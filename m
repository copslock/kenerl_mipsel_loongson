Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Nov 2008 22:56:38 +0000 (GMT)
Received: from mms1.broadcom.com ([216.31.210.17]:54286 "EHLO
	mms1.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S23940884AbYKZW4c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 26 Nov 2008 22:56:32 +0000
Received: from [10.11.16.99] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.2)); Wed, 26 Nov 2008 14:56:13 -0800
X-Server-Uuid: 02CED230-5797-4B57-9875-D5D2FEE4708A
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 6EC022B1; Wed, 26 Nov 2008 14:56:13 -0800 (PST)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.11.18.52]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id 5A31A2B0; Wed, 26 Nov
 2008 14:56:13 -0800 (PST)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.5a-GA) with ESMTP
 id HIH11906; Wed, 26 Nov 2008 14:56:12 -0800 (PST)
Received: from SJEXCHHUB02.corp.ad.broadcom.com (sjexchhub02
 [10.16.192.232]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 7201020501; Wed, 26 Nov 2008 14:56:12 -0800 (PST)
Received: from SJEXCHCCR01.corp.ad.broadcom.com ([10.252.49.130]) by
 SJEXCHHUB02.corp.ad.broadcom.com ([10.16.192.232]) with mapi; Wed, 26
 Nov 2008 14:56:12 -0800
From:	"Mark E Mason" <mason@broadcom.com>
To:	LMO <linux-mips@linux-mips.org>
cc:	"Mark E Mason" <mason@broadcom.com>,
	"mmason@upwardaccess.com" <mmason@upwardaccess.com>
Date:	Wed, 26 Nov 2008 14:56:11 -0800
Subject: Booting top-of-tree bcm47xx as nfs-root with cfe only (no
 sibyl)
Thread-Topic: Booting top-of-tree bcm47xx as nfs-root with cfe only (no
 sibyl)
Thread-Index: AclQGizx3SJWSxkJQ3yAWCaYcK8Cyg==
Message-ID: <BD3F7F1EFBA6D54DB056C4FFA45140080348EC801C@SJEXCHCCR01.corp.ad.broadcom.com>
Accept-Language: en-US
Content-Language: en-US
acceptlanguage:	en-US
MIME-Version: 1.0
X-WSS-ID: 65330B8761S16752266-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-Path: <mason@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21451
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mason@broadcom.com
Precedence: bulk
X-list: linux-mips

Hello all,

I dug one of my bcm47xx eval boards out of the garage and I've been trying to get it to boot using the top-of-tree kernel [with NFS enabled as a non-module], with an NFS root mounted filesystem, using CFE only (no sibyl).

I've gotten as far as I have with the following CFE commands:

setenv LINUX_CMDLINE "root=/dev/nfs rw nfsroot=10.0.1.184:/home/mason/debian-root-el"    
ifconfig eth1 -auto
boot -elf 10.0.1.184:vmlinux.47xx

And this is as far as I've gotten ... Something isn't liking the NFS root specification. I'll admit that using sibyl on other cfe machines has made me lazy. I don't really remember the incantations to get this to work correctly... Or is this a kernel config issue?

Thanks in advance,
Mark

CFE> setenv LINUX_CMDLINE "root=/dev/nfs rw nfsroot=10.0.1.184:/home/mason/debian-root-el"    
*** command status = 0
CFE> ifconfig eth1 -auto
phy 5, vendor 000895 part 12
mii_probe: Using PHY 5
eth1: Link speed: 100BaseT FDX
Device eth1:  hwaddr 02-90-4C-4F-47-04, ipaddr 10.0.1.153, mask 255.255.255.0
        gateway 10.0.1.1, nameserver 10.0.1.1, domain mshome.net
*** command status = 0
CFE> boot -elf 10.0.1.184:vmlinux.47xx
Loader:elf Filesys:tftp Dev:eth1 File:10.0.1.184:vmlinux.47xx Options:(null)
Loading: 0x80001000/4067462 0x803e2086/245290 Entry at 0x80005590
Closing network.
eth1: 7960 sent, 7968 received, 0 interrupts
Starting program at 0x80005590

Linux version 2.6.28-rc6 (mason@hawaii) (gcc version 3.4.4) #4 Wed Nov 26 13:59:54 PST 2008
arcs_cmdline='root=/dev/nfs rw nfsroot=10.0.1.184:/home/mason/debian-root-el console=ttyS0,115200'<6>console [early0] enabled
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
Kernel command line: root=/dev/nfs rw nfsroot=10.0.1.184:/home/mason/debian-root-el console=ttyS0,115200
Primary instruction cache 16kB, VIPT, 2-way, linesize 16 bytes.
Primary data cache 16kB, 2-way, VIPT, cache aliases, linesize 16 bytes
PID hash table entries: 256 (order: 8, 1024 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 60676k/65536k available (3103k kernel code, 4784k reserved, 713k data, 156k init, 0k highmem)
Calibrating delay loop... 199.16 BogoMIPS (lpj=398336)
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
VFS: Cannot open root device "nfs" or unknown-block(0,255)
Please append a correct "root=" boot option; here are the available partitions:
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,255)
