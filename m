Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Apr 2003 20:43:09 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:21243 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225208AbTDXTnI>;
	Thu, 24 Apr 2003 20:43:08 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h3OJh1629104;
	Thu, 24 Apr 2003 12:43:01 -0700
Date: Thu, 24 Apr 2003 12:43:01 -0700
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: ITE RTC update
Message-ID: <20030424124301.J28275@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="neYutvxvOLaeuPCA"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2175
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


It appears people still care about this board. :)

This patch implements rtc_set_time() function and
switches to use mips rtc driver.  It thus avoids a 
varying epoch problem (due to the "smart" epoch guessing
algorithm.) in the generic rtc driver.  There are also a bunch 
of other improvements (using century register, not overriding mode, etc)

Jun

--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="030423.ite-rtc.patch"

diff -Nru link/arch/mips/ite-boards/generic/time.c.orig link/arch/mips/ite-boards/generic/time.c
--- link/arch/mips/ite-boards/generic/time.c.orig	Thu Apr 17 13:56:58 2003
+++ link/arch/mips/ite-boards/generic/time.c	Wed Apr 23 16:12:02 2003
@@ -2,6 +2,9 @@
  * Carsten Langgaard, carstenl@mips.com
  * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
  *
+ * Copyright (C) 2003 MontaVista Software Inc.
+ * Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
+ *
  * ########################################################################
  *
  *  This program is free software; you can distribute it and/or modify it
@@ -27,13 +30,88 @@
 #include <linux/sched.h>
 #include <linux/spinlock.h>
 #include <linux/mc146818rtc.h>
-#include <linux/timex.h>
 
+#include <asm/time.h>
 #include <asm/mipsregs.h>
 #include <asm/ptrace.h>
+#include <asm/it8172/it8172.h>
 #include <asm/it8172/it8172_int.h>
 #include <asm/debug.h>
 
+#define IT8172_RTC_ADR_REG  (IT8172_PCI_IO_BASE + IT_RTC_BASE)
+#define IT8172_RTC_DAT_REG  (IT8172_RTC_ADR_REG + 1)
+#define IT8172_RTC_CENTURY_REG  (IT8172_PCI_IO_BASE + IT_RTC_CENTURY)
+
+static volatile char *rtc_adr_reg = (char*)KSEG1ADDR(IT8172_RTC_ADR_REG);
+static volatile char *rtc_dat_reg = (char*)KSEG1ADDR(IT8172_RTC_DAT_REG);
+static volatile char *rtc_century_reg = (char*)KSEG1ADDR(IT8172_RTC_CENTURY_REG);
+
+unsigned char it8172_rtc_read_data(unsigned long addr)
+{
+	unsigned char retval;
+
+	*rtc_adr_reg = addr;
+	retval =  *rtc_dat_reg;
+	return retval;
+}
+
+void it8172_rtc_write_data(unsigned char data, unsigned long addr)
+{
+	*rtc_adr_reg = addr;
+	*rtc_dat_reg = data;
+}
+
+#undef 	CMOS_READ
+#undef 	CMOS_WRITE
+#define	CMOS_READ(addr)			it8172_rtc_read_data(addr)
+#define CMOS_WRITE(data, addr) 		it8172_rtc_write_data(data, addr)
+
+static unsigned char saved_control;	/* remember rtc control reg */
+static inline int rtc_24h(void) { return saved_control & RTC_24H; }
+static inline int rtc_dm_binary(void) { return saved_control & RTC_DM_BINARY; }
+
+static inline unsigned char
+bin_to_hw(unsigned char c)
+{
+	if (rtc_dm_binary()) 
+		return c;
+	else
+		return ((c/10) << 4) + (c%10);
+}
+
+static inline unsigned char
+hw_to_bin(unsigned char c)
+{
+	if (rtc_dm_binary())
+		return c;
+	else
+		return (c>>4)*10 + (c &0xf);
+}
+
+/* 0x80 bit indicates pm in 12-hour format */
+static inline unsigned char
+hour_bin_to_hw(unsigned char c)
+{
+	if (rtc_24h()) 
+		return bin_to_hw(c);
+	if (c >= 12) 
+		return 0x80 | bin_to_hw((c==12)?12:c-12);  /* 12 is 12pm */
+	else
+		return bin_to_hw((c==0)?12:c);	/* 0 is 12 AM, not 0 am */
+}
+
+static inline unsigned char
+hour_hw_to_bin(unsigned char c)
+{
+	unsigned char tmp = hw_to_bin(c&0x3f);
+	if (rtc_24h())
+		return tmp;
+	if (c & 0x80) 
+		return (tmp==12)?12:tmp+12;  	/* 12pm is 12, not 24 */
+	else 
+		return (tmp==12)?0:tmp;		/* 12am is 0 */
+}
+
 static unsigned long r4k_offset; /* Amount to increment compare reg each time */
 static unsigned long r4k_cur;    /* What counter should be at next timer irq */
 extern unsigned int mips_counter_frequency;
