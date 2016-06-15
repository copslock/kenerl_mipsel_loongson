Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jun 2016 20:34:23 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:14337 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27042347AbcFOSaVle15W (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Jun 2016 20:30:21 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 50C2478AC39EE;
        Wed, 15 Jun 2016 19:30:10 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 15 Jun 2016 19:30:14 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 12/17] MIPS: KVM: Add KScratch registers
Date:   Wed, 15 Jun 2016 19:29:56 +0100
Message-ID: <1466015401-24433-13-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 54067
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

Allow up to 6 KVM guest KScratch registers to be enabled and accessed
via the KVM guest register API and from the guest itself (the fallback
reading and writing of commpage registers is sufficient for KScratch
registers to work as expected).

User mode can expose the registers by setting the appropriate bits of
the guest Config4.KScrExist field. KScratch registers that aren't usable
won't be writeable via the KVM Ioctl API.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 Documentation/virtual/kvm/api.txt |  6 ++++
 arch/mips/include/asm/kvm_host.h  | 19 +++++++++++
 arch/mips/kvm/emulate.c           |  7 +++-
 arch/mips/kvm/mips.c              | 71 +++++++++++++++++++++++++++++++++++++++
 arch/mips/kvm/trace.h             |  6 ++++
 arch/mips/kvm/trap_emul.c         |  2 ++
 6 files changed, 110 insertions(+), 1 deletion(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index a4482cce4bae..c98945bda208 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2032,6 +2032,12 @@ registers, find a list below:
   MIPS  | KVM_REG_MIPS_CP0_CONFIG5      | 32
   MIPS  | KVM_REG_MIPS_CP0_CONFIG7      | 32
   MIPS  | KVM_REG_MIPS_CP0_ERROREPC     | 64
+  MIPS  | KVM_REG_MIPS_CP0_KSCRATCH1    | 64
+  MIPS  | KVM_REG_MIPS_CP0_KSCRATCH2    | 64
+  MIPS  | KVM_REG_MIPS_CP0_KSCRATCH3    | 64
+  MIPS  | KVM_REG_MIPS_CP0_KSCRATCH4    | 64
+  MIPS  | KVM_REG_MIPS_CP0_KSCRATCH5    | 64
+  MIPS  | KVM_REG_MIPS_CP0_KSCRATCH6    | 64
   MIPS  | KVM_REG_MIPS_COUNT_CTL        | 64
   MIPS  | KVM_REG_MIPS_COUNT_RESUME     | 64
   MIPS  | KVM_REG_MIPS_COUNT_HZ         | 64
diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index f12eb01a3195..5e9da2a31fde 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -56,6 +56,12 @@
 #define KVM_REG_MIPS_CP0_CONFIG7	MIPS_CP0_32(16, 7)
 #define KVM_REG_MIPS_CP0_XCONTEXT	MIPS_CP0_64(20, 0)
 #define KVM_REG_MIPS_CP0_ERROREPC	MIPS_CP0_64(30, 0)
+#define KVM_REG_MIPS_CP0_KSCRATCH1	MIPS_CP0_64(31, 2)
+#define KVM_REG_MIPS_CP0_KSCRATCH2	MIPS_CP0_64(31, 3)
+#define KVM_REG_MIPS_CP0_KSCRATCH3	MIPS_CP0_64(31, 4)
+#define KVM_REG_MIPS_CP0_KSCRATCH4	MIPS_CP0_64(31, 5)
+#define KVM_REG_MIPS_CP0_KSCRATCH5	MIPS_CP0_64(31, 6)
+#define KVM_REG_MIPS_CP0_KSCRATCH6	MIPS_CP0_64(31, 7)
 
 
 #define KVM_MAX_VCPUS		1
@@ -376,6 +382,7 @@ struct kvm_vcpu_arch {
 
 	u8 fpu_enabled;
 	u8 msa_enabled;
+	u8 kscratch_enabled;
 };
 
 
@@ -429,6 +436,18 @@ struct kvm_vcpu_arch {
 #define kvm_write_c0_guest_config7(cop0, val)	(cop0->reg[MIPS_CP0_CONFIG][7] = (val))
 #define kvm_read_c0_guest_errorepc(cop0)	(cop0->reg[MIPS_CP0_ERROR_PC][0])
 #define kvm_write_c0_guest_errorepc(cop0, val)	(cop0->reg[MIPS_CP0_ERROR_PC][0] = (val))
+#define kvm_read_c0_guest_kscratch1(cop0)	(cop0->reg[MIPS_CP0_DESAVE][2])
+#define kvm_read_c0_guest_kscratch2(cop0)	(cop0->reg[MIPS_CP0_DESAVE][3])
+#define kvm_read_c0_guest_kscratch3(cop0)	(cop0->reg[MIPS_CP0_DESAVE][4])
+#define kvm_read_c0_guest_kscratch4(cop0)	(cop0->reg[MIPS_CP0_DESAVE][5])
+#define kvm_read_c0_guest_kscratch5(cop0)	(cop0->reg[MIPS_CP0_DESAVE][6])
+#define kvm_read_c0_guest_kscratch6(cop0)	(cop0->reg[MIPS_CP0_DESAVE][7])
+#define kvm_write_c0_guest_kscratch1(cop0, val)	(cop0->reg[MIPS_CP0_DESAVE][2] = (val))
+#define kvm_write_c0_guest_kscratch2(cop0, val)	(cop0->reg[MIPS_CP0_DESAVE][3] = (val))
+#define kvm_write_c0_guest_kscratch3(cop0, val)	(cop0->reg[MIPS_CP0_DESAVE][4] = (val))
+#define kvm_write_c0_guest_kscratch4(cop0, val)	(cop0->reg[MIPS_CP0_DESAVE][5] = (val))
+#define kvm_write_c0_guest_kscratch5(cop0, val)	(cop0->reg[MIPS_CP0_DESAVE][6] = (val))
+#define kvm_write_c0_guest_kscratch6(cop0, val)	(cop0->reg[MIPS_CP0_DESAVE][7] = (val))
 
 /*
  * Some of the guest registers may be modified asynchronously (e.g. from a
diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index 4ca5450febbb..5f0354c80c8e 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -941,7 +941,12 @@ unsigned int kvm_mips_config3_wrmask(struct kvm_vcpu *vcpu)
 unsigned int kvm_mips_config4_wrmask(struct kvm_vcpu *vcpu)
 {
 	/* Config5 is optional */
-	return MIPS_CONF_M;
+	unsigned int mask = MIPS_CONF_M;
+
+	/* KScrExist */
+	mask |= (unsigned int)vcpu->arch.kscratch_enabled << 16;
+
+	return mask;
 }
 
 /**
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 622b9feba927..5a2b9034a05c 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -9,6 +9,7 @@
  * Authors: Sanjay Lal <sanjayl@kymasys.com>
  */
 
+#include <linux/bitops.h>
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/kdebug.h>
@@ -548,6 +549,15 @@ static u64 kvm_mips_get_one_regs_msa[] = {
 	KVM_REG_MIPS_MSA_CSR,
 };
 
+static u64 kvm_mips_get_one_regs_kscratch[] = {
+	KVM_REG_MIPS_CP0_KSCRATCH1,
+	KVM_REG_MIPS_CP0_KSCRATCH2,
+	KVM_REG_MIPS_CP0_KSCRATCH3,
+	KVM_REG_MIPS_CP0_KSCRATCH4,
+	KVM_REG_MIPS_CP0_KSCRATCH5,
+	KVM_REG_MIPS_CP0_KSCRATCH6,
+};
+
 static unsigned long kvm_mips_num_regs(struct kvm_vcpu *vcpu)
 {
 	unsigned long ret;
@@ -561,6 +571,7 @@ static unsigned long kvm_mips_num_regs(struct kvm_vcpu *vcpu)
 	}
 	if (kvm_mips_guest_can_have_msa(&vcpu->arch))
 		ret += ARRAY_SIZE(kvm_mips_get_one_regs_msa) + 32;
+	ret += __arch_hweight8(vcpu->arch.kscratch_enabled);
 	ret += kvm_mips_callbacks->num_regs(vcpu);
 
 	return ret;
@@ -613,6 +624,16 @@ static int kvm_mips_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *indices)
 		}
 	}
 
