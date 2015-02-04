Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Feb 2015 18:06:54 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:61718 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012549AbbBDRGw4XpFB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Feb 2015 18:06:52 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id E9A01FEFD7A9A;
        Wed,  4 Feb 2015 17:06:43 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 4 Feb 2015 17:06:47 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 4 Feb 2015 17:06:46 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sanjay Lal <sanjayl@kymasys.com>,
        Gleb Natapov <gleb@kernel.org>, <kvm@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <stable@vger.kernel.org>
Subject: [PATCH] KVM: MIPS: Don't leak FPU/DSP to guest
Date:   Wed, 4 Feb 2015 17:06:37 +0000
Message-ID: <1423069597-8376-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.0.5
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45695
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

The FPU and DSP are enabled via the CP0 Status CU1 and MX bits by
kvm_mips_set_c0_status() on a guest exit, presumably in case there is
active state that needs saving if pre-emption occurs. However neither of
these bits are cleared again when returning to the guest.

This effectively gives the guest access to the FPU/DSP hardware after
the first guest exit even though it is not aware of its presence,
allowing FP instructions in guest user code to intermittently actually
execute instead of trapping into the guest OS for emulation. It will
then read & manipulate the hardware FP registers which technically
belong to the user process (e.g. QEMU), or are stale from another user
process. It can also crash the guest OS by causing an FP exception, for
which a guest exception handler won't have been registered.

First lets save and disable the FPU (and MSA) state with lose_fpu(1)
before entering the guest. This simplifies the problem, especially for
when guest FPU/MSA support is added in the future, and prevents FR=1 FPU
state being live when the FR bit gets cleared for the guest, which
according to the architecture causes the contents of the FPU and vector
registers to become UNPREDICTABLE.

We can then safely remove the enabling of the FPU in
kvm_mips_set_c0_status(), since there should never be any active FPU or
MSA state to save at pre-emption, which should plug the FPU leak.

DSP state is always live rather than being lazily restored, so for that
it is simpler to just clear the MX bit again when re-entering the guest.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Sanjay Lal <sanjayl@kymasys.com>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: kvm@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # v3.10+: 044f0f03eca0: MIPS: KVM: Deliver guest interrupts
Cc: <stable@vger.kernel.org> # v3.10+
---
 arch/mips/kvm/locore.S | 2 +-
 arch/mips/kvm/mips.c   | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kvm/locore.S b/arch/mips/kvm/locore.S
index d7279c03c517..4a68b176d6e4 100644
--- a/arch/mips/kvm/locore.S
+++ b/arch/mips/kvm/locore.S
@@ -434,7 +434,7 @@ __kvm_mips_return_to_guest:
 	/* Setup status register for running guest in UM */
 	.set	at
 	or	v1, v1, (ST0_EXL | KSU_USER | ST0_IE)
-	and	v1, v1, ~ST0_CU0
+	and	v1, v1, ~(ST0_CU0 | ST0_MX)
 	.set	noat
 	mtc0	v1, CP0_STATUS
 	ehb
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index dd133ccecec4..270bbd41769e 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -15,6 +15,7 @@
 #include <linux/vmalloc.h>
 #include <linux/fs.h>
 #include <linux/bootmem.h>
+#include <asm/fpu.h>
 #include <asm/page.h>
 #include <asm/cacheflush.h>
 #include <asm/mmu_context.h>
@@ -379,6 +380,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		vcpu->mmio_needed = 0;
 	}
 
+	lose_fpu(1);
+
 	local_irq_disable();
 	/* Check if we have any exceptions/interrupts pending */
 	kvm_mips_deliver_interrupts(vcpu,
@@ -987,9 +990,6 @@ static void kvm_mips_set_c0_status(void)
 {
 	uint32_t status = read_c0_status();
 
-	if (cpu_has_fpu)
-		status |= (ST0_CU1);
-
 	if (cpu_has_dsp)
 		status |= (ST0_MX);
 
-- 
2.0.5
