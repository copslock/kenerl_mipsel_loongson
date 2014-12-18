Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2014 16:10:31 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:39462 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009094AbaLRPK3Tb6RB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Dec 2014 16:10:29 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id DFBA2A51408C7
        for <linux-mips@linux-mips.org>; Thu, 18 Dec 2014 15:10:18 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 18 Dec 2014 15:10:22 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.125) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 18 Dec 2014 15:10:20 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH RFC 00/67] Add MIPS R6 support
Date:   Thu, 18 Dec 2014 15:09:09 +0000
Message-ID: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.125]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44735
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

This RFC patch adds support for MIPS R6. Some bits, (and mostly for the emulator)
have been taken from Leonid's branch on
http://git.linux-mips.org/cgit/yegoshin/mips.git/log/?id=refs/heads/android-linux-mti-r6-3.10

The rest of the stuff have mostly been re-written.

This patch is based on v3.18

The emulator is likely to change once David Daney's patches have been
merged	so treat the emulator patches lightly. It's not needed to run
an R6 userland.

This has been tested with mips32r6/mips64r6 BE/LE builds with
mipsel/mips/mips64/mips64el R6 buildroot and mipsel/mips64el R2
buildroot.

You can get an R6 toolchain from here:
http://community.imgtec.com/developers/mips/tools/codescape-mips-sdk/

A suitable public QEMU R6 tree can be found here:
https://github.com/prplfoundation/qemu.git i6400-mips64r6-PRIP4

Both 32-bit (-cpu mips32r6-generic) and 64-bit (-cpu mips64r6-generic)
R6 options are supported and expected to work with these patches.

You can find all these patches in the following git tree:
git://git.linux-mips.org/pub/scm/mchandras/linux.git 3.18-mipsr6-rfc-1


Leonid Yegoshin (20):
  MIPS: Add generic QEMU R6 PRid and cpu type identifiers
  MIPS: Add cases for CPU_QEMUR6
  MIPS: Add MIPS QEMUR6 probe support
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
  MIPS: lib: memcpy: Add MIPS R6 support
  MIPS: lib: memset: Add MIPS R6 support
  MIPS: mm: tlbex: Add MIPS R6 case for the EHB instruction
  MIPS: kernel: mips-r2-to-r6-emul: Add R2 emulator for MIPS R6

