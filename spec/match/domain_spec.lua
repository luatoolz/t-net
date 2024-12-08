describe("match.domain", function()
	local t, is, domain
	setup(function()
    t = require "t"
    is = t.is
    domain = t.match.domain
	end)
  it("meta", function()
    assert.truthy(is)
    assert.truthy(is.callable(domain))
  end)
  it("positive", function()
--    assert.equal('сайт.рф', domain('сайт.рф'))
--    assert.equal('xxx.сайт.рф', domain('xxx.сайт.рф'))
--    assert.equal('любой.сайт.рф', domain('любой.сайт.рф'))

    assert.equal('x.com', domain('x.com'))
    assert.equal('xy.com', domain('xy.com'))

    assert.equal('site.com', domain('site.com'))
    assert.equal('site.COM', domain('site.COM'))
    assert.equal('site.CoM', domain('site.CoM'))

    assert.equal('site.com', domain('site.com.'))
    assert.equal('site.com', domain('.site.com'))
    assert.equal('site.com', domain('.site.com.'))

    assert.equal('si-te.com', domain('si-te.com'))

    assert.equal('xxx.site.info', domain('xxx.site.info'))

    assert.is_true(domain('xxx.site.com') == domain('xxx.site.com'))
    assert.is_true(domain('site.com') == domain('site.com'))

    assert.equal('com.ru', domain('com.ru'))
    assert.equal('com.ru', domain('.com.ru'))
  end)
  it("negative", function()
    assert.is_nil(domain('8.8.8.8'))

    assert.is_nil(domain('com'))
    assert.is_nil(domain('.com'))

    assert.is_nil(domain('.'))
    assert.is_nil(domain('.local'))
    assert.is_nil(domain('local'))
    assert.is_nil(domain({}))
    assert.is_nil(domain({'type'}))
    assert.is_nil(domain(0))
    assert.is_nil(domain(''))
    assert.is_nil(domain(false))
    assert.is_nil(domain(true))

    assert.not_true(domain('site.com') == domain('SiTe.info'))
    assert.not_true(domain('site.com') == domain('xxx.site.info'))
  end)
  it("nil", function()
    assert.is_nil(domain(nil))
    assert.is_nil(domain())
  end)
end)