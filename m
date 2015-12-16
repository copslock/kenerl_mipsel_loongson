Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Dec 2015 00:53:49 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:21759 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27014077AbbLPXuRepbB0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Dec 2015 00:50:17 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 8962E1E41BC20;
        Wed, 16 Dec 2015 23:50:07 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Wed, 16 Dec 2015 23:50:11 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 16 Dec 2015 23:50:10 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paolo Bonzini <pbonzini@redhat.com>
CC:     Gleb Natapov <gleb@kernel.org>, <linux-mips@linux-mips.org>,
        <kvm@vger.kernel.org>, James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 12/16] MIPS: KVM: Use cacheops.h definitions
Date:   Wed, 16 Dec 2015 23:49:37 +0000
Message-ID: <1450309781-28030-13-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1450309781-28030-1-git-send-email-james.hogan@imgtec.com>
References: <1450309781-28030-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50659
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

Drop the custom cache operation code definitions used by KVM for
emulating guest CACHE instructions, and switch to use the existing
definitions in <asm/cacheops.h>.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: kvm@vger.kernel.org
Cc: linux-mips@linux-mips.org
---
 arch/mips/kvm/emulate.c | 30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index 6ff1dcfc9ef1..0eb65668d2ab 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -20,6 +20,7 @@
 #include <linux/random.h>
 #include <asm/page.h>
 #include <asm/cacheflush.h>
+#include <asm/cacheops.h>
 #include <asm/cpu-info.h>
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
@@ -1544,19 +1545,6 @@ int kvm_mips_sync_icache(unsigned long va, struct kvm_vcpu *vcpu)
 	return 0;
 }
 
-#define MIPS_CACHE_OP_INDEX_INV         0x0
-#define MIPS_CACHE_OP_INDEX_LD_TAG      0x1
-#define MIPS_CACHE_OP_INDEX_ST_TAG      0x2
-#define MIPS_CACHE_OP_IMP               0x3
-#define MIPS_CACHE_OP_HIT_INV           0x4
-#define MIPS_CACHE_OP_FILL_WB_INV       0x5
-#define MIPS_CACHE_OP_HIT_HB            0x6
-#define MIPS_CACHE_OP_FETCH_LOCK        0x7
-
-#define MIPS_CACHE_ICACHE               0x0
-#define MIPS_CACHE_DCACHE               0x1
-#define MIPS_CACHE_SEC                  0x3
-
 enum emulation_result kvm_mips_emulate_cache(uint32_t inst, uint32_t *opc,
 					     uint32_t cause,
 					     struct kvm_run *run,
@@ -1581,8 +1569,8 @@ enum emulation_result kvm_mips_emulate_cache(uint32_t inst, uint32_t *opc,
 	base = (inst >> 21) & 0x1f;
 	op_inst = (inst >> 16) & 0x1f;
 	offset = (int16_t)inst;
-	cache = (inst >> 16) & 0x3;
-	op = (inst >> 18) & 0x7;
+	cache = op_inst & CacheOp_Cache;
+	op = op_inst & CacheOp_Op;
 
 	va = arch->gprs[base] + offset;
 
@@ -1594,14 +1582,14 @@ enum emulation_result kvm_mips_emulate_cache(uint32_t inst, uint32_t *opc,
 	 * invalidate the caches entirely by stepping through all the
 	 * ways/indexes
 	 */
-	if (op == MIPS_CACHE_OP_INDEX_INV) {
+	if (op == Index_Writeback_Inv) {
 		kvm_debug("@ %#lx/%#lx CACHE (cache: %#x, op: %#x, base[%d]: %#lx, offset: %#x\n",
 			  vcpu->arch.pc, vcpu->arch.gprs[31], cache, op, base,
 			  arch->gprs[base], offset);
 
-		if (cache == MIPS_CACHE_DCACHE)
+		if (cache == Cache_D)
 			r4k_blast_dcache();
-		else if (cache == MIPS_CACHE_ICACHE)
+		else if (cache == Cache_I)
 			r4k_blast_icache();
 		else {
 			kvm_err("%s: unsupported CACHE INDEX operation\n",
@@ -1674,9 +1662,7 @@ enum emulation_result kvm_mips_emulate_cache(uint32_t inst, uint32_t *opc,
 
 skip_fault:
 	/* XXXKYMA: Only a subset of cache ops are supported, used by Linux */
-	if (cache == MIPS_CACHE_DCACHE
-	    && (op == MIPS_CACHE_OP_FILL_WB_INV
-		|| op == MIPS_CACHE_OP_HIT_INV)) {
+	if (op_inst == Hit_Writeback_Inv_D || op_inst == Hit_Invalidate_D) {
 		flush_dcache_line(va);
 
 #ifdef CONFIG_KVM_MIPS_DYN_TRANS
@@ -1686,7 +1672,7 @@ skip_fault:
 		 */
 		kvm_mips_trans_cache_va(inst, opc, vcpu);
 #endif
-	} else if (op == MIPS_CACHE_OP_HIT_INV && cache == MIPS_CACHE_ICACHE) {
+	} else if (op_inst == Hit_Invalidate_I) {
 		flush_dcache_line(va);
 		flush_icache_line(va);
 
-- 
2.4.10
