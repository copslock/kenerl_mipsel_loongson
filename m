Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jan 2017 21:54:47 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:39318 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993869AbdAIUx3fNltP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Jan 2017 21:53:29 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 9D8DB9DF90990;
        Mon,  9 Jan 2017 20:53:18 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 9 Jan 2017 20:53:22 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 2/10] KVM: MIPS/MMU: Convert guest physical map to page table
Date:   Mon, 9 Jan 2017 20:51:54 +0000
Message-ID: <2c1b56d0a48fd8ffa2e8cd1729a6f1f546cf1b2d.1483993967.git-series.james.hogan@imgtec.com>
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
X-archive-position: 56238
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

Current guest physical memory is mapped to host physical addresses using
a single linear array (guest_pmap of length guest_pmap_npages). This was
only really meant to be temporary, and isn't sparse, so its wasteful of
memory. A small amount of RAM at GPA 0 and a small boot exception vector
at GPA 0x1fc00000 cannot be represented without a full 128KiB guest_pmap
allocation (MIPS32 with 16KiB pages), which is one reason why QEMU
currently runs its boot code at the top of RAM instead of the usual boot
exception vector address.

Instead use the existing infrastructure for host virtual page table
management to allocate a page table for guest physical memory too. This
should be sufficient for now, assuming the size of physical memory
doesn't exceed the size of virtual memory. It may need extending in
future to handle XPA (eXtended Physical Addressing) in 32-bit guests, as
supported by VZ guests on P5600.

Some of this code is based loosely on Cavium's VZ KVM implementation.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h |   7 +-
 arch/mips/kvm/mips.c             |  48 +----
 arch/mips/kvm/mmu.c              | 293 ++++++++++++++++++++++++++++----
 3 files changed, 278 insertions(+), 70 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index ac9d41900597..b2d968ed2757 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -153,9 +153,8 @@ struct kvm_arch_memory_slot {
 };
 
 struct kvm_arch {
-	/* Guest GVA->HPA page table */
-	unsigned long *guest_pmap;
-	unsigned long guest_pmap_npages;
+	/* Guest physical mm */
+	struct mm_struct gpa_mm;
 };
 
 #define N_MIPS_COPROC_REGS	32
@@ -633,6 +632,8 @@ enum kvm_mips_flush {
 	KMF_GPA		= 0x2,
 };
 void kvm_mips_flush_gva_pt(pgd_t *pgd, enum kvm_mips_flush flags);
+bool kvm_mips_flush_gpa_pt(struct kvm *kvm, gfn_t start_gfn, gfn_t end_gfn);
+pgd_t *kvm_pgd_alloc(void);
 void kvm_mmu_free_memory_caches(struct kvm_vcpu *vcpu);
 void kvm_trap_emul_invalidate_gva(struct kvm_vcpu *vcpu, unsigned long addr,
 				  bool user);
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 4dc6cf2b7c50..90c28fbf4829 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -22,6 +22,7 @@
 #include <asm/page.h>
 #include <asm/cacheflush.h>
 #include <asm/mmu_context.h>
+#include <asm/pgalloc.h>
 #include <asm/pgtable.h>
 
 #include <linux/kvm_host.h>
@@ -94,6 +95,11 @@ void kvm_arch_check_processor_compat(void *rtn)
 
 int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 {
+	/* Allocate page table to map GPA -> RPA */
+	kvm->arch.gpa_mm.pgd = kvm_pgd_alloc();
+	if (!kvm->arch.gpa_mm.pgd)
+		return -ENOMEM;
+
 	return 0;
 }
 
@@ -112,13 +118,6 @@ void kvm_mips_free_vcpus(struct kvm *kvm)
 	unsigned int i;
 	struct kvm_vcpu *vcpu;
 
-	/* Put the pages we reserved for the guest pmap */
-	for (i = 0; i < kvm->arch.guest_pmap_npages; i++) {
-		if (kvm->arch.guest_pmap[i] != KVM_INVALID_PAGE)
-			kvm_release_pfn_clean(kvm->arch.guest_pmap[i]);
-	}
-	kfree(kvm->arch.guest_pmap);
-
 	kvm_for_each_vcpu(i, vcpu, kvm) {
 		kvm_arch_vcpu_free(vcpu);
 	}
