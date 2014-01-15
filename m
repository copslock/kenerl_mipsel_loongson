Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jan 2014 11:12:59 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:9543 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827340AbaAOKMFg2mg1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Jan 2014 11:12:05 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     John Crispin <john@phrozen.org>,
        Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Gleb Natapov <gleb@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
        Sanjay Lal <sanjayl@kymasys.com>
Subject: [PATCH 2/2] MIPS: KVM: remove shadow_tlb code
Date:   Wed, 15 Jan 2014 10:11:22 +0000
Message-ID: <1389780682-32638-3-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1389780682-32638-1-git-send-email-james.hogan@imgtec.com>
References: <1389780682-32638-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.65]
X-SEF-Processed: 7_3_0_01192__2014_01_15_10_12_01
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38982
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

The initialisation of the shadow host TLB assumes the number of host TLB
entries <= 64, an assumption that can break in the presense of an FTLB
for which support was recently added. This results in an overflow and
amongst other things the comparecount timer callback function pointer
being overwritten which causes a lock up.

The shadow host TLB is actually disabled at present as it is not
necessary, so lets remove that code entirely.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: Gleb Natapov <gleb@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
Cc: Sanjay Lal <sanjayl@kymasys.com>
---
This is based on John Crispin's mips-next-3.14 branch where FTLB support
is applied.
---
 arch/mips/include/asm/kvm_host.h |   7 ---
 arch/mips/kvm/kvm_mips.c         |   1 -
 arch/mips/kvm/kvm_tlb.c          | 130 ---------------------------------------
 3 files changed, 138 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 32966969f2f9..a995fce87791 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -391,9 +391,6 @@ struct kvm_vcpu_arch {
 	uint32_t guest_kernel_asid[NR_CPUS];
 	struct mm_struct guest_kernel_mm, guest_user_mm;
 
-	struct kvm_mips_tlb shadow_tlb[NR_CPUS][KVM_MIPS_GUEST_TLB_SIZE];
-
-
 	struct hrtimer comparecount_timer;
 
 	int last_sched_cpu;
@@ -529,7 +526,6 @@ extern enum emulation_result kvm_mips_handle_tlbmod(unsigned long cause,
 
 extern void kvm_mips_dump_host_tlbs(void);
 extern void kvm_mips_dump_guest_tlbs(struct kvm_vcpu *vcpu);
-extern void kvm_mips_dump_shadow_tlbs(struct kvm_vcpu *vcpu);
 extern void kvm_mips_flush_host_tlb(int skip_kseg0);
 extern int kvm_mips_host_tlb_inv(struct kvm_vcpu *vcpu, unsigned long entryhi);
 extern int kvm_mips_host_tlb_inv_index(struct kvm_vcpu *vcpu, int index);
@@ -541,10 +537,7 @@ extern unsigned long kvm_mips_translate_guest_kseg0_to_hpa(struct kvm_vcpu *vcpu
 						   unsigned long gva);
 extern void kvm_get_new_mmu_context(struct mm_struct *mm, unsigned long cpu,
 				    struct kvm_vcpu *vcpu);
-extern void kvm_shadow_tlb_put(struct kvm_vcpu *vcpu);
-extern void kvm_shadow_tlb_load(struct kvm_vcpu *vcpu);
 extern void kvm_local_flush_tlb_all(void);
-extern void kvm_mips_init_shadow_tlb(struct kvm_vcpu *vcpu);
 extern void kvm_mips_alloc_new_mmu_context(struct kvm_vcpu *vcpu);
 extern void kvm_mips_vcpu_load(struct kvm_vcpu *vcpu, int cpu);
 extern void kvm_mips_vcpu_put(struct kvm_vcpu *vcpu);
diff --git a/arch/mips/kvm/kvm_mips.c b/arch/mips/kvm/kvm_mips.c
index 73b34827826c..da5186fbd77a 100644
--- a/arch/mips/kvm/kvm_mips.c
+++ b/arch/mips/kvm/kvm_mips.c
@@ -1001,7 +1001,6 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
 	hrtimer_init(&vcpu->arch.comparecount_timer, CLOCK_MONOTONIC,
 		     HRTIMER_MODE_REL);
 	vcpu->arch.comparecount_timer.function = kvm_mips_comparecount_wakeup;
-	kvm_mips_init_shadow_tlb(vcpu);
 	return 0;
 }
 
diff --git a/arch/mips/kvm/kvm_tlb.c b/arch/mips/kvm/kvm_tlb.c
index 52083ea7fddd..68e6563915cd 100644
--- a/arch/mips/kvm/kvm_tlb.c
+++ b/arch/mips/kvm/kvm_tlb.c
@@ -145,30 +145,6 @@ void kvm_mips_dump_guest_tlbs(struct kvm_vcpu *vcpu)
 	}
 }
 
