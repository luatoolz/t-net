local t = require "t"
local idn = t.matchu.idn
local idn2 = require 'idn2'
return function(x) x=tostring(x); return (idn(x) or idn(idn2.to_ascii(x))) and true or nil end