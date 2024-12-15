local t=t or require "t"
local is=t.is
return function(x) return (is.net.domain(x) or t.match.domain(tostring(x):lower())) and true or nil end