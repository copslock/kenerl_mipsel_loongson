Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Sep 2017 22:44:59 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:34856 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992197AbdIXUkn63Irz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 24 Sep 2017 22:40:43 +0200
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 428063EE;
        Sun, 24 Sep 2017 20:40:37 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>, Bo Hu <bohu@google.com>,
        Douglas Leung <douglas.leung@imgtec.com>,
        Jin Qian <jinqian@google.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.13 019/109] MIPS: math-emu: <MAX|MIN>.<D|S>: Fix cases of both inputs negative
Date:   Sun, 24 Sep 2017 22:32:40 +0200
Message-Id: <20170924203353.868377458@linuxfoundation.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170924203353.104695385@linuxfoundation.org>
References: <20170924203353.104695385@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60138
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aleksandar Markovic <aleksandar.markovic@imgtec.com>

commit aabf5cf02e22ebc4e541adf835910f388b6c3e65 upstream.

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
Reviewed-by: James Hogan <james.hogan@imgtec.com>
Cc: Bo Hu <bohu@google.com>
Cc: Douglas Leung <douglas.leung@imgtec.com>
Cc: Jin Qian <jinqian@google.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Petar Jovanovic <petar.jovanovic@imgtec.com>
Cc: Raghu Gandham <raghu.gandham@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/16882/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/math-emu/dp_fmax.c |   32 ++++++++++++++++++++++++--------
 arch/mips/math-emu/dp_fmin.c |   32 ++++++++++++++++++++++++--------
 arch/mips/math-emu/sp_fmax.c |   32 ++++++++++++++++++++++++--------
 arch/mips/math-emu/sp_fmin.c |   32 ++++++++++++++++++++++++--------
 4 files changed, 96 insertions(+), 32 deletions(-)

--- a/arch/mips/math-emu/dp_fmax.c
+++ b/arch/mips/math-emu/dp_fmax.c
@@ -116,16 +116,32 @@ union ieee754dp ieee754dp_fmax(union iee
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
--- a/arch/mips/math-emu/dp_fmin.c
+++ b/arch/mips/math-emu/dp_fmin.c
@@ -116,16 +116,32 @@ union ieee754dp ieee754dp_fmin(union iee
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
--- a/arch/mips/math-emu/sp_fmax.c
+++ b/arch/mips/math-emu/sp_fmax.c
@@ -116,16 +116,32 @@ union ieee754sp ieee754sp_fmax(union iee
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
--- a/arch/mips/math-emu/sp_fmin.c
+++ b/arch/mips/math-emu/sp_fmin.c
@@ -116,16 +116,32 @@ union ieee754sp ieee754sp_fmin(union iee
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
