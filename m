Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jun 2016 12:28:55 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:58147 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27040986AbcFNK2Q2lcyY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jun 2016 12:28:16 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 33AC09FB8B3FE;
        Tue, 14 Jun 2016 09:40:41 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 14 Jun 2016 09:40:43 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     James Hogan <james.hogan@imgtec.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, <linux-mips@linux-mips.org>,
        <kvm@vger.kernel.org>
Subject: [PATCH 2/8] MIPS: KVM: Add kvm_aux trace event
Date:   Tue, 14 Jun 2016 09:40:11 +0100
Message-ID: <1465893617-5774-3-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1465893617-5774-1-git-send-email-james.hogan@imgtec.com>
References: <1465893617-5774-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54040
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

Add a MIPS specific trace event for auxiliary context operations
(notably FPU and MSA). Unfortunately the generic kvm_fpu trace event
isn't flexible enough to handle the range of interesting things that can
happen with FPU and MSA context.

The type of state being operated on is traced:
- FPU: Just the FPU registers.
- MSA: Just the upper half of the MSA vector registers (low half already
       loaded with FPU state).
- FPU & MSA: Full MSA vector state (includes FPU state).

As is the type of operation:
- Restore: State was enabled and restored.
- Save: State was saved and disabled.
- Enable: State was enabled (already loaded).
- Disable: State was disabled (kept loaded).
- Discard: State was discarded and disabled.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/mips.c  | 11 +++++++++++
 arch/mips/kvm/trace.h | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 9093262ff3ce..c0e8f8640f2b 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -1465,6 +1465,9 @@ void kvm_own_fpu(struct kvm_vcpu *vcpu)
 	if (!(vcpu->arch.aux_inuse & KVM_MIPS_AUX_FPU)) {
 		__kvm_restore_fpu(&vcpu->arch);
 		vcpu->arch.aux_inuse |= KVM_MIPS_AUX_FPU;
+		trace_kvm_aux(vcpu, KVM_TRACE_AUX_RESTORE, KVM_TRACE_AUX_FPU);
+	} else {
+		trace_kvm_aux(vcpu, KVM_TRACE_AUX_ENABLE, KVM_TRACE_AUX_FPU);
 	}
 
 	preempt_enable();
@@ -1513,6 +1516,7 @@ void kvm_own_msa(struct kvm_vcpu *vcpu)
 		 */
 		__kvm_restore_msa_upper(&vcpu->arch);
 		vcpu->arch.aux_inuse |= KVM_MIPS_AUX_MSA;
+		trace_kvm_aux(vcpu, KVM_TRACE_AUX_RESTORE, KVM_TRACE_AUX_MSA);
 		break;
 	case 0:
 		/* Neither FPU or MSA already active, restore full MSA state */
@@ -1520,8 +1524,11 @@ void kvm_own_msa(struct kvm_vcpu *vcpu)
 		vcpu->arch.aux_inuse |= KVM_MIPS_AUX_MSA;
 		if (kvm_mips_guest_has_fpu(&vcpu->arch))
 			vcpu->arch.aux_inuse |= KVM_MIPS_AUX_FPU;
+		trace_kvm_aux(vcpu, KVM_TRACE_AUX_RESTORE,
+			      KVM_TRACE_AUX_FPU_MSA);
 		break;
 	default:
+		trace_kvm_aux(vcpu, KVM_TRACE_AUX_ENABLE, KVM_TRACE_AUX_MSA);
 		break;
 	}
 
@@ -1535,10 +1542,12 @@ void kvm_drop_fpu(struct kvm_vcpu *vcpu)
 	preempt_disable();
 	if (cpu_has_msa && vcpu->arch.aux_inuse & KVM_MIPS_AUX_MSA) {
 		disable_msa();
+		trace_kvm_aux(vcpu, KVM_TRACE_AUX_DISCARD, KVM_TRACE_AUX_MSA);
 		vcpu->arch.aux_inuse &= ~KVM_MIPS_AUX_MSA;
 	}
 	if (vcpu->arch.aux_inuse & KVM_MIPS_AUX_FPU) {
 		clear_c0_status(ST0_CU1 | ST0_FR);
+		trace_kvm_aux(vcpu, KVM_TRACE_AUX_DISCARD, KVM_TRACE_AUX_FPU);
 		vcpu->arch.aux_inuse &= ~KVM_MIPS_AUX_FPU;
 	}
 	preempt_enable();
