Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jul 2014 11:46:41 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:40654 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6842451AbaGXJqfwF3gz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Jul 2014 11:46:35 +0200
Received: from bl16-86-217.dsl.telepac.pt ([188.81.86.217] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.71)
        (envelope-from <luis.henriques@canonical.com>)
        id 1XAFbX-0005nL-4k; Thu, 24 Jul 2014 09:46:27 +0000
From:   Luis Henriques <luis.henriques@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Gleb Natapov <gleb@kernel.org>, kvm@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Sanjay Lal <sanjayl@kymasys.com>,
        Luis Henriques <luis.henriques@canonical.com>
Subject: [PATCH 3.11 002/128] MIPS: KVM: Remove redundant NULL checks before kfree()
Date:   Thu, 24 Jul 2014 10:44:11 +0100
Message-Id: <1406195177-8656-3-git-send-email-luis.henriques@canonical.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1406195177-8656-1-git-send-email-luis.henriques@canonical.com>
References: <1406195177-8656-1-git-send-email-luis.henriques@canonical.com>
X-Extended-Stable: 3.11
Return-Path: <luis.henriques@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41558
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luis.henriques@canonical.com
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

3.11.10.14 -stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

commit c6c0a6637f9da54f9472144d44f71cf847f92e20 upstream.

The kfree() function already NULL checks the parameter so remove the
redundant NULL checks before kfree() calls in arch/mips/kvm/.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: kvm@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: Sanjay Lal <sanjayl@kymasys.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 arch/mips/kvm/kvm_mips.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/mips/kvm/kvm_mips.c b/arch/mips/kvm/kvm_mips.c
index 426345ac6f6e..7e78af0e57de 100644
--- a/arch/mips/kvm/kvm_mips.c
+++ b/arch/mips/kvm/kvm_mips.c
@@ -149,9 +149,7 @@ void kvm_mips_free_vcpus(struct kvm *kvm)
 		if (kvm->arch.guest_pmap[i] != KVM_INVALID_PAGE)
 			kvm_mips_release_pfn_clean(kvm->arch.guest_pmap[i]);
 	}
-
-	if (kvm->arch.guest_pmap)
-		kfree(kvm->arch.guest_pmap);
+	kfree(kvm->arch.guest_pmap);
 
 	kvm_for_each_vcpu(i, vcpu, kvm) {
 		kvm_arch_vcpu_free(vcpu);
@@ -384,12 +382,8 @@ void kvm_arch_vcpu_free(struct kvm_vcpu *vcpu)
 
 	kvm_mips_dump_stats(vcpu);
 
-	if (vcpu->arch.guest_ebase)
-		kfree(vcpu->arch.guest_ebase);
-
-	if (vcpu->arch.kseg0_commpage)
-		kfree(vcpu->arch.kseg0_commpage);
-
+	kfree(vcpu->arch.guest_ebase);
+	kfree(vcpu->arch.kseg0_commpage);
 }
 
 void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
-- 
1.9.1
