Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Oct 2007 17:32:32 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:47355 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20032084AbXJXQcW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 24 Oct 2007 17:32:22 +0100
Received: from localhost (p1200-ipad310funabasi.chiba.ocn.ne.jp [123.217.203.200])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 2CAE8A92D; Thu, 25 Oct 2007 01:32:15 +0900 (JST)
Date:	Thu, 25 Oct 2007 01:34:09 +0900 (JST)
Message-Id: <20071025.013409.26096880.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] txx9tmr clockevent/clocksource driver (take 2)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17199
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Convert jmr3927_clock_event_device to more generic
txx9tmr_clock_event_device which supports one-shot mode.  The
txx9tmr_clock_event_device can be used for TX49 too if the cp0 timer
interrupt was not available.

Convert jmr3927_hpt_read to txx9_clocksource driver which does not
depends jiffies anymore.  The txx9_clocksource itself can be used for
TX49, but normally TX49 uses higher precision clocksource_mips.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
Changes from "take 1" (suggested by Sergei Shtylyov)

* Define TXX9_CLOCKSOURCE_BITS and add a comment.
* Remove #ifdef around txx9_clocksource.  It can be used for TX49 too.
* Move TXX9_TIMER_BITS into txx9tmr.h.
* Fix typo.

 arch/mips/Kconfig                                  |    6 +
 arch/mips/jmr3927/rbhma3100/setup.c                |   83 +---------
 arch/mips/kernel/Makefile                          |    1 +
 arch/mips/kernel/cevt-txx9.c                       |  171 ++++++++++++++++++++
 .../toshiba_rbtx4927/toshiba_rbtx4927_setup.c      |   17 +-
 arch/mips/tx4938/toshiba_rbtx4938/setup.c          |   19 +--
 include/asm-mips/jmr3927/jmr3927.h                 |    9 +-
 include/asm-mips/jmr3927/tx3927.h                  |    4 +-
 include/asm-mips/jmr3927/txx927.h                  |   37 -----
 include/asm-mips/tx4927/tx4927_pci.h               |    3 +
 include/asm-mips/tx4938/tx4938.h                   |    1 -
 include/asm-mips/txx9tmr.h                         |   67 ++++++++
 12 files changed, 273 insertions(+), 145 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 61262c5..97da953 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -583,6 +583,7 @@ config SNI_RM
 
 config TOSHIBA_JMR3927
 	bool "Toshiba JMR-TX3927 board"
+	select CEVT_TXX9
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
 	select MIPS_TX3927
@@ -597,6 +598,7 @@ config TOSHIBA_JMR3927
 config TOSHIBA_RBTX4927
 	bool "Toshiba RBTX49[23]7 board"
 	select CEVT_R4K
+	select CEVT_TXX9
 	select DMA_NONCOHERENT
 	select HAS_TXX9_SERIAL
 	select HW_HAS_PCI
@@ -618,6 +620,7 @@ config TOSHIBA_RBTX4927
 config TOSHIBA_RBTX4938
 	bool "Toshiba RBTX4938 board"
 	select CEVT_R4K
+	select CEVT_TXX9
 	select DMA_NONCOHERENT
 	select HAS_TXX9_SERIAL
 	select HW_HAS_PCI
@@ -736,6 +739,9 @@ config CEVT_GT641XX
 config CEVT_R4K
 	bool
 
+config CEVT_TXX9
+	bool
+
 config CFE
 	bool
 
diff --git a/arch/mips/jmr3927/rbhma3100/setup.c b/arch/mips/jmr3927/rbhma3100/setup.c
index edb9e59..06e01c8 100644
--- a/arch/mips/jmr3927/rbhma3100/setup.c
+++ b/arch/mips/jmr3927/rbhma3100/setup.c
@@ -27,17 +27,13 @@
  * Copyright (C) 2007 Ralf Baechle (ralf@linux-mips.org)
  */
 
-#include <linux/clockchips.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/kdev_t.h>
 #include <linux/types.h>
-#include <linux/sched.h>
 #include <linux/pci.h>
 #include <linux/ide.h>
-#include <linux/irq.h>
 #include <linux/ioport.h>
