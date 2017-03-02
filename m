Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Mar 2017 10:47:00 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:31027 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993897AbdCBJhoAiG6t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Mar 2017 10:37:44 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 6B175BDB89A60;
        Thu,  2 Mar 2017 09:37:35 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 2 Mar 2017 09:37:37 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>
Subject: [PATCH 25/32] KVM: MIPS/VZ: Support guest CP0_BadInstr[P]
Date:   Thu, 2 Mar 2017 09:36:52 +0000
Message-ID: <fc71f00190925fa50867b3d1b1a69a3b2aa74a92.1488447004.git-series.james.hogan@imgtec.com>
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
X-archive-position: 56982
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

Add support for VZ guest CP0_BadInstr and CP0_BadInstrP registers, as
found on most VZ capable cores. These guest registers need context
switching, and exposing via the KVM ioctl API when they are present.

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
 arch/mips/include/asm/kvm_host.h  |  4 +++-
 arch/mips/kvm/vz.c                | 46 ++++++++++++++++++++++++++++++++-
 3 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 996a388f05c5..a654a2133981 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2079,6 +2079,8 @@ registers, find a list below:
   MIPS  | KVM_REG_MIPS_CP0_WIRED        | 32
   MIPS  | KVM_REG_MIPS_CP0_HWRENA       | 32
   MIPS  | KVM_REG_MIPS_CP0_BADVADDR     | 64
+  MIPS  | KVM_REG_MIPS_CP0_BADINSTR     | 32
+  MIPS  | KVM_REG_MIPS_CP0_BADINSTRP    | 32
   MIPS  | KVM_REG_MIPS_CP0_COUNT        | 32
   MIPS  | KVM_REG_MIPS_CP0_ENTRYHI      | 64
   MIPS  | KVM_REG_MIPS_CP0_COMPARE      | 32
diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 41d8abc1d6fa..53c92f34475f 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -40,6 +40,8 @@
 #define KVM_REG_MIPS_CP0_WIRED		MIPS_CP0_32(6, 0)
 #define KVM_REG_MIPS_CP0_HWRENA		MIPS_CP0_32(7, 0)
 #define KVM_REG_MIPS_CP0_BADVADDR	MIPS_CP0_64(8, 0)
+#define KVM_REG_MIPS_CP0_BADINSTR	MIPS_CP0_32(8, 1)
+#define KVM_REG_MIPS_CP0_BADINSTRP	MIPS_CP0_32(8, 2)
 #define KVM_REG_MIPS_CP0_COUNT		MIPS_CP0_32(9, 0)
 #define KVM_REG_MIPS_CP0_ENTRYHI	MIPS_CP0_64(10, 0)
 #define KVM_REG_MIPS_CP0_COMPARE	MIPS_CP0_32(11, 0)
@@ -672,6 +674,8 @@ __BUILD_KVM_RW_HW(pagegrain,      32, MIPS_CP0_TLB_PG_MASK,  1)
 __BUILD_KVM_RW_HW(wired,          32, MIPS_CP0_TLB_WIRED,    0)
 __BUILD_KVM_RW_HW(hwrena,         32, MIPS_CP0_HWRENA,       0)
 __BUILD_KVM_RW_HW(badvaddr,       l,  MIPS_CP0_BAD_VADDR,    0)
+__BUILD_KVM_RW_HW(badinstr,       32, MIPS_CP0_BAD_VADDR,    1)
+__BUILD_KVM_RW_HW(badinstrp,      32, MIPS_CP0_BAD_VADDR,    2)
 __BUILD_KVM_RW_SW(count,          32, MIPS_CP0_COUNT,        0)
 __BUILD_KVM_RW_HW(entryhi,        l,  MIPS_CP0_TLB_HI,       0)
 __BUILD_KVM_RW_HW(compare,        32, MIPS_CP0_COMPARE,      0)
