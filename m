Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 May 2008 01:41:55 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:55285 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S20021904AbYEGAlP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 7 May 2008 01:41:15 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m470eNCM020419;
	Wed, 7 May 2008 02:40:23 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m470eNj2020415;
	Wed, 7 May 2008 01:40:23 +0100
Date:	Wed, 7 May 2008 01:40:22 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Alessandro Zummo <a.zummo@towertech.it>,
	Jean Delvare <khali@linux-fr.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>
cc:	rtc-linux@googlegroups.com, i2c@lm-sensors.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 1/4] RTC: Class device support for persistent clock
Message-ID: <Pine.LNX.4.55.0805070015360.16173@cliff.in.clinika.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19116
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

 This is a generic implementation of rtc_read_persistent_clock() and
rtc_update_persistent_clock() suitable for platforms to be used for
read_persistent_clock() and update_persistent_clock() calls.  An RTC
device selected by the user with the RTC_HCTOSYS_DEVICE option is used.  

 As rtc_read_persistent_clock() is not available at the time
timekeeping_init() is called, it will now be disabled if the class device
is to be used as a reference.  In this case rtc_hctosys(), already
present, will be used to set up the system time at the late initcall time.  
This call has now been rewritten to make use of
rtc_read_persistent_clock().

 As rtc_set_mmss() used by rtc_update_persistent_clock() may sleep for 
some hardware, the call is now made from a work queue scheduled by the 
timer originally used for the entire function.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
patch-2.6.26-rc1-20080505-rtc-persistent-clock-11
diff -up --recursive --new-file linux-2.6.26-rc1-20080505.macro/drivers/rtc/Kconfig linux-2.6.26-rc1-20080505/drivers/rtc/Kconfig
--- linux-2.6.26-rc1-20080505.macro/drivers/rtc/Kconfig	2008-05-05 02:55:40.000000000 +0000
+++ linux-2.6.26-rc1-20080505/drivers/rtc/Kconfig	2008-05-05 21:41:34.000000000 +0000
@@ -21,24 +21,30 @@ menuconfig RTC_CLASS
 if RTC_CLASS
 
 config RTC_HCTOSYS
-	bool "Set system time from RTC on startup and resume"
+	bool "Use time from RTC as a reference for the system time"
 	depends on RTC_CLASS = y
 	default y
 	help
-	  If you say yes here, the system time (wall clock) will be set using
-	  the value read from a specified RTC device. This is useful to avoid
-	  unnecessary fsck runs at boot time, and to network better.
+	  If you say yes here, the specified RTC device will be used
+	  as a reference to the system time (wall clock).  The device
+	  will be used to set the system time as required during
+	  startup, suspend and, for platforms that support such usage,
+	  for NTP timekeeping.
+
+	  This is useful to avoid unnecessary fsck runs at boot time,
+	  and to network better.
 
 config RTC_HCTOSYS_DEVICE
-	string "RTC used to set the system time"
+	string "RTC used as a reference for the system time"
 	depends on RTC_HCTOSYS = y
 	default "rtc0"
 	help
-	  The RTC device that will be used to (re)initialize the system
+	  The RTC device that will be used as a reference for the system
 	  clock, usually rtc0.  Initialization is done when the system
-	  starts up, and when it resumes from a low power state.  This
-	  device should record time in UTC, since the kernel won't do
-	  timezone correction.
+	  starts up, and when it resumes from a low power state.  Also,
+	  if supported by the platform, NTP timekeeping uses this device
+	  to record the system time periodically.  This device should
+	  record time in UTC, since the kernel won't do timezone correction.
 
 	  The driver for this RTC device must be loaded before late_initcall
 	  functions run, so it must usually be statically linked.
