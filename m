Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Sep 2005 14:03:29 +0100 (BST)
Received: from [IPv6:::ffff:85.21.88.6] ([IPv6:::ffff:85.21.88.6]:2836 "EHLO
	buildserver.ru.mvista.com") by linux-mips.org with ESMTP
	id <S8225204AbVINNCj>; Wed, 14 Sep 2005 14:02:39 +0100
Received: from [192.168.12.17] ([10.149.0.1])
	by buildserver.ru.mvista.com (8.11.6/8.11.6) with ESMTP id j8ED2ct21785;
	Wed, 14 Sep 2005 18:02:38 +0500
Message-ID: <43281F6E.3010807@ru.mvista.com>
Date:	Wed, 14 Sep 2005 17:02:38 +0400
From:	"Vladimir A. Barinov" <vbarinov@ru.mvista.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] RTC for TX4927(37) platform
References: <20050913124544.GC3224@linux-mips.org>	<20050913133126.GO23161@lug-owl.de>	<20050913152038.GE3224@linux-mips.org> <17191.61757.80884.8289@mips.com> <43281DC3.8010602@ru.mvista.com>
In-Reply-To: <43281DC3.8010602@ru.mvista.com>
Content-Type: multipart/mixed;
 boundary="------------050908050609050203010502"
Return-Path: <vbarinov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8944
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vbarinov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------050908050609050203010502
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello All!

This as a patch to add RTC support for TX4927 platform.
The current RTC_DS1742=y can't be ever compiled.

Does it makes sence to push it in?

Regards,
Vladimir

--------------050908050609050203010502
Content-Type: text/plain;
 name="pro_mips_tx4927_rtc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pro_mips_tx4927_rtc.patch"

 Signed-off-by: Vladimir Barinov <vbarinov@ru.mvista.com>
 Description:
 	RTC support for TX4927/37 platform in 2.6.
 	
Index: linux-2.6.10/arch/mips/tx4927/common/Makefile
===================================================================
--- linux-2.6.10/arch/mips/tx4927/common/Makefile
+++ linux-2.6.10/arch/mips/tx4927/common/Makefile
@@ -6,7 +6,7 @@
 # unless it's something special (ie not a .c file).
 #
 
-obj-y	+= tx4927_prom.o tx4927_setup.o tx4927_irq.o tx4927_irq_handler.o
+obj-y	+= tx4927_prom.o tx4927_setup.o tx4927_irq.o tx4927_irq_handler.o rtc_ds1742.o
 
 obj-$(CONFIG_TOSHIBA_FPCIB0)	   += smsc_fdc37m81x.o
 obj-$(CONFIG_KGDB)                 += tx4927_dbgio.o
Index: linux-2.6.10/include/asm-mips/tx4927/toshiba_rbtx4927.h
===================================================================
--- linux-2.6.10/include/asm-mips/tx4927/toshiba_rbtx4927.h
+++ linux-2.6.10/include/asm-mips/tx4927/toshiba_rbtx4927.h
@@ -49,6 +49,7 @@
 #define RBTX4927_SW_RESET_ENABLE     0xbc00f002
 #define RBTX4927_SW_RESET_ENABLE_SET            0x01
 
+#define RBTX4927_RTC_BASE	0xbc010000
 
 #define RBTX4927_RTL_8019_BASE (0x1c020280-TBTX4927_ISA_IO_OFFSET)
 #define RBTX4927_RTL_8019_IRQ  (29)
