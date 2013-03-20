Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Mar 2013 17:45:36 +0100 (CET)
Received: from mail-pb0-f54.google.com ([209.85.160.54]:48087 "EHLO
        mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824283Ab3CTQpe4gDmD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Mar 2013 17:45:34 +0100
Received: by mail-pb0-f54.google.com with SMTP id rr4so1490355pbb.41
        for <multiple recipients>; Wed, 20 Mar 2013 09:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=4UPxzLnBgCZ6JPOpp/np0RVJxf69Qqlip4w1rWlYbCM=;
        b=JmgCEuj0BWKaSEqOUY/8vWieGvolFzIKU8AG3SrSqDKzOPbc1i8QuEMxXHst0Pfmef
         SZcQkmEkP9o0EAJ3jRJsz5YBVBQNCz3Sf/oRt72bNbiDSqwxqMLjZKBgVLWWhh7QY7vm
         gyqNtOZqQDkV94yNcsBC4XSaE5tDZnkj7CSPfEIlM9ND+D4lj5XYJ/FaRab0qdFLXjG5
         nzFnoG02SAt1DXno18gSk/yWRO5WSTnemCbqjkoQ7pfbrFmvSfPGJeDroajbMvoGRLVE
         CFxzdzapOq8RLHhNmwgB2mkI4g3/zPwtlMFDCIggBWgUhwq+StXnuSYXHNsl4sfAmVcH
         n5HQ==
X-Received: by 10.68.211.8 with SMTP id my8mr10146978pbc.7.1363797928134;
        Wed, 20 Mar 2013 09:45:28 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id wi7sm2857476pac.9.2013.03.20.09.45.25
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 20 Mar 2013 09:45:25 -0700 (PDT)
Message-ID: <5149E7A4.3040906@gmail.com>
Date:   Wed, 20 Mar 2013 09:45:24 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
MIME-Version: 1.0
To:     Jayachandran C <jchandra@broadcom.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 2/3] MIPS: mm: Use scratch for PGD when !CONFIG_MIPS_PGD_C0_CONTEXT
References: <cover.1363772750.git.jchandra@broadcom.com> <0b28a7e2191bcaab55ecb362042f8c46da186b7c.1363772750.git.jchandra@broadcom.com>
In-Reply-To: <0b28a7e2191bcaab55ecb362042f8c46da186b7c.1363772750.git.jchandra@broadcom.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35920
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 03/20/2013 09:27 AM, Jayachandran C wrote:
> Allow usage of scratch register for current pgd even when
> MIPS_PGD_C0_CONTEXT is not configured.  MIPS_PGD_C0_CONTEXT is set
> for 64r2 platforms to indicate availability of Xcontext for saving
> cpuid, thus freeing Context which was used for cpuid to be used for
> saving PGD. This option was also tied to using a scratch register for
> storing PGD.
>
> This commit will allow usage of scratch register to store the current
> pgd if one can be allocated for the platform, even when
> MIPS_PGD_C0_CONTEXT is not set. The cpu id will be kept in the CP0
> Context register in this case.


The point of MIPS_PGD_C0_CONTEXT is really to indicate that the PGD 
pointer is stored in a register (or portion thereof) and that setting 
the PGD is done by calling into uasm generated code.

Perhaps we should rename this Kconfig vairable so that its name 
indicates its function, or remove it altogether if possible, and machine 
generate the setting of the PGD pointer even when it is stored in the 
array in memory.


