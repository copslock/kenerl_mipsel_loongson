Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jul 2017 18:17:51 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:57725 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993975AbdG0QMw0OZs9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 27 Jul 2017 18:12:52 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id E6C981A4A40;
        Thu, 27 Jul 2017 18:12:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.domain.local (rtrkw197-lin.domain.local [10.10.13.95])
        by mail.rt-rk.com (Postfix) with ESMTPSA id C92CB1A4A25;
        Thu, 27 Jul 2017 18:12:46 +0200 (CEST)
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
Subject: [PATCH v4 16/16] MIPS: math-emu: <MADDF|MSUBF>.D: Fix accuracy (64-bit case)
Date:   Thu, 27 Jul 2017 18:08:59 +0200
Message-Id: <1501171791-23690-17-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1501171791-23690-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1501171791-23690-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59300
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
as it is implemented in hardware, using 128-bit intermediate
calculations.

One test case example (raw bits) that this patch fixes:

MADDF.D fd,fs,ft:
  fd = 0x00000ca000000000
  fs = ft = 0x3f40624dd2f1a9fc

Fixes: e24c3bec3e8e ("MIPS: math-emu: Add support for the MIPS R6 MADDF FPU instruction")
Fixes: 83d43305a1df ("MIPS: math-emu: Add support for the MIPS R6 MSUBF FPU instruction")

Signed-off-by: Douglas Leung <douglas.leung@imgtec.com>
Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
Cc: <stable@vger.kernel.org> # 4.7+
---
 arch/mips/math-emu/dp_maddf.c | 133 +++++++++++++++++++++++++++++-------------
 1 file changed, 94 insertions(+), 39 deletions(-)

diff --git a/arch/mips/math-emu/dp_maddf.c b/arch/mips/math-emu/dp_maddf.c
index e799fc8..e0d9be5 100644
--- a/arch/mips/math-emu/dp_maddf.c
+++ b/arch/mips/math-emu/dp_maddf.c
@@ -15,18 +15,44 @@
 #include "ieee754dp.h"
 
 
