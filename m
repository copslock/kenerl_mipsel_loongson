Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Aug 2017 19:02:55 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:11792 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994922AbdHRRCsexezq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Aug 2017 19:02:48 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 27F8AB6101D9;
        Fri, 18 Aug 2017 18:02:38 +0100 (IST)
Received: from HHMAIL-X.hh.imgtec.org (10.100.10.113) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 18 Aug 2017 18:02:41 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by HHMAIL-X.hh.imgtec.org
 (10.100.10.113) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 18 Aug
 2017 18:02:41 +0100
Received: from np-p-burton.localnet (10.20.1.88) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.266.1; Fri, 18 Aug
 2017 10:02:39 -0700
From:   Paul Burton <paul.burton@imgtec.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
CC:     <linux-mips@linux-mips.org>, Jason Cooper <jason@lakedaemon.net>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 34/38] irqchip: mips-gic: Make pcpu_masks a per-cpu variable
Date:   Fri, 18 Aug 2017 10:02:33 -0700
Message-ID: <4849840.2gNksj1pBB@np-p-burton>
Organization: Imagination Technologies
In-Reply-To: <80cfe904-c724-26dd-6802-b2f1b49062be@arm.com>
References: <20170813043646.25821-1-paul.burton@imgtec.com> <20170813043646.25821-35-paul.burton@imgtec.com> <80cfe904-c724-26dd-6802-b2f1b49062be@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1732863.6PQG09rORk";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Originating-IP: [10.20.1.88]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59679
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

--nextPart1732863.6PQG09rORk
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Marc,

