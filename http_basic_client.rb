require 'net/http'
require 'optparse'
require 'uri'

options = {}
OptionParser.new do |opts|
  opts.on('-u USER:PASSWORD') do |s|
    options[:user], options[:password] = s.split ':'
  end
end.parse!

uri = URI.parse 'http://localhost:8000/'
http = Net::HTTP.new uri.host, uri.port
http.set_debug_output STDERR
req = Net::HTTP::Get.new uri.request_uri
req.basic_auth options[:user], options[:password]

res = http.request req
