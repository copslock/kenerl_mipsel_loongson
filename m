Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jul 2017 18:17:24 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:57718 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994825AbdG0QMta3Pr9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 27 Jul 2017 18:12:49 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id 02A791A4A1E;
        Thu, 27 Jul 2017 18:12:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.domain.local (rtrkw197-lin.domain.local [10.10.13.95])
        by mail.rt-rk.com (Postfix) with ESMTPSA id B49491A4A09;
        Thu, 27 Jul 2017 18:12:43 +0200 (CEST)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org
Cc:     Douglas Leung <douglas.leung@imgtec.com>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        "# 4 . 7+" <stable@vger.kernel.org>, Bo Hu <bohu@google.com>,
        James Hogan <james.hogan@imgtec.com>,
        Jin Qian <jinqian@google.com>, linux-kernel@vger.kernel.org,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v4 15/16] MIPS: math-emu: <MADDF|MSUBF>.S: Fix accuracy (32-bit case)
Date:   Thu, 27 Jul 2017 18:08:58 +0200
Message-Id: <1501171791-23690-16-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1501171791-23690-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1501171791-23690-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59299
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

From: Douglas Leung <douglas.leung@imgtec.com>

Implement fused multiply-add with correct accuracy.

Fused multiply-add operation has better accuracy than respective
sequential execution of multiply and add operations applied on the
same inputs. This is because accuracy errors accumulate in latter
case.

This patch implements fused multiply-add with the same accuracy
as it is implemented in hardware, using 64-bit intermediate
calculations.

One test case example (raw bits) that this patch fixes:

MADDF.S fd,fs,ft:
  fd = 0x22575225
  fs = ft = 0x3727c5ac

Fixes: e24c3bec3e8e ("MIPS: math-emu: Add support for the MIPS R6 MADDF FPU instruction")
Fixes: 83d43305a1df ("MIPS: math-emu: Add support for the MIPS R6 MSUBF FPU instruction")

Signed-off-by: Douglas Leung <douglas.leung@imgtec.com>
Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
Cc: <stable@vger.kernel.org> # 4.7+
---
 arch/mips/math-emu/ieee754sp.h |   4 ++
 arch/mips/math-emu/sp_maddf.c  | 116 ++++++++++++++++-------------------------
 2 files changed, 50 insertions(+), 70 deletions(-)

diff --git a/arch/mips/math-emu/ieee754sp.h b/arch/mips/math-emu/ieee754sp.h
index 8476067..0f63e42 100644
--- a/arch/mips/math-emu/ieee754sp.h
+++ b/arch/mips/math-emu/ieee754sp.h
@@ -45,6 +45,10 @@ static inline int ieee754sp_finite(union ieee754sp x)
 	return SPBEXP(x) != SP_EMAX + 1 + SP_EBIAS;
 }
 
+/* 64 bit right shift with rounding */
+#define XSPSRS64(v, rs)						\
+	(((rs) >= 64) ? ((v) != 0) : ((v) >> (rs)) | ((v) << (64-(rs)) != 0))
+
 /* 3bit extended single precision sticky right shift */
 #define XSPSRS(v, rs)						\
 	((rs > (SP_FBITS+3))?1:((v) >> (rs)) | ((v) << (32-(rs)) != 0))
