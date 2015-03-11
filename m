Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Mar 2015 15:49:06 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:49301 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013350AbbCKOsLgt2J0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Mar 2015 15:48:11 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id F115B7DE209C;
        Wed, 11 Mar 2015 14:48:02 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 11 Mar 2015 14:48:05 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 11 Mar 2015 14:48:05 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
        <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Gleb Natapov <gleb@kernel.org>
Subject: [PATCH 03/20] MIPS: KVM: Handle TRAP exceptions from guest kernel
Date:   Wed, 11 Mar 2015 14:44:39 +0000
Message-ID: <1426085096-12932-4-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 46318
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

Trap instructions are used by Linux to implement BUG_ON(), however KVM
doesn't pass trap exceptions on to the guest if they occur in guest
kernel mode, instead triggering an internal error "Exception Code: 13,
not yet handled". The guest kernel then doesn't get a chance to print
the usual BUG message and stack trace.

Implement handling of the trap exception so that it gets passed to the
guest and the user is left with a more useful log message.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: kvm@vger.kernel.org
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/kvm_host.h |  8 ++++++++
 arch/mips/kvm/emulate.c          | 36 ++++++++++++++++++++++++++++++++++++
 arch/mips/kvm/mips.c             |  7 +++++++
 arch/mips/kvm/stats.c            |  1 +
 arch/mips/kvm/trap_emul.c        | 19 +++++++++++++++++++
 5 files changed, 71 insertions(+)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index f722b0528c25..8fc3ba2872f0 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -119,6 +119,7 @@ struct kvm_vcpu_stat {
 	u32 syscall_exits;
 	u32 resvd_inst_exits;
 	u32 break_inst_exits;
+	u32 trap_inst_exits;
 	u32 flush_dcache_exits;
 	u32 halt_successful_poll;
 	u32 halt_wakeup;
@@ -138,6 +139,7 @@ enum kvm_mips_exit_types {
 	SYSCALL_EXITS,
 	RESVD_INST_EXITS,
 	BREAK_INST_EXITS,
+	TRAP_INST_EXITS,
 	FLUSH_DCACHE_EXITS,
 	MAX_KVM_MIPS_EXIT_TYPES
 };
@@ -579,6 +581,7 @@ struct kvm_mips_callbacks {
 	int (*handle_syscall)(struct kvm_vcpu *vcpu);
 	int (*handle_res_inst)(struct kvm_vcpu *vcpu);
 	int (*handle_break)(struct kvm_vcpu *vcpu);
+	int (*handle_trap)(struct kvm_vcpu *vcpu);
 	int (*handle_msa_disabled)(struct kvm_vcpu *vcpu);
 	int (*vm_init)(struct kvm *kvm);
 	int (*vcpu_init)(struct kvm_vcpu *vcpu);
@@ -713,6 +716,11 @@ extern enum emulation_result kvm_mips_emulate_bp_exc(unsigned long cause,
 						     struct kvm_run *run,
 						     struct kvm_vcpu *vcpu);
 
+extern enum emulation_result kvm_mips_emulate_trap_exc(unsigned long cause,
+						       uint32_t *opc,
+						       struct kvm_run *run,
+						       struct kvm_vcpu *vcpu);
+
 extern enum emulation_result kvm_mips_complete_mmio_load(struct kvm_vcpu *vcpu,
 							 struct kvm_run *run);
 
diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index 838d3a6a5b7d..33e132dc7de8 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -1970,6 +1970,41 @@ enum emulation_result kvm_mips_emulate_bp_exc(unsigned long cause,
 	return er;
 }
 
+enum emulation_result kvm_mips_emulate_trap_exc(unsigned long cause,
+						uint32_t *opc,
+						struct kvm_run *run,
+						struct kvm_vcpu *vcpu)
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
+		kvm_debug("Delivering TRAP @ pc %#lx\n", arch->pc);
+
+		kvm_change_c0_guest_cause(cop0, (0xff),
+					  (T_TRAP << CAUSEB_EXCCODE));
+
+		/* Set PC to the exception entry point */
+		arch->pc = KVM_GUEST_KSEG0 + 0x180;
+
+	} else {
+		kvm_err("Trying to deliver TRAP when EXL is already set\n");
+		er = EMULATE_FAIL;
+	}
+
+	return er;
+}
+
 /* ll/sc, rdhwr, sync emulation */
 
 #define OPCODE 0xfc000000
