Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 15:22:00 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:56598 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27041085AbcFINTo1gL6i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jun 2016 15:19:44 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id C12D7F010164;
        Thu,  9 Jun 2016 14:19:39 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 9 Jun 2016 14:19:42 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 14/18] MIPS: KVM: Arrayify struct kvm_mips_tlb::tlb_lo*
Date:   Thu, 9 Jun 2016 14:19:17 +0100
Message-ID: <1465478361-7431-15-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 53921
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

The values of the EntryLo0 and EntryLo1 registers for a TLB entry are
stored in separate members of struct kvm_mips_tlb called tlb_lo0 and
tlb_lo1 respectively. To allow future code which needs to manipulate
arbitrary EntryLo data in the TLB entry to be simpler and less
conditional, replace these members with an array of two elements.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h | 11 +++++------
 arch/mips/kvm/emulate.c          | 10 +++++-----
 arch/mips/kvm/mmu.c              | 20 +++++++++++---------
 arch/mips/kvm/tlb.c              | 21 +++++++++++----------
 4 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 24a8e557db88..2d15da111ba8 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -310,13 +310,13 @@ enum emulation_result {
 
 #define VPN2_MASK		0xffffe000
 #define KVM_ENTRYHI_ASID	MIPS_ENTRYHI_ASID
-#define TLB_IS_GLOBAL(x)	(((x).tlb_lo0 & MIPS3_PG_G) &&		\
-				 ((x).tlb_lo1 & MIPS3_PG_G))
+#define TLB_IS_GLOBAL(x)	(((x).tlb_lo[0] & MIPS3_PG_G) &&	\
+				 ((x).tlb_lo[1] & MIPS3_PG_G))
 #define TLB_VPN2(x)		((x).tlb_hi & VPN2_MASK)
 #define TLB_ASID(x)		((x).tlb_hi & KVM_ENTRYHI_ASID)
 #define TLB_IS_VALID(x, va)	(((va) & (1 << PAGE_SHIFT))		\
-				 ? ((x).tlb_lo1 & MIPS3_PG_V)		\
-				 : ((x).tlb_lo0 & MIPS3_PG_V))
+				 ? ((x).tlb_lo[1] & MIPS3_PG_V)		\
+				 : ((x).tlb_lo[0] & MIPS3_PG_V))
 #define TLB_HI_VPN2_HIT(x, y)	((TLB_VPN2(x) & ~(x).tlb_mask) ==	\
 				 ((y) & VPN2_MASK & ~(x).tlb_mask))
 #define TLB_HI_ASID_HIT(x, y)	(TLB_IS_GLOBAL(x) ||			\
