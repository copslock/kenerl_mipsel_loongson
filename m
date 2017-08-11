Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Aug 2017 22:59:32 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:30441 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994820AbdHKU5jRbWyw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Aug 2017 22:57:39 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 4F8E3DCDB1BDE;
        Fri, 11 Aug 2017 21:57:28 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 11 Aug 2017 21:57:32 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Subject: [PATCH 4/4] MIPS/ptrace: Add PTRACE_SET_SYSCALL operation
Date:   Fri, 11 Aug 2017 21:56:53 +0100
Message-ID: <20170811205653.21873-5-james.hogan@imgtec.com>
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
X-archive-position: 59490
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

Add a PTRACE_SET_SYSCALL ptrace operation to allow the system call to be
cancelled independently to the value of the v0 system call number
register.

This is needed for SECCOMP_RET_TRACE when the tracer wants to cancel the
system call, since it has to set both the system call number to -1 and
the chosen return value, both of which reside in the same register (v0).
The tracer should set the return value first, followed by
PTRACE_SET_SYSCALL to set the system call number to -1.

That is in contrast to the normal ptrace syscall hook which triggers the
tracer on both entry and exit, allowing the system call to be cancelled
during the entry hook (setting system call number register to -1, or
optionally using PTRACE_SET_SYSCALL), separately to setting the return
value during the exit hook.

Positive values (to change the syscall that should be executed instead
of cancelling it entirely) are explicitly disallowed at the moment. The
same thing can be done safely already by writing the v0 system call
number register and the argument registers, and allowing
thread_info::syscall to be changed to a different value independently of
the v0 register would potentially allow seccomp or the syscall trace
events to be fooled into thinking a different system call was being
executed.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Will Drewry <wad@chromium.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/uapi/asm/ptrace.h |  1 +
 arch/mips/kernel/ptrace.c           | 11 +++++++++++
 arch/mips/kernel/ptrace32.c         | 11 +++++++++++
 3 files changed, 23 insertions(+)

diff --git a/arch/mips/include/uapi/asm/ptrace.h b/arch/mips/include/uapi/asm/ptrace.h
index 91a3d197ede3..23af103c4e8d 100644
--- a/arch/mips/include/uapi/asm/ptrace.h
+++ b/arch/mips/include/uapi/asm/ptrace.h
@@ -58,6 +58,7 @@ struct pt_regs {
 
 #define PTRACE_GET_THREAD_AREA	25
 #define PTRACE_SET_THREAD_AREA	26
+#define PTRACE_SET_SYSCALL	27
 
 /* Calls to trace a 64bit program from a 32bit program.	 */
 #define PTRACE_PEEKTEXT_3264	0xc0
diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index 465fc5633e61..9bf31a990c6e 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -853,6 +853,17 @@ long arch_ptrace(struct task_struct *child, long request,
 		ret = put_user(task_thread_info(child)->tp_value, datalp);
 		break;
 
+	case PTRACE_SET_SYSCALL:
+		/*
+		 * This is currently only useful to cancel the syscall from a
+		 * seccomp RET_TRACE tracer.
+		 */
+		if ((long)data >= 0)
+			return -EINVAL;
+		task_thread_info(child)->syscall = -1;
+		ret = 0;
+		break;
+
 	case PTRACE_GET_WATCH_REGS:
 		ret = ptrace_get_watch_regs(child, addrp);
 		break;
diff --git a/arch/mips/kernel/ptrace32.c b/arch/mips/kernel/ptrace32.c
index 2b9260f92ccd..cca76aec9c10 100644
--- a/arch/mips/kernel/ptrace32.c
+++ b/arch/mips/kernel/ptrace32.c
@@ -287,6 +287,17 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 				(unsigned int __user *) (unsigned long) data);
 		break;
 
+	case PTRACE_SET_SYSCALL:
+		/*
+		 * This is currently only useful to cancel the syscall from a
+		 * seccomp RET_TRACE tracer.
+		 */
+		if ((long)data >= 0)
+			return -EINVAL;
+		task_thread_info(child)->syscall = -1;
+		ret = 0;
+		break;
+
 	case PTRACE_GET_THREAD_AREA_3264:
 		ret = put_user(task_thread_info(child)->tp_value,
 				(unsigned long __user *) (unsigned long) data);
-- 
2.13.2