Index: linux-2.6.10/arch/mips/tx4927/common/rtc_ds1742.c
===================================================================
--- /dev/null
+++ linux-2.6.10/arch/mips/tx4927/common/rtc_ds1742.c
@@ -0,0 +1,141 @@
+/*
+ * arch/mips/tx4927/common/rtc_ds1742.c 
+ * 
+ * This is a copy of:  arch/mips/jmr3927/common/rtc_ds1742.c
+ *
+ * Copyright (c) 2001-2005 MontaVista Software Inc.
+ * Copyright (c) 2000-2001 Toshiba Corporation 
+ *
+ * 2001-2005 (c) MontaVista Software, Inc. This file is licensed under the
+ * terms of the GNU General Public License version 2. This program is
+ * licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/types.h>
+#include <linux/ds1742rtc.h>
+
+#include <asm/time.h>
+#include <asm/delay.h>
+#include <asm/debug.h>
+
+#define	EPOCH		2000
+
+#undef BCD_TO_BIN
+#define BCD_TO_BIN(val) (((val)&15) + ((val)>>4)*10)
+
+#undef BIN_TO_BCD
+#define BIN_TO_BCD(val) ((((val)/10)<<4) + (val)%10)
+
+unsigned long rtc_base;
+
+/* RTC-dependent code for time.c */
+
+static unsigned long rtc_ds1742_get_time(void)
+{
+	unsigned int year, month, day, hour, minute, second;
+	unsigned int century;
+	static unsigned int save = 0;
+
+	CMOS_WRITE(RTC_READ, RTC_CONTROL);
+	second 	= BCD_TO_BIN(CMOS_READ(RTC_SECONDS) & RTC_SECONDS_MASK);
+	minute 	= BCD_TO_BIN(CMOS_READ(RTC_MINUTES));
+	hour 	= BCD_TO_BIN(CMOS_READ(RTC_HOURS));
+	day 	= BCD_TO_BIN(CMOS_READ(RTC_DATE));
+	month 	= BCD_TO_BIN(CMOS_READ(RTC_MONTH));
+	year 	= BCD_TO_BIN(CMOS_READ(RTC_YEAR));
+	century = BCD_TO_BIN(CMOS_READ(RTC_CENTURY) & RTC_CENTURY_MASK);
+	CMOS_WRITE(0, RTC_CONTROL);
+
+	/* manual -- must wait 500us min between RTC_READ clr and next set */
+	if (save != second)
+		save = second;
+	else
+		udelay(500);
+
+	year += EPOCH;
+
+	return mktime(year, month, day, hour, minute, second);
+}
+
+static int rtc_ds1742_set_time(unsigned long t)
+{
+	struct rtc_time tm;
+	u8 year, month, day, hour, minute, second;
+	u8 cmos_year, cmos_month, cmos_day, cmos_hour, cmos_minute, cmos_second;
+	int cmos_century;
+
+	CMOS_WRITE(RTC_READ, RTC_CONTROL);
+	cmos_second  = (u8) (CMOS_READ(RTC_SECONDS) & RTC_SECONDS_MASK);
+	cmos_minute  = (u8) CMOS_READ(RTC_MINUTES);
+	cmos_hour    = (u8) CMOS_READ(RTC_HOURS);
+	cmos_day     = (u8) CMOS_READ(RTC_DATE);
+	cmos_month   = (u8) CMOS_READ(RTC_MONTH);
+	cmos_year    = (u8) CMOS_READ(RTC_YEAR);
+	cmos_century = CMOS_READ(RTC_CENTURY) & RTC_CENTURY_MASK;
+	CMOS_WRITE(RTC_WRITE, RTC_CONTROL);
+
+	/* convert */
+	to_tm(t, &tm);
+
+	/* check each field one by one */
+	year = BIN_TO_BCD(tm.tm_year - EPOCH);
+	if (year != cmos_year)
+		CMOS_WRITE(year, RTC_YEAR);
+
+	month = BIN_TO_BCD(tm.tm_mon + 1);
+	if (month != (cmos_month & 0x1f))
+		CMOS_WRITE((month & 0x1f) | (cmos_month & ~0x1f), RTC_MONTH);
+
+	day = BIN_TO_BCD(tm.tm_mday);
+	if (day != cmos_day)
+		CMOS_WRITE(day, RTC_DATE);
+
+	if (cmos_hour & 0x40) {
+		/* 12 hour format */
+		hour = 0x40;
+		if (tm.tm_hour > 12) {
+			hour |= 0x20 | (BIN_TO_BCD(hour - 12) & 0x1f);
+		} else {
+			hour |= BIN_TO_BCD(tm.tm_hour);
+		}
+	} else {
+		/* 24 hour format */
+		hour = BIN_TO_BCD(tm.tm_hour) & 0x3f;
+	}
+
+	if (hour != cmos_hour)
+		CMOS_WRITE(hour, RTC_HOURS);
+
+	minute = BIN_TO_BCD(tm.tm_min);
+	if (minute != cmos_minute)
+		CMOS_WRITE(minute, RTC_MINUTES);
+
+	second = BIN_TO_BCD(tm.tm_sec);
+	if (second != cmos_second)
+		CMOS_WRITE(second & RTC_SECONDS_MASK, RTC_SECONDS);
+
+	/* RTC_CENTURY and RTC_CONTROL share same address... */
+	CMOS_WRITE(cmos_century, RTC_CONTROL);
+	return 0;
+}
+
+void rtc_ds1742_init(unsigned long base)
+{
+	u8 cmos_second;
+
+	/* remember the base */
+	rtc_base = base;
+	db_assert((rtc_base & 0xe0000000) == KSEG1);
+
+	/* clear oscillator stop bit */
+	CMOS_WRITE(RTC_READ, RTC_CONTROL);
+	cmos_second = (u8) (CMOS_READ(RTC_SECONDS) & RTC_SECONDS_MASK);
+	CMOS_WRITE(RTC_WRITE, RTC_CONTROL);
+	CMOS_WRITE(cmos_second, RTC_SECONDS);	/* clear msb */
+	CMOS_WRITE(0, RTC_CONTROL);
+
+	/* set the function pointers */
+	rtc_get_time = rtc_ds1742_get_time;
+	rtc_set_time = rtc_ds1742_set_time;
+}
Index: linux-2.6.10/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
===================================================================
--- linux-2.6.10/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
+++ linux-2.6.10/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
@@ -133,9 +133,6 @@ JP7 is not bus master -- do NOT use -- o
 #include <asm/time.h>
 #include <linux/bootmem.h>
 #include <linux/blkdev.h>
