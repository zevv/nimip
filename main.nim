
import types, iface, tap, eth, ip4


var nip = NimIp()
var if0 = newIface("ifname", "00:30:b4:10:20:30")
if0.addIpAddr("10.3.3.4")

nip.ifaces.add if0

let fd = tapOpen("nimtap0")

while true:
  var f: Frame

  tapRx(fd, f)
  echo $f

  nip.ethRx(f)