@@ -2176,6 +2211,7 @@ enum emulation_result kvm_mips_check_privilege(unsigned long cause,
 		case T_SYSCALL:
 		case T_BREAK:
 		case T_RES_INST:
+		case T_TRAP:
 		case T_MSADIS:
 			break;
 
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index f5e7ddab02f7..399b5517ecb8 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -48,6 +48,7 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{ "syscall",	  VCPU_STAT(syscall_exits),	 KVM_STAT_VCPU },
 	{ "resvd_inst",	  VCPU_STAT(resvd_inst_exits),	 KVM_STAT_VCPU },
 	{ "break_inst",	  VCPU_STAT(break_inst_exits),	 KVM_STAT_VCPU },
+	{ "trap_inst",	  VCPU_STAT(trap_inst_exits),	 KVM_STAT_VCPU },
 	{ "flush_dcache", VCPU_STAT(flush_dcache_exits), KVM_STAT_VCPU },
 	{ "halt_successful_poll", VCPU_STAT(halt_successful_poll), KVM_STAT_VCPU },
 	{ "halt_wakeup",  VCPU_STAT(halt_wakeup),	 KVM_STAT_VCPU },
@@ -1119,6 +1120,12 @@ int kvm_mips_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
 		ret = kvm_mips_callbacks->handle_break(vcpu);
 		break;
 
+	case T_TRAP:
+		++vcpu->stat.trap_inst_exits;
+		trace_kvm_exit(vcpu, TRAP_INST_EXITS);
+		ret = kvm_mips_callbacks->handle_trap(vcpu);
+		break;
+
 	case T_MSADIS:
 		ret = kvm_mips_callbacks->handle_msa_disabled(vcpu);
 		break;
diff --git a/arch/mips/kvm/stats.c b/arch/mips/kvm/stats.c
index a74d6024c5ad..dd90b0a92181 100644
--- a/arch/mips/kvm/stats.c
+++ b/arch/mips/kvm/stats.c
@@ -25,6 +25,7 @@ char *kvm_mips_exit_types_str[MAX_KVM_MIPS_EXIT_TYPES] = {
 	"System Call",
 	"Reserved Inst",
 	"Break Inst",
+	"Trap Inst",
 	"D-Cache Flushes",
 };
 
diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index 4372cc86650c..dc019950e243 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -330,6 +330,24 @@ static int kvm_trap_emul_handle_break(struct kvm_vcpu *vcpu)
 	return ret;
 }
 
+static int kvm_trap_emul_handle_trap(struct kvm_vcpu *vcpu)
+{
+	struct kvm_run *run = vcpu->run;
+	uint32_t __user *opc = (uint32_t __user *)vcpu->arch.pc;
+	unsigned long cause = vcpu->arch.host_cp0_cause;
+	enum emulation_result er = EMULATE_DONE;
+	int ret = RESUME_GUEST;
+
+	er = kvm_mips_emulate_trap_exc(cause, opc, run, vcpu);
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
@@ -497,6 +515,7 @@ static struct kvm_mips_callbacks kvm_trap_emul_callbacks = {
 	.handle_syscall = kvm_trap_emul_handle_syscall,
 	.handle_res_inst = kvm_trap_emul_handle_res_inst,
 	.handle_break = kvm_trap_emul_handle_break,
+	.handle_trap = kvm_trap_emul_handle_trap,
 	.handle_msa_disabled = kvm_trap_emul_handle_msa_disabled,
 
 	.vm_init = kvm_trap_emul_vm_init,
-- 
2.0.5