-#ifdef CONFIG_RTC_DS1742
-#include <linux/ds1742rtc.h>
-#endif
 #ifdef CONFIG_TOSHIBA_FPCIB0
 #include <asm/tx4927/smsc_fdc37m81x.h>
 #endif
Index: linux-2.6.10/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
===================================================================
--- linux-2.6.10/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
+++ linux-2.6.10/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
@@ -63,9 +63,7 @@
 #include <asm/time.h>
 #include <linux/bootmem.h>
 #include <linux/blkdev.h>
-#ifdef CONFIG_RTC_DS1742
 #include <linux/ds1742rtc.h>
-#endif
 #ifdef CONFIG_TOSHIBA_FPCIB0
 #include <asm/tx4927/smsc_fdc37m81x.h>
 #endif
@@ -970,12 +968,6 @@ void __init toshiba_rbtx4927_setup(void)
 			       "+\n");
 }
 
-#ifdef CONFIG_RTC_DS1742
-extern unsigned long rtc_ds1742_get_time(void);
-extern int rtc_ds1742_set_time(unsigned long);
-extern void rtc_ds1742_wait(void);
-#endif
-
 void __init
 toshiba_rbtx4927_time_init(void)
 {
@@ -984,58 +976,14 @@ toshiba_rbtx4927_time_init(void)
 
 	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_TIME_INIT, "-\n");
 
