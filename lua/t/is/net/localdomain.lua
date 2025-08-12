local t=require 't'
local domain=t.net.domain
local tld=t.net.tld
return function(d) if type(d)=='string' or type(d)=='table' then
  d=d and domain(d)
  return d and ((not tld(d)) and true or nil)
end return nil end