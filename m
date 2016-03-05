Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Mar 2016 23:40:37 +0100 (CET)
Received: from rev33.vpn.fdn.fr ([80.67.179.33]:41081 "EHLO
        outils.crapouillou.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27024652AbcCEWjlXrWSb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 5 Mar 2016 23:39:41 +0100
From:   Paul Cercueil <paul@crapouillou.net>
To:     Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Paul Cercueil <paul@crapouillou.net>,
        Paul Burton <paul.burton@imgtec.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, rtc-linux@googlegroups.com
Subject: [PATCH 5/5] MIPS: jz4740: Use the jz4740-rtc driver as the power controller
Date:   Sat,  5 Mar 2016 23:38:51 +0100
Message-Id: <1457217531-26064-5-git-send-email-paul@crapouillou.net>
In-Reply-To: <1457217531-26064-1-git-send-email-paul@crapouillou.net>
References: <1457217531-26064-1-git-send-email-paul@crapouillou.net>
Return-Path: <paul@outils.crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52469
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@crapouillou.net
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

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/boot/dts/ingenic/jz4740.dtsi |  2 ++
 arch/mips/jz4740/reset.c               | 64 ----------------------------------
 2 files changed, 2 insertions(+), 64 deletions(-)

diff --git a/arch/mips/boot/dts/ingenic/jz4740.dtsi b/arch/mips/boot/dts/ingenic/jz4740.dtsi
index 8b2437c..f2ddacb 100644
--- a/arch/mips/boot/dts/ingenic/jz4740.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4740.dtsi
@@ -32,6 +32,8 @@
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <32768>;
+
+		system-power-controller;
 	};
 
 	cgu: jz4740-cgu@10000000 {
diff --git a/arch/mips/jz4740/reset.c b/arch/mips/jz4740/reset.c
index 954e669..0a88b17 100644
--- a/arch/mips/jz4740/reset.c
+++ b/arch/mips/jz4740/reset.c
@@ -12,7 +12,6 @@
  *
  */
 
-#include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/pm.h>
@@ -57,71 +56,8 @@ static void jz4740_restart(char *command)
 	jz4740_halt();
 }
 
-#define JZ_REG_RTC_CTRL			0x00
-#define JZ_REG_RTC_HIBERNATE		0x20
-#define JZ_REG_RTC_WAKEUP_FILTER	0x24
-#define JZ_REG_RTC_RESET_COUNTER	0x28
-
-#define JZ_RTC_CTRL_WRDY		BIT(7)
-#define JZ_RTC_WAKEUP_FILTER_MASK	0x0000FFE0
-#define JZ_RTC_RESET_COUNTER_MASK	0x00000FE0
-
-static inline void jz4740_rtc_wait_ready(void __iomem *rtc_base)
-{
-	uint32_t ctrl;
-
-	do {
-		ctrl = readl(rtc_base + JZ_REG_RTC_CTRL);
-	} while (!(ctrl & JZ_RTC_CTRL_WRDY));
-}
-
-static void jz4740_power_off(void)
-{
-	void __iomem *rtc_base = ioremap(JZ4740_RTC_BASE_ADDR, 0x38);
-	unsigned long wakeup_filter_ticks;
-	unsigned long reset_counter_ticks;
-	struct clk *rtc_clk;
-	unsigned long rtc_rate;
-
-	rtc_clk = clk_get(NULL, "rtc");
-	if (IS_ERR(rtc_clk))
-		panic("unable to get RTC clock");
-	rtc_rate = clk_get_rate(rtc_clk);
-	clk_put(rtc_clk);
-
-	/*
-	 * Set minimum wakeup pin assertion time: 100 ms.
-	 * Range is 0 to 2 sec if RTC is clocked at 32 kHz.
-	 */
-	wakeup_filter_ticks = (100 * rtc_rate) / 1000;
-	if (wakeup_filter_ticks < JZ_RTC_WAKEUP_FILTER_MASK)
-		wakeup_filter_ticks &= JZ_RTC_WAKEUP_FILTER_MASK;
-	else
-		wakeup_filter_ticks = JZ_RTC_WAKEUP_FILTER_MASK;
-	jz4740_rtc_wait_ready(rtc_base);
-	writel(wakeup_filter_ticks, rtc_base + JZ_REG_RTC_WAKEUP_FILTER);
-
-	/*
-	 * Set reset pin low-level assertion time after wakeup: 60 ms.
-	 * Range is 0 to 125 ms if RTC is clocked at 32 kHz.
-	 */
-	reset_counter_ticks = (60 * rtc_rate) / 1000;
-	if (reset_counter_ticks < JZ_RTC_RESET_COUNTER_MASK)
-		reset_counter_ticks &= JZ_RTC_RESET_COUNTER_MASK;
-	else
-		reset_counter_ticks = JZ_RTC_RESET_COUNTER_MASK;
-	jz4740_rtc_wait_ready(rtc_base);
-	writel(reset_counter_ticks, rtc_base + JZ_REG_RTC_RESET_COUNTER);
-
-	jz4740_rtc_wait_ready(rtc_base);
-	writel(1, rtc_base + JZ_REG_RTC_HIBERNATE);
-
-	jz4740_halt();
-}
-
 void jz4740_reset_init(void)
 {
 	_machine_restart = jz4740_restart;
 	_machine_halt = jz4740_halt;
-	pm_power_off = jz4740_power_off;
 }
-- 
2.7.0
