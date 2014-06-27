Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Jun 2014 01:24:04 +0200 (CEST)
Received: from smtp.outflux.net ([198.145.64.163]:46727 "EHLO smtp.outflux.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6860051AbaF0XXRMUgIM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 28 Jun 2014 01:23:17 +0200
Received: from www.outflux.net (serenity.outflux.net [10.2.0.2])
        by vinyl.outflux.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id s5RNN6Sq026770;
        Fri, 27 Jun 2014 16:23:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Alexei Starovoitov <ast@plumgrid.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <dborkman@redhat.com>,
        Will Drewry <wad@chromium.org>,
        Julien Tinnes <jln@chromium.org>,
        David Drysdale <drysdale@google.com>,
        linux-api@vger.kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v9 04/11] seccomp: add "seccomp" syscall
Date:   Fri, 27 Jun 2014 16:22:53 -0700
Message-Id: <1403911380-27787-5-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1403911380-27787-1-git-send-email-keescook@chromium.org>
References: <1403911380-27787-1-git-send-email-keescook@chromium.org>
X-MIMEDefang-Filter: outflux$Revision: 1.316 $
X-HELO: www.outflux.net
X-Scanned-By: MIMEDefang 2.73
Return-Path: <keescook@www.outflux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40892
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keescook@chromium.org
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

This adds the new "seccomp" syscall with both an "operation" and "flags"
parameter for future expansion. The third argument is a pointer value,
used with the SECCOMP_SET_MODE_FILTER operation. Currently, flags must
be 0. This is functionally equivalent to prctl(PR_SET_SECCOMP, ...).

In addition to the TSYNC flag later in this patch series, there is a
non-zero chance that this syscall could be used for configuring a fixed
argument area for seccomp-tracer-aware processes to pass syscall arguments
in the future. Hence, the use of "seccomp" not simply "seccomp_add_filter"
for this syscall. Additionally, this syscall uses operation, flags,
and user pointer for arguments because strictly passing arguments via
a user pointer would mean seccomp itself would be unable to trivially
filter the seccomp syscall itself.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/Kconfig                      |    1 +
 arch/x86/syscalls/syscall_32.tbl  |    1 +
 arch/x86/syscalls/syscall_64.tbl  |    1 +
 include/linux/syscalls.h          |    2 ++
 include/uapi/asm-generic/unistd.h |    4 ++-
 include/uapi/linux/seccomp.h      |    4 +++
 kernel/seccomp.c                  |   55 +++++++++++++++++++++++++++++++++----
 kernel/sys_ni.c                   |    3 ++
 8 files changed, 65 insertions(+), 6 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 97ff872c7acc..0eae9df35b88 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -321,6 +321,7 @@ config HAVE_ARCH_SECCOMP_FILTER
 	  - secure_computing is called from a ptrace_event()-safe context
 	  - secure_computing return value is checked and a return value of -1
 	    results in the system call being skipped immediately.
+	  - seccomp syscall wired up
 
 config SECCOMP_FILTER
 	def_bool y
diff --git a/arch/x86/syscalls/syscall_32.tbl b/arch/x86/syscalls/syscall_32.tbl
index d6b867921612..7527eac24122 100644
--- a/arch/x86/syscalls/syscall_32.tbl
+++ b/arch/x86/syscalls/syscall_32.tbl
@@ -360,3 +360,4 @@
 351	i386	sched_setattr		sys_sched_setattr
 352	i386	sched_getattr		sys_sched_getattr
 353	i386	renameat2		sys_renameat2
+354	i386	seccomp			sys_seccomp
diff --git a/arch/x86/syscalls/syscall_64.tbl b/arch/x86/syscalls/syscall_64.tbl
index ec255a1646d2..16272a6c12b7 100644
--- a/arch/x86/syscalls/syscall_64.tbl
+++ b/arch/x86/syscalls/syscall_64.tbl
@@ -323,6 +323,7 @@
 314	common	sched_setattr		sys_sched_setattr
 315	common	sched_getattr		sys_sched_getattr
 316	common	renameat2		sys_renameat2
