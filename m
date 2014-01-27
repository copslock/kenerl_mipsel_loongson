Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 21:34:32 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:44752 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825865AbaA0UZ1rrh2L (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 21:25:27 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 42/58] MIPS: kernel: {ftrace,kgdb}: Set correct address limit for cache flushes
Date:   Mon, 27 Jan 2014 20:19:29 +0000
Message-ID: <1390853985-14246-43-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
References: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_01_27_20_25_27
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39161
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

When flushing the icache, make sure the address limit is correct
so the appropriate 'cache' instruction will be used. This has no
impact on cores operating in non-eva mode. However, when EVA is
enabled, we ensure that 'cache' will be used instead of 'cachee'.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/ftrace.c |  4 ++++
 arch/mips/kernel/kgdb.c   | 17 ++++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
index 185ba25..ddcc350 100644
--- a/arch/mips/kernel/ftrace.c
+++ b/arch/mips/kernel/ftrace.c
@@ -90,6 +90,7 @@ static inline void ftrace_dyn_arch_init_insns(void)
 static int ftrace_modify_code(unsigned long ip, unsigned int new_code)
 {
 	int faulted;
+	mm_segment_t old_fs;
 
 	/* *(unsigned int *)ip = new_code; */
 	safe_store_code(new_code, ip, faulted);
@@ -97,7 +98,10 @@ static int ftrace_modify_code(unsigned long ip, unsigned int new_code)
 	if (unlikely(faulted))
 		return -EFAULT;
 
+	old_fs = get_fs();
+	set_fs(get_ds());
 	flush_icache_range(ip, ip + 8);
+	set_fs(old_fs);
 
 	return 0;
 }
diff --git a/arch/mips/kernel/kgdb.c b/arch/mips/kernel/kgdb.c
index fcaac2f..a70ffe4 100644
--- a/arch/mips/kernel/kgdb.c
+++ b/arch/mips/kernel/kgdb.c
@@ -208,7 +208,14 @@ void arch_kgdb_breakpoint(void)
 
 static void kgdb_call_nmi_hook(void *ignored)
 {
+	mm_segment_t old_fs;
+
+	old_fs = get_fs();
+	set_fs(get_ds());
+
 	kgdb_nmicallback(raw_smp_processor_id(), NULL);
+
+	set_fs(old_fs);
 }
 
 void kgdb_roundup_cpus(unsigned long flags)
@@ -282,6 +289,7 @@ static int kgdb_mips_notify(struct notifier_block *self, unsigned long cmd,
 	struct die_args *args = (struct die_args *)ptr;
 	struct pt_regs *regs = args->regs;
 	int trap = (regs->cp0_cause & 0x7c) >> 2;
+	mm_segment_t old_fs;
 
 #ifdef CONFIG_KPROBES
 	/*
@@ -296,11 +304,17 @@ static int kgdb_mips_notify(struct notifier_block *self, unsigned long cmd,
 	if (user_mode(regs))
 		return NOTIFY_DONE;
 
+	/* Kernel mode. Set correct address limit */
+	old_fs = get_fs();
+	set_fs(get_ds());
+
 	if (atomic_read(&kgdb_active) != -1)
 		kgdb_nmicallback(smp_processor_id(), regs);
 
-	if (kgdb_handle_exception(trap, compute_signal(trap), cmd, regs))
+	if (kgdb_handle_exception(trap, compute_signal(trap), cmd, regs)) {
+		set_fs(old_fs);
 		return NOTIFY_DONE;
+	}
 
 	if (atomic_read(&kgdb_setting_breakpoint))
 		if ((trap == 9) && (regs->cp0_epc == (unsigned long)breakinst))
@@ -310,6 +324,7 @@ static int kgdb_mips_notify(struct notifier_block *self, unsigned long cmd,
 	local_irq_enable();
 	__flush_cache_all();
 
+	set_fs(old_fs);
 	return NOTIFY_STOP;
 }
 
-- 
1.8.5.3
