Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jul 2017 18:16:02 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:57683 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994817AbdG0QMgqIcq9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 27 Jul 2017 18:12:36 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id 440CA1A49F0;
        Thu, 27 Jul 2017 18:12:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.domain.local (rtrkw197-lin.domain.local [10.10.13.95])
        by mail.rt-rk.com (Postfix) with ESMTPSA id 283691A49C4;
        Thu, 27 Jul 2017 18:12:31 +0200 (CEST)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org
Cc:     Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        Douglas Leung <douglas.leung@imgtec.com>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        "# 4 . 7+" <stable@vger.kernel.org>, Bo Hu <bohu@google.com>,
        James Hogan <james.hogan@imgtec.com>,
        Jin Qian <jinqian@google.com>, linux-kernel@vger.kernel.org,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v4 12/16] MIPS: math-emu: <MADDF|MSUBF>.<D|S>: Fix some cases of infinite inputs
Date:   Thu, 27 Jul 2017 18:08:55 +0200
Message-Id: <1501171791-23690-13-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1501171791-23690-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1501171791-23690-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59296
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

Fix the cases of <MADDF|MSUBF>.<D|S> when any of two multiplicands is
infinity. The correct behavior in such cases is affected by the nature
of third input. Cases of addition of infinities with opposite signs
and subtraction of infinities with same signs may arise and must be
handles separately. Also, the value od flags argument (that determines
whether the instruction is MADDF or MSUBF) affects the outcome.

Relevant examples:

MADDF.S fd,fs,ft:
  If fs contains +inf, ft contains +inf, and fd contains -inf, fd is
  going to contain indef (without this patch, it used to contain
  -inf).

MSUBF.S fd,fs,ft:
  If fs contains +inf, ft contains 1.0, and fd contains +0.0, fd is
  going to contain -inf (without this patch, it used to contain +inf).

Fixes: e24c3bec3e8e ("MIPS: math-emu: Add support for the MIPS R6 MADDF FPU instruction")
Fixes: 83d43305a1df ("MIPS: math-emu: Add support for the MIPS R6 MSUBF FPU instruction")

Signed-off-by: Douglas Leung <douglas.leung@imgtec.com>
Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
Cc: <stable@vger.kernel.org> # 4.7+
Reviewed-by: James Hogan <james.hogan@imgtec.com>
---
 arch/mips/math-emu/dp_maddf.c | 22 +++++++++++++++++++++-
 arch/mips/math-emu/sp_maddf.c | 22 +++++++++++++++++++++-
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/arch/mips/math-emu/dp_maddf.c b/arch/mips/math-emu/dp_maddf.c
index 8b1bd42..557a0a1 100644
--- a/arch/mips/math-emu/dp_maddf.c
+++ b/arch/mips/math-emu/dp_maddf.c
@@ -84,7 +84,27 @@ static union ieee754dp _dp_maddf(union ieee754dp z, union ieee754dp x,
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_NORM):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
-		return ieee754dp_inf(xs ^ ys);
+		if ((zc == IEEE754_CLASS_INF) &&
+		    ((!(flags & maddf_negate_product) && (zs != (xs ^ ys))) ||
+		     ((flags & maddf_negate_product) && (zs == (xs ^ ys))))) {
+			/*
+			 * Cases of addition of infinities with opposite signs
+			 * or subtraction of infinities with same signs.
+			 */
+			ieee754_setcx(IEEE754_INVALID_OPERATION);
+			return ieee754dp_indef();
+		}
+		/*
+		 * z is here either not an infinity, or an infinity having the
+		 * same sign as product (x*y) (in case of MADDF.D instruction)
+		 * or product -(x*y) (in MSUBF.D case). The result must be an
+		 * infinity, and its sign is determined only by the value of
+		 * (flags & maddf_negate_product) and the signs of x and y.
+		 */
+		if (flags & maddf_negate_product)
+			return ieee754dp_inf(1 ^ (xs ^ ys));
+		else
+			return ieee754dp_inf(xs ^ ys);
 
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_ZERO):
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_NORM):
diff --git a/arch/mips/math-emu/sp_maddf.c b/arch/mips/math-emu/sp_maddf.c
index 6cdaa2a..0d8d25f 100644
--- a/arch/mips/math-emu/sp_maddf.c
+++ b/arch/mips/math-emu/sp_maddf.c
@@ -85,7 +85,27 @@ static union ieee754sp _sp_maddf(union ieee754sp z, union ieee754sp x,
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_NORM):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
-		return ieee754sp_inf(xs ^ ys);
+		if ((zc == IEEE754_CLASS_INF) &&
+		    ((!(flags & maddf_negate_product) && (zs != (xs ^ ys))) ||
+		     ((flags & maddf_negate_product) && (zs == (xs ^ ys))))) {
+			/*
+			 * Cases of addition of infinities with opposite signs
+			 * or subtraction of infinities with same signs.
+			 */
+			ieee754_setcx(IEEE754_INVALID_OPERATION);
+			return ieee754sp_indef();
+		}
+		/*
+		 * z is here either not an infinity, or an infinity having the
+		 * same sign as product (x*y) (in case of MADDF.D instruction)
+		 * or product -(x*y) (in MSUBF.D case). The result must be an
+		 * infinity, and its sign is determined only by the value of
+		 * (flags & maddf_negate_product) and the signs of x and y.
+		 */
+		if (flags & maddf_negate_product)
+			return ieee754sp_inf(1 ^ (xs ^ ys));
+		else
+			return ieee754sp_inf(xs ^ ys);
 
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_ZERO):
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_NORM):
-- 
2.7.4