+317	common	seccomp			sys_seccomp
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index b0881a0ed322..1713977ee26f 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -866,4 +866,6 @@ asmlinkage long sys_process_vm_writev(pid_t pid,
 asmlinkage long sys_kcmp(pid_t pid1, pid_t pid2, int type,
 			 unsigned long idx1, unsigned long idx2);
 asmlinkage long sys_finit_module(int fd, const char __user *uargs, int flags);
+asmlinkage long sys_seccomp(unsigned int op, unsigned int flags,
+			    const char __user *uargs);
 #endif
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 333640608087..65acbf0e2867 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -699,9 +699,11 @@ __SYSCALL(__NR_sched_setattr, sys_sched_setattr)
 __SYSCALL(__NR_sched_getattr, sys_sched_getattr)
 #define __NR_renameat2 276
 __SYSCALL(__NR_renameat2, sys_renameat2)
+#define __NR_seccomp 277
+__SYSCALL(__NR_seccomp, sys_seccomp)
 
 #undef __NR_syscalls
-#define __NR_syscalls 277
+#define __NR_syscalls 278
 
 /*
  * All syscalls below here should go away really,
diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
index ac2dc9f72973..b258878ba754 100644
--- a/include/uapi/linux/seccomp.h
+++ b/include/uapi/linux/seccomp.h
@@ -10,6 +10,10 @@
 #define SECCOMP_MODE_STRICT	1 /* uses hard-coded filter. */
 #define SECCOMP_MODE_FILTER	2 /* uses user-supplied filter. */
 
+/* Valid operations for seccomp syscall. */
+#define SECCOMP_SET_MODE_STRICT	0
+#define SECCOMP_SET_MODE_FILTER	1
+
 /*
  * All BPF programs must return a 32-bit value.
  * The bottom 16-bits are for optional return data.
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 812cea2e7ffb..2f83496d6016 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -18,6 +18,7 @@
 #include <linux/compat.h>
 #include <linux/sched.h>
 #include <linux/seccomp.h>
+#include <linux/syscalls.h>
 
 /* #define SECCOMP_DEBUG 1 */
 
@@ -314,7 +315,7 @@ free_prog:
  *
  * Returns 0 on success and non-zero otherwise.
  */
-static long seccomp_attach_user_filter(char __user *user_filter)
+static long seccomp_attach_user_filter(const char __user *user_filter)
 {
 	struct sock_fprog fprog;
 	long ret = -EFAULT;
@@ -517,6 +518,7 @@ out:
 #ifdef CONFIG_SECCOMP_FILTER
 /**
  * seccomp_set_mode_filter: internal function for setting seccomp filter
+ * @flags:  flags to change filter behavior
  * @filter: struct sock_fprog containing filter
  *
  * This function may be called repeatedly to install additional filters.
@@ -527,11 +529,16 @@ out:
  *
  * Returns 0 on success or -EINVAL on failure.
  */
-static long seccomp_set_mode_filter(char __user *filter)
+static long seccomp_set_mode_filter(unsigned int flags,
+				    const char __user *filter)
 {
 	const unsigned long seccomp_mode = SECCOMP_MODE_FILTER;
 	long ret = -EINVAL;
 
+	/* Validate flags. */
+	if (flags != 0)
+		goto out;
+
 	if (!seccomp_check_mode(seccomp_mode))
 		goto out;
 
@@ -544,12 +551,35 @@ out:
 	return ret;
 }
 #else
-static inline long seccomp_set_mode_filter(char __user *filter)
+static inline long seccomp_set_mode_filter(unsigned int flags,
+					   const char __user *filter)
 {
 	return -EINVAL;
 }
 #endif
 
+/* Common entry point for both prctl and syscall. */
+static long do_seccomp(unsigned int op, unsigned int flags,
+		       const char __user *uargs)
+{
+	switch (op) {
+	case SECCOMP_SET_MODE_STRICT:
+		if (flags != 0 || uargs != NULL)
+			return -EINVAL;
+		return seccomp_set_mode_strict();
+	case SECCOMP_SET_MODE_FILTER:
+		return seccomp_set_mode_filter(flags, uargs);
+	default:
+		return -EINVAL;
+	}
+}
+
+SYSCALL_DEFINE3(seccomp, unsigned int, op, unsigned int, flags,
+			 const char __user *, uargs)
+{
+	return do_seccomp(op, flags, uargs);
+}
+
 /**
  * prctl_set_seccomp: configures current->seccomp.mode
  * @seccomp_mode: requested mode to use
@@ -559,12 +589,27 @@ static inline long seccomp_set_mode_filter(char __user *filter)
  */
 long prctl_set_seccomp(unsigned long seccomp_mode, char __user *filter)
 {
+	unsigned int op;
+	char __user *uargs;
+
 	switch (seccomp_mode) {
 	case SECCOMP_MODE_STRICT:
-		return seccomp_set_mode_strict();
+		op = SECCOMP_SET_MODE_STRICT;
+		/*
+		 * Setting strict mode through prctl always ignored filter,
+		 * so make sure it is always NULL here to pass the internal
+		 * check in do_seccomp().
+		 */
+		uargs = NULL;
+		break;
 	case SECCOMP_MODE_FILTER:
-		return seccomp_set_mode_filter(filter);
+		op = SECCOMP_SET_MODE_FILTER;
+		uargs = filter;
+		break;
 	default:
 		return -EINVAL;
 	}
+
+	/* prctl interface doesn't have flags, so they are always zero. */
+	return do_seccomp(op, 0, uargs);
 }
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 36441b51b5df..2904a2105914 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -213,3 +213,6 @@ cond_syscall(compat_sys_open_by_handle_at);
 
 /* compare kernel pointers */
 cond_syscall(sys_kcmp);
+
+/* operate on Secure Computing state */
+cond_syscall(sys_seccomp);
-- 
1.7.9.5
