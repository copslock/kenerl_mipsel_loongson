Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Feb 2005 15:54:12 +0000 (GMT)
Received: from msr58.hinet.net ([IPv6:::ffff:168.95.4.158]:16082 "EHLO
	msr58.hinet.net") by linux-mips.org with ESMTP id <S8225395AbVBXPx4>;
	Thu, 24 Feb 2005 15:53:56 +0000
Received: from [192.168.186.100] (218-160-24-140.dynamic.hinet.net [218.160.24.140])
	by msr58.hinet.net (8.9.3/8.9.3) with ESMTP id XAA18254
	for <linux-mips@linux-mips.org>; Thu, 24 Feb 2005 23:53:51 +0800 (CST)
Message-ID: <421DF870.30708@s90.tku.edu.tw>
Date:	Thu, 24 Feb 2005 23:53:20 +0800
From:	Tsang-Ren Chang <690190029@s90.tku.edu.tw>
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: ADM5120: Data bus error
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: 8bit
Return-Path: <690190029@s90.tku.edu.tw>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7333
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: 690190029@s90.tku.edu.tw
Precedence: bulk
X-list: linux-mips

Hi,
I'm porting linux-2.4.27 on adm5120 (MIPS 4Kc core).
But when I copied /sbin/pppd , It crashed.

ADM5120 Boot:
no sys signature found!!

jump to linux code!!

LINUX started...
ADM5120 Demo board
CPU revision is: 0001800b
Primary instruction cache 8kB, physically tagged, 2-way, linesize 16 bytes.
Primary data cache 8kB 2-way, linesize 16 bytes.
Linux version 2.4.27 (neo@neo) (gcc version 2.96 20000731 (Red Hat Li
nux 7.3 2.96-110.1)) #498 е| 2ды 24 21:41:56 CST 2005
am5120_setup() starts.
System has PCI BIOS
Determined physical RAM map:
memory: 00d4a000 @ 002b6000 (usable)
Initial ramdisk at: 0x80180000 (1122304 bytes)
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/ram0 console=ttyS0
CPU clock: 175MHz
No external timer interrupt -- use R4k.
Using 87.500 MHz high precision timer.
Calibrating delay loop... 174.48 BogoMIPS
Memory: 13420k/13608k available (1334k kernel code, 188k reserved, 1180k
data, 9
2k init, 0k highmem)
Dentry cache hash table entries: 2048 (order: 2, 16384 bytes)
Inode cache hash table entries: 1024 (order: 1, 8192 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
Checking for 'wait' instruction... available.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
pty: 256 Unix98 ptys configured
HDLC line discipline: version $Revision: 3.7 $, maxframe=4096
N_HDLC line discipline registered.
RAMDISK driver initialized: 16 RAM disks of 5120K size 1024 blocksize
loop: loaded (max 8 devices)
ADM5120 Switch Module Init
PPP generic driver version 2.4.2
MX29LV160B flash device: 200000 at 1fc00000
Amd/Fujitsu Extended Query Table v1.0 at 0x0040
MX29LV320B flash device initialized
ftl_cs: FTL header not found.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 2048)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: Ethernet Bridge 008 for NET4.0
LED & GPIO Driver v1.0
RAMDISK: Compressed image found at block 0
Uncompressing.......
done
Freeing initrd memory: 1096k freed
VFS: Mounted root (ext2 filesystem).
Freeing prom memory: 0kb freed
Freeing unused kernel memory: 92k freed

Please press Enter to activate this console.


BusyBox v1.00-pre7 (2004.11.29-08:57+0000) Built-in shell (ash)
Enter 'help' for a list of built-in commands.

#
# cp /sbin/pppd /tmp/
Data bus error, epc == 8012a824, ra == 800972b8
Oops in traps.c::do_be, line 387:
$0 : 00000000 802a5ca8 8026d000 00000000 8026d300 80ffff00 000000e0 8026d000
$8 : afbe0020 92450000 00000000 24a3ffff 03c4102a 0000026d ba2e8ba3 10400003
$16: 802e3ff4 00000400 00000000 00000000 80276f60 0000007f ba2e8ba3 8038fe3c
$24: 00000000 00000000 80260000 80261d30 00000000 800972b8
Hi : ffff400c
Lo : 00003ffc
epc : 8012a824 Not tainted
Status: 10008403
Cause : 1080001c
PrId : 0001800b
Process cp (pid: 28, stackpage=80260000)
Stack: 80226720 00000001 80276e40 802beaf4 00000000 80261e04 80276f60
00000002 000003f6 00001400 00000000 80261e08 00000004 8003e94c 802beadc
800973b4 0000000c 0000005f 00000001 00000000 80276f60 80095690 00000000
8031697c 000001fe 80226420 80276f00 8003f5a8 80276f70 80276f60 00000001
00000002 00000000 80095764 80261db0 0000001a 80276e40 802beaf4 0000006b
80261e04 ...
Call Trace: [<8003e94c>] [<800973b4>] [<80095690>] [<8003f5a8>] [<80095764>]
[<800405a0>] [<8006b320>] [<8002e490>] [<8006ae20>] [<8012a824>]
[<8002b4bc>]
[<8002b3d8>] [<8002bbf4>] [<8002baa4>] [<8003c430>] [<8003c60c>]
[<8003bd7c>]
[<8000bca4>] [<8000be08>] [<8012abe8>] [<80062fec>]

Code: 8caa0008 8cab000c 24c6ffe0 <8cac0010> 8caf0014 ac880000 ac890004 8ca8
0018 8ca9001c
Segmentation fault



8012a7f8 <both_aligned>:
8012a7f8: 00064142 srl t0,a2,0x5
8012a7fc: 1100001b beqz t0,8012a86c <cleanup_both_aligned>
8012a800: 30d8001f andi t8,a2,0x1f
8012a804: cca00060 lwc3 $0,96(a1)
8012a808: cc810060 lwc3 $1,96(a0)
8012a80c: 00000000 nop
8012a810: 8ca80000 lw t0,0(a1)
8012a814: 8ca90004 lw t1,4(a1)
8012a818: 8caa0008 lw t2,8(a1)
8012a81c: 8cab000c lw t3,12(a1)
8012a820: 24c6ffe0 addiu a2,a2,-32
8012a824: 8cac0010 lw t4,16(a1)
8012a828: 8caf0014 lw t7,20(a1)
8012a82c: ac880000 sw t0,0(a0)
8012a830: ac890004 sw t1,4(a0)
8012a834: 8ca80018 lw t0,24(a1)
8012a838: 8ca9001c lw t1,28(a1)
8012a83c: 24a50020 addiu a1,a1,32
8012a840: 24840020 addiu a0,a0,32
8012a844: ac8affe8 sw t2,-24(a0)
8012a848: ac8bffec sw t3,-20(a0)
8012a84c: ac8cfff0 sw t4,-16(a0)
8012a850: ac8ffff4 sw t7,-12(a0)
8012a854: ac88fff8 sw t0,-8(a0)
8012a858: ac89fffc sw t1,-4(a0)
8012a85c: cca00100 lwc3 $0,256(a1)
8012a860: cc810100 lwc3 $1,256(a0)
8012a864: 14d8ffea bne a2,t8,8012a810 <both_aligned+0x18>
8012a868: 00000000 nop


I tried to ignore this exception(return from do_be() immediately) and
compared /tmp/pppd with original pppd.
I'm confused now because they are all equivalent.
Why does the CPU raise data bus error exception when I copy or read
/sbin/pppd every time? (cp0 hazards?)
How to fix this?

Thanks.
T.R. Chang
