Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Mar 2015 07:16:22 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:48941 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006674AbbCDGQUhp00K (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Mar 2015 07:16:20 +0100
Received: from localhost (unknown [166.170.43.162])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5BDDDA5B;
        Wed,  4 Mar 2015 06:16:14 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sanjay Lal <sanjayl@kymasys.com>,
        Gleb Natapov <gleb@kernel.org>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH 3.14 58/73] KVM: MIPS: Dont leak FPU/DSP to guest
Date:   Tue,  3 Mar 2015 22:13:26 -0800
Message-Id: <20150304055342.084533773@linuxfoundation.org>
X-Mailer: git-send-email 2.3.1
In-Reply-To: <20150304055332.344462103@linuxfoundation.org>
References: <20150304055332.344462103@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46129
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

3.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

commit f798217dfd038af981a18bbe4bc57027a08bb182 upstream.

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
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
This should apply to stable trees 3.12 and 3.14, but not 3.10. The files
had been renamed since v3.14 so it cherry-picked cleanly but the patch
didn't apply cleanly. I've also added a reference to the "MIPS: Export
FP functions used by lose_fpu(1) for KVM" commit which is itself marked
for stable, but is needed to avoid a build failure when KVM=m.
---
 arch/mips/kvm/kvm_locore.S |    2 +-
 arch/mips/kvm/kvm_mips.c   |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

--- a/arch/mips/kvm/kvm_locore.S
+++ b/arch/mips/kvm/kvm_locore.S
@@ -428,7 +428,7 @@ __kvm_mips_return_to_guest:
 	/* Setup status register for running guest in UM */
 	.set	at
 	or	v1, v1, (ST0_EXL | KSU_USER | ST0_IE)
-	and	v1, v1, ~ST0_CU0
+	and	v1, v1, ~(ST0_CU0 | ST0_MX)
 	.set	noat
 	mtc0	v1, CP0_STATUS
 	ehb
--- a/arch/mips/kvm/kvm_mips.c
+++ b/arch/mips/kvm/kvm_mips.c
@@ -15,6 +15,7 @@
 #include <linux/vmalloc.h>
 #include <linux/fs.h>
 #include <linux/bootmem.h>
+#include <asm/fpu.h>
 #include <asm/page.h>
 #include <asm/cacheflush.h>
 #include <asm/mmu_context.h>
@@ -418,6 +419,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_v
 		vcpu->mmio_needed = 0;
 	}
 
+	lose_fpu(1);
+
 	local_irq_disable();
 	/* Check if we have any exceptions/interrupts pending */
 	kvm_mips_deliver_interrupts(vcpu,
@@ -1021,9 +1024,6 @@ void kvm_mips_set_c0_status(void)
 {
 	uint32_t status = read_c0_status();
 
-	if (cpu_has_fpu)
-		status |= (ST0_CU1);
-
 	if (cpu_has_dsp)
 		status |= (ST0_MX);
 
