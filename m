Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Aug 2015 10:00:08 +0200 (CEST)
Received: (from localhost user: 'mchandras' uid#10145 fake: STDIN
        (mchandras@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S27012027AbbHMH6r3Avb4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 Aug 2015 09:58:47 +0200
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
Cc:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 06/10] MIPS: math-emu: Add support for the MIPS R6 MSUBF FPU instruction
Date:   Thu, 13 Aug 2015 09:56:32 +0200
Message-Id: <1439452596-16759-7-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.4.3
In-Reply-To: <1439452596-16759-1-git-send-email-markos.chandras@imgtec.com>
References: <1439452596-16759-1-git-send-email-markos.chandras@imgtec.com>
Return-Path: <mchandras@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48837
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
Floating Point Fused Multiply Subtract:
MSUBF.fmt To perform a fused multiply-subtract of FP values.

MSUBF.fmt: FPR[fd] = FPR[fd] - (FPR[fs] x FPR[ft])

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/math-emu/Makefile   |   4 +-
 arch/mips/math-emu/cp1emu.c   |  26 ++++
 arch/mips/math-emu/dp_msubf.c | 269 ++++++++++++++++++++++++++++++++++++++++++
 arch/mips/math-emu/ieee754.h  |   4 +
 arch/mips/math-emu/sp_msubf.c | 258 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 559 insertions(+), 2 deletions(-)
 create mode 100644 arch/mips/math-emu/dp_msubf.c
 create mode 100644 arch/mips/math-emu/sp_msubf.c

diff --git a/arch/mips/math-emu/Makefile b/arch/mips/math-emu/Makefile
index c40816f86a7a..0037690521ee 100644
--- a/arch/mips/math-emu/Makefile
+++ b/arch/mips/math-emu/Makefile
@@ -4,9 +4,9 @@
 
 obj-y	+= cp1emu.o ieee754dp.o ieee754sp.o ieee754.o \
 	   dp_div.o dp_mul.o dp_sub.o dp_add.o dp_fsp.o dp_cmp.o dp_simple.o \
-	   dp_tint.o dp_fint.o dp_maddf.o \
+	   dp_tint.o dp_fint.o dp_maddf.o dp_msubf.o \
 	   sp_div.o sp_mul.o sp_sub.o sp_add.o sp_fdp.o sp_cmp.o sp_simple.o \
-	   sp_tint.o sp_fint.o sp_maddf.o \
+	   sp_tint.o sp_fint.o sp_maddf.o sp_msubf.o \
 	   dsemul.o
 
 lib-y	+= ieee754d.o \
diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 68646fa563d8..69da5a89e72c 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -1760,6 +1760,19 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			break;
 		}
 
+		case fmsubf_op: {
+			union ieee754sp ft, fs, fd;
+
+			if (!cpu_has_mips_r6)
+				return SIGILL;
+
+			SPFROMREG(ft, MIPSInst_FT(ir));
+			SPFROMREG(fs, MIPSInst_FS(ir));
+			SPFROMREG(fd, MIPSInst_FD(ir));
+			rv.s = ieee754sp_msubf(fd, fs, ft);
+			break;
+		}
+
 		case fabs_op:
 			handler.u = ieee754sp_abs;
 			goto scopuop;
@@ -1993,6 +2006,19 @@ copcsr:
 			break;
 		}
 
+		case fmsubf_op: {
+			union ieee754dp ft, fs, fd;
+
+			if (!cpu_has_mips_r6)
+				return SIGILL;
+
+			DPFROMREG(ft, MIPSInst_FT(ir));
+			DPFROMREG(fs, MIPSInst_FS(ir));
+			DPFROMREG(fd, MIPSInst_FD(ir));
+			rv.d = ieee754dp_msubf(fd, fs, ft);
+			break;
+		}
+
 		case fabs_op:
 			handler.u = ieee754dp_abs;
 			goto dcopuop;
