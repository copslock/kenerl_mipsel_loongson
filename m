Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Jun 2009 17:54:46 +0200 (CEST)
Received: from mail-pz0-f179.google.com ([209.85.222.179]:53845 "EHLO
	mail-pz0-f179.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492192AbZFNPyN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 14 Jun 2009 17:54:13 +0200
Received: by pzk9 with SMTP id 9so1380699pzk.22
        for <multiple recipients>; Sun, 14 Jun 2009 08:53:34 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=7xQk0SHSmRbm59dzQVk5DWBBTXJ+zw5qPQRRMYEqp+U=;
        b=VfoqlNKHuO7DBK21CBPYnkG9PvTnYCOdAYIZtG7/m/bo+haYWkLFUp2k/LHyJFhVql
         3HGNSd8ij2OKL9cpLIxUF8unCC5gnS1b+e10LU36yPoOiI8fM8gTh4Yo+7FvpULjKePY
         B0X9VY+qCVvnhrGswnHja7E5p50AZG4xejCg8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=oJijY4OGE7atX2OVczG4ImdP4BoyEc881jrlTiBFrytpRsoNUqO5129QkouH71sN+E
         m9qftrrv3+NDxo0XxblFU36LgfofkuWlTuEphSC4lX56AQ/C3wlSVy4WLtnPoSKn4Hgk
         /qzBkjct+n/HZlv8OkEdoS4bxhsr75Grdftj4=
Received: by 10.115.95.20 with SMTP id x20mr9933799wal.40.1244994814240;
        Sun, 14 Jun 2009 08:53:34 -0700 (PDT)
Received: from localhost.localdomain ([219.246.59.144])
        by mx.google.com with ESMTPS id v9sm4681277wah.36.2009.06.14.08.53.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Jun 2009 08:53:33 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:	Wang Liming <liming.wang@windriver.com>,
	Wu Zhangjin <wuzj@lemote.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Ingo Molnar <mingo@elte.hu>
Subject: [PATCH v3] mips specific clock function to get precise timestamp
Date:	Sun, 14 Jun 2009 23:53:24 +0800
Message-Id: <16e9c35472ee339da63366456f7e0491f5758964.1244994151.git.wuzj@lemote.com>
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <cover.1244994151.git.wuzj@lemote.com>
References: <cover.1244994151.git.wuzj@lemote.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23411
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzj@lemote.com>

by default, trace_clock_local calling sched_clock(jiffies-based) to get
timestamp, in x86, there is a tsc(64bit) based sched_clock, but in mips,
the 'tsc'(clock counter) is only 32bit long, which will easily rollover,
and there is no existing high precise sched_clock in mips, we need to
get one ourselves.

to avoid invading the whole linux-mips, i do not want to implement a
tsc-based native_sched_clock instead of sched_clock like x86 does.
because, there is a need to handling rollover of the only 32-bit long
'tsc' of mips, which will need extra overhead. in reality, i have tried
to do it, but made the kernel hangs when booting, I'm not sure why it
not work.

so, I just implement a native_sched_clock in arch/mips/kernel/ftrace.c,
but not override the original sched_clock(). to get high precise
timestamp, we implement a native_trace_clock_local, which will not call
original sched_clock again, but native_sched_clock().

and what about the trace_clock and trace_clock_global function, should
we also implement a mips-secific one? I'm not sure.

Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Wu Zhangjin <wuzj@lemote.com>
---
 arch/mips/kernel/Makefile       |    2 +
 arch/mips/kernel/csrc-r4k.c     |    2 +-
 arch/mips/kernel/ftrace_clock.c |   71 +++++++++++++++++++++++++++++++++++++++
 kernel/trace/trace_clock.c      |    2 +-
 4 files changed, 75 insertions(+), 2 deletions(-)
 create mode 100644 arch/mips/kernel/ftrace_clock.c

diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 8dabcc6..44ec7e0 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -11,6 +11,7 @@ obj-y		+= cpu-probe.o branch.o entry.o genex.o irq.o process.o \
 ifdef CONFIG_FUNCTION_TRACER
 # Do not profile debug and lowlevel utilities
 CFLAGS_REMOVE_ftrace.o = -pg
+CFLAGS_REMOVE_ftrace_clock.o = -pg
 CFLAGS_REMOVE_early_printk.o = -pg
 endif
 
@@ -32,6 +33,7 @@ obj-$(CONFIG_MODULES)		+= mips_ksyms.o module.o
 
 obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o
 obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o
+obj-$(CONFIG_NOP_TRACER)	+= ftrace_clock.o
 
 obj-$(CONFIG_CPU_LOONGSON2)	+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_MIPS32)	+= r4k_fpu.o r4k_switch.o
