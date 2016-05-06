Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 May 2016 15:38:40 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:64182 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27028128AbcEFNgnNnG8k (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 May 2016 15:36:43 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id CA924278EBA0D;
        Fri,  6 May 2016 14:36:32 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 6 May 2016 14:36:35 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 6 May 2016 14:36:35 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 6/7] MIPS: Retrieve ASID masks using function accepting struct cpuinfo_mips
Date:   Fri, 6 May 2016 14:36:23 +0100
Message-ID: <1462541784-22128-7-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1462541784-22128-1-git-send-email-james.hogan@imgtec.com>
References: <1462541784-22128-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53297
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

From: Paul Burton <paul.burton@imgtec.com>

In preparation for supporting variable ASID masks, retrieve ASID masks
using functions in asm/cpu-info.h which accept struct cpuinfo_mips. This
will allow those functions to determine the ASID mask based upon the CPU
in a later patch. This also allows for the r3k & r8k cases to be handled
in Kconfig, which is arguably cleaner than the previous #ifdefs.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/Kconfig                   | 11 ++++++++++
 arch/mips/include/asm/cpu-info.h    | 10 +++++++++
 arch/mips/include/asm/mmu_context.h | 41 ++++++++++++++++---------------------
 arch/mips/kernel/traps.c            |  2 +-
 arch/mips/kvm/tlb.c                 | 30 +++++++++++++++++----------
 arch/mips/lib/dump_tlb.c            | 10 +++++----
 arch/mips/lib/r3k_dump_tlb.c        |  9 ++++----
 arch/mips/mm/tlb-r3k.c              | 24 +++++++++++++---------
 arch/mips/mm/tlb-r4k.c              |  2 +-
 arch/mips/mm/tlb-r8k.c              |  2 +-
 10 files changed, 86 insertions(+), 55 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 2018c2b0e078..132d1c68befc 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2401,6 +2401,17 @@ config CPU_R4000_WORKAROUNDS
 config CPU_R4400_WORKAROUNDS
 	bool
 
+config MIPS_ASID_SHIFT
+	int
+	default 6 if CPU_R3000 || CPU_TX39XX
+	default 4 if CPU_R8000
+	default 0
+
+config MIPS_ASID_BITS
+	int
+	default 6 if CPU_R3000 || CPU_TX39XX
+	default 8
+
 #
 # - Highmem only makes sense for the 32-bit kernel.
 # - The current highmem code will only work properly on physically indexed
