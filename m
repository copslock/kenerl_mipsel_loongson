Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jul 2015 13:40:34 +0200 (CEST)
Received: from mail7.hitachi.co.jp ([133.145.228.42]:44442 "EHLO
        mail7.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009635AbbGJLj5gr7tT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Jul 2015 13:39:57 +0200
Received: from mlsv3.hitachi.co.jp (unknown [133.144.234.166])
        by mail7.hitachi.co.jp (Postfix) with ESMTP id 361F3B1D382;
        Fri, 10 Jul 2015 20:39:55 +0900 (JST)
Received: from mfilter06.hitachi.co.jp by mlsv3.hitachi.co.jp (8.13.1/8.13.1) id t6ABdtTi016987; Fri, 10 Jul 2015 20:39:55 +0900
Received: from vshuts04.hitachi.co.jp (vshuts04.hitachi.co.jp [10.201.6.86])
        by mfilter06.hitachi.co.jp (Switch-3.3.4/Switch-3.3.4) with ESMTP id t6ABdrNL023940;
        Fri, 10 Jul 2015 20:39:54 +0900
Received: from hsdlmain.sdl.hitachi.co.jp (unknown [133.144.14.194])
        by vshuts04.hitachi.co.jp (Postfix) with ESMTP id 5D26614003B;
        Fri, 10 Jul 2015 20:39:53 +0900 (JST)
Received: from hsdlvgate2.sdl.hitachi.co.jp by hsdlmain.sdl.hitachi.co.jp (8.13.8/3.7W11021512) id t6ABdr5R008865; Fri, 10 Jul 2015 20:39:53 +0900
X-AuditID: 85900ec0-9c3c7b9000001a57-6c-559faef242f9
Received: from sdl99w.sdl.hitachi.co.jp (sdl99w.yrl.intra.hitachi.co.jp [133.144.14.250])
        by hsdlvgate2.sdl.hitachi.co.jp (Symantec Mail Security) with ESMTP id 4C869236561;
        Fri, 10 Jul 2015 20:39:30 +0900 (JST)
Received: from mailb.sdl.hitachi.co.jp (sdl99b.yrl.intra.hitachi.co.jp [133.144.14.197])
        by sdl99w.sdl.hitachi.co.jp (Postfix) with ESMTP id C351C53C21A;
        Fri, 10 Jul 2015 20:39:52 +0900 (JST)
Received: from [10.198.219.30] (unknown [10.198.219.30])
        by mailb.sdl.hitachi.co.jp (Postfix) with ESMTP id 7C12D495B93;
        Fri, 10 Jul 2015 20:39:52 +0900 (JST)
X-Mailbox-Line: From nobody Fri Jul 10 20:33:31 2015
Subject: [PATCH 2/3] kexec: Pass panic message to crash_kexec()
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Vivek Goyal <vgoyal@redhat.com>
From:   Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc:     linux-mips@linux-mips.org, Baoquan He <bhe@redhat.com>,
        linux-sh@vger.kernel.org, linux-s390@vger.kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>,
        Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
        Daniel Walker <dwalker@fifo99.com>,
        linuxppc-dev@lists.ozlabs.org, linux-metag@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Fri, 10 Jul 2015 20:33:31 +0900
Message-ID: <20150710113331.4368.9926.stgit@softrs>
In-Reply-To: <20150710113331.4368.10495.stgit@softrs>
References: <20150710113331.4368.10495.stgit@softrs>
User-Agent: StGit/0.16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAA==
Return-Path: <hidehiro.kawai.ez@hitachi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48172
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hidehiro.kawai.ez@hitachi.com
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

Add an argument to crash_kexec() to pass the panic message.  This
patch is a preparation for the next patch, and it doesn't change
the current behavior.

Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
---
 arch/arm/kernel/traps.c       |    2 +-
 arch/arm64/kernel/traps.c     |    2 +-
 arch/metag/kernel/traps.c     |    2 +-
 arch/mips/kernel/traps.c      |    2 +-
 arch/powerpc/kernel/traps.c   |    2 +-
 arch/s390/kernel/ipl.c        |    2 +-
 arch/sh/kernel/traps.c        |    2 +-
 arch/x86/kernel/dumpstack.c   |    2 +-
 arch/x86/platform/uv/uv_nmi.c |    2 +-
 include/linux/kexec.h         |    7 +++++--
 kernel/kexec.c                |   23 ++++++++++++++++++++++-
 kernel/panic.c                |    4 ++--
 12 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index d358226..abb7b86 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -293,7 +293,7 @@ static unsigned long oops_begin(void)
 static void oops_end(unsigned long flags, struct pt_regs *regs, int signr)
 {
 	if (regs && kexec_should_crash(current))
-		crash_kexec(regs);
+		crash_kexec_on_oops(regs, current);
 
 	bust_spinlocks(0);
 	die_owner = -1;
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 566bc4c..17a6841 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -233,7 +233,7 @@ void die(const char *str, struct pt_regs *regs, int err)
 	ret = __die(str, err, thread, regs);
 
 	if (regs && kexec_should_crash(thread->task))
-		crash_kexec(regs);
+		crash_kexec_on_oops(regs, thread->task);
 
 	bust_spinlocks(0);
 	add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
diff --git a/arch/metag/kernel/traps.c b/arch/metag/kernel/traps.c
index 17b2e2e..dca46c7 100644
--- a/arch/metag/kernel/traps.c
+++ b/arch/metag/kernel/traps.c
@@ -110,7 +110,7 @@ void __noreturn die(const char *str, struct pt_regs *regs,
 	bust_spinlocks(0);
 	add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
 	if (kexec_should_crash(current))
-		crash_kexec(regs);
+		crash_kexec_on_oops(regs, current);
 
 	if (in_interrupt())
 		panic("Fatal exception in interrupt");
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 2a7b38e..46fc9a6 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -402,7 +402,7 @@ void __noreturn die(const char *str, struct pt_regs *regs)
 	}
 
 	if (regs && kexec_should_crash(current))
-		crash_kexec(regs);
+		crash_kexec_on_oops(regs, current);
 
 	do_exit(sig);
 }
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 6530f1b..4e1fe20 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -163,7 +163,7 @@ static void __kprobes oops_end(unsigned long flags, struct pt_regs *regs,
 	 * it through the crashdump code.
 	 */
 	if (kexec_should_crash(current) || (TRAP(regs) == 0x100)) {
-		crash_kexec(regs);
+		crash_kexec_on_oops(regs, current);
 
 		/*
 		 * We aren't the primary crash CPU. We need to send it
diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index 52fbef91d..67c1f8b 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -1726,7 +1726,7 @@ static void __do_restart(void *ignore)
 	__arch_local_irq_stosm(0x04); /* enable DAT */
 	smp_send_stop();
 #ifdef CONFIG_CRASH_DUMP
-	crash_kexec(NULL);
+	crash_kexec(NULL, "restart");
 #endif
 	on_restart_trigger.action->fn(&on_restart_trigger);
 	stop_run(&on_restart_trigger);
diff --git a/arch/sh/kernel/traps.c b/arch/sh/kernel/traps.c
index dfdad72..4bfb519 100644
--- a/arch/sh/kernel/traps.c
+++ b/arch/sh/kernel/traps.c
@@ -43,7 +43,7 @@ void die(const char *str, struct pt_regs *regs, long err)
 	oops_exit();
 
 	if (kexec_should_crash(current))
-		crash_kexec(regs);
+		crash_kexec_on_oops(regs, current);
 
 	if (in_interrupt())
 		panic("Fatal exception in interrupt");
diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 9c30acf..e973a1d 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -229,7 +229,7 @@ unsigned long oops_begin(void)
 void oops_end(unsigned long flags, struct pt_regs *regs, int signr)
 {
 	if (regs && kexec_should_crash(current))
-		crash_kexec(regs);
+		crash_kexec_on_oops(regs, current);
 
 	bust_spinlocks(0);
 	die_owner = -1;
diff --git a/arch/x86/platform/uv/uv_nmi.c b/arch/x86/platform/uv/uv_nmi.c
index 020c101..8b67644 100644
--- a/arch/x86/platform/uv/uv_nmi.c
+++ b/arch/x86/platform/uv/uv_nmi.c
@@ -499,7 +499,7 @@ static void uv_nmi_kdump(int cpu, int master, struct pt_regs *regs)
 	/* Call crash to dump system state */
 	if (master) {
 		pr_emerg("UV: NMI executing crash_kexec on CPU%d\n", cpu);
-		crash_kexec(regs);
+		crash_kexec(regs, "UV: NMI executing crash_kexec");
 
 		pr_emerg("UV: crash_kexec unexpectedly returned, ");
 		if (!kexec_crash_image) {
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index e804306..0a2744d 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -237,7 +237,8 @@ extern int kexec_purgatory_get_set_symbol(struct kimage *image,
 					  unsigned int size, bool get_value);
 extern void *kexec_purgatory_get_symbol_addr(struct kimage *image,
 					     const char *name);
-extern void crash_kexec(struct pt_regs *);
+extern void crash_kexec(struct pt_regs *, char *msg);
+extern void crash_kexec_on_oops(struct pt_regs *, struct task_struct *p);
 int kexec_should_crash(struct task_struct *);
 void crash_save_cpu(struct pt_regs *regs, int cpu);
 void crash_save_vmcoreinfo(void);
@@ -321,7 +322,9 @@ int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
 #else /* !CONFIG_KEXEC */
 struct pt_regs;
 struct task_struct;
-static inline void crash_kexec(struct pt_regs *regs) { }
+static inline void crash_kexec(struct pt_regs *regs, char *msg) { }
+static inline void crash_kexec_on_oops(struct pt_regs *regs,
+				      struct task_struct *p) { }
 static inline int kexec_should_crash(struct task_struct *p) { return 0; }
 #endif /* CONFIG_KEXEC */
 
diff --git a/kernel/kexec.c b/kernel/kexec.c
index a785c10..9c7894f 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1470,7 +1470,7 @@ void __weak crash_unmap_reserved_pages(void)
 
 #endif /* CONFIG_KEXEC_FILE */
 
-void crash_kexec(struct pt_regs *regs)
+void crash_kexec(struct pt_regs *regs, char *msg)
 {
 	/* Take the kexec_mutex here to prevent sys_kexec_load
 	 * running on one cpu from replacing the crash kernel
@@ -1493,6 +1493,27 @@ void crash_kexec(struct pt_regs *regs)
 	}
 }
 
+void crash_kexec_on_oops(struct pt_regs *regs, struct task_struct *p)
+{
+	static char buf[128];
+	char *msg = "Die for unknown reason";
+
+	if (in_interrupt())
+		msg = "Fatal exception in interrupt";
+	else if (panic_on_oops)
+		msg = "Fatal exception";
+	else if (!p->pid)
+		msg = "Attempted to kill the idle task!";
+	else if (is_global_init(p)) {
+		snprintf(buf, sizeof(buf),
+			 "Attempted to kill init! exitcode=0x%08x",
+			 p->signal->group_exit_code ?: p->exit_code);
+		msg = buf;
+	}
+
+	crash_kexec(regs, msg);
+}
+
 size_t crash_get_memory_size(void)
 {
 	size_t size = 0;
diff --git a/kernel/panic.c b/kernel/panic.c
index 5252331..93008b6 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -118,7 +118,7 @@ void panic(const char *fmt, ...)
 	 * the "crash_kexec_post_notifiers" option to the kernel.
 	 */
 	if (!crash_kexec_post_notifiers)
-		crash_kexec(NULL);
+		crash_kexec(NULL, buf);
 
 	/*
 	 * Note smp_send_stop is the usual smp shutdown function, which
@@ -143,7 +143,7 @@ void panic(const char *fmt, ...)
 	 * more unstable, it can increase risks of the kdump failure too.
 	 */
 	if (crash_kexec_post_notifiers)
-		crash_kexec(NULL);
+		crash_kexec(NULL, buf);
 
 	bust_spinlocks(0);
 