@@ -1560,6 +1569,7 @@ void kvm_lose_fpu(struct kvm_vcpu *vcpu)
 		enable_fpu_hazard();
 
 		__kvm_save_msa(&vcpu->arch);
+		trace_kvm_aux(vcpu, KVM_TRACE_AUX_SAVE, KVM_TRACE_AUX_FPU_MSA);
 
 		/* Disable MSA & FPU */
 		disable_msa();
@@ -1574,6 +1584,7 @@ void kvm_lose_fpu(struct kvm_vcpu *vcpu)
 
 		__kvm_save_fpu(&vcpu->arch);
 		vcpu->arch.aux_inuse &= ~KVM_MIPS_AUX_FPU;
+		trace_kvm_aux(vcpu, KVM_TRACE_AUX_SAVE, KVM_TRACE_AUX_FPU);
 
 		/* Disable FPU */
 		clear_c0_status(ST0_CU1 | ST0_FR);
diff --git a/arch/mips/kvm/trace.h b/arch/mips/kvm/trace.h
index bd6437f67dc0..32ac7cc82e13 100644
--- a/arch/mips/kvm/trace.h
+++ b/arch/mips/kvm/trace.h
@@ -38,6 +38,52 @@ TRACE_EVENT(kvm_exit,
 		      __entry->pc)
 );
 
+#define KVM_TRACE_AUX_RESTORE		0
+#define KVM_TRACE_AUX_SAVE		1
+#define KVM_TRACE_AUX_ENABLE		2
+#define KVM_TRACE_AUX_DISABLE		3
+#define KVM_TRACE_AUX_DISCARD		4
+
+#define KVM_TRACE_AUX_FPU		1
+#define KVM_TRACE_AUX_MSA		2
+#define KVM_TRACE_AUX_FPU_MSA		3
+
+#define kvm_trace_symbol_fpu_msa_op		\
+	{ KVM_TRACE_AUX_RESTORE, "restore" },	\
+	{ KVM_TRACE_AUX_SAVE,    "save" },	\
+	{ KVM_TRACE_AUX_ENABLE,  "enable" },	\
+	{ KVM_TRACE_AUX_DISABLE, "disable" },	\
+	{ KVM_TRACE_AUX_DISCARD, "discard" }
+
+#define kvm_trace_symbol_fpu_msa_state		\
+	{ KVM_TRACE_AUX_FPU,     "FPU" },	\
+	{ KVM_TRACE_AUX_MSA,     "MSA" },	\
+	{ KVM_TRACE_AUX_FPU_MSA, "FPU & MSA" }
+
+TRACE_EVENT(kvm_aux,
+	    TP_PROTO(struct kvm_vcpu *vcpu, unsigned int op,
+		     unsigned int state),
+	    TP_ARGS(vcpu, op, state),
+	    TP_STRUCT__entry(
+			__field(unsigned long, pc)
+			__field(u8, op)
+			__field(u8, state)
+	    ),
+
+	    TP_fast_assign(
+			__entry->pc = vcpu->arch.pc;
+			__entry->op = op;
+			__entry->state = state;
+	    ),
+
+	    TP_printk("%s %s PC: 0x%08lx",
+		      __print_symbolic(__entry->op,
+				       kvm_trace_symbol_fpu_msa_op),
+		      __print_symbolic(__entry->state,
+				       kvm_trace_symbol_fpu_msa_state),
+		      __entry->pc)
+);
+
 #endif /* _TRACE_KVM_H */
 
 /* This part must be outside protection */
-- 
2.4.10
