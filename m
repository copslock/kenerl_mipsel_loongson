Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2012 17:22:30 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:39797 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903628Ab2DIPWX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Apr 2012 17:22:23 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SHGQ2-0005vf-Tb; Mon, 09 Apr 2012 10:22:14 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>
Subject: [PATCH 0/9] Add support for pure microMIPS kernel.
Date:   Mon,  9 Apr 2012 10:21:54 -0500
Message-Id: <1333984923-445-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.6
X-archive-position: 32892
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

This set of patches is to support building a pure microMIPS kernel
image using only instruction from the microMIPS ISA. The result is
a kernel binary reduction of more than 20% and an increase in the
speed of execution due to the smaller and faster instructions.

Steven J. Hill (9):
  MIPS: Add microMIPS configuration option.
  MIPS: Optimise core library functions for microMIPS.
  MIPS: Add support for the M14KE core.
  MIPS: Add microMIPS versions of breakpoints, BUG, etc.
  MIPS: Add support for microMIPS instructions.
  MIPS: Add support for microMIPS exception handling.
  MIPS: Support microMIPS/MIPS16e handling of delay slots.
  MIPS: Support microMIPS/MIPS16e unaligned accesses.
  MIPS: Support microMIPS/MIPS16e floating point.

 arch/mips/Kconfig                      |   10 +
 arch/mips/Makefile                     |    1 +
 arch/mips/configs/sead3micro_defconfig | 1757 ++++++++++++++++++++++++++++++++
 arch/mips/include/asm/branch.h         |   33 +-
 arch/mips/include/asm/break.h          |    8 +
 arch/mips/include/asm/bug.h            |    8 +
 arch/mips/include/asm/cpu-features.h   |    3 +
 arch/mips/include/asm/cpu.h            |    4 +-
 arch/mips/include/asm/dsp.h            |    6 +-
 arch/mips/include/asm/fpu_emulator.h   |    7 +
 arch/mips/include/asm/futex.h          |    4 +
 arch/mips/include/asm/inst.h           |  882 +++++++++++++++-
 arch/mips/include/asm/mipsregs.h       |  359 +++----
 arch/mips/include/asm/paccess.h        |    2 +
 arch/mips/include/asm/page.h           |    6 +
 arch/mips/include/asm/stackframe.h     |   12 +-
 arch/mips/include/asm/uaccess.h        |   14 +-
 arch/mips/kernel/branch.c              |  183 +++-
 arch/mips/kernel/cpu-probe.c           |   10 +
 arch/mips/kernel/genex.S               |   82 +-
 arch/mips/kernel/proc.c                |   27 +-
 arch/mips/kernel/process.c             |  101 ++
 arch/mips/kernel/ptrace.c              |    4 +
 arch/mips/kernel/scall32-o32.S         |   22 +-
 arch/mips/kernel/smtc-asm.S            |    3 +
 arch/mips/kernel/traps.c               |  377 ++++---
 arch/mips/kernel/unaligned.c           | 1496 +++++++++++++++++++++++----
 arch/mips/lib/memcpy.S                 |   17 +-
 arch/mips/lib/memset.S                 |   90 +-
 arch/mips/lib/strlen_user.S            |   13 +-
 arch/mips/lib/strncpy_user.S           |   39 +-
 arch/mips/lib/strnlen_user.S           |   24 +-
 arch/mips/math-emu/cp1emu.c            |  766 ++++++++++++--
 arch/mips/math-emu/dsemul.c            |   40 +-
 arch/mips/mm/c-r4k.c                   |    1 +
 arch/mips/mm/fault.c                   |    2 +
 arch/mips/mm/page.c                    |   26 +-
 arch/mips/mm/tlbex.c                   |   23 +
 arch/mips/mm/uasm.c                    |  174 +++-
 arch/mips/mti-sead3/sead3-init.c       |   57 +-
 arch/mips/oprofile/common.c            |    1 +
 arch/mips/oprofile/op_model_mipsxx.c   |    4 +
 42 files changed, 5877 insertions(+), 821 deletions(-)
 create mode 100644 arch/mips/configs/sead3micro_defconfig

-- 
1.7.9.6
