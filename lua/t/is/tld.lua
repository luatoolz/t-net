local psl=require "public_suffix_list"
local t=t or require "t"
local is=t.is
local has=is.has
local checker=t.checker
local join=string.joiner('.')
local ok=checker({
  string=function(x) return x end,
  userdata=function(x) if has.tostring(x) then return tostring(x) end end,
  table=function(x)
    if getmetatable(x) and has.tostring(x) then return tostring(x) end
    if (not getmetatable(x)) and #x>0 then return join(x) end
  end,
},type,checker({
  string=function(x) return x:lower():strip('.') or '' end,
},type,psl.exists))
return function(host) return ok(host) end