Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Aug 2017 19:11:20 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:51091 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994922AbdHRRLNfUD-q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Aug 2017 19:11:13 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id B34E712CBFFBF;
        Fri, 18 Aug 2017 18:11:02 +0100 (IST)
Received: from HHMAIL-X.hh.imgtec.org (10.100.10.113) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 18 Aug 2017 18:11:06 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by HHMAIL-X.hh.imgtec.org
 (10.100.10.113) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 18 Aug
 2017 18:11:06 +0100
Received: from np-p-burton.localnet (10.20.1.88) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.266.1; Fri, 18 Aug
 2017 10:11:04 -0700
From:   Paul Burton <paul.burton@imgtec.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
CC:     <linux-mips@linux-mips.org>, Jason Cooper <jason@lakedaemon.net>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 35/38] irqchip: mips-gic: Use pcpu_masks to avoid reading GIC_SH_MASK*
Date:   Fri, 18 Aug 2017 10:11:03 -0700
Message-ID: <34162033.30QQ0eu7r0@np-p-burton>
Organization: Imagination Technologies
In-Reply-To: <405f8fc2-2947-cc68-e40a-b7e26a03e713@arm.com>
References: <20170813043646.25821-1-paul.burton@imgtec.com> <20170813043646.25821-36-paul.burton@imgtec.com> <405f8fc2-2947-cc68-e40a-b7e26a03e713@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1643915.GF9IbKTtk9";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Originating-IP: [10.20.1.88]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59680
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

--nextPart1643915.GF9IbKTtk9
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Marc,

