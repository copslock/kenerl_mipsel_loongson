Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jan 2017 15:46:57 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:45994 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992328AbdAFOqIFHlGa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Jan 2017 15:46:08 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 5EAD3AD7A8253;
        Fri,  6 Jan 2017 14:45:58 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 6 Jan 2017 14:46:01 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 2/3] KVM: MIPS: Improve kvm_get_inst() error return
Date:   Fri, 6 Jan 2017 14:44:42 +0000
Message-ID: <7f86bbd32351ad43a8821519c2f492a5611e1f55.1483713106.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
In-Reply-To: <cover.bf96bfd5329a1b0bbde5c97362c9284cafcc0300.1483713106.git-series.james.hogan@imgtec.com>
References: <cover.bf96bfd5329a1b0bbde5c97362c9284cafcc0300.1483713106.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56218
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

Currently kvm_get_inst() returns KVM_INVALID_INST in the event of a
fault reading the guest instruction. This has the rather arbitrary magic
value 0xdeadbeef. This API isn't very robust, and in fact 0xdeadbeef is
a valid MIPS64 instruction encoding, namely "ld t1,-16657(s5)".

Therefore change the kvm_get_inst() API to return 0 or -EFAULT, and to
return the instruction via a u32 *out argument. We can then drop the
KVM_INVALID_INST definition entirely.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h |  3 +-
 arch/mips/kvm/emulate.c          | 90 ++++++++++++++++-----------------
 arch/mips/kvm/mips.c             |  7 ++-
 arch/mips/kvm/mmu.c              |  9 +--
 4 files changed, 56 insertions(+), 53 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 3c39ccd8856e..b0936a4d931a 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -104,7 +104,6 @@
 #define KVM_GUEST_KSEG23ADDR(a)		(KVM_GUEST_CPHYSADDR(a) | KVM_GUEST_KSEG23)
 
 #define KVM_INVALID_PAGE		0xdeadbeef
-#define KVM_INVALID_INST		0xdeadbeef
 #define KVM_INVALID_ADDR		0xdeadbeef
 
 /*
@@ -637,7 +636,7 @@ void kvm_trap_emul_invalidate_gva(struct kvm_vcpu *vcpu, unsigned long addr,
 				  bool user);
 
 /* Emulation */
-u32 kvm_get_inst(u32 *opc, struct kvm_vcpu *vcpu);
+int kvm_get_inst(u32 *opc, struct kvm_vcpu *vcpu, u32 *out);
 enum emulation_result update_pc(struct kvm_vcpu *vcpu, u32 cause);
 
 /**
diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index 67ea39973b96..b906fc0589f3 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -38,23 +38,25 @@
  * Compute the return address and do emulate branch simulation, if required.
  * This function should be called only in branch delay slot active.
  */
