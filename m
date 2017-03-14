Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2017 18:01:11 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:35762 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993943AbdCNRAUa0qjE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Mar 2017 18:00:20 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 24464DAE93776;
        Tue, 14 Mar 2017 17:00:10 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 14 Mar 2017 17:00:14 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 2/2] KVM: MIPS/Emulate: Properly implement TLBR for T&E
Date:   Tue, 14 Mar 2017 17:00:08 +0000
Message-ID: <3688052f24c8ffb26c87c7376de44732f25bcdd6.1489510483.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.1
MIME-Version: 1.0
In-Reply-To: <cover.57583f73c169e83d499329fbda19909b816c0024.1489510483.git-series.james.hogan@imgtec.com>
References: <cover.57583f73c169e83d499329fbda19909b816c0024.1489510483.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57258
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

Properly implement emulation of the TLBR instruction for Trap & Emulate.
This instruction reads the TLB entry pointed at by the CP0_Index
register into the other TLB registers, which may have the side effect of
changing the current ASID. Therefore abstract the CP0_EntryHi and ASID
changing code into a common function in the process.

A comment indicated that Linux doesn't use TLBR, which is true during
normal use, however dumping of the TLB does use it (for example with the
relatively recent 'x' magic sysrq key), as does a wired TLB entries test
case in my KVM tests.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/emulate.c |  99 +++++++++++++++++++++--------------------
 1 file changed, 53 insertions(+), 46 deletions(-)

diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index dd47f2bda01b..e82630b93270 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -990,17 +990,62 @@ enum emulation_result kvm_mips_emul_wait(struct kvm_vcpu *vcpu)
 	return EMULATE_DONE;
 }
 
-/*
- * XXXKYMA: Linux doesn't seem to use TLBR, return EMULATE_FAIL for now so that
- * we can catch this, if things ever change
- */
+static void kvm_mips_change_entryhi(struct kvm_vcpu *vcpu,
+				    unsigned long entryhi)
+{
+	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct mm_struct *kern_mm = &vcpu->arch.guest_kernel_mm;
+	int cpu, i;
+	u32 nasid = entryhi & KVM_ENTRYHI_ASID;
+
+	if (((kvm_read_c0_guest_entryhi(cop0) & KVM_ENTRYHI_ASID) != nasid)) {
+		trace_kvm_asid_change(vcpu, kvm_read_c0_guest_entryhi(cop0) &
+				      KVM_ENTRYHI_ASID, nasid);
+
+		/*
+		 * Flush entries from the GVA page tables.
+		 * Guest user page table will get flushed lazily on re-entry to
+		 * guest user if the guest ASID actually changes.
+		 */
+		kvm_mips_flush_gva_pt(kern_mm->pgd, KMF_KERN);
+
+		/*
+		 * Regenerate/invalidate kernel MMU context.
+		 * The user MMU context will be regenerated lazily on re-entry
+		 * to guest user if the guest ASID actually changes.
+		 */
+		preempt_disable();
+		cpu = smp_processor_id();
+		get_new_mmu_context(kern_mm, cpu);
+		for_each_possible_cpu(i)
+			if (i != cpu)
+				cpu_context(i, kern_mm) = 0;
+		preempt_enable();
+	}
+	kvm_write_c0_guest_entryhi(cop0, entryhi);
+}
+
 enum emulation_result kvm_mips_emul_tlbr(struct kvm_vcpu *vcpu)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct kvm_mips_tlb *tlb;
 	unsigned long pc = vcpu->arch.pc;
+	int index;
 
-	kvm_err("[%#lx] COP0_TLBR [%d]\n", pc, kvm_read_c0_guest_index(cop0));
-	return EMULATE_FAIL;
+	index = kvm_read_c0_guest_index(cop0);
+	if (index < 0 || index >= KVM_MIPS_GUEST_TLB_SIZE) {
+		/* UNDEFINED */
+		kvm_debug("[%#lx] TLBR Index %#x out of range\n", pc, index);
+		index &= KVM_MIPS_GUEST_TLB_SIZE - 1;
+	}
+
+	tlb = &vcpu->arch.guest_tlb[index];
+	kvm_write_c0_guest_pagemask(cop0, tlb->tlb_mask);
+	kvm_write_c0_guest_entrylo0(cop0, tlb->tlb_lo[0]);
+	kvm_write_c0_guest_entrylo1(cop0, tlb->tlb_lo[1]);
+	kvm_mips_change_entryhi(vcpu, tlb->tlb_hi);
+
+	return EMULATE_DONE;
 }
 
 /**
@@ -1224,11 +1269,9 @@ enum emulation_result kvm_mips_emulate_CP0(union mips_instruction inst,
 					   struct kvm_vcpu *vcpu)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
-	struct mm_struct *kern_mm = &vcpu->arch.guest_kernel_mm;
 	enum emulation_result er = EMULATE_DONE;
 	u32 rt, rd, sel;
 	unsigned long curr_pc;
-	int cpu, i;
 
 	/*
 	 * Update PC and hold onto current PC in case there is
@@ -1330,44 +1373,8 @@ enum emulation_result kvm_mips_emulate_CP0(union mips_instruction inst,
 				kvm_change_c0_guest_ebase(cop0, 0x1ffff000,
 							  vcpu->arch.gprs[rt]);
 			} else if (rd == MIPS_CP0_TLB_HI && sel == 0) {
-				u32 nasid =
-					vcpu->arch.gprs[rt] & KVM_ENTRYHI_ASID;
-				if (((kvm_read_c0_guest_entryhi(cop0) &
-				      KVM_ENTRYHI_ASID) != nasid)) {
-					trace_kvm_asid_change(vcpu,
-						kvm_read_c0_guest_entryhi(cop0)
-							& KVM_ENTRYHI_ASID,
-						nasid);
-
-					/*
-					 * Flush entries from the GVA page
-					 * tables.
-					 * Guest user page table will get
-					 * flushed lazily on re-entry to guest
-					 * user if the guest ASID actually
-					 * changes.
-					 */
-					kvm_mips_flush_gva_pt(kern_mm->pgd,
-							      KMF_KERN);
-
-					/*
-					 * Regenerate/invalidate kernel MMU
-					 * context.
-					 * The user MMU context will be
-					 * regenerated lazily on re-entry to
-					 * guest user if the guest ASID actually
-					 * changes.
-					 */
-					preempt_disable();
-					cpu = smp_processor_id();
-					get_new_mmu_context(kern_mm, cpu);
-					for_each_possible_cpu(i)
-						if (i != cpu)
-							cpu_context(i, kern_mm) = 0;
-					preempt_enable();
-				}
-				kvm_write_c0_guest_entryhi(cop0,
-							   vcpu->arch.gprs[rt]);
+				kvm_mips_change_entryhi(vcpu,
+							vcpu->arch.gprs[rt]);
 			}
 			/* Are we writing to COUNT */
 			else if ((rd == MIPS_CP0_COUNT) && (sel == 0)) {
-- 
git-series 0.8.10
