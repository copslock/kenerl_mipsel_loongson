Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2006 19:13:17 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:51465 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133379AbWBQTNG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 17 Feb 2006 19:13:06 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 785B264D59; Fri, 17 Feb 2006 19:19:45 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 7E4E48F77; Fri, 17 Feb 2006 19:19:37 +0000 (GMT)
Date:	Fri, 17 Feb 2006 19:19:37 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Subject: Oops on 64-bit Cobalt with current git
Message-ID: <20060217191937.GA20521@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10501
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

I get the following oops with a 64-bit Cobalt kernel with today's
linux-mips git.  A 32-bit kernel with the same configuration works
without any problems.

Any idea?


Linux version 2.6.16-rc3 (tbm@deprecation) (gcc version 4.0.3 20051201 (prerelease) (Debian 4.0.2-5)) #12 Fri Feb 17 19:07:58 GMT 2006
 CPU revision is: 000028a0
 FPU revision is: 000028a0
 Cobalt board ID: 5
 Determined physical RAM map:
  memory: 0000000008000000 @ 0000000000000000 (usable)
 Built 1 zonelists
 Kernel command line: console=ttyS0,115200 root=/dev/hda2
 Primary instruction cache 32kB, physically tagged, 2-way, linesize 32 bytes.
 Primary data cache 32kB, 2-way, linesize 32 bytes.
 Synthesized TLB refill handler (32 instructions).
 Synthesized TLB load handler fastpath (46 instructions).
 Synthesized TLB store handler fastpath (46 instructions).
 Synthesized TLB modify handler fastpath (45 instructions).
 PID hash table entries: 1024 (order: 10, 32768 bytes)
 Console: colour dummy device 80x25
 Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
 Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
 Memory: 124244k/131072k available (2882k kernel code, 6676k reserved, 669k data, 156k init, 0k highmem)
 Mount-cache hash table entries: 256
 Checking for 'wait' instruction...  available.
 Checking for the multiply/shift bug... no.
 Checking for the daddi bug... no.
 Checking for the daddiu bug... no.
 NET: Registered protocol family 16
 Generic PHY: Registered new driver
 Galileo: fixed bridge class
 Galileo: revision 17
 fuse init (API version 7.6)
 Initializing Cryptographic API
 io scheduler noop registered
 io scheduler anticipatory registered (default)
 io scheduler deadline registered
 io scheduler cfq registered
 Activating ISA DMA hang workarounds.
 rtc: Digital UNIX epoch (1952) detected
 Real Time Clock Driver v1.12a
 Cobalt LCD Driver v2.10
 Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
 ÿserial8250: ttyS0 at I/O 0xc800000 (irq = 21) is a ST16650V2
 loop: loaded (max 8 devices)
 Marvell 88E1101: Registered new driver
 Davicom DM9161E: Registered new driver
 Davicom DM9131: Registered new driver
 Cicada Cis8204: Registered new driver
 LXT970: Registered new driver
 LXT971: Registered new driver
 QS6612: Registered new driver
 Linux Tulip driver version 1.1.13 (May 11, 2002)
 PCI: Enabling device 0000:00:07.0 (0041 -> 0043)
 tulip0: Old format EEPROM on 'Cobalt Microserver' board.  Using substitute media control info.
 tulip0:  EEPROM default media type Autosense.
 tulip0:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
 tulip0:  MII transceiver #1 config 1000 status 7809 advertising 01e1.
 eth0: Digital DS21143 Tulip rev 65 at ffffffffb0001000, 00:10:E0:00:BE:5E, IRQ 19.
 PCI: Enabling device 0000:00:0c.0 (0005 -> 0007)
 tulip1: Old format EEPROM on 'Cobalt Microserver' board.  Using substitute media control info.
 tulip1:  EEPROM default media type Autosense.
 tulip1:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
 tulip1:  MII transceiver #1 config 1000 status 7809 advertising 01e1.
 eth1: Digital DS21143 Tulip rev 65 at ffffffffb0001080, 00:10:E0:00:C5:7A, IRQ 20.
 Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
 ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
 VP_IDE: IDE controller at PCI slot 0000:00:09.1
 VP_IDE: chipset revision 6
 VP_IDE: not 100% native mode: will probe irqs later
 VP_IDE: VIA vt82c586a (rev 27) IDE UDMA33 controller on pci0000:00:09.1
     ide0: BM-DMA at 0x1420-0x1427, BIOS settings: hda:pio, hdb:pio
     ide1: BM-DMA at 0x1428-0x142f, BIOS settings: hdc:pio, hdd:pio
 hda: QUANTUM FIREBALLlct08 04, ATA DISK drive
 ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
 hda: max request size: 128KiB
 hda: 8421840 sectors (4311 MB) w/418KiB Cache, CHS=8912/15/63
 hda: cache flushes not supported
  hda: hda1 hda2 hda3 < hda5 hda6 >
 aoe: aoe_init: AoE v2.6-14 initialised.
 mice: PS/2 mouse device common for all mice
 NET: Registered protocol family 2
 IP route cache hash table entries: 2048 (order: 2, 16384 bytes)
 TCP established hash table entries: 8192 (order: 4, 65536 bytes)
 TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
 TCP: Hash tables configured (established 8192 bind 8192)
 TCP reno registered
 TCP bic registered
 Initializing IPsec netlink socket
 NET: Registered protocol family 1
 NET: Registered protocol family 17
 NET: Registered protocol family 15
 ieee80211: 802.11 data/management/control stack, git-1.1.7
 ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
 kjournald starting.  Commit interval 5 seconds
 EXT3-fs: mounted filesystem with ordered data mode.
 VFS: Mounted root (ext3 filesystem) readonly.
 Freeing unused kernel memory: 156k freed
 Failed to mount /selinux/: No such file or directory
 INIT: version 2.86 booting
