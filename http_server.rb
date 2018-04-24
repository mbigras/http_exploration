require 'webrick'

class C < WEBrick::HTTPServlet::AbstractServlet
  def do_GET request, response
    status, content_type, body = do_stuff_with request

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