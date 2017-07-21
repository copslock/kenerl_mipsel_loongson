Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jul 2017 16:17:57 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:56054 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994856AbdGUON3XUS0G (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 21 Jul 2017 16:13:29 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id EAFCB1A4ABB;
        Fri, 21 Jul 2017 16:13:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.domain.local (rtrkw197-lin.domain.local [10.10.13.95])
        by mail.rt-rk.com (Postfix) with ESMTPSA id 9495A1A4153;
        Fri, 21 Jul 2017 16:13:23 +0200 (CEST)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org
Cc:     Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        Douglas Leung <douglas.leung@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        linux-kernel@vger.kernel.org, Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v3 13/16] MIPS: math-emu: <MADDF|MSUBF>.<D|S>: Fix some cases of zero inputs
Date:   Fri, 21 Jul 2017 16:09:11 +0200
Message-Id: <1500646206-2436-14-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1500646206-2436-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1500646206-2436-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59189
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

Fix the cases of <MADDF|MSUBF>.<D|S> when any of two multiplicands is
+0 or -0, and the third input is also +0 or -0. Depending on the signs
of inputs, certain special cases must be handled.

The relevant example:

MADDF.S fd,fs,ft:
  If fs contains +0.0, ft contains -0.0, and fd contains 0.0, fd is
  going to contain +0.0 (without this patch, it used to contain -0.0).

Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
---
 arch/mips/math-emu/dp_maddf.c | 8 ++++++++
 arch/mips/math-emu/sp_maddf.c | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/mips/math-emu/dp_maddf.c b/arch/mips/math-emu/dp_maddf.c
index 45f815d..b8b2c17 100644
--- a/arch/mips/math-emu/dp_maddf.c
+++ b/arch/mips/math-emu/dp_maddf.c
@@ -113,6 +113,14 @@ static union ieee754dp _dp_maddf(union ieee754dp z, union ieee754dp x,
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_ZERO):
 		if (zc == IEEE754_CLASS_INF)
 			return ieee754dp_inf(zs);
+		/* Handle cases +0 + (-0) and similar ones. */
+		if (zc == IEEE754_CLASS_ZERO) {
+			if ((!(flags & maddf_negate_product) && (zs == (xs ^ ys))) ||
+			    ((flags & maddf_negate_product) && (zs != (xs ^ ys))))
+				return z;
+			else
+				return ieee754dp_zero(ieee754_csr.rm == FPU_CSR_RD);
+		}
 		/* Multiplication is 0 so just return z */
 		return z;
 
diff --git a/arch/mips/math-emu/sp_maddf.c b/arch/mips/math-emu/sp_maddf.c
index 76856d7..cb8597b 100644
--- a/arch/mips/math-emu/sp_maddf.c
+++ b/arch/mips/math-emu/sp_maddf.c
@@ -114,6 +114,14 @@ static union ieee754sp _sp_maddf(union ieee754sp z, union ieee754sp x,
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_ZERO):
 		if (zc == IEEE754_CLASS_INF)
 			return ieee754sp_inf(zs);
+		/* Handle cases +0 + (-0) and similar ones. */
+		if (zc == IEEE754_CLASS_ZERO) {
+			if ((!(flags & maddf_negate_product) && (zs == (xs ^ ys))) ||
+			    ((flags & maddf_negate_product) && (zs != (xs ^ ys))))
+				return z;
+			else
+				return ieee754sp_zero(ieee754_csr.rm == FPU_CSR_RD);
+		}
 		/* Multiplication is 0 so just return z */
 		return z;
 
-- 
2.7.4
