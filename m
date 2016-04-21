Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Apr 2016 15:07:57 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:51995 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27027252AbcDUNHQZLjsj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Apr 2016 15:07:16 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id CC0DD9E20DAAA;
        Thu, 21 Apr 2016 14:07:02 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 21 Apr 2016 14:07:09 +0100
Received: from localhost (10.100.200.79) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Thu, 21 Apr
 2016 14:07:08 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 07/11] MIPS: math-emu: Add z argument macros
Date:   Thu, 21 Apr 2016 14:04:51 +0100
Message-ID: <1461243895-30371-8-git-send-email-paul.burton@imgtec.com>
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
X-archive-position: 53162
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

Introduce macros for handling the "z" argument to maddf & msubf, making
its handling consistent with that of the "x" & "y" arguments rather than
open-coding equivalents.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/math-emu/dp_maddf.c   |  9 ++++-----
 arch/mips/math-emu/ieee754dp.h  |  1 +
 arch/mips/math-emu/ieee754int.h | 10 ++++++++++
 arch/mips/math-emu/ieee754sp.h  |  1 +
 arch/mips/math-emu/sp_maddf.c   |  8 ++++----
 5 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/arch/mips/math-emu/dp_maddf.c b/arch/mips/math-emu/dp_maddf.c
index d5e0fb1..0e1d4d8 100644
--- a/arch/mips/math-emu/dp_maddf.c
+++ b/arch/mips/math-emu/dp_maddf.c
@@ -36,16 +36,15 @@ static union ieee754dp _dp_maddf(union ieee754dp z, union ieee754dp x,
 
 	COMPXDP;
 	COMPYDP;
-
-	u64 zm; int ze; int zs __maybe_unused; int zc;
+	COMPZDP;
 
 	EXPLODEXDP;
 	EXPLODEYDP;
-	EXPLODEDP(z, zc, zs, ze, zm)
+	EXPLODEZDP;
 
 	FLUSHXDP;
 	FLUSHYDP;
-	FLUSHDP(z, zc, zs, ze, zm);
+	FLUSHZDP;
 
 	ieee754_clearcx();
 
@@ -54,7 +53,7 @@ static union ieee754dp _dp_maddf(union ieee754dp z, union ieee754dp x,
 		ieee754_setcx(IEEE754_INVALID_OPERATION);
 		return ieee754dp_nanxcpt(z);
 	case IEEE754_CLASS_DNORM:
-		DPDNORMx(zm, ze);
+		DPDNORMZ;
 	/* QNAN is handled separately below */
 	}
 
diff --git a/arch/mips/math-emu/ieee754dp.h b/arch/mips/math-emu/ieee754dp.h
index e2babd9..9ba0230 100644
--- a/arch/mips/math-emu/ieee754dp.h
+++ b/arch/mips/math-emu/ieee754dp.h
@@ -60,6 +60,7 @@ static inline int ieee754dp_finite(union ieee754dp x)
 	while ((m >> DP_FBITS) == 0) { m <<= 1; e--; }
 #define DPDNORMX	DPDNORMx(xm, xe)
 #define DPDNORMY	DPDNORMx(ym, ye)
+#define DPDNORMZ	DPDNORMx(zm, ze)
 
 static inline union ieee754dp builddp(int s, int bx, u64 m)
 {
diff --git a/arch/mips/math-emu/ieee754int.h b/arch/mips/math-emu/ieee754int.h
index ed7bb27..8bc2f69 100644
--- a/arch/mips/math-emu/ieee754int.h
+++ b/arch/mips/math-emu/ieee754int.h
@@ -55,6 +55,9 @@ static inline int ieee754_class_nan(int xc)
 #define COMPYSP \
 	unsigned ym; int ye; int ys; int yc
 
+#define COMPZSP \
+	unsigned zm; int ze; int zs; int zc
+
 #define EXPLODESP(v, vc, vs, ve, vm)					\
 {									\
 	vs = SPSIGN(v);							\
@@ -81,6 +84,7 @@ static inline int ieee754_class_nan(int xc)
 }
 #define EXPLODEXSP EXPLODESP(x, xc, xs, xe, xm)
 #define EXPLODEYSP EXPLODESP(y, yc, ys, ye, ym)
+#define EXPLODEZSP EXPLODESP(z, zc, zs, ze, zm)
 
 
 #define COMPXDP \
@@ -89,6 +93,9 @@ static inline int ieee754_class_nan(int xc)
 #define COMPYDP \
 	u64 ym; int ye; int ys; int yc
 
+#define COMPZDP \
+	u64 zm; int ze; int zs; int zc
+
 #define EXPLODEDP(v, vc, vs, ve, vm)					\
 {									\
 	vm = DPMANT(v);							\
@@ -115,6 +122,7 @@ static inline int ieee754_class_nan(int xc)
 }
 #define EXPLODEXDP EXPLODEDP(x, xc, xs, xe, xm)
 #define EXPLODEYDP EXPLODEDP(y, yc, ys, ye, ym)
+#define EXPLODEZDP EXPLODEDP(z, zc, zs, ze, zm)
 
 #define FLUSHDP(v, vc, vs, ve, vm)					\
 	if (vc==IEEE754_CLASS_DNORM) {					\
@@ -140,7 +148,9 @@ static inline int ieee754_class_nan(int xc)
 
 #define FLUSHXDP FLUSHDP(x, xc, xs, xe, xm)
 #define FLUSHYDP FLUSHDP(y, yc, ys, ye, ym)
+#define FLUSHZDP FLUSHDP(z, zc, zs, ze, zm)
 #define FLUSHXSP FLUSHSP(x, xc, xs, xe, xm)
 #define FLUSHYSP FLUSHSP(y, yc, ys, ye, ym)
+#define FLUSHZSP FLUSHSP(z, zc, zs, ze, zm)
 
 #endif /* __IEEE754INT_H  */
diff --git a/arch/mips/math-emu/ieee754sp.h b/arch/mips/math-emu/ieee754sp.h
index 374a3f0..b24fdff 100644
--- a/arch/mips/math-emu/ieee754sp.h
+++ b/arch/mips/math-emu/ieee754sp.h
@@ -65,6 +65,7 @@ static inline int ieee754sp_finite(union ieee754sp x)
 	while ((m >> SP_FBITS) == 0) { m <<= 1; e--; }
 #define SPDNORMX	SPDNORMx(xm, xe)
 #define SPDNORMY	SPDNORMx(ym, ye)
+#define SPDNORMZ	SPDNORMx(zm, ze)
 
 static inline union ieee754sp buildsp(int s, int bx, unsigned m)
 {
diff --git a/arch/mips/math-emu/sp_maddf.c b/arch/mips/math-emu/sp_maddf.c
index 93b7132..86e1d0b 100644
--- a/arch/mips/math-emu/sp_maddf.c
+++ b/arch/mips/math-emu/sp_maddf.c
@@ -36,15 +36,15 @@ static union ieee754sp _sp_maddf(union ieee754sp z, union ieee754sp x,
 
 	COMPXSP;
 	COMPYSP;
-	u32 zm; int ze; int zs __maybe_unused; int zc;
+	COMPZSP;
 
 	EXPLODEXSP;
 	EXPLODEYSP;
-	EXPLODESP(z, zc, zs, ze, zm)
+	EXPLODEZSP;
 
 	FLUSHXSP;
 	FLUSHYSP;
-	FLUSHSP(z, zc, zs, ze, zm);
+	FLUSHZSP;
 
 	ieee754_clearcx();
 
@@ -53,7 +53,7 @@ static union ieee754sp _sp_maddf(union ieee754sp z, union ieee754sp x,
 		ieee754_setcx(IEEE754_INVALID_OPERATION);
 		return ieee754sp_nanxcpt(z);
 	case IEEE754_CLASS_DNORM:
-		SPDNORMx(zm, ze);
+		SPDNORMZ;
 	/* QNAN is handled separately below */
 	}
 
-- 
2.8.0
