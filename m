Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Mar 2015 15:52:36 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:48917 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013343AbbCKOsS2ec1u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Mar 2015 15:48:18 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id EBCC7E555CC84;
        Wed, 11 Mar 2015 14:48:09 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 11 Mar 2015 14:48:12 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 11 Mar 2015 14:48:12 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
        <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Gleb Natapov <gleb@kernel.org>
Subject: [PATCH 13/20] MIPS: KVM: Add FP exception handling
Date:   Wed, 11 Mar 2015 14:44:49 +0000
Message-ID: <1426085096-12932-14-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 46330
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

Add guest exception handling for floating point exceptions and
coprocessor 1 unusable exceptions.

Floating point exceptions from the guest need passing to the guest
kernel, so for these a guest FPE is emulated.

Also, coprocessor 1 unusable exceptions are normally passed straight
through to the guest (because no guest FPU was supported), but the
hypervisor can now handle them if the guest has its FPU enabled by
restoring the guest FPU context and enabling the FPU.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h |  8 ++++++++
 arch/mips/kvm/emulate.c          | 36 ++++++++++++++++++++++++++++++++++++
 arch/mips/kvm/mips.c             |  7 +++++++
 arch/mips/kvm/stats.c            |  1 +
 arch/mips/kvm/trap_emul.c        | 39 ++++++++++++++++++++++++++++++++++++---
 5 files changed, 88 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 866edf330e53..fb264d8695e4 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -123,6 +123,7 @@ struct kvm_vcpu_stat {
 	u32 resvd_inst_exits;
 	u32 break_inst_exits;
 	u32 trap_inst_exits;
+	u32 fpe_exits;
 	u32 flush_dcache_exits;
 	u32 halt_successful_poll;
 	u32 halt_wakeup;
@@ -143,6 +144,7 @@ enum kvm_mips_exit_types {
 	RESVD_INST_EXITS,
 	BREAK_INST_EXITS,
 	TRAP_INST_EXITS,
+	FPE_EXITS,
 	FLUSH_DCACHE_EXITS,
 	MAX_KVM_MIPS_EXIT_TYPES
 };
@@ -585,6 +587,7 @@ struct kvm_mips_callbacks {
 	int (*handle_res_inst)(struct kvm_vcpu *vcpu);
 	int (*handle_break)(struct kvm_vcpu *vcpu);
 	int (*handle_trap)(struct kvm_vcpu *vcpu);
+	int (*handle_fpe)(struct kvm_vcpu *vcpu);
 	int (*handle_msa_disabled)(struct kvm_vcpu *vcpu);
 	int (*vm_init)(struct kvm *kvm);
 	int (*vcpu_init)(struct kvm_vcpu *vcpu);
@@ -734,6 +737,11 @@ extern enum emulation_result kvm_mips_emulate_trap_exc(unsigned long cause,
 						       struct kvm_run *run,
 						       struct kvm_vcpu *vcpu);
 
+extern enum emulation_result kvm_mips_emulate_fpe_exc(unsigned long cause,
+						      uint32_t *opc,
+						      struct kvm_run *run,
+						      struct kvm_vcpu *vcpu);
+
 extern enum emulation_result kvm_mips_complete_mmio_load(struct kvm_vcpu *vcpu,
 							 struct kvm_run *run);
 
diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index 3511bb20fe0e..fbf169fb63df 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -2146,6 +2146,41 @@ enum emulation_result kvm_mips_emulate_trap_exc(unsigned long cause,
 	return er;
 }
 
+enum emulation_result kvm_mips_emulate_fpe_exc(unsigned long cause,
+					       uint32_t *opc,
+					       struct kvm_run *run,
+					       struct kvm_vcpu *vcpu)
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
+		kvm_debug("Delivering FPE @ pc %#lx\n", arch->pc);
+
+		kvm_change_c0_guest_cause(cop0, (0xff),
+					  (T_FPE << CAUSEB_EXCCODE));
+
+		/* Set PC to the exception entry point */
+		arch->pc = KVM_GUEST_KSEG0 + 0x180;
+
+	} else {
+		kvm_err("Trying to deliver FPE when EXL is already set\n");
+		er = EMULATE_FAIL;
+	}
+
+	return er;
+}
+
 /* ll/sc, rdhwr, sync emulation */
 
 #define OPCODE 0xfc000000
