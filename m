Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Apr 2016 15:07:19 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:22145 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27027124AbcDUNGpxE5gj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Apr 2016 15:06:45 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id A008CE02327E8;
        Thu, 21 Apr 2016 14:06:32 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 21 Apr 2016 14:06:39 +0100
Received: from localhost (10.100.200.79) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Thu, 21 Apr
 2016 14:06:38 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 05/11] MIPS: math-emu: Unify ieee754sp_m{add,sub}f
Date:   Thu, 21 Apr 2016 14:04:49 +0100
Message-ID: <1461243895-30371-6-git-send-email-paul.burton@imgtec.com>
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
X-archive-position: 53160
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

The code for emulating MIPSr6 madd.s & msub.s instructions has
previously been implemented as 2 different functions, namely
ieee754sp_maddf & ieee754sp_msubf. The difference in behaviour of these
2 instructions is merely the sign of the product, so we can easily share
the code implementing them. Do this for the single precision variant,
removing the original ieee754sp_msubf in favor of reusing the code from
ieee754sp_maddf.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/math-emu/Makefile   |   2 +-
 arch/mips/math-emu/sp_maddf.c |  22 +++-
 arch/mips/math-emu/sp_msubf.c | 258 ------------------------------------------
 3 files changed, 21 insertions(+), 261 deletions(-)
 delete mode 100644 arch/mips/math-emu/sp_msubf.c

diff --git a/arch/mips/math-emu/Makefile b/arch/mips/math-emu/Makefile
index a19641d..3389aff 100644
--- a/arch/mips/math-emu/Makefile
+++ b/arch/mips/math-emu/Makefile
@@ -6,7 +6,7 @@ obj-y	+= cp1emu.o ieee754dp.o ieee754sp.o ieee754.o \
 	   dp_div.o dp_mul.o dp_sub.o dp_add.o dp_fsp.o dp_cmp.o dp_simple.o \
 	   dp_tint.o dp_fint.o dp_maddf.o dp_msubf.o dp_2008class.o dp_fmin.o dp_fmax.o \
 	   sp_div.o sp_mul.o sp_sub.o sp_add.o sp_fdp.o sp_cmp.o sp_simple.o \
-	   sp_tint.o sp_fint.o sp_maddf.o sp_msubf.o sp_2008class.o sp_fmin.o sp_fmax.o \
+	   sp_tint.o sp_fint.o sp_maddf.o sp_2008class.o sp_fmin.o sp_fmax.o \
 	   dsemul.o
 
 lib-y	+= ieee754d.o \
diff --git a/arch/mips/math-emu/sp_maddf.c b/arch/mips/math-emu/sp_maddf.c
index dd1dd83..93b7132 100644
--- a/arch/mips/math-emu/sp_maddf.c
+++ b/arch/mips/math-emu/sp_maddf.c
@@ -14,8 +14,12 @@
 
 #include "ieee754sp.h"
 
