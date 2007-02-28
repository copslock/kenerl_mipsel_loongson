Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Feb 2007 15:41:50 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:62921 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20039331AbXB1Plp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 28 Feb 2007 15:41:45 +0000
Received: from localhost (p5152-ipad28funabasi.chiba.ocn.ne.jp [220.107.204.152])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id DE09FB6E3; Thu,  1 Mar 2007 00:40:21 +0900 (JST)
Date:	Thu, 01 Mar 2007 00:40:21 +0900 (JST)
Message-Id: <20070301.004021.41012099.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, sshtylyov@ru.mvista.com
Subject: [PATCH] Convert to RTC-class ds1742 driver
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14276
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

The generic rtc-ds1742 driver can be used for RBTX4927 and JMR3927
(with __swizzle_addr trick).  This patch also removes MIPS local
DS1742 stuff.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/Kconfig                                          |    4 
 arch/mips/configs/jmr3927_defconfig                        |   24 +
 arch/mips/jmr3927/common/Makefile                          |    2 
 arch/mips/jmr3927/common/rtc_ds1742.c                      |  171 -----------
 arch/mips/jmr3927/rbhma3100/setup.c                        |   39 +-
 arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c   |    3 
 arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c |   76 ----
 include/asm-mips/ds1742.h                                  |   13 
 include/asm-mips/jmr3927/jmr3927.h                         |    6 
 include/asm-mips/mach-jmr3927/ds1742.h                     |   16 -
 include/asm-mips/mach-jmr3927/mangle-port.h                |   18 +
 include/linux/ds1742rtc.h                                  |   53 ---
 12 files changed, 86 insertions(+), 339 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index dbcd2b4..af40849 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1895,10 +1895,6 @@ config HZ
 
 source "kernel/Kconfig.preempt"
 
-config RTC_DS1742
-	bool "DS1742 BRAM/RTC support"
-	depends on TOSHIBA_JMR3927 || TOSHIBA_RBTX4927
-
 config MIPS_INSANE_LARGE
 	bool "Support for large 64-bit configurations"
 	depends on CPU_R10000 && 64BIT
diff --git a/arch/mips/configs/jmr3927_defconfig b/arch/mips/configs/jmr3927_defconfig
index 9ebb522..98b9fbc 100644
--- a/arch/mips/configs/jmr3927_defconfig
+++ b/arch/mips/configs/jmr3927_defconfig
@@ -148,7 +148,6 @@ CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
-CONFIG_RTC_DS1742=y
 # CONFIG_KEXEC is not set
 CONFIG_LOCKDEP_SUPPORT=y
 CONFIG_STACKTRACE_SUPPORT=y
@@ -802,7 +801,28 @@ CONFIG_USB_ARCH_HAS_EHCI=y
 #
 # Real Time Clock
 #
-# CONFIG_RTC_CLASS is not set
+CONFIG_RTC_LIB=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_HCTOSYS=y
+CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
+# CONFIG_RTC_DEBUG is not set
+
+#
+# RTC interfaces
+#
+CONFIG_RTC_INTF_SYSFS=y
+CONFIG_RTC_INTF_PROC=y
+CONFIG_RTC_INTF_DEV=y
+# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
+
+#
+# RTC drivers
+#
+# CONFIG_RTC_DRV_DS1553 is not set
+CONFIG_RTC_DRV_DS1742=y
+# CONFIG_RTC_DRV_M48T86 is not set
+# CONFIG_RTC_DRV_TEST is not set
+# CONFIG_RTC_DRV_V3020 is not set
 
 #
 # DMA Engine support
diff --git a/arch/mips/jmr3927/common/Makefile b/arch/mips/jmr3927/common/Makefile
index cb09a8e..01e7db1 100644
--- a/arch/mips/jmr3927/common/Makefile
+++ b/arch/mips/jmr3927/common/Makefile
@@ -2,4 +2,4 @@
 # Makefile for the common code of TOSHIBA JMR-TX3927 board
 #
 
