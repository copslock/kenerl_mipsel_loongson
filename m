Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Dec 2015 00:51:28 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:1965 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27014065AbbLPXuMe8rh0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Dec 2015 00:50:12 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id CA6574A18438F;
        Wed, 16 Dec 2015 23:50:01 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Wed, 16 Dec 2015 23:50:05 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 16 Dec 2015 23:50:05 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paolo Bonzini <pbonzini@redhat.com>
CC:     Gleb Natapov <gleb@kernel.org>, <linux-mips@linux-mips.org>,
        <kvm@vger.kernel.org>, James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 04/16] MIPS: KVM: Drop unused kvm_mips_host_tlb_inv_index()
Date:   Wed, 16 Dec 2015 23:49:29 +0000
Message-ID: <1450309781-28030-5-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1450309781-28030-1-git-send-email-james.hogan@imgtec.com>
References: <1450309781-28030-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50652
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

The function kvm_mips_host_tlb_inv_index() is unused, so drop it
completely.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h |  1 -
 arch/mips/kvm/tlb.c              | 37 -------------------------------------
 2 files changed, 38 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index b14265d8d606..16f647347357 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -678,7 +678,6 @@ extern void kvm_mips_dump_host_tlbs(void);
 extern void kvm_mips_dump_guest_tlbs(struct kvm_vcpu *vcpu);
 extern void kvm_mips_flush_host_tlb(int skip_kseg0);
 extern int kvm_mips_host_tlb_inv(struct kvm_vcpu *vcpu, unsigned long entryhi);
-extern int kvm_mips_host_tlb_inv_index(struct kvm_vcpu *vcpu, int index);
 
 extern int kvm_mips_guest_tlb_lookup(struct kvm_vcpu *vcpu,
 				     unsigned long entryhi);
diff --git a/arch/mips/kvm/tlb.c b/arch/mips/kvm/tlb.c
index 3d3f22301a35..2c0997447448 100644
--- a/arch/mips/kvm/tlb.c
+++ b/arch/mips/kvm/tlb.c
@@ -507,43 +507,6 @@ int kvm_mips_host_tlb_inv(struct kvm_vcpu *vcpu, unsigned long va)
 }
 EXPORT_SYMBOL(kvm_mips_host_tlb_inv);
 
-/* XXXKYMA: Fix Guest USER/KERNEL no longer share the same ASID */
-int kvm_mips_host_tlb_inv_index(struct kvm_vcpu *vcpu, int index)
-{
-	unsigned long flags, old_entryhi;
-
-	if (index >= current_cpu_data.tlbsize)
-		BUG();
-
-	local_irq_save(flags);
-
-	old_entryhi = read_c0_entryhi();
-
-	write_c0_entryhi(UNIQUE_ENTRYHI(index));
-	mtc0_tlbw_hazard();
-
-	write_c0_index(index);
-	mtc0_tlbw_hazard();
-
-	write_c0_entrylo0(0);
-	mtc0_tlbw_hazard();
-
-	write_c0_entrylo1(0);
-	mtc0_tlbw_hazard();
-
-	tlb_write_indexed();
-	mtc0_tlbw_hazard();
-	tlbw_use_hazard();
-
-	write_c0_entryhi(old_entryhi);
-	mtc0_tlbw_hazard();
-	tlbw_use_hazard();
-
-	local_irq_restore(flags);
-
-	return 0;
-}
-
 void kvm_mips_flush_host_tlb(int skip_kseg0)
 {
 	unsigned long flags;
-- 
2.4.10
