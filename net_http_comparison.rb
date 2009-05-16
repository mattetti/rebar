require 'client'

erlang = Rebar::Erlang.new(:funs, '127.0.0.1', 5500)

require 'benchmark'
require 'net/http'
require 'uri'

url   = URI.parse 'http://localhost:5984/test/test'
req   = Net::HTTP::Get.new(url.path)
# not reusing the same connection since rest-client doesn't and net/http times out
# http  = Net::HTTP.start(url.host, 5984)

n = 1000
Benchmark.bm(7) do |x|
  x.report("ruby:") { n.times {  http  = Net::HTTP.start(url.host, 5984); http.request(req) } }
  x.report("erlang:") { n.times { erlang.test('this is a test') } }
end