Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jan 2016 15:05:20 +0100 (CET)
Received: from mail.bmw-carit.de ([62.245.222.98]:47569 "EHLO
        linuxmail.bmw-carit.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27010812AbcA2ODicJ-pr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Jan 2016 15:03:38 +0100
Received: from localhost (handman.bmw-carit.intra [192.168.101.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linuxmail.bmw-carit.de (Postfix) with ESMTPS id DBD1259CFE;
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
Subject: [PATCH tip v7 6/7] rcu: Do not call rcu_nocb_gp_cleanup() while holding rnp->lock
Date:   Fri, 29 Jan 2016 15:03:27 +0100
Message-Id: <1454076208-28354-7-git-send-email-daniel.wagner@bmw-carit.de>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1454076208-28354-1-git-send-email-daniel.wagner@bmw-carit.de>
References: <1454076208-28354-1-git-send-email-daniel.wagner@bmw-carit.de>
Return-Path: <daniel.wagner@oss.bmw-carit.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51526
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

rcu_nocb_gp_cleanup() is called while holding rnp->lock. Currently,
this is okay because the wake_up_all() in rcu_nocb_gp_cleanup() will
not enable the IRQs. lockdep is happy.

By switching over using swait this is not true anymore. swake_up_all()
enables the IRQs while processing the waiters. __do_softirq() can now
run and will eventually call rcu_process_callbacks() which wants to
grap nrp->lock.

Let's move the rcu_nocb_gp_cleanup() call outside the lock before we
switch over to swait.

If we would hold the rnp->lock and use swait, lockdep reports
following:

 =================================
 [ INFO: inconsistent lock state ]
 4.2.0-rc5-00025-g9a73ba0 #136 Not tainted
 ---------------------------------
 inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
 rcu_preempt/8 [HC0[0]:SC0[0]:HE1:SE1] takes:
  (rcu_node_1){+.?...}, at: [<ffffffff811387c7>] rcu_gp_kthread+0xb97/0xeb0
 {IN-SOFTIRQ-W} state was registered at:
   [<ffffffff81109b9f>] __lock_acquire+0xd5f/0x21e0
   [<ffffffff8110be0f>] lock_acquire+0xdf/0x2b0
   [<ffffffff81841cc9>] _raw_spin_lock_irqsave+0x59/0xa0
   [<ffffffff81136991>] rcu_process_callbacks+0x141/0x3c0
   [<ffffffff810b1a9d>] __do_softirq+0x14d/0x670
   [<ffffffff810b2214>] irq_exit+0x104/0x110
   [<ffffffff81844e96>] smp_apic_timer_interrupt+0x46/0x60
   [<ffffffff81842e70>] apic_timer_interrupt+0x70/0x80
   [<ffffffff810dba66>] rq_attach_root+0xa6/0x100
   [<ffffffff810dbc2d>] cpu_attach_domain+0x16d/0x650
   [<ffffffff810e4b42>] build_sched_domains+0x942/0xb00
   [<ffffffff821777c2>] sched_init_smp+0x509/0x5c1
   [<ffffffff821551e3>] kernel_init_freeable+0x172/0x28f
   [<ffffffff8182cdce>] kernel_init+0xe/0xe0
   [<ffffffff8184231f>] ret_from_fork+0x3f/0x70
 irq event stamp: 76
 hardirqs last  enabled at (75): [<ffffffff81841330>] _raw_spin_unlock_irq+0x30/0x60
 hardirqs last disabled at (76): [<ffffffff8184116f>] _raw_spin_lock_irq+0x1f/0x90
 softirqs last  enabled at (0): [<ffffffff810a8df2>] copy_process.part.26+0x602/0x1cf0
 softirqs last disabled at (0): [<          (null)>]           (null)
 other info that might help us debug this:
  Possible unsafe locking scenario:
        CPU0
        ----
   lock(rcu_node_1);
   <Interrupt>
     lock(rcu_node_1);
  *** DEADLOCK ***
 1 lock held by rcu_preempt/8:
  #0:  (rcu_node_1){+.?...}, at: [<ffffffff811387c7>] rcu_gp_kthread+0xb97/0xeb0
 stack backtrace:
 CPU: 0 PID: 8 Comm: rcu_preempt Not tainted 4.2.0-rc5-00025-g9a73ba0 #136
 Hardware name: Dell Inc. PowerEdge R820/066N7P, BIOS 2.0.20 01/16/2014
  0000000000000000 000000006d7e67d8 ffff881fb081fbd8 ffffffff818379e0
  0000000000000000 ffff881fb0812a00 ffff881fb081fc38 ffffffff8110813b
  0000000000000000 0000000000000001 ffff881f00000001 ffffffff8102fa4f
 Call Trace:
  [<ffffffff818379e0>] dump_stack+0x4f/0x7b
  [<ffffffff8110813b>] print_usage_bug+0x1db/0x1e0
  [<ffffffff8102fa4f>] ? save_stack_trace+0x2f/0x50
  [<ffffffff811087ad>] mark_lock+0x66d/0x6e0
  [<ffffffff81107790>] ? check_usage_forwards+0x150/0x150
  [<ffffffff81108898>] mark_held_locks+0x78/0xa0
  [<ffffffff81841330>] ? _raw_spin_unlock_irq+0x30/0x60
  [<ffffffff81108a28>] trace_hardirqs_on_caller+0x168/0x220
  [<ffffffff81108aed>] trace_hardirqs_on+0xd/0x10
  [<ffffffff81841330>] _raw_spin_unlock_irq+0x30/0x60
  [<ffffffff810fd1c7>] swake_up_all+0xb7/0xe0
  [<ffffffff811386e1>] rcu_gp_kthread+0xab1/0xeb0
  [<ffffffff811089bf>] ? trace_hardirqs_on_caller+0xff/0x220
  [<ffffffff81841341>] ? _raw_spin_unlock_irq+0x41/0x60
  [<ffffffff81137c30>] ? rcu_barrier+0x20/0x20
  [<ffffffff810d2014>] kthread+0x104/0x120
  [<ffffffff81841330>] ? _raw_spin_unlock_irq+0x30/0x60
  [<ffffffff810d1f10>] ? kthread_create_on_node+0x260/0x260
  [<ffffffff8184231f>] ret_from_fork+0x3f/0x70
  [<ffffffff810d1f10>] ? kthread_create_on_node+0x260/0x260

Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/rcu/tree.c        |  4 +++-
 kernel/rcu/tree.h        |  3 ++-
 kernel/rcu/tree_plugin.h | 16 +++++++++++++---
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f07343b..baf6d09 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1590,7 +1590,6 @@ static int rcu_future_gp_cleanup(struct rcu_state *rsp, struct rcu_node *rnp)
 	int needmore;
 	struct rcu_data *rdp = this_cpu_ptr(rsp->rda);
 
-	rcu_nocb_gp_cleanup(rsp, rnp);
 	rnp->need_future_gp[c & 0x1] = 0;
 	needmore = rnp->need_future_gp[(c + 1) & 0x1];
 	trace_rcu_future_gp(rnp, rdp, c,
@@ -1991,6 +1990,7 @@ static void rcu_gp_cleanup(struct rcu_state *rsp)
 	int nocb = 0;
 	struct rcu_data *rdp;
 	struct rcu_node *rnp = rcu_get_root(rsp);
+	wait_queue_head_t *sq;
 
 	WRITE_ONCE(rsp->gp_activity, jiffies);
 	raw_spin_lock_irq(&rnp->lock);
@@ -2029,7 +2029,9 @@ static void rcu_gp_cleanup(struct rcu_state *rsp)
 			needgp = __note_gp_changes(rsp, rnp, rdp) || needgp;
 		/* smp_mb() provided by prior unlock-lock pair. */
 		nocb += rcu_future_gp_cleanup(rsp, rnp);
+		sq = rcu_nocb_gp_get(rnp);
 		raw_spin_unlock_irq(&rnp->lock);
+		rcu_nocb_gp_cleanup(sq);
 		cond_resched_rcu_qs();
 		WRITE_ONCE(rsp->gp_activity, jiffies);
 		rcu_gp_slow(rsp, gp_cleanup_delay);
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 9fb4e23..aa47e2c 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -607,7 +607,8 @@ static void zero_cpu_stall_ticks(struct rcu_data *rdp);
 static void increment_cpu_stall_ticks(void);
 static bool rcu_nocb_cpu_needs_barrier(struct rcu_state *rsp, int cpu);
 static void rcu_nocb_gp_set(struct rcu_node *rnp, int nrq);
-static void rcu_nocb_gp_cleanup(struct rcu_state *rsp, struct rcu_node *rnp);
+static wait_queue_head_t *rcu_nocb_gp_get(struct rcu_node *rnp);
+static void rcu_nocb_gp_cleanup(wait_queue_head_t *sq);
 static void rcu_init_one_nocb(struct rcu_node *rnp);
 static bool __call_rcu_nocb(struct rcu_data *rdp, struct rcu_head *rhp,
 			    bool lazy, unsigned long flags);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 630c197..99b1ce6 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1822,9 +1822,9 @@ early_param("rcu_nocb_poll", parse_rcu_nocb_poll);
  * Wake up any no-CBs CPUs' kthreads that were waiting on the just-ended
  * grace period.
  */
-static void rcu_nocb_gp_cleanup(struct rcu_state *rsp, struct rcu_node *rnp)
+static void rcu_nocb_gp_cleanup(wait_queue_head_t *sq)
 {
-	wake_up_all(&rnp->nocb_gp_wq[rnp->completed & 0x1]);
+	wake_up_all(sq);
 }
 
 /*
@@ -1840,6 +1840,11 @@ static void rcu_nocb_gp_set(struct rcu_node *rnp, int nrq)
 	rnp->need_future_gp[(rnp->completed + 1) & 0x1] += nrq;
 }
 
+static wait_queue_head_t *rcu_nocb_gp_get(struct rcu_node *rnp)
+{
+	return &rnp->nocb_gp_wq[rnp->completed & 0x1];
+}
+
 static void rcu_init_one_nocb(struct rcu_node *rnp)
 {
 	init_waitqueue_head(&rnp->nocb_gp_wq[0]);
@@ -2514,7 +2519,7 @@ static bool rcu_nocb_cpu_needs_barrier(struct rcu_state *rsp, int cpu)
 	return false;
 }
 
-static void rcu_nocb_gp_cleanup(struct rcu_state *rsp, struct rcu_node *rnp)
+static void rcu_nocb_gp_cleanup(wait_queue_head_t *sq)
 {
 }
 
@@ -2522,6 +2527,11 @@ static void rcu_nocb_gp_set(struct rcu_node *rnp, int nrq)
 {
 }
 
+static wait_queue_head_t *rcu_nocb_gp_get(struct rcu_node *rnp)
+{
+	return NULL;
+}
+
 static void rcu_init_one_nocb(struct rcu_node *rnp)
 {
 }
-- 
2.5.0
