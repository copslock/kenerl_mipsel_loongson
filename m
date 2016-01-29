Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jan 2016 15:04:38 +0100 (CET)
Received: from mail.bmw-carit.de ([62.245.222.98]:47546 "EHLO
        linuxmail.bmw-carit.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27010702AbcA2ODdRy39r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Jan 2016 15:03:33 +0100
Received: from localhost (handman.bmw-carit.intra [192.168.101.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linuxmail.bmw-carit.de (Postfix) with ESMTPS id 733EC59CFB;
        Fri, 29 Jan 2016 14:47:27 +0100 (CET)
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
Subject: [PATCH tip v7 3/7] wait.[ch]: Introduce the simple waitqueue (swait) implementation
Date:   Fri, 29 Jan 2016 15:03:24 +0100
Message-Id: <1454076208-28354-4-git-send-email-daniel.wagner@bmw-carit.de>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1454076208-28354-1-git-send-email-daniel.wagner@bmw-carit.de>
References: <1454076208-28354-1-git-send-email-daniel.wagner@bmw-carit.de>
Return-Path: <daniel.wagner@oss.bmw-carit.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51524
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

From: "Peter Zijlstra (Intel)" <peterz@infradead.org>

The existing wait queue support has support for custom wake up call
backs, wake flags, wake key (passed to call back) and exclusive
flags that allow wakers to be tagged as exclusive, for limiting
the number of wakers.

In a lot of cases, none of these features are used, and hence we
can benefit from a slimmed down version that lowers memory overhead
and reduces runtime overhead.

The concept originated from -rt, where waitqueues are a constant
source of trouble, as we can't convert the head lock to a raw
spinlock due to fancy and long lasting callbacks.

With the removal of custom callbacks, we can use a raw lock for
queue list manipulations, hence allowing the simple wait support
to be used in -rt.

Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Originally-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>

[Patch is from PeterZ which is based on Thomas version.
 Commit message is written by Paul G.
 Daniel:
  -  And some compile issues fixed.
  -  Added non-lazy implementation of swake_up_locked as suggested by Boqun Feng.]
---
 include/linux/swait.h | 172 ++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/Makefile |   2 +-
 kernel/sched/swait.c  | 123 ++++++++++++++++++++++++++++++++++++
 3 files changed, 296 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/swait.h
 create mode 100644 kernel/sched/swait.c

diff --git a/include/linux/swait.h b/include/linux/swait.h
new file mode 100644
index 0000000..c1f9c62
--- /dev/null
+++ b/include/linux/swait.h
@@ -0,0 +1,172 @@
+#ifndef _LINUX_SWAIT_H
+#define _LINUX_SWAIT_H
+
+#include <linux/list.h>
+#include <linux/stddef.h>
+#include <linux/spinlock.h>
+#include <asm/current.h>
+
+/*
+ * Simple wait queues
+ *
+ * While these are very similar to the other/complex wait queues (wait.h) the
+ * most important difference is that the simple waitqueue allows for
+ * deterministic behaviour -- IOW it has strictly bounded IRQ and lock hold
+ * times.
+ *
+ * In order to make this so, we had to drop a fair number of features of the
+ * other waitqueue code; notably:
+ *
+ *  - mixing INTERRUPTIBLE and UNINTERRUPTIBLE sleeps on the same waitqueue;
+ *    all wakeups are TASK_NORMAL in order to avoid O(n) lookups for the right
+ *    sleeper state.
+ *
+ *  - the exclusive mode; because this requires preserving the list order
+ *    and this is hard.
+ *
+ *  - custom wake functions; because you cannot give any guarantees about
+ *    random code.
+ *
+ * As a side effect of this; the data structures are slimmer.
+ *
+ * One would recommend using this wait queue where possible.
+ */
+
+struct task_struct;
+
+struct swait_queue_head {
+	raw_spinlock_t		lock;
+	struct list_head	task_list;
+};
+
+struct swait_queue {
+	struct task_struct	*task;
+	struct list_head	task_list;
+};
+
+#define __SWAITQUEUE_INITIALIZER(name) {				\
+	.task		= current,					\
+	.task_list	= LIST_HEAD_INIT((name).task_list),		\
+}
+
+#define DECLARE_SWAITQUEUE(name)					\
+	struct swait_queue name = __SWAITQUEUE_INITIALIZER(name)
+
+#define __SWAIT_QUEUE_HEAD_INITIALIZER(name) {				\
+	.lock		= __RAW_SPIN_LOCK_UNLOCKED(name.lock),		\
+	.task_list	= LIST_HEAD_INIT((name).task_list),		\
+}
+
+#define DECLARE_SWAIT_QUEUE_HEAD(name)					\
+	struct swait_queue_head name = __SWAIT_QUEUE_HEAD_INITIALIZER(name)
+
+extern void __init_swait_queue_head(struct swait_queue_head *q, const char *name,
+				    struct lock_class_key *key);
+
+#define init_swait_queue_head(q)				\
+	do {							\
+		static struct lock_class_key __key;		\
+		__init_swait_queue_head((q), #q, &__key);	\
+	} while (0)
+
+#ifdef CONFIG_LOCKDEP
+# define __SWAIT_QUEUE_HEAD_INIT_ONSTACK(name)			\
+	({ init_swait_queue_head(&name); name; })
+# define DECLARE_SWAIT_QUEUE_HEAD_ONSTACK(name)			\
+	struct swait_queue_head name = __SWAIT_QUEUE_HEAD_INIT_ONSTACK(name)
+#else
+# define DECLARE_SWAIT_QUEUE_HEAD_ONSTACK(name)			\
+	DECLARE_SWAIT_QUEUE_HEAD(name)
+#endif
+
+static inline int swait_active(struct swait_queue_head *q)
+{
+	return !list_empty(&q->task_list);
+}
+
+extern void swake_up(struct swait_queue_head *q);
+extern void swake_up_all(struct swait_queue_head *q);
+extern void swake_up_locked(struct swait_queue_head *q);
+
+extern void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait);
+extern void prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait, int state);
+extern long prepare_to_swait_event(struct swait_queue_head *q, struct swait_queue *wait, int state);
+
+extern void __finish_swait(struct swait_queue_head *q, struct swait_queue *wait);
+extern void finish_swait(struct swait_queue_head *q, struct swait_queue *wait);
+
+/* as per ___wait_event() but for swait, therefore "exclusive == 0" */
+#define ___swait_event(wq, condition, state, ret, cmd)			\
+({									\
+	struct swait_queue __wait;					\
+	long __ret = ret;						\
+									\
+	INIT_LIST_HEAD(&__wait.task_list);				\
+	for (;;) {							\
+		long __int = prepare_to_swait_event(&wq, &__wait, state);\
+									\
+		if (condition)						\
+			break;						\
+									\
+		if (___wait_is_interruptible(state) && __int) {		\
+			__ret = __int;					\
+			break;						\
+		}							\
+									\
+		cmd;							\
+	}								\
+	finish_swait(&wq, &__wait);					\
+	__ret;								\
+})
+
+#define __swait_event(wq, condition)					\
+	(void)___swait_event(wq, condition, TASK_UNINTERRUPTIBLE, 0,	\
+			    schedule())
+
+#define swait_event(wq, condition)					\
+do {									\
+	if (condition)							\
+		break;							\
+	__swait_event(wq, condition);					\
+} while (0)
+
+#define __swait_event_timeout(wq, condition, timeout)			\
+	___swait_event(wq, ___wait_cond_timeout(condition),		\
+		      TASK_UNINTERRUPTIBLE, timeout,			\
+		      __ret = schedule_timeout(__ret))
+
+#define swait_event_timeout(wq, condition, timeout)			\
+({									\
+	long __ret = timeout;						\
+	if (!___wait_cond_timeout(condition))				\
+		__ret = __swait_event_timeout(wq, condition, timeout);	\
+	__ret;								\
+})
+
+#define __swait_event_interruptible(wq, condition)			\
+	___swait_event(wq, condition, TASK_INTERRUPTIBLE, 0,		\
+		      schedule())
+
+#define swait_event_interruptible(wq, condition)			\
+({									\
+	int __ret = 0;							\
+	if (!(condition))						\
+		__ret = __swait_event_interruptible(wq, condition);	\
+	__ret;								\
+})
+
+#define __swait_event_interruptible_timeout(wq, condition, timeout)	\
+	___swait_event(wq, ___wait_cond_timeout(condition),		\
+		      TASK_INTERRUPTIBLE, timeout,			\
+		      __ret = schedule_timeout(__ret))
+
+#define swait_event_interruptible_timeout(wq, condition, timeout)	\
+({									\
+	long __ret = timeout;						\
+	if (!___wait_cond_timeout(condition))				\
+		__ret = __swait_event_interruptible_timeout(wq,		\
+						condition, timeout);	\
+	__ret;								\
+})
+
+#endif /* _LINUX_SWAIT_H */
diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index 6768797..7d4cba2 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -13,7 +13,7 @@ endif
 
 obj-y += core.o loadavg.o clock.o cputime.o
 obj-y += idle_task.o fair.o rt.o deadline.o stop_task.o
