Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Aug 2008 11:25:53 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:46985 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20045367AbYHIKZt (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 9 Aug 2008 11:25:49 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1KRldr-000090-01; Sat, 09 Aug 2008 12:25:47 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 897DEC3163; Sat,  9 Aug 2008 12:25:33 +0200 (CEST)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH v2] IP22/28: Switch over to RTC class driver
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Message-Id: <20080809102533.897DEC3163@solo.franken.de>
Date:	Sat,  9 Aug 2008 12:25:33 +0200 (CEST)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20161
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

This patchset removes some dead code and creates a platform device
for the RTC class driver.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

Changes in v2:

- corrected rtc resource end


 arch/mips/sgi-ip22/ip22-platform.c  |   15 ++++++++
 arch/mips/sgi-ip22/ip22-setup.c     |    1 -
 arch/mips/sgi-ip22/ip22-time.c      |   64 -----------------------------------
 include/asm-mips/mach-ip22/ds1286.h |   18 ----------
 include/asm-mips/mach-ip28/ds1286.h |    4 --
 include/linux/ds1286.h              |    2 -
 6 files changed, 15 insertions(+), 89 deletions(-)

diff --git a/arch/mips/sgi-ip22/ip22-platform.c b/arch/mips/sgi-ip22/ip22-platform.c
index 6014123..9bbb90b 100644
--- a/arch/mips/sgi-ip22/ip22-platform.c
+++ b/arch/mips/sgi-ip22/ip22-platform.c
@@ -192,3 +192,18 @@ static int __init sgi_button_devinit(void)
 }
 
 device_initcall(sgi_button_devinit);
+
+static int __init sgi_ds1286_devinit(void)
+{
+	struct resource res;
+
+	memset(&res, 0, sizeof(res));
+	res.start = HPC3_CHIP0_BASE + offsetof(struct hpc3_regs, rtcregs);
+	res.end = res.start + sizeof(hpc3c0->rtcregs) - 1;
+	res.flags = IORESOURCE_MEM;
+
+	return IS_ERR(platform_device_register_simple("rtc-ds1286", -1,
+						      &res, 1));
+}
+
+device_initcall(sgi_ds1286_devinit);
diff --git a/arch/mips/sgi-ip22/ip22-setup.c b/arch/mips/sgi-ip22/ip22-setup.c
index 896a1ef..b9a9313 100644
--- a/arch/mips/sgi-ip22/ip22-setup.c
+++ b/arch/mips/sgi-ip22/ip22-setup.c
@@ -4,7 +4,6 @@
  * Copyright (C) 1996 David S. Miller (dm@engr.sgi.com)
  * Copyright (C) 1997, 1998 Ralf Baechle (ralf@gnu.org)
  */
-#include <linux/ds1286.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/kdev_t.h>
diff --git a/arch/mips/sgi-ip22/ip22-time.c b/arch/mips/sgi-ip22/ip22-time.c
index 10e5054..3dcb27e 100644
--- a/arch/mips/sgi-ip22/ip22-time.c
+++ b/arch/mips/sgi-ip22/ip22-time.c
@@ -10,7 +10,6 @@
  * Copyright (C) 2003, 06 Ralf Baechle (ralf@linux-mips.org)
  */
 #include <linux/bcd.h>
-#include <linux/ds1286.h>
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
@@ -29,69 +28,6 @@
 #include <asm/sgi/hpc3.h>
 #include <asm/sgi/ip22.h>
 
