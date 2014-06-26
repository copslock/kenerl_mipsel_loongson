Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jun 2014 21:12:34 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:29450 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6860042AbaFZTMMA01Ze (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Jun 2014 21:12:12 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 64681E55FA0B4;
        Thu, 26 Jun 2014 20:12:00 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Thu, 26 Jun
 2014 20:12:04 +0100
Received: from BAMAIL02.ba.imgtec.org (192.168.66.28) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Thu, 26 Jun 2014 20:12:03 +0100
Received: from fun-lab.mips.com (10.20.2.221) by bamail02.ba.imgtec.org
 (192.168.66.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Thu, 26 Jun
 2014 12:11:55 -0700
From:   Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
To:     <pbonzini@redhat.com>
CC:     <gleb@kernel.org>, <kvm@vger.kernel.org>, <sanjayl@kymasys.com>,
        <james.hogan@imgtec.com>, <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <dengcheng.zhu@imgtec.com>
Subject: [PATCH v4 1/7] MIPS: KVM: Reformat code and comments
Date:   Thu, 26 Jun 2014 12:11:34 -0700
Message-ID: <1403809900-17454-2-git-send-email-dengcheng.zhu@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1403809900-17454-1-git-send-email-dengcheng.zhu@imgtec.com>
References: <1403809900-17454-1-git-send-email-dengcheng.zhu@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.2.221]
Return-Path: <DengCheng.Zhu@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40852
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@imgtec.com
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

From: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>

No logic changes inside.

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
---
Changes:
v4 - v3:
o Align elements in debugfs_entries[].
o Indentation and comment style changes.
v2 - v1:
o Don't change the opening comment mark for kernel-doc comments.
o To make long lines more readable, use local variables / macros.
o Slight format adjustments are made.

 arch/mips/include/asm/kvm_host.h  |  10 +-
 arch/mips/include/asm/r4kcache.h  |   3 +
 arch/mips/kvm/kvm_locore.S        |  55 +++---
 arch/mips/kvm/kvm_mips.c          | 179 +++++++++---------
 arch/mips/kvm/kvm_mips_comm.h     |  21 +-
 arch/mips/kvm/kvm_mips_commpage.c |  21 +-
 arch/mips/kvm/kvm_mips_dyntrans.c |  38 ++--
 arch/mips/kvm/kvm_mips_emul.c     | 389 +++++++++++++++++++-------------------
 arch/mips/kvm/kvm_mips_int.c      |  45 +++--
 arch/mips/kvm/kvm_mips_int.h      |  22 ++-
 arch/mips/kvm/kvm_mips_opcode.h   |  26 ++-
 arch/mips/kvm/kvm_mips_stats.c    |  18 +-
 arch/mips/kvm/kvm_tlb.c           | 194 +++++++++----------
 arch/mips/kvm/kvm_trap_emul.c     |  77 ++++----
 arch/mips/kvm/trace.h             |  18 +-
 15 files changed, 564 insertions(+), 552 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index b0aa955..3f813f2 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -359,13 +359,17 @@ enum emulation_result {
 #define MIPS3_PG_FRAME		0x3fffffc0
 
 #define VPN2_MASK		0xffffe000
-#define TLB_IS_GLOBAL(x)	(((x).tlb_lo0 & MIPS3_PG_G) &&	\
+#define TLB_IS_GLOBAL(x)	(((x).tlb_lo0 & MIPS3_PG_G) &&		\
 				 ((x).tlb_lo1 & MIPS3_PG_G))
 #define TLB_VPN2(x)		((x).tlb_hi & VPN2_MASK)
 #define TLB_ASID(x)		((x).tlb_hi & ASID_MASK)
-#define TLB_IS_VALID(x, va)	(((va) & (1 << PAGE_SHIFT))	\
-				 ? ((x).tlb_lo1 & MIPS3_PG_V)	\
+#define TLB_IS_VALID(x, va)	(((va) & (1 << PAGE_SHIFT))		\
+				 ? ((x).tlb_lo1 & MIPS3_PG_V)		\
 				 : ((x).tlb_lo0 & MIPS3_PG_V))
+#define TLB_HI_VPN2_HIT(x, y)	((TLB_VPN2(x) & ~(x).tlb_mask) ==	\
+				 ((y) & VPN2_MASK & ~(x).tlb_mask))
+#define TLB_HI_ASID_HIT(x, y)	(TLB_IS_GLOBAL(x) ||			\
+				 TLB_ASID(x) == ((y) & ASID_MASK))
 
 struct kvm_mips_tlb {
 	long tlb_mask;
diff --git a/arch/mips/include/asm/r4kcache.h b/arch/mips/include/asm/r4kcache.h
index 0b8bd28..4520adc 100644
--- a/arch/mips/include/asm/r4kcache.h
+++ b/arch/mips/include/asm/r4kcache.h
@@ -19,6 +19,9 @@
 #include <asm/mipsmtregs.h>
 #include <asm/uaccess.h> /* for segment_eq() */
 
+extern void (*r4k_blast_dcache)(void);
+extern void (*r4k_blast_icache)(void);
+
 /*
  * This macro return a properly sign-extended address suitable as base address
  * for indexed cache operations.  Two issues here:
diff --git a/arch/mips/kvm/kvm_locore.S b/arch/mips/kvm/kvm_locore.S
index 033ac34..d7279c0 100644
--- a/arch/mips/kvm/kvm_locore.S
+++ b/arch/mips/kvm/kvm_locore.S
@@ -16,7 +16,6 @@
 #include <asm/stackframe.h>
 #include <asm/asm-offsets.h>
 
-
 #define _C_LABEL(x)     x
 #define MIPSX(name)     mips32_ ## name
 #define CALLFRAME_SIZ   32
@@ -91,7 +90,10 @@ FEXPORT(__kvm_mips_vcpu_run)
 	LONG_S	$24, PT_R24(k1)
 	LONG_S	$25, PT_R25(k1)
 
-	/* XXXKYMA k0/k1 not saved, not being used if we got here through an ioctl() */
+	/*
+	 * XXXKYMA k0/k1 not saved, not being used if we got here through
+	 * an ioctl()
+	 */
 
 	LONG_S	$28, PT_R28(k1)
 	LONG_S	$29, PT_R29(k1)
@@ -132,7 +134,10 @@ FEXPORT(__kvm_mips_vcpu_run)
 	/* Save the kernel gp as well */
 	LONG_S	gp, VCPU_HOST_GP(k1)
 
-	/* Setup status register for running the guest in UM, interrupts are disabled */
+	/*
+	 * Setup status register for running the guest in UM, interrupts
+	 * are disabled
+	 */
 	li	k0, (ST0_EXL | KSU_USER | ST0_BEV)
 	mtc0	k0, CP0_STATUS
 	ehb
@@ -152,7 +157,6 @@ FEXPORT(__kvm_mips_vcpu_run)
 	mtc0	k0, CP0_STATUS
 	ehb
 
-
 	/* Set Guest EPC */
 	LONG_L	t0, VCPU_PC(k1)
 	mtc0	t0, CP0_EPC
@@ -165,7 +169,7 @@ FEXPORT(__kvm_mips_load_asid)
 	 INT_ADDIU t1, k1, VCPU_GUEST_KERNEL_ASID  /* (BD)  */
 	INT_ADDIU t1, k1, VCPU_GUEST_USER_ASID    /* else user */
 1:
-	     /* t1: contains the base of the ASID array, need to get the cpu id  */
+	/* t1: contains the base of the ASID array, need to get the cpu id */
 	LONG_L	t2, TI_CPU($28)             /* smp_processor_id */
 	INT_SLL	t2, t2, 2                   /* x4 */
 	REG_ADDU t3, t1, t2
@@ -229,9 +233,7 @@ FEXPORT(__kvm_mips_load_k0k1)
 	eret
 
 VECTOR(MIPSX(exception), unknown)
-/*
- * Find out what mode we came from and jump to the proper handler.
- */
+/* Find out what mode we came from and jump to the proper handler. */
 	mtc0	k0, CP0_ERROREPC	#01: Save guest k0
 	ehb				#02:
 
@@ -239,7 +241,8 @@ VECTOR(MIPSX(exception), unknown)
 	INT_SRL	k0, k0, 10		#03: Get rid of CPUNum
 	INT_SLL	k0, k0, 10		#04
 	LONG_S	k1, 0x3000(k0)		#05: Save k1 @ offset 0x3000
-	INT_ADDIU k0, k0, 0x2000		#06: Exception handler is installed @ offset 0x2000
+	INT_ADDIU k0, k0, 0x2000	#06: Exception handler is
+					#    installed @ offset 0x2000
 	j	k0			#07: jump to the function
 	 nop				#08: branch delay slot
 VECTOR_END(MIPSX(exceptionEnd))
@@ -248,7 +251,6 @@ VECTOR_END(MIPSX(exceptionEnd))
 /*
  * Generic Guest exception handler. We end up here when the guest
  * does something that causes a trap to kernel mode.
- *
  */
 NESTED (MIPSX(GuestException), CALLFRAME_SIZ, ra)
 	/* Get the VCPU pointer from DDTATA_LO */
@@ -290,9 +292,7 @@ NESTED (MIPSX(GuestException), CALLFRAME_SIZ, ra)
 	LONG_S	$30, VCPU_R30(k1)
 	LONG_S	$31, VCPU_R31(k1)
 
-	/* We need to save hi/lo and restore them on
-	 * the way out
-	 */
+	/* We need to save hi/lo and restore them on the way out */
 	mfhi	t0
 	LONG_S	t0, VCPU_HI(k1)
 
@@ -321,8 +321,10 @@ NESTED (MIPSX(GuestException), CALLFRAME_SIZ, ra)
 	/* Save pointer to run in s0, will be saved by the compiler */
 	move	s0, a0
 
-	/* Save Host level EPC, BadVaddr and Cause to VCPU, useful to
-	 * process the exception */
+	/*
+	 * Save Host level EPC, BadVaddr and Cause to VCPU, useful to
+	 * process the exception
+	 */
 	mfc0	k0,CP0_EPC
 	LONG_S	k0, VCPU_PC(k1)
 
@@ -351,7 +353,6 @@ NESTED (MIPSX(GuestException), CALLFRAME_SIZ, ra)
 	LONG_L	k0, VCPU_HOST_EBASE(k1)
 	mtc0	k0,CP0_EBASE
 
-
 	/* Now that the new EBASE has been loaded, unset BEV and KSU_USER */
 	.set	at
 	and	v0, v0, ~(ST0_EXL | KSU_USER | ST0_IE)
@@ -369,7 +370,8 @@ NESTED (MIPSX(GuestException), CALLFRAME_SIZ, ra)
 	/* Saved host state */
 	INT_ADDIU sp, sp, -PT_SIZE
 
-	/* XXXKYMA do we need to load the host ASID, maybe not because the
+	/*
+	 * XXXKYMA do we need to load the host ASID, maybe not because the
 	 * kernel entries are marked GLOBAL, need to verify
 	 */
 
@@ -383,9 +385,11 @@ NESTED (MIPSX(GuestException), CALLFRAME_SIZ, ra)
 
 	/* Jump to handler */
 FEXPORT(__kvm_mips_jump_to_handler)
-	/* XXXKYMA: not sure if this is safe, how large is the stack??
+	/*
+	 * XXXKYMA: not sure if this is safe, how large is the stack??
 	 * Now jump to the kvm_mips_handle_exit() to see if we can deal
-	 * with this in the kernel */
+	 * with this in the kernel
+	 */
 	PTR_LA	t9, kvm_mips_handle_exit
 	jalr.hb	t9
 	 INT_ADDIU sp, sp, -CALLFRAME_SIZ           /* BD Slot */
@@ -394,7 +398,8 @@ FEXPORT(__kvm_mips_jump_to_handler)
 	di
 	ehb
 
-	/* XXXKYMA: k0/k1 could have been blown away if we processed
+	/*
+	 * XXXKYMA: k0/k1 could have been blown away if we processed
 	 * an exception while we were handling the exception from the
 	 * guest, reload k1
 	 */
@@ -402,7 +407,8 @@ FEXPORT(__kvm_mips_jump_to_handler)
 	move	k1, s1
 	INT_ADDIU k1, k1, VCPU_HOST_ARCH
 
-	/* Check return value, should tell us if we are returning to the
+	/*
+	 * Check return value, should tell us if we are returning to the
 	 * host (handle I/O etc)or resuming the guest
 	 */
 	andi	t0, v0, RESUME_HOST
@@ -521,8 +527,10 @@ __kvm_mips_return_to_host:
 	LONG_L	$0, PT_R0(k1)
 	LONG_L	$1, PT_R1(k1)
 
-	/* r2/v0 is the return code, shift it down by 2 (arithmetic)
-	 * to recover the err code  */
+	/*
+	 * r2/v0 is the return code, shift it down by 2 (arithmetic)
+	 * to recover the err code
+	 */
 	INT_SRA	k0, v0, 2
 	move	$2, k0
 
@@ -566,7 +574,6 @@ __kvm_mips_return_to_host:
 	PTR_LI	k0, 0x2000000F
 	mtc0	k0,  CP0_HWRENA
 
-
 	/* Restore RA, which is the address we will return to */
 	LONG_L  ra, PT_R31(k1)
 	j       ra
diff --git a/arch/mips/kvm/kvm_mips.c b/arch/mips/kvm/kvm_mips.c
index cd5e4f5..52be52a 100644
--- a/arch/mips/kvm/kvm_mips.c
+++ b/arch/mips/kvm/kvm_mips.c
@@ -7,7 +7,7 @@
  *
  * Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
  * Authors: Sanjay Lal <sanjayl@kymasys.com>
-*/
+ */
 
 #include <linux/errno.h>
 #include <linux/err.h>
@@ -31,38 +31,41 @@
 #define VECTORSPACING 0x100	/* for EI/VI mode */
 #endif
 
-#define VCPU_STAT(x) offsetof(struct kvm_vcpu, stat.x), KVM_STAT_VCPU
+#define VCPU_STAT(x) offsetof(struct kvm_vcpu, stat.x)
 struct kvm_stats_debugfs_item debugfs_entries[] = {
-	{ "wait", VCPU_STAT(wait_exits) },
-	{ "cache", VCPU_STAT(cache_exits) },
-	{ "signal", VCPU_STAT(signal_exits) },
-	{ "interrupt", VCPU_STAT(int_exits) },
-	{ "cop_unsuable", VCPU_STAT(cop_unusable_exits) },
-	{ "tlbmod", VCPU_STAT(tlbmod_exits) },
-	{ "tlbmiss_ld", VCPU_STAT(tlbmiss_ld_exits) },
-	{ "tlbmiss_st", VCPU_STAT(tlbmiss_st_exits) },
-	{ "addrerr_st", VCPU_STAT(addrerr_st_exits) },
-	{ "addrerr_ld", VCPU_STAT(addrerr_ld_exits) },
-	{ "syscall", VCPU_STAT(syscall_exits) },
-	{ "resvd_inst", VCPU_STAT(resvd_inst_exits) },
-	{ "break_inst", VCPU_STAT(break_inst_exits) },
-	{ "flush_dcache", VCPU_STAT(flush_dcache_exits) },
-	{ "halt_wakeup", VCPU_STAT(halt_wakeup) },
+	{ "wait",	  VCPU_STAT(wait_exits),	 KVM_STAT_VCPU },
+	{ "cache",	  VCPU_STAT(cache_exits),	 KVM_STAT_VCPU },
+	{ "signal",	  VCPU_STAT(signal_exits),	 KVM_STAT_VCPU },
+	{ "interrupt",	  VCPU_STAT(int_exits),		 KVM_STAT_VCPU },
+	{ "cop_unsuable", VCPU_STAT(cop_unusable_exits), KVM_STAT_VCPU },
+	{ "tlbmod",	  VCPU_STAT(tlbmod_exits),	 KVM_STAT_VCPU },
+	{ "tlbmiss_ld",	  VCPU_STAT(tlbmiss_ld_exits),	 KVM_STAT_VCPU },
+	{ "tlbmiss_st",	  VCPU_STAT(tlbmiss_st_exits),	 KVM_STAT_VCPU },
+	{ "addrerr_st",	  VCPU_STAT(addrerr_st_exits),	 KVM_STAT_VCPU },
+	{ "addrerr_ld",	  VCPU_STAT(addrerr_ld_exits),	 KVM_STAT_VCPU },
+	{ "syscall",	  VCPU_STAT(syscall_exits),	 KVM_STAT_VCPU },
+	{ "resvd_inst",	  VCPU_STAT(resvd_inst_exits),	 KVM_STAT_VCPU },
+	{ "break_inst",	  VCPU_STAT(break_inst_exits),	 KVM_STAT_VCPU },
+	{ "flush_dcache", VCPU_STAT(flush_dcache_exits), KVM_STAT_VCPU },
+	{ "halt_wakeup",  VCPU_STAT(halt_wakeup),	 KVM_STAT_VCPU },
 	{NULL}
 };
 
 static int kvm_mips_reset_vcpu(struct kvm_vcpu *vcpu)
 {
 	int i;
+
 	for_each_possible_cpu(i) {
 		vcpu->arch.guest_kernel_asid[i] = 0;
 		vcpu->arch.guest_user_asid[i] = 0;
 	}
+
 	return 0;
 }
 
-/* XXXKYMA: We are simulatoring a processor that has the WII bit set in Config7, so we
- * are "runnable" if interrupts are pending
+/*
+ * XXXKYMA: We are simulatoring a processor that has the WII bit set in
+ * Config7, so we are "runnable" if interrupts are pending
  */
 int kvm_arch_vcpu_runnable(struct kvm_vcpu *vcpu)
 {
@@ -103,7 +106,10 @@ static void kvm_mips_init_tlbs(struct kvm *kvm)
 {
 	unsigned long wired;
 
-	/* Add a wired entry to the TLB, it is used to map the commpage to the Guest kernel */
+	/*
+	 * Add a wired entry to the TLB, it is used to map the commpage to
+	 * the Guest kernel
+	 */
 	wired = read_c0_wired();
 	write_c0_wired(wired + 1);
 	mtc0_tlbw_hazard();
@@ -130,7 +136,6 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 		on_each_cpu(kvm_mips_init_vm_percpu, kvm, 1);
 	}
 
-
 	return 0;
 }
 
@@ -185,8 +190,8 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 	}
 }
 
