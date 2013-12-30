Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Dec 2013 22:33:59 +0100 (CET)
Received: from hall.aurel32.net ([195.154.112.97]:43950 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825493Ab3L3Vd4zVvDa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Dec 2013 22:33:56 +0100
Received: from aurel32 by hall.aurel32.net with local (Exim 4.80)
        (envelope-from <aurelien@aurel32.net>)
        id 1VxkTC-0004uQ-VX; Mon, 30 Dec 2013 22:33:55 +0100
Date:   Mon, 30 Dec 2013 22:33:54 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: Re: [PATCH V15 02/12] MIPS: Loongson: Add basic Loongson-3 CPU
 support
Message-ID: <20131230213354.GA20586@hall.aurel32.net>
References: <1387109676-540-1-git-send-email-chenhc@lemote.com>
 <1387109676-540-3-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1387109676-540-3-git-send-email-chenhc@lemote.com>
X-Mailer: Mutt 1.5.21 (2010-09-15)
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38815
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
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

On Sun, Dec 15, 2013 at 08:14:26PM +0800, Huacai Chen wrote:
> Basic Loongson-3 CPU support include CPU probing and TLB/cache
> initializing.
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Signed-off-by: Hongliang Tao <taohl@lemote.com>
> Signed-off-by: Hua Yan <yanh@lemote.com>
> ---
>  arch/mips/include/asm/cpu-type.h |    4 +++
>  arch/mips/kernel/cpu-probe.c     |   14 +++++++---
>  arch/mips/mm/c-r4k.c             |   56 ++++++++++++++++++++++++++++++++++++++
>  arch/mips/mm/tlb-r4k.c           |    3 +-
>  arch/mips/mm/tlbex.c             |    1 +
>  5 files changed, 73 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/mips/include/asm/cpu-type.h b/arch/mips/include/asm/cpu-type.h
> index 4a402cc..a591e63 100644
> --- a/arch/mips/include/asm/cpu-type.h
> +++ b/arch/mips/include/asm/cpu-type.h
> @@ -20,6 +20,10 @@ static inline int __pure __get_cpu_type(const int cpu_type)
>  	case CPU_LOONGSON2:
>  #endif
>  
> +#ifdef CONFIG_SYS_HAS_CPU_LOONGSON3
> +	case CPU_LOONGSON3:
> +#endif
> +
>  #ifdef CONFIG_SYS_HAS_CPU_LOONGSON1B
>  	case CPU_LOONGSON1:
>  #endif
> diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
> index c814287..4bc81b2 100644
> --- a/arch/mips/kernel/cpu-probe.c
> +++ b/arch/mips/kernel/cpu-probe.c
> @@ -639,17 +639,23 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
>  			     MIPS_CPU_LLSC;
>  		c->tlbsize = 64;
>  		break;
> -	case PRID_IMP_LOONGSON2:
> -		c->cputype = CPU_LOONGSON2;
> -		__cpu_name[cpu] = "ICT Loongson-2";
> -
> +	case PRID_IMP_LOONGSON2: /* Loongson-2/3 have the same PRID_IMP field */

In short it means there is one PRID_IMP for 32-bit Loongson CPUs, and
one for 64-bit ones. Maybe the name should be changed?

>  		switch (c->processor_id & PRID_REV_MASK) {
>  		case PRID_REV_LOONGSON2E:
> +			c->cputype = CPU_LOONGSON2;
> +			__cpu_name[cpu] = "ICT Loongson-2E";
>  			set_elf_platform(cpu, "loongson2e");
>  			break;
>  		case PRID_REV_LOONGSON2F:
> +			c->cputype = CPU_LOONGSON2;
> +			__cpu_name[cpu] = "ICT Loongson-2F";
>  			set_elf_platform(cpu, "loongson2f");
>  			break;
> +		case PRID_REV_LOONGSON3A:
> +			c->cputype = CPU_LOONGSON3;
> +			__cpu_name[cpu] = "ICT Loongson-3A";
> +			set_elf_platform(cpu, "loongson3a");
> +			break;
>  		}

I have mixed feelings about the Loongson-2 name change. On one side it's
clearly better to have 2E and 2F instead of 2 V0.2 and 2 V0.3, and it
should have been like that since the beginning. That said changing that
now is kind of breaking the userland. I know that it would break debian
installer support for example, though that should not be a real problem
as we ship the installer with a given kernel version. I don't know if
there are other usages that can cause a problem. Any opinion from
others?

Also it's totally out of scope of this patch, but having a different
value of cputype for Loongson 2E and 2F might be a good idea to remove
a few ifdef.

>  		set_isa(c, MIPS_CPU_ISA_III);
> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
> index 73f02da..69dd882 100644
> --- a/arch/mips/mm/c-r4k.c
> +++ b/arch/mips/mm/c-r4k.c
> @@ -348,6 +348,7 @@ static inline void local_r4k___flush_cache_all(void * args)
>  {
>  	switch (current_cpu_type()) {
>  	case CPU_LOONGSON2:
> +	case CPU_LOONGSON3:
>  	case CPU_R4000SC:
>  	case CPU_R4000MC:
>  	case CPU_R4400SC:
> @@ -1003,6 +1004,31 @@ static void probe_pcache(void)
>  		c->dcache.waybit = 0;
>  		break;
>  
> +	case CPU_LOONGSON3:
> +		config1 = read_c0_config1();
> +		if ((lsize = ((config1 >> 19) & 7)))
> +			c->icache.linesz = 2 << lsize;
> +		else
> +			c->icache.linesz = lsize;
                
Here you can use directly:
		c->icache.linesz = 0;

> +		c->icache.sets = 64 << ((config1 >> 22) & 7);
> +		c->icache.ways = 1 + ((config1 >> 16) & 7);
> +		icache_size = c->icache.sets *
> +					  c->icache.ways *
> +					  c->icache.linesz;
> +		c->icache.waybit = 0;
> +
> +		if ((lsize = ((config1 >> 10) & 7)))
> +			c->dcache.linesz = 2 << lsize;
> +		else
> +			c->dcache.linesz = lsize;

Same as above, you can set the value as 0 directly.

> +		c->dcache.sets = 64 << ((config1 >> 13) & 7);
> +		c->dcache.ways = 1 + ((config1 >> 7) & 7);
> +		dcache_size = c->dcache.sets *
> +					  c->dcache.ways *
> +					  c->dcache.linesz;
> +		c->dcache.waybit = 0;
> +		break;
> +
>  	default:
>  		if (!(config & MIPS_CONF_M))
>  			panic("Don't know how to probe P-caches on this cpu.");
> @@ -1222,6 +1248,32 @@ static void __init loongson2_sc_init(void)
>  	c->options |= MIPS_CPU_INCLUSIVE_CACHES;
>  }
>  
> +static void __init loongson3_sc_init(void)
> +{
> +	struct cpuinfo_mips *c = &current_cpu_data;
> +	unsigned int config2, lsize;
> +
> +	config2 = read_c0_config2();
> +	if ((lsize = ((config2 >> 4) & 15)))
> +		c->scache.linesz = 2 << lsize;
> +	else
> +		c->scache.linesz = lsize;

same as above, set to 0;

> +	c->scache.sets = 64 << ((config2 >> 8) & 15);
> +	c->scache.ways = 1 + (config2 & 15);
> +
> +	scache_size = c->scache.sets *
> +				  c->scache.ways *
> +				  c->scache.linesz;
> +	/* Loongson-3 has 4 cores, 1MB scache for each. scaches are shared */
> +	scache_size *= 4;
> +	c->scache.waybit = 0;
> +	pr_info("Unified secondary cache %ldkB %s, linesize %d bytes.\n",
> +	       scache_size >> 10, way_string[c->scache.ways], c->scache.linesz);
> +	if (scache_size)
> +		c->options |= MIPS_CPU_INCLUSIVE_CACHES;
> +	return;
> +}
> +
>  extern int r5k_sc_init(void);
>  extern int rm7k_sc_init(void);
>  extern int mips_sc_init(void);
> @@ -1274,6 +1326,10 @@ static void setup_scache(void)
>  		loongson2_sc_init();
>  		return;
>  
> +	case CPU_LOONGSON3:
> +		loongson3_sc_init();
> +		return;
> +
>  	case CPU_XLP:
>  		/* don't need to worry about L2, fully coherent */
>  		return;
> diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
> index da3b0b9..10ab29e 100644
> --- a/arch/mips/mm/tlb-r4k.c
> +++ b/arch/mips/mm/tlb-r4k.c
> @@ -53,13 +53,14 @@ extern void build_tlb_refill_handler(void);
>  #endif /* CONFIG_MIPS_MT_SMTC */
>  
>  /*
> - * LOONGSON2 has a 4 entry itlb which is a subset of dtlb,
> + * LOONGSON2/3 has a 4 entry itlb which is a subset of dtlb,
>   * unfortrunately, itlb is not totally transparent to software.

unfortunately

>   */
>  static inline void flush_itlb(void)
>  {
>  	switch (current_cpu_type()) {
>  	case CPU_LOONGSON2:
> +	case CPU_LOONGSON3:
>  		write_c0_diag(4);
>  		break;
>  	default:
> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
> index 183f2b5..f89124c 100644
> --- a/arch/mips/mm/tlbex.c
> +++ b/arch/mips/mm/tlbex.c
> @@ -579,6 +579,7 @@ static void build_tlb_write_entry(u32 **p, struct uasm_label **l,
>  	case CPU_BMIPS4380:
>  	case CPU_BMIPS5000:
>  	case CPU_LOONGSON2:
> +	case CPU_LOONGSON3:
>  	case CPU_R5500:
>  		if (m4kc_tlbp_war())
>  			uasm_i_nop(p);

Beside the few comments above, this patch globally looks fine to me.


-- 
Aurelien Jarno	                        GPG: 1024D/F1BCDB73
aurelien@aurel32.net                 http://www.aurel32.net
