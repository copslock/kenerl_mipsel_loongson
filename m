Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Aug 2016 17:36:33 +0200 (CEST)
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:55926 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992642AbcHUPgThCw93 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 21 Aug 2016 17:36:19 +0200
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id u7LFWGxg013306;
        Sun, 21 Aug 2016 17:32:16 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 3.10 051/180] MIPS: KVM: Add missing gfn range check
Date:   Sun, 21 Aug 2016 17:29:41 +0200
Message-Id: <1471793510-13022-52-git-send-email-w@1wt.eu>
X-Mailer: git-send-email 2.8.0.rc2.1.gbe9624a
In-Reply-To: <1471793510-13022-1-git-send-email-w@1wt.eu>
References: <1471793510-13022-1-git-send-email-w@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=latin1
Content-Transfer-Encoding: 8bit
Return-Path: <w@1wt.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54710
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: w@1wt.eu
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

From: James Hogan <james.hogan@imgtec.com>

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
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 arch/mips/kvm/kvm_tlb.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kvm/kvm_tlb.c b/arch/mips/kvm/kvm_tlb.c
index 1e6b1f1..8aba2e5 100644
--- a/arch/mips/kvm/kvm_tlb.c
+++ b/arch/mips/kvm/kvm_tlb.c
@@ -397,6 +397,7 @@ kvm_mips_handle_mapped_seg_tlb_fault(struct kvm_vcpu *vcpu,
 	unsigned long entryhi = 0, entrylo0 = 0, entrylo1 = 0;
 	struct kvm *kvm = vcpu->kvm;
 	pfn_t pfn0, pfn1;
+	gfn_t gfn0, gfn1;
 	long tlb_lo[2];
 
 	tlb_lo[0] = tlb->tlb_lo0;
@@ -410,14 +411,24 @@ kvm_mips_handle_mapped_seg_tlb_fault(struct kvm_vcpu *vcpu,
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
2.8.0.rc2.1.gbe9624a
