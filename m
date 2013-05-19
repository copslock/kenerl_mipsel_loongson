Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 May 2013 07:53:03 +0200 (CEST)
Received: from kymasys.com ([64.62.140.43]:52828 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6835028Ab3ESFtDKbl79 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 19 May 2013 07:49:03 +0200
Received: from agni.kymasys.com ([75.40.23.192]) by kymasys.com for <linux-mips@linux-mips.org>; Sat, 18 May 2013 22:48:55 -0700
Received: by agni.kymasys.com (Postfix, from userid 500)
        id 4433B630063; Sat, 18 May 2013 22:47:43 -0700 (PDT)
From:   Sanjay Lal <sanjayl@kymasys.com>
To:     kvm@vger.kernel.org
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Gleb Natapov <gleb@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Sanjay Lal <sanjayl@kymasys.com>
Subject: [PATCH 11/18] KVM/MIPS32-VZ: VZ: Handle Guest TLB faults that are handled in Root context
Date:   Sat, 18 May 2013 22:47:33 -0700
Message-Id: <1368942460-15577-12-git-send-email-sanjayl@kymasys.com>
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1368942460-15577-1-git-send-email-sanjayl@kymasys.com>
References: <n>
 <1368942460-15577-1-git-send-email-sanjayl@kymasys.com>
Return-Path: <sanjayl@kymasys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36468
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sanjayl@kymasys.com
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

- Guest physical addresses need to be mapped by the Root TLB.

Signed-off-by: Sanjay Lal <sanjayl@kymasys.com>
---
 arch/mips/kvm/kvm_tlb.c | 444 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 359 insertions(+), 85 deletions(-)

diff --git a/arch/mips/kvm/kvm_tlb.c b/arch/mips/kvm/kvm_tlb.c
index 89511a9..5b1a221 100644
--- a/arch/mips/kvm/kvm_tlb.c
+++ b/arch/mips/kvm/kvm_tlb.c
@@ -17,12 +17,16 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/kvm_host.h>
+#include <linux/srcu.h>
 
 #include <asm/cpu.h>
 #include <asm/bootinfo.h>
 #include <asm/mmu_context.h>
 #include <asm/pgtable.h>
 #include <asm/cacheflush.h>
+#ifdef CONFIG_KVM_MIPS_VZ
+#include <asm/mipsvzregs.h>
+#endif
 
 #undef CONFIG_MIPS_MT
 #include <asm/r4kcache.h>
@@ -33,8 +37,12 @@
 
 #define PRIx64 "llx"
 
+#ifdef CONFIG_KVM_MIPS_VZ
 /* Use VZ EntryHi.EHINV to invalidate TLB entries */
+#define UNIQUE_ENTRYHI(idx) (ENTRYHI_EHINV | (CKSEG0 + ((idx) << (PAGE_SHIFT + 1))))
+#else
 #define UNIQUE_ENTRYHI(idx) (CKSEG0 + ((idx) << (PAGE_SHIFT + 1)))
+#endif
 
 atomic_t kvm_mips_instance;
 EXPORT_SYMBOL(kvm_mips_instance);
@@ -51,13 +59,13 @@ EXPORT_SYMBOL(kvm_mips_is_error_pfn);
 
 uint32_t kvm_mips_get_kernel_asid(struct kvm_vcpu *vcpu)
 {
-	return ASID_MASK(vcpu->arch.guest_kernel_asid[smp_processor_id()]);
+	return vcpu->arch.guest_kernel_asid[smp_processor_id()] & ASID_MASK;
 }
 
 
 uint32_t kvm_mips_get_user_asid(struct kvm_vcpu *vcpu)
 {
-	return ASID_MASK(vcpu->arch.guest_user_asid[smp_processor_id()]);
+	return vcpu->arch.guest_user_asid[smp_processor_id()] & ASID_MASK;
 }
 
 inline uint32_t kvm_mips_get_commpage_asid (struct kvm_vcpu *vcpu)
@@ -72,11 +80,11 @@ inline uint32_t kvm_mips_get_commpage_asid (struct kvm_vcpu *vcpu)
 
 void kvm_mips_dump_host_tlbs(void)
 {
-	unsigned long old_entryhi;
-	unsigned long old_pagemask;
 	struct kvm_mips_tlb tlb;
-	unsigned long flags;
 	int i;
+	ulong flags;
+	unsigned long old_entryhi;
+	unsigned long old_pagemask;
 
 	local_irq_save(flags);
 
@@ -84,7 +92,7 @@ void kvm_mips_dump_host_tlbs(void)
 	old_pagemask = read_c0_pagemask();
 
 	printk("HOST TLBs:\n");
-	printk("ASID: %#lx\n", ASID_MASK(read_c0_entryhi()));
+	printk("ASID: %#lx\n", read_c0_entryhi() & ASID_MASK);
 
 	for (i = 0; i < current_cpu_data.tlbsize; i++) {
 		write_c0_index(i);
@@ -97,10 +105,23 @@ void kvm_mips_dump_host_tlbs(void)
 		tlb.tlb_lo0 = read_c0_entrylo0();
 		tlb.tlb_lo1 = read_c0_entrylo1();
 		tlb.tlb_mask = read_c0_pagemask();
+#ifdef CONFIG_KVM_MIPS_VZ
+		tlb.guestctl1 = 0;
+		if (cpu_has_vzguestid) {
+			tlb.guestctl1 = read_c0_guestctl1();
+			/* clear GuestRID after tlb_read in case it was changed */
+			mips32_ClearGuestRID();
+		}
+#endif
 
 		printk("TLB%c%3d Hi 0x%08lx ",
 		       (tlb.tlb_lo0 | tlb.tlb_lo1) & MIPS3_PG_V ? ' ' : '*',
 		       i, tlb.tlb_hi);
+#ifdef CONFIG_KVM_MIPS_VZ
+		if (cpu_has_vzguestid) {
+			printk("GuestCtl1 0x%08x ", tlb.guestctl1);
+		}
+#endif
 		printk("Lo0=0x%09" PRIx64 " %c%c attr %lx ",
 		       (uint64_t) mips3_tlbpfn_to_paddr(tlb.tlb_lo0),
 		       (tlb.tlb_lo0 & MIPS3_PG_D) ? 'D' : ' ',
@@ -120,9 +141,9 @@ void kvm_mips_dump_host_tlbs(void)
 
 void kvm_mips_dump_guest_tlbs(struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
-	struct kvm_mips_tlb tlb;
 	int i;
+	struct kvm_mips_tlb tlb;
+	struct mips_coproc *cop0 = vcpu->arch.cop0;
 
 	printk("Guest TLBs:\n");
 	printk("Guest EntryHi: %#lx\n", kvm_read_c0_guest_entryhi(cop0));
@@ -156,6 +177,11 @@ void kvm_mips_dump_shadow_tlbs(struct kvm_vcpu *vcpu)
 		printk("TLB%c%3d Hi 0x%08lx ",
 		       (tlb.tlb_lo0 | tlb.tlb_lo1) & MIPS3_PG_V ? ' ' : '*',
 		       i, tlb.tlb_hi);
+#ifdef CONFIG_KVM_MIPS_VZ
+		if (cpu_has_vzguestid) {
+			printk("GuestCtl1 0x%08x ", tlb.guestctl1);
+		}
+#endif
 		printk("Lo0=0x%09" PRIx64 " %c%c attr %lx ",
 		       (uint64_t) mips3_tlbpfn_to_paddr(tlb.tlb_lo0),
 		       (tlb.tlb_lo0 & MIPS3_PG_D) ? 'D' : ' ',
@@ -169,26 +195,31 @@ void kvm_mips_dump_shadow_tlbs(struct kvm_vcpu *vcpu)
 	}
 }
 
-static void kvm_mips_map_page(struct kvm *kvm, gfn_t gfn)
+static int kvm_mips_map_page(struct kvm *kvm, gfn_t gfn)
 {
+	int srcu_idx, err = 0;
 	pfn_t pfn;
 
 	if (kvm->arch.guest_pmap[gfn] != KVM_INVALID_PAGE)
-		return;
+		return 0;
 
+        srcu_idx = srcu_read_lock(&kvm->srcu);
 	pfn = kvm_mips_gfn_to_pfn(kvm, gfn);
 
 	if (kvm_mips_is_error_pfn(pfn)) {
-		panic("Couldn't get pfn for gfn %#" PRIx64 "!\n", gfn);
+		kvm_err("Couldn't get pfn for gfn %#" PRIx64 "!\n", gfn);
+		err = -EFAULT;
+		goto out;
 	}
 
 	kvm->arch.guest_pmap[gfn] = pfn;
-	return;
+out:
+	srcu_read_unlock(&kvm->srcu, srcu_idx);
+	return err;
 }
 
 /* Translate guest KSEG0 addresses to Host PA */
-unsigned long kvm_mips_translate_guest_kseg0_to_hpa(struct kvm_vcpu *vcpu,
-	unsigned long gva)
+ulong kvm_mips_translate_guest_kseg0_to_hpa(struct kvm_vcpu *vcpu, ulong gva)
 {
 	gfn_t gfn;
 	uint32_t offset = gva & ~PAGE_MASK;
@@ -207,22 +238,32 @@ unsigned long kvm_mips_translate_guest_kseg0_to_hpa(struct kvm_vcpu *vcpu,
 			gva);
 		return KVM_INVALID_PAGE;
 	}
-	kvm_mips_map_page(vcpu->kvm, gfn);
+
+	if (kvm_mips_map_page(vcpu->kvm, gfn) < 0)
+		return KVM_INVALID_ADDR;
+
 	return (kvm->arch.guest_pmap[gfn] << PAGE_SHIFT) + offset;
 }
 
 /* XXXKYMA: Must be called with interrupts disabled */
 /* set flush_dcache_mask == 0 if no dcache flush required */
 int
-kvm_mips_host_tlb_write(struct kvm_vcpu *vcpu, unsigned long entryhi,
-	unsigned long entrylo0, unsigned long entrylo1, int flush_dcache_mask)
+kvm_mips_host_tlb_write(struct kvm_vcpu *vcpu, ulong entryhi,
+			ulong entrylo0, ulong entrylo1, int flush_dcache_mask)
 {
-	unsigned long flags;
-	unsigned long old_entryhi;
+	ulong flags;
+	ulong old_entryhi;
 	volatile int idx;
+	int debug __maybe_unused = 0;
 
 	local_irq_save(flags);
 
+#ifdef CONFIG_KVM_MIPS_VZ
+	if (cpu_has_vzguestid) {
+		/* Set Guest ID for root probe and write of guest TLB entry */
+		mips32_SetGuestRIDtoGuestID();
+	}
+#endif
 
 	old_entryhi = read_c0_entryhi();
 	write_c0_entryhi(entryhi);
@@ -256,6 +297,12 @@ kvm_mips_host_tlb_write(struct kvm_vcpu *vcpu, unsigned long entryhi,
 			  "entrylo0(R): 0x%08lx, entrylo1(R): 0x%08lx\n",
 			  vcpu->arch.pc, idx, read_c0_entryhi(),
 			  read_c0_entrylo0(), read_c0_entrylo1());
+#ifdef CONFIG_KVM_MIPS_VZ
+		if (cpu_has_vzguestid) {
+			kvm_debug("@ %#lx idx: %2d guestCtl1(R): 0x%08x\n",
+				  vcpu->arch.pc, idx, read_c0_guestctl1());
+		}
+#endif
 	}
 #endif
 
@@ -275,24 +322,77 @@ kvm_mips_host_tlb_write(struct kvm_vcpu *vcpu, unsigned long entryhi,
 	/* Restore old ASID */
 	write_c0_entryhi(old_entryhi);
 	mtc0_tlbw_hazard();
+#ifdef CONFIG_KVM_MIPS_VZ
+	if (cpu_has_vzguestid) {
+		mips32_ClearGuestRID();
+	}
+#endif
 	tlbw_use_hazard();
 	local_irq_restore(flags);
 	return 0;
 }
 
+#ifdef CONFIG_KVM_MIPS_VZ
+/* XXXKYMA: Must be called with interrupts disabled */
+int kvm_mips_handle_vz_root_tlb_fault(ulong badvaddr, struct kvm_vcpu *vcpu)
+{
+	gfn_t gfn;
+	pfn_t pfn0, pfn1;
+	ulong vaddr = 0;
+	ulong entryhi = 0, entrylo0 = 0, entrylo1 = 0;
+	int even;
+	struct kvm *kvm = vcpu->kvm;
+	const int flush_dcache_mask = 0;
+
+	gfn = (KVM_GUEST_CPHYSADDR(badvaddr) >> PAGE_SHIFT);
+	if (gfn >= kvm->arch.guest_pmap_npages) {
+		kvm_err("%s: Invalid gfn: %#llx, BadVaddr: %#lx\n", __func__,
+			gfn, badvaddr);
+		kvm_mips_dump_host_tlbs();
+		return -1;
+	}
+	even = !(gfn & 0x1);
+	vaddr = badvaddr & (PAGE_MASK << 1);
+
+	if (kvm_mips_map_page(vcpu->kvm, gfn) < 0)
+		return -1;
+
+	if (kvm_mips_map_page(vcpu->kvm, gfn ^ 0x1) < 0)
+		return -1;
+
+	if (even) {
+		pfn0 = kvm->arch.guest_pmap[gfn];
+		pfn1 = kvm->arch.guest_pmap[gfn ^ 0x1];
+	} else {
+		pfn0 = kvm->arch.guest_pmap[gfn ^ 0x1];
+		pfn1 = kvm->arch.guest_pmap[gfn];
+	}
+
+	entryhi = (vaddr | kvm_mips_get_kernel_asid(vcpu));
+	entrylo0 = mips3_paddr_to_tlbpfn(pfn0 << PAGE_SHIFT) | (0x3 << 3) | (1 << 2) |
+			(0x1 << 1);
+	entrylo1 = mips3_paddr_to_tlbpfn(pfn1 << PAGE_SHIFT) | (0x3 << 3) | (1 << 2) |
+			(0x1 << 1);
+
+	return kvm_mips_host_tlb_write(vcpu, entryhi, entrylo0, entrylo1,
+				       flush_dcache_mask);
+}
+#endif
 
 /* XXXKYMA: Must be called with interrupts disabled */
-int kvm_mips_handle_kseg0_tlb_fault(unsigned long badvaddr,
-	struct kvm_vcpu *vcpu)
+int kvm_mips_handle_kseg0_tlb_fault(ulong badvaddr, struct kvm_vcpu *vcpu)
 {
 	gfn_t gfn;
 	pfn_t pfn0, pfn1;
-	unsigned long vaddr = 0;
-	unsigned long entryhi = 0, entrylo0 = 0, entrylo1 = 0;
+	ulong vaddr = 0;
+	ulong entryhi = 0, entrylo0 = 0, entrylo1 = 0;
 	int even;
 	struct kvm *kvm = vcpu->kvm;
 	const int flush_dcache_mask = 0;
 
+#ifdef CONFIG_KVM_MIPS_VZ
+	BUG_ON(cpu_has_vz);
+#endif
 
 	if (KVM_GUEST_KSEGX(badvaddr) != KVM_GUEST_KSEG0) {
 		kvm_err("%s: Invalid BadVaddr: %#lx\n", __func__, badvaddr);
@@ -310,8 +410,11 @@ int kvm_mips_handle_kseg0_tlb_fault(unsigned long badvaddr,
 	even = !(gfn & 0x1);
 	vaddr = badvaddr & (PAGE_MASK << 1);
 
-	kvm_mips_map_page(vcpu->kvm, gfn);
-	kvm_mips_map_page(vcpu->kvm, gfn ^ 0x1);
+	if (kvm_mips_map_page(vcpu->kvm, gfn) < 0)
+		return -1;
+
+	if (kvm_mips_map_page(vcpu->kvm, gfn ^ 0x1) < 0)
+		return -1;
 
 	if (even) {
 		pfn0 = kvm->arch.guest_pmap[gfn];
@@ -331,13 +434,16 @@ int kvm_mips_handle_kseg0_tlb_fault(unsigned long badvaddr,
 				       flush_dcache_mask);
 }
 
-int kvm_mips_handle_commpage_tlb_fault(unsigned long badvaddr,
-	struct kvm_vcpu *vcpu)
+int kvm_mips_handle_commpage_tlb_fault(ulong badvaddr, struct kvm_vcpu *vcpu)
 {
 	pfn_t pfn0, pfn1;
-	unsigned long flags, old_entryhi = 0, vaddr = 0;
-	unsigned long entrylo0 = 0, entrylo1 = 0;
+	ulong flags, old_entryhi = 0, vaddr = 0;
+	ulong entrylo0 = 0, entrylo1 = 0;
+	int debug __maybe_unused = 0;
 
+#ifdef CONFIG_KVM_MIPS_VZ
+	BUG_ON(cpu_has_vz);
+#endif
 
 	pfn0 = CPHYSADDR(vcpu->arch.kseg0_commpage) >> PAGE_SHIFT;
 	pfn1 = 0;
@@ -378,19 +484,26 @@ int kvm_mips_handle_commpage_tlb_fault(unsigned long badvaddr,
 
 int
 kvm_mips_handle_mapped_seg_tlb_fault(struct kvm_vcpu *vcpu,
-	struct kvm_mips_tlb *tlb, unsigned long *hpa0, unsigned long *hpa1)
+				     struct kvm_mips_tlb *tlb, ulong *hpa0,
+				     ulong *hpa1)
 {
-	unsigned long entryhi = 0, entrylo0 = 0, entrylo1 = 0;
-	struct kvm *kvm = vcpu->kvm;
 	pfn_t pfn0, pfn1;
+	ulong entryhi = 0, entrylo0 = 0, entrylo1 = 0;
+	struct kvm *kvm = vcpu->kvm;
 
+#ifdef CONFIG_KVM_MIPS_VZ
+	BUG_ON(cpu_has_vz);
+#endif
 
 	if ((tlb->tlb_hi & VPN2_MASK) == 0) {
 		pfn0 = 0;
 		pfn1 = 0;
 	} else {
-		kvm_mips_map_page(kvm, mips3_tlbpfn_to_paddr(tlb->tlb_lo0) >> PAGE_SHIFT);
-		kvm_mips_map_page(kvm, mips3_tlbpfn_to_paddr(tlb->tlb_lo1) >> PAGE_SHIFT);
+		if (kvm_mips_map_page(kvm, mips3_tlbpfn_to_paddr(tlb->tlb_lo0) >> PAGE_SHIFT) < 0)
+			return -1;
+
+		if (kvm_mips_map_page(kvm, mips3_tlbpfn_to_paddr(tlb->tlb_lo1) >> PAGE_SHIFT) < 0)
+			return -1;
 
 		pfn0 = kvm->arch.guest_pmap[mips3_tlbpfn_to_paddr(tlb->tlb_lo0) >> PAGE_SHIFT];
 		pfn1 = kvm->arch.guest_pmap[mips3_tlbpfn_to_paddr(tlb->tlb_lo1) >> PAGE_SHIFT];
@@ -419,16 +532,19 @@ kvm_mips_handle_mapped_seg_tlb_fault(struct kvm_vcpu *vcpu,
 				       tlb->tlb_mask);
 }
 
-int kvm_mips_guest_tlb_lookup(struct kvm_vcpu *vcpu, unsigned long entryhi)
+int kvm_mips_guest_tlb_lookup(struct kvm_vcpu *vcpu, ulong entryhi)
 {
 	int i;
 	int index = -1;
 	struct kvm_mips_tlb *tlb = vcpu->arch.guest_tlb;
 
+#ifdef CONFIG_KVM_MIPS_VZ
+	BUG_ON(cpu_has_vz);
+#endif
 
 	for (i = 0; i < KVM_MIPS_GUEST_TLB_SIZE; i++) {
 		if (((TLB_VPN2(tlb[i]) & ~tlb[i].tlb_mask) == ((entryhi & VPN2_MASK) & ~tlb[i].tlb_mask)) &&
-			(TLB_IS_GLOBAL(tlb[i]) || (TLB_ASID(tlb[i]) == ASID_MASK(entryhi)))) {
+			(TLB_IS_GLOBAL(tlb[i]) || (TLB_ASID(tlb[i]) == (entryhi & ASID_MASK)))) {
 			index = i;
 			break;
 		}
@@ -442,11 +558,17 @@ int kvm_mips_guest_tlb_lookup(struct kvm_vcpu *vcpu, unsigned long entryhi)
 	return index;
 }
 
-int kvm_mips_host_tlb_lookup(struct kvm_vcpu *vcpu, unsigned long vaddr)
+int kvm_mips_host_tlb_lookup(struct kvm_vcpu *vcpu, ulong vaddr)
 {
-	unsigned long old_entryhi, flags;
+	ulong old_entryhi, flags;
 	volatile int idx;
 
+#ifdef CONFIG_KVM_MIPS_VZ
+	/* Not used in VZ emulation mode.
+	 *  -- call to tlb_probe could overwrite GuestID field
+	 */
+	BUG_ON(cpu_has_vz);
+#endif
 
 	local_irq_save(flags);
 
@@ -478,13 +600,19 @@ int kvm_mips_host_tlb_lookup(struct kvm_vcpu *vcpu, unsigned long vaddr)
 	return idx;
 }
 
-int kvm_mips_host_tlb_inv(struct kvm_vcpu *vcpu, unsigned long va)
+int kvm_mips_host_tlb_inv(struct kvm_vcpu *vcpu, ulong va)
 {
 	int idx;
-	unsigned long flags, old_entryhi;
+	ulong flags, old_entryhi;
 
 	local_irq_save(flags);
 
+#ifdef CONFIG_KVM_MIPS_VZ
+	if (cpu_has_vzguestid) {
+		/* Set Guest ID for root probe and write of guest TLB entry */
+		mips32_SetGuestRIDtoGuestID();
+	}
+#endif
 
 	old_entryhi = read_c0_entryhi();
 
@@ -514,6 +642,11 @@ int kvm_mips_host_tlb_inv(struct kvm_vcpu *vcpu, unsigned long va)
 
 	write_c0_entryhi(old_entryhi);
 	mtc0_tlbw_hazard();
+#ifdef CONFIG_KVM_MIPS_VZ
+	if (cpu_has_vzguestid) {
+		mips32_ClearGuestRID();
+	}
+#endif
 	tlbw_use_hazard();
 
 	local_irq_restore(flags);
@@ -531,13 +664,19 @@ int kvm_mips_host_tlb_inv(struct kvm_vcpu *vcpu, unsigned long va)
 /* XXXKYMA: Fix Guest USER/KERNEL no longer share the same ASID*/
 int kvm_mips_host_tlb_inv_index(struct kvm_vcpu *vcpu, int index)
 {
-	unsigned long flags, old_entryhi;
+	ulong flags, old_entryhi;
 
 	if (index >= current_cpu_data.tlbsize)
 		BUG();
 
 	local_irq_save(flags);
 
+#ifdef CONFIG_KVM_MIPS_VZ
+	if (cpu_has_vzguestid) {
+		/* Set Guest ID for root probe and write of guest TLB entry */
+		mips32_SetGuestRIDtoGuestID();
+	}
+#endif
 
 	old_entryhi = read_c0_entryhi();
 
@@ -559,6 +698,11 @@ int kvm_mips_host_tlb_inv_index(struct kvm_vcpu *vcpu, int index)
 
 	write_c0_entryhi(old_entryhi);
 	mtc0_tlbw_hazard();
+#ifdef CONFIG_KVM_MIPS_VZ
+	if (cpu_has_vzguestid) {
+		mips32_ClearGuestRID();
+	}
+#endif
 	tlbw_use_hazard();
 
 	local_irq_restore(flags);
@@ -574,6 +718,11 @@ void kvm_mips_flush_host_tlb(int skip_kseg0)
 	int entry = 0;
 	int maxentry = current_cpu_data.tlbsize;
 
+#ifdef CONFIG_KVM_MIPS_VZ
+	/* kseg0 should always be flushed in VZ emulation mode */
+	/* If this changes then clear GuestRID after tlb_read */
+	BUG_ON(cpu_has_vz && skip_kseg0);
+#endif
 
 	local_irq_save(flags);
 
@@ -626,7 +775,7 @@ kvm_get_new_mmu_context(struct mm_struct *mm, unsigned long cpu,
 {
 	unsigned long asid = asid_cache(cpu);
 
-	if (!(ASID_MASK(ASID_INC(asid)))) {
+	if (!((asid += ASID_INC) & ASID_MASK)) {
 		if (cpu_has_vtag_icache) {
 			flush_icache_all();
 		}
@@ -663,11 +812,22 @@ void kvm_shadow_tlb_put(struct kvm_vcpu *vcpu)
 		vcpu->arch.shadow_tlb[cpu][entry].tlb_lo0 = read_c0_entrylo0();
 		vcpu->arch.shadow_tlb[cpu][entry].tlb_lo1 = read_c0_entrylo1();
 		vcpu->arch.shadow_tlb[cpu][entry].tlb_mask = read_c0_pagemask();
+#ifdef CONFIG_KVM_MIPS_VZ
+		vcpu->arch.shadow_tlb[cpu][entry].guestctl1 = 0;
+		if (cpu_has_vzguestid) {
+			vcpu->arch.shadow_tlb[cpu][entry].guestctl1 = read_c0_guestctl1();
+		}
+#endif
 	}
 
 	write_c0_entryhi(old_entryhi);
 	write_c0_pagemask(old_pagemask);
 	mtc0_tlbw_hazard();
+#ifdef CONFIG_KVM_MIPS_VZ
+	if (cpu_has_vzguestid) {
+		mips32_ClearGuestRID();
+	}
+#endif
 
 	local_irq_restore(flags);
 
@@ -693,6 +853,14 @@ void kvm_shadow_tlb_load(struct kvm_vcpu *vcpu)
 		write_c0_index(entry);
 		mtc0_tlbw_hazard();
 
+#ifdef CONFIG_KVM_MIPS_VZ
+		if (cpu_has_vzguestid) {
+			/* Set GuestID for root write of guest TLB entry */
+			mips32_SetGuestRID((vcpu->arch.shadow_tlb[cpu][entry].
+					    guestctl1 & GUESTCTL1_RID) >>
+					   GUESTCTL1_RID_SHIFT);
+		}
+#endif
 		tlb_write_indexed();
 		tlbw_use_hazard();
 	}
@@ -700,9 +868,57 @@ void kvm_shadow_tlb_load(struct kvm_vcpu *vcpu)
 	tlbw_use_hazard();
 	write_c0_entryhi(old_ctx);
 	mtc0_tlbw_hazard();
+#ifdef CONFIG_KVM_MIPS_VZ
+	if (cpu_has_vzguestid) {
+		mips32_ClearGuestRID();
+	}
+#endif
 	local_irq_restore(flags);
 }
 
+#ifdef CONFIG_KVM_MIPS_VZ
+void kvm_vz_local_flush_guest_tlb_all(void)
+{
+	unsigned long flags;
+	unsigned long old_ctx;
+	int entry = 0;
+	struct mips_coproc *cop0 = NULL;
+
+	if (cpu_has_tlbinv) {
+
+		local_irq_save(flags);
+
+		/* Blast 'em all away. */
+		kvm_write_c0_guest_index(cop0, 0);
+		tlbw_use_hazard();
+		tlb_guest_invalidate_flush();
+
+		local_irq_restore(flags);
+
+		return;
+	}
+
+	local_irq_save(flags);
+	/* Save old context and create impossible VPN2 value */
+	old_ctx = kvm_read_c0_guest_entryhi(cop0);
+	kvm_write_c0_guest_entrylo0(cop0, 0);
+	kvm_write_c0_guest_entrylo1(cop0, 0);
+
+	/* Blast 'em all away. */
+	while (entry < current_cpu_data.vz.tlbsize) {
+		/* Make sure all entries differ. */
+		kvm_write_c0_guest_entryhi(cop0, UNIQUE_ENTRYHI(entry));
+		kvm_write_c0_guest_index(cop0, entry);
+		mtc0_tlbw_hazard();
+		tlb_write_guest_indexed();
+		entry++;
+	}
+	tlbw_use_hazard();
+	kvm_write_c0_guest_entryhi(cop0, old_ctx);
+	mtc0_tlbw_hazard();
+	local_irq_restore(flags);
+}
+#endif
 
 void kvm_local_flush_tlb_all(void)
 {
@@ -710,6 +926,21 @@ void kvm_local_flush_tlb_all(void)
 	unsigned long old_ctx;
 	int entry = 0;
 
+#ifdef CONFIG_KVM_MIPS_VZ
+	if (cpu_has_tlbinv) {
+
+		local_irq_save(flags);
+
+		/* Blast 'em all away. */
+		write_c0_index(0);
+		tlbw_use_hazard();
+		tlb_invalidate_flush();
+
+		local_irq_restore(flags);
+
+		return;
+	}
+#endif
 	local_irq_save(flags);
 	/* Save old context and create impossible VPN2 value */
 	old_ctx = read_c0_entryhi();
@@ -729,6 +960,11 @@ void kvm_local_flush_tlb_all(void)
 	write_c0_entryhi(old_ctx);
 	mtc0_tlbw_hazard();
 
+#ifdef CONFIG_KVM_MIPS_VZ
+	if (atomic_read(&kvm_mips_instance) != 0) {
+		kvm_vz_local_flush_guest_tlb_all();
+	}
+#endif
 	local_irq_restore(flags);
 }
 
@@ -744,6 +980,9 @@ void kvm_mips_init_shadow_tlb(struct kvm_vcpu *vcpu)
 			vcpu->arch.shadow_tlb[cpu][entry].tlb_lo1 = 0x0;
 			vcpu->arch.shadow_tlb[cpu][entry].tlb_mask =
 			    read_c0_pagemask();
+#ifdef CONFIG_KVM_MIPS_VZ
+			vcpu->arch.shadow_tlb[cpu][entry].guestctl1 = 0x0;
+#endif
 #ifdef DEBUG
 			kvm_debug
 			    ("shadow_tlb[%d][%d]: tlb_hi: %#lx, lo0: %#lx, lo1: %#lx\n",
@@ -759,8 +998,11 @@ void kvm_mips_init_shadow_tlb(struct kvm_vcpu *vcpu)
 /* Restore ASID once we are scheduled back after preemption */
 void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
-	unsigned long flags;
+	ulong flags;
 	int newasid = 0;
+#ifdef CONFIG_KVM_MIPS_VZ
+	int restore_regs = 0;
+#endif
 
 #ifdef DEBUG
 	kvm_debug("%s: vcpu %p, cpu: %d\n", __func__, vcpu, cpu);
@@ -770,6 +1012,10 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 	local_irq_save(flags);
 
+	if (vcpu->arch.last_sched_cpu != cpu)
+		kvm_info("[%d->%d]KVM VCPU[%d] switch\n",
+			 vcpu->arch.last_sched_cpu, cpu, vcpu->vcpu_id);
+
 	if (((vcpu->arch.
 	      guest_kernel_asid[cpu] ^ asid_cache(cpu)) & ASID_VERSION_MASK)) {
 		kvm_get_new_mmu_context(&vcpu->arch.guest_kernel_mm, cpu, vcpu);
@@ -780,6 +1026,21 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 		    vcpu->arch.guest_user_mm.context.asid[cpu];
 		newasid++;
 
+#ifdef CONFIG_KVM_MIPS_VZ
+		/* Set the GuestID for the guest VM.  A vcpu has a different
+		 * vzguestid on each host cpu in an smp system.
+		 */
+		if (cpu_has_vzguestid) {
+			vcpu->arch.vzguestid[cpu] =
+					vcpu->arch.guest_kernel_asid[cpu];
+			if (KVM_VZROOTID == (vcpu->arch.vzguestid[cpu] &
+						 KVM_VZGUESTID_MASK)) {
+				vcpu->arch.vzguestid[cpu] =
+					vcpu->arch.guest_user_asid[cpu];
+			}
+			restore_regs = 1;
+		}
+#endif
 		kvm_info("[%d]: cpu_context: %#lx\n", cpu,
 			 cpu_context(cpu, current->mm));
 		kvm_info("[%d]: Allocated new ASID for Guest Kernel: %#x\n",
@@ -788,11 +1049,28 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 			 vcpu->arch.guest_user_asid[cpu]);
 	}
 
-	if (vcpu->arch.last_sched_cpu != cpu) {
-		kvm_info("[%d->%d]KVM VCPU[%d] switch\n",
-			 vcpu->arch.last_sched_cpu, cpu, vcpu->vcpu_id);
+#ifdef CONFIG_KVM_MIPS_VZ
+	if (cpu_has_vzguestid) {
+		/* restore cp0 registers if another guest has been running */
+		if ((read_c0_guestctl1() ^ vcpu->arch.vzguestid[cpu]) &
+				KVM_VZGUESTID_MASK) {
+			change_c0_guestctl1(KVM_VZGUESTID_MASK,
+					vcpu->arch.vzguestid[cpu]);
+			restore_regs = 1;
+		}
+	} else {
+		restore_regs = 1;
+		kvm_vz_local_flush_guest_tlb_all();
 	}
 
+	if (vcpu->arch.last_sched_cpu != cpu)
+		restore_regs = 1;
+
+	if (restore_regs)
+		kvm_mips_callbacks->vcpu_ioctl_set_regs(vcpu,
+							&vcpu->arch.guest_regs);
+#endif
+
 	/* Only reload shadow host TLB if new ASIDs haven't been allocated */
 #if 0
 	if ((atomic_read(&kvm_mips_instance) > 1) && !newasid) {
@@ -801,28 +1079,17 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	}
 #endif
 
-	if (!newasid) {
-		/* If we preempted while the guest was executing, then reload the pre-empted ASID */
-		if (current->flags & PF_VCPU) {
-			write_c0_entryhi(ASID_MASK(vcpu->arch.preempt_entryhi));
-			ehb();
-		}
-	} else {
-		/* New ASIDs were allocated for the VM */
-
-		/* Were we in guest context? If so then the pre-empted ASID is no longer
-		 * valid, we need to set it to what it should be based on the mode of
-		 * the Guest (Kernel/User)
-		 */
-		if (current->flags & PF_VCPU) {
-			if (KVM_GUEST_KERNEL_MODE(vcpu))
-				write_c0_entryhi(ASID_MASK(vcpu->arch.
-						 guest_kernel_asid[cpu]));
-			else
-				write_c0_entryhi(ASID_MASK(vcpu->arch.
-						 guest_user_asid[cpu]));
-			ehb();
-		}
+	/* If we preempted while the guest was executing, then reload the ASID
+	 * based on the mode of the Guest (Kernel/User)
+	 */
+	if (current->flags & PF_VCPU) {
+		if (KVM_GUEST_KERNEL_MODE(vcpu))
+			write_c0_entryhi(vcpu->arch.guest_kernel_asid[cpu] &
+					 ASID_MASK);
+		else
+			write_c0_entryhi(vcpu->arch.guest_user_asid[cpu] &
+					 ASID_MASK);
+		ehb();
 	}
 
 	local_irq_restore(flags);
@@ -832,21 +1099,17 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 /* ASID can change if another task is scheduled during preemption */
 void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 {
-	unsigned long flags;
+	ulong flags;
 	uint32_t cpu;
 
 	local_irq_save(flags);
 
 	cpu = smp_processor_id();
-
-
-	vcpu->arch.preempt_entryhi = read_c0_entryhi();
 	vcpu->arch.last_sched_cpu = cpu;
 
-#if 0
-	if ((atomic_read(&kvm_mips_instance) > 1)) {
-		kvm_shadow_tlb_put(vcpu);
-	}
+#ifdef CONFIG_KVM_MIPS_VZ
+	/* save guest cp0 registers */
+	kvm_mips_callbacks->vcpu_ioctl_get_regs(vcpu, &vcpu->arch.guest_regs);
 #endif
 
 	if (((cpu_context(cpu, current->mm) ^ asid_cache(cpu)) &
@@ -863,23 +1126,28 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 
 uint32_t kvm_get_inst(uint32_t *opc, struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
-	unsigned long paddr, flags;
 	uint32_t inst;
+	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	int index;
+	ulong paddr, flags;
 
-	if (KVM_GUEST_KSEGX((unsigned long) opc) < KVM_GUEST_KSEG0 ||
-	    KVM_GUEST_KSEGX((unsigned long) opc) == KVM_GUEST_KSEG23) {
+	if (KVM_GUEST_KSEGX((ulong) opc) < KVM_GUEST_KSEG0 ||
+	    KVM_GUEST_KSEGX((ulong) opc) == KVM_GUEST_KSEG23) {
+#ifdef CONFIG_KVM_MIPS_VZ
+		/* TODO VZ verify if both kvm_get_inst paths are used */
+		BUG_ON(cpu_has_vz);
+#endif
 		local_irq_save(flags);
-		index = kvm_mips_host_tlb_lookup(vcpu, (unsigned long) opc);
+		index = kvm_mips_host_tlb_lookup(vcpu, (ulong) opc);
 		if (index >= 0) {
 			inst = *(opc);
 		} else {
 			index =
 			    kvm_mips_guest_tlb_lookup(vcpu,
-						      ((unsigned long) opc & VPN2_MASK)
+						      ((ulong) opc & VPN2_MASK)
 						      |
-						      ASID_MASK(kvm_read_c0_guest_entryhi(cop0)));
+						      (kvm_read_c0_guest_entryhi
+						       (cop0) & ASID_MASK));
 			if (index < 0) {
 				kvm_err
 				    ("%s: get_user_failed for %p, vcpu: %p, ASID: %#lx\n",
@@ -897,8 +1165,11 @@ uint32_t kvm_get_inst(uint32_t *opc, struct kvm_vcpu *vcpu)
 		local_irq_restore(flags);
 	} else if (KVM_GUEST_KSEGX(opc) == KVM_GUEST_KSEG0) {
 		paddr =
-		    kvm_mips_translate_guest_kseg0_to_hpa(vcpu,
-							 (unsigned long) opc);
+		    kvm_mips_translate_guest_kseg0_to_hpa(vcpu, (ulong) opc);
+
+		if (paddr == KVM_INVALID_ADDR)
+			return KVM_INVALID_INST;
+
 		inst = *(uint32_t *) CKSEG0ADDR(paddr);
 	} else {
 		kvm_err("%s: illegal address: %p\n", __func__, opc);
@@ -926,3 +1197,6 @@ EXPORT_SYMBOL(kvm_mips_dump_guest_tlbs);
 EXPORT_SYMBOL(kvm_get_inst);
 EXPORT_SYMBOL(kvm_arch_vcpu_load);
 EXPORT_SYMBOL(kvm_arch_vcpu_put);
+#ifdef CONFIG_KVM_MIPS_VZ
+EXPORT_SYMBOL(kvm_mips_handle_vz_root_tlb_fault);
+#endif
-- 
1.7.11.3
