Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jul 2017 16:15:42 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:55917 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993966AbdGUOMzaOvSG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 21 Jul 2017 16:12:55 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id 0E9941A46C8;
        Fri, 21 Jul 2017 16:12:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.domain.local (rtrkw197-lin.domain.local [10.10.13.95])
        by mail.rt-rk.com (Postfix) with ESMTPSA id B646E1A4153;
        Fri, 21 Jul 2017 16:12:49 +0200 (CEST)
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
Subject: [PATCH v3 08/16] MIPS: math-emu: <MAXA|MINA>.<D|S>: Fix cases of input values with opposite signs
Date:   Fri, 21 Jul 2017 16:09:06 +0200
Message-Id: <1500646206-2436-9-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1500646206-2436-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1500646206-2436-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59184
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

Fix the value returned by <MAXA|MINA>.<D|S>, if inputs are normal fp
numbers of the same absolute value, but opposite signs.

The relevant example:

MAXA.S fd,fs,ft:
  If fs contains -3, and ft contains +3, fd is going to contain +3
  (without this patch, it used to contain -3).

Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
---
 arch/mips/math-emu/dp_fmax.c | 8 ++++++--
 arch/mips/math-emu/dp_fmin.c | 6 +++++-
 arch/mips/math-emu/sp_fmax.c | 8 ++++++--
 arch/mips/math-emu/sp_fmin.c | 6 +++++-
 4 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/mips/math-emu/dp_fmax.c b/arch/mips/math-emu/dp_fmax.c
index a0175cc..860b43f9 100644
--- a/arch/mips/math-emu/dp_fmax.c
+++ b/arch/mips/math-emu/dp_fmax.c
@@ -224,7 +224,11 @@ union ieee754dp ieee754dp_fmaxa(union ieee754dp x, union ieee754dp y)
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
diff --git a/arch/mips/math-emu/dp_fmin.c b/arch/mips/math-emu/dp_fmin.c
index 074a858..73d85e4 100644
--- a/arch/mips/math-emu/dp_fmin.c
+++ b/arch/mips/math-emu/dp_fmin.c
@@ -224,7 +224,11 @@ union ieee754dp ieee754dp_fmina(union ieee754dp x, union ieee754dp y)
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
diff --git a/arch/mips/math-emu/sp_fmax.c b/arch/mips/math-emu/sp_fmax.c
index 15825db..fec7f64 100644
--- a/arch/mips/math-emu/sp_fmax.c
+++ b/arch/mips/math-emu/sp_fmax.c
@@ -224,7 +224,11 @@ union ieee754sp ieee754sp_fmaxa(union ieee754sp x, union ieee754sp y)
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
diff --git a/arch/mips/math-emu/sp_fmin.c b/arch/mips/math-emu/sp_fmin.c
index f1418f7..74780bc 100644
--- a/arch/mips/math-emu/sp_fmin.c
+++ b/arch/mips/math-emu/sp_fmin.c
@@ -225,7 +225,11 @@ union ieee754sp ieee754sp_fmina(union ieee754sp x, union ieee754sp y)
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
-- 
2.7.4