@@ -68,39 +146,66 @@
 	return (mips_counter_frequency / HZ);
 }
 
-unsigned long it8172_rtc_get_time(void)
+static unsigned long 
+it8172_rtc_get_time(void)
 {
 	unsigned int year, mon, day, hour, min, sec;
-	unsigned char save_control;
-
-	save_control = CMOS_READ(RTC_CONTROL);
+	unsigned int flags;
 
-	/* Freeze it. */
-	CMOS_WRITE(save_control | RTC_SET, RTC_CONTROL);
+	/* avoid update-in-progress. */
+	for (;;) {
+		local_irq_save(flags);
+		if (! (CMOS_READ(RTC_REG_A) & RTC_UIP))
+			break;
+		/* don't hold intr closed all the time */
+		local_irq_restore(flags);
+	}
 
 	/* Read regs. */
-	sec = CMOS_READ(RTC_SECONDS);
-	min = CMOS_READ(RTC_MINUTES);
-	hour = CMOS_READ(RTC_HOURS);
-
-	if (!(save_control & RTC_24H))
-	{
-		if ((hour & 0xf) == 0xc)
-		        hour &= 0x80;
-	        if (hour & 0x80)
-		        hour = (hour & 0xf) + 12;
+	sec = hw_to_bin(CMOS_READ(RTC_SECONDS));
+	min = hw_to_bin(CMOS_READ(RTC_MINUTES));
+	hour = hour_hw_to_bin(CMOS_READ(RTC_HOURS));
+	day = hw_to_bin(CMOS_READ(RTC_DAY_OF_MONTH));
+	mon = hw_to_bin(CMOS_READ(RTC_MONTH));
+	year = hw_to_bin(CMOS_READ(RTC_YEAR)) + 
+		hw_to_bin(*rtc_century_reg) * 100;
+
+	/* restore interrupts */
+	local_irq_restore(flags);
+		
+	return mktime(year, mon, day, hour, min, sec);
+}
+
+static int
+it8172_rtc_set_time(unsigned long t)
+{
+	struct rtc_time tm;
+	unsigned int flags;
+
+	/* convert */
+	to_tm(t, &tm);
+
+	/* avoid update-in-progress. */
+	for (;;) {
+		local_irq_save(flags);
+		if (! (CMOS_READ(RTC_REG_A) & RTC_UIP))
+			break;
+		/* don't hold intr closed all the time */
+		local_irq_restore(flags);
 	}
-	day = CMOS_READ(RTC_DAY_OF_MONTH);
-	mon = CMOS_READ(RTC_MONTH);
-	year = CMOS_READ(RTC_YEAR);
 
-	/* Unfreeze clock. */
-	CMOS_WRITE(save_control, RTC_CONTROL);
+	*rtc_century_reg = bin_to_hw(tm.tm_year/100);
+	CMOS_WRITE(bin_to_hw(tm.tm_sec), RTC_SECONDS);
+	CMOS_WRITE(bin_to_hw(tm.tm_min), RTC_MINUTES);
+	CMOS_WRITE(hour_bin_to_hw(tm.tm_hour), RTC_HOURS);
+	CMOS_WRITE(bin_to_hw(tm.tm_mday), RTC_DAY_OF_MONTH);
+	CMOS_WRITE(bin_to_hw(tm.tm_mon+1), RTC_MONTH);	/* tm_mon starts from 0 */
+	CMOS_WRITE(bin_to_hw(tm.tm_year%100), RTC_YEAR);
 
-	if ((year += 1900) < 1970)
-	        year += 100;
+	/* restore interrupts */
+	local_irq_restore(flags);
 
-	return mktime(year, mon, day, hour, min, sec);
+	return 0;
 }
 
 void __init it8172_time_init(void)
@@ -109,8 +214,8 @@
         unsigned int est_freq;
 
 	local_irq_save(flags);
-        /* Set Data mode - binary. */
-        CMOS_WRITE(CMOS_READ(RTC_CONTROL) | RTC_DM_BINARY, RTC_CONTROL);
+
+	saved_control = CMOS_READ(RTC_CONTROL);
 
 	printk("calculating r4koff... ");
 	r4k_offset = cal_r4koff();
@@ -121,7 +226,11 @@
 	est_freq -= est_freq%10000;
 	printk("CPU frequency %d.%02d MHz\n", est_freq/1000000,
 	       (est_freq%1000000)*100/1000000);
+
 	local_irq_restore(flags);
+
+	rtc_get_time = it8172_rtc_get_time;
+	rtc_set_time = it8172_rtc_set_time;
 }
 
 #define ALLINTS (IE_IRQ0 | IE_IRQ1 | IE_IRQ2 | IE_IRQ3 | IE_IRQ4 | IE_IRQ5)
