Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Aug 2017 15:18:57 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:41908 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993968AbdHRNSsv4Ey9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 18 Aug 2017 15:18:48 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id 8BF151A1DF4;
        Fri, 18 Aug 2017 15:18:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.domain.local (unknown [10.10.13.95])
        by mail.rt-rk.com (Postfix) with ESMTPSA id 6EBED1A1DCA;
        Fri, 18 Aug 2017 15:18:42 +0200 (CEST)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org
Cc:     Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        Bo Hu <bohu@google.com>,
        Douglas Leung <douglas.leung@imgtec.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Jin Qian <jinqian@google.com>, linux-kernel@vger.kernel.org,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 0/6] MIPS: math-emu: FP emulation fixes and improvements
Date:   Fri, 18 Aug 2017 15:17:29 +0200
Message-Id: <1503062286-27030-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59656
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aleksandar.markovic@rt-rk.com
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

From: Aleksandar Markovic <aleksandar.markovic@imgtec.com>

This series includes:

  - a fix for certain SIGILL program crashes on issuing a valid
    CMP instruction
  - a fix for RINT emulation inaccuracies
  - a fix for the output of CLASS.D instruction emulation
  - several FP emulation debugfs statistics improvements

The patches in this series are logically and physically
independent on the patches previously sent in "Misc" series.
This means that these two series can be applied independently,
in any order.

The script "checkpatch --strict" returns a check and a warning
iff aplied on the patch 6. However, they are unavoidable if the
code is to be kept consistent in the file me-debugfs.c.

Aleksandar Markovic (6):
  MIPS: math-emu: CMP.Sxxx.<D|S>: Prevent occurences of SIGILL crashes
  MIPS: math-emu: RINT.<D|S>: Fix several problems by reimplementation
  MIPS: math-emu: CLASS.D: Zero bits 32-63 of the result
  MIPS: math-emu: Add FP emu debugfs statistics for branches
  MIPS: math-emu: Add FP emu debugfs reset functionality
  MIPS: math-emu: Add FP emu debugfs stats for individual instructions

 MAINTAINERS                          |   7 +
 arch/mips/include/asm/fpu_emulator.h | 116 +++++++++++++
 arch/mips/math-emu/Makefile          |   6 +-
 arch/mips/math-emu/cp1emu.c          | 272 +++++++++++++++++++++++++++++-
 arch/mips/math-emu/dp_rint.c         |  89 ++++++++++
 arch/mips/math-emu/ieee754.h         |   2 +
 arch/mips/math-emu/me-debugfs.c      | 318 ++++++++++++++++++++++++++++++++++-
 arch/mips/math-emu/sp_rint.c         |  90 ++++++++++
 8 files changed, 888 insertions(+), 12 deletions(-)
 create mode 100644 arch/mips/math-emu/dp_rint.c
 create mode 100644 arch/mips/math-emu/sp_rint.c

-- 
2.7.4
