Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Nov 2016 03:06:01 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37817 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993003AbcKNCEVM7VeO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Nov 2016 03:04:21 +0100
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1c66d9-0005pK-Bh; Mon, 14 Nov 2016 02:04:20 +0000
Received: from ben by deadeye with local (Exim 4.87)
        (envelope-from <ben@decadent.org.uk>)
        id 1c66d8-0000XQ-C5; Mon, 14 Nov 2016 02:04:18 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Ralf Baechle" <ralf@linux-mips.org>,
        linux-mips@linux-mips.org, "James Hogan" <james.hogan@imgtec.com>,
        kvm@vger.kernel.org, "Paolo Bonzini" <pbonzini@redhat.com>,
        "Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?=" <rkrcmar@redhat.com>
Date:   Mon, 14 Nov 2016 00:14:20 +0000
Message-ID: <lsq.1479082460.809062822@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 176/346] MIPS: KVM: Add missing gfn range check
In-Reply-To: <lsq.1479082458.755945576@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55798
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.16.39-rc1 review patch.  If anyone has any objections, please let me know.

------------------

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
[bwh: Backported to 3.16: adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/kvm/kvm_tlb.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

--- a/arch/mips/kvm/kvm_tlb.c
+++ b/arch/mips/kvm/kvm_tlb.c
@@ -361,6 +361,7 @@ kvm_mips_handle_mapped_seg_tlb_fault(str
 	unsigned long entryhi = 0, entrylo0 = 0, entrylo1 = 0;
 	struct kvm *kvm = vcpu->kvm;
 	pfn_t pfn0, pfn1;
+	gfn_t gfn0, gfn1;
 	long tlb_lo[2];
 
 
@@ -375,18 +376,24 @@ kvm_mips_handle_mapped_seg_tlb_fault(str
 			VPN2_MASK & (PAGE_MASK << 1)))
 		tlb_lo[(KVM_GUEST_COMMPAGE_ADDR >> PAGE_SHIFT) & 1] = 0;
 
-	if (kvm_mips_map_page(kvm, mips3_tlbpfn_to_paddr(tlb_lo[0])
-				   >> PAGE_SHIFT) < 0)
+	gfn0 = mips3_tlbpfn_to_paddr(tlb_lo[0]) >> PAGE_SHIFT;
+	gfn1 = mips3_tlbpfn_to_paddr(tlb_lo[1]) >> PAGE_SHIFT;
+	if (gfn0 >= kvm->arch.guest_pmap_npages ||
+	    gfn1 >= kvm->arch.guest_pmap_npages) {
+		kvm_err("%s: Invalid gfn: [%#llx, %#llx], EHi: %#lx\n",
+			__func__, gfn0, gfn1, tlb->tlb_hi);
+		kvm_mips_dump_guest_tlbs(vcpu);
 		return -1;
+	}
 
-	if (kvm_mips_map_page(kvm, mips3_tlbpfn_to_paddr(tlb_lo[1])
-				   >> PAGE_SHIFT) < 0)
+	if (kvm_mips_map_page(kvm, gfn0) < 0)
 		return -1;
 
-	pfn0 = kvm->arch.guest_pmap[
-		mips3_tlbpfn_to_paddr(tlb_lo[0]) >> PAGE_SHIFT];
-	pfn1 = kvm->arch.guest_pmap[
-		mips3_tlbpfn_to_paddr(tlb_lo[1]) >> PAGE_SHIFT];
+	if (kvm_mips_map_page(kvm, gfn1) < 0)
+		return -1;
+
+	pfn0 = kvm->arch.guest_pmap[gfn0];
+	pfn1 = kvm->arch.guest_pmap[gfn1];
 
 	if (hpa0)
 		*hpa0 = pfn0 << PAGE_SHIFT;
