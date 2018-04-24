# HTTP Exploration

> Exploring HTTP servers and clients with Ruby

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
