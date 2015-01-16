Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2015 11:50:11 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:52659 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009602AbbAPKuJ6o7x3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jan 2015 11:50:09 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C08978660EB94
        for <linux-mips@linux-mips.org>; Fri, 16 Jan 2015 10:50:00 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 16 Jan 2015 10:50:02 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.96) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Fri, 16 Jan 2015 10:50:02 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>
Subject: [PATCH RFC v2 00/70] Add MIPS R6 support
Date:   Fri, 16 Jan 2015 10:48:39 +0000
Message-ID: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45144
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

Hi,

This is the v2 of the MIPS R6 patchset I posted a month ago[1].
I have addressed most of the issues. Most notably:

* Rebased onto v3.19-rc4
* Use the "ZC" constraints for the R6 LL/ZC atomics introduced in GCC 4.9
* Code simplifications as suggested by Sergei Shtylyov and David Daney
* Add FP ABI improvement necessary for R6 userland to work with the latest
  tools.
* Code fixes.
* A couple of unrelated commits are included as well (ie s/addi/addiu/, FP fixes,
etc. I will talk to Ralf and see if we need to merge them separately or not.

A couple of things haven't been addressed on purpose:

* The QEMU patches are still needed. The PRPL QEMU has changed since then
to use the I6400[2] PRID for mips64r6[3] but mips32r6 remains the same.
This means that for mips64r6 to boot, you need to modify your PRPL tree to use
the old PRID definition even for the I6400 cpu until there is proper support in
the kernel. The generic QEMU PRID is also used by QEMU R2-generic cpu
implementations as well.

The new patches are available in my git tree[4].

[1]: http://www.linux-mips.org/archives/linux-mips/2014-12/msg00222.html
[2]: http://www.imgtec.com/mips/warrior/iclass.asp
[3]: https://github.com/prplfoundation/qemu/commit/4473b4492ddc9c90be85d11db7029fc9bbfd805a
[4]: git://git.linux-mips.org/pub/scm/mchandras/linux.git 3.19-r6-rfc-1


Leonid Yegoshin (21):
  MIPS: Add generic QEMU PRid and cpu type identifiers
  MIPS: Add cases for CPU_QEMU_GENERIC
  MIPS: Add MIPS generic QEMU probe support
  MIPS: Add build support for the MIPS R6 ISA
  MIPS: mm: uasm: Add signed 9-bit immediate related macros
  MIPS: mm: Add MIPS R6 instruction encodings
  MIPS: asm: module: define MODULE_PROC_FAMILY for MIPS R6
  MIPS: asm: stackframe: Do not preserve the HI/LO registers on MIPS R6
  MIPS: asm: asmmacro: Add MIPS R6 support to the simple EI/DI variants
  MIPS: asm: cpu: Add MIPSR6 ISA definitions
  MIPS: kernel: cpu-bugs64: Do not check R6 cores for existing 64-bit
    bugs
  MIPS: kernel: cevt-r4k: Add MIPS R6 to the c0_compare_interrupt
    handler
  MIPS: kernel: cpu-probe.c: Add support for MIPS R6
  MIPS: kernel: traps: Add MIPS R6 related definitions
  MIPS: kernel: r4k_switch: Add support for MIPS R6
  MIPS: kernel: r4k_fpu: Add support for MIPS R6
  MIPS: kernel: unaligned: Add support for the MIPS R6
  MIPS: lib: memcpy: Add MIPS R6 support
  MIPS: lib: memset: Add MIPS R6 support
  MIPS: mm: tlbex: Use cpu_has_mips_r2_exec_hazard for the EHB
    instruction
  MIPS: kernel: mips-r2-to-r6-emul: Add R2 emulator for MIPS R6

Markos Chandras (49):
  MIPS: asm: asm: Add new macros to set ISA and arch asm annotations
  MIPS: asm: asmmacro: Drop unused 'reg' argument on MIPSR2
  MIPS: asm: asmmacro: Replace add instructions with "addui"
  MIPS: Use generic checksum functions for MIPS R6
  MIPS: asm: hazards: Add MIPSR6 definitions
  MIPS: asm: irqflags: Add MIPS R6 related definitions
  MIPS: asm: r4kcache: Add MIPS R6 cache unroll functions
  MIPS: asm: spram: Add MIPS R6 related definitions
  MIPS: Use the new "ZC" constraint for MIPS R6
  MIPS: asm: cmpxchg: Update ISA constraints for MIPS R6 support
  MIPS: asm: atomic: Update ISA constraints for MIPS R6 support
  MIPS: asm: bitops: Update ISA constraints for MIPS R6 support
  MIPS: asm: futex: Set the appropriate ISA level for MIPS R6
  MIPS: asm: spinlock: Replace sub instruction with addiu
  MIPS: asm: local: Set the appropriate ISA level for MIPS R6
  MIPS: kernel: entry.S: Add MIPS R6 related definitions
  MIPS: kernel: proc: Add MIPS R6 support to /proc/cpuinfo
  MIPS: kernel: genex: Set correct ISA level
  MIPS: kernel: cps-vec: Replace addi with addiu
  MIPS: kernel: syscall: Set the appropriate ISA level for MIPS R6
  MIPS: mm: page: Add MIPS R6 support
  MIPS: mm: c-r4k: Set the correct ISA level
  MIPS: mm: scache: Add secondary cache support for MIPS R6 cores
  MIPS: kernel: Prepare the JR instruction for emulation on MIPS R6
  MIPS: kernel: branch: Prevent BLTZL emulation for MIPS R6
  MIPS: kernel: branch: Prevent BGEZL emulation for MIPS R6
  MIPS: kernel: branch: Prevent BLTZAL emulation for MIPS R6
  MIPS: kernel: branch: Prevent BGEZAL emulation for MIPS R6
  MIPS: kernel: branch: Prevent BEQL emulation for MIPS R6
  MIPS: kernel: branch: Prevent BNEL emulation for MIPS R6
  MIPS: kernel: branch: Prevent BLEZL emulation for MIPS R6
  MIPS: kernel: branch: Prevent BGTZL emulation for MIPS R6
  MIPS: Emulate the BC1{EQ,NE}Z FPU instructions
  MIPS: Emulate the new MIPS R6 B{L,G}Ε{Z,}{AL,}C instructions
  MIPS: Emulate the new MIPS R6 B{L,G}T{Z,}{AL,}C instructions
  MIPS: Emulate the new MIPS R6 branch compact (BC) instruction
  MIPS: Emulate the new MIPS R6 BOVC, BEQC and BEQZALC instructions
  MIPS: Emulate the new MIPS R6 BNVC, BNEC and BNEZLAC instructions
  MIPS: Emulate the new MIPS R6 BALC instruction
  MIPS: Emulate the new MIPS R6 BEQZC and JIC instructions
  MIPS: Emulate the new MIPS R6 BNEZC and JIALC instructions
  MIPS: Add LLB bit and related feature for the Config 5 CP0 register
  MIPS: asm: mipsregs: Add support for the LLADDR register
  MIPS: Make use of the ERETNC instruction on MIPS R6
  MIPS: Handle MIPS IV, V and R2 FPU instructions on MIPS R6 as well
  MIPS: kernel: process: Do not allow FR=0 on MIPS R6
  MIPS: kernel: elf: Improve the overall ABI and FPU mode checks
  MIPS: Malta: Add support for building MIPS R6 kernel
  MIPS: Add Malta QEMU 32R6 defconfig

 arch/mips/Kconfig                           |   66 +-
 arch/mips/Makefile                          |    4 +
 arch/mips/configs/malta_qemu_32r6_defconfig |  193 +++
 arch/mips/include/asm/Kbuild                |    1 +
 arch/mips/include/asm/asm.h                 |   13 +
 arch/mips/include/asm/asmmacro.h            |   22 +-
 arch/mips/include/asm/atomic.h              |   13 +-
 arch/mips/include/asm/bitops.h              |   31 +-
 arch/mips/include/asm/checksum.h            |    6 +
 arch/mips/include/asm/cmpxchg.h             |   11 +-
 arch/mips/include/asm/compiler.h            |   10 +-
 arch/mips/include/asm/cpu-features.h        |   22 +-
 arch/mips/include/asm/cpu-type.h            |    7 +
 arch/mips/include/asm/cpu.h                 |   11 +-
 arch/mips/include/asm/elf.h                 |   10 +-
 arch/mips/include/asm/fpu.h                 |    3 +-
 arch/mips/include/asm/futex.h               |    8 +-
 arch/mips/include/asm/hazards.h             |    9 +-
 arch/mips/include/asm/irqflags.h            |    6 +-
 arch/mips/include/asm/local.h               |    4 +-
 arch/mips/include/asm/mips-r2-to-r6-emul.h  |   96 ++
 arch/mips/include/asm/mipsregs.h            |    3 +
 arch/mips/include/asm/module.h              |    4 +
 arch/mips/include/asm/r4kcache.h            |  149 +-
 arch/mips/include/asm/spinlock.h            |    2 +-
 arch/mips/include/asm/spram.h               |    4 +-
 arch/mips/include/asm/stackframe.h          |    8 +-
 arch/mips/include/asm/switch_to.h           |    9 +-
 arch/mips/include/asm/thread_info.h         |    2 +-
 arch/mips/include/uapi/asm/inst.h           |   24 +-
 arch/mips/kernel/Makefile                   |    2 +
 arch/mips/kernel/asm-offsets.c              |    1 +
 arch/mips/kernel/branch.c                   |  283 +++-
 arch/mips/kernel/cevt-r4k.c                 |    2 +-
 arch/mips/kernel/cps-vec.S                  |   16 +-
 arch/mips/kernel/cpu-bugs64.c               |   11 +-
 arch/mips/kernel/cpu-probe.c                |   27 +-
 arch/mips/kernel/elf.c                      |  284 ++--
 arch/mips/kernel/entry.S                    |   23 +-
 arch/mips/kernel/genex.S                    |    2 +-
 arch/mips/kernel/idle.c                     |    1 +
 arch/mips/kernel/mips-r2-to-r6-emul.c       | 2378 +++++++++++++++++++++++++++
 arch/mips/kernel/mips_ksyms.c               |    2 +
 arch/mips/kernel/proc.c                     |    8 +-
 arch/mips/kernel/process.c                  |    4 +
 arch/mips/kernel/r4k_fpu.S                  |   12 +-
 arch/mips/kernel/r4k_switch.S               |   14 +-
 arch/mips/kernel/spram.c                    |    1 +
 arch/mips/kernel/syscall.c                  |    2 +-
 arch/mips/kernel/traps.c                    |   41 +-
 arch/mips/kernel/unaligned.c                |  390 ++++-
 arch/mips/lib/Makefile                      |    1 +
 arch/mips/lib/memcpy.S                      |   23 +
 arch/mips/lib/memset.S                      |   47 +
 arch/mips/lib/mips-atomic.c                 |    2 +-
 arch/mips/math-emu/cp1emu.c                 |  158 +-
 arch/mips/mm/c-r4k.c                        |    6 +-
 arch/mips/mm/page.c                         |   20 +-
 arch/mips/mm/sc-mips.c                      |    4 +-
 arch/mips/mm/tlbex.c                        |    7 +-
 arch/mips/mm/uasm-mips.c                    |   32 +
 arch/mips/mm/uasm.c                         |   13 +-
 62 files changed, 4281 insertions(+), 287 deletions(-)
 create mode 100644 arch/mips/configs/malta_qemu_32r6_defconfig
 create mode 100644 arch/mips/include/asm/mips-r2-to-r6-emul.h
 create mode 100644 arch/mips/kernel/mips-r2-to-r6-emul.c

-- 
2.2.1
