Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jul 2017 18:17:01 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:57695 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994821AbdG0QMpppvr9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 27 Jul 2017 18:12:45 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id 3A9421A49F1;
        Thu, 27 Jul 2017 18:12:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.domain.local (rtrkw197-lin.domain.local [10.10.13.95])
        by mail.rt-rk.com (Postfix) with ESMTPSA id DD4501A4982;
        Thu, 27 Jul 2017 18:12:39 +0200 (CEST)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org
Cc:     Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        "# 4 . 7+" <stable@vger.kernel.org>, Bo Hu <bohu@google.com>,
        Douglas Leung <douglas.leung@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Jin Qian <jinqian@google.com>, linux-kernel@vger.kernel.org,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v4 14/16] MIPS: math-emu: <MADDF|MSUBF>.<D|S>: Clean up "maddf_flags" enumeration
Date:   Thu, 27 Jul 2017 18:08:57 +0200
Message-Id: <1501171791-23690-15-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1501171791-23690-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1501171791-23690-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59298
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

Fix definition and usage of "maddf_flags" enumeration. Avoid duplicate
definition and apply more common capitalization.

This patch does not change any scenario. It just makes MADDF and
MSUBF emulation code more readable and easier to maintain, and
hopefully prevents future bugs as well.

Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
Cc: <stable@vger.kernel.org> # 4.7+
Reviewed-by: James Hogan <james.hogan@imgtec.com>
---
 arch/mips/math-emu/dp_maddf.c   | 19 ++++++++-----------
 arch/mips/math-emu/ieee754int.h |  4 ++++
 arch/mips/math-emu/sp_maddf.c   | 19 ++++++++-----------
 3 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/arch/mips/math-emu/dp_maddf.c b/arch/mips/math-emu/dp_maddf.c
index c38fe1b..e799fc8 100644
--- a/arch/mips/math-emu/dp_maddf.c
+++ b/arch/mips/math-emu/dp_maddf.c
@@ -14,9 +14,6 @@
 
 #include "ieee754dp.h"
 
-enum maddf_flags {
-	maddf_negate_product	= 1 << 0,
-};
 
 static union ieee754dp _dp_maddf(union ieee754dp z, union ieee754dp x,
 				 union ieee754dp y, enum maddf_flags flags)
