Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jan 2016 15:05:37 +0100 (CET)
Received: from mail.bmw-carit.de ([62.245.222.98]:47587 "EHLO
        linuxmail.bmw-carit.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27010892AbcA2ODio1wnr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Jan 2016 15:03:38 +0100
Received: from localhost (handman.bmw-carit.intra [192.168.101.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linuxmail.bmw-carit.de (Postfix) with ESMTPS id B7A1659CFD;
        Fri, 29 Jan 2016 14:47:32 +0100 (CET)
From:   Daniel Wagner <daniel.wagner@bmw-carit.de>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     linux-fbdev@vger.kernel.org, linux-mips@linux-mips.org,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Maik Broemme <mbroemme@plusserver.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH tip v7 5/7] KVM: use simple waitqueue for vcpu->wq
Date:   Fri, 29 Jan 2016 15:03:26 +0100
Message-Id: <1454076208-28354-6-git-send-email-daniel.wagner@bmw-carit.de>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1454076208-28354-1-git-send-email-daniel.wagner@bmw-carit.de>
References: <1454076208-28354-1-git-send-email-daniel.wagner@bmw-carit.de>
Return-Path: <daniel.wagner@oss.bmw-carit.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51527
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.wagner@bmw-carit.de
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

From: Marcelo Tosatti <mtosatti@redhat.com>

The problem:

On -rt, an emulated LAPIC timer instances has the following path:

1) hard interrupt
2) ksoftirqd is scheduled
3) ksoftirqd wakes up vcpu thread
4) vcpu thread is scheduled

This extra context switch introduces unnecessary latency in the
LAPIC path for a KVM guest.

The solution:

Allow waking up vcpu thread from hardirq context,
thus avoiding the need for ksoftirqd to be scheduled.

Normal waitqueues make use of spinlocks, which on -RT
are sleepable locks. Therefore, waking up a waitqueue
waiter involves locking a sleeping lock, which
is not allowed from hard interrupt context.

cyclictest command line:

This patch reduces the average latency in my tests from 14us to 11us.

Daniel writes:
Paolo asked for numbers from kvm-unit-tests/tscdeadline_latency
benchmark on mainline. The test was run 1000 times on
tip/sched/core 4.4.0-rc8-01134-g0905f04:

  ./x86-run x86/tscdeadline_latency.flat -cpu host

with idle=poll.

The test seems not to deliver really stable numbers though most of
them are smaller. Paolo write:

"Anything above ~10000 cycles means that the host went to C1 or
lower---the number means more or less nothing in that case.

The mean shows an improvement indeed."

Before:

               min             max         mean           std
count  1000.000000     1000.000000  1000.000000   1000.000000
mean   5162.596000  2019270.084000  5824.491541  20681.645558
std      75.431231   622607.723969    89.575700   6492.272062
min    4466.000000    23928.000000  5537.926500    585.864966
25%    5163.000000  1613252.750000  5790.132275  16683.745433
50%    5175.000000  2281919.000000  5834.654000  23151.990026
75%    5190.000000  2382865.750000  5861.412950  24148.206168
max    5228.000000  4175158.000000  6254.827300  46481.048691

After
               min            max         mean           std
count  1000.000000     1000.00000  1000.000000   1000.000000
mean   5143.511000  2076886.10300  5813.312474  21207.357565
std      77.668322   610413.09583    86.541500   6331.915127
min    4427.000000    25103.00000  5529.756600    559.187707
25%    5148.000000  1691272.75000  5784.889825  17473.518244
50%    5160.000000  2308328.50000  5832.025000  23464.837068
75%    5172.000000  2393037.75000  5853.177675  24223.969976
max    5222.000000  3922458.00000  6186.720500  42520.379830

