Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Jun 2004 10:37:21 +0100 (BST)
Received: from f16.mail.ru ([IPv6:::ffff:194.67.57.46]:4104 "EHLO f16.mail.ru")
	by linux-mips.org with ESMTP id <S8225533AbUFGJhQ>;
	Mon, 7 Jun 2004 10:37:16 +0100
Received: from mail by f16.mail.ru with local 
	id 1BXGZ7-000HT0-00
	for linux-mips@linux-mips.org; Mon, 07 Jun 2004 13:37:13 +0400
Received: from [80.240.102.213] by msg.mail.ru with HTTP;
	Mon, 07 Jun 2004 13:37:13 +0400
From: =?koi8-r?Q?=22?=romio kasyanov=?koi8-r?Q?=22=20?= 
	<kasyanov_ri@mail.ru>
To: linux-mips@linux-mips.org
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [80.240.102.213]
Date: Mon, 07 Jun 2004 13:37:13 +0400
Reply-To: =?koi8-r?Q?=22?=romio kasyanov=?koi8-r?Q?=22=20?= 
	  <kasyanov_ri@mail.ru>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 8bit
Message-Id: <E1BXGZ7-000HT0-00.kasyanov_ri-mail-ru@f16.mail.ru>
Return-Path: <kasyanov_ri@mail.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5257
Subject: (no subject)
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kasyanov_ri@mail.ru
Precedence: bulk
X-list: linux-mips

Hello!
Trying to port linux kernel 2_4_25 on dbaux1550.
This is my dump.Don't know from what to start.Please help.

CPU revision is: 03030200
Primary instruction cache 16kB, physically tagged, 4-way, linesize 32 bytes.
Primary data cache 16kB 4-way, linesize 32 bytes.
Linux version 2.4.25 (roman@storm) (gcc version 3.3.2) #6 Mon Jun 7 12:56:39 MS4
AMD Alchemy Au1550/Db1550 Board
Au1550 AA (PRId 03030200) @ 396MHZ
BCLK switching enabled!
Determined physical RAM map:
 memory: 0c000000 @ 00000000 (usable)
On node 0 totalpages: 49152
zone(0): 49152 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line:  console=ttyS0,115200 usb_ohci=base:0x14020000,len:0x100006
calculating r4koff... 003c6cc0(3960000)
CPU frequency 396.00 MHz
Console: colour dummy device 80x25
Calibrating delay loop... 395.67 BogoMIPS
Memory: 191136k/196608k available (1873k kernel code, 5472k reserved, 120k data)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Checking for 'wait' instruction...  unavailable.
POSIX conformance testing by UNIFIX
Autoconfig PCI channel 0x80313938
Scanning bus 00, I/O 0x00000300:0x00100000, Mem 0x40000000:0x50000000
00:0b.0 Class 0002: 0007:0000 (rev 01)
        I/O at 0x00000300 [size=0x8]
        I/O at 0x00000308 [size=0x4]
        I/O at 0x00000310 [size=0x8]
        I/O at 0x00000318 [size=0x4]
        I/O at 0x00000400 [size=0x100]
remap_area_pte: page already exists
Break instruction in kernel code in traps.c::do_bp, line 591:
$0 : 00000000 1000fc00 00000024 00000000 80302818 00000001 00000001 80302830
$8 : 00000001 000006b2 0000068b 000006b2 80320000 80320000 80320000 ba2e8ba3
$16: 00000000 00103000 8034b018 00003000 00000005 00000000 000007d7 00000017
$24: ba2e8ba3 00000001                   8121a000 8121be78 00003000 80109b28
Hi : fffff61f
Lo : 0000034b
epc   : 80109b28    Not tainted
Status: 1000fc03
Cause : 00800024
PrId  : 03030200
Process swapper (pid: 1, stackpage=8121a000)
Stack:    00000000 00000000 bb77fd8c bb77fd8c bb77fd8d 00000000 00000000
 00000000 00000000 00000000 fffffff4 802f8800 c0103000 802f8800 00000004
 ffffd000 00000000 00103000 001fffff 00000001 00000000 00100000 00000005
 00000000 c0003000 00000000 00000010 00000000 8008c6b4 80109cac c0003000
 00000000 00000004 3fffd000 00000000 00100000 00000010 00000000 80340000
 80310000 ...
Call Trace:   [<80109cac>] [<801007b0>] [<801007b0>] [<80101e00>] [<80101da0>]
 [<80200118>] [<8015fad0>] [<801007b0>] [<801007c0>] [<80102188>] [<8010fb30>]
 [<801603b8>] [<80160394>] [<80102178>]

Code:
Kernel panic: Attempted to kill init!
