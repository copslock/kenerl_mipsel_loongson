Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Sep 2017 22:46:01 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:34888 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992533AbdIXUkvTtZaz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 24 Sep 2017 22:40:51 +0200
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A247849B;
        Sun, 24 Sep 2017 20:40:44 +0000 (UTC)
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
Subject: [PATCH 4.13 021/109] MIPS: math-emu: <MAXA|MINA>.<D|S>: Fix cases of both infinite inputs
Date:   Sun, 24 Sep 2017 22:32:42 +0200
Message-Id: <20170924203353.949668884@linuxfoundation.org>
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
X-archive-position: 60140
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

commit 3444c4eb534c20e44f0d6670b34263efaf8b531f upstream.

Fix the value returned by <MAXA|MINA>.<D|S> fd,fs,ft, if both inputs
are infinite. The previous implementation returned always the value
contained in ft in such cases. The correct behavior is specified
in Mips instruction set manual and is as follows:

    fs    ft        MAXA     MINA
  ---------------------------------
    inf   inf        inf      inf
    inf  -inf        inf     -inf
   -inf   inf        inf     -inf
   -inf  -inf       -inf     -inf

A relevant example:

MAXA.S fd,fs,ft:
  If fs contains +inf, and ft contains -inf, fd is going to contain
  +inf (without this patch, it used to contain -inf).

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
Patchwork: https://patchwork.linux-mips.org/patch/16884/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/math-emu/dp_fmax.c |    4 +++-
 arch/mips/math-emu/dp_fmin.c |    4 +++-
 arch/mips/math-emu/sp_fmax.c |    4 +++-
 arch/mips/math-emu/sp_fmin.c |    4 +++-
 4 files changed, 12 insertions(+), 4 deletions(-)

--- a/arch/mips/math-emu/dp_fmax.c
+++ b/arch/mips/math-emu/dp_fmax.c
@@ -202,6 +202,9 @@ union ieee754dp ieee754dp_fmaxa(union ie
 	/*
 	 * Infinity and zero handling
 	 */
+	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
+		return ieee754dp_inf(xs & ys);
+
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_ZERO):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_NORM):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
@@ -209,7 +212,6 @@ union ieee754dp ieee754dp_fmaxa(union ie
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_ZERO):
 		return x;
 
-	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_INF):
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_INF):
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_INF):
--- a/arch/mips/math-emu/dp_fmin.c
+++ b/arch/mips/math-emu/dp_fmin.c
@@ -202,6 +202,9 @@ union ieee754dp ieee754dp_fmina(union ie
 	/*
 	 * Infinity and zero handling
 	 */
+	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
+		return ieee754dp_inf(xs | ys);
+
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_ZERO):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_NORM):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
@@ -209,7 +212,6 @@ union ieee754dp ieee754dp_fmina(union ie
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_ZERO):
 		return x;
 
-	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_INF):
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_INF):
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_INF):
--- a/arch/mips/math-emu/sp_fmax.c
+++ b/arch/mips/math-emu/sp_fmax.c
@@ -202,6 +202,9 @@ union ieee754sp ieee754sp_fmaxa(union ie
 	/*
 	 * Infinity and zero handling
 	 */
+	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
+		return ieee754sp_inf(xs & ys);
+
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_ZERO):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_NORM):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
@@ -209,7 +212,6 @@ union ieee754sp ieee754sp_fmaxa(union ie
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_ZERO):
 		return x;
 
-	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_INF):
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_INF):
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_INF):
--- a/arch/mips/math-emu/sp_fmin.c
+++ b/arch/mips/math-emu/sp_fmin.c
@@ -202,6 +202,9 @@ union ieee754sp ieee754sp_fmina(union ie
 	/*
 	 * Infinity and zero handling
 	 */
+	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
+		return ieee754sp_inf(xs | ys);
+
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_ZERO):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_NORM):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
@@ -209,7 +212,6 @@ union ieee754sp ieee754sp_fmina(union ie
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_ZERO):
 		return x;
 
-	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_INF):
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_INF):
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_INF):
