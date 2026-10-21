// gomux - Go edge multiplexer for hotscript (ports 80 and 443).
// Replaces the old HAProxy + Nginx edge stack.
//
//   :80   raw SSH            -> 22
//         HTTP payload       -> router (below)
//   :443  raw SSH            -> 22
//         plain HTTP         -> router
//         TLS (any SNI)      -> TLS terminate -> SSH- -> 22, else router
//
//   router (HTTP payload):
//         "<METHOD> /vless[...]"  -> 127.0.0.1:14016   (Xray VLESS ws, request forwarded untouched)
//         "<METHOD> /<port>/..."  -> 127.0.0.1:<port>   (request path is rewritten to "/")
//         anything else           -> WS-Dropbear (127.0.0.1:700, request forwarded untouched)
//
// Build:  go mod init gomux && go build -ldflags "-s -w" -o gomux .
// Test on other ports:  ./gomux -http :9080 -tls :9443
// Normal run uses the defaults (:80 / :443).

package main

import (
	"bufio"
	"bytes"
	"crypto/tls"
	"errors"
	"flag"
	"io"
	"log"
	"net"
	"os"
	"strconv"
	"sync"
	"time"
)

var (
	sshAddr   = "127.0.0.1:22"
	vlessAddr = "127.0.0.1:14016" // Xray VLESS (ws, path /vless)
	wsAddr    = "127.0.0.1:700"   // WS-Dropbear: default route for everything else
	tlsCfg    *tls.Config
)

// ---------------------------------------------------------------- helpers

// bconn: a connection whose first bytes can be peeked without being lost.
type bconn struct {
	net.Conn
	r *bufio.Reader
}

func newB(c net.Conn) *bconn { return &bconn{Conn: c, r: bufio.NewReaderSize(c, 16384)} }

func (b *bconn) Read(p []byte) (int, error) { return b.r.Read(p) }

func isTimeout(err error) bool {
	var ne net.Error
	return errors.As(err, &ne) && ne.Timeout()
}

type kind int

const (
	kUnknown kind = iota // nothing arrived within 2s
	kTLS
	kSSH
	kHTTP // anything else (first line / first packet in data)
)

// classify peeks at the first bytes (waits up to 2s for the client).
func classify(b *bconn, allowTLS bool) (kind, []byte, error) {
	b.SetReadDeadline(time.Now().Add(2 * time.Second))
	defer b.SetReadDeadline(time.Time{})

	first, err := b.r.Peek(1)
	if err != nil {
		if isTimeout(err) {
			return kUnknown, nil, nil
		}
		return kUnknown, nil, err
	}
	if allowTLS && first[0] == 0x16 {
		return kTLS, nil, nil
	}
	head, _ := b.r.Peek(7)
	if string(head) == "SSH-2.0" {
		return kSSH, nil, nil
	}
	// wait for the end of the first line (or timeout / 8 KB)
	for {
		n := b.r.Buffered()
		data, _ := b.r.Peek(n)
		if bytes.IndexByte(data, '\n') >= 0 || n >= 8192 {
			return kHTTP, data, nil
		}
		if _, err := b.r.Peek(n + 1); err != nil {
			return kHTTP, data, nil
		}
	}
}

// ---------------------------------------------------------------- certificate
// The certificate files are re-checked every 30s, so a renewal needs no restart.

type certStore struct {
	mu        sync.Mutex
	crt, key  string
	cert      *tls.Certificate
	mtime     time.Time
	lastCheck time.Time
}

func (s *certStore) load() error {
	st, err := os.Stat(s.crt)
	if err != nil {
		return err
	}
	c, err := tls.LoadX509KeyPair(s.crt, s.key)
	if err != nil {
		return err
	}
	s.cert, s.mtime = &c, st.ModTime()
	return nil
}

// get is used as tls.Config.GetCertificate (same certificate for any SNI).
func (s *certStore) get(*tls.ClientHelloInfo) (*tls.Certificate, error) {
	s.mu.Lock()
	defer s.mu.Unlock()
	if time.Since(s.lastCheck) > 30*time.Second {
		s.lastCheck = time.Now()
		if st, err := os.Stat(s.crt); err == nil && !st.ModTime().Equal(s.mtime) {
			if err := s.load(); err != nil {
				log.Println("cert reload:", err) // keep serving the old one
			} else {
				log.Println("cert reloaded")
			}
		}
	}
	return s.cert, nil
}

// ---------------------------------------------------------------- relay

func pipe(c, d net.Conn) {
	done := make(chan struct{}, 2)
	go func() { io.Copy(d, c); done <- struct{}{} }()
	go func() { io.Copy(c, d); done <- struct{}{} }()
	<-done
	c.Close()
	d.Close()
}

func relay(c net.Conn, addr string) {
	d, err := net.DialTimeout("tcp", addr, 5*time.Second)
	if err != nil {
		log.Println("dial", addr, err)
		c.Close()
		return
	}
	pipe(c, d)
}

