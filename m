Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Apr 2016 13:50:22 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:46408 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27027244AbcDULtRecbrh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 21 Apr 2016 13:49:17 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6B664AD95;
        Thu, 21 Apr 2016 11:49:15 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jiri Kosina <jkosina@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-cris-kernel@axis.com, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v5 4/4] printk/nmi: flush NMI messages on the system panic
Date:   Thu, 21 Apr 2016 13:48:45 +0200
Message-Id: <1461239325-22779-5-git-send-email-pmladek@suse.com>
X-Mailer: git-send-email 1.8.5.6
In-Reply-To: <1461239325-22779-1-git-send-email-pmladek@suse.com>
References: <1461239325-22779-1-git-send-email-pmladek@suse.com>
Return-Path: <pmladek@suse.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53152
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pmladek@suse.com
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

In NMI context, printk() messages are stored into per-CPU buffers to avoid
a possible deadlock.  They are normally flushed to the main ring buffer via
an IRQ work.  But the work is never called when the system calls panic() in
the very same NMI handler.

This patch tries to flush NMI buffers before the crash dump is generated.
In this case it does not risk a double release and bails out when the
logbuf_lock is already taken.  The aim is to get the messages into the main
ring buffer when possible.  It makes them better accessible in the vmcore.

Then the patch tries to flush the buffers second time when other CPUs are
down.  It might be more aggressive and reset logbuf_lock. The aim is to
get the messages available for the consequent kmsg_dump() and
console_flush_on_panic() calls.

The patch causes vprintk_emit() to be called even in NMI context again. But
it is done via printk_deferred() so that the console handling is skipped.
Consoles use internal locks and we could not prevent a deadlock easily.
They are explicitly called later when the crash dump is not generated, see
console_flush_on_panic().

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/printk.h   |  2 ++
 kernel/kexec_core.c      |  1 +
 kernel/panic.c           |  6 +++++-
 kernel/printk/internal.h |  2 ++
 kernel/printk/nmi.c      | 39 ++++++++++++++++++++++++++++++++++++++-
 kernel/printk/printk.c   |  2 +-
 6 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 51dd6b824fe2..f4da695fd615 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -127,11 +127,13 @@ extern void printk_nmi_init(void);
 extern void printk_nmi_enter(void);
 extern void printk_nmi_exit(void);
 extern void printk_nmi_flush(void);
+extern void printk_nmi_flush_on_panic(void);
 #else
 static inline void printk_nmi_init(void) { }
 static inline void printk_nmi_enter(void) { }
 static inline void printk_nmi_exit(void) { }
 static inline void printk_nmi_flush(void) { }
+static inline void printk_nmi_flush_on_panic(void) { }
 #endif /* PRINTK_NMI */
 
 #ifdef CONFIG_PRINTK
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 8d34308ea449..1dc3fe8495e0 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -893,6 +893,7 @@ void crash_kexec(struct pt_regs *regs)
 	old_cpu = atomic_cmpxchg(&panic_cpu, PANIC_CPU_INVALID, this_cpu);
 	if (old_cpu == PANIC_CPU_INVALID) {
 		/* This is the 1st CPU which comes here, so go ahead. */
+		printk_nmi_flush_on_panic();
 		__crash_kexec(regs);
 
 		/*
diff --git a/kernel/panic.c b/kernel/panic.c
index 535c96510a44..8aa74497cc5a 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -160,8 +160,10 @@ void panic(const char *fmt, ...)
 	 *
 	 * Bypass the panic_cpu check and call __crash_kexec directly.
 	 */
-	if (!crash_kexec_post_notifiers)
+	if (!crash_kexec_post_notifiers) {
+		printk_nmi_flush_on_panic();
 		__crash_kexec(NULL);
+	}
 
 	/*
 	 * Note smp_send_stop is the usual smp shutdown function, which
@@ -176,6 +178,8 @@ void panic(const char *fmt, ...)
 	 */
 	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
 
+	/* Call flush even twice. It tries harder with a single online CPU */
+	printk_nmi_flush_on_panic();
 	kmsg_dump(KMSG_DUMP_PANIC);
 
 	/*
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 341bedccc065..7fd2838fa417 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -22,6 +22,8 @@ int __printf(1, 0) vprintk_default(const char *fmt, va_list args);
 
 #ifdef CONFIG_PRINTK_NMI
 
+extern raw_spinlock_t logbuf_lock;
+
 /*
  * printk() could not take logbuf_lock in NMI context. Instead,
  * it temporary stores the strings into a per-CPU buffer.
diff --git a/kernel/printk/nmi.c b/kernel/printk/nmi.c
index bf08557d7e3d..b69eb8a2876f 100644
--- a/kernel/printk/nmi.c
+++ b/kernel/printk/nmi.c
@@ -17,6 +17,7 @@
 
 #include <linux/preempt.h>
 #include <linux/spinlock.h>
+#include <linux/debug_locks.h>
 #include <linux/smp.h>
 #include <linux/cpumask.h>
 #include <linux/irq_work.h>
@@ -106,7 +107,16 @@ static void print_nmi_seq_line(struct nmi_seq_buf *s, int start, int end)
 {
 	const char *buf = s->buffer + start;
 
-	printk("%.*s", (end - start) + 1, buf);
+	/*
+	 * The buffers are flushed in NMI only on panic.  The messages must
+	 * go only into the ring buffer at this stage.  Consoles will get
+	 * explicitly called later when a crashdump is not generated.
+	 */
+	if (in_nmi())
+		printk_deferred("%.*s", (end - start) + 1, buf);
+	else
+		printk("%.*s", (end - start) + 1, buf);
+
 }
 
 /*
@@ -194,6 +204,33 @@ void printk_nmi_flush(void)
 		__printk_nmi_flush(&per_cpu(nmi_print_seq, cpu).work);
 }
 
+/**
+ * printk_nmi_flush_on_panic - flush all per-cpu nmi buffers when the system
+ *	goes down.
+ *
+ * Similar to printk_nmi_flush() but it can be called even in NMI context when
+ * the system goes down. It does the best effort to get NMI messages into
+ * the main ring buffer.
+ *
+ * Note that it could try harder when there is only one CPU online.
+ */
+void printk_nmi_flush_on_panic(void)
+{
+	/*
+	 * Make sure that we could access the main ring buffer.
+	 * Do not risk a double release when more CPUs are up.
+	 */
+	if (in_nmi() && raw_spin_is_locked(&logbuf_lock)) {
+		if (num_online_cpus() > 1)
+			return;
+
+		debug_locks_off();
+		raw_spin_lock_init(&logbuf_lock);
+	}
+
+	printk_nmi_flush();
+}
+
 void __init printk_nmi_init(void)
 {
 	int cpu;
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index e38579d730f4..60cdf6386763 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -245,7 +245,7 @@ __packed __aligned(4)
  * within the scheduler's rq lock. It must be released before calling
  * console_unlock() or anything else that might wake up a process.
  */
-static DEFINE_RAW_SPINLOCK(logbuf_lock);
+DEFINE_RAW_SPINLOCK(logbuf_lock);
 
 #ifdef CONFIG_PRINTK
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
-- 
1.8.5.6
