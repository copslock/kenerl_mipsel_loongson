Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jan 2017 15:47:24 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:34666 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992380AbdAFOqIfohPa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Jan 2017 15:46:08 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 49E7BBDFCBF49;
        Fri,  6 Jan 2017 14:45:59 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 6 Jan 2017 14:46:01 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 3/3] KVM: MIPS: Use CP0_BadInstr[P] for emulation
Date:   Fri, 6 Jan 2017 14:44:43 +0000
Message-ID: <32b64d3b2460bffb8bad3e5ff0cd4506f8890855.1483713106.git-series.james.hogan@imgtec.com>
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
X-archive-position: 56219
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

When exiting from the guest, store the values of the CP0_BadInstr and
CP0_BadInstrP registers if they exist, which contain the encodings of
the instructions which caused the last synchronous exception.

When the instruction is needed for emulation, kvm_get_badinstr() and
kvm_get_badinstrp() are used instead of calling kvm_get_inst() directly,
to decide whether to read the saved CP0_BadInstr/CP0_BadInstrP registers
(if they exist), or read the instruction from memory (if not).

The use of these registers should be more robust than using
kvm_get_inst(), as it actually gives the instruction encoding seen by
the hardware rather than relying on user accessors after the fact, which
can be fooled by incoherent icache or a racing code modification. It
will also work with VZ, where the guest virtual memory isn't directly
accessible by the host with user accessors.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h |  4 +++-
 arch/mips/kvm/emulate.c          | 48 ++++++++++++++++++++++++++++++---
 arch/mips/kvm/entry.c            | 14 ++++++++++-
 arch/mips/kvm/mips.c             |  2 +-
 4 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index b0936a4d931a..ac9d41900597 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -280,6 +280,8 @@ struct kvm_vcpu_arch {
 	unsigned long host_cp0_badvaddr;
 	unsigned long host_cp0_epc;
 	u32 host_cp0_cause;
+	u32 host_cp0_badinstr;
+	u32 host_cp0_badinstrp;
 
 	/* GPRS */
 	unsigned long gprs[32];
@@ -638,6 +640,8 @@ void kvm_trap_emul_invalidate_gva(struct kvm_vcpu *vcpu, unsigned long addr,
 /* Emulation */
 int kvm_get_inst(u32 *opc, struct kvm_vcpu *vcpu, u32 *out);
 enum emulation_result update_pc(struct kvm_vcpu *vcpu, u32 cause);
+int kvm_get_badinstr(u32 *opc, struct kvm_vcpu *vcpu, u32 *out);
+int kvm_get_badinstrp(u32 *opc, struct kvm_vcpu *vcpu, u32 *out);
 
 /**
  * kvm_is_ifetch_fault() - Find whether a TLBL exception is due to ifetch fault.
diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index b906fc0589f3..b295a4a1496f 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -54,7 +54,7 @@ static int kvm_compute_return_epc(struct kvm_vcpu *vcpu, unsigned long instpc,
 	}
 
 	/* Read the instruction */
-	err = kvm_get_inst((u32 *)epc, vcpu, &insn.word);
+	err = kvm_get_badinstrp((u32 *)epc, vcpu, &insn.word);
 	if (err)
 		return err;
 
@@ -259,6 +259,48 @@ enum emulation_result update_pc(struct kvm_vcpu *vcpu, u32 cause)
 }
 
 /**
+ * kvm_get_badinstr() - Get bad instruction encoding.
+ * @opc:	Guest pointer to faulting instruction.
+ * @vcpu:	KVM VCPU information.
+ *
+ * Gets the instruction encoding of the faulting instruction, using the saved
+ * BadInstr register value if it exists, otherwise falling back to reading guest
+ * memory at @opc.
+ *
+ * Returns:	The instruction encoding of the faulting instruction.
+ */
+int kvm_get_badinstr(u32 *opc, struct kvm_vcpu *vcpu, u32 *out)
+{
+	if (cpu_has_badinstr) {
+		*out = vcpu->arch.host_cp0_badinstr;
+		return 0;
+	} else {
+		return kvm_get_inst(opc, vcpu, out);
+	}
+}
+
+/**
+ * kvm_get_badinstrp() - Get bad prior instruction encoding.
+ * @opc:	Guest pointer to prior faulting instruction.
+ * @vcpu:	KVM VCPU information.
+ *
+ * Gets the instruction encoding of the prior faulting instruction (the branch
+ * containing the delay slot which faulted), using the saved BadInstrP register
+ * value if it exists, otherwise falling back to reading guest memory at @opc.
+ *
+ * Returns:	The instruction encoding of the prior faulting instruction.
+ */
+int kvm_get_badinstrp(u32 *opc, struct kvm_vcpu *vcpu, u32 *out)
+{
+	if (cpu_has_badinstrp) {
+		*out = vcpu->arch.host_cp0_badinstrp;
+		return 0;
+	} else {
+		return kvm_get_inst(opc, vcpu, out);
+	}
+}
+
+/**
  * kvm_mips_count_disabled() - Find whether the CP0_Count timer is disabled.
  * @vcpu:	Virtual CPU.
  *
@@ -1839,7 +1881,7 @@ enum emulation_result kvm_mips_emulate_inst(u32 cause, u32 *opc,
 	/* Fetch the instruction. */
 	if (cause & CAUSEF_BD)
 		opc += 1;
-	err = kvm_get_inst(opc, vcpu, &inst.word);
+	err = kvm_get_badinstr(opc, vcpu, &inst.word);
 	if (err)
 		return EMULATE_FAIL;
 
@@ -2434,7 +2476,7 @@ enum emulation_result kvm_mips_handle_ri(u32 cause, u32 *opc,
 	/* Fetch the instruction. */
 	if (cause & CAUSEF_BD)
 		opc += 1;
-	err = kvm_get_inst(opc, vcpu, &inst.word);
+	err = kvm_get_badinstr(opc, vcpu, &inst.word);
 	if (err) {
 		kvm_err("%s: Cannot get inst @ %p (%d)\n", __func__, opc, err);
 		return EMULATE_FAIL;
diff --git a/arch/mips/kvm/entry.c b/arch/mips/kvm/entry.c
index 1ae33e0e675c..c5b254c4d0da 100644
--- a/arch/mips/kvm/entry.c
+++ b/arch/mips/kvm/entry.c
@@ -53,6 +53,8 @@
 /* Some CP0 registers */
 #define C0_HWRENA	7, 0
 #define C0_BADVADDR	8, 0
+#define C0_BADINSTR	8, 1
+#define C0_BADINSTRP	8, 2
 #define C0_ENTRYHI	10, 0
 #define C0_STATUS	12, 0
 #define C0_CAUSE	13, 0
@@ -579,6 +581,18 @@ void *kvm_mips_build_exit(void *addr)
 	uasm_i_mfc0(&p, K0, C0_CAUSE);
 	uasm_i_sw(&p, K0, offsetof(struct kvm_vcpu_arch, host_cp0_cause), K1);
 
+	if (cpu_has_badinstr) {
+		uasm_i_mfc0(&p, K0, C0_BADINSTR);
+		uasm_i_sw(&p, K0, offsetof(struct kvm_vcpu_arch,
+					   host_cp0_badinstr), K1);
+	}
+
+	if (cpu_has_badinstrp) {
+		uasm_i_mfc0(&p, K0, C0_BADINSTRP);
+		uasm_i_sw(&p, K0, offsetof(struct kvm_vcpu_arch,
+					   host_cp0_badinstrp), K1);
+	}
+
 	/* Now restore the host state just enough to run the handlers */
 
 	/* Switch EBASE to the one used by Linux */
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 69775fb9c408..4dc6cf2b7c50 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -1476,7 +1476,7 @@ int kvm_mips_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
 		if (cause & CAUSEF_BD)
 			opc += 1;
 		inst = 0;
-		kvm_get_inst(opc, vcpu, &inst);
+		kvm_get_badinstr(opc, vcpu, &inst);
 		kvm_err("Exception Code: %d, not yet handled, @ PC: %p, inst: 0x%08x  BadVaddr: %#lx Status: %#lx\n",
 			exccode, opc, inst, badvaddr,
 			kvm_read_c0_guest_status(vcpu->arch.cop0));
-- 
git-series 0.8.10
