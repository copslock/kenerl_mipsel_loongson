Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Feb 2017 15:20:56 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:26901 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992244AbdBAOTnSra7g (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Feb 2017 15:19:43 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id EB2A0CEAD8479;
        Wed,  1 Feb 2017 14:19:30 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 1 Feb 2017 14:19:34 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 1/5] KVM: MIPS/T&E: Move CP0 register access into T&E
Date:   Wed, 1 Feb 2017 14:19:23 +0000
Message-ID: <5b75b2f581d6b2162cb2fad00056f4bf033ab760.1485958267.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
In-Reply-To: <cover.7aeb0f08d03b5d18b5332cdb1b38a8f057d310ac.1485958267.git-series.james.hogan@imgtec.com>
References: <cover.7aeb0f08d03b5d18b5332cdb1b38a8f057d310ac.1485958267.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56576
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

Access to various CP0 registers via the KVM register access API needs to
be implementation specific to allow restrictions to be made on changes,
for example when VZ guest registers aren't present, so move them all
into trap_emul.c in preparation for VZ.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h |   1 +-
 arch/mips/kvm/emulate.c          |   2 +-
 arch/mips/kvm/mips.c             | 198 +--------------------------------
 arch/mips/kvm/trap_emul.c        | 181 ++++++++++++++++++++++++++++-
 4 files changed, 179 insertions(+), 203 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 31e7f3797f52..c6922762ff1a 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -345,7 +345,6 @@ struct kvm_vcpu_arch {
 
 	u8 fpu_enabled;
 	u8 msa_enabled;
-	u8 kscratch_enabled;
 };
 
 
diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index b6cafb0a9df4..f2b054b80bca 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -1066,7 +1066,7 @@ unsigned int kvm_mips_config4_wrmask(struct kvm_vcpu *vcpu)
 	unsigned int mask = MIPS_CONF_M;
 
 	/* KScrExist */
-	mask |= (unsigned int)vcpu->arch.kscratch_enabled << 16;
+	mask |= 0xfc << MIPS_CONF4_KSCREXIST_SHIFT;
 
 	return mask;
 }
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index cf501a5a0dfe..d95b36c1e710 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -520,33 +520,6 @@ static u64 kvm_mips_get_one_regs[] = {
 	KVM_REG_MIPS_LO,
 #endif
 	KVM_REG_MIPS_PC,
-
-	KVM_REG_MIPS_CP0_INDEX,
-	KVM_REG_MIPS_CP0_CONTEXT,
-	KVM_REG_MIPS_CP0_USERLOCAL,
-	KVM_REG_MIPS_CP0_PAGEMASK,
-	KVM_REG_MIPS_CP0_WIRED,
-	KVM_REG_MIPS_CP0_HWRENA,
-	KVM_REG_MIPS_CP0_BADVADDR,
-	KVM_REG_MIPS_CP0_COUNT,
-	KVM_REG_MIPS_CP0_ENTRYHI,
-	KVM_REG_MIPS_CP0_COMPARE,
-	KVM_REG_MIPS_CP0_STATUS,
-	KVM_REG_MIPS_CP0_CAUSE,
-	KVM_REG_MIPS_CP0_EPC,
-	KVM_REG_MIPS_CP0_PRID,
-	KVM_REG_MIPS_CP0_CONFIG,
-	KVM_REG_MIPS_CP0_CONFIG1,
-	KVM_REG_MIPS_CP0_CONFIG2,
-	KVM_REG_MIPS_CP0_CONFIG3,
-	KVM_REG_MIPS_CP0_CONFIG4,
-	KVM_REG_MIPS_CP0_CONFIG5,
-	KVM_REG_MIPS_CP0_CONFIG7,
-	KVM_REG_MIPS_CP0_ERROREPC,
-
-	KVM_REG_MIPS_COUNT_CTL,
-	KVM_REG_MIPS_COUNT_RESUME,
-	KVM_REG_MIPS_COUNT_HZ,
 };
 
 static u64 kvm_mips_get_one_regs_fpu[] = {
@@ -559,15 +532,6 @@ static u64 kvm_mips_get_one_regs_msa[] = {
 	KVM_REG_MIPS_MSA_CSR,
 };
 
-static u64 kvm_mips_get_one_regs_kscratch[] = {
-	KVM_REG_MIPS_CP0_KSCRATCH1,
-	KVM_REG_MIPS_CP0_KSCRATCH2,
-	KVM_REG_MIPS_CP0_KSCRATCH3,
-	KVM_REG_MIPS_CP0_KSCRATCH4,
-	KVM_REG_MIPS_CP0_KSCRATCH5,
-	KVM_REG_MIPS_CP0_KSCRATCH6,
-};
-
 static unsigned long kvm_mips_num_regs(struct kvm_vcpu *vcpu)
 {
 	unsigned long ret;
@@ -581,7 +545,6 @@ static unsigned long kvm_mips_num_regs(struct kvm_vcpu *vcpu)
 	}
 	if (kvm_mips_guest_can_have_msa(&vcpu->arch))
 		ret += ARRAY_SIZE(kvm_mips_get_one_regs_msa) + 32;
-	ret += __arch_hweight8(vcpu->arch.kscratch_enabled);
 	ret += kvm_mips_callbacks->num_regs(vcpu);
 
 	return ret;
@@ -634,16 +597,6 @@ static int kvm_mips_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *indices)
 		}
 	}
 
