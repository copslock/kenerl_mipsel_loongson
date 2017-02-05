Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Feb 2017 20:15:06 +0100 (CET)
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:27208 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991532AbdBETO5j0rIJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 5 Feb 2017 20:14:57 +0100
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id v15JEY6J007943;
        Sun, 5 Feb 2017 20:14:34 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux@roeck-us.net
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Gleb Natapov <gleb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        James Hogan <james.hogan@imgtec.com>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 3.10 022/319] MIPS: KVM: Fix unused variable build warning
Date:   Sun,  5 Feb 2017 20:09:26 +0100
Message-Id: <1486322063-7558-23-git-send-email-w@1wt.eu>
X-Mailer: git-send-email 2.8.0.rc2.1.gbe9624a
In-Reply-To: <1486322063-7558-1-git-send-email-w@1wt.eu>
References: <1486322063-7558-1-git-send-email-w@1wt.eu>
Return-Path: <w@1wt.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56638
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: w@1wt.eu
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

From: Nicholas Mc Guire <hofrat@osadl.org>

commit 5f508c43a7648baa892528922402f1e13f258bd4 upstream.

As kvm_mips_complete_mmio_load() did not yet modify PC at this point
as James Hogans <james.hogan@imgtec.com> explained the curr_pc variable
and the comments along with it can be dropped.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Link: http://lkml.org/lkml/2015/5/8/422
Cc: Gleb Natapov <gleb@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: kvm@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/9993/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
[james.hogan@imgtec.com: Backport to 3.10..3.16]
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 arch/mips/kvm/kvm_mips_emul.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/mips/kvm/kvm_mips_emul.c b/arch/mips/kvm/kvm_mips_emul.c
index 9f76438..5c2d70b 100644
--- a/arch/mips/kvm/kvm_mips_emul.c
+++ b/arch/mips/kvm/kvm_mips_emul.c
@@ -1610,7 +1610,6 @@ kvm_mips_complete_mmio_load(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
 	unsigned long *gpr = &vcpu->arch.gprs[vcpu->arch.io_gpr];
 	enum emulation_result er = EMULATE_DONE;
-	unsigned long curr_pc;
 
 	if (run->mmio.len > sizeof(*gpr)) {
 		printk("Bad MMIO length: %d", run->mmio.len);
@@ -1618,11 +1617,6 @@ kvm_mips_complete_mmio_load(struct kvm_vcpu *vcpu, struct kvm_run *run)
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
2.8.0.rc2.1.gbe9624a
