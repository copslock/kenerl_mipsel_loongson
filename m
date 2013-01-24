Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jan 2013 11:44:19 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:50579 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6832208Ab3AXKoSFW9pn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Jan 2013 11:44:18 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id C23F225BA31;
        Thu, 24 Jan 2013 11:44:12 +0100 (CET)
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zCLdIDO4vY3k; Thu, 24 Jan 2013 11:44:12 +0100 (CET)
Received: from [127.0.0.1] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPSA id 725FD25BA24;
        Thu, 24 Jan 2013 11:44:11 +0100 (CET)
Message-ID: <51011087.60709@openwrt.org>
Date:   Thu, 24 Jan 2013 11:44:23 +0100
From:   Gabor Juhos <juhosg@openwrt.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [RFC 03/11] MIPS: ralink: adds irq code
References: <1358942755-25371-1-git-send-email-blogic@openwrt.org> <1358942755-25371-4-git-send-email-blogic@openwrt.org>
In-Reply-To: <1358942755-25371-4-git-send-email-blogic@openwrt.org>
X-Enigmail-Version: 1.5
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
X-Antivirus: avast! (VPS 130124-0, 2013.01.24), Outbound message
X-Antivirus-Status: Clean
X-archive-position: 35532
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi John,

> All of the Ralink Wifi SoC currently supported by this series share the same
> interrupt controller (INTC).
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
>  arch/mips/ralink/irq.c |  182 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 182 insertions(+)
>  create mode 100644 arch/mips/ralink/irq.c
> 
> diff --git a/arch/mips/ralink/irq.c b/arch/mips/ralink/irq.c
> new file mode 100644
> index 0000000..f858d5d
> --- /dev/null
> +++ b/arch/mips/ralink/irq.c
> @@ -0,0 +1,182 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published
> + * by the Free Software Foundation.
> + *
> + * Copyright (C) 2009 Gabor Juhos <juhosg@openwrt.org>
> + * Copyright (C) 2013 John Crispin <blogic@openwrt.org>
> + */
> +
> +#include <linux/io.h>
> +#include <linux/bitops.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/interrupt.h>
> +
> +#include <asm/irq_cpu.h>
> +#include <asm/mipsregs.h>
> +
> +#include "common.h"
> +
> +/* INTC register offsets */
> +#define INTC_REG_STATUS0	0x00
> +#define INTC_REG_STATUS1	0x04
> +#define INTC_REG_TYPE		0x20
> +#define INTC_REG_RAW_STATUS	0x30
> +#define INTC_REG_ENABLE		0x34
> +#define INTC_REG_DISABLE	0x38
> +
> +#define INTC_INT_GLOBAL		BIT(31)
> +#define INTC_IRQ_COUNT		32
> +
> +#define RALINK_CPU_IRQ_BASE	0
> +
> +#define RALINK_CPU_IRQ_INTC	(RALINK_CPU_IRQ_BASE + 2)
> +#define RALINK_CPU_IRQ_FE	(RALINK_CPU_IRQ_BASE + 5)
> +#define RALINK_CPU_IRQ_WIFI	(RALINK_CPU_IRQ_BASE + 6)
> +#define RALINK_CPU_IRQ_COUNTER	(RALINK_CPU_IRQ_BASE + 7)

It would be better to use MIPS_CPU_IRQ_BASE instead of introducing a separate
constant. Or assign MIPS_CPU_IRQ_BASE to RALINK_CPU_IRQ_BASE at least.

> +
> +/* we have a cascade of 8 irqs */
> +#define MIPS_CPU_IRQ_CASCADE	8

The code uses this as a base number for the IRQs routed through the INTC
controller. So I would call this to RALINK_INTC_IRQ_BASE.

> +
> +/* we have 32 SoC irqs */
> +#define RALINK_INTC_IRQ_COUNT	32
> +
> +#define RALINK_INTC_IRQ_PERFC   (MIPS_CPU_IRQ_CASCADE + 9)
> +
> +static void __iomem *rt_intc_membase;
> +
> +static inline void rt_intc_w32(u32 val, unsigned reg)
> +{
> +	__raw_writel(val, rt_intc_membase + reg);
> +}
> +
> +static inline u32 rt_intc_r32(unsigned reg)
> +{
> +	return __raw_readl(rt_intc_membase + reg);
> +}
> +
> +static void ralink_intc_irq_unmask(struct irq_data *d)
> +{
> +	unsigned int irq = d->irq - MIPS_CPU_IRQ_CASCADE;

Because you are using irqdomains, you should use the hw_irq field of irq_data to
get the bit offset.

> +
> +	rt_intc_w32((1 << irq), INTC_REG_ENABLE);
> +}
> +
> +static void ralink_intc_irq_mask(struct irq_data *d)
> +{
> +	unsigned int irq = d->irq - MIPS_CPU_IRQ_CASCADE;
> +
> +	rt_intc_w32((1 << irq), INTC_REG_DISABLE);
> +}
> +
> +static struct irq_chip ralink_intc_irq_chip = {
> +	.name		= "INTC",
> +	.irq_unmask	= ralink_intc_irq_unmask,
> +	.irq_mask	= ralink_intc_irq_mask,
> +	.irq_mask_ack	= ralink_intc_irq_mask,
> +};
> +
> +static struct irqaction ralink_intc_irqaction = {
> +	.handler	= no_action,
> +	.name		= "cascade [INTC]",
> +};

