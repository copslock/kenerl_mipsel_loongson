Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2017 11:30:46 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:46673 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994825AbdCNKSa3dUrU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Mar 2017 11:18:30 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 9592AFAD5FECF;
        Tue, 14 Mar 2017 10:18:20 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 14 Mar 2017 10:18:23 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>
Subject: [PATCH v2 27/33] KVM: MIPS/VZ: Support guest CP0_[X]ContextConfig
Date:   Tue, 14 Mar 2017 10:15:34 +0000
Message-ID: <96b386766c4e727c4596996d2b2e127cc462d7e6.1489485940.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.1
MIME-Version: 1.0
In-Reply-To: <cover.26e10ec77a4ed0d3177ccf4fabf57bc95ea030f8.1489485940.git-series.james.hogan@imgtec.com>
References: <cover.26e10ec77a4ed0d3177ccf4fabf57bc95ea030f8.1489485940.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57230
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

Add support for VZ guest CP0_ContextConfig and CP0_XContextConfig
(MIPS64 only) registers, as found on P5600 and P6600 cores. These guest
registers need initialising, context switching, and exposing via the KVM
ioctl API when they are present.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
Cc: linux-doc@vger.kernel.org
---
 Documentation/virtual/kvm/api.txt |  2 +-
 arch/mips/include/asm/kvm_host.h  |  4 ++-
 arch/mips/kvm/vz.c                | 62 ++++++++++++++++++++++++++++++--
 3 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 5ef4fa1de7d4..5f53bfdc0d84 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2073,7 +2073,9 @@ registers, find a list below:
   MIPS  | KVM_REG_MIPS_CP0_ENTRYLO0     | 64
   MIPS  | KVM_REG_MIPS_CP0_ENTRYLO1     | 64
   MIPS  | KVM_REG_MIPS_CP0_CONTEXT      | 64
+  MIPS  | KVM_REG_MIPS_CP0_CONTEXTCONFIG| 32
   MIPS  | KVM_REG_MIPS_CP0_USERLOCAL    | 64
+  MIPS  | KVM_REG_MIPS_CP0_XCONTEXTCONFIG| 64
   MIPS  | KVM_REG_MIPS_CP0_PAGEMASK     | 32
   MIPS  | KVM_REG_MIPS_CP0_PAGEGRAIN    | 32
   MIPS  | KVM_REG_MIPS_CP0_WIRED        | 32
diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 3a9ca3326315..5066d89f2227 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -34,7 +34,9 @@
 #define KVM_REG_MIPS_CP0_ENTRYLO0	MIPS_CP0_64(2, 0)
 #define KVM_REG_MIPS_CP0_ENTRYLO1	MIPS_CP0_64(3, 0)
 #define KVM_REG_MIPS_CP0_CONTEXT	MIPS_CP0_64(4, 0)
+#define KVM_REG_MIPS_CP0_CONTEXTCONFIG	MIPS_CP0_32(4, 1)
 #define KVM_REG_MIPS_CP0_USERLOCAL	MIPS_CP0_64(4, 2)
+#define KVM_REG_MIPS_CP0_XCONTEXTCONFIG	MIPS_CP0_64(4, 3)
 #define KVM_REG_MIPS_CP0_PAGEMASK	MIPS_CP0_32(5, 0)
 #define KVM_REG_MIPS_CP0_PAGEGRAIN	MIPS_CP0_32(5, 1)
 #define KVM_REG_MIPS_CP0_WIRED		MIPS_CP0_32(6, 0)
@@ -665,7 +667,9 @@ __BUILD_KVM_RW_HW(index,          32, MIPS_CP0_TLB_INDEX,    0)
 __BUILD_KVM_RW_HW(entrylo0,       l,  MIPS_CP0_TLB_LO0,      0)
 __BUILD_KVM_RW_HW(entrylo1,       l,  MIPS_CP0_TLB_LO1,      0)
 __BUILD_KVM_RW_HW(context,        l,  MIPS_CP0_TLB_CONTEXT,  0)
+__BUILD_KVM_RW_HW(contextconfig,  32, MIPS_CP0_TLB_CONTEXT,  1)
 __BUILD_KVM_RW_HW(userlocal,      l,  MIPS_CP0_TLB_CONTEXT,  2)