-void kvm_mips_dump_shadow_tlbs(struct kvm_vcpu *vcpu)
-{
-	int i;
-	volatile struct kvm_mips_tlb tlb;
-
-	printk("Shadow TLBs:\n");
-	for (i = 0; i < KVM_MIPS_GUEST_TLB_SIZE; i++) {
-		tlb = vcpu->arch.shadow_tlb[smp_processor_id()][i];
-		printk("TLB%c%3d Hi 0x%08lx ",
-		       (tlb.tlb_lo0 | tlb.tlb_lo1) & MIPS3_PG_V ? ' ' : '*',
-		       i, tlb.tlb_hi);
-		printk("Lo0=0x%09" PRIx64 " %c%c attr %lx ",
-		       (uint64_t) mips3_tlbpfn_to_paddr(tlb.tlb_lo0),
-		       (tlb.tlb_lo0 & MIPS3_PG_D) ? 'D' : ' ',
-		       (tlb.tlb_lo0 & MIPS3_PG_G) ? 'G' : ' ',
-		       (tlb.tlb_lo0 >> 3) & 7);
-		printk("Lo1=0x%09" PRIx64 " %c%c attr %lx sz=%lx\n",
-		       (uint64_t) mips3_tlbpfn_to_paddr(tlb.tlb_lo1),
-		       (tlb.tlb_lo1 & MIPS3_PG_D) ? 'D' : ' ',
-		       (tlb.tlb_lo1 & MIPS3_PG_G) ? 'G' : ' ',
-		       (tlb.tlb_lo1 >> 3) & 7, tlb.tlb_mask);
-	}
-}
-
 static int kvm_mips_map_page(struct kvm *kvm, gfn_t gfn)
 {
 	int srcu_idx, err = 0;
@@ -655,70 +631,6 @@ kvm_get_new_mmu_context(struct mm_struct *mm, unsigned long cpu,
 	cpu_context(cpu, mm) = asid_cache(cpu) = asid;
 }
 
-void kvm_shadow_tlb_put(struct kvm_vcpu *vcpu)
-{
-	unsigned long flags;
-	unsigned long old_entryhi;
-	unsigned long old_pagemask;
-	int entry = 0;
-	int cpu = smp_processor_id();
-
-	local_irq_save(flags);
-
-	old_entryhi = read_c0_entryhi();
-	old_pagemask = read_c0_pagemask();
-
-	for (entry = 0; entry < current_cpu_data.tlbsize; entry++) {
-		write_c0_index(entry);
-		mtc0_tlbw_hazard();
-		tlb_read();
-		tlbw_use_hazard();
-
-		vcpu->arch.shadow_tlb[cpu][entry].tlb_hi = read_c0_entryhi();
-		vcpu->arch.shadow_tlb[cpu][entry].tlb_lo0 = read_c0_entrylo0();
-		vcpu->arch.shadow_tlb[cpu][entry].tlb_lo1 = read_c0_entrylo1();
-		vcpu->arch.shadow_tlb[cpu][entry].tlb_mask = read_c0_pagemask();
-	}
-
-	write_c0_entryhi(old_entryhi);
-	write_c0_pagemask(old_pagemask);
-	mtc0_tlbw_hazard();
-
-	local_irq_restore(flags);
-
-}
-
-void kvm_shadow_tlb_load(struct kvm_vcpu *vcpu)
-{
-	unsigned long flags;
-	unsigned long old_ctx;
-	int entry;
-	int cpu = smp_processor_id();
-
-	local_irq_save(flags);
-
-	old_ctx = read_c0_entryhi();
-
-	for (entry = 0; entry < current_cpu_data.tlbsize; entry++) {
-		write_c0_entryhi(vcpu->arch.shadow_tlb[cpu][entry].tlb_hi);
-		mtc0_tlbw_hazard();
-		write_c0_entrylo0(vcpu->arch.shadow_tlb[cpu][entry].tlb_lo0);
-		write_c0_entrylo1(vcpu->arch.shadow_tlb[cpu][entry].tlb_lo1);
-
-		write_c0_index(entry);
-		mtc0_tlbw_hazard();
-
-		tlb_write_indexed();
-		tlbw_use_hazard();
-	}
-
-	tlbw_use_hazard();
-	write_c0_entryhi(old_ctx);
-	mtc0_tlbw_hazard();
-	local_irq_restore(flags);
-}
-
-
 void kvm_local_flush_tlb_all(void)
 {
 	unsigned long flags;
@@ -747,30 +659,6 @@ void kvm_local_flush_tlb_all(void)
 	local_irq_restore(flags);
 }
 
-void kvm_mips_init_shadow_tlb(struct kvm_vcpu *vcpu)
-{
-	int cpu, entry;
-
-	for_each_possible_cpu(cpu) {
-		for (entry = 0; entry < current_cpu_data.tlbsize; entry++) {
-			vcpu->arch.shadow_tlb[cpu][entry].tlb_hi =
-			    UNIQUE_ENTRYHI(entry);
-			vcpu->arch.shadow_tlb[cpu][entry].tlb_lo0 = 0x0;
-			vcpu->arch.shadow_tlb[cpu][entry].tlb_lo1 = 0x0;
-			vcpu->arch.shadow_tlb[cpu][entry].tlb_mask =
-			    read_c0_pagemask();
-#ifdef DEBUG
-			kvm_debug
-			    ("shadow_tlb[%d][%d]: tlb_hi: %#lx, lo0: %#lx, lo1: %#lx\n",
-			     cpu, entry,
-			     vcpu->arch.shadow_tlb[cpu][entry].tlb_hi,
-			     vcpu->arch.shadow_tlb[cpu][entry].tlb_lo0,
-			     vcpu->arch.shadow_tlb[cpu][entry].tlb_lo1);
-#endif
-		}
-	}
-}
-
 /* Restore ASID once we are scheduled back after preemption */
 void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
@@ -808,14 +696,6 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 			 vcpu->arch.last_sched_cpu, cpu, vcpu->vcpu_id);
 	}
 