@@ -133,9 +132,17 @@ void kvm_mips_free_vcpus(struct kvm *kvm)
 	mutex_unlock(&kvm->lock);
 }
 
+static void kvm_mips_free_gpa_pt(struct kvm *kvm)
+{
+	/* It should always be safe to remove after flushing the whole range */
+	WARN_ON(!kvm_mips_flush_gpa_pt(kvm, 0, ~0));
+	pgd_free(NULL, kvm->arch.gpa_mm.pgd);
+}
+
 void kvm_arch_destroy_vm(struct kvm *kvm)
 {
 	kvm_mips_free_vcpus(kvm);
+	kvm_mips_free_gpa_pt(kvm);
 }
 
 long kvm_arch_dev_ioctl(struct file *filp, unsigned int ioctl,
@@ -164,36 +171,9 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 				   const struct kvm_memory_slot *new,
 				   enum kvm_mr_change change)
 {
-	unsigned long npages = 0;
-	int i;
-
 	kvm_debug("%s: kvm: %p slot: %d, GPA: %llx, size: %llx, QVA: %llx\n",
 		  __func__, kvm, mem->slot, mem->guest_phys_addr,
 		  mem->memory_size, mem->userspace_addr);
-
-	/* Setup Guest PMAP table */
-	if (!kvm->arch.guest_pmap) {
-		if (mem->slot == 0)
-			npages = mem->memory_size >> PAGE_SHIFT;
-
-		if (npages) {
-			kvm->arch.guest_pmap_npages = npages;
-			kvm->arch.guest_pmap =
-			    kzalloc(npages * sizeof(unsigned long), GFP_KERNEL);
-
-			if (!kvm->arch.guest_pmap) {
-				kvm_err("Failed to allocate guest PMAP\n");
-				return;
-			}
-
-			kvm_debug("Allocated space for Guest PMAP Table (%ld pages) @ %p\n",
-				  npages, kvm->arch.guest_pmap);
-
-			/* Now setup the page table */
-			for (i = 0; i < npages; i++)
-				kvm->arch.guest_pmap[i] = KVM_INVALID_PAGE;
-		}
-	}
 }
 
 static inline void dump_handler(const char *symbol, void *start, void *end)
diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index 6379ac1bc7b9..09f5da706d9a 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -63,6 +63,63 @@ void kvm_mmu_free_memory_caches(struct kvm_vcpu *vcpu)
 }
 
 /**
+ * kvm_pgd_init() - Initialise KVM GPA page directory.
+ * @page:	Pointer to page directory (PGD) for KVM GPA.
+ *
+ * Initialise a KVM GPA page directory with pointers to the invalid table, i.e.
+ * representing no mappings. This is similar to pgd_init(), however it
+ * initialises all the page directory pointers, not just the ones corresponding
+ * to the userland address space (since it is for the guest physical address
+ * space rather than a virtual address space).
+ */
+static void kvm_pgd_init(void *page)
+{
+	unsigned long *p, *end;
+	unsigned long entry;
+
+#ifdef __PAGETABLE_PMD_FOLDED
+	entry = (unsigned long)invalid_pte_table;
+#else
+	entry = (unsigned long)invalid_pmd_table;
+#endif
+
+	p = (unsigned long *)page;
+	end = p + PTRS_PER_PGD;
+
+	do {
+		p[0] = entry;
+		p[1] = entry;
+		p[2] = entry;
+		p[3] = entry;
+		p[4] = entry;
+		p += 8;
+		p[-3] = entry;
+		p[-2] = entry;
+		p[-1] = entry;
+	} while (p != end);
+}
+
+/**
+ * kvm_pgd_alloc() - Allocate and initialise a KVM GPA page directory.
+ *
+ * Allocate a blank KVM GPA page directory (PGD) for representing guest physical
+ * to host physical page mappings.
+ *
+ * Returns:	Pointer to new KVM GPA page directory.
+ *		NULL on allocation failure.
+ */
+pgd_t *kvm_pgd_alloc(void)
+{
+	pgd_t *ret;
+
+	ret = (pgd_t *)__get_free_pages(GFP_KERNEL, PGD_ORDER);
+	if (ret)
+		kvm_pgd_init(ret);
+
+	return ret;
+}
+
+/**
  * kvm_mips_walk_pgd() - Walk page table with optional allocation.
  * @pgd:	Page directory pointer.
  * @addr:	Address to index page table using.
@@ -112,15 +169,182 @@ static pte_t *kvm_mips_walk_pgd(pgd_t *pgd, struct kvm_mmu_memory_cache *cache,
 	return pte_offset(pmd, addr);
 }
 
-static int kvm_mips_map_page(struct kvm *kvm, gfn_t gfn)
+/* Caller must hold kvm->mm_lock */
+static pte_t *kvm_mips_pte_for_gpa(struct kvm *kvm,
+				   struct kvm_mmu_memory_cache *cache,
+				   unsigned long addr)
 {
-	int srcu_idx, err = 0;
-	kvm_pfn_t pfn;
+	return kvm_mips_walk_pgd(kvm->arch.gpa_mm.pgd, cache, addr);
+}
 
