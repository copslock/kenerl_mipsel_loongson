Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Nov 2014 01:49:26 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:39869 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012929AbaKHAtYR0fVo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 8 Nov 2014 01:49:24 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sA80nNhv015216;
        Sat, 8 Nov 2014 01:49:23 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sA80nM5l015215;
        Sat, 8 Nov 2014 01:49:22 +0100
Date:   Sat, 8 Nov 2014 01:49:22 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mips@linux-mips.org
Subject: MIPS: Pull request
Message-ID: <20141108004922.GA14896@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43925
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

The following changes since commit cac7f2429872d3733dc3f9915857b1691da2eb2f:

  Linux 3.18-rc2 (2014-10-26 16:48:41 -0700)

are available in the git repository at:

  git://git.linux-mips.org/pub/scm/ralf/upstream-linus.git upstream

for you to fetch changes up to 842dfc11ea9a21f9825167c8a4f2834b205b0a79:

  MIPS: Fix build with binutils 2.24.51+ (2014-11-07 15:07:36 +0100)

This weeks' round of MIPS bug fixes for 3.18:

 o Wire up the bpf syscall
 o Fix TLB dump output for R3000 class TLBs
 o Fix strnlen_user return value if no NUL character was found.
 o Fix build with binutils 2.24.51+.  While there is no binutils 2.25
   release yet, toolchains derived from binutils 2.24.51+ are already in
   common use.
 o The Octeon GPIO code forgot to offline GPIO IRQs.
 o Fix build error for XLP.
 o Fix possible BUG assertion with EVA for CMA

Please consider pulling,

  Ralf

----------------------------------------------------------------
Alexander Sverdlin (1):
      MIPS: Octeon: Make Octeon GPIO IRQ chip CPU hotplug-aware

Isamu Mogi (1):
      MIPS: R3000: Fix debug output for Virtual page number

Manuel Lauss (1):
      MIPS: Fix build with binutils 2.24.51+

Ralf Baechle (2):
      MIPS: Wire up bpf syscall.
      MIPS: Fix strnlen_user() return value in case of overlong strings.

Yijing Wang (1):
      MIPS/Xlp: Remove the dead function destroy_irq() to fix build error

Zubair Lutfullah Kakakhel (1):
      MIPS: CMA: Do not reserve memory if not required

 arch/mips/Makefile                   |  9 +++++++++
 arch/mips/cavium-octeon/octeon-irq.c |  2 ++
 arch/mips/include/asm/asmmacro-32.h  |  6 ++++++
 arch/mips/include/asm/asmmacro.h     | 18 ++++++++++++++++++
 arch/mips/include/asm/fpregdef.h     | 14 ++++++++++++++
 arch/mips/include/asm/fpu.h          |  4 ++--
 arch/mips/include/asm/mipsregs.h     | 11 ++++++++++-
 arch/mips/include/uapi/asm/unistd.h  | 15 +++++++++------
 arch/mips/kernel/branch.c            |  8 ++------
 arch/mips/kernel/genex.S             |  1 +
 arch/mips/kernel/r2300_fpu.S         |  6 ++++++
 arch/mips/kernel/r2300_switch.S      |  5 +++++
 arch/mips/kernel/r4k_fpu.S           | 27 +++++++++++++++++++++++++--
 arch/mips/kernel/r4k_switch.S        | 15 ++++++++++++++-
 arch/mips/kernel/r6000_fpu.S         |  5 +++++
 arch/mips/kernel/scall32-o32.S       |  1 +
 arch/mips/kernel/scall64-64.S        |  1 +
 arch/mips/kernel/scall64-n32.S       |  1 +
 arch/mips/kernel/scall64-o32.S       |  1 +
 arch/mips/kernel/setup.c             |  3 ++-
 arch/mips/lib/r3k_dump_tlb.c         |  4 ++--
 arch/mips/lib/strnlen_user.S         |  6 ++++--
 arch/mips/math-emu/cp1emu.c          |  6 +-----
 arch/mips/pci/msi-xlp.c              |  4 +---
 24 files changed, 142 insertions(+), 31 deletions(-)
