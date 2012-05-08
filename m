Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 May 2012 19:53:34 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:36894 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903636Ab2EHRx0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 May 2012 19:53:26 +0200
Received: by dadm1 with SMTP id m1so4575093dad.36
        for <linux-mips@linux-mips.org>; Tue, 08 May 2012 10:53:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:subject:to:cc:in-reply-to:references:date:message-id
         :x-gm-message-state;
        bh=YDG8f9yxMTq93A/2F1KIJlBNsc0Gl1MvdzmKp0eaOWE=;
        b=KoGq58py/IbFftupPqNEVO/oPvfJ2rSnfZULgOASQ80QoePzPswJ/iFySubRVfZi0n
         9SblV79K3XzdYD+9ks5xKx2GYq99zY2gqUDt9yvxA5VHJtjPQjz38qPDfjVl7cKbfsER
         pvdWKWgbT+y6A+wNdRQZjASMgTbggDiLk0ioAZOsrtzsWu6X4DUfXMnovwlQ+6+kafx8
         Yr7wE1teOQH5nbubJUYdyBcwhB0BwbqQPv80GbLphgr163MRxfgeHa3CuCoil4/16NHQ
         G8h+TjKL6sPeGzFOoEUiN7ytPzXym5tw0u5ABM9d6awW0LoT0akycj1X9Eq+CiCynk0V
         gMwg==
Received: by 10.68.203.225 with SMTP id kt1mr41474314pbc.133.1336499599993;
        Tue, 08 May 2012 10:53:19 -0700 (PDT)
Received: from localhost (S0106d8b37715ee14.cg.shawcable.net. [68.146.14.168])
        by mx.google.com with ESMTPS id sh10sm3050222pbc.48.2012.05.08.10.53.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 May 2012 10:53:18 -0700 (PDT)
Received: by localhost (Postfix, from userid 1000)
        id EA2113E05D0; Tue,  8 May 2012 11:53:16 -0600 (MDT)
From:   Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 03/14] OF: MIPS: lantiq: implement irq_domain support
To:     John Crispin <blogic@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, devicetree-discuss@lists.ozlabs.org
In-Reply-To: <1336133919-26525-3-git-send-email-blogic@openwrt.org>
References: <1336133919-26525-1-git-send-email-blogic@openwrt.org> <1336133919-26525-3-git-send-email-blogic@openwrt.org>
Date:   Tue, 08 May 2012 11:53:16 -0600
Message-Id: <20120508175316.EA2113E05D0@localhost>
X-Gm-Message-State: ALoCoQk+/LUMnWS/UR9XporUWt+3Eja+p3L5+7UxCgQDIzxM08/0CuUn9xDzZZ4mERBwqKlte/Fc
X-archive-position: 33219
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Fri,  4 May 2012 14:18:28 +0200, John Crispin <blogic@openwrt.org> wrote:
> Add support for irq_domain on lantiq socs. The conversion is straight forward
> as the ICU found inside the socs allows the usage of irq_domain_add_linear.
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>
> Cc: devicetree-discuss@lists.ozlabs.org
> ---
> This patch is part of a series moving the mips/lantiq target to OF and clkdev
> support. The patch, once Acked, should go upstream via Ralf's MIPS tree.

Yes, this looks like the right direction, but there is a pretty major
bug that needs to be delt with.  All of the irq ops need are still
using hardcoded (d->irq - INT_NUM_IRQ0) calculations to figure out the
irq number, but that doesn't work with the linear mapping.  The only
reason it's probably working right now is that the linear mapping uses
a 'hint' value to try and make the irq and the hwirq the same number,
but the hint feature is going to be removed soon.

All of the references to d->irq - INT_NUM_IRQ0 need to be replaced
with d->hwirq which the irq_domain manages for you.

You should probably also inspect the ltq_{startup,shutdown}_eiu_irq
functions to make sure they're also doing the right thing.

I could also complain about some cosmetic ugliness in the map
function, but that really isn't something I'm going to get upset over.

g.

