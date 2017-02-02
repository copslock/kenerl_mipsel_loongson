Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Feb 2017 13:16:47 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:44884 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993939AbdBBMFRKcfFv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Feb 2017 13:05:17 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id CD7296AF988A;
        Thu,  2 Feb 2017 12:05:12 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 2 Feb 2017 12:05:15 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH v2 28/30] KVM: MIPS/TLB: Drop kvm_local_flush_tlb_all()
Date:   Thu, 2 Feb 2017 12:04:41 +0000
Message-ID: <5e432f5db9cc4c6927a62345c03131ba37d4e24e.1486036366.git-series.james.hogan@imgtec.com>
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
X-archive-position: 56616
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

Now that KVM no longer uses wired entries we can safely use
local_flush_tlb_all() when we need to flush the entire TLB (on the start
of a new ASID cycle). This doesn't flush wired entries, which allows
other code to use them without KVM clobbering them all the time. It also
is more up to date, knowing about the tlbinv architectural feature,
flushing of micro TLB on cores where that is necessary (Loongson I
believe), and knows to stop the HTW while doing so.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h    |  1 -
 arch/mips/include/asm/mmu_context.h |  5 -----
 arch/mips/kvm/mmu.c                 |  2 +-
 arch/mips/kvm/tlb.c                 | 29 -----------------------------
 4 files changed, 1 insertion(+), 36 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index a26504bee21c..1a83b6f85de2 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -641,7 +641,6 @@ void kvm_trap_emul_invalidate_gva(struct kvm_vcpu *vcpu, unsigned long addr,
 				  bool user);
 extern void kvm_get_new_mmu_context(struct mm_struct *mm, unsigned long cpu,
 				    struct kvm_vcpu *vcpu);
-extern void kvm_local_flush_tlb_all(void);
 extern void kvm_mips_alloc_new_mmu_context(struct kvm_vcpu *vcpu);
 extern void kvm_mips_vcpu_load(struct kvm_vcpu *vcpu, int cpu);
 extern void kvm_mips_vcpu_put(struct kvm_vcpu *vcpu);
diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mmu_context.h
index 16eb8521398e..2abf94f72c0a 100644
--- a/arch/mips/include/asm/mmu_context.h
+++ b/arch/mips/include/asm/mmu_context.h
@@ -99,17 +99,12 @@ static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 static inline void
 get_new_mmu_context(struct mm_struct *mm, unsigned long cpu)
 {
-	extern void kvm_local_flush_tlb_all(void);
 	unsigned long asid = asid_cache(cpu);
 
 	if (!((asid += cpu_asid_inc()) & cpu_asid_mask(&cpu_data[cpu]))) {
 		if (cpu_has_vtag_icache)
 			flush_icache_all();
-#ifdef CONFIG_KVM
-		kvm_local_flush_tlb_all();      /* start new asid cycle */
-#else
 		local_flush_tlb_all();	/* start new asid cycle */
-#endif
 		if (!asid)		/* fix version if needed */
 			asid = asid_first_version(cpu);
 	}
diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index c4e9c65065ea..cf832ea963d8 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -453,7 +453,7 @@ void kvm_get_new_mmu_context(struct mm_struct *mm, unsigned long cpu,
 		if (cpu_has_vtag_icache)
 			flush_icache_all();
 
-		kvm_local_flush_tlb_all();      /* start new asid cycle */
+		local_flush_tlb_all();      /* start new asid cycle */
 
 		if (!asid)      /* fix version if needed */
 			asid = asid_first_version(cpu);
diff --git a/arch/mips/kvm/tlb.c b/arch/mips/kvm/tlb.c
index 8af5fd2cb107..51f4aee717e7 100644
--- a/arch/mips/kvm/tlb.c
+++ b/arch/mips/kvm/tlb.c
@@ -263,35 +263,6 @@ void kvm_mips_flush_host_tlb(int skip_kseg0)
 }
 EXPORT_SYMBOL_GPL(kvm_mips_flush_host_tlb);
 
-void kvm_local_flush_tlb_all(void)
-{
-	unsigned long flags;
-	unsigned long old_ctx;
-	int entry = 0;
-
-	local_irq_save(flags);
-	/* Save old context and create impossible VPN2 value */
-	old_ctx = read_c0_entryhi();
-	write_c0_entrylo0(0);
-	write_c0_entrylo1(0);
-
-	/* Blast 'em all away. */
-	while (entry < current_cpu_data.tlbsize) {
-		/* Make sure all entries differ. */
-		write_c0_entryhi(UNIQUE_ENTRYHI(entry));
-		write_c0_index(entry);
-		mtc0_tlbw_hazard();
-		tlb_write_indexed();
-		tlbw_use_hazard();
-		entry++;
-	}
-	write_c0_entryhi(old_ctx);
-	mtc0_tlbw_hazard();
-
-	local_irq_restore(flags);
-}
-EXPORT_SYMBOL_GPL(kvm_local_flush_tlb_all);
-
 /**
  * kvm_mips_suspend_mm() - Suspend the active mm.
  * @cpu		The CPU we're running on.
-- 
git-series 0.8.10
