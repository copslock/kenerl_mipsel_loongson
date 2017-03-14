Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2017 11:31:56 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:10185 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994828AbdCNKSb7f7jU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Mar 2017 11:18:31 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 60692254E6404;
        Tue, 14 Mar 2017 10:18:21 +0000 (GMT)
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
Subject: [PATCH v2 28/33] KVM: MIPS/VZ: Support guest segmentation control
Date:   Tue, 14 Mar 2017 10:15:35 +0000
Message-ID: <0b0a077b78df261dd2e2a186fd975acce2bc8af0.1489485940.git-series.james.hogan@imgtec.com>
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
X-archive-position: 57233
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

Add support for VZ guest CP0_SegCtl0, CP0_SegCtl1, and CP0_SegCtl2
registers, as found on P5600 and P6600 cores. These guest registers need
initialising, context switching, and exposing via the KVM ioctl API when
they are present.

They also require the GVA -> GPA translation code for handling a GVA
root exception to be updated to interpret the segmentation registers and
decode the faulting instruction enough to detect EVA memory access
instructions.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
Cc: linux-doc@vger.kernel.org
---
 Documentation/virtual/kvm/api.txt |   3 +-
 arch/mips/include/asm/kvm_host.h  |   6 +-
 arch/mips/kvm/vz.c                | 242 ++++++++++++++++++++++++++++++-
 3 files changed, 250 insertions(+), 1 deletion(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 5f53bfdc0d84..45194363a160 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2078,6 +2078,9 @@ registers, find a list below:
   MIPS  | KVM_REG_MIPS_CP0_XCONTEXTCONFIG| 64
   MIPS  | KVM_REG_MIPS_CP0_PAGEMASK     | 32
   MIPS  | KVM_REG_MIPS_CP0_PAGEGRAIN    | 32
+  MIPS  | KVM_REG_MIPS_CP0_SEGCTL0      | 64
+  MIPS  | KVM_REG_MIPS_CP0_SEGCTL1      | 64
+  MIPS  | KVM_REG_MIPS_CP0_SEGCTL2      | 64
   MIPS  | KVM_REG_MIPS_CP0_WIRED        | 32
   MIPS  | KVM_REG_MIPS_CP0_HWRENA       | 32
   MIPS  | KVM_REG_MIPS_CP0_BADVADDR     | 64
diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 5066d89f2227..b2129c031df7 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -39,6 +39,9 @@
 #define KVM_REG_MIPS_CP0_XCONTEXTCONFIG	MIPS_CP0_64(4, 3)
 #define KVM_REG_MIPS_CP0_PAGEMASK	MIPS_CP0_32(5, 0)
 #define KVM_REG_MIPS_CP0_PAGEGRAIN	MIPS_CP0_32(5, 1)
+#define KVM_REG_MIPS_CP0_SEGCTL0	MIPS_CP0_64(5, 2)
+#define KVM_REG_MIPS_CP0_SEGCTL1	MIPS_CP0_64(5, 3)
+#define KVM_REG_MIPS_CP0_SEGCTL2	MIPS_CP0_64(5, 4)
 #define KVM_REG_MIPS_CP0_WIRED		MIPS_CP0_32(6, 0)
 #define KVM_REG_MIPS_CP0_HWRENA		MIPS_CP0_32(7, 0)
 #define KVM_REG_MIPS_CP0_BADVADDR	MIPS_CP0_64(8, 0)
@@ -672,6 +675,9 @@ __BUILD_KVM_RW_HW(userlocal,      l,  MIPS_CP0_TLB_CONTEXT,  2)
 __BUILD_KVM_RW_HW(xcontextconfig, l,  MIPS_CP0_TLB_CONTEXT,  3)
 __BUILD_KVM_RW_HW(pagemask,       l,  MIPS_CP0_TLB_PG_MASK,  0)
 __BUILD_KVM_RW_HW(pagegrain,      32, MIPS_CP0_TLB_PG_MASK,  1)
+__BUILD_KVM_RW_HW(segctl0,        l,  MIPS_CP0_TLB_PG_MASK,  2)
+__BUILD_KVM_RW_HW(segctl1,        l,  MIPS_CP0_TLB_PG_MASK,  3)
+__BUILD_KVM_RW_HW(segctl2,        l,  MIPS_CP0_TLB_PG_MASK,  4)
 __BUILD_KVM_RW_HW(wired,          32, MIPS_CP0_TLB_WIRED,    0)
 __BUILD_KVM_RW_HW(hwrena,         32, MIPS_CP0_HWRENA,       0)
 __BUILD_KVM_RW_HW(badvaddr,       l,  MIPS_CP0_BAD_VADDR,    0)
diff --git a/arch/mips/kvm/vz.c b/arch/mips/kvm/vz.c
index 97e7a788bf4a..f32c1ab3f724 100644
--- a/arch/mips/kvm/vz.c
+++ b/arch/mips/kvm/vz.c
@@ -412,6 +412,117 @@ static void kvm_vz_save_timer(struct kvm_vcpu *vcpu)
 }
 
 /**
+ * is_eva_access() - Find whether an instruction is an EVA memory accessor.
+ * @inst:	32-bit instruction encoding.
+ *
+ * Finds whether @inst encodes an EVA memory access instruction, which would
+ * indicate that emulation of it should access the user mode address space
+ * instead of the kernel mode address space. This matters for MUSUK segments
+ * which are TLB mapped for user mode but unmapped for kernel mode.
+ *
+ * Returns:	Whether @inst encodes an EVA accessor instruction.
+ */
+static bool is_eva_access(union mips_instruction inst)
+{
+	if (inst.spec3_format.opcode != spec3_op)
+		return false;
+
+	switch (inst.spec3_format.func) {
+	case lwle_op:
+	case lwre_op:
+	case cachee_op:
+	case sbe_op:
+	case she_op:
+	case sce_op:
+	case swe_op:
+	case swle_op:
+	case swre_op:
+	case prefe_op:
+	case lbue_op:
+	case lhue_op:
+	case lbe_op:
+	case lhe_op:
+	case lle_op:
+	case lwe_op:
+		return true;
+	default:
+		return false;
+	}
+}
+
+/**
+ * is_eva_am_mapped() - Find whether an access mode is mapped.
+ * @vcpu:	KVM VCPU state.
+ * @am:		3-bit encoded access mode.
+ * @eu:		Segment becomes unmapped and uncached when Status.ERL=1.
+ *
+ * Decode @am to find whether it encodes a mapped segment for the current VCPU
+ * state. Where necessary @eu and the actual instruction causing the fault are
+ * taken into account to make the decision.
+ *
+ * Returns:	Whether the VCPU faulted on a TLB mapped address.
+ */
+static bool is_eva_am_mapped(struct kvm_vcpu *vcpu, unsigned int am, bool eu)
+{
+	u32 am_lookup;
+	int err;
+
+	/*
+	 * Interpret access control mode. We assume address errors will already
+	 * have been caught by the guest, leaving us with:
+	 *      AM      UM  SM  KM  31..24 23..16
+	 * UK    0 000          Unm   0      0
+	 * MK    1 001          TLB   1
+	 * MSK   2 010      TLB TLB   1
+	 * MUSK  3 011  TLB TLB TLB   1
+	 * MUSUK 4 100  TLB TLB Unm   0      1
+	 * USK   5 101      Unm Unm   0      0
+	 * -     6 110                0      0
+	 * UUSK  7 111  Unm Unm Unm   0      0
+	 *
+	 * We shift a magic value by AM across the sign bit to find if always
+	 * TLB mapped, and if not shift by 8 again to find if it depends on KM.
+	 */
+	am_lookup = 0x70080000 << am;
+	if ((s32)am_lookup < 0) {
+		/*
+		 * MK, MSK, MUSK
+		 * Always TLB mapped, unless SegCtl.EU && ERL
+		 */
+		if (!eu || !(read_gc0_status() & ST0_ERL))
+			return true;
+	} else {
+		am_lookup <<= 8;
+		if ((s32)am_lookup < 0) {
+			union mips_instruction inst;
+			unsigned int status;
+			u32 *opc;
+
+			/*
+			 * MUSUK
+			 * TLB mapped if not in kernel mode
+			 */
+			status = read_gc0_status();
+			if (!(status & (ST0_EXL | ST0_ERL)) &&
+			    (status & ST0_KSU))
+				return true;
+			/*
+			 * EVA access instructions in kernel
+			 * mode access user address space.
+			 */
+			opc = (u32 *)vcpu->arch.pc;
+			if (vcpu->arch.host_cp0_cause & CAUSEF_BD)
+				opc += 1;
+			err = kvm_get_badinstr(opc, vcpu, &inst.word);
+			if (!err && is_eva_access(inst))
+				return true;
+		}
+	}
+
+	return false;
+}
+
+/**
  * kvm_vz_gva_to_gpa() - Convert valid GVA to GPA.
  * @vcpu:	KVM VCPU state.
  * @gva:	Guest virtual address to convert.
@@ -427,10 +538,58 @@ static int kvm_vz_gva_to_gpa(struct kvm_vcpu *vcpu, unsigned long gva,
 			     unsigned long *gpa)
 {
 	u32 gva32 = gva;
+	unsigned long segctl;
 
 	if ((long)gva == (s32)gva32) {
 		/* Handle canonical 32-bit virtual address */
