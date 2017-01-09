Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jan 2017 21:56:24 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:63803 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993876AbdAIUxd2py2P (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Jan 2017 21:53:33 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id A47992516E558;
        Mon,  9 Jan 2017 20:53:21 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 9 Jan 2017 20:53:25 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 6/10] KVM: MIPS/T&E: Add lockless GVA access helpers
Date:   Mon, 9 Jan 2017 20:51:58 +0000
Message-ID: <3b8bf455517d5772bdf8dede083f4057a7ce432a.1483993967.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
In-Reply-To: <cover.4133d2f24fd73c1889a46ea05bb8924867b33747.1483993967.git-series.james.hogan@imgtec.com>
References: <cover.4133d2f24fd73c1889a46ea05bb8924867b33747.1483993967.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56242
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

Add helpers to allow for lockless direct access to the GVA space, by
changing the VCPU mode to READING_SHADOW_PAGE_TABLES for the duration of
the access. This allows asynchronous TLB flush requests in future
patches to safely trigger either a TLB flush before the direct GVA space
access, or a delay until the in-progress lockless direct access is
complete.

The kvm_trap_emul_gva_lockless_begin() and
kvm_trap_emul_gva_lockless_end() helpers take care of guarding the
direct GVA accesses, and kvm_trap_emul_gva_fault() tries to handle a
uaccess fault resulting from a flush having taken place.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h | 15 ++++++++-
 arch/mips/kvm/mmu.c              | 51 ++++++++++++++++++++++++++-
 arch/mips/kvm/trap_emul.c        | 65 +++++++++++++++++++++++++++++++++-
 3 files changed, 131 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index b2d968ed2757..491689fcbaac 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -243,6 +243,7 @@ enum emulation_result {
 #define TLB_ASID(x)		((x).tlb_hi & KVM_ENTRYHI_ASID)
 #define TLB_LO_IDX(x, va)	(((va) >> PAGE_SHIFT) & 1)
 #define TLB_IS_VALID(x, va)	((x).tlb_lo[TLB_LO_IDX(x, va)] & ENTRYLO_V)
+#define TLB_IS_DIRTY(x, va)	((x).tlb_lo[TLB_LO_IDX(x, va)] & ENTRYLO_D)
 #define TLB_HI_VPN2_HIT(x, y)	((TLB_VPN2(x) & ~(x).tlb_mask) ==	\
 				 ((y) & VPN2_MASK & ~(x).tlb_mask))
 #define TLB_HI_ASID_HIT(x, y)	(TLB_IS_GLOBAL(x) ||			\
@@ -637,6 +638,20 @@ pgd_t *kvm_pgd_alloc(void);
 void kvm_mmu_free_memory_caches(struct kvm_vcpu *vcpu);
 void kvm_trap_emul_invalidate_gva(struct kvm_vcpu *vcpu, unsigned long addr,
 				  bool user);
+void kvm_trap_emul_gva_lockless_begin(struct kvm_vcpu *vcpu);
+void kvm_trap_emul_gva_lockless_end(struct kvm_vcpu *vcpu);
+
+enum kvm_mips_fault_result {
+	KVM_MIPS_MAPPED = 0,
+	KVM_MIPS_GVA,
+	KVM_MIPS_GPA,
+	KVM_MIPS_TLB,
+	KVM_MIPS_TLBINV,
+	KVM_MIPS_TLBMOD,
+};
+enum kvm_mips_fault_result kvm_trap_emul_gva_fault(struct kvm_vcpu *vcpu,
+						   unsigned long gva,
+						   bool write);
 
 /* Emulation */
 int kvm_get_inst(u32 *opc, struct kvm_vcpu *vcpu, u32 *out);
diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index e41ee36dd626..32c317de6c0a 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -732,6 +732,57 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 	local_irq_restore(flags);
 }
 
