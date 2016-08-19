Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Aug 2016 09:12:27 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:54880 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992481AbcHSHL5ZPVKS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 19 Aug 2016 09:11:57 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 18E57AAF1;
        Fri, 19 Aug 2016 07:11:57 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 3.12 051/100] MIPS: KVM: Add missing gfn range check
Date:   Fri, 19 Aug 2016 09:10:50 +0200
Message-Id: <313925d185fe7a7a52900e932cbff5f19ceebe7c.1471589700.git.jslaby@suse.cz>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <bc76af4e1436406a1f53da243e76bd10327691f2.1471589700.git.jslaby@suse.cz>
References: <bc76af4e1436406a1f53da243e76bd10327691f2.1471589700.git.jslaby@suse.cz>
In-Reply-To: <cover.1471589700.git.jslaby@suse.cz>
References: <cover.1471589700.git.jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <jslaby@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54676
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jslaby@suse.cz
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

3.12-stable review patch.  If anyone has any objections, please let me know.

===============

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
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/mips/kvm/kvm_tlb.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kvm/kvm_tlb.c b/arch/mips/kvm/kvm_tlb.c
index 1e6b1f124377..8aba2e54f90f 100644
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
2.9.3
