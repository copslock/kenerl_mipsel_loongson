Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jul 2017 16:17:34 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:56045 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993977AbdGUONVUkklG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 21 Jul 2017 16:13:21 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id D374C1A4991;
        Fri, 21 Jul 2017 16:13:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.domain.local (rtrkw197-lin.domain.local [10.10.13.95])
        by mail.rt-rk.com (Postfix) with ESMTPSA id 741A01A4153;
        Fri, 21 Jul 2017 16:13:15 +0200 (CEST)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org
Cc:     Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        Douglas Leung <douglas.leung@imgtec.com>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        linux-kernel@vger.kernel.org, Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v3 12/16] MIPS: math-emu: <MADDF|MSUBF>.<D|S>: Fix some cases of infinite inputs
Date:   Fri, 21 Jul 2017 16:09:10 +0200
Message-Id: <1500646206-2436-13-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1500646206-2436-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1500646206-2436-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59188
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
infinity. The correct behavior in such cases is affected by the nature
of third input. Cases of addition of infinities with opposite signs
and subtraction of infinities with same signs may arise and must be
handles separately. Also, the value od flags argument (that determines
whether the instruction is MADDF or MSUBF) affects the outcome.

The relevant examples:

MADDF.S fd,fs,ft:
  If fs contains +inf, ft contains +inf, and fd contains -inf, fd is
  going to contain indef (without this patch, it used to contain
  -inf).

MSUBF.S fd,fs,ft:
  If fs contains +inf, ft contains 1.0, and fd contains +0.0, fd is
  going to contain -inf (without this patch, it used to contain +inf).

Signed-off-by: Douglas Leung <douglas.leung@imgtec.com>
Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
---
 arch/mips/math-emu/dp_maddf.c | 21 ++++++++++++++++++++-
 arch/mips/math-emu/sp_maddf.c | 21 ++++++++++++++++++++-
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/arch/mips/math-emu/dp_maddf.c b/arch/mips/math-emu/dp_maddf.c
index 4f2e783..45f815d 100644
--- a/arch/mips/math-emu/dp_maddf.c
+++ b/arch/mips/math-emu/dp_maddf.c
@@ -85,7 +85,26 @@ static union ieee754dp _dp_maddf(union ieee754dp z, union ieee754dp x,
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_NORM):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
-		return ieee754dp_inf(xs ^ ys);
+		if ((zc == IEEE754_CLASS_INF) &&
+		    ((!(flags & maddf_negate_product) && (zs != (xs ^ ys))) ||
+		     ((flags & maddf_negate_product) && (zs == (xs ^ ys))))) {
+			/*
+			 * Cases of addition of infinities with opposite signs
+			 * or subtraction of infinities with same signs.
+			 */
+			ieee754_setcx(IEEE754_INVALID_OPERATION);
+			return ieee754dp_indef();
+		}
+		/*
+		 * z is here either not infinity, or infinity of the same sign
+		 * as maddf_negate_product * x * y. So, the result must be
+		 * infinity, and its sign is determined only by the value of
+		 * (flags & maddf_negate_product) and the signs of x and y.
+		 */
+		if (flags & maddf_negate_product)
+			return ieee754dp_inf(1 ^ (xs ^ ys));
+		else
+			return ieee754dp_inf(xs ^ ys);
 
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_ZERO):
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_NORM):
diff --git a/arch/mips/math-emu/sp_maddf.c b/arch/mips/math-emu/sp_maddf.c
index 9fd2035..76856d7 100644
--- a/arch/mips/math-emu/sp_maddf.c
+++ b/arch/mips/math-emu/sp_maddf.c
@@ -86,7 +86,26 @@ static union ieee754sp _sp_maddf(union ieee754sp z, union ieee754sp x,
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_NORM):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
-		return ieee754sp_inf(xs ^ ys);
+		if ((zc == IEEE754_CLASS_INF) &&
+		    ((!(flags & maddf_negate_product) && (zs != (xs ^ ys))) ||
+		     ((flags & maddf_negate_product) && (zs == (xs ^ ys))))) {
+			/*
+			 * Cases of addition of infinities with opposite signs
+			 * or subtraction of infinities with same signs.
+			 */
+			ieee754_setcx(IEEE754_INVALID_OPERATION);
+			return ieee754sp_indef();
+		}
+		/*
+		 * z is here either not infinity, or infinity of the same sign
+		 * as maddf_negate_product * x * y. So, the result must be
+		 * infinity, and its sign is determined only by the value of
+		 * (flags & maddf_negate_product) and the signs of x and y.
+		 */
+		if (flags & maddf_negate_product)
+			return ieee754sp_inf(1 ^ (xs ^ ys));
+		else
+			return ieee754sp_inf(xs ^ ys);
 
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_ZERO):
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_NORM):
-- 
2.7.4
