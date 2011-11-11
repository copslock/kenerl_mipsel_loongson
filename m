Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Nov 2011 17:08:41 +0100 (CET)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:53799 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903984Ab1KKQIc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Nov 2011 17:08:32 +0100
Received: by ywp31 with SMTP id 31so2763213ywp.36
        for <multiple recipients>; Fri, 11 Nov 2011 08:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=1KDbiyc+lwIPeQJd1NUte8KqExI4nhIRaNWSzFpxmvg=;
        b=kQ4QK2+j6GImFT2BUHBK+4h9DFfWBBR2dPc6wUs87GeyIxUVlsFiXh2iPWUohbS1XI
         V/xjudWTu/twaEvFZQcZfBivdBCche48Ogr44zEucxFiH2UIuWCIpux2ai5IyU77HFgs
         uiSni4PGIqHdpxPUDf41JxVprBmf5ntJfbTiA=
Received: by 10.100.208.1 with SMTP id f1mr2529301ang.72.1321027691538;
        Fri, 11 Nov 2011 08:08:11 -0800 (PST)
Received: from [192.168.1.103] (65-36-72-55.dyn.grandenetworks.net. [65.36.72.55])
        by mx.google.com with ESMTPS id b9sm34901487anb.7.2011.11.11.08.08.09
        (version=SSLv3 cipher=OTHER);
        Fri, 11 Nov 2011 08:08:10 -0800 (PST)
Message-ID: <4EBD4868.7040809@gmail.com>
Date:   Fri, 11 Nov 2011 10:08:08 -0600
From:   Rob Herring <robherring2@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
MIME-Version: 1.0
To:     ddaney.cavm@gmail.com
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca,
        linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 3/8] MIPS: Octeon: Add irq_create_of_mapping() and GPIO
 interrupts.
References: <1320978124-13042-1-git-send-email-ddaney.cavm@gmail.com> <1320978124-13042-4-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1320978124-13042-4-git-send-email-ddaney.cavm@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 31563
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robherring2@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10391

On 11/10/2011 08:21 PM, ddaney.cavm@gmail.com wrote:
> From: David Daney <david.daney@cavium.com>
> 
> This is needed for Octeon to use the Device Tree.
> 
> The GPIO interrupts are configured based on Device Tree properties
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  arch/mips/cavium-octeon/octeon-irq.c |  188 +++++++++++++++++++++++++++++++++-
>  1 files changed, 187 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
> index ffd4ae6..bb10546 100644
> --- a/arch/mips/cavium-octeon/octeon-irq.c
> +++ b/arch/mips/cavium-octeon/octeon-irq.c
> @@ -8,11 +8,14 @@
>  
>  #include <linux/interrupt.h>
>  #include <linux/bitops.h>
> +#include <linux/module.h>
>  #include <linux/percpu.h>
> +#include <linux/of_irq.h>
>  #include <linux/irq.h>
>  #include <linux/smp.h>
>  
>  #include <asm/octeon/octeon.h>
> +#include <asm/octeon/cvmx-gpio-defs.h>
>  
>  static DEFINE_RAW_SPINLOCK(octeon_irq_ciu0_lock);
>  static DEFINE_RAW_SPINLOCK(octeon_irq_ciu1_lock);
> @@ -58,6 +61,95 @@ static void __init octeon_irq_set_ciu_mapping(int irq, int line, int bit,
>  	octeon_irq_ciu_to_irq[line][bit] = irq;
>  }
>  
> +static unsigned int octeon_irq_gpio_mapping(struct device_node *controller,
> +					    const u32 *intspec,
> +					    unsigned int intsize)
> +{
> +	struct of_irq oirq;
> +	int i;
> +	unsigned int irq = 0;
> +	unsigned int type;
> +	unsigned int ciu = 0, bit = 0;
> +	unsigned int pin = be32_to_cpup(intspec);
> +	unsigned int trigger = be32_to_cpup(intspec + 1);
> +	bool set_edge_handler = false;
> +
> +	if (pin >= 16)
> +		goto err;
> +	i = of_irq_map_one(controller, 0, &oirq);
> +	if (i)
> +		goto err;
> +	if (oirq.size != 2)
> +		goto err_put;
> +
> +	ciu = oirq.specifier[0];
> +	bit = oirq.specifier[1] + pin;
> +
> +	if (ciu >= 8 || bit >= 64)
> +		goto err_put;
> +
> +	irq = octeon_irq_ciu_to_irq[ciu][bit];
> +	if (!irq)
> +		goto err_put;
> +
> +	switch (trigger & 0xf) {
> +	case 1:
> +		type = IRQ_TYPE_EDGE_RISING;
> +		set_edge_handler = true;
> +		break;
> +	case 2:
> +		type = IRQ_TYPE_EDGE_FALLING;
> +		set_edge_handler = true;
> +		break;
> +	case 4:
> +		type = IRQ_TYPE_LEVEL_HIGH;
> +		break;
> +	case 8:
> +		type = IRQ_TYPE_LEVEL_LOW;
> +		break;
> +	default:
> +		pr_err("Error: Invalid irq trigger specification: %x\n",
> +		       trigger);
> +		type = IRQ_TYPE_LEVEL_LOW;
> +		break;
> +	}
> +
> +	irq_set_irq_type(irq, type);
> +
> +	if (set_edge_handler)
> +		__irq_set_handler(irq, handle_edge_irq, 0, NULL);
> +
> +err_put:
> +	of_node_put(oirq.controller);
> +err:
> +	return irq;
> +}
> +
> +/*
> + * irq_create_of_mapping - Hook to resolve OF irq specifier into a Linux irq#
> + *
> + * Octeon irq maps are a pair of indexes.  The first selects either
> + * ciu0 or ciu1, the second is the bit within the ciu register.
> + */
> +unsigned int irq_create_of_mapping(struct device_node *controller,
> +				   const u32 *intspec, unsigned int intsize)
> +{
> +	unsigned int irq = 0;
> +	unsigned int ciu, bit;
> +
> +	if (of_device_is_compatible(controller, "cavium,octeon-3860-gpio"))
> +		return octeon_irq_gpio_mapping(controller, intspec, intsize);
> +
> +	ciu = be32_to_cpup(intspec);
> +	bit = be32_to_cpup(intspec + 1);
> +
> +	if (ciu < 8 && bit < 64)
> +		irq = octeon_irq_ciu_to_irq[ciu][bit];
> +
> +	return irq;
> +}
> +EXPORT_SYMBOL_GPL(irq_create_of_mapping);

