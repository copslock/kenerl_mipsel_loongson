Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 15:24:33 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:56598 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27041105AbcFINTqj5xBi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jun 2016 15:19:46 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id A813FD425FE92;
        Thu,  9 Jun 2016 14:19:42 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 9 Jun 2016 14:19:45 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     James Hogan <james.hogan@imgtec.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 18/18] MIPS: KVM: Use va in kvm_get_inst()
Date:   Thu, 9 Jun 2016 14:19:21 +0100
Message-ID: <1465478361-7431-19-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 53928
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

Like other functions, make use of a local unsigned long va, for the
virtual address of the PC. This reduces the amount of verbose casting of
the opc pointer to an unsigned long.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/mmu.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index ad3125fa9c61..208f70409ccb 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -327,17 +327,18 @@ u32 kvm_get_inst(u32 *opc, struct kvm_vcpu *vcpu)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	unsigned long paddr, flags, vpn2, asid;
+	unsigned long va = (unsigned long)opc;
 	u32 inst;
 	int index;
 
-	if (KVM_GUEST_KSEGX((unsigned long) opc) < KVM_GUEST_KSEG0 ||
-	    KVM_GUEST_KSEGX((unsigned long) opc) == KVM_GUEST_KSEG23) {
+	if (KVM_GUEST_KSEGX(va) < KVM_GUEST_KSEG0 ||
+	    KVM_GUEST_KSEGX(va) == KVM_GUEST_KSEG23) {
 		local_irq_save(flags);
-		index = kvm_mips_host_tlb_lookup(vcpu, (unsigned long) opc);
+		index = kvm_mips_host_tlb_lookup(vcpu, va);
 		if (index >= 0) {
 			inst = *(opc);
 		} else {
-			vpn2 = (unsigned long) opc & VPN2_MASK;
+			vpn2 = va & VPN2_MASK;
 			asid = kvm_read_c0_guest_entryhi(cop0) &
 						KVM_ENTRYHI_ASID;
 			index = kvm_mips_guest_tlb_lookup(vcpu, vpn2 | asid);
@@ -354,10 +355,8 @@ u32 kvm_get_inst(u32 *opc, struct kvm_vcpu *vcpu)
 			inst = *(opc);
 		}
 		local_irq_restore(flags);
-	} else if (KVM_GUEST_KSEGX(opc) == KVM_GUEST_KSEG0) {
-		paddr =
-		    kvm_mips_translate_guest_kseg0_to_hpa(vcpu,
-							  (unsigned long) opc);
+	} else if (KVM_GUEST_KSEGX(va) == KVM_GUEST_KSEG0) {
+		paddr = kvm_mips_translate_guest_kseg0_to_hpa(vcpu, va);
 		inst = *(u32 *) CKSEG0ADDR(paddr);
 	} else {
 		kvm_err("%s: illegal address: %p\n", __func__, opc);
-- 
2.4.10
