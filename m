Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2016 12:28:18 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:4011 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990522AbcIBK2KIiPq5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Sep 2016 12:28:10 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 494FAC333B4F0;
        Fri,  2 Sep 2016 11:27:49 +0100 (IST)
Received: from [10.150.130.83] (10.150.130.83) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 2 Sep
 2016 11:27:51 +0100
Subject: Re: [PATCH 1/6] irqchip: mips-gic: Add context saving for
 MIPS_REMOTEPROC
To:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <1472810395-21381-1-git-send-email-matt.redfearn@imgtec.com>
 <1472810395-21381-2-git-send-email-matt.redfearn@imgtec.com>
CC:     <linux-mips@linux-mips.org>, <lisa.parratt@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>
From:   Matt Redfearn <matt.redfearn@imgtec.com>
Message-ID: <752af60d-bf34-9bd5-20c0-c2dd9ae86c66@imgtec.com>
Date:   Fri, 2 Sep 2016 11:27:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1472810395-21381-2-git-send-email-matt.redfearn@imgtec.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54982
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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



On 02/09/16 10:59, Matt Redfearn wrote:
> The MIPS remote processor driver allows non-Linux firmware to take
> control of and execute on one of the systems VPEs. If that VPE is
> brought back under Linux, it is necessary to ensure that all GIC
> interrupts are routed and masked as Linux expects them, as the firmware
> can have done anything it likes with the GIC configuration (hopefully
> just for that VPEs local interrupt sources, but allow for shared
> external interrupts as well).
>
> The configuration of shared and local CPU interrupts is maintained and
> updated every time a change is made. When a CPU is brought online, the
> saved configuration is restored.
>
> These functions will also be useful for restoring GIC context after a
> suspend to RAM.
>
> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
> ---
>
>   drivers/irqchip/irq-mips-gic.c | 185 +++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 178 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
> index 83f498393a7f..5ba1fe1468ce 100644
> --- a/drivers/irqchip/irq-mips-gic.c
> +++ b/drivers/irqchip/irq-mips-gic.c
> @@ -8,6 +8,7 @@
>    */
>   #include <linux/bitmap.h>
>   #include <linux/clocksource.h>
> +#include <linux/cpu.h>
>   #include <linux/init.h>
>   #include <linux/interrupt.h>
>   #include <linux/irq.h>
> @@ -56,6 +57,47 @@ static unsigned int timer_cpu_pin;
>   static struct irq_chip gic_level_irq_controller, gic_edge_irq_controller;
>   DECLARE_BITMAP(ipi_resrv, GIC_MAX_INTRS);
>   
> +#if defined(CONFIG_MIPS_RPROC)

Spot the mistake - this should, of course, be CONFIG_MIPS_REMOTEPROC. 
I'll fix that in v2.

Matt