diff --git a/arch/mips/kernel/csrc-r4k.c b/arch/mips/kernel/csrc-r4k.c
index e95a3cd..3da1c7a 100644
--- a/arch/mips/kernel/csrc-r4k.c
+++ b/arch/mips/kernel/csrc-r4k.c
@@ -10,7 +10,7 @@
 
 #include <asm/time.h>
 
-static cycle_t c0_hpt_read(struct clocksource *cs)
+static cycle_t notrace c0_hpt_read(struct clocksource *cs)
 {
 	return read_c0_count();
 }
diff --git a/arch/mips/kernel/ftrace_clock.c b/arch/mips/kernel/ftrace_clock.c
new file mode 100644
index 0000000..8ad896e
--- /dev/null
+++ b/arch/mips/kernel/ftrace_clock.c
@@ -0,0 +1,71 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive for
+ * more details.
+ *
+ * Copyright (C) 2009 DSLab, Lanzhou University, China
+ * Author: Wu Zhangjin <wuzj@lemote.com>
+ */
+
+#include <linux/types.h>
+#include <linux/sched.h>
+#include <linux/jiffies.h>
+#include <linux/clocksource.h>
+
+/*
+ * mips-specific high precise sched_clock() implementation,
+ *
+ * currently, this is only needed in ftrace, so not override the original
+ * sched_clock().
+ */
+
+unsigned long long native_sched_clock(void)
+{
+	u64 current_cycles;
+	static unsigned long old_jiffies;
+	static u64 time, old_cycles;
+
+	preempt_disable_notrace();
+    /* update timestamp to avoid missing the timer interrupt */
+	if (time_before(jiffies, old_jiffies)) {
+		old_jiffies = jiffies;
+		time = sched_clock();
+		old_cycles = clock->cycle_last;
+	}
+	current_cycles = clock->read(clock);
+
+	time = (time + cyc2ns(clock, (current_cycles - old_cycles)
+				& clock->mask));
+
+	old_cycles = current_cycles;
+	preempt_enable_no_resched_notrace();
+
+	return time;
+}
+
+/*
+ * native_trace_clock_local(): the simplest and least coherent tracing clock.
+ *
+ * Useful for tracing that does not cross to other CPUs nor
+ * does it go through idle events.
+ */
+u64 native_trace_clock_local(void)
+{
+	unsigned long flags;
+	u64 clock;
+
+	/*
+	 * herein, we use the above native_sched_clock() to get high precise
+	 * timestamp, because the original sched_clock in mips is jiffies based,
+	 * which not have enough precision.
+	 */
+	raw_local_irq_save(flags);
+	clock = native_sched_clock();
+	raw_local_irq_restore(flags);
+
+	return clock;
+}
+
+u64 trace_clock_local(void)
+		__attribute__((alias("native_trace_clock_local")));
+
diff --git a/kernel/trace/trace_clock.c b/kernel/trace/trace_clock.c
index b588fd8..78c98c8 100644
--- a/kernel/trace/trace_clock.c
+++ b/kernel/trace/trace_clock.c
@@ -26,7 +26,7 @@
  * Useful for tracing that does not cross to other CPUs nor
  * does it go through idle events.
  */
-u64 notrace trace_clock_local(void)
+u64 __attribute__((weak)) notrace trace_clock_local(void)
 {
 	unsigned long flags;
 	u64 clock;
-- 
1.6.0.4
