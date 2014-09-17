Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Sep 2014 11:15:02 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:32560 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008413AbaIQJO7aPj2Z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Sep 2014 11:14:59 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 99BE722664784;
        Wed, 17 Sep 2014 10:14:49 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 17 Sep 2014 10:14:52 +0100
Received: from [192.168.154.94] (192.168.154.94) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 17 Sep
 2014 10:14:50 +0100
Message-ID: <5419510A.3000300@imgtec.com>
Date:   Wed, 17 Sep 2014 10:14:50 +0100
From:   Qais Yousef <qais.yousef@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.7.0
MIME-Version: 1.0
To:     Andrew Bresticker <abrestic@chromium.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
CC:     Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        "Jonas Gorski" <jogo@openwrt.org>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 14/24] irqchip: mips-gic: Implement generic irq_ack/irq_eoi
 callbacks
References: <1410825087-5497-1-git-send-email-abrestic@chromium.org> <1410825087-5497-15-git-send-email-abrestic@chromium.org>
In-Reply-To: <1410825087-5497-15-git-send-email-abrestic@chromium.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42658
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: qais.yousef@imgtec.com
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

Hi Andrew,

On 09/16/2014 12:51 AM, Andrew Bresticker wrote:
> There's no need for platforms to have their own GIC irq_ack/irq_eoi
> callbacks.  Move them to the GIC irqchip driver.
>
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> ---
>   arch/mips/include/asm/gic.h     |  2 --
>   arch/mips/mti-malta/malta-int.c | 16 ----------------
>   arch/mips/mti-sead3/sead3-int.c | 21 ---------------------
>   drivers/irqchip/irq-mips-gic.c  | 15 ++++++++++++---
>   4 files changed, 12 insertions(+), 42 deletions(-)
>
> diff --git a/arch/mips/include/asm/gic.h b/arch/mips/include/asm/gic.h
> index 022d831..1bf7985 100644
> --- a/arch/mips/include/asm/gic.h
> +++ b/arch/mips/include/asm/gic.h
> @@ -376,7 +376,5 @@ extern void gic_bind_eic_interrupt(int irq, int set);
>   extern unsigned int gic_get_timer_pending(void);
>   extern void gic_get_int_mask(unsigned long *dst, const unsigned long *src);
>   extern unsigned int gic_get_int(void);
> -extern void gic_irq_ack(struct irq_data *d);
> -extern void gic_finish_irq(struct irq_data *d);
>   extern void gic_platform_init(int irqs, struct irq_chip *irq_controller);
>   #endif /* _ASM_GICREGS_H */
> diff --git a/arch/mips/mti-malta/malta-int.c b/arch/mips/mti-malta/malta-int.c
> index 5c31208..b60adfd 100644
> --- a/arch/mips/mti-malta/malta-int.c
> +++ b/arch/mips/mti-malta/malta-int.c
> @@ -715,22 +715,6 @@ int malta_be_handler(struct pt_regs *regs, int is_fixup)
>   	return retval;
>   }
>   
> -void gic_irq_ack(struct irq_data *d)
> -{
> -	int irq = (d->irq - gic_irq_base);
> -
> -	GIC_CLR_INTR_MASK(irq);
> -
> -	if (gic_irq_flags[irq] & GIC_TRIG_EDGE)
> -		GICWRITE(GIC_REG(SHARED, GIC_SH_WEDGE), irq);
> -}
> -
> -void gic_finish_irq(struct irq_data *d)
> -{
> -	/* Enable interrupts. */
> -	GIC_SET_INTR_MASK(d->irq - gic_irq_base);
> -}
> -
>   void __init gic_platform_init(int irqs, struct irq_chip *irq_controller)
>   {
>   	int i;
> diff --git a/arch/mips/mti-sead3/sead3-int.c b/arch/mips/mti-sead3/sead3-int.c
> index 9d5b5bd..03f9865 100644
> --- a/arch/mips/mti-sead3/sead3-int.c
> +++ b/arch/mips/mti-sead3/sead3-int.c
> @@ -85,27 +85,6 @@ void __init arch_init_irq(void)
>   			ARRAY_SIZE(gic_intr_map), MIPS_GIC_IRQ_BASE);
>   }
>   
> -void gic_irq_ack(struct irq_data *d)
> -{
> -	GIC_CLR_INTR_MASK(d->irq - gic_irq_base);
> -}
> -
> -void gic_finish_irq(struct irq_data *d)
> -{
> -	unsigned int irq = (d->irq - gic_irq_base);
> -	unsigned int i, irq_source;
> -
> -	/* Clear edge detectors. */
> -	for (i = 0; i < gic_shared_intr_map[irq].num_shared_intr; i++) {
> -		irq_source = gic_shared_intr_map[irq].intr_list[i];
> -		if (gic_irq_flags[irq_source] & GIC_TRIG_EDGE)
> -			GICWRITE(GIC_REG(SHARED, GIC_SH_WEDGE), irq_source);
> -	}
> -
> -	/* Enable interrupts. */
> -	GIC_SET_INTR_MASK(irq);
> -}
> -
>   void __init gic_platform_init(int irqs, struct irq_chip *irq_controller)
>   {
>   	int i;
> diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
> index 9e9d8b9..0dc2972 100644
> --- a/drivers/irqchip/irq-mips-gic.c
> +++ b/drivers/irqchip/irq-mips-gic.c
> @@ -237,6 +237,15 @@ static void gic_unmask_irq(struct irq_data *d)
>   	GIC_SET_INTR_MASK(d->irq - gic_irq_base);
>   }
>   
> +static void gic_ack_irq(struct irq_data *d)
> +{
> +	GIC_CLR_INTR_MASK(d->irq - gic_irq_base);
> +
> +	/* Clear edge detector */
> +	if (gic_irq_flags[d->irq - gic_irq_base] & GIC_TRIG_EDGE)
> +		GICWRITE(GIC_REG(SHARED, GIC_SH_WEDGE), d->irq - gic_irq_base);
> +}
> +
>   #ifdef CONFIG_SMP
>   static DEFINE_SPINLOCK(gic_lock);
>   
> @@ -272,11 +281,11 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *cpumask,
>   
>   static struct irq_chip gic_irq_controller = {
>   	.name			=	"MIPS GIC",
> -	.irq_ack		=	gic_irq_ack,
> +	.irq_ack		=	gic_ack_irq,
>   	.irq_mask		=	gic_mask_irq,
> -	.irq_mask_ack		=	gic_mask_irq,
> +	.irq_mask_ack		=	gic_ack_irq,
>   	.irq_unmask		=	gic_unmask_irq,
> -	.irq_eoi		=	gic_finish_irq,
> +	.irq_eoi		=	gic_unmask_irq,
>   #ifdef CONFIG_SMP
>   	.irq_set_affinity	=	gic_set_affinity,
>   #endif

I'm no expert in irq_chip api but I think providing irq_mask_ack and 
irq_eoi makes no sense to GIC and can be removed.

Qais