-		if ((s32)gva32 < (s32)0xc0000000) {
+		if (cpu_guest_has_segments) {
+			unsigned long mask, pa;
+
+			switch (gva32 >> 29) {
+			case 0:
+			case 1: /* CFG5 (1GB) */
+				segctl = read_gc0_segctl2() >> 16;
+				mask = (unsigned long)0xfc0000000ull;
+				break;
+			case 2:
+			case 3: /* CFG4 (1GB) */
+				segctl = read_gc0_segctl2();
+				mask = (unsigned long)0xfc0000000ull;
+				break;
+			case 4: /* CFG3 (512MB) */
+				segctl = read_gc0_segctl1() >> 16;
+				mask = (unsigned long)0xfe0000000ull;
+				break;
+			case 5: /* CFG2 (512MB) */
+				segctl = read_gc0_segctl1();
+				mask = (unsigned long)0xfe0000000ull;
+				break;
+			case 6: /* CFG1 (512MB) */
+				segctl = read_gc0_segctl0() >> 16;
+				mask = (unsigned long)0xfe0000000ull;
+				break;
+			case 7: /* CFG0 (512MB) */
+				segctl = read_gc0_segctl0();
+				mask = (unsigned long)0xfe0000000ull;
+				break;
+			default:
+				/*
+				 * GCC 4.9 isn't smart enough to figure out that
+				 * segctl and mask are always initialised.
+				 */
+				unreachable();
+			}
+
+			if (is_eva_am_mapped(vcpu, (segctl >> 4) & 0x7,
+					     segctl & 0x0008))
+				goto tlb_mapped;
+
+			/* Unmapped, find guest physical address */
+			pa = (segctl << 20) & mask;
+			pa |= gva32 & ~mask;
+			*gpa = pa;
+			return 0;
+		} else if ((s32)gva32 < (s32)0xc0000000) {
 			/* legacy unmapped KSeg0 or KSeg1 */
 			*gpa = gva32 & 0x1fffffff;
 			return 0;
@@ -438,6 +597,20 @@ static int kvm_vz_gva_to_gpa(struct kvm_vcpu *vcpu, unsigned long gva,
 #ifdef CONFIG_64BIT
 	} else if ((gva & 0xc000000000000000) == 0x8000000000000000) {
 		/* XKPHYS */
+		if (cpu_guest_has_segments) {
+			/*
+			 * Each of the 8 regions can be overridden by SegCtl2.XR
+			 * to use SegCtl1.XAM.
+			 */
+			segctl = read_gc0_segctl2();
+			if (segctl & (1ull << (56 + ((gva >> 59) & 0x7)))) {
+				segctl = read_gc0_segctl1();
+				if (is_eva_am_mapped(vcpu, (segctl >> 59) & 0x7,
+						     0))
+					goto tlb_mapped;
+			}
+
+		}
 		/*
 		 * Traditionally fully unmapped.
 		 * Bits 61:59 specify the CCA, which we can just mask off here.
@@ -449,6 +622,7 @@ static int kvm_vz_gva_to_gpa(struct kvm_vcpu *vcpu, unsigned long gva,
 #endif
 	}
 
+tlb_mapped:
 	return kvm_vz_guest_tlb_lookup(vcpu, gva, gpa);
 }
 
@@ -1212,6 +1386,12 @@ static u64 kvm_vz_get_one_regs_contextconfig[] = {
 #endif
 };
 
+static u64 kvm_vz_get_one_regs_segments[] = {
+	KVM_REG_MIPS_CP0_SEGCTL0,
+	KVM_REG_MIPS_CP0_SEGCTL1,
+	KVM_REG_MIPS_CP0_SEGCTL2,
+};
+
 static u64 kvm_vz_get_one_regs_kscratch[] = {
 	KVM_REG_MIPS_CP0_KSCRATCH1,
 	KVM_REG_MIPS_CP0_KSCRATCH2,
@@ -1234,6 +1414,8 @@ static unsigned long kvm_vz_num_regs(struct kvm_vcpu *vcpu)
 		++ret;
 	if (cpu_guest_has_contextconfig)
 		ret += ARRAY_SIZE(kvm_vz_get_one_regs_contextconfig);
+	if (cpu_guest_has_segments)
+		ret += ARRAY_SIZE(kvm_vz_get_one_regs_segments);
 	ret += __arch_hweight8(cpu_data[0].guest.kscratch_mask);
 
 	return ret;
@@ -1273,6 +1455,12 @@ static int kvm_vz_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *indices)
 			return -EFAULT;
 		indices += ARRAY_SIZE(kvm_vz_get_one_regs_contextconfig);
 	}
+	if (cpu_guest_has_segments) {
+		if (copy_to_user(indices, kvm_vz_get_one_regs_segments,
+				 sizeof(kvm_vz_get_one_regs_segments)))
+			return -EFAULT;
+		indices += ARRAY_SIZE(kvm_vz_get_one_regs_segments);
+	}
 	for (i = 0; i < 6; ++i) {
 		if (!cpu_guest_has_kscr(i + 2))
 			continue;
@@ -1361,6 +1549,21 @@ static int kvm_vz_get_one_reg(struct kvm_vcpu *vcpu,
 	case KVM_REG_MIPS_CP0_PAGEGRAIN:
 		*v = (long)read_gc0_pagegrain();
 		break;
+	case KVM_REG_MIPS_CP0_SEGCTL0:
+		if (!cpu_guest_has_segments)
+			return -EINVAL;
+		*v = read_gc0_segctl0();
+		break;
+	case KVM_REG_MIPS_CP0_SEGCTL1:
+		if (!cpu_guest_has_segments)
+			return -EINVAL;
+		*v = read_gc0_segctl1();
+		break;
+	case KVM_REG_MIPS_CP0_SEGCTL2:
+		if (!cpu_guest_has_segments)
+			return -EINVAL;
+		*v = read_gc0_segctl2();
+		break;
 	case KVM_REG_MIPS_CP0_WIRED:
 		*v = (long)read_gc0_wired();
 		break;
@@ -1528,6 +1731,21 @@ static int kvm_vz_set_one_reg(struct kvm_vcpu *vcpu,
 	case KVM_REG_MIPS_CP0_PAGEGRAIN:
 		write_gc0_pagegrain(v);
 		break;
+	case KVM_REG_MIPS_CP0_SEGCTL0:
+		if (!cpu_guest_has_segments)
+			return -EINVAL;
+		write_gc0_segctl0(v);
+		break;
+	case KVM_REG_MIPS_CP0_SEGCTL1:
+		if (!cpu_guest_has_segments)
+			return -EINVAL;
+		write_gc0_segctl1(v);
+		break;
+	case KVM_REG_MIPS_CP0_SEGCTL2:
+		if (!cpu_guest_has_segments)
+			return -EINVAL;
+		write_gc0_segctl2(v);
+		break;
 	case KVM_REG_MIPS_CP0_WIRED:
 		change_gc0_wired(MIPSR6_WIRED_WIRED, v);
 		break;
@@ -1955,6 +2173,12 @@ static int kvm_vz_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	if (cpu_guest_has_badinstrp)
 		kvm_restore_gc0_badinstrp(cop0);
 
+	if (cpu_guest_has_segments) {
+		kvm_restore_gc0_segctl0(cop0);
+		kvm_restore_gc0_segctl1(cop0);
+		kvm_restore_gc0_segctl2(cop0);
+	}
+
 	/* restore Root.GuestCtl2 from unused Guest guestctl2 register */
 	if (cpu_has_guestctl2)
 		write_c0_guestctl2(
@@ -2038,6 +2262,12 @@ static int kvm_vz_vcpu_put(struct kvm_vcpu *vcpu, int cpu)
 	if (cpu_guest_has_badinstrp)
 		kvm_save_gc0_badinstrp(cop0);
 
+	if (cpu_guest_has_segments) {
+		kvm_save_gc0_segctl0(cop0);
+		kvm_save_gc0_segctl1(cop0);
+		kvm_save_gc0_segctl2(cop0);
+	}
+
 	kvm_vz_save_timer(vcpu);
 
 	/* save Root.GuestCtl2 in unused Guest guestctl2 register */
@@ -2356,6 +2586,16 @@ static int kvm_vz_vcpu_setup(struct kvm_vcpu *vcpu)
 #endif
 	}
 
+	/* Implementation dependent, use the legacy layout */
+	if (cpu_guest_has_segments) {
+		/* SegCtl0, SegCtl1, SegCtl2 */
+		kvm_write_sw_gc0_segctl0(cop0, 0x00200010);
+		kvm_write_sw_gc0_segctl1(cop0, 0x00000002 |
+				(_page_cachable_default >> _CACHE_SHIFT) <<
+						(16 + MIPS_SEGCFG_C_SHIFT));
+		kvm_write_sw_gc0_segctl2(cop0, 0x00380438);
+	}
+
 	/* start with no pending virtual guest interrupts */
 	if (cpu_has_guestctl2)
 		cop0->reg[MIPS_CP0_GUESTCTL2][MIPS_CP0_GUESTCTL2_SEL] = 0;
-- 
git-series 0.8.10