diff -up --recursive --new-file linux-2.6.26-rc1-20080505.macro/drivers/rtc/hctosys.c linux-2.6.26-rc1-20080505/drivers/rtc/hctosys.c
--- linux-2.6.26-rc1-20080505.macro/drivers/rtc/hctosys.c	2008-05-05 02:55:40.000000000 +0000
+++ linux-2.6.26-rc1-20080505/drivers/rtc/hctosys.c	2008-05-05 21:10:50.000000000 +0000
@@ -1,8 +1,9 @@
 /*
- * RTC subsystem, initialize system time on startup
+ * RTC subsystem, persistent clock and startup initialization support
  *
  * Copyright (C) 2005 Tower Technologies
  * Author: Alessandro Zummo <a.zummo@towertech.it>
+ * Copyright (C) 2008  Maciej W. Rozycki
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -22,46 +23,85 @@
  * the best guess is to add 0.5s.
  */
 
-static int __init rtc_hctosys(void)
+/*
+ * Note the unusual API:
+ * zero returned means a failure, anything else is seconds from epoch.
+ */
+unsigned long rtc_read_persistent_clock(void)
 {
-	int err;
-	struct rtc_time tm;
 	struct rtc_device *rtc = rtc_class_open(CONFIG_RTC_HCTOSYS_DEVICE);
+	struct rtc_time tm;
+	unsigned long time = 0;
 
 	if (rtc == NULL) {
-		printk("%s: unable to open rtc device (%s)\n",
-			__FILE__, CONFIG_RTC_HCTOSYS_DEVICE);
-		return -ENODEV;
+		printk(KERN_ERR "hctosys: unable to open rtc device (%s)\n",
+		       CONFIG_RTC_HCTOSYS_DEVICE);
+		goto out;
+	}
+	if (rtc_read_time(rtc, &tm) < 0) {
+		dev_err(rtc->dev.parent,
+			"hctosys: unable to read the hardware clock\n");
+		goto out_close;
 	}
+	if (rtc_valid_tm(&tm) < 0) {
+		dev_err(rtc->dev.parent, "hctosys: invalid date/time\n");
+		goto out_close;
+	}
+
+	rtc_tm_to_time(&tm, &time);
 
-	err = rtc_read_time(rtc, &tm);
-	if (err == 0) {
-		err = rtc_valid_tm(&tm);
-		if (err == 0) {
-			struct timespec tv;
-
-			tv.tv_nsec = NSEC_PER_SEC >> 1;
-
-			rtc_tm_to_time(&tm, &tv.tv_sec);
-
-			do_settimeofday(&tv);
-
-			dev_info(rtc->dev.parent,
-				"setting system clock to "
-				"%d-%02d-%02d %02d:%02d:%02d UTC (%u)\n",
-				tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
-				tm.tm_hour, tm.tm_min, tm.tm_sec,
-				(unsigned int) tv.tv_sec);
-		}
-		else
-			dev_err(rtc->dev.parent,
-				"hctosys: invalid date/time\n");
+out_close:
+	rtc_class_close(rtc);
+out:
+	return time;
+}
+
+int rtc_update_persistent_clock(struct timespec now)
+{
+	struct rtc_device *rtc = rtc_class_open(CONFIG_RTC_HCTOSYS_DEVICE);
+	int err;
+
+	if (rtc == NULL) {
+		printk(KERN_ERR "hctosys: unable to open rtc device (%s)\n",
+		       CONFIG_RTC_HCTOSYS_DEVICE);
+		err = -ENXIO;
+		goto out;
 	}
-	else
+	err = rtc_set_mmss(rtc, now.tv_sec);
+	if (err < 0) {
 		dev_err(rtc->dev.parent,
-			"hctosys: unable to read the hardware clock\n");
+			"hctosys: unable to set the hardware clock\n");
+		goto out_close;
+	}
 
+	err = 0;
+
+out_close:
 	rtc_class_close(rtc);
+out:
+	return err;
+}
+
+static int __init rtc_hctosys(void)
+{
+	struct rtc_time tm;
+	struct timespec tv;
+	unsigned long time;
+
+	time = rtc_read_persistent_clock();
+	if (!time)
+		return -ENODEV;
+
+	tv.tv_nsec = NSEC_PER_SEC >> 1;
+	tv.tv_sec = time;
+	do_settimeofday(&tv);
+
+	rtc_time_to_tm(time, &tm);
+	pr_info("%s: setting system clock to "
+		"%d-%02d-%02d %02d:%02d:%02d UTC (%lu)\n",
+		CONFIG_RTC_HCTOSYS_DEVICE,
+		tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
+		tm.tm_hour, tm.tm_min, tm.tm_sec, (unsigned long)tv.tv_sec);
 
 	return 0;
 }
