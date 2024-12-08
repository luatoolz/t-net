local t = require "t"
local join=string.joiner('.')

local mn = 256 -- 1 byte
local md = mn -- mod divisor
local max = mn^4

local function toint(x)
  if type(x)=='number' then return string.format('%d', x) end
end

return function(n)
  if type(n)=='number' and n>=0 and n<max then
    local d = math.floor(n % md)
    n = math.floor(n / mn)
    local c = math.floor(n % md)
    n = math.floor(n / mn)
    local b = math.floor(n % md)
    n = math.floor(n / mn)
    local a = math.floor(n % md)
    return join{toint(a), toint(b), toint(c), toint(d)}
  end
end