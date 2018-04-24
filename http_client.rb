require 'net/http'
require 'uri'

uri = URI.parse 'http://localhost:8000/'
http = Net::HTTP.new uri.host, uri.port
http.set_debug_output STDERR
req = Net::HTTP::Get.new uri.request_uri

res = http.request req
