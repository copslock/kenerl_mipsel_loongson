Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Nov 2015 00:09:58 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:58843 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007618AbbKYXJ4GRKq0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 Nov 2015 00:09:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject; bh=v8L+GMVk6pxaSoIXchJ2ouUhHGGuv4K+DMKdZuIwf0M=;
        b=a3ar1jx0NIlXh7lbyDknkiqcuMw/G4NyfD0eQaHorPQ1yPr0ylKxKSAsP1G7V1URNMJNbPdDXc1Hu66UodxNqGOFGfSlvSOHtcFtsSJeiDCSCy6mcCnKag2+QqCoMBX+FohMmFOimGI+R4mlKwCvBWBlXgVmvWnfQfCHhYLunEyned+88ywWpMWymbGDw6raQFM/0tDXHEKNf7cHT/35ZIzS1OxFpDq1PD2dn3XV8ZvZ8nwScWBqexWijsNpTngVyDfMC09vRVaeLdoRZV2KYM+nrt7sgACTxsAWUpREu7iHqVt2FZzeWq+ObP4QzKXBIUjZd8L04PLfo3fV4q5ljQ==;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:45217 ident=simon)
        by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465)
        with esmtpsav (UNKNOWN:DHE-RSA-AES256-SHA:256/CN=Simon Arlott)
        id 1a1jC3-000810-Ix (Exim); Wed, 25 Nov 2015 23:09:44 +0000
Subject: [PATCH (v2) 11/11] watchdog: bcm63xx_wdt: Use brcm,bcm6345-wdt device
 tree binding
To:     Guenter Roeck <linux@roeck-us.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Maxime Bizon <mbizon@freebox.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org
References: <5650BFD6.5030700@simon.arlott.org.uk>
 <5650C08C.6090300@simon.arlott.org.uk> <5650E2FA.6090408@roeck-us.net>
 <5650E5BB.6020404@simon.arlott.org.uk> <56512937.6030903@roeck-us.net>
 <5651CB13.4090704@simon.arlott.org.uk> <5651CDB6.5030406@simon.arlott.org.uk>
Cc:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Jonas Gorski <jogo@openwrt.org>
From:   Simon Arlott <simon@fire.lp0.eu>
Message-ID: <56563FB6.8040001@simon.arlott.org.uk>
Date:   Wed, 25 Nov 2015 23:09:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <5651CDB6.5030406@simon.arlott.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <simon@fire.lp0.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50124
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

Add of_match_table for "brcm,bcm6345-wdt".

Use a NULL clock name when not on mach-bcm63xx so that the device tree
clock name does not have to be "periph".

Allow the watchdog to be selected on BMIPS_GENERIC and select the BCM6345
timer interrupt handler.

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
---
Patch 7 split into two patches.

On 25/11/15 02:44, Guenter Roeck wrote:
>> +	hw = devm_kzalloc(&pdev->dev, sizeof(*hw), GFP_KERNEL);
>> +	wdd = devm_kzalloc(&pdev->dev, sizeof(*wdd), GFP_KERNEL);
> 
> It would be better to allocate wdd as part of struct bcm63xx_wdt_hw.

This altered the context of this patch (was 10/10 now 11/11) because
platform_get_drvdata() is now "hw" instead of "wdd".

 drivers/watchdog/Kconfig       |  3 ++-
 drivers/watchdog/bcm63xx_wdt.c | 14 +++++++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 6815b74..0c50add 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1272,8 +1272,9 @@ config OCTEON_WDT
 
 config BCM63XX_WDT
 	tristate "Broadcom BCM63xx hardware watchdog"
-	depends on BCM63XX
+	depends on BCM63XX || BMIPS_GENERIC
 	select WATCHDOG_CORE
+	select BCM6345_L2_TIMER_IRQ if BMIPS_GENERIC
 	help
 	  Watchdog driver for the built in watchdog hardware in Broadcom
 	  BCM63xx SoC.
diff --git a/drivers/watchdog/bcm63xx_wdt.c b/drivers/watchdog/bcm63xx_wdt.c
index fa6c28b..4db4145 100644
--- a/drivers/watchdog/bcm63xx_wdt.c
+++ b/drivers/watchdog/bcm63xx_wdt.c
@@ -22,6 +22,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/mod_devicetable.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
 #include <linux/watchdog.h>
@@ -31,7 +32,11 @@
 
 #define PFX KBUILD_MODNAME
 
-#define WDT_CLK_NAME		"periph"
+#ifdef CONFIG_BCM63XX
+# define WDT_CLK_NAME		"periph"
+#else
+# define WDT_CLK_NAME		NULL
+#endif
 
 struct bcm63xx_wdt_hw {
 	struct watchdog_device wdd;
@@ -286,12 +291,19 @@ static void bcm63xx_wdt_shutdown(struct platform_device *pdev)
 	bcm63xx_wdt_stop(&hw->wdd);
 }
 
+static const struct of_device_id bcm63xx_wdt_dt_ids[] = {
+	{ .compatible = "brcm,bcm6345-wdt" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, bcm63xx_wdt_dt_ids);
+
 static struct platform_driver bcm63xx_wdt_driver = {
 	.probe	= bcm63xx_wdt_probe,
 	.remove = bcm63xx_wdt_remove,
 	.shutdown = bcm63xx_wdt_shutdown,
 	.driver = {
 		.name = "bcm63xx-wdt",
+		.of_match_table = bcm63xx_wdt_dt_ids,
 	}
 };
 
-- 
2.1.4

-- 
Simon Arlott
