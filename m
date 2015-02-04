Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Feb 2015 11:52:28 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:55261 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011464AbbBDKw0xLGoE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Feb 2015 11:52:26 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 1472B9269C09F;
        Wed,  4 Feb 2015 10:52:19 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 4 Feb 2015 10:52:20 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 4 Feb 2015 10:52:18 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Gleb Natapov <gleb@kernel.org>, <kvm@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <stable@vger.kernel.org>
Subject: [PATCH] KVM: MIPS: Disable HTW while in guest
Date:   Wed, 4 Feb 2015 10:52:03 +0000
Message-ID: <1423047123-32212-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.0.5
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45646
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Ensure any hardware page table walker (HTW) is disabled while in KVM
guest mode, as KVM doesn't yet set up hardware page table walking for
guest mappings so the wrong mappings would get loaded, resulting in the
guest hanging or crashing once it reaches userland.

The HTW is disabled and re-enabled around the call to
__kvm_mips_vcpu_run() which does the initial switch into guest mode and
the final switch out of guest context. Additionally it is enabled for
the duration of guest exits (i.e. kvm_mips_handle_exit()), getting
disabled again before returning back to guest or host.

In all cases the HTW is only disabled in normal kernel mode while
interrupts are disabled, so that the HTW doesn't get left disabled if
the process is preempted.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: kvm@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # v3.17+
---
 arch/mips/kvm/mips.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index e3b21e51ff7e..dd133ccecec4 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -18,6 +18,7 @@
 #include <asm/page.h>
 #include <asm/cacheflush.h>
 #include <asm/mmu_context.h>
+#include <asm/pgtable.h>
 
 #include <linux/kvm_host.h>
 
@@ -385,8 +386,14 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 
 	kvm_guest_enter();
 
+	/* Disable hardware page table walking while in guest */
+	htw_stop();
+
 	r = __kvm_mips_vcpu_run(run, vcpu);
 
+	/* Re-enable HTW before enabling interrupts */
+	htw_start();
+
 	kvm_guest_exit();
 	local_irq_enable();
 
@@ -1002,6 +1009,9 @@ int kvm_mips_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
 	enum emulation_result er = EMULATE_DONE;
 	int ret = RESUME_GUEST;
 
+	/* re-enable HTW before enabling interrupts */
+	htw_start();
+
 	/* Set a default exit reason */
 	run->exit_reason = KVM_EXIT_UNKNOWN;
 	run->ready_for_interrupt_injection = 1;
@@ -1136,6 +1146,9 @@ skip_emul:
 		}
 	}
 
+	/* Disable HTW before returning to guest or host */
+	htw_stop();
+
 	return ret;
 }
 
-- 
2.0.5
