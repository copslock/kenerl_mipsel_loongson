Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Mar 2015 15:48:12 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:18298 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013330AbbCKOsKcEKIL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Mar 2015 15:48:10 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 7FDA2C02AB0D9;
        Wed, 11 Mar 2015 14:48:02 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 11 Mar 2015 14:48:04 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 11 Mar 2015 14:48:04 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
        <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Gleb Natapov <gleb@kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH 01/20] MIPS: KVM: Handle MSA Disabled exceptions from guest
Date:   Wed, 11 Mar 2015 14:44:37 +0000
Message-ID: <1426085096-12932-2-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 46315
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

Guest user mode can generate a guest MSA Disabled exception on an MSA
capable core by simply trying to execute an MSA instruction. Since this
exception is unknown to KVM it will be passed on to the guest kernel.
However guest Linux kernels prior to v3.15 do not set up an exception
handler for the MSA Disabled exception as they don't support any MSA
capable cores. This results in a guest OS panic.

Since an older processor ID may be being emulated, and MSA support is
not advertised to the guest, the correct behaviour is to generate a
Reserved Instruction exception in the guest kernel so it can send the
guest process an illegal instruction signal (SIGILL), as would happen
with a non-MSA-capable core.

Fix this as minimally as reasonably possible by preventing
kvm_mips_check_privilege() from relaying MSA Disabled exceptions from
guest user mode to the guest kernel, and handling the MSA Disabled
exception by emulating a Reserved Instruction exception in the guest,
via a new handle_msa_disabled() KVM callback.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
Cc: <stable@vger.kernel.org> # v3.15+
---
 arch/mips/include/asm/kvm_host.h |  2 ++
 arch/mips/kvm/emulate.c          |  1 +
 arch/mips/kvm/mips.c             |  4 ++++
 arch/mips/kvm/trap_emul.c        | 28 ++++++++++++++++++++++++++++
 4 files changed, 35 insertions(+)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index ac4fc716062b..f722b0528c25 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -322,6 +322,7 @@ enum mips_mmu_types {
 #define T_TRAP			13	/* Trap instruction */
 #define T_VCEI			14	/* Virtual coherency exception */
 #define T_FPE			15	/* Floating point exception */
+#define T_MSADIS		21	/* MSA disabled exception */
 #define T_WATCH			23	/* Watch address reference */
 #define T_VCED			31	/* Virtual coherency data */
 
@@ -578,6 +579,7 @@ struct kvm_mips_callbacks {
 	int (*handle_syscall)(struct kvm_vcpu *vcpu);
 	int (*handle_res_inst)(struct kvm_vcpu *vcpu);
 	int (*handle_break)(struct kvm_vcpu *vcpu);
+	int (*handle_msa_disabled)(struct kvm_vcpu *vcpu);
 	int (*vm_init)(struct kvm *kvm);
 	int (*vcpu_init)(struct kvm_vcpu *vcpu);
 	int (*vcpu_setup)(struct kvm_vcpu *vcpu);
diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index fb3e8dfd1ff6..838d3a6a5b7d 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -2176,6 +2176,7 @@ enum emulation_result kvm_mips_check_privilege(unsigned long cause,
 		case T_SYSCALL:
 		case T_BREAK:
 		case T_RES_INST:
+		case T_MSADIS:
 			break;
 
 		case T_COP_UNUSABLE:
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index c9eccf5df912..f5e7ddab02f7 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -1119,6 +1119,10 @@ int kvm_mips_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
 		ret = kvm_mips_callbacks->handle_break(vcpu);
 		break;
 
+	case T_MSADIS:
+		ret = kvm_mips_callbacks->handle_msa_disabled(vcpu);
+		break;
+
 	default:
 		kvm_err("Exception Code: %d, not yet handled, @ PC: %p, inst: 0x%08x  BadVaddr: %#lx Status: %#lx\n",
 			exccode, opc, kvm_get_inst(opc, vcpu), badvaddr,
diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index fd7257b70e65..4372cc86650c 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -330,6 +330,33 @@ static int kvm_trap_emul_handle_break(struct kvm_vcpu *vcpu)
 	return ret;
 }
 
+static int kvm_trap_emul_handle_msa_disabled(struct kvm_vcpu *vcpu)
+{
+	struct kvm_run *run = vcpu->run;
+	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.pc;
+	unsigned long cause = vcpu->arch.host_cp0_cause;
+	enum emulation_result er = EMULATE_DONE;
+	int ret = RESUME_GUEST;
+
+	/* No MSA supported in guest, guest reserved instruction exception */
+	er = kvm_mips_emulate_ri_exc(cause, opc, run, vcpu);
+
+	switch (er) {
+	case EMULATE_DONE:
+		ret = RESUME_GUEST;
+		break;
+
+	case EMULATE_FAIL:
+		run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+		ret = RESUME_HOST;
+		break;
+
+	default:
+		BUG();
+	}
+	return ret;
+}
+
 static int kvm_trap_emul_vm_init(struct kvm *kvm)
 {
 	return 0;
@@ -470,6 +497,7 @@ static struct kvm_mips_callbacks kvm_trap_emul_callbacks = {
 	.handle_syscall = kvm_trap_emul_handle_syscall,
 	.handle_res_inst = kvm_trap_emul_handle_res_inst,
 	.handle_break = kvm_trap_emul_handle_break,
+	.handle_msa_disabled = kvm_trap_emul_handle_msa_disabled,
 
 	.vm_init = kvm_trap_emul_vm_init,
 	.vcpu_init = kvm_trap_emul_vcpu_init,
-- 
2.0.5
