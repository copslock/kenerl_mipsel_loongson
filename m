Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 15:25:51 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:38355 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27041112AbcFINTuEMwui (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jun 2016 15:19:50 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 022DFDF412252;
        Thu,  9 Jun 2016 14:19:39 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 9 Jun 2016 14:19:41 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 13/18] MIPS: KVM: Use dump_tlb_all() for kvm_mips_dump_host_tlbs()
Date:   Thu, 9 Jun 2016 14:19:16 +0100
Message-ID: <1465478361-7431-14-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 53932
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

KVM implements its own routine for dumping the host TLB entries, but we
already have dump_tlb_all() which does something very similar (although
it only prints out TLB entries which match the current ASID or are
global).

Make KVM use dump_tlb_all() along with dump_tlb_regs() to avoid the
duplication and inevitable bitrot, allowing TLB dumping enhancements
(e.g. for VZ and GuestIDs) to be made in a single place.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/tlb.c | 42 ++++--------------------------------------
 1 file changed, 4 insertions(+), 38 deletions(-)

diff --git a/arch/mips/kvm/tlb.c b/arch/mips/kvm/tlb.c
index d3000680df1f..c0b8e3fc895e 100644
--- a/arch/mips/kvm/tlb.c
+++ b/arch/mips/kvm/tlb.c
@@ -24,6 +24,7 @@
 #include <asm/pgtable.h>
 #include <asm/cacheflush.h>
 #include <asm/tlb.h>
+#include <asm/tlbdebug.h>
 
 #undef CONFIG_MIPS_MT
 #include <asm/r4kcache.h>
@@ -60,50 +61,15 @@ inline u32 kvm_mips_get_commpage_asid(struct kvm_vcpu *vcpu)
 
 void kvm_mips_dump_host_tlbs(void)
 {
-	unsigned long old_entryhi;
-	unsigned long old_pagemask;
-	struct kvm_mips_tlb tlb;
 	unsigned long flags;
-	int i;
 
 	local_irq_save(flags);
 
-	old_entryhi = read_c0_entryhi();
-	old_pagemask = read_c0_pagemask();
-
 	kvm_info("HOST TLBs:\n");
-	kvm_info("ASID: %#lx\n", read_c0_entryhi() &
-		 cpu_asid_mask(&current_cpu_data));
+	dump_tlb_regs();
+	pr_info("\n");
+	dump_tlb_all();
 
-	for (i = 0; i < current_cpu_data.tlbsize; i++) {
-		write_c0_index(i);
-		mtc0_tlbw_hazard();
-
-		tlb_read();
-		tlbw_use_hazard();
-
-		tlb.tlb_hi = read_c0_entryhi();
-		tlb.tlb_lo0 = read_c0_entrylo0();
-		tlb.tlb_lo1 = read_c0_entrylo1();
-		tlb.tlb_mask = read_c0_pagemask();
-
-		kvm_info("TLB%c%3d Hi 0x%08lx ",
-			 (tlb.tlb_lo0 | tlb.tlb_lo1) & MIPS3_PG_V ? ' ' : '*',
-			 i, tlb.tlb_hi);
-		kvm_info("Lo0=0x%09llx %c%c attr %lx ",
-			 (u64) mips3_tlbpfn_to_paddr(tlb.tlb_lo0),
-			 (tlb.tlb_lo0 & MIPS3_PG_D) ? 'D' : ' ',
-			 (tlb.tlb_lo0 & MIPS3_PG_G) ? 'G' : ' ',
-			 (tlb.tlb_lo0 >> 3) & 7);
-		kvm_info("Lo1=0x%09llx %c%c attr %lx sz=%lx\n",
-			 (u64) mips3_tlbpfn_to_paddr(tlb.tlb_lo1),
-			 (tlb.tlb_lo1 & MIPS3_PG_D) ? 'D' : ' ',
-			 (tlb.tlb_lo1 & MIPS3_PG_G) ? 'G' : ' ',
-			 (tlb.tlb_lo1 >> 3) & 7, tlb.tlb_mask);
-	}
-	write_c0_entryhi(old_entryhi);
-	write_c0_pagemask(old_pagemask);
-	mtc0_tlbw_hazard();
 	local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(kvm_mips_dump_host_tlbs);
-- 
2.4.10
