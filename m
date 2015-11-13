Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Nov 2015 01:48:04 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:18910 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010674AbbKMArghBYnl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Nov 2015 01:47:36 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 6DEA8DBEB8E96;
        Fri, 13 Nov 2015 00:47:25 +0000 (GMT)
Received: from [10.100.200.62] (10.100.200.62) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server id 14.3.235.1; Fri, 13 Nov 2015
 00:47:29 +0000
Date:   Fri, 13 Nov 2015 00:47:28 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/8] MIPS: math-emu: Add IEEE Std 754-2008 NaN encoding
 emulation
In-Reply-To: <alpine.DEB.2.00.1511111418430.7097@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1511130006100.7097@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1511111418430.7097@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.62]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49913
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

Implement IEEE Std 754-2008 NaN encoding wired to the state of the 
FCSR.NAN2008 bit.  Make the interpretation of the quiet bit in NaN data 
as follows:

* in the legacy mode originally defined by the MIPS architecture the 
  value of 1 denotes an sNaN whereas the value of 0 denotes a qNaN,

* in the 2008 mode introduced with revision 5 of the MIPS architecture 
  the value of 0 denotes an sNaN whereas the value of 1 denotes a qNaN, 
  following the definition of the preferred NaN encoding introduced with 
  IEEE Std 754-2008.

In the 2008 mode, following the requirement of the said standard, quiet 
an sNaN where needed by setting the quiet bit to 1 and leaving all the 
NaN payload bits unchanged.

Update format conversion operations according to the rules set by IEEE 
Std 754-2008 and the MIPS architecture.  Specifically:

* propagate NaN payload bits through conversions between floating-point 
  formats such that as much information as possible is preserved and 
  specifically a conversion from a narrower format to a wider format and 
  then back to the original format does not change a qNaN payload in any 
  way,

* conversions from a floating-point to an integer format where the 
  source is a NaN, infinity or a value that would convert to an integer 
  outside the range of the result format produce, under the default 
  exception handling, the respective values defined by the MIPS 
  architecture.

In full FPU emulation set the FIR.HAS2008 bit to 1, however do not make 
any further FCSR bits writable.

Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
---
linux-mips-emu-nan2008.diff
Index: linux-sfr-test/arch/mips/kernel/cpu-probe.c
===================================================================
--- linux-sfr-test.orig/arch/mips/kernel/cpu-probe.c	2015-09-04 21:34:10.000000000 +0100
+++ linux-sfr-test/arch/mips/kernel/cpu-probe.c	2015-09-04 21:35:56.582838000 +0100
@@ -113,6 +113,8 @@ static void cpu_set_nofpu_id(struct cpui
 	if (c->isa_level & (MIPS_CPU_ISA_M32R2 | MIPS_CPU_ISA_M64R2 |
 			    MIPS_CPU_ISA_M32R6 | MIPS_CPU_ISA_M64R6))
 		value |= MIPS_FPIR_F64 | MIPS_FPIR_L | MIPS_FPIR_W;
+	if (c->options & MIPS_CPU_NAN_2008)
+		value |= MIPS_FPIR_HAS2008;
 	c->fpu_id = value;
 }
 