-	if (kvm->arch.guest_pmap[gfn] != KVM_INVALID_PAGE)
-		return 0;
+/*
+ * kvm_mips_flush_gpa_{pte,pmd,pud,pgd,pt}.
+ * Flush a range of guest physical address space from the VM's GPA page tables.
+ */
+
+static bool kvm_mips_flush_gpa_pte(pte_t *pte, unsigned long start_gpa,
+				   unsigned long end_gpa)
+{
+	int i_min = __pte_offset(start_gpa);
+	int i_max = __pte_offset(end_gpa);
+	bool safe_to_remove = (i_min == 0 && i_max == PTRS_PER_PTE - 1);
+	int i;
+
+	for (i = i_min; i <= i_max; ++i) {
+		if (!pte_present(pte[i]))
+			continue;
+
+		kvm_release_pfn_clean(pte_pfn(pte[i]));
+		set_pte(pte + i, __pte(0));
+	}
+	return safe_to_remove;
+}
+
+static bool kvm_mips_flush_gpa_pmd(pmd_t *pmd, unsigned long start_gpa,
+				   unsigned long end_gpa)
+{
+	pte_t *pte;
+	unsigned long end = ~0ul;
+	int i_min = __pmd_offset(start_gpa);
+	int i_max = __pmd_offset(end_gpa);
+	bool safe_to_remove = (i_min == 0 && i_max == PTRS_PER_PMD - 1);
+	int i;
+
+	for (i = i_min; i <= i_max; ++i, start_gpa = 0) {
+		if (!pmd_present(pmd[i]))
+			continue;
+
+		pte = pte_offset(pmd + i, 0);
+		if (i == i_max)
+			end = end_gpa;
+
+		if (kvm_mips_flush_gpa_pte(pte, start_gpa, end)) {
+			pmd_clear(pmd + i);
+			pte_free_kernel(NULL, pte);
+		} else {
+			safe_to_remove = false;
+		}
+	}
+	return safe_to_remove;
+}
+
+static bool kvm_mips_flush_gpa_pud(pud_t *pud, unsigned long start_gpa,
+				   unsigned long end_gpa)
+{
+	pmd_t *pmd;
+	unsigned long end = ~0ul;
+	int i_min = __pud_offset(start_gpa);
+	int i_max = __pud_offset(end_gpa);
+	bool safe_to_remove = (i_min == 0 && i_max == PTRS_PER_PUD - 1);
+	int i;
+
+	for (i = i_min; i <= i_max; ++i, start_gpa = 0) {
+		if (!pud_present(pud[i]))
+			continue;
+
+		pmd = pmd_offset(pud + i, 0);
+		if (i == i_max)
+			end = end_gpa;
+
+		if (kvm_mips_flush_gpa_pmd(pmd, start_gpa, end)) {
+			pud_clear(pud + i);
+			pmd_free(NULL, pmd);
+		} else {
+			safe_to_remove = false;
+		}
+	}
+	return safe_to_remove;
+}
+
+static bool kvm_mips_flush_gpa_pgd(pgd_t *pgd, unsigned long start_gpa,
+				   unsigned long end_gpa)
+{
+	pud_t *pud;
+	unsigned long end = ~0ul;
+	int i_min = pgd_index(start_gpa);
+	int i_max = pgd_index(end_gpa);
+	bool safe_to_remove = (i_min == 0 && i_max == PTRS_PER_PGD - 1);
+	int i;
+
+	for (i = i_min; i <= i_max; ++i, start_gpa = 0) {
+		if (!pgd_present(pgd[i]))
+			continue;
+
+		pud = pud_offset(pgd + i, 0);
+		if (i == i_max)
+			end = end_gpa;
+
+		if (kvm_mips_flush_gpa_pud(pud, start_gpa, end)) {
+			pgd_clear(pgd + i);
+			pud_free(NULL, pud);
+		} else {
+			safe_to_remove = false;
+		}
+	}
+	return safe_to_remove;
+}
+
+/**
+ * kvm_mips_flush_gpa_pt() - Flush a range of guest physical addresses.
+ * @kvm:	KVM pointer.
+ * @start_gfn:	Guest frame number of first page in GPA range to flush.
+ * @end_gfn:	Guest frame number of last page in GPA range to flush.
+ *
+ * Flushes a range of GPA mappings from the GPA page tables.
+ *
+ * The caller must hold the @kvm->mmu_lock spinlock.
+ *
+ * Returns:	Whether its safe to remove the top level page directory because
+ *		all lower levels have been removed.
+ */
+bool kvm_mips_flush_gpa_pt(struct kvm *kvm, gfn_t start_gfn, gfn_t end_gfn)
+{
+	return kvm_mips_flush_gpa_pgd(kvm->arch.gpa_mm.pgd,
+				      start_gfn << PAGE_SHIFT,
+				      end_gfn << PAGE_SHIFT);
+}
+
+/**
+ * kvm_mips_map_page() - Map a guest physical page.
+ * @vcpu:		VCPU pointer.
+ * @gpa:		Guest physical address of fault.
+ * @out_entry:		New PTE for @gpa (written on success unless NULL).
+ * @out_buddy:		New PTE for @gpa's buddy (written on success unless
+ *			NULL).
+ *
+ * Handle GPA faults by creating a new GPA mapping (or updating an existing
+ * one).
+ *
+ * This takes care of asking KVM for the corresponding PFN, and creating a
+ * mapping in the GPA page tables. Derived mappings (GVA page tables and TLBs)
+ * must be handled by the caller.
+ *
+ * Returns:	0 on success, in which case the caller may use the @out_entry
+ *		and @out_buddy PTEs to update derived mappings and resume guest
+ *		execution.
+ *		-EFAULT if there is no memory region at @gpa or a write was
+ *		attempted to a read-only memory region. This is usually handled
+ *		as an MMIO access.
+ */
+static int kvm_mips_map_page(struct kvm_vcpu *vcpu, unsigned long gpa,
+			     pte_t *out_entry, pte_t *out_buddy)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_mmu_memory_cache *memcache = &vcpu->arch.mmu_page_cache;
+	gfn_t gfn = gpa >> PAGE_SHIFT;
+	int srcu_idx, err;
+	kvm_pfn_t pfn;
+	pte_t *ptep, entry, old_pte;
+	unsigned long prot_bits;
 
 	srcu_idx = srcu_read_lock(&kvm->srcu);
