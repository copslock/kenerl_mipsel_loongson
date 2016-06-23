Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jun 2016 18:37:12 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:60788 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27043850AbcFWQfC1pJjz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Jun 2016 18:35:02 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id B0163B3BED1CC;
        Thu, 23 Jun 2016 17:34:51 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 23 Jun 2016 17:34:55 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>,
        <kvm@vger.kernel.org>
Subject: [PATCH 06/14] MIPS; KVM: Convert exception entry to uasm
Date:   Thu, 23 Jun 2016 17:34:39 +0100
Message-ID: <1466699687-24791-7-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1466699687-24791-1-git-send-email-james.hogan@imgtec.com>
References: <1466699687-24791-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54144
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

Convert the whole of locore.S (assembly to enter guest and handle
exception entry) to be generated dynamically with uasm. This is done
with minimal changes to the resulting code.

The main changes are:
- Some constants are generated by uasm using LUI+ADDIU instead of
  LUI+ORI.
- Loading of lo and hi are swapped around in vcpu_run but not when
  resuming the guest after an exit. Both bits of logic are now generated
  by the same code.
- Register MOVEs in uasm use different ADDU operand ordering to GNU as,
  putting zero register into rs instead of rt.
- The JALR.HB to call the C exit handler is switched to JALR, since the
  hazard barrier would appear to be unnecessary.

This will allow further optimisation in the future to dynamically handle
the capabilities of the CPU.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h    |   8 +-
 arch/mips/kvm/Kconfig               |   1 +
 arch/mips/kvm/Makefile              |   2 +-
 arch/mips/kvm/{locore.S => entry.c} | 884 ++++++++++++++++++------------------
 arch/mips/kvm/interrupt.h           |   4 -
 arch/mips/kvm/mips.c                |  37 +-
 6 files changed, 472 insertions(+), 464 deletions(-)
 rename arch/mips/kvm/{locore.S => entry.c} (20%)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index b0773c6d622f..2e76e899079c 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -533,8 +533,12 @@ int kvm_mips_emulation_init(struct kvm_mips_callbacks **install_callbacks);
 /* Debug: dump vcpu state */
 int kvm_arch_vcpu_dump_regs(struct kvm_vcpu *vcpu);
 
-/* Trampoline ASM routine to start running in "Guest" context */
-extern int __kvm_mips_vcpu_run(struct kvm_run *run, struct kvm_vcpu *vcpu);
+extern int kvm_mips_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu);
+
+/* Building of entry/exception code */
+void *kvm_mips_build_vcpu_run(void *addr);
+void *kvm_mips_build_exception(void *addr);
+void *kvm_mips_build_exit(void *addr);
 
 /* FPU/MSA context management */
 void __kvm_save_fpu(struct kvm_vcpu_arch *vcpu);
diff --git a/arch/mips/kvm/Kconfig b/arch/mips/kvm/Kconfig
index 2ae12825529f..7c56d6b124d1 100644
--- a/arch/mips/kvm/Kconfig
+++ b/arch/mips/kvm/Kconfig
@@ -17,6 +17,7 @@ if VIRTUALIZATION
 config KVM
 	tristate "Kernel-based Virtual Machine (KVM) support"
 	depends on HAVE_KVM
+	select EXPORT_UASM
 	select PREEMPT_NOTIFIERS
 	select ANON_INODES
 	select KVM_MMIO
diff --git a/arch/mips/kvm/Makefile b/arch/mips/kvm/Makefile
index 0aabe40fcac9..847429de780d 100644
--- a/arch/mips/kvm/Makefile
+++ b/arch/mips/kvm/Makefile
@@ -7,7 +7,7 @@ EXTRA_CFLAGS += -Ivirt/kvm -Iarch/mips/kvm
 
 common-objs-$(CONFIG_CPU_HAS_MSA) += msa.o
 
-kvm-objs := $(common-objs-y) mips.o emulate.o locore.o \
+kvm-objs := $(common-objs-y) mips.o emulate.o entry.o \
 	    interrupt.o stats.o commpage.o \
 	    dyntrans.o trap_emul.o fpu.o
 kvm-objs += mmu.o
diff --git a/arch/mips/kvm/locore.S b/arch/mips/kvm/entry.c
similarity index 20%
rename from arch/mips/kvm/locore.S
rename to arch/mips/kvm/entry.c
index 698286c0f732..9a18b4939b35 100644
--- a/arch/mips/kvm/locore.S
+++ b/arch/mips/kvm/entry.c
@@ -3,373 +3,445 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Main entry point for the guest, exception handling.
+ * Generation of main entry point for the guest, exception handling.
  *
- * Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
+ * Copyright (C) 2012  MIPS Technologies, Inc.
  * Authors: Sanjay Lal <sanjayl@kymasys.com>
+ *
+ * Copyright (C) 2016 Imagination Technologies Ltd.
  */
 
-#include <asm/asm.h>
-#include <asm/asmmacro.h>
-#include <asm/regdef.h>
-#include <asm/mipsregs.h>
-#include <asm/stackframe.h>
-#include <asm/asm-offsets.h>
-
-#define _C_LABEL(x)     x
-#define MIPSX(name)     mips32_ ## name
+#include <linux/kvm_host.h>
+#include <asm/msa.h>
+#include <asm/setup.h>
+#include <asm/uasm.h>
+
+/* Register names */
+#define ZERO		0
+#define AT		1
+#define V0		2
+#define V1		3
+#define A0		4
+#define A1		5
+
+#if _MIPS_SIM == _MIPS_SIM_ABI32
+#define T0		8
+#define T1		9
+#define T2		10
+#define T3		11
+#endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
+
+#if _MIPS_SIM == _MIPS_SIM_ABI64 || _MIPS_SIM == _MIPS_SIM_NABI32
+#define T0		12
+#define T1		13
+#define T2		14
+#define T3		15
+#endif /* _MIPS_SIM == _MIPS_SIM_ABI64 || _MIPS_SIM == _MIPS_SIM_NABI32 */
+
+#define S0		16
+#define S1		17
+#define T9		25
+#define K0		26
+#define K1		27
+#define GP		28
+#define SP		29
+#define RA		31
+
+/* Some CP0 registers */
+#define C0_HWRENA	7, 0
+#define C0_BADVADDR	8, 0
+#define C0_ENTRYHI	10, 0
+#define C0_STATUS	12, 0
+#define C0_CAUSE	13, 0
+#define C0_EPC		14, 0
+#define C0_EBASE	15, 1
+#define C0_CONFIG3	16, 3
+#define C0_CONFIG5	16, 5
+#define C0_DDATA_LO	28, 3
+#define C0_ERROREPC	30, 0
+
 #define CALLFRAME_SIZ   32
 
-/*
- * VECTOR
- *  exception vector entrypoint
- */
-#define VECTOR(x, regmask)      \
-    .ent    _C_LABEL(x),0;      \
-    EXPORT(x);
-
-#define VECTOR_END(x)      \
-    EXPORT(x);
-
-/* Overload, Danger Will Robinson!! */
-#define PT_HOST_USERLOCAL   PT_EPC
+enum label_id {
+	label_fpu_1 = 1,
+	label_msa_1,
+	label_return_to_host,
+	label_kernel_asid,
+};
 