-obj-y += wait.o completion.o idle.o
+obj-y += wait.o swait.o completion.o idle.o
 obj-$(CONFIG_SMP) += cpupri.o cpudeadline.o
 obj-$(CONFIG_SCHED_AUTOGROUP) += auto_group.o
 obj-$(CONFIG_SCHEDSTATS) += stats.o
diff --git a/kernel/sched/swait.c b/kernel/sched/swait.c
new file mode 100644
index 0000000..82f0dff
--- /dev/null
+++ b/kernel/sched/swait.c
@@ -0,0 +1,123 @@
+#include <linux/sched.h>
+#include <linux/swait.h>
+
+void __init_swait_queue_head(struct swait_queue_head *q, const char *name,
+			     struct lock_class_key *key)
+{
+	raw_spin_lock_init(&q->lock);
+	lockdep_set_class_and_name(&q->lock, key, name);
+	INIT_LIST_HEAD(&q->task_list);
+}
+EXPORT_SYMBOL(__init_swait_queue_head);
+
+/*
+ * The thing about the wake_up_state() return value; I think we can ignore it.
+ *
+ * If for some reason it would return 0, that means the previously waiting
+ * task is already running, so it will observe condition true (or has already).
+ */
+void swake_up_locked(struct swait_queue_head *q)
+{
+	struct swait_queue *curr;
+
+	if (list_empty(&q->task_list))
+		return;
+
+	curr = list_first_entry(&q->task_list, typeof(*curr), task_list);
+	wake_up_process(curr->task);
+	list_del_init(&curr->task_list);
+}
+EXPORT_SYMBOL(swake_up_locked);
+
+void swake_up(struct swait_queue_head *q)
+{
+	unsigned long flags;
+
+	if (!swait_active(q))
+		return;
+
+	raw_spin_lock_irqsave(&q->lock, flags);
+	swake_up_locked(q);
+	raw_spin_unlock_irqrestore(&q->lock, flags);
+}
+EXPORT_SYMBOL(swake_up);
+
+/*
+ * Does not allow usage from IRQ disabled, since we must be able to
+ * release IRQs to guarantee bounded hold time.
+ */
+void swake_up_all(struct swait_queue_head *q)
+{
+	struct swait_queue *curr;
+	LIST_HEAD(tmp);
+
+	if (!swait_active(q))
+		return;
+
+	raw_spin_lock_irq(&q->lock);
+	list_splice_init(&q->task_list, &tmp);
+	while (!list_empty(&tmp)) {
+		curr = list_first_entry(&tmp, typeof(*curr), task_list);
+
+		wake_up_state(curr->task, TASK_NORMAL);
+		list_del_init(&curr->task_list);
+
+		if (list_empty(&tmp))
+			break;
+
+		raw_spin_unlock_irq(&q->lock);
+		raw_spin_lock_irq(&q->lock);
+	}
+	raw_spin_unlock_irq(&q->lock);
+}
+EXPORT_SYMBOL(swake_up_all);
+
+void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait)
+{
+	wait->task = current;
+	if (list_empty(&wait->task_list))
+		list_add(&wait->task_list, &q->task_list);
+}
+
+void prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait, int state)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&q->lock, flags);
+	__prepare_to_swait(q, wait);
+	set_current_state(state);
+	raw_spin_unlock_irqrestore(&q->lock, flags);
+}
+EXPORT_SYMBOL(prepare_to_swait);
+
+long prepare_to_swait_event(struct swait_queue_head *q, struct swait_queue *wait, int state)
+{
+	if (signal_pending_state(state, current))
+		return -ERESTARTSYS;
+
+	prepare_to_swait(q, wait, state);
+
+	return 0;
+}
+EXPORT_SYMBOL(prepare_to_swait_event);
+
+void __finish_swait(struct swait_queue_head *q, struct swait_queue *wait)
+{
+	__set_current_state(TASK_RUNNING);
+	if (!list_empty(&wait->task_list))
+		list_del_init(&wait->task_list);
+}
+
+void finish_swait(struct swait_queue_head *q, struct swait_queue *wait)
+{
+	unsigned long flags;
+
+	__set_current_state(TASK_RUNNING);
+
+	if (!list_empty_careful(&wait->task_list)) {
+		raw_spin_lock_irqsave(&q->lock, flags);
+		list_del_init(&wait->task_list);
+		raw_spin_unlock_irqrestore(&q->lock, flags);
+	}
+}
+EXPORT_SYMBOL(finish_swait);
-- 
2.5.0
