Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jan 2017 02:37:07 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:24520 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992886AbdAFBdkseY8u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Jan 2017 02:33:40 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 7B093A49A5EB9;
        Fri,  6 Jan 2017 01:33:32 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 6 Jan 2017 01:33:33 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 6/30] KVM: MIPS/MMU: Simplify ASID restoration
Date:   Fri, 6 Jan 2017 01:32:38 +0000
Message-ID: <d86e83f27a5964e281b72d9d53b6abf571234a6c.1483665879.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
In-Reply-To: <cover.d6d201de414322ed2c1372e164254e6055ef7db9.1483665879.git-series.james.hogan@imgtec.com>
References: <cover.d6d201de414322ed2c1372e164254e6055ef7db9.1483665879.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56182
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

KVM T&E uses an ASID for guest kernel mode and an ASID for guest user
mode. The current ASID is saved when the guest is scheduled out, and
restored when scheduling back in, with checks for whether the ASID needs
to be regenerated.

This isn't really necessary as the ASID can be easily determined by the
current guest mode, so lets simplify it to just read the required ASID
from guest_kernel_asid or guest_user_asid even if the ASID hasn't been
regenerated.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h |  3 +--
 arch/mips/kvm/mmu.c              | 46 ++++++++-------------------------
 2 files changed, 12 insertions(+), 37 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index bebec370324f..7cc53e44b42e 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -318,9 +318,6 @@ struct kvm_vcpu_arch {
 	/* Bitmask of pending exceptions to be cleared */
 	unsigned long pending_exceptions_clr;
 
-	/* Save/Restore the entryhi register when are are preempted/scheduled back in */
-	unsigned long preempt_entryhi;
-
 	/* S/W Based TLB for guest */
 	struct kvm_mips_tlb guest_tlb[KVM_MIPS_GUEST_TLB_SIZE];
 
diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index 3b677c851be0..e1698a66253b 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -237,7 +237,6 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
 	unsigned long asid_mask = cpu_asid_mask(&cpu_data[cpu]);
 	unsigned long flags;
-	int newasid = 0;
 
 	kvm_debug("%s: vcpu %p, cpu: %d\n", __func__, vcpu, cpu);
 
@@ -250,7 +249,6 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 		kvm_get_new_mmu_context(&vcpu->arch.guest_kernel_mm, cpu, vcpu);
 		vcpu->arch.guest_kernel_asid[cpu] =
 		    vcpu->arch.guest_kernel_mm.context.asid[cpu];
-		newasid++;
 
 		kvm_debug("[%d]: cpu_context: %#lx\n", cpu,
 			  cpu_context(cpu, current->mm));
@@ -263,7 +261,6 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 		kvm_get_new_mmu_context(&vcpu->arch.guest_user_mm, cpu, vcpu);
 		vcpu->arch.guest_user_asid[cpu] =
 		    vcpu->arch.guest_user_mm.context.asid[cpu];
-		newasid++;
 
 		kvm_debug("[%d]: cpu_context: %#lx\n", cpu,
 			  cpu_context(cpu, current->mm));
@@ -282,35 +279,18 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 		kvm_mips_migrate_count(vcpu);
 	}
 
-	if (!newasid) {
-		/*
-		 * If we preempted while the guest was executing, then reload
-		 * the pre-empted ASID
-		 */
-		if (current->flags & PF_VCPU) {
-			write_c0_entryhi(vcpu->arch.
-					 preempt_entryhi & asid_mask);
-			ehb();
-		}
-	} else {
-		/* New ASIDs were allocated for the VM */
-
-		/*
-		 * Were we in guest context? If so then the pre-empted ASID is
-		 * no longer valid, we need to set it to what it should be based
-		 * on the mode of the Guest (Kernel/User)
-		 */
-		if (current->flags & PF_VCPU) {
-			if (KVM_GUEST_KERNEL_MODE(vcpu))
-				write_c0_entryhi(vcpu->arch.
-						 guest_kernel_asid[cpu] &
-						 asid_mask);
-			else
-				write_c0_entryhi(vcpu->arch.
-						 guest_user_asid[cpu] &
-						 asid_mask);
-			ehb();
-		}
+	/*
+	 * If we preempted while the guest was executing, then reload the ASID
+	 * based on the mode of the Guest (Kernel/User)
+	 */
+	if (current->flags & PF_VCPU) {
+		if (KVM_GUEST_KERNEL_MODE(vcpu))
+			write_c0_entryhi(vcpu->arch.guest_kernel_asid[cpu] &
+					 asid_mask);
+		else
+			write_c0_entryhi(vcpu->arch.guest_user_asid[cpu] &
+					 asid_mask);
+		ehb();
 	}
 
 	/* restore guest state to registers */
@@ -329,8 +309,6 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 	local_irq_save(flags);
 
 	cpu = smp_processor_id();
-
-	vcpu->arch.preempt_entryhi = read_c0_entryhi();
 	vcpu->arch.last_sched_cpu = cpu;
 
 	/* save guest state in registers */
-- 
git-series 0.8.10