+/**
+ * kvm_trap_emul_gva_fault() - Safely attempt to handle a GVA access fault.
+ * @vcpu:	Virtual CPU.
+ * @gva:	Guest virtual address to be accessed.
+ * @write:	True if write attempted (must be dirtied and made writable).
+ *
+ * Safely attempt to handle a GVA fault, mapping GVA pages if necessary, and
+ * dirtying the page if @write so that guest instructions can be modified.
+ *
+ * Returns:	KVM_MIPS_MAPPED on success.
+ *		KVM_MIPS_GVA if bad guest virtual address.
+ *		KVM_MIPS_GPA if bad guest physical address.
+ *		KVM_MIPS_TLB if guest TLB not present.
+ *		KVM_MIPS_TLBINV if guest TLB present but not valid.
+ *		KVM_MIPS_TLBMOD if guest TLB read only.
+ */
+enum kvm_mips_fault_result kvm_trap_emul_gva_fault(struct kvm_vcpu *vcpu,
+						   unsigned long gva,
+						   bool write)
+{
+	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct kvm_mips_tlb *tlb;
+	int index;
+
+	if (KVM_GUEST_KSEGX(gva) == KVM_GUEST_KSEG0) {
+		if (kvm_mips_handle_kseg0_tlb_fault(gva, vcpu) < 0)
+			return KVM_MIPS_GPA;
+	} else if ((KVM_GUEST_KSEGX(gva) < KVM_GUEST_KSEG0) ||
+		   KVM_GUEST_KSEGX(gva) == KVM_GUEST_KSEG23) {
+		/* Address should be in the guest TLB */
+		index = kvm_mips_guest_tlb_lookup(vcpu, (gva & VPN2_MASK) |
+			  (kvm_read_c0_guest_entryhi(cop0) & KVM_ENTRYHI_ASID));
+		if (index < 0)
+			return KVM_MIPS_TLB;
+		tlb = &vcpu->arch.guest_tlb[index];
+
+		/* Entry should be valid, and dirty for writes */
+		if (!TLB_IS_VALID(*tlb, gva))
+			return KVM_MIPS_TLBINV;
+		if (write && !TLB_IS_DIRTY(*tlb, gva))
+			return KVM_MIPS_TLBMOD;
+
+		if (kvm_mips_handle_mapped_seg_tlb_fault(vcpu, tlb, gva))
+			return KVM_MIPS_GPA;
+	} else {
+		return KVM_MIPS_GVA;
+	}
+
+	return KVM_MIPS_MAPPED;
+}
+
 int kvm_get_inst(u32 *opc, struct kvm_vcpu *vcpu, u32 *out)
 {
 	int err;
diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index 0cb76e1aac0e..2cc637ed9e95 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -788,6 +788,71 @@ static void kvm_trap_emul_check_requests(struct kvm_vcpu *vcpu, int cpu,
 	}
 }
 
+/**
+ * kvm_trap_emul_gva_lockless_begin() - Begin lockless access to GVA space.
+ * @vcpu:	VCPU pointer.
+ *
+ * Call before a GVA space access outside of guest mode, to ensure that
+ * asynchronous TLB flush requests are handled or delayed until completion of
+ * the GVA access (as indicated by a matching kvm_trap_emul_gva_lockless_end()).
+ *
+ * Should be called with IRQs already enabled.
+ */
+void kvm_trap_emul_gva_lockless_begin(struct kvm_vcpu *vcpu)
+{
+	/* We re-enable IRQs in kvm_trap_emul_gva_lockless_end() */
+	WARN_ON_ONCE(irqs_disabled());
+
+	/*
+	 * The caller is about to access the GVA space, so we set the mode to
+	 * force TLB flush requests to send an IPI, and also disable IRQs to
+	 * delay IPI handling until kvm_trap_emul_gva_lockless_end().
+	 */
+	local_irq_disable();
+
+	/*
+	 * Make sure the read of VCPU requests is not reordered ahead of the
+	 * write to vcpu->mode, or we could miss a TLB flush request while
+	 * the requester sees the VCPU as outside of guest mode and not needing
+	 * an IPI.
+	 */
+	smp_store_mb(vcpu->mode, READING_SHADOW_PAGE_TABLES);
+
+	/*
+	 * If a TLB flush has been requested (potentially while
+	 * OUTSIDE_GUEST_MODE and assumed immediately effective), perform it
+	 * before accessing the GVA space, and be sure to reload the ASID if
+	 * necessary as it'll be immediately used.
+	 *
+	 * TLB flush requests after this check will trigger an IPI due to the
+	 * mode change above, which will be delayed due to IRQs disabled.
+	 */
+	kvm_trap_emul_check_requests(vcpu, smp_processor_id(), true);
+}
+
+/**
+ * kvm_trap_emul_gva_lockless_end() - End lockless access to GVA space.
+ * @vcpu:	VCPU pointer.
+ *
+ * Called after a GVA space access outside of guest mode. Should have a matching
+ * call to kvm_trap_emul_gva_lockless_begin().
+ */
+void kvm_trap_emul_gva_lockless_end(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * Make sure the write to vcpu->mode is not reordered in front of GVA
+	 * accesses, or a TLB flush requester may not think it necessary to send
+	 * an IPI.
+	 */
+	smp_store_release(&vcpu->mode, OUTSIDE_GUEST_MODE);
+
+	/*
+	 * Now that the access to GVA space is complete, its safe for pending
+	 * TLB flush request IPIs to be handled (which indicates completion).
+	 */
+	local_irq_enable();
+}
+
 static void kvm_trap_emul_vcpu_reenter(struct kvm_run *run,
 				       struct kvm_vcpu *vcpu)
 {
-- 
git-series 0.8.10
