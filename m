Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Feb 2017 13:12:54 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:41033 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993926AbdBBMFJ6qkyv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Feb 2017 13:05:09 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 3A04F73C19945;
        Thu,  2 Feb 2017 12:05:05 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 2 Feb 2017 12:05:08 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH v2 20/30] KVM: MIPS/MMU: Invalidate GVA PTs on ASID changes
Date:   Thu, 2 Feb 2017 12:04:33 +0000
Message-ID: <cf22921d89f14ef03aea28495918eac40bc411ab.1486036366.git-series.james.hogan@imgtec.com>
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
X-archive-position: 56606
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

Implement invalidation of large ranges of virtual addresses from GVA
page tables in response to a guest ASID change (immediately for guest
kernel page table, lazily for guest user page table).

We iterate through a range of page tables invalidating entries and
freeing fully invalidated tables. To minimise overhead the exact ranges
invalidated depends on the flags argument to kvm_mips_flush_gva_pt(),
which also allows it to be used in future KVM_CAP_SYNC_MMU patches in
response to GPA changes, which unlike guest TLB mapping changes affects
guest KSeg0 mappings.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h |  17 ++++-
 arch/mips/kvm/emulate.c          |  11 +++-
 arch/mips/kvm/mmu.c              | 134 ++++++++++++++++++++++++++++++++-
 arch/mips/kvm/trap_emul.c        |   5 +-
 4 files changed, 165 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index fb2ea578c193..f5145dcab319 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -614,6 +614,23 @@ extern int kvm_mips_host_tlb_lookup(struct kvm_vcpu *vcpu, unsigned long vaddr);
 void kvm_mips_suspend_mm(int cpu);
 void kvm_mips_resume_mm(int cpu);
 
