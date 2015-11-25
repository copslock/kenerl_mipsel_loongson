Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Nov 2015 23:57:23 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:58447 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007618AbbKYW5VnCxb0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Nov 2015 23:57:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject; bh=+EuKL1JnpsOtNpNK/IPdxb54UJJszdjhKy7/CUqeUzo=;
        b=EZStANtlDWhHR2SWAsc/At56HGAWOKWtRaQNiG2Xtmr5B9zWavUi/GwYleRKZPTOQp7xNy4KZ/OfacAZxqujYU6RMW9D3PnqxeiFB+3896VEu5545DyA3ertayXFXxz+XyqYdXIy55S+DZyXRJVxs6HAcrx1APAzZFuCxN6shwLMvobIrUs/TbNyAAyWYnuci0ooUcMU6N8SogG/kHPucAhayHo8OZRMdJY3PUR49t4jGbapRi4BuwPOzowkuoeIBeSrS+TSBDN7RZT/WIDbsLEoe4yVH+5MderyLs2IJs/RhB4ss/ibQ5UgqiUFF7spy4gEShfItRShrLSmpjEUrQ==;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:45200 ident=simon)
        by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465)
        with esmtpsav (UNKNOWN:DHE-RSA-AES256-SHA:256/CN=Simon Arlott)
        id 1a1izx-0006zY-Mi (Exim); Wed, 25 Nov 2015 22:57:14 +0000
Subject: [PATCH (v4) 8/11] watchdog: bcm63xx_wdt: Warn if the watchdog is
 currently running
To:     Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org
References: <5650BFD6.5030700@simon.arlott.org.uk>
 <5650C08C.6090300@simon.arlott.org.uk> <5650E2FA.6090408@roeck-us.net>
 <5650E5BB.6020404@simon.arlott.org.uk> <56512937.6030903@roeck-us.net>
 <5651CB13.4090704@simon.arlott.org.uk> <5651CC90.7090402@simon.arlott.org.uk>
 <a1461a17c94353f38316d2c6ae04d6b77c91bfd4@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
 <56552214.2050808@roeck-us.net> <56556E84.50202@simon.arlott.org.uk>
 <56563B1E.6050906@simon.arlott.org.uk> <56563C2C.60308@simon.arlott.org.uk>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
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
Message-ID: <56563CC8.40002@simon.arlott.org.uk>
Date:   Wed, 25 Nov 2015 22:57:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <56563C2C.60308@simon.arlott.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <simon@fire.lp0.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50122
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

Warn when the device is registered if the hardware watchdog is currently
running and report the remaining time left.

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
---
On 25/11/15 02:51, Guenter Roeck wrote:
> This is really two logical changes, isn't it ?

Patch 7 split into two patches.

 drivers/watchdog/bcm63xx_wdt.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/bcm63xx_wdt.c b/drivers/watchdog/bcm63xx_wdt.c
index ab4a794..2312dc2 100644
--- a/drivers/watchdog/bcm63xx_wdt.c
+++ b/drivers/watchdog/bcm63xx_wdt.c
@@ -14,6 +14,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -159,6 +160,8 @@ static int bcm63xx_wdt_probe(struct platform_device *pdev)
 	struct bcm63xx_wdt_hw *hw;
 	struct watchdog_device *wdd;
 	struct resource *r;
+	u32 timeleft1, timeleft2;
+	unsigned int timeleft;
 	int ret;
 
 	hw = devm_kzalloc(&pdev->dev, sizeof(*hw), GFP_KERNEL);
@@ -199,7 +202,6 @@ static int bcm63xx_wdt_probe(struct platform_device *pdev)
 	}
 
 	raw_spin_lock_init(&hw->lock);
-	hw->running = false;
 
 	wdd->parent = &pdev->dev;
 	wdd->ops = &bcm63xx_wdt_ops;
@@ -213,6 +215,23 @@ static int bcm63xx_wdt_probe(struct platform_device *pdev)
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
 	ret = watchdog_register_device(wdd);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to register watchdog device\n");
@@ -230,6 +249,8 @@ static int bcm63xx_wdt_probe(struct platform_device *pdev)
 		dev_name(wdd->dev), hw->regs,
 		wdd->timeout, wdd->max_timeout);
 
+	if (hw->running)
+		dev_alert(wdd->dev, "running, reboot in %us\n", timeleft);
 	return 0;
 
 unregister_watchdog:
-- 
2.1.4

-- 
Simon Arlott
