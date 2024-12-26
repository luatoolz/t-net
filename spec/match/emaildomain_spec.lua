describe("match.emaildomain", function()
	local t, is, emaildomain
	setup(function()
    t = require "t"
    is = t.is
    emaildomain = t.matchu.emaildomain
	end)
  it("meta", function()
    assert.truthy(is)
    assert.truthy(is.callable(emaildomain))
  end)
  it("positive", function()
    assert.equal('site.com', emaildomain('x@site.com'))
    assert.equal('site.info', emaildomain('x@site.info'))
    assert.equal('a.site.com', emaildomain('x@a.site.com'))
    assert.equal('site.COM', emaildomain('1@site.COM'))
    assert.equal('сайт.рф', emaildomain('me@сайт.рф'))
    assert.equal('xxx.сайт.рф', emaildomain('a@xxx.сайт.рф'))
  end)
  it("negative", function()
    assert.is_nil(emaildomain('8.8.8.8'))
    assert.is_nil(emaildomain('com'))
    assert.is_nil(emaildomain('.com'))
    assert.is_nil(emaildomain('com.ru'))
    assert.is_nil(emaildomain('.com.ru'))
    assert.is_nil(emaildomain('.'))
    assert.is_nil(emaildomain('.local'))
    assert.is_nil(emaildomain('local'))
    assert.is_nil(emaildomain({}))
    assert.is_nil(emaildomain({'type'}))
    assert.is_nil(emaildomain(0))
    assert.is_nil(emaildomain(''))
    assert.is_nil(emaildomain(false))
    assert.is_nil(emaildomain(true))
    assert.is_nil(emaildomain('@'))
    assert.is_nil(emaildomain('a@'))
  end)
  it("nil", function()
    assert.is_nil(emaildomain(nil))
    assert.is_nil(emaildomain())
  end)
end)