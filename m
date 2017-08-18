Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Aug 2017 15:54:20 +0200 (CEST)
Received: from foss.arm.com ([217.140.101.70]:39646 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994906AbdHRNyDBS5OK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 18 Aug 2017 15:54:03 +0200
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97E2715A2;
        Fri, 18 Aug 2017 06:53:54 -0700 (PDT)
Received: from [10.1.207.16] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD9A53F483;
        Fri, 18 Aug 2017 06:53:50 -0700 (PDT)
Subject: Re: [PATCH v4 4/8] irqchip/irq-goldfish-pic: Add Goldfish PIC driver
To:     Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
        linux-mips@linux-mips.org
Cc:     Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        Bo Hu <bohu@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Douglas Leung <douglas.leung@imgtec.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Hogan <james.hogan@imgtec.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Jin Qian <jinqian@google.com>, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <1503061833-26563-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1503061833-26563-5-git-send-email-aleksandar.markovic@rt-rk.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <f701df56-ceff-7da8-7c0e-1bf2a2853512@arm.com>
Date:   Fri, 18 Aug 2017 14:53:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1503061833-26563-5-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Return-Path: <marc.zyngier@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59664
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marc.zyngier@arm.com
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

On 18/08/17 14:08, Aleksandar Markovic wrote:
> From: Miodrag Dinic <miodrag.dinic@imgtec.com>
> 
> Add device driver for a virtual programmable interrupt controller
> 
> The virtual PIC is designed as a device tree-based interrupt controller.
> 
> The compatible string used by OS for binding the driver is
> "google,goldfish-pic".
> 
> Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
> Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
> ---
>  MAINTAINERS                        |   1 +
>  drivers/irqchip/Kconfig            |   8 ++
>  drivers/irqchip/Makefile           |   1 +
>  drivers/irqchip/irq-goldfish-pic.c | 145 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 155 insertions(+)
>  create mode 100644 drivers/irqchip/irq-goldfish-pic.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 013da1d..6426875 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -844,6 +844,7 @@ ANDROID GOLDFISH PIC DRIVER
>  M:	Miodrag Dinic <miodrag.dinic@imgtec.com>
>  S:	Supported
>  F:	Documentation/devicetree/bindings/interrupt-controller/google,goldfish-pic.txt
> +F:	drivers/irqchip/irq-goldfish-pic.c
>  
>  ANDROID GOLDFISH RTC DRIVER
>  M:	Miodrag Dinic <miodrag.dinic@imgtec.com>
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index f1fd5f4..21fab14 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -306,3 +306,11 @@ config QCOM_IRQ_COMBINER
>  	help
>  	  Say yes here to add support for the IRQ combiner devices embedded
>  	  in Qualcomm Technologies chips.
> +
> +config GOLDFISH_PIC
> +	bool "Goldfish programmable interrupt controller"
> +	depends on MIPS && (GOLDFISH || COMPILE_TEST)
> +	select IRQ_DOMAIN
> +	help
> +	  Say yes here to enable Goldfish interrupt controller driver used
> +	  for Goldfish based virtual platforms.
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index e88d856..ade04a1 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -78,3 +78,4 @@ obj-$(CONFIG_EZNPS_GIC)			+= irq-eznps.o
>  obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o irq-aspeed-i2c-ic.o
>  obj-$(CONFIG_STM32_EXTI) 		+= irq-stm32-exti.o
>  obj-$(CONFIG_QCOM_IRQ_COMBINER)		+= qcom-irq-combiner.o
> +obj-$(CONFIG_GOLDFISH_PIC) 		+= irq-goldfish-pic.o
> diff --git a/drivers/irqchip/irq-goldfish-pic.c b/drivers/irqchip/irq-goldfish-pic.c
> new file mode 100644
> index 0000000..948c35e
> --- /dev/null
> +++ b/drivers/irqchip/irq-goldfish-pic.c
> @@ -0,0 +1,145 @@
> +/*
> + * Copyright (C) 2017 Imagination Technologies Ltd.	All rights reserved
> + *	Author: Miodrag Dinic <miodrag.dinic@imgtec.com>
> + *
> + * This file implements interrupt controller driver for MIPS Goldfish PIC.
> + *
> + * This program is free software; you can redistribute	it and/or modify it
> + * under  the terms of	the GNU General	 Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/irq.h>
> +#include <linux/irqchip.h>
> +#include <linux/irqdomain.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +
> +#include <asm/setup.h>
> +
> +/* 0..7 MIPS CPU interrupts */
> +#define GF_CPU_IRQ_PIC		(MIPS_CPU_IRQ_BASE + 2)
> +#define GF_CPU_IRQ_COMPARE	(MIPS_CPU_IRQ_BASE + 7)
> +
> +#define GF_NR_IRQS		40
> +/* 8..39 Cascaded Goldfish PIC interrupts */
> +#define GF_IRQ_OFFSET		8
> +
> +#define GF_PIC_NUMBER		0x04
> +#define GF_PIC_DISABLE_ALL	0x08
> +#define GF_PIC_DISABLE		0x0c
> +#define GF_PIC_ENABLE		0x10
> +
> +static struct irq_domain *irq_domain;
> +static void __iomem *gf_pic_base;
> +
> +static inline void unmask_goldfish_irq(struct irq_data *d)
> +{
> +	writel(d->hwirq - GF_IRQ_OFFSET,
> +	       gf_pic_base + GF_PIC_ENABLE);
> +	irq_enable_hazard();
> +}
> +
> +static inline void mask_goldfish_irq(struct irq_data *d)
> +{
> +	writel(d->hwirq - GF_IRQ_OFFSET,
> +	       gf_pic_base + GF_PIC_DISABLE);
> +	irq_disable_hazard();
> +}
> +
> +static struct irq_chip goldfish_irq_controller = {
> +	.name		= "Goldfish PIC",
> +	.irq_ack	= mask_goldfish_irq,

I'm slightly puzzled.

> +	.irq_mask	= mask_goldfish_irq,
> +	.irq_mask_ack	= mask_goldfish_irq,

What does it mean to have irq_mask_ack implemented as mask?

> +	.irq_unmask	= unmask_goldfish_irq,
> +	.irq_eoi	= unmask_goldfish_irq,

Really? Are you joking?

> +	.irq_disable	= mask_goldfish_irq,
> +	.irq_enable	= unmask_goldfish_irq,

If enable/disable are the same as mask/unmask, you don't need separate
entry points.

> +};
> +
> +static void goldfish_irq_dispatch(void)
> +{
> +	u32 irq;
> +	u32 virq;
> +
> +	irq = readl(gf_pic_base + GF_PIC_NUMBER);
> +	if (irq == 0) {
> +		/* Timer interrupt */
> +		do_IRQ(GF_CPU_IRQ_COMPARE);
> +		return;
> +	}

Why isn't this indirected through the irqdomain just like the rest?

> +
> +	virq = irq_linear_revmap(irq_domain, irq);
> +	virq += GF_IRQ_OFFSET;


?????? Why do you have to add an offset here? The whole point of an
irqdomain is to convert a hwirq to an irq. If you need to adjust it, it
means you're doing something completely wrong the first place.

> +	do_IRQ(virq);
> +}
> +
> +static void goldfish_ip2_irq_dispatch(struct irq_desc *desc)
> +{
> +	unsigned long pending = read_c0_cause() & read_c0_status() & ST0_IM;
> +
> +	if (pending & CAUSEF_IP2)
> +		goldfish_irq_dispatch();
> +	else
> +		spurious_interrupt();

chained_irq_enter/exit when this is a chained interrupt handler?

> +}
> +
> +static int goldfish_pic_map(struct irq_domain *d, unsigned int irq,
> +			    irq_hw_number_t hw)
> +{
> +	if (cpu_has_vint)
> +		set_vi_handler(hw, goldfish_irq_dispatch);
> +
> +	irq_set_chip_and_handler(irq, &goldfish_irq_controller,
> +				 handle_level_irq);
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops gf_pic_irq_domain_ops = {
> +	.map = goldfish_pic_map,
> +	.xlate = irq_domain_xlate_onetwocell,

Why "twocell"? You only seem to handle level interrupts, so one single
cell should be enough, right? That's even the way you document it in the
DT...

> +};
> +
> +static struct irqaction cascade = {
> +	.handler	= no_action,
> +	.flags		= IRQF_PROBE_SHARED,
> +	.name		= "cascade",
> +};
> +
> +static void __init __goldfish_pic_init(struct device_node *of_node)

Why this __ prefix?

> +{
> +	gf_pic_base = of_iomap(of_node, 0);
> +	if (!gf_pic_base)
> +		panic("Failed to map Goldfish PIC base : No such device!");

No such device? Or more accurately out of space to do the IO mapping?

> +
> +	/* Mask interrupts. */
> +	writel(1, gf_pic_base + GF_PIC_DISABLE_ALL);
> +
> +	if (!cpu_has_vint)
> +		irq_set_chained_handler(GF_CPU_IRQ_PIC,
> +					goldfish_ip2_irq_dispatch);
> +
> +	setup_irq(GF_CPU_IRQ_PIC, &cascade);
> +
> +	irq_domain = irq_domain_add_legacy(of_node, GF_NR_IRQS,
> +					   GF_IRQ_OFFSET, 0,
> +					   &gf_pic_irq_domain_ops, NULL);
> +	if (!irq_domain)
> +		panic("Failed to add irqdomain for Goldfish PIC");
> +}
> +
> +int __init goldfish_pic_of_init(struct device_node *of_node,
> +				struct device_node *parent)

Why isn't it static?

> +{
> +	__goldfish_pic_init(of_node);

Why do we need to indirect it at all?

> +	return 0;
> +}
> +
> +IRQCHIP_DECLARE(google_gf_pic, "google,goldfish-pic", goldfish_pic_of_init);
> +
> 

Really, this is not any better than the initial version. You clearly
have not tried to understand the requirements for an interrupt
controller with respect to the flows it uses. Also, the use of the
irqdomain is completely backward.

	M.
-- 
Jazz is not dead. It just smells funny...
