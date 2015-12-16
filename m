Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Dec 2015 00:51:45 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:14543 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27014064AbbLPXuMepbB0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Dec 2015 00:50:12 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 8DDD38A679267;
        Wed, 16 Dec 2015 23:50:02 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Wed, 16 Dec 2015 23:50:06 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 16 Dec 2015 23:50:05 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paolo Bonzini <pbonzini@redhat.com>
CC:     Gleb Natapov <gleb@kernel.org>, <linux-mips@linux-mips.org>,
        <kvm@vger.kernel.org>, James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 05/16] MIPS: KVM: Convert EXPORT_SYMBOL to _GPL
Date:   Wed, 16 Dec 2015 23:49:30 +0000
Message-ID: <1450309781-28030-6-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1450309781-28030-1-git-send-email-james.hogan@imgtec.com>
References: <1450309781-28030-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50653
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

Export symbols only to GPL modules to match other KVM symbols in
virt/kvm/ and arch/*/kvm/.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/callback.c |  2 +-
 arch/mips/kvm/tlb.c      | 36 ++++++++++++++++++------------------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/mips/kvm/callback.c b/arch/mips/kvm/callback.c
index 313c2e37b978..d88aa2173fb0 100644
--- a/arch/mips/kvm/callback.c
+++ b/arch/mips/kvm/callback.c
@@ -11,4 +11,4 @@
 #include <linux/kvm_host.h>
 
 struct kvm_mips_callbacks *kvm_mips_callbacks;
-EXPORT_SYMBOL(kvm_mips_callbacks);
+EXPORT_SYMBOL_GPL(kvm_mips_callbacks);
diff --git a/arch/mips/kvm/tlb.c b/arch/mips/kvm/tlb.c
index 2c0997447448..0939b1d6f910 100644
--- a/arch/mips/kvm/tlb.c
+++ b/arch/mips/kvm/tlb.c
@@ -35,17 +35,17 @@
 #define PRIx64 "llx"
 
 atomic_t kvm_mips_instance;
-EXPORT_SYMBOL(kvm_mips_instance);
+EXPORT_SYMBOL_GPL(kvm_mips_instance);
 
 /* These function pointers are initialized once the KVM module is loaded */
 pfn_t (*kvm_mips_gfn_to_pfn)(struct kvm *kvm, gfn_t gfn);
-EXPORT_SYMBOL(kvm_mips_gfn_to_pfn);
+EXPORT_SYMBOL_GPL(kvm_mips_gfn_to_pfn);
 
 void (*kvm_mips_release_pfn_clean)(pfn_t pfn);
-EXPORT_SYMBOL(kvm_mips_release_pfn_clean);
+EXPORT_SYMBOL_GPL(kvm_mips_release_pfn_clean);
 
 bool (*kvm_mips_is_error_pfn)(pfn_t pfn);
-EXPORT_SYMBOL(kvm_mips_is_error_pfn);
+EXPORT_SYMBOL_GPL(kvm_mips_is_error_pfn);
 
 uint32_t kvm_mips_get_kernel_asid(struct kvm_vcpu *vcpu)
 {
@@ -111,7 +111,7 @@ void kvm_mips_dump_host_tlbs(void)
 	mtc0_tlbw_hazard();
 	local_irq_restore(flags);
 }
-EXPORT_SYMBOL(kvm_mips_dump_host_tlbs);
+EXPORT_SYMBOL_GPL(kvm_mips_dump_host_tlbs);
 
 void kvm_mips_dump_guest_tlbs(struct kvm_vcpu *vcpu)
 {
@@ -139,7 +139,7 @@ void kvm_mips_dump_guest_tlbs(struct kvm_vcpu *vcpu)
 			 (tlb.tlb_lo1 >> 3) & 7, tlb.tlb_mask);
 	}
 }
