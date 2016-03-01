Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Mar 2016 00:47:16 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:53131 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007431AbcCAXrLfI2CJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Mar 2016 00:47:11 +0100
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2D20DDBF;
        Tue,  1 Mar 2016 23:47:05 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Gleb Natapov <gleb@kernel.org>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org
Subject: [PATCH 3.10 16/80] MIPS: KVM: Fix ASID restoration logic
Date:   Tue,  1 Mar 2016 15:45:10 -0800
Message-Id: <20160301234350.176327405@linuxfoundation.org>
X-Mailer: git-send-email 2.7.2
In-Reply-To: <20160301234349.667990420@linuxfoundation.org>
References: <20160301234349.667990420@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52395
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

3.10-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/kvm/kvm_locore.S |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

--- a/arch/mips/kvm/kvm_locore.S
+++ b/arch/mips/kvm/kvm_locore.S
@@ -156,9 +156,11 @@ FEXPORT(__kvm_mips_vcpu_run)
 
 FEXPORT(__kvm_mips_load_asid)
     /* Set the ASID for the Guest Kernel */
-    sll         t0, t0, 1                       /* with kseg0 @ 0x40000000, kernel */
-                                                /* addresses shift to 0x80000000 */
-    bltz        t0, 1f                          /* If kernel */
+    PTR_L	t0, VCPU_COP0(k1)
+    LONG_L	t0, COP0_STATUS(t0)
+    andi	t0, KSU_USER | ST0_ERL | ST0_EXL
+    xori	t0, KSU_USER
+    bnez	t0, 1f		/* If kernel */
 	addiu       t1, k1, VCPU_GUEST_KERNEL_ASID  /* (BD)  */
     addiu       t1, k1, VCPU_GUEST_USER_ASID    /* else user */
 1:
@@ -442,9 +444,11 @@ __kvm_mips_return_to_guest:
 	mtc0		t0, CP0_EPC
 
     /* Set the ASID for the Guest Kernel */
-    sll         t0, t0, 1                       /* with kseg0 @ 0x40000000, kernel */
-                                                /* addresses shift to 0x80000000 */
-    bltz        t0, 1f                          /* If kernel */
+    PTR_L	t0, VCPU_COP0(k1)
+    LONG_L	t0, COP0_STATUS(t0)
+    andi	t0, KSU_USER | ST0_ERL | ST0_EXL
+    xori	t0, KSU_USER
+    bnez	t0, 1f		/* If kernel */
 	addiu       t1, k1, VCPU_GUEST_KERNEL_ASID  /* (BD)  */
     addiu       t1, k1, VCPU_GUEST_USER_ASID    /* else user */
 1:
