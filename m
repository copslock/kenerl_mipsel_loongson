Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jun 2012 11:50:37 +0200 (CEST)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:39683 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903394Ab2FSJua (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Jun 2012 11:50:30 +0200
Received: by eaaf11 with SMTP id f11so1932938eaa.36
        for <multiple recipients>; Tue, 19 Jun 2012 02:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:organization:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding
         :content-type;
        bh=pxggMkLAVHpsO6Yhtcz/Fhoc1J4Pck3nlXWPkvztsLs=;
        b=RwLNogjP/o+6QWFkWC1pmyQrDuXP3Tppds1SzMOBd6I6ji+WpQywhLZ5BSwMC4KaK6
         ztcavzaf/wic7IipHOtH5ZnPtq5o+ReBuF79IrjOIXOy9SctvSxvHLX8yLNuajJBkLAk
         jqBNpRsxxT/Rww0YbIPLSXKI0fidiObH5IluAdCT7XkjrY7rAiEpk474cmjsWtQ8AkJY
         QgE+OhEBhTK+AZE0G6Ma/cHyQbJfuHHSAIDSFMQHjBQXjxU8Gspyvk3BYnqTrKTQPOmh
         msxDFqXO39kncvHoUZ4XydBEelIRTN8TIi82TEXOs1wZOaqURMtItF6s//cY34PWnCep
         hhkA==
Received: by 10.14.100.201 with SMTP id z49mr2092169eef.229.1340099424631;
        Tue, 19 Jun 2012 02:50:24 -0700 (PDT)
Received: from flexo.localnet (freebox.vlq16.iliad.fr. [213.36.7.13])
        by mx.google.com with ESMTPS id g46sm73508388eea.14.2012.06.19.02.50.21
        (version=SSLv3 cipher=OTHER);
        Tue, 19 Jun 2012 02:50:22 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Huacai Chen <chenhuacai@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: Re: [PATCH V2 02/16] MIPS: Loongson: Add basic Loongson-3 CPU support.
Date:   Tue, 19 Jun 2012 11:47:57 +0200
Message-ID: <2294746.SzucsIzFyJ@flexo>
Organization: OpenWrt
User-Agent: KMail/4.8.3 (Linux/3.2.0-24-generic; KDE/4.8.3; x86_64; ; )
In-Reply-To: <1340088624-25550-3-git-send-email-chenhc@lemote.com>
References: <1340088624-25550-1-git-send-email-chenhc@lemote.com> <1340088624-25550-3-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-archive-position: 33714
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi,

Comments inline, especially about your c-r4k.c changes. You don't seem to have 
updated arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h for 
LOONGSON3 is that inentional?

On Tuesday 19 June 2012 14:50:10 Huacai Chen wrote:
> Basic Loongson-3 CPU support include: CPU probing, TLB and cache
> initializing, cache flushing method, etc.
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Signed-off-by: Hongliang Tao <taohl@lemote.com>
> Signed-off-by: Hua Yan <yanh@lemote.com>
> ---
[snip]
> diff --git a/arch/mips/loongson/common/setup.c 
b/arch/mips/loongson/common/setup.c
> index 27d826b..ebb17ef 100644
> --- a/arch/mips/loongson/common/setup.c
> +++ b/arch/mips/loongson/common/setup.c
> @@ -18,9 +18,6 @@
>  #include <linux/screen_info.h>
>  #endif
>  
> -void (*__wbflush)(void);
> -EXPORT_SYMBOL(__wbflush);
> -
>  static void wbflush_loongson(void)
>  {
>  	asm(".set\tpush\n\t"
> @@ -32,6 +29,9 @@ static void wbflush_loongson(void)
>  	    ".set mips0\n\t");
>  }
>  
> +void (*__wbflush)(void) = wbflush_loongson;
> +EXPORT_SYMBOL(__wbflush);
> +

Can you explain why you need to move this symbol? It also looks like this 
could be a separate patch.

>  void __init plat_mem_setup(void)
>  {
>  	__wbflush = wbflush_loongson;
> diff --git a/arch/mips/mm/Makefile b/arch/mips/mm/Makefile
> index fd6203f..a79b6d1 100644
> --- a/arch/mips/mm/Makefile
> +++ b/arch/mips/mm/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_HIGHMEM)		+= highmem.o
>  obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
>  
>  obj-$(CONFIG_CPU_LOONGSON2)	+= c-r4k.o cex-gen.o tlb-r4k.o
> +obj-$(CONFIG_CPU_LOONGSON3)	+= c-r4k.o cex-gen.o tlb-r4k.o
>  obj-$(CONFIG_CPU_MIPS32)	+= c-r4k.o cex-gen.o tlb-r4k.o
>  obj-$(CONFIG_CPU_MIPS64)	+= c-r4k.o cex-gen.o tlb-r4k.o
>  obj-$(CONFIG_CPU_NEVADA)	+= c-r4k.o cex-gen.o tlb-r4k.o
> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
> index ce0dbee..a1a3482 100644
> --- a/arch/mips/mm/c-r4k.c
> +++ b/arch/mips/mm/c-r4k.c
> @@ -362,6 +362,9 @@ static inline void local_r4k___flush_cache_all(void * 
args)
>  
>  static void r4k___flush_cache_all(void)
>  {
> +#if defined(CONFIG_CPU_LOONGSON3)
> +	return;
> +#endif
>  	r4k_on_each_cpu(local_r4k___flush_cache_all, NULL);
>  }

This looks wrong, there is already a check for LOONGSON2 in 
local_r4k___flush_cache_all() and yet you are adding this special case in 
r4k___flush_cache_all(), so just move it to local_r4k___flush_cache_all() 
instead.

>  
> @@ -382,11 +385,17 @@ static inline int has_valid_asid(const struct 
mm_struct *mm)
>  
>  static void r4k__flush_cache_vmap(void)
>  {
> +#if defined(CONFIG_CPU_LOONGSON3)
> +	return;
> +#endif
>  	r4k_blast_dcache();
>  }
>  
>  static void r4k__flush_cache_vunmap(void)
>  {
> +#if defined(CONFIG_CPU_LOONGSON3)
> +	return;
> +#endif
>  	r4k_blast_dcache();
>  }

We might want to introduce a new cpu_has_foo() inline for this, such as 
cpu_has_blast_dache() or something like that.

>  
> @@ -408,6 +417,9 @@ static void r4k_flush_cache_range(struct vm_area_struct 
*vma,
>  {
>  	int exec = vma->vm_flags & VM_EXEC;
>  
> +#if defined(CONFIG_CPU_LOONGSON3)
> +	return;
> +#endif

We end up having an unused but set variable here in case of LOONGSOON3, so 
please mark this variable as __maybe_unused.

>  	if (cpu_has_dc_aliases || (exec && !cpu_has_ic_fills_f_dc))
>  		r4k_on_each_cpu(local_r4k_flush_cache_range, vma);
>  }
> @@ -438,6 +450,9 @@ static inline void local_r4k_flush_cache_mm(void * args)
>  
>  static void r4k_flush_cache_mm(struct mm_struct *mm)
>  {
> +#if defined(CONFIG_CPU_LOONGSON3)
> +	return;
> +#endif
>  	if (!cpu_has_dc_aliases)
>  		return;

This makes me think that maybe your cpu does not have data cache aliases? If 
such this should be noted as such in cpu-features-override.h and this ifdef 
can go away.

>  
> @@ -528,6 +543,9 @@ static void r4k_flush_cache_page(struct vm_area_struct 
*vma,
>  	unsigned long addr, unsigned long pfn)
>  {
>  	struct flush_cache_page_args args;
> +#if defined(CONFIG_CPU_LOONGSON3)
> +	return;
> +#endif

args becomes an unused variable.

>  
>  	args.vma = vma;
>  	args.addr = addr;
> @@ -543,6 +561,9 @@ static inline void local_r4k_flush_data_cache_page(void * 
addr)
>  
>  static void r4k_flush_data_cache_page(unsigned long addr)
>  {
> +#if defined(CONFIG_CPU_LOONGSON3)
> +	return;
> +#endif
>  	if (in_atomic())
>  		local_r4k_flush_data_cache_page((void *)addr);
>  	else
> @@ -701,6 +722,9 @@ static void local_r4k_flush_cache_sigtramp(void * arg)
>  
>  static void r4k_flush_cache_sigtramp(unsigned long addr)
>  {
> +#if defined(CONFIG_CPU_LOONGSON3)
> +	return;
> +#endif
>  	r4k_on_each_cpu(local_r4k_flush_cache_sigtramp, (void *) addr);
>  }
>  
> @@ -952,6 +976,31 @@ static void __cpuinit probe_pcache(void)
>  		c->dcache.waybit = 0;
>  		break;
>  
> +	case CPU_LOONGSON3:
> +		config1 = read_c0_config1();
> +		if ((lsize = ((config1 >> 19) & 7)))
> +			c->icache.linesz = 2 << lsize;
> +		else
> +			c->icache.linesz = lsize;
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
> @@ -1170,6 +1219,34 @@ static void __init loongson2_sc_init(void)
>  }
>  #endif
>  
> +#if defined(CONFIG_CPU_LOONGSON3)
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
> +#endif
> +
>  extern int r5k_sc_init(void);
>  extern int rm7k_sc_init(void);
>  extern int mips_sc_init(void);
> @@ -1224,6 +1301,13 @@ static void __cpuinit setup_scache(void)
>  		loongson2_sc_init();
>  		return;
>  #endif
> +
> +#if defined(CONFIG_CPU_LOONGSON3)
> +	case CPU_LOONGSON3:
> +		loongson3_sc_init();
> +		return;
> +#endif
> +
>  	case CPU_XLP:
>  		/* don't need to worry about L2, fully coherent */
>  		return;
> diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
> index d2572cb..11b9c88 100644
> --- a/arch/mips/mm/tlb-r4k.c
> +++ b/arch/mips/mm/tlb-r4k.c
> @@ -50,7 +50,7 @@ extern void build_tlb_refill_handler(void);
>  
>  #endif /* CONFIG_MIPS_MT_SMTC */
>  
> -#if defined(CONFIG_CPU_LOONGSON2)
> +#if defined(CONFIG_CPU_LOONGSON2) || defined(CONFIG_CPU_LOONGSON3)
>  /*
>   * LOONGSON2 has a 4 entry itlb which is a subset of dtlb,
>   * unfortrunately, itlb is not totally transparent to software.
> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
> index 03eb0ef..4420250 100644
> --- a/arch/mips/mm/tlbex.c
> +++ b/arch/mips/mm/tlbex.c
> @@ -507,6 +507,7 @@ static void __cpuinit build_tlb_write_entry(u32 **p, 
struct uasm_label **l,
>  	case CPU_BMIPS4380:
>  	case CPU_BMIPS5000:
>  	case CPU_LOONGSON2:
> +	case CPU_LOONGSON3:
>  	case CPU_R5500:
>  		if (m4kc_tlbp_war())
>  			uasm_i_nop(p);
> -- 
> 1.7.7.3
> 
> 
