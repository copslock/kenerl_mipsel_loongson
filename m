Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Mar 2012 23:04:58 +0100 (CET)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:41135 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903697Ab2CIWEt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Mar 2012 23:04:49 +0100
Received: by iaky10 with SMTP id y10so3427445iak.36
        for <linux-mips@linux-mips.org>; Fri, 09 Mar 2012 14:04:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:subject:to:cc:in-reply-to:references:date:message-id
         :x-gm-message-state;
        bh=VqDMMEGoTAtp4h+Ky+eHRtsmRlKuCSYckzTYpLMZ4tY=;
        b=IrbpUIXI+1alVu6nNUeT9SWu2DqUzuCI989110s6DA7ZMyrkqrrVfSipSoDs8AwRjA
         mtMbm7duqGRm/7/ELfZHJ5hssGARzgn7K42EVGw8kWObORKZ7KwaZwfJkOG+BPe/uolA
         t4W7QlOS0ECU7M+vDmvrBc6IrW4PnoAnCBkvc0lD+3anmX1Sk+XdBRyTM8gbvHPHkWNv
         LWvWQQYG2vCKJor6JelrGBW09Y6UjwrRKZo8jp+iP8+UXkMDHsBtiKdbbm7pKZuGSfiL
         iQ3ezG0vVQSmoGAM7Yw4vZIKYet0afKGHVORM5kZKFhbloPlTYaItS37IdlhPVT6Xv2Z
         oXwg==
Received: by 10.50.186.198 with SMTP id fm6mr5735276igc.40.1331330683244;
        Fri, 09 Mar 2012 14:04:43 -0800 (PST)
Received: from localhost (S0106d8b37715ee14.cg.shawcable.net. [68.146.14.168])
        by mx.google.com with ESMTPS id df2sm5618545igb.0.2012.03.09.14.04.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 09 Mar 2012 14:04:41 -0800 (PST)
Received: by localhost (Postfix, from userid 1000)
        id 073653E0880; Fri,  9 Mar 2012 15:04:40 -0700 (MST)
From:   Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v4] spi: add Broadcom BCM63xx SPI controller driver
To:     Florian Fainelli <florian@openwrt.org>, ralf@linux-mips.org
Cc:     Tanguy Bouzeloc <tanguy.bouzeloc@efixo.com>,
        linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>,
        spi-devel-general@lists.sourceforge.net
In-Reply-To: <1328091249-10389-1-git-send-email-florian@openwrt.org>
References: <1328019048-5892-10-git-send-email-florian@openwrt.org> <1328091249-10389-1-git-send-email-florian@openwrt.org>
Date:   Fri, 09 Mar 2012 15:04:39 -0700
Message-Id: <20120309220440.073653E0880@localhost>
X-Gm-Message-State: ALoCoQnu8Kj1CdZlGmp3AfmIH43HX1kbJkTpnqYjnX6D+X/BNAytn4yfZax+7dVS09PknoMc4cAQ
X-archive-position: 32631
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wed,  1 Feb 2012 11:14:09 +0100, Florian Fainelli <florian@openwrt.org> wrote:
> This patch adds support for the SPI controller found on the Broadcom BCM63xx
> SoCs.
> 
> Signed-off-by: Tanguy Bouzeloc <tanguy.bouzeloc@efixo.com>
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>

Applied, thanks.

In v3.4, the spi subsystem is gaining core support for spi message queues.
You should look at migrating this driver to use it in the v3.5 timeframe.

g.