+__BUILD_KVM_RW_HW(xcontextconfig, l,  MIPS_CP0_TLB_CONTEXT,  3)
 __BUILD_KVM_RW_HW(pagemask,       l,  MIPS_CP0_TLB_PG_MASK,  0)
 __BUILD_KVM_RW_HW(pagegrain,      32, MIPS_CP0_TLB_PG_MASK,  1)
 __BUILD_KVM_RW_HW(wired,          32, MIPS_CP0_TLB_WIRED,    0)
diff --git a/arch/mips/kvm/vz.c b/arch/mips/kvm/vz.c
index ec909fcd08ce..97e7a788bf4a 100644
--- a/arch/mips/kvm/vz.c
+++ b/arch/mips/kvm/vz.c
@@ -131,7 +131,7 @@ static inline unsigned int kvm_vz_config5_guest_wrmask(struct kvm_vcpu *vcpu)
  * Config:	M, [MT]
  * Config1:	M, [MMUSize-1, C2, MD, PC, WR, CA], FP
  * Config2:	M
- * Config3:	M, MSAP, [BPG], ULRI, [DSP2P, DSPP, CTXTC, ITL, LPA, VEIC,
+ * Config3:	M, MSAP, [BPG], ULRI, [DSP2P, DSPP], CTXTC, [ITL, LPA, VEIC,
  *		VInt, SP, CDMM, MT, SM, TL]
  * Config4:	M, [VTLBSizeExt, MMUSizeExt]
  * Config5:	[MRP]
@@ -161,7 +161,7 @@ static inline unsigned int kvm_vz_config2_user_wrmask(struct kvm_vcpu *vcpu)
 static inline unsigned int kvm_vz_config3_user_wrmask(struct kvm_vcpu *vcpu)
 {
 	unsigned int mask = kvm_vz_config3_guest_wrmask(vcpu) | MIPS_CONF_M |
-		MIPS_CONF3_ULRI;
+		MIPS_CONF3_ULRI | MIPS_CONF3_CTXTC;
 
 	/* Permit MSA to be present if MSA is supported */
 	if (kvm_mips_guest_can_have_msa(&vcpu->arch))
@@ -1205,6 +1205,13 @@ static u64 kvm_vz_get_one_regs[] = {
 	KVM_REG_MIPS_COUNT_HZ,
 };
 
+static u64 kvm_vz_get_one_regs_contextconfig[] = {
+	KVM_REG_MIPS_CP0_CONTEXTCONFIG,
+#ifdef CONFIG_64BIT
+	KVM_REG_MIPS_CP0_XCONTEXTCONFIG,
+#endif
+};
+
 static u64 kvm_vz_get_one_regs_kscratch[] = {
 	KVM_REG_MIPS_CP0_KSCRATCH1,
 	KVM_REG_MIPS_CP0_KSCRATCH2,
@@ -1225,6 +1232,8 @@ static unsigned long kvm_vz_num_regs(struct kvm_vcpu *vcpu)
 		++ret;
 	if (cpu_guest_has_badinstrp)
 		++ret;
+	if (cpu_guest_has_contextconfig)
+		ret += ARRAY_SIZE(kvm_vz_get_one_regs_contextconfig);
 	ret += __arch_hweight8(cpu_data[0].guest.kscratch_mask);
 
 	return ret;
@@ -1258,6 +1267,12 @@ static int kvm_vz_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *indices)
 			return -EFAULT;
 		++indices;
 	}
+	if (cpu_guest_has_contextconfig) {
+		if (copy_to_user(indices, kvm_vz_get_one_regs_contextconfig,
+				 sizeof(kvm_vz_get_one_regs_contextconfig)))
+			return -EFAULT;
+		indices += ARRAY_SIZE(kvm_vz_get_one_regs_contextconfig);
+	}
 	for (i = 0; i < 6; ++i) {
 		if (!cpu_guest_has_kscr(i + 2))
 			continue;
@@ -1323,11 +1338,23 @@ static int kvm_vz_get_one_reg(struct kvm_vcpu *vcpu,
 	case KVM_REG_MIPS_CP0_CONTEXT:
 		*v = (long)read_gc0_context();
 		break;
+	case KVM_REG_MIPS_CP0_CONTEXTCONFIG:
+		if (!cpu_guest_has_contextconfig)
+			return -EINVAL;
+		*v = read_gc0_contextconfig();
+		break;
 	case KVM_REG_MIPS_CP0_USERLOCAL:
 		if (!cpu_guest_has_userlocal)
 			return -EINVAL;
 		*v = read_gc0_userlocal();
 		break;
+#ifdef CONFIG_64BIT
+	case KVM_REG_MIPS_CP0_XCONTEXTCONFIG:
+		if (!cpu_guest_has_contextconfig)
+			return -EINVAL;
+		*v = read_gc0_xcontextconfig();
+		break;
+#endif
 	case KVM_REG_MIPS_CP0_PAGEMASK:
 		*v = (long)read_gc0_pagemask();
 		break;
@@ -1478,11 +1505,23 @@ static int kvm_vz_set_one_reg(struct kvm_vcpu *vcpu,
 	case KVM_REG_MIPS_CP0_CONTEXT:
 		write_gc0_context(v);
 		break;
+	case KVM_REG_MIPS_CP0_CONTEXTCONFIG:
+		if (!cpu_guest_has_contextconfig)
+			return -EINVAL;
+		write_gc0_contextconfig(v);
+		break;
 	case KVM_REG_MIPS_CP0_USERLOCAL:
 		if (!cpu_guest_has_userlocal)
 			return -EINVAL;
 		write_gc0_userlocal(v);
 		break;
+#ifdef CONFIG_64BIT
+	case KVM_REG_MIPS_CP0_XCONTEXTCONFIG:
+		if (!cpu_guest_has_contextconfig)
+			return -EINVAL;
+		write_gc0_xcontextconfig(v);
+		break;
+#endif
 	case KVM_REG_MIPS_CP0_PAGEMASK:
 		write_gc0_pagemask(v);
 		break;
@@ -1874,8 +1913,12 @@ static int kvm_vz_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	kvm_restore_gc0_entrylo0(cop0);
 	kvm_restore_gc0_entrylo1(cop0);
 	kvm_restore_gc0_context(cop0);
+	if (cpu_guest_has_contextconfig)
+		kvm_restore_gc0_contextconfig(cop0);
 #ifdef CONFIG_64BIT
 	kvm_restore_gc0_xcontext(cop0);
+	if (cpu_guest_has_contextconfig)
+		kvm_restore_gc0_xcontextconfig(cop0);
 #endif
 	kvm_restore_gc0_pagemask(cop0);
 	kvm_restore_gc0_pagegrain(cop0);
@@ -1933,8 +1976,12 @@ static int kvm_vz_vcpu_put(struct kvm_vcpu *vcpu, int cpu)
 	kvm_save_gc0_entrylo0(cop0);
 	kvm_save_gc0_entrylo1(cop0);
 	kvm_save_gc0_context(cop0);
+	if (cpu_guest_has_contextconfig)
+		kvm_save_gc0_contextconfig(cop0);
 #ifdef CONFIG_64BIT
 	kvm_save_gc0_xcontext(cop0);
+	if (cpu_guest_has_contextconfig)
+		kvm_save_gc0_xcontextconfig(cop0);
 #endif
 	kvm_save_gc0_pagemask(cop0);
 	kvm_save_gc0_pagegrain(cop0);
@@ -2298,6 +2345,17 @@ static int kvm_vz_vcpu_setup(struct kvm_vcpu *vcpu)
 		kvm_clear_sw_gc0_config5(cop0, MIPS_CONF5_MRP);
 	}
 
+	if (cpu_guest_has_contextconfig) {
+		/* ContextConfig */
+		kvm_write_sw_gc0_contextconfig(cop0, 0x007ffff0);
+#ifdef CONFIG_64BIT
+		/* XContextConfig */
+		/* bits SEGBITS-13+3:4 set */
+		kvm_write_sw_gc0_xcontextconfig(cop0,
+					((1ull << (cpu_vmbits - 13)) - 1) << 4);
+#endif
+	}
+
 	/* start with no pending virtual guest interrupts */
 	if (cpu_has_guestctl2)
 		cop0->reg[MIPS_CP0_GUESTCTL2][MIPS_CP0_GUESTCTL2_SEL] = 0;
-- 
git-series 0.8.10
