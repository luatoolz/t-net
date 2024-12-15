describe("dns", function()
	local t, is, dns, host, tld, domain, ip, ips
	setup(function()
    t = require "t"
    is = t.is
    dns = t.net.dns
    host = t.net.host
    tld = t.net.tld
    domain = t.net.domain
    ip = t.net.ip
    ips = t.net.ips
	end)
  it("meta", function()
    assert.truthy(is)
    assert.truthy(is.callable(dns))
    assert.truthy(is.callable(host))
    assert.truthy(is.callable(tld))
    assert.truthy(is.callable(domain))

    assert.callable(dns.a)
    assert.callable(dns.A)
    assert.equal(dns.a, dns.A)
  end)
  it("positive", function()
    assert.equal(t.set({ip('34.226.36.51'),ip('34.211.108.46'),ip('13.113.196.52'),ip('35.176.92.19')}), t.set(dns('site.com.', 'A')))
    assert.values({'34.226.36.51','34.211.108.46','13.113.196.52','35.176.92.19'}, dns('site.com.', 'A')*tostring)
    assert.values({'34.226.36.51','34.211.108.46','13.113.196.52','35.176.92.19'}, dns.a('site.com.')*tostring)
    assert.values({'34.226.36.51','34.211.108.46','13.113.196.52','35.176.92.19'}, dns.A('site.com.')*tostring)
    assert.values({'34.226.36.51','34.211.108.46','13.113.196.52','35.176.92.19'}, ips(dns.A('site.com.')*tostring))
    assert.values({'ns2.yandex.ru', 'ns1.yandex.ru'}, dns.ns('yandex.ru')*tostring)
    assert.equal('one.one.one.one', tostring(dns.ptr('1.1.1.1')[1]))
    assert.equal('one.one.one.one', tostring(dns.ptr('1.1.1.1.in-addr.arpa')[1]))
    assert.equal(t.array{host('mx.yandex.ru')}, dns.mx('yandex.ru'))
    assert.equal(host('mx.yandex.ru'), dns('yandex.ru', 'mx')[1])
    assert.equal(host('mx.yandex.ru'), dns('yandex.ru', 'MX')[1])
    assert.is_nil(dns.mx('example.com'))

--    assert.equal('сайт.рф', dns('яндекс.рф'))
--    assert.equal('сайт.рф', tostring(dns('xxx.сайт.рф')))
--    assert.equal('сайт.рф', tostring(dns('любой.сайт.рф')))
  end)
  it("negative", function()
    assert.is_nil(dns.a('8.8.8.8'))

    assert.is_nil(dns.a('com'))
    assert.is_nil(dns.a('.com'))
    assert.is_nil(dns.a('.'))
    assert.is_nil(dns.a('.local'))
    assert.is_nil(dns.a('local'))
    assert.is_nil(dns.a({}))
    assert.is_nil(dns.a({'type'}))
    assert.is_nil(dns.a(0))
    assert.is_nil(dns.a(''))
    assert.is_nil(dns.a(false))
    assert.is_nil(dns.a(true))
  end)
  it("nil", function()
    assert.is_nil(dns(nil))
    assert.is_nil(dns())
    assert.is_nil(dns.a(nil))
    assert.is_nil(dns.a())
  end)
end)