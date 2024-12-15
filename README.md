# t.net: network objects interface
- `t.net.ip`
- `t.net.domain`
- `t.net.host`
- `t.net.tld`

## dns service
- `t.net.dns`
```lua
local dns = t.net.dns

dns.ns('yandex.ru')     # ns2.yandex.ru ns1.yandex.ru
dns('yandex.ru', 'NS')  # same

dns.mx('yandex.ru')   # mx.yandex.ru
dns.mx('example.com') # nil

dns.ptr('1.1.1.1')              # one.one.one.one
dns.ptr('1.1.1.1.in-addr.arpa') # one.one.one.one
```

Typed values (`t.net.ip`, `t.net.host` and others) returned.

## depends
- `luaresolver`
