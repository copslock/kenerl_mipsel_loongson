Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Sep 2003 02:15:33 +0100 (BST)
Received: from [IPv6:::ffff:218.1.66.81] ([IPv6:::ffff:218.1.66.81]:13014 "HELO
	mail.citiz.net") by linux-mips.org with SMTP id <S8225346AbTIRBPO> convert rfc822-to-8bit;
	Thu, 18 Sep 2003 02:15:14 +0100
Received: (umta 20066 invoked by uid 1820); 18 Sep 2003 01:14:59 -0000
X-Lasthop: 202.120.8.28
Received: from unknown (HELO hdtv) (unknown@202.120.8.28)
  by localhost with SMTP; 18 Sep 2003 01:14:59 -0000
From: "embedlf" <embedlf@citiz.net>
To: linux-mips@linux-mips.org <linux-mips@linux-mips.org>
Subject: the problem about open file on ramdisk
X-mailer: Foxmail 4.2 [cn]
Mime-Version: 1.0
Content-Type: text/plain;
      charset="GB2312"
Content-Transfer-Encoding: 8BIT
Date: Thu, 18 Sep 2003 9:22:23 +0800
Message-Id: <20030918011514Z8225346-1272+5558@linux-mips.org>
Return-Path: <embedlf@citiz.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3197
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: embedlf@citiz.net
Precedence: bulk
X-list: linux-mips

linux-mips:
	 I use initrd ramdisk as rootfs on my mips cpu board.But after compiling kernel and download it to the board,that print the error message.Following is the message.

CPU revision is: 00001800

Primary instruction cache 64kb, linesize 16 bytes.

Primary data cache 16kb, linesize 16 bytes.

Linux version 2.4.18-MIPS-01.01 (l@l) (gcc version 2.96) #147 眉 9埖 17 15:21:28 CST 2003

Determined physical RAM map:

 memory: 04000000 @ 00000000 (usable)

Initial ramdisk at: 0x80270000 (1917091 bytes)

On node 0 totalpages: 16384

zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: 
Calibrating delay loop... 299.00 BogoMIPS
Memory: 59992k/65536k available (1281k kernel code, 5544k reserved, 1976k data, 72k init, 0k highmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
Checking for 'wait' instruction...  available.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
Dummy keyboard driver installed.
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
block: 128 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.

RAMDISK: Compressed image found at block 0

Freeing initrd memory: 1872k freed

VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 72k freed
kernel BUG at traps.c:627!

Unable to handle kernel paging request at virtual address 00000000, epc == 80105088, ra == 80105088

Oops in fault.c:do_page_fault, line 205:

$0 : 00000000 10018000 0000001b 00000000 80262d10 00000001 00000001 00000000

$8 : 00001289 00001289 80450000 80448139 00000000 00000000 fffffff9 0000000a

$16: 80251000 8113bca8 00000440 8110e320 8116f660 00000000 00000000 00000000

$24: ffffffff 8113bb4a                   8113a000 8113bc88 80458538 80105088

Hi : 00000000

Lo : 00000200

epc  : 80105088    Not tainted

Status: 10018003

Cause : 0000000c

Process swapper (pid: 1, stackpage=8113a000)

Stack: 80229740 80229738 00000273 10018001 80251000 8116d000 00000440 80103f4c

       83a202a0 8013147c 83a20660 00000000 83a20660 80263dec 00000000 80252000

       80440000 8010a480 80251000 00000000 00000250 10018001 00000000 80225ad8

       00ff0000 000003e8 00000001 80232700 80254000 8116f260 80251000 8116d000

       00000440 8110e320 8116f660 00000000 00000000 00000000 00000400 81169000

       8046a8c0 ...

Call Trace:

Code: 24a59738  0c045adb  24060273 <ac000000> 8e2200ac  04410002  8e2400a0  24840004  24820004 

Kernel panic: Attempted to kill init!

 <0>Rebooting in 180 seconds..


At the address 80105088, there is the function do_ri() in traps.c. I found that this fault
was caused by "if (open("/dev/console", O_RDWR, 0) < 0)".Why?
	please help me to analyse this fault.How to conquer it?


　　　　　　　　embedlf
　　　　　　　　embedlf@citiz.net
　　　　　　　　　　2003-09-18
