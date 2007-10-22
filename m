Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Oct 2007 11:42:17 +0100 (BST)
Received: from mo30.po.2iij.NET ([210.128.50.53]:30533 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20021580AbXJVKmH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 22 Oct 2007 11:42:07 +0100
Received: by mo.po.2iij.net (mo30) id l9MAg15Y028440; Mon, 22 Oct 2007 19:42:01 +0900 (JST)
Received: from localhost (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox300) id l9MAfw1c011027
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 22 Oct 2007 19:41:58 +0900
Date:	Mon, 22 Oct 2007 19:43:15 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] add GT641xx timer0 clockevent
Message-Id: <20071022194315.f75738ba.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17148
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips


Add GT641xx timer0 clockevent.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/Kconfig mips/arch/mips/Kconfig
--- mips-orig/arch/mips/Kconfig	2007-10-22 09:19:37.959724750 +0900
+++ mips/arch/mips/Kconfig	2007-10-22 09:19:23.342811250 +0900
@@ -66,6 +66,7 @@ config BCM47XX
 config MIPS_COBALT
 	bool "Cobalt Server"
 	select CEVT_R4K
+	select CEVT_GT641XX
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
 	select I8253
@@ -729,6 +730,9 @@ config ARCH_MAY_HAVE_PC_FDC
 config BOOT_RAW
 	bool
 
+config CEVT_GT641XX
+	bool
+
 config CEVT_R4K
 	bool
 
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/Makefile mips/arch/mips/cobalt/Makefile
--- mips-orig/arch/mips/cobalt/Makefile	2007-10-22 09:19:37.971725500 +0900
+++ mips/arch/mips/cobalt/Makefile	2007-10-22 09:19:23.354812000 +0900
@@ -2,7 +2,7 @@
 # Makefile for the Cobalt micro systems family specific parts of the kernel
 #
 
-obj-y := buttons.o irq.o led.o reset.o rtc.o serial.o setup.o
+obj-y := buttons.o irq.o led.o reset.o rtc.o serial.o setup.o time.o
 
 obj-$(CONFIG_PCI)		+= pci.o
 obj-$(CONFIG_EARLY_PRINTK)	+= console.o
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/setup.c mips/arch/mips/cobalt/setup.c
--- mips-orig/arch/mips/cobalt/setup.c	2007-10-22 09:19:37.987726500 +0900
+++ mips/arch/mips/cobalt/setup.c	2007-10-22 09:19:23.366812750 +0900
@@ -9,19 +9,17 @@
  * Copyright (C) 2001, 2002, 2003 by Liam Davies (ldavies@agile.tv)
  *
  */
-#include <linux/interrupt.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
 #include <linux/pm.h>
 
 #include <asm/bootinfo.h>
-#include <asm/time.h>
-#include <asm/i8253.h>
-#include <asm/io.h>
 #include <asm/reboot.h>
 #include <asm/gt64120.h>
 
 #include <cobalt.h>
-#include <irq.h>
 
 extern void cobalt_machine_restart(char *command);
 extern void cobalt_machine_halt(void);
@@ -41,17 +39,6 @@ const char *get_system_type(void)
 	return "MIPS Cobalt";
 }
 
