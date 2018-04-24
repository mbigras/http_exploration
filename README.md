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