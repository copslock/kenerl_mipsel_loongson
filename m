Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Oct 2017 17:55:22 +0100 (CET)
Received: from adrastea.cedarwireless.com ([IPv6:2620:26:c001:1001:0:1:7:44]:34288
        "EHLO adrastea.cedarwireless.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992366AbdJaQzQPZ6PA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Oct 2017 17:55:16 +0100
Received: from localhost (localhost [127.0.0.1])
        by adrastea.cedarwireless.com (Postfix) with ESMTP id BC634C45
        for <linux-mips@linux-mips.org>; Tue, 31 Oct 2017 09:55:06 -0700 (PDT)
X-Virus-Scanned: amavisd-new at cedarwireless.com
Received: from adrastea.cedarwireless.com ([127.0.0.1])
        by localhost (adrastea.cedarwireless.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ry9J17jGFZb8 for <linux-mips@linux-mips.org>;
        Tue, 31 Oct 2017 09:54:40 -0700 (PDT)
Received: from mail-wm0-f41.google.com (mail-wm0-f41.google.com [74.125.82.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: smtprelay)
        by adrastea.cedarwireless.com (Postfix) with ESMTPSA id 076DBA4C
        for <linux-mips@linux-mips.org>; Tue, 31 Oct 2017 09:54:40 -0700 (PDT)
Received: by mail-wm0-f41.google.com with SMTP id s66so87283wmf.5
        for <linux-mips@linux-mips.org>; Tue, 31 Oct 2017 09:54:39 -0700 (PDT)
X-Gm-Message-State: AMCzsaUtd9crQHV3PD3PBQs7MhAX7N1wvHb6G1M6NRPETMFoLCDiMr1d
        X1P5yVKG0Z5YuP7GV30VSbGQbqWnlvHR4AchcQM=
X-Google-Smtp-Source: ABhQp+RpoSeBqNUrAiMdPyUWjnuqzc6qSN/k9cDvSZaiuk6pamQ6jwMJOmYG6XaVuZu4ypokVM1Gljbu+z27zue/Fxc=
X-Received: by 10.28.91.65 with SMTP id p62mr2199054wmb.126.1509468878218;
 Tue, 31 Oct 2017 09:54:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.163.3 with HTTP; Tue, 31 Oct 2017 09:54:37 -0700 (PDT)
From:   Gabriel Kuri <gkuri@ieee.org>
Date:   Tue, 31 Oct 2017 09:54:37 -0700
X-Gmail-Original-Message-ID: <CAO3KpR3+j86m_Bbq=C0Ws4jR3RHO9oq0Gdkq60JP4szqNKcosQ@mail.gmail.com>
Message-ID: <CAO3KpR3+j86m_Bbq=C0Ws4jR3RHO9oq0Gdkq60JP4szqNKcosQ@mail.gmail.com>
Subject: Octeon CN5010 - Kernel 4.4.92
To:     linux-mips@linux-mips.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <gkuri@ieee.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60611
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gkuri@ieee.org
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

I'm working on getting Kernel 4.4.92 running on a board with a CN5010
processor and 64MB RAM.

The issue I'm running in to is the kernel memory map seems to be
messed up. It's only recognizing 46MB of RAM of the 64MB and only 21MB
are usable of the 46MB it recognizes. Not sure what is wrong, but
could someone give me some guidance on where I could troubleshoot?

Thanks


Below is some relevant kernel output at boot ...


ELF file is 64 bit
Allocated memory for ELF segment: addr: 0x1100000, size 0x16189c8
Loading .text @ 0x81100000 (0x355290 bytes)
Loading __ex_table @ 0x81455290 (0x57c0 bytes)
Loading .rodata @ 0x8145b000 (0xca300 bytes)
Loading .pci_fixup @ 0x81525300 (0x1db8 bytes)
Loading __ksymtab @ 0x815270b8 (0xbdd0 bytes)
Loading __ksymtab_gpl @ 0x81532e88 (0x6710 bytes)
Loading __ksymtab_strings @ 0x81539598 (0x14cfd bytes)
Loading __param @ 0x8154e298 (0x988 bytes)
Clearing __modver @ 0x8154ec20 (0x3e0 bytes)
Loading .data @ 0x8154f000 (0x3cad8 bytes)
Loading .data..page_aligned @ 0x8158c000 (0x4000 bytes)
Loading .init.text @ 0x81590000 (0x2660c bytes)
Loading .init.data @ 0x815b6620 (0x11308 bytes)
Loading .data..percpu @ 0x815c8000 (0x3eb0 bytes)
Clearing .bss @ 0x816d0000 (0x10489c8 bytes)
## Loading OS kernel with entry point: 0x81107920 ...
Bootloader: Done loading app on coremask: 0x1
[    0.000000] Linux version 4.4.92 (gkuri@galileo) (gcc version 5.4.0
(LEDE GCC 5.4.0 r3560-79f57e422d) ) #0 SMP Tue7
[    0.000000] CVMSEG size: 2 cache lines (256 bytes)
[    0.000000] bootconsole [early0] enabled
[    0.000000] CPU0 revision is: 000d0601 (Cavium Octeon+)
[    0.000000] Checking for the multiply/shift bug... no.
[    0.000000] Checking for the daddiu bug... no.
[    0.000000] Determined physical RAM map:
[    0.000000]  memory: 0000000001800000 @ 0000000002800000 (usable)
[    0.000000]  memory: 00000000016189c8 @ 0000000001100000 (usable)
[    0.000000] Wasting 243712 bytes for tracking 4352 unused pages
[    0.000000] Using internal Device Tree.
[    0.000000] software IO TLB [mem 0x0280b000-0x0284b000] (0MB)
mapped at [800000000280b000-800000000284afff]
[    0.000000] Zone ranges:
[    0.000000]   DMA32    [mem 0x0000000001100000-0x00000000efffffff]
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000001100000-0x0000000002717fff]
[    0.000000]   node   0: [mem 0x0000000002800000-0x0000000003ffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000001100000-0x0000000003ffffff]
[    0.000000] Primary instruction cache 32kB, virtually tagged, 4
way, 64 sets, linesize 128 bytes.
[    0.000000] Primary data cache 16kB, 64-way, 2 sets, linesize 128 bytes.
[    0.000000] PERCPU: Embedded 13 pages/cpu @8000000002858000 s16048
r8192 d29008 u53248
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 11635
[    0.000000] Kernel command line:  bootoctlinux bed00000
console=ttyS0,9600 bootver=APBoot 1.0.8.3/20343
[    0.000000] PID hash table entries: 256 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
[    0.000000] Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Memory: 20468K/47200K available (3411K kernel code,
261K rwdata, 976K rodata, 1280K init, 16674K bss, )
[    0.000000] SLUB: HWalign=128, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  CONFIG_RCU_FANOUT set to non-default value of 32
[    0.000000]  RCU restricting CPUs from NR_CPUS=16 to nr_cpu_ids=1.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1



Some relevant output once booted ...

# cat /proc/iomem
01100000-027189c7 : System RAM
  01100000-0145528f : Kernel code
  01455290-0158ffff : Kernel data
02800000-03ffffff : System RAM
1f400000-1fbfffff : 1f400000.nor
1070000000800-10700000008ff : /soc@0/gpio-controller@1070000000800
1180000000800-118000000083f : serial
1180000000c00-1180000000c3f : serial
1180000001000-11800000011ff : /soc@0/i2c@1180000001000
1180000001800-118000000183f : /soc@0/mdio@1180000001800
1180040000000-118004000000f : octeon_rng
11b00f0000000-11b0130000000 : Octeon PCI MEM
  11b00f0000000-11b00f000ffff : 0000:00:03.0
  11b00f0010000-11b00f001ffff : 0000:00:04.0
1400000000000-1400000000007 : octeon_rng


# free -m
             total       used       free     shared    buffers     cached
Mem:         21748      19616       2132         32       1012       2196
-/+ buffers/cache:      16408       5340
Swap:            0          0          0

# cat /proc/cpuinfo
system type             : CN3010_EVB_HS5 (CN5010p1.1-500-SCP)
machine                 : Unknown
processor               : 0
cpu model               : Cavium Octeon+ V0.1
BogoMIPS                : 1000.00
wait instruction        : yes
microsecond timers      : yes
tlb_entries             : 64
extra interrupt vector  : yes
hardware watchpoint     : yes, count: 2, address/irw mask: [0x0ffc, 0x0ffb]
isa                     : mips1 mips2 mips3 mips4 mips5 mips64r2
ASEs implemented        :
shadow register sets    : 1
kscratch registers      : 0
package                 : 0
core                    : 0
VCED exceptions         : not available
VCEI exceptions         : not available


# cat /proc/meminfo
MemTotal:          21748 kB
MemFree:            2148 kB
MemAvailable:       3256 kB
Buffers:            1012 kB
Cached:             2196 kB
SwapCached:            0 kB
Active:             3168 kB
Inactive:            656 kB
Active(anon):        644 kB
Inactive(anon):        4 kB
Active(file):       2524 kB
Inactive(file):      652 kB
Unevictable:           0 kB
Mlocked:               0 kB
SwapTotal:             0 kB
SwapFree:              0 kB
Dirty:                 0 kB
Writeback:             0 kB
AnonPages:           628 kB
Mapped:             1320 kB
Shmem:                32 kB
Slab:               8416 kB
SReclaimable:        984 kB
SUnreclaim:         7432 kB
KernelStack:         720 kB
PageTables:           88 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:       10872 kB
Committed_AS:       1620 kB
VmallocTotal:   1069547512 kB
VmallocUsed:           0 kB
VmallocChunk:          0 kB