-long
-kvm_arch_dev_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
+long kvm_arch_dev_ioctl(struct file *filp, unsigned int ioctl,
+			unsigned long arg)
 {
 	return -ENOIOCTLCMD;
 }
@@ -207,17 +212,17 @@ void kvm_arch_memslots_updated(struct kvm *kvm)
 }
 
 int kvm_arch_prepare_memory_region(struct kvm *kvm,
-                                struct kvm_memory_slot *memslot,
-                                struct kvm_userspace_memory_region *mem,
-                                enum kvm_mr_change change)
+				   struct kvm_memory_slot *memslot,
+				   struct kvm_userspace_memory_region *mem,
+				   enum kvm_mr_change change)
 {
 	return 0;
 }
 
 void kvm_arch_commit_memory_region(struct kvm *kvm,
-                                struct kvm_userspace_memory_region *mem,
-                                const struct kvm_memory_slot *old,
-                                enum kvm_mr_change change)
+				   struct kvm_userspace_memory_region *mem,
+				   const struct kvm_memory_slot *old,
+				   enum kvm_mr_change change)
 {
 	unsigned long npages = 0;
 	int i, err = 0;
@@ -246,9 +251,8 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 				  npages, kvm->arch.guest_pmap);
 
 			/* Now setup the page table */
-			for (i = 0; i < npages; i++) {
+			for (i = 0; i < npages; i++)
 				kvm->arch.guest_pmap[i] = KVM_INVALID_PAGE;
-			}
 		}
 	}
 out:
@@ -270,8 +274,6 @@ void kvm_arch_flush_shadow(struct kvm *kvm)
 
 struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm, unsigned int id)
 {
-	extern char mips32_exception[], mips32_exceptionEnd[];
-	extern char mips32_GuestException[], mips32_GuestExceptionEnd[];
 	int err, size, offset;
 	void *gebase;
 	int i;
@@ -290,14 +292,14 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm, unsigned int id)
 
 	kvm_debug("kvm @ %p: create cpu %d at %p\n", kvm, id, vcpu);
 
-	/* Allocate space for host mode exception handlers that handle
+	/*
+	 * Allocate space for host mode exception handlers that handle
 	 * guest mode exits
 	 */
-	if (cpu_has_veic || cpu_has_vint) {
+	if (cpu_has_veic || cpu_has_vint)
 		size = 0x200 + VECTORSPACING * 64;
-	} else {
+	else
 		size = 0x4000;
-	}
 
 	/* Save Linux EBASE */
 	vcpu->arch.host_ebase = (void *)read_c0_ebase();
@@ -345,7 +347,10 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm, unsigned int id)
 	local_flush_icache_range((unsigned long)gebase,
 				(unsigned long)gebase + ALIGN(size, PAGE_SIZE));
 
-	/* Allocate comm page for guest kernel, a TLB will be reserved for mapping GVA @ 0xFFFF8000 to this page */
+	/*
+	 * Allocate comm page for guest kernel, a TLB will be reserved for
+	 * mapping GVA @ 0xFFFF8000 to this page
+	 */
 	vcpu->arch.kseg0_commpage = kzalloc(PAGE_SIZE << 1, GFP_KERNEL);
 
 	if (!vcpu->arch.kseg0_commpage) {
@@ -391,9 +396,8 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 	kvm_arch_vcpu_free(vcpu);
 }
 
-int
-kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
-				    struct kvm_guest_debug *dbg)
+int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
+					struct kvm_guest_debug *dbg)
 {
 	return -ENOIOCTLCMD;
 }
@@ -430,8 +434,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	return r;
 }
 
-int
-kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu, struct kvm_mips_interrupt *irq)
+int kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu,
+			     struct kvm_mips_interrupt *irq)
 {
 	int intr = (int)irq->irq;
 	struct kvm_vcpu *dvcpu = NULL;
@@ -458,23 +462,20 @@ kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu, struct kvm_mips_interrupt *irq)
 
 	dvcpu->arch.wait = 0;
 
-	if (waitqueue_active(&dvcpu->wq)) {
+	if (waitqueue_active(&dvcpu->wq))
 		wake_up_interruptible(&dvcpu->wq);
-	}
 
 	return 0;
 }
 
-int
-kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
-				struct kvm_mp_state *mp_state)
+int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
+				    struct kvm_mp_state *mp_state)
 {
 	return -ENOIOCTLCMD;
 }
 
-int
-kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
-				struct kvm_mp_state *mp_state)
+int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
+				    struct kvm_mp_state *mp_state)
 {
 	return -ENOIOCTLCMD;
 }
@@ -631,10 +632,12 @@ static int kvm_mips_get_reg(struct kvm_vcpu *vcpu,
 	}
 	if ((reg->id & KVM_REG_SIZE_MASK) == KVM_REG_SIZE_U64) {
 		u64 __user *uaddr64 = (u64 __user *)(long)reg->addr;
+
 		return put_user(v, uaddr64);
 	} else if ((reg->id & KVM_REG_SIZE_MASK) == KVM_REG_SIZE_U32) {
 		u32 __user *uaddr32 = (u32 __user *)(long)reg->addr;
 		u32 v32 = (u32)v;
+
 		return put_user(v32, uaddr32);
 	} else {
 		return -EINVAL;
@@ -727,8 +730,8 @@ static int kvm_mips_set_reg(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
-long
-kvm_arch_vcpu_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
+long kvm_arch_vcpu_ioctl(struct file *filp, unsigned int ioctl,
+			 unsigned long arg)
 {
 	struct kvm_vcpu *vcpu = filp->private_data;
 	void __user *argp = (void __user *)arg;
@@ -738,6 +741,7 @@ kvm_arch_vcpu_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 	case KVM_SET_ONE_REG:
 	case KVM_GET_ONE_REG: {
 		struct kvm_one_reg reg;
+
 		if (copy_from_user(&reg, argp, sizeof(reg)))
 			return -EFAULT;
 		if (ioctl == KVM_SET_ONE_REG)
@@ -772,6 +776,7 @@ kvm_arch_vcpu_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 	case KVM_INTERRUPT:
 		{
 			struct kvm_mips_interrupt irq;
+
 			r = -EFAULT;
 			if (copy_from_user(&irq, argp, sizeof(irq)))
 				goto out;
@@ -790,9 +795,7 @@ out:
 	return r;
 }
 
-/*
- * Get (and clear) the dirty memory log for a memory slot.
- */
+/* Get (and clear) the dirty memory log for a memory slot. */
 int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
 {
 	struct kvm_memory_slot *memslot;
@@ -859,14 +862,14 @@ void kvm_arch_exit(void)
 	kvm_mips_callbacks = NULL;
 }
 
-int
-kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
+int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
+				  struct kvm_sregs *sregs)
 {
 	return -ENOIOCTLCMD;
 }
 
-int
-kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
+int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
+				  struct kvm_sregs *sregs)
 {
 	return -ENOIOCTLCMD;
 }
@@ -979,14 +982,11 @@ static void kvm_mips_comparecount_func(unsigned long data)
 	kvm_mips_callbacks->queue_timer_int(vcpu);
 
 	vcpu->arch.wait = 0;
-	if (waitqueue_active(&vcpu->wq)) {
+	if (waitqueue_active(&vcpu->wq))
 		wake_up_interruptible(&vcpu->wq);
-	}
 }
 
-/*
- * low level hrtimer wake routine.
- */
+/* low level hrtimer wake routine */
 static enum hrtimer_restart kvm_mips_comparecount_wakeup(struct hrtimer *timer)
 {
 	struct kvm_vcpu *vcpu;
@@ -1010,8 +1010,8 @@ void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu)
 	return;
 }
 
-int
-kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu, struct kvm_translation *tr)
+int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
+				  struct kvm_translation *tr)
 {
 	return 0;
 }
@@ -1022,8 +1022,7 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 	return kvm_mips_callbacks->vcpu_setup(vcpu);
 }
 
