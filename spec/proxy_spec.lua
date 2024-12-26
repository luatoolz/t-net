describe("proxy", function()
	local t, is, proxy
	setup(function()
    t = require "t"
    is = t.is
    proxy = t.net.proxy
	end)
  it("meta", function()
    assert.truthy(is)
    assert.truthy(is.callable(proxy))
  end)
  it("positive", function()
    assert.equal('socks5://127.0.0.1:9050', tostring(proxy('socks5://127.0.0.1:9050')))
    assert.equal('socks5', proxy('socks5://127.0.0.1:9050').scheme)
    assert.equal('127.0.0.1', proxy('socks5://127.0.0.1:9050').ip)
    assert.equal('9050', proxy('socks5://127.0.0.1:9050').port)
  end)
  it("negative", function()
    assert.is_nil(proxy('socks5q://127.0.0.1:9050'))
    assert.is_nil(proxy('socks5://127.0.0.1:'))
    assert.is_nil(proxy('socks5://127.0.0.370:9050'))

    assert.is_nil(proxy(-1))
    assert.is_nil(proxy('.'))
    assert.is_nil(proxy({}))
    assert.is_nil(proxy({'type'}))
    assert.is_nil(proxy(''))
    assert.is_nil(proxy(false))
    assert.is_nil(proxy(true))
  end)
  it("nil", function()
    assert.is_nil(proxy(nil))
    assert.is_nil(proxy())
  end)
end)