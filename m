Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Aug 2017 17:37:29 +0200 (CEST)
Received: from foss.arm.com ([217.140.101.70]:41296 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992864AbdHRPhNAtp0s (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 18 Aug 2017 17:37:13 +0200
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C685B15A2;
        Fri, 18 Aug 2017 08:37:05 -0700 (PDT)
Received: from [10.1.207.16] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DADB03F540;
        Fri, 18 Aug 2017 08:37:04 -0700 (PDT)
Subject: Re: [PATCH 34/38] irqchip: mips-gic: Make pcpu_masks a per-cpu
 variable
To:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>
References: <20170813043646.25821-1-paul.burton@imgtec.com>
 <20170813043646.25821-35-paul.burton@imgtec.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <80cfe904-c724-26dd-6802-b2f1b49062be@arm.com>
Date:   Fri, 18 Aug 2017 16:37:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170813043646.25821-35-paul.burton@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Return-Path: <marc.zyngier@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59672
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
> Define the pcpu_masks variable using the kernel's standard per-cpu
> variable support, rather than an open-coded array of structs containing
> bitmaps.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-mips@linux-mips.org
> ---
> 
>  drivers/irqchip/irq-mips-gic.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
> index feff4bf97577..00153231376a 100644
> --- a/drivers/irqchip/irq-mips-gic.c
> +++ b/drivers/irqchip/irq-mips-gic.c
> @@ -13,6 +13,7 @@
>  #include <linux/irq.h>
>  #include <linux/irqchip.h>
>  #include <linux/of_address.h>
> +#include <linux/percpu.h>
>  #include <linux/sched.h>
>  #include <linux/smp.h>
>  
> @@ -23,6 +24,7 @@
>  #include <dt-bindings/interrupt-controller/mips-gic.h>
>  
>  #define GIC_MAX_INTRS		256
> +#define GIC_MAX_LONGS		BITS_TO_LONGS(GIC_MAX_INTRS)
>  
>  /* Add 2 to convert GIC CPU pin to core interrupt */
>  #define GIC_CPU_PIN_OFFSET	2
> @@ -40,11 +42,8 @@
>  
>  void __iomem *mips_gic_base;
>  
> -struct gic_pcpu_mask {
> -	DECLARE_BITMAP(pcpu_mask, GIC_MAX_INTRS);
> -};
> +DEFINE_PER_CPU_READ_MOSTLY(unsigned long[GIC_MAX_LONGS], pcpu_masks);
>  
> -static struct gic_pcpu_mask pcpu_masks[NR_CPUS];
>  static DEFINE_SPINLOCK(gic_lock);
>  static struct irq_domain *gic_irq_domain;
>  static struct irq_domain *gic_ipi_domain;
> @@ -137,7 +136,7 @@ static void gic_handle_shared_int(bool chained)
>  	DECLARE_BITMAP(intrmask, GIC_MAX_INTRS);
>  
>  	/* Get per-cpu bitmaps */
> -	pcpu_mask = pcpu_masks[smp_processor_id()].pcpu_mask;
> +	pcpu_mask = this_cpu_ptr(pcpu_masks);
>  
>  	if (mips_cm_is64) {
>  		__ioread64_copy(pending, addr_gic_pend(),
> @@ -254,8 +253,8 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *cpumask,
>  
>  	/* Update the pcpu_masks */
>  	for (i = 0; i < min(gic_vpes, NR_CPUS); i++)

Is there any case where gic_vpes is not equal to nr_cpus?

> -		clear_bit(irq, pcpu_masks[i].pcpu_mask);
> -	set_bit(irq, pcpu_masks[cpumask_first(&tmp)].pcpu_mask);
> +		clear_bit(irq, per_cpu_ptr(pcpu_masks, i));
> +	set_bit(irq, per_cpu_ptr(pcpu_masks, cpumask_first(&tmp)));
>  
>  	cpumask_copy(irq_data_get_affinity_mask(d), cpumask);
>  	spin_unlock_irqrestore(&gic_lock, flags);
> @@ -416,8 +415,8 @@ static int gic_shared_irq_domain_map(struct irq_domain *d, unsigned int virq,
>  	write_gic_map_pin(intr, GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin);
>  	write_gic_map_vp(intr, BIT(mips_cm_vp_id(vpe)));
>  	for (i = 0; i < min(gic_vpes, NR_CPUS); i++)
> -		clear_bit(intr, pcpu_masks[i].pcpu_mask);
> -	set_bit(intr, pcpu_masks[vpe].pcpu_mask);
> +		clear_bit(intr, per_cpu_ptr(pcpu_masks, i));
> +	set_bit(intr, per_cpu_ptr(pcpu_masks, vpe));
>  	spin_unlock_irqrestore(&gic_lock, flags);
>  
>  	return 0;
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
