Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Apr 2009 16:10:54 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:57563 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022675AbZDWPKp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 23 Apr 2009 16:10:45 +0100
Received: from localhost.localdomain (p8154-ipad310funabasi.chiba.ocn.ne.jp [123.217.210.154])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 7631CA9A8; Fri, 24 Apr 2009 00:10:36 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] TXx9: micro optimization for clocksource and clock_event
Date:	Fri, 24 Apr 2009 00:10:36 +0900
Message-Id: <1240499436-8246-1-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.3
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22441
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Use container structure for clocksource, clock_event_device and hold a
pointer to txx9_tmr_reg in it.

This saves a few instructions in clocksource and clock_event handlers.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/kernel/cevt-txx9.c |   67 +++++++++++++++++++++++++++---------------
 1 files changed, 43 insertions(+), 24 deletions(-)

diff --git a/arch/mips/kernel/cevt-txx9.c b/arch/mips/kernel/cevt-txx9.c
index 2e911e3..0037f21 100644
--- a/arch/mips/kernel/cevt-txx9.c
+++ b/arch/mips/kernel/cevt-txx9.c
@@ -20,22 +20,29 @@
 #define TIMER_CCD	0	/* 1/2 */
 #define TIMER_CLK(imclk)	((imclk) / (2 << TIMER_CCD))
 
-static struct txx9_tmr_reg __iomem *txx9_cs_tmrptr;
+struct txx9_clocksource {
+	struct clocksource cs;
+	struct txx9_tmr_reg __iomem *tmrptr;
+};
 
 static cycle_t txx9_cs_read(struct clocksource *cs)
 {
-	return __raw_readl(&txx9_cs_tmrptr->trr);
+	struct txx9_clocksource *txx9_cs =
+		container_of(cs, struct txx9_clocksource, cs);
+	return __raw_readl(&txx9_cs->tmrptr->trr);
 }
 
 /* Use 1 bit smaller width to use full bits in that width */
 #define TXX9_CLOCKSOURCE_BITS (TXX9_TIMER_BITS - 1)
 