+/* MMU handling */
+
+/**
+ * enum kvm_mips_flush - Types of MMU flushes.
+ * @KMF_USER:	Flush guest user virtual memory mappings.
+ *		Guest USeg only.
+ * @KMF_KERN:	Flush guest kernel virtual memory mappings.
+ *		Guest USeg and KSeg2/3.
+ * @KMF_GPA:	Flush guest physical memory mappings.
+ *		Also includes KSeg0 if KMF_KERN is set.
+ */
+enum kvm_mips_flush {
+	KMF_USER	= 0x0,
+	KMF_KERN	= 0x1,
+	KMF_GPA		= 0x2,
+};
+void kvm_mips_flush_gva_pt(pgd_t *pgd, enum kvm_mips_flush flags);
 extern unsigned long kvm_mips_translate_guest_kseg0_to_hpa(struct kvm_vcpu *vcpu,
 						   unsigned long gva);
 extern void kvm_get_new_mmu_context(struct mm_struct *mm, unsigned long cpu,
diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index 611b8996ca0c..1d399396e486 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -1172,6 +1172,17 @@ enum emulation_result kvm_mips_emulate_CP0(union mips_instruction inst,
 						nasid);
 
 					/*
+					 * Flush entries from the GVA page
+					 * tables.
+					 * Guest user page table will get
+					 * flushed lazily on re-entry to guest
+					 * user if the guest ASID actually
+					 * changes.
+					 */
+					kvm_mips_flush_gva_pt(kern_mm->pgd,
+							      KMF_KERN);
+
+					/*
 					 * Regenerate/invalidate kernel MMU
 					 * context.
 					 * The user MMU context will be
diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index 27d6d0dbfeb4..09146b62552f 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -12,6 +12,7 @@
 #include <linux/highmem.h>
 #include <linux/kvm_host.h>
 #include <asm/mmu_context.h>
+#include <asm/pgalloc.h>
 
 static u32 kvm_mips_get_kernel_asid(struct kvm_vcpu *vcpu)
 {
@@ -80,6 +81,139 @@ unsigned long kvm_mips_translate_guest_kseg0_to_hpa(struct kvm_vcpu *vcpu,
 	return (kvm->arch.guest_pmap[gfn] << PAGE_SHIFT) + offset;
 }
 
+/*
+ * kvm_mips_flush_gva_{pte,pmd,pud,pgd,pt}.
+ * Flush a range of guest physical address space from the VM's GPA page tables.
+ */
+
+static bool kvm_mips_flush_gva_pte(pte_t *pte, unsigned long start_gva,
+				   unsigned long end_gva)
+{
+	int i_min = __pte_offset(start_gva);
+	int i_max = __pte_offset(end_gva);
+	bool safe_to_remove = (i_min == 0 && i_max == PTRS_PER_PTE - 1);
+	int i;
+
+	/*
+	 * There's no freeing to do, so there's no point clearing individual
+	 * entries unless only part of the last level page table needs flushing.
+	 */
+	if (safe_to_remove)
+		return true;
+
+	for (i = i_min; i <= i_max; ++i) {
+		if (!pte_present(pte[i]))
+			continue;
+
+		set_pte(pte + i, __pte(0));
+	}
+	return false;
+}
+
+static bool kvm_mips_flush_gva_pmd(pmd_t *pmd, unsigned long start_gva,
+				   unsigned long end_gva)
+{
+	pte_t *pte;
+	unsigned long end = ~0ul;
+	int i_min = __pmd_offset(start_gva);
+	int i_max = __pmd_offset(end_gva);
+	bool safe_to_remove = (i_min == 0 && i_max == PTRS_PER_PMD - 1);
+	int i;
+
+	for (i = i_min; i <= i_max; ++i, start_gva = 0) {
+		if (!pmd_present(pmd[i]))
+			continue;
+
+		pte = pte_offset(pmd + i, 0);
+		if (i == i_max)
+			end = end_gva;
+
+		if (kvm_mips_flush_gva_pte(pte, start_gva, end)) {
+			pmd_clear(pmd + i);
+			pte_free_kernel(NULL, pte);
+		} else {
+			safe_to_remove = false;
+		}
+	}
+	return safe_to_remove;
+}
+
+static bool kvm_mips_flush_gva_pud(pud_t *pud, unsigned long start_gva,
+				   unsigned long end_gva)
+{
+	pmd_t *pmd;
+	unsigned long end = ~0ul;
+	int i_min = __pud_offset(start_gva);
+	int i_max = __pud_offset(end_gva);
+	bool safe_to_remove = (i_min == 0 && i_max == PTRS_PER_PUD - 1);
+	int i;
+
+	for (i = i_min; i <= i_max; ++i, start_gva = 0) {
+		if (!pud_present(pud[i]))
+			continue;
+
+		pmd = pmd_offset(pud + i, 0);
+		if (i == i_max)
+			end = end_gva;
+
+		if (kvm_mips_flush_gva_pmd(pmd, start_gva, end)) {
+			pud_clear(pud + i);
+			pmd_free(NULL, pmd);
+		} else {
+			safe_to_remove = false;
+		}
+	}
+	return safe_to_remove;
+}
+
+static bool kvm_mips_flush_gva_pgd(pgd_t *pgd, unsigned long start_gva,
+				   unsigned long end_gva)
+{
+	pud_t *pud;
+	unsigned long end = ~0ul;
+	int i_min = pgd_index(start_gva);
+	int i_max = pgd_index(end_gva);
+	bool safe_to_remove = (i_min == 0 && i_max == PTRS_PER_PGD - 1);
+	int i;
+
+	for (i = i_min; i <= i_max; ++i, start_gva = 0) {
+		if (!pgd_present(pgd[i]))
+			continue;
+
+		pud = pud_offset(pgd + i, 0);
+		if (i == i_max)
+			end = end_gva;
+
+		if (kvm_mips_flush_gva_pud(pud, start_gva, end)) {
+			pgd_clear(pgd + i);
+			pud_free(NULL, pud);
+		} else {
+			safe_to_remove = false;
+		}
+	}
+	return safe_to_remove;
+}
+
+void kvm_mips_flush_gva_pt(pgd_t *pgd, enum kvm_mips_flush flags)
+{
+	if (flags & KMF_GPA) {
+		/* all of guest virtual address space could be affected */
+		if (flags & KMF_KERN)
+			/* useg, kseg0, seg2/3 */
+			kvm_mips_flush_gva_pgd(pgd, 0, 0x7fffffff);
+		else
+			/* useg */
+			kvm_mips_flush_gva_pgd(pgd, 0, 0x3fffffff);
+	} else {
+		/* useg */
+		kvm_mips_flush_gva_pgd(pgd, 0, 0x3fffffff);
+
+		/* kseg2/3 */
+		if (flags & KMF_KERN)
+			kvm_mips_flush_gva_pgd(pgd, 0x60000000, 0x7fffffff);
+	}
+}
+
 /* XXXKYMA: Must be called with interrupts disabled */
 int kvm_mips_handle_kseg0_tlb_fault(unsigned long badvaddr,
 				    struct kvm_vcpu *vcpu)
diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index f39d427649dc..6a56e48f4bfa 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -774,14 +774,15 @@ static void kvm_trap_emul_vcpu_reenter(struct kvm_run *run,
 	unsigned int gasid;
 
 	/*
-	 * Lazy host ASID regeneration for guest user mode.
+	 * Lazy host ASID regeneration / PT flush for guest user mode.
 	 * If the guest ASID has changed since the last guest usermode
 	 * execution, regenerate the host ASID so as to invalidate stale TLB
-	 * entries.
+	 * entries and flush GVA PT entries too.
 	 */
 	if (!KVM_GUEST_KERNEL_MODE(vcpu)) {
 		gasid = kvm_read_c0_guest_entryhi(cop0) & KVM_ENTRYHI_ASID;
 		if (gasid != vcpu->arch.last_user_gasid) {
+			kvm_mips_flush_gva_pt(user_mm->pgd, KMF_USER);
 			kvm_get_new_mmu_context(user_mm, cpu, vcpu);
 			for_each_possible_cpu(i)
 				if (i != cpu)
-- 
git-series 0.8.10
