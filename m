Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Mar 2017 10:50:58 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:19741 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993904AbdCBJhsrnqAt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Mar 2017 10:37:48 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 57F04BBD2AD25;
        Thu,  2 Mar 2017 09:37:39 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 2 Mar 2017 09:37:41 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, <linux-doc@vger.kernel.org>
Subject: [PATCH 30/32] KVM: MIPS/VZ: Emulate MAARs when necessary
Date:   Thu, 2 Mar 2017 09:36:57 +0000
Message-ID: <5a654608c6b78f79ba2a26797bf86a7f24d1f45d.1488447004.git-series.james.hogan@imgtec.com>
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
X-archive-position: 56992
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

Add emulation of Memory Accessibility Attribute Registers (MAARs) when
necessary. We can't actually do anything with whatever the guest
provides, but it may not be possible to clear Guest.Config5.MRP so we
have to emulate at least a pair of MAARs.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
Cc: linux-doc@vger.kernel.org
---
 Documentation/virtual/kvm/api.txt |   5 +-
 arch/mips/include/asm/kvm_host.h  |   5 +-
 arch/mips/include/uapi/asm/kvm.h  |  20 +++++-
 arch/mips/kvm/trace.h             |   2 +-
 arch/mips/kvm/vz.c                | 110 ++++++++++++++++++++++++++++++-
 5 files changed, 137 insertions(+), 5 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index a0430186dbd4..c4e43aeadb10 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2114,6 +2114,7 @@ registers, find a list below:
   MIPS  | KVM_REG_MIPS_CP0_KSCRATCH4    | 64
   MIPS  | KVM_REG_MIPS_CP0_KSCRATCH5    | 64
   MIPS  | KVM_REG_MIPS_CP0_KSCRATCH6    | 64
+  MIPS  | KVM_REG_MIPS_CP0_MAAR(0..63)  | 64
   MIPS  | KVM_REG_MIPS_COUNT_CTL        | 64
   MIPS  | KVM_REG_MIPS_COUNT_RESUME     | 64
   MIPS  | KVM_REG_MIPS_COUNT_HZ         | 64
@@ -2180,6 +2181,10 @@ hardware, host kernel, guest, and whether XPA is present in the guest, i.e.
 with the RI and XI bits (if they exist) in bits 63 and 62 respectively, and
 the PFNX field starting at bit 30.
 
+MIPS MAARs (see KVM_REG_MIPS_CP0_MAAR(*) above) have the following id bit
+patterns:
+  0x7030 0000 0001 01 <reg:8>
+
 MIPS KVM control registers (see above) have the following id bit patterns:
   0x7030 0000 0002 <reg:16>
 
diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 6b7d131565cd..3b381b52fd6c 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -67,6 +67,7 @@
 #define KVM_REG_MIPS_CP0_CONFIG4	MIPS_CP0_32(16, 4)
 #define KVM_REG_MIPS_CP0_CONFIG5	MIPS_CP0_32(16, 5)
 #define KVM_REG_MIPS_CP0_CONFIG7	MIPS_CP0_32(16, 7)
+#define KVM_REG_MIPS_CP0_MAARI		MIPS_CP0_64(17, 2)
 #define KVM_REG_MIPS_CP0_XCONTEXT	MIPS_CP0_64(20, 0)
 #define KVM_REG_MIPS_CP0_ERROREPC	MIPS_CP0_64(30, 0)
 #define KVM_REG_MIPS_CP0_KSCRATCH1	MIPS_CP0_64(31, 2)