-#ifdef CONFIG_RTC_DS1742
-
-	rtc_get_time = rtc_ds1742_get_time;
-	rtc_set_time = rtc_ds1742_set_time;
-
-	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_TIME_INIT,
-				       ":rtc_ds1742_init()-\n");
-	rtc_ds1742_init(0xbc010000);
-	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_TIME_INIT,
-				       ":rtc_ds1742_init()+\n");
-
-	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_TIME_INIT,
-				       ":Calibrate mips_hpt_frequency-\n");
-	rtc_ds1742_wait();
-
-	/* get the count */
-	c1 = read_c0_count();
-
-	/* wait for the seconds to change again */
-	rtc_ds1742_wait();
-
-	/* get the count again */
-	c2 = read_c0_count();
-
-	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_TIME_INIT,
-				       ":Calibrate mips_hpt_frequency+\n");
-	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_TIME_INIT,
-				       ":c1=%12u\n", c1);
-	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_TIME_INIT,
-				       ":c2=%12u\n", c2);
-
-	/* this diff is as close as we are going to get to counter ticks per sec */
-	mips_hpt_frequency = abs(c2 - c1);
-	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_TIME_INIT,
-				       ":f1=%12u\n", mips_hpt_frequency);
-
-	/* round to 1/10th of a MHz */
-	mips_hpt_frequency /= (100 * 1000);
-	mips_hpt_frequency *= (100 * 1000);
-	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_TIME_INIT,
-				       ":f2=%12u\n", mips_hpt_frequency);
-
-	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_INFO,
-				       ":mips_hpt_frequency=%uHz (%uMHz)\n",
-				       mips_hpt_frequency,
-				       mips_hpt_frequency / 1000000);
-#else
-	mips_hpt_frequency = 100000000;
+	rtc_ds1742_init(RBTX4927_RTC_BASE);
+	/*
+	 * Default TX4927 processor speed is 200 MHz. However, it
+	 * can be configured by the user
+	 */
+	mips_hpt_frequency = (CONFIG_TOSHIBA_TX4927_CPU_SPEED * 1000000) / 2;
-#endif
 
 	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_TIME_INIT, "+\n");
-
 }
 
 void __init toshiba_rbtx4927_timer_setup(struct irqaction *irq)
Index: linux-2.6.10/include/asm-mips/ds1742.h
===================================================================
--- /dev/null
+++ linux-2.6.10/include/asm-mips/ds1742.h
@@ -0,0 +1,29 @@
+/*
+ * Machine dependent access functions for RTC registers.
+ *
+ * Do not include this file directly. It's included from linux/ds1742rtc.h
+ *
+ * Author: Vladimir Barinov <vbarinov@ru.mvista.com>
+ *
+ * (c) 2005 MontaVista Software, Inc. This file is licensed under the
+ * terms of the GNU General Public License version 2. This program is
+ * licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#ifndef __LINUX_DS1742_H
+#define __LINUX_DS1742_H
+
+extern unsigned long rtc_base;
+
+static inline unsigned char CMOS_READ(unsigned long addr)
+{
+	return (*(volatile u8 *)(rtc_base + addr));
+}
+
+static inline void CMOS_WRITE(unsigned char data, unsigned long addr)
+{
+	*(volatile u8 *)(rtc_base + addr) = data;
+}
+
+#endif /* __LINUX_DS1742_H */
Index: linux-2.6.10/arch/mips/tx4927/Kconfig
===================================================================
--- linux-2.6.10/arch/mips/tx4927/Kconfig	2005-01-30 23:45:36.000000000 +0300
+++ linux-2.6.10/arch/mips/tx4927/Kconfig	2005-09-14 15:41:00.000000000 +0400
@@ -1,3 +1,11 @@
+config TOSHIBA_TX4927_CPU_SPEED
+        int "CPU speed of the TX4927 processor (MHz)"
+        depends on TOSHIBA_RBTX4927
+        default 200
+        help
+          This sets the speed for the TX4927 processor. The default speed
+          is 200 MHz.
+
 config TOSHIBA_FPCIB0
 	bool "FPCIB0 Backplane Support"
 	depends on TOSHIBA_RBTX4927

--------------050908050609050203010502--
