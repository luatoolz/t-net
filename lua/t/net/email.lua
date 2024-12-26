local t=require "t"
local mt, match =
  t.mt,
  t.matchu

return setmetatable({},{
__call=function(self, ...)
  local it = ...
  if type(it)=='table' then
    if mt(it)==mt(self) then return it end
    if not getmetatable(it) then
      local login, domain, name = it.login, it.domain, it.name
      if type(login)=='string' and type(domain)=='string' then
        login = login:lower():null()
        domain = domain:lower():null()
        if type(name)=='string' then name = name:lower():null() end
        it=nil
        if login and domain then
          it = {login=login, domain=domain, name=name}
        end
      else return nil end
    elseif mt(it).__tostring then it=tostring(it) else
      return nil
    end
  end
  if type(it)=='string' then
    it=it:lower()
    local login, domain = match.emaillogin(it), match.emaildomain(it)
    it=nil
    if login and domain then
      it = {login=login, domain=domain}
    end
  end

  if type(it)=='table' and it.login and it.domain then
    return mt(it, mt(self), true)
  end
  return nil
end,
__eq = function(a, b) return tostring(a)==tostring(b) end,
__export = function(self) return tostring(self) end,
__name = 'net/email',
__tostring = function(self) return '%s@%s' % {self.login, self.domain} end,
})