+
+	/* We need a minimum of cached pages ready for page table creation */
+	err = mmu_topup_memory_cache(memcache, KVM_MMU_CACHE_MIN_PAGES,
+				     KVM_NR_MEM_OBJS);
+	if (err)
+		goto out;
+
 	pfn = gfn_to_pfn(kvm, gfn);
 
 	if (is_error_noslot_pfn(pfn)) {
@@ -129,7 +353,25 @@ static int kvm_mips_map_page(struct kvm *kvm, gfn_t gfn)
 		goto out;
 	}
 
-	kvm->arch.guest_pmap[gfn] = pfn;
+	spin_lock(&kvm->mmu_lock);
+
+	ptep = kvm_mips_pte_for_gpa(kvm, memcache, gpa);
+
+	prot_bits = __READABLE | _PAGE_PRESENT | __WRITEABLE;
+	entry = pfn_pte(pfn, __pgprot(prot_bits));
+
+	old_pte = *ptep;
+	set_pte(ptep, entry);
+	if (pte_present(old_pte))
+		kvm_release_pfn_clean(pte_pfn(old_pte));
+
+	err = 0;
+	if (out_entry)
+		*out_entry = *ptep;
+	if (out_buddy)
+		*out_buddy = *ptep_buddy(ptep);
+
+	spin_unlock(&kvm->mmu_lock);
 out:
 	srcu_read_unlock(&kvm->srcu, srcu_idx);
 	return err;
