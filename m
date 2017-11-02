Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Nov 2017 12:18:28 +0100 (CET)
Received: from mx2.rt-rk.com ([89.216.37.149]:52060 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993866AbdKBLQyIywFI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 Nov 2017 12:16:54 +0100
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id BBB391A4AD3;
        Thu,  2 Nov 2017 12:16:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local [10.10.13.111])
        by mail.rt-rk.com (Postfix) with ESMTPSA id 9D7901A4ACC;
        Thu,  2 Nov 2017 12:16:48 +0100 (CET)
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
        Manuel Lauss <manuel.lauss@gmail.com>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Paul Burton <paul.burton@mips.com>,
        Petar Jovanovic <petar.jovanovic@mips.com>,
        Raghu Gandham <raghu.gandham@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v3 7/8] MIPS: math-emu: Avoid multiple assignment
Date:   Thu,  2 Nov 2017 12:14:04 +0100
Message-Id: <1509621287-32198-8-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1509621287-32198-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1509621287-32198-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60669
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

Replace several instances of multiple assignment with individual
assignments.

Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
---
 arch/mips/math-emu/cp1emu.c  | 3 ++-
 arch/mips/math-emu/dp_sqrt.c | 6 ++++--
 arch/mips/math-emu/sp_sqrt.c | 3 ++-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 9e5c880..fe74973 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -1190,7 +1190,8 @@ static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			if (!cpu_has_mips_r6 || delay_slot(xcp))
 				return SIGILL;
 
-			cond = likely = 0;
+			likely = 0;
+			cond = 0;
 			fpr = &current->thread.fpu.fpr[MIPSInst_RT(ir)];
 			bit0 = get_fpr32(fpr, 0) & 0x1;
 			switch (MIPSInst_RS(ir)) {
diff --git a/arch/mips/math-emu/dp_sqrt.c b/arch/mips/math-emu/dp_sqrt.c
index cea907b..fa39eb8 100644
--- a/arch/mips/math-emu/dp_sqrt.c
+++ b/arch/mips/math-emu/dp_sqrt.c
@@ -91,7 +91,8 @@ union ieee754dp ieee754dp_sqrt(union ieee754dp x)
 		scalx -= 256;
 	}
 
-	y = x = builddp(0, xe + DP_EBIAS, xm & ~DP_HIDDEN_BIT);
+	x = builddp(0, xe + DP_EBIAS, xm & ~DP_HIDDEN_BIT);
+	y = x;
 
 	/* magic initial approximation to almost 8 sig. bits */
 	yh = y.bits >> 32;
@@ -108,7 +109,8 @@ union ieee754dp ieee754dp_sqrt(union ieee754dp x)
 
 	/* triple to almost 56 sig. bits: y ~= sqrt(x) to within 1 ulp */
 	/* t=y*y; z=t;	pt[n0]+=0x00100000; t+=z; z=(x-z)*y; */
-	z = t = ieee754dp_mul(y, y);
+	t = ieee754dp_mul(y, y);
+	z = t;
 	t.bexp += 0x001;
 	t = ieee754dp_add(t, z);
 	z = ieee754dp_mul(ieee754dp_sub(x, z), y);
diff --git a/arch/mips/math-emu/sp_sqrt.c b/arch/mips/math-emu/sp_sqrt.c
index 67059c3..9cc83f0 100644
--- a/arch/mips/math-emu/sp_sqrt.c
+++ b/arch/mips/math-emu/sp_sqrt.c
@@ -82,7 +82,8 @@ union ieee754sp ieee754sp_sqrt(union ieee754sp x)
 
 	/* generate sqrt(x) bit by bit */
 	ix += ix;
-	q = s = 0;		/* q = sqrt(x) */
+	s = 0;
+	q = 0;			/* q = sqrt(x) */
 	r = 0x01000000;		/* r = moving bit from right to left */
 
 	while (r != 0) {
-- 
2.7.4