-void __init plat_timer_setup(struct irqaction *irq)
-{
-	/* Load timer value for HZ (TCLK is 50MHz) */
-	GT_WRITE(GT_TC0_OFS, 50*1000*1000 / HZ);
-
-	/* Enable timer0 */
-	GT_WRITE(GT_TC_CONTROL_OFS, GT_TC_CONTROL_ENTC0_MSK | GT_TC_CONTROL_SELTC0_MSK);
-
-	setup_irq(GT641XX_TIMER0_IRQ, irq);
-}
-
 /*
  * Cobalt doesn't have PS/2 keyboard/mouse interfaces,
  * keyboard conntroller is never used.
@@ -84,11 +71,6 @@ static struct resource cobalt_reserved_r
 	},
 };
 
-void __init plat_time_init(void)
-{
-	setup_pit_timer();
-}
-
 void __init plat_mem_setup(void)
 {
 	int i;
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/time.c mips/arch/mips/cobalt/time.c
--- mips-orig/arch/mips/cobalt/time.c	1970-01-01 09:00:00.000000000 +0900
+++ mips/arch/mips/cobalt/time.c	2007-10-22 09:24:18.157236000 +0900
@@ -0,0 +1,35 @@
+/*
+ *  Cobalt time initialization.
+ *
+ *  Copyright (C) 2007  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+#include <linux/init.h>
+
+#include <asm/gt64120.h>
+#include <asm/i8253.h>
+#include <asm/time.h>
+
+#define GT641XX_BASE_CLOCK	50000000	/* 50MHz */
+
+void __init plat_time_init(void)
+{
+	setup_pit_timer();
+
+	gt641xx_set_base_clock(GT641XX_BASE_CLOCK);
+
+	mips_timer_state = gt641xx_timer0_state;
+}
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/kernel/Makefile mips/arch/mips/kernel/Makefile
--- mips-orig/arch/mips/kernel/Makefile	2007-10-22 09:19:38.011728000 +0900
+++ mips/arch/mips/kernel/Makefile	2007-10-22 09:19:23.366812750 +0900
@@ -9,6 +9,7 @@ obj-y		+= cpu-probe.o branch.o entry.o g
 		   time.o topology.o traps.o unaligned.o
 
 obj-$(CONFIG_CEVT_R4K)		+= cevt-r4k.o
