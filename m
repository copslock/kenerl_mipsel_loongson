Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Sep 2009 10:41:09 +0200 (CEST)
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52503 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492473AbZIUIlB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 21 Sep 2009 10:41:01 +0200
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1MpeS0-0005L9-LB; Mon, 21 Sep 2009 10:40:48 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1MpeRx-0005yE-B9; Mon, 21 Sep 2009 10:40:45 +0200
From:	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
To:	linux-mips@linux-mips.org, oprofile-list@lists.sf.net
Cc:	Wu Zhangjin <wuzj@lemote.com>, Yanhua <yanh@lemote.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Robert Richter <robert.richter@amd.com>
Subject: [PATCH 3/3] Fix typo "enalbe" -> "enable"
Date:	Mon, 21 Sep 2009 10:40:37 +0200
Message-Id: <1253522437-22919-1-git-send-email-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 1.6.4.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mips@linux-mips.org
Return-Path: <ukl@pengutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24059
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ukl@pengutronix.de
Precedence: bulk
X-list: linux-mips

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: Wu Zhangjin <wuzj@lemote.com>
Cc: Yanhua <yanh@lemote.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Robert Richter <robert.richter@amd.com>
---
 arch/mips/oprofile/op_model_loongson2.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/mips/oprofile/op_model_loongson2.c b/arch/mips/oprofile/op_model_loongson2.c
index 655cb8d..deed1d5 100644
--- a/arch/mips/oprofile/op_model_loongson2.c
+++ b/arch/mips/oprofile/op_model_loongson2.c
@@ -44,7 +44,7 @@ static struct loongson2_register_config {
 	unsigned int ctrl;
 	unsigned long long reset_counter1;
 	unsigned long long reset_counter2;
-	int cnt1_enalbed, cnt2_enalbed;
+	int cnt1_enabled, cnt2_enabled;
 } reg;
 
 DEFINE_SPINLOCK(sample_lock);
@@ -81,8 +81,8 @@ static void loongson2_reg_setup(struct op_counter_config *cfg)
 
 	reg.ctrl = ctrl;
 
-	reg.cnt1_enalbed = cfg[0].enabled;
-	reg.cnt2_enalbed = cfg[1].enabled;
+	reg.cnt1_enabled = cfg[0].enabled;
+	reg.cnt2_enabled = cfg[1].enabled;
 
 }
 
@@ -99,7 +99,7 @@ static void loongson2_cpu_setup(void *args)
 static void loongson2_cpu_start(void *args)
 {
 	/* Start all counters on current CPU */
-	if (reg.cnt1_enalbed || reg.cnt2_enalbed)
+	if (reg.cnt1_enabled || reg.cnt2_enabled)
 		write_c0_perfctrl(reg.ctrl);
 }
 
@@ -125,7 +125,7 @@ static irqreturn_t loongson2_perfcount_handler(int irq, void *dev_id)
 	 */
 
 	/* Check whether the irq belongs to me */
-	enabled = reg.cnt1_enalbed | reg.cnt2_enalbed;
+	enabled = reg.cnt1_enabled | reg.cnt2_enabled;
 	if (!enabled)
 		return IRQ_NONE;
 
@@ -136,12 +136,12 @@ static irqreturn_t loongson2_perfcount_handler(int irq, void *dev_id)
 	spin_lock_irqsave(&sample_lock, flags);
 
 	if (counter1 & LOONGSON2_PERFCNT_OVERFLOW) {
-		if (reg.cnt1_enalbed)
+		if (reg.cnt1_enabled)
 			oprofile_add_sample(regs, 0);
 		counter1 = reg.reset_counter1;
 	}
 	if (counter2 & LOONGSON2_PERFCNT_OVERFLOW) {
-		if (reg.cnt2_enalbed)
+		if (reg.cnt2_enabled)
 			oprofile_add_sample(regs, 1);
 		counter2 = reg.reset_counter2;
 	}
-- 
1.6.4.3
