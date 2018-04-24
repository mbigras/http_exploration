require 'webrick'
require 'tempfile'

class C < WEBrick::HTTPServlet::AbstractServlet
  def initialize server
    super server

    passwd_file = Tempfile.new 'my_password_file'
    passwd_file.close

    config = { :Realm => 'BasicAuth example realm' }

    htpasswd = WEBrick::HTTPAuth::Htpasswd.new passwd_file.path
    htpasswd.set_passwd config[:Realm], 'username', 'good'
    htpasswd.flush

    config[:UserDB] = htpasswd

    @basic_auth = WEBrick::HTTPAuth::BasicAuth.new config
  end

  def do_GET request, response
    @basic_auth.authenticate request, response

    do_stuff_with request

    response.status = 200
    response['Content-Type'] = 'text/plain'
    response.body = "hello world!\n"
  end

  private

  def do_stuff_with request
    puts "doing stuff with request..."
  end
end

server = WEBrick::HTTPServer.new :Port => 8000

trap 'INT' do
  server.shutdown
end

server.mount '/', C

server.start