Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 May 2004 08:39:54 +0100 (BST)
Received: from schenk.ISAR.de ([IPv6:::ffff:212.14.78.13]:17181 "EHLO
	schenk.isar.de") by linux-mips.org with ESMTP id <S8225550AbUENHjv>;
	Fri, 14 May 2004 08:39:51 +0100
Received: from gwhaus.rt.schenk (gwhaus.rt.schenk [172.22.0.4])
	by schenk.isar.de (8.11.6/8.11.6/SuSE Linux 0.5) with ESMTP id i4E7dRD28060
	for <linux-mips@linux-mips.org>; Fri, 14 May 2004 09:39:28 +0200
Received: from schenk.isar.de (pcimr4.rt.schenk [172.22.10.24])
	by gwhaus.rt.schenk (8.11.6/8.11.6/SuSE Linux 0.5) with ESMTP id i4E7dRi28606
	for <linux-mips@linux-mips.org>; Fri, 14 May 2004 09:39:27 +0200
Message-ID: <40A477AF.903@schenk.isar.de>
Date: Fri, 14 May 2004 09:39:27 +0200
From: Rojhalat Ibrahim <ibrahim@schenk.isar.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Invalid kernel address
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ibrahim@schenk.isar.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5000
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ibrahim@schenk.isar.de
Precedence: bulk
X-list: linux-mips

Hi,

I'm trying to run Linux 2.4.26 from current CVS
on a Jaguar-ATX board. What can I do about this
message: "Kernel panic: Invalid kernel address"?

Here is the complete console output:

Mips64 Jaguar-ATX
cpu_clock set to 1000000000
mv64340_base set to 0xfffffffff4000000
arcs_cmdline: tftp://172.22.10.24/vmlinux console=ttyS0,38400 
nfsroot=172.22.10.
24:/home/mipsroot ip=172.22.110.5
CPU revision is: 00003430
FPU revision is: 00003420
Primary instruction cache 16kB, physically tagged, 4-way, linesize 32 bytes.
Primary data cache 16kB 4-way, linesize 32 bytes.
Secondary cache size 256K, linesize 32 bytes.
Enabling secondary cache...Linux version 2.4.26 (imr@pcimr4) (gcc 
version 3.3.3)
  #102 Fri May 14 09:17:06 CEST 2004
PMON_v2_setup
Momentum Jaguar-ATX: Board Assembly Rev. B
FPGA Rev: 2.0
Reset reason: 0x1
   - Power-up reset
Board Status register: 0x00
   - User jumper: absent
   - Boot flash write jumper: absent
Jaguar ATX DMA-low mode set
Determined physical RAM map:
  memory: 0000000008000000 @ 0000000000000000 (usable)
  memory: 0000000010000000 @ 0000000008000000 (usable)
On node 0 totalpages: 98304
zone(0): 98304 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: tftp://172.22.10.24/vmlinux console=ttyS0,38400 
nfsroot=172
.22.10.24:/home/mipsroot ip=172.22.110.5
Using 500.000 MHz high precision timer.
Calibrating delay loop... 999.42 BogoMIPS
Memory: 251776k/393216k available (1399k kernel code, 141440k reserved, 
128k dat
a, 80k init)
Dentry cache hash table entries: 65536 (order: 8, 1048576 bytes)
Inode cache hash table entries: 32768 (order: 7, 524288 bytes)
Mount cache hash table entries: 256 (order: 0, 4096 bytes)
Buffer cache hash table entries: 32768 (order: 6, 262144 bytes)
Page-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Checking for 'wait' instruction...  unavailable.
Checking for the multiply/shift bug... no.
Checking for the daddi bug... no.
Checking for the daddiu bug... no.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with SHARE_IRQ enabled
ttyS00 at 0xfffffffffd000020 (irq = 7) is a 16550A
rtc: IRQ 8 is not free.
Generic MIPS RTC Driver v1.0
loop: loaded (max 8 devices)
MV-64340 10/100/1000 Ethernet Driver
eth0: port 0 with MAC address 00:03:cc:1d:00:98
RX TCP/UDP Checksum Offload ON,
TX and RX Interrupt Coalescing ON
RX NAPI Enabled
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
IP-Config: Guessing netmask 255.255.0.0
IP-Config: Complete:
       device=eth0, addr=172.22.110.5, mask=255.255.0.0, gw=255.255.255.255,
      host=172.22.110.5, domain=, nis-domain=(none),
      bootserver=255.255.255.255, rootserver=172.22.10.24, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 172.22.10.24
Looking up port of RPC 100005/1 on 172.22.10.24
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 80k freed
Kernel panic: Invalid kernel address
In interrupt handler - not syncing


Is there any way I can fix this?

Thanks for your help
Rojhalat Ibrahim
