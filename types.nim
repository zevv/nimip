
import std/[strutils,strscans]

type

  NimIp* = object
    ifaces*: seq[Iface]

  Iface* = ref object
    name*: string
    macAddr*: MacAddr
    ipAddrs*: seq[IPAddr]

  MacAddr* = array[6, uint8]

  IP4Addr* = array[4, uint8]

  IP6Addr* = array[16, uint16]

  IPFamily* = enum IP4, IP6

  IPAddr* = object
    case family*: IPFamily
      of IP4:
        ip4Addr*: IP4Addr
      of IP6:
        ip6Addr*: IP6Addr

  Frame* {.packed.} = object
    data*: array[1500, uint8]
  
  EthType* = uint16
  
  EthHdr* {.packed.} = object
    dst*: MacAddr
    src*: MacAddr
    typ*: EthType

  ArpHdr* {.packed.} = object
    hType*: uint16
    pType*: uint16
    hLen*: uint8
    pLen*: uint8
    op*: uint16
    senderMac*: MacAddr
    senderIp*: IP4Addr
    targetMac*: MacAddr
    targetIp*: IP4Addr

const

  ET_ARP* = EthType(0x0806)


proc `$`*(a: MacAddr): string =
  for i in 0..<sizeof(a):
    if i > 0: result.add(":")
    result.add toHex(a[i])


proc macAddr*(s: string): MacAddr =
  var a: array[6, int]
  if s.scanf("$h:$h:$h:$h:$h:$h", a[0], a[1], a[2], a[3], a[4], a[5]):
    for i in 0..5:
      result[i] = a[i].uint8
