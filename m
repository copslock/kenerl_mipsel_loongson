Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jul 2017 18:13:02 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:57563 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993973AbdG0QLuiJV49 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 27 Jul 2017 18:11:50 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id 425E01A4700;
        Thu, 27 Jul 2017 18:11:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.domain.local (rtrkw197-lin.domain.local [10.10.13.95])
        by mail.rt-rk.com (Postfix) with ESMTPSA id 23EBE1A2258;
        Thu, 27 Jul 2017 18:11:44 +0200 (CEST)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org
Cc:     Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        "# 4 . 3+" <stable@vger.kernel.org>, Bo Hu <bohu@google.com>,
        Douglas Leung <douglas.leung@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Jin Qian <jinqian@google.com>, linux-kernel@vger.kernel.org,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v4 05/16] MIPS: math-emu: <MAX|MAXA|MIN|MINA>.<D|S>: Fix quiet NaN propagation
Date:   Thu, 27 Jul 2017 18:08:48 +0200
Message-Id: <1501171791-23690-6-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1501171791-23690-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1501171791-23690-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59289
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

From: Aleksandar Markovic <aleksandar.markovic@imgtec.com>

Fix the value returned by <MAX|MAXA|MIN|MINA>.<D|S> fd,fs,ft, if both
inputs are quiet NaNs. The <MAX|MAXA|MIN|MINA>.<D|S> specifications
state that the returned value in such cases should be the quiet NaN
contained in register fs.

A relevant example:

MAX.S fd,fs,ft:
  If fs contains qNaN1, and ft contains qNaN2, fd is going to contain
  qNaN1 (without this patch, it used to contain qNaN2).

Fixes: a79f5f9ba508 ("MIPS: math-emu: Add support for the MIPS R6 MAX{, A} FPU instruction")
Fixes: 4e9561b20e2f ("MIPS: math-emu: Add support for the MIPS R6 MIN{, A} FPU instruction")

Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
Cc: <stable@vger.kernel.org> # 4.3+
Reviewed-by: James Hogan <james.hogan@imgtec.com>
---
 arch/mips/math-emu/dp_fmax.c | 32 ++++++++++++++++++++++++++++----
 arch/mips/math-emu/dp_fmin.c | 32 ++++++++++++++++++++++++++++----
 arch/mips/math-emu/sp_fmax.c | 32 ++++++++++++++++++++++++++++----
 arch/mips/math-emu/sp_fmin.c | 32 ++++++++++++++++++++++++++++----
 4 files changed, 112 insertions(+), 16 deletions(-)

diff --git a/arch/mips/math-emu/dp_fmax.c b/arch/mips/math-emu/dp_fmax.c
index fd71b8d..41bd6ed 100644
--- a/arch/mips/math-emu/dp_fmax.c
+++ b/arch/mips/math-emu/dp_fmax.c
@@ -47,14 +47,26 @@ union ieee754dp ieee754dp_fmax(union ieee754dp x, union ieee754dp y)
 	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_INF):
 		return ieee754dp_nanxcpt(x);
 
-	/* numbers are preferred to NaNs */
+	/*
+	 * Quiet NaN handling
+	 */
+
+	/*
+	 *    The case of both inputs quiet NaNs
+	 */
+	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
+		return x;
+
+	/*
+	 *    The cases of exactly one input quiet NaN (numbers
+	 *    are here preferred as returned values to NaNs)
+	 */
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_QNAN):
 		return x;
 
-	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_ZERO):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_NORM):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_DNORM):
@@ -147,14 +159,26 @@ union ieee754dp ieee754dp_fmaxa(union ieee754dp x, union ieee754dp y)
 	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_INF):
 		return ieee754dp_nanxcpt(x);
 
-	/* numbers are preferred to NaNs */
+	/*
+	 * Quiet NaN handling
+	 */
+
+	/*
+	 *    The case of both inputs quiet NaNs
+	 */
+	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
+		return x;
+
+	/*
+	 *    The cases of exactly one input quiet NaN (numbers
+	 *    are here preferred as returned values to NaNs)
+	 */
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_QNAN):
 		return x;
 
-	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_ZERO):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_NORM):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_DNORM):
diff --git a/arch/mips/math-emu/dp_fmin.c b/arch/mips/math-emu/dp_fmin.c
index c1072b0..53fb8c9 100644
--- a/arch/mips/math-emu/dp_fmin.c
+++ b/arch/mips/math-emu/dp_fmin.c
@@ -47,14 +47,26 @@ union ieee754dp ieee754dp_fmin(union ieee754dp x, union ieee754dp y)
 	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_INF):
 		return ieee754dp_nanxcpt(x);
 
