Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Nov 2017 12:59:16 +0100 (CET)
Received: from foss.arm.com ([217.140.101.70]:53272 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991869AbdKGL7ImOMZ7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 7 Nov 2017 12:59:08 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7773814;
        Tue,  7 Nov 2017 03:59:01 -0800 (PST)
Received: from [10.1.207.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D6E43F220;
        Tue,  7 Nov 2017 03:58:58 -0800 (PST)
Subject: Re: [PATCH v8 2/5] irqchip/irq-goldfish-pic: Add Goldfish PIC driver
To:     Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
        linux-mips@linux-mips.org
Cc:     Miodrag Dinic <miodrag.dinic@mips.com>,
        Goran Ferenc <goran.ferenc@mips.com>,
        Aleksandar Markovic <aleksandar.markovic@mips.com>,
        "David S. Miller" <davem@davemloft.net>,
        Douglas Leung <douglas.leung@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Hogan <james.hogan@mips.com>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Paul Burton <paul.burton@mips.com>,
        Petar Jovanovic <petar.jovanovic@mips.com>,
        Raghu Gandham <raghu.gandham@mips.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <1509729730-26621-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1509729730-26621-3-git-send-email-aleksandar.markovic@rt-rk.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <b2ac2511-83ea-e5b3-34af-0b82838211b9@arm.com>
Date:   Tue, 7 Nov 2017 11:58:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <1509729730-26621-3-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Return-Path: <marc.zyngier@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60739
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

On 03/11/17 17:21, Aleksandar Markovic wrote:
> From: Miodrag Dinic <miodrag.dinic@mips.com>
> 
> Add device driver for a virtual programmable interrupt controller
> 
> The virtual PIC is designed as a device tree-based interrupt controller.
> 
> The compatible string used by OS for binding the driver is
> "google,goldfish-pic".
> 
> Signed-off-by: Miodrag Dinic <miodrag.dinic@mips.com>
> Signed-off-by: Goran Ferenc <goran.ferenc@mips.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
> ---
>  MAINTAINERS                        |   1 +
>  drivers/irqchip/Kconfig            |   8 +++
>  drivers/irqchip/Makefile           |   1 +
>  drivers/irqchip/irq-goldfish-pic.c | 136 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 146 insertions(+)
>  create mode 100644 drivers/irqchip/irq-goldfish-pic.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 47f0b95..1bf5587 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -876,6 +876,7 @@ ANDROID GOLDFISH PIC DRIVER
>  M:	Miodrag Dinic <miodrag.dinic@mips.com>
>  S:	Supported
>  F:	Documentation/devicetree/bindings/interrupt-controller/google,goldfish-pic.txt
> +F:	drivers/irqchip/irq-goldfish-pic.c
>  
>  ANDROID GOLDFISH RTC DRIVER
>  M:	Miodrag Dinic <miodrag.dinic@mips.com>
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index 9d8a1dd..712b561 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -321,3 +321,11 @@ config IRQ_UNIPHIER_AIDET
>  	select IRQ_DOMAIN_HIERARCHY
>  	help
>  	  Support for the UniPhier AIDET (ARM Interrupt Detector).
> +
> +config GOLDFISH_PIC
> +	bool "Goldfish programmable interrupt controller"
> +	depends on MIPS && (GOLDFISH || COMPILE_TEST)
> +	select IRQ_DOMAIN
> +	help
> +	  Say yes here to enable Goldfish interrupt controller driver used
> +	  for Goldfish based virtual platforms.
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index 845abc1..0e7a224 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -79,3 +79,4 @@ obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o irq-aspeed-i2c-ic.o
>  obj-$(CONFIG_STM32_EXTI) 		+= irq-stm32-exti.o
>  obj-$(CONFIG_QCOM_IRQ_COMBINER)		+= qcom-irq-combiner.o
>  obj-$(CONFIG_IRQ_UNIPHIER_AIDET)	+= irq-uniphier-aidet.o
> +obj-$(CONFIG_GOLDFISH_PIC) 		+= irq-goldfish-pic.o
> diff --git a/drivers/irqchip/irq-goldfish-pic.c b/drivers/irqchip/irq-goldfish-pic.c
> new file mode 100644
> index 0000000..6e17ce6
> --- /dev/null
> +++ b/drivers/irqchip/irq-goldfish-pic.c
> @@ -0,0 +1,136 @@
> +/*
> + * Driver for MIPS Goldfish Programmable Interrupt Controller.
> + *
> + * Author: Miodrag Dinic <miodrag.dinic@mips.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License, or (at your
> + * option) any later version.
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/irqchip.h>
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +
> +#define GFPIC_NR_IRQS			32
> +
> +/* 8..39 Cascaded Goldfish PIC interrupts */
> +#define GFPIC_IRQ_BASE			8
> +
> +#define GFPIC_REG_IRQ_PENDING		0x04
> +#define GFPIC_REG_IRQ_DISABLE_ALL	0x08
> +#define GFPIC_REG_IRQ_DISABLE		0x0c
> +#define GFPIC_REG_IRQ_ENABLE		0x10
> +
> +struct goldfish_pic_data {
> +	void __iomem *base;
> +	struct irq_domain *irq_domain;
> +};
> +
> +static void goldfish_pic_cascade(struct irq_desc *desc)
> +{
> +	struct goldfish_pic_data *gfpic = irq_desc_get_handler_data(desc);
> +	struct irq_chip *host_chip = irq_desc_get_chip(desc);
> +	u32 pending, hwirq, virq;
> +
> +	chained_irq_enter(host_chip, desc);
> +
> +	pending = readl(gfpic->base + GFPIC_REG_IRQ_PENDING);
> +	while (pending) {
> +		hwirq = __fls(pending);
> +		virq = irq_linear_revmap(gfpic->irq_domain, hwirq);
> +		generic_handle_irq(virq);
> +		pending &= ~(1 << hwirq);
> +	}
> +
> +	chained_irq_exit(host_chip, desc);
> +}
> +
> +static const struct irq_domain_ops goldfish_irq_domain_ops = {
> +	.xlate = irq_domain_xlate_onecell,
> +};
> +
> +static int __init goldfish_pic_of_init(struct device_node *of_node,
> +				       struct device_node *parent)
> +{
> +	struct goldfish_pic_data *gfpic;
> +	struct irq_chip_generic *gc;
> +	struct irq_chip_type *ct;
> +	unsigned int parent_irq;
> +	int ret = 0;
> +
> +	gfpic = kzalloc(sizeof(*gfpic), GFP_KERNEL);
> +	if (!gfpic) {
> +		ret = -ENOMEM;
> +		goto out_err;
> +	}
> +
> +	parent_irq = irq_of_parse_and_map(of_node, 0);
> +	if (!parent_irq) {
> +		pr_err("Failed to map parent IRQ!");
> +		ret = -EINVAL;
> +		goto out_free;
> +	}
> +
> +	gfpic->base = of_iomap(of_node, 0);
> +	if (!gfpic->base) {
> +		pr_err("Failed to map base address!");
> +		ret = -ENOMEM;
> +		goto out_unmap_irq;
> +	}
> +
> +	/* Mask interrupts. */
> +	writel(1, gfpic->base + GFPIC_REG_IRQ_DISABLE_ALL);
> +
> +	gc = irq_alloc_generic_chip("GFPIC", 1, GFPIC_IRQ_BASE, gfpic->base,
> +				    handle_level_irq);
> +	if (!gc) {
> +		pr_err("Failed to allocate chip structures!");
> +		ret = -ENOMEM;
> +		goto out_unmap_irq;
> +	}
> +
> +	ct = gc->chip_types;
> +	ct->regs.enable = GFPIC_REG_IRQ_ENABLE;
> +	ct->regs.disable = GFPIC_REG_IRQ_DISABLE;
> +	ct->chip.irq_unmask = irq_gc_unmask_enable_reg;
> +	ct->chip.irq_mask = irq_gc_mask_disable_reg;
> +
> +	irq_setup_generic_chip(gc, IRQ_MSK(GFPIC_NR_IRQS), 0, 0,
> +			       IRQ_NOPROBE | IRQ_LEVEL);
> +
> +	gfpic->irq_domain = irq_domain_add_legacy(of_node, GFPIC_NR_IRQS,
> +						  GFPIC_IRQ_BASE, 0,
> +						  &goldfish_irq_domain_ops,
> +						  NULL);
> +	if (!gfpic->irq_domain) {
> +		pr_err("Failed to add irqdomain!");
> +		ret = -EINVAL;

Why -EINVAL? All the other allocation failures return -ENOMEM... And
where is the freeing of "gc" done on error?

These are really trivial mistakes, and I wish you'd spend a bit more
time looking at these details...

> +		goto out_iounmap;
> +	}
> +
> +	irq_set_chained_handler_and_data(parent_irq,
> +					 goldfish_pic_cascade, gfpic);
> +
> +	pr_info("Successfully registered.");
> +	return 0;
> +
> +out_iounmap:
> +	iounmap(gfpic->base);
> +out_unmap_irq:
> +	irq_dispose_mapping(parent_irq);
> +out_free:
> +	kfree(gfpic);
> +out_err:
> +	pr_err("Failed to initialize! (errno = %d)", ret);
> +	return ret;
> +}
> +
> +IRQCHIP_DECLARE(google_gf_pic, "google,goldfish-pic", goldfish_pic_of_init);
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
