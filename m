Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Mar 2015 15:51:45 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:63254 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013402AbbCKOsRch0Yp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Mar 2015 15:48:17 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 8055B11D41038;
        Wed, 11 Mar 2015 14:48:08 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 11 Mar 2015 14:48:11 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 11 Mar 2015 14:48:10 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
        <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Gleb Natapov <gleb@kernel.org>
Subject: [PATCH 11/20] MIPS: KVM: Add base guest FPU support
Date:   Wed, 11 Mar 2015 14:44:47 +0000
Message-ID: <1426085096-12932-12-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 46327
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

Add base code for supporting FPU in MIPS KVM guests. The FPU cannot yet
be enabled in the guest, we're just laying the groundwork.

Whether the guest's FPU context is loaded is stored in a bit in the
fpu_inuse vcpu member. This allows the FPU to be disabled when the guest
disables it, but keeping the FPU context loaded so it doesn't have to be
reloaded if the guest re-enables it.

An fpu_enabled vcpu member stores whether userland has enabled the FPU
capability (which will be wired up in a later patch).

New assembly code is added for saving and restoring the FPU context, and
for saving/clearing and restoring FCSR (which can itself cause an FP
exception depending on the value). The FCSR is restored before returning
to the guest if the FPU is already enabled, and a die notifier is
registered to catch the possible FP exception and step over the ctc1
instruction.

The helper function kvm_lose_fpu() is added to save FPU context and
disable the FPU, which is used when saving hardware state before a
context switch or KVM exit (the vcpu_get_regs() callback).

The helper function kvm_own_fpu() is added to enable the FPU and restore
the FPU context if it isn't already loaded, which will be used in a
later patch when the guest attempts to use the FPU for the first time
and triggers a co-processor unusable exception.

The helper function kvm_drop_fpu() is added to discard the FPU context
and disable the FPU, which will be used in a later patch when the FPU
state will become architecturally UNPREDICTABLE (change of FR mode) to
force a reload of [stale] context in the new FR mode.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h |  27 +++++++++
 arch/mips/kernel/asm-offsets.c   |  38 ++++++++++++
 arch/mips/kvm/Makefile           |   2 +-
 arch/mips/kvm/fpu.S              | 122 +++++++++++++++++++++++++++++++++++++
 arch/mips/kvm/locore.S           |  17 ++++++
 arch/mips/kvm/mips.c             | 126 +++++++++++++++++++++++++++++++++++++++
 arch/mips/kvm/trap_emul.c        |   2 +
 7 files changed, 333 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/kvm/fpu.S

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index fb79d67de192..866edf330e53 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -357,6 +357,8 @@ struct kvm_mips_tlb {
 	long tlb_lo1;
 };
 
