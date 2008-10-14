Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Oct 2008 16:18:43 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:61375 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S21487821AbYJNPRk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 14 Oct 2008 16:17:40 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1KpleS-0005UJ-02; Tue, 14 Oct 2008 17:17:36 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id CA36DC3AEA; Tue, 14 Oct 2008 17:17:28 +0200 (CEST)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH v4] IP27: Switch over to RTC class driver
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Message-Id: <20081014151728.CA36DC3AEA@solo.franken.de>
Date:	Tue, 14 Oct 2008 17:17:28 +0200 (CEST)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20752
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

Please apply for 2.6.28

 arch/mips/sgi-ip27/ip27-timer.c |   99 +++++++++------------------------------
 1 files changed, 22 insertions(+), 77 deletions(-)

diff --git a/arch/mips/sgi-ip27/ip27-timer.c b/arch/mips/sgi-ip27/ip27-timer.c
index 8b4e854..1327c27 100644
--- a/arch/mips/sgi-ip27/ip27-timer.c
+++ b/arch/mips/sgi-ip27/ip27-timer.c
@@ -13,12 +13,12 @@
 #include <linux/time.h>
 #include <linux/timex.h>
 #include <linux/mm.h>
+#include <linux/platform_device.h>
 
 #include <asm/time.h>
 #include <asm/pgtable.h>
 #include <asm/sgialib.h>
 #include <asm/sn/ioc3.h>
-#include <asm/m48t35.h>
 #include <asm/sn/klconfig.h>
 #include <asm/sn/arch.h>
 #include <asm/sn/addrs.h>
@@ -28,51 +28,6 @@
 
 #define TICK_SIZE (tick_nsec / 1000)
 
-#if 0
-static int set_rtc_mmss(unsigned long nowtime)
-{
-	int retval = 0;
-	int real_seconds, real_minutes, cmos_minutes;
-	struct m48t35_rtc *rtc;
-	nasid_t nid;
-
-	nid = get_nasid();
-	rtc = (struct m48t35_rtc *)(KL_CONFIG_CH_CONS_INFO(nid)->memory_base +
-							IOC3_BYTEBUS_DEV0);
-
-	rtc->control |= M48T35_RTC_READ;
-	cmos_minutes = BCD2BIN(rtc->min);
-	rtc->control &= ~M48T35_RTC_READ;
-
-	/*
-	 * Since we're only adjusting minutes and seconds, don't interfere with
-	 * hour overflow. This avoids messing with unknown time zones but
-	 * requires your RTC not to be off by more than 15 minutes
-	 */
-	real_seconds = nowtime % 60;
-	real_minutes = nowtime / 60;
-	if (((abs(real_minutes - cmos_minutes) + 15)/30) & 1)
-		real_minutes += 30;	/* correct for half hour time zone */
-	real_minutes %= 60;
-
-	if (abs(real_minutes - cmos_minutes) < 30) {
-		real_seconds = BIN2BCD(real_seconds);
-		real_minutes = BIN2BCD(real_minutes);
-		rtc->control |= M48T35_RTC_SET;
-		rtc->sec = real_seconds;
-		rtc->min = real_minutes;
-		rtc->control &= ~M48T35_RTC_SET;
-	} else {
-		printk(KERN_WARNING
-		       "set_rtc_mmss: can't update from %d to %d\n",
-		       cmos_minutes, real_minutes);
-		retval = -1;
-	}
-
-	return retval;
-}
-#endif
-
 /* Includes for ioc3_init().  */
 #include <asm/sn/types.h>
 #include <asm/sn/sn0/addrs.h>
@@ -80,37 +35,6 @@ static int set_rtc_mmss(unsigned long nowtime)
 #include <asm/sn/sn0/hubio.h>
 #include <asm/pci/bridge.h>
 
-unsigned long read_persistent_clock(void)
-{
-        unsigned int year, month, date, hour, min, sec;
-	struct m48t35_rtc *rtc;
-	nasid_t nid;
-
-	nid = get_nasid();
-	rtc = (struct m48t35_rtc *)(KL_CONFIG_CH_CONS_INFO(nid)->memory_base +
-							IOC3_BYTEBUS_DEV0);
-
-	rtc->control |= M48T35_RTC_READ;
-	sec = rtc->sec;
-	min = rtc->min;
-	hour = rtc->hour;
-	date = rtc->date;
-	month = rtc->month;
-	year = rtc->year;
-	rtc->control &= ~M48T35_RTC_READ;
-
-        sec = BCD2BIN(sec);
-        min = BCD2BIN(min);
-        hour = BCD2BIN(hour);
-        date = BCD2BIN(date);
-        month = BCD2BIN(month);
-        year = BCD2BIN(year);
-
-        year += 1970;
-
-        return mktime(year, month, date, hour, min, sec);
-}
-
 static void enable_rt_irq(unsigned int irq)
 {
 }
@@ -286,6 +210,7 @@ void __cpuinit cpu_time_init(void)
 
 void __cpuinit hub_rtc_init(cnodeid_t cnode)
 {
+
 	/*
 	 * We only need to initialize the current node.
 	 * If this is not the current node then it is a cpuless
@@ -301,3 +226,23 @@ void __cpuinit hub_rtc_init(cnodeid_t cnode)
 		LOCAL_HUB_S(PI_RT_PEND_B, 0);
 	}
 }
+
+static int __init sgi_ip27_rtc_devinit(void)
+{
+	struct resource res;
+
+	memset(&res, 0, sizeof(res));
+	res.start = XPHYSADDR(KL_CONFIG_CH_CONS_INFO(master_nasid)->memory_base +
+			      IOC3_BYTEBUS_DEV0);
+	res.end = res.start + 32767;
+	res.flags = IORESOURCE_MEM;
+
+	return IS_ERR(platform_device_register_simple("rtc-m48t35", -1,
+						      &res, 1));
+}
+
+/*
+ * kludge make this a device_initcall after ioc3 resource conflicts
+ * are resolved
+ */
+late_initcall(sgi_ip27_rtc_devinit);
