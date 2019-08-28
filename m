Return-Path: <SRS0=KjQ3=WY=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343D4C3A5A3
	for <linux-mips@archiver.kernel.org>; Wed, 28 Aug 2019 00:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E82B12186A
	for <linux-mips@archiver.kernel.org>; Wed, 28 Aug 2019 00:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="UOfdGaVq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbfH1A1c (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 27 Aug 2019 20:27:32 -0400
Received: from forward104o.mail.yandex.net ([37.140.190.179]:59615 "EHLO
        forward104o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726077AbfH1A1c (ORCPT
        <rfc822;linux-mips@vger.kernel.org>);
        Tue, 27 Aug 2019 20:27:32 -0400
Received: from mxback16g.mail.yandex.net (mxback16g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:316])
        by forward104o.mail.yandex.net (Yandex) with ESMTP id C138C940469;
        Wed, 28 Aug 2019 03:27:25 +0300 (MSK)
Received: from smtp4p.mail.yandex.net (smtp4p.mail.yandex.net [2a02:6b8:0:1402::15:6])
        by mxback16g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id QilzggbnNc-RPu4TseI;
        Wed, 28 Aug 2019 03:27:25 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1566952045;
        bh=KFZ1BDucOcw7Hrk+NcoiBrCwMW1a4qxccycQvX/bjpY=;
        h=In-Reply-To:From:To:Subject:Cc:Date:References:Message-ID;
        b=UOfdGaVqYB3uJhYiE9g4/DF5Wi7Nn2l4Ukrj0mpKb5S2PwYUm8m+n1TWPbh5E5MQQ
         icdZ3ybu4X5lfq9BT/lwbKszGlO70Z+HKo1wlJh7wKRC69xzh0JMptxMFYztTXxEvJ
         JHY+cuue7R8zX+RGzEJUIMbn9IK06YSpOuNzFOFY=
Authentication-Results: mxback16g.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp4p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id IPYJKNpNbZ-RGfa7n2A;
        Wed, 28 Aug 2019 03:27:23 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH 04/13] irqchip: Add driver for Loongson-3 I/O interrupt
 controller
To:     Marc Zyngier <maz@kernel.org>, linux-mips@vger.kernel.org
Cc:     chenhc@lemote.com, paul.burton@mips.com, tglx@linutronix.de,
        jason@lakedaemon.net, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.co, devicetree@vger.kernel.org
References: <20190827085302.5197-1-jiaxun.yang@flygoat.com>
 <20190827085302.5197-5-jiaxun.yang@flygoat.com>
 <e6a5862f-0f6c-cab0-9f4a-51b7889d38e7@kernel.org>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <82c4b9ed-7270-74ce-6e10-165182e540dd@flygoat.com>
Date:   Wed, 28 Aug 2019 08:27:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e6a5862f-0f6c-cab0-9f4a-51b7889d38e7@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org


