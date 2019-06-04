
import std/[strutils,posix]
import types, arp


proc `$`*(t: EthType): string =
  toHex(t)


proc `$`*(eh: EthHdr): string =
  result.add $eh.dst
  result.add " "
  result.add $eh.src
  result.add " [" & $eh.typ & "]"


template make(o: untyped, off: int, T: type): untyped =
  cast[ptr T](cast[ByteAddress](o.addr) + off)


proc ethRx*(nip: NimIP, f: var Frame) =

  var eh = make(f, 0, EthHdr)
  eh.typ = ntohs(eh.typ)

  echo $(eh[])

  if eh.typ == ET_ARP:
    var ah = make(f, sizeof(EthHdr), ArpHdr)
    nip.arpRx(ah[])

proc isBcast(macAddr: MacAddr): bool =
  return macAddr == [0xff.uint8, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff]
