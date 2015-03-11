Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Mar 2015 15:53:32 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:2616 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013429AbbCKOsVGAW7d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Mar 2015 15:48:21 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C441D4DBE2F77;
        Wed, 11 Mar 2015 14:48:12 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 11 Mar 2015 14:48:14 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 11 Mar 2015 14:48:14 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
        <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Gleb Natapov <gleb@kernel.org>
Subject: [PATCH 16/20] MIPS: KVM: Add base guest MSA support
Date:   Wed, 11 Mar 2015 14:44:52 +0000
Message-ID: <1426085096-12932-17-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.0.5
In-Reply-To: <1426085096-12932-1-git-send-email-james.hogan@imgtec.com>
References: <1426085096-12932-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46333
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

Add base code for supporting the MIPS SIMD Architecture (MSA) in MIPS
KVM guests. MSA cannot yet be enabled in the guest, we're just laying
the groundwork.

As with the FPU, whether the guest's MSA context is loaded is stored in
another bit in the fpu_inuse vcpu member. This allows MSA to be disabled
when the guest disables it, but keeping the MSA context loaded so it
doesn't have to be reloaded if the guest re-enables it.

New assembly code is added for saving and restoring the MSA context,
restoring only the upper half of the MSA context (for if the FPU context
is already loaded) and for saving/clearing and restoring MSACSR (which
can itself cause an MSA FP exception depending on the value). The MSACSR
is restored before returning to the guest if MSA is already enabled, and
the existing FP exception die notifier is extended to catch the possible
MSA FP exception and step over the ctcmsa instruction.

The helper function kvm_own_msa() is added to enable MSA and restore
the MSA context if it isn't already loaded, which will be used in a
later patch when the guest attempts to use MSA for the first time and
triggers an MSA disabled exception.

The existing FPU helpers are extended to handle MSA. kvm_lose_fpu()
saves the full MSA context if it is loaded (which includes the FPU
context) and both kvm_lose_fpu() and kvm_drop_fpu() disable MSA.

kvm_own_fpu() also needs to lose any MSA context if FR=0, since there
would be a risk of getting reserved instruction exceptions if CU1 is
enabled and we later try and save the MSA context. We shouldn't usually
hit this case since it will be handled when emulating CU1 changes,
however there's nothing to stop the guest modifying the Status register
directly via the comm page, which will cause this case to get hit.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h |  21 ++++-
 arch/mips/kernel/asm-offsets.c   |   1 +
 arch/mips/kvm/Makefile           |   6 +-
 arch/mips/kvm/locore.S           |  21 +++++
 arch/mips/kvm/mips.c             | 132 ++++++++++++++++++++++++++++----
 arch/mips/kvm/msa.S              | 161 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 323 insertions(+), 19 deletions(-)
 create mode 100644 arch/mips/kvm/msa.S

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index fb264d8695e4..1dc0dca15cbd 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -360,6 +360,7 @@ struct kvm_mips_tlb {
 };
 
 #define KVM_MIPS_FPU_FPU	0x1
+#define KVM_MIPS_FPU_MSA	0x2
 
 #define KVM_MIPS_GUEST_TLB_SIZE	64
 struct kvm_vcpu_arch {
@@ -432,6 +433,7 @@ struct kvm_vcpu_arch {
 	int wait;
 
 	u8 fpu_enabled;
+	u8 msa_enabled;
 };
 
 
@@ -576,6 +578,18 @@ static inline bool kvm_mips_guest_has_fpu(struct kvm_vcpu_arch *vcpu)
 		kvm_read_c0_guest_config1(vcpu->cop0) & MIPS_CONF1_FP;
 }
 
