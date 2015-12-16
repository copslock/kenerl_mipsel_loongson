Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Dec 2015 00:52:05 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:35327 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27014066AbbLPXuMw4960 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Dec 2015 00:50:12 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 4D98CF42FB2E0;
        Wed, 16 Dec 2015 23:50:03 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Wed, 16 Dec 2015 23:50:07 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 16 Dec 2015 23:50:06 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paolo Bonzini <pbonzini@redhat.com>
CC:     Gleb Natapov <gleb@kernel.org>, <linux-mips@linux-mips.org>,
        <kvm@vger.kernel.org>, James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 06/16] MIPS: KVM: Refactor added offsetof()s
Date:   Wed, 16 Dec 2015 23:49:31 +0000
Message-ID: <1450309781-28030-7-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 50654
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

When calculating the offsets into the commpage for dynamically
translated mtc0/mfc0 guest instructions, multiple offsetof()s are added
together to find the offset of the specific register in the mips_coproc,
within the commpage.

Simplify each of these cases to a single offsetof() to find the offset
of the specific register within the commpage.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/dyntrans.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/mips/kvm/dyntrans.c b/arch/mips/kvm/dyntrans.c
index 521121bdebff..f1527a465c1b 100644
--- a/arch/mips/kvm/dyntrans.c
+++ b/arch/mips/kvm/dyntrans.c
@@ -86,10 +86,8 @@ int kvm_mips_trans_mfc0(uint32_t inst, uint32_t *opc, struct kvm_vcpu *vcpu)
 	} else {
 		mfc0_inst = LW_TEMPLATE;
 		mfc0_inst |= ((rt & 0x1f) << 16);
-		mfc0_inst |=
-		    offsetof(struct mips_coproc,
-			     reg[rd][sel]) + offsetof(struct kvm_mips_commpage,
-						      cop0);
+		mfc0_inst |= offsetof(struct kvm_mips_commpage,
+				      cop0.reg[rd][sel]);
 	}
 
 	if (KVM_GUEST_KSEGX(opc) == KVM_GUEST_KSEG0) {
@@ -123,9 +121,7 @@ int kvm_mips_trans_mtc0(uint32_t inst, uint32_t *opc, struct kvm_vcpu *vcpu)
 	sel = inst & 0x7;
 
 	mtc0_inst |= ((rt & 0x1f) << 16);
-	mtc0_inst |=
-	    offsetof(struct mips_coproc,
-		     reg[rd][sel]) + offsetof(struct kvm_mips_commpage, cop0);
+	mtc0_inst |= offsetof(struct kvm_mips_commpage, cop0.reg[rd][sel]);
 
 	if (KVM_GUEST_KSEGX(opc) == KVM_GUEST_KSEG0) {
 		kseg0_opc =
-- 
2.4.10
