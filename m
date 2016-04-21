Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Apr 2016 15:07:36 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:20131 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026632AbcDUNHAwxlAj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Apr 2016 15:07:00 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id B2F0890CEF18A;
        Thu, 21 Apr 2016 14:06:47 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 21 Apr 2016 14:06:53 +0100
Received: from localhost (10.100.200.79) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Thu, 21 Apr
 2016 14:06:52 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 06/11] MIPS: math-emu: Unify ieee754dp_m{add,sub}f
Date:   Thu, 21 Apr 2016 14:04:50 +0100
Message-ID: <1461243895-30371-7-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1461243895-30371-1-git-send-email-paul.burton@imgtec.com>
References: <1461243895-30371-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.79]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53161
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

The code for emulating MIPSr6 madd.d & msub.d instructions has
previously been implemented as 2 different functions, namely
ieee754dp_maddf & ieee754dp_msubf. The difference in behaviour of these
2 instructions is merely the sign of the product, so we can easily share
the code implementing them. Do this for the double precision variant,
removing the original ieee754dp_msubf in favor of reusing the code from
ieee754dp_maddf.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/math-emu/Makefile   |   2 +-
 arch/mips/math-emu/dp_maddf.c |  22 +++-
 arch/mips/math-emu/dp_msubf.c | 269 ------------------------------------------
 3 files changed, 21 insertions(+), 272 deletions(-)
 delete mode 100644 arch/mips/math-emu/dp_msubf.c

diff --git a/arch/mips/math-emu/Makefile b/arch/mips/math-emu/Makefile
index 3389aff..e9bbc2a 100644
--- a/arch/mips/math-emu/Makefile
+++ b/arch/mips/math-emu/Makefile
@@ -4,7 +4,7 @@
 
 obj-y	+= cp1emu.o ieee754dp.o ieee754sp.o ieee754.o \
 	   dp_div.o dp_mul.o dp_sub.o dp_add.o dp_fsp.o dp_cmp.o dp_simple.o \
-	   dp_tint.o dp_fint.o dp_maddf.o dp_msubf.o dp_2008class.o dp_fmin.o dp_fmax.o \
+	   dp_tint.o dp_fint.o dp_maddf.o dp_2008class.o dp_fmin.o dp_fmax.o \
 	   sp_div.o sp_mul.o sp_sub.o sp_add.o sp_fdp.o sp_cmp.o sp_simple.o \
 	   sp_tint.o sp_fint.o sp_maddf.o sp_2008class.o sp_fmin.o sp_fmax.o \
 	   dsemul.o
diff --git a/arch/mips/math-emu/dp_maddf.c b/arch/mips/math-emu/dp_maddf.c
index 119eda9..d5e0fb1 100644
--- a/arch/mips/math-emu/dp_maddf.c
+++ b/arch/mips/math-emu/dp_maddf.c
@@ -14,8 +14,12 @@
 
 #include "ieee754dp.h"
 
