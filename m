Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2012 16:22:30 +0100 (CET)
Received: from kymasys.com ([64.62.140.43]:57398 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6822164Ab2JaPSdIhWLP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 Oct 2012 16:18:33 +0100
Received: from ::ffff:173.33.185.184 ([173.33.185.184]) by kymasys.com for <linux-mips@linux-mips.org>; Wed, 31 Oct 2012 08:18:24 -0700
From:   Sanjay Lal <sanjayl@kymasys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Subject: [PATCH 02/20] KVM/MIPS32: Arch specific KVM data structures.
Date:   Wed, 31 Oct 2012 11:18:21 -0400
Message-Id: <54507365-0EF7-480A-8A54-75E12B3677D9@kymasys.com>
To:     kvm@vger.kernel.org, linux-mips@linux-mips.org
Mime-Version: 1.0 (Apple Message framework v1283)
X-Mailer: Apple Mail (2.1283)
X-archive-position: 34817
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sanjayl@kymasys.com
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


Signed-off-by: Sanjay Lal <sanjayl@kymasys.com>
---
 arch/mips/include/asm/kvm.h      |  58 ++++
 arch/mips/include/asm/kvm_host.h | 672 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 730 insertions(+)
 create mode 100644 arch/mips/include/asm/kvm.h
 create mode 100644 arch/mips/include/asm/kvm_host.h

diff --git a/arch/mips/include/asm/kvm.h b/arch/mips/include/asm/kvm.h
new file mode 100644
index 0000000..39bb715
--- /dev/null
+++ b/arch/mips/include/asm/kvm.h
@@ -0,0 +1,58 @@
+/*
+* This file is subject to the terms and conditions of the GNU General Public
+* License.  See the file "COPYING" in the main directory of this archive
+* for more details.
+*
+*
+* Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
+* Authors: Sanjay Lal <sanjayl@kymasys.com>
+*/
+
+
+#ifndef __LINUX_KVM_MIPS_H
+#define __LINUX_KVM_MIPS_H
+
+#include <linux/types.h>
+
+#define __KVM_MIPS
+
+#define N_MIPS_COPROC_REGS      32
+#define N_MIPS_COPROC_SEL   	8
+
+/* for KVM_GET_REGS and KVM_SET_REGS */
+struct kvm_regs {
+    __u32 gprs[32];
+    __u32 hi;
+    __u32 lo;
+    __u32 pc;
+
+    ulong cp0reg[N_MIPS_COPROC_REGS][N_MIPS_COPROC_SEL];
+};
+
+/* for KVM_GET_SREGS and KVM_SET_SREGS */
+struct kvm_sregs {
+};
+
+/* for KVM_GET_FPU and KVM_SET_FPU */
+struct kvm_fpu {
+};
+
+struct kvm_debug_exit_arch {
+};
+
+/* for KVM_SET_GUEST_DEBUG */
+struct kvm_guest_debug_arch {
+};
+
+struct kvm_mips_interrupt {
+    /* in */
+    __u32 cpu;
+    __u32 irq;
+};
+
+/* definition of registers in kvm_run */
+struct kvm_sync_regs {
+};
+
+#endif /* __LINUX_KVM_MIPS_H */
diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
new file mode 100644
index 0000000..0352106
--- /dev/null
+++ b/arch/mips/include/asm/kvm_host.h
@@ -0,0 +1,672 @@
+/*
+* This file is subject to the terms and conditions of the GNU General Public
+* License.  See the file "COPYING" in the main directory of this archive
+* for more details.
+*
+* PUT YOUR TITLE AND/OR INFORMATION FOR THE FILE HERE
+*
+* Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
+* Authors: Sanjay Lal <sanjayl@kymasys.com>
+*/
+
+#ifndef __MIPS_KVM_HOST_H__
+#define __MIPS_KVM_HOST_H__
+
+#include <linux/mutex.h>
+#include <linux/hrtimer.h>
+#include <linux/interrupt.h>
+#include <linux/types.h>
+#include <linux/kvm_types.h>
+#include <linux/threads.h>
+#include <linux/spinlock.h>
+
+#define KVM_MAX_VCPUS 8
+#define KVM_MEMORY_SLOTS 32
+/* memory slots that does not exposed to userspace */
+#define KVM_PRIVATE_MEM_SLOTS 4
+
+#define KVM_COALESCED_MMIO_PAGE_OFFSET 1
+
+/* Don't support huge pages */
+#define KVM_HPAGE_GFN_SHIFT(x)  0
+
+/* We don't currently support large pages. */
+#define KVM_NR_PAGE_SIZES	1
+#define KVM_PAGES_PER_HPAGE(x)  1
+
+#define ENTER_CRITICAL(flags)   local_irq_save(flags)
+#define EXIT_CRITICAL(flags)    local_irq_restore(flags)
+
+
+#define KVM_GUEST_KERNEL_ASID  ((vcpu->arch.guest_kernel_asid[smp_processor_id()]) & ASID_MASK)
+
+#define KVM_GUEST_USER_ASID		((vcpu->arch.guest_user_asid[smp_processor_id()]) & ASID_MASK)
+
+
+#define KVM_GUEST_WIRED_TLBS    (current_cpu_data.tlbsize)
+#define KVM_GUEST_COMMPAGE_TLB  (vcpu->kvm->arch.commpage_tlb)
+#define KVM_GUEST_TLBS          KVM_GUEST_WIRED_TLBS
+
+/* Special address that contains the comm page, used for reducing # of traps */
+#define KVM_GUEST_COMMPAGE_ADDR     0x0
+
+#define KVM_GUEST_KERNEL_MODE(vcpu)     ((kvm_read_c0_guest_status(vcpu->arch.cop0) & (ST0_EXL | ST0_ERL)) || \
+                                        ((kvm_read_c0_guest_status(vcpu->arch.cop0) & KSU_USER) == 0))
+
+#define KVM_GUEST_KUSEG             0x00000000UL
+#define KVM_GUEST_KSEG0             0x40000000UL
+#define KVM_GUEST_KSEG23            0x60000000UL
+#define KVM_GUEST_KSEGX(a)          ((_ACAST32_(a)) & 0x60000000)
+#define KVM_GUEST_CPHYSADDR(a)      ((_ACAST32_(a)) & 0x1fffffff)
+
+#define KVM_GUEST_CKSEG0ADDR(a)		(KVM_GUEST_CPHYSADDR(a) | KVM_GUEST_KSEG0)
+#define KVM_GUEST_CKSEG1ADDR(a)		(KVM_GUEST_CPHYSADDR(a) | KVM_GUEST_KSEG1)
+#define KVM_GUEST_CKSEG23ADDR(a)	(KVM_GUEST_CPHYSADDR(a) | KVM_GUEST_KSEG23)
+
+/*
+ * Map an address to a certain kernel segment
+ */
+#define KVM_GUEST_KSEG0ADDR(a)		(KVM_GUEST_CPHYSADDR(a) | KSEG0)
+#define KVM_GUEST_KSEG23ADDR(a)		(KVM_GUEST_CPHYSADDR(a) | KVM_GUEST_KSEG23)
+
+#define KVM_INVALID_PAGE            0xdeadbeef
+#define KVM_INVALID_INST            0xdeadbeef
+#define KVM_INVALID_ADDR            0xdeadbeef
+
+#define KVM_MALTA_GUEST_RTC_ADDR    0xb8000070UL
+
+#ifndef __unused
+#define __unused __attribute__((unused))
+#endif
+
+#define GUEST_TICKS_PER_JIFFY (40000000/HZ)
+#define MS_TO_NS(x) (x * 1E6L)
+
+#define CAUSEB_DC       27
+#define CAUSEF_DC       (_ULCAST_(1)   << 27)
+
+struct kvm;
+struct kvm_run;
+struct kvm_vcpu;
+struct kvm_interrupt;
+
+extern atomic_t kvm_mips_instance;
+
+struct kvm_vm_stat
+{
+    u32 remote_tlb_flush;
+};
+
+struct kvm_vcpu_stat
+{
+	u32 halt_wakeup;
+};
+
+enum kvm_mips_exit_types
+{
+    WAIT_EXITS,
+    CACHE_EXITS,
+    SIGNAL_EXITS,
+    INT_EXITS,
+    COP_UNUSABLE_EXITS,
+    TLBMOD_EXITS,
+    TLBMISS_LD_EXITS,
+    TLBMISS_ST_EXITS,
+    ADDRERR_ST_EXITS,
+    ADDRERR_LD_EXITS,
+    SYSCALL_EXITS,
+    RESVD_INST_EXITS,
+    BREAK_INST_EXITS,
+    FLUSH_DCACHE_EXITS,
+    MAX_KVM_MIPS_EXIT_TYPES
+};
+
+struct kvm_arch_memory_slot {
+};
+
+struct kvm_arch
+{
+    /* Guest GVA->HPA page table */
+    ulong *guest_pmap;
+    ulong guest_pmap_npages;
+
+    /* Wired host TLB used for the commpage */
+    int commpage_tlb;
+
+    pfn_t (*gfn_to_pfn) (struct kvm *kvm, gfn_t gfn);
+    void (*release_pfn_clean) (pfn_t pfn);
+    bool (*is_error_pfn) (pfn_t pfn);
+};
+
+#define N_MIPS_COPROC_REGS      32
+#define N_MIPS_COPROC_SEL   	8
+
+struct mips_coproc
+{
+    ulong reg[N_MIPS_COPROC_REGS][N_MIPS_COPROC_SEL];
+#ifdef CONFIG_KVM_MIPS_DEBUG_COP0_COUNTERS
+    ulong stat[N_MIPS_COPROC_REGS][N_MIPS_COPROC_SEL];
+#endif
+};
+
+/*
+ * Coprocessor 0 register names
+ */
+#define	MIPS_CP0_TLB_INDEX	    0
+#define	MIPS_CP0_TLB_RANDOM	    1
+#define	MIPS_CP0_TLB_LOW	    2
+#define	MIPS_CP0_TLB_LO0	    2
+#define	MIPS_CP0_TLB_LO1	    3
+#define	MIPS_CP0_TLB_CONTEXT	4
+#define	MIPS_CP0_TLB_PG_MASK	5
+#define	MIPS_CP0_TLB_WIRED	    6
+#define	MIPS_CP0_HWRENA 	    7
+#define	MIPS_CP0_BAD_VADDR	    8
+#define	MIPS_CP0_COUNT	        9
+#define	MIPS_CP0_TLB_HI	        10
+#define	MIPS_CP0_COMPARE	    11
+#define	MIPS_CP0_STATUS	        12
+#define	MIPS_CP0_CAUSE	        13
+#define	MIPS_CP0_EXC_PC	        14
+#define	MIPS_CP0_PRID		    15
+#define	MIPS_CP0_CONFIG	        16
+#define	MIPS_CP0_LLADDR	        17
+#define	MIPS_CP0_WATCH_LO	    18
+#define	MIPS_CP0_WATCH_HI	    19
+#define	MIPS_CP0_TLB_XCONTEXT   20
+#define	MIPS_CP0_ECC		    26
+#define	MIPS_CP0_CACHE_ERR	    27
+#define	MIPS_CP0_TAG_LO	        28
+#define	MIPS_CP0_TAG_HI	        29
+#define	MIPS_CP0_ERROR_PC	    30
+#define	MIPS_CP0_DEBUG	        23
+#define	MIPS_CP0_DEPC		    24
+#define	MIPS_CP0_PERFCNT	    25
+#define	MIPS_CP0_ERRCTL         26
+#define	MIPS_CP0_DATA_LO	    28
+#define	MIPS_CP0_DATA_HI	    29
+#define	MIPS_CP0_DESAVE	        31
+
+#define MIPS_CP0_CONFIG_SEL	    0
+#define MIPS_CP0_CONFIG1_SEL    1
+#define MIPS_CP0_CONFIG2_SEL    2
+#define MIPS_CP0_CONFIG3_SEL    3
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
+#define MIPS_CONFIG0                                              \
+  ((1 << CP0C0_M) | (0x3 << CP0C0_K0))
+
+/* Have config2, no coprocessor2 attached, no MDMX support attached,
+   no performance counters, watch registers present,
+   no code compression, EJTAG present, no FPU, no watch registers */
+#define MIPS_CONFIG1                                              \
+((1 << CP0C1_M) |                                                 \
+ (0 << CP0C1_C2) | (0 << CP0C1_MD) | (0 << CP0C1_PC) |            \
+ (0 << CP0C1_WR) | (0 << CP0C1_CA) | (1 << CP0C1_EP) |            \
+ (0 << CP0C1_FP))
+
+/* Have config3, no tertiary/secondary caches implemented */
+#define MIPS_CONFIG2                                              \
+((1 << CP0C2_M))
+
+/* No config4, no DSP ASE, no large physaddr (PABITS),
+   no external interrupt controller, no vectored interrupts,
+   no 1kb pages, no SmartMIPS ASE, no trace logic */
+#define MIPS_CONFIG3                                              \
+((0 << CP0C3_M) | (0 << CP0C3_DSPP) | (0 << CP0C3_LPA) |          \
+ (0 << CP0C3_VEIC) | (0 << CP0C3_VInt) | (0 << CP0C3_SP) |        \
+ (0 << CP0C3_SM) | (0 << CP0C3_TL))
+
+/* MMU types, the first four entries have the same layout as the
+   CP0C0_MT field.  */
+enum mips_mmu_types
+{
+    MMU_TYPE_NONE,
+    MMU_TYPE_R4000,
+    MMU_TYPE_RESERVED,
+    MMU_TYPE_FMT,
+    MMU_TYPE_R3000,
+    MMU_TYPE_R6000,
+    MMU_TYPE_R8000
+};
+
+/*
+ * Trap codes
+ */
+#define T_INT           0       /* Interrupt pending */
+#define T_TLB_MOD       1       /* TLB modified fault */
+#define T_TLB_LD_MISS       2   /* TLB miss on load or ifetch */
+#define T_TLB_ST_MISS       3   /* TLB miss on a store */
+#define T_ADDR_ERR_LD       4   /* Address error on a load or ifetch */
+#define T_ADDR_ERR_ST       5   /* Address error on a store */
+#define T_BUS_ERR_IFETCH    6   /* Bus error on an ifetch */
+#define T_BUS_ERR_LD_ST     7   /* Bus error on a load or store */
+#define T_SYSCALL       8       /* System call */
+#define T_BREAK         9       /* Breakpoint */
+#define T_RES_INST      10      /* Reserved instruction exception */
+#define T_COP_UNUSABLE      11  /* Coprocessor unusable */
+#define T_OVFLOW        12      /* Arithmetic overflow */
+
+/*
+ * Trap definitions added for r4000 port.
+ */
+#define T_TRAP          13      /* Trap instruction */
+#define T_VCEI          14      /* Virtual coherency exception */
+#define T_FPE           15      /* Floating point exception */
+#define T_WATCH         23      /* Watch address reference */
+#define T_VCED          31      /* Virtual coherency data */
+
+/* Resume Flags */
+#define RESUME_FLAG_DR          (1<<0)  /* Reload guest nonvolatile state? */
+#define RESUME_FLAG_HOST        (1<<1)  /* Resume host? */
+
+#define RESUME_GUEST            0
+#define RESUME_GUEST_DR         RESUME_FLAG_DR
+#define RESUME_HOST             RESUME_FLAG_HOST
+
+enum emulation_result
+{
+    EMULATE_DONE,               /* no further processing */
+    EMULATE_DO_MMIO,            /* kvm_run filled with MMIO request */
+    EMULATE_FAIL,               /* can't emulate this instruction */
+    EMULATE_WAIT,               /* WAIT instruction */
+    EMULATE_PRIV_FAIL,
+};
+
+#define MIPS3_PG_G  0x00000001  /* Global; ignore ASID if in lo0 & lo1 */
+#define MIPS3_PG_V  0x00000002  /* Valid */
+#define MIPS3_PG_NV 0x00000000
+#define MIPS3_PG_D  0x00000004  /* Dirty */
+
+#define mips3_paddr_to_tlbpfn(x) \
+    (((unsigned long)(x) >> MIPS3_PG_SHIFT) & MIPS3_PG_FRAME)
+#define mips3_tlbpfn_to_paddr(x) \
+    ((unsigned long)((x) & MIPS3_PG_FRAME) << MIPS3_PG_SHIFT)
+
+#define MIPS3_PG_SHIFT      6
+#define MIPS3_PG_FRAME      0x3fffffc0
+
+#define VPN2_MASK           0xffffe000
+#define TLB_IS_GLOBAL(x)    (((x).tlb_lo0 & MIPS3_PG_G) && ((x).tlb_lo1 & MIPS3_PG_G))
+#define TLB_VPN2(x)         ((x).tlb_hi & VPN2_MASK)
+#define TLB_ASID(x)         ((x).tlb_hi & ASID_MASK)
+#define TLB_IS_VALID(x,va)  (((va) & (1 << PAGE_SHIFT)) ? ((x).tlb_lo1 & MIPS3_PG_V) : ((x).tlb_lo0 & MIPS3_PG_V))
+
+
+struct kvm_mips_tlb
+{
+    long tlb_mask;
+    long tlb_hi;
+    long tlb_lo0;
+    long tlb_lo1;
+};
+
+#define KVM_MIPS_GUEST_TLB_SIZE     64
+struct kvm_vcpu_arch
+{
+    void *host_ebase, *guest_ebase;
+    ulong host_stack;
+    ulong host_gp;
+
+    /* Host CP0 registers used when handling exits from guest */
+    ulong host_cp0_badvaddr;
+    ulong host_cp0_cause;
+    ulong host_cp0_epc;
+    ulong host_cp0_entryhi;
+    uint32_t guest_inst;
+
+    /* GPRS */
+    ulong gprs[32];
+    ulong hi;
+    ulong lo;
+    ulong pc;
+
+    /* FPU State */
+    struct mips_fpu_struct fpu;
+
+    /* COP0 State */
+    struct mips_coproc *cop0;
+
+
+    /* Host KSEG0 address of the EI/DI offset */
+    void *kseg0_commpage;
+
+    u32 io_gpr;                  /* GPR used as IO source/target */
+
+    /* Used to calibrate the virutal count register for the guest */
+    int32_t host_cp0_count;
+
+    /* Bitmask of exceptions that are pending */
+    ulong pending_exceptions;
+
+    /* Bitmask of pending exceptions to be cleared */
+    ulong pending_exceptions_clr;
+
+    ulong pending_load_cause;
+
+    /* Save/Restore the entryhi register when are are preempted/scheduled back in */ 
+    ulong preempt_entryhi;
+
+    /* S/W Based TLB for guest */
+    struct kvm_mips_tlb guest_tlb[KVM_MIPS_GUEST_TLB_SIZE];
+
+    /* Guest ASID -> Host ASID mapping */
+    uint32_t asid_map[256];
+  
+    /* Cached guest kernel/user ASIDs */
+    uint32_t guest_user_asid[NR_CPUS];
+    uint32_t guest_kernel_asid[NR_CPUS];
+    struct mm_struct guest_kernel_mm, guest_user_mm;
+
+    struct kvm_mips_tlb shadow_tlb[NR_CPUS][KVM_MIPS_GUEST_TLB_SIZE];
+
+
+    struct hrtimer comparecount_timer;
+
+    int last_sched_cpu;
+
+    /* WAIT executed */
+    int wait;
+
+    /* Stats for exit reasons */
+    ulong exit_reason_stats[MAX_KVM_MIPS_EXIT_TYPES];
+};
+
+
+#define kvm_read_c0_guest_index(cop0)               (cop0->reg[MIPS_CP0_TLB_INDEX][0])
+#define kvm_write_c0_guest_index(cop0,val)          (cop0->reg[MIPS_CP0_TLB_INDEX][0] = val)
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
+#define kvm_change_c0_guest_cause(cop0, change, val)  \
+{                                                     \
+    kvm_clear_c0_guest_cause(cop0, change);           \
+    kvm_set_c0_guest_cause(cop0, ((val) & (change))); \
+}
+#define kvm_set_c0_guest_ebase(cop0, val)           (cop0->reg[MIPS_CP0_PRID][1] |= (val))
+#define kvm_clear_c0_guest_ebase(cop0, val)         (cop0->reg[MIPS_CP0_PRID][1] &= ~(val))
+#define kvm_change_c0_guest_ebase(cop0, change, val)  \
+{                                                     \
+    kvm_clear_c0_guest_ebase(cop0, change);           \
+    kvm_set_c0_guest_ebase(cop0, ((val) & (change))); \
+}
+
+
+struct kvm_mips_callbacks {
+    int (*handle_cop_unusable)(struct kvm_vcpu *vcpu);
+    int (*handle_tlb_mod)(struct kvm_vcpu *vcpu);
+    int (*handle_tlb_ld_miss)(struct kvm_vcpu *vcpu);
+    int (*handle_tlb_st_miss)(struct kvm_vcpu *vcpu);
+    int (*handle_addr_err_st)(struct kvm_vcpu *vcpu);
+    int (*handle_addr_err_ld)(struct kvm_vcpu *vcpu);
+    int (*handle_syscall)(struct kvm_vcpu *vcpu);
+    int (*handle_res_inst)(struct kvm_vcpu *vcpu);
+    int (*handle_break)(struct kvm_vcpu *vcpu);
+    gpa_t (*gva_to_gpa)(gva_t gva);
+    void (*queue_timer_int)(struct kvm_vcpu *vcpu);
+    void (*dequeue_timer_int)(struct kvm_vcpu *vcpu);
+    void (*queue_io_int)(struct kvm_vcpu *vcpu, struct kvm_mips_interrupt *irq);
+    void (*dequeue_io_int)(struct kvm_vcpu *vcpu, struct kvm_mips_interrupt *irq);
+    int (*irq_deliver)(struct kvm_vcpu *vcpu, unsigned int priority, uint32_t cause);
+    int (*irq_clear)(struct kvm_vcpu *vcpu, unsigned int priority, uint32_t cause);
+    int (*vcpu_ioctl_get_regs)(struct kvm_vcpu *vcpu, struct kvm_regs *regs);
+    int (*vcpu_ioctl_set_regs)(struct kvm_vcpu *vcpu, struct kvm_regs *regs);
+    int (*vcpu_init)(struct kvm_vcpu *vcpu);
+};
+extern struct kvm_mips_callbacks *kvm_mips_callbacks;
+int kvm_mips_emulation_init(struct kvm_mips_callbacks **install_callbacks);
+
+int kvm_arch_vcpu_dump_regs(struct kvm_vcpu *vcpu);
+
+/* Poll based printf, can't use printk while debugging */
+extern int kvm_mips_printf(const char *fmt, ...);
+
+/* Trampoline ASM routine to start running in "Guest" context */
+extern int __kvm_mips_vcpu_run(struct kvm_run *run, struct kvm_vcpu *vcpu);
+
+
+/* TLB handling */
+extern int kvm_mips_handle_kseg0_tlb_fault(ulong badbaddr,
+                                           struct kvm_vcpu *vcpu);
+
+extern int kvm_mips_handle_commpage_tlb_fault(ulong badvaddr,
+                                             struct kvm_vcpu *vcpu);
+
+extern int kvm_mips_handle_mapped_seg_tlb_fault(struct kvm_vcpu *vcpu,
+                                                struct kvm_mips_tlb *tlb,
+                                                ulong * hpa0, ulong * hpa1);
+
+extern enum emulation_result kvm_mips_handle_tlbmiss(ulong cause,
+                                                     uint32_t __user * opc,
+                                                     struct kvm_run *run,
+                                                     struct kvm_vcpu *vcpu);
+
+extern enum emulation_result kvm_mips_handle_tlbmod(ulong cause,
+                                                    uint32_t __user * opc,
+                                                    struct kvm_run *run,
+                                                    struct kvm_vcpu *vcpu);
+
+
+extern void kvm_mips_dump_host_tlbs(void);
+extern void kvm_mips_dump_guest_tlbs(struct kvm_vcpu *vcpu);
+extern void kvm_mips_dump_shadow_tlbs(struct kvm_vcpu *vcpu);
+extern void kvm_mips_flush_host_tlb(int skip_kseg0);
+extern int kvm_mips_host_tlb_inv(struct kvm_vcpu *vcpu, ulong entryhi);
+extern int kvm_mips_host_tlb_inv_index(struct kvm_vcpu *vcpu, int index);
+
+extern int kvm_mips_guest_tlb_lookup(struct kvm_vcpu *vcpu, ulong entryhi);
+extern int kvm_mips_host_tlb_lookup(struct kvm_vcpu *vcpu, ulong vaddr);
+extern ulong kvm_mips_translate_guest_kseg0_to_hpa(struct kvm_vcpu *vcpu,
+                                                   ulong gva);
+extern void kvm_get_new_mmu_context(struct mm_struct *mm, unsigned long cpu, struct kvm_vcpu *vcpu);
+extern void kvm_shadow_tlb_put(struct kvm_vcpu *vcpu);
+extern void kvm_shadow_tlb_load(struct kvm_vcpu *vcpu);
+extern void kvm_local_flush_tlb_all(void);
+extern void kvm_mips_init_shadow_tlb(struct kvm_vcpu *vcpu);
+extern void kvm_mips_alloc_new_mmu_context (struct kvm_vcpu *vcpu);
+extern void kvm_mips_vcpu_load(struct kvm_vcpu *vcpu, int cpu);
+extern void kvm_mips_vcpu_put(struct kvm_vcpu *vcpu);
+
+/* Emulation */
+uint32_t kvm_get_inst(uint32_t __user * opc, struct kvm_vcpu *vcpu);
+enum emulation_result update_pc(struct kvm_vcpu *vcpu, uint32_t cause);
+
+extern enum emulation_result kvm_mips_emulate_inst(ulong cause,
+                                                   uint32_t __user * opc,
+                                                   struct kvm_run *run,
+                                                   struct kvm_vcpu *vcpu);
+
+extern enum emulation_result kvm_mips_emulate_syscall(ulong cause,
+                                                      uint32_t __user * opc,
+                                                      struct kvm_run *run,
+                                                      struct kvm_vcpu *vcpu);
+
+extern enum emulation_result kvm_mips_emulate_tlbmiss_ld(ulong cause,
+                                                         uint32_t __user * opc,
+                                                         struct kvm_run *run,
+                                                         struct kvm_vcpu *vcpu);
+
+extern enum emulation_result kvm_mips_emulate_tlbinv_ld(ulong cause,
+                                                        uint32_t __user * opc,
+                                                        struct kvm_run *run,
+                                                        struct kvm_vcpu *vcpu);
+
+extern enum emulation_result kvm_mips_emulate_tlbmiss_st(ulong cause,
+                                                         uint32_t __user * opc,
+                                                         struct kvm_run *run,
+                                                         struct kvm_vcpu *vcpu);
+
+extern enum emulation_result kvm_mips_emulate_tlbinv_st(ulong cause,
+                                                        uint32_t __user * opc,
+                                                        struct kvm_run *run,
+                                                        struct kvm_vcpu *vcpu);
+
+
+extern enum emulation_result kvm_mips_emulate_tlbmod(ulong cause,
+                                                     uint32_t __user * opc,
+                                                     struct kvm_run *run,
+                                                     struct kvm_vcpu *vcpu);
+
+extern enum emulation_result kvm_mips_emulate_fpu_exc(ulong cause,
+                                                      uint32_t __user * opc,
+                                                      struct kvm_run *run,
+                                                      struct kvm_vcpu *vcpu);
+
+extern enum emulation_result kvm_mips_handle_ri(ulong cause,
+                                                uint32_t __user * opc,
+                                                struct kvm_run *run,
+                                                struct kvm_vcpu *vcpu);
+
+extern enum emulation_result kvm_mips_emulate_ri_exc(ulong cause,
+                                                     uint32_t __user * opc,
+                                                     struct kvm_run *run,
+                                                     struct kvm_vcpu *vcpu);
+
+extern enum emulation_result kvm_mips_emulate_bp_exc(ulong cause,
+                                                     uint32_t __user * opc,
+                                                     struct kvm_run *run,
+                                                     struct kvm_vcpu *vcpu);
+
+extern enum emulation_result kvm_mips_complete_mmio_load(struct kvm_vcpu *vcpu,
+                                                         struct kvm_run *run);
+
+#if 0
+enum emulation_result kvm_mips_emulate_count(struct kvm_vcpu *vcpu,
+                                             ulong newcompare);
+#else
+enum emulation_result kvm_mips_emulate_count(struct kvm_vcpu *vcpu);
+#endif
+
+enum emulation_result kvm_mips_check_privilege(ulong cause, uint32_t __user * opc,
+                         struct kvm_run *run, struct kvm_vcpu *vcpu);
+
+enum emulation_result kvm_mips_emulate_cache(uint32_t inst,
+                                             uint32_t __user * opc,
+                                             uint32_t cause,
+                                             struct kvm_run *run,
+                                             struct kvm_vcpu *vcpu);
+enum emulation_result kvm_mips_emulate_CP0(uint32_t inst,
+                                           uint32_t * opc,
+                                           uint32_t cause,
+                                           struct kvm_run *run,
+                                           struct kvm_vcpu *vcpu);
+enum emulation_result kvm_mips_emulate_store(uint32_t inst,
+                                             uint32_t cause,
+                                             struct kvm_run *run,
+                                             struct kvm_vcpu *vcpu);
+enum emulation_result kvm_mips_emulate_load(uint32_t inst,
+                                            uint32_t cause,
+                                            struct kvm_run *run,
+                                            struct kvm_vcpu *vcpu);
+
+/* Dynamic binary translation */
+extern int kvm_mips_trans_cache_index (uint32_t inst, uint32_t __user *opc, struct kvm_vcpu *vcpu);
+extern int kvm_mips_trans_cache_va (uint32_t inst, uint32_t __user *opc, struct kvm_vcpu *vcpu);
+extern int kvm_mips_trans_mfc0 (uint32_t inst, uint32_t __user *opc, struct kvm_vcpu *vcpu);
+extern int kvm_mips_trans_mtc0 (uint32_t inst, uint32_t __user *opc, struct kvm_vcpu *vcpu);
+
+/* Misc */
+extern void mips32_SyncICache(ulong addr, ulong size);
+extern int kvm_mips_dump_stats(struct kvm_vcpu *vcpu);
+extern ulong kvm_mips_get_ramsize (struct kvm *kvm);
+
+
+#endif /* __MIPS_KVM_HOST_H__ */
-- 
1.7.11.3
