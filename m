Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Aug 2015 10:01:06 +0200 (CEST)
Received: (from localhost user: 'mchandras' uid#10145 fake: STDIN
        (mchandras@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S27012166AbbHMH7CFDS94 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 Aug 2015 09:59:02 +0200
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
Cc:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 09/10] MIPS: math-emu: Add support for the MIPS R6 MIN{,A} FPU instruction
Date:   Thu, 13 Aug 2015 09:56:35 +0200
Message-Id: <1439452596-16759-10-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.4.3
In-Reply-To: <1439452596-16759-1-git-send-email-markos.chandras@imgtec.com>
References: <1439452596-16759-1-git-send-email-markos.chandras@imgtec.com>
Return-Path: <mchandras@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48840
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

MIPS R6 introduced the following instruction:
Scalar Floating-Point Minimum and
Scalar Floating-Point argument with Minimum Absolute Value

MIN.fmt writes the minimum value of the inputs fs and ft to the
destination fd.
MINA.fmt takes input arguments fs and ft and writes the argument with
the minimum absolute value to the destination fd.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/math-emu/Makefile  |   4 +-
 arch/mips/math-emu/cp1emu.c  |  48 ++++++++++
 arch/mips/math-emu/dp_fmin.c | 213 +++++++++++++++++++++++++++++++++++++++++++
 arch/mips/math-emu/ieee754.h |   4 +
 arch/mips/math-emu/sp_fmin.c | 213 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 480 insertions(+), 2 deletions(-)
 create mode 100644 arch/mips/math-emu/dp_fmin.c
 create mode 100644 arch/mips/math-emu/sp_fmin.c

diff --git a/arch/mips/math-emu/Makefile b/arch/mips/math-emu/Makefile
index ea8db2607d07..b9946322804e 100644
--- a/arch/mips/math-emu/Makefile
+++ b/arch/mips/math-emu/Makefile
@@ -4,9 +4,9 @@
 
 obj-y	+= cp1emu.o ieee754dp.o ieee754sp.o ieee754.o \
 	   dp_div.o dp_mul.o dp_sub.o dp_add.o dp_fsp.o dp_cmp.o dp_simple.o \
-	   dp_tint.o dp_fint.o dp_maddf.o dp_msubf.o dp_2008class.o \
+	   dp_tint.o dp_fint.o dp_maddf.o dp_msubf.o dp_2008class.o dp_fmin.o \
 	   sp_div.o sp_mul.o sp_sub.o sp_add.o sp_fdp.o sp_cmp.o sp_simple.o \
-	   sp_tint.o sp_fint.o sp_maddf.o sp_msubf.o sp_2008class.o \
+	   sp_tint.o sp_fint.o sp_maddf.o sp_msubf.o sp_2008class.o sp_fmin.o \
 	   dsemul.o
 
 lib-y	+= ieee754d.o \
diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index cdebeb14a7d0..18532d284bdf 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -1797,6 +1797,30 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			break;
 		}
 
+		case fmin_op: {
+			union ieee754sp fs, ft;
+
+			if (!cpu_has_mips_r6)
+				return SIGILL;
+
+			SPFROMREG(ft, MIPSInst_FT(ir));
+			SPFROMREG(fs, MIPSInst_FS(ir));
+			rv.s = ieee754sp_fmin(fs, ft);
+			break;
+		}
+
+		case fmina_op: {
+			union ieee754sp fs, ft;
+
+			if (!cpu_has_mips_r6)
+				return SIGILL;
+
+			SPFROMREG(ft, MIPSInst_FT(ir));
+			SPFROMREG(fs, MIPSInst_FS(ir));
+			rv.s = ieee754sp_fmina(fs, ft);
+			break;
+		}
+
 		case fabs_op:
 			handler.u = ieee754sp_abs;
 			goto scopuop;
@@ -2067,6 +2091,30 @@ copcsr:
 			break;
 		}
 
