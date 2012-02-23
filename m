Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Feb 2012 17:08:19 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:47370 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903756Ab2BWQDe (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 23 Feb 2012 17:03:34 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH V2 08/14] MIPS: lantiq: convert falcon gpio to clkdev api
Date:   Thu, 23 Feb 2012 17:03:07 +0100
Message-Id: <1330012993-13510-8-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1330012993-13510-1-git-send-email-blogic@openwrt.org>
References: <1330012993-13510-1-git-send-email-blogic@openwrt.org>
X-archive-position: 32514
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

The falcon gpio clocks used to be enabled when registering the platform device.
Move this code into the driver and use clkdev api.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/lantiq/falcon/devices.c |    5 -----
 arch/mips/lantiq/falcon/gpio.c    |    9 +++++++++
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/mips/lantiq/falcon/devices.c b/arch/mips/lantiq/falcon/devices.c
index 4f47b44..6cd7a88 100644
--- a/arch/mips/lantiq/falcon/devices.c
+++ b/arch/mips/lantiq/falcon/devices.c
@@ -111,9 +111,6 @@ falcon_register_gpio(void)
 		falcon_gpio1_res, ARRAY_SIZE(falcon_gpio1_res));
 	platform_device_register_simple("falcon_gpio", 2,
 		falcon_gpio2_res, ARRAY_SIZE(falcon_gpio2_res));
-	ltq_sysctl_activate(SYSCTL_SYS1, ACTS_PADCTRL1 | ACTS_P1);
-	ltq_sysctl_activate(SYSCTL_SYSETH, ACTS_PADCTRL0 |
-		ACTS_PADCTRL2 | ACTS_P0 | ACTS_P2);
 }
 
 void __init
@@ -123,6 +120,4 @@ falcon_register_gpio_extra(void)
 		falcon_gpio3_res, ARRAY_SIZE(falcon_gpio3_res));
 	platform_device_register_simple("falcon_gpio", 4,
 		falcon_gpio4_res, ARRAY_SIZE(falcon_gpio4_res));
-	ltq_sysctl_activate(SYSCTL_SYS1,
-		ACTS_PADCTRL3 | ACTS_PADCTRL4 | ACTS_P3 | ACTS_P4);
 }
diff --git a/arch/mips/lantiq/falcon/gpio.c b/arch/mips/lantiq/falcon/gpio.c
index b7611d7..89c9896 100644
--- a/arch/mips/lantiq/falcon/gpio.c
+++ b/arch/mips/lantiq/falcon/gpio.c
@@ -71,6 +71,7 @@ struct falcon_gpio_port {
 	void __iomem *port;
 	unsigned int irq_base;
 	unsigned int chained_irq;
+	struct clk *clk;
 };
 
 static struct falcon_gpio_port ltq_gpio_port[MAX_PORTS];
@@ -332,6 +333,14 @@ falcon_gpio_probe(struct platform_device *pdev)
 		goto err;
 	}
 
+	gpio_port->clk = clk_get(&pdev->dev, NULL);
+	if (!gpio_port->clk) {
+		dev_err(&pdev->dev, "Could not get clock\n");
+		ret = -ENOENT;
+		goto err;
+	}
+	clk_enable(gpio_port->clk);
+
 	if (irq > 0) {
 		/* irq_chip support */
 		gpio_port->gpio_chip.to_irq = falcon_gpio_to_irq;
-- 
1.7.7.1
