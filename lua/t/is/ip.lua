local t=t or require "t"
local is=t.is
return function(x) return (is.net.ip(x) or t.match.ip(tostring(x):lower())) and true or nil end