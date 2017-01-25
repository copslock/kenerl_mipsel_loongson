Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jan 2017 19:57:28 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:56446 "EHLO
        outils.crapouillou.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993959AbdAYSxRtoZww (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Jan 2017 19:53:17 +0100
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
Subject: [PATCH v3 11/14] mtd: nand: jz4740: Let the pinctrl driver configure the pins
Date:   Wed, 25 Jan 2017 19:52:04 +0100
Message-Id: <20170125185207.23902-12-paul@crapouillou.net>
In-Reply-To: <20170125185207.23902-1-paul@crapouillou.net>
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
 <20170125185207.23902-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1485370367; bh=UDp8cuNHUXhrJQLy/FmSCwxFcNzQFU34PahZsP/WatI=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=POvv4+uOSkYPkMUrP7MBrcBF/AgIaJQbnWkRmDD6/+NmkZ5yfikYX01GaZipZkoqrNS89TiMl8NeCOJCDoZ5Su6mlplCtzWwtw8zCfaX89JMoGiqwuG0BtG0m3M828Q3C16hkVhYP/snhwhwLl6b3DNMtJ8Zqyy0EErNtk3QY38=
Return-Path: <paul@outils.crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56504
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

Before, this NAND driver would set itself the configuration of the
chip-select pins for the various NAND banks.

Now that the JZ4740 and similar SoCs have a pinctrl driver, we rely on
the pins being properly configured before the driver probes.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/mtd/nand/jz4740_nand.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

v2: No changes
v3: No changes

diff --git a/drivers/mtd/nand/jz4740_nand.c b/drivers/mtd/nand/jz4740_nand.c
index 5551c36adbdf..0d06a1f07d82 100644
--- a/drivers/mtd/nand/jz4740_nand.c
+++ b/drivers/mtd/nand/jz4740_nand.c
@@ -25,7 +25,6 @@
 
 #include <linux/gpio.h>
 
-#include <asm/mach-jz4740/gpio.h>
 #include <asm/mach-jz4740/jz4740_nand.h>
 
 #define JZ_REG_NAND_CTRL	0x50
@@ -310,34 +309,20 @@ static int jz_nand_detect_bank(struct platform_device *pdev,
 			       uint8_t *nand_dev_id)
 {
 	int ret;
-	int gpio;
-	char gpio_name[9];
 	char res_name[6];
 	uint32_t ctrl;
 	struct nand_chip *chip = &nand->chip;
 	struct mtd_info *mtd = nand_to_mtd(chip);
 
-	/* Request GPIO port. */
-	gpio = JZ_GPIO_MEM_CS0 + bank - 1;
-	sprintf(gpio_name, "NAND CS%d", bank);
-	ret = gpio_request(gpio, gpio_name);
-	if (ret) {
-		dev_warn(&pdev->dev,
-			"Failed to request %s gpio %d: %d\n",
-			gpio_name, gpio, ret);
-		goto notfound_gpio;
-	}
-
 	/* Request I/O resource. */
 	sprintf(res_name, "bank%d", bank);
 	ret = jz_nand_ioremap_resource(pdev, res_name,
 					&nand->bank_mem[bank - 1],
 					&nand->bank_base[bank - 1]);
 	if (ret)
-		goto notfound_resource;
+		return ret;
 
 	/* Enable chip in bank. */
-	jz_gpio_set_function(gpio, JZ_GPIO_FUNC_MEM_CS0);
 	ctrl = readl(nand->base + JZ_REG_NAND_CTRL);
 	ctrl |= JZ_NAND_CTRL_ENABLE_CHIP(bank - 1);
 	writel(ctrl, nand->base + JZ_REG_NAND_CTRL);
@@ -377,12 +362,8 @@ static int jz_nand_detect_bank(struct platform_device *pdev,
 	dev_info(&pdev->dev, "No chip found on bank %i\n", bank);
 	ctrl &= ~(JZ_NAND_CTRL_ENABLE_CHIP(bank - 1));
 	writel(ctrl, nand->base + JZ_REG_NAND_CTRL);
-	jz_gpio_set_function(gpio, JZ_GPIO_FUNC_NONE);
 	jz_nand_iounmap_resource(nand->bank_mem[bank - 1],
 				 nand->bank_base[bank - 1]);
-notfound_resource:
-	gpio_free(gpio);
-notfound_gpio:
 	return ret;
 }
 
@@ -503,7 +484,6 @@ static int jz_nand_probe(struct platform_device *pdev)
 err_unclaim_banks:
 	while (chipnr--) {
 		unsigned char bank = nand->banks[chipnr];
-		gpio_free(JZ_GPIO_MEM_CS0 + bank - 1);
 		jz_nand_iounmap_resource(nand->bank_mem[bank - 1],
 					 nand->bank_base[bank - 1]);
 	}
@@ -530,7 +510,6 @@ static int jz_nand_remove(struct platform_device *pdev)
 		if (bank != 0) {
 			jz_nand_iounmap_resource(nand->bank_mem[bank - 1],
 						 nand->bank_base[bank - 1]);
-			gpio_free(JZ_GPIO_MEM_CS0 + bank - 1);
 		}
 	}
 
-- 
2.11.0
