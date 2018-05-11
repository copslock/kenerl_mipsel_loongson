Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2018 07:55:28 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:33506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990404AbeENFzS3O8rO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 May 2018 07:55:18 +0200
Received: from localhost.localdomain (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77B8A217D6;
        Fri, 11 May 2018 21:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1526075241;
        bh=NdXe7rRB48eMRzgZaGCofbUb1pWHkXyqCEEowr9fBhA=;
        h=From:To:Cc:Subject:Date:From;
        b=clfXcY26UXmPYxDV/YHpkLm5J7JwWnDxXdqyYGZRREJd5ql1cmVmZs19JXU4msmCo
         weLjZKXbxui8ZqzQjxX4WDdkW5fAtVdNY3q95c1P1eau0DTeUuQNzETgzFVLufepbH
         PBHEGBI6aCKi8YNsDGTG9hFeLcPTHFMZ5/HT48TI=
From:   James Hogan <jhogan@kernel.org>
To:     linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        user-mode-linux-devel@lists.sourceforge.net
Cc:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Matthew Fortune <matthew.fortune@mips.com>,
        Robert Suchanek <robert.suchanek@mips.com>,
        linux-arch@vger.kernel.org
Subject: [PATCH v4 0/4] MIPS: Override barrier_before_unreachable() to fix microMIPS
Date:   Fri, 11 May 2018 22:46:58 +0100
Message-Id: <cover.a2e1d7681cb1ff2808945fc00db5f29c2f011783.1526074770.git-series.jhogan@kernel.org>
X-Mailer: git-send-email 2.17.0
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63897
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhogan@kernel.org
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

This series overrides barrier_before_unreachable() for MIPS to add an
.insn assembler directive.

Due to the subsequent __builtin_unreachable(), the assembler can't tell
that a label on the empty inline asm is code rather than data, so any
microMIPS branches targeting it (which sadly can't be removed) raise
errors due to the mismatching ISA mode, Adding the .insn in patch 4
tells the assembler that it should be treated as code.

To do this we add a new standard asm/compiler.h for architecture
overrides in patch 3. There are a few existing asm/compiler.h files
already existing, most of which are fairly simple and don't include
anything else (arm, arm64, mips). Unfortunately the alpha one includes
linux/compiler.h though, so it can undefine some inline macros. On
Arnd's suggestion this is converted to use OPTIMIZE_INLINING instead in
patch 1. A build of alpha's defconfig on GCC 7.3 before and after this
series results in the following size differences, which appear harmless
to me:

$ ./scripts/bloat-o-meter vmlinux.1 vmlinux.2
add/remove: 1/1 grow/shrink: 3/0 up/down: 264/-348 (-84)
Function                                     old     new   delta
cap_bprm_set_creds                          1496    1664    +168
cap_issubset                                   -      68     +68
flex_array_put                               328     344     +16
cap_capset                                   488     500     +12
nonroot_raised_pE.constprop                  348       -    -348
Total: Before=5823709, After=5823625, chg -0.00%

Also um needs the generated/ include directory adding to the include
paths in patch 2 so that an asm-generic wrapper asm/compiler.h can be
included from automatically included headers.

Changes in v4 (James):
- Fix asm-generic/compiler.h include from check, compiler_types.h is
  included on the command line so linux/compiler.h may not be included
  (kbuild test robot).
- New patch 2 to fix um (kbuild test robot).

Changes in v3 (James):
- New patch 1.
- Rebase after 4.17 arch removal and update commit messages.
- Use asm/compiler.h instead of compiler-gcc.h (Arnd).
- Drop stable tag for now.

Changes in v2 (Paul):
- Add generic-y entries to arch Kbuild files. Oops!

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: Matthew Fortune <matthew.fortune@mips.com>
Cc: Robert Suchanek <robert.suchanek@mips.com>
Cc: linux-alpha@vger.kernel.org
Cc: user-mode-linux-devel@lists.sourceforge.net
Cc: linux-mips@linux-mips.org
Cc: linux-arch@vger.kernel.org

James Hogan (2):
  alpha: Use OPTIMIZE_INLINING instead of asm/compiler.h
  um: Add generated/ to MODE_INCLUDE

Paul Burton (2):
  compiler.h: Allow arch-specific overrides
  MIPS: Workaround GCC __builtin_unreachable reordering bug

 arch/alpha/Kconfig                 |  6 ++++++
 arch/alpha/include/asm/compiler.h  | 11 -----------
 arch/arc/include/asm/Kbuild        |  1 +
 arch/c6x/include/asm/Kbuild        |  1 +
 arch/h8300/include/asm/Kbuild      |  1 +
 arch/hexagon/include/asm/Kbuild    |  1 +
 arch/ia64/include/asm/Kbuild       |  1 +
 arch/m68k/include/asm/Kbuild       |  1 +
 arch/microblaze/include/asm/Kbuild |  1 +
 arch/mips/include/asm/compiler.h   | 23 +++++++++++++++++++++++
 arch/nds32/include/asm/Kbuild      |  1 +
 arch/nios2/include/asm/Kbuild      |  1 +
 arch/openrisc/include/asm/Kbuild   |  1 +
 arch/parisc/include/asm/Kbuild     |  1 +
 arch/powerpc/include/asm/Kbuild    |  1 +
 arch/riscv/include/asm/Kbuild      |  1 +
 arch/s390/include/asm/Kbuild       |  1 +
 arch/sh/include/asm/Kbuild         |  1 +
 arch/sparc/include/asm/Kbuild      |  1 +
 arch/um/Makefile                   |  1 +
 arch/um/include/asm/Kbuild         |  1 +
 arch/unicore32/include/asm/Kbuild  |  1 +
 arch/x86/include/asm/Kbuild        |  1 +
 arch/xtensa/include/asm/Kbuild     |  1 +
 include/asm-generic/compiler.h     |  8 ++++++++
 include/linux/compiler-gcc.h       |  2 ++
 include/linux/compiler_types.h     |  3 +++
 27 files changed, 63 insertions(+), 11 deletions(-)
 create mode 100644 include/asm-generic/compiler.h

base-commit: 6d08b06e67cd117f6992c46611dfb4ce267cd71e
-- 
git-series 0.9.1