-#include <linux/param.h>	/* for HZ */
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/platform_device.h>
@@ -48,17 +44,13 @@
 #endif
 
 #include <asm/addrspace.h>
-#include <asm/time.h>
+#include <asm/txx9tmr.h>
 #include <asm/reboot.h>
 #include <asm/jmr3927/jmr3927.h>
 #include <asm/mipsregs.h>
 
 extern void puts(const char *cp);
 
-/* Tick Timer divider */
-#define JMR3927_TIMER_CCD	0	/* 1/2 */
-#define JMR3927_TIMER_CLK	(JMR3927_IMCLK / (2 << JMR3927_TIMER_CCD))
-
 /* don't enable - see errata */
 static int jmr3927_ccfg_toeon;
 
@@ -93,66 +85,12 @@ static void jmr3927_machine_power_off(void)
 	while (1);
 }
 
-static cycle_t jmr3927_hpt_read(void)
-{
-	/* We assume this function is called xtime_lock held. */
-	return jiffies * (JMR3927_TIMER_CLK / HZ) + jmr3927_tmrptr->trr;
-}
-
-static void jmr3927_set_mode(enum clock_event_mode mode,
-	struct clock_event_device *evt)
-{
-	/* Nothing to do here */
-}
-
-struct clock_event_device jmr3927_clock_event_device = {
-	.name		= "MIPS",
-	.features	= CLOCK_EVT_FEAT_PERIODIC,
-	.shift		= 32,
-	.rating		= 300,
-	.cpumask	= CPU_MASK_CPU0,
-	.irq		= JMR3927_IRQ_TICK,
-	.set_mode	= jmr3927_set_mode,
-};
-
-static irqreturn_t jmr3927_timer_interrupt(int irq, void *dev_id)
-{
-	struct clock_event_device *cd = &jmr3927_clock_event_device;
-
-	jmr3927_tmrptr->tisr = 0;       /* ack interrupt */
-
-	cd->event_handler(cd);
-
-	return IRQ_HANDLED;
-}
-
-static struct irqaction jmr3927_timer_irqaction = {
-	.handler	= jmr3927_timer_interrupt,
-	.flags		= IRQF_DISABLED | IRQF_PERCPU,
-	.name		= "jmr3927-timer",
-};
-
 void __init plat_time_init(void)
 {
-	struct clock_event_device *cd;
-
-	clocksource_mips.read = jmr3927_hpt_read;
-	mips_hpt_frequency = JMR3927_TIMER_CLK;
-
-	jmr3927_tmrptr->cpra = JMR3927_TIMER_CLK / HZ;
-	jmr3927_tmrptr->itmr = TXx927_TMTITMR_TIIE | TXx927_TMTITMR_TZCE;
-	jmr3927_tmrptr->ccdr = JMR3927_TIMER_CCD;
-	jmr3927_tmrptr->tcr =
-		TXx927_TMTCR_TCE | TXx927_TMTCR_CCDE | TXx927_TMTCR_TMODE_ITVL;
-
-	cd = &jmr3927_clock_event_device;
-	/* Calculate the min / max delta */
-	cd->mult = div_sc((unsigned long) JMR3927_IMCLK, NSEC_PER_SEC, 32);
-	cd->max_delta_ns	= clockevent_delta2ns(0x7fffffff, cd);
-	cd->min_delta_ns	= clockevent_delta2ns(0x300, cd);
-	clockevents_register_device(cd);
-
-	setup_irq(JMR3927_IRQ_TICK, &jmr3927_timer_irqaction);
+	txx9_clockevent_init(TX3927_TMR_REG(0),
+			     TXX9_IRQ_BASE + JMR3927_IRQ_IRC_TMR(0),
+			     JMR3927_IMCLK);
+	txx9_clocksource_init(TX3927_TMR_REG(1), JMR3927_IMCLK);
 }
 
 #define DO_WRITE_THROUGH
@@ -317,15 +255,8 @@ static void __init tx3927_setup(void)
 	       tx3927_ccfgptr->ccfg, tx3927_ccfgptr->pcfg);
 
 	/* TMR */