diff --git a/arch/mips/kvm/vz.c b/arch/mips/kvm/vz.c
index 30c3550926b0..5fd14d35c146 100644
--- a/arch/mips/kvm/vz.c
+++ b/arch/mips/kvm/vz.c
@@ -1220,6 +1220,10 @@ static unsigned long kvm_vz_num_regs(struct kvm_vcpu *vcpu)
 	ret = ARRAY_SIZE(kvm_vz_get_one_regs);
 	if (cpu_guest_has_userlocal)
 		++ret;
+	if (cpu_guest_has_badinstr)
+		++ret;
+	if (cpu_guest_has_badinstrp)
+		++ret;
 	ret += __arch_hweight8(cpu_data[0].guest.kscratch_mask);
 
 	return ret;
@@ -1241,6 +1245,18 @@ static int kvm_vz_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *indices)
 			return -EFAULT;
 		++indices;
 	}
+	if (cpu_guest_has_badinstr) {
+		index = KVM_REG_MIPS_CP0_BADINSTR;
+		if (copy_to_user(indices, &index, sizeof(index)))
+			return -EFAULT;
+		++indices;
+	}
+	if (cpu_guest_has_badinstrp) {
+		index = KVM_REG_MIPS_CP0_BADINSTRP;
+		if (copy_to_user(indices, &index, sizeof(index)))
+			return -EFAULT;
+		++indices;
+	}
 	for (i = 0; i < 6; ++i) {
 		if (!cpu_guest_has_kscr(i + 2))
 			continue;
@@ -1326,6 +1342,16 @@ static int kvm_vz_get_one_reg(struct kvm_vcpu *vcpu,
 	case KVM_REG_MIPS_CP0_BADVADDR:
 		*v = (long)read_gc0_badvaddr();
 		break;
+	case KVM_REG_MIPS_CP0_BADINSTR:
+		if (!cpu_guest_has_badinstr)
+			return -EINVAL;
+		*v = read_gc0_badinstr();
+		break;
+	case KVM_REG_MIPS_CP0_BADINSTRP:
+		if (!cpu_guest_has_badinstrp)
+			return -EINVAL;
+		*v = read_gc0_badinstrp();
+		break;
 	case KVM_REG_MIPS_CP0_COUNT:
 		*v = kvm_mips_read_count(vcpu);
 		break;
@@ -1471,6 +1497,16 @@ static int kvm_vz_set_one_reg(struct kvm_vcpu *vcpu,
 	case KVM_REG_MIPS_CP0_BADVADDR:
 		write_gc0_badvaddr(v);
 		break;
+	case KVM_REG_MIPS_CP0_BADINSTR:
+		if (!cpu_guest_has_badinstr)
+			return -EINVAL;
+		write_gc0_badinstr(v);
+		break;
+	case KVM_REG_MIPS_CP0_BADINSTRP:
+		if (!cpu_guest_has_badinstrp)
+			return -EINVAL;
+		write_gc0_badinstrp(v);
+		break;
 	case KVM_REG_MIPS_CP0_COUNT:
 		kvm_mips_write_count(vcpu, v);
 		break;
@@ -1870,6 +1906,11 @@ static int kvm_vz_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 			kvm_restore_gc0_kscratch6(cop0);
 	}
 
+	if (cpu_guest_has_badinstr)
+		kvm_restore_gc0_badinstr(cop0);
+	if (cpu_guest_has_badinstrp)
+		kvm_restore_gc0_badinstrp(cop0);
+
 	/* restore Root.GuestCtl2 from unused Guest guestctl2 register */
 	if (cpu_has_guestctl2)
 		write_c0_guestctl2(
@@ -1944,6 +1985,11 @@ static int kvm_vz_vcpu_put(struct kvm_vcpu *vcpu, int cpu)
 			kvm_save_gc0_kscratch6(cop0);
 	}
 
+	if (cpu_guest_has_badinstr)
+		kvm_save_gc0_badinstr(cop0);
+	if (cpu_guest_has_badinstrp)
+		kvm_save_gc0_badinstrp(cop0);
+
 	kvm_vz_save_timer(vcpu);
 
 	/* save Root.GuestCtl2 in unused Guest guestctl2 register */
-- 
git-series 0.8.10
