Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jul 2017 16:15:15 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:55911 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993956AbdGUOMsFQ2XG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 21 Jul 2017 16:12:48 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id 95D651A46C8;
        Fri, 21 Jul 2017 16:12:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.domain.local (rtrkw197-lin.domain.local [10.10.13.95])
        by mail.rt-rk.com (Postfix) with ESMTPSA id 377EC1A4153;
        Fri, 21 Jul 2017 16:12:42 +0200 (CEST)
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
Subject: [PATCH v3 07/16] MIPS: math-emu: <MAX|MIN>.<D|S>: Fix cases of both inputs negative
Date:   Fri, 21 Jul 2017 16:09:05 +0200
Message-Id: <1500646206-2436-8-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1500646206-2436-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1500646206-2436-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59183
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

Fix the value returned by <MAX|MIN>.<D|S>, if both inputs are negative
normal fp numbers. The previous logic did not take into account that
if both inputs have the same sign, there should be separate treatment
of the cases when both inputs are negative and when both inputs are
positive.

The relevant example:

MAX.S fd,fs,ft:
  If fs contains -5, and ft contains -7, fd is going to contain -5
  (without this patch, it used to contain -7).

Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
---
 arch/mips/math-emu/dp_fmax.c | 33 +++++++++++++++++++++++++--------
 arch/mips/math-emu/dp_fmin.c | 33 +++++++++++++++++++++++++--------
 arch/mips/math-emu/sp_fmax.c | 33 +++++++++++++++++++++++++--------
 arch/mips/math-emu/sp_fmin.c | 32 +++++++++++++++++++++++++-------
 4 files changed, 100 insertions(+), 31 deletions(-)

diff --git a/arch/mips/math-emu/dp_fmax.c b/arch/mips/math-emu/dp_fmax.c
index 9517572..a0175cc 100644
--- a/arch/mips/math-emu/dp_fmax.c
+++ b/arch/mips/math-emu/dp_fmax.c
@@ -106,16 +106,33 @@ union ieee754dp ieee754dp_fmax(union ieee754dp x, union ieee754dp y)
 	else if (xs < ys)
 		return x;
 
-	/* Compare exponent */
-	if (xe > ye)
-		return x;
-	else if (xe < ye)
-		return y;
+	/* Signs of inputs are the same, let's compare exponents */
+	if (xs == 0) {
+		/* Inputs are both positive */
+		if (xe > ye)
+			return x;
+		else if (xe < ye)
+			return y;
+	} else {
+		/* Inputs are both negative */
+		if (xe > ye)
+			return y;
+		else if (xe < ye)
+			return x;
+	}
 
-	/* Compare mantissa */
-	if (xm <= ym)
+	/* Signs and exponents of inputs are the same, let's compare mantissas */
+	if (xs == 0) {
+		/* Inputs are both positive, with equal exponents */
+		if (xm <= ym)
+			return y;
+		return x;
+	} else {
+		/* Inputs are both negative, with equal exponents */
+		if (xm <= ym)
+			return x;
 		return y;
-	return x;
+	}
 }
 
 union ieee754dp ieee754dp_fmaxa(union ieee754dp x, union ieee754dp y)
diff --git a/arch/mips/math-emu/dp_fmin.c b/arch/mips/math-emu/dp_fmin.c
index 7069320..074a858 100644
--- a/arch/mips/math-emu/dp_fmin.c
+++ b/arch/mips/math-emu/dp_fmin.c
@@ -106,16 +106,33 @@ union ieee754dp ieee754dp_fmin(union ieee754dp x, union ieee754dp y)
 	else if (xs < ys)
 		return y;
 
-	/* Compare exponent */
-	if (xe > ye)
-		return y;
-	else if (xe < ye)
-		return x;
+	/* Signs of inputs are the same, let's compare exponents */
+	if (xs == 0) {
+		/* Inputs are both positive */
+		if (xe > ye)
+			return y;
+		else if (xe < ye)
+			return x;
+	} else {
+		/* Inputs are both negative */
+		if (xe > ye)
+			return x;
+		else if (xe < ye)
+			return y;
+	}
 
-	/* Compare mantissa */
-	if (xm <= ym)
+	/* Signs and exponents of inputs are the same, let's compare mantissas */
+	if (xs == 0) {
+		/* Inputs are both positive, with equal exponents */
+		if (xm <= ym)
+			return x;
+		return y;
+	} else {
+		/* Inputs are both negative, with equal exponents */
+		if (xm <= ym)
+			return y;
 		return x;
-	return y;
+	}
 }
 
 union ieee754dp ieee754dp_fmina(union ieee754dp x, union ieee754dp y)
diff --git a/arch/mips/math-emu/sp_fmax.c b/arch/mips/math-emu/sp_fmax.c
index d72111a..15825db 100644
--- a/arch/mips/math-emu/sp_fmax.c
+++ b/arch/mips/math-emu/sp_fmax.c
@@ -106,16 +106,33 @@ union ieee754sp ieee754sp_fmax(union ieee754sp x, union ieee754sp y)
 	else if (xs < ys)
 		return x;
 
-	/* Compare exponent */
-	if (xe > ye)
-		return x;
-	else if (xe < ye)
-		return y;
+	/* Signs of inputs are the same, let's compare exponents */
+	if (xs == 0) {
+		/* Inputs are both positive */
+		if (xe > ye)
+			return x;
+		else if (xe < ye)
+			return y;
+	} else {
+		/* Inputs are both negative */
+		if (xe > ye)
+			return y;
+		else if (xe < ye)
+			return x;
+	}
 
-	/* Compare mantissa */
-	if (xm <= ym)
+	/* Signs and exponents of inputs are the same, let's compare mantissas */
+	if (xs == 0) {
+		/* Inputs are both positive, with equal exponents */
+		if (xm <= ym)
+			return y;
+		return x;
+	} else {
+		/* Inputs are both negative, with equal exponents */
+		if (xm <= ym)
+			return x;
 		return y;
-	return x;
+	}
 }
 
 union ieee754sp ieee754sp_fmaxa(union ieee754sp x, union ieee754sp y)
diff --git a/arch/mips/math-emu/sp_fmin.c b/arch/mips/math-emu/sp_fmin.c
index 61ff9c6..f1418f7 100644
--- a/arch/mips/math-emu/sp_fmin.c
+++ b/arch/mips/math-emu/sp_fmin.c
@@ -106,16 +106,34 @@ union ieee754sp ieee754sp_fmin(union ieee754sp x, union ieee754sp y)
 	else if (xs < ys)
 		return y;
 
-	/* Compare exponent */
-	if (xe > ye)
+	/* Signs of inputs are the same, let's compare exponents */
+	if (xs == 0) {
+		/* Inputs are both positive */
+		if (xe > ye)
+			return y;
+		else if (xe < ye)
+			return x;
+	} else {
+		/* Inputs are both negative */
+		if (xe > ye)
+			return x;
+		else if (xe < ye)
+			return y;
+	}
+
+	/* Signs and exponents of inputs are the same, let's compare mantissas */
+	if (xs == 0) {
+		/* Inputs are both positive, with equal exponents */
+		if (xm <= ym)
+			return x;
 		return y;
-	else if (xe < ye)
+	} else {
+		/* Inputs are both negative, with equal exponents */
+		if (xm <= ym)
+			return y;
 		return x;
+	}
 
-	/* Compare mantissa */
-	if (xm <= ym)
-		return x;
-	return y;
 }
 
 union ieee754sp ieee754sp_fmina(union ieee754sp x, union ieee754sp y)
-- 
2.7.4