-static struct clocksource txx9_clocksource = {
-	.name		= "TXx9",
-	.rating		= 200,
-	.read		= txx9_cs_read,
-	.mask		= CLOCKSOURCE_MASK(TXX9_CLOCKSOURCE_BITS),
-	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+static struct txx9_clocksource txx9_clocksource = {
+	.cs = {
+		.name		= "TXx9",
+		.rating		= 200,
+		.read		= txx9_cs_read,
+		.mask		= CLOCKSOURCE_MASK(TXX9_CLOCKSOURCE_BITS),
+		.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+	},
 };
 
 void __init txx9_clocksource_init(unsigned long baseaddr,
@@ -43,8 +50,8 @@ void __init txx9_clocksource_init(unsigned long baseaddr,
 {
 	struct txx9_tmr_reg __iomem *tmrptr;
 
-	clocksource_set_clock(&txx9_clocksource, TIMER_CLK(imbusclk));
-	clocksource_register(&txx9_clocksource);
+	clocksource_set_clock(&txx9_clocksource.cs, TIMER_CLK(imbusclk));
+	clocksource_register(&txx9_clocksource.cs);
 
 	tmrptr = ioremap(baseaddr, sizeof(struct txx9_tmr_reg));
 	__raw_writel(TCR_BASE, &tmrptr->tcr);
@@ -53,10 +60,13 @@ void __init txx9_clocksource_init(unsigned long baseaddr,
 	__raw_writel(TXx9_TMITMR_TZCE, &tmrptr->itmr);
 	__raw_writel(1 << TXX9_CLOCKSOURCE_BITS, &tmrptr->cpra);
 	__raw_writel(TCR_BASE | TXx9_TMTCR_TCE, &tmrptr->tcr);
-	txx9_cs_tmrptr = tmrptr;
+	txx9_clocksource.tmrptr = tmrptr;
 }
 
-static struct txx9_tmr_reg __iomem *txx9_tmrptr;
+struct txx9_clock_event_device {
+	struct clock_event_device cd;
+	struct txx9_tmr_reg __iomem *tmrptr;
+};
 
 static void txx9tmr_stop_and_clear(struct txx9_tmr_reg __iomem *tmrptr)
 {
@@ -69,7 +79,9 @@ static void txx9tmr_stop_and_clear(struct txx9_tmr_reg __iomem *tmrptr)
 static void txx9tmr_set_mode(enum clock_event_mode mode,
 			     struct clock_event_device *evt)
 {
-	struct txx9_tmr_reg __iomem *tmrptr = txx9_tmrptr;
+	struct txx9_clock_event_device *txx9_cd =
+		container_of(evt, struct txx9_clock_event_device, cd);
+	struct txx9_tmr_reg __iomem *tmrptr = txx9_cd->tmrptr;
 
 	txx9tmr_stop_and_clear(tmrptr);
 	switch (mode) {
@@ -99,7 +111,9 @@ static void txx9tmr_set_mode(enum clock_event_mode mode,
 static int txx9tmr_set_next_event(unsigned long delta,
 				  struct clock_event_device *evt)
 {
-	struct txx9_tmr_reg __iomem *tmrptr = txx9_tmrptr;
+	struct txx9_clock_event_device *txx9_cd =
+		container_of(evt, struct txx9_clock_event_device, cd);
+	struct txx9_tmr_reg __iomem *tmrptr = txx9_cd->tmrptr;
 
 	txx9tmr_stop_and_clear(tmrptr);
 	/* start timer */
@@ -108,18 +122,22 @@ static int txx9tmr_set_next_event(unsigned long delta,
 	return 0;
 }
 
-static struct clock_event_device txx9tmr_clock_event_device = {
-	.name		= "TXx9",
-	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
-	.rating		= 200,
-	.set_mode	= txx9tmr_set_mode,
-	.set_next_event	= txx9tmr_set_next_event,
+static struct txx9_clock_event_device txx9_clock_event_device = {
+	.cd = {
+		.name		= "TXx9",
+		.features	= CLOCK_EVT_FEAT_PERIODIC |
+				  CLOCK_EVT_FEAT_ONESHOT,
+		.rating		= 200,
+		.set_mode	= txx9tmr_set_mode,
+		.set_next_event	= txx9tmr_set_next_event,
+	},
 };
 
 static irqreturn_t txx9tmr_interrupt(int irq, void *dev_id)
 {
-	struct clock_event_device *cd = &txx9tmr_clock_event_device;
-	struct txx9_tmr_reg __iomem *tmrptr = txx9_tmrptr;
+	struct txx9_clock_event_device *txx9_cd = dev_id;
+	struct clock_event_device *cd = &txx9_cd->cd;
+	struct txx9_tmr_reg __iomem *tmrptr = txx9_cd->tmrptr;
 
 	__raw_writel(0, &tmrptr->tisr);	/* ack interrupt */
 	cd->event_handler(cd);
@@ -130,19 +148,20 @@ static struct irqaction txx9tmr_irq = {
 	.handler	= txx9tmr_interrupt,
 	.flags		= IRQF_DISABLED | IRQF_PERCPU,
 	.name		= "txx9tmr",
+	.dev_id		= &txx9_clock_event_device,
 };
 
 void __init txx9_clockevent_init(unsigned long baseaddr, int irq,
 				 unsigned int imbusclk)
 {
-	struct clock_event_device *cd = &txx9tmr_clock_event_device;
+	struct clock_event_device *cd = &txx9_clock_event_device.cd;
 	struct txx9_tmr_reg __iomem *tmrptr;
 
 	tmrptr = ioremap(baseaddr, sizeof(struct txx9_tmr_reg));
 	txx9tmr_stop_and_clear(tmrptr);
 	__raw_writel(TIMER_CCD, &tmrptr->ccdr);
 	__raw_writel(0, &tmrptr->itmr);
-	txx9_tmrptr = tmrptr;
+	txx9_clock_event_device.tmrptr = tmrptr;
 
 	clockevent_set_clock(cd, TIMER_CLK(imbusclk));
 	cd->max_delta_ns =
-- 
1.5.6.3