CPU 0 Unable to handle kernel paging request at virtual address 0000000000000100, epc == ffffffff8008e8a8, ra == ffffffff80081d10
 Oops[#1]:
 Cpu 0
 $ 0   : 0000000000000000 ffffffff900064e1 9800000007fc98e8 ffffffff803a25d8
 $ 4   : 9800000007fcfeb0 0000000000000000 0000000000000004 9800000007fa1a80
 $ 8   : 0000000000000000 9800000007fcfe60 0000000000000000 0000000000443868
 $12   : 0000000000000000 0000000000000003 ffffffff8008f7f8 980000000786c000
 $16   : ffffffffffffffff 0000000000000000 0000000000538c88 0000000000000000
 $20   : 0000000000000000 00000000000002b5 0000000000440000 00000000005297e4
 $24   : 0000000000000000 ffffffff8008e890                                  
 $28   : 9800000007fcc000 9800000007fcfde0 0000000000522900 ffffffff80081d10
 Hi    : 0000000000000000
 Lo    : 0000000000000078
 epc   : ffffffff8008e8a8 do_signal32+0x18/0x2a0     Not tainted
 ra    : ffffffff80081d10 work_notifysig+0xc/0x14
 Status: 900064e2    KX SX UX KERNEL EXL 
 Cause : 00808008
 BadVA : 0000000000000100
 PrId  : 000028a0
 Process default.hotplug (pid: 688, threadinfo=9800000007fcc000, task=9800000007fc98e8)
 Stack : 0003000200000000 9800000007fc98e8 ffffffff800af118 0000000000100100
         0000000000200200 ffffffff80428318 0000000000000000 ffffff0000000000
         0000000000538c88 0000000000000000 ffffffff800c4400 0000000000000000
         0000000000020000 0000000000000000 0000000000000000 0000000000000000
         0000000000000000 ffffffff8008f844 0000000000538c88 0000000000538b48
         ffffffffffffffff 0000000000000000 0000000000538c88 0000000000000000
         ffffffff80081d10 ffffffff800980c8 0000000000000000 ffffffff900064e0
         0000000000000000 0000000000000000 0000000000000003 000000007fb0ce70
         0000000000000000 0000000000000000 0000000000000002 0000000000000001
         0000000000000000 0000000000000000 0000000000000000 0000000000000000
         ...
 Call Trace:
  [<ffffffff800af118>] default_wake_function+0x0/0x20
  [<ffffffff800c4400>] sys_rt_sigprocmask+0x98/0x130
  [<ffffffff8008f844>] sys32_rt_sigprocmask+0x4c/0x190
  [<ffffffff80081d10>] work_notifysig+0xc/0x14
  [<ffffffff800980c8>] handle_sys+0x128/0x144
 
 
 Code: ffbf00c0  ffb300b8  ffb200b0 <dca20100> 24030010  30420018  00a0802d  1043000b  0080882d 
 CPU 0 Unable to handle kernel paging request at virtual address 0000000000000100, epc == ffffffff8008e8a8, ra == ffffffff80081d10
 Oops[#2]:
 Cpu 0
 $ 0   : 0000000000000000 ffffffff900064e1 9800000007ed80c8 ffffffff803a25d8
 $ 4   : 9800000007fa7eb0 0000000000000000 0000000000000004 9800000007fa1d20
 $ 8   : 0000000000000000 9800000007fa7e60 0000000000000000 0000000000443868
 $12   : 0000000000000000 0000000000000003 ffffffff8008f7f8 9800000007864000
 $16   : ffffffffffffffff 0000000000000000 0000000000538c88 0000000000000000
 $20   : 0000000000000000 00000000000002b4 0000000000440000 00000000005297e4
 $24   : 0000000000000000 ffffffff8008e890                                  
 $28   : 9800000007fa4000 9800000007fa7de0 0000000000522900 ffffffff80081d10
 Hi    : 0000000000000000
 Lo    : 0000000000000078
 epc   : ffffffff8008e8a8 do_signal32+0x18/0x2a0     Not tainted
 ra    : ffffffff80081d10 work_notifysig+0xc/0x14
 Status: 900064e2    KX SX UX KERNEL EXL 
 Cause : 00808408
 BadVA : 0000000000000100
 PrId  : 000028a0
 Process default.hotplug (pid: 687, threadinfo=9800000007fa4000, task=9800000007ed80c8)
 Stack : 0003000200000000 9800000007ed80c8 ffffffff800af118 0000000000100100
         0000000000200200 0000000000000012 0000000000000000 ffffff0000000000
         0000000000538c88 0000000000000000 ffffffff800c4400 0000000000000000
         0000000000020000 0000000000000000 0000000000000000 0000000000000000
         0000000000000000 ffffffff8008f844 0000000000538c88 0000000000538b48
         ffffffffffffffff 0000000000000000 0000000000538c88 0000000000000000
         ffffffff80081d10 ffffffff800980c8 0000000000000000 ffffffff900064e0
         0000000000000000 0000000000000000 0000000000000003 000000007fd0fe70
         0000000000000000 0000000000000000 0000000000000002 0000000000000001
         0000000000000000 0000000000000000 0000000000000000 0000000000000000
         ...
 Call Trace:
  [<ffffffff800af118>] default_wake_function+0x0/0x20
  [<ffffffff800c4400>] sys_rt_sigprocmask+0x98/0x130
  [<ffffffff8008f844>] sys32_rt_sigprocmask+0x4c/0x190
  [<ffffffff80081d10>] work_notifysig+0xc/0x14
  [<ffffffff800980c8>] handle_sys+0x128/0x144
 
 
 Code: ffbf00c0  ffb300b8  ffb200b0 <dca20100> 24030010  30420018  00a0802d  1043000b  0080882d 
 CPU 0 Unable to handle kernel paging request at virtual address 0000000000000100, epc == ffffffff8008e8a8, ra == ffffffff80081d10
 Oops[#3]:
 Cpu 0
 $ 0   : 0000000000000000 ffffffff900064e0 9800000007ed98c8 ffffffff803a25d8
 $ 4   : 9800000007edfeb0 0000000000000000 0000000000000004 0000000000000000
 $ 8   : ffffffff80428770 ffffffff80430000 98000000012d1000 ffffffff80420000
 $12   : 0000000000000000 000000000000000b 0000000000000000 ffffffff80430000
 $16   : ffffffffffffffff 0000000000000004 0000000000000080 000000007fb0d190
 $20   : 0000000000000003 0000000000538468 0000000000000000 0000000000000000
 $24   : 0000000000000018 ffffffff8008e890                                  
 $28   : 9800000007edc000 9800000007edfde0 0000000000000001 ffffffff80081d10
 Hi    : 00000000000168cc
 Lo    : 0000000000007844
 epc   : ffffffff8008e8a8 do_signal32+0x18/0x2a0     Not tainted
 ra    : ffffffff80081d10 work_notifysig+0xc/0x14
 Status: 900064e2    KX SX UX KERNEL EXL 
 Cause : 00808008
 BadVA : 0000000000000100
 PrId  : 000028a0
 Process default.hotplug (pid: 683, threadinfo=9800000007edc000, task=9800000007ed98c8)
 Stack : 9800000007f387c0 000000007fb0d190 0000000000000000 0000000000000080
         9800000007fc4f20 0000000000000001 98000000007c2b40 000000000000000b
         0000000000000003 0000000000538468 0000000000000000 0000000000000000
         0000000000000001 ffffffff80104754 fffffffffffffff7 000000007fb0d190
         9800000007f387c0 000000007fb0d190 ffffffff8010535c 9800000007f383c0
         ffffffffffffffff 0000000000000004 0000000000000080 000000007fb0d190
         ffffffff80081d10 ffffffff800980c8 0000000000000000 ffffffffb00064e1
         000000000000000b 0000000000000003 0000000000000003 000000007fb0d190
         0000000000000080 0000000000000000 0000000000000000 0000000000442fa8
         0000000000000000 0000000000000001 0000000000000000 0000000000000001
         ...
 Call Trace:
  [<ffffffff80104754>] vfs_read+0x11c/0x178
  [<ffffffff8010535c>] sys_read+0x4c/0x90
  [<ffffffff80081d10>] work_notifysig+0xc/0x14
  [<ffffffff800980c8>] handle_sys+0x128/0x144
  [<ffffffff8008f7f8>] sys32_rt_sigprocmask+0x0/0x190
 
 
 Code: ffbf00c0  ffb300b8  ffb200b0 <dca20100> 24030010  30420018  00a0802d  1043000b  0080882d 
 CPU 0 Unable to handle kernel paging request at virtual address 0000000000000100, epc == ffffffff8008e8a8, ra == ffffffff80081d10
 Oops[#4]:
 Cpu 0
 $ 0   : 0000000000000000 ffffffff900064e1 980000000052f2a8 ffffffff803a25d8
 $ 4   : 9800000007c17eb0 0000000000000000 0000000000000004 98000000005142a0
 $ 8   : 0000000000000000 9800000007c17e60 0000000000000000 0000000000443868
 $12   : 0000000000000000 0000000000000003 ffffffff8008f7f8 00000000004404f8
 $16   : ffffffffffffffff 0000000000000000 0000000000537fa8 000000000000008b
 $20   : 0000000000000000 00000000000002ab 0000000000440000 00000000005297e4
 $24   : 0000000000000000 ffffffff8008e890                                  
 $28   : 9800000007c14000 9800000007c17de0 0000000000522900 ffffffff80081d10
 Hi    : 0000000000000054
 Lo    : 000000000001b3bc
 epc   : ffffffff8008e8a8 do_signal32+0x18/0x2a0     Not tainted
 ra    : ffffffff80081d10 work_notifysig+0xc/0x14
 Status: 900064e2    KX SX UX KERNEL EXL 
 Cause : 00808008
 BadVA : 0000000000000100
 PrId  : 000028a0
 Process hotplug (pid: 679, threadinfo=9800000007c14000, task=980000000052f2a8)
 Stack : 0000000000000000 ffffffff80430000 0000000000000000 ffffffff80430000
         ffffffff80430000 fffffffffffffffe 0000000000000000 ffffff0000000000
         0000000000537fa8 000000000000008b ffffffff800c4400 ffffffff80430000
         0000000000020000 0000000000000000 0000000000000000 0000000000000000
         0000000000000000 ffffffff8008f844 000000000052ae5c 0000000000522924
         ffffffffffffffff 0000000000000000 0000000000537fa8 000000000000008b
         ffffffff80081d10 ffffffff800980c8 0000000000000000 000000002ac4311c
         0000000000000000 0000000000000000 0000000000000003 000000007ff6a3e8
         0000000000000000 0000000000000000 0000000000000002 000000002aaff270
         0000000000000000 0000000000000001 0000000000000000 ffffffff80000010
         ...
 Call Trace:
  [<ffffffff800c4400>] sys_rt_sigprocmask+0x98/0x130
  [<ffffffff8008f844>] sys32_rt_sigprocmask+0x4c/0x190
  [<ffffffff80081d10>] work_notifysig+0xc/0x14
  [<ffffffff800980c8>] handle_sys+0x128/0x144
  [<ffffffff801053a0>] sys_write+0x0/0x90
  [<ffffffff800c39f8>] flush_signals+0x98/0xd0
 
 
 Code: ffbf00c0  ffb300b8  ffb200b0 <dca20100> 24030010  30420018  00a0802d  1043000b  0080882d 
 CPU 0 Unable to handle kernel paging request at virtual address 0000000000000100, epc == ffffffff8008e8a8, ra == ffffffff80081d10
 Oops[#5]:
 Cpu 0
 $ 0   : 0000000000000000 ffffffff900064e0 980000000052e6a8 ffffffff803a25d8
 $ 4   : 9800000007e3beb0 0000000000000000 0000000000000004 0000000000000000
 $ 8   : ffffffff80428770 ffffffff80430000 98000000012d1000 ffffffff80420000
 $12   : 0000000000000000 000000000000000b 0000000000000000 ffffffff80430000
 $16   : ffffffffffffffff 0000000000000004 0000000000000080 000000007fd10190
 $20   : 0000000000000003 0000000000538468 0000000000000000 0000000000000000
 $24   : 0000000000000018 ffffffff8008e890                                  
 $28   : 9800000007e38000 9800000007e3bde0 0000000000000001 ffffffff80081d10
 Hi    : 0000000000017f79
 Lo    : 0000000000007fd3
 epc   : ffffffff8008e8a8 do_signal32+0x18/0x2a0     Not tainted
 ra    : ffffffff80081d10 work_notifysig+0xc/0x14
 Status: 900064e2    KX SX UX KERNEL EXL 
 Cause : 00808008
 BadVA : 0000000000000100
 PrId  : 000028a0
 Process default.hotplug (pid: 681, threadinfo=9800000007e38000, task=980000000052e6a8)
 Stack : 9800000007f388c0 000000007fd10190 0000000000000000 0000000000000080
         9800000007d880c0 0000000000000001 9800000000554090 000000000000000b
         0000000000000003 0000000000538468 0000000000000000 0000000000000000
         0000000000000001 ffffffff80104754 fffffffffffffff7 000000007fd10190
         9800000007f388c0 000000007fd10190 ffffffff8010535c 9800000007f384c0
         ffffffffffffffff 0000000000000004 0000000000000080 000000007fd10190
         ffffffff80081d10 ffffffff800980c8 0000000000000000 ffffffffb00064e1
         000000000000000b 0000000000000003 0000000000000003 000000007fd10190
         0000000000000080 0000000000000000 0000000000000000 0000000000442fa8
         0000000000000000 0000000000000001 0000000000000000 0000000000000001
         ...
 Call Trace:
  [<ffffffff80104754>] vfs_read+0x11c/0x178
  [<ffffffff8010535c>] sys_read+0x4c/0x90
  [<ffffffff80081d10>] work_notifysig+0xc/0x14
  [<ffffffff800980c8>] handle_sys+0x128/0x144
  [<ffffffff8008f7f8>] sys32_rt_sigprocmask+0x0/0x190
 
 
 Code: ffbf00c0  ffb300b8  ffb200b0 <dca20100> 24030010  30420018  00a0802d  1043000b  0080882d 
 CPU 0 Unable to handle kernel paging request at virtual address 0000000000000100, epc == ffffffff8008e8a8, ra == ffffffff80081d10
 Oops[#6]:
 Cpu 0
 $ 0   : 0000000000000000 ffffffff900064e1 9800000001323288 ffffffff803a25d8
 $ 4   : 9800000001333eb0 0000000000000000 0000000000000004 98000000005147e0
 $ 8   : 0000000000000000 9800000001333e60 0000000000000000 0000000000443868
 $12   : 0000000000000000 0000000000000003 ffffffff8008f7f8 00000000004404f8
 $16   : ffffffffffffffff 0000000000000000 0000000000537fc8 000000000000008b
 $20   : 0000000000000000 00000000000002a9 0000000000440000 00000000005297e4
 $24   : 0000000000000000 ffffffff8008e890                                  
 $28   : 9800000001330000 9800000001333de0 0000000000522900 ffffffff80081d10
 Hi    : 0000000000000054
 Lo    : 000000000001b3bc
 epc   : ffffffff8008e8a8 do_signal32+0x18/0x2a0     Not tainted
 ra    : ffffffff80081d10 work_notifysig+0xc/0x14
 Status: 900064e2    KX SX UX KERNEL EXL 
 Cause : 00808008
 BadVA : 0000000000000100
 PrId  : 000028a0
 Process hotplug (pid: 677, threadinfo=9800000001330000, task=9800000001323288)
 Stack : 0000000000000000 ffffffff80430000 0000000000000000 ffffffff80430000
         ffffffff80430000 fffffffffffffffe 0000000000000000 ffffff0000000000
         0000000000537fc8 000000000000008b ffffffff800c4400 ffffffff80430000
         0000000000020000 0000000000000000 0000000000000000 0000000000000000
         0000000000000000 ffffffff8008f844 000000002aac0cb8 0000000000000000
         ffffffffffffffff 0000000000000000 0000000000537fc8 000000000000008b
         ffffffff80081d10 ffffffff800980c8 0000000000000000 ffffffff900064e0
         0000000000000000 0000000000000000 0000000000000003 000000007fa623e8
         0000000000000000 0000000000000000 0000000000000002 000000002aaff270
         0000000000000000 0000000000000001 0000000000000000 0000000000000000
         ...
 Call Trace:
  [<ffffffff800c4400>] sys_rt_sigprocmask+0x98/0x130
  [<ffffffff8008f844>] sys32_rt_sigprocmask+0x4c/0x190
  [<ffffffff80081d10>] work_notifysig+0xc/0x14
  [<ffffffff800980c8>] handle_sys+0x128/0x144
  [<ffffffff800c39f8>] flush_signals+0x98/0xd0
 
 
 Code: ffbf00c0  ffb300b8  ffb200b0 <dca20100> 24030010  30420018  00a0802d  1043000b  0080882d 
 CPU 0 Unable to handle kernel paging request at virtual address 0000000000000100, epc == ffffffff8008e8a8, ra == ffffffff80081d10
 Oops[#7]:
 Cpu 0
 $ 0   : 0000000000000000 ffffffff900064e1 9800000007fc8ce8 ffffffff803a25d8
 $ 4   : 980000000780feb0 0000000000000000 0000000000000004 9800000007fa1540
 $ 8   : 0000000000000000 980000000780fe60 0000000000000000 0000000000443868
 $12   : 0000000000000000 0000000000000003 ffffffff8008f7f8 9800000007830000
 $16   : ffffffffffffffff 0000000000000000 0000000000538c88 0000000000000000
 $20   : 0000000000000000 00000000000002b3 0000000000440000 00000000005297e4
 $24   : 0000000000000000 ffffffff8008e890                                  
 $28   : 980000000780c000 980000000780fde0 0000000000522900 ffffffff80081d10
 Hi    : 0000000000000000
 Lo    : 0000000000000078
 epc   : ffffffff8008e8a8 do_signal32+0x18/0x2a0     Not tainted
 ra    : ffffffff80081d10 work_notifysig+0xc/0x14
 Status: 900064e2    KX SX UX KERNEL EXL 
 Cause : 00808008
 BadVA : 0000000000000100
 PrId  : 000028a0
 Process default.hotplug (pid: 690, threadinfo=980000000780c000, task=9800000007fc8ce8)
 Stack : 0000000000000000 ffffffff80430000 0000000000000000 ffffffff80430000
         ffffffff80430000 fffffffffffffffe 0000000000000000 ffffff0000000000
         0000000000538c88 0000000000000000 ffffffff800c4400 ffffffff80430000
         0000000000020000 0000000000000000 0000000000000000 0000000000000000
         0000000000000000 ffffffff8008f844 000000000052ae5c 0000000000522924
         ffffffffffffffff 0000000000000000 0000000000538c88 0000000000000000
         ffffffff80081d10 ffffffff800980c8 0000000000000000 ffffffff900064e0
         0000000000000000 0000000000000000 0000000000000003 000000007fa3ce70
         0000000000000000 0000000000000000 0000000000000002 0000000000000001
         0000000000000000 0000000000000000 0000000000000000 0000000000000000
         ...
 Call Trace:
  [<ffffffff800c4400>] sys_rt_sigprocmask+0x98/0x130
  [<ffffffff8008f844>] sys32_rt_sigprocmask+0x4c/0x190
  [<ffffffff80081d10>] work_notifysig+0xc/0x14
  [<ffffffff800980c8>] handle_sys+0x128/0x144
 
 
 Code: ffbf00c0  ffb300b8  ffb200b0 <dca20100> 24030010  30420018  00a0802d  1043000b  0080882d 
 CPU 0 Unable to handle kernel paging request at virtual address 0000000000000100, epc == ffffffff8008e8a8, ra == ffffffff80081d10
 Oops[#8]:
 Cpu 0
 $ 0   : 0000000000000000 ffffffff900064e0 980000000052e0a8 ffffffff803a25d8
 $ 4   : 9800000007e5beb0 0000000000000000 0000000000000004 98000000011a45b0
 $ 8   : 0000000000000001 0000000000000001 0000000000000018 ffffffff80420000
 $12   : 0000000000000000 0000000000006400 0000000000000000 980000000780c000
 $16   : 000000000000000a 0000000000000004 0000000000000080 000000007fa3d190
 $20   : 0000000000000003 000000007fa3d19b 000000000053b508 0000000000000000
 $24   : 0000000000000020 ffffffff8008e890                                  
 $28   : 9800000007e58000 9800000007e5bde0 0000000000000001 ffffffff80081d10
 Hi    : 0000000000000000
 Lo    : 0000000000000018
 epc   : ffffffff8008e8a8 do_signal32+0x18/0x2a0     Not tainted
 ra    : ffffffff80081d10 work_notifysig+0xc/0x14
 Status: 900064e2    KX SX UX KERNEL EXL 
 Cause : 00808008
 BadVA : 0000000000000100
 PrId  : 000028a0
 Process default.hotplug (pid: 682, threadinfo=9800000007e58000, task=980000000052e0a8)
 Stack : 9800000007f386c0 000000007fa3d190 9800000007e5be88 0000000000000080
         0000000000000003 000000007fa3d19b 000000000053b508 0000000000000000
         0000000000000001 ffffffff80117174 000000007fa3d190 0000000000000080
         ffffffff801046f8 ffffffff801046d0 fffffffffffffff7 000000007fa3d190
         9800000007f386c0 000000007fa3d190 ffffffff8010535c 0000000000000080
         000000000000000a 0000000000000004 0000000000000080 000000007fa3d190
         ffffffff80081d10 ffffffff800980c8 0000000000000000 ffffffff900064e0
         0000000000000000 000000000000000c 0000000000000003 000000007fa3d190
         0000000000000080 0000000000000000 0000000000000000 0000000000000000
         98000000012d1000 000000000000000b 0000000000000000 000000000000000b
         ...
 Call Trace:
  [<ffffffff80117174>] pipe_read+0x1c/0x28
  [<ffffffff801046f8>] vfs_read+0xc0/0x178
  [<ffffffff801046d0>] vfs_read+0x98/0x178
  [<ffffffff8010535c>] sys_read+0x4c/0x90
  [<ffffffff80081d10>] work_notifysig+0xc/0x14
  [<ffffffff800980c8>] handle_sys+0x128/0x144
 
 
 Code: ffbf00c0  ffb300b8  ffb200b0 <dca20100> 24030010  30420018  00a0802d  1043000b  0080882d 
 CPU 0 Unable to handle kernel paging request at virtual address 0000000000000100, epc == ffffffff8008e8a8, ra == ffffffff80081d10
 Oops[#9]:
 Cpu 0
 $ 0   : 0000000000000000 ffffffff900064e1 9800000001322088 ffffffff803a25d8
 $ 4   : 980000000051feb0 0000000000000000 0000000000000004 9800000000514540
 $ 8   : 0000000000000000 980000000051fe60 0000000000000000 0000000000443868
 $12   : 0000000000000000 0000000000000003 ffffffff8008f7f8 00000000004404f8
 $16   : ffffffffffffffff 0000000000000000 0000000000537fa8 000000000000008b
 $20   : 0000000000000000 00000000000002aa 0000000000440000 00000000005297e4
 $24   : 0000000000000000 ffffffff8008e890                                  
 $28   : 980000000051c000 980000000051fde0 0000000000522900 ffffffff80081d10
 Hi    : 0000000000000054
 Lo    : 000000000001b3bc
 epc   : ffffffff8008e8a8 do_signal32+0x18/0x2a0     Not tainted
 ra    : ffffffff80081d10 work_notifysig+0xc/0x14
 Status: 900064e2    KX SX UX KERNEL EXL 
 Cause : 00808008
 BadVA : 0000000000000100
 PrId  : 000028a0
 Process hotplug (pid: 678, threadinfo=980000000051c000, task=9800000001322088)
 Stack : 0000000000000000 ffffffff80430000 0000000000000000 ffffffff80430000
         ffffffff80430000 fffffffffffffffe 0000000000000000 ffffff0000000000
         0000000000537fa8 000000000000008b ffffffff800c4400 ffffffff80430000
         0000000000020000 0000000000000000 0000000000000000 0000000000000000
         0000000000000000 ffffffff8008f844 00000000004e0000 0000000000537fa8
         ffffffffffffffff 0000000000000000 0000000000537fa8 000000000000008b
         ffffffff80081d10 ffffffff800980c8 0000000000000000 ffffffff900064e0
         0000000000000000 0000000000000000 0000000000000003 000000007f9a23e8
         0000000000000000 0000000000000000 0000000000000002 000000002aaff270
         0000000000000000 0000000000000001 0000000000000000 0000000000000000
         ...
 Call Trace:
  [<ffffffff800c4400>] sys_rt_sigprocmask+0x98/0x130
  [<ffffffff8008f844>] sys32_rt_sigprocmask+0x4c/0x190
  [<ffffffff80081d10>] work_notifysig+0xc/0x14
  [<ffffffff800980c8>] handle_sys+0x128/0x144
  [<ffffffff800c39f8>] flush_signals+0x98/0xd0
 
 
 Code: ffbf00c0  ffb300b8  ffb200b0 <dca20100> 24030010  30420018  00a0802d  1043000b  0080882d 
 CPU 0 Unable to handle kernel paging request at virtual address 0000000000000100, epc == ffffffff8008e8a8, ra == ffffffff80081d10
 Oops[#10]:
 Cpu 0
 $ 0   : 0000000000000000 ffffffff900064e0 980000000045d848 ffffffff803a25d8
 $ 4   : 9800000000463eb0 0000000000000000 0000000000000004 0000000000000000
 $ 8   : 9800000007892788 9800000000463c10 0004ce78440afdbf 0000000000000000
 $12   : 0000000000000000 9800000000463cc0 0000000000000180 ffffffff80430000
 $16   : 000000007fe058e0 000000002ad80000 000000007fe056ec 000000002ad70000
 $20   : 000000007fe058e0 0000000000000180 000000002ad06fc0 0000000000000000
 $24   : 0000000000000004 ffffffff8008e890                                  
 $28   : 9800000000460000 9800000000463de0 000000007fe054cc ffffffff80081d10
 Hi    : 0000000000016a88
 Lo    : 00000000000078d8
 epc   : ffffffff8008e8a8 do_signal32+0x18/0x2a0     Not tainted
 ra    : ffffffff80081d10 work_notifysig+0xc/0x14
 Status: 900064e2    KX SX UX KERNEL EXL 
 Cause : 00808008
 BadVA : 0000000000000100
 PrId  : 000028a0
 Process init (pid: 1, threadinfo=9800000000460000, task=980000000045d848)
 Stack : 0000000000000007 0000000000000000 0000000000000000 9800000000463e60
         980000000071e460 0000000000000001 9800000007d65db0 0000000000000180
         000000007fe058e0 0000000000000180 000000002ad06fc0 0000000000000000
         000000007fe054cc ffffffff80104754 fffffffffffffff7 000000007fe056ec
         98000000078926e0 000000002ad70000 ffffffff8010535c 0000000000000000
         000000007fe058e0 000000002ad80000 000000007fe056ec 000000002ad70000
         ffffffff80081d10 ffffffff800980c8 0000000000000000 ffffffff900064e0
         0000000000000180 0000000000000005 0000000000000000 000000007fe056ec
         0000000000000180 0000000000000000 0000000000000000 0000000000402b24
         0000000000000000 0000000000000001 0000000000000000 ffffffff80000010
         ...
 Call Trace:
  [<ffffffff80104754>] vfs_read+0x11c/0x178
  [<ffffffff8010535c>] sys_read+0x4c/0x90
  [<ffffffff80081d10>] work_notifysig+0xc/0x14
  [<ffffffff800980c8>] handle_sys+0x128/0x144
  [<ffffffff8008bbb0>] sys32_llseek+0x0/0x30
 
 
 Code: ffbf00c0  ffb300b8  ffb200b0 <dca20100> 24030010  30420018  00a0802d  1043000b  0080882d 
 Kernel panic - not syncing: Attempted to kill init!
  

-- 
Martin Michlmayr
http://www.cyrius.com/
