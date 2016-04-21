Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Apr 2016 15:08:46 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:40954 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27027256AbcDUNH7QiTcj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Apr 2016 15:07:59 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id 6E80FDD15357;
        Thu, 21 Apr 2016 14:07:46 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 21 Apr 2016 14:07:52 +0100
Received: from localhost (10.100.200.79) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Thu, 21 Apr
 2016 14:07:52 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Adam Buchbinder <adam.buchbinder@gmail.com>,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 10/11] MIPS: math-emu: Fix m{add,sub}.s shifts
Date:   Thu, 21 Apr 2016 14:04:54 +0100
Message-ID: <1461243895-30371-11-git-send-email-paul.burton@imgtec.com>
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
X-archive-position: 53165
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

The code in _sp_maddf (formerly ieee754sp_madd) appears to have been
copied verbatim from ieee754sp_add, and although it's adding the
unpacked "r" & "z" floats it kept using macros that operate on "x" &
"y". This led to the addition being carried out incorrectly on some
mismash of the product, accumulator & multiplicand fields. Typically
this would lead to the assertions "ze == re" & "ze <= SP_EMAX" failing
since ze & re hadn't been operated upon.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: e24c3bec3e8e ("MIPS: math-emu: Add support for the MIPS R6 MADDF FPU instruction")
---

 arch/mips/math-emu/ieee754sp.c |  3 ++-
 arch/mips/math-emu/ieee754sp.h | 16 +++++++---------
 arch/mips/math-emu/sp_add.c    |  6 ++++--
 arch/mips/math-emu/sp_maddf.c  | 13 ++++++++-----
 arch/mips/math-emu/sp_sub.c    |  6 ++++--
 5 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/arch/mips/math-emu/ieee754sp.c b/arch/mips/math-emu/ieee754sp.c
index e0b2c45..2de0c09 100644
--- a/arch/mips/math-emu/ieee754sp.c
+++ b/arch/mips/math-emu/ieee754sp.c
@@ -138,7 +138,8 @@ union ieee754sp ieee754sp_format(int sn, int xe, unsigned xm)
 		} else {
 			/* sticky right shift es bits
 			 */
-			SPXSRSXn(es);
+			xm = XSPSRS(xm, es);
+			xe += es;
 			assert((xm & (SP_HIDDEN_BIT << 3)) == 0);
 			assert(xe == SP_EMIN);
 		}
diff --git a/arch/mips/math-emu/ieee754sp.h b/arch/mips/math-emu/ieee754sp.h
index b24fdff..8476067 100644
--- a/arch/mips/math-emu/ieee754sp.h
+++ b/arch/mips/math-emu/ieee754sp.h
@@ -46,19 +46,17 @@ static inline int ieee754sp_finite(union ieee754sp x)
 }
 
 /* 3bit extended single precision sticky right shift */
-#define SPXSRSXn(rs)							\
-	(xe += rs,							\
-	 xm = (rs > (SP_FBITS+3))?1:((xm) >> (rs)) | ((xm) << (32-(rs)) != 0))
+#define XSPSRS(v, rs)						\
+	((rs > (SP_FBITS+3))?1:((v) >> (rs)) | ((v) << (32-(rs)) != 0))
 
-#define SPXSRSX1() \
-	(xe++, (xm = (xm >> 1) | (xm & 1)))
+#define XSPSRS1(m) \
+	((m >> 1) | (m & 1))
 
-#define SPXSRSYn(rs)								\
-	(ye+=rs,								\
-	 ym = (rs > (SP_FBITS+3))?1:((ym) >> (rs)) | ((ym) << (32-(rs)) != 0))
+#define SPXSRSX1() \
+	(xe++, (xm = XSPSRS1(xm)))
 
 #define SPXSRSY1() \
-	(ye++, (ym = (ym >> 1) | (ym & 1)))
+	(ye++, (ym = XSPSRS1(ym)))
 
 /* convert denormal to normalized with extended exponent */
 #define SPDNORMx(m,e) \
diff --git a/arch/mips/math-emu/sp_add.c b/arch/mips/math-emu/sp_add.c
index f1c87b0..c55c0c0 100644
--- a/arch/mips/math-emu/sp_add.c
+++ b/arch/mips/math-emu/sp_add.c
@@ -132,13 +132,15 @@ union ieee754sp ieee754sp_add(union ieee754sp x, union ieee754sp y)
 		 * Have to shift y fraction right to align.
 		 */
 		s = xe - ye;
-		SPXSRSYn(s);
+		ym = XSPSRS(ym, s);
+		ye += s;
 	} else if (ye > xe) {
 		/*
 		 * Have to shift x fraction right to align.
 		 */
 		s = ye - xe;
-		SPXSRSXn(s);
+		xm = XSPSRS(xm, s);
+		xe += s;
 	}
 	assert(xe == ye);
 	assert(xe <= SP_EMAX);
diff --git a/arch/mips/math-emu/sp_maddf.c b/arch/mips/math-emu/sp_maddf.c
index 86e1d0b..a8cd8b4 100644
--- a/arch/mips/math-emu/sp_maddf.c
+++ b/arch/mips/math-emu/sp_maddf.c
@@ -214,16 +214,18 @@ static union ieee754sp _sp_maddf(union ieee754sp z, union ieee754sp x,
 
 	if (ze > re) {
 		/*
-		 * Have to shift y fraction right to align.
+		 * Have to shift r fraction right to align.
 		 */
 		s = ze - re;
-		SPXSRSYn(s);
+		rm = XSPSRS(rm, s);
+		re += s;
 	} else if (re > ze) {
 		/*
-		 * Have to shift x fraction right to align.
+		 * Have to shift z fraction right to align.
 		 */
 		s = re - ze;
-		SPXSRSYn(s);
+		zm = XSPSRS(zm, s);
+		ze += s;
 	}
 	assert(ze == re);
 	assert(ze <= SP_EMAX);
@@ -236,7 +238,8 @@ static union ieee754sp _sp_maddf(union ieee754sp z, union ieee754sp x,
 		zm = zm + rm;
 
 		if (zm >> (SP_FBITS + 1 + 3)) { /* carry out */
-			SPXSRSX1();
+			zm = XSPSRS1(zm);
+			ze++;
 		}
 	} else {
 		if (zm >= rm) {
diff --git a/arch/mips/math-emu/sp_sub.c b/arch/mips/math-emu/sp_sub.c
index ec5f937..dc998ed 100644
--- a/arch/mips/math-emu/sp_sub.c
+++ b/arch/mips/math-emu/sp_sub.c
@@ -134,13 +134,15 @@ union ieee754sp ieee754sp_sub(union ieee754sp x, union ieee754sp y)
 		 * have to shift y fraction right to align
 		 */
 		s = xe - ye;
-		SPXSRSYn(s);
+		ym = XSPSRS(ym, s);
+		ye += s;
 	} else if (ye > xe) {
 		/*
 		 * have to shift x fraction right to align
 		 */
 		s = ye - xe;
-		SPXSRSXn(s);
+		xm = XSPSRS(xm, s);
+		xe += s;
 	}
 	assert(xe == ye);
 	assert(xe <= SP_EMAX);
-- 
2.8.0