Markos Chandras (47):
  MIPS: asm: asm: Add new macros to set ISA and arch asm annotations
  MIPS: asm: asmmacro: Drop unused 'reg' argument on MIPSR2
  MIPS: asm: asmmacro: Replace add instructions with "addui"
  MIPS: Use generic checksum functions for MIPS R6
  MIPS: asm: hazards: Add MIPSR6 definitions
  MIPS: asm: irqflags: Add MIPS R6 related definitions
  MIPS: asm: r4kcache: Add MIPS R6 cache unroll functions
  MIPS: asm: spram: Add MIPS R6 related definitions
  MIPS: asm: atomic: Update asm and ISA constrains for MIPS R6 support
  MIPS: asm: cmpxchg: Update asm and ISA constrains for MIPS R6 support
  MIPS: asm: bitops: Update asm and ISA constrains for MIPS R6 support
  MIPS: asm: futex: Update asm and ISA constrains for MIPS R6 support
  MIPS: asm: spinlock: Update asm constrains for MIPS R6 support
  MIPS: asm: spinlock: Replace sub instruction with addiu
  MIPS: kernel: entry.S: Add MIPS R6 related definitions
  MIPS: kernel: proc: Add MIPS R6 support to /proc/cpuinfo
  MIPS: kernel: genex: Set correct ISA level
  MIPS: kernel: cps-vec: Replace addi with addiu
  MIPS: uapi: inst: Add new opcodes for COP2 instructions
  MIPS: kernel: unaligned: Add support for the MIPS R6
  MIPS: mm: page: Add MIPS R6 support
  MIPS: mm: c-r4k: Set the correct ISA level
  MIPS: kernel: branch: Prepare the JR instruction for emulation on MIPS
    R6
  MIPS: kernel: branch: Prevent BLTZL emulation for MIPS R6
  MIPS: kernel: branch: Prevent BGEZL emulation for MIPS R6
  MIPS: kernel: branch: Prevent BLTZAL emulation for MIPS R6
  MIPS: kernel: branch: Prevent BGEZAL emulation for MIPS R6
  MIPS: kernel: branch: Prevent BEQL emulation for MIPS R6
  MIPS: kernel: branch: Prevent BNEL emulation for MIPS R6
  MIPS: kernel: branch: Prevent BLEZL emulation for MIPS R6
  MIPS: kernel: branch: Prevent BGTZL emulation for MIPS R6
  MIPS: uapi: inst: Add new BC1EQZ and BC1NEZ MIPS R6 opcodes
  MIPS: kernel: branch: Add support for the BC1{EQ,NE}Z FPU branches
  MIPS: kernel: branch: Add new MIPS R6 B{L,G}ΕZ{AL,}C emulation
  MIPS: kernel: branch: Add new MIPS R6 B{L,G}TZ{AL,}C emulation
  MIPS: kernel: branch: Emulate the branch compact (BC) on MIPS R6
  MIPS: kernel: branch: Emulate the BOVC, BEQC and BEQZALC R6
    instructions
  MIPS: kernel: branch: Emulate the BNVC, BNEC and BNEZLAC R6
    instructions
  MIPS: kernel: branch: Emulate the BALC R6 instruction
  MIPS: kernel: branch: Emulate the BEQZC and JIC instructions
  MIPS: math-emu: cp1emu: Move the fpucondbit struct to a header
  MIPS: Add LLB bit and related feature for the Config 5 CP0 register
  MIPS: asm: mipsregs: Add support for the LLADDR register
  MIPS: Make use of the ERETNC instruction on MIPS R6
  MIPS: Malta: malta-int: Set correct asm ISA level
  MIPS: Malta: Add support for building MIPS R6 kernel
  MIPS: Add Malta QEMU 32R6 defconfig

 arch/mips/Kconfig                           |   66 +-
 arch/mips/Makefile                          |    4 +
 arch/mips/configs/malta_qemu_32r6_defconfig |  193 +++
 arch/mips/include/asm/Kbuild                |    1 +
 arch/mips/include/asm/asm.h                 |   13 +
 arch/mips/include/asm/asmmacro.h            |   22 +-
 arch/mips/include/asm/atomic.h              |   50 +-
 arch/mips/include/asm/bitops.h              |   91 +-
 arch/mips/include/asm/checksum.h            |    6 +
 arch/mips/include/asm/cmpxchg.h             |   28 +-
 arch/mips/include/asm/cpu-features.h        |   17 +-
 arch/mips/include/asm/cpu-type.h            |    5 +
 arch/mips/include/asm/cpu.h                 |   11 +-
 arch/mips/include/asm/fpu_emulator.h        |   12 +
 arch/mips/include/asm/futex.h               |   24 +-
 arch/mips/include/asm/hazards.h             |    8 +-
 arch/mips/include/asm/irqflags.h            |    6 +-
 arch/mips/include/asm/mips-r2-to-r6-emul.h  |   94 ++
 arch/mips/include/asm/mipsregs.h            |    3 +
 arch/mips/include/asm/module.h              |    4 +
 arch/mips/include/asm/r4kcache.h            |  149 +-
 arch/mips/include/asm/spinlock.h            |   60 +-
 arch/mips/include/asm/spram.h               |    4 +-
 arch/mips/include/asm/stackframe.h          |    8 +-
 arch/mips/include/asm/switch_to.h           |    9 +-
 arch/mips/include/asm/thread_info.h         |    2 +-
 arch/mips/include/uapi/asm/inst.h           |   32 +-
 arch/mips/kernel/Makefile                   |    2 +
 arch/mips/kernel/asm-offsets.c              |    1 +
 arch/mips/kernel/branch.c                   |  251 ++-
 arch/mips/kernel/cevt-r4k.c                 |    2 +-
 arch/mips/kernel/cps-vec.S                  |   16 +-
 arch/mips/kernel/cpu-bugs64.c               |   11 +-
 arch/mips/kernel/cpu-probe.c                |   24 +-
 arch/mips/kernel/entry.S                    |   23 +-
 arch/mips/kernel/genex.S                    |    2 +-
 arch/mips/kernel/idle.c                     |    1 +
 arch/mips/kernel/kprobes.c                  |    8 +-
 arch/mips/kernel/mips-r2-to-r6-emul.c       | 2377 +++++++++++++++++++++++++++
 arch/mips/kernel/mips_ksyms.c               |    2 +
 arch/mips/kernel/proc.c                     |    9 +-
 arch/mips/kernel/r4k_fpu.S                  |   10 +-
 arch/mips/kernel/r4k_switch.S               |   12 +-
 arch/mips/kernel/spram.c                    |    1 +
 arch/mips/kernel/traps.c                    |   41 +-
 arch/mips/kernel/unaligned.c                |  398 ++++-
 arch/mips/lib/Makefile                      |    1 +
 arch/mips/lib/memcpy.S                      |   23 +
 arch/mips/lib/memset.S                      |   47 +
 arch/mips/lib/mips-atomic.c                 |    2 +-
 arch/mips/math-emu/cp1emu.c                 |   20 +-
 arch/mips/mm/c-r4k.c                        |    3 +-
 arch/mips/mm/page.c                         |   20 +-
 arch/mips/mm/sc-mips.c                      |    1 +
 arch/mips/mm/tlbex.c                        |    3 +-
 arch/mips/mm/uasm-mips.c                    |   36 +-
 arch/mips/mm/uasm.c                         |   13 +-
 arch/mips/mti-malta/malta-int.c             |    2 +-
 58 files changed, 4008 insertions(+), 276 deletions(-)
 create mode 100644 arch/mips/configs/malta_qemu_32r6_defconfig
 create mode 100644 arch/mips/include/asm/mips-r2-to-r6-emul.h
 create mode 100644 arch/mips/kernel/mips-r2-to-r6-emul.c

-- 
2.2.0