+/* 128 bits shift right logical with rounding. */
+void srl128(u64 *hptr, u64 *lptr, int count)
+{
+	u64 low;
+
+	if (count >= 128) {
+		*lptr = *hptr != 0 || *lptr != 0;
+		*hptr = 0;
+	} else if (count >= 64) {
+		if (count == 64) {
+			*lptr = *hptr | (*lptr != 0);
+		} else {
+			low = *lptr;
+			*lptr = *hptr >> (count - 64);
+			*lptr |= (*hptr << (128 - count)) != 0 || low != 0;
+		}
+		*hptr = 0;
+	} else {
+		low = *lptr;
+		*lptr = low >> count | *hptr << (64 - count);
+		*lptr |= (low << (64 - count)) != 0;
+		*hptr = *hptr >> count;
+	}
+}
+
 static union ieee754dp _dp_maddf(union ieee754dp z, union ieee754dp x,
 				 union ieee754dp y, enum maddf_flags flags)
 {
 	int re;
 	int rs;
-	u64 rm;
 	unsigned lxm;
 	unsigned hxm;
 	unsigned lym;
 	unsigned hym;
 	u64 lrm;
 	u64 hrm;
+	u64 lzm;
+	u64 hzm;
 	u64 t;
 	u64 at;
 	int s;
@@ -172,7 +198,7 @@ static union ieee754dp _dp_maddf(union ieee754dp z, union ieee754dp x,
 	ym <<= 64 - (DP_FBITS + 1);
 
 	/*
-	 * Multiply 64 bits xm, ym to give high 64 bits rm with stickness.
+	 * Multiply 64 bits xm and ym to give 128 bits result in hrm:lrm.
 	 */
 
 	/* 32 * 32 => 64 */
@@ -202,81 +228,110 @@ static union ieee754dp _dp_maddf(union ieee754dp z, union ieee754dp x,
 
 	hrm = hrm + (t >> 32);
 
-	rm = hrm | (lrm != 0);
-
-	/*
-	 * Sticky shift down to normal rounding precision.
-	 */
-	if ((s64) rm < 0) {
-		rm = (rm >> (64 - (DP_FBITS + 1 + 3))) |
-		     ((rm << (DP_FBITS + 1 + 3)) != 0);
+	/* Put explicit bit at bit 126 if necessary */
+	if ((int64_t)hrm < 0) {
+		lrm = (hrm << 63) | (lrm >> 1);
+		hrm = hrm >> 1;
 		re++;
-	} else {
-		rm = (rm >> (64 - (DP_FBITS + 1 + 3 + 1))) |
-		     ((rm << (DP_FBITS + 1 + 3 + 1)) != 0);
 	}
-	assert(rm & (DP_HIDDEN_BIT << 3));
 
-	if (zc == IEEE754_CLASS_ZERO)
-		return ieee754dp_format(rs, re, rm);
+	assert(hrm & (1 << 62));
 
-	/* And now the addition */
-	assert(zm & DP_HIDDEN_BIT);
+	if (zc == IEEE754_CLASS_ZERO) {
+		/*
+		 * Move explicit bit from bit 126 to bit 55 since the
+		 * ieee754dp_format code expects the mantissa to be
+		 * 56 bits wide (53 + 3 rounding bits).
+		 */
+		srl128(&hrm, &lrm, (126 - 55));
+		return ieee754dp_format(rs, re, lrm);
+	}
 
-	/*
-	 * Provide guard,round and stick bit space.
-	 */
-	zm <<= 3;
+	/* Move explicit bit from bit 52 to bit 126 */
+	lzm = 0;
+	hzm = zm << 10;
+	assert(hzm & (1 << 62));
 
+	/* Make the exponents the same */
 	if (ze > re) {
 		/*
 		 * Have to shift y fraction right to align.
 		 */
 		s = ze - re;
-		rm = XDPSRS(rm, s);
+		srl128(&hrm, &lrm, s);
 		re += s;
 	} else if (re > ze) {
 		/*
 		 * Have to shift x fraction right to align.
 		 */
 		s = re - ze;
-		zm = XDPSRS(zm, s);
+		srl128(&hzm, &lzm, s);
 		ze += s;
 	}
 	assert(ze == re);
 	assert(ze <= DP_EMAX);
 
+	/* Do the addition */
 	if (zs == rs) {
 		/*
-		 * Generate 28 bit result of adding two 27 bit numbers
-		 * leaving result in xm, xs and xe.
+		 * Generate 128 bit result by adding two 127 bit numbers
+		 * leaving result in hzm:lzm, zs and ze.
 		 */
-		zm = zm + rm;
-
-		if (zm >> (DP_FBITS + 1 + 3)) { /* carry out */
-			zm = XDPSRS1(zm);
+		hzm = hzm + hrm + (lzm > (lzm + lrm));
+		lzm = lzm + lrm;
+		if ((int64_t)hzm < 0) {        /* carry out */
+			srl128(&hzm, &lzm, 1);
 			ze++;
 		}
 	} else {
-		if (zm >= rm) {
-			zm = zm - rm;
+		if (hzm > hrm || (hzm == hrm && lzm >= lrm)) {
+			hzm = hzm - hrm - (lzm < lrm);
+			lzm = lzm - lrm;
 		} else {
-			zm = rm - zm;
+			hzm = hrm - hzm - (lrm < lzm);
+			lzm = lrm - lzm;
 			zs = rs;
 		}
-		if (zm == 0)
+		if (lzm == 0 && hzm == 0)
 			return ieee754dp_zero(ieee754_csr.rm == FPU_CSR_RD);
 
 		/*
-		 * Normalize to rounding precision.
+		 * Put explicit bit at bit 126 if necessary.
 		 */
-		while ((zm >> (DP_FBITS + 3)) == 0) {
-			zm <<= 1;
-			ze--;
+		if (hzm == 0) {
+			/* left shift by 63 or 64 bits */
+			if ((int64_t)lzm < 0) {
+				/* MSB of lzm is the explicit bit */
+				hzm = lzm >> 1;
+				lzm = lzm << 63;
+				ze -= 63;
+			} else {
+				hzm = lzm;
+				lzm = 0;
+				ze -= 64;
+			}
+		}
+
+		t = 0;
+		while ((hzm >> (62 - t)) == 0)
+			t++;
+
+		assert(t <= 62);
+		if (t) {
+			hzm = hzm << t | lzm >> (64 - t);
+			lzm = lzm << t;
+			ze -= t;
 		}
 	}
 
-	return ieee754dp_format(zs, ze, zm);
+	/*
+	 * Move explicit bit from bit 126 to bit 55 since the
+	 * ieee754dp_format code expects the mantissa to be
+	 * 56 bits wide (53 + 3 rounding bits).
+	 */
+	srl128(&hzm, &lzm, (126 - 55));
+
+	return ieee754dp_format(zs, ze, lzm);
 }
 
 union ieee754dp ieee754dp_maddf(union ieee754dp z, union ieee754dp x,
-- 
2.7.4
