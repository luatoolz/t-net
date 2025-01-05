local t=require "t"
local to, mt, match =
  t.to,
  t.mt,
  t.match

local proto = t.set('socks','socks4','socks5','socks5h','http','https')

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
    for v in table.ivalues(it) do table.insert(rv, v) end
    it=rv
  end
  local scheme, ip, port = table.unpack(it)
  if proto[scheme] and match.ip(ip) and to.integer(port) then
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
__mul = table.__mul,
__mod = table.__mod,
__name = 'net/proxy',
__tostring = function(self) return '%s://%s:%s' % self end,
})