Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jan 2017 02:43:48 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:45428 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993135AbdAFBdxsLcGu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Jan 2017 02:33:53 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 581A883348665;
        Fri,  6 Jan 2017 01:33:46 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 6 Jan 2017 01:33:47 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 24/30] KVM: MIPS/MMU: Convert commpage fault handling to page tables
Date:   Fri, 6 Jan 2017 01:32:56 +0000
Message-ID: <8df579b8a65d4462ace7f0de32891619c15d591d.1483665879.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
In-Reply-To: <cover.d6d201de414322ed2c1372e164254e6055ef7db9.1483665879.git-series.james.hogan@imgtec.com>
References: <cover.d6d201de414322ed2c1372e164254e6055ef7db9.1483665879.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56198
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
place, convert the handling of commpage faults from the guest kernel to
fill the GVA page table and invalidate the TLB entry, rather than
filling the wired TLB entry directly.

For simplicity we no longer use a wired entry for the commpage (refill
should be much cheaper with the fast-path handler anyway). Since we
don't need to manipulate the TLB directly any longer, move the function
from tlb.c to mmu.c. This puts it closer to the similar functions
handling KSeg0 and TLB mapped page faults from the guest.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h |  3 +--
 arch/mips/kvm/mips.c             | 34 +--------------------------
 arch/mips/kvm/mmu.c              | 21 ++++++++++++++++-
 arch/mips/kvm/tlb.c              | 44 +---------------------------------
 4 files changed, 22 insertions(+), 80 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 52a83a8e603a..667bf34b91f7 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -159,9 +159,6 @@ struct kvm_arch {
 	/* Guest GVA->HPA page table */
 	unsigned long *guest_pmap;
 	unsigned long guest_pmap_npages;
-
-	/* Wired host TLB used for the commpage */
-	int commpage_tlb;
 };
 
 #define N_MIPS_COPROC_REGS	32
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index c55e6f8c57c7..09fcfde0a9db 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -92,28 +92,10 @@ void kvm_arch_check_processor_compat(void *rtn)
 	*(int *)rtn = 0;
 }
 
-static void kvm_mips_init_tlbs(struct kvm *kvm)
-{
-	unsigned long wired;
-
-	/*
-	 * Add a wired entry to the TLB, it is used to map the commpage to
-	 * the Guest kernel
-	 */
-	wired = read_c0_wired();
-	write_c0_wired(wired + 1);
-	mtc0_tlbw_hazard();
-	kvm->arch.commpage_tlb = wired;
-
-	kvm_debug("[%d] commpage TLB: %d\n", smp_processor_id(),
-		  kvm->arch.commpage_tlb);
-}
-
 static void kvm_mips_init_vm_percpu(void *arg)
 {
 	struct kvm *kvm = (struct kvm *)arg;
 
-	kvm_mips_init_tlbs(kvm);
 	kvm_mips_callbacks->vm_init(kvm);
 
 }
@@ -165,25 +147,11 @@ void kvm_mips_free_vcpus(struct kvm *kvm)
 	mutex_unlock(&kvm->lock);
 }
 
