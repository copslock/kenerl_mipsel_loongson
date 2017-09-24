Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Sep 2017 22:40:46 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:34096 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990481AbdIXUiPVYZRz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 24 Sep 2017 22:38:15 +0200
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 72CA83EE;
        Sun, 24 Sep 2017 20:38:08 +0000 (UTC)
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
Subject: [PATCH 4.9 20/77] MIPS: math-emu: <MADDF|MSUBF>.<D|S>: Fix NaN propagation
Date:   Sun, 24 Sep 2017 22:32:05 +0200
Message-Id: <20170924203243.667871040@linuxfoundation.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170924203242.904856530@linuxfoundation.org>
References: <20170924203242.904856530@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60129
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aleksandar Markovic <aleksandar.markovic@imgtec.com>

commit e840be6e7057757befc3581e1699e30fe7f0dd51 upstream.

Fix the cases of <MADDF|MSUBF>.<D|S> when any of three inputs is any
NaN. Correct behavior of <MADDF|MSUBF>.<D|S> fd, fs, ft is following:

  - if any of inputs is sNaN, return a sNaN using following rules: if
    only one input is sNaN, return that one; if more than one input is
    sNaN, order of precedence for return value is fd, fs, ft
  - if no input is sNaN, but at least one of inputs is qNaN, return a
    qNaN using following rules: if only one input is qNaN, return that
    one; if more than one input is qNaN, order of precedence for
    return value is fd, fs, ft

The previous code contained correct handling of some above cases, but
not all. Also, such handling was scattered into various cases of
"switch (CLPAIR(xc, yc))" statement, and elsewhere. With this patch,
this logic is placed in one place, and "switch (CLPAIR(xc, yc))" is
significantly simplified.

A relevant example:

MADDF.S fd,fs,ft:
  If fs contains qNaN1, ft contains qNaN2, and fd contains qNaN3, fd
  is going to contain qNaN3 (without this patch, it used to contain
  qNaN1).

Fixes: e24c3bec3e8e ("MIPS: math-emu: Add support for the MIPS R6 MADDF FPU instruction")
Fixes: 83d43305a1df ("MIPS: math-emu: Add support for the MIPS R6 MSUBF FPU instruction")

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
Patchwork: https://patchwork.linux-mips.org/patch/16886/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/math-emu/dp_maddf.c |   66 ++++++++++++------------------------------
 arch/mips/math-emu/sp_maddf.c |   66 +++++++++++++-----------------------------
 2 files changed, 41 insertions(+), 91 deletions(-)

--- a/arch/mips/math-emu/dp_maddf.c
+++ b/arch/mips/math-emu/dp_maddf.c
@@ -48,52 +48,34 @@ static union ieee754dp _dp_maddf(union i
 
 	ieee754_clearcx();
 
-	switch (zc) {
-	case IEEE754_CLASS_SNAN:
-		ieee754_setcx(IEEE754_INVALID_OPERATION);
+	/*
+	 * Handle the cases when at least one of x, y or z is a NaN.
+	 * Order of precedence is sNaN, qNaN and z, x, y.
+	 */
+	if (zc == IEEE754_CLASS_SNAN)
 		return ieee754dp_nanxcpt(z);
-	case IEEE754_CLASS_DNORM:
-		DPDNORMZ;
-	/* QNAN and ZERO cases are handled separately below */
-	}
-
-	switch (CLPAIR(xc, yc)) {
-	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_SNAN):
-	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_SNAN):
-	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_SNAN):
-	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_SNAN):
-	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_SNAN):
-		return ieee754dp_nanxcpt(y);
-
-	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_SNAN):
-	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_QNAN):
-	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_ZERO):
-	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_NORM):
-	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_DNORM):
-	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_INF):
+	if (xc == IEEE754_CLASS_SNAN)
 		return ieee754dp_nanxcpt(x);
-
-	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_QNAN):
-	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_QNAN):
-	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_QNAN):
-	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_QNAN):
+	if (yc == IEEE754_CLASS_SNAN)
+		return ieee754dp_nanxcpt(y);
+	if (zc == IEEE754_CLASS_QNAN)
+		return z;
+	if (xc == IEEE754_CLASS_QNAN)
+		return x;
+	if (yc == IEEE754_CLASS_QNAN)
 		return y;
 
-	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
-	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_ZERO):
-	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_NORM):
-	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_DNORM):
-	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_INF):
-		return x;
+	if (zc == IEEE754_CLASS_DNORM)
+		DPDNORMZ;
+	/* ZERO z cases are handled separately below */
 
+	switch (CLPAIR(xc, yc)) {
 
 	/*
 	 * Infinity handling
 	 */
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_ZERO):
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_INF):
-		if (zc == IEEE754_CLASS_QNAN)
-			return z;
 		ieee754_setcx(IEEE754_INVALID_OPERATION);
 		return ieee754dp_indef();
 
