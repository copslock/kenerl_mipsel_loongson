Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Aug 2016 11:06:55 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:16333 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993186AbcHRJF6gvUSd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Aug 2016 11:05:58 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 52D51BC8BAEC0;
        Thu, 18 Aug 2016 10:05:40 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 18 Aug 2016 10:05:41 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     <stable@vger.kernel.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH BACKPORT 3.17-4.4 1/4] MIPS: KVM: Fix mapped fault broken commpage handling
Date:   Thu, 18 Aug 2016 10:05:29 +0100
Message-ID: <68df6d553f95e9f40311c92f7e010d90a329843a.1471018436.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.9.2
MIME-Version: 1.0
In-Reply-To: <cover.6970eb00e72f05828fc82d97b7283d20eac8951e.1471018436.git-series.james.hogan@imgtec.com>
References: <cover.6970eb00e72f05828fc82d97b7283d20eac8951e.1471018436.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54587
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

commit c604cffa93478f8888bec62b23d6073dad03d43a upstream.

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
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
[james.hogan@imgtec.com: Backport to v3.17.y - v4.4.y]
Signed-off-by: James Hogan <james.hogan@imgtec.com>
---
 arch/mips/kvm/tlb.c | 45 ++++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/arch/mips/kvm/tlb.c b/arch/mips/kvm/tlb.c
index aed0ac2a4972..d3c5715426c4 100644
--- a/arch/mips/kvm/tlb.c
+++ b/arch/mips/kvm/tlb.c
@@ -361,24 +361,31 @@ int kvm_mips_handle_mapped_seg_tlb_fault(struct kvm_vcpu *vcpu,
 	unsigned long entryhi = 0, entrylo0 = 0, entrylo1 = 0;
 	struct kvm *kvm = vcpu->kvm;
 	pfn_t pfn0, pfn1;
+	long tlb_lo[2];
 
-	if ((tlb->tlb_hi & VPN2_MASK) == 0) {
-		pfn0 = 0;
-		pfn1 = 0;
-	} else {
-		if (kvm_mips_map_page(kvm, mips3_tlbpfn_to_paddr(tlb->tlb_lo0)
-					   >> PAGE_SHIFT) < 0)
-			return -1;
-
-		if (kvm_mips_map_page(kvm, mips3_tlbpfn_to_paddr(tlb->tlb_lo1)
-					   >> PAGE_SHIFT) < 0)
-			return -1;
-
-		pfn0 = kvm->arch.guest_pmap[mips3_tlbpfn_to_paddr(tlb->tlb_lo0)
-					    >> PAGE_SHIFT];
-		pfn1 = kvm->arch.guest_pmap[mips3_tlbpfn_to_paddr(tlb->tlb_lo1)
-					    >> PAGE_SHIFT];
-	}
+	tlb_lo[0] = tlb->tlb_lo0;
+	tlb_lo[1] = tlb->tlb_lo1;
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
+	pfn0 = kvm->arch.guest_pmap[mips3_tlbpfn_to_paddr(tlb_lo[0])
+				    >> PAGE_SHIFT];
+	pfn1 = kvm->arch.guest_pmap[mips3_tlbpfn_to_paddr(tlb_lo[1])
+				    >> PAGE_SHIFT];
 
 	if (hpa0)
 		*hpa0 = pfn0 << PAGE_SHIFT;
@@ -391,9 +398,9 @@ int kvm_mips_handle_mapped_seg_tlb_fault(struct kvm_vcpu *vcpu,
 					       kvm_mips_get_kernel_asid(vcpu) :
 					       kvm_mips_get_user_asid(vcpu));
 	entrylo0 = mips3_paddr_to_tlbpfn(pfn0 << PAGE_SHIFT) | (0x3 << 3) |
-		   (tlb->tlb_lo0 & MIPS3_PG_D) | (tlb->tlb_lo0 & MIPS3_PG_V);
+		   (tlb_lo[0] & MIPS3_PG_D) | (tlb_lo[0] & MIPS3_PG_V);
 	entrylo1 = mips3_paddr_to_tlbpfn(pfn1 << PAGE_SHIFT) | (0x3 << 3) |
-		   (tlb->tlb_lo1 & MIPS3_PG_D) | (tlb->tlb_lo1 & MIPS3_PG_V);
+		   (tlb_lo[1] & MIPS3_PG_D) | (tlb_lo[1] & MIPS3_PG_V);
 
 	kvm_debug("@ %#lx tlb_lo0: 0x%08lx tlb_lo1: 0x%08lx\n", vcpu->arch.pc,
 		  tlb->tlb_lo0, tlb->tlb_lo1);
-- 
git-series 0.8.8
