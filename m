Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Mar 2017 10:45:46 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:44459 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992213AbdCBJhjb0Tjt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Mar 2017 10:37:39 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 4EBCDCCCAE227;
        Thu,  2 Mar 2017 09:37:30 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 2 Mar 2017 09:37:32 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 19/32] KVM: MIPS/TLB: Add VZ TLB management
Date:   Thu, 2 Mar 2017 09:36:46 +0000
Message-ID: <83a35a320cae0f1b742201e94014c62744b6bc7c.1488447004.git-series.james.hogan@imgtec.com>
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
X-archive-position: 56979
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

Add functions for MIPS VZ TLB management to tlb.c.

kvm_vz_host_tlb_inv() will be used for invalidating root TLB entries
after GPA page tables have been modified due to a KVM page fault. It
arranges for a root GPA mapping to be flushed from the TLB, using the
gpa_mm ASID or the current GuestID to do the probe.

kvm_vz_local_flush_roottlb_all_guests() and
kvm_vz_local_flush_guesttlb_all() flush all TLB entries in the
corresponding TLB for guest mappings (GPA->RPA for root TLB with
GuestID, and all entries for guest TLB). They will be used when starting
a new GuestID cycle, when VZ hardware is enabled/disabled, and also when
switching to a guest when the guest TLB contents may be stale or belong
to a different VM.

kvm_vz_guest_tlb_lookup() converts a guest virtual address to a guest
physical address using the guest TLB. This will be used to decode guest
virtual addresses which are sometimes provided by VZ hardware in
CP0_BadVAddr for certain exceptions when the guest physical address is
unavailable.

kvm_vz_save_guesttlb() and kvm_vz_load_guesttlb() will be used to
preserve wired guest VTLB entries while a guest isn't running.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/cpu-info.h |   1 +-
 arch/mips/include/asm/kvm_host.h |  12 +-
 arch/mips/kvm/tlb.c              | 404 ++++++++++++++++++++++++++++++++-
 3 files changed, 417 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/cpu-info.h b/arch/mips/include/asm/cpu-info.h
index edbe2734a1bf..4113796e0ef4 100644
--- a/arch/mips/include/asm/cpu-info.h
+++ b/arch/mips/include/asm/cpu-info.h
@@ -33,6 +33,7 @@ struct guest_info {
 	unsigned long		ases_dyn;
 	unsigned long long	options;
 	unsigned long long	options_dyn;
+	int			tlbsize;
 	u8			conf;
 	u8			kscratch_mask;
 };
diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 9938c665729e..6c1b5bedf7e9 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -815,6 +815,18 @@ extern int kvm_mips_host_tlb_inv(struct kvm_vcpu *vcpu, unsigned long entryhi,
 extern int kvm_mips_guest_tlb_lookup(struct kvm_vcpu *vcpu,
 				     unsigned long entryhi);
 
+#ifdef CONFIG_KVM_MIPS_VZ
+int kvm_vz_host_tlb_inv(struct kvm_vcpu *vcpu, unsigned long entryhi);
+int kvm_vz_guest_tlb_lookup(struct kvm_vcpu *vcpu, unsigned long gva,
+			    unsigned long *gpa);
+void kvm_vz_local_flush_roottlb_all_guests(void);
+void kvm_vz_local_flush_guesttlb_all(void);
+void kvm_vz_save_guesttlb(struct kvm_mips_tlb *buf, unsigned int index,
+			  unsigned int count);
+void kvm_vz_load_guesttlb(const struct kvm_mips_tlb *buf, unsigned int index,
+			  unsigned int count);
+#endif
+
 void kvm_mips_suspend_mm(int cpu);
 void kvm_mips_resume_mm(int cpu);
 
diff --git a/arch/mips/kvm/tlb.c b/arch/mips/kvm/tlb.c
index 2819eb793345..a28fcb1e5072 100644
--- a/arch/mips/kvm/tlb.c
+++ b/arch/mips/kvm/tlb.c
@@ -33,6 +33,18 @@
 #define KVM_GUEST_PC_TLB    0
 #define KVM_GUEST_SP_TLB    1
 
+#ifdef CONFIG_KVM_MIPS_VZ
+static u32 kvm_mips_get_root_asid(struct kvm_vcpu *vcpu)
+{
+	struct mm_struct *gpa_mm = &vcpu->kvm->arch.gpa_mm;
+
+	if (cpu_has_guestid)
+		return 0;
+	else
+		return cpu_asid(smp_processor_id(), gpa_mm);
+}
+#endif
+
 static u32 kvm_mips_get_kernel_asid(struct kvm_vcpu *vcpu)
 {
 	struct mm_struct *kern_mm = &vcpu->arch.guest_kernel_mm;
@@ -179,6 +191,398 @@ int kvm_mips_host_tlb_inv(struct kvm_vcpu *vcpu, unsigned long va,
 }
 EXPORT_SYMBOL_GPL(kvm_mips_host_tlb_inv);
 
+#ifdef CONFIG_KVM_MIPS_VZ
+
+/* GuestID management */
+
+/**
+ * clear_root_gid() - Set GuestCtl1.RID for normal root operation.
+ */
+static inline void clear_root_gid(void)
+{
+	if (cpu_has_guestid) {
+		clear_c0_guestctl1(MIPS_GCTL1_RID);
+		mtc0_tlbw_hazard();
+	}
+}
+
+/**
+ * set_root_gid_to_guest_gid() - Set GuestCtl1.RID to match GuestCtl1.ID.
+ *
+ * Sets the root GuestID to match the current guest GuestID, for TLB operation
+ * on the GPA->RPA mappings in the root TLB.
+ *
+ * The caller must be sure to disable HTW while the root GID is set, and
+ * possibly longer if TLB registers are modified.
+ */
+static inline void set_root_gid_to_guest_gid(void)
+{
+	unsigned int guestctl1;
+
+	if (cpu_has_guestid) {
+		back_to_back_c0_hazard();
+		guestctl1 = read_c0_guestctl1();
+		guestctl1 = (guestctl1 & ~MIPS_GCTL1_RID) |
+			((guestctl1 & MIPS_GCTL1_ID) >> MIPS_GCTL1_ID_SHIFT)
+						     << MIPS_GCTL1_RID_SHIFT;
+		write_c0_guestctl1(guestctl1);
+		mtc0_tlbw_hazard();
+	}
+}
+
+int kvm_vz_host_tlb_inv(struct kvm_vcpu *vcpu, unsigned long va)
+{
+	int idx;
+	unsigned long flags, old_entryhi;
+
+	local_irq_save(flags);
+	htw_stop();
+
+	/* Set root GuestID for root probe and write of guest TLB entry */
+	set_root_gid_to_guest_gid();
+
+	old_entryhi = read_c0_entryhi();
+
+	idx = _kvm_mips_host_tlb_inv((va & VPN2_MASK) |
+				     kvm_mips_get_root_asid(vcpu));
+
+	write_c0_entryhi(old_entryhi);
+	clear_root_gid();
+	mtc0_tlbw_hazard();
+
+	htw_start();
+	local_irq_restore(flags);
+
+	if (idx > 0)
+		kvm_debug("%s: Invalidated root entryhi %#lx @ idx %d\n",
+			  __func__, (va & VPN2_MASK) |
+				    kvm_mips_get_root_asid(vcpu), idx);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kvm_vz_host_tlb_inv);
+
+/**
+ * kvm_vz_guest_tlb_lookup() - Lookup a guest VZ TLB mapping.
+ * @vcpu:	KVM VCPU pointer.
+ * @gpa:	Guest virtual address in a TLB mapped guest segment.
+ * @gpa:	Ponter to output guest physical address it maps to.
+ *
+ * Converts a guest virtual address in a guest TLB mapped segment to a guest
+ * physical address, by probing the guest TLB.
+ *
+ * Returns:	0 if guest TLB mapping exists for @gva. *@gpa will have been
+ *		written.
+ *		-EFAULT if no guest TLB mapping exists for @gva. *@gpa may not
+ *		have been written.
+ */
+int kvm_vz_guest_tlb_lookup(struct kvm_vcpu *vcpu, unsigned long gva,
+			    unsigned long *gpa)
+{
+	unsigned long o_entryhi, o_entrylo[2], o_pagemask;
+	unsigned int o_index;
+	unsigned long entrylo[2], pagemask, pagemaskbit, pa;
+	unsigned long flags;
+	int index;
+
+	/* Probe the guest TLB for a mapping */
+	local_irq_save(flags);
+	/* Set root GuestID for root probe of guest TLB entry */
+	htw_stop();
+	set_root_gid_to_guest_gid();
+
+	o_entryhi = read_gc0_entryhi();
+	o_index = read_gc0_index();
+
+	write_gc0_entryhi((o_entryhi & 0x3ff) | (gva & ~0xfffl));
+	mtc0_tlbw_hazard();
+	guest_tlb_probe();
+	tlb_probe_hazard();
+
+	index = read_gc0_index();
+	if (index < 0) {
+		/* No match, fail */
+		write_gc0_entryhi(o_entryhi);
+		write_gc0_index(o_index);
+
+		clear_root_gid();
+		htw_start();
+		local_irq_restore(flags);
+		return -EFAULT;
+	}
+
+	/* Match! read the TLB entry */
+	o_entrylo[0] = read_gc0_entrylo0();
+	o_entrylo[1] = read_gc0_entrylo1();
+	o_pagemask = read_gc0_pagemask();
+
+	mtc0_tlbr_hazard();
+	guest_tlb_read();
+	tlb_read_hazard();
+
+	entrylo[0] = read_gc0_entrylo0();
+	entrylo[1] = read_gc0_entrylo1();
+	pagemask = ~read_gc0_pagemask() & ~0x1fffl;
+
+	write_gc0_entryhi(o_entryhi);
+	write_gc0_index(o_index);
+	write_gc0_entrylo0(o_entrylo[0]);
+	write_gc0_entrylo1(o_entrylo[1]);
+	write_gc0_pagemask(o_pagemask);
+
+	clear_root_gid();
+	htw_start();
+	local_irq_restore(flags);
+
+	/* Select one of the EntryLo values and interpret the GPA */
+	pagemaskbit = (pagemask ^ (pagemask & (pagemask - 1))) >> 1;
+	pa = entrylo[!!(gva & pagemaskbit)];
+
+	/*
+	 * TLB entry may have become invalid since TLB probe if physical FTLB
+	 * entries are shared between threads (e.g. I6400).
+	 */
+	if (!(pa & ENTRYLO_V))
+		return -EFAULT;
+
+	/*
+	 * Note, this doesn't take guest MIPS32 XPA into account, where PFN is
+	 * split with XI/RI in the middle.
+	 */
+	pa = (pa << 6) & ~0xfffl;
+	pa |= gva & ~(pagemask | pagemaskbit);
+
+	*gpa = pa;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kvm_vz_guest_tlb_lookup);
+
+/**
+ * kvm_vz_local_flush_roottlb_all_guests() - Flush all root TLB entries for
+ * guests.
+ *
+ * Invalidate all entries in root tlb which are GPA mappings.
+ */
+void kvm_vz_local_flush_roottlb_all_guests(void)
+{
+	unsigned long flags;
+	unsigned long old_entryhi, old_pagemask, old_guestctl1;
+	int entry;
+
+	if (WARN_ON(!cpu_has_guestid))
+		return;
+
+	local_irq_save(flags);
+	htw_stop();
+
+	/* TLBR may clobber EntryHi.ASID, PageMask, and GuestCtl1.RID */
+	old_entryhi = read_c0_entryhi();
+	old_pagemask = read_c0_pagemask();
+	old_guestctl1 = read_c0_guestctl1();
+
+	/*
+	 * Invalidate guest entries in root TLB while leaving root entries
+	 * intact when possible.
+	 */
+	for (entry = 0; entry < current_cpu_data.tlbsize; entry++) {
+		write_c0_index(entry);
+		mtc0_tlbw_hazard();
+		tlb_read();
+		tlb_read_hazard();
+
+		/* Don't invalidate non-guest (RVA) mappings in the root TLB */
+		if (!(read_c0_guestctl1() & MIPS_GCTL1_RID))
+			continue;
+
+		/* Make sure all entries differ. */
+		write_c0_entryhi(UNIQUE_ENTRYHI(entry));
+		write_c0_entrylo0(0);
+		write_c0_entrylo1(0);
+		write_c0_guestctl1(0);
+		mtc0_tlbw_hazard();
+		tlb_write_indexed();
+	}
+
+	write_c0_entryhi(old_entryhi);
+	write_c0_pagemask(old_pagemask);
+	write_c0_guestctl1(old_guestctl1);
+	tlbw_use_hazard();
+
+	htw_start();
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL_GPL(kvm_vz_local_flush_roottlb_all_guests);
+
+/**
+ * kvm_vz_local_flush_guesttlb_all() - Flush all guest TLB entries.
+ *
+ * Invalidate all entries in guest tlb irrespective of guestid.
+ */
+void kvm_vz_local_flush_guesttlb_all(void)
+{
+	unsigned long flags;
+	unsigned long old_index;
+	unsigned long old_entryhi;
+	unsigned long old_entrylo[2];
+	unsigned long old_pagemask;
+	int entry;
+
+	local_irq_save(flags);
+
+	/* Preserve all clobbered guest registers */
+	old_index = read_gc0_index();
+	old_entryhi = read_gc0_entryhi();
+	old_entrylo[0] = read_gc0_entrylo0();
+	old_entrylo[1] = read_gc0_entrylo1();
+	old_pagemask = read_gc0_pagemask();
+
+	/* Invalidate guest entries in guest TLB */
+	write_gc0_entrylo0(0);
+	write_gc0_entrylo1(0);
+	write_gc0_pagemask(0);
+	for (entry = 0; entry < current_cpu_data.guest.tlbsize; entry++) {
+		/* Make sure all entries differ. */
+		write_gc0_index(entry);
+		write_gc0_entryhi(UNIQUE_GUEST_ENTRYHI(entry));
+		mtc0_tlbw_hazard();
+		guest_tlb_write_indexed();
+	}
+	write_gc0_index(old_index);
+	write_gc0_entryhi(old_entryhi);
+	write_gc0_entrylo0(old_entrylo[0]);
+	write_gc0_entrylo1(old_entrylo[1]);
+	write_gc0_pagemask(old_pagemask);
+	tlbw_use_hazard();
+
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL_GPL(kvm_vz_local_flush_guesttlb_all);
+
+/**
+ * kvm_vz_save_guesttlb() - Save a range of guest TLB entries.
+ * @buf:	Buffer to write TLB entries into.
+ * @index:	Start index.
+ * @count:	Number of entries to save.
+ *
+ * Save a range of guest TLB entries. The caller must ensure interrupts are
+ * disabled.
+ */
+void kvm_vz_save_guesttlb(struct kvm_mips_tlb *buf, unsigned int index,
+			  unsigned int count)
+{
+	unsigned int end = index + count;
+	unsigned long old_entryhi, old_entrylo0, old_entrylo1, old_pagemask;
+	unsigned int guestctl1 = 0;
+	int old_index, i;
+
+	/* Save registers we're about to clobber */
+	old_index = read_gc0_index();
+	old_entryhi = read_gc0_entryhi();
+	old_entrylo0 = read_gc0_entrylo0();
+	old_entrylo1 = read_gc0_entrylo1();
+	old_pagemask = read_gc0_pagemask();
+
+	/* Set root GuestID for root probe */
+	htw_stop();
+	set_root_gid_to_guest_gid();
+	if (cpu_has_guestid)
+		guestctl1 = read_c0_guestctl1();
+
+	/* Read each entry from guest TLB */
+	for (i = index; i < end; ++i, ++buf) {
+		write_gc0_index(i);
+
+		mtc0_tlbr_hazard();
+		guest_tlb_read();
+		tlb_read_hazard();
+
+		if (cpu_has_guestid &&
+		    (read_c0_guestctl1() ^ guestctl1) & MIPS_GCTL1_RID) {
+			/* Entry invalid or belongs to another guest */
+			buf->tlb_hi = UNIQUE_GUEST_ENTRYHI(i);
+			buf->tlb_lo[0] = 0;
+			buf->tlb_lo[1] = 0;
+			buf->tlb_mask = 0;
+		} else {
+			/* Entry belongs to the right guest */
+			buf->tlb_hi = read_gc0_entryhi();
+			buf->tlb_lo[0] = read_gc0_entrylo0();
+			buf->tlb_lo[1] = read_gc0_entrylo1();
+			buf->tlb_mask = read_gc0_pagemask();
+		}
+	}
+
+	/* Clear root GuestID again */
+	clear_root_gid();
+	htw_start();
+
+	/* Restore clobbered registers */
+	write_gc0_index(old_index);
+	write_gc0_entryhi(old_entryhi);
+	write_gc0_entrylo0(old_entrylo0);
+	write_gc0_entrylo1(old_entrylo1);
+	write_gc0_pagemask(old_pagemask);
+
+	tlbw_use_hazard();
+}
+EXPORT_SYMBOL_GPL(kvm_vz_save_guesttlb);
+
+/**
+ * kvm_vz_load_guesttlb() - Save a range of guest TLB entries.
+ * @buf:	Buffer to read TLB entries from.
+ * @index:	Start index.
+ * @count:	Number of entries to load.
+ *
+ * Load a range of guest TLB entries. The caller must ensure interrupts are
+ * disabled.
+ */
+void kvm_vz_load_guesttlb(const struct kvm_mips_tlb *buf, unsigned int index,
+			  unsigned int count)
+{
+	unsigned int end = index + count;
+	unsigned long old_entryhi, old_entrylo0, old_entrylo1, old_pagemask;
+	int old_index, i;
+
+	/* Save registers we're about to clobber */
+	old_index = read_gc0_index();
+	old_entryhi = read_gc0_entryhi();
+	old_entrylo0 = read_gc0_entrylo0();
+	old_entrylo1 = read_gc0_entrylo1();
+	old_pagemask = read_gc0_pagemask();
+
+	/* Set root GuestID for root probe */
+	htw_stop();
+	set_root_gid_to_guest_gid();
+
+	/* Write each entry to guest TLB */
+	for (i = index; i < end; ++i, ++buf) {
+		write_gc0_index(i);
+		write_gc0_entryhi(buf->tlb_hi);
+		write_gc0_entrylo0(buf->tlb_lo[0]);
+		write_gc0_entrylo1(buf->tlb_lo[1]);
+		write_gc0_pagemask(buf->tlb_mask);
+
+		mtc0_tlbw_hazard();
+		guest_tlb_write_indexed();
+	}
+
+	/* Clear root GuestID again */
+	clear_root_gid();
+	htw_start();
+
+	/* Restore clobbered registers */
+	write_gc0_index(old_index);
+	write_gc0_entryhi(old_entryhi);
+	write_gc0_entrylo0(old_entrylo0);
+	write_gc0_entrylo1(old_entrylo1);
+	write_gc0_pagemask(old_pagemask);
+
+	tlbw_use_hazard();
+}
+EXPORT_SYMBOL_GPL(kvm_vz_load_guesttlb);
+
+#endif
+
 /**
  * kvm_mips_suspend_mm() - Suspend the active mm.
  * @cpu		The CPU we're running on.
-- 
git-series 0.8.10