-	/* disable all timers */
-	for (i = 0; i < TX3927_NR_TMR; i++) {
-		tx3927_tmrptr(i)->tcr = TXx927_TMTCR_CRE;
-		tx3927_tmrptr(i)->tisr = 0;
-		tx3927_tmrptr(i)->cpra = 0xffffffff;
-		tx3927_tmrptr(i)->itmr = 0;
-		tx3927_tmrptr(i)->ccdr = 0;
-		tx3927_tmrptr(i)->pgmr = 0;
-	}
+	for (i = 0; i < TX3927_NR_TMR; i++)
+		txx9_tmr_init(TX3927_TMR_REG(i));
 
 	/* DMA */
 	tx3927_dmaptr->mcr = 0;
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index d7745c8..3196509 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -10,6 +10,7 @@ obj-y		+= cpu-probe.o branch.o entry.o genex.o irq.o process.o \
 
 obj-$(CONFIG_CEVT_R4K)		+= cevt-r4k.o
 obj-$(CONFIG_CEVT_GT641XX)	+= cevt-gt641xx.o
+obj-$(CONFIG_CEVT_TXX9)		+= cevt-txx9.o
 
 binfmt_irix-objs	:= irixelf.o irixinv.o irixioctl.o irixsig.o	\
 			   irix5sys.o sysirix.o
