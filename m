Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Nov 2015 23:50:19 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:58271 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010189AbbKYWuR3kdy0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Nov 2015 23:50:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject; bh=D3OV34DA4MoIFZRLYKBiT1m3ewrCjr6g/8UvtbQG/BE=;
        b=mzMHBrnFFlU6NAqjMEMTzQhWIklMuzbCHFcYG2dAI7/vGRTy8OF0Yyc+RehjlshcCeJbaanj4MT1Wq8BGcbAcZmnvniqJyXU4u0Gg2ynOjb2skU7TCmv+MOA47WoJarSAbwHYcL9y+elzb+67/B08tY7WD9X1QNQUmKsQThuO3lQIydfOJF+B8g//8DVCzTMgkjAcGMglcb9hbNxnI0FQEi3hCauMNKl3COYoQjX/CPP28aoYoEB/h6FG22zv8DFj65Xr+KFkSoiAHb7OLb7T9EijXtMncYBTMqCfeFFgNb1gMavzKtuQr2mfFexCmdLXfcRwKRYKyFFac0lmpi6Ag==;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:45192 ident=simon)
        by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465)
        with esmtpsav (UNKNOWN:DHE-RSA-AES256-SHA:256/CN=Simon Arlott)
        id 1a1it5-0006jz-Re (Exim); Wed, 25 Nov 2015 22:50:08 +0000
Subject: [PATCH (v3) 7/11] watchdog: bcm63xx_wdt: Add get_timeleft function
To:     Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org
References: <5650BFD6.5030700@simon.arlott.org.uk>
 <5650C08C.6090300@simon.arlott.org.uk> <5650E2FA.6090408@roeck-us.net>
 <5650E5BB.6020404@simon.arlott.org.uk> <56512937.6030903@roeck-us.net>
 <5651CB13.4090704@simon.arlott.org.uk> <5651CC90.7090402@simon.arlott.org.uk>
 <a1461a17c94353f38316d2c6ae04d6b77c91bfd4@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
 <56552214.2050808@roeck-us.net> <56556E84.50202@simon.arlott.org.uk>
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
Message-ID: <56563B1E.6050906@simon.arlott.org.uk>
Date:   Wed, 25 Nov 2015 22:50:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <56556E84.50202@simon.arlott.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <simon@fire.lp0.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50120
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

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
---
On 25/11/15 02:51, Guenter Roeck wrote:
> This is really two logical changes, isn't it ?

Patch 7 split into two patches.

 drivers/watchdog/bcm63xx_wdt.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/bcm63xx_wdt.c b/drivers/watchdog/bcm63xx_wdt.c
index 0a19731..5615277 100644
--- a/drivers/watchdog/bcm63xx_wdt.c
+++ b/drivers/watchdog/bcm63xx_wdt.c
@@ -14,6 +14,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -78,6 +79,19 @@ static int bcm63xx_wdt_stop(struct watchdog_device *wdd)
 	return 0;
 }
 
+static unsigned int bcm63xx_wdt_get_timeleft(struct watchdog_device *wdd)
+{
+	struct bcm63xx_wdt_hw *hw = to_wdt_hw(wdd);
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
@@ -132,6 +146,7 @@ static struct watchdog_ops bcm63xx_wdt_ops = {
 	.owner = THIS_MODULE,
 	.start = bcm63xx_wdt_start,
 	.stop = bcm63xx_wdt_stop,
+	.get_timeleft = bcm63xx_wdt_get_timeleft,
 	.set_timeout = bcm63xx_wdt_set_timeout,
 };
 
@@ -215,7 +230,6 @@ static int bcm63xx_wdt_probe(struct platform_device *pdev)
 		"%s at MMIO 0x%p (timeout = %us, max_timeout = %us)",
 		dev_name(wdd->dev), hw->regs,
 		wdd->timeout, wdd->max_timeout);
-
 	return 0;
 
 unregister_watchdog:
@@ -256,6 +270,7 @@ module_platform_driver(bcm63xx_wdt_driver);
 
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