[Patch was originaly based on the swait implementation found in the -rt
 tree. Daniel ported it to mainline's version and gathered the
 benchmark numbers for tscdeadline_latency test.]

Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/arm/kvm/arm.c                  |  8 ++++----
 arch/arm/kvm/psci.c                 |  4 ++--
 arch/mips/kvm/mips.c                |  8 ++++----
 arch/powerpc/include/asm/kvm_host.h |  4 ++--
 arch/powerpc/kvm/book3s_hv.c        | 23 +++++++++++------------
 arch/s390/include/asm/kvm_host.h    |  2 +-
 arch/s390/kvm/interrupt.c           |  4 ++--
 arch/x86/kvm/lapic.c                |  6 +++---
 include/linux/kvm_host.h            |  5 +++--
 virt/kvm/async_pf.c                 |  4 ++--
 virt/kvm/kvm_main.c                 | 17 ++++++++---------
 11 files changed, 42 insertions(+), 43 deletions(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index e06fd29..f7e3235 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -498,18 +498,18 @@ static void kvm_arm_resume_guest(struct kvm *kvm)
 	struct kvm_vcpu *vcpu;
 
 	kvm_for_each_vcpu(i, vcpu, kvm) {
-		wait_queue_head_t *wq = kvm_arch_vcpu_wq(vcpu);
+		struct swait_queue_head *wq = kvm_arch_vcpu_wq(vcpu);
 
 		vcpu->arch.pause = false;
-		wake_up_interruptible(wq);
+		swake_up(wq);
 	}
 }
 
 static void vcpu_sleep(struct kvm_vcpu *vcpu)
 {
-	wait_queue_head_t *wq = kvm_arch_vcpu_wq(vcpu);
+	struct swait_queue_head *wq = kvm_arch_vcpu_wq(vcpu);
 
-	wait_event_interruptible(*wq, ((!vcpu->arch.power_off) &&
+	swait_event_interruptible(*wq, ((!vcpu->arch.power_off) &&
 				       (!vcpu->arch.pause)));
 }
 
diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
index a9b3b90..c2b1315 100644
--- a/arch/arm/kvm/psci.c
+++ b/arch/arm/kvm/psci.c
@@ -70,7 +70,7 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
 {
 	struct kvm *kvm = source_vcpu->kvm;
 	struct kvm_vcpu *vcpu = NULL;
-	wait_queue_head_t *wq;
+	struct swait_queue_head *wq;
 	unsigned long cpu_id;
 	unsigned long context_id;
 	phys_addr_t target_pc;
@@ -119,7 +119,7 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
 	smp_mb();		/* Make sure the above is visible */
 
 	wq = kvm_arch_vcpu_wq(vcpu);
-	wake_up_interruptible(wq);
+	swake_up(wq);
 
 	return PSCI_RET_SUCCESS;
 }
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index b9b803f..28e9acb 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -445,8 +445,8 @@ int kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu,
 
 	dvcpu->arch.wait = 0;
 
-	if (waitqueue_active(&dvcpu->wq))
-		wake_up_interruptible(&dvcpu->wq);
+	if (swait_active(&dvcpu->wq))
+		swake_up(&dvcpu->wq);
 
 	return 0;
 }
@@ -1174,8 +1174,8 @@ static void kvm_mips_comparecount_func(unsigned long data)
 	kvm_mips_callbacks->queue_timer_int(vcpu);
 
 	vcpu->arch.wait = 0;
-	if (waitqueue_active(&vcpu->wq))
-		wake_up_interruptible(&vcpu->wq);
+	if (swait_active(&vcpu->wq))
+		swake_up(&vcpu->wq);
 }
 
 /* low level hrtimer wake routine */
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index cfa758c..f8673ff 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -286,7 +286,7 @@ struct kvmppc_vcore {
 	struct list_head runnable_threads;
 	struct list_head preempt_list;
 	spinlock_t lock;
-	wait_queue_head_t wq;
+	struct swait_queue_head wq;
 	spinlock_t stoltb_lock;	/* protects stolen_tb and preempt_tb */
 	u64 stolen_tb;
 	u64 preempt_tb;
@@ -626,7 +626,7 @@ struct kvm_vcpu_arch {
 	u8 prodded;
 	u32 last_inst;
 
-	wait_queue_head_t *wqp;
+	struct swait_queue_head *wqp;
 	struct kvmppc_vcore *vcore;
 	int ret;
 	int trap;
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index a7352b5..df34a64 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -114,11 +114,11 @@ static bool kvmppc_ipi_thread(int cpu)
 static void kvmppc_fast_vcpu_kick_hv(struct kvm_vcpu *vcpu)
 {
 	int cpu;
-	wait_queue_head_t *wqp;
+	struct swait_queue_head *wqp;
 
 	wqp = kvm_arch_vcpu_wq(vcpu);
-	if (waitqueue_active(wqp)) {
-		wake_up_interruptible(wqp);
+	if (swait_active(wqp)) {
+		swake_up(wqp);
 		++vcpu->stat.halt_wakeup;
 	}
 
@@ -707,8 +707,8 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
 		tvcpu->arch.prodded = 1;
 		smp_mb();
 		if (vcpu->arch.ceded) {
-			if (waitqueue_active(&vcpu->wq)) {
-				wake_up_interruptible(&vcpu->wq);
+			if (swait_active(&vcpu->wq)) {
+				swake_up(&vcpu->wq);
 				vcpu->stat.halt_wakeup++;
 			}
 		}
@@ -1447,7 +1447,7 @@ static struct kvmppc_vcore *kvmppc_vcore_create(struct kvm *kvm, int core)
 	INIT_LIST_HEAD(&vcore->runnable_threads);
 	spin_lock_init(&vcore->lock);
 	spin_lock_init(&vcore->stoltb_lock);
-	init_waitqueue_head(&vcore->wq);
+	init_swait_queue_head(&vcore->wq);
 	vcore->preempt_tb = TB_NIL;
 	vcore->lpcr = kvm->arch.lpcr;
 	vcore->first_vcpuid = core * threads_per_subcore;
@@ -2519,10 +2519,9 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
 {
 	struct kvm_vcpu *vcpu;
 	int do_sleep = 1;
+	DECLARE_SWAITQUEUE(wait);
 
-	DEFINE_WAIT(wait);
-
-	prepare_to_wait(&vc->wq, &wait, TASK_INTERRUPTIBLE);
+	prepare_to_swait(&vc->wq, &wait, TASK_INTERRUPTIBLE);
 
 	/*
 	 * Check one last time for pending exceptions and ceded state after
@@ -2536,7 +2535,7 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
 	}
 
 	if (!do_sleep) {
-		finish_wait(&vc->wq, &wait);
+		finish_swait(&vc->wq, &wait);
 		return;
 	}
 
@@ -2544,7 +2543,7 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
 	trace_kvmppc_vcore_blocked(vc, 0);
 	spin_unlock(&vc->lock);
 	schedule();
-	finish_wait(&vc->wq, &wait);
+	finish_swait(&vc->wq, &wait);
 	spin_lock(&vc->lock);
 	vc->vcore_state = VCORE_INACTIVE;
 	trace_kvmppc_vcore_blocked(vc, 1);
@@ -2600,7 +2599,7 @@ static int kvmppc_run_vcpu(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 			kvmppc_start_thread(vcpu, vc);
 			trace_kvm_guest_enter(vcpu);
 		} else if (vc->vcore_state == VCORE_SLEEPING) {
-			wake_up(&vc->wq);
+			swake_up(&vc->wq);
 		}
 
 	}
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index efaac2c..c66831f 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -427,7 +427,7 @@ struct kvm_s390_irq_payload {
 struct kvm_s390_local_interrupt {
 	spinlock_t lock;
 	struct kvm_s390_float_interrupt *float_int;
-	wait_queue_head_t *wq;
+	struct swait_queue_head *wq;
 	atomic_t *cpuflags;
 	DECLARE_BITMAP(sigp_emerg_pending, KVM_MAX_VCPUS);
 	struct kvm_s390_irq_payload irq;
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 6a75352..cc862c4 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -868,13 +868,13 @@ no_timer:
 
 void kvm_s390_vcpu_wakeup(struct kvm_vcpu *vcpu)
 {
-	if (waitqueue_active(&vcpu->wq)) {
+	if (swait_active(&vcpu->wq)) {
 		/*
 		 * The vcpu gave up the cpu voluntarily, mark it as a good
 		 * yield-candidate.
 		 */
 		vcpu->preempted = true;
-		wake_up_interruptible(&vcpu->wq);
+		swake_up(&vcpu->wq);
 		vcpu->stat.halt_wakeup++;
 	}
 }
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 4d30b86..34dc14f 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1195,7 +1195,7 @@ static void apic_update_lvtt(struct kvm_lapic *apic)
 static void apic_timer_expired(struct kvm_lapic *apic)
 {
 	struct kvm_vcpu *vcpu = apic->vcpu;
-	wait_queue_head_t *q = &vcpu->wq;
+	struct swait_queue_head *q = &vcpu->wq;
 	struct kvm_timer *ktimer = &apic->lapic_timer;
 
 	if (atomic_read(&apic->lapic_timer.pending))
@@ -1204,8 +1204,8 @@ static void apic_timer_expired(struct kvm_lapic *apic)
 	atomic_inc(&apic->lapic_timer.pending);
 	kvm_set_pending_timer(vcpu);
 
-	if (waitqueue_active(q))
-		wake_up_interruptible(q);
+	if (swait_active(q))
+		swake_up(q);
 
 	if (apic_lvtt_tscdeadline(apic))
 		ktimer->expired_tscdeadline = ktimer->tscdeadline;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index c923350..c690acc 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -25,6 +25,7 @@
 #include <linux/irqflags.h>
 #include <linux/context_tracking.h>
 #include <linux/irqbypass.h>
+#include <linux/swait.h>
 #include <asm/signal.h>
 
 #include <linux/kvm.h>
@@ -243,7 +244,7 @@ struct kvm_vcpu {
 	int fpu_active;
 	int guest_fpu_loaded, guest_xcr0_loaded;
 	unsigned char fpu_counter;
-	wait_queue_head_t wq;
+	struct swait_queue_head wq;
 	struct pid *pid;
 	int sigset_active;
 	sigset_t sigset;
@@ -794,7 +795,7 @@ static inline bool kvm_arch_has_assigned_device(struct kvm *kvm)
 }
 #endif
 
-static inline wait_queue_head_t *kvm_arch_vcpu_wq(struct kvm_vcpu *vcpu)
+static inline struct swait_queue_head *kvm_arch_vcpu_wq(struct kvm_vcpu *vcpu)
 {
 #ifdef __KVM_HAVE_ARCH_WQP
 	return vcpu->arch.wqp;
diff --git a/virt/kvm/async_pf.c b/virt/kvm/async_pf.c
index 77d42be..cd8477c 100644
--- a/virt/kvm/async_pf.c
+++ b/virt/kvm/async_pf.c
@@ -98,8 +98,8 @@ static void async_pf_execute(struct work_struct *work)
 	 * This memory barrier pairs with prepare_to_wait's set_current_state()
 	 */
 	smp_mb();
-	if (waitqueue_active(&vcpu->wq))
-		wake_up_interruptible(&vcpu->wq);
+	if (swait_active(&vcpu->wq))
+		swake_up(&vcpu->wq);
 
 	mmput(mm);
 	kvm_put_kvm(vcpu->kvm);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 484079e..43fad2e 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -226,8 +226,7 @@ int kvm_vcpu_init(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned id)
 	vcpu->kvm = kvm;
 	vcpu->vcpu_id = id;
 	vcpu->pid = NULL;
-	vcpu->halt_poll_ns = 0;
-	init_waitqueue_head(&vcpu->wq);
+	init_swait_queue_head(&vcpu->wq);
 	kvm_async_pf_vcpu_init(vcpu);
 
 	vcpu->pre_pcpu = -1;
@@ -1999,7 +1998,7 @@ static int kvm_vcpu_check_block(struct kvm_vcpu *vcpu)
 void kvm_vcpu_block(struct kvm_vcpu *vcpu)
 {
 	ktime_t start, cur;
-	DEFINE_WAIT(wait);
+	DECLARE_SWAITQUEUE(wait);
 	bool waited = false;
 	u64 block_ns;
 
@@ -2024,7 +2023,7 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
 	kvm_arch_vcpu_blocking(vcpu);
 
 	for (;;) {
-		prepare_to_wait(&vcpu->wq, &wait, TASK_INTERRUPTIBLE);
+		prepare_to_swait(&vcpu->wq, &wait, TASK_INTERRUPTIBLE);
 
 		if (kvm_vcpu_check_block(vcpu) < 0)
 			break;
@@ -2033,7 +2032,7 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
 		schedule();
 	}
 
-	finish_wait(&vcpu->wq, &wait);
+	finish_swait(&vcpu->wq, &wait);
 	cur = ktime_get();
 
 	kvm_arch_vcpu_unblocking(vcpu);
@@ -2065,11 +2064,11 @@ void kvm_vcpu_kick(struct kvm_vcpu *vcpu)
 {
 	int me;
 	int cpu = vcpu->cpu;
-	wait_queue_head_t *wqp;
+	struct swait_queue_head *wqp;
 
 	wqp = kvm_arch_vcpu_wq(vcpu);
-	if (waitqueue_active(wqp)) {
-		wake_up_interruptible(wqp);
+	if (swait_active(wqp)) {
+		swake_up(wqp);
 		++vcpu->stat.halt_wakeup;
 	}
 
@@ -2170,7 +2169,7 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me)
 				continue;
 			if (vcpu == me)
 				continue;
-			if (waitqueue_active(&vcpu->wq) && !kvm_arch_vcpu_runnable(vcpu))
+			if (swait_active(&vcpu->wq) && !kvm_arch_vcpu_runnable(vcpu))
 				continue;
 			if (!kvm_vcpu_eligible_for_directed_yield(vcpu))
 				continue;
-- 
2.5.0
