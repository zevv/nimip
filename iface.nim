
import types, ip

proc newIface*(name: string, a: string): Iface =
  return Iface(name: name, macAddr: macAddr(a))

proc addIpAddr*(iface: Iface, s: string) =
  iface.ipAddrs.add ipAddr(s)

proc hasIpAddr*(iface: Iface, ipAddr: IPAddr): bool =
  for a in iface.ipAddrs:
    if a == ipAddr:
      return true

proc ipAddrToIface*(nip: NimIp, ipAddr: IPAddr): Iface =
  for iface in nip.ifaces:
    if iface.hasIpAddr(ipAddr):
      return iface

proc macAddrToIface*(nip: NimIp, macAddr: MacAddr): Iface =
  for iface in nip.ifaces:
    if iface.macAddr == macAddr:
      return iface

proc `$`*(i: Iface): string =
  return i.name & "[" & $i.macAddr & "]"
