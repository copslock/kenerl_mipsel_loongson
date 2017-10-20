Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Oct 2017 16:19:43 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:42219 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992933AbdJTOTchCfJ- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 20 Oct 2017 16:19:32 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id 65A8B1A495E;
        Fri, 20 Oct 2017 16:19:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local [10.10.13.111])
        by mail.rt-rk.com (Postfix) with ESMTPSA id 3CFD41A4833;
        Fri, 20 Oct 2017 16:19:26 +0200 (CEST)
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
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Paul Burton <paul.burton@mips.com>,
        Petar Jovanovic <petar.jovanovic@mips.com>,
        Raghu Gandham <raghu.gandham@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v2 2/2] MIPS: math-emu: Use preferred flavor of unsigned integer declarations
Date:   Fri, 20 Oct 2017 16:16:28 +0200
Message-Id: <1508509002-28518-3-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1508509002-28518-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1508509002-28518-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60495
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

Fix occurences of unsigned integer declarations that are not
preferred by standards of checkpatch scripts. This removes
significant number of checkpatch warnings in math-emu
directory (several files will become completely warning-free),
and thus makes easier to spot (now and in the future) other
perhaps more significant checkpatch errors and warnings.

Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
Reviewed-by: James Hogan <james.hogan@mips.com>
---
 arch/mips/math-emu/cp1emu.c     | 18 ++++++++++--------
 arch/mips/math-emu/dp_maddf.c   |  8 ++++----
 arch/mips/math-emu/dp_mul.c     |  8 ++++----
 arch/mips/math-emu/dp_sqrt.c    |  4 ++--
 arch/mips/math-emu/ieee754.h    | 15 ++++++++-------
 arch/mips/math-emu/ieee754int.h |  6 +++---
 arch/mips/math-emu/ieee754sp.c  |  4 ++--
 arch/mips/math-emu/ieee754sp.h  |  2 +-
 arch/mips/math-emu/sp_div.c     |  4 ++--
 arch/mips/math-emu/sp_fint.c    |  2 +-
 arch/mips/math-emu/sp_maddf.c   |  6 +++---
 arch/mips/math-emu/sp_mul.c     | 10 +++++-----
 12 files changed, 45 insertions(+), 42 deletions(-)

diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 6f57212..da6c1c0 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -810,7 +810,7 @@ do {									\
 #define SITOREG(si, x)							\
 do {									\
 	if (cop1_64bit(xcp) && !hybrid_fprs()) {			\
-		unsigned i;						\
+		unsigned int i;						\
 		set_fpr32(&ctx->fpr[x], 0, si);				\
 		for (i = 1; i < ARRAY_SIZE(ctx->fpr[x].val32); i++)	\
 			set_fpr32(&ctx->fpr[x], i, 0);			\
@@ -823,7 +823,7 @@ do {									\
 
 #define SITOHREG(si, x)							\
 do {									\
-	unsigned i;							\
+	unsigned int i;							\
 	set_fpr32(&ctx->fpr[x], 1, si);					\
 	for (i = 2; i < ARRAY_SIZE(ctx->fpr[x].val32); i++)		\
 		set_fpr32(&ctx->fpr[x], i, 0);				\
@@ -834,7 +834,7 @@ do {									\
 
 #define DITOREG(di, x)							\
 do {									\
-	unsigned fpr, i;						\
+	unsigned int fpr, i;						\
 	fpr = (x) & ~(cop1_64bit(xcp) ^ 1);				\
 	set_fpr64(&ctx->fpr[fpr], 0, di);				\
 	for (i = 1; i < ARRAY_SIZE(ctx->fpr[x].val64); i++)		\
@@ -1465,7 +1465,7 @@ DEF3OP(nmsub, dp, ieee754dp_mul, ieee754dp_sub, ieee754dp_neg);
 static int fpux_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 	mips_instruction ir, void __user **fault_addr)
 {
-	unsigned rcsr = 0;	/* resulting csr */
+	unsigned int rcsr = 0;	/* resulting csr */
 
 	MIPS_FPU_EMU_INC_STATS(cp1xops);
 
@@ -1661,10 +1661,10 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 	mips_instruction ir)
 {
 	int rfmt;		/* resulting format */
-	unsigned rcsr = 0;	/* resulting csr */
+	unsigned int rcsr = 0;	/* resulting csr */
 	unsigned int oldrm;
 	unsigned int cbit;
-	unsigned cond;
+	unsigned int cond;
 	union {
 		union ieee754dp d;
 		union ieee754sp s;
@@ -2029,9 +2029,10 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 
 		default:
 			if (!NO_R6EMU && MIPSInst_FUNC(ir) >= fcmp_op) {
-				unsigned cmpop = MIPSInst_FUNC(ir) - fcmp_op;
+				unsigned int cmpop;
 				union ieee754sp fs, ft;
 
+				cmpop = MIPSInst_FUNC(ir) - fcmp_op;
 				SPFROMREG(fs, MIPSInst_FS(ir));
 				SPFROMREG(ft, MIPSInst_FT(ir));
 				rv.w = ieee754sp_cmp(fs, ft,
@@ -2379,9 +2380,10 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 
 		default:
 			if (!NO_R6EMU && MIPSInst_FUNC(ir) >= fcmp_op) {
-				unsigned cmpop = MIPSInst_FUNC(ir) - fcmp_op;
+				unsigned int cmpop;
 				union ieee754dp fs, ft;
 
+				cmpop = MIPSInst_FUNC(ir) - fcmp_op;
 				DPFROMREG(fs, MIPSInst_FS(ir));
 				DPFROMREG(ft, MIPSInst_FT(ir));
 				rv.w = ieee754dp_cmp(fs, ft,
diff --git a/arch/mips/math-emu/dp_maddf.c b/arch/mips/math-emu/dp_maddf.c
index e0d9be5..7ad79ed 100644
--- a/arch/mips/math-emu/dp_maddf.c
+++ b/arch/mips/math-emu/dp_maddf.c
@@ -45,10 +45,10 @@ static union ieee754dp _dp_maddf(union ieee754dp z, union ieee754dp x,
 {
 	int re;
 	int rs;
-	unsigned lxm;
-	unsigned hxm;
-	unsigned lym;
-	unsigned hym;
+	unsigned int lxm;
+	unsigned int hxm;
+	unsigned int lym;
+	unsigned int hym;
 	u64 lrm;
 	u64 hrm;
 	u64 lzm;
diff --git a/arch/mips/math-emu/dp_mul.c b/arch/mips/math-emu/dp_mul.c
index 87d0b44..60c8bfe 100644
--- a/arch/mips/math-emu/dp_mul.c
+++ b/arch/mips/math-emu/dp_mul.c
@@ -26,10 +26,10 @@ union ieee754dp ieee754dp_mul(union ieee754dp x, union ieee754dp y)
 	int re;
 	int rs;
 	u64 rm;
-	unsigned lxm;
-	unsigned hxm;
-	unsigned lym;
-	unsigned hym;
+	unsigned int lxm;
+	unsigned int hxm;
+	unsigned int lym;
+	unsigned int hym;
 	u64 lrm;
 	u64 hrm;
 	u64 t;
diff --git a/arch/mips/math-emu/dp_sqrt.c b/arch/mips/math-emu/dp_sqrt.c
index cd5bc08..cea907b 100644
--- a/arch/mips/math-emu/dp_sqrt.c
+++ b/arch/mips/math-emu/dp_sqrt.c
@@ -21,7 +21,7 @@
 
 #include "ieee754dp.h"
 
-static const unsigned table[] = {
+static const unsigned int table[] = {
 	0, 1204, 3062, 5746, 9193, 13348, 18162, 23592,
 	29598, 36145, 43202, 50740, 58733, 67158, 75992,
 	85215, 83599, 71378, 60428, 50647, 41945, 34246,
@@ -33,7 +33,7 @@ union ieee754dp ieee754dp_sqrt(union ieee754dp x)
 {
 	struct _ieee754_csr oldcsr;
 	union ieee754dp y, z, t;
-	unsigned scalx, yh;
+	unsigned int scalx, yh;
 	COMPXDP;
 
 	EXPLODEXDP;
diff --git a/arch/mips/math-emu/ieee754.h b/arch/mips/math-emu/ieee754.h
index 92dc8fa..e0eb7a9 100644
--- a/arch/mips/math-emu/ieee754.h
+++ b/arch/mips/math-emu/ieee754.h
@@ -165,11 +165,12 @@ struct _ieee754_csr {
 };
 #define ieee754_csr (*(struct _ieee754_csr *)(&current->thread.fpu.fcr31))
 
-static inline unsigned ieee754_getrm(void)
+static inline unsigned int ieee754_getrm(void)
 {
 	return (ieee754_csr.rm);
 }
-static inline unsigned ieee754_setrm(unsigned rm)
+
+static inline unsigned int ieee754_setrm(unsigned int rm)
 {
 	return (ieee754_csr.rm = rm);
 }
@@ -177,14 +178,14 @@ static inline unsigned ieee754_setrm(unsigned rm)
 /*
  * get current exceptions
  */
-static inline unsigned ieee754_getcx(void)
+static inline unsigned int ieee754_getcx(void)
 {
 	return (ieee754_csr.cx);
 }
 
 /* test for current exception condition
  */
-static inline int ieee754_cxtest(unsigned n)
+static inline int ieee754_cxtest(unsigned int n)
 {
 	return (ieee754_csr.cx & n);
 }
@@ -192,21 +193,21 @@ static inline int ieee754_cxtest(unsigned n)
 /*
  * get sticky exceptions
  */
-static inline unsigned ieee754_getsx(void)
+static inline unsigned int ieee754_getsx(void)
 {
 	return (ieee754_csr.sx);
 }
 
 /* clear sticky conditions
 */
-static inline unsigned ieee754_clrsx(void)
+static inline unsigned int ieee754_clrsx(void)
 {
 	return (ieee754_csr.sx = 0);
 }
 
 /* test for sticky exception condition
  */
-static inline int ieee754_sxtest(unsigned n)
+static inline int ieee754_sxtest(unsigned int n)
 {
 	return (ieee754_csr.sx & n);
 }
diff --git a/arch/mips/math-emu/ieee754int.h b/arch/mips/math-emu/ieee754int.h
index dd2071f..06ac0e2 100644
--- a/arch/mips/math-emu/ieee754int.h
+++ b/arch/mips/math-emu/ieee754int.h
@@ -54,13 +54,13 @@ static inline int ieee754_class_nan(int xc)
 }
 
 #define COMPXSP \
-	unsigned xm; int xe; int xs __maybe_unused; int xc
+	unsigned int xm; int xe; int xs __maybe_unused; int xc
 
 #define COMPYSP \
-	unsigned ym; int ye; int ys; int yc
+	unsigned int ym; int ye; int ys; int yc
 
 #define COMPZSP \
-	unsigned zm; int ze; int zs; int zc
+	unsigned int zm; int ze; int zs; int zc
 
 #define EXPLODESP(v, vc, vs, ve, vm)					\
 {									\
diff --git a/arch/mips/math-emu/ieee754sp.c b/arch/mips/math-emu/ieee754sp.c
index 260e6896..8423e4c 100644
--- a/arch/mips/math-emu/ieee754sp.c
+++ b/arch/mips/math-emu/ieee754sp.c
@@ -65,7 +65,7 @@ union ieee754sp __cold ieee754sp_nanxcpt(union ieee754sp r)
 	return r;
 }
 
-static unsigned ieee754sp_get_rounding(int sn, unsigned xm)
+static unsigned int ieee754sp_get_rounding(int sn, unsigned int xm)
 {
 	/* inexact must round of 3 bits
 	 */
@@ -96,7 +96,7 @@ static unsigned ieee754sp_get_rounding(int sn, unsigned xm)
  * xe is an unbiased exponent
  * xm is 3bit extended precision value.
  */
-union ieee754sp ieee754sp_format(int sn, int xe, unsigned xm)
+union ieee754sp ieee754sp_format(int sn, int xe, unsigned int xm)
 {
 	assert(xm);		/* we don't gen exact zeros (probably should) */
 
diff --git a/arch/mips/math-emu/ieee754sp.h b/arch/mips/math-emu/ieee754sp.h
index 0f63e42..8c5a638 100644
--- a/arch/mips/math-emu/ieee754sp.h
+++ b/arch/mips/math-emu/ieee754sp.h
@@ -69,7 +69,7 @@ static inline int ieee754sp_finite(union ieee754sp x)
 #define SPDNORMY	SPDNORMx(ym, ye)
 #define SPDNORMZ	SPDNORMx(zm, ze)
 
-static inline union ieee754sp buildsp(int s, int bx, unsigned m)
+static inline union ieee754sp buildsp(int s, int bx, unsigned int m)
 {
 	union ieee754sp r;
 
diff --git a/arch/mips/math-emu/sp_div.c b/arch/mips/math-emu/sp_div.c
index 27f6db3..23587b3 100644
--- a/arch/mips/math-emu/sp_div.c
+++ b/arch/mips/math-emu/sp_div.c
@@ -23,9 +23,9 @@
 
 union ieee754sp ieee754sp_div(union ieee754sp x, union ieee754sp y)
 {
-	unsigned rm;
+	unsigned int rm;
 	int re;
-	unsigned bm;
+	unsigned int bm;
 
 	COMPXSP;
 	COMPYSP;
diff --git a/arch/mips/math-emu/sp_fint.c b/arch/mips/math-emu/sp_fint.c
index d5d8495..1a35d12 100644
--- a/arch/mips/math-emu/sp_fint.c
+++ b/arch/mips/math-emu/sp_fint.c
@@ -23,7 +23,7 @@
 
 union ieee754sp ieee754sp_fint(int x)
 {
-	unsigned xm;
+	unsigned int xm;
 	int xe;
 	int xs;
 
diff --git a/arch/mips/math-emu/sp_maddf.c b/arch/mips/math-emu/sp_maddf.c
index 7195fe7..f823338 100644
--- a/arch/mips/math-emu/sp_maddf.c
+++ b/arch/mips/math-emu/sp_maddf.c
@@ -20,9 +20,9 @@ static union ieee754sp _sp_maddf(union ieee754sp z, union ieee754sp x,
 {
 	int re;
 	int rs;
-	unsigned rm;
-	uint64_t rm64;
-	uint64_t zm64;
+	unsigned int rm;
+	u64 rm64;
+	u64 zm64;
 	int s;
 
 	COMPXSP;
diff --git a/arch/mips/math-emu/sp_mul.c b/arch/mips/math-emu/sp_mul.c
index d910c43..4015101 100644
--- a/arch/mips/math-emu/sp_mul.c
+++ b/arch/mips/math-emu/sp_mul.c
@@ -25,15 +25,15 @@ union ieee754sp ieee754sp_mul(union ieee754sp x, union ieee754sp y)
 {
 	int re;
 	int rs;
-	unsigned rm;
+	unsigned int rm;
 	unsigned short lxm;
 	unsigned short hxm;
 	unsigned short lym;
 	unsigned short hym;
-	unsigned lrm;
-	unsigned hrm;
-	unsigned t;
-	unsigned at;
+	unsigned int lrm;
+	unsigned int hrm;
+	unsigned int t;
+	unsigned int at;
 
 	COMPXSP;
 	COMPYSP;
-- 
2.7.4