-static
-void kvm_mips_set_c0_status(void)
+static void kvm_mips_set_c0_status(void)
 {
 	uint32_t status = read_c0_status();
 
@@ -1053,7 +1052,10 @@ int kvm_mips_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
 	run->exit_reason = KVM_EXIT_UNKNOWN;
 	run->ready_for_interrupt_injection = 1;
 
-	/* Set the appropriate status bits based on host CPU features, before we hit the scheduler */
+	/*
+	 * Set the appropriate status bits based on host CPU features,
+	 * before we hit the scheduler
+	 */
 	kvm_mips_set_c0_status();
 
 	local_irq_enable();
@@ -1061,7 +1063,8 @@ int kvm_mips_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
 	kvm_debug("kvm_mips_handle_exit: cause: %#x, PC: %p, kvm_run: %p, kvm_vcpu: %p\n",
 			cause, opc, run, vcpu);
 
-	/* Do a privilege check, if in UM most of these exit conditions end up
+	/*
+	 * Do a privilege check, if in UM most of these exit conditions end up
 	 * causing an exception to be delivered to the Guest Kernel
 	 */
 	er = kvm_mips_check_privilege(cause, opc, run, vcpu);
@@ -1080,9 +1083,8 @@ int kvm_mips_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
 		++vcpu->stat.int_exits;
 		trace_kvm_exit(vcpu, INT_EXITS);
 
-		if (need_resched()) {
+		if (need_resched())
 			cond_resched();
-		}
 
 		ret = RESUME_GUEST;
 		break;
@@ -1094,9 +1096,8 @@ int kvm_mips_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
 		trace_kvm_exit(vcpu, COP_UNUSABLE_EXITS);
 		ret = kvm_mips_callbacks->handle_cop_unusable(vcpu);
 		/* XXXKYMA: Might need to return to user space */
-		if (run->exit_reason == KVM_EXIT_IRQ_WINDOW_OPEN) {
+		if (run->exit_reason == KVM_EXIT_IRQ_WINDOW_OPEN)
 			ret = RESUME_HOST;
-		}
 		break;
 
 	case T_TLB_MOD:
@@ -1106,10 +1107,9 @@ int kvm_mips_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
 		break;
 
 	case T_TLB_ST_MISS:
-		kvm_debug
-		    ("TLB ST fault:  cause %#x, status %#lx, PC: %p, BadVaddr: %#lx\n",
-		     cause, kvm_read_c0_guest_status(vcpu->arch.cop0), opc,
-		     badvaddr);
+		kvm_debug("TLB ST fault:  cause %#x, status %#lx, PC: %p, BadVaddr: %#lx\n",
+			  cause, kvm_read_c0_guest_status(vcpu->arch.cop0), opc,
+			  badvaddr);
 
 		++vcpu->stat.tlbmiss_st_exits;
 		trace_kvm_exit(vcpu, TLBMISS_ST_EXITS);
@@ -1156,10 +1156,9 @@ int kvm_mips_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
 		break;
 
 	default:
-		kvm_err
-		    ("Exception Code: %d, not yet handled, @ PC: %p, inst: 0x%08x  BadVaddr: %#lx Status: %#lx\n",
-		     exccode, opc, kvm_get_inst(opc, vcpu), badvaddr,
-		     kvm_read_c0_guest_status(vcpu->arch.cop0));
+		kvm_err("Exception Code: %d, not yet handled, @ PC: %p, inst: 0x%08x  BadVaddr: %#lx Status: %#lx\n",
+			exccode, opc, kvm_get_inst(opc, vcpu), badvaddr,
+			kvm_read_c0_guest_status(vcpu->arch.cop0));
 		kvm_arch_vcpu_dump_regs(vcpu);
 		run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
 		ret = RESUME_HOST;
@@ -1174,7 +1173,7 @@ skip_emul:
 		kvm_mips_deliver_interrupts(vcpu, cause);
 
 	if (!(ret & RESUME_HOST)) {
-		/* Only check for signals if not already exiting to userspace  */
+		/* Only check for signals if not already exiting to userspace */
 		if (signal_pending(current)) {
 			run->exit_reason = KVM_EXIT_INTR;
 			ret = (-EINTR << 2) | RESUME_HOST;
@@ -1195,11 +1194,13 @@ int __init kvm_mips_init(void)
 	if (ret)
 		return ret;
 
-	/* On MIPS, kernel modules are executed from "mapped space", which requires TLBs.
-	 * The TLB handling code is statically linked with the rest of the kernel (kvm_tlb.c)
-	 * to avoid the possibility of double faulting. The issue is that the TLB code
-	 * references routines that are part of the the KVM module,
-	 * which are only available once the module is loaded.
+	/*
+	 * On MIPS, kernel modules are executed from "mapped space", which
+	 * requires TLBs. The TLB handling code is statically linked with
+	 * the rest of the kernel (kvm_tlb.c) to avoid the possibility of
+	 * double faulting. The issue is that the TLB code references
+	 * routines that are part of the the KVM module, which are only
+	 * available once the module is loaded.
 	 */
 	kvm_mips_gfn_to_pfn = gfn_to_pfn;
 	kvm_mips_release_pfn_clean = kvm_release_pfn_clean;
diff --git a/arch/mips/kvm/kvm_mips_comm.h b/arch/mips/kvm/kvm_mips_comm.h
index a4a8c85..08c5fa2 100644
--- a/arch/mips/kvm/kvm_mips_comm.h
+++ b/arch/mips/kvm/kvm_mips_comm.h
@@ -1,19 +1,20 @@
 /*
-* This file is subject to the terms and conditions of the GNU General Public
-* License.  See the file "COPYING" in the main directory of this archive
-* for more details.
-*
-* KVM/MIPS: commpage: mapped into get kernel space
-*
-* Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
-* Authors: Sanjay Lal <sanjayl@kymasys.com>
-*/
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * KVM/MIPS: commpage: mapped into get kernel space
+ *
+ * Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
+ * Authors: Sanjay Lal <sanjayl@kymasys.com>
+ */
 
 #ifndef __KVM_MIPS_COMMPAGE_H__
 #define __KVM_MIPS_COMMPAGE_H__
 
 struct kvm_mips_commpage {
-	struct mips_coproc cop0;	/* COP0 state is mapped into Guest kernel via commpage */
+	/* COP0 state is mapped into Guest kernel via commpage */
+	struct mips_coproc cop0;
 };
 
 #define KVM_MIPS_COMM_EIDI_OFFSET       0x0
diff --git a/arch/mips/kvm/kvm_mips_commpage.c b/arch/mips/kvm/kvm_mips_commpage.c
index 3873b1e..ab7096e 100644
--- a/arch/mips/kvm/kvm_mips_commpage.c
+++ b/arch/mips/kvm/kvm_mips_commpage.c
@@ -1,14 +1,14 @@
 /*
-* This file is subject to the terms and conditions of the GNU General Public
-* License.  See the file "COPYING" in the main directory of this archive
-* for more details.
-*
-* commpage, currently used for Virtual COP0 registers.
-* Mapped into the guest kernel @ 0x0.
-*
-* Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
-* Authors: Sanjay Lal <sanjayl@kymasys.com>
-*/
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * commpage, currently used for Virtual COP0 registers.
+ * Mapped into the guest kernel @ 0x0.
+ *
+ * Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
+ * Authors: Sanjay Lal <sanjayl@kymasys.com>
+ */
 
 #include <linux/errno.h>
 #include <linux/err.h>
@@ -27,6 +27,7 @@
 void kvm_mips_commpage_init(struct kvm_vcpu *vcpu)
 {
 	struct kvm_mips_commpage *page = vcpu->arch.kseg0_commpage;
+
 	memset(page, 0, sizeof(struct kvm_mips_commpage));
 
 	/* Specific init values for fields */
diff --git a/arch/mips/kvm/kvm_mips_dyntrans.c b/arch/mips/kvm/kvm_mips_dyntrans.c
index b80e41d..fa7184d 100644
--- a/arch/mips/kvm/kvm_mips_dyntrans.c
+++ b/arch/mips/kvm/kvm_mips_dyntrans.c
@@ -1,13 +1,13 @@
 /*
-* This file is subject to the terms and conditions of the GNU General Public
-* License.  See the file "COPYING" in the main directory of this archive
-* for more details.
-*
-* KVM/MIPS: Binary Patching for privileged instructions, reduces traps.
-*
-* Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
-* Authors: Sanjay Lal <sanjayl@kymasys.com>
-*/
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * KVM/MIPS: Binary Patching for privileged instructions, reduces traps.
+ *
+ * Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
+ * Authors: Sanjay Lal <sanjayl@kymasys.com>
+ */
 
 #include <linux/errno.h>
 #include <linux/err.h>
@@ -28,9 +28,8 @@
 #define CLEAR_TEMPLATE  0x00000020
 #define SW_TEMPLATE     0xac000000
 
-int
-kvm_mips_trans_cache_index(uint32_t inst, uint32_t *opc,
-			   struct kvm_vcpu *vcpu)
+int kvm_mips_trans_cache_index(uint32_t inst, uint32_t *opc,
+			       struct kvm_vcpu *vcpu)
 {
 	int result = 0;
 	unsigned long kseg0_opc;
@@ -47,12 +46,11 @@ kvm_mips_trans_cache_index(uint32_t inst, uint32_t *opc,
 }
 
 /*
- *  Address based CACHE instructions are transformed into synci(s). A little heavy
- * for just D-cache invalidates, but avoids an expensive trap
+ * Address based CACHE instructions are transformed into synci(s). A little
+ * heavy for just D-cache invalidates, but avoids an expensive trap
  */
-int
-kvm_mips_trans_cache_va(uint32_t inst, uint32_t *opc,
-			struct kvm_vcpu *vcpu)
+int kvm_mips_trans_cache_va(uint32_t inst, uint32_t *opc,
+			    struct kvm_vcpu *vcpu)
 {
 	int result = 0;
 	unsigned long kseg0_opc;
@@ -72,8 +70,7 @@ kvm_mips_trans_cache_va(uint32_t inst, uint32_t *opc,
 	return result;
 }
 
-int
-kvm_mips_trans_mfc0(uint32_t inst, uint32_t *opc, struct kvm_vcpu *vcpu)
+int kvm_mips_trans_mfc0(uint32_t inst, uint32_t *opc, struct kvm_vcpu *vcpu)
 {
 	int32_t rt, rd, sel;
 	uint32_t mfc0_inst;
@@ -115,8 +112,7 @@ kvm_mips_trans_mfc0(uint32_t inst, uint32_t *opc, struct kvm_vcpu *vcpu)
 	return 0;
 }
 
-int
-kvm_mips_trans_mtc0(uint32_t inst, uint32_t *opc, struct kvm_vcpu *vcpu)
+int kvm_mips_trans_mtc0(uint32_t inst, uint32_t *opc, struct kvm_vcpu *vcpu)
 {
 	int32_t rt, rd, sel;
 	uint32_t mtc0_inst = SW_TEMPLATE;
diff --git a/arch/mips/kvm/kvm_mips_emul.c b/arch/mips/kvm/kvm_mips_emul.c
index 8d48400..9ec9f1d 100644
--- a/arch/mips/kvm/kvm_mips_emul.c
+++ b/arch/mips/kvm/kvm_mips_emul.c
@@ -1,13 +1,13 @@
 /*
-* This file is subject to the terms and conditions of the GNU General Public
-* License.  See the file "COPYING" in the main directory of this archive
-* for more details.
-*
-* KVM/MIPS: Instruction/Exception emulation
-*
-* Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
-* Authors: Sanjay Lal <sanjayl@kymasys.com>
-*/
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * KVM/MIPS: Instruction/Exception emulation
+ *
+ * Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
+ * Authors: Sanjay Lal <sanjayl@kymasys.com>
+ */
 
 #include <linux/errno.h>
 #include <linux/err.h>
@@ -51,18 +51,14 @@ unsigned long kvm_compute_return_epc(struct kvm_vcpu *vcpu,
 	if (epc & 3)
 		goto unaligned;
 
-	/*
-	 * Read the instruction
-	 */
+	/* Read the instruction */
 	insn.word = kvm_get_inst((uint32_t *) epc, vcpu);
 
 	if (insn.word == KVM_INVALID_INST)
 		return KVM_INVALID_INST;
 
 	switch (insn.i_format.opcode) {
-		/*
-		 * jr and jalr are in r_format format.
-		 */
+		/* jr and jalr are in r_format format. */
 	case spec_op:
 		switch (insn.r_format.func) {
 		case jalr_op:
@@ -124,18 +120,16 @@ unsigned long kvm_compute_return_epc(struct kvm_vcpu *vcpu,
 
 			dspcontrol = rddsp(0x01);
 
-			if (dspcontrol >= 32) {
+			if (dspcontrol >= 32)
 				epc = epc + 4 + (insn.i_format.simmediate << 2);
-			} else
+			else
 				epc += 8;
 			nextpc = epc;
 			break;
 		}
 		break;
 
-		/*
-		 * These are unconditional and in j_format.
-		 */
+		/* These are unconditional and in j_format. */
 	case jal_op:
 		arch->gprs[31] = instpc + 8;
 	case j_op:
@@ -146,9 +140,7 @@ unsigned long kvm_compute_return_epc(struct kvm_vcpu *vcpu,
 		nextpc = epc;
 		break;
 
-		/*
-		 * These are conditional and in i_format.
-		 */
+		/* These are conditional and in i_format. */
 	case beq_op:
 	case beql_op:
 		if (arch->gprs[insn.i_format.rs] ==
@@ -189,9 +181,7 @@ unsigned long kvm_compute_return_epc(struct kvm_vcpu *vcpu,
 		nextpc = epc;
 		break;
 
-		/*
-		 * And now the FPA/cp1 branch instructions.
-		 */
+		/* And now the FPA/cp1 branch instructions. */
 	case cop1_op:
 		printk("%s: unsupported cop1_op\n", __func__);
 		break;
@@ -219,7 +209,8 @@ enum emulation_result update_pc(struct kvm_vcpu *vcpu, uint32_t cause)
 			er = EMULATE_FAIL;
 		} else {
 			vcpu->arch.pc = branch_pc;
-			kvm_debug("BD update_pc(): New PC: %#lx\n", vcpu->arch.pc);
+			kvm_debug("BD update_pc(): New PC: %#lx\n",
+				  vcpu->arch.pc);
 		}
 	} else
 		vcpu->arch.pc += 4;
@@ -240,6 +231,7 @@ enum emulation_result update_pc(struct kvm_vcpu *vcpu, uint32_t cause)
 static inline int kvm_mips_count_disabled(struct kvm_vcpu *vcpu)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
+
 	return	(vcpu->arch.count_ctl & KVM_REG_MIPS_COUNT_CTL_DC) ||
 		(kvm_read_c0_guest_cause(cop0) & CAUSEF_DC);
 }
@@ -392,7 +384,6 @@ static ktime_t kvm_mips_freeze_hrtimer(struct kvm_vcpu *vcpu,
 	return now;
 }
 
-
 /**
  * kvm_mips_resume_hrtimer() - Resume hrtimer, updating expiry.
  * @vcpu:	Virtual CPU.
@@ -781,8 +772,9 @@ enum emulation_result kvm_mips_emul_wait(struct kvm_vcpu *vcpu)
 		vcpu->arch.wait = 1;
 		kvm_vcpu_block(vcpu);
 
-		/* We we are runnable, then definitely go off to user space to check if any
-		 * I/O interrupts are pending.
+		/*
+		 * We we are runnable, then definitely go off to user space to
+		 * check if any I/O interrupts are pending.
 		 */
 		if (kvm_check_request(KVM_REQ_UNHALT, vcpu)) {
 			clear_bit(KVM_REQ_UNHALT, &vcpu->requests);
@@ -793,8 +785,9 @@ enum emulation_result kvm_mips_emul_wait(struct kvm_vcpu *vcpu)
 	return er;
 }
 
-/* XXXKYMA: Linux doesn't seem to use TLBR, return EMULATE_FAIL for now so that we can catch
- * this, if things ever change
+/*
+ * XXXKYMA: Linux doesn't seem to use TLBR, return EMULATE_FAIL for now so that
+ * we can catch this, if things ever change
  */
 enum emulation_result kvm_mips_emul_tlbr(struct kvm_vcpu *vcpu)
 {
@@ -827,21 +820,22 @@ enum emulation_result kvm_mips_emul_tlbwi(struct kvm_vcpu *vcpu)
 	}
 
 	tlb = &vcpu->arch.guest_tlb[index];
-#if 1
-	/* Probe the shadow host TLB for the entry being overwritten, if one matches, invalidate it */
+	/*
+	 * Probe the shadow host TLB for the entry being overwritten, if one
+	 * matches, invalidate it
+	 */
 	kvm_mips_host_tlb_inv(vcpu, tlb->tlb_hi);
-#endif
 
 	tlb->tlb_mask = kvm_read_c0_guest_pagemask(cop0);
 	tlb->tlb_hi = kvm_read_c0_guest_entryhi(cop0);
 	tlb->tlb_lo0 = kvm_read_c0_guest_entrylo0(cop0);
 	tlb->tlb_lo1 = kvm_read_c0_guest_entrylo1(cop0);
 
-	kvm_debug
-	    ("[%#x] COP0_TLBWI [%d] (entryhi: %#lx, entrylo0: %#lx entrylo1: %#lx, mask: %#lx)\n",
-	     pc, index, kvm_read_c0_guest_entryhi(cop0),
-	     kvm_read_c0_guest_entrylo0(cop0), kvm_read_c0_guest_entrylo1(cop0),
-	     kvm_read_c0_guest_pagemask(cop0));
+	kvm_debug("[%#x] COP0_TLBWI [%d] (entryhi: %#lx, entrylo0: %#lx entrylo1: %#lx, mask: %#lx)\n",
+		  pc, index, kvm_read_c0_guest_entryhi(cop0),
+		  kvm_read_c0_guest_entrylo0(cop0),
+		  kvm_read_c0_guest_entrylo1(cop0),
+		  kvm_read_c0_guest_pagemask(cop0));
 
 	return er;
 }
@@ -855,12 +849,8 @@ enum emulation_result kvm_mips_emul_tlbwr(struct kvm_vcpu *vcpu)
 	uint32_t pc = vcpu->arch.pc;
 	int index;
 
-#if 1
 	get_random_bytes(&index, sizeof(index));
 	index &= (KVM_MIPS_GUEST_TLB_SIZE - 1);
-#else
-	index = jiffies % KVM_MIPS_GUEST_TLB_SIZE;
-#endif
 
 	if (index < 0 || index >= KVM_MIPS_GUEST_TLB_SIZE) {
 		printk("%s: illegal index: %d\n", __func__, index);
@@ -869,21 +859,21 @@ enum emulation_result kvm_mips_emul_tlbwr(struct kvm_vcpu *vcpu)
 
 	tlb = &vcpu->arch.guest_tlb[index];
 
-#if 1
-	/* Probe the shadow host TLB for the entry being overwritten, if one matches, invalidate it */
+	/*
+	 * Probe the shadow host TLB for the entry being overwritten, if one
+	 * matches, invalidate it
+	 */
 	kvm_mips_host_tlb_inv(vcpu, tlb->tlb_hi);
-#endif
 
 	tlb->tlb_mask = kvm_read_c0_guest_pagemask(cop0);
 	tlb->tlb_hi = kvm_read_c0_guest_entryhi(cop0);
 	tlb->tlb_lo0 = kvm_read_c0_guest_entrylo0(cop0);
 	tlb->tlb_lo1 = kvm_read_c0_guest_entrylo1(cop0);
 
-	kvm_debug
-	    ("[%#x] COP0_TLBWR[%d] (entryhi: %#lx, entrylo0: %#lx entrylo1: %#lx)\n",
-	     pc, index, kvm_read_c0_guest_entryhi(cop0),
-	     kvm_read_c0_guest_entrylo0(cop0),
-	     kvm_read_c0_guest_entrylo1(cop0));
+	kvm_debug("[%#x] COP0_TLBWR[%d] (entryhi: %#lx, entrylo0: %#lx entrylo1: %#lx)\n",
+		  pc, index, kvm_read_c0_guest_entryhi(cop0),
+		  kvm_read_c0_guest_entrylo0(cop0),
+		  kvm_read_c0_guest_entrylo1(cop0));
 
 	return er;
 }
@@ -906,9 +896,9 @@ enum emulation_result kvm_mips_emul_tlbp(struct kvm_vcpu *vcpu)
 	return er;
 }
 
-enum emulation_result
-kvm_mips_emulate_CP0(uint32_t inst, uint32_t *opc, uint32_t cause,
-		     struct kvm_run *run, struct kvm_vcpu *vcpu)
+enum emulation_result kvm_mips_emulate_CP0(uint32_t inst, uint32_t *opc,
+					   uint32_t cause, struct kvm_run *run,
+					   struct kvm_vcpu *vcpu)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	enum emulation_result er = EMULATE_DONE;
@@ -922,9 +912,8 @@ kvm_mips_emulate_CP0(uint32_t inst, uint32_t *opc, uint32_t cause,
 	 */
 	curr_pc = vcpu->arch.pc;
 	er = update_pc(vcpu, cause);
-	if (er == EMULATE_FAIL) {
+	if (er == EMULATE_FAIL)
 		return er;
-	}
 
 	copz = (inst >> 21) & 0x1f;
 	rt = (inst >> 16) & 0x1f;
@@ -973,8 +962,7 @@ kvm_mips_emulate_CP0(uint32_t inst, uint32_t *opc, uint32_t cause,
 #ifdef CONFIG_KVM_MIPS_DYN_TRANS
 				kvm_mips_trans_mfc0(inst, opc, vcpu);
 #endif
-			}
-			else {
+			} else {
 				vcpu->arch.gprs[rt] = cop0->reg[rd][sel];
 
 #ifdef CONFIG_KVM_MIPS_DYN_TRANS
@@ -1014,17 +1002,15 @@ kvm_mips_emulate_CP0(uint32_t inst, uint32_t *opc, uint32_t cause,
 				       kvm_read_c0_guest_ebase(cop0));
 			} else if (rd == MIPS_CP0_TLB_HI && sel == 0) {
 				uint32_t nasid =
-				    vcpu->arch.gprs[rt] & ASID_MASK;
-				if ((KSEGX(vcpu->arch.gprs[rt]) != CKSEG0)
-				    &&
+					vcpu->arch.gprs[rt] & ASID_MASK;
+				if ((KSEGX(vcpu->arch.gprs[rt]) != CKSEG0) &&
 				    ((kvm_read_c0_guest_entryhi(cop0) &
 				      ASID_MASK) != nasid)) {
-
-					kvm_debug
-					    ("MTCz, change ASID from %#lx to %#lx\n",
-					     kvm_read_c0_guest_entryhi(cop0) &
-					     ASID_MASK,
-					     vcpu->arch.gprs[rt] & ASID_MASK);
+					kvm_debug("MTCz, change ASID from %#lx to %#lx\n",
+						kvm_read_c0_guest_entryhi(cop0)
+						& ASID_MASK,
+						vcpu->arch.gprs[rt]
+						& ASID_MASK);
 
 					/* Blow away the shadow host TLBs */
 					kvm_mips_flush_host_tlb(1);
@@ -1049,7 +1035,10 @@ kvm_mips_emulate_CP0(uint32_t inst, uint32_t *opc, uint32_t cause,
 			} else if ((rd == MIPS_CP0_STATUS) && (sel == 0)) {
 				kvm_write_c0_guest_status(cop0,
 							  vcpu->arch.gprs[rt]);
-				/* Make sure that CU1 and NMI bits are never set */
+				/*
+				 * Make sure that CU1 and NMI bits are
+				 * never set
+				 */
 				kvm_clear_c0_guest_status(cop0,
 							  (ST0_CU1 | ST0_NMI));
 
@@ -1058,6 +1047,7 @@ kvm_mips_emulate_CP0(uint32_t inst, uint32_t *opc, uint32_t cause,
 #endif
 			} else if ((rd == MIPS_CP0_CAUSE) && (sel == 0)) {
 				uint32_t old_cause, new_cause;
+
 				old_cause = kvm_read_c0_guest_cause(cop0);
 				new_cause = vcpu->arch.gprs[rt];
 				/* Update R/W bits */
@@ -1115,7 +1105,10 @@ kvm_mips_emulate_CP0(uint32_t inst, uint32_t *opc, uint32_t cause,
 				    cop0->reg[MIPS_CP0_STATUS][2] & 0xf;
 				uint32_t pss =
 				    (cop0->reg[MIPS_CP0_STATUS][2] >> 6) & 0xf;
-				/* We don't support any shadow register sets, so SRSCtl[PSS] == SRSCtl[CSS] = 0 */
+				/*
+				 * We don't support any shadow register sets, so
+				 * SRSCtl[PSS] == SRSCtl[CSS] = 0
+				 */
 				if (css || pss) {
 					er = EMULATE_FAIL;
 					break;
@@ -1135,12 +1128,9 @@ kvm_mips_emulate_CP0(uint32_t inst, uint32_t *opc, uint32_t cause,
 	}
 
 done:
-	/*
-	 * Rollback PC only if emulation was unsuccessful
-	 */
-	if (er == EMULATE_FAIL) {
+	/* Rollback PC only if emulation was unsuccessful */
+	if (er == EMULATE_FAIL)
 		vcpu->arch.pc = curr_pc;
-	}
 
 dont_update_pc:
 	/*
@@ -1152,9 +1142,9 @@ dont_update_pc:
 	return er;
 }
 
-enum emulation_result
-kvm_mips_emulate_store(uint32_t inst, uint32_t cause,
-		       struct kvm_run *run, struct kvm_vcpu *vcpu)
+enum emulation_result kvm_mips_emulate_store(uint32_t inst, uint32_t cause,
+					     struct kvm_run *run,
+					     struct kvm_vcpu *vcpu)
 {
 	enum emulation_result er = EMULATE_DO_MMIO;
 	int32_t op, base, rt, offset;
@@ -1257,19 +1247,16 @@ kvm_mips_emulate_store(uint32_t inst, uint32_t cause,
 		break;
 	}
 
-	/*
-	 * Rollback PC if emulation was unsuccessful
-	 */
-	if (er == EMULATE_FAIL) {
+	/* Rollback PC if emulation was unsuccessful */
+	if (er == EMULATE_FAIL)
 		vcpu->arch.pc = curr_pc;
-	}
 
 	return er;
 }
 
-enum emulation_result
-kvm_mips_emulate_load(uint32_t inst, uint32_t cause,
-		      struct kvm_run *run, struct kvm_vcpu *vcpu)
+enum emulation_result kvm_mips_emulate_load(uint32_t inst, uint32_t cause,
+					    struct kvm_run *run,
+					    struct kvm_vcpu *vcpu)
 {
 	enum emulation_result er = EMULATE_DO_MMIO;
 	int32_t op, base, rt, offset;
@@ -1410,13 +1397,12 @@ int kvm_mips_sync_icache(unsigned long va, struct kvm_vcpu *vcpu)
 #define MIPS_CACHE_DCACHE               0x1
 #define MIPS_CACHE_SEC                  0x3
 
-enum emulation_result
-kvm_mips_emulate_cache(uint32_t inst, uint32_t *opc, uint32_t cause,
-		       struct kvm_run *run, struct kvm_vcpu *vcpu)
+enum emulation_result kvm_mips_emulate_cache(uint32_t inst, uint32_t *opc,
+					     uint32_t cause,
+					     struct kvm_run *run,
+					     struct kvm_vcpu *vcpu)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
-	extern void (*r4k_blast_dcache) (void);
-	extern void (*r4k_blast_icache) (void);
 	enum emulation_result er = EMULATE_DONE;
 	int32_t offset, cache, op_inst, op, base;
 	struct kvm_vcpu_arch *arch = &vcpu->arch;
@@ -1443,14 +1429,15 @@ kvm_mips_emulate_cache(uint32_t inst, uint32_t *opc, uint32_t cause,
 	kvm_debug("CACHE (cache: %#x, op: %#x, base[%d]: %#lx, offset: %#x\n",
 		  cache, op, base, arch->gprs[base], offset);
 
-	/* Treat INDEX_INV as a nop, basically issued by Linux on startup to invalidate
-	 * the caches entirely by stepping through all the ways/indexes
+	/*
+	 * Treat INDEX_INV as a nop, basically issued by Linux on startup to
+	 * invalidate the caches entirely by stepping through all the
+	 * ways/indexes
 	 */
 	if (op == MIPS_CACHE_OP_INDEX_INV) {
-		kvm_debug
-		    ("@ %#lx/%#lx CACHE (cache: %#x, op: %#x, base[%d]: %#lx, offset: %#x\n",
-		     vcpu->arch.pc, vcpu->arch.gprs[31], cache, op, base,
-		     arch->gprs[base], offset);
+		kvm_debug("@ %#lx/%#lx CACHE (cache: %#x, op: %#x, base[%d]: %#lx, offset: %#x\n",
+			  vcpu->arch.pc, vcpu->arch.gprs[31], cache, op, base,
+			  arch->gprs[base], offset);
 
 		if (cache == MIPS_CACHE_DCACHE)
 			r4k_blast_dcache();
@@ -1470,21 +1457,19 @@ kvm_mips_emulate_cache(uint32_t inst, uint32_t *opc, uint32_t cause,
 
 	preempt_disable();
 	if (KVM_GUEST_KSEGX(va) == KVM_GUEST_KSEG0) {
-
-		if (kvm_mips_host_tlb_lookup(vcpu, va) < 0) {
+		if (kvm_mips_host_tlb_lookup(vcpu, va) < 0)
 			kvm_mips_handle_kseg0_tlb_fault(va, vcpu);
-		}
 	} else if ((KVM_GUEST_KSEGX(va) < KVM_GUEST_KSEG0) ||
 		   KVM_GUEST_KSEGX(va) == KVM_GUEST_KSEG23) {
 		int index;
 
 		/* If an entry already exists then skip */
-		if (kvm_mips_host_tlb_lookup(vcpu, va) >= 0) {
+		if (kvm_mips_host_tlb_lookup(vcpu, va) >= 0)
 			goto skip_fault;
-		}
 
-		/* If address not in the guest TLB, then give the guest a fault, the
-		 * resulting handler will do the right thing
+		/*
+		 * If address not in the guest TLB, then give the guest a fault,
+		 * the resulting handler will do the right thing
 		 */
 		index = kvm_mips_guest_tlb_lookup(vcpu, (va & VPN2_MASK) |
 						  (kvm_read_c0_guest_entryhi
@@ -1499,14 +1484,20 @@ kvm_mips_emulate_cache(uint32_t inst, uint32_t *opc, uint32_t cause,
 			goto dont_update_pc;
 		} else {
 			struct kvm_mips_tlb *tlb = &vcpu->arch.guest_tlb[index];
-			/* Check if the entry is valid, if not then setup a TLB invalid exception to the guest */
+			/*
+			 * Check if the entry is valid, if not then setup a TLB
+			 * invalid exception to the guest
+			 */
 			if (!TLB_IS_VALID(*tlb, va)) {
 				er = kvm_mips_emulate_tlbinv_ld(cause, NULL,
 								run, vcpu);
 				preempt_enable();
 				goto dont_update_pc;
 			} else {
-				/* We fault an entry from the guest tlb to the shadow host TLB */
+				/*
+				 * We fault an entry from the guest tlb to the
+				 * shadow host TLB
+				 */
 				kvm_mips_handle_mapped_seg_tlb_fault(vcpu, tlb,
 								     NULL,
 								     NULL);
@@ -1530,7 +1521,10 @@ skip_fault:
 		flush_dcache_line(va);
 
 #ifdef CONFIG_KVM_MIPS_DYN_TRANS
-		/* Replace the CACHE instruction, with a SYNCI, not the same, but avoids a trap */
+		/*
+		 * Replace the CACHE instruction, with a SYNCI, not the same,
+		 * but avoids a trap
+		 */
 		kvm_mips_trans_cache_va(inst, opc, vcpu);
 #endif
 	} else if (op == MIPS_CACHE_OP_HIT_INV && cache == MIPS_CACHE_ICACHE) {
@@ -1552,28 +1546,23 @@ skip_fault:
 
 	preempt_enable();
 
-      dont_update_pc:
-	/*
-	 * Rollback PC
-	 */
+dont_update_pc:
+	/* Rollback PC */
 	vcpu->arch.pc = curr_pc;
-      done:
+done:
 	return er;
 }
 
-enum emulation_result
-kvm_mips_emulate_inst(unsigned long cause, uint32_t *opc,
-		      struct kvm_run *run, struct kvm_vcpu *vcpu)
+enum emulation_result kvm_mips_emulate_inst(unsigned long cause, uint32_t *opc,
+					    struct kvm_run *run,
+					    struct kvm_vcpu *vcpu)
 {
 	enum emulation_result er = EMULATE_DONE;
 	uint32_t inst;
 
-	/*
-	 *  Fetch the instruction.
-	 */
-	if (cause & CAUSEF_BD) {
+	/* Fetch the instruction. */
+	if (cause & CAUSEF_BD)
 		opc += 1;
-	}
 
 	inst = kvm_get_inst(opc, vcpu);
 
@@ -1611,9 +1600,10 @@ kvm_mips_emulate_inst(unsigned long cause, uint32_t *opc,
 	return er;
 }
 
-enum emulation_result
-kvm_mips_emulate_syscall(unsigned long cause, uint32_t *opc,
-			 struct kvm_run *run, struct kvm_vcpu *vcpu)
+enum emulation_result kvm_mips_emulate_syscall(unsigned long cause,
+					       uint32_t *opc,
+					       struct kvm_run *run,
+					       struct kvm_vcpu *vcpu)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	struct kvm_vcpu_arch *arch = &vcpu->arch;
@@ -1645,9 +1635,10 @@ kvm_mips_emulate_syscall(unsigned long cause, uint32_t *opc,
 	return er;
 }
 
-enum emulation_result
-kvm_mips_emulate_tlbmiss_ld(unsigned long cause, uint32_t *opc,
-			    struct kvm_run *run, struct kvm_vcpu *vcpu)
+enum emulation_result kvm_mips_emulate_tlbmiss_ld(unsigned long cause,
+						  uint32_t *opc,
+						  struct kvm_run *run,
+						  struct kvm_vcpu *vcpu)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	struct kvm_vcpu_arch *arch = &vcpu->arch;
@@ -1691,9 +1682,10 @@ kvm_mips_emulate_tlbmiss_ld(unsigned long cause, uint32_t *opc,
 	return er;
 }
 
-enum emulation_result
-kvm_mips_emulate_tlbinv_ld(unsigned long cause, uint32_t *opc,
-			   struct kvm_run *run, struct kvm_vcpu *vcpu)
+enum emulation_result kvm_mips_emulate_tlbinv_ld(unsigned long cause,
+						 uint32_t *opc,
+						 struct kvm_run *run,
+						 struct kvm_vcpu *vcpu)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	struct kvm_vcpu_arch *arch = &vcpu->arch;
@@ -1737,9 +1729,10 @@ kvm_mips_emulate_tlbinv_ld(unsigned long cause, uint32_t *opc,
 	return er;
 }
 
-enum emulation_result
-kvm_mips_emulate_tlbmiss_st(unsigned long cause, uint32_t *opc,
-			    struct kvm_run *run, struct kvm_vcpu *vcpu)
+enum emulation_result kvm_mips_emulate_tlbmiss_st(unsigned long cause,
+						  uint32_t *opc,
+						  struct kvm_run *run,
+						  struct kvm_vcpu *vcpu)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	struct kvm_vcpu_arch *arch = &vcpu->arch;
@@ -1781,9 +1774,10 @@ kvm_mips_emulate_tlbmiss_st(unsigned long cause, uint32_t *opc,
 	return er;
 }
 
-enum emulation_result
-kvm_mips_emulate_tlbinv_st(unsigned long cause, uint32_t *opc,
-			   struct kvm_run *run, struct kvm_vcpu *vcpu)
+enum emulation_result kvm_mips_emulate_tlbinv_st(unsigned long cause,
+						 uint32_t *opc,
+						 struct kvm_run *run,
+						 struct kvm_vcpu *vcpu)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	struct kvm_vcpu_arch *arch = &vcpu->arch;
@@ -1826,9 +1820,9 @@ kvm_mips_emulate_tlbinv_st(unsigned long cause, uint32_t *opc,
 }
 
 /* TLBMOD: store into address matching TLB with Dirty bit off */
-enum emulation_result
-kvm_mips_handle_tlbmod(unsigned long cause, uint32_t *opc,
-		       struct kvm_run *run, struct kvm_vcpu *vcpu)
+enum emulation_result kvm_mips_handle_tlbmod(unsigned long cause, uint32_t *opc,
+					     struct kvm_run *run,
+					     struct kvm_vcpu *vcpu)
 {
 	enum emulation_result er = EMULATE_DONE;
 #ifdef DEBUG
@@ -1837,9 +1831,7 @@ kvm_mips_handle_tlbmod(unsigned long cause, uint32_t *opc,
 				(kvm_read_c0_guest_entryhi(cop0) & ASID_MASK);
 	int index;
 
-	/*
-	 * If address not in the guest TLB, then we are in trouble
-	 */
+	/* If address not in the guest TLB, then we are in trouble */
 	index = kvm_mips_guest_tlb_lookup(vcpu, entryhi);
 	if (index < 0) {
 		/* XXXKYMA Invalidate and retry */
@@ -1856,9 +1848,10 @@ kvm_mips_handle_tlbmod(unsigned long cause, uint32_t *opc,
 	return er;
 }
 
-enum emulation_result
-kvm_mips_emulate_tlbmod(unsigned long cause, uint32_t *opc,
-			struct kvm_run *run, struct kvm_vcpu *vcpu)
+enum emulation_result kvm_mips_emulate_tlbmod(unsigned long cause,
+					      uint32_t *opc,
+					      struct kvm_run *run,
+					      struct kvm_vcpu *vcpu)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	unsigned long entryhi = (vcpu->arch.host_cp0_badvaddr & VPN2_MASK) |
@@ -1898,9 +1891,10 @@ kvm_mips_emulate_tlbmod(unsigned long cause, uint32_t *opc,
 	return er;
 }
 
-enum emulation_result
-kvm_mips_emulate_fpu_exc(unsigned long cause, uint32_t *opc,
-			 struct kvm_run *run, struct kvm_vcpu *vcpu)
+enum emulation_result kvm_mips_emulate_fpu_exc(unsigned long cause,
+					       uint32_t *opc,
+					       struct kvm_run *run,
+					       struct kvm_vcpu *vcpu)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	struct kvm_vcpu_arch *arch = &vcpu->arch;
@@ -1927,9 +1921,10 @@ kvm_mips_emulate_fpu_exc(unsigned long cause, uint32_t *opc,
 	return er;
 }
 
-enum emulation_result
-kvm_mips_emulate_ri_exc(unsigned long cause, uint32_t *opc,
-			struct kvm_run *run, struct kvm_vcpu *vcpu)
+enum emulation_result kvm_mips_emulate_ri_exc(unsigned long cause,
+					      uint32_t *opc,
+					      struct kvm_run *run,
+					      struct kvm_vcpu *vcpu)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	struct kvm_vcpu_arch *arch = &vcpu->arch;
@@ -1961,9 +1956,10 @@ kvm_mips_emulate_ri_exc(unsigned long cause, uint32_t *opc,
 	return er;
 }
 
-enum emulation_result
-kvm_mips_emulate_bp_exc(unsigned long cause, uint32_t *opc,
-			struct kvm_run *run, struct kvm_vcpu *vcpu)
+enum emulation_result kvm_mips_emulate_bp_exc(unsigned long cause,
+					      uint32_t *opc,
+					      struct kvm_run *run,
+					      struct kvm_vcpu *vcpu)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	struct kvm_vcpu_arch *arch = &vcpu->arch;
@@ -1995,9 +1991,7 @@ kvm_mips_emulate_bp_exc(unsigned long cause, uint32_t *opc,
 	return er;
 }
 
-/*
- * ll/sc, rdhwr, sync emulation
- */
+/* ll/sc, rdhwr, sync emulation */
 
 #define OPCODE 0xfc000000
 #define BASE   0x03e00000
@@ -2012,9 +2006,9 @@ kvm_mips_emulate_bp_exc(unsigned long cause, uint32_t *opc,
 #define SYNC   0x0000000f
 #define RDHWR  0x0000003b
 
-enum emulation_result
-kvm_mips_handle_ri(unsigned long cause, uint32_t *opc,
-		   struct kvm_run *run, struct kvm_vcpu *vcpu)
+enum emulation_result kvm_mips_handle_ri(unsigned long cause, uint32_t *opc,
+					 struct kvm_run *run,
+					 struct kvm_vcpu *vcpu)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	struct kvm_vcpu_arch *arch = &vcpu->arch;
@@ -2031,9 +2025,7 @@ kvm_mips_handle_ri(unsigned long cause, uint32_t *opc,
 	if (er == EMULATE_FAIL)
 		return er;
 
-	/*
-	 *  Fetch the instruction.
-	 */
+	/* Fetch the instruction. */
 	if (cause & CAUSEF_BD)
 		opc += 1;
 
@@ -2099,8 +2091,8 @@ emulate_ri:
 	return kvm_mips_emulate_ri_exc(cause, opc, run, vcpu);
 }
 
-enum emulation_result
-kvm_mips_complete_mmio_load(struct kvm_vcpu *vcpu, struct kvm_run *run)
+enum emulation_result kvm_mips_complete_mmio_load(struct kvm_vcpu *vcpu,
+						  struct kvm_run *run)
 {
 	unsigned long *gpr = &vcpu->arch.gprs[vcpu->arch.io_gpr];
 	enum emulation_result er = EMULATE_DONE;
@@ -2142,18 +2134,18 @@ kvm_mips_complete_mmio_load(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	}
 
 	if (vcpu->arch.pending_load_cause & CAUSEF_BD)
-		kvm_debug
-		    ("[%#lx] Completing %d byte BD Load to gpr %d (0x%08lx) type %d\n",
-		     vcpu->arch.pc, run->mmio.len, vcpu->arch.io_gpr, *gpr,
-		     vcpu->mmio_needed);
+		kvm_debug("[%#lx] Completing %d byte BD Load to gpr %d (0x%08lx) type %d\n",
+			  vcpu->arch.pc, run->mmio.len, vcpu->arch.io_gpr, *gpr,
+			  vcpu->mmio_needed);
 
 done:
 	return er;
 }
 
-static enum emulation_result
-kvm_mips_emulate_exc(unsigned long cause, uint32_t *opc,
-		     struct kvm_run *run, struct kvm_vcpu *vcpu)
+static enum emulation_result kvm_mips_emulate_exc(unsigned long cause,
+						  uint32_t *opc,
+						  struct kvm_run *run,
+						  struct kvm_vcpu *vcpu)
 {
 	uint32_t exccode = (cause >> CAUSEB_EXCCODE) & 0x1f;
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
@@ -2188,9 +2180,10 @@ kvm_mips_emulate_exc(unsigned long cause, uint32_t *opc,
 	return er;
 }
 
-enum emulation_result
-kvm_mips_check_privilege(unsigned long cause, uint32_t *opc,
-			 struct kvm_run *run, struct kvm_vcpu *vcpu)
+enum emulation_result kvm_mips_check_privilege(unsigned long cause,
+					       uint32_t *opc,
+					       struct kvm_run *run,
+					       struct kvm_vcpu *vcpu)
 {
 	enum emulation_result er = EMULATE_DONE;
 	uint32_t exccode = (cause >> CAUSEB_EXCCODE) & 0x1f;
@@ -2215,7 +2208,10 @@ kvm_mips_check_privilege(unsigned long cause, uint32_t *opc,
 			break;
 
 		case T_TLB_LD_MISS:
-			/* We we are accessing Guest kernel space, then send an address error exception to the guest */
+			/*
+			 * We we are accessing Guest kernel space, then send an
+			 * address error exception to the guest
+			 */
 			if (badvaddr >= (unsigned long) KVM_GUEST_KSEG0) {
 				printk("%s: LD MISS @ %#lx\n", __func__,
 				       badvaddr);
@@ -2226,7 +2222,10 @@ kvm_mips_check_privilege(unsigned long cause, uint32_t *opc,
 			break;
 
 		case T_TLB_ST_MISS:
-			/* We we are accessing Guest kernel space, then send an address error exception to the guest */
+			/*
+			 * We we are accessing Guest kernel space, then send an
+			 * address error exception to the guest
+			 */
 			if (badvaddr >= (unsigned long) KVM_GUEST_KSEG0) {
 				printk("%s: ST MISS @ %#lx\n", __func__,
 				       badvaddr);
@@ -2260,21 +2259,23 @@ kvm_mips_check_privilege(unsigned long cause, uint32_t *opc,
 		}
 	}
 
-	if (er == EMULATE_PRIV_FAIL) {
+	if (er == EMULATE_PRIV_FAIL)
 		kvm_mips_emulate_exc(cause, opc, run, vcpu);
-	}
+
 	return er;
 }
 
-/* User Address (UA) fault, this could happen if
+/*
+ * User Address (UA) fault, this could happen if
  * (1) TLB entry not present/valid in both Guest and shadow host TLBs, in this
  *     case we pass on the fault to the guest kernel and let it handle it.
  * (2) TLB entry is present in the Guest TLB but not in the shadow, in this
  *     case we inject the TLB from the Guest TLB into the shadow host TLB
  */
-enum emulation_result
-kvm_mips_handle_tlbmiss(unsigned long cause, uint32_t *opc,
-			struct kvm_run *run, struct kvm_vcpu *vcpu)
+enum emulation_result kvm_mips_handle_tlbmiss(unsigned long cause,
+					      uint32_t *opc,
+					      struct kvm_run *run,
+					      struct kvm_vcpu *vcpu)
 {
 	enum emulation_result er = EMULATE_DONE;
 	uint32_t exccode = (cause >> CAUSEB_EXCCODE) & 0x1f;
@@ -2284,10 +2285,11 @@ kvm_mips_handle_tlbmiss(unsigned long cause, uint32_t *opc,
 	kvm_debug("kvm_mips_handle_tlbmiss: badvaddr: %#lx, entryhi: %#lx\n",
 		  vcpu->arch.host_cp0_badvaddr, vcpu->arch.host_cp0_entryhi);
 
-	/* KVM would not have got the exception if this entry was valid in the shadow host TLB
-	 * Check the Guest TLB, if the entry is not there then send the guest an
-	 * exception. The guest exc handler should then inject an entry into the
-	 * guest TLB
+	/*
+	 * KVM would not have got the exception if this entry was valid in the
+	 * shadow host TLB. Check the Guest TLB, if the entry is not there then
+	 * send the guest an exception. The guest exc handler should then inject
+	 * an entry into the guest TLB.
 	 */
 	index = kvm_mips_guest_tlb_lookup(vcpu,
 					  (va & VPN2_MASK) |
@@ -2305,7 +2307,10 @@ kvm_mips_handle_tlbmiss(unsigned long cause, uint32_t *opc,
 	} else {
 		struct kvm_mips_tlb *tlb = &vcpu->arch.guest_tlb[index];
 
-		/* Check if the entry is valid, if not then setup a TLB invalid exception to the guest */
+		/*
+		 * Check if the entry is valid, if not then setup a TLB invalid
+		 * exception to the guest
+		 */
 		if (!TLB_IS_VALID(*tlb, va)) {
 			if (exccode == T_TLB_LD_MISS) {
 				er = kvm_mips_emulate_tlbinv_ld(cause, opc, run,
@@ -2319,10 +2324,12 @@ kvm_mips_handle_tlbmiss(unsigned long cause, uint32_t *opc,
 				er = EMULATE_FAIL;
 			}
 		} else {
-			kvm_debug
-			    ("Injecting hi: %#lx, lo0: %#lx, lo1: %#lx into shadow host TLB\n",
-			     tlb->tlb_hi, tlb->tlb_lo0, tlb->tlb_lo1);
-			/* OK we have a Guest TLB entry, now inject it into the shadow host TLB */
+			kvm_debug("Injecting hi: %#lx, lo0: %#lx, lo1: %#lx into shadow host TLB\n",
+				  tlb->tlb_hi, tlb->tlb_lo0, tlb->tlb_lo1);
+			/*
+			 * OK we have a Guest TLB entry, now inject it into the
+			 * shadow host TLB
+			 */
 			kvm_mips_handle_mapped_seg_tlb_fault(vcpu, tlb, NULL,
 							     NULL);
 		}
diff --git a/arch/mips/kvm/kvm_mips_int.c b/arch/mips/kvm/kvm_mips_int.c
index 1e5de16..d458c04 100644
--- a/arch/mips/kvm/kvm_mips_int.c
+++ b/arch/mips/kvm/kvm_mips_int.c
@@ -1,13 +1,13 @@
 /*
-* This file is subject to the terms and conditions of the GNU General Public
-* License.  See the file "COPYING" in the main directory of this archive
-* for more details.
-*
-* KVM/MIPS: Interrupt delivery
-*
-* Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
-* Authors: Sanjay Lal <sanjayl@kymasys.com>
-*/
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * KVM/MIPS: Interrupt delivery
+ *
+ * Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
+ * Authors: Sanjay Lal <sanjayl@kymasys.com>
+ */
 
 #include <linux/errno.h>
 #include <linux/err.h>
@@ -34,7 +34,8 @@ void kvm_mips_dequeue_irq(struct kvm_vcpu *vcpu, uint32_t priority)
 
 void kvm_mips_queue_timer_int_cb(struct kvm_vcpu *vcpu)
 {
-	/* Cause bits to reflect the pending timer interrupt,
+	/*
+	 * Cause bits to reflect the pending timer interrupt,
 	 * the EXC code will be set when we are actually
 	 * delivering the interrupt:
 	 */
@@ -51,12 +52,13 @@ void kvm_mips_dequeue_timer_int_cb(struct kvm_vcpu *vcpu)
 	kvm_mips_dequeue_irq(vcpu, MIPS_EXC_INT_TIMER);
 }
 
-void
-kvm_mips_queue_io_int_cb(struct kvm_vcpu *vcpu, struct kvm_mips_interrupt *irq)
+void kvm_mips_queue_io_int_cb(struct kvm_vcpu *vcpu,
+			      struct kvm_mips_interrupt *irq)
 {
 	int intr = (int)irq->irq;
 
-	/* Cause bits to reflect the pending IO interrupt,
+	/*
+	 * Cause bits to reflect the pending IO interrupt,
 	 * the EXC code will be set when we are actually
 	 * delivering the interrupt:
 	 */
@@ -83,11 +85,11 @@ kvm_mips_queue_io_int_cb(struct kvm_vcpu *vcpu, struct kvm_mips_interrupt *irq)
 
 }
 
-void
-kvm_mips_dequeue_io_int_cb(struct kvm_vcpu *vcpu,
-			   struct kvm_mips_interrupt *irq)
+void kvm_mips_dequeue_io_int_cb(struct kvm_vcpu *vcpu,
+				struct kvm_mips_interrupt *irq)
 {
 	int intr = (int)irq->irq;
+
 	switch (intr) {
 	case -2:
 		kvm_clear_c0_guest_cause(vcpu->arch.cop0, (C_IRQ0));
@@ -111,9 +113,8 @@ kvm_mips_dequeue_io_int_cb(struct kvm_vcpu *vcpu,
 }
 
 /* Deliver the interrupt of the corresponding priority, if possible. */
-int
-kvm_mips_irq_deliver_cb(struct kvm_vcpu *vcpu, unsigned int priority,
-			uint32_t cause)
+int kvm_mips_irq_deliver_cb(struct kvm_vcpu *vcpu, unsigned int priority,
+			    uint32_t cause)
 {
 	int allowed = 0;
 	uint32_t exccode;
@@ -164,7 +165,6 @@ kvm_mips_irq_deliver_cb(struct kvm_vcpu *vcpu, unsigned int priority,
 
 	/* Are we allowed to deliver the interrupt ??? */
 	if (allowed) {
-
 		if ((kvm_read_c0_guest_status(cop0) & ST0_EXL) == 0) {
 			/* save old pc */
 			kvm_write_c0_guest_epc(cop0, arch->pc);
@@ -195,9 +195,8 @@ kvm_mips_irq_deliver_cb(struct kvm_vcpu *vcpu, unsigned int priority,
 	return allowed;
 }
 
-int
-kvm_mips_irq_clear_cb(struct kvm_vcpu *vcpu, unsigned int priority,
-		      uint32_t cause)
+int kvm_mips_irq_clear_cb(struct kvm_vcpu *vcpu, unsigned int priority,
+			  uint32_t cause)
 {
 	return 1;
 }
diff --git a/arch/mips/kvm/kvm_mips_int.h b/arch/mips/kvm/kvm_mips_int.h
index 20da7d2..4ab4bdf 100644
--- a/arch/mips/kvm/kvm_mips_int.h
+++ b/arch/mips/kvm/kvm_mips_int.h
@@ -1,14 +1,15 @@
 /*
-* This file is subject to the terms and conditions of the GNU General Public
-* License.  See the file "COPYING" in the main directory of this archive
-* for more details.
-*
-* KVM/MIPS: Interrupts
-* Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
-* Authors: Sanjay Lal <sanjayl@kymasys.com>
-*/
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * KVM/MIPS: Interrupts
+ * Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
+ * Authors: Sanjay Lal <sanjayl@kymasys.com>
+ */
 
-/* MIPS Exception Priorities, exceptions (including interrupts) are queued up
+/*
+ * MIPS Exception Priorities, exceptions (including interrupts) are queued up
  * for the guest in the order specified by their priorities
  */
 
@@ -27,6 +28,9 @@
 #define MIPS_EXC_MAX                12
 /* XXXSL More to follow */
 
+extern char mips32_exception[], mips32_exceptionEnd[];
+extern char mips32_GuestException[], mips32_GuestExceptionEnd[];
+
 #define C_TI        (_ULCAST_(1) << 30)
 
 #define KVM_MIPS_IRQ_DELIVER_ALL_AT_ONCE (0)
diff --git a/arch/mips/kvm/kvm_mips_opcode.h b/arch/mips/kvm/kvm_mips_opcode.h
index 86d3b4c..03a6ae8 100644
--- a/arch/mips/kvm/kvm_mips_opcode.h
+++ b/arch/mips/kvm/kvm_mips_opcode.h
@@ -1,24 +1,22 @@
 /*
-* This file is subject to the terms and conditions of the GNU General Public
-* License.  See the file "COPYING" in the main directory of this archive
-* for more details.
-*
-* Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
-* Authors: Sanjay Lal <sanjayl@kymasys.com>
-*/
-
-/*
- * Define opcode values not defined in <asm/isnt.h>
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
+ * Authors: Sanjay Lal <sanjayl@kymasys.com>
  */
 
+/* Define opcode values not defined in <asm/isnt.h> */
+
 #ifndef __KVM_MIPS_OPCODE_H__
 #define __KVM_MIPS_OPCODE_H__
 
 /* COP0 Ops */
-#define     mfmcz_op         0x0b	/*  01011  */
-#define     wrpgpr_op        0x0e	/*  01110  */
+#define mfmcz_op	0x0b	/* 01011 */
+#define wrpgpr_op	0x0e	/* 01110 */
 
-/*  COP0 opcodes (only if COP0 and CO=1):  */
-#define     wait_op               0x20	/*  100000  */
+/* COP0 opcodes (only if COP0 and CO=1): */
+#define wait_op		0x20	/* 100000 */
 
 #endif /* __KVM_MIPS_OPCODE_H__ */
diff --git a/arch/mips/kvm/kvm_mips_stats.c b/arch/mips/kvm/kvm_mips_stats.c
index 075904b..6efef38 100644
--- a/arch/mips/kvm/kvm_mips_stats.c
+++ b/arch/mips/kvm/kvm_mips_stats.c
@@ -1,13 +1,13 @@
 /*
-* This file is subject to the terms and conditions of the GNU General Public
-* License.  See the file "COPYING" in the main directory of this archive
-* for more details.
-*
-* KVM/MIPS: COP0 access histogram
-*
-* Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
-* Authors: Sanjay Lal <sanjayl@kymasys.com>
-*/
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * KVM/MIPS: COP0 access histogram
+ *
+ * Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
+ * Authors: Sanjay Lal <sanjayl@kymasys.com>
+ */
 
 #include <linux/kvm_host.h>
 
diff --git a/arch/mips/kvm/kvm_tlb.c b/arch/mips/kvm/kvm_tlb.c
index 8a5a700..bb7418b 100644
--- a/arch/mips/kvm/kvm_tlb.c
+++ b/arch/mips/kvm/kvm_tlb.c
@@ -1,14 +1,14 @@
 /*
-* This file is subject to the terms and conditions of the GNU General Public
-* License.  See the file "COPYING" in the main directory of this archive
-* for more details.
-*
-* KVM/MIPS TLB handling, this file is part of the Linux host kernel so that
-* TLB handlers run from KSEG0
-*
-* Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
-* Authors: Sanjay Lal <sanjayl@kymasys.com>
-*/
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * KVM/MIPS TLB handling, this file is part of the Linux host kernel so that
+ * TLB handlers run from KSEG0
+ *
+ * Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
+ * Authors: Sanjay Lal <sanjayl@kymasys.com>
+ */
 
 #include <linux/sched.h>
 #include <linux/smp.h>
@@ -18,7 +18,6 @@
 #include <linux/kvm_host.h>
 #include <linux/srcu.h>
 
-
 #include <asm/cpu.h>
 #include <asm/bootinfo.h>
 #include <asm/mmu_context.h>
@@ -39,13 +38,13 @@ atomic_t kvm_mips_instance;
 EXPORT_SYMBOL(kvm_mips_instance);
 
 /* These function pointers are initialized once the KVM module is loaded */
-pfn_t(*kvm_mips_gfn_to_pfn) (struct kvm *kvm, gfn_t gfn);
+pfn_t (*kvm_mips_gfn_to_pfn)(struct kvm *kvm, gfn_t gfn);
 EXPORT_SYMBOL(kvm_mips_gfn_to_pfn);
 
-void (*kvm_mips_release_pfn_clean) (pfn_t pfn);
+void (*kvm_mips_release_pfn_clean)(pfn_t pfn);
 EXPORT_SYMBOL(kvm_mips_release_pfn_clean);
 
-bool(*kvm_mips_is_error_pfn) (pfn_t pfn);
+bool (*kvm_mips_is_error_pfn)(pfn_t pfn);
 EXPORT_SYMBOL(kvm_mips_is_error_pfn);
 
 uint32_t kvm_mips_get_kernel_asid(struct kvm_vcpu *vcpu)
@@ -53,21 +52,17 @@ uint32_t kvm_mips_get_kernel_asid(struct kvm_vcpu *vcpu)
 	return vcpu->arch.guest_kernel_asid[smp_processor_id()] & ASID_MASK;
 }
 
-
 uint32_t kvm_mips_get_user_asid(struct kvm_vcpu *vcpu)
 {
 	return vcpu->arch.guest_user_asid[smp_processor_id()] & ASID_MASK;
 }
 
-inline uint32_t kvm_mips_get_commpage_asid (struct kvm_vcpu *vcpu)
+inline uint32_t kvm_mips_get_commpage_asid(struct kvm_vcpu *vcpu)
 {
 	return vcpu->kvm->arch.commpage_tlb;
 }
 
-
-/*
- * Structure defining an tlb entry data set.
- */
+/* Structure defining an tlb entry data set. */
 
 void kvm_mips_dump_host_tlbs(void)
 {
@@ -116,6 +111,7 @@ void kvm_mips_dump_host_tlbs(void)
 	mtc0_tlbw_hazard();
 	local_irq_restore(flags);
 }
+EXPORT_SYMBOL(kvm_mips_dump_host_tlbs);
 
 void kvm_mips_dump_guest_tlbs(struct kvm_vcpu *vcpu)
 {
@@ -143,6 +139,7 @@ void kvm_mips_dump_guest_tlbs(struct kvm_vcpu *vcpu)
 		       (tlb.tlb_lo1 >> 3) & 7, tlb.tlb_mask);
 	}
 }
+EXPORT_SYMBOL(kvm_mips_dump_guest_tlbs);
 
 static int kvm_mips_map_page(struct kvm *kvm, gfn_t gfn)
 {
@@ -152,7 +149,7 @@ static int kvm_mips_map_page(struct kvm *kvm, gfn_t gfn)
 	if (kvm->arch.guest_pmap[gfn] != KVM_INVALID_PAGE)
 		return 0;
 
-        srcu_idx = srcu_read_lock(&kvm->srcu);
+	srcu_idx = srcu_read_lock(&kvm->srcu);
 	pfn = kvm_mips_gfn_to_pfn(kvm, gfn);
 
 	if (kvm_mips_is_error_pfn(pfn)) {
@@ -169,7 +166,7 @@ out:
 
 /* Translate guest KSEG0 addresses to Host PA */
 unsigned long kvm_mips_translate_guest_kseg0_to_hpa(struct kvm_vcpu *vcpu,
-	unsigned long gva)
+						    unsigned long gva)
 {
 	gfn_t gfn;
 	uint32_t offset = gva & ~PAGE_MASK;
@@ -194,12 +191,13 @@ unsigned long kvm_mips_translate_guest_kseg0_to_hpa(struct kvm_vcpu *vcpu,
 
 	return (kvm->arch.guest_pmap[gfn] << PAGE_SHIFT) + offset;
 }
+EXPORT_SYMBOL(kvm_mips_translate_guest_kseg0_to_hpa);
 
 /* XXXKYMA: Must be called with interrupts disabled */
 /* set flush_dcache_mask == 0 if no dcache flush required */
-int
-kvm_mips_host_tlb_write(struct kvm_vcpu *vcpu, unsigned long entryhi,
-	unsigned long entrylo0, unsigned long entrylo1, int flush_dcache_mask)
+int kvm_mips_host_tlb_write(struct kvm_vcpu *vcpu, unsigned long entryhi,
+			    unsigned long entrylo0, unsigned long entrylo1,
+			    int flush_dcache_mask)
 {
 	unsigned long flags;
 	unsigned long old_entryhi;
@@ -207,7 +205,6 @@ kvm_mips_host_tlb_write(struct kvm_vcpu *vcpu, unsigned long entryhi,
 
 	local_irq_save(flags);
 
-
 	old_entryhi = read_c0_entryhi();
 	write_c0_entryhi(entryhi);
 	mtc0_tlbw_hazard();
@@ -240,12 +237,14 @@ kvm_mips_host_tlb_write(struct kvm_vcpu *vcpu, unsigned long entryhi,
 	if (flush_dcache_mask) {
 		if (entrylo0 & MIPS3_PG_V) {
 			++vcpu->stat.flush_dcache_exits;
-			flush_data_cache_page((entryhi & VPN2_MASK) & ~flush_dcache_mask);
+			flush_data_cache_page((entryhi & VPN2_MASK) &
+					      ~flush_dcache_mask);
 		}
 		if (entrylo1 & MIPS3_PG_V) {
 			++vcpu->stat.flush_dcache_exits;
-			flush_data_cache_page(((entryhi & VPN2_MASK) & ~flush_dcache_mask) |
-				(0x1 << PAGE_SHIFT));
+			flush_data_cache_page(((entryhi & VPN2_MASK) &
+					       ~flush_dcache_mask) |
+					      (0x1 << PAGE_SHIFT));
 		}
 	}
 
@@ -257,10 +256,9 @@ kvm_mips_host_tlb_write(struct kvm_vcpu *vcpu, unsigned long entryhi,
 	return 0;
 }
 
-
 /* XXXKYMA: Must be called with interrupts disabled */
 int kvm_mips_handle_kseg0_tlb_fault(unsigned long badvaddr,
-	struct kvm_vcpu *vcpu)
+				    struct kvm_vcpu *vcpu)
 {
 	gfn_t gfn;
 	pfn_t pfn0, pfn1;
@@ -270,7 +268,6 @@ int kvm_mips_handle_kseg0_tlb_fault(unsigned long badvaddr,
 	struct kvm *kvm = vcpu->kvm;
 	const int flush_dcache_mask = 0;
 
-
 	if (KVM_GUEST_KSEGX(badvaddr) != KVM_GUEST_KSEG0) {
 		kvm_err("%s: Invalid BadVaddr: %#lx\n", __func__, badvaddr);
 		kvm_mips_dump_host_tlbs();
@@ -302,14 +299,15 @@ int kvm_mips_handle_kseg0_tlb_fault(unsigned long badvaddr,
 	}
 
 	entryhi = (vaddr | kvm_mips_get_kernel_asid(vcpu));
-	entrylo0 = mips3_paddr_to_tlbpfn(pfn0 << PAGE_SHIFT) | (0x3 << 3) | (1 << 2) |
-			(0x1 << 1);
-	entrylo1 = mips3_paddr_to_tlbpfn(pfn1 << PAGE_SHIFT) | (0x3 << 3) | (1 << 2) |
-			(0x1 << 1);
+	entrylo0 = mips3_paddr_to_tlbpfn(pfn0 << PAGE_SHIFT) | (0x3 << 3) |
+		   (1 << 2) | (0x1 << 1);
+	entrylo1 = mips3_paddr_to_tlbpfn(pfn1 << PAGE_SHIFT) | (0x3 << 3) |
+		   (1 << 2) | (0x1 << 1);
 
 	return kvm_mips_host_tlb_write(vcpu, entryhi, entrylo0, entrylo1,
 				       flush_dcache_mask);
 }
+EXPORT_SYMBOL(kvm_mips_handle_kseg0_tlb_fault);
 
 int kvm_mips_handle_commpage_tlb_fault(unsigned long badvaddr,
 	struct kvm_vcpu *vcpu)
@@ -318,11 +316,10 @@ int kvm_mips_handle_commpage_tlb_fault(unsigned long badvaddr,
 	unsigned long flags, old_entryhi = 0, vaddr = 0;
 	unsigned long entrylo0 = 0, entrylo1 = 0;
 
-
 	pfn0 = CPHYSADDR(vcpu->arch.kseg0_commpage) >> PAGE_SHIFT;
 	pfn1 = 0;
-	entrylo0 = mips3_paddr_to_tlbpfn(pfn0 << PAGE_SHIFT) | (0x3 << 3) | (1 << 2) |
-			(0x1 << 1);
+	entrylo0 = mips3_paddr_to_tlbpfn(pfn0 << PAGE_SHIFT) | (0x3 << 3) |
+		   (1 << 2) | (0x1 << 1);
 	entrylo1 = 0;
 
 	local_irq_save(flags);
@@ -341,9 +338,9 @@ int kvm_mips_handle_commpage_tlb_fault(unsigned long badvaddr,
 	mtc0_tlbw_hazard();
 	tlbw_use_hazard();
 
-	kvm_debug ("@ %#lx idx: %2d [entryhi(R): %#lx] entrylo0 (R): 0x%08lx, entrylo1(R): 0x%08lx\n",
-	     vcpu->arch.pc, read_c0_index(), read_c0_entryhi(),
-	     read_c0_entrylo0(), read_c0_entrylo1());
+	kvm_debug("@ %#lx idx: %2d [entryhi(R): %#lx] entrylo0 (R): 0x%08lx, entrylo1(R): 0x%08lx\n",
+		  vcpu->arch.pc, read_c0_index(), read_c0_entryhi(),
+		  read_c0_entrylo0(), read_c0_entrylo1());
 
 	/* Restore old ASID */
 	write_c0_entryhi(old_entryhi);
@@ -353,28 +350,33 @@ int kvm_mips_handle_commpage_tlb_fault(unsigned long badvaddr,
 
 	return 0;
 }
+EXPORT_SYMBOL(kvm_mips_handle_commpage_tlb_fault);
 
-int
-kvm_mips_handle_mapped_seg_tlb_fault(struct kvm_vcpu *vcpu,
-	struct kvm_mips_tlb *tlb, unsigned long *hpa0, unsigned long *hpa1)
+int kvm_mips_handle_mapped_seg_tlb_fault(struct kvm_vcpu *vcpu,
+					 struct kvm_mips_tlb *tlb,
+					 unsigned long *hpa0,
+					 unsigned long *hpa1)
 {
 	unsigned long entryhi = 0, entrylo0 = 0, entrylo1 = 0;
 	struct kvm *kvm = vcpu->kvm;
 	pfn_t pfn0, pfn1;
 
-
 	if ((tlb->tlb_hi & VPN2_MASK) == 0) {
 		pfn0 = 0;
 		pfn1 = 0;
 	} else {
-		if (kvm_mips_map_page(kvm, mips3_tlbpfn_to_paddr(tlb->tlb_lo0) >> PAGE_SHIFT) < 0)
+		if (kvm_mips_map_page(kvm, mips3_tlbpfn_to_paddr(tlb->tlb_lo0)
+					   >> PAGE_SHIFT) < 0)
 			return -1;
 
-		if (kvm_mips_map_page(kvm, mips3_tlbpfn_to_paddr(tlb->tlb_lo1) >> PAGE_SHIFT) < 0)
+		if (kvm_mips_map_page(kvm, mips3_tlbpfn_to_paddr(tlb->tlb_lo1)
+					   >> PAGE_SHIFT) < 0)
 			return -1;
 
-		pfn0 = kvm->arch.guest_pmap[mips3_tlbpfn_to_paddr(tlb->tlb_lo0) >> PAGE_SHIFT];
-		pfn1 = kvm->arch.guest_pmap[mips3_tlbpfn_to_paddr(tlb->tlb_lo1) >> PAGE_SHIFT];
+		pfn0 = kvm->arch.guest_pmap[mips3_tlbpfn_to_paddr(tlb->tlb_lo0)
+					    >> PAGE_SHIFT];
+		pfn1 = kvm->arch.guest_pmap[mips3_tlbpfn_to_paddr(tlb->tlb_lo1)
+					    >> PAGE_SHIFT];
 	}
 
 	if (hpa0)
@@ -385,11 +387,12 @@ kvm_mips_handle_mapped_seg_tlb_fault(struct kvm_vcpu *vcpu,
 
 	/* Get attributes from the Guest TLB */
 	entryhi = (tlb->tlb_hi & VPN2_MASK) | (KVM_GUEST_KERNEL_MODE(vcpu) ?
-			kvm_mips_get_kernel_asid(vcpu) : kvm_mips_get_user_asid(vcpu));
+					       kvm_mips_get_kernel_asid(vcpu) :
+					       kvm_mips_get_user_asid(vcpu));
 	entrylo0 = mips3_paddr_to_tlbpfn(pfn0 << PAGE_SHIFT) | (0x3 << 3) |
-			(tlb->tlb_lo0 & MIPS3_PG_D) | (tlb->tlb_lo0 & MIPS3_PG_V);
+		   (tlb->tlb_lo0 & MIPS3_PG_D) | (tlb->tlb_lo0 & MIPS3_PG_V);
 	entrylo1 = mips3_paddr_to_tlbpfn(pfn1 << PAGE_SHIFT) | (0x3 << 3) |
-			(tlb->tlb_lo1 & MIPS3_PG_D) | (tlb->tlb_lo1 & MIPS3_PG_V);
+		   (tlb->tlb_lo1 & MIPS3_PG_D) | (tlb->tlb_lo1 & MIPS3_PG_V);
 
 	kvm_debug("@ %#lx tlb_lo0: 0x%08lx tlb_lo1: 0x%08lx\n", vcpu->arch.pc,
 		  tlb->tlb_lo0, tlb->tlb_lo1);
@@ -397,6 +400,7 @@ kvm_mips_handle_mapped_seg_tlb_fault(struct kvm_vcpu *vcpu,
 	return kvm_mips_host_tlb_write(vcpu, entryhi, entrylo0, entrylo1,
 				       tlb->tlb_mask);
 }
+EXPORT_SYMBOL(kvm_mips_handle_mapped_seg_tlb_fault);
 
 int kvm_mips_guest_tlb_lookup(struct kvm_vcpu *vcpu, unsigned long entryhi)
 {
@@ -404,10 +408,9 @@ int kvm_mips_guest_tlb_lookup(struct kvm_vcpu *vcpu, unsigned long entryhi)
 	int index = -1;
 	struct kvm_mips_tlb *tlb = vcpu->arch.guest_tlb;
 
-
 	for (i = 0; i < KVM_MIPS_GUEST_TLB_SIZE; i++) {
-		if (((TLB_VPN2(tlb[i]) & ~tlb[i].tlb_mask) == ((entryhi & VPN2_MASK) & ~tlb[i].tlb_mask)) &&
-			(TLB_IS_GLOBAL(tlb[i]) || (TLB_ASID(tlb[i]) == (entryhi & ASID_MASK)))) {
+		if (TLB_HI_VPN2_HIT(tlb[i], entryhi) &&
+		    TLB_HI_ASID_HIT(tlb[i], entryhi)) {
 			index = i;
 			break;
 		}
@@ -418,21 +421,23 @@ int kvm_mips_guest_tlb_lookup(struct kvm_vcpu *vcpu, unsigned long entryhi)
 
 	return index;
 }
+EXPORT_SYMBOL(kvm_mips_guest_tlb_lookup);
 
 int kvm_mips_host_tlb_lookup(struct kvm_vcpu *vcpu, unsigned long vaddr)
 {
 	unsigned long old_entryhi, flags;
 	volatile int idx;
 
-
 	local_irq_save(flags);
 
 	old_entryhi = read_c0_entryhi();
 
 	if (KVM_GUEST_KERNEL_MODE(vcpu))
-		write_c0_entryhi((vaddr & VPN2_MASK) | kvm_mips_get_kernel_asid(vcpu));
+		write_c0_entryhi((vaddr & VPN2_MASK) |
+				 kvm_mips_get_kernel_asid(vcpu));
 	else {
-		write_c0_entryhi((vaddr & VPN2_MASK) | kvm_mips_get_user_asid(vcpu));
+		write_c0_entryhi((vaddr & VPN2_MASK) |
+				 kvm_mips_get_user_asid(vcpu));
 	}
 
 	mtc0_tlbw_hazard();
@@ -452,6 +457,7 @@ int kvm_mips_host_tlb_lookup(struct kvm_vcpu *vcpu, unsigned long vaddr)
 
 	return idx;
 }
+EXPORT_SYMBOL(kvm_mips_host_tlb_lookup);
 
 int kvm_mips_host_tlb_inv(struct kvm_vcpu *vcpu, unsigned long va)
 {
@@ -460,7 +466,6 @@ int kvm_mips_host_tlb_inv(struct kvm_vcpu *vcpu, unsigned long va)
 
 	local_irq_save(flags);
 
-
 	old_entryhi = read_c0_entryhi();
 
 	write_c0_entryhi((va & VPN2_MASK) | kvm_mips_get_user_asid(vcpu));
@@ -499,8 +504,9 @@ int kvm_mips_host_tlb_inv(struct kvm_vcpu *vcpu, unsigned long va)
 
 	return 0;
 }
+EXPORT_SYMBOL(kvm_mips_host_tlb_inv);
 
-/* XXXKYMA: Fix Guest USER/KERNEL no longer share the same ASID*/
+/* XXXKYMA: Fix Guest USER/KERNEL no longer share the same ASID */
 int kvm_mips_host_tlb_inv_index(struct kvm_vcpu *vcpu, int index)
 {
 	unsigned long flags, old_entryhi;
@@ -510,7 +516,6 @@ int kvm_mips_host_tlb_inv_index(struct kvm_vcpu *vcpu, int index)
 
 	local_irq_save(flags);
 
-
 	old_entryhi = read_c0_entryhi();
 
 	write_c0_entryhi(UNIQUE_ENTRYHI(index));
@@ -546,7 +551,6 @@ void kvm_mips_flush_host_tlb(int skip_kseg0)
 	int entry = 0;
 	int maxentry = current_cpu_data.tlbsize;
 
-
 	local_irq_save(flags);
 
 	old_entryhi = read_c0_entryhi();
@@ -554,7 +558,6 @@ void kvm_mips_flush_host_tlb(int skip_kseg0)
 
 	/* Blast 'em all away. */
 	for (entry = 0; entry < maxentry; entry++) {
-
 		write_c0_index(entry);
 		mtc0_tlbw_hazard();
 
@@ -565,9 +568,8 @@ void kvm_mips_flush_host_tlb(int skip_kseg0)
 			entryhi = read_c0_entryhi();
 
 			/* Don't blow away guest kernel entries */
-			if (KVM_GUEST_KSEGX(entryhi) == KVM_GUEST_KSEG0) {
+			if (KVM_GUEST_KSEGX(entryhi) == KVM_GUEST_KSEG0)
 				continue;
-			}
 		}
 
 		/* Make sure all entries differ. */
@@ -591,17 +593,17 @@ void kvm_mips_flush_host_tlb(int skip_kseg0)
 
 	local_irq_restore(flags);
 }
+EXPORT_SYMBOL(kvm_mips_flush_host_tlb);
 
-void
-kvm_get_new_mmu_context(struct mm_struct *mm, unsigned long cpu,
-			struct kvm_vcpu *vcpu)
+void kvm_get_new_mmu_context(struct mm_struct *mm, unsigned long cpu,
+			     struct kvm_vcpu *vcpu)
 {
 	unsigned long asid = asid_cache(cpu);
 
-	if (!((asid += ASID_INC) & ASID_MASK)) {
-		if (cpu_has_vtag_icache) {
+	asid += ASID_INC;
+	if (!(asid & ASID_MASK)) {
+		if (cpu_has_vtag_icache)
 			flush_icache_all();
-		}
 
 		kvm_local_flush_tlb_all();      /* start new asid cycle */
 
@@ -639,6 +641,7 @@ void kvm_local_flush_tlb_all(void)
 
 	local_irq_restore(flags);
 }
+EXPORT_SYMBOL(kvm_local_flush_tlb_all);
 
 /**
  * kvm_mips_migrate_count() - Migrate timer.
@@ -699,7 +702,10 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	}
 
 	if (!newasid) {
-		/* If we preempted while the guest was executing, then reload the pre-empted ASID */
+		/*
+		 * If we preempted while the guest was executing, then reload
+		 * the pre-empted ASID
+		 */
 		if (current->flags & PF_VCPU) {
 			write_c0_entryhi(vcpu->arch.
 					 preempt_entryhi & ASID_MASK);
@@ -708,9 +714,10 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	} else {
 		/* New ASIDs were allocated for the VM */
 
-		/* Were we in guest context? If so then the pre-empted ASID is no longer
-		 * valid, we need to set it to what it should be based on the mode of
-		 * the Guest (Kernel/User)
+		/*
+		 * Were we in guest context? If so then the pre-empted ASID is
+		 * no longer valid, we need to set it to what it should be based
+		 * on the mode of the Guest (Kernel/User)
 		 */
 		if (current->flags & PF_VCPU) {
 			if (KVM_GUEST_KERNEL_MODE(vcpu))
@@ -728,6 +735,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	local_irq_restore(flags);
 
 }
+EXPORT_SYMBOL(kvm_arch_vcpu_load);
 
 /* ASID can change if another task is scheduled during preemption */
 void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
@@ -739,7 +747,6 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 
 	cpu = smp_processor_id();
 
-
 	vcpu->arch.preempt_entryhi = read_c0_entryhi();
 	vcpu->arch.last_sched_cpu = cpu;
 
@@ -754,11 +761,12 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 
 	local_irq_restore(flags);
 }
+EXPORT_SYMBOL(kvm_arch_vcpu_put);
 
 uint32_t kvm_get_inst(uint32_t *opc, struct kvm_vcpu *vcpu)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
-	unsigned long paddr, flags;
+	unsigned long paddr, flags, vpn2, asid;
 	uint32_t inst;
 	int index;
 
@@ -769,16 +777,12 @@ uint32_t kvm_get_inst(uint32_t *opc, struct kvm_vcpu *vcpu)
 		if (index >= 0) {
 			inst = *(opc);
 		} else {
-			index =
-			    kvm_mips_guest_tlb_lookup(vcpu,
-						      ((unsigned long) opc & VPN2_MASK)
-						      |
-						      (kvm_read_c0_guest_entryhi
-						       (cop0) & ASID_MASK));
+			vpn2 = (unsigned long) opc & VPN2_MASK;
+			asid = kvm_read_c0_guest_entryhi(cop0) & ASID_MASK;
+			index = kvm_mips_guest_tlb_lookup(vcpu, vpn2 | asid);
 			if (index < 0) {
-				kvm_err
-				    ("%s: get_user_failed for %p, vcpu: %p, ASID: %#lx\n",
-				     __func__, opc, vcpu, read_c0_entryhi());
+				kvm_err("%s: get_user_failed for %p, vcpu: %p, ASID: %#lx\n",
+					__func__, opc, vcpu, read_c0_entryhi());
 				kvm_mips_dump_host_tlbs();
 				local_irq_restore(flags);
 				return KVM_INVALID_INST;
@@ -793,7 +797,7 @@ uint32_t kvm_get_inst(uint32_t *opc, struct kvm_vcpu *vcpu)
 	} else if (KVM_GUEST_KSEGX(opc) == KVM_GUEST_KSEG0) {
 		paddr =
 		    kvm_mips_translate_guest_kseg0_to_hpa(vcpu,
-							 (unsigned long) opc);
+							  (unsigned long) opc);
 		inst = *(uint32_t *) CKSEG0ADDR(paddr);
 	} else {
 		kvm_err("%s: illegal address: %p\n", __func__, opc);
@@ -802,18 +806,4 @@ uint32_t kvm_get_inst(uint32_t *opc, struct kvm_vcpu *vcpu)
 
 	return inst;
 }
-
-EXPORT_SYMBOL(kvm_local_flush_tlb_all);
-EXPORT_SYMBOL(kvm_mips_handle_mapped_seg_tlb_fault);
-EXPORT_SYMBOL(kvm_mips_handle_commpage_tlb_fault);
-EXPORT_SYMBOL(kvm_mips_dump_host_tlbs);
-EXPORT_SYMBOL(kvm_mips_handle_kseg0_tlb_fault);
-EXPORT_SYMBOL(kvm_mips_host_tlb_lookup);
-EXPORT_SYMBOL(kvm_mips_flush_host_tlb);
-EXPORT_SYMBOL(kvm_mips_guest_tlb_lookup);
-EXPORT_SYMBOL(kvm_mips_host_tlb_inv);
-EXPORT_SYMBOL(kvm_mips_translate_guest_kseg0_to_hpa);
-EXPORT_SYMBOL(kvm_mips_dump_guest_tlbs);
 EXPORT_SYMBOL(kvm_get_inst);
-EXPORT_SYMBOL(kvm_arch_vcpu_load);
-EXPORT_SYMBOL(kvm_arch_vcpu_put);
diff --git a/arch/mips/kvm/kvm_trap_emul.c b/arch/mips/kvm/kvm_trap_emul.c
index 693f952..106335b 100644
--- a/arch/mips/kvm/kvm_trap_emul.c
+++ b/arch/mips/kvm/kvm_trap_emul.c
@@ -1,13 +1,13 @@
 /*
-* This file is subject to the terms and conditions of the GNU General Public
-* License.  See the file "COPYING" in the main directory of this archive
-* for more details.
-*
-* KVM/MIPS: Deliver/Emulate exceptions to the guest kernel
-*
-* Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
-* Authors: Sanjay Lal <sanjayl@kymasys.com>
-*/
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * KVM/MIPS: Deliver/Emulate exceptions to the guest kernel
+ *
+ * Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
+ * Authors: Sanjay Lal <sanjayl@kymasys.com>
+ */
 
 #include <linux/errno.h>
 #include <linux/err.h>
@@ -37,7 +37,6 @@ static gpa_t kvm_trap_emul_gva_to_gpa_cb(gva_t gva)
 	return gpa;
 }
 
-
 static int kvm_trap_emul_handle_cop_unusable(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
@@ -46,9 +45,9 @@ static int kvm_trap_emul_handle_cop_unusable(struct kvm_vcpu *vcpu)
 	enum emulation_result er = EMULATE_DONE;
 	int ret = RESUME_GUEST;
 
-	if (((cause & CAUSEF_CE) >> CAUSEB_CE) == 1) {
+	if (((cause & CAUSEF_CE) >> CAUSEB_CE) == 1)
 		er = kvm_mips_emulate_fpu_exc(cause, opc, run, vcpu);
-	} else
+	else
 		er = kvm_mips_emulate_inst(cause, opc, run, vcpu);
 
 	switch (er) {
@@ -83,9 +82,8 @@ static int kvm_trap_emul_handle_tlb_mod(struct kvm_vcpu *vcpu)
 
 	if (KVM_GUEST_KSEGX(badvaddr) < KVM_GUEST_KSEG0
 	    || KVM_GUEST_KSEGX(badvaddr) == KVM_GUEST_KSEG23) {
-		kvm_debug
-		    ("USER/KSEG23 ADDR TLB MOD fault: cause %#lx, PC: %p, BadVaddr: %#lx\n",
-		     cause, opc, badvaddr);
+		kvm_debug("USER/KSEG23 ADDR TLB MOD fault: cause %#lx, PC: %p, BadVaddr: %#lx\n",
+			  cause, opc, badvaddr);
 		er = kvm_mips_handle_tlbmod(cause, opc, run, vcpu);
 
 		if (er == EMULATE_DONE)
@@ -95,8 +93,10 @@ static int kvm_trap_emul_handle_tlb_mod(struct kvm_vcpu *vcpu)
 			ret = RESUME_HOST;
 		}
 	} else if (KVM_GUEST_KSEGX(badvaddr) == KVM_GUEST_KSEG0) {
-		/* XXXKYMA: The guest kernel does not expect to get this fault when we are not
-		 * using HIGHMEM. Need to address this in a HIGHMEM kernel
+		/*
+		 * XXXKYMA: The guest kernel does not expect to get this fault
+		 * when we are not using HIGHMEM. Need to address this in a
+		 * HIGHMEM kernel
 		 */
 		printk
 		    ("TLB MOD fault not handled, cause %#lx, PC: %p, BadVaddr: %#lx\n",
@@ -134,9 +134,8 @@ static int kvm_trap_emul_handle_tlb_st_miss(struct kvm_vcpu *vcpu)
 		}
 	} else if (KVM_GUEST_KSEGX(badvaddr) < KVM_GUEST_KSEG0
 		   || KVM_GUEST_KSEGX(badvaddr) == KVM_GUEST_KSEG23) {
-		kvm_debug
-		    ("USER ADDR TLB LD fault: cause %#lx, PC: %p, BadVaddr: %#lx\n",
-		     cause, opc, badvaddr);
+		kvm_debug("USER ADDR TLB LD fault: cause %#lx, PC: %p, BadVaddr: %#lx\n",
+			  cause, opc, badvaddr);
 		er = kvm_mips_handle_tlbmiss(cause, opc, run, vcpu);
 		if (er == EMULATE_DONE)
 			ret = RESUME_GUEST;
@@ -145,8 +144,9 @@ static int kvm_trap_emul_handle_tlb_st_miss(struct kvm_vcpu *vcpu)
 			ret = RESUME_HOST;
 		}
 	} else if (KVM_GUEST_KSEGX(badvaddr) == KVM_GUEST_KSEG0) {
-		/* All KSEG0 faults are handled by KVM, as the guest kernel does not
-		 * expect to ever get them
+		/*
+		 * All KSEG0 faults are handled by KVM, as the guest kernel does
+		 * not expect to ever get them
 		 */
 		if (kvm_mips_handle_kseg0_tlb_fault
 		    (vcpu->arch.host_cp0_badvaddr, vcpu) < 0) {
@@ -154,9 +154,8 @@ static int kvm_trap_emul_handle_tlb_st_miss(struct kvm_vcpu *vcpu)
 			ret = RESUME_HOST;
 		}
 	} else {
-		kvm_err
-		    ("Illegal TLB LD fault address , cause %#lx, PC: %p, BadVaddr: %#lx\n",
-		     cause, opc, badvaddr);
+		kvm_err("Illegal TLB LD fault address , cause %#lx, PC: %p, BadVaddr: %#lx\n",
+			cause, opc, badvaddr);
 		kvm_mips_dump_host_tlbs();
 		kvm_arch_vcpu_dump_regs(vcpu);
 		run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
@@ -185,11 +184,14 @@ static int kvm_trap_emul_handle_tlb_ld_miss(struct kvm_vcpu *vcpu)
 		kvm_debug("USER ADDR TLB ST fault: PC: %#lx, BadVaddr: %#lx\n",
 			  vcpu->arch.pc, badvaddr);
 
-		/* User Address (UA) fault, this could happen if
-		 * (1) TLB entry not present/valid in both Guest and shadow host TLBs, in this
-		 *     case we pass on the fault to the guest kernel and let it handle it.
-		 * (2) TLB entry is present in the Guest TLB but not in the shadow, in this
-		 *     case we inject the TLB from the Guest TLB into the shadow host TLB
+		/*
+		 * User Address (UA) fault, this could happen if
+		 * (1) TLB entry not present/valid in both Guest and shadow host
+		 *     TLBs, in this case we pass on the fault to the guest
+		 *     kernel and let it handle it.
+		 * (2) TLB entry is present in the Guest TLB but not in the
+		 *     shadow, in this case we inject the TLB from the Guest TLB
+		 *     into the shadow host TLB
 		 */
 
 		er = kvm_mips_handle_tlbmiss(cause, opc, run, vcpu);
@@ -349,9 +351,9 @@ static int kvm_trap_emul_vcpu_setup(struct kvm_vcpu *vcpu)
 	uint32_t config1;
 	int vcpu_id = vcpu->vcpu_id;
 
-	/* Arch specific stuff, set up config registers properly so that the
-	 * guest will come up as expected, for now we simulate a
-	 * MIPS 24kc
+	/*
+	 * Arch specific stuff, set up config registers properly so that the
+	 * guest will come up as expected, for now we simulate a MIPS 24kc
 	 */
 	kvm_write_c0_guest_prid(cop0, 0x00019300);
 	kvm_write_c0_guest_config(cop0,
@@ -373,14 +375,15 @@ static int kvm_trap_emul_vcpu_setup(struct kvm_vcpu *vcpu)
 
 	kvm_write_c0_guest_config2(cop0, MIPS_CONFIG2);
 	/* MIPS_CONFIG2 | (read_c0_config2() & 0xfff) */
-	kvm_write_c0_guest_config3(cop0,
-				   MIPS_CONFIG3 | (0 << CP0C3_VInt) | (1 <<
-								       CP0C3_ULRI));
+	kvm_write_c0_guest_config3(cop0, MIPS_CONFIG3 | (0 << CP0C3_VInt) |
+					 (1 << CP0C3_ULRI));
 
 	/* Set Wait IE/IXMT Ignore in Config7, IAR, AR */
 	kvm_write_c0_guest_config7(cop0, (MIPS_CONF7_WII) | (1 << 10));
 
-	/* Setup IntCtl defaults, compatibilty mode for timer interrupts (HW5) */
+	/*
+	 * Setup IntCtl defaults, compatibilty mode for timer interrupts (HW5)
+	 */
 	kvm_write_c0_guest_intctl(cop0, 0xFC000000);
 
 	/* Put in vcpu id as CPUNum into Ebase Reg to handle SMP Guests */
diff --git a/arch/mips/kvm/trace.h b/arch/mips/kvm/trace.h
index bc9e0f4..c1388d4 100644
--- a/arch/mips/kvm/trace.h
+++ b/arch/mips/kvm/trace.h
@@ -1,11 +1,11 @@
 /*
-* This file is subject to the terms and conditions of the GNU General Public
-* License.  See the file "COPYING" in the main directory of this archive
-* for more details.
-*
-* Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
-* Authors: Sanjay Lal <sanjayl@kymasys.com>
-*/
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
+ * Authors: Sanjay Lal <sanjayl@kymasys.com>
+ */
 
 #if !defined(_TRACE_KVM_H) || defined(TRACE_HEADER_MULTI_READ)
 #define _TRACE_KVM_H
@@ -17,9 +17,7 @@
 #define TRACE_INCLUDE_PATH .
 #define TRACE_INCLUDE_FILE trace
 
-/*
- * Tracepoints for VM eists
- */
+/* Tracepoints for VM eists */
 extern char *kvm_mips_exit_types_str[MAX_KVM_MIPS_EXIT_TYPES];
 
 TRACE_EVENT(kvm_exit,
-- 
1.8.5.3
