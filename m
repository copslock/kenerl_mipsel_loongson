Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Feb 2010 17:01:49 +0100 (CET)
Received: from imr1.ericy.com ([198.24.6.9]:54474 "EHLO imr1.ericy.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492289Ab0BBQBn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 2 Feb 2010 17:01:43 +0100
Received: from eusaamw0711.eamcs.ericsson.se ([147.117.20.178])
        by imr1.ericy.com (8.13.1/8.13.1) with ESMTP id o12G2dZX004116;
        Tue, 2 Feb 2010 10:02:42 -0600
Received: from localhost (147.117.20.212) by eusaamw0711.eamcs.ericsson.se
 (147.117.20.179) with Microsoft SMTP Server id 8.1.375.2; Tue, 2 Feb 2010
 11:01:31 -0500
Date:   Tue, 2 Feb 2010 08:03:14 -0800
From:   Guenter Roeck <guenter.roeck@ericsson.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH v5] Virtual memory size detection for 64 bit MIPS CPUs
Message-ID: <20100202160314.GA20951@ericsson.com>
References: <1265107061-18355-1-git-send-email-guenter.roeck@ericsson.com> <20100202130153.GB10837@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20100202130153.GB10837@linux-mips.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <groeck@ericsson.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25855
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guenter.roeck@ericsson.com
Precedence: bulk
X-list: linux-mips

On Tue, Feb 02, 2010 at 08:01:53AM -0500, Ralf Baechle wrote:
> On Tue, Feb 02, 2010 at 02:37:41AM -0800, Guenter Roeck wrote:
> 
> Pretty good, let the nitpicking start :-)
> 
> > diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
> > index 1f4df64..284eb55 100644
> > --- a/arch/mips/include/asm/cpu-features.h
> > +++ b/arch/mips/include/asm/cpu-features.h
> > @@ -209,6 +209,9 @@
> >  # ifndef cpu_has_64bit_addresses
> >  # define cpu_has_64bit_addresses	1
> >  # endif
> > +# ifndef cpu_vmbits
> > +# define cpu_vmbits cpu_data[0].vmbits
> > +# endif
> >  #endif
> 
> For 32-bit kernels we probably should fix cpu_vmbits to 31.
> 
> #ifdef CONFIG_64BIT
> # ifndef cpu_vmbits
> #  define cpu_vmbits cpu_data[0].vmbits
> #  define __NEED_VMBITS
> # endif
> #else
> # #define cpu_vmbits 31
> #endif
> 
Makes sense in theory. However, cpu-features.h includes cpu-info.h
which would need to have __NEED_VMBITS defined. So we would have a circular dependency.

To avoid that, I could use CONFIG_64BIT directly whenever vmbits is used or set.
vmbits would still be calculated but not used if cpu_vmbits is defined separately.

Another option would be to define the vmbits variable with #ifdef CONFIG_64BIT,
but populate and use it only if __NEED_VMBITS is defined. That would avoid the
unnecessary calculation.

Let me know what you prefer, and if you have a better idea. Right now I use
the second approach.

