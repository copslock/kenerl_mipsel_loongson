Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Apr 2005 18:11:17 +0100 (BST)
Received: from mail.timesys.com ([IPv6:::ffff:65.117.135.102]:18043 "EHLO
	exchange.timesys.com") by linux-mips.org with ESMTP
	id <S8224923AbVDFRK4>; Wed, 6 Apr 2005 18:10:56 +0100
Received: from [192.168.2.27] ([192.168.2.27]) by exchange.timesys.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Wed, 6 Apr 2005 13:06:43 -0400
Message-ID: <4254181A.9000301@timesys.com>
Date:	Wed, 06 Apr 2005 13:10:50 -0400
From:	Greg Weeks <greg.weeks@timesys.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: 4kc machine check
Content-Type: multipart/mixed;
 boundary="------------000705020200040604050105"
X-OriginalArrivalTime: 06 Apr 2005 17:06:43.0937 (UTC) FILETIME=[022F8D10:01C53ACB]
Return-Path: <greg.weeks@timesys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7613
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg.weeks@timesys.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------000705020200040604050105
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I noticed there was a recent checkin for 4000 series tlb code. It still 
seems to be a problem on the 4kc malta.

Greg Weeks



--------------000705020200040604050105
Content-Type: text/plain;
 name="malta.mc.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="malta.mc.txt"

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
.............
Start = 0x803ca000, range = (0x80100000,0x803ec085), format = SREC
YAMON> go . root=/dev/hda1
 
LINUX started...
Config serial console: console=ttyS0,38400n8r
Linux version 2.6.12-rc1 (gweeks@tanith.timesys.com) (gcc version 3.4.1 20040714 (TimeSys 3.4.1-7)) #1 Wed Apr 6 13:06:34 EDT 2005
CPU revision is: 00018001
Determined physical RAM map:
 memory: 00001000 @ 00000000 (reserved)
 memory: 000ef000 @ 00001000 (ROM data)
 memory: 00320000 @ 000f0000 (reserved)
 memory: 03bf0000 @ 00410000 (usable)
Built 1 zonelists
Kernel command line: root=/dev/hda1 console=ttyS0,38400n8r
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
Memory: 60672k/61376k available (2199k kernel code, 628k reserved, 652k data, 140k init, 0k highmem)
Mount-cache hash table entries: 512
Checking for 'wait' instruction...  available.
NET: Registered protocol family 16
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
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
 hda: hda1 hda2 hda3
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP established hash table entries: 4096 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing prom memory: 956kb freed
Freeing unused kernel memory: 1096k freed
Algorithmics/MIPS FPU Emulator v1.5
INIT: version 2.84 booting
Got mcheck at 0040240c
Cpu 0
$ 0   : 00000000 1000fc01 000002cd 00000023
$ 4   : 00000802 004084c2 004084c4 00000000
$ 8   : 00000000 00000000 80134390 ffffffec
$12   : 00000000 60e100fe 7efefefc ef4eff08
$16   : 10000560 7fa4cb48 100012a0 7fa4cbc8
$20   : 100012cc 7fa4cc48 7fa4cc48 100012a8
$24   : 8faffff6 0040240c
$28   : 10008270 7fa4ca28 7fa4cb28 004038d4
Hi    : fffffeee
Lo    : 200b02cd
epc   : 0040240c 0x40240c     Not tainted
ra    : 004038d4 0x4038d4
Status: 0020fc13    USER EXL IE
Cause : 00800060
PrId  : 00018001
                 
Index:  1 pgmask=4kb va=2ab82000 asid=07
                        [pa=000bf000 c=3 d=0 v=1 g=0]
                        [pa=00040000 c=3 d=0 v=0 g=0]
                                                      
Index:  2 pgmask=4kb va=00402000 asid=07
                        [pa=004d7000 c=3 d=0 v=0 g=0]
                        [pa=003d6000 c=3 d=0 v=1 g=0]
                                                      
Index:  3 pgmask=4kb va=7fa4c000 asid=07
                        [pa=01198000 c=3 d=1 v=1 g=0]
                        [pa=00000000 c=0 d=0 v=0 g=0]
                                                      
Index:  4 pgmask=4kb va=2acea000 asid=07
                        [pa=000c0000 c=3 d=0 v=1 g=0]
                        [pa=01199000 c=3 d=1 v=1 g=0]
                                                      
Index:  6 pgmask=4kb va=2abd0000 asid=07
                        [pa=000a1000 c=3 d=0 v=0 g=0]
                        [pa=000a2000 c=3 d=0 v=1 g=0]
                                                      
Index:  7 pgmask=4kb va=2abc4000 asid=07
                        [pa=00095000 c=3 d=0 v=0 g=0]
                        [pa=00096000 c=3 d=0 v=1 g=0]
                                                      
Index:  8 pgmask=4kb va=2acec000 asid=07
                        [pa=0119b000 c=3 d=1 v=1 g=0]
                        [pa=00410000 c=3 d=0 v=1 g=0]
                                                      
Index:  9 pgmask=4kb va=10000000 asid=07
                        [pa=00002000 c=3 d=0 v=1 g=0]
                        [pa=0119a000 c=3 d=1 v=1 g=0]
                                                      
Index: 10 pgmask=4kb va=2ace8000 asid=07
                        [pa=0002c000 c=3 d=0 v=1 g=0]
                        [pa=000c2000 c=3 d=0 v=1 g=0]
                                                      
Index: 11 pgmask=4kb va=2abca000 asid=07
                        [pa=0009b000 c=3 d=0 v=1 g=0]
                        [pa=00000000 c=0 d=0 v=0 g=0]
                                                      
Index: 14 pgmask=4kb va=2abce000 asid=07
                        [pa=00000000 c=0 d=0 v=0 g=0]
                        [pa=000a0000 c=3 d=0 v=1 g=0]
                                                      
Index: 15 pgmask=4kb va=2abf2000 asid=07
                        [pa=00000000 c=0 d=0 v=0 g=0]
                        [pa=00075000 c=3 d=0 v=1 g=0]
                                                      
Kernel panic - not syncing: Caught Machine Check exception - caused by multiple matching entries in the TLB.
                             


--------------000705020200040604050105--
