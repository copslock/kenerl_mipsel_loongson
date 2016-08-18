Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Aug 2016 11:23:50 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:11678 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993186AbcHRJXXYqCQl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Aug 2016 11:23:23 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 71DB5E7686D31;
        Thu, 18 Aug 2016 10:23:03 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 18 Aug 2016 10:23:05 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     <stable@vger.kernel.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH BACKPORT 3.10-3.15 2/4] MIPS: KVM: Add missing gfn range check
Date:   Thu, 18 Aug 2016 10:22:53 +0100
Message-ID: <54b01d37d3ac6ff18fdef80d1189d3c1285d4f46.1471021142.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.9.2
MIME-Version: 1.0
In-Reply-To: <cover.04bc2e89e693aeb69bf6e36d1d7b18ffb591bd31.1471021142.git-series.james.hogan@imgtec.com>
References: <cover.04bc2e89e693aeb69bf6e36d1d7b18ffb591bd31.1471021142.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54591
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

commit 8985d50382359e5bf118fdbefc859d0dbf6cebc7 upstream.

kvm_mips_handle_mapped_seg_tlb_fault() calculates the guest frame number
based on the guest TLB EntryLo values, however it is not range checked
to ensure it lies within the guest_pmap. If the physical memory the
guest refers to is out of range then dump the guest TLB and emit an
internal error.

Fixes: 858dd5d45733 ("KVM/MIPS32: MMU/TLB operations for the Guest.")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
[james.hogan@imgtec.com: Backport to v3.10.y - v3.15.y]
Signed-off-by: James Hogan <james.hogan@imgtec.com>
---
 arch/mips/kvm/kvm_tlb.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kvm/kvm_tlb.c b/arch/mips/kvm/kvm_tlb.c
index 780bb077f328..ac6b772d6b2a 100644
--- a/arch/mips/kvm/kvm_tlb.c
+++ b/arch/mips/kvm/kvm_tlb.c
@@ -370,6 +370,7 @@ kvm_mips_handle_mapped_seg_tlb_fault(struct kvm_vcpu *vcpu,
 	unsigned long entryhi = 0, entrylo0 = 0, entrylo1 = 0;
 	struct kvm *kvm = vcpu->kvm;
 	pfn_t pfn0, pfn1;
+	gfn_t gfn0, gfn1;
 	long tlb_lo[2];
 
 	tlb_lo[0] = tlb->tlb_lo0;
@@ -383,14 +384,24 @@ kvm_mips_handle_mapped_seg_tlb_fault(struct kvm_vcpu *vcpu,
 			VPN2_MASK & (PAGE_MASK << 1)))
 		tlb_lo[(KVM_GUEST_COMMPAGE_ADDR >> PAGE_SHIFT) & 1] = 0;
 
-	if (kvm_mips_map_page(kvm, mips3_tlbpfn_to_paddr(tlb_lo[0]) >> PAGE_SHIFT) < 0)
+	gfn0 = mips3_tlbpfn_to_paddr(tlb_lo[0]) >> PAGE_SHIFT;
+	gfn1 = mips3_tlbpfn_to_paddr(tlb_lo[1]) >> PAGE_SHIFT;
+	if (gfn0 >= kvm->arch.guest_pmap_npages ||
+	    gfn1 >= kvm->arch.guest_pmap_npages) {
+		kvm_err("%s: Invalid gfn: [%#llx, %#llx], EHi: %#lx\n",
+			__func__, gfn0, gfn1, tlb->tlb_hi);
+		kvm_mips_dump_guest_tlbs(vcpu);
+		return -1;
+	}
+
+	if (kvm_mips_map_page(kvm, gfn0) < 0)
 		return -1;
 
-	if (kvm_mips_map_page(kvm, mips3_tlbpfn_to_paddr(tlb_lo[1]) >> PAGE_SHIFT) < 0)
+	if (kvm_mips_map_page(kvm, gfn1) < 0)
 		return -1;
 
-	pfn0 = kvm->arch.guest_pmap[mips3_tlbpfn_to_paddr(tlb_lo[0]) >> PAGE_SHIFT];
-	pfn1 = kvm->arch.guest_pmap[mips3_tlbpfn_to_paddr(tlb_lo[1]) >> PAGE_SHIFT];
+	pfn0 = kvm->arch.guest_pmap[gfn0];
+	pfn1 = kvm->arch.guest_pmap[gfn1];
 
 	if (hpa0)
 		*hpa0 = pfn0 << PAGE_SHIFT;
-- 
git-series 0.8.8
