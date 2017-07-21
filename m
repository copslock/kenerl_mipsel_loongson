Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jul 2017 16:16:12 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:55934 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993969AbdGUONCcrBMG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 21 Jul 2017 16:13:02 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id F11951A46C8;
        Fri, 21 Jul 2017 16:12:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.domain.local (rtrkw197-lin.domain.local [10.10.13.95])
        by mail.rt-rk.com (Postfix) with ESMTPSA id 97E911A4153;
        Fri, 21 Jul 2017 16:12:56 +0200 (CEST)
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
Subject: [PATCH v3 09/16] MIPS: math-emu: <MAXA|MINA>.<D|S>: Fix cases of both infinite inputs
Date:   Fri, 21 Jul 2017 16:09:07 +0200
Message-Id: <1500646206-2436-10-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1500646206-2436-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1500646206-2436-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59185
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

The relevant example:

MAXA.S fd,fs,ft:
  If fs contains +inf, and ft contains -inf, fd is going to contain
  +inf (without this patch, it used to contain -inf).

Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
---
 arch/mips/math-emu/dp_fmax.c | 4 +++-
 arch/mips/math-emu/dp_fmin.c | 4 +++-
 arch/mips/math-emu/sp_fmax.c | 4 +++-
 arch/mips/math-emu/sp_fmin.c | 4 +++-
 4 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/mips/math-emu/dp_fmax.c b/arch/mips/math-emu/dp_fmax.c
index 860b43f9..5459643 100644
--- a/arch/mips/math-emu/dp_fmax.c
+++ b/arch/mips/math-emu/dp_fmax.c
@@ -183,6 +183,9 @@ union ieee754dp ieee754dp_fmaxa(union ieee754dp x, union ieee754dp y)
 	/*
 	 * Infinity and zero handling
 	 */
+	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
+		return ieee754dp_inf(xs & ys);
+
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_ZERO):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_NORM):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
@@ -190,7 +193,6 @@ union ieee754dp ieee754dp_fmaxa(union ieee754dp x, union ieee754dp y)
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_ZERO):
 		return x;
 
-	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_INF):
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_INF):
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_INF):
diff --git a/arch/mips/math-emu/dp_fmin.c b/arch/mips/math-emu/dp_fmin.c
index 73d85e4..d4cd243 100644
--- a/arch/mips/math-emu/dp_fmin.c
+++ b/arch/mips/math-emu/dp_fmin.c
@@ -183,6 +183,9 @@ union ieee754dp ieee754dp_fmina(union ieee754dp x, union ieee754dp y)
 	/*
 	 * Infinity and zero handling
 	 */
+	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
+		return ieee754dp_inf(xs | ys);
+
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_ZERO):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_NORM):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
@@ -190,7 +193,6 @@ union ieee754dp ieee754dp_fmina(union ieee754dp x, union ieee754dp y)
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_ZERO):
 		return x;
 
-	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_INF):
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_INF):
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_INF):
diff --git a/arch/mips/math-emu/sp_fmax.c b/arch/mips/math-emu/sp_fmax.c
index fec7f64..528a90b 100644
--- a/arch/mips/math-emu/sp_fmax.c
+++ b/arch/mips/math-emu/sp_fmax.c
@@ -183,6 +183,9 @@ union ieee754sp ieee754sp_fmaxa(union ieee754sp x, union ieee754sp y)
 	/*
 	 * Infinity and zero handling
 	 */
+	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
+		return ieee754sp_inf(xs & ys);
+
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_ZERO):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_NORM):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
@@ -190,7 +193,6 @@ union ieee754sp ieee754sp_fmaxa(union ieee754sp x, union ieee754sp y)
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_ZERO):
 		return x;
 
-	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_INF):
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_INF):
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_INF):
diff --git a/arch/mips/math-emu/sp_fmin.c b/arch/mips/math-emu/sp_fmin.c
index 74780bc..5f1d650 100644
--- a/arch/mips/math-emu/sp_fmin.c
+++ b/arch/mips/math-emu/sp_fmin.c
@@ -184,6 +184,9 @@ union ieee754sp ieee754sp_fmina(union ieee754sp x, union ieee754sp y)
 	/*
 	 * Infinity and zero handling
 	 */
+	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
+		return ieee754sp_inf(xs | ys);
+
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_ZERO):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_NORM):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
@@ -191,7 +194,6 @@ union ieee754sp ieee754sp_fmina(union ieee754sp x, union ieee754sp y)
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_ZERO):
 		return x;
 
-	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_INF):
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_INF):
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_INF):
-- 
2.7.4
