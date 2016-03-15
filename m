Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Mar 2016 00:32:41 +0100 (CET)
Received: from youngberry.canonical.com ([91.189.89.112]:41562 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006686AbcCOXckY3Sww (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Mar 2016 00:32:40 +0100
Received: from 1.general.kamal.us.vpn ([10.172.68.52] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kamal@canonical.com>)
        id 1afyS4-0001WH-R0; Tue, 15 Mar 2016 23:32:37 +0000
Received: from kamal by fourier with local (Exim 4.86)
        (envelope-from <kamal@whence.com>)
        id 1afyS2-000664-5U; Tue, 15 Mar 2016 16:32:34 -0700
From:   Kamal Mostafa <kamal@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        James Hogan <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org, kvm@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 4.2.y-ckt 38/98] MIPS: kvm: Fix ioctl error handling.
Date:   Tue, 15 Mar 2016 16:30:32 -0700
Message-Id: <1458084692-23100-39-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1458084692-23100-1-git-send-email-kamal@canonical.com>
References: <1458084692-23100-1-git-send-email-kamal@canonical.com>
X-Extended-Stable: 4.2
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52600
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

4.2.8-ckt6 -stable review patch.  If anyone has any objections, please let me know.

---8<------------------------------------------------------------

From: "Michael S. Tsirkin" <mst@redhat.com>

commit 887349f69f37e71e2a8bfbd743831625a0b2ff51 upstream.

Calling return copy_to_user(...) or return copy_from_user in an ioctl
will not do the right thing if there's a pagefault:
copy_to_user/copy_from_user return the number of bytes not copied in
this case.

Fix up kvm on mips to do
	return copy_to_user(...)) ?  -EFAULT : 0;
and
	return copy_from_user(...)) ?  -EFAULT : 0;

everywhere.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/12709/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/kvm/mips.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index bafb32b..216dba8 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -701,7 +701,7 @@ static int kvm_mips_get_reg(struct kvm_vcpu *vcpu,
 	} else if ((reg->id & KVM_REG_SIZE_MASK) == KVM_REG_SIZE_U128) {
 		void __user *uaddr = (void __user *)(long)reg->addr;
 
-		return copy_to_user(uaddr, vs, 16);
+		return copy_to_user(uaddr, vs, 16) ? -EFAULT : 0;
 	} else {
 		return -EINVAL;
 	}
@@ -731,7 +731,7 @@ static int kvm_mips_set_reg(struct kvm_vcpu *vcpu,
 	} else if ((reg->id & KVM_REG_SIZE_MASK) == KVM_REG_SIZE_U128) {
 		void __user *uaddr = (void __user *)(long)reg->addr;
 
-		return copy_from_user(vs, uaddr, 16);
+		return copy_from_user(vs, uaddr, 16) ? -EFAULT : 0;
 	} else {
 		return -EINVAL;
 	}
-- 
2.7.0
