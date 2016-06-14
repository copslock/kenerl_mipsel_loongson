Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jun 2016 12:27:46 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:12291 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27027984AbcFNK1ofBn5Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jun 2016 12:27:44 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 8055182E8D32;
        Tue, 14 Jun 2016 09:40:40 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 14 Jun 2016 09:40:43 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 1/8] MIPS: KVM: Generalise fpu_inuse for other state
Date:   Tue, 14 Jun 2016 09:40:10 +0100
Message-ID: <1465893617-5774-2-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 54036
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

Rename fpu_inuse and the related definitions to aux_inuse so it can be
used for lazy context management of other auxiliary processor state too,
such as VZ guest timer, watchpoints and performance counters.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h |  8 ++++----
 arch/mips/kvm/emulate.c          |  8 ++++----
 arch/mips/kvm/mips.c             | 38 +++++++++++++++++++-------------------
 3 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index d0432b5f2343..e6273850bab6 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -323,8 +323,8 @@ struct kvm_mips_tlb {
 	long tlb_lo[2];
 };
 
-#define KVM_MIPS_FPU_FPU	0x1
-#define KVM_MIPS_FPU_MSA	0x2
+#define KVM_MIPS_AUX_FPU	0x1
+#define KVM_MIPS_AUX_MSA	0x2
 
 #define KVM_MIPS_GUEST_TLB_SIZE	64
 struct kvm_vcpu_arch {
@@ -346,8 +346,8 @@ struct kvm_vcpu_arch {
 
 	/* FPU State */
 	struct mips_fpu_struct fpu;
-	/* Which FPU state is loaded (KVM_MIPS_FPU_*) */
-	unsigned int fpu_inuse;
+	/* Which auxiliary state is loaded (KVM_MIPS_AUX_*) */
+	unsigned int aux_inuse;
 
 	/* COP0 State */
 	struct mips_coproc *cop0;
diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index 5b89c0803405..8647bd97b934 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -1154,7 +1154,7 @@ enum emulation_result kvm_mips_emulate_CP0(u32 inst, u32 *opc, u32 cause,
 				 * it first.
 				 */
 				if (change & ST0_CU1 && !(val & ST0_FR) &&
-				    vcpu->arch.fpu_inuse & KVM_MIPS_FPU_MSA)
+				    vcpu->arch.aux_inuse & KVM_MIPS_AUX_MSA)
 					kvm_lose_fpu(vcpu);
 
 				/*
@@ -1165,7 +1165,7 @@ enum emulation_result kvm_mips_emulate_CP0(u32 inst, u32 *opc, u32 cause,
 				 * the near future.
 				 */
 				if (change & ST0_CU1 &&
-				    vcpu->arch.fpu_inuse & KVM_MIPS_FPU_FPU)
+				    vcpu->arch.aux_inuse & KVM_MIPS_AUX_FPU)
 					change_c0_status(ST0_CU1, val);
 
 				preempt_enable();
@@ -1200,7 +1200,7 @@ enum emulation_result kvm_mips_emulate_CP0(u32 inst, u32 *opc, u32 cause,
 				 * context is already loaded.
 				 */
 				if (change & MIPS_CONF5_FRE &&
-				    vcpu->arch.fpu_inuse & KVM_MIPS_FPU_FPU)
+				    vcpu->arch.aux_inuse & KVM_MIPS_AUX_FPU)
 					change_c0_config5(MIPS_CONF5_FRE, val);
 
 				/*
@@ -1210,7 +1210,7 @@ enum emulation_result kvm_mips_emulate_CP0(u32 inst, u32 *opc, u32 cause,
 				 * quickly enabled again in the near future.
 				 */
 				if (change & MIPS_CONF5_MSAEN &&
-				    vcpu->arch.fpu_inuse & KVM_MIPS_FPU_MSA)
+				    vcpu->arch.aux_inuse & KVM_MIPS_AUX_MSA)
 					change_c0_config5(MIPS_CONF5_MSAEN,
 							  val);
 
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 6e753761b5d6..9093262ff3ce 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -1447,7 +1447,7 @@ void kvm_own_fpu(struct kvm_vcpu *vcpu)
 	 * not to clobber the status register directly via the commpage.
 	 */
 	if (cpu_has_msa && sr & ST0_CU1 && !(sr & ST0_FR) &&
-	    vcpu->arch.fpu_inuse & KVM_MIPS_FPU_MSA)
+	    vcpu->arch.aux_inuse & KVM_MIPS_AUX_MSA)
 		kvm_lose_fpu(vcpu);
 
 	/*
@@ -1462,9 +1462,9 @@ void kvm_own_fpu(struct kvm_vcpu *vcpu)
 	enable_fpu_hazard();
 
 	/* If guest FPU state not active, restore it now */
