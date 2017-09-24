Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Sep 2017 22:37:54 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:33822 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990557AbdIXUhMMFTVz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 24 Sep 2017 22:37:12 +0200
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 82A803EE;
        Sun, 24 Sep 2017 20:37:05 +0000 (UTC)
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
Subject: [PATCH 4.9 13/77] MIPS: math-emu: <MAX|MAXA|MIN|MINA>.<D|S>: Fix quiet NaN propagation
Date:   Sun, 24 Sep 2017 22:31:58 +0200
Message-Id: <20170924203243.407641939@linuxfoundation.org>
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
X-archive-position: 60123
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

commit e78bf0dc4789bdea1453595ae89e8db65918e22e upstream.

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
Reviewed-by: James Hogan <james.hogan@imgtec.com>
Cc: Bo Hu <bohu@google.com>
Cc: Douglas Leung <douglas.leung@imgtec.com>
Cc: Jin Qian <jinqian@google.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Petar Jovanovic <petar.jovanovic@imgtec.com>
Cc: Raghu Gandham <raghu.gandham@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/16880/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/math-emu/dp_fmax.c |   32 ++++++++++++++++++++++++++++----
 arch/mips/math-emu/dp_fmin.c |   32 ++++++++++++++++++++++++++++----
 arch/mips/math-emu/sp_fmax.c |   32 ++++++++++++++++++++++++++++----
 arch/mips/math-emu/sp_fmin.c |   32 ++++++++++++++++++++++++++++----
 4 files changed, 112 insertions(+), 16 deletions(-)

--- a/arch/mips/math-emu/dp_fmax.c
+++ b/arch/mips/math-emu/dp_fmax.c
@@ -47,14 +47,26 @@ union ieee754dp ieee754dp_fmax(union iee
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
@@ -147,14 +159,26 @@ union ieee754dp ieee754dp_fmaxa(union ie
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
--- a/arch/mips/math-emu/dp_fmin.c
+++ b/arch/mips/math-emu/dp_fmin.c
@@ -47,14 +47,26 @@ union ieee754dp ieee754dp_fmin(union iee
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
@@ -147,14 +159,26 @@ union ieee754dp ieee754dp_fmina(union ie
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
--- a/arch/mips/math-emu/sp_fmax.c
+++ b/arch/mips/math-emu/sp_fmax.c
@@ -47,14 +47,26 @@ union ieee754sp ieee754sp_fmax(union iee
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
@@ -147,14 +159,26 @@ union ieee754sp ieee754sp_fmaxa(union ie
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
--- a/arch/mips/math-emu/sp_fmin.c
+++ b/arch/mips/math-emu/sp_fmin.c
@@ -47,14 +47,26 @@ union ieee754sp ieee754sp_fmin(union iee
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
@@ -147,14 +159,26 @@ union ieee754sp ieee754sp_fmina(union ie
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
