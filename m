Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Dec 2015 14:08:12 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:53999 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008078AbbLANIH1l5cd (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 1 Dec 2015 14:08:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject; bh=RkMibMKP8ZudV5SXfRP37rgSuHJkQxOqAUfTptiKD18=;
        b=BVu/zAGjf1GyM0Ai2fdyhilspyhtoaCkvEUoAvvGdB3BnQYxjPywEjRb/Ea4WmYxDjnEE5fDyNhG38Yprpr/ny1f+7d9UOetL58xSFkvTlFETpEStI4icvhfVl5PJIcm+4J8idhe18L4FuepS+1a2k6SENd8iKGdbErAS2YeILn8VdATcW8rZ3pq95FUdqjOmKFkarfqhCGzsgvgfB1X0atH04iUJk5HNRBX95S4OFduvlrcsPDvs/VpNsw+qRP4ixm/10NuYrDIMHLsbE47Y4DOTOlFGzDWhn9989s9MPI5SOcarHPkeio0sG5BylZ2JBWlU+5SH3h08Q/ch1v0Tw==;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:45588 ident=simon)
        by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465)
        with esmtpsav (UNKNOWN:DHE-RSA-AES256-SHA:256/CN=Simon Arlott)
        id 1a3kez-00086Q-Kd (Exim); Tue, 01 Dec 2015 13:07:58 +0000
Subject: [PATCH 07/11] watchdog: bcm63xx_wdt: Add get_timeleft function
To:     Guenter Roeck <linux@roeck-us.net>,
        Thomas Gleixner <tglx@linutronix.de>
References: <565D9A40.60409@simon.arlott.org.uk>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        Jonas Gorski <jogo@openwrt.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Maxime Bizon <mbizon@freebox.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-watchdog@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
From:   Simon Arlott <simon@fire.lp0.eu>
Message-ID: <565D9BAC.2010809@simon.arlott.org.uk>
Date:   Tue, 1 Dec 2015 13:07:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <565D9A40.60409@simon.arlott.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <simon@fire.lp0.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50258
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
 drivers/watchdog/bcm63xx_wdt.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/watchdog/bcm63xx_wdt.c b/drivers/watchdog/bcm63xx_wdt.c
index 0a19731..ab4a794 100644
--- a/drivers/watchdog/bcm63xx_wdt.c
+++ b/drivers/watchdog/bcm63xx_wdt.c
@@ -78,6 +78,19 @@ static int bcm63xx_wdt_stop(struct watchdog_device *wdd)
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
@@ -132,6 +145,7 @@ static struct watchdog_ops bcm63xx_wdt_ops = {
 	.owner = THIS_MODULE,
 	.start = bcm63xx_wdt_start,
 	.stop = bcm63xx_wdt_stop,
+	.get_timeleft = bcm63xx_wdt_get_timeleft,
 	.set_timeout = bcm63xx_wdt_set_timeout,
 };
 
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
