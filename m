Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Nov 2012 03:37:41 +0100 (CET)
Received: from kymasys.com ([64.62.140.43]:49052 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6828074Ab2KVCfBwFSqG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 22 Nov 2012 03:35:01 +0100
Received: from agni.kymasys.com ([75.40.23.192]) by kymasys.com for <linux-mips@linux-mips.org>; Wed, 21 Nov 2012 18:34:53 -0800
Received: by agni.kymasys.com (Postfix, from userid 500)
        id 8D871630279; Wed, 21 Nov 2012 18:34:18 -0800 (PST)
From:   Sanjay Lal <sanjayl@kymasys.com>
To:     kvm@vger.kernel.org, linux-mips@linux-mips.org
Cc:     Sanjay Lal <sanjayl@kymasys.com>
Subject: [PATCH v2 04/18] KVM/MIPS32: MIPS arch specific APIs for KVM
Date:   Wed, 21 Nov 2012 18:34:02 -0800
Message-Id: <1353551656-23579-5-git-send-email-sanjayl@kymasys.com>
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1353551656-23579-1-git-send-email-sanjayl@kymasys.com>
References: <1353551656-23579-1-git-send-email-sanjayl@kymasys.com>
X-archive-position: 35084
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

- Implements the arch specific APIs for KVM, some are stubs for MIPS
- kvm_mips_handle_exit(): Main 'C' distpatch routine for handling exceptions while in "Guest" mode.
- Also implements in-kernel timer interrupt support for the guest.

Signed-off-by: Sanjay Lal <sanjayl@kymasys.com>
---
 arch/mips/kvm/kvm_mips.c | 965 +++++++++++++++++++++++++++++++++++++++++++++++
 arch/mips/kvm/trace.h    |  46 +++
 2 files changed, 1011 insertions(+)
 create mode 100644 arch/mips/kvm/kvm_mips.c
 create mode 100644 arch/mips/kvm/trace.h

diff --git a/arch/mips/kvm/kvm_mips.c b/arch/mips/kvm/kvm_mips.c
new file mode 100644
index 0000000..e239d73
--- /dev/null
+++ b/arch/mips/kvm/kvm_mips.c
@@ -0,0 +1,965 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * KVM/MIPS: MIPS specific KVM APIs
+ *
+ * Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
+ * Authors: Sanjay Lal <sanjayl@kymasys.com>
+*/
+
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/vmalloc.h>
+#include <linux/fs.h>
+#include <linux/bootmem.h>
+#include <asm/page.h>
+#include <asm/cacheflush.h>
+#include <asm/mmu_context.h>
+
+#include <linux/kvm_host.h>
+
+#include "kvm_mips_int.h"
+#include "kvm_mips_comm.h"
+
+#define CREATE_TRACE_POINTS
+#include "trace.h"
+
+#ifndef VECTORSPACING
+#define VECTORSPACING 0x100	/* for EI/VI mode */
+#endif
+
+#define VCPU_STAT(x) offsetof(struct kvm_vcpu, stat.x), KVM_STAT_VCPU
+struct kvm_stats_debugfs_item debugfs_entries[] = {
+	{ "wait", VCPU_STAT(wait_exits) },
+	{ "cache", VCPU_STAT(cache_exits) },
+	{ "signal", VCPU_STAT(signal_exits) },
+	{ "interrupt", VCPU_STAT(int_exits) },
+	{ "cop_unsuable", VCPU_STAT(cop_unusable_exits) },
+	{ "tlbmod", VCPU_STAT(tlbmod_exits) },
+	{ "tlbmiss_ld", VCPU_STAT(tlbmiss_ld_exits) },
+	{ "tlbmiss_st", VCPU_STAT(tlbmiss_st_exits) },
+	{ "addrerr_st", VCPU_STAT(addrerr_st_exits) },
+	{ "addrerr_ld", VCPU_STAT(addrerr_ld_exits) },
+	{ "syscall", VCPU_STAT(syscall_exits) },
+	{ "resvd_inst", VCPU_STAT(resvd_inst_exits) },
+	{ "break_inst", VCPU_STAT(break_inst_exits) },
+	{ "flush_dcache", VCPU_STAT(flush_dcache_exits) },
+	{ "halt_wakeup", VCPU_STAT(halt_wakeup) },
+	{NULL}
+};
+
+static int kvm_mips_reset_vcpu(struct kvm_vcpu *vcpu)
+{
+	int i;
+	for_each_possible_cpu(i) {
+		vcpu->arch.guest_kernel_asid[i] = 0;
+		vcpu->arch.guest_user_asid[i] = 0;
+	}
+	return 0;
+}
+
+gfn_t unalias_gfn(struct kvm *kvm, gfn_t gfn)
+{
+	return gfn;
+}
+
+/* XXXKYMA: We are simulatoring a processor that has the WII bit set in Config7, so we
+ * are "runnable" if interrupts are pending
+ */
+int kvm_arch_vcpu_runnable(struct kvm_vcpu *vcpu)
+{
+	return !!(vcpu->arch.pending_exceptions);
+}
+
+int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
+{
+	return 1;
+}
+
+int kvm_arch_hardware_enable(void *garbage)
+{
+	return 0;
+}
+
+void kvm_arch_hardware_disable(void *garbage)
+{
+}
+
+int kvm_arch_hardware_setup(void)
+{
+	return 0;
+}
+
+void kvm_arch_hardware_unsetup(void)
+{
+}
+
+void kvm_arch_check_processor_compat(void *rtn)
+{
+	int *r = (int *)rtn;
+	*r = 0;
+	return;
+}
+
+static void kvm_mips_init_tlbs(struct kvm *kvm)
+{
+	ulong wired;
+
+	/* Add a wired entry to the TLB, it is used to map the commpage to the Guest kernel */
+	wired = read_c0_wired();
+	write_c0_wired(wired + 1);
+	mtc0_tlbw_hazard();
+	kvm->arch.commpage_tlb = wired;
+
+	kvm_debug("[%d] commpage TLB: %d\n", smp_processor_id(),
+		  kvm->arch.commpage_tlb);
+}
+
+static void kvm_mips_init_vm_percpu(void *arg)
+{
+	struct kvm *kvm = (struct kvm *)arg;
+
+	kvm_mips_init_tlbs(kvm);
+	kvm_mips_callbacks->vm_init(kvm);
+
+}
+
+int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
+{
+	if (atomic_inc_return(&kvm_mips_instance) == 1) {
+		kvm_info("%s: 1st KVM instance, setup host TLB parameters\n",
+			 __func__);
+		on_each_cpu(kvm_mips_init_vm_percpu, kvm, 1);
+	}
+
+
+	return 0;
+}
+
+void kvm_mips_free_vcpus(struct kvm *kvm)
+{
+	unsigned int i;
+	struct kvm_vcpu *vcpu;
+
+	/* Put the pages we reserved for the guest pmap */
+	for (i = 0; i < kvm->arch.guest_pmap_npages; i++) {
+		if (kvm->arch.guest_pmap[i] != KVM_INVALID_PAGE)
+			kvm_mips_release_pfn_clean(kvm->arch.guest_pmap[i]);
+	}
+
+	if (kvm->arch.guest_pmap)
+		kfree(kvm->arch.guest_pmap);
+
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		kvm_arch_vcpu_free(vcpu);
+	}
+
+	mutex_lock(&kvm->lock);
+
+	for (i = 0; i < atomic_read(&kvm->online_vcpus); i++)
+		kvm->vcpus[i] = NULL;
+
+	atomic_set(&kvm->online_vcpus, 0);
+
+	mutex_unlock(&kvm->lock);
+}
+
+void kvm_arch_sync_events(struct kvm *kvm)
+{
+}
+
+static void kvm_mips_uninit_tlbs(void *arg)
+{
+	/* Restore wired count */
+	write_c0_wired(0);
+	mtc0_tlbw_hazard();
+	/* Clear out all the TLBs */
+	kvm_local_flush_tlb_all();
+}
+
+void kvm_arch_destroy_vm(struct kvm *kvm)
+{
+	kvm_mips_free_vcpus(kvm);
+
+	/* If this is the last instance, restore wired count */
+	if (atomic_dec_return(&kvm_mips_instance) == 0) {
+		kvm_info("%s: last KVM instance, restoring TLB parameters\n",
+			 __func__);
+		on_each_cpu(kvm_mips_uninit_tlbs, NULL, 1);
+	}
+}
+
+long
+kvm_arch_dev_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
+{
+	return -EINVAL;
+}
+
+int
+kvm_arch_set_memory_region(struct kvm *kvm,
+			   struct kvm_userspace_memory_region *mem,
+			   struct kvm_memory_slot old, int user_alloc)
+{
+	return 0;
+}
+
+void kvm_arch_free_memslot(struct kvm_memory_slot *free,
+			   struct kvm_memory_slot *dont)
+{
+}
+
+int kvm_arch_create_memslot(struct kvm_memory_slot *slot, unsigned long npages)
+{
+	return 0;
+}
+
+int kvm_arch_prepare_memory_region(struct kvm *kvm,
+				   struct kvm_memory_slot *memslot,
+				   struct kvm_memory_slot old,
+				   struct kvm_userspace_memory_region *mem,
+				   int user_alloc)
+{
+	return 0;
+}
+
+void kvm_arch_commit_memory_region(struct kvm *kvm,
+				   struct kvm_userspace_memory_region *mem,
+				   struct kvm_memory_slot old, int user_alloc)
+{
+	ulong npages = 0;
+	pfn_t pfn __unused;
+	int i, err = 0;
+
+	kvm_debug("%s: kvm: %p slot: %d, GPA: %llx, size: %llx, QVA: %llx\n",
+		  __func__, kvm, mem->slot, mem->guest_phys_addr,
+		  mem->memory_size, mem->userspace_addr);
+
+	/* Setup Guest PMAP table */
+	if (!kvm->arch.guest_pmap) {
+		if (mem->slot == 0)
+			npages = mem->memory_size >> PAGE_SHIFT;
+
+		if (npages) {
+			kvm->arch.guest_pmap_npages = npages;
+			kvm->arch.guest_pmap =
+			    kzalloc(npages * sizeof(ulong), GFP_KERNEL);
+
+			if (!kvm->arch.guest_pmap) {
+				kvm_err("Failed to allocate guest PMAP");
+				err = -ENOMEM;
+				goto out;
+			}
+
+			kvm_info
+			    ("Allocated space for Guest PMAP Table (%ld pages) @ %p\n",
+			     npages, kvm->arch.guest_pmap);
+
+			/* Now setup the page table */
+			for (i = 0; i < npages; i++) {
+				kvm->arch.guest_pmap[i] = KVM_INVALID_PAGE;
+			}
+		}
+	}
+out:
+	return;
+}
+
+void kvm_arch_flush_shadow_all(struct kvm *kvm)
+{
+}
+
+void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
+				   struct kvm_memory_slot *slot)
+{
+}
+
+void kvm_arch_flush_shadow(struct kvm *kvm)
+{
+}
+
+struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm, unsigned int id)
+{
+	extern char mips32_exception[], mips32_exceptionEnd[];
+	extern char mips32_GuestException[], mips32_GuestExceptionEnd[];
+	int err, size, offset;
+	void *gebase;
+	int i;
+
+	struct kvm_vcpu *vcpu = kzalloc(sizeof(struct kvm_vcpu), GFP_KERNEL);
+
+	if (!vcpu) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	err = kvm_vcpu_init(vcpu, kvm, id);
+
+	if (err)
+		goto out_free_cpu;
+
+	kvm_info("kvm @ %p: create cpu %d at %p\n", kvm, id, vcpu);
+
+	/* Allocate space for host mode exception handlers that handle
+	 * guest mode exits
+	 */
+	if (cpu_has_veic || cpu_has_vint) {
+		size = 0x200 + VECTORSPACING * 64;
+	} else {
+		size = 0x200;
+	}
+
+	/* Save Linux EBASE */
+	vcpu->arch.host_ebase = (void *)read_c0_ebase();
+
+	gebase = kzalloc(ALIGN(size, PAGE_SIZE), GFP_KERNEL);
+
+	if (!gebase) {
+		err = -ENOMEM;
+		goto out_free_cpu;
+	}
+	kvm_info("Allocated %d bytes for KVM Exception Handlers @ %p\n",
+		 ALIGN(size, PAGE_SIZE), gebase);
+
+	/* Save new ebase */
+	vcpu->arch.guest_ebase = gebase;
+
+	/* Copy L1 Guest Exception handler to correct offset */
+
+	/* TLB Refill, EXL = 0 */
+	memcpy(gebase, mips32_exception,
+	       mips32_exceptionEnd - mips32_exception);
+
+	/* General Exception Entry point */
+	memcpy(gebase + 0x180, mips32_exception,
+	       mips32_exceptionEnd - mips32_exception);
+
+	/* For vectored interrupts poke the exception code @ all offsets 0-7 */
+	for (i = 0; i < 8; i++) {
+		kvm_debug("L1 Vectored handler @ %p\n",
+			  gebase + 0x200 + (i * VECTORSPACING));
+		memcpy(gebase + 0x200 + (i * VECTORSPACING), mips32_exception,
+		       mips32_exceptionEnd - mips32_exception);
+	}
+
+	/* General handler, relocate to unmapped space for sanity's sake */
+	offset = 0x2000;
+	kvm_info("Installing KVM Exception handlers @ %p, %#x bytes\n",
+		 gebase + offset,
+		 mips32_GuestExceptionEnd - mips32_GuestException);
+
+	memcpy(gebase + offset, mips32_GuestException,
+	       mips32_GuestExceptionEnd - mips32_GuestException);
+
+	/* Invalidate the icache for these ranges */
+	mips32_SyncICache((ulong) gebase, ALIGN(size, PAGE_SIZE));
+
+	/* Allocate comm page for guest kernel, a TLB will be reserved for mapping GVA @ 0xFFFF8000 to this page */
+	vcpu->arch.kseg0_commpage = kzalloc(PAGE_SIZE << 1, GFP_KERNEL);
+
+	if (!vcpu->arch.kseg0_commpage) {
+		err = -ENOMEM;
+		goto out_free_gebase;
+	}
+
+	kvm_info("Allocated COMM page @ %p\n", vcpu->arch.kseg0_commpage);
+	kvm_mips_commpage_init(vcpu);
+
+	/* Init */
+	vcpu->arch.last_sched_cpu = -1;
+
+	/* Start off the timer */
+	kvm_mips_emulate_count(vcpu);
+
+	return vcpu;
+
+out_free_gebase:
+	kfree(gebase);
+
+out_free_cpu:
+	kfree(vcpu);
+
+out:
+	return ERR_PTR(err);
+}
+
+void kvm_arch_vcpu_free(struct kvm_vcpu *vcpu)
+{
+	hrtimer_cancel(&vcpu->arch.comparecount_timer);
+
+	kvm_vcpu_uninit(vcpu);
+
+	kvm_mips_dump_stats(vcpu);
+
+	if (vcpu->arch.guest_ebase)
+		kfree(vcpu->arch.guest_ebase);
+
+	if (vcpu->arch.kseg0_commpage)
+		kfree(vcpu->arch.kseg0_commpage);
+
+}
+
+void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
+{
+	kvm_arch_vcpu_free(vcpu);
+}
+
+int
+kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
+				    struct kvm_guest_debug *dbg)
+{
+	return -EINVAL;
+}
+
+int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
+{
+	int r = 0;
+	sigset_t sigsaved;
+
+	if (vcpu->sigset_active)
+		sigprocmask(SIG_SETMASK, &vcpu->sigset, &sigsaved);
+
+	if (vcpu->mmio_needed) {
+		if (!vcpu->mmio_is_write)
+			kvm_mips_complete_mmio_load(vcpu, run);
+		vcpu->mmio_needed = 0;
+	}
+
+	/* Check if we have any exceptions/interrupts pending */
+	kvm_mips_deliver_interrupts(vcpu,
+				    kvm_read_c0_guest_cause(vcpu->arch.cop0));
+
+	local_irq_disable();
+	kvm_guest_enter();
+
+	r = __kvm_mips_vcpu_run(run, vcpu);
+
+	kvm_guest_exit();
+	local_irq_enable();
+
+	if (vcpu->sigset_active)
+		sigprocmask(SIG_SETMASK, &sigsaved, NULL);
+
+	return r;
+}
+
+int
+kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu, struct kvm_mips_interrupt *irq)
+{
+	int intr = (int)irq->irq;
+	struct kvm_vcpu *dvcpu = NULL;
+
+	if (intr == 3 || intr == -3 || intr == 4 || intr == -4)
+		kvm_debug("%s: CPU: %d, INTR: %d\n", __func__, irq->cpu,
+			  (int)intr);
+
+	if (irq->cpu == -1)
+		dvcpu = vcpu;
+	else
+		dvcpu = vcpu->kvm->vcpus[irq->cpu];
+
+	if (intr == 2 || intr == 3 || intr == 4) {
+		kvm_mips_callbacks->queue_io_int(dvcpu, irq);
+
+	} else if (intr == -2 || intr == -3 || intr == -4) {
+		kvm_mips_callbacks->dequeue_io_int(dvcpu, irq);
+	} else {
+		kvm_err("%s: invalid interrupt ioctl (%d:%d)\n", __func__,
+			irq->cpu, irq->irq);
+		return -EINVAL;
+	}
+
+	dvcpu->arch.wait = 0;
+
+	if (waitqueue_active(&dvcpu->wq)) {
+		wake_up_interruptible(&dvcpu->wq);
+	}
+
+	return 0;
+}
+
+int
+kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
+				struct kvm_mp_state *mp_state)
+{
+	return -EINVAL;
+}
+
+int
+kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
+				struct kvm_mp_state *mp_state)
+{
+	return -EINVAL;
+}
+
+long
+kvm_arch_vcpu_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
+{
+	struct kvm_vcpu *vcpu = filp->private_data;
+	void __user *argp = (void __user *)arg;
+	long r;
+	int intr;
+
+	switch (ioctl) {
+	case KVM_NMI:
+		/* Treat the NMI as a CPU reset */
+		r = kvm_mips_reset_vcpu(vcpu);
+		break;
+	case KVM_INTERRUPT:
+		{
+			struct kvm_mips_interrupt irq;
+			r = -EFAULT;
+			if (copy_from_user(&irq, argp, sizeof(irq)))
+				goto out;
+
+			intr = (int)irq.irq;
+
+			kvm_debug("[%d] %s: irq: %d\n", vcpu->vcpu_id, __func__,
+				  irq.irq);
+
+			r = kvm_vcpu_ioctl_interrupt(vcpu, &irq);
+			break;
+		}
+	default:
+		r = -EINVAL;
+	}
+
+out:
+	return r;
+}
+
+/*
+ * Get (and clear) the dirty memory log for a memory slot.
+ */
+int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
+{
+	struct kvm_memory_slot *memslot;
+	struct kvm_vcpu *vcpu __unused;
+	ulong ga, ga_end;
+	int is_dirty = 0;
+	int r;
+	unsigned long n;
+
+	mutex_lock(&kvm->slots_lock);
+
+	r = kvm_get_dirty_log(kvm, log, &is_dirty);
+	if (r)
+		goto out;
+
+	/* If nothing is dirty, don't bother messing with page tables. */
+	if (is_dirty) {
+		memslot = &kvm->memslots->memslots[log->slot];
+
+		ga = memslot->base_gfn << PAGE_SHIFT;
+		ga_end = ga + (memslot->npages << PAGE_SHIFT);
+
+		printk("%s: dirty, ga: %#lx, ga_end %#lx\n", __func__, ga,
+		       ga_end);
+
+		n = kvm_dirty_bitmap_bytes(memslot);
+		memset(memslot->dirty_bitmap, 0, n);
+	}
+
+	r = 0;
+out:
+	mutex_unlock(&kvm->slots_lock);
+	return r;
+
+}
+
+long kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
+{
+	long r;
+
+	switch (ioctl) {
+	default:
+		r = -EINVAL;
+	}
+
+	return r;
+}
+
+int kvm_arch_init(void *opaque)
+{
+	int ret;
+
+	if (kvm_mips_callbacks) {
+		kvm_err("kvm: module already exists\n");
+		return -EEXIST;
+	}
+
+	ret = kvm_mips_emulation_init(&kvm_mips_callbacks);
+
+	return ret;
+}
+
+void kvm_arch_exit(void)
+{
+	kvm_mips_callbacks = NULL;
+}
+
+int
+kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
+{
+	return -ENOTSUPP;
+}
+
+int
+kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
+{
+	return -ENOTSUPP;
+}
+
+int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
+{
+	return -ENOTSUPP;
+}
+
+int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
+{
+	return -ENOTSUPP;
+}
+
+int kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *vmf)
+{
+	return VM_FAULT_SIGBUS;
+}
+
+int kvm_dev_ioctl_check_extension(long ext)
+{
+	int r;
+
+	switch (ext) {
+	case KVM_CAP_COALESCED_MMIO:
+		r = KVM_COALESCED_MMIO_PAGE_OFFSET;
+		break;
+	default:
+		r = 0;
+		break;
+	}
+	return r;
+
+}
+
+int kvm_cpu_has_pending_timer(struct kvm_vcpu *vcpu)
+{
+	return kvm_mips_pending_timer(vcpu);
+}
+
+int kvm_arch_vcpu_dump_regs(struct kvm_vcpu *vcpu)
+{
+	int i;
+	struct mips_coproc *cop0;
+
+	if (!vcpu)
+		return -1;
+
+	printk("VCPU Register Dump:\n");
+	printk("\tpc = 0x%08lx\n", vcpu->arch.pc);;
+	printk("\texceptions: %08lx\n", vcpu->arch.pending_exceptions);
+
+	for (i = 0; i < 32; i += 4) {
+		printk("\tgpr%02d: %08lx %08lx %08lx %08lx\n", i,
+		       vcpu->arch.gprs[i],
+		       vcpu->arch.gprs[i + 1],
+		       vcpu->arch.gprs[i + 2], vcpu->arch.gprs[i + 3]);
+	}
+	printk("\thi: 0x%08lx\n", vcpu->arch.hi);
+	printk("\tlo: 0x%08lx\n", vcpu->arch.lo);
+
+	cop0 = vcpu->arch.cop0;
+	printk("\tStatus: 0x%08lx, Cause: 0x%08lx\n",
+	       kvm_read_c0_guest_status(cop0), kvm_read_c0_guest_cause(cop0));
+
+	printk("\tEPC: 0x%08lx\n", kvm_read_c0_guest_epc(cop0));
+
+	return 0;
+}
+
+int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
+{
+	int i;
+	struct mips_coproc *cop0 __unused = vcpu->arch.cop0;
+
+	for (i = 0; i < 32; i++)
+		vcpu->arch.gprs[i] = regs->gprs[i];
+
+	vcpu->arch.hi = regs->hi;
+	vcpu->arch.lo = regs->lo;
+	vcpu->arch.pc = regs->pc;
+
+	return kvm_mips_callbacks->vcpu_ioctl_set_regs(vcpu, regs);
+}
+
+int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
+{
+	int i;
+	struct mips_coproc *cop0 __unused = vcpu->arch.cop0;
+
+	for (i = 0; i < 32; i++)
+		regs->gprs[i] = vcpu->arch.gprs[i];
+
+	regs->hi = vcpu->arch.hi;
+	regs->lo = vcpu->arch.lo;
+	regs->pc = vcpu->arch.pc;
+
+	return kvm_mips_callbacks->vcpu_ioctl_get_regs(vcpu, regs);
+}
+
+void kvm_mips_comparecount_func(unsigned long data)
+{
+	struct kvm_vcpu *vcpu = (struct kvm_vcpu *)data;
+
+	kvm_mips_callbacks->queue_timer_int(vcpu);
+
+	vcpu->arch.wait = 0;
+	if (waitqueue_active(&vcpu->wq)) {
+		wake_up_interruptible(&vcpu->wq);
+	}
+}
+
+/*
+ * low level hrtimer wake routine.
+ */
+enum hrtimer_restart kvm_mips_comparecount_wakeup(struct hrtimer *timer)
+{
+	struct kvm_vcpu *vcpu;
+
+	vcpu = container_of(timer, struct kvm_vcpu, arch.comparecount_timer);
+	kvm_mips_comparecount_func((ulong) vcpu);
+	hrtimer_forward_now(&vcpu->arch.comparecount_timer,
+			    ktime_set(0, MS_TO_NS(10)));
+	return HRTIMER_RESTART;
+}
+
+int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
+{
+	kvm_mips_callbacks->vcpu_init(vcpu);
+	hrtimer_init(&vcpu->arch.comparecount_timer, CLOCK_MONOTONIC,
+		     HRTIMER_MODE_REL);
+	vcpu->arch.comparecount_timer.function = kvm_mips_comparecount_wakeup;
+	kvm_mips_init_shadow_tlb(vcpu);
+	return 0;
+}
+
+void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu)
+{
+	return;
+}
+
+int
+kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu, struct kvm_translation *tr)
+{
+	return 0;
+}
+
+/* Initial guest state */
+int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
+{
+	return kvm_mips_callbacks->vcpu_setup(vcpu);
+}
+
+static
+void kvm_mips_set_c0_status(void)
+{
+	uint32_t status = read_c0_status();
+
+	if (cpu_has_fpu)
+		status |= (ST0_CU1);
+
+	if (cpu_has_dsp)
+		status |= (ST0_MX);
+
+	write_c0_status(status);
+	ehb();
+}
+
+/*
+ * Return value is in the form (errcode<<2 | RESUME_FLAG_HOST | RESUME_FLAG_NV)
+ */
+int kvm_mips_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
+{
+	uint32_t cause = vcpu->arch.host_cp0_cause;
+	uint32_t exccode = (cause >> CAUSEB_EXCCODE) & 0x1f;
+	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.pc;
+	ulong badvaddr = vcpu->arch.host_cp0_badvaddr;
+	enum emulation_result er = EMULATE_DONE;
+	int ret = RESUME_GUEST;
+
+	/* Set a default exit reason */
+	run->exit_reason = KVM_EXIT_UNKNOWN;
+	run->ready_for_interrupt_injection = 1;
+
+	/* Set the appropriate status bits based on host CPU features, before we hit the scheduler */
+	kvm_mips_set_c0_status();
+
+	local_irq_enable();
+
+	kvm_debug("kvm_mips_handle_exit: cause: %#x, PC: %p, kvm_run: %p, kvm_vcpu: %p\n",
+			cause, opc, run, vcpu);
+
+	/* Do a privilege check, if in UM most of these exit conditions end up
+	 * causing an exception to be delivered to the Guest Kernel
+	 */
+	er = kvm_mips_check_privilege(cause, opc, run, vcpu);
+	if (er == EMULATE_PRIV_FAIL) {
+		goto skip_emul;
+	} else if (er == EMULATE_FAIL) {
+		run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+		ret = RESUME_HOST;
+		goto skip_emul;
+	}
+
+	switch (exccode) {
+	case T_INT:
+		kvm_debug("[%d]T_INT @ %p\n", vcpu->vcpu_id, opc);
+
+		++vcpu->stat.int_exits;
+		trace_kvm_exit(vcpu, INT_EXITS);
+
+		if (need_resched()) {
+			cond_resched();
+		}
+
+		ret = RESUME_GUEST;
+		break;
+
+	case T_COP_UNUSABLE:
+		kvm_debug("T_COP_UNUSABLE: @ PC: %p\n", opc);
+
+		++vcpu->stat.cop_unusable_exits;
+		trace_kvm_exit(vcpu, COP_UNUSABLE_EXITS);
+		ret = kvm_mips_callbacks->handle_cop_unusable(vcpu);
+		/* XXXKYMA: Might need to return to user space */
+		if (run->exit_reason == KVM_EXIT_IRQ_WINDOW_OPEN) {
+			ret = RESUME_HOST;
+		}
+		break;
+
+	case T_TLB_MOD:
+		++vcpu->stat.tlbmod_exits;
+		trace_kvm_exit(vcpu, TLBMOD_EXITS);
+		ret = kvm_mips_callbacks->handle_tlb_mod(vcpu);
+		break;
+
+	case T_TLB_ST_MISS:
+		kvm_debug
+		    ("TLB ST fault:  cause %#x, status %#lx, PC: %p, BadVaddr: %#lx\n",
+		     cause, kvm_read_c0_guest_status(vcpu->arch.cop0), opc,
+		     badvaddr);
+
+		++vcpu->stat.tlbmiss_st_exits;
+		trace_kvm_exit(vcpu, TLBMISS_ST_EXITS);
+		ret = kvm_mips_callbacks->handle_tlb_st_miss(vcpu);
+		break;
+
+	case T_TLB_LD_MISS:
+		kvm_debug("TLB LD fault: cause %#x, PC: %p, BadVaddr: %#lx\n",
+			  cause, opc, badvaddr);
+
+		++vcpu->stat.tlbmiss_ld_exits;
+		trace_kvm_exit(vcpu, TLBMISS_LD_EXITS);
+		ret = kvm_mips_callbacks->handle_tlb_ld_miss(vcpu);
+		break;
+
+	case T_ADDR_ERR_ST:
+		++vcpu->stat.addrerr_st_exits;
+		trace_kvm_exit(vcpu, ADDRERR_ST_EXITS);
+		ret = kvm_mips_callbacks->handle_addr_err_st(vcpu);
+		break;
+
+	case T_ADDR_ERR_LD:
+		++vcpu->stat.addrerr_ld_exits;
+		trace_kvm_exit(vcpu, ADDRERR_LD_EXITS);
+		ret = kvm_mips_callbacks->handle_addr_err_ld(vcpu);
+		break;
+
+	case T_SYSCALL:
+		++vcpu->stat.syscall_exits;
+		trace_kvm_exit(vcpu, SYSCALL_EXITS);
+		ret = kvm_mips_callbacks->handle_syscall(vcpu);
+		break;
+
+	case T_RES_INST:
+		++vcpu->stat.resvd_inst_exits;
+		trace_kvm_exit(vcpu, RESVD_INST_EXITS);
+		ret = kvm_mips_callbacks->handle_res_inst(vcpu);
+		break;
+
+	case T_BREAK:
+		++vcpu->stat.break_inst_exits;
+		trace_kvm_exit(vcpu, BREAK_INST_EXITS);
+		ret = kvm_mips_callbacks->handle_break(vcpu);
+		break;
+
+	default:
+		kvm_err
+		    ("Exception Code: %d, not yet handled, @ PC: %p, inst: 0x%08x  BadVaddr: %#lx Status: %#lx\n",
+		     exccode, opc, kvm_get_inst(opc, vcpu), badvaddr,
+		     kvm_read_c0_guest_status(vcpu->arch.cop0));
+		kvm_arch_vcpu_dump_regs(vcpu);
+		run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+		ret = RESUME_HOST;
+		break;
+
+	}
+
+skip_emul:
+	local_irq_disable();
+
+	if (er == EMULATE_DONE && !(ret & RESUME_HOST))
+		kvm_mips_deliver_interrupts(vcpu, cause);
+
+	if (!(ret & RESUME_HOST)) {
+		/* Only check for signals if not already exiting to userspace  */
+		if (signal_pending(current)) {
+			run->exit_reason = KVM_EXIT_INTR;
+			ret = (-EINTR << 2) | RESUME_HOST;
+			++vcpu->stat.signal_exits;
+			trace_kvm_exit(vcpu, SIGNAL_EXITS);
+		}
+	}
+
+	return ret;
+}
+
+int __init kvm_mips_init(void)
+{
+	int ret;
+
+	ret = kvm_init(NULL, sizeof(struct kvm_vcpu), 0, THIS_MODULE);
+
+	if (ret)
+		return ret;
+
+	/* On MIPS, kernel modules are executed from "mapped space", which requires TLBs.
+	 * The TLB handling code is statically linked with the rest of the kernel (kvm_tlb.c)
+	 * to avoid the possibility of double faulting. The issue is that the TLB code
+	 * references routines that are part of the the KVM module,
+	 * which are only available once the module is loaded.
+	 */
+	kvm_mips_gfn_to_pfn = gfn_to_pfn;
+	kvm_mips_release_pfn_clean = kvm_release_pfn_clean;
+	kvm_mips_is_error_pfn = is_error_pfn;
+
+	pr_info("KVM/MIPS Initialized\n");
+	return 0;
+}
+
+void __exit kvm_mips_exit(void)
+{
+	kvm_exit();
+
+	kvm_mips_gfn_to_pfn = NULL;
+	kvm_mips_release_pfn_clean = NULL;
+	kvm_mips_is_error_pfn = NULL;
+
+	pr_info("KVM/MIPS unloaded\n");
+}
+
+module_init(kvm_mips_init);
+module_exit(kvm_mips_exit);
+
+EXPORT_TRACEPOINT_SYMBOL(kvm_exit);
diff --git a/arch/mips/kvm/trace.h b/arch/mips/kvm/trace.h
new file mode 100644
index 0000000..bc9e0f4
--- /dev/null
+++ b/arch/mips/kvm/trace.h
@@ -0,0 +1,46 @@
+/*
+* This file is subject to the terms and conditions of the GNU General Public
+* License.  See the file "COPYING" in the main directory of this archive
+* for more details.
+*
+* Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
+* Authors: Sanjay Lal <sanjayl@kymasys.com>
+*/
+
+#if !defined(_TRACE_KVM_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_KVM_H
+
+#include <linux/tracepoint.h>
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM kvm
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE trace
+
+/*
+ * Tracepoints for VM eists
+ */
+extern char *kvm_mips_exit_types_str[MAX_KVM_MIPS_EXIT_TYPES];
+
+TRACE_EVENT(kvm_exit,
+	    TP_PROTO(struct kvm_vcpu *vcpu, unsigned int reason),
+	    TP_ARGS(vcpu, reason),
+	    TP_STRUCT__entry(
+			__field(struct kvm_vcpu *, vcpu)
+			__field(unsigned int, reason)
+	    ),
+
+	    TP_fast_assign(
+			__entry->vcpu = vcpu;
+			__entry->reason = reason;
+	    ),
+
+	    TP_printk("[%s]PC: 0x%08lx",
+		      kvm_mips_exit_types_str[__entry->reason],
+		      __entry->vcpu->arch.pc)
+);
+
+#endif /* _TRACE_KVM_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
1.7.11.3
