Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Aug 2017 13:10:42 +0200 (CEST)
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37476 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991181AbdHRLKabIp7W (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Aug 2017 13:10:30 +0200
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0373C2B;
        Fri, 18 Aug 2017 04:10:23 -0700 (PDT)
Received: from [10.1.207.16] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE0E23F540;
        Fri, 18 Aug 2017 04:10:21 -0700 (PDT)
Subject: Re: [PATCH 02/38] MIPS: GIC: Introduce asm/mips-gic.h with accessor
 functions
To:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-kernel@vger.kernel.org
References: <20170813043646.25821-1-paul.burton@imgtec.com>
 <20170813043646.25821-3-paul.burton@imgtec.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <b331ff4a-cdc6-49d1-96a5-f7536b3324f1@arm.com>
Date:   Fri, 18 Aug 2017 12:10:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170813043646.25821-3-paul.burton@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Return-Path: <marc.zyngier@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59643
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
> This patch introduces a new header providing accessor functions for the
> MIPS Global Interrupt Controller (GIC) mirroring those provided for the
> other 2 components of the MIPS Coherent Processing System (CPS) - the
> Coherence Manager (CM) & Cluster Power Controller (CPC).
> 
> This header makes use of the new standardised CPS accessor macros where
> possible, but does require some custom accessors for cases where we have
> either a bit or a register per interrupt.
> 
> A major advantage of this over the existing
> include/linux/irqchip/mips-gic.h definitions is that code performing
> accesses can become much simpler, for example this:
> 
>   gic_update_bits(GIC_REG(SHARED, GIC_SH_SET_TRIGGER) +
>                   GIC_INTR_OFS(intr), 1ul << GIC_INTR_BIT(intr),
>                   (unsigned long)trig << GIC_INTR_BIT(intr));
> 
> ...can become simply:
> 
>   change_gic_trig(intr, trig);
> 
> The accessors handle 32 vs 64 bit in the same way as for CM & CPC code,
> which means that GIC code will also not need to worry about the access
> size in most cases. They are also accessible outside of
> drivers/irqchip/irq-mips-gic.c which will allow for simplification in
> the use of the non-interrupt portions of the GIC (eg. counters) which
> currently require the interrupt controller driver to expose helper
> functions for access.
> 
> This patch doesn't change any existing code over to use the new
> accessors yet, since a wholesale change would be invasive & difficult to
> review. Instead follow-on patches will convert code piecemeal to use
> this new header. The one change to existing code is to rename gic_base
> to mips_gic_base & make it global, in order to fit in with the naming
> expected by the standardised CPS accessor macros.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> ---
> 
>  arch/mips/include/asm/mips-cps.h |   1 +
>  arch/mips/include/asm/mips-gic.h | 293 +++++++++++++++++++++++++++++++++++++++
>  drivers/irqchip/irq-mips-gic.c   |  13 +-
>  3 files changed, 300 insertions(+), 7 deletions(-)
>  create mode 100644 arch/mips/include/asm/mips-gic.h
> 
> diff --git a/arch/mips/include/asm/mips-cps.h b/arch/mips/include/asm/mips-cps.h
> index 2dd737d803e1..bf02b5070a98 100644
> --- a/arch/mips/include/asm/mips-cps.h
> +++ b/arch/mips/include/asm/mips-cps.h
> @@ -107,6 +107,7 @@ static inline void clear_##unit##_##name(uint##sz##_t val)		\
>  
>  #include <asm/mips-cm.h>
>  #include <asm/mips-cpc.h>
> +#include <asm/mips-gic.h>
>  
>  /**
>   * mips_cps_numclusters - return the number of clusters present in the system
> diff --git a/arch/mips/include/asm/mips-gic.h b/arch/mips/include/asm/mips-gic.h
> new file mode 100644
> index 000000000000..8cf4bdc1a059
> --- /dev/null
> +++ b/arch/mips/include/asm/mips-gic.h
> @@ -0,0 +1,293 @@
> +/*
> + * Copyright (C) 2017 Imagination Technologies
> + * Author: Paul Burton <paul.burton@imgtec.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +#ifndef __MIPS_ASM_MIPS_CPS_H__
> +# error Please include asm/mips-cps.h rather than asm/mips-gic.h
> +#endif
> +
> +#ifndef __MIPS_ASM_MIPS_GIC_H__
> +#define __MIPS_ASM_MIPS_GIC_H__
> +
> +#include <linux/bitops.h>
> +
> +/* The base address of the GIC registers */
> +extern void __iomem *mips_gic_base;
> +
> +/* Offsets from the GIC base address to various control blocks */
> +#define MIPS_GIC_SHARED_OFS	0x00000
> +#define MIPS_GIC_SHARED_SZ	0x08000
> +#define MIPS_GIC_LOCAL_OFS	0x08000
> +#define MIPS_GIC_LOCAL_SZ	0x04000
> +#define MIPS_GIC_REDIR_OFS	0x0c000
> +#define MIPS_GIC_REDIR_SZ	0x04000
> +#define MIPS_GIC_USER_OFS	0x10000
> +#define MIPS_GIC_USER_SZ	0x10000
> +
> +/* For read-only shared registers */
> +#define GIC_ACCESSOR_RO(sz, off, name)					\
> +	CPS_ACCESSOR_RO(gic, sz, MIPS_GIC_SHARED_OFS + off, name)
> +
> +/* For read-write shared registers */
> +#define GIC_ACCESSOR_RW(sz, off, name)					\
> +	CPS_ACCESSOR_RW(gic, sz, MIPS_GIC_SHARED_OFS + off, name)
> +
> +/* For read-only local registers */
> +#define GIC_VX_ACCESSOR_RO(sz, off, name)				\
> +	CPS_ACCESSOR_RO(gic, sz, MIPS_GIC_LOCAL_OFS + off, vl_##name)	\
> +	CPS_ACCESSOR_RO(gic, sz, MIPS_GIC_REDIR_OFS + off, vo_##name)
> +
> +/* For read-write local registers */
> +#define GIC_VX_ACCESSOR_RW(sz, off, name)				\
> +	CPS_ACCESSOR_RW(gic, sz, MIPS_GIC_LOCAL_OFS + off, vl_##name)	\
> +	CPS_ACCESSOR_RW(gic, sz, MIPS_GIC_REDIR_OFS + off, vo_##name)
> +
> +/* For read-only shared per-interrupt registers */
> +#define GIC_ACCESSOR_RO_INTR_REG(sz, off, stride, name)			\
> +static inline void __iomem *addr_gic_##name(unsigned int intr)		\
> +{									\
> +	return mips_gic_base + (off) + (intr * (stride));		\
> +}									\
> +									\
> +static inline unsigned int read_gic_##name(unsigned int intr)		\
> +{									\
> +	BUILD_BUG_ON(sz != 32);						\
> +	return __raw_readl(addr_gic_##name(intr));			\
> +}
> +
> +/* For read-write shared per-interrupt registers */
> +#define GIC_ACCESSOR_RW_INTR_REG(sz, off, stride, name)			\
> +	GIC_ACCESSOR_RO_INTR_REG(sz, off, stride, name)			\
> +									\
> +static inline void write_gic_##name(unsigned int intr,			\
> +				    unsigned int val)			\
> +{									\
> +	BUILD_BUG_ON(sz != 32);						\
> +	__raw_writel(val, addr_gic_##name(intr));			\
> +}
> +
> +/* For read-only local per-interrupt registers */
> +#define GIC_VX_ACCESSOR_RO_INTR_REG(sz, off, stride, name)		\
> +	GIC_ACCESSOR_RO_INTR_REG(sz, MIPS_GIC_LOCAL_OFS + off,		\
> +				 stride, vl_##name)			\
> +	GIC_ACCESSOR_RO_INTR_REG(sz, MIPS_GIC_REDIR_OFS + off,		\
> +				 stride, vo_##name)
> +
> +/* For read-write local per-interrupt registers */
> +#define GIC_VX_ACCESSOR_RW_INTR_REG(sz, off, stride, name)		\
> +	GIC_ACCESSOR_RW_INTR_REG(sz, MIPS_GIC_LOCAL_OFS + off,		\
> +				 stride, vl_##name)			\
> +	GIC_ACCESSOR_RW_INTR_REG(sz, MIPS_GIC_REDIR_OFS + off,		\
> +				 stride, vo_##name)
> +
> +/* For read-only shared bit-per-interrupt registers */
> +#define GIC_ACCESSOR_RO_INTR_BIT(off, name)				\
> +static inline void __iomem *addr_gic_##name(void)			\
> +{									\
> +	return mips_gic_base + (off);					\
> +}									\
> +									\
> +static inline unsigned int read_gic_##name(unsigned int intr)		\
> +{									\
> +	void __iomem *addr = addr_gic_##name();				\
> +	unsigned int val;						\
> +									\
> +	if (mips_cm_is64) {						\
> +		addr += (intr / 64) * sizeof(uint64_t);			\
> +		val = __raw_readq(addr) >> intr % 64;			\
> +	} else {							\
> +		addr += (intr / 32) * sizeof(uint32_t);			\
> +		val = __raw_readl(addr) >> intr % 32;			\
> +	}								\
> +									\
> +	return val & 0x1;						\
> +}
> +
> +/* For read-write shared bit-per-interrupt registers */
> +#define GIC_ACCESSOR_RW_INTR_BIT(off, name)				\
> +	GIC_ACCESSOR_RO_INTR_BIT(off, name)				\
> +									\
> +static inline void write_gic_##name(unsigned int intr)			\
> +{									\
> +	void __iomem *addr = addr_gic_##name();				\
> +									\
> +	if (mips_cm_is64) {						\

Given that you now refer to this symbol, wouldn't it be best to include
asm/mips-cm.h here? It is probably included via some other path, but
it'd make this file standalone.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
