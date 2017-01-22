Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Jan 2017 15:52:33 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:50940 "EHLO
        outils.crapouillou.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993871AbdAVOukrn2gb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 22 Jan 2017 15:50:40 +0100
From:   Paul Cercueil <paul@crapouillou.net>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Boris Brezillon <boris.brezillon@free-electrons.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        james.hogan@imgtec.com, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 10/14] mmc: jz4740: Let the pinctrl driver configure the pins
Date:   Sun, 22 Jan 2017 15:49:43 +0100
Message-Id: <20170122144947.16158-11-paul@crapouillou.net>
In-Reply-To: <20170122144947.16158-1-paul@crapouillou.net>
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
 <20170122144947.16158-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1485096640; bh=GD2dsT7COHUBmw1hHHQMPb8PO08atKf3R/sWBK8oVR0=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=UscOK9SzNxSBcY/IZi1rMMZzIMc6z/3VDgfr4JwaDd/H8XtcmMqTcJj3E5320IwDCcmcAvjz/2QGoXbWT0qyYCtJ2bCRDR+HZ4MfvxuwLUxhy4J8g10olT/2Px1NCDnGccPhY/5Tfo5uR8kiekSR902igPDUOH+OJGxPHWiqpV0=
Return-Path: <paul@outils.crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56446
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

Now that the JZ4740 and similar SoCs have a pinctrl driver, we rely on
the pins being properly configured before the driver probes.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/mmc/host/jz4740_mmc.c | 45 +++++--------------------------------------
 1 file changed, 5 insertions(+), 40 deletions(-)

v2: Set pin sleep/default state in suspend/resume callbacks

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 819ad32964fc..b5fec5b7ee7b 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -20,14 +20,13 @@
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/scatterlist.h>
 #include <linux/clk.h>
 
 #include <linux/bitops.h>
-#include <linux/gpio.h>
-#include <asm/mach-jz4740/gpio.h>
 #include <asm/cacheflush.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
@@ -906,15 +905,6 @@ static const struct mmc_host_ops jz4740_mmc_ops = {
 	.enable_sdio_irq = jz4740_mmc_enable_sdio_irq,
 };
 
-static const struct jz_gpio_bulk_request jz4740_mmc_pins[] = {
-	JZ_GPIO_BULK_PIN(MSC_CMD),
-	JZ_GPIO_BULK_PIN(MSC_CLK),
-	JZ_GPIO_BULK_PIN(MSC_DATA0),
-	JZ_GPIO_BULK_PIN(MSC_DATA1),
-	JZ_GPIO_BULK_PIN(MSC_DATA2),
-	JZ_GPIO_BULK_PIN(MSC_DATA3),
-};
-
 static int jz4740_mmc_request_gpio(struct device *dev, int gpio,
 	const char *name, bool output, int value)
 {
@@ -978,15 +968,6 @@ static void jz4740_mmc_free_gpios(struct platform_device *pdev)
 		gpio_free(pdata->gpio_power);
 }
 
-static inline size_t jz4740_mmc_num_pins(struct jz4740_mmc_host *host)
-{
-	size_t num_pins = ARRAY_SIZE(jz4740_mmc_pins);
-	if (host->pdata && host->pdata->data_1bit)
-		num_pins -= 3;
-
-	return num_pins;
-}
-
 static int jz4740_mmc_probe(struct platform_device* pdev)
 {
 	int ret;
@@ -1027,15 +1008,9 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
 		goto err_free_host;
 	}
 
-	ret = jz_gpio_bulk_request(jz4740_mmc_pins, jz4740_mmc_num_pins(host));
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to request mmc pins: %d\n", ret);
-		goto err_free_host;
-	}
-
 	ret = jz4740_mmc_request_gpios(mmc, pdev);
 	if (ret)
-		goto err_gpio_bulk_free;
+		goto err_release_dma;
 
 	mmc->ops = &jz4740_mmc_ops;
 	mmc->f_min = JZ_MMC_CLK_RATE / 128;
@@ -1091,10 +1066,9 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
 	free_irq(host->irq, host);
 err_free_gpios:
 	jz4740_mmc_free_gpios(pdev);
-err_gpio_bulk_free:
+err_release_dma:
 	if (host->use_dma)
 		jz4740_mmc_release_dma_channels(host);
-	jz_gpio_bulk_free(jz4740_mmc_pins, jz4740_mmc_num_pins(host));
 err_free_host:
 	mmc_free_host(mmc);
 
@@ -1114,7 +1088,6 @@ static int jz4740_mmc_remove(struct platform_device *pdev)
 	free_irq(host->irq, host);
 
 	jz4740_mmc_free_gpios(pdev);
-	jz_gpio_bulk_free(jz4740_mmc_pins, jz4740_mmc_num_pins(host));
 
 	if (host->use_dma)
 		jz4740_mmc_release_dma_channels(host);
@@ -1128,20 +1101,12 @@ static int jz4740_mmc_remove(struct platform_device *pdev)
 
 static int jz4740_mmc_suspend(struct device *dev)
 {
-	struct jz4740_mmc_host *host = dev_get_drvdata(dev);
-
-	jz_gpio_bulk_suspend(jz4740_mmc_pins, jz4740_mmc_num_pins(host));
-
-	return 0;
+	return pinctrl_pm_select_sleep_state(dev);
 }
 
 static int jz4740_mmc_resume(struct device *dev)
 {
-	struct jz4740_mmc_host *host = dev_get_drvdata(dev);
-
-	jz_gpio_bulk_resume(jz4740_mmc_pins, jz4740_mmc_num_pins(host));
-
-	return 0;
+	return pinctrl_pm_select_default_state(dev);
 }
 
 static SIMPLE_DEV_PM_OPS(jz4740_mmc_pm_ops, jz4740_mmc_suspend,
-- 
2.11.0
