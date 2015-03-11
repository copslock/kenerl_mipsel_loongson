Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Mar 2015 15:52:01 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:14402 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013413AbbCKOsR4YAj2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Mar 2015 15:48:17 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 0307F17B6548E;
        Wed, 11 Mar 2015 14:48:10 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 11 Mar 2015 14:48:11 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 11 Mar 2015 14:48:11 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
        <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Gleb Natapov <gleb@kernel.org>
Subject: [PATCH 12/20] MIPS: KVM: Emulate FPU bits in COP0 interface
Date:   Wed, 11 Mar 2015 14:44:48 +0000
Message-ID: <1426085096-12932-13-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 46328
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

Emulate FPU related parts of COP0 interface so that the guest will be
able to enable/disable the following once the FPU capability has been
wired up:
- The FPU (Status.CU1)
- 64-bit FP register mode (Status.FR)
- Hybrid FP register mode (Config5.FRE)

Changing Status.CU1 has no immediate effect if the FPU state isn't live,
as the FPU state is restored lazily on first use. After that, changes
take place immediately in the host Status.CU1, so that the guest can
start getting coprocessor unusable exceptions right away for guest FPU
operations if it is disabled. The FPU state is saved lazily too, as the
FPU may get re-enabled in the near future anyway.

Any change to Status.FR causes the FPU state to be discarded and FPU
disabled, as the register state is architecturally UNPREDICTABLE after
such a change. This should also ensure that the FPU state is fully
initialised (with stale state, but that's fine) when it is next used in
the new FP mode.

Any change to the Config5.FRE bit is immediately updated in the host
state so that the guest can get the relevant exceptions right away for
single-precision FPU operations.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/emulate.c | 111 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 100 insertions(+), 11 deletions(-)

diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index 91d5b0e370b4..3511bb20fe0e 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -893,8 +893,13 @@ enum emulation_result kvm_mips_emul_tlbp(struct kvm_vcpu *vcpu)
  */
 unsigned int kvm_mips_config1_wrmask(struct kvm_vcpu *vcpu)
 {
-	/* Read-only */
-	return 0;
+	unsigned int mask = 0;
+
+	/* Permit FPU to be present if FPU is supported */
+	if (kvm_mips_guest_can_have_fpu(&vcpu->arch))
+		mask |= MIPS_CONF1_FP;
+
+	return mask;
 }
 
 /**
@@ -932,8 +937,19 @@ unsigned int kvm_mips_config4_wrmask(struct kvm_vcpu *vcpu)
  */
 unsigned int kvm_mips_config5_wrmask(struct kvm_vcpu *vcpu)
 {
-	/* Read-only */
-	return 0;
+	unsigned int mask = 0;
+
+	/*
+	 * Permit guest FPU mode changes if FPU is enabled and the relevant
+	 * feature exists according to FIR register.
+	 */
+	if (kvm_mips_guest_has_fpu(&vcpu->arch)) {
+		if (cpu_has_fre)
+			mask |= MIPS_CONF5_FRE;
+		/* We don't support UFR or UFE */
+	}
+
+	return mask;
 }
 
 enum emulation_result kvm_mips_emulate_CP0(uint32_t inst, uint32_t *opc,
@@ -1073,18 +1089,91 @@ enum emulation_result kvm_mips_emulate_CP0(uint32_t inst, uint32_t *opc,
 				kvm_mips_write_compare(vcpu,
 						       vcpu->arch.gprs[rt]);
 			} else if ((rd == MIPS_CP0_STATUS) && (sel == 0)) {
-				kvm_write_c0_guest_status(cop0,
-							  vcpu->arch.gprs[rt]);
+				unsigned int old_val, val, change;
+
+				old_val = kvm_read_c0_guest_status(cop0);
+				val = vcpu->arch.gprs[rt];
+				change = val ^ old_val;
+
+				/* Make sure that the NMI bit is never set */
+				val &= ~ST0_NMI;
+
 				/*
-				 * Make sure that CU1 and NMI bits are
-				 * never set
+				 * Don't allow CU1 or FR to be set unless FPU
+				 * capability enabled and exists in guest
+				 * configuration.
 				 */
-				kvm_clear_c0_guest_status(cop0,
-							  (ST0_CU1 | ST0_NMI));
+				if (!kvm_mips_guest_has_fpu(&vcpu->arch))
+					val &= ~(ST0_CU1 | ST0_FR);
+
+				/*
+				 * Also don't allow FR to be set if host doesn't
+				 * support it.
+				 */
+				if (!(current_cpu_data.fpu_id & MIPS_FPIR_F64))
+					val &= ~ST0_FR;
+
+
+				/* Handle changes in FPU mode */
+				preempt_disable();
+
+				/*
+				 * FPU and Vector register state is made
+				 * UNPREDICTABLE by a change of FR, so don't
+				 * even bother saving it.
+				 */
+				if (change & ST0_FR)
+					kvm_drop_fpu(vcpu);
+
+				/*
+				 * Propagate CU1 (FPU enable) changes
+				 * immediately if the FPU context is already
+				 * loaded. When disabling we leave the context
+				 * loaded so it can be quickly enabled again in
+				 * the near future.
+				 */
+				if (change & ST0_CU1 &&
+				    vcpu->arch.fpu_inuse & KVM_MIPS_FPU_FPU)
+					change_c0_status(ST0_CU1, val);
+
+				preempt_enable();
+
+				kvm_write_c0_guest_status(cop0, val);
 
 #ifdef CONFIG_KVM_MIPS_DYN_TRANS
-				kvm_mips_trans_mtc0(inst, opc, vcpu);
+				/*
+				 * If FPU present, we need CU1/FR bits to take
+				 * effect fairly soon.
+				 */
+				if (!kvm_mips_guest_has_fpu(&vcpu->arch))
+					kvm_mips_trans_mtc0(inst, opc, vcpu);
 #endif
+			} else if ((rd == MIPS_CP0_CONFIG) && (sel == 5)) {
+				unsigned int old_val, val, change, wrmask;
+
+				old_val = kvm_read_c0_guest_config5(cop0);
+				val = vcpu->arch.gprs[rt];
+
+				/* Only a few bits are writable in Config5 */
+				wrmask = kvm_mips_config5_wrmask(vcpu);
+				change = (val ^ old_val) & wrmask;
+				val = old_val ^ change;
+
+
+				/* Handle changes in FPU modes */
+				preempt_disable();
+
+				/*
+				 * Propagate FRE changes immediately if the FPU
+				 * context is already loaded.
+				 */
+				if (change & MIPS_CONF5_FRE &&
+				    vcpu->arch.fpu_inuse & KVM_MIPS_FPU_FPU)
+					change_c0_config5(MIPS_CONF5_FRE, val);
+
+				preempt_enable();
+
+				kvm_write_c0_guest_config5(cop0, val);
 			} else if ((rd == MIPS_CP0_CAUSE) && (sel == 0)) {
 				uint32_t old_cause, new_cause;
 
-- 
2.0.5
