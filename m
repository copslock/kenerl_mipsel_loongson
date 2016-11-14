Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Nov 2016 03:06:52 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37855 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993008AbcKNCEV7HqdO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Nov 2016 03:04:21 +0100
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1c66d9-0005pT-C9; Mon, 14 Nov 2016 02:04:20 +0000
Received: from ben by deadeye with local (Exim 4.87)
        (envelope-from <ben@decadent.org.uk>)
        id 1c66d8-0000XL-BR; Mon, 14 Nov 2016 02:04:18 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Ralf Baechle" <ralf@linux-mips.org>,
        "James Hogan" <james.hogan@imgtec.com>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org, "Paolo Bonzini" <pbonzini@redhat.com>,
        "Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?=" <rkrcmar@redhat.com>
Date:   Mon, 14 Nov 2016 00:14:20 +0000
Message-ID: <lsq.1479082460.271072103@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 175/346] MIPS: KVM: Fix mapped fault broken commpage
 handling
In-Reply-To: <lsq.1479082458.755945576@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55800
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
[bwh: Backported to 3.16: adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/mips/kvm/kvm_tlb.c
+++ b/arch/mips/kvm/kvm_tlb.c
@@ -361,21 +361,32 @@ kvm_mips_handle_mapped_seg_tlb_fault(str
 	unsigned long entryhi = 0, entrylo0 = 0, entrylo1 = 0;
 	struct kvm *kvm = vcpu->kvm;
 	pfn_t pfn0, pfn1;
+	long tlb_lo[2];
 
 
-	if ((tlb->tlb_hi & VPN2_MASK) == 0) {
-		pfn0 = 0;
-		pfn1 = 0;
-	} else {
-		if (kvm_mips_map_page(kvm, mips3_tlbpfn_to_paddr(tlb->tlb_lo0) >> PAGE_SHIFT) < 0)
-			return -1;
-
-		if (kvm_mips_map_page(kvm, mips3_tlbpfn_to_paddr(tlb->tlb_lo1) >> PAGE_SHIFT) < 0)
-			return -1;
-
-		pfn0 = kvm->arch.guest_pmap[mips3_tlbpfn_to_paddr(tlb->tlb_lo0) >> PAGE_SHIFT];
-		pfn1 = kvm->arch.guest_pmap[mips3_tlbpfn_to_paddr(tlb->tlb_lo1) >> PAGE_SHIFT];
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
+	pfn0 = kvm->arch.guest_pmap[
+		mips3_tlbpfn_to_paddr(tlb_lo[0]) >> PAGE_SHIFT];
+	pfn1 = kvm->arch.guest_pmap[
+		mips3_tlbpfn_to_paddr(tlb_lo[1]) >> PAGE_SHIFT];
 
 	if (hpa0)
 		*hpa0 = pfn0 << PAGE_SHIFT;
@@ -387,9 +398,9 @@ kvm_mips_handle_mapped_seg_tlb_fault(str
 	entryhi = (tlb->tlb_hi & VPN2_MASK) | (KVM_GUEST_KERNEL_MODE(vcpu) ?
 			kvm_mips_get_kernel_asid(vcpu) : kvm_mips_get_user_asid(vcpu));
 	entrylo0 = mips3_paddr_to_tlbpfn(pfn0 << PAGE_SHIFT) | (0x3 << 3) |
-			(tlb->tlb_lo0 & MIPS3_PG_D) | (tlb->tlb_lo0 & MIPS3_PG_V);
+		(tlb_lo[0] & MIPS3_PG_D) | (tlb_lo[0] & MIPS3_PG_V);
 	entrylo1 = mips3_paddr_to_tlbpfn(pfn1 << PAGE_SHIFT) | (0x3 << 3) |
-			(tlb->tlb_lo1 & MIPS3_PG_D) | (tlb->tlb_lo1 & MIPS3_PG_V);
+		(tlb_lo[1] & MIPS3_PG_D) | (tlb_lo[1] & MIPS3_PG_V);
 
 	kvm_debug("@ %#lx tlb_lo0: 0x%08lx tlb_lo1: 0x%08lx\n", vcpu->arch.pc,
 		  tlb->tlb_lo0, tlb->tlb_lo1);