-	/* Only reload shadow host TLB if new ASIDs haven't been allocated */
-#if 0
-	if ((atomic_read(&kvm_mips_instance) > 1) && !newasid) {
-		kvm_mips_flush_host_tlb(0);
-		kvm_shadow_tlb_load(vcpu);
-	}
-#endif
-
 	if (!newasid) {
 		/* If we preempted while the guest was executing, then reload the pre-empted ASID */
 		if (current->flags & PF_VCPU) {
@@ -861,12 +741,6 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 	vcpu->arch.preempt_entryhi = read_c0_entryhi();
 	vcpu->arch.last_sched_cpu = cpu;
 
-#if 0
-	if ((atomic_read(&kvm_mips_instance) > 1)) {
-		kvm_shadow_tlb_put(vcpu);
-	}
-#endif
-
 	if (((cpu_context(cpu, current->mm) ^ asid_cache(cpu)) &
 	     ASID_VERSION_MASK)) {
 		kvm_debug("%s: Dropping MMU Context:  %#lx\n", __func__,
@@ -928,10 +802,8 @@ uint32_t kvm_get_inst(uint32_t *opc, struct kvm_vcpu *vcpu)
 }
 
 EXPORT_SYMBOL(kvm_local_flush_tlb_all);
-EXPORT_SYMBOL(kvm_shadow_tlb_put);
 EXPORT_SYMBOL(kvm_mips_handle_mapped_seg_tlb_fault);
 EXPORT_SYMBOL(kvm_mips_handle_commpage_tlb_fault);
-EXPORT_SYMBOL(kvm_mips_init_shadow_tlb);
 EXPORT_SYMBOL(kvm_mips_dump_host_tlbs);
 EXPORT_SYMBOL(kvm_mips_handle_kseg0_tlb_fault);
 EXPORT_SYMBOL(kvm_mips_host_tlb_lookup);
@@ -939,8 +811,6 @@ EXPORT_SYMBOL(kvm_mips_flush_host_tlb);
 EXPORT_SYMBOL(kvm_mips_guest_tlb_lookup);
 EXPORT_SYMBOL(kvm_mips_host_tlb_inv);
 EXPORT_SYMBOL(kvm_mips_translate_guest_kseg0_to_hpa);
-EXPORT_SYMBOL(kvm_shadow_tlb_load);
-EXPORT_SYMBOL(kvm_mips_dump_shadow_tlbs);
 EXPORT_SYMBOL(kvm_mips_dump_guest_tlbs);
 EXPORT_SYMBOL(kvm_get_inst);
 EXPORT_SYMBOL(kvm_arch_vcpu_load);
-- 
1.8.1.2
