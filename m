Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jun 2014 01:05:53 +0200 (CEST)
Received: from smtp.outflux.net ([198.145.64.163]:40438 "EHLO smtp.outflux.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6859996AbaFJXERwQPCe (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 11 Jun 2014 01:04:17 +0200
Received: from www.outflux.net (serenity.outflux.net [10.2.0.2])
        by vinyl.outflux.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id s5AN2MHX021952;
        Tue, 10 Jun 2014 16:02:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        Will Drewry <wad@chromium.org>,
        Julien Tinnes <jln@chromium.org>,
        David Drysdale <drysdale@google.com>,
        Alexei Starovoitov <ast@plumgrid.com>,
        John Johansen <john.johansen@canonical.com>,
        Russell King <linux@arm.linux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        James Morris <james.l.morris@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        "David A. Long" <dave.long@linaro.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Kevin Hilman <khilman@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Juri Lelli <juri.lelli@gmail.com>,
        Miklos Szeredi <mszeredi@suse.cz>,
        Dario Faggioli <raistlin@linux.it>,
        Markos Chandras <markos.chandras@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Huacai Chen <chenhc@lemote.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Mike Frysinger <vapier@gentoo.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <dborkman@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Rik van Riel <riel@redhat.com>,
        Daeseok Youn <daeseok.youn@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Eric Paris <eparis@redhat.com>,
        Fabian Frederick <fabf@skynet.be>, Robin Holt <holt@sgi.com>,
        Dongsheng Yang <yangds.fnst@cn.fujitsu.com>,
        liguang <lig.fnst@cn.fujitsu.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alex Thorlton <athorlton@sgi.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org
Subject: [PATCH v6 6/9] seccomp: add "seccomp" syscall
Date:   Tue, 10 Jun 2014 16:01:51 -0700
Message-Id: <1402441314-7447-7-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1402441314-7447-1-git-send-email-keescook@chromium.org>
References: <1402441314-7447-1-git-send-email-keescook@chromium.org>
X-MIMEDefang-Filter: outflux$Revision: 1.316 $
X-HELO: www.outflux.net
X-Scanned-By: MIMEDefang 2.73
Return-Path: <keescook@www.outflux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40469
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

Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: linux-api@vger.kernel.org
---
 arch/x86/syscalls/syscall_32.tbl  |    1 +
 arch/x86/syscalls/syscall_64.tbl  |    1 +
 include/linux/syscalls.h          |    2 ++
 include/uapi/asm-generic/unistd.h |    4 ++-
 include/uapi/linux/seccomp.h      |    4 +++
 kernel/seccomp.c                  |   63 ++++++++++++++++++++++++++++++++-----
 kernel/sys_ni.c                   |    3 ++
 7 files changed, 69 insertions(+), 9 deletions(-)

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
index 39d32c2904fc..c0cafa9e84af 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -19,6 +19,7 @@
 #include <linux/sched.h>
 #include <linux/seccomp.h>
 #include <linux/slab.h>
+#include <linux/syscalls.h>
 
 /* #define SECCOMP_DEBUG 1 */
 
@@ -301,8 +302,8 @@ free_prog:
  *
  * Returns filter on success and ERR_PTR otherwise.
  */
-static
-struct seccomp_filter *seccomp_prepare_user_filter(char __user *user_filter)
+static struct seccomp_filter *
+seccomp_prepare_user_filter(const char __user *user_filter)
 {
 	struct sock_fprog fprog;
 	struct seccomp_filter *filter = ERR_PTR(-EFAULT);
@@ -325,19 +326,25 @@ out:
 
 /**
  * seccomp_attach_filter: validate and attach filter
+ * @flags:  flags to change filter behavior
  * @filter: seccomp filter to add to the current process
  *
  * Caller must be holding current->sighand->siglock lock.
  *
  * Returns 0 on success, -ve on error.
  */
-static long seccomp_attach_filter(struct seccomp_filter *filter)
+static long seccomp_attach_filter(unsigned int flags,
+				  struct seccomp_filter *filter)
 {
 	unsigned long total_insns;
 	struct seccomp_filter *walker;
 
 	BUG_ON(!spin_is_locked(&current->sighand->siglock));
 
+	/* Validate flags. */
+	if (flags != 0)
+		return -EINVAL;
+
 	/* Validate resulting filter length. */
 	total_insns = filter->len;
 	for (walker = current->seccomp.filter; walker; walker = filter->prev)
@@ -541,6 +548,7 @@ out:
 #ifdef CONFIG_SECCOMP_FILTER
 /**
  * seccomp_set_mode_filter: internal function for setting seccomp filter
+ * @flags:  flags to change filter behavior
  * @filter: struct sock_fprog containing filter
  *
  * This function may be called repeatedly to install additional filters.
@@ -551,7 +559,8 @@ out:
  *
  * Returns 0 on success or -EINVAL on failure.
  */
-static long seccomp_set_mode_filter(char __user *filter)
+static long seccomp_set_mode_filter(unsigned int flags,
+				    const char __user *filter)
 {
 	const unsigned long seccomp_mode = SECCOMP_MODE_FILTER;
 	struct seccomp_filter *prepared = NULL;
@@ -569,7 +578,7 @@ static long seccomp_set_mode_filter(char __user *filter)
 	if (!seccomp_check_mode(current, seccomp_mode))
 		goto out;
 
-	ret = seccomp_attach_filter(prepared);
+	ret = seccomp_attach_filter(flags, prepared);
 	if (ret)
 		goto out;
 	/* Do not free the successfully attached filter. */
@@ -583,12 +592,35 @@ out_free:
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
@@ -598,12 +630,27 @@ static inline long seccomp_set_mode_filter(char __user *filter)
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
