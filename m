Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Jul 2014 06:00:39 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:61849 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816071AbaGCEAb4stRV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Jul 2014 06:00:31 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 13954D4F79561
        for <linux-mips@linux-mips.org>; Thu,  3 Jul 2014 05:00:22 +0100 (IST)
Received: from BAMAIL02.ba.imgtec.org (192.168.66.28) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 3 Jul 2014 05:00:23 +0100
Received: from [192.168.159.140] (192.168.159.140) by bamail02.ba.imgtec.org
 (192.168.66.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Wed, 2 Jul
 2014 21:00:20 -0700
Message-ID: <53B4D547.5090507@imgtec.com>
Date:   Wed, 2 Jul 2014 23:00:07 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     LMOL <linux-mips@linux-mips.org>
Subject: Release #3 of Linux MTI-3.10-LTS kernel.
Content-Type: multipart/mixed;
        boundary="------------060805070701080507030305"
X-Originating-IP: [192.168.159.140]
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40991
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

--------------060805070701080507030305
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Imagination Technologies is pleased to announce the third release of
its 3.10 LTS (Long-Term Support) MIPS kernel. The attached ChangeLog
is the MTI patches applied against Greg's 3.10.42 release. The code
repository is hosted at the Linux/MIPS project GIT:

     GIT REPO:  git://git.linux-mips.org/pub/scm/linux-mti.git
  BRANCH NAME:  linux-mti-3.10
     TAG NAME:  linux-mti-3.10.42

We look forward to any comments or feedback.

         The Imagination MIPS Kernel Team

--------------060805070701080507030305
Content-Type: text/plain; charset="UTF-8"; name="ChangeLog-MTI-3.10.42"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="ChangeLog-MTI-3.10.42"

a1c935c MIPS: kernel: Makefile: Add missing segment file to Makefile
e4cd6c1 MIPS: kernel: segment: Convert segment.c to debugfs
78b0350 MIPS: msc: Prevent out-of-bounds writes to MIPS SC ioremap'd region
293d5e6 MIPS: pm-cps: select CONFIG_MIPS_CPC
8b8e117 MIPS: pm-cps: prevent use of mips_cps_* without CPS SMP
83ba614 MIPS: Fix a typo error in AUDIT_ARCH definition
bfed080 MIPS: Add new AUDIT_ARCH token for the N32 ABI on MIPS64
25c07e0 MIPS: Fix syscall tracing interface
5b872f1 MIPS: KVM: Remove dead code in CP0 emulation
9027fac MIPS: KVM: Consult HWREna before emulating RDHWR
2356a54 MIPS: KVM: asm/kvm_host.h: Clean up whitespace
84d3697 MIPS: KVM: remove shadow_tlb code
91365a4 MIPS: KVM: Use EHINV to invalidate TLB entries if the core supports it
5548dc8 mips/kvm: Make kvm_locore.S 64-bit buildable/safe.
06cb775 mips/kvm: Cleanup .push/.pop directives in kvm_locore.S
0669bb3 mips/kvm: Improve code formatting in arch/mips/kvm/kvm_locore.S
460be52 MIPS: Add __wback_cache_all() for suspend to RAM
836b417 MIPS: Malta: Pseudo suspend to RAM
96cc369 MIPS: Change segctl C0 regs to ulong
94cc72d MIPS: c-r4k: Make __flush_cache_all flush scache
d03c50f MIPS: Malta: CPS SMP by default
9451ff1 MIPS: smp-cps: duplicate core0 CCA on secondary cores
c6534a6 MIPS: smp-cps: set a coherent default CCA
f0f2e49 MIPS: smp-cps: prevent multi-core SMP with unsuitable CCA
1692610 MIPS: smp-cps: flush cache after patching mips_cps_core_entry
aa76005 MIPS: smp-cps: disable preemption whilst booting a CPU
f187489 MIPS: CPC: prevent preemption whilst locking other core access
ae2b27e MIPS: cpuidle-cps: support core power down
b7bf029 MIPS: smp-cps: hotplug support
435d64c MIPS: smp-cps: do MT core init in asm, simplify it
8d4b78e MIPS: smp-cps: use CPC core-other locking
c2b6606 MIPS: pm-cps: handle offline CPUs
81471fe MIPS: pm-cps: add a power-gated state
50e9728 MIPS: pm-cps: remove alloc_cpumask_var from PM state entry
a9a4d22 MIPS: pm-cps: don't bother zero-initializing ready_count
1445068 MIPS: pm-cps: don't bother clearing ready_count on nc-wait exit
74a4acb MIPS: pm-cps: abstract CPS PM state entry from cpuidle
6cc1e58 MIPS: smp-cps: function to determine whether CPS SMP is in use
a959c91 MIPS: cpuidle-cps: support clock gating cores
e1dcf6a MIPS: cpuidle-cps: use cached non-coherent TLB entry for sync
f11451d MIPS: cpuidle-cps: rename nc_ready_count to ready_count
c0c78bb MIPS: cpuidle-cps: remove unused first_cpu variable
ea415d0 MIPS: cpuidle-cps: ensure a CM is present
e89f07a MIPS: add kmap_noncoherent to wire a cached non-coherent TLB entry
bcc6789 MIPS: uasm: add jr.hb instruction
ac97ef1 MIPS: uasm: add MT ASE yield instruction
92efaca MIPS: inst.h: define MT yield op
56a9a5b MIPS: MT: define write_c0_tchalt macro
b348d51 MIPS: CPC: provide locking functions
6ba8574 MIPS: CPC: provide functions to retrieve register addresses
00a4074 MIPS: introduce cpu_coherent_mask
a81c69a MIPS: support for generic clockevents broadcast
b5f21679 MIPS: allow R4K clockevent device to function regardless of GIC
4c0f991 MIPS: mark R4K clockevent device with CLOCK_EVT_FEAT_C3STOP
2ecadf2 MIPS: allow GIC clockevent device config from other CPUs
9bc772a MIPS: mark GIC clockevent device with CLOCK_EVT_FEAT_C3STOP
c751616 cpuidle: delay enabling interrupts until all coupled CPUs leave idle
4d7af1f cpuidle: coupled: always disable IRQs after leaving safe state
51989fe clocksource: Add generic dummy timer driver
4794328 MIPS: PM: Implement PM helper macros
b5b4c3dd MIPS: irq-gic: Add Cluster PM callbacks to preserve GIC state
53fe38a MIPS: tlb-r4k: Add CPU PM callback to reconfigure TLB
f0813d5 MIPS: c-r4k: Add CPU PM callback for coherency
a6717b2 MIPS: traps: Add CPU PM callback for trap configuration
8cd96a1 MIPS: PM: Add CPU PM callbacks for general CPU context
8d19b93 MIPS: Protect GIC IPI usage within MT SMP code
bd651dd MIPS: GIC: Fix GICBIS macro
8d11349 MIPS: Malta: Fix dispatching of GIC interrupts
5884da8 MIPS: GIC: Generalise check for pending interrupts
1583860 MIPS: GIC: Prevent array overrun
9fb4237 MIPS: GIC: Remove GIC_FLAG_IPI
87ca909 MIPS: GIC: Move GIC_NUM_INTRS into platform irq.h
84752f7 MIPS: GIC: move GIC interrupt bitmap declarations
0a444be MIPS: bugfix of FPU save/restore for MIPS32 context on MIPS64
6c55a17 MIPS: Restore plat_device_is_coherent semantics
b9b03ca MIPS: lib: iomap: Use __mem_{read,write}{b,w,l} for MMIO
83c7313 Merge branch 'linux-mti-3.10' into dev-linux-mti-next
e185cee Merge tag 'v3.10.42' into linux-mti-3.10
bc205c5 sead3-setup.c: copy fdt to non init memory before unflatening it
6908e8d sead3: populate platform devices from device tree
44265da sead3: remove chosen node
ab9f5ee sead3-setup: allow cmdline/env to change memory size using memsize param
442ef44 MIPS: smp-cps: fix NMI detection
681a669 Merge tag 'v3.10.33' into linux-mti-3.10
224eae9 Merge tag 'v3.10.32' into linux-mti-3.10
d38ce98 Merge branch 'linux-mti-3.10' into dev-linux-mti-3.10
41e93d2 Merge tag 'v3.10.31' into linux-mti-3.10
b869d04 Merge branch 'linux-mti-3.10' into dev-linux-mti-3.10
071e016 MIPS: CPC: use __raw_ memory access functions
45921f5 MIPS: fix warning when including smp-ops.h with CONFIG_SMP=n
a30355d MIPS: microMIPS: Remove unsupported compiler flag.
769f653 MIPS: Malta: GIC IPIs may be used without MT
23037c5 MIPS: smp-mt: use common GIC IPI implementation
552d500 MIPS: smp-cps: don't run MT instructions if cpu doesn't have MT
709b199 MIPS: smp-cps: fix build when CONFIG_MIPS_MT_SMP=n
def97ae MIPS: provide empty mips_mt_set_cpuoptions when CONFIG_MIPS_MT=n
35a99fd MIPS: add cpu_vpe_id macro
d55096f MIPS: futex: Use LLE and SCE for EVA
e2ef64e MIPS: asm: uaccess: Fix EVA #ifdef for __strncpy_from_user
035b90c MIPS: lib: memset: Drop unused EXE macro
fbae3b2 MIPS: OProfile: Add CPU_P5600 cases
733a85d MIPS: OProfile: Add CPU_PROAPTIV case
ddc9d53 MIPS: P5600: use CPU_P5600
01f2c84 MIPS: Add cases for CPU_P5600
1a3876a MIPS: Add MIPS P5600 cputype identifier
7a90997 MIPS: kernel: cpu-probe: Add support for probing M5150 cores
c4096be MIPS: Add support for the M5150 processor
cd96b39 MIPS: Add processor identifier for the M5150 processor
9fe7ecf MIPS: Fix build error seen in some configurations
73e449e MIPS: Select HAVE_ARCH_SECCOMP_FILTER
d989e2d MIPS: seccomp: Handle indirect system calls (o32)
ce32431 MIPS: kernel: scalls: Skip the syscall if denied by the seccomp filter
f0b9a02 MIPS: ptrace: Move away from secure_computing_strict
8c0bea7 MIPS: Enable entries for SIGSYS in struct siginfo.
8922873 MIPS: asm: syscall: Add the syscall_rollback function
19e7a50 MIPS: asm: syscall: Define syscall_get_arch
9aaa01a MIPS: asm: syscall: Fix copying system call arguments
de494ed MIPS: Add syscall_set_return_value system call
866c057 MIPS: Move audit_arch() helper function to __syscall_get_arch().
2a3838d MIPS: Enable HAVE_ARCH_TRACEHOOK.
beefa48 MIPS: Implement task_user_regset_view.
eca5a06 MIPS: Provide arch_syscall_addr.
fd8f2e8 MIPS: Add P5600 PRid and probe support
8532906 MIPS: CMP framework should depend on !SMTC, not on SMVP
67a75c0 MIPS: more helpful CONFIG_MIPS_CMP help text, label
c687433 MIPS: Malta: allow use of MIPS CPS SMP implementation
f99c66b MIPS: Malta: probe CPC when supported
51f61cf MIPS: Coherent Processing System SMP implementation
4a31da4 MIPS: move GIC IPI functions out of smp-cmp.c
38cd4b2 MIPS: add CPC probe, access functions
fb34033 MIPS: add missing CPC, GIC register definitions
af826fa MIPS: add missing includes to gic.h
55768e1 MIPS: introduce _EXT assembler macro
d709956 MIPS: add CP0 CMGCRBase bit definitions
1613e96 MIPS: define Config1 cache field shifts & sizes
5135055 MIPS: cpuidle driver for MIPS CPS
7d1db60 MIPS: support use of cpuidle
8ed414f MIPS: uasm: add a label variant of beq
9b20f90 MIPS: uasm: add mftc0 & mttc0 instructions
42ae1b0 MIPS: uasm: add jr.hb instruction
63d316c MIPS: uasm: add wait instruction
aa60172 MIPS: uasm: add sync instruction
1b7cf44 MIPS: inst.h: define microMIPS wait op
2048c29 MIPS: inst.h: define microMIPS sync op
7e2ac98 MIPS: inst.h: define COP0 wait op
d5c46af cpuidle: declare cpuidle_dev in cpuidle.h
1b7c4f2 cpuidle: coupled: disable IRQs after leaving safe state
ddff60e MIPS: Fix invalid detection of GCMP L2 SYNC support.
0974f84 MIPS: Add 1074K CPU support explicitly.
b802471 mips: default NR_CPUS=8 for malta SMP defconfigs
5ca99a2 mips: set page size to 16KB for malta SMP defconfigs
f17200b mips: regenerate malta defconfigs
27f9a69 mips: add ".set push" ".set pop" pairs around ".set eva"
a582e80 MIPS: bugfix of "core" and "vpe_id" setup for MT ASE w/out GCMP
2a2f88f MIPS: bugfix of force-bev-location parsing
93e263c MIPS: bugfix of ebase WG bit mask
642d37e MIPS: bugfix of coherentio variable default setup
77ea488 Merge tag 'v3.10.28' into linux-mti-3.10
4951dd7 MIPS: CPC: use __raw_ memory access functions
c199b19 MIPS: fix warning when including smp-ops.h with CONFIG_SMP=n
4b6ba55 MIPS: microMIPS: Remove unsupported compiler flag.
c05be6d MIPS: Malta: GIC IPIs may be used without MT
ec35d19 MIPS: smp-mt: use common GIC IPI implementation
412ecb2 MIPS: smp-cps: don't run MT instructions if cpu doesn't have MT
110a330 MIPS: smp-cps: fix build when CONFIG_MIPS_MT_SMP=n
4fd9941 MIPS: provide empty mips_mt_set_cpuoptions when CONFIG_MIPS_MT=n
bbca087 MIPS: add cpu_vpe_id macro
6e4a72e MIPS: futex: Use LLE and SCE for EVA
8e145d2 MIPS: asm: uaccess: Fix EVA #ifdef for __strncpy_from_user
44a5bea MIPS: lib: memset: Drop unused EXE macro
7955ded MIPS: OProfile: Add CPU_P5600 cases
2acb504 MIPS: OProfile: Add CPU_PROAPTIV case
e1d658a MIPS: P5600: use CPU_P5600
c8df185 MIPS: Add cases for CPU_P5600
f84fa60 MIPS: Add MIPS P5600 cputype identifier
2ab1945 MIPS: kernel: cpu-probe: Add support for probing M5150 cores
cfefa3f MIPS: Add support for the M5150 processor
b0b427c MIPS: Add processor identifier for the M5150 processor
5c9a04f MIPS: Fix build error seen in some configurations
fb8a1f2 MIPS: Select HAVE_ARCH_SECCOMP_FILTER
5b7b22c MIPS: seccomp: Handle indirect system calls (o32)
6f1c767 MIPS: kernel: scalls: Skip the syscall if denied by the seccomp filter
e552128 MIPS: ptrace: Move away from secure_computing_strict
1725558 MIPS: Enable entries for SIGSYS in struct siginfo.
40665a7 MIPS: asm: syscall: Add the syscall_rollback function
b65210b MIPS: asm: syscall: Define syscall_get_arch
9247d87 MIPS: asm: syscall: Fix copying system call arguments
93cfb3f MIPS: Add syscall_set_return_value system call
fd55466 MIPS: Move audit_arch() helper function to __syscall_get_arch().
590163c MIPS: Enable HAVE_ARCH_TRACEHOOK.
fd48566 MIPS: Implement task_user_regset_view.
61dd3a8 MIPS: Provide arch_syscall_addr.
447edd0 Merge branch 'linux-mti-3.10' into dev-linux-mti-3.10
2e2b5c4 Merge tag 'v3.10.28' into linux-mti-3.10
a99047d MIPS: Add P5600 PRid and probe support
839f29d MIPS: CMP framework should depend on !SMTC, not on SMVP
877957c MIPS: more helpful CONFIG_MIPS_CMP help text, label
720e7e7 MIPS: Malta: allow use of MIPS CPS SMP implementation
9a10cfc MIPS: Malta: probe CPC when supported
182cd2f MIPS: Coherent Processing System SMP implementation
3bf0959 MIPS: move GIC IPI functions out of smp-cmp.c
3c1a118 MIPS: add CPC probe, access functions
24df281 MIPS: add missing CPC, GIC register definitions
3f2d81259 MIPS: add missing includes to gic.h
1771e92 MIPS: introduce _EXT assembler macro
8957228 MIPS: add CP0 CMGCRBase bit definitions
40f658a MIPS: define Config1 cache field shifts & sizes
b38c2b1 MIPS: cpuidle driver for MIPS CPS
3e9dfa2 MIPS: support use of cpuidle
aee95b8 MIPS: uasm: add a label variant of beq
dfafe06 MIPS: uasm: add mftc0 & mttc0 instructions
6ca3675 MIPS: uasm: add jr.hb instruction
fd7d669 MIPS: uasm: add wait instruction
dac3412 MIPS: uasm: add sync instruction
d00ec3f MIPS: inst.h: define microMIPS wait op
70e8c8a MIPS: inst.h: define microMIPS sync op
107d235 MIPS: inst.h: define COP0 wait op
48299a4 cpuidle: declare cpuidle_dev in cpuidle.h
5886ea1 cpuidle: coupled: disable IRQs after leaving safe state
44eb48c MIPS: Fix invalid detection of GCMP L2 SYNC support.
501604a MIPS: Add 1074K CPU support explicitly.
10597ab mips: default NR_CPUS=8 for malta SMP defconfigs
b7c554b mips: set page size to 16KB for malta SMP defconfigs
48cf2f5 mips: regenerate malta defconfigs
4220e6a Merge branch 'linux-mti-3.10' into dev-linux-mti-3.10
499c0eb Merge tag 'v3.10.20' into linux-mti-3.10
3ead322 mips: add ".set push" ".set pop" pairs around ".set eva"
207d390 Merge branch 'linux-mti-3.10' into dev-linux-mti-3.10
8b61724 Merge tag 'v3.10.19' into linux-mti-3.10
6c50510 MIPS: malta: Fix GIC interrupt offsets
80ea0c1 MIPS: Fix forgotten preempt_enable() when CPU has inclusive pcaches
d069271 MIPS: Clean up MIPS MT platform configuration options.
cd63d3f MIPS: Malta: Enable DEVTMPFS
acc47b0 MIPS: EVA: Fix encoding for the UUSK AM bits on the SegCtl registers.
64b0d66 MIPS: EVA: Don't write the EVA bit in the config5 CP0 register
b6da477 MIPS: Fix more section mismatch warnings
4827c02 MIPS: bcm63xx: cpu: Replace BUG() with panic()
a5d064a MIPS/Perf-events: Support proAptiv/interAptiv cores
4b3e29c MIPS/Perf-events: Fix 74K cache map
acf29d0 MIPS: Malta: Remove ttyS2 serial.
0d6f343 MIPS: VPE: Re-implement as writes to a pseudo-device.
43334f8 MIPS: GIC: Send IPIs using the GIC.
2142169 MIPS: configs: Add Malta EVA defconfig
79d6c9d MIPS: MIPS32 R2 SYNC optimization
14b9f8c MIPS: BEV overlay segment location and size verification.
3daa071 MIPS: bugfix of Malta PCI bridges loop.
f76f3e8 MIPS: Malta: check memory map type - legacy or new
ef1917e MIPS: Malta new memory map support
7ab1fc3 MIPS: EVA SMP support for Malta board
27eefa2 MIPS: Add interAptiv CPU support.
6c4b398 MIPS: EVA CACHEE instruction implementation in kernel
4a71806 MIPS: Fix bug in using flush_cache_vunmap
98f6c46 MIPS: Cache flush functions are reworked.
4e5dd44 MIPS: MIPS32R2 Segment/EVA support upto 3GB
9a86ff5 MIPS: malta: Fix GIC interrupt offsets
65b4e45 MIPS: Add proAPTIV CPU support.
d569f76 MIPS: bugfix of "core" and "vpe_id" setup for MT ASE w/out GCMP
d08041a MIPS: bugfix of force-bev-location parsing
8891190 MIPS: bugfix of ebase WG bit mask
562361d MIPS: bugfix of coherentio variable default setup
93c4683 MIPS: mm: tlbex: Remove special case for proAptiv cores
2b22dbf MIPS: Fix forgotten preempt_enable() when CPU has inclusive pcaches
0671b94 MIPS: Clean up MIPS MT platform configuration options.
d2160ab MIPS: Allow ASID size to be determined at boot time. (REVERT)
55e6adc MIPS: Malta: Enable DEVTMPFS
08271bd MIPS: EVA: Fix encoding for the UUSK AM bits on the SegCtl registers.
4dcadb4 MIPS: EVA: Don't write the EVA bit in the config5 CP0 register
a2f2bb5 MIPS: Fix more section mismatch warnings
20bb63e MIPS: bcm63xx: cpu: Replace BUG() with panic()
d43dd75 MIPS/Perf-events: Support proAptiv/interAptiv cores
3f28f3d MIPS/Perf-events: Fix 74K cache map
7372151 MIPS: Malta: Remove ttyS2 serial.
ad97e82 MIPS: VPE: Re-implement as writes to a pseudo-device.
530b4a9 MIPS: GIC: Send IPIs using the GIC.
cd3c6da MIPS: configs: Add Malta EVA defconfig
05eb753 MIPS: MIPS32 R2 SYNC optimization
b7fdf13 MIPS: BEV overlay segment location and size verification.
499b132 MIPS: bugfix of Malta PCI bridges loop.
0f3b76d MIPS: Malta: check memory map type - legacy or new
0bcba61 MIPS: Malta new memory map support
eb23659 MIPS: EVA SMP support for Malta board
d85dfcc MIPS: Add interAptiv CPU support.
68a17d7 MIPS: EVA CACHEE instruction implementation in kernel
3a347ef MIPS: Fix bug in using flush_cache_vunmap
43d9fa2 MIPS: Cache flush functions are reworked.
25161c5 MIPS: MIPS32R2 Segment/EVA support upto 3GB
5f6da75 MIPS: Add proAPTIV CPU support.
376fce6 MIPS: Allow ASID size to be determined at boot time.
8aea860 MIPS: 64bit address support on MIPS64 R2
9f9d14e MIPS: Revert fixrange_init() limiting to the FIXMAP region.
eb8f352 MIPS HIGHMEM fixes for cache aliasing and non-DMA I/O.
464b12c MIPS: bugfix: M14Kc support is restored
599097a MIPS: FPU2 IEEE754-2008 SNaN support
5a67a83 MIPS: microMIPS: Add -mfp64 support to FPU emulator.
6442e35 MIPS:  -mfp64 for abi=o32 ELF binaries support.
cc2d0cc MIPS: Add -mfp64 support to FPU emulator.
ad403bf MIPS: removal of X bit in page tables for HEAP/BSS.
0581fe0 MIPS: rearrange PTE bits into fixed positions for MIPS32 R2.
9e4dbd8 MIPS: Add printing of ES bit when cache error occurs.
e5c22f5 MIPS: bugfix of stack trace dump.
9b81d97 MIPS: Always register R4K clock when selected.
a7389bc MIPS: Remove bogus BUG_ON()
184edf8 MIPS: Kconfig: CMP support needs to select SMP as well
ce23850 MIPS: Fix rtlx build error.
7857385 MIPS: cavium-octeon: fix I/O space setup on non-PCI systems
e3335dc MIPS: cpu-features.h: s/MIPS53/MIPS64/
772ed2d MIPS: Fix invalid symbolic link file
005592f MIPS: PCI: pci-bcm1480: Include missing vt.h header
eea92ba MIPS: 74K/1074K: Correct erratum workaround.
d00f4fa MIPS: Fix VGA_MAP_MEM macro.
2b4f1492 MIPS: Fix accessing to per-cpu data when flushing the cache
c4d621e MIPS: Fix SMP core calculations when using MT support.
1bf8465 MIPS: kexec: Fix random crashes while loading crashkernel
30474d1 MIPS: kdump: Skip walking indirection page for crashkernels
61253b0 MIPS: Export copy_from_user_page() (needed by lustre)
fce5bbb MIPS: Move declaration of Octeon function fixup_irqs() to header.
dc06b90 MIPS: Add uImage build target
913dd01 MIPS: Refactor load/entry address calculations
a64c5d8 MIPS: Refactor boot and boot/compressed rules
009d393 MIPS: add <dt-bindings/> symlink
0c1a943 MIPS: powertv: Drop BOOTLOADER_DRIVER Kconfig symbol
2e9f935 MIPS: Kconfig: Drop obsolete NR_CPUS_DEFAULT_{1,2} options
5b8d0ef MIPS: TXx9: Fix build error if CONFIG_TOSHIBA_JMR3927 is not selected
a84ae3d MIPS: Loongson: Hide the pci code behind CONFIG_PCI
f2f0485 MIPS: use generic-y where possible
1ae2cf6 MIPS: R4k clock source initialization bug fix
94b6980 staging: MIPS: add Octeon USB HCD support
4fcc82c MIPS: Octeon: Fix DT pruning bug with pip ports
6b55104 MIPS: Octeon: Enable interfaces on EdgeRouter Lite
7eb657c MIPS: PNX833x: PNX8335_PCI_ETHERNET_INT depends on CONFIG_SOC_PNX8335
1b40a79 MIPS: powertv: Fix arguments for free_reserved_area()
ca39885 MIPS: Set default CPU type for BCM47XX platforms
7911dd4 MIPS: Fix multiple definitions of UNCAC_BASE.
c25cd76 MIPS: KVM: Mark KVM_GUEST (T&E KVM) as BROKEN_ON_SMP
cccd074 MIPS: Kconfig: Add missing MODULES dependency to VPE_LOADER
5ab18c1 ide: Fix IDE PIO size calculation
6bc48ae MIPS: BCM63xx: CLK: Add dummy clk_{set,round}_rate() functions
aa5f3f2 MIPS: SEAD3: Disable L2 cache on SEAD-3.
e4c1268 MIPS: Malta: Update GCMP detection.
8bdfec7 Revert "MIPS: make CAC_ADDR and UNCAC_ADDR account for PHYS_OFFSET"
2448c5d MIPS: APSP: Remove <asm/kspd.h>
e00caea MIPS: microMIPS: Fix improper definition of ISA exception bit.
785c8af MIPS: Don't try to decode microMIPS branch instructions where they cannot exist.
09c3c65 MIPS: Declare emulate_load_store_microMIPS as a static function.
56e3b11 MIPS: Only set cpu_has_mmips if SYS_SUPPORTS_MICROMIPS
553ddf4 MIPS: GIC: Fix gic_set_affinity infinite loop
ef2f8d3 MIPS: Boot: Compressed: Remove -fstack-protector from CFLAGS
fa9f1f1 MIPS: SNI: pcimt: Guard sni_controller with CONFIG_PCI
cd120b3 MIPS: Sibyte: Platform: Add load address for CONFIG_SIBYTE_LITTLESUR
ab6e34d MIPS: microMIPS: Fix POOL16C minor opcode enum
bdb3d7b MIPS: Fix execution hazard during watchpoint register probe
19c8d85 MIPS: powertv: Drop SYS_HAS_EARLY_PRINTK
0e3c3f0 MIPS: sibyte: Amend dependencies for SIBYTE_BUS_WATCHER
694b3b9 MIPS: Sibyte: Fix bus watcher build for BCM1x55 and BCM1x80.
4f6982d MIPS: Sibyte: Fix build for SIBYTE_BW_TRACE on BCM1x55 and BCM1x80.
42a3a87 MIPS: sibyte: Declare the cfe_write() buffer as constant
dcdc44d MIPS: Sibyte: Add missing sched.h header
9fed7a7 MIPS: sibyte: Remove unused variable.
c559e9e MIPS: ath79: Fix argument for the ap136_pc_init function
fedf532 MIPS: malta: Remove software reset defines from generic header.
99bb17c MIPS: malta: Move defines of reset registers and values.
daf6ac7 MIPS: sead3: Fix ability to perform a soft reset.
65fa77b MIPS: kvm: Kconfig: Drop HAVE_KVM dependency from VIRTUALIZATION
be8cc02 MIPS: kernel: mcount.S: Drop FRAME_POINTER codepath
fa29498 USB: ehci-sead3: remove unnecessary platform_set_drvdata()
762b201 MIPS: Fix TLBR-use hazards for R2 cores in the TLB reload handlers
8e8cb01 SSB: Kconfig: Amend SSB_EMBEDDED dependencies

--------------060805070701080507030305--