+		case fmin_op: {
+			union ieee754dp fs, ft;
+
+			if (!cpu_has_mips_r6)
+				return SIGILL;
+
+			DPFROMREG(ft, MIPSInst_FT(ir));
+			DPFROMREG(fs, MIPSInst_FS(ir));
+			rv.d = ieee754dp_fmin(fs, ft);
+			break;
+		}
+
+		case fmina_op: {
+			union ieee754dp fs, ft;
+
+			if (!cpu_has_mips_r6)
+				return SIGILL;
+
+			DPFROMREG(ft, MIPSInst_FT(ir));
+			DPFROMREG(fs, MIPSInst_FS(ir));
+			rv.d = ieee754dp_fmina(fs, ft);
+			break;
+		}
+
 		case fabs_op:
 			handler.u = ieee754dp_abs;
 			goto dcopuop;
diff --git a/arch/mips/math-emu/dp_fmin.c b/arch/mips/math-emu/dp_fmin.c
new file mode 100644
index 000000000000..c1072b0dfb95
--- /dev/null
+++ b/arch/mips/math-emu/dp_fmin.c
@@ -0,0 +1,213 @@
+/*
+ * IEEE754 floating point arithmetic
+ * double precision: MIN{,A}.f
+ * MIN : Scalar Floating-Point Minimum
+ * MINA: Scalar Floating-Point argument with Minimum Absolute Value
+ *
+ * MIN.D : FPR[fd] = minNum(FPR[fs],FPR[ft])
+ * MINA.D: FPR[fd] = maxNumMag(FPR[fs],FPR[ft])
+ *
+ * MIPS floating point support
+ * Copyright (C) 2015 Imagination Technologies, Ltd.
+ * Author: Markos Chandras <markos.chandras@imgtec.com>
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; version 2 of the License.
+ */
+
+#include "ieee754dp.h"
+
+union ieee754dp ieee754dp_fmin(union ieee754dp x, union ieee754dp y)
+{
+	COMPXDP;
+	COMPYDP;
+
+	EXPLODEXDP;
+	EXPLODEYDP;
+
+	FLUSHXDP;
+	FLUSHYDP;
+
+	ieee754_clearcx();
+
+	switch (CLPAIR(xc, yc)) {
+	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_SNAN):
+	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_SNAN):
+	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_SNAN):
+	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_SNAN):
+	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_SNAN):
+		return ieee754dp_nanxcpt(y);
+
+	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_SNAN):
+	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_QNAN):
+	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_ZERO):
+	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_NORM):
+	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_DNORM):
+	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_INF):
+		return ieee754dp_nanxcpt(x);
+
+	/* numbers are preferred to NaNs */
+	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_QNAN):
+	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_QNAN):
+	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_QNAN):
+	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_QNAN):
+		return x;
+
+	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
+	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_ZERO):
+	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_NORM):
+	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_DNORM):
+	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_INF):
+		return y;
+
+	/*
+	 * Infinity and zero handling
+	 */
+	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_ZERO):
+	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_NORM):
+	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
+	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_ZERO):
+	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_ZERO):
+		return xs ? x : y;
+
+	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
+	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_INF):
+	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_INF):
+	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_INF):
+	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_NORM):
+	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_DNORM):
+		return ys ? y : x;
+
+	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_ZERO):
+		if (xs == ys)
+			return x;
+		return ieee754dp_zero(1);
+
+	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_DNORM):
+		DPDNORMX;
+
+	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_DNORM):
+		DPDNORMY;
+		break;
+
+	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_NORM):
+		DPDNORMX;
+	}
+
+	/* Finally get to do some computation */
+
+	assert(xm & DP_HIDDEN_BIT);
+	assert(ym & DP_HIDDEN_BIT);
+
+	/* Compare signs */
+	if (xs > ys)
+		return x;
+	else if (xs < ys)
+		return y;
+
+	/* Compare exponent */
+	if (xe > ye)
+		return y;
+	else if (xe < ye)
+		return x;
+
+	/* Compare mantissa */
+	if (xm <= ym)
+		return x;
+	return y;
+}
+
+union ieee754dp ieee754dp_fmina(union ieee754dp x, union ieee754dp y)
+{
+	COMPXDP;
+	COMPYDP;
+
+	EXPLODEXDP;
+	EXPLODEYDP;
+
+	FLUSHXDP;
+	FLUSHYDP;
+
+	ieee754_clearcx();
+
+	switch (CLPAIR(xc, yc)) {
+	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_SNAN):
+	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_SNAN):
+	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_SNAN):
+	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_SNAN):
+	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_SNAN):
+		return ieee754dp_nanxcpt(y);
+
+	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_SNAN):
+	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_QNAN):
+	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_ZERO):
+	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_NORM):
+	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_DNORM):
+	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_INF):
+		return ieee754dp_nanxcpt(x);
+
+	/* numbers are preferred to NaNs */
+	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_QNAN):
+	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_QNAN):
+	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_QNAN):
+	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_QNAN):
+		return x;
+
+	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
+	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_ZERO):
+	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_NORM):
+	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_DNORM):
+	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_INF):
+		return y;
+
+	/*
+	 * Infinity and zero handling
+	 */
+	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_ZERO):
+	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_NORM):
+	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
+	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_ZERO):
+	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_ZERO):
+		return x;
+
+	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
+	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_INF):
+	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_INF):
+	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_INF):
+	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_NORM):
+	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_DNORM):
+		return y;
+
+	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_ZERO):
+		if (xs == ys)
+			return x;
+		return ieee754dp_zero(1);
+
+	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_DNORM):
+		DPDNORMX;
+
+	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_DNORM):
+		DPDNORMY;
+		break;
+
+	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_NORM):
+		DPDNORMX;
+	}
+
+	/* Finally get to do some computation */
+
+	assert(xm & DP_HIDDEN_BIT);
+	assert(ym & DP_HIDDEN_BIT);
+
+	/* Compare exponent */
+	if (xe > ye)
+		return y;
+	else if (xe < ye)
+		return x;
+
+	/* Compare mantissa */
+	if (xm <= ym)
+		return x;
+	return y;
+}
diff --git a/arch/mips/math-emu/ieee754.h b/arch/mips/math-emu/ieee754.h
index 3b833eac48f5..6a16357a1ddd 100644
--- a/arch/mips/math-emu/ieee754.h
+++ b/arch/mips/math-emu/ieee754.h
@@ -80,6 +80,8 @@ union ieee754sp ieee754sp_maddf(union ieee754sp z, union ieee754sp x,
 union ieee754sp ieee754sp_msubf(union ieee754sp z, union ieee754sp x,
 				union ieee754sp y);
 int ieee754sp_2008class(union ieee754sp x);
+union ieee754sp ieee754sp_fmin(union ieee754sp x, union ieee754sp y);
+union ieee754sp ieee754sp_fmina(union ieee754sp x, union ieee754sp y);
 
 /*
  * double precision (often aka double)
@@ -110,6 +112,8 @@ union ieee754dp ieee754dp_maddf(union ieee754dp z, union ieee754dp x,
 union ieee754dp ieee754dp_msubf(union ieee754dp z, union ieee754dp x,
 				union ieee754dp y);
 int ieee754dp_2008class(union ieee754dp x);
+union ieee754dp ieee754dp_fmin(union ieee754dp x, union ieee754dp y);
+union ieee754dp ieee754dp_fmina(union ieee754dp x, union ieee754dp y);
 
 
 /* 5 types of floating point number
diff --git a/arch/mips/math-emu/sp_fmin.c b/arch/mips/math-emu/sp_fmin.c
new file mode 100644
index 000000000000..4eb1bb9e9dec
--- /dev/null
+++ b/arch/mips/math-emu/sp_fmin.c
@@ -0,0 +1,213 @@
+/*
+ * IEEE754 floating point arithmetic
+ * single precision: MIN{,A}.f
+ * MIN : Scalar Floating-Point Minimum
+ * MINA: Scalar Floating-Point argument with Minimum Absolute Value
+ *
+ * MIN.S : FPR[fd] = minNum(FPR[fs],FPR[ft])
+ * MINA.S: FPR[fd] = maxNumMag(FPR[fs],FPR[ft])
+ *
+ * MIPS floating point support
+ * Copyright (C) 2015 Imagination Technologies, Ltd.
+ * Author: Markos Chandras <markos.chandras@imgtec.com>
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; version 2 of the License.
+ */
+
+#include "ieee754sp.h"
+
+union ieee754sp ieee754sp_fmin(union ieee754sp x, union ieee754sp y)
+{
+	COMPXSP;
+	COMPYSP;
+
+	EXPLODEXSP;
+	EXPLODEYSP;
+
+	FLUSHXSP;
+	FLUSHYSP;
+
+	ieee754_clearcx();
+
+	switch (CLPAIR(xc, yc)) {
+	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_SNAN):
+	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_SNAN):
+	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_SNAN):
+	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_SNAN):
+	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_SNAN):
+		return ieee754sp_nanxcpt(y);
+
+	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_SNAN):
+	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_QNAN):
+	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_ZERO):
+	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_NORM):
+	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_DNORM):
+	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_INF):
+		return ieee754sp_nanxcpt(x);
+
+	/* numbers are preferred to NaNs */
+	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_QNAN):
+	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_QNAN):
+	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_QNAN):
+	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_QNAN):
+		return x;
+
+	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
+	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_ZERO):
+	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_NORM):
+	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_DNORM):
+	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_INF):
+		return y;
+
+	/*
+	 * Infinity and zero handling
+	 */
+	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_ZERO):
+	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_NORM):
+	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
+	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_ZERO):
+	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_ZERO):
+		return xs ? x : y;
+
+	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
+	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_INF):
+	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_INF):
+	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_INF):
+	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_NORM):
+	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_DNORM):
+		return ys ? y : x;
+
+	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_ZERO):
+		if (xs == ys)
+			return x;
+		return ieee754sp_zero(1);
+
+	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_DNORM):
+		SPDNORMX;
+
+	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_DNORM):
+		SPDNORMY;
+		break;
+
+	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_NORM):
+		SPDNORMX;
+	}
+
+	/* Finally get to do some computation */
+
+	assert(xm & SP_HIDDEN_BIT);
+	assert(ym & SP_HIDDEN_BIT);
+
+	/* Compare signs */
+	if (xs > ys)
+		return x;
+	else if (xs < ys)
+		return y;
+
+	/* Compare exponent */
+	if (xe > ye)
+		return y;
+	else if (xe < ye)
+		return x;
+
+	/* Compare mantissa */
+	if (xm <= ym)
+		return x;
+	return y;
+}
+
+union ieee754sp ieee754sp_fmina(union ieee754sp x, union ieee754sp y)
+{
+	COMPXSP;
+	COMPYSP;
+
+	EXPLODEXSP;
+	EXPLODEYSP;
+
+	FLUSHXSP;
+	FLUSHYSP;
+
+	ieee754_clearcx();
+
+	switch (CLPAIR(xc, yc)) {
+	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_SNAN):
+	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_SNAN):
+	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_SNAN):
+	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_SNAN):
+	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_SNAN):
+		return ieee754sp_nanxcpt(y);
+
+	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_SNAN):
+	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_QNAN):
+	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_ZERO):
+	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_NORM):
+	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_DNORM):
+	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_INF):
+		return ieee754sp_nanxcpt(x);
+
+	/* numbers are preferred to NaNs */
+	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_QNAN):
+	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_QNAN):
+	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_QNAN):
+	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_QNAN):
+		return x;
+
+	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
+	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_ZERO):
+	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_NORM):
+	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_DNORM):
+	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_INF):
+		return y;
+
+	/*
+	 * Infinity and zero handling
+	 */
+	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_ZERO):
+	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_NORM):
+	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
+	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_ZERO):
+	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_ZERO):
+		return x;
+
+	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
+	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_INF):
+	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_INF):
+	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_INF):
+	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_NORM):
+	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_DNORM):
+		return y;
+
+	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_ZERO):
+		if (xs == ys)
+			return x;
+		return ieee754sp_zero(1);
+
+	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_DNORM):
+		SPDNORMX;
+
+	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_DNORM):
+		SPDNORMY;
+		break;
+
+	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_NORM):
+		SPDNORMX;
+	}
+
+	/* Finally get to do some computation */
+
+	assert(xm & SP_HIDDEN_BIT);
+	assert(ym & SP_HIDDEN_BIT);
+
+	/* Compare exponent */
+	if (xe > ye)
+		return y;
+	else if (xe < ye)
+		return x;
+
+	/* Compare mantissa */
+	if (xm <= ym)
+		return x;
+	return y;
+}
-- 
2.5.0
