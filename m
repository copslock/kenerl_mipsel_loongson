Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jan 2017 02:42:31 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:27116 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993125AbdAFBdwFf-fu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Jan 2017 02:33:52 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id F156CF34073DE;
        Fri,  6 Jan 2017 01:33:44 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 6 Jan 2017 01:33:45 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 22/30] KVM: MIPS/MMU: Convert KSeg0 faults to page tables
Date:   Fri, 6 Jan 2017 01:32:54 +0000
Message-ID: <27424f5721bf65ea1d20f479b4756a4ff69ff89a.1483665879.git-series.james.hogan@imgtec.com>
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
X-archive-position: 56195
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

Now that we have GVA page tables and an optimised TLB refill handler in
place, convert the handling of KSeg0 page faults from the guest to fill
the GVA page tables and invalidate the TLB entry, rather than filling a
TLB entry directly.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/mmu.c | 79 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 64 insertions(+), 15 deletions(-)

diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index dbf2b55ee874..afb47f21d8bc 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -14,6 +14,33 @@
 #include <asm/mmu_context.h>
 #include <asm/pgalloc.h>
 
+/*
+ * KVM_MMU_CACHE_MIN_PAGES is the number of GPA page table translation levels
+ * for which pages need to be cached.
+ */
+#if defined(__PAGETABLE_PMD_FOLDED)
+#define KVM_MMU_CACHE_MIN_PAGES 1
+#else
+#define KVM_MMU_CACHE_MIN_PAGES 2
+#endif
+
+static int mmu_topup_memory_cache(struct kvm_mmu_memory_cache *cache,
+				  int min, int max)
+{
+	void *page;
+
+	BUG_ON(max > KVM_NR_MEM_OBJS);
+	if (cache->nobjs >= min)
+		return 0;
+	while (cache->nobjs < max) {
+		page = (void *)__get_free_page(GFP_KERNEL);
+		if (!page)
+			return -ENOMEM;
+		cache->objects[cache->nobjs++] = page;
+	}
+	return 0;
+}
+
 static void mmu_free_memory_cache(struct kvm_mmu_memory_cache *mc)
 {
 	while (mc->nobjs)
@@ -151,6 +178,27 @@ unsigned long kvm_mips_translate_guest_kseg0_to_hpa(struct kvm_vcpu *vcpu,
 	return (kvm->arch.guest_pmap[gfn] << PAGE_SHIFT) + offset;
 }
 
+static pte_t *kvm_trap_emul_pte_for_gva(struct kvm_vcpu *vcpu,
+					unsigned long addr)
+{
+	struct kvm_mmu_memory_cache *memcache = &vcpu->arch.mmu_page_cache;
+	pgd_t *pgdp;
+	int ret;
+
+	/* We need a minimum of cached pages ready for page table creation */
+	ret = mmu_topup_memory_cache(memcache, KVM_MMU_CACHE_MIN_PAGES,
+				     KVM_NR_MEM_OBJS);
+	if (ret)
+		return NULL;
+
+	if (KVM_GUEST_KERNEL_MODE(vcpu))
+		pgdp = vcpu->arch.guest_kernel_mm.pgd;
+	else
+		pgdp = vcpu->arch.guest_user_mm.pgd;
+
+	return kvm_mips_walk_pgd(pgdp, memcache, addr);
+}
+
 void kvm_trap_emul_invalidate_gva(struct kvm_vcpu *vcpu, unsigned long addr,
 				  bool user)
 {
@@ -316,10 +364,8 @@ int kvm_mips_handle_kseg0_tlb_fault(unsigned long badvaddr,
 	gfn_t gfn;
 	kvm_pfn_t pfn0, pfn1;
 	unsigned long vaddr = 0;
-	unsigned long entryhi = 0, entrylo0 = 0, entrylo1 = 0;
 	struct kvm *kvm = vcpu->kvm;
-	const int flush_dcache_mask = 0;
-	int ret;
+	pte_t *ptep_gva;
 
 	if (KVM_GUEST_KSEGX(badvaddr) != KVM_GUEST_KSEG0) {
 		kvm_err("%s: Invalid BadVaddr: %#lx\n", __func__, badvaddr);
@@ -327,6 +373,8 @@ int kvm_mips_handle_kseg0_tlb_fault(unsigned long badvaddr,
 		return -1;
 	}
 
+	/* Find host PFNs */
+
 	gfn = (KVM_GUEST_CPHYSADDR(badvaddr) >> PAGE_SHIFT);
 	if ((gfn | 1) >= kvm->arch.guest_pmap_npages) {
 		kvm_err("%s: Invalid gfn: %#llx, BadVaddr: %#lx\n", __func__,
@@ -345,20 +393,21 @@ int kvm_mips_handle_kseg0_tlb_fault(unsigned long badvaddr,
 	pfn0 = kvm->arch.guest_pmap[gfn & ~0x1];
 	pfn1 = kvm->arch.guest_pmap[gfn | 0x1];
 
-	entrylo0 = mips3_paddr_to_tlbpfn(pfn0 << PAGE_SHIFT) |
-		((_page_cachable_default >> _CACHE_SHIFT) << ENTRYLO_C_SHIFT) |
-		ENTRYLO_D | ENTRYLO_V;
-	entrylo1 = mips3_paddr_to_tlbpfn(pfn1 << PAGE_SHIFT) |
-		((_page_cachable_default >> _CACHE_SHIFT) << ENTRYLO_C_SHIFT) |
-		ENTRYLO_D | ENTRYLO_V;
+	/* Find GVA page table entry */
 
-	preempt_disable();
-	entryhi = (vaddr | kvm_mips_get_kernel_asid(vcpu));
-	ret = kvm_mips_host_tlb_write(vcpu, entryhi, entrylo0, entrylo1,
-				      flush_dcache_mask);
-	preempt_enable();
+	ptep_gva = kvm_trap_emul_pte_for_gva(vcpu, vaddr);
+	if (!ptep_gva) {
+		kvm_err("No ptep for gva %lx\n", vaddr);
+		return -1;
+	}
 
-	return ret;
+	/* Write host PFNs into GVA page table */
+	ptep_gva[0] = pte_mkyoung(pte_mkdirty(pfn_pte(pfn0, PAGE_SHARED)));
+	ptep_gva[1] = pte_mkyoung(pte_mkdirty(pfn_pte(pfn1, PAGE_SHARED)));
+
+	/* Invalidate this entry in the TLB, guest kernel ASID only */
+	kvm_mips_host_tlb_inv(vcpu, vaddr, false, true);
+	return 0;
 }
 
 int kvm_mips_handle_mapped_seg_tlb_fault(struct kvm_vcpu *vcpu,
-- 
git-series 0.8.10
