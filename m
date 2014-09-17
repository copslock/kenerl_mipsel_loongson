Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Sep 2014 11:24:55 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:10650 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008413AbaIQJYw2iM0a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Sep 2014 11:24:52 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 6C775820CFF23;
        Wed, 17 Sep 2014 10:24:43 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 17 Sep
 2014 10:24:46 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 17 Sep 2014 10:24:45 +0100
Received: from [192.168.154.94] (192.168.154.94) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 17 Sep
 2014 10:24:44 +0100
Message-ID: <5419535C.9060802@imgtec.com>
Date:   Wed, 17 Sep 2014 10:24:44 +0100
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
Subject: Re: [PATCH 20/24] irqchip: mips-gic: Use separate edge/level irq_chips
References: <1410825087-5497-1-git-send-email-abrestic@chromium.org> <1410825087-5497-21-git-send-email-abrestic@chromium.org>
In-Reply-To: <1410825087-5497-21-git-send-email-abrestic@chromium.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42660
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

On 09/16/2014 12:51 AM, Andrew Bresticker wrote:
> GIC edge-triggered interrupts must be acknowledged by clearing the edge
> detector via a write to GIC_SH_WEDGE.  Create a separate edge-triggered
> irq_chip with the appropriate irq_ack() callback.  This also allows us
> to get rid of gic_irq_flags.
>
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> ---
>   arch/mips/include/asm/gic.h    |  1 -
>   drivers/irqchip/irq-mips-gic.c | 38 ++++++++++++++++++++++++--------------
>   2 files changed, 24 insertions(+), 15 deletions(-)
>
> diff --git a/arch/mips/include/asm/gic.h b/arch/mips/include/asm/gic.h
> index 8d1e457..f245395 100644
> --- a/arch/mips/include/asm/gic.h
> +++ b/arch/mips/include/asm/gic.h
> @@ -345,7 +345,6 @@
>   extern unsigned int gic_present;
>   extern unsigned int gic_frequency;
>   extern unsigned long _gic_base;
> -extern unsigned int gic_irq_flags[];
>   extern unsigned int gic_cpu_pin;
>   
>   extern void gic_init(unsigned long gic_base_addr,
> diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
> index c9ba102..6682a4e 100644
> --- a/drivers/irqchip/irq-mips-gic.c
> +++ b/drivers/irqchip/irq-mips-gic.c
> @@ -24,7 +24,6 @@
>   unsigned int gic_frequency;
>   unsigned int gic_present;
>   unsigned long _gic_base;
> -unsigned int gic_irq_flags[GIC_NUM_INTRS];
>   unsigned int gic_cpu_pin;
>   
>   struct gic_pcpu_mask {
> @@ -44,6 +43,7 @@ static struct gic_pending_regs pending_regs[NR_CPUS];
>   static struct gic_intrmask_regs intrmask_regs[NR_CPUS];
>   static struct irq_domain *gic_irq_domain;
>   static int gic_shared_intrs;
> +static struct irq_chip gic_level_irq_controller, gic_edge_irq_controller;
>   
>   static void __gic_irq_dispatch(void);
>   
> @@ -228,11 +228,7 @@ static void gic_ack_irq(struct irq_data *d)
>   {
>   	unsigned int irq = d->hwirq;
>   
> -	GIC_CLR_INTR_MASK(irq);
> -
> -	/* Clear edge detector */
> -	if (gic_irq_flags[irq] & GIC_TRIG_EDGE)
> -		GICWRITE(GIC_REG(SHARED, GIC_SH_WEDGE), irq);
> +	GICWRITE(GIC_REG(SHARED, GIC_SH_WEDGE), irq);
>   }
>   
>   static int gic_set_type(struct irq_data *d, unsigned int type)
> @@ -275,11 +271,13 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
>   	}
>   
>   	if (is_edge) {
> -		gic_irq_flags[irq] |= GIC_TRIG_EDGE;
> -		__irq_set_handler_locked(d->irq, handle_edge_irq);
> +		__irq_set_chip_handler_name_locked(d->irq,
> +						   &gic_edge_irq_controller,
> +						   handle_edge_irq, NULL);
>   	} else {
> -		gic_irq_flags[irq] &= ~GIC_TRIG_EDGE;
> -		__irq_set_handler_locked(d->irq, handle_level_irq);
> +		__irq_set_chip_handler_name_locked(d->irq,
> +						   &gic_level_irq_controller,
> +						   handle_level_irq, NULL);
>   	}
>   
>   	return 0;
> @@ -318,11 +316,23 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *cpumask,
>   }
>   #endif
>   
> -static struct irq_chip gic_irq_controller = {
> +static struct irq_chip gic_level_irq_controller = {
> +	.name			=	"MIPS GIC",
> +	.irq_ack		=	gic_mask_irq,
> +	.irq_mask		=	gic_mask_irq,
> +	.irq_mask_ack		=	gic_mask_irq,
> +	.irq_unmask		=	gic_unmask_irq,
> +	.irq_eoi		=	gic_unmask_irq,
> +	.irq_set_type		=	gic_set_type,
> +#ifdef CONFIG_SMP
> +	.irq_set_affinity	=	gic_set_affinity,
> +#endif
> +};
> +

I don't think there's a need to provide irq_ack, irq_mask_ack and 
irq_eoi here.

> +static struct irq_chip gic_edge_irq_controller = {
>   	.name			=	"MIPS GIC",
>   	.irq_ack		=	gic_ack_irq,
>   	.irq_mask		=	gic_mask_irq,
> -	.irq_mask_ack		=	gic_ack_irq,
>   	.irq_unmask		=	gic_unmask_irq,
>   	.irq_eoi		=	gic_unmask_irq,
>   	.irq_set_type		=	gic_set_type,

irq_eoi can be removed from here as well.

Qais

> @@ -433,7 +443,6 @@ static void __init gic_basic_init(int numvpes)
>   		GIC_SET_POLARITY(i, GIC_POL_POS);
>   		GIC_SET_TRIGGER(i, GIC_TRIG_LEVEL);
>   		GIC_CLR_INTR_MASK(i);
> -		gic_irq_flags[i] = 0;
>   	}
>   
>   	vpe_local_setup(numvpes);
> @@ -442,7 +451,8 @@ static void __init gic_basic_init(int numvpes)
>   static int gic_irq_domain_map(struct irq_domain *d, unsigned int virq,
>   			      irq_hw_number_t hw)
>   {
> -	irq_set_chip_and_handler(virq, &gic_irq_controller, handle_level_irq);
> +	irq_set_chip_and_handler(virq, &gic_level_irq_controller,
> +				 handle_level_irq);
>   
>   	GICWRITE(GIC_REG_ADDR(SHARED, GIC_SH_MAP_TO_PIN(hw)),
>   		 GIC_MAP_TO_PIN_MSK | gic_cpu_pin);