diff -Nru link/arch/mips/ite-boards/generic/Makefile.orig link/arch/mips/ite-boards/generic/Makefile
--- link/arch/mips/ite-boards/generic/Makefile.orig	Wed Feb 26 17:06:27 2003
+++ link/arch/mips/ite-boards/generic/Makefile	Wed Apr 23 16:05:03 2003
@@ -16,7 +16,7 @@
 
 O_TARGET := it8172.o
 
-obj-y := it8172_rtc.o it8172_setup.o irq.o int-handler.o pmon_prom.o time.o lpc.o puts.o reset.o
+obj-y := it8172_setup.o irq.o int-handler.o pmon_prom.o time.o lpc.o puts.o reset.o
 
 obj-$(CONFIG_PCI) += it8172_pci.o
 obj-$(CONFIG_IT8172_CIR) += it8172_cir.o
diff -Nru link/arch/mips/ite-boards/generic/it8172_rtc.c.orig link/arch/mips/ite-boards/generic/it8172_rtc.c
--- link/arch/mips/ite-boards/generic/it8172_rtc.c.orig	Sat Mar 17 20:30:27 2001
+++ link/arch/mips/ite-boards/generic/it8172_rtc.c	Wed Apr 23 16:05:03 2003
@@ -1,62 +0,0 @@
-/*
- * Copyright 2000 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *         	ppopov@mvista.com or source@mvista.com
- *
- * Carsten Langgaard, carstenl@mips.com
- * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
- *
- * ########################################################################
- *
- *  This program is free software; you can distribute it and/or modify it
- *  under the terms of the GNU General Public License (Version 2) as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope it will be useful, but WITHOUT
- *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
- *  for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
- *
- * ########################################################################
- *
- * RTC routines for ITE8172 MC146818-compatible rtc chip.
- *
- */
-#include <linux/mc146818rtc.h>
-#include <asm/it8172/it8172.h>
-
-#define IT8172_RTC_ADR_REG  (IT8172_PCI_IO_BASE + IT_RTC_BASE)
-#define IT8172_RTC_DAT_REG  (IT8172_RTC_ADR_REG + 1)
-
-static volatile char *rtc_adr_reg = KSEG1ADDR((volatile char *)IT8172_RTC_ADR_REG);
-static volatile char *rtc_dat_reg = KSEG1ADDR((volatile char *)IT8172_RTC_DAT_REG);
-
-unsigned char it8172_rtc_read_data(unsigned long addr)
-{
-	unsigned char retval;
-
-	*rtc_adr_reg = addr;
-	retval =  *rtc_dat_reg;
-	return retval;
-}
-
-void it8172_rtc_write_data(unsigned char data, unsigned long addr)
-{
-	*rtc_adr_reg = addr;
-	*rtc_dat_reg = data;
-}
-
-static int it8172_rtc_bcd_mode(void)
-{
-	return 0;
-}
-
-struct rtc_ops it8172_rtc_ops = {
-	&it8172_rtc_read_data,
-	&it8172_rtc_write_data,
-	&it8172_rtc_bcd_mode
-};
diff -Nru link/arch/mips/ite-boards/generic/it8172_setup.c.orig link/arch/mips/ite-boards/generic/it8172_setup.c
--- link/arch/mips/ite-boards/generic/it8172_setup.c.orig	Thu Apr 17 13:56:58 2003
+++ link/arch/mips/ite-boards/generic/it8172_setup.c	Wed Apr 23 16:14:28 2003
@@ -32,12 +32,13 @@
 #include <linux/sched.h>
 #include <linux/ioport.h>
 #include <linux/console.h>
