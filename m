Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jan 2017 21:55:08 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:59833 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993870AbdAIUxaOHP-P (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Jan 2017 21:53:30 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id DD5AFF7C478FD;
        Mon,  9 Jan 2017 20:53:19 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 9 Jan 2017 20:53:23 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 4/10] KVM: MIPS/T&E: Handle TLB invalidation requests
Date:   Mon, 9 Jan 2017 20:51:56 +0000
Message-ID: <96b8132c7751feaf197bf2c0cd92327070dc2062.1483993967.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
In-Reply-To: <cover.4133d2f24fd73c1889a46ea05bb8924867b33747.1483993967.git-series.james.hogan@imgtec.com>
References: <cover.4133d2f24fd73c1889a46ea05bb8924867b33747.1483993967.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56239
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

Add handling of TLB invalidation requests before entering guest mode.
This will allow asynchonous invalidation of the VCPU mappings when
physical memory regions are altered. Should the CPU running the VCPU
already be in guest mode an IPI will be sent to trigger a guest exit.

The reload_asid path will be used in a future patch for when GVA is
about to be directly accessed by KVM.

In the process, the stale user ASID check in the re-entry path (for lazy
user GVA flushing) is generalised to check the ASID for the current
guest mode, in case a TLB invalidation request was handled. This has the
side effect of making the ASID checks on vcpu_load too conservative,
which will be addressed in a later patch.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/trap_emul.c | 71 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 63 insertions(+), 8 deletions(-)

diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index a92772098294..c6a16267f084 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -775,31 +775,86 @@ static int kvm_trap_emul_vcpu_put(struct kvm_vcpu *vcpu, int cpu)
 	return 0;
 }
 
+static void kvm_trap_emul_check_requests(struct kvm_vcpu *vcpu, int cpu,
+					 bool reload_asid)
+{
+	struct mm_struct *kern_mm = &vcpu->arch.guest_kernel_mm;
+	struct mm_struct *user_mm = &vcpu->arch.guest_user_mm;
+	struct mm_struct *mm;
+	int i;
+
+	if (likely(!vcpu->requests))
+		return;
+
+	if (kvm_check_request(KVM_REQ_TLB_FLUSH, vcpu)) {
+		/*
+		 * Both kernel & user GVA mappings must be invalidated. The
+		 * caller is just about to check whether the ASID is stale
+		 * anyway so no need to reload it here.
+		 */
+		kvm_mips_flush_gva_pt(kern_mm->pgd, KMF_GPA | KMF_KERN);
+		kvm_mips_flush_gva_pt(user_mm->pgd, KMF_GPA | KMF_USER);
+		for_each_possible_cpu(i) {
+			cpu_context(i, kern_mm) = 0;
+			cpu_context(i, user_mm) = 0;
+		}
+
+		/* Generate new ASID for current mode */
+		if (reload_asid) {
+			mm = KVM_GUEST_KERNEL_MODE(vcpu) ? kern_mm : user_mm;
+			get_new_mmu_context(mm, cpu);
+			htw_stop();
+			write_c0_entryhi(cpu_asid(cpu, mm));
+			TLBMISS_HANDLER_SETUP_PGD(mm->pgd);
+			htw_start();
+		}
+	}
+}
+
 static void kvm_trap_emul_vcpu_reenter(struct kvm_run *run,
 				       struct kvm_vcpu *vcpu)
 {
+	struct mm_struct *kern_mm = &vcpu->arch.guest_kernel_mm;
 	struct mm_struct *user_mm = &vcpu->arch.guest_user_mm;
+	struct mm_struct *mm;
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	int i, cpu = smp_processor_id();
 	unsigned int gasid;
 
 	/*
-	 * Lazy host ASID regeneration / PT flush for guest user mode.
-	 * If the guest ASID has changed since the last guest usermode
-	 * execution, regenerate the host ASID so as to invalidate stale TLB
-	 * entries and flush GVA PT entries too.
+	 * No need to reload ASID, IRQs are disabled already so there's no rush,
+	 * and we'll check if we need to regenerate below anyway before
+	 * re-entering the guest.
 	 */
-	if (!KVM_GUEST_KERNEL_MODE(vcpu)) {
+	kvm_trap_emul_check_requests(vcpu, cpu, false);
+
+	if (KVM_GUEST_KERNEL_MODE(vcpu)) {
+		mm = kern_mm;
+	} else {
+		mm = user_mm;
+
+		/*
+		 * Lazy host ASID regeneration / PT flush for guest user mode.
+		 * If the guest ASID has changed since the last guest usermode
+		 * execution, invalidate the stale TLB entries and flush GVA PT
+		 * entries too.
+		 */
 		gasid = kvm_read_c0_guest_entryhi(cop0) & KVM_ENTRYHI_ASID;
 		if (gasid != vcpu->arch.last_user_gasid) {
 			kvm_mips_flush_gva_pt(user_mm->pgd, KMF_USER);
-			get_new_mmu_context(user_mm, cpu);
 			for_each_possible_cpu(i)
-				if (i != cpu)
-					cpu_context(i, user_mm) = 0;
+				cpu_context(i, user_mm) = 0;
 			vcpu->arch.last_user_gasid = gasid;
 		}
 	}
+
+	/*
+	 * Check if ASID is stale. This may happen due to a TLB flush request or
+	 * a lazy user MM invalidation.
+	 */
+	if ((cpu_context(cpu, mm) ^ asid_cache(cpu)) &
+	    asid_version_mask(cpu))
+		get_new_mmu_context(mm, cpu);
 }
 
 static int kvm_trap_emul_vcpu_run(struct kvm_run *run, struct kvm_vcpu *vcpu)
-- 
git-series 0.8.10
