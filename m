Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Aug 2005 15:13:35 +0100 (BST)
Received: from static-151-204-232-50.bos.east.verizon.net ([IPv6:::ffff:151.204.232.50]:16820
	"EHLO mail2.sicortex.com") by linux-mips.org with ESMTP
	id <S8225438AbVHCONP>; Wed, 3 Aug 2005 15:13:15 +0100
Received: from ws118.sicortex.com (ws118.sicortex.com [10.0.0.118])
	by mail2.sicortex.com (Postfix) with ESMTP id E207D1BFF0E;
	Wed,  3 Aug 2005 10:16:28 -0400 (EDT)
From:	Joshua Wise <mips@joshuawise.com>
To:	linux-mips@linux-mips.org
Subject: SMP badness on 5kc
Date:	Wed, 3 Aug 2005 10:16:27 -0400
User-Agent: KMail/1.8
Cc:	ralf@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508031016.28227.mips@joshuawise.com>
Return-Path: <mips@joshuawise.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8686
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mips@joshuawise.com
Precedence: bulk
X-list: linux-mips

Hi all,

I have been setting up a simulation of a multiprocessor 5kc board that my 
company is developing using gxemul, and I've come across a few problems with 
the MIPS SMP support.

The first issue that I came across was that 5kc does not have an scache, and 
hence r4k_blast_scache will be null, and hence local_r4k_flush_icache_range 
crashes the system with a kernel NULL dereference. (Actually, that happens 
early enough that it drops back into YAMON, without even giving me a kernel 
panic.) Strangely enough, this only happens on SMP... My solution for this 
was to put a switch statement like the one in local_r4k___flush_cache_all 
into local_r4k_flush_icache_range around the if 
(!cpu_icache_snoops_remote_store). This seemed to cause the crash to stop 
happening.

My second issue, unresolved to date, is that we are calling 
on_each_cpu(local_r4k___flush_cache_all) (called from r4k_flush_cache_all) 
while interrupts are disabled. This doesn't happen while we are bringing up 
CPUs 0 or 1 -- it seems to only happen when bringing up CPU2. This causes a 
"badness" message, followed by either a lot of oopses, or a deadlock. Below 
my sig is a boot log from serial, complete with debug messages written by the 
Sirius Cybernetics Corporation. :)

 I'm not quite sure what to make of this, but I am willing to do any 
diagnostics that you need. On request, I can also post my implementations of 
the prom_ functions, although they're pretty straightforward -- they map 
almost directly to gxemul's fake mp device.

Thanks,
joshua

wise@ws118:~/gxemul-<Our Machine>> ./gxemul @gxemul.conf
GXemul-<Our Machine>   Copyright (C) 2003-2005  Anders Gavare
Read the source code and/or documentation for other Copyright messages.

Creating emulation from configfile "gxemul.conf":
    name: "<Our Machine> Simulation"
    machine "<Our Machine>":
        memory: 64 MB

        ***  NOT starting bintrans, as gxemul was compiled without such 
support!

        cpu0 .. cpu5: 5Kc (I+D = 32+32 KB)
        device  0 at 0x0010000000: cons [console]
        device  1 at 0x0011000000: mp
        device  2 at 0x0015000000: ns16550 [emarg serial]
        device  3 at 0x001fc00010: prid
        machine: <Our Machine>
        loading vmlinux.srec:
            SREC "arch/mips/boot/vmlinux.srec"
            entry point 0x802ca000
            0x1fa9f1 bytes loaded
        loading System.map:
            6724 symbols
        loading 0x80400000:initrd.mips:
            RAW: 0x400000 bytes @ 0x80400000
        loading 0x9fc00000:yamon.bin:
            RAW: 0xd9470 bytes @ 0x9fc00000
        starting cpu0 at 0xffffffff9fc00000
-------------------------------------------------------------------------------

CPU BOARD <Our Machine> RAM RAM_HILO RAM_TEST CLEAR COPYTEXT COPYDATA STACK 
INFO CINFO FIRSTC

Environment default switch is in the 'on' position. The environment
has been set to default values. If the switch is not set to 'off',
the environment will be cleared at every reset.

Please set the switch to the 'off' position or type Ctrl-C to continue.

YAMON> go 802ca000
Linux version 2.6.12-rc6<Our CPU>-trunk (wise@ws118) (gcc version 3.4.4) #168 
SMP Wed Aug 3 09:41:47 EDT 2005
CPU revision is: 00018101
FPU revision is: 00038110
Determined physical RAM map:
 memory: 0000000000001000 @ 0000000000000000 (reserved)
 memory: 00000000000ff000 @ 0000000000001000 (ROM data)
 memory: 0000000000218000 @ 0000000000100000 (reserved)
 memory: 0000000003ce8000 @ 0000000000318000 (usable)
