Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Jul 2010 00:48:18 +0200 (CEST)
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:58131 "EHLO
        mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492144Ab0GDWsM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Jul 2010 00:48:12 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTP id A230298B;
        Mon,  5 Jul 2010 00:48:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at informatik.uni-hamburg.de
Received: from mailhost.informatik.uni-hamburg.de ([127.0.0.1])
        by localhost (mailhost.informatik.uni-hamburg.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 1peHLjPh61FW; Mon,  5 Jul 2010 00:48:05 +0200 (CEST)
Received: from [192.168.37.31] (port-92973.pppoe.wtnet.de [84.46.75.169])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: 7clausen)
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTPSA id 4025098A;
        Mon,  5 Jul 2010 00:48:03 +0200 (CEST)
Message-ID: <4C310F90.5050106@metafoo.de>
Date:   Mon, 05 Jul 2010 00:47:44 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla-Thunderbird 2.0.0.24 (X11/20100329)
MIME-Version: 1.0
To:     Samuel Ortiz <sameo@linux.intel.com>
CC:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v2 22/26] MFD: Add JZ4740 ADC driver
References: <1276924111-11158-1-git-send-email-lars@metafoo.de> <1276924111-11158-23-git-send-email-lars@metafoo.de>
In-Reply-To: <1276924111-11158-23-git-send-email-lars@metafoo.de>
X-Enigmail-Version: 0.95.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27305
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
X-list: linux-mips

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Samuel

Could you take a look at this driver and say whether this driver looks ok or not?

Thanks
- - Lars

