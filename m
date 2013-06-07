Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Jun 2013 01:08:16 +0200 (CEST)
Received: from mail-ie0-f179.google.com ([209.85.223.179]:42530 "EHLO
        mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835162Ab3FGXD4QAPZ3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Jun 2013 01:03:56 +0200
Received: by mail-ie0-f179.google.com with SMTP id c10so3600026ieb.10
        for <multiple recipients>; Fri, 07 Jun 2013 16:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=hiTm4b62tyRsQbWeYceywmYe9AyPSkdvxQeoXxyXGp8=;
        b=cHIfl0arYOMlFF8go308CfO23na+X6FpniUk6CPdjkTX3612onbHPv3t2cxKw88pi/
         yjNuk76BbKdFA43gEPuhJFIxNCmaxhm7lC40nTbaqa18kIHvXBL8FF93iRJnnfHt0Uzm
         JHFp8SopVw91P3QSap7Am0Zlw5lfL3hfsrSY6Ps1Up4sYiamFdsKBIRgsq3iaW/pJdpr
         uXDrSZpvO8ATP3jjGn/OeF10wfQxFw+x+SNIqBP4WOiNw+gWLSkA6jbM8FV/OxYQmQe+
         XWVLIJW1dygDal0RPzW0pXXxCDuJQA7bWzTn70kJ1K4vhO8Xq2n6BMskJu3f+Jcx0uVa
         vlOA==
X-Received: by 10.42.35.75 with SMTP id p11mr393128icd.6.1370646229418;
        Fri, 07 Jun 2013 16:03:49 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id qn10sm172765igc.6.2013.06.07.16.03.47
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 16:03:48 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r57N3j3j006646;
        Fri, 7 Jun 2013 16:03:45 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r57N3jmN006645;
        Fri, 7 Jun 2013 16:03:45 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 09/31] mips/kvm: Factor trap-and-emulate support into a pluggable implementation.
Date:   Fri,  7 Jun 2013 16:03:13 -0700
Message-Id: <1370646215-6543-10-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
References: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36730
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

From: David Daney <david.daney@cavium.com>

Many of the arch entry points now dispatch through an ops vector.
This will allow alternate implementations based on the MIPSVZ hardware
support to be added.

There is no substantive code change here, just moving things around.
The biggest change is that the implementation specific data needed by
the vcpu and kvm is held in separate structures, pointed to by
vcpu->arch.impl and kvm->arch.impl, minor changes to the assembly code
was made to traverse these pointers.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/kvm_host.h    | 610 ++----------------------
 arch/mips/include/asm/kvm_mips_te.h | 589 +++++++++++++++++++++++
 arch/mips/kernel/asm-offsets.c      | 100 ++--
 arch/mips/kvm/kvm_locore.S          |  47 +-
 arch/mips/kvm/kvm_mips.c            | 709 ++--------------------------
 arch/mips/kvm/kvm_mips_comm.h       |   1 +
 arch/mips/kvm/kvm_mips_commpage.c   |   9 +-
 arch/mips/kvm/kvm_mips_emul.c       | 172 ++++---
 arch/mips/kvm/kvm_mips_int.c        |  45 +-
 arch/mips/kvm/kvm_mips_int.h        |   2 -
 arch/mips/kvm/kvm_mips_stats.c      |   6 +-
 arch/mips/kvm/kvm_tlb.c             | 138 +++---
 arch/mips/kvm/kvm_trap_emul.c       | 912 ++++++++++++++++++++++++++++++++++--
 13 files changed, 1807 insertions(+), 1533 deletions(-)
 create mode 100644 arch/mips/include/asm/kvm_mips_te.h

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index d9ee320..16013c7 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -35,51 +35,9 @@
 #define KVM_PAGES_PER_HPAGE(x)	1
 
 
-
-/* Special address that contains the comm page, used for reducing # of traps */
-#define KVM_GUEST_COMMPAGE_ADDR     0x0
-
-#define KVM_GUEST_KERNEL_MODE(vcpu)	((kvm_read_c0_guest_status(vcpu->arch.cop0) & (ST0_EXL | ST0_ERL)) || \
-					((kvm_read_c0_guest_status(vcpu->arch.cop0) & KSU_USER) == 0))
-
-#define KVM_GUEST_KUSEG             0x00000000UL
-#define KVM_GUEST_KSEG0             0x40000000UL
-#define KVM_GUEST_KSEG23            0x60000000UL
-#define KVM_GUEST_KSEGX(a)          ((_ACAST32_(a)) & 0x60000000)
-#define KVM_GUEST_CPHYSADDR(a)      ((_ACAST32_(a)) & 0x1fffffff)
-
-#define KVM_GUEST_CKSEG0ADDR(a)		(KVM_GUEST_CPHYSADDR(a) | KVM_GUEST_KSEG0)
-#define KVM_GUEST_CKSEG1ADDR(a)		(KVM_GUEST_CPHYSADDR(a) | KVM_GUEST_KSEG1)
-#define KVM_GUEST_CKSEG23ADDR(a)	(KVM_GUEST_CPHYSADDR(a) | KVM_GUEST_KSEG23)
-
-/*
- * Map an address to a certain kernel segment
- */
-#define KVM_GUEST_KSEG0ADDR(a)		(KVM_GUEST_CPHYSADDR(a) | KVM_GUEST_KSEG0)
-#define KVM_GUEST_KSEG1ADDR(a)		(KVM_GUEST_CPHYSADDR(a) | KVM_GUEST_KSEG1)
-#define KVM_GUEST_KSEG23ADDR(a)		(KVM_GUEST_CPHYSADDR(a) | KVM_GUEST_KSEG23)
-
-#define KVM_INVALID_PAGE            0xdeadbeef
-#define KVM_INVALID_INST            0xdeadbeef
-#define KVM_INVALID_ADDR            0xdeadbeef
-
-#define KVM_MALTA_GUEST_RTC_ADDR    0xb8000070UL
-
-#define GUEST_TICKS_PER_JIFFY (40000000/HZ)
-#define MS_TO_NS(x) (x * 1E6L)
-
-#define CAUSEB_DC       27
-#define CAUSEF_DC       (_ULCAST_(1)   << 27)
-
 struct kvm;
-struct kvm_run;
 struct kvm_vcpu;
