Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Feb 2016 10:07:47 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:47352 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010034AbcBEJHpF-H1g (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Feb 2016 10:07:45 +0100
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1aRcMf-0002Tc-Nf; Fri, 05 Feb 2016 10:07:41 +0100
Date:   Fri, 5 Feb 2016 10:06:34 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     David Daney <ddaney.cavm@gmail.com>
cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 6/7] [PATCH] MIPS: OCTEON: Add support for OCTEON III
 interrupt controller.
In-Reply-To: <1454632974-7686-7-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <alpine.DEB.2.11.1602050954480.25254@nanos>
References: <1454632974-7686-1-git-send-email-ddaney.cavm@gmail.com> <1454632974-7686-7-git-send-email-ddaney.cavm@gmail.com>
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
X-archive-position: 51806
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

On Thu, 4 Feb 2016, David Daney wrote:
> +static int octeon_irq_ciu_set_type(struct irq_data *data, unsigned int t)
> +{
> +	irqd_set_trigger_type(data, t);
> +
> +	if (irqd_get_trigger_type(data) & IRQ_TYPE_EDGE_BOTH)
> +		irq_set_handler_locked(data, handle_edge_irq);
> +	else
> +		irq_set_handler_locked(data, handle_level_irq);
> +
> +	return IRQ_SET_MASK_OK;

That doesn't make any sense. First you store the type 't' in irq data, then
you query irq data for the type and at the end you tell the core to set the
type in irq data.

     if (t & IRQ_TYPE_EDGE_BOTH)
     	...
     else
        ...
     return IRQ_SET_MASK_OK;

does the same, right?

> +int octeon_irq_ciu3_xlat(struct irq_domain *d,

static ?

> +			 struct device_node *node,
> +			 const u32 *intspec,
> +			 unsigned int intsize,
> +			 unsigned long *out_hwirq,
> +			 unsigned int *out_type)
> +{
> +
> +void octeon_irq_ciu3_enable(struct irq_data *data)

static 

> +void octeon_irq_ciu3_disable(struct irq_data *data)
> +void octeon_irq_ciu3_ack(struct irq_data *data)
> +void octeon_irq_ciu3_mask(struct irq_data *data)
> +void octeon_irq_ciu3_mask_ack(struct irq_data *data)
> +int octeon_irq_ciu3_set_affinity(struct irq_data *data,
> +				 const struct cpumask *dest, bool force)

ditto

> +int octeon_irq_ciu3_mapx(struct irq_domain *d, unsigned int virq,
> +			 irq_hw_number_t hw, struct irq_chip *chip)

....

> +void octeon_ciu3_mbox_send(int cpu, unsigned int mbox)
> +{
> +	struct octeon_ciu3_info *ciu3_info;
> +	unsigned int intsn;
> +	union cvmx_ciu3_iscx_w1s isc_w1s;
> +	u64 isc_w1s_addr;
> +
> +	if (WARN_ON_ONCE(mbox >= CIU3_MBOX_PER_CORE))
> +		return;
> +
> +	intsn = octeon_irq_ciu3_mbox_intsn_for_cpu(cpu, mbox);
> +	ciu3_info = per_cpu(octeon_ciu3_info, cpu);
> +	isc_w1s_addr = ciu3_info->ciu3_addr + CIU3_ISC_W1S(intsn);
> +
> +	isc_w1s.u64 = 0;
> +	isc_w1s.s.raw = 1;
> +
> +	cvmx_write_csr(isc_w1s_addr, isc_w1s.u64);
> +	cvmx_read_csr(isc_w1s_addr);
> +}
> +EXPORT_SYMBOL(octeon_ciu3_mbox_send);

Why need modules that function?

Thanks,

	tglx