On 2019/8/28 上午12:45, Marc Zyngier wrote:
> On 27/08/2019 09:52, Jiaxun Yang wrote:
>> This controller appeared on Loongson-3 family of chips as the primary
>> package interrupt source.
>>
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> ---
>>   drivers/irqchip/Kconfig          |   9 ++
>>   drivers/irqchip/Makefile         |   1 +
>>   drivers/irqchip/irq-ls3-iointc.c | 216 +++++++++++++++++++++++++++++++
>>   3 files changed, 226 insertions(+)
>>   create mode 100644 drivers/irqchip/irq-ls3-iointc.c
>>
>> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
>> index 80e10f4e213a..8d9eac5fd4a7 100644
>> --- a/drivers/irqchip/Kconfig
>> +++ b/drivers/irqchip/Kconfig
>> @@ -471,6 +471,15 @@ config TI_SCI_INTA_IRQCHIP
>>   	  If you wish to use interrupt aggregator irq resources managed by the
>>   	  TI System Controller, say Y here. Otherwise, say N.
>>   
>> +config LS3_IOINTC
>> +	bool "Loongson3 I/O Interrupt Controller"
>> +	depends on MACH_LOONGSON64
>> +	default y
>> +	select IRQ_DOMAIN
>> +	select GENERIC_IRQ_CHIP
>> +	help
>> +	  Support for the Loongson-3 I/O Interrupt Controller.
>> +
>>   endmenu
>>   
>>   config SIFIVE_PLIC
>> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
>> index 8d0fcec6ab23..49ecb8d38138 100644
>> --- a/drivers/irqchip/Makefile
>> +++ b/drivers/irqchip/Makefile
>> @@ -102,3 +102,4 @@ obj-$(CONFIG_MADERA_IRQ)		+= irq-madera.o
>>   obj-$(CONFIG_LS1X_IRQ)			+= irq-ls1x.o
>>   obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)	+= irq-ti-sci-intr.o
>>   obj-$(CONFIG_TI_SCI_INTA_IRQCHIP)	+= irq-ti-sci-inta.o
>> +obj-$(CONFIG_LS3_IOINTC)			+= irq-ls3-iointc.o
>> diff --git a/drivers/irqchip/irq-ls3-iointc.c b/drivers/irqchip/irq-ls3-iointc.c
>> new file mode 100644
>> index 000000000000..1fc3c41c57d9
>> --- /dev/null
>> +++ b/drivers/irqchip/irq-ls3-iointc.c
>> @@ -0,0 +1,216 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + *  Copyright (C) 2019, Jiaxun Yang <jiaxun.yang@flygoat.com>
>> + *  Loongson-3 IOINTC IRQ support
>> + */
>> +
>> +#include <linux/errno.h>
>> +#include <linux/init.h>
>> +#include <linux/types.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/ioport.h>
>> +#include <linux/irqchip.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/io.h>
>> +#include <linux/smp.h>
>> +#include <linux/irqchip/chained_irq.h>
>> +
>> +
>> +#define LS3_CHIP_IRQ	32
>> +
>> +#define LS3_INTC_CHIP_START	0x20
>> +
>> +#define LS3_REG_INTC_STATUS	0x00
>> +#define LS3_REG_INTC_EN_STATUS	0x04
>> +#define LS3_REG_INTC_ENABLE	0x08
>> +#define LS3_REG_INTC_DISABLE	0x0c
>> +#define LS3_REG_INTC_POL	0x10
>> +#define LS3_REG_INTC_EDGE	0x18
>> +
>> +#define LS3_MAP_CORE_INT(x, y)	(u8)(BIT(x) | (BIT(y) << 4))
>> +
>> +
>> +struct ls3_iointc_priv {
>> +	struct irq_domain	*domain;
>> +	void __iomem		*intc_base;
>> +};
>> +
>> +
>> +static void ls3_io_chained_handle_irq(struct irq_desc *desc)
>> +{
>> +	struct ls3_iointc_priv *priv = irq_desc_get_handler_data(desc);
>> +	struct irq_chip *chip = irq_desc_get_chip(desc);
>> +	u32 pending;
>> +
>> +	chained_irq_enter(chip, desc);
>> +
>> +	pending = readl(priv->intc_base + LS3_REG_INTC_EN_STATUS) &
>> +		readl(priv->intc_base + LS3_REG_INTC_STATUS);
> Reading the enabled status from the HW on each interrupt? I'm sure
> that's pretty cheap...
Seems expensive but to deal with a buggy hardware... That's worthy.
>
>> +
>> +	if (!pending)
>> +		spurious_interrupt();
>> +
>> +	while (pending) {
>> +		int bit = __ffs(pending);
>> +
>> +		generic_handle_irq(irq_find_mapping(priv->domain, bit));
>> +		pending &= ~BIT(bit);
>> +	}
>> +
>> +	chained_irq_exit(chip, desc);
>> +}
>> +
>> +
>> +static void ls_intc_set_bit(struct irq_chip_generic *gc,
>> +							unsigned int offset,
>> +							u32 mask, bool set)
>> +{
>> +	if (set)
>> +		writel(readl(gc->reg_base + offset) | mask,
>> +		gc->reg_base + offset);
> Please correctly align the second line.
>
>> +	else
>> +		writel(readl(gc->reg_base + offset) & ~mask,
>> +		gc->reg_base + offset);
>> +}
> Have you tried this on a SMP system? A RMW without locking is unlikely
> to go down very well.
>
>> +
>> +static int ls_intc_set_type(struct irq_data *data, unsigned int type)
>> +{
>> +	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
>> +	u32 mask = data->mask;
>> +
>> +	switch (type) {
>> +	case IRQ_TYPE_LEVEL_HIGH:
>> +		ls_intc_set_bit(gc, LS3_REG_INTC_EDGE, mask, false);
>> +		ls_intc_set_bit(gc, LS3_REG_INTC_POL, mask, true);
>> +		break;
>> +	case IRQ_TYPE_LEVEL_LOW:
>> +		ls_intc_set_bit(gc, LS3_REG_INTC_EDGE, mask, false);
>> +		ls_intc_set_bit(gc, LS3_REG_INTC_POL, mask, false);
>> +		break;
>> +	case IRQ_TYPE_EDGE_RISING:
>> +		ls_intc_set_bit(gc, LS3_REG_INTC_EDGE, mask, true);
>> +		ls_intc_set_bit(gc, LS3_REG_INTC_POL, mask, true);
>> +		break;
>> +	case IRQ_TYPE_EDGE_FALLING:
>> +		ls_intc_set_bit(gc, LS3_REG_INTC_EDGE, mask, true);
>> +		ls_intc_set_bit(gc, LS3_REG_INTC_POL, mask, false);
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	irqd_set_trigger_type(data, type);
>> +	return 0;
>> +}
>> +
>> +int __init ls3_iointc_of_init(struct device_node *node,
>> +				       struct device_node *parent)
>> +{
>> +	struct irq_chip_generic *gc;
>> +	struct irq_chip_type *ct;
>> +	struct ls3_iointc_priv *priv;
>> +	int parent_irq, err = 0;
>> +	int core = cpu_logical_map(smp_processor_id());
> Are you guaranteed to be in a non-preemptible section here?
Yes, as irqchip will be initialized even earlier than clockevent. There 
must be non-preemptible.
>
>> +	int ip = 0;
>> +	int i;
>> +	const u32 *map_ip, *map_core;
>> +
>> +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	priv->intc_base = of_iomap(node, 0);
>> +	if (!priv->intc_base) {
>> +		err = -ENODEV;
>> +		goto out_free_priv;
>> +	}
>> +
>> +	map_ip = of_get_property(node, "loongson,map-ip", NULL);
>> +	if (!map_ip)
>> +		goto no_ip;
>> +	else if ((*map_ip) > 5)
>> +		pr_err("* %pOF loongson,map-ip is invalid\n", node);
>> +	else
>> +		ip = (*map_ip);
> What is this "ip"?
The interrupt line number of CPU (parent intc). As MIPS called CPU 
interrupt registers "CAUSE_IP".
>
>> +no_ip:
>> +
>> +	/* If this property does not exist or invalid,
>> +	 * we map all IRQs to bootcore.
>> +	 */
> Comment format.
>
>> +	map_core = of_get_property(node, "loongson,map-core", NULL);
>> +	if (!map_core)
>> +		goto no_core;
>> +	else if ((*map_core) > 3)
>> +		pr_err("* %pOF loongson,map-core is invalid\n", node);
>> +	else
>> +		core = (*map_core);
>> +no_core:
>> +
>> +	parent_irq = irq_of_parse_and_map(node, 0);
>> +	if (!parent_irq) {
>> +		pr_err("ls3-iointc: unable to get parent irq\n");
>> +		err =  -ENODEV;
>> +		goto out_iounmap;
>> +	}
>> +	/* Set up an IRQ domain */
>> +	priv->domain = irq_domain_add_linear(node, 32, &irq_generic_chip_ops,
>> +					     NULL);
>> +	if (!priv->domain) {
>> +		pr_err("ls3-iointc: cannot add IRQ domain\n");
>> +		err = -ENOMEM;
>> +		goto out_iounmap;
>> +	}
>> +
>> +	err = irq_alloc_domain_generic_chips(priv->domain, 32, 1,
>> +		node->full_name, handle_level_irq,
>> +		IRQ_NOPROBE, 0, 0);
>> +	if (err) {
>> +		pr_err("ls3-iointc: unable to register IRQ domain\n");
>> +		err = -ENOMEM;
>> +		goto out_free_domain;
>> +	}
>> +
>> +	/*
>> +	 * Q: Why don't we set IRQ affinity by these registers?
>> +	 * A: Hardware IRQ delivery is seriously broken,
>> +	 *    so we map all IRQs to a fixed core.
>> +	 */
>> +	pr_info("ls3-iointc: Mapping All ls3-iointc IRQ to core %d, IP %d\n", core, ip);
>> +	for (i = 0; i < LS3_CHIP_IRQ; i++)
>> +		writeb(LS3_MAP_CORE_INT(core, ip), priv->intc_base + 0x1 * i);
> This doesn't make much sense. If this is a chained irqchip, all
> interrupts end-up on a single CPU (the one that handle the parent IRQ).
> So how comes there is even a choice of picking a target CPU?

It's parent IRQ (mti,cpu-interrupt-controller) is a percpu IRQ.

In design, it allows us to decide affinity at runtime but actually 
hardware is seriously broken.

> Also, you still need to define a set_affinity() callback, even if it
> returns -EINVAL.
>
>> +	priv->intc_base += LS3_INTC_CHIP_START;
>> +
>> +	/* Disable all IRQs */
>> +	writel(0xffffffff, priv->intc_base + LS3_REG_INTC_DISABLE);
>> +	/* Set to level triggered */
>> +	writel(0x0, priv->intc_base + LS3_REG_INTC_EDGE);
>> +
>> +	gc = irq_get_domain_generic_chip(priv->domain, 0);
>> +	gc->reg_base = priv->intc_base;
>> +	gc->domain = priv->domain;
>> +
>> +	ct = gc->chip_types;
>> +	ct->regs.enable = LS3_REG_INTC_ENABLE;
>> +	ct->regs.disable = LS3_REG_INTC_DISABLE;
>> +	ct->chip.irq_unmask = irq_gc_unmask_enable_reg;
>> +	ct->chip.irq_mask = irq_gc_mask_disable_reg;
>> +	ct->chip.irq_mask_ack = irq_gc_mask_disable_reg;
>> +	ct->chip.irq_set_type = ls_intc_set_type;
>> +
>> +	irq_set_chained_handler_and_data(parent_irq,
>> +		ls3_io_chained_handle_irq, priv);
>> +
>> +	return 0;
>> +
>> +out_free_domain:
>> +	irq_domain_remove(priv->domain);
>> +out_iounmap:
>> +	iounmap(priv->intc_base);
>> +out_free_priv:
>> +	kfree(priv);
>> +
>> +	return err;
>> +}
>> +
>> +IRQCHIP_DECLARE(ls3_iointc, "loongson,ls3-iointc", ls3_iointc_of_init);
>>
> Thanks,
>
> 	M.
