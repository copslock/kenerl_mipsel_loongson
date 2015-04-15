Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Apr 2015 17:44:10 +0200 (CEST)
Received: from kiutl.biot.com ([31.172.244.210]:39035 "EHLO kiutl.biot.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27025200AbbDOPoJUbpKc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Apr 2015 17:44:09 +0200
Received: from spamd by kiutl.biot.com with sa-checked (Exim 4.83)
        (envelope-from <bert@biot.com>)
        id 1YiPU2-0000Sb-3p
        for linux-mips@linux-mips.org; Wed, 15 Apr 2015 17:44:10 +0200
Received: from [2a02:578:4a04:2a00::5] (helo=sumner.biot.com)
        by kiutl.biot.com with esmtps (TLSv1.2:DHE-RSA-AES128-SHA:128)
        (Exim 4.83)
        (envelope-from <bert@biot.com>)
        id 1YiPTv-0000S5-VA; Wed, 15 Apr 2015 17:44:04 +0200
Received: from bert by sumner.biot.com with local (Exim 4.82)
        (envelope-from <bert@biot.com>)
        id 1YiPTu-0008NK-OM; Wed, 15 Apr 2015 17:44:02 +0200
From:   Bert Vermeulen <bert@biot.com>
To:     ralf@linux-mips.org, broonie@kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        andy.shevchenko@gmail.com, jogo@openwrt.org
Cc:     Bert Vermeulen <bert@biot.com>
Subject: [PATCH v7] spi: Add SPI driver for Mikrotik RB4xx series boards
Date:   Wed, 15 Apr 2015 17:43:52 +0200
Message-Id: <1429112632-32153-1-git-send-email-bert@biot.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <bert@biot.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46867
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bert@biot.com
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

This driver mediates access between the connected CPLD and other devices
on the bus.

The m25p80-compatible boot flash and (some models) MMC use regular SPI,
bitbanged as required by the SoC. However the SPI-connected CPLD has
a two-wire mode, in which two bits are transferred per SPI clock
cycle. The second bit is transmitted with the SoC's CS2 pin.

Signed-off-by: Bert Vermeulen <bert@biot.com>
---
Changes in v7:
- use SPI_TX_DUAL/tx_nbits to signal two-wire mode
- use SPI_MASTER_MUST_TX for dummy writes
- use bits_per_word_mask to restrict word size
- properly disable/unprepare clock on module removal
- code cleanup
Changes in v6:
- removed unnecessary SPI mode check
- whitespace fixes


 drivers/spi/Kconfig     |   6 ++
 drivers/spi/Makefile    |   1 +
 drivers/spi/spi-rb4xx.c | 210 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 217 insertions(+)
 create mode 100644 drivers/spi/spi-rb4xx.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index ab8dfbe..8b1beaf6 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -429,6 +429,12 @@ config SPI_ROCKCHIP
 	  The main usecase of this controller is to use spi flash as boot
 	  device.
 
+config SPI_RB4XX
+	tristate "Mikrotik RB4XX SPI master"
+	depends on SPI_MASTER && ATH79
+	help
+	  SPI controller driver for the Mikrotik RB4xx series boards.
+
 config SPI_RSPI
 	tristate "Renesas RSPI/QSPI controller"
 	depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index d8cbf65..0218f39 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -66,6 +66,7 @@ obj-$(CONFIG_SPI_PXA2XX)		+= spi-pxa2xx-platform.o
 obj-$(CONFIG_SPI_PXA2XX_PCI)		+= spi-pxa2xx-pci.o
 obj-$(CONFIG_SPI_QUP)			+= spi-qup.o
 obj-$(CONFIG_SPI_ROCKCHIP)		+= spi-rockchip.o
+obj-$(CONFIG_SPI_RB4XX)			+= spi-rb4xx.o
 obj-$(CONFIG_SPI_RSPI)			+= spi-rspi.o
 obj-$(CONFIG_SPI_S3C24XX)		+= spi-s3c24xx-hw.o
 spi-s3c24xx-hw-y			:= spi-s3c24xx.o
diff --git a/drivers/spi/spi-rb4xx.c b/drivers/spi/spi-rb4xx.c
new file mode 100644
index 0000000..9b449d4
--- /dev/null
+++ b/drivers/spi/spi-rb4xx.c
@@ -0,0 +1,210 @@
+/*
+ * SPI controller driver for the Mikrotik RB4xx boards
+ *
+ * Copyright (C) 2010 Gabor Juhos <juhosg@openwrt.org>
+ * Copyright (C) 2015 Bert Vermeulen <bert@biot.com>
+ *
+ * This file was based on the patches for Linux 2.6.27.39 published by
+ * MikroTik for their RouterBoard 4xx series devices.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/spi/spi.h>
+
+#include <asm/mach-ath79/ar71xx_regs.h>
+
+struct rb4xx_spi {
+	void __iomem *base;
+	struct clk *clk;
+};
+
+static inline u32 rb4xx_read(struct rb4xx_spi *rbspi, u32 reg)
+{
+	return __raw_readl(rbspi->base + reg);
+}
+
+static inline void rb4xx_write(struct rb4xx_spi *rbspi, u32 reg, u32 value)
+{
+	__raw_writel(value, rbspi->base + reg);
+}
+
+static inline void do_spi_clk(struct rb4xx_spi *rbspi, u32 spi_ioc, int value)
+{
+	u32 regval;
+
+	regval = spi_ioc;
+	if (value & BIT(0))
+		regval |= AR71XX_SPI_IOC_DO;
+
+	rb4xx_write(rbspi, AR71XX_SPI_REG_IOC, regval);
+	rb4xx_write(rbspi, AR71XX_SPI_REG_IOC, regval | AR71XX_SPI_IOC_CLK);
+}
+
+static void do_spi_byte(struct rb4xx_spi *rbspi, u32 spi_ioc, u8 byte)
+{
+	int i;
+
+	for (i = 7; i >= 0; i--)
+		do_spi_clk(rbspi, spi_ioc, byte >> i);
+}
+
+/* The CS2 pin is used to clock in a second bit per clock cycle. */
+static inline void do_spi_clk_two(struct rb4xx_spi *rbspi, u32 spi_ioc,
+				   u8 value)
+{
+	u32 regval;
+
+	regval = spi_ioc;
+	if (value & BIT(1))
+		regval |= AR71XX_SPI_IOC_DO;
+	if (value & BIT(0))
+		regval |= AR71XX_SPI_IOC_CS2;
+
+	rb4xx_write(rbspi, AR71XX_SPI_REG_IOC, regval);
+	rb4xx_write(rbspi, AR71XX_SPI_REG_IOC, regval | AR71XX_SPI_IOC_CLK);
+}
+
+/* Two bits at a time, msb first */
+static void do_spi_byte_two(struct rb4xx_spi *rbspi, u32 spi_ioc, u8 byte)
+{
+	do_spi_clk_two(rbspi, spi_ioc, byte >> 6);
+	do_spi_clk_two(rbspi, spi_ioc, byte >> 4);
+	do_spi_clk_two(rbspi, spi_ioc, byte >> 2);
+	do_spi_clk_two(rbspi, spi_ioc, byte >> 0);
+}
+
+static void rb4xx_set_cs(struct spi_device *spi, bool enable)
+{
+	struct rb4xx_spi *rbspi = spi_master_get_devdata(spi->master);
+
+	/*
+	 * Setting CS is done along with bitbanging the actual values,
+	 * since it's all on the same hardware register. However the
+	 * CPLD needs CS deselected after every command.
+	 */
+	if (!enable)
+		rb4xx_write(rbspi, AR71XX_SPI_REG_IOC,
+			    AR71XX_SPI_IOC_CS0 | AR71XX_SPI_IOC_CS1);
+}
+
+static int rb4xx_transfer_one(struct spi_master *master,
+			      struct spi_device *spi, struct spi_transfer *t)
+{
+	struct rb4xx_spi *rbspi = spi_master_get_devdata(master);
+	int i;
+	u32 spi_ioc;
+	u8 *rx_buf;
+	const u8 *tx_buf;
+
+	/*
+	 * Prime the SPI register with the SPI device selected. The m25p80 boot
+	 * flash and CPLD share the CS0 pin. This works because the CPLD's
+	 * command set was designed to almost not clash with that of the
+	 * boot flash.
+	 */
+	if (spi->chip_select == 2)
+		/* MMC */
+		spi_ioc = AR71XX_SPI_IOC_CS0;
+	else
+		/* Boot flash and CPLD */
+		spi_ioc = AR71XX_SPI_IOC_CS1;
+
+	tx_buf = t->tx_buf;
+	rx_buf = t->rx_buf;
+	for (i = 0; i < t->len; ++i) {
+		if (t->tx_nbits == SPI_NBITS_DUAL)
+			/* CPLD can use two-wire transfers */
+			do_spi_byte_two(rbspi, spi_ioc, tx_buf[i]);
+		else
+			do_spi_byte(rbspi, spi_ioc, tx_buf[i]);
+		if (!rx_buf)
+			continue;
+		rx_buf[i] = rb4xx_read(rbspi, AR71XX_SPI_REG_RDS);
+	}
+	spi_finalize_current_transfer(master);
+
+	return 0;
+}
+
+static int rb4xx_spi_probe(struct platform_device *pdev)
+{
+	struct spi_master *master;
+	struct clk *ahb_clk;
+	struct rb4xx_spi *rbspi;
+	struct resource *r;
+	int err;
+	void __iomem *spi_base;
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	spi_base = devm_ioremap_resource(&pdev->dev, r);
+	if (!spi_base)
+		return PTR_ERR(spi_base);
+
+	master = spi_alloc_master(&pdev->dev, sizeof(*rbspi));
+	if (!master)
+		return -ENOMEM;
+
+	ahb_clk = devm_clk_get(&pdev->dev, "ahb");
+	if (IS_ERR(ahb_clk))
+		return PTR_ERR(ahb_clk);
+
+	master->bus_num = 0;
+	master->num_chipselect = 3;
+	master->mode_bits = SPI_TX_DUAL;
+	master->bits_per_word_mask = BIT(7);
+	master->flags = SPI_MASTER_MUST_TX;
+	master->transfer_one = rb4xx_transfer_one;
+	master->set_cs = rb4xx_set_cs;
+
+	err = devm_spi_register_master(&pdev->dev, master);
+	if (err) {
+		dev_err(&pdev->dev, "failed to register SPI master\n");
+		return err;
+	}
+
+	err = clk_prepare_enable(ahb_clk);
+	if (err)
+		return err;
+
+	rbspi = spi_master_get_devdata(master);
+	rbspi->base = spi_base;
+	rbspi->clk = ahb_clk;
+	platform_set_drvdata(pdev, rbspi);
+
+	/* Enable SPI */
+	rb4xx_write(rbspi, AR71XX_SPI_REG_FS, AR71XX_SPI_FS_GPIO);
+
+	return 0;
+}
+
+static int rb4xx_spi_remove(struct platform_device *pdev)
+{
+	struct rb4xx_spi *rbspi = platform_get_drvdata(pdev);
+
+	clk_disable_unprepare(rbspi->clk);
+
+	return 0;
+}
+
+static struct platform_driver rb4xx_spi_drv = {
+	.probe = rb4xx_spi_probe,
+	.remove = rb4xx_spi_remove,
+	.driver = {
+		.name = "rb4xx-spi",
+	},
+};
+
+module_platform_driver(rb4xx_spi_drv);
+
+MODULE_DESCRIPTION("Mikrotik RB4xx SPI controller driver");
+MODULE_AUTHOR("Gabor Juhos <juhosg@openwrt.org>");
+MODULE_AUTHOR("Bert Vermeulen <bert@biot.com>");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1
