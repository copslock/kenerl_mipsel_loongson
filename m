Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Aug 2017 18:43:42 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:52133 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994922AbdHRQnfc29Pq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Aug 2017 18:43:35 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 97B61688C4707;
        Fri, 18 Aug 2017 17:43:24 +0100 (IST)
Received: from HHMAIL-X.hh.imgtec.org (10.100.10.113) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 18 Aug 2017 17:43:28 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by HHMAIL-X.hh.imgtec.org
 (10.100.10.113) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 18 Aug
 2017 17:43:27 +0100
Received: from np-p-burton.localnet (10.20.1.88) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.266.1; Fri, 18 Aug
 2017 09:43:25 -0700
From:   Paul Burton <paul.burton@imgtec.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
CC:     <linux-mips@linux-mips.org>, Jason Cooper <jason@lakedaemon.net>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/38] MIPS: GIC: Introduce asm/mips-gic.h with accessor functions
Date:   Fri, 18 Aug 2017 09:43:20 -0700
Message-ID: <1981544.dTMeF8HtiM@np-p-burton>
Organization: Imagination Technologies
In-Reply-To: <b331ff4a-cdc6-49d1-96a5-f7536b3324f1@arm.com>
References: <20170813043646.25821-1-paul.burton@imgtec.com> <20170813043646.25821-3-paul.burton@imgtec.com> <b331ff4a-cdc6-49d1-96a5-f7536b3324f1@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart136644354.Ievfv3LtmX";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Originating-IP: [10.20.1.88]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59675
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

--nextPart136644354.Ievfv3LtmX
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Marc,

