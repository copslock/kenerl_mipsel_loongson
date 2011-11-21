Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Nov 2011 21:17:35 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:34466 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903800Ab1KUUR0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 21 Nov 2011 21:17:26 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 02E453B51A0;
        Mon, 21 Nov 2011 21:17:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pQ5eIUnh65vf; Mon, 21 Nov 2011 21:17:24 +0100 (CET)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id 29BA93B519A;
        Mon, 21 Nov 2011 21:17:24 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     Grant Likely <grant.likely@secretlab.ca>
Cc:     spi-devel-general@lists.sourceforge.net, linux-mips@linux-mips.org,
        ralf@linux-mips.org, Florian Fainelli <florian@openwrt.org>,
        Tanguy Bouzeloc <tanguy.bouzeloc@efixo.com>
Subject: [PATCH spi-next] spi: add Broadcom BCM63xx SPI controller driver
Date:   Mon, 21 Nov 2011 21:16:55 +0100
Message-Id: <1321906615-11392-1-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.5.4
X-archive-position: 31898
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17768

This patch adds support for the SPI controller found on the Broadcom BCM63xx
SoCs.

Signed-off-by: Tanguy Bouzeloc <tanguy.bouzeloc@efixo.com>
Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
The platform related changes have been submitted on the linux-mips ml:
http://www.linux-mips.org/archives/linux-mips/2011-11/msg00547.html

Ralf, if Grant is okay with that patch, it probably makes sense to merge this
controller via your tree since it depends on the arch/mips/bcm63xx knobs.

 drivers/spi/Kconfig       |    6 +
 drivers/spi/Makefile      |    1 +
 drivers/spi/spi-bcm63xx.c |  494 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 501 insertions(+), 0 deletions(-)
 create mode 100644 drivers/spi/spi-bcm63xx.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 52e2900..8aecc4e 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -94,6 +94,12 @@ config SPI_AU1550
 	  If you say yes to this option, support will be included for the
 	  Au1550 SPI controller (may also work with Au1200,Au1210,Au1250).
 
+config SPI_BCM63XX
+	tristate "Broadcom BCM63xx SPI controller"
+	depends on BCM63XX
+	help
+          Enable support for the SPI controller on the Broadcom BCM63xx SoCs.
+
 config SPI_BITBANG
 	tristate "Utilities for Bitbanging SPI masters"
 	help
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 61c3261..be38f73 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_SPI_ALTERA)		+= spi-altera.o
 obj-$(CONFIG_SPI_ATMEL)			+= spi-atmel.o
 obj-$(CONFIG_SPI_ATH79)			+= spi-ath79.o
 obj-$(CONFIG_SPI_AU1550)		+= spi-au1550.o
+obj-$(CONFIG_SPI_BCM63XX)		+= spi-bcm63xx.o
 obj-$(CONFIG_SPI_BFIN)			+= spi-bfin5xx.o
 obj-$(CONFIG_SPI_BFIN_SPORT)		+= spi-bfin-sport.o
 obj-$(CONFIG_SPI_BITBANG)		+= spi-bitbang.o
diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
new file mode 100644
index 0000000..9f01fc8
--- /dev/null
+++ b/drivers/spi/spi-bcm63xx.c
@@ -0,0 +1,494 @@
+/*
+ * Broadcom BCM63xx SPI controller support
+ *
+ * Copyright (C) 2009-2011 Florian Fainelli <florian@openwrt.org>
+ * Copyright (C) 2010 Tanguy Bouzeloc <tanguy.bouzeloc@efixo.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the
+ * Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/spi/spi.h>
+#include <linux/completion.h>
+#include <linux/err.h>
+
+#include <bcm63xx_dev_spi.h>
+
+#define PFX		KBUILD_MODNAME
+#define DRV_VER		"0.1.2"
+
+struct bcm63xx_spi {
+	spinlock_t              lock;
+	int			stopping;
+	struct completion	done;
+
+	void __iomem		*regs;
+	int			irq;
+
+	/* Platform data */
+	u32			speed_hz;
+	unsigned		fifo_size;
+
+	/* Data buffers */
+	const unsigned char	*tx_ptr;
+	unsigned char		*rx_ptr;
+
+	/* data iomem */
+	u8 __iomem		*tx_io;
+	const u8 __iomem	*rx_io;
+
+	int			remaining_bytes;
+
+	struct clk		*clk;
+	struct platform_device	*pdev;
+};
+
+static inline u8 bcm_spi_readb(struct bcm63xx_spi *bs,
+				unsigned int offset)
+{
+	return bcm_readw(bs->regs + bcm63xx_spireg(offset));
+}
+
+static inline u16 bcm_spi_readw(struct bcm63xx_spi *bs,
+				unsigned int offset)
+{
+	return bcm_readw(bs->regs + bcm63xx_spireg(offset));
+}
+
+static inline void bcm_spi_writeb(struct bcm63xx_spi *bs,
+				  u8 value, unsigned int offset)
+{
+	bcm_writeb(value, bs->regs + bcm63xx_spireg(offset));
+}
+
+static inline void bcm_spi_writew(struct bcm63xx_spi *bs,
+				  u16 value, unsigned int offset)
+{
+	bcm_writew(value, bs->regs + bcm63xx_spireg(offset));
+}
+
+static int bcm63xx_spi_setup_transfer(struct spi_device *spi,
+				      struct spi_transfer *t)
+{
+	struct bcm63xx_spi *bs = spi_master_get_devdata(spi->master);
+	u8 bits_per_word;
+	u8 clk_cfg;
+	u32 hz;
+	unsigned int div;
+
+	bits_per_word = (t) ? t->bits_per_word : spi->bits_per_word;
+	hz = (t) ? t->speed_hz : spi->max_speed_hz;
+	if (bits_per_word != 8) {
+		dev_err(&spi->dev, "%s, unsupported bits_per_word=%d\n",
+			__func__, bits_per_word);
+		return -EINVAL;
+	}
+
+	if (spi->chip_select > spi->master->num_chipselect) {
+		dev_err(&spi->dev, "%s, unsupported slave %d\n",
+			__func__, spi->chip_select);
+		return -EINVAL;
+	}
+
+	/* Check clock setting */
+	div = (bs->speed_hz / hz);
+	switch (div) {
+	case 2:
+		clk_cfg = SPI_CLK_25MHZ;
+		break;
+	case 4:
+		clk_cfg = SPI_CLK_12_50MHZ;
+		break;
+	case 8:
+		clk_cfg = SPI_CLK_6_250MHZ;
+		break;
+	case 16:
+		clk_cfg = SPI_CLK_3_125MHZ;
+		break;
+	case 32:
+		clk_cfg = SPI_CLK_1_563MHZ;
+		break;
+	case 64:
+		clk_cfg = SPI_CLK_0_781MHZ;
+		break;
+	case 128:
+	default:
+		/* Set to slowest mode for compatibility */
+		clk_cfg = SPI_CLK_0_391MHZ;
+		break;
+	}
+
+	bcm_spi_writeb(bs, clk_cfg, SPI_CLK_CFG);
+	dev_dbg(&spi->dev, "Setting clock register to %d (hz %d, cmd %02x)\n",
+		div, hz, clk_cfg);
+
+	return 0;
+}
+
+/* the spi->mode bits understood by this driver: */
+#define MODEBITS (SPI_CPOL | SPI_CPHA)
+
+static int bcm63xx_spi_setup(struct spi_device *spi)
+{
+	struct bcm63xx_spi *bs;
+	int ret;
+
+	bs = spi_master_get_devdata(spi->master);
+
+	if (bs->stopping)
+		return -ESHUTDOWN;
+
+	if (!spi->bits_per_word)
+		spi->bits_per_word = 8;
+
+	if (spi->mode & ~MODEBITS) {
+		dev_err(&spi->dev, "%s, unsupported mode bits %x\n",
+			__func__, spi->mode & ~MODEBITS);
+		return -EINVAL;
+	}
+
+	ret = bcm63xx_spi_setup_transfer(spi, NULL);
+	if (ret < 0) {
+		dev_err(&spi->dev, "setup: unsupported mode bits %x\n",
+			spi->mode & ~MODEBITS);
+		return ret;
+	}
+
+	dev_dbg(&spi->dev, "%s, mode %d, %u bits/w, %u nsec/bit\n",
+		__func__, spi->mode & MODEBITS, spi->bits_per_word, 0);
+
+	return 0;
+}
+
+/* Fill the TX FIFO with as many bytes as possible */
+static void bcm63xx_spi_fill_tx_fifo(struct bcm63xx_spi *bs)
+{
+	u8 size;
+
+	/* Fill the Tx FIFO with as many bytes as possible */
+	size = bs->remaining_bytes < bs->fifo_size ? bs->remaining_bytes :
+		bs->fifo_size;
+	memcpy_toio(bs->tx_io, bs->tx_ptr, size);
+	bs->remaining_bytes -= size;
+}
+
+static int bcm63xx_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
+{
+	struct bcm63xx_spi *bs = spi_master_get_devdata(spi->master);
+	u16 msg_ctl;
+	u16 cmd;
+
+	dev_dbg(&spi->dev, "txrx: tx %p, rx %p, len %d\n",
+		t->tx_buf, t->rx_buf, t->len);
+
+	/* Transmitter is inhibited */
+	bs->tx_ptr = t->tx_buf;
+	bs->rx_ptr = t->rx_buf;
+	init_completion(&bs->done);
+
+	if (t->tx_buf) {
+		bs->remaining_bytes = t->len;
+		bcm63xx_spi_fill_tx_fifo(bs);
+	}
+
+	/* Enable the command done interrupt which
+	 * we use to determine completion of a command */
+	bcm_spi_writeb(bs, SPI_INTR_CMD_DONE, SPI_INT_MASK);
+
+	/* Fill in the Message control register */
+	msg_ctl = (t->len << SPI_BYTE_CNT_SHIFT);
+
+	if (t->rx_buf && t->tx_buf)
+		msg_ctl |= (SPI_FD_RW << SPI_MSG_TYPE_SHIFT);
+	else if (t->rx_buf)
+		msg_ctl |= (SPI_HD_R << SPI_MSG_TYPE_SHIFT);
+	else if (t->tx_buf)
+		msg_ctl |= (SPI_HD_W << SPI_MSG_TYPE_SHIFT);
+
+	bcm_spi_writew(bs, msg_ctl, SPI_MSG_CTL);
+
+	/* Issue the transfer */
+	cmd = SPI_CMD_START_IMMEDIATE;
+	cmd |= (0 << SPI_CMD_PREPEND_BYTE_CNT_SHIFT);
+	cmd |= (spi->chip_select << SPI_CMD_DEVICE_ID_SHIFT);
+	bcm_spi_writew(bs, cmd, SPI_CMD);
+	wait_for_completion(&bs->done);
+
+	/* Disable the CMD_DONE interrupt */
+	bcm_spi_writeb(bs, 0, SPI_INT_MASK);
+
+	return t->len - bs->remaining_bytes;
+}
+
+static int bcm63xx_transfer(struct spi_device *spi, struct spi_message *m)
+{
+	struct bcm63xx_spi *bs = spi_master_get_devdata(spi->master);
+	struct spi_transfer *t;
+	int ret = 0;
+
+	if (unlikely(list_empty(&m->transfers)))
+		return -EINVAL;
+
+	if (bs->stopping)
+		return -ESHUTDOWN;
+
+	list_for_each_entry(t, &m->transfers, transfer_list) {
+		ret += bcm63xx_txrx_bufs(spi, t);
+	}
+
+	m->complete(m->context);
+
+	return ret;
+}
+
+/* This driver supports single master mode only. Hence
+ * CMD_DONE is the only interrupt we care about
+ */
+static irqreturn_t bcm63xx_spi_interrupt(int irq, void *dev_id)
+{
+	struct spi_master *master = (struct spi_master *)dev_id;
+	struct bcm63xx_spi *bs = spi_master_get_devdata(master);
+	u8 intr;
+	u16 cmd;
+
+	/* Read interupts and clear them immediately */
+	intr = bcm_spi_readb(bs, SPI_INT_STATUS);
+	bcm_spi_writeb(bs, SPI_INTR_CLEAR_ALL, SPI_INT_STATUS);
+	bcm_spi_writeb(bs, 0, SPI_INT_MASK);
+
+	/* A tansfer completed */
+	if (intr & SPI_INTR_CMD_DONE) {
+		u8 rx_tail;
+
+		rx_tail = bcm_spi_readb(bs, SPI_RX_TAIL);
+
+		/* Read out all the data */
+		if (rx_tail)
+			memcpy_fromio(bs->rx_ptr, bs->rx_io, rx_tail);
+
+		/* See if there is more data to send */
+		if (bs->remaining_bytes > 0) {
+			bcm63xx_spi_fill_tx_fifo(bs);
+
+			/* Start the transfer */
+			bcm_spi_writew(bs, SPI_HD_W << SPI_MSG_TYPE_SHIFT,
+				       SPI_MSG_CTL);
+			cmd = bcm_spi_readw(bs, SPI_CMD);
+			cmd |= SPI_CMD_START_IMMEDIATE;
+			cmd |= (0 << SPI_CMD_PREPEND_BYTE_CNT_SHIFT);
+			bcm_spi_writeb(bs, SPI_INTR_CMD_DONE, SPI_INT_MASK);
+			bcm_spi_writew(bs, cmd, SPI_CMD);
+		} else
+			complete(&bs->done);
+	}
+
+	return IRQ_HANDLED;
+}
+
+
+static int __init bcm63xx_spi_probe(struct platform_device *pdev)
+{
+	struct resource *r;
+	struct device *dev = &pdev->dev;
+	struct bcm63xx_spi_pdata *pdata = pdev->dev.platform_data;
+	int irq;
+	struct spi_master *master;
+	struct clk *clk;
+	struct bcm63xx_spi *bs;
+	int ret;
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r) {
+		dev_err(dev, "no iomem\n");
+		ret = -ENXIO;
+		goto out;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(dev, "no irq\n");
+		ret = -ENXIO;
+		goto out;
+	}
+
+	clk = clk_get(dev, "spi");
+	if (IS_ERR(clk)) {
+		dev_err(dev, "no clock for device\n");
+		ret = -ENODEV;
+		goto out;
+	}
+
+	master = spi_alloc_master(dev, sizeof(*bs));
+	if (!master) {
+		dev_err(dev, "out of memory\n");
+		ret = -ENOMEM;
+		goto out_free;
+	}
+
+	bs = spi_master_get_devdata(master);
+	init_completion(&bs->done);
+
+	platform_set_drvdata(pdev, master);
+	bs->pdev = pdev;
+
+	if (!request_mem_region(r->start, resource_size(r), PFX)) {
+		dev_err(dev, "iomem request failed\n");
+		ret = -ENXIO;
+		goto out_put_master;
+	}
+
+	bs->regs = ioremap_nocache(r->start, resource_size(r));
+	if (!bs->regs) {
+		dev_err(dev, "unable to ioremap regs\n");
+		ret = -ENOMEM;
+		goto out_put_master;
+	}
+	bs->irq = irq;
+	bs->clk = clk;
+	bs->fifo_size = pdata->fifo_size;
+
+	ret = request_irq(irq, bcm63xx_spi_interrupt, 0, pdev->name, master);
+	if (ret) {
+		dev_err(dev, "unable to request irq\n");
+		goto out_unmap;
+	}
+
+	master->bus_num = pdata->bus_num;
+	master->num_chipselect = pdata->num_chipselect;
+	master->setup = bcm63xx_spi_setup;
+	master->transfer = bcm63xx_transfer;
+	bs->speed_hz = pdata->speed_hz;
+	bs->stopping = 0;
+	bs->tx_io = (u8 *)(bs->regs + bcm63xx_spireg(SPI_MSG_DATA));
+	bs->rx_io = (const u8 *)(bs->regs + bcm63xx_spireg(SPI_RX_DATA));
+	spin_lock_init(&bs->lock);
+
+	/* Initialize hardware */
+	clk_enable(bs->clk);
+	bcm_spi_writeb(bs, SPI_INTR_CLEAR_ALL, SPI_INT_STATUS);
+
+	/* register and we are done */
+	ret = spi_register_master(master);
+	if (ret) {
+		dev_err(dev, "spi register failed\n");
+		goto out_reset_hw;
+	}
+
+	dev_info(dev, "at 0x%08x (irq %d, FIFOs size %d) v%s\n",
+		 r->start, irq, bs->fifo_size, DRV_VER);
+
+	return 0;
+
+out_reset_hw:
+	clk_disable(clk);
+	free_irq(irq, master);
+out_unmap:
+	iounmap(bs->regs);
+out_put_master:
+	spi_master_put(master);
+out_free:
+	clk_put(clk);
+out:
+	return ret;
+}
+
+static int __exit bcm63xx_spi_remove(struct platform_device *pdev)
+{
+	struct spi_master *master = platform_get_drvdata(pdev);
+	struct bcm63xx_spi *bs = spi_master_get_devdata(master);
+	struct resource	*r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	/* reset spi block */
+	bcm_spi_writeb(bs, 0, SPI_INT_MASK);
+	spin_lock(&bs->lock);
+	bs->stopping = 1;
+
+	/* HW shutdown */
+	clk_disable(bs->clk);
+	clk_put(bs->clk);
+
+	spin_unlock(&bs->lock);
+
+	free_irq(bs->irq, master);
+	iounmap(bs->regs);
+	release_mem_region(r->start, r->end - r->start);
+	platform_set_drvdata(pdev, 0);
+	spi_unregister_master(master);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int bcm63xx_spi_suspend(struct platform_device *pdev, pm_message_t mesg)
+{
+	struct spi_master *master = platform_get_drvdata(pdev);
+	struct bcm63xx_spi *bs = spi_master_get_devdata(master);
+
+	clk_disable(bs->clk);
+
+	return 0;
+}
+
+static int bcm63xx_spi_resume(struct platform_device *pdev)
+{
+	struct spi_master *master = platform_get_drvdata(pdev);
+	struct bcm63xx_spi *bs = spi_master_get_devdata(master);
+
+	clk_enable(bs->clk);
+
+	return 0;
+}
+#else
+#define bcm63xx_spi_suspend	NULL
+#define bcm63xx_spi_resume	NULL
+#endif
+
+static struct platform_driver bcm63xx_spi_driver = {
+	.driver = {
+		.name	= "bcm63xx-spi",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= bcm63xx_spi_probe,
+	.remove		= __exit_p(bcm63xx_spi_remove),
+	.suspend	= bcm63xx_spi_suspend,
+	.resume		= bcm63xx_spi_resume,
+};
+
+
+static int __init bcm63xx_spi_init(void)
+{
+	return platform_driver_register(&bcm63xx_spi_driver);
+}
+
+static void __exit bcm63xx_spi_exit(void)
+{
+	platform_driver_unregister(&bcm63xx_spi_driver);
+}
+
+module_init(bcm63xx_spi_init);
+module_exit(bcm63xx_spi_exit);
+
+MODULE_ALIAS("platform:bcm63xx_spi");
+MODULE_AUTHOR("Florian Fainelli <florian@openwrt.org>");
+MODULE_AUTHOR("Tanguy Bouzeloc <tanguy.bouzeloc@efixo.com>");
+MODULE_DESCRIPTION("Broadcom BCM63xx SPI Controller driver");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(DRV_VER);
-- 
1.7.5.4
