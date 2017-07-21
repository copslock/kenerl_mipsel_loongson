Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jul 2017 16:14:22 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:55836 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993954AbdGUOM3KjtBG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 21 Jul 2017 16:12:29 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id AB2991A49EE;
        Fri, 21 Jul 2017 16:12:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.domain.local (rtrkw197-lin.domain.local [10.10.13.95])
        by mail.rt-rk.com (Postfix) with ESMTPSA id 5D5CC1A49DE;
        Fri, 21 Jul 2017 16:12:23 +0200 (CEST)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org
Cc:     Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        Douglas Leung <douglas.leung@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        linux-kernel@vger.kernel.org, Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v3 05/16] MIPS: math-emu: <MAX|MAXA|MIN|MINA>.<D|S>: Fix quiet NaN propagation
Date:   Fri, 21 Jul 2017 16:09:03 +0200
Message-Id: <1500646206-2436-6-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1500646206-2436-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1500646206-2436-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59181
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

Fix the value returned by <MAX|MAXA|MIN|MINA>.<D|S>, if both inputs
are quiet NaNs. The specifications of <MAX|MAXA|MIN|MINA>.<D|S> state
that the returned value in such cases should be the quiet NaN
contained in register fs.

The relevant example:

MAX.S fd,fs,ft:
  If fs contains qNaN1, and ft contains qNaN2, fd is going to contain
  qNaN1 (without this patch, it used to contain qNaN2).

Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
---
 arch/mips/math-emu/dp_fmax.c | 8 ++++++--
 arch/mips/math-emu/dp_fmin.c | 8 ++++++--
 arch/mips/math-emu/sp_fmax.c | 8 ++++++--
 arch/mips/math-emu/sp_fmin.c | 8 ++++++--
 4 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/arch/mips/math-emu/dp_fmax.c b/arch/mips/math-emu/dp_fmax.c
index fd71b8d..567fc33 100644
--- a/arch/mips/math-emu/dp_fmax.c
+++ b/arch/mips/math-emu/dp_fmax.c
@@ -47,6 +47,9 @@ union ieee754dp ieee754dp_fmax(union ieee754dp x, union ieee754dp y)
 	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_INF):
 		return ieee754dp_nanxcpt(x);
 
+	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
+		return x;
+
 	/* numbers are preferred to NaNs */
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_QNAN):
@@ -54,7 +57,6 @@ union ieee754dp ieee754dp_fmax(union ieee754dp x, union ieee754dp y)
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_QNAN):
 		return x;
 
-	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_ZERO):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_NORM):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_DNORM):
@@ -147,6 +149,9 @@ union ieee754dp ieee754dp_fmaxa(union ieee754dp x, union ieee754dp y)
 	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_INF):
 		return ieee754dp_nanxcpt(x);
 
+	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
+		return x;
+
 	/* numbers are preferred to NaNs */
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_QNAN):
@@ -154,7 +159,6 @@ union ieee754dp ieee754dp_fmaxa(union ieee754dp x, union ieee754dp y)
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_QNAN):
 		return x;
 
-	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_ZERO):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_NORM):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_DNORM):
diff --git a/arch/mips/math-emu/dp_fmin.c b/arch/mips/math-emu/dp_fmin.c
index c1072b0..77f7ca9 100644
--- a/arch/mips/math-emu/dp_fmin.c
+++ b/arch/mips/math-emu/dp_fmin.c
@@ -47,6 +47,9 @@ union ieee754dp ieee754dp_fmin(union ieee754dp x, union ieee754dp y)
 	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_INF):
 		return ieee754dp_nanxcpt(x);
 
+	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
+		return x;
+
 	/* numbers are preferred to NaNs */
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_QNAN):
@@ -54,7 +57,6 @@ union ieee754dp ieee754dp_fmin(union ieee754dp x, union ieee754dp y)
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_QNAN):
 		return x;
 
-	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_ZERO):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_NORM):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_DNORM):
@@ -147,6 +149,9 @@ union ieee754dp ieee754dp_fmina(union ieee754dp x, union ieee754dp y)
 	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_INF):
 		return ieee754dp_nanxcpt(x);
 
+	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
+		return x;
+
 	/* numbers are preferred to NaNs */
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_QNAN):
@@ -154,7 +159,6 @@ union ieee754dp ieee754dp_fmina(union ieee754dp x, union ieee754dp y)
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_QNAN):
 		return x;
 
-	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_ZERO):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_NORM):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_DNORM):
diff --git a/arch/mips/math-emu/sp_fmax.c b/arch/mips/math-emu/sp_fmax.c
index 4d00084..d46e8e4 100644
--- a/arch/mips/math-emu/sp_fmax.c
+++ b/arch/mips/math-emu/sp_fmax.c
@@ -47,6 +47,9 @@ union ieee754sp ieee754sp_fmax(union ieee754sp x, union ieee754sp y)
 	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_INF):
 		return ieee754sp_nanxcpt(x);
 
+	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
+		return x;
+
 	/* numbers are preferred to NaNs */
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_QNAN):
@@ -54,7 +57,6 @@ union ieee754sp ieee754sp_fmax(union ieee754sp x, union ieee754sp y)
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_QNAN):
 		return x;
 
-	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_ZERO):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_NORM):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_DNORM):
@@ -147,6 +149,9 @@ union ieee754sp ieee754sp_fmaxa(union ieee754sp x, union ieee754sp y)
 	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_INF):
 		return ieee754sp_nanxcpt(x);
 
+	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
+		return x;
+
 	/* numbers are preferred to NaNs */
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_QNAN):
@@ -154,7 +159,6 @@ union ieee754sp ieee754sp_fmaxa(union ieee754sp x, union ieee754sp y)
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_QNAN):
 		return x;
 
-	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_ZERO):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_NORM):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_DNORM):
diff --git a/arch/mips/math-emu/sp_fmin.c b/arch/mips/math-emu/sp_fmin.c
index 4eb1bb9..b528c4b 100644
--- a/arch/mips/math-emu/sp_fmin.c
+++ b/arch/mips/math-emu/sp_fmin.c
@@ -47,6 +47,9 @@ union ieee754sp ieee754sp_fmin(union ieee754sp x, union ieee754sp y)
 	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_INF):
 		return ieee754sp_nanxcpt(x);
 
+	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
+		return x;
+
 	/* numbers are preferred to NaNs */
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_QNAN):
@@ -54,7 +57,6 @@ union ieee754sp ieee754sp_fmin(union ieee754sp x, union ieee754sp y)
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_QNAN):
 		return x;
 
-	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_ZERO):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_NORM):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_DNORM):
@@ -147,6 +149,9 @@ union ieee754sp ieee754sp_fmina(union ieee754sp x, union ieee754sp y)
 	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_INF):
 		return ieee754sp_nanxcpt(x);
 
+	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
+		return x;
+
 	/* numbers are preferred to NaNs */
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_QNAN):
@@ -154,7 +159,6 @@ union ieee754sp ieee754sp_fmina(union ieee754sp x, union ieee754sp y)
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_QNAN):
 		return x;
 
-	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_ZERO):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_NORM):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_DNORM):
-- 
2.7.4
