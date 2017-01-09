Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jan 2017 21:55:33 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:44502 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993873AbdAIUxcx-SEP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Jan 2017 21:53:32 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id CE7CD1FA3D268;
        Mon,  9 Jan 2017 20:53:20 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 9 Jan 2017 20:53:24 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 5/10] KVM: MIPS/T&E: Reduce stale ASID checks
Date:   Mon, 9 Jan 2017 20:51:57 +0000
Message-ID: <f8edc1cf1113316aaa81de155435bfc03b1b8158.1483993967.git-series.james.hogan@imgtec.com>
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
X-archive-position: 56240
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

The stale ASID checks taking place on VCPU load can be reduced:

- Now that we check for a stale ASID on guest re-entry, there is no need
  to do so when loading the VCPU outside of guest context, since it will
  happen before entering the guest. Note that a lot of KVM VCPU ioctls
  will cause the VCPU to be loaded but guest context won't be entered.

- There is no need to check for a stale kernel_mm ASID when the guest is
  in user mode and vice versa. In fact doing so can potentially be
  problematic since the user_mm ASID regeneration may trigger a new ASID
  cycle, which would cause the kern_mm ASID to become stale after it has
  been checked for staleness.

Therefore only check the ASID for the mm corresponding to the current
guest mode, and only if we're already in guest context. We drop some of
the related kvm_debug() calls here too.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/trap_emul.c | 35 ++++++-----------------------------
 1 file changed, 6 insertions(+), 29 deletions(-)

diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index c6a16267f084..0cb76e1aac0e 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -714,35 +714,15 @@ static int kvm_trap_emul_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	struct mm_struct *user_mm = &vcpu->arch.guest_user_mm;
 	struct mm_struct *mm;
 
-	/* Allocate new kernel and user ASIDs if needed */
-
-	if ((cpu_context(cpu, kern_mm) ^ asid_cache(cpu)) &
-						asid_version_mask(cpu)) {
-		get_new_mmu_context(kern_mm, cpu);
-
-		kvm_debug("[%d]: cpu_context: %#lx\n", cpu,
-			  cpu_context(cpu, current->mm));
-		kvm_debug("[%d]: Allocated new ASID for Guest Kernel: %#lx\n",
-			  cpu, cpu_context(cpu, kern_mm));
-	}
-
-	if ((cpu_context(cpu, user_mm) ^ asid_cache(cpu)) &
-						asid_version_mask(cpu)) {
-		get_new_mmu_context(user_mm, cpu);
-
-		kvm_debug("[%d]: cpu_context: %#lx\n", cpu,
-			  cpu_context(cpu, current->mm));
-		kvm_debug("[%d]: Allocated new ASID for Guest User: %#lx\n",
-			  cpu, cpu_context(cpu, user_mm));
-	}
-
 	/*
-	 * Were we in guest context? If so then the pre-empted ASID is
-	 * no longer valid, we need to set it to what it should be based
-	 * on the mode of the Guest (Kernel/User)
+	 * Were we in guest context? If so, restore the appropriate ASID based
+	 * on the mode of the Guest (Kernel/User).
 	 */
 	if (current->flags & PF_VCPU) {
 		mm = KVM_GUEST_KERNEL_MODE(vcpu) ? kern_mm : user_mm;
+		if ((cpu_context(cpu, mm) ^ asid_cache(cpu)) &
+		    asid_version_mask(cpu))
+			get_new_mmu_context(mm, cpu);
 		write_c0_entryhi(cpu_asid(cpu, mm));
 		TLBMISS_HANDLER_SETUP_PGD(mm->pgd);
 		cpumask_clear_cpu(cpu, mm_cpumask(current->active_mm));
@@ -760,11 +740,8 @@ static int kvm_trap_emul_vcpu_put(struct kvm_vcpu *vcpu, int cpu)
 	if (current->flags & PF_VCPU) {
 		/* Restore normal Linux process memory map */
 		if (((cpu_context(cpu, current->mm) ^ asid_cache(cpu)) &
-		     asid_version_mask(cpu))) {
-			kvm_debug("%s: Dropping MMU Context:  %#lx\n", __func__,
-				  cpu_context(cpu, current->mm));
+		     asid_version_mask(cpu)))
 			get_new_mmu_context(current->mm, cpu);
-		}
 		write_c0_entryhi(cpu_asid(cpu, current->mm));
 		TLBMISS_HANDLER_SETUP_PGD(current->mm->pgd);
 		cpumask_set_cpu(cpu, mm_cpumask(current->mm));
-- 
git-series 0.8.10