Lars-Peter Clausen wrote:
> This patch adds a MFD driver for the JZ4740 ADC unit. The driver is used to
> demultiplex IRQs and synchronize access to shared registers between the battery,
> hwmon and (future) touchscreen driver.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> ---
>  drivers/mfd/Kconfig        |    8 +
>  drivers/mfd/Makefile       |    1 +
>  drivers/mfd/jz4740-adc.c   |  392 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/jz4740-adc.h |   32 ++++
>  4 files changed, 433 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/mfd/jz4740-adc.c
>  create mode 100644 include/linux/jz4740-adc.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 9da0e50..9cacc39 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -482,6 +482,14 @@ config MFD_JANZ_CMODIO
>  	  host many different types of MODULbus daughterboards, including
>  	  CAN and GPIO controllers.
>  
> +config MFD_JZ4740_ADC
> +	tristate "Support for the JZ4740 SoC ADC core"
> +	select MFD_CORE
> +	depends on MACH_JZ4740
> +	help
> +	  Say yes here if you want support for the ADC unit in the JZ4740 SoC.
> +	  This driver is necessary for jz4740-battery and jz4740-hwmon driver.
> +
>  endif # MFD_SUPPORT
>  
>  menu "Multimedia Capabilities Port drivers"
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index fb503e7..a1a2765 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -71,3 +71,4 @@ obj-$(CONFIG_PMIC_ADP5520)	+= adp5520.o
>  obj-$(CONFIG_LPC_SCH)		+= lpc_sch.o
>  obj-$(CONFIG_MFD_RDC321X)	+= rdc321x-southbridge.o
>  obj-$(CONFIG_MFD_JANZ_CMODIO)	+= janz-cmodio.o
> +obj-$(CONFIG_MFD_JZ4740_ADC)	+= jz4740-adc.o
> diff --git a/drivers/mfd/jz4740-adc.c b/drivers/mfd/jz4740-adc.c
> new file mode 100644
> index 0000000..cac8a52
> --- /dev/null
> +++ b/drivers/mfd/jz4740-adc.c
> @@ -0,0 +1,392 @@
> +/*
> + * Copyright (C) 2009-2010, Lars-Peter Clausen <lars@metafoo.de>
> + * JZ4740 SoC ADC driver
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under  the terms of the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the License, or (at your
> + * option) any later version.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write to the Free Software Foundation, Inc.,
> + * 675 Mass Ave, Cambridge, MA 02139, USA.
> + *
> + * This driver synchronizes access to the JZ4740 ADC core between the
> + * JZ4740 battery and hwmon drivers.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/irq.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +
> +#include <linux/clk.h>
> +#include <linux/mfd/core.h>
> +
> +#include <linux/jz4740-adc.h>
> +
> +
> +#define JZ_REG_ADC_ENABLE	0x00
> +#define JZ_REG_ADC_CFG		0x04
> +#define JZ_REG_ADC_CTRL		0x08
> +#define JZ_REG_ADC_STATUS	0x0c
> +
> +#define JZ_REG_ADC_TOUCHSCREEN_BASE	0x10
> +#define JZ_REG_ADC_BATTERY_BASE	0x1c
> +#define JZ_REG_ADC_HWMON_BASE	0x20
> +
> +#define JZ_ADC_ENABLE_TOUCH	BIT(2)
> +#define JZ_ADC_ENABLE_BATTERY	BIT(1)
> +#define JZ_ADC_ENABLE_ADCIN	BIT(0)
> +
> +enum {
> +	JZ_ADC_IRQ_ADCIN = 0,
> +	JZ_ADC_IRQ_BATTERY,
> +	JZ_ADC_IRQ_TOUCH,
> +	JZ_ADC_IRQ_PENUP,
> +	JZ_ADC_IRQ_PENDOWN,
> +};
> +
> +struct jz4740_adc {
> +	struct resource *mem;
> +	void __iomem *base;
> +
> +	int irq;
> +	int irq_base;
> +
> +	struct clk *clk;
> +	unsigned int clk_ref;
> +
> +	spinlock_t lock;
> +};
> +
> +static inline void jz4740_adc_irq_set_masked(struct jz4740_adc *adc, int irq,
> +	bool masked)
> +{
> +	unsigned long flags;
> +	uint8_t val;
> +
> +	irq -= adc->irq_base;
> +
> +	spin_lock_irqsave(&adc->lock, flags);
> +
> +	val = readb(adc->base + JZ_REG_ADC_CTRL);
> +	if (masked)
> +		val |= BIT(irq);
> +	else
> +		val &= ~BIT(irq);
> +	writeb(val, adc->base + JZ_REG_ADC_CTRL);
> +
> +	spin_unlock_irqrestore(&adc->lock, flags);
> +}
> +
> +static void jz4740_adc_irq_mask(unsigned int irq)
> +{
> +	struct jz4740_adc *adc = get_irq_chip_data(irq);
> +	jz4740_adc_irq_set_masked(adc, irq, true);
> +}
> +
> +static void jz4740_adc_irq_unmask(unsigned int irq)
> +{
> +	struct jz4740_adc *adc = get_irq_chip_data(irq);
> +	jz4740_adc_irq_set_masked(adc, irq, false);
> +}
> +
> +static void jz4740_adc_irq_ack(unsigned int irq)
> +{
> +	struct jz4740_adc *adc = get_irq_chip_data(irq);
> +
> +	irq -= adc->irq_base;
> +	writeb(BIT(irq), adc->base + JZ_REG_ADC_STATUS);
> +}
> +
> +static struct irq_chip jz4740_adc_irq_chip = {
> +	.name = "jz4740-adc",
> +	.mask = jz4740_adc_irq_mask,
> +	.unmask = jz4740_adc_irq_unmask,
> +	.ack = jz4740_adc_irq_ack,
> +};
> +
> +static void jz4740_adc_irq_demux(unsigned int irq, struct irq_desc *desc)
> +{
> +	struct jz4740_adc *adc = get_irq_desc_data(desc);
> +	uint8_t status;
> +	unsigned int i;
> +
> +	status = readb(adc->base + JZ_REG_ADC_STATUS);
> +
> +	for (i = 0; i < 5; ++i) {
> +		if (status & BIT(i))
> +			generic_handle_irq(adc->irq_base + i);
> +	}
> +}
> +
> +static inline void jz4740_adc_clk_enable(struct jz4740_adc *adc)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&adc->lock, flags);
> +	if (adc->clk_ref++ == 0)
> +		clk_enable(adc->clk);
> +	spin_unlock_irqrestore(&adc->lock, flags);
> +}
> +
> +static inline void jz4740_adc_clk_disable(struct jz4740_adc *adc)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&adc->lock, flags);
> +	if (--adc->clk_ref == 0)
> +		clk_disable(adc->clk);
> +	spin_unlock_irqrestore(&adc->lock, flags);
> +}
> +
> +
> +static inline void jz4740_adc_set_enabled(struct jz4740_adc *adc, int engine,
> +	bool enabled)
> +{
> +	unsigned long flags;
> +	uint8_t val;
> +
> +	spin_lock_irqsave(&adc->lock, flags);
> +
> +	val = readb(adc->base + JZ_REG_ADC_ENABLE);
> +	if (enabled)
> +		val |= BIT(engine);
> +	else
> +		val &= BIT(engine);
> +	writeb(val, adc->base + JZ_REG_ADC_ENABLE);
> +
> +	spin_unlock_irqrestore(&adc->lock, flags);
> +}
> +
> +static int jz4740_adc_cell_enable(struct platform_device *pdev)
> +{
> +	struct jz4740_adc *adc = dev_get_drvdata(pdev->dev.parent);
> +
> +	jz4740_adc_clk_enable(adc);
> +	jz4740_adc_set_enabled(adc, pdev->id, true);
> +
> +	return 0;
> +}
> +
> +static int jz4740_adc_cell_disable(struct platform_device *pdev)
> +{
> +	struct jz4740_adc *adc = dev_get_drvdata(pdev->dev.parent);
> +
> +	jz4740_adc_set_enabled(adc, pdev->id, false);
> +	jz4740_adc_clk_disable(adc);
> +
> +	return 0;
> +}
> +
> +int jz4740_adc_set_config(struct device *dev, uint32_t mask, uint32_t val)
> +{
> +	struct jz4740_adc *adc = dev_get_drvdata(dev);
> +	unsigned long flags;
> +	uint32_t cfg;
> +
> +	if (!adc)
> +		return -ENODEV;
> +
> +	spin_lock_irqsave(&adc->lock, flags);
> +
> +	cfg = readl(adc->base + JZ_REG_ADC_CFG);
> +
> +	cfg &= ~mask;
> +	cfg |= val;
> +
> +	writel(cfg, adc->base + JZ_REG_ADC_CFG);
> +
> +	spin_unlock_irqrestore(&adc->lock, flags);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(jz4740_adc_set_config);
> +
> +static struct resource jz4740_hwmon_resources[] = {
> +	{
> +		.start = JZ_ADC_IRQ_ADCIN,
> +		.flags = IORESOURCE_IRQ,
> +	},
> +	{
> +		.start	= JZ_REG_ADC_HWMON_BASE,
> +		.end	= JZ_REG_ADC_HWMON_BASE + 3,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +};
> +
> +static struct resource jz4740_battery_resources[] = {
> +	{
> +		.start = JZ_ADC_IRQ_BATTERY,
> +		.flags = IORESOURCE_IRQ,
> +	},
> +	{
> +		.start	= JZ_REG_ADC_BATTERY_BASE,
> +		.end	= JZ_REG_ADC_BATTERY_BASE + 3,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +};
> +
> +const struct mfd_cell jz4740_adc_cells[] = {
> +	{
> +		.id = 0,
> +		.name = "jz4740-hwmon",
> +		.num_resources = ARRAY_SIZE(jz4740_hwmon_resources),
> +		.resources = jz4740_hwmon_resources,
> +		.platform_data = (void *)&jz4740_adc_cells[0],
> +		.data_size = sizeof(struct mfd_cell),
> +
> +		.enable = jz4740_adc_cell_enable,
> +		.disable = jz4740_adc_cell_disable,
> +	},
> +	{
> +		.id = 1,
> +		.name = "jz4740-battery",
> +		.num_resources = ARRAY_SIZE(jz4740_battery_resources),
> +		.resources = jz4740_battery_resources,
> +		.platform_data = (void *)&jz4740_adc_cells[1],
> +		.data_size = sizeof(struct mfd_cell),
> +
> +		.enable = jz4740_adc_cell_enable,
> +		.disable = jz4740_adc_cell_disable,
> +	},
> +};
> +
> +static int __devinit jz4740_adc_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct jz4740_adc *adc;
> +	struct resource *mem_base;
> +	int irq;
> +
> +	adc = kmalloc(sizeof(*adc), GFP_KERNEL);
> +
> +	adc->irq = platform_get_irq(pdev, 0);
> +	if (adc->irq < 0) {
> +		ret = adc->irq;
> +		dev_err(&pdev->dev, "Failed to get platform irq: %d\n", ret);
> +		goto err_free;
> +	}
> +
> +	adc->irq_base = platform_get_irq(pdev, 1);
> +	if (adc->irq_base < 0) {
> +		ret = adc->irq_base;
> +		dev_err(&pdev->dev, "Failed to get irq base: %d\n", ret);
> +		goto err_free;
> +	}
> +
> +	mem_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!mem_base) {
> +		ret = -ENOENT;
> +		dev_err(&pdev->dev, "Failed to get platform mmio resource\n");
> +		goto err_free;
> +	}
> +
> +	/* Only request the shared registers for the MFD driver */
> +	adc->mem = request_mem_region(mem_base->start, JZ_REG_ADC_STATUS,
> +					pdev->name);
> +	if (!adc->mem) {
> +		ret = -EBUSY;
> +		dev_err(&pdev->dev, "Failed to request mmio memory region\n");
> +		goto err_free;
> +	}
> +
> +	adc->base = ioremap_nocache(adc->mem->start, resource_size(adc->mem));
> +	if (!adc->base) {
> +		ret = -EBUSY;
> +		dev_err(&pdev->dev, "Failed to ioremap mmio memory\n");
> +		goto err_release_mem_region;
> +	}
> +
> +	adc->clk = clk_get(&pdev->dev, "adc");
> +	if (IS_ERR(adc->clk)) {
> +		ret = PTR_ERR(adc->clk);
> +		dev_err(&pdev->dev, "Failed to get clock: %d\n", ret);
> +		goto err_iounmap;
> +	}
> +
> +	spin_lock_init(&adc->lock);
> +
> +	adc->clk_ref = 0;
> +
> +	platform_set_drvdata(pdev, adc);
> +
> +	for (irq = adc->irq_base; irq < adc->irq_base + 5; ++irq) {
> +		set_irq_chip_data(irq, adc);
> +		set_irq_chip_and_handler(irq, &jz4740_adc_irq_chip,
> +		    handle_level_irq);
> +	}
> +
> +	set_irq_data(adc->irq, adc);
> +	set_irq_chained_handler(adc->irq, jz4740_adc_irq_demux);
> +
> +	writeb(0x00, adc->base + JZ_REG_ADC_ENABLE);
> +	writeb(0xff, adc->base + JZ_REG_ADC_CTRL);
> +
> +	mfd_add_devices(&pdev->dev, 0, jz4740_adc_cells,
> +		ARRAY_SIZE(jz4740_adc_cells), mem_base, adc->irq_base);
> +
> +	return 0;
> +
> +err_iounmap:
> +	platform_set_drvdata(pdev, NULL);
> +	iounmap(adc->base);
> +err_release_mem_region:
> +	release_mem_region(adc->mem->start, resource_size(adc->mem));
> +err_free:
> +	kfree(adc);
> +
> +	return ret;
> +}
> +
> +static int __devexit jz4740_adc_remove(struct platform_device *pdev)
> +{
> +	struct jz4740_adc *adc = platform_get_drvdata(pdev);
> +
> +	mfd_remove_devices(&pdev->dev);
> +
> +	set_irq_data(adc->irq, NULL);
> +	set_irq_chained_handler(adc->irq, NULL);
> +
> +	iounmap(adc->base);
> +	release_mem_region(adc->mem->start, resource_size(adc->mem));
> +
> +	clk_put(adc->clk);
> +
> +	platform_set_drvdata(pdev, NULL);
> +
> +	kfree(adc);
> +
> +	return 0;
> +}
> +
> +struct platform_driver jz4740_adc_driver = {
> +	.probe	= jz4740_adc_probe,
> +	.remove = __devexit_p(jz4740_adc_remove),
> +	.driver = {
> +		.name = "jz4740-adc",
> +		.owner = THIS_MODULE,
> +	},
> +};
> +
> +static int __init jz4740_adc_init(void)
> +{
> +	return platform_driver_register(&jz4740_adc_driver);
> +}
> +module_init(jz4740_adc_init);
> +
> +static void __exit jz4740_adc_exit(void)
> +{
> +	platform_driver_unregister(&jz4740_adc_driver);
> +}
> +module_exit(jz4740_adc_exit);
> +
> +MODULE_DESCRIPTION("JZ4740 SoC ADC driver");
> +MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:jz4740-adc");
> diff --git a/include/linux/jz4740-adc.h b/include/linux/jz4740-adc.h
> new file mode 100644
> index 0000000..9053f95
> --- /dev/null
> +++ b/include/linux/jz4740-adc.h
> @@ -0,0 +1,32 @@
> +
> +#ifndef __LINUX_JZ4740_ADC
> +#define __LINUX_JZ4740_ADC
> +
> +#include <linux/device.h>
> +
> +/*
> + * jz4740_adc_set_config - Configure a JZ4740 adc device
> + * @dev: Pointer to a jz4740-adc device
> + * @mask: Mask for the config value to be set
> + * @val: Value to be set
> + *
> + * This function can be used by the JZ4740 ADC mfd cells to configure their
> + * options in the shared config register.
> +*/
> +int jz4740_adc_set_config(struct device *dev, uint32_t mask, uint32_t val);
> +
> +#define JZ_ADC_CONFIG_SPZZ		BIT(31)
> +#define JZ_ADC_CONFIG_EX_IN		BIT(30)
> +#define JZ_ADC_CONFIG_DNUM_MASK		(0x7 << 16)
> +#define JZ_ADC_CONFIG_DMA_ENABLE	BIT(15)
> +#define JZ_ADC_CONFIG_XYZ_MASK		(0x2 << 13)
> +#define JZ_ADC_CONFIG_SAMPLE_NUM_MASK	(0x7 << 10)
> +#define JZ_ADC_CONFIG_CLKDIV_MASK	(0xf << 5)
> +#define JZ_ADC_CONFIG_BAT_MB		BIT(4)
> +
> +#define JZ_ADC_CONFIG_DNUM(dnum)	((dnum) << 16)
> +#define JZ_ADC_CONFIG_XYZ_OFFSET(dnum)	((xyz) << 13)
> +#define JZ_ADC_CONFIG_SAMPLE_NUM(x)	((x) << 10)
> +#define JZ_ADC_CONFIG_CLKDIV(div)	((div) << 5)
> +
> +#endif

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkwxD5AACgkQBX4mSR26RiN/pgCfbdAlLjaN4Ot91yNDkNs+27TX
f90AoIFB5pXsuLK+6lQbqq5WUt8cOhlM
=wFGF
-----END PGP SIGNATURE-----
