Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2017 11:20:00 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:32640 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994794AbdCNKSLgIsWU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Mar 2017 11:18:11 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 98A3A1C4AC7D5;
        Tue, 14 Mar 2017 10:18:07 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 14 Mar 2017 10:18:10 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v2 10/33] KVM: MIPS: Update kvm_lose_fpu() for VZ
Date:   Tue, 14 Mar 2017 10:15:17 +0000
Message-ID: <7e134450e015643a1b07bb65657fc4acaabcc22b.1489485940.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.1
MIME-Version: 1.0
In-Reply-To: <cover.26e10ec77a4ed0d3177ccf4fabf57bc95ea030f8.1489485940.git-series.james.hogan@imgtec.com>
References: <cover.26e10ec77a4ed0d3177ccf4fabf57bc95ea030f8.1489485940.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57204
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

Update the implementation of kvm_lose_fpu() for VZ, where there is no
need to enable the FPU/MSA in the root context if the FPU/MSA state is
loaded but disabled in the guest context.

The trap & emulate implementation needs to disable FPU/MSA in the root
context when the guest disables them in order to catch the COP1 unusable
or MSA disabled exception when they're used and pass it on to the guest.

For VZ however as long as the context is loaded and enabled in the root
context, the guest can enable and disable it in the guest context
without the hypervisor having to do much, and will take guest exceptions
without hypervisor intervention if used without being enabled in the
guest context.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/mips.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 15a1b1716c2e..a743f67378ba 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -1527,16 +1527,18 @@ void kvm_drop_fpu(struct kvm_vcpu *vcpu)
 void kvm_lose_fpu(struct kvm_vcpu *vcpu)
 {
 	/*
-	 * FPU & MSA get disabled in root context (hardware) when it is disabled
-	 * in guest context (software), but the register state in the hardware
-	 * may still be in use. This is why we explicitly re-enable the hardware
-	 * before saving.
+	 * With T&E, FPU & MSA get disabled in root context (hardware) when it
+	 * is disabled in guest context (software), but the register state in
+	 * the hardware may still be in use.
+	 * This is why we explicitly re-enable the hardware before saving.
 	 */
 
 	preempt_disable();
 	if (cpu_has_msa && vcpu->arch.aux_inuse & KVM_MIPS_AUX_MSA) {
-		set_c0_config5(MIPS_CONF5_MSAEN);
-		enable_fpu_hazard();
+		if (!IS_ENABLED(CONFIG_KVM_MIPS_VZ)) {
+			set_c0_config5(MIPS_CONF5_MSAEN);
+			enable_fpu_hazard();
+		}
 
 		__kvm_save_msa(&vcpu->arch);
 		trace_kvm_aux(vcpu, KVM_TRACE_AUX_SAVE, KVM_TRACE_AUX_FPU_MSA);
@@ -1549,8 +1551,10 @@ void kvm_lose_fpu(struct kvm_vcpu *vcpu)
 		}
 		vcpu->arch.aux_inuse &= ~(KVM_MIPS_AUX_FPU | KVM_MIPS_AUX_MSA);
 	} else if (vcpu->arch.aux_inuse & KVM_MIPS_AUX_FPU) {
-		set_c0_status(ST0_CU1);
-		enable_fpu_hazard();
+		if (!IS_ENABLED(CONFIG_KVM_MIPS_VZ)) {
+			set_c0_status(ST0_CU1);
+			enable_fpu_hazard();
+		}
 
 		__kvm_save_fpu(&vcpu->arch);
 		vcpu->arch.aux_inuse &= ~KVM_MIPS_AUX_FPU;
-- 
git-series 0.8.10