+#define KVM_MIPS_FPU_FPU	0x1
+
 #define KVM_MIPS_GUEST_TLB_SIZE	64
 struct kvm_vcpu_arch {
 	void *host_ebase, *guest_ebase;
@@ -378,6 +380,8 @@ struct kvm_vcpu_arch {
 
 	/* FPU State */
 	struct mips_fpu_struct fpu;
+	/* Which FPU state is loaded (KVM_MIPS_FPU_*) */
+	unsigned int fpu_inuse;
 
 	/* COP0 State */
 	struct mips_coproc *cop0;
@@ -424,6 +428,8 @@ struct kvm_vcpu_arch {
 
 	/* WAIT executed */
 	int wait;
+
+	u8 fpu_enabled;
 };
 
 
@@ -554,6 +560,19 @@ static inline void _kvm_atomic_change_c0_guest_reg(unsigned long *reg,
 	kvm_set_c0_guest_ebase(cop0, ((val) & (change)));		\
 }
 
+/* Helpers */
+
+static inline bool kvm_mips_guest_can_have_fpu(struct kvm_vcpu_arch *vcpu)
+{
+	return (!__builtin_constant_p(cpu_has_fpu) || cpu_has_fpu) &&
+		vcpu->fpu_enabled;
+}
+
+static inline bool kvm_mips_guest_has_fpu(struct kvm_vcpu_arch *vcpu)
+{
+	return kvm_mips_guest_can_have_fpu(vcpu) &&
+		kvm_read_c0_guest_config1(vcpu->cop0) & MIPS_CONF1_FP;
+}
 
 struct kvm_mips_callbacks {
 	int (*handle_cop_unusable)(struct kvm_vcpu *vcpu);
@@ -597,6 +616,14 @@ int kvm_arch_vcpu_dump_regs(struct kvm_vcpu *vcpu);
 /* Trampoline ASM routine to start running in "Guest" context */
 extern int __kvm_mips_vcpu_run(struct kvm_run *run, struct kvm_vcpu *vcpu);
 
+/* FPU context management */
+void __kvm_save_fpu(struct kvm_vcpu_arch *vcpu);
+void __kvm_restore_fpu(struct kvm_vcpu_arch *vcpu);
+void __kvm_restore_fcsr(struct kvm_vcpu_arch *vcpu);
+void kvm_own_fpu(struct kvm_vcpu *vcpu);
+void kvm_drop_fpu(struct kvm_vcpu *vcpu);
+void kvm_lose_fpu(struct kvm_vcpu *vcpu);
+
 /* TLB handling */
 uint32_t kvm_get_kernel_asid(struct kvm_vcpu *vcpu);
 
diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index 3ee1565c5be3..a12bcf920073 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -404,6 +404,44 @@ void output_kvm_defines(void)
 	OFFSET(VCPU_LO, kvm_vcpu_arch, lo);
 	OFFSET(VCPU_HI, kvm_vcpu_arch, hi);
 	OFFSET(VCPU_PC, kvm_vcpu_arch, pc);
+	BLANK();
+
+	OFFSET(VCPU_FPR0, kvm_vcpu_arch, fpu.fpr[0]);
+	OFFSET(VCPU_FPR1, kvm_vcpu_arch, fpu.fpr[1]);
+	OFFSET(VCPU_FPR2, kvm_vcpu_arch, fpu.fpr[2]);
+	OFFSET(VCPU_FPR3, kvm_vcpu_arch, fpu.fpr[3]);
+	OFFSET(VCPU_FPR4, kvm_vcpu_arch, fpu.fpr[4]);
+	OFFSET(VCPU_FPR5, kvm_vcpu_arch, fpu.fpr[5]);
+	OFFSET(VCPU_FPR6, kvm_vcpu_arch, fpu.fpr[6]);
+	OFFSET(VCPU_FPR7, kvm_vcpu_arch, fpu.fpr[7]);
+	OFFSET(VCPU_FPR8, kvm_vcpu_arch, fpu.fpr[8]);
+	OFFSET(VCPU_FPR9, kvm_vcpu_arch, fpu.fpr[9]);
+	OFFSET(VCPU_FPR10, kvm_vcpu_arch, fpu.fpr[10]);
+	OFFSET(VCPU_FPR11, kvm_vcpu_arch, fpu.fpr[11]);
+	OFFSET(VCPU_FPR12, kvm_vcpu_arch, fpu.fpr[12]);
+	OFFSET(VCPU_FPR13, kvm_vcpu_arch, fpu.fpr[13]);
+	OFFSET(VCPU_FPR14, kvm_vcpu_arch, fpu.fpr[14]);
+	OFFSET(VCPU_FPR15, kvm_vcpu_arch, fpu.fpr[15]);
+	OFFSET(VCPU_FPR16, kvm_vcpu_arch, fpu.fpr[16]);
+	OFFSET(VCPU_FPR17, kvm_vcpu_arch, fpu.fpr[17]);
+	OFFSET(VCPU_FPR18, kvm_vcpu_arch, fpu.fpr[18]);
+	OFFSET(VCPU_FPR19, kvm_vcpu_arch, fpu.fpr[19]);
+	OFFSET(VCPU_FPR20, kvm_vcpu_arch, fpu.fpr[20]);
+	OFFSET(VCPU_FPR21, kvm_vcpu_arch, fpu.fpr[21]);
+	OFFSET(VCPU_FPR22, kvm_vcpu_arch, fpu.fpr[22]);
+	OFFSET(VCPU_FPR23, kvm_vcpu_arch, fpu.fpr[23]);
+	OFFSET(VCPU_FPR24, kvm_vcpu_arch, fpu.fpr[24]);
+	OFFSET(VCPU_FPR25, kvm_vcpu_arch, fpu.fpr[25]);
+	OFFSET(VCPU_FPR26, kvm_vcpu_arch, fpu.fpr[26]);
+	OFFSET(VCPU_FPR27, kvm_vcpu_arch, fpu.fpr[27]);
+	OFFSET(VCPU_FPR28, kvm_vcpu_arch, fpu.fpr[28]);
+	OFFSET(VCPU_FPR29, kvm_vcpu_arch, fpu.fpr[29]);
+	OFFSET(VCPU_FPR30, kvm_vcpu_arch, fpu.fpr[30]);
+	OFFSET(VCPU_FPR31, kvm_vcpu_arch, fpu.fpr[31]);
+
+	OFFSET(VCPU_FCR31, kvm_vcpu_arch, fpu.fcr31);
+	BLANK();
+
 	OFFSET(VCPU_COP0, kvm_vcpu_arch, cop0);
 	OFFSET(VCPU_GUEST_KERNEL_ASID, kvm_vcpu_arch, guest_kernel_asid);
 	OFFSET(VCPU_GUEST_USER_ASID, kvm_vcpu_arch, guest_user_asid);
diff --git a/arch/mips/kvm/Makefile b/arch/mips/kvm/Makefile
index 401fe027c261..78d7bcd7710a 100644
--- a/arch/mips/kvm/Makefile
+++ b/arch/mips/kvm/Makefile
@@ -7,7 +7,7 @@ EXTRA_CFLAGS += -Ivirt/kvm -Iarch/mips/kvm
 
 kvm-objs := $(common-objs) mips.o emulate.o locore.o \
 	    interrupt.o stats.o commpage.o \
-	    dyntrans.o trap_emul.o
+	    dyntrans.o trap_emul.o fpu.o
 
 obj-$(CONFIG_KVM)	+= kvm.o
 obj-y			+= callback.o tlb.o
diff --git a/arch/mips/kvm/fpu.S b/arch/mips/kvm/fpu.S
new file mode 100644
index 000000000000..531fbf5131c0
--- /dev/null
+++ b/arch/mips/kvm/fpu.S
@@ -0,0 +1,122 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * FPU context handling code for KVM.
+ *
+ * Copyright (C) 2015 Imagination Technologies Ltd.
+ */
+
+#include <asm/asm.h>
+#include <asm/asm-offsets.h>
+#include <asm/fpregdef.h>
+#include <asm/mipsregs.h>
+#include <asm/regdef.h>
+
+	.set	noreorder
+	.set	noat
+
+LEAF(__kvm_save_fpu)
+	.set	push
+	.set	mips64r2
+	SET_HARDFLOAT
+	mfc0	t0, CP0_STATUS
+	sll     t0, t0, 5			# is Status.FR set?
+	bgez    t0, 1f				# no: skip odd doubles
+	 nop
+	sdc1	$f1,  VCPU_FPR1(a0)
+	sdc1	$f3,  VCPU_FPR3(a0)
+	sdc1	$f5,  VCPU_FPR5(a0)
+	sdc1	$f7,  VCPU_FPR7(a0)
+	sdc1	$f9,  VCPU_FPR9(a0)
+	sdc1	$f11, VCPU_FPR11(a0)
+	sdc1	$f13, VCPU_FPR13(a0)
+	sdc1	$f15, VCPU_FPR15(a0)
+	sdc1	$f17, VCPU_FPR17(a0)
+	sdc1	$f19, VCPU_FPR19(a0)
+	sdc1	$f21, VCPU_FPR21(a0)
+	sdc1	$f23, VCPU_FPR23(a0)
+	sdc1	$f25, VCPU_FPR25(a0)
+	sdc1	$f27, VCPU_FPR27(a0)
+	sdc1	$f29, VCPU_FPR29(a0)
+	sdc1	$f31, VCPU_FPR31(a0)
+1:	sdc1	$f0,  VCPU_FPR0(a0)
+	sdc1	$f2,  VCPU_FPR2(a0)
+	sdc1	$f4,  VCPU_FPR4(a0)
+	sdc1	$f6,  VCPU_FPR6(a0)
+	sdc1	$f8,  VCPU_FPR8(a0)
+	sdc1	$f10, VCPU_FPR10(a0)
+	sdc1	$f12, VCPU_FPR12(a0)
+	sdc1	$f14, VCPU_FPR14(a0)
+	sdc1	$f16, VCPU_FPR16(a0)
+	sdc1	$f18, VCPU_FPR18(a0)
+	sdc1	$f20, VCPU_FPR20(a0)
+	sdc1	$f22, VCPU_FPR22(a0)
+	sdc1	$f24, VCPU_FPR24(a0)
+	sdc1	$f26, VCPU_FPR26(a0)
+	sdc1	$f28, VCPU_FPR28(a0)
+	jr	ra
+	 sdc1	$f30, VCPU_FPR30(a0)
+	.set	pop
+	END(__kvm_save_fpu)
+
+LEAF(__kvm_restore_fpu)
+	.set	push
+	.set	mips64r2
+	SET_HARDFLOAT
+	mfc0	t0, CP0_STATUS
+	sll     t0, t0, 5			# is Status.FR set?
+	bgez    t0, 1f				# no: skip odd doubles
+	 nop
+	ldc1	$f1,  VCPU_FPR1(a0)
+	ldc1	$f3,  VCPU_FPR3(a0)
+	ldc1	$f5,  VCPU_FPR5(a0)
+	ldc1	$f7,  VCPU_FPR7(a0)
+	ldc1	$f9,  VCPU_FPR9(a0)
+	ldc1	$f11, VCPU_FPR11(a0)
+	ldc1	$f13, VCPU_FPR13(a0)
+	ldc1	$f15, VCPU_FPR15(a0)
+	ldc1	$f17, VCPU_FPR17(a0)
+	ldc1	$f19, VCPU_FPR19(a0)
+	ldc1	$f21, VCPU_FPR21(a0)
+	ldc1	$f23, VCPU_FPR23(a0)
+	ldc1	$f25, VCPU_FPR25(a0)
+	ldc1	$f27, VCPU_FPR27(a0)
+	ldc1	$f29, VCPU_FPR29(a0)
+	ldc1	$f31, VCPU_FPR31(a0)
+1:	ldc1	$f0,  VCPU_FPR0(a0)
+	ldc1	$f2,  VCPU_FPR2(a0)
+	ldc1	$f4,  VCPU_FPR4(a0)
+	ldc1	$f6,  VCPU_FPR6(a0)
+	ldc1	$f8,  VCPU_FPR8(a0)
+	ldc1	$f10, VCPU_FPR10(a0)
+	ldc1	$f12, VCPU_FPR12(a0)
+	ldc1	$f14, VCPU_FPR14(a0)
+	ldc1	$f16, VCPU_FPR16(a0)
+	ldc1	$f18, VCPU_FPR18(a0)
+	ldc1	$f20, VCPU_FPR20(a0)
+	ldc1	$f22, VCPU_FPR22(a0)
+	ldc1	$f24, VCPU_FPR24(a0)
+	ldc1	$f26, VCPU_FPR26(a0)
+	ldc1	$f28, VCPU_FPR28(a0)
+	jr	ra
+	 ldc1	$f30, VCPU_FPR30(a0)
+	.set	pop
+	END(__kvm_restore_fpu)
+
+LEAF(__kvm_restore_fcsr)
+	.set	push
+	SET_HARDFLOAT
+	lw	t0, VCPU_FCR31(a0)
+	/*
+	 * The ctc1 must stay at this offset in __kvm_restore_fcsr.
+	 * See kvm_mips_csr_die_notify() which handles t0 containing a value
+	 * which triggers an FP Exception, which must be stepped over and
+	 * ignored since the set cause bits must remain there for the guest.
+	 */
+	ctc1	t0, fcr31
+	jr	ra
+	 nop
+	.set	pop
+	END(__kvm_restore_fcsr)
diff --git a/arch/mips/kvm/locore.S b/arch/mips/kvm/locore.S
index 4a68b176d6e4..f5594049c0c3 100644
--- a/arch/mips/kvm/locore.S
+++ b/arch/mips/kvm/locore.S
@@ -353,6 +353,23 @@ NESTED (MIPSX(GuestException), CALLFRAME_SIZ, ra)
 	LONG_L	k0, VCPU_HOST_EBASE(k1)
 	mtc0	k0,CP0_EBASE
 
+	/*
+	 * If FPU is enabled, save FCR31 and clear it so that later ctc1's don't
+	 * trigger FPE for pending exceptions.
+	 */
+	.set	at
+	and	v1, v0, ST0_CU1
+	beqz	v1, 1f
+	 nop
+	.set	push
+	SET_HARDFLOAT
+	cfc1	t0, fcr31
+	sw	t0, VCPU_FCR31(k1)
+	ctc1	zero,fcr31
+	.set	pop
+	.set	noat
+1:
+
 	/* Now that the new EBASE has been loaded, unset BEV and KSU_USER */
 	.set	at
 	and	v0, v0, ~(ST0_EXL | KSU_USER | ST0_IE)
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 73eecc779454..b26a48d81467 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -11,6 +11,7 @@
 
 #include <linux/errno.h>
 #include <linux/err.h>
+#include <linux/kdebug.h>
 #include <linux/module.h>
 #include <linux/vmalloc.h>
 #include <linux/fs.h>
@@ -1178,12 +1179,133 @@ skip_emul:
 		}
 	}
 
+	if (ret == RESUME_GUEST) {
+		/*
+		 * If FPU is enabled (i.e. the guest's FPU context is live),
+		 * restore FCR31.
+		 *
+		 * This should be before returning to the guest exception
+		 * vector, as it may well cause an FP exception if there are
+		 * pending exception bits unmasked. (see
+		 * kvm_mips_csr_die_notifier() for how that is handled).
+		 */
+		if (kvm_mips_guest_has_fpu(&vcpu->arch) &&
+		    read_c0_status() & ST0_CU1)
+			__kvm_restore_fcsr(&vcpu->arch);
+	}
+
 	/* Disable HTW before returning to guest or host */
 	htw_stop();
 
 	return ret;
 }
 