-#define CP0_DDATA_LO        $28,3
+UASM_L_LA(_fpu_1)
+UASM_L_LA(_msa_1)
+UASM_L_LA(_return_to_host)
+UASM_L_LA(_kernel_asid)
 
-/* Resume Flags */
-#define RESUME_FLAG_HOST        (1<<1)  /* Resume host? */
+static void *kvm_mips_build_enter_guest(void *addr);
+static void *kvm_mips_build_ret_from_exit(void *addr);
+static void *kvm_mips_build_ret_to_guest(void *addr);
+static void *kvm_mips_build_ret_to_host(void *addr);
 
-#define RESUME_GUEST            0
-#define RESUME_HOST             RESUME_FLAG_HOST
-
-/*
- * __kvm_mips_vcpu_run: entry point to the guest
- * a0: run
- * a1: vcpu
+/**
+ * kvm_mips_build_vcpu_run() - Assemble function to start running a guest VCPU.
+ * @addr:	Address to start writing code.
+ *
+ * Assemble the start of the vcpu_run function to run a guest VCPU. The function
+ * conforms to the following prototype:
+ *
+ * int vcpu_run(struct kvm_run *run, struct kvm_vcpu *vcpu);
+ *
+ * The exit from the guest and return to the caller is handled by the code
+ * generated by kvm_mips_build_ret_to_host().
+ *
+ * Returns:	Next address after end of written function.
  */
