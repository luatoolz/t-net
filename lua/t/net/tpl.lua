local t=t or require "t"
local pkg=t.pkg(...)

local join, split, match, byte, mt, is, map, sub, append =
  string.joiner('.'),
  string.splitter('.'),
  t.match,
  t.number.byte,
  t.mt,
  t.is,
  table.map,
  table.sub,
  table.append

local tld, inet_ntoa, inet_aton, computed =
  pkg.tld,
  pkg.inet_ntoa,
  pkg.inet_aton,
  mt.computed

local domain, host, ip, dns = {}, {}, {}, {}
local function minus(i, n)
  if type(n)=='number' and n<0 and type(i)=='number' and i<0 then
    if (n+i)>0 then
      return (n+1)+i
    end
  end
  return i
end
local function pkgn(x, alt) return mt(x).__name or alt or 'unknown' end

local tpl = {
__concat=function(self, it)
  if (not is.ip(self)) and #self>0 then
    if type(it)=='string' and #it>0 then return host(append(sub(self), it, 1)) end
    if type(it)=='table' and #it>0 then
      local rv=sub(self)
      for _,v in ipairs(it) do append(rv, v, 1) end
      return host(rv)
    end
  end
end,
__eq = function(a, b) return tostring(a)==tostring(b) end,
__export = function(self) if #self>0 then return tostring(self) end end,
__index = function(self, k) return rawget(self, minus(k, #self)) or computed(self, k) end,
__tostring = function(self) return #self>0 and string.lower(join(self)) or '' end,
}

local function getnetobject(self, it)
  if type(it)=='nil' or type(it)=='boolean' then return nil end
  if type(it)=='table' then
    if getmetatable(it)==getmetatable(self) then return it end
    if getmetatable(it) then
      it=tostring(it)
    else
      if type(next(it))=='nil' then return nil end
      if #it>0 then it=join(it) end
    end
    if type(it)=='table' then return pkgn(self):error('got non-empty non-array table') end
  end
  if type(it)~='string' then it=tostring(it) end
  if type(it)=='string' then it=string.lower(it) end
  return it
end

setmetatable(domain,{
__call=function(self, it)
  if mt(it)==mt(self) then return it end
  it=getnetobject(self, it)
  it=match.domain(it)
  if type(it)~='string' or #it==0 then return nil end
  local _,n=tld(it, true)
  local rv=split(it)
  if #rv>n then return mt(sub(rv, -n-1), mt(self), true) end
end,
__computable = {
  tld     = function(self) return tld(self) end,
  islocal = function(self) return is.localdomain(self) end,
  ip      = function(self) return self.a end,
  a       = function(self) return dns.a(self) end,
  ns      = function(self) return dns.ns(self) end,
  mx      = function(self) return dns.mx(self) end,
},
__concat = tpl.__concat,
__eq = tpl.__eq,
__export = tpl.__export,
__index = tpl.__index,
__name = 'net/domain',
__tostring = tpl.__tostring,
})

setmetatable(host,{
__call=function(self, it)
  if mt(it)==mt(self) then return it end
  it=getnetobject(self, it)
  return mt(ip(it) or split(match.host(it)), mt(self), true)
end,
__computable = {
  tld     = function(self) return tld(self.domain) end,
  ok      = function(self) return dns end,
  domain  = function(self) return domain(self) end,
  ip      = function(self) return self.a end,
  a       = function(self) return dns.a(self) end,
  ns      = function(self) return dns.ns(self) end,
  mx      = function(self) return dns.mx(self) end,
},
__concat = tpl.__concat,
__eq = tpl.__eq,
__export = tpl.__export,
__index = tpl.__index,
__name = 'net/host',
__tostring = tpl.__tostring,
})

setmetatable(ip, {
__call=function(self, it)
  if getmetatable(it)==getmetatable(self) then return it end
  if type(it)=='number' then it=inet_ntoa(it) end
  if type(it)=='table' and #it==4 and #(map(it, byte) or {})==4 then return setmetatable(it, getmetatable(self)) end
  it=getnetobject(self, it)
  local rv=match.ip(it)
  if type(rv)~='string' or #rv==0 then return pkgn(self):error('empty match') end
  return mt(it:split('.'), getmetatable(self))
end,
__concat = tpl.__concat,
__eq = tpl.__eq,
__export = tpl.__export,
__index = tpl.__index,
__name = 'net/ip',
__tonumber=inet_aton,
__tostring = tpl.__tostring,
})

return {
  domain=domain,
  host=host,
  ip=ip,
  dns=dns,
}