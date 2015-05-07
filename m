Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 May 2015 14:56:01 +0200 (CEST)
Received: from www.osadl.org ([62.245.132.105]:42832 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012252AbbEGM4AMqPAI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 7 May 2015 14:56:00 +0200
Received: from debian.hofr.at (92-243-35-153.adsl.nanet.at [92.243.35.153] (may be forged))
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id t47CtgZv005523;
        Thu, 7 May 2015 14:55:45 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Gleb Natapov <gleb@kernel.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] MIPS: KVM: do not sign extend on unsigned MMIO load
Date:   Thu,  7 May 2015 14:47:50 +0200
Message-Id: <1431002870-30098-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <hofrat@osadl.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47270
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

Fix possible unintended sign extension in unsigned MMIO loads by casting
to uint16_t in the case of mmio_needed != 2.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Thanks to James Hogan <james.hogan@imgtec.com> for the explaination of 
mmio_needed (there is not really any helpful comment in the code on this)
in this case (mmio_needed!=2) it should be unsigned.

Patch was only compile tested msp71xx_defconfig + CONFIG_KVM=m

Patch is against 4.1-rc2 (localversion-next is -next-20150506)

 arch/mips/kvm/emulate.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index 6230f37..2f0fc60 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -2415,7 +2415,7 @@ enum emulation_result kvm_mips_complete_mmio_load(struct kvm_vcpu *vcpu,
 		if (vcpu->mmio_needed == 2)
 			*gpr = *(int16_t *) run->mmio.data;
 		else
-			*gpr = *(int16_t *) run->mmio.data;
+			*gpr = *(uint16_t *)run->mmio.data;
 
 		break;
 	case 1:
-- 
1.7.10.4
