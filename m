Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 16:23:35 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:4427 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817294AbaA0PX3PN8uE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 16:23:29 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 00/15] Initial MSA support
Date:   Mon, 27 Jan 2014 15:22:59 +0000
Message-ID: <1390836194-26286-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.152.22]
X-SEF-Processed: 7_3_0_01192__2014_01_27_15_23_23
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39094
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

This series introduces initial support for the MIPS SIMD Architecture
(MSA) ASE introduced with MIPSr5. This support allows for MSA being
detected & enabled for tasks which use it, and for vector registers
(which are aliased with FP registers) to be context switched. MSA
implementations with vector register partitioning are not handled since
none currently exist, and a mechanism for exposing the vector registers
via ptrace remains to be added later.

The series applies atop the current mips-for-linux-next branch. An
earlier version of the first patch has been sent to the list before, but
is now included in this series to make its intent clearer.

Paul Burton (15):
  mips: simplify FP context access
  mips: update outdated comment
  mips: move & rename fpu_emulator_{save,restore}_context
  mips: don't require FPU on sigcontext setup/restore
  mips: replace hardcoded 32 with NUM_FPU_REGS in ptrace
  mips: clear upper bits of FP registers on emulator writes
  mips: don't assume 64-bit FP registers for dump_{,task_}fpu
  mips: don't assume 64-bit FP registers for FP regset
  mips: don't assume 64-bit FP registers for context switch
  mips: add MSA register definitions & access
  mips: detect the MSA ASE
  mips: basic MSA context switching support
  mips: dumb MSA FP exception handler
  mips: panic if vector register partitioning is implemented
  mips: save/restore MSA context around signals

 arch/mips/Kconfig                       |  20 ++
 arch/mips/Makefile                      |   5 +
 arch/mips/include/asm/asmmacro-32.h     | 128 ++++++-------
 arch/mips/include/asm/asmmacro.h        | 319 +++++++++++++++++++++++++-------
 arch/mips/include/asm/cpu-features.h    |   6 +
 arch/mips/include/asm/cpu-info.h        |   1 +
 arch/mips/include/asm/cpu.h             |   1 +
 arch/mips/include/asm/fpu.h             |   2 +-
 arch/mips/include/asm/mipsregs.h        |   1 +
 arch/mips/include/asm/msa.h             | 199 ++++++++++++++++++++
 arch/mips/include/asm/processor.h       |  45 ++++-
 arch/mips/include/asm/sigcontext.h      |   2 +
 arch/mips/include/asm/switch_to.h       |  22 ++-
 arch/mips/include/asm/thread_info.h     |   4 +
 arch/mips/include/uapi/asm/sigcontext.h |   8 +
 arch/mips/kernel/asm-offsets.c          |  69 +++++++
 arch/mips/kernel/cpu-probe.c            |  26 +++
 arch/mips/kernel/genex.S                |   2 +
 arch/mips/kernel/proc.c                 |   1 +
 arch/mips/kernel/process.c              |  23 ++-
 arch/mips/kernel/ptrace.c               |  85 ++++++---
 arch/mips/kernel/ptrace32.c             |  25 +--
 arch/mips/kernel/r4k_fpu.S              | 213 +++++++++++++++++++++
 arch/mips/kernel/r4k_switch.S           |  58 ++++--
 arch/mips/kernel/signal.c               | 136 +++++++++++---
 arch/mips/kernel/signal32.c             | 134 ++++++++++++--
 arch/mips/kernel/traps.c                | 113 ++++++++++-
 arch/mips/math-emu/cp1emu.c             |  51 +++--
 arch/mips/math-emu/kernel_linkage.c     |  76 +-------
 29 files changed, 1433 insertions(+), 342 deletions(-)
 create mode 100644 arch/mips/include/asm/msa.h

-- 
1.8.5.3
