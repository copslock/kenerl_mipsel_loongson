Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Sep 2017 22:45:31 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:34876 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992456AbdIXUksuwyrz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 24 Sep 2017 22:40:48 +0200
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3162D266;
        Sun, 24 Sep 2017 20:40:42 +0000 (UTC)
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
Subject: [PATCH 4.13 020/109] MIPS: math-emu: <MAXA|MINA>.<D|S>: Fix cases of input values with opposite signs
Date:   Sun, 24 Sep 2017 22:32:41 +0200
Message-Id: <20170924203353.908697321@linuxfoundation.org>
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
X-archive-position: 60139
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

commit 1a41b3b441508ae63b1a9ec699ec94065739eb60 upstream.

Fix the value returned by <MAXA|MINA>.<D|S>, if the inputs are normal
fp numbers of the same absolute value, but opposite signs.

A relevant example:

MAXA.S fd,fs,ft:
  If fs contains -3.0, and ft contains +3.0, fd is going to contain
  +3.0 (without this patch, it used to contain -3.0).

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
Patchwork: https://patchwork.linux-mips.org/patch/16883/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/math-emu/dp_fmax.c |    8 ++++++--
 arch/mips/math-emu/dp_fmin.c |    6 +++++-
 arch/mips/math-emu/sp_fmax.c |    8 ++++++--
 arch/mips/math-emu/sp_fmin.c |    6 +++++-
 4 files changed, 22 insertions(+), 6 deletions(-)

--- a/arch/mips/math-emu/dp_fmax.c
+++ b/arch/mips/math-emu/dp_fmax.c
@@ -243,7 +243,11 @@ union ieee754dp ieee754dp_fmaxa(union ie
 		return y;
 
 	/* Compare mantissa */
-	if (xm <= ym)
+	if (xm < ym)
 		return y;
-	return x;
+	else if (xm > ym)
+		return x;
+	else if (xs == 0)
+		return x;
+	return y;
 }
--- a/arch/mips/math-emu/dp_fmin.c
+++ b/arch/mips/math-emu/dp_fmin.c
@@ -243,7 +243,11 @@ union ieee754dp ieee754dp_fmina(union ie
 		return x;
 
 	/* Compare mantissa */
-	if (xm <= ym)
+	if (xm < ym)
+		return x;
+	else if (xm > ym)
+		return y;
+	else if (xs == 1)
 		return x;
 	return y;
 }
--- a/arch/mips/math-emu/sp_fmax.c
+++ b/arch/mips/math-emu/sp_fmax.c
@@ -243,7 +243,11 @@ union ieee754sp ieee754sp_fmaxa(union ie
 		return y;
 
 	/* Compare mantissa */
-	if (xm <= ym)
+	if (xm < ym)
 		return y;
-	return x;
+	else if (xm > ym)
+		return x;
+	else if (xs == 0)
+		return x;
+	return y;
 }
--- a/arch/mips/math-emu/sp_fmin.c
+++ b/arch/mips/math-emu/sp_fmin.c
@@ -243,7 +243,11 @@ union ieee754sp ieee754sp_fmina(union ie
 		return x;
 
 	/* Compare mantissa */
-	if (xm <= ym)
+	if (xm < ym)
+		return x;
+	else if (xm > ym)
+		return y;
+	else if (xs == 1)
 		return x;
 	return y;
 }