diff -up --recursive --new-file linux-2.6.26-rc1-20080505.macro/include/linux/rtc.h linux-2.6.26-rc1-20080505/include/linux/rtc.h
--- linux-2.6.26-rc1-20080505.macro/include/linux/rtc.h	2008-05-05 02:55:59.000000000 +0000
+++ linux-2.6.26-rc1-20080505/include/linux/rtc.h	2008-05-05 21:10:50.000000000 +0000
@@ -200,6 +200,9 @@ extern int rtc_irq_set_state(struct rtc_
 extern int rtc_irq_set_freq(struct rtc_device *rtc,
 				struct rtc_task *task, int freq);
 
+extern unsigned long rtc_read_persistent_clock(void);
+extern int rtc_update_persistent_clock(struct timespec now);
+
 typedef struct rtc_task {
 	void (*func)(void *private_data);
 	void *private_data;
diff -up --recursive --new-file linux-2.6.26-rc1-20080505.macro/kernel/time/ntp.c linux-2.6.26-rc1-20080505/kernel/time/ntp.c
--- linux-2.6.26-rc1-20080505.macro/kernel/time/ntp.c	2008-05-05 02:56:03.000000000 +0000
+++ linux-2.6.26-rc1-20080505/kernel/time/ntp.c	2008-05-05 21:10:50.000000000 +0000
@@ -3,6 +3,8 @@
  *
  * NTP state machine interfaces and logic.
  *
+ * Copyright (c) 2008  Maciej W. Rozycki
+ *
  * This code was mainly moved from kernel/timer.c and kernel/time.c
  * Please see those files for relevant copyright info and historical
  * changelogs.
@@ -17,6 +19,7 @@
 #include <linux/capability.h>
 #include <linux/math64.h>
 #include <linux/clocksource.h>
+#include <linux/workqueue.h>
 #include <asm/timex.h>
 
 /*
@@ -218,11 +221,13 @@ void second_overflow(void)
 /* Disable the cmos update - used by virtualization and embedded */
 int no_sync_cmos_clock  __read_mostly;
 
-static void sync_cmos_clock(unsigned long dummy);
+static void sync_cmos_clock(unsigned long data);
+static void do_sync_cmos_clock(struct work_struct *work);
 
 static DEFINE_TIMER(sync_cmos_timer, sync_cmos_clock, 0, 0);
+static DECLARE_WORK(sync_cmos_work, do_sync_cmos_clock);
 
-static void sync_cmos_clock(unsigned long dummy)
+static void do_sync_cmos_clock(struct work_struct *work)
 {
 	struct timespec now, next;
 	int fail = 1;
@@ -261,6 +266,12 @@ static void sync_cmos_clock(unsigned lon
 	mod_timer(&sync_cmos_timer, jiffies + timespec_to_jiffies(&next));
 }
 
+static void sync_cmos_clock(unsigned long data)
+{
+	/* Some implementations of update_persistent_clock() may sleep.  */
+	schedule_work(&sync_cmos_work);
+}
+
 static void notify_cmos_timer(void)
 {
 	if (!no_sync_cmos_clock)
diff -up --recursive --new-file linux-2.6.26-rc1-20080505.macro/kernel/time/timekeeping.c linux-2.6.26-rc1-20080505/kernel/time/timekeeping.c
--- linux-2.6.26-rc1-20080505.macro/kernel/time/timekeeping.c	2008-05-05 02:56:03.000000000 +0000
+++ linux-2.6.26-rc1-20080505/kernel/time/timekeeping.c	2008-05-05 21:10:50.000000000 +0000
@@ -242,7 +242,11 @@ unsigned long __attribute__((weak)) read
 void __init timekeeping_init(void)
 {
 	unsigned long flags;
-	unsigned long sec = read_persistent_clock();
+	unsigned long sec = 0;
+
+#ifndef CONFIG_RTC_HCTOSYS
+	sec = read_persistent_clock();
+#endif
 
 	write_seqlock_irqsave(&xtime_lock, flags);
 