diff --git a/arch/mips/kernel/cevt-txx9.c b/arch/mips/kernel/cevt-txx9.c
new file mode 100644
index 0000000..795cb8f
--- /dev/null
+++ b/arch/mips/kernel/cevt-txx9.c
@@ -0,0 +1,171 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Based on linux/arch/mips/kernel/cevt-r4k.c,
+ *          linux/arch/mips/jmr3927/rbhma3100/setup.c
+ *
+ * Copyright 2001 MontaVista Software Inc.
+ * Copyright (C) 2000-2001 Toshiba Corporation
+ * Copyright (C) 2007 MIPS Technologies, Inc.
+ * Copyright (C) 2007 Ralf Baechle <ralf@linux-mips.org>
+ */
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <asm/time.h>
+#include <asm/txx9tmr.h>
+
+#define TCR_BASE (TXx9_TMTCR_CCDE | TXx9_TMTCR_CRE | TXx9_TMTCR_TMODE_ITVL)
+#define TIMER_CCD	0	/* 1/2 */
+#define TIMER_CLK(imclk)	((imclk) / (2 << TIMER_CCD))
+
+static struct txx9_tmr_reg __iomem *txx9_cs_tmrptr;
+
+static cycle_t txx9_cs_read(void)
+{
+	return __raw_readl(&txx9_cs_tmrptr->trr);
+}
+
+/* Use 1 bit smaller width to use full bits in that width */
+#define TXX9_CLOCKSOURCE_BITS (TXX9_TIMER_BITS - 1)
+
+static struct clocksource txx9_clocksource = {
+	.name		= "TXx9",
+	.rating		= 200,
+	.read		= txx9_cs_read,
+	.mask		= CLOCKSOURCE_MASK(TXX9_CLOCKSOURCE_BITS),
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+void __init txx9_clocksource_init(unsigned long baseaddr,
+				  unsigned int imbusclk)
+{
+	struct txx9_tmr_reg __iomem *tmrptr;
+
+	clocksource_set_clock(&txx9_clocksource, TIMER_CLK(imbusclk));
+	clocksource_register(&txx9_clocksource);
+
+	tmrptr = ioremap(baseaddr, sizeof(struct txx9_tmr_reg));
+	__raw_writel(TCR_BASE, &tmrptr->tcr);
+	__raw_writel(0, &tmrptr->tisr);
+	__raw_writel(TIMER_CCD, &tmrptr->ccdr);
+	__raw_writel(TXx9_TMITMR_TZCE, &tmrptr->itmr);
+	__raw_writel(1 << TXX9_CLOCKSOURCE_BITS, &tmrptr->cpra);
+	__raw_writel(TCR_BASE | TXx9_TMTCR_TCE, &tmrptr->tcr);
+	txx9_cs_tmrptr = tmrptr;
+}
+
+static struct txx9_tmr_reg __iomem *txx9_tmrptr;
+
+static void txx9tmr_stop_and_clear(struct txx9_tmr_reg __iomem *tmrptr)
+{
+	/* stop and reset counter */
+	__raw_writel(TCR_BASE, &tmrptr->tcr);
+	/* clear pending interrupt */
+	__raw_writel(0, &tmrptr->tisr);
+}
+
+static void txx9tmr_set_mode(enum clock_event_mode mode,
+			     struct clock_event_device *evt)
+{
+	struct txx9_tmr_reg __iomem *tmrptr = txx9_tmrptr;
+
+	txx9tmr_stop_and_clear(tmrptr);
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		__raw_writel(TXx9_TMITMR_TIIE | TXx9_TMITMR_TZCE,
+			     &tmrptr->itmr);
+		/* start timer */
+		__raw_writel(((u64)(NSEC_PER_SEC / HZ) * evt->mult) >>
+			     evt->shift,
+			     &tmrptr->cpra);
+		__raw_writel(TCR_BASE | TXx9_TMTCR_TCE, &tmrptr->tcr);
+		break;
+	case CLOCK_EVT_MODE_SHUTDOWN:
+	case CLOCK_EVT_MODE_UNUSED:
+		__raw_writel(0, &tmrptr->itmr);
+		break;
+	case CLOCK_EVT_MODE_ONESHOT:
+		__raw_writel(TXx9_TMITMR_TIIE, &tmrptr->itmr);
+		break;
+	case CLOCK_EVT_MODE_RESUME:
+		__raw_writel(TIMER_CCD, &tmrptr->ccdr);
+		__raw_writel(0, &tmrptr->itmr);
+		break;
+	}
+}
+
+static int txx9tmr_set_next_event(unsigned long delta,
+				  struct clock_event_device *evt)
+{
+	struct txx9_tmr_reg __iomem *tmrptr = txx9_tmrptr;
+
+	txx9tmr_stop_and_clear(tmrptr);
+	/* start timer */
+	__raw_writel(delta, &tmrptr->cpra);
+	__raw_writel(TCR_BASE | TXx9_TMTCR_TCE, &tmrptr->tcr);
+	return 0;
+}
+
+static struct clock_event_device txx9tmr_clock_event_device = {
+	.name		= "TXx9",
+	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
+	.rating		= 200,
+	.cpumask	= CPU_MASK_CPU0,
+	.set_mode	= txx9tmr_set_mode,
+	.set_next_event	= txx9tmr_set_next_event,
+};
+
+static irqreturn_t txx9tmr_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *cd = &txx9tmr_clock_event_device;
+	struct txx9_tmr_reg __iomem *tmrptr = txx9_tmrptr;
+
+	__raw_writel(0, &tmrptr->tisr);	/* ack interrupt */
+	cd->event_handler(cd);
+	return IRQ_HANDLED;
+}
+
+static struct irqaction txx9tmr_irq = {
+	.handler	= txx9tmr_interrupt,
+	.flags		= IRQF_DISABLED | IRQF_PERCPU,
+	.name		= "txx9tmr",
+};
+
+void __init txx9_clockevent_init(unsigned long baseaddr, int irq,
+				 unsigned int imbusclk)
+{
+	struct clock_event_device *cd = &txx9tmr_clock_event_device;
+	struct txx9_tmr_reg __iomem *tmrptr;
+
+	tmrptr = ioremap(baseaddr, sizeof(struct txx9_tmr_reg));
+	txx9tmr_stop_and_clear(tmrptr);
+	__raw_writel(TIMER_CCD, &tmrptr->ccdr);
+	__raw_writel(0, &tmrptr->itmr);
+	txx9_tmrptr = tmrptr;
+
+	clockevent_set_clock(cd, TIMER_CLK(imbusclk));
+	cd->max_delta_ns =
+		clockevent_delta2ns(0xffffffff >> (32 - TXX9_TIMER_BITS), cd);
+	cd->min_delta_ns = clockevent_delta2ns(0xf, cd);
+	cd->irq = irq;
+	clockevents_register_device(cd);
+	setup_irq(irq, &txx9tmr_irq);
+	printk(KERN_INFO "TXx9: clockevent device at 0x%lx, irq %d\n",
+	       baseaddr, irq);
+}
+
+void __init txx9_tmr_init(unsigned long baseaddr)
+{
+	struct txx9_tmr_reg __iomem *tmrptr;
+
+	tmrptr = ioremap(baseaddr, sizeof(struct txx9_tmr_reg));
+	__raw_writel(TXx9_TMTCR_CRE, &tmrptr->tcr);
+	__raw_writel(0, &tmrptr->tisr);
+	__raw_writel(0xffffffff, &tmrptr->cpra);
+	__raw_writel(0, &tmrptr->itmr);
+	__raw_writel(0, &tmrptr->ccdr);
+	__raw_writel(0, &tmrptr->pgmr);
+	iounmap(tmrptr);
+}
diff --git a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
index c7470fb..0299595 100644
--- a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
+++ b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
@@ -63,6 +63,7 @@
 #include <asm/processor.h>
 #include <asm/reboot.h>
 #include <asm/time.h>
