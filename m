Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Aug 2005 09:50:18 +0100 (BST)
Received: from RT-soft-1.Moscow.itn.ru ([IPv6:::ffff:80.240.96.90]:36967 "EHLO
	buildserver.ru.mvista.com") by linux-mips.org with ESMTP
	id <S8225207AbVHRItz>; Thu, 18 Aug 2005 09:49:55 +0100
Received: from 192.168.1.133 ([10.150.0.9])
	by buildserver.ru.mvista.com (8.11.6/8.11.6) with ESMTP id j7I8sit19225;
	Thu, 18 Aug 2005 13:54:45 +0500
Subject: a patch for generic MIPS RTC
From:	Sergey Podstavin <spodstavin@ru.mvista.com>
Reply-To: spodstavin@ru.mvista.com
To:	linux-mips <linux-mips@linux-mips.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>
Content-Type: multipart/mixed; boundary="=-jWNDXCryGAwurHmkZsnW"
Organization: MontaVista
Date:	Thu, 18 Aug 2005 12:54:50 +0400
Message-Id: <1124355290.5441.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Return-Path: <spodstavin@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8766
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: spodstavin@ru.mvista.com
Precedence: bulk
X-list: linux-mips


--=-jWNDXCryGAwurHmkZsnW
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi!

genrtc doesn't work as a module because functions for module defined in
wrong place. Most architectures define these functions in <asm/rtc.h>,
so make MIPS follow their example.
It makes the generic MIPS RTC working as a module for MIPS.

Best wishes,
Sergey Podstavin

--=-jWNDXCryGAwurHmkZsnW
Content-Disposition: attachment; filename=fix_genrtc_as_a_module.patch
Content-Type: text/x-patch; name=fix_genrtc_as_a_module.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Source: MontaVista Software, Inc. Sergey Podstavin <spodstavin@ru.mvista.com>
Type: Defect Fix
Disposition: submit to linux-mips@linux-mips.org
Description:
    genrtc doesn't work as a module because functions for module defined in wrong place.	
Most architectures define these functions in <asm/rtc.h>, so make MIPS follow their example.

Signed-off-by: Tom Rini <trini@kernel.crashing.org>
Signed-off-by: Sergey Podstavin <spodstavin@ru.mvista.com>

Index: linux/arch/mips/kernel/genrtc.c
===================================================================
--- linux.orig/arch/mips/kernel/genrtc.c
+++ linux/arch/mips/kernel/genrtc.c
@@ -1,64 +1 @@
-/*
- * A glue layer that provides RTC read/write to drivers/char/genrtc.c driver
- * based on MIPS internal RTC routines.  It does take care locking
- * issues so that we are SMP/Preemption safe.
- *
- * Copyright (C) 2004 MontaVista Software Inc.
- * Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
- *
- * Please read the COPYING file for all license details.
- */
-
-#include <linux/spinlock.h>
-
-#include <asm/rtc.h>
-#include <asm/time.h>
-
-static DEFINE_SPINLOCK(mips_rtc_lock);
-
-unsigned int get_rtc_time(struct rtc_time *time)
-{
-	unsigned long nowtime;
-
-	spin_lock(&mips_rtc_lock);
-	nowtime = rtc_get_time();
-	to_tm(nowtime, time);
-	time->tm_year -= 1900;
-	spin_unlock(&mips_rtc_lock);
-
-	return RTC_24H;
-}
-
-int set_rtc_time(struct rtc_time *time)
-{
-	unsigned long nowtime;
-	int ret;
-
-	spin_lock(&mips_rtc_lock);
-	nowtime = mktime(time->tm_year+1900, time->tm_mon+1,
-			time->tm_mday, time->tm_hour, time->tm_min,
-			time->tm_sec);
-	ret = rtc_set_time(nowtime);
-	spin_unlock(&mips_rtc_lock);
-
-	return ret;
-}
-
-unsigned int get_rtc_ss(void)
-{
-	struct rtc_time h;
-
-	get_rtc_time(&h);
-	return h.tm_sec;
-}
-
-int get_rtc_pll(struct rtc_pll_info *pll)
-{
-	return -EINVAL;
-}
-
-int set_rtc_pll(struct rtc_pll_info *pll)
-{
-	return -EINVAL;
-}
 
Index: linux/arch/mips/kernel/Makefile
===================================================================
--- linux.orig/arch/mips/kernel/Makefile
+++ linux/arch/mips/kernel/Makefile
@@ -57,8 +57,6 @@
 
 obj-$(CONFIG_64BIT)		+= cpu-bugs64.o
 
-obj-$(CONFIG_GEN_RTC)		+= genrtc.o
-
 CFLAGS_cpu-bugs64.o	= $(shell if $(CC) $(CFLAGS) -Wa,-mdaddi -c -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-DHAVE_AS_SET_DADDI"; fi)
 CFLAGS_ioctl32.o	+= -Ifs/
 
Index: linux/include/asm-mips/rtc.h
===================================================================
--- linux.orig/include/asm-mips/rtc.h
+++ linux/include/asm-mips/rtc.h
@@ -14,7 +14,9 @@
 
 #ifdef __KERNEL__
 
+#include <linux/spinlock.h>
 #include <linux/rtc.h>
+#include <asm/time.h>
 
 #define RTC_PIE 0x40            /* periodic interrupt enable */
 #define RTC_AIE 0x20            /* alarm interrupt enable */
@@ -33,5 +35,52 @@
 int get_rtc_pll(struct rtc_pll_info *pll);
 int set_rtc_pll(struct rtc_pll_info *pll);
 
+static DEFINE_SPINLOCK(mips_rtc_lock);
+
+static inline unsigned int get_rtc_time(struct rtc_time *time)
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
+static inline int set_rtc_time(struct rtc_time *time)
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
+static inline unsigned int get_rtc_ss(void)
+{
+	struct rtc_time h;
+
+	get_rtc_time(&h);
+	return h.tm_sec;
+}
+
+static inline int get_rtc_pll(struct rtc_pll_info *pll)
+{
+	return -EINVAL;
+}
+
+static inline int set_rtc_pll(struct rtc_pll_info *pll)
+{
+	return -EINVAL;
+}
 #endif
 #endif

--=-jWNDXCryGAwurHmkZsnW--
