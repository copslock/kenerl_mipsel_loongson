Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Nov 2013 13:49:24 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:52390 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822305Ab3KGMszCh5TV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 7 Nov 2013 13:48:55 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 0/6] FP improvements
Date:   Thu, 7 Nov 2013 12:48:27 +0000
Message-ID: <1383828513-28462-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.7.10
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.152.22]
X-SEF-Processed: 7_3_0_01192__2013_11_07_12_48_49
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38471
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

This series includes a few improvements to floating point support. The
first 2 patches add support for missing instructions to the FPU
emulator. The 3rd is a small cleanup. The 4th introduces support for
O32 binaries using 64-bit floating point. The 5th modifies the FPU
emulator to stop executing code from the user stack. The 6th & final
patch is not strictly FP-related but is a consequence of the 5th patch,
and allows us to mark the stack & allocated heap memory as
non-executable by default.

Leonid Yegoshin (1):
  mips: mfhc1 & mthc1 support for the FPU emulator

Paul Burton (4):
  mips: remove unused {en,dis}able_fpu macros
  mips: support for 64-bit FP with O32 binaries
  mips: use per-mm page to execute FP branch delay slots
  mips: non-exec stack & heap when non-exec PT_GNU_STACK is present

Steven J. Hill (1):
  mips: microMIPS: mfhc1 & mthc1 support for the FPU emulator

 arch/mips/Kconfig                    |  17 ++
 arch/mips/include/asm/asmmacro-32.h  |  42 -----
 arch/mips/include/asm/asmmacro-64.h  |  96 ----------
 arch/mips/include/asm/asmmacro.h     | 107 +++++++++++
 arch/mips/include/asm/elf.h          |  22 ++-
 arch/mips/include/asm/fpu.h          | 104 ++++++++---
 arch/mips/include/asm/fpu_emulator.h |   2 +
 arch/mips/include/asm/mmu.h          |  12 ++
 arch/mips/include/asm/mmu_context.h  |   7 +
 arch/mips/include/asm/page.h         |   6 +-
 arch/mips/include/asm/processor.h    |   7 +-
 arch/mips/include/asm/thread_info.h  |   6 +-
 arch/mips/include/uapi/asm/inst.h    |   7 +-
 arch/mips/kernel/Makefile            |   7 +-
 arch/mips/kernel/cpu-probe.c         |   2 +-
 arch/mips/kernel/elf.c               |  28 +++
 arch/mips/kernel/entry.S             |  13 +-
 arch/mips/kernel/process.c           |   5 +-
 arch/mips/kernel/ptrace.c            |   8 +-
 arch/mips/kernel/ptrace32.c          |   4 +-
 arch/mips/kernel/r4k_fpu.S           |  74 +++++++-
 arch/mips/kernel/r4k_switch.S        |  45 ++++-
 arch/mips/kernel/signal.c            |  10 +-
 arch/mips/kernel/signal32.c          |  10 +-
 arch/mips/kernel/traps.c             |  20 +-
 arch/mips/kernel/vdso.c              |   2 +-
 arch/mips/math-emu/cp1emu.c          |  37 +++-
 arch/mips/math-emu/dsemul.c          | 346 ++++++++++++++++++++++++++---------
 arch/mips/math-emu/kernel_linkage.c  |   6 +-
 29 files changed, 743 insertions(+), 309 deletions(-)
 create mode 100644 arch/mips/kernel/elf.c

-- 
1.8.4.1