-	if (!(vcpu->arch.fpu_inuse & KVM_MIPS_FPU_FPU)) {
+	if (!(vcpu->arch.aux_inuse & KVM_MIPS_AUX_FPU)) {
 		__kvm_restore_fpu(&vcpu->arch);
-		vcpu->arch.fpu_inuse |= KVM_MIPS_FPU_FPU;
+		vcpu->arch.aux_inuse |= KVM_MIPS_AUX_FPU;
 	}
 
 	preempt_enable();
@@ -1491,8 +1491,8 @@ void kvm_own_msa(struct kvm_vcpu *vcpu)
 		 * interacts with MSA state, so play it safe and save it first.
 		 */
 		if (!(sr & ST0_FR) &&
-		    (vcpu->arch.fpu_inuse & (KVM_MIPS_FPU_FPU |
-				KVM_MIPS_FPU_MSA)) == KVM_MIPS_FPU_FPU)
+		    (vcpu->arch.aux_inuse & (KVM_MIPS_AUX_FPU |
+				KVM_MIPS_AUX_MSA)) == KVM_MIPS_AUX_FPU)
 			kvm_lose_fpu(vcpu);
 
 		change_c0_status(ST0_CU1 | ST0_FR, sr);
@@ -1506,20 +1506,20 @@ void kvm_own_msa(struct kvm_vcpu *vcpu)
 	set_c0_config5(MIPS_CONF5_MSAEN);
 	enable_fpu_hazard();
 
-	switch (vcpu->arch.fpu_inuse & (KVM_MIPS_FPU_FPU | KVM_MIPS_FPU_MSA)) {
-	case KVM_MIPS_FPU_FPU:
+	switch (vcpu->arch.aux_inuse & (KVM_MIPS_AUX_FPU | KVM_MIPS_AUX_MSA)) {
+	case KVM_MIPS_AUX_FPU:
 		/*
 		 * Guest FPU state already loaded, only restore upper MSA state
 		 */
 		__kvm_restore_msa_upper(&vcpu->arch);
-		vcpu->arch.fpu_inuse |= KVM_MIPS_FPU_MSA;
+		vcpu->arch.aux_inuse |= KVM_MIPS_AUX_MSA;
 		break;
 	case 0:
 		/* Neither FPU or MSA already active, restore full MSA state */
 		__kvm_restore_msa(&vcpu->arch);
-		vcpu->arch.fpu_inuse |= KVM_MIPS_FPU_MSA;
+		vcpu->arch.aux_inuse |= KVM_MIPS_AUX_MSA;
 		if (kvm_mips_guest_has_fpu(&vcpu->arch))
-			vcpu->arch.fpu_inuse |= KVM_MIPS_FPU_FPU;
+			vcpu->arch.aux_inuse |= KVM_MIPS_AUX_FPU;
 		break;
 	default:
 		break;
@@ -1533,13 +1533,13 @@ void kvm_own_msa(struct kvm_vcpu *vcpu)
 void kvm_drop_fpu(struct kvm_vcpu *vcpu)
 {
 	preempt_disable();
-	if (cpu_has_msa && vcpu->arch.fpu_inuse & KVM_MIPS_FPU_MSA) {
+	if (cpu_has_msa && vcpu->arch.aux_inuse & KVM_MIPS_AUX_MSA) {
 		disable_msa();
-		vcpu->arch.fpu_inuse &= ~KVM_MIPS_FPU_MSA;
+		vcpu->arch.aux_inuse &= ~KVM_MIPS_AUX_MSA;
 	}
-	if (vcpu->arch.fpu_inuse & KVM_MIPS_FPU_FPU) {
+	if (vcpu->arch.aux_inuse & KVM_MIPS_AUX_FPU) {
 		clear_c0_status(ST0_CU1 | ST0_FR);
-		vcpu->arch.fpu_inuse &= ~KVM_MIPS_FPU_FPU;
+		vcpu->arch.aux_inuse &= ~KVM_MIPS_AUX_FPU;
 	}
 	preempt_enable();
 }
@@ -1555,7 +1555,7 @@ void kvm_lose_fpu(struct kvm_vcpu *vcpu)
 	 */
 
 	preempt_disable();
-	if (cpu_has_msa && vcpu->arch.fpu_inuse & KVM_MIPS_FPU_MSA) {
+	if (cpu_has_msa && vcpu->arch.aux_inuse & KVM_MIPS_AUX_MSA) {
 		set_c0_config5(MIPS_CONF5_MSAEN);
 		enable_fpu_hazard();
 
@@ -1563,17 +1563,17 @@ void kvm_lose_fpu(struct kvm_vcpu *vcpu)
 
 		/* Disable MSA & FPU */
 		disable_msa();
-		if (vcpu->arch.fpu_inuse & KVM_MIPS_FPU_FPU) {
+		if (vcpu->arch.aux_inuse & KVM_MIPS_AUX_FPU) {
 			clear_c0_status(ST0_CU1 | ST0_FR);
 			disable_fpu_hazard();
 		}
-		vcpu->arch.fpu_inuse &= ~(KVM_MIPS_FPU_FPU | KVM_MIPS_FPU_MSA);
-	} else if (vcpu->arch.fpu_inuse & KVM_MIPS_FPU_FPU) {
+		vcpu->arch.aux_inuse &= ~(KVM_MIPS_AUX_FPU | KVM_MIPS_AUX_MSA);
+	} else if (vcpu->arch.aux_inuse & KVM_MIPS_AUX_FPU) {
 		set_c0_status(ST0_CU1);
 		enable_fpu_hazard();
 
 		__kvm_save_fpu(&vcpu->arch);
-		vcpu->arch.fpu_inuse &= ~KVM_MIPS_FPU_FPU;
+		vcpu->arch.aux_inuse &= ~KVM_MIPS_AUX_FPU;
 
 		/* Disable FPU */
 		clear_c0_status(ST0_CU1 | ST0_FR);
-- 
2.4.10
