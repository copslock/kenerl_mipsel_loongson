Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Feb 2017 13:08:00 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:20794 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993914AbdBBMFHljwbv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Feb 2017 13:05:07 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id A3884E944BFCA;
        Thu,  2 Feb 2017 12:04:55 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 2 Feb 2017 12:04:58 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH v2 8/30] KVM: MIPS/MMU: Move preempt/ASID handling to implementation
Date:   Thu, 2 Feb 2017 12:04:21 +0000
Message-ID: <341dc04c44b0bdf43044866f9bb1eac091e856ea.1486036366.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
In-Reply-To: <cover.e37f86dece46fc3ed00a075d68119cab361cda8e.1486036366.git-series.james.hogan@imgtec.com>
References: <cover.e37f86dece46fc3ed00a075d68119cab361cda8e.1486036366.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56595
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

The MIPS KVM host and guest GVA ASIDs may need regenerating when
scheduling a process in guest context, which is done from the
kvm_arch_vcpu_load() / kvm_arch_vcpu_put() functions in mmu.c.

However this is a fairly implementation specific detail. VZ for example
may use GuestIDs instead of normal ASIDs to distinguish mappings
belonging to different guests, and even on VZ without GuestID the root
TLB will be used differently to trap & emulate.

Trap & emulate GVA ASIDs only relate to the user part of the full
address space, so can be left active during guest exit handling (guest
context) to allow guest instructions to be easily read and translated.

VZ root ASIDs however are for GPA mappings so can't be left active
during normal kernel code. They also aren't useful for accessing guest
virtual memory, and we should have CP0_BadInstr[P] registers available
to provide encodings of trapping guest instructions anyway.

Therefore move the ASID preemption handling into the implementation
callback.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/mmu.c       | 51 +------------------------------------
 arch/mips/kvm/trap_emul.c | 56 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 54 insertions(+), 53 deletions(-)

diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index ed46528611f4..df013538113f 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -235,39 +235,12 @@ static void kvm_mips_migrate_count(struct kvm_vcpu *vcpu)
 /* Restore ASID once we are scheduled back after preemption */
 void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
-	unsigned long asid_mask = cpu_asid_mask(&cpu_data[cpu]);
 	unsigned long flags;
 
 	kvm_debug("%s: vcpu %p, cpu: %d\n", __func__, vcpu, cpu);
 
-	/* Allocate new kernel and user ASIDs if needed */
-
 	local_irq_save(flags);
 
-	if ((vcpu->arch.guest_kernel_asid[cpu] ^ asid_cache(cpu)) &
-						asid_version_mask(cpu)) {
-		kvm_get_new_mmu_context(&vcpu->arch.guest_kernel_mm, cpu, vcpu);
-		vcpu->arch.guest_kernel_asid[cpu] =
-		    vcpu->arch.guest_kernel_mm.context.asid[cpu];
-
-		kvm_debug("[%d]: cpu_context: %#lx\n", cpu,
-			  cpu_context(cpu, current->mm));
-		kvm_debug("[%d]: Allocated new ASID for Guest Kernel: %#x\n",
-			  cpu, vcpu->arch.guest_kernel_asid[cpu]);
-	}
-
-	if ((vcpu->arch.guest_user_asid[cpu] ^ asid_cache(cpu)) &
-						asid_version_mask(cpu)) {
-		kvm_get_new_mmu_context(&vcpu->arch.guest_user_mm, cpu, vcpu);
-		vcpu->arch.guest_user_asid[cpu] =
-		    vcpu->arch.guest_user_mm.context.asid[cpu];
-
-		kvm_debug("[%d]: cpu_context: %#lx\n", cpu,
-			  cpu_context(cpu, current->mm));
-		kvm_debug("[%d]: Allocated new ASID for Guest User: %#x\n", cpu,
-			  vcpu->arch.guest_user_asid[cpu]);
-	}
-
 	if (vcpu->arch.last_sched_cpu != cpu) {
 		kvm_debug("[%d->%d]KVM VCPU[%d] switch\n",
 			  vcpu->arch.last_sched_cpu, cpu, vcpu->vcpu_id);
@@ -279,25 +252,10 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 		kvm_mips_migrate_count(vcpu);
 	}
 
