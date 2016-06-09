Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 15:22:58 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:5733 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27041089AbcFINToty4ci (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jun 2016 15:19:44 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 9E1EF812069C4;
        Thu,  9 Jun 2016 14:19:35 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 9 Jun 2016 14:19:38 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     James Hogan <james.hogan@imgtec.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 09/18] MIPS: KVM: Simplify even/odd TLB handling
Date:   Thu, 9 Jun 2016 14:19:12 +0100
Message-ID: <1465478361-7431-10-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 53924
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

When handling TLB faults in the guest KSeg0 region, a pair of physical
addresses are read from the guest physical address map. However that
process is rather convoluted with an if/then/else statement. Simplify it
to just clear the lowest bit for the even entry and set the lowest bit
for the odd entry.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/mmu.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index d5ada83ec55c..9924c1d253a7 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -87,7 +87,6 @@ int kvm_mips_handle_kseg0_tlb_fault(unsigned long badvaddr,
 	kvm_pfn_t pfn0, pfn1;
 	unsigned long vaddr = 0;
 	unsigned long entryhi = 0, entrylo0 = 0, entrylo1 = 0;
-	int even;
 	struct kvm *kvm = vcpu->kvm;
 	const int flush_dcache_mask = 0;
 	int ret;
@@ -105,7 +104,6 @@ int kvm_mips_handle_kseg0_tlb_fault(unsigned long badvaddr,
 		kvm_mips_dump_host_tlbs();
 		return -1;
 	}
-	even = !(gfn & 0x1);
 	vaddr = badvaddr & (PAGE_MASK << 1);
 
 	if (kvm_mips_map_page(vcpu->kvm, gfn) < 0)
@@ -114,13 +112,8 @@ int kvm_mips_handle_kseg0_tlb_fault(unsigned long badvaddr,
 	if (kvm_mips_map_page(vcpu->kvm, gfn ^ 0x1) < 0)
 		return -1;
 
-	if (even) {
-		pfn0 = kvm->arch.guest_pmap[gfn];
-		pfn1 = kvm->arch.guest_pmap[gfn ^ 0x1];
-	} else {
-		pfn0 = kvm->arch.guest_pmap[gfn ^ 0x1];
-		pfn1 = kvm->arch.guest_pmap[gfn];
-	}
+	pfn0 = kvm->arch.guest_pmap[gfn & ~0x1];
+	pfn1 = kvm->arch.guest_pmap[gfn | 0x1];
 
 	entrylo0 = mips3_paddr_to_tlbpfn(pfn0 << PAGE_SHIFT) | (0x3 << 3) |
 		   (1 << 2) | (0x1 << 1);
-- 
2.4.10
