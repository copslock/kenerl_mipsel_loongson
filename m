Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 May 2014 11:18:24 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:26720 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822139AbaE2JRECJlkf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 May 2014 11:17:04 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 9B308ABD76050;
        Thu, 29 May 2014 10:16:54 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Thu, 29 May 2014 10:16:56 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.101) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Thu, 29 May 2014 10:16:56 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        James Hogan <james.hogan@imgtec.com>,
        Gleb Natapov <gleb@kernel.org>, <kvm@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, Sanjay Lal <sanjayl@kymasys.com>
Subject: [PATCH v2 03/23] MIPS: KVM: Use local_flush_icache_range to fix RI on XBurst
Date:   Thu, 29 May 2014 10:16:25 +0100
Message-ID: <1401355005-20370-4-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1401355005-20370-1-git-send-email-james.hogan@imgtec.com>
References: <1401355005-20370-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40324
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

MIPS KVM uses mips32_SyncICache to synchronise the icache with the
dcache after dynamically modifying guest instructions or writing guest
exception vector. However this uses rdhwr to get the SYNCI step, which
causes a reserved instruction exception on Ingenic XBurst cores.

It would seem to make more sense to use local_flush_icache_range()
instead which does the same thing but is more portable.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: kvm@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: Sanjay Lal <sanjayl@kymasys.com>
---
 arch/mips/include/asm/kvm_host.h  |  1 -
 arch/mips/kvm/kvm_locore.S        | 32 --------------------------------
 arch/mips/kvm/kvm_mips.c          |  3 ++-
 arch/mips/kvm/kvm_mips_dyntrans.c | 15 +++++++++------
 arch/mips/kvm/kvm_mips_emul.c     |  2 +-
 5 files changed, 12 insertions(+), 41 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 060aaa6348d7..f0e25c6d10b2 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -646,7 +646,6 @@ extern int kvm_mips_trans_mtc0(uint32_t inst, uint32_t *opc,
 			       struct kvm_vcpu *vcpu);
 
 /* Misc */
-extern void mips32_SyncICache(unsigned long addr, unsigned long size);
 extern int kvm_mips_dump_stats(struct kvm_vcpu *vcpu);
 extern unsigned long kvm_mips_get_ramsize(struct kvm *kvm);
 
diff --git a/arch/mips/kvm/kvm_locore.S b/arch/mips/kvm/kvm_locore.S
index bbace092ad0a..033ac343e72c 100644
--- a/arch/mips/kvm/kvm_locore.S
+++ b/arch/mips/kvm/kvm_locore.S
@@ -611,35 +611,3 @@ MIPSX(exceptions):
 	.word _C_LABEL(MIPSX(GuestException))	# 29
 	.word _C_LABEL(MIPSX(GuestException))	# 30
 	.word _C_LABEL(MIPSX(GuestException))	# 31
-
-
-/* This routine makes changes to the instruction stream effective to the hardware.
- * It should be called after the instruction stream is written.
- * On return, the new instructions are effective.
- * Inputs:
- * a0 = Start address of new instruction stream
- * a1 = Size, in bytes, of new instruction stream
- */
-
-#define HW_SYNCI_Step       $1
-LEAF(MIPSX(SyncICache))
-	.set	push
-	.set	mips32r2
-	beq	a1, zero, 20f
-	 nop
-	REG_ADDU a1, a0, a1
-	rdhwr	v0, HW_SYNCI_Step
-	beq	v0, zero, 20f
-	 nop
-10:
-	synci	0(a0)
-	REG_ADDU a0, a0, v0
-	sltu	v1, a0, a1
-	bne	v1, zero, 10b
-	 nop
-	sync
-20:
-	jr.hb	ra
-	 nop
-	.set	pop
-END(MIPSX(SyncICache))
diff --git a/arch/mips/kvm/kvm_mips.c b/arch/mips/kvm/kvm_mips.c
index 5efce56f0df0..14511138f187 100644
--- a/arch/mips/kvm/kvm_mips.c
+++ b/arch/mips/kvm/kvm_mips.c
@@ -350,7 +350,8 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm, unsigned int id)
 	       mips32_GuestExceptionEnd - mips32_GuestException);
 
 	/* Invalidate the icache for these ranges */
-	mips32_SyncICache((unsigned long) gebase, ALIGN(size, PAGE_SIZE));
+	local_flush_icache_range((unsigned long)gebase,
+				(unsigned long)gebase + ALIGN(size, PAGE_SIZE));
 
 	/* Allocate comm page for guest kernel, a TLB will be reserved for mapping GVA @ 0xFFFF8000 to this page */
 	vcpu->arch.kseg0_commpage = kzalloc(PAGE_SIZE << 1, GFP_KERNEL);
