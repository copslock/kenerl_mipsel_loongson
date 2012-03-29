Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Mar 2012 18:14:16 +0200 (CEST)
Received: from smtp-vbr9.xs4all.nl ([194.109.24.29]:3962 "EHLO
        smtp-vbr9.xs4all.nl" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903602Ab2C2QOK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Mar 2012 18:14:10 +0200
Received: from starbug-2.trinair2002 (dhcp-089-098-069-120.chello.nl [89.98.69.120])
        (authenticated bits=0)
        by smtp-vbr9.xs4all.nl (8.13.8/8.13.8) with ESMTP id q2TGDuNN015838;
        Thu, 29 Mar 2012 18:13:56 +0200 (CEST)
        (envelope-from maarten@treewalker.org)
Received: from hyperion.trinair2002 (hyperion.trinair2002 [192.168.0.43])
        by starbug-2.trinair2002 (Postfix) with ESMTP id 907363DF38;
        Thu, 29 Mar 2012 18:13:55 +0200 (CEST)
From:   Maarten ter Huurne <maarten@treewalker.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-mips@linux-mips.org,
        Maarten ter Huurne <maarten@treewalker.org>
Subject: [PATCH] MIPS: JZ4740: reset: Initialize hibernate wakeup counters.
Date:   Thu, 29 Mar 2012 18:19:58 +0200
Message-Id: <1333037998-18762-1-git-send-email-maarten@treewalker.org>
X-Mailer: git-send-email 1.7.7
X-Virus-Scanned: by XS4ALL Virus Scanner
X-archive-position: 32817
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maarten@treewalker.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

In hibernation mode only the wakeup logic and the RTC are left running,
so this is what users perceive as power down.

If the counters are not initialized, the corresponding pin (typically
connected to the power button) has to be asserted for two seconds
before the device wakes up. Most users expect a shorter wakeup time.

I took the timing values of 100 ms and 60 ms from BouKiCHi's patch for
the Dingoo A320 kernel.

Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/mips/jz4740/reset.c |   46 ++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/arch/mips/jz4740/reset.c b/arch/mips/jz4740/reset.c
index 5f1fb95..e6d1d7b 100644
--- a/arch/mips/jz4740/reset.c
+++ b/arch/mips/jz4740/reset.c
@@ -21,6 +21,9 @@
 #include <asm/mach-jz4740/base.h>
 #include <asm/mach-jz4740/timer.h>
 
+#include "reset.h"
+#include "clock.h"
+
 static void jz4740_halt(void)
 {
 	while (1) {
@@ -53,21 +56,52 @@ static void jz4740_restart(char *command)
 	jz4740_halt();
 }
 
-#define JZ_REG_RTC_CTRL		0x00
-#define JZ_REG_RTC_HIBERNATE	0x20
+#define JZ_REG_RTC_CTRL			0x00
+#define JZ_REG_RTC_HIBERNATE		0x20
+#define JZ_REG_RTC_WAKEUP_FILTER	0x24
+#define JZ_REG_RTC_RESET_COUNTER	0x28
 
-#define JZ_RTC_CTRL_WRDY	BIT(7)
+#define JZ_RTC_CTRL_WRDY		BIT(7)
+#define JZ_RTC_WAKEUP_FILTER_MASK	0x0000FFE0
+#define JZ_RTC_RESET_COUNTER_MASK	0x00000FE0
 
-static void jz4740_power_off(void)
+static inline void jz4740_rtc_wait_ready(void __iomem *rtc_base)
 {
-	void __iomem *rtc_base = ioremap(JZ4740_RTC_BASE_ADDR, 0x24);
 	uint32_t ctrl;
-
 	do {
 		ctrl = readl(rtc_base + JZ_REG_RTC_CTRL);
 	} while (!(ctrl & JZ_RTC_CTRL_WRDY));
+}
+
+static void jz4740_power_off(void)
+{
+	void __iomem *rtc_base = ioremap(JZ4740_RTC_BASE_ADDR, 0x38);
+	unsigned long long wakeup_filter_ticks;
+	unsigned long long reset_counter_ticks;
+
+	/* Set minimum wakeup pin assertion time: 100 ms.
+	   Range is 0 to 2 sec if RTC is clocked at 32 kHz. */
+	wakeup_filter_ticks = (100 * jz4740_clock_bdata.rtc_rate) / 1000;
+	if (wakeup_filter_ticks < JZ_RTC_WAKEUP_FILTER_MASK)
+		wakeup_filter_ticks &= JZ_RTC_WAKEUP_FILTER_MASK;
+	else
+		wakeup_filter_ticks = JZ_RTC_WAKEUP_FILTER_MASK;
+	jz4740_rtc_wait_ready(rtc_base);
+	writel(wakeup_filter_ticks, rtc_base + JZ_REG_RTC_WAKEUP_FILTER);
 
+	/* Set reset pin low-level assertion time after wakeup: 60 ms.
+	   Range is 0 to 125 ms if RTC is clocked at 32 kHz. */
+	reset_counter_ticks = (60 * jz4740_clock_bdata.rtc_rate) / 1000;
+	if (reset_counter_ticks < JZ_RTC_RESET_COUNTER_MASK)
+		reset_counter_ticks &= JZ_RTC_RESET_COUNTER_MASK;
+	else
+		reset_counter_ticks = JZ_RTC_RESET_COUNTER_MASK;
+	jz4740_rtc_wait_ready(rtc_base);
+	writel(reset_counter_ticks, rtc_base + JZ_REG_RTC_RESET_COUNTER);
+
+	jz4740_rtc_wait_ready(rtc_base);
 	writel(1, rtc_base + JZ_REG_RTC_HIBERNATE);
+
 	jz4740_halt();
 }
 
-- 
1.7.7
