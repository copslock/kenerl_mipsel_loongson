Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Apr 2005 12:34:30 +0100 (BST)
Received: from mail.timesys.com ([IPv6:::ffff:65.117.135.102]:53844 "EHLO
	exchange.timesys.com") by linux-mips.org with ESMTP
	id <S8225268AbVDELeM>; Tue, 5 Apr 2005 12:34:12 +0100
Received: from [192.168.2.27] ([192.168.2.27]) by exchange.timesys.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Tue, 5 Apr 2005 07:30:06 -0400
Message-ID: <425277B1.7080501@timesys.com>
Date:	Tue, 05 Apr 2005 07:34:09 -0400
From:	Greg Weeks <greg.weeks@timesys.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: malta 4kc bus error
Content-Type: multipart/mixed;
 boundary="------------010002090203000601090901"
X-OriginalArrivalTime: 05 Apr 2005 11:30:06.0656 (UTC) FILETIME=[D1414C00:01C539D2]
Return-Path: <greg.weeks@timesys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7594
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg.weeks@timesys.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------010002090203000601090901
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Now I'm seeing a bus error on the Malta. This is the same set-up. 4kc 
processor and the tree is a sync against the Malta tree on Friday with 
the tlb patch from Monday.

Greg Weeks

--------------010002090203000601090901
Content-Type: text/plain;
 name="malta.oops.be.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="malta.oops.be.txt"

YAMON ROM Monitor, Revision 02.06.
Copyright (c) 1999-2004 MIPS Technologies, Inc. - All Rights Reserved.
 
For a list of available commands, type 'help'.
 
Compilation time =              Mar 23 2004  16:50:44
Board type/revision =           0x02 (Malta) / 0x00
Core board type/revision =      0x01 (CoreLV) / 0x01
System controller/revision =    Galileo / GT_64120A-B-1
FPGA revision =                 0x0001
MAC address =                   00.d0.a0.00.01.9a
Board S/N =                     0000000162
PCI bus frequency =             33.33 MHz
Processor Company ID/options =  0x01 (MIPS Technologies, Inc.) / 0x00
Processor ID/revision =         0x80 (MIPS 4Kc) / 0x01
Endianness =                    Little
CPU/Bus frequency =             80 MHz / 40 MHz
Flash memory size =             4 MByte
SDRAM size =                    64 MByte
First free SDRAM address =      0x800b3850
 
YAMON> load
About to load tftp://192.168.25.2/vmlinux.srec
Press Ctrl-C to break
........................................
........................................
........................................
........................................
........................................
........................................
........................................
........................................
........................................
.................
Start = 0x803d2000, range = (0x80100000,0x803f5085), format = SREC
YAMON> go . ip=dhcp
 
LINUX started...
Config serial console: console=ttyS0,38400n8r
Linux version 2.6.12-rc1 (gweeks@tanith.timesys.com) (gcc version 3.4.1 20040714 (TimeSys 3.4.1-7)) #1 Mon Apr 4 15:21:59 EDT 2005
CPU revision is: 00018001
Determined physical RAM map:
 memory: 00001000 @ 00000000 (reserved)
 memory: 000ef000 @ 00001000 (ROM data)
 memory: 00329000 @ 000f0000 (reserved)
 memory: 03be7000 @ 00419000 (usable)
Built 1 zonelists
Kernel command line: ip=dhcp console=ttyS0,38400n8r
Primary instruction cache 16kB, physically tagged, 4-way, linesize 16 bytes.
Primary data cache 16kB, 4-way, linesize 16 bytes.
Synthesized TLB refill handler (19 instructions).
Synthesized TLB load handler fastpath (31 instructions).
Synthesized TLB store handler fastpath (31 instructions).
Synthesized TLB modify handler fastpath (30 instructions).
PID hash table entries: 512 (order: 9, 8192 bytes)
CPU frequency 80.00 MHz
Using 40.001 MHz high precision timer.
Console: colour dummy device 80x25
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 60672k/61340k available (2227k kernel code, 628k reserved, 656k data, 144k init, 0k highmem)
Mount-cache hash table entries: 512
Checking for 'wait' instruction...  available.
NET: Registered protocol family 16
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
rtc: SRM (post-2000) epoch (2000) detected
Real Time Clock Driver v1.12a
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
pcnet32.c:v1.30i 06.28.2004 tsbogend@alpha.franken.de
pcnet32: PCnet/FAST III 79C973 at 0x1060, 00 d0 a0 00 01 9a assigned IRQ 10.
eth0: registered as PCnet/FAST III 79C973
pcnet32: 1 cards_found.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:0a.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1080-0x1087, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x1088-0x108f, BIOS settings: hdc:pio, hdd:pio
hda: IBM-DTLA-307075, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 150136560 sectors (76869 MB) w/1916KiB Cache, CHS=65535/16/63, UDMA(33)
hda: cache flushes not supported
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP established hash table entries: 4096 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
eth0: link up, 100Mbps, half-duplex, lpa 0x40A1
Sending DHCP requests ., OK
IP-Config: Got DHCP answer from 192.168.25.2, my address is 192.168.25.4
IP-Config: Complete:
      device=eth0, addr=192.168.25.4, mask=255.255.255.0, gw=255.255.255.255,
     host=192.168.25.4, domain=, nis-domain=(none),
     bootserver=192.168.25.2, rootserver=192.168.25.2, rootpath=/opt/timesys/linux/6.0/mipsel-std/rfs
Looking up port of RPC 100003/2 on 192.168.25.2
Looking up port of RPC 100005/1 on 192.168.25.2
VFS: Mounted root (nfs filesystem) readonly.
Freeing prom memory: 956kb freed
Freeing unused kernel memory: 1100k freed
Algorithmics/MIPS FPU Emulator v1.5
INIT: version 2.84 booting
Executing first boot commands
mount: directory to mount not in host:dir format
mount: directory to mount not in host:dir format
 
                Welcome to TimeSys release 1.0 (distbuilder)
 
Making extra nodes:  [  OK  ][  OK  ]
Starting udev:  [  OK  ]
Initializing hardware...  storage network audio done[  OK  ]
raidautorun: failed to open /dev/md0: 6
Configuring kernel parameters:  [  OK  ]
Setting clock : Mon Apr  4 20:28:54 UTC 2005 [  OK  ]
Setting hostname timesys-bsp:  [  OK  ]
Remounting root filesystem in read-write mode:  [  OK  ]
Checking filesystems
Checking all file systems.
[  OK  ]
Mounting local filesystems:  [  OK  ]
Enabling swap space:  [  OK  ]
INIT: Entering runlevel: 3
Entering non-interactive startup
Setting network parameters:  [  OK  ]
Bringing up loopback interface:  Data bus error, epc == 80228860, ra == 80177ce4Oops in arch/mips/kernel/traps.c::do_be, line 336[#1]:
Cpu 0
$ 0   : 00000000 1000e94b 1000e96b 00000000
$ 4   : 83ffffa0 1000e929 00000012 1000e94b
$ 8   : 003d4457 00637465 00000001 3d445750
$12   : 00000001 83c21d68 00000080 70000000
$16   : 00000023 00000f9f 83ffff9f 00000023
$20   : 1000e928 0001ff9f 00000000 10013af4
$24   : 00000002 8107a600
$28   : 83c20000 83c21ea0 83fff000 80177ce4
Hi    : 10624430
Lo    : 4fdf32f6
epc   : 80228860 src_unaligned_dst_aligned+0x20/0x5c     Not tainted
ra    : 80177ce4 copy_strings+0xf8/0x24c
Status: 1000fc03    KERNEL EXL IE
Cause : 0080201c
PrId  : 00018001
Modules linked in:
Process ifup (pid: 1610, threadinfo=83c20000, task=806f8b78)
Stack : 80000000 10013ad8 81273200 00000080 8107ffe0 83c21f30 8111e000 10013ad8
        81273200 00000000 10014800 83c21f30 ffffffff 10013ad8 10013e80 80179404
        00000007 8012897c 81273200 8017b4b8 8111e000 8111e000 10013ad8 10014150
        00000000 10014150 8010631c 801062f4 0000006a 10006fec 00000000 10014150
        10014150 10014800 8010a060 80100f50 10014150 10014800 10013ad8 2ad23d94
        ...
Call Trace:
 [<80179404>] do_execve+0x118/0x224
 [<8012897c>] __do_softirq+0x8c/0x14c
 [<8017b4b8>] getname+0x28/0xf8
 [<8010631c>] sys_execve+0x50/0x7c
 [<801062f4>] sys_execve+0x28/0x7c
 [<8010a060>] stack_done+0x20/0x3c
 [<80100f50>] mipsIRQ+0x110/0x180
                                  
 
Code: 98a80000  98a90004  24c6fff0 <88a80003> 88a90007  98aa0008  98ab000c  88aa000b  88ab000f
CoreHI interrupt, shouldn't happen, so we die here!!!
epc   : 80128944
Status: 1000fc03
Cause : 10802000
badVaddr : 80107248
GT_INTRCAUSE = 40000009
GT_CPUERR_ADDR = 0004000000
CoreHi interrupt in arch/mips/mips-boards/malta/malta_int.c::corehi_irqdispatch, line 180[#2]:
Cpu 0
$ 0   : 00000000 1000fc01 00000100 00000002
$ 4   : 00000000 00000000 00000078 00000059
$ 8   : 06f4c980 000f4237 806f8b78 80400000
$12   : 80400000 fffffffe ffffffff 00000010
$16   : 00000002 1000fc00 83c21df0 00000004
$20   : 0000000a 80400000 80400000 10013af4
$24   : 00000007 83c21c08
$28   : 83c20000 83c21ca8 83fff000 80128ac8
Hi    : 00000000
Lo    : 00000000
epc   : 80128944 __do_softirq+0x54/0x14c     Not tainted
ra    : 80128ac8 do_softirq+0x8c/0xb8
Status: 1000fc03    KERNEL EXL IE
Cause : 10802000
PrId  : 00018001
Modules linked in:
Process ifup (pid: 1610, threadinfo=83c20000, task=806f8b78)
Stack : 80330000 803f8a36 1000a000 1000fc00 1000fc00 1000fc00 83c21df0 00000004
        1000e928 0001ff9f 00000000 80128ac8 1000e928 0001ff9f 1000a000 1000fc00
        1000a000 80100f50 3b9aca00 00000001 80370000 1000fc00 80370000 80123528
        00000000 1000fc01 00000001 8036c0b8 8036c0b8 8036c0d0 00000001 804042d4
        00001816 8036c0a8 80400000 80400000 80400000 fffffffe ffffffff 00000010
        ...
Call Trace:
 [<80128ac8>] do_softirq+0x8c/0xb8
 [<80100f50>] mipsIRQ+0x110/0x180
 [<80123528>] vprintk+0x334/0x404
 [<80107e9c>] __die+0xb0/0xc8
 [<80107eac>] __die+0xc0/0xc8
 [<80108090>] do_be+0x1b0/0x1f4
 [<80228860>] src_unaligned_dst_aligned+0x20/0x5c
 [<80177ce4>] copy_strings+0xf8/0x24c
 [<801025d4>] handle_dbe_int+0x2c/0x38
 [<80177ce4>] copy_strings+0xf8/0x24c
 [<8016b26c>] vfs_read+0xbc/0x178
 [<80228860>] src_unaligned_dst_aligned+0x20/0x5c
 [<80179404>] do_execve+0x118/0x224
 [<8012897c>] __do_softirq+0x8c/0x14c
 [<8017b4b8>] getname+0x28/0xf8
 [<8010631c>] sys_execve+0x50/0x7c
 [<801062f4>] sys_execve+0x28/0x7c
 [<8010a060>] stack_done+0x20/0x3c
 [<80100f50>] mipsIRQ+0x110/0x180
                                  
 
Code: 3421001f  3821001e  40816000 <3c028040> 2453ea50  26d1cf48  0804a258  24120001  1200000a
Kernel panic - not syncing: Aiee, killing interrupt handler!
                                                             


--------------010002090203000601090901--