+/* Enable FPU for guest and restore context */
+void kvm_own_fpu(struct kvm_vcpu *vcpu)
+{
+	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	unsigned int sr, cfg5;
+
+	preempt_disable();
+
+	/*
+	 * Enable FPU for guest
+	 * We set FR and FRE according to guest context
+	 */
+	sr = kvm_read_c0_guest_status(cop0);
+	change_c0_status(ST0_CU1 | ST0_FR, sr);
+	if (cpu_has_fre) {
+		cfg5 = kvm_read_c0_guest_config5(cop0);
+		change_c0_config5(MIPS_CONF5_FRE, cfg5);
+	}
+	enable_fpu_hazard();
+
+	/* If guest FPU state not active, restore it now */
+	if (!(vcpu->arch.fpu_inuse & KVM_MIPS_FPU_FPU)) {
+		__kvm_restore_fpu(&vcpu->arch);
+		vcpu->arch.fpu_inuse |= KVM_MIPS_FPU_FPU;
+	}
+
+	preempt_enable();
+}
+
+/* Drop FPU without saving it */
+void kvm_drop_fpu(struct kvm_vcpu *vcpu)
+{
+	preempt_disable();
+	if (vcpu->arch.fpu_inuse & KVM_MIPS_FPU_FPU) {
+		clear_c0_status(ST0_CU1 | ST0_FR);
+		vcpu->arch.fpu_inuse &= ~KVM_MIPS_FPU_FPU;
+	}
+	preempt_enable();
+}
+
+/* Save and disable FPU */
+void kvm_lose_fpu(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * FPU gets disabled in root context (hardware) when it is disabled in
+	 * guest context (software), but the register state in the hardware may
+	 * still be in use. This is why we explicitly re-enable the hardware
+	 * before saving.
+	 */
+
+	preempt_disable();
+	if (vcpu->arch.fpu_inuse & KVM_MIPS_FPU_FPU) {
+		set_c0_status(ST0_CU1);
+		enable_fpu_hazard();
+
+		__kvm_save_fpu(&vcpu->arch);
+		vcpu->arch.fpu_inuse &= ~KVM_MIPS_FPU_FPU;
+
+		/* Disable FPU */
+		clear_c0_status(ST0_CU1 | ST0_FR);
+	}
+	preempt_enable();
+}
+
+/*
+ * Step over a specific ctc1 to FCSR which is used to restore guest FCSR state
+ * and may trigger a "harmless" FP exception if cause bits are set in the value
+ * being written.
+ */
+static int kvm_mips_csr_die_notify(struct notifier_block *self,
+				   unsigned long cmd, void *ptr)
+{
+	struct die_args *args = (struct die_args *)ptr;
+	struct pt_regs *regs = args->regs;
+	unsigned long pc;
+
+	/* Only interested in FPE */
+	if (cmd != DIE_FP)
+		return NOTIFY_DONE;
+
+	/* Return immediately if guest context isn't active */
+	if (!(current->flags & PF_VCPU))
+		return NOTIFY_DONE;
+
+	/* Should never get here from user mode */
+	BUG_ON(user_mode(regs));
+
+	pc = instruction_pointer(regs);
+	switch (cmd) {
+	case DIE_FP:
+		/* match 2nd instruction in __kvm_restore_fcsr */
+		if (pc != (unsigned long)&__kvm_restore_fcsr + 4)
+			return NOTIFY_DONE;
+		break;
+	}
+
+	/* Move PC forward a little and continue executing */
+	instruction_pointer(regs) += 4;
+
+	return NOTIFY_STOP;
+}
+
+static struct notifier_block kvm_mips_csr_die_notifier = {
+	.notifier_call = kvm_mips_csr_die_notify,
+};
+
 int __init kvm_mips_init(void)
 {
 	int ret;
@@ -1193,6 +1315,8 @@ int __init kvm_mips_init(void)
 	if (ret)
 		return ret;
 
+	register_die_notifier(&kvm_mips_csr_die_notifier);
+
 	/*
 	 * On MIPS, kernel modules are executed from "mapped space", which
 	 * requires TLBs. The TLB handling code is statically linked with
@@ -1215,6 +1339,8 @@ void __exit kvm_mips_exit(void)
 	kvm_mips_gfn_to_pfn = NULL;
 	kvm_mips_release_pfn_clean = NULL;
 	kvm_mips_is_error_pfn = NULL;
+
+	unregister_die_notifier(&kvm_mips_csr_die_notifier);
 }
 
 module_init(kvm_mips_init);
diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index 0d2729d202f4..408af244aed2 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -554,6 +554,8 @@ static int kvm_trap_emul_set_one_reg(struct kvm_vcpu *vcpu,
 
 static int kvm_trap_emul_vcpu_get_regs(struct kvm_vcpu *vcpu)
 {
+	kvm_lose_fpu(vcpu);
+
 	return 0;
 }
 
-- 
2.0.5