> 
>  arch/mips/lantiq/irq.c |  120 +++++++++++++++++++++++++++---------------------
>  1 files changed, 68 insertions(+), 52 deletions(-)
> 
> diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
> index d227be1..170e6cb 100644
> --- a/arch/mips/lantiq/irq.c
> +++ b/arch/mips/lantiq/irq.c
> @@ -9,6 +9,11 @@
>  
>  #include <linux/interrupt.h>
>  #include <linux/ioport.h>
> +#include <linux/sched.h>
> +#include <linux/irqdomain.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
>  
>  #include <asm/bootinfo.h>
>  #include <asm/irq_cpu.h>
> @@ -16,7 +21,7 @@
>  #include <lantiq_soc.h>
>  #include <irq.h>
>  
> -/* register definitions */
> +/* register definitions - internal irqs */
>  #define LTQ_ICU_IM0_ISR		0x0000
>  #define LTQ_ICU_IM0_IER		0x0008
>  #define LTQ_ICU_IM0_IOSR	0x0010
> @@ -25,6 +30,7 @@
>  #define LTQ_ICU_IM1_ISR		0x0028
>  #define LTQ_ICU_OFFSET		(LTQ_ICU_IM1_ISR - LTQ_ICU_IM0_ISR)
>  
> +/* register definitions - external irqs */
>  #define LTQ_EIU_EXIN_C		0x0000
>  #define LTQ_EIU_EXIN_INIC	0x0004
>  #define LTQ_EIU_EXIN_INEN	0x000C
> @@ -37,13 +43,13 @@
>  #define LTQ_EIU_IR4		(INT_NUM_IM1_IRL0 + 1)
>  #define LTQ_EIU_IR5		(INT_NUM_IM1_IRL0 + 2)
>  #define LTQ_EIU_IR6		(INT_NUM_IM2_IRL0 + 30)
> -
>  #define MAX_EIU			6
>  
>  /* the performance counter */
>  #define LTQ_PERF_IRQ		(INT_NUM_IM4_IRL0 + 31)
>  
> -/* irqs generated by device attached to the EBU need to be acked in
> +/*
> + * irqs generated by devices attached to the EBU need to be acked in
>   * a special manner
>   */
>  #define LTQ_ICU_EBU_IRQ		22
> @@ -71,20 +77,6 @@ static unsigned short ltq_eiu_irq[MAX_EIU] = {
>  	LTQ_EIU_IR5,
>  };
>  
> -static struct resource ltq_icu_resource = {
> -	.name	= "icu",
> -	.start	= LTQ_ICU_BASE_ADDR,
> -	.end	= LTQ_ICU_BASE_ADDR + LTQ_ICU_SIZE - 1,
> -	.flags	= IORESOURCE_MEM,
> -};
> -
> -static struct resource ltq_eiu_resource = {
> -	.name	= "eiu",
> -	.start	= LTQ_EIU_BASE_ADDR,
> -	.end	= LTQ_EIU_BASE_ADDR + LTQ_ICU_SIZE - 1,
> -	.flags	= IORESOURCE_MEM,
> -};
> -
>  static void __iomem *ltq_icu_membase;
>  static void __iomem *ltq_eiu_membase;
>  
> @@ -199,14 +191,15 @@ static void ltq_hw_irqdispatch(int module)
>  	if (irq == 0)
>  		return;
>  
> -	/* silicon bug causes only the msb set to 1 to be valid. all
> +	/*
> +	 * silicon bug causes only the msb set to 1 to be valid. all
>  	 * other bits might be bogus
>  	 */
>  	irq = __fls(irq);
>  	do_IRQ((int)irq + INT_NUM_IM0_IRL0 + (INT_NUM_IM_OFFSET * module));
>  
>  	/* if this is a EBU irq, we need to ack it or get a deadlock */
> -	if ((irq == LTQ_ICU_EBU_IRQ) && (module == 0))
> +	if ((irq == LTQ_ICU_EBU_IRQ) && (module == 0) && LTQ_EBU_PCC_ISTAT)
>  		ltq_ebu_w32(ltq_ebu_r32(LTQ_EBU_PCC_ISTAT) | 0x10,
>  			LTQ_EBU_PCC_ISTAT);
>  }
> @@ -290,38 +283,62 @@ out:
>  	return;
>  }
>  
> +static int icu_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
> +{
> +	if (((irq == LTQ_EIU_IR0) || (irq == LTQ_EIU_IR1) ||
> +			(irq == LTQ_EIU_IR2)) && ltq_eiu_membase)
> +		irq_set_chip_and_handler(irq, &ltq_eiu_type, handle_level_irq);
> +	/* EIU3-5 only exist on ar9 and vr9 */
> +	else if (((irq == LTQ_EIU_IR3) || (irq == LTQ_EIU_IR4) ||
> +			(irq == LTQ_EIU_IR5)) &&
> +			(of_machine_is_compatible("lantiq,ar9") ||
> +				of_machine_is_compatible("lantiq,vr9")) &&
> +			ltq_eiu_membase)
> +		irq_set_chip_and_handler(irq, &ltq_eiu_type, handle_level_irq);
> +	else
> +		irq_set_chip_and_handler(irq, &ltq_irq_type, handle_level_irq);
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops irq_domain_ops = {
> +	.xlate = irq_domain_xlate_onetwocell,
> +	.map = icu_map,
> +};
> +
>  static struct irqaction cascade = {
>  	.handler = no_action,
>  	.name = "cascade",
>  };
>  
> -void __init arch_init_irq(void)
> +int __init icu_of_init(struct device_node *node, struct device_node *parent)
>  {
> +	struct device_node *eiu_node;
> +	struct resource res;
>  	int i;
>  
> -	if (insert_resource(&iomem_resource, &ltq_icu_resource) < 0)
> -		panic("Failed to insert icu memory");
> +	if (of_address_to_resource(node, 0, &res))
> +		panic("Failed to get icu memory range");
>  
> -	if (request_mem_region(ltq_icu_resource.start,
> -			resource_size(&ltq_icu_resource), "icu") < 0)
> -		panic("Failed to request icu memory");
> +	if (request_mem_region(res.start, resource_size(&res), res.name) < 0)
> +		pr_err("Failed to request icu memory");
>  
> -	ltq_icu_membase = ioremap_nocache(ltq_icu_resource.start,
> -				resource_size(&ltq_icu_resource));
> +	ltq_icu_membase = ioremap_nocache(res.start, resource_size(&res));
>  	if (!ltq_icu_membase)
>  		panic("Failed to remap icu memory");
>  
> -	if (insert_resource(&iomem_resource, &ltq_eiu_resource) < 0)
> -		panic("Failed to insert eiu memory");
> -
> -	if (request_mem_region(ltq_eiu_resource.start,
> -			resource_size(&ltq_eiu_resource), "eiu") < 0)
> -		panic("Failed to request eiu memory");
> -
> -	ltq_eiu_membase = ioremap_nocache(ltq_eiu_resource.start,
> -				resource_size(&ltq_eiu_resource));
> -	if (!ltq_eiu_membase)
> -		panic("Failed to remap eiu memory");
> +	/* the external interrupts are optional and xway only */
> +	eiu_node = of_find_compatible_node(NULL, NULL, "lantiq,eiu");
> +	if (eiu_node && of_address_to_resource(eiu_node, 0, &res)) {
> +		if (request_mem_region(res.start, resource_size(&res),
> +							res.name) < 0)
> +			pr_err("Failed to request eiu memory");
> +
> +		ltq_eiu_membase = ioremap_nocache(res.start,
> +							resource_size(&res));
> +		if (!ltq_eiu_membase)
> +			panic("Failed to remap eiu memory");
> +	}
>  
>  	/* turn off all irqs by default */
>  	for (i = 0; i < 5; i++) {
> @@ -346,20 +363,8 @@ void __init arch_init_irq(void)
>  		set_vi_handler(7, ltq_hw5_irqdispatch);
>  	}
>  
> -	for (i = INT_NUM_IRQ0;
> -		i <= (INT_NUM_IRQ0 + (5 * INT_NUM_IM_OFFSET)); i++)
> -		if ((i == LTQ_EIU_IR0) || (i == LTQ_EIU_IR1) ||
> -			(i == LTQ_EIU_IR2))
> -			irq_set_chip_and_handler(i, &ltq_eiu_type,
> -				handle_level_irq);
> -		/* EIU3-5 only exist on ar9 and vr9 */
> -		else if (((i == LTQ_EIU_IR3) || (i == LTQ_EIU_IR4) ||
> -			(i == LTQ_EIU_IR5)) && (ltq_is_ar9() || ltq_is_vr9()))
> -			irq_set_chip_and_handler(i, &ltq_eiu_type,
> -				handle_level_irq);
> -		else
> -			irq_set_chip_and_handler(i, &ltq_irq_type,
> -				handle_level_irq);
> +	irq_domain_add_linear(node, 6 * INT_NUM_IM_OFFSET,
> +		&irq_domain_ops, 0);
>  
>  #if defined(CONFIG_MIPS_MT_SMP)
>  	if (cpu_has_vint) {
> @@ -382,9 +387,20 @@ void __init arch_init_irq(void)
>  
>  	/* tell oprofile which irq to use */
>  	cp0_perfcount_irq = LTQ_PERF_IRQ;
> +	return 0;
>  }
>  
>  unsigned int __cpuinit get_c0_compare_int(void)
>  {
>  	return CP0_LEGACY_COMPARE_IRQ;
>  }
> +
> +static struct of_device_id __initdata of_irq_ids[] = {
> +	{ .compatible = "lantiq,icu", .data = icu_of_init },
> +	{},
> +};
> +
> +void __init arch_init_irq(void)
> +{
> +	of_irq_init(of_irq_ids);
> +}
> -- 
> 1.7.9.1
> 
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
