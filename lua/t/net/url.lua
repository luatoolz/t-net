local t=t or require "t"
local pkgn=...
local pkg=t.pkg(pkgn)
local url = require "net.url"
url.options.legal_in_path["+"] = true

local join, mt, match =
  string.joiner(''),
  t.mt,
  t.match

local domain, computed =
  pkg.domain,
  mt.computed

local port = setmetatable({
  https = '443',
  http = '80',
  ['443'] = '443',
  ['80'] = '80',
  [443] = '443',
  [80] = '80',
},{__index = function(self, k) return rawget(self, tostring(k):lower()) end,})

return setmetatable({},{
__call=function(self, it)
  if mt(it)==mt(self) then return it end
  if type(it)~='string' then return nil end
  it=tostring(it):trim():lower():strip("https://", "http://", "//", "www."):null()
  if not match.host(it) then return end
  it=it and url.parse(it:prefix("https://")):normalize()
  return it and mt(it, mt(self), true) or nil
end,
__computable = {
  authority = function(self) return '' end,
  host      = function(self) return self.authority:match("^[^%/]+") end,
  path      = function(self) return self.authority:match("%/.+$") end,
  domain    = function(self) return tostring(domain(self.host)) end,
  scheme    = function(self) return self.authority:null() and 'https' end,
  port      = function(self) return port[self.scheme] end,
  matches   = function(self) return port[self.scheme]==port[self.port] end,
  ascheme   = function(self) return self.scheme and '%s://'%self.scheme end,
  aport     = function(self) return self.matches and '' or (':%s'%self.port) end,
},
__eq = function(a, b) return tostring(a)==tostring(b) end,
__export = function(self) return tostring(self) end,
__index = computed,
__mul = table.__mul,
__mod = table.__mod,
__name = 'net/url',
__tostring = function(self) return join(self.ascheme, self.host, self.aport, self.path) end,
})