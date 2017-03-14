Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2017 11:31:33 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:59098 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994827AbdCNKSbzvisU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Mar 2017 11:18:31 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 1465B6F4B75D3;
        Tue, 14 Mar 2017 10:18:22 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 14 Mar 2017 10:18:24 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>
Subject: [PATCH v2 29/33] KVM: MIPS/VZ: Support guest hardware page table walker
Date:   Tue, 14 Mar 2017 10:15:36 +0000
Message-ID: <19c4ea3fd5b9c19724f6a6b20b22b483d5fdc276.1489485940.git-series.james.hogan@imgtec.com>
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
X-archive-position: 57232
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

Add support for VZ guest CP0_PWBase, CP0_PWField, CP0_PWSize, and
CP0_PWCtl registers for controlling the guest hardware page table walker
(HTW) present on P5600 and P6600 cores. These guest registers need
initialising on R6, context switching, and exposing via the KVM ioctl
API when they are present.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
Cc: linux-doc@vger.kernel.org
---
 Documentation/virtual/kvm/api.txt |  4 ++-
 arch/mips/include/asm/kvm_host.h  |  8 +++-
 arch/mips/kvm/vz.c                | 80 ++++++++++++++++++++++++++++++++-
 3 files changed, 92 insertions(+), 0 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 45194363a160..b108238dc9dc 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2081,7 +2081,11 @@ registers, find a list below:
   MIPS  | KVM_REG_MIPS_CP0_SEGCTL0      | 64
   MIPS  | KVM_REG_MIPS_CP0_SEGCTL1      | 64
   MIPS  | KVM_REG_MIPS_CP0_SEGCTL2      | 64
+  MIPS  | KVM_REG_MIPS_CP0_PWBASE       | 64
+  MIPS  | KVM_REG_MIPS_CP0_PWFIELD      | 64
+  MIPS  | KVM_REG_MIPS_CP0_PWSIZE       | 64
   MIPS  | KVM_REG_MIPS_CP0_WIRED        | 32
+  MIPS  | KVM_REG_MIPS_CP0_PWCTL        | 32
   MIPS  | KVM_REG_MIPS_CP0_HWRENA       | 32
   MIPS  | KVM_REG_MIPS_CP0_BADVADDR     | 64
   MIPS  | KVM_REG_MIPS_CP0_BADINSTR     | 32
diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index b2129c031df7..8d016ab3a8b9 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -42,7 +42,11 @@
 #define KVM_REG_MIPS_CP0_SEGCTL0	MIPS_CP0_64(5, 2)
 #define KVM_REG_MIPS_CP0_SEGCTL1	MIPS_CP0_64(5, 3)
 #define KVM_REG_MIPS_CP0_SEGCTL2	MIPS_CP0_64(5, 4)
+#define KVM_REG_MIPS_CP0_PWBASE		MIPS_CP0_64(5, 5)
+#define KVM_REG_MIPS_CP0_PWFIELD	MIPS_CP0_64(5, 6)
+#define KVM_REG_MIPS_CP0_PWSIZE		MIPS_CP0_64(5, 7)
 #define KVM_REG_MIPS_CP0_WIRED		MIPS_CP0_32(6, 0)
+#define KVM_REG_MIPS_CP0_PWCTL		MIPS_CP0_32(6, 6)
 #define KVM_REG_MIPS_CP0_HWRENA		MIPS_CP0_32(7, 0)
 #define KVM_REG_MIPS_CP0_BADVADDR	MIPS_CP0_64(8, 0)
 #define KVM_REG_MIPS_CP0_BADINSTR	MIPS_CP0_32(8, 1)
@@ -678,7 +682,11 @@ __BUILD_KVM_RW_HW(pagegrain,      32, MIPS_CP0_TLB_PG_MASK,  1)
 __BUILD_KVM_RW_HW(segctl0,        l,  MIPS_CP0_TLB_PG_MASK,  2)
 __BUILD_KVM_RW_HW(segctl1,        l,  MIPS_CP0_TLB_PG_MASK,  3)
 __BUILD_KVM_RW_HW(segctl2,        l,  MIPS_CP0_TLB_PG_MASK,  4)
