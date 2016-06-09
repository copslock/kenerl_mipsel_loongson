Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 15:25:10 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:50264 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27041081AbcFINTrZAJzi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jun 2016 15:19:47 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 0F01AF02765F6;
        Thu,  9 Jun 2016 14:19:38 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 9 Jun 2016 14:19:41 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 12/18] MIPS: KVM: Clean up TLB management hazards
Date:   Thu, 9 Jun 2016 14:19:15 +0100
Message-ID: <1465478361-7431-13-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 53930
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

KVM's host TLB handling routines were using tlbw hazard barrier macros
around tlb_read(). Now that hazard barrier macros exist for tlbr, update
this case to use them.

Also fix various other unnecessary hazard barriers in this code.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/tlb.c | 27 +++++----------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/arch/mips/kvm/tlb.c b/arch/mips/kvm/tlb.c
index 37d77ad8431e..d3000680df1f 100644
--- a/arch/mips/kvm/tlb.c
+++ b/arch/mips/kvm/tlb.c
@@ -195,7 +195,6 @@ int kvm_mips_host_tlb_write(struct kvm_vcpu *vcpu, unsigned long entryhi,
 	/* Restore old ASID */
 	write_c0_entryhi(old_entryhi);
 	mtc0_tlbw_hazard();
-	tlbw_use_hazard();
 	local_irq_restore(flags);
 	return 0;
 }
@@ -219,15 +218,11 @@ int kvm_mips_handle_commpage_tlb_fault(unsigned long badvaddr,
 	old_entryhi = read_c0_entryhi();
 	vaddr = badvaddr & (PAGE_MASK << 1);
 	write_c0_entryhi(vaddr | kvm_mips_get_kernel_asid(vcpu));
-	mtc0_tlbw_hazard();
 	write_c0_entrylo0(entrylo0);
-	mtc0_tlbw_hazard();
 	write_c0_entrylo1(entrylo1);
-	mtc0_tlbw_hazard();
 	write_c0_index(kvm_mips_get_commpage_asid(vcpu));
 	mtc0_tlbw_hazard();
 	tlb_write_indexed();
-	mtc0_tlbw_hazard();
 	tlbw_use_hazard();
 
 	kvm_debug("@ %#lx idx: %2d [entryhi(R): %#lx] entrylo0 (R): 0x%08lx, entrylo1(R): 0x%08lx\n",
@@ -237,7 +232,6 @@ int kvm_mips_handle_commpage_tlb_fault(unsigned long badvaddr,
 	/* Restore old ASID */
 	write_c0_entryhi(old_entryhi);
 	mtc0_tlbw_hazard();
-	tlbw_use_hazard();
 	local_irq_restore(flags);
 
 	return 0;
@@ -291,7 +285,6 @@ int kvm_mips_host_tlb_lookup(struct kvm_vcpu *vcpu, unsigned long vaddr)
 	/* Restore old ASID */
 	write_c0_entryhi(old_entryhi);
 	mtc0_tlbw_hazard();
-	tlbw_use_hazard();
 
 	local_irq_restore(flags);
 
@@ -322,21 +315,16 @@ int kvm_mips_host_tlb_inv(struct kvm_vcpu *vcpu, unsigned long va)
 
 	if (idx > 0) {
 		write_c0_entryhi(UNIQUE_ENTRYHI(idx));
-		mtc0_tlbw_hazard();
-
 		write_c0_entrylo0(0);
-		mtc0_tlbw_hazard();
-
 		write_c0_entrylo1(0);
 		mtc0_tlbw_hazard();
 
 		tlb_write_indexed();
-		mtc0_tlbw_hazard();
+		tlbw_use_hazard();
 	}
 
 	write_c0_entryhi(old_entryhi);
 	mtc0_tlbw_hazard();
-	tlbw_use_hazard();
 
 	local_irq_restore(flags);
 
@@ -364,11 +352,11 @@ void kvm_mips_flush_host_tlb(int skip_kseg0)
 	/* Blast 'em all away. */
 	for (entry = 0; entry < maxentry; entry++) {
 		write_c0_index(entry);
-		mtc0_tlbw_hazard();
 
 		if (skip_kseg0) {
+			mtc0_tlbr_hazard();
 			tlb_read();
-			tlbw_use_hazard();
+			tlb_read_hazard();
 
 			entryhi = read_c0_entryhi();
 
@@ -379,22 +367,17 @@ void kvm_mips_flush_host_tlb(int skip_kseg0)
 
 		/* Make sure all entries differ. */
 		write_c0_entryhi(UNIQUE_ENTRYHI(entry));
-		mtc0_tlbw_hazard();
 		write_c0_entrylo0(0);
-		mtc0_tlbw_hazard();
 		write_c0_entrylo1(0);
 		mtc0_tlbw_hazard();
 
 		tlb_write_indexed();
-		mtc0_tlbw_hazard();
+		tlbw_use_hazard();
 	}
 
-	tlbw_use_hazard();
-
 	write_c0_entryhi(old_entryhi);
 	write_c0_pagemask(old_pagemask);
 	mtc0_tlbw_hazard();
-	tlbw_use_hazard();
 
 	local_irq_restore(flags);
 }
@@ -419,9 +402,9 @@ void kvm_local_flush_tlb_all(void)
 		write_c0_index(entry);
 		mtc0_tlbw_hazard();
 		tlb_write_indexed();
+		tlbw_use_hazard();
 		entry++;
 	}
-	tlbw_use_hazard();
 	write_c0_entryhi(old_ctx);
 	mtc0_tlbw_hazard();
 
-- 
2.4.10
