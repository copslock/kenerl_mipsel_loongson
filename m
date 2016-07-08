Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Jul 2016 12:54:45 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:15620 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992754AbcGHKx52k8Lv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Jul 2016 12:53:57 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 28FA41AF45085;
        Fri,  8 Jul 2016 11:53:48 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 8 Jul 2016 11:53:50 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        James Hogan <james.hogan@imgtec.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 04/12] MIPS: KVM: Make entry code MIPS64 friendly
Date:   Fri, 8 Jul 2016 11:53:23 +0100
Message-ID: <1467975211-12674-5-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1467975211-12674-1-git-send-email-james.hogan@imgtec.com>
References: <1467975211-12674-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54260
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

The MIPS KVM entry code (originally kvm_locore.S, later locore.S, and
now entry.c) has never quite been right when built for 64-bit, using
32-bit instructions when 64-bit instructions were needed for handling
64-bit registers and pointers. Fix several cases of this now.

The changes roughly fall into the following categories.

- COP0 scratch registers contain guest register values and the VCPU
  pointer, and are themselves full width. Similarly CP0_EPC and
  CP0_BadVAddr registers are full width (even though technically we
  don't support 64-bit guest address spaces with trap & emulate KVM).
  Use MFC0/MTC0 for accessing them.

- Handling of stack pointers and the VCPU pointer must match the pointer
  size of the kernel ABI (always o32 or n64), so use ADDIU.

- The CPU number in thread_info, and the guest_{user,kernel}_asid arrays
  in kvm_vcpu_arch are all 32 bit integers, so use lw (instead of LW) to
  load them.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/entry.c | 48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/mips/kvm/entry.c b/arch/mips/kvm/entry.c
index 75ba7c2ecb3d..f4556d0279c6 100644
--- a/arch/mips/kvm/entry.c
+++ b/arch/mips/kvm/entry.c
@@ -120,12 +120,12 @@ static void kvm_mips_build_save_scratch(u32 **p, unsigned int tmp,
 					unsigned int frame)
 {
 	/* Save the VCPU scratch register value in cp0_epc of the stack frame */
-	uasm_i_mfc0(p, tmp, scratch_vcpu[0], scratch_vcpu[1]);
+	UASM_i_MFC0(p, tmp, scratch_vcpu[0], scratch_vcpu[1]);
 	UASM_i_SW(p, tmp, offsetof(struct pt_regs, cp0_epc), frame);
 
 	/* Save the temp scratch register value in cp0_cause of stack frame */
 	if (scratch_tmp[0] == 31) {
-		uasm_i_mfc0(p, tmp, scratch_tmp[0], scratch_tmp[1]);
+		UASM_i_MFC0(p, tmp, scratch_tmp[0], scratch_tmp[1]);
 		UASM_i_SW(p, tmp, offsetof(struct pt_regs, cp0_cause), frame);
 	}
 }
@@ -138,11 +138,11 @@ static void kvm_mips_build_restore_scratch(u32 **p, unsigned int tmp,
 	 * kvm_mips_build_save_scratch().
 	 */
 	UASM_i_LW(p, tmp, offsetof(struct pt_regs, cp0_epc), frame);
-	uasm_i_mtc0(p, tmp, scratch_vcpu[0], scratch_vcpu[1]);
+	UASM_i_MTC0(p, tmp, scratch_vcpu[0], scratch_vcpu[1]);
 
 	if (scratch_tmp[0] == 31) {
 		UASM_i_LW(p, tmp, offsetof(struct pt_regs, cp0_cause), frame);
-		uasm_i_mtc0(p, tmp, scratch_tmp[0], scratch_tmp[1]);
+		UASM_i_MTC0(p, tmp, scratch_tmp[0], scratch_tmp[1]);
 	}
 }
 
@@ -171,7 +171,7 @@ void *kvm_mips_build_vcpu_run(void *addr)
 	 */
 
 	/* k0/k1 not being used in host kernel context */
-	uasm_i_addiu(&p, K1, SP, -(int)sizeof(struct pt_regs));
+	UASM_i_ADDIU(&p, K1, SP, -(int)sizeof(struct pt_regs));
 	for (i = 16; i < 32; ++i) {
 		if (i == 24)
 			i = 28;
@@ -186,10 +186,10 @@ void *kvm_mips_build_vcpu_run(void *addr)
 	kvm_mips_build_save_scratch(&p, V1, K1);
 
 	/* VCPU scratch register has pointer to vcpu */
-	uasm_i_mtc0(&p, A1, scratch_vcpu[0], scratch_vcpu[1]);
+	UASM_i_MTC0(&p, A1, scratch_vcpu[0], scratch_vcpu[1]);
 
 	/* Offset into vcpu->arch */
-	uasm_i_addiu(&p, K1, A1, offsetof(struct kvm_vcpu, arch));
+	UASM_i_ADDIU(&p, K1, A1, offsetof(struct kvm_vcpu, arch));
 
 	/*
 	 * Save the host stack to VCPU, used for exception processing
@@ -252,7 +252,7 @@ static void *kvm_mips_build_enter_guest(void *addr)
 
 	/* Set Guest EPC */
 	UASM_i_LW(&p, T0, offsetof(struct kvm_vcpu_arch, pc), K1);
-	uasm_i_mtc0(&p, T0, C0_EPC);
+	UASM_i_MTC0(&p, T0, C0_EPC);
 
 	/* Set the ASID for the Guest Kernel */
 	UASM_i_LW(&p, T0, offsetof(struct kvm_vcpu_arch, cop0), K1);
@@ -261,20 +261,20 @@ static void *kvm_mips_build_enter_guest(void *addr)
 	uasm_i_andi(&p, T0, T0, KSU_USER | ST0_ERL | ST0_EXL);
 	uasm_i_xori(&p, T0, T0, KSU_USER);
 	uasm_il_bnez(&p, &r, T0, label_kernel_asid);
-	 uasm_i_addiu(&p, T1, K1,
+	 UASM_i_ADDIU(&p, T1, K1,
 		      offsetof(struct kvm_vcpu_arch, guest_kernel_asid));
 	/* else user */
-	uasm_i_addiu(&p, T1, K1,
+	UASM_i_ADDIU(&p, T1, K1,
 		     offsetof(struct kvm_vcpu_arch, guest_user_asid));
 	uasm_l_kernel_asid(&l, p);
 
 	/* t1: contains the base of the ASID array, need to get the cpu id  */
 	/* smp_processor_id */
-	UASM_i_LW(&p, T2, offsetof(struct thread_info, cpu), GP);
+	uasm_i_lw(&p, T2, offsetof(struct thread_info, cpu), GP);
 	/* x4 */
 	uasm_i_sll(&p, T2, T2, 2);
 	UASM_i_ADDU(&p, T3, T1, T2);
-	UASM_i_LW(&p, K0, 0, T3);
+	uasm_i_lw(&p, K0, 0, T3);
 #ifdef CONFIG_MIPS_ASID_BITS_VARIABLE
 	/* x sizeof(struct cpuinfo_mips)/4 */
 	uasm_i_addiu(&p, T3, ZERO, sizeof(struct cpuinfo_mips)/4);
@@ -344,11 +344,11 @@ void *kvm_mips_build_exception(void *addr, void *handler)
 	memset(relocs, 0, sizeof(relocs));
 
 	/* Save guest k1 into scratch register */
-	uasm_i_mtc0(&p, K1, scratch_tmp[0], scratch_tmp[1]);
+	UASM_i_MTC0(&p, K1, scratch_tmp[0], scratch_tmp[1]);
 
 	/* Get the VCPU pointer from the VCPU scratch register */
-	uasm_i_mfc0(&p, K1, scratch_vcpu[0], scratch_vcpu[1]);
-	uasm_i_addiu(&p, K1, K1, offsetof(struct kvm_vcpu, arch));
+	UASM_i_MFC0(&p, K1, scratch_vcpu[0], scratch_vcpu[1]);
+	UASM_i_ADDIU(&p, K1, K1, offsetof(struct kvm_vcpu, arch));
 
 	/* Save guest k0 into VCPU structure */
 	UASM_i_SW(&p, K0, offsetof(struct kvm_vcpu_arch, gprs[K0]), K1);
@@ -415,13 +415,13 @@ void *kvm_mips_build_exit(void *addr)
 
 	/* Finally save guest k1 to VCPU */
 	uasm_i_ehb(&p);
-	uasm_i_mfc0(&p, T0, scratch_tmp[0], scratch_tmp[1]);
+	UASM_i_MFC0(&p, T0, scratch_tmp[0], scratch_tmp[1]);
 	UASM_i_SW(&p, T0, offsetof(struct kvm_vcpu_arch, gprs[K1]), K1);
 
 	/* Now that context has been saved, we can use other registers */
 
 	/* Restore vcpu */
-	uasm_i_mfc0(&p, A1, scratch_vcpu[0], scratch_vcpu[1]);
+	UASM_i_MFC0(&p, A1, scratch_vcpu[0], scratch_vcpu[1]);
 	uasm_i_move(&p, S1, A1);
 
 	/* Restore run (vcpu->run) */
@@ -433,10 +433,10 @@ void *kvm_mips_build_exit(void *addr)
 	 * Save Host level EPC, BadVaddr and Cause to VCPU, useful to process
 	 * the exception
 	 */
-	uasm_i_mfc0(&p, K0, C0_EPC);
+	UASM_i_MFC0(&p, K0, C0_EPC);
 	UASM_i_SW(&p, K0, offsetof(struct kvm_vcpu_arch, pc), K1);
 
-	uasm_i_mfc0(&p, K0, C0_BADVADDR);
+	UASM_i_MFC0(&p, K0, C0_BADVADDR);
 	UASM_i_SW(&p, K0, offsetof(struct kvm_vcpu_arch, host_cp0_badvaddr),
 		  K1);
 
@@ -506,7 +506,7 @@ void *kvm_mips_build_exit(void *addr)
 	UASM_i_LW(&p, SP, offsetof(struct kvm_vcpu_arch, host_stack), K1);
 
 	/* Saved host state */
-	uasm_i_addiu(&p, SP, SP, -(int)sizeof(struct pt_regs));
+	UASM_i_ADDIU(&p, SP, SP, -(int)sizeof(struct pt_regs));
 
 	/*
 	 * XXXKYMA do we need to load the host ASID, maybe not because the
@@ -529,7 +529,7 @@ void *kvm_mips_build_exit(void *addr)
 	 */
 	UASM_i_LA(&p, T9, (unsigned long)kvm_mips_handle_exit);
 	uasm_i_jalr(&p, RA, T9);
-	 uasm_i_addiu(&p, SP, SP, -CALLFRAME_SIZ);
+	 UASM_i_ADDIU(&p, SP, SP, -CALLFRAME_SIZ);
 
 	uasm_resolve_relocs(relocs, labels);
 
@@ -569,7 +569,7 @@ static void *kvm_mips_build_ret_from_exit(void *addr)
 	 */
 
 	uasm_i_move(&p, K1, S1);
-	uasm_i_addiu(&p, K1, K1, offsetof(struct kvm_vcpu, arch));
+	UASM_i_ADDIU(&p, K1, K1, offsetof(struct kvm_vcpu, arch));
 
 	/*
 	 * Check return value, should tell us if we are returning to the
@@ -603,7 +603,7 @@ static void *kvm_mips_build_ret_to_guest(void *addr)
 	u32 *p = addr;
 
 	/* Put the saved pointer to vcpu (s1) back into the scratch register */
-	uasm_i_mtc0(&p, S1, scratch_vcpu[0], scratch_vcpu[1]);
+	UASM_i_MTC0(&p, S1, scratch_vcpu[0], scratch_vcpu[1]);
 
 	/* Load up the Guest EBASE to minimize the window where BEV is set */
 	UASM_i_LW(&p, T0, offsetof(struct kvm_vcpu_arch, guest_ebase), K1);
@@ -645,7 +645,7 @@ static void *kvm_mips_build_ret_to_host(void *addr)
 
 	/* EBASE is already pointing to Linux */
 	UASM_i_LW(&p, K1, offsetof(struct kvm_vcpu_arch, host_stack), K1);
-	uasm_i_addiu(&p, K1, K1, -(int)sizeof(struct pt_regs));
+	UASM_i_ADDIU(&p, K1, K1, -(int)sizeof(struct pt_regs));
 
 	/*
 	 * r2/v0 is the return code, shift it down by 2 (arithmetic)
-- 
2.4.10