-struct kvm_interrupt;
-
-extern atomic_t kvm_mips_instance;
-extern pfn_t(*kvm_mips_gfn_to_pfn) (struct kvm *kvm, gfn_t gfn);
-extern void (*kvm_mips_release_pfn_clean) (pfn_t pfn);
-extern bool(*kvm_mips_is_error_pfn) (pfn_t pfn);
+enum kvm_mr_change;
 
 struct kvm_vm_stat {
 	u32 remote_tlb_flush;
@@ -103,561 +61,49 @@ struct kvm_vcpu_stat {
 	u32 halt_wakeup;
 };
 
-enum kvm_mips_exit_types {
-	WAIT_EXITS,
-	CACHE_EXITS,
-	SIGNAL_EXITS,
-	INT_EXITS,
-	COP_UNUSABLE_EXITS,
-	TLBMOD_EXITS,
-	TLBMISS_LD_EXITS,
-	TLBMISS_ST_EXITS,
-	ADDRERR_ST_EXITS,
-	ADDRERR_LD_EXITS,
-	SYSCALL_EXITS,
-	RESVD_INST_EXITS,
-	BREAK_INST_EXITS,
-	FLUSH_DCACHE_EXITS,
-	MAX_KVM_MIPS_EXIT_TYPES
-};
-
 struct kvm_arch_memory_slot {
 };
 
-struct kvm_arch {
-	/* Guest GVA->HPA page table */
-	unsigned long *guest_pmap;
-	unsigned long guest_pmap_npages;
-
-	/* Wired host TLB used for the commpage */
-	int commpage_tlb;
-};
-
-#define N_MIPS_COPROC_REGS      32
-#define N_MIPS_COPROC_SEL   	8
-
-struct mips_coproc {
-	unsigned long reg[N_MIPS_COPROC_REGS][N_MIPS_COPROC_SEL];
-#ifdef CONFIG_KVM_MIPS_DEBUG_COP0_COUNTERS
-	unsigned long stat[N_MIPS_COPROC_REGS][N_MIPS_COPROC_SEL];
-#endif
+struct kvm_mips_ops {
+	int (*vcpu_runnable)(struct kvm_vcpu *vcpu);
+	void (*free_vcpus)(struct kvm *kvm);
+	void (*destroy_vm)(struct kvm *kvm);
+	void (*commit_memory_region)(struct kvm *kvm,
+				     struct kvm_userspace_memory_region *mem,
+				     const struct kvm_memory_slot *old,
+				     enum kvm_mr_change change);
+	struct kvm_vcpu *(*vcpu_create)(struct kvm *kvm, unsigned int id);
+	void (*vcpu_free)(struct kvm_vcpu *vcpu);
+	int (*vcpu_run)(struct kvm_vcpu *vcpu, struct kvm_run *run);
+	long (*vm_ioctl)(struct kvm *kvm, unsigned int ioctl,
+			 unsigned long arg);
+	long (*vcpu_ioctl)(struct kvm_vcpu *vcpu, unsigned int ioctl,
+			   unsigned long arg);
+	int (*get_reg)(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
+	int (*set_reg)(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg,
+		       u64 v);
+	int (*cpu_has_pending_timer)(struct kvm_vcpu *vcpu);
+	int (*vcpu_init)(struct kvm_vcpu *vcpu);
+	int (*vcpu_setup)(struct kvm_vcpu *vcpu);
+	void (*vcpu_load)(struct kvm_vcpu *vcpu, int cpu);
+	void (*vcpu_put)(struct kvm_vcpu *vcpu);
 };
 
-/*
- * Coprocessor 0 register names
- */
-#define	MIPS_CP0_TLB_INDEX	    0
-#define	MIPS_CP0_TLB_RANDOM	    1
-#define	MIPS_CP0_TLB_LOW	    2
-#define	MIPS_CP0_TLB_LO0	    2
-#define	MIPS_CP0_TLB_LO1	    3
-#define	MIPS_CP0_TLB_CONTEXT	4
-#define	MIPS_CP0_TLB_PG_MASK	5
-#define	MIPS_CP0_TLB_WIRED	    6
-#define	MIPS_CP0_HWRENA 	    7
-#define	MIPS_CP0_BAD_VADDR	    8
-#define	MIPS_CP0_COUNT	        9
-#define	MIPS_CP0_TLB_HI	        10
-#define	MIPS_CP0_COMPARE	    11
-#define	MIPS_CP0_STATUS	        12
-#define	MIPS_CP0_CAUSE	        13
-#define	MIPS_CP0_EXC_PC	        14
-#define	MIPS_CP0_PRID		    15
-#define	MIPS_CP0_CONFIG	        16
-#define	MIPS_CP0_LLADDR	        17
-#define	MIPS_CP0_WATCH_LO	    18
-#define	MIPS_CP0_WATCH_HI	    19
-#define	MIPS_CP0_TLB_XCONTEXT   20
-#define	MIPS_CP0_ECC		    26
-#define	MIPS_CP0_CACHE_ERR	    27
-#define	MIPS_CP0_TAG_LO	        28
-#define	MIPS_CP0_TAG_HI	        29
-#define	MIPS_CP0_ERROR_PC	    30
-#define	MIPS_CP0_DEBUG	        23
-#define	MIPS_CP0_DEPC		    24
-#define	MIPS_CP0_PERFCNT	    25
-#define	MIPS_CP0_ERRCTL         26
-#define	MIPS_CP0_DATA_LO	    28
-#define	MIPS_CP0_DATA_HI	    29
-#define	MIPS_CP0_DESAVE	        31
-
-#define MIPS_CP0_CONFIG_SEL	    0
-#define MIPS_CP0_CONFIG1_SEL    1
-#define MIPS_CP0_CONFIG2_SEL    2
-#define MIPS_CP0_CONFIG3_SEL    3
-
-/* Config0 register bits */
-#define CP0C0_M    31
-#define CP0C0_K23  28
-#define CP0C0_KU   25
-#define CP0C0_MDU  20
-#define CP0C0_MM   17
-#define CP0C0_BM   16
-#define CP0C0_BE   15
-#define CP0C0_AT   13
-#define CP0C0_AR   10
-#define CP0C0_MT   7
-#define CP0C0_VI   3
-#define CP0C0_K0   0
-
-/* Config1 register bits */
-#define CP0C1_M    31
-#define CP0C1_MMU  25
-#define CP0C1_IS   22
-#define CP0C1_IL   19
-#define CP0C1_IA   16
-#define CP0C1_DS   13
-#define CP0C1_DL   10
-#define CP0C1_DA   7
-#define CP0C1_C2   6
-#define CP0C1_MD   5
-#define CP0C1_PC   4
-#define CP0C1_WR   3
-#define CP0C1_CA   2
-#define CP0C1_EP   1
-#define CP0C1_FP   0
-
-/* Config2 Register bits */
-#define CP0C2_M    31
-#define CP0C2_TU   28
-#define CP0C2_TS   24
-#define CP0C2_TL   20
-#define CP0C2_TA   16
-#define CP0C2_SU   12
-#define CP0C2_SS   8
-#define CP0C2_SL   4
-#define CP0C2_SA   0
-
-/* Config3 Register bits */
-#define CP0C3_M    31
-#define CP0C3_ISA_ON_EXC 16
-#define CP0C3_ULRI  13
-#define CP0C3_DSPP 10
-#define CP0C3_LPA  7
-#define CP0C3_VEIC 6
-#define CP0C3_VInt 5
-#define CP0C3_SP   4
-#define CP0C3_MT   2
-#define CP0C3_SM   1
-#define CP0C3_TL   0
-
-/* Have config1, Cacheable, noncoherent, write-back, write allocate*/
-#define MIPS_CONFIG0                                              \
-  ((1 << CP0C0_M) | (0x3 << CP0C0_K0))
-
-/* Have config2, no coprocessor2 attached, no MDMX support attached,
-   no performance counters, watch registers present,
-   no code compression, EJTAG present, no FPU, no watch registers */
-#define MIPS_CONFIG1                                              \
-((1 << CP0C1_M) |                                                 \
- (0 << CP0C1_C2) | (0 << CP0C1_MD) | (0 << CP0C1_PC) |            \
- (0 << CP0C1_WR) | (0 << CP0C1_CA) | (1 << CP0C1_EP) |            \
- (0 << CP0C1_FP))
-
-/* Have config3, no tertiary/secondary caches implemented */
-#define MIPS_CONFIG2                                              \
-((1 << CP0C2_M))
-
-/* No config4, no DSP ASE, no large physaddr (PABITS),
-   no external interrupt controller, no vectored interrupts,
-   no 1kb pages, no SmartMIPS ASE, no trace logic */
-#define MIPS_CONFIG3                                              \
-((0 << CP0C3_M) | (0 << CP0C3_DSPP) | (0 << CP0C3_LPA) |          \
- (0 << CP0C3_VEIC) | (0 << CP0C3_VInt) | (0 << CP0C3_SP) |        \
- (0 << CP0C3_SM) | (0 << CP0C3_TL))
-
-/* MMU types, the first four entries have the same layout as the
-   CP0C0_MT field.  */
-enum mips_mmu_types {
-	MMU_TYPE_NONE,
-	MMU_TYPE_R4000,
-	MMU_TYPE_RESERVED,
-	MMU_TYPE_FMT,
-	MMU_TYPE_R3000,
-	MMU_TYPE_R6000,
-	MMU_TYPE_R8000
-};
-
-/*
- * Trap codes
- */
-#define T_INT           0	/* Interrupt pending */
-#define T_TLB_MOD       1	/* TLB modified fault */
-#define T_TLB_LD_MISS       2	/* TLB miss on load or ifetch */
-#define T_TLB_ST_MISS       3	/* TLB miss on a store */
-#define T_ADDR_ERR_LD       4	/* Address error on a load or ifetch */
-#define T_ADDR_ERR_ST       5	/* Address error on a store */
-#define T_BUS_ERR_IFETCH    6	/* Bus error on an ifetch */
-#define T_BUS_ERR_LD_ST     7	/* Bus error on a load or store */
-#define T_SYSCALL       8	/* System call */
-#define T_BREAK         9	/* Breakpoint */
-#define T_RES_INST      10	/* Reserved instruction exception */
-#define T_COP_UNUSABLE      11	/* Coprocessor unusable */
-#define T_OVFLOW        12	/* Arithmetic overflow */
-
-/*
- * Trap definitions added for r4000 port.
- */
-#define T_TRAP          13	/* Trap instruction */
-#define T_VCEI          14	/* Virtual coherency exception */
-#define T_FPE           15	/* Floating point exception */
-#define T_WATCH         23	/* Watch address reference */
-#define T_VCED          31	/* Virtual coherency data */
-
-/* Resume Flags */
-#define RESUME_FLAG_DR          (1<<0)	/* Reload guest nonvolatile state? */
-#define RESUME_FLAG_HOST        (1<<1)	/* Resume host? */
-
-#define RESUME_GUEST            0
-#define RESUME_GUEST_DR         RESUME_FLAG_DR
-#define RESUME_HOST             RESUME_FLAG_HOST
-
-enum emulation_result {
-	EMULATE_DONE,		/* no further processing */
-	EMULATE_DO_MMIO,	/* kvm_run filled with MMIO request */
-	EMULATE_FAIL,		/* can't emulate this instruction */
-	EMULATE_WAIT,		/* WAIT instruction */
-	EMULATE_PRIV_FAIL,
+struct kvm_arch {
+	const struct kvm_mips_ops *ops;
+	void *impl;
 };
 
-#define MIPS3_PG_G  0x00000001	/* Global; ignore ASID if in lo0 & lo1 */
-#define MIPS3_PG_V  0x00000002	/* Valid */
-#define MIPS3_PG_NV 0x00000000
-#define MIPS3_PG_D  0x00000004	/* Dirty */
-
-#define mips3_paddr_to_tlbpfn(x) \
-    (((unsigned long)(x) >> MIPS3_PG_SHIFT) & MIPS3_PG_FRAME)
-#define mips3_tlbpfn_to_paddr(x) \
-    ((unsigned long)((x) & MIPS3_PG_FRAME) << MIPS3_PG_SHIFT)
-
-#define MIPS3_PG_SHIFT      6
-#define MIPS3_PG_FRAME      0x3fffffc0
-
-#define VPN2_MASK           0xffffe000
-#define TLB_IS_GLOBAL(x)    (((x).tlb_lo0 & MIPS3_PG_G) && ((x).tlb_lo1 & MIPS3_PG_G))
-#define TLB_VPN2(x)         ((x).tlb_hi & VPN2_MASK)
-#define TLB_ASID(x)         ((x).tlb_hi & ASID_MASK)
-#define TLB_IS_VALID(x, va) (((va) & (1 << PAGE_SHIFT)) ? ((x).tlb_lo1 & MIPS3_PG_V) : ((x).tlb_lo0 & MIPS3_PG_V))
-
-struct kvm_mips_tlb {
-	long tlb_mask;
-	long tlb_hi;
-	long tlb_lo0;
-	long tlb_lo1;
-};
 
-#define KVM_MIPS_GUEST_TLB_SIZE     64
 struct kvm_vcpu_arch {
-	void *host_ebase, *guest_ebase;
-	unsigned long host_stack;
-	unsigned long host_gp;
-
-	/* Host CP0 registers used when handling exits from guest */
-	unsigned long host_cp0_badvaddr;
-	unsigned long host_cp0_cause;
-	unsigned long host_cp0_epc;
-	unsigned long host_cp0_entryhi;
-	uint32_t guest_inst;
-
 	/* GPRS */
 	unsigned long gprs[32];
 	unsigned long hi;
 	unsigned long lo;
 	unsigned long epc;
 
-	/* FPU State */
-	struct mips_fpu_struct fpu;
-
-	/* COP0 State */
-	struct mips_coproc *cop0;
-
-	/* Host KSEG0 address of the EI/DI offset */
-	void *kseg0_commpage;
-
-	u32 io_gpr;		/* GPR used as IO source/target */
-
-	/* Used to calibrate the virutal count register for the guest */
-	int32_t host_cp0_count;
-
-	/* Bitmask of exceptions that are pending */
-	unsigned long pending_exceptions;
-
-	/* Bitmask of pending exceptions to be cleared */
-	unsigned long pending_exceptions_clr;
-
-	unsigned long pending_load_cause;
-
-	/* Save/Restore the entryhi register when are are preempted/scheduled back in */
-	unsigned long preempt_entryhi;
-
-	/* S/W Based TLB for guest */
-	struct kvm_mips_tlb guest_tlb[KVM_MIPS_GUEST_TLB_SIZE];
-
-	/* Cached guest kernel/user ASIDs */
-	uint32_t guest_user_asid[NR_CPUS];
-	uint32_t guest_kernel_asid[NR_CPUS];
-	struct mm_struct guest_kernel_mm, guest_user_mm;
-
-	struct kvm_mips_tlb shadow_tlb[NR_CPUS][KVM_MIPS_GUEST_TLB_SIZE];
-
-
-	struct hrtimer comparecount_timer;
-
-	int last_sched_cpu;
-
-	/* WAIT executed */
-	int wait;
+	void *impl;
 };
 
 
-#define kvm_read_c0_guest_index(cop0)               (cop0->reg[MIPS_CP0_TLB_INDEX][0])
-#define kvm_write_c0_guest_index(cop0, val)         (cop0->reg[MIPS_CP0_TLB_INDEX][0] = val)
-#define kvm_read_c0_guest_entrylo0(cop0)            (cop0->reg[MIPS_CP0_TLB_LO0][0])
-#define kvm_read_c0_guest_entrylo1(cop0)            (cop0->reg[MIPS_CP0_TLB_LO1][0])
-#define kvm_read_c0_guest_context(cop0)             (cop0->reg[MIPS_CP0_TLB_CONTEXT][0])
-#define kvm_write_c0_guest_context(cop0, val)       (cop0->reg[MIPS_CP0_TLB_CONTEXT][0] = (val))
-#define kvm_read_c0_guest_userlocal(cop0)           (cop0->reg[MIPS_CP0_TLB_CONTEXT][2])
-#define kvm_read_c0_guest_pagemask(cop0)            (cop0->reg[MIPS_CP0_TLB_PG_MASK][0])
-#define kvm_write_c0_guest_pagemask(cop0, val)      (cop0->reg[MIPS_CP0_TLB_PG_MASK][0] = (val))
-#define kvm_read_c0_guest_wired(cop0)               (cop0->reg[MIPS_CP0_TLB_WIRED][0])
-#define kvm_write_c0_guest_wired(cop0, val)         (cop0->reg[MIPS_CP0_TLB_WIRED][0] = (val))
-#define kvm_read_c0_guest_badvaddr(cop0)            (cop0->reg[MIPS_CP0_BAD_VADDR][0])
-#define kvm_write_c0_guest_badvaddr(cop0, val)      (cop0->reg[MIPS_CP0_BAD_VADDR][0] = (val))
-#define kvm_read_c0_guest_count(cop0)               (cop0->reg[MIPS_CP0_COUNT][0])
-#define kvm_write_c0_guest_count(cop0, val)         (cop0->reg[MIPS_CP0_COUNT][0] = (val))
-#define kvm_read_c0_guest_entryhi(cop0)             (cop0->reg[MIPS_CP0_TLB_HI][0])
-#define kvm_write_c0_guest_entryhi(cop0, val)       (cop0->reg[MIPS_CP0_TLB_HI][0] = (val))
-#define kvm_read_c0_guest_compare(cop0)             (cop0->reg[MIPS_CP0_COMPARE][0])
-#define kvm_write_c0_guest_compare(cop0, val)       (cop0->reg[MIPS_CP0_COMPARE][0] = (val))
-#define kvm_read_c0_guest_status(cop0)              (cop0->reg[MIPS_CP0_STATUS][0])
-#define kvm_write_c0_guest_status(cop0, val)        (cop0->reg[MIPS_CP0_STATUS][0] = (val))
-#define kvm_read_c0_guest_intctl(cop0)              (cop0->reg[MIPS_CP0_STATUS][1])
-#define kvm_write_c0_guest_intctl(cop0, val)        (cop0->reg[MIPS_CP0_STATUS][1] = (val))
-#define kvm_read_c0_guest_cause(cop0)               (cop0->reg[MIPS_CP0_CAUSE][0])
-#define kvm_write_c0_guest_cause(cop0, val)         (cop0->reg[MIPS_CP0_CAUSE][0] = (val))
-#define kvm_read_c0_guest_epc(cop0)                 (cop0->reg[MIPS_CP0_EXC_PC][0])
-#define kvm_write_c0_guest_epc(cop0, val)           (cop0->reg[MIPS_CP0_EXC_PC][0] = (val))
-#define kvm_read_c0_guest_prid(cop0)                (cop0->reg[MIPS_CP0_PRID][0])
-#define kvm_write_c0_guest_prid(cop0, val)          (cop0->reg[MIPS_CP0_PRID][0] = (val))
-#define kvm_read_c0_guest_ebase(cop0)               (cop0->reg[MIPS_CP0_PRID][1])
-#define kvm_write_c0_guest_ebase(cop0, val)         (cop0->reg[MIPS_CP0_PRID][1] = (val))
-#define kvm_read_c0_guest_config(cop0)              (cop0->reg[MIPS_CP0_CONFIG][0])
-#define kvm_read_c0_guest_config1(cop0)             (cop0->reg[MIPS_CP0_CONFIG][1])
-#define kvm_read_c0_guest_config2(cop0)             (cop0->reg[MIPS_CP0_CONFIG][2])
-#define kvm_read_c0_guest_config3(cop0)             (cop0->reg[MIPS_CP0_CONFIG][3])
-#define kvm_read_c0_guest_config7(cop0)             (cop0->reg[MIPS_CP0_CONFIG][7])
-#define kvm_write_c0_guest_config(cop0, val)        (cop0->reg[MIPS_CP0_CONFIG][0] = (val))
-#define kvm_write_c0_guest_config1(cop0, val)       (cop0->reg[MIPS_CP0_CONFIG][1] = (val))
-#define kvm_write_c0_guest_config2(cop0, val)       (cop0->reg[MIPS_CP0_CONFIG][2] = (val))
-#define kvm_write_c0_guest_config3(cop0, val)       (cop0->reg[MIPS_CP0_CONFIG][3] = (val))
-#define kvm_write_c0_guest_config7(cop0, val)       (cop0->reg[MIPS_CP0_CONFIG][7] = (val))
-#define kvm_read_c0_guest_errorepc(cop0)            (cop0->reg[MIPS_CP0_ERROR_PC][0])
-#define kvm_write_c0_guest_errorepc(cop0, val)      (cop0->reg[MIPS_CP0_ERROR_PC][0] = (val))
-
-#define kvm_set_c0_guest_status(cop0, val)          (cop0->reg[MIPS_CP0_STATUS][0] |= (val))
-#define kvm_clear_c0_guest_status(cop0, val)        (cop0->reg[MIPS_CP0_STATUS][0] &= ~(val))
-#define kvm_set_c0_guest_cause(cop0, val)           (cop0->reg[MIPS_CP0_CAUSE][0] |= (val))
-#define kvm_clear_c0_guest_cause(cop0, val)         (cop0->reg[MIPS_CP0_CAUSE][0] &= ~(val))
-#define kvm_change_c0_guest_cause(cop0, change, val)  \
-{                                                     \
-    kvm_clear_c0_guest_cause(cop0, change);           \
-    kvm_set_c0_guest_cause(cop0, ((val) & (change))); \
-}
-#define kvm_set_c0_guest_ebase(cop0, val)           (cop0->reg[MIPS_CP0_PRID][1] |= (val))
-#define kvm_clear_c0_guest_ebase(cop0, val)         (cop0->reg[MIPS_CP0_PRID][1] &= ~(val))
-#define kvm_change_c0_guest_ebase(cop0, change, val)  \
-{                                                     \
-    kvm_clear_c0_guest_ebase(cop0, change);           \
-    kvm_set_c0_guest_ebase(cop0, ((val) & (change))); \
-}
-
-
-struct kvm_mips_callbacks {
-	int (*handle_cop_unusable) (struct kvm_vcpu *vcpu);
-	int (*handle_tlb_mod) (struct kvm_vcpu *vcpu);
-	int (*handle_tlb_ld_miss) (struct kvm_vcpu *vcpu);
-	int (*handle_tlb_st_miss) (struct kvm_vcpu *vcpu);
-	int (*handle_addr_err_st) (struct kvm_vcpu *vcpu);
-	int (*handle_addr_err_ld) (struct kvm_vcpu *vcpu);
-	int (*handle_syscall) (struct kvm_vcpu *vcpu);
-	int (*handle_res_inst) (struct kvm_vcpu *vcpu);
-	int (*handle_break) (struct kvm_vcpu *vcpu);
-	int (*vm_init) (struct kvm *kvm);
-	int (*vcpu_init) (struct kvm_vcpu *vcpu);
-	int (*vcpu_setup) (struct kvm_vcpu *vcpu);
-	 gpa_t(*gva_to_gpa) (gva_t gva);
-	void (*queue_timer_int) (struct kvm_vcpu *vcpu);
-	void (*dequeue_timer_int) (struct kvm_vcpu *vcpu);
-	void (*queue_io_int) (struct kvm_vcpu *vcpu,
-			      struct kvm_mips_interrupt *irq);
-	void (*dequeue_io_int) (struct kvm_vcpu *vcpu,
-				struct kvm_mips_interrupt *irq);
-	int (*irq_deliver) (struct kvm_vcpu *vcpu, unsigned int priority,
-			    uint32_t cause);
-	int (*irq_clear) (struct kvm_vcpu *vcpu, unsigned int priority,
-			  uint32_t cause);
-};
-extern struct kvm_mips_callbacks *kvm_mips_callbacks;
-int kvm_mips_emulation_init(struct kvm_mips_callbacks **install_callbacks);
-
-/* Debug: dump vcpu state */
-int kvm_arch_vcpu_dump_regs(struct kvm_vcpu *vcpu);
-
-/* Trampoline ASM routine to start running in "Guest" context */
-extern int __kvm_mips_vcpu_run(struct kvm_run *run, struct kvm_vcpu *vcpu);
-
-/* TLB handling */
-uint32_t kvm_get_kernel_asid(struct kvm_vcpu *vcpu);
-
-uint32_t kvm_get_user_asid(struct kvm_vcpu *vcpu);
-
-uint32_t kvm_get_commpage_asid (struct kvm_vcpu *vcpu);
-
-extern int kvm_mips_handle_kseg0_tlb_fault(unsigned long badbaddr,
-					   struct kvm_vcpu *vcpu);
-
-extern int kvm_mips_handle_commpage_tlb_fault(unsigned long badvaddr,
-					      struct kvm_vcpu *vcpu);
-
-extern int kvm_mips_handle_mapped_seg_tlb_fault(struct kvm_vcpu *vcpu,
-						struct kvm_mips_tlb *tlb,
-						unsigned long *hpa0,
-						unsigned long *hpa1);
-
-extern enum emulation_result kvm_mips_handle_tlbmiss(unsigned long cause,
-						     uint32_t *opc,
-						     struct kvm_run *run,
-						     struct kvm_vcpu *vcpu);
-
-extern enum emulation_result kvm_mips_handle_tlbmod(unsigned long cause,
-						    uint32_t *opc,
-						    struct kvm_run *run,
-						    struct kvm_vcpu *vcpu);
-
-extern void kvm_mips_dump_host_tlbs(void);
-extern void kvm_mips_dump_guest_tlbs(struct kvm_vcpu *vcpu);
-extern void kvm_mips_dump_shadow_tlbs(struct kvm_vcpu *vcpu);
-extern void kvm_mips_flush_host_tlb(int skip_kseg0);
-extern int kvm_mips_host_tlb_inv(struct kvm_vcpu *vcpu, unsigned long entryhi);
-extern int kvm_mips_host_tlb_inv_index(struct kvm_vcpu *vcpu, int index);
-
-extern int kvm_mips_guest_tlb_lookup(struct kvm_vcpu *vcpu,
-				     unsigned long entryhi);
-extern int kvm_mips_host_tlb_lookup(struct kvm_vcpu *vcpu, unsigned long vaddr);
-extern unsigned long kvm_mips_translate_guest_kseg0_to_hpa(struct kvm_vcpu *vcpu,
-						   unsigned long gva);
-extern void kvm_get_new_mmu_context(struct mm_struct *mm, unsigned long cpu,
-				    struct kvm_vcpu *vcpu);
-extern void kvm_shadow_tlb_put(struct kvm_vcpu *vcpu);
-extern void kvm_shadow_tlb_load(struct kvm_vcpu *vcpu);
-extern void kvm_local_flush_tlb_all(void);
-extern void kvm_mips_init_shadow_tlb(struct kvm_vcpu *vcpu);
-extern void kvm_mips_alloc_new_mmu_context(struct kvm_vcpu *vcpu);
-extern void kvm_mips_vcpu_load(struct kvm_vcpu *vcpu, int cpu);
-extern void kvm_mips_vcpu_put(struct kvm_vcpu *vcpu);
-
-/* Emulation */
-uint32_t kvm_get_inst(uint32_t *opc, struct kvm_vcpu *vcpu);
-enum emulation_result update_pc(struct kvm_vcpu *vcpu, uint32_t cause);
-
-extern enum emulation_result kvm_mips_emulate_inst(unsigned long cause,
-						   uint32_t *opc,
-						   struct kvm_run *run,
-						   struct kvm_vcpu *vcpu);
-
-extern enum emulation_result kvm_mips_emulate_syscall(unsigned long cause,
-						      uint32_t *opc,
-						      struct kvm_run *run,
-						      struct kvm_vcpu *vcpu);
-
-extern enum emulation_result kvm_mips_emulate_tlbmiss_ld(unsigned long cause,
-							 uint32_t *opc,
-							 struct kvm_run *run,
-							 struct kvm_vcpu *vcpu);
-
-extern enum emulation_result kvm_mips_emulate_tlbinv_ld(unsigned long cause,
-							uint32_t *opc,
-							struct kvm_run *run,
-							struct kvm_vcpu *vcpu);
-
-extern enum emulation_result kvm_mips_emulate_tlbmiss_st(unsigned long cause,
-							 uint32_t *opc,
-							 struct kvm_run *run,
-							 struct kvm_vcpu *vcpu);
-
-extern enum emulation_result kvm_mips_emulate_tlbinv_st(unsigned long cause,
-							uint32_t *opc,
-							struct kvm_run *run,
-							struct kvm_vcpu *vcpu);
-
-extern enum emulation_result kvm_mips_emulate_tlbmod(unsigned long cause,
-						     uint32_t *opc,
-						     struct kvm_run *run,
-						     struct kvm_vcpu *vcpu);
-
-extern enum emulation_result kvm_mips_emulate_fpu_exc(unsigned long cause,
-						      uint32_t *opc,
-						      struct kvm_run *run,
-						      struct kvm_vcpu *vcpu);
-
-extern enum emulation_result kvm_mips_handle_ri(unsigned long cause,
-						uint32_t *opc,
-						struct kvm_run *run,
-						struct kvm_vcpu *vcpu);
-
-extern enum emulation_result kvm_mips_emulate_ri_exc(unsigned long cause,
-						     uint32_t *opc,
-						     struct kvm_run *run,
-						     struct kvm_vcpu *vcpu);
-
-extern enum emulation_result kvm_mips_emulate_bp_exc(unsigned long cause,
-						     uint32_t *opc,
-						     struct kvm_run *run,
-						     struct kvm_vcpu *vcpu);
-
-extern enum emulation_result kvm_mips_complete_mmio_load(struct kvm_vcpu *vcpu,
-							 struct kvm_run *run);
-
-enum emulation_result kvm_mips_emulate_count(struct kvm_vcpu *vcpu);
-
-enum emulation_result kvm_mips_check_privilege(unsigned long cause,
-					       uint32_t *opc,
-					       struct kvm_run *run,
-					       struct kvm_vcpu *vcpu);
-
-enum emulation_result kvm_mips_emulate_cache(uint32_t inst,
-					     uint32_t *opc,
-					     uint32_t cause,
-					     struct kvm_run *run,
-					     struct kvm_vcpu *vcpu);
-enum emulation_result kvm_mips_emulate_CP0(uint32_t inst,
-					   uint32_t *opc,
-					   uint32_t cause,
-					   struct kvm_run *run,
-					   struct kvm_vcpu *vcpu);
-enum emulation_result kvm_mips_emulate_store(uint32_t inst,
-					     uint32_t cause,
-					     struct kvm_run *run,
-					     struct kvm_vcpu *vcpu);
-enum emulation_result kvm_mips_emulate_load(uint32_t inst,
-					    uint32_t cause,
-					    struct kvm_run *run,
-					    struct kvm_vcpu *vcpu);
-
-/* Dynamic binary translation */
-extern int kvm_mips_trans_cache_index(uint32_t inst, uint32_t *opc,
-				      struct kvm_vcpu *vcpu);
-extern int kvm_mips_trans_cache_va(uint32_t inst, uint32_t *opc,
-				   struct kvm_vcpu *vcpu);
-extern int kvm_mips_trans_mfc0(uint32_t inst, uint32_t *opc,
-			       struct kvm_vcpu *vcpu);
-extern int kvm_mips_trans_mtc0(uint32_t inst, uint32_t *opc,
-			       struct kvm_vcpu *vcpu);
-
-/* Misc */
-extern void mips32_SyncICache(unsigned long addr, unsigned long size);
-extern int kvm_mips_dump_stats(struct kvm_vcpu *vcpu);
-extern unsigned long kvm_mips_get_ramsize(struct kvm *kvm);
-
-
 #endif /* __MIPS_KVM_HOST_H__ */
diff --git a/arch/mips/include/asm/kvm_mips_te.h b/arch/mips/include/asm/kvm_mips_te.h
new file mode 100644
index 0000000..a9dd202
--- /dev/null
+++ b/arch/mips/include/asm/kvm_mips_te.h
@@ -0,0 +1,589 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
+ * Authors: Sanjay Lal <sanjayl@kymasys.com>
+ */
+#ifndef __KVM_MIPS_EMUL_H__
+#define __KVM_MIPS_EMUL_H__
+
+
+/* Special address that contains the comm page, used for reducing # of traps */
+#define KVM_GUEST_COMMPAGE_ADDR     0x0
+
+#define KVM_GUEST_KERNEL_MODE(vcpu)					\
+({									\
+	struct kvm_mips_vcpu_te *_te = vcpu->arch.impl;			\
+	(kvm_read_c0_guest_status(_te->cop0) & (ST0_EXL | ST0_ERL)) ||	\
+		((kvm_read_c0_guest_status(_te->cop0) & KSU_USER) == 0); \
+})
+
+#define KVM_GUEST_KUSEG             0x00000000UL
+#define KVM_GUEST_KSEG0             0x40000000UL
+#define KVM_GUEST_KSEG23            0x60000000UL
+#define KVM_GUEST_KSEGX(a)          ((_ACAST32_(a)) & 0x60000000)
+#define KVM_GUEST_CPHYSADDR(a)      ((_ACAST32_(a)) & 0x1fffffff)
+
+#define KVM_GUEST_CKSEG0ADDR(a)	(KVM_GUEST_CPHYSADDR(a) | KVM_GUEST_KSEG0)
+#define KVM_GUEST_CKSEG1ADDR(a)	(KVM_GUEST_CPHYSADDR(a) | KVM_GUEST_KSEG1)
+#define KVM_GUEST_CKSEG23ADDR(a) (KVM_GUEST_CPHYSADDR(a) | KVM_GUEST_KSEG23)
+
+/*
+ * Map an address to a certain kernel segment
+ */
+#define KVM_GUEST_KSEG0ADDR(a)	(KVM_GUEST_CPHYSADDR(a) | KVM_GUEST_KSEG0)
+#define KVM_GUEST_KSEG1ADDR(a)	(KVM_GUEST_CPHYSADDR(a) | KVM_GUEST_KSEG1)
+#define KVM_GUEST_KSEG23ADDR(a)	(KVM_GUEST_CPHYSADDR(a) | KVM_GUEST_KSEG23)
+
+#define KVM_INVALID_PAGE            0xdeadbeef
+#define KVM_INVALID_INST            0xdeadbeef
+#define KVM_INVALID_ADDR            0xdeadbeef
+
+#define KVM_MALTA_GUEST_RTC_ADDR    0xb8000070UL
+
+#define GUEST_TICKS_PER_JIFFY (40000000/HZ)
+#define MS_TO_NS(x) (x * 1E6L)
+
+#define CAUSEB_DC       27
+#define CAUSEF_DC       (_ULCAST_(1)   << 27)
+
+extern atomic_t kvm_mips_instance;
+extern pfn_t(*kvm_mips_gfn_to_pfn) (struct kvm *kvm, gfn_t gfn);
+extern void (*kvm_mips_release_pfn_clean) (pfn_t pfn);
+extern bool(*kvm_mips_is_error_pfn) (pfn_t pfn);
+
+enum kvm_mips_exit_types {
+	WAIT_EXITS,
+	CACHE_EXITS,
+	SIGNAL_EXITS,
+	INT_EXITS,
+	COP_UNUSABLE_EXITS,
+	TLBMOD_EXITS,
+	TLBMISS_LD_EXITS,
+	TLBMISS_ST_EXITS,
+	ADDRERR_ST_EXITS,
+	ADDRERR_LD_EXITS,
+	SYSCALL_EXITS,
+	RESVD_INST_EXITS,
+	BREAK_INST_EXITS,
+	FLUSH_DCACHE_EXITS,
+	MAX_KVM_MIPS_EXIT_TYPES
+};
+
+
+#define N_MIPS_COPROC_REGS	32
+#define N_MIPS_COPROC_SEL	8
+
+struct mips_coproc {
+	unsigned long reg[N_MIPS_COPROC_REGS][N_MIPS_COPROC_SEL];
+#ifdef CONFIG_KVM_MIPS_DEBUG_COP0_COUNTERS
+	unsigned long stat[N_MIPS_COPROC_REGS][N_MIPS_COPROC_SEL];
+#endif
+};
+
+/*
+ * Coprocessor 0 register names
+ */
+#define	MIPS_CP0_TLB_INDEX	0
+#define	MIPS_CP0_TLB_RANDOM	1
+#define	MIPS_CP0_TLB_LOW	2
+#define	MIPS_CP0_TLB_LO0	2
+#define	MIPS_CP0_TLB_LO1	3
+#define	MIPS_CP0_TLB_CONTEXT	4
+#define	MIPS_CP0_TLB_PG_MASK	5
+#define	MIPS_CP0_TLB_WIRED	6
+#define	MIPS_CP0_HWRENA		7
+#define	MIPS_CP0_BAD_VADDR	8
+#define	MIPS_CP0_COUNT		9
+#define	MIPS_CP0_TLB_HI		10
+#define	MIPS_CP0_COMPARE	11
+#define	MIPS_CP0_STATUS		12
+#define	MIPS_CP0_CAUSE		13
+#define	MIPS_CP0_EXC_PC		14
+#define	MIPS_CP0_PRID		15
+#define	MIPS_CP0_CONFIG		16
+#define	MIPS_CP0_LLADDR		17
+#define	MIPS_CP0_WATCH_LO	18
+#define	MIPS_CP0_WATCH_HI	19
+#define	MIPS_CP0_TLB_XCONTEXT	20
+#define	MIPS_CP0_ECC		26
+#define	MIPS_CP0_CACHE_ERR	27
+#define	MIPS_CP0_TAG_LO		28
+#define	MIPS_CP0_TAG_HI		29
+#define	MIPS_CP0_ERROR_PC	30
+#define	MIPS_CP0_DEBUG		23
+#define	MIPS_CP0_DEPC		24
+#define	MIPS_CP0_PERFCNT	25
+#define	MIPS_CP0_ERRCTL		26
+#define	MIPS_CP0_DATA_LO	28
+#define	MIPS_CP0_DATA_HI	29
+#define	MIPS_CP0_DESAVE		31
+
+#define MIPS_CP0_CONFIG_SEL	0
+#define MIPS_CP0_CONFIG1_SEL	1
+#define MIPS_CP0_CONFIG2_SEL	2
+#define MIPS_CP0_CONFIG3_SEL	3
+
+/* Config0 register bits */
+#define CP0C0_M    31
+#define CP0C0_K23  28
+#define CP0C0_KU   25
+#define CP0C0_MDU  20
+#define CP0C0_MM   17
+#define CP0C0_BM   16
+#define CP0C0_BE   15
+#define CP0C0_AT   13
+#define CP0C0_AR   10
+#define CP0C0_MT   7
+#define CP0C0_VI   3
+#define CP0C0_K0   0
+
+/* Config1 register bits */
+#define CP0C1_M    31
+#define CP0C1_MMU  25
+#define CP0C1_IS   22
+#define CP0C1_IL   19
+#define CP0C1_IA   16
+#define CP0C1_DS   13
+#define CP0C1_DL   10
+#define CP0C1_DA   7
+#define CP0C1_C2   6
+#define CP0C1_MD   5
+#define CP0C1_PC   4
+#define CP0C1_WR   3
+#define CP0C1_CA   2
+#define CP0C1_EP   1
+#define CP0C1_FP   0
+
+/* Config2 Register bits */
+#define CP0C2_M    31
+#define CP0C2_TU   28
+#define CP0C2_TS   24
+#define CP0C2_TL   20
+#define CP0C2_TA   16
+#define CP0C2_SU   12
+#define CP0C2_SS   8
+#define CP0C2_SL   4
+#define CP0C2_SA   0
+
+/* Config3 Register bits */
+#define CP0C3_M    31
+#define CP0C3_ISA_ON_EXC 16
+#define CP0C3_ULRI  13
+#define CP0C3_DSPP 10
+#define CP0C3_LPA  7
+#define CP0C3_VEIC 6
+#define CP0C3_VInt 5
+#define CP0C3_SP   4
+#define CP0C3_MT   2
+#define CP0C3_SM   1
+#define CP0C3_TL   0
+
+/* Have config1, Cacheable, noncoherent, write-back, write allocate*/
+#define MIPS_CONFIG0 ((1 << CP0C0_M) | (0x3 << CP0C0_K0))
+
+/*
+ * Have config2, no coprocessor2 attached, no MDMX support attached,
+ * no performance counters, watch registers present, no code
+ * compression, EJTAG present, no FPU, no watch registers
+ */
+#define MIPS_CONFIG1							\
+	((1 << CP0C1_M) |						\
+	 (0 << CP0C1_C2) | (0 << CP0C1_MD) | (0 << CP0C1_PC) |		\
+	 (0 << CP0C1_WR) | (0 << CP0C1_CA) | (1 << CP0C1_EP) |		\
+	 (0 << CP0C1_FP))
+
+/* Have config3, no tertiary/secondary caches implemented */
+#define MIPS_CONFIG2 ((1 << CP0C2_M))
+
+/*
+ * No config4, no DSP ASE, no large physaddr (PABITS), no external
+ * interrupt controller, no vectored interrupts, no 1kb pages, no
+ * SmartMIPS ASE, no trace logic
+ */
+#define MIPS_CONFIG3							\
+	((0 << CP0C3_M) | (0 << CP0C3_DSPP) | (0 << CP0C3_LPA) |	\
+	 (0 << CP0C3_VEIC) | (0 << CP0C3_VInt) | (0 << CP0C3_SP) |	\
+	 (0 << CP0C3_SM) | (0 << CP0C3_TL))
+
+/* MMU types, the first four entries have the same layout as the
+   CP0C0_MT field.  */
+enum mips_mmu_types {
+	MMU_TYPE_NONE,
+	MMU_TYPE_R4000,
+	MMU_TYPE_RESERVED,
+	MMU_TYPE_FMT,
+	MMU_TYPE_R3000,
+	MMU_TYPE_R6000,
+	MMU_TYPE_R8000
+};
+
+/*
+ * Trap codes
+ */
+#define T_INT           0	/* Interrupt pending */
+#define T_TLB_MOD       1	/* TLB modified fault */
+#define T_TLB_LD_MISS       2	/* TLB miss on load or ifetch */
+#define T_TLB_ST_MISS       3	/* TLB miss on a store */
+#define T_ADDR_ERR_LD       4	/* Address error on a load or ifetch */
+#define T_ADDR_ERR_ST       5	/* Address error on a store */
+#define T_BUS_ERR_IFETCH    6	/* Bus error on an ifetch */
+#define T_BUS_ERR_LD_ST     7	/* Bus error on a load or store */
+#define T_SYSCALL       8	/* System call */
+#define T_BREAK         9	/* Breakpoint */
+#define T_RES_INST      10	/* Reserved instruction exception */
+#define T_COP_UNUSABLE      11	/* Coprocessor unusable */
+#define T_OVFLOW        12	/* Arithmetic overflow */
+
+/*
+ * Trap definitions added for r4000 port.
+ */
+#define T_TRAP          13	/* Trap instruction */
+#define T_VCEI          14	/* Virtual coherency exception */
+#define T_FPE           15	/* Floating point exception */
+#define T_WATCH         23	/* Watch address reference */
+#define T_VCED          31	/* Virtual coherency data */
+
+/* Resume Flags */
+#define RESUME_FLAG_DR          (1<<0)	/* Reload guest nonvolatile state? */
+#define RESUME_FLAG_HOST        (1<<1)	/* Resume host? */
+
+#define RESUME_GUEST            0
+#define RESUME_GUEST_DR         RESUME_FLAG_DR
+#define RESUME_HOST             RESUME_FLAG_HOST
+
+enum emulation_result {
+	EMULATE_DONE,		/* no further processing */
+	EMULATE_DO_MMIO,	/* kvm_run filled with MMIO request */
+	EMULATE_FAIL,		/* can't emulate this instruction */
+	EMULATE_WAIT,		/* WAIT instruction */
+	EMULATE_PRIV_FAIL,
+};
+
+#define MIPS3_PG_G  0x00000001	/* Global; ignore ASID if in lo0 & lo1 */
+#define MIPS3_PG_V  0x00000002	/* Valid */
+#define MIPS3_PG_NV 0x00000000
+#define MIPS3_PG_D  0x00000004	/* Dirty */
+
+#define mips3_paddr_to_tlbpfn(x)					\
+	(((unsigned long)(x) >> MIPS3_PG_SHIFT) & MIPS3_PG_FRAME)
+#define mips3_tlbpfn_to_paddr(x)					\
+	((unsigned long)((x) & MIPS3_PG_FRAME) << MIPS3_PG_SHIFT)
+
+#define MIPS3_PG_SHIFT      6
+#define MIPS3_PG_FRAME      0x3fffffc0
+
+#define VPN2_MASK           0xffffe000
+#define TLB_IS_GLOBAL(x)    (((x).tlb_lo0 & MIPS3_PG_G) && ((x).tlb_lo1 & MIPS3_PG_G))
+#define TLB_VPN2(x)         ((x).tlb_hi & VPN2_MASK)
+#define TLB_ASID(x)         ((x).tlb_hi & ASID_MASK)
+#define TLB_IS_VALID(x, va) (((va) & (1 << PAGE_SHIFT)) ? ((x).tlb_lo1 & MIPS3_PG_V) : ((x).tlb_lo0 & MIPS3_PG_V))
+
+struct kvm_mips_te {
+	/* Guest GVA->HPA page table */
+	unsigned long *guest_pmap;
+	unsigned long guest_pmap_npages;
+
+	/* Wired host TLB used for the commpage */
+	int commpage_tlb;
+};
+
+struct kvm_mips_tlb {
+	long tlb_mask;
+	long tlb_hi;
+	long tlb_lo0;
+	long tlb_lo1;
+};
+
+#define KVM_MIPS_GUEST_TLB_SIZE     64
+
+/* Trap and Emulate VCPU state. */
+struct kvm_mips_vcpu_te {
+	struct kvm_vcpu *vcpu;
+	struct kvm_mips_te *kvm_mips_te;
+	void *host_ebase, *guest_ebase;
+	unsigned long host_stack;
+	unsigned long host_gp;
+
+	/* Host CP0 registers used when handling exits from guest */
+	unsigned long host_cp0_badvaddr;
+	unsigned long host_cp0_cause;
+	unsigned long host_cp0_epc;
+	unsigned long host_cp0_entryhi;
+	uint32_t guest_inst;
+
+	/* COP0 State */
+	struct mips_coproc *cop0;
+
+	/* Host KSEG0 address of the EI/DI offset */
+	void *kseg0_commpage;
+
+	u32 io_gpr;		/* GPR used as IO source/target */
+
+	/* Used to calibrate the virutal count register for the guest */
+	int32_t host_cp0_count;
+
+	/* Bitmask of exceptions that are pending */
+	unsigned long pending_exceptions;
+
+	/* Bitmask of pending exceptions to be cleared */
+	unsigned long pending_exceptions_clr;
+
+	unsigned long pending_load_cause;
+
+	/*
+	 * Save/Restore the entryhi register when are are
+	 * preempted/scheduled back in
+	 */
+	unsigned long preempt_entryhi;
+
+	/* S/W Based TLB for guest */
+	struct kvm_mips_tlb guest_tlb[KVM_MIPS_GUEST_TLB_SIZE];
+
+	/* Cached guest kernel/user ASIDs */
+	uint32_t guest_user_asid[NR_CPUS];
+	uint32_t guest_kernel_asid[NR_CPUS];
+	struct mm_struct guest_kernel_mm, guest_user_mm;
+
+	struct kvm_mips_tlb shadow_tlb[NR_CPUS][KVM_MIPS_GUEST_TLB_SIZE];
+
+
+	struct hrtimer comparecount_timer;
+
+	int last_sched_cpu;
+
+	/* WAIT executed */
+	int wait;
+};
+
+
+#define kvm_read_c0_guest_index(cop0)               (cop0->reg[MIPS_CP0_TLB_INDEX][0])
+#define kvm_write_c0_guest_index(cop0, val)         (cop0->reg[MIPS_CP0_TLB_INDEX][0] = val)
+#define kvm_read_c0_guest_entrylo0(cop0)            (cop0->reg[MIPS_CP0_TLB_LO0][0])
+#define kvm_read_c0_guest_entrylo1(cop0)            (cop0->reg[MIPS_CP0_TLB_LO1][0])
+#define kvm_read_c0_guest_context(cop0)             (cop0->reg[MIPS_CP0_TLB_CONTEXT][0])
+#define kvm_write_c0_guest_context(cop0, val)       (cop0->reg[MIPS_CP0_TLB_CONTEXT][0] = (val))
+#define kvm_read_c0_guest_userlocal(cop0)           (cop0->reg[MIPS_CP0_TLB_CONTEXT][2])
+#define kvm_read_c0_guest_pagemask(cop0)            (cop0->reg[MIPS_CP0_TLB_PG_MASK][0])
+#define kvm_write_c0_guest_pagemask(cop0, val)      (cop0->reg[MIPS_CP0_TLB_PG_MASK][0] = (val))
+#define kvm_read_c0_guest_wired(cop0)               (cop0->reg[MIPS_CP0_TLB_WIRED][0])
+#define kvm_write_c0_guest_wired(cop0, val)         (cop0->reg[MIPS_CP0_TLB_WIRED][0] = (val))
+#define kvm_read_c0_guest_badvaddr(cop0)            (cop0->reg[MIPS_CP0_BAD_VADDR][0])
+#define kvm_write_c0_guest_badvaddr(cop0, val)      (cop0->reg[MIPS_CP0_BAD_VADDR][0] = (val))
+#define kvm_read_c0_guest_count(cop0)               (cop0->reg[MIPS_CP0_COUNT][0])
+#define kvm_write_c0_guest_count(cop0, val)         (cop0->reg[MIPS_CP0_COUNT][0] = (val))
+#define kvm_read_c0_guest_entryhi(cop0)             (cop0->reg[MIPS_CP0_TLB_HI][0])
+#define kvm_write_c0_guest_entryhi(cop0, val)       (cop0->reg[MIPS_CP0_TLB_HI][0] = (val))
+#define kvm_read_c0_guest_compare(cop0)             (cop0->reg[MIPS_CP0_COMPARE][0])
+#define kvm_write_c0_guest_compare(cop0, val)       (cop0->reg[MIPS_CP0_COMPARE][0] = (val))
+#define kvm_read_c0_guest_status(cop0)              (cop0->reg[MIPS_CP0_STATUS][0])
+#define kvm_write_c0_guest_status(cop0, val)        (cop0->reg[MIPS_CP0_STATUS][0] = (val))
+#define kvm_read_c0_guest_intctl(cop0)              (cop0->reg[MIPS_CP0_STATUS][1])
+#define kvm_write_c0_guest_intctl(cop0, val)        (cop0->reg[MIPS_CP0_STATUS][1] = (val))
+#define kvm_read_c0_guest_cause(cop0)               (cop0->reg[MIPS_CP0_CAUSE][0])
+#define kvm_write_c0_guest_cause(cop0, val)         (cop0->reg[MIPS_CP0_CAUSE][0] = (val))
+#define kvm_read_c0_guest_epc(cop0)                 (cop0->reg[MIPS_CP0_EXC_PC][0])
+#define kvm_write_c0_guest_epc(cop0, val)           (cop0->reg[MIPS_CP0_EXC_PC][0] = (val))
+#define kvm_read_c0_guest_prid(cop0)                (cop0->reg[MIPS_CP0_PRID][0])
+#define kvm_write_c0_guest_prid(cop0, val)          (cop0->reg[MIPS_CP0_PRID][0] = (val))
+#define kvm_read_c0_guest_ebase(cop0)               (cop0->reg[MIPS_CP0_PRID][1])
+#define kvm_write_c0_guest_ebase(cop0, val)         (cop0->reg[MIPS_CP0_PRID][1] = (val))
+#define kvm_read_c0_guest_config(cop0)              (cop0->reg[MIPS_CP0_CONFIG][0])
+#define kvm_read_c0_guest_config1(cop0)             (cop0->reg[MIPS_CP0_CONFIG][1])
+#define kvm_read_c0_guest_config2(cop0)             (cop0->reg[MIPS_CP0_CONFIG][2])
+#define kvm_read_c0_guest_config3(cop0)             (cop0->reg[MIPS_CP0_CONFIG][3])
+#define kvm_read_c0_guest_config7(cop0)             (cop0->reg[MIPS_CP0_CONFIG][7])
+#define kvm_write_c0_guest_config(cop0, val)        (cop0->reg[MIPS_CP0_CONFIG][0] = (val))
+#define kvm_write_c0_guest_config1(cop0, val)       (cop0->reg[MIPS_CP0_CONFIG][1] = (val))
+#define kvm_write_c0_guest_config2(cop0, val)       (cop0->reg[MIPS_CP0_CONFIG][2] = (val))
+#define kvm_write_c0_guest_config3(cop0, val)       (cop0->reg[MIPS_CP0_CONFIG][3] = (val))
+#define kvm_write_c0_guest_config7(cop0, val)       (cop0->reg[MIPS_CP0_CONFIG][7] = (val))
+#define kvm_read_c0_guest_errorepc(cop0)            (cop0->reg[MIPS_CP0_ERROR_PC][0])
+#define kvm_write_c0_guest_errorepc(cop0, val)      (cop0->reg[MIPS_CP0_ERROR_PC][0] = (val))
+
+#define kvm_set_c0_guest_status(cop0, val)          (cop0->reg[MIPS_CP0_STATUS][0] |= (val))
+#define kvm_clear_c0_guest_status(cop0, val)        (cop0->reg[MIPS_CP0_STATUS][0] &= ~(val))
+#define kvm_set_c0_guest_cause(cop0, val)           (cop0->reg[MIPS_CP0_CAUSE][0] |= (val))
+#define kvm_clear_c0_guest_cause(cop0, val)         (cop0->reg[MIPS_CP0_CAUSE][0] &= ~(val))
+#define kvm_change_c0_guest_cause(cop0, change, val)	\
+{							\
+	kvm_clear_c0_guest_cause(cop0, change);		\
+	kvm_set_c0_guest_cause(cop0, ((val) & (change)));	\
+}
+#define kvm_set_c0_guest_ebase(cop0, val)           (cop0->reg[MIPS_CP0_PRID][1] |= (val))
+#define kvm_clear_c0_guest_ebase(cop0, val)         (cop0->reg[MIPS_CP0_PRID][1] &= ~(val))
+#define kvm_change_c0_guest_ebase(cop0, change, val)	\
+{							\
+	kvm_clear_c0_guest_ebase(cop0, change);		\
+	kvm_set_c0_guest_ebase(cop0, ((val) & (change)));	\
+}
+
+
+struct kvm_mips_callbacks {
+	int (*handle_cop_unusable) (struct kvm_vcpu *vcpu);
+	int (*handle_tlb_mod) (struct kvm_vcpu *vcpu);
+	int (*handle_tlb_ld_miss) (struct kvm_vcpu *vcpu);
+	int (*handle_tlb_st_miss) (struct kvm_vcpu *vcpu);
+	int (*handle_addr_err_st) (struct kvm_vcpu *vcpu);
+	int (*handle_addr_err_ld) (struct kvm_vcpu *vcpu);
+	int (*handle_syscall) (struct kvm_vcpu *vcpu);
+	int (*handle_res_inst) (struct kvm_vcpu *vcpu);
+	int (*handle_break) (struct kvm_vcpu *vcpu);
+	int (*vm_init) (struct kvm *kvm);
+	int (*vcpu_init) (struct kvm_vcpu *vcpu);
+	int (*vcpu_setup) (struct kvm_vcpu *vcpu);
+	 gpa_t(*gva_to_gpa) (gva_t gva);
+	void (*queue_timer_int) (struct kvm_vcpu *vcpu);
+	void (*dequeue_timer_int) (struct kvm_vcpu *vcpu);
+	void (*queue_io_int) (struct kvm_vcpu *vcpu,
+			      struct kvm_mips_interrupt *irq);
+	void (*dequeue_io_int) (struct kvm_vcpu *vcpu,
+				struct kvm_mips_interrupt *irq);
+	int (*irq_deliver) (struct kvm_vcpu *vcpu, unsigned int priority,
+			    u32 cause);
+	int (*irq_clear) (struct kvm_vcpu *vcpu, unsigned int priority,
+			  u32 cause);
+};
+extern struct kvm_mips_callbacks *kvm_mips_callbacks;
+int kvm_mips_emulation_init(struct kvm_mips_callbacks **install_callbacks);
+
+/* Debug: dump vcpu state */
+int kvm_mips_te_vcpu_dump_regs(struct kvm_vcpu *vcpu);
+
+/* Trampoline ASM routine to start running in "Guest" context */
+int __kvm_mips_vcpu_run(struct kvm_run *run, struct kvm_vcpu *vcpu);
+
+/* TLB handling */
+u32 kvm_get_kernel_asid(struct kvm_vcpu *vcpu);
+
+u32 kvm_get_user_asid(struct kvm_vcpu *vcpu);
+
+u32 kvm_get_commpage_asid(struct kvm_vcpu *vcpu);
+
+int kvm_mips_handle_kseg0_tlb_fault(unsigned long badbaddr,
+				    struct kvm_vcpu *vcpu);
+
+int kvm_mips_handle_commpage_tlb_fault(unsigned long badvaddr,
+				       struct kvm_vcpu *vcpu);
+
+int kvm_mips_handle_mapped_seg_tlb_fault(struct kvm_vcpu *vcpu,
+					 struct kvm_mips_tlb *tlb,
+					 unsigned long *hpa0,
+					 unsigned long *hpa1);
+
+enum emulation_result kvm_mips_handle_tlbmiss(unsigned long cause, u32 *opc,
+					      struct kvm_run *run,
+					      struct kvm_vcpu *vcpu);
+
+enum emulation_result kvm_mips_handle_tlbmod(unsigned long cause, u32 *opc,
+					     struct kvm_run *run,
+					     struct kvm_vcpu *vcpu);
+
+void kvm_mips_dump_host_tlbs(void);
+void kvm_mips_dump_guest_tlbs(struct kvm_vcpu *vcpu);
+void kvm_mips_dump_shadow_tlbs(struct kvm_vcpu *vcpu);
+void kvm_mips_flush_host_tlb(int skip_kseg0);
+int kvm_mips_host_tlb_inv(struct kvm_vcpu *vcpu, unsigned long entryhi);
+int kvm_mips_host_tlb_inv_index(struct kvm_vcpu *vcpu, int index);
+
+int kvm_mips_guest_tlb_lookup(struct kvm_vcpu *vcpu, unsigned long entryhi);
+int kvm_mips_host_tlb_lookup(struct kvm_vcpu *vcpu, unsigned long vaddr);
+unsigned long kvm_mips_translate_guest_kseg0_to_hpa(struct kvm_vcpu *vcpu,
+						    unsigned long gva);
+void kvm_get_new_mmu_context(struct mm_struct *mm, unsigned long cpu,
+			     struct kvm_vcpu *vcpu);
+void kvm_shadow_tlb_put(struct kvm_vcpu *vcpu);
+void kvm_shadow_tlb_load(struct kvm_vcpu *vcpu);
+void kvm_local_flush_tlb_all(void);
+void kvm_mips_init_shadow_tlb(struct kvm_vcpu *vcpu);
+void kvm_mips_alloc_new_mmu_context(struct kvm_vcpu *vcpu);
+void kvm_mips_vcpu_load(struct kvm_vcpu *vcpu, int cpu);
+void kvm_mips_vcpu_put(struct kvm_vcpu *vcpu);
+void kvm_mips_te_vcpu_load(struct kvm_vcpu *vcpu, int cpu);
+void kvm_mips_te_vcpu_put(struct kvm_vcpu *vcpu);
+int kvm_mips_te_arch_init(void *opaque);
+int kvm_mips_te_init_vm(struct kvm *kvm, unsigned long type);
+/* Emulation */
+u32 kvm_get_inst(u32 *opc, struct kvm_vcpu *vcpu);
+enum emulation_result update_pc(struct kvm_vcpu *vcpu, u32 cause);
+
+enum emulation_result kvm_mips_emulate_inst(unsigned long cause, u32 *opc,
+					    struct kvm_run *run,
+					    struct kvm_vcpu *vcpu);
+
+enum emulation_result kvm_mips_emulate_syscall(unsigned long cause, u32 *opc,
+					       struct kvm_run *run,
+					       struct kvm_vcpu *vcpu);
+
+enum emulation_result kvm_mips_emulate_tlbmiss_ld(unsigned long cause, u32 *opc,
+						  struct kvm_run *run,
+						  struct kvm_vcpu *vcpu);
+
+enum emulation_result kvm_mips_emulate_tlbinv_ld(unsigned long cause, u32 *opc,
+						 struct kvm_run *run,
+						 struct kvm_vcpu *vcpu);
+
+enum emulation_result kvm_mips_emulate_tlbmiss_st(unsigned long cause, u32 *opc,
+						  struct kvm_run *run,
+						  struct kvm_vcpu *vcpu);
+
+enum emulation_result kvm_mips_emulate_tlbinv_st(unsigned long cause, u32 *opc,
+						 struct kvm_run *run,
+						 struct kvm_vcpu *vcpu);
+
+enum emulation_result kvm_mips_emulate_tlbmod(unsigned long cause, u32 *opc,
+					      struct kvm_run *run,
+					      struct kvm_vcpu *vcpu);
+
+enum emulation_result kvm_mips_emulate_fpu_exc(unsigned long cause, u32 *opc,
+					       struct kvm_run *run,
+					       struct kvm_vcpu *vcpu);
+
+enum emulation_result kvm_mips_handle_ri(unsigned long cause, u32 *opc,
+					 struct kvm_run *run,
+					 struct kvm_vcpu *vcpu);
+
+enum emulation_result kvm_mips_emulate_ri_exc(unsigned long cause, u32 *opc,
+					      struct kvm_run *run,
+					      struct kvm_vcpu *vcpu);
+
+enum emulation_result kvm_mips_emulate_bp_exc(unsigned long cause, u32 *opc,
+					      struct kvm_run *run,
+					      struct kvm_vcpu *vcpu);
+
+enum emulation_result kvm_mips_complete_mmio_load(struct kvm_vcpu *vcpu,
+						  struct kvm_run *run);
+
+enum emulation_result kvm_mips_emulate_count(struct kvm_vcpu *vcpu);
+
+enum emulation_result kvm_mips_check_privilege(unsigned long cause, u32 *opc,
+					       struct kvm_run *run,
+					       struct kvm_vcpu *vcpu);
+
+enum emulation_result kvm_mips_emulate_cache(u32 inst, u32 *opc, u32 cause,
+					     struct kvm_run *run,
+					     struct kvm_vcpu *vcpu);
+enum emulation_result kvm_mips_emulate_CP0(u32 inst, u32 *opc, u32 cause,
+					   struct kvm_run *run,
+					   struct kvm_vcpu *vcpu);
+enum emulation_result kvm_mips_emulate_store(u32 inst, u32 cause,
+					     struct kvm_run *run,
+					     struct kvm_vcpu *vcpu);
+enum emulation_result kvm_mips_emulate_load(u32 inst, u32 cause,
+					    struct kvm_run *run,
+					    struct kvm_vcpu *vcpu);
+
+/* Dynamic binary translation */
+int kvm_mips_trans_cache_index(u32 inst, u32 *opc, struct kvm_vcpu *vcpu);
+int kvm_mips_trans_cache_va(u32 inst, u32 *opc, struct kvm_vcpu *vcpu);
+int kvm_mips_trans_mfc0(u32 inst, u32 *opc, struct kvm_vcpu *vcpu);
+int kvm_mips_trans_mtc0(u32 inst, u32 *opc, struct kvm_vcpu *vcpu);
+
+/* Misc */
+void mips32_SyncICache(unsigned long addr, unsigned long size);
+int kvm_mips_dump_stats(struct kvm_vcpu *vcpu);
+unsigned long kvm_mips_get_ramsize(struct kvm *kvm);
+
+#endif /* __KVM_MIPS_EMUL_H__ */
diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index a0aa12c..5a9222e 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -18,6 +18,7 @@
 #include <asm/processor.h>
 
 #include <linux/kvm_host.h>
+#include <asm/kvm_mips_te.h>
 
 void output_ptreg_defines(void)
 {
@@ -331,6 +332,7 @@ void output_pbe_defines(void)
 }
 #endif
 
+#if IS_ENABLED(CONFIG_KVM)
 void output_kvm_defines(void)
 {
 	COMMENT(" KVM/MIPS Specfic offsets. ");
@@ -338,59 +340,59 @@ void output_kvm_defines(void)
 	OFFSET(VCPU_RUN, kvm_vcpu, run);
 	OFFSET(VCPU_HOST_ARCH, kvm_vcpu, arch);
 
-	OFFSET(VCPU_HOST_EBASE, kvm_vcpu_arch, host_ebase);
-	OFFSET(VCPU_GUEST_EBASE, kvm_vcpu_arch, guest_ebase);
 
-	OFFSET(VCPU_HOST_STACK, kvm_vcpu_arch, host_stack);
-	OFFSET(VCPU_HOST_GP, kvm_vcpu_arch, host_gp);
+	OFFSET(KVM_VCPU_ARCH_R0, kvm_vcpu, arch.gprs[0]);
+	OFFSET(KVM_VCPU_ARCH_R1, kvm_vcpu, arch.gprs[1]);
+	OFFSET(KVM_VCPU_ARCH_R2, kvm_vcpu, arch.gprs[2]);
+	OFFSET(KVM_VCPU_ARCH_R3, kvm_vcpu, arch.gprs[3]);
+	OFFSET(KVM_VCPU_ARCH_R4, kvm_vcpu, arch.gprs[4]);
+	OFFSET(KVM_VCPU_ARCH_R5, kvm_vcpu, arch.gprs[5]);
+	OFFSET(KVM_VCPU_ARCH_R6, kvm_vcpu, arch.gprs[6]);
+	OFFSET(KVM_VCPU_ARCH_R7, kvm_vcpu, arch.gprs[7]);
+	OFFSET(KVM_VCPU_ARCH_R8, kvm_vcpu, arch.gprs[8]);
+	OFFSET(KVM_VCPU_ARCH_R9, kvm_vcpu, arch.gprs[9]);
+	OFFSET(KVM_VCPU_ARCH_R10, kvm_vcpu, arch.gprs[10]);
+	OFFSET(KVM_VCPU_ARCH_R11, kvm_vcpu, arch.gprs[11]);
+	OFFSET(KVM_VCPU_ARCH_R12, kvm_vcpu, arch.gprs[12]);
+	OFFSET(KVM_VCPU_ARCH_R13, kvm_vcpu, arch.gprs[13]);
+	OFFSET(KVM_VCPU_ARCH_R14, kvm_vcpu, arch.gprs[14]);
+	OFFSET(KVM_VCPU_ARCH_R15, kvm_vcpu, arch.gprs[15]);
+	OFFSET(KVM_VCPU_ARCH_R16, kvm_vcpu, arch.gprs[16]);
+	OFFSET(KVM_VCPU_ARCH_R17, kvm_vcpu, arch.gprs[17]);
+	OFFSET(KVM_VCPU_ARCH_R18, kvm_vcpu, arch.gprs[18]);
+	OFFSET(KVM_VCPU_ARCH_R19, kvm_vcpu, arch.gprs[19]);
+	OFFSET(KVM_VCPU_ARCH_R20, kvm_vcpu, arch.gprs[20]);
+	OFFSET(KVM_VCPU_ARCH_R21, kvm_vcpu, arch.gprs[21]);
+	OFFSET(KVM_VCPU_ARCH_R22, kvm_vcpu, arch.gprs[22]);
+	OFFSET(KVM_VCPU_ARCH_R23, kvm_vcpu, arch.gprs[23]);
+	OFFSET(KVM_VCPU_ARCH_R24, kvm_vcpu, arch.gprs[24]);
+	OFFSET(KVM_VCPU_ARCH_R25, kvm_vcpu, arch.gprs[25]);
+	OFFSET(KVM_VCPU_ARCH_R26, kvm_vcpu, arch.gprs[26]);
+	OFFSET(KVM_VCPU_ARCH_R27, kvm_vcpu, arch.gprs[27]);
+	OFFSET(KVM_VCPU_ARCH_R28, kvm_vcpu, arch.gprs[28]);
+	OFFSET(KVM_VCPU_ARCH_R29, kvm_vcpu, arch.gprs[29]);
+	OFFSET(KVM_VCPU_ARCH_R30, kvm_vcpu, arch.gprs[30]);
+	OFFSET(KVM_VCPU_ARCH_R31, kvm_vcpu, arch.gprs[31]);
+	OFFSET(KVM_VCPU_ARCH_LO, kvm_vcpu, arch.lo);
+	OFFSET(KVM_VCPU_ARCH_HI, kvm_vcpu, arch.hi);
+	OFFSET(KVM_VCPU_ARCH_EPC, kvm_vcpu, arch.epc);
+	OFFSET(KVM_VCPU_ARCH_IMPL, kvm_vcpu, arch.impl);
 
-	OFFSET(VCPU_HOST_CP0_BADVADDR, kvm_vcpu_arch, host_cp0_badvaddr);
-	OFFSET(VCPU_HOST_CP0_CAUSE, kvm_vcpu_arch, host_cp0_cause);
-	OFFSET(VCPU_HOST_EPC, kvm_vcpu_arch, host_cp0_epc);
-	OFFSET(VCPU_HOST_ENTRYHI, kvm_vcpu_arch, host_cp0_entryhi);
-
-	OFFSET(VCPU_GUEST_INST, kvm_vcpu_arch, guest_inst);
-
-	OFFSET(KVM_VCPU_ARCH_R0, kvm_vcpu_arch, gprs[0]);
-	OFFSET(KVM_VCPU_ARCH_R1, kvm_vcpu_arch, gprs[1]);
-	OFFSET(KVM_VCPU_ARCH_R2, kvm_vcpu_arch, gprs[2]);
-	OFFSET(KVM_VCPU_ARCH_R3, kvm_vcpu_arch, gprs[3]);
-	OFFSET(KVM_VCPU_ARCH_R4, kvm_vcpu_arch, gprs[4]);
-	OFFSET(KVM_VCPU_ARCH_R5, kvm_vcpu_arch, gprs[5]);
-	OFFSET(KVM_VCPU_ARCH_R6, kvm_vcpu_arch, gprs[6]);
-	OFFSET(KVM_VCPU_ARCH_R7, kvm_vcpu_arch, gprs[7]);
-	OFFSET(KVM_VCPU_ARCH_R8, kvm_vcpu_arch, gprs[8]);
-	OFFSET(KVM_VCPU_ARCH_R9, kvm_vcpu_arch, gprs[9]);
-	OFFSET(KVM_VCPU_ARCH_R10, kvm_vcpu_arch, gprs[10]);
-	OFFSET(KVM_VCPU_ARCH_R11, kvm_vcpu_arch, gprs[11]);
-	OFFSET(KVM_VCPU_ARCH_R12, kvm_vcpu_arch, gprs[12]);
-	OFFSET(KVM_VCPU_ARCH_R13, kvm_vcpu_arch, gprs[13]);
-	OFFSET(KVM_VCPU_ARCH_R14, kvm_vcpu_arch, gprs[14]);
-	OFFSET(KVM_VCPU_ARCH_R15, kvm_vcpu_arch, gprs[15]);
-	OFFSET(KVM_VCPU_ARCH_R16, kvm_vcpu_arch, gprs[16]);
-	OFFSET(KVM_VCPU_ARCH_R17, kvm_vcpu_arch, gprs[17]);
-	OFFSET(KVM_VCPU_ARCH_R18, kvm_vcpu_arch, gprs[18]);
-	OFFSET(KVM_VCPU_ARCH_R19, kvm_vcpu_arch, gprs[19]);
-	OFFSET(KVM_VCPU_ARCH_R20, kvm_vcpu_arch, gprs[20]);
-	OFFSET(KVM_VCPU_ARCH_R21, kvm_vcpu_arch, gprs[21]);
-	OFFSET(KVM_VCPU_ARCH_R22, kvm_vcpu_arch, gprs[22]);
-	OFFSET(KVM_VCPU_ARCH_R23, kvm_vcpu_arch, gprs[23]);
-	OFFSET(KVM_VCPU_ARCH_R24, kvm_vcpu_arch, gprs[24]);
-	OFFSET(KVM_VCPU_ARCH_R25, kvm_vcpu_arch, gprs[25]);
-	OFFSET(KVM_VCPU_ARCH_R26, kvm_vcpu_arch, gprs[26]);
-	OFFSET(KVM_VCPU_ARCH_R27, kvm_vcpu_arch, gprs[27]);
-	OFFSET(KVM_VCPU_ARCH_R28, kvm_vcpu_arch, gprs[28]);
-	OFFSET(KVM_VCPU_ARCH_R29, kvm_vcpu_arch, gprs[29]);
-	OFFSET(KVM_VCPU_ARCH_R30, kvm_vcpu_arch, gprs[30]);
-	OFFSET(KVM_VCPU_ARCH_R31, kvm_vcpu_arch, gprs[31]);
-	OFFSET(KVM_VCPU_ARCH_LO, kvm_vcpu_arch, lo);
-	OFFSET(KVM_VCPU_ARCH_HI, kvm_vcpu_arch, hi);
-	OFFSET(KVM_VCPU_ARCH_EPC, kvm_vcpu_arch, epc);
-	OFFSET(VCPU_COP0, kvm_vcpu_arch, cop0);
-	OFFSET(VCPU_GUEST_KERNEL_ASID, kvm_vcpu_arch, guest_kernel_asid);
-	OFFSET(VCPU_GUEST_USER_ASID, kvm_vcpu_arch, guest_user_asid);
+	OFFSET(KVM_MIPS_VCPU_TE_HOST_EBASE, kvm_mips_vcpu_te, host_ebase);
+	OFFSET(KVM_MIPS_VCPU_TE_GUEST_EBASE, kvm_mips_vcpu_te, guest_ebase);
+	OFFSET(KVM_MIPS_VCPU_TE_HOST_STACK, kvm_mips_vcpu_te, host_stack);
+	OFFSET(KVM_MIPS_VCPU_TE_HOST_GP, kvm_mips_vcpu_te, host_gp);
+	OFFSET(KVM_MIPS_VCPU_TE_HOST_CP0_BADVADDR, kvm_mips_vcpu_te, host_cp0_badvaddr);
+	OFFSET(KVM_MIPS_VCPU_TE_HOST_CP0_CAUSE, kvm_mips_vcpu_te, host_cp0_cause);
+	OFFSET(KVM_MIPS_VCPU_TE_HOST_EPC, kvm_mips_vcpu_te, host_cp0_epc);
+	OFFSET(KVM_MIPS_VCPU_TE_HOST_ENTRYHI, kvm_mips_vcpu_te, host_cp0_entryhi);
+	OFFSET(KVM_MIPS_VCPU_TE_GUEST_INST, kvm_mips_vcpu_te, guest_inst);
+	OFFSET(KVM_MIPS_VCPU_TE_COP0, kvm_mips_vcpu_te, cop0);
+	OFFSET(KVM_MIPS_VCPU_TE_GUEST_KERNEL_ASID, kvm_mips_vcpu_te, guest_kernel_asid);
+	OFFSET(KVM_MIPS_VCPU_TE_GUEST_USER_ASID, kvm_mips_vcpu_te, guest_user_asid);
 
 	OFFSET(COP0_TLB_HI, mips_coproc, reg[MIPS_CP0_TLB_HI][0]);
 	OFFSET(COP0_STATUS, mips_coproc, reg[MIPS_CP0_STATUS][0]);
 	BLANK();
 }
+#endif
diff --git a/arch/mips/kvm/kvm_locore.S b/arch/mips/kvm/kvm_locore.S
index 7c2933a..efcd366 100644
--- a/arch/mips/kvm/kvm_locore.S
+++ b/arch/mips/kvm/kvm_locore.S
@@ -122,17 +122,17 @@ FEXPORT(__kvm_mips_vcpu_run)
 	/* DDATA_LO has pointer to vcpu */
 	mtc0	a1, CP0_DDATA_LO
 
-	/* Offset into vcpu->arch */
-	addiu	k1, a1, VCPU_HOST_ARCH
+	move	k1, a1
+	LONG_L	t1, KVM_VCPU_ARCH_IMPL(k1)
 
 	/*
 	 * Save the host stack to VCPU, used for exception processing
 	 * when we exit from the Guest
 	 */
-	LONG_S	sp, VCPU_HOST_STACK(k1)
+	LONG_S	sp, KVM_MIPS_VCPU_TE_HOST_STACK(t1)
 
 	/* Save the kernel gp as well */
-	LONG_S	gp, VCPU_HOST_GP(k1)
+	LONG_S	gp, KVM_MIPS_VCPU_TE_HOST_GP(t1)
 
 	/* Setup status register for running the guest in UM, interrupts are disabled */
 	li	k0, (ST0_EXL | KSU_USER| ST0_BEV)
@@ -140,7 +140,7 @@ FEXPORT(__kvm_mips_vcpu_run)
 	ehb
 
 	/* load up the new EBASE */
-	LONG_L	k0, VCPU_GUEST_EBASE(k1)
+	LONG_L	k0, KVM_MIPS_VCPU_TE_GUEST_EBASE(t1)
 	mtc0	k0, CP0_EBASE
 
 	/*
@@ -159,13 +159,13 @@ FEXPORT(__kvm_mips_vcpu_run)
 	LONG_L	t0, KVM_VCPU_ARCH_EPC(k1)
 	mtc0	t0, CP0_EPC
 
-FEXPORT(__kvm_mips_load_asid)
 	/* Set the ASID for the Guest Kernel */
 	sll	t0, t0, 1	/* with kseg0 @ 0x40000000, kernel */
 			        /* addresses shift to 0x80000000 */
+	LONG_L	v0, KVM_VCPU_ARCH_IMPL(k1)
 	bltz	t0, 1f		/* If kernel */
-	 addiu	t1, k1, VCPU_GUEST_KERNEL_ASID  /* (BD)  */
-	addiu	t1, k1, VCPU_GUEST_USER_ASID    /* else user */
+	 addiu	t1, v0, KVM_MIPS_VCPU_TE_GUEST_KERNEL_ASID	/* (BD)  */
+	addiu	t1, v0, KVM_MIPS_VCPU_TE_GUEST_USER_ASID	/* else user */
 1:
 	     /* t1: contains the base of the ASID array, need to get the cpu id  */
 	LONG_L	t2, TI_CPU($28)             /* smp_processor_id */
@@ -222,7 +222,6 @@ FEXPORT(__kvm_mips_load_asid)
 	LONG_L	k0, KVM_VCPU_ARCH_HI(k1)
 	mthi	k0
 
-FEXPORT(__kvm_mips_load_k0k1)
 	/* Restore the guest's k0/k1 registers */
 	LONG_L	k0, KVM_VCPU_ARCH_R26(k1)
 	LONG_L	k1, KVM_VCPU_ARCH_R27(k1)
@@ -264,7 +263,6 @@ NESTED (MIPSX(GuestException), CALLFRAME_SIZ, ra)
 
 	/* Get the VCPU pointer from DDTATA_LO */
 	mfc0	k1, CP0_DDATA_LO
-	addiu	k1, k1, VCPU_HOST_ARCH
 
 	/* Start saving Guest context to VCPU */
 	LONG_S	$0, KVM_VCPU_ARCH_R0(k1)
@@ -334,17 +332,18 @@ NESTED (MIPSX(GuestException), CALLFRAME_SIZ, ra)
 
 	/* Save Host level EPC, BadVaddr and Cause to VCPU, useful to
 	 * process the exception */
+	LONG_L	t1, KVM_VCPU_ARCH_IMPL(k1)
 	mfc0	k0,CP0_EPC
 	LONG_S	k0, KVM_VCPU_ARCH_EPC(k1)
 
 	mfc0	k0, CP0_BADVADDR
-	LONG_S	k0, VCPU_HOST_CP0_BADVADDR(k1)
+	LONG_S	k0, KVM_MIPS_VCPU_TE_HOST_CP0_BADVADDR(t1)
 
 	mfc0	k0, CP0_CAUSE
-	LONG_S	k0, VCPU_HOST_CP0_CAUSE(k1)
+	LONG_S	k0, KVM_MIPS_VCPU_TE_HOST_CP0_CAUSE(t1)
 
 	mfc0	k0, CP0_ENTRYHI
-	LONG_S	k0, VCPU_HOST_ENTRYHI(k1)
+	LONG_S	k0, KVM_MIPS_VCPU_TE_HOST_ENTRYHI(t1)
 
 	/* Now restore the host state just enough to run the handlers */
 
@@ -359,8 +358,8 @@ NESTED (MIPSX(GuestException), CALLFRAME_SIZ, ra)
 	mtc0	k0, CP0_STATUS
 	ehb
 
-	LONG_L	k0, VCPU_HOST_EBASE(k1)
-	mtc0	k0,CP0_EBASE
+	LONG_L	k0, KVM_MIPS_VCPU_TE_HOST_EBASE(t1)
+	mtc0	k0, CP0_EBASE
 
 
 	/* Now that the new EBASE has been loaded, unset BEV and KSU_USER */
@@ -372,10 +371,10 @@ NESTED (MIPSX(GuestException), CALLFRAME_SIZ, ra)
 	ehb
 
 	/* Load up host GP */
-	LONG_L	gp, VCPU_HOST_GP(k1)
+	LONG_L	gp, KVM_MIPS_VCPU_TE_HOST_GP(t1)
 
 	/* Need a stack before we can jump to "C" */
-	LONG_L	sp, VCPU_HOST_STACK(k1)
+	LONG_L	sp, KVM_MIPS_VCPU_TE_HOST_STACK(t1)
 
 	/* Saved host state */
 	addiu	sp,sp, -PT_SIZE
@@ -397,7 +396,7 @@ FEXPORT(__kvm_mips_jump_to_handler)
 	/* XXXKYMA: not sure if this is safe, how large is the stack??
 	 * Now jump to the kvm_mips_handle_exit() to see if we can deal
 	 * with this in the kernel */
-	PTR_LA	t9, kvm_mips_handle_exit
+	PTR_LA	t9, kvm_mips_te_handle_exit
 	jalr.hb	t9
 	 addiu	sp,sp, -CALLFRAME_SIZ           /* BD Slot */
 
@@ -411,7 +410,6 @@ FEXPORT(__kvm_mips_jump_to_handler)
 	 */
 
 	move	k1, s1
-	addiu	k1, k1, VCPU_HOST_ARCH
 
 	/* Check return value, should tell us if we are returning to the
 	 * host (handle I/O etc)or resuming the guest
@@ -420,12 +418,12 @@ FEXPORT(__kvm_mips_jump_to_handler)
 	bnez	t0, __kvm_mips_return_to_host
 	 nop
 
-__kvm_mips_return_to_guest:
+	LONG_L	v0, KVM_VCPU_ARCH_IMPL(k1)
    	 /* Put the saved pointer to vcpu (s1) back into the DDATA_LO Register */
 	mtc0	s1, CP0_DDATA_LO
 
 	/* Load up the Guest EBASE to minimize the window where BEV is set */
-	LONG_L	t0, VCPU_GUEST_EBASE(k1)
+	LONG_L	t0, KVM_MIPS_VCPU_TE_GUEST_EBASE(v0)
 
 	/* Switch EBASE back to the one used by KVM */
 	mfc0	v1, CP0_STATUS
@@ -452,8 +450,8 @@ __kvm_mips_return_to_guest:
 	sll	t0, t0, 1	/* with kseg0 @ 0x40000000, kernel */
 				/* addresses shift to 0x80000000 */
 	bltz	t0, 1f		/* If kernel */
-	 addiu	t1, k1, VCPU_GUEST_KERNEL_ASID  /* (BD)  */
-	addiu	t1, k1, VCPU_GUEST_USER_ASID    /* else user */
+	 addiu	t1, v0, KVM_MIPS_VCPU_TE_GUEST_KERNEL_ASID	/* (BD)  */
+	addiu	t1, v0, KVM_MIPS_VCPU_TE_GUEST_USER_ASID	/* else user */
 1:
 	/* t1: contains the base of the ASID array, need to get the cpu id  */
 	LONG_L	t2, TI_CPU($28)		/* smp_processor_id */
@@ -514,8 +512,9 @@ FEXPORT(__kvm_mips_skip_guest_restore)
 	eret
 
 __kvm_mips_return_to_host:
+	LONG_L	t1, KVM_VCPU_ARCH_IMPL(k1)
 	/* EBASE is already pointing to Linux */
-	LONG_L	k1, VCPU_HOST_STACK(k1)
+	LONG_L	k1, KVM_MIPS_VCPU_TE_HOST_STACK(t1)
 	addiu	k1,k1, -PT_SIZE
 
 	/* Restore host DDATA_LO */
diff --git a/arch/mips/kvm/kvm_mips.c b/arch/mips/kvm/kvm_mips.c
index 4ac5ab4..041caad 100644
--- a/arch/mips/kvm/kvm_mips.c
+++ b/arch/mips/kvm/kvm_mips.c
@@ -15,21 +15,12 @@
 #include <linux/vmalloc.h>
 #include <linux/fs.h>
 #include <linux/bootmem.h>
+#include <linux/kvm_host.h>
+
 #include <asm/page.h>
 #include <asm/cacheflush.h>
 #include <asm/mmu_context.h>
-
-#include <linux/kvm_host.h>
-
-#include "kvm_mips_int.h"
-#include "kvm_mips_comm.h"
-
-#define CREATE_TRACE_POINTS
-#include "trace.h"
-
-#ifndef VECTORSPACING
-#define VECTORSPACING 0x100	/* for EI/VI mode */
-#endif
+#include <asm/kvm_mips_te.h>
 
 #define VCPU_STAT(x) offsetof(struct kvm_vcpu, stat.x), KVM_STAT_VCPU
 struct kvm_stats_debugfs_item debugfs_entries[] = {
@@ -51,16 +42,6 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{NULL}
 };
 
-static int kvm_mips_reset_vcpu(struct kvm_vcpu *vcpu)
-{
-	int i;
-	for_each_possible_cpu(i) {
-		vcpu->arch.guest_kernel_asid[i] = 0;
-		vcpu->arch.guest_user_asid[i] = 0;
-	}
-	return 0;
-}
-
 gfn_t unalias_gfn(struct kvm *kvm, gfn_t gfn)
 {
 	return gfn;
@@ -71,7 +52,7 @@ gfn_t unalias_gfn(struct kvm *kvm, gfn_t gfn)
  */
 int kvm_arch_vcpu_runnable(struct kvm_vcpu *vcpu)
 {
-	return !!(vcpu->arch.pending_exceptions);
+	return vcpu->kvm->arch.ops->vcpu_runnable(vcpu);
 }
 
 int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
@@ -104,92 +85,22 @@ void kvm_arch_check_processor_compat(void *rtn)
 	return;
 }
 
-static void kvm_mips_init_tlbs(struct kvm *kvm)
-{
-	unsigned long wired;
-
-	/* Add a wired entry to the TLB, it is used to map the commpage to the Guest kernel */
-	wired = read_c0_wired();
-	write_c0_wired(wired + 1);
-	mtc0_tlbw_hazard();
-	kvm->arch.commpage_tlb = wired;
-
-	kvm_debug("[%d] commpage TLB: %d\n", smp_processor_id(),
-		  kvm->arch.commpage_tlb);
-}
-
-static void kvm_mips_init_vm_percpu(void *arg)
-{
-	struct kvm *kvm = (struct kvm *)arg;
-
-	kvm_mips_init_tlbs(kvm);
-	kvm_mips_callbacks->vm_init(kvm);
-
-}
+int kvm_mips_te_init_vm(struct kvm *kvm, unsigned long type);
 
 int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 {
-	if (atomic_inc_return(&kvm_mips_instance) == 1) {
-		kvm_info("%s: 1st KVM instance, setup host TLB parameters\n",
-			 __func__);
-		on_each_cpu(kvm_mips_init_vm_percpu, kvm, 1);
-	}
-
-
-	return 0;
-}
-
-void kvm_mips_free_vcpus(struct kvm *kvm)
-{
-	unsigned int i;
-	struct kvm_vcpu *vcpu;
-
-	/* Put the pages we reserved for the guest pmap */
-	for (i = 0; i < kvm->arch.guest_pmap_npages; i++) {
-		if (kvm->arch.guest_pmap[i] != KVM_INVALID_PAGE)
-			kvm_mips_release_pfn_clean(kvm->arch.guest_pmap[i]);
-	}
-
-	if (kvm->arch.guest_pmap)
-		kfree(kvm->arch.guest_pmap);
-
-	kvm_for_each_vcpu(i, vcpu, kvm) {
-		kvm_arch_vcpu_free(vcpu);
-	}
-
-	mutex_lock(&kvm->lock);
-
-	for (i = 0; i < atomic_read(&kvm->online_vcpus); i++)
-		kvm->vcpus[i] = NULL;
-
-	atomic_set(&kvm->online_vcpus, 0);
-
-	mutex_unlock(&kvm->lock);
+	if (type == 0)
+		return kvm_mips_te_init_vm(kvm, type);
+	return -EINVAL;
 }
 
 void kvm_arch_sync_events(struct kvm *kvm)
 {
 }
 
-static void kvm_mips_uninit_tlbs(void *arg)
-{
-	/* Restore wired count */
-	write_c0_wired(0);
-	mtc0_tlbw_hazard();
-	/* Clear out all the TLBs */
-	kvm_local_flush_tlb_all();
-}
-
 void kvm_arch_destroy_vm(struct kvm *kvm)
 {
-	kvm_mips_free_vcpus(kvm);
-
-	/* If this is the last instance, restore wired count */
-	if (atomic_dec_return(&kvm_mips_instance) == 0) {
-		kvm_info("%s: last KVM instance, restoring TLB parameters\n",
-			 __func__);
-		on_each_cpu(kvm_mips_uninit_tlbs, NULL, 1);
-	}
+	kvm->arch.ops->destroy_vm(kvm);
 }
 
 long
@@ -221,41 +132,7 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
                                 const struct kvm_memory_slot *old,
                                 enum kvm_mr_change change)
 {
-	unsigned long npages = 0;
-	int i, err = 0;
-
-	kvm_debug("%s: kvm: %p slot: %d, GPA: %llx, size: %llx, QVA: %llx\n",
-		  __func__, kvm, mem->slot, mem->guest_phys_addr,
-		  mem->memory_size, mem->userspace_addr);
-
-	/* Setup Guest PMAP table */
-	if (!kvm->arch.guest_pmap) {
-		if (mem->slot == 0)
-			npages = mem->memory_size >> PAGE_SHIFT;
-
-		if (npages) {
-			kvm->arch.guest_pmap_npages = npages;
-			kvm->arch.guest_pmap =
-			    kzalloc(npages * sizeof(unsigned long), GFP_KERNEL);
-
-			if (!kvm->arch.guest_pmap) {
-				kvm_err("Failed to allocate guest PMAP");
-				err = -ENOMEM;
-				goto out;
-			}
-
-			kvm_info
-			    ("Allocated space for Guest PMAP Table (%ld pages) @ %p\n",
-			     npages, kvm->arch.guest_pmap);
-
-			/* Now setup the page table */
-			for (i = 0; i < npages; i++) {
-				kvm->arch.guest_pmap[i] = KVM_INVALID_PAGE;
-			}
-		}
-	}
-out:
-	return;
+	kvm->arch.ops->commit_memory_region(kvm, mem, old, change);
 }
 
 void kvm_arch_flush_shadow_all(struct kvm *kvm)
@@ -273,123 +150,12 @@ void kvm_arch_flush_shadow(struct kvm *kvm)
 
 struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm, unsigned int id)
 {
-	extern char mips32_exception[], mips32_exceptionEnd[];
-	extern char mips32_GuestException[], mips32_GuestExceptionEnd[];
-	int err, size, offset;
-	void *gebase;
-	int i;
-
-	struct kvm_vcpu *vcpu = kzalloc(sizeof(struct kvm_vcpu), GFP_KERNEL);
-
-	if (!vcpu) {
-		err = -ENOMEM;
-		goto out;
-	}
-
-	err = kvm_vcpu_init(vcpu, kvm, id);
-
-	if (err)
-		goto out_free_cpu;
-
-	kvm_info("kvm @ %p: create cpu %d at %p\n", kvm, id, vcpu);
-
-	/* Allocate space for host mode exception handlers that handle
-	 * guest mode exits
-	 */
-	if (cpu_has_veic || cpu_has_vint) {
-		size = 0x200 + VECTORSPACING * 64;
-	} else {
-		size = 0x200;
-	}
-
-	/* Save Linux EBASE */
-	vcpu->arch.host_ebase = (void *)(long)(read_c0_ebase() & 0x3ff);
-
-	gebase = kzalloc(ALIGN(size, PAGE_SIZE), GFP_KERNEL);
-
-	if (!gebase) {
-		err = -ENOMEM;
-		goto out_free_cpu;
-	}
-	kvm_info("Allocated %d bytes for KVM Exception Handlers @ %p\n",
-		 ALIGN(size, PAGE_SIZE), gebase);
-
-	/* Save new ebase */
-	vcpu->arch.guest_ebase = gebase;
-
-	/* Copy L1 Guest Exception handler to correct offset */
-
-	/* TLB Refill, EXL = 0 */
-	memcpy(gebase, mips32_exception,
-	       mips32_exceptionEnd - mips32_exception);
-
-	/* General Exception Entry point */
-	memcpy(gebase + 0x180, mips32_exception,
-	       mips32_exceptionEnd - mips32_exception);
-
-	/* For vectored interrupts poke the exception code @ all offsets 0-7 */
-	for (i = 0; i < 8; i++) {
-		kvm_debug("L1 Vectored handler @ %p\n",
-			  gebase + 0x200 + (i * VECTORSPACING));
-		memcpy(gebase + 0x200 + (i * VECTORSPACING), mips32_exception,
-		       mips32_exceptionEnd - mips32_exception);
-	}
-
-	/* General handler, relocate to unmapped space for sanity's sake */
-	offset = 0x2000;
-	kvm_info("Installing KVM Exception handlers @ %p, %#x bytes\n",
-		 gebase + offset,
-		 (unsigned)(mips32_GuestExceptionEnd - mips32_GuestException));
-
-	memcpy(gebase + offset, mips32_GuestException,
-	       mips32_GuestExceptionEnd - mips32_GuestException);
-
-	/* Invalidate the icache for these ranges */
-	mips32_SyncICache((unsigned long) gebase, ALIGN(size, PAGE_SIZE));
-
-	/* Allocate comm page for guest kernel, a TLB will be reserved for mapping GVA @ 0xFFFF8000 to this page */
-	vcpu->arch.kseg0_commpage = kzalloc(PAGE_SIZE << 1, GFP_KERNEL);
-
-	if (!vcpu->arch.kseg0_commpage) {
-		err = -ENOMEM;
-		goto out_free_gebase;
-	}
-
-	kvm_info("Allocated COMM page @ %p\n", vcpu->arch.kseg0_commpage);
-	kvm_mips_commpage_init(vcpu);
-
-	/* Init */
-	vcpu->arch.last_sched_cpu = -1;
-
-	/* Start off the timer */
-	kvm_mips_emulate_count(vcpu);
-
-	return vcpu;
-
-out_free_gebase:
-	kfree(gebase);
-
-out_free_cpu:
-	kfree(vcpu);
-
-out:
-	return ERR_PTR(err);
+	return kvm->arch.ops->vcpu_create(kvm, id);
 }
 
 void kvm_arch_vcpu_free(struct kvm_vcpu *vcpu)
 {
-	hrtimer_cancel(&vcpu->arch.comparecount_timer);
-
-	kvm_vcpu_uninit(vcpu);
-
-	kvm_mips_dump_stats(vcpu);
-
-	if (vcpu->arch.guest_ebase)
-		kfree(vcpu->arch.guest_ebase);
-
-	if (vcpu->arch.kseg0_commpage)
-		kfree(vcpu->arch.kseg0_commpage);
-
+	vcpu->kvm->arch.ops->vcpu_free(vcpu);
 }
 
 void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
@@ -406,70 +172,9 @@ kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 
 int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
-	int r = 0;
-	sigset_t sigsaved;
-
-	if (vcpu->sigset_active)
-		sigprocmask(SIG_SETMASK, &vcpu->sigset, &sigsaved);
-
-	if (vcpu->mmio_needed) {
-		if (!vcpu->mmio_is_write)
-			kvm_mips_complete_mmio_load(vcpu, run);
-		vcpu->mmio_needed = 0;
-	}
-
-	/* Check if we have any exceptions/interrupts pending */
-	kvm_mips_deliver_interrupts(vcpu,
-				    kvm_read_c0_guest_cause(vcpu->arch.cop0));
-
-	local_irq_disable();
-	kvm_guest_enter();
-
-	r = __kvm_mips_vcpu_run(run, vcpu);
-
-	kvm_guest_exit();
-	local_irq_enable();
-
-	if (vcpu->sigset_active)
-		sigprocmask(SIG_SETMASK, &sigsaved, NULL);
-
-	return r;
+	return vcpu->kvm->arch.ops->vcpu_run(vcpu, run);
 }
 
-int
-kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu, struct kvm_mips_interrupt *irq)
-{
-	int intr = (int)irq->irq;
-	struct kvm_vcpu *dvcpu = NULL;
-
-	if (intr == 3 || intr == -3 || intr == 4 || intr == -4)
-		kvm_debug("%s: CPU: %d, INTR: %d\n", __func__, irq->cpu,
-			  (int)intr);
-
-	if (irq->cpu == -1)
-		dvcpu = vcpu;
-	else
-		dvcpu = vcpu->kvm->vcpus[irq->cpu];
-
-	if (intr == 2 || intr == 3 || intr == 4) {
-		kvm_mips_callbacks->queue_io_int(dvcpu, irq);
-
-	} else if (intr == -2 || intr == -3 || intr == -4) {
-		kvm_mips_callbacks->dequeue_io_int(dvcpu, irq);
-	} else {
-		kvm_err("%s: invalid interrupt ioctl (%d:%d)\n", __func__,
-			irq->cpu, irq->irq);
-		return -EINVAL;
-	}
-
-	dvcpu->arch.wait = 0;
-
-	if (waitqueue_active(&dvcpu->wq)) {
-		wake_up_interruptible(&dvcpu->wq);
-	}
-
-	return 0;
-}
 
 int
 kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
