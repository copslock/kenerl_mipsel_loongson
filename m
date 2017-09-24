Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Sep 2017 22:47:56 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:35012 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993035AbdIXUlXxvhtz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 24 Sep 2017 22:41:23 +0200
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C628C266;
        Sun, 24 Sep 2017 20:41:14 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>, Bo Hu <bohu@google.com>,
        Douglas Leung <douglas.leung@imgtec.com>,
        Jin Qian <jinqian@google.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.13 026/109] MIPS: math-emu: <MADDF|MSUBF>.<D|S>: Clean up "maddf_flags" enumeration
Date:   Sun, 24 Sep 2017 22:32:47 +0200
Message-Id: <20170924203354.137274058@linuxfoundation.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170924203353.104695385@linuxfoundation.org>
References: <20170924203353.104695385@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60144
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aleksandar Markovic <aleksandar.markovic@imgtec.com>

commit ae11c0619973ffd73a496308d8a1cb5e1a353737 upstream.

Fix definition and usage of "maddf_flags" enumeration. Avoid duplicate
definition and apply more common capitalization.

This patch does not change any scenario. It just makes MADDF and
MSUBF emulation code more readable and easier to maintain, and
hopefully prevents future bugs as well.

Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
Cc: Bo Hu <bohu@google.com>
Cc: Douglas Leung <douglas.leung@imgtec.com>
Cc: Jin Qian <jinqian@google.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Petar Jovanovic <petar.jovanovic@imgtec.com>
Cc: Raghu Gandham <raghu.gandham@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/16889/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/math-emu/dp_maddf.c   |   19 ++++++++-----------
 arch/mips/math-emu/ieee754int.h |    4 ++++
 arch/mips/math-emu/sp_maddf.c   |   19 ++++++++-----------
 3 files changed, 20 insertions(+), 22 deletions(-)

--- a/arch/mips/math-emu/dp_maddf.c
+++ b/arch/mips/math-emu/dp_maddf.c
@@ -14,9 +14,6 @@
 
 #include "ieee754dp.h"
 
-enum maddf_flags {
-	maddf_negate_product	= 1 << 0,
-};
 
 static union ieee754dp _dp_maddf(union ieee754dp z, union ieee754dp x,
 				 union ieee754dp y, enum maddf_flags flags)
@@ -85,8 +82,8 @@ static union ieee754dp _dp_maddf(union i
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
@@ -99,9 +96,9 @@ static union ieee754dp _dp_maddf(union i
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
@@ -115,9 +112,9 @@ static union ieee754dp _dp_maddf(union i
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
@@ -167,7 +164,7 @@ static union ieee754dp _dp_maddf(union i
 
 	re = xe + ye;
 	rs = xs ^ ys;
-	if (flags & maddf_negate_product)
+	if (flags & MADDF_NEGATE_PRODUCT)
 		rs ^= 1;
 
 	/* shunt to top of word */
@@ -291,5 +288,5 @@ union ieee754dp ieee754dp_maddf(union ie
 union ieee754dp ieee754dp_msubf(union ieee754dp z, union ieee754dp x,
 				union ieee754dp y)
 {
-	return _dp_maddf(z, x, y, maddf_negate_product);
+	return _dp_maddf(z, x, y, MADDF_NEGATE_PRODUCT);
 }
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
--- a/arch/mips/math-emu/sp_maddf.c
+++ b/arch/mips/math-emu/sp_maddf.c
@@ -14,9 +14,6 @@
 
 #include "ieee754sp.h"
 
-enum maddf_flags {
-	maddf_negate_product	= 1 << 0,
-};
 
 static union ieee754sp _sp_maddf(union ieee754sp z, union ieee754sp x,
 				 union ieee754sp y, enum maddf_flags flags)
@@ -86,8 +83,8 @@ static union ieee754sp _sp_maddf(union i
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
@@ -100,9 +97,9 @@ static union ieee754sp _sp_maddf(union i
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
@@ -116,9 +113,9 @@ static union ieee754sp _sp_maddf(union i
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
@@ -170,7 +167,7 @@ static union ieee754sp _sp_maddf(union i
 
 	re = xe + ye;
 	rs = xs ^ ys;
-	if (flags & maddf_negate_product)
+	if (flags & MADDF_NEGATE_PRODUCT)
 		rs ^= 1;
 
 	/* shunt to top of word */
@@ -287,5 +284,5 @@ union ieee754sp ieee754sp_maddf(union ie
 union ieee754sp ieee754sp_msubf(union ieee754sp z, union ieee754sp x,
 				union ieee754sp y)
 {
-	return _sp_maddf(z, x, y, maddf_negate_product);
+	return _sp_maddf(z, x, y, MADDF_NEGATE_PRODUCT);
 }
