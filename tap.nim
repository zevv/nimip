
import std/[posix]
import types


{.emit:"""

#include <linux/if.h>
#include <linux/if_tun.h>
#include <sys/ioctl.h>
#include <fcntl.h>

static int setup_tap(char *name)
{
  int fd = open("/dev/net/tun", O_RDWR);
  if(fd == -1) return -1;

  struct ifreq ifr;
  memset(&ifr, 0, sizeof(ifr));
  snprintf(ifr.ifr_name, sizeof(ifr.ifr_name), "%s", name);
  ifr.ifr_flags = IFF_TAP | IFF_NO_PI;
  int r = ioctl(fd, TUNSETIFF, &ifr);
  if(r == -1) return -1;

  return fd;
}

""".}

proc setup_tap(name: cstring): cint {.cdecl,importc.}

proc tapOpen*(name: string): int =
  return setup_tap(name)

proc tapRx*(fd: int, f: var Frame) =
  discard read(fd.cint, addr f, sizeof(f))





