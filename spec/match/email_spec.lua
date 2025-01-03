describe("match.email", function()
	local t, is, email
	setup(function()
    t = require "t"
    is = t.is
    email = t.matchu.email
	end)
  it("meta", function()
    assert.truthy(is)
    assert.truthy(is.callable(email))
  end)
  it("positive", function()
    assert.equal('x@site.com', email('x@site.com'))
    assert.equal('x@site.info', email('x@site.info'))
    assert.equal('x@a.site.com', email('x@a.site.com'))
    assert.equal('1@site.COM', email('1@site.COM'))
    assert.equal('me@сайт.рф', email('me@сайт.рф'))
    assert.equal('a@xxx.сайт.рф', email('a@xxx.сайт.рф'))

    assert.equal('x@site.com', email(' x@site.com '))
    assert.equal('x@site.info', email(' x@site.info '))
    assert.equal('x@a.site.com', email(' x@a.site.com '))
    assert.equal('1@site.COM', email(' 1@site.COM '))
    assert.equal('me@сайт.рф', email(' me@сайт.рф '))
    assert.equal('a@xxx.сайт.рф', email(' a@xxx.сайт.рф '))

    assert.equal('x@site.com', email('!x@site.com*'))
    assert.equal('x@site.info', email('#x@site.info^'))
    assert.equal('x@a.site.com', email('%%x@a.site.com+'))
    assert.equal('1@site.COM', email('^1@site.COM='))
    assert.equal('me@сайт.рф', email('~me@сайт.рф#'))
    assert.equal('a@xxx.сайт.рф', email('/a@xxx.сайт.рф$'))

    assert.equal('-x@site.com', email('-x@site.com'))
    assert.equal('-x@site.com', email('-x@site.com-'))
  end)
  it("negative", function()
    assert.is_nil(email('8.8.8.8'))
    assert.is_nil(email('com'))
    assert.is_nil(email('.com'))
    assert.is_nil(email('com.ru'))
    assert.is_nil(email('.com.ru'))
    assert.is_nil(email('.'))
    assert.is_nil(email('.local'))
    assert.is_nil(email('local'))
    assert.is_nil(email({}))
    assert.is_nil(email({'type'}))
    assert.is_nil(email(0))
    assert.is_nil(email(''))
    assert.is_nil(email(false))
    assert.is_nil(email(true))
    assert.is_nil(email('@'))
    assert.is_nil(email('a@'))
  end)
  it("nil", function()
    assert.is_nil(email(nil))
    assert.is_nil(email())
  end)
end)