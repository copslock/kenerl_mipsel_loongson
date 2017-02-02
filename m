Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Feb 2017 13:14:27 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:44884 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993931AbdBBMFO33jvv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Feb 2017 13:05:14 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 2544C7AB38616;
        Thu,  2 Feb 2017 12:05:09 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 2 Feb 2017 12:05:11 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH v2 23/30] KVM: MIPS/MMU: Convert TLB mapped faults to page tables
Date:   Thu, 2 Feb 2017 12:04:36 +0000
Message-ID: <c25db5777e77bab48c49acea14918e148d2e1893.1486036366.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
In-Reply-To: <cover.e37f86dece46fc3ed00a075d68119cab361cda8e.1486036366.git-series.james.hogan@imgtec.com>
References: <cover.e37f86dece46fc3ed00a075d68119cab361cda8e.1486036366.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56610
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

Now that we have GVA page tables and an optimised TLB refill handler in
place, convert the handling of page faults in TLB mapped segment from
the guest to fill a single GVA page table entry and invalidate the TLB
entry, rather than filling a TLB entry pair directly.

Also remove the now unused kvm_mips_get_{kernel,user}_asid() functions
in mmu.c and kvm_mips_host_tlb_write() in tlb.c.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h |  7 +--
 arch/mips/kvm/emulate.c          |  6 +-
 arch/mips/kvm/mmu.c              | 93 ++++++++++++---------------------
 arch/mips/kvm/tlb.c              | 64 +-----------------------
 4 files changed, 40 insertions(+), 130 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 40aab4f5007c..f7680999e28a 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -599,7 +599,8 @@ extern int kvm_mips_handle_commpage_tlb_fault(unsigned long badvaddr,
 					      struct kvm_vcpu *vcpu);
 
 extern int kvm_mips_handle_mapped_seg_tlb_fault(struct kvm_vcpu *vcpu,
-						struct kvm_mips_tlb *tlb);
+						struct kvm_mips_tlb *tlb,
+						unsigned long gva);
 
 extern enum emulation_result kvm_mips_handle_tlbmiss(u32 cause,
 						     u32 *opc,
@@ -613,10 +614,6 @@ extern enum emulation_result kvm_mips_handle_tlbmod(u32 cause,
 
 extern void kvm_mips_dump_host_tlbs(void);
 extern void kvm_mips_dump_guest_tlbs(struct kvm_vcpu *vcpu);
-extern int kvm_mips_host_tlb_write(struct kvm_vcpu *vcpu, unsigned long entryhi,
-				   unsigned long entrylo0,
-				   unsigned long entrylo1,
-				   int flush_dcache_mask);
 extern void kvm_mips_flush_host_tlb(int skip_kseg0);
 extern int kvm_mips_host_tlb_inv(struct kvm_vcpu *vcpu, unsigned long entryhi,
 				 bool user, bool kernel);
diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index 19eaeda6975c..3ced662e012e 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -1770,7 +1770,8 @@ enum emulation_result kvm_mips_emulate_cache(union mips_instruction inst,
 			 * We fault an entry from the guest tlb to the
 			 * shadow host TLB
 			 */
-			if (kvm_mips_handle_mapped_seg_tlb_fault(vcpu, tlb)) {
+			if (kvm_mips_handle_mapped_seg_tlb_fault(vcpu, tlb,
+								 va)) {
 				kvm_err("%s: handling mapped seg tlb fault for %lx, index: %u, vcpu: %p, ASID: %#lx\n",
 					__func__, va, index, vcpu,
 					read_c0_entryhi());
@@ -2746,7 +2747,8 @@ enum emulation_result kvm_mips_handle_tlbmiss(u32 cause,
 			 * OK we have a Guest TLB entry, now inject it into the
 			 * shadow host TLB
 			 */
-			if (kvm_mips_handle_mapped_seg_tlb_fault(vcpu, tlb)) {
+			if (kvm_mips_handle_mapped_seg_tlb_fault(vcpu, tlb,
+								 va)) {
 				kvm_err("%s: handling mapped seg tlb fault for %lx, index: %u, vcpu: %p, ASID: %#lx\n",
 					__func__, va, index, vcpu,
 					read_c0_entryhi());
diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index afb47f21d8bc..62122d297e52 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -61,22 +61,6 @@ void kvm_mmu_free_memory_caches(struct kvm_vcpu *vcpu)
 	mmu_free_memory_cache(&vcpu->arch.mmu_page_cache);
 }
 
-static u32 kvm_mips_get_kernel_asid(struct kvm_vcpu *vcpu)
-{
-	struct mm_struct *kern_mm = &vcpu->arch.guest_kernel_mm;
-	int cpu = smp_processor_id();
-
-	return cpu_asid(cpu, kern_mm);
-}
-
-static u32 kvm_mips_get_user_asid(struct kvm_vcpu *vcpu)
-{
-	struct mm_struct *user_mm = &vcpu->arch.guest_user_mm;
-	int cpu = smp_processor_id();
-
-	return cpu_asid(cpu, user_mm);
-}
-
 /**
  * kvm_mips_walk_pgd() - Walk page table with optional allocation.
  * @pgd:	Page directory pointer.
@@ -411,67 +395,58 @@ int kvm_mips_handle_kseg0_tlb_fault(unsigned long badvaddr,
 }
 
 int kvm_mips_handle_mapped_seg_tlb_fault(struct kvm_vcpu *vcpu,
-					 struct kvm_mips_tlb *tlb)
+					 struct kvm_mips_tlb *tlb,
+					 unsigned long gva)
 {
-	unsigned long entryhi = 0, entrylo0 = 0, entrylo1 = 0;
 	struct kvm *kvm = vcpu->kvm;
-	kvm_pfn_t pfn0, pfn1;
-	gfn_t gfn0, gfn1;
-	long tlb_lo[2];
-	int ret;
-
-	tlb_lo[0] = tlb->tlb_lo[0];
-	tlb_lo[1] = tlb->tlb_lo[1];
+	kvm_pfn_t pfn;
+	gfn_t gfn;
+	long tlb_lo = 0;
+	pte_t *ptep_gva;
+	unsigned int idx;
+	bool kernel = KVM_GUEST_KERNEL_MODE(vcpu);
 
 	/*
 	 * The commpage address must not be mapped to anything else if the guest
 	 * TLB contains entries nearby, or commpage accesses will break.
 	 */
-	if (!((tlb->tlb_hi ^ KVM_GUEST_COMMPAGE_ADDR) &
-			VPN2_MASK & (PAGE_MASK << 1)))
-		tlb_lo[(KVM_GUEST_COMMPAGE_ADDR >> PAGE_SHIFT) & 1] = 0;
-
-	gfn0 = mips3_tlbpfn_to_paddr(tlb_lo[0]) >> PAGE_SHIFT;
-	gfn1 = mips3_tlbpfn_to_paddr(tlb_lo[1]) >> PAGE_SHIFT;
-	if (gfn0 >= kvm->arch.guest_pmap_npages ||
-	    gfn1 >= kvm->arch.guest_pmap_npages) {
-		kvm_err("%s: Invalid gfn: [%#llx, %#llx], EHi: %#lx\n",
-			__func__, gfn0, gfn1, tlb->tlb_hi);
+	idx = TLB_LO_IDX(*tlb, gva);
+	if ((gva ^ KVM_GUEST_COMMPAGE_ADDR) & VPN2_MASK & PAGE_MASK)
+		tlb_lo = tlb->tlb_lo[idx];
+
+	/* Find host PFN */
+	gfn = mips3_tlbpfn_to_paddr(tlb_lo) >> PAGE_SHIFT;
+	if (gfn >= kvm->arch.guest_pmap_npages) {
+		kvm_err("%s: Invalid gfn: %#llx, EHi: %#lx\n",
+			__func__, gfn, tlb->tlb_hi);
 		kvm_mips_dump_guest_tlbs(vcpu);
 		return -1;
 	}
-
-	if (kvm_mips_map_page(kvm, gfn0) < 0)
+	if (kvm_mips_map_page(kvm, gfn) < 0)
 		return -1;
+	pfn = kvm->arch.guest_pmap[gfn];
 
-	if (kvm_mips_map_page(kvm, gfn1) < 0)
+	/* Find GVA page table entry */
+	ptep_gva = kvm_trap_emul_pte_for_gva(vcpu, gva);
+	if (!ptep_gva) {
+		kvm_err("No ptep for gva %lx\n", gva);
 		return -1;
+	}
 
-	pfn0 = kvm->arch.guest_pmap[gfn0];
-	pfn1 = kvm->arch.guest_pmap[gfn1];
+	/* Write PFN into GVA page table, taking attributes from Guest TLB */
+	*ptep_gva = pfn_pte(pfn, (!(tlb_lo & ENTRYLO_V)) ? __pgprot(0) :
+				 (tlb_lo & ENTRYLO_D) ? PAGE_SHARED :
+				 PAGE_READONLY);
+	if (pte_present(*ptep_gva))
+		*ptep_gva = pte_mkyoung(pte_mkdirty(*ptep_gva));
 
-	/* Get attributes from the Guest TLB */
-	entrylo0 = mips3_paddr_to_tlbpfn(pfn0 << PAGE_SHIFT) |
-		((_page_cachable_default >> _CACHE_SHIFT) << ENTRYLO_C_SHIFT) |
-		(tlb_lo[0] & ENTRYLO_D) |
-		(tlb_lo[0] & ENTRYLO_V);
-	entrylo1 = mips3_paddr_to_tlbpfn(pfn1 << PAGE_SHIFT) |
-		((_page_cachable_default >> _CACHE_SHIFT) << ENTRYLO_C_SHIFT) |
-		(tlb_lo[1] & ENTRYLO_D) |
-		(tlb_lo[1] & ENTRYLO_V);
+	/* Invalidate this entry in the TLB, current guest mode ASID only */
+	kvm_mips_host_tlb_inv(vcpu, gva, !kernel, kernel);
 
 	kvm_debug("@ %#lx tlb_lo0: 0x%08lx tlb_lo1: 0x%08lx\n", vcpu->arch.pc,
 		  tlb->tlb_lo[0], tlb->tlb_lo[1]);
 
-	preempt_disable();
-	entryhi = (tlb->tlb_hi & VPN2_MASK) | (KVM_GUEST_KERNEL_MODE(vcpu) ?
-					       kvm_mips_get_kernel_asid(vcpu) :
-					       kvm_mips_get_user_asid(vcpu));
-	ret = kvm_mips_host_tlb_write(vcpu, entryhi, entrylo0, entrylo1,
-				      tlb->tlb_mask);
-	preempt_enable();
-
-	return ret;
+	return 0;
 }
 
 void kvm_get_new_mmu_context(struct mm_struct *mm, unsigned long cpu,
@@ -582,7 +557,7 @@ u32 kvm_get_inst(u32 *opc, struct kvm_vcpu *vcpu)
 				return KVM_INVALID_INST;
 			}
 			if (kvm_mips_handle_mapped_seg_tlb_fault(vcpu,
-						&vcpu->arch.guest_tlb[index])) {
+					&vcpu->arch.guest_tlb[index], va)) {
 				kvm_err("%s: handling mapped seg tlb fault failed for %p, index: %u, vcpu: %p, ASID: %#lx\n",
 					__func__, opc, index, vcpu,
 					read_c0_entryhi());
diff --git a/arch/mips/kvm/tlb.c b/arch/mips/kvm/tlb.c
index 06ee9a1d78a5..2fb76869d017 100644
--- a/arch/mips/kvm/tlb.c
+++ b/arch/mips/kvm/tlb.c
@@ -104,70 +104,6 @@ void kvm_mips_dump_guest_tlbs(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_GPL(kvm_mips_dump_guest_tlbs);
 
-/* XXXKYMA: Must be called with interrupts disabled */
-/* set flush_dcache_mask == 0 if no dcache flush required */
-int kvm_mips_host_tlb_write(struct kvm_vcpu *vcpu, unsigned long entryhi,
-			    unsigned long entrylo0, unsigned long entrylo1,
-			    int flush_dcache_mask)
-{
-	unsigned long flags;
-	unsigned long old_entryhi;
-	int idx;
-
-	local_irq_save(flags);
-
-	old_entryhi = read_c0_entryhi();
-	write_c0_entryhi(entryhi);
-	mtc0_tlbw_hazard();
-
-	tlb_probe();
-	tlb_probe_hazard();
-	idx = read_c0_index();
-
-	if (idx > current_cpu_data.tlbsize) {
-		kvm_err("%s: Invalid Index: %d\n", __func__, idx);
-		kvm_mips_dump_host_tlbs();
-		local_irq_restore(flags);
-		return -1;
-	}
-
-	write_c0_entrylo0(entrylo0);
-	write_c0_entrylo1(entrylo1);
-	mtc0_tlbw_hazard();
-
-	if (idx < 0)
-		tlb_write_random();
-	else
-		tlb_write_indexed();
-	tlbw_use_hazard();
-
-	kvm_debug("@ %#lx idx: %2d [entryhi(R): %#lx] entrylo0(R): 0x%08lx, entrylo1(R): 0x%08lx\n",
-		  vcpu->arch.pc, idx, read_c0_entryhi(),
-		  read_c0_entrylo0(), read_c0_entrylo1());
-
-	/* Flush D-cache */
-	if (flush_dcache_mask) {
-		if (entrylo0 & ENTRYLO_V) {
-			++vcpu->stat.flush_dcache_exits;
-			flush_data_cache_page((entryhi & VPN2_MASK) &
-					      ~flush_dcache_mask);
-		}
-		if (entrylo1 & ENTRYLO_V) {
-			++vcpu->stat.flush_dcache_exits;
-			flush_data_cache_page(((entryhi & VPN2_MASK) &
-					       ~flush_dcache_mask) |
-					      (0x1 << PAGE_SHIFT));
-		}
-	}
-
-	/* Restore old ASID */
-	write_c0_entryhi(old_entryhi);
-	mtc0_tlbw_hazard();
-	local_irq_restore(flags);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(kvm_mips_host_tlb_write);
-
 int kvm_mips_handle_commpage_tlb_fault(unsigned long badvaddr,
 	struct kvm_vcpu *vcpu)
 {
-- 
git-series 0.8.10
