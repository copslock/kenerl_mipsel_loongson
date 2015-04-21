Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Apr 2015 16:54:23 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:51213 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27025947AbbDUOyW0nkwk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Apr 2015 16:54:22 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 72B18B868B49;
        Tue, 21 Apr 2015 15:54:15 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 21 Apr 2015 15:54:17 +0100
Received: from localhost (192.168.159.67) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 21 Apr
 2015 15:54:16 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v3 23/37] MIPS: JZ4740: replace use of jz4740_clock_bdata
Date:   Tue, 21 Apr 2015 15:46:50 +0100
Message-ID: <1429627624-30525-24-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.3.5
In-Reply-To: <1429627624-30525-1-git-send-email-paul.burton@imgtec.com>
References: <1429627624-30525-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.67]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46980
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Replace uses of the jz4740_clock_bdata struct with calls to clk_get_rate
for the appropriate clock. This is in preparation for migrating the
clocks towards common clock framework & devicetree.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
Changes in v3:
  - Rebase.

Changes in v2:
  - None.
---
 arch/mips/jz4740/platform.c | 11 ++++++++++-
 arch/mips/jz4740/reset.c    | 13 +++++++++++--
 arch/mips/jz4740/time.c     |  9 ++++++++-
 3 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/arch/mips/jz4740/platform.c b/arch/mips/jz4740/platform.c
index 0b12f27..2a5c7c7 100644
--- a/arch/mips/jz4740/platform.c
+++ b/arch/mips/jz4740/platform.c
@@ -13,6 +13,7 @@
  *
  */
 
+#include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
@@ -308,9 +309,17 @@ static struct platform_device jz4740_uart_device = {
 void jz4740_serial_device_register(void)
 {
 	struct plat_serial8250_port *p;
+	struct clk *ext_clk;
+	unsigned long ext_rate;
+
+	ext_clk = clk_get(NULL, "ext");
+	if (IS_ERR(ext_clk))
+		panic("unable to get ext clock");
+	ext_rate = clk_get_rate(ext_clk);
+	clk_put(ext_clk);
 
 	for (p = jz4740_uart_data; p->flags != 0; ++p)
-		p->uartclk = jz4740_clock_bdata.ext_rate;
+		p->uartclk = ext_rate;
 
 	platform_device_register(&jz4740_uart_device);
 }
diff --git a/arch/mips/jz4740/reset.c b/arch/mips/jz4740/reset.c
index b6c6343..954e669 100644
--- a/arch/mips/jz4740/reset.c
+++ b/arch/mips/jz4740/reset.c
@@ -12,6 +12,7 @@
  *
  */
 
+#include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/pm.h>
@@ -79,12 +80,20 @@ static void jz4740_power_off(void)
 	void __iomem *rtc_base = ioremap(JZ4740_RTC_BASE_ADDR, 0x38);
 	unsigned long wakeup_filter_ticks;
 	unsigned long reset_counter_ticks;
+	struct clk *rtc_clk;
+	unsigned long rtc_rate;
+
+	rtc_clk = clk_get(NULL, "rtc");
+	if (IS_ERR(rtc_clk))
+		panic("unable to get RTC clock");
+	rtc_rate = clk_get_rate(rtc_clk);
+	clk_put(rtc_clk);
 
 	/*
 	 * Set minimum wakeup pin assertion time: 100 ms.
 	 * Range is 0 to 2 sec if RTC is clocked at 32 kHz.
 	 */
-	wakeup_filter_ticks = (100 * jz4740_clock_bdata.rtc_rate) / 1000;
+	wakeup_filter_ticks = (100 * rtc_rate) / 1000;
 	if (wakeup_filter_ticks < JZ_RTC_WAKEUP_FILTER_MASK)
 		wakeup_filter_ticks &= JZ_RTC_WAKEUP_FILTER_MASK;
 	else
@@ -96,7 +105,7 @@ static void jz4740_power_off(void)
 	 * Set reset pin low-level assertion time after wakeup: 60 ms.
 	 * Range is 0 to 125 ms if RTC is clocked at 32 kHz.
 	 */
-	reset_counter_ticks = (60 * jz4740_clock_bdata.rtc_rate) / 1000;
+	reset_counter_ticks = (60 * rtc_rate) / 1000;
 	if (reset_counter_ticks < JZ_RTC_RESET_COUNTER_MASK)
 		reset_counter_ticks &= JZ_RTC_RESET_COUNTER_MASK;
 	else
diff --git a/arch/mips/jz4740/time.c b/arch/mips/jz4740/time.c
index 78ed765..f66f7f5 100644
--- a/arch/mips/jz4740/time.c
+++ b/arch/mips/jz4740/time.c
@@ -13,6 +13,7 @@
  *
  */
 
+#include <linux/clk.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/time.h>
@@ -115,11 +116,17 @@ void __init plat_time_init(void)
 	int ret;
 	uint32_t clk_rate;
 	uint16_t ctrl;
+	struct clk *ext_clk;
 
 	jz4740_clock_init();
 	jz4740_timer_init();
 
-	clk_rate = jz4740_clock_bdata.ext_rate >> 4;
+	ext_clk = clk_get(NULL, "ext");
+	if (IS_ERR(ext_clk))
+		panic("unable to get ext clock");
+	clk_rate = clk_get_rate(ext_clk) >> 4;
+	clk_put(ext_clk);
+
 	jz4740_jiffies_per_tick = DIV_ROUND_CLOSEST(clk_rate, HZ);
 
 	clockevent_set_clock(&jz4740_clockevent, clk_rate);
-- 
2.3.5
