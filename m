Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 May 2008 01:36:26 +0100 (BST)
Received: from p549F5155.dip.t-dialin.net ([84.159.81.85]:65001 "EHLO
	p549F5155.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S28575670AbYE2UQA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 29 May 2008 21:16:00 +0100
Received: from mx03.syneticon.net ([87.79.32.166]:64784 "EHLO
	mx03.syneticon.net") by lappi.linux-mips.net with ESMTP
	id S1108422AbYE2UPz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 29 May 2008 22:15:55 +0200
Received: from localhost (filter1.syneticon.net [192.168.113.3])
	by mx03.syneticon.net (Postfix) with ESMTP id 98DA095EE;
	Thu, 29 May 2008 22:15:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mx03.syneticon.net
Received: from mx03.syneticon.net ([192.168.113.4])
	by localhost (mx03.syneticon.net [192.168.113.3]) (amavisd-new, port 10025)
	with ESMTP id cPPIvOZ8R+I2; Thu, 29 May 2008 22:15:48 +0200 (CEST)
Received: from [192.168.10.145] (koln-4d0b776d.pool.mediaWays.net [77.11.119.109])
	by mx03.syneticon.net (Postfix) with ESMTP;
	Thu, 29 May 2008 22:15:48 +0200 (CEST)
Message-ID: <483F0EF3.3060500@wpkg.org>
Date:	Thu, 29 May 2008 22:15:47 +0200
From:	Tomasz Chmielewski <mangoo@wpkg.org>
User-Agent: Thunderbird 2.0.0.12 (X11/20080305)
MIME-Version: 1.0
To:	Nicolas Schichan <nschichan@freebox.fr>
CC:	linux-mips@linux-mips.org,
	Kexec Mailing List <kexec@lists.infradead.org>,
	openwrt-devel@lists.openwrt.org
Subject: Re: kexec on mips - anyone has it working?
References: <483BCB75.4050901@wpkg.org> <200805271449.45124.nschichan@freebox.fr> <483C4F73.4040909@wpkg.org> <200805291347.05196.nschichan@freebox.fr>
In-Reply-To: <200805291347.05196.nschichan@freebox.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <mangoo@wpkg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19380
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mangoo@wpkg.org
Precedence: bulk
X-list: linux-mips

Nicolas Schichan schrieb:
> On Tuesday 27 May 2008 20:14:11 you wrote:
>> Aah, I see.
>>
>> Anyway, it doesn't work - with or without this slight change in
>> machine_kexec.c, with kexec compiled from the sources in the link you
>> gave or with kexec-tools-testing-20080324, it just doesn't work on
>> BCM43XX with OpenWRT patches. At least on Asus WL-500gP.
> 
> I'm not familiar with broadcom CPU names, but isn't BCM43XX supposed
> to be a Wifi chipset ? :)
> 
> However,  could   you  kexec   a  kernel  from   a  kernel   that  has
> CONFIG_MIPS_UNCACHED  set (under  "Kernel  hacking", "run  uncached")?
> this will slow down the kernel that does the kexec, but if this works,
> then it is most probably a cache problem.

I guess I'm not that lucky. Either CONFIG_MIPS_UNCACHED slowed the 
device down so much that it didn't boot, or it didn't boot. Hey, isn't 
it the same? So either BCM43XX doesn't work very well with certain 
kernel options enabled/disabled, or OpenWRT patches still lack some 
features to make ASUS WL-500gP properly (added openwrt-devel to CC:).

Without CONFIG_MIPS_UNCACHED it boots just fine.

Here is what is displayed when doing "kexec -e" (using 
kexec-tools-testing-20080324):

# kexec -e
b44: eth0: powering down PHY
Starting new kernel
Will call new kernel at 00305000
Bye ...





Below, a full bootup up to the point where it freezes with 
CONFIG_MIPS_UNCACHED enabled (every message is printed very fast, up 
until the last "usbcore", where nothing else shows up):


CFE version 1.0.37 for BCM947XX (32bit,SP,LE)
Build Date: �| 10�� 12 22:21:19 CST 2006 (root@localhost.localdomain)
Copyright (C) 2000,2001,2002,2003 Broadcom Corporation.

Initializing Arena
Initializing Devices.
et0: Broadcom BCM47xx 10/100 Mbps Ethernet Controller 3.90.7.0
rndis0: Broadcom USB RNDIS Network Adapter (P-t-P)
CPU type 0x29006: 264MHz
Total memory: 33554432 KBytes

Total memory used by CFE:  0x80800000 - 0x8089AF40 (634688)
Initialized Data:          0x808313D0 - 0x80833790 (9152)
BSS Area:                  0x80833790 - 0x80834F40 (6064)
Local Heap:                0x80834F40 - 0x80898F40 (409600)
Stack Area:                0x80898F40 - 0x8089AF40 (8192)
Text (code) segment:       0x80800000 - 0x808313D0 (201680)
Boot area (physical):      0x0089B000 - 0x008DB000
Relocation Factor:         I:00000000 - D:00000000

Device eth0:  hwaddr 00-0E-A6-F1-ED-3C, ipaddr 192.168.1.1, mask 
255.255.255.0
         gateway not set, nameserver not set
Null Rescue Flag.
Loader:raw Filesys:raw Dev:flash0.os File: Options:(null)
Loading: .. 3768 bytes read
Entry at 0x80001000
Closing network.
Starting program at 0x80001000
Linux version 2.6.25.4 (build@dom) (gcc version 4.1.2) #5 Thu May 29 
21:45:46 CEST 2008
console [early0] enabled
CPU revision is: 00029006 (Broadcom BCM3302)
ssb: Core 0 found: ChipCommon (cc 0x800, rev 0x03, vendor 0x4243)
ssb: Core 1 found: Fast Ethernet (cc 0x806, rev 0x06, vendor 0x4243)
ssb: Core 2 found: Fast Ethernet (cc 0x806, rev 0x06, vendor 0x4243)
ssb: Core 3 found: USB 1.1 Hostdev (cc 0x808, rev 0x03, vendor 0x4243)
ssb: Core 4 found: PCI (cc 0x804, rev 0x08, vendor 0x4243)
ssb: Core 5 found: MIPS 3302 (cc 0x816, rev 0x03, vendor 0x4243)
ssb: Core 6 found: V90 (cc 0x807, rev 0x02, vendor 0x4243)
ssb: Core 7 found: IPSEC (cc 0x80B, rev 0x00, vendor 0x4243)
ssb: Core 8 found: MEMC SDRAM (cc 0x80F, rev 0x02, vendor 0x4243)
ssb: Initializing MIPS core...
ssb: set_irq: core 0x0806, irq 2 => 2
ssb: set_irq: core 0x0806, irq 3 => 3
ssb: set_irq: core 0x0804, irq 0 => 4
ssb: Sonics Silicon Backplane found at address 0x18000000
Serial init done.
Determined physical RAM map:
  memory: 02000000 @ 00000000 (usable)
Initrd not found or empty - disabling initrd
Zone PFN ranges:
   Normal          0 ->     8192
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
     0:        0 ->     8192
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 8128
Kernel command line: root=/dev/sda1 rootdelay=10 console=ttyS0,115200
Primary instruction cache 16kB, VIPT, 2-way, linesize 16 bytes.
Primary data cache 16kB, 2-way, VIPT, cache aliases, linesize 16 bytes
Synthesized clear page handler (26 instructions).
Synthesized copy page handler (46 instructions).
PID hash table entries: 128 (order: 7, 512 bytes)
console handover: boot [early0] -> real [ttyS0]
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Memory: 29376k/32768k available (2409k kernel code, 3392k reserved, 392k 
data, 144k init, 0k highmem)
Mount-cache hash table entries: 512
net_namespace: 440 bytes
NET: Registered protocol family 16
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb




With CONFIG_MIPS_UNCACHED disabled, it continues like here:

ssb: PCIcore in host mode found
Registering a PCI bus after boot
PCI: Fixing up bridge 0000:00:00.0
PCI: Fixing up device 0000:00:00.0
PCI: Fixing latency timer of device 0000:00:00.0 to 168
PCI: Enabling device 0000:00:02.0 (0000 -> 0002)
PCI: Fixing up device 0000:00:02.0
ssb: Core 0 found: ChipCommon (cc 0x800, rev 0x0D, vendor 0x4243)
ssb: Core 1 found: IEEE 802.11 (cc 0x812, rev 0x09, vendor 0x4243)
ssb: Core 2 found: PCI (cc 0x804, rev 0x0C, vendor 0x4243)
ssb: Core 3 found: PCMCIA (cc 0x80D, rev 0x07, vendor 0x4243)
ssb: Sonics Silicon Backplane found on PCI device 0000:00:02.0
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 1024 (order: 1, 8192 bytes)
TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
TCP: Hash tables configured (established 1024 bind 1024)
TCP reno registered
detected lzma initramfs
initramfs: LZMA lc=1,lp=2,pb=2,origSize=512
squashfs: version 3.0 (2006/03/15) Phillip Lougher
Registering mini_fo version $Id$
(...)


-- 
Tomasz Chmielewski
http://wpkg.org
