Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2015 21:49:52 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:50899 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014857AbbCaTtfIqUva (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Mar 2015 21:49:35 +0200
Received: from [10.172.68.52] (helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.71)
        (envelope-from <kamal@canonical.com>)
        id 1Yd2AD-0000pV-BU; Tue, 31 Mar 2015 19:49:29 +0000
Received: from kamal by fourier with local (Exim 4.82)
        (envelope-from <kamal@whence.com>)
        id 1Yd2AA-0000d2-Tg; Tue, 31 Mar 2015 12:49:26 -0700
From:   Kamal Mostafa <kamal@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sanjay Lal <sanjayl@kymasys.com>,
        Gleb Natapov <gleb@kernel.org>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org,
        Luis Henriques <luis.henriques@canonical.com>,
        Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 3.13.y-ckt 069/143] KVM: MIPS: Don't leak FPU/DSP to guest
Date:   Tue, 31 Mar 2015 12:47:14 -0700
Message-Id: <1427831308-1854-70-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1427831308-1854-1-git-send-email-kamal@canonical.com>
References: <1427831308-1854-1-git-send-email-kamal@canonical.com>
X-Extended-Stable: 3.13
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46670
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
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[ luis: backported to 3.16: files rename:
  - locore.S -> kvm_locore.S
  - mips.c -> kvm_mips.c ]
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>

Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/kvm/kvm_locore.S | 2 +-
 arch/mips/kvm/kvm_mips.c   | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kvm/kvm_locore.S b/arch/mips/kvm/kvm_locore.S
index bbace09..03a2db5 100644
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
diff --git a/arch/mips/kvm/kvm_mips.c b/arch/mips/kvm/kvm_mips.c
index 4d058a7..bdc5eeb 100644
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
@@ -424,6 +425,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		vcpu->mmio_needed = 0;
 	}
 
+	lose_fpu(1);
+
 	local_irq_disable();
 	/* Check if we have any exceptions/interrupts pending */
 	kvm_mips_deliver_interrupts(vcpu,
@@ -1028,9 +1031,6 @@ void kvm_mips_set_c0_status(void)
 {
 	uint32_t status = read_c0_status();
 
-	if (cpu_has_fpu)
-		status |= (ST0_CU1);
-
 	if (cpu_has_dsp)
 		status |= (ST0_MX);
 
-- 
1.9.1
