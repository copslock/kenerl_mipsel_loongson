Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jun 2016 18:38:43 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:7679 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27043856AbcFWQfGmP77z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Jun 2016 18:35:06 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 201E75E01E6E2;
        Thu, 23 Jun 2016 17:34:56 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 23 Jun 2016 17:34:59 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>,
        <kvm@vger.kernel.org>
Subject: [PATCH 12/14] MIPS: KVM: Dynamically choose scratch registers
Date:   Thu, 23 Jun 2016 17:34:45 +0100
Message-ID: <1466699687-24791-13-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 54149
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

Scratch cop0 registers are needed by KVM to be able to save/restore all
the GPRs, including k0/k1, and for storing the VCPU pointer. However no
registers are universally suitable for these purposes, so the decision
should be made at runtime.

Until now, we've used DDATA_LO to store the VCPU pointer, and ErrorEPC
as a temporary. It could be argued that this is abuse of those
registers, and DDATA_LO is known not to be usable on certain
implementations (Cavium Octeon). If KScratch registers are present, use
them instead.

We save & restore the temporary register in addition to the VCPU pointer
register when using a KScratch register for it, as it may be used for
normal host TLB handling too.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h |  1 +
 arch/mips/kvm/entry.c            | 94 +++++++++++++++++++++++++++++++++-------
 arch/mips/kvm/mips.c             |  4 ++
 3 files changed, 84 insertions(+), 15 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 2e76e899079c..a80c3208b234 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -536,6 +536,7 @@ int kvm_arch_vcpu_dump_regs(struct kvm_vcpu *vcpu);
 extern int kvm_mips_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu);
 
 /* Building of entry/exception code */
+int kvm_mips_entry_setup(void);
 void *kvm_mips_build_vcpu_run(void *addr);
 void *kvm_mips_build_exception(void *addr);
 void *kvm_mips_build_exit(void *addr);
diff --git a/arch/mips/kvm/entry.c b/arch/mips/kvm/entry.c
index 6395bfa7e542..b6e7fd9f12f0 100644
--- a/arch/mips/kvm/entry.c
+++ b/arch/mips/kvm/entry.c
@@ -61,6 +61,9 @@
 
 #define CALLFRAME_SIZ   32
 