@@ -85,8 +82,8 @@ static union ieee754dp _dp_maddf(union ieee754dp z, union ieee754dp x,
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
 		if ((zc == IEEE754_CLASS_INF) &&
-		    ((!(flags & maddf_negate_product) && (zs != (xs ^ ys))) ||
-		     ((flags & maddf_negate_product) && (zs == (xs ^ ys))))) {
+		    ((!(flags & MADDF_NEGATE_PRODUCT) && (zs != (xs ^ ys))) ||
+		     ((flags & MADDF_NEGATE_PRODUCT) && (zs == (xs ^ ys))))) {
 			/*
 			 * Cases of addition of infinities with opposite signs
 			 * or subtraction of infinities with same signs.
@@ -99,9 +96,9 @@ static union ieee754dp _dp_maddf(union ieee754dp z, union ieee754dp x,
 		 * same sign as product (x*y) (in case of MADDF.D instruction)
 		 * or product -(x*y) (in MSUBF.D case). The result must be an
 		 * infinity, and its sign is determined only by the value of
-		 * (flags & maddf_negate_product) and the signs of x and y.
+		 * (flags & MADDF_NEGATE_PRODUCT) and the signs of x and y.
 		 */
-		if (flags & maddf_negate_product)
+		if (flags & MADDF_NEGATE_PRODUCT)
 			return ieee754dp_inf(1 ^ (xs ^ ys));
 		else
 			return ieee754dp_inf(xs ^ ys);
@@ -115,9 +112,9 @@ static union ieee754dp _dp_maddf(union ieee754dp z, union ieee754dp x,
 			return ieee754dp_inf(zs);
 		if (zc == IEEE754_CLASS_ZERO) {
 			/* Handle cases +0 + (-0) and similar ones. */
-			if ((!(flags & maddf_negate_product)
+			if ((!(flags & MADDF_NEGATE_PRODUCT)
 					&& (zs == (xs ^ ys))) ||
-			    ((flags & maddf_negate_product)
+			    ((flags & MADDF_NEGATE_PRODUCT)
 					&& (zs != (xs ^ ys))))
 				/*
 				 * Cases of addition of zeros of equal signs
@@ -167,7 +164,7 @@ static union ieee754dp _dp_maddf(union ieee754dp z, union ieee754dp x,
 
 	re = xe + ye;
 	rs = xs ^ ys;
-	if (flags & maddf_negate_product)
+	if (flags & MADDF_NEGATE_PRODUCT)
 		rs ^= 1;
 
 	/* shunt to top of word */
@@ -291,5 +288,5 @@ union ieee754dp ieee754dp_maddf(union ieee754dp z, union ieee754dp x,
 union ieee754dp ieee754dp_msubf(union ieee754dp z, union ieee754dp x,
 				union ieee754dp y)
 {
-	return _dp_maddf(z, x, y, maddf_negate_product);
+	return _dp_maddf(z, x, y, MADDF_NEGATE_PRODUCT);
 }
diff --git a/arch/mips/math-emu/ieee754int.h b/arch/mips/math-emu/ieee754int.h
index 8bc2f69..dd2071f 100644
--- a/arch/mips/math-emu/ieee754int.h
+++ b/arch/mips/math-emu/ieee754int.h
@@ -26,6 +26,10 @@
 
 #define CLPAIR(x, y)	((x)*6+(y))
 
+enum maddf_flags {
+	MADDF_NEGATE_PRODUCT	= 1 << 0,
+};
+
 static inline void ieee754_clearcx(void)
 {
 	ieee754_csr.cx = 0;
diff --git a/arch/mips/math-emu/sp_maddf.c b/arch/mips/math-emu/sp_maddf.c
index 4241ec1..07f5a9b 100644
--- a/arch/mips/math-emu/sp_maddf.c
+++ b/arch/mips/math-emu/sp_maddf.c
@@ -14,9 +14,6 @@
 
 #include "ieee754sp.h"
 
-enum maddf_flags {
-	maddf_negate_product	= 1 << 0,
-};
 
 static union ieee754sp _sp_maddf(union ieee754sp z, union ieee754sp x,
 				 union ieee754sp y, enum maddf_flags flags)
@@ -86,8 +83,8 @@ static union ieee754sp _sp_maddf(union ieee754sp z, union ieee754sp x,
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
 		if ((zc == IEEE754_CLASS_INF) &&
-		    ((!(flags & maddf_negate_product) && (zs != (xs ^ ys))) ||
-		     ((flags & maddf_negate_product) && (zs == (xs ^ ys))))) {
+		    ((!(flags & MADDF_NEGATE_PRODUCT) && (zs != (xs ^ ys))) ||
+		     ((flags & MADDF_NEGATE_PRODUCT) && (zs == (xs ^ ys))))) {
 			/*
 			 * Cases of addition of infinities with opposite signs
 			 * or subtraction of infinities with same signs.
@@ -100,9 +97,9 @@ static union ieee754sp _sp_maddf(union ieee754sp z, union ieee754sp x,
 		 * same sign as product (x*y) (in case of MADDF.D instruction)
 		 * or product -(x*y) (in MSUBF.D case). The result must be an
 		 * infinity, and its sign is determined only by the value of
-		 * (flags & maddf_negate_product) and the signs of x and y.
+		 * (flags & MADDF_NEGATE_PRODUCT) and the signs of x and y.
 		 */
-		if (flags & maddf_negate_product)
+		if (flags & MADDF_NEGATE_PRODUCT)
 			return ieee754sp_inf(1 ^ (xs ^ ys));
 		else
 			return ieee754sp_inf(xs ^ ys);
@@ -116,9 +113,9 @@ static union ieee754sp _sp_maddf(union ieee754sp z, union ieee754sp x,
 			return ieee754sp_inf(zs);
 		if (zc == IEEE754_CLASS_ZERO) {
 			/* Handle cases +0 + (-0) and similar ones. */
-			if ((!(flags & maddf_negate_product)
+			if ((!(flags & MADDF_NEGATE_PRODUCT)
 					&& (zs == (xs ^ ys))) ||
-			    ((flags & maddf_negate_product)
+			    ((flags & MADDF_NEGATE_PRODUCT)
 					&& (zs != (xs ^ ys))))
 				/*
 				 * Cases of addition of zeros of equal signs
@@ -170,7 +167,7 @@ static union ieee754sp _sp_maddf(union ieee754sp z, union ieee754sp x,
 
 	re = xe + ye;
 	rs = xs ^ ys;
-	if (flags & maddf_negate_product)
+	if (flags & MADDF_NEGATE_PRODUCT)
 		rs ^= 1;
 
 	/* shunt to top of word */
@@ -287,5 +284,5 @@ union ieee754sp ieee754sp_maddf(union ieee754sp z, union ieee754sp x,
 union ieee754sp ieee754sp_msubf(union ieee754sp z, union ieee754sp x,
 				union ieee754sp y)
 {
-	return _sp_maddf(z, x, y, maddf_negate_product);
+	return _sp_maddf(z, x, y, MADDF_NEGATE_PRODUCT);
 }
-- 
2.7.4
