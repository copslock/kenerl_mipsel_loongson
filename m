Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jan 2016 13:38:56 +0100 (CET)
Received: from foss.arm.com ([217.140.101.70]:55369 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27014793AbcATMix7AURK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 20 Jan 2016 13:38:53 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6EA33A8;
        Wed, 20 Jan 2016 04:38:08 -0800 (PST)
Received: from sofa.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4EE1D3F21A;
        Wed, 20 Jan 2016 04:38:45 -0800 (PST)
Date:   Wed, 20 Jan 2016 12:38:41 +0000
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Alban Bedel <albeu@free.fr>
Cc:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Alexander Couzens <lynxis@fe80.eu>,
        Joel Porquet <joel@porquet.org>,
        "Andrew Bresticker" <abrestic@chromium.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] MIPS: ath79: irq: Move the MISC driver to
 drivers/irqchip
Message-ID: <20160120123841.039345ad@sofa.wild-wind.fr.eu.org>
In-Reply-To: <1447788896-15553-5-git-send-email-albeu@free.fr>
References: <1447788896-15553-1-git-send-email-albeu@free.fr>
        <1447788896-15553-5-git-send-email-albeu@free.fr>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.13.2-1-geb0880 (GTK+ 2.24.25; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <marc.zyngier@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51254
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

On Tue, 17 Nov 2015 20:34:54 +0100
Alban Bedel <albeu@free.fr> wrote:

Hi Alban,

> The driver stays the same but the initialization changes a bit.
> For OF boards we now get the memory map from the OF node and use
> a linear mapping instead of the legacy mapping. For legacy boards
> we still use a legacy mapping and just pass down all the parameters
> from the board init code.
> 
> Signed-off-by: Alban Bedel <albeu@free.fr>
> ---
>  arch/mips/ath79/irq.c                    | 163 +++------------------------
>  arch/mips/include/asm/mach-ath79/ath79.h |   3 +
>  drivers/irqchip/Makefile                 |   1 +
>  drivers/irqchip/irq-ath79-misc.c         | 182 +++++++++++++++++++++++++++++++
>  4 files changed, 201 insertions(+), 148 deletions(-)
>  create mode 100644 drivers/irqchip/irq-ath79-misc.c
> 

[...]

> diff --git a/drivers/irqchip/irq-ath79-misc.c b/drivers/irqchip/irq-ath79-misc.c
> new file mode 100644
> index 0000000..bd2121f1
> --- /dev/null
> +++ b/drivers/irqchip/irq-ath79-misc.c
> @@ -0,0 +1,182 @@
> +/*
> + *  Atheros AR71xx/AR724x/AR913x MISC interrupt controller
> + *
> + *  Copyright (C) 2015 Alban Bedel <albeu@free.fr>
> + *  Copyright (C) 2010-2011 Jaiganesh Narayanan <jnarayanan@atheros.com>
> + *  Copyright (C) 2008-2011 Gabor Juhos <juhosg@openwrt.org>
> + *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
> + *
> + *  Parts of this file are based on Atheros' 2.6.15/2.6.31 BSP
> + *
> + *  This program is free software; you can redistribute it and/or modify it
> + *  under the terms of the GNU General Public License version 2 as published
> + *  by the Free Software Foundation.
> + */
> +
> +#include <linux/irqchip.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +
> +#define AR71XX_RESET_REG_MISC_INT_STATUS	0
> +#define AR71XX_RESET_REG_MISC_INT_ENABLE	4
> +
> +#define ATH79_MISC_IRQ_COUNT			32
> +
> +static void ath79_misc_irq_handler(struct irq_desc *desc)
> +{
> +	struct irq_domain *domain = irq_desc_get_handler_data(desc);
> +	void __iomem *base = domain->host_data;
> +	u32 pending;
> +
> +	pending = __raw_readl(base + AR71XX_RESET_REG_MISC_INT_STATUS) &
> +		  __raw_readl(base + AR71XX_RESET_REG_MISC_INT_ENABLE);
> +
> +	if (!pending) {
> +		spurious_interrupt();
> +		return;
> +	}
> +
> +	while (pending) {
> +		int bit = __ffs(pending);
> +
> +		generic_handle_irq(irq_linear_revmap(domain, bit));
> +		pending &= ~BIT(bit);
> +	}
> +}

Given that this function is used as a chained handler, it seems to be
missing the usual chained_irq_enter/exit...

> +
> +static void ar71xx_misc_irq_unmask(struct irq_data *d)
> +{
> +	void __iomem *base = irq_data_get_irq_chip_data(d);
> +	unsigned int irq = d->hwirq;
> +	u32 t;
> +
> +	t = __raw_readl(base + AR71XX_RESET_REG_MISC_INT_ENABLE);
> +	__raw_writel(t | BIT(irq), base + AR71XX_RESET_REG_MISC_INT_ENABLE);
> +
> +	/* flush write */
> +	__raw_readl(base + AR71XX_RESET_REG_MISC_INT_ENABLE);
> +}
> +
> +static void ar71xx_misc_irq_mask(struct irq_data *d)
> +{
> +	void __iomem *base = irq_data_get_irq_chip_data(d);
> +	unsigned int irq = d->hwirq;
> +	u32 t;
> +
> +	t = __raw_readl(base + AR71XX_RESET_REG_MISC_INT_ENABLE);
> +	__raw_writel(t & ~BIT(irq), base + AR71XX_RESET_REG_MISC_INT_ENABLE);
> +
> +	/* flush write */
> +	__raw_readl(base + AR71XX_RESET_REG_MISC_INT_ENABLE);
> +}
> +
> +static void ar724x_misc_irq_ack(struct irq_data *d)
> +{
> +	void __iomem *base = irq_data_get_irq_chip_data(d);
> +	unsigned int irq = d->hwirq;
> +	u32 t;
> +
> +	t = __raw_readl(base + AR71XX_RESET_REG_MISC_INT_STATUS);
> +	__raw_writel(t & ~BIT(irq), base + AR71XX_RESET_REG_MISC_INT_STATUS);
> +
> +	/* flush write */
> +	__raw_readl(base + AR71XX_RESET_REG_MISC_INT_STATUS);
> +}
> +
> +static struct irq_chip ath79_misc_irq_chip = {
> +	.name		= "MISC",
> +	.irq_unmask	= ar71xx_misc_irq_unmask,
> +	.irq_mask	= ar71xx_misc_irq_mask,
> +};
> +
> +static int misc_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
> +{
> +	irq_set_chip_and_handler(irq, &ath79_misc_irq_chip, handle_level_irq);
> +	irq_set_chip_data(irq, d->host_data);
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops misc_irq_domain_ops = {
> +	.xlate = irq_domain_xlate_onecell,
> +	.map = misc_map,
> +};
> +
> +static void __init ath79_misc_intc_domain_init(
> +	struct irq_domain *domain, int irq)
> +{
> +	void __iomem *base = domain->host_data;
> +
> +	/* Disable and clear all interrupts */
> +	__raw_writel(0, base + AR71XX_RESET_REG_MISC_INT_ENABLE);
> +	__raw_writel(0, base + AR71XX_RESET_REG_MISC_INT_STATUS);
> +
> +	irq_set_chained_handler_and_data(irq, ath79_misc_irq_handler, domain);
> +}
> +
> +static int __init ath79_misc_intc_of_init(
> +	struct device_node *node, struct device_node *parent)
> +{
> +	struct irq_domain *domain;
> +	void __iomem *base;
> +	int irq;
> +
> +	irq = irq_of_parse_and_map(node, 0);
> +	if (!irq) {
> +		pr_err("Failed to get MISC IRQ\n");
> +		return -EINVAL;
> +	}
> +
> +	base = of_iomap(node, 0);
> +	if (!base) {
> +		pr_err("Failed to get MISC IRQ registers\n");
> +		return -ENOMEM;
> +	}
> +
> +	domain = irq_domain_add_linear(node, ATH79_MISC_IRQ_COUNT,
> +				&misc_irq_domain_ops, base);
> +	if (!domain) {
> +		pr_err("Failed to add MISC irqdomain\n");
> +		return -EINVAL;
> +	}
> +
> +	ath79_misc_intc_domain_init(domain, irq);
> +	return 0;
> +}
> +
> +static int __init ar7100_misc_intc_of_init(
> +	struct device_node *node, struct device_node *parent)
> +{
> +	ath79_misc_irq_chip.irq_mask_ack = ar71xx_misc_irq_mask;
> +	return ath79_misc_intc_of_init(node, parent);
> +}
> +
> +IRQCHIP_DECLARE(ar7100_misc_intc, "qca,ar7100-misc-intc",
> +		ar7100_misc_intc_of_init);
> +
> +static int __init ar7240_misc_intc_of_init(
> +	struct device_node *node, struct device_node *parent)
> +{
> +	ath79_misc_irq_chip.irq_ack = ar724x_misc_irq_ack;
> +	return ath79_misc_intc_of_init(node, parent);
> +}
> +
> +IRQCHIP_DECLARE(ar7240_misc_intc, "qca,ar7240-misc-intc",
> +		ar7240_misc_intc_of_init);
> +
> +void __init ath79_misc_irq_init(void __iomem *regs, int irq,
> +				int irq_base, bool is_ar71xx)
> +{
> +	struct irq_domain *domain;
> +
> +	if (is_ar71xx)
> +		ath79_misc_irq_chip.irq_mask_ack = ar71xx_misc_irq_mask;
> +	else
> +		ath79_misc_irq_chip.irq_ack = ar724x_misc_irq_ack;
> +
> +	domain = irq_domain_add_legacy(NULL, ATH79_MISC_IRQ_COUNT,
> +			irq_base, 0, &misc_irq_domain_ops, regs);
> +	if (!domain)
> +		panic("Failed to create MISC irqdomain");
> +
> +	ath79_misc_intc_domain_init(domain, irq);
> +}

Other than that, this looks OK.

Thanks,

	M.
-- 
AAAFNRAA
