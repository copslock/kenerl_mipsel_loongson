Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jun 2007 17:43:15 +0100 (BST)
Received: from marmite.frogfoot.net ([196.1.58.49]:18109 "EHLO
	marmite.frogfoot.net") by ftp.linux-mips.org with ESMTP
	id S20021697AbXF2QnJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 29 Jun 2007 17:43:09 +0100
Received: from michael by marmite.frogfoot.net with local (Exim 4.63)
	(envelope-from <michael@frogfoot.com>)
	id 1I4JVf-0003oc-N5
	for linux-mips@linux-mips.org; Fri, 29 Jun 2007 18:39:51 +0200
Date:	Fri, 29 Jun 2007 18:39:51 +0200
To:	linux-mips@linux-mips.org
Subject: Unhandled kernel unaligned access debugging
Message-ID: <20070629163951.GG5929@marmite.frogfoot.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	Michael Wood <michael@frogfoot.com>
Return-Path: <michael@frogfoot.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15580
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michael@frogfoot.com
Precedence: bulk
X-list: linux-mips

Hi

I've been playing with OpenWRT Kamikaze (development branch) on a TI AR7
board (TNETD7300AGDW).  The kernel version is 2.6.21.5.

Twice now I have got an "Unhandled kernel unaligned access" error on
boot.  I have booted various revisions of Kamikaze (2.6.21.5 kernel)
several times without encountering the error, though.  i.e. it only
happens occasionally.

After the error the device appears to have hung, so debugfs/proc won't
help me, I suppose :)

I think understand more or less what this means, but am unsure of how to
debug it.  I think OpenWRT is using the vanilla kernel, but maybe I'm
missing something.  Is this because I'm not using the kernel from
linux-mips.org?

This is the second one I got:

