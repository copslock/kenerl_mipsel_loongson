Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Aug 2013 20:59:15 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:50211 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6865310Ab3HIS7I4lavK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Aug 2013 20:59:08 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Gabor Juhos <juhosg@openwrt.org>, linux-spi@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH 2/2] SPI: ralink: add Ralink SoC spi driver
Date:   Fri,  9 Aug 2013 20:51:27 +0200
Message-Id: <1376074288-29302-2-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1376074288-29302-1-git-send-email-blogic@openwrt.org>
References: <1376074288-29302-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37500
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

From: Gabor Juhos <juhosg@openwrt.org>

Add the driver needed to make SPI work on Ralink SoC.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
Acked-by: John Crispin <blogic@openwrt.org>
Cc: linux-spi@vger.kernel.org
Cc: linux-mips@linux-mips.org
---
 drivers/spi/Kconfig      |    6 +
 drivers/spi/Makefile     |    1 +
 drivers/spi/spi-rt2880.c |  457 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 464 insertions(+)
 create mode 100644 drivers/spi/spi-rt2880.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 89cbbab..72f86f4 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -345,6 +345,12 @@ config SPI_RSPI
 	help
 	  SPI driver for Renesas RSPI blocks.
 
+config SPI_RT2880
+	tristate "Ralink RT288x SPI Controller"
+	depends on RALINK
+	help
+	  This selects a driver for the Ralink RT288x/RT305x SPI Controller.
+
 config SPI_S3C24XX
 	tristate "Samsung S3C24XX series SPI"
 	depends on ARCH_S3C24XX
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 33f9c09..02b1c99 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -55,6 +55,7 @@ spi-pxa2xx-platform-$(CONFIG_SPI_PXA2XX_DMA)	+= spi-pxa2xx-dma.o
 obj-$(CONFIG_SPI_PXA2XX)		+= spi-pxa2xx-platform.o
 obj-$(CONFIG_SPI_PXA2XX_PCI)		+= spi-pxa2xx-pci.o
 obj-$(CONFIG_SPI_RSPI)			+= spi-rspi.o
+obj-$(CONFIG_SPI_RT2880)		+= spi-rt2880.o
 obj-$(CONFIG_SPI_S3C24XX)		+= spi-s3c24xx-hw.o
 spi-s3c24xx-hw-y			:= spi-s3c24xx.o
 spi-s3c24xx-hw-$(CONFIG_SPI_S3C24XX_FIQ) += spi-s3c24xx-fiq.o
