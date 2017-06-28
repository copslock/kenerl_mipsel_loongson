Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jun 2017 19:33:54 +0200 (CEST)
Received: from foss.arm.com ([217.140.101.70]:50848 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993975AbdF1RdrORjfZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Jun 2017 19:33:47 +0200
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B0BC344;
        Wed, 28 Jun 2017 10:33:40 -0700 (PDT)
Received: from [10.1.207.16] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B54B3F41F;
        Wed, 28 Jun 2017 10:33:37 -0700 (PDT)
Subject: Re: [PATCH v2 04/10] MIPS: ranchu: Add Goldfish PIC driver
To:     Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
        linux-mips@linux-mips.org
References: <1498664922-28493-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1498664922-28493-5-git-send-email-aleksandar.markovic@rt-rk.com>
Cc:     Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        "David S. Miller" <davem@davemloft.net>,
        Douglas Leung <douglas.leung@imgtec.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Hogan <james.hogan@imgtec.com>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <2b0374aa-ca59-8f9e-7ddd-08ddf8631b02@arm.com>
Date:   Wed, 28 Jun 2017 18:33:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <1498664922-28493-5-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <marc.zyngier@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58886
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

On 28/06/17 16:46, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
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
>  drivers/irqchip/Kconfig            |   9 ++
>  drivers/irqchip/Makefile           |   1 +
>  drivers/irqchip/irq-goldfish-pic.c | 169 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 180 insertions(+)
>  create mode 100644 drivers/irqchip/irq-goldfish-pic.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 85da9f0..fb4c6ea 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -845,6 +845,7 @@ ANDROID GOLDFISH PIC DRIVER
>  M:	Miodrag Dinic <miodrag.dinic@imgtec.com>
>  S:	Supported
>  F:	Documentation/devicetree/bindings/interrupt-controller/google,goldfish-pic.txt
> +F:	drivers/irqchip/irq-goldfish-pic.c
>  
>  ANDROID GOLDFISH RTC DRIVER
>  M:	Miodrag Dinic <miodrag.dinic@imgtec.com>
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index 478f8ac..6c2f924 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -301,3 +301,12 @@ config QCOM_IRQ_COMBINER
>  	help
>  	  Say yes here to add support for the IRQ combiner devices embedded
>  	  in Qualcomm Technologies chips.
> +
> +config GOLDFISH_PIC
> +	bool "Goldfish programmable interrupt controller"
> +	depends on MIPS
> +	depends on GOLDFISH
> +	select IRQ_DOMAIN
> +	help
> +	  Say yes here to enable Goldfish interrupt controller driver used
> +	  for Goldfish based virtual platforms.
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index b64c59b..5e73932 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -76,3 +76,4 @@ obj-$(CONFIG_EZNPS_GIC)			+= irq-eznps.o
>  obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o
>  obj-$(CONFIG_STM32_EXTI) 		+= irq-stm32-exti.o
>  obj-$(CONFIG_QCOM_IRQ_COMBINER)		+= qcom-irq-combiner.o
> +obj-$(CONFIG_GOLDFISH_PIC) 		+= irq-goldfish-pic.o
> diff --git a/drivers/irqchip/irq-goldfish-pic.c b/drivers/irqchip/irq-goldfish-pic.c
> new file mode 100644
> index 0000000..d0e4c2d
> --- /dev/null
> +++ b/drivers/irqchip/irq-goldfish-pic.c
> @@ -0,0 +1,169 @@
> +/* drivers/irqchip/irq-goldfish-pic.c
> + *
> + * Copyright (C) 2007 Google, Inc.
> + * Copyright (C) 2017 Imagination Technologies Ltd.
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/irqchip.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +
> +#include <asm/setup.h>
> +
> +/* 0..7 MIPS CPU interrupts */
> +#define GOLDFISH_CPU_IRQ_PIC		(MIPS_CPU_IRQ_BASE + 2)
> +#define GOLDFISH_CPU_IRQ_FIQ		(MIPS_CPU_IRQ_BASE + 3) /* Not used? */
> +#define GOLDFISH_CPU_IRQ_COMPARE	(MIPS_CPU_IRQ_BASE + 7)
> +
> +#define GOLDFISH_NR_IRQS		40
> +/* 8..39 Cascaded Goldfish PIC interrupts */
> +#define GOLDFISH_IRQ_OFFSET		8
> +
> +#define GOLDFISH_PIC_NUMBER		0x04
> +#define GOLDFISH_PIC_DISABLE_ALL	0x08
> +#define GOLDFISH_PIC_DISABLE		0x0c
> +#define GOLDFISH_PIC_ENABLE		0x10
> +
> +static struct irq_domain *goldfish_pic_domain;
> +static void __iomem *goldfish_pic_base;
> +
> +void goldfish_mask_irq(struct irq_data *d)
> +{
> +	writel(d->irq - GOLDFISH_IRQ_OFFSET,
> +	       goldfish_pic_base + GOLDFISH_PIC_DISABLE);

This makes exactly zero sense. You're using the Linux irq, which is just
a random number, and write that to the HW?

> +}
> +
> +void goldfish_unmask_irq(struct irq_data *d)
> +{
> +	writel(d->irq - GOLDFISH_IRQ_OFFSET,
> +	       goldfish_pic_base + GOLDFISH_PIC_ENABLE);
> +}
> +
> +static struct irq_chip goldfish_irq_chip = {
> +	.name	= "goldfish",
> +	.irq_mask	= goldfish_mask_irq,
> +	.irq_mask_ack	= goldfish_mask_irq,
> +	.irq_unmask	= goldfish_unmask_irq,
> +};
> +
> +void goldfish_irq_dispatch(void)
> +{
> +	uint32_t irq;
> +
> +	/*
> +	 * Disable all interrupt sources
> +	 */
> +	irq = readl(goldfish_pic_base + GOLDFISH_PIC_NUMBER);
> +	do_IRQ(GOLDFISH_IRQ_OFFSET + irq);
> +}
> +
> +void goldfish_fiq_dispatch(void)
> +{
> +	panic("goldfish_fiq_dispatch");
> +}
> +
> +static void goldfish_ip2_irq_dispatch(struct irq_desc *desc)
> +{
> +	unsigned int pending = read_c0_cause() & read_c0_status() & ST0_IM;
> +
> +	if (pending & CAUSEF_IP2)
> +		goldfish_irq_dispatch();
> +	else if (pending & CAUSEF_IP3)
> +		goldfish_fiq_dispatch();
> +	else if (pending & CAUSEF_IP7)
> +		do_IRQ(MIPS_CPU_IRQ_BASE + 7);
> +	else
> +		spurious_interrupt();
> +}
> +
> +static struct irqaction cascade = {
> +	.handler	= no_action,
> +	.flags		= IRQF_NO_THREAD,
> +	.name		= "cascade",
> +};
> +
> +static void mips_timer_dispatch(void)
> +{
> +	do_IRQ(MIPS_CPU_IRQ_BASE + GOLDFISH_CPU_IRQ_COMPARE);
> +}
> +
> +static int goldfish_pic_map(struct irq_domain *d, unsigned int irq,
> +				irq_hw_number_t hw)
> +{
> +	struct irq_chip *chip = &goldfish_irq_chip;
> +
> +	if (hw < GOLDFISH_IRQ_OFFSET)
> +		return 0;
> +
> +	irq_set_chip_and_handler(hw, chip, handle_level_irq);

Ah, right. No. Really. You're completely confusing irq and hwirq. You
really have to chose: either your system is DT driven, and you
completely disassociate irq and hwirq (that's what the irq domain is
for), or it is the same thing, and there is no irq domain (and no DT
either).

As it stands, this looks like a driver that has been DT-ified in a
hurry, without actually trying to make it fit in.

> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops irq_domain_ops = {
> +	.xlate = irq_domain_xlate_onetwocell,
> +	.map = goldfish_pic_map,
> +};
> +
> +int __init goldfish_pic_of_init(struct device_node *node,
> +				struct device_node *parent)
> +{
> +	struct resource res;
> +
> +	if (of_address_to_resource(node, 0, &res)) {
> +		pr_err("%s(): Failed to get icu memory range", __func__);
> +		return -ENODEV;
> +	}
> +
> +	if (request_mem_region(res.start, resource_size(&res),
> +				res.name) < 0) {
> +		pr_err("%s(): Failed to request icu memory", __func__);
> +		return -ENOMEM;
> +	}
> +
> +	goldfish_pic_base = ioremap_nocache(res.start, resource_size(&res));

All of the above should replaced by a single of_iomap.

> +	if (!goldfish_pic_base) {
> +		pr_err("%s(): Failed to remap icu memory", __func__);
> +		release_mem_region(res.start, resource_size(&res));
> +		return -ENOMEM;
> +	}
> +
> +	/*
> +	 * Disable all interrupt sources
> +	 */
> +	writel(1, goldfish_pic_base + GOLDFISH_PIC_DISABLE_ALL);
> +
> +	if (cpu_has_vint) {
> +		pr_info("Setting up vectored interrupts\n");
> +		set_vi_handler(GOLDFISH_CPU_IRQ_PIC, goldfish_irq_dispatch);
> +		set_vi_handler(GOLDFISH_CPU_IRQ_FIQ, goldfish_fiq_dispatch);
> +		set_vi_handler(GOLDFISH_CPU_IRQ_COMPARE, mips_timer_dispatch);
> +	} else {
> +		irq_set_chained_handler(GOLDFISH_CPU_IRQ_PIC,
> +				goldfish_ip2_irq_dispatch);
> +	}
> +
> +	setup_irq(MIPS_CPU_IRQ_BASE+GOLDFISH_CPU_IRQ_PIC, &cascade);
> +	setup_irq(MIPS_CPU_IRQ_BASE+GOLDFISH_CPU_IRQ_FIQ, &cascade);

The problem here is that you're mixing HW interrupt numbers (the VI
stuff) and things that should never be a HW interrupt number.

> +
> +	goldfish_pic_domain = irq_domain_add_linear(node, GOLDFISH_NR_IRQS,
> +							&irq_domain_ops, 0);

And if you're going to confuse irq and hwirq, this is definitely not the
irqdomain you want, but a legacy domain instead.

> +	if (!goldfish_pic_domain)
> +		panic("Failed to add IRQ domain");
> +
> +	return 0;
> +}
> +
> +IRQCHIP_DECLARE(google_goldfish_pic, "google,goldfish-pic",
> +		goldfish_pic_of_init);
> 

As it stands, this needs a major amount of reworking. You're most
probably better off rewriting it from scratch instead of tinkering with
what looks like 10+ year old code...

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
