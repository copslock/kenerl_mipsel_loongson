Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Apr 2015 16:20:18 +0200 (CEST)
Received: from smtp6-g21.free.fr ([212.27.42.6]:11766 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27026070AbbDXOUJkIfnP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 24 Apr 2015 16:20:09 +0200
Received: from localhost.localdomain (unknown [85.177.202.128])
        (Authenticated sender: albeu)
        by smtp6-g21.free.fr (Postfix) with ESMTPA id 88FE882298;
        Fri, 24 Apr 2015 16:17:36 +0200 (CEST)
From:   Alban Bedel <albeu@free.fr>
To:     linux-spi@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Mark Brown <broonie@kernel.org>, Alban Bedel <albeu@free.fr>,
        Gabor Juhos <juhosg@openwrt.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH 2/4] spi: spi-ath79: Add device tree support
Date:   Fri, 24 Apr 2015 16:19:22 +0200
Message-Id: <1429885164-28501-3-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1429885164-28501-1-git-send-email-albeu@free.fr>
References: <1429885164-28501-1-git-send-email-albeu@free.fr>
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47074
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

Set the OF node of the spi controller and use the generic GPIO based
chip select instead of the custom controller data. As the controller
data isn't used by any board just drop it.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 .../mips/include/asm/mach-ath79/ath79_spi_platform.h |  4 ----
 drivers/spi/spi-ath79.c                              | 20 +++++++++++---------
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/mips/include/asm/mach-ath79/ath79_spi_platform.h b/arch/mips/include/asm/mach-ath79/ath79_spi_platform.h
index aa2283e..aa71216 100644
--- a/arch/mips/include/asm/mach-ath79/ath79_spi_platform.h
+++ b/arch/mips/include/asm/mach-ath79/ath79_spi_platform.h
@@ -16,8 +16,4 @@ struct ath79_spi_platform_data {
 	unsigned	num_chipselect;
 };
 
-struct ath79_spi_controller_data {
-	unsigned	gpio;
-};
-
 #endif /* _ATH79_SPI_PLATFORM_H */
diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
index b02eb4a..239bc31 100644
--- a/drivers/spi/spi-ath79.c
+++ b/drivers/spi/spi-ath79.c
@@ -79,10 +79,8 @@ static void ath79_spi_chipselect(struct spi_device *spi, int is_active)
 	}
 
 	if (spi->chip_select) {
-		struct ath79_spi_controller_data *cdata = spi->controller_data;
-
 		/* SPI is normally active-low */
-		gpio_set_value(cdata->gpio, cs_high);
+		gpio_set_value(spi->cs_gpio, cs_high);
 	} else {
 		if (cs_high)
 			sp->ioc_base |= AR71XX_SPI_IOC_CS0;
@@ -117,11 +115,9 @@ static void ath79_spi_disable(struct ath79_spi *sp)
 
 static int ath79_spi_setup_cs(struct spi_device *spi)
 {
-	struct ath79_spi_controller_data *cdata;
 	int status;
 
-	cdata = spi->controller_data;
-	if (spi->chip_select && !cdata)
+	if (spi->chip_select && !gpio_is_valid(spi->cs_gpio))
 		return -EINVAL;
 
 	status = 0;
@@ -134,7 +130,7 @@ static int ath79_spi_setup_cs(struct spi_device *spi)
 		else
 			flags |= GPIOF_INIT_HIGH;
 
-		status = gpio_request_one(cdata->gpio, flags,
+		status = gpio_request_one(spi->cs_gpio, flags,
 					  dev_name(&spi->dev));
 	}
 
@@ -144,8 +140,7 @@ static int ath79_spi_setup_cs(struct spi_device *spi)
 static void ath79_spi_cleanup_cs(struct spi_device *spi)
 {
 	if (spi->chip_select) {
-		struct ath79_spi_controller_data *cdata = spi->controller_data;
-		gpio_free(cdata->gpio);
+		gpio_free(spi->cs_gpio);
 	}
 }
 
@@ -217,6 +212,7 @@ static int ath79_spi_probe(struct platform_device *pdev)
 	}
 
 	sp = spi_master_get_devdata(master);
+	master->dev.of_node = pdev->dev.of_node;
 	platform_set_drvdata(pdev, sp);
 
 	pdata = dev_get_platdata(&pdev->dev);
@@ -301,12 +297,18 @@ static void ath79_spi_shutdown(struct platform_device *pdev)
 	ath79_spi_remove(pdev);
 }
 
+static const struct of_device_id ath79_spi_of_match[] = {
+	{ .compatible = "qca,ar7100-spi", },
+	{ },
+};
+
 static struct platform_driver ath79_spi_driver = {
 	.probe		= ath79_spi_probe,
 	.remove		= ath79_spi_remove,
 	.shutdown	= ath79_spi_shutdown,
 	.driver		= {
 		.name	= DRV_NAME,
+		.of_match_table = ath79_spi_of_match,
 	},
 };
 module_platform_driver(ath79_spi_driver);
-- 
2.0.0
