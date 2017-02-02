Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Feb 2017 13:46:05 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:25077 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993900AbdBBMp6BnadS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Feb 2017 13:45:58 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id C7F2247F23B97;
        Thu,  2 Feb 2017 12:45:47 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 2 Feb 2017 12:45:50 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH v2 12/13] KVM: MIPS/MMU: Implement KVM_CAP_SYNC_MMU
Date:   Thu, 2 Feb 2017 12:45:33 +0000
Message-ID: <20170202124533.32312-1-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <c5c854a71ada1d4ef812d7b4cb0a81bde0a22faa.1484570878.git-series.james.hogan@imgtec.com>
References: <c5c854a71ada1d4ef812d7b4cb0a81bde0a22faa.1484570878.git-series.james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56620
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

Implement the SYNC_MMU capability for KVM MIPS, allowing changes in the
underlying user host virtual address (HVA) mappings to be promptly
reflected in the corresponding guest physical address (GPA) mappings.

This allows for several features to work with guest RAM which require
mappings to be altered or protected, such as copy-on-write, KSM (Kernel
Samepage Merging), idle page tracking, memory swapping, and guest memory
ballooning.

There are two main aspects of this change, described below.

The KVM MMU notifier architecture callbacks are implemented so we can be
notified of changes in the HVA mappings. These arrange for the guest
physical address (GPA) page tables to be modified and possibly for
derived mappings (GVA page tables and TLBs) to be flushed.

 - kvm_unmap_hva[_range]() - These deal with HVA mappings being removed,
   for example before a copy-on-write takes place, which requires the
   corresponding GPA page table mappings to be removed too.

 - kvm_set_spte_hva() - These update a GPA page table entry to match the
   new HVA entry, but must be careful to respect KVM specific
   configuration such as not dirtying a clean guest page which is dirty
   to the host, and write protecting writable pages in read only
   memslots (which will soon be supported).

 - kvm[_test]_age_hva() - These update GPA page table entries to be old
   (invalid) so that access can be tracked, making them young again.

The GPA page fault handling (kvm_mips_map_page) is updated to use
gfn_to_pfn_prot() (which may provide read-only pages), to handle
asynchronous page table invalidation from MMU notifier callbacks, and to
handle more cases in the fast path.

 - mmu_notifier_seq is used to detect asynchronous page table
   invalidations while we're holding a pfn from gfn_to_pfn_prot()
   outside of kvm->mmu_lock, retrying if invalidations have taken place,
   e.g. a COW or a KSM page merge.

 - The fast path (_kvm_mips_map_page_fast) now handles marking old pages
   as young / accessed, and disallowing dirtying of clean pages that
   aren't actually writable (e.g. shared pages that should COW, and
   read-only memory regions when they are enabled in a future patch).

 - Due to the use of MMU notifications we no longer need to keep the
   page references after we've updated the GPA page tables.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
Changes in v2:
- Silence bogus GCC 4.9 warning by initialising pfn to 0:

  arch/mips/kvm/mmu.c In function ‘kvm_mips_map_page’:
  arch/mips/kvm/mmu.c +667 :3: error: ‘pfn’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
     kvm_set_pfn_accessed(pfn);
     ^
  arch/mips/kvm/mmu.c +626 :12: note: ‘pfn’ was declared here
    kvm_pfn_t pfn;
              ^
---
 arch/mips/include/asm/kvm_host.h |  13 ++-
 arch/mips/kvm/Kconfig            |   1 +-
 arch/mips/kvm/mips.c             |   1 +-
 arch/mips/kvm/mmu.c              | 235 +++++++++++++++++++++++++++++---
 4 files changed, 233 insertions(+), 17 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index a7394940119c..718dfffa17d5 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -663,6 +663,19 @@ enum kvm_mips_fault_result kvm_trap_emul_gva_fault(struct kvm_vcpu *vcpu,
 						   unsigned long gva,
 						   bool write);
 
