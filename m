Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jan 2004 18:39:16 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:10996 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225343AbUA3SjP>;
	Fri, 30 Jan 2004 18:39:15 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id i0UIdDw02645;
	Fri, 30 Jan 2004 10:39:13 -0800
Date: Fri, 30 Jan 2004 10:39:13 -0800
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: [PATCH 2.6] enable genrtc for MIPS
Message-ID: <20040130103913.E31937@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4204
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


genrtc.c is like mips-rtc.c we have in 2.4, except it is shared by
other arches and has more capabilities (such as emulated alarms)

This patch implements the arch-specific code for genrtc based on 
MIPS's rtc_get_time() and rtc_set_time(), which are now implemented
by every MIPS board.  This essentially means with this patch
every MIPS machine now has a working genrtc for free.

Of course, individual board is still free to choose the old rtc.c
or implement some peculiar ones of its own - although I can't see why. :)

Jun

--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mips-genrtc.patch"

diff -Nru linux/arch/mips/kernel/Makefile.orig linux/arch/mips/kernel/Makefile
--- linux/arch/mips/kernel/Makefile.orig	Mon Jan  5 10:33:35 2004
+++ linux/arch/mips/kernel/Makefile	Fri Jan 30 10:29:07 2004
@@ -51,6 +51,8 @@
 
 obj-$(CONFIG_MIPS64)		+= cpu-bugs64.o
 
+obj-$(CONFIG_GEN_RTC)		+= genrtc.o
+
 CFLAGS_cpu-bugs64.o	= $(shell if $(CC) $(CFLAGS) -Wa,-mdaddi -c -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-DHAVE_AS_SET_DADDI"; fi)
 
 EXTRA_AFLAGS := $(CFLAGS)
diff -Nru linux/arch/mips/kernel/genrtc.c.orig linux/arch/mips/kernel/genrtc.c
--- linux/arch/mips/kernel/genrtc.c.orig	Thu Jan 29 16:35:28 2004
+++ linux/arch/mips/kernel/genrtc.c	Thu Jan 29 17:22:56 2004
@@ -0,0 +1,65 @@
+/*
+ * A glue layer that provides RTC read/write to drivers/char/genrtc.c driver
+ * based on MIPS internal RTC routines.  It does take care locking
+ * issues so that we are SMP/Preemption safe.
+ *
+ * Copyright (C) 2004 MontaVista Software Inc.
+ * Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
+ *
+ * Please read the COPYING file for all license details.
+ */
+
+#include <linux/config.h>
+#include <linux/spinlock.h>
+
+#include <asm/rtc.h>
+#include <asm/time.h>
+
+static spinlock_t mips_rtc_lock = SPIN_LOCK_UNLOCKED;
+
+unsigned int get_rtc_time(struct rtc_time *time)
+{
+	unsigned long nowtime;
+
+	spin_lock(&mips_rtc_lock);
+	nowtime = rtc_get_time();
+	to_tm(nowtime, time);
+	time->tm_year -= 1900;
+	spin_unlock(&mips_rtc_lock);
+
+	return RTC_24H;
+}
+
+int set_rtc_time(struct rtc_time *time)
+{
+	unsigned long nowtime;
+	int ret;
+
+	spin_lock(&mips_rtc_lock);
+	nowtime = mktime(time->tm_year+1900, time->tm_mon+1,
+			time->tm_mday, time->tm_hour, time->tm_min,
+			time->tm_sec);
+	ret = rtc_set_time(nowtime);
+	spin_unlock(&mips_rtc_lock);
+
+	return ret;
+}
+
+unsigned int get_rtc_ss(void)
+{
+	struct rtc_time h;
+
+	get_rtc_time(&h);
+	return h.tm_sec;
+}
+
+int get_rtc_pll(struct rtc_pll_info *pll)
+{
+	return -EINVAL;
+}
+
+int set_rtc_pll(struct rtc_pll_info *pll)
+{
+	return -EINVAL;
+}
+
diff -Nru linux/include/asm-mips/rtc.h.orig linux/include/asm-mips/rtc.h
--- linux/include/asm-mips/rtc.h.orig	Thu Oct 31 08:35:52 2002
+++ linux/include/asm-mips/rtc.h	Thu Jan 29 16:35:14 2004
@@ -1,10 +1,37 @@
-#ifndef _I386_RTC_H
-#define _I386_RTC_H
-
 /*
- * x86 uses the default access methods for the RTC.
+ * include/asm-mips/rtc.h 
+ *
+ * (Really an interface for drivers/char/genrtc.c)
+ *
+ * Copyright (C) 2004 MontaVista Software Inc.
+ * Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
+ *
+ * Please read the COPYING file for all license details.
  */
 
-#include <asm-generic/rtc.h>
+#ifndef _MIPS_RTC_H
+#define _MIPS_RTC_H
+
+#ifdef __KERNEL__
+
+#include <linux/rtc.h>
+
+#define RTC_PIE 0x40            /* periodic interrupt enable */
+#define RTC_AIE 0x20            /* alarm interrupt enable */
+#define RTC_UIE 0x10            /* update-finished interrupt enable */
 
+/* some dummy definitions */
+#define RTC_BATT_BAD 0x100      /* battery bad */
+#define RTC_SQWE 0x08           /* enable square-wave output */
+#define RTC_DM_BINARY 0x04      /* all time/date values are BCD if clear */
+#define RTC_24H 0x02            /* 24 hour mode - else hours bit 7 means pm */
+#define RTC_DST_EN 0x01         /* auto switch DST - works f. USA only */
+
+unsigned int get_rtc_time(struct rtc_time *time);
+int set_rtc_time(struct rtc_time *time);
+unsigned int get_rtc_ss(void);
+int get_rtc_pll(struct rtc_pll_info *pll);
+int set_rtc_pll(struct rtc_pll_info *pll);
+
+#endif
 #endif

--T4sUOijqQbZv57TR--
