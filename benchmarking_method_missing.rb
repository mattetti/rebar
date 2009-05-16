require 'client'

module Rebar
  class Erlang
    def method_missing(*args)
      method, *params = args
      def_missing_method(method)
      rpc(method, params)
    end
    
    def def_missing_method(method_name)
      # p "method #{method_name} called via method missing is now being defined"
      Erlang.class_eval "def #{method_name}(*args); rpc(#{method_name.inspect}, args) ;end"
    end
  end
end

erlang = Rebar::Erlang.new(:funs, '127.0.0.1', 5500)

require 'benchmark'
require 'net/http'
require 'uri'

n = 1000
Benchmark.bm(7) do |x|
   x.report("erlang:") { n.times { erlang.test('this is a test') } }
end

# res = [1.123659, 1.040658, 1.189246, 1.040673, 1.052533]
# meth_missing_average = res.inject(0){|sum, n| sum+n} / res.length
# p "method missing: #{meth_missing_average}"
# 
# res = [1.411776, 1.190651, 1.131445, 1.518396, 1.411938]
# compiled_average = res.inject(0){|sum, n| sum+n} / res.length
# p "compiled method missing: #{compiled_average}"
# 
# p "compiled average is #{compiled_average/meth_missing_average} times slower :("