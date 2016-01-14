Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jan 2016 09:11:10 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:58492 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007755AbcANILHECwir (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Jan 2016 09:11:07 +0100
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1aJczo-0001dv-OB; Thu, 14 Jan 2016 09:11:04 +0100
Date:   Thu, 14 Jan 2016 09:10:09 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Joshua Henderson <joshua.henderson@microchip.com>
cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v5 02/14] irqchip: irq-pic32-evic: Add support for PIC32
 interrupt controller
In-Reply-To: <1452734299-460-3-git-send-email-joshua.henderson@microchip.com>
Message-ID: <alpine.DEB.2.11.1601140901210.3575@nanos>
References: <1452734299-460-1-git-send-email-joshua.henderson@microchip.com> <1452734299-460-3-git-send-email-joshua.henderson@microchip.com>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51112
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
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

On Wed, 13 Jan 2016, Joshua Henderson wrote:
> +static int pic32_set_type_edge(struct irq_data *data,
> +			       unsigned int flow_type)
> +{
> +	struct evic_chip_data *priv = irqd_to_priv(data);
> +	int ret;
> +	int i;
> +
> +	if (!(flow_type & IRQ_TYPE_EDGE_BOTH))
> +		return -EBADR;
> +
> +	/* set polarity for external interrupts only */
> +	for (i = 0; i < ARRAY_SIZE(priv->ext_irqs); i++) {
> +		if (priv->ext_irqs[i] == data->hwirq) {
> +			ret = pic32_set_ext_polarity(i + 1, flow_type);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +
> +	irqd_set_trigger_type(data, flow_type);

The core code handles that already.

> +static int pic32_irq_domain_map(struct irq_domain *d, unsigned int virq,
> +				irq_hw_number_t hw)
> +{
> +	struct evic_chip_data *priv = d->host_data;
> +	struct irq_data *data;
> +	int ret;
> +	u32 iecclr, ifsclr;
> +	u32 reg, mask;
> +
> +	ret = irq_map_generic_chip(d, virq, hw);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Piggyback on xlate function to move to an alternate chip as necessary
> +	 * at time of mapping instead of allowing the flow handler/chip to be
> +	 * changed later. This requires all interrupts to be configured through
> +	 * DT.
> +	 */
> +	if (priv->irq_types[hw] & IRQ_TYPE_SENSE_MASK) {
> +		data = irq_domain_get_irq_data(d, virq);
> +		irqd_set_trigger_type(data, priv->irq_types[hw]);
> +		irq_setup_alt_chip(data, priv->irq_types[hw]);
> +	}

I like that approach.

So except for the nit in pic32_set_type_edge() this looks good. It's pretty
clear now what the code does and how the hardware works.

Thanks for following up!

       tglx