-obj-y	 += prom.o puts.o rtc_ds1742.o
+obj-y	 += prom.o puts.o
diff --git a/arch/mips/jmr3927/common/rtc_ds1742.c b/arch/mips/jmr3927/common/rtc_ds1742.c
deleted file mode 100644
index e656134..0000000
--- a/arch/mips/jmr3927/common/rtc_ds1742.c
+++ /dev/null
@@ -1,171 +0,0 @@
-/*
- * Copyright 2001 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *              ahennessy@mvista.com
- *
- * arch/mips/jmr3927/common/rtc_ds1742.c
- * Based on arch/mips/ddb5xxx/common/rtc_ds1386.c
- *     low-level RTC hookups for s for Dallas 1742 chip.
- *
- * Copyright (C) 2000-2001 Toshiba Corporation
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-
-/*
- * This file exports a function, rtc_ds1386_init(), which expects an
- * uncached base address as the argument.  It will set the two function
- * pointers expected by the MIPS generic timer code.
- */
-
-#include <linux/bcd.h>
-#include <linux/types.h>
-#include <linux/time.h>
-#include <linux/rtc.h>
-#include <linux/ds1742rtc.h>
-
-#include <asm/time.h>
-#include <asm/addrspace.h>
-
-#include <asm/debug.h>
-
-#define	EPOCH		2000
-
-static unsigned long rtc_base;
-
-static unsigned long
-rtc_ds1742_get_time(void)
-{
-	unsigned int year, month, day, hour, minute, second;
-	unsigned int century;
-	unsigned long flags;
-
-	spin_lock_irqsave(&rtc_lock, flags);
-	rtc_write(RTC_READ, RTC_CONTROL);
-	second = BCD2BIN(rtc_read(RTC_SECONDS) & RTC_SECONDS_MASK);
-	minute = BCD2BIN(rtc_read(RTC_MINUTES));
-	hour = BCD2BIN(rtc_read(RTC_HOURS));
-	day = BCD2BIN(rtc_read(RTC_DATE));
-	month = BCD2BIN(rtc_read(RTC_MONTH));
-	year = BCD2BIN(rtc_read(RTC_YEAR));
-	century = BCD2BIN(rtc_read(RTC_CENTURY) & RTC_CENTURY_MASK);
-	rtc_write(0, RTC_CONTROL);
-	spin_unlock_irqrestore(&rtc_lock, flags);
-
-	year += century * 100;
-
-	return mktime(year, month, day, hour, minute, second);
-}
-extern void to_tm(unsigned long tim, struct rtc_time * tm);
-
-static int
-rtc_ds1742_set_time(unsigned long t)
-{
-	struct rtc_time tm;
-	u8 year, month, day, hour, minute, second;
-	u8 cmos_year, cmos_month, cmos_day, cmos_hour, cmos_minute, cmos_second;
-	int cmos_century;
-	unsigned long flags;
-
-	spin_lock_irqsave(&rtc_lock, flags);
-	rtc_write(RTC_READ, RTC_CONTROL);
-	cmos_second = (u8)(rtc_read(RTC_SECONDS) & RTC_SECONDS_MASK);
-	cmos_minute = (u8)rtc_read(RTC_MINUTES);
-	cmos_hour = (u8)rtc_read(RTC_HOURS);
-	cmos_day = (u8)rtc_read(RTC_DATE);
-	cmos_month = (u8)rtc_read(RTC_MONTH);
-	cmos_year = (u8)rtc_read(RTC_YEAR);
-	cmos_century = rtc_read(RTC_CENTURY) & RTC_CENTURY_MASK;
-
-	rtc_write(RTC_WRITE, RTC_CONTROL);
-
-	/* convert */
-	to_tm(t, &tm);
-
-	/* check each field one by one */
-	year = BIN2BCD(tm.tm_year - EPOCH);
-	if (year != cmos_year) {
-		rtc_write(year,RTC_YEAR);
-	}
-
-	month = BIN2BCD(tm.tm_mon);
-	if (month != (cmos_month & 0x1f)) {
-		rtc_write((month & 0x1f) | (cmos_month & ~0x1f),RTC_MONTH);
-	}
-
-	day = BIN2BCD(tm.tm_mday);
-	if (day != cmos_day) {
-
-		rtc_write(day, RTC_DATE);
-	}
-
-	if (cmos_hour & 0x40) {
-		/* 12 hour format */
-		hour = 0x40;
-		if (tm.tm_hour > 12) {
-			hour |= 0x20 | (BIN2BCD(hour-12) & 0x1f);
-		} else {
-			hour |= BIN2BCD(tm.tm_hour);
-		}
-	} else {
-		/* 24 hour format */
-		hour = BIN2BCD(tm.tm_hour) & 0x3f;
-	}
-	if (hour != cmos_hour) rtc_write(hour, RTC_HOURS);
-
-	minute = BIN2BCD(tm.tm_min);
-	if (minute !=  cmos_minute) {
-		rtc_write(minute, RTC_MINUTES);
-	}
-
-	second = BIN2BCD(tm.tm_sec);
-	if (second !=  cmos_second) {
-		rtc_write(second & RTC_SECONDS_MASK,RTC_SECONDS);
-	}
-
-	/* RTC_CENTURY and RTC_CONTROL share same address... */
-	rtc_write(cmos_century, RTC_CONTROL);
-	spin_unlock_irqrestore(&rtc_lock, flags);
-
-	return 0;
-}
-
-void
-rtc_ds1742_init(unsigned long base)
-{
-	u8  cmos_second;
-
-	/* remember the base */
-	rtc_base = base;
-	db_assert((rtc_base & 0xe0000000) == KSEG1);
-
-	/* set the function pointers */
-	rtc_mips_get_time = rtc_ds1742_get_time;
-	rtc_mips_set_time = rtc_ds1742_set_time;
-
-	/* clear oscillator stop bit */
-	rtc_write(RTC_READ, RTC_CONTROL);
-	cmos_second = (u8)(rtc_read(RTC_SECONDS) & RTC_SECONDS_MASK);
-	rtc_write(RTC_WRITE, RTC_CONTROL);
-	rtc_write(cmos_second, RTC_SECONDS); /* clear msb */
-	rtc_write(0, RTC_CONTROL);
-}
diff --git a/arch/mips/jmr3927/rbhma3100/setup.c b/arch/mips/jmr3927/rbhma3100/setup.c
index ecabe5b..fc523bd 100644
--- a/arch/mips/jmr3927/rbhma3100/setup.c
+++ b/arch/mips/jmr3927/rbhma3100/setup.c
@@ -45,6 +45,7 @@
 #include <linux/param.h>	/* for HZ */
 #include <linux/delay.h>
 #include <linux/pm.h>
