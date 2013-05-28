Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 May 2013 17:25:15 +0200 (CEST)
Received: from mail-qe0-f47.google.com ([209.85.128.47]:53363 "EHLO
        mail-qe0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827527Ab3E1PZIkkXiL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 May 2013 17:25:08 +0200
Received: by mail-qe0-f47.google.com with SMTP id f6so3456184qej.20
        for <multiple recipients>; Tue, 28 May 2013 08:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=3pbuMLiu1m6LX7qLmFWaWeN1nDf+EMan0EH9+n8eTOA=;
        b=aXbax9ZKVtNbJwHo90W10hQRsoUjOn4GnH4aaEDFyw+WQNClU8k3EupLPpXjR/zCrO
         KtCstA4iWz3bASNtXhMFKfx9hKsif8Zu6+VCu/Qlr2Uxdc8Ydd5YQaXlU0L88g+iYf8s
         ZxB4dyJeq72cU2YVyv0e00hhHL5OtEwMXq6fZVcGR5YLyitFjitCm63Avr1Iub9VZwEL
         /eAamrLip94ntos6akdo0pbi/HKF5MF0xhuOkbLV8uUqRlXp6VQKvpu/LwZ+uapsNnCi
         Onau4ZaqA6qaCmdtK59lrhhVNECOloW8ypESfCs5zwOx4F7zng+pLfG2htJuilp3N2tX
         k4Wg==
X-Received: by 10.224.172.1 with SMTP id j1mr32088411qaz.15.1369754702461;
        Tue, 28 May 2013 08:25:02 -0700 (PDT)
Received: from yakj.usersys.redhat.com (net-37-117-138-128.cust.dsl.vodafone.it. [37.117.138.128])
        by mx.google.com with ESMTPSA id y1sm28376719qad.5.2013.05.28.08.24.59
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 08:25:01 -0700 (PDT)
Message-ID: <51A4CC42.9030602@redhat.com>
Date:   Tue, 28 May 2013 17:24:50 +0200
From:   Paolo Bonzini <pbonzini@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130514 Thunderbird/17.0.6
MIME-Version: 1.0
To:     Sanjay Lal <sanjayl@kymasys.com>
CC:     kvm@vger.kernel.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Gleb Natapov <gleb@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 16/18] KVM/MIPS32-VZ: Add VZ-ASE support to KVM/MIPS data
 structures.
References: <n> <1368942460-15577-1-git-send-email-sanjayl@kymasys.com> <1368942460-15577-17-git-send-email-sanjayl@kymasys.com>
In-Reply-To: <1368942460-15577-17-git-send-email-sanjayl@kymasys.com>
X-Enigmail-Version: 1.5.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <paolo.bonzini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36623
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pbonzini@redhat.com
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

Il 19/05/2013 07:47, Sanjay Lal ha scritto:
> Signed-off-by: Sanjay Lal <sanjayl@kymasys.com>
> ---
>  arch/mips/include/asm/kvm_host.h | 244 ++++++++++++++++++++++++++++++---------
>  1 file changed, 191 insertions(+), 53 deletions(-)
> 
> diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
> index e68781e..c92e297 100644
> --- a/arch/mips/include/asm/kvm_host.h
> +++ b/arch/mips/include/asm/kvm_host.h
> @@ -19,21 +19,28 @@
>  #include <linux/threads.h>
>  #include <linux/spinlock.h>
>  
> +#ifdef CONFIG_KVM_MIPS_VZ
> +#include <asm/mipsvzregs.h>
> +#endif

No need to make the inclusion conditional.

>  
> -#define KVM_MAX_VCPUS		1
> -#define KVM_USER_MEM_SLOTS	8
> +#define KVM_MAX_VCPUS 8
> +#define KVM_USER_MEM_SLOTS 8
>  /* memory slots that does not exposed to userspace */
> -#define KVM_PRIVATE_MEM_SLOTS 	0
> +#define KVM_PRIVATE_MEM_SLOTS 0
>  
>  #define KVM_COALESCED_MMIO_PAGE_OFFSET 1
>  
>  /* Don't support huge pages */
> -#define KVM_HPAGE_GFN_SHIFT(x)	0
> +#define KVM_HPAGE_GFN_SHIFT(x)  0
>  
>  /* We don't currently support large pages. */
>  #define KVM_NR_PAGE_SIZES	1
> -#define KVM_PAGES_PER_HPAGE(x)	1
> +#define KVM_PAGES_PER_HPAGE(x)  1
>  
> +#ifdef CONFIG_KVM_MIPS_VZ
> +#define KVM_VZROOTID		(GUESTCTL1_VZ_ROOT_GUESTID)
> +#define KVM_VZGUESTID_MASK	(GUESTCTL1_ID)
> +#endif

