Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Nov 2015 23:16:07 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:49507 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007587AbbKXWQFTobld (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 Nov 2015 23:16:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:To:From:Subject:Date:References:In-Reply-To:Message-ID; bh=Oh9Ej7KwtrJlGPaStnDC8dj9WNi4tHdfbCL01Fj2WWI=;
        b=M/RL1N9XxQXuHvNZQWiH0Bn1i2aBEm76Njk4etF9Ac32oayEPT2Ru9zRZE71xo/+8hNTC0gGRZkOE5KckHFjyLxQnrxl2251zKr+W7QUqa0OO0Y3PYJ9BdnoYuDXKzBYOPqnStNxVie/dGAaJRO7OLTMRCc4BnjbSE/gG+G6fST8+Mryiy7o1og9FbUEGInpPeqTcSxJsC1o8OoiNmCBs/Olyd0OCz6dOU99c3zkBn4cXztEOxkizOX/HOsoIPIwtoRKSFfUUD4sDR5k4mVUewewJHQmtWFv65zLRYcFM9jE1oGpdEnb6JvSsSBT63cnfYMd2qje6Cog3/2cYhd1XQ==;
Received: from lp0_webmail by proxima.lp0.eu with local 
        id 1a1LsU-0004wp-Vh (Exim); Tue, 24 Nov 2015 22:16:00 +0000
Received: from simon by proxima.lp0.eu with https;
        Tue, 24 Nov 2015 22:15:59 -0000
Message-ID: <a1461a17c94353f38316d2c6ae04d6b77c91bfd4@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
In-Reply-To: <5651CC90.7090402@simon.arlott.org.uk>
References: <5650BFD6.5030700@simon.arlott.org.uk>
    <5650C08C.6090300@simon.arlott.org.uk> <5650E2FA.6090408@roeck-us.net>
    <5650E5BB.6020404@simon.arlott.org.uk> <56512937.6030903@roeck-us.net>
    <5651CB13.4090704@simon.arlott.org.uk>
    <5651CC90.7090402@simon.arlott.org.uk>
Date:   Tue, 24 Nov 2015 22:15:59 -0000
Subject: [PATCH (v2) 7/10] watchdog: bcm63xx_wdt: Add get_timeleft function
From:   "Simon Arlott" <simon@fire.lp0.eu>
To:     linux-watchdog@vger.kernel.org
Cc:     "Guenter Roeck" <linux@roeck-us.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Jason Cooper" <jason@lakedaemon.net>,
        "Marc Zyngier" <marc.zyngier@arm.com>,
        "Kevin Cernekee" <cernekee@gmail.com>,
        "Florian Fainelli" <f.fainelli@gmail.com>,
        "Wim Van Sebroeck" <wim@iguana.be>,
        "Maxime Bizon" <mbizon@freebox.fr>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org, "Rob Herring" <robh+dt@kernel.org>,
        "Pawel Moll" <pawel.moll@arm.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Ian Campbell" <ijc+devicetree@hellion.org.uk>,
        "Kumar Gala" <galak@codeaurora.org>,
        "Jonas Gorski" <jogo@openwrt.org>
User-Agent: SquirrelMail/1.4.22
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Return-Path: <simon@fire.lp0.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50072
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: simon@fire.lp0.eu
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

Return the remaining time from the hardware control register.

Warn when the device is registered if the hardware watchdog is currently
running and report the remaining time left.

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
---
Changed "if (timeleft > 0)" to "if (hw->running)" when checking if a
warning should be printed, in case the time left is truncated down to
0 seconds.

 drivers/watchdog/bcm63xx_wdt.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/watchdog/bcm63xx_wdt.c b/drivers/watchdog/bcm63xx_wdt.c
index 3c7667a..9d099e0 100644
--- a/drivers/watchdog/bcm63xx_wdt.c
+++ b/drivers/watchdog/bcm63xx_wdt.c
@@ -14,6 +14,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -75,6 +76,19 @@ static int bcm63xx_wdt_stop(struct watchdog_device *wdd)
 	return 0;
 }

+static unsigned int bcm63xx_wdt_get_timeleft(struct watchdog_device *wdd)
+{
+	struct bcm63xx_wdt_hw *hw = watchdog_get_drvdata(wdd);
+	unsigned long flags;
+	u32 val;
+
+	raw_spin_lock_irqsave(&hw->lock, flags);
+	val = __raw_readl(hw->regs + WDT_CTL_REG);
+	val /= hw->clock_hz;
+	raw_spin_unlock_irqrestore(&hw->lock, flags);
+	return val;
+}
+
 static int bcm63xx_wdt_set_timeout(struct watchdog_device *wdd,
 	unsigned int timeout)
 {
@@ -130,6 +144,7 @@ static struct watchdog_ops bcm63xx_wdt_ops = {
 	.owner = THIS_MODULE,
 	.start = bcm63xx_wdt_start,
 	.stop = bcm63xx_wdt_stop,
+	.get_timeleft = bcm63xx_wdt_get_timeleft,
 	.set_timeout = bcm63xx_wdt_set_timeout,
 };

@@ -144,6 +159,8 @@ static int bcm63xx_wdt_probe(struct platform_device *pdev)
 	struct bcm63xx_wdt_hw *hw;
 	struct watchdog_device *wdd;
 	struct resource *r;
+	u32 timeleft1, timeleft2;
+	unsigned int timeleft;
 	int ret;

 	hw = devm_kzalloc(&pdev->dev, sizeof(*hw), GFP_KERNEL);
@@ -197,6 +214,23 @@ static int bcm63xx_wdt_probe(struct platform_device *pdev)
 	watchdog_init_timeout(wdd, 0, &pdev->dev);
 	watchdog_set_nowayout(wdd, nowayout);

+	/* Compare two reads of the time left value, 2 clock ticks apart */
+	rmb();
+	timeleft1 = __raw_readl(hw->regs + WDT_CTL_REG);
+	udelay(DIV_ROUND_UP(1000000, hw->clock_hz / 2));
+	/* Ensure the register is read twice */
+	rmb();
+	timeleft2 = __raw_readl(hw->regs + WDT_CTL_REG);
+
+	/* If the time left is changing, the watchdog is running */
+	if (timeleft1 != timeleft2) {
+		hw->running = true;
+		timeleft = bcm63xx_wdt_get_timeleft(wdd);
+	} else {
+		hw->running = false;
+		timeleft = 0;
+	}
+
 	ret = bcm63xx_timer_register(TIMER_WDT_ID, bcm63xx_wdt_isr, wdd);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to register wdt timer isr\n");
@@ -214,6 +248,8 @@ static int bcm63xx_wdt_probe(struct platform_device *pdev)
 		dev_name(wdd->dev), hw->regs,
 		wdd->timeout, wdd->max_timeout);

+	if (hw->running)
+		dev_alert(wdd->dev, "running, reboot in %us\n", timeleft);
 	return 0;

 unregister_timer:
@@ -255,6 +291,7 @@ module_platform_driver(bcm63xx_wdt_driver);

 MODULE_AUTHOR("Miguel Gaio <miguel.gaio@efixo.com>");
 MODULE_AUTHOR("Florian Fainelli <florian@openwrt.org>");
+MODULE_AUTHOR("Simon Arlott");
 MODULE_DESCRIPTION("Driver for the Broadcom BCM63xx SoC watchdog");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:bcm63xx-wdt");
-- 
2.1.4

-- 
Simon Arlott
