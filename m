Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Oct 2017 03:27:01 +0100 (CET)
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35008 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992215AbdJaC0yZwKe- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Oct 2017 03:26:54 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D281280D;
        Mon, 30 Oct 2017 19:26:46 -0700 (PDT)
Received: from zomby-woof (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 237D93F24A;
        Mon, 30 Oct 2017 19:26:42 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc:     <linux-mips@linux-mips.org>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        Goran Ferenc <goran.ferenc@mips.com>,
        Aleksandar Markovic <aleksandar.markovic@mips.com>,
        "David S. Miller" <davem@davemloft.net>,
        Douglas Leung <douglas.leung@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Hogan <james.hogan@mips.com>,
        Jason Cooper <jason@lakedaemon.net>,
        <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Paul Burton <paul.burton@mips.com>,
        Petar Jovanovic <petar.jovanovic@mips.com>,
        Raghu Gandham <raghu.gandham@mips.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v6 2/5] irqchip/irq-goldfish-pic: Add Goldfish PIC driver
In-Reply-To: <1509364642-21771-3-git-send-email-aleksandar.markovic@rt-rk.com>
        (Aleksandar Markovic's message of "Mon, 30 Oct 2017 12:56:33 +0100")
Organization: ARM Ltd
References: <1509364642-21771-1-git-send-email-aleksandar.markovic@rt-rk.com>
        <1509364642-21771-3-git-send-email-aleksandar.markovic@rt-rk.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
Date:   Tue, 31 Oct 2017 02:26:40 +0000
Message-ID: <86y3ns3vdr.fsf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <marc.zyngier@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60597
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

On Mon, Oct 30 2017 at 12:56:33 pm GMT, Aleksandar Markovic <aleksandar.markovic@rt-rk.com> wrote:
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

[...]

> diff --git a/drivers/irqchip/irq-goldfish-pic.c b/drivers/irqchip/irq-goldfish-pic.c
> new file mode 100644
> index 0000000..48fb773
> --- /dev/null
> +++ b/drivers/irqchip/irq-goldfish-pic.c

[...]

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
> +		pr_err("Failed to map Goldfish PIC parent IRQ\n");
> +		ret = -EINVAL;
> +		goto out_free;
> +	}
> +
> +	gfpic->base = of_iomap(of_node, 0);
> +	if (!gfpic->base) {
> +		pr_err("Failed to map Goldfish PIC base\n");
> +		ret = -ENOMEM;
> +		goto out_unmap_irq;
> +	}
> +
> +	/* Mask interrupts. */
> +	writel(1, gfpic->base + GFPIC_REG_IRQ_DISABLE_ALL);
> +
> +	gc = irq_alloc_generic_chip("GFPIC", 1, GFPIC_IRQ_BASE, gfpic->base,
> +				    handle_level_irq);
> +
> +	ct = gc->chip_types;

And what if the allocation fails?

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
> +		pr_err("Failed to add irqdomain for Goldfish PIC\n");
> +		ret = -EINVAL;
> +		goto out_iounmap;
> +	}
> +
> +	irq_set_chained_handler_and_data(parent_irq,
> +					 goldfish_pic_cascade, gfpic);
> +
> +	pr_info("Successfully registered Goldfish PIC\n");
> +	return 0;
> +
> +out_iounmap:
> +	iounmap(gfpic->base);
> +out_unmap_irq:
> +	irq_dispose_mapping(parent_irq); 
> +out_free:
> +	kfree(gfpic);
> +out_err:
> +	return ret;
> +}
> +
> +IRQCHIP_DECLARE(google_gf_pic, "google,goldfish-pic", goldfish_pic_of_init);

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
