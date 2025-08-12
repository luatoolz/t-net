local t=require 't'
local number, mt, iter, match = t.number,
  t.mt,
  t.iter,
  t.match

local proto = t.set('socks','socks4','socks5','socks5a','socks5h','http','https')

return setmetatable({},{
__call=function(self, ...)
  local it = ...
  local new
  if mt(it)==mt(self) then return it end
  if type(it)=='table' then
    if mt(it).__tostring then it=tostring(it) end
  end
  if type(it)=='string' then
    it = it:lower():split(':','/')
    new = true
  end
  if type(it)~='table' or (type(it)=='table' and getmetatable(it)) or #it~=3 then
    return nil
  elseif not new then
    local rv={}
    for v in iter.ivalues(it) do table.insert(rv, v) end
    it=rv
  end

  local scheme, ip, port = table.unpack(it)
  if proto[scheme] and match.ip(tostring(ip)) and number.integer(port) then
    return mt(it, mt(self), true)
  end
end,
__computable = {
  ok      = function(self) return #self==3 end,
  scheme  = function(self) return self[1] end,
  ip      = function(self) return self[2] end,
  port    = function(self) return self[3] end,
},
__eq = function(a, b) return tostring(a)==tostring(b) end,
__export = function(self) return tostring(self) end,
__index = mt.computed,
__mul = table.map,
__mod = table.filter,
__name = 'net/proxy',
__tostring = function(self) return '%s://%s:%d' ^ {self[1],self[2],self[3]} end,
})