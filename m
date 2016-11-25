Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Nov 2016 09:31:40 +0100 (CET)
Received: from mx2.suse.de ([195.135.220.15]:59799 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992022AbcKYIasFtMCw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 25 Nov 2016 09:30:48 +0100
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 21EE1AE03;
        Fri, 25 Nov 2016 08:30:43 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>,
        Gleb Natapov <gleb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        James Hogan <james.hogan@imgtec.com>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 3.12 003/127] MIPS: KVM: Fix unused variable build warning
Date:   Fri, 25 Nov 2016 09:28:36 +0100
Message-Id: <fb357699fe2d1f8ab6820a13353aee5a10477267.1480062521.git.jslaby@suse.cz>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <f668f2eee98250a2073a4beafdb7f6d1e21c528e.1480062521.git.jslaby@suse.cz>
References: <f668f2eee98250a2073a4beafdb7f6d1e21c528e.1480062521.git.jslaby@suse.cz>
In-Reply-To: <cover.1480062521.git.jslaby@suse.cz>
References: <cover.1480062521.git.jslaby@suse.cz>
Return-Path: <jslaby@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55889
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

From: Nicholas Mc Guire <hofrat@osadl.org>

3.12-stable review patch.  If anyone has any objections, please let me know.

===============

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
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/mips/kvm/kvm_mips_emul.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/mips/kvm/kvm_mips_emul.c b/arch/mips/kvm/kvm_mips_emul.c
index 7f3fb19d2156..779a376c4cce 100644
--- a/arch/mips/kvm/kvm_mips_emul.c
+++ b/arch/mips/kvm/kvm_mips_emul.c
@@ -1655,7 +1655,6 @@ kvm_mips_complete_mmio_load(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
 	unsigned long *gpr = &vcpu->arch.gprs[vcpu->arch.io_gpr];
 	enum emulation_result er = EMULATE_DONE;
-	unsigned long curr_pc;
 
 	if (run->mmio.len > sizeof(*gpr)) {
 		printk("Bad MMIO length: %d", run->mmio.len);
@@ -1663,11 +1662,6 @@ kvm_mips_complete_mmio_load(struct kvm_vcpu *vcpu, struct kvm_run *run)
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
2.10.2
