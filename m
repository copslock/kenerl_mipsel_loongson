Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jan 2005 17:14:21 +0000 (GMT)
Received: from schenk.ISAR.de ([IPv6:::ffff:212.14.78.13]:45132 "EHLO
	schenk.isar.de") by linux-mips.org with ESMTP id <S8225203AbVARROM>;
	Tue, 18 Jan 2005 17:14:12 +0000
Received: from gwhaus.rt.schenk (gwhaus.rt.schenk [172.22.0.4])
	by schenk.isar.de (8.11.6/8.11.6/SuSE Linux 0.5) with ESMTP id j0IHDm430324;
	Tue, 18 Jan 2005 18:13:48 +0100
Received: from [172.22.10.24] (pcimr4.rt.schenk [172.22.10.24])
	by gwhaus.rt.schenk (8.11.6/8.11.6/SuSE Linux 0.5) with ESMTP id j0IHDli08863;
	Tue, 18 Jan 2005 18:13:48 +0100
Message-ID: <41ED43CB.9030101@schenk.isar.de>
Date: Tue, 18 Jan 2005 18:13:47 +0100
From: Rojhalat Ibrahim <ibrahim@schenk.isar.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040617
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Manish Lachwani <m_lachwani@yahoo.com>
CC: linux-mips@linux-mips.org
Subject: Re: More than 512MB of memory
References: <20050118154925.8835.qmail@web52802.mail.yahoo.com>
In-Reply-To: <20050118154925.8835.qmail@web52802.mail.yahoo.com>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ibrahim@schenk.isar.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6940
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ibrahim@schenk.isar.de
Precedence: bulk
X-list: linux-mips

Hi,

here is the boot log including the crash.

Thanks
Rojhalat Ibrahim


PMON2000 MIPS Initializing. Standby...
ERRORPC=00000000 CONFIG=004264b0 STATUS=00400000
CPU PRID 00003440, MaskID 00000612
Setting up SDRAM controller: sdram config 0x0003adef
master clock 100 Mhz, MulFundBIU 0x08, DivXSDRAM 0x05
sdram freq 0x09896800 hz, sdram period: 0x06 nsec
dimm0: density 512Mbit, width 8, double-sided, unbuffered, size 0x40000000
   supported CAS latency: 3 2.5 2, using 2 cycles
   RAS to CAS delay (tRCD) 0x0f nsec
       setting rank timing tRCD to 0x03 cycles
   precharge to bank activation delay (tRP) 0x0f nsec
       setting rank timing tRP to 0x03 cycles
   bank activation delay and refresh recovery (tRC) 0x37 nsec
       setting rank timing tRC to 0x0b cycles
   minimum auto-refresh to active/auto-refresh (tRFC) 0x41 nsec
       setting rank timing tRFC to 0x0b cycles
   reduced refresh rate of 7800 nsec
       setting rank timing tREF to 0x0050 cycles
   rank0: base 0x00000000 size 0x10000000 timing 0x2c50b900 cfg 0x00000031
   rank1: base 0x20000000 size 0x01000000 timing 0x2c50b900 cfg 0x00000031
dimm1: not present
Clearing first 1MB of memory...done
Initializing caches...done
Copy PMON to execute location...done
PMON stack at 8000f800
OCD base address moved to fb000000
cpu1 in holding location
mainbus0 (root)
localbus0 at mainbus0
rme0 at localbus0: adr 00:e0:04:00:00:9f
eephy0 at rme0 phy 0: Marvell 88E1000* Gigabit PHY
rme1 at localbus0: adr 00:e0:04:00:00:a0
eephy1 at rme1 phy 1: Marvell 88E1000* Gigabit PHY
rme2 at localbus0: adr 00:e0:04:00:00:a1
eephy2 at rme2 phy 2: Marvell 88E1000* Gigabit PHY
pcibr0 at mainbus0
pci0 at pcibr0 bus 0
network configure 'rme0:172.22.110.5:255.255.0.0'
rme0: link is up, MII, 100 Mbit, full duplex

Configuration [YOSEMITE,EL,SMP,NET]
Version: PMON2000 imr (YOSEMITE-EL) #18: Mon Jan 17 11:52:39 CET 2005.
Supported loaders [srec, elf, bin]
Supported filesystems [net, socket, tty]
This software may be redistributed under the BSD copyright.
BSP Copyright 2004, PMC-Sierra, Inc.
CPU E9000 @ 1000.00 MHz / Bus @ 160.00 MHz
Memory size 1024 MB.
Primary Instruction cache size 16KB (32 line, 4 way)
Primary Data cache size 16KB (32 line, 4 way)
Secondary cache size 256KB
Dual processor system running.
rank0 update: LKM1 0x01ffff00
rank1 update: LKM2 0x01ffff00

PMON>
PMON>
PMON> $linux
Loading file: tftp://172.22.10.24/vmlinux (elf)
0x80100000/1798276 + 0x802b7084/122780(z) + 3702 syms\
Linux version 2.6.10 (imr@pcimr4) (gcc version 3.4.3) #383 Tue Jan 18 
15:57:08 C
ET 2005
CPU revision is: 00003440
FPU revision is: 00003420
Determined physical RAM map:
  memory: 40000000 @ 00000000 (usable)
512MB HIGHMEM available.
Built 1 zonelists
Kernel command line: tftp://172.22.10.24/vmlinux 
nfsroot=172.22.10.24:/home/mips
root ip=172.22.110.5 console=ttyS0,115200
Unknown boot option `tftp://172.22.10.24/vmlinux': ignoring
Primary instruction cache 16kB, physically tagged, 4-way, linesize 32 bytes.
Primary data cache 16kB, 4-way, linesize 32 bytes.
Secondary cache enabled.
Synthesized TLB refill handler (26 instructions).
Synthesized TLB load handler fastpath (39 instructions).
Synthesized TLB store handler fastpath (39 instructions).
Synthesized TLB modify handler fastpath (38 instructions).
PID hash table entries: 4096 (order: 12, 65536 bytes)
Using 500.000 MHz high precision timer.
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1036096k/524288k available (1416k kernel code, 11988k reserved, 
231k dat
a, 108k init, 524288k highmem)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Checking for 'wait' instruction...  available.
NET: Registered protocol family 16
Can't analyze prologue code at 802608ec
highmem bounce pool size: 64 pages
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
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
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
CPU 0 Unable to handle kernel paging request at virtual address 
00000000, epc ==
  8010cd20, ra == 8010e0a0
Oops in arch/mips/mm/fault.c::do_page_fault, line 166[#1]:
Cpu 0
$ 0   : 00000000 90009800 802c0000 00001000
$ 4   : 00000000 817ff100 ffffffbf 802c2b58
$ 8   : 90009801 1000001e 81b54540 00000000
$12   : 0000000c 00000078 0001ffff 00000000
$16   : 00000000 817ff100 817ff100 81b54540
$20   : 802a5414 2aaa8a70 00000000 00000000
$24   : 00000000 00000000
$28   : 802f0000 802f1dc0 00000000 8010e0a0
Hi    : 000f41fa
Lo    : 9aa824c0
epc   : 8010cd20 r4k_blast_dcache_page_dc32+0x4/0x9c     Not tainted
ra    : 8010e0a0 r4k_flush_icache_page+0x60/0xac
Status: 90009803    KERNEL EXL IE
Cause : 00000008
BadVA : 00000000
PrId  : 00003440
Process init (pid: 1, threadinfo=802f0000, task=818efb48)
Stack : 802a6c58 00000000 81b80554 81b54540 802a5414 817ff100 802c0000 
00000000
         8014f2b0 8014f250 00000000 00000000 802f1df8 8014d2b8 00000001 
0000000b
         00000000 00000000 81b80554 2aaa8a70 802b2d00 802a5414 00000000 
00000000
         80270000 8014fc5c 802b2d00 817fffe0 802803f0 81a8c600 81b54540 
81b80554
         00000000 81a8c602 818efb48 2aaa8a70 00030000 802f1f30 802b2d00 
802b2d2c
         ...
Call Trace:
  [<802a6c58>] ld_mmu_r4xx0+0xa90/0xe3c
  [<802a5414>] build_tlb_refill_handler+0x3f8/0xf40
  [<8014f2b0>] do_no_page+0x248/0x814
  [<8014f250>] do_no_page+0x1e8/0x814
  [<8014d2b8>] pte_alloc_map+0x110/0x150
  [<802b2d00>] inet_init+0x10c/0x550
  [<802a5414>] build_tlb_refill_handler+0x3f8/0xf40
  [<8014fc5c>] handle_mm_fault+0x3e0/0x470
  [<802b2d00>] inet_init+0x10c/0x550
  [<802b2d00>] inet_init+0x10c/0x550
  [<802b2d2c>] inet_init+0x138/0x550
  [<802a5414>] build_tlb_refill_handler+0x3f8/0xf40
  [<8010a488>] do_page_fault+0x258/0x3a0
  [<8016bfcc>] getname+0x2c/0xf8
  [<80105990>] sys_execve+0x64/0x7c
  [<801207d8>] __call_console_drivers+0x84/0xb0
  [<80108c80>] stack_done+0x20/0x3c
  [<802b0000>] serial8250_init+0xa4/0x12c
  [<8010aa74>] tlb_do_page_fault_0+0xf4/0xfc
  [<802b0000>] serial8250_init+0xa4/0x12c


Code: 03e00008  00000000  24831000 <bc950000> bc950020  bc950040 
bc950060  bc95
0080  bc9500a0
Kernel panic - not syncing: Attempted to kill init!



Manish Lachwani wrote:
> Hello !
> 
> I have used Yosemite with 1 GB memory in both 32-bit
> and 64-bit modes. However, 2.4 kernel though.
> 
> Can you please send the boot log of PMON and Linux.
> What is the crash?
> 
> Thanks
> Manish Lachwani
> 
> --- Rojhalat Ibrahim <ibrahim@schenk.isar.de> wrote:
> 
> 
>>Hi,
>>
>>is there anything special I have to do
>>when I want to use more than 512MB of memory?
>>My Yosemite board works fine with 512MB
>>but when I try 1GB it crashes in 32bit mode
>>with highmem and also in 64bit mode.
>>The boot monitor (PMON) maps the 1024MB
>>to physical addresses 0x0000.0000 - 0x4000.0000.
>>
>>Thanks
>>Rojhalat Ibrahim
>>
>>
>>
> 
> 
> 
> =====
> http://www.koffee-break.com
> 