// fwdTarget looks at the first request line, e.g. "GET /700/anything?x=1 HTTP/1.1".
// If the path starts with /<port>/ it returns the port, the length of the original
// line and the rewritten line ("GET /?x=1 HTTP/1.1"), like the old Nginx forwarder.
func fwdTarget(data []byte) (port int, lineLen int, newLine []byte, ok bool) {
	nl := bytes.IndexByte(data, '\n')
	if nl < 0 {
		return
	}
	line := data[:nl+1]
	eol := []byte("\n")
	if nl > 0 && data[nl-1] == '\r' {
		eol = []byte("\r\n")
	}
	f := bytes.Fields(bytes.TrimRight(line, "\r\n"))
	if len(f) != 3 {
		return
	}
	uri := f[1]
	if len(uri) < 3 || uri[0] != '/' {
		return
	}
	i := 1
	for i < len(uri) && uri[i] >= '0' && uri[i] <= '9' {
		i++
	}
	if i == 1 || i >= len(uri) || uri[i] != '/' {
		return
	}
	p, err := strconv.Atoi(string(uri[1:i]))
	if err != nil || p < 1 || p > 65535 {
		return
	}
	rest := uri[i+1:]
	newURI := []byte("/")
	if q := bytes.IndexByte(rest, '?'); q >= 0 {
		newURI = append(newURI, rest[q:]...)
	}
	var out []byte
	out = append(out, f[0]...)
	out = append(out, ' ')
	out = append(out, newURI...)
	out = append(out, ' ')
	out = append(out, f[2]...)
	out = append(out, eol...)
	return p, len(line), out, true
}

// isVless reports whether the first request line targets the VLESS websocket path
// (/vless, /vless?x=1 or /vless/...). The request is forwarded to Xray untouched.
func isVless(data []byte) bool {
	nl := bytes.IndexByte(data, '\n')
	if nl < 0 {
		nl = len(data)
	}
	f := bytes.Fields(bytes.TrimRight(data[:nl], "\r\n"))
	if len(f) != 3 {
		return false
	}
	uri := f[1]
	if !bytes.HasPrefix(uri, []byte("/vless")) {
		return false
	}
	if len(uri) == 6 {
		return true
	}
	return uri[6] == '?' || uri[6] == '/'
}

func reply503(c net.Conn) {
	c.Write([]byte("HTTP/1.1 503 Service Unavailable\r\nContent-Length: 0\r\nConnection: close\r\n\r\n"))
	c.Close()
}

// router decides where a connection goes.
func router(b *bconn, k kind, data []byte) {
	switch k {
	case kSSH, kUnknown:
		// raw SSH, or a silent client that waits for the SSH banner
		relay(b, sshAddr)
	case kHTTP:
		if isVless(data) {
			d, err := net.DialTimeout("tcp", vlessAddr, 5*time.Second)
			if err != nil {
				log.Println("dial", vlessAddr, err)
				reply503(b)
				return
			}
			pipe(b, d)
			return
		}
		port, lineLen, newLine, ok := fwdTarget(data)
		if !ok {
			// default route: payloads without /<port>/ or /vless go to WS-Dropbear untouched
			d, err := net.DialTimeout("tcp", wsAddr, 5*time.Second)
			if err != nil {
				log.Println("dial", wsAddr, err)
				reply503(b)
				return
			}
			pipe(b, d)
			return
		}
		addr := "127.0.0.1:" + strconv.Itoa(port)
		d, err := net.DialTimeout("tcp", addr, 5*time.Second)
		if err != nil {
			log.Println("dial", addr, err)
			reply503(b)
			return
		}
		b.r.Discard(lineLen)
		if _, err := d.Write(newLine); err != nil {
			d.Close()
			b.Close()
			return
		}
		pipe(b, d)
	default:
		b.Close()
	}
}

// ---------------------------------------------------------------- entry points

func handle80(c net.Conn) {
	b := newB(c)
	k, data, err := classify(b, false)
	if err != nil {
		c.Close()
		return
	}
	router(b, k, data)
}

func handle443(c net.Conn) {
	b := newB(c)
	k, data, err := classify(b, true)
	if err != nil {
		c.Close()
		return
	}
	if k == kTLS {
		handleTLS(b)
		return
	}
	router(b, k, data)
}

// handleTLS terminates TLS (any SNI), then classifies the decrypted stream again.
func handleTLS(b *bconn) {
	tc := tls.Server(b, tlsCfg)
	tc.SetDeadline(time.Now().Add(10 * time.Second))
	if err := tc.Handshake(); err != nil {
		tc.Close()
		return
	}
	tc.SetDeadline(time.Time{})

	nb := newB(tc)
	k, data, err := classify(nb, false)
	if err != nil {
		tc.Close()
		return
	}
	router(nb, k, data)
}

func listen(addr string, h func(net.Conn)) {
	ln, err := net.Listen("tcp", addr)
	if err != nil {
		log.Fatal(err)
	}
	log.Println("listening on", addr)
	for {
		c, err := ln.Accept()
		if err != nil {
			log.Println(err)
			time.Sleep(100 * time.Millisecond)
			continue
		}
		go h(c)
	}
}

func main() {
	httpAddr := flag.String("http", ":80", "cleartext listen address")
	tlsAddr := flag.String("tls", ":443", "TLS listen address")
	certFile := flag.String("cert", "/etc/firewallfalcon/ssl/firewallfalcon.crt", "TLS certificate (full chain)")
	keyFile := flag.String("key", "/etc/firewallfalcon/ssl/firewallfalcon.key", "TLS private key")
	flag.StringVar(&sshAddr, "ssh", sshAddr, "OpenSSH target")
	flag.StringVar(&wsAddr, "ws", wsAddr, "default route target (WS-Dropbear)")
	flag.Parse()

	store := &certStore{crt: *certFile, key: *keyFile}
	if err := store.load(); err != nil {
		log.Fatal("cert: ", err)
	}
	store.lastCheck = time.Now()
	tlsCfg = &tls.Config{
		GetCertificate: store.get,
		MinVersion:     tls.VersionTLS12,
	}

	go listen(*httpAddr, handle80)
	listen(*tlsAddr, handle443)
}
