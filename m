Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jan 2015 11:54:59 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:41226 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011344AbbAUKy5vNRZE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Jan 2015 11:54:57 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id D984F5A28472D
        for <linux-mips@linux-mips.org>; Wed, 21 Jan 2015 10:54:49 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 21 Jan 2015 10:54:51 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.96) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 21 Jan 2015 10:54:49 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>
Subject: [PATCH] MIPS: mm: fault: Add debug information for userland SIGSEGV signals
Date:   Wed, 21 Jan 2015 10:54:46 +0000
Message-ID: <1421837686-20216-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.2.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45397
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

Commit 41c594ab65fc ("[MIPS] MT: Improved multithreading support.")
removed useful debug information for userland segmentation faults.
This patch bring this back along with the ability to determine the
name of the object file where the EPC and RA registers point at.
Furthermore, we select the SYSCTL_EXCEPTION_TRACE symbol for MIPS
which is the de facto solution to turn userland exception logging
on and off via the /proc/sys/debug/exception-trace file.

Cc: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
Here is the output for a userland segfault

do_page_fault(): sending SIGSEGV to bash for invalid write access to 0000000000003ee0
epc = 0000000000427c18 in bash[400000+a4000]
ra  = 0000000000427c04 in bash[400000+a4000]
---
 arch/mips/Kconfig    |  1 +
 arch/mips/mm/fault.c | 29 ++++++++++++++++++++---------
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index be42028e11a6..9a7b8f347b30 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -54,6 +54,7 @@ config MIPS
 	select CPU_PM if CPU_IDLE
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_BINFMT_ELF_STATE
+	select SYSCTL_EXCEPTION_TRACE
 
 menu "Machine selection"
 
diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
index becc42bb1849..ef10886dda46 100644
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -14,6 +14,7 @@
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/ptrace.h>
+#include <linux/ratelimit.h>
 #include <linux/mman.h>
 #include <linux/mm.h>
 #include <linux/smp.h>
@@ -28,6 +29,8 @@
 #include <asm/highmem.h>		/* For VMALLOC_END */
 #include <linux/kdebug.h>
 
+int show_unhandled_signals = 1;
+
 /*
  * This routine handles page faults.  It determines the address,
  * and the problem, and then passes it off to one of the appropriate
@@ -44,6 +47,8 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
 	int fault;
 	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
 
+	static DEFINE_RATELIMIT_STATE(ratelimit_state, 5 * HZ, 10);
+
 #if 0
 	printk("Cpu%d[%s:%d:%0*lx:%ld:%0*lx]\n", raw_smp_processor_id(),
 	       current->comm, current->pid, field, address, write,
@@ -201,15 +206,21 @@ bad_area_nosemaphore:
 	if (user_mode(regs)) {
 		tsk->thread.cp0_badvaddr = address;
 		tsk->thread.error_code = write;
-#if 0
-		printk("do_page_fault() #2: sending SIGSEGV to %s for "
-		       "invalid %s\n%0*lx (epc == %0*lx, ra == %0*lx)\n",
-		       tsk->comm,
-		       write ? "write access to" : "read access from",
-		       field, address,
-		       field, (unsigned long) regs->cp0_epc,
-		       field, (unsigned long) regs->regs[31]);
-#endif
+		if (show_unhandled_signals &&
+		    unhandled_signal(tsk, SIGSEGV) &&
+		    __ratelimit(&ratelimit_state)) {
+			pr_info("\ndo_page_fault(): sending SIGSEGV to %s for invalid %s %0*lx",
+				tsk->comm,
+				write ? "write access to" : "read access from",
+				field, address);
+			pr_info("epc = %0*lx in", field,
+				(unsigned long) regs->cp0_epc);
+			print_vma_addr(" ", regs->cp0_epc);
+			pr_info("ra  = %0*lx in", field,
+				(unsigned long) regs->regs[31]);
+			print_vma_addr(" ", regs->regs[31]);
+			pr_info("\n");
+		}
 		info.si_signo = SIGSEGV;
 		info.si_errno = 0;
 		/* info.si_code has been set above */
-- 
2.2.1