+#include <linux/platform_device.h>
 #ifdef CONFIG_SERIAL_TXX9
 #include <linux/tty.h>
 #include <linux/serial.h>
@@ -172,19 +173,10 @@ static cycle_t jmr3927_hpt_read(void)
 	return jiffies * (JMR3927_TIMER_CLK / HZ) + jmr3927_tmrptr->trr;
 }
 
-#define USE_RTC_DS1742
-#ifdef USE_RTC_DS1742
-extern void rtc_ds1742_init(unsigned long base);
-#endif
 static void __init jmr3927_time_init(void)
 {
 	clocksource_mips.read = jmr3927_hpt_read;
 	mips_hpt_frequency = JMR3927_TIMER_CLK;
-#ifdef USE_RTC_DS1742
-	if (jmr3927_have_nvram()) {
-	        rtc_ds1742_init(JMR3927_IOC_NVRAMB_ADDR);
-	}
-#endif
 }
 
 void __init plat_timer_setup(struct irqaction *irq)
@@ -540,3 +532,32 @@ void __init tx3927_setup(void)
                        printk("TX3927 D-Cache WriteBack (CWF) .\n");
 	}
 }
+
+/* This trick makes rtc-ds1742 driver usable as is. */
+unsigned long __swizzle_addr_b(unsigned long port)
+{
+	if ((port & 0xffff0000) != JMR3927_IOC_NVRAMB_ADDR)
+		return port;
+	port = (port & 0xffff0000) | (port & 0x7fff << 1);
+#ifdef __BIG_ENDIAN
+	return port;
+#else
+	return port | 1;
+#endif
+}
+EXPORT_SYMBOL(__swizzle_addr_b);
+
+static int __init jmr3927_rtc_init(void)
+{
+	struct resource res = {
+		.start	= JMR3927_IOC_NVRAMB_ADDR - IO_BASE,
+		.end	= JMR3927_IOC_NVRAMB_ADDR - IO_BASE + 0x800 - 1,
+		.flags	= IORESOURCE_MEM,
+	};
+	struct platform_device *dev;
+	if (!jmr3927_have_nvram())
+		return -ENODEV;
+	dev = platform_device_register_simple("ds1742", -1, &res, 1);
+	return IS_ERR(dev) ? PTR_ERR(dev) : 0;
+}
+device_initcall(jmr3927_rtc_init);
diff --git a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
index dcce88f..5cc30c1 100644
--- a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
+++ b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
@@ -132,9 +132,6 @@ JP7 is not bus master -- do NOT use -- o
 #include <asm/wbflush.h>
 #include <linux/bootmem.h>
 #include <linux/blkdev.h>
