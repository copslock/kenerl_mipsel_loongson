Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jun 2017 10:41:11 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:41216 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991129AbdFMIlDl9qgW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 13 Jun 2017 10:41:03 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v5D8ex7G008092;
        Tue, 13 Jun 2017 10:40:59 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v5D8evMX008091;
        Tue, 13 Jun 2017 10:40:57 +0200
Date:   Tue, 13 Jun 2017 10:40:57 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH V4 2/9] MIPS: c-r4k: Add r4k_blast_scache_node for
 Loongson-3
Message-ID: <20170613084057.GA31492@linux-mips.org>
References: <1496718888-18324-1-git-send-email-chenhc@lemote.com>
 <1496718888-18324-2-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1496718888-18324-2-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58417
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Tue, Jun 06, 2017 at 11:14:41AM +0800, Huacai Chen wrote:

> For multi-node Loongson-3 (NUMA configuration), r4k_blast_scache() can
> only flush Node-0's scache. So we add r4k_blast_scache_node() by using
> (CAC_BASE | (node_id << 44)) instead of CKSEG0 as the start address.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  arch/mips/include/asm/r4kcache.h | 26 ++++++++++++++++++++++++++
>  arch/mips/mm/c-r4k.c             | 33 ++++++++++++++++++++++++++++++++-
>  2 files changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/include/asm/r4kcache.h b/arch/mips/include/asm/r4kcache.h
> index 7f12d7e..aa615e3 100644
> --- a/arch/mips/include/asm/r4kcache.h
> +++ b/arch/mips/include/asm/r4kcache.h
> @@ -747,4 +747,30 @@ __BUILD_BLAST_CACHE_RANGE(s, scache, Hit_Writeback_Inv_SD, , )
>  __BUILD_BLAST_CACHE_RANGE(inv_d, dcache, Hit_Invalidate_D, , )
>  __BUILD_BLAST_CACHE_RANGE(inv_s, scache, Hit_Invalidate_SD, , )
>  
> +#ifdef CONFIG_CPU_LOONGSON3
> +#define __BUILD_BLAST_CACHE_NODE(pfx, desc, indexop, hitop, lsize)	\
> +static inline void blast_##pfx##cache##lsize##_node(long node)		\
> +{									\
> +	unsigned long start = CAC_BASE | (node << 44);			\
> +	unsigned long end = start + current_cpu_data.desc.waysize;	\
> +	unsigned long ws_inc = 1UL << current_cpu_data.desc.waybit;	\
> +	unsigned long ws_end = current_cpu_data.desc.ways <<		\
> +			       current_cpu_data.desc.waybit;		\
> +	unsigned long ws, addr;						\
> +									\
> +	__##pfx##flush_prologue						\
> +									\
> +	for (ws = 0; ws < ws_end; ws += ws_inc)				\
> +		for (addr = start; addr < end; addr += lsize * 32)	\
> +			cache##lsize##_unroll32(addr|ws, indexop);	\
> +									\
> +	__##pfx##flush_epilogue						\
> +}
> +
> +__BUILD_BLAST_CACHE_NODE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 16)
> +__BUILD_BLAST_CACHE_NODE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 32)
> +__BUILD_BLAST_CACHE_NODE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 64)
> +__BUILD_BLAST_CACHE_NODE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 128)
> +#endif

This all expand to just inline functions which generate no code if they're
unused, so you can drop the #ifdef.

However a comment explaining why this function is only required for
Loongson 3 would be great!

> +
>  #endif /* _ASM_R4KCACHE_H */
> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
> index 3fe99cb..0a49af0 100644
> --- a/arch/mips/mm/c-r4k.c
> +++ b/arch/mips/mm/c-r4k.c
> @@ -459,11 +459,29 @@ static void r4k_blast_scache_setup(void)
>  		r4k_blast_scache = blast_scache128;
>  }
>  
> +static void (* r4k_blast_scache_node)(long node);
> +
> +static void r4k_blast_scache_node_setup(void)
> +{
> +	unsigned long sc_lsize = cpu_scache_line_size();
> +
> +	r4k_blast_scache_node = (void *)cache_noop;
> +#ifdef CONFIG_CPU_LOONGSON3
> +	if (sc_lsize == 16)
> +		r4k_blast_scache_node = blast_scache16_node;
> +	else if (sc_lsize == 32)
> +		r4k_blast_scache_node = blast_scache32_node;
> +	else if (sc_lsize == 64)
> +		r4k_blast_scache_node = blast_scache64_node;
> +	else if (sc_lsize == 128)
> +		r4k_blast_scache_node = blast_scache128_node;
> +#endif

No #idefs please.  Instead you can check the CPU type with something like

	if (current_cpu_type() = CPU_LOONGSON3) {
		...
	}

__get_cpu_type() in include/asm/cpu-type.h will then ensure that GCC
knows it can optimize things for the CPU type(s) in use.

> +
>  static inline void local_r4k___flush_cache_all(void * args)
>  {
>  	switch (current_cpu_type()) {
>  	case CPU_LOONGSON2:
> -	case CPU_LOONGSON3:
>  	case CPU_R4000SC:
>  	case CPU_R4000MC:
>  	case CPU_R4400SC:
> @@ -480,6 +498,10 @@ static inline void local_r4k___flush_cache_all(void * args)
>  		r4k_blast_scache();
>  		break;
>  
> +	case CPU_LOONGSON3:
> +		r4k_blast_scache_node(get_ebase_cpunum() >> 2);
> +		break;
> +
>  	case CPU_BMIPS5000:
>  		r4k_blast_scache();
>  		__sync();
> @@ -840,7 +862,11 @@ static void r4k_dma_cache_wback_inv(unsigned long addr, unsigned long size)
>  	preempt_disable();
>  	if (cpu_has_inclusive_pcaches) {
>  		if (size >= scache_size)
> +#ifndef CONFIG_CPU_LOONGSON3
>  			r4k_blast_scache();
> +#else
> +			r4k_blast_scache_node((addr >> 44) & 0xF);
> +#endif

Ditto.

>  		else
>  			blast_scache_range(addr, addr + size);
>  		preempt_enable();
> @@ -873,7 +899,11 @@ static void r4k_dma_cache_inv(unsigned long addr, unsigned long size)
>  	preempt_disable();
>  	if (cpu_has_inclusive_pcaches) {
>  		if (size >= scache_size)
> +#ifndef CONFIG_CPU_LOONGSON3
>  			r4k_blast_scache();
> +#else
> +			r4k_blast_scache_node((addr >> 44) & 0xF);
> +#endif

Ditto.

>  		else {
>  			/*
>  			 * There is no clearly documented alignment requirement
> @@ -1903,6 +1933,7 @@ void r4k_cache_init(void)
>  	r4k_blast_scache_page_setup();
>  	r4k_blast_scache_page_indexed_setup();
>  	r4k_blast_scache_setup();
> +	r4k_blast_scache_node_setup();
>  #ifdef CONFIG_EVA
>  	r4k_blast_dcache_user_page_setup();
>  	r4k_blast_icache_user_page_setup();

  Ralf
