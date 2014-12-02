Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Dec 2014 20:47:30 +0100 (CET)
Received: from smtp-out-013.synserver.de ([212.40.185.13]:1038 "EHLO
        smtp-out-013.synserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007841AbaLBTr33A0LF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Dec 2014 20:47:29 +0100
Received: (qmail 28061 invoked by uid 0); 2 Dec 2014 19:47:27 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@laprican.de
X-SynServer-PPID: 27907
Received: from ppp-82-135-76-235.dynamic.mnet-online.de (HELO lars-laptop.fritz.box) [82.135.76.235]
  by 217.119.54.73 with SMTP; 2 Dec 2014 19:47:27 -0000
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Brian Norris <computersforpeace@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] mtd: nand: jz4740: Convert to GPIO descriptor API
Date:   Tue,  2 Dec 2014 20:48:26 +0100
Message-Id: <1417549706-28420-1-git-send-email-lars@metafoo.de>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44547
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
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

Use the GPIO descriptor API instead of the deprecated legacy GPIO API to
manage the busy GPIO.

The patch updates both the jz4740 nand driver and the only user of the driver
the qi-lb60 board driver.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
This patch should preferably be merged through the MTD tree with Ralf's ack for
the MIPS bits.
---
 arch/mips/include/asm/mach-jz4740/jz4740_nand.h |    2 --
 arch/mips/jz4740/board-qi_lb60.c                |   11 ++++++++-
 drivers/mtd/nand/jz4740_nand.c                  |   29 ++++++++---------------
 3 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/arch/mips/include/asm/mach-jz4740/jz4740_nand.h b/arch/mips/include/asm/mach-jz4740/jz4740_nand.h
index 986982d..79cff26 100644
--- a/arch/mips/include/asm/mach-jz4740/jz4740_nand.h
+++ b/arch/mips/include/asm/mach-jz4740/jz4740_nand.h
@@ -27,8 +27,6 @@ struct jz_nand_platform_data {
 
 	struct nand_ecclayout	*ecc_layout;
 
-	unsigned int busy_gpio;
-
 	unsigned char banks[JZ_NAND_NUM_BANKS];
 
 	void (*ident_callback)(struct platform_device *, struct nand_chip *,
diff --git a/arch/mips/jz4740/board-qi_lb60.c b/arch/mips/jz4740/board-qi_lb60.c
index c454525..9dd051e 100644
--- a/arch/mips/jz4740/board-qi_lb60.c
+++ b/arch/mips/jz4740/board-qi_lb60.c
@@ -140,10 +140,18 @@ static void qi_lb60_nand_ident(struct platform_device *pdev,
 
 static struct jz_nand_platform_data qi_lb60_nand_pdata = {
 	.ident_callback = qi_lb60_nand_ident,
-	.busy_gpio = 94,
 	.banks = { 1 },
 };
 
+static struct gpiod_lookup_table qi_lb60_nand_gpio_table = {
+	.dev_id = "jz4740-nand.0",
+	.table = {
+		GPIO_LOOKUP("Bank C", 30, "busy", 0),
+		{ },
+	},
+};
+
+
 /* Keyboard*/
 
 #define KEY_QI_QI	KEY_F13
@@ -472,6 +480,7 @@ static int __init qi_lb60_init_platform_devices(void)
 	jz4740_mmc_device.dev.platform_data = &qi_lb60_mmc_pdata;
 
 	gpiod_add_lookup_table(&qi_lb60_audio_gpio_table);
+	gpiod_add_lookup_table(&qi_lb60_nand_gpio_table);
 
 	jz4740_serial_device_register();
 
diff --git a/drivers/mtd/nand/jz4740_nand.c b/drivers/mtd/nand/jz4740_nand.c
index a2c804d..1994996 100644
--- a/drivers/mtd/nand/jz4740_nand.c
+++ b/drivers/mtd/nand/jz4740_nand.c
@@ -69,7 +69,7 @@ struct jz_nand {
 
 	int selected_bank;
 
-	struct jz_nand_platform_data *pdata;
+	struct gpio_desc *busy_gpio;
 	bool is_reading;
 };
 
@@ -131,7 +131,7 @@ static void jz_nand_cmd_ctrl(struct mtd_info *mtd, int dat, unsigned int ctrl)
 static int jz_nand_dev_ready(struct mtd_info *mtd)
 {
 	struct jz_nand *nand = mtd_to_jz_nand(mtd);
-	return gpio_get_value_cansleep(nand->pdata->busy_gpio);
+	return gpiod_get_value_cansleep(nand->busy_gpio);
 }
 
 static void jz_nand_hwctl(struct mtd_info *mtd, int mode)
@@ -423,14 +423,12 @@ static int jz_nand_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_free;
 
-	if (pdata && gpio_is_valid(pdata->busy_gpio)) {
-		ret = gpio_request(pdata->busy_gpio, "NAND busy pin");
-		if (ret) {
-			dev_err(&pdev->dev,
-				"Failed to request busy gpio %d: %d\n",
-				pdata->busy_gpio, ret);
-			goto err_iounmap_mmio;
-		}
+	nand->busy_gpio = devm_gpiod_get_optional(&pdev->dev, "busy", GPIOD_IN);
+	if (IS_ERR(nand->busy_gpio)) {
+		ret = PTR_ERR(nand->busy_gpio);
+		dev_err(&pdev->dev, "Failed to request busy gpio %d\n",
+		    ret);
+		goto err_iounmap_mmio;
 	}
 
 	mtd		= &nand->mtd;
@@ -454,10 +452,9 @@ static int jz_nand_probe(struct platform_device *pdev)
 	chip->cmd_ctrl = jz_nand_cmd_ctrl;
 	chip->select_chip = jz_nand_select_chip;
 
-	if (pdata && gpio_is_valid(pdata->busy_gpio))
+	if (nand->busy_gpio)
 		chip->dev_ready = jz_nand_dev_ready;
 
-	nand->pdata = pdata;
 	platform_set_drvdata(pdev, nand);
 
 	/* We are going to autodetect NAND chips in the banks specified in the
@@ -496,7 +493,7 @@ static int jz_nand_probe(struct platform_device *pdev)
 	}
 	if (chipnr == 0) {
 		dev_err(&pdev->dev, "No NAND chips found\n");
-		goto err_gpio_busy;
+		goto err_iounmap_mmio;
 	}
 
 	if (pdata && pdata->ident_callback) {
@@ -533,9 +530,6 @@ err_unclaim_banks:
 					 nand->bank_base[bank - 1]);
 	}
 	writel(0, nand->base + JZ_REG_NAND_CTRL);
-err_gpio_busy:
-	if (pdata && gpio_is_valid(pdata->busy_gpio))
-		gpio_free(pdata->busy_gpio);
 err_iounmap_mmio:
 	jz_nand_iounmap_resource(nand->mem, nand->base);
 err_free:
@@ -546,7 +540,6 @@ err_free:
 static int jz_nand_remove(struct platform_device *pdev)
 {
 	struct jz_nand *nand = platform_get_drvdata(pdev);
-	struct jz_nand_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	size_t i;
 
 	nand_release(&nand->mtd);
@@ -562,8 +555,6 @@ static int jz_nand_remove(struct platform_device *pdev)
 			gpio_free(JZ_GPIO_MEM_CS0 + bank - 1);
 		}
 	}
-	if (pdata && gpio_is_valid(pdata->busy_gpio))
-		gpio_free(pdata->busy_gpio);
 
 	jz_nand_iounmap_resource(nand->mem, nand->base);
 
-- 
1.7.10.4
