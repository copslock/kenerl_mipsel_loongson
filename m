Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Apr 2005 14:29:11 +0100 (BST)
Received: from mail.timesys.com ([IPv6:::ffff:65.117.135.102]:18781 "EHLO
	exchange.timesys.com") by linux-mips.org with ESMTP
	id <S8226024AbVDDN2y>; Mon, 4 Apr 2005 14:28:54 +0100
Received: from [192.168.2.27] ([192.168.2.27]) by exchange.timesys.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Mon, 4 Apr 2005 09:24:50 -0400
Message-ID: <42514113.9060902@timesys.com>
Date:	Mon, 04 Apr 2005 09:28:51 -0400
From:	Greg Weeks <greg.weeks@timesys.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: malta 4kc machine check
Content-Type: multipart/mixed;
 boundary="------------060304000905080105090008"
X-OriginalArrivalTime: 04 Apr 2005 13:24:50.0640 (UTC) FILETIME=[AE042500:01C53919]
Return-Path: <greg.weeks@timesys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7582
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg.weeks@timesys.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------060304000905080105090008
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I'm getting a machine check on a malta 4kc when userland starts up. This 
was built from a copy of the malta tree from Friday. Has anyone else ran 
into this?

Greg Weeks

--------------060304000905080105090008
Content-Type: text/plain;
 name="malta.fail.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="malta.fail.txt"

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
..............
Start = 0x803cc000, range = (0x80100000,0x803ee084), format = SREC
YAMON> go . ip=dhcp
 
LINUX started...
Config serial console: console=ttyS0,38400n8r
Linux version 2.6.12-rc1 (gweeks@tanith.timesys.com) (gcc version 3.4.1 20040714 (TimeSys 3.4.1-7)) #2 Mon Apr 4 09:15:04 EDT 2005
CPU revision is: 00018001
Determined physical RAM map:
 memory: 00001000 @ 00000000 (reserved)
 memory: 000ef000 @ 00001000 (ROM data)
 memory: 00322000 @ 000f0000 (reserved)
 memory: 03bee000 @ 00412000 (usable)
Built 1 zonelists
Kernel command line: ip=dhcp console=ttyS0,38400n8r
Primary instruction cache 16kB, physically tagged, 4-way, linesize 16 bytes.
Primary data cache 16kB, 4-way, linesize 16 bytes.
Synthesized TLB refill handler (19 instructions).
3c1b8041
401a4000
8f7b1018
001ad582
001ad080
037ad821
401a2000
8f7b0000
001ad042
335a0ff8
037ad821
8f7a0000
8f7b0004
001ad182
409a1000
001bd982
409b1800
42000006
42000018
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
Synthesized TLB load handler fastpath (31 instructions).
3c1b8041
401a4000
8f7b1018
001ad582
001ad080
037ad821
401a4000
8f7b0000
001ad282
335a0ffc
037ad821
8f7a0000
42000008
335a0003
3b5a0003
1740000d
8f7a0000
375a0088
af7a0000
377b0004
3b7b0004
8f7a0000
8f7b0004
001ad182
409a1000
001bd982
409b1800
42000002
42000018
08042e6c
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
Synthesized TLB store handler fastpath (31 instructions).
3c1b8041
401a4000
8f7b1018
001ad582
001ad080
037ad821
401a4000
8f7b0000
001ad282
335a0ffc
037ad821
8f7a0000
42000008
335a0005
3b5a0005
1740000d
8f7a0000
375a0198
af7a0000
377b0004
3b7b0004
8f7a0000
8f7b0004
001ad182
409a1000
001bd982
409b1800
42000002
42000018
08042eaf
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
Synthesized TLB modify handler fastpath (30 instructions).
3c1b8041
401a4000
8f7b1018
001ad582
001ad080
037ad821
401a4000
8f7b0000
001ad282
335a0ffc
037ad821
8f7a0000
42000008
335a0004
1340000d
8f7a0000
375a0198
af7a0000
377b0004
3b7b0004
8f7a0000
8f7b0004
001ad182
409a1000
001bd982
409b1800
42000002
42000018
08042eaf
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
PID hash table entries: 512 (order: 9, 8192 bytes)
CPU frequency 80.00 MHz
Using 40.001 MHz high precision timer.
Console: colour dummy device 80x25
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 60672k/61368k available (2206k kernel code, 628k reserved, 653k data, 140k init, 0k highmem)
Mount-cache hash table entries: 512
Checking for 'wait' instruction...  available.
NET: Registered protocol family 16
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
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
Freeing unused kernel memory: 1096k freed
Algorithmics/MIPS FPU Emulator v1.5
INIT: version 2.84 booting
Executing first boot commands
Got mcheck at 2ac5abbc
Cpu 0
$ 0   : 00000000 1000fc01 100119cc 10010000
$ 4   : 000000ff ffffffe0 100115b0 100115a8
$ 8   : 2ad24d90 00000048 00000021 ffffffec
$12   : fffffffe 00000000 00000048 2ad23d40
$16   : 10000d60 000002ca 10012320 00000000
$20   : ffffffff 00000000 ffffffff 00000000
$24   : 00000000 2ac5abac
$28   : 2ad2a0a0 7f8fa988 100120b8 004123cc
Hi    : ffa1c549
Lo    : a17c6bd5
epc   : 2ac5abbc 0x2ac5abbc     Not tainted
ra    : 004123cc 0x4123cc
Status: 0020fc13    USER EXL IE
Cause : 00800060
PrId  : 00018001
                 
Index:  0 pgmask=4kb va=2ab90000 asid=10
                        [pa=00036000 c=3 d=0 v=1 g=0]
                        [pa=00037000 c=3 d=0 v=1 g=0]
                                                      
Index:  1 pgmask=4kb va=2ab96000 asid=10
                        [pa=00023000 c=3 d=0 v=1 g=0]
                        [pa=00024000 c=3 d=0 v=1 g=0]
                                                      
Index:  2 pgmask=4kb va=80004000 asid=00
                        [pa=00000000 c=0 d=0 v=0 g=0]
                        [pa=00000000 c=0 d=0 v=0 g=0]
                                                      
Index:  3 pgmask=4kb va=1000a000 asid=12
                        [pa=011dc000 c=3 d=0 v=1 g=0]
                        [pa=011cc000 c=3 d=0 v=0 g=0]
                                                      
Index:  4 pgmask=4kb va=2ac5a000 asid=12
                        [pa=000a6000 c=3 d=0 v=1 g=0]
                        [pa=000a7000 c=3 d=0 v=0 g=0]
                                                      
Index:  5 pgmask=4kb va=2ad22000 asid=12
                        [pa=011bf000 c=3 d=0 v=1 g=0]
                        [pa=005b7000 c=3 d=1 v=1 g=0]
                                                      
Index:  6 pgmask=4kb va=7f8fa000 asid=10
                        [pa=0116d000 c=3 d=1 v=1 g=0]
                        [pa=00000000 c=0 d=0 v=0 g=0]
                                                      
Index:  7 pgmask=4kb va=2ac02000 asid=12
                        [pa=01131000 c=3 d=0 v=1 g=0]
                        [pa=01132000 c=3 d=0 v=0 g=0]
                                                      
Index:  8 pgmask=4kb va=10010000 asid=12
                        [pa=00514000 c=3 d=0 v=0 g=0]
                        [pa=005b8000 c=3 d=1 v=1 g=0]
                                                      
Index:  9 pgmask=4kb va=80012000 asid=00
                        [pa=00000000 c=0 d=0 v=0 g=0]
                        [pa=00000000 c=0 d=0 v=0 g=0]
                                                      
Index: 10 pgmask=4kb va=10006000 asid=12
                        [pa=011c9000 c=3 d=0 v=1 g=0]
                        [pa=0115c000 c=3 d=0 v=1 g=0]
                                                      
Index: 11 pgmask=4kb va=2abfc000 asid=12
                        [pa=00086000 c=3 d=0 v=0 g=0]
                        [pa=00087000 c=3 d=0 v=1 g=0]
                                                      
Index: 12 pgmask=4kb va=2ad24000 asid=12
                        [pa=011ca000 c=3 d=0 v=0 g=0]
                        [pa=00553000 c=3 d=0 v=1 g=0]
                                                      
Index: 13 pgmask=4kb va=10004000 asid=12
                        [pa=00000000 c=0 d=0 v=0 g=0]
                        [pa=011be000 c=3 d=0 v=1 g=0]
                                                      
Index: 14 pgmask=4kb va=00410000 asid=10
                        [pa=011b0000 c=3 d=0 v=1 g=0]
                        [pa=011b1000 c=3 d=0 v=1 g=0]
                                                      
Index: 15 pgmask=4kb va=7f8fa000 asid=12
                        [pa=005b6000 c=3 d=1 v=1 g=0]
                        [pa=00000000 c=0 d=0 v=0 g=0]
                                                      
Kernel panic - not syncing: Caught Machine Check exception - caused by multiple matching entries in the TLB.
                             


--------------060304000905080105090008--