-union ieee754sp ieee754sp_maddf(union ieee754sp z, union ieee754sp x,
-				union ieee754sp y)
+enum maddf_flags {
+	maddf_negate_product	= 1 << 0,
+};
+
+static union ieee754sp _sp_maddf(union ieee754sp z, union ieee754sp x,
+				 union ieee754sp y, enum maddf_flags flags)
 {
 	int re;
 	int rs;
@@ -154,6 +158,8 @@ union ieee754sp ieee754sp_maddf(union ieee754sp z, union ieee754sp x,
 
 	re = xe + ye;
 	rs = xs ^ ys;
+	if (flags & maddf_negate_product)
+		rs ^= 1;
 
 	/* shunt to top of word */
 	xm <<= 32 - (SP_FBITS + 1);
@@ -253,3 +259,15 @@ union ieee754sp ieee754sp_maddf(union ieee754sp z, union ieee754sp x,
 	}
 	return ieee754sp_format(zs, ze, zm);
 }
+
+union ieee754sp ieee754sp_maddf(union ieee754sp z, union ieee754sp x,
+				union ieee754sp y)
+{
+	return _sp_maddf(z, x, y, 0);
+}
+
+union ieee754sp ieee754sp_msubf(union ieee754sp z, union ieee754sp x,
+				union ieee754sp y)
+{
+	return _sp_maddf(z, x, y, maddf_negate_product);
+}
diff --git a/arch/mips/math-emu/sp_msubf.c b/arch/mips/math-emu/sp_msubf.c
deleted file mode 100644
index 81c38b980..0000000
--- a/arch/mips/math-emu/sp_msubf.c
+++ /dev/null
@@ -1,258 +0,0 @@
-/*
- * IEEE754 floating point arithmetic
- * single precision: MSUB.f (Fused Multiply Subtract)
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
-#include "ieee754sp.h"
-
-union ieee754sp ieee754sp_msubf(union ieee754sp z, union ieee754sp x,
-				union ieee754sp y)
-{
-	int re;
-	int rs;
-	unsigned rm;
-	unsigned short lxm;
-	unsigned short hxm;
-	unsigned short lym;
-	unsigned short hym;
-	unsigned lrm;
-	unsigned hrm;
-	unsigned t;
-	unsigned at;
-	int s;
-
-	COMPXSP;
-	COMPYSP;
-	u32 zm; int ze; int zs __maybe_unused; int zc;
-
-	EXPLODEXSP;
-	EXPLODEYSP;
-	EXPLODESP(z, zc, zs, ze, zm)
-
-	FLUSHXSP;
-	FLUSHYSP;
-	FLUSHSP(z, zc, zs, ze, zm);
-
-	ieee754_clearcx();
-
-	switch (zc) {
-	case IEEE754_CLASS_SNAN:
-		ieee754_setcx(IEEE754_INVALID_OPERATION);
-		return ieee754sp_nanxcpt(z);
-	case IEEE754_CLASS_DNORM:
-		SPDNORMx(zm, ze);
-	/* QNAN is handled separately below */
-	}
-
-	switch (CLPAIR(xc, yc)) {
-	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_SNAN):
-	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_SNAN):
-	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_SNAN):
-	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_SNAN):
-	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_SNAN):
-		return ieee754sp_nanxcpt(y);
-
-	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_SNAN):
-	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_QNAN):
-	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_ZERO):
-	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_NORM):
-	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_DNORM):
-	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_INF):
-		return ieee754sp_nanxcpt(x);
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
-	/*
-	 * Infinity handling
-	 */
-	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_ZERO):
-	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_INF):
-		if (zc == IEEE754_CLASS_QNAN)
-			return z;
-		ieee754_setcx(IEEE754_INVALID_OPERATION);
-		return ieee754sp_indef();
-
-	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_INF):
-	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_INF):
-	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_NORM):
-	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
-	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
-		if (zc == IEEE754_CLASS_QNAN)
-			return z;
-		return ieee754sp_inf(xs ^ ys);
-
-	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_ZERO):
-	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_NORM):
-	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_DNORM):
-	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_ZERO):
-	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_ZERO):
-		if (zc == IEEE754_CLASS_INF)
-			return ieee754sp_inf(zs);
-		/* Multiplication is 0 so just return z */
-		return z;
-
-	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_DNORM):
-		SPDNORMX;
-
-	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_DNORM):
-		if (zc == IEEE754_CLASS_QNAN)
-			return z;
-		else if (zc == IEEE754_CLASS_INF)
-			return ieee754sp_inf(zs);
-		SPDNORMY;
-		break;
-
-	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_NORM):
-		if (zc == IEEE754_CLASS_QNAN)
-			return z;
-		else if (zc == IEEE754_CLASS_INF)
-			return ieee754sp_inf(zs);
-		SPDNORMX;
-		break;
-
-	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_NORM):
-		if (zc == IEEE754_CLASS_QNAN)
-			return z;
-		else if (zc == IEEE754_CLASS_INF)
-			return ieee754sp_inf(zs);
-		/* fall through to real compuation */
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
-
-	/* rm = xm * ym, re = xe+ye basically */
-	assert(xm & SP_HIDDEN_BIT);
-	assert(ym & SP_HIDDEN_BIT);
-
-	re = xe + ye;
-	rs = xs ^ ys;
-
-	/* shunt to top of word */
-	xm <<= 32 - (SP_FBITS + 1);
-	ym <<= 32 - (SP_FBITS + 1);
-
-	/*
-	 * Multiply 32 bits xm, ym to give high 32 bits rm with stickness.
-	 */
-	lxm = xm & 0xffff;
-	hxm = xm >> 16;
-	lym = ym & 0xffff;
-	hym = ym >> 16;
-
-	lrm = lxm * lym;	/* 16 * 16 => 32 */
-	hrm = hxm * hym;	/* 16 * 16 => 32 */
-
-	t = lxm * hym; /* 16 * 16 => 32 */
-	at = lrm + (t << 16);
-	hrm += at < lrm;
-	lrm = at;
-	hrm = hrm + (t >> 16);
-
-	t = hxm * lym; /* 16 * 16 => 32 */
-	at = lrm + (t << 16);
-	hrm += at < lrm;
-	lrm = at;
-	hrm = hrm + (t >> 16);
-
-	rm = hrm | (lrm != 0);
-
-	/*
-	 * Sticky shift down to normal rounding precision.
-	 */
-	if ((int) rm < 0) {
-		rm = (rm >> (32 - (SP_FBITS + 1 + 3))) |
-		    ((rm << (SP_FBITS + 1 + 3)) != 0);
-		re++;
-	} else {
-		rm = (rm >> (32 - (SP_FBITS + 1 + 3 + 1))) |
-		     ((rm << (SP_FBITS + 1 + 3 + 1)) != 0);
-	}
-	assert(rm & (SP_HIDDEN_BIT << 3));
-
-	/* And now the subtraction */
-
-	/* Flip sign of r and handle as add */
-	rs ^= 1;
-
-	assert(zm & SP_HIDDEN_BIT);
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
-		SPXSRSYn(s);
-	} else if (re > ze) {
-		/*
-		 * Have to shift x fraction right to align.
-		 */
-		s = re - ze;
-		SPXSRSYn(s);
-	}
-	assert(ze == re);
-	assert(ze <= SP_EMAX);
-
-	if (zs == rs) {
-		/*
-		 * Generate 28 bit result of adding two 27 bit numbers
-		 * leaving result in zm, zs and ze.
-		 */
-		zm = zm + rm;
-
-		if (zm >> (SP_FBITS + 1 + 3)) { /* carry out */
-			SPXSRSX1(); /* shift preserving sticky */
-		}
-	} else {
-		if (zm >= rm) {
-			zm = zm - rm;
-		} else {
-			zm = rm - zm;
-			zs = rs;
-		}
-		if (zm == 0)
-			return ieee754sp_zero(ieee754_csr.rm == FPU_CSR_RD);
-
-		/*
-		 * Normalize in extended single precision
-		 */
-		while ((zm >> (SP_MBITS + 3)) == 0) {
-			zm <<= 1;
-			ze--;
-		}
-
-	}
-	return ieee754sp_format(zs, ze, zm);
-}
-- 
2.8.0