+#include <asm/txx9tmr.h>
 #include <linux/bootmem.h>
 #include <linux/blkdev.h>
 #ifdef CONFIG_TOSHIBA_FPCIB0
@@ -93,7 +94,6 @@
 
 #define TOSHIBA_RBTX4927_SETUP_EFWFU       ( 1 <<  3 )
 #define TOSHIBA_RBTX4927_SETUP_SETUP       ( 1 <<  4 )
-#define TOSHIBA_RBTX4927_SETUP_TIME_INIT   ( 1 <<  5 )
 #define TOSHIBA_RBTX4927_SETUP_PCIBIOS     ( 1 <<  7 )
 #define TOSHIBA_RBTX4927_SETUP_PCI1        ( 1 <<  8 )
 #define TOSHIBA_RBTX4927_SETUP_PCI2        ( 1 <<  9 )
@@ -130,7 +130,6 @@ extern void toshiba_rbtx4927_power_off(void);
 
 int tx4927_using_backplane = 0;
 
-extern void gt64120_time_init(void);
 extern void toshiba_rbtx4927_irq_setup(void);
 
 char *prom_getcmdline(void);
@@ -721,6 +720,7 @@ void toshiba_rbtx4927_power_off(void)
 
 void __init toshiba_rbtx4927_setup(void)
 {
+	int i;
 	u32 cp0_config;
 	char *argptr;
 
@@ -764,6 +764,9 @@ void __init toshiba_rbtx4927_setup(void)
 	_machine_halt = toshiba_rbtx4927_halt;
 	pm_power_off = toshiba_rbtx4927_power_off;
 
+	for (i = 0; i < TX4927_NR_TMR; i++)
+		txx9_tmr_init(TX4927_TMR_REG(0) & 0xfffffffffULL);
+
 #ifdef CONFIG_PCI
 
 	/* PCIC */
@@ -892,7 +895,6 @@ void __init toshiba_rbtx4927_setup(void)
 #ifdef CONFIG_SERIAL_TXX9
 	{
 		extern int early_serial_txx9_setup(struct uart_port *port);
-		int i;
 		struct uart_port req;
 		for(i = 0; i < 2; i++) {
 			memset(&req, 0, sizeof(req));
@@ -937,12 +939,11 @@ void __init toshiba_rbtx4927_setup(void)
 void __init
 toshiba_rbtx4927_time_init(void)
 {
-	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_TIME_INIT, "-\n");
-
 	mips_hpt_frequency = tx4927_cpu_clock / 2;
-
-	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_TIME_INIT, "+\n");
-
+	if (tx4927_ccfgptr->ccfg & TX4927_CCFG_TINTDIS)
+		txx9_clockevent_init(TX4927_TMR_REG(0) & 0xfffffffffULL,
+				     TXX9_IRQ_BASE + 17,
+				     50000000);
 }
 
 static int __init toshiba_rbtx4927_rtc_init(void)
diff --git a/arch/mips/tx4938/toshiba_rbtx4938/setup.c b/arch/mips/tx4938/toshiba_rbtx4938/setup.c
index ceecaf4..4a81523 100644
--- a/arch/mips/tx4938/toshiba_rbtx4938/setup.c
+++ b/arch/mips/tx4938/toshiba_rbtx4938/setup.c
@@ -26,6 +26,7 @@
 #include <asm/reboot.h>
 #include <asm/irq.h>
 #include <asm/time.h>
+#include <asm/txx9tmr.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/bootinfo.h>
@@ -773,15 +774,8 @@ void __init tx4938_board_setup(void)
 	}
 
 	/* TMR */
