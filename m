Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Feb 2017 13:16:23 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:1215 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993937AbdBBMFQ5tiiv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Feb 2017 13:05:16 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 1886A3DA91390;
        Thu,  2 Feb 2017 12:05:07 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 2 Feb 2017 12:05:10 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH v2 21/30] KVM: MIPS/MMU: Invalidate stale GVA PTEs on TLBW
Date:   Thu, 2 Feb 2017 12:04:34 +0000
Message-ID: <42f178d55998b92510eea95548f6ea24c60a9144.1486036366.git-series.james.hogan@imgtec.com>
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
X-archive-position: 56615
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

Implement invalidation of specific pairs of GVA page table entries in
one or both of the GVA page tables. This is used when existing mappings
are replaced in the guest TLB by emulated TLBWI/TLBWR instructions. Due
to the sharing of page tables in the host kernel range, we should be
careful not to allow host pages to be invalidated.

Add a helper kvm_mips_walk_pgd() which can be used when walking of
either GPA (future patches) or GVA page tables is needed, optionally
with allocation of page tables along the way when they don't exist.

GPA page table walking will need to be protected by the kvm->mmu_lock,
so we also add a small MMU page cache in each KVM VCPU, like that found
for other architectures but smaller. This allows enough pages to be
pre-allocated to handle a single fault without holding the lock,
allowing the helper to run with the lock held without having to handle
allocation failures.

Using the same mechanism for GVA allows the same code to be used, and
allows it to use the same cache of allocated pages if the GPA walk
didn't need to allocate any new tables.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h | 17 ++++++-
 arch/mips/kvm/emulate.c          |  6 ++-
 arch/mips/kvm/mips.c             |  1 +-
 arch/mips/kvm/mmu.c              | 95 +++++++++++++++++++++++++++++++++-
 4 files changed, 119 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index f5145dcab319..40aab4f5007c 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -261,6 +261,17 @@ struct kvm_mips_tlb {
 	long tlb_lo[2];
 };
 
+#define KVM_NR_MEM_OBJS     4
+
+/*
+ * We don't want allocation failures within the mmu code, so we preallocate
+ * enough memory for a single page fault in a cache.
+ */
+struct kvm_mmu_memory_cache {
+	int nobjs;
+	void *objects[KVM_NR_MEM_OBJS];
+};
+
 #define KVM_MIPS_AUX_FPU	0x1
 #define KVM_MIPS_AUX_MSA	0x2
 
