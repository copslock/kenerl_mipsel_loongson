Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 May 2012 22:46:32 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:42789 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903703Ab2EXUq1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 May 2012 22:46:27 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SXevM-0003qN-Jo; Thu, 24 May 2012 15:46:20 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>
Subject: [PATCH 0/9] Add support for pure microMIPS kernel.
Date:   Thu, 24 May 2012 15:45:57 -0500
Message-Id: <1337892366-24210-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10
X-archive-position: 33450
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

This set of patches is to support building a pure microMIPS kernel
image using only instruction from the microMIPS ISA. The result is
a kernel binary reduction of more than 20% and an increase in the
speed of execution due to the smaller and faster instructions.

Steven J. Hill (9):
  MIPS: Add microMIPS breakpoints and DSP support.
  MIPS: Add support for microMIPS instructions.
  MIPS: Add support for microMIPS exception handling.
  MIPS: Support microMIPS/MIPS16e handling of delay slots.
  MIPS: Support microMIPS/MIPS16e unaligned accesses.
  MIPS: Support microMIPS/MIPS16e floating point.
  MIPS: Work-around microMIPS GNU assembler bug.
  MIPS: Fixup ordering of micro assembler instructions.
  MIPS: Add microMIPS configuration option.

 arch/mips/Kconfig                      |   10 +
 arch/mips/Makefile                     |    1 +
 arch/mips/configs/sead3_defconfig      |    5 +-
 arch/mips/configs/sead3micro_defconfig | 1771 ++++++++++++++++++++++++++++++++
 arch/mips/include/asm/branch.h         |   33 +-
 arch/mips/include/asm/break.h          |   11 +-
 arch/mips/include/asm/dsp.h            |    4 +
 arch/mips/include/asm/fpu_emulator.h   |    7 +
 arch/mips/include/asm/futex.h          |    4 +
 arch/mips/include/asm/inst.h           |  882 +++++++++++++++-
 arch/mips/include/asm/mipsregs.h       |  359 +++----
 arch/mips/include/asm/paccess.h        |    2 +
 arch/mips/include/asm/stackframe.h     |   12 +-
 arch/mips/include/asm/uaccess.h        |   14 +-
 arch/mips/include/asm/uasm.h           |  103 +-
 arch/mips/kernel/branch.c              |  183 +++-
 arch/mips/kernel/cpu-probe.c           |    3 +
 arch/mips/kernel/genex.S               |   82 +-
 arch/mips/kernel/proc.c                |    9 +-
 arch/mips/kernel/process.c             |  101 ++
 arch/mips/kernel/scall32-o32.S         |   22 +-
 arch/mips/kernel/smtc-asm.S            |    3 +
 arch/mips/kernel/traps.c               |  375 +++++--
 arch/mips/kernel/unaligned.c           | 1496 +++++++++++++++++++++++----
 arch/mips/math-emu/cp1emu.c            |  766 ++++++++++++--
 arch/mips/math-emu/dsemul.c            |   40 +-
 arch/mips/mm/tlbex.c                   |   21 +
 arch/mips/mm/uasm.c                    |  214 +++-
 arch/mips/mti-sead3/sead3-init.c       |   48 +
 29 files changed, 5768 insertions(+), 813 deletions(-)
 create mode 100644 arch/mips/configs/sead3micro_defconfig

-- 
1.7.10