diff --git a/arch/mips/math-emu/sp_maddf.c b/arch/mips/math-emu/sp_maddf.c
index 07f5a9b..7195fe7 100644
--- a/arch/mips/math-emu/sp_maddf.c
+++ b/arch/mips/math-emu/sp_maddf.c
@@ -21,14 +21,8 @@ static union ieee754sp _sp_maddf(union ieee754sp z, union ieee754sp x,
 	int re;
 	int rs;
 	unsigned rm;
-	unsigned short lxm;
-	unsigned short hxm;
-	unsigned short lym;
-	unsigned short hym;
-	unsigned lrm;
-	unsigned hrm;
-	unsigned t;
-	unsigned at;
+	uint64_t rm64;
+	uint64_t zm64;
 	int s;
 
 	COMPXSP;
@@ -170,108 +164,90 @@ static union ieee754sp _sp_maddf(union ieee754sp z, union ieee754sp x,
 	if (flags & MADDF_NEGATE_PRODUCT)
 		rs ^= 1;
 
-	/* shunt to top of word */
-	xm <<= 32 - (SP_FBITS + 1);
-	ym <<= 32 - (SP_FBITS + 1);
+	/* Multiple 24 bit xm and ym to give 48 bit results */
+	rm64 = (uint64_t)xm * ym;
 
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
+	/* Shunt to top of word */
+	rm64 = rm64 << 16;
 
-	/*
-	 * Sticky shift down to normal rounding precision.
-	 */
-	if ((int) rm < 0) {
-		rm = (rm >> (32 - (SP_FBITS + 1 + 3))) |
-		    ((rm << (SP_FBITS + 1 + 3)) != 0);
+	/* Put explicit bit at bit 62 if necessary */
+	if ((int64_t) rm64 < 0) {
+		rm64 = rm64 >> 1;
 		re++;
-	} else {
-		rm = (rm >> (32 - (SP_FBITS + 1 + 3 + 1))) |
-		     ((rm << (SP_FBITS + 1 + 3 + 1)) != 0);
 	}
-	assert(rm & (SP_HIDDEN_BIT << 3));
 
-	if (zc == IEEE754_CLASS_ZERO)
-		return ieee754sp_format(rs, re, rm);
-
-	/* And now the addition */
+	assert(rm64 & (1 << 62));
 
-	assert(zm & SP_HIDDEN_BIT);
+	if (zc == IEEE754_CLASS_ZERO) {
+		/*
+		 * Move explicit bit from bit 62 to bit 26 since the
+		 * ieee754sp_format code expects the mantissa to be
+		 * 27 bits wide (24 + 3 rounding bits).
+		 */
+		rm = XSPSRS64(rm64, (62 - 26));
+		return ieee754sp_format(rs, re, rm);
+	}
 
-	/*
-	 * Provide guard,round and stick bit space.
-	 */
-	zm <<= 3;
+	/* Move explicit bit from bit 23 to bit 62 */
+	zm64 = (uint64_t)zm << (62 - 23);
+	assert(zm64 & (1 << 62));
 
+	/* Make the exponents the same */
 	if (ze > re) {
 		/*
 		 * Have to shift r fraction right to align.
 		 */
 		s = ze - re;
-		rm = XSPSRS(rm, s);
+		rm64 = XSPSRS64(rm64, s);
 		re += s;
 	} else if (re > ze) {
 		/*
 		 * Have to shift z fraction right to align.
 		 */
 		s = re - ze;
-		zm = XSPSRS(zm, s);
+		zm64 = XSPSRS64(zm64, s);
 		ze += s;
 	}
 	assert(ze == re);
 	assert(ze <= SP_EMAX);
 
+	/* Do the addition */
 	if (zs == rs) {
 		/*
-		 * Generate 28 bit result of adding two 27 bit numbers
-		 * leaving result in zm, zs and ze.
+		 * Generate 64 bit result by adding two 63 bit numbers
+		 * leaving result in zm64, zs and ze.
 		 */
-		zm = zm + rm;
-
-		if (zm >> (SP_FBITS + 1 + 3)) { /* carry out */
-			zm = XSPSRS1(zm);
+		zm64 = zm64 + rm64;
+		if ((int64_t)zm64 < 0) {	/* carry out */
+			zm64 = XSPSRS1(zm64);
 			ze++;
 		}
 	} else {
-		if (zm >= rm) {
-			zm = zm - rm;
+		if (zm64 >= rm64) {
+			zm64 = zm64 - rm64;
 		} else {
-			zm = rm - zm;
+			zm64 = rm64 - zm64;
 			zs = rs;
 		}
-		if (zm == 0)
+		if (zm64 == 0)
 			return ieee754sp_zero(ieee754_csr.rm == FPU_CSR_RD);
 
 		/*
-		 * Normalize in extended single precision
+		 * Put explicit bit at bit 62 if necessary.
 		 */
-		while ((zm >> (SP_MBITS + 3)) == 0) {
-			zm <<= 1;
+		while ((zm64 >> 62) == 0) {
+			zm64 <<= 1;
 			ze--;
 		}
-
 	}
+
+	/*
+	 * Move explicit bit from bit 62 to bit 26 since the
+	 * ieee754sp_format code expects the mantissa to be
+	 * 27 bits wide (24 + 3 rounding bits).
+	 */
+	zm = XSPSRS64(zm64, (62 - 26));
+
 	return ieee754sp_format(zs, ze, zm);
 }
 
-- 
2.7.4
