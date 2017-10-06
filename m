Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Oct 2017 19:29:59 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:60417 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991743AbdJFR3u0fCCM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 6 Oct 2017 19:29:50 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id 557A01A4566;
        Fri,  6 Oct 2017 19:29:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local [10.10.13.111])
        by mail.rt-rk.com (Postfix) with ESMTPSA id 385FA1A2178;
        Fri,  6 Oct 2017 19:29:43 +0200 (CEST)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org
Cc:     Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        Douglas Leung <douglas.leung@imgtec.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 0/2] MIPS: Minor FPU emulation fixes
Date:   Fri,  6 Oct 2017 19:28:59 +0200
Message-Id: <1507310955-3525-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60314
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

This series contains two minor FPU emulation patches that
were not included into a recent larger series of FPU fixes,
mainly not to additionally burden already complex set of
patches.

Only the first patch changes functionality, and in such way
that it affects certain Mips debugfs features only.

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
