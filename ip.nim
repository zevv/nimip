
import std/[strscans]
import types

proc `==`*(a, b: IPAddr): bool =
  if a.family == b.family:
    case a.family:
      of IP4:
        result = a.ip4Addr == b.ip4Addr
      of IP6:
        result = a.ip6Addr == b.ip6Addr


proc ipAddr*(s: string): IPAddr =
  var a: array[4, int]
  if s.scanf("$i.$i.$i.$i", a[0], a[1], a[2], a[3]):
    result = IPAddr(family: IP4)
    for i in 0..3:
      result.ip4Addr[i] = a[i].uint8


proc ipAddr*(ip4Addr: IP4Addr): IPAddr =
  result = IPAddr(family: IP4, ip4Addr: ip4Addr)