@@ -325,8 +325,7 @@ enum emulation_result {
 struct kvm_mips_tlb {
 	long tlb_mask;
 	long tlb_hi;
-	long tlb_lo0;
-	long tlb_lo1;
+	long tlb_lo[2];
 };
 
 #define KVM_MIPS_FPU_FPU	0x1
diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index fb77fb469776..5b89c0803405 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -833,8 +833,8 @@ enum emulation_result kvm_mips_emul_tlbwi(struct kvm_vcpu *vcpu)
 
 	tlb->tlb_mask = kvm_read_c0_guest_pagemask(cop0);
 	tlb->tlb_hi = kvm_read_c0_guest_entryhi(cop0);
-	tlb->tlb_lo0 = kvm_read_c0_guest_entrylo0(cop0);
-	tlb->tlb_lo1 = kvm_read_c0_guest_entrylo1(cop0);
+	tlb->tlb_lo[0] = kvm_read_c0_guest_entrylo0(cop0);
+	tlb->tlb_lo[1] = kvm_read_c0_guest_entrylo1(cop0);
 
 	kvm_debug("[%#lx] COP0_TLBWI [%d] (entryhi: %#lx, entrylo0: %#lx entrylo1: %#lx, mask: %#lx)\n",
 		  pc, index, kvm_read_c0_guest_entryhi(cop0),
@@ -866,8 +866,8 @@ enum emulation_result kvm_mips_emul_tlbwr(struct kvm_vcpu *vcpu)
 
 	tlb->tlb_mask = kvm_read_c0_guest_pagemask(cop0);
 	tlb->tlb_hi = kvm_read_c0_guest_entryhi(cop0);
-	tlb->tlb_lo0 = kvm_read_c0_guest_entrylo0(cop0);
-	tlb->tlb_lo1 = kvm_read_c0_guest_entrylo1(cop0);
+	tlb->tlb_lo[0] = kvm_read_c0_guest_entrylo0(cop0);
+	tlb->tlb_lo[1] = kvm_read_c0_guest_entrylo1(cop0);
 
 	kvm_debug("[%#lx] COP0_TLBWR[%d] (entryhi: %#lx, entrylo0: %#lx entrylo1: %#lx)\n",
 		  pc, index, kvm_read_c0_guest_entryhi(cop0),
@@ -2592,7 +2592,7 @@ enum emulation_result kvm_mips_handle_tlbmiss(u32 cause,
 			}
 		} else {
 			kvm_debug("Injecting hi: %#lx, lo0: %#lx, lo1: %#lx into shadow host TLB\n",
-				  tlb->tlb_hi, tlb->tlb_lo0, tlb->tlb_lo1);
+				  tlb->tlb_hi, tlb->tlb_lo[0], tlb->tlb_lo[1]);
 			/*
 			 * OK we have a Guest TLB entry, now inject it into the
 			 * shadow host TLB
diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index 4d42b47b500b..14996aa5e7c4 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -141,28 +141,30 @@ int kvm_mips_handle_mapped_seg_tlb_fault(struct kvm_vcpu *vcpu,
 		pfn0 = 0;
 		pfn1 = 0;
 	} else {
-		if (kvm_mips_map_page(kvm, mips3_tlbpfn_to_paddr(tlb->tlb_lo0)
+		if (kvm_mips_map_page(kvm, mips3_tlbpfn_to_paddr(tlb->tlb_lo[0])
 					   >> PAGE_SHIFT) < 0)
 			return -1;
 
-		if (kvm_mips_map_page(kvm, mips3_tlbpfn_to_paddr(tlb->tlb_lo1)
+		if (kvm_mips_map_page(kvm, mips3_tlbpfn_to_paddr(tlb->tlb_lo[1])
 					   >> PAGE_SHIFT) < 0)
 			return -1;
 
-		pfn0 = kvm->arch.guest_pmap[mips3_tlbpfn_to_paddr(tlb->tlb_lo0)
-					    >> PAGE_SHIFT];
-		pfn1 = kvm->arch.guest_pmap[mips3_tlbpfn_to_paddr(tlb->tlb_lo1)
-					    >> PAGE_SHIFT];
+		pfn0 = kvm->arch.guest_pmap[
+			mips3_tlbpfn_to_paddr(tlb->tlb_lo[0]) >> PAGE_SHIFT];
+		pfn1 = kvm->arch.guest_pmap[
+			mips3_tlbpfn_to_paddr(tlb->tlb_lo[1]) >> PAGE_SHIFT];
 	}
 
 	/* Get attributes from the Guest TLB */
 	entrylo0 = mips3_paddr_to_tlbpfn(pfn0 << PAGE_SHIFT) | (0x3 << 3) |
-		   (tlb->tlb_lo0 & MIPS3_PG_D) | (tlb->tlb_lo0 & MIPS3_PG_V);
+		   (tlb->tlb_lo[0] & MIPS3_PG_D) |
+		   (tlb->tlb_lo[0] & MIPS3_PG_V);
 	entrylo1 = mips3_paddr_to_tlbpfn(pfn1 << PAGE_SHIFT) | (0x3 << 3) |
-		   (tlb->tlb_lo1 & MIPS3_PG_D) | (tlb->tlb_lo1 & MIPS3_PG_V);
+		   (tlb->tlb_lo[1] & MIPS3_PG_D) |
+		   (tlb->tlb_lo[1] & MIPS3_PG_V);
 
 	kvm_debug("@ %#lx tlb_lo0: 0x%08lx tlb_lo1: 0x%08lx\n", vcpu->arch.pc,
-		  tlb->tlb_lo0, tlb->tlb_lo1);
+		  tlb->tlb_lo[0], tlb->tlb_lo[1]);
 
 	preempt_disable();
 	entryhi = (tlb->tlb_hi & VPN2_MASK) | (KVM_GUEST_KERNEL_MODE(vcpu) ?
diff --git a/arch/mips/kvm/tlb.c b/arch/mips/kvm/tlb.c
index c0b8e3fc895e..4825d0dbb65e 100644
--- a/arch/mips/kvm/tlb.c
+++ b/arch/mips/kvm/tlb.c
@@ -86,18 +86,19 @@ void kvm_mips_dump_guest_tlbs(struct kvm_vcpu *vcpu)
 	for (i = 0; i < KVM_MIPS_GUEST_TLB_SIZE; i++) {
 		tlb = vcpu->arch.guest_tlb[i];
 		kvm_info("TLB%c%3d Hi 0x%08lx ",
-			 (tlb.tlb_lo0 | tlb.tlb_lo1) & MIPS3_PG_V ? ' ' : '*',
+			 (tlb.tlb_lo[0] | tlb.tlb_lo[1]) & MIPS3_PG_V
+							? ' ' : '*',
 			 i, tlb.tlb_hi);
 		kvm_info("Lo0=0x%09llx %c%c attr %lx ",
-			 (u64) mips3_tlbpfn_to_paddr(tlb.tlb_lo0),
-			 (tlb.tlb_lo0 & MIPS3_PG_D) ? 'D' : ' ',
-			 (tlb.tlb_lo0 & MIPS3_PG_G) ? 'G' : ' ',
-			 (tlb.tlb_lo0 >> 3) & 7);
+			 (u64) mips3_tlbpfn_to_paddr(tlb.tlb_lo[0]),
+			 (tlb.tlb_lo[0] & MIPS3_PG_D) ? 'D' : ' ',
+			 (tlb.tlb_lo[0] & MIPS3_PG_G) ? 'G' : ' ',
+			 (tlb.tlb_lo[0] >> 3) & 7);
 		kvm_info("Lo1=0x%09llx %c%c attr %lx sz=%lx\n",
-			 (u64) mips3_tlbpfn_to_paddr(tlb.tlb_lo1),
-			 (tlb.tlb_lo1 & MIPS3_PG_D) ? 'D' : ' ',
-			 (tlb.tlb_lo1 & MIPS3_PG_G) ? 'G' : ' ',
-			 (tlb.tlb_lo1 >> 3) & 7, tlb.tlb_mask);
+			 (u64) mips3_tlbpfn_to_paddr(tlb.tlb_lo[1]),
+			 (tlb.tlb_lo[1] & MIPS3_PG_D) ? 'D' : ' ',
+			 (tlb.tlb_lo[1] & MIPS3_PG_G) ? 'G' : ' ',
+			 (tlb.tlb_lo[1] >> 3) & 7, tlb.tlb_mask);
 	}
 }
 EXPORT_SYMBOL_GPL(kvm_mips_dump_guest_tlbs);
@@ -219,7 +220,7 @@ int kvm_mips_guest_tlb_lookup(struct kvm_vcpu *vcpu, unsigned long entryhi)
 	}
 
 	kvm_debug("%s: entryhi: %#lx, index: %d lo0: %#lx, lo1: %#lx\n",
-		  __func__, entryhi, index, tlb[i].tlb_lo0, tlb[i].tlb_lo1);
+		  __func__, entryhi, index, tlb[i].tlb_lo[0], tlb[i].tlb_lo[1]);
 
 	return index;
 }
-- 
2.4.10
