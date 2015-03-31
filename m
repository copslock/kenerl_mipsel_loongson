Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2015 21:49:35 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:50867 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014835AbbCaTtceteU9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Mar 2015 21:49:32 +0200
Received: from [10.172.68.52] (helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.71)
        (envelope-from <kamal@canonical.com>)
        id 1Yd2AC-0000pQ-PO; Tue, 31 Mar 2015 19:49:29 +0000
Received: from kamal by fourier with local (Exim 4.82)
        (envelope-from <kamal@whence.com>)
        id 1Yd2AA-0000cx-BH; Tue, 31 Mar 2015 12:49:26 -0700
From:   Kamal Mostafa <kamal@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Gleb Natapov <gleb@kernel.org>, kvm@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Sanjay Lal <sanjayl@kymasys.com>,
        Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 3.13.y-ckt 068/143] MIPS: KVM: Deliver guest interrupts after local_irq_disable()
Date:   Tue, 31 Mar 2015 12:47:13 -0700
Message-Id: <1427831308-1854-69-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1427831308-1854-1-git-send-email-kamal@canonical.com>
References: <1427831308-1854-1-git-send-email-kamal@canonical.com>
X-Extended-Stable: 3.13
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46669
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

3.13.11-ckt18 -stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

commit 044f0f03eca0110e1835b2ea038a484b93950328 upstream.

When about to run the guest, deliver guest interrupts after disabling
host interrupts. This should prevent an hrtimer interrupt from being
handled after delivering guest interrupts, and therefore not delivering
the guest timer interrupt until after the next guest exit.

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
index 7a8b440..4d058a7 100644
--- a/arch/mips/kvm/kvm_mips.c
+++ b/arch/mips/kvm/kvm_mips.c
@@ -424,11 +424,11 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		vcpu->mmio_needed = 0;
 	}
 
+	local_irq_disable();
 	/* Check if we have any exceptions/interrupts pending */
 	kvm_mips_deliver_interrupts(vcpu,
 				    kvm_read_c0_guest_cause(vcpu->arch.cop0));
 
-	local_irq_disable();
 	kvm_guest_enter();
 
 	r = __kvm_mips_vcpu_run(run, vcpu);
-- 
1.9.1
