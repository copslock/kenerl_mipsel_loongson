Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 15:23:18 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:56598 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27041098AbcFINTprSy3i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jun 2016 15:19:45 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 2C68CFC69CBA2;
        Thu,  9 Jun 2016 14:19:41 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 9 Jun 2016 14:19:44 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 16/18] MIPS: KVM: Use MIPS_ENTRYLO_* defs from mipsregs.h
Date:   Thu, 9 Jun 2016 14:19:19 +0100
Message-ID: <1465478361-7431-17-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1465478361-7431-1-git-send-email-james.hogan@imgtec.com>
References: <1465478361-7431-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53925
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

Convert KVM to use the MIPS_ENTRYLO_* definitions from <asm/mipsregs.h>
rather than custom definitions in kvm_host.h

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h | 11 ++++-------
 arch/mips/kvm/mmu.c              | 22 ++++++++++++----------
 arch/mips/kvm/tlb.c              | 23 ++++++++++++-----------
 3 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 83a3212b956d..d0432b5f2343 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -19,6 +19,8 @@
 #include <linux/threads.h>
 #include <linux/spinlock.h>
 
+#include <asm/mipsregs.h>
+
 /* MIPS KVM register ids */
 #define MIPS_CP0_32(_R, _S)					\
 	(KVM_REG_MIPS_CP0 | KVM_REG_SIZE_U32 | (8 * (_R) + (_S)))
@@ -295,11 +297,6 @@ enum emulation_result {
 	EMULATE_PRIV_FAIL,
 };
 
-#define MIPS3_PG_G	0x00000001 /* Global; ignore ASID if in lo0 & lo1 */
-#define MIPS3_PG_V	0x00000002 /* Valid */
-#define MIPS3_PG_NV	0x00000000
-#define MIPS3_PG_D	0x00000004 /* Dirty */
-
 #define mips3_paddr_to_tlbpfn(x) \
 	(((unsigned long)(x) >> MIPS3_PG_SHIFT) & MIPS3_PG_FRAME)
 #define mips3_tlbpfn_to_paddr(x) \
@@ -310,11 +307,11 @@ enum emulation_result {
 
 #define VPN2_MASK		0xffffe000
 #define KVM_ENTRYHI_ASID	MIPS_ENTRYHI_ASID
-#define TLB_IS_GLOBAL(x)	((x).tlb_lo[0] & (x).tlb_lo[1] & MIPS3_PG_G)
+#define TLB_IS_GLOBAL(x)	((x).tlb_lo[0] & (x).tlb_lo[1] & ENTRYLO_G)
 #define TLB_VPN2(x)		((x).tlb_hi & VPN2_MASK)
 #define TLB_ASID(x)		((x).tlb_hi & KVM_ENTRYHI_ASID)
 #define TLB_LO_IDX(x, va)	(((va) >> PAGE_SHIFT) & 1)
-#define TLB_IS_VALID(x, va)	((x).tlb_lo[TLB_LO_IDX(x, va)] & MIPS3_PG_V)
+#define TLB_IS_VALID(x, va)	((x).tlb_lo[TLB_LO_IDX(x, va)] & ENTRYLO_V)
 #define TLB_HI_VPN2_HIT(x, y)	((TLB_VPN2(x) & ~(x).tlb_mask) ==	\
 				 ((y) & VPN2_MASK & ~(x).tlb_mask))
 #define TLB_HI_ASID_HIT(x, y)	(TLB_IS_GLOBAL(x) ||			\
diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index 14996aa5e7c4..ad3125fa9c61 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -115,10 +115,10 @@ int kvm_mips_handle_kseg0_tlb_fault(unsigned long badvaddr,
 	pfn0 = kvm->arch.guest_pmap[gfn & ~0x1];
 	pfn1 = kvm->arch.guest_pmap[gfn | 0x1];
 
-	entrylo0 = mips3_paddr_to_tlbpfn(pfn0 << PAGE_SHIFT) | (0x3 << 3) |
-		   (1 << 2) | (0x1 << 1);
-	entrylo1 = mips3_paddr_to_tlbpfn(pfn1 << PAGE_SHIFT) | (0x3 << 3) |
-		   (1 << 2) | (0x1 << 1);
+	entrylo0 = mips3_paddr_to_tlbpfn(pfn0 << PAGE_SHIFT) |
+		   (0x3 << ENTRYLO_C_SHIFT) | ENTRYLO_D | ENTRYLO_V;
+	entrylo1 = mips3_paddr_to_tlbpfn(pfn1 << PAGE_SHIFT) |
+		   (0x3 << ENTRYLO_C_SHIFT) | ENTRYLO_D | ENTRYLO_V;
 
 	preempt_disable();
 	entryhi = (vaddr | kvm_mips_get_kernel_asid(vcpu));
@@ -156,12 +156,14 @@ int kvm_mips_handle_mapped_seg_tlb_fault(struct kvm_vcpu *vcpu,
 	}
 
 	/* Get attributes from the Guest TLB */
-	entrylo0 = mips3_paddr_to_tlbpfn(pfn0 << PAGE_SHIFT) | (0x3 << 3) |
-		   (tlb->tlb_lo[0] & MIPS3_PG_D) |
-		   (tlb->tlb_lo[0] & MIPS3_PG_V);
-	entrylo1 = mips3_paddr_to_tlbpfn(pfn1 << PAGE_SHIFT) | (0x3 << 3) |
-		   (tlb->tlb_lo[1] & MIPS3_PG_D) |
-		   (tlb->tlb_lo[1] & MIPS3_PG_V);
+	entrylo0 = mips3_paddr_to_tlbpfn(pfn0 << PAGE_SHIFT) |
+		   (0x3 << ENTRYLO_C_SHIFT) |
+		   (tlb->tlb_lo[0] & ENTRYLO_D) |
+		   (tlb->tlb_lo[0] & ENTRYLO_V);
+	entrylo1 = mips3_paddr_to_tlbpfn(pfn1 << PAGE_SHIFT) |
+		   (0x3 << ENTRYLO_C_SHIFT) |
+		   (tlb->tlb_lo[1] & ENTRYLO_D) |
+		   (tlb->tlb_lo[1] & ENTRYLO_V);
 
 	kvm_debug("@ %#lx tlb_lo0: 0x%08lx tlb_lo1: 0x%08lx\n", vcpu->arch.pc,
 		  tlb->tlb_lo[0], tlb->tlb_lo[1]);
diff --git a/arch/mips/kvm/tlb.c b/arch/mips/kvm/tlb.c
index 4825d0dbb65e..8012e686d4ae 100644
--- a/arch/mips/kvm/tlb.c
+++ b/arch/mips/kvm/tlb.c
@@ -86,19 +86,20 @@ void kvm_mips_dump_guest_tlbs(struct kvm_vcpu *vcpu)
 	for (i = 0; i < KVM_MIPS_GUEST_TLB_SIZE; i++) {
 		tlb = vcpu->arch.guest_tlb[i];
 		kvm_info("TLB%c%3d Hi 0x%08lx ",
-			 (tlb.tlb_lo[0] | tlb.tlb_lo[1]) & MIPS3_PG_V
+			 (tlb.tlb_lo[0] | tlb.tlb_lo[1]) & ENTRYLO_V
 							? ' ' : '*',
 			 i, tlb.tlb_hi);
 		kvm_info("Lo0=0x%09llx %c%c attr %lx ",
 			 (u64) mips3_tlbpfn_to_paddr(tlb.tlb_lo[0]),
-			 (tlb.tlb_lo[0] & MIPS3_PG_D) ? 'D' : ' ',
-			 (tlb.tlb_lo[0] & MIPS3_PG_G) ? 'G' : ' ',
-			 (tlb.tlb_lo[0] >> 3) & 7);
+			 (tlb.tlb_lo[0] & ENTRYLO_D) ? 'D' : ' ',
+			 (tlb.tlb_lo[0] & ENTRYLO_G) ? 'G' : ' ',
+			 (tlb.tlb_lo[0] & ENTRYLO_C) >> ENTRYLO_C_SHIFT);
 		kvm_info("Lo1=0x%09llx %c%c attr %lx sz=%lx\n",
 			 (u64) mips3_tlbpfn_to_paddr(tlb.tlb_lo[1]),
-			 (tlb.tlb_lo[1] & MIPS3_PG_D) ? 'D' : ' ',
-			 (tlb.tlb_lo[1] & MIPS3_PG_G) ? 'G' : ' ',
-			 (tlb.tlb_lo[1] >> 3) & 7, tlb.tlb_mask);
+			 (tlb.tlb_lo[1] & ENTRYLO_D) ? 'D' : ' ',
+			 (tlb.tlb_lo[1] & ENTRYLO_G) ? 'G' : ' ',
+			 (tlb.tlb_lo[1] & ENTRYLO_C) >> ENTRYLO_C_SHIFT,
+			 tlb.tlb_mask);
 	}
 }
 EXPORT_SYMBOL_GPL(kvm_mips_dump_guest_tlbs);
@@ -146,12 +147,12 @@ int kvm_mips_host_tlb_write(struct kvm_vcpu *vcpu, unsigned long entryhi,
 
 	/* Flush D-cache */
 	if (flush_dcache_mask) {
-		if (entrylo0 & MIPS3_PG_V) {
+		if (entrylo0 & ENTRYLO_V) {
 			++vcpu->stat.flush_dcache_exits;
 			flush_data_cache_page((entryhi & VPN2_MASK) &
 					      ~flush_dcache_mask);
 		}
-		if (entrylo1 & MIPS3_PG_V) {
+		if (entrylo1 & ENTRYLO_V) {
 			++vcpu->stat.flush_dcache_exits;
 			flush_data_cache_page(((entryhi & VPN2_MASK) &
 					       ~flush_dcache_mask) |
@@ -176,8 +177,8 @@ int kvm_mips_handle_commpage_tlb_fault(unsigned long badvaddr,
 
 	pfn0 = CPHYSADDR(vcpu->arch.kseg0_commpage) >> PAGE_SHIFT;
 	pfn1 = 0;
-	entrylo0 = mips3_paddr_to_tlbpfn(pfn0 << PAGE_SHIFT) | (0x3 << 3) |
-		   (1 << 2) | (0x1 << 1);
+	entrylo0 = mips3_paddr_to_tlbpfn(pfn0 << PAGE_SHIFT) |
+		   (0x3 << ENTRYLO_C_SHIFT) | ENTRYLO_D | ENTRYLO_V;
 	entrylo1 = 0;
 
 	local_irq_save(flags);
-- 
2.4.10