-#include <linux/mc146818rtc.h>
 #include <linux/serial_reg.h>
 
 #include <asm/cpu.h>
 #include <asm/bootinfo.h>
 #include <asm/irq.h>
+#include <asm/time.h>
+#include <asm/io.h>
 #include <asm/mipsregs.h>
 #include <asm/reboot.h>
 #include <asm/traps.h>
@@ -52,7 +53,6 @@
 char serial_console[20];
 #endif
 
-extern struct rtc_ops it8172_rtc_ops;
 extern struct resource ioport_resource;
 #ifdef CONFIG_BLK_DEV_IDE
 extern struct ide_ops std_ide_ops;
@@ -72,11 +72,8 @@
 
 extern void (*board_time_init)(void);
 extern void (*board_timer_setup)(struct irqaction *irq);
-extern unsigned long (*rtc_get_time)(void);
-extern int (*rtc_set_time)(unsigned long);
 extern void it8172_time_init(void);
 extern void it8172_timer_setup(struct irqaction *irq);
-extern unsigned long it8172_rtc_get_time(void);
 
 #ifdef CONFIG_IT8172_REVC
 struct {
@@ -135,12 +132,9 @@
 #endif
 
 	clear_c0_status(ST0_FR);
-	rtc_ops = &it8172_rtc_ops;
 
 	board_time_init = it8172_time_init;
 	board_timer_setup = it8172_timer_setup;
-	rtc_get_time = it8172_rtc_get_time;
-	//rtc_set_time = it8172_rtc_set_time;
 
 	_machine_restart = it8172_restart;
 	_machine_halt = it8172_halt;
diff -Nru link/arch/mips/defconfig-it8172.orig link/arch/mips/defconfig-it8172
--- link/arch/mips/defconfig-it8172.orig	Thu Apr 17 13:56:57 2003
+++ link/arch/mips/defconfig-it8172	Wed Apr 23 16:17:47 2003
@@ -584,8 +584,8 @@
 # CONFIG_SCx200_GPIO is not set
 # CONFIG_AMD_PM768 is not set
 # CONFIG_NVRAM is not set
-CONFIG_RTC=y
-# CONFIG_MIPS_RTC is not set
+# CONFIG_RTC is not set
+CONFIG_MIPS_RTC=y
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
diff -Nru link/include/asm-mips/it8172/it8172.h.orig link/include/asm-mips/it8172/it8172.h
--- link/include/asm-mips/it8172/it8172.h.orig	Mon Aug  5 16:53:38 2002
+++ link/include/asm-mips/it8172/it8172.h	Wed Apr 23 16:05:03 2003
@@ -193,6 +193,8 @@
 
 // IT8172 RTC
 #define IT_RTC_BASE				0x14800
+#define IT_RTC_CENTURY				0x14808
+
 #define IT_RTC_RIR0				0x00
 #define IT_RTC_RTR0				0x01
 #define IT_RTC_RIR1				0x02
diff -Nru link/include/asm-mips/mc146818rtc.h.orig link/include/asm-mips/mc146818rtc.h
--- link/include/asm-mips/mc146818rtc.h.orig	Mon Apr 21 13:58:21 2003
+++ link/include/asm-mips/mc146818rtc.h	Wed Apr 23 16:15:38 2003
@@ -50,14 +50,6 @@
 
 #include <asm/dec/rtc-dec.h>
 
-#elif defined(CONFIG_MIPS_ITE8172) || defined(CONFIG_MIPS_IVR)
-
-#include <asm/it8172/it8172_int.h>
-
-#define RTC_PORT(x)	(0x14014800 + (x))
-#define RTC_IOMAPPED	0
-#define RTC_IRQ		IT8172_RTC_IRQ
-
 #elif defined(CONFIG_MIPS_PB1500) || defined(CONFIG_MIPS_PB1100)
 
 #define RTC_PORT(x)	(0x0c000000 + (x))

--neYutvxvOLaeuPCA--
