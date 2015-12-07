Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Dec 2015 16:07:07 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:42870 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012310AbbLGPFdJfgOc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Dec 2015 16:05:33 +0100
Received: from localhost (unknown [66.228.68.140])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 000C3A73;
        Mon,  7 Dec 2015 15:05:26 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Gleb Natapov <gleb@kernel.org>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org
Subject: [PATCH 4.3 036/125] MIPS: KVM: Uninit VCPU in vcpu_create error path
Date:   Mon,  7 Dec 2015 10:00:49 -0500
Message-Id: <20151207145754.074267600@linuxfoundation.org>
X-Mailer: git-send-email 2.6.3
In-Reply-To: <20151207145752.225938417@linuxfoundation.org>
References: <20151207145752.225938417@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50374
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

4.3-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

commit 585bb8f9a5e592f2ce7abbe5ed3112d5438d2754 upstream.

If either of the memory allocations in kvm_arch_vcpu_create() fail, the
vcpu which has been allocated and kvm_vcpu_init'd doesn't get uninit'd
in the error handling path. Add a call to kvm_vcpu_uninit() to fix this.

Fixes: 669e846e6c4e ("KVM/MIPS32: MIPS arch specific APIs for KVM")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kvm/mips.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -279,7 +279,7 @@ struct kvm_vcpu *kvm_arch_vcpu_create(st
 
 	if (!gebase) {
 		err = -ENOMEM;
-		goto out_free_cpu;
+		goto out_uninit_cpu;
 	}
 	kvm_debug("Allocated %d bytes for KVM Exception Handlers @ %p\n",
 		  ALIGN(size, PAGE_SIZE), gebase);
@@ -343,6 +343,9 @@ struct kvm_vcpu *kvm_arch_vcpu_create(st
 out_free_gebase:
 	kfree(gebase);
 
+out_uninit_cpu:
+	kvm_vcpu_uninit(vcpu);
+
 out_free_cpu:
 	kfree(vcpu);
 