-union ieee754dp ieee754dp_maddf(union ieee754dp z, union ieee754dp x,
-				union ieee754dp y)
+enum maddf_flags {
+	maddf_negate_product	= 1 << 0,
+};
+
+static union ieee754dp _dp_maddf(union ieee754dp z, union ieee754dp x,
+				 union ieee754dp y, enum maddf_flags flags)
 {
 	int re;
 	int rs;
@@ -154,6 +158,8 @@ union ieee754dp ieee754dp_maddf(union ieee754dp z, union ieee754dp x,
 
 	re = xe + ye;
 	rs = xs ^ ys;
+	if (flags & maddf_negate_product)
+		rs ^= 1;
 
 	/* shunt to top of word */
 	xm <<= 64 - (DP_FBITS + 1);
@@ -263,3 +269,15 @@ union ieee754dp ieee754dp_maddf(union ieee754dp z, union ieee754dp x,
 
 	return ieee754dp_format(zs, ze, zm);
 }
+
+union ieee754dp ieee754dp_maddf(union ieee754dp z, union ieee754dp x,
+				union ieee754dp y)
+{
+	return _dp_maddf(z, x, y, 0);
+}
+
+union ieee754dp ieee754dp_msubf(union ieee754dp z, union ieee754dp x,
+				union ieee754dp y)
+{
+	return _dp_maddf(z, x, y, maddf_negate_product);
+}
diff --git a/arch/mips/math-emu/dp_msubf.c b/arch/mips/math-emu/dp_msubf.c
deleted file mode 100644
index 1224126..0000000
--- a/arch/mips/math-emu/dp_msubf.c
+++ /dev/null
@@ -1,269 +0,0 @@
-/*
- * IEEE754 floating point arithmetic
- * double precision: MSUB.f (Fused Multiply Subtract)
- * MSUBF.fmt: FPR[fd] = FPR[fd] - (FPR[fs] x FPR[ft])
- *
- * MIPS floating point support
- * Copyright (C) 2015 Imagination Technologies, Ltd.
- * Author: Markos Chandras <markos.chandras@imgtec.com>
- *
- *  This program is free software; you can distribute it and/or modify it
- *  under the terms of the GNU General Public License as published by the
- *  Free Software Foundation; version 2 of the License.
- */
-
-#include "ieee754dp.h"
-
-union ieee754dp ieee754dp_msubf(union ieee754dp z, union ieee754dp x,
-				union ieee754dp y)
-{
-	int re;
-	int rs;
-	u64 rm;
-	unsigned lxm;
-	unsigned hxm;
-	unsigned lym;
-	unsigned hym;
-	u64 lrm;
-	u64 hrm;
-	u64 t;
-	u64 at;
-	int s;
-
-	COMPXDP;
-	COMPYDP;
-
-	u64 zm; int ze; int zs __maybe_unused; int zc;
-
-	EXPLODEXDP;
-	EXPLODEYDP;
-	EXPLODEDP(z, zc, zs, ze, zm)
-
-	FLUSHXDP;
-	FLUSHYDP;
-	FLUSHDP(z, zc, zs, ze, zm);
-
-	ieee754_clearcx();
-
-	switch (zc) {
-	case IEEE754_CLASS_SNAN:
-		ieee754_setcx(IEEE754_INVALID_OPERATION);
-		return ieee754dp_nanxcpt(z);
-	case IEEE754_CLASS_DNORM:
-		DPDNORMx(zm, ze);
-	/* QNAN is handled separately below */
-	}
-
-	switch (CLPAIR(xc, yc)) {
-	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_SNAN):
-	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_SNAN):
-	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_SNAN):
-	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_SNAN):
-	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_SNAN):
-		return ieee754dp_nanxcpt(y);
-
-	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_SNAN):
-	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_QNAN):
-	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_ZERO):
-	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_NORM):
-	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_DNORM):
-	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_INF):
-		return ieee754dp_nanxcpt(x);
-
-	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_QNAN):
-	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_QNAN):
-	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_QNAN):
-	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_QNAN):
-		return y;
-
-	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
-	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_ZERO):
-	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_NORM):
-	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_DNORM):
-	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_INF):
-		return x;
-
-
-	/*
-	 * Infinity handling
-	 */
-	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_ZERO):
-	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_INF):
-		if (zc == IEEE754_CLASS_QNAN)
-			return z;
-		ieee754_setcx(IEEE754_INVALID_OPERATION);
-		return ieee754dp_indef();
-
-	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_INF):
-	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_INF):
-	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_NORM):
-	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
-	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
-		if (zc == IEEE754_CLASS_QNAN)
-			return z;
-		return ieee754dp_inf(xs ^ ys);
-
-	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_ZERO):
-	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_NORM):
-	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_DNORM):
-	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_ZERO):
-	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_ZERO):
-		if (zc == IEEE754_CLASS_INF)
-			return ieee754dp_inf(zs);
-		/* Multiplication is 0 so just return z */
-		return z;
-
-	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_DNORM):
-		DPDNORMX;
-
-	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_DNORM):
-		if (zc == IEEE754_CLASS_QNAN)
-			return z;
-		else if (zc == IEEE754_CLASS_INF)
-			return ieee754dp_inf(zs);
-		DPDNORMY;
-		break;
-
-	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_NORM):
-		if (zc == IEEE754_CLASS_QNAN)
-			return z;
-		else if (zc == IEEE754_CLASS_INF)
-			return ieee754dp_inf(zs);
-		DPDNORMX;
-		break;
-
-	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_NORM):
-		if (zc == IEEE754_CLASS_QNAN)
-			return z;
-		else if (zc == IEEE754_CLASS_INF)
-			return ieee754dp_inf(zs);
-		/* fall through to real computations */
-	}
-
-	/* Finally get to do some computation */
-
-	/*
-	 * Do the multiplication bit first
-	 *
-	 * rm = xm * ym, re = xe + ye basically
-	 *
-	 * At this point xm and ym should have been normalized.
-	 */
-	assert(xm & DP_HIDDEN_BIT);
-	assert(ym & DP_HIDDEN_BIT);
-
-	re = xe + ye;
-	rs = xs ^ ys;
-
-	/* shunt to top of word */
-	xm <<= 64 - (DP_FBITS + 1);
-	ym <<= 64 - (DP_FBITS + 1);
-
-	/*
-	 * Multiply 32 bits xm, ym to give high 32 bits rm with stickness.
-	 */
-
-	/* 32 * 32 => 64 */
-#define DPXMULT(x, y)	((u64)(x) * (u64)y)
-
-	lxm = xm;
-	hxm = xm >> 32;
-	lym = ym;
-	hym = ym >> 32;
-
-	lrm = DPXMULT(lxm, lym);
-	hrm = DPXMULT(hxm, hym);
-
-	t = DPXMULT(lxm, hym);
-
-	at = lrm + (t << 32);
-	hrm += at < lrm;
-	lrm = at;
-
-	hrm = hrm + (t >> 32);
-
-	t = DPXMULT(hxm, lym);
-
-	at = lrm + (t << 32);
-	hrm += at < lrm;
-	lrm = at;
-
-	hrm = hrm + (t >> 32);
-
-	rm = hrm | (lrm != 0);
-
-	/*
-	 * Sticky shift down to normal rounding precision.
-	 */
-	if ((s64) rm < 0) {
-		rm = (rm >> (64 - (DP_FBITS + 1 + 3))) |
-		     ((rm << (DP_FBITS + 1 + 3)) != 0);
-			re++;
-	} else {
-		rm = (rm >> (64 - (DP_FBITS + 1 + 3 + 1))) |
-		     ((rm << (DP_FBITS + 1 + 3 + 1)) != 0);
-	}
-	assert(rm & (DP_HIDDEN_BIT << 3));
-
-	/* And now the subtraction */
-
-	/* flip sign of r and handle as add */
-	rs ^= 1;
-
-	assert(zm & DP_HIDDEN_BIT);
-
-	/*
-	 * Provide guard,round and stick bit space.
-	 */
-	zm <<= 3;
-
-	if (ze > re) {
-		/*
-		 * Have to shift y fraction right to align.
-		 */
-		s = ze - re;
-		rm = XDPSRS(rm, s);
-		re += s;
-	} else if (re > ze) {
-		/*
-		 * Have to shift x fraction right to align.
-		 */
-		s = re - ze;
-		zm = XDPSRS(zm, s);
-		ze += s;
-	}
-	assert(ze == re);
-	assert(ze <= DP_EMAX);
-
-	if (zs == rs) {
-		/*
-		 * Generate 28 bit result of adding two 27 bit numbers
-		 * leaving result in xm, xs and xe.
-		 */
-		zm = zm + rm;
-
-		if (zm >> (DP_FBITS + 1 + 3)) { /* carry out */
-			zm = XDPSRS1(zm);
-			ze++;
-		}
-	} else {
-		if (zm >= rm) {
-			zm = zm - rm;
-		} else {
-			zm = rm - zm;
-			zs = rs;
-		}
-		if (zm == 0)
-			return ieee754dp_zero(ieee754_csr.rm == FPU_CSR_RD);
-
-		/*
-		 * Normalize to rounding precision.
-		 */
-		while ((zm >> (DP_FBITS + 3)) == 0) {
-			zm <<= 1;
-			ze--;
-		}
-	}
-
-	return ieee754dp_format(zs, ze, zm);
-}
-- 
2.8.0