diff --git a/drivers/spi/spi-rt2880.c b/drivers/spi/spi-rt2880.c
new file mode 100644
index 0000000..b3a5443
--- /dev/null
+++ b/drivers/spi/spi-rt2880.c
@@ -0,0 +1,457 @@
+/*
+ * spi-rt2880.c -- Ralink RT288x/RT305x SPI controller driver
+ *
+ * Copyright (C) 2011 Sergiy <piratfm@gmail.com>
+ * Copyright (C) 2011-2013 Gabor Juhos <juhosg@openwrt.org>
+ *
+ * Some parts are based on spi-orion.c:
+ *   Author: Shadi Ammouri <shadi@marvell.com>
+ *   Copyright (C) 2007-2008 Marvell Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/reset.h>
+#include <linux/spi/spi.h>
+#include <linux/platform_device.h>
+
+#define DRIVER_NAME			"spi-rt2880"
+/* only one slave is supported*/
+#define RALINK_NUM_CHIPSELECTS		1
+/* in usec */
+#define RALINK_SPI_WAIT_RDY_MAX_LOOP	2000
+
+#define RAMIPS_SPI_STAT			0x00
+#define RAMIPS_SPI_CFG			0x10
+#define RAMIPS_SPI_CTL			0x14
+#define RAMIPS_SPI_DATA			0x20
+
+/* SPISTAT register bit field */
+#define SPISTAT_BUSY			BIT(0)
+
+/* SPICFG register bit field */
+#define SPICFG_LSBFIRST			0
+#define SPICFG_MSBFIRST			BIT(8)
+#define SPICFG_SPICLKPOL		BIT(6)
+#define SPICFG_RXCLKEDGE_FALLING	BIT(5)
+#define SPICFG_TXCLKEDGE_FALLING	BIT(4)
+#define SPICFG_SPICLK_PRESCALE_MASK	0x7
+#define SPICFG_SPICLK_DIV2		0
+#define SPICFG_SPICLK_DIV4		1
+#define SPICFG_SPICLK_DIV8		2
+#define SPICFG_SPICLK_DIV16		3
+#define SPICFG_SPICLK_DIV32		4
+#define SPICFG_SPICLK_DIV64		5
+#define SPICFG_SPICLK_DIV128		6
+#define SPICFG_SPICLK_DISABLE		7
+
+/* SPICTL register bit field */
+#define SPICTL_HIZSDO			BIT(3)
+#define SPICTL_STARTWR			BIT(2)
+#define SPICTL_STARTRD			BIT(1)
+#define SPICTL_SPIENA			BIT(0)
+
+#ifdef DEBUG
+#define spi_debug(args...) printk(args)
+#else
+#define spi_debug(args...)
+#endif
+
+struct rt2880_spi {
+	struct spi_master	*master;
+	void __iomem		*base;
+	unsigned int		sys_freq;
+	unsigned int		speed;
+	struct clk		*clk;
+};
+
+static inline struct rt2880_spi *spidev_to_rt2880_spi(struct spi_device *spi)
+{
+	return spi_master_get_devdata(spi->master);
+}
+
+static inline u32 rt2880_spi_read(struct rt2880_spi *rs, u32 reg)
+{
+	return ioread32(rs->base + reg);
+}
+
+static inline void rt2880_spi_write(struct rt2880_spi *rs, u32 reg, u32 val)
+{
+	iowrite32(val, rs->base + reg);
+}
+
+static inline void rt2880_spi_setbits(struct rt2880_spi *rs, u32 reg, u32 mask)
+{
+	void __iomem *addr = rs->base + reg;
+	u32 val;
+
+	val = ioread32(addr);
+	val |= mask;
+	iowrite32(val, addr);
+}
+
+static inline void rt2880_spi_clrbits(struct rt2880_spi *rs, u32 reg, u32 mask)
+{
+	void __iomem *addr = rs->base + reg;
+	u32 val;
+
+	val = ioread32(addr);
+	val &= ~mask;
+	iowrite32(val, addr);
+}
+
+static int rt2880_spi_baudrate_set(struct spi_device *spi, unsigned int speed)
+{
+	struct rt2880_spi *rs = spidev_to_rt2880_spi(spi);
+	u32 rate;
+	u32 prescale;
+	u32 reg;
+
+	spi_debug("%s: speed:%u\n", __func__, speed);
+
+	/*
+	 * the supported rates are: 2, 4, 8, ... 128
+	 * round up as we look for equal or less speed
+	 */
+	rate = DIV_ROUND_UP(rs->sys_freq, speed);
+	spi_debug("%s: rate-1:%u\n", __func__, rate);
+	rate = roundup_pow_of_two(rate);
+	spi_debug("%s: rate-2:%u\n", __func__, rate);
+
+	/* check if requested speed is too small */
+	if (rate > 128)
+		return -EINVAL;
+
+	if (rate < 2)
+		rate = 2;
+
+	/* Convert the rate to SPI clock divisor value.	*/
+	prescale = ilog2(rate/2);
+	spi_debug("%s: prescale:%u\n", __func__, prescale);
+
+	reg = rt2880_spi_read(rs, RAMIPS_SPI_CFG);
+	reg = ((reg & ~SPICFG_SPICLK_PRESCALE_MASK) | prescale);
+	rt2880_spi_write(rs, RAMIPS_SPI_CFG, reg);
+	rs->speed = speed;
+	return 0;
+}
+
+/*
+ * called only when no transfer is active on the bus
+ */
+static int
+rt2880_spi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
+{
+	struct rt2880_spi *rs = spidev_to_rt2880_spi(spi);
+	unsigned int speed = spi->max_speed_hz;
+	int rc;
+	unsigned int bits_per_word = 8;
+
+	if ((t != NULL) && t->speed_hz)
+		speed = t->speed_hz;
+
+	if ((t != NULL) && t->bits_per_word)
+		bits_per_word = t->bits_per_word;
+
+	if (rs->speed != speed) {
+		spi_debug("%s: speed_hz:%u\n", __func__, speed);
+		rc = rt2880_spi_baudrate_set(spi, speed);
+		if (rc)
+			return rc;
+	}
+
+	if (bits_per_word != 8) {
+		spi_debug("%s: bad bits_per_word: %u\n", __func__,
+			  bits_per_word);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void rt2880_spi_set_cs(struct rt2880_spi *rs, int enable)
+{
+	if (enable)
+		rt2880_spi_clrbits(rs, RAMIPS_SPI_CTL, SPICTL_SPIENA);
+	else
+		rt2880_spi_setbits(rs, RAMIPS_SPI_CTL, SPICTL_SPIENA);
+}
+
+static inline int rt2880_spi_wait_till_ready(struct rt2880_spi *rs)
+{
+	int i;
+
+	for (i = 0; i < RALINK_SPI_WAIT_RDY_MAX_LOOP; i++) {
+		u32 status;
+
+		status = rt2880_spi_read(rs, RAMIPS_SPI_STAT);
+		if ((status & SPISTAT_BUSY) == 0)
+			return 0;
+
+		udelay(1);
+	}
+
+	return -ETIMEDOUT;
+}
+
+static unsigned int
+rt2880_spi_write_read(struct spi_device *spi, struct spi_transfer *xfer)
+{
+	struct rt2880_spi *rs = spidev_to_rt2880_spi(spi);
+	unsigned count = 0;
+	u8 *rx = xfer->rx_buf;
+	const u8 *tx = xfer->tx_buf;
+	int err;
+
+	spi_debug("%s(%d): %s %s\n", __func__, xfer->len,
+		  (tx != NULL) ? "tx" : "  ",
+		  (rx != NULL) ? "rx" : "  ");
+
+	if (tx) {
+		for (count = 0; count < xfer->len; count++) {
+			rt2880_spi_write(rs, RAMIPS_SPI_DATA, tx[count]);
+			rt2880_spi_setbits(rs, RAMIPS_SPI_CTL, SPICTL_STARTWR);
+			err = rt2880_spi_wait_till_ready(rs);
+			if (err) {
+				dev_err(&spi->dev, "TX failed, err=%d\n", err);
+				goto out;
+			}
+		}
+	}
+
+	if (rx) {
+		for (count = 0; count < xfer->len; count++) {
+			rt2880_spi_setbits(rs, RAMIPS_SPI_CTL, SPICTL_STARTRD);
+			err = rt2880_spi_wait_till_ready(rs);
+			if (err) {
+				dev_err(&spi->dev, "RX failed, err=%d\n", err);
+				goto out;
+			}
+			rx[count] = (u8) rt2880_spi_read(rs, RAMIPS_SPI_DATA);
+		}
+	}
+
+out:
+	return count;
+}
+
+static int rt2880_spi_transfer_one_message(struct spi_master *master,
+					   struct spi_message *m)
+{
+	struct rt2880_spi *rs = spi_master_get_devdata(master);
+	struct spi_device *spi = m->spi;
+	struct spi_transfer *t = NULL;
+	int par_override = 0;
+	int status = 0;
+	int cs_active = 0;
+
+	/* Load defaults */
+	status = rt2880_spi_setup_transfer(spi, NULL);
+	if (status < 0)
+		goto msg_done;
+
+	list_for_each_entry(t, &m->transfers, transfer_list) {
+		unsigned int bits_per_word = spi->bits_per_word;
+
+		if (t->tx_buf == NULL && t->rx_buf == NULL && t->len) {
+			dev_err(&spi->dev,
+				"message rejected: invalid transfer data buffers\n");
+			status = -EIO;
+			goto msg_done;
+		}
+
+		if (t->bits_per_word)
+			bits_per_word = t->bits_per_word;
+
+		if (bits_per_word != 8) {
+			dev_err(&spi->dev,
+				"message rejected: invalid transfer bits_per_word (%d bits)\n",
+				bits_per_word);
+			status = -EIO;
+			goto msg_done;
+		}
+
+		if (t->speed_hz && t->speed_hz < (rs->sys_freq / 128)) {
+			dev_err(&spi->dev,
+				"message rejected: device min speed (%d Hz) exceeds required transfer speed (%d Hz)\n",
+				(rs->sys_freq / 128), t->speed_hz);
+			status = -EIO;
+			goto msg_done;
+		}
+
+		if (par_override || t->speed_hz || t->bits_per_word) {
+			par_override = 1;
+			status = rt2880_spi_setup_transfer(spi, t);
+			if (status < 0)
+				goto msg_done;
+			if (!t->speed_hz && !t->bits_per_word)
+				par_override = 0;
+		}
+
+		if (!cs_active) {
+			rt2880_spi_set_cs(rs, 1);
+			cs_active = 1;
+		}
+
+		if (t->len)
+			m->actual_length += rt2880_spi_write_read(spi, t);
+
+		if (t->delay_usecs)
+			udelay(t->delay_usecs);
+
+		if (t->cs_change) {
+			rt2880_spi_set_cs(rs, 0);
+			cs_active = 0;
+		}
+	}
+
+msg_done:
+	if (cs_active)
+		rt2880_spi_set_cs(rs, 0);
+
+	m->status = status;
+	spi_finalize_current_message(master);
+
+	return 0;
+}
+
+static int rt2880_spi_setup(struct spi_device *spi)
+{
+	struct rt2880_spi *rs = spidev_to_rt2880_spi(spi);
+
+	if ((spi->max_speed_hz == 0) ||
+	    (spi->max_speed_hz > (rs->sys_freq / 2)))
+		spi->max_speed_hz = (rs->sys_freq / 2);
+
+	if (spi->max_speed_hz < (rs->sys_freq / 128)) {
+		dev_err(&spi->dev, "setup: requested speed is too low %d Hz\n",
+			spi->max_speed_hz);
+		return -EINVAL;
+	}
+
+	if (spi->bits_per_word != 0 && spi->bits_per_word != 8) {
+		dev_err(&spi->dev,
+			"setup: requested bits per words - os wrong %d bpw\n",
+			spi->bits_per_word);
+		return -EINVAL;
+	}
+
+	if (spi->bits_per_word == 0)
+		spi->bits_per_word = 8;
+
+	/*
+	 * baudrate & width will be set rt2880_spi_setup_transfer
+	 */
+	return 0;
+}
+
+static void rt2880_spi_reset(struct rt2880_spi *rs)
+{
+	rt2880_spi_write(rs, RAMIPS_SPI_CFG,
+			 SPICFG_MSBFIRST | SPICFG_TXCLKEDGE_FALLING |
+			 SPICFG_SPICLK_DIV16 | SPICFG_SPICLKPOL);
+	rt2880_spi_write(rs, RAMIPS_SPI_CTL, SPICTL_HIZSDO | SPICTL_SPIENA);
+}
+
+static int rt2880_spi_probe(struct platform_device *pdev)
+{
+	struct spi_master *master;
+	struct rt2880_spi *rs;
+	struct resource *r;
+	int status = 0;
+	void __iomem *base;
+	struct clk *clk;
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_request_and_ioremap(&pdev->dev, r);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(clk)) {
+		dev_err(&pdev->dev, "unable to get SYS clock, err=%d\n",
+			status);
+		return PTR_ERR(clk);
+	}
+
+	status = clk_enable(clk);
+	if (status)
+		return status;
+
+	master = spi_alloc_master(&pdev->dev, sizeof(*rs));
+	if (master == NULL) {
+		dev_dbg(&pdev->dev, "master allocation failed\n");
+		return -ENOMEM;
+	}
+
+	/* we support only mode 0, and no options */
+	master->mode_bits = 0;
+
+	master->setup = rt2880_spi_setup;
+	master->transfer_one_message = rt2880_spi_transfer_one_message;
+	master->num_chipselect = RALINK_NUM_CHIPSELECTS;
+	master->dev.of_node = pdev->dev.of_node;
+
+	dev_set_drvdata(&pdev->dev, master);
+
+	rs = spi_master_get_devdata(master);
+	rs->base = base;
+	rs->clk = clk;
+	rs->master = master;
+	rs->sys_freq = clk_get_rate(rs->clk);
+	spi_debug("%s: sys_freq: %u\n", __func__, rs->sys_freq);
+
+	device_reset(&pdev->dev);
+
+	rt2880_spi_reset(rs);
+
+	return spi_register_master(master);
+}
+
+static int rt2880_spi_remove(struct platform_device *pdev)
+{
+	struct spi_master *master;
+	struct rt2880_spi *rs;
+
+	master = dev_get_drvdata(&pdev->dev);
+	rs = spi_master_get_devdata(master);
+
+	clk_disable(rs->clk);
+	clk_put(rs->clk);
+	spi_unregister_master(master);
+
+	return 0;
+}
+
+MODULE_ALIAS("platform:" DRIVER_NAME);
+
+static const struct of_device_id rt2880_spi_match[] = {
+	{ .compatible = "rt2880,rt2880-spi" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, rt2880_spi_match);
+
+static struct platform_driver rt2880_spi_driver = {
+	.driver = {
+		.name = DRIVER_NAME,
+		.owner = THIS_MODULE,
+		.of_match_table = rt2880_spi_match,
+	},
+	.probe = rt2880_spi_probe,
+	.remove = rt2880_spi_remove,
+};
+
+module_platform_driver(rt2880_spi_driver);
+
+MODULE_DESCRIPTION("Ralink SPI driver");
+MODULE_AUTHOR("Sergiy <piratfm@gmail.com>");
+MODULE_AUTHOR("Gabor Juhos <juhosg@openwrt.org>");
+MODULE_LICENSE("GPL");
-- 
1.7.10.4
