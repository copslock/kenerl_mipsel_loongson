Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jul 2017 16:16:44 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:55979 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993967AbdGUONId-IJG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 21 Jul 2017 16:13:08 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id 2B7F11A46C8;
        Fri, 21 Jul 2017 16:13:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.domain.local (rtrkw197-lin.domain.local [10.10.13.95])
        by mail.rt-rk.com (Postfix) with ESMTPSA id D28B11A4153;
        Fri, 21 Jul 2017 16:13:02 +0200 (CEST)
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
Subject: [PATCH v3 10/16] MIPS: math-emu: MINA.<D|S>: Fix some cases of infinity and zero inputs
Date:   Fri, 21 Jul 2017 16:09:08 +0200
Message-Id: <1500646206-2436-11-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1500646206-2436-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1500646206-2436-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59186
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

Fix following special cases for MINA>.<D|S>:

  - if one of the inputs is zero, and the other is subnormal, normal,
    or infinity, the  value of the former should be returned (that is,
    a zero).
  - if one of the inputs is infinity, and the other input is normal,
    or subnormal, the value of the latter should be returned.

The previous implementation's logic for such cases was incorrect - it
appears as if it implements MAXA, and not MINA instruction.

The relevant example:

MINA.S fd,fs,ft:
  If fs contains 100.0, and ft contains 0.0, fd is going to contain
  0.0 (without this patch, it used to contain 100.0).

Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
---
 arch/mips/math-emu/dp_fmin.c | 4 ++--
 arch/mips/math-emu/sp_fmin.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/math-emu/dp_fmin.c b/arch/mips/math-emu/dp_fmin.c
index d4cd243..1e9ee3d 100644
--- a/arch/mips/math-emu/dp_fmin.c
+++ b/arch/mips/math-emu/dp_fmin.c
@@ -191,14 +191,14 @@ union ieee754dp ieee754dp_fmina(union ieee754dp x, union ieee754dp y)
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_ZERO):
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_ZERO):
-		return x;
+		return y;
 
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_INF):
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_INF):
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_INF):
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_NORM):
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_DNORM):
-		return y;
+		return x;
 
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_ZERO):
 		return ieee754dp_zero(xs | ys);
diff --git a/arch/mips/math-emu/sp_fmin.c b/arch/mips/math-emu/sp_fmin.c
index 5f1d650..685ce75 100644
--- a/arch/mips/math-emu/sp_fmin.c
+++ b/arch/mips/math-emu/sp_fmin.c
@@ -192,14 +192,14 @@ union ieee754sp ieee754sp_fmina(union ieee754sp x, union ieee754sp y)
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_ZERO):
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_ZERO):
-		return x;
+		return y;
 
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_INF):
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_INF):
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_INF):
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_NORM):
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_DNORM):
-		return y;
+		return x;
 
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_ZERO):
 		return ieee754sp_zero(xs | ys);
-- 
2.7.4