-	/* disable all timers */
-	for (i = 0; i < TX4938_NR_TMR; i++) {
-		tx4938_tmrptr(i)->tcr  = 0x00000020;
-		tx4938_tmrptr(i)->tisr = 0;
-		tx4938_tmrptr(i)->cpra = 0xffffffff;
-		tx4938_tmrptr(i)->itmr = 0;
-		tx4938_tmrptr(i)->ccdr = 0;
-		tx4938_tmrptr(i)->pgmr = 0;
-	}
+	for (i = 0; i < TX4938_NR_TMR; i++)
+		txx9_tmr_init(TX4938_TMR_REG(i) & 0xfffffffffULL);
 
 	/* enable DMA */
 	TX4938_WR64(0xff1fb150, TX4938_DMA_MCR_MSTEN);
@@ -852,12 +846,13 @@ void tx4938_report_pcic_status(void)
 
 #endif /* CONFIG_PCI */
 
-/* We use onchip r4k counter or TMR timer as our system wide timer
- * interrupt running at 100HZ. */
-
 void __init plat_time_init(void)
 {
 	mips_hpt_frequency = txx9_cpu_clock / 2;
+	if (tx4938_ccfgptr->ccfg & TX4938_CCFG_TINTDIS)
+		txx9_clockevent_init(TX4938_TMR_REG(0) & 0xfffffffffULL,
+				     TXX9_IRQ_BASE + TX4938_IR_TMR(0),
+				     txx9_gbus_clock / 2);
 }
 
 void __init toshiba_rbtx4938_setup(void)
diff --git a/include/asm-mips/jmr3927/jmr3927.h b/include/asm-mips/jmr3927/jmr3927.h
index b2dc35f..81602c8 100644
--- a/include/asm-mips/jmr3927/jmr3927.h
+++ b/include/asm-mips/jmr3927/jmr3927.h
@@ -132,9 +132,7 @@
 #define JMR3927_IRQ_IRC_DMA	(JMR3927_IRQ_IRC + TX3927_IR_DMA)
 #define JMR3927_IRQ_IRC_PIO	(JMR3927_IRQ_IRC + TX3927_IR_PIO)
 #define JMR3927_IRQ_IRC_PCI	(JMR3927_IRQ_IRC + TX3927_IR_PCI)
-#define JMR3927_IRQ_IRC_TMR0	(JMR3927_IRQ_IRC + TX3927_IR_TMR0)
-#define JMR3927_IRQ_IRC_TMR1	(JMR3927_IRQ_IRC + TX3927_IR_TMR1)
-#define JMR3927_IRQ_IRC_TMR2	(JMR3927_IRQ_IRC + TX3927_IR_TMR2)
+#define JMR3927_IRQ_IRC_TMR(ch)	(JMR3927_IRQ_IRC + TX3927_IR_TMR(ch))
 #define JMR3927_IRQ_IOC_PCIA	(JMR3927_IRQ_IOC + JMR3927_IOC_INTB_PCIA)
 #define JMR3927_IRQ_IOC_PCIB	(JMR3927_IRQ_IOC + JMR3927_IOC_INTB_PCIB)
 #define JMR3927_IRQ_IOC_PCIC	(JMR3927_IRQ_IOC + JMR3927_IOC_INTB_PCIC)
@@ -148,17 +146,12 @@
 #define JMR3927_IRQ_IOCINT	JMR3927_IRQ_IRC_INT1
 /* TC35815 100M Ether (JMR-TX3912:JPW4:2-3 Short) */
 #define JMR3927_IRQ_ETHER0	JMR3927_IRQ_IRC_INT3
-/* Clock Tick (10ms) */
-#define JMR3927_IRQ_TICK	JMR3927_IRQ_IRC_TMR0
 
 /* Clocks */
 #define JMR3927_CORECLK	132710400	/* 132.7MHz */
 #define JMR3927_GBUSCLK	(JMR3927_CORECLK / 2)	/* 66.35MHz */
 #define JMR3927_IMCLK	(JMR3927_CORECLK / 4)	/* 33.17MHz */
 
