Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jan 2017 13:54:17 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:62579 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993966AbdAPMt4kBrdk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Jan 2017 13:49:56 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 258991D000005;
        Mon, 16 Jan 2017 12:49:47 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 16 Jan 2017 12:49:50 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 11/13] KVM: MIPS/MMU: Pass GPA PTE bits to mapped GVA PTEs
Date:   Mon, 16 Jan 2017 12:49:32 +0000
Message-ID: <fea11ed8c2676b601831977d92db88575c6a4c87.1484570878.git-series.james.hogan@imgtec.com>
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
X-archive-position: 56330
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

Propagate the GPA PTE protection bits on to the GVA PTEs on a mapped
fault (except _PAGE_WRITE, and filtered by the guest TLB entry), rather
than always overriding the protection. This allows dirty page tracking
to work in mapped guest segments as a clear dirty bit in the GPA PTE
will propagate to the GVA PTEs even when the guest TLB has the dirty bit
set.

Since the filtering of protection bits is now abstracted, if the buddy
GVA PTE is also valid, we obtain the corresponding GPA PTE using a
simple non-allocating walk and load that into the GVA PTE similarly
(which may itself be invalid).

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/mmu.c | 56 ++++++++++++++++++++++++++++++----------------
 1 file changed, 37 insertions(+), 19 deletions(-)

diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index 9cc941864aa8..8a01bbd276fc 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -782,6 +782,15 @@ static pte_t kvm_mips_gpa_pte_to_gva_unmapped(pte_t pte)
 	return pte;
 }
 
+static pte_t kvm_mips_gpa_pte_to_gva_mapped(pte_t pte, long entrylo)
+{
+	/* Guest EntryLo overrides host EntryLo */
+	if (!(entrylo & ENTRYLO_D))
+		pte = pte_mkclean(pte);
+
+	return kvm_mips_gpa_pte_to_gva_unmapped(pte);
+}
+
 /* XXXKYMA: Must be called with interrupts disabled */
 int kvm_mips_handle_kseg0_tlb_fault(unsigned long badvaddr,
 				    struct kvm_vcpu *vcpu,
@@ -825,39 +834,48 @@ int kvm_mips_handle_mapped_seg_tlb_fault(struct kvm_vcpu *vcpu,
 					 unsigned long gva,
 					 bool write_fault)
 {
-	kvm_pfn_t pfn;
-	long tlb_lo = 0;
-	pte_t pte_gpa, *ptep_gva;
-	unsigned int idx;
+	struct kvm *kvm = vcpu->kvm;
+	long tlb_lo[2];
+	pte_t pte_gpa[2], *ptep_buddy, *ptep_gva;
+	unsigned int idx = TLB_LO_IDX(*tlb, gva);
 	bool kernel = KVM_GUEST_KERNEL_MODE(vcpu);
 
+	tlb_lo[0] = tlb->tlb_lo[0];
+	tlb_lo[1] = tlb->tlb_lo[1];
+
 	/*
 	 * The commpage address must not be mapped to anything else if the guest
 	 * TLB contains entries nearby, or commpage accesses will break.
 	 */
-	idx = TLB_LO_IDX(*tlb, gva);
-	if ((gva ^ KVM_GUEST_COMMPAGE_ADDR) & VPN2_MASK & PAGE_MASK)
-		tlb_lo = tlb->tlb_lo[idx];
+	if (!((gva ^ KVM_GUEST_COMMPAGE_ADDR) & VPN2_MASK & (PAGE_MASK << 1)))
+		tlb_lo[TLB_LO_IDX(*tlb, KVM_GUEST_COMMPAGE_ADDR)] = 0;
 
-	/* Find host PFN */
-	if (kvm_mips_map_page(vcpu, mips3_tlbpfn_to_paddr(tlb_lo), write_fault,
-			      &pte_gpa, NULL) < 0)
+	/* Get the GPA page table entry */
+	if (kvm_mips_map_page(vcpu, mips3_tlbpfn_to_paddr(tlb_lo[idx]),
+			      write_fault, &pte_gpa[idx], NULL) < 0)
 		return -1;
-	pfn = pte_pfn(pte_gpa);
 
-	/* Find GVA page table entry */
-	ptep_gva = kvm_trap_emul_pte_for_gva(vcpu, gva);
+	/* And its GVA buddy's GPA page table entry if it also exists */
+	pte_gpa[!idx] = pfn_pte(0, __pgprot(0));
+	if (tlb_lo[!idx] & ENTRYLO_V) {
+		spin_lock(&kvm->mmu_lock);
+		ptep_buddy = kvm_mips_pte_for_gpa(kvm, NULL,
+					mips3_tlbpfn_to_paddr(tlb_lo[!idx]));
+		if (ptep_buddy)
+			pte_gpa[!idx] = *ptep_buddy;
+		spin_unlock(&kvm->mmu_lock);
+	}
+
+	/* Get the GVA page table entry pair */
+	ptep_gva = kvm_trap_emul_pte_for_gva(vcpu, gva & ~PAGE_SIZE);
 	if (!ptep_gva) {
 		kvm_err("No ptep for gva %lx\n", gva);
 		return -1;
 	}
 
-	/* Write PFN into GVA page table, taking attributes from Guest TLB */
-	*ptep_gva = pfn_pte(pfn, (!(tlb_lo & ENTRYLO_V)) ? __pgprot(0) :
-				 (tlb_lo & ENTRYLO_D) ? PAGE_SHARED :
-				 PAGE_READONLY);
-	if (pte_present(*ptep_gva))
-		*ptep_gva = pte_mkyoung(pte_mkdirty(*ptep_gva));
+	/* Copy a pair of entries from GPA page table to GVA page table */
+	ptep_gva[0] = kvm_mips_gpa_pte_to_gva_mapped(pte_gpa[0], tlb_lo[0]);
+	ptep_gva[1] = kvm_mips_gpa_pte_to_gva_mapped(pte_gpa[1], tlb_lo[1]);
 
 	/* Invalidate this entry in the TLB, current guest mode ASID only */
 	kvm_mips_host_tlb_inv(vcpu, gva, !kernel, kernel);
-- 
git-series 0.8.10
