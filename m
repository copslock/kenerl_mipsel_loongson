Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 May 2013 07:51:55 +0200 (CEST)
Received: from kymasys.com ([64.62.140.43]:58424 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6835024Ab3ESFslV73c0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 19 May 2013 07:48:41 +0200
Received: from agni.kymasys.com ([75.40.23.192]) by kymasys.com for <linux-mips@linux-mips.org>; Sat, 18 May 2013 22:48:31 -0700
Received: by agni.kymasys.com (Postfix, from userid 500)
        id 5E4FA630069; Sat, 18 May 2013 22:47:43 -0700 (PDT)
From:   Sanjay Lal <sanjayl@kymasys.com>
To:     kvm@vger.kernel.org
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Gleb Natapov <gleb@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Sanjay Lal <sanjayl@kymasys.com>
Subject: [PATCH 17/18] KVM/MIPS32: Revert to older method for accessing ASID parameters
Date:   Sat, 18 May 2013 22:47:39 -0700
Message-Id: <1368942460-15577-18-git-send-email-sanjayl@kymasys.com>
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1368942460-15577-1-git-send-email-sanjayl@kymasys.com>
References: <n>
 <1368942460-15577-1-git-send-email-sanjayl@kymasys.com>
Return-Path: <sanjayl@kymasys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36465
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sanjayl@kymasys.com
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

- Now that commit d532f3d26 has been reverted in the MIPS tree,
  revert back to the older method of using the ASID_MASK.
- Trivial cleanup: s/unsigned long/long

Signed-off-by: Sanjay Lal <sanjayl@kymasys.com>
---
 arch/mips/kvm/kvm_mips_dyntrans.c |  24 ++--
 arch/mips/kvm/kvm_mips_emul.c     | 236 ++++++++++++++++++++++----------------
 2 files changed, 147 insertions(+), 113 deletions(-)

diff --git a/arch/mips/kvm/kvm_mips_dyntrans.c b/arch/mips/kvm/kvm_mips_dyntrans.c
index 96528e2..c657b37 100644
--- a/arch/mips/kvm/kvm_mips_dyntrans.c
+++ b/arch/mips/kvm/kvm_mips_dyntrans.c
@@ -32,13 +32,13 @@ kvm_mips_trans_cache_index(uint32_t inst, uint32_t *opc,
 			   struct kvm_vcpu *vcpu)
 {
 	int result = 0;
-	unsigned long kseg0_opc;
+	ulong kseg0_opc;
 	uint32_t synci_inst = 0x0;
 
 	/* Replace the CACHE instruction, with a NOP */
 	kseg0_opc =
 	    CKSEG0ADDR(kvm_mips_translate_guest_kseg0_to_hpa
-		       (vcpu, (unsigned long) opc));
+		       (vcpu, (ulong) opc));
 	memcpy((void *)kseg0_opc, (void *)&synci_inst, sizeof(uint32_t));
 	mips32_SyncICache(kseg0_opc, 32);
 
@@ -54,7 +54,7 @@ kvm_mips_trans_cache_va(uint32_t inst, uint32_t *opc,
 			struct kvm_vcpu *vcpu)
 {
 	int result = 0;
-	unsigned long kseg0_opc;
+	ulong kseg0_opc;
 	uint32_t synci_inst = SYNCI_TEMPLATE, base, offset;
 
 	base = (inst >> 21) & 0x1f;
@@ -64,7 +64,7 @@ kvm_mips_trans_cache_va(uint32_t inst, uint32_t *opc,
 
 	kseg0_opc =
 	    CKSEG0ADDR(kvm_mips_translate_guest_kseg0_to_hpa
-		       (vcpu, (unsigned long) opc));
+		       (vcpu, (ulong) opc));
 	memcpy((void *)kseg0_opc, (void *)&synci_inst, sizeof(uint32_t));
 	mips32_SyncICache(kseg0_opc, 32);
 
@@ -76,7 +76,7 @@ kvm_mips_trans_mfc0(uint32_t inst, uint32_t *opc, struct kvm_vcpu *vcpu)
 {
 	int32_t rt, rd, sel;
 	uint32_t mfc0_inst;
-	unsigned long kseg0_opc, flags;
+	ulong kseg0_opc, flags;
 
 	rt = (inst >> 16) & 0x1f;
 	rd = (inst >> 11) & 0x1f;
@@ -97,13 +97,13 @@ kvm_mips_trans_mfc0(uint32_t inst, uint32_t *opc, struct kvm_vcpu *vcpu)
 	if (KVM_GUEST_KSEGX(opc) == KVM_GUEST_KSEG0) {
 		kseg0_opc =
 		    CKSEG0ADDR(kvm_mips_translate_guest_kseg0_to_hpa
-			       (vcpu, (unsigned long) opc));
+			       (vcpu, (ulong) opc));
 		memcpy((void *)kseg0_opc, (void *)&mfc0_inst, sizeof(uint32_t));
 		mips32_SyncICache(kseg0_opc, 32);
-	} else if (KVM_GUEST_KSEGX((unsigned long) opc) == KVM_GUEST_KSEG23) {
+	} else if (KVM_GUEST_KSEGX((ulong) opc) == KVM_GUEST_KSEG23) {
 		local_irq_save(flags);
 		memcpy((void *)opc, (void *)&mfc0_inst, sizeof(uint32_t));
-		mips32_SyncICache((unsigned long) opc, 32);
+		mips32_SyncICache((ulong) opc, 32);
 		local_irq_restore(flags);
 	} else {
 		kvm_err("%s: Invalid address: %p\n", __func__, opc);
@@ -118,7 +118,7 @@ kvm_mips_trans_mtc0(uint32_t inst, uint32_t *opc, struct kvm_vcpu *vcpu)
 {
 	int32_t rt, rd, sel;
 	uint32_t mtc0_inst = SW_TEMPLATE;
-	unsigned long kseg0_opc, flags;
+	ulong kseg0_opc, flags;
 
 	rt = (inst >> 16) & 0x1f;
 	rd = (inst >> 11) & 0x1f;
@@ -132,13 +132,13 @@ kvm_mips_trans_mtc0(uint32_t inst, uint32_t *opc, struct kvm_vcpu *vcpu)
 	if (KVM_GUEST_KSEGX(opc) == KVM_GUEST_KSEG0) {
 		kseg0_opc =
 		    CKSEG0ADDR(kvm_mips_translate_guest_kseg0_to_hpa
-			       (vcpu, (unsigned long) opc));
+			       (vcpu, (ulong) opc));
 		memcpy((void *)kseg0_opc, (void *)&mtc0_inst, sizeof(uint32_t));
 		mips32_SyncICache(kseg0_opc, 32);
-	} else if (KVM_GUEST_KSEGX((unsigned long) opc) == KVM_GUEST_KSEG23) {
+	} else if (KVM_GUEST_KSEGX((ulong) opc) == KVM_GUEST_KSEG23) {
 		local_irq_save(flags);
 		memcpy((void *)opc, (void *)&mtc0_inst, sizeof(uint32_t));
-		mips32_SyncICache((unsigned long) opc, 32);
+		mips32_SyncICache((ulong) opc, 32);
 		local_irq_restore(flags);
 	} else {
 		kvm_err("%s: Invalid address: %p\n", __func__, opc);
diff --git a/arch/mips/kvm/kvm_mips_emul.c b/arch/mips/kvm/kvm_mips_emul.c
index 2b2bac9..d9fb542 100644
--- a/arch/mips/kvm/kvm_mips_emul.c
+++ b/arch/mips/kvm/kvm_mips_emul.c
@@ -34,12 +34,13 @@
 
 #include "trace.h"
 
+static int debug __maybe_unused;
+
 /*
  * Compute the return address and do emulate branch simulation, if required.
  * This function should be called only in branch delay slot active.
  */
-unsigned long kvm_compute_return_epc(struct kvm_vcpu *vcpu,
-	unsigned long instpc)
+u_long kvm_compute_return_epc(struct kvm_vcpu *vcpu, u_long instpc)
 {
 	unsigned int dspcontrol;
 	union mips_instruction insn;
@@ -209,7 +210,7 @@ sigill:
 
 enum emulation_result update_pc(struct kvm_vcpu *vcpu, uint32_t cause)
 {
-	unsigned long branch_pc;
+	u_long branch_pc;
 	enum emulation_result er = EMULATE_DONE;
 
 	if (cause & CAUSEF_BD) {
@@ -234,8 +235,8 @@ enum emulation_result update_pc(struct kvm_vcpu *vcpu, uint32_t cause)
  */
 enum emulation_result kvm_mips_emulate_count(struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	enum emulation_result er = EMULATE_DONE;
+	struct mips_coproc *cop0 = vcpu->arch.cop0;
 
 	/* If COUNT is enabled */
 	if (!(kvm_read_c0_guest_cause(cop0) & CAUSEF_DC)) {
@@ -245,15 +246,13 @@ enum emulation_result kvm_mips_emulate_count(struct kvm_vcpu *vcpu)
 	} else {
 		hrtimer_try_to_cancel(&vcpu->arch.comparecount_timer);
 	}
-
 	return er;
 }
 
 enum emulation_result kvm_mips_emul_eret(struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	enum emulation_result er = EMULATE_DONE;
-
+	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	if (kvm_read_c0_guest_status(cop0) & ST0_EXL) {
 		kvm_debug("[%#lx] ERET to %#lx\n", vcpu->arch.pc,
 			  kvm_read_c0_guest_epc(cop0));
@@ -268,7 +267,6 @@ enum emulation_result kvm_mips_emul_eret(struct kvm_vcpu *vcpu)
 		       vcpu->arch.pc);
 		er = EMULATE_FAIL;
 	}
-
 	return er;
 }
 
@@ -302,9 +300,9 @@ enum emulation_result kvm_mips_emul_wait(struct kvm_vcpu *vcpu)
  */
 enum emulation_result kvm_mips_emul_tlbr(struct kvm_vcpu *vcpu)
 {
+	uint32_t pc = vcpu->arch.pc;
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	enum emulation_result er = EMULATE_FAIL;
-	uint32_t pc = vcpu->arch.pc;
 
 	printk("[%#x] COP0_TLBR [%ld]\n", pc, kvm_read_c0_guest_index(cop0));
 	return er;
@@ -313,9 +311,9 @@ enum emulation_result kvm_mips_emul_tlbr(struct kvm_vcpu *vcpu)
 /* Write Guest TLB Entry @ Index */
 enum emulation_result kvm_mips_emul_tlbwi(struct kvm_vcpu *vcpu)
 {
+	enum emulation_result er = EMULATE_DONE;
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	int index = kvm_read_c0_guest_index(cop0);
-	enum emulation_result er = EMULATE_DONE;
 	struct kvm_mips_tlb *tlb = NULL;
 	uint32_t pc = vcpu->arch.pc;
 
@@ -331,10 +329,8 @@ enum emulation_result kvm_mips_emul_tlbwi(struct kvm_vcpu *vcpu)
 	}
 
 	tlb = &vcpu->arch.guest_tlb[index];
-#if 1
 	/* Probe the shadow host TLB for the entry being overwritten, if one matches, invalidate it */
 	kvm_mips_host_tlb_inv(vcpu, tlb->tlb_hi);
-#endif
 
 	tlb->tlb_mask = kvm_read_c0_guest_pagemask(cop0);
 	tlb->tlb_hi = kvm_read_c0_guest_entryhi(cop0);
@@ -353,18 +349,14 @@ enum emulation_result kvm_mips_emul_tlbwi(struct kvm_vcpu *vcpu)
 /* Write Guest TLB Entry @ Random Index */
 enum emulation_result kvm_mips_emul_tlbwr(struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	enum emulation_result er = EMULATE_DONE;
-	struct kvm_mips_tlb *tlb = NULL;
+	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	uint32_t pc = vcpu->arch.pc;
 	int index;
+	struct kvm_mips_tlb *tlb = NULL;
 
-#if 1
 	get_random_bytes(&index, sizeof(index));
 	index &= (KVM_MIPS_GUEST_TLB_SIZE - 1);
-#else
-	index = jiffies % KVM_MIPS_GUEST_TLB_SIZE;
-#endif
 
 	if (index < 0 || index >= KVM_MIPS_GUEST_TLB_SIZE) {
 		printk("%s: illegal index: %d\n", __func__, index);
@@ -373,10 +365,8 @@ enum emulation_result kvm_mips_emul_tlbwr(struct kvm_vcpu *vcpu)
 
 	tlb = &vcpu->arch.guest_tlb[index];
 
-#if 1
 	/* Probe the shadow host TLB for the entry being overwritten, if one matches, invalidate it */
 	kvm_mips_host_tlb_inv(vcpu, tlb->tlb_hi);
-#endif
 
 	tlb->tlb_mask = kvm_read_c0_guest_pagemask(cop0);
 	tlb->tlb_hi = kvm_read_c0_guest_entryhi(cop0);
@@ -394,11 +384,11 @@ enum emulation_result kvm_mips_emul_tlbwr(struct kvm_vcpu *vcpu)
 
 enum emulation_result kvm_mips_emul_tlbp(struct kvm_vcpu *vcpu)
 {
+	int index = -1;
+	uint32_t pc = vcpu->arch.pc;
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	long entryhi = kvm_read_c0_guest_entryhi(cop0);
 	enum emulation_result er = EMULATE_DONE;
-	uint32_t pc = vcpu->arch.pc;
-	int index = -1;
 
 	index = kvm_mips_guest_tlb_lookup(vcpu, entryhi);
 
@@ -414,11 +404,11 @@ enum emulation_result
 kvm_mips_emulate_CP0(uint32_t inst, uint32_t *opc, uint32_t cause,
 		     struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	enum emulation_result er = EMULATE_DONE;
 	int32_t rt, rd, copz, sel, co_bit, op;
+	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	uint32_t pc = vcpu->arch.pc;
-	unsigned long curr_pc;
+	u_long curr_pc;
 
 	/*
 	 * Update PC and hold onto current PC in case there is
@@ -478,15 +468,29 @@ kvm_mips_emulate_CP0(uint32_t inst, uint32_t *opc, uint32_t cause,
 #endif
 			/* Get reg */
 			if ((rd == MIPS_CP0_COUNT) && (sel == 0)) {
+#ifdef CONFIG_KVM_MIPS_VZ
+				vcpu->arch.gprs[rt] =
+				    kvm_read_c0_guest_count(cop0);
+#else
 				/* XXXKYMA: Run the Guest count register @ 1/4 the rate of the host */
 				vcpu->arch.gprs[rt] = (read_c0_count() >> 2);
+#endif
 			} else if ((rd == MIPS_CP0_ERRCTL) && (sel == 0)) {
 				vcpu->arch.gprs[rt] = 0x0;
 #ifdef CONFIG_KVM_MIPS_DYN_TRANS
 				kvm_mips_trans_mfc0(inst, opc, vcpu);
 #endif
 			}
+#ifdef CONFIG_KVM_MIPS_VZ
+			else if ((rd == MIPS_CP0_COMPARE) && (sel == 0)) {
+				vcpu->arch.gprs[rt] =
+				    kvm_read_c0_guest_compare(cop0);
+			}
+#endif
 			else {
+#ifdef CONFIG_KVM_MIPS_VZ
+				/* TODO VZ validate CP0 accesses for CONFIG_KVM_MIPS_VZ */
+#endif
 				vcpu->arch.gprs[rt] = cop0->reg[rd][sel];
 
 #ifdef CONFIG_KVM_MIPS_DYN_TRANS
@@ -501,6 +505,9 @@ kvm_mips_emulate_CP0(uint32_t inst, uint32_t *opc, uint32_t cause,
 			break;
 
 		case dmfc_op:
+#ifdef CONFIG_KVM_MIPS_VZ
+			/* TODO VZ add DMFC CONFIG_KVM_MIPS_VZ support if required */
+#endif
 			vcpu->arch.gprs[rt] = cop0->reg[rd][sel];
 			break;
 
@@ -525,16 +532,18 @@ kvm_mips_emulate_CP0(uint32_t inst, uint32_t *opc, uint32_t cause,
 				printk("MTCz, cop0->reg[EBASE]: %#lx\n",
 				       kvm_read_c0_guest_ebase(cop0));
 			} else if (rd == MIPS_CP0_TLB_HI && sel == 0) {
-				uint32_t nasid = ASID_MASK(vcpu->arch.gprs[rt]);
+				uint32_t nasid =
+				    vcpu->arch.gprs[rt] & ASID_MASK;
 				if ((KSEGX(vcpu->arch.gprs[rt]) != CKSEG0)
 				    &&
-				    (ASID_MASK(kvm_read_c0_guest_entryhi(cop0))
-				      != nasid)) {
+				    ((kvm_read_c0_guest_entryhi(cop0) &
+				      ASID_MASK) != nasid)) {
 
 					kvm_debug
 					    ("MTCz, change ASID from %#lx to %#lx\n",
-					     ASID_MASK(kvm_read_c0_guest_entryhi(cop0)),
-					     ASID_MASK(vcpu->arch.gprs[rt]));
+					     kvm_read_c0_guest_entryhi(cop0) &
+					     ASID_MASK,
+					     vcpu->arch.gprs[rt] & ASID_MASK);
 
 					/* Blow away the shadow host TLBs */
 					kvm_mips_flush_host_tlb(1);
@@ -570,6 +579,9 @@ kvm_mips_emulate_CP0(uint32_t inst, uint32_t *opc, uint32_t cause,
 				kvm_mips_trans_mtc0(inst, opc, vcpu);
 #endif
 			} else {
+#ifdef CONFIG_KVM_MIPS_VZ
+				/* TODO VZ validate CP0 accesses for CONFIG_KVM_MIPS_VZ */
+#endif
 				cop0->reg[rd][sel] = vcpu->arch.gprs[rt];
 #ifdef CONFIG_KVM_MIPS_DYN_TRANS
 				kvm_mips_trans_mtc0(inst, opc, vcpu);
@@ -659,7 +671,7 @@ kvm_mips_emulate_store(uint32_t inst, uint32_t cause,
 	int32_t op, base, rt, offset;
 	uint32_t bytes;
 	void *data = run->mmio.data;
-	unsigned long curr_pc;
+	u_long curr_pc;
 
 	/*
 	 * Update PC and hold onto current PC in case there is
@@ -871,13 +883,13 @@ kvm_mips_emulate_load(uint32_t inst, uint32_t cause,
 	return er;
 }
 
-int kvm_mips_sync_icache(unsigned long va, struct kvm_vcpu *vcpu)
+int kvm_mips_sync_icache(ulong va, struct kvm_vcpu *vcpu)
 {
-	unsigned long offset = (va & ~PAGE_MASK);
-	struct kvm *kvm = vcpu->kvm;
-	unsigned long pa;
 	gfn_t gfn;
 	pfn_t pfn;
+	ulong pa;
+	ulong offset = (va & ~PAGE_MASK);
+	struct kvm *kvm = vcpu->kvm;
 
 	gfn = va >> PAGE_SHIFT;
 
@@ -913,14 +925,15 @@ enum emulation_result
 kvm_mips_emulate_cache(uint32_t inst, uint32_t *opc, uint32_t cause,
 		       struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	extern void (*r4k_blast_dcache) (void);
 	extern void (*r4k_blast_icache) (void);
+	int debug __maybe_unused = 0;
 	enum emulation_result er = EMULATE_DONE;
 	int32_t offset, cache, op_inst, op, base;
 	struct kvm_vcpu_arch *arch = &vcpu->arch;
-	unsigned long va;
-	unsigned long curr_pc;
+	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	ulong va;
+	u_long curr_pc;
 
 	/*
 	 * Update PC and hold onto current PC in case there is
@@ -966,6 +979,9 @@ kvm_mips_emulate_cache(uint32_t inst, uint32_t *opc, uint32_t cause,
 #endif
 		goto done;
 	}
+#ifdef CONFIG_KVM_MIPS_VZ
+	BUG_ON(cpu_has_vz);
+#endif
 
 	preempt_disable();
 	if (KVM_GUEST_KSEGX(va) == KVM_GUEST_KSEG0) {
@@ -986,7 +1002,8 @@ kvm_mips_emulate_cache(uint32_t inst, uint32_t *opc, uint32_t cause,
 		 * resulting handler will do the right thing
 		 */
 		index = kvm_mips_guest_tlb_lookup(vcpu, (va & VPN2_MASK) |
-						  ASID_MASK(kvm_read_c0_guest_entryhi(cop0)));
+						  (kvm_read_c0_guest_entryhi
+						   (cop0) & ASID_MASK));
 
 		if (index < 0) {
 			vcpu->arch.host_cp0_entryhi = (va & VPN2_MASK);
@@ -1060,7 +1077,7 @@ skip_fault:
 }
 
 enum emulation_result
-kvm_mips_emulate_inst(unsigned long cause, uint32_t *opc,
+kvm_mips_emulate_inst(ulong cause, uint32_t *opc,
 		      struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
 	enum emulation_result er = EMULATE_DONE;
@@ -1110,12 +1127,12 @@ kvm_mips_emulate_inst(unsigned long cause, uint32_t *opc,
 }
 
 enum emulation_result
-kvm_mips_emulate_syscall(unsigned long cause, uint32_t *opc,
+kvm_mips_emulate_syscall(ulong cause, uint32_t *opc,
 			 struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
-	struct kvm_vcpu_arch *arch = &vcpu->arch;
 	enum emulation_result er = EMULATE_DONE;
+	struct kvm_vcpu_arch *arch = &vcpu->arch;
+	struct mips_coproc *cop0 = vcpu->arch.cop0;
 
 	if ((kvm_read_c0_guest_status(cop0) & ST0_EXL) == 0) {
 		/* save old pc */
@@ -1144,14 +1161,16 @@ kvm_mips_emulate_syscall(unsigned long cause, uint32_t *opc,
 }
 
 enum emulation_result
-kvm_mips_emulate_tlbmiss_ld(unsigned long cause, uint32_t *opc,
+kvm_mips_emulate_tlbmiss_ld(ulong cause, uint32_t *opc,
 			    struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
-	struct kvm_vcpu_arch *arch = &vcpu->arch;
 	enum emulation_result er = EMULATE_DONE;
-	unsigned long entryhi = (vcpu->arch.  host_cp0_badvaddr & VPN2_MASK) |
-				ASID_MASK(kvm_read_c0_guest_entryhi(cop0));
+	struct kvm_vcpu_arch *arch = &vcpu->arch;
+	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	ulong entryhi =
+	    (vcpu->arch.
+	     host_cp0_badvaddr & VPN2_MASK) | (kvm_read_c0_guest_entryhi(cop0) &
+					       ASID_MASK);
 
 	if ((kvm_read_c0_guest_status(cop0) & ST0_EXL) == 0) {
 		/* save old pc */
@@ -1190,15 +1209,16 @@ kvm_mips_emulate_tlbmiss_ld(unsigned long cause, uint32_t *opc,
 }
 
 enum emulation_result
-kvm_mips_emulate_tlbinv_ld(unsigned long cause, uint32_t *opc,
+kvm_mips_emulate_tlbinv_ld(ulong cause, uint32_t *opc,
 			   struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
-	struct kvm_vcpu_arch *arch = &vcpu->arch;
 	enum emulation_result er = EMULATE_DONE;
-	unsigned long entryhi =
-		(vcpu->arch.host_cp0_badvaddr & VPN2_MASK) |
-		ASID_MASK(kvm_read_c0_guest_entryhi(cop0));
+	struct kvm_vcpu_arch *arch = &vcpu->arch;
+	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	ulong entryhi =
+	    (vcpu->arch.
+	     host_cp0_badvaddr & VPN2_MASK) | (kvm_read_c0_guest_entryhi(cop0) &
+					       ASID_MASK);
 
 	if ((kvm_read_c0_guest_status(cop0) & ST0_EXL) == 0) {
 		/* save old pc */
@@ -1236,14 +1256,14 @@ kvm_mips_emulate_tlbinv_ld(unsigned long cause, uint32_t *opc,
 }
 
 enum emulation_result
-kvm_mips_emulate_tlbmiss_st(unsigned long cause, uint32_t *opc,
+kvm_mips_emulate_tlbmiss_st(ulong cause, uint32_t *opc,
 			    struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
-	struct kvm_vcpu_arch *arch = &vcpu->arch;
 	enum emulation_result er = EMULATE_DONE;
-	unsigned long entryhi = (vcpu->arch.host_cp0_badvaddr & VPN2_MASK) |
-				ASID_MASK(kvm_read_c0_guest_entryhi(cop0));
+	struct kvm_vcpu_arch *arch = &vcpu->arch;
+	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	ulong entryhi = (vcpu->arch.host_cp0_badvaddr & VPN2_MASK) |
+	    (kvm_read_c0_guest_entryhi(cop0) & ASID_MASK);
 
 	if ((kvm_read_c0_guest_status(cop0) & ST0_EXL) == 0) {
 		/* save old pc */
@@ -1280,14 +1300,18 @@ kvm_mips_emulate_tlbmiss_st(unsigned long cause, uint32_t *opc,
 }
 
 enum emulation_result
-kvm_mips_emulate_tlbinv_st(unsigned long cause, uint32_t *opc,
+kvm_mips_emulate_tlbinv_st(ulong cause, uint32_t *opc,
 			   struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
-	struct kvm_vcpu_arch *arch = &vcpu->arch;
 	enum emulation_result er = EMULATE_DONE;
-	unsigned long entryhi = (vcpu->arch.host_cp0_badvaddr & VPN2_MASK) |
-		ASID_MASK(kvm_read_c0_guest_entryhi(cop0));
+	struct kvm_vcpu_arch *arch = &vcpu->arch;
+	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	ulong entryhi = (vcpu->arch.host_cp0_badvaddr & VPN2_MASK) |
+	    (kvm_read_c0_guest_entryhi(cop0) & ASID_MASK);
+
+#ifdef CONFIG_KVM_MIPS_VZ
+	BUG_ON(cpu_has_vz);
+#endif
 
 	if ((kvm_read_c0_guest_status(cop0) & ST0_EXL) == 0) {
 		/* save old pc */
@@ -1325,10 +1349,18 @@ kvm_mips_emulate_tlbinv_st(unsigned long cause, uint32_t *opc,
 
 /* TLBMOD: store into address matching TLB with Dirty bit off */
 enum emulation_result
-kvm_mips_handle_tlbmod(unsigned long cause, uint32_t *opc,
+kvm_mips_handle_tlbmod(ulong cause, uint32_t *opc,
 		       struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
 	enum emulation_result er = EMULATE_DONE;
+	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	int index __maybe_unused;
+	ulong entryhi __maybe_unused = (vcpu->arch.host_cp0_badvaddr & VPN2_MASK) |
+					(kvm_read_c0_guest_entryhi(cop0) & ASID_MASK);
+
+#ifdef CONFIG_KVM_MIPS_VZ
+	BUG_ON(cpu_has_vz);
+#endif
 
 #ifdef DEBUG
 	/*
@@ -1351,14 +1383,14 @@ kvm_mips_handle_tlbmod(unsigned long cause, uint32_t *opc,
 }
 
 enum emulation_result
-kvm_mips_emulate_tlbmod(unsigned long cause, uint32_t *opc,
+kvm_mips_emulate_tlbmod(ulong cause, uint32_t *opc,
 			struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
-	unsigned long entryhi = (vcpu->arch.host_cp0_badvaddr & VPN2_MASK) |
-				ASID_MASK(kvm_read_c0_guest_entryhi(cop0));
-	struct kvm_vcpu_arch *arch = &vcpu->arch;
 	enum emulation_result er = EMULATE_DONE;
+	struct kvm_vcpu_arch *arch = &vcpu->arch;
+	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	ulong entryhi = (vcpu->arch.host_cp0_badvaddr & VPN2_MASK) |
+	    (kvm_read_c0_guest_entryhi(cop0) & ASID_MASK);
 
 	if ((kvm_read_c0_guest_status(cop0) & ST0_EXL) == 0) {
 		/* save old pc */
@@ -1393,12 +1425,12 @@ kvm_mips_emulate_tlbmod(unsigned long cause, uint32_t *opc,
 }
 
 enum emulation_result
-kvm_mips_emulate_fpu_exc(unsigned long cause, uint32_t *opc,
+kvm_mips_emulate_fpu_exc(ulong cause, uint32_t *opc,
 			 struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
-	struct kvm_vcpu_arch *arch = &vcpu->arch;
 	enum emulation_result er = EMULATE_DONE;
+	struct kvm_vcpu_arch *arch = &vcpu->arch;
+	struct mips_coproc *cop0 = vcpu->arch.cop0;
 
 	if ((kvm_read_c0_guest_status(cop0) & ST0_EXL) == 0) {
 		/* save old pc */
@@ -1422,12 +1454,12 @@ kvm_mips_emulate_fpu_exc(unsigned long cause, uint32_t *opc,
 }
 
 enum emulation_result
-kvm_mips_emulate_ri_exc(unsigned long cause, uint32_t *opc,
+kvm_mips_emulate_ri_exc(ulong cause, uint32_t *opc,
 			struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
-	struct kvm_vcpu_arch *arch = &vcpu->arch;
 	enum emulation_result er = EMULATE_DONE;
+	struct kvm_vcpu_arch *arch = &vcpu->arch;
+	struct mips_coproc *cop0 = vcpu->arch.cop0;
 
 	if ((kvm_read_c0_guest_status(cop0) & ST0_EXL) == 0) {
 		/* save old pc */
@@ -1456,12 +1488,12 @@ kvm_mips_emulate_ri_exc(unsigned long cause, uint32_t *opc,
 }
 
 enum emulation_result
-kvm_mips_emulate_bp_exc(unsigned long cause, uint32_t *opc,
+kvm_mips_emulate_bp_exc(ulong cause, uint32_t *opc,
 			struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
-	struct kvm_vcpu_arch *arch = &vcpu->arch;
 	enum emulation_result er = EMULATE_DONE;
+	struct kvm_vcpu_arch *arch = &vcpu->arch;
+	struct mips_coproc *cop0 = vcpu->arch.cop0;
 
 	if ((kvm_read_c0_guest_status(cop0) & ST0_EXL) == 0) {
 		/* save old pc */
@@ -1507,14 +1539,14 @@ kvm_mips_emulate_bp_exc(unsigned long cause, uint32_t *opc,
 #define RDHWR  0x0000003b
 
 enum emulation_result
-kvm_mips_handle_ri(unsigned long cause, uint32_t *opc,
+kvm_mips_handle_ri(ulong cause, uint32_t *opc,
 		   struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
-	struct kvm_vcpu_arch *arch = &vcpu->arch;
 	enum emulation_result er = EMULATE_DONE;
-	unsigned long curr_pc;
+	struct kvm_vcpu_arch *arch = &vcpu->arch;
+	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	uint32_t inst;
+	u_long curr_pc;
 
 	/*
 	 * Update PC and hold onto current PC in case there is
@@ -1564,12 +1596,7 @@ kvm_mips_handle_ri(unsigned long cause, uint32_t *opc,
 			}
 			break;
 		case 29:
-#if 1
 			arch->gprs[rt] = kvm_read_c0_guest_userlocal(cop0);
-#else
-			/* UserLocal not implemented */
-			er = kvm_mips_emulate_ri_exc(cause, opc, run, vcpu);
-#endif
 			break;
 
 		default:
@@ -1594,9 +1621,9 @@ kvm_mips_handle_ri(unsigned long cause, uint32_t *opc,
 enum emulation_result
 kvm_mips_complete_mmio_load(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
-	unsigned long *gpr = &vcpu->arch.gprs[vcpu->arch.io_gpr];
 	enum emulation_result er = EMULATE_DONE;
-	unsigned long curr_pc;
+	ulong *gpr = &vcpu->arch.gprs[vcpu->arch.io_gpr];
+	u_long curr_pc;
 
 	if (run->mmio.len > sizeof(*gpr)) {
 		printk("Bad MMIO length: %d", run->mmio.len);
@@ -1644,13 +1671,17 @@ done:
 }
 
 static enum emulation_result
-kvm_mips_emulate_exc(unsigned long cause, uint32_t *opc,
+kvm_mips_emulate_exc(ulong cause, uint32_t *opc,
 		     struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
-	uint32_t exccode = (cause >> CAUSEB_EXCCODE) & 0x1f;
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
-	struct kvm_vcpu_arch *arch = &vcpu->arch;
 	enum emulation_result er = EMULATE_DONE;
+	struct kvm_vcpu_arch *arch = &vcpu->arch;
+	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	uint32_t exccode = (cause >> CAUSEB_EXCCODE) & 0x1f;
+
+#ifdef CONFIG_KVM_MIPS_VZ
+	BUG_ON(cpu_has_vz);
+#endif
 
 	if ((kvm_read_c0_guest_status(cop0) & ST0_EXL) == 0) {
 		/* save old pc */
@@ -1681,12 +1712,12 @@ kvm_mips_emulate_exc(unsigned long cause, uint32_t *opc,
 }
 
 enum emulation_result
-kvm_mips_check_privilege(unsigned long cause, uint32_t *opc,
+kvm_mips_check_privilege(ulong cause, uint32_t *opc,
 			 struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
 	enum emulation_result er = EMULATE_DONE;
 	uint32_t exccode = (cause >> CAUSEB_EXCCODE) & 0x1f;
-	unsigned long badvaddr = vcpu->arch.host_cp0_badvaddr;
+	ulong badvaddr = vcpu->arch.host_cp0_badvaddr;
 
 	int usermode = !KVM_GUEST_KERNEL_MODE(vcpu);
 
@@ -1708,7 +1739,7 @@ kvm_mips_check_privilege(unsigned long cause, uint32_t *opc,
 
 		case T_TLB_LD_MISS:
 			/* We we are accessing Guest kernel space, then send an address error exception to the guest */
-			if (badvaddr >= (unsigned long) KVM_GUEST_KSEG0) {
+			if (badvaddr >= (ulong) KVM_GUEST_KSEG0) {
 				printk("%s: LD MISS @ %#lx\n", __func__,
 				       badvaddr);
 				cause &= ~0xff;
@@ -1719,7 +1750,7 @@ kvm_mips_check_privilege(unsigned long cause, uint32_t *opc,
 
 		case T_TLB_ST_MISS:
 			/* We we are accessing Guest kernel space, then send an address error exception to the guest */
-			if (badvaddr >= (unsigned long) KVM_GUEST_KSEG0) {
+			if (badvaddr >= (ulong) KVM_GUEST_KSEG0) {
 				printk("%s: ST MISS @ %#lx\n", __func__,
 				       badvaddr);
 				cause &= ~0xff;
@@ -1765,17 +1796,20 @@ kvm_mips_check_privilege(unsigned long cause, uint32_t *opc,
  *     case we inject the TLB from the Guest TLB into the shadow host TLB
  */
 enum emulation_result
-kvm_mips_handle_tlbmiss(unsigned long cause, uint32_t *opc,
+kvm_mips_handle_tlbmiss(ulong cause, uint32_t *opc,
 			struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
 	enum emulation_result er = EMULATE_DONE;
 	uint32_t exccode = (cause >> CAUSEB_EXCCODE) & 0x1f;
-	unsigned long va = vcpu->arch.host_cp0_badvaddr;
+	ulong va = vcpu->arch.host_cp0_badvaddr;
 	int index;
 
 	kvm_debug("kvm_mips_handle_tlbmiss: badvaddr: %#lx, entryhi: %#lx\n",
 		  vcpu->arch.host_cp0_badvaddr, vcpu->arch.host_cp0_entryhi);
 
+#ifdef CONFIG_KVM_MIPS_VZ
+	BUG_ON(cpu_has_vz);
+#endif
 	/* KVM would not have got the exception if this entry was valid in the shadow host TLB
 	 * Check the Guest TLB, if the entry is not there then send the guest an
 	 * exception. The guest exc handler should then inject an entry into the
@@ -1783,8 +1817,8 @@ kvm_mips_handle_tlbmiss(unsigned long cause, uint32_t *opc,
 	 */
 	index = kvm_mips_guest_tlb_lookup(vcpu,
 					  (va & VPN2_MASK) |
-					  ASID_MASK(kvm_read_c0_guest_entryhi
-					   (vcpu->arch.cop0)));
+					  (kvm_read_c0_guest_entryhi
+					   (vcpu->arch.cop0) & ASID_MASK));
 	if (index < 0) {
 		if (exccode == T_TLB_LD_MISS) {
 			er = kvm_mips_emulate_tlbmiss_ld(cause, opc, run, vcpu);
-- 
1.7.11.3