@@ -568,8 +273,6 @@ static int kvm_mips_get_reg(struct kvm_vcpu *vcpu,
 			    const struct kvm_one_reg *reg)
 {
 	u64 __user *uaddr = (u64 __user *)(long)reg->addr;
-
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	s64 v;
 
 	switch (reg->id) {
@@ -585,51 +288,9 @@ static int kvm_mips_get_reg(struct kvm_vcpu *vcpu,
 	case KVM_REG_MIPS_PC:
 		v = (long)vcpu->arch.epc;
 		break;
-
-	case KVM_REG_MIPS_CP0_INDEX:
-		v = (long)kvm_read_c0_guest_index(cop0);
-		break;
-	case KVM_REG_MIPS_CP0_CONTEXT:
-		v = (long)kvm_read_c0_guest_context(cop0);
-		break;
-	case KVM_REG_MIPS_CP0_PAGEMASK:
-		v = (long)kvm_read_c0_guest_pagemask(cop0);
-		break;
-	case KVM_REG_MIPS_CP0_WIRED:
-		v = (long)kvm_read_c0_guest_wired(cop0);
-		break;
-	case KVM_REG_MIPS_CP0_BADVADDR:
-		v = (long)kvm_read_c0_guest_badvaddr(cop0);
-		break;
-	case KVM_REG_MIPS_CP0_ENTRYHI:
-		v = (long)kvm_read_c0_guest_entryhi(cop0);
-		break;
-	case KVM_REG_MIPS_CP0_STATUS:
-		v = (long)kvm_read_c0_guest_status(cop0);
-		break;
-	case KVM_REG_MIPS_CP0_CAUSE:
-		v = (long)kvm_read_c0_guest_cause(cop0);
-		break;
-	case KVM_REG_MIPS_CP0_ERROREPC:
-		v = (long)kvm_read_c0_guest_errorepc(cop0);
-		break;
-	case KVM_REG_MIPS_CP0_CONFIG:
-		v = (long)kvm_read_c0_guest_config(cop0);
-		break;
-	case KVM_REG_MIPS_CP0_CONFIG1:
-		v = (long)kvm_read_c0_guest_config1(cop0);
-		break;
-	case KVM_REG_MIPS_CP0_CONFIG2:
-		v = (long)kvm_read_c0_guest_config2(cop0);
-		break;
-	case KVM_REG_MIPS_CP0_CONFIG3:
-		v = (long)kvm_read_c0_guest_config3(cop0);
-		break;
-	case KVM_REG_MIPS_CP0_CONFIG7:
-		v = (long)kvm_read_c0_guest_config7(cop0);
-		break;
 	default:
-		return -EINVAL;
+		return vcpu->kvm->arch.ops->get_reg(vcpu, reg);
+
 	}
 	return put_user(v, uaddr);
 }
@@ -638,7 +299,6 @@ static int kvm_mips_set_reg(struct kvm_vcpu *vcpu,
 			    const struct kvm_one_reg *reg)
 {
 	u64 __user *uaddr = (u64 __user *)(long)reg->addr;
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	u64 v;
 
 	if (get_user(v, uaddr) != 0)
@@ -661,41 +321,14 @@ static int kvm_mips_set_reg(struct kvm_vcpu *vcpu,
 		vcpu->arch.epc = v;
 		break;
 
-	case KVM_REG_MIPS_CP0_INDEX:
-		kvm_write_c0_guest_index(cop0, v);
-		break;
-	case KVM_REG_MIPS_CP0_CONTEXT:
-		kvm_write_c0_guest_context(cop0, v);
-		break;
-	case KVM_REG_MIPS_CP0_PAGEMASK:
-		kvm_write_c0_guest_pagemask(cop0, v);
-		break;
-	case KVM_REG_MIPS_CP0_WIRED:
-		kvm_write_c0_guest_wired(cop0, v);
-		break;
-	case KVM_REG_MIPS_CP0_BADVADDR:
-		kvm_write_c0_guest_badvaddr(cop0, v);
-		break;
-	case KVM_REG_MIPS_CP0_ENTRYHI:
-		kvm_write_c0_guest_entryhi(cop0, v);
-		break;
-	case KVM_REG_MIPS_CP0_STATUS:
-		kvm_write_c0_guest_status(cop0, v);
-		break;
-	case KVM_REG_MIPS_CP0_CAUSE:
-		kvm_write_c0_guest_cause(cop0, v);
-		break;
-	case KVM_REG_MIPS_CP0_ERROREPC:
-		kvm_write_c0_guest_errorepc(cop0, v);
-		break;
 	default:
-		return -EINVAL;
+		return vcpu->kvm->arch.ops->set_reg(vcpu, reg, v);
 	}
 	return 0;
 }
 
-long
-kvm_arch_vcpu_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
+long kvm_arch_vcpu_ioctl(struct file *filp, unsigned int ioctl,
+			 unsigned long arg)
 {
 	struct kvm_vcpu *vcpu = filp->private_data;
 	void __user *argp = (void __user *)arg;
@@ -732,28 +365,9 @@ kvm_arch_vcpu_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 			return -EFAULT;
 		return 0;
 	}
-	case KVM_NMI:
-		/* Treat the NMI as a CPU reset */
-		r = kvm_mips_reset_vcpu(vcpu);
-		break;
-	case KVM_INTERRUPT:
-		{
-			struct kvm_mips_interrupt irq;
-			r = -EFAULT;
-			if (copy_from_user(&irq, argp, sizeof(irq)))
-				goto out;
-
-			kvm_debug("[%d] %s: irq: %d\n", vcpu->vcpu_id, __func__,
-				  irq.irq);
-
-			r = kvm_vcpu_ioctl_interrupt(vcpu, &irq);
-			break;
-		}
 	default:
-		r = -ENOIOCTLCMD;
+		r = vcpu->kvm->arch.ops->vcpu_ioctl(vcpu, ioctl, arg);
 	}
