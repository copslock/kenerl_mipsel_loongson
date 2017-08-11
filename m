Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Aug 2017 22:59:07 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:14644 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994817AbdHKU5hVPnpw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Aug 2017 22:57:37 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id AAFEEB7A628C6;
        Fri, 11 Aug 2017 21:57:26 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 11 Aug 2017 21:57:31 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Lars Persson <lars.persson@axis.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Subject: [PATCH 2/4] MIPS/ptrace: Pick up ptrace/seccomp changed syscalls
Date:   Fri, 11 Aug 2017 21:56:51 +0100
Message-ID: <20170811205653.21873-3-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20170811205653.21873-1-james.hogan@imgtec.com>
References: <20170811205653.21873-1-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59489
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

The MIPS syscall_trace_enter() allows the system call number to be
altered or cancelled by a ptrace tracer, via the normal ptrace hook
(PTRACE_SYSCALL) and changing the system call number register on entry,
and similarly via seccomp (PTRACE_EVENT_SECCOMP when a seccomp filter
returns SECCOMP_RET_TRACE).

Be sure to update the syscall local variable if this happens, so that
seccomp will filter the correct system call number if the normal ptrace
hook changes it first, and so that if either the normal ptrace hook or
seccomp change it the correct system call number is passed to the trace
event.

This won't have any effect until the next commit, which fixes ptrace to
update thread_info::syscall.

Fixes: c2d9f1775731 ("MIPS: Fix syscall_get_nr for the syscall exit tracing.")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Lars Persson <lars.persson@axis.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Will Drewry <wad@chromium.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/kernel/ptrace.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index 1395654cfc8d..be5d5fefcc7c 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -864,9 +864,11 @@ asmlinkage long syscall_trace_enter(struct pt_regs *regs, long syscall)
 
 	current_thread_info()->syscall = syscall;
 
-	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
-	    tracehook_report_syscall_entry(regs))
-		return -1;
+	if (test_thread_flag(TIF_SYSCALL_TRACE)) {
+		if (tracehook_report_syscall_entry(regs))
+			return -1;
+		syscall = current_thread_info()->syscall;
+	}
 
 #ifdef CONFIG_SECCOMP
 	if (unlikely(test_thread_flag(TIF_SECCOMP))) {
@@ -884,6 +886,7 @@ asmlinkage long syscall_trace_enter(struct pt_regs *regs, long syscall)
 		ret = __secure_computing(&sd);
 		if (ret == -1)
 			return ret;
+		syscall = current_thread_info()->syscall;
 	}
 #endif
 
-- 
2.13.2