Index: linux-sfr-test/arch/mips/math-emu/dp_tint.c
===================================================================
--- linux-sfr-test.orig/arch/mips/math-emu/dp_tint.c	2015-04-08 16:56:50.000000000 +0100
+++ linux-sfr-test/arch/mips/math-emu/dp_tint.c	2015-09-04 21:35:56.587767000 +0100
@@ -38,10 +38,13 @@ int ieee754dp_tint(union ieee754dp x)
 	switch (xc) {
 	case IEEE754_CLASS_SNAN:
 	case IEEE754_CLASS_QNAN:
-	case IEEE754_CLASS_INF:
 		ieee754_setcx(IEEE754_INVALID_OPERATION);
 		return ieee754si_indef();
 
+	case IEEE754_CLASS_INF:
+		ieee754_setcx(IEEE754_INVALID_OPERATION);
+		return ieee754si_overflow(xs);
+
 	case IEEE754_CLASS_ZERO:
 		return 0;
 
@@ -53,7 +56,7 @@ int ieee754dp_tint(union ieee754dp x)
 		/* Set invalid. We will only use overflow for floating
 		   point overflow */
 		ieee754_setcx(IEEE754_INVALID_OPERATION);
-		return ieee754si_indef();
+		return ieee754si_overflow(xs);
 	}
 	/* oh gawd */
 	if (xe > DP_FBITS) {
@@ -93,7 +96,7 @@ int ieee754dp_tint(union ieee754dp x)
 		if ((xm >> 31) != 0 && (xs == 0 || xm != 0x80000000)) {
 			/* This can happen after rounding */
 			ieee754_setcx(IEEE754_INVALID_OPERATION);
-			return ieee754si_indef();
+			return ieee754si_overflow(xs);
 		}
 		if (round || sticky)
 			ieee754_setcx(IEEE754_INEXACT);
Index: linux-sfr-test/arch/mips/math-emu/dp_tlong.c
===================================================================
--- linux-sfr-test.orig/arch/mips/math-emu/dp_tlong.c	2015-04-08 16:56:50.000000000 +0100
+++ linux-sfr-test/arch/mips/math-emu/dp_tlong.c	2015-09-04 21:35:56.589811000 +0100
@@ -38,10 +38,13 @@ s64 ieee754dp_tlong(union ieee754dp x)
 	switch (xc) {
 	case IEEE754_CLASS_SNAN:
 	case IEEE754_CLASS_QNAN:
-	case IEEE754_CLASS_INF:
 		ieee754_setcx(IEEE754_INVALID_OPERATION);
 		return ieee754di_indef();
 
+	case IEEE754_CLASS_INF:
+		ieee754_setcx(IEEE754_INVALID_OPERATION);
+		return ieee754di_overflow(xs);
+
 	case IEEE754_CLASS_ZERO:
 		return 0;
 
@@ -56,7 +59,7 @@ s64 ieee754dp_tlong(union ieee754dp x)
 		/* Set invalid. We will only use overflow for floating
 		   point overflow */
 		ieee754_setcx(IEEE754_INVALID_OPERATION);
-		return ieee754di_indef();
+		return ieee754di_overflow(xs);
 	}
 	/* oh gawd */
 	if (xe > DP_FBITS) {
@@ -97,7 +100,7 @@ s64 ieee754dp_tlong(union ieee754dp x)
 		if ((xm >> 63) != 0) {
 			/* This can happen after rounding */
 			ieee754_setcx(IEEE754_INVALID_OPERATION);
-			return ieee754di_indef();
+			return ieee754di_overflow(xs);
 		}
 		if (round || sticky)
 			ieee754_setcx(IEEE754_INEXACT);
Index: linux-sfr-test/arch/mips/math-emu/ieee754.c
===================================================================
--- linux-sfr-test.orig/arch/mips/math-emu/ieee754.c	2015-04-08 16:56:50.000000000 +0100
+++ linux-sfr-test/arch/mips/math-emu/ieee754.c	2015-09-04 21:35:56.592775000 +0100
@@ -59,7 +59,8 @@ const union ieee754dp __ieee754dp_spcval
 	DPCNST(1, 3,           0x4000000000000ULL),	/* - 10.0   */
 	DPCNST(0, DP_EMAX + 1, 0x0000000000000ULL),	/* + infinity */
 	DPCNST(1, DP_EMAX + 1, 0x0000000000000ULL),	/* - infinity */
-	DPCNST(0, DP_EMAX + 1, 0x7FFFFFFFFFFFFULL),	/* + indef quiet Nan */
+	DPCNST(0, DP_EMAX + 1, 0x7FFFFFFFFFFFFULL),	/* + ind legacy qNaN */
+	DPCNST(0, DP_EMAX + 1, 0x8000000000000ULL),	/* + indef 2008 qNaN */
 	DPCNST(0, DP_EMAX,     0xFFFFFFFFFFFFFULL),	/* + max */
 	DPCNST(1, DP_EMAX,     0xFFFFFFFFFFFFFULL),	/* - max */
 	DPCNST(0, DP_EMIN,     0x0000000000000ULL),	/* + min normal */
@@ -82,7 +83,8 @@ const union ieee754sp __ieee754sp_spcval
 	SPCNST(1, 3,	       0x200000),	/* - 10.0   */
 	SPCNST(0, SP_EMAX + 1, 0x000000),	/* + infinity */
 	SPCNST(1, SP_EMAX + 1, 0x000000),	/* - infinity */
-	SPCNST(0, SP_EMAX + 1, 0x3FFFFF),	/* + indef quiet Nan  */
+	SPCNST(0, SP_EMAX + 1, 0x3FFFFF),	/* + indef legacy quiet NaN */
+	SPCNST(0, SP_EMAX + 1, 0x400000),	/* + indef 2008 quiet NaN */
 	SPCNST(0, SP_EMAX,     0x7FFFFF),	/* + max normal */
 	SPCNST(1, SP_EMAX,     0x7FFFFF),	/* - max normal */
 	SPCNST(0, SP_EMIN,     0x000000),	/* + min normal */
Index: linux-sfr-test/arch/mips/math-emu/ieee754.h
===================================================================
--- linux-sfr-test.orig/arch/mips/math-emu/ieee754.h	2015-09-04 19:19:07.000000000 +0100
+++ linux-sfr-test/arch/mips/math-emu/ieee754.h	2015-09-04 21:35:56.594791000 +0100
@@ -221,15 +221,16 @@ union ieee754dp ieee754dp_dump(char *s, 
 #define IEEE754_SPCVAL_NTEN		5	/* -10.0 */
 #define IEEE754_SPCVAL_PINFINITY	6	/* +inf */
 #define IEEE754_SPCVAL_NINFINITY	7	/* -inf */
-#define IEEE754_SPCVAL_INDEF		8	/* quiet NaN */
-#define IEEE754_SPCVAL_PMAX		9	/* +max norm */
-#define IEEE754_SPCVAL_NMAX		10	/* -max norm */
-#define IEEE754_SPCVAL_PMIN		11	/* +min norm */
-#define IEEE754_SPCVAL_NMIN		12	/* -min norm */
-#define IEEE754_SPCVAL_PMIND		13	/* +min denorm */
-#define IEEE754_SPCVAL_NMIND		14	/* -min denorm */
-#define IEEE754_SPCVAL_P1E31		15	/* + 1.0e31 */
-#define IEEE754_SPCVAL_P1E63		16	/* + 1.0e63 */
+#define IEEE754_SPCVAL_INDEF_LEG	8	/* legacy quiet NaN */
+#define IEEE754_SPCVAL_INDEF_2008	9	/* IEEE 754-2008 quiet NaN */
+#define IEEE754_SPCVAL_PMAX		10	/* +max norm */
+#define IEEE754_SPCVAL_NMAX		11	/* -max norm */
+#define IEEE754_SPCVAL_PMIN		12	/* +min norm */
+#define IEEE754_SPCVAL_NMIN		13	/* -min norm */
+#define IEEE754_SPCVAL_PMIND		14	/* +min denorm */
+#define IEEE754_SPCVAL_NMIND		15	/* -min denorm */
+#define IEEE754_SPCVAL_P1E31		16	/* + 1.0e31 */
+#define IEEE754_SPCVAL_P1E63		17	/* + 1.0e63 */
 
 extern const union ieee754dp __ieee754dp_spcvals[];
 extern const union ieee754sp __ieee754sp_spcvals[];
@@ -243,7 +244,8 @@ extern const union ieee754sp __ieee754sp
 #define ieee754dp_zero(sn)	(ieee754dp_spcvals[IEEE754_SPCVAL_PZERO+(sn)])
 #define ieee754dp_one(sn)	(ieee754dp_spcvals[IEEE754_SPCVAL_PONE+(sn)])
 #define ieee754dp_ten(sn)	(ieee754dp_spcvals[IEEE754_SPCVAL_PTEN+(sn)])
-#define ieee754dp_indef()	(ieee754dp_spcvals[IEEE754_SPCVAL_INDEF])
+#define ieee754dp_indef()	(ieee754dp_spcvals[IEEE754_SPCVAL_INDEF_LEG + \
+						   ieee754_csr.nan2008])
 #define ieee754dp_max(sn)	(ieee754dp_spcvals[IEEE754_SPCVAL_PMAX+(sn)])
 #define ieee754dp_min(sn)	(ieee754dp_spcvals[IEEE754_SPCVAL_PMIN+(sn)])
 #define ieee754dp_mind(sn)	(ieee754dp_spcvals[IEEE754_SPCVAL_PMIND+(sn)])
@@ -254,7 +256,8 @@ extern const union ieee754sp __ieee754sp
 #define ieee754sp_zero(sn)	(ieee754sp_spcvals[IEEE754_SPCVAL_PZERO+(sn)])
 #define ieee754sp_one(sn)	(ieee754sp_spcvals[IEEE754_SPCVAL_PONE+(sn)])
 #define ieee754sp_ten(sn)	(ieee754sp_spcvals[IEEE754_SPCVAL_PTEN+(sn)])
-#define ieee754sp_indef()	(ieee754sp_spcvals[IEEE754_SPCVAL_INDEF])
+#define ieee754sp_indef()	(ieee754sp_spcvals[IEEE754_SPCVAL_INDEF_LEG + \
+						   ieee754_csr.nan2008])
 #define ieee754sp_max(sn)	(ieee754sp_spcvals[IEEE754_SPCVAL_PMAX+(sn)])
 #define ieee754sp_min(sn)	(ieee754sp_spcvals[IEEE754_SPCVAL_PMIN+(sn)])
 #define ieee754sp_mind(sn)	(ieee754sp_spcvals[IEEE754_SPCVAL_PMIND+(sn)])