-
-out:
 	return r;
 }
 
@@ -807,24 +421,30 @@ long kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 	return r;
 }
 
+int kvm_mips_te_arch_init(void *opaque);
+void kvm_mips_te_arch_exit(void);
+
 int kvm_arch_init(void *opaque)
 {
-	int ret;
-
-	if (kvm_mips_callbacks) {
-		kvm_err("kvm: module already exists\n");
-		return -EEXIST;
-	}
+	return kvm_mips_te_arch_init(opaque);
+}
 
-	ret = kvm_mips_emulation_init(&kvm_mips_callbacks);
+void kvm_arch_exit(void)
+{
+	kvm_mips_te_arch_exit();
+}
 
-	return ret;
+void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
+{
+	vcpu->kvm->arch.ops->vcpu_load(vcpu, cpu);
 }
+EXPORT_SYMBOL(kvm_arch_vcpu_load);
 
-void kvm_arch_exit(void)
+void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 {
-	kvm_mips_callbacks = NULL;
+	vcpu->kvm->arch.ops->vcpu_put(vcpu);
 }
+EXPORT_SYMBOL(kvm_arch_vcpu_put);
 
 int
 kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
@@ -878,37 +498,7 @@ int kvm_dev_ioctl_check_extension(long ext)
 
 int kvm_cpu_has_pending_timer(struct kvm_vcpu *vcpu)
 {
-	return kvm_mips_pending_timer(vcpu);
-}
-
-int kvm_arch_vcpu_dump_regs(struct kvm_vcpu *vcpu)
-{
-	int i;
-	struct mips_coproc *cop0;
-
-	if (!vcpu)
-		return -1;
-
-	printk("VCPU Register Dump:\n");
-	printk("\tepc = 0x%08lx\n", vcpu->arch.epc);;
-	printk("\texceptions: %08lx\n", vcpu->arch.pending_exceptions);
-
-	for (i = 0; i < 32; i += 4) {
-		printk("\tgpr%02d: %08lx %08lx %08lx %08lx\n", i,
-		       vcpu->arch.gprs[i],
-		       vcpu->arch.gprs[i + 1],
-		       vcpu->arch.gprs[i + 2], vcpu->arch.gprs[i + 3]);
-	}
-	printk("\thi: 0x%08lx\n", vcpu->arch.hi);
-	printk("\tlo: 0x%08lx\n", vcpu->arch.lo);
-
-	cop0 = vcpu->arch.cop0;
-	printk("\tStatus: 0x%08lx, Cause: 0x%08lx\n",
-	       kvm_read_c0_guest_status(cop0), kvm_read_c0_guest_cause(cop0));
-
-	printk("\tEPC: 0x%08lx\n", kvm_read_c0_guest_epc(cop0));
-
-	return 0;
+	return vcpu->kvm->arch.ops->cpu_has_pending_timer(vcpu);
 }
 
 int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
@@ -939,40 +529,9 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	return 0;
 }
 
-void kvm_mips_comparecount_func(unsigned long data)
-{
-	struct kvm_vcpu *vcpu = (struct kvm_vcpu *)data;
-
-	kvm_mips_callbacks->queue_timer_int(vcpu);
-
-	vcpu->arch.wait = 0;
-	if (waitqueue_active(&vcpu->wq)) {
-		wake_up_interruptible(&vcpu->wq);
-	}
-}
-
-/*
- * low level hrtimer wake routine.
- */
-enum hrtimer_restart kvm_mips_comparecount_wakeup(struct hrtimer *timer)
-{
-	struct kvm_vcpu *vcpu;
-
-	vcpu = container_of(timer, struct kvm_vcpu, arch.comparecount_timer);
-	kvm_mips_comparecount_func((unsigned long) vcpu);
-	hrtimer_forward_now(&vcpu->arch.comparecount_timer,
-			    ktime_set(0, MS_TO_NS(10)));
-	return HRTIMER_RESTART;
-}
-
 int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
 {
-	kvm_mips_callbacks->vcpu_init(vcpu);
-	hrtimer_init(&vcpu->arch.comparecount_timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_REL);
-	vcpu->arch.comparecount_timer.function = kvm_mips_comparecount_wakeup;
-	kvm_mips_init_shadow_tlb(vcpu);
-	return 0;
+	return vcpu->kvm->arch.ops->vcpu_init(vcpu);
 }
 
 void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu)