-#define jmr3927_tmrptr		tx3927_tmrptr(0)	/* TMR0 */
-
-
 /*
  * TX3927 Pin Configuration:
  *
diff --git a/include/asm-mips/jmr3927/tx3927.h b/include/asm-mips/jmr3927/tx3927.h
index 211bcf4..338f998 100644
--- a/include/asm-mips/jmr3927/tx3927.h
+++ b/include/asm-mips/jmr3927/tx3927.h
@@ -222,9 +222,7 @@ struct tx3927_ccfg_reg {
 #define TX3927_IR_DMA	8
 #define TX3927_IR_PIO	9
 #define TX3927_IR_PCI	10
-#define TX3927_IR_TMR0	13
-#define TX3927_IR_TMR1	14
-#define TX3927_IR_TMR2	15
+#define TX3927_IR_TMR(ch)	(13 + (ch))
 #define TX3927_NUM_IR	16
 
 /*
diff --git a/include/asm-mips/jmr3927/txx927.h b/include/asm-mips/jmr3927/txx927.h
index 58a8ff6..0474fe8 100644
--- a/include/asm-mips/jmr3927/txx927.h
+++ b/include/asm-mips/jmr3927/txx927.h
@@ -10,22 +10,6 @@
 #ifndef __ASM_TXX927_H
 #define __ASM_TXX927_H
 
-struct txx927_tmr_reg {
-	volatile unsigned long tcr;
-	volatile unsigned long tisr;
-	volatile unsigned long cpra;
-	volatile unsigned long cprb;
-	volatile unsigned long itmr;
-	volatile unsigned long unused0[3];
-	volatile unsigned long ccdr;
-	volatile unsigned long unused1[3];
-	volatile unsigned long pgmr;
-	volatile unsigned long unused2[3];
-	volatile unsigned long wtmr;
-	volatile unsigned long unused3[43];
-	volatile unsigned long trr;
-};
-
 struct txx927_sio_reg {
 	volatile unsigned long lcr;
 	volatile unsigned long dicr;
@@ -51,27 +35,6 @@ struct txx927_pio_reg {
 };
 
 /*
- * TMR
- */
-/* TMTCR : Timer Control */
-#define TXx927_TMTCR_TCE	0x00000080
-#define TXx927_TMTCR_CCDE	0x00000040
-#define TXx927_TMTCR_CRE	0x00000020
-#define TXx927_TMTCR_ECES	0x00000008
-#define TXx927_TMTCR_CCS	0x00000004
-#define TXx927_TMTCR_TMODE_MASK	0x00000003
-#define TXx927_TMTCR_TMODE_ITVL	0x00000000
-
-/* TMTISR : Timer Int. Status */
-#define TXx927_TMTISR_TPIBS	0x00000004
-#define TXx927_TMTISR_TPIAS	0x00000002
-#define TXx927_TMTISR_TIIS	0x00000001
-
-/* TMTITMR : Interval Timer Mode */
-#define TXx927_TMTITMR_TIIE	0x00008000
-#define TXx927_TMTITMR_TZCE	0x00000001
-
-/*
  * SIO
  */
 /* SILCR : Line Control */
diff --git a/include/asm-mips/tx4927/tx4927_pci.h b/include/asm-mips/tx4927/tx4927_pci.h
index f98b2bb..3f1e470 100644
--- a/include/asm-mips/tx4927/tx4927_pci.h
+++ b/include/asm-mips/tx4927/tx4927_pci.h
@@ -9,6 +9,7 @@
 #define __ASM_TX4927_TX4927_PCI_H
 
 #define TX4927_CCFG_TOE 0x00004000
+#define TX4927_CCFG_TINTDIS	0x01000000
 
 #define TX4927_PCIMEM      0x08000000
 #define TX4927_PCIMEM_SIZE 0x08000000
@@ -20,6 +21,8 @@
 #define TX4927_PCIC_REG         0xff1fd000
 #define TX4927_CCFG_REG         0xff1fe000
 #define TX4927_IRC_REG          0xff1ff600