On Friday, 18 August 2017 08:37:03 PDT Marc Zyngier wrote:
> On 13/08/17 05:36, Paul Burton wrote:
> > Define the pcpu_masks variable using the kernel's standard per-cpu
> > variable support, rather than an open-coded array of structs containing
> > bitmaps.
> > 
> > Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> > Cc: Jason Cooper <jason@lakedaemon.net>
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: linux-mips@linux-mips.org
> > ---
> > 
> >  drivers/irqchip/irq-mips-gic.c | 17 ++++++++---------
> >  1 file changed, 8 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/irqchip/irq-mips-gic.c
> > b/drivers/irqchip/irq-mips-gic.c index feff4bf97577..00153231376a 100644
> > --- a/drivers/irqchip/irq-mips-gic.c
> > +++ b/drivers/irqchip/irq-mips-gic.c
> > @@ -13,6 +13,7 @@
> > 
> >  #include <linux/irq.h>
> >  #include <linux/irqchip.h>
> >  #include <linux/of_address.h>
> > 
> > +#include <linux/percpu.h>
> > 
> >  #include <linux/sched.h>
> >  #include <linux/smp.h>
> > 
> > @@ -23,6 +24,7 @@
> > 
> >  #include <dt-bindings/interrupt-controller/mips-gic.h>
> >  
> >  #define GIC_MAX_INTRS		256
> > 
> > +#define GIC_MAX_LONGS		BITS_TO_LONGS(GIC_MAX_INTRS)
> > 
> >  /* Add 2 to convert GIC CPU pin to core interrupt */
> >  #define GIC_CPU_PIN_OFFSET	2
> > 
> > @@ -40,11 +42,8 @@
> > 
> >  void __iomem *mips_gic_base;
> > 
> > -struct gic_pcpu_mask {
> > -	DECLARE_BITMAP(pcpu_mask, GIC_MAX_INTRS);
> > -};
> > +DEFINE_PER_CPU_READ_MOSTLY(unsigned long[GIC_MAX_LONGS], pcpu_masks);
> > 
> > -static struct gic_pcpu_mask pcpu_masks[NR_CPUS];
> > 
> >  static DEFINE_SPINLOCK(gic_lock);
> >  static struct irq_domain *gic_irq_domain;
> >  static struct irq_domain *gic_ipi_domain;
> > 
> > @@ -137,7 +136,7 @@ static void gic_handle_shared_int(bool chained)
> > 
> >  	DECLARE_BITMAP(intrmask, GIC_MAX_INTRS);
> >  	
> >  	/* Get per-cpu bitmaps */
> > 
> > -	pcpu_mask = pcpu_masks[smp_processor_id()].pcpu_mask;
> > +	pcpu_mask = this_cpu_ptr(pcpu_masks);
> > 
> >  	if (mips_cm_is64) {
> >  	
> >  		__ioread64_copy(pending, addr_gic_pend(),
> > 
> > @@ -254,8 +253,8 @@ static int gic_set_affinity(struct irq_data *d, const
> > struct cpumask *cpumask,> 
> >  	/* Update the pcpu_masks */
> >  	for (i = 0; i < min(gic_vpes, NR_CPUS); i++)
> 
> Is there any case where gic_vpes is not equal to nr_cpus?

Yes - if the kernel is built with CONFIG_NR_CPUS set to something other than 
the actual number of VPs (Virtual Processors, ie. hardware threads) in the 
system. (VPE, or Virtual Processing Element, is a roughly equivalent term used 
in older revisions of the MIPS architecture).

To be honest I suspect gic_vpes should go away, and for example in this case 
we should juse use for_each_possible_cpu(). The use of gic_vpes here was added 
by commit 2a0787051182 ("irqchip/mips-gic: Use gic_vpes instead of NR_CPUS") 
but it doesn't really do a good job of explaining why - I suspect Qais felt it 
was an optimisation, but that's debatable.

This code will need adjusting to add multi-cluster support, which is my 
ultimate goal here, anyway. So that'll be one of the next things for me to 
tackle.

Thanks,
    Paul

> 
> > -		clear_bit(irq, pcpu_masks[i].pcpu_mask);
> > -	set_bit(irq, pcpu_masks[cpumask_first(&tmp)].pcpu_mask);
> > +		clear_bit(irq, per_cpu_ptr(pcpu_masks, i));
> > +	set_bit(irq, per_cpu_ptr(pcpu_masks, cpumask_first(&tmp)));
> > 
> >  	cpumask_copy(irq_data_get_affinity_mask(d), cpumask);
> >  	spin_unlock_irqrestore(&gic_lock, flags);
> > 
> > @@ -416,8 +415,8 @@ static int gic_shared_irq_domain_map(struct irq_domain
> > *d, unsigned int virq,> 
> >  	write_gic_map_pin(intr, GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin);
> >  	write_gic_map_vp(intr, BIT(mips_cm_vp_id(vpe)));
> >  	for (i = 0; i < min(gic_vpes, NR_CPUS); i++)
> > 
> > -		clear_bit(intr, pcpu_masks[i].pcpu_mask);
> > -	set_bit(intr, pcpu_masks[vpe].pcpu_mask);
> > +		clear_bit(intr, per_cpu_ptr(pcpu_masks, i));
> > +	set_bit(intr, per_cpu_ptr(pcpu_masks, vpe));
> > 
> >  	spin_unlock_irqrestore(&gic_lock, flags);
> >  	
> >  	return 0;
> 
> Thanks,
> 
> 	M.


--nextPart1732863.6PQG09rORk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEELIGR03D5+Fg+69wPgiDZ+mk8HGUFAlmXHakACgkQgiDZ+mk8
HGXabxAAgDDC0okwp/V1UBYpQIOisMIVs+F2+qCe+ZbJoP7GvSlLa7F4tY8MPU33
Irtxey09k0vKxSR8eBLtWBrRGc0znZ7i29EDKd6yCN/16i59Enag1DHH7a/DWLVV
qL4q917hetZMtXExDG7ZeQEXzCSIkS1Psp/lFxHg5lnJnmkZNDkfUPXrlrwmu98R
nFf5anEDezL1X0LcWwcaqPObQ8xTC4AVf8jEBgqRavy66qo/T6caFZMHalQrklqk
q6jawnHfJCnUxDtu/XnAJ4wToceprJAnqB0ufX2Ttde8MP2Tw0tk3TqU58KKDSDZ
g5dZyeZFLshvYWpVYzj7ergQIzZD1JB5oe92R/+/jppdSwHiZqnn+2mXOltKa8Sb
0sWF0pe0IwPmLOAlZoi5ZmtgCfggoYVjJiDOhnDAh+lMmEOpcAYXLB40kthdID02
XxNrRjXKASAFALnEgHkelHk3O1Pjykuq3qK4zQE6FvE/Y/1pnCFYXiVZ28ZBg8D5
UbRBEfeVeNHNithqabKc3riHMRuDdoghWfW272p9XCQKSRU5LhhrGNIdaAw8fG2T
Khjk8cPO50cV/tiFq2VGLJKB66oWKWHMHGG3LCz6mFO8raEgnQ+WYsYd8cCeE8M3
PPIWoZzuaP+pS35823TdlU6l5yw4/YYL4m9jqwbQv55GGx3GKXA=
=+7g7
-----END PGP SIGNATURE-----

--nextPart1732863.6PQG09rORk--