+	for (i = 0; i < 6; ++i) {
+		if (!(vcpu->arch.kscratch_enabled & BIT(i + 2)))
+			continue;
+
+		if (copy_to_user(indices, &kvm_mips_get_one_regs_kscratch[i],
+				 sizeof(kvm_mips_get_one_regs_kscratch[i])))
+			return -EFAULT;
+		++indices;
+	}
+
 	return kvm_mips_callbacks->copy_reg_indices(vcpu, indices);
 }
 
@@ -765,6 +786,31 @@ static int kvm_mips_get_reg(struct kvm_vcpu *vcpu,
 	case KVM_REG_MIPS_CP0_ERROREPC:
 		v = (long)kvm_read_c0_guest_errorepc(cop0);
 		break;
+	case KVM_REG_MIPS_CP0_KSCRATCH1 ... KVM_REG_MIPS_CP0_KSCRATCH6:
+		idx = reg->id - KVM_REG_MIPS_CP0_KSCRATCH1 + 2;
+		if (!(vcpu->arch.kscratch_enabled & BIT(idx)))
+			return -EINVAL;
+		switch (idx) {
+		case 2:
+			v = (long)kvm_read_c0_guest_kscratch1(cop0);
+			break;
+		case 3:
+			v = (long)kvm_read_c0_guest_kscratch2(cop0);
+			break;
+		case 4:
+			v = (long)kvm_read_c0_guest_kscratch3(cop0);
+			break;
+		case 5:
+			v = (long)kvm_read_c0_guest_kscratch4(cop0);
+			break;
+		case 6:
+			v = (long)kvm_read_c0_guest_kscratch5(cop0);
+			break;
+		case 7:
+			v = (long)kvm_read_c0_guest_kscratch6(cop0);
+			break;
+		}
+		break;
 	/* registers to be handled specially */
 	default:
 		ret = kvm_mips_callbacks->get_one_reg(vcpu, reg, &v);
@@ -931,6 +977,31 @@ static int kvm_mips_set_reg(struct kvm_vcpu *vcpu,
 	case KVM_REG_MIPS_CP0_ERROREPC:
 		kvm_write_c0_guest_errorepc(cop0, v);
 		break;
+	case KVM_REG_MIPS_CP0_KSCRATCH1 ... KVM_REG_MIPS_CP0_KSCRATCH6:
+		idx = reg->id - KVM_REG_MIPS_CP0_KSCRATCH1 + 2;
+		if (!(vcpu->arch.kscratch_enabled & BIT(idx)))
+			return -EINVAL;
+		switch (idx) {
+		case 2:
+			kvm_write_c0_guest_kscratch1(cop0, v);
+			break;
+		case 3:
+			kvm_write_c0_guest_kscratch2(cop0, v);
+			break;
+		case 4:
+			kvm_write_c0_guest_kscratch3(cop0, v);
+			break;
+		case 5:
+			kvm_write_c0_guest_kscratch4(cop0, v);
+			break;
+		case 6:
+			kvm_write_c0_guest_kscratch5(cop0, v);
+			break;
+		case 7:
+			kvm_write_c0_guest_kscratch6(cop0, v);
+			break;
+		}
+		break;
 	/* registers to be handled specially */
 	default:
 		return kvm_mips_callbacks->set_one_reg(vcpu, reg, v);
diff --git a/arch/mips/kvm/trace.h b/arch/mips/kvm/trace.h
index 95f67d04bd1d..75f1fda08f70 100644
--- a/arch/mips/kvm/trace.h
+++ b/arch/mips/kvm/trace.h
@@ -178,6 +178,12 @@ TRACE_EVENT(kvm_exit,
 	{ KVM_TRACE_COP0(16, 7),	"Config7" },		\
 	{ KVM_TRACE_COP0(26, 0),	"ECC" },		\
 	{ KVM_TRACE_COP0(30, 0),	"ErrorEPC" },		\
+	{ KVM_TRACE_COP0(31, 2),	"KScratch1" },		\
+	{ KVM_TRACE_COP0(31, 3),	"KScratch2" },		\
+	{ KVM_TRACE_COP0(31, 4),	"KScratch3" },		\
+	{ KVM_TRACE_COP0(31, 5),	"KScratch4" },		\
+	{ KVM_TRACE_COP0(31, 6),	"KScratch5" },		\
+	{ KVM_TRACE_COP0(31, 7),	"KScratch6" },		\
 	{ KVM_TRACE_HWR( 0, 0),		"CPUNum" },		\
 	{ KVM_TRACE_HWR( 1, 0),		"SYNCI_Step" },		\
 	{ KVM_TRACE_HWR( 2, 0),		"CC" },			\
diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index b64ca1a222f7..eb191c4612bb 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -418,6 +418,8 @@ static int kvm_trap_emul_vm_init(struct kvm *kvm)
 
 static int kvm_trap_emul_vcpu_init(struct kvm_vcpu *vcpu)
 {
+	vcpu->arch.kscratch_enabled = 0xfc;
+
 	return 0;
 }
 
-- 
2.4.10
