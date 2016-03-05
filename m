Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Mar 2016 23:40:18 +0100 (CET)
Received: from rev33.vpn.fdn.fr ([80.67.179.33]:41053 "EHLO
        outils.crapouillou.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27015015AbcCEWjiHOnVb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 5 Mar 2016 23:39:38 +0100
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
Subject: [PATCH 4/5] rtc: jz4740_rtc: Add support for acting as the system power controller
Date:   Sat,  5 Mar 2016 23:38:50 +0100
Message-Id: <1457217531-26064-4-git-send-email-paul@crapouillou.net>
In-Reply-To: <1457217531-26064-1-git-send-email-paul@crapouillou.net>
References: <1457217531-26064-1-git-send-email-paul@crapouillou.net>
Return-Path: <paul@outils.crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52468
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
 drivers/rtc/rtc-jz4740.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
index 3914b1c..f53cfd6 100644
--- a/drivers/rtc/rtc-jz4740.c
+++ b/drivers/rtc/rtc-jz4740.c
@@ -14,11 +14,13 @@
  *
  */
 
+#include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/reboot.h>
 #include <linux/rtc.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -28,6 +30,8 @@
 #define JZ_REG_RTC_SEC_ALARM	0x08
 #define JZ_REG_RTC_REGULATOR	0x0C
 #define JZ_REG_RTC_HIBERNATE	0x20
+#define JZ_REG_RTC_WAKEUP_FILTER	0x24
+#define JZ_REG_RTC_RESET_COUNTER	0x28
 #define JZ_REG_RTC_SCRATCHPAD	0x34
 
 /* The following are present on the jz4780 */
@@ -45,6 +49,9 @@
 /* Magic value to enable writes on jz4780 */
 #define JZ_RTC_WENR_MAGIC	0xA55A
 
+#define JZ_RTC_WAKEUP_FILTER_MASK	0x0000FFE0
+#define JZ_RTC_RESET_COUNTER_MASK	0x00000FE0
+
 enum jz4740_rtc_type {
 	ID_JZ4740,
 	ID_JZ4780,
@@ -59,8 +66,13 @@ struct jz4740_rtc {
 	int irq;
 
 	spinlock_t lock;
+
+	unsigned int min_wakeup_pin_assert_time;
+	unsigned int reset_pin_assert_time;
 };
 
+static struct device *dev_for_power_off;
+
 static inline uint32_t jz4740_rtc_reg_read(struct jz4740_rtc *rtc, size_t reg)
 {
 	return readl(rtc->base + reg);
@@ -246,6 +258,49 @@ void jz4740_rtc_poweroff(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(jz4740_rtc_poweroff);
 
+static void jz4740_rtc_power_off(void)
+{
+	struct jz4740_rtc *rtc = dev_get_drvdata(dev_for_power_off);
+	unsigned long wakeup_filter_ticks;
+	unsigned long reset_counter_ticks;
+	struct clk *rtc_clk;
+	unsigned long rtc_rate;
+
+	rtc_clk = clk_get(dev_for_power_off, "rtc");
+	if (IS_ERR(rtc_clk))
+		panic("unable to get RTC clock");
+	rtc_rate = clk_get_rate(rtc_clk);
+	clk_put(rtc_clk);
+
+	/*
+	 * Set minimum wakeup pin assertion time: 100 ms.
+	 * Range is 0 to 2 sec if RTC is clocked at 32 kHz.
+	 */
+	wakeup_filter_ticks =
+		(rtc->min_wakeup_pin_assert_time * rtc_rate) / 1000;
+	if (wakeup_filter_ticks < JZ_RTC_WAKEUP_FILTER_MASK)
+		wakeup_filter_ticks &= JZ_RTC_WAKEUP_FILTER_MASK;
+	else
+		wakeup_filter_ticks = JZ_RTC_WAKEUP_FILTER_MASK;
+	jz4740_rtc_reg_write(rtc,
+			JZ_REG_RTC_WAKEUP_FILTER, wakeup_filter_ticks);
+
+	/*
+	 * Set reset pin low-level assertion time after wakeup: 60 ms.
+	 * Range is 0 to 125 ms if RTC is clocked at 32 kHz.
+	 */
+	reset_counter_ticks = (rtc->reset_pin_assert_time * rtc_rate) / 1000;
+	if (reset_counter_ticks < JZ_RTC_RESET_COUNTER_MASK)
+		reset_counter_ticks &= JZ_RTC_RESET_COUNTER_MASK;
+	else
+		reset_counter_ticks = JZ_RTC_RESET_COUNTER_MASK;
+	jz4740_rtc_reg_write(rtc,
+			JZ_REG_RTC_RESET_COUNTER, reset_counter_ticks);
+
+	jz4740_rtc_poweroff(dev_for_power_off);
+	machine_halt();
+}
+
 static const struct of_device_id jz4740_rtc_of_match[] = {
 	{ .compatible = "ingenic,jz4740-rtc", .data = (void *) ID_JZ4740 },
 	{ .compatible = "ingenic,jz4780-rtc", .data = (void *) ID_JZ4780 },
@@ -314,6 +369,28 @@ static int jz4740_rtc_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (of_device_is_system_power_controller(pdev->dev.of_node)) {
+		if (!pm_power_off) {
+			/* Default: 60ms */
+			rtc->reset_pin_assert_time = 60;
+			device_property_read_u32(&pdev->dev,
+					"reset-pin-assert-time",
+					&rtc->reset_pin_assert_time);
+
+			/* Default: 100ms */
+			rtc->min_wakeup_pin_assert_time = 100;
+			device_property_read_u32(&pdev->dev,
+					"min-wakeup-pin-assert-time",
+					&rtc->min_wakeup_pin_assert_time);
+
+			dev_for_power_off = &pdev->dev;
+			pm_power_off = jz4740_rtc_power_off;
+		} else {
+			dev_err(&pdev->dev,
+					"Poweroff handler already present!\n");
+		}
+	}
+
 	return 0;
 }
 
-- 
2.7.0
