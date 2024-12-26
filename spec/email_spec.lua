describe("email", function()
	local t, is, email
	setup(function()
    t = require "t"
    is = t.is
    email = t.net.email
	end)
  it("meta", function()
    assert.truthy(is)
    assert.truthy(is.callable(email))
  end)
  it("positive", function()
    assert.equal('x@site.com', tostring(email('x@site.com')))
    assert.equal('x@site.com', tostring(email({login='x', domain='site.com'})))
    assert.equal('x@site.com', tostring(email(email('x@site.com'))))

    assert.equal('x@site.info', tostring(email('x@site.info')))

    assert.equal('x@a.site.com', tostring(email('x@a.site.com')))
    assert.equal('x@a.site.com', tostring(email({login='x', domain='a.site.com'})))
    assert.equal('x@a.site.com', tostring(email(email('x@a.site.com'))))

    assert.equal('1@site.com', tostring(email('1@site.COM')))

    assert.equal('me@сайт.рф', tostring(email('me@сайт.рф')))
    assert.equal('a@xxx.сайт.рф', tostring(email('a@xxx.сайт.рф')))

--    assert.equal('me@сайт.рф', tostring(email('me@саЙт.рф')))

    assert.is_true(email('x@site.com') == email('x@site.com'))

    assert.equal('site.com', tostring(t.net.domain(email('x@a.site.com'))))
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
    assert.is_nil(email('@a'))
    assert.is_nil(email('a@'))

    assert.not_true(email('a@site.com') == email('a@site.info'))
    assert.not_true(email('a@site.com') == email('b@site.com'))
  end)
  it("nil", function()
    assert.is_nil(email(nil))
    assert.is_nil(email())
  end)
end)