@@ -327,6 +338,9 @@ struct kvm_vcpu_arch {
 	/* Guest ASID of last user mode execution */
 	unsigned int last_user_gasid;
 
+	/* Cache some mmu pages needed inside spinlock regions */
+	struct kvm_mmu_memory_cache mmu_page_cache;
+
 	int last_sched_cpu;
 
 	/* WAIT executed */
@@ -631,6 +645,9 @@ enum kvm_mips_flush {
 	KMF_GPA		= 0x2,
 };
 void kvm_mips_flush_gva_pt(pgd_t *pgd, enum kvm_mips_flush flags);
+void kvm_mmu_free_memory_caches(struct kvm_vcpu *vcpu);
+void kvm_trap_emul_invalidate_gva(struct kvm_vcpu *vcpu, unsigned long addr,
+				  bool user);
 extern unsigned long kvm_mips_translate_guest_kseg0_to_hpa(struct kvm_vcpu *vcpu,
 						   unsigned long gva);
 extern void kvm_get_new_mmu_context(struct mm_struct *mm, unsigned long cpu,
diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index 1d399396e486..19eaeda6975c 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -864,11 +864,17 @@ static void kvm_mips_invalidate_guest_tlb(struct kvm_vcpu *vcpu,
 	/* No need to flush for entries which are already invalid */
 	if (!((tlb->tlb_lo[0] | tlb->tlb_lo[1]) & ENTRYLO_V))
 		return;
+	/* Don't touch host kernel page tables or TLB mappings */
+	if ((unsigned long)tlb->tlb_hi > 0x7fffffff)
+		return;
 	/* User address space doesn't need flushing for KSeg2/3 changes */
 	user = tlb->tlb_hi < KVM_GUEST_KSEG0;
 
 	preempt_disable();
 
+	/* Invalidate page table entries */
+	kvm_trap_emul_invalidate_gva(vcpu, tlb->tlb_hi & VPN2_MASK, user);
+
 	/*
 	 * Probe the shadow host TLB for the entry being overwritten, if one
 	 * matches, invalidate it
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 3cf720790ce6..c55e6f8c57c7 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -396,6 +396,7 @@ void kvm_arch_vcpu_free(struct kvm_vcpu *vcpu)
 
 	kvm_mips_dump_stats(vcpu);
 
+	kvm_mmu_free_memory_caches(vcpu);
 	kfree(vcpu->arch.guest_ebase);
 	kfree(vcpu->arch.kseg0_commpage);
 	kfree(vcpu);
diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index 09146b62552f..dbf2b55ee874 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -14,6 +14,26 @@
 #include <asm/mmu_context.h>
 #include <asm/pgalloc.h>
 
+static void mmu_free_memory_cache(struct kvm_mmu_memory_cache *mc)
+{
+	while (mc->nobjs)
+		free_page((unsigned long)mc->objects[--mc->nobjs]);
+}
+
+static void *mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc)
+{
+	void *p;
+
+	BUG_ON(!mc || !mc->nobjs);
+	p = mc->objects[--mc->nobjs];
+	return p;
+}
+
+void kvm_mmu_free_memory_caches(struct kvm_vcpu *vcpu)
+{
+	mmu_free_memory_cache(&vcpu->arch.mmu_page_cache);
+}
+
 static u32 kvm_mips_get_kernel_asid(struct kvm_vcpu *vcpu)
 {
 	struct mm_struct *kern_mm = &vcpu->arch.guest_kernel_mm;
@@ -30,6 +50,56 @@ static u32 kvm_mips_get_user_asid(struct kvm_vcpu *vcpu)
 	return cpu_asid(cpu, user_mm);
 }
 
+/**
+ * kvm_mips_walk_pgd() - Walk page table with optional allocation.
+ * @pgd:	Page directory pointer.
+ * @addr:	Address to index page table using.
+ * @cache:	MMU page cache to allocate new page tables from, or NULL.
+ *
+ * Walk the page tables pointed to by @pgd to find the PTE corresponding to the
+ * address @addr. If page tables don't exist for @addr, they will be created
+ * from the MMU cache if @cache is not NULL.
+ *
+ * Returns:	Pointer to pte_t corresponding to @addr.
+ *		NULL if a page table doesn't exist for @addr and !@cache.
+ *		NULL if a page table allocation failed.
+ */
+static pte_t *kvm_mips_walk_pgd(pgd_t *pgd, struct kvm_mmu_memory_cache *cache,
+				unsigned long addr)
+{
+	pud_t *pud;
+	pmd_t *pmd;
+
+	pgd += pgd_index(addr);
+	if (pgd_none(*pgd)) {
+		/* Not used on MIPS yet */
+		BUG();
+		return NULL;
+	}
+	pud = pud_offset(pgd, addr);
+	if (pud_none(*pud)) {
+		pmd_t *new_pmd;
+
+		if (!cache)
+			return NULL;
+		new_pmd = mmu_memory_cache_alloc(cache);
+		pmd_init((unsigned long)new_pmd,
+			 (unsigned long)invalid_pte_table);
+		pud_populate(NULL, pud, new_pmd);
+	}
+	pmd = pmd_offset(pud, addr);
+	if (pmd_none(*pmd)) {
+		pte_t *new_pte;
+
+		if (!cache)
+			return NULL;
+		new_pte = mmu_memory_cache_alloc(cache);
+		clear_page(new_pte);
+		pmd_populate_kernel(NULL, pmd, new_pte);
+	}
+	return pte_offset(pmd, addr);
+}
+
 static int kvm_mips_map_page(struct kvm *kvm, gfn_t gfn)
 {
 	int srcu_idx, err = 0;
@@ -81,6 +151,31 @@ unsigned long kvm_mips_translate_guest_kseg0_to_hpa(struct kvm_vcpu *vcpu,
 	return (kvm->arch.guest_pmap[gfn] << PAGE_SHIFT) + offset;
 }
 
+void kvm_trap_emul_invalidate_gva(struct kvm_vcpu *vcpu, unsigned long addr,
+				  bool user)
+{
+	pgd_t *pgdp;
+	pte_t *ptep;
+
+	addr &= PAGE_MASK << 1;
+
+	pgdp = vcpu->arch.guest_kernel_mm.pgd;
+	ptep = kvm_mips_walk_pgd(pgdp, NULL, addr);
+	if (ptep) {
+		ptep[0] = pfn_pte(0, __pgprot(0));
+		ptep[1] = pfn_pte(0, __pgprot(0));
+	}
+
+	if (user) {
+		pgdp = vcpu->arch.guest_user_mm.pgd;
+		ptep = kvm_mips_walk_pgd(pgdp, NULL, addr);
+		if (ptep) {
+			ptep[0] = pfn_pte(0, __pgprot(0));
+			ptep[1] = pfn_pte(0, __pgprot(0));
+		}
+	}
+}
+
 /*
  * kvm_mips_flush_gva_{pte,pmd,pud,pgd,pt}.
  * Flush a range of guest physical address space from the VM's GPA page tables.
-- 
git-series 0.8.10
