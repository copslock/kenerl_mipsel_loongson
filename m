Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Nov 2008 23:57:34 +0000 (GMT)
Received: from mms2.broadcom.com ([216.31.210.18]:10245 "EHLO
	mms2.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S23941225AbYKZX5Z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 26 Nov 2008 23:57:25 +0000
Received: from [10.11.16.99] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.2)); Wed, 26 Nov 2008 15:57:08 -0800
X-Server-Uuid: D3C04415-6FA8-4F2C-93C1-920E106A2031
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 DA91C2B2; Wed, 26 Nov 2008 15:57:07 -0800 (PST)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.11.18.52]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id C19DC2B0; Wed, 26 Nov
 2008 15:57:07 -0800 (PST)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.5a-GA) with ESMTP
 id HIH20745; Wed, 26 Nov 2008 15:57:06 -0800 (PST)
Received: from SJEXCHHUB02.corp.ad.broadcom.com (sjexchhub02
 [10.16.192.232]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 760F220501; Wed, 26 Nov 2008 15:57:06 -0800 (PST)
Received: from SJEXCHCCR01.corp.ad.broadcom.com ([10.252.49.130]) by
 SJEXCHHUB02.corp.ad.broadcom.com ([10.16.192.232]) with mapi; Wed, 26
 Nov 2008 15:57:06 -0800
From:	"Mark E Mason" <mason@broadcom.com>
To:	"Andrew Sharp" <andy.sharp@onstor.com>
cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	LMO <linux-mips@linux-mips.org>,
	"mmason@upwardaccess.com" <mmason@upwardaccess.com>
Date:	Wed, 26 Nov 2008 15:57:05 -0800
Subject: RE: Booting top-of-tree bcm47xx as nfs-root with cfe only (no
 sibyl)
Thread-Topic: Booting top-of-tree bcm47xx as nfs-root with cfe only (no
 sibyl)
Thread-Index: AclQHxxhVKDsSwASRgKxzd44qOXlrAAAf1Sw
Message-ID: <BD3F7F1EFBA6D54DB056C4FFA45140080348EC805C@SJEXCHCCR01.corp.ad.broadcom.com>
References: <BD3F7F1EFBA6D54DB056C4FFA45140080348EC801C@SJEXCHCCR01.corp.ad.broadcom.com>
 <alpine.LFD.1.10.0811262304510.23566@ftp.linux-mips.org>
 <BD3F7F1EFBA6D54DB056C4FFA45140080348EC8037@SJEXCHCCR01.corp.ad.broadcom.com>
 <20081126153115.24dda1dc@ripper.onstor.net>
In-Reply-To: <20081126153115.24dda1dc@ripper.onstor.net>
Accept-Language: en-US
Content-Language: en-US
acceptlanguage:	en-US
MIME-Version: 1.0
X-WSS-ID: 65333DDE3FC21065722-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-Path: <mason@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21456
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mason@broadcom.com
Precedence: bulk
X-list: linux-mips

Hello Andrew,

Thanks!

I think I found it, not only do you need CONFIG_ROOT_NFS, but you also need CONFIG_IP_PNP and a few other friends, which seem to be missing from the default config file for the 47xx.

Once those are fixed, I get this far, which is better, but still not booting (see below).

I'm running a debian userland for this - the one I usually use with my bcm1480 ;). It's not compiled with soft-float, and the 47xx doesn't have a fpu - so something with the floating point emulation code configuration I'd imagine. I'm familiar with the internals of that code (or at least an older version of it that was used in VxWorks), but not so much with how it's used / configured under Linux.

Are the OpenWrT and other userlands usually built with soft-float or something?

Thanks!
/Mark


CFE> setenv LINUX_CMDLINE "root=/dev/nfs rw ip=dhcp nfsroot=10.0.1.184:/home/mason/debian-root-el"
*** command status = 0
CFE> ifconfig eth1 -auto
phy 5, vendor 000895 part 12
mii_probe: Using PHY 5
eth1: Link speed: 100BaseT FDX
Device eth1:  hwaddr 02-90-4C-4F-47-04, ipaddr 10.0.1.150, mask 255.255.255.0
        gateway 10.0.1.1, nameserver 10.0.1.1, domain mshome.net
*** command status = 0
CFE> boot -elf 10.0.1.184:vmlinux.47xx
Loader:elf Filesys:tftp Dev:eth1 File:10.0.1.184:vmlinux.47xx Options:(null)
Loading: 0x80001000/4087942 0x803e7086/245626 Entry at 0x80005590
Closing network.
eth1: 8000 sent, 8002 received, 0 interrupts
Starting program at 0x80005590

Linux version 2.6.28-rc6 (mason@hawaii) (gcc version 3.4.4) #6 Wed Nov 26 15:50:43 PST 2008
arcs_cmdline='root=/dev/nfs rw ip=dhcp nfsroot=10.0.1.184:/home/mason/debian-root-el console=ttyS0,115200'<6>console [early0] enabled
CPU revision is: 00029006 (Broadcom BCM3302)
ssb: Sonics Silicon Backplane found at address 0x18000000
Determined physical RAM map:
 memory: 04000000 @ 00000000 (usable)
Initrd not found or empty - disabling initrd
Zone PFN ranges:
  Normal   0x00000000 -> 0x00004000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00004000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16256
Kernel command line: root=/dev/nfs rw ip=dhcp nfsroot=10.0.1.184:/home/mason/debian-root-el console=ttyS0,115200
Primary instruction cache 16kB, VIPT, 2-way, linesize 16 bytes.
Primary data cache 16kB, 2-way, VIPT, cache aliases, linesize 16 bytes
PID hash table entries: 256 (order: 8, 1024 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 60656k/65536k available (3104k kernel code, 4804k reserved, 721k data, 168k init, 0k highmem)
Calibrating delay loop... 198.65 BogoMIPS (lpj=397312)
Mount-cache hash table entries: 512
Initializing cgroup subsys ns
Initializing cgroup subsys cpuacct
net_namespace: 720 bytes
NET: Registered protocol family 16
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Fixing up bridge 0000:00:00.0
PCI: Fixing up device 0000:00:00.0
PCI: Fixing latency timer of device 0000:00:00.0 to 168
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 2048 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
TCP reno registered
NET: Registered protocol family 1
audit: initializing netlink socket (disabled)
type=2000 audit(0.379:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
msgmni has been set to 118
alg: No test for stdrng (krng)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Serial: 8250/16550 driver2 ports, IRQ sharing disabled
serial8250.0: ttyS0 at MMIO 0xb8000300 (irq = 3) is a 16550A
console handover: boot [early0] -> real [ttyS0]
serial8250.0: ttyS1 at MMIO 0xb8000400 (irq = 3) is a 16550A
brd: module loaded
b44.c:v2.0
eth0: Broadcom 44xx/47xx 10/100BaseT Ethernet 02:90:4c:4e:47:04
eth1: Broadcom 44xx/47xx 10/100BaseT Ethernet 02:90:4c:4f:47:04
console [netcon0] enabled
netconsole: network logging started
Driver 'sd' needs updating - please use bus_type methods
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
mice: PS/2 mouse device common for all mice
TCP bic registered
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
registered taskstats version 1
b44: eth0: Link is up at 100 Mbps, full duplex.
b44: eth0: Flow control is off for TX and off for RX.
Sending DHCP requests .<6>b44: eth1: Link is up at 100 Mbps, full duplex.
b44: eth1: Flow control is off for TX and off for RX.
., OK
IP-Config: Got DHCP answer from 0.0.0.0, my address is 10.0.1.149
b44: eth0: powering down PHY
IP-Config: Complete:
     device=eth1, addr=10.0.1.149, mask=255.255.255.0, gw=10.0.1.1,
     host=10.0.1.149, domain=mshome.net, nis-domain=(none),
     bootserver=0.0.0.0, rootserver=10.0.1.184, rootpath=
Looking up port of RPC 100003/2 on 10.0.1.184
Looking up port of RPC 100005/1 on 10.0.1.184
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 168k freed
Algorithmics/MIPS FPU Emulator v1.5
Data bus error, epc == 803ef178, ra == 80017030
Oops[#1]:
Cpu 0
$ 0   : 00000000 1000a800 fffd9000 00000001
$ 4   : 810a6000 fffd9000 810a6f00 fffd9000
$ 8   : 803bc1c8 00000001 81021500 00040000
$12   : 00000000 803e8d20 00000001 803bc1a0
$16   : 810a6000 803f0000 2ad19120 0109968b
$20   : 8394d2ac 8395517c 2ad19120 83940de0
$24   : 00000000 2aab4184                  
$28   : 83818000 83819db0 00000000 80017030
Hi    : 00000000
Lo    : 00000000
epc   : 803ef178 0x803ef178
    Not tainted
ra    : 80017030 copy_user_highpage+0x90/0x140
Status: 1000a803    KERNEL EXL IE 
Cause : 0080001c
PrId  : 00029006 (Broadcom BCM3302)
Modules linked in:
Process init (pid: 1, threadinfo=83818000, task=83815a58, tls=00000000)
Stack : 83943464 0109968b 8394d2ac 8395517c 803f0000 81021320 810214c0 8008c498
        839551d0 00000000 00000000 00000000 00000000 00000000 810214c0 83940de0
        83815a58 0109968b 80000000 8395517c 8394d2ac 2ad19120 00000001 00030000
        00000464 8008dc84 83940de0 00100073 00000000 00000000 8394d2ac 83940e20
        0109968b 00100073 80091a14 800917d4 83815a58 8395517c 83940e14 83940de0
        ...
Call Trace:
[<8008c498>] do_wp_page+0x6dc/0xa24
[<8008dc84>] handle_mm_fault+0x7e8/0x8e8
[<80091a14>] mmap_region+0x3cc/0x6b8
[<800917d4>] mmap_region+0x18c/0x6b8
[<80016a00>] do_page_fault+0x100/0x344
[<8001f6f0>] fpu_emulator_cop1Handler+0x1bf0/0x1c54
[<8009200c>] do_mmap_pgoff+0x30c/0x344
[<80013c94>] do_cpu+0x360/0x3c4
[<80001400>] ret_from_exception+0x0/0x24
[<80001400>] ret_from_exception+0x0/0x24


Code: cc9e0060  cc9e0070  cca40100 <8ca80000> 8ca90004  8caa0008  8cab000c  cc9e0080  ac880000 
note: init[1] exited with preempt_count 2
BUG: scheduling while atomic: init/1/0x10000002
Modules linked in:
Call Trace:
[<800125a0>] dump_stack+0x8/0x34
[<80009bac>] __sched_text_start+0x6c/0x6d0
[<8002c4d0>] __cond_resched+0x20/0x4c
[<8000a5e4>] _cond_resched+0x4c/0x60
[<80033780>] put_files_struct+0x19c/0x228
[<800342b4>] do_exit+0x268/0x854
[<80012d40>] do_be+0x0/0x198

Kernel panic - not syncing: Attempted to kill init!
