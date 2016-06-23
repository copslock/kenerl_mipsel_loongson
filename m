Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jun 2016 17:51:59 +0200 (CEST)
Received: from pmta2.delivery5.ore.mailhop.org ([54.186.218.12]:60220 "EHLO
        pmta2.delivery5.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27043812AbcFWPvzjn4Wd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Jun 2016 17:51:55 +0200
X-MHO-User: 79b94487-395a-11e6-8929-8ded99d5e9d7
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Originating-IP: 74.99.78.160
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from io (unknown [74.99.78.160])
        by outbound2.ore.mailhop.org (Halon Mail Gateway) with ESMTPSA;
        Thu, 23 Jun 2016 15:52:22 +0000 (UTC)
Received: from io.lakedaemon.net (localhost [127.0.0.1])
        by io (Postfix) with ESMTP id F25AE8015F;
        Thu, 23 Jun 2016 15:51:48 +0000 (UTC)
X-DKIM: OpenDKIM Filter v2.6.8 io F25AE8015F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lakedaemon.net;
        s=mail; t=1466697109;
        bh=m77mFKVq+CQtAmw/huAw/wQwA+FNPVv9jWedL6buLbU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=gLch7yUyPxIVPCgMKXUrkG/i5dhBoM558rtCeHWskWWoqqpeKZunDfj/rtydUOYsz
         821a30RRqkury/SZq/YWxeOvoa9I3lgfIC2Z2AI5ESZ/BQNOJurIMSEQ1BLA4Rtbt4
         ih7ECYE4PXPmNNtSZsCNXKgFIZVRPgsPGxln4QWFYDl0FLUbvzmjz0pIxAejl4t55b
         q0XHK1tBu2XFN6IZhLZ4gTiZmas+F5NhV2J2+7e/pOKC13zkYLOW2l+4Iu9eX7Ykc2
         vBMdRwEWdPFwSTIcYsHGQoJJ+kXzjzMq5vuUGqxgavpDc7tIbAPSU0c4qhl4TaApA/
         D7ddktitNeL+Q==
Date:   Thu, 23 Jun 2016 15:51:48 +0000
From:   Jason Cooper <jason@lakedaemon.net>
To:     Binbin Zhou <zhoubb@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-kernel@vger.kernel.org, Chunbo Cui <cuichboo@163.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: Re: [PATCH RESEND v4 6/9] irqchip/ls1x-cpu: Move the CPU IRQ driver
 from arch/mips/loongson32/common/
Message-ID: <20160623155148.GF9922@io.lakedaemon.net>
References: <1463622257-10230-1-git-send-email-zhoubb@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1463622257-10230-1-git-send-email-zhoubb@lemote.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <jason@lakedaemon.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54136
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jason@lakedaemon.net
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

Hi folks!

On Thu, May 19, 2016 at 09:44:17AM +0800, Binbin Zhou wrote:

Commit message?

> Signed-off-by: Chunbo Cui <cuichboo@163.com>
> Signed-off-by: Binbin Zhou <zhoubb@lemote.com>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  arch/mips/include/asm/irq_cpu.h   |   1 +
>  arch/mips/loongson32/common/irq.c | 128 +-------------------
>  drivers/irqchip/Makefile          |   1 +
>  drivers/irqchip/irq-ls1x-cpu.c    | 242 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 245 insertions(+), 127 deletions(-)
>  create mode 100644 drivers/irqchip/irq-ls1x-cpu.c
> 
...
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index b03cfcb..ae53eb9 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -5,6 +5,7 @@ obj-$(CONFIG_ATH79)			+= irq-ath79-cpu.o
>  obj-$(CONFIG_ATH79)			+= irq-ath79-misc.o
>  obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2835.o
>  obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2836.o
> +obj-$(CONFIG_MACH_LOONGSON32)		+= irq-ls1x-cpu.o
>  obj-$(CONFIG_ARCH_EXYNOS)		+= exynos-combiner.o
>  obj-$(CONFIG_ARCH_HIP04)		+= irq-hip04.o
>  obj-$(CONFIG_ARCH_MMP)			+= irq-mmp.o

This is a gentle reminder to myself to fix this file up at the end of
the merge window.  It's making me twitch.

> diff --git a/drivers/irqchip/irq-ls1x-cpu.c b/drivers/irqchip/irq-ls1x-cpu.c
> new file mode 100644
> index 0000000..0df984b
> --- /dev/null
> +++ b/drivers/irqchip/irq-ls1x-cpu.c
> @@ -0,0 +1,242 @@
> +/*
> + * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
> + * Copyright (c) 2016 Binbin Zhou <zhoubb@lemote.com>
> + *
> + * This program is free software; you can redistribute	it and/or modify it
> + * under  the terms of	the GNU General	 Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.

nit: paragraph needs to be reflowed.

> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/irqchip.h>
> +#include <linux/irqdomain.h>
> +#include <asm/irq_cpu.h>
> +
> +#include <loongson1.h>
> +#include <irq.h>
> +
> +#define LS1X_INTC_REG(n, x) \
> +		((void __iomem *)KSEG1ADDR(LS1X_INT_REG_BASE + (n * 0x18) + (x)))
> +
> +#define LS1X_INTC_INTISR(n)		LS1X_INTC_REG(n, 0x0)
> +#define LS1X_INTC_INTIEN(n)		LS1X_INTC_REG(n, 0x4)
> +#define LS1X_INTC_INTSET(n)		LS1X_INTC_REG(n, 0x8)
> +#define LS1X_INTC_INTCLR(n)		LS1X_INTC_REG(n, 0xc)
> +#define LS1X_INTC_INTPOL(n)		LS1X_INTC_REG(n, 0x10)
> +#define LS1X_INTC_INTEDGE(n)		LS1X_INTC_REG(n, 0x14)
> +
> +static void ls1x_irq_ack(struct irq_data *d)
> +{
> +	unsigned int bit = (d->irq - LS1X_IRQ_BASE) & 0x1f;
> +	unsigned int n = (d->irq - LS1X_IRQ_BASE) >> 5;
> +
> +	ls1x_writel(ls1x_readl(LS1X_INTC_INTCLR(n))
> +			| (1 << bit), LS1X_INTC_INTCLR(n));

Why can't we use the standard functions?

> +}
> +
> +static void ls1x_irq_mask(struct irq_data *d)
> +{
> +	unsigned int bit = (d->irq - LS1X_IRQ_BASE) & 0x1f;
> +	unsigned int n = (d->irq - LS1X_IRQ_BASE) >> 5;
> +
> +	ls1x_writel(ls1x_readl(LS1X_INTC_INTIEN(n))
> +			& ~(1 << bit), LS1X_INTC_INTIEN(n));

With this, and all the statements similar to it below, we do the same
calculations (LS1X_INTC_XXXXXX(n)) twice.  The compiler can't optimize
it because it doesn't know n ahead of time.  Let's just calculate it
once:

	void __iomem *addr = LS1X_INTC_INTIEN((d->irq - LS1X_IRQ_BASE) >> 5);

	xwrite(xread(addr) & ~(1 << bit), addr);

where x{write,read}() is whatever we conclude is appropriate for this
driver.

> +}
> +
> +static void ls1x_irq_mask_ack(struct irq_data *d)
> +{
> +	unsigned int bit = (d->irq - LS1X_IRQ_BASE) & 0x1f;
> +	unsigned int n = (d->irq - LS1X_IRQ_BASE) >> 5;
> +
> +	ls1x_writel(ls1x_readl(LS1X_INTC_INTIEN(n))
> +			& ~(1 << bit), LS1X_INTC_INTIEN(n));
> +	ls1x_writel(ls1x_readl(LS1X_INTC_INTCLR(n))
> +			| (1 << bit), LS1X_INTC_INTCLR(n));
> +}
> +
> +static void ls1x_irq_unmask(struct irq_data *d)
> +{
> +	unsigned int bit = (d->irq - LS1X_IRQ_BASE) & 0x1f;
> +	unsigned int n = (d->irq - LS1X_IRQ_BASE) >> 5;
> +
> +	ls1x_writel(ls1x_readl(LS1X_INTC_INTIEN(n))
> +			| (1 << bit), LS1X_INTC_INTIEN(n));
> +}
> +
> +static void ls1x_irq_edge_type(struct irq_data *data, unsigned int flow_type)
> +{
> +	unsigned int bit = (data->irq - LS1X_IRQ_BASE) & 0x1f;
> +	unsigned int n = (data->irq - LS1X_IRQ_BASE) >> 5;
> +
> +	if (flow_type & IRQ_TYPE_EDGE_RISING)
> +		ls1x_writel(ls1x_readl(LS1X_INTC_INTPOL(n)) | (1 << bit),
> +				LS1X_INTC_INTPOL(n));
> +	else
> +		ls1x_writel(ls1x_readl(LS1X_INTC_INTPOL(n)) & ~(1 << bit),
> +				LS1X_INTC_INTPOL(n));
> +
> +	ls1x_writel(ls1x_readl(LS1X_INTC_INTEDGE(n)) | (1 << bit),
> +			LS1X_INTC_INTEDGE(n));
> +	ls1x_writel(ls1x_readl(LS1X_INTC_INTIEN(n)) | (1 << bit),
> +			LS1X_INTC_INTIEN(n));
> +
> +	irq_set_handler_locked(data, handle_edge_irq);
> +}
> +
> +static void ls1x_irq_level_type(struct irq_data *data, unsigned int flow_type)
> +{
> +	unsigned int bit = (data->irq - LS1X_IRQ_BASE) & 0x1f;
> +	unsigned int n = (data->irq - LS1X_IRQ_BASE) >> 5;
> +
> +	if (flow_type & IRQ_TYPE_LEVEL_HIGH)
> +		ls1x_writel(ls1x_readl(LS1X_INTC_INTPOL(n)) | (1 << bit),
> +				LS1X_INTC_INTPOL(n));
> +	else if (flow_type & IRQ_TYPE_LEVEL_LOW)
> +		ls1x_writel(ls1x_readl(LS1X_INTC_INTPOL(n)) & ~(1 << bit),
> +				LS1X_INTC_INTPOL(n));
> +
> +	ls1x_writel(ls1x_readl(LS1X_INTC_INTEDGE(n)) & ~(1 << bit),
> +			LS1X_INTC_INTEDGE(n));
> +	ls1x_writel(ls1x_readl(LS1X_INTC_INTIEN(n)) | (1 << bit),
> +			LS1X_INTC_INTIEN(n));
> +
> +	irq_set_handler_locked(data, handle_level_irq);
> +}
> +
> +static int ls1x_irq_set_type(struct irq_data *data, unsigned int flow_type)
> +{
> +	unsigned int bit = (data->irq - LS1X_IRQ_BASE) & 0x1f;
> +	unsigned int n = (data->irq - LS1X_IRQ_BASE) >> 5;
> +
> +	if ((flow_type & IRQ_TYPE_EDGE_BOTH) == IRQ_TYPE_EDGE_BOTH) {
> +		pr_info("ls1x irq don't support both rising and falling\n");

Under what conditions have you encountered this?  Badly written
devicetree?  driver?

> +		return -1;
> +	}
> +
> +	ls1x_writel(ls1x_readl(LS1X_INTC_INTCLR(n)) | (1 << bit),
> +			LS1X_INTC_INTCLR(n));
> +
> +	if (flow_type & IRQ_TYPE_EDGE_BOTH)
> +		ls1x_irq_edge_type(data, flow_type);
> +	else if (flow_type && IRQ_TYPE_LEVEL_MASK)
> +		ls1x_irq_level_type(data, flow_type);
> +
> +	return IRQ_SET_MASK_OK;
> +}
> +
> +static struct irq_chip ls1x_cpu_irq_chip = {
> +	.name		= "LS1X-INTC",
> +	.irq_ack	= ls1x_irq_ack,
> +	.irq_mask	= ls1x_irq_mask,
> +	.irq_mask_ack	= ls1x_irq_mask_ack,
> +	.irq_unmask	= ls1x_irq_unmask,
> +	.irq_set_type	= ls1x_irq_set_type,
> +};
> +
> +static void ls1x_irq_dispatch(int n)
> +{
> +	u32 int_status, irq;
> +
> +	/* Get pending sources, masked by current enables */
> +	int_status = ls1x_readl(LS1X_INTC_INTISR(n)) &
> +			ls1x_readl(LS1X_INTC_INTIEN(n));
> +
> +	if (int_status) {
> +		irq = LS1X_IRQ(n, __ffs(int_status));
> +		do_IRQ(irq);
> +	}
> +}
> +
> +asmlinkage void plat_irq_dispatch(void)
> +{
> +	unsigned int pending;
> +
> +	pending = read_c0_cause() & read_c0_status() & ST0_IM;
> +
> +	if (pending & CAUSEF_IP7)
> +		do_IRQ(TIMER_IRQ);
> +	else if (pending & CAUSEF_IP2)
> +		ls1x_irq_dispatch(0); /* INT0 */
> +	else if (pending & CAUSEF_IP3)
> +		ls1x_irq_dispatch(1); /* INT1 */
> +	else if (pending & CAUSEF_IP4)
> +		ls1x_irq_dispatch(2); /* INT2 */
> +	else if (pending & CAUSEF_IP5)
> +		ls1x_irq_dispatch(3); /* INT3 */
> +	else if (pending & CAUSEF_IP6)
> +		ls1x_irq_dispatch(4); /* INT4 */
> +	else
> +		spurious_interrupt();
> +
> +}
> +
> +struct irqaction cascade_irqaction = {
> +	.handler = no_action,
> +	.name = "cascade",
> +	.flags = IRQF_NO_THREAD,
> +};
> +
> +static int ls1x_cpu_intc_map(struct irq_domain *d, unsigned int irq,
> +			     irq_hw_number_t hw)
> +{
> +	int n;
> +
> +	/*
> +	 * Disable interrupts and clear pending,
> +	 * setup all IRQs as high level triggered
> +	 */
> +	for (n = 0; n < 4; n++) {
> +		ls1x_writel(0x0, LS1X_INTC_INTIEN(n));
> +		ls1x_writel(0xffffffff, LS1X_INTC_INTCLR(n));
> +		ls1x_writel(0xffffffff, LS1X_INTC_INTPOL(n));
> +		/* set DMA0, DMA1 and DMA2 to edge trigger */
> +		ls1x_writel(n ? 0x0 : 0xe000, LS1X_INTC_INTEDGE(n));
> +	}
> +
> +
> +	for (n = LS1X_IRQ_BASE; n < LS1X_IRQS; n++) {
> +		irq_set_chip_and_handler(n, &ls1x_cpu_irq_chip,
> +					 handle_level_irq);
> +	}
> +
> +	setup_irq(INT0_IRQ, &cascade_irqaction);
> +	setup_irq(INT1_IRQ, &cascade_irqaction);
> +	setup_irq(INT2_IRQ, &cascade_irqaction);
> +	setup_irq(INT3_IRQ, &cascade_irqaction);
> +	setup_irq(INT4_IRQ, &cascade_irqaction);
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops ls1x_cpu_intc_domain_ops = {
> +	.map = ls1x_cpu_intc_map,
> +	.xlate = irq_domain_xlate_onecell,
> +};
> +
> +static void __init __ls1x_irq_init(struct device_node *of_node)
> +{
> +	struct irq_domain *domain;
> +
> +	domain = irq_domain_add_legacy(of_node, LS1X_IRQS, LS1X_IRQ_BASE, 0,
> +				       &ls1x_cpu_intc_domain_ops, NULL);

Please take a look at using _simple() or _linear().

> +	if (!domain)
> +		panic("Failed to add irqdomain for MIPS CPU");
> +}
> +
> +void __init ls1x_cpu_irq_init(void)
> +{
> +	__ls1x_irq_init(NULL);
> +}
> +
> +static int __init ls1x_cpu_irq_of_init(
> +	struct device_node *node, struct device_node *parent)
> +
> +{
> +	__ls1x_irq_init(node);
> +	return 0;
> +}
> +
> +IRQCHIP_DECLARE(ls1x_cpu_intc, "loongson-1A cpu-irq-intc",
> +		ls1x_cpu_irq_of_init);
> -- 
> 1.9.1

thx,

Jason.