+#define KVM_ARCH_WANT_MMU_NOTIFIER
+int kvm_unmap_hva(struct kvm *kvm, unsigned long hva);
+int kvm_unmap_hva_range(struct kvm *kvm,
+			unsigned long start, unsigned long end);
+void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
+int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end);
+int kvm_test_age_hva(struct kvm *kvm, unsigned long hva);
+
+static inline void kvm_arch_mmu_notifier_invalidate_page(struct kvm *kvm,
+							 unsigned long address)
+{
+}
+
 /* Emulation */
 int kvm_get_inst(u32 *opc, struct kvm_vcpu *vcpu, u32 *out);
 enum emulation_result update_pc(struct kvm_vcpu *vcpu, u32 cause);
diff --git a/arch/mips/kvm/Kconfig b/arch/mips/kvm/Kconfig
index 85c4593b634a..65067327db12 100644
--- a/arch/mips/kvm/Kconfig
+++ b/arch/mips/kvm/Kconfig
@@ -22,6 +22,7 @@ config KVM
 	select ANON_INODES
 	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
 	select KVM_MMIO
+	select MMU_NOTIFIER
 	select SRCU
 	---help---
 	  Support for hosting Guest kernels.
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 5b7e9a053f77..425e4139742c 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -1222,6 +1222,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	switch (ext) {
 	case KVM_CAP_ONE_REG:
 	case KVM_CAP_ENABLE_CAP:
+	case KVM_CAP_SYNC_MMU:
 		r = 1;
 		break;
 	case KVM_CAP_COALESCED_MMIO:
diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index 8a01bbd276fc..cb0faade311e 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -194,7 +194,6 @@ static bool kvm_mips_flush_gpa_pte(pte_t *pte, unsigned long start_gpa,
 		if (!pte_present(pte[i]))
 			continue;
 
-		kvm_release_pfn_clean(pte_pfn(pte[i]));
 		set_pte(pte + i, __pte(0));
 	}
 	return safe_to_remove;
@@ -450,6 +449,155 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
 	kvm_mips_mkclean_gpa_pt(kvm, start, end);
 }
 
