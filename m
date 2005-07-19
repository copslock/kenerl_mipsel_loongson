Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jul 2005 07:41:54 +0100 (BST)
Received: from bay107-f33.bay107.hotmail.com ([IPv6:::ffff:64.4.51.43]:48822
	"EHLO hotmail.com") by linux-mips.org with ESMTP
	id <S8226856AbVGSGlg>; Tue, 19 Jul 2005 07:41:36 +0100
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Mon, 18 Jul 2005 23:43:17 -0700
Message-ID: <BAY107-F3324FE3490CA2192FD631BC9D40@phx.gbl>
Received: from 64.4.51.220 by by107fd.bay107.hotmail.msn.com with HTTP;
	Tue, 19 Jul 2005 06:43:17 GMT
X-Originating-IP: [64.4.51.220]
X-Originating-Email: [michaelanburaj@hotmail.com]
X-Sender: michaelanburaj@hotmail.com
In-Reply-To: <20030510194942.GH27494@lug-owl.de>
From:	"Michael Anburaj" <michaelanburaj@hotmail.com>
To:	linux-mips@linux-mips.org
Cc:	embeddedeng@yahoo.com
Subject: Re: 4kc machine check
Date:	Mon, 18 Jul 2005 23:43:17 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 19 Jul 2005 06:43:17.0714 (UTC) FILETIME=[254CE320:01C58C2D]
Return-Path: <michaelanburaj@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8541
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michaelanburaj@hotmail.com
Precedence: bulk
X-list: linux-mips

Hi,

I am seeing what Greg Weeks saw and emailed couple of months back.

source: linux-mips CVS source pulled using TAGS <linux_2_6_11 through 
linux_2_6_12>\
Board: MIPS 4Kc Atlas
Bootloader: Redboot or YAMON
kernel parameters: console=ttyS0,115200 rd_start=0x80400000 rd_size=0x3f0ffc
kernel load address: 0x80100000 ~ 0x803xxxxx
ramdisk image: 0x80400000 ~ 0x807fcfff

I tried couple of linux-mips CVS versions & these are the results:

version linux_2_6_12 & newer do not print any messages on the console, but 
causes an exception. verions between linux_2_6_11 & linux_2_6_12 (all the 
_r1,2,3s), when loading the ramdisk (initrd) it fails (console dump included 
at the bottom).

I tried loading compressed and non-compressed ext2 files as ramdisk – but 
the problem stays. I don’t know if this is due to something I am doing wrong 
or it’s a known issue.

Please help me!

Thanks,
-Mike.

Clipping from the console:

LINUX started...
Linux version 2.6.10-rc2 (root@localhost.localdomain) (gcc version 2.95.4 
200105CPU revision is: 00018001
Determined physical RAM map:
memory: 00001000 @ 00000000 (reserved)
memory: 000ff000 @ 00001000 (ROM data)
memory: 00286000 @ 00100000 (reserved)
memory: 00c7a000 @ 00386000 (usable)
Initial ramdisk at: 0x80400000 (4182015 bytes)
Built 1 zonelists
Kernel command line: console=ttyS0,115200 rd_start=0x80400000 
rd_size=0x3fcfff
Primary instruction cache 16kB, physically tagged, 4-way, linesize 16 bytes.
Primary data cache 16kB, 4-way, linesize 16 bytes.
Synthesized TLB handler (19 instructions).
PID hash table entries: 128 (order: 7, 2048 bytes)
CPU frequency 80.00 MHz
Using 40.000 MHz high precision timer.
Console: colour dummy device 80x25
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Memory: 8020k/12776k available (1776k kernel code, 4736k reserved, 379k 
data, 3)Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Checking for 'wait' instruction...  available.
checking if image is initramfs...it isn't (bad gzip magic numbers); looks 
like dFreeing initrd memory: 4083k freed
NET: Registered protocol family 16
Can't analyze prologue code at 802ba92c
SCSI subsystem initialized
PCI: Bus 1, bridge: 0000:00:0f.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
??ttyS0 at I/O 0x1f000900 (irq = 1) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 1024)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
RAMDISK: ext2 filesystem found at block 0
RAMDISK: Loading 4084KiB [1 disk] into ram disk... done.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing prom memory: 1020kb freed
Freeing unused kernel memory: 1364k freed
Got mcheck at 0042ebec
Cpu 0
$ 0   : 00000000 1000fc00 00000000 0048b1b6
$ 4   : 1000f209 0048b1a0 00000063 00000000
$ 8   : 0004a770 00405481 2aaad47c 2abe4828
$12   : 00000309 0ab969fb 00000001 2abe6df8
$16   : 1000f1ec 7fff79c0 1000f2ec 1000f1e8
$20   : 7fff7f24 00000002 00000000 00430000
$24   : 2abe1798 2ac29770
$28   : 1000a6e0 7fff75a0 004069a0 0042eb8c
Hi    : 00000224
Lo    : 0002a9b1
epc   : 0042ebec 0x42ebec     Not tainted
ra    : 0042eb8c 0x42eb8c
Status: 0020fc13    USER EXL IE
Cause : 00800060
PrId  : 00018001

