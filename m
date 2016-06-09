Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 15:23:36 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:18957 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27041103AbcFINTp60eBi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jun 2016 15:19:45 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 92FBCF387829E;
        Thu,  9 Jun 2016 14:19:36 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 9 Jun 2016 14:19:39 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     James Hogan <james.hogan@imgtec.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 10/18] MIPS: KVM: Drop unused hpa0/hpa1 args from function
Date:   Thu, 9 Jun 2016 14:19:13 +0100
Message-ID: <1465478361-7431-11-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 53926
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

The function kvm_mips_handle_mapped_seg_tlb_fault() has two completely
unused pointer arguments, hpa0 and hpa1, for which all users always pass
NULL.

Drop these two arguments and update the callers.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h |  4 +---
 arch/mips/kvm/emulate.c          |  7 ++-----
 arch/mips/kvm/mmu.c              | 13 ++-----------
 3 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index c8f9671c2779..f68293b4a598 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -630,9 +630,7 @@ extern int kvm_mips_handle_commpage_tlb_fault(unsigned long badvaddr,
 					      struct kvm_vcpu *vcpu);
 
 extern int kvm_mips_handle_mapped_seg_tlb_fault(struct kvm_vcpu *vcpu,
-						struct kvm_mips_tlb *tlb,
-						unsigned long *hpa0,
-						unsigned long *hpa1);
+						struct kvm_mips_tlb *tlb);
 
 extern enum emulation_result kvm_mips_handle_tlbmiss(u32 cause,
 						     u32 *opc,
diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index 3baab5ec3d3b..fb77fb469776 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -1633,9 +1633,7 @@ enum emulation_result kvm_mips_emulate_cache(u32 inst, u32 *opc,
 				 * We fault an entry from the guest tlb to the
 				 * shadow host TLB
 				 */
-				kvm_mips_handle_mapped_seg_tlb_fault(vcpu, tlb,
-								     NULL,
-								     NULL);
+				kvm_mips_handle_mapped_seg_tlb_fault(vcpu, tlb);
 			}
 		}
 	} else {
@@ -2599,8 +2597,7 @@ enum emulation_result kvm_mips_handle_tlbmiss(u32 cause,
 			 * OK we have a Guest TLB entry, now inject it into the
 			 * shadow host TLB
 			 */
-			kvm_mips_handle_mapped_seg_tlb_fault(vcpu, tlb, NULL,
-							     NULL);
+			kvm_mips_handle_mapped_seg_tlb_fault(vcpu, tlb);
 		}
 	}
 
diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index 9924c1d253a7..4d42b47b500b 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -130,9 +130,7 @@ int kvm_mips_handle_kseg0_tlb_fault(unsigned long badvaddr,
 }
 
 int kvm_mips_handle_mapped_seg_tlb_fault(struct kvm_vcpu *vcpu,
-					 struct kvm_mips_tlb *tlb,
-					 unsigned long *hpa0,
-					 unsigned long *hpa1)
+					 struct kvm_mips_tlb *tlb)
 {
 	unsigned long entryhi = 0, entrylo0 = 0, entrylo1 = 0;
 	struct kvm *kvm = vcpu->kvm;
@@ -157,12 +155,6 @@ int kvm_mips_handle_mapped_seg_tlb_fault(struct kvm_vcpu *vcpu,
 					    >> PAGE_SHIFT];
 	}
 
-	if (hpa0)
-		*hpa0 = pfn0 << PAGE_SHIFT;
-
-	if (hpa1)
-		*hpa1 = pfn1 << PAGE_SHIFT;
-
 	/* Get attributes from the Guest TLB */
 	entrylo0 = mips3_paddr_to_tlbpfn(pfn0 << PAGE_SHIFT) | (0x3 << 3) |
 		   (tlb->tlb_lo0 & MIPS3_PG_D) | (tlb->tlb_lo0 & MIPS3_PG_V);
@@ -354,8 +346,7 @@ u32 kvm_get_inst(u32 *opc, struct kvm_vcpu *vcpu)
 			}
 			kvm_mips_handle_mapped_seg_tlb_fault(vcpu,
 							     &vcpu->arch.
-							     guest_tlb[index],
-							     NULL, NULL);
+							     guest_tlb[index]);
 			inst = *(opc);
 		}
 		local_irq_restore(flags);
-- 
2.4.10