>
> The code to store the current pgd for the TLB miss handler is now
> generated in all cases. When scratch register is available, the PGD
> is also stored in the scratch register.
>
> Signed-off-by: Jayachandran C <jchandra@broadcom.com>
> ---
>   arch/mips/include/asm/mmu_context.h |    8 +-
>   arch/mips/mm/tlbex.c                |  142 ++++++++++++++++++++++-------------
>   2 files changed, 92 insertions(+), 58 deletions(-)
>
> diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mmu_context.h
> index e81d719..39e87ee 100644
> --- a/arch/mips/include/asm/mmu_context.h
> +++ b/arch/mips/include/asm/mmu_context.h
> @@ -24,13 +24,12 @@
>   #endif /* SMTC */
>   #include <asm-generic/mm_hooks.h>
>
> -#ifdef CONFIG_MIPS_PGD_C0_CONTEXT
> +extern void tlbmiss_handler_setup_pgd(unsigned long pgd);
>
>   #define TLBMISS_HANDLER_SETUP_PGD(pgd)				\
>   	tlbmiss_handler_setup_pgd((unsigned long)(pgd))
>
> -extern void tlbmiss_handler_setup_pgd(unsigned long pgd);
> -
> +#ifdef CONFIG_MIPS_PGD_C0_CONTEXT
>   #define TLBMISS_HANDLER_SETUP()						\
>   	do {								\
>   		TLBMISS_HANDLER_SETUP_PGD(swapper_pg_dir);		\
> @@ -46,9 +45,6 @@ extern void tlbmiss_handler_setup_pgd(unsigned long pgd);
>    */
>   extern unsigned long pgd_current[];
>
> -#define TLBMISS_HANDLER_SETUP_PGD(pgd) \
> -	pgd_current[smp_processor_id()] = (unsigned long)(pgd)
> -
>   #ifdef CONFIG_32BIT
>   #define TLBMISS_HANDLER_SETUP()						\
>   	write_c0_context((unsigned long) smp_processor_id() << 25);	\
> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
> index ca470c6..ede46d7 100644
> --- a/arch/mips/mm/tlbex.c
> +++ b/arch/mips/mm/tlbex.c
> @@ -829,11 +829,11 @@ build_get_pmde64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
>   	}
>   	/* No uasm_i_nop needed here, since the next insn doesn't touch TMP. */
>
> -#ifdef CONFIG_MIPS_PGD_C0_CONTEXT
>   	if (pgd_reg != -1) {
>   		/* pgd is in pgd_reg */
>   		UASM_i_MFC0(p, ptr, c0_kscratch(), pgd_reg);
>   	} else {
> +#ifdef CONFIG_MIPS_PGD_C0_CONTEXT
>   		/*
>   		 * &pgd << 11 stored in CONTEXT [23..63].
>   		 */
> @@ -845,30 +845,30 @@ build_get_pmde64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
>   		/* 1 0	1 0 1  << 6  xkphys cached */
>   		uasm_i_ori(p, ptr, ptr, 0x540);
>   		uasm_i_drotr(p, ptr, ptr, 11);
> -	}
>   #elif defined(CONFIG_SMP)
> -# ifdef	 CONFIG_MIPS_MT_SMTC
> -	/*
> -	 * SMTC uses TCBind value as "CPU" index
> -	 */
> -	uasm_i_mfc0(p, ptr, C0_TCBIND);
> -	uasm_i_dsrl_safe(p, ptr, ptr, 19);
> +# ifdef CONFIG_MIPS_MT_SMTC
> +		/*
> +		 * SMTC uses TCBind value as "CPU" index
> +		 */
> +		uasm_i_mfc0(p, ptr, C0_TCBIND);
> +		uasm_i_dsrl_safe(p, ptr, ptr, 19);
>   # else
> -	/*
> -	 * 64 bit SMP running in XKPHYS has smp_processor_id() << 3
> -	 * stored in CONTEXT.
> -	 */
> -	uasm_i_dmfc0(p, ptr, C0_CONTEXT);
> -	uasm_i_dsrl_safe(p, ptr, ptr, 23);
> +		/*
> +		 * 64 bit SMP running in XKPHYS has smp_processor_id() << 3
> +		 * stored in CONTEXT.
> +		 */
> +		uasm_i_dmfc0(p, ptr, C0_CONTEXT);
> +		uasm_i_dsrl_safe(p, ptr, ptr, 23);
>   # endif
> -	UASM_i_LA_mostly(p, tmp, pgdc);
> -	uasm_i_daddu(p, ptr, ptr, tmp);
> -	uasm_i_dmfc0(p, tmp, C0_BADVADDR);
> -	uasm_i_ld(p, ptr, uasm_rel_lo(pgdc), ptr);
> +		UASM_i_LA_mostly(p, tmp, pgdc);
> +		uasm_i_daddu(p, ptr, ptr, tmp);
> +		uasm_i_dmfc0(p, tmp, C0_BADVADDR);
> +		uasm_i_ld(p, ptr, uasm_rel_lo(pgdc), ptr);
>   #else
> -	UASM_i_LA_mostly(p, ptr, pgdc);
> -	uasm_i_ld(p, ptr, uasm_rel_lo(pgdc), ptr);
> +		UASM_i_LA_mostly(p, ptr, pgdc);
> +		uasm_i_ld(p, ptr, uasm_rel_lo(pgdc), ptr);
>   #endif
> +	}
>
>   	uasm_l_vmalloc_done(l, *p);
>
> @@ -963,31 +963,37 @@ build_get_pgd_vmalloc64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
>   static void __cpuinit __maybe_unused
>   build_get_pgde32(u32 **p, unsigned int tmp, unsigned int ptr)
>   {
> -	long pgdc = (long)pgd_current;
> +	if (pgd_reg != -1) {
> +		/* pgd is in pgd_reg */
> +		uasm_i_mfc0(p, ptr, c0_kscratch(), pgd_reg);
> +		uasm_i_mfc0(p, tmp, C0_BADVADDR); /* get faulting address */
> +	} else {
> +		long pgdc = (long)pgd_current;
>
> -	/* 32 bit SMP has smp_processor_id() stored in CONTEXT. */
> +		/* 32 bit SMP has smp_processor_id() stored in CONTEXT. */
>   #ifdef CONFIG_SMP
> -#ifdef	CONFIG_MIPS_MT_SMTC
> -	/*
> -	 * SMTC uses TCBind value as "CPU" index
> -	 */
> -	uasm_i_mfc0(p, ptr, C0_TCBIND);
> -	UASM_i_LA_mostly(p, tmp, pgdc);
> -	uasm_i_srl(p, ptr, ptr, 19);
> -#else
> -	/*
> -	 * smp_processor_id() << 3 is stored in CONTEXT.
> -	 */
> -	uasm_i_mfc0(p, ptr, C0_CONTEXT);
> -	UASM_i_LA_mostly(p, tmp, pgdc);
> -	uasm_i_srl(p, ptr, ptr, 23);
> -#endif
> -	uasm_i_addu(p, ptr, tmp, ptr);
> +# ifdef CONFIG_MIPS_MT_SMTC
> +		/*
> +		 * SMTC uses TCBind value as "CPU" index
> +		 */
> +		uasm_i_mfc0(p, ptr, C0_TCBIND);
> +		UASM_i_LA_mostly(p, tmp, pgdc);
> +		uasm_i_srl(p, ptr, ptr, 19);
> +# else
> +		/*
> +		 * smp_processor_id() << 3 is stored in CONTEXT.
> +		 */
> +		uasm_i_mfc0(p, ptr, C0_CONTEXT);
> +		UASM_i_LA_mostly(p, tmp, pgdc);
> +		uasm_i_srl(p, ptr, ptr, 23);
> +# endif
> +		uasm_i_addu(p, ptr, tmp, ptr);
>   #else
> -	UASM_i_LA_mostly(p, ptr, pgdc);
> +		UASM_i_LA_mostly(p, ptr, pgdc);
>   #endif
> -	uasm_i_mfc0(p, tmp, C0_BADVADDR); /* get faulting address */
> -	uasm_i_lw(p, ptr, uasm_rel_lo(pgdc), ptr);
> +		uasm_i_mfc0(p, tmp, C0_BADVADDR); /* get faulting address */
> +		uasm_i_lw(p, ptr, uasm_rel_lo(pgdc), ptr);
> +	}
>   	uasm_i_srl(p, tmp, tmp, PGDIR_SHIFT); /* get pgd only bits */
>   	uasm_i_sll(p, tmp, tmp, PGD_T_LOG2);
>   	uasm_i_addu(p, ptr, ptr, tmp); /* add in pgd offset */
> @@ -1468,16 +1474,17 @@ static void __cpuinit build_r4000_tlb_refill_handler(void)
>   u32 handle_tlbl[FASTPATH_SIZE] __cacheline_aligned;
>   u32 handle_tlbs[FASTPATH_SIZE] __cacheline_aligned;
>   u32 handle_tlbm[FASTPATH_SIZE] __cacheline_aligned;
> -#ifdef CONFIG_MIPS_PGD_C0_CONTEXT
>   u32 tlbmiss_handler_setup_pgd[16] __cacheline_aligned;
>
> -static void __cpuinit build_r4000_setup_pgd(void)
> +static void __cpuinit build_setup_pgd(void)
>   {
>   	const int a0 = 4;
> -	const int a1 = 5;
> +	const int __maybe_unused a1 = 5;
> +	const int __maybe_unused a2 = 6;
>   	u32 *p = tlbmiss_handler_setup_pgd;
> -	struct uasm_label *l = labels;
> -	struct uasm_reloc *r = relocs;
> +#ifndef CONFIG_MIPS_PGD_C0_CONTEXT
> +	long pgdc = (long)pgd_current;
> +#endif
>
>   	memset(tlbmiss_handler_setup_pgd, 0, sizeof(tlbmiss_handler_setup_pgd));
>   	memset(labels, 0, sizeof(labels));
> @@ -1485,7 +1492,11 @@ static void __cpuinit build_r4000_setup_pgd(void)
>
>   	pgd_reg = allocate_kscratch();
>
> +#ifdef CONFIG_MIPS_PGD_C0_CONTEXT
>   	if (pgd_reg == -1) {
> +		struct uasm_label *l = labels;
> +		struct uasm_reloc *r = relocs;
> +
>   		/* PGD << 11 in c0_Context */
>   		/*
>   		 * If it is a ckseg0 address, convert to a physical
> @@ -1507,6 +1518,37 @@ static void __cpuinit build_r4000_setup_pgd(void)
>   		uasm_i_jr(&p, 31);
>   		UASM_i_MTC0(&p, a0, c0_kscratch(), pgd_reg);
>   	}
> +#else
> +	/* Save PGD to pgd_current[smp_processor_id()] */
> +#if defined(CONFIG_SMP)
> +# ifdef CONFIG_MIPS_MT_SMTC
> +	/*
> +	 * SMTC uses TCBind value as "CPU" index
> +	 */
> +	uasm_i_mfc0(&p, a1, C0_TCBIND);
> +	uasm_i_dsrl_safe(&p, a1, a1, 19);
> +# else
> +	/*
> +	 * smp_processor_id() is in CONTEXT
> +	 */
> +	UASM_i_MFC0(&p, a1, C0_CONTEXT);
> +	uasm_i_dsrl_safe(&p, a1, a1, 23);
> +# endif
> +	UASM_i_LA_mostly(&p, a2, pgdc);
> +	UASM_i_ADDU(&p, a2, a2, a1);
> +	UASM_i_SW(&p, a0, uasm_rel_lo(pgdc), a2);
> +#else
> +	UASM_i_LA_mostly(&p, a2, pgdc);
> +	UASM_i_SW(&p, a0, uasm_rel_lo(pgdc), a2);
> +#endif /* SMP */
> +	uasm_i_jr(&p, 31);
> +
> +	/* if pgd_reg is allocated, save PGD also to scratch register */
> +	if (pgd_reg != -1)
> +		UASM_i_MTC0(&p, a0, c0_kscratch(), pgd_reg);
> +	else
> +		uasm_i_nop(&p);
> +#endif
>   	if (p - tlbmiss_handler_setup_pgd > ARRAY_SIZE(tlbmiss_handler_setup_pgd))
>   		panic("tlbmiss_handler_setup_pgd space exceeded");
>   	uasm_resolve_relocs(relocs, labels);
> @@ -1517,7 +1559,6 @@ static void __cpuinit build_r4000_setup_pgd(void)
>   		     tlbmiss_handler_setup_pgd,
>   		     ARRAY_SIZE(tlbmiss_handler_setup_pgd));
>   }
> -#endif
>
>   static void __cpuinit
>   iPTE_LW(u32 **p, unsigned int pte, unsigned int ptr)
> @@ -2175,6 +2216,7 @@ void __cpuinit build_tlb_refill_handler(void)
>   #ifndef CONFIG_MIPS_PGD_C0_CONTEXT
>   		build_r3000_tlb_refill_handler();
>   		if (!run_once) {
> +			build_setup_pgd();
>   			build_r3000_tlb_load_handler();
>   			build_r3000_tlb_store_handler();
>   			build_r3000_tlb_modify_handler();
> @@ -2197,9 +2239,7 @@ void __cpuinit build_tlb_refill_handler(void)
>   	default:
>   		if (!run_once) {
>   			scratch_reg = allocate_kscratch();
> -#ifdef CONFIG_MIPS_PGD_C0_CONTEXT
> -			build_r4000_setup_pgd();
> -#endif
> +			build_setup_pgd();
>   			build_r4000_tlb_load_handler();
>   			build_r4000_tlb_store_handler();
>   			build_r4000_tlb_modify_handler();
> @@ -2217,8 +2257,6 @@ void __cpuinit flush_tlb_handlers(void)
>   			   (unsigned long)handle_tlbs + sizeof(handle_tlbs));
>   	local_flush_icache_range((unsigned long)handle_tlbm,
>   			   (unsigned long)handle_tlbm + sizeof(handle_tlbm));
> -#ifdef CONFIG_MIPS_PGD_C0_CONTEXT
>   	local_flush_icache_range((unsigned long)tlbmiss_handler_setup_pgd,
>   			   (unsigned long)tlbmiss_handler_setup_pgd + sizeof(handle_tlbm));
> -#endif
>   }
>