+static inline bool kvm_mips_guest_can_have_msa(struct kvm_vcpu_arch *vcpu)
+{
+	return (!__builtin_constant_p(cpu_has_msa) || cpu_has_msa) &&
+		vcpu->msa_enabled;
+}
+
+static inline bool kvm_mips_guest_has_msa(struct kvm_vcpu_arch *vcpu)
+{
+	return kvm_mips_guest_can_have_msa(vcpu) &&
+		kvm_read_c0_guest_config3(vcpu->cop0) & MIPS_CONF3_MSA;
+}
+
 struct kvm_mips_callbacks {
 	int (*handle_cop_unusable)(struct kvm_vcpu *vcpu);
 	int (*handle_tlb_mod)(struct kvm_vcpu *vcpu);
@@ -619,11 +633,16 @@ int kvm_arch_vcpu_dump_regs(struct kvm_vcpu *vcpu);
 /* Trampoline ASM routine to start running in "Guest" context */
 extern int __kvm_mips_vcpu_run(struct kvm_run *run, struct kvm_vcpu *vcpu);
 
-/* FPU context management */
+/* FPU/MSA context management */
 void __kvm_save_fpu(struct kvm_vcpu_arch *vcpu);
 void __kvm_restore_fpu(struct kvm_vcpu_arch *vcpu);
 void __kvm_restore_fcsr(struct kvm_vcpu_arch *vcpu);
+void __kvm_save_msa(struct kvm_vcpu_arch *vcpu);
+void __kvm_restore_msa(struct kvm_vcpu_arch *vcpu);
+void __kvm_restore_msa_upper(struct kvm_vcpu_arch *vcpu);
+void __kvm_restore_msacsr(struct kvm_vcpu_arch *vcpu);
 void kvm_own_fpu(struct kvm_vcpu *vcpu);
+void kvm_own_msa(struct kvm_vcpu *vcpu);
 void kvm_drop_fpu(struct kvm_vcpu *vcpu);
 void kvm_lose_fpu(struct kvm_vcpu *vcpu);
 
diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index a12bcf920073..e59fd7cfac9e 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -440,6 +440,7 @@ void output_kvm_defines(void)
 	OFFSET(VCPU_FPR31, kvm_vcpu_arch, fpu.fpr[31]);
 
 	OFFSET(VCPU_FCR31, kvm_vcpu_arch, fpu.fcr31);
+	OFFSET(VCPU_MSA_CSR, kvm_vcpu_arch, fpu.msacsr);
 	BLANK();
 
 	OFFSET(VCPU_COP0, kvm_vcpu_arch, cop0);
diff --git a/arch/mips/kvm/Makefile b/arch/mips/kvm/Makefile
index 78d7bcd7710a..637ebbebd549 100644
--- a/arch/mips/kvm/Makefile
+++ b/arch/mips/kvm/Makefile
@@ -1,11 +1,13 @@
 # Makefile for KVM support for MIPS
 #
 
-common-objs = $(addprefix ../../../virt/kvm/, kvm_main.o coalesced_mmio.o)
+common-objs-y = $(addprefix ../../../virt/kvm/, kvm_main.o coalesced_mmio.o)
 
 EXTRA_CFLAGS += -Ivirt/kvm -Iarch/mips/kvm
 
-kvm-objs := $(common-objs) mips.o emulate.o locore.o \
+common-objs-$(CONFIG_CPU_HAS_MSA) += msa.o
+
+kvm-objs := $(common-objs-y) mips.o emulate.o locore.o \
 	    interrupt.o stats.o commpage.o \
 	    dyntrans.o trap_emul.o fpu.o
 
diff --git a/arch/mips/kvm/locore.S b/arch/mips/kvm/locore.S
index f5594049c0c3..c567240386a0 100644
--- a/arch/mips/kvm/locore.S
+++ b/arch/mips/kvm/locore.S
@@ -36,6 +36,8 @@
 #define PT_HOST_USERLOCAL   PT_EPC
 
 #define CP0_DDATA_LO        $28,3
+#define CP0_CONFIG3         $16,3
+#define CP0_CONFIG5         $16,5
 #define CP0_EBASE           $15,1
 
 #define CP0_INTCTL          $12,1
@@ -370,6 +372,25 @@ NESTED (MIPSX(GuestException), CALLFRAME_SIZ, ra)
 	.set	noat
 1:
 
+#ifdef CONFIG_CPU_HAS_MSA
+	/*
+	 * If MSA is enabled, save MSACSR and clear it so that later
+	 * instructions don't trigger MSAFPE for pending exceptions.
+	 */
+	mfc0	t0, CP0_CONFIG3
+	ext	t0, t0, 28, 1 /* MIPS_CONF3_MSAP */
+	beqz	t0, 1f
+	 nop
+	mfc0	t0, CP0_CONFIG5
+	ext	t0, t0, 27, 1 /* MIPS_CONF5_MSAEN */
+	beqz	t0, 1f
+	 nop
+	_cfcmsa	t0, MSA_CSR
+	sw	t0, VCPU_MSA_CSR(k1)
+	_ctcmsa	MSA_CSR, zero
+1:
+#endif
+
 	/* Now that the new EBASE has been loaded, unset BEV and KSU_USER */
 	.set	at
 	and	v0, v0, ~(ST0_EXL | KSU_USER | ST0_IE)
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 6cdb2a1cd8ec..17434e8b452d 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -1295,17 +1295,21 @@ skip_emul:
 
 	if (ret == RESUME_GUEST) {
 		/*
-		 * If FPU is enabled (i.e. the guest's FPU context is live),
-		 * restore FCR31.
+		 * If FPU / MSA are enabled (i.e. the guest's FPU / MSA context
+		 * is live), restore FCR31 / MSACSR.
 		 *
 		 * This should be before returning to the guest exception
-		 * vector, as it may well cause an FP exception if there are
-		 * pending exception bits unmasked. (see
+		 * vector, as it may well cause an [MSA] FP exception if there
+		 * are pending exception bits unmasked. (see
 		 * kvm_mips_csr_die_notifier() for how that is handled).
 		 */
 		if (kvm_mips_guest_has_fpu(&vcpu->arch) &&
 		    read_c0_status() & ST0_CU1)
 			__kvm_restore_fcsr(&vcpu->arch);
+
+		if (kvm_mips_guest_has_msa(&vcpu->arch) &&
+		    read_c0_config5() & MIPS_CONF5_MSAEN)
+			__kvm_restore_msacsr(&vcpu->arch);
 	}
 
 	/* Disable HTW before returning to guest or host */
@@ -1322,11 +1326,26 @@ void kvm_own_fpu(struct kvm_vcpu *vcpu)
 
 	preempt_disable();
 
+	sr = kvm_read_c0_guest_status(cop0);
+
+	/*
+	 * If MSA state is already live, it is undefined how it interacts with
+	 * FR=0 FPU state, and we don't want to hit reserved instruction
+	 * exceptions trying to save the MSA state later when CU=1 && FR=1, so
+	 * play it safe and save it first.
+	 *
+	 * In theory we shouldn't ever hit this case since kvm_lose_fpu() should
+	 * get called when guest CU1 is set, however we can't trust the guest
+	 * not to clobber the status register directly via the commpage.
+	 */
+	if (cpu_has_msa && sr & ST0_CU1 && !(sr & ST0_FR) &&
+	    vcpu->arch.fpu_inuse & KVM_MIPS_FPU_MSA)
+		kvm_lose_fpu(vcpu);
+
 	/*
 	 * Enable FPU for guest
 	 * We set FR and FRE according to guest context
 	 */
-	sr = kvm_read_c0_guest_status(cop0);
 	change_c0_status(ST0_CU1 | ST0_FR, sr);
 	if (cpu_has_fre) {
 		cfg5 = kvm_read_c0_guest_config5(cop0);
@@ -1343,10 +1362,73 @@ void kvm_own_fpu(struct kvm_vcpu *vcpu)
 	preempt_enable();
 }
 
-/* Drop FPU without saving it */
+#ifdef CONFIG_CPU_HAS_MSA
+/* Enable MSA for guest and restore context */
+void kvm_own_msa(struct kvm_vcpu *vcpu)
+{
+	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	unsigned int sr, cfg5;
+
+	preempt_disable();
+
+	/*
+	 * Enable FPU if enabled in guest, since we're restoring FPU context
+	 * anyway. We set FR and FRE according to guest context.
+	 */
+	if (kvm_mips_guest_has_fpu(&vcpu->arch)) {
+		sr = kvm_read_c0_guest_status(cop0);
+
+		/*
+		 * If FR=0 FPU state is already live, it is undefined how it
+		 * interacts with MSA state, so play it safe and save it first.
+		 */
+		if (!(sr & ST0_FR) &&
+		    (vcpu->arch.fpu_inuse & (KVM_MIPS_FPU_FPU |
+				KVM_MIPS_FPU_MSA)) == KVM_MIPS_FPU_FPU)
+			kvm_lose_fpu(vcpu);
+
+		change_c0_status(ST0_CU1 | ST0_FR, sr);
+		if (sr & ST0_CU1 && cpu_has_fre) {
+			cfg5 = kvm_read_c0_guest_config5(cop0);
+			change_c0_config5(MIPS_CONF5_FRE, cfg5);
+		}
+	}
+
+	/* Enable MSA for guest */
+	set_c0_config5(MIPS_CONF5_MSAEN);
+	enable_fpu_hazard();
+
+	switch (vcpu->arch.fpu_inuse & (KVM_MIPS_FPU_FPU | KVM_MIPS_FPU_MSA)) {
+	case KVM_MIPS_FPU_FPU:
+		/*
+		 * Guest FPU state already loaded, only restore upper MSA state
+		 */
+		__kvm_restore_msa_upper(&vcpu->arch);
+		vcpu->arch.fpu_inuse |= KVM_MIPS_FPU_MSA;
+		break;
+	case 0:
+		/* Neither FPU or MSA already active, restore full MSA state */
+		__kvm_restore_msa(&vcpu->arch);
+		vcpu->arch.fpu_inuse |= KVM_MIPS_FPU_MSA;
+		if (kvm_mips_guest_has_fpu(&vcpu->arch))
+			vcpu->arch.fpu_inuse |= KVM_MIPS_FPU_FPU;
+		break;
+	default:
+		break;
+	}
+
+	preempt_enable();
+}
+#endif
+
+/* Drop FPU & MSA without saving it */
 void kvm_drop_fpu(struct kvm_vcpu *vcpu)
 {
 	preempt_disable();
+	if (cpu_has_msa && vcpu->arch.fpu_inuse & KVM_MIPS_FPU_MSA) {
+		disable_msa();
+		vcpu->arch.fpu_inuse &= ~KVM_MIPS_FPU_MSA;
+	}
 	if (vcpu->arch.fpu_inuse & KVM_MIPS_FPU_FPU) {
 		clear_c0_status(ST0_CU1 | ST0_FR);
 		vcpu->arch.fpu_inuse &= ~KVM_MIPS_FPU_FPU;
@@ -1354,18 +1436,29 @@ void kvm_drop_fpu(struct kvm_vcpu *vcpu)
 	preempt_enable();
 }
 
-/* Save and disable FPU */
+/* Save and disable FPU & MSA */
 void kvm_lose_fpu(struct kvm_vcpu *vcpu)
 {
 	/*
-	 * FPU gets disabled in root context (hardware) when it is disabled in
-	 * guest context (software), but the register state in the hardware may
-	 * still be in use. This is why we explicitly re-enable the hardware
+	 * FPU & MSA get disabled in root context (hardware) when it is disabled
+	 * in guest context (software), but the register state in the hardware
+	 * may still be in use. This is why we explicitly re-enable the hardware
 	 * before saving.
 	 */
 
 	preempt_disable();
-	if (vcpu->arch.fpu_inuse & KVM_MIPS_FPU_FPU) {
+	if (cpu_has_msa && vcpu->arch.fpu_inuse & KVM_MIPS_FPU_MSA) {
+		set_c0_config5(MIPS_CONF5_MSAEN);
+		enable_fpu_hazard();
+
+		__kvm_save_msa(&vcpu->arch);
+
+		/* Disable MSA & FPU */
+		disable_msa();
+		if (vcpu->arch.fpu_inuse & KVM_MIPS_FPU_FPU)
+			clear_c0_status(ST0_CU1 | ST0_FR);
+		vcpu->arch.fpu_inuse &= ~(KVM_MIPS_FPU_FPU | KVM_MIPS_FPU_MSA);
+	} else if (vcpu->arch.fpu_inuse & KVM_MIPS_FPU_FPU) {
 		set_c0_status(ST0_CU1);
 		enable_fpu_hazard();
 
@@ -1379,9 +1472,9 @@ void kvm_lose_fpu(struct kvm_vcpu *vcpu)
 }
 
 /*
- * Step over a specific ctc1 to FCSR which is used to restore guest FCSR state
- * and may trigger a "harmless" FP exception if cause bits are set in the value
- * being written.
+ * Step over a specific ctc1 to FCSR and a specific ctcmsa to MSACSR which are
+ * used to restore guest FCSR/MSACSR state and may trigger a "harmless" FP/MSAFP
+ * exception if cause bits are set in the value being written.
  */
 static int kvm_mips_csr_die_notify(struct notifier_block *self,
 				   unsigned long cmd, void *ptr)
@@ -1390,8 +1483,8 @@ static int kvm_mips_csr_die_notify(struct notifier_block *self,
 	struct pt_regs *regs = args->regs;
 	unsigned long pc;
 
-	/* Only interested in FPE */
-	if (cmd != DIE_FP)
+	/* Only interested in FPE and MSAFPE */
+	if (cmd != DIE_FP && cmd != DIE_MSAFP)
 		return NOTIFY_DONE;
 
 	/* Return immediately if guest context isn't active */
@@ -1408,6 +1501,13 @@ static int kvm_mips_csr_die_notify(struct notifier_block *self,
 		if (pc != (unsigned long)&__kvm_restore_fcsr + 4)
 			return NOTIFY_DONE;
 		break;
+	case DIE_MSAFP:
+		/* match 2nd/3rd instruction in __kvm_restore_msacsr */
+		if (!cpu_has_msa ||
+		    pc < (unsigned long)&__kvm_restore_msacsr + 4 ||
+		    pc > (unsigned long)&__kvm_restore_msacsr + 8)
+			return NOTIFY_DONE;
+		break;
 	}
 
 	/* Move PC forward a little and continue executing */
diff --git a/arch/mips/kvm/msa.S b/arch/mips/kvm/msa.S
new file mode 100644
index 000000000000..d02f0c6cc2cc
--- /dev/null
+++ b/arch/mips/kvm/msa.S
@@ -0,0 +1,161 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * MIPS SIMD Architecture (MSA) context handling code for KVM.
+ *
+ * Copyright (C) 2015 Imagination Technologies Ltd.
+ */
+
+#include <asm/asm.h>
+#include <asm/asm-offsets.h>
+#include <asm/asmmacro.h>
+#include <asm/regdef.h>
+
+	.set	noreorder
+	.set	noat
+
+LEAF(__kvm_save_msa)
+	st_d	0,  VCPU_FPR0,  a0
+	st_d	1,  VCPU_FPR1,  a0
+	st_d	2,  VCPU_FPR2,  a0
+	st_d	3,  VCPU_FPR3,  a0
+	st_d	4,  VCPU_FPR4,  a0
+	st_d	5,  VCPU_FPR5,  a0
+	st_d	6,  VCPU_FPR6,  a0
+	st_d	7,  VCPU_FPR7,  a0
+	st_d	8,  VCPU_FPR8,  a0
+	st_d	9,  VCPU_FPR9,  a0
+	st_d	10, VCPU_FPR10, a0
+	st_d	11, VCPU_FPR11, a0
+	st_d	12, VCPU_FPR12, a0
+	st_d	13, VCPU_FPR13, a0
+	st_d	14, VCPU_FPR14, a0
+	st_d	15, VCPU_FPR15, a0
+	st_d	16, VCPU_FPR16, a0
+	st_d	17, VCPU_FPR17, a0
+	st_d	18, VCPU_FPR18, a0
+	st_d	19, VCPU_FPR19, a0
+	st_d	20, VCPU_FPR20, a0
+	st_d	21, VCPU_FPR21, a0
+	st_d	22, VCPU_FPR22, a0
+	st_d	23, VCPU_FPR23, a0
+	st_d	24, VCPU_FPR24, a0
+	st_d	25, VCPU_FPR25, a0
+	st_d	26, VCPU_FPR26, a0
+	st_d	27, VCPU_FPR27, a0
+	st_d	28, VCPU_FPR28, a0
+	st_d	29, VCPU_FPR29, a0
+	st_d	30, VCPU_FPR30, a0
+	st_d	31, VCPU_FPR31, a0
+	jr	ra
+	 nop
+	END(__kvm_save_msa)
+
+LEAF(__kvm_restore_msa)
+	ld_d	0,  VCPU_FPR0,  a0
+	ld_d	1,  VCPU_FPR1,  a0
+	ld_d	2,  VCPU_FPR2,  a0
+	ld_d	3,  VCPU_FPR3,  a0
+	ld_d	4,  VCPU_FPR4,  a0
+	ld_d	5,  VCPU_FPR5,  a0
+	ld_d	6,  VCPU_FPR6,  a0
+	ld_d	7,  VCPU_FPR7,  a0
+	ld_d	8,  VCPU_FPR8,  a0
+	ld_d	9,  VCPU_FPR9,  a0
+	ld_d	10, VCPU_FPR10, a0
+	ld_d	11, VCPU_FPR11, a0
+	ld_d	12, VCPU_FPR12, a0
+	ld_d	13, VCPU_FPR13, a0
+	ld_d	14, VCPU_FPR14, a0
+	ld_d	15, VCPU_FPR15, a0
+	ld_d	16, VCPU_FPR16, a0
+	ld_d	17, VCPU_FPR17, a0
+	ld_d	18, VCPU_FPR18, a0
+	ld_d	19, VCPU_FPR19, a0
+	ld_d	20, VCPU_FPR20, a0
+	ld_d	21, VCPU_FPR21, a0
+	ld_d	22, VCPU_FPR22, a0
+	ld_d	23, VCPU_FPR23, a0
+	ld_d	24, VCPU_FPR24, a0
+	ld_d	25, VCPU_FPR25, a0
+	ld_d	26, VCPU_FPR26, a0
+	ld_d	27, VCPU_FPR27, a0
+	ld_d	28, VCPU_FPR28, a0
+	ld_d	29, VCPU_FPR29, a0
+	ld_d	30, VCPU_FPR30, a0
+	ld_d	31, VCPU_FPR31, a0
+	jr	ra
+	 nop
+	END(__kvm_restore_msa)
+
+	.macro	kvm_restore_msa_upper	wr, off, base
+	.set	push
+	.set	noat
+#ifdef CONFIG_64BIT
+	ld	$1, \off(\base)
+	insert_d \wr, 1
+#elif defined(CONFIG_CPU_LITTLE_ENDIAN)
+	lw	$1, \off(\base)
+	insert_w \wr, 2
+	lw	$1, (\off+4)(\base)
+	insert_w \wr, 3
+#else /* CONFIG_CPU_BIG_ENDIAN */
+	lw	$1, (\off+4)(\base)
+	insert_w \wr, 2
+	lw	$1, \off(\base)
+	insert_w \wr, 3
+#endif
+	.set	pop
+	.endm
+
+LEAF(__kvm_restore_msa_upper)
+	kvm_restore_msa_upper	0,  VCPU_FPR0 +8, a0
+	kvm_restore_msa_upper	1,  VCPU_FPR1 +8, a0
+	kvm_restore_msa_upper	2,  VCPU_FPR2 +8, a0
+	kvm_restore_msa_upper	3,  VCPU_FPR3 +8, a0
+	kvm_restore_msa_upper	4,  VCPU_FPR4 +8, a0
+	kvm_restore_msa_upper	5,  VCPU_FPR5 +8, a0
+	kvm_restore_msa_upper	6,  VCPU_FPR6 +8, a0
+	kvm_restore_msa_upper	7,  VCPU_FPR7 +8, a0
+	kvm_restore_msa_upper	8,  VCPU_FPR8 +8, a0
+	kvm_restore_msa_upper	9,  VCPU_FPR9 +8, a0
+	kvm_restore_msa_upper	10, VCPU_FPR10+8, a0
+	kvm_restore_msa_upper	11, VCPU_FPR11+8, a0
+	kvm_restore_msa_upper	12, VCPU_FPR12+8, a0
+	kvm_restore_msa_upper	13, VCPU_FPR13+8, a0
+	kvm_restore_msa_upper	14, VCPU_FPR14+8, a0
+	kvm_restore_msa_upper	15, VCPU_FPR15+8, a0
+	kvm_restore_msa_upper	16, VCPU_FPR16+8, a0
+	kvm_restore_msa_upper	17, VCPU_FPR17+8, a0
+	kvm_restore_msa_upper	18, VCPU_FPR18+8, a0
+	kvm_restore_msa_upper	19, VCPU_FPR19+8, a0
+	kvm_restore_msa_upper	20, VCPU_FPR20+8, a0
+	kvm_restore_msa_upper	21, VCPU_FPR21+8, a0
+	kvm_restore_msa_upper	22, VCPU_FPR22+8, a0
+	kvm_restore_msa_upper	23, VCPU_FPR23+8, a0
+	kvm_restore_msa_upper	24, VCPU_FPR24+8, a0
+	kvm_restore_msa_upper	25, VCPU_FPR25+8, a0
+	kvm_restore_msa_upper	26, VCPU_FPR26+8, a0
+	kvm_restore_msa_upper	27, VCPU_FPR27+8, a0
+	kvm_restore_msa_upper	28, VCPU_FPR28+8, a0
+	kvm_restore_msa_upper	29, VCPU_FPR29+8, a0
+	kvm_restore_msa_upper	30, VCPU_FPR30+8, a0
+	kvm_restore_msa_upper	31, VCPU_FPR31+8, a0
+	jr	ra
+	 nop
+	END(__kvm_restore_msa_upper)
+
+LEAF(__kvm_restore_msacsr)
+	lw	t0, VCPU_MSA_CSR(a0)
+	/*
+	 * The ctcmsa must stay at this offset in __kvm_restore_msacsr.
+	 * See kvm_mips_csr_die_notify() which handles t0 containing a value
+	 * which triggers an MSA FP Exception, which must be stepped over and
+	 * ignored since the set cause bits must remain there for the guest.
+	 */
+	_ctcmsa	MSA_CSR, t0
+	jr	ra
+	 nop
+	END(__kvm_restore_msacsr)
-- 
2.0.5
