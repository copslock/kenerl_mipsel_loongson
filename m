Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Nov 2015 23:48:13 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:58203 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007618AbbKYWsLmRPm0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Nov 2015 23:48:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject; bh=IM/8vabP7EmxE/u2lvvAt3ASP0bRBZTc2WPMDKRDGGg=;
        b=E00lG5wblKmLT1ObQR2qw/4NMxysyp8d2dHoXjj6KFH5JBLYW4j0aZJm/cHso8yimbRglkaGNFjvWQ8q2BzK5+wvHIYzW6k36OI5aCiyP7RAqTe6hlTL9GMhHob8KwshgtyOHUWAvBww5V/hkwvJpVuow5opjpR3NMwRZmtwG3H2qdcL9apsAbcXnxCgCUq6jqnjBK3QCC+vTn+IeRZ3MPSU2YrDj/ZFSJyO32z91NS6Khv6qR+90MvXF/k0DUk1Re92KKd7sGqAX/GwZ0HY2IX7r8itkWnPUIz7+/g2KfBfX/eZrI/xyaQqHoLE8JV8gE6/UT+r7Qwo4zM8y2kLFg==;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:45187 ident=simon)
        by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465)
        with esmtpsav (UNKNOWN:DHE-RSA-AES256-SHA:256/CN=Simon Arlott)
        id 1a1ir2-0006Z0-DO (Exim); Wed, 25 Nov 2015 22:48:01 +0000
Subject: [PATCH (v3) 6/11] watchdog: bcm63xx_wdt: Obtain watchdog clock HZ
 from "periph" clk
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-watchdog@vger.kernel.org
References: <5650BFD6.5030700@simon.arlott.org.uk>
 <5650C08C.6090300@simon.arlott.org.uk> <5650E2FA.6090408@roeck-us.net>
 <5650E5BB.6020404@simon.arlott.org.uk> <56512937.6030903@roeck-us.net>
 <5651CB13.4090704@simon.arlott.org.uk> <5651CC3C.5090200@simon.arlott.org.uk>
 <38e0094262a1f609b95697730137fb81dc83fcea@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
 <5654E7DE.4020400@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Maxime Bizon <mbizon@freebox.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Jonas Gorski <jogo@openwrt.org>
From:   Simon Arlott <simon@fire.lp0.eu>
Message-ID: <56563A9F.5000901@simon.arlott.org.uk>
Date:   Wed, 25 Nov 2015 22:47:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <5654E7DE.4020400@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <simon@fire.lp0.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50119
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

Instead of using a fixed clock HZ in the driver, obtain it from the
"periph" clk that the watchdog timer uses.

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
---
Patch 7 split into two patches.

On 24/11/15 22:42, Florian Fainelli wrote:
> On 24/11/15 14:12, Simon Arlott wrote:
>> Instead of using a fixed clock HZ in the driver, obtain it from the
>> "periph" clk that the watchdog timer uses.
>> 
>> Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
> 
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> 

Changed because of the reordering of timer/watchdog register calls.

 drivers/watchdog/bcm63xx_wdt.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/bcm63xx_wdt.c b/drivers/watchdog/bcm63xx_wdt.c
index 2257924..0a19731 100644
--- a/drivers/watchdog/bcm63xx_wdt.c
+++ b/drivers/watchdog/bcm63xx_wdt.c
@@ -13,6 +13,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/clk.h>
 #include <linux/errno.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -32,12 +33,14 @@
 
 #define PFX KBUILD_MODNAME
 
-#define WDT_HZ			50000000		/* Fclk */
+#define WDT_CLK_NAME		"periph"
 
 struct bcm63xx_wdt_hw {
 	struct watchdog_device wdd;
 	raw_spinlock_t lock;
 	void __iomem *regs;
+	struct clk *clk;
+	unsigned long clock_hz;
 	bool running;
 };
 
@@ -54,7 +57,7 @@ static int bcm63xx_wdt_start(struct watchdog_device *wdd)
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&hw->lock, flags);
-	bcm_writel(wdd->timeout * WDT_HZ, hw->regs + WDT_DEFVAL_REG);
+	bcm_writel(wdd->timeout * hw->clock_hz, hw->regs + WDT_DEFVAL_REG);
 	bcm_writel(WDT_START_1, hw->regs + WDT_CTL_REG);
 	bcm_writel(WDT_START_2, hw->regs + WDT_CTL_REG);
 	hw->running = true;
@@ -118,7 +121,7 @@ static void bcm63xx_wdt_isr(void *data)
 			die(PFX ": watchdog timer expired\n", get_irq_regs());
 		}
 
-		ms = timeleft / (WDT_HZ / 1000);
+		ms = timeleft / (hw->clock_hz / 1000);
 		dev_alert(hw->wdd.dev,
 			"warning timer fired, reboot in %ums\n", ms);
 	}
@@ -162,6 +165,25 @@ static int bcm63xx_wdt_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
+	hw->clk = devm_clk_get(&pdev->dev, WDT_CLK_NAME);
+	if (IS_ERR(hw->clk)) {
+		if (PTR_ERR(hw->clk) != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "unable to request clock\n");
+		return PTR_ERR(hw->clk);
+	}
+
+	hw->clock_hz = clk_get_rate(hw->clk);
+	if (!hw->clock_hz) {
+		dev_err(&pdev->dev, "unable to fetch clock rate\n");
+		return -EINVAL;
+	}
+
+	ret = clk_prepare_enable(hw->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "unable to enable clock\n");
+		return ret;
+	}
+
 	raw_spin_lock_init(&hw->lock);
 	hw->running = false;
 
@@ -169,7 +191,7 @@ static int bcm63xx_wdt_probe(struct platform_device *pdev)
 	wdd->ops = &bcm63xx_wdt_ops;
 	wdd->info = &bcm63xx_wdt_info;
 	wdd->min_timeout = 1;
-	wdd->max_timeout = 0xffffffff / WDT_HZ;
+	wdd->max_timeout = 0xffffffff / hw->clock_hz;
 	wdd->timeout = min(30U, wdd->max_timeout);
 
 	platform_set_drvdata(pdev, hw);
@@ -180,7 +202,7 @@ static int bcm63xx_wdt_probe(struct platform_device *pdev)
 	ret = watchdog_register_device(wdd);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to register watchdog device\n");
-		return ret;
+		goto disable_clk;
 	}
 
 	ret = bcm63xx_timer_register(TIMER_WDT_ID, bcm63xx_wdt_isr, hw);
@@ -198,6 +220,9 @@ static int bcm63xx_wdt_probe(struct platform_device *pdev)
 
 unregister_watchdog:
 	watchdog_unregister_device(wdd);
+
+disable_clk:
+	clk_disable_unprepare(hw->clk);
 	return ret;
 }
 
@@ -207,6 +232,7 @@ static int bcm63xx_wdt_remove(struct platform_device *pdev)
 
 	bcm63xx_timer_unregister(TIMER_WDT_ID);
 	watchdog_unregister_device(&hw->wdd);
+	clk_disable_unprepare(hw->clk);
 	return 0;
 }
 
-- 
2.1.4

-- 
Simon Arlott
