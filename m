Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Feb 2016 16:36:11 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:42076 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007956AbcB1PgKErHKH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 28 Feb 2016 16:36:10 +0100
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        by mx1.redhat.com (Postfix) with ESMTPS id 753FC7F085;
        Sun, 28 Feb 2016 15:36:03 +0000 (UTC)
Received: from redhat.com (vpn1-7-76.ams2.redhat.com [10.36.7.76])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u1SFZxrQ002588;
        Sun, 28 Feb 2016 10:36:00 -0500
Date:   Sun, 28 Feb 2016 17:35:59 +0200
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH for-4,5] mips/kvm: fix ioctl error handling
Message-ID: <1456673711-24132-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Return-Path: <mst@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52355
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mst@redhat.com
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

Calling return copy_to_user(...) or return copy_from_user in an ioctl
will not do the right thing if there's a pagefault:
copy_to_user/copy_from_user return the number of bytes not copied in
this case.

Fix up kvm on mips to do
	return copy_to_user(...)) ?  -EFAULT : 0;
and
	return copy_from_user(...)) ?  -EFAULT : 0;

everywhere.

Cc: stable@vger.kernel.org
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Untested.

 arch/mips/kvm/mips.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 8bc3977..3110447 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -702,7 +702,7 @@ static int kvm_mips_get_reg(struct kvm_vcpu *vcpu,
 	} else if ((reg->id & KVM_REG_SIZE_MASK) == KVM_REG_SIZE_U128) {
 		void __user *uaddr = (void __user *)(long)reg->addr;
 
-		return copy_to_user(uaddr, vs, 16);
+		return copy_to_user(uaddr, vs, 16) ? -EFAULT : 0;
 	} else {
 		return -EINVAL;
 	}
@@ -732,7 +732,7 @@ static int kvm_mips_set_reg(struct kvm_vcpu *vcpu,
 	} else if ((reg->id & KVM_REG_SIZE_MASK) == KVM_REG_SIZE_U128) {
 		void __user *uaddr = (void __user *)(long)reg->addr;
 
-		return copy_from_user(vs, uaddr, 16);
+		return copy_from_user(vs, uaddr, 16) ? -EFAULT : 0;
 	} else {
 		return -EINVAL;
 	}
-- 
MST
