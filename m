Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jul 2017 16:14:45 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:55891 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992974AbdGUOMi6L5PG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 21 Jul 2017 16:12:38 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id 722021A4A8B;
        Fri, 21 Jul 2017 16:12:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.domain.local (rtrkw197-lin.domain.local [10.10.13.95])
        by mail.rt-rk.com (Postfix) with ESMTPSA id 31D621A4A85;
        Fri, 21 Jul 2017 16:12:33 +0200 (CEST)
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
Subject: [PATCH v3 06/16] MIPS: math-emu: <MAX|MAXA|MIN|MINA>.<D|S>: Fix cases of both inputs zero
Date:   Fri, 21 Jul 2017 16:09:04 +0200
Message-Id: <1500646206-2436-7-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1500646206-2436-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1500646206-2436-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59182
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
are zeros. The right behavior in such cases is stated in instruction
reference manual and is as follows:

   fs  ft       MAX     MIN       MAXA    MINA
  ---------------------------------------------
    0   0        0       0         0       0
    0  -0        0      -0         0      -0
   -0   0        0      -0         0      -0
   -0  -0       -0      -0        -0      -0

The relevant example:

MAX.S fd,fs,ft:
  If fs contains +0, and ft contains -0, fd is going to contain 0
  (without this patch, it used to contain -0).

Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
---
 arch/mips/math-emu/dp_fmax.c | 8 ++------
 arch/mips/math-emu/dp_fmin.c | 8 ++------
 arch/mips/math-emu/sp_fmax.c | 8 ++------
 arch/mips/math-emu/sp_fmin.c | 8 ++------
 4 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/arch/mips/math-emu/dp_fmax.c b/arch/mips/math-emu/dp_fmax.c
index 567fc33..9517572 100644
--- a/arch/mips/math-emu/dp_fmax.c
+++ b/arch/mips/math-emu/dp_fmax.c
@@ -82,9 +82,7 @@ union ieee754dp ieee754dp_fmax(union ieee754dp x, union ieee754dp y)
 		return ys ? x : y;
 
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_ZERO):
-		if (xs == ys)
-			return x;
-		return ieee754dp_zero(1);
+		return ieee754dp_zero(xs & ys);
 
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_DNORM):
 		DPDNORMX;
@@ -184,9 +182,7 @@ union ieee754dp ieee754dp_fmaxa(union ieee754dp x, union ieee754dp y)
 		return y;
 
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_ZERO):
-		if (xs == ys)
-			return x;
-		return ieee754dp_zero(1);
+		return ieee754dp_zero(xs & ys);
 
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_DNORM):
 		DPDNORMX;
diff --git a/arch/mips/math-emu/dp_fmin.c b/arch/mips/math-emu/dp_fmin.c
index 77f7ca9..7069320 100644
--- a/arch/mips/math-emu/dp_fmin.c
+++ b/arch/mips/math-emu/dp_fmin.c
@@ -82,9 +82,7 @@ union ieee754dp ieee754dp_fmin(union ieee754dp x, union ieee754dp y)
 		return ys ? y : x;
 
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_ZERO):
-		if (xs == ys)
-			return x;
-		return ieee754dp_zero(1);
+		return ieee754dp_zero(xs | ys);
 
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_DNORM):
 		DPDNORMX;
@@ -184,9 +182,7 @@ union ieee754dp ieee754dp_fmina(union ieee754dp x, union ieee754dp y)
 		return y;
 
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_ZERO):
-		if (xs == ys)
-			return x;
-		return ieee754dp_zero(1);
+		return ieee754dp_zero(xs | ys);
 
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_DNORM):
 		DPDNORMX;
diff --git a/arch/mips/math-emu/sp_fmax.c b/arch/mips/math-emu/sp_fmax.c
index d46e8e4..d72111a 100644
--- a/arch/mips/math-emu/sp_fmax.c
+++ b/arch/mips/math-emu/sp_fmax.c
@@ -82,9 +82,7 @@ union ieee754sp ieee754sp_fmax(union ieee754sp x, union ieee754sp y)
 		return ys ? x : y;
 
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_ZERO):
-		if (xs == ys)
-			return x;
-		return ieee754sp_zero(1);
+		return ieee754sp_zero(xs & ys);
 
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_DNORM):
 		SPDNORMX;
@@ -184,9 +182,7 @@ union ieee754sp ieee754sp_fmaxa(union ieee754sp x, union ieee754sp y)
 		return y;
 
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_ZERO):
-		if (xs == ys)
-			return x;
-		return ieee754sp_zero(1);
+		return ieee754sp_zero(xs & ys);
 
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_DNORM):
 		SPDNORMX;
diff --git a/arch/mips/math-emu/sp_fmin.c b/arch/mips/math-emu/sp_fmin.c
index b528c4b..61ff9c6 100644
--- a/arch/mips/math-emu/sp_fmin.c
+++ b/arch/mips/math-emu/sp_fmin.c
@@ -82,9 +82,7 @@ union ieee754sp ieee754sp_fmin(union ieee754sp x, union ieee754sp y)
 		return ys ? y : x;
 
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_ZERO):
-		if (xs == ys)
-			return x;
-		return ieee754sp_zero(1);
+		return ieee754sp_zero(xs | ys);
 
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_DNORM):
 		SPDNORMX;
@@ -184,9 +182,7 @@ union ieee754sp ieee754sp_fmina(union ieee754sp x, union ieee754sp y)
 		return y;
 
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_ZERO):
-		if (xs == ys)
-			return x;
-		return ieee754sp_zero(1);
+		return ieee754sp_zero(xs | ys);
 
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_DNORM):
 		SPDNORMX;
-- 
2.7.4
