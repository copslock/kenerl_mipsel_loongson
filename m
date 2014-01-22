Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Jan 2014 15:43:03 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:24642 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825759AbaAVOlb4oQyT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 22 Jan 2014 15:41:31 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 3/8] MIPS: asm: syscall: Define syscall_get_arch
Date:   Wed, 22 Jan 2014 14:39:59 +0000
Message-ID: <1390401604-11830-4-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1390401604-11830-1-git-send-email-markos.chandras@imgtec.com>
References: <1390401604-11830-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_01_22_14_40_36
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39056
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

This effectively renames __syscall_get_arch to syscall_get_arch
and implements a compatible interface for the seccomp API.
The seccomp code (kernel/seccomp.c) expects a syscall_get_arch
function to be defined for every architecture, so we drop
the leading underscores from the existing function.

This also makes use of the 'task' argument to determine the type
the process instead of assuming the process has the same
characteristics as the kernel it's running on.

Reviewed-by: Paul Burton <paul.burton@imgtec.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/syscall.h | 6 ++++--
 arch/mips/kernel/ptrace.c       | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/syscall.h b/arch/mips/include/asm/syscall.h
index e3e2f76..e7e0210 100644
--- a/arch/mips/include/asm/syscall.h
+++ b/arch/mips/include/asm/syscall.h
@@ -106,11 +106,13 @@ extern const unsigned long sys_call_table[];
 extern const unsigned long sys32_call_table[];
 extern const unsigned long sysn32_call_table[];
 
-static inline int __syscall_get_arch(void)
+static inline int syscall_get_arch(struct task_struct *task,
+				   struct pt_regs *regs)
 {
 	int arch = EM_MIPS;
 #ifdef CONFIG_64BIT
-	arch |=  __AUDIT_ARCH_64BIT;
+	if (!test_tsk_thread_flag(task, TIF_32BIT_REGS))
+		arch |= __AUDIT_ARCH_64BIT;
 #endif
 #if defined(__LITTLE_ENDIAN)
 	arch |=  __AUDIT_ARCH_LE;
diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index 7da9b76..fe5af54 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -677,7 +677,7 @@ asmlinkage void syscall_trace_enter(struct pt_regs *regs)
 	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
 		trace_sys_enter(regs, regs->regs[2]);
 
-	audit_syscall_entry(__syscall_get_arch(),
+	audit_syscall_entry(syscall_get_arch(current, regs),
 			    regs->regs[2],
 			    regs->regs[4], regs->regs[5],
 			    regs->regs[6], regs->regs[7]);
-- 
1.8.5.3