@@ -266,12 +269,25 @@ extern const union ieee754sp __ieee754sp
  */
 static inline int ieee754si_indef(void)
 {
-	return INT_MAX;
+	return ieee754_csr.nan2008 ? 0 : INT_MAX;
 }
 
 static inline s64 ieee754di_indef(void)
 {
-	return S64_MAX;
+	return ieee754_csr.nan2008 ? 0 : S64_MAX;
+}
+
+/*
+ * Overflow integer value
+ */
+static inline int ieee754si_overflow(int xs)
+{
+	return ieee754_csr.nan2008 && xs ? INT_MIN : INT_MAX;
+}
+
+static inline s64 ieee754di_overflow(int xs)
+{
+	return ieee754_csr.nan2008 && xs ? S64_MIN : S64_MAX;
 }
 
 /* result types for xctx.rt */
Index: linux-sfr-test/arch/mips/math-emu/ieee754dp.c
===================================================================
--- linux-sfr-test.orig/arch/mips/math-emu/ieee754dp.c	2015-04-08 16:56:50.000000000 +0100
+++ linux-sfr-test/arch/mips/math-emu/ieee754dp.c	2015-09-04 21:35:56.597771000 +0100
@@ -37,8 +37,11 @@ static inline int ieee754dp_isnan(union 
 
 static inline int ieee754dp_issnan(union ieee754dp x)
 {
+	int qbit;
+
 	assert(ieee754dp_isnan(x));
-	return (DPMANT(x) & DP_MBIT(DP_FBITS - 1)) == DP_MBIT(DP_FBITS - 1);
+	qbit = (DPMANT(x) & DP_MBIT(DP_FBITS - 1)) == DP_MBIT(DP_FBITS - 1);
+	return ieee754_csr.nan2008 ^ qbit;
 }
 
 
@@ -51,7 +54,12 @@ union ieee754dp __cold ieee754dp_nanxcpt
 	assert(ieee754dp_issnan(r));
 
 	ieee754_setcx(IEEE754_INVALID_OPERATION);
-	return ieee754dp_indef();
+	if (ieee754_csr.nan2008)
+		DPMANT(r) |= DP_MBIT(DP_FBITS - 1);
+	else
+		r = ieee754dp_indef();
+
+	return r;
 }
 
 static u64 ieee754dp_get_rounding(int sn, u64 xm)
