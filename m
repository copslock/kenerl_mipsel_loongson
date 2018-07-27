Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jul 2018 14:06:19 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:43260 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992494AbeG0MFvaXn-s (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 27 Jul 2018 14:05:51 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 34F5120732; Fri, 27 Jul 2018 14:05:45 +0200 (CEST)
Received: from localhost (unknown [88.128.81.178])
        by mail.bootlin.com (Postfix) with ESMTPSA id F3A4820717;
        Fri, 27 Jul 2018 14:05:44 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Mark Brown <broonie@kernel.org>, James Hogan <jhogan@kernel.org>
Cc:     Paul Burton <paul.burton@mips.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 2/4] spi: dw-mmio: add MSCC Ocelot support
Date:   Fri, 27 Jul 2018 14:05:33 +0200
Message-Id: <20180727120535.16504-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727120535.16504-1-alexandre.belloni@bootlin.com>
References: <20180727120535.16504-1-alexandre.belloni@bootlin.com>
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65199
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@bootlin.com
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

Because the SPI controller deasserts the chip select when the TX fifo is
empty (which may happen in the middle of a transfer), the CS should be
handled by linux. Unfortunately, some or all of the first four chip
selects are not muxable as GPIOs, depending on the SoC.

There is a way to bitbang those pins by using the SPI boot controller so
use it to set the chip selects.

At init time, it is also necessary to give control of the SPI interface to
the Designware IP.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---

Change in v2:
 - correctly use device_get_match_data to retrieve the init function instead of
   hardcoding it.

 .../bindings/spi/snps,dw-apb-ssi.txt          |  5 +-
 drivers/spi/spi-dw-mmio.c                     | 91 +++++++++++++++++++
 2 files changed, 93 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
index d97b9fc4c1cb..204b311e0400 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
@@ -1,9 +1,8 @@
 Synopsys DesignWare AMBA 2.0 Synchronous Serial Interface.
 
 Required properties:
-- compatible : "snps,dw-apb-ssi" or "mscc,<soc>-spi"
-- reg : The register base for the controller. For "mscc,<soc>-spi", a second
-  register set is required (named ICPU_CFG:SPI_MST)
+- compatible : "snps,dw-apb-ssi"
+- reg : The register base for the controller.
 - interrupts : One interrupt, used by the controller.
 - #address-cells : <1>, as required by generic SPI binding.
 - #size-cells : <0>, also as required by generic SPI binding.
diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index d25cc4037e23..0bc47545c49c 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -15,11 +15,13 @@
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
 #include <linux/scatterlist.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_gpio.h>
 #include <linux/of_platform.h>
 #include <linux/property.h>
+#include <linux/regmap.h>
 
 #include "spi-dw.h"
 
@@ -28,10 +30,91 @@
 struct dw_spi_mmio {
 	struct dw_spi  dws;
 	struct clk     *clk;
+	void           *priv;
 };
 
+#define MSCC_CPU_SYSTEM_CTRL_GENERAL_CTRL	0x24
+#define OCELOT_IF_SI_OWNER_MASK			GENMASK(5, 4)
+#define OCELOT_IF_SI_OWNER_OFFSET		4
+#define MSCC_IF_SI_OWNER_SISL			0
+#define MSCC_IF_SI_OWNER_SIBM			1
+#define MSCC_IF_SI_OWNER_SIMC			2
+
+#define MSCC_SPI_MST_SW_MODE			0x14
+#define MSCC_SPI_MST_SW_MODE_SW_PIN_CTRL_MODE	BIT(13)
+#define MSCC_SPI_MST_SW_MODE_SW_SPI_CS(x)	(x << 5)
+struct dw_spi_mscc {
+	struct regmap       *syscon;
+	void __iomem        *spi_mst;
+};
+
+/*
+ * The SPI master controller automatically deasserts
+ * chip select when the tx fifo is empty. The chip selects then needs to be
+ * either driven as GPIOs or, for the first 4 using the the SPI boot controller
+ * registers. the final chip select is an OR gate between the SPI master
+ * controller and the SPI boot controller.
+ */
+static void dw_spi_mscc_set_cs(struct spi_device *spi, bool enable)
+{
+	struct dw_spi *dws = spi_master_get_devdata(spi->master);
+	struct dw_spi_mmio *dwsmmio = container_of(dws, struct dw_spi_mmio, dws);
+	struct dw_spi_mscc *dwsmscc = dwsmmio->priv;
+	u32 cs = spi->chip_select;
+
+	if (cs < 4) {
+		u32 sw_mode = MSCC_SPI_MST_SW_MODE_SW_PIN_CTRL_MODE;
+
+		if (!enable)
+			sw_mode |= MSCC_SPI_MST_SW_MODE_SW_SPI_CS(BIT(cs));
+
+		writel(sw_mode, dwsmscc->spi_mst + MSCC_SPI_MST_SW_MODE);
+	}
+
+	if (!enable)
+		dw_writel(dws, DW_SPI_SER, BIT(cs));
+}
+
+static int dw_spi_mscc_init(struct platform_device *pdev,
+			    struct dw_spi_mmio *dwsmmio)
+{
+	struct dw_spi_mscc *dwsmscc;
+	struct resource *res;
+
+	dwsmscc = devm_kzalloc(&pdev->dev, sizeof(struct dw_spi_mscc),
+			       GFP_KERNEL);
+	if (!dwsmscc)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	dwsmscc->spi_mst = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(dwsmscc->spi_mst)) {
+		dev_err(&pdev->dev, "SPI_MST region map failed\n");
+		return PTR_ERR(dwsmscc->spi_mst);
+	}
+
+	dwsmscc->syscon = syscon_regmap_lookup_by_compatible("mscc,ocelot-cpu-syscon");
+	if (IS_ERR(dwsmscc->syscon))
+		return PTR_ERR(dwsmscc->syscon);
+
+	/* Deassert all CS */
+	writel(0, dwsmscc->spi_mst + MSCC_SPI_MST_SW_MODE);
+
+	/* Select the owner of the SI interface */
+	regmap_update_bits(dwsmscc->syscon, MSCC_CPU_SYSTEM_CTRL_GENERAL_CTRL,
+			   OCELOT_IF_SI_OWNER_MASK,
+			   MSCC_IF_SI_OWNER_SIMC << OCELOT_IF_SI_OWNER_OFFSET);
+
+	dwsmmio->dws.set_cs = dw_spi_mscc_set_cs;
+	dwsmmio->priv = dwsmscc;
+
+	return 0;
+}
+
 static int dw_spi_mmio_probe(struct platform_device *pdev)
 {
+	int (*init_func)(struct platform_device *pdev,
+			 struct dw_spi_mmio *dwsmmio);
 	struct dw_spi_mmio *dwsmmio;
 	struct dw_spi *dws;
 	struct resource *mem;
@@ -99,6 +182,13 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 		}
 	}
 
+	init_func = device_get_match_data(&pdev->dev);
+	if (init_func) {
+		ret = init_func(pdev, dwsmmio);
+		if (ret)
+			goto out;
+	}
+
 	ret = dw_spi_add_host(&pdev->dev, dws);
 	if (ret)
 		goto out;
@@ -123,6 +213,7 @@ static int dw_spi_mmio_remove(struct platform_device *pdev)
 
 static const struct of_device_id dw_spi_mmio_of_match[] = {
 	{ .compatible = "snps,dw-apb-ssi", },
+	{ .compatible = "mscc,ocelot-spi", .data = dw_spi_mscc_init},
 	{ /* end of table */}
 };
 MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);
-- 
2.18.0