@@ -989,208 +548,18 @@ kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu, struct kvm_translation *tr)
 /* Initial guest state */
 int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 {
-	return kvm_mips_callbacks->vcpu_setup(vcpu);
-}
-
-static
-void kvm_mips_set_c0_status(void)
-{
-	uint32_t status = read_c0_status();
-
-	if (cpu_has_fpu)
-		status |= (ST0_CU1);
-
-	if (cpu_has_dsp)
-		status |= (ST0_MX);
-
-	write_c0_status(status);
-	ehb();
-}
-
-/*
- * Return value is in the form (errcode<<2 | RESUME_FLAG_HOST | RESUME_FLAG_NV)
- */
-int kvm_mips_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
-{
-	uint32_t cause = vcpu->arch.host_cp0_cause;
-	uint32_t exccode = (cause >> CAUSEB_EXCCODE) & 0x1f;
-	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.epc;
-	unsigned long badvaddr = vcpu->arch.host_cp0_badvaddr;
-	enum emulation_result er = EMULATE_DONE;
-	int ret = RESUME_GUEST;
-
-	/* Set a default exit reason */
-	run->exit_reason = KVM_EXIT_UNKNOWN;
-	run->ready_for_interrupt_injection = 1;
-
-	/* Set the appropriate status bits based on host CPU features, before we hit the scheduler */
-	kvm_mips_set_c0_status();
-
-	local_irq_enable();
-
-	kvm_debug("kvm_mips_handle_exit: cause: %#x, PC: %p, kvm_run: %p, kvm_vcpu: %p\n",
-			cause, opc, run, vcpu);
-
-	/* Do a privilege check, if in UM most of these exit conditions end up
-	 * causing an exception to be delivered to the Guest Kernel
-	 */
-	er = kvm_mips_check_privilege(cause, opc, run, vcpu);
-	if (er == EMULATE_PRIV_FAIL) {
-		goto skip_emul;
-	} else if (er == EMULATE_FAIL) {
-		run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
-		ret = RESUME_HOST;
-		goto skip_emul;
-	}
-
-	switch (exccode) {
-	case T_INT:
-		kvm_debug("[%d]T_INT @ %p\n", vcpu->vcpu_id, opc);
-
-		++vcpu->stat.int_exits;
-		trace_kvm_exit(vcpu, INT_EXITS);
-
-		if (need_resched()) {
-			cond_resched();
-		}
-
-		ret = RESUME_GUEST;
-		break;
-
-	case T_COP_UNUSABLE:
-		kvm_debug("T_COP_UNUSABLE: @ PC: %p\n", opc);
-
-		++vcpu->stat.cop_unusable_exits;
-		trace_kvm_exit(vcpu, COP_UNUSABLE_EXITS);
-		ret = kvm_mips_callbacks->handle_cop_unusable(vcpu);
-		/* XXXKYMA: Might need to return to user space */
-		if (run->exit_reason == KVM_EXIT_IRQ_WINDOW_OPEN) {
-			ret = RESUME_HOST;
-		}
-		break;
-
-	case T_TLB_MOD:
-		++vcpu->stat.tlbmod_exits;
-		trace_kvm_exit(vcpu, TLBMOD_EXITS);
-		ret = kvm_mips_callbacks->handle_tlb_mod(vcpu);
-		break;
-
-	case T_TLB_ST_MISS:
-		kvm_debug
-		    ("TLB ST fault:  cause %#x, status %#lx, PC: %p, BadVaddr: %#lx\n",
-		     cause, kvm_read_c0_guest_status(vcpu->arch.cop0), opc,
-		     badvaddr);
-
-		++vcpu->stat.tlbmiss_st_exits;
-		trace_kvm_exit(vcpu, TLBMISS_ST_EXITS);
-		ret = kvm_mips_callbacks->handle_tlb_st_miss(vcpu);
-		break;
-
-	case T_TLB_LD_MISS:
-		kvm_debug("TLB LD fault: cause %#x, PC: %p, BadVaddr: %#lx\n",
-			  cause, opc, badvaddr);
-
-		++vcpu->stat.tlbmiss_ld_exits;
-		trace_kvm_exit(vcpu, TLBMISS_LD_EXITS);
-		ret = kvm_mips_callbacks->handle_tlb_ld_miss(vcpu);
-		break;
-
-	case T_ADDR_ERR_ST:
-		++vcpu->stat.addrerr_st_exits;
-		trace_kvm_exit(vcpu, ADDRERR_ST_EXITS);
-		ret = kvm_mips_callbacks->handle_addr_err_st(vcpu);
-		break;
-
-	case T_ADDR_ERR_LD:
-		++vcpu->stat.addrerr_ld_exits;
-		trace_kvm_exit(vcpu, ADDRERR_LD_EXITS);
-		ret = kvm_mips_callbacks->handle_addr_err_ld(vcpu);
-		break;
-
-	case T_SYSCALL:
-		++vcpu->stat.syscall_exits;
-		trace_kvm_exit(vcpu, SYSCALL_EXITS);
-		ret = kvm_mips_callbacks->handle_syscall(vcpu);
-		break;
-
-	case T_RES_INST:
-		++vcpu->stat.resvd_inst_exits;
-		trace_kvm_exit(vcpu, RESVD_INST_EXITS);
-		ret = kvm_mips_callbacks->handle_res_inst(vcpu);
-		break;
-
-	case T_BREAK:
-		++vcpu->stat.break_inst_exits;
-		trace_kvm_exit(vcpu, BREAK_INST_EXITS);
-		ret = kvm_mips_callbacks->handle_break(vcpu);
-		break;
-
-	default:
-		kvm_err
-		    ("Exception Code: %d, not yet handled, @ PC: %p, inst: 0x%08x  BadVaddr: %#lx Status: %#lx\n",
-		     exccode, opc, kvm_get_inst(opc, vcpu), badvaddr,
-		     kvm_read_c0_guest_status(vcpu->arch.cop0));
-		kvm_arch_vcpu_dump_regs(vcpu);
-		run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
-		ret = RESUME_HOST;
-		break;
-
-	}
-
-skip_emul:
-	local_irq_disable();
-
-	if (er == EMULATE_DONE && !(ret & RESUME_HOST))
-		kvm_mips_deliver_interrupts(vcpu, cause);
-
-	if (!(ret & RESUME_HOST)) {
-		/* Only check for signals if not already exiting to userspace  */
-		if (signal_pending(current)) {
-			run->exit_reason = KVM_EXIT_INTR;
-			ret = (-EINTR << 2) | RESUME_HOST;
-			++vcpu->stat.signal_exits;
-			trace_kvm_exit(vcpu, SIGNAL_EXITS);
-		}
-	}
-
-	return ret;
+	return vcpu->kvm->arch.ops->vcpu_setup(vcpu);
 }
 
 int __init kvm_mips_init(void)
 {
-	int ret;
-
-	ret = kvm_init(NULL, sizeof(struct kvm_vcpu), 0, THIS_MODULE);
-
-	if (ret)
-		return ret;
-
-	/* On MIPS, kernel modules are executed from "mapped space", which requires TLBs.
-	 * The TLB handling code is statically linked with the rest of the kernel (kvm_tlb.c)
-	 * to avoid the possibility of double faulting. The issue is that the TLB code
-	 * references routines that are part of the the KVM module,
-	 * which are only available once the module is loaded.
-	 */
-	kvm_mips_gfn_to_pfn = gfn_to_pfn;
-	kvm_mips_release_pfn_clean = kvm_release_pfn_clean;
-	kvm_mips_is_error_pfn = is_error_pfn;
-
-	pr_info("KVM/MIPS Initialized\n");
-	return 0;
+	return kvm_init(NULL, sizeof(struct kvm_vcpu), 0, THIS_MODULE);
 }
 
 void __exit kvm_mips_exit(void)
 {
 	kvm_exit();
-
-	kvm_mips_gfn_to_pfn = NULL;
-	kvm_mips_release_pfn_clean = NULL;
-	kvm_mips_is_error_pfn = NULL;
-
-	pr_info("KVM/MIPS unloaded\n");
 }
 
 module_init(kvm_mips_init);
 module_exit(kvm_mips_exit);
-
-EXPORT_TRACEPOINT_SYMBOL(kvm_exit);
diff --git a/arch/mips/kvm/kvm_mips_comm.h b/arch/mips/kvm/kvm_mips_comm.h
index a4a8c85..d087c5c 100644
--- a/arch/mips/kvm/kvm_mips_comm.h
+++ b/arch/mips/kvm/kvm_mips_comm.h
@@ -11,6 +11,7 @@
 
 #ifndef __KVM_MIPS_COMMPAGE_H__
 #define __KVM_MIPS_COMMPAGE_H__
