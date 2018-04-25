require 'webrick'
require 'tempfile'

class C < WEBrick::HTTPServlet::AbstractServlet
  # https://ruby-doc.org/stdlib-2.5.0/libdoc/webrick/rdoc/WEBrick/HTTPAuth/DigestAuth.html
  # By default WEBrick creates a new servlet instance
  # for every request and the DigestAuth object must 
  # be used across requests.
  @instance = nil

  def self.get_instance server, *options
    @instance ||= new(server, *options)
  end

  def initialize server
    super server

    config = { :Realm => 'DigestAuth example realm' }

    config[:Realm] = 'net-http-digest_auth'
    config[:UseOpaque] = false
    config[:AutoReloadUserDB] = false

    passwd_file = Tempfile.new 'net-http-digest_auth'
    passwd_file.close

    htpasswd = WEBrick::HTTPAuth::Htpasswd.new passwd_file.path
    htpasswd.auth_type = WEBrick::HTTPAuth::DigestAuth
    htpasswd.set_passwd config[:Realm], 'username', 'good'
    htpasswd.flush

    config[:UserDB] = htpasswd

    @digest_auth = WEBrick::HTTPAuth::DigestAuth.new config
  end

  def do_GET request, response
    @digest_auth.authenticate request, response

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

# Extended by Max Bigras 2018
# Originally from
# https://github.com/drbrain/net-http-digest_auth
# (The MIT License)

# Copyright (c) Eric Hodel

# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# 'Software'), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:

# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.