-/*
- * Note that mktime uses month from 1 to 12 while rtc_time_to_tm
- * uses 0 to 11.
- */
-unsigned long read_persistent_clock(void)
-{
-	unsigned int yrs, mon, day, hrs, min, sec;
-	unsigned int save_control;
-	unsigned long flags;
-
-	spin_lock_irqsave(&rtc_lock, flags);
-	save_control = hpc3c0->rtcregs[RTC_CMD] & 0xff;
-	hpc3c0->rtcregs[RTC_CMD] = save_control | RTC_TE;
-
-	sec = BCD2BIN(hpc3c0->rtcregs[RTC_SECONDS] & 0xff);
-	min = BCD2BIN(hpc3c0->rtcregs[RTC_MINUTES] & 0xff);
-	hrs = BCD2BIN(hpc3c0->rtcregs[RTC_HOURS] & 0x3f);
-	day = BCD2BIN(hpc3c0->rtcregs[RTC_DATE] & 0xff);
-	mon = BCD2BIN(hpc3c0->rtcregs[RTC_MONTH] & 0x1f);
-	yrs = BCD2BIN(hpc3c0->rtcregs[RTC_YEAR] & 0xff);
-
-	hpc3c0->rtcregs[RTC_CMD] = save_control;
-	spin_unlock_irqrestore(&rtc_lock, flags);
-
-	if (yrs < 45)
-		yrs += 30;
-	if ((yrs += 40) < 70)
-		yrs += 100;
-
-	return mktime(yrs + 1900, mon, day, hrs, min, sec);
-}
-
-int rtc_mips_set_time(unsigned long tim)
-{
-	struct rtc_time tm;
-	unsigned int save_control;
-	unsigned long flags;
-
-	rtc_time_to_tm(tim, &tm);
-
-	tm.tm_mon += 1;		/* tm_mon starts at zero */
-	tm.tm_year -= 40;
-	if (tm.tm_year >= 100)
-		tm.tm_year -= 100;
-
-	spin_lock_irqsave(&rtc_lock, flags);
-	save_control = hpc3c0->rtcregs[RTC_CMD] & 0xff;
-	hpc3c0->rtcregs[RTC_CMD] = save_control | RTC_TE;
-
-	hpc3c0->rtcregs[RTC_YEAR] = BIN2BCD(tm.tm_year);
-	hpc3c0->rtcregs[RTC_MONTH] = BIN2BCD(tm.tm_mon);
-	hpc3c0->rtcregs[RTC_DATE] = BIN2BCD(tm.tm_mday);
-	hpc3c0->rtcregs[RTC_HOURS] = BIN2BCD(tm.tm_hour);
-	hpc3c0->rtcregs[RTC_MINUTES] = BIN2BCD(tm.tm_min);
-	hpc3c0->rtcregs[RTC_SECONDS] = BIN2BCD(tm.tm_sec);
-	hpc3c0->rtcregs[RTC_HUNDREDTH_SECOND] = 0;
-
-	hpc3c0->rtcregs[RTC_CMD] = save_control;
-	spin_unlock_irqrestore(&rtc_lock, flags);
-
-	return 0;
-}
-
 static unsigned long dosample(void)
 {
 	u32 ct0, ct1;
diff --git a/include/asm-mips/mach-ip22/ds1286.h b/include/asm-mips/mach-ip22/ds1286.h
deleted file mode 100644
index f19f1ea..0000000
--- a/include/asm-mips/mach-ip22/ds1286.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 1998, 2001, 03 by Ralf Baechle
- *
- * RTC routines for PC style attached Dallas chip.
- */
-#ifndef __ASM_MACH_IP22_DS1286_H
-#define __ASM_MACH_IP22_DS1286_H
-
-#include <asm/sgi/hpc3.h>
-
-#define rtc_read(reg)		(hpc3c0->rtcregs[(reg)] & 0xff)
-#define rtc_write(data, reg)	do { hpc3c0->rtcregs[(reg)] = (data); } while(0)
-
-#endif /* __ASM_MACH_IP22_DS1286_H */
diff --git a/include/asm-mips/mach-ip28/ds1286.h b/include/asm-mips/mach-ip28/ds1286.h
deleted file mode 100644
index 471bb9a..0000000
--- a/include/asm-mips/mach-ip28/ds1286.h
+++ /dev/null
@@ -1,4 +0,0 @@
-#ifndef __ASM_MACH_IP28_DS1286_H
-#define __ASM_MACH_IP28_DS1286_H
-#include <asm/mach-ip22/ds1286.h>
-#endif /* __ASM_MACH_IP28_DS1286_H */
diff --git a/include/linux/ds1286.h b/include/linux/ds1286.h
index d898986..45ea0aa 100644
--- a/include/linux/ds1286.h
+++ b/include/linux/ds1286.h
@@ -8,8 +8,6 @@
 #ifndef __LINUX_DS1286_H
 #define __LINUX_DS1286_H
 
-#include <asm/ds1286.h>
-
 /**********************************************************************
  * register summary
  **********************************************************************/
