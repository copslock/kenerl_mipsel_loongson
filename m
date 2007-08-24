Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Aug 2007 12:25:57 +0100 (BST)
Received: from sorrow.cyrius.com ([65.19.161.204]:40460 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S20024507AbXHXLZt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Aug 2007 12:25:49 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 284196173E; Fri, 24 Aug 2007 11:25:12 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 626585437A; Fri, 24 Aug 2007 13:24:54 +0200 (CEST)
Date:	Fri, 24 Aug 2007 13:24:54 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Peter Horton <phorton@bitbox.co.uk>
Cc:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>,
	linux-mips@linux-mips.org
Subject: Re: Tulip driver broken on Cobalt RaQ1 in 2.6
Message-ID: <20070824112454.GD31646@deprecation.cyrius.com>
References: <20070823203757.GA25971@deprecation.cyrius.com> <20070824133656.4163c577.yoichi_yuasa@tripeaks.co.jp> <20070824080215.GA31646@deprecation.cyrius.com> <46CE9F03.7040207@bitbox.co.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <46CE9F03.7040207@bitbox.co.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16269
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Peter Horton <phorton@bitbox.co.uk> [2007-08-24 10:04]:
> What does /proc/interrupts show after this ?

No interrupt for eth0:

uruk:~# cat /proc/interrupts
           CPU0
  2:          0          XT-PIC  cascade
  8:          0          XT-PIC  rtc0
 14:       1773          XT-PIC  ide0
 18:     199990            MIPS  timer
 20:          0            MIPS  eth0
 21:        582            MIPS  serial
 22:          0            MIPS  cascade

ERR:          0


> Does the networking work in CoLo ?

Yes.

The full boot log (including CoLo) is below.
-- 
Martin Michlmayr
http://www.cyrius.com/

--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=log
Content-Transfer-Encoding: quoted-printable

Cobalt Microserver Diagnostics - 'We serve it, you surf it'
Built Mon Aug 24 14:44:00 PDT 1998=0D

 1.LCD Test................................PASS
 2.Controller Test.........................PASS
 4.Flash Test..............................PASS
 5.Bank 0:.................................16M
 6.Bank 1:.................................16M
 7.Bank 2:.................................16M
 8.Bank 3:.................................0M
 9.Serial Test.............................PASS
10.PCI Expansion Slot....................**EMPTY**
12.IDE Test................................PASS
13.Ethernet Test...........................PASS
16.RTC Test................................PASS
Decompressing -=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08=08 d=
one
Decompressing -|=08/=08-=08 done.

[ "CoLo" v1.22 ]
stage2: 82fa0000-83000000
cpu: clock 150.000MHz
pci: unit type <RaQ>
tulip: #0 device 21143
tulip: {00:10:e0:00:27:5c}
ide: resetting
boot: running boot menu
1> lcd 'Booting...'
1> net
tulip: link up (100Mbps full-duplex)
net: interface up
dhcp: DISCOVER
dhcp: OFFER 192.168.1.7 <-- 192.168.1.4
dhcp: REQUEST
dhcp: ACK
net: interface down
tulip: link up (100Mbps full-duplex)
net: interface up
  address     192.168.1.7
  netmask     255.255.255.0
  gateway     192.168.1.1
  name server 192.168.1.1
1> lcd 'Booting...' {ip-address}
1> nfs {dhcp-next-server} {dhcp-root-path} {dhcp-boot-file}
nfs: mounted "/nfsroot"
nfs: lookup "default.colo"
nfs: mode <0100644>
 0KB0KB loaded=0D
00000148 328t
nfs: unmounted "/nfsroot"
1> -script
2> nfs {dhcp-next-server} {dhcp-root-path} vmlinux-git
nfs: mounted "/nfsroot"
nfs: lookup "vmlinux-git"
nfs: mode <0100755>
 0KB 406KB=0D 830KB=0D 1256KB=0D 1672KB=0D 2097KB=0D 2523KB=0D 2938KB=0D335=
6KB loaded (1917KB/sec)=0D
00346e5e 3436126t
nfs: unmounted "/nfsroot"
2> lcd "Booting Debian"
2> execute root=3D/dev/hda2 console=3DttyS0,115200
elf32: 00080000 - 003741cf (80340000) (ffffffff.80000000)
elf32: 80080000 (80080000) 2980092t + 116948t
net: interface down
Linux version 2.6.23-rc3-gb377fd39-dirty (tbm@em64t) (gcc version 4.1.2 200=
61028 (prerelease) (Debian 4.1.1-19)) #50 Thu Aug 23 10:02:42 UTC 2007
console [early0] enabled
CPU revision is: 00002810
FPU revision is: 00002810
Determined physical RAM map:
 memory: 03000000 @ 00000000 (usable)
Built 1 zonelists in Zone order.  Total pages: 12192
Kernel command line: root=3D/dev/hda2 console=3DttyS0,115200
Primary instruction cache 16kB, physically tagged, 2-way, linesize 32 bytes.
Primary data cache 16kB, 2-way, linesize 32 bytes.
Synthesized TLB refill handler (21 instructions).
Synthesized TLB load handler fastpath (34 instructions).
Synthesized TLB store handler fastpath (34 instructions).
Synthesized TLB modify handler fastpath (33 instructions).
PID hash table entries: 256 (order: 8, 1024 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 45152k/49152k available (2380k kernel code, 3984k reserved, 431k da=
ta, 96k init, 0k highmem)
Mount-cache hash table entries: 512
NET: Registered protocol family 16
Galileo: revision 2
Galileo: PCI retry count exceeded (06.0)
Cobalt board ID: 4
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 2048 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
TCP reno registered
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Activating ISA DMA hang workarounds.
Cobalt LCD Driver v2.10
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
=FFserial8250.0: ttyS0 at MMIO 0x1c800000 (irq =3D 21) is a ST16650V2
console handover: boot [early0] -> real [ttyS0]
loop: module loaded
Linux Tulip driver version 1.1.15-NAPI (Feb 27, 2007)
PCI: Enabling device 0000:00:07.0 (0041 -> 0043)
tulip0: Old format EEPROM on 'Cobalt Microserver' board.  Using substitute =
media control info.
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip0:  MII transceiver #1 config 1000 status 7809 advertising 01e1.
eth0: Digital DS21142/43 Tulip rev 65 at MMIO 0x12040000, 00:10:E0:00:27:5C=
, IRQ 20.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: IDE controller at PCI slot 0000:00:09.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c586a (rev 27) IDE UDMA33 controller on pci0000:00:09.1
    ide0: BM-DMA at 0x10a0-0x10a7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x10a8-0x10af, BIOS settings: hdc:pio, hdd:pio
hda: SAMSUNG SV1021H, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 19932192 sectors (10205 MB) w/426KiB Cache, CHS=3D19774/16/63, UDMA(33)
hda: cache flushes not supported
 hda: hda1 hda2 hda3 < hda5 >
physmap platform flash device: 00080000 at 1fc00000
Found: AMD AM29F040
physmap-flash.0: Found 1 x8 devices at 0x0 in 8-bit bank
number of JEDEC chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
cmdlinepart partition parsing not available
RedBoot partition parsing not available
Using physmap partition information
Creating 1 MTD partitions on "physmap-flash.0":
0x00000000-0x00080000 : "firmware"
input: Cobalt buttons as /class/input/input0
rtc_cmos rtc_cmos: rtc core: registered rtc_cmos as rtc0
rtc0: alarms up to one day
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
rtc_cmos rtc_cmos: setting the system clock to 1998-01-15 05:51:39 (8848434=
99)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 96k freed
INIT: version 2.86 booting=0D=0D
Starting the hotplug events dispatcher: udevd.
Synthesizing the initial hotplug events...done.
Waiting for /dev to be fully populated...done.
Activating swap:swapon on /dev/hda5
Adding 176672k swap on /dev/hda5.  Priority:-1 extents:1 across:176672k
=2E
Will now check root file system:fsck 1.40-WIP (14-Nov-2006)
[/sbin/fsck.ext3 (1) -- /] fsck.ext3 -a -C0 /dev/hda2=20
/: Superblock last mount time is in the future.  FIXED.
/: clean, 192889/1212416 files, 824245/2421798 blocks
=2E
EXT3 FS on hda2, internal journal
Setting the system clock..
Cannot access the Hardware Clock via any known method.
Use the --debug option to see the details of our search for an access metho=
d.
System Clock set. Local time: Thu Jan 15 05:52:25 UTC 1998.
Cleaning up ifupdown....
Loading device-mapper support.
Will now check all file systems.
fsck 1.40-WIP (14-Nov-2006)
Checking all file systems.
[/sbin/fsck.ext2 (1) -- /boot] fsck.ext2 -a -C0 /dev/hda1=20
/boot: clean, 30/24096 files, 23248/96356 blocks
Done checking file systems.=20
A log is being saved in /var/log/fsck/checkfs if that location is writable.
Setting kernel variables...done.
Will now mount local filesystems:.
Will now activate swapfile swap:done.
Detecting hardware...Discovered hardware for these modules: de4x5 via82cxxx=
 uhci_hcd
=1B[33m*=1B[39;49m de4x5 disabled in configuration.
sed: can't read /proc/modules: No such file or directory
=1B[33m*=1B[39;49m Skipping unavailable/built-in via82cxxx module.
sed: can't read /proc/modules: No such file or directory
=1B[33m*=1B[39;49m Skipping unavailable/built-in uhci_hcd module.
Cleaning /tmp...done.
Cleaning /var/run...done.
Cleaning /var/lock...done.
Running 0dns-down to make sure resolv.conf is ok...done.
Setting up networking....
=1B[33m*=1B[39;49m /etc/network/options is deprecated (see README.Debian of=
 netbase).
Setting up IP spoofing protection...done (rp_filter).
Configuring network interfaces...Internet Software Consortium DHCP Client 2=
=2E0pl5
Copyright 1995, 1996, 1997, 1998, 1999 The Internet Software Consortium.
All rights reserved.

Please contribute if you find this software useful.
For info, please visit http://www.isc.org/dhcp-contrib.html

Listening on LPF/eth0/00:10:e0:00:27:5c
Sending on   LPF/eth0/00:10:e0:00:27:5c
Sending on   Socket/fallback/fallback-net
DHCPREQUEST on eth0 to 255.255.255.255 port 67
eth0: Setting full-duplex based on MII#1 link partner capability of 45e1.
DHCPREQUEST on eth0 to 255.255.255.255 port 67
DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 3
DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 7
DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 10
DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 19
DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 15
DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 7
No DHCPOFFERS received.
No working leases in persistent database.

Exiting.

Failed to bring up eth0.
done.
Starting portmap daemon....
Setting console screen modes and fonts.
Initializing random number generator...done.
Recovering nvi editor sessions...none found.
Setting up X server socket directory /tmp/.X11-unix....
Setting up ICE socket directory /tmp/.ICE-unix....
Recovering schroot sessions:.
INIT: Entering runlevel: 2=0D=0D
Starting system log daemon....
Starting kernel log daemon....
Starting portmap daemon...Already running..
Starting Cobalt LCD admin menu: paneld.
Starting MTA: exim4.
=1B[31m*=1B[39;49m ALERT: exim paniclog /var/log/exim4/paniclog has non-zer=
o size, mail system possibly broken
Starting printer spooler: lpd.
Starting internet superserver: inetd.
Starting OpenBSD Secure Shell server: sshd.
Starting NFS common utilities: statd.
Starting deferred execution scheduler: atd.
Starting periodic command scheduler: crond.
Running local boot scripts (/etc/rc.local).

Debian GNU/Linux 4.0 uruk ttyS0

uruk login: root
Password:=20
Last login: Thu Jan 15 05:43:54 1998 on ttyS0
Linux uruk 2.6.23-rc3-gb377fd39-dirty #50 Thu Aug 23 10:02:42 UTC 2007 mips

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
uruk:~# cat /proc/interrupts=20
           CPU0      =20
  2:          0          XT-PIC  cascade
  8:          0          XT-PIC  rtc0
 14:       1773          XT-PIC  ide0
 18:     199990            MIPS  timer
 20:          0            MIPS  eth0
 21:        582            MIPS  serial
 22:          0            MIPS  cascade

ERR:          0
uruk:~#=20

--Qxx1br4bt0+wmkIi--
