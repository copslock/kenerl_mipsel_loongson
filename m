Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Aug 2018 18:10:05 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:54017 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994667AbeHQQJdpYvOq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Aug 2018 18:09:33 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B17CF20890; Fri, 17 Aug 2018 18:09:27 +0200 (CEST)
Received: from localhost.localdomain (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 73564207A3;
        Fri, 17 Aug 2018 18:09:26 +0200 (CEST)
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Lukasz Majewski <lukma@denx.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Alexander Clouter <alex@digriz.org.uk>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Han Xu <han.xu@nxp.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Xiaolei Li <xiaolei.li@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org,
        Wan ZongShun <mcuos.com@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>, Stefan Agner <stefan@agner.ch>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Subject: [PATCH 02/23] mtd: rawnand: Pass a nand_chip object to nand_scan() & co
Date:   Fri, 17 Aug 2018 18:09:01 +0200
Message-Id: <20180817160922.6224-3-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180817160922.6224-1-boris.brezillon@bootlin.com>
References: <20180817160922.6224-1-boris.brezillon@bootlin.com>
Return-Path: <boris.brezillon@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65610
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: boris.brezillon@bootlin.com
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

Let's make the raw NAND API consistent by patching all helpers to take
a nand_chip object instead of an mtd_info one.

We start with all variants of nand_scan().

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 Documentation/driver-api/mtdnand.rst             |  2 +-
 drivers/mtd/nand/raw/ams-delta.c                 |  2 +-
 drivers/mtd/nand/raw/atmel/nand-controller.c     |  2 +-
 drivers/mtd/nand/raw/au1550nd.c                  |  2 +-
 drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c |  2 +-
 drivers/mtd/nand/raw/brcmnand/brcmnand.c         |  2 +-
 drivers/mtd/nand/raw/cafe_nand.c                 |  2 +-
 drivers/mtd/nand/raw/cmx270_nand.c               |  2 +-
 drivers/mtd/nand/raw/cs553x_nand.c               |  2 +-
 drivers/mtd/nand/raw/davinci_nand.c              |  2 +-
 drivers/mtd/nand/raw/denali.c                    |  2 +-
 drivers/mtd/nand/raw/diskonchip.c                |  2 +-
 drivers/mtd/nand/raw/docg4.c                     |  2 +-
 drivers/mtd/nand/raw/fsl_elbc_nand.c             |  2 +-
 drivers/mtd/nand/raw/fsl_ifc_nand.c              |  2 +-
 drivers/mtd/nand/raw/fsl_upm.c                   |  2 +-
 drivers/mtd/nand/raw/fsmc_nand.c                 |  2 +-
 drivers/mtd/nand/raw/gpio.c                      |  2 +-
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c       |  2 +-
 drivers/mtd/nand/raw/hisi504_nand.c              |  2 +-
 drivers/mtd/nand/raw/jz4740_nand.c               |  2 +-
 drivers/mtd/nand/raw/jz4780_nand.c               |  2 +-
 drivers/mtd/nand/raw/lpc32xx_mlc.c               |  2 +-
 drivers/mtd/nand/raw/lpc32xx_slc.c               |  2 +-
 drivers/mtd/nand/raw/marvell_nand.c              |  2 +-
 drivers/mtd/nand/raw/mpc5121_nfc.c               |  2 +-
 drivers/mtd/nand/raw/mtk_nand.c                  |  2 +-
 drivers/mtd/nand/raw/mxc_nand.c                  |  2 +-
 drivers/mtd/nand/raw/nand_base.c                 | 21 ++++++++++-----------
 drivers/mtd/nand/raw/nandsim.c                   |  2 +-
 drivers/mtd/nand/raw/ndfc.c                      |  2 +-
 drivers/mtd/nand/raw/nuc900_nand.c               |  2 +-
 drivers/mtd/nand/raw/omap2.c                     |  2 +-
 drivers/mtd/nand/raw/orion_nand.c                |  2 +-
 drivers/mtd/nand/raw/oxnas_nand.c                |  2 +-
 drivers/mtd/nand/raw/pasemi_nand.c               |  2 +-
 drivers/mtd/nand/raw/plat_nand.c                 |  2 +-
 drivers/mtd/nand/raw/qcom_nandc.c                |  2 +-
 drivers/mtd/nand/raw/s3c2410.c                   |  2 +-
 drivers/mtd/nand/raw/sh_flctl.c                  |  2 +-
 drivers/mtd/nand/raw/sharpsl.c                   |  2 +-
 drivers/mtd/nand/raw/sm_common.c                 |  2 +-
 drivers/mtd/nand/raw/socrates_nand.c             |  2 +-
 drivers/mtd/nand/raw/sunxi_nand.c                |  2 +-
 drivers/mtd/nand/raw/tango_nand.c                |  2 +-
 drivers/mtd/nand/raw/tegra_nand.c                |  2 +-
 drivers/mtd/nand/raw/tmio_nand.c                 |  2 +-
 drivers/mtd/nand/raw/txx9ndfmc.c                 |  2 +-
 drivers/mtd/nand/raw/vf610_nfc.c                 |  2 +-
 drivers/mtd/nand/raw/xway_nand.c                 |  2 +-
 drivers/staging/mt29f_spinand/mt29f_spinand.c    |  2 +-
 include/linux/mtd/rawnand.h                      |  7 ++++---
 52 files changed, 64 insertions(+), 64 deletions(-)

diff --git a/Documentation/driver-api/mtdnand.rst b/Documentation/driver-api/mtdnand.rst
index dcd63599f700..b71cc42b3d6c 100644
--- a/Documentation/driver-api/mtdnand.rst
+++ b/Documentation/driver-api/mtdnand.rst
@@ -246,7 +246,7 @@ necessary information about the device.
         this->eccmode = NAND_ECC_SOFT;
 
         /* Scan to find existence of the device */
-        if (nand_scan (board_mtd, 1)) {
+        if (nand_scan (this, 1)) {
             err = -ENXIO;
             goto out_ior;
         }
diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index 37a3cc21c7bc..24ba7296ec08 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -235,7 +235,7 @@ static int ams_delta_init(struct platform_device *pdev)
 		goto out_gpio;
 
 	/* Scan to find existence of the device */
-	err = nand_scan(ams_delta_mtd, 1);
+	err = nand_scan(this, 1);
 	if (err)
 		goto out_mtd;
 
diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index 525e1325841d..fc1c1213cfed 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -1685,7 +1685,7 @@ atmel_nand_controller_add_nand(struct atmel_nand_controller *nc,
 
 	nc->caps->ops->nand_init(nc, nand);
 
-	ret = nand_scan(mtd, nand->numcs);
+	ret = nand_scan(chip, nand->numcs);
 	if (ret) {
 		dev_err(nc->dev, "NAND scan failed: %d\n", ret);
 		return ret;
diff --git a/drivers/mtd/nand/raw/au1550nd.c b/drivers/mtd/nand/raw/au1550nd.c
index 32c0440141fb..614f5d447ba5 100644
--- a/drivers/mtd/nand/raw/au1550nd.c
+++ b/drivers/mtd/nand/raw/au1550nd.c
@@ -451,7 +451,7 @@ static int au1550nd_probe(struct platform_device *pdev)
 	this->write_buf = (pd->devwidth) ? au_write_buf16 : au_write_buf;
 	this->read_buf = (pd->devwidth) ? au_read_buf16 : au_read_buf;
 
-	ret = nand_scan(mtd, 1);
+	ret = nand_scan(this, 1);
 	if (ret) {
 		dev_err(&pdev->dev, "NAND scan failed with %d\n", ret);
 		goto out3;
diff --git a/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c b/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c
index 60874de430eb..9b62bc2d25a0 100644
--- a/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c
+++ b/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c
@@ -423,7 +423,7 @@ int bcm47xxnflash_ops_bcm4706_init(struct bcm47xxnflash *b47n)
 			(w4 << 24 | w3 << 18 | w2 << 12 | w1 << 6 | w0));
 
 	/* Scan NAND */
-	err = nand_scan(nand_to_mtd(&b47n->nand_chip), 1);
+	err = nand_scan(&b47n->nand_chip, 1);
 	if (err) {
 		pr_err("Could not scan NAND flash: %d\n", err);
 		goto exit;
diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 4b90d5b380c2..a9a94c102654 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -2301,7 +2301,7 @@ static int brcmnand_init_cs(struct brcmnand_host *host, struct device_node *dn)
 	nand_writereg(ctrl, cfg_offs,
 		      nand_readreg(ctrl, cfg_offs) & ~CFG_BUS_WIDTH);
 
-	ret = nand_scan(mtd, 1);
+	ret = nand_scan(chip, 1);
 	if (ret)
 		return ret;
 
diff --git a/drivers/mtd/nand/raw/cafe_nand.c b/drivers/mtd/nand/raw/cafe_nand.c
index 1dbe43adcfe7..e497b95d624e 100644
--- a/drivers/mtd/nand/raw/cafe_nand.c
+++ b/drivers/mtd/nand/raw/cafe_nand.c
@@ -783,7 +783,7 @@ static int cafe_nand_probe(struct pci_dev *pdev,
 
 	/* Scan to find existence of the device */
 	cafe->nand.dummy_controller.ops = &cafe_nand_controller_ops;
-	err = nand_scan(mtd, 2);
+	err = nand_scan(&cafe->nand, 2);
 	if (err)
 		goto out_irq;
 
diff --git a/drivers/mtd/nand/raw/cmx270_nand.c b/drivers/mtd/nand/raw/cmx270_nand.c
index b66e254b6802..e92c0f113eb3 100644
--- a/drivers/mtd/nand/raw/cmx270_nand.c
+++ b/drivers/mtd/nand/raw/cmx270_nand.c
@@ -193,7 +193,7 @@ static int __init cmx270_init(void)
 	this->write_buf = cmx270_write_buf;
 
 	/* Scan to find existence of the device */
-	ret = nand_scan(cmx270_nand_mtd, 1);
+	ret = nand_scan(this, 1);
 	if (ret) {
 		pr_notice("No NAND device\n");
 		goto err_scan;
diff --git a/drivers/mtd/nand/raw/cs553x_nand.c b/drivers/mtd/nand/raw/cs553x_nand.c
index beafad62e7d5..4065bcd12e64 100644
--- a/drivers/mtd/nand/raw/cs553x_nand.c
+++ b/drivers/mtd/nand/raw/cs553x_nand.c
@@ -241,7 +241,7 @@ static int __init cs553x_init_one(int cs, int mmio, unsigned long adr)
 	}
 
 	/* Scan to find existence of the device */
-	err = nand_scan(new_mtd, 1);
+	err = nand_scan(this, 1);
 	if (err)
 		goto out_free;
 
diff --git a/drivers/mtd/nand/raw/davinci_nand.c b/drivers/mtd/nand/raw/davinci_nand.c
index 40145e206a6b..1021624195f7 100644
--- a/drivers/mtd/nand/raw/davinci_nand.c
+++ b/drivers/mtd/nand/raw/davinci_nand.c
@@ -807,7 +807,7 @@ static int nand_davinci_probe(struct platform_device *pdev)
 
 	/* Scan to find existence of the device(s) */
 	info->chip.dummy_controller.ops = &davinci_nand_controller_ops;
-	ret = nand_scan(mtd, pdata->mask_chipsel ? 2 : 1);
+	ret = nand_scan(&info->chip, pdata->mask_chipsel ? 2 : 1);
 	if (ret < 0) {
 		dev_dbg(&pdev->dev, "no NAND chip(s) found\n");
 		return ret;
diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index a031645a244d..9b51c519a2d2 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -1357,7 +1357,7 @@ int denali_init(struct denali_nand_info *denali)
 		chip->setup_data_interface = denali_setup_data_interface;
 
 	chip->dummy_controller.ops = &denali_controller_ops;
-	ret = nand_scan(mtd, denali->max_banks);
+	ret = nand_scan(chip, denali->max_banks);
 	if (ret)
 		goto disable_irq;
 
diff --git a/drivers/mtd/nand/raw/diskonchip.c b/drivers/mtd/nand/raw/diskonchip.c
index 3c46188dd6d2..9159748a2ef0 100644
--- a/drivers/mtd/nand/raw/diskonchip.c
+++ b/drivers/mtd/nand/raw/diskonchip.c
@@ -1620,7 +1620,7 @@ static int __init doc_probe(unsigned long physadr)
 	else
 		numchips = doc2001_init(mtd);
 
-	if ((ret = nand_scan(mtd, numchips)) || (ret = doc->late_init(mtd))) {
+	if ((ret = nand_scan(nand, numchips)) || (ret = doc->late_init(mtd))) {
 		/* DBB note: i believe nand_release is necessary here, as
 		   buffers may have been allocated in nand_base.  Check with
 		   Thomas. FIX ME! */
diff --git a/drivers/mtd/nand/raw/docg4.c b/drivers/mtd/nand/raw/docg4.c
index a3f04315c05c..8bd23be2f27d 100644
--- a/drivers/mtd/nand/raw/docg4.c
+++ b/drivers/mtd/nand/raw/docg4.c
@@ -1391,7 +1391,7 @@ static int __init probe_docg4(struct platform_device *pdev)
 	 * ->attach_chip callback.
 	 */
 	nand->dummy_controller.ops = &docg4_controller_ops;
-	retval = nand_scan(mtd, 0);
+	retval = nand_scan(nand, 0);
 	if (retval)
 		goto free_nand;
 
diff --git a/drivers/mtd/nand/raw/fsl_elbc_nand.c b/drivers/mtd/nand/raw/fsl_elbc_nand.c
index 55f449b711fd..541343d142e0 100644
--- a/drivers/mtd/nand/raw/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/raw/fsl_elbc_nand.c
@@ -915,7 +915,7 @@ static int fsl_elbc_nand_probe(struct platform_device *pdev)
 		goto err;
 
 	priv->chip.controller->ops = &fsl_elbc_controller_ops;
-	ret = nand_scan(mtd, 1);
+	ret = nand_scan(&priv->chip, 1);
 	if (ret)
 		goto err;
 
diff --git a/drivers/mtd/nand/raw/fsl_ifc_nand.c b/drivers/mtd/nand/raw/fsl_ifc_nand.c
index 24f59d0066af..006d7922c31c 100644
--- a/drivers/mtd/nand/raw/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/raw/fsl_ifc_nand.c
@@ -1051,7 +1051,7 @@ static int fsl_ifc_nand_probe(struct platform_device *dev)
 		goto err;
 
 	priv->chip.controller->ops = &fsl_ifc_controller_ops;
-	ret = nand_scan(mtd, 1);
+	ret = nand_scan(&priv->chip, 1);
 	if (ret)
 		goto err;
 
diff --git a/drivers/mtd/nand/raw/fsl_upm.c b/drivers/mtd/nand/raw/fsl_upm.c
index a88e2cf66e0f..b45c9940f9c0 100644
--- a/drivers/mtd/nand/raw/fsl_upm.c
+++ b/drivers/mtd/nand/raw/fsl_upm.c
@@ -191,7 +191,7 @@ static int fun_chip_init(struct fsl_upm_nand *fun,
 		goto err;
 	}
 
-	ret = nand_scan(mtd, fun->mchip_count);
+	ret = nand_scan(&fun->chip, fun->mchip_count);
 	if (ret)
 		goto err;
 
diff --git a/drivers/mtd/nand/raw/fsmc_nand.c b/drivers/mtd/nand/raw/fsmc_nand.c
index f418236fa020..9991e3b8e237 100644
--- a/drivers/mtd/nand/raw/fsmc_nand.c
+++ b/drivers/mtd/nand/raw/fsmc_nand.c
@@ -1125,7 +1125,7 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
 	 * Scan to find existence of the device
 	 */
 	nand->dummy_controller.ops = &fsmc_nand_controller_ops;
-	ret = nand_scan(mtd, 1);
+	ret = nand_scan(nand, 1);
 	if (ret)
 		goto release_dma_write_chan;
 
diff --git a/drivers/mtd/nand/raw/gpio.c b/drivers/mtd/nand/raw/gpio.c
index 2780af26d9ab..983d3be48019 100644
--- a/drivers/mtd/nand/raw/gpio.c
+++ b/drivers/mtd/nand/raw/gpio.c
@@ -289,7 +289,7 @@ static int gpio_nand_probe(struct platform_device *pdev)
 	if (gpiomtd->nwp && !IS_ERR(gpiomtd->nwp))
 		gpiod_direction_output(gpiomtd->nwp, 1);
 
-	ret = nand_scan(mtd, 1);
+	ret = nand_scan(chip, 1);
 	if (ret)
 		goto err_wp;
 
diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
index 1c1ebbc82824..7af207bc3ab5 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -1934,7 +1934,7 @@ static int gpmi_nand_init(struct gpmi_nand_data *this)
 		goto err_out;
 
 	chip->dummy_controller.ops = &gpmi_nand_controller_ops;
-	ret = nand_scan(mtd, GPMI_IS_MX6(this) ? 2 : 1);
+	ret = nand_scan(chip, GPMI_IS_MX6(this) ? 2 : 1);
 	if (ret)
 		goto err_out;
 
diff --git a/drivers/mtd/nand/raw/hisi504_nand.c b/drivers/mtd/nand/raw/hisi504_nand.c
index 0f5c48aa5673..81baa2e6ae56 100644
--- a/drivers/mtd/nand/raw/hisi504_nand.c
+++ b/drivers/mtd/nand/raw/hisi504_nand.c
@@ -801,7 +801,7 @@ static int hisi_nfc_probe(struct platform_device *pdev)
 	}
 
 	chip->dummy_controller.ops = &hisi_nfc_controller_ops;
-	ret = nand_scan(mtd, max_chips);
+	ret = nand_scan(chip, max_chips);
 	if (ret)
 		return ret;
 
diff --git a/drivers/mtd/nand/raw/jz4740_nand.c b/drivers/mtd/nand/raw/jz4740_nand.c
index a7515452bc59..75bb26645c82 100644
--- a/drivers/mtd/nand/raw/jz4740_nand.c
+++ b/drivers/mtd/nand/raw/jz4740_nand.c
@@ -331,7 +331,7 @@ static int jz_nand_detect_bank(struct platform_device *pdev,
 
 	if (chipnr == 0) {
 		/* Detect first chip. */
-		ret = nand_scan(mtd, 1);
+		ret = nand_scan(chip, 1);
 		if (ret)
 			goto notfound_id;
 
diff --git a/drivers/mtd/nand/raw/jz4780_nand.c b/drivers/mtd/nand/raw/jz4780_nand.c
index db4fa60bd52a..2122a7f3c484 100644
--- a/drivers/mtd/nand/raw/jz4780_nand.c
+++ b/drivers/mtd/nand/raw/jz4780_nand.c
@@ -286,7 +286,7 @@ static int jz4780_nand_init_chip(struct platform_device *pdev,
 	nand_set_flash_node(chip, np);
 
 	chip->controller->ops = &jz4780_nand_controller_ops;
-	ret = nand_scan(mtd, 1);
+	ret = nand_scan(chip, 1);
 	if (ret)
 		return ret;
 
diff --git a/drivers/mtd/nand/raw/lpc32xx_mlc.c b/drivers/mtd/nand/raw/lpc32xx_mlc.c
index e82abada130a..453a83b82d73 100644
--- a/drivers/mtd/nand/raw/lpc32xx_mlc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_mlc.c
@@ -802,7 +802,7 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 	 * SMALL block or LARGE block.
 	 */
 	nand_chip->dummy_controller.ops = &lpc32xx_nand_controller_ops;
-	res = nand_scan(mtd, 1);
+	res = nand_scan(nand_chip, 1);
 	if (res)
 		goto free_irq;
 
diff --git a/drivers/mtd/nand/raw/lpc32xx_slc.c b/drivers/mtd/nand/raw/lpc32xx_slc.c
index a4e8b7e75135..ad6eff0591d2 100644
--- a/drivers/mtd/nand/raw/lpc32xx_slc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_slc.c
@@ -925,7 +925,7 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 
 	/* Find NAND device */
 	chip->dummy_controller.ops = &lpc32xx_nand_controller_ops;
-	res = nand_scan(mtd, 1);
+	res = nand_scan(chip, 1);
 	if (res)
 		goto release_dma;
 
diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
index 218e09431d3d..39c9eadd2c77 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -2538,7 +2538,7 @@ static int marvell_nand_chip_init(struct device *dev, struct marvell_nfc *nfc,
 
 	chip->options |= NAND_BUSWIDTH_AUTO;
 
-	ret = nand_scan(mtd, marvell_nand->nsels);
+	ret = nand_scan(chip, marvell_nand->nsels);
 	if (ret) {
 		dev_err(dev, "could not scan the nand chip\n");
 		return ret;
diff --git a/drivers/mtd/nand/raw/mpc5121_nfc.c b/drivers/mtd/nand/raw/mpc5121_nfc.c
index c0be9c30b4cf..efaaec462bd7 100644
--- a/drivers/mtd/nand/raw/mpc5121_nfc.c
+++ b/drivers/mtd/nand/raw/mpc5121_nfc.c
@@ -767,7 +767,7 @@ static int mpc5121_nfc_probe(struct platform_device *op)
 	}
 
 	/* Detect NAND chips */
-	retval = nand_scan(mtd, be32_to_cpup(chips_no));
+	retval = nand_scan(chip, be32_to_cpup(chips_no));
 	if (retval) {
 		dev_err(dev, "NAND Flash not found !\n");
 		goto error;
diff --git a/drivers/mtd/nand/raw/mtk_nand.c b/drivers/mtd/nand/raw/mtk_nand.c
index 57b5ed1699e3..7a2ce405f914 100644
--- a/drivers/mtd/nand/raw/mtk_nand.c
+++ b/drivers/mtd/nand/raw/mtk_nand.c
@@ -1365,7 +1365,7 @@ static int mtk_nfc_nand_chip_init(struct device *dev, struct mtk_nfc *nfc,
 
 	mtk_nfc_hw_init(nfc);
 
-	ret = nand_scan(mtd, nsels);
+	ret = nand_scan(nand, nsels);
 	if (ret)
 		return ret;
 
diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_nand.c
index a0884a621053..1ca03d88adf1 100644
--- a/drivers/mtd/nand/raw/mxc_nand.c
+++ b/drivers/mtd/nand/raw/mxc_nand.c
@@ -1887,7 +1887,7 @@ static int mxcnd_probe(struct platform_device *pdev)
 
 	/* Scan the NAND device */
 	this->dummy_controller.ops = &mxcnd_controller_ops;
-	err = nand_scan(mtd, is_imx25_nfc(host) ? 4 : 1);
+	err = nand_scan(this, is_imx25_nfc(host) ? 4 : 1);
 	if (err)
 		goto escan;
 
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 306ef6ec41db..974cbfbde5e2 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -5960,7 +5960,7 @@ static int nand_dt_init(struct nand_chip *chip)
 
 /**
  * nand_scan_ident - Scan for the NAND device
- * @mtd: MTD device structure
+ * @chip: NAND chip object
  * @maxchips: number of chips to scan for
  * @table: alternative NAND ID table
  *
@@ -5972,11 +5972,11 @@ static int nand_dt_init(struct nand_chip *chip)
  * prevented dynamic allocations during this phase which was unconvenient and
  * as been banned for the benefit of the ->init_ecc()/cleanup_ecc() hooks.
  */
-static int nand_scan_ident(struct mtd_info *mtd, int maxchips,
+static int nand_scan_ident(struct nand_chip *chip, int maxchips,
 			   struct nand_flash_dev *table)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	int i, nand_maf_id, nand_dev_id;
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	int ret;
 
 	/* Enforce the right timings for reset/detection */
@@ -6430,15 +6430,15 @@ static bool nand_ecc_strength_good(struct mtd_info *mtd)
 
 /**
  * nand_scan_tail - Scan for the NAND device
- * @mtd: MTD device structure
+ * @chip: NAND chip object
  *
  * This is the second phase of the normal nand_scan() function. It fills out
  * all the uninitialized function pointers with the defaults and scans for a
  * bad block table if appropriate.
  */
-static int nand_scan_tail(struct mtd_info *mtd)
+static int nand_scan_tail(struct nand_chip *chip)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	int ret, i;
 
@@ -6777,7 +6777,7 @@ static void nand_detach(struct nand_chip *chip)
 
 /**
  * nand_scan_with_ids - [NAND Interface] Scan for the NAND device
- * @mtd: MTD device structure
+ * @chip: NAND chip object
  * @maxchips: number of chips to scan for. @nand_scan_ident() will not be run if
  *	      this parameter is zero (useful for specific drivers that must
  *	      handle this part of the process themselves, e.g docg4).
@@ -6787,14 +6787,13 @@ static void nand_detach(struct nand_chip *chip)
  * The flash ID is read and the mtd/chip structures are filled with the
  * appropriate values.
  */
-int nand_scan_with_ids(struct mtd_info *mtd, int maxchips,
+int nand_scan_with_ids(struct nand_chip *chip, int maxchips,
 		       struct nand_flash_dev *ids)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	int ret;
 
 	if (maxchips) {
-		ret = nand_scan_ident(mtd, maxchips, ids);
+		ret = nand_scan_ident(chip, maxchips, ids);
 		if (ret)
 			return ret;
 	}
@@ -6803,7 +6802,7 @@ int nand_scan_with_ids(struct mtd_info *mtd, int maxchips,
 	if (ret)
 		goto cleanup_ident;
 
-	ret = nand_scan_tail(mtd);
+	ret = nand_scan_tail(chip);
 	if (ret)
 		goto detach_chip;
 
diff --git a/drivers/mtd/nand/raw/nandsim.c b/drivers/mtd/nand/raw/nandsim.c
index 47a81d1b1397..60761175e531 100644
--- a/drivers/mtd/nand/raw/nandsim.c
+++ b/drivers/mtd/nand/raw/nandsim.c
@@ -2309,7 +2309,7 @@ static int __init ns_init_module(void)
 		goto error;
 
 	chip->dummy_controller.ops = &ns_controller_ops;
-	retval = nand_scan(nsmtd, 1);
+	retval = nand_scan(chip, 1);
 	if (retval) {
 		NS_ERR("Could not scan NAND Simulator device\n");
 		goto error;
diff --git a/drivers/mtd/nand/raw/ndfc.c b/drivers/mtd/nand/raw/ndfc.c
index 540fa1a0ea24..cfe31c78482a 100644
--- a/drivers/mtd/nand/raw/ndfc.c
+++ b/drivers/mtd/nand/raw/ndfc.c
@@ -181,7 +181,7 @@ static int ndfc_chip_init(struct ndfc_controller *ndfc,
 		goto err;
 	}
 
-	ret = nand_scan(mtd, 1);
+	ret = nand_scan(chip, 1);
 	if (ret)
 		goto err;
 
diff --git a/drivers/mtd/nand/raw/nuc900_nand.c b/drivers/mtd/nand/raw/nuc900_nand.c
index af5b32c9a791..41ed993b9523 100644
--- a/drivers/mtd/nand/raw/nuc900_nand.c
+++ b/drivers/mtd/nand/raw/nuc900_nand.c
@@ -270,7 +270,7 @@ static int nuc900_nand_probe(struct platform_device *pdev)
 
 	nuc900_nand_enable(nuc900_nand);
 
-	if (nand_scan(mtd, 1))
+	if (nand_scan(chip, 1))
 		return -ENXIO;
 
 	mtd_device_register(mtd, partitions, ARRAY_SIZE(partitions));
diff --git a/drivers/mtd/nand/raw/omap2.c b/drivers/mtd/nand/raw/omap2.c
index 4546ac0bed4a..c2aff2492fa1 100644
--- a/drivers/mtd/nand/raw/omap2.c
+++ b/drivers/mtd/nand/raw/omap2.c
@@ -2254,7 +2254,7 @@ static int omap_nand_probe(struct platform_device *pdev)
 	/* scan NAND device connected to chip controller */
 	nand_chip->options |= info->devsize & NAND_BUSWIDTH_16;
 
-	err = nand_scan(mtd, 1);
+	err = nand_scan(nand_chip, 1);
 	if (err)
 		goto return_error;
 
diff --git a/drivers/mtd/nand/raw/orion_nand.c b/drivers/mtd/nand/raw/orion_nand.c
index 52d435285a3f..256a6b018bdc 100644
--- a/drivers/mtd/nand/raw/orion_nand.c
+++ b/drivers/mtd/nand/raw/orion_nand.c
@@ -174,7 +174,7 @@ static int __init orion_nand_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = nand_scan(mtd, 1);
+	ret = nand_scan(nc, 1);
 	if (ret)
 		goto no_dev;
 
diff --git a/drivers/mtd/nand/raw/oxnas_nand.c b/drivers/mtd/nand/raw/oxnas_nand.c
index 01b00bb69c1e..9aeb024c2a0e 100644
--- a/drivers/mtd/nand/raw/oxnas_nand.c
+++ b/drivers/mtd/nand/raw/oxnas_nand.c
@@ -142,7 +142,7 @@ static int oxnas_nand_probe(struct platform_device *pdev)
 		chip->chip_delay = 30;
 
 		/* Scan to find existence of the device */
-		err = nand_scan(mtd, 1);
+		err = nand_scan(chip, 1);
 		if (err)
 			goto err_clk_unprepare;
 
diff --git a/drivers/mtd/nand/raw/pasemi_nand.c b/drivers/mtd/nand/raw/pasemi_nand.c
index a47a7e4bd25a..eca4e41d2be3 100644
--- a/drivers/mtd/nand/raw/pasemi_nand.c
+++ b/drivers/mtd/nand/raw/pasemi_nand.c
@@ -156,7 +156,7 @@ static int pasemi_nand_probe(struct platform_device *ofdev)
 	chip->bbt_options = NAND_BBT_USE_FLASH;
 
 	/* Scan to find existence of the device */
-	err = nand_scan(pasemi_nand_mtd, 1);
+	err = nand_scan(chip, 1);
 	if (err)
 		goto out_lpc;
 
diff --git a/drivers/mtd/nand/raw/plat_nand.c b/drivers/mtd/nand/raw/plat_nand.c
index 24f904300c44..c9a23fb21718 100644
--- a/drivers/mtd/nand/raw/plat_nand.c
+++ b/drivers/mtd/nand/raw/plat_nand.c
@@ -131,7 +131,7 @@ static int plat_nand_probe(struct platform_device *pdev)
 	}
 
 	/* Scan to find existence of the device */
-	err = nand_scan(mtd, pdata->chip.nr_chips);
+	err = nand_scan(&data->chip, pdata->chip.nr_chips);
 	if (err)
 		goto out;
 
diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index d1d470bb32e4..390424b57037 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -2835,7 +2835,7 @@ static int qcom_nand_host_init_and_register(struct qcom_nand_controller *nandc,
 	/* set up initial status value */
 	host->status = NAND_STATUS_READY | NAND_STATUS_WP;
 
-	ret = nand_scan(mtd, 1);
+	ret = nand_scan(chip, 1);
 	if (ret)
 		return ret;
 
diff --git a/drivers/mtd/nand/raw/s3c2410.c b/drivers/mtd/nand/raw/s3c2410.c
index c21e8892394a..7f30d801d642 100644
--- a/drivers/mtd/nand/raw/s3c2410.c
+++ b/drivers/mtd/nand/raw/s3c2410.c
@@ -1170,7 +1170,7 @@ static int s3c24xx_nand_probe(struct platform_device *pdev)
 		mtd->dev.parent = &pdev->dev;
 		s3c2410_nand_init_chip(info, nmtd, sets);
 
-		err = nand_scan(mtd, sets ? sets->nr_chips : 1);
+		err = nand_scan(&nmtd->chip, sets ? sets->nr_chips : 1);
 		if (err)
 			goto exit_error;
 
diff --git a/drivers/mtd/nand/raw/sh_flctl.c b/drivers/mtd/nand/raw/sh_flctl.c
index ef3036d9bf15..abcc3be89b89 100644
--- a/drivers/mtd/nand/raw/sh_flctl.c
+++ b/drivers/mtd/nand/raw/sh_flctl.c
@@ -1193,7 +1193,7 @@ static int flctl_probe(struct platform_device *pdev)
 	flctl_setup_dma(flctl);
 
 	nand->dummy_controller.ops = &flctl_nand_controller_ops;
-	ret = nand_scan(flctl_mtd, 1);
+	ret = nand_scan(nand, 1);
 	if (ret)
 		goto err_chip;
 
diff --git a/drivers/mtd/nand/raw/sharpsl.c b/drivers/mtd/nand/raw/sharpsl.c
index fc171b17a39b..4afacb0dcf00 100644
--- a/drivers/mtd/nand/raw/sharpsl.c
+++ b/drivers/mtd/nand/raw/sharpsl.c
@@ -171,7 +171,7 @@ static int sharpsl_nand_probe(struct platform_device *pdev)
 	this->ecc.correct = nand_correct_data;
 
 	/* Scan to find existence of the device */
-	err = nand_scan(mtd, 1);
+	err = nand_scan(this, 1);
 	if (err)
 		goto err_scan;
 
diff --git a/drivers/mtd/nand/raw/sm_common.c b/drivers/mtd/nand/raw/sm_common.c
index 73aafe8c3ef3..02ac6e9b2d16 100644
--- a/drivers/mtd/nand/raw/sm_common.c
+++ b/drivers/mtd/nand/raw/sm_common.c
@@ -195,7 +195,7 @@ int sm_register_device(struct mtd_info *mtd, int smartmedia)
 	/* Scan for card properties */
 	chip->dummy_controller.ops = &sm_controller_ops;
 	flash_ids = smartmedia ? nand_smartmedia_flash_ids : nand_xd_flash_ids;
-	ret = nand_scan_with_ids(mtd, 1, flash_ids);
+	ret = nand_scan_with_ids(chip, 1, flash_ids);
 	if (ret)
 		return ret;
 
diff --git a/drivers/mtd/nand/raw/socrates_nand.c b/drivers/mtd/nand/raw/socrates_nand.c
index 36c45aa21f66..e335560f87af 100644
--- a/drivers/mtd/nand/raw/socrates_nand.c
+++ b/drivers/mtd/nand/raw/socrates_nand.c
@@ -173,7 +173,7 @@ static int socrates_nand_probe(struct platform_device *ofdev)
 
 	dev_set_drvdata(&ofdev->dev, host);
 
-	res = nand_scan(mtd, 1);
+	res = nand_scan(nand_chip, 1);
 	if (res)
 		goto out;
 
diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 1f0b7ee38df5..179f74b6edf6 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -1940,7 +1940,7 @@ static int sunxi_nand_chip_init(struct device *dev, struct sunxi_nfc *nfc,
 	mtd = nand_to_mtd(nand);
 	mtd->dev.parent = dev;
 
-	ret = nand_scan(mtd, nsels);
+	ret = nand_scan(nand, nsels);
 	if (ret)
 		return ret;
 
diff --git a/drivers/mtd/nand/raw/tango_nand.c b/drivers/mtd/nand/raw/tango_nand.c
index 72698691727d..45beb87aec93 100644
--- a/drivers/mtd/nand/raw/tango_nand.c
+++ b/drivers/mtd/nand/raw/tango_nand.c
@@ -588,7 +588,7 @@ static int chip_init(struct device *dev, struct device_node *np)
 	mtd_set_ooblayout(mtd, &tango_nand_ooblayout_ops);
 	mtd->dev.parent = dev;
 
-	err = nand_scan(mtd, 1);
+	err = nand_scan(chip, 1);
 	if (err)
 		return err;
 
diff --git a/drivers/mtd/nand/raw/tegra_nand.c b/drivers/mtd/nand/raw/tegra_nand.c
index 79da1efc88d1..5dcee20e2a8c 100644
--- a/drivers/mtd/nand/raw/tegra_nand.c
+++ b/drivers/mtd/nand/raw/tegra_nand.c
@@ -1119,7 +1119,7 @@ static int tegra_nand_chips_init(struct device *dev,
 	chip->select_chip = tegra_nand_select_chip;
 	chip->setup_data_interface = tegra_nand_setup_data_interface;
 
-	ret = nand_scan(mtd, 1);
+	ret = nand_scan(chip, 1);
 	if (ret)
 		return ret;
 
diff --git a/drivers/mtd/nand/raw/tmio_nand.c b/drivers/mtd/nand/raw/tmio_nand.c
index dcaa924502de..6df499a239ae 100644
--- a/drivers/mtd/nand/raw/tmio_nand.c
+++ b/drivers/mtd/nand/raw/tmio_nand.c
@@ -436,7 +436,7 @@ static int tmio_probe(struct platform_device *dev)
 	nand_chip->waitfunc = tmio_nand_wait;
 
 	/* Scan to find existence of the device */
-	retval = nand_scan(mtd, 1);
+	retval = nand_scan(nand_chip, 1);
 	if (retval)
 		goto err_irq;
 
diff --git a/drivers/mtd/nand/raw/txx9ndfmc.c b/drivers/mtd/nand/raw/txx9ndfmc.c
index 4d61a14fcb65..169e8bcee61e 100644
--- a/drivers/mtd/nand/raw/txx9ndfmc.c
+++ b/drivers/mtd/nand/raw/txx9ndfmc.c
@@ -359,7 +359,7 @@ static int __init txx9ndfmc_probe(struct platform_device *dev)
 		if (plat->wide_mask & (1 << i))
 			chip->options |= NAND_BUSWIDTH_16;
 
-		if (nand_scan(mtd, 1)) {
+		if (nand_scan(chip, 1)) {
 			kfree(txx9_priv->mtdname);
 			kfree(txx9_priv);
 			continue;
diff --git a/drivers/mtd/nand/raw/vf610_nfc.c b/drivers/mtd/nand/raw/vf610_nfc.c
index 6f6dcbf9095b..3b486f4ce868 100644
--- a/drivers/mtd/nand/raw/vf610_nfc.c
+++ b/drivers/mtd/nand/raw/vf610_nfc.c
@@ -892,7 +892,7 @@ static int vf610_nfc_probe(struct platform_device *pdev)
 
 	/* Scan the NAND chip */
 	chip->dummy_controller.ops = &vf610_nfc_controller_ops;
-	err = nand_scan(mtd, 1);
+	err = nand_scan(chip, 1);
 	if (err)
 		goto err_disable_clk;
 
diff --git a/drivers/mtd/nand/raw/xway_nand.c b/drivers/mtd/nand/raw/xway_nand.c
index 9926b4e3d69d..e670d3b5a646 100644
--- a/drivers/mtd/nand/raw/xway_nand.c
+++ b/drivers/mtd/nand/raw/xway_nand.c
@@ -205,7 +205,7 @@ static int xway_nand_probe(struct platform_device *pdev)
 		    | cs_flag, EBU_NAND_CON);
 
 	/* Scan to find existence of the device */
-	err = nand_scan(mtd, 1);
+	err = nand_scan(&data->chip, 1);
 	if (err)
 		return err;
 
diff --git a/drivers/staging/mt29f_spinand/mt29f_spinand.c b/drivers/staging/mt29f_spinand/mt29f_spinand.c
index 448478451c4c..b50788b2d1d9 100644
--- a/drivers/staging/mt29f_spinand/mt29f_spinand.c
+++ b/drivers/staging/mt29f_spinand/mt29f_spinand.c
@@ -934,7 +934,7 @@ static int spinand_probe(struct spi_device *spi_nand)
 	mtd_set_ooblayout(mtd, &spinand_oob_64_ops);
 #endif
 
-	if (nand_scan(mtd, 1))
+	if (nand_scan(chip, 1))
 		return -ENXIO;
 
 	return mtd_device_register(mtd, NULL, 0);
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 818cdc0a4dbb..733b228d94a5 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -24,15 +24,16 @@
 #include <linux/of.h>
 #include <linux/types.h>
 
+struct nand_chip;
 struct nand_flash_dev;
 
 /* Scan and identify a NAND device */
-int nand_scan_with_ids(struct mtd_info *mtd, int max_chips,
+int nand_scan_with_ids(struct nand_chip *chip, int max_chips,
 		       struct nand_flash_dev *ids);
 
-static inline int nand_scan(struct mtd_info *mtd, int max_chips)
+static inline int nand_scan(struct nand_chip *chip, int max_chips)
 {
-	return nand_scan_with_ids(mtd, max_chips, NULL);
+	return nand_scan_with_ids(chip, max_chips, NULL);
 }
 
 /* Internal helper for board drivers which need to override command function */
-- 
2.14.1
