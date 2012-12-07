Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Dec 2012 06:05:51 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:60304 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6815793Ab2LGFFtn7xi0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Dec 2012 06:05:49 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1Tgq86-0007MA-T8; Thu, 06 Dec 2012 23:05:42 -0600
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH v99,00/13] Add support for pure microMIPS kernel.
Date:   Thu,  6 Dec 2012 23:05:24 -0600
Message-Id: <1354856737-28678-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.5
X-archive-position: 35211
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
image using only instructions from the microMIPS ISA. The result is
a kernel binary size reduction of more than 20% and an increase in
the speed of execution due to the smaller and faster instructions.

Douglas Leung (1):
  MIPS: microMIPS: Add vdso support.

Steven J. Hill (12):
  MIPS: microMIPS: Add support for microMIPS instructions.
  MIPS: Whitespace clean-ups after microMIPS additions.
  MIPS: microMIPS: Floating point support for 16-bit instructions.
  MIPS: microMIPS: Add support for exception handling.
  MIPS: microMIPS: Support handling of delay slots.
  MIPS: microMIPS: Add unaligned access support.
  MIPS: microMIPS: Add configuration option for microMIPS kernel.
  MIPS: microMIPS: Work-around for assembler bug.
  MIPS: microMIPS: Optimise 'memset' core library function.
  MIPS: microMIPS: Optimise 'strncpy' core library function.
  MIPS: microMIPS: Optimise 'strlen' core library function.
  MIPS: microMIPS: Optimise 'strnlen' core library function.

 arch/mips/Kconfig                      |   11 +
 arch/mips/Makefile                     |    1 +
 arch/mips/configs/sead3micro_defconfig |  125 +++
 arch/mips/include/asm/asm.h            |    2 +
 arch/mips/include/asm/branch.h         |   33 +-
 arch/mips/include/asm/fpu_emulator.h   |    7 +
 arch/mips/include/asm/inst.h           |  858 +++++++++++++++++-
 arch/mips/include/asm/mipsregs.h       |   41 +-
 arch/mips/include/asm/stackframe.h     |   12 +-
 arch/mips/include/asm/uaccess.h        |   14 +-
 arch/mips/kernel/branch.c              |  183 +++-
 arch/mips/kernel/cpu-probe.c           |    3 +
 arch/mips/kernel/genex.S               |   74 +-
 arch/mips/kernel/proc.c                |    5 +
 arch/mips/kernel/process.c             |  101 +++
 arch/mips/kernel/scall32-o32.S         |    9 +
 arch/mips/kernel/signal.c              |    6 +
 arch/mips/kernel/smtc-asm.S            |    3 +
 arch/mips/kernel/traps.c               |  296 +++++--
 arch/mips/kernel/unaligned.c           | 1496 +++++++++++++++++++++++++++-----
 arch/mips/lib/memset.S                 |   84 +-
 arch/mips/lib/strlen_user.S            |    9 +-
 arch/mips/lib/strncpy_user.S           |   28 +-
 arch/mips/lib/strnlen_user.S           |    2 +-
 arch/mips/math-emu/cp1emu.c            |  766 ++++++++++++++--
 arch/mips/math-emu/dsemul.c            |   40 +-
 arch/mips/mm/tlbex.c                   |   21 +
 arch/mips/mm/uasm-micromips.c          |  194 +++++
 arch/mips/mm/uasm-mips.c               |  178 ++++
 arch/mips/mm/uasm.c                    |  211 +----
 arch/mips/mti-sead3/sead3-init.c       |   48 +
 31 files changed, 4159 insertions(+), 702 deletions(-)
 create mode 100644 arch/mips/configs/sead3micro_defconfig
 create mode 100644 arch/mips/mm/uasm-micromips.c
 create mode 100644 arch/mips/mm/uasm-mips.c

-- 
1.7.9.5
