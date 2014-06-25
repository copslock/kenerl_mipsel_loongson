Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jun 2014 13:47:06 +0200 (CEST)
Received: from ip4-83-240-18-248.cust.nbox.cz ([83.240.18.248]:53441 "EHLO
        ip4-83-240-18-248.cust.nbox.cz" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6819433AbaFYLpzW0Dq6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Jun 2014 13:45:55 +0200
Received: from ku by ip4-83-240-18-248.cust.nbox.cz with local (Exim 4.80.1)
        (envelope-from <jslaby@suse.cz>)
        id 1Wzldw-0001vX-Mp; Wed, 25 Jun 2014 13:45:36 +0200
From:   Jiri Slaby <jslaby@suse.cz>
To:     stable@vger.kernel.org
Cc:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Gleb Natapov <gleb@kernel.org>, kvm@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Sanjay Lal <sanjayl@kymasys.com>, Jiri Slaby <jslaby@suse.cz>
Subject: [patch added to the 3.12 stable tree] MIPS: KVM: Allocate at least 16KB for exception handlers
Date:   Wed, 25 Jun 2014 13:45:12 +0200
Message-Id: <1403696736-7282-13-git-send-email-jslaby@suse.cz>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1403696736-7282-1-git-send-email-jslaby@suse.cz>
References: <1403696736-7282-1-git-send-email-jslaby@suse.cz>
Return-Path: <jslaby@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40802
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jslaby@suse.cz
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

From: James Hogan <james.hogan@imgtec.com>

This patch has been added to the 3.12 stable tree. If you have any
objections, please let us know.

===============

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
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/mips/kvm/kvm_mips.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kvm/kvm_mips.c b/arch/mips/kvm/kvm_mips.c
index a7b044536de4..b31153969946 100644
--- a/arch/mips/kvm/kvm_mips.c
+++ b/arch/mips/kvm/kvm_mips.c
@@ -303,7 +303,7 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm, unsigned int id)
 	if (cpu_has_veic || cpu_has_vint) {
 		size = 0x200 + VECTORSPACING * 64;
 	} else {
-		size = 0x200;
+		size = 0x4000;
 	}
 
 	/* Save Linux EBASE */
-- 
2.0.0
