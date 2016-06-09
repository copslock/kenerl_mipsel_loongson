Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 15:21:21 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:45188 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27041084AbcFINTnT-qDi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jun 2016 15:19:43 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id E400F76FF0FCC;
        Thu,  9 Jun 2016 14:19:32 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 9 Jun 2016 14:19:35 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 05/18] MIPS: KVM: Convert code to kernel sized types
Date:   Thu, 9 Jun 2016 14:19:08 +0100
Message-ID: <1465478361-7431-6-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1465478361-7431-1-git-send-email-james.hogan@imgtec.com>
References: <1465478361-7431-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53919
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

Convert the MIPS KVM C code to use standard kernel sized types (e.g.
u32) instead of inttypes.h style ones (e.g. uint32_t) or other types as
appropriate.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/dyntrans.c  |  24 +++++------
 arch/mips/kvm/emulate.c   | 104 +++++++++++++++++++++++-----------------------
 arch/mips/kvm/interrupt.c |   2 +-
 arch/mips/kvm/mips.c      |   8 ++--
 arch/mips/kvm/tlb.c       |  28 ++++++-------
 arch/mips/kvm/trap_emul.c |  30 ++++++-------
 6 files changed, 98 insertions(+), 98 deletions(-)

diff --git a/arch/mips/kvm/dyntrans.c b/arch/mips/kvm/dyntrans.c
index e79502a88534..d4a86fb239cd 100644
--- a/arch/mips/kvm/dyntrans.c
+++ b/arch/mips/kvm/dyntrans.c
@@ -33,13 +33,13 @@ int kvm_mips_trans_cache_index(u32 inst, u32 *opc,
 {
 	int result = 0;
 	unsigned long kseg0_opc;
-	uint32_t synci_inst = 0x0;
+	u32 synci_inst = 0x0;
 
 	/* Replace the CACHE instruction, with a NOP */
 	kseg0_opc =
 	    CKSEG0ADDR(kvm_mips_translate_guest_kseg0_to_hpa
 		       (vcpu, (unsigned long) opc));
-	memcpy((void *)kseg0_opc, (void *)&synci_inst, sizeof(uint32_t));
+	memcpy((void *)kseg0_opc, (void *)&synci_inst, sizeof(u32));
 	local_flush_icache_range(kseg0_opc, kseg0_opc + 32);
 
 	return result;
@@ -54,7 +54,7 @@ int kvm_mips_trans_cache_va(u32 inst, u32 *opc,
 {
 	int result = 0;
 	unsigned long kseg0_opc;
-	uint32_t synci_inst = SYNCI_TEMPLATE, base, offset;
+	u32 synci_inst = SYNCI_TEMPLATE, base, offset;
 
 	base = (inst >> 21) & 0x1f;
 	offset = inst & 0xffff;
@@ -64,7 +64,7 @@ int kvm_mips_trans_cache_va(u32 inst, u32 *opc,
 	kseg0_opc =
 	    CKSEG0ADDR(kvm_mips_translate_guest_kseg0_to_hpa
 		       (vcpu, (unsigned long) opc));
-	memcpy((void *)kseg0_opc, (void *)&synci_inst, sizeof(uint32_t));
+	memcpy((void *)kseg0_opc, (void *)&synci_inst, sizeof(u32));
 	local_flush_icache_range(kseg0_opc, kseg0_opc + 32);
 
 	return result;
@@ -72,8 +72,8 @@ int kvm_mips_trans_cache_va(u32 inst, u32 *opc,
 
 int kvm_mips_trans_mfc0(u32 inst, u32 *opc, struct kvm_vcpu *vcpu)
 {
-	int32_t rt, rd, sel;
-	uint32_t mfc0_inst;
+	u32 rt, rd, sel;
+	u32 mfc0_inst;
 	unsigned long kseg0_opc, flags;
 
 	rt = (inst >> 16) & 0x1f;
@@ -94,11 +94,11 @@ int kvm_mips_trans_mfc0(u32 inst, u32 *opc, struct kvm_vcpu *vcpu)
 		kseg0_opc =
 		    CKSEG0ADDR(kvm_mips_translate_guest_kseg0_to_hpa
 			       (vcpu, (unsigned long) opc));
-		memcpy((void *)kseg0_opc, (void *)&mfc0_inst, sizeof(uint32_t));
+		memcpy((void *)kseg0_opc, (void *)&mfc0_inst, sizeof(u32));
 		local_flush_icache_range(kseg0_opc, kseg0_opc + 32);
 	} else if (KVM_GUEST_KSEGX((unsigned long) opc) == KVM_GUEST_KSEG23) {
 		local_irq_save(flags);
-		memcpy((void *)opc, (void *)&mfc0_inst, sizeof(uint32_t));
+		memcpy((void *)opc, (void *)&mfc0_inst, sizeof(u32));
 		local_flush_icache_range((unsigned long)opc,
 					 (unsigned long)opc + 32);
 		local_irq_restore(flags);
@@ -112,8 +112,8 @@ int kvm_mips_trans_mfc0(u32 inst, u32 *opc, struct kvm_vcpu *vcpu)
 
 int kvm_mips_trans_mtc0(u32 inst, u32 *opc, struct kvm_vcpu *vcpu)
 {
-	int32_t rt, rd, sel;
-	uint32_t mtc0_inst = SW_TEMPLATE;
+	u32 rt, rd, sel;
+	u32 mtc0_inst = SW_TEMPLATE;
 	unsigned long kseg0_opc, flags;
 
 	rt = (inst >> 16) & 0x1f;
@@ -127,11 +127,11 @@ int kvm_mips_trans_mtc0(u32 inst, u32 *opc, struct kvm_vcpu *vcpu)
 		kseg0_opc =
 		    CKSEG0ADDR(kvm_mips_translate_guest_kseg0_to_hpa
 			       (vcpu, (unsigned long) opc));
-		memcpy((void *)kseg0_opc, (void *)&mtc0_inst, sizeof(uint32_t));
+		memcpy((void *)kseg0_opc, (void *)&mtc0_inst, sizeof(u32));
 		local_flush_icache_range(kseg0_opc, kseg0_opc + 32);
 	} else if (KVM_GUEST_KSEGX((unsigned long) opc) == KVM_GUEST_KSEG23) {
 		local_irq_save(flags);
-		memcpy((void *)opc, (void *)&mtc0_inst, sizeof(uint32_t));
+		memcpy((void *)opc, (void *)&mtc0_inst, sizeof(u32));
 		local_flush_icache_range((unsigned long)opc,
 					 (unsigned long)opc + 32);
 		local_irq_restore(flags);
diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index c59c51908476..8f4f3242a655 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -52,7 +52,7 @@ unsigned long kvm_compute_return_epc(struct kvm_vcpu *vcpu,
 		goto unaligned;
 
 	/* Read the instruction */
-	insn.word = kvm_get_inst((uint32_t *) epc, vcpu);
+	insn.word = kvm_get_inst((u32 *) epc, vcpu);
 
 	if (insn.word == KVM_INVALID_INST)
 		return KVM_INVALID_INST;
@@ -304,7 +304,7 @@ static u32 kvm_mips_read_count_running(struct kvm_vcpu *vcpu, ktime_t now)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	ktime_t expires, threshold;
-	uint32_t count, compare;
+	u32 count, compare;
 	int running;
 
 	/* Calculate the biased and scaled guest CP0_Count */
@@ -315,7 +315,7 @@ static u32 kvm_mips_read_count_running(struct kvm_vcpu *vcpu, ktime_t now)
 	 * Find whether CP0_Count has reached the closest timer interrupt. If
 	 * not, we shouldn't inject it.
 	 */
-	if ((int32_t)(count - compare) < 0)
+	if ((s32)(count - compare) < 0)
 		return count;
 
 	/*
@@ -421,13 +421,13 @@ static void kvm_mips_resume_hrtimer(struct kvm_vcpu *vcpu,
 				    ktime_t now, u32 count)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
-	uint32_t compare;
+	u32 compare;
 	u64 delta;
 	ktime_t expire;
 
 	/* Calculate timeout (wrap 0 to 2^32) */
 	compare = kvm_read_c0_guest_compare(cop0);
-	delta = (u64)(uint32_t)(compare - count - 1) + 1;
+	delta = (u64)(u32)(compare - count - 1) + 1;
 	delta = div_u64(delta * NSEC_PER_SEC, vcpu->arch.count_hz);
 	expire = ktime_add_ns(now, delta);
 
@@ -543,7 +543,7 @@ void kvm_mips_write_compare(struct kvm_vcpu *vcpu, u32 compare, bool ack)
 	int dc;
 	u32 old_compare = kvm_read_c0_guest_compare(cop0);
 	ktime_t now;
-	uint32_t count;
+	u32 count;
 
 	/* if unchanged, must just be an ack */
 	if (old_compare == compare) {
@@ -584,7 +584,7 @@ void kvm_mips_write_compare(struct kvm_vcpu *vcpu, u32 compare, bool ack)
 static ktime_t kvm_mips_count_disable(struct kvm_vcpu *vcpu)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
-	uint32_t count;
+	u32 count;
 	ktime_t now;
 
 	/* Stop hrtimer */
@@ -631,7 +631,7 @@ void kvm_mips_count_disable_cause(struct kvm_vcpu *vcpu)
 void kvm_mips_count_enable_cause(struct kvm_vcpu *vcpu)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
-	uint32_t count;
+	u32 count;
 
 	kvm_clear_c0_guest_cause(cop0, CAUSEF_DC);
 
@@ -660,7 +660,7 @@ int kvm_mips_set_count_ctl(struct kvm_vcpu *vcpu, s64 count_ctl)
 	s64 changed = count_ctl ^ vcpu->arch.count_ctl;
 	s64 delta;
 	ktime_t expire, now;
-	uint32_t count, compare;
+	u32 count, compare;
 
 	/* Only allow defined bits to be changed */
 	if (changed & ~(s64)(KVM_REG_MIPS_COUNT_CTL_DC))
@@ -686,7 +686,7 @@ int kvm_mips_set_count_ctl(struct kvm_vcpu *vcpu, s64 count_ctl)
 			 */
 			count = kvm_read_c0_guest_count(cop0);
 			compare = kvm_read_c0_guest_compare(cop0);
-			delta = (u64)(uint32_t)(compare - count - 1) + 1;
+			delta = (u64)(u32)(compare - count - 1) + 1;
 			delta = div_u64(delta * NSEC_PER_SEC,
 					vcpu->arch.count_hz);
 			expire = ktime_add_ns(vcpu->arch.count_resume, delta);
@@ -800,9 +800,9 @@ enum emulation_result kvm_mips_emul_wait(struct kvm_vcpu *vcpu)
 enum emulation_result kvm_mips_emul_tlbr(struct kvm_vcpu *vcpu)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
-	uint32_t pc = vcpu->arch.pc;
+	unsigned long pc = vcpu->arch.pc;
 
-	kvm_err("[%#x] COP0_TLBR [%ld]\n", pc, kvm_read_c0_guest_index(cop0));
+	kvm_err("[%#lx] COP0_TLBR [%ld]\n", pc, kvm_read_c0_guest_index(cop0));
 	return EMULATE_FAIL;
 }
 
@@ -812,11 +812,11 @@ enum emulation_result kvm_mips_emul_tlbwi(struct kvm_vcpu *vcpu)
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	int index = kvm_read_c0_guest_index(cop0);
 	struct kvm_mips_tlb *tlb = NULL;
-	uint32_t pc = vcpu->arch.pc;
+	unsigned long pc = vcpu->arch.pc;
 
 	if (index < 0 || index >= KVM_MIPS_GUEST_TLB_SIZE) {
 		kvm_debug("%s: illegal index: %d\n", __func__, index);
-		kvm_debug("[%#x] COP0_TLBWI [%d] (entryhi: %#lx, entrylo0: %#lx entrylo1: %#lx, mask: %#lx)\n",
+		kvm_debug("[%#lx] COP0_TLBWI [%d] (entryhi: %#lx, entrylo0: %#lx entrylo1: %#lx, mask: %#lx)\n",
 			  pc, index, kvm_read_c0_guest_entryhi(cop0),
 			  kvm_read_c0_guest_entrylo0(cop0),
 			  kvm_read_c0_guest_entrylo1(cop0),
@@ -836,7 +836,7 @@ enum emulation_result kvm_mips_emul_tlbwi(struct kvm_vcpu *vcpu)
 	tlb->tlb_lo0 = kvm_read_c0_guest_entrylo0(cop0);
 	tlb->tlb_lo1 = kvm_read_c0_guest_entrylo1(cop0);
 
-	kvm_debug("[%#x] COP0_TLBWI [%d] (entryhi: %#lx, entrylo0: %#lx entrylo1: %#lx, mask: %#lx)\n",
+	kvm_debug("[%#lx] COP0_TLBWI [%d] (entryhi: %#lx, entrylo0: %#lx entrylo1: %#lx, mask: %#lx)\n",
 		  pc, index, kvm_read_c0_guest_entryhi(cop0),
 		  kvm_read_c0_guest_entrylo0(cop0),
 		  kvm_read_c0_guest_entrylo1(cop0),
@@ -850,7 +850,7 @@ enum emulation_result kvm_mips_emul_tlbwr(struct kvm_vcpu *vcpu)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	struct kvm_mips_tlb *tlb = NULL;
-	uint32_t pc = vcpu->arch.pc;
+	unsigned long pc = vcpu->arch.pc;
 	int index;
 
 	get_random_bytes(&index, sizeof(index));
@@ -869,7 +869,7 @@ enum emulation_result kvm_mips_emul_tlbwr(struct kvm_vcpu *vcpu)
 	tlb->tlb_lo0 = kvm_read_c0_guest_entrylo0(cop0);
 	tlb->tlb_lo1 = kvm_read_c0_guest_entrylo1(cop0);
 
-	kvm_debug("[%#x] COP0_TLBWR[%d] (entryhi: %#lx, entrylo0: %#lx entrylo1: %#lx)\n",
+	kvm_debug("[%#lx] COP0_TLBWR[%d] (entryhi: %#lx, entrylo0: %#lx entrylo1: %#lx)\n",
 		  pc, index, kvm_read_c0_guest_entryhi(cop0),
 		  kvm_read_c0_guest_entrylo0(cop0),
 		  kvm_read_c0_guest_entrylo1(cop0));
@@ -881,14 +881,14 @@ enum emulation_result kvm_mips_emul_tlbp(struct kvm_vcpu *vcpu)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	long entryhi = kvm_read_c0_guest_entryhi(cop0);
-	uint32_t pc = vcpu->arch.pc;
+	unsigned long pc = vcpu->arch.pc;
 	int index = -1;
 
 	index = kvm_mips_guest_tlb_lookup(vcpu, entryhi);
 
 	kvm_write_c0_guest_index(cop0, index);
 
-	kvm_debug("[%#x] COP0_TLBP (entryhi: %#lx), index: %d\n", pc, entryhi,
+	kvm_debug("[%#lx] COP0_TLBP (entryhi: %#lx), index: %d\n", pc, entryhi,
 		  index);
 
 	return EMULATE_DONE;
@@ -978,8 +978,8 @@ enum emulation_result kvm_mips_emulate_CP0(u32 inst, u32 *opc, u32 cause,
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	enum emulation_result er = EMULATE_DONE;
-	int32_t rt, rd, copz, sel, co_bit, op;
-	uint32_t pc = vcpu->arch.pc;
+	u32 rt, rd, copz, sel, co_bit, op;
+	unsigned long pc = vcpu->arch.pc;
 	unsigned long curr_pc;
 
 	/*
@@ -1047,7 +1047,7 @@ enum emulation_result kvm_mips_emulate_CP0(u32 inst, u32 *opc, u32 cause,
 			}
 
 			kvm_debug
-			    ("[%#x] MFCz[%d][%d], vcpu->arch.gprs[%d]: %#lx\n",
+			    ("[%#lx] MFCz[%d][%d], vcpu->arch.gprs[%d]: %#lx\n",
 			     pc, rd, sel, rt, vcpu->arch.gprs[rt]);
 
 			break;
@@ -1077,7 +1077,7 @@ enum emulation_result kvm_mips_emulate_CP0(u32 inst, u32 *opc, u32 cause,
 				kvm_err("MTCz, cop0->reg[EBASE]: %#lx\n",
 					kvm_read_c0_guest_ebase(cop0));
 			} else if (rd == MIPS_CP0_TLB_HI && sel == 0) {
-				uint32_t nasid =
+				u32 nasid =
 					vcpu->arch.gprs[rt] & KVM_ENTRYHI_ASID;
 				if ((KSEGX(vcpu->arch.gprs[rt]) != CKSEG0) &&
 				    ((kvm_read_c0_guest_entryhi(cop0) &
@@ -1099,7 +1099,7 @@ enum emulation_result kvm_mips_emulate_CP0(u32 inst, u32 *opc, u32 cause,
 				kvm_mips_write_count(vcpu, vcpu->arch.gprs[rt]);
 				goto done;
 			} else if ((rd == MIPS_CP0_COMPARE) && (sel == 0)) {
-				kvm_debug("[%#x] MTCz, COMPARE %#lx <- %#lx\n",
+				kvm_debug("[%#lx] MTCz, COMPARE %#lx <- %#lx\n",
 					  pc, kvm_read_c0_guest_compare(cop0),
 					  vcpu->arch.gprs[rt]);
 
@@ -1218,7 +1218,7 @@ enum emulation_result kvm_mips_emulate_CP0(u32 inst, u32 *opc, u32 cause,
 
 				kvm_write_c0_guest_config5(cop0, val);
 			} else if ((rd == MIPS_CP0_CAUSE) && (sel == 0)) {
-				uint32_t old_cause, new_cause;
+				u32 old_cause, new_cause;
 
 				old_cause = kvm_read_c0_guest_cause(cop0);
 				new_cause = vcpu->arch.gprs[rt];
@@ -1239,7 +1239,7 @@ enum emulation_result kvm_mips_emulate_CP0(u32 inst, u32 *opc, u32 cause,
 #endif
 			}
 
-			kvm_debug("[%#x] MTCz, cop0->reg[%d][%d]: %#lx\n", pc,
+			kvm_debug("[%#lx] MTCz, cop0->reg[%d][%d]: %#lx\n", pc,
 				  rd, sel, cop0->reg[rd][sel]);
 			break;
 
@@ -1271,9 +1271,8 @@ enum emulation_result kvm_mips_emulate_CP0(u32 inst, u32 *opc, u32 cause,
 
 		case wrpgpr_op:
 			{
-				uint32_t css =
-				    cop0->reg[MIPS_CP0_STATUS][2] & 0xf;
-				uint32_t pss =
+				u32 css = cop0->reg[MIPS_CP0_STATUS][2] & 0xf;
+				u32 pss =
 				    (cop0->reg[MIPS_CP0_STATUS][2] >> 6) & 0xf;
 				/*
 				 * We don't support any shadow register sets, so
@@ -1316,8 +1315,9 @@ enum emulation_result kvm_mips_emulate_store(u32 inst, u32 cause,
 					     struct kvm_vcpu *vcpu)
 {
 	enum emulation_result er = EMULATE_DO_MMIO;
-	int32_t op, base, rt, offset;
-	uint32_t bytes;
+	u32 op, base, rt;
+	s16 offset;
+	u32 bytes;
 	void *data = run->mmio.data;
 	unsigned long curr_pc;
 
@@ -1332,7 +1332,7 @@ enum emulation_result kvm_mips_emulate_store(u32 inst, u32 cause,
 
 	rt = (inst >> 16) & 0x1f;
 	base = (inst >> 21) & 0x1f;
-	offset = inst & 0xffff;
+	offset = (s16)inst;
 	op = (inst >> 26) & 0x3f;
 
 	switch (op) {
@@ -1356,7 +1356,7 @@ enum emulation_result kvm_mips_emulate_store(u32 inst, u32 cause,
 		*(u8 *) data = vcpu->arch.gprs[rt];
 		kvm_debug("OP_SB: eaddr: %#lx, gpr: %#lx, data: %#x\n",
 			  vcpu->arch.host_cp0_badvaddr, vcpu->arch.gprs[rt],
-			  *(uint8_t *) data);
+			  *(u8 *) data);
 
 		break;
 
@@ -1378,11 +1378,11 @@ enum emulation_result kvm_mips_emulate_store(u32 inst, u32 cause,
 		run->mmio.is_write = 1;
 		vcpu->mmio_needed = 1;
 		vcpu->mmio_is_write = 1;
-		*(uint32_t *) data = vcpu->arch.gprs[rt];
+		*(u32 *) data = vcpu->arch.gprs[rt];
 
 		kvm_debug("[%#lx] OP_SW: eaddr: %#lx, gpr: %#lx, data: %#x\n",
 			  vcpu->arch.pc, vcpu->arch.host_cp0_badvaddr,
-			  vcpu->arch.gprs[rt], *(uint32_t *) data);
+			  vcpu->arch.gprs[rt], *(u32 *) data);
 		break;
 
 	case sh_op:
@@ -1403,11 +1403,11 @@ enum emulation_result kvm_mips_emulate_store(u32 inst, u32 cause,
 		run->mmio.is_write = 1;
 		vcpu->mmio_needed = 1;
 		vcpu->mmio_is_write = 1;
-		*(uint16_t *) data = vcpu->arch.gprs[rt];
+		*(u16 *) data = vcpu->arch.gprs[rt];
 
 		kvm_debug("[%#lx] OP_SH: eaddr: %#lx, gpr: %#lx, data: %#x\n",
 			  vcpu->arch.pc, vcpu->arch.host_cp0_badvaddr,
-			  vcpu->arch.gprs[rt], *(uint32_t *) data);
+			  vcpu->arch.gprs[rt], *(u32 *) data);
 		break;
 
 	default:
@@ -1428,12 +1428,13 @@ enum emulation_result kvm_mips_emulate_load(u32 inst, u32 cause,
 					    struct kvm_vcpu *vcpu)
 {
 	enum emulation_result er = EMULATE_DO_MMIO;
-	int32_t op, base, rt, offset;
-	uint32_t bytes;
+	u32 op, base, rt;
+	s16 offset;
+	u32 bytes;
 
 	rt = (inst >> 16) & 0x1f;
 	base = (inst >> 21) & 0x1f;
-	offset = inst & 0xffff;
+	offset = (s16)inst;
 	op = (inst >> 26) & 0x3f;
 
 	vcpu->arch.pending_load_cause = cause;
@@ -1535,7 +1536,8 @@ enum emulation_result kvm_mips_emulate_cache(u32 inst, u32 *opc,
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	enum emulation_result er = EMULATE_DONE;
-	int32_t offset, cache, op_inst, op, base;
+	u32 cache, op_inst, op, base;
+	s16 offset;
 	struct kvm_vcpu_arch *arch = &vcpu->arch;
 	unsigned long va;
 	unsigned long curr_pc;
@@ -1551,7 +1553,7 @@ enum emulation_result kvm_mips_emulate_cache(u32 inst, u32 *opc,
 
 	base = (inst >> 21) & 0x1f;
 	op_inst = (inst >> 16) & 0x1f;
-	offset = (int16_t)inst;
+	offset = (s16)inst;
 	cache = op_inst & CacheOp_Cache;
 	op = op_inst & CacheOp_Op;
 
@@ -1691,7 +1693,7 @@ enum emulation_result kvm_mips_emulate_inst(unsigned long cause, u32 *opc,
 					    struct kvm_vcpu *vcpu)
 {
 	enum emulation_result er = EMULATE_DONE;
-	uint32_t inst;
+	u32 inst;
 
 	/* Fetch the instruction. */
 	if (cause & CAUSEF_BD)
@@ -2282,7 +2284,7 @@ enum emulation_result kvm_mips_handle_ri(unsigned long cause, u32 *opc,
 	struct kvm_vcpu_arch *arch = &vcpu->arch;
 	enum emulation_result er = EMULATE_DONE;
 	unsigned long curr_pc;
-	uint32_t inst;
+	u32 inst;
 
 	/*
 	 * Update PC and hold onto current PC in case there is
@@ -2377,19 +2379,19 @@ enum emulation_result kvm_mips_complete_mmio_load(struct kvm_vcpu *vcpu,
 
 	switch (run->mmio.len) {
 	case 4:
-		*gpr = *(int32_t *) run->mmio.data;
+		*gpr = *(s32 *) run->mmio.data;
 		break;
 
 	case 2:
 		if (vcpu->mmio_needed == 2)
-			*gpr = *(int16_t *) run->mmio.data;
+			*gpr = *(s16 *) run->mmio.data;
 		else
-			*gpr = *(uint16_t *)run->mmio.data;
+			*gpr = *(u16 *)run->mmio.data;
 
 		break;
 	case 1:
 		if (vcpu->mmio_needed == 2)
-			*gpr = *(int8_t *) run->mmio.data;
+			*gpr = *(s8 *) run->mmio.data;
 		else
 			*gpr = *(u8 *) run->mmio.data;
 		break;
@@ -2409,7 +2411,7 @@ static enum emulation_result kvm_mips_emulate_exc(unsigned long cause,
 						  struct kvm_run *run,
 						  struct kvm_vcpu *vcpu)
 {
-	uint32_t exccode = (cause >> CAUSEB_EXCCODE) & 0x1f;
+	u32 exccode = (cause >> CAUSEB_EXCCODE) & 0x1f;
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	struct kvm_vcpu_arch *arch = &vcpu->arch;
 	enum emulation_result er = EMULATE_DONE;
@@ -2448,7 +2450,7 @@ enum emulation_result kvm_mips_check_privilege(unsigned long cause,
 					       struct kvm_vcpu *vcpu)
 {
 	enum emulation_result er = EMULATE_DONE;
-	uint32_t exccode = (cause >> CAUSEB_EXCCODE) & 0x1f;
+	u32 exccode = (cause >> CAUSEB_EXCCODE) & 0x1f;
 	unsigned long badvaddr = vcpu->arch.host_cp0_badvaddr;
 
 	int usermode = !KVM_GUEST_KERNEL_MODE(vcpu);
@@ -2544,7 +2546,7 @@ enum emulation_result kvm_mips_handle_tlbmiss(unsigned long cause,
 					      struct kvm_vcpu *vcpu)
 {
 	enum emulation_result er = EMULATE_DONE;
-	uint32_t exccode = (cause >> CAUSEB_EXCCODE) & 0x1f;
+	u32 exccode = (cause >> CAUSEB_EXCCODE) & 0x1f;
 	unsigned long va = vcpu->arch.host_cp0_badvaddr;
 	int index;
 
diff --git a/arch/mips/kvm/interrupt.c b/arch/mips/kvm/interrupt.c
index 49ce83237fc3..ad28dac6b7e9 100644
--- a/arch/mips/kvm/interrupt.c
+++ b/arch/mips/kvm/interrupt.c
@@ -117,7 +117,7 @@ int kvm_mips_irq_deliver_cb(struct kvm_vcpu *vcpu, unsigned int priority,
 			    u32 cause)
 {
 	int allowed = 0;
-	uint32_t exccode;
+	u32 exccode;
 
 	struct kvm_vcpu_arch *arch = &vcpu->arch;
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 44da5259f390..a2b1b9205b94 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -1222,7 +1222,7 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 
 static void kvm_mips_set_c0_status(void)
 {
-	uint32_t status = read_c0_status();
+	u32 status = read_c0_status();
 
 	if (cpu_has_dsp)
 		status |= (ST0_MX);
@@ -1236,9 +1236,9 @@ static void kvm_mips_set_c0_status(void)
  */
 int kvm_mips_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
-	uint32_t cause = vcpu->arch.host_cp0_cause;
-	uint32_t exccode = (cause >> CAUSEB_EXCCODE) & 0x1f;
-	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.pc;
+	u32 cause = vcpu->arch.host_cp0_cause;
+	u32 exccode = (cause >> CAUSEB_EXCCODE) & 0x1f;
+	u32 __user *opc = (u32 __user *) vcpu->arch.pc;
 	unsigned long badvaddr = vcpu->arch.host_cp0_badvaddr;
 	enum emulation_result er = EMULATE_DONE;
 	int ret = RESUME_GUEST;
diff --git a/arch/mips/kvm/tlb.c b/arch/mips/kvm/tlb.c
index 7ea346e150a8..c4e11e138042 100644
--- a/arch/mips/kvm/tlb.c
+++ b/arch/mips/kvm/tlb.c
@@ -32,8 +32,6 @@
 #define KVM_GUEST_PC_TLB    0
 #define KVM_GUEST_SP_TLB    1
 
-#define PRIx64 "llx"
-
 atomic_t kvm_mips_instance;
 EXPORT_SYMBOL_GPL(kvm_mips_instance);
 
@@ -102,13 +100,13 @@ void kvm_mips_dump_host_tlbs(void)
 		kvm_info("TLB%c%3d Hi 0x%08lx ",
 			 (tlb.tlb_lo0 | tlb.tlb_lo1) & MIPS3_PG_V ? ' ' : '*',
 			 i, tlb.tlb_hi);
-		kvm_info("Lo0=0x%09" PRIx64 " %c%c attr %lx ",
-			 (uint64_t) mips3_tlbpfn_to_paddr(tlb.tlb_lo0),
+		kvm_info("Lo0=0x%09llx %c%c attr %lx ",
+			 (u64) mips3_tlbpfn_to_paddr(tlb.tlb_lo0),
 			 (tlb.tlb_lo0 & MIPS3_PG_D) ? 'D' : ' ',
 			 (tlb.tlb_lo0 & MIPS3_PG_G) ? 'G' : ' ',
 			 (tlb.tlb_lo0 >> 3) & 7);
-		kvm_info("Lo1=0x%09" PRIx64 " %c%c attr %lx sz=%lx\n",
-			 (uint64_t) mips3_tlbpfn_to_paddr(tlb.tlb_lo1),
+		kvm_info("Lo1=0x%09llx %c%c attr %lx sz=%lx\n",
+			 (u64) mips3_tlbpfn_to_paddr(tlb.tlb_lo1),
 			 (tlb.tlb_lo1 & MIPS3_PG_D) ? 'D' : ' ',
 			 (tlb.tlb_lo1 & MIPS3_PG_G) ? 'G' : ' ',
 			 (tlb.tlb_lo1 >> 3) & 7, tlb.tlb_mask);
@@ -134,13 +132,13 @@ void kvm_mips_dump_guest_tlbs(struct kvm_vcpu *vcpu)
 		kvm_info("TLB%c%3d Hi 0x%08lx ",
 			 (tlb.tlb_lo0 | tlb.tlb_lo1) & MIPS3_PG_V ? ' ' : '*',
 			 i, tlb.tlb_hi);
-		kvm_info("Lo0=0x%09" PRIx64 " %c%c attr %lx ",
-			 (uint64_t) mips3_tlbpfn_to_paddr(tlb.tlb_lo0),
+		kvm_info("Lo0=0x%09llx %c%c attr %lx ",
+			 (u64) mips3_tlbpfn_to_paddr(tlb.tlb_lo0),
 			 (tlb.tlb_lo0 & MIPS3_PG_D) ? 'D' : ' ',
 			 (tlb.tlb_lo0 & MIPS3_PG_G) ? 'G' : ' ',
 			 (tlb.tlb_lo0 >> 3) & 7);
-		kvm_info("Lo1=0x%09" PRIx64 " %c%c attr %lx sz=%lx\n",
-			 (uint64_t) mips3_tlbpfn_to_paddr(tlb.tlb_lo1),
+		kvm_info("Lo1=0x%09llx %c%c attr %lx sz=%lx\n",
+			 (u64) mips3_tlbpfn_to_paddr(tlb.tlb_lo1),
 			 (tlb.tlb_lo1 & MIPS3_PG_D) ? 'D' : ' ',
 			 (tlb.tlb_lo1 & MIPS3_PG_G) ? 'G' : ' ',
 			 (tlb.tlb_lo1 >> 3) & 7, tlb.tlb_mask);
@@ -160,7 +158,7 @@ static int kvm_mips_map_page(struct kvm *kvm, gfn_t gfn)
 	pfn = kvm_mips_gfn_to_pfn(kvm, gfn);
 
 	if (kvm_mips_is_error_pfn(pfn)) {
-		kvm_err("Couldn't get pfn for gfn %#" PRIx64 "!\n", gfn);
+		kvm_err("Couldn't get pfn for gfn %#llx!\n", gfn);
 		err = -EFAULT;
 		goto out;
 	}
@@ -176,7 +174,7 @@ unsigned long kvm_mips_translate_guest_kseg0_to_hpa(struct kvm_vcpu *vcpu,
 						    unsigned long gva)
 {
 	gfn_t gfn;
-	uint32_t offset = gva & ~PAGE_MASK;
+	unsigned long offset = gva & ~PAGE_MASK;
 	struct kvm *kvm = vcpu->kvm;
 
 	if (KVM_GUEST_KSEGX(gva) != KVM_GUEST_KSEG0) {
@@ -726,7 +724,7 @@ EXPORT_SYMBOL_GPL(kvm_arch_vcpu_load);
 void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 {
 	unsigned long flags;
-	uint32_t cpu;
+	int cpu;
 
 	local_irq_save(flags);
 
@@ -755,7 +753,7 @@ u32 kvm_get_inst(u32 *opc, struct kvm_vcpu *vcpu)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	unsigned long paddr, flags, vpn2, asid;
-	uint32_t inst;
+	u32 inst;
 	int index;
 
 	if (KVM_GUEST_KSEGX((unsigned long) opc) < KVM_GUEST_KSEG0 ||
@@ -787,7 +785,7 @@ u32 kvm_get_inst(u32 *opc, struct kvm_vcpu *vcpu)
 		paddr =
 		    kvm_mips_translate_guest_kseg0_to_hpa(vcpu,
 							  (unsigned long) opc);
-		inst = *(uint32_t *) CKSEG0ADDR(paddr);
+		inst = *(u32 *) CKSEG0ADDR(paddr);
 	} else {
 		kvm_err("%s: illegal address: %p\n", __func__, opc);
 		return KVM_INVALID_INST;
diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index 6ba0fafcecbc..4aa5d77b0d6a 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -21,7 +21,7 @@
 static gpa_t kvm_trap_emul_gva_to_gpa_cb(gva_t gva)
 {
 	gpa_t gpa;
-	uint32_t kseg = KSEGX(gva);
+	gva_t kseg = KSEGX(gva);
 
 	if ((kseg == CKSEG0) || (kseg == CKSEG1))
 		gpa = CPHYSADDR(gva);
@@ -40,7 +40,7 @@ static int kvm_trap_emul_handle_cop_unusable(struct kvm_vcpu *vcpu)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	struct kvm_run *run = vcpu->run;
-	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.pc;
+	u32 __user *opc = (u32 __user *) vcpu->arch.pc;
 	unsigned long cause = vcpu->arch.host_cp0_cause;
 	enum emulation_result er = EMULATE_DONE;
 	int ret = RESUME_GUEST;
@@ -87,7 +87,7 @@ static int kvm_trap_emul_handle_cop_unusable(struct kvm_vcpu *vcpu)
 static int kvm_trap_emul_handle_tlb_mod(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
-	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.pc;
+	u32 __user *opc = (u32 __user *) vcpu->arch.pc;
 	unsigned long badvaddr = vcpu->arch.host_cp0_badvaddr;
 	unsigned long cause = vcpu->arch.host_cp0_cause;
 	enum emulation_result er = EMULATE_DONE;
@@ -131,7 +131,7 @@ static int kvm_trap_emul_handle_tlb_mod(struct kvm_vcpu *vcpu)
 static int kvm_trap_emul_handle_tlb_st_miss(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
-	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.pc;
+	u32 __user *opc = (u32 __user *) vcpu->arch.pc;
 	unsigned long badvaddr = vcpu->arch.host_cp0_badvaddr;
 	unsigned long cause = vcpu->arch.host_cp0_cause;
 	enum emulation_result er = EMULATE_DONE;
@@ -178,7 +178,7 @@ static int kvm_trap_emul_handle_tlb_st_miss(struct kvm_vcpu *vcpu)
 static int kvm_trap_emul_handle_tlb_ld_miss(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
-	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.pc;
+	u32 __user *opc = (u32 __user *) vcpu->arch.pc;
 	unsigned long badvaddr = vcpu->arch.host_cp0_badvaddr;
 	unsigned long cause = vcpu->arch.host_cp0_cause;
 	enum emulation_result er = EMULATE_DONE;
@@ -232,7 +232,7 @@ static int kvm_trap_emul_handle_tlb_ld_miss(struct kvm_vcpu *vcpu)
 static int kvm_trap_emul_handle_addr_err_st(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
-	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.pc;
+	u32 __user *opc = (u32 __user *) vcpu->arch.pc;
 	unsigned long badvaddr = vcpu->arch.host_cp0_badvaddr;
 	unsigned long cause = vcpu->arch.host_cp0_cause;
 	enum emulation_result er = EMULATE_DONE;
@@ -262,7 +262,7 @@ static int kvm_trap_emul_handle_addr_err_st(struct kvm_vcpu *vcpu)
 static int kvm_trap_emul_handle_addr_err_ld(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
-	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.pc;
+	u32 __user *opc = (u32 __user *) vcpu->arch.pc;
 	unsigned long badvaddr = vcpu->arch.host_cp0_badvaddr;
 	unsigned long cause = vcpu->arch.host_cp0_cause;
 	enum emulation_result er = EMULATE_DONE;
@@ -292,7 +292,7 @@ static int kvm_trap_emul_handle_addr_err_ld(struct kvm_vcpu *vcpu)
 static int kvm_trap_emul_handle_syscall(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
-	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.pc;
+	u32 __user *opc = (u32 __user *) vcpu->arch.pc;
 	unsigned long cause = vcpu->arch.host_cp0_cause;
 	enum emulation_result er = EMULATE_DONE;
 	int ret = RESUME_GUEST;
@@ -310,7 +310,7 @@ static int kvm_trap_emul_handle_syscall(struct kvm_vcpu *vcpu)
 static int kvm_trap_emul_handle_res_inst(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
-	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.pc;
+	u32 __user *opc = (u32 __user *) vcpu->arch.pc;
 	unsigned long cause = vcpu->arch.host_cp0_cause;
 	enum emulation_result er = EMULATE_DONE;
 	int ret = RESUME_GUEST;
@@ -328,7 +328,7 @@ static int kvm_trap_emul_handle_res_inst(struct kvm_vcpu *vcpu)
 static int kvm_trap_emul_handle_break(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
-	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.pc;
+	u32 __user *opc = (u32 __user *) vcpu->arch.pc;
 	unsigned long cause = vcpu->arch.host_cp0_cause;
 	enum emulation_result er = EMULATE_DONE;
 	int ret = RESUME_GUEST;
@@ -346,7 +346,7 @@ static int kvm_trap_emul_handle_break(struct kvm_vcpu *vcpu)
 static int kvm_trap_emul_handle_trap(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
-	uint32_t __user *opc = (uint32_t __user *)vcpu->arch.pc;
+	u32 __user *opc = (u32 __user *)vcpu->arch.pc;
 	unsigned long cause = vcpu->arch.host_cp0_cause;
 	enum emulation_result er = EMULATE_DONE;
 	int ret = RESUME_GUEST;
@@ -364,7 +364,7 @@ static int kvm_trap_emul_handle_trap(struct kvm_vcpu *vcpu)
 static int kvm_trap_emul_handle_msa_fpe(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
-	uint32_t __user *opc = (uint32_t __user *)vcpu->arch.pc;
+	u32 __user *opc = (u32 __user *)vcpu->arch.pc;
 	unsigned long cause = vcpu->arch.host_cp0_cause;
 	enum emulation_result er = EMULATE_DONE;
 	int ret = RESUME_GUEST;
@@ -382,7 +382,7 @@ static int kvm_trap_emul_handle_msa_fpe(struct kvm_vcpu *vcpu)
 static int kvm_trap_emul_handle_fpe(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
-	uint32_t __user *opc = (uint32_t __user *)vcpu->arch.pc;
+	u32 __user *opc = (u32 __user *)vcpu->arch.pc;
 	unsigned long cause = vcpu->arch.host_cp0_cause;
 	enum emulation_result er = EMULATE_DONE;
 	int ret = RESUME_GUEST;
@@ -407,7 +407,7 @@ static int kvm_trap_emul_handle_msa_disabled(struct kvm_vcpu *vcpu)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	struct kvm_run *run = vcpu->run;
-	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.pc;
+	u32 __user *opc = (u32 __user *) vcpu->arch.pc;
 	unsigned long cause = vcpu->arch.host_cp0_cause;
 	enum emulation_result er = EMULATE_DONE;
 	int ret = RESUME_GUEST;
@@ -457,7 +457,7 @@ static int kvm_trap_emul_vcpu_init(struct kvm_vcpu *vcpu)
 static int kvm_trap_emul_vcpu_setup(struct kvm_vcpu *vcpu)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
-	uint32_t config1;
+	u32 config1;
 	int vcpu_id = vcpu->vcpu_id;
 
 	/*
-- 
2.4.10