+#define TX4927_NR_TMR	3
+#define TX4927_TMR_REG(ch)	(0xff1ff000 + (ch) * 0x100)
 #define TX4927_CE3      0x17f00000      /* 1M */
 #define TX4927_PCIRESET_ADDR    0xbc00f006
 #define TX4927_PCI_CLK_ADDR     (KSEG1 + TX4927_CE3 + 0x00040020)
diff --git a/include/asm-mips/tx4938/tx4938.h b/include/asm-mips/tx4938/tx4938.h
index 650b010..f7c448b 100644
--- a/include/asm-mips/tx4938/tx4938.h
+++ b/include/asm-mips/tx4938/tx4938.h
@@ -641,7 +641,6 @@ struct tx4938_ccfg_reg {
 #define tx4938_pcicptr		((struct tx4938_pcic_reg *)TX4938_PCIC_REG)
 #define tx4938_pcic1ptr		((struct tx4938_pcic_reg *)TX4938_PCIC1_REG)
 #define tx4938_ccfgptr		((struct tx4938_ccfg_reg *)TX4938_CCFG_REG)
-#define tx4938_tmrptr(ch)	((struct tx4938_tmr_reg *)TX4938_TMR_REG(ch))
 #define tx4938_sioptr(ch)	((struct tx4938_sio_reg *)TX4938_SIO_REG(ch))
 #define tx4938_pioptr		((struct tx4938_pio_reg *)TX4938_PIO_REG)
 #define tx4938_aclcptr		((struct tx4938_aclc_reg *)TX4938_ACLC_REG)
diff --git a/include/asm-mips/txx9tmr.h b/include/asm-mips/txx9tmr.h
new file mode 100644
index 0000000..67f70a8
--- /dev/null
+++ b/include/asm-mips/txx9tmr.h
@@ -0,0 +1,67 @@
+/*
+ * include/asm-mips/txx9tmr.h
+ * TX39/TX49 timer controller definitions.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#ifndef __ASM_TXX9TMR_H
+#define __ASM_TXX9TMR_H
+
+#include <linux/types.h>
+
+struct txx9_tmr_reg {
+	u32 tcr;
+	u32 tisr;
+	u32 cpra;
+	u32 cprb;
+	u32 itmr;
+	u32 unused0[3];
+	u32 ccdr;
+	u32 unused1[3];
+	u32 pgmr;
+	u32 unused2[3];
+	u32 wtmr;
+	u32 unused3[43];
+	u32 trr;
+};
+
+/* TMTCR : Timer Control */
+#define TXx9_TMTCR_TCE		0x00000080
+#define TXx9_TMTCR_CCDE		0x00000040
+#define TXx9_TMTCR_CRE		0x00000020
+#define TXx9_TMTCR_ECES		0x00000008
+#define TXx9_TMTCR_CCS		0x00000004
+#define TXx9_TMTCR_TMODE_MASK	0x00000003
+#define TXx9_TMTCR_TMODE_ITVL	0x00000000
+#define TXx9_TMTCR_TMODE_PGEN	0x00000001
+#define TXx9_TMTCR_TMODE_WDOG	0x00000002
+
+/* TMTISR : Timer Int. Status */
+#define TXx9_TMTISR_TPIBS	0x00000004
+#define TXx9_TMTISR_TPIAS	0x00000002
+#define TXx9_TMTISR_TIIS	0x00000001
+
+/* TMITMR : Interval Timer Mode */
+#define TXx9_TMITMR_TIIE	0x00008000
+#define TXx9_TMITMR_TZCE	0x00000001
+
+/* TMWTMR : Watchdog Timer Mode */
+#define TXx9_TMWTMR_TWIE	0x00008000
+#define TXx9_TMWTMR_WDIS	0x00000080
+#define TXx9_TMWTMR_TWC		0x00000001
+
+void txx9_clocksource_init(unsigned long baseaddr,
+			   unsigned int imbusclk);
+void txx9_clockevent_init(unsigned long baseaddr, int irq,
+			  unsigned int imbusclk);
+void txx9_tmr_init(unsigned long baseaddr);
+
+#ifdef CONFIG_CPU_TX39XX
+#define TXX9_TIMER_BITS	24
+#else
+#define TXX9_TIMER_BITS	32
+#endif
+
+#endif /* __ASM_TXX9TMR_H */
