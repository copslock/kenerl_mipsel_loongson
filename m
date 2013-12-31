Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Dec 2013 16:09:30 +0100 (CET)
Received: from [195.154.112.97] ([195.154.112.97]:47570 "EHLO hall.aurel32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825378Ab3LaPJ1bXlpL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Dec 2013 16:09:27 +0100
Received: from aurel32 by hall.aurel32.net with local (Exim 4.80)
        (envelope-from <aurelien@aurel32.net>)
        id 1Vy0wb-0001OD-TF; Tue, 31 Dec 2013 16:09:21 +0100
Date:   Tue, 31 Dec 2013 16:09:21 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Huacai Chen <chenhc@lemote.com>,
        Huacai Chen <chenhuacai@gmail.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] MIPS: Fix case mismatch in
 local_r4k_flush_icache_range()
Message-ID: <20131231150921.GB20636@hall.aurel32.net>
References: <1385755623-25219-1-git-send-email-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1385755623-25219-1-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: Mutt 1.5.21 (2010-09-15)
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38821
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

On Fri, Nov 29, 2013 at 10:07:02PM +0200, Aaro Koskinen wrote:
> From: Huacai Chen <chenhc@lemote.com>
> 
> Currently, Loongson-2 call protected_blast_icache_range() and others
> call protected_loongson23_blast_icache_range(), but I think the
> correct behavior should be the opposite. BTW, Loongson-3's cache-ops is
> compatible with MIPS64, but not compatible with Loongson-2. So, rename
> xxx_loongson23_yyy things to xxx_loongson2_yyy.
> 
> The patch fixes early boot hang with 3.13-rc1, introduced in the commit
> 14bd8c082016cd1f67fdfd702e4cf6367869a712 (MIPS: Loongson: Get rid of
> Loongson 2 #ifdefery all over arch/mips.).
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>  arch/mips/include/asm/cacheops.h | 2 +-
>  arch/mips/include/asm/r4kcache.h | 8 ++++----
>  arch/mips/mm/c-r4k.c             | 4 ++--
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/mips/include/asm/cacheops.h b/arch/mips/include/asm/cacheops.h
> index c75025f..06b9bc7 100644
> --- a/arch/mips/include/asm/cacheops.h
> +++ b/arch/mips/include/asm/cacheops.h
> @@ -83,6 +83,6 @@
>  /*
>   * Loongson2-specific cacheops
>   */
> -#define Hit_Invalidate_I_Loongson23	0x00
> +#define Hit_Invalidate_I_Loongson2	0x00
>  
>  #endif	/* __ASM_CACHEOPS_H */
> diff --git a/arch/mips/include/asm/r4kcache.h b/arch/mips/include/asm/r4kcache.h
> index 34d1a19..91d20b0 100644
> --- a/arch/mips/include/asm/r4kcache.h
> +++ b/arch/mips/include/asm/r4kcache.h
> @@ -165,7 +165,7 @@ static inline void flush_icache_line(unsigned long addr)
>  	__iflush_prologue
>  	switch (boot_cpu_type()) {
>  	case CPU_LOONGSON2:
> -		cache_op(Hit_Invalidate_I_Loongson23, addr);
> +		cache_op(Hit_Invalidate_I_Loongson2, addr);
>  		break;
>  
>  	default:
> @@ -219,7 +219,7 @@ static inline void protected_flush_icache_line(unsigned long addr)
>  {
>  	switch (boot_cpu_type()) {
>  	case CPU_LOONGSON2:
> -		protected_cache_op(Hit_Invalidate_I_Loongson23, addr);
> +		protected_cache_op(Hit_Invalidate_I_Loongson2, addr);
>  		break;
>  
>  	default:
> @@ -452,8 +452,8 @@ static inline void prot##extra##blast_##pfx##cache##_range(unsigned long start,
>  __BUILD_BLAST_CACHE_RANGE(d, dcache, Hit_Writeback_Inv_D, protected_, )
>  __BUILD_BLAST_CACHE_RANGE(s, scache, Hit_Writeback_Inv_SD, protected_, )
>  __BUILD_BLAST_CACHE_RANGE(i, icache, Hit_Invalidate_I, protected_, )
> -__BUILD_BLAST_CACHE_RANGE(i, icache, Hit_Invalidate_I_Loongson23, \
> -	protected_, loongson23_)
> +__BUILD_BLAST_CACHE_RANGE(i, icache, Hit_Invalidate_I_Loongson2, \
> +	protected_, loongson2_)
>  __BUILD_BLAST_CACHE_RANGE(d, dcache, Hit_Writeback_Inv_D, , )
>  __BUILD_BLAST_CACHE_RANGE(s, scache, Hit_Writeback_Inv_SD, , )
>  /* blast_inv_dcache_range */
> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
> index 62ffd20..73f02da 100644
> --- a/arch/mips/mm/c-r4k.c
> +++ b/arch/mips/mm/c-r4k.c
> @@ -580,11 +580,11 @@ static inline void local_r4k_flush_icache_range(unsigned long start, unsigned lo
>  	else {
>  		switch (boot_cpu_type()) {
>  		case CPU_LOONGSON2:
> -			protected_blast_icache_range(start, end);
> +			protected_loongson2_blast_icache_range(start, end);
>  			break;
>  
>  		default:
> -			protected_loongson23_blast_icache_range(start, end);
> +			protected_blast_icache_range(start, end);
>  			break;
>  		}
>  	}

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

I think we should try to get this patch to 3.13 asap, as it might cause
some problem on MIPS machines other than Loongson 2 ones.

-- 
Aurelien Jarno	                        GPG: 1024D/F1BCDB73
aurelien@aurel32.net                 http://www.aurel32.net
