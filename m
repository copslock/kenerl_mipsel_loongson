Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Feb 2010 14:01:45 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:33848 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492262Ab0BBNBl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 2 Feb 2010 14:01:41 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o12D1sSb013930;
        Tue, 2 Feb 2010 14:01:54 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o12D1rbB013929;
        Tue, 2 Feb 2010 14:01:53 +0100
Date:   Tue, 2 Feb 2010 14:01:53 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Guenter Roeck <guenter.roeck@ericsson.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH v5] Virtual memory size detection for 64 bit MIPS CPUs
Message-ID: <20100202130153.GB10837@linux-mips.org>
References: <1265107061-18355-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1265107061-18355-1-git-send-email-guenter.roeck@ericsson.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25846
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 02, 2010 at 02:37:41AM -0800, Guenter Roeck wrote:

Pretty good, let the nitpicking start :-)

> diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
> index 1f4df64..284eb55 100644
> --- a/arch/mips/include/asm/cpu-features.h
> +++ b/arch/mips/include/asm/cpu-features.h
> @@ -209,6 +209,9 @@
>  # ifndef cpu_has_64bit_addresses
>  # define cpu_has_64bit_addresses	1
>  # endif
> +# ifndef cpu_vmbits
> +# define cpu_vmbits cpu_data[0].vmbits
> +# endif
>  #endif

For 32-bit kernels we probably should fix cpu_vmbits to 31.

#ifdef CONFIG_64BIT
# ifndef cpu_vmbits
#  define cpu_vmbits cpu_data[0].vmbits
#  define __NEED_VMBITS
# endif
#else
# #define cpu_vmbits 31
#endif

>  #if defined(CONFIG_CPU_MIPSR2_IRQ_VI) && !defined(cpu_has_vint)
> diff --git a/arch/mips/include/asm/cpu-info.h b/arch/mips/include/asm/cpu-info.h
> index 1260443..3c694bc 100644
> --- a/arch/mips/include/asm/cpu-info.h
> +++ b/arch/mips/include/asm/cpu-info.h
> @@ -58,6 +58,7 @@ struct cpuinfo_mips {
>  	struct cache_desc	tcache;	/* Tertiary/split secondary cache */
>  	int			srsets;	/* Shadow register sets */
>  	int			core;	/* physical core number */
> +	int			vmbits;	/* Virtual memory size in bits */

#ifdef __NEED_VMBITS
	int			vmbits;	/* Virtual memory size in bits */
#endif

To do for a later separate patch - minimize the sizes of all cpuinfo_mips
members; int is overkill for many members.

>  #if defined(CONFIG_MIPS_MT_SMP) || defined(CONFIG_MIPS_MT_SMTC)
>  	/*
>  	 * In the MIPS MT "SMTC" model, each TC is considered
> diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
> index 9cd5089..8eda30b 100644
> --- a/arch/mips/include/asm/pgtable-64.h
> +++ b/arch/mips/include/asm/pgtable-64.h
> @@ -110,7 +110,9 @@
>  #define VMALLOC_START		MAP_BASE
>  #define VMALLOC_END	\
>  	(VMALLOC_START + \
> -	 PTRS_PER_PGD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE - (1UL << 32))
> +	 min(PTRS_PER_PGD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE, \
> +	     (1UL << cpu_vmbits)) - (1UL << 32))
> +

This overlaps with other allocations near the top - yes, we've been living
dangerous but with bottom up allocations a conflict was very, very unlikely.

Dealing with them in a sane way in the VMALLOC_END macro definition is hard,
so I suggest changing the definition to something like:

extern unsigned long vmalloc_end;

#define VMALLOC_START	MAP_BASE
#define VMALLOC_END	vmalloc_end

And initialize the value of vmalloc_end in something like the mm section of
arch/mips/kernel/traps.c:per_cpu_trap_init().

There you can also ensure the value of vmalloc_end is <= FIXADDR_START.

Finally probing can be used to fix yet another sin.  For 64-bit kernels
arch/mips/include/asm/processor.h defines TASK_SIZE:

#define TASK_SIZE       0x10000000000UL

This should turn into something like.

#define TASK_SIZE	(1UL << vmbits)

This is also why I sugget to keep vmbits as 31, not 32.  Hello S390 :-)

> +static inline void cpu_set_vmbits(struct cpuinfo_mips *c)
> +{
> +	if (cpu_has_64bits) {
> +		write_c0_entryhi(0x3ffffffffffff000ULL);
> +		back_to_back_c0_hazard();
> +		c->vmbits = fls64(read_c0_entryhi() & 0x3ffffffffffff000ULL);
> +	} else
> +		c->vmbits = 32;
> +}

With my changes suggested above this would need changing to something like:

static inline void cpu_set_vmbits(struct cpuinfo_mips *c)
{
	if (__NEED_VMBITS) {
		write_c0_entryhi(0x3ffffffffffff000ULL);
		back_to_back_c0_hazard();
		c->vmbits = fls64(read_c0_entryhi() & 0x3ffffffffffff000ULL);

		return;
	}

	BUG();
}

>  #define R4K_OPTS (MIPS_CPU_TLB | MIPS_CPU_4KEX | MIPS_CPU_4K_CACHE \
>  		| MIPS_CPU_COUNTER)
>  
> @@ -967,6 +977,8 @@ __cpuinit void cpu_probe(void)
>  		c->srsets = ((read_c0_srsctl() >> 26) & 0x0f) + 1;
>  	else
>  		c->srsets = 1;
> +
> +	cpu_set_vmbits(c);

I think a name like cpu_probe_vmbits() would be clearer.

Thanks,

  Ralf