-	for (i = 0; i < 6; ++i) {
-		if (!(vcpu->arch.kscratch_enabled & BIT(i + 2)))
-			continue;
-
-		if (copy_to_user(indices, &kvm_mips_get_one_regs_kscratch[i],
-				 sizeof(kvm_mips_get_one_regs_kscratch[i])))
-			return -EFAULT;
-		++indices;
-	}
-
 	return kvm_mips_callbacks->copy_reg_indices(vcpu, indices);
 }
 
@@ -734,95 +687,6 @@ static int kvm_mips_get_reg(struct kvm_vcpu *vcpu,
 		v = fpu->msacsr;
 		break;
 
-	/* Co-processor 0 registers */
-	case KVM_REG_MIPS_CP0_INDEX:
-		v = (long)kvm_read_c0_guest_index(cop0);
-		break;
-	case KVM_REG_MIPS_CP0_CONTEXT:
-		v = (long)kvm_read_c0_guest_context(cop0);
-		break;
-	case KVM_REG_MIPS_CP0_USERLOCAL:
-		v = (long)kvm_read_c0_guest_userlocal(cop0);
-		break;
-	case KVM_REG_MIPS_CP0_PAGEMASK:
-		v = (long)kvm_read_c0_guest_pagemask(cop0);
-		break;
-	case KVM_REG_MIPS_CP0_WIRED:
-		v = (long)kvm_read_c0_guest_wired(cop0);
-		break;
-	case KVM_REG_MIPS_CP0_HWRENA:
-		v = (long)kvm_read_c0_guest_hwrena(cop0);
-		break;
-	case KVM_REG_MIPS_CP0_BADVADDR:
-		v = (long)kvm_read_c0_guest_badvaddr(cop0);
-		break;
-	case KVM_REG_MIPS_CP0_ENTRYHI:
-		v = (long)kvm_read_c0_guest_entryhi(cop0);
-		break;
-	case KVM_REG_MIPS_CP0_COMPARE:
-		v = (long)kvm_read_c0_guest_compare(cop0);
-		break;
-	case KVM_REG_MIPS_CP0_STATUS:
-		v = (long)kvm_read_c0_guest_status(cop0);
-		break;
-	case KVM_REG_MIPS_CP0_CAUSE:
-		v = (long)kvm_read_c0_guest_cause(cop0);
-		break;
-	case KVM_REG_MIPS_CP0_EPC:
-		v = (long)kvm_read_c0_guest_epc(cop0);
-		break;
-	case KVM_REG_MIPS_CP0_PRID:
-		v = (long)kvm_read_c0_guest_prid(cop0);
-		break;
-	case KVM_REG_MIPS_CP0_CONFIG:
-		v = (long)kvm_read_c0_guest_config(cop0);
-		break;
-	case KVM_REG_MIPS_CP0_CONFIG1:
-		v = (long)kvm_read_c0_guest_config1(cop0);
-		break;
-	case KVM_REG_MIPS_CP0_CONFIG2:
-		v = (long)kvm_read_c0_guest_config2(cop0);
-		break;
-	case KVM_REG_MIPS_CP0_CONFIG3:
-		v = (long)kvm_read_c0_guest_config3(cop0);
-		break;
-	case KVM_REG_MIPS_CP0_CONFIG4:
-		v = (long)kvm_read_c0_guest_config4(cop0);
-		break;
-	case KVM_REG_MIPS_CP0_CONFIG5:
-		v = (long)kvm_read_c0_guest_config5(cop0);
-		break;
-	case KVM_REG_MIPS_CP0_CONFIG7:
-		v = (long)kvm_read_c0_guest_config7(cop0);
-		break;
-	case KVM_REG_MIPS_CP0_ERROREPC:
-		v = (long)kvm_read_c0_guest_errorepc(cop0);
-		break;
-	case KVM_REG_MIPS_CP0_KSCRATCH1 ... KVM_REG_MIPS_CP0_KSCRATCH6:
-		idx = reg->id - KVM_REG_MIPS_CP0_KSCRATCH1 + 2;
-		if (!(vcpu->arch.kscratch_enabled & BIT(idx)))
-			return -EINVAL;
-		switch (idx) {
-		case 2:
-			v = (long)kvm_read_c0_guest_kscratch1(cop0);
-			break;
-		case 3:
-			v = (long)kvm_read_c0_guest_kscratch2(cop0);
-			break;
-		case 4:
-			v = (long)kvm_read_c0_guest_kscratch3(cop0);
-			break;
-		case 5:
-			v = (long)kvm_read_c0_guest_kscratch4(cop0);
-			break;
-		case 6:
-			v = (long)kvm_read_c0_guest_kscratch5(cop0);
-			break;
-		case 7:
-			v = (long)kvm_read_c0_guest_kscratch6(cop0);
-			break;
-		}
-		break;
 	/* registers to be handled specially */
 	default:
 		ret = kvm_mips_callbacks->get_one_reg(vcpu, reg, &v);
@@ -954,68 +818,6 @@ static int kvm_mips_set_reg(struct kvm_vcpu *vcpu,
 		fpu->msacsr = v;
 		break;
 
-	/* Co-processor 0 registers */
-	case KVM_REG_MIPS_CP0_INDEX:
-		kvm_write_c0_guest_index(cop0, v);
-		break;
-	case KVM_REG_MIPS_CP0_CONTEXT:
-		kvm_write_c0_guest_context(cop0, v);
-		break;
-	case KVM_REG_MIPS_CP0_USERLOCAL:
-		kvm_write_c0_guest_userlocal(cop0, v);
-		break;
-	case KVM_REG_MIPS_CP0_PAGEMASK:
-		kvm_write_c0_guest_pagemask(cop0, v);
-		break;
-	case KVM_REG_MIPS_CP0_WIRED:
-		kvm_write_c0_guest_wired(cop0, v);
-		break;
-	case KVM_REG_MIPS_CP0_HWRENA:
-		kvm_write_c0_guest_hwrena(cop0, v);
-		break;
-	case KVM_REG_MIPS_CP0_BADVADDR:
-		kvm_write_c0_guest_badvaddr(cop0, v);
-		break;
-	case KVM_REG_MIPS_CP0_ENTRYHI:
-		kvm_write_c0_guest_entryhi(cop0, v);
-		break;
-	case KVM_REG_MIPS_CP0_STATUS:
-		kvm_write_c0_guest_status(cop0, v);
-		break;
-	case KVM_REG_MIPS_CP0_EPC:
-		kvm_write_c0_guest_epc(cop0, v);
-		break;
-	case KVM_REG_MIPS_CP0_PRID:
-		kvm_write_c0_guest_prid(cop0, v);
-		break;
-	case KVM_REG_MIPS_CP0_ERROREPC:
-		kvm_write_c0_guest_errorepc(cop0, v);
-		break;
-	case KVM_REG_MIPS_CP0_KSCRATCH1 ... KVM_REG_MIPS_CP0_KSCRATCH6:
-		idx = reg->id - KVM_REG_MIPS_CP0_KSCRATCH1 + 2;
-		if (!(vcpu->arch.kscratch_enabled & BIT(idx)))
-			return -EINVAL;
-		switch (idx) {
-		case 2:
-			kvm_write_c0_guest_kscratch1(cop0, v);
-			break;
-		case 3:
-			kvm_write_c0_guest_kscratch2(cop0, v);
-			break;
-		case 4:
-			kvm_write_c0_guest_kscratch3(cop0, v);
-			break;
-		case 5:
-			kvm_write_c0_guest_kscratch4(cop0, v);
-			break;
-		case 6:
-			kvm_write_c0_guest_kscratch5(cop0, v);
-			break;
-		case 7:
-			kvm_write_c0_guest_kscratch6(cop0, v);
-			break;
-		}
-		break;
 	/* registers to be handled specially */
 	default:
 		return kvm_mips_callbacks->set_one_reg(vcpu, reg, v);
diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index da5acd0ac005..653d03aa7e0b 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -489,8 +489,6 @@ static int kvm_trap_emul_vcpu_init(struct kvm_vcpu *vcpu)
 	struct mm_struct *kern_mm = &vcpu->arch.guest_kernel_mm;
 	struct mm_struct *user_mm = &vcpu->arch.guest_user_mm;
 
-	vcpu->arch.kscratch_enabled = 0xfc;
-
 	/*
 	 * Allocate GVA -> HPA page tables.
 	 * MIPS doesn't use the mm_struct pointer argument.
@@ -640,14 +638,54 @@ static void kvm_trap_emul_flush_shadow_memslot(struct kvm *kvm,
 	kvm_trap_emul_flush_shadow_all(kvm);
 }
 
+static u64 kvm_trap_emul_get_one_regs[] = {
+	KVM_REG_MIPS_CP0_INDEX,
+	KVM_REG_MIPS_CP0_CONTEXT,
+	KVM_REG_MIPS_CP0_USERLOCAL,
+	KVM_REG_MIPS_CP0_PAGEMASK,
+	KVM_REG_MIPS_CP0_WIRED,
+	KVM_REG_MIPS_CP0_HWRENA,
+	KVM_REG_MIPS_CP0_BADVADDR,
+	KVM_REG_MIPS_CP0_COUNT,
+	KVM_REG_MIPS_CP0_ENTRYHI,
+	KVM_REG_MIPS_CP0_COMPARE,
+	KVM_REG_MIPS_CP0_STATUS,
+	KVM_REG_MIPS_CP0_CAUSE,
+	KVM_REG_MIPS_CP0_EPC,
+	KVM_REG_MIPS_CP0_PRID,
+	KVM_REG_MIPS_CP0_CONFIG,
+	KVM_REG_MIPS_CP0_CONFIG1,
+	KVM_REG_MIPS_CP0_CONFIG2,
+	KVM_REG_MIPS_CP0_CONFIG3,
+	KVM_REG_MIPS_CP0_CONFIG4,
+	KVM_REG_MIPS_CP0_CONFIG5,
+	KVM_REG_MIPS_CP0_CONFIG7,
+	KVM_REG_MIPS_CP0_ERROREPC,
+	KVM_REG_MIPS_CP0_KSCRATCH1,
+	KVM_REG_MIPS_CP0_KSCRATCH2,
+	KVM_REG_MIPS_CP0_KSCRATCH3,
+	KVM_REG_MIPS_CP0_KSCRATCH4,
+	KVM_REG_MIPS_CP0_KSCRATCH5,
+	KVM_REG_MIPS_CP0_KSCRATCH6,
+
+	KVM_REG_MIPS_COUNT_CTL,
+	KVM_REG_MIPS_COUNT_RESUME,
+	KVM_REG_MIPS_COUNT_HZ,
+};
+
 static unsigned long kvm_trap_emul_num_regs(struct kvm_vcpu *vcpu)
 {
-	return 0;
+	return ARRAY_SIZE(kvm_trap_emul_get_one_regs);
 }
 
 static int kvm_trap_emul_copy_reg_indices(struct kvm_vcpu *vcpu,
 					  u64 __user *indices)
 {
+	if (copy_to_user(indices, kvm_trap_emul_get_one_regs,
+			 sizeof(kvm_trap_emul_get_one_regs)))
+		return -EFAULT;
+	indices += ARRAY_SIZE(kvm_trap_emul_get_one_regs);
+
 	return 0;
 }
 
@@ -655,7 +693,69 @@ static int kvm_trap_emul_get_one_reg(struct kvm_vcpu *vcpu,
 				     const struct kvm_one_reg *reg,
 				     s64 *v)
 {
+	struct mips_coproc *cop0 = vcpu->arch.cop0;
+
 	switch (reg->id) {
+	case KVM_REG_MIPS_CP0_INDEX:
+		*v = (long)kvm_read_c0_guest_index(cop0);
+		break;
+	case KVM_REG_MIPS_CP0_CONTEXT:
+		*v = (long)kvm_read_c0_guest_context(cop0);
+		break;
+	case KVM_REG_MIPS_CP0_USERLOCAL:
+		*v = (long)kvm_read_c0_guest_userlocal(cop0);
+		break;
+	case KVM_REG_MIPS_CP0_PAGEMASK:
+		*v = (long)kvm_read_c0_guest_pagemask(cop0);
+		break;
+	case KVM_REG_MIPS_CP0_WIRED:
+		*v = (long)kvm_read_c0_guest_wired(cop0);
+		break;
+	case KVM_REG_MIPS_CP0_HWRENA:
+		*v = (long)kvm_read_c0_guest_hwrena(cop0);
+		break;
+	case KVM_REG_MIPS_CP0_BADVADDR:
+		*v = (long)kvm_read_c0_guest_badvaddr(cop0);
+		break;
+	case KVM_REG_MIPS_CP0_ENTRYHI:
+		*v = (long)kvm_read_c0_guest_entryhi(cop0);
+		break;
+	case KVM_REG_MIPS_CP0_COMPARE:
+		*v = (long)kvm_read_c0_guest_compare(cop0);
+		break;
+	case KVM_REG_MIPS_CP0_STATUS:
+		*v = (long)kvm_read_c0_guest_status(cop0);
+		break;
+	case KVM_REG_MIPS_CP0_CAUSE:
+		*v = (long)kvm_read_c0_guest_cause(cop0);
+		break;
+	case KVM_REG_MIPS_CP0_EPC:
+		*v = (long)kvm_read_c0_guest_epc(cop0);
+		break;
+	case KVM_REG_MIPS_CP0_PRID:
+		*v = (long)kvm_read_c0_guest_prid(cop0);
+		break;
+	case KVM_REG_MIPS_CP0_CONFIG:
+		*v = (long)kvm_read_c0_guest_config(cop0);
+		break;
+	case KVM_REG_MIPS_CP0_CONFIG1:
+		*v = (long)kvm_read_c0_guest_config1(cop0);
+		break;
+	case KVM_REG_MIPS_CP0_CONFIG2:
+		*v = (long)kvm_read_c0_guest_config2(cop0);
+		break;
+	case KVM_REG_MIPS_CP0_CONFIG3:
+		*v = (long)kvm_read_c0_guest_config3(cop0);
+		break;
+	case KVM_REG_MIPS_CP0_CONFIG4:
+		*v = (long)kvm_read_c0_guest_config4(cop0);
+		break;
+	case KVM_REG_MIPS_CP0_CONFIG5:
+		*v = (long)kvm_read_c0_guest_config5(cop0);
+		break;
+	case KVM_REG_MIPS_CP0_CONFIG7:
+		*v = (long)kvm_read_c0_guest_config7(cop0);
+		break;
 	case KVM_REG_MIPS_CP0_COUNT:
 		*v = kvm_mips_read_count(vcpu);
 		break;
@@ -668,6 +768,27 @@ static int kvm_trap_emul_get_one_reg(struct kvm_vcpu *vcpu,
 	case KVM_REG_MIPS_COUNT_HZ:
 		*v = vcpu->arch.count_hz;
 		break;
+	case KVM_REG_MIPS_CP0_ERROREPC:
+		*v = (long)kvm_read_c0_guest_errorepc(cop0);
+		break;
+	case KVM_REG_MIPS_CP0_KSCRATCH1:
+		*v = (long)kvm_read_c0_guest_kscratch1(cop0);
+		break;
+	case KVM_REG_MIPS_CP0_KSCRATCH2:
+		*v = (long)kvm_read_c0_guest_kscratch2(cop0);
+		break;
+	case KVM_REG_MIPS_CP0_KSCRATCH3:
+		*v = (long)kvm_read_c0_guest_kscratch3(cop0);
+		break;
+	case KVM_REG_MIPS_CP0_KSCRATCH4:
+		*v = (long)kvm_read_c0_guest_kscratch4(cop0);
+		break;
+	case KVM_REG_MIPS_CP0_KSCRATCH5:
+		*v = (long)kvm_read_c0_guest_kscratch5(cop0);
+		break;
+	case KVM_REG_MIPS_CP0_KSCRATCH6:
+		*v = (long)kvm_read_c0_guest_kscratch6(cop0);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -683,6 +804,39 @@ static int kvm_trap_emul_set_one_reg(struct kvm_vcpu *vcpu,
 	unsigned int cur, change;
 
 	switch (reg->id) {
+	case KVM_REG_MIPS_CP0_INDEX:
+		kvm_write_c0_guest_index(cop0, v);
+		break;
+	case KVM_REG_MIPS_CP0_CONTEXT:
+		kvm_write_c0_guest_context(cop0, v);
+		break;
+	case KVM_REG_MIPS_CP0_USERLOCAL:
+		kvm_write_c0_guest_userlocal(cop0, v);
+		break;
+	case KVM_REG_MIPS_CP0_PAGEMASK:
+		kvm_write_c0_guest_pagemask(cop0, v);
+		break;
+	case KVM_REG_MIPS_CP0_WIRED:
+		kvm_write_c0_guest_wired(cop0, v);
+		break;
+	case KVM_REG_MIPS_CP0_HWRENA:
+		kvm_write_c0_guest_hwrena(cop0, v);
+		break;
+	case KVM_REG_MIPS_CP0_BADVADDR:
+		kvm_write_c0_guest_badvaddr(cop0, v);
+		break;
+	case KVM_REG_MIPS_CP0_ENTRYHI:
+		kvm_write_c0_guest_entryhi(cop0, v);
+		break;
+	case KVM_REG_MIPS_CP0_STATUS:
+		kvm_write_c0_guest_status(cop0, v);
+		break;
+	case KVM_REG_MIPS_CP0_EPC:
+		kvm_write_c0_guest_epc(cop0, v);
+		break;
+	case KVM_REG_MIPS_CP0_PRID:
+		kvm_write_c0_guest_prid(cop0, v);
+		break;
 	case KVM_REG_MIPS_CP0_COUNT:
 		kvm_mips_write_count(vcpu, v);
 		break;
@@ -759,6 +913,27 @@ static int kvm_trap_emul_set_one_reg(struct kvm_vcpu *vcpu,
 	case KVM_REG_MIPS_COUNT_HZ:
 		ret = kvm_mips_set_count_hz(vcpu, v);
 		break;
+	case KVM_REG_MIPS_CP0_ERROREPC:
+		kvm_write_c0_guest_errorepc(cop0, v);
+		break;
+	case KVM_REG_MIPS_CP0_KSCRATCH1:
+		kvm_write_c0_guest_kscratch1(cop0, v);
+		break;
+	case KVM_REG_MIPS_CP0_KSCRATCH2:
+		kvm_write_c0_guest_kscratch2(cop0, v);
+		break;
+	case KVM_REG_MIPS_CP0_KSCRATCH3:
+		kvm_write_c0_guest_kscratch3(cop0, v);
+		break;
+	case KVM_REG_MIPS_CP0_KSCRATCH4:
+		kvm_write_c0_guest_kscratch4(cop0, v);
+		break;
+	case KVM_REG_MIPS_CP0_KSCRATCH5:
+		kvm_write_c0_guest_kscratch5(cop0, v);
+		break;
+	case KVM_REG_MIPS_CP0_KSCRATCH6:
+		kvm_write_c0_guest_kscratch6(cop0, v);
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
git-series 0.8.10