diff --git a/arch/mips/include/asm/cpu-info.h b/arch/mips/include/asm/cpu-info.h
index af12c1f9f1a8..4cb3cdadc41e 100644
--- a/arch/mips/include/asm/cpu-info.h
+++ b/arch/mips/include/asm/cpu-info.h
@@ -131,4 +131,14 @@ struct proc_cpuinfo_notifier_args {
 # define cpu_vpe_id(cpuinfo)	({ (void)cpuinfo; 0; })
 #endif
 
+static inline unsigned long cpu_asid_inc(void)
+{
+	return 1 << CONFIG_MIPS_ASID_SHIFT;
+}
+
+static inline unsigned long cpu_asid_mask(struct cpuinfo_mips *cpuinfo)
+{
+	return ((1 << CONFIG_MIPS_ASID_BITS) - 1) << CONFIG_MIPS_ASID_SHIFT;
+}
+
 #endif /* __ASM_CPU_INFO_H */
diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mmu_context.h
index 45914b59824c..fc57e135cb0a 100644
--- a/arch/mips/include/asm/mmu_context.h
+++ b/arch/mips/include/asm/mmu_context.h
@@ -65,37 +65,32 @@ extern unsigned long pgd_current[];
 	back_to_back_c0_hazard();					\
 	TLBMISS_HANDLER_SETUP_PGD(swapper_pg_dir)
 #endif /* CONFIG_MIPS_PGD_C0_CONTEXT*/
-#if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
 
-#define ASID_INC	0x40
-#define ASID_MASK	0xfc0
+/*
+ *  All unused by hardware upper bits will be considered
+ *  as a software asid extension.
+ */
+static unsigned long asid_version_mask(unsigned int cpu)
+{
+	unsigned long asid_mask = cpu_asid_mask(&cpu_data[cpu]);
 
-#elif defined(CONFIG_CPU_R8000)
+	return ~(asid_mask | (asid_mask - 1));
+}
 
-#define ASID_INC	0x10
-#define ASID_MASK	0xff0
-
-#else /* FIXME: not correct for R6000 */
-
-#define ASID_INC	0x1
-#define ASID_MASK	0xff
-
-#endif
+static unsigned long asid_first_version(unsigned int cpu)
+{
+	return ~asid_version_mask(cpu) + 1;
+}
 
 #define cpu_context(cpu, mm)	((mm)->context.asid[cpu])
-#define cpu_asid(cpu, mm)	(cpu_context((cpu), (mm)) & ASID_MASK)
 #define asid_cache(cpu)		(cpu_data[cpu].asid_cache)
+#define cpu_asid(cpu, mm) \
+	(cpu_context((cpu), (mm)) & cpu_asid_mask(&cpu_data[cpu]))
 
 static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 {
 }
 
-/*
- *  All unused by hardware upper bits will be considered
- *  as a software asid extension.
- */
-#define ASID_VERSION_MASK  ((unsigned long)~(ASID_MASK|(ASID_MASK-1)))
-#define ASID_FIRST_VERSION ((unsigned long)(~ASID_VERSION_MASK) + 1)
 
 /* Normal, classic MIPS get_new_mmu_context */
 static inline void
@@ -104,7 +99,7 @@ get_new_mmu_context(struct mm_struct *mm, unsigned long cpu)
 	extern void kvm_local_flush_tlb_all(void);
 	unsigned long asid = asid_cache(cpu);
 
-	if (! ((asid += ASID_INC) & ASID_MASK) ) {
+	if (!((asid += cpu_asid_inc()) & cpu_asid_mask(&cpu_data[cpu]))) {
 		if (cpu_has_vtag_icache)
 			flush_icache_all();
 #ifdef CONFIG_KVM
@@ -113,7 +108,7 @@ get_new_mmu_context(struct mm_struct *mm, unsigned long cpu)
 		local_flush_tlb_all();	/* start new asid cycle */
 #endif
 		if (!asid)		/* fix version if needed */
-			asid = ASID_FIRST_VERSION;
+			asid = asid_first_version(cpu);
 	}
 
 	cpu_context(cpu, mm) = asid_cache(cpu) = asid;
@@ -145,7 +140,7 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 
 	htw_stop();
 	/* Check if our ASID is of an older version and thus invalid */
-	if ((cpu_context(cpu, next) ^ asid_cache(cpu)) & ASID_VERSION_MASK)
+	if ((cpu_context(cpu, next) ^ asid_cache(cpu)) & asid_version_mask(cpu))
 		get_new_mmu_context(next, cpu);
 	write_c0_entryhi(cpu_asid(cpu, next));
 	TLBMISS_HANDLER_SETUP_PGD(next->pgd);
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index ae0c89d23ad7..1dd4198f25fb 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -2134,7 +2134,7 @@ void per_cpu_trap_init(bool is_boot_cpu)
 	}
 
 	if (!cpu_data[cpu].asid_cache)
-		cpu_data[cpu].asid_cache = ASID_FIRST_VERSION;
+		cpu_data[cpu].asid_cache = asid_first_version(cpu);
 
 	atomic_inc(&init_mm.mm_count);
 	current->active_mm = &init_mm;
diff --git a/arch/mips/kvm/tlb.c b/arch/mips/kvm/tlb.c
index 52d87280f865..b9c52c1d35d6 100644
--- a/arch/mips/kvm/tlb.c
+++ b/arch/mips/kvm/tlb.c
@@ -49,12 +49,18 @@ EXPORT_SYMBOL_GPL(kvm_mips_is_error_pfn);
 
 uint32_t kvm_mips_get_kernel_asid(struct kvm_vcpu *vcpu)
 {
-	return vcpu->arch.guest_kernel_asid[smp_processor_id()] & ASID_MASK;
+	int cpu = smp_processor_id();
+
+	return vcpu->arch.guest_kernel_asid[cpu] &
+			cpu_asid_mask(&cpu_data[cpu]);
 }
 
 uint32_t kvm_mips_get_user_asid(struct kvm_vcpu *vcpu)
 {
-	return vcpu->arch.guest_user_asid[smp_processor_id()] & ASID_MASK;
+	int cpu = smp_processor_id();
+
+	return vcpu->arch.guest_user_asid[cpu] &
+			cpu_asid_mask(&cpu_data[cpu]);
 }
 
 inline uint32_t kvm_mips_get_commpage_asid(struct kvm_vcpu *vcpu)
@@ -78,7 +84,8 @@ void kvm_mips_dump_host_tlbs(void)
 	old_pagemask = read_c0_pagemask();
 
 	kvm_info("HOST TLBs:\n");
-	kvm_info("ASID: %#lx\n", read_c0_entryhi() & ASID_MASK);
+	kvm_info("ASID: %#lx\n", read_c0_entryhi() &
+		 cpu_asid_mask(&current_cpu_data));
 
 	for (i = 0; i < current_cpu_data.tlbsize; i++) {
 		write_c0_index(i);
@@ -564,15 +571,15 @@ void kvm_get_new_mmu_context(struct mm_struct *mm, unsigned long cpu,
 {
 	unsigned long asid = asid_cache(cpu);
 
-	asid += ASID_INC;
-	if (!(asid & ASID_MASK)) {
+	asid += cpu_asid_inc();
+	if (!(asid & cpu_asid_mask(&cpu_data[cpu]))) {
 		if (cpu_has_vtag_icache)
 			flush_icache_all();
 
 		kvm_local_flush_tlb_all();      /* start new asid cycle */
 
 		if (!asid)      /* fix version if needed */
-			asid = ASID_FIRST_VERSION;
+			asid = asid_first_version(cpu);
 	}
 
 	cpu_context(cpu, mm) = asid_cache(cpu) = asid;
@@ -627,6 +634,7 @@ static void kvm_mips_migrate_count(struct kvm_vcpu *vcpu)
 /* Restore ASID once we are scheduled back after preemption */
 void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
+	unsigned long asid_mask = cpu_asid_mask(&cpu_data[cpu]);
 	unsigned long flags;
 	int newasid = 0;
 
@@ -637,7 +645,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	local_irq_save(flags);
 
 	if ((vcpu->arch.guest_kernel_asid[cpu] ^ asid_cache(cpu)) &
-							ASID_VERSION_MASK) {
+						asid_version_mask(cpu)) {
 		kvm_get_new_mmu_context(&vcpu->arch.guest_kernel_mm, cpu, vcpu);
 		vcpu->arch.guest_kernel_asid[cpu] =
 		    vcpu->arch.guest_kernel_mm.context.asid[cpu];
@@ -672,7 +680,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 		 */
 		if (current->flags & PF_VCPU) {
 			write_c0_entryhi(vcpu->arch.
-					 preempt_entryhi & ASID_MASK);
+					 preempt_entryhi & asid_mask);
 			ehb();
 		}
 	} else {
@@ -687,11 +695,11 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 			if (KVM_GUEST_KERNEL_MODE(vcpu))
 				write_c0_entryhi(vcpu->arch.
 						 guest_kernel_asid[cpu] &
-						 ASID_MASK);
+						 asid_mask);
 			else
 				write_c0_entryhi(vcpu->arch.
 						 guest_user_asid[cpu] &
-						 ASID_MASK);
+						 asid_mask);
 			ehb();
 		}
 	}
@@ -721,7 +729,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 	kvm_mips_callbacks->vcpu_get_regs(vcpu);
 
 	if (((cpu_context(cpu, current->mm) ^ asid_cache(cpu)) &
-	     ASID_VERSION_MASK)) {
+	     asid_version_mask(cpu))) {
 		kvm_debug("%s: Dropping MMU Context:  %#lx\n", __func__,
 			  cpu_context(cpu, current->mm));
 		drop_mmu_context(current->mm, cpu);
diff --git a/arch/mips/lib/dump_tlb.c b/arch/mips/lib/dump_tlb.c
index 92a37319efbe..3283aa7423e4 100644
--- a/arch/mips/lib/dump_tlb.c
+++ b/arch/mips/lib/dump_tlb.c
@@ -73,6 +73,8 @@ static void dump_tlb(int first, int last)
 	unsigned long s_entryhi, entryhi, asid;
 	unsigned long long entrylo0, entrylo1, pa;
 	unsigned int s_index, s_pagemask, pagemask, c0, c1, i;
+	unsigned long asidmask = cpu_asid_mask(&current_cpu_data);
+	int asidwidth = DIV_ROUND_UP(ilog2(asidmask) + 1, 4);
 #ifdef CONFIG_32BIT
 	bool xpa = cpu_has_xpa && (read_c0_pagegrain() & PG_ELPA);
 	int pwidth = xpa ? 11 : 8;
@@ -86,7 +88,7 @@ static void dump_tlb(int first, int last)
 	s_pagemask = read_c0_pagemask();
 	s_entryhi = read_c0_entryhi();
 	s_index = read_c0_index();
-	asid = s_entryhi & 0xff;
+	asid = s_entryhi & asidmask;
 
 	for (i = first; i <= last; i++) {
 		write_c0_index(i);
@@ -115,7 +117,7 @@ static void dump_tlb(int first, int last)
 		 * due to duplicate TLB entry.
 		 */
 		if (!((entrylo0 | entrylo1) & ENTRYLO_G) &&
-		    (entryhi & 0xff) != asid)
+		    (entryhi & asidmask) != asid)
 			continue;
 
 		/*
@@ -126,9 +128,9 @@ static void dump_tlb(int first, int last)
 		c0 = (entrylo0 & ENTRYLO_C) >> ENTRYLO_C_SHIFT;
 		c1 = (entrylo1 & ENTRYLO_C) >> ENTRYLO_C_SHIFT;
 
-		printk("va=%0*lx asid=%02lx\n",
+		printk("va=%0*lx asid=%0*lx\n",
 		       vwidth, (entryhi & ~0x1fffUL),
-		       entryhi & 0xff);
+		       asidwidth, entryhi & asidmask);
 		/* RI/XI are in awkward places, so mask them off separately */
 		pa = entrylo0 & ~(MIPS_ENTRYLO_RI | MIPS_ENTRYLO_XI);
 		if (xpa)
diff --git a/arch/mips/lib/r3k_dump_tlb.c b/arch/mips/lib/r3k_dump_tlb.c
index cfcbb5218b59..744f4a7bc49d 100644
--- a/arch/mips/lib/r3k_dump_tlb.c
+++ b/arch/mips/lib/r3k_dump_tlb.c
@@ -29,9 +29,10 @@ static void dump_tlb(int first, int last)
 {
 	int	i;
 	unsigned int asid;
-	unsigned long entryhi, entrylo0;
+	unsigned long entryhi, entrylo0, asid_mask;
 
-	asid = read_c0_entryhi() & ASID_MASK;
+	asid_mask = cpu_asid_mask(&current_cpu_data);
+	asid = read_c0_entryhi() & asid_mask;
 
 	for (i = first; i <= last; i++) {
 		write_c0_index(i<<8);
@@ -46,7 +47,7 @@ static void dump_tlb(int first, int last)
 		/* Unused entries have a virtual address of KSEG0.  */
 		if ((entryhi & PAGE_MASK) != KSEG0 &&
 		    (entrylo0 & R3K_ENTRYLO_G ||
-		     (entryhi & ASID_MASK) == asid)) {
+		     (entryhi & asid_mask) == asid)) {
 			/*
 			 * Only print entries in use
 			 */
@@ -55,7 +56,7 @@ static void dump_tlb(int first, int last)
 			printk("va=%08lx asid=%08lx"
 			       "  [pa=%06lx n=%d d=%d v=%d g=%d]",
 			       entryhi & PAGE_MASK,
-			       entryhi & ASID_MASK,
+			       entryhi & asid_mask,
 			       entrylo0 & PAGE_MASK,
 			       (entrylo0 & R3K_ENTRYLO_N) ? 1 : 0,
 			       (entrylo0 & R3K_ENTRYLO_D) ? 1 : 0,
diff --git a/arch/mips/mm/tlb-r3k.c b/arch/mips/mm/tlb-r3k.c
index b4f366f7c0f5..1290b995695d 100644
--- a/arch/mips/mm/tlb-r3k.c
+++ b/arch/mips/mm/tlb-r3k.c
@@ -43,7 +43,7 @@ static void local_flush_tlb_from(int entry)
 {
 	unsigned long old_ctx;
 
-	old_ctx = read_c0_entryhi() & ASID_MASK;
+	old_ctx = read_c0_entryhi() & cpu_asid_mask(&current_cpu_data);
 	write_c0_entrylo0(0);
 	while (entry < current_cpu_data.tlbsize) {
 		write_c0_index(entry << 8);
@@ -81,6 +81,7 @@ void local_flush_tlb_mm(struct mm_struct *mm)
 void local_flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 			   unsigned long end)
 {
+	unsigned long asid_mask = cpu_asid_mask(&current_cpu_data);
 	struct mm_struct *mm = vma->vm_mm;
 	int cpu = smp_processor_id();
 
@@ -89,13 +90,13 @@ void local_flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 
 #ifdef DEBUG_TLB
 		printk("[tlbrange<%lu,0x%08lx,0x%08lx>]",
-			cpu_context(cpu, mm) & ASID_MASK, start, end);
+			cpu_context(cpu, mm) & asid_mask, start, end);
 #endif
 		local_irq_save(flags);
 		size = (end - start + (PAGE_SIZE - 1)) >> PAGE_SHIFT;
 		if (size <= current_cpu_data.tlbsize) {
-			int oldpid = read_c0_entryhi() & ASID_MASK;
-			int newpid = cpu_context(cpu, mm) & ASID_MASK;
+			int oldpid = read_c0_entryhi() & asid_mask;
+			int newpid = cpu_context(cpu, mm) & asid_mask;
 
 			start &= PAGE_MASK;
 			end += PAGE_SIZE - 1;
@@ -159,6 +160,7 @@ void local_flush_tlb_kernel_range(unsigned long start, unsigned long end)
 
 void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
 {
+	unsigned long asid_mask = cpu_asid_mask(&current_cpu_data);
 	int cpu = smp_processor_id();
 
 	if (cpu_context(cpu, vma->vm_mm) != 0) {
@@ -168,10 +170,10 @@ void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
 #ifdef DEBUG_TLB
 		printk("[tlbpage<%lu,0x%08lx>]", cpu_context(cpu, vma->vm_mm), page);
 #endif
-		newpid = cpu_context(cpu, vma->vm_mm) & ASID_MASK;
+		newpid = cpu_context(cpu, vma->vm_mm) & asid_mask;
 		page &= PAGE_MASK;
 		local_irq_save(flags);
-		oldpid = read_c0_entryhi() & ASID_MASK;
+		oldpid = read_c0_entryhi() & asid_mask;
 		write_c0_entryhi(page | newpid);
 		BARRIER;
 		tlb_probe();
@@ -190,6 +192,7 @@ finish:
 
 void __update_tlb(struct vm_area_struct *vma, unsigned long address, pte_t pte)
 {
+	unsigned long asid_mask = cpu_asid_mask(&current_cpu_data);
 	unsigned long flags;
 	int idx, pid;
 
@@ -199,10 +202,10 @@ void __update_tlb(struct vm_area_struct *vma, unsigned long address, pte_t pte)
 	if (current->active_mm != vma->vm_mm)
 		return;
 
-	pid = read_c0_entryhi() & ASID_MASK;
+	pid = read_c0_entryhi() & asid_mask;
 
 #ifdef DEBUG_TLB
-	if ((pid != (cpu_context(cpu, vma->vm_mm) & ASID_MASK)) || (cpu_context(cpu, vma->vm_mm) == 0)) {
+	if ((pid != (cpu_context(cpu, vma->vm_mm) & asid_mask)) || (cpu_context(cpu, vma->vm_mm) == 0)) {
 		printk("update_mmu_cache: Wheee, bogus tlbpid mmpid=%lu tlbpid=%d\n",
 		       (cpu_context(cpu, vma->vm_mm)), pid);
 	}
@@ -228,6 +231,7 @@ void __update_tlb(struct vm_area_struct *vma, unsigned long address, pte_t pte)
 void add_wired_entry(unsigned long entrylo0, unsigned long entrylo1,
 		     unsigned long entryhi, unsigned long pagemask)
 {
+	unsigned long asid_mask = cpu_asid_mask(&current_cpu_data);
 	unsigned long flags;
 	unsigned long old_ctx;
 	static unsigned long wired = 0;
@@ -243,7 +247,7 @@ void add_wired_entry(unsigned long entrylo0, unsigned long entrylo1,
 
 		local_irq_save(flags);
 		/* Save old context and create impossible VPN2 value */
-		old_ctx = read_c0_entryhi() & ASID_MASK;
+		old_ctx = read_c0_entryhi() & asid_mask;
 		old_pagemask = read_c0_pagemask();
 		w = read_c0_wired();
 		write_c0_wired(w + 1);
@@ -266,7 +270,7 @@ void add_wired_entry(unsigned long entrylo0, unsigned long entrylo1,
 #endif
 
 		local_irq_save(flags);
-		old_ctx = read_c0_entryhi() & ASID_MASK;
+		old_ctx = read_c0_entryhi() & asid_mask;
 		write_c0_entrylo0(entrylo0);
 		write_c0_entryhi(entryhi);
 		write_c0_index(wired);
diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index c17d7627f872..0063daa8b679 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -301,7 +301,7 @@ void __update_tlb(struct vm_area_struct * vma, unsigned long address, pte_t pte)
 	local_irq_save(flags);
 
 	htw_stop();
-	pid = read_c0_entryhi() & ASID_MASK;
+	pid = read_c0_entryhi() & cpu_asid_mask(&current_cpu_data);
 	address &= (PAGE_MASK << 1);
 	write_c0_entryhi(address | pid);
 	pgdp = pgd_offset(vma->vm_mm, address);
diff --git a/arch/mips/mm/tlb-r8k.c b/arch/mips/mm/tlb-r8k.c
index 138a2ec7cc6b..e86e2e55ad3e 100644
--- a/arch/mips/mm/tlb-r8k.c
+++ b/arch/mips/mm/tlb-r8k.c
@@ -194,7 +194,7 @@ void __update_tlb(struct vm_area_struct * vma, unsigned long address, pte_t pte)
 	if (current->active_mm != vma->vm_mm)
 		return;
 
-	pid = read_c0_entryhi() & ASID_MASK;
+	pid = read_c0_entryhi() & cpu_asid_mask(&current_cpu_data);
 
 	local_irq_save(flags);
 	address &= PAGE_MASK;
-- 
2.4.10
