Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Mar 2015 15:51:26 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:4149 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013405AbbCKOsRkZoMN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Mar 2015 15:48:17 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 26FE0FFDB396D;
        Wed, 11 Mar 2015 14:48:14 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 11 Mar 2015 14:48:16 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 11 Mar 2015 14:48:15 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
        <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Gleb Natapov <gleb@kernel.org>
Subject: [PATCH 18/20] MIPS: KVM: Add MSA exception handling
Date:   Wed, 11 Mar 2015 14:44:54 +0000
Message-ID: <1426085096-12932-19-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 46326
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

Add guest exception handling for MIPS SIMD Architecture (MSA) floating
point exceptions and MSA disabled exceptions.

MSA floating point exceptions from the guest need passing to the guest
kernel, so for these a guest MSAFPE is emulated.

MSA disabled exceptions are normally handled by passing a reserved
instruction exception to the guest (because no guest MSA was supported),
but the hypervisor can now handle them if the guest has MSA by passing
an MSA disabled exception to the guest, or if the guest has MSA enabled
by transparently restoring the guest MSA context and enabling MSA and
the FPU.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h | 16 +++++++++
 arch/mips/kvm/emulate.c          | 71 ++++++++++++++++++++++++++++++++++++++++
 arch/mips/kvm/mips.c             | 10 ++++++
 arch/mips/kvm/stats.c            |  2 ++
 arch/mips/kvm/trap_emul.c        | 43 ++++++++++++++++++++++--
 5 files changed, 140 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 1dc0dca15cbd..4c25823563fe 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -123,7 +123,9 @@ struct kvm_vcpu_stat {
 	u32 resvd_inst_exits;
 	u32 break_inst_exits;
 	u32 trap_inst_exits;
+	u32 msa_fpe_exits;
 	u32 fpe_exits;
+	u32 msa_disabled_exits;
 	u32 flush_dcache_exits;
 	u32 halt_successful_poll;
 	u32 halt_wakeup;
@@ -144,7 +146,9 @@ enum kvm_mips_exit_types {
 	RESVD_INST_EXITS,
 	BREAK_INST_EXITS,
 	TRAP_INST_EXITS,
+	MSA_FPE_EXITS,
 	FPE_EXITS,
+	MSA_DISABLED_EXITS,
 	FLUSH_DCACHE_EXITS,
 	MAX_KVM_MIPS_EXIT_TYPES
 };
@@ -305,6 +309,7 @@ enum mips_mmu_types {
  */
 #define T_TRAP			13	/* Trap instruction */
 #define T_VCEI			14	/* Virtual coherency exception */
+#define T_MSAFPE		14	/* MSA floating point exception */
 #define T_FPE			15	/* Floating point exception */
 #define T_MSADIS		21	/* MSA disabled exception */
 #define T_WATCH			23	/* Watch address reference */
@@ -601,6 +606,7 @@ struct kvm_mips_callbacks {
 	int (*handle_res_inst)(struct kvm_vcpu *vcpu);
 	int (*handle_break)(struct kvm_vcpu *vcpu);
 	int (*handle_trap)(struct kvm_vcpu *vcpu);
+	int (*handle_msa_fpe)(struct kvm_vcpu *vcpu);
 	int (*handle_fpe)(struct kvm_vcpu *vcpu);
 	int (*handle_msa_disabled)(struct kvm_vcpu *vcpu);
 	int (*vm_init)(struct kvm *kvm);
@@ -756,11 +762,21 @@ extern enum emulation_result kvm_mips_emulate_trap_exc(unsigned long cause,
 						       struct kvm_run *run,
 						       struct kvm_vcpu *vcpu);
 
+extern enum emulation_result kvm_mips_emulate_msafpe_exc(unsigned long cause,
+							 uint32_t *opc,
+							 struct kvm_run *run,
+							 struct kvm_vcpu *vcpu);
+
 extern enum emulation_result kvm_mips_emulate_fpe_exc(unsigned long cause,
 						      uint32_t *opc,
 						      struct kvm_run *run,
 						      struct kvm_vcpu *vcpu);
 
+extern enum emulation_result kvm_mips_emulate_msadis_exc(unsigned long cause,
+							 uint32_t *opc,
+							 struct kvm_run *run,
+							 struct kvm_vcpu *vcpu);
+
 extern enum emulation_result kvm_mips_complete_mmio_load(struct kvm_vcpu *vcpu,
 							 struct kvm_run *run);
 
diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index 07f554c72cb8..6230f376a44e 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -2179,6 +2179,41 @@ enum emulation_result kvm_mips_emulate_trap_exc(unsigned long cause,
 	return er;
 }
 
+enum emulation_result kvm_mips_emulate_msafpe_exc(unsigned long cause,
+						  uint32_t *opc,
+						  struct kvm_run *run,
+						  struct kvm_vcpu *vcpu)
+{
+	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct kvm_vcpu_arch *arch = &vcpu->arch;
+	enum emulation_result er = EMULATE_DONE;
+
+	if ((kvm_read_c0_guest_status(cop0) & ST0_EXL) == 0) {
+		/* save old pc */
+		kvm_write_c0_guest_epc(cop0, arch->pc);
+		kvm_set_c0_guest_status(cop0, ST0_EXL);
+
+		if (cause & CAUSEF_BD)
+			kvm_set_c0_guest_cause(cop0, CAUSEF_BD);
+		else
+			kvm_clear_c0_guest_cause(cop0, CAUSEF_BD);
+
+		kvm_debug("Delivering MSAFPE @ pc %#lx\n", arch->pc);
+
+		kvm_change_c0_guest_cause(cop0, (0xff),
+					  (T_MSAFPE << CAUSEB_EXCCODE));
+
+		/* Set PC to the exception entry point */
+		arch->pc = KVM_GUEST_KSEG0 + 0x180;
+
+	} else {
+		kvm_err("Trying to deliver MSAFPE when EXL is already set\n");
+		er = EMULATE_FAIL;
+	}
+
+	return er;
+}
+
 enum emulation_result kvm_mips_emulate_fpe_exc(unsigned long cause,
 					       uint32_t *opc,
 					       struct kvm_run *run,
@@ -2214,6 +2249,41 @@ enum emulation_result kvm_mips_emulate_fpe_exc(unsigned long cause,
 	return er;
 }
 
+enum emulation_result kvm_mips_emulate_msadis_exc(unsigned long cause,
+						  uint32_t *opc,
+						  struct kvm_run *run,
+						  struct kvm_vcpu *vcpu)
+{
+	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct kvm_vcpu_arch *arch = &vcpu->arch;
+	enum emulation_result er = EMULATE_DONE;
+
+	if ((kvm_read_c0_guest_status(cop0) & ST0_EXL) == 0) {
+		/* save old pc */
+		kvm_write_c0_guest_epc(cop0, arch->pc);
+		kvm_set_c0_guest_status(cop0, ST0_EXL);
+
+		if (cause & CAUSEF_BD)
+			kvm_set_c0_guest_cause(cop0, CAUSEF_BD);
+		else
+			kvm_clear_c0_guest_cause(cop0, CAUSEF_BD);
+
+		kvm_debug("Delivering MSADIS @ pc %#lx\n", arch->pc);
+
+		kvm_change_c0_guest_cause(cop0, (0xff),
+					  (T_MSADIS << CAUSEB_EXCCODE));
+
+		/* Set PC to the exception entry point */
+		arch->pc = KVM_GUEST_KSEG0 + 0x180;
+
+	} else {
+		kvm_err("Trying to deliver MSADIS when EXL is already set\n");
+		er = EMULATE_FAIL;
+	}
+
+	return er;
+}
+
 /* ll/sc, rdhwr, sync emulation */
 
 #define OPCODE 0xfc000000
@@ -2421,6 +2491,7 @@ enum emulation_result kvm_mips_check_privilege(unsigned long cause,
 		case T_BREAK:
 		case T_RES_INST:
 		case T_TRAP:
+		case T_MSAFPE:
 		case T_FPE:
 		case T_MSADIS:
 			break;
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 17434e8b452d..a44a37475156 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -50,7 +50,9 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{ "resvd_inst",	  VCPU_STAT(resvd_inst_exits),	 KVM_STAT_VCPU },
 	{ "break_inst",	  VCPU_STAT(break_inst_exits),	 KVM_STAT_VCPU },
 	{ "trap_inst",	  VCPU_STAT(trap_inst_exits),	 KVM_STAT_VCPU },
+	{ "msa_fpe",	  VCPU_STAT(msa_fpe_exits),	 KVM_STAT_VCPU },
 	{ "fpe",	  VCPU_STAT(fpe_exits),		 KVM_STAT_VCPU },
+	{ "msa_disabled", VCPU_STAT(msa_disabled_exits), KVM_STAT_VCPU },
 	{ "flush_dcache", VCPU_STAT(flush_dcache_exits), KVM_STAT_VCPU },
 	{ "halt_successful_poll", VCPU_STAT(halt_successful_poll), KVM_STAT_VCPU },
 	{ "halt_wakeup",  VCPU_STAT(halt_wakeup),	 KVM_STAT_VCPU },
@@ -1256,6 +1258,12 @@ int kvm_mips_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
 		ret = kvm_mips_callbacks->handle_trap(vcpu);
 		break;
 
+	case T_MSAFPE:
+		++vcpu->stat.msa_fpe_exits;
+		trace_kvm_exit(vcpu, MSA_FPE_EXITS);
+		ret = kvm_mips_callbacks->handle_msa_fpe(vcpu);
+		break;
+
 	case T_FPE:
 		++vcpu->stat.fpe_exits;
 		trace_kvm_exit(vcpu, FPE_EXITS);
@@ -1263,6 +1271,8 @@ int kvm_mips_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
 		break;
 
 	case T_MSADIS:
+		++vcpu->stat.msa_disabled_exits;
+		trace_kvm_exit(vcpu, MSA_DISABLED_EXITS);
 		ret = kvm_mips_callbacks->handle_msa_disabled(vcpu);
 		break;
 
diff --git a/arch/mips/kvm/stats.c b/arch/mips/kvm/stats.c
index 3843828f3b91..888bb67070ac 100644
--- a/arch/mips/kvm/stats.c
+++ b/arch/mips/kvm/stats.c
@@ -26,7 +26,9 @@ char *kvm_mips_exit_types_str[MAX_KVM_MIPS_EXIT_TYPES] = {
 	"Reserved Inst",
 	"Break Inst",
 	"Trap Inst",
+	"MSA FPE",
 	"FPE",
+	"MSA Disabled",
 	"D-Cache Flushes",
 };
 
diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index 421d5b815f24..d836ed5b0bc7 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -362,6 +362,24 @@ static int kvm_trap_emul_handle_trap(struct kvm_vcpu *vcpu)
 	return ret;
 }
 
+static int kvm_trap_emul_handle_msa_fpe(struct kvm_vcpu *vcpu)
+{
+	struct kvm_run *run = vcpu->run;
+	uint32_t __user *opc = (uint32_t __user *)vcpu->arch.pc;
+	unsigned long cause = vcpu->arch.host_cp0_cause;
+	enum emulation_result er = EMULATE_DONE;
+	int ret = RESUME_GUEST;
+
+	er = kvm_mips_emulate_msafpe_exc(cause, opc, run, vcpu);
+	if (er == EMULATE_DONE) {
+		ret = RESUME_GUEST;
+	} else {
+		run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+		ret = RESUME_HOST;
+	}
+	return ret;
+}
+
 static int kvm_trap_emul_handle_fpe(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
@@ -380,16 +398,36 @@ static int kvm_trap_emul_handle_fpe(struct kvm_vcpu *vcpu)
 	return ret;
 }
 
+/**
+ * kvm_trap_emul_handle_msa_disabled() - Guest used MSA while disabled in root.
+ * @vcpu:	Virtual CPU context.
+ *
+ * Handle when the guest attempts to use MSA when it is disabled.
+ */
 static int kvm_trap_emul_handle_msa_disabled(struct kvm_vcpu *vcpu)
 {
+	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	struct kvm_run *run = vcpu->run;
 	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.pc;
 	unsigned long cause = vcpu->arch.host_cp0_cause;
 	enum emulation_result er = EMULATE_DONE;
 	int ret = RESUME_GUEST;
 
-	/* No MSA supported in guest, guest reserved instruction exception */
-	er = kvm_mips_emulate_ri_exc(cause, opc, run, vcpu);
+	if (!kvm_mips_guest_has_msa(&vcpu->arch) ||
+	    (kvm_read_c0_guest_status(cop0) & (ST0_CU1 | ST0_FR)) == ST0_CU1) {
+		/*
+		 * No MSA in guest, or FPU enabled and not in FR=1 mode,
+		 * guest reserved instruction exception
+		 */
+		er = kvm_mips_emulate_ri_exc(cause, opc, run, vcpu);
+	} else if (!(kvm_read_c0_guest_config5(cop0) & MIPS_CONF5_MSAEN)) {
+		/* MSA disabled by guest, guest MSA disabled exception */
+		er = kvm_mips_emulate_msadis_exc(cause, opc, run, vcpu);
+	} else {
+		/* Restore MSA/FPU state */
+		kvm_own_msa(vcpu);
+		er = EMULATE_DONE;
+	}
 
 	switch (er) {
 	case EMULATE_DONE:
@@ -608,6 +646,7 @@ static struct kvm_mips_callbacks kvm_trap_emul_callbacks = {
 	.handle_res_inst = kvm_trap_emul_handle_res_inst,
 	.handle_break = kvm_trap_emul_handle_break,
 	.handle_trap = kvm_trap_emul_handle_trap,
+	.handle_msa_fpe = kvm_trap_emul_handle_msa_fpe,
 	.handle_fpe = kvm_trap_emul_handle_fpe,
 	.handle_msa_disabled = kvm_trap_emul_handle_msa_disabled,
 
-- 
2.0.5
