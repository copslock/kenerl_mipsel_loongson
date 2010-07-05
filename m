Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Jul 2010 16:58:23 +0200 (CEST)
Received: from mga14.intel.com ([143.182.124.37]:33651 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490949Ab0GEO6S (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 5 Jul 2010 16:58:18 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga102.ch.intel.com with ESMTP; 05 Jul 2010 07:53:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.53,540,1272870000"; 
   d="scan'208";a="296679096"
Received: from unknown (HELO sortiz-mobl) ([10.255.17.75])
  by azsmga001.ch.intel.com with ESMTP; 05 Jul 2010 07:53:07 -0700
Date:   Mon, 5 Jul 2010 16:53:08 +0200
From:   Samuel Ortiz <sameo@linux.intel.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 22/26] MFD: Add JZ4740 ADC driver
Message-ID: <20100705145306.GA3850@sortiz-mobl>
References: <1276924111-11158-1-git-send-email-lars@metafoo.de>
 <1276924111-11158-23-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1276924111-11158-23-git-send-email-lars@metafoo.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <sameo@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27324
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sameo@linux.intel.com
Precedence: bulk
X-list: linux-mips

Hi Lars,

Sorry for the review delay. This one got lost in my inbox :-/

On Sat, Jun 19, 2010 at 07:08:27AM +0200, Lars-Peter Clausen wrote:
> This patch adds a MFD driver for the JZ4740 ADC unit. The driver is used to
> demultiplex IRQs and synchronize access to shared registers between the battery,
> hwmon and (future) touchscreen driver.
The driver looks pretty clean. I only have a couple nitpicks:

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
for_each_set_bit() could nicely replace your loop here.

> +static inline void jz4740_adc_clk_enable(struct jz4740_adc *adc)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&adc->lock, flags);
> +	if (adc->clk_ref++ == 0)
> +		clk_enable(adc->clk);
> +	spin_unlock_irqrestore(&adc->lock, flags);
> +}
I'm not familiar with your platform clock framework, but shouldn't the
refcounting be handled there instead of spread over all your drivers ?

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
Please return the mfd_add_devices return value.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