> ---
> Changes since v3:
> - changed bcm_spi_readb to use readb accessor instead of readw
> - fixed multiple __dev{init,exit} annotations
> 
> Changes since v2:
> - reworked bcm63xx_spi_setup_transfer to choose closest spi transfer
>   frequency
> - removed invalid 25Mhz frequency
> - fixed some minor checkpatch issues
> 
> Changes since v1:
> - switched to the devm_* API which frees resources automatically
> - switched to dev_pm_ops
> - use module_platform_driver
> - remove MODULE_VERSION()
> - fixed return value when clock is not present using PTR_ERR()
> - fixed probe() error path to disable clock in case of failure
> 
>  drivers/spi/Kconfig       |    6 +
>  drivers/spi/Makefile      |    1 +
>  drivers/spi/spi-bcm63xx.c |  486 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 493 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/spi/spi-bcm63xx.c
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 3f9a47e..16818ac 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -94,6 +94,12 @@ config SPI_AU1550
>  	  If you say yes to this option, support will be included for the
>  	  PSC SPI controller found on Au1550, Au1200 and Au1300 series.
>  
> +config SPI_BCM63XX
> +	tristate "Broadcom BCM63xx SPI controller"
> +	depends on BCM63XX
> +	help
> +          Enable support for the SPI controller on the Broadcom BCM63xx SoCs.
> +
>  config SPI_BITBANG
>  	tristate "Utilities for Bitbanging SPI masters"
>  	help
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index 61c3261..be38f73 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_SPI_ALTERA)		+= spi-altera.o
>  obj-$(CONFIG_SPI_ATMEL)			+= spi-atmel.o
>  obj-$(CONFIG_SPI_ATH79)			+= spi-ath79.o
>  obj-$(CONFIG_SPI_AU1550)		+= spi-au1550.o
> +obj-$(CONFIG_SPI_BCM63XX)		+= spi-bcm63xx.o
>  obj-$(CONFIG_SPI_BFIN)			+= spi-bfin5xx.o
>  obj-$(CONFIG_SPI_BFIN_SPORT)		+= spi-bfin-sport.o
>  obj-$(CONFIG_SPI_BITBANG)		+= spi-bitbang.o
> diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
> new file mode 100644
> index 0000000..f01b264
> --- /dev/null
> +++ b/drivers/spi/spi-bcm63xx.c
> @@ -0,0 +1,486 @@
> +/*
> + * Broadcom BCM63xx SPI controller support
> + *
> + * Copyright (C) 2009-2011 Florian Fainelli <florian@openwrt.org>
> + * Copyright (C) 2010 Tanguy Bouzeloc <tanguy.bouzeloc@efixo.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the
> + * Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/spi/spi.h>
> +#include <linux/completion.h>
> +#include <linux/err.h>
> +
> +#include <bcm63xx_dev_spi.h>
> +
> +#define PFX		KBUILD_MODNAME
> +#define DRV_VER		"0.1.2"
> +
> +struct bcm63xx_spi {
> +	spinlock_t		lock;
> +	int			stopping;
> +	struct completion	done;
> +
> +	void __iomem		*regs;
> +	int			irq;
> +
> +	/* Platform data */
> +	u32			speed_hz;
> +	unsigned		fifo_size;
> +
> +	/* Data buffers */
> +	const unsigned char	*tx_ptr;
> +	unsigned char		*rx_ptr;
> +
> +	/* data iomem */
> +	u8 __iomem		*tx_io;
> +	const u8 __iomem	*rx_io;
> +
> +	int			remaining_bytes;
> +
> +	struct clk		*clk;
> +	struct platform_device	*pdev;
> +};
> +
> +static inline u8 bcm_spi_readb(struct bcm63xx_spi *bs,
> +				unsigned int offset)
> +{
> +	return bcm_readb(bs->regs + bcm63xx_spireg(offset));
> +}
> +
> +static inline u16 bcm_spi_readw(struct bcm63xx_spi *bs,
> +				unsigned int offset)
> +{
> +	return bcm_readw(bs->regs + bcm63xx_spireg(offset));
> +}
> +
> +static inline void bcm_spi_writeb(struct bcm63xx_spi *bs,
> +				  u8 value, unsigned int offset)
> +{
> +	bcm_writeb(value, bs->regs + bcm63xx_spireg(offset));
> +}
> +
> +static inline void bcm_spi_writew(struct bcm63xx_spi *bs,
> +				  u16 value, unsigned int offset)
> +{
> +	bcm_writew(value, bs->regs + bcm63xx_spireg(offset));
> +}
> +
> +static const unsigned bcm63xx_spi_freq_table[SPI_CLK_MASK][2] = {
> +	{ 20000000, SPI_CLK_20MHZ },
> +	{ 12500000, SPI_CLK_12_50MHZ },
> +	{  6250000, SPI_CLK_6_250MHZ },
> +	{  3125000, SPI_CLK_3_125MHZ },
> +	{  1563000, SPI_CLK_1_563MHZ },
> +	{   781000, SPI_CLK_0_781MHZ },
> +	{   391000, SPI_CLK_0_391MHZ }
> +};
> +
> +static int bcm63xx_spi_setup_transfer(struct spi_device *spi,
> +				      struct spi_transfer *t)
> +{
> +	struct bcm63xx_spi *bs = spi_master_get_devdata(spi->master);
> +	u8 bits_per_word;
> +	u8 clk_cfg, reg;
> +	u32 hz;
> +	int i;
> +
> +	bits_per_word = (t) ? t->bits_per_word : spi->bits_per_word;
> +	hz = (t) ? t->speed_hz : spi->max_speed_hz;
> +	if (bits_per_word != 8) {
> +		dev_err(&spi->dev, "%s, unsupported bits_per_word=%d\n",
> +			__func__, bits_per_word);
> +		return -EINVAL;
> +	}
> +
> +	if (spi->chip_select > spi->master->num_chipselect) {
> +		dev_err(&spi->dev, "%s, unsupported slave %d\n",
> +			__func__, spi->chip_select);
> +		return -EINVAL;
> +	}
> +
> +	/* Find the closest clock configuration */
> +	for (i = 0; i < SPI_CLK_MASK; i++) {
> +		if (hz <= bcm63xx_spi_freq_table[i][0]) {
> +			clk_cfg = bcm63xx_spi_freq_table[i][1];
> +			break;
> +		}
> +	}
> +
> +	/* No matching configuration found, default to lowest */
> +	if (i == SPI_CLK_MASK)
> +		clk_cfg = SPI_CLK_0_391MHZ;
> +
> +	/* clear existing clock configuration bits of the register */
> +	reg = bcm_spi_readb(bs, SPI_CLK_CFG);
> +	reg &= ~SPI_CLK_MASK;
> +	reg |= clk_cfg;
> +
> +	bcm_spi_writeb(bs, reg, SPI_CLK_CFG);
> +	dev_dbg(&spi->dev, "Setting clock register to %02x (hz %d)\n",
> +		clk_cfg, hz);
> +
> +	return 0;
> +}
> +
> +/* the spi->mode bits understood by this driver: */
> +#define MODEBITS (SPI_CPOL | SPI_CPHA)
> +
> +static int bcm63xx_spi_setup(struct spi_device *spi)
> +{
> +	struct bcm63xx_spi *bs;
> +	int ret;
> +
> +	bs = spi_master_get_devdata(spi->master);
> +
> +	if (bs->stopping)
> +		return -ESHUTDOWN;
> +
> +	if (!spi->bits_per_word)
> +		spi->bits_per_word = 8;
> +
> +	if (spi->mode & ~MODEBITS) {
> +		dev_err(&spi->dev, "%s, unsupported mode bits %x\n",
> +			__func__, spi->mode & ~MODEBITS);
> +		return -EINVAL;
> +	}
> +
> +	ret = bcm63xx_spi_setup_transfer(spi, NULL);
> +	if (ret < 0) {
> +		dev_err(&spi->dev, "setup: unsupported mode bits %x\n",
> +			spi->mode & ~MODEBITS);
> +		return ret;
> +	}
> +
> +	dev_dbg(&spi->dev, "%s, mode %d, %u bits/w, %u nsec/bit\n",
> +		__func__, spi->mode & MODEBITS, spi->bits_per_word, 0);
> +
> +	return 0;
> +}
> +
> +/* Fill the TX FIFO with as many bytes as possible */
> +static void bcm63xx_spi_fill_tx_fifo(struct bcm63xx_spi *bs)
> +{
> +	u8 size;
> +
> +	/* Fill the Tx FIFO with as many bytes as possible */
> +	size = bs->remaining_bytes < bs->fifo_size ? bs->remaining_bytes :
> +		bs->fifo_size;
> +	memcpy_toio(bs->tx_io, bs->tx_ptr, size);
> +	bs->remaining_bytes -= size;
> +}
> +
> +static int bcm63xx_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
> +{
> +	struct bcm63xx_spi *bs = spi_master_get_devdata(spi->master);
> +	u16 msg_ctl;
> +	u16 cmd;
> +
> +	dev_dbg(&spi->dev, "txrx: tx %p, rx %p, len %d\n",
> +		t->tx_buf, t->rx_buf, t->len);
> +
> +	/* Transmitter is inhibited */
> +	bs->tx_ptr = t->tx_buf;
> +	bs->rx_ptr = t->rx_buf;
> +	init_completion(&bs->done);
> +
> +	if (t->tx_buf) {
> +		bs->remaining_bytes = t->len;
> +		bcm63xx_spi_fill_tx_fifo(bs);
> +	}
> +
> +	/* Enable the command done interrupt which
> +	 * we use to determine completion of a command */
> +	bcm_spi_writeb(bs, SPI_INTR_CMD_DONE, SPI_INT_MASK);
> +
> +	/* Fill in the Message control register */
> +	msg_ctl = (t->len << SPI_BYTE_CNT_SHIFT);
> +
> +	if (t->rx_buf && t->tx_buf)
> +		msg_ctl |= (SPI_FD_RW << SPI_MSG_TYPE_SHIFT);
> +	else if (t->rx_buf)
> +		msg_ctl |= (SPI_HD_R << SPI_MSG_TYPE_SHIFT);
> +	else if (t->tx_buf)
> +		msg_ctl |= (SPI_HD_W << SPI_MSG_TYPE_SHIFT);
> +
> +	bcm_spi_writew(bs, msg_ctl, SPI_MSG_CTL);
> +
> +	/* Issue the transfer */
> +	cmd = SPI_CMD_START_IMMEDIATE;
> +	cmd |= (0 << SPI_CMD_PREPEND_BYTE_CNT_SHIFT);
> +	cmd |= (spi->chip_select << SPI_CMD_DEVICE_ID_SHIFT);
> +	bcm_spi_writew(bs, cmd, SPI_CMD);
> +	wait_for_completion(&bs->done);
> +
> +	/* Disable the CMD_DONE interrupt */
> +	bcm_spi_writeb(bs, 0, SPI_INT_MASK);
> +
> +	return t->len - bs->remaining_bytes;
> +}
> +
> +static int bcm63xx_transfer(struct spi_device *spi, struct spi_message *m)
> +{
> +	struct bcm63xx_spi *bs = spi_master_get_devdata(spi->master);
> +	struct spi_transfer *t;
> +	int ret = 0;
> +
> +	if (unlikely(list_empty(&m->transfers)))
> +		return -EINVAL;
> +
> +	if (bs->stopping)
> +		return -ESHUTDOWN;
> +
> +	list_for_each_entry(t, &m->transfers, transfer_list) {
> +		ret += bcm63xx_txrx_bufs(spi, t);
> +	}
> +
> +	m->complete(m->context);
> +
> +	return ret;
> +}
> +
> +/* This driver supports single master mode only. Hence
> + * CMD_DONE is the only interrupt we care about
> + */
> +static irqreturn_t bcm63xx_spi_interrupt(int irq, void *dev_id)
> +{
> +	struct spi_master *master = (struct spi_master *)dev_id;
> +	struct bcm63xx_spi *bs = spi_master_get_devdata(master);
> +	u8 intr;
> +	u16 cmd;
> +
> +	/* Read interupts and clear them immediately */
> +	intr = bcm_spi_readb(bs, SPI_INT_STATUS);
> +	bcm_spi_writeb(bs, SPI_INTR_CLEAR_ALL, SPI_INT_STATUS);
> +	bcm_spi_writeb(bs, 0, SPI_INT_MASK);
> +
> +	/* A tansfer completed */
> +	if (intr & SPI_INTR_CMD_DONE) {
> +		u8 rx_tail;
> +
> +		rx_tail = bcm_spi_readb(bs, SPI_RX_TAIL);
> +
> +		/* Read out all the data */
> +		if (rx_tail)
> +			memcpy_fromio(bs->rx_ptr, bs->rx_io, rx_tail);
> +
> +		/* See if there is more data to send */
> +		if (bs->remaining_bytes > 0) {
> +			bcm63xx_spi_fill_tx_fifo(bs);
> +
> +			/* Start the transfer */
> +			bcm_spi_writew(bs, SPI_HD_W << SPI_MSG_TYPE_SHIFT,
> +				       SPI_MSG_CTL);
> +			cmd = bcm_spi_readw(bs, SPI_CMD);
> +			cmd |= SPI_CMD_START_IMMEDIATE;
> +			cmd |= (0 << SPI_CMD_PREPEND_BYTE_CNT_SHIFT);
> +			bcm_spi_writeb(bs, SPI_INTR_CMD_DONE, SPI_INT_MASK);
> +			bcm_spi_writew(bs, cmd, SPI_CMD);
> +		} else {
> +			complete(&bs->done);
> +		}
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +
> +static int __devinit bcm63xx_spi_probe(struct platform_device *pdev)
> +{
> +	struct resource *r;
> +	struct device *dev = &pdev->dev;
> +	struct bcm63xx_spi_pdata *pdata = pdev->dev.platform_data;
> +	int irq;
> +	struct spi_master *master;
> +	struct clk *clk;
> +	struct bcm63xx_spi *bs;
> +	int ret;
> +
> +	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!r) {
> +		dev_err(dev, "no iomem\n");
> +		ret = -ENXIO;
> +		goto out;
> +	}
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(dev, "no irq\n");
> +		ret = -ENXIO;
> +		goto out;
> +	}
> +
> +	clk = clk_get(dev, "spi");
> +	if (IS_ERR(clk)) {
> +		dev_err(dev, "no clock for device\n");
> +		ret = PTR_ERR(clk);
> +		goto out;
> +	}
> +
> +	master = spi_alloc_master(dev, sizeof(*bs));
> +	if (!master) {
> +		dev_err(dev, "out of memory\n");
> +		ret = -ENOMEM;
> +		goto out_clk;
> +	}
> +
> +	bs = spi_master_get_devdata(master);
> +	init_completion(&bs->done);
> +
> +	platform_set_drvdata(pdev, master);
> +	bs->pdev = pdev;
> +
> +	if (!devm_request_mem_region(&pdev->dev, r->start,
> +					resource_size(r), PFX)) {
> +		dev_err(dev, "iomem request failed\n");
> +		ret = -ENXIO;
> +		goto out_err;
> +	}
> +
> +	bs->regs = devm_ioremap_nocache(&pdev->dev, r->start,
> +							resource_size(r));
> +	if (!bs->regs) {
> +		dev_err(dev, "unable to ioremap regs\n");
> +		ret = -ENOMEM;
> +		goto out_err;
> +	}
> +
> +	bs->irq = irq;
> +	bs->clk = clk;
> +	bs->fifo_size = pdata->fifo_size;
> +
> +	ret = devm_request_irq(&pdev->dev, irq, bcm63xx_spi_interrupt, 0,
> +							pdev->name, master);
> +	if (ret) {
> +		dev_err(dev, "unable to request irq\n");
> +		goto out_err;
> +	}
> +
> +	master->bus_num = pdata->bus_num;
> +	master->num_chipselect = pdata->num_chipselect;
> +	master->setup = bcm63xx_spi_setup;
> +	master->transfer = bcm63xx_transfer;
> +	bs->speed_hz = pdata->speed_hz;
> +	bs->stopping = 0;
> +	bs->tx_io = (u8 *)(bs->regs + bcm63xx_spireg(SPI_MSG_DATA));
> +	bs->rx_io = (const u8 *)(bs->regs + bcm63xx_spireg(SPI_RX_DATA));
> +	spin_lock_init(&bs->lock);
> +
> +	/* Initialize hardware */
> +	clk_enable(bs->clk);
> +	bcm_spi_writeb(bs, SPI_INTR_CLEAR_ALL, SPI_INT_STATUS);
> +
> +	/* register and we are done */
> +	ret = spi_register_master(master);
> +	if (ret) {
> +		dev_err(dev, "spi register failed\n");
> +		goto out_clk_disable;
> +	}
> +
> +	dev_info(dev, "at 0x%08x (irq %d, FIFOs size %d) v%s\n",
> +		 r->start, irq, bs->fifo_size, DRV_VER);
> +
> +	return 0;
> +
> +out_clk_disable:
> +	clk_disable(clk);
> +out_err:
> +	platform_set_drvdata(pdev, NULL);
> +	spi_master_put(master);
> +out_clk:
> +	clk_put(clk);
> +out:
> +	return ret;
> +}
> +
> +static int __devexit bcm63xx_spi_remove(struct platform_device *pdev)
> +{
> +	struct spi_master *master = platform_get_drvdata(pdev);
> +	struct bcm63xx_spi *bs = spi_master_get_devdata(master);
> +
> +	/* reset spi block */
> +	bcm_spi_writeb(bs, 0, SPI_INT_MASK);
> +	spin_lock(&bs->lock);
> +	bs->stopping = 1;
> +
> +	/* HW shutdown */
> +	clk_disable(bs->clk);
> +	clk_put(bs->clk);
> +
> +	spin_unlock(&bs->lock);
> +	platform_set_drvdata(pdev, 0);
> +	spi_unregister_master(master);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int bcm63xx_spi_suspend(struct device *dev)
> +{
> +	struct spi_master *master =
> +			platform_get_drvdata(to_platform_device(dev));
> +	struct bcm63xx_spi *bs = spi_master_get_devdata(master);
> +
> +	clk_disable(bs->clk);
> +
> +	return 0;
> +}
> +
> +static int bcm63xx_spi_resume(struct device *dev)
> +{
> +	struct spi_master *master =
> +			platform_get_drvdata(to_platform_device(dev));
> +	struct bcm63xx_spi *bs = spi_master_get_devdata(master);
> +
> +	clk_enable(bs->clk);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops bcm63xx_spi_pm_ops = {
> +	.suspend	= bcm63xx_spi_suspend,
> +	.resume		= bcm63xx_spi_resume,
> +};
> +
> +#define BCM63XX_SPI_PM_OPS	(&bcm63xx_spi_pm_ops)
> +#else
> +#define BCM63XX_SPI_PM_OPS	NULL
> +#endif
> +
> +static struct platform_driver bcm63xx_spi_driver = {
> +	.driver = {
> +		.name	= "bcm63xx-spi",
> +		.owner	= THIS_MODULE,
> +		.pm	= BCM63XX_SPI_PM_OPS,
> +	},
> +	.probe		= bcm63xx_spi_probe,
> +	.remove		= __devexit_p(bcm63xx_spi_remove),
> +};
> +
> +module_platform_driver(bcm63xx_spi_driver);
> +
> +MODULE_ALIAS("platform:bcm63xx_spi");
> +MODULE_AUTHOR("Florian Fainelli <florian@openwrt.org>");
> +MODULE_AUTHOR("Tanguy Bouzeloc <tanguy.bouzeloc@efixo.com>");
> +MODULE_DESCRIPTION("Broadcom BCM63xx SPI Controller driver");
> +MODULE_LICENSE("GPL");
> -- 
> 1.7.5.4
> 
> 
> ------------------------------------------------------------------------------
> Keep Your Developer Skills Current with LearnDevNow!
> The most comprehensive online learning library for Microsoft developers
> is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
> Metro Style Apps, more. Free future releases when you subscribe now!
> http://p.sf.net/sfu/learndevnow-d2d
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies,Ltd.
