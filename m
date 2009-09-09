Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Sep 2009 00:37:03 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:3016 "EHLO smtp3"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493122AbZIIWg4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 10 Sep 2009 00:36:56 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by smtp3 with MailMarshal (v6,5,4,7535)
	id <B4aa82df70000>; Wed, 09 Sep 2009 15:36:39 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 9 Sep 2009 15:36:35 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 9 Sep 2009 15:36:35 -0700
Message-ID: <4AA82DF3.5070805@caviumnetworks.com>
Date:	Wed, 09 Sep 2009 15:36:35 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	Wu Fei <at.wufei@gmail.com>, Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Shrink the size of tlb handler
References: <20090903142753.GA6482@desktop> <20090903142953.GB6482@desktop>
In-Reply-To: <20090903142953.GB6482@desktop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Sep 2009 22:36:35.0616 (UTC) FILETIME=[FCE7DA00:01CA319D]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24002
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Wu Fei wrote:
> By combining swapper_pg_dir and module_pg_dir, several if conditions
> can be eliminated from the tlb exception handler. The reason they
> can be combined is that, the effective virtual address of vmalloc
> returned is at the bottom, and of module_alloc returned is at the
> top. It also fixes the bug in vmalloc(), which happens when its
> return address is not covered by the first pgd.
> 
> Signed-off-by: Wu Fei <at.wufei@gmail.com>


I like this patch.  I ported it to my 2.6.27 kernel and it seems to work 
well.

One thing you are missing is that that label_module_alloc should now no 
longer be needed in tlbex.c  It should be removed.

David Daney