On node 0 totalpages: 16384
  DMA zone: 16384 pages, LIFO batch:7
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
Built 1 zonelists
I am running on a <Our Company> <Our Machine>!
Kernel command line:  console=ttyS0,38400n8r
Primary instruction cache 32kB, physically tagged, 2-way, linesize 32 bytes.
Primary data cache 32kB, 2-way, linesize 32 bytes.
About to flush all cache on CPU 0
R4K cache flush time! (0)
Synthesized TLB refill handler (36 instructions).
Synthesized TLB load handler fastpath (50 instructions).
Synthesized TLB store handler fastpath (50 instructions).
Synthesized TLB modify handler fastpath (49 instructions).
Cache parity protection enabled
PID hash table entries: 512 (order: 9, 16384 bytes)
CPU frequency 8.00 MHz
Using 4.000 MHz high precision timer.
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Memory: 60924k/62368k available (1450k kernel code, 1304k reserved, 378k data, 
208k init, 0k highmem)
Calibrating delay loop... 8.19 BogoMIPS (lpj=4096)
Mount-cache hash table entries: 256
Checking for 'wait' instruction...  available.
Checking for the multiply/shift bug... no.
Checking for the daddi bug... no.
Checking for the daddiu bug... no.
Detected 5 available secondary CPU(s)
CPU 1 started.....
CPU revision is: 00018101
FPU revision is: 00038110
Primary instruction cache 32kB, physically tagged, 2-way, linesize 32 bytes.
Primary data cache 32kB, 2-way, linesize 32 bytes.
About to flush all cache on CPU 1
R4K cache flush time! (1)
Synthesized TLB refill handler (36 instructions).
Calibrating delay loop... 8.19 BogoMIPS (lpj=4096)
Finishing init on cpu 1...CPU frequency 8.00 MHz
done
IPI send 0->1: 1
IPI on 1: 1 -- Reschedule myself? Why, certainly!
IPI send 0->1: 1
IPI on 1: 1 -- Reschedule myself? Why, certainly!
CPU 2 started.....
CPU revision is: 00018101
FPU revision is: 00038110
Primary instruction cache 32kB, physically tagged, 2-way, linesize 32 bytes.
Primary data cache 32kB, 2-way, linesize 32 bytes.
About to flush all cache on CPU 2
R4K cache flush time! (2)
SMP_CALL_FUNCTION on CPU 2: I am calling: ffffffff801255a0
Badness in smp_call_function at arch/mips/kernel/smp.c:150
Call Trace:
 [<ffffffff8010bca8>] smp_call_function+0x250/0x258
 [<ffffffff80141924>] printk+0x2c/0x38
 [<ffffffff801256b4>] r4k___flush_cache_all+0x44/0x70
 [<ffffffff80141924>] printk+0x2c/0x38
 [<ffffffff801255a0>] local_r4k___flush_cache_all+0x0/0xd0
 [<ffffffff801256c8>] r4k___flush_cache_all+0x58/0x70
 [<ffffffff802df55c>] ld_mmu_r4xx0+0xc54/0x1ab0
 [<ffffffff802d9c4c>] per_cpu_trap_init+0x1ac/0x1d0
 [<ffffffff8010b9a4>] start_secondary+0x24/0xd8

IPI send 2->0: 2
IPI on 0: 2 -- IPI on 1: 2 -- IPI send 2->1: 2
Call a function? I'd love to!
SMP_CALL_FUNCTION on CPU 2: I am calling: ffffffff80125ef0
Badness in smp_call_function at arch/mips/kernel/smp.c:150
Call Trace:
 [<ffffffff8010bca8>] smp_call_function+0x250/0x258
 [<ffffffff80125ef0>] local_r4k_flush_icache_range+0x0/0x280
 [<ffffffff801261b0>] r4k_flush_icache_range+0x40/0x58
 [<ffffffff802e1934>] build_clear_page+0x144c/0x1e88
 [<ffffffff802df5d0>] ld_mmu_r4xx0+0xcc8/0x1ab0
 [<ffffffff802d9c4c>] Call a function? I'd love to!
per_cpu_trap_init+0x1ac/0x1d0
 [<ffffffff8010b9a4>] start_secondary+0x24/0xd8

IPI send 2->0: 2
IPI send 2->1: 2
IPI on 1: 2 -- Call a function? I'd love to!
[ cpu0: warning: LOW reference vaddr=0x00000000, exception TLBL, 
pc=ffffffff80300a84 <vm_area_cachep+0x4> ]
CPU 0 Unable to hand<1>CPU 0 Unable to handle kernel paging request at virtual 
address 0000000000000000, epc == ffffffff80300a84, <4>ra == fffffffBadness 
in<4> smp_call_function at arch/mips/kernel/smp.c:150
Call Trace:
 [<ffffffff8010bca8>] smp_call_function+0x250/0x258
 [<ffffffff8010bbac>] smp_call_function+0x154/0x258
 [<ffffffff80125ef0>] local_r4k_flush_icache_range+0x0/0x280
 [<ffffffff801261b0>] r4k_flush_icache_range+0x40/0x58
 [<ffffffff802e4f94>] build_copy_page+0x2c24/0x3490
 [<ffffffff801261b8>] r4k_flush_icache_range+0x48/0x58
 [<ffffffff802d9c4c>] Oopsper_cpu_trap_init+0x1ac/0x1d0
 [<ffffffff8010b9a4>] start_secondary+0x24/0xd8