diff --git a/arch/mips/math-emu/dp_msubf.c b/arch/mips/math-emu/dp_msubf.c
new file mode 100644
index 000000000000..12241262f856
--- /dev/null
+++ b/arch/mips/math-emu/dp_msubf.c
@@ -0,0 +1,269 @@
+/*
+ * IEEE754 floating point arithmetic
+ * double precision: MSUB.f (Fused Multiply Subtract)
+ * MSUBF.fmt: FPR[fd] = FPR[fd] - (FPR[fs] x FPR[ft])
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
+union ieee754dp ieee754dp_msubf(union ieee754dp z, union ieee754dp x,
+				union ieee754dp y)
+{
+	int re;
+	int rs;
+	u64 rm;
+	unsigned lxm;
+	unsigned hxm;
+	unsigned lym;
+	unsigned hym;
+	u64 lrm;
+	u64 hrm;
+	u64 t;
+	u64 at;
+	int s;
+
+	COMPXDP;
+	COMPYDP;
+
+	u64 zm; int ze; int zs __maybe_unused; int zc;
+
+	EXPLODEXDP;
+	EXPLODEYDP;
+	EXPLODEDP(z, zc, zs, ze, zm)
+
+	FLUSHXDP;
+	FLUSHYDP;
+	FLUSHDP(z, zc, zs, ze, zm);
+
+	ieee754_clearcx();
+
+	switch (zc) {
+	case IEEE754_CLASS_SNAN:
+		ieee754_setcx(IEEE754_INVALID_OPERATION);
+		return ieee754dp_nanxcpt(z);
+	case IEEE754_CLASS_DNORM:
+		DPDNORMx(zm, ze);
+	/* QNAN is handled separately below */
+	}
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
+	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_QNAN):
+	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_QNAN):
+	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_QNAN):
+	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_QNAN):
+		return y;
+
+	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
+	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_ZERO):
+	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_NORM):
+	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_DNORM):
+	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_INF):
+		return x;
+
+
+	/*
+	 * Infinity handling
+	 */
+	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_ZERO):
+	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_INF):
+		if (zc == IEEE754_CLASS_QNAN)
+			return z;
+		ieee754_setcx(IEEE754_INVALID_OPERATION);
+		return ieee754dp_indef();
+
+	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_INF):
+	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_INF):
+	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_NORM):
+	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
+	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
+		if (zc == IEEE754_CLASS_QNAN)
+			return z;
+		return ieee754dp_inf(xs ^ ys);
+
+	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_ZERO):
+	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_NORM):
+	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_DNORM):
+	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_ZERO):
+	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_ZERO):
+		if (zc == IEEE754_CLASS_INF)
+			return ieee754dp_inf(zs);
+		/* Multiplication is 0 so just return z */
+		return z;
+
+	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_DNORM):
+		DPDNORMX;
+
+	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_DNORM):
+		if (zc == IEEE754_CLASS_QNAN)
+			return z;
+		else if (zc == IEEE754_CLASS_INF)
+			return ieee754dp_inf(zs);
+		DPDNORMY;
+		break;
+
+	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_NORM):
+		if (zc == IEEE754_CLASS_QNAN)
+			return z;
+		else if (zc == IEEE754_CLASS_INF)
+			return ieee754dp_inf(zs);
+		DPDNORMX;
+		break;
+
+	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_NORM):
+		if (zc == IEEE754_CLASS_QNAN)
+			return z;
+		else if (zc == IEEE754_CLASS_INF)
+			return ieee754dp_inf(zs);
+		/* fall through to real computations */
+	}
+
+	/* Finally get to do some computation */
+
+	/*
+	 * Do the multiplication bit first
+	 *
+	 * rm = xm * ym, re = xe + ye basically
+	 *
+	 * At this point xm and ym should have been normalized.
+	 */
+	assert(xm & DP_HIDDEN_BIT);
+	assert(ym & DP_HIDDEN_BIT);
+
+	re = xe + ye;
+	rs = xs ^ ys;
+
+	/* shunt to top of word */
+	xm <<= 64 - (DP_FBITS + 1);
+	ym <<= 64 - (DP_FBITS + 1);
+
+	/*
+	 * Multiply 32 bits xm, ym to give high 32 bits rm with stickness.
+	 */
+
+	/* 32 * 32 => 64 */
+#define DPXMULT(x, y)	((u64)(x) * (u64)y)
+
+	lxm = xm;
+	hxm = xm >> 32;
+	lym = ym;
+	hym = ym >> 32;
+
+	lrm = DPXMULT(lxm, lym);
+	hrm = DPXMULT(hxm, hym);
+
+	t = DPXMULT(lxm, hym);
+
+	at = lrm + (t << 32);
+	hrm += at < lrm;
+	lrm = at;
+
+	hrm = hrm + (t >> 32);
+
+	t = DPXMULT(hxm, lym);
+
+	at = lrm + (t << 32);
+	hrm += at < lrm;
+	lrm = at;
+
+	hrm = hrm + (t >> 32);
+
+	rm = hrm | (lrm != 0);
+
+	/*
+	 * Sticky shift down to normal rounding precision.
+	 */
+	if ((s64) rm < 0) {
+		rm = (rm >> (64 - (DP_FBITS + 1 + 3))) |
+		     ((rm << (DP_FBITS + 1 + 3)) != 0);
+			re++;
+	} else {
+		rm = (rm >> (64 - (DP_FBITS + 1 + 3 + 1))) |
+		     ((rm << (DP_FBITS + 1 + 3 + 1)) != 0);
+	}
+	assert(rm & (DP_HIDDEN_BIT << 3));
+
+	/* And now the subtraction */
+
+	/* flip sign of r and handle as add */
+	rs ^= 1;
+
+	assert(zm & DP_HIDDEN_BIT);
+
+	/*
+	 * Provide guard,round and stick bit space.
+	 */
+	zm <<= 3;
+
+	if (ze > re) {
+		/*
+		 * Have to shift y fraction right to align.
+		 */
+		s = ze - re;
+		rm = XDPSRS(rm, s);
+		re += s;
+	} else if (re > ze) {
+		/*
+		 * Have to shift x fraction right to align.
+		 */
+		s = re - ze;
+		zm = XDPSRS(zm, s);
+		ze += s;
+	}
+	assert(ze == re);
+	assert(ze <= DP_EMAX);
+
+	if (zs == rs) {
+		/*
+		 * Generate 28 bit result of adding two 27 bit numbers
+		 * leaving result in xm, xs and xe.
+		 */
+		zm = zm + rm;
+
+		if (zm >> (DP_FBITS + 1 + 3)) { /* carry out */
+			zm = XDPSRS1(zm);
+			ze++;
+		}
+	} else {
+		if (zm >= rm) {
+			zm = zm - rm;
+		} else {
+			zm = rm - zm;
+			zs = rs;
+		}
+		if (zm == 0)
+			return ieee754dp_zero(ieee754_csr.rm == FPU_CSR_RD);
+
+		/*
+		 * Normalize to rounding precision.
+		 */
+		while ((zm >> (DP_FBITS + 3)) == 0) {
+			zm <<= 1;
+			ze--;
+		}
+	}
+
+	return ieee754dp_format(zs, ze, zm);
+}
diff --git a/arch/mips/math-emu/ieee754.h b/arch/mips/math-emu/ieee754.h
index 4e025f9e220c..8c780190a059 100644
--- a/arch/mips/math-emu/ieee754.h
+++ b/arch/mips/math-emu/ieee754.h
@@ -77,6 +77,8 @@ union ieee754sp ieee754sp_sqrt(union ieee754sp x);
 
 union ieee754sp ieee754sp_maddf(union ieee754sp z, union ieee754sp x,
 				union ieee754sp y);
