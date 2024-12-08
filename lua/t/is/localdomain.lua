local t=t or require "t"
local domain=t.net.domain
local tld=t.net.tld
return function(d)
  d=d and domain(d)
  return d and (not tld(d))
end