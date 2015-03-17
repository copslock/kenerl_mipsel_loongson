Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Mar 2015 09:43:30 +0100 (CET)
Received: from ip4-83-240-67-251.cust.nbox.cz ([83.240.67.251]:44025 "EHLO
        ip4-83-240-18-248.cust.nbox.cz" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27013954AbbCQImvhbP2N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Mar 2015 09:42:51 +0100
Received: from ku by ip4-83-240-18-248.cust.nbox.cz with local (Exim 4.85)
        (envelope-from <jslaby@suse.cz>)
        id 1YXn57-0005mo-I1; Tue, 17 Mar 2015 09:42:33 +0100
From:   Jiri Slaby <jslaby@suse.cz>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Gleb Natapov <gleb@kernel.org>, kvm@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Sanjay Lal <sanjayl@kymasys.com>, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 3.12 022/175] MIPS: KVM: Deliver guest interrupts after local_irq_disable()
Date:   Tue, 17 Mar 2015 09:40:00 +0100
Message-Id: <2301499b1269fbca843e7fa164c2a9e9de27892d.1426581621.git.jslaby@suse.cz>
X-Mailer: git-send-email 2.3.0
In-Reply-To: <a48f1a6bfc3ee997dfd719eaecb44a05477b93e2.1426581620.git.jslaby@suse.cz>
References: <a48f1a6bfc3ee997dfd719eaecb44a05477b93e2.1426581620.git.jslaby@suse.cz>
In-Reply-To: <cover.1426581620.git.jslaby@suse.cz>
References: <cover.1426581620.git.jslaby@suse.cz>
Return-Path: <jslaby@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46429
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

3.12-stable review patch.  If anyone has any objections, please let me know.

===============

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
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/mips/kvm/kvm_mips.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kvm/kvm_mips.c b/arch/mips/kvm/kvm_mips.c
index 3f3e5b2b2f38..016f163b42da 100644
--- a/arch/mips/kvm/kvm_mips.c
+++ b/arch/mips/kvm/kvm_mips.c
@@ -417,11 +417,11 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
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
2.3.0
