Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Aug 2016 12:58:58 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:5703 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992705AbcHKK6uEUll8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Aug 2016 12:58:50 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id A00CE5EC82B8D;
        Thu, 11 Aug 2016 11:58:30 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 11 Aug 2016 11:58:33 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>,
        <stable@vger.kernel.org>, James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 1/4] MIPS: KVM: Fix mapped fault broken commpage handling
Date:   Thu, 11 Aug 2016 11:58:12 +0100
Message-ID: <2d99b9ec50abf03c086d0cdaa9ef729687ac940f.1470911944.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.9.2
MIME-Version: 1.0
In-Reply-To: <cover.e70247d7d77e67a2331e65b6b7fd3894508e5d28.1470911944.git-series.james.hogan@imgtec.com>
References: <cover.e70247d7d77e67a2331e65b6b7fd3894508e5d28.1470911944.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54480
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

kvm_mips_handle_mapped_seg_tlb_fault() appears to map the guest page at
virtual address 0 to PFN 0 if the guest has created its own mapping
there. The intention is unclear, but it may have been an attempt to
protect the zero page from being mapped to anything but the comm page in
code paths you wouldn't expect from genuine commpage accesses (guest
kernel mode cache instructions on that address, hitting trapping
instructions when executing from that address with a coincidental TLB
eviction during the KVM handling, and guest user mode accesses to that
address).

Fix this to check for mappings exactly at KVM_GUEST_COMMPAGE_ADDR (it
may not be at address 0 since commit 42aa12e74e91 ("MIPS: KVM: Move
commpage so 0x0 is unmapped")), and set the corresponding EntryLo to be
interpreted as 0 (invalid).

Fixes: 858dd5d45733 ("KVM/MIPS32: MMU/TLB operations for the Guest.")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
Cc: <stable@vger.kernel.org> # 3.10.x-
---
 arch/mips/kvm/mmu.c | 49 ++++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 21 deletions(-)

diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index 57319ee57c4f..96e0b24cfe5c 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -138,35 +138,42 @@ int kvm_mips_handle_mapped_seg_tlb_fault(struct kvm_vcpu *vcpu,
 	unsigned long entryhi = 0, entrylo0 = 0, entrylo1 = 0;
 	struct kvm *kvm = vcpu->kvm;
 	kvm_pfn_t pfn0, pfn1;
+	long tlb_lo[2];
 	int ret;
 
-	if ((tlb->tlb_hi & VPN2_MASK) == 0) {
-		pfn0 = 0;
-		pfn1 = 0;
-	} else {
-		if (kvm_mips_map_page(kvm, mips3_tlbpfn_to_paddr(tlb->tlb_lo[0])
-					   >> PAGE_SHIFT) < 0)
-			return -1;
-
-		if (kvm_mips_map_page(kvm, mips3_tlbpfn_to_paddr(tlb->tlb_lo[1])
-					   >> PAGE_SHIFT) < 0)
-			return -1;
-
-		pfn0 = kvm->arch.guest_pmap[
-			mips3_tlbpfn_to_paddr(tlb->tlb_lo[0]) >> PAGE_SHIFT];
-		pfn1 = kvm->arch.guest_pmap[
-			mips3_tlbpfn_to_paddr(tlb->tlb_lo[1]) >> PAGE_SHIFT];
-	}
+	tlb_lo[0] = tlb->tlb_lo[0];
+	tlb_lo[1] = tlb->tlb_lo[1];
+
+	/*
+	 * The commpage address must not be mapped to anything else if the guest
+	 * TLB contains entries nearby, or commpage accesses will break.
+	 */
+	if (!((tlb->tlb_hi ^ KVM_GUEST_COMMPAGE_ADDR) &
+			VPN2_MASK & (PAGE_MASK << 1)))
+		tlb_lo[(KVM_GUEST_COMMPAGE_ADDR >> PAGE_SHIFT) & 1] = 0;
+
+	if (kvm_mips_map_page(kvm, mips3_tlbpfn_to_paddr(tlb_lo[0])
+				   >> PAGE_SHIFT) < 0)
+		return -1;
+
+	if (kvm_mips_map_page(kvm, mips3_tlbpfn_to_paddr(tlb_lo[1])
+				   >> PAGE_SHIFT) < 0)
+		return -1;
+
+	pfn0 = kvm->arch.guest_pmap[
+		mips3_tlbpfn_to_paddr(tlb_lo[0]) >> PAGE_SHIFT];
+	pfn1 = kvm->arch.guest_pmap[
+		mips3_tlbpfn_to_paddr(tlb_lo[1]) >> PAGE_SHIFT];
 
 	/* Get attributes from the Guest TLB */
 	entrylo0 = mips3_paddr_to_tlbpfn(pfn0 << PAGE_SHIFT) |
 		((_page_cachable_default >> _CACHE_SHIFT) << ENTRYLO_C_SHIFT) |
-		(tlb->tlb_lo[0] & ENTRYLO_D) |
-		(tlb->tlb_lo[0] & ENTRYLO_V);
+		(tlb_lo[0] & ENTRYLO_D) |
+		(tlb_lo[0] & ENTRYLO_V);
 	entrylo1 = mips3_paddr_to_tlbpfn(pfn1 << PAGE_SHIFT) |
 		((_page_cachable_default >> _CACHE_SHIFT) << ENTRYLO_C_SHIFT) |
-		(tlb->tlb_lo[1] & ENTRYLO_D) |
-		(tlb->tlb_lo[1] & ENTRYLO_V);
+		(tlb_lo[1] & ENTRYLO_D) |
+		(tlb_lo[1] & ENTRYLO_V);
 
 	kvm_debug("@ %#lx tlb_lo0: 0x%08lx tlb_lo1: 0x%08lx\n", vcpu->arch.pc,
 		  tlb->tlb_lo[0], tlb->tlb_lo[1]);
-- 
git-series 0.8.7
