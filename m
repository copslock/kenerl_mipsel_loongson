Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jan 2017 13:53:31 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:48028 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990508AbdAPMtzgvr7k (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Jan 2017 13:49:55 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 8EFC0361AF4EC;
        Mon, 16 Jan 2017 12:49:45 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 16 Jan 2017 12:49:48 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 9/13] KVM: MIPS/MMU: Handle dirty logging on GPA faults
Date:   Mon, 16 Jan 2017 12:49:30 +0000
Message-ID: <0e5f023d936dcb93600708ebb655673943f38f70.1484570878.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
In-Reply-To: <cover.99eec1b2ac935212acbcf2effacaab95cf6cdbf1.1484570878.git-series.james.hogan@imgtec.com>
References: <cover.99eec1b2ac935212acbcf2effacaab95cf6cdbf1.1484570878.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56328
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

Update kvm_mips_map_page() to handle logging of dirty guest physical
pages. Upcoming patches will propagate the dirty bit to the GVA page
tables.

A fast path is added for handling protection bits that can be resolved
without calling into KVM, currently just dirtying of clean pages being
written to.

The slow path marks the GPA page table entry writable only on writes,
and at the same time marks the page dirty in the dirty page logging
bitmask.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/mmu.c | 74 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 70 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index 63a6d542ecb3..7962eea4ebc3 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -451,6 +451,58 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
 }
 
 /**
+ * _kvm_mips_map_page_fast() - Fast path GPA fault handler.
+ * @vcpu:		VCPU pointer.
+ * @gpa:		Guest physical address of fault.
+ * @write_fault:	Whether the fault was due to a write.
+ * @out_entry:		New PTE for @gpa (written on success unless NULL).
+ * @out_buddy:		New PTE for @gpa's buddy (written on success unless
+ *			NULL).
+ *
+ * Perform fast path GPA fault handling, doing all that can be done without
+ * calling into KVM. This handles dirtying of clean pages (for dirty page
+ * logging).
+ *
+ * Returns:	0 on success, in which case we can update derived mappings and
+ *		resume guest execution.
+ *		-EFAULT on failure due to absent GPA mapping or write to
+ *		read-only page, in which case KVM must be consulted.
+ */
+static int _kvm_mips_map_page_fast(struct kvm_vcpu *vcpu, unsigned long gpa,
+				   bool write_fault,
+				   pte_t *out_entry, pte_t *out_buddy)
+{
+	struct kvm *kvm = vcpu->kvm;
+	gfn_t gfn = gpa >> PAGE_SHIFT;
+	pte_t *ptep;
+	int ret = 0;
+
+	spin_lock(&kvm->mmu_lock);
+
+	/* Fast path - just check GPA page table for an existing entry */
+	ptep = kvm_mips_pte_for_gpa(kvm, NULL, gpa);
+	if (!ptep || !pte_present(*ptep)) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	if (write_fault && !pte_dirty(*ptep)) {
+		/* Track dirtying of pages */
+		set_pte(ptep, pte_mkdirty(*ptep));
+		mark_page_dirty(kvm, gfn);
+	}
+
+	if (out_entry)
+		*out_entry = *ptep;
+	if (out_buddy)
+		*out_buddy = *ptep_buddy(ptep);
+
+out:
+	spin_unlock(&kvm->mmu_lock);
+	return ret;
+}
+
+/**
  * kvm_mips_map_page() - Map a guest physical page.
  * @vcpu:		VCPU pointer.
  * @gpa:		Guest physical address of fault.
@@ -462,9 +514,9 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
  * Handle GPA faults by creating a new GPA mapping (or updating an existing
  * one).
  *
- * This takes care of asking KVM for the corresponding PFN, and creating a
- * mapping in the GPA page tables. Derived mappings (GVA page tables and TLBs)
- * must be handled by the caller.
+ * This takes care of marking pages dirty (dirty page tracking), asking KVM for
+ * the corresponding PFN, and creating a mapping in the GPA page tables. Derived
+ * mappings (GVA page tables and TLBs) must be handled by the caller.
  *
  * Returns:	0 on success, in which case the caller may use the @out_entry
  *		and @out_buddy PTEs to update derived mappings and resume guest
@@ -485,7 +537,12 @@ static int kvm_mips_map_page(struct kvm_vcpu *vcpu, unsigned long gpa,
 	pte_t *ptep, entry, old_pte;
 	unsigned long prot_bits;
 
+	/* Try the fast path to handle clean pages */
 	srcu_idx = srcu_read_lock(&kvm->srcu);
+	err = _kvm_mips_map_page_fast(vcpu, gpa, write_fault, out_entry,
+				      out_buddy);
+	if (!err)
+		goto out;
 
 	/* We need a minimum of cached pages ready for page table creation */
 	err = mmu_topup_memory_cache(memcache, KVM_MMU_CACHE_MIN_PAGES,
@@ -493,6 +550,7 @@ static int kvm_mips_map_page(struct kvm_vcpu *vcpu, unsigned long gpa,
 	if (err)
 		goto out;
 
+	/* Slow path - ask KVM core whether we can access this GPA */
 	pfn = gfn_to_pfn(kvm, gfn);
 
 	if (is_error_noslot_pfn(pfn)) {
@@ -502,11 +560,19 @@ static int kvm_mips_map_page(struct kvm_vcpu *vcpu, unsigned long gpa,
 
 	spin_lock(&kvm->mmu_lock);
 
+	/* Ensure page tables are allocated */
 	ptep = kvm_mips_pte_for_gpa(kvm, memcache, gpa);
 
-	prot_bits = __READABLE | _PAGE_PRESENT | __WRITEABLE;
+	/* Set up the PTE */
+	prot_bits = __READABLE | _PAGE_PRESENT | _PAGE_WRITE |
+		_page_cachable_default;
+	if (write_fault) {
+		prot_bits |= __WRITEABLE;
+		mark_page_dirty(kvm, gfn);
+	}
 	entry = pfn_pte(pfn, __pgprot(prot_bits));
 
+	/* Write the PTE */
 	old_pte = *ptep;
 	set_pte(ptep, entry);
 	if (pte_present(old_pte))
-- 
git-series 0.8.10
