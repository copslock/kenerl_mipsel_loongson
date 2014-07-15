Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jul 2014 23:35:07 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:40375 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861035AbaGOVfBSYIfT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Jul 2014 23:35:01 +0200
Received: from c-67-160-228-185.hsd1.ca.comcast.net ([67.160.228.185] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.71)
        (envelope-from <kamal@canonical.com>)
        id 1X7AJp-0007Cr-5i; Tue, 15 Jul 2014 21:31:25 +0000
Received: from kamal by fourier with local (Exim 4.82)
        (envelope-from <kamal@whence.com>)
        id 1X7AJn-00045M-86; Tue, 15 Jul 2014 14:31:23 -0700
From:   Kamal Mostafa <kamal@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Gleb Natapov <gleb@kernel.org>, kvm@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Sanjay Lal <sanjayl@kymasys.com>,
        Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 3.13 076/198] MIPS: KVM: Allocate at least 16KB for exception handlers
Date:   Tue, 15 Jul 2014 14:29:06 -0700
Message-Id: <1405459868-15089-77-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1405459868-15089-1-git-send-email-kamal@canonical.com>
References: <1405459868-15089-1-git-send-email-kamal@canonical.com>
X-Extended-Stable: 3.13
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41210
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kamal@canonical.com
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

3.13.11.5 -stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

commit 7006e2dfda9adfa40251093604db76d7e44263b3 upstream.

Each MIPS KVM guest has its own copy of the KVM exception vector. This
contains the TLB refill exception handler at offset 0x000, the general
exception handler at offset 0x180, and interrupt exception handlers at
offset 0x200 in case Cause_IV=1. A common handler is copied to offset
0x2000 and offset 0x3000 is used for temporarily storing k1 during entry
from guest.

However the amount of memory allocated for this purpose is calculated as
0x200 rounded up to the next page boundary, which is insufficient if 4KB
pages are in use. This can lead to the common handler at offset 0x2000
being overwritten and infinitely recursive exceptions on the next exit
from the guest.

Increase the minimum size from 0x200 to 0x4000 to cover the full use of
the page.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: kvm@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: Sanjay Lal <sanjayl@kymasys.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/kvm/kvm_mips.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kvm/kvm_mips.c b/arch/mips/kvm/kvm_mips.c
index 73b3482..3dfbe82 100644
--- a/arch/mips/kvm/kvm_mips.c
+++ b/arch/mips/kvm/kvm_mips.c
@@ -304,7 +304,7 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm, unsigned int id)
 	if (cpu_has_veic || cpu_has_vint) {
 		size = 0x200 + VECTORSPACING * 64;
 	} else {
-		size = 0x200;
+		size = 0x4000;
 	}
 
 	/* Save Linux EBASE */
-- 
1.9.1
