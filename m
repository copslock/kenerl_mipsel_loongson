Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Dec 2015 15:37:37 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:38700 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010130AbbLGOhRrGwwc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Dec 2015 15:37:17 +0100
Received: from localhost (unknown [66.228.68.140])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B0B7CBCA;
        Mon,  7 Dec 2015 14:37:11 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Gleb Natapov <gleb@kernel.org>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org
Subject: [PATCH 4.1 33/95] MIPS: KVM: Fix ASID restoration logic
Date:   Mon,  7 Dec 2015 09:35:27 -0500
Message-Id: <20151207142740.966327091@linuxfoundation.org>
X-Mailer: git-send-email 2.6.3
In-Reply-To: <20151207142739.317088107@linuxfoundation.org>
References: <20151207142739.317088107@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50359
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

commit 002374f371bd02df864cce1fe85d90dc5b292837 upstream.

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
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kvm/locore.S |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

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
