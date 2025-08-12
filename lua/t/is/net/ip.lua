local t=t or require "t"
return function(x) return (t.net.ip(x) or t.match.ip(tostring(x):lower())) and true or nil end