Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jul 2014 09:28:40 +0200 (CEST)
Received: from ip4-83-240-18-248.cust.nbox.cz ([83.240.18.248]:47687 "EHLO
        ip4-83-240-18-248.cust.nbox.cz" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861346AbaGRH1qj02yD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Jul 2014 09:27:46 +0200
Received: from ku by ip4-83-240-18-248.cust.nbox.cz with local (Exim 4.82)
        (envelope-from <jslaby@suse.cz>)
        id 1X82Zn-0003Yw-Ji; Fri, 18 Jul 2014 09:27:31 +0200
From:   Jiri Slaby <jslaby@suse.cz>
To:     stable@vger.kernel.org
Cc:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Gleb Natapov <gleb@kernel.org>, kvm@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Sanjay Lal <sanjayl@kymasys.com>, Jiri Slaby <jslaby@suse.cz>
Subject: [patch added to the 3.12 stable tree] MIPS: KVM: Remove redundant NULL checks before kfree()
Date:   Fri, 18 Jul 2014 09:25:31 +0200
Message-Id: <1405668451-13298-50-git-send-email-jslaby@suse.cz>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1405668451-13298-1-git-send-email-jslaby@suse.cz>
References: <1405668451-13298-1-git-send-email-jslaby@suse.cz>
Return-Path: <jslaby@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41304
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
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/mips/kvm/kvm_mips.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/mips/kvm/kvm_mips.c b/arch/mips/kvm/kvm_mips.c
index b31153969946..8b900e987338 100644
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
@@ -388,12 +386,8 @@ void kvm_arch_vcpu_free(struct kvm_vcpu *vcpu)
 
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
2.0.0
