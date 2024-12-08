local t=t or require "t"
local is=t.is
--local host=t.net.ip
return function(x) return (is.net.ip(x) or t.match.ip(tostring(x):lower())) and true or nil end
--is.like(host, host(d)) end