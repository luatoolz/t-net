describe("tld", function()
	local t, is, tld, domain, host
	setup(function()
    t = require "t"
    is = t.is
    tld = t.net.tld
    domain = t.net.domain
    host = t.net.host
    local _ = domain
    _ = host
	end)
  it("positive", function()
    assert.equal('com', tld('COM'))
    assert.equal('com', tld('CoM'))
    assert.equal('com', tld('com'))
    assert.equal('com', tld('.com'))
    assert.equal('рф', tld('.рф'))
    assert.equal('info', tld('.info'))

    assert.equal('com.ru', tld('com.ru'))
    assert.equal('com.ru', tld('.com.ru'))
    assert.equal('com.ru', tld('xxx.com.ru'))
    assert.equal('com.ru', tld('cOm.rU'))
    assert.equal('com.ru', tld('.Com.Ru'))
    assert.equal('com.ru', tld('xxx.COM.RU'))

    assert.equal('com', tld({'com'}))
    assert.equal('com.ru', tld({'com','ru'}))
    assert.equal('com.ru', tld({'xxx','com','ru'}))
    assert.equal('com', tld({'COM'}))
    assert.equal('com.ru', tld({'cOm','Ru'}))
    assert.equal('com.ru', tld({'xxx','cOm','Ru'}))

    assert.equal('com.ru', tld(domain({'xxx','com','ru'})))
    assert.equal('com.ru', tld(domain({'xxx','cOm','Ru'})))

    assert.equal('com', tld(host({'com'})))
    assert.equal('com.ru', tld(host({'com','ru'})))
    assert.equal('com.ru', tld(host({'xxx','com','ru'})))
    assert.equal('com', tld(host({'COM'})))
    assert.equal('com.ru', tld(host({'cOm','Ru'})))
    assert.equal('com.ru', tld(host({'xxx','cOm','Ru'})))
  end)
  it("negative", function()
    assert.is_nil(tld('8.8.8.8'))
    assert.is_nil(tld(''))
    assert.is_nil(tld('.'))
    assert.is_nil(tld('.local'))
    assert.is_nil(tld('local'))
    assert.is_nil(tld({}))
    assert.is_nil(tld({''}))
    assert.is_nil(tld({'type'}))
    assert.is_nil(tld(0))
    assert.is_nil(tld(''))
    assert.is_nil(tld(false))
    assert.is_nil(tld(true))
  end)
  it("nil", function()
    assert.is_nil(tld(nil))
    assert.is_nil(tld())
  end)
end)