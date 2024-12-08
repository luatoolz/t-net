describe("inet_ntoa", function()
	local t, is, inet_ntoa
  local mn, ip8, ip255
	setup(function()
    t = require "t"
    is = t.is
    inet_ntoa = t.net.inet_ntoa
    mn=256
    ip8=8*(mn^3) + 8*(mn^2) + 8*(mn) + 8 --134744072
    ip255=255*(mn^3) + 255*(mn^2) + 255*(mn) + 255
	end)
  it("meta", function()
    assert.truthy(is)
    assert.truthy(is.callable(inet_ntoa))
    assert.equal(134744072, ip8)
  end)
  it("positive", function()
    assert.equal('0.0.0.0', inet_ntoa(0))
    assert.equal('8.8.8.8', inet_ntoa(ip8))
    assert.equal('255.255.255.255', inet_ntoa(ip255))
  end)
  it("negative", function()
    assert.is_nil(inet_ntoa(-1))
    assert.is_nil(inet_ntoa(ip255+1))
    assert.is_nil(inet_ntoa('.'))
    assert.is_nil(inet_ntoa({}))
    assert.is_nil(inet_ntoa({'type'}))
    assert.is_nil(inet_ntoa(''))
    assert.is_nil(inet_ntoa(false))
    assert.is_nil(inet_ntoa(true))
  end)
  it("nil", function()
    assert.is_nil(inet_ntoa(nil))
    assert.is_nil(inet_ntoa())
  end)
end)