-	.set	noreorder
+void *kvm_mips_build_vcpu_run(void *addr)
+{
+	u32 *p = addr;
+	unsigned int i;
+
+	/*
+	 * A0: run
+	 * A1: vcpu
+	 */
 
-FEXPORT(__kvm_mips_vcpu_run)
 	/* k0/k1 not being used in host kernel context */
-	INT_ADDIU k1, sp, -PT_SIZE
-	LONG_S	$16, PT_R16(k1)
-	LONG_S	$17, PT_R17(k1)
-	LONG_S	$18, PT_R18(k1)
-	LONG_S	$19, PT_R19(k1)
-	LONG_S	$20, PT_R20(k1)
-	LONG_S	$21, PT_R21(k1)
-	LONG_S	$22, PT_R22(k1)
-	LONG_S	$23, PT_R23(k1)
-
-	LONG_S	$28, PT_R28(k1)
-	LONG_S	$29, PT_R29(k1)
-	LONG_S	$30, PT_R30(k1)
-	LONG_S	$31, PT_R31(k1)
+	uasm_i_addiu(&p, K1, SP, -(int)sizeof(struct pt_regs));
+	for (i = 16; i < 32; ++i) {
+		if (i == 24)
+			i = 28;
+		UASM_i_SW(&p, i, offsetof(struct pt_regs, regs[i]), K1);
+	}
 
 	/* Save hi/lo */
-	mflo	v0
-	LONG_S	v0, PT_LO(k1)
-	mfhi	v1
-	LONG_S	v1, PT_HI(k1)
+	uasm_i_mflo(&p, V0);
+	UASM_i_SW(&p, V0, offsetof(struct pt_regs, lo), K1);
+	uasm_i_mfhi(&p, V1);
+	UASM_i_SW(&p, V1, offsetof(struct pt_regs, hi), K1);
 
 	/* Save host status */
-	mfc0	v0, CP0_STATUS
-	LONG_S	v0, PT_STATUS(k1)
+	uasm_i_mfc0(&p, V0, C0_STATUS);
+	UASM_i_SW(&p, V0, offsetof(struct pt_regs, cp0_status), K1);
 
 	/* Save DDATA_LO, will be used to store pointer to vcpu */
-	mfc0	v1, CP0_DDATA_LO
-	LONG_S	v1, PT_HOST_USERLOCAL(k1)
+	uasm_i_mfc0(&p, V1, C0_DDATA_LO);
+	UASM_i_SW(&p, V1, offsetof(struct pt_regs, cp0_epc), K1);
 
 	/* DDATA_LO has pointer to vcpu */
-	mtc0	a1, CP0_DDATA_LO
+	uasm_i_mtc0(&p, A1, C0_DDATA_LO);
 
 	/* Offset into vcpu->arch */
-	INT_ADDIU k1, a1, VCPU_HOST_ARCH
+	uasm_i_addiu(&p, K1, A1, offsetof(struct kvm_vcpu, arch));
 
 	/*
 	 * Save the host stack to VCPU, used for exception processing
 	 * when we exit from the Guest
 	 */
-	LONG_S	sp, VCPU_HOST_STACK(k1)
+	UASM_i_SW(&p, SP, offsetof(struct kvm_vcpu_arch, host_stack), K1);
 
 	/* Save the kernel gp as well */
-	LONG_S	gp, VCPU_HOST_GP(k1)
+	UASM_i_SW(&p, GP, offsetof(struct kvm_vcpu_arch, host_gp), K1);
 
 	/*
 	 * Setup status register for running the guest in UM, interrupts
 	 * are disabled
 	 */
-	li	k0, (ST0_EXL | KSU_USER | ST0_BEV)
-	mtc0	k0, CP0_STATUS
-	ehb
+	UASM_i_LA(&p, K0, ST0_EXL | KSU_USER | ST0_BEV);
+	uasm_i_mtc0(&p, K0, C0_STATUS);
+	uasm_i_ehb(&p);
 
 	/* load up the new EBASE */
-	LONG_L	k0, VCPU_GUEST_EBASE(k1)
-	mtc0	k0, CP0_EBASE
+	UASM_i_LW(&p, K0, offsetof(struct kvm_vcpu_arch, guest_ebase), K1);
+	uasm_i_mtc0(&p, K0, C0_EBASE);
 
 	/*
 	 * Now that the new EBASE has been loaded, unset BEV, set
 	 * interrupt mask as it was but make sure that timer interrupts
 	 * are enabled
 	 */
-	li	k0, (ST0_EXL | KSU_USER | ST0_IE)
-	andi	v0, v0, ST0_IM
-	or	k0, k0, v0
-	mtc0	k0, CP0_STATUS
-	ehb
+	uasm_i_addiu(&p, K0, ZERO, ST0_EXL | KSU_USER | ST0_IE);
+	uasm_i_andi(&p, V0, V0, ST0_IM);
+	uasm_i_or(&p, K0, K0, V0);
+	uasm_i_mtc0(&p, K0, C0_STATUS);
+	uasm_i_ehb(&p);
+
+	p = kvm_mips_build_enter_guest(p);
+
+	return p;
+}
+
+/**
+ * kvm_mips_build_enter_guest() - Assemble code to resume guest execution.
+ * @addr:	Address to start writing code.
+ *
+ * Assemble the code to resume guest execution. This code is common between the
+ * initial entry into the guest from the host, and returning from the exit
+ * handler back to the guest.
+ *
+ * Returns:	Next address after end of written function.
+ */
+static void *kvm_mips_build_enter_guest(void *addr)
+{
+	u32 *p = addr;
+	unsigned int i;
+	struct uasm_label labels[2];
+	struct uasm_reloc relocs[2];
+	struct uasm_label *l = labels;
+	struct uasm_reloc *r = relocs;
+
+	memset(labels, 0, sizeof(labels));
+	memset(relocs, 0, sizeof(relocs));
 
 	/* Set Guest EPC */
-	LONG_L	t0, VCPU_PC(k1)
-	mtc0	t0, CP0_EPC
+	UASM_i_LW(&p, T0, offsetof(struct kvm_vcpu_arch, pc), K1);
+	uasm_i_mtc0(&p, T0, C0_EPC);
 
-FEXPORT(__kvm_mips_load_asid)
 	/* Set the ASID for the Guest Kernel */
-	PTR_L	t0, VCPU_COP0(k1)
-	LONG_L	t0, COP0_STATUS(t0)
-	andi	t0, KSU_USER | ST0_ERL | ST0_EXL
-	xori	t0, KSU_USER
-	bnez	t0, 1f		/* If kernel */
-	 INT_ADDIU t1, k1, VCPU_GUEST_KERNEL_ASID  /* (BD)  */
-	INT_ADDIU t1, k1, VCPU_GUEST_USER_ASID    /* else user */
-1:
-	/* t1: contains the base of the ASID array, need to get the cpu id */
-	LONG_L	t2, TI_CPU($28)             /* smp_processor_id */
-	INT_SLL	t2, t2, 2                   /* x4 */
-	REG_ADDU t3, t1, t2
-	LONG_L	k0, (t3)
+	UASM_i_LW(&p, T0, offsetof(struct kvm_vcpu_arch, cop0), K1);
+	UASM_i_LW(&p, T0, offsetof(struct mips_coproc, reg[MIPS_CP0_STATUS][0]),
+		  T0);
+	uasm_i_andi(&p, T0, T0, KSU_USER | ST0_ERL | ST0_EXL);
+	uasm_i_xori(&p, T0, T0, KSU_USER);
+	uasm_il_bnez(&p, &r, T0, label_kernel_asid);
+	 uasm_i_addiu(&p, T1, K1,
+		      offsetof(struct kvm_vcpu_arch, guest_kernel_asid));
+	/* else user */
+	uasm_i_addiu(&p, T1, K1,
+		     offsetof(struct kvm_vcpu_arch, guest_user_asid));
+	uasm_l_kernel_asid(&l, p);
+
+	/* t1: contains the base of the ASID array, need to get the cpu id  */
+	/* smp_processor_id */
+	UASM_i_LW(&p, T2, offsetof(struct thread_info, cpu), GP);
+	/* x4 */
+	uasm_i_sll(&p, T2, T2, 2);
+	UASM_i_ADDU(&p, T3, T1, T2);
+	UASM_i_LW(&p, K0, 0, T3);
 #ifdef CONFIG_MIPS_ASID_BITS_VARIABLE
-	li	t3, CPUINFO_SIZE/4
-	mul	t2, t2, t3		/* x sizeof(struct cpuinfo_mips)/4 */
-	LONG_L	t2, (cpu_data + CPUINFO_ASID_MASK)(t2)
-	and	k0, k0, t2
+	/* x sizeof(struct cpuinfo_mips)/4 */
+	uasm_i_addiu(&p, T3, ZERO, sizeof(struct cpuinfo_mips)/4);
+	uasm_i_mul(&p, T2, T2, T3);
+
+	UASM_i_LA_mostly(&p, AT, (long)&cpu_data[0].asid_mask);
+	UASM_i_ADDU(&p, AT, AT, T2);
+	UASM_i_LW(&p, T2, uasm_rel_lo((long)&cpu_data[0].asid_mask), AT);
+	uasm_i_and(&p, K0, K0, T2);
 #else
-	andi	k0, k0, MIPS_ENTRYHI_ASID
+	uasm_i_andi(&p, K0, K0, MIPS_ENTRYHI_ASID);
 #endif
-	mtc0	k0, CP0_ENTRYHI
-	ehb
+	uasm_i_mtc0(&p, K0, C0_ENTRYHI);
+	uasm_i_ehb(&p);
 
 	/* Disable RDHWR access */
-	mtc0	zero, CP0_HWRENA
-
-	.set	noat
-	/* Now load up the Guest Context from VCPU */
-	LONG_L	$1, VCPU_R1(k1)
-	LONG_L	$2, VCPU_R2(k1)
-	LONG_L	$3, VCPU_R3(k1)
-
-	LONG_L	$4, VCPU_R4(k1)
-	LONG_L	$5, VCPU_R5(k1)
-	LONG_L	$6, VCPU_R6(k1)
-	LONG_L	$7, VCPU_R7(k1)
-
-	LONG_L	$8, VCPU_R8(k1)
-	LONG_L	$9, VCPU_R9(k1)
-	LONG_L	$10, VCPU_R10(k1)
-	LONG_L	$11, VCPU_R11(k1)
-	LONG_L	$12, VCPU_R12(k1)
-	LONG_L	$13, VCPU_R13(k1)
-	LONG_L	$14, VCPU_R14(k1)
-	LONG_L	$15, VCPU_R15(k1)
-	LONG_L	$16, VCPU_R16(k1)
-	LONG_L	$17, VCPU_R17(k1)
-	LONG_L	$18, VCPU_R18(k1)
-	LONG_L	$19, VCPU_R19(k1)
-	LONG_L	$20, VCPU_R20(k1)
-	LONG_L	$21, VCPU_R21(k1)
-	LONG_L	$22, VCPU_R22(k1)
-	LONG_L	$23, VCPU_R23(k1)
-	LONG_L	$24, VCPU_R24(k1)
-	LONG_L	$25, VCPU_R25(k1)
-
-	/* k0/k1 loaded up later */
-
-	LONG_L	$28, VCPU_R28(k1)
-	LONG_L	$29, VCPU_R29(k1)
-	LONG_L	$30, VCPU_R30(k1)
-	LONG_L	$31, VCPU_R31(k1)
+	uasm_i_mtc0(&p, ZERO, C0_HWRENA);
+
+	/* load the guest context from VCPU and return */
+	for (i = 1; i < 32; ++i) {
+		/* Guest k0/k1 loaded later */
+		if (i == K0 || i == K1)
+			continue;
+		UASM_i_LW(&p, i, offsetof(struct kvm_vcpu_arch, gprs[i]), K1);
+	}
 
 	/* Restore hi/lo */
-	LONG_L	k0, VCPU_LO(k1)
-	mtlo	k0
+	UASM_i_LW(&p, K0, offsetof(struct kvm_vcpu_arch, hi), K1);
+	uasm_i_mthi(&p, K0);
 
-	LONG_L	k0, VCPU_HI(k1)
-	mthi	k0
+	UASM_i_LW(&p, K0, offsetof(struct kvm_vcpu_arch, lo), K1);
+	uasm_i_mtlo(&p, K0);
 
-FEXPORT(__kvm_mips_load_k0k1)
 	/* Restore the guest's k0/k1 registers */
-	LONG_L	k0, VCPU_R26(k1)
-	LONG_L	k1, VCPU_R27(k1)
+	UASM_i_LW(&p, K0, offsetof(struct kvm_vcpu_arch, gprs[K0]), K1);
+	UASM_i_LW(&p, K1, offsetof(struct kvm_vcpu_arch, gprs[K1]), K1);
 
 	/* Jump to guest */
-	eret
-EXPORT(__kvm_mips_vcpu_run_end)
-
-VECTOR(MIPSX(exception), unknown)
-/* Find out what mode we came from and jump to the proper handler. */
-	mtc0	k0, CP0_ERROREPC	#01: Save guest k0
-	ehb				#02:
-
-	mfc0	k0, CP0_EBASE		#02: Get EBASE
-	INT_SRL	k0, k0, 10		#03: Get rid of CPUNum
-	INT_SLL	k0, k0, 10		#04
-	LONG_S	k1, 0x3000(k0)		#05: Save k1 @ offset 0x3000
-	INT_ADDIU k0, k0, 0x2000	#06: Exception handler is
-					#    installed @ offset 0x2000
-	j	k0			#07: jump to the function
-	 nop				#08: branch delay slot
-VECTOR_END(MIPSX(exceptionEnd))
-.end MIPSX(exception)
-
-/*
- * Generic Guest exception handler. We end up here when the guest
- * does something that causes a trap to kernel mode.
+	uasm_i_eret(&p);
+
+	uasm_resolve_relocs(relocs, labels);
+
+	return p;
+}
+
+/**
+ * kvm_mips_build_exception() - Assemble first level guest exception handler.
+ * @addr:	Address to start writing code.
+ *
+ * Assemble exception vector code for guest execution. The generated vector will
+ * jump to the common exception handler generated by kvm_mips_build_exit().
+ *
+ * Returns:	Next address after end of written function.
+ */
+void *kvm_mips_build_exception(void *addr)
+{
+	u32 *p = addr;
+
+	/* Save guest k0 */
+	uasm_i_mtc0(&p, K0, C0_ERROREPC);
+	uasm_i_ehb(&p);
+
+	/* Get EBASE */
+	uasm_i_mfc0(&p, K0, C0_EBASE);
+	/* Get rid of CPUNum */
+	uasm_i_srl(&p, K0, K0, 10);
+	uasm_i_sll(&p, K0, K0, 10);
+	/* Save k1 @ offset 0x3000 */
+	UASM_i_SW(&p, K1, 0x3000, K0);
+
+	/* Exception handler is installed @ offset 0x2000 */
+	uasm_i_addiu(&p, K0, K0, 0x2000);
+	/* Jump to the function */
+	uasm_i_jr(&p, K0);
+	 uasm_i_nop(&p);
+
+	return p;
+}
+
+/**
+ * kvm_mips_build_exit() - Assemble common guest exit handler.
+ * @addr:	Address to start writing code.
+ *
+ * Assemble the generic guest exit handling code. This is called by the
+ * exception vectors (generated by kvm_mips_build_exception()), and calls
+ * kvm_mips_handle_exit(), then either resumes the guest or returns to the host
+ * depending on the return value.
+ *
+ * Returns:	Next address after end of written function.
  */
-NESTED (MIPSX(GuestException), CALLFRAME_SIZ, ra)
-	/* Get the VCPU pointer from DDTATA_LO */
-	mfc0	k1, CP0_DDATA_LO
-	INT_ADDIU k1, k1, VCPU_HOST_ARCH
+void *kvm_mips_build_exit(void *addr)
+{
+	u32 *p = addr;
+	unsigned int i;
+	struct uasm_label labels[3];
+	struct uasm_reloc relocs[3];
+	struct uasm_label *l = labels;
+	struct uasm_reloc *r = relocs;
+
+	memset(labels, 0, sizeof(labels));
+	memset(relocs, 0, sizeof(relocs));
+
+	/*
+	 * Generic Guest exception handler. We end up here when the guest
+	 * does something that causes a trap to kernel mode.
+	 */
+
+	/* Get the VCPU pointer from DDATA_LO */
+	uasm_i_mfc0(&p, K1, C0_DDATA_LO);
+	uasm_i_addiu(&p, K1, K1, offsetof(struct kvm_vcpu, arch));
 
 	/* Start saving Guest context to VCPU */
-	LONG_S	$0, VCPU_R0(k1)
-	LONG_S	$1, VCPU_R1(k1)
-	LONG_S	$2, VCPU_R2(k1)
-	LONG_S	$3, VCPU_R3(k1)
-	LONG_S	$4, VCPU_R4(k1)
-	LONG_S	$5, VCPU_R5(k1)
-	LONG_S	$6, VCPU_R6(k1)
-	LONG_S	$7, VCPU_R7(k1)
-	LONG_S	$8, VCPU_R8(k1)
-	LONG_S	$9, VCPU_R9(k1)
-	LONG_S	$10, VCPU_R10(k1)
-	LONG_S	$11, VCPU_R11(k1)
-	LONG_S	$12, VCPU_R12(k1)
-	LONG_S	$13, VCPU_R13(k1)
-	LONG_S	$14, VCPU_R14(k1)
-	LONG_S	$15, VCPU_R15(k1)
-	LONG_S	$16, VCPU_R16(k1)
-	LONG_S	$17, VCPU_R17(k1)
-	LONG_S	$18, VCPU_R18(k1)
-	LONG_S	$19, VCPU_R19(k1)
-	LONG_S	$20, VCPU_R20(k1)
-	LONG_S	$21, VCPU_R21(k1)
-	LONG_S	$22, VCPU_R22(k1)
-	LONG_S	$23, VCPU_R23(k1)
-	LONG_S	$24, VCPU_R24(k1)
-	LONG_S	$25, VCPU_R25(k1)
-
-	/* Guest k0/k1 saved later */
-
-	LONG_S	$28, VCPU_R28(k1)
-	LONG_S	$29, VCPU_R29(k1)
-	LONG_S	$30, VCPU_R30(k1)
-	LONG_S	$31, VCPU_R31(k1)
-
-	.set at
+	for (i = 0; i < 32; ++i) {
+		/* Guest k0/k1 saved later */
+		if (i == K0 || i == K1)
+			continue;
+		UASM_i_SW(&p, i, offsetof(struct kvm_vcpu_arch, gprs[i]), K1);
+	}
 
 	/* We need to save hi/lo and restore them on the way out */
-	mfhi	t0
-	LONG_S	t0, VCPU_HI(k1)
+	uasm_i_mfhi(&p, T0);
+	UASM_i_SW(&p, T0, offsetof(struct kvm_vcpu_arch, hi), K1);
 
-	mflo	t0
-	LONG_S	t0, VCPU_LO(k1)
+	uasm_i_mflo(&p, T0);
+	UASM_i_SW(&p, T0, offsetof(struct kvm_vcpu_arch, lo), K1);
 
 	/* Finally save guest k0/k1 to VCPU */
-	mfc0	t0, CP0_ERROREPC
-	LONG_S	t0, VCPU_R26(k1)
+	uasm_i_mfc0(&p, T0, C0_ERROREPC);
+	UASM_i_SW(&p, T0, offsetof(struct kvm_vcpu_arch, gprs[K0]), K1);
 
 	/* Get GUEST k1 and save it in VCPU */
-	PTR_LI	t1, ~0x2ff
-	mfc0	t0, CP0_EBASE
-	and	t0, t0, t1
-	LONG_L	t0, 0x3000(t0)
-	LONG_S	t0, VCPU_R27(k1)
+	uasm_i_addiu(&p, T1, ZERO, ~0x2ff);
+	uasm_i_mfc0(&p, T0, C0_EBASE);
+	uasm_i_and(&p, T0, T0, T1);
+	UASM_i_LW(&p, T0, 0x3000, T0);
+	UASM_i_SW(&p, T0, offsetof(struct kvm_vcpu_arch, gprs[K1]), K1);
 
 	/* Now that context has been saved, we can use other registers */
 
 	/* Restore vcpu */
-	mfc0	a1, CP0_DDATA_LO
-	move	s1, a1
+	uasm_i_mfc0(&p, A1, C0_DDATA_LO);
+	uasm_i_move(&p, S1, A1);
 
 	/* Restore run (vcpu->run) */
-	LONG_L	a0, VCPU_RUN(a1)
+	UASM_i_LW(&p, A0, offsetof(struct kvm_vcpu, run), A1);
 	/* Save pointer to run in s0, will be saved by the compiler */
-	move	s0, a0
+	uasm_i_move(&p, S0, A0);
 
 	/*
-	 * Save Host level EPC, BadVaddr and Cause to VCPU, useful to
-	 * process the exception
+	 * Save Host level EPC, BadVaddr and Cause to VCPU, useful to process
+	 * the exception
 	 */
-	mfc0	k0,CP0_EPC
-	LONG_S	k0, VCPU_PC(k1)
+	uasm_i_mfc0(&p, K0, C0_EPC);
+	UASM_i_SW(&p, K0, offsetof(struct kvm_vcpu_arch, pc), K1);
 
-	mfc0	k0, CP0_BADVADDR
-	LONG_S	k0, VCPU_HOST_CP0_BADVADDR(k1)
+	uasm_i_mfc0(&p, K0, C0_BADVADDR);
+	UASM_i_SW(&p, K0, offsetof(struct kvm_vcpu_arch, host_cp0_badvaddr),
+		  K1);
 
-	mfc0	k0, CP0_CAUSE
-	sw	k0, VCPU_HOST_CP0_CAUSE(k1)
+	uasm_i_mfc0(&p, K0, C0_CAUSE);
+	uasm_i_sw(&p, K0, offsetof(struct kvm_vcpu_arch, host_cp0_cause), K1);
 
 	/* Now restore the host state just enough to run the handlers */
 
 	/* Switch EBASE to the one used by Linux */
 	/* load up the host EBASE */
-	mfc0	v0, CP0_STATUS
+	uasm_i_mfc0(&p, V0, C0_STATUS);
 
-	or	k0, v0, ST0_BEV
+	uasm_i_lui(&p, AT, ST0_BEV >> 16);
+	uasm_i_or(&p, K0, V0, AT);
 
-	mtc0	k0, CP0_STATUS
-	ehb
+	uasm_i_mtc0(&p, K0, C0_STATUS);
+	uasm_i_ehb(&p);
 
-	LONG_L	k0, ebase
-	mtc0	k0,CP0_EBASE
+	UASM_i_LA_mostly(&p, K0, (long)&ebase);
+	UASM_i_LW(&p, K0, uasm_rel_lo((long)&ebase), K0);
+	uasm_i_mtc0(&p, K0, C0_EBASE);
 
 	/*
 	 * If FPU is enabled, save FCR31 and clear it so that later ctc1's don't
 	 * trigger FPE for pending exceptions.
 	 */
-	and	v1, v0, ST0_CU1
-	beqz	v1, 1f
-	 nop
-	.set	push
-	SET_HARDFLOAT
-	cfc1	t0, fcr31
-	sw	t0, VCPU_FCR31(k1)
-	ctc1	zero,fcr31
-	.set	pop
-1:
+	uasm_i_lui(&p, AT, ST0_CU1 >> 16);
+	uasm_i_and(&p, V1, V0, AT);
+	uasm_il_beqz(&p, &r, V1, label_fpu_1);
+	 uasm_i_nop(&p);
+	uasm_i_cfc1(&p, T0, 31);
+	uasm_i_sw(&p, T0, offsetof(struct kvm_vcpu_arch, fpu.fcr31), K1);
+	uasm_i_ctc1(&p, ZERO, 31);
+	uasm_l_fpu_1(&l, p);
 
 #ifdef CONFIG_CPU_HAS_MSA
 	/*
 	 * If MSA is enabled, save MSACSR and clear it so that later
 	 * instructions don't trigger MSAFPE for pending exceptions.
 	 */
-	mfc0	t0, CP0_CONFIG3
-	ext	t0, t0, 28, 1 /* MIPS_CONF3_MSAP */
-	beqz	t0, 1f
-	 nop
-	mfc0	t0, CP0_CONFIG5
-	ext	t0, t0, 27, 1 /* MIPS_CONF5_MSAEN */
-	beqz	t0, 1f
-	 nop
-	_cfcmsa	t0, MSA_CSR
-	sw	t0, VCPU_MSA_CSR(k1)
-	_ctcmsa	MSA_CSR, zero
-1:
+	uasm_i_mfc0(&p, T0, C0_CONFIG3);
+	uasm_i_ext(&p, T0, T0, 28, 1); /* MIPS_CONF3_MSAP */
+	uasm_il_beqz(&p, &r, T0, label_msa_1);
+	 uasm_i_nop(&p);
+	uasm_i_mfc0(&p, T0, C0_CONFIG5);
+	uasm_i_ext(&p, T0, T0, 27, 1); /* MIPS_CONF5_MSAEN */
+	uasm_il_beqz(&p, &r, T0, label_msa_1);
+	 uasm_i_nop(&p);
+	uasm_i_cfcmsa(&p, T0, MSA_CSR);
+	uasm_i_sw(&p, T0, offsetof(struct kvm_vcpu_arch, fpu.msacsr),
+		  K1);
+	uasm_i_ctcmsa(&p, MSA_CSR, ZERO);
+	uasm_l_msa_1(&l, p);
 #endif
 
 	/* Now that the new EBASE has been loaded, unset BEV and KSU_USER */
-	and	v0, v0, ~(ST0_EXL | KSU_USER | ST0_IE)
-	or	v0, v0, ST0_CU0
-	mtc0	v0, CP0_STATUS
-	ehb
+	uasm_i_addiu(&p, AT, ZERO, ~(ST0_EXL | KSU_USER | ST0_IE));
+	uasm_i_and(&p, V0, V0, AT);
+	uasm_i_lui(&p, AT, ST0_CU0 >> 16);
+	uasm_i_or(&p, V0, V0, AT);
+	uasm_i_mtc0(&p, V0, C0_STATUS);
+	uasm_i_ehb(&p);
 
 	/* Load up host GP */
-	LONG_L	gp, VCPU_HOST_GP(k1)
+	UASM_i_LW(&p, GP, offsetof(struct kvm_vcpu_arch, host_gp), K1);
 
 	/* Need a stack before we can jump to "C" */
-	LONG_L	sp, VCPU_HOST_STACK(k1)
+	UASM_i_LW(&p, SP, offsetof(struct kvm_vcpu_arch, host_stack), K1);
 
 	/* Saved host state */
-	INT_ADDIU sp, sp, -PT_SIZE
+	uasm_i_addiu(&p, SP, SP, -(int)sizeof(struct pt_regs));
 
 	/*
 	 * XXXKYMA do we need to load the host ASID, maybe not because the
@@ -377,27 +449,54 @@ NESTED (MIPSX(GuestException), CALLFRAME_SIZ, ra)
 	 */
 
 	/* Restore host DDATA_LO */
-	LONG_L	k0, PT_HOST_USERLOCAL(sp)
-	mtc0	k0, CP0_DDATA_LO
+	UASM_i_LW(&p, K0, offsetof(struct pt_regs, cp0_epc), SP);
+	uasm_i_mtc0(&p, K0, C0_DDATA_LO);
 
 	/* Restore RDHWR access */
-	INT_L	k0, hwrena
-	mtc0	k0, CP0_HWRENA
+	UASM_i_LA_mostly(&p, K0, (long)&hwrena);
+	uasm_i_lw(&p, K0, uasm_rel_lo((long)&hwrena), K0);
+	uasm_i_mtc0(&p, K0, C0_HWRENA);
 
 	/* Jump to handler */
-FEXPORT(__kvm_mips_jump_to_handler)
 	/*
 	 * XXXKYMA: not sure if this is safe, how large is the stack??
 	 * Now jump to the kvm_mips_handle_exit() to see if we can deal
 	 * with this in the kernel
 	 */
-	PTR_LA	t9, kvm_mips_handle_exit
-	jalr.hb	t9
-	 INT_ADDIU sp, sp, -CALLFRAME_SIZ           /* BD Slot */
+	UASM_i_LA(&p, T9, (unsigned long)kvm_mips_handle_exit);
+	uasm_i_jalr(&p, RA, T9);
+	 uasm_i_addiu(&p, SP, SP, -CALLFRAME_SIZ);
+
+	uasm_resolve_relocs(relocs, labels);
+
+	p = kvm_mips_build_ret_from_exit(p);
+
+	return p;
+}
+
+/**
+ * kvm_mips_build_ret_from_exit() - Assemble guest exit return handler.
+ * @addr:	Address to start writing code.
+ *
+ * Assemble the code to handle the return from kvm_mips_handle_exit(), either
+ * resuming the guest or returning to the host depending on the return value.
+ *
+ * Returns:	Next address after end of written function.
+ */
+static void *kvm_mips_build_ret_from_exit(void *addr)
+{
+	u32 *p = addr;
+	struct uasm_label labels[2];
+	struct uasm_reloc relocs[2];
+	struct uasm_label *l = labels;
+	struct uasm_reloc *r = relocs;
+
+	memset(labels, 0, sizeof(labels));
+	memset(relocs, 0, sizeof(relocs));
 
 	/* Return from handler Make sure interrupts are disabled */
-	di
-	ehb
+	uasm_i_di(&p, ZERO);
+	uasm_i_ehb(&p);
 
 	/*
 	 * XXXKYMA: k0/k1 could have been blown away if we processed
@@ -405,198 +504,119 @@ FEXPORT(__kvm_mips_jump_to_handler)
 	 * guest, reload k1
 	 */
 
-	move	k1, s1
-	INT_ADDIU k1, k1, VCPU_HOST_ARCH
+	uasm_i_move(&p, K1, S1);
+	uasm_i_addiu(&p, K1, K1, offsetof(struct kvm_vcpu, arch));
 
 	/*
 	 * Check return value, should tell us if we are returning to the
 	 * host (handle I/O etc)or resuming the guest
 	 */
-	andi	t0, v0, RESUME_HOST
-	bnez	t0, __kvm_mips_return_to_host
-	 nop
+	uasm_i_andi(&p, T0, V0, RESUME_HOST);
+	uasm_il_bnez(&p, &r, T0, label_return_to_host);
+	 uasm_i_nop(&p);
+
+	p = kvm_mips_build_ret_to_guest(p);
+
+	uasm_l_return_to_host(&l, p);
+	p = kvm_mips_build_ret_to_host(p);
+
+	uasm_resolve_relocs(relocs, labels);
+
+	return p;
+}
+
+/**
+ * kvm_mips_build_ret_to_guest() - Assemble code to return to the guest.
+ * @addr:	Address to start writing code.
+ *
+ * Assemble the code to handle return from the guest exit handler
+ * (kvm_mips_handle_exit()) back to the guest.
+ *
+ * Returns:	Next address after end of written function.
+ */
+static void *kvm_mips_build_ret_to_guest(void *addr)
+{
+	u32 *p = addr;
 
-__kvm_mips_return_to_guest:
 	/* Put the saved pointer to vcpu (s1) back into the DDATA_LO Register */
-	mtc0	s1, CP0_DDATA_LO
+	uasm_i_mtc0(&p, S1, C0_DDATA_LO);
 
 	/* Load up the Guest EBASE to minimize the window where BEV is set */
-	LONG_L	t0, VCPU_GUEST_EBASE(k1)
+	UASM_i_LW(&p, T0, offsetof(struct kvm_vcpu_arch, guest_ebase), K1);
 
 	/* Switch EBASE back to the one used by KVM */
-	mfc0	v1, CP0_STATUS
-	or	k0, v1, ST0_BEV
-	mtc0	k0, CP0_STATUS
-	ehb
-	mtc0	t0, CP0_EBASE
+	uasm_i_mfc0(&p, V1, C0_STATUS);
+	uasm_i_lui(&p, AT, ST0_BEV >> 16);
+	uasm_i_or(&p, K0, V1, AT);
+	uasm_i_mtc0(&p, K0, C0_STATUS);
+	uasm_i_ehb(&p);
+	uasm_i_mtc0(&p, T0, C0_EBASE);
 
 	/* Setup status register for running guest in UM */
-	or	v1, v1, (ST0_EXL | KSU_USER | ST0_IE)
-	and	v1, v1, ~(ST0_CU0 | ST0_MX)
-	mtc0	v1, CP0_STATUS
-	ehb
+	uasm_i_ori(&p, V1, V1, ST0_EXL | KSU_USER | ST0_IE);
+	UASM_i_LA(&p, AT, ~(ST0_CU0 | ST0_MX));
+	uasm_i_and(&p, V1, V1, AT);
+	uasm_i_mtc0(&p, V1, C0_STATUS);
+	uasm_i_ehb(&p);
+
+	p = kvm_mips_build_enter_guest(p);
+
+	return p;
+}
+
+/**
+ * kvm_mips_build_ret_to_host() - Assemble code to return to the host.
+ * @addr:	Address to start writing code.
+ *
+ * Assemble the code to handle return from the guest exit handler
+ * (kvm_mips_handle_exit()) back to the host, i.e. to the caller of the vcpu_run
+ * function generated by kvm_mips_build_vcpu_run().
+ *
+ * Returns:	Next address after end of written function.
+ */
+static void *kvm_mips_build_ret_to_host(void *addr)
+{
+	u32 *p = addr;
+	unsigned int i;
 
-	/* Set Guest EPC */
-	LONG_L	t0, VCPU_PC(k1)
-	mtc0	t0, CP0_EPC
-
-	/* Set the ASID for the Guest Kernel */
-	PTR_L	t0, VCPU_COP0(k1)
-	LONG_L	t0, COP0_STATUS(t0)
-	andi	t0, KSU_USER | ST0_ERL | ST0_EXL
-	xori	t0, KSU_USER
-	bnez	t0, 1f		/* If kernel */
-	 INT_ADDIU t1, k1, VCPU_GUEST_KERNEL_ASID  /* (BD)  */
-	INT_ADDIU t1, k1, VCPU_GUEST_USER_ASID    /* else user */
-1:
-	/* t1: contains the base of the ASID array, need to get the cpu id  */
-	LONG_L	t2, TI_CPU($28)		/* smp_processor_id */
-	INT_SLL	t2, t2, 2		/* x4 */
-	REG_ADDU t3, t1, t2
-	LONG_L	k0, (t3)
-#ifdef CONFIG_MIPS_ASID_BITS_VARIABLE
-	li	t3, CPUINFO_SIZE/4
-	mul	t2, t2, t3		/* x sizeof(struct cpuinfo_mips)/4 */
-	LONG_L	t2, (cpu_data + CPUINFO_ASID_MASK)(t2)
-	and	k0, k0, t2
-#else
-	andi	k0, k0, MIPS_ENTRYHI_ASID
-#endif
-	mtc0	k0, CP0_ENTRYHI
-	ehb
-
-	/* Disable RDHWR access */
-	mtc0	zero, CP0_HWRENA
-
-	.set	noat
-	/* load the guest context from VCPU and return */
-	LONG_L	$0, VCPU_R0(k1)
-	LONG_L	$1, VCPU_R1(k1)
-	LONG_L	$2, VCPU_R2(k1)
-	LONG_L	$3, VCPU_R3(k1)
-	LONG_L	$4, VCPU_R4(k1)
-	LONG_L	$5, VCPU_R5(k1)
-	LONG_L	$6, VCPU_R6(k1)
-	LONG_L	$7, VCPU_R7(k1)
-	LONG_L	$8, VCPU_R8(k1)
-	LONG_L	$9, VCPU_R9(k1)
-	LONG_L	$10, VCPU_R10(k1)
-	LONG_L	$11, VCPU_R11(k1)
-	LONG_L	$12, VCPU_R12(k1)
-	LONG_L	$13, VCPU_R13(k1)
-	LONG_L	$14, VCPU_R14(k1)
-	LONG_L	$15, VCPU_R15(k1)
-	LONG_L	$16, VCPU_R16(k1)
-	LONG_L	$17, VCPU_R17(k1)
-	LONG_L	$18, VCPU_R18(k1)
-	LONG_L	$19, VCPU_R19(k1)
-	LONG_L	$20, VCPU_R20(k1)
-	LONG_L	$21, VCPU_R21(k1)
-	LONG_L	$22, VCPU_R22(k1)
-	LONG_L	$23, VCPU_R23(k1)
-	LONG_L	$24, VCPU_R24(k1)
-	LONG_L	$25, VCPU_R25(k1)
-
-	/* $/k1 loaded later */
-	LONG_L	$28, VCPU_R28(k1)
-	LONG_L	$29, VCPU_R29(k1)
-	LONG_L	$30, VCPU_R30(k1)
-	LONG_L	$31, VCPU_R31(k1)
-
-FEXPORT(__kvm_mips_skip_guest_restore)
-	LONG_L	k0, VCPU_HI(k1)
-	mthi	k0
-
-	LONG_L	k0, VCPU_LO(k1)
-	mtlo	k0
-
-	LONG_L	k0, VCPU_R26(k1)
-	LONG_L	k1, VCPU_R27(k1)
-
-	eret
-	.set	at
-
-__kvm_mips_return_to_host:
 	/* EBASE is already pointing to Linux */
-	LONG_L	k1, VCPU_HOST_STACK(k1)
-	INT_ADDIU k1,k1, -PT_SIZE
+	UASM_i_LW(&p, K1, offsetof(struct kvm_vcpu_arch, host_stack), K1);
+	uasm_i_addiu(&p, K1, K1, -(int)sizeof(struct pt_regs));
 
 	/* Restore host DDATA_LO */
-	LONG_L	k0, PT_HOST_USERLOCAL(k1)
-	mtc0	k0, CP0_DDATA_LO
+	UASM_i_LW(&p, K0, offsetof(struct pt_regs, cp0_epc), K1);
+	uasm_i_mtc0(&p, K0, C0_DDATA_LO);
 
 	/*
 	 * r2/v0 is the return code, shift it down by 2 (arithmetic)
 	 * to recover the err code
 	 */
-	INT_SRA	k0, v0, 2
-	move	$2, k0
+	uasm_i_sra(&p, K0, V0, 2);
+	uasm_i_move(&p, V0, K0);
 
 	/* Load context saved on the host stack */
-	LONG_L	$16, PT_R16(k1)
-	LONG_L	$17, PT_R17(k1)
-	LONG_L	$18, PT_R18(k1)
-	LONG_L	$19, PT_R19(k1)
-	LONG_L	$20, PT_R20(k1)
-	LONG_L	$21, PT_R21(k1)
-	LONG_L	$22, PT_R22(k1)
-	LONG_L	$23, PT_R23(k1)
+	for (i = 16; i < 31; ++i) {
+		if (i == 24)
+			i = 28;
+		UASM_i_LW(&p, i, offsetof(struct pt_regs, regs[i]), K1);
+	}
 
-	LONG_L	$28, PT_R28(k1)
-	LONG_L	$29, PT_R29(k1)
-	LONG_L	$30, PT_R30(k1)
+	UASM_i_LW(&p, K0, offsetof(struct pt_regs, hi), K1);
+	uasm_i_mthi(&p, K0);
 
-	LONG_L	k0, PT_HI(k1)
-	mthi	k0
-
-	LONG_L	k0, PT_LO(k1)
-	mtlo	k0
+	UASM_i_LW(&p, K0, offsetof(struct pt_regs, lo), K1);
+	uasm_i_mtlo(&p, K0);
 
 	/* Restore RDHWR access */
-	INT_L	k0, hwrena
-	mtc0	k0, CP0_HWRENA
+	UASM_i_LA_mostly(&p, K0, (long)&hwrena);
+	uasm_i_lw(&p, K0, uasm_rel_lo((long)&hwrena), K0);
+	uasm_i_mtc0(&p, K0, C0_HWRENA);
 
 	/* Restore RA, which is the address we will return to */
-	LONG_L	ra, PT_R31(k1)
-	j	ra
-	 nop
+	UASM_i_LW(&p, RA, offsetof(struct pt_regs, regs[RA]), K1);
+	uasm_i_jr(&p, RA);
+	 uasm_i_nop(&p);
 
-VECTOR_END(MIPSX(GuestExceptionEnd))
-.end MIPSX(GuestException)
+	return p;
+}
 
-MIPSX(exceptions):
-	####
-	##### The exception handlers.
-	#####
-	.word _C_LABEL(MIPSX(GuestException))	#  0
-	.word _C_LABEL(MIPSX(GuestException))	#  1
-	.word _C_LABEL(MIPSX(GuestException))	#  2
-	.word _C_LABEL(MIPSX(GuestException))	#  3
-	.word _C_LABEL(MIPSX(GuestException))	#  4
-	.word _C_LABEL(MIPSX(GuestException))	#  5
-	.word _C_LABEL(MIPSX(GuestException))	#  6
-	.word _C_LABEL(MIPSX(GuestException))	#  7
-	.word _C_LABEL(MIPSX(GuestException))	#  8
-	.word _C_LABEL(MIPSX(GuestException))	#  9
-	.word _C_LABEL(MIPSX(GuestException))	# 10
-	.word _C_LABEL(MIPSX(GuestException))	# 11
-	.word _C_LABEL(MIPSX(GuestException))	# 12
-	.word _C_LABEL(MIPSX(GuestException))	# 13
-	.word _C_LABEL(MIPSX(GuestException))	# 14
-	.word _C_LABEL(MIPSX(GuestException))	# 15
-	.word _C_LABEL(MIPSX(GuestException))	# 16
-	.word _C_LABEL(MIPSX(GuestException))	# 17
-	.word _C_LABEL(MIPSX(GuestException))	# 18
-	.word _C_LABEL(MIPSX(GuestException))	# 19
-	.word _C_LABEL(MIPSX(GuestException))	# 20
-	.word _C_LABEL(MIPSX(GuestException))	# 21
-	.word _C_LABEL(MIPSX(GuestException))	# 22
-	.word _C_LABEL(MIPSX(GuestException))	# 23
-	.word _C_LABEL(MIPSX(GuestException))	# 24
-	.word _C_LABEL(MIPSX(GuestException))	# 25
-	.word _C_LABEL(MIPSX(GuestException))	# 26
-	.word _C_LABEL(MIPSX(GuestException))	# 27
-	.word _C_LABEL(MIPSX(GuestException))	# 28
-	.word _C_LABEL(MIPSX(GuestException))	# 29
-	.word _C_LABEL(MIPSX(GuestException))	# 30
-	.word _C_LABEL(MIPSX(GuestException))	# 31
diff --git a/arch/mips/kvm/interrupt.h b/arch/mips/kvm/interrupt.h
index d661c100b219..fb118a2c8379 100644
--- a/arch/mips/kvm/interrupt.h
+++ b/arch/mips/kvm/interrupt.h
@@ -28,10 +28,6 @@
 #define MIPS_EXC_MAX                12
 /* XXXSL More to follow */
 
-extern char __kvm_mips_vcpu_run_end[];
-extern char mips32_exception[], mips32_exceptionEnd[];
-extern char mips32_GuestException[], mips32_GuestExceptionEnd[];
-
 #define C_TI        (_ULCAST_(1) << 30)
 
 #define KVM_MIPS_IRQ_DELIVER_ALL_AT_ONCE (0)
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 5a2b9034a05c..f00cf5f9ac52 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -247,8 +247,8 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 
 struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm, unsigned int id)
 {
-	int err, size, offset;
-	void *gebase;
+	int err, size;
+	void *gebase, *p;
 	int i;
 
 	struct kvm_vcpu *vcpu = kzalloc(sizeof(struct kvm_vcpu), GFP_KERNEL);
@@ -286,41 +286,28 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm, unsigned int id)
 	/* Save new ebase */
 	vcpu->arch.guest_ebase = gebase;
 
