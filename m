Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Sep 2017 22:41:43 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:34498 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990497AbdIXUjJy-4hz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 24 Sep 2017 22:39:09 +0200
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3B40D258;
        Sun, 24 Sep 2017 20:39:03 +0000 (UTC)
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
Subject: [PATCH 4.9 22/77] MIPS: math-emu: <MADDF|MSUBF>.<D|S>: Fix some cases of zero inputs
Date:   Sun, 24 Sep 2017 22:32:07 +0200
Message-Id: <20170924203243.745123797@linuxfoundation.org>
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
X-archive-position: 60131
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

commit 7cf64ce4d37f1b4f44365fcf77f565d523819dcd upstream.

Fix the cases of <MADDF|MSUBF>.<D|S> when any of two multiplicands is
+0 or -0, and the third input is also +0 or -0. Depending on the signs
of inputs, certain special cases must be handled.

A relevant example:

MADDF.S fd,fs,ft:
  If fs contains +0.0, ft contains -0.0, and fd contains 0.0, fd is
  going to contain +0.0 (without this patch, it used to contain -0.0).

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
Patchwork: https://patchwork.linux-mips.org/patch/16888/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/math-emu/dp_maddf.c |   18 +++++++++++++++++-
 arch/mips/math-emu/sp_maddf.c |   18 +++++++++++++++++-
 2 files changed, 34 insertions(+), 2 deletions(-)

--- a/arch/mips/math-emu/dp_maddf.c
+++ b/arch/mips/math-emu/dp_maddf.c
@@ -113,7 +113,23 @@ static union ieee754dp _dp_maddf(union i
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_ZERO):
 		if (zc == IEEE754_CLASS_INF)
 			return ieee754dp_inf(zs);
-		/* Multiplication is 0 so just return z */
+		if (zc == IEEE754_CLASS_ZERO) {
+			/* Handle cases +0 + (-0) and similar ones. */
+			if ((!(flags & maddf_negate_product)
+					&& (zs == (xs ^ ys))) ||
+			    ((flags & maddf_negate_product)
+					&& (zs != (xs ^ ys))))
+				/*
+				 * Cases of addition of zeros of equal signs
+				 * or subtraction of zeroes of opposite signs.
+				 * The sign of the resulting zero is in any
+				 * such case determined only by the sign of z.
+				 */
+				return z;
+
+			return ieee754dp_zero(ieee754_csr.rm == FPU_CSR_RD);
+		}
+		/* x*y is here 0, and z is not 0, so just return z */
 		return z;
 
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_DNORM):
--- a/arch/mips/math-emu/sp_maddf.c
+++ b/arch/mips/math-emu/sp_maddf.c
@@ -114,7 +114,23 @@ static union ieee754sp _sp_maddf(union i
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_ZERO):
 		if (zc == IEEE754_CLASS_INF)
 			return ieee754sp_inf(zs);
-		/* Multiplication is 0 so just return z */
+		if (zc == IEEE754_CLASS_ZERO) {
+			/* Handle cases +0 + (-0) and similar ones. */
+			if ((!(flags & maddf_negate_product)
+					&& (zs == (xs ^ ys))) ||
+			    ((flags & maddf_negate_product)
+					&& (zs != (xs ^ ys))))
+				/*
+				 * Cases of addition of zeros of equal signs
+				 * or subtraction of zeroes of opposite signs.
+				 * The sign of the resulting zero is in any
+				 * such case determined only by the sign of z.
+				 */
+				return z;
+
+			return ieee754sp_zero(ieee754_csr.rm == FPU_CSR_RD);
+		}
+		/* x*y is here 0, and z is not 0, so just return z */
 		return z;
 
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_DNORM):
