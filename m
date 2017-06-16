Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 14:23:08 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:23374 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994811AbdFPMXBnJlHl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jun 2017 14:23:01 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 95A0163D36211;
        Fri, 16 Jun 2017 13:22:51 +0100 (IST)
Received: from LDT-J-COWGILL.le.imgtec.org (10.150.130.85) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 16 Jun 2017 13:22:54 +0100
From:   James Cowgill <James.Cowgill@imgtec.com>
To:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <kvm@vger.kernel.org>, James Cowgill <James.Cowgill@imgtec.com>
Subject: [PATCH] KVM: MIPS: Fix maybe-uninitialized build failure
Date:   Fri, 16 Jun 2017 13:05:02 +0100
Message-ID: <20170616120502.2660-1-James.Cowgill@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.150.130.85]
Return-Path: <James.Cowgill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58525
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: James.Cowgill@imgtec.com
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

This commit fixes a "maybe-uninitialized" build failure in
arch/mips/kvm/tlb.c when KVM, DYNAMIC_DEBUG and JUMP_LABEL are all
enabled. The failure is:

In file included from ./include/linux/printk.h:329:0,
                 from ./include/linux/kernel.h:13,
                 from ./include/asm-generic/bug.h:15,
                 from ./arch/mips/include/asm/bug.h:41,
                 from ./include/linux/bug.h:4,
                 from ./include/linux/thread_info.h:11,
                 from ./include/asm-generic/current.h:4,
                 from ./arch/mips/include/generated/asm/current.h:1,
                 from ./include/linux/sched.h:11,
                 from arch/mips/kvm/tlb.c:13:
arch/mips/kvm/tlb.c: In function ‘kvm_mips_host_tlb_inv’:
./include/linux/dynamic_debug.h:126:3: error: ‘idx_kernel’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
   __dynamic_pr_debug(&descriptor, pr_fmt(fmt), \
   ^~~~~~~~~~~~~~~~~~
arch/mips/kvm/tlb.c:169:16: note: ‘idx_kernel’ was declared here
  int idx_user, idx_kernel;
                ^~~~~~~~~~

There is a similar error relating to "idx_user".

As far as I can tell, it is impossible for either idx_user or idx_kernel
to be uninitialized when they are later read in the calls to kvm_debug,
but to satisfy the compiler, add zero initializers to both variables.

Signed-off-by: James Cowgill <James.Cowgill@imgtec.com>
Fixes: 57e3869cfaae ("KVM: MIPS/TLB: Generalise host TLB invalidate to kernel ASID")
Cc: <stable@vger.kernel.org> # 4.11+
---
 arch/mips/kvm/tlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kvm/tlb.c b/arch/mips/kvm/tlb.c
index 7c6336dd2638..41d239269988 100644
--- a/arch/mips/kvm/tlb.c
+++ b/arch/mips/kvm/tlb.c
@@ -166,7 +166,7 @@ static int _kvm_mips_host_tlb_inv(unsigned long entryhi)
 int kvm_mips_host_tlb_inv(struct kvm_vcpu *vcpu, unsigned long va,
 			  bool user, bool kernel)
 {
-	int idx_user, idx_kernel;
+	int idx_user = 0, idx_kernel = 0;
 	unsigned long flags, old_entryhi;
 
 	local_irq_save(flags);
-- 
2.11.0
