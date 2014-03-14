Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Mar 2014 14:07:48 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.89.28.115]:60831 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6825821AbaCNNG3COI2k (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Mar 2014 14:06:29 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 73A0F620936EC;
        Fri, 14 Mar 2014 13:06:19 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Fri, 14 Mar 2014 13:06:22 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.65) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Fri, 14 Mar 2014 13:06:21 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, Gleb Natapov <gleb@kernel.org>,
        "Paolo Bonzini" <pbonzini@redhat.com>
CC:     James Hogan <james.hogan@imgtec.com>,
        Sanjay Lal <sanjayl@kymasys.com>, <linux-mips@linux-mips.org>,
        <kvm@vger.kernel.org>
Subject: [PATCH 2/4] MIPS: KVM: asm/kvm_host.h: Clean up whitespace
Date:   Fri, 14 Mar 2014 13:06:08 +0000
Message-ID: <1394802370-20487-3-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1394802370-20487-1-git-send-email-james.hogan@imgtec.com>
References: <1394802370-20487-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.65]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39470
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

The whitespace in asm/kvm_host.h is quite inconsistent in places. Clean
up the whole file to use tabs more consistently.

When you use the --ignore-space-change argument to git diff this patch
only changes line wrapping in TLB_IS_GLOBAL and TLB_IS_VALID macros.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sanjay Lal <sanjayl@kymasys.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h | 415 ++++++++++++++++++++-------------------
 1 file changed, 209 insertions(+), 206 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index a995fce87791..502c8da08574 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -30,16 +30,16 @@
 
 
 /* Special address that contains the comm page, used for reducing # of traps */
-#define KVM_GUEST_COMMPAGE_ADDR     0x0
+#define KVM_GUEST_COMMPAGE_ADDR		0x0
 
 #define KVM_GUEST_KERNEL_MODE(vcpu)	((kvm_read_c0_guest_status(vcpu->arch.cop0) & (ST0_EXL | ST0_ERL)) || \
 					((kvm_read_c0_guest_status(vcpu->arch.cop0) & KSU_USER) == 0))
 
-#define KVM_GUEST_KUSEG             0x00000000UL
-#define KVM_GUEST_KSEG0             0x40000000UL
-#define KVM_GUEST_KSEG23            0x60000000UL
-#define KVM_GUEST_KSEGX(a)          ((_ACAST32_(a)) & 0x60000000)
-#define KVM_GUEST_CPHYSADDR(a)      ((_ACAST32_(a)) & 0x1fffffff)
+#define KVM_GUEST_KUSEG			0x00000000UL
+#define KVM_GUEST_KSEG0			0x40000000UL
+#define KVM_GUEST_KSEG23		0x60000000UL
+#define KVM_GUEST_KSEGX(a)		((_ACAST32_(a)) & 0x60000000)
+#define KVM_GUEST_CPHYSADDR(a)		((_ACAST32_(a)) & 0x1fffffff)
 
 #define KVM_GUEST_CKSEG0ADDR(a)		(KVM_GUEST_CPHYSADDR(a) | KVM_GUEST_KSEG0)
 #define KVM_GUEST_CKSEG1ADDR(a)		(KVM_GUEST_CPHYSADDR(a) | KVM_GUEST_KSEG1)
@@ -52,17 +52,17 @@
 #define KVM_GUEST_KSEG1ADDR(a)		(KVM_GUEST_CPHYSADDR(a) | KVM_GUEST_KSEG1)
 #define KVM_GUEST_KSEG23ADDR(a)		(KVM_GUEST_CPHYSADDR(a) | KVM_GUEST_KSEG23)
 
-#define KVM_INVALID_PAGE            0xdeadbeef
-#define KVM_INVALID_INST            0xdeadbeef
-#define KVM_INVALID_ADDR            0xdeadbeef
+#define KVM_INVALID_PAGE		0xdeadbeef
+#define KVM_INVALID_INST		0xdeadbeef
+#define KVM_INVALID_ADDR		0xdeadbeef
 
-#define KVM_MALTA_GUEST_RTC_ADDR    0xb8000070UL
+#define KVM_MALTA_GUEST_RTC_ADDR	0xb8000070UL
 