-static void kvm_mips_uninit_tlbs(void *arg)
-{
-	/* Restore wired count */
-	write_c0_wired(0);
-	mtc0_tlbw_hazard();
-	/* Clear out all the TLBs */
-	kvm_local_flush_tlb_all();
-}
-
 void kvm_arch_destroy_vm(struct kvm *kvm)
 {
 	kvm_mips_free_vcpus(kvm);
 
-	/* If this is the last instance, restore wired count */
-	if (atomic_dec_return(&kvm_mips_instance) == 0) {
-		kvm_debug("%s: last KVM instance, restoring TLB parameters\n",
-			  __func__);
-		on_each_cpu(kvm_mips_uninit_tlbs, NULL, 1);
-	}
+	atomic_dec(&kvm_mips_instance);
 }
 
 long kvm_arch_dev_ioctl(struct file *filp, unsigned int ioctl,
diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index 62122d297e52..98f1a7715a68 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -449,6 +449,27 @@ int kvm_mips_handle_mapped_seg_tlb_fault(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
+int kvm_mips_handle_commpage_tlb_fault(unsigned long badvaddr,
+				       struct kvm_vcpu *vcpu)
+{
+	kvm_pfn_t pfn;
+	pte_t *ptep;
+
+	ptep = kvm_trap_emul_pte_for_gva(vcpu, badvaddr);
+	if (!ptep) {
+		kvm_err("No ptep for commpage %lx\n", badvaddr);
+		return -1;
+	}
+
+	pfn = PFN_DOWN(virt_to_phys(vcpu->arch.kseg0_commpage));
+	/* Also set valid and dirty, so refill handler doesn't have to */
+	*ptep = pte_mkyoung(pte_mkdirty(pfn_pte(pfn, PAGE_SHARED)));
+
+	/* Invalidate this entry in the TLB, guest kernel ASID only */
+	kvm_mips_host_tlb_inv(vcpu, badvaddr, false, true);
+	return 0;
+}
+
 void kvm_get_new_mmu_context(struct mm_struct *mm, unsigned long cpu,
 			     struct kvm_vcpu *vcpu)
 {
diff --git a/arch/mips/kvm/tlb.c b/arch/mips/kvm/tlb.c
index 74c8187ffb0c..9bcab0dc827b 100644
--- a/arch/mips/kvm/tlb.c
+++ b/arch/mips/kvm/tlb.c
@@ -52,11 +52,6 @@ static u32 kvm_mips_get_user_asid(struct kvm_vcpu *vcpu)
 	return cpu_asid(cpu, user_mm);
 }
 
-inline u32 kvm_mips_get_commpage_asid(struct kvm_vcpu *vcpu)
-{
-	return vcpu->kvm->arch.commpage_tlb;
-}
-
 /* Structure defining an tlb entry data set. */
 
 void kvm_mips_dump_host_tlbs(void)
@@ -104,45 +99,6 @@ void kvm_mips_dump_guest_tlbs(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_GPL(kvm_mips_dump_guest_tlbs);
 
-int kvm_mips_handle_commpage_tlb_fault(unsigned long badvaddr,
-	struct kvm_vcpu *vcpu)
-{
-	kvm_pfn_t pfn;
-	unsigned long flags, old_entryhi = 0, vaddr = 0;
-	unsigned long entrylo[2] = { 0, 0 };
-	unsigned int pair_idx;
-
-	pfn = PFN_DOWN(virt_to_phys(vcpu->arch.kseg0_commpage));
-	pair_idx = (badvaddr >> PAGE_SHIFT) & 1;
-	entrylo[pair_idx] = mips3_paddr_to_tlbpfn(pfn << PAGE_SHIFT) |
-		((_page_cachable_default >> _CACHE_SHIFT) << ENTRYLO_C_SHIFT) |
-		ENTRYLO_D | ENTRYLO_V;
-
-	local_irq_save(flags);
-
-	old_entryhi = read_c0_entryhi();
-	vaddr = badvaddr & (PAGE_MASK << 1);
-	write_c0_entryhi(vaddr | kvm_mips_get_kernel_asid(vcpu));
-	write_c0_entrylo0(entrylo[0]);
-	write_c0_entrylo1(entrylo[1]);
-	write_c0_index(kvm_mips_get_commpage_asid(vcpu));
-	mtc0_tlbw_hazard();
-	tlb_write_indexed();
-	tlbw_use_hazard();
-
-	kvm_debug("@ %#lx idx: %2d [entryhi(R): %#lx] entrylo0 (R): 0x%08lx, entrylo1(R): 0x%08lx\n",
-		  vcpu->arch.pc, read_c0_index(), read_c0_entryhi(),
-		  read_c0_entrylo0(), read_c0_entrylo1());
-
-	/* Restore old ASID */
-	write_c0_entryhi(old_entryhi);
-	mtc0_tlbw_hazard();
-	local_irq_restore(flags);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(kvm_mips_handle_commpage_tlb_fault);
-
 int kvm_mips_guest_tlb_lookup(struct kvm_vcpu *vcpu, unsigned long entryhi)
 {
 	int i;
-- 
git-series 0.8.10