@@ -318,11 +560,10 @@ void kvm_mips_flush_gva_pt(pgd_t *pgd, enum kvm_mips_flush flags)
 int kvm_mips_handle_kseg0_tlb_fault(unsigned long badvaddr,
 				    struct kvm_vcpu *vcpu)
 {
-	gfn_t gfn;
+	unsigned long gpa;
 	kvm_pfn_t pfn0, pfn1;
-	unsigned long vaddr = 0;
-	struct kvm *kvm = vcpu->kvm;
-	pte_t *ptep_gva;
+	unsigned long vaddr;
+	pte_t pte_gpa[2], *ptep_gva;
 
 	if (KVM_GUEST_KSEGX(badvaddr) != KVM_GUEST_KSEG0) {
 		kvm_err("%s: Invalid BadVaddr: %#lx\n", __func__, badvaddr);
@@ -332,23 +573,17 @@ int kvm_mips_handle_kseg0_tlb_fault(unsigned long badvaddr,
 
 	/* Find host PFNs */
 
-	gfn = (KVM_GUEST_CPHYSADDR(badvaddr) >> PAGE_SHIFT);
-	if ((gfn | 1) >= kvm->arch.guest_pmap_npages) {
-		kvm_err("%s: Invalid gfn: %#llx, BadVaddr: %#lx\n", __func__,
-			gfn, badvaddr);
-		kvm_mips_dump_host_tlbs();
-		return -1;
-	}
+	gpa = KVM_GUEST_CPHYSADDR(badvaddr & (PAGE_MASK << 1));
 	vaddr = badvaddr & (PAGE_MASK << 1);
 
-	if (kvm_mips_map_page(vcpu->kvm, gfn) < 0)
+	if (kvm_mips_map_page(vcpu, gpa, &pte_gpa[0], NULL) < 0)
 		return -1;
 
-	if (kvm_mips_map_page(vcpu->kvm, gfn ^ 0x1) < 0)
+	if (kvm_mips_map_page(vcpu, gpa | PAGE_SIZE, &pte_gpa[1], NULL) < 0)
 		return -1;
 
-	pfn0 = kvm->arch.guest_pmap[gfn & ~0x1];
-	pfn1 = kvm->arch.guest_pmap[gfn | 0x1];
+	pfn0 = pte_pfn(pte_gpa[0]);
+	pfn1 = pte_pfn(pte_gpa[1]);
 
 	/* Find GVA page table entry */
 
@@ -371,11 +606,9 @@ int kvm_mips_handle_mapped_seg_tlb_fault(struct kvm_vcpu *vcpu,
 					 struct kvm_mips_tlb *tlb,
 					 unsigned long gva)
 {
-	struct kvm *kvm = vcpu->kvm;
 	kvm_pfn_t pfn;
-	gfn_t gfn;
 	long tlb_lo = 0;
-	pte_t *ptep_gva;
+	pte_t pte_gpa, *ptep_gva;
 	unsigned int idx;
 	bool kernel = KVM_GUEST_KERNEL_MODE(vcpu);
 
@@ -388,16 +621,10 @@ int kvm_mips_handle_mapped_seg_tlb_fault(struct kvm_vcpu *vcpu,
 		tlb_lo = tlb->tlb_lo[idx];
 
 	/* Find host PFN */
-	gfn = mips3_tlbpfn_to_paddr(tlb_lo) >> PAGE_SHIFT;
-	if (gfn >= kvm->arch.guest_pmap_npages) {
-		kvm_err("%s: Invalid gfn: %#llx, EHi: %#lx\n",
-			__func__, gfn, tlb->tlb_hi);
-		kvm_mips_dump_guest_tlbs(vcpu);
-		return -1;
-	}
-	if (kvm_mips_map_page(kvm, gfn) < 0)
+	if (kvm_mips_map_page(vcpu, mips3_tlbpfn_to_paddr(tlb_lo), &pte_gpa,
+			      NULL) < 0)
 		return -1;
-	pfn = kvm->arch.guest_pmap[gfn];
+	pfn = pte_pfn(pte_gpa);
 
 	/* Find GVA page table entry */
 	ptep_gva = kvm_trap_emul_pte_for_gva(vcpu, gva);
-- 
git-series 0.8.10
