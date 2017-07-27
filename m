Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jul 2017 18:15:09 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:57634 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994792AbdG0QMZ5RzB9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 27 Jul 2017 18:12:25 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id 5ABAC1A49D9;
        Thu, 27 Jul 2017 18:12:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.domain.local (rtrkw197-lin.domain.local [10.10.13.95])
        by mail.rt-rk.com (Postfix) with ESMTPSA id 3F5B11A49C9;
        Thu, 27 Jul 2017 18:12:20 +0200 (CEST)
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
Subject: [PATCH v4 10/16] MIPS: math-emu: MINA.<D|S>: Fix some cases of infinity and zero inputs
Date:   Thu, 27 Jul 2017 18:08:53 +0200
Message-Id: <1501171791-23690-11-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1501171791-23690-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1501171791-23690-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59294
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

A relevant example:

MINA.S fd,fs,ft:
  If fs contains 100.0, and ft contains 0.0, fd is going to contain
  0.0 (without this patch, it used to contain 100.0).

Fixes: a79f5f9ba508 ("MIPS: math-emu: Add support for the MIPS R6 MAX{, A} FPU instruction")
Fixes: 4e9561b20e2f ("MIPS: math-emu: Add support for the MIPS R6 MIN{, A} FPU instruction")

Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
Cc: <stable@vger.kernel.org> # 4.3+
Reviewed-by: James Hogan <james.hogan@imgtec.com>
---
 arch/mips/math-emu/dp_fmin.c | 4 ++--
 arch/mips/math-emu/sp_fmin.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/math-emu/dp_fmin.c b/arch/mips/math-emu/dp_fmin.c
index 2495bd7..a287b23 100644
--- a/arch/mips/math-emu/dp_fmin.c
+++ b/arch/mips/math-emu/dp_fmin.c
@@ -210,14 +210,14 @@ union ieee754dp ieee754dp_fmina(union ieee754dp x, union ieee754dp y)
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
index 42ec431..c51385f 100644
--- a/arch/mips/math-emu/sp_fmin.c
+++ b/arch/mips/math-emu/sp_fmin.c
@@ -210,14 +210,14 @@ union ieee754sp ieee754sp_fmina(union ieee754sp x, union ieee754sp y)
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
