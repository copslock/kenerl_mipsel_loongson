Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Mar 2008 01:55:48 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:23257 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28576465AbYCUBzp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 21 Mar 2008 01:55:45 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1JcWTu-0007B3-00; Fri, 21 Mar 2008 02:55:42 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 9074FFA04B; Fri, 21 Mar 2008 02:55:40 +0100 (CET)
Date:	Fri, 21 Mar 2008 02:55:40 +0100
To:	Matteo Croce <technoboy85@gmail.com>
Cc:	linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>,
	Felix Fietkau <nbd@openwrt.org>,
	Nicolas Thill <nico@openwrt.org>, linux-serial@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH][MIPS][5/6]: AR7: serial hack
Message-ID: <20080321015540.GA30988@alpha.franken.de>
References: <200803120221.25044.technoboy85@gmail.com> <200803141646.09645.technoboy85@gmail.com> <20080315104009.GA6533@alpha.franken.de> <200803161645.06364.technoboy85@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200803161645.06364.technoboy85@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18448
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Sun, Mar 16, 2008 at 04:45:06PM +0100, Matteo Croce wrote:
> Tried I get teh usual broken serial output:
> 
> IP6 oover IPv4 tuneliing driver
> NET: eggistered protooll family 17
> VFS: Monteed root (squahfss filesystem)reaadonly.

Linux version 2.6.25-rc6-00000-g151de9e-dirty (tsbogend@solo.franken.de)
(gcc version 3.3.3 (Debian 20040320)) #29 Fri Mar 21 02:40:21 CET 2008
console [early0] enabled
CPU revision is: 00018448 (MIPS 4KEc)
TI AR7 (Unknown), ID: 0x5700, Revision: 0x00
Determined physical RAM map:
 memory: 02000000 @ 14000000 (usable)
Zone PFN ranges:
  Normal      81920 ->    90112
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:    81920 ->    90112
Built 1 zonelists in Zone order, mobility grouping on.  Total pages:
8128
Kernel command line: console=ttyS0,115200
Primary instruction cache 16kB, VIPT, 4-way, linesize 16 bytes.
Primary data cache 16kB, 4-way, VIPT, no aliases, linesize 16 bytes
Synthesized clear page handler (26 instructions).
Synthesized copy page handler (46 instructions).
PID hash table entries: 128 (order: 7, 512 bytes)
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Memory: 29700k/32768k available (2075k kernel code, 3068k reserved, 466k
data, 136k init, 0k highmem)
Mount-cache hash table entries: 512
net_namespace: 152 bytes
NET: Registered protocol family 16
SCSI subsystem initialized
NET: Registered protocol family 2
Time: MIPS clocksource has been installed.
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 1024 (order: 1, 8192 bytes)
TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
TCP: Hash tables configured (established 1024 bind 1024)
TCP reno registered
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing
disabled
serial8250: ttyS0 at MMIO 0x8610e03 (irq = 15) is a 16550A
console handover: boot [early0] -> real [ttyS0]
serial8250: ttyS1 at MMIO 0x8610f03 (irq = 16) is a 16550A
loop: module loaded
Fixed MDIO Bus: probed
ar7_wdt: failed to unlock WDT disable reg
ar7_wdt: failed to unlock WDT prescale reg
ar7_wdt: failed to unlock WDT change reg
ar7_wdt: timer margin 59 seconds (prescale 65535, change 57180, freq
62500000)
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
Root-NFS: No NFS server available, giving up.
VFS: Unable to mount root fs via NFS, trying floppy.
List of all partitions:
No filesystem could mount root, tried:
Kernel panic - not syncing: VFS: Unable to mount root fs on
unknown-block(2,0)
Rebooting in 3 seconds..

I don't see any problems with using PORT_16550A. What I'm still
wondering how your kernel could work at all, since there is a
missing case for setting up the TLB refill handler. Something like
the patch below.

And most of the AR7 device driver code will not work for big endian. 
The log above is from a big endian AR7 system, where I needed
to disable CPMAC to get it booting that far.

Thomas.


diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 3a93d4c..382738c 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -307,6 +307,7 @@ static void __cpuinit build_tlb_write_entry(u32 **p, struct uasm_label **l,
 	case CPU_R12000:
 	case CPU_R14000:
 	case CPU_4KC:
+	case CPU_4KEC:
 	case CPU_SB1:
 	case CPU_SB1A:
 	case CPU_4KSC:


-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