-#ifdef CONFIG_RTC_DS1742
-#include <linux/ds1742rtc.h>
-#endif
 #ifdef CONFIG_TOSHIBA_FPCIB0
 #include <asm/tx4927/smsc_fdc37m81x.h>
 #endif
diff --git a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
index 7316a78..0f7576d 100644
--- a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
+++ b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
@@ -53,6 +53,7 @@
 #include <linux/pci.h>
 #include <linux/timex.h>
 #include <linux/pm.h>
+#include <linux/platform_device.h>
 
 #include <asm/bootinfo.h>
 #include <asm/page.h>
@@ -64,9 +65,6 @@
 #include <asm/time.h>
 #include <linux/bootmem.h>
 #include <linux/blkdev.h>
-#ifdef CONFIG_RTC_DS1742
-#include <linux/ds1742rtc.h>
-#endif
 #ifdef CONFIG_TOSHIBA_FPCIB0
 #include <asm/tx4927/smsc_fdc37m81x.h>
 #endif
@@ -1020,69 +1018,12 @@ void __init toshiba_rbtx4927_setup(void)
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
-	u32 c1;
-	u32 c2;
-
 	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_TIME_INIT, "-\n");
 
-#ifdef CONFIG_RTC_DS1742
-
-	rtc_mips_get_time = rtc_ds1742_get_time;
-	rtc_mips_set_time = rtc_ds1742_set_time;
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
-#endif
+	mips_hpt_frequency = tx4927_cpu_clock / 2;
 
 	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_TIME_INIT, "+\n");
 
@@ -1095,3 +1036,16 @@ void __init toshiba_rbtx4927_timer_setup
 	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_TIMER_SETUP,
 				       "+\n");
 }
