Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Oct 2017 17:04:47 +0200 (CEST)
Received: from 20pmail.ess.barracuda.com ([64.235.154.232]:52786 "EHLO
        20pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990506AbdJWPEjgP5Tj convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 23 Oct 2017 17:04:39 +0200
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1412.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Mon, 23 Oct 2017 15:02:50 +0000
Received: from MIPSMAIL01.mipstec.com ([fe80::5c93:1f20:524d:a563]) by
 MIPSMAIL01.mipstec.com ([fe80::5c93:1f20:524d:a563%13]) with mapi id
 14.03.0361.001; Mon, 23 Oct 2017 08:01:58 -0700
From:   Miodrag Dinic <Miodrag.Dinic@mips.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Goran Ferenc <Goran.Ferenc@mips.com>,
        Aleksandar Markovic <Aleksandar.Markovic@mips.com>,
        "David S. Miller" <davem@davemloft.net>,
        Douglas Leung <Douglas.Leung@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Hogan <James.Hogan@mips.com>,
        Jason Cooper <jason@lakedaemon.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        Paul Burton <Paul.Burton@mips.com>,
        "Petar Jovanovic" <Petar.Jovanovic@mips.com>,
        Raghu Gandham <Raghu.Gandham@mips.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [PATCH v5 2/5] irqchip/irq-goldfish-pic: Add Goldfish PIC driver
Thread-Topic: [PATCH v5 2/5] irqchip/irq-goldfish-pic: Add Goldfish PIC
 driver
Thread-Index: AQHTS9e4ZtZScpY9a0K465tIPZVCtqLxh43K
Date:   Mon, 23 Oct 2017 15:01:57 +0000
Message-ID: <48924BBB91ABDE4D9335632A6B179DD6A713C0@MIPSMAIL01.mipstec.com>
References: <1508510055-6167-1-git-send-email-aleksandar.markovic@rt-rk.com>
        <1508510055-6167-3-git-send-email-aleksandar.markovic@rt-rk.com>,<864lqqgtse.fsf@arm.com>
In-Reply-To: <864lqqgtse.fsf@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [82.117.201.26]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-BESS-ID: 1508770969-452060-6850-136151-1
X-BESS-VER: 2017.12.1-r1709122024
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186224
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Miodrag.Dinic@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60526
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Miodrag.Dinic@mips.com
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

Hi Marc,

> > +static irqreturn_t goldfish_pic_cascade(int irq, void *data)
> > +{
> > +     struct goldfish_pic_data *gfpic = irq_get_handler_data(irq);
> > +     u32 hwirq;
> > +     u32 virq;
> > +
> > +     hwirq = readl(gfpic->base + GFPIC_REG_IRQ_PENDING);
> > +
> > +     virq = irq_linear_revmap(gfpic->irq_domain, hwirq);
> > +     generic_handle_irq(virq);
> > +
> > +     return IRQ_HANDLED;
> > +}
> 
> This is not how we implement cascaded (chained) interrupt
> controllers. See existing examples everywhere in the irqchip directory.

It will be addressed in V6.

Thank you.

Kind regards,
Miodrag

________________________________________
From: Marc Zyngier [marc.zyngier@arm.com]
Sent: Monday, October 23, 2017 10:20 AM
To: Aleksandar Markovic
Cc: linux-mips@linux-mips.org; Miodrag Dinic; Goran Ferenc; Aleksandar Markovic; David S. Miller; Douglas Leung; Greg Kroah-Hartman; James Hogan; Jason Cooper; linux-kernel@vger.kernel.org; Mauro Carvalho Chehab; Paul Burton; Petar Jovanovic; Raghu Gandham; Randy Dunlap; Thomas Gleixner
Subject: Re: [PATCH v5 2/5] irqchip/irq-goldfish-pic: Add Goldfish PIC driver

On Fri, Oct 20 2017 at  4:33:35 pm BST, Aleksandar Markovic <aleksandar.markovic@rt-rk.com> wrote:
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
>  drivers/irqchip/irq-goldfish-pic.c | 131 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 141 insertions(+)
>  create mode 100644 drivers/irqchip/irq-goldfish-pic.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4d5108f..f1be016 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -876,6 +876,7 @@ ANDROID GOLDFISH PIC DRIVER
>  M:   Miodrag Dinic <miodrag.dinic@mips.com>
>  S:   Supported
>  F:   Documentation/devicetree/bindings/interrupt-controller/google,goldfish-pic.txt
> +F:   drivers/irqchip/irq-goldfish-pic.c
>
>  ANDROID GOLDFISH RTC DRIVER
>  M:   Miodrag Dinic <miodrag.dinic@mips.com>
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index 9d8a1dd..712b561 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -321,3 +321,11 @@ config IRQ_UNIPHIER_AIDET
>       select IRQ_DOMAIN_HIERARCHY
>       help
>         Support for the UniPhier AIDET (ARM Interrupt Detector).
> +
> +config GOLDFISH_PIC
> +     bool "Goldfish programmable interrupt controller"
> +     depends on MIPS && (GOLDFISH || COMPILE_TEST)
> +     select IRQ_DOMAIN
> +     help
> +       Say yes here to enable Goldfish interrupt controller driver used
> +       for Goldfish based virtual platforms.
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index 845abc1..0e7a224 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -79,3 +79,4 @@ obj-$(CONFIG_ARCH_ASPEED)           += irq-aspeed-vic.o irq-aspeed-i2c-ic.o
>  obj-$(CONFIG_STM32_EXTI)             += irq-stm32-exti.o
>  obj-$(CONFIG_QCOM_IRQ_COMBINER)              += qcom-irq-combiner.o
>  obj-$(CONFIG_IRQ_UNIPHIER_AIDET)     += irq-uniphier-aidet.o
> +obj-$(CONFIG_GOLDFISH_PIC)           += irq-goldfish-pic.o
> diff --git a/drivers/irqchip/irq-goldfish-pic.c b/drivers/irqchip/irq-goldfish-pic.c
> new file mode 100644
> index 0000000..d8b5277
> --- /dev/null
> +++ b/drivers/irqchip/irq-goldfish-pic.c
> @@ -0,0 +1,131 @@
> +/*
> + * Copyright (C) 2017 Imagination Technologies Ltd.  All rights reserved
> + *   Author: Miodrag Dinic <miodrag.dinic@imgtec.com>
> + *
> + * This file implements interrupt controller driver for MIPS Goldfish PIC.
> + *
> + * This program is free software; you can redistribute       it and/or modify it
> + * under  the terms of       the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/irqchip.h>
> +#include <linux/irqdomain.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +
> +#define GFPIC_NR_IRQS                        32
> +
> +/* 8..39 Cascaded Goldfish PIC interrupts */
> +#define GFPIC_IRQ_BASE                       8
> +
> +#define GFPIC_REG_IRQ_PENDING                0x04
> +#define GFPIC_REG_IRQ_DISABLE_ALL    0x08
> +#define GFPIC_REG_IRQ_DISABLE                0x0c
> +#define GFPIC_REG_IRQ_ENABLE         0x10
> +
> +struct goldfish_pic_data {
> +     void __iomem *base;
> +     struct irq_domain *irq_domain;
> +};
> +
> +static irqreturn_t goldfish_pic_cascade(int irq, void *data)
> +{
> +     struct goldfish_pic_data *gfpic = irq_get_handler_data(irq);
> +     u32 hwirq;
> +     u32 virq;
> +
> +     hwirq = readl(gfpic->base + GFPIC_REG_IRQ_PENDING);
> +
> +     virq = irq_linear_revmap(gfpic->irq_domain, hwirq);
> +     generic_handle_irq(virq);
> +
> +     return IRQ_HANDLED;
> +}

This is not how we implement cascaded (chained) interrupt
controllers. See existing examples everywhere in the irqchip directory.

> +
> +static const struct irq_domain_ops goldfish_irq_domain_ops = {
> +     .xlate = irq_domain_xlate_onecell,
> +};
> +
> +static struct irqaction cascade = {
> +     .handler        = goldfish_pic_cascade,
> +     .name           = "Goldfish PIC cascade",
> +};
> +
> +static int __init goldfish_pic_of_init(struct device_node *of_node,
> +                                    struct device_node *parent)
> +{
> +     struct goldfish_pic_data *gfpic;
> +     struct irq_chip_generic *gc;
> +     struct irq_chip_type *ct;
> +     unsigned int parent_irq;
> +     int ret = 0;
> +
> +     gfpic = kzalloc(sizeof(*gfpic), GFP_KERNEL);
> +     if (!gfpic) {
> +             ret = -ENOMEM;
> +             goto out_err;
> +     }
> +
> +     parent_irq = irq_of_parse_and_map(of_node, 0);
> +     if (!parent_irq) {
> +             pr_err("Failed to map Goldfish PIC parent IRQ\n");
> +             ret = -EINVAL;
> +             goto out_free;
> +     }
> +
> +     ret = irq_set_handler_data(parent_irq, gfpic);
> +     if (ret)
> +             goto out_unmap_irq;
> +
> +     gfpic->base = of_iomap(of_node, 0);
> +     if (!gfpic->base) {
> +             pr_err("Failed to map Goldfish PIC base\n");
> +             ret = -ENOMEM;
> +             goto out_unmap_irq;
> +     }
> +
> +     /* Mask interrupts. */
> +     writel(1, gfpic->base + GFPIC_REG_IRQ_DISABLE_ALL);
> +
> +     gc = irq_alloc_generic_chip("GFPIC", 1, GFPIC_IRQ_BASE, gfpic->base,
> +                                 handle_level_irq);
> +
> +     ct = gc->chip_types;
> +     ct->regs.enable = GFPIC_REG_IRQ_ENABLE;
> +     ct->regs.disable = GFPIC_REG_IRQ_DISABLE;
> +     ct->chip.irq_unmask = irq_gc_unmask_enable_reg;
> +     ct->chip.irq_mask = irq_gc_mask_disable_reg;
> +
> +     irq_setup_generic_chip(gc, IRQ_MSK(GFPIC_NR_IRQS), 0, 0,
> +                            IRQ_NOPROBE | IRQ_LEVEL);
> +
> +     gfpic->irq_domain = irq_domain_add_legacy(of_node, GFPIC_NR_IRQS,
> +                                               GFPIC_IRQ_BASE, 0,
> +                                               &goldfish_irq_domain_ops,
> +                                               NULL);
> +     if (!gfpic->irq_domain) {
> +             pr_err("Failed to add irqdomain for Goldfish PIC\n");
> +             ret = -EINVAL;
> +             goto out_iounmap;
> +     }
> +
> +     setup_irq(parent_irq, &cascade);
> +
> +     pr_info("Successfully registered Goldfish PIC\n");
> +     return 0;
> +
> +out_iounmap:
> +     iounmap(gfpic->base);
> +out_unmap_irq:
> +     irq_dispose_mapping(parent_irq);
> +out_free:
> +     kfree(gfpic);
> +out_err:
> +     return ret;
> +}
> +
> +IRQCHIP_DECLARE(google_gf_pic, "google,goldfish-pic", goldfish_pic_of_init);

It otherwise looks much better than the previous versions.

Thanks,

        M.
--
Jazz is not dead. It just smells funny.
