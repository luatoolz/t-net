describe("domain", function()
	local t, is, domain, host, tld
	setup(function()
    t = require "t"
    is = t.is
    domain = t.net.domain
    host = t.net.host
    tld = t.net.tld
	end)
  it("meta", function()
    assert.truthy(is)
    assert.truthy(is.callable(domain))
  end)
  it("positive", function()
    assert.equal('site.com', tostring(domain('site.com.')))
    assert.equal('site.com', tostring(domain('.site.com')))
    assert.equal('site.com', tostring(domain('.site.com.')))

    assert.equal('site.com', tostring(domain('site.COM')))
    assert.equal('site.com', tostring(domain('site.CoM')))
    assert.equal('site.com', tostring(domain('site.com')))

--    assert.equal('сайт.рф', tostring(domain('сайт.рф')))
--    assert.equal('сайт.рф', tostring(domain('xxx.сайт.рф')))
--    assert.equal('сайт.рф', tostring(domain('любой.сайт.рф')))

    assert.equal('site.info', tostring(domain('xxx.site.info')))

    assert.equal(domain('xxx.site.com'), domain('site.com'))

    assert.equal(tld('site.com'), domain('site.com').tld)
    assert.equal(tld('xxx.site.info'), domain('xxx.site.info').tld)

    assert.equal('my.local', tostring(domain('my.local')))
    assert.equal('my.local', tostring(domain('xxx.my.local')))
    assert.equal('my.local', tostring(domain('yyy.xxx.my.local')))

    assert.equal(true, domain('my.local').islocal)
    assert.is_nil(domain('site.com').islocal)

    assert.equal(host('www.site.com'), domain('site.com') .. 'www')
    assert.equal('www.site.com', tostring(domain('site.com') .. 'www'))
  end)
  it("__concat", function()
    assert.equal(host('www.site.com'), domain('site.com') .. 'www')
  end)
  it("negative", function()
    assert.is_nil(domain('8.8.8.8'))

    assert.is_nil(domain('com'))
    assert.is_nil(domain('.com'))

    assert.is_nil(domain('com.ru'))
    assert.is_nil(domain('.com.ru'))

    assert.is_nil(domain('.'))
    assert.is_nil(domain('.local'))
    assert.is_nil(domain('local'))
    assert.is_nil(domain({}))
    assert.is_nil(domain({'type'}))
    assert.is_nil(domain(0))
    assert.is_nil(domain(''))
    assert.is_nil(domain(false))
    assert.is_nil(domain(true))

    assert.not_true(domain('site.com') == domain('site.info'))
  end)
  it("nil", function()
    assert.is_nil(domain(nil))
    assert.is_nil(domain())
  end)
end)