+/*
+ * kvm_mips_mkold_gpa_pt.
+ * Mark a range of guest physical address space old (all accesses fault) in the
+ * VM's GPA page table to allow detection of commonly used pages.
+ */
+
+BUILD_PTE_RANGE_OP(mkold, pte_mkold)
+
+static int kvm_mips_mkold_gpa_pt(struct kvm *kvm, gfn_t start_gfn,
+				 gfn_t end_gfn)
+{
+	return kvm_mips_mkold_pgd(kvm->arch.gpa_mm.pgd,
+				  start_gfn << PAGE_SHIFT,
+				  end_gfn << PAGE_SHIFT);
+}
+
+static int handle_hva_to_gpa(struct kvm *kvm,
+			     unsigned long start,
+			     unsigned long end,
+			     int (*handler)(struct kvm *kvm, gfn_t gfn,
+					    gpa_t gfn_end,
+					    struct kvm_memory_slot *memslot,
+					    void *data),
+			     void *data)
+{
+	struct kvm_memslots *slots;
+	struct kvm_memory_slot *memslot;
+	int ret = 0;
+
+	slots = kvm_memslots(kvm);
+
+	/* we only care about the pages that the guest sees */
+	kvm_for_each_memslot(memslot, slots) {
+		unsigned long hva_start, hva_end;
+		gfn_t gfn, gfn_end;
+
+		hva_start = max(start, memslot->userspace_addr);
+		hva_end = min(end, memslot->userspace_addr +
+					(memslot->npages << PAGE_SHIFT));
+		if (hva_start >= hva_end)
+			continue;
+
+		/*
+		 * {gfn(page) | page intersects with [hva_start, hva_end)} =
+		 * {gfn_start, gfn_start+1, ..., gfn_end-1}.
+		 */
+		gfn = hva_to_gfn_memslot(hva_start, memslot);
+		gfn_end = hva_to_gfn_memslot(hva_end + PAGE_SIZE - 1, memslot);
+
+		ret |= handler(kvm, gfn, gfn_end, memslot, data);
+	}
+
+	return ret;
+}
+
+
+static int kvm_unmap_hva_handler(struct kvm *kvm, gfn_t gfn, gfn_t gfn_end,
+				 struct kvm_memory_slot *memslot, void *data)
+{
+	kvm_mips_flush_gpa_pt(kvm, gfn, gfn_end);
+	return 1;
+}
+
+int kvm_unmap_hva(struct kvm *kvm, unsigned long hva)
+{
+	unsigned long end = hva + PAGE_SIZE;
+
+	handle_hva_to_gpa(kvm, hva, end, &kvm_unmap_hva_handler, NULL);
+
+	kvm_mips_callbacks->flush_shadow_all(kvm);
+	return 0;
+}
+
+int kvm_unmap_hva_range(struct kvm *kvm, unsigned long start, unsigned long end)
+{
+	handle_hva_to_gpa(kvm, start, end, &kvm_unmap_hva_handler, NULL);
+
+	kvm_mips_callbacks->flush_shadow_all(kvm);
+	return 0;
+}
+
+static int kvm_set_spte_handler(struct kvm *kvm, gfn_t gfn, gfn_t gfn_end,
+				struct kvm_memory_slot *memslot, void *data)
+{
+	gpa_t gpa = gfn << PAGE_SHIFT;
+	pte_t hva_pte = *(pte_t *)data;
+	pte_t *gpa_pte = kvm_mips_pte_for_gpa(kvm, NULL, gpa);
+	pte_t old_pte;
+
+	if (!gpa_pte)
+		return 0;
+
+	/* Mapping may need adjusting depending on memslot flags */
+	old_pte = *gpa_pte;
+	if (memslot->flags & KVM_MEM_LOG_DIRTY_PAGES && !pte_dirty(old_pte))
+		hva_pte = pte_mkclean(hva_pte);
+	else if (memslot->flags & KVM_MEM_READONLY)
+		hva_pte = pte_wrprotect(hva_pte);
+
+	set_pte(gpa_pte, hva_pte);
+
+	/* Replacing an absent or old page doesn't need flushes */
+	if (!pte_present(old_pte) || !pte_young(old_pte))
+		return 0;
+
+	/* Pages swapped, aged, moved, or cleaned require flushes */
+	return !pte_present(hva_pte) ||
+	       !pte_young(hva_pte) ||
+	       pte_pfn(old_pte) != pte_pfn(hva_pte) ||
+	       (pte_dirty(old_pte) && !pte_dirty(hva_pte));
+}
+
+void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
+{
+	unsigned long end = hva + PAGE_SIZE;
+	int ret;
+
+	ret = handle_hva_to_gpa(kvm, hva, end, &kvm_set_spte_handler, &pte);
+	if (ret)
+		kvm_mips_callbacks->flush_shadow_all(kvm);
+}
+
+static int kvm_age_hva_handler(struct kvm *kvm, gfn_t gfn, gfn_t gfn_end,
+			       struct kvm_memory_slot *memslot, void *data)
+{
+	return kvm_mips_mkold_gpa_pt(kvm, gfn, gfn_end);
+}
+
+static int kvm_test_age_hva_handler(struct kvm *kvm, gfn_t gfn, gfn_t gfn_end,
+				    struct kvm_memory_slot *memslot, void *data)
+{
+	gpa_t gpa = gfn << PAGE_SHIFT;
+	pte_t *gpa_pte = kvm_mips_pte_for_gpa(kvm, NULL, gpa);
+
+	if (!gpa_pte)
+		return 0;
+	return pte_young(*gpa_pte);
+}
+
+int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end)
+{
+	return handle_hva_to_gpa(kvm, start, end, kvm_age_hva_handler, NULL);
+}
+
+int kvm_test_age_hva(struct kvm *kvm, unsigned long hva)
+{
+	return handle_hva_to_gpa(kvm, hva, hva, kvm_test_age_hva_handler, NULL);
+}
+
 /**
  * _kvm_mips_map_page_fast() - Fast path GPA fault handler.
  * @vcpu:		VCPU pointer.
@@ -460,8 +608,8 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
  *			NULL).
  *
  * Perform fast path GPA fault handling, doing all that can be done without
- * calling into KVM. This handles dirtying of clean pages (for dirty page
- * logging).
+ * calling into KVM. This handles marking old pages young (for idle page
+ * tracking), and dirtying of clean pages (for dirty page logging).
  *
  * Returns:	0 on success, in which case we can update derived mappings and
  *		resume guest execution.
@@ -475,6 +623,8 @@ static int _kvm_mips_map_page_fast(struct kvm_vcpu *vcpu, unsigned long gpa,
 	struct kvm *kvm = vcpu->kvm;
 	gfn_t gfn = gpa >> PAGE_SHIFT;
 	pte_t *ptep;
+	kvm_pfn_t pfn = 0;	/* silence bogus GCC warning */
+	bool pfn_valid = false;
 	int ret = 0;
 
 	spin_lock(&kvm->mmu_lock);