> ---
>  arch/mips/include/asm/pgtable-64.h |   11 ++------
>  arch/mips/mm/init.c                |    3 --
>  arch/mips/mm/pgtable-64.c          |    3 --
>  arch/mips/mm/tlbex.c               |   49 ------------------------------------
>  4 files changed, 3 insertions(+), 63 deletions(-)
> 
> diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
> index 4ed9d1b..9cd5089 100644
> --- a/arch/mips/include/asm/pgtable-64.h
> +++ b/arch/mips/include/asm/pgtable-64.h
> @@ -109,13 +109,13 @@
>  
>  #define VMALLOC_START		MAP_BASE
>  #define VMALLOC_END	\
> -	(VMALLOC_START + PTRS_PER_PGD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE)
> +	(VMALLOC_START + \
> +	 PTRS_PER_PGD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE - (1UL << 32))
>  #if defined(CONFIG_MODULES) && defined(KBUILD_64BIT_SYM32) && \
>  	VMALLOC_START != CKSSEG
>  /* Load modules into 32bit-compatible segment. */
>  #define MODULE_START	CKSSEG
>  #define MODULE_END	(FIXADDR_START-2*PAGE_SIZE)
> -extern pgd_t module_pg_dir[PTRS_PER_PGD];
>  #endif
>  
>  #define pte_ERROR(e) \
> @@ -188,12 +188,7 @@ static inline void pud_clear(pud_t *pudp)
>  #define __pmd_offset(address)	pmd_index(address)
>  
>  /* to find an entry in a kernel page-table-directory */
> -#ifdef MODULE_START
> -#define pgd_offset_k(address) \
> -	((address) >= MODULE_START ? module_pg_dir : pgd_offset(&init_mm, 0UL))
> -#else
> -#define pgd_offset_k(address) pgd_offset(&init_mm, 0UL)
> -#endif
> +#define pgd_offset_k(address) pgd_offset(&init_mm, address)
>  
>  #define pgd_index(address)	(((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))
>  #define pmd_index(address)	(((address) >> PMD_SHIFT) & (PTRS_PER_PMD-1))
> diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
> index 0e82050..38c79c5 100644
> --- a/arch/mips/mm/init.c
> +++ b/arch/mips/mm/init.c
> @@ -475,9 +475,6 @@ unsigned long pgd_current[NR_CPUS];
>   */
>  pgd_t swapper_pg_dir[_PTRS_PER_PGD] __page_aligned(_PGD_ORDER);
>  #ifdef CONFIG_64BIT
> -#ifdef MODULE_START
> -pgd_t module_pg_dir[PTRS_PER_PGD] __page_aligned(PGD_ORDER);
> -#endif
>  pmd_t invalid_pmd_table[PTRS_PER_PMD] __page_aligned(PMD_ORDER);
>  #endif
>  pte_t invalid_pte_table[PTRS_PER_PTE] __page_aligned(PTE_ORDER);
> diff --git a/arch/mips/mm/pgtable-64.c b/arch/mips/mm/pgtable-64.c
> index e4b565a..1121019 100644
> --- a/arch/mips/mm/pgtable-64.c
> +++ b/arch/mips/mm/pgtable-64.c
> @@ -59,9 +59,6 @@ void __init pagetable_init(void)
>  
>  	/* Initialize the entire pgd.  */
>  	pgd_init((unsigned long)swapper_pg_dir);
> -#ifdef MODULE_START
> -	pgd_init((unsigned long)module_pg_dir);
> -#endif
>  	pmd_init((unsigned long)invalid_pmd_table, (unsigned long)invalid_pte_table);
>  
>  	pgd_base = swapper_pg_dir;
> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
> index 9a17bf8..bc66f57 100644
> --- a/arch/mips/mm/tlbex.c
> +++ b/arch/mips/mm/tlbex.c
> @@ -499,11 +499,7 @@ build_get_pmde64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
>  	 * The vmalloc handling is not in the hotpath.
>  	 */
>  	uasm_i_dmfc0(p, tmp, C0_BADVADDR);
> -#ifdef MODULE_START
> -	uasm_il_bltz(p, r, tmp, label_module_alloc);
> -#else
>  	uasm_il_bltz(p, r, tmp, label_vmalloc);
> -#endif
>  	/* No uasm_i_nop needed here, since the next insn doesn't touch TMP. */
>  
>  #ifdef CONFIG_SMP
> @@ -556,52 +552,7 @@ build_get_pgd_vmalloc64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
>  {
>  	long swpd = (long)swapper_pg_dir;
>  
> -#ifdef MODULE_START
> -	long modd = (long)module_pg_dir;
> -
> -	uasm_l_module_alloc(l, *p);
> -	/*
> -	 * Assumption:
> -	 * VMALLOC_START >= 0xc000000000000000UL
> -	 * MODULE_START >= 0xe000000000000000UL
> -	 */
> -	UASM_i_SLL(p, ptr, bvaddr, 2);
> -	uasm_il_bgez(p, r, ptr, label_vmalloc);
> -
> -	if (uasm_in_compat_space_p(MODULE_START) &&
> -	    !uasm_rel_lo(MODULE_START)) {
> -		uasm_i_lui(p, ptr, uasm_rel_hi(MODULE_START)); /* delay slot */
> -	} else {
> -		/* unlikely configuration */
> -		uasm_i_nop(p); /* delay slot */
> -		UASM_i_LA(p, ptr, MODULE_START);
> -	}
> -	uasm_i_dsubu(p, bvaddr, bvaddr, ptr);
> -
> -	if (uasm_in_compat_space_p(modd) && !uasm_rel_lo(modd)) {
> -		uasm_il_b(p, r, label_vmalloc_done);
> -		uasm_i_lui(p, ptr, uasm_rel_hi(modd));
> -	} else {
> -		UASM_i_LA_mostly(p, ptr, modd);
> -		uasm_il_b(p, r, label_vmalloc_done);
> -		if (uasm_in_compat_space_p(modd))
> -			uasm_i_addiu(p, ptr, ptr, uasm_rel_lo(modd));
> -		else
> -			uasm_i_daddiu(p, ptr, ptr, uasm_rel_lo(modd));
> -	}
> -
>  	uasm_l_vmalloc(l, *p);
> -	if (uasm_in_compat_space_p(MODULE_START) &&
> -	    !uasm_rel_lo(MODULE_START) &&
> -	    MODULE_START << 32 == VMALLOC_START)
> -		uasm_i_dsll32(p, ptr, ptr, 0);	/* typical case */
> -	else
> -		UASM_i_LA(p, ptr, VMALLOC_START);
> -#else
> -	uasm_l_vmalloc(l, *p);
> -	UASM_i_LA(p, ptr, VMALLOC_START);
> -#endif
> -	uasm_i_dsubu(p, bvaddr, bvaddr, ptr);
>  
>  	if (uasm_in_compat_space_p(swpd) && !uasm_rel_lo(swpd)) {
>  		uasm_il_b(p, r, label_vmalloc_done);
