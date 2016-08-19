Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Aug 2016 09:12:03 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:54876 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992475AbcHSHL5IIcvS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 19 Aug 2016 09:11:57 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9D8EDACC5;
        Fri, 19 Aug 2016 07:11:56 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 3.12 050/100] MIPS: KVM: Fix mapped fault broken commpage handling
Date:   Fri, 19 Aug 2016 09:10:49 +0200
Message-Id: <0a73cdedcf38e9e976b739aad2d15a897e5e6965.1471589700.git.jslaby@suse.cz>
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
X-archive-position: 54675
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
[james.hogan@imgtec.com: Backport to v3.10.y - v3.15.y]
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/mips/kvm/kvm_tlb.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/arch/mips/kvm/kvm_tlb.c b/arch/mips/kvm/kvm_tlb.c
index c777dd36d4a8..1e6b1f124377 100644
--- a/arch/mips/kvm/kvm_tlb.c
+++ b/arch/mips/kvm/kvm_tlb.c
@@ -397,21 +397,27 @@ kvm_mips_handle_mapped_seg_tlb_fault(struct kvm_vcpu *vcpu,
 	unsigned long entryhi = 0, entrylo0 = 0, entrylo1 = 0;
 	struct kvm *kvm = vcpu->kvm;
 	pfn_t pfn0, pfn1;
+	long tlb_lo[2];
 
+	tlb_lo[0] = tlb->tlb_lo0;
+	tlb_lo[1] = tlb->tlb_lo1;
 
-	if ((tlb->tlb_hi & VPN2_MASK) == 0) {
-		pfn0 = 0;
-		pfn1 = 0;
-	} else {
-		if (kvm_mips_map_page(kvm, mips3_tlbpfn_to_paddr(tlb->tlb_lo0) >> PAGE_SHIFT) < 0)
-			return -1;
+	/*
+	 * The commpage address must not be mapped to anything else if the guest
+	 * TLB contains entries nearby, or commpage accesses will break.
+	 */
+	if (!((tlb->tlb_hi ^ KVM_GUEST_COMMPAGE_ADDR) &
+			VPN2_MASK & (PAGE_MASK << 1)))
+		tlb_lo[(KVM_GUEST_COMMPAGE_ADDR >> PAGE_SHIFT) & 1] = 0;
 
-		if (kvm_mips_map_page(kvm, mips3_tlbpfn_to_paddr(tlb->tlb_lo1) >> PAGE_SHIFT) < 0)
-			return -1;
+	if (kvm_mips_map_page(kvm, mips3_tlbpfn_to_paddr(tlb_lo[0]) >> PAGE_SHIFT) < 0)
+		return -1;
 
-		pfn0 = kvm->arch.guest_pmap[mips3_tlbpfn_to_paddr(tlb->tlb_lo0) >> PAGE_SHIFT];
-		pfn1 = kvm->arch.guest_pmap[mips3_tlbpfn_to_paddr(tlb->tlb_lo1) >> PAGE_SHIFT];
-	}
+	if (kvm_mips_map_page(kvm, mips3_tlbpfn_to_paddr(tlb_lo[1]) >> PAGE_SHIFT) < 0)
+		return -1;
+
+	pfn0 = kvm->arch.guest_pmap[mips3_tlbpfn_to_paddr(tlb_lo[0]) >> PAGE_SHIFT];
+	pfn1 = kvm->arch.guest_pmap[mips3_tlbpfn_to_paddr(tlb_lo[1]) >> PAGE_SHIFT];
 
 	if (hpa0)
 		*hpa0 = pfn0 << PAGE_SHIFT;
@@ -423,9 +429,9 @@ kvm_mips_handle_mapped_seg_tlb_fault(struct kvm_vcpu *vcpu,
 	entryhi = (tlb->tlb_hi & VPN2_MASK) | (KVM_GUEST_KERNEL_MODE(vcpu) ?
 			kvm_mips_get_kernel_asid(vcpu) : kvm_mips_get_user_asid(vcpu));
 	entrylo0 = mips3_paddr_to_tlbpfn(pfn0 << PAGE_SHIFT) | (0x3 << 3) |
-			(tlb->tlb_lo0 & MIPS3_PG_D) | (tlb->tlb_lo0 & MIPS3_PG_V);
+			(tlb_lo[0] & MIPS3_PG_D) | (tlb_lo[0] & MIPS3_PG_V);
 	entrylo1 = mips3_paddr_to_tlbpfn(pfn1 << PAGE_SHIFT) | (0x3 << 3) |
-			(tlb->tlb_lo1 & MIPS3_PG_D) | (tlb->tlb_lo1 & MIPS3_PG_V);
+			(tlb_lo[1] & MIPS3_PG_D) | (tlb_lo[1] & MIPS3_PG_V);
 
 #ifdef DEBUG
 	kvm_debug("@ %#lx tlb_lo0: 0x%08lx tlb_lo1: 0x%08lx\n", vcpu->arch.pc,
-- 
2.9.3
