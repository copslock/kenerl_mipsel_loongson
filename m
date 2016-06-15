Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jun 2016 20:31:24 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:28676 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27042331AbcFOSaPTm2SW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Jun 2016 20:30:15 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id D50E08611C962;
        Wed, 15 Jun 2016 19:30:03 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 15 Jun 2016 19:30:07 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 03/17] MIPS: KVM: Convert emulation to use asm/inst.h
Date:   Wed, 15 Jun 2016 19:29:47 +0100
Message-ID: <1466015401-24433-4-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1466015401-24433-1-git-send-email-james.hogan@imgtec.com>
References: <1466015401-24433-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54057
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

Convert various MIPS KVM guest instruction emulation functions to decode
instructions (and encode translations) using the union mips_instruction
and related enumerations in asm/inst.h rather than #defines and
hardcoded values.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h  |  22 ++++----
 arch/mips/include/uapi/asm/inst.h |  35 +++++++++++-
 arch/mips/kvm/dyntrans.c          |  74 +++++++++++++-------------
 arch/mips/kvm/emulate.c           | 109 +++++++++++++++-----------------------
 4 files changed, 126 insertions(+), 114 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index b8cb74270746..1e002136f514 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -19,6 +19,7 @@
 #include <linux/threads.h>
 #include <linux/spinlock.h>
 
+#include <asm/inst.h>
 #include <asm/mipsregs.h>
 
 /* MIPS KVM register ids */
@@ -733,21 +734,21 @@ enum emulation_result kvm_mips_check_privilege(u32 cause,
 					       struct kvm_run *run,
 					       struct kvm_vcpu *vcpu);
 
-enum emulation_result kvm_mips_emulate_cache(u32 inst,
+enum emulation_result kvm_mips_emulate_cache(union mips_instruction inst,
 					     u32 *opc,
 					     u32 cause,
 					     struct kvm_run *run,
 					     struct kvm_vcpu *vcpu);
-enum emulation_result kvm_mips_emulate_CP0(u32 inst,
+enum emulation_result kvm_mips_emulate_CP0(union mips_instruction inst,
 					   u32 *opc,
 					   u32 cause,
 					   struct kvm_run *run,
 					   struct kvm_vcpu *vcpu);
-enum emulation_result kvm_mips_emulate_store(u32 inst,
+enum emulation_result kvm_mips_emulate_store(union mips_instruction inst,
 					     u32 cause,
 					     struct kvm_run *run,
 					     struct kvm_vcpu *vcpu);
-enum emulation_result kvm_mips_emulate_load(u32 inst,
+enum emulation_result kvm_mips_emulate_load(union mips_instruction inst,
 					    u32 cause,
 					    struct kvm_run *run,
 					    struct kvm_vcpu *vcpu);
@@ -758,11 +759,14 @@ unsigned int kvm_mips_config4_wrmask(struct kvm_vcpu *vcpu);
 unsigned int kvm_mips_config5_wrmask(struct kvm_vcpu *vcpu);
 
 /* Dynamic binary translation */
-extern int kvm_mips_trans_cache_index(u32 inst, u32 *opc,
-				      struct kvm_vcpu *vcpu);
-extern int kvm_mips_trans_cache_va(u32 inst, u32 *opc, struct kvm_vcpu *vcpu);
-extern int kvm_mips_trans_mfc0(u32 inst, u32 *opc, struct kvm_vcpu *vcpu);
-extern int kvm_mips_trans_mtc0(u32 inst, u32 *opc, struct kvm_vcpu *vcpu);
+extern int kvm_mips_trans_cache_index(union mips_instruction inst,
+				      u32 *opc, struct kvm_vcpu *vcpu);
+extern int kvm_mips_trans_cache_va(union mips_instruction inst, u32 *opc,
+				   struct kvm_vcpu *vcpu);
+extern int kvm_mips_trans_mfc0(union mips_instruction inst, u32 *opc,
+			       struct kvm_vcpu *vcpu);
+extern int kvm_mips_trans_mtc0(union mips_instruction inst, u32 *opc,
+			       struct kvm_vcpu *vcpu);
 
 /* Misc */
 extern void kvm_mips_dump_stats(struct kvm_vcpu *vcpu);
diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/asm/inst.h
index 8051f9aa1379..a1ebf973725c 100644
--- a/arch/mips/include/uapi/asm/inst.h
+++ b/arch/mips/include/uapi/asm/inst.h
@@ -103,7 +103,7 @@ enum rt_op {
 	bltzal_op, bgezal_op, bltzall_op, bgezall_op,
 	rt_op_0x14, rt_op_0x15, rt_op_0x16, rt_op_0x17,
 	rt_op_0x18, rt_op_0x19, rt_op_0x1a, rt_op_0x1b,
-	bposge32_op, rt_op_0x1d, rt_op_0x1e, rt_op_0x1f
+	bposge32_op, rt_op_0x1d, rt_op_0x1e, synci_op
 };
 
 /*
@@ -586,6 +586,36 @@ struct r_format {			/* Register format */
 	;))))))
 };
 
