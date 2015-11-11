Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Nov 2015 15:21:58 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:32052 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011543AbbKKOVlg0eX0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Nov 2015 15:21:41 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 28472F5B4B0C9;
        Wed, 11 Nov 2015 14:21:33 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Wed, 11 Nov 2015 14:21:35 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 11 Nov 2015 14:21:35 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Gleb Natapov <gleb@kernel.org>, <linux-mips@linux-mips.org>,
        <kvm@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH 1/3] MIPS: KVM: Fix ASID restoration logic
Date:   Wed, 11 Nov 2015 14:21:18 +0000
Message-ID: <1447251680-5254-2-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1447251680-5254-1-git-send-email-james.hogan@imgtec.com>
References: <1447251680-5254-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49886
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

ASID restoration on guest resume should determine the guest execution
mode based on the guest Status register rather than bit 30 of the guest
PC.

Fix the two places in locore.S that do this, loading the guest status
from the cop0 area. Note, this assembly is specific to the trap &
emulate implementation of KVM, so it doesn't need to check the
supervisor bit as that mode is not implemented in the guest.

Fixes: b680f70fc111 ("KVM/MIPS32: Entry point for trampolining to...")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
Cc: <stable@vger.kernel.org> # 3.10.x-
---
 arch/mips/kvm/locore.S | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/mips/kvm/locore.S b/arch/mips/kvm/locore.S
index c567240386a0..d1ee95a7f7dd 100644
--- a/arch/mips/kvm/locore.S
+++ b/arch/mips/kvm/locore.S
@@ -165,9 +165,11 @@ FEXPORT(__kvm_mips_vcpu_run)
 
 FEXPORT(__kvm_mips_load_asid)
 	/* Set the ASID for the Guest Kernel */
-	INT_SLL	t0, t0, 1	/* with kseg0 @ 0x40000000, kernel */
-			        /* addresses shift to 0x80000000 */
-	bltz	t0, 1f		/* If kernel */
+	PTR_L	t0, VCPU_COP0(k1)
+	LONG_L	t0, COP0_STATUS(t0)
+	andi	t0, KSU_USER | ST0_ERL | ST0_EXL
+	xori	t0, KSU_USER
+	bnez	t0, 1f		/* If kernel */
 	 INT_ADDIU t1, k1, VCPU_GUEST_KERNEL_ASID  /* (BD)  */
 	INT_ADDIU t1, k1, VCPU_GUEST_USER_ASID    /* else user */
 1:
@@ -482,9 +484,11 @@ __kvm_mips_return_to_guest:
 	mtc0	t0, CP0_EPC
 
 	/* Set the ASID for the Guest Kernel */
-	INT_SLL	t0, t0, 1	/* with kseg0 @ 0x40000000, kernel */
-				/* addresses shift to 0x80000000 */
-	bltz	t0, 1f		/* If kernel */
+	PTR_L	t0, VCPU_COP0(k1)
+	LONG_L	t0, COP0_STATUS(t0)
+	andi	t0, KSU_USER | ST0_ERL | ST0_EXL
+	xori	t0, KSU_USER
+	bnez	t0, 1f		/* If kernel */
 	 INT_ADDIU t1, k1, VCPU_GUEST_KERNEL_ASID  /* (BD)  */
 	INT_ADDIU t1, k1, VCPU_GUEST_USER_ASID    /* else user */
 1:
-- 
2.4.10
