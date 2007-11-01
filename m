Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Nov 2007 12:52:45 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:58573 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20026791AbXKAMwf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 1 Nov 2007 12:52:35 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1InZXG-0004c5-00; Thu, 01 Nov 2007 13:52:34 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 19EF5C2361; Thu,  1 Nov 2007 13:52:36 +0100 (CET)
Date:	Thu, 1 Nov 2007 13:52:36 +0100
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] JAZZ: disable PIT; cleanup R4030 clockevent
Message-ID: <20071101125236.GA16577@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17350
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

PIT doesn't work, disable it completly
make r4030 clockevent code look like other mips clockevent code

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 97da953..c4f7e60 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -119,7 +119,6 @@ config MACH_JAZZ
 	select CEVT_R4K
 	select GENERIC_ISA_DMA
 	select IRQ_CPU
-	select I8253
 	select I8259
 	select ISA
 	select PCSPEAKER
diff --git a/arch/mips/jazz/irq.c b/arch/mips/jazz/irq.c
index 1dac9e1..a629719 100644
--- a/arch/mips/jazz/irq.c
+++ b/arch/mips/jazz/irq.c
@@ -118,16 +118,16 @@ static void r4030_set_mode(enum clock_event_mode mode,
 struct clock_event_device r4030_clockevent = {
 	.name		= "r4030",
 	.features	= CLOCK_EVT_FEAT_PERIODIC,
-	.rating		= 100,
+	.rating		= 300,
 	.irq		= JAZZ_TIMER_IRQ,
-	.cpumask	= CPU_MASK_CPU0,
 	.set_mode	= r4030_set_mode,
 };
 
 static irqreturn_t r4030_timer_interrupt(int irq, void *dev_id)
 {
-	r4030_clockevent.event_handler(&r4030_clockevent);
+	struct clock_event_device *cd = dev_id;
 
+	cd->event_handler(cd);
 	return IRQ_HANDLED;
 }
 
@@ -135,15 +135,22 @@ static struct irqaction r4030_timer_irqaction = {
 	.handler	= r4030_timer_interrupt,
 	.flags		= IRQF_DISABLED,
 	.mask		= CPU_MASK_CPU0,
-	.name		= "timer",
+	.name		= "R4030 timer",
 };
 
 void __init plat_time_init(void)
 {
-	struct irqaction *irq = &r4030_timer_irqaction;
+	struct clock_event_device *cd = &r4030_clockevent;
+	struct irqaction *action = &r4030_timer_irqaction;
+	unsigned int cpu = smp_processor_id();
 
 	BUG_ON(HZ != 100);
 
+	cd->cpumask             = cpumask_of_cpu(cpu);
+	clockevents_register_device(cd);
+	action->dev_id = cd;
+	setup_irq(JAZZ_TIMER_IRQ, action);
+
 	/*
 	 * Set clock to 100Hz.
 	 *
@@ -151,8 +158,4 @@ void __init plat_time_init(void)
 	 * a programmable 4-bit divider.  This makes it fairly inflexible.
 	 */
 	r4030_write_reg32(JAZZ_TIMER_INTERVAL, 9);
-	setup_irq(JAZZ_TIMER_IRQ, irq);
-
-	clockevents_register_device(&r4030_clockevent);
-	setup_pit_timer();
 }



-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
