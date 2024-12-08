local t=t or require "t"
local is=t.is
local host=t.net.host
return function(d) return is.like(host, host(d)) end