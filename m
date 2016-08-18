Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Aug 2016 16:12:08 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:53992 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993204AbcHROL7bGkiI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Aug 2016 16:11:59 +0200
Received: from localhost (pes75-3-78-192-101-3.fbxo.proxad.net [78.192.101.3])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4905678D;
        Thu, 18 Aug 2016 14:11:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org
Subject: [PATCH 4.7 085/186] MIPS: KVM: Fix mapped fault broken commpage handling
Date:   Thu, 18 Aug 2016 15:58:22 +0200
Message-Id: <20160818135935.761248419@linuxfoundation.org>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160818135932.219369981@linuxfoundation.org>
References: <20160818135932.219369981@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54647
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

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
Cc: <stable@vger.kernel.org> # 3.10.x-
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
[james.hogan@imgtec.com: Backport to v4.7]
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/kvm/tlb.c |   45 ++++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 19 deletions(-)

--- a/arch/mips/kvm/tlb.c
+++ b/arch/mips/kvm/tlb.c
@@ -373,25 +373,32 @@ int kvm_mips_handle_mapped_seg_tlb_fault
 	unsigned long entryhi = 0, entrylo0 = 0, entrylo1 = 0;
 	struct kvm *kvm = vcpu->kvm;
 	kvm_pfn_t pfn0, pfn1;
+	long tlb_lo[2];
 	int ret;
 
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
@@ -401,9 +408,9 @@ int kvm_mips_handle_mapped_seg_tlb_fault
 
 	/* Get attributes from the Guest TLB */
 	entrylo0 = mips3_paddr_to_tlbpfn(pfn0 << PAGE_SHIFT) | (0x3 << 3) |
-		   (tlb->tlb_lo0 & MIPS3_PG_D) | (tlb->tlb_lo0 & MIPS3_PG_V);
+		   (tlb_lo[0] & MIPS3_PG_D) | (tlb_lo[0] & MIPS3_PG_V);
 	entrylo1 = mips3_paddr_to_tlbpfn(pfn1 << PAGE_SHIFT) | (0x3 << 3) |
-		   (tlb->tlb_lo1 & MIPS3_PG_D) | (tlb->tlb_lo1 & MIPS3_PG_V);
+		   (tlb_lo[1] & MIPS3_PG_D) | (tlb_lo[1] & MIPS3_PG_V);
 
 	kvm_debug("@ %#lx tlb_lo0: 0x%08lx tlb_lo1: 0x%08lx\n", vcpu->arch.pc,
 		  tlb->tlb_lo0, tlb->tlb_lo1);
