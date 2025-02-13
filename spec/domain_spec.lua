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
    assert.truthy(is.callable(domain.normal))
  end)
  it("positive", function()
    assert.equal('site.com', tostring(domain('site.com.')))
    assert.equal('site.com', tostring(domain('.site.com')))
    assert.equal('site.com', tostring(domain('.site.com.')))

    assert.equal('site.com', tostring(domain('site.COM')))
    assert.equal('site.com', tostring(domain('site.CoM')))
    assert.equal('site.com', tostring(domain('site.com')))

    assert.equal('сайт.рф', tostring(domain('сайт.рф')))
    assert.equal('сайт.рф', tostring(domain('xxx.сайт.рф')))
    assert.equal('сайт.рф', tostring(domain('любой.сайт.рф')))

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

    assert.equal('日本語.jp', tostring(domain('日本語.jp')))
    assert.equal('日本語.jp', tostring(domain('xn--wgv71a119e.jp')))
    assert.equal('сайт.рф', tostring(domain('xn--80aswg.xn--p1ai')))
    assert.equal('räksmörgås.se', tostring(domain('räksmörgås.se')))
    assert.equal('räksmörgås.se', tostring(domain('xn--rksmrgs-5wao1o.se')))

    assert.equal('site.info', domain.normal('site.info'))
  end)
  it("tld", function()
    assert.equal('com', domain('microsoft.com').tld)
    assert.equal('com.ru', domain('microsoft.com.ru').tld)
  end)
  it("idn", function()
    assert.equal('xn--rksmrgs-5wao1o.se', domain('räksmörgås.se').idn)
    assert.equal('xn--blbrgrd-fxak7p.no', domain('blåbærgrød.no').idn)
    assert.equal('xn--nxasmm1c.com', domain('βόλος.com').idn)
    assert.equal('xn--nxasmm1c.com', domain('xn--nxasmm1c.com').idn)
    assert.equal('xn--80aswg.xn--p1ai', domain('xn--80aswg.xn--p1ai').idn)
    assert.equal('xn--80aswg.xn--p1ai', domain('сайт.рф').idn)
    assert.equal('xn--wgv71a119e.jp', domain('日本語.jp').idn)
    assert.is_nil(domain('microsoft.com').idn)
  end)
  it("local", function()
    assert.is_nil(domain('microsoft.com').islocal)
    assert.is_true(domain('microsoft.local').islocal)
  end)
  it("ispubmx", function()
    assert.is_true(domain('dispostable.com').ispubmx)
    assert.is_nil(domain('microsoft.com').ispubmx)
    assert.is_nil(domain('microsoft.local').ispubmx)
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