> +#define CONTEXT_SAVING
> +#endif
> +
> +#ifdef CONTEXT_SAVING
> +static struct {
> +	unsigned mask:		GIC_NUM_LOCAL_INTRS;
> +} gic_local_state[NR_CPUS];
> +
> +#define gic_save_local_rmask(vpe, i)	(gic_local_state[vpe].mask &= i)
> +#define gic_save_local_smask(vpe, i)	(gic_local_state[vpe].mask |= i)
> +
> +static struct {
> +	unsigned vpe:		8;
> +	unsigned pin:		4;
> +
> +	unsigned polarity:	1;
> +	unsigned trigger:	1;
> +	unsigned dual_edge:	1;
> +	unsigned mask:		1;
> +} gic_shared_state[GIC_MAX_INTRS];
> +
> +#define gic_save_shared_vpe(i, v)	gic_shared_state[i].vpe = v
> +#define gic_save_shared_pin(i, p)	gic_shared_state[i].pin = p
> +#define gic_save_shared_polarity(i, p)	gic_shared_state[i].polarity = p
> +#define gic_save_shared_trigger(i, t)	gic_shared_state[i].trigger = t
> +#define gic_save_shared_dual_edge(i, d)	gic_shared_state[i].dual_edge = d
> +#define gic_save_shared_mask(i, m)	gic_shared_state[i].mask = m
> +
> +#else
> +#define gic_save_local_rmask(vpe, i)
> +#define gic_save_local_smask(vpe, i)
> +
> +#define gic_save_shared_vpe(i, v)
> +#define gic_save_shared_pin(i, p)
> +#define gic_save_shared_polarity(i, p)
> +#define gic_save_shared_trigger(i, t)
> +#define gic_save_shared_dual_edge(i, d)
> +#define gic_save_shared_mask(i, m)
> +#endif /* CONTEXT_SAVING */
> +
>   static void __gic_irq_dispatch(void);
>   
>   static inline u32 gic_read32(unsigned int reg)
> @@ -105,52 +147,94 @@ static inline void gic_update_bits(unsigned int reg, unsigned long mask,
>   	gic_write(reg, regval);
>   }
>   
> -static inline void gic_reset_mask(unsigned int intr)
> +static inline void gic_write_reset_mask(unsigned int intr)
>   {
>   	gic_write(GIC_REG(SHARED, GIC_SH_RMASK) + GIC_INTR_OFS(intr),
>   		  1ul << GIC_INTR_BIT(intr));
>   }
>   
> -static inline void gic_set_mask(unsigned int intr)
> +static inline void gic_reset_mask(unsigned int intr)
> +{
> +	gic_save_shared_mask(intr, 0);
> +	gic_write_reset_mask(intr);
> +}
> +
> +static inline void gic_write_set_mask(unsigned int intr)
>   {
>   	gic_write(GIC_REG(SHARED, GIC_SH_SMASK) + GIC_INTR_OFS(intr),
>   		  1ul << GIC_INTR_BIT(intr));
>   }
>   
> -static inline void gic_set_polarity(unsigned int intr, unsigned int pol)
> +static inline void gic_set_mask(unsigned int intr)
> +{
> +	gic_save_shared_mask(intr, 1);
> +	gic_write_set_mask(intr);
> +}
> +
> +static inline void gic_write_polarity(unsigned int intr, unsigned int pol)
>   {
>   	gic_update_bits(GIC_REG(SHARED, GIC_SH_SET_POLARITY) +
>   			GIC_INTR_OFS(intr), 1ul << GIC_INTR_BIT(intr),
>   			(unsigned long)pol << GIC_INTR_BIT(intr));
>   }
>   
> -static inline void gic_set_trigger(unsigned int intr, unsigned int trig)
> +static inline void gic_set_polarity(unsigned int intr, unsigned int pol)
> +{
> +	gic_save_shared_polarity(intr, pol);
> +	gic_write_polarity(intr, pol);
> +}
> +
> +static inline void gic_write_trigger(unsigned int intr, unsigned int trig)
>   {
>   	gic_update_bits(GIC_REG(SHARED, GIC_SH_SET_TRIGGER) +
>   			GIC_INTR_OFS(intr), 1ul << GIC_INTR_BIT(intr),
>   			(unsigned long)trig << GIC_INTR_BIT(intr));
>   }
>   
> -static inline void gic_set_dual_edge(unsigned int intr, unsigned int dual)
> +static inline void gic_set_trigger(unsigned int intr, unsigned int trig)
> +{
> +	gic_save_shared_trigger(intr, trig);
> +	gic_write_trigger(intr, trig);
> +}
> +
> +static inline void gic_write_dual_edge(unsigned int intr, unsigned int dual)
>   {
>   	gic_update_bits(GIC_REG(SHARED, GIC_SH_SET_DUAL) + GIC_INTR_OFS(intr),
>   			1ul << GIC_INTR_BIT(intr),
>   			(unsigned long)dual << GIC_INTR_BIT(intr));
>   }
>   
> -static inline void gic_map_to_pin(unsigned int intr, unsigned int pin)
> +static inline void gic_set_dual_edge(unsigned int intr, unsigned int dual)
> +{
> +	gic_save_shared_dual_edge(intr, dual);
> +	gic_write_dual_edge(intr, dual);
> +}
> +
> +static inline void gic_write_map_to_pin(unsigned int intr, unsigned int pin)
>   {
>   	gic_write32(GIC_REG(SHARED, GIC_SH_INTR_MAP_TO_PIN_BASE) +
>   		    GIC_SH_MAP_TO_PIN(intr), GIC_MAP_TO_PIN_MSK | pin);
>   }
>   
> -static inline void gic_map_to_vpe(unsigned int intr, unsigned int vpe)
> +static inline void gic_map_to_pin(unsigned int intr, unsigned int pin)
> +{
> +	gic_save_shared_pin(intr, pin);
> +	gic_write_map_to_pin(intr, pin);
> +}
> +
> +static inline void gic_write_map_to_vpe(unsigned int intr, unsigned int vpe)
>   {
>   	gic_write(GIC_REG(SHARED, GIC_SH_INTR_MAP_TO_VPE_BASE) +
>   		  GIC_SH_MAP_TO_VPE_REG_OFF(intr, vpe),
>   		  GIC_SH_MAP_TO_VPE_REG_BIT(vpe));
>   }
>   
> +static inline void gic_map_to_vpe(unsigned int intr, unsigned int vpe)
> +{
> +	gic_save_shared_vpe(intr, vpe);
> +	gic_write_map_to_vpe(intr, vpe);
> +}
> +
>   #ifdef CONFIG_CLKSRC_MIPS_GIC
>   cycle_t gic_read_count(void)
>   {
> @@ -537,6 +621,7 @@ static void gic_mask_local_irq(struct irq_data *d)
>   {
>   	int intr = GIC_HWIRQ_TO_LOCAL(d->hwirq);
>   
> +	gic_save_local_rmask(smp_processor_id(), (1 << intr));
>   	gic_write32(GIC_REG(VPE_LOCAL, GIC_VPE_RMASK), 1 << intr);
>   }
>   
> @@ -544,6 +629,7 @@ static void gic_unmask_local_irq(struct irq_data *d)
>   {
>   	int intr = GIC_HWIRQ_TO_LOCAL(d->hwirq);
>   
> +	gic_save_local_smask(smp_processor_id(), (1 << intr));
>   	gic_write32(GIC_REG(VPE_LOCAL, GIC_VPE_SMASK), 1 << intr);
>   }
>   
> @@ -561,6 +647,7 @@ static void gic_mask_local_irq_all_vpes(struct irq_data *d)
>   
>   	spin_lock_irqsave(&gic_lock, flags);
>   	for (i = 0; i < gic_vpes; i++) {
> +		gic_save_local_rmask(mips_cm_vp_id(i), 1 << intr);
>   		gic_write(GIC_REG(VPE_LOCAL, GIC_VPE_OTHER_ADDR),
>   			  mips_cm_vp_id(i));
>   		gic_write32(GIC_REG(VPE_OTHER, GIC_VPE_RMASK), 1 << intr);
> @@ -576,6 +663,7 @@ static void gic_unmask_local_irq_all_vpes(struct irq_data *d)
>   
>   	spin_lock_irqsave(&gic_lock, flags);
>   	for (i = 0; i < gic_vpes; i++) {
> +		gic_save_local_smask(mips_cm_vp_id(i), 1 << intr);
>   		gic_write(GIC_REG(VPE_LOCAL, GIC_VPE_OTHER_ADDR),
>   			  mips_cm_vp_id(i));
>   		gic_write32(GIC_REG(VPE_OTHER, GIC_VPE_SMASK), 1 << intr);
> @@ -983,6 +1071,85 @@ static struct irq_domain_ops gic_ipi_domain_ops = {
>   	.match = gic_ipi_domain_match,
>   };
>   
> +#ifdef CONTEXT_SAVING
> +static void gic_restore_shared(void)
> +{
> +	unsigned long flags;
> +	int i;
> +
> +	spin_lock_irqsave(&gic_lock, flags);
> +	for (i = 0; i < gic_shared_intrs; i++) {
> +		gic_write_polarity(i, gic_shared_state[i].polarity);
> +		gic_write_trigger(i, gic_shared_state[i].trigger);
> +		gic_write_dual_edge(i, gic_shared_state[i].dual_edge);
> +		gic_write_map_to_vpe(i, gic_shared_state[i].vpe);
> +		gic_write_map_to_pin(i, gic_shared_state[i].pin);
> +
> +		if (gic_shared_state[i].mask)
> +			gic_write_set_mask(i);
> +		else
> +			gic_write_reset_mask(i);
> +	}
> +	spin_unlock_irqrestore(&gic_lock, flags);
> +}
> +
> +static void gic_restore_local(unsigned int vpe)
> +{
> +	int hw, virq, intr, mask;
> +	unsigned long flags;
> +
> +	for (hw = 0; hw < GIC_NUM_LOCAL_INTRS; hw++) {
> +		intr = GIC_LOCAL_TO_HWIRQ(hw);
> +		virq = irq_linear_revmap(gic_irq_domain, intr);
> +		gic_local_irq_domain_map(gic_irq_domain, virq, hw);
> +	}
> +
> +	local_irq_save(flags);
> +	gic_write(GIC_REG(VPE_LOCAL, GIC_VPE_OTHER_ADDR), vpe);
> +
> +	/* Enable EIC mode if necessary */
> +	gic_write32(GIC_REG(VPE_OTHER, GIC_VPE_CTL), cpu_has_veic);
> +
> +	/* Restore interrupt masks */
> +	mask = gic_local_state[vpe].mask;
> +	gic_write32(GIC_REG(VPE_OTHER, GIC_VPE_RMASK), ~mask);
> +	gic_write32(GIC_REG(VPE_OTHER, GIC_VPE_SMASK), mask);
> +
> +	local_irq_restore(flags);
> +}
> +#endif /* CONTEXT_SAVING */
> +
> +#ifdef CONFIG_MIPS_RPROC
> +/*
> + * The MIPS remote processor driver allows non-Linux firmware to take control
> + * of and execute on one of the systems VPEs. If that VPE is brought back under
> + * Linux, it is necessary to ensure that all GIC interrupts are routed and
> + * masked as Linux expects them, as the firmware can have done anything it
> + * likes with the GIC configuration (hopefully just for that VPEs local
> + * interrupt sources, but allow for shared external interrupts as well).
> + */
> +static int gic_cpu_notify(struct notifier_block *nfb, unsigned long action,
> +			       void *hcpu)
> +{
> +	unsigned int cpu = mips_cm_vp_id((unsigned long)hcpu);
> +
> +	switch (action) {
> +	case CPU_UP_PREPARE:
> +	case CPU_DOWN_FAILED:
> +		gic_restore_shared();
> +		gic_restore_local(cpu);
> +	default:
> +		break;
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block gic_cpu_notifier __refdata = {
> +	.notifier_call = gic_cpu_notify
> +};
> +#endif /* CONFIG_MIPS_RPROC */
> +
>   static void __init __gic_init(unsigned long gic_base_addr,
>   			      unsigned long gic_addrspace_size,
>   			      unsigned int cpu_vec, unsigned int irqbase,
> @@ -1082,6 +1249,10 @@ static void __init __gic_init(unsigned long gic_base_addr,
>   	}
>   
>   	gic_basic_init();
> +
> +#ifdef CONFIG_MIPS_RPROC
> +	register_hotcpu_notifier(&gic_cpu_notifier);
> +#endif /* CONFIG_MIPS_RPROC */
>   }
>   
>   void __init gic_init(unsigned long gic_base_addr,
