
import std/[strutils]
import types

proc `$`*(a: IP4Addr): string =
  for i in 0..<sizeof(a):
    if i != 0:
      result.add "."
    result.add intToStr(a[i].int)


proc initIP4Addr*(a: string): IP4Addr =
  result = [10.uint8, 3, 3, 4]
