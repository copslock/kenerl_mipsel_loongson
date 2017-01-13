Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jan 2017 08:45:04 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:30188 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990519AbdAMHo5bTRFz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Jan 2017 08:44:57 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id AC471B4F7A350;
        Fri, 13 Jan 2017 07:44:48 +0000 (GMT)
Received: from WR-NOWAKOWSKI.kl.imgtec.org (10.80.2.5) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 13 Jan 2017 07:44:50 +0000
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>
Subject: [PATCH 1/2] MIPS: ptrace: protect watchpoint handling code from setting watchpoints
Date:   Fri, 13 Jan 2017 08:44:46 +0100
Message-ID: <1484293487-5770-1-git-send-email-marcin.nowakowski@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56286
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@imgtec.com
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

With certain EVA configurations it is possible for the kernel address
space to overlap user address space, which allows the user to set
watchpoints on kernel addresses via ptrace.

If a watchpoint is set in the watch exception handling code (after
exception level has been cleared) then the system will hang in an
infinite loop when hitting a watchpoint while trying to process it.

To prevent that place all watch exception entry/exit code in a single
named section and disallow placing watchpoints in that area.

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
---
 arch/mips/kernel/entry.S       |  2 +-
 arch/mips/kernel/genex.S       |  2 ++
 arch/mips/kernel/ptrace.c      | 14 ++++++++++++++
 arch/mips/kernel/traps.c       |  2 ++
 arch/mips/kernel/vmlinux.lds.S |  8 ++++++++
 5 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/entry.S b/arch/mips/kernel/entry.S
index 7791840..ef69a64 100644
--- a/arch/mips/kernel/entry.S
+++ b/arch/mips/kernel/entry.S
@@ -24,7 +24,7 @@
 #define __ret_from_irq	ret_from_exception
 #endif
 
-	.text
+	.section .text..no_watch
 	.align	5
 #ifndef CONFIG_PREEMPT
 FEXPORT(ret_from_exception)
diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index dc0b296..102a9e8 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -433,6 +433,7 @@ NESTED(nmi_handler, PT_SIZE, sp)
 	BUILD_HANDLER ftlb ftlb none silent		/* #16 */
 	BUILD_HANDLER msa msa sti silent		/* #21 */
 	BUILD_HANDLER mdmx mdmx sti silent		/* #22 */
+.section .text..no_watch
 #ifdef	CONFIG_HARDWARE_WATCHPOINTS
 	/*
 	 * For watch, interrupts will be enabled after the watch
@@ -442,6 +443,7 @@ NESTED(nmi_handler, PT_SIZE, sp)
 #else
 	BUILD_HANDLER watch watch sti verbose		/* #23 */
 #endif
+.previous
 	BUILD_HANDLER mcheck mcheck cli verbose		/* #24 */
 	BUILD_HANDLER mt mt sti silent			/* #25 */
 	BUILD_HANDLER dsp dsp sti silent		/* #26 */
diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index c8ba260..1c8d75c 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -235,6 +235,17 @@ int ptrace_get_watch_regs(struct task_struct *child,
 	return 0;
 }
 
+static int ptrace_watch_in_watch_code_region(unsigned long addr)
+{
+	extern unsigned long __nowatch_text_start, __nowatch_text_end;
+	unsigned long start, end;
+
+	start = (((unsigned long)&__nowatch_text_start) & ~MIPS_WATCHLO_IRW);
+	end = (((unsigned long)&__nowatch_text_end) & ~MIPS_WATCHLO_IRW);
+
+	return addr >= start && addr < end;
+}
+
 int ptrace_set_watch_regs(struct task_struct *child,
 			  struct pt_watch_regs __user *addr)
 {
@@ -262,6 +273,9 @@ int ptrace_set_watch_regs(struct task_struct *child,
 				return -EINVAL;
 		}
 #endif
+		if (ptrace_watch_in_watch_code_region(lt[i]))
+			return -EINVAL;
+
 		__get_user(ht[i], &addr->WATCH_STYLE.watchhi[i]);
 		if (ht[i] & ~MIPS_WATCHHI_MASK)
 			return -EINVAL;
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 6c7f9d7..b86ce85 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1509,6 +1509,8 @@ asmlinkage void do_mdmx(struct pt_regs *regs)
  * Called with interrupts disabled.
  */
 asmlinkage void do_watch(struct pt_regs *regs)
+	__attribute__((section(".text..no_watch")));
+asmlinkage void do_watch(struct pt_regs *regs)
 {
 	siginfo_t info = { .si_signo = SIGTRAP, .si_code = TRAP_HWBKPT };
 	enum ctx_state prev_state;
diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index d5de675..f76f481 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -32,6 +32,13 @@ PHDRS {
 	jiffies	 = jiffies_64;
 #endif
 
+#define NOWATCH_TEXT							\
+		ALIGN_FUNCTION();					\
+		VMLINUX_SYMBOL(__nowatch_text_start) = .;		\
+		*(.text..no_watch)					\
+		VMLINUX_SYMBOL(__nowatch_text_end) = .;
+
+
 SECTIONS
 {
 #ifdef CONFIG_BOOT_ELF64
@@ -54,6 +61,7 @@ SECTIONS
 	_text = .;	/* Text and read-only data */
 	.text : {
 		TEXT_TEXT
+		NOWATCH_TEXT
 		SCHED_TEXT
 		CPUIDLE_TEXT
 		LOCK_TEXT
-- 
2.7.4
