# HTTP Exploration

> Exploring HTTP servers and clients with Ruby

## Sections

* [HTTP server](#http-server)
* [HTTP server with Basic Authentication](#http-server-with-basic-authentication)
* [HTTP server with Digest Authentication](#http-server-with-digest-authentication)

## HTTP server

```
ruby http_server.rb
[2018-04-24 12:42:50] INFO  WEBrick 1.3.1
[2018-04-24 12:42:50] INFO  ruby 2.4.2 (2017-09-14) [x86_64-darwin16]
[2018-04-24 12:42:50] INFO  WEBrick::HTTPServer#start: pid=26526 port=8000
doing stuff with request...
::1 - - [24/Apr/2018:12:42:53 PDT] "GET / HTTP/1.1" 200 13
- -> /
```

```
ruby http_client.rb
opening connection to localhost:8000...
opened
<- "GET / HTTP/1.1\r\nAccept-Encoding: gzip;q=1.0,deflate;q=0.6,identity;q=0.3\r\nAccept: */*\r\nUser-Agent: Ruby\r\nConnection: close\r\nHost: localhost:8000\r\n\r\n"
-> "HTTP/1.1 200 OK \r\n"
-> "Content-Type: text/plain\r\n"
-> "Server: WEBrick/1.3.1 (Ruby/2.4.2/2017-09-14)\r\n"
-> "Date: Tue, 24 Apr 2018 19:42:53 GMT\r\n"
-> "Content-Length: 13\r\n"
-> "Connection: close\r\n"
-> "\r\n"
reading 13 bytes...
-> ""
-> "hello world!\n"
read 13 bytes
Conn close
```

## HTTP server with Basic Authentication

```
ruby http_basic_server.rb
[2018-04-24 13:09:14] INFO  WEBrick 1.3.1
[2018-04-24 13:09:14] INFO  ruby 2.4.2 (2017-09-14) [x86_64-darwin16]
[2018-04-24 13:09:14] INFO  WEBrick::HTTPServer#start: pid=27399 port=8000
[2018-04-24 13:09:18] ERROR Basic BasicAuth example realm: username: password unmatch.
[2018-04-24 13:09:18] ERROR WEBrick::HTTPStatus::Unauthorized
::1 - - [24/Apr/2018:13:09:18 PDT] "GET / HTTP/1.1" 401 295
- -> /
[2018-04-24 13:09:21] INFO  Basic BasicAuth example realm: username: authentication succeeded.
doing stuff with request...
::1 - username [24/Apr/2018:13:09:21 PDT] "GET / HTTP/1.1" 200 13
- -> /
```

```
ruby http_basic_client.rb -u username:bad
opening connection to localhost:8000...
opened
<- "GET / HTTP/1.1\r\nAccept-Encoding: gzip;q=1.0,deflate;q=0.6,identity;q=0.3\r\nAccept: */*\r\nUser-Agent: Ruby\r\nAuthorization: Basic dXNlcm5hbWU6YmFk\r\nConnection: close\r\nHost: localhost:8000\r\n\r\n"
-> "HTTP/1.1 401 Unauthorized \r\n"
-> "WWW-Authenticate: Basic realm=\"BasicAuth example realm\"\r\n"
-> "Content-Type: text/html; charset=ISO-8859-1\r\n"
-> "Server: WEBrick/1.3.1 (Ruby/2.4.2/2017-09-14)\r\n"
-> "Date: Tue, 24 Apr 2018 20:09:18 GMT\r\n"
-> "Content-Length: 295\r\n"
-> "Connection: close\r\n"
-> "\r\n"
reading 295 bytes...
-> "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\">\n<HTML>\n  <HEAD><TITLE>Unauthorized</TITLE></HEAD>\n  <BODY>\n    <H1>Unauthorized</H1>\n    WEBrick::HTTPStatus::Unauthorized\n    <HR>\n    <ADDRESS>\n     WEBrick/1.3.1 (Ruby/2.4.2/2017-09-14) at\n     localhost:8000\n    </ADDRESS>\n  </BODY>\n</HTML>\n"
read 295 bytes
Conn close

ruby http_basic_client.rb -u username:good
opening connection to localhost:8000...
opened
<- "GET / HTTP/1.1\r\nAccept-Encoding: gzip;q=1.0,deflate;q=0.6,identity;q=0.3\r\nAccept: */*\r\nUser-Agent: Ruby\r\nAuthorization: Basic dXNlcm5hbWU6Z29vZA==\r\nConnection: close\r\nHost: localhost:8000\r\n\r\n"
-> "HTTP/1.1 200 OK \r\n"
-> "Content-Type: text/plain\r\n"
-> "Server: WEBrick/1.3.1 (Ruby/2.4.2/2017-09-14)\r\n"
-> "Date: Tue, 24 Apr 2018 20:09:21 GMT\r\n"
-> "Content-Length: 13\r\n"
-> "Connection: close\r\n"
-> "\r\n"
reading 13 bytes...
-> "hello world!\n"
read 13 bytes
Conn close
```

## HTTP server with Digest Authentication

```
ruby http_digest_server.rb
[2018-04-25 09:47:56] INFO  WEBrick 1.3.1
[2018-04-25 09:47:56] INFO  ruby 2.4.2 (2017-09-14) [x86_64-darwin16]
[2018-04-25 09:47:56] INFO  WEBrick::HTTPServer#start: pid=38728 port=8000
[2018-04-25 09:48:01] ERROR Digest net-http-digest_auth: no credentials in the request.
[2018-04-25 09:48:01] ERROR WEBrick::HTTPStatus::Unauthorized
[2018-04-25 09:48:01] ERROR Digest net-http-digest_auth: username: digest unmatch.
[2018-04-25 09:48:01] ERROR WEBrick::HTTPStatus::Unauthorized
::1 - - [25/Apr/2018:09:48:01 PDT] "GET / HTTP/1.1" 401 295
::1 - - [25/Apr/2018:09:48:01 PDT] "GET / HTTP/1.1" 401 295
- -> /
- -> /
[2018-04-25 09:48:06] ERROR Digest net-http-digest_auth: no credentials in the request.
[2018-04-25 09:48:06] ERROR WEBrick::HTTPStatus::Unauthorized
::1 - - [25/Apr/2018:09:48:06 PDT] "GET / HTTP/1.1" 401 295
- -> /
[2018-04-25 09:48:06] INFO  Digest net-http-digest_auth: username: authentication succeeded.
doing stuff with request...
::1 - username [25/Apr/2018:09:48:06 PDT] "GET / HTTP/1.1" 200 13
- -> /
```

```
ruby http_digest_client.rb -u username:bad
opening connection to localhost:8000...
opened
<- "GET / HTTP/1.1\r\nAccept-Encoding: gzip;q=1.0,deflate;q=0.6,identity;q=0.3\r\nAccept: */*\r\nUser-Agent: Ruby\r\nConnection: close\r\nHost: localhost:8000\r\n\r\n"
-> "HTTP/1.1 401 Unauthorized \r\n"
-> "WWW-Authenticate: Digest realm=\"net-http-digest_auth\", nonce=\"MDAxNTI0Njc0ODgxOmFiY2RhMzJkZGNkMjY0NmUwZDg0MGQzMGUxMzQ1ZDNl\", stale=false, algorithm=MD5-sess, qop=\"auth\"\r\n"
-> "Content-Type: text/html; charset=ISO-8859-1\r\n"
-> "Server: WEBrick/1.3.1 (Ruby/2.4.2/2017-09-14)\r\n"
-> "Date: Wed, 25 Apr 2018 16:48:01 GMT\r\n"
-> "Content-Length: 295\r\n"
-> "Connection: close\r\n"
-> "\r\n"
reading 295 bytes...
-> "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\">\n<HTML>\n  <HEAD><TITLE>Unauthorized</TITLE></HEAD>\n  <BODY>\n    <H1>Unauthorized</H1>\n    WEBrick::HTTPStatus::Unauthorized\n    <HR>\n    <ADDRESS>\n     WEBrick/1.3.1 (Ruby/2.4.2/2017-09-14) at\n     localhost:8000\n    </ADDRESS>\n  </BODY>\n</HTML>\n"
read 295 bytes
Conn close
opening connection to localhost:8000...
opened
<- "GET / HTTP/1.1\r\nAccept-Encoding: gzip;q=1.0,deflate;q=0.6,identity;q=0.3\r\nAccept: */*\r\nUser-Agent: Ruby\r\nAuthorization: Digest username=\"username\", realm=\"net-http-digest_auth\", algorithm=MD5-sess, qop=auth, uri=\"/\", nonce=\"MDAxNTI0Njc0ODgxOmFiY2RhMzJkZGNkMjY0NmUwZDg0MGQzMGUxMzQ1ZDNl\", nc=00000000, cnonce=\"72978a6b5b42fce3069636755acef793\", response=\"a2f3609f1ef359c17b0870ff93f39826\"\r\nConnection: close\r\nHost: localhost:8000\r\n\r\n"
-> "HTTP/1.1 401 Unauthorized \r\n"
-> "WWW-Authenticate: Digest realm=\"net-http-digest_auth\", nonce=\"MDAxNTI0Njc0ODgxOmFiY2RhMzJkZGNkMjY0NmUwZDg0MGQzMGUxMzQ1ZDNl\", stale=false, algorithm=MD5-sess, qop=\"auth\"\r\n"
-> "Content-Type: text/html; charset=ISO-8859-1\r\n"
-> "Server: WEBrick/1.3.1 (Ruby/2.4.2/2017-09-14)\r\n"
-> "Date: Wed, 25 Apr 2018 16:48:01 GMT\r\n"
-> "Content-Length: 295\r\n"
-> "Connection: close\r\n"
-> "\r\n"
reading 295 bytes...
-> ""
-> "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\">\n<HTML>\n  <HEAD><TITLE>Unauthorized</TITLE></HEAD>\n  <BODY>\n    <H1>Unauthorized</H1>\n    WEBrick::HTTPStatus::Unauthorized\n    <HR>\n    <ADDRESS>\n     WEBrick/1.3.1 (Ruby/2.4.2/2017-09-14) at\n     localhost:8000\n    </ADDRESS>\n  </BODY>\n</HTML>\n"
read 295 bytes
Conn close

ruby http_digest_client.rb -u username:good
opening connection to localhost:8000...
opened
<- "GET / HTTP/1.1\r\nAccept-Encoding: gzip;q=1.0,deflate;q=0.6,identity;q=0.3\r\nAccept: */*\r\nUser-Agent: Ruby\r\nConnection: close\r\nHost: localhost:8000\r\n\r\n"
-> "HTTP/1.1 401 Unauthorized \r\n"
-> "WWW-Authenticate: Digest realm=\"net-http-digest_auth\", nonce=\"MDAxNTI0Njc0ODg2OmUzNzFiNDRmYWU1YTJmZDY2ZjI2YTljYjdkNDg4Nzk3\", stale=false, algorithm=MD5-sess, qop=\"auth\"\r\n"
-> "Content-Type: text/html; charset=ISO-8859-1\r\n"
-> "Server: WEBrick/1.3.1 (Ruby/2.4.2/2017-09-14)\r\n"
-> "Date: Wed, 25 Apr 2018 16:48:06 GMT\r\n"
-> "Content-Length: 295\r\n"
-> "Connection: close\r\n"
-> "\r\n"
reading 295 bytes...
-> ""
-> "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\">\n<HTML>\n  <HEAD><TITLE>Unauthorized</TITLE></HEAD>\n  <BODY>\n    <H1>Unauthorized</H1>\n    WEBrick::HTTPStatus::Unauthorized\n    <HR>\n    <ADDRESS>\n     WEBrick/1.3.1 (Ruby/2.4.2/2017-09-14) at\n     localhost:8000\n    </ADDRESS>\n  </BODY>\n</HTML>\n"
read 295 bytes
Conn close
opening connection to localhost:8000...
opened
<- "GET / HTTP/1.1\r\nAccept-Encoding: gzip;q=1.0,deflate;q=0.6,identity;q=0.3\r\nAccept: */*\r\nUser-Agent: Ruby\r\nAuthorization: Digest username=\"username\", realm=\"net-http-digest_auth\", algorithm=MD5-sess, qop=auth, uri=\"/\", nonce=\"MDAxNTI0Njc0ODg2OmUzNzFiNDRmYWU1YTJmZDY2ZjI2YTljYjdkNDg4Nzk3\", nc=00000000, cnonce=\"4f05e050a56748b4f1eefd588ba647a6\", response=\"10b04bdf3be8e4c812810f22bb22e7c9\"\r\nConnection: close\r\nHost: localhost:8000\r\n\r\n"
-> "HTTP/1.1 200 OK \r\n"
-> "Authentication-Info: nextnonce=\"MDAxNTI0Njc0ODg2OmUzNzFiNDRmYWU1YTJmZDY2ZjI2YTljYjdkNDg4Nzk3\", rspauth=\"62d571e60d66c80eb4729cf363368ad4\", qop=\"auth\", cnonce=\"4f05e050a56748b4f1eefd588ba647a6\", nc=00000000\r\n"
-> "Content-Type: text/plain\r\n"
-> "Server: WEBrick/1.3.1 (Ruby/2.4.2/2017-09-14)\r\n"
-> "Date: Wed, 25 Apr 2018 16:48:06 GMT\r\n"
-> "Content-Length: 13\r\n"
-> "Connection: close\r\n"
-> "\r\n"
reading 13 bytes...
-> ""
-> "hello world!\n"
read 13 bytes
Conn close
```