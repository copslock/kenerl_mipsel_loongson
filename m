Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 May 2013 07:50:31 +0200 (CEST)
Received: from kymasys.com ([64.62.140.43]:51253 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6825887Ab3ESFsYQbxwu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 19 May 2013 07:48:24 +0200
Received: from agni.kymasys.com ([75.40.23.192]) by kymasys.com for <linux-mips@linux-mips.org>; Sat, 18 May 2013 22:48:15 -0700
Received: by agni.kymasys.com (Postfix, from userid 500)
        id 4D39B630065; Sat, 18 May 2013 22:47:43 -0700 (PDT)
From:   Sanjay Lal <sanjayl@kymasys.com>
To:     kvm@vger.kernel.org
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Gleb Natapov <gleb@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Sanjay Lal <sanjayl@kymasys.com>
Subject: [PATCH 13/18] KVM/MIPS32-VZ: Top level handler for Guest faults
Date:   Sat, 18 May 2013 22:47:35 -0700
Message-Id: <1368942460-15577-14-git-send-email-sanjayl@kymasys.com>
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1368942460-15577-1-git-send-email-sanjayl@kymasys.com>
References: <n>
 <1368942460-15577-1-git-send-email-sanjayl@kymasys.com>
Return-Path: <sanjayl@kymasys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36462
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

- Add VZ specific VM Exit reasons to the traces.
- Add top level handler for Guest Exit exceptions.

Signed-off-by: Sanjay Lal <sanjayl@kymasys.com>
---
 arch/mips/kvm/kvm_mips.c | 73 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 53 insertions(+), 20 deletions(-)

diff --git a/arch/mips/kvm/kvm_mips.c b/arch/mips/kvm/kvm_mips.c
index e0dad02..cad9112 100644
--- a/arch/mips/kvm/kvm_mips.c
+++ b/arch/mips/kvm/kvm_mips.c
@@ -18,6 +18,9 @@
 #include <asm/page.h>
 #include <asm/cacheflush.h>
 #include <asm/mmu_context.h>
+#ifdef CONFIG_KVM_MIPS_VZ
+#include <asm/mipsvzregs.h>
+#endif
 
 #include <linux/kvm_host.h>
 
@@ -47,6 +50,21 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{ "resvd_inst", VCPU_STAT(resvd_inst_exits) },
 	{ "break_inst", VCPU_STAT(break_inst_exits) },
 	{ "flush_dcache", VCPU_STAT(flush_dcache_exits) },
+#ifdef CONFIG_KVM_MIPS_VZ
+	{ "hypervisor_gpsi", VCPU_STAT(hypervisor_gpsi_exits) },
+	{ "hypervisor_gpsi_cp0", VCPU_STAT(hypervisor_gpsi_cp0_exits) },
+	{ "hypervisor_gpsi_cache", VCPU_STAT(hypervisor_gpsi_cache_exits) },
+	{ "hypervisor_gsfc", VCPU_STAT(hypervisor_gsfc_exits) },
+	{ "hypervisor_gsfc_cp0_status", VCPU_STAT(hypervisor_gsfc_cp0_status_exits) },
+	{ "hypervisor_gsfc_cp0_cause", VCPU_STAT(hypervisor_gsfc_cp0_cause_exits) },
+	{ "hypervisor_gsfc_cp0_intctl", VCPU_STAT(hypervisor_gsfc_cp0_intctl_exits) },
+	{ "hypervisor_hc", VCPU_STAT(hypervisor_hc_exits) },
+	{ "hypervisor_grr", VCPU_STAT(hypervisor_grr_exits) },
+	{ "hypervisor_gva", VCPU_STAT(hypervisor_gva_exits) },
+	{ "hypervisor_ghfc", VCPU_STAT(hypervisor_ghfc_exits) },
+	{ "hypervisor_gpa", VCPU_STAT(hypervisor_gpa_exits) },
+	{ "hypervisor_resv", VCPU_STAT(hypervisor_resv_exits) },
+#endif
 	{ "halt_wakeup", VCPU_STAT(halt_wakeup) },
 	{NULL}
 };
@@ -57,6 +75,9 @@ static int kvm_mips_reset_vcpu(struct kvm_vcpu *vcpu)
 	for_each_possible_cpu(i) {
 		vcpu->arch.guest_kernel_asid[i] = 0;
 		vcpu->arch.guest_user_asid[i] = 0;
+#ifdef CONFIG_KVM_MIPS_VZ
+		vcpu->arch.vzguestid[i] = 0;
+#endif
 	}
 	return 0;
 }
