Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Dec 2015 18:00:24 +0100 (CET)
Received: from foss.arm.com ([217.140.101.70]:60749 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008999AbbLORAUqlMr6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 15 Dec 2015 18:00:20 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CEF825F6;
        Tue, 15 Dec 2015 08:59:49 -0800 (PST)
Received: from [10.1.209.24] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A22653F308;
        Tue, 15 Dec 2015 09:00:12 -0800 (PST)
Message-ID: <5670471B.6090608@arm.com>
Date:   Tue, 15 Dec 2015 17:00:11 +0000
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
MIME-Version: 1.0
To:     Joshua Henderson <joshua.henderson@microchip.com>,
        linux-kernel@vger.kernel.org
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH v2 02/14] irqchip: irq-pic32-evic: Add support for PIC32
 interrupt controller
References: <1450133093-7053-1-git-send-email-joshua.henderson@microchip.com> <1450133093-7053-3-git-send-email-joshua.henderson@microchip.com>
In-Reply-To: <1450133093-7053-3-git-send-email-joshua.henderson@microchip.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <marc.zyngier@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50630
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

On 14/12/15 22:42, Joshua Henderson wrote:
> From: Cristian Birsan <cristian.birsan@microchip.com>
> 
> This adds support for the interrupt controller present on PIC32 class
> devices.
> 
> The following features are supported:
>  - DT properties for EVIC and for devices that use interrupt lines
>  - Persistent and non-persistent interrupt handling
>  - irqdomain support
> 
> Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
> Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> ---
>  drivers/irqchip/Makefile           |    1 +
>  drivers/irqchip/irq-pic32-evic.c   |  321 ++++++++++++++++++++++++++++++++++++
>  include/linux/irqchip/pic32-evic.h |   19 +++
>  3 files changed, 341 insertions(+)
>  create mode 100644 drivers/irqchip/irq-pic32-evic.c
>  create mode 100644 include/linux/irqchip/pic32-evic.h
> 
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index 177f78f..e3608fc 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -55,3 +55,4 @@ obj-$(CONFIG_RENESAS_H8S_INTC)		+= irq-renesas-h8s.o
>  obj-$(CONFIG_ARCH_SA1100)		+= irq-sa11x0.o
>  obj-$(CONFIG_INGENIC_IRQ)		+= irq-ingenic.o
>  obj-$(CONFIG_IMX_GPCV2)			+= irq-imx-gpcv2.o
> +obj-$(CONFIG_MACH_PIC32)		+= irq-pic32-evic.o
> diff --git a/drivers/irqchip/irq-pic32-evic.c b/drivers/irqchip/irq-pic32-evic.c
> new file mode 100644
> index 0000000..6a7747c
> --- /dev/null
> +++ b/drivers/irqchip/irq-pic32-evic.c
> @@ -0,0 +1,321 @@
> +/*
> + * Cristian Birsan <cristian.birsan@microchip.com>
> + * Copyright (C) 2015 Microchip Technology Inc.  All rights reserved.
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/irqdomain.h>
> +#include <linux/of_address.h>
> +#include <linux/slab.h>
> +#include <linux/io.h>
> +#include <linux/irqchip.h>
> +#include <linux/irqchip/pic32-evic.h>
> +
> +#include <asm/irq.h>
> +#include <asm/traps.h>
> +
> +#define CORE_TIMER_INTERRUPT 0
> +#define EXTERNAL_INTERRUPT_0 3
> +#define EXTERNAL_INTERRUPT_1 8
> +#define EXTERNAL_INTERRUPT_2 13
> +#define EXTERNAL_INTERRUPT_3 18
> +#define EXTERNAL_INTERRUPT_4 23
> +
> +#define PRI_MASK	0x7	/* 3 bit priority mask */
> +#define SUBPRI_MASK	0x3	/* 2 bit subpriority mask */
> +#define INT_MASK	0x1F	/* 5 bit pri and subpri mask */
> +#define NR_EXT_IRQS	5	/* 5 external interrupts sources */
> +
> +#define PIC32_INT_PRI(pri, subpri)	\
> +	(((pri & PRI_MASK) << 2) | (subpri & SUBPRI_MASK))
> +#define DEFAULT_PIC32_INT_PRI PIC32_INT_PRI(2, 0)
> +
> +static struct irq_domain *evic_irq_domain;
> +static struct evic __iomem *evic_base;
> +
> +static unsigned int *evic_irq_prio;
> +
> +struct pic_reg {
> +	u32 val; /* value register*/
> +	u32 clr; /* clear register */
> +	u32 set; /* set register */
> +	u32 inv; /* inv register */
> +} __packed;
> +
> +struct evic {
> +	struct pic_reg intcon;
> +	struct pic_reg priss;
> +	struct pic_reg intstat;
> +	struct pic_reg iptmr;
> +	struct pic_reg ifs[6];
> +	u32 reserved1[8];
> +	struct pic_reg iec[6];
> +	u32 reserved2[8];
> +	struct pic_reg ipc[48];
> +	u32 reserved3[64];
> +	u32 off[191];
> +} __packed;
> +
> +static int get_ext_irq_index(irq_hw_number_t hw);
> +static void evic_set_ext_irq_polarity(int ext_irq, u32 type);
> +
> +#define BIT_REG_MASK(bit, reg, mask)		\
> +	do {					\
> +		reg = bit/32;			\
> +		mask = 1 << (bit % 32);		\
> +	} while (0)
> +
> +asmlinkage void __weak plat_irq_dispatch(void)
> +{
> +	unsigned int irq, hwirq;
> +	u32 reg, mask;
> +
> +	hwirq = readl(&evic_base->intstat.val) & 0xFF;
> +
> +	/* Check if the interrupt was really triggered by hardware*/
> +	BIT_REG_MASK(hwirq, reg, mask);
> +	if (likely(readl(&evic_base->ifs[reg].val) &
> +			readl(&evic_base->iec[reg].val) & mask)) {
> +		irq = irq_linear_revmap(evic_irq_domain, hwirq);
> +		do_IRQ(irq);
> +	} else
> +		spurious_interrupt();
> +}
> +
> +/* mask off an interrupt */
> +static inline void mask_pic32_irq(struct irq_data *irqd)
> +{
> +	u32 reg, mask;
> +	unsigned int hwirq = irqd_to_hwirq(irqd);
> +
> +	BIT_REG_MASK(hwirq, reg, mask);
> +	writel(mask, &evic_base->iec[reg].clr);
> +}
> +
> +/* unmask an interrupt */
> +static inline void unmask_pic32_irq(struct irq_data *irqd)
> +{
> +	u32 reg, mask;
> +	unsigned int hwirq = irqd_to_hwirq(irqd);
> +
> +	BIT_REG_MASK(hwirq, reg, mask);
> +	writel(mask, &evic_base->iec[reg].set);
> +}
> +
> +/* acknowledge an interrupt */
> +static void ack_pic32_irq(struct irq_data *irqd)
> +{
> +	u32 reg, mask;
> +	unsigned int hwirq = irqd_to_hwirq(irqd);
> +
> +	BIT_REG_MASK(hwirq, reg, mask);
> +	writel(mask, &evic_base->ifs[reg].clr);
> +}
> +
> +/* mask off and acknowledge an interrupt */
> +static inline void mask_ack_pic32_irq(struct irq_data *irqd)
> +{
> +	u32 reg, mask;
> +	unsigned int hwirq = irqd_to_hwirq(irqd);
> +
> +	BIT_REG_MASK(hwirq, reg, mask);
> +	writel(mask, &evic_base->iec[reg].clr);
> +	writel(mask, &evic_base->ifs[reg].clr);
> +}
> +
> +static int set_type_pic32_irq(struct irq_data *data, unsigned int flow_type)
> +{
> +	int index;
> +
> +	switch (flow_type) {
> +
> +	case IRQ_TYPE_EDGE_RISING:
> +	case IRQ_TYPE_EDGE_FALLING:
> +		irq_set_handler_locked(data, handle_edge_irq);
> +		break;
> +
> +	case IRQ_TYPE_LEVEL_HIGH:
> +	case IRQ_TYPE_LEVEL_LOW:
> +		irq_set_handler_locked(data, handle_fasteoi_irq);
> +		break;
> +
> +	default:
> +		pr_err("Invalid interrupt type !\n");
> +		return -EINVAL;
> +	}
> +
> +	/* set polarity for external interrupts only */
> +	index = get_ext_irq_index(data->hwirq);
> +	if (index >= 0)
> +		evic_set_ext_irq_polarity(index, flow_type);
> +
> +	return IRQ_SET_MASK_OK;
> +}
> +
> +static void pic32_bind_evic_interrupt(int irq, int set)
> +{
> +	writel(set, &evic_base->off[irq]);
> +}
> +
> +int pic32_get_c0_compare_int(void)
> +{
> +	int virq;
> +
> +	virq = irq_create_mapping(evic_irq_domain, CORE_TIMER_INTERRUPT);
> +	irq_set_irq_type(virq, IRQ_TYPE_EDGE_RISING);
> +	return virq;
> +}
> +
> +static struct irq_chip pic32_irq_chip = {
> +	.name = "PIC32-EVIC",
> +	.irq_ack = ack_pic32_irq,
> +	.irq_mask = mask_pic32_irq,
> +	.irq_mask_ack = mask_ack_pic32_irq,
> +	.irq_unmask = unmask_pic32_irq,
> +	.irq_eoi = ack_pic32_irq,
> +	.irq_set_type = set_type_pic32_irq,
> +	.irq_enable = unmask_pic32_irq,
> +	.irq_disable = mask_pic32_irq,

I'm not sure I see the point of having all these methods. First, there
is a lot of duplication: no need to provide enable/disable if all you
have is mask/unmask - the core code can deal with that.

Then, your EOI method is not really an EOI. It doesn't terminate the
handling, or at least that's not what the name suggest. If this is
really an EOI, then you should be able to simplify the whole thing on
only use the fasteoi handler, including for edge interrupts.

It would be good to have an insight on how this thing actually works
(I've tried to read the only documentation, but this is vague at best),
that would help picking the right design for your use case.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