+
+static int __init toshiba_rbtx4927_rtc_init(void)
+{
+	struct resource res = {
+		.start	= 0x1c010000,
+		.end	= 0x1c010000 + 0x800 - 1,
+		.flags	= IORESOURCE_MEM,
+	};
+	struct platform_device *dev =
+		platform_device_register_simple("ds1742", -1, &res, 1);
+	return IS_ERR(dev) ? PTR_ERR(dev) : 0;
+}
+device_initcall(toshiba_rbtx4927_rtc_init);
diff --git a/include/asm-mips/ds1742.h b/include/asm-mips/ds1742.h
deleted file mode 100644
index c2f2c32..0000000
--- a/include/asm-mips/ds1742.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2006 by Ralf Baechle (ralf@linux-mips.org)
- */
-#ifndef _ASM_DS1742_H
-#define _ASM_DS1742_H
-
-#include <ds1742.h>
-
-#endif /* _ASM_DS1742_H */
diff --git a/include/asm-mips/jmr3927/jmr3927.h b/include/asm-mips/jmr3927/jmr3927.h
index baf4129..c50e68f 100644
--- a/include/asm-mips/jmr3927/jmr3927.h
+++ b/include/asm-mips/jmr3927/jmr3927.h
@@ -179,12 +179,6 @@ static inline int jmr3927_have_isac(void
 #define jmr3927_have_nvram() \
 	((jmr3927_ioc_reg_in(JMR3927_IOC_REV_ADDR) & JMR3927_IDT_MASK) == JMR3927_IOC_IDT)
 
-/* NVRAM macro */
-#define jmr3927_nvram_in(ofs) \
-	jmr3927_ioc_reg_in(JMR3927_IOC_NVRAMB_ADDR + ((ofs) << 1))
-#define jmr3927_nvram_out(d, ofs) \
-	jmr3927_ioc_reg_out(d, JMR3927_IOC_NVRAMB_ADDR + ((ofs) << 1))
-
 /* LED macro */
 #define jmr3927_led_set(n/*0-16*/)	jmr3927_ioc_reg_out(~(n), JMR3927_IOC_LED_ADDR)
 #define jmr3927_io_led_set(n/*0-3*/)	jmr3927_isac_reg_out((n), JMR3927_ISAC_LED_ADDR)
diff --git a/include/asm-mips/mach-jmr3927/ds1742.h b/include/asm-mips/mach-jmr3927/ds1742.h
deleted file mode 100644
index 8a8fef6..0000000
--- a/include/asm-mips/mach-jmr3927/ds1742.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2003, 06 by Ralf Baechle
- */
-#ifndef __ASM_MACH_JMR3927_DS1742_H
-#define __ASM_MACH_JMR3927_DS1742_H
-
-#include <asm/jmr3927/jmr3927.h>
-
-#define rtc_read(reg)		(jmr3927_nvram_in(reg))
-#define rtc_write(data, reg)	(jmr3927_nvram_out((data),(reg)))
-
-#endif /* __ASM_MACH_JMR3927_DS1742_H */
diff --git a/include/asm-mips/mach-jmr3927/mangle-port.h b/include/asm-mips/mach-jmr3927/mangle-port.h
new file mode 100644
index 0000000..501a202
--- /dev/null
+++ b/include/asm-mips/mach-jmr3927/mangle-port.h
@@ -0,0 +1,18 @@
+#ifndef __ASM_MACH_JMR3927_MANGLE_PORT_H
+#define __ASM_MACH_JMR3927_MANGLE_PORT_H
+
+extern unsigned long __swizzle_addr_b(unsigned long port);
+#define __swizzle_addr_w(port)	(port)
+#define __swizzle_addr_l(port)	(port)
+#define __swizzle_addr_q(port)	(port)
+
+#define ioswabb(a,x)		(x)
+#define __mem_ioswabb(a,x)	(x)
+#define ioswabw(a,x)		le16_to_cpu(x)
+#define __mem_ioswabw(a,x)	(x)
+#define ioswabl(a,x)		le32_to_cpu(x)
+#define __mem_ioswabl(a,x)	(x)
+#define ioswabq(a,x)		le64_to_cpu(x)
+#define __mem_ioswabq(a,x)	(x)
+
+#endif /* __ASM_MACH_JMR3927_MANGLE_PORT_H */
diff --git a/include/linux/ds1742rtc.h b/include/linux/ds1742rtc.h
deleted file mode 100644
index a83cdd1..0000000
--- a/include/linux/ds1742rtc.h
+++ /dev/null
@@ -1,53 +0,0 @@
-/*
- * ds1742rtc.h - register definitions for the Real-Time-Clock / CMOS RAM
- *
- * Copyright (C) 1999-2001 Toshiba Corporation
- * Copyright (C) 2003 Ralf Baechle (ralf@linux-mips.org)
- *
- * Permission is hereby granted to copy, modify and redistribute this code
- * in terms of the GNU Library General Public License, Version 2 or later,
- * at your option.
- */
-#ifndef __LINUX_DS1742RTC_H
-#define __LINUX_DS1742RTC_H
-
-#include <asm/ds1742.h>
-
-#define RTC_BRAM_SIZE		0x800
-#define RTC_OFFSET		0x7f8
-
-/*
- * Register summary
- */
-#define RTC_CONTROL		(RTC_OFFSET + 0)
-#define RTC_CENTURY		(RTC_OFFSET + 0)
-#define RTC_SECONDS		(RTC_OFFSET + 1)
-#define RTC_MINUTES		(RTC_OFFSET + 2)
-#define RTC_HOURS		(RTC_OFFSET + 3)
-#define RTC_DAY			(RTC_OFFSET + 4)
-#define RTC_DATE		(RTC_OFFSET + 5)
-#define RTC_MONTH		(RTC_OFFSET + 6)
-#define RTC_YEAR		(RTC_OFFSET + 7)
-
-#define RTC_CENTURY_MASK	0x3f
-#define RTC_SECONDS_MASK	0x7f
-#define RTC_DAY_MASK		0x07
-
-/*
- * Bits in the Control/Century register
- */
-#define RTC_WRITE		0x80
-#define RTC_READ		0x40
-
-/*
- * Bits in the Seconds register
- */
-#define RTC_STOP		0x80
-
-/*
- * Bits in the Day register
- */
-#define RTC_BATT_FLAG		0x80
-#define RTC_FREQ_TEST		0x40
-
-#endif /* __LINUX_DS1742RTC_H */
