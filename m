Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 May 2006 02:50:04 +0200 (CEST)
Received: from [220.76.242.187] ([220.76.242.187]:59087 "EHLO
	localhost.localdomain") by ftp.linux-mips.org with ESMTP
	id S8134092AbWEZAty (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 26 May 2006 02:49:54 +0200
Received: from mrv ([192.168.11.157])
	by localhost.localdomain (8.12.8/8.12.8) with SMTP id k4Q0pfEE030590
	for <linux-mips@linux-mips.org>; Fri, 26 May 2006 09:51:43 +0900
Message-ID: <001101c6805e$4c4f62b0$9d0ba8c0@mrv>
From:	"Roman Mashak" <mrv@corecom.co.kr>
To:	<linux-mips@linux-mips.org>
Subject: booting with NFS root
Date:	Fri, 26 May 2006 09:49:50 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="koi8-r";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
FL-Build: Fidolook 2002 (SL) 6.0.2800.86 - 14/6/2003 22:16:25
Return-Path: <mrv@corecom.co.kr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11551
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mrv@corecom.co.kr
Precedence: bulk
X-list: linux-mips

Hello!

I have evaluation board from PMC-sierra, their CPU is using E9000 core. 
Kernel (2.4.26), root FS are provided by them. I set up NFS and TFTP servers 
on my linux box, kernel loads into board but fails to boot woth the 
following message (I skipped some lines of kernel):

=====================
PMC-Sierra TITAN 10/100/1000 Ethernet Driver
Device Id : 206014,  Version : 0
eth0: port 0 with MAC address 30:30:3a:31:31:3a
Rx NAPI supported, Tx Coalescing ON
eth1: port 1 with MAC address 30:30:3a:31:31:3b
Rx NAPI supported, Tx Coalescing ON
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 16384)
IP-Config: Entered.
ipconfig.c 1194
dev.c 1998
dev.c 2013
dev.c 750
irq.c 539
irq.c 571
irq.c 840
irq.c 879
handler->startup 80259d14
irq.c 892
irq.c 576
Assigned IRQ 6 to port 0
titan_ge.c 2256
titan_ge.c 2278
titan_ge.c 2316
titan_ge.c 2359
titan_ge.c 1614
titan_ge.c 1659
titan_ge.c 1698
titan_ge.c 1717
titan_ge.c 1837
titan_ge.c 2025
titan_ge.c 2118
titan_ge.c 2177
dev_addr=       1, reg_addr=      11
val=    4111
val=       1
titan_ge.c 2184
titan_ge.c 2397
dev_addr=       1, reg_addr=      11
val=    4112
val=       1
dev.c 788
dev.c 2034
dev.c 2043
dev.c 2059
IP-Config: eth0 UP (able=1, xid=57c63687)
dev.c 1998
dev.c 2013
dev.c 750
irq.c 539
irq.c 571
irq.c 840
irq.c 879
irq.c 892
irq.c 576
Assigned IRQ 6 to port 1
titan_ge.c 2256
titan_ge.c 2278
titan_ge.c 2316
titan_ge.c 2359
titan_ge.c 1659
titan_ge.c 1698
titan_ge.c 1717
titan_ge.c 1837
titan_ge.c 2025
titan_ge.c 2118
titan_ge.c 2177
dev_addr=       2, reg_addr=      11
val=    4111
val=       1
titan_ge.c 2184
titan_ge.c 2397
dev_addr=       2, reg_addr=      11
val=    4212
val=       1
eth1: Error opening interface
dev.c 788
dev.c 2034
dev.c 2043
dev.c 2059
IP-Config: Failed to open eth1
ipconfig.c 1199
IP-Config: Guessing netmask 255.255.255.0
IP-Config: Complete:
      device=eth0, addr=192.168.11.42, mask=255.255.255.0, 
gw=255.255.255.255,
     host=192.168.11.42, domain=, nis-domain=(none),
     bootserver=255.255.255.255, rootserver=192.168.11.43, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 192.168.11.43
Looking up port of RPC 100005/1 on 192.168.11.43
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 104k freed
do_cpu invoked from kernel context! in traps.c::do_cpu, line 676:
$0 : 00000000 9004a000 2ab03fe0 2ab03fe0 2ab01560 00000000 00000ae0 00000ae0
$8 : 00000020 2ab01fe0 2ab01520 00001000 00000019 00000080 811d7b18 00000c62
$16: 2ab010c0 811d7c58 87f8cfe0 00000003 00000080 2ab01520 87f841a0 00000001
$24: 00000000 00000080                   811d6000 811d7ba0 2aaa8000 8015f414
Hi : 00000000
Lo : 00000000
epc   : 80256e14    Not tainted
Status: 9004a003
Cause : 1000002c
PrId  : 000034c1
Process init (pid: 1, stackpage=811d6000)
Stack:    8015f8a8 8015f9a8 87f71180 8012b2fc 00000000 80135330 00002012
 00000019 87f8cf60 2ab019e4 00000004 00002012 000590c0 2ab01000 10000000
 811d7d88 87ff5740 00000000 811d7ef8 81164e80 00000000 00000002 87f841a0
 8015ffd8 811d7c20 811d6000 811d7cbc 801975a4 00006012 0000000a 811d7c18
 811d7c18 7f454c46 01020100 00000000 00000000 00020008 00000001 00401980
 00000034 ...
Call Trace:   [<8015f8a8>] [<8015f9a8>] [<8012b2fc>] [<80135330>] 
[<8015ffd8>]
 [<801975a4>] [<8015fbc0>] [<801493ac>] [<801007b8>] [<8014889c>] 
[<801495bc>]
 [<801495a8>] [<801007b8>] [<80108f80>] [<801007b8>] [<8014fcc4>] 
[<801095c0>]
 [<8025ad30>] [<801007b8>] [<8025ad30>] [<8014af50>] [<801007b8>] 
[<80117888>]
 [<801194a0>] [<80100884>] [<801007b8>] [<8010079c>] [<8025de14>] 
[<80104320>]
 [<80117aec>] [<8026b7a8>] [<801b2054>] [<80104310>]

Code: 30c8003c  01244821  24840040 <ac85ffc0> ac85ffc4  ac85ffc8  ac85ffcc 
ac85ffd0  ac85ffd4
Kernel panic: Attempted to kill init!
=====================

I load kernel with the following parameters:
tftp://192.168.11.43/vmlinux ip=192.168.11.42 root=/dev/nfs 
nfsroot=192.168.11.43:/export/linux/mips-fs-be

What may be the problem here?

Thanks in advance!

With best regards, Roman Mashak.  E-mail: mrv@corecom.co.kr 