-	/* Copy L1 Guest Exception handler to correct offset */
+	/* Build guest exception vectors dynamically in unmapped memory */
 
 	/* TLB Refill, EXL = 0 */
-	memcpy(gebase, mips32_exception,
-	       mips32_exceptionEnd - mips32_exception);
+	kvm_mips_build_exception(gebase);
 
 	/* General Exception Entry point */
-	memcpy(gebase + 0x180, mips32_exception,
-	       mips32_exceptionEnd - mips32_exception);
+	kvm_mips_build_exception(gebase + 0x180);
 
 	/* For vectored interrupts poke the exception code @ all offsets 0-7 */
 	for (i = 0; i < 8; i++) {
 		kvm_debug("L1 Vectored handler @ %p\n",
 			  gebase + 0x200 + (i * VECTORSPACING));
-		memcpy(gebase + 0x200 + (i * VECTORSPACING), mips32_exception,
-		       mips32_exceptionEnd - mips32_exception);
+		kvm_mips_build_exception(gebase + 0x200 + i * VECTORSPACING);
 	}
 
-	/* General handler, relocate to unmapped space for sanity's sake */
-	offset = 0x2000;
-	kvm_debug("Installing KVM Exception handlers @ %p, %#x bytes\n",
-		  gebase + offset,
-		  mips32_GuestExceptionEnd - mips32_GuestException);
+	/* General exit handler */
+	p = gebase + 0x2000;
+	p = kvm_mips_build_exit(p);
 
-	memcpy(gebase + offset, mips32_GuestException,
-	       mips32_GuestExceptionEnd - mips32_GuestException);
-
-#ifdef MODULE
-	offset += mips32_GuestExceptionEnd - mips32_GuestException;
-	memcpy(gebase + offset, (char *)__kvm_mips_vcpu_run,
-	       __kvm_mips_vcpu_run_end - (char *)__kvm_mips_vcpu_run);
-	vcpu->arch.vcpu_run = gebase + offset;
-#else
-	vcpu->arch.vcpu_run = __kvm_mips_vcpu_run;
-#endif
+	/* Guest entry routine */
+	vcpu->arch.vcpu_run = p;
+	p = kvm_mips_build_vcpu_run(p);
 
 	/* Invalidate the icache for these ranges */
 	local_flush_icache_range((unsigned long)gebase,
-- 
2.4.10
