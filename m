Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Nov 2003 01:38:44 +0000 (GMT)
Received: from rrcs-central-24-123-115-44.biz.rr.com ([IPv6:::ffff:24.123.115.44]:13184
	"EHLO localhost.localdomain") by linux-mips.org with ESMTP
	id <S8225426AbTKABim>; Sat, 1 Nov 2003 01:38:42 +0000
Received: from radium ([192.168.0.20])
	by localhost.localdomain (8.12.8/8.12.8) with ESMTP id hA11brmv028438
	for <linux-mips@linux-mips.org>; Fri, 31 Oct 2003 19:37:56 -0600
From: "Lyle Bainbridge" <lyle@zevion.com>
To: <linux-mips@linux-mips.org>
Subject: 
Date: Fri, 31 Oct 2003 19:38:58 -0600
Message-ID: <000001c3a018$ed5efb30$800101df@radium>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Return-Path: <lyle@zevion.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3562
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lyle@zevion.com
Precedence: bulk
X-list: linux-mips

Hi,

I am porting the linux-mips 2.4.22 kernel to a custom Au1500 board and I
am seeing strange output when the kernel starts.  Some lines feed ok,
but some don't, and in that case the error level is displayed (ie, <4>).
Also numerous characters are dropped. 

Does anybody have any clue about what might be happening?  See kernel
output below.

Thanks,
Lyle

CPU revision is: 01030200<4>Primary instruction cache 16kB, physically
tagged, 4
-way, linesize 32 bytes.<4>Primary data cache 16kB 4-way, linesize 32
bytes.
Linux version 2.4.22 (root@localhost.localdomain) (gcc version 3.3.1) #9
Fri Oct
 31 18:57:53 CST 2003<4>Determined physical RAM map:<4> memory:
0(usable)
On node zone(0): 8192 pages..e4>zone1o): 0 pages.
ss
zone(2): 0 pages.
Kernel command line:  panic=2 ethaddr=00:30:23:50:00:00 root=/dev/hda2
console=t
tyS0,115200
 0ST 2003<4>calculating r4koff... 00493e00(4800000)
CPU frequency 480.00 MHz
set_au1x00_lcd_clock: warning: LCD clock too high (60000
KHz)<4>Calibrating dela
y loop... 478.41 BogoMIPS
Memory:8r9804k/32768k available (1257k kernel code, 2964k reserved, 84k
data, 76
k init, 0k highmem)<6>Dentry cache hash table entries: 4096 (order: 3,
32768 byt
es)
Inode cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)<4>Checking
for 'wait
' instruction... unavailable.
POSIX conformance testing by UNIFIX
Autoconfig PCI channel 0x80267b18
X1Scanning bus 00, I/O 0x00000300:0x00100000, Mem 0x40000000:0x50000000
 04k data, 76k init, 0k highmem)
00:0c.0 Class 0104: 1103:0007 (rev 01)
        I/O at 0x00000300 [size=0x8]
        I/O at 0x00000308 [size=0x4]
        I/O at 0x00000310 [size=0x8]
        I/O at 0x00000318 [size=0x4]
        I/O at 0x00000400 [size=0x100]
Non-coherent PCI accesses enabled<6>Linux NET4.0 for Linux 2.4<6>Based
upon Swan
sea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapda6>Journalled Block Device driver loaded
pty: 256 Unix98 ptys configured<6>Serial driver version 1.01
(2001-02-08) with n
o serial options enabled
 eata, 76k init, 0k highmem)<6>ttyS00 at 0xb1100000 (irq = 0) is a 16550
ttyS01 at 0xb1200000 (irq = 1) is a 16550<6>ttyS02 at 0xb1300000 (irq =
2) is a
16550
ttyS03 at 0xb1400000 (irq = 3) is a 1655056>loop: loaded (max 8 devices)
)(is a 16550<4>au1000eth.c:1.4 ppopov@mvista.com
eth0: Au1x Ethernet found at 0xb1500000, irq 28<4>ethaddr not set in
boot prom<6
>eth0: Broadcom BCM5222 10/100 BaseT PHY at phy address 3<6>eth0: Using
Broadcom
 BCM5222 10/100 BaseT PHY as default<6>Uniform Multi-Platform E-IDE
driver Revis
ion: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx<6>HP
T371: IDE controller at PCI slot 07:0c.0<6>HPT371: chipset revision
1<6>HPT371:
not 100% native mode: will probe irqs later
HPT37X: using 33MHz PCI clock<6>    ide0: BM-DMA at 0x0408-0x040, BIOS
settings:
 hd:pio, hd:pio
HPT371: port 0x0310 already claimed by ide0
NET4: Linux TCP/IP 1.0 for NET4.0<6>IP Protocols: ICMP, UDP, TCP, IGMP
6>IP: routing cache hash table of 512 buckets, 4Kbytes
verride with idebus=xx=6>TCP: Hash tables configured (established 2048
bind 4096
)