It would be simpler to use 'irq_set_chained_handler' instead of 'irq_setup' in
'intc_of_init'. In that way you would not have to use a custom irq_action.

> +
> +unsigned int __cpuinit get_c0_compare_irq(void)
> +{
> +	return CP0_LEGACY_COMPARE_IRQ;
> +}
> +
> +void ralink_intc_dispatch(void)
> +{
> +	u32 pending = rt_intc_r32(INTC_REG_STATUS0);
> +
> +	do_IRQ((int)(__ffs(pending) + MIPS_CPU_IRQ_CASCADE));

You have to check that 'pending' is not zero before passing that to '__ffs',
because the result of '__ffs(x)' is not defined if 'x' is zero.

> +}
> +
> +asmlinkage void plat_irq_dispatch(void)
> +{
> +	unsigned long pending;
> +
> +	pending = read_c0_status() & read_c0_cause() & ST0_IM;
> +
> +	if (pending & STATUSF_IP7)
> +		do_IRQ(RALINK_CPU_IRQ_COUNTER);
> +
> +	else if (pending & STATUSF_IP5)
> +		do_IRQ(RALINK_CPU_IRQ_FE);
> +
> +	else if (pending & STATUSF_IP6)
> +		do_IRQ(RALINK_CPU_IRQ_WIFI);
> +
> +	else if (pending & STATUSF_IP2)
> +		ralink_intc_dispatch();
> +
> +	else
> +		spurious_interrupt();
> +}
> +
> +static int intc_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
> +{
> +	if (hw < MIPS_CPU_IRQ_CASCADE)
> +		return 0;

The INTC controller can handle 32 IRQs, so the hardware IRQ numbers within the
0..31 range are valid. With this code, the hardware IRQ numbers from the 0..7
range can't be mapped.

> +
> +	irq_set_chip_and_handler(hw, &ralink_intc_irq_chip, handle_level_irq);
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops irq_domain_ops = {
> +	.xlate = irq_domain_xlate_onetwocell,

This should be either 'irq_domain_xlate_onecell' or 'irq_domain_xlate_twocell'.

Here is the note from linux/irq/irqdomain.c:

 * Note: don't use this function unless your interrupt controller explicitly
 * supports both one and two cell bindings.  For the majority of controllers
 * the _onecell() or _twocell() variants above should be used.

> +	.map = intc_map,
> +};
> +
> +int __init intc_of_init(struct device_node *node, struct device_node *parent)
> +{
> +	struct resource res;
> +
> +	mips_cpu_irq_init();
> +
> +	if (of_address_to_resource(node, 0, &res))
> +		panic("Failed to get intc memory range");
> +
> +	if (request_mem_region(res.start, resource_size(&res),
> +				res.name) < 0)
> +		pr_err("Failed to request intc memory");
> +
> +	rt_intc_membase = ioremap_nocache(res.start,
> +					resource_size(&res));
> +	if (!rt_intc_membase)
> +		panic("Failed to remap intc memory");
> +
> +	/* disable all interrupts */
> +	rt_intc_w32(~0, INTC_REG_DISABLE);
> +
> +	/* route all INTC interrupts to MIPS HW0 interrupt */
> +	rt_intc_w32(0, INTC_REG_TYPE);
> +
> +	setup_irq(RALINK_CPU_IRQ_INTC, &ralink_intc_irqaction);
> +
> +	irq_domain_add_linear(node,
> +		MIPS_CPU_IRQ_CASCADE + RALINK_INTC_IRQ_COUNT,
> +		&irq_domain_ops, 0);
> +
> +	rt_intc_w32(INTC_INT_GLOBAL, INTC_REG_ENABLE);
> +
> +	cp0_perfcount_irq = RALINK_INTC_IRQ_PERFC;
> +
> +	return 0;
> +}
> +
> +static struct of_device_id __initdata of_irq_ids[] = {
> +	{ .compatible = "ralink,intc", .data = intc_of_init },
> +	{},
> +};
> +
> +void __init arch_init_irq(void)
> +{
> +	of_irq_init(of_irq_ids);
> +}
> +
> 