+obj-$(CONFIG_CEVT_GT641XX)	+= cevt-gt641xx.o
 
 binfmt_irix-objs	:= irixelf.o irixinv.o irixioctl.o irixsig.o	\
 			   irix5sys.o sysirix.o
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/kernel/cevt-gt641xx.c mips/arch/mips/kernel/cevt-gt641xx.c
--- mips-orig/arch/mips/kernel/cevt-gt641xx.c	1970-01-01 09:00:00.000000000 +0900
+++ mips/arch/mips/kernel/cevt-gt641xx.c	2007-10-22 09:24:33.146172750 +0900
@@ -0,0 +1,144 @@
+/*
+ *  GT641xx clockevent routines.
+ *
+ *  Copyright (C) 2007  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+#include <linux/clockchips.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+
+#include <asm/gt64120.h>
+#include <asm/time.h>
+
+#include <irq.h>
+
+static DEFINE_SPINLOCK(gt641xx_timer_lock);
+static unsigned int gt641xx_base_clock;
+
+void gt641xx_set_base_clock(unsigned int clock)
+{
+	gt641xx_base_clock = clock;
+}
+
+int gt641xx_timer0_state(void)
+{
+	if (GT_READ(GT_TC0_OFS))
+		return 0;
+
+	GT_WRITE(GT_TC0_OFS, gt641xx_base_clock / HZ);
+	GT_WRITE(GT_TC_CONTROL_OFS, GT_TC_CONTROL_ENTC0_MSK);
+
+	return 1;
+}
+
+static int gt641xx_timer0_set_next_event(unsigned long delta,
+					 struct clock_event_device *evt)
+{
+	unsigned long flags;
+	u32 ctrl;
+
+	spin_lock_irqsave(&gt641xx_timer_lock, flags);
+
+	ctrl = GT_READ(GT_TC_CONTROL_OFS);
+	ctrl &= ~(GT_TC_CONTROL_ENTC0_MSK | GT_TC_CONTROL_SELTC0_MSK);
+	ctrl |= GT_TC_CONTROL_ENTC0_MSK;
+
+	GT_WRITE(GT_TC0_OFS, delta);
+	GT_WRITE(GT_TC_CONTROL_OFS, ctrl);
+
+	spin_unlock_irqrestore(&gt641xx_timer_lock, flags);
+
+	return 0;
+}
+
+static void gt641xx_timer0_set_mode(enum clock_event_mode mode,
+				    struct clock_event_device *evt)
+{
+	unsigned long flags;
+	u32 ctrl;
+
+	spin_lock_irqsave(&gt641xx_timer_lock, flags);
+
+	ctrl = GT_READ(GT_TC_CONTROL_OFS);
+	ctrl &= ~(GT_TC_CONTROL_ENTC0_MSK | GT_TC_CONTROL_SELTC0_MSK);
+
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		ctrl |= GT_TC_CONTROL_ENTC0_MSK | GT_TC_CONTROL_SELTC0_MSK;
+		break;
+	case CLOCK_EVT_MODE_ONESHOT:
+		ctrl |= GT_TC_CONTROL_ENTC0_MSK;
+		break;
+	default:
+		break;
+	}
+
+	GT_WRITE(GT_TC_CONTROL_OFS, ctrl);
+
+	spin_unlock_irqrestore(&gt641xx_timer_lock, flags);
+}
+
+static void gt641xx_timer0_event_handler(struct clock_event_device *dev)
+{
+}
+
+static struct clock_event_device gt641xx_timer0_clockevent = {
+	.name		= "gt641xx-timer0",
+	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
+	.cpumask	= CPU_MASK_CPU0,
+	.irq		= GT641XX_TIMER0_IRQ,
+	.set_next_event	= gt641xx_timer0_set_next_event,
+	.set_mode	= gt641xx_timer0_set_mode,
+	.event_handler	= gt641xx_timer0_event_handler,
+};
+
+static irqreturn_t gt641xx_timer0_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *cd = &gt641xx_timer0_clockevent;
+
+	cd->event_handler(cd);
+
+	return IRQ_HANDLED;
+}
+
+static struct irqaction gt641xx_timer0_irqaction = {
+	.handler	= gt641xx_timer0_interrupt,
+	.flags		= IRQF_DISABLED | IRQF_PERCPU,
+	.name		= "gt641xx_timer0",
+};
+
+static int __init gt641xx_timer0_clockevent_init(void)
+{
+	struct clock_event_device *cd;
+
+	if (!gt641xx_base_clock)
+		return 0;
+
+	GT_WRITE(GT_TC0_OFS, gt641xx_base_clock / HZ);
+
+	cd = &gt641xx_timer0_clockevent;
+	cd->rating = 200 + gt641xx_base_clock / 10000000;
+	cd->max_delta_ns = clockevent_delta2ns(0x7fffffff, cd);
+	cd->min_delta_ns = clockevent_delta2ns(0x300, cd);
+	clockevent_set_clock(cd, gt641xx_base_clock);
+
+	clockevents_register_device(&gt641xx_timer0_clockevent);
+
+	return setup_irq(GT641XX_TIMER0_IRQ, &gt641xx_timer0_irqaction);
+}
+arch_initcall(gt641xx_timer0_clockevent_init);
diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/gt64120.h mips/include/asm-mips/gt64120.h
--- mips-orig/include/asm-mips/gt64120.h	2007-10-22 09:19:38.055730750 +0900
+++ mips/include/asm-mips/gt64120.h	2007-10-22 09:19:23.370813000 +0900
@@ -21,6 +21,8 @@
 #ifndef _ASM_GT64120_H
 #define _ASM_GT64120_H
 
+#include <linux/clocksource.h>
+
 #include <asm/addrspace.h>
 #include <asm/byteorder.h>
 
@@ -572,4 +574,7 @@
 #define GT_READ(ofs)		le32_to_cpu(__GT_READ(ofs))
 #define GT_WRITE(ofs, data)	__GT_WRITE(ofs, cpu_to_le32(data))
 
+extern void gt641xx_set_base_clock(unsigned int clock);
+extern int gt641xx_timer0_state(void);
+
 #endif /* _ASM_GT64120_H */
