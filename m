Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 11:51:54 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:50797 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27040983AbcFIJvLx2mPR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jun 2016 11:51:11 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 2E419B1395791;
        Thu,  9 Jun 2016 10:51:03 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 9 Jun 2016 10:51:05 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     James Hogan <james.hogan@imgtec.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>,
        <linux-mips@linux-mips.org>
Subject: [PATCH 4/4] MIPS: KVM: Fix CACHE triggered exception emulation
Date:   Thu, 9 Jun 2016 10:50:46 +0100
Message-ID: <1465465846-31918-5-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1465465846-31918-1-git-send-email-james.hogan@imgtec.com>
References: <1465465846-31918-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53910
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

When emulating TLB miss / invalid exceptions during CACHE instruction
emulation, be sure to set up the correct PC and host_cp0_badvaddr state
for the kvm_mips_emlulate_tlb*_ld() function to pick up for guest EPC
and BadVAddr.

PC needs to be rewound otherwise the guest EPC will end up pointing at
the next instruction after the faulting CACHE instruction.

host_cp0_badvaddr must be set because guest CACHE instructions trap with
a Coprocessor Unusable exception, which doesn't update the host BadVAddr
as a TLB exception would.

This doesn't tend to get hit when dynamic translation of emulated
instructions is enabled, since only the first execution of each CACHE
instruction actually goes through this code path, with subsequent
executions hitting the SYNCI instruction that it gets replaced with.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: kvm@vger.kernel.org
Cc: linux-mips@linux-mips.org
---
 arch/mips/kvm/emulate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index 52bec0fe2fbb..645c8a1982a7 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -1636,6 +1636,7 @@ enum emulation_result kvm_mips_emulate_cache(uint32_t inst, uint32_t *opc,
 		if (index < 0) {
 			vcpu->arch.host_cp0_entryhi = (va & VPN2_MASK);
 			vcpu->arch.host_cp0_badvaddr = va;
+			vcpu->arch.pc = curr_pc;
 			er = kvm_mips_emulate_tlbmiss_ld(cause, NULL, run,
 							 vcpu);
 			preempt_enable();
@@ -1647,6 +1648,8 @@ enum emulation_result kvm_mips_emulate_cache(uint32_t inst, uint32_t *opc,
 			 * invalid exception to the guest
 			 */
 			if (!TLB_IS_VALID(*tlb, va)) {
+				vcpu->arch.host_cp0_badvaddr = va;
+				vcpu->arch.pc = curr_pc;
 				er = kvm_mips_emulate_tlbinv_ld(cause, NULL,
 								run, vcpu);
 				preempt_enable();
-- 
2.4.10