Index: linux-sfr-test/arch/mips/math-emu/ieee754int.h
===================================================================
--- linux-sfr-test.orig/arch/mips/math-emu/ieee754int.h	2015-09-04 19:19:07.000000000 +0100
+++ linux-sfr-test/arch/mips/math-emu/ieee754int.h	2015-09-04 21:35:56.599789000 +0100
@@ -63,10 +63,10 @@ static inline int ieee754_class_nan(int 
 	if (ve == SP_EMAX+1+SP_EBIAS) {					\
 		if (vm == 0)						\
 			vc = IEEE754_CLASS_INF;				\
-		else if (vm & SP_MBIT(SP_FBITS-1))			\
-			vc = IEEE754_CLASS_SNAN;			\
-		else							\
+		else if (ieee754_csr.nan2008 ^ !(vm & SP_MBIT(SP_FBITS - 1))) \
 			vc = IEEE754_CLASS_QNAN;			\
+		else							\
+			vc = IEEE754_CLASS_SNAN;			\
 	} else if (ve == SP_EMIN-1+SP_EBIAS) {				\
 		if (vm) {						\
 			ve = SP_EMIN;					\
@@ -97,10 +97,10 @@ static inline int ieee754_class_nan(int 
 	if (ve == DP_EMAX+1+DP_EBIAS) {					\
 		if (vm == 0)						\
 			vc = IEEE754_CLASS_INF;				\
-		else if (vm & DP_MBIT(DP_FBITS-1))			\
-			vc = IEEE754_CLASS_SNAN;			\
-		else							\
+		else if (ieee754_csr.nan2008 ^ !(vm & DP_MBIT(DP_FBITS - 1))) \
 			vc = IEEE754_CLASS_QNAN;			\
+		else							\
+			vc = IEEE754_CLASS_SNAN;			\
 	} else if (ve == DP_EMIN-1+DP_EBIAS) {				\
 		if (vm) {						\
 			ve = DP_EMIN;					\
Index: linux-sfr-test/arch/mips/math-emu/ieee754sp.c
===================================================================
--- linux-sfr-test.orig/arch/mips/math-emu/ieee754sp.c	2015-04-08 16:56:50.000000000 +0100
+++ linux-sfr-test/arch/mips/math-emu/ieee754sp.c	2015-09-04 21:35:56.602775000 +0100
@@ -37,8 +37,11 @@ static inline int ieee754sp_isnan(union 
 
 static inline int ieee754sp_issnan(union ieee754sp x)
 {
+	int qbit;
+
 	assert(ieee754sp_isnan(x));
-	return SPMANT(x) & SP_MBIT(SP_FBITS - 1);
+	qbit = (SPMANT(x) & SP_MBIT(SP_FBITS - 1)) == SP_MBIT(SP_FBITS - 1);
+	return ieee754_csr.nan2008 ^ qbit;
 }
 
 
@@ -51,7 +54,12 @@ union ieee754sp __cold ieee754sp_nanxcpt
 	assert(ieee754sp_issnan(r));
 
 	ieee754_setcx(IEEE754_INVALID_OPERATION);
-	return ieee754sp_indef();
+	if (ieee754_csr.nan2008)
+		SPMANT(r) |= SP_MBIT(SP_FBITS - 1);
+	else
+		r = ieee754sp_indef();
+
+	return r;
 }
 
 static unsigned ieee754sp_get_rounding(int sn, unsigned xm)
Index: linux-sfr-test/arch/mips/math-emu/sp_fdp.c
===================================================================
--- linux-sfr-test.orig/arch/mips/math-emu/sp_fdp.c	2015-04-08 16:56:50.000000000 +0100
+++ linux-sfr-test/arch/mips/math-emu/sp_fdp.c	2015-09-04 21:35:56.604814000 +0100
@@ -44,13 +44,16 @@ union ieee754sp ieee754sp_fdp(union ieee
 
 	switch (xc) {
 	case IEEE754_CLASS_SNAN:
-		return ieee754sp_nanxcpt(ieee754sp_nan_fdp(xs, xm));
-
+		x = ieee754dp_nanxcpt(x);
+		EXPLODEXDP;
+		/* Fall through.  */
 	case IEEE754_CLASS_QNAN:
 		y = ieee754sp_nan_fdp(xs, xm);
-		EXPLODEYSP;
-		if (!ieee754_class_nan(yc))
-			y = ieee754sp_indef();
+		if (!ieee754_csr.nan2008) {
+			EXPLODEYSP;
+			if (!ieee754_class_nan(yc))
+				y = ieee754sp_indef();
+		}
 		return y;
 
 	case IEEE754_CLASS_INF:
Index: linux-sfr-test/arch/mips/math-emu/sp_tint.c
===================================================================
--- linux-sfr-test.orig/arch/mips/math-emu/sp_tint.c	2015-04-08 16:56:50.000000000 +0100
+++ linux-sfr-test/arch/mips/math-emu/sp_tint.c	2015-09-04 21:35:56.607763000 +0100
@@ -38,10 +38,13 @@ int ieee754sp_tint(union ieee754sp x)
 	switch (xc) {
 	case IEEE754_CLASS_SNAN:
 	case IEEE754_CLASS_QNAN:
-	case IEEE754_CLASS_INF:
 		ieee754_setcx(IEEE754_INVALID_OPERATION);
 		return ieee754si_indef();
 
+	case IEEE754_CLASS_INF:
+		ieee754_setcx(IEEE754_INVALID_OPERATION);
+		return ieee754si_overflow(xs);
+
 	case IEEE754_CLASS_ZERO:
 		return 0;
 
@@ -56,7 +59,7 @@ int ieee754sp_tint(union ieee754sp x)
 		/* Set invalid. We will only use overflow for floating
 		   point overflow */
 		ieee754_setcx(IEEE754_INVALID_OPERATION);
-		return ieee754si_indef();
+		return ieee754si_overflow(xs);
 	}
 	/* oh gawd */
 	if (xe > SP_FBITS) {
@@ -97,7 +100,7 @@ int ieee754sp_tint(union ieee754sp x)
 		if ((xm >> 31) != 0) {
 			/* This can happen after rounding */
 			ieee754_setcx(IEEE754_INVALID_OPERATION);
-			return ieee754si_indef();
+			return ieee754si_overflow(xs);
 		}
 		if (round || sticky)
 			ieee754_setcx(IEEE754_INEXACT);
Index: linux-sfr-test/arch/mips/math-emu/sp_tlong.c
===================================================================
--- linux-sfr-test.orig/arch/mips/math-emu/sp_tlong.c	2015-04-08 16:56:50.000000000 +0100
+++ linux-sfr-test/arch/mips/math-emu/sp_tlong.c	2015-09-04 21:35:56.609788000 +0100
@@ -39,10 +39,13 @@ s64 ieee754sp_tlong(union ieee754sp x)
 	switch (xc) {
 	case IEEE754_CLASS_SNAN:
 	case IEEE754_CLASS_QNAN:
-	case IEEE754_CLASS_INF:
 		ieee754_setcx(IEEE754_INVALID_OPERATION);
 		return ieee754di_indef();
 
+	case IEEE754_CLASS_INF:
+		ieee754_setcx(IEEE754_INVALID_OPERATION);
+		return ieee754di_overflow(xs);
+
 	case IEEE754_CLASS_ZERO:
 		return 0;
 
@@ -57,7 +60,7 @@ s64 ieee754sp_tlong(union ieee754sp x)
 		/* Set invalid. We will only use overflow for floating
 		   point overflow */
 		ieee754_setcx(IEEE754_INVALID_OPERATION);
-		return ieee754di_indef();
+		return ieee754di_overflow(xs);
 	}
 	/* oh gawd */
 	if (xe > SP_FBITS) {
@@ -94,7 +97,7 @@ s64 ieee754sp_tlong(union ieee754sp x)
 		if ((xm >> 63) != 0) {
 			/* This can happen after rounding */
 			ieee754_setcx(IEEE754_INVALID_OPERATION);
-			return ieee754di_indef();
+			return ieee754di_overflow(xs);
 		}
 		if (round || sticky)
 			ieee754_setcx(IEEE754_INEXACT);
