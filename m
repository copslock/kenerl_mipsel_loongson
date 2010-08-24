Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Aug 2010 08:05:21 +0200 (CEST)
Received: from mail.windriver.com ([147.11.1.11]:63493 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1490957Ab0HXGFO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Aug 2010 08:05:14 +0200
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
        by mail.windriver.com (8.14.3/8.14.3) with ESMTP id o7O64u5M020496;
        Mon, 23 Aug 2010 23:04:56 -0700 (PDT)
Received: from ala-mail06.corp.ad.wrs.com ([147.11.57.147]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
         Mon, 23 Aug 2010 23:04:56 -0700
Received: from localhost.localdomain ([128.224.163.135]) by ala-mail06.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
         Mon, 23 Aug 2010 23:04:55 -0700
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] tracing/ftrace: Fix the potential hang on MIPS SMP
Date:   Tue, 24 Aug 2010 14:06:51 +0800
Message-Id: <1282630011-23348-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.4
X-OriginalArrivalTime: 24 Aug 2010 06:04:56.0013 (UTC) FILETIME=[468BAFD0:01CB4352]
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27668
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <zhangjin.wu@windriver.com>

In Ftrace, we need to flush the icache after code modification to ensure
the instructions will be executed are exactly what we want.

And for the following reason(arch/x86/kernel/ftrace.c):

 * Modifying code must take extra care. On an SMP machine, if
 * the code being modified is also being executed on another CPU
 * that CPU will have undefined results and possibly take a GPF.
 * We use kstop_machine to stop other CPUS from exectuing code.

In SMP, the code modification are protected by stop_machine(), which
will disables the irqs of all cpus and then modify the code, flush the
icache.

In MIPS SMP, to tell the other cpus to flush their related icache, the
IPI interrupt must be sent to them and wait for them exiting from the
icache flushing, but for the stop_machine() have disabled interrupts, it
will need to wait for the other cpus all the time, then deadlock ->
hang.

(Note: cavium is an exception, benefit from its synci instruction, it
doesn't call smp_call_function() to execute the icache flushing
operation but send the ICACHE_FLUSH ipi to the other cpus directly, so,
no wait and no hang on cavium, and after the irqs of the cpus are
enabled, the pending icache flush interrupt will be filed and synci will
flush the icache on every cpu respectively, so, no cache problem).

To break this deadlock, the key is: stop calling flush_icache_range() in
stop_machine() but delay it after stop_machine(). delaying the icache
flushing operation doesn't influence the tracing results even if the
other cpus execute the code just modified before the icache flushing,
for the kernel tracing will only be enabled after users issuing:

$ echo 1 > /path/to/tracing/tracing_enabled

Thanks to the weak functions: ftrace_arch_code_modify_prepare() and
ftrace_arch_code_modify_post_process(). they are called by
ftrace_run_update_code() before and after stop_machine() respectively,
with them, ftrace_modify_code() can check whether it is called in
stop_machine() and if called in stop_machine(), then delay the operation
of icache flushing, as a result, the deadlock is broken.

Without this patch, Ftrace for RMI XLS will hang after issuing the
following command:

$ echo function > /path/to/tracing/current_tracer

Exactly, it hangs on kernel/smp.c:

void smp_call_function_many(const struct cpumask *mask,
{
	[snip]
	/*
	 * Can deadlock when called with interrupts disabled.
	 * We allow cpu's that are not yet online though, as no one else can
	 * send smp call function interrupt to this cpu and as such deadlocks
	 * can't happen.
	 */
	WARN_ON_ONCE(cpu_online(this_cpu) && irqs_disabled()
		     && !oops_in_progress);
	[snip]
	csd_lock(&data->csd);

	[snip]
	/* Send a message to all CPUs in the map */
	arch_send_call_function_ipi_mask(data->cpumask);

	/* Optionally wait for the CPUs to complete */
	if (wait)
		csd_lock_wait(&data->csd);	--> hang here
}

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/kernel/ftrace.c |   22 +++++++++++++++++++++-
 1 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
index 5a84a1f..c8ebb13 100644
--- a/arch/mips/kernel/ftrace.c
+++ b/arch/mips/kernel/ftrace.c
@@ -69,6 +69,23 @@ static inline void ftrace_dyn_arch_init_insns(void)
 #endif
 }
 
+#ifdef CONFIG_SMP
+static int machine_stopped __read_mostly;
+
+int ftrace_arch_code_modify_prepare(void)
+{
+	machine_stopped = 1;
+	return 0;
+}
+
+int ftrace_arch_code_modify_post_process(void)
+{
+	__flush_cache_all();
+	machine_stopped = 0;
+	return 0;
+}
+#endif
+
 static int ftrace_modify_code(unsigned long ip, unsigned int new_code)
 {
 	int faulted;
@@ -79,7 +96,10 @@ static int ftrace_modify_code(unsigned long ip, unsigned int new_code)
 	if (unlikely(faulted))
 		return -EFAULT;
 
-	flush_icache_range(ip, ip + 8);
+#ifdef CONFIG_SMP
+	if (!machine_stopped)
+#endif
+		flush_icache_range(ip, ip + 8);
 
 	return 0;
 }
-- 
1.7.0.4
