Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jun 2016 20:34:39 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:22679 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27042348AbcFOSaWM-MeW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Jun 2016 20:30:22 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id B1BA8807C2736;
        Wed, 15 Jun 2016 19:30:11 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 15 Jun 2016 19:30:15 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 14/17] MIPS: KVM: Use host CCA for TLB mappings
Date:   Wed, 15 Jun 2016 19:29:58 +0100
Message-ID: <1466015401-24433-15-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1466015401-24433-1-git-send-email-james.hogan@imgtec.com>
References: <1466015401-24433-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54068
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

KVM TLB mappings for the guest were being created with a cache coherency
attribute (CCA) of 3, which is cached incoherent. Create them instead
with the default host CCA, which should be the correct one for coherency
on SMP systems.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/mmu.c | 18 ++++++++++--------
 arch/mips/kvm/tlb.c |  3 ++-
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index 2f494ec5c939..ecead748de04 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -116,9 +116,11 @@ int kvm_mips_handle_kseg0_tlb_fault(unsigned long badvaddr,
 	pfn1 = kvm->arch.guest_pmap[gfn | 0x1];
 
 	entrylo0 = mips3_paddr_to_tlbpfn(pfn0 << PAGE_SHIFT) |
-		   (0x3 << ENTRYLO_C_SHIFT) | ENTRYLO_D | ENTRYLO_V;
+		((_page_cachable_default >> _CACHE_SHIFT) << ENTRYLO_C_SHIFT) |
+		ENTRYLO_D | ENTRYLO_V;
 	entrylo1 = mips3_paddr_to_tlbpfn(pfn1 << PAGE_SHIFT) |
-		   (0x3 << ENTRYLO_C_SHIFT) | ENTRYLO_D | ENTRYLO_V;
+		((_page_cachable_default >> _CACHE_SHIFT) << ENTRYLO_C_SHIFT) |
+		ENTRYLO_D | ENTRYLO_V;
 
 	preempt_disable();
 	entryhi = (vaddr | kvm_mips_get_kernel_asid(vcpu));
@@ -157,13 +159,13 @@ int kvm_mips_handle_mapped_seg_tlb_fault(struct kvm_vcpu *vcpu,
 
 	/* Get attributes from the Guest TLB */
 	entrylo0 = mips3_paddr_to_tlbpfn(pfn0 << PAGE_SHIFT) |
-		   (0x3 << ENTRYLO_C_SHIFT) |
-		   (tlb->tlb_lo[0] & ENTRYLO_D) |
-		   (tlb->tlb_lo[0] & ENTRYLO_V);
+		((_page_cachable_default >> _CACHE_SHIFT) << ENTRYLO_C_SHIFT) |
+		(tlb->tlb_lo[0] & ENTRYLO_D) |
+		(tlb->tlb_lo[0] & ENTRYLO_V);
 	entrylo1 = mips3_paddr_to_tlbpfn(pfn1 << PAGE_SHIFT) |
-		   (0x3 << ENTRYLO_C_SHIFT) |
-		   (tlb->tlb_lo[1] & ENTRYLO_D) |
-		   (tlb->tlb_lo[1] & ENTRYLO_V);
+		((_page_cachable_default >> _CACHE_SHIFT) << ENTRYLO_C_SHIFT) |
+		(tlb->tlb_lo[1] & ENTRYLO_D) |
+		(tlb->tlb_lo[1] & ENTRYLO_V);
 
 	kvm_debug("@ %#lx tlb_lo0: 0x%08lx tlb_lo1: 0x%08lx\n", vcpu->arch.pc,
 		  tlb->tlb_lo[0], tlb->tlb_lo[1]);
diff --git a/arch/mips/kvm/tlb.c b/arch/mips/kvm/tlb.c
index 385fbd34e77d..9699352293e4 100644
--- a/arch/mips/kvm/tlb.c
+++ b/arch/mips/kvm/tlb.c
@@ -179,7 +179,8 @@ int kvm_mips_handle_commpage_tlb_fault(unsigned long badvaddr,
 	pfn = CPHYSADDR(vcpu->arch.kseg0_commpage) >> PAGE_SHIFT;
 	pair_idx = (badvaddr >> PAGE_SHIFT) & 1;
 	entrylo[pair_idx] = mips3_paddr_to_tlbpfn(pfn << PAGE_SHIFT) |
-		(0x3 << ENTRYLO_C_SHIFT) | ENTRYLO_D | ENTRYLO_V;
+		((_page_cachable_default >> _CACHE_SHIFT) << ENTRYLO_C_SHIFT) |
+		ENTRYLO_D | ENTRYLO_V;
 
 	local_irq_save(flags);
 
-- 
2.4.10