-	/*
-	 * If we preempted while the guest was executing, then reload the ASID
-	 * based on the mode of the Guest (Kernel/User)
-	 */
-	if (current->flags & PF_VCPU) {
-		if (KVM_GUEST_KERNEL_MODE(vcpu))
-			write_c0_entryhi(vcpu->arch.guest_kernel_asid[cpu] &
-					 asid_mask);
-		else
-			write_c0_entryhi(vcpu->arch.guest_user_asid[cpu] &
-					 asid_mask);
-		ehb();
-	}
-
 	/* restore guest state to registers */
 	kvm_mips_callbacks->vcpu_load(vcpu, cpu);
 
 	local_irq_restore(flags);
-
 }
 
 /* ASID can change if another task is scheduled during preemption */
@@ -314,15 +272,6 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 	/* save guest state in registers */
 	kvm_mips_callbacks->vcpu_put(vcpu, cpu);
 
-	if (((cpu_context(cpu, current->mm) ^ asid_cache(cpu)) &
-	     asid_version_mask(cpu))) {
-		kvm_debug("%s: Dropping MMU Context:  %#lx\n", __func__,
-			  cpu_context(cpu, current->mm));
-		drop_mmu_context(current->mm, cpu);
-	}
-	write_c0_entryhi(cpu_asid(cpu, current->mm));
-	ehb();
-
 	local_irq_restore(flags);
 }
 
diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index c0ee51465913..494a90221b5e 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -11,9 +11,9 @@
 
 #include <linux/errno.h>
 #include <linux/err.h>
-#include <linux/vmalloc.h>
-
 #include <linux/kvm_host.h>
+#include <linux/vmalloc.h>
+#include <asm/mmu_context.h>
 
 #include "interrupt.h"
 
@@ -635,6 +635,49 @@ static int kvm_trap_emul_set_one_reg(struct kvm_vcpu *vcpu,
 
 static int kvm_trap_emul_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
+	unsigned long asid_mask = cpu_asid_mask(&cpu_data[cpu]);
+
+	/* Allocate new kernel and user ASIDs if needed */
+
+	if ((vcpu->arch.guest_kernel_asid[cpu] ^ asid_cache(cpu)) &
+						asid_version_mask(cpu)) {
+		kvm_get_new_mmu_context(&vcpu->arch.guest_kernel_mm, cpu, vcpu);
+		vcpu->arch.guest_kernel_asid[cpu] =
+		    vcpu->arch.guest_kernel_mm.context.asid[cpu];
+
+		kvm_debug("[%d]: cpu_context: %#lx\n", cpu,
+			  cpu_context(cpu, current->mm));
+		kvm_debug("[%d]: Allocated new ASID for Guest Kernel: %#x\n",
+			  cpu, vcpu->arch.guest_kernel_asid[cpu]);
+	}
+
+	if ((vcpu->arch.guest_user_asid[cpu] ^ asid_cache(cpu)) &
+						asid_version_mask(cpu)) {
+		kvm_get_new_mmu_context(&vcpu->arch.guest_user_mm, cpu, vcpu);
+		vcpu->arch.guest_user_asid[cpu] =
+		    vcpu->arch.guest_user_mm.context.asid[cpu];
+
+		kvm_debug("[%d]: cpu_context: %#lx\n", cpu,
+			  cpu_context(cpu, current->mm));
+		kvm_debug("[%d]: Allocated new ASID for Guest User: %#x\n", cpu,
+			  vcpu->arch.guest_user_asid[cpu]);
+	}
+
+	/*
+	 * Were we in guest context? If so then the pre-empted ASID is
+	 * no longer valid, we need to set it to what it should be based
+	 * on the mode of the Guest (Kernel/User)
+	 */
+	if (current->flags & PF_VCPU) {
+		if (KVM_GUEST_KERNEL_MODE(vcpu))
+			write_c0_entryhi(vcpu->arch.guest_kernel_asid[cpu] &
+					 asid_mask);
+		else
+			write_c0_entryhi(vcpu->arch.guest_user_asid[cpu] &
+					 asid_mask);
+		ehb();
+	}
+
 	return 0;
 }
 
@@ -642,6 +685,15 @@ static int kvm_trap_emul_vcpu_put(struct kvm_vcpu *vcpu, int cpu)
 {
 	kvm_lose_fpu(vcpu);
 
+	if (((cpu_context(cpu, current->mm) ^ asid_cache(cpu)) &
+	     asid_version_mask(cpu))) {
+		kvm_debug("%s: Dropping MMU Context:  %#lx\n", __func__,
+			  cpu_context(cpu, current->mm));
+		drop_mmu_context(current->mm, cpu);
+	}
+	write_c0_entryhi(cpu_asid(cpu, current->mm));
+	ehb();
+
 	return 0;
 }
 
-- 
git-series 0.8.10