+__BUILD_KVM_RW_HW(pwbase,         l,  MIPS_CP0_TLB_PG_MASK,  5)
+__BUILD_KVM_RW_HW(pwfield,        l,  MIPS_CP0_TLB_PG_MASK,  6)
+__BUILD_KVM_RW_HW(pwsize,         l,  MIPS_CP0_TLB_PG_MASK,  7)
 __BUILD_KVM_RW_HW(wired,          32, MIPS_CP0_TLB_WIRED,    0)
+__BUILD_KVM_RW_HW(pwctl,          32, MIPS_CP0_TLB_WIRED,    6)
 __BUILD_KVM_RW_HW(hwrena,         32, MIPS_CP0_HWRENA,       0)
 __BUILD_KVM_RW_HW(badvaddr,       l,  MIPS_CP0_BAD_VADDR,    0)
 __BUILD_KVM_RW_HW(badinstr,       32, MIPS_CP0_BAD_VADDR,    1)
diff --git a/arch/mips/kvm/vz.c b/arch/mips/kvm/vz.c
index f32c1ab3f724..fb12c5b4a75c 100644
--- a/arch/mips/kvm/vz.c
+++ b/arch/mips/kvm/vz.c
@@ -1392,6 +1392,13 @@ static u64 kvm_vz_get_one_regs_segments[] = {
 	KVM_REG_MIPS_CP0_SEGCTL2,
 };
 
+static u64 kvm_vz_get_one_regs_htw[] = {
+	KVM_REG_MIPS_CP0_PWBASE,
+	KVM_REG_MIPS_CP0_PWFIELD,
+	KVM_REG_MIPS_CP0_PWSIZE,
+	KVM_REG_MIPS_CP0_PWCTL,
+};
+
 static u64 kvm_vz_get_one_regs_kscratch[] = {
 	KVM_REG_MIPS_CP0_KSCRATCH1,
 	KVM_REG_MIPS_CP0_KSCRATCH2,
@@ -1416,6 +1423,8 @@ static unsigned long kvm_vz_num_regs(struct kvm_vcpu *vcpu)
 		ret += ARRAY_SIZE(kvm_vz_get_one_regs_contextconfig);
 	if (cpu_guest_has_segments)
 		ret += ARRAY_SIZE(kvm_vz_get_one_regs_segments);
+	if (cpu_guest_has_htw)
+		ret += ARRAY_SIZE(kvm_vz_get_one_regs_htw);
 	ret += __arch_hweight8(cpu_data[0].guest.kscratch_mask);
 
 	return ret;
@@ -1461,6 +1470,12 @@ static int kvm_vz_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *indices)
 			return -EFAULT;
 		indices += ARRAY_SIZE(kvm_vz_get_one_regs_segments);
 	}