-#define GUEST_TICKS_PER_JIFFY (40000000/HZ)
-#define MS_TO_NS(x) (x * 1E6L)
+#define GUEST_TICKS_PER_JIFFY		(40000000/HZ)
+#define MS_TO_NS(x)			(x * 1E6L)
 
-#define CAUSEB_DC       27
-#define CAUSEF_DC       (_ULCAST_(1)   << 27)
+#define CAUSEB_DC			27
+#define CAUSEF_DC			(_ULCAST_(1) << 27)
 
 struct kvm;
 struct kvm_run;
@@ -126,8 +126,8 @@ struct kvm_arch {
 	int commpage_tlb;
 };
 
-#define N_MIPS_COPROC_REGS      32
-#define N_MIPS_COPROC_SEL   	8
+#define N_MIPS_COPROC_REGS	32
+#define N_MIPS_COPROC_SEL	8
 
 struct mips_coproc {
 	unsigned long reg[N_MIPS_COPROC_REGS][N_MIPS_COPROC_SEL];
@@ -139,124 +139,124 @@ struct mips_coproc {
 /*
  * Coprocessor 0 register names
  */
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
+#define MIPS_CP0_TLB_INDEX	0
+#define MIPS_CP0_TLB_RANDOM	1
+#define MIPS_CP0_TLB_LOW	2
+#define MIPS_CP0_TLB_LO0	2
+#define MIPS_CP0_TLB_LO1	3
+#define MIPS_CP0_TLB_CONTEXT	4
+#define MIPS_CP0_TLB_PG_MASK	5
+#define MIPS_CP0_TLB_WIRED	6
+#define MIPS_CP0_HWRENA		7
+#define MIPS_CP0_BAD_VADDR	8
+#define MIPS_CP0_COUNT		9
+#define MIPS_CP0_TLB_HI		10
+#define MIPS_CP0_COMPARE	11
+#define MIPS_CP0_STATUS		12
+#define MIPS_CP0_CAUSE		13
+#define MIPS_CP0_EXC_PC		14
+#define MIPS_CP0_PRID		15
+#define MIPS_CP0_CONFIG		16
+#define MIPS_CP0_LLADDR		17
+#define MIPS_CP0_WATCH_LO	18
+#define MIPS_CP0_WATCH_HI	19
+#define MIPS_CP0_TLB_XCONTEXT	20
+#define MIPS_CP0_ECC		26
+#define MIPS_CP0_CACHE_ERR	27
+#define MIPS_CP0_TAG_LO		28
+#define MIPS_CP0_TAG_HI		29
+#define MIPS_CP0_ERROR_PC	30
+#define MIPS_CP0_DEBUG		23
+#define MIPS_CP0_DEPC		24
+#define MIPS_CP0_PERFCNT	25
+#define MIPS_CP0_ERRCTL		26
+#define MIPS_CP0_DATA_LO	28
+#define MIPS_CP0_DATA_HI	29
+#define MIPS_CP0_DESAVE		31
+
+#define MIPS_CP0_CONFIG_SEL	0
+#define MIPS_CP0_CONFIG1_SEL	1
+#define MIPS_CP0_CONFIG2_SEL	2
+#define MIPS_CP0_CONFIG3_SEL	3
 
 /* Config0 register bits */
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
+#define CP0C0_M			31
+#define CP0C0_K23		28
+#define CP0C0_KU		25
+#define CP0C0_MDU		20
+#define CP0C0_MM		17
+#define CP0C0_BM		16
+#define CP0C0_BE		15
+#define CP0C0_AT		13
+#define CP0C0_AR		10
+#define CP0C0_MT		7
+#define CP0C0_VI		3
+#define CP0C0_K0		0
 
 /* Config1 register bits */
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
+#define CP0C1_M			31
+#define CP0C1_MMU		25
+#define CP0C1_IS		22
+#define CP0C1_IL		19
+#define CP0C1_IA		16
+#define CP0C1_DS		13
+#define CP0C1_DL		10
+#define CP0C1_DA		7
+#define CP0C1_C2		6
+#define CP0C1_MD		5
+#define CP0C1_PC		4
+#define CP0C1_WR		3
+#define CP0C1_CA		2
+#define CP0C1_EP		1
+#define CP0C1_FP		0
 
 /* Config2 Register bits */
-#define CP0C2_M    31
-#define CP0C2_TU   28
-#define CP0C2_TS   24
-#define CP0C2_TL   20
-#define CP0C2_TA   16
-#define CP0C2_SU   12
-#define CP0C2_SS   8
-#define CP0C2_SL   4
-#define CP0C2_SA   0
+#define CP0C2_M			31
+#define CP0C2_TU		28
+#define CP0C2_TS		24
+#define CP0C2_TL		20
+#define CP0C2_TA		16
+#define CP0C2_SU		12
+#define CP0C2_SS		8
+#define CP0C2_SL		4
+#define CP0C2_SA		0
 
 /* Config3 Register bits */
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
+#define CP0C3_M			31
+#define CP0C3_ISA_ON_EXC	16
+#define CP0C3_ULRI		13
+#define CP0C3_DSPP		10
+#define CP0C3_LPA		7
+#define CP0C3_VEIC		6
+#define CP0C3_VInt		5
+#define CP0C3_SP		4
+#define CP0C3_MT		2
+#define CP0C3_SM		1
+#define CP0C3_TL		0
 
 /* Have config1, Cacheable, noncoherent, write-back, write allocate*/
-#define MIPS_CONFIG0                                              \
+#define MIPS_CONFIG0						\
   ((1 << CP0C0_M) | (0x3 << CP0C0_K0))
 
 /* Have config2, no coprocessor2 attached, no MDMX support attached,
    no performance counters, watch registers present,
    no code compression, EJTAG present, no FPU, no watch registers */
-#define MIPS_CONFIG1                                              \
-((1 << CP0C1_M) |                                                 \
- (0 << CP0C1_C2) | (0 << CP0C1_MD) | (0 << CP0C1_PC) |            \
- (0 << CP0C1_WR) | (0 << CP0C1_CA) | (1 << CP0C1_EP) |            \
+#define MIPS_CONFIG1						\
+((1 << CP0C1_M) |						\
+ (0 << CP0C1_C2) | (0 << CP0C1_MD) | (0 << CP0C1_PC) |		\
+ (0 << CP0C1_WR) | (0 << CP0C1_CA) | (1 << CP0C1_EP) |		\
  (0 << CP0C1_FP))
 
 /* Have config3, no tertiary/secondary caches implemented */
-#define MIPS_CONFIG2                                              \
+#define MIPS_CONFIG2						\
 ((1 << CP0C2_M))
 
 /* No config4, no DSP ASE, no large physaddr (PABITS),
    no external interrupt controller, no vectored interrupts,
    no 1kb pages, no SmartMIPS ASE, no trace logic */
-#define MIPS_CONFIG3                                              \
-((0 << CP0C3_M) | (0 << CP0C3_DSPP) | (0 << CP0C3_LPA) |          \
- (0 << CP0C3_VEIC) | (0 << CP0C3_VInt) | (0 << CP0C3_SP) |        \
+#define MIPS_CONFIG3						\
+((0 << CP0C3_M) | (0 << CP0C3_DSPP) | (0 << CP0C3_LPA) |	\
+ (0 << CP0C3_VEIC) | (0 << CP0C3_VInt) | (0 << CP0C3_SP) |	\
  (0 << CP0C3_SM) | (0 << CP0C3_TL))
 
 /* MMU types, the first four entries have the same layout as the
@@ -274,36 +274,36 @@ enum mips_mmu_types {
 /*
  * Trap codes
  */
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
+#define T_INT			0	/* Interrupt pending */
+#define T_TLB_MOD		1	/* TLB modified fault */
+#define T_TLB_LD_MISS		2	/* TLB miss on load or ifetch */
+#define T_TLB_ST_MISS		3	/* TLB miss on a store */
+#define T_ADDR_ERR_LD		4	/* Address error on a load or ifetch */
+#define T_ADDR_ERR_ST		5	/* Address error on a store */
+#define T_BUS_ERR_IFETCH	6	/* Bus error on an ifetch */
+#define T_BUS_ERR_LD_ST		7	/* Bus error on a load or store */
+#define T_SYSCALL		8	/* System call */
+#define T_BREAK			9	/* Breakpoint */
+#define T_RES_INST		10	/* Reserved instruction exception */
+#define T_COP_UNUSABLE		11	/* Coprocessor unusable */
+#define T_OVFLOW		12	/* Arithmetic overflow */
 
 /*
  * Trap definitions added for r4000 port.
  */
-#define T_TRAP          13	/* Trap instruction */
-#define T_VCEI          14	/* Virtual coherency exception */
-#define T_FPE           15	/* Floating point exception */
-#define T_WATCH         23	/* Watch address reference */
-#define T_VCED          31	/* Virtual coherency data */
+#define T_TRAP			13	/* Trap instruction */
+#define T_VCEI			14	/* Virtual coherency exception */
+#define T_FPE			15	/* Floating point exception */
+#define T_WATCH			23	/* Watch address reference */
+#define T_VCED			31	/* Virtual coherency data */
 
 /* Resume Flags */
-#define RESUME_FLAG_DR          (1<<0)	/* Reload guest nonvolatile state? */
-#define RESUME_FLAG_HOST        (1<<1)	/* Resume host? */
+#define RESUME_FLAG_DR		(1<<0)	/* Reload guest nonvolatile state? */
+#define RESUME_FLAG_HOST	(1<<1)	/* Resume host? */
 
-#define RESUME_GUEST            0
-#define RESUME_GUEST_DR         RESUME_FLAG_DR
-#define RESUME_HOST             RESUME_FLAG_HOST
+#define RESUME_GUEST		0
+#define RESUME_GUEST_DR		RESUME_FLAG_DR
+#define RESUME_HOST		RESUME_FLAG_HOST
 
 enum emulation_result {
 	EMULATE_DONE,		/* no further processing */
@@ -313,24 +313,27 @@ enum emulation_result {
 	EMULATE_PRIV_FAIL,
 };
 
-#define MIPS3_PG_G  0x00000001	/* Global; ignore ASID if in lo0 & lo1 */
-#define MIPS3_PG_V  0x00000002	/* Valid */
-#define MIPS3_PG_NV 0x00000000
-#define MIPS3_PG_D  0x00000004	/* Dirty */
+#define MIPS3_PG_G	0x00000001 /* Global; ignore ASID if in lo0 & lo1 */
+#define MIPS3_PG_V	0x00000002 /* Valid */
+#define MIPS3_PG_NV	0x00000000
+#define MIPS3_PG_D	0x00000004 /* Dirty */
 
 #define mips3_paddr_to_tlbpfn(x) \
-    (((unsigned long)(x) >> MIPS3_PG_SHIFT) & MIPS3_PG_FRAME)
+	(((unsigned long)(x) >> MIPS3_PG_SHIFT) & MIPS3_PG_FRAME)
 #define mips3_tlbpfn_to_paddr(x) \
-    ((unsigned long)((x) & MIPS3_PG_FRAME) << MIPS3_PG_SHIFT)
+	((unsigned long)((x) & MIPS3_PG_FRAME) << MIPS3_PG_SHIFT)
 
-#define MIPS3_PG_SHIFT      6
-#define MIPS3_PG_FRAME      0x3fffffc0
+#define MIPS3_PG_SHIFT		6
+#define MIPS3_PG_FRAME		0x3fffffc0
 
-#define VPN2_MASK           0xffffe000
-#define TLB_IS_GLOBAL(x)    (((x).tlb_lo0 & MIPS3_PG_G) && ((x).tlb_lo1 & MIPS3_PG_G))
-#define TLB_VPN2(x)         ((x).tlb_hi & VPN2_MASK)
-#define TLB_ASID(x)         ((x).tlb_hi & ASID_MASK)
-#define TLB_IS_VALID(x, va) (((va) & (1 << PAGE_SHIFT)) ? ((x).tlb_lo1 & MIPS3_PG_V) : ((x).tlb_lo0 & MIPS3_PG_V))
+#define VPN2_MASK		0xffffe000
+#define TLB_IS_GLOBAL(x)	(((x).tlb_lo0 & MIPS3_PG_G) &&	\
+				 ((x).tlb_lo1 & MIPS3_PG_G))
+#define TLB_VPN2(x)		((x).tlb_hi & VPN2_MASK)
+#define TLB_ASID(x)		((x).tlb_hi & ASID_MASK)
+#define TLB_IS_VALID(x, va)	(((va) & (1 << PAGE_SHIFT))	\
+				 ? ((x).tlb_lo1 & MIPS3_PG_V)	\
+				 : ((x).tlb_lo0 & MIPS3_PG_V))
 
 struct kvm_mips_tlb {
 	long tlb_mask;
@@ -339,7 +342,7 @@ struct kvm_mips_tlb {
 	long tlb_lo1;
 };
 
-#define KVM_MIPS_GUEST_TLB_SIZE     64
+#define KVM_MIPS_GUEST_TLB_SIZE	64
 struct kvm_vcpu_arch {
 	void *host_ebase, *guest_ebase;
 	unsigned long host_stack;
@@ -400,65 +403,65 @@ struct kvm_vcpu_arch {
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
+#define kvm_read_c0_guest_index(cop0)		(cop0->reg[MIPS_CP0_TLB_INDEX][0])
+#define kvm_write_c0_guest_index(cop0, val)	(cop0->reg[MIPS_CP0_TLB_INDEX][0] = val)
+#define kvm_read_c0_guest_entrylo0(cop0)	(cop0->reg[MIPS_CP0_TLB_LO0][0])
+#define kvm_read_c0_guest_entrylo1(cop0)	(cop0->reg[MIPS_CP0_TLB_LO1][0])
+#define kvm_read_c0_guest_context(cop0)		(cop0->reg[MIPS_CP0_TLB_CONTEXT][0])
+#define kvm_write_c0_guest_context(cop0, val)	(cop0->reg[MIPS_CP0_TLB_CONTEXT][0] = (val))
+#define kvm_read_c0_guest_userlocal(cop0)	(cop0->reg[MIPS_CP0_TLB_CONTEXT][2])
+#define kvm_read_c0_guest_pagemask(cop0)	(cop0->reg[MIPS_CP0_TLB_PG_MASK][0])
+#define kvm_write_c0_guest_pagemask(cop0, val)	(cop0->reg[MIPS_CP0_TLB_PG_MASK][0] = (val))
+#define kvm_read_c0_guest_wired(cop0)		(cop0->reg[MIPS_CP0_TLB_WIRED][0])
+#define kvm_write_c0_guest_wired(cop0, val)	(cop0->reg[MIPS_CP0_TLB_WIRED][0] = (val))
+#define kvm_read_c0_guest_badvaddr(cop0)	(cop0->reg[MIPS_CP0_BAD_VADDR][0])
+#define kvm_write_c0_guest_badvaddr(cop0, val)	(cop0->reg[MIPS_CP0_BAD_VADDR][0] = (val))
+#define kvm_read_c0_guest_count(cop0)		(cop0->reg[MIPS_CP0_COUNT][0])
+#define kvm_write_c0_guest_count(cop0, val)	(cop0->reg[MIPS_CP0_COUNT][0] = (val))
+#define kvm_read_c0_guest_entryhi(cop0)		(cop0->reg[MIPS_CP0_TLB_HI][0])
+#define kvm_write_c0_guest_entryhi(cop0, val)	(cop0->reg[MIPS_CP0_TLB_HI][0] = (val))
+#define kvm_read_c0_guest_compare(cop0)		(cop0->reg[MIPS_CP0_COMPARE][0])
+#define kvm_write_c0_guest_compare(cop0, val)	(cop0->reg[MIPS_CP0_COMPARE][0] = (val))
+#define kvm_read_c0_guest_status(cop0)		(cop0->reg[MIPS_CP0_STATUS][0])
+#define kvm_write_c0_guest_status(cop0, val)	(cop0->reg[MIPS_CP0_STATUS][0] = (val))
+#define kvm_read_c0_guest_intctl(cop0)		(cop0->reg[MIPS_CP0_STATUS][1])
+#define kvm_write_c0_guest_intctl(cop0, val)	(cop0->reg[MIPS_CP0_STATUS][1] = (val))
+#define kvm_read_c0_guest_cause(cop0)		(cop0->reg[MIPS_CP0_CAUSE][0])
+#define kvm_write_c0_guest_cause(cop0, val)	(cop0->reg[MIPS_CP0_CAUSE][0] = (val))
+#define kvm_read_c0_guest_epc(cop0)		(cop0->reg[MIPS_CP0_EXC_PC][0])
+#define kvm_write_c0_guest_epc(cop0, val)	(cop0->reg[MIPS_CP0_EXC_PC][0] = (val))
+#define kvm_read_c0_guest_prid(cop0)		(cop0->reg[MIPS_CP0_PRID][0])
+#define kvm_write_c0_guest_prid(cop0, val)	(cop0->reg[MIPS_CP0_PRID][0] = (val))
+#define kvm_read_c0_guest_ebase(cop0)		(cop0->reg[MIPS_CP0_PRID][1])
+#define kvm_write_c0_guest_ebase(cop0, val)	(cop0->reg[MIPS_CP0_PRID][1] = (val))
+#define kvm_read_c0_guest_config(cop0)		(cop0->reg[MIPS_CP0_CONFIG][0])
+#define kvm_read_c0_guest_config1(cop0)		(cop0->reg[MIPS_CP0_CONFIG][1])
+#define kvm_read_c0_guest_config2(cop0)		(cop0->reg[MIPS_CP0_CONFIG][2])
+#define kvm_read_c0_guest_config3(cop0)		(cop0->reg[MIPS_CP0_CONFIG][3])
+#define kvm_read_c0_guest_config7(cop0)		(cop0->reg[MIPS_CP0_CONFIG][7])
+#define kvm_write_c0_guest_config(cop0, val)	(cop0->reg[MIPS_CP0_CONFIG][0] = (val))
+#define kvm_write_c0_guest_config1(cop0, val)	(cop0->reg[MIPS_CP0_CONFIG][1] = (val))
+#define kvm_write_c0_guest_config2(cop0, val)	(cop0->reg[MIPS_CP0_CONFIG][2] = (val))
+#define kvm_write_c0_guest_config3(cop0, val)	(cop0->reg[MIPS_CP0_CONFIG][3] = (val))
+#define kvm_write_c0_guest_config7(cop0, val)	(cop0->reg[MIPS_CP0_CONFIG][7] = (val))
+#define kvm_read_c0_guest_errorepc(cop0)	(cop0->reg[MIPS_CP0_ERROR_PC][0])
+#define kvm_write_c0_guest_errorepc(cop0, val)	(cop0->reg[MIPS_CP0_ERROR_PC][0] = (val))
+
+#define kvm_set_c0_guest_status(cop0, val)	(cop0->reg[MIPS_CP0_STATUS][0] |= (val))
+#define kvm_clear_c0_guest_status(cop0, val)	(cop0->reg[MIPS_CP0_STATUS][0] &= ~(val))
+#define kvm_set_c0_guest_cause(cop0, val)	(cop0->reg[MIPS_CP0_CAUSE][0] |= (val))
+#define kvm_clear_c0_guest_cause(cop0, val)	(cop0->reg[MIPS_CP0_CAUSE][0] &= ~(val))
+#define kvm_change_c0_guest_cause(cop0, change, val)			\
+{									\
+	kvm_clear_c0_guest_cause(cop0, change);				\
+	kvm_set_c0_guest_cause(cop0, ((val) & (change)));		\
 }
-#define kvm_set_c0_guest_ebase(cop0, val)           (cop0->reg[MIPS_CP0_PRID][1] |= (val))
-#define kvm_clear_c0_guest_ebase(cop0, val)         (cop0->reg[MIPS_CP0_PRID][1] &= ~(val))
-#define kvm_change_c0_guest_ebase(cop0, change, val)  \
-{                                                     \
-    kvm_clear_c0_guest_ebase(cop0, change);           \
-    kvm_set_c0_guest_ebase(cop0, ((val) & (change))); \
+#define kvm_set_c0_guest_ebase(cop0, val)	(cop0->reg[MIPS_CP0_PRID][1] |= (val))
+#define kvm_clear_c0_guest_ebase(cop0, val)	(cop0->reg[MIPS_CP0_PRID][1] &= ~(val))
+#define kvm_change_c0_guest_ebase(cop0, change, val)			\
+{									\
+	kvm_clear_c0_guest_ebase(cop0, change);				\
+	kvm_set_c0_guest_ebase(cop0, ((val) & (change)));		\
 }
 
 
-- 
1.8.1.2