Any reason to not use the GUESTCTL1_* macros directly?

>  
>  
>  /* Special address that contains the comm page, used for reducing # of traps */
> @@ -42,11 +49,20 @@
>  #define KVM_GUEST_KERNEL_MODE(vcpu)	((kvm_read_c0_guest_status(vcpu->arch.cop0) & (ST0_EXL | ST0_ERL)) || \
>  					((kvm_read_c0_guest_status(vcpu->arch.cop0) & KSU_USER) == 0))
>  
> +#ifdef CONFIG_KVM_MIPS_VZ
> +#define KVM_GUEST_KUSEG             0x00000000UL
> +#define KVM_GUEST_KSEG0             0x80000000UL
> +#define KVM_GUEST_KSEG1             0xa0000000UL
> +#define KVM_GUEST_KSEG23            0xc0000000UL
> +#define KVM_GUEST_KSEGX(a)          ((_ACAST32_(a)) & 0xe0000000)
> +#define KVM_GUEST_CPHYSADDR(a)      ((_ACAST32_(a)) & 0x1fffffff)
> +#else
>  #define KVM_GUEST_KUSEG             0x00000000UL
>  #define KVM_GUEST_KSEG0             0x40000000UL
>  #define KVM_GUEST_KSEG23            0x60000000UL
>  #define KVM_GUEST_KSEGX(a)          ((_ACAST32_(a)) & 0x60000000)
>  #define KVM_GUEST_CPHYSADDR(a)      ((_ACAST32_(a)) & 0x1fffffff)
> +#endif
>  
>  #define KVM_GUEST_CKSEG0ADDR(a)		(KVM_GUEST_CPHYSADDR(a) | KVM_GUEST_KSEG0)
>  #define KVM_GUEST_CKSEG1ADDR(a)		(KVM_GUEST_CPHYSADDR(a) | KVM_GUEST_KSEG1)
> @@ -100,6 +116,21 @@ struct kvm_vcpu_stat {
>  	u32 resvd_inst_exits;
>  	u32 break_inst_exits;
>  	u32 flush_dcache_exits;
> +#ifdef CONFIG_KVM_MIPS_VZ
> +	u32 hypervisor_gpsi_exits;
> +	u32 hypervisor_gpsi_cp0_exits;
> +	u32 hypervisor_gpsi_cache_exits;
> +	u32 hypervisor_gsfc_exits;
> +	u32 hypervisor_gsfc_cp0_status_exits;
> +	u32 hypervisor_gsfc_cp0_cause_exits;
> +	u32 hypervisor_gsfc_cp0_intctl_exits;
> +	u32 hypervisor_hc_exits;
> +	u32 hypervisor_grr_exits;
> +	u32 hypervisor_gva_exits;
> +	u32 hypervisor_ghfc_exits;
> +	u32 hypervisor_gpa_exits;
> +	u32 hypervisor_resv_exits;
> +#endif
>  	u32 halt_wakeup;
>  };
>  
> @@ -118,6 +149,21 @@ enum kvm_mips_exit_types {
>  	RESVD_INST_EXITS,
>  	BREAK_INST_EXITS,
>  	FLUSH_DCACHE_EXITS,
> +#ifdef CONFIG_KVM_MIPS_VZ
> +	HYPERVISOR_GPSI_EXITS,
> +	HYPERVISOR_GPSI_CP0_EXITS,
> +	HYPERVISOR_GPSI_CACHE_EXITS,
> +	HYPERVISOR_GSFC_EXITS,
> +	HYPERVISOR_GSFC_CP0_STATUS_EXITS,
> +	HYPERVISOR_GSFC_CP0_CAUSE_EXITS,
> +	HYPERVISOR_GSFC_CP0_INTCTL_EXITS,
> +	HYPERVISOR_HC_EXITS,
> +	HYPERVISOR_GRR_EXITS,
> +	HYPERVISOR_GVA_EXITS,
> +	HYPERVISOR_GHFC_EXITS,
> +	HYPERVISOR_GPA_EXITS,
> +	HYPERVISOR_RESV_EXITS,
> +#endif
>  	MAX_KVM_MIPS_EXIT_TYPES
>  };
>  
> @@ -126,8 +172,8 @@ struct kvm_arch_memory_slot {
>  
>  struct kvm_arch {
>  	/* Guest GVA->HPA page table */
> -	unsigned long *guest_pmap;
> -	unsigned long guest_pmap_npages;
> +	ulong *guest_pmap;
> +	ulong guest_pmap_npages;

Please make this search-and-replace a separate patch.

>  
>  	/* Wired host TLB used for the commpage */
>  	int commpage_tlb;
> @@ -137,9 +183,9 @@ struct kvm_arch {
>  #define N_MIPS_COPROC_SEL   	8
>  
>  struct mips_coproc {
> -	unsigned long reg[N_MIPS_COPROC_REGS][N_MIPS_COPROC_SEL];
> +	ulong reg[N_MIPS_COPROC_REGS][N_MIPS_COPROC_SEL];
>  #ifdef CONFIG_KVM_MIPS_DEBUG_COP0_COUNTERS
> -	unsigned long stat[N_MIPS_COPROC_REGS][N_MIPS_COPROC_SEL];
> +	ulong stat[N_MIPS_COPROC_REGS][N_MIPS_COPROC_SEL];
>  #endif
>  };
>  
> @@ -294,6 +340,9 @@ enum mips_mmu_types {
>  #define T_RES_INST      10	/* Reserved instruction exception */
>  #define T_COP_UNUSABLE      11	/* Coprocessor unusable */
>  #define T_OVFLOW        12	/* Arithmetic overflow */
> +#ifdef CONFIG_KVM_MIPS_VZ
> +#define T_GUEST_EXIT        27	/* Guest Exit (VZ ASE) */
> +#endif

Also doesn't need to be conditional, does it?

Even in the implementation, I would prefer to have no ifdefs like

#ifdef CONFIG_KVM_MIPS_VZ
	case T_GUEST_EXIT:
		/* defer exit accounting to handler */
		ret = kvm_mips_callbacks->handle_guest_exit(vcpu);
		break;

#endif

in generic code.

>  
>  /*
>   * Trap definitions added for r4000 port.
> @@ -336,7 +385,7 @@ enum emulation_result {
>  #define VPN2_MASK           0xffffe000
>  #define TLB_IS_GLOBAL(x)    (((x).tlb_lo0 & MIPS3_PG_G) && ((x).tlb_lo1 & MIPS3_PG_G))
>  #define TLB_VPN2(x)         ((x).tlb_hi & VPN2_MASK)
> -#define TLB_ASID(x)         (ASID_MASK((x).tlb_hi))
> +#define TLB_ASID(x)         ((x).tlb_hi & ASID_MASK)
>  #define TLB_IS_VALID(x, va) (((va) & (1 << PAGE_SHIFT)) ? ((x).tlb_lo1 & MIPS3_PG_V) : ((x).tlb_lo0 & MIPS3_PG_V))
>  
>  struct kvm_mips_tlb {
> @@ -344,26 +393,29 @@ struct kvm_mips_tlb {
>  	long tlb_hi;
>  	long tlb_lo0;
>  	long tlb_lo1;
> +#ifdef CONFIG_KVM_MIPS_VZ
> +	uint32_t guestctl1;
> +#endif
>  };
>  
>  #define KVM_MIPS_GUEST_TLB_SIZE     64
>  struct kvm_vcpu_arch {
>  	void *host_ebase, *guest_ebase;
> -	unsigned long host_stack;
> -	unsigned long host_gp;
> +	ulong host_stack;
> +	ulong host_gp;
>  
>  	/* Host CP0 registers used when handling exits from guest */
> -	unsigned long host_cp0_badvaddr;
> -	unsigned long host_cp0_cause;
> -	unsigned long host_cp0_epc;
> -	unsigned long host_cp0_entryhi;
> +	ulong host_cp0_badvaddr;
> +	ulong host_cp0_cause;
> +	ulong host_cp0_epc;
> +	ulong host_cp0_entryhi;
>  	uint32_t guest_inst;
>  
>  	/* GPRS */
> -	unsigned long gprs[32];
> -	unsigned long hi;
> -	unsigned long lo;
> -	unsigned long pc;
> +	ulong gprs[32];
> +	ulong hi;
> +	ulong lo;
> +	ulong pc;
>  
>  	/* FPU State */
>  	struct mips_fpu_struct fpu;
> @@ -380,15 +432,12 @@ struct kvm_vcpu_arch {
>  	int32_t host_cp0_count;
>  
>  	/* Bitmask of exceptions that are pending */
> -	unsigned long pending_exceptions;
> +	ulong pending_exceptions;
>  
>  	/* Bitmask of pending exceptions to be cleared */
> -	unsigned long pending_exceptions_clr;
> +	ulong pending_exceptions_clr;
>  
> -	unsigned long pending_load_cause;
> -
> -	/* Save/Restore the entryhi register when are are preempted/scheduled back in */
> -	unsigned long preempt_entryhi;
> +	ulong pending_load_cause;
>  
>  	/* S/W Based TLB for guest */
>  	struct kvm_mips_tlb guest_tlb[KVM_MIPS_GUEST_TLB_SIZE];
> @@ -400,6 +449,13 @@ struct kvm_vcpu_arch {
>  
>  	struct kvm_mips_tlb shadow_tlb[NR_CPUS][KVM_MIPS_GUEST_TLB_SIZE];
>  
> +#ifdef CONFIG_KVM_MIPS_VZ
> +	/* vcpu's vzguestid is different on each host cpu in an smp system */
> +	uint32_t vzguestid[NR_CPUS];
> +
> +	/* storage for saved guest CP0 registers */
> +	struct kvm_regs guest_regs;
> +#endif
>  
>  	struct hrtimer comparecount_timer;
>  
> @@ -409,6 +465,74 @@ struct kvm_vcpu_arch {
>  	int wait;
>  };
>  
> +#ifdef CONFIG_KVM_MIPS_VZ
> +
> +#define kvm_read_c0_guest_index(cop0)                ((void)cop0, read_c0_guest_index())

Parentheses around cop0.

> +#define kvm_write_c0_guest_index(cop0, val)          ((void)cop0, write_c0_guest_index(val))
> +#define kvm_read_c0_guest_random(cop0)               ((void)cop0, read_c0_guest_random())
> +#define kvm_read_c0_guest_entrylo0(cop0)             ((void)cop0, read_c0_guest_entrylo0())
> +#define kvm_write_c0_guest_entrylo0(cop0, val)       ((void)cop0, write_c0_guest_entrylo0(val))
> +#define kvm_read_c0_guest_entrylo1(cop0)             ((void)cop0, read_c0_guest_entrylo1())
> +#define kvm_write_c0_guest_entrylo1(cop0, val)       ((void)cop0, write_c0_guest_entrylo1(val))
> +#define kvm_read_c0_guest_context(cop0)              ((void)cop0, read_c0_guest_context())
> +#define kvm_write_c0_guest_context(cop0, val)        ((void)cop0, write_c0_guest_context(val))
> +#define kvm_read_c0_guest_userlocal(cop0)            ((void)cop0, read_c0_guest_userlocal())
> +#define kvm_write_c0_guest_userlocal(cop0, val)      ((void)cop0, write_c0_guest_userlocal(val))
> +#define kvm_read_c0_guest_pagemask(cop0)             ((void)cop0, read_c0_guest_pagemask())
> +#define kvm_write_c0_guest_pagemask(cop0, val)       ((void)cop0, write_c0_guest_pagemask(val))
> +#define kvm_read_c0_guest_pagegrain(cop0)            ((void)cop0, read_c0_guest_pagegrain())
> +#define kvm_write_c0_guest_pagegrain(cop0, val)      ((void)cop0, write_c0_guest_pagegrain(val))
> +#define kvm_read_c0_guest_wired(cop0)                ((void)cop0, read_c0_guest_wired())
> +#define kvm_write_c0_guest_wired(cop0, val)          ((void)cop0, write_c0_guest_wired(val))
> +#define kvm_read_c0_guest_hwrena(cop0)               ((void)cop0, read_c0_guest_hwrena())
> +#define kvm_write_c0_guest_hwrena(cop0, val)         ((void)cop0, write_c0_guest_hwrena(val))
> +#define kvm_read_c0_guest_badvaddr(cop0)             ((void)cop0, read_c0_guest_badvaddr())
> +#define kvm_write_c0_guest_badvaddr(cop0, val)       ((void)cop0, write_c0_guest_badvaddr(val))
> +#define kvm_read_c0_guest_count(cop0)                ((void)cop0, read_c0_guest_count())
> +#define kvm_write_c0_guest_count(cop0, val)          ((void)cop0, write_c0_guest_count(val))
> +#define kvm_read_c0_guest_entryhi(cop0)              ((void)cop0, read_c0_guest_entryhi())
> +#define kvm_write_c0_guest_entryhi(cop0, val)        ((void)cop0, write_c0_guest_entryhi(val))
> +#define kvm_read_c0_guest_compare(cop0)              ((void)cop0, read_c0_guest_compare())
> +#define kvm_write_c0_guest_compare(cop0, val)        ((void)cop0, write_c0_guest_compare(val))
> +#define kvm_read_c0_guest_status(cop0)               ((void)cop0, read_c0_guest_status())
> +#define kvm_write_c0_guest_status(cop0, val)         ((void)cop0, write_c0_guest_status(val))
> +#define kvm_read_c0_guest_intctl(cop0)               ((void)cop0, read_c0_guest_intctl())
> +#define kvm_write_c0_guest_intctl(cop0, val)         ((void)cop0, write_c0_guest_intctl(val))
> +#define kvm_read_c0_guest_cause(cop0)                ((void)cop0, read_c0_guest_cause())
> +#define kvm_write_c0_guest_cause(cop0, val)          ((void)cop0, write_c0_guest_cause(val))
> +#define kvm_read_c0_guest_epc(cop0)                  ((void)cop0, read_c0_guest_epc())
> +#define kvm_write_c0_guest_epc(cop0, val)            ((void)cop0, write_c0_guest_epc(val))
> +#define kvm_read_c0_guest_prid(cop0)                 (cop0->reg[MIPS_CP0_PRID][0])
> +#define kvm_write_c0_guest_prid(cop0, val)           (cop0->reg[MIPS_CP0_PRID][0] = (val))
> +#define kvm_read_c0_guest_ebase(cop0)                ((void)cop0, read_c0_guest_ebase())
> +#define kvm_write_c0_guest_ebase(cop0, val)          ((void)cop0, write_c0_guest_ebase(val))
> +#define kvm_read_c0_guest_config(cop0)               ((void)cop0, read_c0_guest_config())
> +#define kvm_read_c0_guest_config1(cop0)              ((void)cop0, read_c0_guest_config1())
> +#define kvm_read_c0_guest_config2(cop0)              ((void)cop0, read_c0_guest_config2())
> +#define kvm_read_c0_guest_config3(cop0)              ((void)cop0, read_c0_guest_config3())
> +#define kvm_read_c0_guest_config4(cop0)              ((void)cop0, read_c0_guest_config4())
> +#define kvm_read_c0_guest_config5(cop0)              ((void)cop0, read_c0_guest_config5())
> +#define kvm_read_c0_guest_config6(cop0)              ((void)cop0, read_c0_guest_config6())
> +#define kvm_read_c0_guest_config7(cop0)              ((void)cop0, read_c0_guest_config7())
> +#define kvm_write_c0_guest_config(cop0, val)         ((void)cop0, write_c0_guest_config(val))
> +#define kvm_write_c0_guest_config1(cop0, val)        ((void)cop0, write_c0_guest_config1(val))
> +#define kvm_write_c0_guest_config2(cop0, val)        ((void)cop0, write_c0_guest_config2(val))
> +#define kvm_write_c0_guest_config3(cop0, val)        ((void)cop0, write_c0_guest_config3(val))
> +#define kvm_write_c0_guest_config4(cop0, val)        ((void)cop0, write_c0_guest_config4(val))
> +#define kvm_write_c0_guest_config5(cop0, val)        ((void)cop0, write_c0_guest_config5(val))
> +#define kvm_write_c0_guest_config6(cop0, val)        ((void)cop0, write_c0_guest_config6(val))
> +#define kvm_write_c0_guest_config7(cop0, val)        ((void)cop0, write_c0_guest_config7(val))
> +#define kvm_read_c0_guest_errorepc(cop0)             ((void)cop0, read_c0_guest_errorepc())
> +#define kvm_write_c0_guest_errorepc(cop0, val)       ((void)cop0, write_c0_guest_errorepc(val))
> +
> +#define kvm_set_c0_guest_status(cop0, val)           ((void)cop0, set_c0_guest_status(val))
> +#define kvm_clear_c0_guest_status(cop0, val)         ((void)cop0, clear_c0_guest_status(val))
> +#define kvm_set_c0_guest_cause(cop0, val)            ((void)cop0, set_c0_guest_cause(val))
> +#define kvm_clear_c0_guest_cause(cop0, val)          ((void)cop0, clear_c0_guest_cause(val))
> +#define kvm_change_c0_guest_cause(cop0, change, val) ((void)cop0, change_c0_guest_cause(change, val))
> +#define kvm_change_c0_guest_ebase(cop0, change, val) ((void)cop0, change_c0_guest_ebase(change, val))
> +
> +#else
>  
>  #define kvm_read_c0_guest_index(cop0)               (cop0->reg[MIPS_CP0_TLB_INDEX][0])
>  #define kvm_write_c0_guest_index(cop0, val)         (cop0->reg[MIPS_CP0_TLB_INDEX][0] = val)
> @@ -471,6 +595,7 @@ struct kvm_vcpu_arch {
>      kvm_set_c0_guest_ebase(cop0, ((val) & (change))); \
>  }
>  
> +#endif
>  
>  struct kvm_mips_callbacks {
>  	int (*handle_cop_unusable) (struct kvm_vcpu *vcpu);
> @@ -482,6 +607,9 @@ struct kvm_mips_callbacks {
>  	int (*handle_syscall) (struct kvm_vcpu *vcpu);
>  	int (*handle_res_inst) (struct kvm_vcpu *vcpu);
>  	int (*handle_break) (struct kvm_vcpu *vcpu);
> +#ifdef CONFIG_KVM_MIPS_VZ
> +	int (*handle_guest_exit) (struct kvm_vcpu *vcpu);
> +#endif

No need to make it conditional.  Ideally, you could choose both modes
available independently, so that a kernel with both VZ and
trap-and-emulate could be built.  Can the trap-and-emulate kernels run
under VZ?

Otherwise, there's hardly any point in having the callbacks in the first
place.

>  	int (*vm_init) (struct kvm *kvm);
>  	int (*vcpu_init) (struct kvm_vcpu *vcpu);
>  	int (*vcpu_setup) (struct kvm_vcpu *vcpu);
> @@ -517,23 +645,26 @@ uint32_t kvm_get_user_asid(struct kvm_vcpu *vcpu);
>  
>  uint32_t kvm_get_commpage_asid (struct kvm_vcpu *vcpu);
>  
> -extern int kvm_mips_handle_kseg0_tlb_fault(unsigned long badbaddr,
> +#ifdef CONFIG_KVM_MIPS_VZ
> +extern int kvm_mips_handle_vz_root_tlb_fault(ulong badvaddr,
> +					     struct kvm_vcpu *vcpu);
> +#endif

kvm_tlb.c has many parts that, after this patch, are BUG_ON(!cpu_has_vz)'d.

Perhaps you could split it into kvm_tlb.c, kvm_tlb_emul.c, kvm_tlb_vz.c?

Then these functions can also be in a separate header, rather than being
#ifdef'ed in this one.

This raises a related question: how much of kvm_mips_emul.c is reused
under VZ?  In x86, you can trigger emulation of any instruction by
"racing" the emulator: one VCPU triggers emulation of an instruction
that has to be emulated, the second rewrites it to another one on the
fly.  Another way to do the same is to make the iTLB and dTLB point to
different pages (load from the address of the instruction, change the
page table, execute the instruction; then the emulator will use the
entry from the dTLB).

Would it be possible to "trick" KVM into executing unwanted branches of
kvm_mips_emul.c by these tricks?  If so, the best thing would be to just
reenter the guest and retry executing the same instruction.  But a
BUG_ON() is definitely wrong, because it will crash the host.

Paolo

> +extern int kvm_mips_handle_kseg0_tlb_fault(ulong badbaddr,
>  					   struct kvm_vcpu *vcpu);
>  
> -extern int kvm_mips_handle_commpage_tlb_fault(unsigned long badvaddr,
> +extern int kvm_mips_handle_commpage_tlb_fault(ulong badvaddr,
>  					      struct kvm_vcpu *vcpu);
>  
>  extern int kvm_mips_handle_mapped_seg_tlb_fault(struct kvm_vcpu *vcpu,
>  						struct kvm_mips_tlb *tlb,
> -						unsigned long *hpa0,
> -						unsigned long *hpa1);
> +						ulong *hpa0, ulong *hpa1);
>  
> -extern enum emulation_result kvm_mips_handle_tlbmiss(unsigned long cause,
> +extern enum emulation_result kvm_mips_handle_tlbmiss(ulong cause,
>  						     uint32_t *opc,
>  						     struct kvm_run *run,
>  						     struct kvm_vcpu *vcpu);
>  
> -extern enum emulation_result kvm_mips_handle_tlbmod(unsigned long cause,
> +extern enum emulation_result kvm_mips_handle_tlbmod(ulong cause,
>  						    uint32_t *opc,
>  						    struct kvm_run *run,
>  						    struct kvm_vcpu *vcpu);
> @@ -542,14 +673,13 @@ extern void kvm_mips_dump_host_tlbs(void);
>  extern void kvm_mips_dump_guest_tlbs(struct kvm_vcpu *vcpu);
>  extern void kvm_mips_dump_shadow_tlbs(struct kvm_vcpu *vcpu);
>  extern void kvm_mips_flush_host_tlb(int skip_kseg0);
> -extern int kvm_mips_host_tlb_inv(struct kvm_vcpu *vcpu, unsigned long entryhi);
> +extern int kvm_mips_host_tlb_inv(struct kvm_vcpu *vcpu, ulong entryhi);
>  extern int kvm_mips_host_tlb_inv_index(struct kvm_vcpu *vcpu, int index);
>  
> -extern int kvm_mips_guest_tlb_lookup(struct kvm_vcpu *vcpu,
> -				     unsigned long entryhi);
> -extern int kvm_mips_host_tlb_lookup(struct kvm_vcpu *vcpu, unsigned long vaddr);
> -extern unsigned long kvm_mips_translate_guest_kseg0_to_hpa(struct kvm_vcpu *vcpu,
> -						   unsigned long gva);
> +extern int kvm_mips_guest_tlb_lookup(struct kvm_vcpu *vcpu, ulong entryhi);
> +extern int kvm_mips_host_tlb_lookup(struct kvm_vcpu *vcpu, ulong vaddr);
> +extern ulong kvm_mips_translate_guest_kseg0_to_hpa(struct kvm_vcpu *vcpu,
> +						   ulong gva);
>  extern void kvm_get_new_mmu_context(struct mm_struct *mm, unsigned long cpu,
>  				    struct kvm_vcpu *vcpu);
>  extern void kvm_shadow_tlb_put(struct kvm_vcpu *vcpu);
> @@ -564,57 +694,57 @@ extern void kvm_mips_vcpu_put(struct kvm_vcpu *vcpu);
>  uint32_t kvm_get_inst(uint32_t *opc, struct kvm_vcpu *vcpu);
>  enum emulation_result update_pc(struct kvm_vcpu *vcpu, uint32_t cause);
>  
> -extern enum emulation_result kvm_mips_emulate_inst(unsigned long cause,
> +extern enum emulation_result kvm_mips_emulate_inst(ulong cause,
>  						   uint32_t *opc,
>  						   struct kvm_run *run,
>  						   struct kvm_vcpu *vcpu);
>  
> -extern enum emulation_result kvm_mips_emulate_syscall(unsigned long cause,
> +extern enum emulation_result kvm_mips_emulate_syscall(ulong cause,
>  						      uint32_t *opc,
>  						      struct kvm_run *run,
>  						      struct kvm_vcpu *vcpu);
>  
> -extern enum emulation_result kvm_mips_emulate_tlbmiss_ld(unsigned long cause,
> +extern enum emulation_result kvm_mips_emulate_tlbmiss_ld(ulong cause,
>  							 uint32_t *opc,
>  							 struct kvm_run *run,
>  							 struct kvm_vcpu *vcpu);
>  
> -extern enum emulation_result kvm_mips_emulate_tlbinv_ld(unsigned long cause,
> +extern enum emulation_result kvm_mips_emulate_tlbinv_ld(ulong cause,
>  							uint32_t *opc,
>  							struct kvm_run *run,
>  							struct kvm_vcpu *vcpu);
>  
> -extern enum emulation_result kvm_mips_emulate_tlbmiss_st(unsigned long cause,
> +extern enum emulation_result kvm_mips_emulate_tlbmiss_st(ulong cause,
>  							 uint32_t *opc,
>  							 struct kvm_run *run,
>  							 struct kvm_vcpu *vcpu);
>  
> -extern enum emulation_result kvm_mips_emulate_tlbinv_st(unsigned long cause,
> +extern enum emulation_result kvm_mips_emulate_tlbinv_st(ulong cause,
>  							uint32_t *opc,
>  							struct kvm_run *run,
>  							struct kvm_vcpu *vcpu);
>  
> -extern enum emulation_result kvm_mips_emulate_tlbmod(unsigned long cause,
> +extern enum emulation_result kvm_mips_emulate_tlbmod(ulong cause,
>  						     uint32_t *opc,
>  						     struct kvm_run *run,
>  						     struct kvm_vcpu *vcpu);
>  
> -extern enum emulation_result kvm_mips_emulate_fpu_exc(unsigned long cause,
> +extern enum emulation_result kvm_mips_emulate_fpu_exc(ulong cause,
>  						      uint32_t *opc,
>  						      struct kvm_run *run,
>  						      struct kvm_vcpu *vcpu);
>  
> -extern enum emulation_result kvm_mips_handle_ri(unsigned long cause,
> +extern enum emulation_result kvm_mips_handle_ri(ulong cause,
>  						uint32_t *opc,
>  						struct kvm_run *run,
>  						struct kvm_vcpu *vcpu);
>  
> -extern enum emulation_result kvm_mips_emulate_ri_exc(unsigned long cause,
> +extern enum emulation_result kvm_mips_emulate_ri_exc(ulong cause,
>  						     uint32_t *opc,
>  						     struct kvm_run *run,
>  						     struct kvm_vcpu *vcpu);
>  
> -extern enum emulation_result kvm_mips_emulate_bp_exc(unsigned long cause,
> +extern enum emulation_result kvm_mips_emulate_bp_exc(ulong cause,
>  						     uint32_t *opc,
>  						     struct kvm_run *run,
>  						     struct kvm_vcpu *vcpu);
> @@ -624,7 +754,7 @@ extern enum emulation_result kvm_mips_complete_mmio_load(struct kvm_vcpu *vcpu,
>  
>  enum emulation_result kvm_mips_emulate_count(struct kvm_vcpu *vcpu);
>  
> -enum emulation_result kvm_mips_check_privilege(unsigned long cause,
> +enum emulation_result kvm_mips_check_privilege(ulong cause,
>  					       uint32_t *opc,
>  					       struct kvm_run *run,
>  					       struct kvm_vcpu *vcpu);
> @@ -659,9 +789,17 @@ extern int kvm_mips_trans_mtc0(uint32_t inst, uint32_t *opc,
>  			       struct kvm_vcpu *vcpu);
>  
>  /* Misc */
> -extern void mips32_SyncICache(unsigned long addr, unsigned long size);
> +extern void mips32_SyncICache(ulong addr, ulong size);
>  extern int kvm_mips_dump_stats(struct kvm_vcpu *vcpu);
> -extern unsigned long kvm_mips_get_ramsize(struct kvm *kvm);
> -
> +extern ulong kvm_mips_get_ramsize(struct kvm *kvm);
> +
> +#ifdef CONFIG_KVM_MIPS_VZ
> +/* VZ ASE specific functions */
> +extern void kvm_vz_restore_guest_timer_int(struct kvm_vcpu *vcpu,
> +					   struct kvm_regs *regs);
> +extern void mips32_ClearGuestRID(void);
> +extern void mips32_SetGuestRID(ulong guestRID);
> +extern void mips32_SetGuestRIDtoGuestID(void);
> +#endif
>  
>  #endif /* __MIPS_KVM_HOST_H__ */
> 
