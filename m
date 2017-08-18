Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Aug 2017 17:44:39 +0200 (CEST)
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41380 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994913AbdHRPo0nV0Ys (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Aug 2017 17:44:26 +0200
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5FAC15A2;
        Fri, 18 Aug 2017 08:44:17 -0700 (PDT)
Received: from [10.1.207.16] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7B393F540;
        Fri, 18 Aug 2017 08:44:16 -0700 (PDT)
Subject: Re: [PATCH 35/38] irqchip: mips-gic: Use pcpu_masks to avoid reading
 GIC_SH_MASK*
To:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>
References: <20170813043646.25821-1-paul.burton@imgtec.com>
 <20170813043646.25821-36-paul.burton@imgtec.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <405f8fc2-2947-cc68-e40a-b7e26a03e713@arm.com>
Date:   Fri, 18 Aug 2017 16:44:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170813043646.25821-36-paul.burton@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Return-Path: <marc.zyngier@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59673
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

On 13/08/17 05:36, Paul Burton wrote:
> This patch avoids the need to read the GIC_SH_MASK* registers when
> decoding shared interrupts by setting & clearing the interrupt's bit in
> the appropriate CPU's pcpu_masks entry when masking or unmasking the
> interrupt.
> 
> This effectively means that whilst an interrupt is masked we clear its
> bit in all pcpu_masks, which causes gic_handle_shared_int() to ignore it
> on all CPUs without needing to check GIC_SH_MASK*.
> 
> In essence, we add a little overhead to masking or unmasking interrupts
> but in return reduce the overhead of the far more common task of
> decoding interrupts.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-mips@linux-mips.org
> ---
> 
>  drivers/irqchip/irq-mips-gic.c | 49 ++++++++++++++++++++++++------------------
>  1 file changed, 28 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
> index 00153231376a..7a42f0b3822f 100644
> --- a/drivers/irqchip/irq-mips-gic.c
> +++ b/drivers/irqchip/irq-mips-gic.c
> @@ -55,6 +55,19 @@ static struct irq_chip gic_level_irq_controller, gic_edge_irq_controller;
>  DECLARE_BITMAP(ipi_resrv, GIC_MAX_INTRS);
>  DECLARE_BITMAP(ipi_available, GIC_MAX_INTRS);
>  
> +static void gic_setup_pcpu_mask(unsigned int intr, unsigned int cpu)
> +{
> +	unsigned int i;
> +
> +	/* Clear the interrupt's bit in all pcpu_masks */
> +	for_each_possible_cpu(i)
> +		clear_bit(intr, per_cpu_ptr(pcpu_masks, i));

This iterates from 0 to nr_cpu_ids-1...

> +
> +	/* Set the interrupt's bit in the appropriate CPU's mask */
> +	if (cpu < NR_CPUS)

and here you're using NR_CPUS. I'm a bit worried that you're not quite
using the same thing (nr_cpu_ids <= NR_CPUS).

> +		set_bit(intr, per_cpu_ptr(pcpu_masks, cpu));
> +}
> +
>  static bool gic_local_irq_is_routable(int intr)
>  {
>  	u32 vpe_ctl;
> @@ -133,24 +146,17 @@ static void gic_handle_shared_int(bool chained)
>  	unsigned int intr, virq;
>  	unsigned long *pcpu_mask;
>  	DECLARE_BITMAP(pending, GIC_MAX_INTRS);
> -	DECLARE_BITMAP(intrmask, GIC_MAX_INTRS);
>  
>  	/* Get per-cpu bitmaps */
>  	pcpu_mask = this_cpu_ptr(pcpu_masks);
>  
> -	if (mips_cm_is64) {
> +	if (mips_cm_is64)
>  		__ioread64_copy(pending, addr_gic_pend(),
>  				DIV_ROUND_UP(gic_shared_intrs, 64));
> -		__ioread64_copy(intrmask, addr_gic_mask(),
> -				DIV_ROUND_UP(gic_shared_intrs, 64));
> -	} else {
> +	else
>  		__ioread32_copy(pending, addr_gic_pend(),
>  				DIV_ROUND_UP(gic_shared_intrs, 32));
> -		__ioread32_copy(intrmask, addr_gic_mask(),
> -				DIV_ROUND_UP(gic_shared_intrs, 32));
> -	}
>  
> -	bitmap_and(pending, pending, intrmask, gic_shared_intrs);
>  	bitmap_and(pending, pending, pcpu_mask, gic_shared_intrs);
>  
>  	for_each_set_bit(intr, pending, gic_shared_intrs) {
> @@ -165,12 +171,19 @@ static void gic_handle_shared_int(bool chained)
>  
>  static void gic_mask_irq(struct irq_data *d)
>  {
> -	write_gic_rmask(BIT(GIC_HWIRQ_TO_SHARED(d->hwirq)));
> +	unsigned int intr = GIC_HWIRQ_TO_SHARED(d->hwirq);
> +
> +	write_gic_rmask(BIT(intr));
> +	gic_setup_pcpu_mask(intr, NR_CPUS);
>  }
>  
>  static void gic_unmask_irq(struct irq_data *d)
>  {
> -	write_gic_smask(BIT(GIC_HWIRQ_TO_SHARED(d->hwirq)));
> +	struct cpumask *affinity = irq_data_get_affinity_mask(d);
> +	unsigned int intr = GIC_HWIRQ_TO_SHARED(d->hwirq);
> +
> +	write_gic_smask(BIT(intr));
> +	gic_setup_pcpu_mask(intr, cpumask_first_and(affinity, cpu_online_mask));
>  }
>  
>  static void gic_ack_irq(struct irq_data *d)
> @@ -239,7 +252,6 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *cpumask,
>  	unsigned int irq = GIC_HWIRQ_TO_SHARED(d->hwirq);
>  	cpumask_t	tmp = CPU_MASK_NONE;
>  	unsigned long	flags;
> -	int		i;
>  
>  	cpumask_and(&tmp, cpumask, cpu_online_mask);
>  	if (cpumask_empty(&tmp))
> @@ -252,9 +264,7 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *cpumask,
>  	write_gic_map_vp(irq, BIT(mips_cm_vp_id(cpumask_first(&tmp))));
>  
>  	/* Update the pcpu_masks */
> -	for (i = 0; i < min(gic_vpes, NR_CPUS); i++)
> -		clear_bit(irq, per_cpu_ptr(pcpu_masks, i));
> -	set_bit(irq, per_cpu_ptr(pcpu_masks, cpumask_first(&tmp)));
> +	gic_setup_pcpu_mask(irq, read_gic_mask(irq) ? cpumask_first(&tmp) : NR_CPUS);
>  
>  	cpumask_copy(irq_data_get_affinity_mask(d), cpumask);
>  	spin_unlock_irqrestore(&gic_lock, flags);
> @@ -405,18 +415,15 @@ static int gic_local_irq_domain_map(struct irq_domain *d, unsigned int virq,
>  }
>  
>  static int gic_shared_irq_domain_map(struct irq_domain *d, unsigned int virq,
> -				     irq_hw_number_t hw, unsigned int vpe)
> +				     irq_hw_number_t hw, unsigned int cpu)
>  {
>  	int intr = GIC_HWIRQ_TO_SHARED(hw);
>  	unsigned long flags;
> -	int i;
>  
>  	spin_lock_irqsave(&gic_lock, flags);
>  	write_gic_map_pin(intr, GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin);
> -	write_gic_map_vp(intr, BIT(mips_cm_vp_id(vpe)));
> -	for (i = 0; i < min(gic_vpes, NR_CPUS); i++)
> -		clear_bit(intr, per_cpu_ptr(pcpu_masks, i));
> -	set_bit(intr, per_cpu_ptr(pcpu_masks, vpe));
> +	write_gic_map_vp(intr, BIT(mips_cm_vp_id(cpu)));
> +	gic_setup_pcpu_mask(intr, cpu);
>  	spin_unlock_irqrestore(&gic_lock, flags);
>  
>  	return 0;
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
