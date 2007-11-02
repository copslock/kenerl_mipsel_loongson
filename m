Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Nov 2007 10:20:45 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:5065 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20029200AbXKBKUg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 2 Nov 2007 10:20:36 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1Intag-0005et-00; Fri, 02 Nov 2007 11:17:26 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id F360ADF2E2; Fri,  2 Nov 2007 11:17:13 +0100 (CET)
Date:	Fri, 2 Nov 2007 11:17:13 +0100
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] JAZZ: disable PIT; cleanup R4030 clockevent
Message-ID: <20071102101713.GA9110@alpha.franken.de>
References: <20071101125236.GA16577@alpha.franken.de> <20071101150741.GA8570@linux-mips.org> <20071101160210.GA20366@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071101160210.GA20366@linux-mips.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17371
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Thu, Nov 01, 2007 at 04:02:10PM +0000, Ralf Baechle wrote:
> all over the kernel.  I hope this should bring the i2853 to life for you.

it does now, even pit clockevent works now (if you apply the patch
below).

Thomas.


Fix ISA irq acknowledge
make r4030 clockevent code look like other mips clockevent code

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

diff --git a/arch/mips/jazz/irq.c b/arch/mips/jazz/irq.c
index ae25b48..d7f8a78 100644
--- a/arch/mips/jazz/irq.c
+++ b/arch/mips/jazz/irq.c
@@ -97,9 +97,10 @@ asmlinkage void plat_irq_dispatch(void)
 	if (pending & IE_IRQ4) {
 		r4030_read_reg32(JAZZ_TIMER_REGISTER);
 		do_IRQ(JAZZ_TIMER_IRQ);
-	} else if (pending & IE_IRQ2)
-		do_IRQ(r4030_read_reg32(JAZZ_EISA_IRQ_ACK));
-	else if (pending & IE_IRQ1) {
+	} else if (pending & IE_IRQ2) {
+		irq = *(volatile u8 *)JAZZ_EISA_IRQ_ACK;
+		do_IRQ(irq);
+	} else if (pending & IE_IRQ1) {
 		irq = *(volatile u8 *)JAZZ_IO_IRQ_SOURCE >> 2;
 		if (likely(irq > 0))
 			do_IRQ(irq + JAZZ_IRQ_START - 1);
@@ -117,16 +118,16 @@ static void r4030_set_mode(enum clock_event_mode mode,
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
 
@@ -134,15 +135,22 @@ static struct irqaction r4030_timer_irqaction = {
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
@@ -150,8 +158,5 @@ void __init plat_time_init(void)
 	 * a programmable 4-bit divider.  This makes it fairly inflexible.
 	 */
 	r4030_write_reg32(JAZZ_TIMER_INTERVAL, 9);
-	setup_irq(JAZZ_TIMER_IRQ, irq);
-
-	clockevents_register_device(&r4030_clockevent);
 	setup_pit_timer();
 }

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