@@ -486,10 +636,24 @@ static int _kvm_mips_map_page_fast(struct kvm_vcpu *vcpu, unsigned long gpa,
 		goto out;
 	}
 
+	/* Track access to pages marked old */
+	if (!pte_young(*ptep)) {
+		set_pte(ptep, pte_mkyoung(*ptep));
+		pfn = pte_pfn(*ptep);
+		pfn_valid = true;
+		/* call kvm_set_pfn_accessed() after unlock */
+	}
 	if (write_fault && !pte_dirty(*ptep)) {
-		/* Track dirtying of pages */
+		if (!pte_write(*ptep)) {
+			ret = -EFAULT;
+			goto out;
+		}
+
+		/* Track dirtying of writeable pages */
 		set_pte(ptep, pte_mkdirty(*ptep));
+		pfn = pte_pfn(*ptep);
 		mark_page_dirty(kvm, gfn);
+		kvm_set_pfn_dirty(pfn);
 	}
 
 	if (out_entry)
@@ -499,6 +663,8 @@ static int _kvm_mips_map_page_fast(struct kvm_vcpu *vcpu, unsigned long gpa,
 
 out:
 	spin_unlock(&kvm->mmu_lock);
+	if (pfn_valid)
+		kvm_set_pfn_accessed(pfn);
 	return ret;
 }
 
