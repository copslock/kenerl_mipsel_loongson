Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jan 2005 15:23:40 +0000 (GMT)
Received: from schenk.ISAR.de ([IPv6:::ffff:212.14.78.13]:17961 "EHLO
	schenk.isar.de") by linux-mips.org with ESMTP id <S8225243AbVAJPXf>;
	Mon, 10 Jan 2005 15:23:35 +0000
Received: from gwhaus.rt.schenk (gwhaus.rt.schenk [172.22.0.4])
	by schenk.isar.de (8.11.6/8.11.6/SuSE Linux 0.5) with ESMTP id j0AFNX415775;
	Mon, 10 Jan 2005 16:23:33 +0100
Received: from [172.22.10.24] (pcimr4.rt.schenk [172.22.10.24])
	by gwhaus.rt.schenk (8.11.6/8.11.6/SuSE Linux 0.5) with ESMTP id j0AFNXi10619;
	Mon, 10 Jan 2005 16:23:33 +0100
Message-ID: <41E29DF5.6040800@schenk.isar.de>
Date: Mon, 10 Jan 2005 16:23:33 +0100
From: Rojhalat Ibrahim <ibrahim@schenk.isar.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040617
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
CC: linux-mips@linux-mips.org
Subject: Re: [PATCH] Further TLB handler optimizations
References: <20041223202526.GA2254@deprecation.cyrius.com> <20041224040051.93587.qmail@web52806.mail.yahoo.com> <20041224085645.GJ3539@rembrandt.csv.ica.uni-stuttgart.de> <20050107190605.GG31335@rembrandt.csv.ica.uni-stuttgart.de> <41E27A6A.5060204@schenk.isar.de> <20050110140429.GC15344@rembrandt.csv.ica.uni-stuttgart.de>
In-Reply-To: <20050110140429.GC15344@rembrandt.csv.ica.uni-stuttgart.de>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ibrahim@schenk.isar.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6866
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ibrahim@schenk.isar.de
Precedence: bulk
X-list: linux-mips

Thiemo Seufer wrote:
> Rojhalat Ibrahim wrote:
> 
>>Thiemo Seufer wrote:
>>
>>>I updated the patch now and checked it in. Please test, especially
>>>for cases I couldn't do, like R3000-style TLB handling and MIPS32
>>>CPUs with 64bit physaddr.
>>>
>>
>>My Yosemite board (RM9000 processor) does not boot anymore with
>>CONFIG_64BIT_PHYS_ADDR. Without that option it seems to be working
>>as before. I tried to define cpu_has_64bit_gp_regs.
> 
> 
> Correct, this should always be defined for 64bit capable CPUs.
> 
> 
Ok. But before it was working without that setting.
Furthermore, without cpu_has_64bit_gp_regs and without
CONFIG_64BIT_PHYS_ADDR I get a working kernel. With
cpu_has_64bit_gp_regs defined the kernel fails with
or without CONFIG_64BIT_PHYS_ADDR.

>>With that it boots partly.
> 
> 
> Where does it fail?
> 
> 
Actually the kernel seems to boot completely
but never starts init. It just stops after the
last line.

The console output looks like this:

Linux version 2.6.10 (imr@pcimr4) (gcc version 3.4.3) #334 Mon Jan 10 
16:11:13 C
ET 2005
CPU revision is: 00003440
FPU revision is: 00003420
Determined physical RAM map:
  memory: 10000000 @ 00000000 (usable)
Built 1 zonelists
Kernel command line: tftp://172.22.10.24/vmlinux 
nfsroot=172.22.10.24:/home/mips
root ip=172.22.110.5 console=ttyS0,115200
Unknown boot option `tftp://172.22.10.24/vmlinux': ignoring
Primary instruction cache 16kB, physically tagged, 4-way, linesize 32 bytes.
Primary data cache 16kB, 4-way, linesize 32 bytes.
Secondary cache enabled.
Synthesized TLB refill handler (27 instructions).
Synthesized TLB load handler fastpath (39 instructions).
Synthesized TLB store handler fastpath (39 instructions).
Synthesized TLB modify handler fastpath (38 instructions).
PID hash table entries: 2048 (order: 11, 32768 bytes)
Using 500.000 MHz high precision timer.
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 256576k/262144k available (1431k kernel code, 5400k reserved, 
236k data,
  108k init, 0k highmem)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Checking for 'wait' instruction...  available.
NET: Registered protocol family 16
Can't analyze prologue code at 802645ac
Generic RTC Driver v1.07
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
ttyS0 at MMIO 0x0 (irq = 4) is a ST16650
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
loop: loaded (max 8 devices)
PMC-Sierra TITAN 10/100/1000 Ethernet Driver
Device Id : 9220,  Version : 1
eth0: port 0 with MAC address 00:e0:04:00:00:21
Rx NAPI supported, Tx Coalescing ON
eth1: port 1 with MAC address 00:e0:04:00:00:22
Rx NAPI supported, Tx Coalescing ON
eth2: port 2 with MAC address 00:e0:04:00:00:23
Rx NAPI supported, Tx Coalescing ON
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET: Registered protocol family 1
NET: Registered protocol family 17
Assigned IRQ 3 to port 0
Assigned IRQ 2 to port 1
eth1: Error opening interface
IP-Config: Failed to open eth1
Assigned IRQ 1 to port 2
eth2: Error opening interface
IP-Config: Failed to open eth2
IP-Config: Guessing netmask 255.255.0.0
IP-Config: Complete:
       device=eth0, addr=172.22.110.5, mask=255.255.0.0, gw=255.255.255.255,
      host=172.22.110.5, domain=, nis-domain=(none),
      bootserver=255.255.255.255, rootserver=172.22.10.24, rootpath=
Looking up port of RPC 100003/2 on 172.22.10.24
Looking up port of RPC 100005/1 on 172.22.10.24
VFS: Mounted root (nfs filesystem) readonly.
Freeing unused kernel memory: 108k freed