@@ -2353,6 +2388,7 @@ enum emulation_result kvm_mips_check_privilege(unsigned long cause,
 		case T_BREAK:
 		case T_RES_INST:
 		case T_TRAP:
+		case T_FPE:
 		case T_MSADIS:
 			break;
 
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index b26a48d81467..dd0833833bea 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -50,6 +50,7 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{ "resvd_inst",	  VCPU_STAT(resvd_inst_exits),	 KVM_STAT_VCPU },
 	{ "break_inst",	  VCPU_STAT(break_inst_exits),	 KVM_STAT_VCPU },
 	{ "trap_inst",	  VCPU_STAT(trap_inst_exits),	 KVM_STAT_VCPU },
+	{ "fpe",	  VCPU_STAT(fpe_exits),		 KVM_STAT_VCPU },
 	{ "flush_dcache", VCPU_STAT(flush_dcache_exits), KVM_STAT_VCPU },
 	{ "halt_successful_poll", VCPU_STAT(halt_successful_poll), KVM_STAT_VCPU },
 	{ "halt_wakeup",  VCPU_STAT(halt_wakeup),	 KVM_STAT_VCPU },
@@ -1148,6 +1149,12 @@ int kvm_mips_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
 		ret = kvm_mips_callbacks->handle_trap(vcpu);
 		break;
 
+	case T_FPE:
+		++vcpu->stat.fpe_exits;
+		trace_kvm_exit(vcpu, FPE_EXITS);
+		ret = kvm_mips_callbacks->handle_fpe(vcpu);
+		break;
+
 	case T_MSADIS:
 		ret = kvm_mips_callbacks->handle_msa_disabled(vcpu);
 		break;
diff --git a/arch/mips/kvm/stats.c b/arch/mips/kvm/stats.c
index dd90b0a92181..3843828f3b91 100644
--- a/arch/mips/kvm/stats.c
+++ b/arch/mips/kvm/stats.c
@@ -26,6 +26,7 @@ char *kvm_mips_exit_types_str[MAX_KVM_MIPS_EXIT_TYPES] = {
 	"Reserved Inst",
 	"Break Inst",
 	"Trap Inst",
+	"FPE",
 	"D-Cache Flushes",
 };
 
diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index 408af244aed2..421d5b815f24 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -39,16 +39,30 @@ static gpa_t kvm_trap_emul_gva_to_gpa_cb(gva_t gva)
 
 static int kvm_trap_emul_handle_cop_unusable(struct kvm_vcpu *vcpu)
 {
+	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	struct kvm_run *run = vcpu->run;
 	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.pc;
 	unsigned long cause = vcpu->arch.host_cp0_cause;
 	enum emulation_result er = EMULATE_DONE;
 	int ret = RESUME_GUEST;
 
-	if (((cause & CAUSEF_CE) >> CAUSEB_CE) == 1)
-		er = kvm_mips_emulate_fpu_exc(cause, opc, run, vcpu);
-	else
+	if (((cause & CAUSEF_CE) >> CAUSEB_CE) == 1) {
+		/* FPU Unusable */
+		if (!kvm_mips_guest_has_fpu(&vcpu->arch) ||
+		    (kvm_read_c0_guest_status(cop0) & ST0_CU1) == 0) {
+			/*
+			 * Unusable/no FPU in guest:
+			 * deliver guest COP1 Unusable Exception
+			 */
+			er = kvm_mips_emulate_fpu_exc(cause, opc, run, vcpu);
+		} else {
+			/* Restore FPU state */
+			kvm_own_fpu(vcpu);
+			er = EMULATE_DONE;
+		}
+	} else {
 		er = kvm_mips_emulate_inst(cause, opc, run, vcpu);
+	}
 
 	switch (er) {
 	case EMULATE_DONE:
@@ -348,6 +362,24 @@ static int kvm_trap_emul_handle_trap(struct kvm_vcpu *vcpu)
 	return ret;
 }
 
+static int kvm_trap_emul_handle_fpe(struct kvm_vcpu *vcpu)
+{
+	struct kvm_run *run = vcpu->run;
+	uint32_t __user *opc = (uint32_t __user *)vcpu->arch.pc;
+	unsigned long cause = vcpu->arch.host_cp0_cause;
+	enum emulation_result er = EMULATE_DONE;
+	int ret = RESUME_GUEST;
+
+	er = kvm_mips_emulate_fpe_exc(cause, opc, run, vcpu);
+	if (er == EMULATE_DONE) {
+		ret = RESUME_GUEST;
+	} else {
+		run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+		ret = RESUME_HOST;
+	}
+	return ret;
+}
+
 static int kvm_trap_emul_handle_msa_disabled(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
@@ -576,6 +608,7 @@ static struct kvm_mips_callbacks kvm_trap_emul_callbacks = {
 	.handle_res_inst = kvm_trap_emul_handle_res_inst,
 	.handle_break = kvm_trap_emul_handle_break,
 	.handle_trap = kvm_trap_emul_handle_trap,
+	.handle_fpe = kvm_trap_emul_handle_fpe,
 	.handle_msa_disabled = kvm_trap_emul_handle_msa_disabled,
 
 	.vm_init = kvm_trap_emul_vm_init,
-- 
2.0.5
