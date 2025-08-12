local t=require 't'
local is=t.is
local host=t.net.hostname
return function(d) return is.like(host, host(d)) end