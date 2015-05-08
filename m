Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 May 2015 17:46:56 +0200 (CEST)
Received: from www.osadl.org ([62.245.132.105]:52594 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27026571AbbEHPqzhbYkH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 8 May 2015 17:46:55 +0200
Received: from debian.hofr.at (92-243-35-153.adsl.nanet.at [92.243.35.153] (may be forged))
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id t48FkjOu005709;
        Fri, 8 May 2015 17:46:45 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Gleb Natapov <gleb@kernel.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] MIPS: KVM: fix unused variable build warning
Date:   Fri,  8 May 2015 17:38:52 +0200
Message-Id: <1431099532-30298-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <hofrat@osadl.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47288
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

As kvm_mips_complete_mmio_load() did not yet modify PC at this point
as James Hogans <james.hogan@imgtec.com> explained the curr_pc variable
and the comments along with it can be dropped.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Link: http://lkml.org/lkml/2015/5/8/422                                         
---

buildwarning being fixed in -next-20150508:
arch/mips/kvm/emulate.c: In function 'kvm_mips_complete_mmio_load':
arch/mips/kvm/emulate.c:2392:16: warning: variable 'curr_pc' set but not
used [-Wunused-but-set-variable]

Patch was only compile tested msp71xx_defconfig + CONFIG_KVM=m

Patch is against 4.1-rc2 (localversion-next is -next-20150508)

 arch/mips/kvm/emulate.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index 6230f37..4b50c57 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -2389,7 +2389,6 @@ enum emulation_result kvm_mips_complete_mmio_load(struct kvm_vcpu *vcpu,
 {
 	unsigned long *gpr = &vcpu->arch.gprs[vcpu->arch.io_gpr];
 	enum emulation_result er = EMULATE_DONE;
-	unsigned long curr_pc;
 
 	if (run->mmio.len > sizeof(*gpr)) {
 		kvm_err("Bad MMIO length: %d", run->mmio.len);
@@ -2397,11 +2396,6 @@ enum emulation_result kvm_mips_complete_mmio_load(struct kvm_vcpu *vcpu,
 		goto done;
 	}
 
-	/*
-	 * Update PC and hold onto current PC in case there is
-	 * an error and we want to rollback the PC
-	 */
-	curr_pc = vcpu->arch.pc;
 	er = update_pc(vcpu, vcpu->arch.pending_load_cause);
 	if (er == EMULATE_FAIL)
 		return er;
-- 
1.7.10.4
