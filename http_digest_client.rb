require 'net/http'
require 'net/http/digest_auth'
require 'optparse'
require 'uri'

options = {}
OptionParser.new do |opts|
  opts.on('-u USER:PASSWORD') do |s|
    options[:user], options[:password] = s.split ':'
  end
end.parse!

uri = URI.parse 'http://localhost:8000/'
uri.user = options[:user]
uri.password = options[:password]

class DigestClient

  def get uri, headers: {}
    request :get, uri, headers
  end

  private

  def request verb, uri, headers={}, opts={}
    h = Net::HTTP.new uri.host, uri.port
    h.set_debug_output $stderr

    klass = Object.const_get "Net::HTTP::#{verb.to_s.capitalize}"

    req = klass.new uri.request_uri
    headers.each do |k, v|
      req.add_field k, v
    end

    res = h.request req

    case res.code
    when '401'
      if opts[:already_tried?]
        res
      else
        digest_auth = Net::HTTP::DigestAuth.new
        auth = digest_auth.auth_header uri, res['www-authenticate'], verb.to_s.upcase
        auth_header = { 'Authorization' => auth }
        opts[:already_tried?] = true
        request verb, uri, auth_header, opts
      end
    else
      res
    end
  end
end

res = DigestClient.new.get uri
