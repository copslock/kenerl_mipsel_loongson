Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jun 2016 20:34:05 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:43854 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27042346AbcFOSaVfR5IW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Jun 2016 20:30:21 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 02A4D34254C7D;
        Wed, 15 Jun 2016 19:30:11 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 15 Jun 2016 19:30:15 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 13/17] MIPS: KVM: Move commpage so 0x0 is unmapped
Date:   Wed, 15 Jun 2016 19:29:57 +0100
Message-ID: <1466015401-24433-14-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 54066
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

The comm page which is mapped into the guest kernel address space at
0x0 has the unfortunate side effect of allowing guest kernel NULL
pointer dereferences to succeed. The only constraint on this address is
that it must be within 32KiB of 0x0, so that single lw/sw instructions
(which have 16-bit signed offset fields) can be used to access it, using
the zero register as a base.

So lets move the comm page as high as possible within that constraint so
that 0x0 can be left unmapped, at least for page sizes < 32KiB.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h | 10 ++++++++--
 arch/mips/kvm/commpage.c         |  2 +-
 arch/mips/kvm/dyntrans.c         |  4 ++--
 arch/mips/kvm/tlb.c              | 18 +++++++++---------
 4 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 5e9da2a31fde..6c43c782bdfa 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -74,8 +74,14 @@
 
 
 
-/* Special address that contains the comm page, used for reducing # of traps */
-#define KVM_GUEST_COMMPAGE_ADDR		0x0
+/*
+ * Special address that contains the comm page, used for reducing # of traps
+ * This needs to be within 32Kb of 0x0 (so the zero register can be used), but
+ * preferably not at 0x0 so that most kernel NULL pointer dereferences can be
+ * caught.
+ */
+#define KVM_GUEST_COMMPAGE_ADDR		((PAGE_SIZE > 0x8000) ?	0 : \
+					 (0x8000 - PAGE_SIZE))
 
 #define KVM_GUEST_KERNEL_MODE(vcpu)	((kvm_read_c0_guest_status(vcpu->arch.cop0) & (ST0_EXL | ST0_ERL)) || \
 					((kvm_read_c0_guest_status(vcpu->arch.cop0) & KSU_USER) == 0))
diff --git a/arch/mips/kvm/commpage.c b/arch/mips/kvm/commpage.c
index 2d6e976d1add..a36b77e1705c 100644
--- a/arch/mips/kvm/commpage.c
+++ b/arch/mips/kvm/commpage.c
@@ -4,7 +4,7 @@
  * for more details.
  *
  * commpage, currently used for Virtual COP0 registers.
- * Mapped into the guest kernel @ 0x0.
+ * Mapped into the guest kernel @ KVM_GUEST_COMMPAGE_ADDR.
  *
  * Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
  * Authors: Sanjay Lal <sanjayl@kymasys.com>
diff --git a/arch/mips/kvm/dyntrans.c b/arch/mips/kvm/dyntrans.c
index a3031dae8d1b..8a1833b9eb38 100644
--- a/arch/mips/kvm/dyntrans.c
+++ b/arch/mips/kvm/dyntrans.c
@@ -93,7 +93,7 @@ int kvm_mips_trans_mfc0(union mips_instruction inst, u32 *opc,
 	} else {
 		mfc0_inst.i_format.opcode = lw_op;
 		mfc0_inst.i_format.rt = inst.c0r_format.rt;
-		mfc0_inst.i_format.simmediate =
+		mfc0_inst.i_format.simmediate = KVM_GUEST_COMMPAGE_ADDR |
 			offsetof(struct kvm_mips_commpage, cop0.reg[rd][sel]);
 	}
 
@@ -111,7 +111,7 @@ int kvm_mips_trans_mtc0(union mips_instruction inst, u32 *opc,
 
 	mtc0_inst.i_format.opcode = sw_op;
 	mtc0_inst.i_format.rt = inst.c0r_format.rt;
-	mtc0_inst.i_format.simmediate =
+	mtc0_inst.i_format.simmediate = KVM_GUEST_COMMPAGE_ADDR |
 		offsetof(struct kvm_mips_commpage, cop0.reg[rd][sel]);
 
 	return kvm_mips_trans_replace(vcpu, opc, mtc0_inst);
diff --git a/arch/mips/kvm/tlb.c b/arch/mips/kvm/tlb.c
index 8012e686d4ae..385fbd34e77d 100644
--- a/arch/mips/kvm/tlb.c
+++ b/arch/mips/kvm/tlb.c
@@ -171,23 +171,23 @@ EXPORT_SYMBOL_GPL(kvm_mips_host_tlb_write);
 int kvm_mips_handle_commpage_tlb_fault(unsigned long badvaddr,
 	struct kvm_vcpu *vcpu)
 {
-	kvm_pfn_t pfn0, pfn1;
+	kvm_pfn_t pfn;
 	unsigned long flags, old_entryhi = 0, vaddr = 0;
-	unsigned long entrylo0 = 0, entrylo1 = 0;
+	unsigned long entrylo[2] = { 0, 0 };
+	unsigned int pair_idx;
 
-	pfn0 = CPHYSADDR(vcpu->arch.kseg0_commpage) >> PAGE_SHIFT;
-	pfn1 = 0;
-	entrylo0 = mips3_paddr_to_tlbpfn(pfn0 << PAGE_SHIFT) |
-		   (0x3 << ENTRYLO_C_SHIFT) | ENTRYLO_D | ENTRYLO_V;
-	entrylo1 = 0;
+	pfn = CPHYSADDR(vcpu->arch.kseg0_commpage) >> PAGE_SHIFT;
+	pair_idx = (badvaddr >> PAGE_SHIFT) & 1;
+	entrylo[pair_idx] = mips3_paddr_to_tlbpfn(pfn << PAGE_SHIFT) |
+		(0x3 << ENTRYLO_C_SHIFT) | ENTRYLO_D | ENTRYLO_V;
 
 	local_irq_save(flags);
 
 	old_entryhi = read_c0_entryhi();
 	vaddr = badvaddr & (PAGE_MASK << 1);
 	write_c0_entryhi(vaddr | kvm_mips_get_kernel_asid(vcpu));
-	write_c0_entrylo0(entrylo0);
-	write_c0_entrylo1(entrylo1);
+	write_c0_entrylo0(entrylo[0]);
+	write_c0_entrylo1(entrylo[1]);
 	write_c0_index(kvm_mips_get_commpage_asid(vcpu));
 	mtc0_tlbw_hazard();
 	tlb_write_indexed();
-- 
2.4.10
