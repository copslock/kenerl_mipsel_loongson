Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Jul 2010 17:44:09 +0200 (CEST)
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:53953 "EHLO
        mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491853Ab0GEPoF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Jul 2010 17:44:05 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTP id 8AFBB4DD;
        Mon,  5 Jul 2010 17:43:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at informatik.uni-hamburg.de
Received: from mailhost.informatik.uni-hamburg.de ([127.0.0.1])
        by localhost (mailhost.informatik.uni-hamburg.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id xdG8MmsN1ui2; Mon,  5 Jul 2010 17:43:58 +0200 (CEST)
Received: from [172.31.16.228] (d060066.adsl.hansenet.de [80.171.60.66])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: 7clausen)
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTPSA id C10A04DC;
        Mon,  5 Jul 2010 17:43:50 +0200 (CEST)
Message-ID: <4C31FDA3.3040708@metafoo.de>
Date:   Mon, 05 Jul 2010 17:43:31 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla-Thunderbird 2.0.0.24 (X11/20100329)
MIME-Version: 1.0
To:     Samuel Ortiz <sameo@linux.intel.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 22/26] MFD: Add JZ4740 ADC driver
References: <1276924111-11158-1-git-send-email-lars@metafoo.de> <1276924111-11158-23-git-send-email-lars@metafoo.de> <20100705145306.GA3850@sortiz-mobl>
In-Reply-To: <20100705145306.GA3850@sortiz-mobl>
X-Enigmail-Version: 0.95.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27325
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
X-list: linux-mips

Hi

Samuel Ortiz wrote:
> Hi Lars,
> 
> Sorry for the review delay. This one got lost in my inbox :-/
> 
> On Sat, Jun 19, 2010 at 07:08:27AM +0200, Lars-Peter Clausen wrote:
>> This patch adds a MFD driver for the JZ4740 ADC unit. The driver is used to
>> demultiplex IRQs and synchronize access to shared registers between the battery,
>> hwmon and (future) touchscreen driver.
> The driver looks pretty clean. I only have a couple nitpicks:
> 
>> +static void jz4740_adc_irq_demux(unsigned int irq, struct irq_desc *desc)
>> +{
>> +	struct jz4740_adc *adc = get_irq_desc_data(desc);
>> +	uint8_t status;
>> +	unsigned int i;
>> +
>> +	status = readb(adc->base + JZ_REG_ADC_STATUS);
>> +
>> +	for (i = 0; i < 5; ++i) {
>> +		if (status & BIT(i))
>> +			generic_handle_irq(adc->irq_base + i);
> for_each_set_bit() could nicely replace your loop here.

I wonder if it would make sense to optimize for_each_set_bit for small builtin
constants. Using it in it's current form for this loop would likely add some overhead.

> 
>> +static inline void jz4740_adc_clk_enable(struct jz4740_adc *adc)
>> +{
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&adc->lock, flags);
>> +	if (adc->clk_ref++ == 0)
>> +		clk_enable(adc->clk);
>> +	spin_unlock_irqrestore(&adc->lock, flags);
>> +}
> I'm not familiar with your platform clock framework, but shouldn't the
> refcounting be handled there instead of spread over all your drivers ?

The ADC clock is the only clock on this platform which is shared between multiple
devices so I refrained from adding the refcounting to the core for now. But to be
strictly complaint with the clock API as defined in linux/clk.h the implementation
should do refcounting. I'm still a bit uncertain what would be done best here.

> 
>> +static int __devinit jz4740_adc_probe(struct platform_device *pdev)
>> +{
>> +	int ret;
>> +	struct jz4740_adc *adc;
>> +	struct resource *mem_base;
>> +	int irq;
>> +
>> +	adc = kmalloc(sizeof(*adc), GFP_KERNEL);
>> +
>> +	adc->irq = platform_get_irq(pdev, 0);
>> +	if (adc->irq < 0) {
>> +		ret = adc->irq;
>> +		dev_err(&pdev->dev, "Failed to get platform irq: %d\n", ret);
>> +		goto err_free;
>> +	}
>> +
>> +	adc->irq_base = platform_get_irq(pdev, 1);
>> +	if (adc->irq_base < 0) {
>> +		ret = adc->irq_base;
>> +		dev_err(&pdev->dev, "Failed to get irq base: %d\n", ret);
>> +		goto err_free;
>> +	}
>> +
>> +	mem_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (!mem_base) {
>> +		ret = -ENOENT;
>> +		dev_err(&pdev->dev, "Failed to get platform mmio resource\n");
>> +		goto err_free;
>> +	}
>> +
>> +	/* Only request the shared registers for the MFD driver */
>> +	adc->mem = request_mem_region(mem_base->start, JZ_REG_ADC_STATUS,
>> +					pdev->name);
>> +	if (!adc->mem) {
>> +		ret = -EBUSY;
>> +		dev_err(&pdev->dev, "Failed to request mmio memory region\n");
>> +		goto err_free;
>> +	}
>> +
>> +	adc->base = ioremap_nocache(adc->mem->start, resource_size(adc->mem));
>> +	if (!adc->base) {
>> +		ret = -EBUSY;
>> +		dev_err(&pdev->dev, "Failed to ioremap mmio memory\n");
>> +		goto err_release_mem_region;
>> +	}
>> +
>> +	adc->clk = clk_get(&pdev->dev, "adc");
>> +	if (IS_ERR(adc->clk)) {
>> +		ret = PTR_ERR(adc->clk);
>> +		dev_err(&pdev->dev, "Failed to get clock: %d\n", ret);
>> +		goto err_iounmap;
>> +	}
>> +
>> +	spin_lock_init(&adc->lock);
>> +
>> +	adc->clk_ref = 0;
>> +
>> +	platform_set_drvdata(pdev, adc);
>> +
>> +	for (irq = adc->irq_base; irq < adc->irq_base + 5; ++irq) {
>> +		set_irq_chip_data(irq, adc);
>> +		set_irq_chip_and_handler(irq, &jz4740_adc_irq_chip,
>> +		    handle_level_irq);
>> +	}
>> +
>> +	set_irq_data(adc->irq, adc);
>> +	set_irq_chained_handler(adc->irq, jz4740_adc_irq_demux);
>> +
>> +	writeb(0x00, adc->base + JZ_REG_ADC_ENABLE);
>> +	writeb(0xff, adc->base + JZ_REG_ADC_CTRL);
>> +
>> +	mfd_add_devices(&pdev->dev, 0, jz4740_adc_cells,
>> +		ARRAY_SIZE(jz4740_adc_cells), mem_base, adc->irq_base);
>> +
>> +	return 0;
> Please return the mfd_add_devices return value.
> 
> Cheers,
> Samuel.
> 

Thanks for reviewing the patch

- Lars