+struct c0r_format {			/* C0 register format */
+	__BITFIELD_FIELD(unsigned int opcode : 6,
+	__BITFIELD_FIELD(unsigned int rs : 5,
+	__BITFIELD_FIELD(unsigned int rt : 5,
+	__BITFIELD_FIELD(unsigned int rd : 5,
+	__BITFIELD_FIELD(unsigned int z: 8,
+	__BITFIELD_FIELD(unsigned int sel : 3,
+	;))))))
+};
+
+struct mfmc0_format {			/* MFMC0 register format */
+	__BITFIELD_FIELD(unsigned int opcode : 6,
+	__BITFIELD_FIELD(unsigned int rs : 5,
+	__BITFIELD_FIELD(unsigned int rt : 5,
+	__BITFIELD_FIELD(unsigned int rd : 5,
+	__BITFIELD_FIELD(unsigned int re : 5,
+	__BITFIELD_FIELD(unsigned int sc : 1,
+	__BITFIELD_FIELD(unsigned int : 2,
+	__BITFIELD_FIELD(unsigned int sel : 3,
+	;))))))))
+};
+
+struct co_format {			/* C0 CO format */
+	__BITFIELD_FIELD(unsigned int opcode : 6,
+	__BITFIELD_FIELD(unsigned int co : 1,
+	__BITFIELD_FIELD(unsigned int code : 19,
+	__BITFIELD_FIELD(unsigned int func : 6,
+	;))))
+};
+
 struct p_format {		/* Performance counter format (R10000) */
 	__BITFIELD_FIELD(unsigned int opcode : 6,
 	__BITFIELD_FIELD(unsigned int rs : 5,
@@ -937,6 +967,9 @@ union mips_instruction {
 	struct u_format u_format;
 	struct c_format c_format;
 	struct r_format r_format;
+	struct c0r_format c0r_format;
+	struct mfmc0_format mfmc0_format;
+	struct co_format co_format;
 	struct p_format p_format;
 	struct f_format f_format;
 	struct ma_format ma_format;
diff --git a/arch/mips/kvm/dyntrans.c b/arch/mips/kvm/dyntrans.c
index eb6e0d17a668..a3031dae8d1b 100644
--- a/arch/mips/kvm/dyntrans.c
+++ b/arch/mips/kvm/dyntrans.c
@@ -20,21 +20,14 @@
 
 #include "commpage.h"
 
-#define SYNCI_TEMPLATE  0x041f0000
-#define SYNCI_BASE(x)   (((x) >> 21) & 0x1f)
-#define SYNCI_OFFSET    ((x) & 0xffff)
-
-#define LW_TEMPLATE     0x8c000000
-#define CLEAR_TEMPLATE  0x00000020
-#define SW_TEMPLATE     0xac000000
-
 /**
  * kvm_mips_trans_replace() - Replace trapping instruction in guest memory.
  * @vcpu:	Virtual CPU.
  * @opc:	PC of instruction to replace.
  * @replace:	Instruction to write
  */
-static int kvm_mips_trans_replace(struct kvm_vcpu *vcpu, u32 *opc, u32 replace)
+static int kvm_mips_trans_replace(struct kvm_vcpu *vcpu, u32 *opc,
+				  union mips_instruction replace)
 {
 	unsigned long kseg0_opc, flags;
 
@@ -58,63 +51,68 @@ static int kvm_mips_trans_replace(struct kvm_vcpu *vcpu, u32 *opc, u32 replace)
 	return 0;
 }
 
-int kvm_mips_trans_cache_index(u32 inst, u32 *opc,
+int kvm_mips_trans_cache_index(union mips_instruction inst, u32 *opc,
 			       struct kvm_vcpu *vcpu)
 {
+	union mips_instruction nop_inst = { 0 };
+
 	/* Replace the CACHE instruction, with a NOP */
-	return kvm_mips_trans_replace(vcpu, opc, 0x00000000);
+	return kvm_mips_trans_replace(vcpu, opc, nop_inst);
 }
 
 /*
  * Address based CACHE instructions are transformed into synci(s). A little
  * heavy for just D-cache invalidates, but avoids an expensive trap
  */
-int kvm_mips_trans_cache_va(u32 inst, u32 *opc,
+int kvm_mips_trans_cache_va(union mips_instruction inst, u32 *opc,
 			    struct kvm_vcpu *vcpu)
 {
-	u32 synci_inst = SYNCI_TEMPLATE, base, offset;
+	union mips_instruction synci_inst = { 0 };
 
-	base = (inst >> 21) & 0x1f;
-	offset = inst & 0xffff;
-	synci_inst |= (base << 21);
-	synci_inst |= offset;
+	synci_inst.i_format.opcode = bcond_op;
+	synci_inst.i_format.rs = inst.i_format.rs;
+	synci_inst.i_format.rt = synci_op;
+	synci_inst.i_format.simmediate = inst.i_format.simmediate;
 
 	return kvm_mips_trans_replace(vcpu, opc, synci_inst);
 }
 
-int kvm_mips_trans_mfc0(u32 inst, u32 *opc, struct kvm_vcpu *vcpu)
+int kvm_mips_trans_mfc0(union mips_instruction inst, u32 *opc,
+			struct kvm_vcpu *vcpu)
 {
-	u32 rt, rd, sel;
-	u32 mfc0_inst;
+	union mips_instruction mfc0_inst = { 0 };
+	u32 rd, sel;
 
-	rt = (inst >> 16) & 0x1f;
-	rd = (inst >> 11) & 0x1f;
-	sel = inst & 0x7;
+	rd = inst.c0r_format.rd;
+	sel = inst.c0r_format.sel;
 
-	if ((rd == MIPS_CP0_ERRCTL) && (sel == 0)) {
-		mfc0_inst = CLEAR_TEMPLATE;
-		mfc0_inst |= ((rt & 0x1f) << 11);
+	if (rd == MIPS_CP0_ERRCTL && sel == 0) {
+		mfc0_inst.r_format.opcode = spec_op;
+		mfc0_inst.r_format.rd = inst.c0r_format.rt;
+		mfc0_inst.r_format.func = add_op;
 	} else {
-		mfc0_inst = LW_TEMPLATE;
-		mfc0_inst |= ((rt & 0x1f) << 16);
-		mfc0_inst |= offsetof(struct kvm_mips_commpage,
-				      cop0.reg[rd][sel]);
+		mfc0_inst.i_format.opcode = lw_op;
+		mfc0_inst.i_format.rt = inst.c0r_format.rt;
+		mfc0_inst.i_format.simmediate =
+			offsetof(struct kvm_mips_commpage, cop0.reg[rd][sel]);
 	}
 
 	return kvm_mips_trans_replace(vcpu, opc, mfc0_inst);
 }
 
-int kvm_mips_trans_mtc0(u32 inst, u32 *opc, struct kvm_vcpu *vcpu)
+int kvm_mips_trans_mtc0(union mips_instruction inst, u32 *opc,
+			struct kvm_vcpu *vcpu)
 {
-	u32 rt, rd, sel;
-	u32 mtc0_inst = SW_TEMPLATE;
+	union mips_instruction mtc0_inst = { 0 };
+	u32 rd, sel;
 
-	rt = (inst >> 16) & 0x1f;
-	rd = (inst >> 11) & 0x1f;
-	sel = inst & 0x7;
+	rd = inst.c0r_format.rd;
+	sel = inst.c0r_format.sel;
 
-	mtc0_inst |= ((rt & 0x1f) << 16);
-	mtc0_inst |= offsetof(struct kvm_mips_commpage, cop0.reg[rd][sel]);
+	mtc0_inst.i_format.opcode = sw_op;
+	mtc0_inst.i_format.rt = inst.c0r_format.rt;
+	mtc0_inst.i_format.simmediate =
+		offsetof(struct kvm_mips_commpage, cop0.reg[rd][sel]);
 
 	return kvm_mips_trans_replace(vcpu, opc, mtc0_inst);
 }
diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index ff4072c2b25e..80bb6212a067 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -972,13 +972,14 @@ unsigned int kvm_mips_config5_wrmask(struct kvm_vcpu *vcpu)
 	return mask;
 }
 
-enum emulation_result kvm_mips_emulate_CP0(u32 inst, u32 *opc, u32 cause,
+enum emulation_result kvm_mips_emulate_CP0(union mips_instruction inst,
+					   u32 *opc, u32 cause,
 					   struct kvm_run *run,
 					   struct kvm_vcpu *vcpu)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	enum emulation_result er = EMULATE_DONE;
-	u32 rt, rd, copz, sel, co_bit, op;
+	u32 rt, rd, sel;
 	unsigned long curr_pc;
 
 	/*
@@ -990,16 +991,8 @@ enum emulation_result kvm_mips_emulate_CP0(u32 inst, u32 *opc, u32 cause,
 	if (er == EMULATE_FAIL)
 		return er;
 
-	copz = (inst >> 21) & 0x1f;
-	rt = (inst >> 16) & 0x1f;
-	rd = (inst >> 11) & 0x1f;
-	sel = inst & 0x7;
-	co_bit = (inst >> 25) & 1;
-
-	if (co_bit) {
-		op = (inst) & 0xff;
-
-		switch (op) {
+	if (inst.co_format.co) {
+		switch (inst.co_format.func) {
 		case tlbr_op:	/*  Read indexed TLB entry  */
 			er = kvm_mips_emul_tlbr(vcpu);
 			break;
@@ -1018,13 +1011,16 @@ enum emulation_result kvm_mips_emulate_CP0(u32 inst, u32 *opc, u32 cause,
 		case eret_op:
 			er = kvm_mips_emul_eret(vcpu);
 			goto dont_update_pc;
-			break;
 		case wait_op:
 			er = kvm_mips_emul_wait(vcpu);
 			break;
 		}
 	} else {
-		switch (copz) {
+		rt = inst.c0r_format.rt;
+		rd = inst.c0r_format.rd;
+		sel = inst.c0r_format.sel;
+
+		switch (inst.c0r_format.rs) {
 		case mfc_op:
 #ifdef CONFIG_KVM_MIPS_DEBUG_COP0_COUNTERS
 			cop0->stat[rd][sel]++;
@@ -1258,7 +1254,7 @@ enum emulation_result kvm_mips_emulate_CP0(u32 inst, u32 *opc, u32 cause,
 				vcpu->arch.gprs[rt] =
 				    kvm_read_c0_guest_status(cop0);
 			/* EI */
-			if (inst & 0x20) {
+			if (inst.mfmc0_format.sc) {
 				kvm_debug("[%#lx] mfmc0_op: EI\n",
 					  vcpu->arch.pc);
 				kvm_set_c0_guest_status(cop0, ST0_IE);
@@ -1290,7 +1286,7 @@ enum emulation_result kvm_mips_emulate_CP0(u32 inst, u32 *opc, u32 cause,
 			break;
 		default:
 			kvm_err("[%#lx]MachEmulateCP0: unsupported COP0, copz: 0x%x\n",
-				vcpu->arch.pc, copz);
+				vcpu->arch.pc, inst.c0r_format.rs);
 			er = EMULATE_FAIL;
 			break;
 		}
@@ -1311,13 +1307,13 @@ dont_update_pc:
 	return er;
 }
 
-enum emulation_result kvm_mips_emulate_store(u32 inst, u32 cause,
+enum emulation_result kvm_mips_emulate_store(union mips_instruction inst,
+					     u32 cause,
 					     struct kvm_run *run,
 					     struct kvm_vcpu *vcpu)
 {
 	enum emulation_result er = EMULATE_DO_MMIO;
-	u32 op, base, rt;
-	s16 offset;
+	u32 rt;
 	u32 bytes;
 	void *data = run->mmio.data;
 	unsigned long curr_pc;
@@ -1331,12 +1327,9 @@ enum emulation_result kvm_mips_emulate_store(u32 inst, u32 cause,
 	if (er == EMULATE_FAIL)
 		return er;
 
-	rt = (inst >> 16) & 0x1f;
-	base = (inst >> 21) & 0x1f;
-	offset = (s16)inst;
-	op = (inst >> 26) & 0x3f;
+	rt = inst.i_format.rt;
 
-	switch (op) {
+	switch (inst.i_format.opcode) {
 	case sb_op:
 		bytes = 1;
 		if (bytes > sizeof(run->mmio.data)) {
@@ -1413,7 +1406,7 @@ enum emulation_result kvm_mips_emulate_store(u32 inst, u32 cause,
 
 	default:
 		kvm_err("Store not yet supported (inst=0x%08x)\n",
-			inst);
+			inst.word);
 		er = EMULATE_FAIL;
 		break;
 	}
@@ -1425,19 +1418,16 @@ enum emulation_result kvm_mips_emulate_store(u32 inst, u32 cause,
 	return er;
 }
 
-enum emulation_result kvm_mips_emulate_load(u32 inst, u32 cause,
-					    struct kvm_run *run,
+enum emulation_result kvm_mips_emulate_load(union mips_instruction inst,
+					    u32 cause, struct kvm_run *run,
 					    struct kvm_vcpu *vcpu)
 {
 	enum emulation_result er = EMULATE_DO_MMIO;
-	u32 op, base, rt;
-	s16 offset;
+	u32 op, rt;
 	u32 bytes;
 
-	rt = (inst >> 16) & 0x1f;
-	base = (inst >> 21) & 0x1f;
-	offset = (s16)inst;
-	op = (inst >> 26) & 0x3f;
+	rt = inst.i_format.rt;
+	op = inst.i_format.opcode;
 
 	vcpu->arch.pending_load_cause = cause;
 	vcpu->arch.io_gpr = rt;
@@ -1524,7 +1514,7 @@ enum emulation_result kvm_mips_emulate_load(u32 inst, u32 cause,
 
 	default:
 		kvm_err("Load not yet supported (inst=0x%08x)\n",
-			inst);
+			inst.word);
 		er = EMULATE_FAIL;
 		break;
 	}
@@ -1532,8 +1522,8 @@ enum emulation_result kvm_mips_emulate_load(u32 inst, u32 cause,
 	return er;
 }
 
-enum emulation_result kvm_mips_emulate_cache(u32 inst, u32 *opc,
-					     u32 cause,
+enum emulation_result kvm_mips_emulate_cache(union mips_instruction inst,
+					     u32 *opc, u32 cause,
 					     struct kvm_run *run,
 					     struct kvm_vcpu *vcpu)
 {
@@ -1554,9 +1544,9 @@ enum emulation_result kvm_mips_emulate_cache(u32 inst, u32 *opc,
 	if (er == EMULATE_FAIL)
 		return er;
 
-	base = (inst >> 21) & 0x1f;
-	op_inst = (inst >> 16) & 0x1f;
-	offset = (s16)inst;
+	base = inst.i_format.rs;
+	op_inst = inst.i_format.rt;
+	offset = inst.i_format.simmediate;
 	cache = op_inst & CacheOp_Cache;
 	op = op_inst & CacheOp_Op;
 
@@ -1693,16 +1683,16 @@ enum emulation_result kvm_mips_emulate_inst(u32 cause, u32 *opc,
 					    struct kvm_run *run,
 					    struct kvm_vcpu *vcpu)
 {
+	union mips_instruction inst;
 	enum emulation_result er = EMULATE_DONE;
-	u32 inst;
 
 	/* Fetch the instruction. */
 	if (cause & CAUSEF_BD)
 		opc += 1;
 
-	inst = kvm_get_inst(opc, vcpu);
+	inst.word = kvm_get_inst(opc, vcpu);
 
-	switch (((union mips_instruction)inst).r_format.opcode) {
+	switch (inst.r_format.opcode) {
 	case cop0_op:
 		er = kvm_mips_emulate_CP0(inst, opc, cause, run, vcpu);
 		break;
@@ -1727,7 +1717,7 @@ enum emulation_result kvm_mips_emulate_inst(u32 cause, u32 *opc,
 
 	default:
 		kvm_err("Instruction emulation not supported (%p/%#x)\n", opc,
-			inst);
+			inst.word);
 		kvm_arch_vcpu_dump_regs(vcpu);
 		er = EMULATE_FAIL;
 		break;
@@ -2262,21 +2252,6 @@ enum emulation_result kvm_mips_emulate_msadis_exc(u32 cause,
 	return er;
 }
 
-/* ll/sc, rdhwr, sync emulation */
-
-#define OPCODE 0xfc000000
-#define BASE   0x03e00000
-#define RT     0x001f0000
-#define OFFSET 0x0000ffff
-#define LL     0xc0000000
-#define SC     0xe0000000
-#define SPEC0  0x00000000
-#define SPEC3  0x7c000000
-#define RD     0x0000f800
-#define FUNC   0x0000003f
-#define SYNC   0x0000000f
-#define RDHWR  0x0000003b
-
 enum emulation_result kvm_mips_handle_ri(u32 cause, u32 *opc,
 					 struct kvm_run *run,
 					 struct kvm_vcpu *vcpu)
@@ -2285,7 +2260,7 @@ enum emulation_result kvm_mips_handle_ri(u32 cause, u32 *opc,
 	struct kvm_vcpu_arch *arch = &vcpu->arch;
 	enum emulation_result er = EMULATE_DONE;
 	unsigned long curr_pc;
-	u32 inst;
+	union mips_instruction inst;
 
 	/*
 	 * Update PC and hold onto current PC in case there is
@@ -2300,18 +2275,19 @@ enum emulation_result kvm_mips_handle_ri(u32 cause, u32 *opc,
 	if (cause & CAUSEF_BD)
 		opc += 1;
 
-	inst = kvm_get_inst(opc, vcpu);
+	inst.word = kvm_get_inst(opc, vcpu);
 
-	if (inst == KVM_INVALID_INST) {
+	if (inst.word == KVM_INVALID_INST) {
 		kvm_err("%s: Cannot get inst @ %p\n", __func__, opc);
 		return EMULATE_FAIL;
 	}
 
-	if ((inst & OPCODE) == SPEC3 && (inst & FUNC) == RDHWR) {
+	if (inst.r_format.opcode == spec3_op &&
+	    inst.r_format.func == rdhwr_op) {
 		int usermode = !KVM_GUEST_KERNEL_MODE(vcpu);
-		int rd = (inst & RD) >> 11;
-		int rt = (inst & RT) >> 16;
-		int sel = (inst >> 6) & 0x7;
+		int rd = inst.r_format.rd;
+		int rt = inst.r_format.rt;
+		int sel = inst.r_format.re & 0x7;
 
 		/* If usermode, check RDHWR rd is allowed by guest HWREna */
 		if (usermode && !(kvm_read_c0_guest_hwrena(cop0) & BIT(rd))) {
@@ -2352,7 +2328,8 @@ enum emulation_result kvm_mips_handle_ri(u32 cause, u32 *opc,
 		trace_kvm_hwr(vcpu, KVM_TRACE_RDHWR, KVM_TRACE_HWR(rd, sel),
 			      vcpu->arch.gprs[rt]);
 	} else {
-		kvm_debug("Emulate RI not supported @ %p: %#x\n", opc, inst);
+		kvm_debug("Emulate RI not supported @ %p: %#x\n",
+			  opc, inst.word);
 		goto emulate_ri;
 	}
 
-- 
2.4.10
