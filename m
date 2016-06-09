Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 15:22:39 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:40490 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27041087AbcFINTokn0yi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jun 2016 15:19:44 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 4B4A6EE0D79E7;
        Thu,  9 Jun 2016 14:19:34 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 9 Jun 2016 14:19:37 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     James Hogan <james.hogan@imgtec.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 07/18] MIPS: KVM: Move non-TLB handling code out of tlb.c
Date:   Thu, 9 Jun 2016 14:19:10 +0100
Message-ID: <1465478361-7431-8-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1465478361-7431-1-git-send-email-james.hogan@imgtec.com>
References: <1465478361-7431-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53923
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

Various functions in tlb.c perform higher level MMU handling, but don't
strictly need to be statically built into the kernel as they don't
directly manipulate TLB entries. Move these functions out into a
separate mmu.c which will be built into the KVM kernel module. This
allows them to directly reference KVM functions in the KVM kernel module
in future.

Module exports of these functions have been removed, since they aren't
needed outside of KVM.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h |   4 +
 arch/mips/kvm/Makefile           |   1 +
 arch/mips/kvm/mmu.c              | 380 +++++++++++++++++++++++++++++++++++++++
 arch/mips/kvm/tlb.c              | 364 +------------------------------------
 4 files changed, 389 insertions(+), 360 deletions(-)
 create mode 100644 arch/mips/kvm/mmu.c

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index dceb49422e3b..f64be7987a32 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -649,6 +649,10 @@ extern enum emulation_result kvm_mips_handle_tlbmod(u32 cause,
 
 extern void kvm_mips_dump_host_tlbs(void);
 extern void kvm_mips_dump_guest_tlbs(struct kvm_vcpu *vcpu);
+extern int kvm_mips_host_tlb_write(struct kvm_vcpu *vcpu, unsigned long entryhi,
+				   unsigned long entrylo0,
+				   unsigned long entrylo1,
+				   int flush_dcache_mask);
 extern void kvm_mips_flush_host_tlb(int skip_kseg0);
 extern int kvm_mips_host_tlb_inv(struct kvm_vcpu *vcpu, unsigned long entryhi);
 
diff --git a/arch/mips/kvm/Makefile b/arch/mips/kvm/Makefile
index 637ebbebd549..0aabe40fcac9 100644
--- a/arch/mips/kvm/Makefile
+++ b/arch/mips/kvm/Makefile
@@ -10,6 +10,7 @@ common-objs-$(CONFIG_CPU_HAS_MSA) += msa.o
 kvm-objs := $(common-objs-y) mips.o emulate.o locore.o \
 	    interrupt.o stats.o commpage.o \
 	    dyntrans.o trap_emul.o fpu.o
+kvm-objs += mmu.o
 
 obj-$(CONFIG_KVM)	+= kvm.o
 obj-y			+= callback.o tlb.o
diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
new file mode 100644
index 000000000000..d18cadfd6e01
--- /dev/null
+++ b/arch/mips/kvm/mmu.c
@@ -0,0 +1,380 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * KVM/MIPS MMU handling in the KVM module.
+ *
+ * Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
+ * Authors: Sanjay Lal <sanjayl@kymasys.com>
+ */
+
+#include <linux/kvm_host.h>
+#include <asm/mmu_context.h>
+
+static u32 kvm_mips_get_kernel_asid(struct kvm_vcpu *vcpu)
+{
+	int cpu = smp_processor_id();
+
+	return vcpu->arch.guest_kernel_asid[cpu] &
+			cpu_asid_mask(&cpu_data[cpu]);
+}
+
+static u32 kvm_mips_get_user_asid(struct kvm_vcpu *vcpu)
+{
+	int cpu = smp_processor_id();
+
+	return vcpu->arch.guest_user_asid[cpu] &
+			cpu_asid_mask(&cpu_data[cpu]);
+}
+
+static int kvm_mips_map_page(struct kvm *kvm, gfn_t gfn)
+{
+	int srcu_idx, err = 0;
+	kvm_pfn_t pfn;
+
+	if (kvm->arch.guest_pmap[gfn] != KVM_INVALID_PAGE)
+		return 0;
+
+	srcu_idx = srcu_read_lock(&kvm->srcu);
+	pfn = kvm_mips_gfn_to_pfn(kvm, gfn);
+
+	if (kvm_mips_is_error_pfn(pfn)) {
+		kvm_err("Couldn't get pfn for gfn %#llx!\n", gfn);
+		err = -EFAULT;
+		goto out;
+	}
+
+	kvm->arch.guest_pmap[gfn] = pfn;
+out:
+	srcu_read_unlock(&kvm->srcu, srcu_idx);
+	return err;
+}
+
+/* Translate guest KSEG0 addresses to Host PA */
+unsigned long kvm_mips_translate_guest_kseg0_to_hpa(struct kvm_vcpu *vcpu,
+						    unsigned long gva)
+{
+	gfn_t gfn;
+	unsigned long offset = gva & ~PAGE_MASK;
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
+
+	if (kvm_mips_map_page(vcpu->kvm, gfn) < 0)
+		return KVM_INVALID_ADDR;
+
+	return (kvm->arch.guest_pmap[gfn] << PAGE_SHIFT) + offset;
+}
+
+/* XXXKYMA: Must be called with interrupts disabled */
+int kvm_mips_handle_kseg0_tlb_fault(unsigned long badvaddr,
+				    struct kvm_vcpu *vcpu)
+{
+	gfn_t gfn;
+	kvm_pfn_t pfn0, pfn1;
+	unsigned long vaddr = 0;
+	unsigned long entryhi = 0, entrylo0 = 0, entrylo1 = 0;
+	int even;
+	struct kvm *kvm = vcpu->kvm;
+	const int flush_dcache_mask = 0;
+	int ret;
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
+	entrylo0 = mips3_paddr_to_tlbpfn(pfn0 << PAGE_SHIFT) | (0x3 << 3) |
+		   (1 << 2) | (0x1 << 1);
+	entrylo1 = mips3_paddr_to_tlbpfn(pfn1 << PAGE_SHIFT) | (0x3 << 3) |
+		   (1 << 2) | (0x1 << 1);
+
+	preempt_disable();
+	entryhi = (vaddr | kvm_mips_get_kernel_asid(vcpu));
+	ret = kvm_mips_host_tlb_write(vcpu, entryhi, entrylo0, entrylo1,
+				      flush_dcache_mask);
+	preempt_enable();
+
+	return ret;
+}
+
+int kvm_mips_handle_mapped_seg_tlb_fault(struct kvm_vcpu *vcpu,
+					 struct kvm_mips_tlb *tlb,
+					 unsigned long *hpa0,
+					 unsigned long *hpa1)
+{
+	unsigned long entryhi = 0, entrylo0 = 0, entrylo1 = 0;
+	struct kvm *kvm = vcpu->kvm;
+	kvm_pfn_t pfn0, pfn1;
+	int ret;
+
+	if ((tlb->tlb_hi & VPN2_MASK) == 0) {
+		pfn0 = 0;
+		pfn1 = 0;
+	} else {
+		if (kvm_mips_map_page(kvm, mips3_tlbpfn_to_paddr(tlb->tlb_lo0)
+					   >> PAGE_SHIFT) < 0)
+			return -1;
+
+		if (kvm_mips_map_page(kvm, mips3_tlbpfn_to_paddr(tlb->tlb_lo1)
+					   >> PAGE_SHIFT) < 0)
+			return -1;
+
+		pfn0 = kvm->arch.guest_pmap[mips3_tlbpfn_to_paddr(tlb->tlb_lo0)
+					    >> PAGE_SHIFT];
+		pfn1 = kvm->arch.guest_pmap[mips3_tlbpfn_to_paddr(tlb->tlb_lo1)
+					    >> PAGE_SHIFT];
+	}
+
+	if (hpa0)
+		*hpa0 = pfn0 << PAGE_SHIFT;
+
+	if (hpa1)
+		*hpa1 = pfn1 << PAGE_SHIFT;
+
+	/* Get attributes from the Guest TLB */
+	entrylo0 = mips3_paddr_to_tlbpfn(pfn0 << PAGE_SHIFT) | (0x3 << 3) |
+		   (tlb->tlb_lo0 & MIPS3_PG_D) | (tlb->tlb_lo0 & MIPS3_PG_V);
+	entrylo1 = mips3_paddr_to_tlbpfn(pfn1 << PAGE_SHIFT) | (0x3 << 3) |
+		   (tlb->tlb_lo1 & MIPS3_PG_D) | (tlb->tlb_lo1 & MIPS3_PG_V);
+
+	kvm_debug("@ %#lx tlb_lo0: 0x%08lx tlb_lo1: 0x%08lx\n", vcpu->arch.pc,
+		  tlb->tlb_lo0, tlb->tlb_lo1);
+
+	preempt_disable();
+	entryhi = (tlb->tlb_hi & VPN2_MASK) | (KVM_GUEST_KERNEL_MODE(vcpu) ?
+					       kvm_mips_get_kernel_asid(vcpu) :
+					       kvm_mips_get_user_asid(vcpu));
+	ret = kvm_mips_host_tlb_write(vcpu, entryhi, entrylo0, entrylo1,
+				      tlb->tlb_mask);
+	preempt_enable();
+
+	return ret;
+}
+
+void kvm_get_new_mmu_context(struct mm_struct *mm, unsigned long cpu,
+			     struct kvm_vcpu *vcpu)
+{
+	unsigned long asid = asid_cache(cpu);
+
+	asid += cpu_asid_inc();
+	if (!(asid & cpu_asid_mask(&cpu_data[cpu]))) {
+		if (cpu_has_vtag_icache)
+			flush_icache_all();
+
+		kvm_local_flush_tlb_all();      /* start new asid cycle */
+
+		if (!asid)      /* fix version if needed */
+			asid = asid_first_version(cpu);
+	}
+
+	cpu_context(cpu, mm) = asid_cache(cpu) = asid;
+}
+
+/**
+ * kvm_mips_migrate_count() - Migrate timer.
+ * @vcpu:	Virtual CPU.
+ *
+ * Migrate CP0_Count hrtimer to the current CPU by cancelling and restarting it
+ * if it was running prior to being cancelled.
+ *
+ * Must be called when the VCPU is migrated to a different CPU to ensure that
+ * timer expiry during guest execution interrupts the guest and causes the
+ * interrupt to be delivered in a timely manner.
+ */
+static void kvm_mips_migrate_count(struct kvm_vcpu *vcpu)
+{
+	if (hrtimer_cancel(&vcpu->arch.comparecount_timer))
+		hrtimer_restart(&vcpu->arch.comparecount_timer);
+}
+
+/* Restore ASID once we are scheduled back after preemption */
+void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
+{
+	unsigned long asid_mask = cpu_asid_mask(&cpu_data[cpu]);
+	unsigned long flags;
+	int newasid = 0;
+
+	kvm_debug("%s: vcpu %p, cpu: %d\n", __func__, vcpu, cpu);
+
+	/* Allocate new kernel and user ASIDs if needed */
+
+	local_irq_save(flags);
+
+	if ((vcpu->arch.guest_kernel_asid[cpu] ^ asid_cache(cpu)) &
+						asid_version_mask(cpu)) {
+		kvm_get_new_mmu_context(&vcpu->arch.guest_kernel_mm, cpu, vcpu);
+		vcpu->arch.guest_kernel_asid[cpu] =
+		    vcpu->arch.guest_kernel_mm.context.asid[cpu];
+		kvm_get_new_mmu_context(&vcpu->arch.guest_user_mm, cpu, vcpu);
+		vcpu->arch.guest_user_asid[cpu] =
+		    vcpu->arch.guest_user_mm.context.asid[cpu];
+		newasid++;
+
+		kvm_debug("[%d]: cpu_context: %#lx\n", cpu,
+			  cpu_context(cpu, current->mm));
+		kvm_debug("[%d]: Allocated new ASID for Guest Kernel: %#x\n",
+			  cpu, vcpu->arch.guest_kernel_asid[cpu]);
+		kvm_debug("[%d]: Allocated new ASID for Guest User: %#x\n", cpu,
+			  vcpu->arch.guest_user_asid[cpu]);
+	}
+
+	if (vcpu->arch.last_sched_cpu != cpu) {
+		kvm_debug("[%d->%d]KVM VCPU[%d] switch\n",
+			  vcpu->arch.last_sched_cpu, cpu, vcpu->vcpu_id);
+		/*
+		 * Migrate the timer interrupt to the current CPU so that it
+		 * always interrupts the guest and synchronously triggers a
+		 * guest timer interrupt.
+		 */
+		kvm_mips_migrate_count(vcpu);
+	}
+
+	if (!newasid) {
+		/*
+		 * If we preempted while the guest was executing, then reload
+		 * the pre-empted ASID
+		 */
+		if (current->flags & PF_VCPU) {
+			write_c0_entryhi(vcpu->arch.
+					 preempt_entryhi & asid_mask);
+			ehb();
+		}
+	} else {
+		/* New ASIDs were allocated for the VM */
+
+		/*
+		 * Were we in guest context? If so then the pre-empted ASID is
+		 * no longer valid, we need to set it to what it should be based
+		 * on the mode of the Guest (Kernel/User)
+		 */
+		if (current->flags & PF_VCPU) {
+			if (KVM_GUEST_KERNEL_MODE(vcpu))
+				write_c0_entryhi(vcpu->arch.
+						 guest_kernel_asid[cpu] &
+						 asid_mask);
+			else
+				write_c0_entryhi(vcpu->arch.
+						 guest_user_asid[cpu] &
+						 asid_mask);
+			ehb();
+		}
+	}
+
+	/* restore guest state to registers */
+	kvm_mips_callbacks->vcpu_set_regs(vcpu);
+
+	local_irq_restore(flags);
+
+}
+
+/* ASID can change if another task is scheduled during preemption */
+void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
+{
+	unsigned long flags;
+	int cpu;
+
+	local_irq_save(flags);
+
+	cpu = smp_processor_id();
+
+	vcpu->arch.preempt_entryhi = read_c0_entryhi();
+	vcpu->arch.last_sched_cpu = cpu;
+
+	/* save guest state in registers */
+	kvm_mips_callbacks->vcpu_get_regs(vcpu);
+
+	if (((cpu_context(cpu, current->mm) ^ asid_cache(cpu)) &
+	     asid_version_mask(cpu))) {
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
+u32 kvm_get_inst(u32 *opc, struct kvm_vcpu *vcpu)
+{
+	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	unsigned long paddr, flags, vpn2, asid;
+	u32 inst;
+	int index;
+
+	if (KVM_GUEST_KSEGX((unsigned long) opc) < KVM_GUEST_KSEG0 ||
+	    KVM_GUEST_KSEGX((unsigned long) opc) == KVM_GUEST_KSEG23) {
+		local_irq_save(flags);
+		index = kvm_mips_host_tlb_lookup(vcpu, (unsigned long) opc);
+		if (index >= 0) {
+			inst = *(opc);
+		} else {
+			vpn2 = (unsigned long) opc & VPN2_MASK;
+			asid = kvm_read_c0_guest_entryhi(cop0) &
+						KVM_ENTRYHI_ASID;
+			index = kvm_mips_guest_tlb_lookup(vcpu, vpn2 | asid);
+			if (index < 0) {
+				kvm_err("%s: get_user_failed for %p, vcpu: %p, ASID: %#lx\n",
+					__func__, opc, vcpu, read_c0_entryhi());
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
+		    kvm_mips_translate_guest_kseg0_to_hpa(vcpu,
+							  (unsigned long) opc);
+		inst = *(u32 *) CKSEG0ADDR(paddr);
+	} else {
+		kvm_err("%s: illegal address: %p\n", __func__, opc);
+		return KVM_INVALID_INST;
+	}
+
+	return inst;
+}
diff --git a/arch/mips/kvm/tlb.c b/arch/mips/kvm/tlb.c
index c4e11e138042..373817c3166b 100644
--- a/arch/mips/kvm/tlb.c
+++ b/arch/mips/kvm/tlb.c
@@ -14,7 +14,7 @@
 #include <linux/smp.h>
 #include <linux/mm.h>
 #include <linux/delay.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/kvm_host.h>
 #include <linux/srcu.h>
 
@@ -45,7 +45,7 @@ EXPORT_SYMBOL_GPL(kvm_mips_release_pfn_clean);
 bool (*kvm_mips_is_error_pfn)(kvm_pfn_t pfn);
 EXPORT_SYMBOL_GPL(kvm_mips_is_error_pfn);
 
-u32 kvm_mips_get_kernel_asid(struct kvm_vcpu *vcpu)
+static u32 kvm_mips_get_kernel_asid(struct kvm_vcpu *vcpu)
 {
 	int cpu = smp_processor_id();
 
@@ -53,7 +53,7 @@ u32 kvm_mips_get_kernel_asid(struct kvm_vcpu *vcpu)
 			cpu_asid_mask(&cpu_data[cpu]);
 }
 
-u32 kvm_mips_get_user_asid(struct kvm_vcpu *vcpu)
+static u32 kvm_mips_get_user_asid(struct kvm_vcpu *vcpu)
 {
 	int cpu = smp_processor_id();
 
@@ -146,58 +146,6 @@ void kvm_mips_dump_guest_tlbs(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_GPL(kvm_mips_dump_guest_tlbs);
 
-static int kvm_mips_map_page(struct kvm *kvm, gfn_t gfn)
-{
-	int srcu_idx, err = 0;
-	kvm_pfn_t pfn;
-
-	if (kvm->arch.guest_pmap[gfn] != KVM_INVALID_PAGE)
-		return 0;
-
-	srcu_idx = srcu_read_lock(&kvm->srcu);
-	pfn = kvm_mips_gfn_to_pfn(kvm, gfn);
-
-	if (kvm_mips_is_error_pfn(pfn)) {
-		kvm_err("Couldn't get pfn for gfn %#llx!\n", gfn);
-		err = -EFAULT;
-		goto out;
-	}
-
-	kvm->arch.guest_pmap[gfn] = pfn;
-out:
-	srcu_read_unlock(&kvm->srcu, srcu_idx);
-	return err;
-}
-
-/* Translate guest KSEG0 addresses to Host PA */
-unsigned long kvm_mips_translate_guest_kseg0_to_hpa(struct kvm_vcpu *vcpu,
-						    unsigned long gva)
-{
-	gfn_t gfn;
-	unsigned long offset = gva & ~PAGE_MASK;
-	struct kvm *kvm = vcpu->kvm;
-
-	if (KVM_GUEST_KSEGX(gva) != KVM_GUEST_KSEG0) {
-		kvm_err("%s/%p: Invalid gva: %#lx\n", __func__,
-			__builtin_return_address(0), gva);
-		return KVM_INVALID_PAGE;
-	}
-
-	gfn = (KVM_GUEST_CPHYSADDR(gva) >> PAGE_SHIFT);
-
-	if (gfn >= kvm->arch.guest_pmap_npages) {
-		kvm_err("%s: Invalid gfn: %#llx, GVA: %#lx\n", __func__, gfn,
-			gva);
-		return KVM_INVALID_PAGE;
-	}
-
-	if (kvm_mips_map_page(vcpu->kvm, gfn) < 0)
-		return KVM_INVALID_ADDR;
-
-	return (kvm->arch.guest_pmap[gfn] << PAGE_SHIFT) + offset;
-}
-EXPORT_SYMBOL_GPL(kvm_mips_translate_guest_kseg0_to_hpa);
-
 /* XXXKYMA: Must be called with interrupts disabled */
 /* set flush_dcache_mask == 0 if no dcache flush required */
 int kvm_mips_host_tlb_write(struct kvm_vcpu *vcpu, unsigned long entryhi,
@@ -261,64 +209,7 @@ int kvm_mips_host_tlb_write(struct kvm_vcpu *vcpu, unsigned long entryhi,
 	local_irq_restore(flags);
 	return 0;
 }
-
-/* XXXKYMA: Must be called with interrupts disabled */
-int kvm_mips_handle_kseg0_tlb_fault(unsigned long badvaddr,
-				    struct kvm_vcpu *vcpu)
-{
-	gfn_t gfn;
-	kvm_pfn_t pfn0, pfn1;
-	unsigned long vaddr = 0;
-	unsigned long entryhi = 0, entrylo0 = 0, entrylo1 = 0;
-	int even;
-	struct kvm *kvm = vcpu->kvm;
-	const int flush_dcache_mask = 0;
-	int ret;
-
-	if (KVM_GUEST_KSEGX(badvaddr) != KVM_GUEST_KSEG0) {
-		kvm_err("%s: Invalid BadVaddr: %#lx\n", __func__, badvaddr);
-		kvm_mips_dump_host_tlbs();
-		return -1;
-	}
-
-	gfn = (KVM_GUEST_CPHYSADDR(badvaddr) >> PAGE_SHIFT);
-	if (gfn >= kvm->arch.guest_pmap_npages) {
-		kvm_err("%s: Invalid gfn: %#llx, BadVaddr: %#lx\n", __func__,
-			gfn, badvaddr);
-		kvm_mips_dump_host_tlbs();
-		return -1;
-	}
-	even = !(gfn & 0x1);
-	vaddr = badvaddr & (PAGE_MASK << 1);
-
-	if (kvm_mips_map_page(vcpu->kvm, gfn) < 0)
-		return -1;
-
-	if (kvm_mips_map_page(vcpu->kvm, gfn ^ 0x1) < 0)
-		return -1;
-
-	if (even) {
-		pfn0 = kvm->arch.guest_pmap[gfn];
-		pfn1 = kvm->arch.guest_pmap[gfn ^ 0x1];
-	} else {
-		pfn0 = kvm->arch.guest_pmap[gfn ^ 0x1];
-		pfn1 = kvm->arch.guest_pmap[gfn];
-	}
-
-	entrylo0 = mips3_paddr_to_tlbpfn(pfn0 << PAGE_SHIFT) | (0x3 << 3) |
-		   (1 << 2) | (0x1 << 1);
-	entrylo1 = mips3_paddr_to_tlbpfn(pfn1 << PAGE_SHIFT) | (0x3 << 3) |
-		   (1 << 2) | (0x1 << 1);
-
-	preempt_disable();
-	entryhi = (vaddr | kvm_mips_get_kernel_asid(vcpu));
-	ret = kvm_mips_host_tlb_write(vcpu, entryhi, entrylo0, entrylo1,
-				      flush_dcache_mask);
-	preempt_enable();
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(kvm_mips_handle_kseg0_tlb_fault);
+EXPORT_SYMBOL_GPL(kvm_mips_host_tlb_write);
 
 int kvm_mips_handle_commpage_tlb_fault(unsigned long badvaddr,
 	struct kvm_vcpu *vcpu)
@@ -363,61 +254,6 @@ int kvm_mips_handle_commpage_tlb_fault(unsigned long badvaddr,
 }
 EXPORT_SYMBOL_GPL(kvm_mips_handle_commpage_tlb_fault);
 
-int kvm_mips_handle_mapped_seg_tlb_fault(struct kvm_vcpu *vcpu,
-					 struct kvm_mips_tlb *tlb,
-					 unsigned long *hpa0,
-					 unsigned long *hpa1)
-{
-	unsigned long entryhi = 0, entrylo0 = 0, entrylo1 = 0;
-	struct kvm *kvm = vcpu->kvm;
-	kvm_pfn_t pfn0, pfn1;
-	int ret;
-
-	if ((tlb->tlb_hi & VPN2_MASK) == 0) {
-		pfn0 = 0;
-		pfn1 = 0;
-	} else {
-		if (kvm_mips_map_page(kvm, mips3_tlbpfn_to_paddr(tlb->tlb_lo0)
-					   >> PAGE_SHIFT) < 0)
-			return -1;
-
-		if (kvm_mips_map_page(kvm, mips3_tlbpfn_to_paddr(tlb->tlb_lo1)
-					   >> PAGE_SHIFT) < 0)
-			return -1;
-
-		pfn0 = kvm->arch.guest_pmap[mips3_tlbpfn_to_paddr(tlb->tlb_lo0)
-					    >> PAGE_SHIFT];
-		pfn1 = kvm->arch.guest_pmap[mips3_tlbpfn_to_paddr(tlb->tlb_lo1)
-					    >> PAGE_SHIFT];
-	}
-
-	if (hpa0)
-		*hpa0 = pfn0 << PAGE_SHIFT;
-
-	if (hpa1)
-		*hpa1 = pfn1 << PAGE_SHIFT;
-
-	/* Get attributes from the Guest TLB */
-	entrylo0 = mips3_paddr_to_tlbpfn(pfn0 << PAGE_SHIFT) | (0x3 << 3) |
-		   (tlb->tlb_lo0 & MIPS3_PG_D) | (tlb->tlb_lo0 & MIPS3_PG_V);
-	entrylo1 = mips3_paddr_to_tlbpfn(pfn1 << PAGE_SHIFT) | (0x3 << 3) |
-		   (tlb->tlb_lo1 & MIPS3_PG_D) | (tlb->tlb_lo1 & MIPS3_PG_V);
-
-	kvm_debug("@ %#lx tlb_lo0: 0x%08lx tlb_lo1: 0x%08lx\n", vcpu->arch.pc,
-		  tlb->tlb_lo0, tlb->tlb_lo1);
-
-	preempt_disable();
-	entryhi = (tlb->tlb_hi & VPN2_MASK) | (KVM_GUEST_KERNEL_MODE(vcpu) ?
-					       kvm_mips_get_kernel_asid(vcpu) :
-					       kvm_mips_get_user_asid(vcpu));
-	ret = kvm_mips_host_tlb_write(vcpu, entryhi, entrylo0, entrylo1,
-				      tlb->tlb_mask);
-	preempt_enable();
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(kvm_mips_handle_mapped_seg_tlb_fault);
-
 int kvm_mips_guest_tlb_lookup(struct kvm_vcpu *vcpu, unsigned long entryhi)
 {
 	int i;
@@ -574,25 +410,6 @@ void kvm_mips_flush_host_tlb(int skip_kseg0)
 }
 EXPORT_SYMBOL_GPL(kvm_mips_flush_host_tlb);
 
-void kvm_get_new_mmu_context(struct mm_struct *mm, unsigned long cpu,
-			     struct kvm_vcpu *vcpu)
-{
-	unsigned long asid = asid_cache(cpu);
-
-	asid += cpu_asid_inc();
-	if (!(asid & cpu_asid_mask(&cpu_data[cpu]))) {
-		if (cpu_has_vtag_icache)
-			flush_icache_all();
-
-		kvm_local_flush_tlb_all();      /* start new asid cycle */
-
-		if (!asid)      /* fix version if needed */
-			asid = asid_first_version(cpu);
-	}
-
-	cpu_context(cpu, mm) = asid_cache(cpu) = asid;
-}
-
 void kvm_local_flush_tlb_all(void)
 {
 	unsigned long flags;
@@ -621,176 +438,3 @@ void kvm_local_flush_tlb_all(void)
 	local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(kvm_local_flush_tlb_all);
-
-/**
- * kvm_mips_migrate_count() - Migrate timer.
- * @vcpu:	Virtual CPU.
- *
- * Migrate CP0_Count hrtimer to the current CPU by cancelling and restarting it
- * if it was running prior to being cancelled.
- *
- * Must be called when the VCPU is migrated to a different CPU to ensure that
- * timer expiry during guest execution interrupts the guest and causes the
- * interrupt to be delivered in a timely manner.
- */
-static void kvm_mips_migrate_count(struct kvm_vcpu *vcpu)
-{
-	if (hrtimer_cancel(&vcpu->arch.comparecount_timer))
-		hrtimer_restart(&vcpu->arch.comparecount_timer);
-}
-
-/* Restore ASID once we are scheduled back after preemption */
-void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
-{
-	unsigned long asid_mask = cpu_asid_mask(&cpu_data[cpu]);
-	unsigned long flags;
-	int newasid = 0;
-
-	kvm_debug("%s: vcpu %p, cpu: %d\n", __func__, vcpu, cpu);
-
-	/* Allocate new kernel and user ASIDs if needed */
-
-	local_irq_save(flags);
-
-	if ((vcpu->arch.guest_kernel_asid[cpu] ^ asid_cache(cpu)) &
-						asid_version_mask(cpu)) {
-		kvm_get_new_mmu_context(&vcpu->arch.guest_kernel_mm, cpu, vcpu);
-		vcpu->arch.guest_kernel_asid[cpu] =
-		    vcpu->arch.guest_kernel_mm.context.asid[cpu];
-		kvm_get_new_mmu_context(&vcpu->arch.guest_user_mm, cpu, vcpu);
-		vcpu->arch.guest_user_asid[cpu] =
-		    vcpu->arch.guest_user_mm.context.asid[cpu];
-		newasid++;
-
-		kvm_debug("[%d]: cpu_context: %#lx\n", cpu,
-			  cpu_context(cpu, current->mm));
-		kvm_debug("[%d]: Allocated new ASID for Guest Kernel: %#x\n",
-			  cpu, vcpu->arch.guest_kernel_asid[cpu]);
-		kvm_debug("[%d]: Allocated new ASID for Guest User: %#x\n", cpu,
-			  vcpu->arch.guest_user_asid[cpu]);
-	}
-
-	if (vcpu->arch.last_sched_cpu != cpu) {
-		kvm_debug("[%d->%d]KVM VCPU[%d] switch\n",
-			  vcpu->arch.last_sched_cpu, cpu, vcpu->vcpu_id);
-		/*
-		 * Migrate the timer interrupt to the current CPU so that it
-		 * always interrupts the guest and synchronously triggers a
-		 * guest timer interrupt.
-		 */
-		kvm_mips_migrate_count(vcpu);
-	}
-
-	if (!newasid) {
-		/*
-		 * If we preempted while the guest was executing, then reload
-		 * the pre-empted ASID
-		 */
-		if (current->flags & PF_VCPU) {
-			write_c0_entryhi(vcpu->arch.
-					 preempt_entryhi & asid_mask);
-			ehb();
-		}
-	} else {
-		/* New ASIDs were allocated for the VM */
-
-		/*
-		 * Were we in guest context? If so then the pre-empted ASID is
-		 * no longer valid, we need to set it to what it should be based
-		 * on the mode of the Guest (Kernel/User)
-		 */
-		if (current->flags & PF_VCPU) {
-			if (KVM_GUEST_KERNEL_MODE(vcpu))
-				write_c0_entryhi(vcpu->arch.
-						 guest_kernel_asid[cpu] &
-						 asid_mask);
-			else
-				write_c0_entryhi(vcpu->arch.
-						 guest_user_asid[cpu] &
-						 asid_mask);
-			ehb();
-		}
-	}
-
-	/* restore guest state to registers */
-	kvm_mips_callbacks->vcpu_set_regs(vcpu);
-
-	local_irq_restore(flags);
-
-}
-EXPORT_SYMBOL_GPL(kvm_arch_vcpu_load);
-
-/* ASID can change if another task is scheduled during preemption */
-void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
-{
-	unsigned long flags;
-	int cpu;
-
-	local_irq_save(flags);
-
-	cpu = smp_processor_id();
-
-	vcpu->arch.preempt_entryhi = read_c0_entryhi();
-	vcpu->arch.last_sched_cpu = cpu;
-
-	/* save guest state in registers */
-	kvm_mips_callbacks->vcpu_get_regs(vcpu);
-
-	if (((cpu_context(cpu, current->mm) ^ asid_cache(cpu)) &
-	     asid_version_mask(cpu))) {
-		kvm_debug("%s: Dropping MMU Context:  %#lx\n", __func__,
-			  cpu_context(cpu, current->mm));
-		drop_mmu_context(current->mm, cpu);
-	}
-	write_c0_entryhi(cpu_asid(cpu, current->mm));
-	ehb();
-
-	local_irq_restore(flags);
-}
-EXPORT_SYMBOL_GPL(kvm_arch_vcpu_put);
-
-u32 kvm_get_inst(u32 *opc, struct kvm_vcpu *vcpu)
-{
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
-	unsigned long paddr, flags, vpn2, asid;
-	u32 inst;
-	int index;
-
-	if (KVM_GUEST_KSEGX((unsigned long) opc) < KVM_GUEST_KSEG0 ||
-	    KVM_GUEST_KSEGX((unsigned long) opc) == KVM_GUEST_KSEG23) {
-		local_irq_save(flags);
-		index = kvm_mips_host_tlb_lookup(vcpu, (unsigned long) opc);
-		if (index >= 0) {
-			inst = *(opc);
-		} else {
-			vpn2 = (unsigned long) opc & VPN2_MASK;
-			asid = kvm_read_c0_guest_entryhi(cop0) &
-						KVM_ENTRYHI_ASID;
-			index = kvm_mips_guest_tlb_lookup(vcpu, vpn2 | asid);
-			if (index < 0) {
-				kvm_err("%s: get_user_failed for %p, vcpu: %p, ASID: %#lx\n",
-					__func__, opc, vcpu, read_c0_entryhi());
-				kvm_mips_dump_host_tlbs();
-				local_irq_restore(flags);
-				return KVM_INVALID_INST;
-			}
-			kvm_mips_handle_mapped_seg_tlb_fault(vcpu,
-							     &vcpu->arch.
-							     guest_tlb[index],
-							     NULL, NULL);
-			inst = *(opc);
-		}
-		local_irq_restore(flags);
-	} else if (KVM_GUEST_KSEGX(opc) == KVM_GUEST_KSEG0) {
-		paddr =
-		    kvm_mips_translate_guest_kseg0_to_hpa(vcpu,
-							  (unsigned long) opc);
-		inst = *(u32 *) CKSEG0ADDR(paddr);
-	} else {
-		kvm_err("%s: illegal address: %p\n", __func__, opc);
-		return KVM_INVALID_INST;
-	}
-
-	return inst;
-}
-EXPORT_SYMBOL_GPL(kvm_get_inst);
-- 
2.4.10
