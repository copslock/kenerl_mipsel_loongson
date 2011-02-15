Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Feb 2011 12:40:32 +0100 (CET)
Received: from qmta06.emeryville.ca.mail.comcast.net ([76.96.30.56]:44477 "EHLO
        qmta06.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491009Ab1BOLkU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Feb 2011 12:40:20 +0100
Received: from omta18.emeryville.ca.mail.comcast.net ([76.96.30.74])
        by qmta06.emeryville.ca.mail.comcast.net with comcast
        id 8BgD1g0031bwxycA6BgDDq; Tue, 15 Feb 2011 11:40:13 +0000
Received: from [192.168.1.13] ([69.251.104.163])
        by omta18.emeryville.ca.mail.comcast.net with comcast
        id 8BgB1g0073XYSBH8eBgCKv; Tue, 15 Feb 2011 11:40:13 +0000
Message-ID: <4D5A65E3.1050707@gentoo.org>
Date:   Tue, 15 Feb 2011 06:39:15 -0500
From:   Kumba <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b2 Thunderbird/3.1.7
MIME-Version: 1.0
To:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: [PATCH 1/2]: Add support for Dallas/Maxim DS1685/1687 RTC
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29180
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Add Dallas/Maxim DS1685/1687 RTC Support.

Signed-off-by: Joshua Kinard <kumba@gentoo.org>
---
  drivers/rtc/Kconfig        |   13
  drivers/rtc/Makefile       |    1
  drivers/rtc/rtc-ds1685.c   |  875 +++++++++++++++++++++++++++++++++++++++++++++
  include/linux/rtc/ds1685.h |  401 ++++++++++++++++++++
  4 files changed, 1290 insertions(+)

diff -Naurp linux-2.6.37.orig/drivers/rtc/Kconfig 
linux-2.6.37.rtc-ds1685/drivers/rtc/Kconfig
--- linux-2.6.37.orig/drivers/rtc/Kconfig	2011-02-15 02:58:36.512076002 -0500
+++ linux-2.6.37.rtc-ds1685/drivers/rtc/Kconfig	2011-02-15 04:20:59.932076001 -0500
@@ -499,6 +499,19 @@ config RTC_DRV_DS1553
  	  This driver can also be built as a module. If so, the module
  	  will be called rtc-ds1553.

+config RTC_DRV_DS1685
+	tristate "Dallas/Maxim DS1685/DS1687"
+	depends on I2C
+	help
+	  If you say yes here you get support for the Dallas/Maxim
+	  DS1685/DS1687 timekeeping chip.
+
+	  Systems that use this chip include EPPC-405-UC modules, by
+	  electronic system design GmbH.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-ds1685.
+
  config RTC_DRV_DS1742
  	tristate "Maxim/Dallas DS1742/1743"
  	help
diff -Naurp linux-2.6.37.orig/drivers/rtc/Makefile 
linux-2.6.37.rtc-ds1685/drivers/rtc/Makefile
--- linux-2.6.37.orig/drivers/rtc/Makefile	2011-02-15 02:58:36.512076002 -0500
+++ linux-2.6.37.rtc-ds1685/drivers/rtc/Makefile	2011-02-15 04:17:15.372075999 -0500
@@ -40,6 +40,7 @@ obj-$(CONFIG_RTC_DRV_DS1390)	+= rtc-ds13
  obj-$(CONFIG_RTC_DRV_DS1511)	+= rtc-ds1511.o
  obj-$(CONFIG_RTC_DRV_DS1553)	+= rtc-ds1553.o
  obj-$(CONFIG_RTC_DRV_DS1672)	+= rtc-ds1672.o
+obj-$(CONFIG_RTC_DRV_DS1685)	+= rtc-ds1685.o
  obj-$(CONFIG_RTC_DRV_DS1742)	+= rtc-ds1742.o
  obj-$(CONFIG_RTC_DRV_DS3232)	+= rtc-ds3232.o
  obj-$(CONFIG_RTC_DRV_DS3234)	+= rtc-ds3234.o
diff -Naurp linux-2.6.37.orig/drivers/rtc/rtc-ds1685.c 
linux-2.6.37.rtc-ds1685/drivers/rtc/rtc-ds1685.c
--- linux-2.6.37.orig/drivers/rtc/rtc-ds1685.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.37.rtc-ds1685/drivers/rtc/rtc-ds1685.c	2011-02-15 
04:22:50.032076002 -0500
@@ -0,0 +1,875 @@
+/*
+ * An rtc driver for the Dallas DS1685/DS1687.
+ *
+ * Copyright (C) 2009 Matthias Fuchs <matthias.fuchs@esd-electronics.com>.
+ * Copyright (C) 2010 Joshua Kinard <kumba@gentoo.org>.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/bcd.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/jiffies.h>
+#include <linux/module.h>
+#include <linux/rtc.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/rtc/ds1685.h>
+#ifdef CONFIG_PROC_FS
+#include <linux/proc_fs.h>
+#endif
+
+#define DRV_VERSION	"0.3"
+
+static int
+ds1685_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct ds1685_priv *pdata = platform_get_drvdata(pdev);
+	struct ds1685_rtc_regs __iomem *regs = pdata->regs;
+	unsigned long flags, start = jiffies;
+	unsigned int data;
+	unsigned int ctrlb, century;
+	unsigned int seconds, minutes, hours, wday, mday, month, years;
+
+	/* Fetch the time info from the RTC registers. */
+	ds1685_rtc_begin_data_access;
+	seconds	= readb(&regs->time.sec);
+	minutes	= readb(&regs->time.min);
+	hours	= readb(&regs->time.hour);
+	wday	= readb(&regs->time.wday);
+	mday	= readb(&regs->time.mday);
+	month	= readb(&regs->time.month);
+	years	= readb(&regs->time.year);
+	century	= readb(&regs->bank1.century);
+	ctrlb	= readb(&regs->time.ctrlb);
+	ds1685_rtc_end_data_access;
+
+	/* Convert to Binary, perform fixups, and store to rtc_time. */
+	tm->tm_sec	= bcd2bin(seconds);
+	tm->tm_min	= bcd2bin(minutes);
+	tm->tm_hour	= bcd2bin(hours);
+	tm->tm_wday	= (bcd2bin(wday) - 1);
+	tm->tm_mday	= bcd2bin(mday);
+	tm->tm_mon	= (bcd2bin(month) - 1);
+	tm->tm_year	= ((bcd2bin(years) + (bcd2bin(century) * 100)) - 1900);
+	tm->tm_yday	= rtc_year_days(tm->tm_mday, tm->tm_mon, tm->tm_year);
+	tm->tm_isdst	= ((ctrlb & RTC_CTRL_B_DSE) ? 1 : 0);
+
+	/* Make sure valid time was received. */
+	if (rtc_valid_tm(tm) < 0) {
+		dev_err(dev, "retrieved date/time is not valid.\n");
+		rtc_time_to_tm(0, tm);
+	}
+	return 0;
+}
+
+static int
+ds1685_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct ds1685_priv *pdata = platform_get_drvdata(pdev);
+	struct ds1685_rtc_regs __iomem *regs = pdata->regs;
+	unsigned int data;
+	unsigned long flags, start = jiffies;
+	unsigned int seconds, minutes, hours, wday, mday, month, years;
+	unsigned int century;
+
+	/* Fetch the time info from rtc_time. */
+	seconds	= bin2bcd(tm->tm_sec);
+	minutes	= bin2bcd(tm->tm_min);
+	hours	= bin2bcd(tm->tm_hour);
+	wday	= bin2bcd(tm->tm_wday + 1);
+	mday	= bin2bcd(tm->tm_mday);
+	month	= bin2bcd(tm->tm_mon + 1);
+	years	= bin2bcd(tm->tm_year % 100);
+	century	= bin2bcd((tm->tm_year + 1900) / 100);
+
+	/*
+	 * Perform Sanity Checks:
+	 *   - Months: !> 12, Month Day != 0.
+	 *   - Month Day !> Max days in current month.
+	 *   - Hours !>= 24, Mins !>= 60, Secs !>= 60, & Weekday !> 7.
+	 */
+	if ((month > 12) || (mday == 0))
+		return -EDOM;
+
+	if (tm->tm_mday > rtc_month_days(tm->tm_mon, tm->tm_year))
+		return -EDOM;
+
+	if ((tm->tm_hour >= 24) || (tm->tm_min >= 60) || (tm->tm_sec >= 60) ||
+	    (wday > 7))
+		return -EDOM;
+
+	/*
+	 * Force datamode to BCD (DM=0) and store the time values in the
+	 * RTC registers.
+	*/
+	ds1685_rtc_begin_data_access;
+	data = readb(&regs->time.ctrlb) & ~(RTC_CTRL_B_DM);
+	writeb(data, &regs->time.ctrlb);
+	writeb(seconds, &regs->time.sec);
+	writeb(minutes, &regs->time.min);
+	writeb(hours, &regs->time.hour);
+	writeb(wday, &regs->time.wday);
+	writeb(mday, &regs->time.mday);
+	writeb(month, &regs->time.month);
+	writeb(years, &regs->time.year);
+	writeb(century, &regs->bank1.century);
+	ds1685_rtc_end_data_access;
+
+	return 0;
+}
+
+static int
+ds1685_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct ds1685_priv *pdata = platform_get_drvdata(pdev);
+	struct ds1685_rtc_regs __iomem *regs = pdata->regs;
+	unsigned int data;
+	unsigned long flags, start = jiffies;
+	unsigned int seconds, minutes, hours, mday;
+
+	/* Fetch the alarm info from the RTC alarm registers. */
+	ds1685_rtc_begin_data_access;
+	seconds	= readb(&regs->time.sec_alrm);
+	minutes	= readb(&regs->time.min_alrm);
+	hours	= readb(&regs->time.hour_alrm);
+	mday	= readb(&regs->bank1.mday_alrm);
+	ds1685_rtc_end_data_access;
+
+	/* Convert to Binary format and store in rtc_wkalrm. */
+	alrm->time.tm_sec = bcd2bin(seconds);
+	alrm->time.tm_min = bcd2bin(minutes);
+	alrm->time.tm_hour = bcd2bin(hours);
+	alrm->time.tm_mday = bcd2bin(mday);
+
+	return 0;
+}
+
+static int
+ds1685_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct ds1685_priv *pdata = platform_get_drvdata(pdev);
+	struct ds1685_rtc_regs __iomem *regs = pdata->regs;
+	unsigned int data;
+	unsigned long flags, start = jiffies;
+	unsigned int seconds, minutes, hours, mday;
+
+	/* Fetch the alarm info and convert to BCD. */
+	seconds	= bin2bcd(alrm->time.tm_sec);
+	minutes	= bin2bcd(alrm->time.tm_min);
+	hours	= bin2bcd(alrm->time.tm_hour);
+	mday	= bin2bcd(alrm->time.tm_mday);
+
+	/* Write to the four RTC alarm registers. */
+	ds1685_rtc_begin_data_access;
+	writeb(seconds, &regs->time.sec_alrm);
+	writeb(minutes, &regs->time.min_alrm);
+	writeb(hours, &regs->time.hour_alrm);
+	writeb(mday, &regs->bank1.mday_alrm);
+	ds1685_rtc_end_data_access;
+
+	return 0;
+}
+
+#ifdef CONFIG_RTC_INTF_DEV
+/*
+ * This function enables/disables an interrupt, depending on what is passed
+ * in irq_bit.  PIE/AIE/UIE are read/written in Ctrl B, and RIE/WIE/KSE in
+ * Ctrl 4B.
+ *
+ * XXX: Only handles PIE/AIE/UIE at present.
+ */
+static inline void
+ds1685_rtc_irq_ctrl(volatile unsigned char *reg, spinlock_t *lock,
+		    const unsigned int *enabled, const unsigned int irq_bit)
+{
+	unsigned long flags;
+
+	if (*enabled) {
+		spin_lock_irqsave(lock, flags);
+		writeb((readb(reg) | irq_bit), reg);
+		spin_unlock_irqrestore(lock, flags);
+	} else {
+		spin_lock_irqsave(lock, flags);
+		writeb((readb(reg) & ~(irq_bit)), reg);
+		spin_unlock_irqrestore(lock, flags);
+	}
+}
+
+/* Replaces ioctl() RTC_PIE on/off. */
+/* 2nd arg should be 'unsigned int', but needs fix in RTC core. */
+static int
+ds1685_rtc_periodic_irq_enable(struct device *dev, int enabled)
+{
+	struct ds1685_priv *rtc = dev_get_drvdata(dev);
+
+	ds1685_rtc_irq_ctrl(&rtc->regs->time.ctrlb, &rtc->lock,
+			    &enabled, RTC_CTRL_B_PIE);
+
+	rtc->p_intr = enabled;
+
+	return 0;
+}
+
+/* Replaces ioctl() RTC_AIE on/off. */
+static int
+ds1685_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
+{
+	struct ds1685_priv *rtc = dev_get_drvdata(dev);
+
+	ds1685_rtc_irq_ctrl(&rtc->regs->time.ctrlb, &rtc->lock,
+			    &enabled, RTC_CTRL_B_AIE);
+
+	rtc->a_intr = enabled;
+
+	return 0;
+}
+
+/* Replaces ioctl() RTC_UIE on/off. */
+static int
+ds1685_rtc_update_irq_enable(struct device *dev, unsigned int enabled)
+{
+	struct ds1685_priv *rtc = dev_get_drvdata(dev);
+
+	ds1685_rtc_irq_ctrl(&rtc->regs->time.ctrlb, &rtc->lock,
+			    &enabled, RTC_CTRL_B_UIE);
+
+	rtc->u_intr = enabled;
+
+	return 0;
+}
+
+/*
+ * Defunct; Will be fully replaced by IRQ API above once RTC Core is modified
+ * to handle RIE/WIE/KSE.
+ */
+static int
+ds1685_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct ds1685_priv *pdata = platform_get_drvdata(pdev);
+	struct ds1685_rtc_regs __iomem *regs = pdata->regs;
+	unsigned int data;
+	unsigned long flags;
+
+	switch (cmd) {
+		case RTC_WIE_ON:
+			/* Allow Wake-up Alarm Interrupts */
+			ds1685_rtc_begin_ctrl_access;
+			data = readb(&regs->bank1.ctrl4b) | RTC_CTRL_4B_WIE;
+			writeb(data, &regs->bank1.ctrl4b);
+			ds1685_rtc_end_ctrl_access;
+			break;
+
+		case RTC_WIE_OFF:
+			/* Disable Wake-up Alarm Interrupts */
+			ds1685_rtc_begin_ctrl_access;
+			data = readb(&regs->bank1.ctrl4b) & ~(RTC_CTRL_4B_WIE);
+			writeb(data, &regs->bank1.ctrl4b);
+			ds1685_rtc_end_ctrl_access;
+			break;
+
+		default:
+			return -ENOIOCTLCMD;
+	}
+
+	return 0;
+}
+#else
+#define ds1685_ioctl			NULL
+#define ds1685_rtc_periodic_irq_enable	NULL
+#define ds1685_rtc_alarm_irq_enable	NULL
+#define ds1685_rtc_update_irq_enable	NULL
+#endif /* CONFIG_RTC_INTF_DEV */
+
+static irqreturn_t
+ds1685_rtc_irq_handler(int irq, void *dev_id)
+{
+	struct platform_device *pdev = dev_id;
+	struct ds1685_priv *pdata = platform_get_drvdata(pdev);
+	struct ds1685_rtc_regs __iomem *regs = pdata->regs;
+	unsigned int data;
+	unsigned int ctrlb, ctrlc;
+#if 0
+	/* XXX: Ctrl4a/Ctrl4b info unused; needs support in RTC core. */
+	unsigned int ctrl4a, ctrl4b;
+#endif
+	unsigned long flags, events = RTC_IRQF;
+	unsigned int num_irqs = 0;
+
+	/* Fetch data from the four registers holding IRQ info. */
+	ds1685_rtc_begin_ctrl_access;
+	ctrlb = readb(&regs->time.ctrlb);
+	ctrlc = readb(&regs->time.ctrlc);
+#if 0
+	/* XXX: Ctrl4a/Ctrl4b info unused; needs support in RTC core. */
+	ctrl4a = readb(&regs->bank1.ctrl4a);
+	ctrl4b = readb(&regs->bank1.ctrl4b);
+#endif
+	ds1685_rtc_end_ctrl_access;
+
+	/* Check to see if the IRQF bit is set. */
+	if (!(ctrlc & RTC_CTRL_C_IRQF))
+		return IRQ_NONE;
+
+	/* Check for alarm interrupts. */
+	if      ((ctrlc & RTC_CTRL_C_AF) &&
+	         (ctrlb & RTC_CTRL_B_AIE)) {
+			events |= RTC_AF;
+			num_irqs++;
+	}
+
+	/* Check for timer interrupts. */
+	else if ((ctrlc & RTC_CTRL_C_UF) &&
+		 (ctrlb & RTC_CTRL_B_UIE)) {
+			events |= RTC_UF;
+			num_irqs++;
+	}
+
+	/* Check for periodic interrupts. */
+	else if ((ctrlc & RTC_CTRL_C_PF) &&
+		 (ctrlb & RTC_CTRL_B_PIE)) {
+			events |= RTC_PF;
+			num_irqs++;
+	}
+
+	rtc_update_irq(pdata->rtc, num_irqs, events);
+	return IRQ_HANDLED;
+}
+
+#ifdef CONFIG_PROC_FS
+#define NUM_REGS	8
+#define NUM_SPACES	4
+
+/*
+ * This prints out the flags of the registers for ds1685_rtc_proc.
+ * It's basically a hex --> binary function, just with extra spacing between
+ * the binary digits.  It only works on single-byte hex values (8 bits),
+ * which is all that we need.
+ */
+static char*
+print_regs(unsigned int *hex, char *dest)
+{
+        unsigned int i, j;
+        char *tmp = dest;
+
+        for(i = 0; i < NUM_REGS; i++) {
+                *tmp++ = ((*hex & 0x80) !=0 ? '1' : '0');
+                for (j = 0; j < NUM_SPACES; j++)
+                        *tmp++ = ' ';
+                *hex <<= 1;
+        }
+	*tmp++ = '\0';
+
+        return dest;
+}
+
+static int
+ds1685_rtc_proc(struct device *dev, struct seq_file *seq)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct ds1685_priv *pdata = platform_get_drvdata(pdev);
+	struct ds1685_rtc_regs __iomem *regs = pdata->regs;
+	unsigned int data;
+	unsigned long flags;
+	unsigned int ctrla, ctrlb, ctrlc, ctrld, ctrl4a, ctrl4b;
+	char bits[NUM_REGS][(NUM_REGS * NUM_SPACES) + NUM_REGS + 1];
+	u8 ssn[8];
+
+	ds1685_rtc_begin_ctrl_access;
+	ds1685_rtc_get_ssn;
+	ctrla = readb(&regs->time.ctrla);
+	ctrlb = readb(&regs->time.ctrlb);
+	ctrlc = readb(&regs->time.ctrlc);
+	ctrld = readb(&regs->time.ctrld);
+	ctrl4a = readb(&regs->bank1.ctrl4a);
+	ctrl4b = readb(&regs->bank1.ctrl4b);
+	ds1685_rtc_end_ctrl_access;
+
+	seq_printf(seq,
+		   "Oscillator\t: %s\n"
+		   "12/24hr\t\t: %s\n"
+		   "DST\t\t: %s\n"
+		   "Data mode\t: %s\n"
+		   "Battery\t\t: %s\n"
+		   "Aux batt\t: %s\n"
+		   "Periodic IRQ\t: %s\n"
+		   "SQW Freq\t: %s\n"
+		   "Serial #\t: %02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x\n"
+		   "Register Status\t:\n"
+		   "   Ctrl A\t: "
+		   "UIP  DV2  DV1  DV0  RS3  RS2  RS1  RS0\n\t\t:  %s\n"
+		   "   Ctrl B\t: "
+		   "SET  PIE  AIE  UIE  SQWE  DM  24hr DSE\n\t\t:  %s\n"
+		   "   Ctrl C\t: "
+		   "IRQF  PF   AF   UF  ---  ---  ---  ---\n\t\t:  %s\n"
+		   "   Ctrl D\t: "
+		   "VRT  ---  ---  ---  ---  ---  ---  ---\n\t\t:  %s\n"
+		   "   Ctrl 4A\t: "
+		   "VRT2 INCR BME  ---  PAB   RF   WF   KF\n\t\t:  %s\n"
+		   "   Ctrl 4B\t: "
+		   "ABE  E32k  CS  RCE  PRS  RIE  WIE  KSE\n\t\t:  %s\n",
+		   ((ctrla & RTC_CTRL_A_DV1) ? "enabled" : "disabled"),
+		   ((ctrlb & RTC_CTRL_B_2412) ? "24-hour" : "12-hour"),
+		   ((ctrlb & RTC_CTRL_B_DSE) ? "enabled" : "disabled"),
+		   ((ctrlb & RTC_CTRL_B_DM) ? "binary" : "BCD"),
+		   ((ctrld & RTC_CTRL_D_VRT) ? "ok" : "exhausted or n/a"),
+		   ((ctrl4a & RTC_CTRL_4A_VRT2) ? "ok" : "exhausted or n/a"),
+		   (!(ctrl4b & RTC_CTRL_4B_E32K) ?
+		     pirq_rate[(ctrla & RTC_CTRL_A_RS_MASK)] : "*"),
+		   (!((ctrl4b & RTC_CTRL_4B_E32K)) ?
+		     sqw_freq[(ctrla & RTC_CTRL_A_RS_MASK)] : "32.768kHz"),
+ 		   ssn[0], ssn[1], ssn[2], ssn[3], ssn[4], ssn[5],
+		   ssn[6], ssn[7],
+		   print_regs(&ctrla, bits[0]),
+		   print_regs(&ctrlb, bits[1]),
+		   print_regs(&ctrlc, bits[2]),
+		   print_regs(&ctrld, bits[3]),
+		   print_regs(&ctrl4a, bits[4]),
+		   print_regs(&ctrl4b, bits[5]));
+
+	return 0;
+}
+#else
+#define ds1685_rtc_proc NULL
+#endif /* CONFIG_PROC_FS */
+
+static const struct rtc_class_ops ds1685_rtc_ops = {
+	.ioctl			= ds1685_ioctl,
+	.proc			= ds1685_rtc_proc,
+	.read_time		= ds1685_rtc_read_time,
+	.set_time		= ds1685_rtc_set_time,
+	.read_alarm		= ds1685_rtc_read_alarm,
+	.set_alarm		= ds1685_rtc_set_alarm,
+	.irq_set_state		= ds1685_rtc_periodic_irq_enable,
+	.alarm_irq_enable	= ds1685_rtc_alarm_irq_enable,
+	.update_irq_enable	= ds1685_rtc_update_irq_enable,
+};
+
+#ifdef CONFIG_SYSFS
+static ssize_t
+ds1685_nvram_read(struct kobject *kobj,
+		  struct bin_attribute *bin_attr,
+		  char *buf, loff_t pos, size_t size)
+{
+	struct platform_device *pdev =
+		to_platform_device(container_of(kobj, struct device, kobj));
+	struct ds1685_priv *pdata = platform_get_drvdata(pdev);
+	struct ds1685_rtc_regs __iomem *regs = pdata->regs;
+	ssize_t count;
+	unsigned int data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&pdata->lock, flags);
+	ds1685_rtc_switch_to_bank0;
+	for (count = 0; size > 0 && pos < NVRAM_TOTAL_SZ_BANK0;
+	     count++, size--)
+		if (count < NVRAM_SZ_TIME)
+			*buf++ = readb(&regs->time.nvram1 + pos++);
+		else
+			*buf++ = readb(&regs->bank0.nvram2 + pos++);
+
+	if (size > 0) {
+		ds1685_rtc_switch_to_bank1;
+
+		for (count = 0; size > 0 && pos < NVRAM_TOTAL_SZ;
+		     count++, size--) {
+			writeb((pos - NVRAM_TOTAL_SZ_BANK0),
+			       &regs->bank1.ext_nvram_addr);
+			*buf++ = readb(&regs->bank1.ext_nvram_dport);
+			pos++;
+		}
+
+		ds1685_rtc_switch_to_bank0;
+	}
+	spin_unlock_irqrestore(&pdata->lock, flags);
+	return count;
+}
+
+static ssize_t
+ds1685_nvram_write(struct kobject *kobj,
+		   struct bin_attribute *bin_attr,
+		   char *buf, loff_t pos, size_t size)
+{
+	struct platform_device *pdev =
+		to_platform_device(container_of(kobj, struct device, kobj));
+	struct ds1685_priv *pdata = platform_get_drvdata(pdev);
+	struct ds1685_rtc_regs __iomem *regs = pdata->regs;
+	ssize_t count;
+	unsigned int data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&pdata->lock, flags);
+	ds1685_rtc_switch_to_bank0;
+	for (count = 0; size > 0 && pos < NVRAM_TOTAL_SZ_BANK0;
+	     count++, size--)
+		if (count < NVRAM_SZ_TIME)
+			writeb(*buf++, &regs->time.nvram1 + pos++);
+		else
+			writeb(*buf++, &regs->bank0.nvram2 + pos++);
+
+	if (size > 0) {
+		ds1685_rtc_switch_to_bank1;
+
+		for (count = 0; size > 0 && pos < NVRAM_TOTAL_SZ;
+		     count++, size--) {
+			writeb((pos - NVRAM_TOTAL_SZ_BANK0),
+			       &regs->bank1.ext_nvram_addr);
+			writeb(*buf++, &regs->bank1.ext_nvram_dport);
+			pos++;
+		}
+
+		ds1685_rtc_switch_to_bank0;
+	}
+	spin_unlock_irqrestore(&pdata->lock, flags);
+
+	return count;
+}
+
+static struct bin_attribute ds1685_nvram_attr = {
+	.attr = {
+		.name = "nvram",
+		.mode = S_IRUGO | S_IWUSR,
+	},
+	.read = ds1685_nvram_read,
+	.write = ds1685_nvram_write,
+	.size = NVRAM_TOTAL_SZ
+};
+
+static ssize_t
+ds1685_sysfs_show_battery(struct device *dev,
+			  struct device_attribute *attr, char *buf)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct ds1685_priv *pdata = platform_get_drvdata(pdev);
+	struct ds1685_rtc_regs __iomem *regs = pdata->regs;
+	unsigned int data;
+	unsigned long flags;
+
+	ds1685_rtc_begin_ctrl_access;
+	data = readb(&regs->time.ctrld);
+	ds1685_rtc_end_ctrl_access;
+
+	return sprintf(buf, "%s\n",
+		       (data & RTC_CTRL_D_VRT) ? "ok" : "exhausted or n/a");
+}
+
+static DEVICE_ATTR(battery, S_IRUGO, ds1685_sysfs_show_battery, NULL);
+
+static ssize_t
+ds1685_sysfs_show_auxbatt(struct device *dev,
+			  struct device_attribute *attr, char *buf)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct ds1685_priv *pdata = platform_get_drvdata(pdev);
+	struct ds1685_rtc_regs __iomem *regs = pdata->regs;
+	unsigned int data;
+	unsigned long flags;
+
+	ds1685_rtc_begin_ctrl_access;
+	data = readb(&regs->bank1.ctrl4a);
+	ds1685_rtc_end_ctrl_access;
+
+	return sprintf(buf, "%s\n",
+		       (data & RTC_CTRL_4A_VRT2) ? "ok" : "exhausted or n/a");
+}
+
+static DEVICE_ATTR(auxbatt, S_IRUGO, ds1685_sysfs_show_auxbatt, NULL);
+
+static ssize_t
+ds1685_sysfs_show_serial(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct ds1685_priv *pdata = platform_get_drvdata(pdev);
+	struct ds1685_rtc_regs __iomem *regs = pdata->regs;
+	u8 ssn[8];
+	unsigned int data;
+	unsigned long flags;
+
+	ds1685_rtc_begin_ctrl_access;
+	ds1685_rtc_get_ssn;
+	ds1685_rtc_end_ctrl_access;
+
+	return sprintf(buf, "%02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x\n",
+		       ssn[0], ssn[1], ssn[2], ssn[3],
+		       ssn[4], ssn[5], ssn[6], ssn[7]);
+
+	return 0;
+}
+
+static DEVICE_ATTR(serial, S_IRUGO, ds1685_sysfs_show_serial, NULL);
+
+static int
+ds1685_sysfs_register(struct device *dev)
+{
+	int err;
+
+	err = sysfs_create_bin_file(&dev->kobj, &ds1685_nvram_attr);
+	if (err)
+		return err;
+
+	err = device_create_file(dev, &dev_attr_battery);
+	if (err) {
+		device_remove_file(dev, &dev_attr_battery);
+		goto out;
+	}
+
+	err = device_create_file(dev, &dev_attr_auxbatt);
+	if (err) {
+		device_remove_file(dev, &dev_attr_auxbatt);
+		goto out;
+	}
+
+	err = device_create_file(dev, &dev_attr_serial);
+	if (err) {
+		device_remove_file(dev, &dev_attr_serial);
+		goto out;
+	}
+
+	return 0;
+
+out:
+	sysfs_remove_bin_file(&dev->kobj, &ds1685_nvram_attr);
+	return err;
+}
+
+static int
+ds1685_sysfs_unregister(struct device *dev)
+{
+	sysfs_remove_bin_file(&dev->kobj, &ds1685_nvram_attr);
+	device_remove_file(dev, &dev_attr_battery);
+	device_remove_file(dev, &dev_attr_auxbatt);
+	device_remove_file(dev, &dev_attr_serial);
+
+	return 0;
+}
+#endif /* CONFIG_SYSFS */
+
+static int __devinit
+ds1685_rtc_probe(struct platform_device *pdev)
+{
+	struct rtc_device *rtc = NULL;
+	struct device *dev = NULL;
+	struct resource *res = NULL;
+	struct ds1685_priv *pdata = NULL;
+	struct ds1685_rtc_regs __iomem *regs = NULL;
+	int ret = 0;
+	unsigned int data, ctrla, ctrlb, ctrlc, ctrld, ctrl4a, ctrl4b;
+	unsigned long flags;
+
+	/* Get the platform resources. */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENXIO;
+
+	/* Kzalloc() some memory for the rtc device structure. */
+	pdata = kzalloc(sizeof(struct ds1685_priv), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+	pdata->size = res->end - res->start + 1;
+
+	/* Request a memory region. */
+	if (!request_mem_region(res->start, pdata->size, pdev->name)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	/* Set the base address for the rtc, and ioremap() its registers. */
+	pdata->baseaddr = res->start;
+	pdata->regs = ioremap(pdata->baseaddr, pdata->size);
+	if (!pdata->regs) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/* Fetch the assigned IRQ, and init the spinlock. */
+	pdata->irq = platform_get_irq(pdev, 0);
+	spin_lock_init(&pdata->lock);
+
+	/* Begin the RTC setup. */
+	regs = pdata->regs;
+	dev = &pdev->dev;
+	ds1685_rtc_begin_ctrl_access;
+
+	/*
+	 * Turn the RTC on, if it was not already on and/or Enable the
+	 * countdown chain.
+	 */
+	ctrla = readb(&regs->time.ctrla);
+	if (!(ctrla & RTC_CTRL_A_DV1)) {
+		dev_warn(&pdev->dev,
+			 "oscillator stop detected - enabled!\n");
+		ctrla |= RTC_CTRL_A_DV1;
+	}
+	ctrla &= ~RTC_CTRL_A_DV2;
+	writeb(ctrla, &regs->time.ctrla);
+
+	/* Prefer BCD mode (DM = 0). */
+	ctrlb = readb(&regs->time.ctrlb);
+	if (ctrlb & RTC_CTRL_B_DM) {
+		dev_info(&pdev->dev, "Setting data mode to BCD\n");
+		ctrlb &= ~RTC_CTRL_B_DM;
+		writeb(ctrlb, &regs->time.ctrlb);
+	}
+
+	/* Check the batteries.  There can be a main and/or an aux battery. */
+	ctrld = readb(&regs->time.ctrld);
+	if (!(ctrld & RTC_CTRL_D_VRT))
+		dev_warn(&pdev->dev,
+			 "Main battery is exhausted or not available.\n");
+	ctrl4a = readb(&regs->bank1.ctrl4a);
+	if (!(ctrl4a & RTC_CTRL_4A_VRT2))
+		dev_warn(&pdev->dev,
+			 "Aux battery is exhausted or not available.\n");
+
+	/* Setup the interrupt handler. */
+	if (pdata->irq > 0) {
+		/* Read Ctrl B and clear PIE/AIE/UIE. */
+		ctrlb = readb(&regs->time.ctrlb);
+		ctrlb &= ~(RTC_CTRL_B_PIE & RTC_CTRL_B_AIE & RTC_CTRL_B_UIE);
+		writeb(ctrlb, &regs->time.ctrlb);
+
+		/* Reading Ctrl C auto-clears PF/AF/UF. */
+		ctrlc = readb(&regs->time.ctrlc);
+
+		/* Read Ctrl 4B and clear RIE/WIE/KSE. */
+		ctrl4b = readb(&regs->bank1.ctrl4b);
+		ctrl4b &= ~(RTC_CTRL_4B_RIE & RTC_CTRL_4B_WIE & RTC_CTRL_4B_KSE);
+		writeb(ctrl4b, &regs->bank1.ctrl4b);
+
+		/* Manually clear RF/WF/KF in Ctrl 4A. */
+		ctrl4a = readb(&regs->bank1.ctrl4a);
+		ctrl4a &= ~(RTC_CTRL_4A_RF & RTC_CTRL_4A_WF & RTC_CTRL_4A_KF);
+		writeb(ctrl4a, &regs->bank1.ctrl4a);
+
+		/* Request an IRQ. */
+		ret = request_irq(pdata->irq, ds1685_rtc_irq_handler,
+				  IRQF_SHARED, pdev->name, pdev);
+
+		/* Check to see if something came back. */
+		if (unlikely(ret)) {
+			dev_warn(&pdev->dev, "RTC interrupt not available\n");
+			pdata->irq = 0;
+		}
+	}
+
+	/* Setup complete. */
+	ds1685_rtc_end_ctrl_access;
+
+	/* Register the device as an RTC. */
+	rtc = rtc_device_register(pdev->name, &pdev->dev,
+				  &ds1685_rtc_ops, THIS_MODULE);
+
+	/* Success? */
+	if (IS_ERR(rtc)) {
+		ret = PTR_ERR(rtc);
+		goto out;
+	}
+	pdata->rtc = rtc;
+
+	/* Set driver data, register w/ sysfs. */
+	platform_set_drvdata(pdev, pdata);
+	ret = ds1685_sysfs_register(&pdev->dev);
+	if (ret) {
+		goto out;
+	}
+
+	/* Done! */
+	return 0;
+
+
+ out:
+	/* If error, clean up. */
+	if (pdata->rtc)
+		rtc_device_unregister(pdata->rtc);
+	if (pdata->irq > 0)
+		free_irq(pdata->irq, pdev);
+	if (pdata->regs)
+		iounmap(pdata->regs);
+	if (pdata->baseaddr)
+		release_mem_region(pdata->baseaddr, pdata->size);
+	kfree(pdata);
+
+	return ret;
+}
+
+static int __devexit
+ds1685_rtc_remove(struct platform_device *pdev)
+{
+	struct ds1685_priv *pdata = platform_get_drvdata(pdev);
+	struct ds1685_rtc_regs __iomem *regs = pdata->regs;
+	unsigned int ctrlb, ctrlc, ctrl4a, ctrl4b;
+
+	ds1685_sysfs_unregister(&pdev->dev);
+	rtc_device_unregister(pdata->rtc);
+	if (pdata->irq > 0) {
+		/* Read Ctrl B and clear PIE/AIE/UIE. */
+		ctrlb = readb(&regs->time.ctrlb);
+		ctrlb &= ~(RTC_CTRL_B_PIE & RTC_CTRL_B_AIE & RTC_CTRL_B_UIE);
+		writeb(ctrlb, &regs->time.ctrlb);
+
+		/* Reading Ctrl C auto-clears PF/AF/UF. */
+		ctrlc = readb(&regs->time.ctrlc);
+
+		/* Read Ctrl 4B and clear RIE/WIE/KSE. */
+		ctrl4b = readb(&regs->bank1.ctrl4b);
+		ctrl4b &= ~(RTC_CTRL_4B_RIE & RTC_CTRL_4B_WIE & RTC_CTRL_4B_KSE);
+		writeb(ctrl4b, &regs->bank1.ctrl4b);
+
+		/* Manually clear RF/WF/KF in Ctrl 4A. */
+		ctrl4a = readb(&regs->bank1.ctrl4a);
+		ctrl4a &= ~(RTC_CTRL_4A_RF & RTC_CTRL_4A_WF & RTC_CTRL_4A_KF);
+		writeb(ctrl4a, &regs->bank1.ctrl4a);
+
+		/* Free the IRQ. */
+		free_irq(pdata->irq, pdev);
+	}
+
+	iounmap(pdata->regs);
+
+	release_mem_region(pdata->baseaddr, pdata->size);
+	kfree(pdata);
+
+	return 0;
+}
+
+static struct platform_driver ds1685_rtc_driver = {
+	.driver		= {
+		.name	= "rtc-ds1685",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= ds1685_rtc_probe,
+	.remove		= __devexit_p(ds1685_rtc_remove),
+};
+
+static __init
+int ds1685_init(void)
+{
+	return platform_driver_register(&ds1685_rtc_driver);
+}
+
+static __exit
+void ds1685_exit(void)
+{
+	platform_driver_unregister(&ds1685_rtc_driver);
+}
+
+
+module_init(ds1685_init);
+module_exit(ds1685_exit);
+
+MODULE_AUTHOR("Matthias Fuchs <matthias.fuchs@esd-electronics.com>, "
+	      "Joshua Kinard <kumba@gentoo.org>");
+MODULE_DESCRIPTION("Dallas/Maxim DS1685/DS1687 RTC driver");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(DRV_VERSION);
+MODULE_ALIAS("platform:rtc-ds1685");
diff -Naurp linux-2.6.37.orig/include/linux/rtc/ds1685.h 
linux-2.6.37.rtc-ds1685/include/linux/rtc/ds1685.h
--- linux-2.6.37.orig/include/linux/rtc/ds1685.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.37.rtc-ds1685/include/linux/rtc/ds1685.h	2011-02-15 
04:28:04.582076001 -0500
@@ -0,0 +1,401 @@
+/*
+ * include/linux/rtc/ds1685.h
+ *
+ * Definitions for the control registers and platform data of the
+ * DS1685/DS1687 RTC chip driver.
+ *
+ * Copyright (C) 2009 Matthias Fuchs <matthias.fuchs@esd-electronics.com>
+ * Copyright (C) 2010 Joshua Kinard <kumba@gentoo.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _LINUX_RTC_DS1685_H_
+#define _LINUX_RTC_DS1685_H_
+
+/*
+ * Found in the original RTC driver for SGI IP30 (Octane) systems, it is used
+ * in the ds1685_begin_access macro while loop to avoid RTC access lockouts.
+ */
+#define DS1685_MAGIC		137
+
+
+/*
+ * NVRAM.
+ * - 50 bytes of NVRAM are available just past the clock registers.
+ * - 64 additional bytes are available in Bank0.
+ * - 128 additional bytes are available in Bank1.
+ */
+#define NVRAM_SZ_TIME		50
+#define NVRAM_SZ_BANK0		64
+#define NVRAM_SZ_BANK1		128
+#define NVRAM_TOTAL_SZ_BANK0	(NVRAM_SZ_TIME + NVRAM_SZ_BANK0)
+#define NVRAM_TOTAL_SZ		(NVRAM_TOTAL_SZ_BANK0 + NVRAM_SZ_BANK1)
+
+
+/*
+ * Some of the register names below are not used in the actual code, but
+ * are made available per the DS1685/DS1687 documentation for possible
+ * future use if the need arises.
+ */
+#define RTC_SECONDS		0x00
+#define RTC_SECONDS_ALARM	0x01
+#define RTC_MINUTES		0x02
+#define RTC_MINUTES_ALARM	0x03
+#define RTC_HOURS		0x04
+#define RTC_HOURS_ALARM		0x05
+#define RTC_DAY			0x06
+#define RTC_DATE		0x07
+#define RTC_MONTH		0x08
+#define RTC_YEAR		0x09
+
+#define RTC_CTRL_A		0x0a	/* Control Register A */
+#define RTC_CTRL_B		0x0b	/* Control Register B */
+#define RTC_CTRL_C		0x0c	/* Control Register C */
+#define RTC_CTRL_D		0x0d	/* Control Register D */
+#define RTC_EXT_CTRL_4A		0x4a	/* Extended Control Register 4A */
+#define RTC_EXT_CTRL_4B		0x4b	/* Extended Control Register 4B */
+#define RTC_NVRAM_START_B0	0x0e
+#define RTC_NVRAM_BANK1_BASE	0x3f00
+
+
+/*
+ * Values of the RTC bits.
+ */
+#define BIT_0			0x01
+#define BIT_1			0x02
+#define BIT_2			0x04
+#define BIT_3			0x08
+#define BIT_4			0x10
+#define BIT_5			0x20
+#define BIT_6			0x40
+#define BIT_7			0x80
+
+/*
+ * Bit names in Control Register A.
+ */
+#define RTC_CTRL_A_RS0		BIT_0	/* Rate-Selection Bit 0 */
+#define RTC_CTRL_A_RS1		BIT_1	/* Rate-Selection Bit 1 */
+#define RTC_CTRL_A_RS2		BIT_2	/* Rate-Selection Bit 2 */
+#define RTC_CTRL_A_RS3		BIT_3	/* Rate-Selection Bit 3 */
+#define RTC_CTRL_A_DV0		BIT_4	/* Bank Select */
+#define RTC_CTRL_A_DV1		BIT_5	/* Oscillator Enable */
+#define RTC_CTRL_A_DV2		BIT_6	/* Countdown Chain */
+#define RTC_CTRL_A_UIP		BIT_7	/* Update In Progress */
+#define RTC_CTRL_A_RS_MASK	(RTC_CTRL_A_RS0 + RTC_CTRL_A_RS1 +	\
+				 RTC_CTRL_A_RS2 + RTC_CTRL_A_RS3)
+
+/*
+ * Bit names in Control Register B.
+ */
+#define RTC_CTRL_B_DSE		BIT_0	/* Daylight Savings Enable */
+#define RTC_CTRL_B_2412		BIT_1	/* 12-Hr/24-Hr Mode */
+#define RTC_CTRL_B_DM		BIT_2	/* Data Mode */
+#define RTC_CTRL_B_SQWE		BIT_3	/* Square-Wave Enable */
+#define RTC_CTRL_B_UIE		BIT_4	/* Update-Ended Interrupt-Enable */
+#define RTC_CTRL_B_AIE		BIT_5	/* Alarm-Interrupt Enable */
+#define RTC_CTRL_B_PIE		BIT_6	/* Periodic-Interrupt Enable */
+#define RTC_CTRL_B_SET		BIT_7	/* SET Bit */
+
+
+/*
+ * Bit names in Control Register C.
+ *
+ * BIT_0, BIT_1, BIT_2, & BIT_3 are unused, always return 0, and cannot be
+ * written to.
+ */
+#define RTC_CTRL_C_UF		BIT_4	/* Update-Ended Interrupt Flag */
+#define RTC_CTRL_C_AF		BIT_5	/* Alarm-Interrupt Flag */
+#define RTC_CTRL_C_PF		BIT_6	/* Periodic-Interrupt Flag */
+#define RTC_CTRL_C_IRQF		BIT_7	/* Interrupt-Request Flag */
+
+
+/*
+ * Bit names in Control Register D.
+ *
+ * BIT_0 through BIT_6 are unused, always return 0, and cannot be written to.
+ */
+#define RTC_CTRL_D_VRT		BIT_7	/* Valid RAM and Time */
+
+
+/*
+ * Bit names in Extended Control Register 4A.
+ *
+ * BIT_4 and BIT_5 are reserved for future use.  They can be read from and
+ * written to, but have no effect on the RTC's operation.
+ */
+#define RTC_CTRL_4A_KF		BIT_0	/* Kickstart Flag */
+#define RTC_CTRL_4A_WF		BIT_1	/* Wake-Up Alarm Flag */
+#define RTC_CTRL_4A_RF		BIT_2	/* RAM Clear Flag */
+#define RTC_CTRL_4A_PAB		BIT_3	/* Power-Active Bar Control */
+#define RTC_CTRL_4A_INCR	BIT_6	/* Increment-in-Progress Status */
+#define RTC_CTRL_4A_VRT2	BIT_7	/* Auxillary Battery Status */
+
+
+/*
+ * Bit names in Extended Control Register 4B.
+ */
+#define RTC_CTRL_4B_KSE		BIT_0	/* Kickstart Interrupt-Enable */
+#define RTC_CTRL_4B_WIE		BIT_1	/* Wake-Up Alarm-Interrupt Enable */
+#define RTC_CTRL_4B_RIE		BIT_2	/* RAM Clear-Interrupt Enable */
+#define RTC_CTRL_4B_PRS		BIT_3	/* PAB Reset-Select */
+#define RTC_CTRL_4B_RCE		BIT_4	/* RAM Clear-Enable */
+#define RTC_CTRL_4B_CS		BIT_5	/* Crystal Select */
+#define RTC_CTRL_4B_E32K	BIT_6	/* Enable 32.768Hz Output on SQW Pin */
+#define RTC_CTRL_4B_ABE		BIT_7	/* Auxillary Battery Enable */
+
+
+/*
+ * Register names in Bank 1.
+ *
+ * The DV0 bit in Control Register A must be set to 1 for these registers
+ * to become available, including Extended Control Registers 4A & 4B.
+ */
+#define RTC_BANK1_MODEL		0x40	/* Model Number */
+#define RTC_BANK1_SERIAL_BYTE_1	0x41	/* 1st Byte of Serial Number */
+#define RTC_BANK1_SERIAL_BYTE_2	0x42	/* 2nd Byte of Serial Number */
+#define RTC_BANK1_SERIAL_BYTE_3	0x43	/* 3rd Byte of Serial Number */
+#define RTC_BANK1_SERIAL_BYTE_4	0x44	/* 4th Byte of Serial Number */
+#define RTC_BANK1_SERIAL_BYTE_5	0x45	/* 5th Byte of Serial Number */
+#define RTC_BANK1_SERIAL_BYTE_6	0x46	/* 6th Byte of Serial Number */
+#define RTC_BANK1_SERIAL_CRC	0x47	/* Serial CRC Byte */
+#define RTC_BANK1_CENTURY	0x48	/* Century Counter */
+#define RTC_BANK1_DATE_ALARM	0x49	/* Date Alarm */
+#define RTC_BANK1_RAM_ADDR	0x50	/* RAM Address */
+#define RTC_BANK1_RAM_DATA_PORT	0x53	/* RAM Data Port */
+
+
+#ifdef CONFIG_PROC_FS
+/*
+ * Periodic Interrupt Rates.  A static character array is used for displaying
+ * these values in /proc when procfs is enabled.
+ */
+static const char *pirq_rate[16] = {
+	"none", "3.90625ms", "7.8125ms", "122.070탎", "244.141탎",
+	"488.281탎", "976.5625탎", "1.953125ms", "3.90625ms", "7.8125ms",
+	"15.625ms", "31.25ms", "62.5ms", "125ms", "250ms", "500ms"
+};
+
+/*
+ * Square-Wave Output Frequencies.  A static character array is used for
+ * displaying these values in /proc when procfs is enabled.
+ */
+static const char *sqw_freq[16] = {
+	"none", "256Hz", "128Hz", "8.192kHz", "4.096kHz", "2.048kHz",
+	"1.024kHz", "512Hz", "256Hz", "128Hz", "64Hz", "32Hz", "16Hz",
+	"8Hz", "4Hz", "2Hz"
+};
+#endif /* CONFIG_PROC_FS */
+
+
+#define DS1685_REG(r) volatile unsigned char r;
+
+
+/*
+ * This structure defines the standard DS1286-style time registers
+ * that exist in both bank0 and bank1.
+ */
+struct ds1685_time_regs {
+	DS1685_REG(sec);		/* Seconds			*/
+	DS1685_REG(sec_alrm);		/* Seconds Alarm		*/
+	DS1685_REG(min);		/* Minutes			*/
+	DS1685_REG(min_alrm);		/* Minutes Alarm		*/
+	DS1685_REG(hour);		/* Hours			*/
+	DS1685_REG(hour_alrm);		/* Hours Alarm			*/
+	DS1685_REG(wday);		/* Day of the Week		*/
+	DS1685_REG(mday);		/* Day of the Month		*/
+	DS1685_REG(month);		/* Current Month		*/
+	DS1685_REG(year);		/* Current Year			*/
+	DS1685_REG(ctrla);		/* Control Register A		*/
+	DS1685_REG(ctrlb);		/* Control Register B		*/
+	DS1685_REG(ctrlc);		/* Control Register C		*/
+	DS1685_REG(ctrld);		/* Control Register D		*/
+	volatile unsigned char nvram1[NVRAM_SZ_TIME];
+};
+
+
+/*
+ * Bank0-specific registers.  This is usually NVRAM.
+ */
+struct ds1685_bank0_regs {
+	volatile unsigned char nvram2[NVRAM_SZ_BANK0];
+};
+
+
+/*
+ * Bank1-specific registers.  These access extended capabilities present
+ * in the DS1685.  The DS17285/DS17287 has minor differences, including an
+ * RTC write counter, and two extended NVRAM address registers, for MSB
+ * or LSB forms of the address.
+ */
+struct ds1685_bank1_regs {
+	DS1685_REG(model);		/* Model Number			*/
+	DS1685_REG(ssn1);		/* 1st Byte of Serial Number	*/
+	DS1685_REG(ssn2);		/* 2nd Byte of Serial Number	*/
+	DS1685_REG(ssn3);		/* 3rd Byte of Serial Number	*/
+	DS1685_REG(ssn4);		/* 4th Byte of Serial Number	*/
+	DS1685_REG(ssn5);		/* 5th Byte of Serial Number	*/
+	DS1685_REG(ssn6);		/* 6th Byte of Serial Number	*/
+	DS1685_REG(crc);		/* Serial # CRC Byte		*/
+	DS1685_REG(century);		/* Current Century		*/
+	DS1685_REG(mday_alrm);		/* Day of the Month Alarm	*/
+	DS1685_REG(ctrl4a);		/* Ext. Control Register 4A	*/
+	DS1685_REG(ctrl4b);		/* Ext. Control Register 4B	*/
+	DS1685_REG(rsvrd1);		/* Reserved; provides SMI	*/
+	DS1685_REG(rsvrd2);		/* Recovery Stack.  Holds last	*/
+	DS1685_REG(rtc_addr2);		/* four RTC addresses for the	*/
+	DS1685_REG(rtc_addr3);		/* BIOS to recover from an SMI.	*/
+	DS1685_REG(ext_nvram_addr);	/* Ext. NVRAM Addr; DS1685/7	*/
+	DS1685_REG(rsvrd3);		/* Reserved			*/
+	DS1685_REG(rsvrd4);		/* Reserved			*/
+	DS1685_REG(ext_nvram_dport);	/* Ext. NVRAM Data Port		*/
+};
+
+
+/*
+ * The actual register struct.  Uses a union to combine bank0 and bank1,
+ * since both use the same address space, but are accessed depending on the
+ * state of the DV0 bit in Control Register A.
+ */
+struct ds1685_rtc_regs {
+	struct ds1685_time_regs time;
+	union {
+		struct ds1685_bank0_regs bank0;
+		struct ds1685_bank1_regs bank1;
+	};
+};
+
+
+/*
+ * DS1685/1687 data structure.
+ */
+struct ds1685_priv {
+	struct rtc_device *rtc;			/* RTC device pointer */
+	struct ds1685_rtc_regs __iomem *regs;	/* RTC Registers */
+	resource_size_t baseaddr;		/* Resource base address */
+	size_t size;				/* Resource size */
+	spinlock_t lock;			/* Spinlock struct */
+	int irq;				/* RTC IRQ # */
+	unsigned int p_intr;			/* Periodic IRQ status */
+	unsigned int a_intr;			/* Alarm IRQ status */
+	unsigned int u_intr;			/* Update IRQ status */
+#if 0	/* Not used just yet; See comments in rtc-ds1685.c */
+	unsigned int r_intr;			/* RAM-Clear IRQ status */
+	unsigned int w_intr;			/* Watchdog IRQ status */
+	unsigned int k_intr;			/* Kickstart IRQ status */
+#endif
+};
+
+
+/*
+ * These two macros set and unset the SET bit in Control Register B.  The
+ * SET bit inhibits update transfers and allows a safe read/write of the
+ * time and calendar bits.
+ */
+#define ds1685_rtc_set_set_bit					\
+	data = readb(&regs->time.ctrlb) | RTC_CTRL_B_SET;	\
+	writeb(data, &regs->time.ctrlb)
+
+#define ds1685_rtc_clear_set_bit				\
+	data = readb(&regs->time.ctrlb) & ~(RTC_CTRL_B_SET);	\
+	writeb(data, &regs->time.ctrlb)
+
+
+/*
+ * These two macros switch between bank0 and bank1.  Bank0 provides access
+ * to the standard RTC capabilities originally defined with the DS1286 RTC.
+ * Bank1 provides access to extended capabilities, including extended
+ * control registers, silicon serial number, century counter, aux battery
+ * capabilities, wake-up/kick-start features and additional amounts of nvram.
+ */
+#define ds1685_rtc_switch_to_bank0				\
+	data = readb(&regs->time.ctrla) & ~(RTC_CTRL_A_DV0);	\
+	writeb(data, &regs->time.ctrla)
+
+#define ds1685_rtc_switch_to_bank1				\
+	data = readb(&regs->time.ctrla) | RTC_CTRL_A_DV0;	\
+	writeb(data, &regs->time.ctrla)
+
+
+/*
+ * This begins the RTC data access, such as reading/writing clock/alarm
+ * registers.  It performs several steps in a common block of code that is
+ * used quite frequently:
+ *
+ * - Sets a spinlock on the IRQ.
+ * - Sets the SET bit in Control Register B.
+ * - Reads Control Register A.
+ * - Checks the UIP bit in Control Register A.  If UIP is active,
+ *   a delay is forced and a check is run to see if RTC access was
+ *   locked out.  The loop runs until UIP is not set.
+ * - A switch to bank1 occurs.  This allows access to all the relevant
+ *   time data, since the time registers are available regardless of
+ *   which bank is currently selected.
+ */
+#define ds1685_rtc_begin_data_access				\
+	spin_lock_irqsave(&pdata->lock, flags);			\
+	ds1685_rtc_set_set_bit;					\
+	data = readb(&regs->time.ctrla);			\
+	while (data & RTC_CTRL_A_UIP) {				\
+		udelay(10);					\
+		if (jiffies > start + DS1685_MAGIC) {		\
+			dev_err(dev, "Access lockout!\n");	\
+			return 1;				\
+		}						\
+		data = readb(&regs->time.ctrla);		\
+	}							\
+	ds1685_rtc_switch_to_bank1
+
+/*
+ * This ends the RTC data access:
+ * - It switches back to bank0.
+ * - It clears the SET bit in Control Register B.
+ * - It unsets the spinlock on the IRQ.
+ */
+#define ds1685_rtc_end_data_access				\
+	ds1685_rtc_switch_to_bank0;				\
+	ds1685_rtc_clear_set_bit;				\
+	spin_unlock_irqrestore(&pdata->lock, flags)
+
+
+/*
+ * This begins the RTC access to the control registers only.  Such
+ * accesses need far less handling, just a spinlock and a switch to
+ * bank1.
+ */
+#define ds1685_rtc_begin_ctrl_access				\
+	spin_lock_irqsave(&pdata->lock, flags);			\
+	ds1685_rtc_switch_to_bank1
+
+/*
+ * This ends the RTC ctrl access:
+ * - It switches back to bank0.
+ * - It unsets the spinlock on the IRQ.
+ */
+#define ds1685_rtc_end_ctrl_access				\
+	ds1685_rtc_switch_to_bank0;				\
+	spin_unlock_irqrestore(&pdata->lock, flags)
+
+
+/*
+ * This fetches the Silicon Serial Number, a unique ID specific to every
+ * DS1685/1687.
+ *
+ * This number starts at 0x40, and is 8-bytes long, ending at 0x47.
+ * The first byte is the model #, the next six bytes are the serial
+ * number digits, and the final byte is a CRC check byte.  Together,
+ * they form the SSN of the RTC.
+ */
+#define ds1685_rtc_get_ssn					\
+	ssn[0] = readb(&regs->bank1.model);			\
+	ssn[1] = readb(&regs->bank1.ssn1);			\
+	ssn[2] = readb(&regs->bank1.ssn2);			\
+	ssn[3] = readb(&regs->bank1.ssn3);			\
+	ssn[4] = readb(&regs->bank1.ssn4);			\
+	ssn[5] = readb(&regs->bank1.ssn5);			\
+	ssn[6] = readb(&regs->bank1.ssn6);			\
+	ssn[7] = readb(&regs->bank1.crc)
+
+#endif /* _LINUX_RTC_DS1685_H_ */