==========================================================================
$ staging_dir_mipsel/bin/mipsel-linux-uclibc-gdb build_mipsel/linux-2.6-ar7/linux-2.6.21.5/vmlinux
GNU gdb 6.3
Copyright 2004 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "--host=i486-linux-gnu --target=mipsel-linux-uclibc"...
(gdb) set remotebaud 9600
(gdb) target remote /dev/ttyS0
Remote debugging using /dev/ttyS0
0xffffffff9410cc10 in breakinst () at arch/mips/kernel/gdb-stub.c:1066
1066            __asm__ __volatile__(
warning: shared library handler failed to enable breakpoint
(gdb) c
Continuing.
Linux version 2.6.21.5 (michael@marmite) (gcc version 4.1.2) #1 Wed Jun 27 14:40:37 SAST 2007
CPU revision is: 00018448
Determined physical RAM map:
 memory: 01000000 @ 14000000 (usable)
Built 1 zonelists.  Total pages: 4064
Kernel command line: init=/etc/preinit rootfstype=squashfs,jffs2, netconsole=@10.10.10.254/,@10.10.10.49/ console=gdb
netconsole: local port 6665
netconsole: local IP 10.10.10.254
netconsole: interface eth0
netconsole: remote port 6666
netconsole: remote IP 10.10.10.49
netconsole: remote ethernet address ff:ff:ff:ff:ff:ff
Primary instruction cache 16kB, physically tagged, 4-way, linesize 16 bytes.
Primary data cache 16kB, 4-way, linesize 16 bytes.
Synthesized TLB refill handler (20 instructions).
Synthesized TLB load handler fastpath (32 instructions).
Synthesized TLB store handler fastpath (32 instructions).
Synthesized TLB modify handler fastpath (31 instructions).
Wait for gdb client connection ...
PID hash table entries: 64 (order: 6, 256 bytes)
Using 75.000 MHz high precision timer.
Dentry cache hash table entries: 2048 (order: 1, 8192 bytes)
Inode-cache hash table entries: 1024 (order: 0, 4096 bytes)
Memory: 13460k/16388k available (2083k kernel code, 180k reserved, 432k data, 112k init)
Mount-cache hash table entries: 512
NET: Registered protocol family 16
vlynq0: regs 0x08611800, irq 29, mem 0x04000000
vlynq1: regs 0x08611c00, irq 33, mem 0x0c000000
registering PCI controller with io_map_base unset
Generic PHY: Registered new driver
Time: MIPS clocksource has been installed.
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 512 (order: 0, 4096 bytes)
TCP bind hash table entries: 512 (order: -1, 2048 bytes)
TCP: Hash tables configured (established 512 bind 512)
TCP reno registered
squashfs: version 3.0 (2006/03/15) Phillip Lougher
Registering mini_fo version $Id$
JFFS2 version 2.2. (NAND) (C) 2001-2006 Red Hat, Inc.
io scheduler noop registered
io scheduler deadline registered (default)
ar7_wdt: timer margin 59 seconds (prescale 65535, change 57180, freq 62500000)
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing disabled
serial8250: ttyS0 at MMIO 0x8610e00 (irq = 15) is a TI-AR7
serial8250: ttyS1 at MMIO 0x8610f00 (irq = 16) is a TI-AR7
Fixed PHY: Registered new driver
cpmac-mii: probed
cpmac: device eth0 (regs: 08612800, irq: 41, phy: fixed@100:1, mac: 00:73:06:04:72:7a)
cpmac: device eth1 (regs: 08610000, irq: 27, phy: 0:1f, mac: 00:73:06:04:72:7a)
netconsole: eth0 doesn't support polling, aborting.
physmap platform flash device: 00400000 at 10000000
physmap-flash.0: Found 1 x16 devices at 0x0 in 16-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
cmdlinepart partition parsing not available
RedBoot partition parsing not available
Parsing AR7 partition map...
4 ar7part partitions found on MTD device physmap-flash.0
Creating 4 MTD partitions on "physmap-flash.0":
0x00000000-0x00010000 : "loader"
0x00010000-0x00020000 : "config"
0x00020000-0x00400000 : "linux"
0x000ea968-0x00400000 : "rootfs"
mtd: partition "rootfs" doesn't start on an erase block boundary -- force read-only
0x00210000-0x00400000 : "rootfs_data"
Registered led device: ar7:status
nf_conntrack version 0.5.0 (128 buckets, 1024 max)
ip_tables: (C) 2000-2006 Netfilter Core Team
TCP vegas registered
NET: Registered protocol family 1
NET: Registered protocol family 17
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
VFS: Mounted root (squashfs filesystem) readonly.
Freeing unused kernel memory: 112k freed
Warning: unable to open an initial console.
Algorithmics/MIPS FPU Emulator v1.5
mini_fo: using base directory: /
mini_fo: using storage directory: /jffs
Unhandled kernel unaligned access[#1]:
Cpu 0
$ 0   : 00000000 10008400 69725020 94001b90
$ 4   : 94003200 7265746e 00000002 00000000
$ 8   : 94016338 940162b0 94016228 940161a0
$12   : 94e5653c 943a0000 943a0000 94e5659c
$16   : 94001b80 00000000 94003200 00000002
$20   : 00000000 00000000 00000000 00000000
$24   : 00000000 9410b8a0
$28   : 943e4000 943e5ec0 00000000 94175e40
Hi    : 00000003
Lo    : 00000002
epc   : 941742bc drain_freelist+0x6c/0xf8     Not tainted
ra    : 94175e40 cache_reap+0xc0/0x124
Status: 10008402    KERNEL EXL
Cause : 10800010
BadVA : 7265746e
PrId  : 00018448
Modules linked in:
Process events/0 (pid: 4, threadinfo=943e4000, task=94019000)
Stack : 00000000 94174208 f47ff6ec bc9bfed7 94001b80 94003200 943a2f70 9401bed0
        94175e40 94175e00 00000000 9411f090 f05ec800 9430495c 00000000 9411e100
        10008401 9400bb80 94175d80 941376dc 9400bb80 9401bed0 00000000 00000000
        9400bb88 9400bb90 9400bb80 9413813c 9401bedc 9401bedc 00000000 9411d7bc
        ffffffff ffffffff ffffffff ffffffff 00000000 94019000 9411eea0 00100100
        ...
Call Trace:
[<941742bc>] drain_freelist+0x6c/0xf8
[<94175e40>] cache_reap+0xc0/0x124
[<941376dc>] run_workqueue+0x160/0x248
[<9413813c>] worker_thread+0x11c/0x164
[<9413c884>] kthread+0x1b8/0x224
[<941054d4>] kernel_thread_helper+0x10/0x18


Code: 40816000  0905d0cb  02201021 <8ca30000> 8ca40004  3c020010  34420100  ac830000  aca20000
PHY: fixed@100:1 - Link is Up - 10/Half
==========================================================================

If I disassemble drain_freelist, this is what I get.  I assume the
instruction at drain_freelist+108 is the culprit:

Dump of assembler code for function drain_freelist:
0xffffffff94174250 <drain_freelist+0>:  addiu   sp,sp,-40
0xffffffff94174254 <drain_freelist+4>:  sw      s3,28(sp)
0xffffffff94174258 <drain_freelist+8>:  sw      s2,24(sp)
0xffffffff9417425c <drain_freelist+12>: sw      s1,20(sp)
0xffffffff94174260 <drain_freelist+16>: sw      s0,16(sp)
0xffffffff94174264 <drain_freelist+20>: move    s2,a0
0xffffffff94174268 <drain_freelist+24>: move    s0,a1
0xffffffff9417426c <drain_freelist+28>: move    s3,a2
0xffffffff94174270 <drain_freelist+32>: move    s1,zero
0xffffffff94174274 <drain_freelist+36>: j       0x94174310 <drain_freelist+192>
0xffffffff94174278 <drain_freelist+40>: sw      ra,32(sp)
0xffffffff9417427c <drain_freelist+44>: mfc0    at,c0_status
0xffffffff94174280 <drain_freelist+48>: ori     at,at,0x1f
0xffffffff94174284 <drain_freelist+52>: xori    at,at,0x1f
0xffffffff94174288 <drain_freelist+56>: mtc0    at,c0_status
0xffffffff9417428c <drain_freelist+60>: nop
0xffffffff94174290 <drain_freelist+64>: nop
0xffffffff94174294 <drain_freelist+68>: nop
0xffffffff94174298 <drain_freelist+72>: lw      a1,20(s0)
0xffffffff9417429c <drain_freelist+76>: bne     a1,v1,0x941742bc <drain_freelist+108>
0xffffffff941742a0 <drain_freelist+80>: nop
0xffffffff941742a4 <drain_freelist+84>: mfc0    at,c0_status
0xffffffff941742a8 <drain_freelist+88>: ori     at,at,0x1f
0xffffffff941742ac <drain_freelist+92>: xori    at,at,0x1e
0xffffffff941742b0 <drain_freelist+96>: mtc0    at,c0_status
0xffffffff941742b4 <drain_freelist+100>:        j       0x9417432c <drain_freelist+220>
0xffffffff941742b8 <drain_freelist+104>:        move    v0,s1
0xffffffff941742bc <drain_freelist+108>:        lw      v1,0(a1)
0xffffffff941742c0 <drain_freelist+112>:        lw      a0,4(a1)
0xffffffff941742c4 <drain_freelist+116>:        lui     v0,0x10
0xffffffff941742c8 <drain_freelist+120>:        ori     v0,v0,0x100
0xffffffff941742cc <drain_freelist+124>:        sw      v1,0(a0)
0xffffffff941742d0 <drain_freelist+128>:        sw      v0,0(a1)
0xffffffff941742d4 <drain_freelist+132>:        lui     v0,0x20
0xffffffff941742d8 <drain_freelist+136>:        ori     v0,v0,0x200
0xffffffff941742dc <drain_freelist+140>:        sw      a0,4(v1)
0xffffffff941742e0 <drain_freelist+144>:        sw      v0,4(a1)
0xffffffff941742e4 <drain_freelist+148>:        lw      v0,24(s0)
0xffffffff941742e8 <drain_freelist+152>:        lw      v1,284(s2)
0xffffffff941742ec <drain_freelist+156>:        subu    v0,v0,v1
0xffffffff941742f0 <drain_freelist+160>:        sw      v0,24(s0)
0xffffffff941742f4 <drain_freelist+164>:        mfc0    at,c0_status
0xffffffff941742f8 <drain_freelist+168>:        ori     at,at,0x1f
0xffffffff941742fc <drain_freelist+172>:        xori    at,at,0x1e
0xffffffff94174300 <drain_freelist+176>:        mtc0    at,c0_status
0xffffffff94174304 <drain_freelist+180>:        jal     0x94173ec4 <slab_destroy>
0xffffffff94174308 <drain_freelist+184>:        move    a0,s2
0xffffffff9417430c <drain_freelist+188>:        addiu   s1,s1,1
0xffffffff94174310 <drain_freelist+192>:        slt     v0,s1,s3
0xffffffff94174314 <drain_freelist+196>:        beqz    v0,0x94174328 <drain_freelist+216>
0xffffffff94174318 <drain_freelist+200>:        addiu   v1,s0,16
0xffffffff9417431c <drain_freelist+204>:        lw      v0,16(s0)
0xffffffff94174320 <drain_freelist+208>:        bne     v0,v1,0x9417427c <drain_freelist+44>
0xffffffff94174324 <drain_freelist+212>:        nop
0xffffffff94174328 <drain_freelist+216>:        move    v0,s1
0xffffffff9417432c <drain_freelist+220>:        lw      ra,32(sp)
0xffffffff94174330 <drain_freelist+224>:        lw      s3,28(sp)
0xffffffff94174334 <drain_freelist+228>:        lw      s2,24(sp)
0xffffffff94174338 <drain_freelist+232>:        lw      s1,20(sp)
0xffffffff9417433c <drain_freelist+236>:        lw      s0,16(sp)
0xffffffff94174340 <drain_freelist+240>:        jr      ra
0xffffffff94174344 <drain_freelist+244>:        addiu   sp,sp,40

Where do I go from here?

Thanks in advance.

-- 
Michael Wood <michael@frogfoot.com>
