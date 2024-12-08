describe("inet_aton", function()
	local t, is, inet_aton
  local mn, ip8, ip255
	setup(function()
    t = require "t"
    is = t.is
    inet_aton = t.net.inet_aton
    mn=256
    ip8=8*(mn^3) + 8*(mn^2) + 8*(mn) + 8 --134744072
    ip255=255*(mn^3) + 255*(mn^2) + 255*(mn) + 255
	end)
  it("meta", function()
    assert.truthy(is)
    assert.truthy(is.callable(inet_aton))
    assert.equal(134744072, ip8)
  end)
  it("positive", function()
    assert.equal(0, inet_aton('0.0.0.0'))
    assert.equal(ip8, inet_aton('8.8.8.8'))
    assert.equal(ip255, inet_aton('255.255.255.255'))
  end)
  it("negative", function()
    assert.is_nil(inet_aton(-1))
    assert.is_nil(inet_aton(ip255+1))
    assert.is_nil(inet_aton('.'))
    assert.is_nil(inet_aton({}))
    assert.is_nil(inet_aton({'type'}))
    assert.is_nil(inet_aton(''))
    assert.is_nil(inet_aton(false))
    assert.is_nil(inet_aton(true))
  end)
  it("nil", function()
    assert.is_nil(inet_aton(nil))
    assert.is_nil(inet_aton())
  end)
end)