IPI send 2->0: 2
IPI send 2->1: 2
IPI on 1: 2 -- Call a function? I'd love to!
 in arch/mips/mm/fault.c::do_page_fault, line 167[#1]:
Cpu 0
Synthesized TLB refill handler (36 instructions).
SMP_CALL_FUNCTION on CPU 2: I am calling: ffffffff80125ef0
Badness in smp_call_function at arch/mips/kernel/smp.c:150
Call Trace:
 [<ffffffff8010bca8>] smp_call_function+0x250/0x258
 [<ffffffff80125ef0>] local_r4k_flush_icache_range+0x0/0x280
 [<ffffffff801261b0>] r4k_flush_icache_range+0x40/0x58
 [<ffffffff802dd50c>] build_tlb_refill_handler+0x3f4/0x15e8
 [<ffffffff8010b9a4>] start_secondary+0x24/0xd8

IPI send 2->0: 2
IPI send 2->1: 2
IPI on 1: 2 -- Call a function? I'd love to!
Calibrating delay loop... $ 0   : 0000000000000000 ffffffff80300000 
0000000000010000 0000000000010000
$ 4   : 9800000000333e10 ffffffff801261b0 0000000000000001 0000000000000004
$ 8   : 0000000000000004 0000000000000f11 000000000000000a ffffffff80300f43
$12   : ffffffffffffffff ffffffff80301337 0000000000000002 ffffffff802754e0
$16   : ffffffff803008a8 000000001400fce0 0000000000000002 0000000000000002
$20   : ffffffff802ffef8 0000000000000000 0000000000000000 0000000000000000
$24   : 0000000000000000 0000000000000020
$28   : 9800000000330000 9800000000333e10 0000000000000000 ffffffff801261b8
Hi    : 0000000000000004
Lo    : 189374bc6a7f0000
epc   : ffffffff80300a84 0xffffffff80300a84     Not tainted
ra    : ffffffff801261b8 r4k_flush_icache_range+0x48/0x58
Status: 1400fce2    KX SX UX KERNEL EXL
Cause : 0000c008
BadVA : 0000000000000000
PrId  : 00018101
Modules linked in:
Process swapper (pid: 1, threadinfo=9800000000330000, task=980000000032d778)
Stack : 0000000000004000 ffffffff80101abc 0000000000000000 ffffffff802ff520
        0000000000000188 0000000000000000 0000000000000002 0000000000000002
        0000000000001000 004189374bc6a7f0 ffffffff802fff40 0000000000000963
        000000000000000a ffffffff80300f3d ffffffffffffffff ffffffff80301337
        0000000000000002 ffffffff802754e0 0000000000000002 0000000000000002
        0000000000000002 0000000000000002 ffffffff802ffef8 0000000000000000
        0000000000000000 0000000000000000 0000000000000000 0000000000000020
        0000000000000000 ffffffff80141924 9800000000330000 9800000000333f50
        0000000000000000 ffffffff802da64c 000000001400fce3 0000000000000199
        99999999999c0000 9800000000374000 0000000000004000 ffffffff802da6f4
        ...
Call Trace:
 [<ffffffff80101abc>] mipsIRQ+0x15c/0x1c0
 [<ffffffff80141924>] printk+0x2c/0x38
 [<ffffffff802da64c>] __cpu_up+0x3c/0x188
 [<ffffffff802da6f4>] __cpu_up+0xe4/0x188
 [<ffffffff802ea0e4>] cpu_up+0x15c/0x270
 [<ffffffff802ea0d0>] cpu_up+0x148/0x270
 [<ffffffff80100e80>] init+0x9a8/0xa78
 [<ffffffff801044a8>] kernel_thread_helper+0x10/0x18
 [<ffffffff80104498>] kernel_thread_helper+0x0/0x18


Code: 00000000  00000000  011638a0 <98000000> 01163aa0  98000000  011639a0  
98000000  01163ba0
IPI on 0: 2 -- Call a function? I'd love to!
IPI on 0: 2 -- Call a function? I'd love to!
IPI on 0: 2 -- Call a function? I'd love to!
Kernel panic - not syncing: Aiee, killing interrupt handler!
 SMP_CALL_FUNCTION on CPU 0: I am calling: ffffffff8010bd78
IPI send 0->1: 2
IPI on 1: 2 -- Call a function? I'd love to!
        
