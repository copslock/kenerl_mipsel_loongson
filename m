Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Mar 2017 10:43:00 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:25287 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993876AbdCBJha0KjPt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Mar 2017 10:37:30 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 4E433A53BDEE9;
        Thu,  2 Mar 2017 09:37:20 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 2 Mar 2017 09:37:21 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 7/32] KVM: MIPS/Emulate: De-duplicate MMIO emulation
Date:   Thu, 2 Mar 2017 09:36:34 +0000
Message-ID: <4d4ab4801b9a0b2de6706046ab8321b24fdf3a51.1488447004.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.1
MIME-Version: 1.0
In-Reply-To: <cover.5cfb5298ebc2f5308f4f56aaac7fa31c39a8ab58.1488447004.git-series.james.hogan@imgtec.com>
References: <cover.5cfb5298ebc2f5308f4f56aaac7fa31c39a8ab58.1488447004.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56972
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

Refactor MIPS KVM MMIO load/store emulation to reduce code duplication.
Each duplicate differed slightly anyway, and it will simplify adding
64-bit MMIO support for VZ.

kvm_mips_emulate_store() and kvm_mips_emulate_load() can now return
EMULATE_DO_MMIO (as possibly originally intended). We therefore stop
calling either of these from kvm_mips_emulate_inst(), which is now only
used by kvm_trap_emul_handle_cop_unusable() which is picky about return
values.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/emulate.c | 206 +++++++++--------------------------------
 1 file changed, 50 insertions(+), 156 deletions(-)

diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index 637753ea0a00..e0f74ee2aad8 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -1477,9 +1477,8 @@ enum emulation_result kvm_mips_emulate_store(union mips_instruction inst,
 					     struct kvm_run *run,
 					     struct kvm_vcpu *vcpu)
 {
-	enum emulation_result er = EMULATE_DO_MMIO;
+	enum emulation_result er;
 	u32 rt;
-	u32 bytes;
 	void *data = run->mmio.data;
 	unsigned long curr_pc;
 
@@ -1494,103 +1493,63 @@ enum emulation_result kvm_mips_emulate_store(union mips_instruction inst,
 
 	rt = inst.i_format.rt;
 
-	switch (inst.i_format.opcode) {
-	case sb_op:
-		bytes = 1;
-		if (bytes > sizeof(run->mmio.data)) {
-			kvm_err("%s: bad MMIO length: %d\n", __func__,
-			       run->mmio.len);
-		}
-		run->mmio.phys_addr =
-		    kvm_mips_callbacks->gva_to_gpa(vcpu->arch.
-						   host_cp0_badvaddr);
-		if (run->mmio.phys_addr == KVM_INVALID_ADDR) {
-			er = EMULATE_FAIL;
-			break;
-		}
-		run->mmio.len = bytes;
-		run->mmio.is_write = 1;
-		vcpu->mmio_needed = 1;
-		vcpu->mmio_is_write = 1;
-		*(u8 *) data = vcpu->arch.gprs[rt];
-		kvm_debug("OP_SB: eaddr: %#lx, gpr: %#lx, data: %#x\n",
-			  vcpu->arch.host_cp0_badvaddr, vcpu->arch.gprs[rt],
-			  *(u8 *) data);
-
-		break;
+	run->mmio.phys_addr = kvm_mips_callbacks->gva_to_gpa(
+						vcpu->arch.host_cp0_badvaddr);
+	if (run->mmio.phys_addr == KVM_INVALID_ADDR)
+		goto out_fail;
 
+	switch (inst.i_format.opcode) {
 	case sw_op:
-		bytes = 4;
-		if (bytes > sizeof(run->mmio.data)) {
-			kvm_err("%s: bad MMIO length: %d\n", __func__,
-			       run->mmio.len);
-		}
-		run->mmio.phys_addr =
-		    kvm_mips_callbacks->gva_to_gpa(vcpu->arch.
-						   host_cp0_badvaddr);
-		if (run->mmio.phys_addr == KVM_INVALID_ADDR) {
-			er = EMULATE_FAIL;
-			break;
-		}
-
-		run->mmio.len = bytes;
-		run->mmio.is_write = 1;
-		vcpu->mmio_needed = 1;
-		vcpu->mmio_is_write = 1;
-		*(u32 *) data = vcpu->arch.gprs[rt];
+		run->mmio.len = 4;
+		*(u32 *)data = vcpu->arch.gprs[rt];
 
 		kvm_debug("[%#lx] OP_SW: eaddr: %#lx, gpr: %#lx, data: %#x\n",
 			  vcpu->arch.pc, vcpu->arch.host_cp0_badvaddr,
-			  vcpu->arch.gprs[rt], *(u32 *) data);
+			  vcpu->arch.gprs[rt], *(u32 *)data);
 		break;
 
 	case sh_op:
-		bytes = 2;
-		if (bytes > sizeof(run->mmio.data)) {
-			kvm_err("%s: bad MMIO length: %d\n", __func__,
-			       run->mmio.len);
-		}
-		run->mmio.phys_addr =
-		    kvm_mips_callbacks->gva_to_gpa(vcpu->arch.
-						   host_cp0_badvaddr);
-		if (run->mmio.phys_addr == KVM_INVALID_ADDR) {
-			er = EMULATE_FAIL;
-			break;
-		}
-
-		run->mmio.len = bytes;
-		run->mmio.is_write = 1;
-		vcpu->mmio_needed = 1;
-		vcpu->mmio_is_write = 1;
-		*(u16 *) data = vcpu->arch.gprs[rt];
+		run->mmio.len = 2;
+		*(u16 *)data = vcpu->arch.gprs[rt];
 
 		kvm_debug("[%#lx] OP_SH: eaddr: %#lx, gpr: %#lx, data: %#x\n",
 			  vcpu->arch.pc, vcpu->arch.host_cp0_badvaddr,
-			  vcpu->arch.gprs[rt], *(u32 *) data);
+			  vcpu->arch.gprs[rt], *(u16 *)data);
+		break;
+
+	case sb_op:
+		run->mmio.len = 1;
+		*(u8 *)data = vcpu->arch.gprs[rt];
+
+		kvm_debug("[%#lx] OP_SB: eaddr: %#lx, gpr: %#lx, data: %#x\n",
+			  vcpu->arch.pc, vcpu->arch.host_cp0_badvaddr,
+			  vcpu->arch.gprs[rt], *(u8 *)data);
 		break;
 
 	default:
 		kvm_err("Store not yet supported (inst=0x%08x)\n",
 			inst.word);
-		er = EMULATE_FAIL;
-		break;
+		goto out_fail;
 	}
 
-	/* Rollback PC if emulation was unsuccessful */
-	if (er == EMULATE_FAIL)
-		vcpu->arch.pc = curr_pc;
+	run->mmio.is_write = 1;
+	vcpu->mmio_needed = 1;
+	vcpu->mmio_is_write = 1;
+	return EMULATE_DO_MMIO;
 
-	return er;
+out_fail:
+	/* Rollback PC if emulation was unsuccessful */
+	vcpu->arch.pc = curr_pc;
+	return EMULATE_FAIL;
 }
 
 enum emulation_result kvm_mips_emulate_load(union mips_instruction inst,
 					    u32 cause, struct kvm_run *run,
 					    struct kvm_vcpu *vcpu)
 {
-	enum emulation_result er = EMULATE_DO_MMIO;
+	enum emulation_result er;
 	unsigned long curr_pc;
 	u32 op, rt;
-	u32 bytes;
 
 	rt = inst.i_format.rt;
 	op = inst.i_format.opcode;
@@ -1609,94 +1568,41 @@ enum emulation_result kvm_mips_emulate_load(union mips_instruction inst,
 
 	vcpu->arch.io_gpr = rt;
 
+	run->mmio.phys_addr = kvm_mips_callbacks->gva_to_gpa(
+						vcpu->arch.host_cp0_badvaddr);
+	if (run->mmio.phys_addr == KVM_INVALID_ADDR)
+		return EMULATE_FAIL;
+
+	vcpu->mmio_needed = 2;	/* signed */
 	switch (op) {
 	case lw_op:
-		bytes = 4;
-		if (bytes > sizeof(run->mmio.data)) {
-			kvm_err("%s: bad MMIO length: %d\n", __func__,
-			       run->mmio.len);
-			er = EMULATE_FAIL;
-			break;
-		}
-		run->mmio.phys_addr =
-		    kvm_mips_callbacks->gva_to_gpa(vcpu->arch.
-						   host_cp0_badvaddr);
-		if (run->mmio.phys_addr == KVM_INVALID_ADDR) {
-			er = EMULATE_FAIL;
-			break;
-		}
-
-		run->mmio.len = bytes;
-		run->mmio.is_write = 0;
-		vcpu->mmio_needed = 1;
-		vcpu->mmio_is_write = 0;
+		run->mmio.len = 4;
 		break;
 
-	case lh_op:
 	case lhu_op:
-		bytes = 2;
-		if (bytes > sizeof(run->mmio.data)) {
-			kvm_err("%s: bad MMIO length: %d\n", __func__,
-			       run->mmio.len);
-			er = EMULATE_FAIL;
-			break;
-		}
-		run->mmio.phys_addr =
-		    kvm_mips_callbacks->gva_to_gpa(vcpu->arch.
-						   host_cp0_badvaddr);
-		if (run->mmio.phys_addr == KVM_INVALID_ADDR) {
-			er = EMULATE_FAIL;
-			break;
-		}
-
-		run->mmio.len = bytes;
-		run->mmio.is_write = 0;
-		vcpu->mmio_needed = 1;
-		vcpu->mmio_is_write = 0;
-
-		if (op == lh_op)
-			vcpu->mmio_needed = 2;
-		else
-			vcpu->mmio_needed = 1;
-
+		vcpu->mmio_needed = 1;	/* unsigned */
+		/* fall through */
+	case lh_op:
+		run->mmio.len = 2;
 		break;
 
 	case lbu_op:
+		vcpu->mmio_needed = 1;	/* unsigned */
+		/* fall through */
 	case lb_op:
-		bytes = 1;
-		if (bytes > sizeof(run->mmio.data)) {
-			kvm_err("%s: bad MMIO length: %d\n", __func__,
-			       run->mmio.len);
-			er = EMULATE_FAIL;
-			break;
-		}
-		run->mmio.phys_addr =
-		    kvm_mips_callbacks->gva_to_gpa(vcpu->arch.
-						   host_cp0_badvaddr);
-		if (run->mmio.phys_addr == KVM_INVALID_ADDR) {
-			er = EMULATE_FAIL;
-			break;
-		}
-
-		run->mmio.len = bytes;
-		run->mmio.is_write = 0;
-		vcpu->mmio_is_write = 0;
-
-		if (op == lb_op)
-			vcpu->mmio_needed = 2;
-		else
-			vcpu->mmio_needed = 1;
-
+		run->mmio.len = 1;
 		break;
 
 	default:
 		kvm_err("Load not yet supported (inst=0x%08x)\n",
 			inst.word);
-		er = EMULATE_FAIL;
-		break;
+		vcpu->mmio_needed = 0;
+		return EMULATE_FAIL;
 	}
 
-	return er;
+	run->mmio.is_write = 0;
+	vcpu->mmio_is_write = 0;
+	return EMULATE_DO_MMIO;
 }
 
 static enum emulation_result kvm_mips_guest_cache_op(int (*fn)(unsigned long),
@@ -1873,18 +1779,6 @@ enum emulation_result kvm_mips_emulate_inst(u32 cause, u32 *opc,
 	case cop0_op:
 		er = kvm_mips_emulate_CP0(inst, opc, cause, run, vcpu);
 		break;
-	case sb_op:
-	case sh_op:
-	case sw_op:
-		er = kvm_mips_emulate_store(inst, cause, run, vcpu);
-		break;
-	case lb_op:
-	case lbu_op:
-	case lhu_op:
-	case lh_op:
-	case lw_op:
-		er = kvm_mips_emulate_load(inst, cause, run, vcpu);
-		break;
 
 #ifndef CONFIG_CPU_MIPSR6
 	case cache_op:
-- 
git-series 0.8.10
