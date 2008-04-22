Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Apr 2008 00:53:35 +0100 (BST)
Received: from mo30.po.2iij.NET ([210.128.50.53]:11540 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S28581544AbYDVXxQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 23 Apr 2008 00:53:16 +0100
Received: by mo.po.2iij.net (mo30) id m3MNrC2j032759; Wed, 23 Apr 2008 08:53:12 +0900 (JST)
Received: from rally.tripeaks.co.jp (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox303) id m3MNr8m4025538
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 23 Apr 2008 08:53:08 +0900
Message-Id: <200804222353.m3MNr8m4025538@po-mbox303.hop.2iij.net>
Date:	Wed, 23 Apr 2008 08:52:45 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 2/2] [MIPS] add DECstation DS1287 clockevent
In-Reply-To: <20080423085140.a693b2e5.yoichi_yuasa@tripeaks.co.jp>
References: <20080423085140.a693b2e5.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18999
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

add DECstation DS1287 clockevent

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/Kconfig linux/arch/mips/Kconfig
--- linux-orig/arch/mips/Kconfig	2008-04-22 19:01:43.957134178 +0900
+++ linux/arch/mips/Kconfig	2008-04-22 18:03:05.427649422 +0900
@@ -81,6 +81,7 @@ config MIPS_COBALT
 config MACH_DECSTATION
 	bool "DECstations"
 	select BOOT_ELF32
+	select CEVT_DS1287
 	select CEVT_R4K
 	select CSRC_IOASIC
 	select CSRC_R4K
@@ -769,6 +770,9 @@ config BOOT_RAW
 config CEVT_BCM1480
 	bool
 
+config CEVT_DS1287
+	bool
+
 config CEVT_GT641XX
 	bool
 
diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/dec/time.c linux/arch/mips/dec/time.c
--- linux-orig/arch/mips/dec/time.c	2008-04-22 19:01:43.957134178 +0900
+++ linux/arch/mips/dec/time.c	2008-04-22 18:03:05.427649422 +0900
@@ -9,30 +9,16 @@
  *
  */
 #include <linux/bcd.h>
-#include <linux/errno.h>
 #include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/kernel.h>
 #include <linux/mc146818rtc.h>
-#include <linux/mm.h>
-#include <linux/module.h>
 #include <linux/param.h>
-#include <linux/sched.h>
-#include <linux/string.h>
-#include <linux/time.h>
-#include <linux/types.h>
-
-#include <asm/bootinfo.h>
-#include <asm/cpu.h>
-#include <asm/io.h>
-#include <asm/irq.h>
-#include <asm/mipsregs.h>
-#include <asm/sections.h>
+
+#include <asm/cpu-features.h>
 #include <asm/time.h>
 
+#include <asm/dec/ds1287.h>
 #include <asm/dec/interrupts.h>
 #include <asm/dec/ioasic.h>
-#include <asm/dec/ioasic_addrs.h>
 #include <asm/dec/machtype.h>
 
 unsigned long read_persistent_clock(void)
@@ -139,42 +125,32 @@ int rtc_mips_set_mmss(unsigned long nowt
 	return retval;
 }
 
-static int dec_timer_state(void)
+void __init plat_time_init(void)
 {
-	return (CMOS_READ(RTC_REG_C) & RTC_PF) != 0;
-}
+	u32 start, end;
+	int i = HZ / 10;
 
-static void dec_timer_ack(void)
-{
-	CMOS_READ(RTC_REG_C);			/* Ack the RTC interrupt.  */
-}
+	/* Set up the rate of periodic DS1287 interrupts. */
+	ds1287_set_base_clock(HZ);
 
-static cycle_t dec_ioasic_hpt_read(void)
-{
-	/*
-	 * The free-running counter is 32-bit which is good for about
-	 * 2 minutes, 50 seconds at possible count rates of up to 25MHz.
-	 */
-	return ioasic_read(IO_REG_FCTR);
-}
+	if (cpu_has_counter) {
+		while (!ds1287_timer_state())
+			;
 
+		start = read_c0_count();
 
-void __init plat_time_init(void)
-{
-	mips_timer_ack = dec_timer_ack;
+		while (i--)
+			while (!ds1287_timer_state())
+				;
+
+		end = read_c0_count();
 
-	if (!cpu_has_counter && IOASIC)
+		mips_hpt_frequency = (end - start) * 10;
+		printk(KERN_INFO "MIPS counter frequency %dHz\n",
+			mips_hpt_frequency);
+	} else if (IOASIC)
 		/* For pre-R4k systems we use the I/O ASIC's counter.  */
 		dec_ioasic_clocksource_init();
 
-	/* Set up the rate of periodic DS1287 interrupts.  */
-	CMOS_WRITE(RTC_REF_CLCK_32KHZ | (16 - __ffs(HZ)), RTC_REG_A);
-}
-
-void __init plat_timer_setup(struct irqaction *irq)
-{
-	setup_irq(dec_interrupt[DEC_IRQ_RTC], irq);
-
-	/* Enable periodic DS1287 interrupts.  */
-	CMOS_WRITE(CMOS_READ(RTC_REG_B) | RTC_PIE, RTC_REG_B);
+	ds1287_clockevent_init(dec_interrupt[DEC_IRQ_RTC]);
 }
diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/kernel/Makefile linux/arch/mips/kernel/Makefile
--- linux-orig/arch/mips/kernel/Makefile	2008-04-22 19:01:43.957134178 +0900
+++ linux/arch/mips/kernel/Makefile	2008-04-22 18:03:05.427649422 +0900
@@ -9,8 +9,9 @@ obj-y		+= cpu-probe.o branch.o entry.o g
 		   time.o topology.o traps.o unaligned.o
 
 obj-$(CONFIG_CEVT_BCM1480)	+= cevt-bcm1480.o
-obj-$(CONFIG_CEVT_R4K)		+= cevt-r4k.o
+obj-$(CONFIG_CEVT_DS1287)	+= cevt-ds1287.o
 obj-$(CONFIG_CEVT_GT641XX)	+= cevt-gt641xx.o
+obj-$(CONFIG_CEVT_R4K)		+= cevt-r4k.o
 obj-$(CONFIG_CEVT_SB1250)	+= cevt-sb1250.o
 obj-$(CONFIG_CEVT_TXX9)		+= cevt-txx9.o
 obj-$(CONFIG_CSRC_BCM1480)	+= csrc-bcm1480.o
diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/kernel/cevt-ds1287.c linux/arch/mips/kernel/cevt-ds1287.c
--- linux-orig/arch/mips/kernel/cevt-ds1287.c	1970-01-01 09:00:00.000000000 +0900
+++ linux/arch/mips/kernel/cevt-ds1287.c	2008-04-22 18:03:05.455637018 +0900
@@ -0,0 +1,132 @@
+/*
+ *  DS1287 clockevent driver
+ *
+ *  Copyright (C) 2008  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
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
+#include <linux/mc146818rtc.h>
+
+#include <asm/time.h>
+
+#include <irq.h>
+
+int ds1287_timer_state(void)
+{
+	return (CMOS_READ(RTC_REG_C) & RTC_PF) != 0;
+}
+
+int ds1287_set_base_clock(unsigned int hz)
+{
+	u8 rate;
+
+	switch (hz) {
+	case 128:
+		rate = 0x9;
+		break;
+	case 256:
+		rate = 0x8;
+		break;
+	case 1024:
+		rate = 0x6;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	CMOS_WRITE(RTC_REF_CLCK_32KHZ | rate, RTC_REG_A);
+
+	return 0;
+}
+
+static int ds1287_set_next_event(unsigned long delta,
+				 struct clock_event_device *evt)
+{
+	return -EINVAL;
+}
+
+static void ds1287_set_mode(enum clock_event_mode mode,
+			    struct clock_event_device *evt)
+{
+	unsigned long flags;
+	u8 val;
+
+	spin_lock_irqsave(&rtc_lock, flags);
+
+	val = CMOS_READ(RTC_REG_B);
+
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		val |= RTC_PIE;
+		break;
+	default:
+		val &= ~RTC_PIE;
+		break;
+	}
+
+	CMOS_WRITE(val, RTC_REG_B);
+
+	spin_unlock_irqrestore(&rtc_lock, flags);
+}
+
+static void ds1287_event_handler(struct clock_event_device *dev)
+{
+}
+
+static struct clock_event_device ds1287_clockevent = {
+	.name		= "ds1287",
+	.features	= CLOCK_EVT_FEAT_PERIODIC,
+	.cpumask	= CPU_MASK_CPU0,
+	.set_next_event	= ds1287_set_next_event,
+	.set_mode	= ds1287_set_mode,
+	.event_handler	= ds1287_event_handler,
+};
+
+static irqreturn_t ds1287_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *cd = &ds1287_clockevent;
+
+	/* Ack the RTC interrupt. */
+	CMOS_READ(RTC_REG_C);
+
+	cd->event_handler(cd);
+
+	return IRQ_HANDLED;
+}
+
+static struct irqaction ds1287_irqaction = {
+	.handler	= ds1287_interrupt,
+	.flags		= IRQF_DISABLED | IRQF_PERCPU,
+	.name		= "ds1287",
+};
+
+int __init ds1287_clockevent_init(int irq)
+{
+	struct clock_event_device *cd;
+
+	cd = &ds1287_clockevent;
+	cd->rating = 100;
+	cd->irq = irq;
+	clockevent_set_clock(cd, 32768);
+	cd->max_delta_ns = clockevent_delta2ns(0x7fffffff, cd);
+	cd->min_delta_ns = clockevent_delta2ns(0x300, cd);
+
+	clockevents_register_device(&ds1287_clockevent);
+
+	return setup_irq(irq, &ds1287_irqaction);
+}
diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/include/asm-mips/dec/ds1287.h linux/include/asm-mips/dec/ds1287.h
--- linux-orig/include/asm-mips/dec/ds1287.h	1970-01-01 09:00:00.000000000 +0900
+++ linux/include/asm-mips/dec/ds1287.h	2008-04-22 18:03:05.455637018 +0900
@@ -0,0 +1,27 @@
+/*
+ *  DS1287 timer functions.
+ *
+ *  Copyright (C) 2008  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
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
+#ifndef __ASM_DEC_DS1287_H
+#define __ASM_DEC_DS1287_H
+
+extern int ds1287_timer_state(void);
+extern void ds1287_set_base_clock(unsigned int clock);
+extern int ds1287_clockevent_init(int irq);
+
+#endif
