local t=require 't'
local tonum=function(x) return tonumber(x, 10) end
local byte=t.number.byte
local array=t.array
local pak=table.pack
local pat="(%d+)%.(%d+)%.(%d+)%.(%d+)"
local mn = 256 -- 1 byte

return function(x)
  x=tostring(x)
  local nums=array(pak(string.match(x, pat)))*tonum*byte
  if #nums~=4 then return nil end
  local n=0
  for _,it in ipairs(nums) do n=(n*mn)+it end
  return n
end