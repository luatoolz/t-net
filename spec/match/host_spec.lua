describe("match.host", function()
	local t, is, host
	setup(function()
    t = require "t"
    is = t.is
    host = t.matchu.host
	end)
  it("meta", function()
    assert.truthy(is)
    assert.truthy(is.callable(host))
  end)
  it("positive", function()
    assert.equal('сайт.рф', host('сайт.рф'))
    assert.equal('xxx.сайт.рф', host('xxx.сайт.рф'))
    assert.equal('любой.сайт.рф', host('любой.сайт.рф'))

    assert.equal('x.com', host('x.com'))
    assert.equal('xy.com', host('xy.com'))

    assert.equal('site.com', host('site.com'))
    assert.equal('site.COM', host('site.COM'))
    assert.equal('site.CoM', host('site.CoM'))

    assert.equal('site.com', host('site.com-'))
    assert.equal('site.com', host('site.com.'))
    assert.equal('site.com', host('.site.com'))
    assert.equal('site.com', host('.site.com.'))

    assert.equal('si-te.com', host('si-te.com'))

    assert.equal('xxx.site.info', host('xxx.site.info'))

    assert.is_true(host('xxx.site.com') == host('xxx.site.com'))
    assert.is_true(host('site.com') == host('site.com'))

    assert.equal('com.ru', host('com.ru'))
    assert.equal('com.ru', host('.com.ru'))

    assert.equal('com', host('com'))
    assert.equal('com', host('.com'))
    assert.equal('com', host('com.'))
    assert.equal('com', host('.com.'))
    assert.equal('local', host('local'))
    assert.equal('local', host('.local'))
  end)
  it("negative", function()
    assert.is_nil(host('8.8.8.8'))
    assert.is_nil(host('.'))
    assert.is_nil(host({}))
    assert.is_nil(host({'type'}))
    assert.is_nil(host(0))
    assert.is_nil(host(''))
    assert.is_nil(host(false))
    assert.is_nil(host(true))

    assert.not_true(host('site.com') == host('SiTe.info'))
    assert.not_true(host('site.com') == host('xxx.site.info'))
  end)
  it("nil", function()
    assert.is_nil(host(nil))
    assert.is_nil(host())
  end)
end)