diff --git a/arch/mips/kvm/kvm_mips_dyntrans.c b/arch/mips/kvm/kvm_mips_dyntrans.c
index 96528e2d1ea6..b80e41d858fd 100644
--- a/arch/mips/kvm/kvm_mips_dyntrans.c
+++ b/arch/mips/kvm/kvm_mips_dyntrans.c
@@ -16,6 +16,7 @@
 #include <linux/vmalloc.h>
 #include <linux/fs.h>
 #include <linux/bootmem.h>
+#include <asm/cacheflush.h>
 
 #include "kvm_mips_comm.h"
 
@@ -40,7 +41,7 @@ kvm_mips_trans_cache_index(uint32_t inst, uint32_t *opc,
 	    CKSEG0ADDR(kvm_mips_translate_guest_kseg0_to_hpa
 		       (vcpu, (unsigned long) opc));
 	memcpy((void *)kseg0_opc, (void *)&synci_inst, sizeof(uint32_t));
-	mips32_SyncICache(kseg0_opc, 32);
+	local_flush_icache_range(kseg0_opc, kseg0_opc + 32);
 
 	return result;
 }
@@ -66,7 +67,7 @@ kvm_mips_trans_cache_va(uint32_t inst, uint32_t *opc,
 	    CKSEG0ADDR(kvm_mips_translate_guest_kseg0_to_hpa
 		       (vcpu, (unsigned long) opc));
 	memcpy((void *)kseg0_opc, (void *)&synci_inst, sizeof(uint32_t));
-	mips32_SyncICache(kseg0_opc, 32);
+	local_flush_icache_range(kseg0_opc, kseg0_opc + 32);
 
 	return result;
 }
@@ -99,11 +100,12 @@ kvm_mips_trans_mfc0(uint32_t inst, uint32_t *opc, struct kvm_vcpu *vcpu)
 		    CKSEG0ADDR(kvm_mips_translate_guest_kseg0_to_hpa
 			       (vcpu, (unsigned long) opc));
 		memcpy((void *)kseg0_opc, (void *)&mfc0_inst, sizeof(uint32_t));
-		mips32_SyncICache(kseg0_opc, 32);
+		local_flush_icache_range(kseg0_opc, kseg0_opc + 32);
 	} else if (KVM_GUEST_KSEGX((unsigned long) opc) == KVM_GUEST_KSEG23) {
 		local_irq_save(flags);
 		memcpy((void *)opc, (void *)&mfc0_inst, sizeof(uint32_t));
-		mips32_SyncICache((unsigned long) opc, 32);
+		local_flush_icache_range((unsigned long)opc,
+					 (unsigned long)opc + 32);
 		local_irq_restore(flags);
 	} else {
 		kvm_err("%s: Invalid address: %p\n", __func__, opc);
@@ -134,11 +136,12 @@ kvm_mips_trans_mtc0(uint32_t inst, uint32_t *opc, struct kvm_vcpu *vcpu)
 		    CKSEG0ADDR(kvm_mips_translate_guest_kseg0_to_hpa
 			       (vcpu, (unsigned long) opc));
 		memcpy((void *)kseg0_opc, (void *)&mtc0_inst, sizeof(uint32_t));
-		mips32_SyncICache(kseg0_opc, 32);
+		local_flush_icache_range(kseg0_opc, kseg0_opc + 32);
 	} else if (KVM_GUEST_KSEGX((unsigned long) opc) == KVM_GUEST_KSEG23) {
 		local_irq_save(flags);
 		memcpy((void *)opc, (void *)&mtc0_inst, sizeof(uint32_t));
-		mips32_SyncICache((unsigned long) opc, 32);
+		local_flush_icache_range((unsigned long)opc,
+					 (unsigned long)opc + 32);
 		local_irq_restore(flags);
 	} else {
 		kvm_err("%s: Invalid address: %p\n", __func__, opc);
diff --git a/arch/mips/kvm/kvm_mips_emul.c b/arch/mips/kvm/kvm_mips_emul.c
index e3fec99941a7..bad31c6235d4 100644
--- a/arch/mips/kvm/kvm_mips_emul.c
+++ b/arch/mips/kvm/kvm_mips_emul.c
@@ -887,7 +887,7 @@ int kvm_mips_sync_icache(unsigned long va, struct kvm_vcpu *vcpu)
 
 	printk("%s: va: %#lx, unmapped: %#x\n", __func__, va, CKSEG0ADDR(pa));
 
-	mips32_SyncICache(CKSEG0ADDR(pa), 32);
+	local_flush_icache_range(CKSEG0ADDR(pa), 32);
 	return 0;
 }
 
-- 
1.9.3
