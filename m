Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Jul 2013 12:02:30 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:50992 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6830580Ab3G2KCXrN5YY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 29 Jul 2013 12:02:23 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH] MIPS: add proper set_mode() to cevt-r4k
Date:   Mon, 29 Jul 2013 11:55:43 +0200
Message-Id: <1375091743-20608-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37384
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

On ralink SoC a secondary cevt exists, that shares irq 7 with the r4k timer.
For this to work, we first need to teach cevt-r4k to not hog the irq.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/kernel/cevt-r4k.c |   39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
index 50d3f5a..b726422 100644
--- a/arch/mips/kernel/cevt-r4k.c
+++ b/arch/mips/kernel/cevt-r4k.c
@@ -38,12 +38,6 @@ static int mips_next_event(unsigned long delta,
 
 #endif /* CONFIG_MIPS_MT_SMTC */
 
-void mips_set_clock_mode(enum clock_event_mode mode,
-				struct clock_event_device *evt)
-{
-	/* Nothing to do ...  */
-}
-
 DEFINE_PER_CPU(struct clock_event_device, mips_clockevent_device);
 int cp0_timer_irq_installed;
 
@@ -90,6 +84,32 @@ struct irqaction c0_compare_irqaction = {
 	.name = "timer",
 };
 
+void mips_set_clock_mode(enum clock_event_mode mode,
+				struct clock_event_device *evt)
+{
+	switch (mode) {
+	case CLOCK_EVT_MODE_ONESHOT:
+		if (cp0_timer_irq_installed)
+			break;
+
+		cp0_timer_irq_installed = 1;
+
+		setup_irq(evt->irq, &c0_compare_irqaction);
+		break;
+
+	case CLOCK_EVT_MODE_SHUTDOWN:
+		if (!cp0_timer_irq_installed)
+			break;
+
+		cp0_timer_irq_installed = 0;
+		free_irq(evt->irq, &c0_compare_irqaction);
+		break;
+
+	default:
+		pr_err("Unhandeled mips clock_mode\n");
+		break;
+	}
+}
 
 void mips_event_handler(struct clock_event_device *dev)
 {
@@ -215,13 +235,6 @@ int r4k_clockevent_init(void)
 #endif
 	clockevents_register_device(cd);
 
-	if (cp0_timer_irq_installed)
-		return 0;
-
-	cp0_timer_irq_installed = 1;
-
-	setup_irq(irq, &c0_compare_irqaction);
-
 	return 0;
 }
 
-- 
1.7.10.4
