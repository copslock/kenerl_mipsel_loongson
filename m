Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Sep 2017 22:47:29 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:34924 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992592AbdIXUk67DSJz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 24 Sep 2017 22:40:58 +0200
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4C075360;
        Sun, 24 Sep 2017 20:40:52 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Douglas Leung <douglas.leung@imgtec.com>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>, Bo Hu <bohu@google.com>,
        Jin Qian <jinqian@google.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.13 024/109] MIPS: math-emu: <MADDF|MSUBF>.<D|S>: Fix some cases of infinite inputs
Date:   Sun, 24 Sep 2017 22:32:45 +0200
Message-Id: <20170924203354.065653792@linuxfoundation.org>
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
X-archive-position: 60143
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

commit 0c64fe6348687f0e1cea9a608eae9d351124a73a upstream.

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
Reviewed-by: James Hogan <james.hogan@imgtec.com>
Cc: Douglas Leung <douglas.leung@imgtec.com>
Cc: Bo Hu <bohu@google.com>
Cc: Jin Qian <jinqian@google.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Petar Jovanovic <petar.jovanovic@imgtec.com>
Cc: Raghu Gandham <raghu.gandham@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/16887/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/math-emu/dp_maddf.c |   22 +++++++++++++++++++++-
 arch/mips/math-emu/sp_maddf.c |   22 +++++++++++++++++++++-
 2 files changed, 42 insertions(+), 2 deletions(-)

--- a/arch/mips/math-emu/dp_maddf.c
+++ b/arch/mips/math-emu/dp_maddf.c
@@ -84,7 +84,27 @@ static union ieee754dp _dp_maddf(union i
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
--- a/arch/mips/math-emu/sp_maddf.c
+++ b/arch/mips/math-emu/sp_maddf.c
@@ -85,7 +85,27 @@ static union ieee754sp _sp_maddf(union i
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
