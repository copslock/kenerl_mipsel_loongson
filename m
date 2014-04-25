Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Apr 2014 17:28:25 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.114]:47969 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6843064AbaDYPUwga4dX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Apr 2014 17:20:52 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 762D4586B504D;
        Fri, 25 Apr 2014 16:20:42 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Fri, 25 Apr
 2014 16:20:45 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Fri, 25 Apr 2014 16:20:45 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.65) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Fri, 25 Apr 2014 16:20:44 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     James Hogan <james.hogan@imgtec.com>,
        Gleb Natapov <gleb@kernel.org>, <kvm@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, Sanjay Lal <sanjayl@kymasys.com>
Subject: [PATCH 20/21] MIPS: KVM: Quieten kvm_info() logging
Date:   Fri, 25 Apr 2014 16:20:03 +0100
Message-ID: <1398439204-26171-21-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1398439204-26171-1-git-send-email-james.hogan@imgtec.com>
References: <1398439204-26171-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.65]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39946
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

The logging from MIPS KVM is fairly noisy with kvm_info() in places
where it shouldn't be, such as on VM creation and migration to a
different CPU. Replace these kvm_info() calls with kvm_debug().

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: kvm@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: Sanjay Lal <sanjayl@kymasys.com>
---
 arch/mips/kvm/kvm_mips.c | 27 +++++++++++++--------------
 arch/mips/kvm/kvm_tlb.c  | 16 ++++++++--------
 2 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/arch/mips/kvm/kvm_mips.c b/arch/mips/kvm/kvm_mips.c
index 0cf03efe8a57..c0c4f20191b5 100644
--- a/arch/mips/kvm/kvm_mips.c
+++ b/arch/mips/kvm/kvm_mips.c
@@ -130,8 +130,8 @@ static void kvm_mips_init_vm_percpu(void *arg)
 int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 {
 	if (atomic_inc_return(&kvm_mips_instance) == 1) {
-		kvm_info("%s: 1st KVM instance, setup host TLB parameters\n",
-			 __func__);
+		kvm_debug("%s: 1st KVM instance, setup host TLB parameters\n",
+			  __func__);
 		on_each_cpu(kvm_mips_init_vm_percpu, kvm, 1);
 	}
 
@@ -186,8 +186,8 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 
 	/* If this is the last instance, restore wired count */
 	if (atomic_dec_return(&kvm_mips_instance) == 0) {
-		kvm_info("%s: last KVM instance, restoring TLB parameters\n",
-			 __func__);
+		kvm_debug("%s: last KVM instance, restoring TLB parameters\n",
+			  __func__);
 		on_each_cpu(kvm_mips_uninit_tlbs, NULL, 1);
 	}
 }
@@ -249,9 +249,8 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 				goto out;
 			}
 
-			kvm_info
-			    ("Allocated space for Guest PMAP Table (%ld pages) @ %p\n",
-			     npages, kvm->arch.guest_pmap);
+			kvm_debug("Allocated space for Guest PMAP Table (%ld pages) @ %p\n",
+				  npages, kvm->arch.guest_pmap);
 
 			/* Now setup the page table */
 			for (i = 0; i < npages; i++) {
@@ -296,7 +295,7 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm, unsigned int id)
 	if (err)
 		goto out_free_cpu;
 
-	kvm_info("kvm @ %p: create cpu %d at %p\n", kvm, id, vcpu);
+	kvm_debug("kvm @ %p: create cpu %d at %p\n", kvm, id, vcpu);
 
 	/* Allocate space for host mode exception handlers that handle
 	 * guest mode exits
@@ -316,8 +315,8 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm, unsigned int id)
 		err = -ENOMEM;
 		goto out_free_cpu;
 	}
-	kvm_info("Allocated %d bytes for KVM Exception Handlers @ %p\n",
-		 ALIGN(size, PAGE_SIZE), gebase);
+	kvm_debug("Allocated %d bytes for KVM Exception Handlers @ %p\n",
+		  ALIGN(size, PAGE_SIZE), gebase);
 
 	/* Save new ebase */
 	vcpu->arch.guest_ebase = gebase;
@@ -342,9 +341,9 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm, unsigned int id)
 
 	/* General handler, relocate to unmapped space for sanity's sake */
 	offset = 0x2000;
-	kvm_info("Installing KVM Exception handlers @ %p, %#x bytes\n",
-		 gebase + offset,
-		 mips32_GuestExceptionEnd - mips32_GuestException);
+	kvm_debug("Installing KVM Exception handlers @ %p, %#x bytes\n",
+		  gebase + offset,
+		  mips32_GuestExceptionEnd - mips32_GuestException);
 
 	memcpy(gebase + offset, mips32_GuestException,
 	       mips32_GuestExceptionEnd - mips32_GuestException);
@@ -361,7 +360,7 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm, unsigned int id)
 		goto out_free_gebase;
 	}
 
-	kvm_info("Allocated COMM page @ %p\n", vcpu->arch.kseg0_commpage);
+	kvm_debug("Allocated COMM page @ %p\n", vcpu->arch.kseg0_commpage);
 	kvm_mips_commpage_init(vcpu);
 
 	/* Init */
diff --git a/arch/mips/kvm/kvm_tlb.c b/arch/mips/kvm/kvm_tlb.c
index 51e7866ea893..0cdd586b0dc5 100644
--- a/arch/mips/kvm/kvm_tlb.c
+++ b/arch/mips/kvm/kvm_tlb.c
@@ -662,17 +662,17 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 		    vcpu->arch.guest_user_mm.context.asid[cpu];
 		newasid++;
 
-		kvm_info("[%d]: cpu_context: %#lx\n", cpu,
-			 cpu_context(cpu, current->mm));
-		kvm_info("[%d]: Allocated new ASID for Guest Kernel: %#x\n",
-			 cpu, vcpu->arch.guest_kernel_asid[cpu]);
-		kvm_info("[%d]: Allocated new ASID for Guest User: %#x\n", cpu,
-			 vcpu->arch.guest_user_asid[cpu]);
+		kvm_debug("[%d]: cpu_context: %#lx\n", cpu,
+			  cpu_context(cpu, current->mm));
+		kvm_debug("[%d]: Allocated new ASID for Guest Kernel: %#x\n",
+			  cpu, vcpu->arch.guest_kernel_asid[cpu]);
+		kvm_debug("[%d]: Allocated new ASID for Guest User: %#x\n", cpu,
+			  vcpu->arch.guest_user_asid[cpu]);
 	}
 
 	if (vcpu->arch.last_sched_cpu != cpu) {
-		kvm_info("[%d->%d]KVM VCPU[%d] switch\n",
-			 vcpu->arch.last_sched_cpu, cpu, vcpu->vcpu_id);
+		kvm_debug("[%d->%d]KVM VCPU[%d] switch\n",
+			  vcpu->arch.last_sched_cpu, cpu, vcpu->vcpu_id);
 		/*
 		 * Migrate the timer interrupt to the current CPU so that it
 		 * always interrupts the guest and synchronously triggers a
-- 
1.8.1.2
