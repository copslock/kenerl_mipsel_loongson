Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Feb 2018 00:49:54 +0100 (CET)
Received: from icp-osb-irony-out5.external.iinet.net.au ([203.59.1.221]:39609
        "EHLO icp-osb-irony-out5.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990864AbeBDXtob4T0t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Feb 2018 00:49:44 +0100
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2CIAABcm3da/zXSMGcNThkBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEHAQEBAQGDIIEXgRiDZZkTAQEBAQEBBoE0fJhkLYUYAoMPFQEBAQEBAQE?=
 =?us-ascii?q?BAoY2AQEBAQIBI1YFCwsNAQMDAQIBAgImAgJPCAYNBgIBAYokBRi/b26CJyGEX?=
 =?us-ascii?q?4NyggYBAQEBAQEBAQEBAQEBAQEBAQEbBYEPg1uDJIIwKYJPNoMvBIUGgmUFpCQ?=
 =?us-ascii?q?BiBmEApYkh2mNbYtFNYFzMxoIKAiDA4JSAgEcghhmjl0BAQE?=
X-IPAS-Result: =?us-ascii?q?A2CIAABcm3da/zXSMGcNThkBAQEBAQEBAQEBAQEHAQEBAQG?=
 =?us-ascii?q?DIIEXgRiDZZkTAQEBAQEBBoE0fJhkLYUYAoMPFQEBAQEBAQEBAoY2AQEBAQIBI?=
 =?us-ascii?q?1YFCwsNAQMDAQIBAgImAgJPCAYNBgIBAYokBRi/b26CJyGEX4NyggYBAQEBAQE?=
 =?us-ascii?q?BAQEBAQEBAQEBAQEbBYEPg1uDJIIwKYJPNoMvBIUGgmUFpCQBiBmEApYkh2mNb?=
 =?us-ascii?q?YtFNYFzMxoIKAiDA4JSAgEcghhmjl0BAQE?=
X-IronPort-AV: E=Sophos;i="5.46,462,1511798400"; 
   d="scan'208";a="39847353"
Received: from unknown (HELO [172.16.0.22]) ([103.48.210.53])
  by icp-osb-irony-out5.iinet.net.au with ESMTP; 05 Feb 2018 07:49:33 +0800
Subject: Re: [PATCH] MIPS: CPS: Fix r1 .set mt assembler warning
To:     James Hogan <jhogan@kernel.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
References: <079ec8f9-d2c2-9e29-278e-48e76bbb8de7@linux-m68k.org>
 <20180202120658.GA8479@saruman>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <8e34deb4-33c3-9bdb-8ffb-b93516f16a84@linux-m68k.org>
Date:   Mon, 5 Feb 2018 09:49:37 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180202120658.GA8479@saruman>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <gerg@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62435
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gerg@linux-m68k.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hi James,

On 02/02/18 22:06, James Hogan wrote:
> On Fri, Feb 02, 2018 at 01:34:20PM +1000, Greg Ungerer wrote:
>> James Hogan wrote:
>>> From 17278a91e04f858155d54bee5528ba4fbcec6f87 Mon Sep 17 00:00:00 2001
>>> From: James Hogan <jhogan@kernel.org>
>>> Date: Tue, 14 Nov 2017 12:01:20 +0000
>>> Subject: [PATCH] MIPS: CPS: Fix r1 .set mt assembler warning
>>>
>>> MIPS CPS has a build warning on kernels configured for MIPS32R1 or
>>> MIPS64R1, due to the use of .set mt without a prior .set mips{32,64}r2:
>>>
>>> arch/mips/kernel/cps-vec.S Assembler messages:
>>> arch/mips/kernel/cps-vec.S:238: Warning: the `mt' extension requires MIPS32 revision 2 or greater
>>>
>>> Add .set MIPS_ISA_LEVEL_RAW before .set mt to silence the warning.
>>
>> This change breaks booting for me on a MediaTek MT7621 platform:
>>
>>   ...
>>   Calibrating delay loop... 586.13 BogoMIPS (lpj=2930688)^M
>>   pid_max: default: 32768 minimum: 301^M
>>   Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)^M
>>   Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)^M
>>   Hierarchical SRCU implementation.^M
>>   smp: Bringing up secondary CPUs ...^M
>>   Reserved instruction in kernel code[#1]:^M
>>   CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.15.0-ac0 #3^M
>>   $ 0   : 00000000 00000001 00000000 00000000^M
>>   $ 4   : 8501dd80 00000001 00000004 00000000^M
>>   $ 8   : 00000004 00000002 00000001 ffffffff^M
>>   $12   : 00000000 00000400 00000003 8501de00^M
>>   $16   : 807d5ca0 8501dd80 00000000 00000001^M
>>   $20   : 80842814 00000000 00000001 000000e0^M
>>   $24   : fffffffc 00000001                  ^M
>>   $28   : 85026000 85027de0 00000020 80013538^M
>>   Hi    : 00000006^M
>>   Lo    : 8e778000^M
>>   epc   : 80656620 mips_cps_boot_vpes+0x4c/0x160^M
>>   ra    : 80013538 cps_boot_secondary+0x280/0x440^M
>>   Status: 11000403        KERNEL EXL IE ^M
>>   Cause : 50800028 (ExcCode 0a)^M
>>   PrId  : 0001992f (MIPS 1004Kc)^M
>>
>> If I revert the patch then I can boot up again, all works as expected.
>>
>> I am not exactly using a pure mainline 4.15 source base though.
>> (I have a bunch of additional changes to make this platform actually work).
>>
>> But this patch certainly does trap as above when present. I am using
>> a gcc-5.4.0/binutils-2.25.1 toolchain.
>>
>> Any thoughts?
> 
> Hmm, sorry about that.
> 
> If there is some more of the log which shows code around the EPC
> (usually a few lines below where you stopped), that would be helpful to
> see exactly whats happening. Perhaps it has used a 64-bit instruction.

Sorry, yes, I snipped that a little too much. Below is the full boot log:

Linux version 4.15.0-ac0 (gerg@goober) (gcc version 5.4.0 (GCC)) #2 SMP Mon Feb 5 08:58:57 AEST 2018
SoC Type: MediaTek MT7621 ver:1 eco:3
bootconsole [early0] enabled
CPU0 revision is: 0001992f (MIPS 1004Kc)
MIPS: machine is Accelerated Concepts 6310-EX
Determined physical RAM map:
 memory: 08000000 @ 00000000 (usable)
Initial ramdisk at: 0x84000000 (16777216 bytes)
VPE topology {2,2} total 4
Primary instruction cache 32kB, VIPT, 4-way, linesize 32 bytes.
Primary data cache 32kB, 4-way, PIPT, no aliases, linesize 32 bytes
MIPS secondary cache 256kB, 8-way, linesize 32 bytes.
Zone ranges:
  Normal   [mem 0x0000000000000000-0x0000000007ffffff]
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000000000000-0x0000000007ffffff]
Initmem setup node 0 [mem 0x0000000000000000-0x0000000007ffffff]
random: get_random_bytes called from start_kernel+0x90/0x4b4 with crng_init=0
percpu: Embedded 15 pages/cpu @(ptrval) s30336 r8192 d22912 u61440
Built 1 zonelists, mobility grouping on.  Total pages: 32512
Kernel command line: console=ttyS0,57600 rd_start=0x84000000 rd_size=0x01000000
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Writing ErrCtl register=0004ae58
Readback ErrCtl register=0004ae58
Memory: 104556K/131072K available (6492K kernel code, 227K rwdata, 1452K rodata, 264K init, 262K bss, 26516K reserved, 0K cma-reserved)
SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
Hierarchical RCU implementation.
NR_IRQS: 256
clocksource: GIC: mask: 0xfffffffff max_cycles: 0xfffffffff, max_idle_ns: 34750190079 ns
sched_clock: 32 bits at 100 Hz, resolution 10000000ns, wraps every 21474836475000000ns
Calibrating delay loop... 586.13 BogoMIPS (lpj=2930688)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
Hierarchical SRCU implementation.
smp: Bringing up secondary CPUs ...
Reserved instruction in kernel code[#1]:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.15.0-ac0 #2
$ 0   : 00000000 00000001 00000000 00000000
$ 4   : 8501dd80 00000001 00000004 00000000
$ 8   : 00000004 00000002 00000001 ffffffff
$12   : 00000000 00000400 00000003 8501de00
$16   : 807d5ca0 8501dd80 00000000 00000001
$20   : 80842814 00000000 00000001 000000e0
$24   : fffffffc 00000001                  
$28   : 85026000 85027de0 00000020 80013538
Hi    : 00000006
Lo    : 8e778000
epc   : 80656620 mips_cps_boot_vpes+0x4c/0x160
ra    : 80013538 cps_boot_secondary+0x280/0x440
Status: 11000403	KERNEL EXL IE 
Cause : 50800028 (ExcCode 0a)
PrId  : 0001992f (MIPS 1004Kc)
Modules linked in:
Process swapper/0 (pid: 1, threadinfo=(ptrval), task=(ptrval), tls=00000000)
Stack : 00000000 807d6170 00000004 00000000 00000001 00000001 00000000 807e0000
        00000000 807d6170 00000004 00000000 00000000 80012424 807de840 807de81c
        8074dfe4 00000001 00000001 80028bf4 811191e4 00000001 00000000 807e0000
        00000000 811191e4 00000001 80029ac8 807d6068 807e0000 80750ebc 85027e8c
        00000000 8006d584 807d6064 807d0000 807d6068 807e0000 807d0000 00000001
        ...
Call Trace:
[<(ptrval)>] mips_cps_boot_vpes+0x4c/0x160
[<(ptrval)>] cps_boot_secondary+0x280/0x440
[<(ptrval)>] __cpu_up+0x20/0x88
[<(ptrval)>] bringup_cpu+0x24/0x110
[<(ptrval)>] cpu_up+0x128/0x270
[<(ptrval)>] smp_init+0xdc/0x134
[<(ptrval)>] kernel_init_freeable+0xac/0x240
[<(ptrval)>] kernel_init+0x14/0x110
[<(ptrval)>] ret_from_kernel_thread+0x14/0x1c
Code: 35290002  40890001  000000c0 <01c0c02d> 240d0000  31c80001  1100002b  00000000  40080801 

---[ end trace 0daa832a1a349425 ]---
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b


A "mips-linux-objdump -d" around that PC gives:

80656610:       40090001        mfc0    t1,c0_mvpcontrol
80656614:       35290002        ori     t1,t1,0x2
80656618:       40890001        mtc0    t1,c0_mvpcontrol
8065661c:       000000c0        ehb
80656620:       01c0c02d        0x1c0c02d
80656624:       240d0000        li      t5,0
80656628:       31c80001        andi    t0,t6,0x1
8065662c:       1100002b        beqz    t0,806566dc <mips_cps_boot_vpes+0x108>
80656630:       00000000        nop

So it can't decode that "01c0c02d"...


> When I build 32r2el_defconfig, that EPC (relative to mips_cps_boot_vpes)
> is a move instruction, which is implemented with OR (which should be
> safe on MIPS32 and MIPS64), both with binutils 2.28ish and 2.24ish (MTI
> / IMG toolchains, so they may have additional patches).

I am using a strait binutils-2.25.1 and gcc-5.4.0 with no additional patches applied.
(configured with "mips-linux" as the target archiecture).

Regards
Greg


> I'll try limiting the .set mt to code that needs it.
> 
> Thanks
> James
> 
>>
>> Regards
>> Greg
>>
>>
>>> Fixes: 245a7868d2f2 ("MIPS: smp-cps: rework core/VPE initialisation")
>>> Signed-off-by: James Hogan <jhogan@kernel.org>
>>> Cc: Paul Burton <paul.burton@mips.com>
>>> Cc: James Hogan <james.hogan@mips.com>
>>> Cc: James Hogan <jhogan@kernel.org>
>>> Cc: Paul Burton <paul.burton@mips.com>
>>> Cc: linux-mips@linux-mips.org
>>> Patchwork: https://patchwork.linux-mips.org/patch/17699/
>>> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
>>> ---
>>>  arch/mips/kernel/cps-vec.S | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
>>> index c7ed260..e68e6e0 100644
>>> --- a/arch/mips/kernel/cps-vec.S
>>> +++ b/arch/mips/kernel/cps-vec.S
>>> @@ -235,6 +235,7 @@ LEAF(mips_cps_core_init)
>>>         has_mt  t0, 3f
>>>
>>>         .set    push
>>> +       .set    MIPS_ISA_LEVEL_RAW
>>>         .set    mt
>>>
>>>         /* Only allow 1 TC per VPE to execute... */
>>> @@ -388,6 +389,7 @@ LEAF(mips_cps_boot_vpes)
>>>  #elif defined(CONFIG_MIPS_MT)
>>>
>>>         .set    push
>>> +       .set    MIPS_ISA_LEVEL_RAW
>>>         .set    mt
>>>
>>>         /* If the core doesn't support MT then return */
>>> -- 
>>> 1.9.1
>>
