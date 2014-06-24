Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jun 2014 17:52:42 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:38952 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816071AbaFXPwioH9dv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Jun 2014 17:52:38 +0200
Received: from localhost (unknown [38.104.188.138])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CC469AF1;
        Tue, 24 Jun 2014 15:52:30 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Gleb Natapov <gleb@kernel.org>, kvm@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Sanjay Lal <sanjayl@kymasys.com>
Subject: [PATCH 3.10 29/52] MIPS: KVM: Allocate at least 16KB for exception handlers
Date:   Tue, 24 Jun 2014 11:50:44 -0400
Message-Id: <20140624154715.254248878@linuxfoundation.org>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <20140624154713.428945460@linuxfoundation.org>
References: <20140624154713.428945460@linuxfoundation.org>
User-Agent: quilt/0.63-1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40737
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kvm/kvm_mips.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/kvm/kvm_mips.c
+++ b/arch/mips/kvm/kvm_mips.c
@@ -299,7 +299,7 @@ struct kvm_vcpu *kvm_arch_vcpu_create(st
 	if (cpu_has_veic || cpu_has_vint) {
 		size = 0x200 + VECTORSPACING * 64;
 	} else {
-		size = 0x200;
+		size = 0x4000;
 	}
 
 	/* Save Linux EBASE */