+static unsigned int scratch_vcpu[2] = { C0_DDATA_LO };
+static unsigned int scratch_tmp[2] = { C0_ERROREPC };
+
 enum label_id {
 	label_fpu_1 = 1,
 	label_msa_1,
@@ -79,6 +82,69 @@ static void *kvm_mips_build_ret_to_guest(void *addr);
 static void *kvm_mips_build_ret_to_host(void *addr);
 
 /**
+ * kvm_mips_entry_setup() - Perform global setup for entry code.
+ *
+ * Perform global setup for entry code, such as choosing a scratch register.
+ *
+ * Returns:	0 on success.
+ *		-errno on failure.
+ */
+int kvm_mips_entry_setup(void)
+{
+	/*
+	 * We prefer to use KScratchN registers if they are available over the
+	 * defaults above, which may not work on all cores.
+	 */
+	unsigned int kscratch_mask = cpu_data[0].kscratch_mask & 0xfc;
+
+	/* Pick a scratch register for storing VCPU */
+	if (kscratch_mask) {
+		scratch_vcpu[0] = 31;
+		scratch_vcpu[1] = ffs(kscratch_mask) - 1;
+		kscratch_mask &= ~BIT(scratch_vcpu[1]);
+	}
+
+	/* Pick a scratch register to use as a temp for saving state */
+	if (kscratch_mask) {
+		scratch_tmp[0] = 31;
+		scratch_tmp[1] = ffs(kscratch_mask) - 1;
+		kscratch_mask &= ~BIT(scratch_tmp[1]);
+	}
+
+	return 0;
+}
+
+static void kvm_mips_build_save_scratch(u32 **p, unsigned int tmp,
+					unsigned int frame)
+{
+	/* Save the VCPU scratch register value in cp0_epc of the stack frame */
+	uasm_i_mfc0(p, tmp, scratch_vcpu[0], scratch_vcpu[1]);
+	UASM_i_SW(p, tmp, offsetof(struct pt_regs, cp0_epc), frame);
+
+	/* Save the temp scratch register value in cp0_cause of stack frame */
+	if (scratch_tmp[0] == 31) {
+		uasm_i_mfc0(p, tmp, scratch_tmp[0], scratch_tmp[1]);
+		UASM_i_SW(p, tmp, offsetof(struct pt_regs, cp0_cause), frame);
+	}
+}
+
+static void kvm_mips_build_restore_scratch(u32 **p, unsigned int tmp,
+					   unsigned int frame)
+{
+	/*
+	 * Restore host scratch register values saved by
+	 * kvm_mips_build_save_scratch().
+	 */
+	UASM_i_LW(p, tmp, offsetof(struct pt_regs, cp0_epc), frame);
+	uasm_i_mtc0(p, tmp, scratch_vcpu[0], scratch_vcpu[1]);
+
+	if (scratch_tmp[0] == 31) {
+		UASM_i_LW(p, tmp, offsetof(struct pt_regs, cp0_cause), frame);
+		uasm_i_mtc0(p, tmp, scratch_tmp[0], scratch_tmp[1]);
+	}
+}
+
+/**
  * kvm_mips_build_vcpu_run() - Assemble function to start running a guest VCPU.
  * @addr:	Address to start writing code.
  *
@@ -120,12 +186,11 @@ void *kvm_mips_build_vcpu_run(void *addr)
 	uasm_i_mfc0(&p, V0, C0_STATUS);
 	UASM_i_SW(&p, V0, offsetof(struct pt_regs, cp0_status), K1);
 
-	/* Save DDATA_LO, will be used to store pointer to vcpu */
-	uasm_i_mfc0(&p, V1, C0_DDATA_LO);
-	UASM_i_SW(&p, V1, offsetof(struct pt_regs, cp0_epc), K1);
+	/* Save scratch registers, will be used to store pointer to vcpu etc */
+	kvm_mips_build_save_scratch(&p, V1, K1);
 
-	/* DDATA_LO has pointer to vcpu */
-	uasm_i_mtc0(&p, A1, C0_DDATA_LO);
+	/* VCPU scratch register has pointer to vcpu */
+	uasm_i_mtc0(&p, A1, scratch_vcpu[0], scratch_vcpu[1]);
 
 	/* Offset into vcpu->arch */
 	uasm_i_addiu(&p, K1, A1, offsetof(struct kvm_vcpu, arch));
@@ -273,7 +338,7 @@ void *kvm_mips_build_exception(void *addr)
 	u32 *p = addr;
 
 	/* Save guest k0 */
-	uasm_i_mtc0(&p, K0, C0_ERROREPC);
+	uasm_i_mtc0(&p, K0, scratch_tmp[0], scratch_tmp[1]);
 	uasm_i_ehb(&p);
 
 	/* Get EBASE */
@@ -321,8 +386,8 @@ void *kvm_mips_build_exit(void *addr)
 	 * does something that causes a trap to kernel mode.
 	 */
 
-	/* Get the VCPU pointer from DDATA_LO */
-	uasm_i_mfc0(&p, K1, C0_DDATA_LO);
+	/* Get the VCPU pointer from the scratch register */
+	uasm_i_mfc0(&p, K1, scratch_vcpu[0], scratch_vcpu[1]);
 	uasm_i_addiu(&p, K1, K1, offsetof(struct kvm_vcpu, arch));
 
 	/* Start saving Guest context to VCPU */
@@ -341,7 +406,7 @@ void *kvm_mips_build_exit(void *addr)
 	UASM_i_SW(&p, T0, offsetof(struct kvm_vcpu_arch, lo), K1);
 
 	/* Finally save guest k0/k1 to VCPU */
-	uasm_i_mfc0(&p, T0, C0_ERROREPC);
+	uasm_i_mfc0(&p, T0, scratch_tmp[0], scratch_tmp[1]);
 	UASM_i_SW(&p, T0, offsetof(struct kvm_vcpu_arch, gprs[K0]), K1);
 
 	/* Get GUEST k1 and save it in VCPU */
@@ -354,7 +419,7 @@ void *kvm_mips_build_exit(void *addr)
 	/* Now that context has been saved, we can use other registers */
 
 	/* Restore vcpu */
-	uasm_i_mfc0(&p, A1, C0_DDATA_LO);
+	uasm_i_mfc0(&p, A1, scratch_vcpu[0], scratch_vcpu[1]);
 	uasm_i_move(&p, S1, A1);
 
 	/* Restore run (vcpu->run) */
@@ -446,9 +511,8 @@ void *kvm_mips_build_exit(void *addr)
 	 * kernel entries are marked GLOBAL, need to verify
 	 */
 
-	/* Restore host DDATA_LO */
-	UASM_i_LW(&p, K0, offsetof(struct pt_regs, cp0_epc), SP);
-	uasm_i_mtc0(&p, K0, C0_DDATA_LO);
+	/* Restore host scratch registers, as we'll have clobbered them */
+	kvm_mips_build_restore_scratch(&p, K0, SP);
 
 	/* Restore RDHWR access */
 	UASM_i_LA_mostly(&p, K0, (long)&hwrena);
@@ -536,8 +600,8 @@ static void *kvm_mips_build_ret_to_guest(void *addr)
 {
 	u32 *p = addr;
 
-	/* Put the saved pointer to vcpu (s1) back into the DDATA_LO Register */
-	uasm_i_mtc0(&p, S1, C0_DDATA_LO);
+	/* Put the saved pointer to vcpu (s1) back into the scratch register */
+	uasm_i_mtc0(&p, S1, scratch_vcpu[0], scratch_vcpu[1]);
 
 	/* Load up the Guest EBASE to minimize the window where BEV is set */
 	UASM_i_LW(&p, T0, offsetof(struct kvm_vcpu_arch, guest_ebase), K1);
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index f809ad84196d..e45b505e2ad7 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -1775,6 +1775,10 @@ static int __init kvm_mips_init(void)
 {
 	int ret;
 
+	ret = kvm_mips_entry_setup();
+	if (ret)
+		return ret;
+
 	ret = kvm_init(NULL, sizeof(struct kvm_vcpu), 0, THIS_MODULE);
 
 	if (ret)
-- 
2.4.10
