Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Jul 2016 12:56:54 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:28113 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992829AbcGHKyGA7Guv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Jul 2016 12:54:06 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 4F06F142AB953;
        Fri,  8 Jul 2016 11:53:47 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 8 Jul 2016 11:53:49 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        James Hogan <james.hogan@imgtec.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 03/12] MIPS: KVM: Use kmap instead of CKSEG0ADDR()
Date:   Fri, 8 Jul 2016 11:53:22 +0100
Message-ID: <1467975211-12674-4-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1467975211-12674-1-git-send-email-james.hogan@imgtec.com>
References: <1467975211-12674-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54266
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

There are several unportable uses of CKSEG0ADDR() in MIPS KVM, which
implicitly assume that a host physical address will be in the low 512MB
of the physical address space (accessible in KSeg0). These assumptions
don't hold for highmem or on 64-bit kernels.

When interpreting the guest physical address when reading or overwriting
a trapping instruction, use kmap_atomic() to get a usable virtual
address to access guest memory, which is portable to 64-bit and highmem
kernels.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/dyntrans.c | 17 +++++++++++------
 arch/mips/kvm/mmu.c      |  7 ++++++-
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/mips/kvm/dyntrans.c b/arch/mips/kvm/dyntrans.c
index 91ebd2b6034f..9a16ba2cb487 100644
--- a/arch/mips/kvm/dyntrans.c
+++ b/arch/mips/kvm/dyntrans.c
@@ -11,6 +11,7 @@
 
 #include <linux/errno.h>
 #include <linux/err.h>
+#include <linux/highmem.h>
 #include <linux/kvm_host.h>
 #include <linux/module.h>
 #include <linux/vmalloc.h>
@@ -29,14 +30,18 @@
 static int kvm_mips_trans_replace(struct kvm_vcpu *vcpu, u32 *opc,
 				  union mips_instruction replace)
 {
-	unsigned long kseg0_opc, flags;
+	unsigned long paddr, flags;
+	void *vaddr;
 
 	if (KVM_GUEST_KSEGX(opc) == KVM_GUEST_KSEG0) {
-		kseg0_opc =
-		    CKSEG0ADDR(kvm_mips_translate_guest_kseg0_to_hpa
-			       (vcpu, (unsigned long) opc));
-		memcpy((void *)kseg0_opc, (void *)&replace, sizeof(u32));
-		local_flush_icache_range(kseg0_opc, kseg0_opc + 32);
+		paddr = kvm_mips_translate_guest_kseg0_to_hpa(vcpu,
+							    (unsigned long)opc);
+		vaddr = kmap_atomic(pfn_to_page(PHYS_PFN(paddr)));
+		vaddr += paddr & ~PAGE_MASK;
+		memcpy(vaddr, (void *)&replace, sizeof(u32));
+		local_flush_icache_range((unsigned long)vaddr,
+					 (unsigned long)vaddr + 32);
+		kunmap_atomic(vaddr);
 	} else if (KVM_GUEST_KSEGX((unsigned long) opc) == KVM_GUEST_KSEG23) {
 		local_irq_save(flags);
 		memcpy((void *)opc, (void *)&replace, sizeof(u32));
diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index ecead748de04..57319ee57c4f 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -9,6 +9,7 @@
  * Authors: Sanjay Lal <sanjayl@kymasys.com>
  */
 
+#include <linux/highmem.h>
 #include <linux/kvm_host.h>
 #include <asm/mmu_context.h>
 
@@ -330,6 +331,7 @@ u32 kvm_get_inst(u32 *opc, struct kvm_vcpu *vcpu)
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	unsigned long paddr, flags, vpn2, asid;
 	unsigned long va = (unsigned long)opc;
+	void *vaddr;
 	u32 inst;
 	int index;
 
@@ -360,7 +362,10 @@ u32 kvm_get_inst(u32 *opc, struct kvm_vcpu *vcpu)
 		local_irq_restore(flags);
 	} else if (KVM_GUEST_KSEGX(va) == KVM_GUEST_KSEG0) {
 		paddr = kvm_mips_translate_guest_kseg0_to_hpa(vcpu, va);
-		inst = *(u32 *) CKSEG0ADDR(paddr);
+		vaddr = kmap_atomic(pfn_to_page(PHYS_PFN(paddr)));
+		vaddr += paddr & ~PAGE_MASK;
+		inst = *(u32 *)vaddr;
+		kunmap_atomic(vaddr);
 	} else {
 		kvm_err("%s: illegal address: %p\n", __func__, opc);
 		return KVM_INVALID_INST;
-- 
2.4.10
