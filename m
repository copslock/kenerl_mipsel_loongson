Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Aug 2017 22:58:11 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:2797 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994815AbdHKU5gsES-w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Aug 2017 22:57:36 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id F3AA4A517A422;
        Fri, 11 Aug 2017 21:57:25 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 11 Aug 2017 21:57:30 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        <netdev@vger.kernel.org>
Subject: [PATCH 1/4] MIPS/seccomp: Fix indirect syscall args
Date:   Fri, 11 Aug 2017 21:56:50 +0100
Message-ID: <20170811205653.21873-2-james.hogan@imgtec.com>
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
X-archive-position: 59487
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

Since commit 669c4092225f ("MIPS: Give __secure_computing() access to
syscall arguments."), upon syscall entry when seccomp is enabled,
syscall_trace_enter() passes a carefully prepared struct seccomp_data
containing syscall arguments to __secure_computing(). Unfortunately it
directly uses mips_get_syscall_arg() and fails to take into account the
indirect O32 system calls (i.e. syscall(2)) which put the system call
number in a0 and have the arguments shifted up by one entry.

We can't just revert that commit as samples/bpf/tracex5 would break
again, so use syscall_get_arguments() which already takes indirect
syscalls into account instead of directly using mips_get_syscall_arg(),
similar to what populate_seccomp_data() does.

This also removes the redundant error checking of the
mips_get_syscall_arg() return value (get_user() already zeroes the
result if an argument from the stack can't be loaded).

Reported-by: James Cowgill <James.Cowgill@imgtec.com>
Fixes: 669c4092225f ("MIPS: Give __secure_computing() access to syscall arguments.")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: David Daney <david.daney@cavium.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Will Drewry <wad@chromium.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
---
It would have been much simpler for MIPS arch code to just pass a NULL
seccomp_data to secure_computing() so populate_seccomp_data() would take
care of fetching arguments, as it did for MIPS prior to commit
669c4092225f ("MIPS: Give __secure_computing() access to syscall
arguments."), but as that commit mentions it breaks samples/bpf/tracex5,
which relies on sd being non-NULL at entry to __seccomp_filter().

Arguably the samples/bpf/tracex5 test is flawed, at least for every arch
except x86 (and now MIPS).
---
 arch/mips/kernel/ptrace.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index 6dd13641a418..1395654cfc8d 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -872,15 +872,13 @@ asmlinkage long syscall_trace_enter(struct pt_regs *regs, long syscall)
 	if (unlikely(test_thread_flag(TIF_SECCOMP))) {
 		int ret, i;
 		struct seccomp_data sd;
+		unsigned long args[6];
 
 		sd.nr = syscall;
 		sd.arch = syscall_get_arch();
-		for (i = 0; i < 6; i++) {
-			unsigned long v, r;
-
-			r = mips_get_syscall_arg(&v, current, regs, i);
-			sd.args[i] = r ? 0 : v;
-		}
+		syscall_get_arguments(current, regs, 0, 6, args);
+		for (i = 0; i < 6; i++)
+			sd.args[i] = args[i];
 		sd.instruction_pointer = KSTK_EIP(current);
 
 		ret = __secure_computing(&sd);
-- 
2.13.2
