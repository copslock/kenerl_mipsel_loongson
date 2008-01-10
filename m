Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Jan 2008 14:10:44 +0000 (GMT)
Received: from fk-out-0910.google.com ([209.85.128.188]:28900 "EHLO
	fk-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S28577372AbYAJOKf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 10 Jan 2008 14:10:35 +0000
Received: by fk-out-0910.google.com with SMTP id f40so485814fka.0
        for <linux-mips@linux-mips.org>; Thu, 10 Jan 2008 06:10:34 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        bh=yBwzo9vS699z78s6SSnpFhPTSWU/klLe4Ia7PJmWrG8=;
        b=RQzYcZdUp7TsK4EvsQ+LtFam6X6Yduhhg1RZ363pdtwvyR1G+atDMyjxnfPJ9AjVpsVmTDUK0hdzcwnLkxCqLGIbAoPiauRAGAEXJKyMBgNhUKw348TZ8y+BRSILCbVKAy7/JBqupfXZCm+CM8y7qRYzoUsfuzUpODp3h8iTHbM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=wgd89hU2EJujmX4db3jYrBohgCJB+RR4COEaS94OtIOhqcVDrYxcyDT/uMGdUbEQZlY/ObrqfIvJThS6OGxNrZ2ur+yt+YT0uaol7T0OMjvGqKPGb7ayXdYAtuwRb3ZL6y5OfPrTT6FdQKrdTzKGd6EwRsoDOK8sCWy5/UVtLlw=
Received: by 10.78.149.15 with SMTP id w15mr2206640hud.72.1199974234552;
        Thu, 10 Jan 2008 06:10:34 -0800 (PST)
Received: from ?89.253.13.228? ( [89.253.13.228])
        by mx.google.com with ESMTPS id e9sm5346443muf.0.2008.01.10.06.10.22
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 10 Jan 2008 06:10:33 -0800 (PST)
Message-ID: <4786273D.7010006@gmail.com>
Date:	Thu, 10 Jan 2008 17:10:05 +0300
From:	Vitaly Wool <vitalywool@gmail.com>
User-Agent: Icedove 1.5.0.12 (X11/20070607)
MIME-Version: 1.0
To:	ralf@linux-mips.org
CC:	linux-mips@linux-mips.org
Subject: pnx8xxx: move to clocksource
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <vitalywool@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17969
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vitalywool@gmail.com
Precedence: bulk
X-list: linux-mips

This patch converts PNX8XXX system timer to clocksource.

 arch/mips/philips/pnx8550/common/time.c |  109 +++++++++++++++++++++-----------
 1 files changed, 72 insertions(+), 37 deletions(-)

Signed-off-by: Vitaly Wool <vitalywool@gmail.com>

Index: linux-2.6/arch/mips/philips/pnx8550/common/time.c
===================================================================
--- linux-2.6.orig/arch/mips/philips/pnx8550/common/time.c
+++ linux-2.6/arch/mips/philips/pnx8550/common/time.c
@@ -22,7 +22,6 @@
 #include <linux/kernel_stat.h>
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
-#include <linux/module.h>
 
 #include <asm/bootinfo.h>
 #include <asm/cpu.h>
@@ -41,11 +40,60 @@ static cycle_t hpt_read(void)
 	return read_c0_count2();
 }
 
+static struct clocksource pnx_clocksource = {
+	.name		= "pnx8xxx",
+	.rating		= 200,
+	.read		= hpt_read,
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
 static void timer_ack(void)
 {
 	write_c0_compare(cpj);
 }
 
+static irqreturn_t pnx8xxx_timer_interrupt(int irq, void *dev_id)
+{
+        struct clock_event_device *c = dev_id;
+
+        /* clear MATCH, signal the event */
+        c->event_handler(c);
+
+	return IRQ_HANDLED;
+}
+
+static struct irqaction pnx8xxx_timer_irq = {
+	.handler	= pnx8xxx_timer_interrupt,
+	.flags		= IRQF_DISABLED | IRQF_PERCPU,
+	.name		= "pnx8xxx_timer",
+};
+
+static irqreturn_t monotonic_interrupt(int irq, void *dev_id)
+{
+	/* Timer 2 clear interrupt */
+	write_c0_compare2(-1);
+	return IRQ_HANDLED;
+}
+
+static struct irqaction monotonic_irqaction = {
+	.handler = monotonic_interrupt,
+	.flags = IRQF_DISABLED,
+	.name = "Monotonic timer",
+};
+
+static int pnx8xxx_set_next_event(unsigned long delta,
+				struct clock_event_device *evt)
+{
+	write_c0_compare(delta);
+	return 0;
+}
+
+static struct clock_event_device pnx8xxx_clockevent = {
+	.name		= "pnx8xxx_clockevent",
+	.features	= CLOCK_EVT_FEAT_ONESHOT,
+	.set_next_event = pnx8xxx_set_next_event,
+};
+
 /*
  * plat_time_init() - it does the following things:
  *
@@ -58,11 +106,34 @@ static void timer_ack(void)
 
 __init void plat_time_init(void)
 {
+	unsigned int             configPR;
 	unsigned int             n;
 	unsigned int             m;
 	unsigned int             p;
 	unsigned int             pow2p;
 
+	clockevents_register_device(&pnx8xxx_clockevent);
+	clocksource_register(&pnx_clocksource);
+
+	setup_irq(PNX8550_INT_TIMER1, &pnx8xxx_timer_irq);
+	setup_irq(PNX8550_INT_TIMER2, &monotonic_irqaction);
+
+	/* Timer 1 start */
+	configPR = read_c0_config7();
+	configPR &= ~0x00000008;
+	write_c0_config7(configPR);
+
+	/* Timer 2 start */
+	configPR = read_c0_config7();
+	configPR &= ~0x00000010;
+	write_c0_config7(configPR);
+
+	/* Timer 3 stop */
+	configPR = read_c0_config7();
+	configPR |= 0x00000020;
+	write_c0_config7(configPR);
+
+
         /* PLL0 sets MIPS clock (PLL1 <=> TM1, PLL6 <=> TM2, PLL5 <=> mem) */
         /* (but only if CLK_MIPS_CTL select value [bits 3:1] is 1:  FIXME) */
 
@@ -87,42 +158,6 @@ __init void plat_time_init(void)
 	write_c0_count2(0);
 	write_c0_compare2(0xffffffff);
 
-	clocksource_mips.read = hpt_read;
-	mips_timer_ack = timer_ack;
-}
-
-static irqreturn_t monotonic_interrupt(int irq, void *dev_id)
-{
-	/* Timer 2 clear interrupt */
-	write_c0_compare2(-1);
-	return IRQ_HANDLED;
 }
 
-static struct irqaction monotonic_irqaction = {
-	.handler = monotonic_interrupt,
-	.flags = IRQF_DISABLED,
-	.name = "Monotonic timer",
-};
 
-void __init plat_timer_setup(struct irqaction *irq)
-{
-	int configPR;
-
-	setup_irq(PNX8550_INT_TIMER1, irq);
-	setup_irq(PNX8550_INT_TIMER2, &monotonic_irqaction);
-
-	/* Timer 1 start */
-	configPR = read_c0_config7();
-	configPR &= ~0x00000008;
-	write_c0_config7(configPR);
-
-	/* Timer 2 start */
-	configPR = read_c0_config7();
-	configPR &= ~0x00000010;
-	write_c0_config7(configPR);
-
-	/* Timer 3 stop */
-	configPR = read_c0_config7();
-	configPR |= 0x00000020;
-	write_c0_config7(configPR);
-}