+	if (cpu_guest_has_htw) {
+		if (copy_to_user(indices, kvm_vz_get_one_regs_htw,
+				 sizeof(kvm_vz_get_one_regs_htw)))
+			return -EFAULT;
+		indices += ARRAY_SIZE(kvm_vz_get_one_regs_htw);
+	}
 	for (i = 0; i < 6; ++i) {
 		if (!cpu_guest_has_kscr(i + 2))
 			continue;
@@ -1564,9 +1579,29 @@ static int kvm_vz_get_one_reg(struct kvm_vcpu *vcpu,
 			return -EINVAL;
 		*v = read_gc0_segctl2();
 		break;
+	case KVM_REG_MIPS_CP0_PWBASE:
+		if (!cpu_guest_has_htw)
+			return -EINVAL;
+		*v = read_gc0_pwbase();
+		break;
+	case KVM_REG_MIPS_CP0_PWFIELD:
+		if (!cpu_guest_has_htw)
+			return -EINVAL;
+		*v = read_gc0_pwfield();
+		break;
+	case KVM_REG_MIPS_CP0_PWSIZE:
+		if (!cpu_guest_has_htw)
+			return -EINVAL;
+		*v = read_gc0_pwsize();
+		break;
 	case KVM_REG_MIPS_CP0_WIRED:
 		*v = (long)read_gc0_wired();
 		break;
+	case KVM_REG_MIPS_CP0_PWCTL:
+		if (!cpu_guest_has_htw)
+			return -EINVAL;
+		*v = read_gc0_pwctl();
+		break;
 	case KVM_REG_MIPS_CP0_HWRENA:
 		*v = (long)read_gc0_hwrena();
 		break;
@@ -1746,9 +1781,29 @@ static int kvm_vz_set_one_reg(struct kvm_vcpu *vcpu,
 			return -EINVAL;
 		write_gc0_segctl2(v);
 		break;
+	case KVM_REG_MIPS_CP0_PWBASE:
+		if (!cpu_guest_has_htw)
+			return -EINVAL;
+		write_gc0_pwbase(v);
+		break;
+	case KVM_REG_MIPS_CP0_PWFIELD:
+		if (!cpu_guest_has_htw)
+			return -EINVAL;
+		write_gc0_pwfield(v);
+		break;
+	case KVM_REG_MIPS_CP0_PWSIZE:
+		if (!cpu_guest_has_htw)
+			return -EINVAL;
+		write_gc0_pwsize(v);
+		break;
 	case KVM_REG_MIPS_CP0_WIRED:
 		change_gc0_wired(MIPSR6_WIRED_WIRED, v);
 		break;
+	case KVM_REG_MIPS_CP0_PWCTL:
+		if (!cpu_guest_has_htw)
+			return -EINVAL;
+		write_gc0_pwctl(v);
+		break;
 	case KVM_REG_MIPS_CP0_HWRENA:
 		write_gc0_hwrena(v);
 		break;
@@ -2179,6 +2234,14 @@ static int kvm_vz_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 		kvm_restore_gc0_segctl2(cop0);
 	}
 
+	/* restore HTW registers */
+	if (cpu_guest_has_htw) {
+		kvm_restore_gc0_pwbase(cop0);
+		kvm_restore_gc0_pwfield(cop0);
+		kvm_restore_gc0_pwsize(cop0);
+		kvm_restore_gc0_pwctl(cop0);
+	}
+
 	/* restore Root.GuestCtl2 from unused Guest guestctl2 register */
 	if (cpu_has_guestctl2)
 		write_c0_guestctl2(
@@ -2268,6 +2331,15 @@ static int kvm_vz_vcpu_put(struct kvm_vcpu *vcpu, int cpu)
 		kvm_save_gc0_segctl2(cop0);
 	}
 
+	/* save HTW registers if enabled in guest */
+	if (cpu_guest_has_htw &&
+	    kvm_read_sw_gc0_config3(cop0) & MIPS_CONF3_PW) {
+		kvm_save_gc0_pwbase(cop0);
+		kvm_save_gc0_pwfield(cop0);
+		kvm_save_gc0_pwsize(cop0);
+		kvm_save_gc0_pwctl(cop0);
+	}
+
 	kvm_vz_save_timer(vcpu);
 
 	/* save Root.GuestCtl2 in unused Guest guestctl2 register */
@@ -2596,6 +2668,14 @@ static int kvm_vz_vcpu_setup(struct kvm_vcpu *vcpu)
 		kvm_write_sw_gc0_segctl2(cop0, 0x00380438);
 	}
 
+	/* reset HTW registers */
+	if (cpu_guest_has_htw && cpu_has_mips_r6) {
+		/* PWField */
+		kvm_write_sw_gc0_pwfield(cop0, 0x0c30c302);
+		/* PWSize */
+		kvm_write_sw_gc0_pwsize(cop0, 1 << MIPS_PWSIZE_PTW_SHIFT);
+	}
+
 	/* start with no pending virtual guest interrupts */
 	if (cpu_has_guestctl2)
 		cop0->reg[MIPS_CP0_GUESTCTL2][MIPS_CP0_GUESTCTL2_SEL] = 0;
-- 
git-series 0.8.10
