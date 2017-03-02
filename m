Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Mar 2017 10:43:50 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:16313 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993886AbdCBJhbgl--t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Mar 2017 10:37:31 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 3DD4BC34D45AF;
        Thu,  2 Mar 2017 09:37:28 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 2 Mar 2017 09:37:29 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH 16/32] KVM: MIPS: Add guest exit exception callback
Date:   Thu, 2 Mar 2017 09:36:43 +0000
Message-ID: <dbd9d1313c2d076f9536c59694fe1bc3a6757d53.1488447004.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.1
MIME-Version: 1.0
In-Reply-To: <cover.5cfb5298ebc2f5308f4f56aaac7fa31c39a8ab58.1488447004.git-series.james.hogan@imgtec.com>
References: <cover.5cfb5298ebc2f5308f4f56aaac7fa31c39a8ab58.1488447004.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56974
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

Add a callback for MIPS KVM implementations to handle the VZ guest
exit exception. Currently the trap & emulate implementation contains a
stub which reports an internal error, but the callback will be used
properly by the VZ implementation.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h |  1 +
 arch/mips/kvm/mips.c             |  5 +++++
 arch/mips/kvm/trace.h            |  2 ++
 arch/mips/kvm/trap_emul.c        | 24 ++++++++++++++++++++++++
 4 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 8572f024f728..3fee98e44f67 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -545,6 +545,7 @@ struct kvm_mips_callbacks {
 	int (*handle_msa_fpe)(struct kvm_vcpu *vcpu);
 	int (*handle_fpe)(struct kvm_vcpu *vcpu);
 	int (*handle_msa_disabled)(struct kvm_vcpu *vcpu);
+	int (*handle_guest_exit)(struct kvm_vcpu *vcpu);
 	int (*hardware_enable)(void);
 	void (*hardware_disable)(void);
 	int (*check_extension)(struct kvm *kvm, long ext);
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 59e79ca76720..9dd9905681ed 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -1350,6 +1350,11 @@ int kvm_mips_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
 		ret = kvm_mips_callbacks->handle_msa_disabled(vcpu);
 		break;
 
+	case EXCCODE_GE:
+		/* defer exit accounting to handler */
+		ret = kvm_mips_callbacks->handle_guest_exit(vcpu);
+		break;
+
 	default:
 		if (cause & CAUSEF_BD)
 			opc += 1;
diff --git a/arch/mips/kvm/trace.h b/arch/mips/kvm/trace.h
index 6e43c89114b8..0c59282a2f7d 100644
--- a/arch/mips/kvm/trace.h
+++ b/arch/mips/kvm/trace.h
@@ -62,6 +62,7 @@ DEFINE_EVENT(kvm_transition, kvm_out,
 #define KVM_TRACE_EXIT_MSA_FPE		14
 #define KVM_TRACE_EXIT_FPE		15
 #define KVM_TRACE_EXIT_MSA_DISABLED	21
+#define KVM_TRACE_EXIT_GUEST_EXIT	27
 /* Further exit reasons */
 #define KVM_TRACE_EXIT_WAIT		32
 #define KVM_TRACE_EXIT_CACHE		33
@@ -92,6 +93,7 @@ DEFINE_EVENT(kvm_transition, kvm_out,
 	{ KVM_TRACE_EXIT_MSA_FPE,	"MSA FPE" },		\
 	{ KVM_TRACE_EXIT_FPE,		"FPE" },		\
 	{ KVM_TRACE_EXIT_MSA_DISABLED,	"MSA Disabled" },	\
+	{ KVM_TRACE_EXIT_GUEST_EXIT,	"Guest Exit" },		\
 	{ KVM_TRACE_EXIT_WAIT,		"WAIT" },		\
 	{ KVM_TRACE_EXIT_CACHE,		"CACHE" },		\
 	{ KVM_TRACE_EXIT_SIGNAL,	"Signal" },		\
diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index c8a0e927220b..1e039fb592e0 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -40,6 +40,29 @@ static gpa_t kvm_trap_emul_gva_to_gpa_cb(gva_t gva)
 	return gpa;
 }
 
+static int kvm_trap_emul_no_handler(struct kvm_vcpu *vcpu)
+{
+	u32 __user *opc = (u32 __user *) vcpu->arch.pc;
+	u32 cause = vcpu->arch.host_cp0_cause;
+	u32 exccode = (cause & CAUSEF_EXCCODE) >> CAUSEB_EXCCODE;
+	unsigned long badvaddr = vcpu->arch.host_cp0_badvaddr;
+	u32 inst = 0;
+
+	/*
+	 *  Fetch the instruction.
+	 */
+	if (cause & CAUSEF_BD)
+		opc += 1;
+	kvm_get_badinstr(opc, vcpu, &inst);
+
+	kvm_err("Exception Code: %d not handled @ PC: %p, inst: 0x%08x BadVaddr: %#lx Status: %#lx\n",
+		exccode, opc, inst, badvaddr,
+		kvm_read_c0_guest_status(vcpu->arch.cop0));
+	kvm_arch_vcpu_dump_regs(vcpu);
+	vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+	return RESUME_HOST;
+}
+
 static int kvm_trap_emul_handle_cop_unusable(struct kvm_vcpu *vcpu)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
@@ -1251,6 +1274,7 @@ static struct kvm_mips_callbacks kvm_trap_emul_callbacks = {
 	.handle_msa_fpe = kvm_trap_emul_handle_msa_fpe,
 	.handle_fpe = kvm_trap_emul_handle_fpe,
 	.handle_msa_disabled = kvm_trap_emul_handle_msa_disabled,
+	.handle_guest_exit = kvm_trap_emul_no_handler,
 
 	.hardware_enable = kvm_trap_emul_hardware_enable,
 	.hardware_disable = kvm_trap_emul_hardware_disable,
-- 
git-series 0.8.10
