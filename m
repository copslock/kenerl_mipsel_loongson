Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Mar 2005 15:02:51 +0000 (GMT)
Received: from spartan.ac.BrockU.CA ([IPv6:::ffff:139.57.65.3]:15790 "EHLO
	spartan.ac.BrockU.CA") by linux-mips.org with ESMTP
	id <S8225978AbVCEPCe>; Sat, 5 Mar 2005 15:02:34 +0000
Received: from spartan.ac.BrockU.CA (localhost.localdomain [127.0.0.1])
	by spartan.ac.BrockU.CA (8.12.8/8.12.8) with ESMTP id j25F2Rgc030213
	for <linux-mips@linux-mips.org>; Sat, 5 Mar 2005 10:02:27 -0500
Received: (from pchapman@localhost)
	by spartan.ac.BrockU.CA (8.12.8/8.12.8/Submit) id j25F2RAp030211
	for linux-mips@linux-mips.org; Sat, 5 Mar 2005 10:02:27 -0500
Date:	Sat, 5 Mar 2005 10:02:27 -0500
From:	Paul Chapman <pchapman@spartan.ac.BrockU.CA>
To:	linux-mips@linux-mips.org
Subject: Re: still ip27 problems
Message-ID: <20050305150227.GA27220@spartan.ac.BrockU.CA>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <pchapman@spartan.ac.BrockU.CA>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7374
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pchapman@spartan.ac.BrockU.CA
Precedence: bulk
X-list: linux-mips

Hello,

I've got an IP27 up and running with 2.6.11 from CVS, and it seems
pretty robust.  I cross-compiled from x86 with the handy-dandy RPMS
kindly provided by Maciej (see "Toolchains" in the wiki).  I used:

binutils-mips64-linux-2.15-1
gcc-mips64-linux-3.4.3-1

The ip27 defconfigs produce a workable system.

Previous 2.6.11-rc* CVS versions were broken on ip27.

HOWEVER, I have only been able to get my Origin 200 to work with
one node.  If I hook up the other node, I get lots of woe (woe enclosed
below).  If you're using more than one node, I suggest unhooking the
others to start off with..

If you can't xcompile, I can send you my vmlinux + modules..

-Paul Chapman

Linux version 2.6.11 (pchapman@paul.dev.brocku.ca) (gcc version 3.4.3) #11 SMP Thu Mar 3 09:11:55
ARCH: SGI-IP27
PROMLIB: ARC firmware Version 64 Revision 0
Discovered 4 cpus on 2 nodes
node_distance: router_a NULL
node_distance: router_a NULL
node_distance: router_a NULL
node_distance: router_a NULL
************** Topology ********************
    00 01 
00  255 255 
01  255 255 
CPU revision is: 00000e35
FPU revision is: 00000900
IP27: Running on node 0.
Node 0 has a primary CPU, CPU is running.
Node 0 has a secondary CPU, CPU is running.
Machine is in M mode.
CPU 0 clock is 360MHz.
Cpu 0, Nasid 0x0: partnum 0xc002 is a bridge
Determined physical RAM map:
Built 2 zonelists
Kernel command line: root=/dev/sdc1 root=/dev/sdc1
Primary instruction cache 32kB, physically tagged, 2-way, linesize 64 bytes.
Primary data cache 32kB, 2-way, linesize 32 bytes.
Unified secondary cache 4096kB 2-way, linesize 128 bytes.
Synthesized TLB refill handler (41 instructions).
Synthesized TLB load handler fastpath (55 instructions).
Synthesized TLB store handler fastpath (55 instructions).
Synthesized TLB modify handler fastpath (54 instructions).
PID hash table entries: 4096 (order: 12, 131072 bytes)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Memory: 502592k/524288k available (2781k kernel code, 21696k reserved, 1056k data, 224k init, 0k)
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
Checking for 'wait' instruction...  unavailable.
Checking for the multiply/shift bug... no.
Checking for the daddi bug... no.
Checking for the daddiu bug... no.
per-CPU timeslice cutoff: 11989235.47 usecs.
task migration cache decay timeout: 11961 msecs.
REPLICATION: ON nasid 0, ktext from nasid 0, kdata from nasid 0
REPLICATION: ON nasid 1, ktext from nasid 0, kdata from nasid 0
CPU revision is: 00000e35
FPU revision is: 00000900
Primary instruction cache 32kB, physically tagged, 2-way, linesize 64 bytes.
Primary data cache 32kB, 2-way, linesize 32 bytes.
Unified secondary cache 4096kB 2-way, linesize 128 bytes.
Synthesized TLB refill handler (41 instructions).
CPU 1 clock is 360MHz.
CPU revision is: 00000e35
FPU revision is: 00000900
Primary instruction cache 32kB, physically tagged, 2-way, linesize 64 bytes.
Primary data cache 32kB, 2-way, linesize 32 bytes.
Unified secondary cache 4096kB 2-way, linesize 128 bytes.
Badness in smp_call_function at arch/mips/kernel/smp.c:167
Call Trace:
 [<a80000000002a4c0>] smp_call_function+0x1f0/0x1f8
 [<a80000000005b1f4>] printk+0x2c/0x38
 [<a80000000003ed20>] local_r4k___flush_cache_all+0x0/0xc8
 [<a80000000003ee20>] r4k___flush_cache_all+0x38/0x50
 [<a8000000003ee914>] ld_mmu_r4xx0+0xab4/0x13f0
 [<a8000000003e9648>] per_cpu_trap_init+0x158/0x180
 [<a80000000002a224>] start_secondary+0x24/0xd0

Badness in smp_call_function at arch/mips/kernel/smp.c:167
Call Trace:
 [<a80000000002a4c0>] smp_call_function+0x1f0/0x1f8
 [<a80000000003f258>] local_r4k_flush_icache_range+0x0/0x148
 [<a80000000003f3e0>] r4k_flush_icache_range+0x40/0x58
 [<a8000000000275a4>] dump_stack+0x14/0x20
 [<a8000000003f047c>] build_clear_page+0x10f4/0x1220
 [<a8000000003ee980>] ld_mmu_r4xx0+0xb20/0x13f0
 [<a8000000003e9648>] per_cpu_trap_init+0x158/0x180
 [<a80000000002a224>] start_secondary+0x24/0xd0

Badness in smp_call_function at arch/mips/kernel/smp.c:167
Call Trace:
 [<a80000000002a4c0>] smp_call_function+0x1f0/0x1f8
 [<a80000000003f258>] local_r4k_flush_icache_range+0x0/0x148
 [<a8000000000275a4>] dump_stack+0x14/0x20
 [<a80000000003f258>] local_r4k_flush_icache_range+0x0/0x148
 [<a80000000003f3e0>] r4k_flush_icache_range+0x40/0x58
 [<a8000000003f2174>] build_copy_page+0x1bcc/0x1fe0
 [<a8000000000275a4>] dump_stack+0x14/0x20
 [<a8000000003e9648>] per_cpu_trap_init+0x158/0x180
 [<a80000000002a224>] start_secondary+0x24/0xd0

Synthesized TLB refill handler (41 instructions).
Badness in smp_call_function at arch/mips/kernel/smp.c:167
Call Trace:
 [<a80000000002a4c0>] smp_call_function+0x1f0/0x1f8
 [<a80000000003f258>] local_r4k_flush_icache_range+0x0/0x148
 [<a80000000003f3e0>] r4k_flush_icache_range+0x40/0x58
 [<a8000000003ecb18>] build_tlb_refill_handler+0x3d8/0x1548
 [<a8000000003f2174>] build_copy_page+0x1bcc/0x1fe0
 [<a8000000000275a4>] dump_stack+0x14/0x20
 [<a80000000002a224>] start_secondary+0x24/0xd0

CPU 2 clock is 360MHz.
Cpu 2, Nasid 0x1: partnum 0xc002 is a bridge
Oops in arch/mips/mm/fault.c::do_page_fault, line 167[#1]:
Cpu 0
$ 0   : 0000000000000000 0000000000420000 0000000000010000 0000000000010100
$ 4   : 0000000000000000 0000000000000000 0000000000000001 000000000000003f
$ 8   : 00000000fffb6d8e a80000011bff0c80 0000000000000000 0000000000008000
$12   : 0000000000000400 000000001000001f 0000000000000000 9600000100002400
$16   : 0000000000000000 9200000001000000 9200000001000098 0000000000000000
$20   : a8000001009f7c90 a80000000042d080 0000000000000000 000000000000000a
$24   : 0000000000000000 ffffffffbfc00038                                  
$28   : a8000001009f4000 a8000001009f7c50 0000000000000000 a80000000002a53c
Hi    : 0000000000000000
Lo    : 0000000000000000
epc   : 0000000000000000 0x0     Not tainted
ra    : a80000000002a53c smp_call_function_interrupt+0x74/0xc8
Status: 94001ce2    KX SX UX KERNEL EXL 
Cause : 0000c008
BadVA : 0000000000000000
PrId  : 00000e35
Modules linked in:
Process swapper (pid: 1, threadinfo=a8000001009f4000, task=a80000001bfa57f8)
Stack : 0000000000000200 a80000000001d8c0 0000000000000400 0000000000000002
        0000000000000002 0000000000000002 a800000000422c78 a800000000021630
        0000000000000000 ffffffff94201ce1 a80000000042d080 0000000000000000
        0000000000000002 a800000100652520 0000000000000001 000000000000003f
        00000000fffb6d8e a80000011bff0c80 0000000000000000 0000000000008000
        0000000000001000 000000001000001f 0000000000000000 9600000100002400
        0000000000000002 0000000000000002 0000000000000002 0000000000000002
        a800000000422c78 a80000000042d080 0000000000000000 000000000000000a
        0000000000000000 ffffffffbfc00038 0000000000000000 0000000000000000
        a8000001009f4000 a8000001009f7dc0 0000000000000000 a800000000061ea0
        ...
Call Trace:
 [<a80000000001d8c0>] ip27_do_irq_mask0+0x190/0x198
 [<a800000000021630>] ret_from_irq+0x0/0x10
 [<a800000000061ea0>] do_softirq+0x98/0xb8
 [<a800000000061c5c>] __do_softirq+0x8c/0x238
 [<a800000000061ea0>] do_softirq+0x98/0xb8
 [<a800000000021630>] ret_from_irq+0x0/0x10
 [<a80000000002a74c>] __cpu_up+0x3c/0x188
 [<a80000000002a7f4>] __cpu_up+0xe4/0x188
 [<a80000000007b31c>] cpu_up+0x19c/0x2b0
 [<a80000000007b308>] cpu_up+0x188/0x2b0
 [<a80000000001ced8>] init+0x9f8/0xac0
 [<a8000000000234b8>] kernel_thread_helper+0x10/0x18
 [<a8000000000234a8>] kernel_thread_helper+0x0/0x18


Code: (Bad address in epc)

Kernel panic - not syncing: Aiee, killing interrupt handler!