@@ -102,8 +84,6 @@ static union ieee754dp _dp_maddf(union i
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_NORM):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
-		if (zc == IEEE754_CLASS_QNAN)
-			return z;
 		return ieee754dp_inf(xs ^ ys);
 
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_ZERO):
@@ -120,25 +100,19 @@ static union ieee754dp _dp_maddf(union i
 		DPDNORMX;
 
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_DNORM):
-		if (zc == IEEE754_CLASS_QNAN)
-			return z;
-		else if (zc == IEEE754_CLASS_INF)
+		if (zc == IEEE754_CLASS_INF)
 			return ieee754dp_inf(zs);
 		DPDNORMY;
 		break;
 
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_NORM):
-		if (zc == IEEE754_CLASS_QNAN)
-			return z;
-		else if (zc == IEEE754_CLASS_INF)
+		if (zc == IEEE754_CLASS_INF)
 			return ieee754dp_inf(zs);
 		DPDNORMX;
 		break;
 
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_NORM):
-		if (zc == IEEE754_CLASS_QNAN)
-			return z;
-		else if (zc == IEEE754_CLASS_INF)
+		if (zc == IEEE754_CLASS_INF)
 			return ieee754dp_inf(zs);
 		/* fall through to real computations */
 	}
--- a/arch/mips/math-emu/sp_maddf.c
+++ b/arch/mips/math-emu/sp_maddf.c
@@ -48,51 +48,35 @@ static union ieee754sp _sp_maddf(union i
 
 	ieee754_clearcx();
 
-	switch (zc) {
-	case IEEE754_CLASS_SNAN:
-		ieee754_setcx(IEEE754_INVALID_OPERATION);
+	/*
+	 * Handle the cases when at least one of x, y or z is a NaN.
+	 * Order of precedence is sNaN, qNaN and z, x, y.
+	 */
+	if (zc == IEEE754_CLASS_SNAN)
 		return ieee754sp_nanxcpt(z);
-	case IEEE754_CLASS_DNORM:
-		SPDNORMZ;
-	/* QNAN and ZERO cases are handled separately below */
-	}
-
-	switch (CLPAIR(xc, yc)) {
-	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_SNAN):
-	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_SNAN):
-	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_SNAN):
-	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_SNAN):
-	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_SNAN):
+	if (xc == IEEE754_CLASS_SNAN)
+		return ieee754sp_nanxcpt(x);
+	if (yc == IEEE754_CLASS_SNAN)
 		return ieee754sp_nanxcpt(y);
+	if (zc == IEEE754_CLASS_QNAN)
+		return z;
+	if (xc == IEEE754_CLASS_QNAN)
+		return x;
+	if (yc == IEEE754_CLASS_QNAN)
+		return y;
 
-	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_SNAN):
-	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_QNAN):
-	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_ZERO):
-	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_NORM):
-	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_DNORM):
-	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_INF):
-		return ieee754sp_nanxcpt(x);
+	if (zc == IEEE754_CLASS_DNORM)
+		SPDNORMZ;
+	/* ZERO z cases are handled separately below */
 
-	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_QNAN):
-	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_QNAN):
-	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_QNAN):
-	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_QNAN):
-		return y;
+	switch (CLPAIR(xc, yc)) {
 
-	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
-	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_ZERO):
-	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_NORM):
-	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_DNORM):
-	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_INF):
-		return x;
 
 	/*
 	 * Infinity handling
 	 */
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_ZERO):
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_INF):
-		if (zc == IEEE754_CLASS_QNAN)
-			return z;
 		ieee754_setcx(IEEE754_INVALID_OPERATION);
 		return ieee754sp_indef();
 
@@ -101,8 +85,6 @@ static union ieee754sp _sp_maddf(union i
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_NORM):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
-		if (zc == IEEE754_CLASS_QNAN)
-			return z;
 		return ieee754sp_inf(xs ^ ys);
 
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_ZERO):
@@ -119,25 +101,19 @@ static union ieee754sp _sp_maddf(union i
 		SPDNORMX;
 
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_DNORM):
-		if (zc == IEEE754_CLASS_QNAN)
-			return z;
-		else if (zc == IEEE754_CLASS_INF)
+		if (zc == IEEE754_CLASS_INF)
 			return ieee754sp_inf(zs);
 		SPDNORMY;
 		break;
 
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_NORM):
-		if (zc == IEEE754_CLASS_QNAN)
-			return z;
-		else if (zc == IEEE754_CLASS_INF)
+		if (zc == IEEE754_CLASS_INF)
 			return ieee754sp_inf(zs);
 		SPDNORMX;
 		break;
 
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_NORM):
-		if (zc == IEEE754_CLASS_QNAN)
-			return z;
-		else if (zc == IEEE754_CLASS_INF)
+		if (zc == IEEE754_CLASS_INF)
 			return ieee754sp_inf(zs);
 		/* fall through to real computations */
 	}
