Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Feb 2017 13:12:08 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:41033 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993543AbdBBMFIXniKv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Feb 2017 13:05:08 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id CEEBCA415A29D;
        Thu,  2 Feb 2017 12:04:58 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 2 Feb 2017 12:05:01 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH v2 12/30] KVM: MIPS/T&E: active_mm = init_mm in guest context
Date:   Thu, 2 Feb 2017 12:04:25 +0000
Message-ID: <b4f36197e7d6a044ef95cfba971b7e8665953f95.1486036366.git-series.james.hogan@imgtec.com>
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
X-archive-position: 56604
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

Set init_mm as the active_mm and update mm_cpumask(current->mm) to
reflect that it isn't active when in guest context. This prevents cache
management code from attempting cache flushes on host virtual addresses
while in guest context, for example due to a cache management IPIs or
later when writing of dynamically translated code hits copy on write.

We do this using helpers in static kernel code to avoid having to export
init_mm to modules.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
Changes in v2:
- Use well defined helpers in static kernel code to avoid having to
  export init_mm to modules.
---
 arch/mips/include/asm/kvm_host.h |  4 ++++-
 arch/mips/kvm/tlb.c              | 35 +++++++++++++++++++++++++++++++++-
 arch/mips/kvm/trap_emul.c        | 12 ++++++++++-
 3 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 9f319375835a..95320b7964a6 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -607,6 +607,10 @@ extern int kvm_mips_host_tlb_inv(struct kvm_vcpu *vcpu, unsigned long entryhi);
 extern int kvm_mips_guest_tlb_lookup(struct kvm_vcpu *vcpu,
 				     unsigned long entryhi);
 extern int kvm_mips_host_tlb_lookup(struct kvm_vcpu *vcpu, unsigned long vaddr);
+
+void kvm_mips_suspend_mm(int cpu);
+void kvm_mips_resume_mm(int cpu);
+
 extern unsigned long kvm_mips_translate_guest_kseg0_to_hpa(struct kvm_vcpu *vcpu,
 						   unsigned long gva);
 extern void kvm_get_new_mmu_context(struct mm_struct *mm, unsigned long cpu,
diff --git a/arch/mips/kvm/tlb.c b/arch/mips/kvm/tlb.c
index ba490130b5e7..6c1f894b8754 100644
--- a/arch/mips/kvm/tlb.c
+++ b/arch/mips/kvm/tlb.c
@@ -382,3 +382,38 @@ void kvm_local_flush_tlb_all(void)
 	local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(kvm_local_flush_tlb_all);
+
+/**
+ * kvm_mips_suspend_mm() - Suspend the active mm.
+ * @cpu		The CPU we're running on.
+ *
+ * Suspend the active_mm, ready for a switch to a KVM guest virtual address
+ * space. This is left active for the duration of guest context, including time
+ * with interrupts enabled, so we need to be careful not to confuse e.g. cache
+ * management IPIs.
+ *
+ * kvm_mips_resume_mm() should be called before context switching to a different
+ * process so we don't need to worry about reference counting.
+ *
+ * This needs to be in static kernel code to avoid exporting init_mm.
+ */
+void kvm_mips_suspend_mm(int cpu)
+{
+	cpumask_clear_cpu(cpu, mm_cpumask(current->active_mm));
+	current->active_mm = &init_mm;
+}
+EXPORT_SYMBOL_GPL(kvm_mips_suspend_mm);
+
+/**
+ * kvm_mips_resume_mm() - Resume the current process mm.
+ * @cpu		The CPU we're running on.
+ *
+ * Resume the mm of the current process, after a switch back from a KVM guest
+ * virtual address space (see kvm_mips_suspend_mm()).
+ */
+void kvm_mips_resume_mm(int cpu)
+{
+	cpumask_set_cpu(cpu, mm_cpumask(current->mm));
+	current->active_mm = current->mm;
+}
+EXPORT_SYMBOL_GPL(kvm_mips_resume_mm);
diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index 3e1dbcbcea85..9cfe4d2a283c 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -670,6 +670,7 @@ static int kvm_trap_emul_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 			write_c0_entryhi(cpu_asid(cpu, kern_mm));
 		else
 			write_c0_entryhi(cpu_asid(cpu, user_mm));
+		kvm_mips_suspend_mm(cpu);
 		ehb();
 	}
 
@@ -689,6 +690,7 @@ static int kvm_trap_emul_vcpu_put(struct kvm_vcpu *vcpu, int cpu)
 			get_new_mmu_context(current->mm, cpu);
 		}
 		write_c0_entryhi(cpu_asid(cpu, current->mm));
+		kvm_mips_resume_mm(cpu);
 		ehb();
 	}
 
@@ -723,7 +725,7 @@ static void kvm_trap_emul_vcpu_reenter(struct kvm_run *run,
 
 static int kvm_trap_emul_vcpu_run(struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
-	int cpu;
+	int cpu = smp_processor_id();
 	int r;
 
 	/* Check if we have any exceptions/interrupts pending */
@@ -735,6 +737,13 @@ static int kvm_trap_emul_vcpu_run(struct kvm_run *run, struct kvm_vcpu *vcpu)
 	/* Disable hardware page table walking while in guest */
 	htw_stop();
 
+	/*
+	 * While in guest context we're in the guest's address space, not the
+	 * host process address space, so we need to be careful not to confuse
+	 * e.g. cache management IPIs.
+	 */
+	kvm_mips_suspend_mm(cpu);
+
 	r = vcpu->arch.vcpu_run(run, vcpu);
 
 	/* We may have migrated while handling guest exits */
@@ -745,6 +754,7 @@ static int kvm_trap_emul_vcpu_run(struct kvm_run *run, struct kvm_vcpu *vcpu)
 	     asid_version_mask(cpu)))
 		get_new_mmu_context(current->mm, cpu);
 	write_c0_entryhi(cpu_asid(cpu, current->mm));
+	kvm_mips_resume_mm(cpu);
 
 	htw_start();
 
-- 
git-series 0.8.10