-	/* numbers are preferred to NaNs */
+	/*
+	 * Quiet NaN handling
+	 */
+
+	/*
+	 *    The case of both inputs quiet NaNs
+	 */
+	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
+		return x;
+
+	/*
+	 *    The cases of exactly one input quiet NaN (numbers
+	 *    are here preferred as returned values to NaNs)
+	 */
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_QNAN):
 		return x;
 
-	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_ZERO):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_NORM):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_DNORM):
@@ -147,14 +159,26 @@ union ieee754dp ieee754dp_fmina(union ieee754dp x, union ieee754dp y)
 	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_INF):
 		return ieee754dp_nanxcpt(x);
 
-	/* numbers are preferred to NaNs */
+	/*
+	 * Quiet NaN handling
+	 */
+
+	/*
+	 *    The case of both inputs quiet NaNs
+	 */
+	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
+		return x;
+
+	/*
+	 *    The cases of exactly one input quiet NaN (numbers
+	 *    are here preferred as returned values to NaNs)
+	 */
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_QNAN):
 		return x;
 
-	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_ZERO):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_NORM):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_DNORM):
diff --git a/arch/mips/math-emu/sp_fmax.c b/arch/mips/math-emu/sp_fmax.c
index 4d00084..d0d73c32 100644
--- a/arch/mips/math-emu/sp_fmax.c
+++ b/arch/mips/math-emu/sp_fmax.c
@@ -47,14 +47,26 @@ union ieee754sp ieee754sp_fmax(union ieee754sp x, union ieee754sp y)
 	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_INF):
 		return ieee754sp_nanxcpt(x);
 
-	/* numbers are preferred to NaNs */
+	/*
+	 * Quiet NaN handling
+	 */
+
+	/*
+	 *    The case of both inputs quiet NaNs
+	 */
+	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
+		return x;
+
+	/*
+	 *    The cases of exactly one input quiet NaN (numbers
+	 *    are here preferred as returned values to NaNs)
+	 */
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_QNAN):
 		return x;
 
-	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_ZERO):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_NORM):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_DNORM):
@@ -147,14 +159,26 @@ union ieee754sp ieee754sp_fmaxa(union ieee754sp x, union ieee754sp y)
 	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_INF):
 		return ieee754sp_nanxcpt(x);
 
-	/* numbers are preferred to NaNs */
+	/*
+	 * Quiet NaN handling
+	 */
+
+	/*
+	 *    The case of both inputs quiet NaNs
+	 */
+	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
+		return x;
+
+	/*
+	 *    The cases of exactly one input quiet NaN (numbers
+	 *    are here preferred as returned values to NaNs)
+	 */
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_QNAN):
 		return x;
 
-	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_ZERO):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_NORM):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_DNORM):
diff --git a/arch/mips/math-emu/sp_fmin.c b/arch/mips/math-emu/sp_fmin.c
index 4eb1bb9..011692e 100644
--- a/arch/mips/math-emu/sp_fmin.c
+++ b/arch/mips/math-emu/sp_fmin.c
@@ -47,14 +47,26 @@ union ieee754sp ieee754sp_fmin(union ieee754sp x, union ieee754sp y)
 	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_INF):
 		return ieee754sp_nanxcpt(x);
 
-	/* numbers are preferred to NaNs */
+	/*
+	 * Quiet NaN handling
+	 */
+
+	/*
+	 *    The case of both inputs quiet NaNs
+	 */
+	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
+		return x;
+
+	/*
+	 *    The cases of exactly one input quiet NaN (numbers
+	 *    are here preferred as returned values to NaNs)
+	 */
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_QNAN):
 		return x;
 
-	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_ZERO):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_NORM):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_DNORM):
@@ -147,14 +159,26 @@ union ieee754sp ieee754sp_fmina(union ieee754sp x, union ieee754sp y)
 	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_INF):
 		return ieee754sp_nanxcpt(x);
 
-	/* numbers are preferred to NaNs */
+	/*
+	 * Quiet NaN handling
+	 */
+
+	/*
+	 *    The case of both inputs quiet NaNs
+	 */
+	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
+		return x;
+
+	/*
+	 *    The cases of exactly one input quiet NaN (numbers
+	 *    are here preferred as returned values to NaNs)
+	 */
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_QNAN):
 		return x;
 
-	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_ZERO):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_NORM):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_DNORM):
-- 
2.7.4
