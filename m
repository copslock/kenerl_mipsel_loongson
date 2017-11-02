Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Nov 2017 12:15:39 +0100 (CET)
Received: from mx2.rt-rk.com ([89.216.37.149]:50616 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993373AbdKBLPc1cwGI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 Nov 2017 12:15:32 +0100
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id 282801A4AAD;
        Thu,  2 Nov 2017 12:15:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local [10.10.13.111])
        by mail.rt-rk.com (Postfix) with ESMTPSA id A58D11A1D20;
        Thu,  2 Nov 2017 12:15:25 +0100 (CET)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org
Cc:     Aleksandar Markovic <aleksandar.markovic@mips.com>,
        Douglas Leung <douglas.leung@imgtec.com>,
        Douglas Leung <douglas.leung@mips.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        Goran Ferenc <goran.ferenc@mips.com>,
        James Hogan <james.hogan@mips.com>,
        linux-kernel@vger.kernel.org,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Paul Burton <paul.burton@mips.com>,
        Petar Jovanovic <petar.jovanovic@mips.com>,
        Raghu Gandham <raghu.gandham@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v3 0/8] MIPS: Misc FPU emulation fixes
Date:   Thu,  2 Nov 2017 12:13:57 +0100
Message-Id: <1509621287-32198-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60662
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

From: Aleksandar Markovic <aleksandar.markovic@mips.com>

v2->v3:

    - further improved commit message of patch 1
    - minor adjustment to patch 2
    - added six new, mostly minor, patches
    - rebased to the latest code

v1->v2:

    - clarify effects of patch 1 in its commit message
    - marked patch 1 as "stable #4.3+"
    - replaced "Minor" with "Misc" in the series title and
      cover letter

This series contains twelwe misc FPU emulation patches that were
not included into a recent larger series of FPU fixes, mainly not
to additionally burden already complex set of patches.

Only the first patch changes functionality.

The remaining ones are just cosmetic changes - they just clean
the code, making it easier to read, debug and maintain, and, by
doing this, hopefully prevent future bugs. They remove a number
of checkpatch and sparse warnings as well.

Aleksandar Markovic (8):
  MIPS: math-emu: Fix final emulation phase for certain instructions
  MIPS: math-emu: Use preferred flavor of unsigned integer declarations
  MIPS: math-emu: Remove an unnecessary header inclusion
  MIPS: math-emu: Avoid definition duplication for macro DPXMULT()
  MIPS: math-emu: Declare function srl128() as static
  MIPS: math-emu: Avoid an assignment within if statement condition
  MIPS: math-emu: Avoid multiple assignment
  MIPS: math-emu: Mark fall throughs in switch statements with a comment

 arch/mips/math-emu/cp1emu.c     | 74 ++++++++++++++++++++++++-----------------
 arch/mips/math-emu/dp_add.c     |  3 +-
 arch/mips/math-emu/dp_div.c     |  1 +
 arch/mips/math-emu/dp_fmax.c    |  2 ++
 arch/mips/math-emu/dp_fmin.c    |  2 ++
 arch/mips/math-emu/dp_maddf.c   | 16 ++++-----
 arch/mips/math-emu/dp_mul.c     | 12 +++----
 arch/mips/math-emu/dp_sqrt.c    | 12 ++++---
 arch/mips/math-emu/dp_sub.c     |  2 +-
 arch/mips/math-emu/ieee754.h    | 15 +++++----
 arch/mips/math-emu/ieee754dp.h  |  3 ++
 arch/mips/math-emu/ieee754int.h |  6 ++--
 arch/mips/math-emu/ieee754sp.c  |  4 +--
 arch/mips/math-emu/ieee754sp.h  |  2 +-
 arch/mips/math-emu/sp_add.c     |  3 +-
 arch/mips/math-emu/sp_div.c     |  5 +--
 arch/mips/math-emu/sp_fdp.c     |  3 +-
 arch/mips/math-emu/sp_fint.c    |  2 +-
 arch/mips/math-emu/sp_fmax.c    |  2 ++
 arch/mips/math-emu/sp_fmin.c    |  2 ++
 arch/mips/math-emu/sp_maddf.c   |  9 ++---
 arch/mips/math-emu/sp_mul.c     | 11 +++---
 arch/mips/math-emu/sp_sqrt.c    |  3 +-
 arch/mips/math-emu/sp_sub.c     |  1 +
 arch/mips/math-emu/sp_tlong.c   |  1 -
 25 files changed, 111 insertions(+), 85 deletions(-)

-- 
2.7.4