Have you looked at irq_domains (kernel/irq/irqdomain.c)? That is what
you should be using for your (gpio) interrupt controller and then use
the common irq_create_of_mapping.

Rob

> +
>  static int octeon_coreid_for_cpu(int cpu)
>  {
>  #ifdef CONFIG_SMP
> @@ -505,6 +597,72 @@ static void octeon_irq_ciu_enable_all_v2(struct irq_data *data)
>  	}
>  }
>  
> +static void octeon_irq_gpio_setup(struct irq_data *data)
> +{
> +	union cvmx_gpio_bit_cfgx cfg;
> +	int bit = data->irq - OCTEON_IRQ_GPIO0;
> +	u32 t = irqd_get_trigger_type(data);
> +
> +	cfg.u64 = 0;
> +	cfg.s.int_en = 1;
> +	cfg.s.int_type = (t & (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING)) != 0;
> +	cfg.s.rx_xor = (t & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_EDGE_FALLING)) != 0;
> +
> +	/* 1 uS glitch filter*/
> +	cfg.s.fil_cnt = 7;
> +	cfg.s.fil_sel = 3;
> +
> +	cvmx_write_csr(CVMX_GPIO_BIT_CFGX(bit), cfg.u64);
> +}
> +
> +static void octeon_irq_ciu_enable_gpio_v2(struct irq_data *data)
> +{
> +	octeon_irq_gpio_setup(data);
> +	octeon_irq_ciu_enable_v2(data);
> +}
> +
> +static void octeon_irq_ciu_enable_gpio(struct irq_data *data)
> +{
> +	octeon_irq_gpio_setup(data);
> +	octeon_irq_ciu_enable(data);
> +}
> +
> +static int octeon_irq_ciu_gpio_set_type(struct irq_data *data, unsigned int t)
> +{
> +	u32 current_type = irqd_get_trigger_type(data);
> +
> +	/* If the type has been set, don't change it */
> +	if (current_type && current_type != t)
> +		return -EINVAL;
> +
> +	irqd_set_trigger_type(data, t);
> +	return IRQ_SET_MASK_OK;
> +}
> +
> +static void octeon_irq_ciu_disable_gpio_v2(struct irq_data *data)
> +{
> +	int bit = data->irq - OCTEON_IRQ_GPIO0;
> +	cvmx_write_csr(CVMX_GPIO_BIT_CFGX(bit), 0);
> +
> +	octeon_irq_ciu_disable_all_v2(data);
> +}
> +
> +static void octeon_irq_ciu_disable_gpio(struct irq_data *data)
> +{
> +	int bit = data->irq - OCTEON_IRQ_GPIO0;
> +	cvmx_write_csr(CVMX_GPIO_BIT_CFGX(bit), 0);
> +
> +	octeon_irq_ciu_disable_all(data);
> +}
> +
> +static void octeon_irq_ciu_gpio_ack(struct irq_data *data)
> +{
> +	int bit = data->irq - OCTEON_IRQ_GPIO0;
> +	u64 mask = 1ull << bit;
> +
> +	cvmx_write_csr(CVMX_GPIO_INT_CLR, mask);
> +}
> +
>  #ifdef CONFIG_SMP
>  
>  static void octeon_irq_cpu_offline_ciu(struct irq_data *data)
> @@ -717,6 +875,31 @@ static struct irq_chip octeon_irq_chip_ciu_mbox = {
>  	.flags = IRQCHIP_ONOFFLINE_ENABLED,
>  };
>  
> +static struct irq_chip octeon_irq_chip_ciu_gpio_v2 = {
> +	.name = "CIU-GPIO",
> +	.irq_enable = octeon_irq_ciu_enable_gpio_v2,
> +	.irq_disable = octeon_irq_ciu_disable_gpio_v2,
> +	.irq_ack = octeon_irq_ciu_gpio_ack,
> +	.irq_mask = octeon_irq_ciu_disable_local_v2,
> +	.irq_unmask = octeon_irq_ciu_enable_v2,
> +	.irq_set_type = octeon_irq_ciu_gpio_set_type,
> +#ifdef CONFIG_SMP
> +	.irq_set_affinity = octeon_irq_ciu_set_affinity_v2,
> +#endif
> +};
> +
> +static struct irq_chip octeon_irq_chip_ciu_gpio = {
> +	.name = "CIU-GPIO",
> +	.irq_enable = octeon_irq_ciu_enable_gpio,
> +	.irq_disable = octeon_irq_ciu_disable_gpio,
> +	.irq_mask = octeon_irq_dummy_mask,
> +	.irq_ack = octeon_irq_ciu_gpio_ack,
> +	.irq_set_type = octeon_irq_ciu_gpio_set_type,
> +#ifdef CONFIG_SMP
> +	.irq_set_affinity = octeon_irq_ciu_set_affinity,
> +#endif
> +};
> +
>  /*
>   * Watchdog interrupts are special.  They are associated with a single
>   * core, so we hardwire the affinity to that core.
> @@ -890,6 +1073,7 @@ static void __init octeon_irq_init_ciu(void)
>  	struct irq_chip *chip_edge;
>  	struct irq_chip *chip_mbox;
>  	struct irq_chip *chip_wd;
> +	struct irq_chip *chip_gpio;
>  
>  	octeon_irq_init_ciu_percpu();
>  	octeon_irq_setup_secondary = octeon_irq_setup_secondary_ciu;
> @@ -904,6 +1088,7 @@ static void __init octeon_irq_init_ciu(void)
>  		chip_edge = &octeon_irq_chip_ciu_edge_v2;
>  		chip_mbox = &octeon_irq_chip_ciu_mbox_v2;
>  		chip_wd = &octeon_irq_chip_ciu_wd_v2;
> +		chip_gpio = &octeon_irq_chip_ciu_gpio_v2;
>  	} else {
>  		octeon_irq_ip2 = octeon_irq_ip2_v1;
>  		octeon_irq_ip3 = octeon_irq_ip3_v1;
> @@ -911,6 +1096,7 @@ static void __init octeon_irq_init_ciu(void)
>  		chip_edge = &octeon_irq_chip_ciu_edge;
>  		chip_mbox = &octeon_irq_chip_ciu_mbox;
>  		chip_wd = &octeon_irq_chip_ciu_wd;
> +		chip_gpio = &octeon_irq_chip_ciu_gpio;
>  	}
>  	octeon_irq_ip4 = octeon_irq_ip4_mask;
>  
> @@ -921,7 +1107,7 @@ static void __init octeon_irq_init_ciu(void)
>  	for (i = 0; i < 16; i++)
>  		octeon_irq_set_ciu_mapping(i + OCTEON_IRQ_WORKQ0, 0, i + 0, chip, handle_level_irq);
>  	for (i = 0; i < 16; i++)
> -		octeon_irq_set_ciu_mapping(i + OCTEON_IRQ_GPIO0, 0, i + 16, chip, handle_level_irq);
> +		octeon_irq_set_ciu_mapping(i + OCTEON_IRQ_GPIO0, 0, i + 16, chip_gpio, handle_level_irq);
>  
>  	octeon_irq_set_ciu_mapping(OCTEON_IRQ_MBOX0, 0, 32, chip_mbox, handle_percpu_irq);
>  	octeon_irq_set_ciu_mapping(OCTEON_IRQ_MBOX1, 0, 33, chip_mbox, handle_percpu_irq);
