Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jul 2017 18:14:43 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:57619 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993961AbdG0QMV2Ax09 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 27 Jul 2017 18:12:21 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id DD4AB1A4987;
        Thu, 27 Jul 2017 18:12:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.domain.local (rtrkw197-lin.domain.local [10.10.13.95])
        by mail.rt-rk.com (Postfix) with ESMTPSA id C03D51A4982;
        Thu, 27 Jul 2017 18:12:15 +0200 (CEST)
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
Subject: [PATCH v4 09/16] MIPS: math-emu: <MAXA|MINA>.<D|S>: Fix cases of both infinite inputs
Date:   Thu, 27 Jul 2017 18:08:52 +0200
Message-Id: <1501171791-23690-10-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1501171791-23690-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1501171791-23690-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59293
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
Cc: <stable@vger.kernel.org> # 4.3+
Reviewed-by: James Hogan <james.hogan@imgtec.com>
---
 arch/mips/math-emu/dp_fmax.c | 4 +++-
 arch/mips/math-emu/dp_fmin.c | 4 +++-
 arch/mips/math-emu/sp_fmax.c | 4 +++-
 arch/mips/math-emu/sp_fmin.c | 4 +++-
 4 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/mips/math-emu/dp_fmax.c b/arch/mips/math-emu/dp_fmax.c
index 81d12bf..5bec64f 100644
--- a/arch/mips/math-emu/dp_fmax.c
+++ b/arch/mips/math-emu/dp_fmax.c
@@ -202,6 +202,9 @@ union ieee754dp ieee754dp_fmaxa(union ieee754dp x, union ieee754dp y)
 	/*
 	 * Infinity and zero handling
 	 */
+	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
+		return ieee754dp_inf(xs & ys);
+
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_ZERO):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_NORM):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
@@ -209,7 +212,6 @@ union ieee754dp ieee754dp_fmaxa(union ieee754dp x, union ieee754dp y)
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_ZERO):
 		return x;
 
-	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_INF):
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_INF):
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_INF):
diff --git a/arch/mips/math-emu/dp_fmin.c b/arch/mips/math-emu/dp_fmin.c
index 4574f04..2495bd7 100644
--- a/arch/mips/math-emu/dp_fmin.c
+++ b/arch/mips/math-emu/dp_fmin.c
@@ -202,6 +202,9 @@ union ieee754dp ieee754dp_fmina(union ieee754dp x, union ieee754dp y)
 	/*
 	 * Infinity and zero handling
 	 */
+	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
+		return ieee754dp_inf(xs | ys);
+
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_ZERO):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_NORM):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
@@ -209,7 +212,6 @@ union ieee754dp ieee754dp_fmina(union ieee754dp x, union ieee754dp y)
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_ZERO):
 		return x;
 
-	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_INF):
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_INF):
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_INF):
diff --git a/arch/mips/math-emu/sp_fmax.c b/arch/mips/math-emu/sp_fmax.c
index fb41497..74a5a00 100644
--- a/arch/mips/math-emu/sp_fmax.c
+++ b/arch/mips/math-emu/sp_fmax.c
@@ -202,6 +202,9 @@ union ieee754sp ieee754sp_fmaxa(union ieee754sp x, union ieee754sp y)
 	/*
 	 * Infinity and zero handling
 	 */
+	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
+		return ieee754sp_inf(xs & ys);
+
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_ZERO):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_NORM):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
@@ -209,7 +212,6 @@ union ieee754sp ieee754sp_fmaxa(union ieee754sp x, union ieee754sp y)
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_ZERO):
 		return x;
 
-	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_INF):
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_INF):
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_INF):
diff --git a/arch/mips/math-emu/sp_fmin.c b/arch/mips/math-emu/sp_fmin.c
index 7915b94..42ec431 100644
--- a/arch/mips/math-emu/sp_fmin.c
+++ b/arch/mips/math-emu/sp_fmin.c
@@ -202,6 +202,9 @@ union ieee754sp ieee754sp_fmina(union ieee754sp x, union ieee754sp y)
 	/*
 	 * Infinity and zero handling
 	 */
+	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
+		return ieee754sp_inf(xs | ys);
+
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_ZERO):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_NORM):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
@@ -209,7 +212,6 @@ union ieee754sp ieee754sp_fmina(union ieee754sp x, union ieee754sp y)
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_ZERO):
 		return x;
 
-	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_INF):
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_INF):
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_INF):
-- 
2.7.4
