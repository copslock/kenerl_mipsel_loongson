Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Mar 2015 15:53:48 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:39206 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013433AbbCKOsVF4qmH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Mar 2015 15:48:21 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id B00AEF4C04207;
        Wed, 11 Mar 2015 14:48:12 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 11 Mar 2015 14:48:15 +0000
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
Subject: [PATCH 17/20] MIPS: KVM: Emulate MSA bits in COP0 interface
Date:   Wed, 11 Mar 2015 14:44:53 +0000
Message-ID: <1426085096-12932-18-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 46334
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

Emulate MSA related parts of COP0 interface so that the guest will be
able to enable/disable MSA (Config5.MSAEn) once the MSA capability has
been wired up.

As with the FPU (Status.CU1) setting Config5.MSAEn has no immediate
effect if the MSA state isn't live, as MSA state is restored lazily on
first use. Changes after the MSA state has been restored take immediate
effect, so that the guest can start getting MSA disabled exceptions
right away for guest MSA operations. The MSA state is saved lazily too,
as MSA may get re-enabled in the near future anyway.

A special case is also added for when Status.CU1 is set while FR=0 and
the MSA state is live. In this case we are at risk of getting reserved
instruction exceptions if we try and save the MSA state, so we lose the
MSA state sooner while MSA is still usable.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/emulate.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index fbf169fb63df..07f554c72cb8 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -912,7 +912,13 @@ unsigned int kvm_mips_config1_wrmask(struct kvm_vcpu *vcpu)
 unsigned int kvm_mips_config3_wrmask(struct kvm_vcpu *vcpu)
 {
 	/* Config4 is optional */
-	return MIPS_CONF_M;
+	unsigned int mask = MIPS_CONF_M;
+
+	/* Permit MSA to be present if MSA is supported */
+	if (kvm_mips_guest_can_have_msa(&vcpu->arch))
+		mask |= MIPS_CONF3_MSA;
+
+	return mask;
 }
 
 /**
@@ -939,6 +945,10 @@ unsigned int kvm_mips_config5_wrmask(struct kvm_vcpu *vcpu)
 {
 	unsigned int mask = 0;
 
+	/* Permit MSAEn changes if MSA supported and enabled */
+	if (kvm_mips_guest_has_msa(&vcpu->arch))
+		mask |= MIPS_CONF5_MSAEN;
+
 	/*
 	 * Permit guest FPU mode changes if FPU is enabled and the relevant
 	 * feature exists according to FIR register.
@@ -1126,6 +1136,18 @@ enum emulation_result kvm_mips_emulate_CP0(uint32_t inst, uint32_t *opc,
 					kvm_drop_fpu(vcpu);
 
 				/*
+				 * If MSA state is already live, it is undefined
+				 * how it interacts with FR=0 FPU state, and we
+				 * don't want to hit reserved instruction
+				 * exceptions trying to save the MSA state later
+				 * when CU=1 && FR=1, so play it safe and save
+				 * it first.
+				 */
+				if (change & ST0_CU1 && !(val & ST0_FR) &&
+				    vcpu->arch.fpu_inuse & KVM_MIPS_FPU_MSA)
+					kvm_lose_fpu(vcpu);
+
+				/*
 				 * Propagate CU1 (FPU enable) changes
 				 * immediately if the FPU context is already
 				 * loaded. When disabling we leave the context
@@ -1160,7 +1182,7 @@ enum emulation_result kvm_mips_emulate_CP0(uint32_t inst, uint32_t *opc,
 				val = old_val ^ change;
 
 
-				/* Handle changes in FPU modes */
+				/* Handle changes in FPU/MSA modes */
 				preempt_disable();
 
 				/*
@@ -1171,6 +1193,17 @@ enum emulation_result kvm_mips_emulate_CP0(uint32_t inst, uint32_t *opc,
 				    vcpu->arch.fpu_inuse & KVM_MIPS_FPU_FPU)
 					change_c0_config5(MIPS_CONF5_FRE, val);
 
+				/*
+				 * Propagate MSAEn changes immediately if the
+				 * MSA context is already loaded. When disabling
+				 * we leave the context loaded so it can be
+				 * quickly enabled again in the near future.
+				 */
+				if (change & MIPS_CONF5_MSAEN &&
+				    vcpu->arch.fpu_inuse & KVM_MIPS_FPU_MSA)
+					change_c0_config5(MIPS_CONF5_MSAEN,
+							  val);
+
 				preempt_enable();
 
 				kvm_write_c0_guest_config5(cop0, val);
-- 
2.0.5
