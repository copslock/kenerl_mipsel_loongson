Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Nov 2012 03:36:43 +0100 (CET)
Received: from kymasys.com ([64.62.140.43]:36003 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6828070Ab2KVCeq0NQhK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Nov 2012 03:34:46 +0100
Received: from agni.kymasys.com ([75.40.23.192]) by kymasys.com for <linux-mips@linux-mips.org>; Wed, 21 Nov 2012 18:34:37 -0800
Received: by agni.kymasys.com (Postfix, from userid 500)
        id 97CD863027C; Wed, 21 Nov 2012 18:34:18 -0800 (PST)
From:   Sanjay Lal <sanjayl@kymasys.com>
To:     kvm@vger.kernel.org, linux-mips@linux-mips.org
Cc:     Sanjay Lal <sanjayl@kymasys.com>
Subject: [PATCH v2 07/18] KVM/MIPS32: MMU/TLB operations for the Guest.
Date:   Wed, 21 Nov 2012 18:34:05 -0800
Message-Id: <1353551656-23579-8-git-send-email-sanjayl@kymasys.com>
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1353551656-23579-1-git-send-email-sanjayl@kymasys.com>
References: <1353551656-23579-1-git-send-email-sanjayl@kymasys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 35081
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
Return-Path: <linux-mips-bounce@linux-mips.org>

- Note that this file is statically linked with the rest of the host kernel (KSEG0). This is because kernel modules are
loaded into mapped space on MIPS and we want to make sure that we don't get any host kernel TLB faults while
manipulating TLBs.
- Virtual Guest TLBs are implemented as 64 entry array regardless of the number of host TLB entries.
- Shadow TLBs map Guest virtual addresses to Host physical addresses.

    - TLB miss handling details:
        Guest KSEG0 TLBMISS (0x40000000 – 0x60000000): Transparent to the Guest.
        Guest KSEG2/3 (0x60000000 – 0x80000000) & Guest UM TLBMISS (0x00000000 – 0x40000000)
            Lookup in Guest/Virtual TLB
            If an entry doesn’t match
                deliver appropriate TLBMISS LD/ST exception to the guest
            If entry does exist in the Guest TLB and is NOT Valid
                Deliver TLB invalid exception to the guest
            If entry does exist in the Guest TLB and is VALID
                Inject the TLB entry into the Shadow TLB

Signed-off-by: Sanjay Lal <sanjayl@kymasys.com>
---
 arch/mips/kvm/kvm_tlb.c | 932 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 932 insertions(+)
 create mode 100644 arch/mips/kvm/kvm_tlb.c

diff --git a/arch/mips/kvm/kvm_tlb.c b/arch/mips/kvm/kvm_tlb.c
new file mode 100644
index 0000000..2d24333
--- /dev/null
+++ b/arch/mips/kvm/kvm_tlb.c
@@ -0,0 +1,932 @@
+/*
+* This file is subject to the terms and conditions of the GNU General Public
+* License.  See the file "COPYING" in the main directory of this archive
+* for more details.
+*
+* KVM/MIPS TLB handling, this file is part of the Linux host kernel so that
+* TLB handlers run from KSEG0
+*
+* Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
+* Authors: Sanjay Lal <sanjayl@kymasys.com>
+*/
+
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/smp.h>
+#include <linux/mm.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/kvm_host.h>
+
+#include <asm/cpu.h>
+#include <asm/bootinfo.h>
+#include <asm/mmu_context.h>
+#include <asm/pgtable.h>
+#include <asm/cacheflush.h>
+
+#undef CONFIG_MIPS_MT
+#include <asm/r4kcache.h>
+#define CONFIG_MIPS_MT
+
+#define KVM_GUEST_PC_TLB    0
+#define KVM_GUEST_SP_TLB    1
+
+#define PRIx64 "llx"
+
+/* Use VZ EntryHi.EHINV to invalidate TLB entries */
+#define UNIQUE_ENTRYHI(idx) (CKSEG0 + ((idx) << (PAGE_SHIFT + 1)))
+
+atomic_t kvm_mips_instance;
+EXPORT_SYMBOL(kvm_mips_instance);
+
+/* These function pointers are initialized once the KVM module is loaded */
+pfn_t(*kvm_mips_gfn_to_pfn) (struct kvm *kvm, gfn_t gfn);
+EXPORT_SYMBOL(kvm_mips_gfn_to_pfn);
+
+void (*kvm_mips_release_pfn_clean) (pfn_t pfn);
+EXPORT_SYMBOL(kvm_mips_release_pfn_clean);
+
+bool(*kvm_mips_is_error_pfn) (pfn_t pfn);
+EXPORT_SYMBOL(kvm_mips_is_error_pfn);
+
+uint32_t kvm_mips_get_kernel_asid(struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.guest_kernel_asid[smp_processor_id()] & ASID_MASK;
+}
+
+
+uint32_t kvm_mips_get_user_asid(struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.guest_user_asid[smp_processor_id()] & ASID_MASK;
+}
+
+inline uint32_t kvm_mips_get_commpage_asid (struct kvm_vcpu *vcpu)
+{
+	return vcpu->kvm->arch.commpage_tlb;
+}
+
+
+/*
+ * Structure defining an tlb entry data set.
+ */
+
+void kvm_mips_dump_host_tlbs(void)
+{
+	struct kvm_mips_tlb tlb;
+	int i;
+	ulong flags;
+	unsigned long old_entryhi;
+	unsigned long old_pagemask;
+
+	local_irq_save(flags);
+
+	old_entryhi = read_c0_entryhi();
+	old_pagemask = read_c0_pagemask();
+
+	printk("HOST TLBs:\n");
+	printk("ASID: %#lx\n", read_c0_entryhi() & ASID_MASK);
+
+	for (i = 0; i < current_cpu_data.tlbsize; i++) {
+		write_c0_index(i);
+		mtc0_tlbw_hazard();
+
+		tlb_read();
+		tlbw_use_hazard();
+
+		tlb.tlb_hi = read_c0_entryhi();
+		tlb.tlb_lo0 = read_c0_entrylo0();
+		tlb.tlb_lo1 = read_c0_entrylo1();
+		tlb.tlb_mask = read_c0_pagemask();
+
+		printk("TLB%c%3d Hi 0x%08lx ",
+		       (tlb.tlb_lo0 | tlb.tlb_lo1) & MIPS3_PG_V ? ' ' : '*',
+		       i, tlb.tlb_hi);
+		printk("Lo0=0x%09" PRIx64 " %c%c attr %lx ",
+		       (uint64_t) mips3_tlbpfn_to_paddr(tlb.tlb_lo0),
+		       (tlb.tlb_lo0 & MIPS3_PG_D) ? 'D' : ' ',
+		       (tlb.tlb_lo0 & MIPS3_PG_G) ? 'G' : ' ',
+		       (tlb.tlb_lo0 >> 3) & 7);
+		printk("Lo1=0x%09" PRIx64 " %c%c attr %lx sz=%lx\n",
+		       (uint64_t) mips3_tlbpfn_to_paddr(tlb.tlb_lo1),
+		       (tlb.tlb_lo1 & MIPS3_PG_D) ? 'D' : ' ',
+		       (tlb.tlb_lo1 & MIPS3_PG_G) ? 'G' : ' ',
+		       (tlb.tlb_lo1 >> 3) & 7, tlb.tlb_mask);
+	}
+	write_c0_entryhi(old_entryhi);
+	write_c0_pagemask(old_pagemask);
+	mtc0_tlbw_hazard();
+	local_irq_restore(flags);
+}
+
+void kvm_mips_dump_guest_tlbs(struct kvm_vcpu *vcpu)
+{
+	int i;
+	struct kvm_mips_tlb tlb;
+	struct mips_coproc *cop0 __unused = vcpu->arch.cop0;
+
+	printk("Guest TLBs:\n");
+	printk("Guest EntryHi: %#lx\n", kvm_read_c0_guest_entryhi(cop0));
+
+	for (i = 0; i < KVM_MIPS_GUEST_TLB_SIZE; i++) {
+		tlb = vcpu->arch.guest_tlb[i];
+		printk("TLB%c%3d Hi 0x%08lx ",
+		       (tlb.tlb_lo0 | tlb.tlb_lo1) & MIPS3_PG_V ? ' ' : '*',
+		       i, tlb.tlb_hi);
+		printk("Lo0=0x%09" PRIx64 " %c%c attr %lx ",
+		       (uint64_t) mips3_tlbpfn_to_paddr(tlb.tlb_lo0),
+		       (tlb.tlb_lo0 & MIPS3_PG_D) ? 'D' : ' ',
+		       (tlb.tlb_lo0 & MIPS3_PG_G) ? 'G' : ' ',
+		       (tlb.tlb_lo0 >> 3) & 7);
+		printk("Lo1=0x%09" PRIx64 " %c%c attr %lx sz=%lx\n",
+		       (uint64_t) mips3_tlbpfn_to_paddr(tlb.tlb_lo1),
+		       (tlb.tlb_lo1 & MIPS3_PG_D) ? 'D' : ' ',
+		       (tlb.tlb_lo1 & MIPS3_PG_G) ? 'G' : ' ',
+		       (tlb.tlb_lo1 >> 3) & 7, tlb.tlb_mask);
+	}
+}
+
+void kvm_mips_dump_shadow_tlbs(struct kvm_vcpu *vcpu)
+{
+	int i;
+	volatile struct kvm_mips_tlb tlb;
+
+	printk("Shadow TLBs:\n");
+	for (i = 0; i < KVM_MIPS_GUEST_TLB_SIZE; i++) {
+		tlb = vcpu->arch.shadow_tlb[smp_processor_id()][i];
+		printk("TLB%c%3d Hi 0x%08lx ",
+		       (tlb.tlb_lo0 | tlb.tlb_lo1) & MIPS3_PG_V ? ' ' : '*',
+		       i, tlb.tlb_hi);
+		printk("Lo0=0x%09" PRIx64 " %c%c attr %lx ",
+		       (uint64_t) mips3_tlbpfn_to_paddr(tlb.tlb_lo0),
+		       (tlb.tlb_lo0 & MIPS3_PG_D) ? 'D' : ' ',
+		       (tlb.tlb_lo0 & MIPS3_PG_G) ? 'G' : ' ',
+		       (tlb.tlb_lo0 >> 3) & 7);
+		printk("Lo1=0x%09" PRIx64 " %c%c attr %lx sz=%lx\n",
+		       (uint64_t) mips3_tlbpfn_to_paddr(tlb.tlb_lo1),
+		       (tlb.tlb_lo1 & MIPS3_PG_D) ? 'D' : ' ',
+		       (tlb.tlb_lo1 & MIPS3_PG_G) ? 'G' : ' ',
+		       (tlb.tlb_lo1 >> 3) & 7, tlb.tlb_mask);
+	}
+}
+
+static void kvm_mips_map_page(struct kvm *kvm, gfn_t gfn)
+{
+	pfn_t pfn;
+
+	if (kvm->arch.guest_pmap[gfn] != KVM_INVALID_PAGE)
+		return;
+
+	pfn = kvm_mips_gfn_to_pfn(kvm, gfn);
+
+	if (kvm_mips_is_error_pfn(pfn)) {
+		panic("Couldn't get pfn for gfn %#" PRIx64 "!\n", gfn);
+	}
+
+	kvm->arch.guest_pmap[gfn] = pfn;
+	return;
+}
+
+/* Translate guest KSEG0 addresses to Host PA */
+ulong kvm_mips_translate_guest_kseg0_to_hpa(struct kvm_vcpu *vcpu, ulong gva)
+{
+	gfn_t gfn;
+	uint32_t offset = gva & ~PAGE_MASK;
+	struct kvm *kvm = vcpu->kvm;
+
+	if (KVM_GUEST_KSEGX(gva) != KVM_GUEST_KSEG0) {
+		kvm_err("%s/%p: Invalid gva: %#lx\n", __func__,
+			__builtin_return_address(0), gva);
+		return KVM_INVALID_PAGE;
+	}
+
+	gfn = (KVM_GUEST_CPHYSADDR(gva) >> PAGE_SHIFT);
+
+	if (gfn >= kvm->arch.guest_pmap_npages) {
+		kvm_err("%s: Invalid gfn: %#llx, GVA: %#lx\n", __func__, gfn,
+			gva);
+		return KVM_INVALID_PAGE;
+	}
+	kvm_mips_map_page(vcpu->kvm, gfn);
+	return (kvm->arch.guest_pmap[gfn] << PAGE_SHIFT) + offset;
+}
+
+/* XXXKYMA: Must be called with interrupts disabled */
+/* set flush_dcache_mask == 0 if no dcache flush required */
+int
+kvm_mips_host_tlb_write(struct kvm_vcpu *vcpu, ulong entryhi,
+			ulong entrylo0, ulong entrylo1, int flush_dcache_mask)
+{
+	ulong flags;
+	ulong old_entryhi;
+	volatile int idx;
+	int debug __unused = 0;
+
+	local_irq_save(flags);
+
+
+	old_entryhi = read_c0_entryhi();
+	write_c0_entryhi(entryhi);
+	mtc0_tlbw_hazard();
+
+	tlb_probe();
+	tlb_probe_hazard();
+	idx = read_c0_index();
+
+	if (idx > current_cpu_data.tlbsize) {
+		kvm_err("%s: Invalid Index: %d\n", __func__, idx);
+		kvm_mips_dump_host_tlbs();
+		return -1;
+	}
+
+	if (idx < 0) {
+		idx = read_c0_random() % current_cpu_data.tlbsize;
+		write_c0_index(idx);
+		mtc0_tlbw_hazard();
+	}
+	write_c0_entrylo0(entrylo0);
+	write_c0_entrylo1(entrylo1);
+	mtc0_tlbw_hazard();
+
+	tlb_write_indexed();
+	tlbw_use_hazard();
+
+#ifdef DEBUG
+	if (debug) {
+		kvm_debug("@ %#lx idx: %2d [entryhi(R): %#lx] "
+			  "entrylo0(R): 0x%08lx, entrylo1(R): 0x%08lx\n",
+			  vcpu->arch.pc, idx, read_c0_entryhi(),
+			  read_c0_entrylo0(), read_c0_entrylo1());
+	}
+#endif
+
+	/* Flush D-cache */
+	if (flush_dcache_mask) {
+		if (entrylo0 & MIPS3_PG_V) {
+			++vcpu->stat.flush_dcache_exits;
+			flush_data_cache_page((entryhi & VPN2_MASK) & ~flush_dcache_mask);
+		}
+		if (entrylo1 & MIPS3_PG_V) {
+			++vcpu->stat.flush_dcache_exits;
+			flush_data_cache_page(((entryhi & VPN2_MASK) & ~flush_dcache_mask) |
+				(0x1 << PAGE_SHIFT));
+		}
+	}
+
+	/* Restore old ASID */
+	write_c0_entryhi(old_entryhi);
+	mtc0_tlbw_hazard();
+	tlbw_use_hazard();
+	local_irq_restore(flags);
+	return 0;
+}
+
+
+/* XXXKYMA: Must be called with interrupts disabled */
+int kvm_mips_handle_kseg0_tlb_fault(ulong badvaddr, struct kvm_vcpu *vcpu)
+{
+	gfn_t gfn;
+	pfn_t pfn0, pfn1;
+	ulong vaddr = 0;
+	ulong entryhi = 0, entrylo0 = 0, entrylo1 = 0;
+	int even;
+	struct kvm *kvm = vcpu->kvm;
+	const int flush_dcache_mask = 0;
+
+
+	if (KVM_GUEST_KSEGX(badvaddr) != KVM_GUEST_KSEG0) {
+		kvm_err("%s: Invalid BadVaddr: %#lx\n", __func__, badvaddr);
+		kvm_mips_dump_host_tlbs();
+		return -1;
+	}
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
+	kvm_mips_map_page(vcpu->kvm, gfn);
+	kvm_mips_map_page(vcpu->kvm, gfn ^ 0x1);
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
+
+int kvm_mips_handle_commpage_tlb_fault(ulong badvaddr, struct kvm_vcpu *vcpu)
+{
+	pfn_t pfn0, pfn1;
+	ulong flags, old_entryhi = 0, vaddr = 0;
+	ulong entrylo0 = 0, entrylo1 = 0;
+	int debug __unused = 0;
+
+
+	pfn0 = CPHYSADDR(vcpu->arch.kseg0_commpage) >> PAGE_SHIFT;
+	pfn1 = 0;
+	entrylo0 = mips3_paddr_to_tlbpfn(pfn0 << PAGE_SHIFT) | (0x3 << 3) | (1 << 2) |
+			(0x1 << 1);
+	entrylo1 = 0;
+
+	local_irq_save(flags);
+
+	old_entryhi = read_c0_entryhi();
+	vaddr = badvaddr & (PAGE_MASK << 1);
+	write_c0_entryhi(vaddr | kvm_mips_get_kernel_asid(vcpu));
+	mtc0_tlbw_hazard();
+	write_c0_entrylo0(entrylo0);
+	mtc0_tlbw_hazard();
+	write_c0_entrylo1(entrylo1);
+	mtc0_tlbw_hazard();
+	write_c0_index(kvm_mips_get_commpage_asid(vcpu));
+	mtc0_tlbw_hazard();
+	tlb_write_indexed();
+	mtc0_tlbw_hazard();
+	tlbw_use_hazard();
+
+#ifdef DEBUG
+	kvm_debug ("@ %#lx idx: %2d [entryhi(R): %#lx] entrylo0 (R): 0x%08lx, entrylo1(R): 0x%08lx\n",
+	     vcpu->arch.pc, read_c0_index(), read_c0_entryhi(),
+	     read_c0_entrylo0(), read_c0_entrylo1());
+#endif
+
+	/* Restore old ASID */
+	write_c0_entryhi(old_entryhi);
+	mtc0_tlbw_hazard();
+	tlbw_use_hazard();
+	local_irq_restore(flags);
+
+	return 0;
+}
+
+int
+kvm_mips_handle_mapped_seg_tlb_fault(struct kvm_vcpu *vcpu,
+				     struct kvm_mips_tlb *tlb, ulong *hpa0,
+				     ulong *hpa1)
+{
+	pfn_t pfn0, pfn1;
+	ulong entryhi = 0, entrylo0 = 0, entrylo1 = 0;
+	struct kvm *kvm = vcpu->kvm;
+
+
+	if ((tlb->tlb_hi & VPN2_MASK) == 0) {
+		pfn0 = 0;
+		pfn1 = 0;
+	} else {
+		kvm_mips_map_page(kvm, mips3_tlbpfn_to_paddr(tlb->tlb_lo0) >> PAGE_SHIFT);
+		kvm_mips_map_page(kvm, mips3_tlbpfn_to_paddr(tlb->tlb_lo1) >> PAGE_SHIFT);
+
+		pfn0 = kvm->arch.guest_pmap[mips3_tlbpfn_to_paddr(tlb->tlb_lo0) >> PAGE_SHIFT];
+		pfn1 = kvm->arch.guest_pmap[mips3_tlbpfn_to_paddr(tlb->tlb_lo1) >> PAGE_SHIFT];
+	}
+
+	if (hpa0)
+		*hpa0 = pfn0 << PAGE_SHIFT;
+
+	if (hpa1)
+		*hpa1 = pfn1 << PAGE_SHIFT;
+
+	/* Get attributes from the Guest TLB */
+	entryhi = (tlb->tlb_hi & VPN2_MASK) | (KVM_GUEST_KERNEL_MODE(vcpu) ?
+			kvm_mips_get_kernel_asid(vcpu) : kvm_mips_get_user_asid(vcpu));
+	entrylo0 = mips3_paddr_to_tlbpfn(pfn0 << PAGE_SHIFT) | (0x3 << 3) |
+			(tlb->tlb_lo0 & MIPS3_PG_D) | (tlb->tlb_lo0 & MIPS3_PG_V);
+	entrylo1 = mips3_paddr_to_tlbpfn(pfn1 << PAGE_SHIFT) | (0x3 << 3) |
+			(tlb->tlb_lo1 & MIPS3_PG_D) | (tlb->tlb_lo1 & MIPS3_PG_V);
+
+#ifdef DEBUG
+	kvm_debug("@ %#lx tlb_lo0: 0x%08lx tlb_lo1: 0x%08lx\n", vcpu->arch.pc,
+		  tlb->tlb_lo0, tlb->tlb_lo1);
+#endif
+
+	return kvm_mips_host_tlb_write(vcpu, entryhi, entrylo0, entrylo1,
+				       tlb->tlb_mask);
+}
+
+int kvm_mips_guest_tlb_lookup(struct kvm_vcpu *vcpu, ulong entryhi)
+{
+	int i;
+	int index = -1;
+	struct kvm_mips_tlb *tlb = vcpu->arch.guest_tlb;
+
+
+	for (i = 0; i < KVM_MIPS_GUEST_TLB_SIZE; i++) {
+		if (((TLB_VPN2(tlb[i]) & ~tlb[i].tlb_mask) == ((entryhi & VPN2_MASK) & ~tlb[i].tlb_mask)) &&
+			(TLB_IS_GLOBAL(tlb[i]) || (TLB_ASID(tlb[i]) == (entryhi & ASID_MASK)))) {
+			index = i;
+			break;
+		}
+	}
+
+#ifdef DEBUG
+	kvm_debug("%s: entryhi: %#lx, index: %d lo0: %#lx, lo1: %#lx\n",
+		  __func__, entryhi, index, tlb[i].tlb_lo0, tlb[i].tlb_lo1);
+#endif
+
+	return index;
+}
+
+int kvm_mips_host_tlb_lookup(struct kvm_vcpu *vcpu, ulong vaddr)
+{
+	ulong old_entryhi, flags;
+	volatile int idx;
+
+
+	local_irq_save(flags);
+
+	old_entryhi = read_c0_entryhi();
+
+	if (KVM_GUEST_KERNEL_MODE(vcpu))
+		write_c0_entryhi((vaddr & VPN2_MASK) | kvm_mips_get_kernel_asid(vcpu));
+	else {
+		write_c0_entryhi((vaddr & VPN2_MASK) | kvm_mips_get_user_asid(vcpu));
+	}
+
+	mtc0_tlbw_hazard();
+
+	tlb_probe();
+	tlb_probe_hazard();
+	idx = read_c0_index();
+
+	/* Restore old ASID */
+	write_c0_entryhi(old_entryhi);
+	mtc0_tlbw_hazard();
+	tlbw_use_hazard();
+
+	local_irq_restore(flags);
+
+#ifdef DEBUG
+	kvm_debug("Host TLB lookup, %#lx, idx: %2d\n", vaddr, idx);
+#endif
+
+	return idx;
+}
+
+int kvm_mips_host_tlb_inv(struct kvm_vcpu *vcpu, ulong va)
+{
+	int idx;
+	ulong flags, old_entryhi;
+
+	local_irq_save(flags);
+
+
+	old_entryhi = read_c0_entryhi();
+
+	write_c0_entryhi((va & VPN2_MASK) | kvm_mips_get_user_asid(vcpu));
+	mtc0_tlbw_hazard();
+
+	tlb_probe();
+	tlb_probe_hazard();
+	idx = read_c0_index();
+
+	if (idx >= current_cpu_data.tlbsize)
+		BUG();
+
+	if (idx > 0) {
+		write_c0_entryhi(UNIQUE_ENTRYHI(idx));
+		mtc0_tlbw_hazard();
+
+		write_c0_entrylo0(0);
+		mtc0_tlbw_hazard();
+
+		write_c0_entrylo1(0);
+		mtc0_tlbw_hazard();
+
+		tlb_write_indexed();
+		mtc0_tlbw_hazard();
+	}
+
+	write_c0_entryhi(old_entryhi);
+	mtc0_tlbw_hazard();
+	tlbw_use_hazard();
+
+	local_irq_restore(flags);
+
+#ifdef DEBUG
+	if (idx > 0) {
+		kvm_debug("%s: Invalidated entryhi %#lx @ idx %d\n", __func__,
+			  (va & VPN2_MASK) | (vcpu->arch.asid_map[va & ASID_MASK] & ASID_MASK), idx);
+	}
+#endif
+
+	return 0;
+}
+
+/* XXXKYMA: Fix Guest USER/KERNEL no longer share the same ASID*/
+int kvm_mips_host_tlb_inv_index(struct kvm_vcpu *vcpu, int index)
+{
+	ulong flags, old_entryhi;
+
+	if (index >= current_cpu_data.tlbsize)
+		BUG();
+
+	local_irq_save(flags);
+
+
+	old_entryhi = read_c0_entryhi();
+
+	write_c0_entryhi(UNIQUE_ENTRYHI(index));
+	mtc0_tlbw_hazard();
+
+	write_c0_index(index);
+	mtc0_tlbw_hazard();
+
+	write_c0_entrylo0(0);
+	mtc0_tlbw_hazard();
+
+	write_c0_entrylo1(0);
+	mtc0_tlbw_hazard();
+
+	tlb_write_indexed();
+	mtc0_tlbw_hazard();
+	tlbw_use_hazard();
+
+	write_c0_entryhi(old_entryhi);
+	mtc0_tlbw_hazard();
+	tlbw_use_hazard();
+
+	local_irq_restore(flags);
+
+	return 0;
+}
+
+void kvm_mips_flush_host_tlb(int skip_kseg0)
+{
+	unsigned long flags;
+	unsigned long old_entryhi, entryhi;
+	unsigned long old_pagemask;
+	int entry = 0;
+	int maxentry = current_cpu_data.tlbsize;
+
+
+	local_irq_save(flags);
+
+	old_entryhi = read_c0_entryhi();
+	old_pagemask = read_c0_pagemask();
+
+	/* Blast 'em all away. */
+	for (entry = 0; entry < maxentry; entry++) {
+
+		write_c0_index(entry);
+		mtc0_tlbw_hazard();
+
+		if (skip_kseg0) {
+			tlb_read();
+			tlbw_use_hazard();
+
+			entryhi = read_c0_entryhi();
+
+			/* Don't blow away guest kernel entries */
+			if (KVM_GUEST_KSEGX(entryhi) == KVM_GUEST_KSEG0) {
+				continue;
+			}
+		}
+
+		/* Make sure all entries differ. */
+		write_c0_entryhi(UNIQUE_ENTRYHI(entry));
+		mtc0_tlbw_hazard();
+		write_c0_entrylo0(0);
+		mtc0_tlbw_hazard();
+		write_c0_entrylo1(0);
+		mtc0_tlbw_hazard();
+
+		tlb_write_indexed();
+		mtc0_tlbw_hazard();
+	}
+
+	tlbw_use_hazard();
+
+	write_c0_entryhi(old_entryhi);
+	write_c0_pagemask(old_pagemask);
+	mtc0_tlbw_hazard();
+	tlbw_use_hazard();
+
+	local_irq_restore(flags);
+}
+
+void
+kvm_get_new_mmu_context(struct mm_struct *mm, unsigned long cpu,
+			struct kvm_vcpu *vcpu)
+{
+	unsigned long asid = asid_cache(cpu);
+
+	if (!((asid += ASID_INC) & ASID_MASK)) {
+		if (cpu_has_vtag_icache) {
+			flush_icache_all();
+		}
+
+		kvm_local_flush_tlb_all();      /* start new asid cycle */
+
+		if (!asid)      /* fix version if needed */
+			asid = ASID_FIRST_VERSION;
+	}
+
+	cpu_context(cpu, mm) = asid_cache(cpu) = asid;
+}
+
+void kvm_shadow_tlb_put(struct kvm_vcpu *vcpu)
+{
+	unsigned long flags;
+	unsigned long old_entryhi;
+	unsigned long old_pagemask;
+	int entry = 0;
+	int cpu = smp_processor_id();
+
+	local_irq_save(flags);
+
+	old_entryhi = read_c0_entryhi();
+	old_pagemask = read_c0_pagemask();
+
+	for (entry = 0; entry < current_cpu_data.tlbsize; entry++) {
+		write_c0_index(entry);
+		mtc0_tlbw_hazard();
+		tlb_read();
+		tlbw_use_hazard();
+
+		vcpu->arch.shadow_tlb[cpu][entry].tlb_hi = read_c0_entryhi();
+		vcpu->arch.shadow_tlb[cpu][entry].tlb_lo0 = read_c0_entrylo0();
+		vcpu->arch.shadow_tlb[cpu][entry].tlb_lo1 = read_c0_entrylo1();
+		vcpu->arch.shadow_tlb[cpu][entry].tlb_mask = read_c0_pagemask();
+	}
+
+	write_c0_entryhi(old_entryhi);
+	write_c0_pagemask(old_pagemask);
+	mtc0_tlbw_hazard();
+
+	local_irq_restore(flags);
+
+}
+
+void kvm_shadow_tlb_load(struct kvm_vcpu *vcpu)
+{
+	unsigned long flags;
+	unsigned long old_ctx;
+	int entry;
+	int cpu = smp_processor_id();
+
+	local_irq_save(flags);
+
+	old_ctx = read_c0_entryhi();
+
+	for (entry = 0; entry < current_cpu_data.tlbsize; entry++) {
+		write_c0_entryhi(vcpu->arch.shadow_tlb[cpu][entry].tlb_hi);
+		mtc0_tlbw_hazard();
+		write_c0_entrylo0(vcpu->arch.shadow_tlb[cpu][entry].tlb_lo0);
+		write_c0_entrylo1(vcpu->arch.shadow_tlb[cpu][entry].tlb_lo1);
+
+		write_c0_index(entry);
+		mtc0_tlbw_hazard();
+
+		tlb_write_indexed();
+		tlbw_use_hazard();
+	}
+
+	tlbw_use_hazard();
+	write_c0_entryhi(old_ctx);
+	mtc0_tlbw_hazard();
+	local_irq_restore(flags);
+}
+
+
+void kvm_local_flush_tlb_all(void)
+{
+	unsigned long flags;
+	unsigned long old_ctx;
+	int entry = 0;
+
+	local_irq_save(flags);
+	/* Save old context and create impossible VPN2 value */
+	old_ctx = read_c0_entryhi();
+	write_c0_entrylo0(0);
+	write_c0_entrylo1(0);
+
+	/* Blast 'em all away. */
+	while (entry < current_cpu_data.tlbsize) {
+		/* Make sure all entries differ. */
+		write_c0_entryhi(UNIQUE_ENTRYHI(entry));
+		write_c0_index(entry);
+		mtc0_tlbw_hazard();
+		tlb_write_indexed();
+		entry++;
+	}
+	tlbw_use_hazard();
+	write_c0_entryhi(old_ctx);
+	mtc0_tlbw_hazard();
+
+	local_irq_restore(flags);
+}
+
+void kvm_mips_init_shadow_tlb(struct kvm_vcpu *vcpu)
+{
+	int cpu, entry;
+
+	for_each_possible_cpu(cpu) {
+		for (entry = 0; entry < current_cpu_data.tlbsize; entry++) {
+			vcpu->arch.shadow_tlb[cpu][entry].tlb_hi =
+			    UNIQUE_ENTRYHI(entry);
+			vcpu->arch.shadow_tlb[cpu][entry].tlb_lo0 = 0x0;
+			vcpu->arch.shadow_tlb[cpu][entry].tlb_lo1 = 0x0;
+			vcpu->arch.shadow_tlb[cpu][entry].tlb_mask =
+			    read_c0_pagemask();
+#ifdef DEBUG
+			kvm_debug
+			    ("shadow_tlb[%d][%d]: tlb_hi: %#lx, lo0: %#lx, lo1: %#lx\n",
+			     cpu, entry,
+			     vcpu->arch.shadow_tlb[cpu][entry].tlb_hi,
+			     vcpu->arch.shadow_tlb[cpu][entry].tlb_lo0,
+			     vcpu->arch.shadow_tlb[cpu][entry].tlb_lo1);
+#endif
+		}
+	}
+}
+
+/* Restore ASID once we are scheduled back after preemption */
+void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
+{
+	ulong flags;
+	int newasid = 0;
+
+#ifdef DEBUG
+	kvm_debug("%s: vcpu %p, cpu: %d\n", __func__, vcpu, cpu);
+#endif
+
+	/* Alocate new kernel and user ASIDs if needed */
+
+	local_irq_save(flags);
+
+	if (((vcpu->arch.
+	      guest_kernel_asid[cpu] ^ asid_cache(cpu)) & ASID_VERSION_MASK)) {
+		kvm_get_new_mmu_context(&vcpu->arch.guest_kernel_mm, cpu, vcpu);
+		vcpu->arch.guest_kernel_asid[cpu] =
+		    vcpu->arch.guest_kernel_mm.context.asid[cpu];
+		kvm_get_new_mmu_context(&vcpu->arch.guest_user_mm, cpu, vcpu);
+		vcpu->arch.guest_user_asid[cpu] =
+		    vcpu->arch.guest_user_mm.context.asid[cpu];
+		newasid++;
+
+		kvm_info("[%d]: cpu_context: %#lx\n", cpu,
+			 cpu_context(cpu, current->mm));
+		kvm_info("[%d]: Allocated new ASID for Guest Kernel: %#x\n",
+			 cpu, vcpu->arch.guest_kernel_asid[cpu]);
+		kvm_info("[%d]: Allocated new ASID for Guest User: %#x\n", cpu,
+			 vcpu->arch.guest_user_asid[cpu]);
+	}
+
+	if (vcpu->arch.last_sched_cpu != cpu) {
+		kvm_info("[%d->%d]KVM VCPU[%d] switch\n",
+			 vcpu->arch.last_sched_cpu, cpu, vcpu->vcpu_id);
+	}
+
+	/* Only reload shadow host TLB if new ASIDs haven't been allocated */
+#if 0
+	if ((atomic_read(&kvm_mips_instance) > 1) && !newasid) {
+		kvm_mips_flush_host_tlb(0);
+		kvm_shadow_tlb_load(vcpu);
+	}
+#endif
+
+	if (!newasid) {
+		/* If we preempted while the guest was executing, then reload the pre-empted ASID */
+		if (current->flags & PF_VCPU) {
+			write_c0_entryhi(vcpu->arch.
+					 preempt_entryhi & ASID_MASK);
+			ehb();
+		}
+	} else {
+		/* New ASIDs were allocated for the VM */
+
+		/* Were we in guest context? If so then the pre-empted ASID is no longer
+		 * valid, we need to set it to what it should be based on the mode of
+		 * the Guest (Kernel/User)
+		 */
+		if (current->flags & PF_VCPU) {
+			if (KVM_GUEST_KERNEL_MODE(vcpu))
+				write_c0_entryhi(vcpu->arch.
+						 guest_kernel_asid[cpu] &
+						 ASID_MASK);
+			else
+				write_c0_entryhi(vcpu->arch.
+						 guest_user_asid[cpu] &
+						 ASID_MASK);
+			ehb();
+		}
+	}
+
+	local_irq_restore(flags);
+
+}
+
+/* ASID can change if another task is scheduled during preemption */
+void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
+{
+	ulong flags __unused;
+	uint32_t cpu __unused;
+
+	local_irq_save(flags);
+
+	cpu = smp_processor_id();
+
+
+	vcpu->arch.preempt_entryhi = read_c0_entryhi();
+	vcpu->arch.last_sched_cpu = cpu;
+
+#if 0
+	if ((atomic_read(&kvm_mips_instance) > 1)) {
+		kvm_shadow_tlb_put(vcpu);
+	}
+#endif
+
+	if (((cpu_context(cpu, current->mm) ^ asid_cache(cpu)) &
+	     ASID_VERSION_MASK)) {
+		kvm_debug("%s: Dropping MMU Context:  %#lx\n", __func__,
+			  cpu_context(cpu, current->mm));
+		drop_mmu_context(current->mm, cpu);
+	}
+	write_c0_entryhi(cpu_asid(cpu, current->mm));
+	ehb();
+
+	local_irq_restore(flags);
+}
+
+uint32_t kvm_get_inst(uint32_t *opc, struct kvm_vcpu *vcpu)
+{
+	uint32_t inst;
+	struct mips_coproc *cop0 __unused = vcpu->arch.cop0;
+	int index;
+	ulong paddr, flags;
+
+	if (KVM_GUEST_KSEGX((ulong) opc) < KVM_GUEST_KSEG0 ||
+	    KVM_GUEST_KSEGX((ulong) opc) == KVM_GUEST_KSEG23) {
+		local_irq_save(flags);
+		index = kvm_mips_host_tlb_lookup(vcpu, (ulong) opc);
+		if (index >= 0) {
+			inst = *(opc);
+		} else {
+			index =
+			    kvm_mips_guest_tlb_lookup(vcpu,
+						      ((ulong) opc & VPN2_MASK)
+						      |
+						      (kvm_read_c0_guest_entryhi
+						       (cop0) & ASID_MASK));
+			if (index < 0) {
+				kvm_err
+				    ("%s: get_user_failed for %p, vcpu: %p, ASID: %#lx\n",
+				     __func__, opc, vcpu, read_c0_entryhi());
+				kvm_mips_dump_host_tlbs();
+				local_irq_restore(flags);
+				return KVM_INVALID_INST;
+			}
+			kvm_mips_handle_mapped_seg_tlb_fault(vcpu,
+							     &vcpu->arch.
+							     guest_tlb[index],
+							     NULL, NULL);
+			inst = *(opc);
+		}
+		local_irq_restore(flags);
+	} else if (KVM_GUEST_KSEGX(opc) == KVM_GUEST_KSEG0) {
+		paddr =
+		    kvm_mips_translate_guest_kseg0_to_hpa(vcpu, (ulong) opc);
+		inst = *(uint32_t *) CKSEG0ADDR(paddr);
+	} else {
+		kvm_err("%s: illegal address: %p\n", __func__, opc);
+		return KVM_INVALID_INST;
+	}
+
+	return inst;
+}
+
+EXPORT_SYMBOL(kvm_local_flush_tlb_all);
+EXPORT_SYMBOL(kvm_shadow_tlb_put);
+EXPORT_SYMBOL(kvm_mips_handle_mapped_seg_tlb_fault);
+EXPORT_SYMBOL(kvm_mips_handle_commpage_tlb_fault);
+EXPORT_SYMBOL(kvm_mips_init_shadow_tlb);
+EXPORT_SYMBOL(kvm_mips_dump_host_tlbs);
+EXPORT_SYMBOL(kvm_mips_handle_kseg0_tlb_fault);
+EXPORT_SYMBOL(kvm_mips_host_tlb_lookup);
+EXPORT_SYMBOL(kvm_mips_flush_host_tlb);
+EXPORT_SYMBOL(kvm_mips_guest_tlb_lookup);
+EXPORT_SYMBOL(kvm_mips_host_tlb_inv);
+EXPORT_SYMBOL(kvm_mips_translate_guest_kseg0_to_hpa);
+EXPORT_SYMBOL(kvm_shadow_tlb_load);
+EXPORT_SYMBOL(kvm_mips_dump_shadow_tlbs);
+EXPORT_SYMBOL(kvm_mips_dump_guest_tlbs);
+EXPORT_SYMBOL(kvm_get_inst);
+EXPORT_SYMBOL(kvm_arch_vcpu_load);
+EXPORT_SYMBOL(kvm_arch_vcpu_put);
+
-- 
1.7.11.3
