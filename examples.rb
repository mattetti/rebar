require 'client'

erlang = Rebar::Erlang.new(:funs, '127.0.0.1', 5500)

ans = erlang.add(1, 2)
puts "1 + 2 = #{ans}"

ans = erlang.cat("foo", "bar")
puts "foobar = #{ans}"

ans = erlang.fac(10)
puts "fac(10) = #{ans}"