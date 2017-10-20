Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Oct 2017 16:18:56 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:40628 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992181AbdJTOStY4W3- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 20 Oct 2017 16:18:49 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id D54DD1A4833;
        Fri, 20 Oct 2017 16:18:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local [10.10.13.111])
        by mail.rt-rk.com (Postfix) with ESMTPSA id B7D421A20E1;
        Fri, 20 Oct 2017 16:18:42 +0200 (CEST)
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
Subject: [PATCH v2 0/2] MIPS: Misc FPU emulation fixes 
Date:   Fri, 20 Oct 2017 16:16:26 +0200
Message-Id: <1508509002-28518-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60493
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

v1->v2:

   - clarify effects of the first patch in its commit message
   - marked the first patch as "stable #4.3+"
   - replaced "Minor" with "Misc" in the series title and
     cover letter

This series contains two misc FPU emulation patches that
were not included into a recent larger series of FPU fixes,
mainly not to additionally burden already complex set of
patches.

Only the first patch changes functionality.

The second one is just a cosmetic change - it just cleans
the code, and removes some checkpatch warnings.

Aleksandar Markovic (2):
  MIPS: math-emu: Update debugfs FP exception stats for certain
    instructions
  MIPS: math-emu: Use preferred flavor of unsigned integer declarations

 arch/mips/math-emu/cp1emu.c     | 46 +++++++++++++++++++++--------------------
 arch/mips/math-emu/dp_maddf.c   |  8 +++----
 arch/mips/math-emu/dp_mul.c     |  8 +++----
 arch/mips/math-emu/dp_sqrt.c    |  4 ++--
 arch/mips/math-emu/ieee754.h    | 15 +++++++-------
 arch/mips/math-emu/ieee754int.h |  6 +++---
 arch/mips/math-emu/ieee754sp.c  |  4 ++--
 arch/mips/math-emu/ieee754sp.h  |  2 +-
 arch/mips/math-emu/sp_div.c     |  4 ++--
 arch/mips/math-emu/sp_fint.c    |  2 +-
 arch/mips/math-emu/sp_maddf.c   |  6 +++---
 arch/mips/math-emu/sp_mul.c     | 10 ++++-----
 12 files changed, 59 insertions(+), 56 deletions(-)

-- 
2.7.4