On Friday, 18 August 2017 04:10:20 PDT Marc Zyngier wrote:
> On 13/08/17 05:36, Paul Burton wrote:
> > This patch introduces a new header providing accessor functions for the
> > MIPS Global Interrupt Controller (GIC) mirroring those provided for the
> > other 2 components of the MIPS Coherent Processing System (CPS) - the
> > Coherence Manager (CM) & Cluster Power Controller (CPC).
> > 
> > This header makes use of the new standardised CPS accessor macros where
> > possible, but does require some custom accessors for cases where we have
> > either a bit or a register per interrupt.
> > 
> > A major advantage of this over the existing
> > include/linux/irqchip/mips-gic.h definitions is that code performing
> > 
> > accesses can become much simpler, for example this:
> >   gic_update_bits(GIC_REG(SHARED, GIC_SH_SET_TRIGGER) +
> >   
> >                   GIC_INTR_OFS(intr), 1ul << GIC_INTR_BIT(intr),
> >                   (unsigned long)trig << GIC_INTR_BIT(intr));
> > 
> > ...can become simply:
> >   change_gic_trig(intr, trig);
> > 
> > The accessors handle 32 vs 64 bit in the same way as for CM & CPC code,
> > which means that GIC code will also not need to worry about the access
> > size in most cases. They are also accessible outside of
> > drivers/irqchip/irq-mips-gic.c which will allow for simplification in
> > the use of the non-interrupt portions of the GIC (eg. counters) which
> > currently require the interrupt controller driver to expose helper
> > functions for access.
> > 
> > This patch doesn't change any existing code over to use the new
> > accessors yet, since a wholesale change would be invasive & difficult to
> > review. Instead follow-on patches will convert code piecemeal to use
> > this new header. The one change to existing code is to rename gic_base
> > to mips_gic_base & make it global, in order to fit in with the naming
> > expected by the standardised CPS accessor macros.
> > 
> > Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> > Cc: Jason Cooper <jason@lakedaemon.net>
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-mips@linux-mips.org
> > ---
> > 
> >  arch/mips/include/asm/mips-cps.h |   1 +
> >  arch/mips/include/asm/mips-gic.h | 293
> >  +++++++++++++++++++++++++++++++++++++++ drivers/irqchip/irq-mips-gic.c  
> >  |  13 +-
> >  3 files changed, 300 insertions(+), 7 deletions(-)
> >  create mode 100644 arch/mips/include/asm/mips-gic.h
> > 
> > diff --git a/arch/mips/include/asm/mips-cps.h
> > b/arch/mips/include/asm/mips-cps.h index 2dd737d803e1..bf02b5070a98
> > 100644
> > --- a/arch/mips/include/asm/mips-cps.h
> > +++ b/arch/mips/include/asm/mips-cps.h
> > @@ -107,6 +107,7 @@ static inline void clear_##unit##_##name(uint##sz##_t
> > val)		\> 
> >  #include <asm/mips-cm.h>
> >  #include <asm/mips-cpc.h>
> > 
> > +#include <asm/mips-gic.h>
> > 
> >  /**
> >  
> >   * mips_cps_numclusters - return the number of clusters present in the
> >   system> 
> > diff --git a/arch/mips/include/asm/mips-gic.h
> > b/arch/mips/include/asm/mips-gic.h new file mode 100644
> > index 000000000000..8cf4bdc1a059
> > --- /dev/null
> > +++ b/arch/mips/include/asm/mips-gic.h
> > @@ -0,0 +1,293 @@
> > +/*
> > + * Copyright (C) 2017 Imagination Technologies
> > + * Author: Paul Burton <paul.burton@imgtec.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > it
> > + * under the terms of the GNU General Public License as published by the
> > + * Free Software Foundation;  either version 2 of the  License, or (at
> > your + * option) any later version.
> > + */
> > +
> > +#ifndef __MIPS_ASM_MIPS_CPS_H__
> > +# error Please include asm/mips-cps.h rather than asm/mips-gic.h
> > +#endif
> > +
> > +#ifndef __MIPS_ASM_MIPS_GIC_H__
> > +#define __MIPS_ASM_MIPS_GIC_H__
> > +
> > +#include <linux/bitops.h>
> > +
> > +/* The base address of the GIC registers */
> > +extern void __iomem *mips_gic_base;
> > +
> > +/* Offsets from the GIC base address to various control blocks */
> > +#define MIPS_GIC_SHARED_OFS	0x00000
> > +#define MIPS_GIC_SHARED_SZ	0x08000
> > +#define MIPS_GIC_LOCAL_OFS	0x08000
> > +#define MIPS_GIC_LOCAL_SZ	0x04000
> > +#define MIPS_GIC_REDIR_OFS	0x0c000
> > +#define MIPS_GIC_REDIR_SZ	0x04000
> > +#define MIPS_GIC_USER_OFS	0x10000
> > +#define MIPS_GIC_USER_SZ	0x10000
> > +
> > +/* For read-only shared registers */
> > +#define GIC_ACCESSOR_RO(sz, off, name)					\
> > +	CPS_ACCESSOR_RO(gic, sz, MIPS_GIC_SHARED_OFS + off, name)
> > +
> > +/* For read-write shared registers */
> > +#define GIC_ACCESSOR_RW(sz, off, name)					\
> > +	CPS_ACCESSOR_RW(gic, sz, MIPS_GIC_SHARED_OFS + off, name)
> > +
> > +/* For read-only local registers */
> > +#define GIC_VX_ACCESSOR_RO(sz, off, name)				\
> > +	CPS_ACCESSOR_RO(gic, sz, MIPS_GIC_LOCAL_OFS + off, vl_##name)	\
> > +	CPS_ACCESSOR_RO(gic, sz, MIPS_GIC_REDIR_OFS + off, vo_##name)
> > +
> > +/* For read-write local registers */
> > +#define GIC_VX_ACCESSOR_RW(sz, off, name)				\
> > +	CPS_ACCESSOR_RW(gic, sz, MIPS_GIC_LOCAL_OFS + off, vl_##name)	\
> > +	CPS_ACCESSOR_RW(gic, sz, MIPS_GIC_REDIR_OFS + off, vo_##name)
> > +
> > +/* For read-only shared per-interrupt registers */
> > +#define GIC_ACCESSOR_RO_INTR_REG(sz, off, stride, name)			\
> > +static inline void __iomem *addr_gic_##name(unsigned int intr)		\
> > +{									\
> > +	return mips_gic_base + (off) + (intr * (stride));		\
> > +}									\
> > +									\
> > +static inline unsigned int read_gic_##name(unsigned int intr)		\
> > +{									\
> > +	BUILD_BUG_ON(sz != 32);						\
> > +	return __raw_readl(addr_gic_##name(intr));			\
> > +}
> > +
> > +/* For read-write shared per-interrupt registers */
> > +#define GIC_ACCESSOR_RW_INTR_REG(sz, off, stride, name)			\
> > +	GIC_ACCESSOR_RO_INTR_REG(sz, off, stride, name)			\
> > +									\
> > +static inline void write_gic_##name(unsigned int intr,			\
> > +				    unsigned int val)			\
> > +{									\
> > +	BUILD_BUG_ON(sz != 32);						\
> > +	__raw_writel(val, addr_gic_##name(intr));			\
> > +}
> > +
> > +/* For read-only local per-interrupt registers */
> > +#define GIC_VX_ACCESSOR_RO_INTR_REG(sz, off, stride, name)		\
> > +	GIC_ACCESSOR_RO_INTR_REG(sz, MIPS_GIC_LOCAL_OFS + off,		\
> > +				 stride, vl_##name)			\
> > +	GIC_ACCESSOR_RO_INTR_REG(sz, MIPS_GIC_REDIR_OFS + off,		\
> > +				 stride, vo_##name)
> > +
> > +/* For read-write local per-interrupt registers */
> > +#define GIC_VX_ACCESSOR_RW_INTR_REG(sz, off, stride, name)		\
> > +	GIC_ACCESSOR_RW_INTR_REG(sz, MIPS_GIC_LOCAL_OFS + off,		\
> > +				 stride, vl_##name)			\
> > +	GIC_ACCESSOR_RW_INTR_REG(sz, MIPS_GIC_REDIR_OFS + off,		\
> > +				 stride, vo_##name)
> > +
> > +/* For read-only shared bit-per-interrupt registers */
> > +#define GIC_ACCESSOR_RO_INTR_BIT(off, name)				\
> > +static inline void __iomem *addr_gic_##name(void)			\
> > +{									\
> > +	return mips_gic_base + (off);					\
> > +}									\
> > +									\
> > +static inline unsigned int read_gic_##name(unsigned int intr)		\
> > +{									\
> > +	void __iomem *addr = addr_gic_##name();				\
> > +	unsigned int val;						\
> > +									\
> > +	if (mips_cm_is64) {						\
> > +		addr += (intr / 64) * sizeof(uint64_t);			\
> > +		val = __raw_readq(addr) >> intr % 64;			\
> > +	} else {							\
> > +		addr += (intr / 32) * sizeof(uint32_t);			\
> > +		val = __raw_readl(addr) >> intr % 32;			\
> > +	}								\
> > +									\
> > +	return val & 0x1;						\
> > +}
> > +
> > +/* For read-write shared bit-per-interrupt registers */
> > +#define GIC_ACCESSOR_RW_INTR_BIT(off, name)				\
> > +	GIC_ACCESSOR_RO_INTR_BIT(off, name)				\
> > +									\
> > +static inline void write_gic_##name(unsigned int intr)			\
> > +{									\
> > +	void __iomem *addr = addr_gic_##name();				\
> > +									\
> > +	if (mips_cm_is64) {						\
> 
> Given that you now refer to this symbol, wouldn't it be best to include
> asm/mips-cm.h here? It is probably included via some other path, but
> it'd make this file standalone.
> 
> Thanks,
> 
> 	M.

The inclusion is actually sort of the other way right now - asm/mips-cps.h 
includes each of asm/mips-cm.h, asm/mips-cpc.h & asm/mips-gic.h. This allows 
us to have code in asm/mips-cps.h which makes use of combinations of those 3 
blocks (CM, CPC & GIC) that form the MIPS Coherent Processing System.

Right now, well once the "MIPS: Initial multi-cluster support" series gets 
merged, the code in asm/mips-cps.h only really requires the CM & CPC headers 
but it seemed good to be consistent & include the GIC one in the same way.

Thanks,
    Paul
--nextPart136644354.Ievfv3LtmX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEELIGR03D5+Fg+69wPgiDZ+mk8HGUFAlmXGSgACgkQgiDZ+mk8
HGW4fRAAjxSSbSNLckttnMTPwls+M1s4Yv0tWVGVVZzhOxctHzawGu6nNqA5/O4Q
J+b570xV4qoFPPKtAMRF3MnvwJt932TmVEaAODqWrYzotgir+DfU2cYhYwHS9QQ4
t6TLF1mEgFxtcXHDMaTVIcC2FAEhXcwCdUx8B++ksM9ejCegH5B3jvvAhoUvm3iJ
b8BmCUW59uBLBSME93BBmugbpAL4J7ZAT09TcX+2hHxBDZhj8zeH8dO8qb6dApej
GAK1dq1jLZQa5J7epY+wytQEToPdmxNU0qkD19rAxEvAiQxB+rzBHZa65kaOaslL
UFHReahdRnUy6ysSmGWtt9StdF6oq2IcLA4tFe6MLROu9sxCgfC6Tyhd1ICIewSM
iA+T9UqjYf4/ulD2/ll1g3kZJXAzymbnCw8OaYrVHSG6b28wdsxSBEaW0gilPP49
KJOudZWVWRZxf3pOLTdLJf7d23CbbKspZto7OEaFc2P08c60JPwA9KRax9R48f+m
lis9Qb1xvnLywRPIDcchvzzMgT3SI2hPDVCbKA1teZy4vng0vDeAV5Y7VcrCj/kx
yKJw58voV3n3QzO3Q0pKSSjdRK7lqN+VFsiX6Jh3+gzKi0FhVleedH8rnVHMHoEB
aqYn2wFD4sIaxkXCUkv9y8DJmBoIOXUn0IUj/JQLJxT3PJcAGoI=
=PZG9
-----END PGP SIGNATURE-----

--nextPart136644354.Ievfv3LtmX--
