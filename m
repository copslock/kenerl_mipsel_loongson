Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Mar 2016 18:51:22 +0100 (CET)
Received: from userp1040.oracle.com ([156.151.31.81]:37888 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007948AbcCMRvSE2xsw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Mar 2016 18:51:18 +0100
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id u2DHp6qZ026388
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Sun, 13 Mar 2016 17:51:07 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.13.8/8.13.8) with ESMTP id u2DHp6Ab021489
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Sun, 13 Mar 2016 17:51:06 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id u2DHp4tY007683;
        Sun, 13 Mar 2016 17:51:05 GMT
Received: from localhost.localdomain (/73.159.178.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 13 Mar 2016 10:51:04 -0700
From:   Sasha Levin <sasha.levin@oracle.com>
To:     stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        James Hogan <james.hogan@imgtec.com>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        kvm@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <sasha.levin@oracle.com>
Subject: [added to the 4.1 stable tree] MIPS: kvm: Fix ioctl error handling.
Date:   Sun, 13 Mar 2016 13:43:55 -0400
Message-Id: <1457891056-30395-77-git-send-email-sasha.levin@oracle.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1457891056-30395-1-git-send-email-sasha.levin@oracle.com>
References: <1457891056-30395-1-git-send-email-sasha.levin@oracle.com>
X-Source-IP: userv0021.oracle.com [156.151.31.71]
Return-Path: <sasha.levin@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52575
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sasha.levin@oracle.com
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

From: "Michael S. Tsirkin" <mst@redhat.com>

This patch has been added to the 4.1 stable tree. If you have any
objections, please let us know.

===============

[ Upstream commit 887349f69f37e71e2a8bfbd743831625a0b2ff51 ]

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
Cc: stable@vger.kernel.org
Cc: kvm@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/12709/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
---
 arch/mips/kvm/mips.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 22ee0af..ace4ed7 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -700,7 +700,7 @@ static int kvm_mips_get_reg(struct kvm_vcpu *vcpu,
 	} else if ((reg->id & KVM_REG_SIZE_MASK) == KVM_REG_SIZE_U128) {
 		void __user *uaddr = (void __user *)(long)reg->addr;
 
-		return copy_to_user(uaddr, vs, 16);
+		return copy_to_user(uaddr, vs, 16) ? -EFAULT : 0;
 	} else {
 		return -EINVAL;
 	}
@@ -730,7 +730,7 @@ static int kvm_mips_set_reg(struct kvm_vcpu *vcpu,
 	} else if ((reg->id & KVM_REG_SIZE_MASK) == KVM_REG_SIZE_U128) {
 		void __user *uaddr = (void __user *)(long)reg->addr;
 
-		return copy_from_user(vs, uaddr, 16);
+		return copy_from_user(vs, uaddr, 16) ? -EFAULT : 0;
 	} else {
 		return -EINVAL;
 	}
-- 
2.5.0