-unsigned long kvm_compute_return_epc(struct kvm_vcpu *vcpu,
-	unsigned long instpc)
+static int kvm_compute_return_epc(struct kvm_vcpu *vcpu, unsigned long instpc,
+				  unsigned long *out)
 {
 	unsigned int dspcontrol;
 	union mips_instruction insn;
 	struct kvm_vcpu_arch *arch = &vcpu->arch;
 	long epc = instpc;
-	long nextpc = KVM_INVALID_INST;
+	long nextpc;
+	int err;
 
-	if (epc & 3)
-		goto unaligned;
+	if (epc & 3) {
+		kvm_err("%s: unaligned epc\n", __func__);
+		return -EINVAL;
+	}
 
 	/* Read the instruction */
-	insn.word = kvm_get_inst((u32 *) epc, vcpu);
-
-	if (insn.word == KVM_INVALID_INST)
-		return KVM_INVALID_INST;
+	err = kvm_get_inst((u32 *)epc, vcpu, &insn.word);
+	if (err)
+		return err;
 
 	switch (insn.i_format.opcode) {
 		/* jr and jalr are in r_format format. */
@@ -66,6 +68,8 @@ unsigned long kvm_compute_return_epc(struct kvm_vcpu *vcpu,
 		case jr_op:
 			nextpc = arch->gprs[insn.r_format.rs];
 			break;
+		default:
+			return -EINVAL;
 		}
 		break;
 
@@ -114,8 +118,11 @@ unsigned long kvm_compute_return_epc(struct kvm_vcpu *vcpu,
 			nextpc = epc;
 			break;
 		case bposge32_op:
-			if (!cpu_has_dsp)
-				goto sigill;
+			if (!cpu_has_dsp) {
+				kvm_err("%s: DSP branch but not DSP ASE\n",
+					__func__);
+				return -EINVAL;
+			}
 
 			dspcontrol = rddsp(0x01);
 
@@ -125,6 +132,8 @@ unsigned long kvm_compute_return_epc(struct kvm_vcpu *vcpu,
 				epc += 8;
 			nextpc = epc;
 			break;
+		default:
+			return -EINVAL;
 		}
 		break;
 
@@ -189,7 +198,7 @@ unsigned long kvm_compute_return_epc(struct kvm_vcpu *vcpu,
 		/* And now the FPA/cp1 branch instructions. */
 	case cop1_op:
 		kvm_err("%s: unsupported cop1_op\n", __func__);
-		break;
+		return -EINVAL;
 
 #ifdef CONFIG_CPU_MIPSR6
 	/* R6 added the following compact branches with forbidden slots */
@@ -198,19 +207,19 @@ unsigned long kvm_compute_return_epc(struct kvm_vcpu *vcpu,
 		/* only rt == 0 isn't compact branch */
 		if (insn.i_format.rt != 0)
 			goto compact_branch;
-		break;
+		return -EINVAL;
 	case pop10_op:
 	case pop30_op:
 		/* only rs == rt == 0 is reserved, rest are compact branches */
 		if (insn.i_format.rs != 0 || insn.i_format.rt != 0)
 			goto compact_branch;
-		break;
+		return -EINVAL;
 	case pop66_op:
 	case pop76_op:
 		/* only rs == 0 isn't compact branch */
 		if (insn.i_format.rs != 0)
 			goto compact_branch;
-		break;
+		return -EINVAL;
 compact_branch:
 		/*
 		 * If we've hit an exception on the forbidden slot, then
@@ -221,42 +230,32 @@ unsigned long kvm_compute_return_epc(struct kvm_vcpu *vcpu,
 		break;
 #else
 compact_branch:
-		/* Compact branches not supported before R6 */
-		break;
+		/* Fall through - Compact branches not supported before R6 */
 #endif
+	default:
+		return -EINVAL;
 	}
 
-	return nextpc;
-
-unaligned:
-	kvm_err("%s: unaligned epc\n", __func__);
-	return nextpc;
-
-sigill:
-	kvm_err("%s: DSP branch but not DSP ASE\n", __func__);
-	return nextpc;
+	*out = nextpc;
+	return 0;
 }
 
 enum emulation_result update_pc(struct kvm_vcpu *vcpu, u32 cause)
 {
-	unsigned long branch_pc;
-	enum emulation_result er = EMULATE_DONE;
+	int err;
 
 	if (cause & CAUSEF_BD) {
-		branch_pc = kvm_compute_return_epc(vcpu, vcpu->arch.pc);
-		if (branch_pc == KVM_INVALID_INST) {
-			er = EMULATE_FAIL;
-		} else {
-			vcpu->arch.pc = branch_pc;
-			kvm_debug("BD update_pc(): New PC: %#lx\n",
-				  vcpu->arch.pc);
-		}
-	} else
+		err = kvm_compute_return_epc(vcpu, vcpu->arch.pc,
+					     &vcpu->arch.pc);
+		if (err)
+			return EMULATE_FAIL;
+	} else {
 		vcpu->arch.pc += 4;
+	}
 
 	kvm_debug("update_pc(): New PC: %#lx\n", vcpu->arch.pc);
 
-	return er;
+	return EMULATE_DONE;
 }
 
 /**
@@ -1835,12 +1834,14 @@ enum emulation_result kvm_mips_emulate_inst(u32 cause, u32 *opc,
 {
 	union mips_instruction inst;
 	enum emulation_result er = EMULATE_DONE;
+	int err;
 
 	/* Fetch the instruction. */
 	if (cause & CAUSEF_BD)
 		opc += 1;
-
-	inst.word = kvm_get_inst(opc, vcpu);
+	err = kvm_get_inst(opc, vcpu, &inst.word);
+	if (err)
+		return EMULATE_FAIL;
 
 	switch (inst.r_format.opcode) {
 	case cop0_op:
@@ -2419,6 +2420,7 @@ enum emulation_result kvm_mips_handle_ri(u32 cause, u32 *opc,
 	enum emulation_result er = EMULATE_DONE;
 	unsigned long curr_pc;
 	union mips_instruction inst;
+	int err;
 
 	/*
 	 * Update PC and hold onto current PC in case there is
@@ -2432,11 +2434,9 @@ enum emulation_result kvm_mips_handle_ri(u32 cause, u32 *opc,
 	/* Fetch the instruction. */
 	if (cause & CAUSEF_BD)
 		opc += 1;
-
-	inst.word = kvm_get_inst(opc, vcpu);
-
-	if (inst.word == KVM_INVALID_INST) {
-		kvm_err("%s: Cannot get inst @ %p\n", __func__, opc);
+	err = kvm_get_inst(opc, vcpu, &inst.word);
+	if (err) {
+		kvm_err("%s: Cannot get inst @ %p (%d)\n", __func__, opc, err);
 		return EMULATE_FAIL;
 	}
 
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 001349124bad..69775fb9c408 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -1348,6 +1348,7 @@ int kvm_mips_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
 	u32 __user *opc = (u32 __user *) vcpu->arch.pc;
 	unsigned long badvaddr = vcpu->arch.host_cp0_badvaddr;
 	enum emulation_result er = EMULATE_DONE;
+	u32 inst;
 	int ret = RESUME_GUEST;
 
 	/* re-enable HTW before enabling interrupts */
@@ -1472,8 +1473,12 @@ int kvm_mips_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
 		break;
 
 	default:
+		if (cause & CAUSEF_BD)
+			opc += 1;
+		inst = 0;
+		kvm_get_inst(opc, vcpu, &inst);
 		kvm_err("Exception Code: %d, not yet handled, @ PC: %p, inst: 0x%08x  BadVaddr: %#lx Status: %#lx\n",
-			exccode, opc, kvm_get_inst(opc, vcpu), badvaddr,
+			exccode, opc, inst, badvaddr,
 			kvm_read_c0_guest_status(vcpu->arch.cop0));
 		kvm_arch_vcpu_dump_regs(vcpu);
 		run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index aab604e75d3b..6379ac1bc7b9 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -503,16 +503,15 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 	local_irq_restore(flags);
 }
 
-u32 kvm_get_inst(u32 *opc, struct kvm_vcpu *vcpu)
+int kvm_get_inst(u32 *opc, struct kvm_vcpu *vcpu, u32 *out)
 {
-	u32 inst;
 	int err;
 
-	err = get_user(inst, opc);
+	err = get_user(*out, opc);
 	if (unlikely(err)) {
 		kvm_err("%s: illegal address: %p\n", __func__, opc);
-		return KVM_INVALID_INST;
+		return -EFAULT;
 	}
 
-	return inst;
+	return 0;
 }
-- 
git-series 0.8.10
