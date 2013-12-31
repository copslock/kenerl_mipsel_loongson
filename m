Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Dec 2013 16:12:55 +0100 (CET)
Received: from [195.154.112.97] ([195.154.112.97]:47586 "EHLO hall.aurel32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825503Ab3LaPMuKNpKg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Dec 2013 16:12:50 +0100
Received: from aurel32 by hall.aurel32.net with local (Exim 4.80)
        (envelope-from <aurelien@aurel32.net>)
        id 1Vy0zt-0001X2-UX; Tue, 31 Dec 2013 16:12:45 +0100
Date:   Tue, 31 Dec 2013 16:12:45 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Huacai Chen <chenhc@lemote.com>,
        Huacai Chen <chenhuacai@gmail.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] MIPS: fix blast_icache32 on loongson2
Message-ID: <20131231151245.GC20636@hall.aurel32.net>
References: <1385755623-25219-1-git-send-email-aaro.koskinen@iki.fi>
 <1385755623-25219-2-git-send-email-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1385755623-25219-2-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: Mutt 1.5.21 (2010-09-15)
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38822
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

On Fri, Nov 29, 2013 at 10:07:03PM +0200, Aaro Koskinen wrote:
> Commit 14bd8c082016cd1f67fdfd702e4cf6367869a712 (MIPS: Loongson: Get
> rid of Loongson 2 #ifdefery all over arch/mips.) failed to add Loongson2
> specific blast_icache32 functions. Fix that.
> 
> The patch fixes the following crash seen with 3.13-rc1:
> 
> [    3.652000] Reserved instruction in kernel code[#1]:
> [...]
> [    3.652000] Call Trace:
> [    3.652000] [<ffffffff802223c8>] blast_icache32_page+0x8/0xb0
> [    3.652000] [<ffffffff80222c34>] r4k_flush_cache_page+0x19c/0x200
> [    3.652000] [<ffffffff802d17e4>] do_wp_page.isra.97+0x47c/0xe08
> [    3.652000] [<ffffffff802d51b0>] handle_mm_fault+0x938/0x1118
> [    3.652000] [<ffffffff8021bd40>] __do_page_fault+0x140/0x540
> [    3.652000] [<ffffffff80206be4>] resume_userspace_check+0x0/0x10
> [    3.652000]
> [    3.652000] Code: 00200825  64834000  00200825 <bc900000> bc900020  bc900040  bc900060  bc900080  bc9000a0
> [    3.656000] ---[ end trace cd8a48f722f5c5f7 ]---
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>  arch/mips/include/asm/r4kcache.h | 43 ++++++++++++++++++++--------------------
>  arch/mips/mm/c-r4k.c             |  7 +++++++
>  2 files changed, 29 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/mips/include/asm/r4kcache.h b/arch/mips/include/asm/r4kcache.h
> index 91d20b0..c84cadd 100644
> --- a/arch/mips/include/asm/r4kcache.h
> +++ b/arch/mips/include/asm/r4kcache.h
> @@ -357,8 +357,8 @@ static inline void invalidate_tcache_page(unsigned long addr)
>  		  "i" (op));
>  
>  /* build blast_xxx, blast_xxx_page, blast_xxx_page_indexed */
> -#define __BUILD_BLAST_CACHE(pfx, desc, indexop, hitop, lsize) \
> -static inline void blast_##pfx##cache##lsize(void)			\
> +#define __BUILD_BLAST_CACHE(pfx, desc, indexop, hitop, lsize, extra)	\
> +static inline void extra##blast_##pfx##cache##lsize(void)		\
>  {									\
>  	unsigned long start = INDEX_BASE;				\
>  	unsigned long end = start + current_cpu_data.desc.waysize;	\
> @@ -376,7 +376,7 @@ static inline void blast_##pfx##cache##lsize(void)			\
>  	__##pfx##flush_epilogue						\
>  }									\
>  									\
> -static inline void blast_##pfx##cache##lsize##_page(unsigned long page) \
> +static inline void extra##blast_##pfx##cache##lsize##_page(unsigned long page) \
>  {									\
>  	unsigned long start = page;					\
>  	unsigned long end = page + PAGE_SIZE;				\
> @@ -391,7 +391,7 @@ static inline void blast_##pfx##cache##lsize##_page(unsigned long page) \
>  	__##pfx##flush_epilogue						\
>  }									\
>  									\
> -static inline void blast_##pfx##cache##lsize##_page_indexed(unsigned long page) \
> +static inline void extra##blast_##pfx##cache##lsize##_page_indexed(unsigned long page) \
>  {									\
>  	unsigned long indexmask = current_cpu_data.desc.waysize - 1;	\
>  	unsigned long start = INDEX_BASE + (page & indexmask);		\
> @@ -410,23 +410,24 @@ static inline void blast_##pfx##cache##lsize##_page_indexed(unsigned long page)
>  	__##pfx##flush_epilogue						\
>  }
>  
> -__BUILD_BLAST_CACHE(d, dcache, Index_Writeback_Inv_D, Hit_Writeback_Inv_D, 16)
> -__BUILD_BLAST_CACHE(i, icache, Index_Invalidate_I, Hit_Invalidate_I, 16)
> -__BUILD_BLAST_CACHE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 16)
> -__BUILD_BLAST_CACHE(d, dcache, Index_Writeback_Inv_D, Hit_Writeback_Inv_D, 32)
> -__BUILD_BLAST_CACHE(i, icache, Index_Invalidate_I, Hit_Invalidate_I, 32)
> -__BUILD_BLAST_CACHE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 32)
> -__BUILD_BLAST_CACHE(d, dcache, Index_Writeback_Inv_D, Hit_Writeback_Inv_D, 64)
> -__BUILD_BLAST_CACHE(i, icache, Index_Invalidate_I, Hit_Invalidate_I, 64)
> -__BUILD_BLAST_CACHE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 64)
> -__BUILD_BLAST_CACHE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 128)
> -
> -__BUILD_BLAST_CACHE(inv_d, dcache, Index_Writeback_Inv_D, Hit_Invalidate_D, 16)
> -__BUILD_BLAST_CACHE(inv_d, dcache, Index_Writeback_Inv_D, Hit_Invalidate_D, 32)
> -__BUILD_BLAST_CACHE(inv_s, scache, Index_Writeback_Inv_SD, Hit_Invalidate_SD, 16)
> -__BUILD_BLAST_CACHE(inv_s, scache, Index_Writeback_Inv_SD, Hit_Invalidate_SD, 32)
> -__BUILD_BLAST_CACHE(inv_s, scache, Index_Writeback_Inv_SD, Hit_Invalidate_SD, 64)
> -__BUILD_BLAST_CACHE(inv_s, scache, Index_Writeback_Inv_SD, Hit_Invalidate_SD, 128)
> +__BUILD_BLAST_CACHE(d, dcache, Index_Writeback_Inv_D, Hit_Writeback_Inv_D, 16, )
> +__BUILD_BLAST_CACHE(i, icache, Index_Invalidate_I, Hit_Invalidate_I, 16, )
> +__BUILD_BLAST_CACHE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 16, )
> +__BUILD_BLAST_CACHE(d, dcache, Index_Writeback_Inv_D, Hit_Writeback_Inv_D, 32, )
> +__BUILD_BLAST_CACHE(i, icache, Index_Invalidate_I, Hit_Invalidate_I, 32, )
> +__BUILD_BLAST_CACHE(i, icache, Index_Invalidate_I, Hit_Invalidate_I_Loongson2, 32, loongson2_)
> +__BUILD_BLAST_CACHE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 32, )
> +__BUILD_BLAST_CACHE(d, dcache, Index_Writeback_Inv_D, Hit_Writeback_Inv_D, 64, )
> +__BUILD_BLAST_CACHE(i, icache, Index_Invalidate_I, Hit_Invalidate_I, 64, )
> +__BUILD_BLAST_CACHE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 64, )
> +__BUILD_BLAST_CACHE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 128, )
> +
> +__BUILD_BLAST_CACHE(inv_d, dcache, Index_Writeback_Inv_D, Hit_Invalidate_D, 16, )
> +__BUILD_BLAST_CACHE(inv_d, dcache, Index_Writeback_Inv_D, Hit_Invalidate_D, 32, )
> +__BUILD_BLAST_CACHE(inv_s, scache, Index_Writeback_Inv_SD, Hit_Invalidate_SD, 16, )
> +__BUILD_BLAST_CACHE(inv_s, scache, Index_Writeback_Inv_SD, Hit_Invalidate_SD, 32, )
> +__BUILD_BLAST_CACHE(inv_s, scache, Index_Writeback_Inv_SD, Hit_Invalidate_SD, 64, )
> +__BUILD_BLAST_CACHE(inv_s, scache, Index_Writeback_Inv_SD, Hit_Invalidate_SD, 128, )
>  
>  /* build blast_xxx_range, protected_blast_xxx_range */
>  #define __BUILD_BLAST_CACHE_RANGE(pfx, desc, hitop, prot, extra)	\
> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
> index 73f02da..49e572d 100644
> --- a/arch/mips/mm/c-r4k.c
> +++ b/arch/mips/mm/c-r4k.c
> @@ -237,6 +237,8 @@ static void r4k_blast_icache_page_setup(void)
>  		r4k_blast_icache_page = (void *)cache_noop;
>  	else if (ic_lsize == 16)
>  		r4k_blast_icache_page = blast_icache16_page;
> +	else if (ic_lsize == 32 && current_cpu_type() == CPU_LOONGSON2)
> +		r4k_blast_icache_page = loongson2_blast_icache32_page;
>  	else if (ic_lsize == 32)
>  		r4k_blast_icache_page = blast_icache32_page;
>  	else if (ic_lsize == 64)
> @@ -261,6 +263,9 @@ static void r4k_blast_icache_page_indexed_setup(void)
>  		else if (TX49XX_ICACHE_INDEX_INV_WAR)
>  			r4k_blast_icache_page_indexed =
>  				tx49_blast_icache32_page_indexed;
> +		else if (current_cpu_type() == CPU_LOONGSON2)
> +			r4k_blast_icache_page_indexed =
> +				loongson2_blast_icache32_page_indexed;
>  		else
>  			r4k_blast_icache_page_indexed =
>  				blast_icache32_page_indexed;
> @@ -284,6 +289,8 @@ static void r4k_blast_icache_setup(void)
>  			r4k_blast_icache = blast_r4600_v1_icache32;
>  		else if (TX49XX_ICACHE_INDEX_INV_WAR)
>  			r4k_blast_icache = tx49_blast_icache32;
> +		else if (current_cpu_type() == CPU_LOONGSON2)
> +			r4k_blast_icache = loongson2_blast_icache32;
>  		else
>  			r4k_blast_icache = blast_icache32;
>  	} else if (ic_lsize == 64)

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno	                        GPG: 1024D/F1BCDB73
aurelien@aurel32.net                 http://www.aurel32.net