@@ -391,6 +392,9 @@ struct kvm_vcpu_arch {
 	struct kvm_mips_tlb *wired_tlb;
 	unsigned int wired_tlb_limit;
 	unsigned int wired_tlb_used;
+
+	/* emulated guest MAAR registers */
+	unsigned long maar[6];
 #endif
 
 	/* Last CPU the VCPU state was loaded on */
@@ -711,6 +715,7 @@ __BUILD_KVM_RW_HW(config4,        32, MIPS_CP0_CONFIG,       4)
 __BUILD_KVM_RW_HW(config5,        32, MIPS_CP0_CONFIG,       5)
 __BUILD_KVM_RW_HW(config6,        32, MIPS_CP0_CONFIG,       6)
 __BUILD_KVM_RW_HW(config7,        32, MIPS_CP0_CONFIG,       7)
+__BUILD_KVM_RW_SW(maari,          l,  MIPS_CP0_LLADDR,       2)
 __BUILD_KVM_RW_HW(xcontext,       l,  MIPS_CP0_TLB_XCONTEXT, 0)
 __BUILD_KVM_RW_HW(errorepc,       l,  MIPS_CP0_ERROR_PC,     0)
 __BUILD_KVM_RW_HW(kscratch1,      l,  MIPS_CP0_DESAVE,       2)
diff --git a/arch/mips/include/uapi/asm/kvm.h b/arch/mips/include/uapi/asm/kvm.h
index a8a0199bf760..3107095d7f0a 100644
--- a/arch/mips/include/uapi/asm/kvm.h
+++ b/arch/mips/include/uapi/asm/kvm.h
@@ -54,9 +54,14 @@ struct kvm_fpu {
  * Register set = 0: GP registers from kvm_regs (see definitions below).
  *
  * Register set = 1: CP0 registers.
- *  bits[15..8]  - Must be zero.
- *  bits[7..3]   - Register 'rd'  index.
- *  bits[2..0]   - Register 'sel' index.
+ *  bits[15..8]  - COP0 register set.
+ *
+ *  COP0 register set = 0: Main CP0 registers.
+ *   bits[7..3]   - Register 'rd'  index.
+ *   bits[2..0]   - Register 'sel' index.
+ *
+ *  COP0 register set = 1: MAARs.
+ *   bits[7..0]   - MAAR index.
  *
  * Register set = 2: KVM specific registers (see definitions below).
  *
@@ -115,6 +120,15 @@ struct kvm_fpu {
 
 
 /*
+ * KVM_REG_MIPS_CP0 - Coprocessor 0 registers.
+ */
+
+#define KVM_REG_MIPS_MAAR	(KVM_REG_MIPS_CP0 | (1 << 8))
+#define KVM_REG_MIPS_CP0_MAAR(n)	(KVM_REG_MIPS_MAAR | \
+					 KVM_REG_SIZE_U64 | (n))
+
+
+/*
  * KVM_REG_MIPS_KVM - KVM specific control registers.
  */
 
diff --git a/arch/mips/kvm/trace.h b/arch/mips/kvm/trace.h
index d80d37a1b82e..affde8a2c584 100644
--- a/arch/mips/kvm/trace.h
+++ b/arch/mips/kvm/trace.h
@@ -176,6 +176,8 @@ TRACE_EVENT(kvm_exit,
 	{ KVM_TRACE_COP0(16, 4),	"Config4" },		\
 	{ KVM_TRACE_COP0(16, 5),	"Config5" },		\
 	{ KVM_TRACE_COP0(16, 7),	"Config7" },		\
+	{ KVM_TRACE_COP0(17, 1),	"MAAR" },		\
+	{ KVM_TRACE_COP0(17, 2),	"MAARI" },		\
 	{ KVM_TRACE_COP0(26, 0),	"ECC" },		\
 	{ KVM_TRACE_COP0(30, 0),	"ErrorEPC" },		\
 	{ KVM_TRACE_COP0(31, 2),	"KScratch1" },		\
diff --git a/arch/mips/kvm/vz.c b/arch/mips/kvm/vz.c
index 1a7f15222d6f..c859295c0526 100644
--- a/arch/mips/kvm/vz.c
+++ b/arch/mips/kvm/vz.c
@@ -134,7 +134,7 @@ static inline unsigned int kvm_vz_config5_guest_wrmask(struct kvm_vcpu *vcpu)
  * Config3:	M, MSAP, [BPG], ULRI, [DSP2P, DSPP], CTXTC, [ITL, LPA, VEIC,
  *		VInt, SP, CDMM, MT, SM, TL]
  * Config4:	M, [VTLBSizeExt, MMUSizeExt]
- * Config5:	[MRP]
+ * Config5:	MRP
  */
 
 static inline unsigned int kvm_vz_config_user_wrmask(struct kvm_vcpu *vcpu)
@@ -177,7 +177,7 @@ static inline unsigned int kvm_vz_config4_user_wrmask(struct kvm_vcpu *vcpu)
 
 static inline unsigned int kvm_vz_config5_user_wrmask(struct kvm_vcpu *vcpu)
 {
-	return kvm_vz_config5_guest_wrmask(vcpu);
+	return kvm_vz_config5_guest_wrmask(vcpu) | MIPS_CONF5_MRP;
 }
 
 static gpa_t kvm_vz_gva_to_gpa_cb(gva_t gva)
@@ -685,6 +685,41 @@ static int kvm_trap_vz_no_handler(struct kvm_vcpu *vcpu)
 	return RESUME_HOST;
 }
 
+static unsigned long mips_process_maar(unsigned int op, unsigned long val)
+{
+	/* Mask off unused bits */
+	unsigned long mask = 0xfffff000 | MIPS_MAAR_S | MIPS_MAAR_VL;
+
+	if (read_gc0_pagegrain() & PG_ELPA)
+		mask |= 0x00ffffff00000000ull;
+	if (cpu_guest_has_mvh)
+		mask |= MIPS_MAAR_VH;
+
+	/* Set or clear VH */
+	if (op == mtc_op) {
+		/* clear VH */
+		val &= ~MIPS_MAAR_VH;
+	} else if (op == dmtc_op) {
+		/* set VH to match VL */
+		val &= ~MIPS_MAAR_VH;
+		if (val & MIPS_MAAR_VL)
+			val |= MIPS_MAAR_VH;
+	}
+
+	return val & mask;
+}
+
+static void kvm_write_maari(struct kvm_vcpu *vcpu, unsigned long val)
+{
+	struct mips_coproc *cop0 = vcpu->arch.cop0;
+
+	val &= MIPS_MAARI_INDEX;
+	if (val == MIPS_MAARI_INDEX)
+		kvm_write_sw_gc0_maari(cop0, ARRAY_SIZE(vcpu->arch.maar) - 1);
+	else if (val < ARRAY_SIZE(vcpu->arch.maar))
+		kvm_write_sw_gc0_maari(cop0, val);
+}
+
 static enum emulation_result kvm_vz_gpsi_cop0(union mips_instruction inst,
 					      u32 *opc, u32 cause,
 					      struct kvm_run *run,
@@ -737,6 +772,15 @@ static enum emulation_result kvm_vz_gpsi_cop0(union mips_instruction inst,
 						MIPS_LLADDR_LLB;
 				else
 					val = 0;
+			} else if (rd == MIPS_CP0_LLADDR &&
+				   sel == 1 &&		/* MAAR */
+				   cpu_guest_has_maar &&
+				   !cpu_guest_has_dyn_maar) {
+				/* MAARI must be in range */
+				BUG_ON(kvm_read_sw_gc0_maari(cop0) >=
+						ARRAY_SIZE(vcpu->arch.maar));
+				val = vcpu->arch.maar[
+					kvm_read_sw_gc0_maari(cop0)];
 			} else if ((rd == MIPS_CP0_PRID &&
 				    (sel == 0 ||	/* PRid */
 				     sel == 2 ||	/* CDMMBase */
@@ -746,6 +790,10 @@ static enum emulation_result kvm_vz_gpsi_cop0(union mips_instruction inst,
 				     sel == 3)) ||	/* SRSMap */
 				   (rd == MIPS_CP0_CONFIG &&
 				    (sel == 7)) ||	/* Config7 */
+				   (rd == MIPS_CP0_LLADDR &&
+				    (sel == 2) &&	/* MAARI */
+				    cpu_guest_has_maar &&
+				    !cpu_guest_has_dyn_maar) ||
 				   (rd == MIPS_CP0_ERRCTL &&
 				    (sel == 0))) {	/* ErrCtl */
 				val = cop0->reg[rd][sel];
@@ -793,6 +841,23 @@ static enum emulation_result kvm_vz_gpsi_cop0(union mips_instruction inst,
 				if (cpu_guest_has_rw_llb &&
 				    !(val & MIPS_LLADDR_LLB))
 					write_gc0_lladdr(0);
+			} else if (rd == MIPS_CP0_LLADDR &&
+				   sel == 1 &&		/* MAAR */
+				   cpu_guest_has_maar &&
+				   !cpu_guest_has_dyn_maar) {
+				val = mips_process_maar(inst.c0r_format.rs,
+							val);
+
+				/* MAARI must be in range */
+				BUG_ON(kvm_read_sw_gc0_maari(cop0) >=
+						ARRAY_SIZE(vcpu->arch.maar));
+				vcpu->arch.maar[kvm_read_sw_gc0_maari(cop0)] =
+									val;
+			} else if (rd == MIPS_CP0_LLADDR &&
+				   (sel == 2) &&	/* MAARI */
+				   cpu_guest_has_maar &&
+				   !cpu_guest_has_dyn_maar) {
+				kvm_write_maari(vcpu, val);
 			} else if (rd == MIPS_CP0_ERRCTL &&
 				   (sel == 0)) {	/* ErrCtl */
 				/* ignore the written value */
@@ -1440,6 +1505,8 @@ static unsigned long kvm_vz_num_regs(struct kvm_vcpu *vcpu)
 		ret += ARRAY_SIZE(kvm_vz_get_one_regs_segments);
 	if (cpu_guest_has_htw)
 		ret += ARRAY_SIZE(kvm_vz_get_one_regs_htw);
+	if (cpu_guest_has_maar && !cpu_guest_has_dyn_maar)
+		ret += 1 + ARRAY_SIZE(vcpu->arch.maar);
 	ret += __arch_hweight8(cpu_data[0].guest.kscratch_mask);
 
 	return ret;
@@ -1491,6 +1558,19 @@ static int kvm_vz_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *indices)
 			return -EFAULT;
 		indices += ARRAY_SIZE(kvm_vz_get_one_regs_htw);
 	}
+	if (cpu_guest_has_maar && !cpu_guest_has_dyn_maar) {
+		for (i = 0; i < ARRAY_SIZE(vcpu->arch.maar); ++i) {
+			index = KVM_REG_MIPS_CP0_MAAR(i);
+			if (copy_to_user(indices, &index, sizeof(index)))
+				return -EFAULT;
+			++indices;
+		}
+
+		index = KVM_REG_MIPS_CP0_MAARI;
+		if (copy_to_user(indices, &index, sizeof(index)))
+			return -EFAULT;
+		++indices;
+	}
 	for (i = 0; i < 6; ++i) {
 		if (!cpu_guest_has_kscr(i + 2))
 			continue;
@@ -1688,6 +1768,19 @@ static int kvm_vz_get_one_reg(struct kvm_vcpu *vcpu,
 			return -EINVAL;
 		*v = read_gc0_config5();
 		break;
+	case KVM_REG_MIPS_CP0_MAAR(0) ... KVM_REG_MIPS_CP0_MAAR(0x3f):
+		if (!cpu_guest_has_maar || cpu_guest_has_dyn_maar)
+			return -EINVAL;
+		idx = reg->id - KVM_REG_MIPS_CP0_MAAR(0);
+		if (idx >= ARRAY_SIZE(vcpu->arch.maar))
+			return -EINVAL;
+		*v = vcpu->arch.maar[idx];
+		break;
+	case KVM_REG_MIPS_CP0_MAARI:
+		if (!cpu_guest_has_maar || cpu_guest_has_dyn_maar)
+			return -EINVAL;
+		*v = kvm_read_sw_gc0_maari(vcpu->arch.cop0);
+		break;
 #ifdef CONFIG_64BIT
 	case KVM_REG_MIPS_CP0_XCONTEXT:
 		*v = read_gc0_xcontext();
@@ -1937,6 +2030,19 @@ static int kvm_vz_set_one_reg(struct kvm_vcpu *vcpu,
 			write_gc0_config5(v);
 		}
 		break;
+	case KVM_REG_MIPS_CP0_MAAR(0) ... KVM_REG_MIPS_CP0_MAAR(0x3f):
+		if (!cpu_guest_has_maar || cpu_guest_has_dyn_maar)
+			return -EINVAL;
+		idx = reg->id - KVM_REG_MIPS_CP0_MAAR(0);
+		if (idx >= ARRAY_SIZE(vcpu->arch.maar))
+			return -EINVAL;
+		vcpu->arch.maar[idx] = mips_process_maar(dmtc_op, v);
+		break;
+	case KVM_REG_MIPS_CP0_MAARI:
+		if (!cpu_guest_has_maar || cpu_guest_has_dyn_maar)
+			return -EINVAL;
+		kvm_write_maari(vcpu, v);
+		break;
 #ifdef CONFIG_64BIT
 	case KVM_REG_MIPS_CP0_XCONTEXT:
 		write_gc0_xcontext(v);
-- 
git-series 0.8.10