@@ -106,7 +127,7 @@ void kvm_arch_check_processor_compat(void *rtn)
 
 static void kvm_mips_init_tlbs(struct kvm *kvm)
 {
-	unsigned long wired;
+	ulong wired;
 
 	/* Add a wired entry to the TLB, it is used to map the commpage to the Guest kernel */
 	wired = read_c0_wired();
@@ -209,19 +230,19 @@ int kvm_arch_create_memslot(struct kvm_memory_slot *slot, unsigned long npages)
 }
 
 int kvm_arch_prepare_memory_region(struct kvm *kvm,
-                                struct kvm_memory_slot *memslot,
-                                struct kvm_userspace_memory_region *mem,
-                                enum kvm_mr_change change)
+				   struct kvm_memory_slot *memslot,
+				   struct kvm_userspace_memory_region *mem,
+				   enum kvm_mr_change change)
 {
 	return 0;
 }
 
 void kvm_arch_commit_memory_region(struct kvm *kvm,
-                                struct kvm_userspace_memory_region *mem,
-                                const struct kvm_memory_slot *old,
-                                enum kvm_mr_change change)
+				   struct kvm_userspace_memory_region *mem,
+				   const struct kvm_memory_slot *old,
+				   enum kvm_mr_change change)
 {
-	unsigned long npages = 0;
+	ulong npages = 0;
 	int i, err = 0;
 
 	kvm_debug("%s: kvm: %p slot: %d, GPA: %llx, size: %llx, QVA: %llx\n",
@@ -236,7 +257,7 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 		if (npages) {
 			kvm->arch.guest_pmap_npages = npages;
 			kvm->arch.guest_pmap =
-			    kzalloc(npages * sizeof(unsigned long), GFP_KERNEL);
+			    kzalloc(npages * sizeof(ulong), GFP_KERNEL);
 
 			if (!kvm->arch.guest_pmap) {
 				kvm_err("Failed to allocate guest PMAP");
@@ -345,7 +366,7 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm, unsigned int id)
 	       mips32_GuestExceptionEnd - mips32_GuestException);
 
 	/* Invalidate the icache for these ranges */
-	mips32_SyncICache((unsigned long) gebase, ALIGN(size, PAGE_SIZE));
+	mips32_SyncICache((ulong) gebase, ALIGN(size, PAGE_SIZE));
 
 	/* Allocate comm page for guest kernel, a TLB will be reserved for mapping GVA @ 0xFFFF8000 to this page */
 	vcpu->arch.kseg0_commpage = kzalloc(PAGE_SIZE << 1, GFP_KERNEL);
@@ -376,6 +397,12 @@ out:
 	return ERR_PTR(err);
 }
 
+int kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
+{
+	return 0;
+}
+
+
 void kvm_arch_vcpu_free(struct kvm_vcpu *vcpu)
 {
 	hrtimer_cancel(&vcpu->arch.comparecount_timer);
@@ -527,7 +554,7 @@ out:
 int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
 {
 	struct kvm_memory_slot *memslot;
-	unsigned long ga, ga_end;
+	ulong ga, ga_end;
 	int is_dirty = 0;
 	int r;
 	unsigned long n;
@@ -602,11 +629,6 @@ kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 	return -ENOTSUPP;
 }
 
-int kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
-{
-	return 0;
-}
-
 int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 {
 	return -ENOTSUPP;
@@ -630,6 +652,11 @@ int kvm_dev_ioctl_check_extension(long ext)
 	case KVM_CAP_COALESCED_MMIO:
 		r = KVM_COALESCED_MMIO_PAGE_OFFSET;
 		break;
+#ifdef CONFIG_KVM_MIPS_VZ
+	case KVM_CAP_MIPS_VZ_ASE:
+		r = cpu_has_vz;
+		break;
+#endif
 	default:
 		r = 0;
 		break;
@@ -721,7 +748,7 @@ enum hrtimer_restart kvm_mips_comparecount_wakeup(struct hrtimer *timer)
 	struct kvm_vcpu *vcpu;
 
 	vcpu = container_of(timer, struct kvm_vcpu, arch.comparecount_timer);
-	kvm_mips_comparecount_func((unsigned long) vcpu);
+	kvm_mips_comparecount_func((ulong) vcpu);
 	hrtimer_forward_now(&vcpu->arch.comparecount_timer,
 			    ktime_set(0, MS_TO_NS(10)));
 	return HRTIMER_RESTART;
@@ -776,14 +803,13 @@ int kvm_mips_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
 	uint32_t cause = vcpu->arch.host_cp0_cause;
 	uint32_t exccode = (cause >> CAUSEB_EXCCODE) & 0x1f;
-	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.pc;
-	unsigned long badvaddr = vcpu->arch.host_cp0_badvaddr;
+	uint32_t *opc = (uint32_t *) vcpu->arch.pc;
+	ulong badvaddr = vcpu->arch.host_cp0_badvaddr;
 	enum emulation_result er = EMULATE_DONE;
 	int ret = RESUME_GUEST;
 
 	/* Set a default exit reason */
 	run->exit_reason = KVM_EXIT_UNKNOWN;
-	run->ready_for_interrupt_injection = 1;
 
 	/* Set the appropriate status bits based on host CPU features, before we hit the scheduler */
 	kvm_mips_set_c0_status();
@@ -887,6 +913,13 @@ int kvm_mips_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
 		ret = kvm_mips_callbacks->handle_break(vcpu);
 		break;
 
+#ifdef CONFIG_KVM_MIPS_VZ
+	case T_GUEST_EXIT:
+		/* defer exit accounting to handler */
+		ret = kvm_mips_callbacks->handle_guest_exit(vcpu);
+		break;
+
+#endif
 	default:
 		kvm_err
 		    ("Exception Code: %d, not yet handled, @ PC: %p, inst: 0x%08x  BadVaddr: %#lx Status: %#lx\n",
-- 
1.7.11.3
