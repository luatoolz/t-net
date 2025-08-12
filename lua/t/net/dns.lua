local t=require 't'
local is=t.is
local pkgn=...
local pkg=t.pkg(pkgn)
local tpl=pkg.tpl
local Resolver, Parser =
  require 'dns.resolver',
  require 'dns.parser'
local recordTypes = Parser.recordTypes
local save = table.save
local nulled = table.nulled
local number = t.number
local env = t.env

env({
  NS = '1.1.1.1,1.0.0.1',
  NS_TIMEOUT = 5,
})

local ns = env.NS:split(',', ' ', ';')

local host, ip, dns =
  tpl.host,
  tpl.ip,
  tpl.dns

local result = {
  A = ip,
  NS = host,
  MX = host,
  CNAME = host,
  PTR = host,
}
local queryf = {
  PTR = function(x) if is.net.ip(x) then
    return host('in-addr.arpa')..ip(x) end
    return host(x) end,
}

local r=Resolver.new(ns, number.integer(env.NS_TIMEOUT))
return setmetatable(dns, {
__call=function(self, it, k) if it and k then
  k=k and self[k]
  if not k then return pkgn:error('bad dns query type') end
  return k(it)
end end,
__index=function(this, k)
  k=k and type(k)=='string' and recordTypes[string.upper(k)]
  k=k and type(k)=='number' and recordTypes[k]
  if not k then print('fail', k); return nil end
  local query = queryf[k] or host
return rawget(this, k) or save(this, k, function(x)
  local id=k
  x=query(x)
  if (not x) or (id=='A' and #x==1) then return nil, 'invalid argument' end
  x=tostring(x)
  local rec,e = r:resolve(x, id)
  if not rec then return nil, e end
  return nulled(t.array(rec)*function(v)
    if v.type~=id and v.type=='SOA' then return nil end
    local f=result[v.type]; if f then return f(v.content) else return v.content end end)
end) end,
__name = 'net/dns',
})