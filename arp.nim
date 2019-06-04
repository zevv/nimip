
import std/[posix,strutils]
import types, ip, ip4, iface, iface


proc `$`*(ah: ArpHdr): string =
  result.add "ARP\n"
  result.add "  Hardware type: " & $ah.hType & "\n"
  result.add "  Protocol type: 0x" & toHex(ah.pType) & "\n"
  result.add "  Hardware size: " & $ah.hLen & "\n"
  result.add "  Protocol size: " & $ah.hLen & "\n"
  result.add "  Opcode: " & $ah.op & "\n"
  result.add "  Sender MAC: " & $ah.senderMac & "\n"
  result.add "  Sender IP: " & $ah.senderIp & "\n"
  result.add "  Target MAC: " & $ah.targetMac & "\n"
  result.add "  Target IP: " & $ah.targetIp & "\n"

proc arpRx*(nip: NimIP, ah: var ArpHdr) =
  ah.htype = ntohs(ah.hType)
  ah.ptype = ntohs(ah.pType)
  ah.op = ntohs(ah.op)

  let iface = nip.ipAddrToIface(ipAddr(ah.targetIp))
  if iface != nil:
    echo $iface