@@ -514,9 +680,10 @@ static int _kvm_mips_map_page_fast(struct kvm_vcpu *vcpu, unsigned long gpa,
  * Handle GPA faults by creating a new GPA mapping (or updating an existing
  * one).
  *
- * This takes care of marking pages dirty (dirty page tracking), asking KVM for
- * the corresponding PFN, and creating a mapping in the GPA page tables. Derived
- * mappings (GVA page tables and TLBs) must be handled by the caller.
+ * This takes care of marking pages young or dirty (idle/dirty page tracking),
+ * asking KVM for the corresponding PFN, and creating a mapping in the GPA page
+ * tables. Derived mappings (GVA page tables and TLBs) must be handled by the
+ * caller.
  *
  * Returns:	0 on success, in which case the caller may use the @out_entry
  *		and @out_buddy PTEs to update derived mappings and resume guest
@@ -535,9 +702,11 @@ static int kvm_mips_map_page(struct kvm_vcpu *vcpu, unsigned long gpa,
 	int srcu_idx, err;
 	kvm_pfn_t pfn;
 	pte_t *ptep, entry, old_pte;
+	bool writeable;
 	unsigned long prot_bits;
+	unsigned long mmu_seq;
 
-	/* Try the fast path to handle clean pages */
+	/* Try the fast path to handle old / clean pages */
 	srcu_idx = srcu_read_lock(&kvm->srcu);
 	err = _kvm_mips_map_page_fast(vcpu, gpa, write_fault, out_entry,
 				      out_buddy);
@@ -550,33 +719,63 @@ static int kvm_mips_map_page(struct kvm_vcpu *vcpu, unsigned long gpa,
 	if (err)
 		goto out;
 
-	/* Slow path - ask KVM core whether we can access this GPA */
-	pfn = gfn_to_pfn(kvm, gfn);
+retry:
+	/*
+	 * Used to check for invalidations in progress, of the pfn that is
+	 * returned by pfn_to_pfn_prot below.
+	 */
+	mmu_seq = kvm->mmu_notifier_seq;
+	/*
+	 * Ensure the read of mmu_notifier_seq isn't reordered with PTE reads in
+	 * gfn_to_pfn_prot() (which calls get_user_pages()), so that we don't
+	 * risk the page we get a reference to getting unmapped before we have a
+	 * chance to grab the mmu_lock without mmu_notifier_retry() noticing.
+	 *
+	 * This smp_rmb() pairs with the effective smp_wmb() of the combination
+	 * of the pte_unmap_unlock() after the PTE is zapped, and the
+	 * spin_lock() in kvm_mmu_notifier_invalidate_<page|range_end>() before
+	 * mmu_notifier_seq is incremented.
+	 */
+	smp_rmb();
 
+	/* Slow path - ask KVM core whether we can access this GPA */
+	pfn = gfn_to_pfn_prot(kvm, gfn, write_fault, &writeable);
 	if (is_error_noslot_pfn(pfn)) {
 		err = -EFAULT;
 		goto out;
 	}
 
 	spin_lock(&kvm->mmu_lock);
+	/* Check if an invalidation has taken place since we got pfn */
+	if (mmu_notifier_retry(kvm, mmu_seq)) {
+		/*
+		 * This can happen when mappings are changed asynchronously, but
+		 * also synchronously if a COW is triggered by
+		 * gfn_to_pfn_prot().
+		 */
+		spin_unlock(&kvm->mmu_lock);
+		kvm_release_pfn_clean(pfn);
+		goto retry;
+	}
 
 	/* Ensure page tables are allocated */
 	ptep = kvm_mips_pte_for_gpa(kvm, memcache, gpa);
 
 	/* Set up the PTE */
-	prot_bits = __READABLE | _PAGE_PRESENT | _PAGE_WRITE |
-		_page_cachable_default;
-	if (write_fault) {
-		prot_bits |= __WRITEABLE;
-		mark_page_dirty(kvm, gfn);
+	prot_bits = _PAGE_PRESENT | __READABLE | _page_cachable_default;
+	if (writeable) {
+		prot_bits |= _PAGE_WRITE;
+		if (write_fault) {
+			prot_bits |= __WRITEABLE;
+			mark_page_dirty(kvm, gfn);
+			kvm_set_pfn_dirty(pfn);
+		}
 	}
 	entry = pfn_pte(pfn, __pgprot(prot_bits));
 
 	/* Write the PTE */
 	old_pte = *ptep;
 	set_pte(ptep, entry);
-	if (pte_present(old_pte))
-		kvm_release_pfn_clean(pte_pfn(old_pte));
 
 	err = 0;
 	if (out_entry)
@@ -585,6 +784,8 @@ static int kvm_mips_map_page(struct kvm_vcpu *vcpu, unsigned long gpa,
 		*out_buddy = *ptep_buddy(ptep);
 
 	spin_unlock(&kvm->mmu_lock);
+	kvm_release_pfn_clean(pfn);
+	kvm_set_pfn_accessed(pfn);
 out:
 	srcu_read_unlock(&kvm->srcu, srcu_idx);
 	return err;
-- 
git-series 0.8.10