+#include <asm/kvm_mips_te.h>
 
 struct kvm_mips_commpage {
 	struct mips_coproc cop0;	/* COP0 state is mapped into Guest kernel via commpage */
diff --git a/arch/mips/kvm/kvm_mips_commpage.c b/arch/mips/kvm/kvm_mips_commpage.c
index 3873b1e..2734348 100644
--- a/arch/mips/kvm/kvm_mips_commpage.c
+++ b/arch/mips/kvm/kvm_mips_commpage.c
@@ -22,16 +22,19 @@
 
 #include <linux/kvm_host.h>
 
+#include <asm/kvm_mips_te.h>
+
 #include "kvm_mips_comm.h"
 
 void kvm_mips_commpage_init(struct kvm_vcpu *vcpu)
 {
-	struct kvm_mips_commpage *page = vcpu->arch.kseg0_commpage;
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
+	struct kvm_mips_commpage *page = vcpu_te->kseg0_commpage;
 	memset(page, 0, sizeof(struct kvm_mips_commpage));
 
 	/* Specific init values for fields */
-	vcpu->arch.cop0 = &page->cop0;
-	memset(vcpu->arch.cop0, 0, sizeof(struct mips_coproc));
+	vcpu_te->cop0 = &page->cop0;
+	memset(vcpu_te->cop0, 0, sizeof(struct mips_coproc));
 
 	return;
 }
diff --git a/arch/mips/kvm/kvm_mips_emul.c b/arch/mips/kvm/kvm_mips_emul.c
index 7cbc3bc..90db96a 100644
--- a/arch/mips/kvm/kvm_mips_emul.c
+++ b/arch/mips/kvm/kvm_mips_emul.c
@@ -28,6 +28,8 @@
 #include <asm/r4kcache.h>
 #define CONFIG_MIPS_MT
 
+#include <asm/kvm_mips_te.h>
+
 #include "kvm_mips_opcode.h"
 #include "kvm_mips_int.h"
 #include "kvm_mips_comm.h"
@@ -234,16 +236,17 @@ enum emulation_result update_pc(struct kvm_vcpu *vcpu, uint32_t cause)
  */
 enum emulation_result kvm_mips_emulate_count(struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
+	struct mips_coproc *cop0 = vcpu_te->cop0;
 	enum emulation_result er = EMULATE_DONE;
 
 	/* If COUNT is enabled */
 	if (!(kvm_read_c0_guest_cause(cop0) & CAUSEF_DC)) {
-		hrtimer_try_to_cancel(&vcpu->arch.comparecount_timer);
-		hrtimer_start(&vcpu->arch.comparecount_timer,
+		hrtimer_try_to_cancel(&vcpu_te->comparecount_timer);
+		hrtimer_start(&vcpu_te->comparecount_timer,
 			      ktime_set(0, MS_TO_NS(10)), HRTIMER_MODE_REL);
 	} else {
-		hrtimer_try_to_cancel(&vcpu->arch.comparecount_timer);
+		hrtimer_try_to_cancel(&vcpu_te->comparecount_timer);
 	}
 
 	return er;
@@ -251,7 +254,8 @@ enum emulation_result kvm_mips_emulate_count(struct kvm_vcpu *vcpu)
 
 enum emulation_result kvm_mips_emul_eret(struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
+	struct mips_coproc *cop0 = vcpu_te->cop0;
 	enum emulation_result er = EMULATE_DONE;
 
 	if (kvm_read_c0_guest_status(cop0) & ST0_EXL) {
@@ -274,15 +278,16 @@ enum emulation_result kvm_mips_emul_eret(struct kvm_vcpu *vcpu)
 
 enum emulation_result kvm_mips_emul_wait(struct kvm_vcpu *vcpu)
 {
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
 	enum emulation_result er = EMULATE_DONE;
 
 	kvm_debug("[%#lx] !!!WAIT!!! (%#lx)\n", vcpu->arch.epc,
-		  vcpu->arch.pending_exceptions);
+		  vcpu_te->pending_exceptions);
 
 	++vcpu->stat.wait_exits;
 	trace_kvm_exit(vcpu, WAIT_EXITS);
-	if (!vcpu->arch.pending_exceptions) {
-		vcpu->arch.wait = 1;
+	if (!vcpu_te->pending_exceptions) {
+		vcpu_te->wait = 1;
 		kvm_vcpu_block(vcpu);
 
 		/* We we are runnable, then definitely go off to user space to check if any
@@ -302,7 +307,8 @@ enum emulation_result kvm_mips_emul_wait(struct kvm_vcpu *vcpu)
  */
 enum emulation_result kvm_mips_emul_tlbr(struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
+	struct mips_coproc *cop0 = vcpu_te->cop0;
 	enum emulation_result er = EMULATE_FAIL;
 	uint32_t pc = vcpu->arch.epc;
 
@@ -313,7 +319,8 @@ enum emulation_result kvm_mips_emul_tlbr(struct kvm_vcpu *vcpu)
 /* Write Guest TLB Entry @ Index */
 enum emulation_result kvm_mips_emul_tlbwi(struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
+	struct mips_coproc *cop0 = vcpu_te->cop0;
 	int index = kvm_read_c0_guest_index(cop0);
 	enum emulation_result er = EMULATE_DONE;
 	struct kvm_mips_tlb *tlb = NULL;
@@ -330,7 +337,7 @@ enum emulation_result kvm_mips_emul_tlbwi(struct kvm_vcpu *vcpu)
 		index = (index & ~0x80000000) % KVM_MIPS_GUEST_TLB_SIZE;
 	}
 
-	tlb = &vcpu->arch.guest_tlb[index];
+	tlb = &vcpu_te->guest_tlb[index];
 #if 1
 	/* Probe the shadow host TLB for the entry being overwritten, if one matches, invalidate it */
 	kvm_mips_host_tlb_inv(vcpu, tlb->tlb_hi);
@@ -353,7 +360,8 @@ enum emulation_result kvm_mips_emul_tlbwi(struct kvm_vcpu *vcpu)
 /* Write Guest TLB Entry @ Random Index */
 enum emulation_result kvm_mips_emul_tlbwr(struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
+	struct mips_coproc *cop0 = vcpu_te->cop0;
 	enum emulation_result er = EMULATE_DONE;
 	struct kvm_mips_tlb *tlb = NULL;
 	uint32_t pc = vcpu->arch.epc;
@@ -371,7 +379,7 @@ enum emulation_result kvm_mips_emul_tlbwr(struct kvm_vcpu *vcpu)
 		return EMULATE_FAIL;
 	}
 
-	tlb = &vcpu->arch.guest_tlb[index];
+	tlb = &vcpu_te->guest_tlb[index];
 
 #if 1
 	/* Probe the shadow host TLB for the entry being overwritten, if one matches, invalidate it */
@@ -394,7 +402,8 @@ enum emulation_result kvm_mips_emul_tlbwr(struct kvm_vcpu *vcpu)
 
 enum emulation_result kvm_mips_emul_tlbp(struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
+	struct mips_coproc *cop0 = vcpu_te->cop0;
 	long entryhi = kvm_read_c0_guest_entryhi(cop0);
 	enum emulation_result er = EMULATE_DONE;
 	uint32_t pc = vcpu->arch.epc;
@@ -414,7 +423,8 @@ enum emulation_result
 kvm_mips_emulate_CP0(uint32_t inst, uint32_t *opc, uint32_t cause,
 		     struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
+	struct mips_coproc *cop0 = vcpu_te->cop0;
 	enum emulation_result er = EMULATE_DONE;
 	int32_t rt, rd, copz, sel, co_bit, op;
 	uint32_t pc = vcpu->arch.epc;
@@ -657,6 +667,7 @@ enum emulation_result
 kvm_mips_emulate_store(uint32_t inst, uint32_t cause,
 		       struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
 	enum emulation_result er = EMULATE_DO_MMIO;
 	int32_t op, base, rt, offset;
 	uint32_t bytes;
@@ -685,8 +696,7 @@ kvm_mips_emulate_store(uint32_t inst, uint32_t cause,
 			       run->mmio.len);
 		}
 		run->mmio.phys_addr =
-		    kvm_mips_callbacks->gva_to_gpa(vcpu->arch.
-						   host_cp0_badvaddr);
+		    kvm_mips_callbacks->gva_to_gpa(vcpu_te->host_cp0_badvaddr);
 		if (run->mmio.phys_addr == KVM_INVALID_ADDR) {
 			er = EMULATE_FAIL;
 			break;
@@ -697,7 +707,7 @@ kvm_mips_emulate_store(uint32_t inst, uint32_t cause,
 		vcpu->mmio_is_write = 1;
 		*(u8 *) data = vcpu->arch.gprs[rt];
 		kvm_debug("OP_SB: eaddr: %#lx, gpr: %#lx, data: %#x\n",
-			  vcpu->arch.host_cp0_badvaddr, vcpu->arch.gprs[rt],
+			  vcpu_te->host_cp0_badvaddr, vcpu->arch.gprs[rt],
 			  *(uint8_t *) data);
 
 		break;
@@ -709,8 +719,7 @@ kvm_mips_emulate_store(uint32_t inst, uint32_t cause,
 			       run->mmio.len);
 		}
 		run->mmio.phys_addr =
-		    kvm_mips_callbacks->gva_to_gpa(vcpu->arch.
-						   host_cp0_badvaddr);
+		    kvm_mips_callbacks->gva_to_gpa(vcpu_te->host_cp0_badvaddr);
 		if (run->mmio.phys_addr == KVM_INVALID_ADDR) {
 			er = EMULATE_FAIL;
 			break;
@@ -723,7 +732,7 @@ kvm_mips_emulate_store(uint32_t inst, uint32_t cause,
 		*(uint32_t *) data = vcpu->arch.gprs[rt];
 
 		kvm_debug("[%#lx] OP_SW: eaddr: %#lx, gpr: %#lx, data: %#x\n",
-			  vcpu->arch.epc, vcpu->arch.host_cp0_badvaddr,
+			  vcpu->arch.epc, vcpu_te->host_cp0_badvaddr,
 			  vcpu->arch.gprs[rt], *(uint32_t *) data);
 		break;
 
@@ -734,8 +743,7 @@ kvm_mips_emulate_store(uint32_t inst, uint32_t cause,
 			       run->mmio.len);
 		}
 		run->mmio.phys_addr =
-		    kvm_mips_callbacks->gva_to_gpa(vcpu->arch.
-						   host_cp0_badvaddr);
+		    kvm_mips_callbacks->gva_to_gpa(vcpu_te->host_cp0_badvaddr);
 		if (run->mmio.phys_addr == KVM_INVALID_ADDR) {
 			er = EMULATE_FAIL;
 			break;
@@ -748,7 +756,7 @@ kvm_mips_emulate_store(uint32_t inst, uint32_t cause,
 		*(uint16_t *) data = vcpu->arch.gprs[rt];
 
 		kvm_debug("[%#lx] OP_SH: eaddr: %#lx, gpr: %#lx, data: %#x\n",
-			  vcpu->arch.epc, vcpu->arch.host_cp0_badvaddr,
+			  vcpu->arch.epc, vcpu_te->host_cp0_badvaddr,
 			  vcpu->arch.gprs[rt], *(uint32_t *) data);
 		break;
 
@@ -772,6 +780,7 @@ enum emulation_result
 kvm_mips_emulate_load(uint32_t inst, uint32_t cause,
 		      struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
 	enum emulation_result er = EMULATE_DO_MMIO;
 	int32_t op, base, rt, offset;
 	uint32_t bytes;
@@ -781,8 +790,8 @@ kvm_mips_emulate_load(uint32_t inst, uint32_t cause,
 	offset = inst & 0xffff;
 	op = (inst >> 26) & 0x3f;
 
-	vcpu->arch.pending_load_cause = cause;
-	vcpu->arch.io_gpr = rt;
+	vcpu_te->pending_load_cause = cause;
+	vcpu_te->io_gpr = rt;
 
 	switch (op) {
 	case lw_op:
@@ -794,8 +803,7 @@ kvm_mips_emulate_load(uint32_t inst, uint32_t cause,
 			break;
 		}
 		run->mmio.phys_addr =
-		    kvm_mips_callbacks->gva_to_gpa(vcpu->arch.
-						   host_cp0_badvaddr);
+		    kvm_mips_callbacks->gva_to_gpa(vcpu_te->host_cp0_badvaddr);
 		if (run->mmio.phys_addr == KVM_INVALID_ADDR) {
 			er = EMULATE_FAIL;
 			break;
@@ -817,8 +825,7 @@ kvm_mips_emulate_load(uint32_t inst, uint32_t cause,
 			break;
 		}
 		run->mmio.phys_addr =
-		    kvm_mips_callbacks->gva_to_gpa(vcpu->arch.
-						   host_cp0_badvaddr);
+		    kvm_mips_callbacks->gva_to_gpa(vcpu_te->host_cp0_badvaddr);
 		if (run->mmio.phys_addr == KVM_INVALID_ADDR) {
 			er = EMULATE_FAIL;
 			break;
@@ -846,8 +853,7 @@ kvm_mips_emulate_load(uint32_t inst, uint32_t cause,
 			break;
 		}
 		run->mmio.phys_addr =
-		    kvm_mips_callbacks->gva_to_gpa(vcpu->arch.
-						   host_cp0_badvaddr);
+		    kvm_mips_callbacks->gva_to_gpa(vcpu_te->host_cp0_badvaddr);
 		if (run->mmio.phys_addr == KVM_INVALID_ADDR) {
 			er = EMULATE_FAIL;
 			break;
@@ -877,22 +883,24 @@ int kvm_mips_sync_icache(unsigned long va, struct kvm_vcpu *vcpu)
 {
 	unsigned long offset = (va & ~PAGE_MASK);
 	struct kvm *kvm = vcpu->kvm;
+	struct kvm_mips_te *kvm_mips_te = kvm->arch.impl;
 	unsigned long pa;
 	gfn_t gfn;
 	pfn_t pfn;
 
 	gfn = va >> PAGE_SHIFT;
 
-	if (gfn >= kvm->arch.guest_pmap_npages) {
+	if (gfn >= kvm_mips_te->guest_pmap_npages) {
 		printk("%s: Invalid gfn: %#llx\n", __func__, gfn);
 		kvm_mips_dump_host_tlbs();
-		kvm_arch_vcpu_dump_regs(vcpu);
+		kvm_mips_te_vcpu_dump_regs(vcpu);
 		return -1;
 	}
-	pfn = kvm->arch.guest_pmap[gfn];
+	pfn = kvm_mips_te->guest_pmap[gfn];
 	pa = (pfn << PAGE_SHIFT) | offset;
 
-	printk("%s: va: %#lx, unmapped: %#lx\n", __func__, va, CKSEG0ADDR(pa));
+	printk("%s: va: %#lx, unmapped: %#lx\n", __func__, va,
+	       (unsigned long)CKSEG0ADDR(pa));
 
 	mips32_SyncICache(CKSEG0ADDR(pa), 32);
 	return 0;
@@ -915,7 +923,8 @@ enum emulation_result
 kvm_mips_emulate_cache(uint32_t inst, uint32_t *opc, uint32_t cause,
 		       struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
+	struct mips_coproc *cop0 = vcpu_te->cop0;
 	enum emulation_result er = EMULATE_DONE;
 	int32_t offset, cache, op_inst, op, base;
 	struct kvm_vcpu_arch *arch = &vcpu->arch;
@@ -990,14 +999,14 @@ kvm_mips_emulate_cache(uint32_t inst, uint32_t *opc, uint32_t cause,
 						   (cop0) & ASID_MASK));
 
 		if (index < 0) {
-			vcpu->arch.host_cp0_entryhi = (va & VPN2_MASK);
-			vcpu->arch.host_cp0_badvaddr = va;
+			vcpu_te->host_cp0_entryhi = (va & VPN2_MASK);
+			vcpu_te->host_cp0_badvaddr = va;
 			er = kvm_mips_emulate_tlbmiss_ld(cause, NULL, run,
 							 vcpu);
 			preempt_enable();
 			goto dont_update_pc;
 		} else {
-			struct kvm_mips_tlb *tlb = &vcpu->arch.guest_tlb[index];
+			struct kvm_mips_tlb *tlb = &vcpu_te->guest_tlb[index];
 			/* Check if the entry is valid, if not then setup a TLB invalid exception to the guest */
 			if (!TLB_IS_VALID(*tlb, va)) {
 				er = kvm_mips_emulate_tlbinv_ld(cause, NULL,
@@ -1102,7 +1111,7 @@ kvm_mips_emulate_inst(unsigned long cause, uint32_t *opc,
 	default:
 		printk("Instruction emulation not supported (%p/%#x)\n", opc,
 		       inst);
-		kvm_arch_vcpu_dump_regs(vcpu);
+		kvm_mips_te_vcpu_dump_regs(vcpu);
 		er = EMULATE_FAIL;
 		break;
 	}
@@ -1114,7 +1123,8 @@ enum emulation_result
 kvm_mips_emulate_syscall(unsigned long cause, uint32_t *opc,
 			 struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
+	struct mips_coproc *cop0 = vcpu_te->cop0;
 	struct kvm_vcpu_arch *arch = &vcpu->arch;
 	enum emulation_result er = EMULATE_DONE;
 
@@ -1148,10 +1158,11 @@ enum emulation_result
 kvm_mips_emulate_tlbmiss_ld(unsigned long cause, uint32_t *opc,
 			    struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
+	struct mips_coproc *cop0 = vcpu_te->cop0;
 	struct kvm_vcpu_arch *arch = &vcpu->arch;
 	enum emulation_result er = EMULATE_DONE;
-	unsigned long entryhi = (vcpu->arch.  host_cp0_badvaddr & VPN2_MASK) |
+	unsigned long entryhi = (vcpu_te->host_cp0_badvaddr & VPN2_MASK) |
 				(kvm_read_c0_guest_entryhi(cop0) & ASID_MASK);
 
 	if ((kvm_read_c0_guest_status(cop0) & ST0_EXL) == 0) {
@@ -1181,7 +1192,7 @@ kvm_mips_emulate_tlbmiss_ld(unsigned long cause, uint32_t *opc,
 				  (T_TLB_LD_MISS << CAUSEB_EXCCODE));
 
 	/* setup badvaddr, context and entryhi registers for the guest */
-	kvm_write_c0_guest_badvaddr(cop0, vcpu->arch.host_cp0_badvaddr);
+	kvm_write_c0_guest_badvaddr(cop0, vcpu_te->host_cp0_badvaddr);
 	/* XXXKYMA: is the context register used by linux??? */
 	kvm_write_c0_guest_entryhi(cop0, entryhi);
 	/* Blow away the shadow host TLBs */
@@ -1194,11 +1205,12 @@ enum emulation_result
 kvm_mips_emulate_tlbinv_ld(unsigned long cause, uint32_t *opc,
 			   struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
+	struct mips_coproc *cop0 = vcpu_te->cop0;
 	struct kvm_vcpu_arch *arch = &vcpu->arch;
 	enum emulation_result er = EMULATE_DONE;
 	unsigned long entryhi =
-		(vcpu->arch.host_cp0_badvaddr & VPN2_MASK) |
+		(vcpu_te->host_cp0_badvaddr & VPN2_MASK) |
 		(kvm_read_c0_guest_entryhi(cop0) & ASID_MASK);
 
 	if ((kvm_read_c0_guest_status(cop0) & ST0_EXL) == 0) {
@@ -1227,7 +1239,7 @@ kvm_mips_emulate_tlbinv_ld(unsigned long cause, uint32_t *opc,
 				  (T_TLB_LD_MISS << CAUSEB_EXCCODE));
 
 	/* setup badvaddr, context and entryhi registers for the guest */
-	kvm_write_c0_guest_badvaddr(cop0, vcpu->arch.host_cp0_badvaddr);
+	kvm_write_c0_guest_badvaddr(cop0, vcpu_te->host_cp0_badvaddr);
 	/* XXXKYMA: is the context register used by linux??? */
 	kvm_write_c0_guest_entryhi(cop0, entryhi);
 	/* Blow away the shadow host TLBs */
@@ -1240,10 +1252,11 @@ enum emulation_result
 kvm_mips_emulate_tlbmiss_st(unsigned long cause, uint32_t *opc,
 			    struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
+	struct mips_coproc *cop0 = vcpu_te->cop0;
 	struct kvm_vcpu_arch *arch = &vcpu->arch;
 	enum emulation_result er = EMULATE_DONE;
-	unsigned long entryhi = (vcpu->arch.host_cp0_badvaddr & VPN2_MASK) |
+	unsigned long entryhi = (vcpu_te->host_cp0_badvaddr & VPN2_MASK) |
 				(kvm_read_c0_guest_entryhi(cop0) & ASID_MASK);
 
 	if ((kvm_read_c0_guest_status(cop0) & ST0_EXL) == 0) {
@@ -1271,7 +1284,7 @@ kvm_mips_emulate_tlbmiss_st(unsigned long cause, uint32_t *opc,
 				  (T_TLB_ST_MISS << CAUSEB_EXCCODE));
 
 	/* setup badvaddr, context and entryhi registers for the guest */
-	kvm_write_c0_guest_badvaddr(cop0, vcpu->arch.host_cp0_badvaddr);
+	kvm_write_c0_guest_badvaddr(cop0, vcpu_te->host_cp0_badvaddr);
 	/* XXXKYMA: is the context register used by linux??? */
 	kvm_write_c0_guest_entryhi(cop0, entryhi);
 	/* Blow away the shadow host TLBs */
@@ -1284,10 +1297,11 @@ enum emulation_result
 kvm_mips_emulate_tlbinv_st(unsigned long cause, uint32_t *opc,
 			   struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
+	struct mips_coproc *cop0 = vcpu_te->cop0;
 	struct kvm_vcpu_arch *arch = &vcpu->arch;
 	enum emulation_result er = EMULATE_DONE;
-	unsigned long entryhi = (vcpu->arch.host_cp0_badvaddr & VPN2_MASK) |
+	unsigned long entryhi = (vcpu_te->host_cp0_badvaddr & VPN2_MASK) |
 		(kvm_read_c0_guest_entryhi(cop0) & ASID_MASK);
 
 	if ((kvm_read_c0_guest_status(cop0) & ST0_EXL) == 0) {
@@ -1315,7 +1329,7 @@ kvm_mips_emulate_tlbinv_st(unsigned long cause, uint32_t *opc,
 				  (T_TLB_ST_MISS << CAUSEB_EXCCODE));
 
 	/* setup badvaddr, context and entryhi registers for the guest */
-	kvm_write_c0_guest_badvaddr(cop0, vcpu->arch.host_cp0_badvaddr);
+	kvm_write_c0_guest_badvaddr(cop0, vcpu_te->host_cp0_badvaddr);
 	/* XXXKYMA: is the context register used by linux??? */
 	kvm_write_c0_guest_entryhi(cop0, entryhi);
 	/* Blow away the shadow host TLBs */
@@ -1337,8 +1351,9 @@ kvm_mips_handle_tlbmod(unsigned long cause, uint32_t *opc,
 	 */
 	index = kvm_mips_guest_tlb_lookup(vcpu, entryhi);
 	if (index < 0) {
+		struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
 		/* XXXKYMA Invalidate and retry */
-		kvm_mips_host_tlb_inv(vcpu, vcpu->arch.host_cp0_badvaddr);
+		kvm_mips_host_tlb_inv(vcpu, vcpu_te->host_cp0_badvaddr);
 		kvm_err("%s: host got TLBMOD for %#lx but entry not present in Guest TLB\n",
 		     __func__, entryhi);
 		kvm_mips_dump_guest_tlbs(vcpu);
@@ -1355,8 +1370,9 @@ enum emulation_result
 kvm_mips_emulate_tlbmod(unsigned long cause, uint32_t *opc,
 			struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
-	unsigned long entryhi = (vcpu->arch.host_cp0_badvaddr & VPN2_MASK) |
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
+	struct mips_coproc *cop0 = vcpu_te->cop0;
+	unsigned long entryhi = (vcpu_te->host_cp0_badvaddr & VPN2_MASK) |
 				(kvm_read_c0_guest_entryhi(cop0) & ASID_MASK);
 	struct kvm_vcpu_arch *arch = &vcpu->arch;
 	enum emulation_result er = EMULATE_DONE;
@@ -1384,7 +1400,7 @@ kvm_mips_emulate_tlbmod(unsigned long cause, uint32_t *opc,
 	kvm_change_c0_guest_cause(cop0, (0xff), (T_TLB_MOD << CAUSEB_EXCCODE));
 
 	/* setup badvaddr, context and entryhi registers for the guest */
-	kvm_write_c0_guest_badvaddr(cop0, vcpu->arch.host_cp0_badvaddr);
+	kvm_write_c0_guest_badvaddr(cop0, vcpu_te->host_cp0_badvaddr);
 	/* XXXKYMA: is the context register used by linux??? */
 	kvm_write_c0_guest_entryhi(cop0, entryhi);
 	/* Blow away the shadow host TLBs */
@@ -1397,7 +1413,8 @@ enum emulation_result
 kvm_mips_emulate_fpu_exc(unsigned long cause, uint32_t *opc,
 			 struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
+	struct mips_coproc *cop0 = vcpu_te->cop0;
 	struct kvm_vcpu_arch *arch = &vcpu->arch;
 	enum emulation_result er = EMULATE_DONE;
 
@@ -1426,7 +1443,8 @@ enum emulation_result
 kvm_mips_emulate_ri_exc(unsigned long cause, uint32_t *opc,
 			struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
+	struct mips_coproc *cop0 = vcpu_te->cop0;
 	struct kvm_vcpu_arch *arch = &vcpu->arch;
 	enum emulation_result er = EMULATE_DONE;
 
@@ -1460,7 +1478,8 @@ enum emulation_result
 kvm_mips_emulate_bp_exc(unsigned long cause, uint32_t *opc,
 			struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
+	struct mips_coproc *cop0 = vcpu_te->cop0;
 	struct kvm_vcpu_arch *arch = &vcpu->arch;
 	enum emulation_result er = EMULATE_DONE;
 
@@ -1511,7 +1530,8 @@ enum emulation_result
 kvm_mips_handle_ri(unsigned long cause, uint32_t *opc,
 		   struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
+	struct mips_coproc *cop0 = vcpu_te->cop0;
 	struct kvm_vcpu_arch *arch = &vcpu->arch;
 	enum emulation_result er = EMULATE_DONE;
 	unsigned long curr_pc;
@@ -1595,7 +1615,8 @@ kvm_mips_handle_ri(unsigned long cause, uint32_t *opc,
 enum emulation_result
 kvm_mips_complete_mmio_load(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
-	unsigned long *gpr = &vcpu->arch.gprs[vcpu->arch.io_gpr];
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
+	unsigned long *gpr = &vcpu->arch.gprs[vcpu_te->io_gpr];
 	enum emulation_result er = EMULATE_DONE;
 	unsigned long curr_pc;
 
@@ -1610,7 +1631,7 @@ kvm_mips_complete_mmio_load(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	 * an error and we want to rollback the PC
 	 */
 	curr_pc = vcpu->arch.epc;
-	er = update_pc(vcpu, vcpu->arch.pending_load_cause);
+	er = update_pc(vcpu, vcpu_te->pending_load_cause);
 	if (er == EMULATE_FAIL)
 		return er;
 
@@ -1634,10 +1655,10 @@ kvm_mips_complete_mmio_load(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		break;
 	}
 
-	if (vcpu->arch.pending_load_cause & CAUSEF_BD)
+	if (vcpu_te->pending_load_cause & CAUSEF_BD)
 		kvm_debug
 		    ("[%#lx] Completing %d byte BD Load to gpr %d (0x%08lx) type %d\n",
-		     vcpu->arch.epc, run->mmio.len, vcpu->arch.io_gpr, *gpr,
+		     vcpu->arch.epc, run->mmio.len, vcpu_te->io_gpr, *gpr,
 		     vcpu->mmio_needed);
 
 done:
@@ -1649,7 +1670,8 @@ kvm_mips_emulate_exc(unsigned long cause, uint32_t *opc,
 		     struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
 	uint32_t exccode = (cause >> CAUSEB_EXCCODE) & 0x1f;
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
+	struct mips_coproc *cop0 = vcpu_te->cop0;
 	struct kvm_vcpu_arch *arch = &vcpu->arch;
 	enum emulation_result er = EMULATE_DONE;
 
@@ -1668,7 +1690,7 @@ kvm_mips_emulate_exc(unsigned long cause, uint32_t *opc,
 
 		/* Set PC to the exception entry point */
 		arch->epc = KVM_GUEST_KSEG0 + 0x180;
-		kvm_write_c0_guest_badvaddr(cop0, vcpu->arch.host_cp0_badvaddr);
+		kvm_write_c0_guest_badvaddr(cop0, vcpu_te->host_cp0_badvaddr);
 
 		kvm_debug("Delivering EXC %d @ pc %#lx, badVaddr: %#lx\n",
 			  exccode, kvm_read_c0_guest_epc(cop0),
@@ -1687,7 +1709,8 @@ kvm_mips_check_privilege(unsigned long cause, uint32_t *opc,
 {
 	enum emulation_result er = EMULATE_DONE;
 	uint32_t exccode = (cause >> CAUSEB_EXCCODE) & 0x1f;
-	unsigned long badvaddr = vcpu->arch.host_cp0_badvaddr;
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
+	unsigned long badvaddr = vcpu_te->host_cp0_badvaddr;
 
 	int usermode = !KVM_GUEST_KERNEL_MODE(vcpu);
 
@@ -1771,11 +1794,12 @@ kvm_mips_handle_tlbmiss(unsigned long cause, uint32_t *opc,
 {
 	enum emulation_result er = EMULATE_DONE;
 	uint32_t exccode = (cause >> CAUSEB_EXCCODE) & 0x1f;
-	unsigned long va = vcpu->arch.host_cp0_badvaddr;
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
+	unsigned long va = vcpu_te->host_cp0_badvaddr;
 	int index;
 
 	kvm_debug("kvm_mips_handle_tlbmiss: badvaddr: %#lx, entryhi: %#lx\n",
-		  vcpu->arch.host_cp0_badvaddr, vcpu->arch.host_cp0_entryhi);
+		  vcpu_te->host_cp0_badvaddr, vcpu_te->host_cp0_entryhi);
 
 	/* KVM would not have got the exception if this entry was valid in the shadow host TLB
 	 * Check the Guest TLB, if the entry is not there then send the guest an
@@ -1784,8 +1808,8 @@ kvm_mips_handle_tlbmiss(unsigned long cause, uint32_t *opc,
 	 */
 	index = kvm_mips_guest_tlb_lookup(vcpu,
 					  (va & VPN2_MASK) |
-					  (kvm_read_c0_guest_entryhi
-					   (vcpu->arch.cop0) & ASID_MASK));
+					  (kvm_read_c0_guest_entryhi(vcpu_te->cop0) &
+					   ASID_MASK));
 	if (index < 0) {
 		if (exccode == T_TLB_LD_MISS) {
 			er = kvm_mips_emulate_tlbmiss_ld(cause, opc, run, vcpu);
@@ -1796,7 +1820,7 @@ kvm_mips_handle_tlbmiss(unsigned long cause, uint32_t *opc,
 			er = EMULATE_FAIL;
 		}
 	} else {
-		struct kvm_mips_tlb *tlb = &vcpu->arch.guest_tlb[index];
+		struct kvm_mips_tlb *tlb = &vcpu_te->guest_tlb[index];
 
 		/* Check if the entry is valid, if not then setup a TLB invalid exception to the guest */
 		if (!TLB_IS_VALID(*tlb, va)) {
diff --git a/arch/mips/kvm/kvm_mips_int.c b/arch/mips/kvm/kvm_mips_int.c
index c1ba08b..c7ff6be 100644
--- a/arch/mips/kvm/kvm_mips_int.c
+++ b/arch/mips/kvm/kvm_mips_int.c
@@ -20,25 +20,30 @@
 
 #include <linux/kvm_host.h>
 
+#include <asm/kvm_mips_te.h>
+
 #include "kvm_mips_int.h"
 
-void kvm_mips_queue_irq(struct kvm_vcpu *vcpu, uint32_t priority)
+static void kvm_mips_queue_irq(struct kvm_vcpu *vcpu, uint32_t priority)
 {
-	set_bit(priority, &vcpu->arch.pending_exceptions);
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
+	set_bit(priority, &vcpu_te->pending_exceptions);
 }
 
-void kvm_mips_dequeue_irq(struct kvm_vcpu *vcpu, uint32_t priority)
+static void kvm_mips_dequeue_irq(struct kvm_vcpu *vcpu, uint32_t priority)
 {
-	clear_bit(priority, &vcpu->arch.pending_exceptions);
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
+	clear_bit(priority, &vcpu_te->pending_exceptions);
 }
 
 void kvm_mips_queue_timer_int_cb(struct kvm_vcpu *vcpu)
 {
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
 	/* Cause bits to reflect the pending timer interrupt,
 	 * the EXC code will be set when we are actually
 	 * delivering the interrupt:
 	 */
-	kvm_set_c0_guest_cause(vcpu->arch.cop0, (C_IRQ5 | C_TI));
+	kvm_set_c0_guest_cause(vcpu_te->cop0, (C_IRQ5 | C_TI));
 
 	/* Queue up an INT exception for the core */
 	kvm_mips_queue_irq(vcpu, MIPS_EXC_INT_TIMER);
@@ -47,13 +52,15 @@ void kvm_mips_queue_timer_int_cb(struct kvm_vcpu *vcpu)
 
 void kvm_mips_dequeue_timer_int_cb(struct kvm_vcpu *vcpu)
 {
-	kvm_clear_c0_guest_cause(vcpu->arch.cop0, (C_IRQ5 | C_TI));
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
+	kvm_clear_c0_guest_cause(vcpu_te->cop0, (C_IRQ5 | C_TI));
 	kvm_mips_dequeue_irq(vcpu, MIPS_EXC_INT_TIMER);
 }
 
 void
 kvm_mips_queue_io_int_cb(struct kvm_vcpu *vcpu, struct kvm_mips_interrupt *irq)
 {
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
 	int intr = (int)irq->irq;
 
 	/* Cause bits to reflect the pending IO interrupt,
@@ -62,18 +69,18 @@ kvm_mips_queue_io_int_cb(struct kvm_vcpu *vcpu, struct kvm_mips_interrupt *irq)
 	 */
 	switch (intr) {
 	case 2:
-		kvm_set_c0_guest_cause(vcpu->arch.cop0, (C_IRQ0));
+		kvm_set_c0_guest_cause(vcpu_te->cop0, (C_IRQ0));
 		/* Queue up an INT exception for the core */
 		kvm_mips_queue_irq(vcpu, MIPS_EXC_INT_IO);
 		break;
 
 	case 3:
-		kvm_set_c0_guest_cause(vcpu->arch.cop0, (C_IRQ1));
+		kvm_set_c0_guest_cause(vcpu_te->cop0, (C_IRQ1));
 		kvm_mips_queue_irq(vcpu, MIPS_EXC_INT_IPI_1);
 		break;
 
 	case 4:
-		kvm_set_c0_guest_cause(vcpu->arch.cop0, (C_IRQ2));
+		kvm_set_c0_guest_cause(vcpu_te->cop0, (C_IRQ2));
 		kvm_mips_queue_irq(vcpu, MIPS_EXC_INT_IPI_2);
 		break;
 
@@ -87,20 +94,21 @@ void
 kvm_mips_dequeue_io_int_cb(struct kvm_vcpu *vcpu,
 			   struct kvm_mips_interrupt *irq)
 {
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
 	int intr = (int)irq->irq;
 	switch (intr) {
 	case -2:
-		kvm_clear_c0_guest_cause(vcpu->arch.cop0, (C_IRQ0));
+		kvm_clear_c0_guest_cause(vcpu_te->cop0, (C_IRQ0));
 		kvm_mips_dequeue_irq(vcpu, MIPS_EXC_INT_IO);
 		break;
 
 	case -3:
-		kvm_clear_c0_guest_cause(vcpu->arch.cop0, (C_IRQ1));
+		kvm_clear_c0_guest_cause(vcpu_te->cop0, (C_IRQ1));
 		kvm_mips_dequeue_irq(vcpu, MIPS_EXC_INT_IPI_1);
 		break;
 
 	case -4:
-		kvm_clear_c0_guest_cause(vcpu->arch.cop0, (C_IRQ2));
+		kvm_clear_c0_guest_cause(vcpu_te->cop0, (C_IRQ2));
 		kvm_mips_dequeue_irq(vcpu, MIPS_EXC_INT_IPI_2);
 		break;
 
@@ -119,7 +127,8 @@ kvm_mips_irq_deliver_cb(struct kvm_vcpu *vcpu, unsigned int priority,
 	uint32_t exccode;
 
 	struct kvm_vcpu_arch *arch = &vcpu->arch;
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
+	struct mips_coproc *cop0 = vcpu_te->cop0;
 
 	switch (priority) {
 	case MIPS_EXC_INT_TIMER:
@@ -189,7 +198,7 @@ kvm_mips_irq_deliver_cb(struct kvm_vcpu *vcpu, unsigned int priority,
 		else
 			arch->epc = KVM_GUEST_KSEG0 + 0x180;
 
-		clear_bit(priority, &vcpu->arch.pending_exceptions);
+		clear_bit(priority, &vcpu_te->pending_exceptions);
 	}
 
 	return allowed;
@@ -204,8 +213,9 @@ kvm_mips_irq_clear_cb(struct kvm_vcpu *vcpu, unsigned int priority,
 
 void kvm_mips_deliver_interrupts(struct kvm_vcpu *vcpu, uint32_t cause)
 {
-	unsigned long *pending = &vcpu->arch.pending_exceptions;
-	unsigned long *pending_clr = &vcpu->arch.pending_exceptions_clr;
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
+	unsigned long *pending = &vcpu_te->pending_exceptions;
+	unsigned long *pending_clr = &vcpu_te->pending_exceptions_clr;
 	unsigned int priority;
 
 	if (!(*pending) && !(*pending_clr))
@@ -239,5 +249,6 @@ void kvm_mips_deliver_interrupts(struct kvm_vcpu *vcpu, uint32_t cause)
 
 int kvm_mips_pending_timer(struct kvm_vcpu *vcpu)
 {
-	return test_bit(MIPS_EXC_INT_TIMER, &vcpu->arch.pending_exceptions);
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
+	return test_bit(MIPS_EXC_INT_TIMER, &vcpu_te->pending_exceptions);
 }
diff --git a/arch/mips/kvm/kvm_mips_int.h b/arch/mips/kvm/kvm_mips_int.h
index 20da7d2..08cf7d1 100644
--- a/arch/mips/kvm/kvm_mips_int.h
+++ b/arch/mips/kvm/kvm_mips_int.h
@@ -32,8 +32,6 @@
 #define KVM_MIPS_IRQ_DELIVER_ALL_AT_ONCE (0)
 #define KVM_MIPS_IRQ_CLEAR_ALL_AT_ONCE   (0)
 
-void kvm_mips_queue_irq(struct kvm_vcpu *vcpu, uint32_t priority);
-void kvm_mips_dequeue_irq(struct kvm_vcpu *vcpu, uint32_t priority);
 int kvm_mips_pending_timer(struct kvm_vcpu *vcpu);
 
 void kvm_mips_queue_timer_int_cb(struct kvm_vcpu *vcpu);
diff --git a/arch/mips/kvm/kvm_mips_stats.c b/arch/mips/kvm/kvm_mips_stats.c
index 075904b..5d0c9ef 100644
--- a/arch/mips/kvm/kvm_mips_stats.c
+++ b/arch/mips/kvm/kvm_mips_stats.c
@@ -10,6 +10,7 @@
 */
 
 #include <linux/kvm_host.h>
+#include <asm/kvm_mips_te.h>
 
 char *kvm_mips_exit_types_str[MAX_KVM_MIPS_EXIT_TYPES] = {
 	"WAIT",
@@ -66,14 +67,15 @@ char *kvm_cop0_str[N_MIPS_COPROC_REGS] = {
 int kvm_mips_dump_stats(struct kvm_vcpu *vcpu)
 {
 #ifdef CONFIG_KVM_MIPS_DEBUG_COP0_COUNTERS
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
 	int i, j;
 
 	printk("\nKVM VCPU[%d] COP0 Access Profile:\n", vcpu->vcpu_id);
 	for (i = 0; i < N_MIPS_COPROC_REGS; i++) {
 		for (j = 0; j < N_MIPS_COPROC_SEL; j++) {
-			if (vcpu->arch.cop0->stat[i][j])
+			if (vcpu_te->cop0->stat[i][j])
 				printk("%s[%d]: %lu\n", kvm_cop0_str[i], j,
-				       vcpu->arch.cop0->stat[i][j]);
+				       vcpu_te->cop0->stat[i][j]);
 		}
 	}
 #endif
diff --git a/arch/mips/kvm/kvm_tlb.c b/arch/mips/kvm/kvm_tlb.c
index 5e189be..ffe6088 100644
--- a/arch/mips/kvm/kvm_tlb.c
+++ b/arch/mips/kvm/kvm_tlb.c
@@ -30,6 +30,8 @@
 #include <asm/r4kcache.h>
 #define CONFIG_MIPS_MT
 
+#include <asm/kvm_mips_te.h>
+
 #define KVM_GUEST_PC_TLB    0
 #define KVM_GUEST_SP_TLB    1
 
@@ -53,18 +55,22 @@ EXPORT_SYMBOL(kvm_mips_is_error_pfn);
 
 uint32_t kvm_mips_get_kernel_asid(struct kvm_vcpu *vcpu)
 {
-	return vcpu->arch.guest_kernel_asid[smp_processor_id()] & ASID_MASK;
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
+
+	return vcpu_te->guest_kernel_asid[smp_processor_id()] & ASID_MASK;
 }
 
 
 uint32_t kvm_mips_get_user_asid(struct kvm_vcpu *vcpu)
 {
-	return vcpu->arch.guest_user_asid[smp_processor_id()] & ASID_MASK;
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
+	return  vcpu_te->guest_user_asid[smp_processor_id()] & ASID_MASK;
 }
 
 inline uint32_t kvm_mips_get_commpage_asid (struct kvm_vcpu *vcpu)
 {
-	return vcpu->kvm->arch.commpage_tlb;
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
+	return vcpu_te->kvm_mips_te->commpage_tlb;
 }
 
 
@@ -122,7 +128,9 @@ void kvm_mips_dump_host_tlbs(void)
 
 void kvm_mips_dump_guest_tlbs(struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
+	struct mips_coproc *cop0 = vcpu_te->cop0;
+
 	struct kvm_mips_tlb tlb;
 	int i;
 
@@ -130,7 +138,7 @@ void kvm_mips_dump_guest_tlbs(struct kvm_vcpu *vcpu)
 	printk("Guest EntryHi: %#lx\n", kvm_read_c0_guest_entryhi(cop0));
 
 	for (i = 0; i < KVM_MIPS_GUEST_TLB_SIZE; i++) {
-		tlb = vcpu->arch.guest_tlb[i];
+		tlb = vcpu_te->guest_tlb[i];
 		printk("TLB%c%3d Hi 0x%08lx ",
 		       (tlb.tlb_lo0 | tlb.tlb_lo1) & MIPS3_PG_V ? ' ' : '*',
 		       i, tlb.tlb_hi);
@@ -150,11 +158,12 @@ void kvm_mips_dump_guest_tlbs(struct kvm_vcpu *vcpu)
 void kvm_mips_dump_shadow_tlbs(struct kvm_vcpu *vcpu)
 {
 	int i;
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
 	volatile struct kvm_mips_tlb tlb;
 
 	printk("Shadow TLBs:\n");
 	for (i = 0; i < KVM_MIPS_GUEST_TLB_SIZE; i++) {
-		tlb = vcpu->arch.shadow_tlb[smp_processor_id()][i];
+		tlb = vcpu_te->shadow_tlb[smp_processor_id()][i];
 		printk("TLB%c%3d Hi 0x%08lx ",
 		       (tlb.tlb_lo0 | tlb.tlb_lo1) & MIPS3_PG_V ? ' ' : '*',
 		       i, tlb.tlb_hi);
@@ -173,10 +182,11 @@ void kvm_mips_dump_shadow_tlbs(struct kvm_vcpu *vcpu)
 
 static int kvm_mips_map_page(struct kvm *kvm, gfn_t gfn)
 {
+	struct kvm_mips_te *kvm_mips_te = kvm->arch.impl;
 	int srcu_idx, err = 0;
 	pfn_t pfn;
 
-	if (kvm->arch.guest_pmap[gfn] != KVM_INVALID_PAGE)
+	if (kvm_mips_te->guest_pmap[gfn] != KVM_INVALID_PAGE)
 		return 0;
 
         srcu_idx = srcu_read_lock(&kvm->srcu);
@@ -188,7 +198,7 @@ static int kvm_mips_map_page(struct kvm *kvm, gfn_t gfn)
 		goto out;
 	}
 
-	kvm->arch.guest_pmap[gfn] = pfn;
+	kvm_mips_te->guest_pmap[gfn] = pfn;
 out:
 	srcu_read_unlock(&kvm->srcu, srcu_idx);
 	return err;
@@ -200,7 +210,7 @@ unsigned long kvm_mips_translate_guest_kseg0_to_hpa(struct kvm_vcpu *vcpu,
 {
 	gfn_t gfn;
 	uint32_t offset = gva & ~PAGE_MASK;
-	struct kvm *kvm = vcpu->kvm;
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
 
 	if (KVM_GUEST_KSEGX(gva) != KVM_GUEST_KSEG0) {
 		kvm_err("%s/%p: Invalid gva: %#lx\n", __func__,
@@ -210,7 +220,7 @@ unsigned long kvm_mips_translate_guest_kseg0_to_hpa(struct kvm_vcpu *vcpu,
 
 	gfn = (KVM_GUEST_CPHYSADDR(gva) >> PAGE_SHIFT);
 
-	if (gfn >= kvm->arch.guest_pmap_npages) {
+	if (gfn >= vcpu_te->kvm_mips_te->guest_pmap_npages) {
 		kvm_err("%s: Invalid gfn: %#llx, GVA: %#lx\n", __func__, gfn,
 			gva);
 		return KVM_INVALID_PAGE;
@@ -219,7 +229,7 @@ unsigned long kvm_mips_translate_guest_kseg0_to_hpa(struct kvm_vcpu *vcpu,
 	if (kvm_mips_map_page(vcpu->kvm, gfn) < 0)
 		return KVM_INVALID_ADDR;
 
-	return (kvm->arch.guest_pmap[gfn] << PAGE_SHIFT) + offset;
+	return (vcpu_te->kvm_mips_te->guest_pmap[gfn] << PAGE_SHIFT) + offset;
 }
 
 /* XXXKYMA: Must be called with interrupts disabled */
@@ -301,7 +311,8 @@ int kvm_mips_handle_kseg0_tlb_fault(unsigned long badvaddr,
 	unsigned long vaddr = 0;
 	unsigned long entryhi = 0, entrylo0 = 0, entrylo1 = 0;
 	int even;
-	struct kvm *kvm = vcpu->kvm;
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
+	struct kvm_mips_te *kvm_mips_te = vcpu_te->kvm_mips_te;
 	const int flush_dcache_mask = 0;
 
 
@@ -312,7 +323,7 @@ int kvm_mips_handle_kseg0_tlb_fault(unsigned long badvaddr,
 	}
 
 	gfn = (KVM_GUEST_CPHYSADDR(badvaddr) >> PAGE_SHIFT);
-	if (gfn >= kvm->arch.guest_pmap_npages) {
+	if (gfn >= kvm_mips_te->guest_pmap_npages) {
 		kvm_err("%s: Invalid gfn: %#llx, BadVaddr: %#lx\n", __func__,
 			gfn, badvaddr);
 		kvm_mips_dump_host_tlbs();
@@ -328,11 +339,11 @@ int kvm_mips_handle_kseg0_tlb_fault(unsigned long badvaddr,
 		return -1;
 
 	if (even) {
-		pfn0 = kvm->arch.guest_pmap[gfn];
-		pfn1 = kvm->arch.guest_pmap[gfn ^ 0x1];
+		pfn0 = kvm_mips_te->guest_pmap[gfn];
+		pfn1 = kvm_mips_te->guest_pmap[gfn ^ 0x1];
 	} else {
-		pfn0 = kvm->arch.guest_pmap[gfn ^ 0x1];
-		pfn1 = kvm->arch.guest_pmap[gfn];
+		pfn0 = kvm_mips_te->guest_pmap[gfn ^ 0x1];
+		pfn1 = kvm_mips_te->guest_pmap[gfn];
 	}
 
 	entryhi = (vaddr | kvm_mips_get_kernel_asid(vcpu));
@@ -351,9 +362,10 @@ int kvm_mips_handle_commpage_tlb_fault(unsigned long badvaddr,
 	pfn_t pfn0, pfn1;
 	unsigned long flags, old_entryhi = 0, vaddr = 0;
 	unsigned long entrylo0 = 0, entrylo1 = 0;
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
 
 
-	pfn0 = CPHYSADDR((unsigned long)vcpu->arch.kseg0_commpage) >> PAGE_SHIFT;
+	pfn0 = CPHYSADDR((unsigned long)vcpu_te->kseg0_commpage) >> PAGE_SHIFT;
 	pfn1 = 0;
 	entrylo0 = mips3_paddr_to_tlbpfn(pfn0 << PAGE_SHIFT) | (0x3 << 3) | (1 << 2) |
 			(0x1 << 1);
@@ -395,6 +407,8 @@ kvm_mips_handle_mapped_seg_tlb_fault(struct kvm_vcpu *vcpu,
 	struct kvm_mips_tlb *tlb, unsigned long *hpa0, unsigned long *hpa1)
 {
 	unsigned long entryhi = 0, entrylo0 = 0, entrylo1 = 0;
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
+	struct kvm_mips_te *kvm_mips_te = vcpu_te->kvm_mips_te;
 	struct kvm *kvm = vcpu->kvm;
 	pfn_t pfn0, pfn1;
 
@@ -409,8 +423,8 @@ kvm_mips_handle_mapped_seg_tlb_fault(struct kvm_vcpu *vcpu,
 		if (kvm_mips_map_page(kvm, mips3_tlbpfn_to_paddr(tlb->tlb_lo1) >> PAGE_SHIFT) < 0)
 			return -1;
 
-		pfn0 = kvm->arch.guest_pmap[mips3_tlbpfn_to_paddr(tlb->tlb_lo0) >> PAGE_SHIFT];
-		pfn1 = kvm->arch.guest_pmap[mips3_tlbpfn_to_paddr(tlb->tlb_lo1) >> PAGE_SHIFT];
+		pfn0 = kvm_mips_te->guest_pmap[mips3_tlbpfn_to_paddr(tlb->tlb_lo0) >> PAGE_SHIFT];
+		pfn1 = kvm_mips_te->guest_pmap[mips3_tlbpfn_to_paddr(tlb->tlb_lo1) >> PAGE_SHIFT];
 	}
 
 	if (hpa0)
@@ -440,7 +454,8 @@ int kvm_mips_guest_tlb_lookup(struct kvm_vcpu *vcpu, unsigned long entryhi)
 {
 	int i;
 	int index = -1;
-	struct kvm_mips_tlb *tlb = vcpu->arch.guest_tlb;
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
+	struct kvm_mips_tlb *tlb = vcpu_te->guest_tlb;
 
 
 	for (i = 0; i < KVM_MIPS_GUEST_TLB_SIZE; i++) {
@@ -664,6 +679,7 @@ void kvm_shadow_tlb_put(struct kvm_vcpu *vcpu)
 	unsigned long old_pagemask;
 	int entry = 0;
 	int cpu = smp_processor_id();
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
 
 	local_irq_save(flags);
 
@@ -676,10 +692,10 @@ void kvm_shadow_tlb_put(struct kvm_vcpu *vcpu)
 		tlb_read();
 		tlbw_use_hazard();
 
-		vcpu->arch.shadow_tlb[cpu][entry].tlb_hi = read_c0_entryhi();
-		vcpu->arch.shadow_tlb[cpu][entry].tlb_lo0 = read_c0_entrylo0();
-		vcpu->arch.shadow_tlb[cpu][entry].tlb_lo1 = read_c0_entrylo1();
-		vcpu->arch.shadow_tlb[cpu][entry].tlb_mask = read_c0_pagemask();
+		vcpu_te->shadow_tlb[cpu][entry].tlb_hi = read_c0_entryhi();
+		vcpu_te->shadow_tlb[cpu][entry].tlb_lo0 = read_c0_entrylo0();
+		vcpu_te->shadow_tlb[cpu][entry].tlb_lo1 = read_c0_entrylo1();
+		vcpu_te->shadow_tlb[cpu][entry].tlb_mask = read_c0_pagemask();
 	}
 
 	write_c0_entryhi(old_entryhi);
@@ -696,16 +712,17 @@ void kvm_shadow_tlb_load(struct kvm_vcpu *vcpu)
 	unsigned long old_ctx;
 	int entry;
 	int cpu = smp_processor_id();
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
 
 	local_irq_save(flags);
 
 	old_ctx = read_c0_entryhi();
 
 	for (entry = 0; entry < current_cpu_data.tlbsize; entry++) {
-		write_c0_entryhi(vcpu->arch.shadow_tlb[cpu][entry].tlb_hi);
+		write_c0_entryhi(vcpu_te->shadow_tlb[cpu][entry].tlb_hi);
 		mtc0_tlbw_hazard();
-		write_c0_entrylo0(vcpu->arch.shadow_tlb[cpu][entry].tlb_lo0);
-		write_c0_entrylo1(vcpu->arch.shadow_tlb[cpu][entry].tlb_lo1);
+		write_c0_entrylo0(vcpu_te->shadow_tlb[cpu][entry].tlb_lo0);
+		write_c0_entrylo1(vcpu_te->shadow_tlb[cpu][entry].tlb_lo1);
 
 		write_c0_index(entry);
 		mtc0_tlbw_hazard();
@@ -752,32 +769,34 @@ void kvm_local_flush_tlb_all(void)
 void kvm_mips_init_shadow_tlb(struct kvm_vcpu *vcpu)
 {
 	int cpu, entry;
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
 
 	for_each_possible_cpu(cpu) {
 		for (entry = 0; entry < current_cpu_data.tlbsize; entry++) {
-			vcpu->arch.shadow_tlb[cpu][entry].tlb_hi =
+			vcpu_te->shadow_tlb[cpu][entry].tlb_hi =
 			    UNIQUE_ENTRYHI(entry);
-			vcpu->arch.shadow_tlb[cpu][entry].tlb_lo0 = 0x0;
-			vcpu->arch.shadow_tlb[cpu][entry].tlb_lo1 = 0x0;
-			vcpu->arch.shadow_tlb[cpu][entry].tlb_mask =
+			vcpu_te->shadow_tlb[cpu][entry].tlb_lo0 = 0x0;
+			vcpu_te->shadow_tlb[cpu][entry].tlb_lo1 = 0x0;
+			vcpu_te->shadow_tlb[cpu][entry].tlb_mask =
 			    read_c0_pagemask();
 #ifdef DEBUG
 			kvm_debug
 			    ("shadow_tlb[%d][%d]: tlb_hi: %#lx, lo0: %#lx, lo1: %#lx\n",
 			     cpu, entry,
-			     vcpu->arch.shadow_tlb[cpu][entry].tlb_hi,
-			     vcpu->arch.shadow_tlb[cpu][entry].tlb_lo0,
-			     vcpu->arch.shadow_tlb[cpu][entry].tlb_lo1);
+			     vcpu_te->shadow_tlb[cpu][entry].tlb_hi,
+			     vcpu_te->shadow_tlb[cpu][entry].tlb_lo0,
+			     vcpu_te->shadow_tlb[cpu][entry].tlb_lo1);
 #endif
 		}
 	}
 }
 
 /* Restore ASID once we are scheduled back after preemption */
-void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
+void kvm_mips_te_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
 	unsigned long flags;
 	int newasid = 0;
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
 
 #ifdef DEBUG
 	kvm_debug("%s: vcpu %p, cpu: %d\n", __func__, vcpu, cpu);
@@ -787,27 +806,24 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 	local_irq_save(flags);
 
-	if (((vcpu->arch.
-	      guest_kernel_asid[cpu] ^ asid_cache(cpu)) & ASID_VERSION_MASK)) {
-		kvm_get_new_mmu_context(&vcpu->arch.guest_kernel_mm, cpu, vcpu);
-		vcpu->arch.guest_kernel_asid[cpu] =
-		    vcpu->arch.guest_kernel_mm.context.asid[cpu];
-		kvm_get_new_mmu_context(&vcpu->arch.guest_user_mm, cpu, vcpu);
-		vcpu->arch.guest_user_asid[cpu] =
-		    vcpu->arch.guest_user_mm.context.asid[cpu];
+	if (((vcpu_te->guest_kernel_asid[cpu] ^ asid_cache(cpu)) & ASID_VERSION_MASK)) {
+		kvm_get_new_mmu_context(&vcpu_te->guest_kernel_mm, cpu, vcpu);
+		vcpu_te->guest_kernel_asid[cpu] = vcpu_te->guest_kernel_mm.context.asid[cpu];
+		kvm_get_new_mmu_context(&vcpu_te->guest_user_mm, cpu, vcpu);
+		vcpu_te->guest_user_asid[cpu] =	vcpu_te->guest_user_mm.context.asid[cpu];
 		newasid++;
 
 		kvm_info("[%d]: cpu_context: %#lx\n", cpu,
 			 cpu_context(cpu, current->mm));
 		kvm_info("[%d]: Allocated new ASID for Guest Kernel: %#x\n",
-			 cpu, vcpu->arch.guest_kernel_asid[cpu]);
+			 cpu, vcpu_te->guest_kernel_asid[cpu]);
 		kvm_info("[%d]: Allocated new ASID for Guest User: %#x\n", cpu,
-			 vcpu->arch.guest_user_asid[cpu]);
+			 vcpu_te->guest_user_asid[cpu]);
 	}
 
-	if (vcpu->arch.last_sched_cpu != cpu) {
+	if (vcpu_te->last_sched_cpu != cpu) {
 		kvm_info("[%d->%d]KVM VCPU[%d] switch\n",
-			 vcpu->arch.last_sched_cpu, cpu, vcpu->vcpu_id);
+			 vcpu_te->last_sched_cpu, cpu, vcpu->vcpu_id);
 	}
 
 	/* Only reload shadow host TLB if new ASIDs haven't been allocated */
@@ -821,8 +837,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	if (!newasid) {
 		/* If we preempted while the guest was executing, then reload the pre-empted ASID */
 		if (current->flags & PF_VCPU) {
-			write_c0_entryhi(vcpu->arch.
-					 preempt_entryhi & ASID_MASK);
+			write_c0_entryhi(vcpu_te->preempt_entryhi & ASID_MASK);
 			ehb();
 		}
 	} else {
@@ -834,13 +849,9 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 		 */
 		if (current->flags & PF_VCPU) {
 			if (KVM_GUEST_KERNEL_MODE(vcpu))
-				write_c0_entryhi(vcpu->arch.
-						 guest_kernel_asid[cpu] &
-						 ASID_MASK);
+				write_c0_entryhi(vcpu_te->guest_kernel_asid[cpu] & ASID_MASK);
 			else
-				write_c0_entryhi(vcpu->arch.
-						 guest_user_asid[cpu] &
-						 ASID_MASK);
+				write_c0_entryhi(vcpu_te->guest_user_asid[cpu] & ASID_MASK);
 			ehb();
 		}
 	}
@@ -850,8 +861,9 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 }
 
 /* ASID can change if another task is scheduled during preemption */
-void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
+void kvm_mips_te_vcpu_put(struct kvm_vcpu *vcpu)
 {
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
 	unsigned long flags;
 	uint32_t cpu;
 
@@ -860,8 +872,8 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 	cpu = smp_processor_id();
 
 
-	vcpu->arch.preempt_entryhi = read_c0_entryhi();
-	vcpu->arch.last_sched_cpu = cpu;
+	vcpu_te->preempt_entryhi = read_c0_entryhi();
+	vcpu_te->last_sched_cpu = cpu;
 
 #if 0
 	if ((atomic_read(&kvm_mips_instance) > 1)) {
@@ -883,7 +895,8 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 
 uint32_t kvm_get_inst(uint32_t *opc, struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
+	struct mips_coproc *cop0 = vcpu_te->cop0;
 	unsigned long paddr, flags;
 	uint32_t inst;
 	int index;
@@ -910,8 +923,7 @@ uint32_t kvm_get_inst(uint32_t *opc, struct kvm_vcpu *vcpu)
 				return KVM_INVALID_INST;
 			}
 			kvm_mips_handle_mapped_seg_tlb_fault(vcpu,
-							     &vcpu->arch.
-							     guest_tlb[index],
+							     &vcpu_te->guest_tlb[index],
 							     NULL, NULL);
 			inst = *(opc);
 		}
@@ -945,5 +957,3 @@ EXPORT_SYMBOL(kvm_shadow_tlb_load);
 EXPORT_SYMBOL(kvm_mips_dump_shadow_tlbs);
 EXPORT_SYMBOL(kvm_mips_dump_guest_tlbs);
 EXPORT_SYMBOL(kvm_get_inst);
-EXPORT_SYMBOL(kvm_arch_vcpu_load);
-EXPORT_SYMBOL(kvm_arch_vcpu_put);
diff --git a/arch/mips/kvm/kvm_trap_emul.c b/arch/mips/kvm/kvm_trap_emul.c
index 8d0ab12..80c4ffa 100644
--- a/arch/mips/kvm/kvm_trap_emul.c
+++ b/arch/mips/kvm/kvm_trap_emul.c
@@ -16,8 +16,786 @@
 
 #include <linux/kvm_host.h>
 
+#include <asm/kvm_mips_te.h>
+
 #include "kvm_mips_opcode.h"
 #include "kvm_mips_int.h"
+#include "kvm_mips_comm.h"
+
+#define CREATE_TRACE_POINTS
+#include "trace.h"
+
+#ifndef VECTORSPACING
+#define VECTORSPACING 0x100	/* for EI/VI mode */
+#endif
+
+static int kvm_mips_te_reset_vcpu(struct kvm_vcpu *vcpu)
+{
+	struct kvm_mips_vcpu_te *te = vcpu->arch.impl;
+	int i;
+
+	for_each_possible_cpu(i) {
+		te->guest_kernel_asid[i] = 0;
+		te->guest_user_asid[i] = 0;
+	}
+	return 0;
+}
+
+static int kvm_mips_te_vcpu_runnable(struct kvm_vcpu *vcpu)
+{
+	struct kvm_mips_vcpu_te *te = vcpu->arch.impl;
+	return !!(te->pending_exceptions);
+}
+
+static void kvm_mips_te_init_tlbs(struct kvm *kvm)
+{
+	struct kvm_mips_te *kvm_mips_te = kvm->arch.impl;
+	unsigned long wired;
+
+	/*
+	 * Add a wired entry to the TLB, it is used to map the
+	 * commpage to the Guest kernel
+	 */
+	wired = read_c0_wired();
+	write_c0_wired(wired + 1);
+	mtc0_tlbw_hazard();
+	kvm_mips_te->commpage_tlb = wired;
+
+	kvm_debug("[%d] commpage TLB: %d\n", smp_processor_id(),
+		  kvm_mips_te->commpage_tlb);
+}
+
+static void kvm_mips_te_init_vm_percpu(void *arg)
+{
+	struct kvm *kvm = (struct kvm *)arg;
+
+	kvm_mips_te_init_tlbs(kvm);
+	kvm_mips_callbacks->vm_init(kvm);
+}
+
+static void kvm_mips_te_free_vcpus(struct kvm *kvm)
+{
+	struct kvm_mips_te *kvm_mips_te = kvm->arch.impl;
+	unsigned int i;
+	struct kvm_vcpu *vcpu;
+
+	/* Put the pages we reserved for the guest pmap */
+	for (i = 0; i < kvm_mips_te->guest_pmap_npages; i++) {
+		if (kvm_mips_te->guest_pmap[i] != KVM_INVALID_PAGE)
+			kvm_mips_release_pfn_clean(kvm_mips_te->guest_pmap[i]);
+	}
+
+	kfree(kvm_mips_te->guest_pmap);
+
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		kvm_arch_vcpu_free(vcpu);
+	}
+
+	mutex_lock(&kvm->lock);
+
+	for (i = 0; i < atomic_read(&kvm->online_vcpus); i++)
+		kvm->vcpus[i] = NULL;
+
+	atomic_set(&kvm->online_vcpus, 0);
+
+	mutex_unlock(&kvm->lock);
+}
+
+static void kvm_mips_te_uninit_tlbs(void *arg)
+{
+	/* Restore wired count */
+	write_c0_wired(0);
+	mtc0_tlbw_hazard();
+	/* Clear out all the TLBs */
+	kvm_local_flush_tlb_all();
+}
+
+static void kvm_mips_te_destroy_vm(struct kvm *kvm)
+{
+	kvm_mips_te_free_vcpus(kvm);
+
+	/* If this is the last instance, restore wired count */
+	if (atomic_dec_return(&kvm_mips_instance) == 0) {
+		kvm_info("%s: last KVM instance, restoring TLB parameters\n",
+			 __func__);
+		on_each_cpu(kvm_mips_te_uninit_tlbs, NULL, 1);
+	}
+	kfree(kvm->arch.impl);
+}
+
+static void kvm_mips_te_commit_memory_region(struct kvm *kvm,
+					     struct kvm_userspace_memory_region *mem,
+					     const struct kvm_memory_slot *old,
+					     enum kvm_mr_change change)
+{
+	struct kvm_mips_te *kvm_mips_te = kvm->arch.impl;
+	unsigned long npages = 0;
+	int i, err = 0;
+
+	kvm_debug("%s: kvm: %p slot: %d, GPA: %llx, size: %llx, QVA: %llx\n",
+		  __func__, kvm, mem->slot, mem->guest_phys_addr,
+		  mem->memory_size, mem->userspace_addr);
+
+	/* Setup Guest PMAP table */
+	if (!kvm_mips_te->guest_pmap) {
+		if (mem->slot == 0)
+			npages = mem->memory_size >> PAGE_SHIFT;
+
+		if (npages) {
+			kvm_mips_te->guest_pmap_npages = npages;
+			kvm_mips_te->guest_pmap =
+			    kzalloc(npages * sizeof(unsigned long), GFP_KERNEL);
+
+			if (!kvm_mips_te->guest_pmap) {
+				kvm_err("Failed to allocate guest PMAP");
+				err = -ENOMEM;
+				goto out;
+			}
+
+			kvm_info("Allocated space for Guest PMAP Table (%ld pages) @ %p\n",
+				 npages, kvm_mips_te->guest_pmap);
+
+			/* Now setup the page table */
+			for (i = 0; i < npages; i++)
+				kvm_mips_te->guest_pmap[i] = KVM_INVALID_PAGE;
+		}
+	}
+out:
+	return;
+}
+
+static struct kvm_vcpu *kvm_mips_te_vcpu_create(struct kvm *kvm, unsigned int id)
+{
+	extern char mips32_exception[], mips32_exceptionEnd[];
+	extern char mips32_GuestException[], mips32_GuestExceptionEnd[];
+	int err, size, offset;
+	void *gebase;
+	int i;
+	struct kvm_mips_te *kvm_mips_te = kvm->arch.impl;
+	struct kvm_mips_vcpu_te *vcpu_te;
+	struct kvm_vcpu *vcpu;
+
+	vcpu_te = kzalloc(sizeof(struct kvm_mips_vcpu_te), GFP_KERNEL);
+	if (!vcpu_te) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	vcpu = kzalloc(sizeof(struct kvm_vcpu), GFP_KERNEL);
+	if (!vcpu) {
+		err = -ENOMEM;
+		goto out;
+	}
+	vcpu->arch.impl = vcpu_te;
+	vcpu_te->vcpu = vcpu;
+	vcpu_te->kvm_mips_te = kvm_mips_te;
+
+	err = kvm_vcpu_init(vcpu, kvm, id);
+
+	if (err)
+		goto out_free_cpu;
+
+	kvm_info("kvm @ %p: create cpu %d at %p\n", kvm, id, vcpu);
+
+	/* Allocate space for host mode exception handlers that handle
+	 * guest mode exits
+	 */
+	if (cpu_has_veic || cpu_has_vint)
+		size = 0x200 + VECTORSPACING * 64;
+	else
+		size = 0x200;
+
+	/* Save Linux EBASE */
+	vcpu_te->host_ebase = (void *)(long)(read_c0_ebase() & 0x3ff);
+
+	gebase = kzalloc(ALIGN(size, PAGE_SIZE), GFP_KERNEL);
+
+	if (!gebase) {
+		err = -ENOMEM;
+		goto out_free_cpu;
+	}
+	kvm_info("Allocated %d bytes for KVM Exception Handlers @ %p\n",
+		 ALIGN(size, PAGE_SIZE), gebase);
+
+	/* Save new ebase */
+	vcpu_te->guest_ebase = gebase;
+
+	/* Copy L1 Guest Exception handler to correct offset */
+
+	/* TLB Refill, EXL = 0 */
+	memcpy(gebase, mips32_exception,
+	       mips32_exceptionEnd - mips32_exception);
+
+	/* General Exception Entry point */
+	memcpy(gebase + 0x180, mips32_exception,
+	       mips32_exceptionEnd - mips32_exception);
+
+	/* For vectored interrupts poke the exception code @ all offsets 0-7 */
+	for (i = 0; i < 8; i++) {
+		kvm_debug("L1 Vectored handler @ %p\n",
+			  gebase + 0x200 + (i * VECTORSPACING));
+		memcpy(gebase + 0x200 + (i * VECTORSPACING), mips32_exception,
+		       mips32_exceptionEnd - mips32_exception);
+	}
+
+	/* General handler, relocate to unmapped space for sanity's sake */
+	offset = 0x2000;
+	kvm_info("Installing KVM Exception handlers @ %p, %#x bytes\n",
+		 gebase + offset,
+		 (unsigned)(mips32_GuestExceptionEnd - mips32_GuestException));
+
+	memcpy(gebase + offset, mips32_GuestException,
+	       mips32_GuestExceptionEnd - mips32_GuestException);
+
+	/* Invalidate the icache for these ranges */
+	mips32_SyncICache((unsigned long) gebase, ALIGN(size, PAGE_SIZE));
+
+	/*
+	 * Allocate comm page for guest kernel, a TLB will be reserved
+	 * for mapping GVA @ 0xFFFF8000 to this page
+	 */
+	vcpu_te->kseg0_commpage = kzalloc(PAGE_SIZE << 1, GFP_KERNEL);
+
+	if (!vcpu_te->kseg0_commpage) {
+		err = -ENOMEM;
+		goto out_free_gebase;
+	}
+
+	kvm_info("Allocated COMM page @ %p\n", vcpu_te->kseg0_commpage);
+	kvm_mips_commpage_init(vcpu);
+
+	/* Init */
+	vcpu_te->last_sched_cpu = -1;
+
+	/* Start off the timer */
+	kvm_mips_emulate_count(vcpu);
+
+	return vcpu;
+
+out_free_gebase:
+	kfree(gebase);
+
+out_free_cpu:
+	kfree(vcpu);
+
+out:
+	kfree(vcpu_te);
+	return ERR_PTR(err);
+}
+
+static void kvm_mips_te_vcpu_free(struct kvm_vcpu *vcpu)
+{
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
+	hrtimer_cancel(&vcpu_te->comparecount_timer);
+
+	kvm_vcpu_uninit(vcpu);
+
+	kvm_mips_dump_stats(vcpu);
+
+	kfree(vcpu_te->guest_ebase);
+	kfree(vcpu_te->kseg0_commpage);
+	kfree(vcpu_te);
+}
+
+static int kvm_mips_te_vcpu_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
+{
+	int r = 0;
+	sigset_t sigsaved;
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
+
+	if (vcpu->sigset_active)
+		sigprocmask(SIG_SETMASK, &vcpu->sigset, &sigsaved);
+
+	if (vcpu->mmio_needed) {
+		if (!vcpu->mmio_is_write)
+			kvm_mips_complete_mmio_load(vcpu, run);
+		vcpu->mmio_needed = 0;
+	}
+
+	/* Check if we have any exceptions/interrupts pending */
+	kvm_mips_deliver_interrupts(vcpu,
+				    kvm_read_c0_guest_cause(vcpu_te->cop0));
+
+	local_irq_disable();
+	kvm_guest_enter();
+
+	r = __kvm_mips_vcpu_run(run, vcpu);
+
+	kvm_guest_exit();
+	local_irq_enable();
+
+	if (vcpu->sigset_active)
+		sigprocmask(SIG_SETMASK, &sigsaved, NULL);
+
+	return r;
+}
+
+static int kvm_mips_te_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu,
+					    struct kvm_mips_interrupt *irq)
+{
+	struct kvm_mips_vcpu_te *dvcpu_te;
+	int intr = (int)irq->irq;
+	struct kvm_vcpu *dvcpu = NULL;
+
+	if (intr == 3 || intr == -3 || intr == 4 || intr == -4)
+		kvm_debug("%s: CPU: %d, INTR: %d\n", __func__, irq->cpu,
+			  (int)intr);
+
+	if (irq->cpu == -1)
+		dvcpu = vcpu;
+	else
+		dvcpu = vcpu->kvm->vcpus[irq->cpu];
+
+	if (intr == 2 || intr == 3 || intr == 4) {
+		kvm_mips_callbacks->queue_io_int(dvcpu, irq);
+
+	} else if (intr == -2 || intr == -3 || intr == -4) {
+		kvm_mips_callbacks->dequeue_io_int(dvcpu, irq);
+	} else {
+		kvm_err("%s: invalid interrupt ioctl (%d:%d)\n", __func__,
+			irq->cpu, irq->irq);
+		return -EINVAL;
+	}
+	dvcpu_te = dvcpu->arch.impl;
+	dvcpu_te->wait = 0;
+
+	if (waitqueue_active(&dvcpu->wq))
+		wake_up_interruptible(&dvcpu->wq);
+
+	return 0;
+}
+
+static long kvm_mips_te_vcpu_ioctl(struct kvm_vcpu *vcpu,
+				   unsigned int ioctl,
+				   unsigned long arg)
+{
+	void __user *argp = (void __user *)arg;
+	long r;
+
+	switch (ioctl) {
+	case KVM_NMI:
+		/* Treat the NMI as a CPU reset */
+		r = kvm_mips_te_reset_vcpu(vcpu);
+		break;
+	case KVM_INTERRUPT:
+		{
+			struct kvm_mips_interrupt irq;
+			r = -EFAULT;
+			if (copy_from_user(&irq, argp, sizeof(irq)))
+				goto out;
+
+			kvm_debug("[%d] %s: irq: %d\n", vcpu->vcpu_id, __func__,
+				  irq.irq);
+
+			r = kvm_mips_te_vcpu_ioctl_interrupt(vcpu, &irq);
+			break;
+		}
+	default:
+		r = -ENOIOCTLCMD;
+		break;
+	}
+out:
+	return r;
+}
+
+#define KVM_REG_MIPS_CP0_INDEX (0x10000 + 8 * 0 + 0)
+#define KVM_REG_MIPS_CP0_ENTRYLO0 (0x10000 + 8 * 2 + 0)
+#define KVM_REG_MIPS_CP0_ENTRYLO1 (0x10000 + 8 * 3 + 0)
+#define KVM_REG_MIPS_CP0_CONTEXT (0x10000 + 8 * 4 + 0)
+#define KVM_REG_MIPS_CP0_USERLOCAL (0x10000 + 8 * 4 + 2)
+#define KVM_REG_MIPS_CP0_PAGEMASK (0x10000 + 8 * 5 + 0)
+#define KVM_REG_MIPS_CP0_PAGEGRAIN (0x10000 + 8 * 5 + 1)
+#define KVM_REG_MIPS_CP0_WIRED (0x10000 + 8 * 6 + 0)
+#define KVM_REG_MIPS_CP0_HWRENA (0x10000 + 8 * 7 + 0)
+#define KVM_REG_MIPS_CP0_BADVADDR (0x10000 + 8 * 8 + 0)
+#define KVM_REG_MIPS_CP0_COUNT (0x10000 + 8 * 9 + 0)
+#define KVM_REG_MIPS_CP0_ENTRYHI (0x10000 + 8 * 10 + 0)
+#define KVM_REG_MIPS_CP0_COMPARE (0x10000 + 8 * 11 + 0)
+#define KVM_REG_MIPS_CP0_STATUS (0x10000 + 8 * 12 + 0)
+#define KVM_REG_MIPS_CP0_CAUSE (0x10000 + 8 * 13 + 0)
+#define KVM_REG_MIPS_CP0_EBASE (0x10000 + 8 * 15 + 1)
+#define KVM_REG_MIPS_CP0_CONFIG (0x10000 + 8 * 16 + 0)
+#define KVM_REG_MIPS_CP0_CONFIG1 (0x10000 + 8 * 16 + 1)
+#define KVM_REG_MIPS_CP0_CONFIG2 (0x10000 + 8 * 16 + 2)
+#define KVM_REG_MIPS_CP0_CONFIG3 (0x10000 + 8 * 16 + 3)
+#define KVM_REG_MIPS_CP0_CONFIG7 (0x10000 + 8 * 16 + 7)
+#define KVM_REG_MIPS_CP0_XCONTEXT (0x10000 + 8 * 20 + 0)
+#define KVM_REG_MIPS_CP0_ERROREPC (0x10000 + 8 * 30 + 0)
+
+static int kvm_mips_te_get_reg(struct kvm_vcpu *vcpu,
+			       const struct kvm_one_reg *reg)
+{
+	u64 __user *uaddr = (u64 __user *)(long)reg->addr;
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
+	struct mips_coproc *cop0 = vcpu_te->cop0;
+	s64 v;
+
+	switch (reg->id) {
+	case KVM_REG_MIPS_CP0_INDEX:
+		v = (long)kvm_read_c0_guest_index(cop0);
+		break;
+	case KVM_REG_MIPS_CP0_CONTEXT:
+		v = (long)kvm_read_c0_guest_context(cop0);
+		break;
+	case KVM_REG_MIPS_CP0_PAGEMASK:
+		v = (long)kvm_read_c0_guest_pagemask(cop0);
+		break;
+	case KVM_REG_MIPS_CP0_WIRED:
+		v = (long)kvm_read_c0_guest_wired(cop0);
+		break;
+	case KVM_REG_MIPS_CP0_BADVADDR:
+		v = (long)kvm_read_c0_guest_badvaddr(cop0);
+		break;
+	case KVM_REG_MIPS_CP0_ENTRYHI:
+		v = (long)kvm_read_c0_guest_entryhi(cop0);
+		break;
+	case KVM_REG_MIPS_CP0_STATUS:
+		v = (long)kvm_read_c0_guest_status(cop0);
+		break;
+	case KVM_REG_MIPS_CP0_CAUSE:
+		v = (long)kvm_read_c0_guest_cause(cop0);
+		break;
+	case KVM_REG_MIPS_CP0_ERROREPC:
+		v = (long)kvm_read_c0_guest_errorepc(cop0);
+		break;
+	case KVM_REG_MIPS_CP0_CONFIG:
+		v = (long)kvm_read_c0_guest_config(cop0);
+		break;
+	case KVM_REG_MIPS_CP0_CONFIG1:
+		v = (long)kvm_read_c0_guest_config1(cop0);
+		break;
+	case KVM_REG_MIPS_CP0_CONFIG2:
+		v = (long)kvm_read_c0_guest_config2(cop0);
+		break;
+	case KVM_REG_MIPS_CP0_CONFIG3:
+		v = (long)kvm_read_c0_guest_config3(cop0);
+		break;
+	case KVM_REG_MIPS_CP0_CONFIG7:
+		v = (long)kvm_read_c0_guest_config7(cop0);
+		break;
+	default:
+		return -EINVAL;
+	}
+	return put_user(v, uaddr);
+}
+
+static int kvm_mips_te_set_reg(struct kvm_vcpu *vcpu,
+			       const struct kvm_one_reg *reg,
+			       u64 v)
+{
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
+	struct mips_coproc *cop0 = vcpu_te->cop0;
+
+	switch (reg->id) {
+	case KVM_REG_MIPS_CP0_INDEX:
+		kvm_write_c0_guest_index(cop0, v);
+		break;
+	case KVM_REG_MIPS_CP0_CONTEXT:
+		kvm_write_c0_guest_context(cop0, v);
+		break;
+	case KVM_REG_MIPS_CP0_PAGEMASK:
+		kvm_write_c0_guest_pagemask(cop0, v);
+		break;
+	case KVM_REG_MIPS_CP0_WIRED:
+		kvm_write_c0_guest_wired(cop0, v);
+		break;
+	case KVM_REG_MIPS_CP0_BADVADDR:
+		kvm_write_c0_guest_badvaddr(cop0, v);
+		break;
+	case KVM_REG_MIPS_CP0_ENTRYHI:
+		kvm_write_c0_guest_entryhi(cop0, v);
+		break;
+	case KVM_REG_MIPS_CP0_STATUS:
+		kvm_write_c0_guest_status(cop0, v);
+		break;
+	case KVM_REG_MIPS_CP0_CAUSE:
+		kvm_write_c0_guest_cause(cop0, v);
+		break;
+	case KVM_REG_MIPS_CP0_ERROREPC:
+		kvm_write_c0_guest_errorepc(cop0, v);
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+int kvm_mips_te_arch_init(void *opaque)
+{
+	int ret;
+
+	if (kvm_mips_callbacks) {
+		kvm_err("kvm: module already exists\n");
+		return -EEXIST;
+	}
+
+	/*
+	 * On MIPS, kernel modules are executed from "mapped space",
+	 * which requires TLBs.  The TLB handling code is statically
+	 * linked with the rest of the kernel (kvm_tlb.c) to avoid the
+	 * possibility of double faulting. The issue is that the TLB
+	 * code references routines that are part of the the KVM
+	 * module, which are only available once the module is loaded.
+	 */
+	kvm_mips_gfn_to_pfn = gfn_to_pfn;
+	kvm_mips_release_pfn_clean = kvm_release_pfn_clean;
+	kvm_mips_is_error_pfn = is_error_pfn;
+
+	ret = kvm_mips_emulation_init(&kvm_mips_callbacks);
+
+	pr_info("KVM/MIPS Initialized\n");
+
+	return ret;
+}
+
+void kvm_mips_te_arch_exit(void)
+{
+	kvm_mips_callbacks = NULL;
+
+	kvm_mips_gfn_to_pfn = NULL;
+	kvm_mips_release_pfn_clean = NULL;
+	kvm_mips_is_error_pfn = NULL;
+
+	pr_info("KVM/MIPS unloaded\n");
+}
+
+int kvm_mips_te_vcpu_dump_regs(struct kvm_vcpu *vcpu)
+{
+	int i;
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
+	struct mips_coproc *cop0 = vcpu_te->cop0;
+
+	if (!vcpu)
+		return -1;
+
+	printk("VCPU Register Dump:\n");
+	printk("\tepc = 0x%08lx\n", vcpu->arch.epc);;
+	printk("\texceptions: %08lx\n", vcpu_te->pending_exceptions);
+
+	for (i = 0; i < 32; i += 4) {
+		printk("\tgpr%02d: %08lx %08lx %08lx %08lx\n", i,
+		       vcpu->arch.gprs[i],
+		       vcpu->arch.gprs[i + 1],
+		       vcpu->arch.gprs[i + 2], vcpu->arch.gprs[i + 3]);
+	}
+	printk("\thi: 0x%08lx\n", vcpu->arch.hi);
+	printk("\tlo: 0x%08lx\n", vcpu->arch.lo);
+
+	printk("\tStatus: 0x%08lx, Cause: 0x%08lx\n",
+	       kvm_read_c0_guest_status(cop0), kvm_read_c0_guest_cause(cop0));
+
+	printk("\tEPC: 0x%08lx\n", kvm_read_c0_guest_epc(cop0));
+
+	return 0;
+}
+
+static void kvm_mips_te_comparecount_func(unsigned long data)
+{
+	struct kvm_vcpu *vcpu = (struct kvm_vcpu *)data;
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
+
+	kvm_mips_callbacks->queue_timer_int(vcpu);
+
+	vcpu_te->wait = 0;
+	if (waitqueue_active(&vcpu->wq))
+		wake_up_interruptible(&vcpu->wq);
+}
+
+/*
+ * low level hrtimer wake routine.
+ */
+static enum hrtimer_restart kvm_mips_te_comparecount_wakeup(struct hrtimer *timer)
+{
+	struct kvm_mips_vcpu_te *vcpu_te;
+
+	vcpu_te = container_of(timer,
+			       struct kvm_mips_vcpu_te,
+			       comparecount_timer);
+	kvm_mips_te_comparecount_func((unsigned long)vcpu_te->vcpu);
+	hrtimer_forward_now(&vcpu_te->comparecount_timer,
+			    ktime_set(0, MS_TO_NS(10)));
+	return HRTIMER_RESTART;
+}
+
+static int kvm_mips_te_vcpu_init(struct kvm_vcpu *vcpu)
+{
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
+
+	kvm_mips_callbacks->vcpu_init(vcpu);
+	hrtimer_init(&vcpu_te->comparecount_timer, CLOCK_MONOTONIC,
+		     HRTIMER_MODE_REL);
+	vcpu_te->comparecount_timer.function = kvm_mips_te_comparecount_wakeup;
+	kvm_mips_init_shadow_tlb(vcpu);
+	return 0;
+}
+
+static int kvm_mips_te_vcpu_setup(struct kvm_vcpu *vcpu)
+{
+	return kvm_mips_callbacks->vcpu_setup(vcpu);
+}
+
+static void kvm_mips_set_c0_status(void)
+{
+	uint32_t status = read_c0_status();
+
+	if (cpu_has_fpu)
+		status |= (ST0_CU1);
+
+	if (cpu_has_dsp)
+		status |= (ST0_MX);
+
+	write_c0_status(status);
+	ehb();
+}
+
+/*
+ * Return value is in the form (errcode<<2 | RESUME_FLAG_HOST | RESUME_FLAG_NV)
+ */
+int kvm_mips_te_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
+{
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
+	uint32_t cause = vcpu_te->host_cp0_cause;
+	uint32_t exccode = (cause >> CAUSEB_EXCCODE) & 0x1f;
+	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.epc;
+	unsigned long badvaddr = vcpu_te->host_cp0_badvaddr;
+	enum emulation_result er = EMULATE_DONE;
+	int ret = RESUME_GUEST;
+
+	/* Set a default exit reason */
+	run->exit_reason = KVM_EXIT_UNKNOWN;
+	run->ready_for_interrupt_injection = 1;
+
+	/*
+	 * Set the appropriate status bits based on host CPU features,
+	 * before we hit the scheduler
+	 */
+	kvm_mips_set_c0_status();
+
+	local_irq_enable();
+
+	kvm_debug("kvm_mips_handle_exit: cause: %#x, PC: %p, kvm_run: %p, kvm_vcpu: %p\n",
+			cause, opc, run, vcpu);
+
+	/* Do a privilege check, if in UM most of these exit conditions end up
+	 * causing an exception to be delivered to the Guest Kernel
+	 */
+	er = kvm_mips_check_privilege(cause, opc, run, vcpu);
+	if (er == EMULATE_PRIV_FAIL) {
+		goto skip_emul;
+	} else if (er == EMULATE_FAIL) {
+		run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+		ret = RESUME_HOST;
+		goto skip_emul;
+	}
+
+	switch (exccode) {
+	case T_INT:
+		kvm_debug("[%d]T_INT @ %p\n", vcpu->vcpu_id, opc);
+
+		++vcpu->stat.int_exits;
+		trace_kvm_exit(vcpu, INT_EXITS);
+
+		if (need_resched())
+			cond_resched();
+
+		ret = RESUME_GUEST;
+		break;
+
+	case T_COP_UNUSABLE:
+		kvm_debug("T_COP_UNUSABLE: @ PC: %p\n", opc);
+
+		++vcpu->stat.cop_unusable_exits;
+		trace_kvm_exit(vcpu, COP_UNUSABLE_EXITS);
+		ret = kvm_mips_callbacks->handle_cop_unusable(vcpu);
+		/* XXXKYMA: Might need to return to user space */
+		if (run->exit_reason == KVM_EXIT_IRQ_WINDOW_OPEN)
+			ret = RESUME_HOST;
+		break;
+
+	case T_TLB_MOD:
+		++vcpu->stat.tlbmod_exits;
+		trace_kvm_exit(vcpu, TLBMOD_EXITS);
+		ret = kvm_mips_callbacks->handle_tlb_mod(vcpu);
+		break;
+
+	case T_TLB_ST_MISS:
+		kvm_debug("TLB ST fault:  cause %#x, status %#lx, PC: %p, BadVaddr: %#lx\n",
+		     cause, kvm_read_c0_guest_status(vcpu_te->cop0), opc,
+		     badvaddr);
+
+		++vcpu->stat.tlbmiss_st_exits;
+		trace_kvm_exit(vcpu, TLBMISS_ST_EXITS);
+		ret = kvm_mips_callbacks->handle_tlb_st_miss(vcpu);
+		break;
+
+	case T_TLB_LD_MISS:
+		kvm_debug("TLB LD fault: cause %#x, PC: %p, BadVaddr: %#lx\n",
+			  cause, opc, badvaddr);
+
+		++vcpu->stat.tlbmiss_ld_exits;
+		trace_kvm_exit(vcpu, TLBMISS_LD_EXITS);
+		ret = kvm_mips_callbacks->handle_tlb_ld_miss(vcpu);
+		break;
+
+	case T_ADDR_ERR_ST:
+		++vcpu->stat.addrerr_st_exits;
+		trace_kvm_exit(vcpu, ADDRERR_ST_EXITS);
+		ret = kvm_mips_callbacks->handle_addr_err_st(vcpu);
+		break;
+
+	case T_ADDR_ERR_LD:
+		++vcpu->stat.addrerr_ld_exits;
+		trace_kvm_exit(vcpu, ADDRERR_LD_EXITS);
+		ret = kvm_mips_callbacks->handle_addr_err_ld(vcpu);
+		break;
+
+	case T_SYSCALL:
+		++vcpu->stat.syscall_exits;
+		trace_kvm_exit(vcpu, SYSCALL_EXITS);
+		ret = kvm_mips_callbacks->handle_syscall(vcpu);
+		break;
+
+	case T_RES_INST:
+		++vcpu->stat.resvd_inst_exits;
+		trace_kvm_exit(vcpu, RESVD_INST_EXITS);
+		ret = kvm_mips_callbacks->handle_res_inst(vcpu);
+		break;
+
+	case T_BREAK:
+		++vcpu->stat.break_inst_exits;
+		trace_kvm_exit(vcpu, BREAK_INST_EXITS);
+		ret = kvm_mips_callbacks->handle_break(vcpu);
+		break;
+
+	default:
+		kvm_err("Exception Code: %d, not yet handled, @ PC: %p, inst: 0x%08x  BadVaddr: %#lx Status: %#lx\n",
+		     exccode, opc, kvm_get_inst(opc, vcpu), badvaddr,
+		     kvm_read_c0_guest_status(vcpu_te->cop0));
+		kvm_mips_te_vcpu_dump_regs(vcpu);
+		run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+		ret = RESUME_HOST;
+		break;
+
+	}
+
+skip_emul:
+	local_irq_disable();
+
+	if (er == EMULATE_DONE && !(ret & RESUME_HOST))
+		kvm_mips_deliver_interrupts(vcpu, cause);
+
+	if (!(ret & RESUME_HOST)) {
+		/* Only check for signals if not already exiting to userspace  */
+		if (signal_pending(current)) {
+			run->exit_reason = KVM_EXIT_INTR;
+			ret = (-EINTR << 2) | RESUME_HOST;
+			++vcpu->stat.signal_exits;
+			trace_kvm_exit(vcpu, SIGNAL_EXITS);
+		}
+	}
+
+	return ret;
+}
 
 static gpa_t kvm_trap_emul_gva_to_gpa_cb(gva_t gva)
 {
@@ -42,9 +820,10 @@ static gpa_t kvm_trap_emul_gva_to_gpa_cb(gva_t gva)
 
 static int kvm_trap_emul_handle_cop_unusable(struct kvm_vcpu *vcpu)
 {
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
 	struct kvm_run *run = vcpu->run;
 	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.epc;
-	unsigned long cause = vcpu->arch.host_cp0_cause;
+	unsigned long cause = vcpu_te->host_cp0_cause;
 	enum emulation_result er = EMULATE_DONE;
 	int ret = RESUME_GUEST;
 
@@ -76,19 +855,19 @@ static int kvm_trap_emul_handle_cop_unusable(struct kvm_vcpu *vcpu)
 
 static int kvm_trap_emul_handle_tlb_mod(struct kvm_vcpu *vcpu)
 {
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
 	struct kvm_run *run = vcpu->run;
 	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.epc;
-	unsigned long badvaddr = vcpu->arch.host_cp0_badvaddr;
-	unsigned long cause = vcpu->arch.host_cp0_cause;
+	unsigned long badvaddr = vcpu_te->host_cp0_badvaddr;
+	u32 cause = vcpu_te->host_cp0_cause;
 	enum emulation_result er = EMULATE_DONE;
 	int ret = RESUME_GUEST;
 
 	if (KVM_GUEST_KSEGX(badvaddr) < KVM_GUEST_KSEG0
 	    || KVM_GUEST_KSEGX(badvaddr) == KVM_GUEST_KSEG23) {
 #ifdef DEBUG
-		kvm_debug
-		    ("USER/KSEG23 ADDR TLB MOD fault: cause %#lx, PC: %p, BadVaddr: %#lx\n",
-		     cause, opc, badvaddr);
+		kvm_debug("USER/KSEG23 ADDR TLB MOD fault: cause %#x, PC: %p, BadVaddr: %#lx\n",
+			  cause, opc, badvaddr);
 #endif
 		er = kvm_mips_handle_tlbmod(cause, opc, run, vcpu);
 
@@ -102,19 +881,17 @@ static int kvm_trap_emul_handle_tlb_mod(struct kvm_vcpu *vcpu)
 		/* XXXKYMA: The guest kernel does not expect to get this fault when we are not
 		 * using HIGHMEM. Need to address this in a HIGHMEM kernel
 		 */
-		printk
-		    ("TLB MOD fault not handled, cause %#lx, PC: %p, BadVaddr: %#lx\n",
-		     cause, opc, badvaddr);
+		printk("TLB MOD fault not handled, cause %#x, PC: %p, BadVaddr: %#lx\n",
+		       cause, opc, badvaddr);
 		kvm_mips_dump_host_tlbs();
-		kvm_arch_vcpu_dump_regs(vcpu);
+		kvm_mips_te_vcpu_dump_regs(vcpu);
 		run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
 		ret = RESUME_HOST;
 	} else {
-		printk
-		    ("Illegal TLB Mod fault address , cause %#lx, PC: %p, BadVaddr: %#lx\n",
-		     cause, opc, badvaddr);
+		printk("Illegal TLB Mod fault address , cause %#x, PC: %p, BadVaddr: %#lx\n",
+		       cause, opc, badvaddr);
 		kvm_mips_dump_host_tlbs();
-		kvm_arch_vcpu_dump_regs(vcpu);
+		kvm_mips_te_vcpu_dump_regs(vcpu);
 		run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
 		ret = RESUME_HOST;
 	}
@@ -123,10 +900,11 @@ static int kvm_trap_emul_handle_tlb_mod(struct kvm_vcpu *vcpu)
 
 static int kvm_trap_emul_handle_tlb_st_miss(struct kvm_vcpu *vcpu)
 {
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
 	struct kvm_run *run = vcpu->run;
 	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.epc;
-	unsigned long badvaddr = vcpu->arch.host_cp0_badvaddr;
-	unsigned long cause = vcpu->arch.host_cp0_cause;
+	unsigned long badvaddr = vcpu_te->host_cp0_badvaddr;
+	u32 cause = vcpu_te->host_cp0_cause;
 	enum emulation_result er = EMULATE_DONE;
 	int ret = RESUME_GUEST;
 
@@ -139,8 +917,7 @@ static int kvm_trap_emul_handle_tlb_st_miss(struct kvm_vcpu *vcpu)
 	} else if (KVM_GUEST_KSEGX(badvaddr) < KVM_GUEST_KSEG0
 		   || KVM_GUEST_KSEGX(badvaddr) == KVM_GUEST_KSEG23) {
 #ifdef DEBUG
-		kvm_debug
-		    ("USER ADDR TLB LD fault: cause %#lx, PC: %p, BadVaddr: %#lx\n",
+		kvm_debug("USER ADDR TLB LD fault: cause %#x, PC: %p, BadVaddr: %#lx\n",
 		     cause, opc, badvaddr);
 #endif
 		er = kvm_mips_handle_tlbmiss(cause, opc, run, vcpu);
@@ -154,17 +931,15 @@ static int kvm_trap_emul_handle_tlb_st_miss(struct kvm_vcpu *vcpu)
 		/* All KSEG0 faults are handled by KVM, as the guest kernel does not
 		 * expect to ever get them
 		 */
-		if (kvm_mips_handle_kseg0_tlb_fault
-		    (vcpu->arch.host_cp0_badvaddr, vcpu) < 0) {
+		if (kvm_mips_handle_kseg0_tlb_fault(vcpu_te->host_cp0_badvaddr, vcpu) < 0) {
 			run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
 			ret = RESUME_HOST;
 		}
 	} else {
-		kvm_err
-		    ("Illegal TLB LD fault address , cause %#lx, PC: %p, BadVaddr: %#lx\n",
-		     cause, opc, badvaddr);
+		kvm_err("Illegal TLB LD fault address , cause %#x, PC: %p, BadVaddr: %#lx\n",
+			cause, opc, badvaddr);
 		kvm_mips_dump_host_tlbs();
-		kvm_arch_vcpu_dump_regs(vcpu);
+		kvm_mips_te_vcpu_dump_regs(vcpu);
 		run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
 		ret = RESUME_HOST;
 	}
@@ -173,10 +948,11 @@ static int kvm_trap_emul_handle_tlb_st_miss(struct kvm_vcpu *vcpu)
 
 static int kvm_trap_emul_handle_tlb_ld_miss(struct kvm_vcpu *vcpu)
 {
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
 	struct kvm_run *run = vcpu->run;
 	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.epc;
-	unsigned long badvaddr = vcpu->arch.host_cp0_badvaddr;
-	unsigned long cause = vcpu->arch.host_cp0_cause;
+	unsigned long badvaddr = vcpu_te->host_cp0_badvaddr;
+	u32 cause = vcpu_te->host_cp0_cause;
 	enum emulation_result er = EMULATE_DONE;
 	int ret = RESUME_GUEST;
 
@@ -208,17 +984,15 @@ static int kvm_trap_emul_handle_tlb_ld_miss(struct kvm_vcpu *vcpu)
 			ret = RESUME_HOST;
 		}
 	} else if (KVM_GUEST_KSEGX(badvaddr) == KVM_GUEST_KSEG0) {
-		if (kvm_mips_handle_kseg0_tlb_fault
-		    (vcpu->arch.host_cp0_badvaddr, vcpu) < 0) {
+		if (kvm_mips_handle_kseg0_tlb_fault(vcpu_te->host_cp0_badvaddr, vcpu) < 0) {
 			run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
 			ret = RESUME_HOST;
 		}
 	} else {
-		printk
-		    ("Illegal TLB ST fault address , cause %#lx, PC: %p, BadVaddr: %#lx\n",
-		     cause, opc, badvaddr);
+		printk("Illegal TLB ST fault address , cause %#x, PC: %p, BadVaddr: %#lx\n",
+		       cause, opc, badvaddr);
 		kvm_mips_dump_host_tlbs();
-		kvm_arch_vcpu_dump_regs(vcpu);
+		kvm_mips_te_vcpu_dump_regs(vcpu);
 		run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
 		ret = RESUME_HOST;
 	}
@@ -227,10 +1001,11 @@ static int kvm_trap_emul_handle_tlb_ld_miss(struct kvm_vcpu *vcpu)
 
 static int kvm_trap_emul_handle_addr_err_st(struct kvm_vcpu *vcpu)
 {
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
 	struct kvm_run *run = vcpu->run;
 	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.epc;
-	unsigned long badvaddr = vcpu->arch.host_cp0_badvaddr;
-	unsigned long cause = vcpu->arch.host_cp0_cause;
+	unsigned long badvaddr = vcpu_te->host_cp0_badvaddr;
+	u32 cause = vcpu_te->host_cp0_cause;
 	enum emulation_result er = EMULATE_DONE;
 	int ret = RESUME_GUEST;
 
@@ -249,9 +1024,8 @@ static int kvm_trap_emul_handle_addr_err_st(struct kvm_vcpu *vcpu)
 			ret = RESUME_HOST;
 		}
 	} else {
-		printk
-		    ("Address Error (STORE): cause %#lx, PC: %p, BadVaddr: %#lx\n",
-		     cause, opc, badvaddr);
+		printk("Address Error (STORE): cause %#x, PC: %p, BadVaddr: %#lx\n",
+		       cause, opc, badvaddr);
 		run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
 		ret = RESUME_HOST;
 	}
@@ -260,10 +1034,11 @@ static int kvm_trap_emul_handle_addr_err_st(struct kvm_vcpu *vcpu)
 
 static int kvm_trap_emul_handle_addr_err_ld(struct kvm_vcpu *vcpu)
 {
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
 	struct kvm_run *run = vcpu->run;
 	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.epc;
-	unsigned long badvaddr = vcpu->arch.host_cp0_badvaddr;
-	unsigned long cause = vcpu->arch.host_cp0_cause;
+	unsigned long badvaddr = vcpu_te->host_cp0_badvaddr;
+	u32 cause = vcpu_te->host_cp0_cause;
 	enum emulation_result er = EMULATE_DONE;
 	int ret = RESUME_GUEST;
 
@@ -281,9 +1056,8 @@ static int kvm_trap_emul_handle_addr_err_ld(struct kvm_vcpu *vcpu)
 			ret = RESUME_HOST;
 		}
 	} else {
-		printk
-		    ("Address Error (LOAD): cause %#lx, PC: %p, BadVaddr: %#lx\n",
-		     cause, opc, badvaddr);
+		printk("Address Error (LOAD): cause %#x, PC: %p, BadVaddr: %#lx\n",
+		       cause, opc, badvaddr);
 		run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
 		ret = RESUME_HOST;
 		er = EMULATE_FAIL;
@@ -293,9 +1067,10 @@ static int kvm_trap_emul_handle_addr_err_ld(struct kvm_vcpu *vcpu)
 
 static int kvm_trap_emul_handle_syscall(struct kvm_vcpu *vcpu)
 {
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
 	struct kvm_run *run = vcpu->run;
 	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.epc;
-	unsigned long cause = vcpu->arch.host_cp0_cause;
+	u32 cause = vcpu_te->host_cp0_cause;
 	enum emulation_result er = EMULATE_DONE;
 	int ret = RESUME_GUEST;
 
@@ -311,9 +1086,10 @@ static int kvm_trap_emul_handle_syscall(struct kvm_vcpu *vcpu)
 
 static int kvm_trap_emul_handle_res_inst(struct kvm_vcpu *vcpu)
 {
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
 	struct kvm_run *run = vcpu->run;
 	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.epc;
-	unsigned long cause = vcpu->arch.host_cp0_cause;
+	u32 cause = vcpu_te->host_cp0_cause;
 	enum emulation_result er = EMULATE_DONE;
 	int ret = RESUME_GUEST;
 
@@ -329,9 +1105,10 @@ static int kvm_trap_emul_handle_res_inst(struct kvm_vcpu *vcpu)
 
 static int kvm_trap_emul_handle_break(struct kvm_vcpu *vcpu)
 {
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
 	struct kvm_run *run = vcpu->run;
 	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.epc;
-	unsigned long cause = vcpu->arch.host_cp0_cause;
+	u32 cause = vcpu_te->host_cp0_cause;
 	enum emulation_result er = EMULATE_DONE;
 	int ret = RESUME_GUEST;
 
@@ -357,7 +1134,8 @@ static int kvm_trap_emul_vcpu_init(struct kvm_vcpu *vcpu)
 
 static int kvm_trap_emul_vcpu_setup(struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct kvm_mips_vcpu_te *vcpu_te = vcpu->arch.impl;
+	struct mips_coproc *cop0 = vcpu_te->cop0;
 	uint32_t config1;
 	int vcpu_id = vcpu->vcpu_id;
 
@@ -430,3 +1208,45 @@ int kvm_mips_emulation_init(struct kvm_mips_callbacks **install_callbacks)
 	*install_callbacks = &kvm_trap_emul_callbacks;
 	return 0;
 }
+
+static long kvm_mips_te_vm_ioctl(struct kvm *kvm, unsigned int ioctl,
+				 unsigned long arg)
+{
+	return -ENOIOCTLCMD;
+}
+
+static const struct kvm_mips_ops kvm_mips_te_ops = {
+	.vcpu_runnable = kvm_mips_te_vcpu_runnable,
+	.destroy_vm = kvm_mips_te_destroy_vm,
+	.commit_memory_region = kvm_mips_te_commit_memory_region,
+	.vcpu_create = kvm_mips_te_vcpu_create,
+	.vcpu_free = kvm_mips_te_vcpu_free,
+	.vcpu_run = kvm_mips_te_vcpu_run,
+	.vm_ioctl = kvm_mips_te_vm_ioctl,
+	.vcpu_ioctl = kvm_mips_te_vcpu_ioctl,
+	.get_reg = kvm_mips_te_get_reg,
+	.set_reg = kvm_mips_te_set_reg,
+	.cpu_has_pending_timer = kvm_mips_pending_timer,
+	.vcpu_init = kvm_mips_te_vcpu_init,
+	.vcpu_setup = kvm_mips_te_vcpu_setup,
+	.vcpu_load = kvm_mips_te_vcpu_load,
+	.vcpu_put = kvm_mips_te_vcpu_put,
+};
+
+int kvm_mips_te_init_vm(struct kvm *kvm, unsigned long type)
+{
+	kvm->arch.ops = &kvm_mips_te_ops;
+	kvm->arch.impl =  kzalloc(sizeof(struct kvm_mips_te), GFP_KERNEL);
+	if (!kvm->arch.impl)
+		return -ENOMEM;
+
+	if (atomic_inc_return(&kvm_mips_instance) == 1) {
+		kvm_info("%s: 1st KVM instance, setup host TLB parameters\n",
+			 __func__);
+		on_each_cpu(kvm_mips_te_init_vm_percpu, kvm, 1);
+	}
+	return 0;
+}
+
+
+EXPORT_TRACEPOINT_SYMBOL(kvm_exit);
-- 
1.7.11.7
