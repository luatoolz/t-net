local t=require 't'
local tonum=function(x) return tonumber(x, 10) end
local byte=t.number.byte
local array=t.array
local pak=table.pack or pack
local unpak=table.unpack or unpack
local pat='(%d+)%.(%d+)%.(%d+)%.(%d+)/(%d+)%.?(%d*)%.?(%d*)%.?(%d*)'
local ok={[5]='%d.%d.%d.%d/%d',[8]='%d.%d.%d.%d/%d.%d.%d.%d'}
return function(x)
  x=tostring(x)
  local nums=array(pak(string.match(x, pat)))*string.null
  local len=#nums
  nums=nums*tonum*byte
  if #nums~=len or not ok[len] then return nil end
  return string.format(ok[len], unpak(nums))
end