On Friday, 18 August 2017 08:44:15 PDT Marc Zyngier wrote:
> On 13/08/17 05:36, Paul Burton wrote:
> > This patch avoids the need to read the GIC_SH_MASK* registers when
> > decoding shared interrupts by setting & clearing the interrupt's bit in
> > the appropriate CPU's pcpu_masks entry when masking or unmasking the
> > interrupt.
> > 
> > This effectively means that whilst an interrupt is masked we clear its
> > bit in all pcpu_masks, which causes gic_handle_shared_int() to ignore it
> > on all CPUs without needing to check GIC_SH_MASK*.
> > 
> > In essence, we add a little overhead to masking or unmasking interrupts
> > but in return reduce the overhead of the far more common task of
> > decoding interrupts.
> > 
> > Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> > Cc: Jason Cooper <jason@lakedaemon.net>
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: linux-mips@linux-mips.org
> > ---
> > 
> >  drivers/irqchip/irq-mips-gic.c | 49
> >  ++++++++++++++++++++++++------------------ 1 file changed, 28
> >  insertions(+), 21 deletions(-)
> > 
> > diff --git a/drivers/irqchip/irq-mips-gic.c
> > b/drivers/irqchip/irq-mips-gic.c index 00153231376a..7a42f0b3822f 100644
> > --- a/drivers/irqchip/irq-mips-gic.c
> > +++ b/drivers/irqchip/irq-mips-gic.c
> > @@ -55,6 +55,19 @@ static struct irq_chip gic_level_irq_controller,
> > gic_edge_irq_controller;> 
> >  DECLARE_BITMAP(ipi_resrv, GIC_MAX_INTRS);
> >  DECLARE_BITMAP(ipi_available, GIC_MAX_INTRS);
> > 
> > +static void gic_setup_pcpu_mask(unsigned int intr, unsigned int cpu)
> > +{
> > +	unsigned int i;
> > +
> > +	/* Clear the interrupt's bit in all pcpu_masks */
> > +	for_each_possible_cpu(i)
> > +		clear_bit(intr, per_cpu_ptr(pcpu_masks, i));
> 
> This iterates from 0 to nr_cpu_ids-1...
> 
> > +
> > +	/* Set the interrupt's bit in the appropriate CPU's mask */
> > +	if (cpu < NR_CPUS)
> 
> and here you're using NR_CPUS. I'm a bit worried that you're not quite
> using the same thing (nr_cpu_ids <= NR_CPUS).

I think that would be fine - if nr_cpu_ids is less than NR_CPUS then all we 
risk is leaving bits set in the mask for CPUs that aren't in cpu_possible_mask 
(which is where nr_cpu_ids comes from). Since those CPUs don't exist & thus 
can't take interrupts they'll never check the bits in their mask.

The NR_CPUS check here is basically just to allow the interrupt to be set in 
none of the masks when called by gic_mask_irq() - NR_CPUS is just some 
constant value that we know will never be the ID of a CPU that an interrupt's 
affinity is set to.

Perhaps it'd be clearer to instead split gic_setup_pcpu_mask() into 2 
functions - one to just clear all the masks, and one to set the interrupt's 
bit in the appropriate one? Possibly just inline that second one. That way we 
wouldn't be using NR_CPUS at all here which might be clearer. How does that 
sound?

Thanks,
    Paul

> 
> > +		set_bit(intr, per_cpu_ptr(pcpu_masks, cpu));
> > +}
> > +
> > 
> >  static bool gic_local_irq_is_routable(int intr)
> >  {
> >  
> >  	u32 vpe_ctl;
> > 
> > @@ -133,24 +146,17 @@ static void gic_handle_shared_int(bool chained)
> > 
> >  	unsigned int intr, virq;
> >  	unsigned long *pcpu_mask;
> >  	DECLARE_BITMAP(pending, GIC_MAX_INTRS);
> > 
> > -	DECLARE_BITMAP(intrmask, GIC_MAX_INTRS);
> > 
> >  	/* Get per-cpu bitmaps */
> >  	pcpu_mask = this_cpu_ptr(pcpu_masks);
> > 
> > -	if (mips_cm_is64) {
> > +	if (mips_cm_is64)
> > 
> >  		__ioread64_copy(pending, addr_gic_pend(),
> >  		
> >  				DIV_ROUND_UP(gic_shared_intrs, 64));
> > 
> > -		__ioread64_copy(intrmask, addr_gic_mask(),
> > -				DIV_ROUND_UP(gic_shared_intrs, 64));
> > -	} else {
> > +	else
> > 
> >  		__ioread32_copy(pending, addr_gic_pend(),
> >  		
> >  				DIV_ROUND_UP(gic_shared_intrs, 32));
> > 
> > -		__ioread32_copy(intrmask, addr_gic_mask(),
> > -				DIV_ROUND_UP(gic_shared_intrs, 32));
> > -	}
> > 
> > -	bitmap_and(pending, pending, intrmask, gic_shared_intrs);
> > 
> >  	bitmap_and(pending, pending, pcpu_mask, gic_shared_intrs);
> >  	
> >  	for_each_set_bit(intr, pending, gic_shared_intrs) {
> > 
> > @@ -165,12 +171,19 @@ static void gic_handle_shared_int(bool chained)
> > 
> >  static void gic_mask_irq(struct irq_data *d)
> >  {
> > 
> > -	write_gic_rmask(BIT(GIC_HWIRQ_TO_SHARED(d->hwirq)));
> > +	unsigned int intr = GIC_HWIRQ_TO_SHARED(d->hwirq);
> > +
> > +	write_gic_rmask(BIT(intr));
> > +	gic_setup_pcpu_mask(intr, NR_CPUS);
> > 
> >  }
> >  
> >  static void gic_unmask_irq(struct irq_data *d)
> >  {
> > 
> > -	write_gic_smask(BIT(GIC_HWIRQ_TO_SHARED(d->hwirq)));
> > +	struct cpumask *affinity = irq_data_get_affinity_mask(d);
> > +	unsigned int intr = GIC_HWIRQ_TO_SHARED(d->hwirq);
> > +
> > +	write_gic_smask(BIT(intr));
> > +	gic_setup_pcpu_mask(intr, cpumask_first_and(affinity, 
cpu_online_mask));
> > 
> >  }
> >  
> >  static void gic_ack_irq(struct irq_data *d)
> > 
> > @@ -239,7 +252,6 @@ static int gic_set_affinity(struct irq_data *d, const
> > struct cpumask *cpumask,> 
> >  	unsigned int irq = GIC_HWIRQ_TO_SHARED(d->hwirq);
> >  	cpumask_t	tmp = CPU_MASK_NONE;
> >  	unsigned long	flags;
> > 
> > -	int		i;
> > 
> >  	cpumask_and(&tmp, cpumask, cpu_online_mask);
> >  	if (cpumask_empty(&tmp))
> > 
> > @@ -252,9 +264,7 @@ static int gic_set_affinity(struct irq_data *d, const
> > struct cpumask *cpumask,> 
> >  	write_gic_map_vp(irq, BIT(mips_cm_vp_id(cpumask_first(&tmp))));
> >  	
> >  	/* Update the pcpu_masks */
> > 
> > -	for (i = 0; i < min(gic_vpes, NR_CPUS); i++)
> > -		clear_bit(irq, per_cpu_ptr(pcpu_masks, i));
> > -	set_bit(irq, per_cpu_ptr(pcpu_masks, cpumask_first(&tmp)));
> > +	gic_setup_pcpu_mask(irq, read_gic_mask(irq) ? cpumask_first(&tmp) :
> > NR_CPUS);> 
> >  	cpumask_copy(irq_data_get_affinity_mask(d), cpumask);
> >  	spin_unlock_irqrestore(&gic_lock, flags);
> > 
> > @@ -405,18 +415,15 @@ static int gic_local_irq_domain_map(struct
> > irq_domain *d, unsigned int virq,> 
> >  }
> >  
> >  static int gic_shared_irq_domain_map(struct irq_domain *d, unsigned int
> >  virq,> 
> > -				     irq_hw_number_t hw, unsigned int vpe)
> > +				     irq_hw_number_t hw, unsigned int cpu)
> > 
> >  {
> >  
> >  	int intr = GIC_HWIRQ_TO_SHARED(hw);
> >  	unsigned long flags;
> > 
> > -	int i;
> > 
> >  	spin_lock_irqsave(&gic_lock, flags);
> >  	write_gic_map_pin(intr, GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin);
> > 
> > -	write_gic_map_vp(intr, BIT(mips_cm_vp_id(vpe)));
> > -	for (i = 0; i < min(gic_vpes, NR_CPUS); i++)
> > -		clear_bit(intr, per_cpu_ptr(pcpu_masks, i));
> > -	set_bit(intr, per_cpu_ptr(pcpu_masks, vpe));
> > +	write_gic_map_vp(intr, BIT(mips_cm_vp_id(cpu)));
> > +	gic_setup_pcpu_mask(intr, cpu);
> > 
> >  	spin_unlock_irqrestore(&gic_lock, flags);
> >  	
> >  	return 0;
> 
> Thanks,
> 
> 	M.


--nextPart1643915.GF9IbKTtk9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEELIGR03D5+Fg+69wPgiDZ+mk8HGUFAlmXH6cACgkQgiDZ+mk8
HGXXLw/+PVkqOWaC+YLK7ciPwb8VUZZO+2cY/YSbEif6FEab0QNVLsESkXsbmdSx
z0Y3s4l80+4IIE98UbJEneCKv4XqwIZmAdirDYfnSpYo8O1eR9QU6oCywmiV6Qxq
h4nzKHzq7ePl8XjX/EX1cbRGeavEWnwH0pIJmnxzOvBdG9KDhj38DvpdUvoHJ47X
asRb70i44S4Ekc7YBf3LmgoHed57FNFZDT35IWUocnG+LGG4DVsdXh3sJBzBIgpn
56O6RlqbmJDHme6cegq3DmSAHO0Po+nxCnDB50h6yNkbHGiCsJ/5a+G/MJmJEVU/
/bOAaHBdUIEXJE0lwsEeGLeyKAigIlz5PvrjtbGiKQ5MLpVgeU7TCYnSI5zDmEUr
dhcB67a+vI52P7VwR2ZPBIs4CGBxldSmIG0Ucgny7Cfu6AatcRFeL0OoUGZ4u21k
siqXvfGWA+jhVcq3NJAinIU2mnOP0/eix3eY3e6UH0P4luOMdy0AgQB0Tnhg7oBz
4vO7GeBxaIax6hldIXIpEc6XhidFUlLFVpToY9S7/Roi4OhIDE9/M4nv56LuhG0A
h4bTKkcjxeuPfaJx1l+UCftKsYG3moXjN1MSDdKjBI4GKZVOFoUurZdaQKPs1Ph2
YKU2MxOCaYsjGAAitl+qXkAYQpp4fB+o9hRsFLnVhwtq0eCLm9Q=
=1LZG
-----END PGP SIGNATURE-----

--nextPart1643915.GF9IbKTtk9--
