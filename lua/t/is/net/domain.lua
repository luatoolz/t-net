local t=require 't'
return function(x) return (x and t.net.domain(x) or t.match.domain(tostring(x):lower())) and true or nil end