Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 May 2015 14:59:30 +0200 (CEST)
Received: from www.osadl.org ([62.245.132.105]:42872 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012252AbbEGM72zkpzT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 7 May 2015 14:59:28 +0200
Received: from debian.hofr.at (92-243-35-153.adsl.nanet.at [92.243.35.153] (may be forged))
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id t47CxNGk005902;
        Thu, 7 May 2015 14:59:23 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Gleb Natapov <gleb@kernel.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH RFC] MIPS: KVM: role back pc in case of EMULATE_FAIL
Date:   Thu,  7 May 2015 14:51:31 +0200
Message-Id: <1431003091-30161-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <hofrat@osadl.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47271
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hofrat@osadl.org
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

Currently if kvm_mips_complete_mmio_load() fails with EMULATE_FAIL it will
not role back the pc nor will the caller handle this failure.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---
 arch/mips/kvm/emulate.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

kvm_mips_complete_mmio_load is called only in arch/mips/kvm/mips.c without
checking the return value to signal EMULATE_FAIL:
 383         if (vcpu->mmio_needed) {
 384                 if (!vcpu->mmio_is_write)
 385                         kvm_mips_complete_mmio_load(vcpu, run);
 386                 vcpu->mmio_needed = 0;
 387         }

so maybe kvm_mips_complete_mmio_load should role back in case of failure 
at arch/mips/kvm/emuilate.c:kvm_mips_complete_mmio_load()
2406         if (er == EMULATE_FAIL) {
2408                 return er;

something like the below patch - only based no looking at how EMULATE_FAIL
is handled at other locations - not sure if this is appropriate here.

Patch was only compile tested msp71xx_defconfig + CONFIG_KVM=m

Patch is against 4.1-rc2 (localversion-next is -next-20150506)

diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index 2f0fc60..b58596b 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -2403,8 +2403,10 @@ enum emulation_result kvm_mips_complete_mmio_load(struct kvm_vcpu *vcpu,
 	 */
 	curr_pc = vcpu->arch.pc;
 	er = update_pc(vcpu, vcpu->arch.pending_load_cause);
-	if (er == EMULATE_FAIL)
+	if (er == EMULATE_FAIL) {
+		vcpu->arch.pc = curr_pc;
 		return er;
+	}
 
 	switch (run->mmio.len) {
 	case 4:
-- 
1.7.10.4