+union ieee754sp ieee754sp_msubf(union ieee754sp z, union ieee754sp x,
+				union ieee754sp y);
 
 /*
  * double precision (often aka double)
@@ -104,6 +106,8 @@ union ieee754dp ieee754dp_sqrt(union ieee754dp x);
 
 union ieee754dp ieee754dp_maddf(union ieee754dp z, union ieee754dp x,
 				union ieee754dp y);
+union ieee754dp ieee754dp_msubf(union ieee754dp z, union ieee754dp x,
+				union ieee754dp y);
 
 
 /* 5 types of floating point number
diff --git a/arch/mips/math-emu/sp_msubf.c b/arch/mips/math-emu/sp_msubf.c
new file mode 100644
index 000000000000..81c38b980d69
--- /dev/null
+++ b/arch/mips/math-emu/sp_msubf.c
@@ -0,0 +1,258 @@
+/*
+ * IEEE754 floating point arithmetic
+ * single precision: MSUB.f (Fused Multiply Subtract)
+ * MSUBF.fmt: FPR[fd] = FPR[fd] - (FPR[fs] x FPR[ft])
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
+union ieee754sp ieee754sp_msubf(union ieee754sp z, union ieee754sp x,
+				union ieee754sp y)
+{
+	int re;
+	int rs;
+	unsigned rm;
+	unsigned short lxm;
+	unsigned short hxm;
+	unsigned short lym;
+	unsigned short hym;
+	unsigned lrm;
+	unsigned hrm;
+	unsigned t;
+	unsigned at;
+	int s;
+
+	COMPXSP;
+	COMPYSP;
+	u32 zm; int ze; int zs __maybe_unused; int zc;
+
+	EXPLODEXSP;
+	EXPLODEYSP;
+	EXPLODESP(z, zc, zs, ze, zm)
+
+	FLUSHXSP;
+	FLUSHYSP;
+	FLUSHSP(z, zc, zs, ze, zm);
+
+	ieee754_clearcx();
+
+	switch (zc) {
+	case IEEE754_CLASS_SNAN:
+		ieee754_setcx(IEEE754_INVALID_OPERATION);
+		return ieee754sp_nanxcpt(z);
+	case IEEE754_CLASS_DNORM:
+		SPDNORMx(zm, ze);
+	/* QNAN is handled separately below */
+	}
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
+	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_QNAN):
+	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_QNAN):
+	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_QNAN):
+	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_QNAN):
+		return y;
+
+	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
+	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_ZERO):
+	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_NORM):
+	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_DNORM):
+	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_INF):
+		return x;
+
+	/*
+	 * Infinity handling
+	 */
+	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_ZERO):
+	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_INF):
+		if (zc == IEEE754_CLASS_QNAN)
+			return z;
+		ieee754_setcx(IEEE754_INVALID_OPERATION);
+		return ieee754sp_indef();
+
+	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_INF):
+	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_INF):
+	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_NORM):
+	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
+	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
+		if (zc == IEEE754_CLASS_QNAN)
+			return z;
+		return ieee754sp_inf(xs ^ ys);
+
+	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_ZERO):
+	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_NORM):
+	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_DNORM):
+	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_ZERO):
+	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_ZERO):
+		if (zc == IEEE754_CLASS_INF)
+			return ieee754sp_inf(zs);
+		/* Multiplication is 0 so just return z */
+		return z;
+
+	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_DNORM):
+		SPDNORMX;
+
+	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_DNORM):
+		if (zc == IEEE754_CLASS_QNAN)
+			return z;
+		else if (zc == IEEE754_CLASS_INF)
+			return ieee754sp_inf(zs);
+		SPDNORMY;
+		break;
+
+	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_NORM):
+		if (zc == IEEE754_CLASS_QNAN)
+			return z;
+		else if (zc == IEEE754_CLASS_INF)
+			return ieee754sp_inf(zs);
+		SPDNORMX;
+		break;
+
+	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_NORM):
+		if (zc == IEEE754_CLASS_QNAN)
+			return z;
+		else if (zc == IEEE754_CLASS_INF)
+			return ieee754sp_inf(zs);
+		/* fall through to real compuation */
+	}
+
+	/* Finally get to do some computation */
+
+	/*
+	 * Do the multiplication bit first
+	 *
+	 * rm = xm * ym, re = xe + ye basically
+	 *
+	 * At this point xm and ym should have been normalized.
+	 */
+
+	/* rm = xm * ym, re = xe+ye basically */
+	assert(xm & SP_HIDDEN_BIT);
+	assert(ym & SP_HIDDEN_BIT);
+
+	re = xe + ye;
+	rs = xs ^ ys;
+
+	/* shunt to top of word */
+	xm <<= 32 - (SP_FBITS + 1);
+	ym <<= 32 - (SP_FBITS + 1);
+
+	/*
+	 * Multiply 32 bits xm, ym to give high 32 bits rm with stickness.
+	 */
+	lxm = xm & 0xffff;
+	hxm = xm >> 16;
+	lym = ym & 0xffff;
+	hym = ym >> 16;
+
+	lrm = lxm * lym;	/* 16 * 16 => 32 */
+	hrm = hxm * hym;	/* 16 * 16 => 32 */
+
+	t = lxm * hym; /* 16 * 16 => 32 */
+	at = lrm + (t << 16);
+	hrm += at < lrm;
+	lrm = at;
+	hrm = hrm + (t >> 16);
+
+	t = hxm * lym; /* 16 * 16 => 32 */
+	at = lrm + (t << 16);
+	hrm += at < lrm;
+	lrm = at;
+	hrm = hrm + (t >> 16);
+
+	rm = hrm | (lrm != 0);
+
+	/*
+	 * Sticky shift down to normal rounding precision.
+	 */
+	if ((int) rm < 0) {
+		rm = (rm >> (32 - (SP_FBITS + 1 + 3))) |
+		    ((rm << (SP_FBITS + 1 + 3)) != 0);
+		re++;
+	} else {
+		rm = (rm >> (32 - (SP_FBITS + 1 + 3 + 1))) |
+		     ((rm << (SP_FBITS + 1 + 3 + 1)) != 0);
+	}
+	assert(rm & (SP_HIDDEN_BIT << 3));
+
+	/* And now the subtraction */
+
+	/* Flip sign of r and handle as add */
+	rs ^= 1;
+
+	assert(zm & SP_HIDDEN_BIT);
+
+	/*
+	 * Provide guard,round and stick bit space.
+	 */
+	zm <<= 3;
+
+	if (ze > re) {
+		/*
+		 * Have to shift y fraction right to align.
+		 */
+		s = ze - re;
+		SPXSRSYn(s);
+	} else if (re > ze) {
+		/*
+		 * Have to shift x fraction right to align.
+		 */
+		s = re - ze;
+		SPXSRSYn(s);
+	}
+	assert(ze == re);
+	assert(ze <= SP_EMAX);
+
+	if (zs == rs) {
+		/*
+		 * Generate 28 bit result of adding two 27 bit numbers
+		 * leaving result in zm, zs and ze.
+		 */
+		zm = zm + rm;
+
+		if (zm >> (SP_FBITS + 1 + 3)) { /* carry out */
+			SPXSRSX1(); /* shift preserving sticky */
+		}
+	} else {
+		if (zm >= rm) {
+			zm = zm - rm;
+		} else {
+			zm = rm - zm;
+			zs = rs;
+		}
+		if (zm == 0)
+			return ieee754sp_zero(ieee754_csr.rm == FPU_CSR_RD);
+
+		/*
+		 * Normalize in extended single precision
+		 */
+		while ((zm >> (SP_MBITS + 3)) == 0) {
+			zm <<= 1;
+			ze--;
+		}
+
+	}
+	return ieee754sp_format(zs, ze, zm);
+}
-- 
2.5.0
