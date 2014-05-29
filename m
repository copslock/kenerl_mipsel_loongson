Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 May 2014 11:24:24 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:12575 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6838763AbaE2JRPyEo6E (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 May 2014 11:17:15 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 0E6F3F3BE76D6;
        Thu, 29 May 2014 10:17:07 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Thu, 29 May 2014 10:17:08 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.101) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Thu, 29 May 2014 10:17:08 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        James Hogan <james.hogan@imgtec.com>,
        Gleb Natapov <gleb@kernel.org>, <kvm@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, Sanjay Lal <sanjayl@kymasys.com>
Subject: [PATCH v2 19/23] MIPS: KVM: Fix kvm_debug bit-rottage
Date:   Thu, 29 May 2014 10:16:41 +0100
Message-ID: <1401355005-20370-20-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1401355005-20370-1-git-send-email-james.hogan@imgtec.com>
References: <1401355005-20370-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40342
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

Fix build errors when DEBUG is defined in arch/mips/kvm/.
 - The DEBUG code in kvm_mips_handle_tlbmod() was missing some variables.
 - The DEBUG code in kvm_mips_host_tlb_write() was conditional on an
   undefined "debug" variable.
 - The DEBUG code in kvm_mips_host_tlb_inv() accessed asid_map directly
   rather than using kvm_mips_get_user_asid(). Also fixed brace
   placement.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: kvm@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: Sanjay Lal <sanjayl@kymasys.com>
---
 arch/mips/kvm/kvm_mips_emul.c |  6 +++++-
 arch/mips/kvm/kvm_tlb.c       | 14 +++++---------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/mips/kvm/kvm_mips_emul.c b/arch/mips/kvm/kvm_mips_emul.c
index 6d257384c9b4..c81ab791b8f2 100644
--- a/arch/mips/kvm/kvm_mips_emul.c
+++ b/arch/mips/kvm/kvm_mips_emul.c
@@ -1831,8 +1831,12 @@ kvm_mips_handle_tlbmod(unsigned long cause, uint32_t *opc,
 		       struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
 	enum emulation_result er = EMULATE_DONE;
-
 #ifdef DEBUG
+	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	unsigned long entryhi = (vcpu->arch.host_cp0_badvaddr & VPN2_MASK) |
+				(kvm_read_c0_guest_entryhi(cop0) & ASID_MASK);
+	int index;
+
 	/*
 	 * If address not in the guest TLB, then we are in trouble
 	 */
diff --git a/arch/mips/kvm/kvm_tlb.c b/arch/mips/kvm/kvm_tlb.c
index d65999a9f8af..994fc2384180 100644
--- a/arch/mips/kvm/kvm_tlb.c
+++ b/arch/mips/kvm/kvm_tlb.c
@@ -233,12 +233,9 @@ kvm_mips_host_tlb_write(struct kvm_vcpu *vcpu, unsigned long entryhi,
 	tlbw_use_hazard();
 
 #ifdef DEBUG
-	if (debug) {
-		kvm_debug("@ %#lx idx: %2d [entryhi(R): %#lx] "
-			  "entrylo0(R): 0x%08lx, entrylo1(R): 0x%08lx\n",
-			  vcpu->arch.pc, idx, read_c0_entryhi(),
-			  read_c0_entrylo0(), read_c0_entrylo1());
-	}
+	kvm_debug("@ %#lx idx: %2d [entryhi(R): %#lx] entrylo0(R): 0x%08lx, entrylo1(R): 0x%08lx\n",
+		  vcpu->arch.pc, idx, read_c0_entryhi(),
+		  read_c0_entrylo0(), read_c0_entrylo1());
 #endif
 
 	/* Flush D-cache */
@@ -507,10 +504,9 @@ int kvm_mips_host_tlb_inv(struct kvm_vcpu *vcpu, unsigned long va)
 	local_irq_restore(flags);
 
 #ifdef DEBUG
-	if (idx > 0) {
+	if (idx > 0)
 		kvm_debug("%s: Invalidated entryhi %#lx @ idx %d\n", __func__,
-			  (va & VPN2_MASK) | (vcpu->arch.asid_map[va & ASID_MASK] & ASID_MASK), idx);
-	}
+			  (va & VPN2_MASK) | kvm_mips_get_user_asid(vcpu), idx);
 #endif
 
 	return 0;
-- 
1.9.3
