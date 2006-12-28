Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Dec 2006 14:13:37 +0000 (GMT)
Received: from rtsoft2.corbina.net ([85.21.88.2]:12475 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S20047221AbWL1ONc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 28 Dec 2006 14:13:32 +0000
Received: (qmail 3766 invoked from network); 28 Dec 2006 14:14:08 -0000
Received: from laja.dev.rtsoft.ru.dev.rtsoft.ru (HELO laja) (192.168.1.205)
  by mail.dev.rtsoft.ru with SMTP; 28 Dec 2006 14:14:08 -0000
Date:	Thu, 28 Dec 2006 17:14:05 +0300
From:	Vitaly Wool <vitalywool@gmail.com>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: [PATCH][respin] pnx8550: fix system timer support
Message-Id: <20061228171405.b1e3eed8.vitalywool@gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <vitalywool@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13521
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vitalywool@gmail.com
Precedence: bulk
X-list: linux-mips

Hello Ralf,

the patch inlined below restores proper time accounting for PNX8550-based boards. It also gets rid of #ifdef in the generic code which becomes unnecessary then.

It's functionally identical to the previous patch with the same name but it has minor comments from Atsushi and Sergei taken into account.

 arch/mips/kernel/time.c                 |    2 -
 arch/mips/philips/pnx8550/common/time.c |   45 +++++++++++++++++++++++++++-----
 2 files changed, 38 insertions(+), 9 deletions(-)

Signed-off-by: Vitaly Wool <vwool@ru.mvista.com>

Index: linux-mips.git/arch/mips/kernel/time.c
===================================================================
--- linux-mips.git.orig/arch/mips/kernel/time.c
+++ linux-mips.git/arch/mips/kernel/time.c
@@ -94,10 +94,8 @@ static void c0_timer_ack(void)
 {
 	unsigned int count;
 
-#ifndef CONFIG_SOC_PNX8550	/* pnx8550 resets to zero */
 	/* Ack this timer interrupt and set the next one.  */
 	expirelo += cycles_per_jiffy;
-#endif
 	write_c0_compare(expirelo);
 
 	/* Check to see if we have missed any timer interrupts.  */
Index: linux-mips.git/arch/mips/philips/pnx8550/common/time.c
===================================================================
--- linux-mips.git.orig/arch/mips/philips/pnx8550/common/time.c
+++ linux-mips.git/arch/mips/philips/pnx8550/common/time.c
@@ -29,11 +29,22 @@
 #include <asm/hardirq.h>
 #include <asm/div64.h>
 #include <asm/debug.h>
+#include <asm/time.h>
 
 #include <int.h>
 #include <cm.h>
 
-extern unsigned int mips_hpt_frequency;
+static unsigned long cpj;
+
+static cycle_t hpt_read(void)
+{
+	return read_c0_count2();
+}
+
+static void timer_ack(void)
+{
+	write_c0_compare(cpj);
+}
 
 /*
  * pnx8550_time_init() - it does the following things:
@@ -68,27 +79,47 @@ void pnx8550_time_init(void)
 	 * HZ timer interrupts per second.
 	 */
 	mips_hpt_frequency = 27UL * ((1000000UL * n)/(m * pow2p));
+	cpj = (mips_hpt_frequency + HZ / 2) / HZ;
+	timer_ack();
+
+	/* Setup Timer 2 */
+	write_c0_count2(0);
+	write_c0_compare2(0xffffffff);
+
+	clocksource_mips.read = hpt_read;
+	mips_timer_ack = timer_ack;
+}
+
+static irqreturn_t monotonic_interrupt(int irq, void *dev_id)
+{
+	/* Timer 2 clear interrupt */
+	write_c0_compare2(-1);
+	return IRQ_HANDLED;
 }
 
+static struct irqaction monotonic_irqaction = {
+	.handler = monotonic_interrupt,
+	.flags = IRQF_DISABLED,
+	.name = "Monotonic timer",
+};
+
 void __init plat_timer_setup(struct irqaction *irq)
 {
 	int configPR;
 
 	setup_irq(PNX8550_INT_TIMER1, irq);
+	setup_irq(PNX8550_INT_TIMER2, &monotonic_irqaction);
 
-	/* Start timer1 */
+	/* Timer 1 start */
 	configPR = read_c0_config7();
 	configPR &= ~0x00000008;
 	write_c0_config7(configPR);
 
-	/* Timer 2 stop */
+	/* Timer 2 start */
 	configPR = read_c0_config7();
-	configPR |= 0x00000010;
+	configPR &= ~0x00000010;
 	write_c0_config7(configPR);
 
-	write_c0_count2(0);
-	write_c0_compare2(0xffffffff);
-
 	/* Timer 3 stop */
 	configPR = read_c0_config7();
 	configPR |= 0x00000020;
