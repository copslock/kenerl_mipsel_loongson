Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Feb 2005 19:53:32 +0000 (GMT)
Received: from gw.voda.cz ([IPv6:::ffff:212.24.154.90]:6584 "EHLO smtp.voda.cz")
	by linux-mips.org with ESMTP id <S8224988AbVBGTxN>;
	Mon, 7 Feb 2005 19:53:13 +0000
Received: from localhost (localhost [127.0.0.1])
	by smtp.voda.cz (Postfix) with ESMTP id 83C0C10F02
	for <linux-mips@linux-mips.org>; Mon,  7 Feb 2005 20:53:07 +0100 (CET)
Received: from smtp.voda.cz ([127.0.0.1])
 by localhost (gw [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 09153-04 for <linux-mips@linux-mips.org>;
 Mon,  7 Feb 2005 20:53:04 +0100 (CET)
Received: from [10.1.1.77] (unknown [213.151.77.162])
	by smtp.voda.cz (Postfix) with ESMTP id B31B910EFA
	for <linux-mips@linux-mips.org>; Mon,  7 Feb 2005 20:53:03 +0100 (CET)
Message-ID: <4207C71F.7050204@voda.cz>
Date:	Mon, 07 Feb 2005 20:53:03 +0100
From:	=?ISO-8859-2?Q?Tom_Vr=E1na?= <tom@voda.cz>
Organization: VODA IT consulting
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: ADM5120: time.c issues ?
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: by amavisd-new at voda.cz
Return-Path: <tom@voda.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7185
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tom@voda.cz
Precedence: bulk
X-list: linux-mips

Hi,

I made my attempt to port ADM5120 stuff from the prehistoric 2.4.18 
kernel to recent 2.4.27-mipscvs. I get to boot, but:

time.c originally uses:
extern unsigned int mips_counter_frequency;
from timex.h

but in 2.4.27 the timex.h changed to:
extern unsigned int mips_hpt_frequency;

Jeroen uses just a localy defined mips_counter_frequency in his 2.6.x port.

Using jeroens time.c the system boots painfully slow, sort of loops int 
the beginning and the finally freezes on the FPU emulator... any 
suggestions ?

       Thanks Tom

LINUX/5120 started...
CPU revision is: 0001800b
Primary instruction cache 8kB, physically tagged, 2-way, linesize 16 bytes.
Primary data cache 8kB, 2-way, linesize 16 bytes.
Linux version 2.4.27-mipscvs-20050128 (tom@jackal) (gcc version 3.2) #11 Po .ono 7 19:12:23 CET 2005
am5120_setup() starts.
System has PCI BIOS
Determined physical RAM map:
 memory: 00d2a000 @ 002d6000 (usable)
Initial ramdisk at: 0x80157000 (1404928 bytes)
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/ram0 console=ttyS0
CPU clock: 175MHz
CPU revision is: 0001800b
Primary instruction cache 8kB, physically tagged, 2-way, linesize 16 bytes.
Primary data cache 8kB, 2-way, linesize 16 bytes.
Linux version 2.4.27-mipscvs-20050128 (tom@jackal) (gcc version 3.2) #11 Po .ono 7 19:12:23 CET 2005
am5120_setup() starts.
System has PCI BIOS
Determined physical RAM map:
 memory: 00d2a000 @ 002d6000 (usable)
Initial ramdisk at: 0x80157000 (1404928 bytes)
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/ram0 console=ttyS0
CPU clock: 175MHz
Calibrating delay loop... 174.48 BogoMIPS
Memory: 13292k/13480k available (1160k kernel code, 188k reserved, 1464k data, 88k init, 0k highmem)
Dentry cache hash table entries: 2048 (order: 2, 16384 bytes)
Inode cache hash table entries: 1024 (order: 1, 8192 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
Checking for 'wait' instruction...  available.
POSIX conformance testing by UNIFIX
Autoconfig PCI channel 0x801568c8
Scanning bus 00, I/O 0x11500000:0x115ffff0, Mem 0x11400000:0x11500000
00:00.0 Class 0600: 1317:5120
        Mem unavailable -- skipping
        I/O unavailable -- skipping
00:02.0 Class 0200: 168c:0013 (rev 01)
        Mem at 0x11400000 [size=0x10000]
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS28 at 0x03f8 (irq = 4) is a 16450
ttyS29 at 0x02f8 (irq = 3) is a 16450
ttyS30 at 0x03e8 (irq = 4) is a 16450
RAMDISK driver initialized: 16 RAM disks of 5120K size 1024 blocksize
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 2048)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 1372k freed
VFS: Mounted root (ext2 filesystem) readonly.
Freeing prom memory: 0kb freed
Freeing unused kernel memory: 88k freed
Algorithmics/MIPS FPU Emulator v1.5


-- 
 Tomas Vrana  <tom@voda.cz>
 --------------------------
 VODA IT consulting, Borkovany 48, 691 75
 http://www.voda.cz/
 phone: +420 519 419 416 mobile: +420 603 469 305 UIN: 105142752
