Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jan 2017 13:53:56 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:7995 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993886AbdAPMtzxI03k (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Jan 2017 13:49:55 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 60D7F8E80BB83;
        Mon, 16 Jan 2017 12:49:46 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 16 Jan 2017 12:49:49 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 10/13] KVM: MIPS/MMU: Pass GPA PTE bits to KSeg0 GVA PTEs
Date:   Mon, 16 Jan 2017 12:49:31 +0000
Message-ID: <555238b387306895a8285cf719f3e9c6e520edde.1484570878.git-series.james.hogan@imgtec.com>
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
X-archive-position: 56329
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

Propagate the GPA PTE protection bits on to the GVA PTEs on a KSeg0
fault (except _PAGE_WRITE), rather than always overriding the
protection. This allows dirty page tracking to work in KSeg0 as a clear
dirty bit in the GPA PTE will propagate to the GVA PTEs.

This makes it simpler to use a single kvm_mips_map_page() to obtain both
the main GPA PTE and its buddy (which may be invalid), which also allows
memory regions to be fully accessible when they don't start and end on a
2*PAGE_SIZE boundary.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/mmu.c | 49 ++++++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index 7962eea4ebc3..9cc941864aa8 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -769,15 +769,27 @@ void kvm_mips_flush_gva_pt(pgd_t *pgd, enum kvm_mips_flush flags)
 	}
 }
 
+static pte_t kvm_mips_gpa_pte_to_gva_unmapped(pte_t pte)
+{
+	/*
+	 * Don't leak writeable but clean entries from GPA page tables. We don't
+	 * want the normal Linux tlbmod handler to handle dirtying when KVM
+	 * accesses guest memory.
+	 */
+	if (!pte_dirty(pte))
+		pte = pte_wrprotect(pte);
+
+	return pte;
+}
+
 /* XXXKYMA: Must be called with interrupts disabled */
 int kvm_mips_handle_kseg0_tlb_fault(unsigned long badvaddr,
 				    struct kvm_vcpu *vcpu,
 				    bool write_fault)
 {
 	unsigned long gpa;
-	kvm_pfn_t pfn0, pfn1;
-	unsigned long vaddr;
 	pte_t pte_gpa[2], *ptep_gva;
+	int idx;
 
 	if (KVM_GUEST_KSEGX(badvaddr) != KVM_GUEST_KSEG0) {
 		kvm_err("%s: Invalid BadVaddr: %#lx\n", __func__, badvaddr);
@@ -785,35 +797,26 @@ int kvm_mips_handle_kseg0_tlb_fault(unsigned long badvaddr,
 		return -1;
 	}
 
-	/* Find host PFNs */
-
-	gpa = KVM_GUEST_CPHYSADDR(badvaddr & (PAGE_MASK << 1));
-	vaddr = badvaddr & (PAGE_MASK << 1);
-
-	if (kvm_mips_map_page(vcpu, gpa, write_fault, &pte_gpa[0], NULL) < 0)
-		return -1;
-
-	if (kvm_mips_map_page(vcpu, gpa | PAGE_SIZE, write_fault, &pte_gpa[1],
-			      NULL) < 0)
+	/* Get the GPA page table entry */
+	gpa = KVM_GUEST_CPHYSADDR(badvaddr);
+	idx = (badvaddr >> PAGE_SHIFT) & 1;
+	if (kvm_mips_map_page(vcpu, gpa, write_fault, &pte_gpa[idx],
+			      &pte_gpa[!idx]) < 0)
 		return -1;
 
-	pfn0 = pte_pfn(pte_gpa[0]);
-	pfn1 = pte_pfn(pte_gpa[1]);
-
-	/* Find GVA page table entry */
-
-	ptep_gva = kvm_trap_emul_pte_for_gva(vcpu, vaddr);
+	/* Get the GVA page table entry */
+	ptep_gva = kvm_trap_emul_pte_for_gva(vcpu, badvaddr & ~PAGE_SIZE);
 	if (!ptep_gva) {
-		kvm_err("No ptep for gva %lx\n", vaddr);
+		kvm_err("No ptep for gva %lx\n", badvaddr);
 		return -1;
 	}
 
-	/* Write host PFNs into GVA page table */
-	ptep_gva[0] = pte_mkyoung(pte_mkdirty(pfn_pte(pfn0, PAGE_SHARED)));
-	ptep_gva[1] = pte_mkyoung(pte_mkdirty(pfn_pte(pfn1, PAGE_SHARED)));
+	/* Copy a pair of entries from GPA page table to GVA page table */
+	ptep_gva[0] = kvm_mips_gpa_pte_to_gva_unmapped(pte_gpa[0]);
+	ptep_gva[1] = kvm_mips_gpa_pte_to_gva_unmapped(pte_gpa[1]);
 
 	/* Invalidate this entry in the TLB, guest kernel ASID only */
-	kvm_mips_host_tlb_inv(vcpu, vaddr, false, true);
+	kvm_mips_host_tlb_inv(vcpu, badvaddr, false, true);
 	return 0;
 }
 
-- 
git-series 0.8.10
