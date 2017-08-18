Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Aug 2017 15:20:29 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:45722 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993968AbdHRNUPwhye9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 18 Aug 2017 15:20:15 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id 665A21A1D54;
        Fri, 18 Aug 2017 15:20:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.domain.local (unknown [10.10.13.95])
        by mail.rt-rk.com (Postfix) with ESMTPSA id 49D371A0EE6;
        Fri, 18 Aug 2017 15:20:10 +0200 (CEST)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org
Cc:     Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        Bo Hu <bohu@google.com>,
        Douglas Leung <douglas.leung@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Jin Qian <jinqian@google.com>, linux-kernel@vger.kernel.org,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 3/6] MIPS: math-emu: CLASS.D: Zero bits 32-63 of the result
Date:   Fri, 18 Aug 2017 15:17:32 +0200
Message-Id: <1503062286-27030-4-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1503062286-27030-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1503062286-27030-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59659
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

Fix content of CLASS.D output bits 32-63 to match hardware behavior.

Prior to this patch, bits 32-63 of CLASS.D output were not
initialized, causing differnet 32-63 bits content of CLASS.D, based on
circumstances. However, the hardware consistently returns all these
bits zeroed. The documentation is not clear whether these bits should
be zero or unpredicible. Since technically "all zero" case still can
be viewed as belonging to "unpredictible" class of results, it is
better to zero bits 32-63.

Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
---
 arch/mips/math-emu/cp1emu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index cabcf2c..1ad15f8 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -2144,8 +2144,8 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 				return SIGILL;
 
 			DPFROMREG(fs, MIPSInst_FS(ir));
-			rv.w = ieee754dp_2008class(fs);
-			rfmt = w_fmt;
+			rv.l = ieee754dp_2008class(fs);
+			rfmt = l_fmt;
 			break;
 		}
 
-- 
2.7.4