> >  #if defined(CONFIG_CPU_MIPSR2_IRQ_VI) && !defined(cpu_has_vint)
> > diff --git a/arch/mips/include/asm/cpu-info.h b/arch/mips/include/asm/cpu-info.h
> > index 1260443..3c694bc 100644
> > --- a/arch/mips/include/asm/cpu-info.h
> > +++ b/arch/mips/include/asm/cpu-info.h
> > @@ -58,6 +58,7 @@ struct cpuinfo_mips {
> >  	struct cache_desc	tcache;	/* Tertiary/split secondary cache */
> >  	int			srsets;	/* Shadow register sets */
> >  	int			core;	/* physical core number */
> > +	int			vmbits;	/* Virtual memory size in bits */
> 
> #ifdef __NEED_VMBITS
> 	int			vmbits;	/* Virtual memory size in bits */
> #endif
> 
> To do for a later separate patch - minimize the sizes of all cpuinfo_mips
> members; int is overkill for many members.
> 
> >  #if defined(CONFIG_MIPS_MT_SMP) || defined(CONFIG_MIPS_MT_SMTC)
> >  	/*
> >  	 * In the MIPS MT "SMTC" model, each TC is considered
> > diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
> > index 9cd5089..8eda30b 100644
> > --- a/arch/mips/include/asm/pgtable-64.h
> > +++ b/arch/mips/include/asm/pgtable-64.h
> > @@ -110,7 +110,9 @@
> >  #define VMALLOC_START		MAP_BASE
> >  #define VMALLOC_END	\
> >  	(VMALLOC_START + \
> > -	 PTRS_PER_PGD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE - (1UL << 32))
> > +	 min(PTRS_PER_PGD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE, \
> > +	     (1UL << cpu_vmbits)) - (1UL << 32))
> > +
> 
> This overlaps with other allocations near the top - yes, we've been living
> dangerous but with bottom up allocations a conflict was very, very unlikely.
> 
> Dealing with them in a sane way in the VMALLOC_END macro definition is hard,
> so I suggest changing the definition to something like:
> 
> extern unsigned long vmalloc_end;
> 
> #define VMALLOC_START	MAP_BASE
> #define VMALLOC_END	vmalloc_end
> 
> And initialize the value of vmalloc_end in something like the mm section of
> arch/mips/kernel/traps.c:per_cpu_trap_init().
> 
> There you can also ensure the value of vmalloc_end is <= FIXADDR_START.
> 
FIXADDR_START is defined as 0xff000000, 0xfffe0000, or (0xff000000 - 0x20000),
for all kernels. If vmalloc_end must be below FIXADDR_START, I might as well
forget about the probing and just use the 32 bit define for VMALLOC_END.

Am I missing something ?

> Finally probing can be used to fix yet another sin.  For 64-bit kernels
> arch/mips/include/asm/processor.h defines TASK_SIZE:
> 
> #define TASK_SIZE       0x10000000000UL
> 
> This should turn into something like.
> 
> #define TASK_SIZE	(1UL << vmbits)
> 
> This is also why I sugget to keep vmbits as 31, not 32.  Hello S390 :-)
> 
A comment at the TASK_SIZE definition says "This is hardcoded into a few places,
so don't change it unless you know what you are doing". Changing it to a variable
causes compilation to fail, so it looks as if there are some deeper complexities
involved.

I think it would be better to change TASK_SIZE in a separate commit, after making
sure that the change does not break anything. So far the patch is a bug fix;
this would make it into an enhancement with unknown side effects.

> > +static inline void cpu_set_vmbits(struct cpuinfo_mips *c)
> > +{
> > +	if (cpu_has_64bits) {
> > +		write_c0_entryhi(0x3ffffffffffff000ULL);
> > +		back_to_back_c0_hazard();
> > +		c->vmbits = fls64(read_c0_entryhi() & 0x3ffffffffffff000ULL);
> > +	} else
> > +		c->vmbits = 32;
> > +}
> 
> With my changes suggested above this would need changing to something like:
> 
> static inline void cpu_set_vmbits(struct cpuinfo_mips *c)
> {
> 	if (__NEED_VMBITS) {
> 		write_c0_entryhi(0x3ffffffffffff000ULL);
> 		back_to_back_c0_hazard();
> 		c->vmbits = fls64(read_c0_entryhi() & 0x3ffffffffffff000ULL);
> 
> 		return;
> 	}
> 
> 	BUG();
> }
> 
BUG() doesn't work because it would fire if __NEED_VMBITS is false.
Also, I would have to define __NEED_VMBITS as TRUE/FALSE if I want to use it
in an if statement. So I decided to use #ifdef __NEED_VMBITS instead. 

> >  #define R4K_OPTS (MIPS_CPU_TLB | MIPS_CPU_4KEX | MIPS_CPU_4K_CACHE \
> >  		| MIPS_CPU_COUNTER)
> >  
> > @@ -967,6 +977,8 @@ __cpuinit void cpu_probe(void)
> >  		c->srsets = ((read_c0_srsctl() >> 26) & 0x0f) + 1;
> >  	else
> >  		c->srsets = 1;
> > +
> > +	cpu_set_vmbits(c);
> 
> I think a name like cpu_probe_vmbits() would be clearer.
> 
Agreed.

Thanks,
Guenter