-EXPORT_SYMBOL(kvm_mips_dump_guest_tlbs);
+EXPORT_SYMBOL_GPL(kvm_mips_dump_guest_tlbs);
 
 static int kvm_mips_map_page(struct kvm *kvm, gfn_t gfn)
 {
@@ -191,7 +191,7 @@ unsigned long kvm_mips_translate_guest_kseg0_to_hpa(struct kvm_vcpu *vcpu,
 
 	return (kvm->arch.guest_pmap[gfn] << PAGE_SHIFT) + offset;
 }
-EXPORT_SYMBOL(kvm_mips_translate_guest_kseg0_to_hpa);
+EXPORT_SYMBOL_GPL(kvm_mips_translate_guest_kseg0_to_hpa);
 
 /* XXXKYMA: Must be called with interrupts disabled */
 /* set flush_dcache_mask == 0 if no dcache flush required */
@@ -308,7 +308,7 @@ int kvm_mips_handle_kseg0_tlb_fault(unsigned long badvaddr,
 	return kvm_mips_host_tlb_write(vcpu, entryhi, entrylo0, entrylo1,
 				       flush_dcache_mask);
 }
-EXPORT_SYMBOL(kvm_mips_handle_kseg0_tlb_fault);
+EXPORT_SYMBOL_GPL(kvm_mips_handle_kseg0_tlb_fault);
 
 int kvm_mips_handle_commpage_tlb_fault(unsigned long badvaddr,
 	struct kvm_vcpu *vcpu)
@@ -351,7 +351,7 @@ int kvm_mips_handle_commpage_tlb_fault(unsigned long badvaddr,
 
 	return 0;
 }
-EXPORT_SYMBOL(kvm_mips_handle_commpage_tlb_fault);
+EXPORT_SYMBOL_GPL(kvm_mips_handle_commpage_tlb_fault);
 
 int kvm_mips_handle_mapped_seg_tlb_fault(struct kvm_vcpu *vcpu,
 					 struct kvm_mips_tlb *tlb,
@@ -401,7 +401,7 @@ int kvm_mips_handle_mapped_seg_tlb_fault(struct kvm_vcpu *vcpu,
 	return kvm_mips_host_tlb_write(vcpu, entryhi, entrylo0, entrylo1,
 				       tlb->tlb_mask);
 }
-EXPORT_SYMBOL(kvm_mips_handle_mapped_seg_tlb_fault);
+EXPORT_SYMBOL_GPL(kvm_mips_handle_mapped_seg_tlb_fault);
 
 int kvm_mips_guest_tlb_lookup(struct kvm_vcpu *vcpu, unsigned long entryhi)
 {
@@ -422,7 +422,7 @@ int kvm_mips_guest_tlb_lookup(struct kvm_vcpu *vcpu, unsigned long entryhi)
 
 	return index;
 }
-EXPORT_SYMBOL(kvm_mips_guest_tlb_lookup);
+EXPORT_SYMBOL_GPL(kvm_mips_guest_tlb_lookup);
 
 int kvm_mips_host_tlb_lookup(struct kvm_vcpu *vcpu, unsigned long vaddr)
 {
@@ -458,7 +458,7 @@ int kvm_mips_host_tlb_lookup(struct kvm_vcpu *vcpu, unsigned long vaddr)
 
 	return idx;
 }
-EXPORT_SYMBOL(kvm_mips_host_tlb_lookup);
+EXPORT_SYMBOL_GPL(kvm_mips_host_tlb_lookup);
 
 int kvm_mips_host_tlb_inv(struct kvm_vcpu *vcpu, unsigned long va)
 {
@@ -505,7 +505,7 @@ int kvm_mips_host_tlb_inv(struct kvm_vcpu *vcpu, unsigned long va)
 
 	return 0;
 }
-EXPORT_SYMBOL(kvm_mips_host_tlb_inv);
+EXPORT_SYMBOL_GPL(kvm_mips_host_tlb_inv);
 
 void kvm_mips_flush_host_tlb(int skip_kseg0)
 {
@@ -557,7 +557,7 @@ void kvm_mips_flush_host_tlb(int skip_kseg0)
 
 	local_irq_restore(flags);
 }
-EXPORT_SYMBOL(kvm_mips_flush_host_tlb);
+EXPORT_SYMBOL_GPL(kvm_mips_flush_host_tlb);
 
 void kvm_get_new_mmu_context(struct mm_struct *mm, unsigned long cpu,
 			     struct kvm_vcpu *vcpu)
@@ -605,7 +605,7 @@ void kvm_local_flush_tlb_all(void)
 
 	local_irq_restore(flags);
 }
-EXPORT_SYMBOL(kvm_local_flush_tlb_all);
+EXPORT_SYMBOL_GPL(kvm_local_flush_tlb_all);
 
 /**
  * kvm_mips_migrate_count() - Migrate timer.
@@ -702,7 +702,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	local_irq_restore(flags);
 
 }
-EXPORT_SYMBOL(kvm_arch_vcpu_load);
+EXPORT_SYMBOL_GPL(kvm_arch_vcpu_load);
 
 /* ASID can change if another task is scheduled during preemption */
 void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
@@ -731,7 +731,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 
 	local_irq_restore(flags);
 }
-EXPORT_SYMBOL(kvm_arch_vcpu_put);
+EXPORT_SYMBOL_GPL(kvm_arch_vcpu_put);
 
 uint32_t kvm_get_inst(uint32_t *opc, struct kvm_vcpu *vcpu)
 {
@@ -776,4 +776,4 @@ uint32_t kvm_get_inst(uint32_t *opc, struct kvm_vcpu *vcpu)
 
 	return inst;
 }
-EXPORT_SYMBOL(kvm_get_inst);
+EXPORT_SYMBOL_GPL(kvm_get_inst);
-- 
2.4.10
