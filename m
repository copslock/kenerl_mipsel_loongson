Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Nov 2017 15:37:04 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.154.231]:59647 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990498AbdKAOg4cX-PE convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 1 Nov 2017 15:36:56 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1403.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 01 Nov 2017 14:35:11 +0000
Received: from MIPSMAIL01.mipstec.com ([fe80::5c93:1f20:524d:a563]) by
 MIPSMAIL01.mipstec.com ([fe80::5c93:1f20:524d:a563%13]) with mapi id
 14.03.0361.001; Wed, 1 Nov 2017 07:34:35 -0700
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
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        "Paul Burton" <Paul.Burton@mips.com>,
        Petar Jovanovic <Petar.Jovanovic@mips.com>,
        Raghu Gandham <Raghu.Gandham@mips.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [PATCH v6 2/5] irqchip/irq-goldfish-pic: Add Goldfish PIC driver
Thread-Topic: [PATCH v6 2/5] irqchip/irq-goldfish-pic: Add Goldfish PIC
 driver
Thread-Index: AQHTUe+vLfaAecHEJUe+bWKT7ULMVKL/mMc+
Date:   Wed, 1 Nov 2017 14:34:34 +0000
Message-ID: <48924BBB91ABDE4D9335632A6B179DD6A73E51@MIPSMAIL01.mipstec.com>
References: <1509364642-21771-1-git-send-email-aleksandar.markovic@rt-rk.com>
        <1509364642-21771-3-git-send-email-aleksandar.markovic@rt-rk.com>,<86y3ns3vdr.fsf@arm.com>
In-Reply-To: <86y3ns3vdr.fsf@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [82.117.201.26]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-BESS-ID: 1509546911-321459-12709-83711-1
X-BESS-VER: 2017.12-r1709122024
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186481
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Miodrag.Dinic@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60631
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

Hello Marc,

> > +     gc = irq_alloc_generic_chip("GFPIC", 1, GFPIC_IRQ_BASE, gfpic->base,
> > +                                 handle_level_irq);
> > +
> > +     ct = gc->chip_types;
> 
> And what if the allocation fails?

Thanks, it will be addressed in V7.

Kind regards,
Miodrag
________________________________________
From: Marc Zyngier [marc.zyngier@arm.com]
Sent: Tuesday, October 31, 2017 3:26 AM
To: Aleksandar Markovic
Cc: linux-mips@linux-mips.org; Miodrag Dinic; Goran Ferenc; Aleksandar Markovic; David S. Miller; Douglas Leung; Greg Kroah-Hartman; James Hogan; Jason Cooper; linux-kernel@vger.kernel.org; Mauro Carvalho Chehab; Miodrag Dinic; Paul Burton; Petar Jovanovic; Raghu Gandham; Randy Dunlap; Thomas Gleixner
Subject: Re: [PATCH v6 2/5] irqchip/irq-goldfish-pic: Add Goldfish PIC driver

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

And what if the allocation fails?

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
> +     irq_set_chained_handler_and_data(parent_irq,
> +                                      goldfish_pic_cascade, gfpic);
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

Thanks,

        M.
--
Jazz is not dead. It just smells funny.
