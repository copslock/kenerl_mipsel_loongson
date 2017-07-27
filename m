Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jul 2017 18:13:50 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:57579 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994231AbdG0QMFQzbn9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 27 Jul 2017 18:12:05 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id BD6651A4923;
        Thu, 27 Jul 2017 18:11:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.domain.local (rtrkw197-lin.domain.local [10.10.13.95])
        by mail.rt-rk.com (Postfix) with ESMTPSA id A0F151A4772;
        Thu, 27 Jul 2017 18:11:59 +0200 (CEST)
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
Subject: [PATCH v4 07/16] MIPS: math-emu: <MAX|MIN>.<D|S>: Fix cases of both inputs negative
Date:   Thu, 27 Jul 2017 18:08:50 +0200
Message-Id: <1501171791-23690-8-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1501171791-23690-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1501171791-23690-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59291
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

A relevant example:

MAX.S fd,fs,ft:
  If fs contains -5.0, and ft contains -7.0, fd is going to contain
  -5.0 (without this patch, it used to contain -7.0).

Fixes: a79f5f9ba508 ("MIPS: math-emu: Add support for the MIPS R6 MAX{, A} FPU instruction")
Fixes: 4e9561b20e2f ("MIPS: math-emu: Add support for the MIPS R6 MIN{, A} FPU instruction")

Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
Cc: <stable@vger.kernel.org> # 4.3+
Reviewed-by: James Hogan <james.hogan@imgtec.com>
---
 arch/mips/math-emu/dp_fmax.c | 32 ++++++++++++++++++++++++--------
 arch/mips/math-emu/dp_fmin.c | 32 ++++++++++++++++++++++++--------
 arch/mips/math-emu/sp_fmax.c | 32 ++++++++++++++++++++++++--------
 arch/mips/math-emu/sp_fmin.c | 32 ++++++++++++++++++++++++--------
 4 files changed, 96 insertions(+), 32 deletions(-)

diff --git a/arch/mips/math-emu/dp_fmax.c b/arch/mips/math-emu/dp_fmax.c
index 31f091a..0b53c78 100644
--- a/arch/mips/math-emu/dp_fmax.c
+++ b/arch/mips/math-emu/dp_fmax.c
@@ -116,16 +116,32 @@ union ieee754dp ieee754dp_fmax(union ieee754dp x, union ieee754dp y)
 	else if (xs < ys)
 		return x;
 
-	/* Compare exponent */
-	if (xe > ye)
-		return x;
-	else if (xe < ye)
-		return y;
+	/* Signs of inputs are equal, let's compare exponents */
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
+	/* Signs and exponents of inputs are equal, let's compare mantissas */
+	if (xs == 0) {
+		/* Inputs are both positive, with equal signs and exponents */
+		if (xm <= ym)
+			return y;
+		return x;
+	}
+	/* Inputs are both negative, with equal signs and exponents */
 	if (xm <= ym)
-		return y;
-	return x;
+		return x;
+	return y;
 }
 
 union ieee754dp ieee754dp_fmaxa(union ieee754dp x, union ieee754dp y)
diff --git a/arch/mips/math-emu/dp_fmin.c b/arch/mips/math-emu/dp_fmin.c
index e607d55..099e6bd 100644
--- a/arch/mips/math-emu/dp_fmin.c
+++ b/arch/mips/math-emu/dp_fmin.c
@@ -116,16 +116,32 @@ union ieee754dp ieee754dp_fmin(union ieee754dp x, union ieee754dp y)
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
+	/* Signs and exponents of inputs are equal, let's compare mantissas */
+	if (xs == 0) {
+		/* Inputs are both positive, with equal signs and exponents */
+		if (xm <= ym)
+			return x;
+		return y;
+	}
+	/* Inputs are both negative, with equal signs and exponents */
 	if (xm <= ym)
-		return x;
-	return y;
+		return y;
+	return x;
 }
 
 union ieee754dp ieee754dp_fmina(union ieee754dp x, union ieee754dp y)
diff --git a/arch/mips/math-emu/sp_fmax.c b/arch/mips/math-emu/sp_fmax.c
index 3ca5b20..7efa772 100644
--- a/arch/mips/math-emu/sp_fmax.c
+++ b/arch/mips/math-emu/sp_fmax.c
@@ -116,16 +116,32 @@ union ieee754sp ieee754sp_fmax(union ieee754sp x, union ieee754sp y)
 	else if (xs < ys)
 		return x;
 
-	/* Compare exponent */
-	if (xe > ye)
-		return x;
-	else if (xe < ye)
-		return y;
+	/* Signs of inputs are equal, let's compare exponents */
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
+	/* Signs and exponents of inputs are equal, let's compare mantissas */
+	if (xs == 0) {
+		/* Inputs are both positive, with equal signs and exponents */
+		if (xm <= ym)
+			return y;
+		return x;
+	}
+	/* Inputs are both negative, with equal signs and exponents */
 	if (xm <= ym)
-		return y;
-	return x;
+		return x;
+	return y;
 }
 
 union ieee754sp ieee754sp_fmaxa(union ieee754sp x, union ieee754sp y)
diff --git a/arch/mips/math-emu/sp_fmin.c b/arch/mips/math-emu/sp_fmin.c
index c982647..e2c5543 100644
--- a/arch/mips/math-emu/sp_fmin.c
+++ b/arch/mips/math-emu/sp_fmin.c
@@ -116,16 +116,32 @@ union ieee754sp ieee754sp_fmin(union ieee754sp x, union ieee754sp y)
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
+	/* Signs and exponents of inputs are equal, let's compare mantissas */
+	if (xs == 0) {
+		/* Inputs are both positive, with equal signs and exponents */
+		if (xm <= ym)
+			return x;
+		return y;
+	}
+	/* Inputs are both negative, with equal signs and exponents */
 	if (xm <= ym)
-		return x;
-	return y;
+		return y;
+	return x;
 }
 
 union ieee754sp ieee754sp_fmina(union ieee754sp x, union ieee754sp y)
-- 
2.7.4