Index:  0 pgmask=4kb va=2ab3c000 asid=17
                        [pa=009d3000 c=3 d=0 v=1 g=0]
                        [pa=00000000 c=0 d=0 v=0 g=0]

Index:  1 pgmask=4kb va=2aaac000 asid=17
                        [pa=0036b000 c=3 d=0 v=1 g=0]
                        [pa=0031d000 c=3 d=0 v=1 g=0]

Index:  2 pgmask=4kb va=0042e000 asid=17
                        [pa=00014000 c=3 d=0 v=1 g=0]
                        [pa=0055e000 c=3 d=0 v=0 g=0]

Index:  3 pgmask=4kb va=2ac2a000 asid=17
                        [pa=00013000 c=3 d=0 v=0 g=0]
                        [pa=00015000 c=3 d=0 v=1 g=0]

Index:  4 pgmask=4kb va=2aaa8000 asid=17
                        [pa=00c4e000 c=3 d=0 v=1 g=0]
                        [pa=00004000 c=3 d=0 v=1 g=0]

Index:  5 pgmask=4kb va=2aaec000 asid=17
                        [pa=00369000 c=3 d=0 v=1 g=0]
                        [pa=00c53000 c=3 d=0 v=1 g=0]

Index:  6 pgmask=4kb va=2abe6000 asid=17
                        [pa=009dd000 c=3 d=0 v=0 g=0]
                        [pa=00c44000 c=3 d=0 v=1 g=0]

Index:  7 pgmask=4kb va=7fff6000 asid=17
                        [pa=00000000 c=0 d=0 v=0 g=0]
                        [pa=0033e000 c=3 d=1 v=1 g=0]

Index:  8 pgmask=4kb va=1000e000 asid=17
                        [pa=0001c000 c=3 d=0 v=0 g=0]
                        [pa=0001a000 c=3 d=0 v=1 g=0]

Index:  9 pgmask=4kb va=0048a000 asid=17
                        [pa=00349000 c=3 d=0 v=0 g=0]
                        [pa=0055f000 c=3 d=0 v=1 g=0]

Index: 10 pgmask=4kb va=2ac28000 asid=17
                        [pa=009cc000 c=3 d=0 v=0 g=0]
                        [pa=0085c000 c=3 d=0 v=1 g=0]

Index: 11 pgmask=4kb va=10002000 asid=17
                        [pa=00021000 c=3 d=1 v=1 g=0]
                        [pa=00556000 c=3 d=0 v=0 g=0]

Index: 12 pgmask=4kb va=00404000 asid=17
                        [pa=00c40000 c=3 d=0 v=0 g=0]
                        [pa=00c41000 c=3 d=0 v=1 g=0]

Index: 13 pgmask=4kb va=2abe4000 asid=17
                        [pa=00c43000 c=3 d=0 v=1 g=0]
                        [pa=009db000 c=3 d=0 v=0 g=0]

Index: 15 pgmask=4kb va=2ab90000 asid=17
                        [pa=00363000 c=3 d=0 v=1 g=0]
                        [pa=0000d000 c=3 d=0 v=1 g=0]

Kernel panic - not syncing: Caught Machine Check exception - caused by 
multiple.
