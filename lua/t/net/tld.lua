local t=t or require "t"
local is=t.is
local has=is.has
local checker=t.checker
local join=string.joiner('.')
local ok=t.checker({
  string=function(x) return x end,
  userdata=function(x) if has.tostring(x) then return tostring(x) end end,
  table=function(x)
    if getmetatable(x) and has.tostring(x) then return tostring(x) end
    if (not getmetatable(x)) and #x>0 then return join(x) end
  end,
},type,checker({
  table=function(x) return x end,
  string=function(x) return x:lower():strip('.'):split('.') end,
},type))

return function(host, need)
  local it=ok(host)
  local rv
  local n=it and #it or 0
  local i
  while n>0 do
    local new=join(table.sub(it, n))
    if is.tld(new) then
      rv=new
      i=(i or 0)+1
    else
      break
    end
    n=n-1
  end
  if need then return rv, i or 1 end
  return rv
end