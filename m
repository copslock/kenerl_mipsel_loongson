Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Jul 2014 20:43:25 +0200 (CEST)
Received: from smtp.outflux.net ([198.145.64.163]:57522 "EHLO smtp.outflux.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6860088AbaGJSkxmADKE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 10 Jul 2014 20:40:53 +0200
Received: from www.outflux.net (serenity.outflux.net [10.2.0.2])
        by vinyl.outflux.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id s6AIeeF9013608;
        Thu, 10 Jul 2014 11:40:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Alexei Starovoitov <ast@plumgrid.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <dborkman@redhat.com>,
        Will Drewry <wad@chromium.org>,
        Julien Tinnes <jln@chromium.org>,
        David Drysdale <drysdale@google.com>,
        linux-api@vger.kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v10 11/11] seccomp: implement SECCOMP_FILTER_FLAG_TSYNC
Date:   Thu, 10 Jul 2014 11:40:31 -0700
Message-Id: <1405017631-27346-12-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1405017631-27346-1-git-send-email-keescook@chromium.org>
References: <1405017631-27346-1-git-send-email-keescook@chromium.org>
X-MIMEDefang-Filter: outflux$Revision: 1.316 $
X-HELO: www.outflux.net
X-Scanned-By: MIMEDefang 2.73
Return-Path: <keescook@www.outflux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41128
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

Applying restrictive seccomp filter programs to large or diverse
codebases often requires handling threads which may be started early in
the process lifetime (e.g., by code that is linked in). While it is
possible to apply permissive programs prior to process start up, it is
difficult to further restrict the kernel ABI to those threads after that
point.

This change adds a new seccomp syscall flag to SECCOMP_SET_MODE_FILTER for
synchronizing thread group seccomp filters at filter installation time.

When calling seccomp(SECCOMP_SET_MODE_FILTER, SECCOMP_FILTER_FLAG_TSYNC,
filter) an attempt will be made to synchronize all threads in current's
threadgroup to its new seccomp filter program. This is possible iff all
threads are using a filter that is an ancestor to the filter current is
attempting to synchronize to. NULL filters (where the task is running as
SECCOMP_MODE_NONE) are also treated as ancestors allowing threads to be
transitioned into SECCOMP_MODE_FILTER. If prctrl(PR_SET_NO_NEW_PRIVS,
...) has been set on the calling thread, no_new_privs will be set for
all synchronized threads too. On success, 0 is returned. On failure,
the pid of one of the failing threads will be returned and no filters
will have been applied.

The race conditions against another thread are:
- requesting TSYNC (already handled by sighand lock)
- performing a clone (already handled by sighand lock)
- changing its filter (already handled by sighand lock)
- calling exec (handled by cred_guard_mutex)
The clone case is assisted by the fact that new threads will have their
seccomp state duplicated from their parent before appearing on the tasklist.

Holding cred_guard_mutex means that seccomp filters cannot be assigned
while in the middle of another thread's exec (potentially bypassing
no_new_privs or similar). The call to de_thread() may kill threads waiting
for the mutex.

Changes across threads to the filter pointer includes a barrier.

Based on patches by Will Drewry.

Suggested-by: Julien Tinnes <jln@chromium.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/exec.c                    |    2 +-
 include/linux/seccomp.h      |    2 +
 include/uapi/linux/seccomp.h |    3 +
 kernel/seccomp.c             |  130 +++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 135 insertions(+), 2 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 0f5c272410f6..ab1f1200ce5d 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1216,7 +1216,7 @@ EXPORT_SYMBOL(install_exec_creds);
 /*
  * determine how safe it is to execute the proposed program
  * - the caller must hold ->cred_guard_mutex to protect against
- *   PTRACE_ATTACH
+ *   PTRACE_ATTACH or seccomp thread-sync
  */
 static void check_unsafe_exec(struct linux_binprm *bprm)
 {
diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index 9ff98b4bfe2e..15de2a711518 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -3,6 +3,8 @@
 
 #include <uapi/linux/seccomp.h>
 
+#define SECCOMP_FILTER_FLAG_MASK	~(SECCOMP_FILTER_FLAG_TSYNC)
+
 #ifdef CONFIG_SECCOMP
 
 #include <linux/thread_info.h>
diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
index b258878ba754..0f238a43ff1e 100644
--- a/include/uapi/linux/seccomp.h
+++ b/include/uapi/linux/seccomp.h
@@ -14,6 +14,9 @@
 #define SECCOMP_SET_MODE_STRICT	0
 #define SECCOMP_SET_MODE_FILTER	1
 
+/* Valid flags for SECCOMP_SET_MODE_FILTER */
+#define SECCOMP_FILTER_FLAG_TSYNC	1
+
 /*
  * All BPF programs must return a 32-bit value.
  * The bottom 16-bits are for optional return data.
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index c6bd5f196d9f..33dbb3907c8a 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -26,6 +26,7 @@
 #ifdef CONFIG_SECCOMP_FILTER
 #include <asm/syscall.h>
 #include <linux/filter.h>
+#include <linux/pid.h>
 #include <linux/ptrace.h>
 #include <linux/security.h>
 #include <linux/tracehook.h>
@@ -225,6 +226,109 @@ static inline void seccomp_assign_mode(struct task_struct *task,
 }
 
 #ifdef CONFIG_SECCOMP_FILTER
+/* Returns 1 if the candidate is an ancestor. */
+static int is_ancestor(struct seccomp_filter *candidate,
+		       struct seccomp_filter *child)
+{
+	/* NULL is the root ancestor. */
+	if (candidate == NULL)
+		return 1;
+	for (; child; child = child->prev)
+		if (child == candidate)
+			return 1;
+	return 0;
+}
+
+/**
+ * seccomp_can_sync_threads: checks if all threads can be synchronized
+ *
+ * Expects sighand and cred_guard_mutex locks to be held.
+ *
+ * Returns 0 on success, -ve on error, or the pid of a thread which was
+ * either not in the correct seccomp mode or it did not have an ancestral
+ * seccomp filter.
+ */
+static inline pid_t seccomp_can_sync_threads(void)
+{
+	struct task_struct *thread, *caller;
+
+	BUG_ON(!mutex_is_locked(&current->signal->cred_guard_mutex));
+	BUG_ON(!spin_is_locked(&current->sighand->siglock));
+
+	if (current->seccomp.mode != SECCOMP_MODE_FILTER)
+		return -EACCES;
+
+	/* Validate all threads being eligible for synchronization. */
+	caller = current;
+	for_each_thread(caller, thread) {
+		pid_t failed;
+
+		if (thread->seccomp.mode == SECCOMP_MODE_DISABLED ||
+		    (thread->seccomp.mode == SECCOMP_MODE_FILTER &&
+		     is_ancestor(thread->seccomp.filter,
+				 caller->seccomp.filter)))
+			continue;
+
+		/* Return the first thread that cannot be synchronized. */
+		failed = task_pid_vnr(thread);
+		/* If the pid cannot be resolved, then return -ESRCH */
+		if (unlikely(WARN_ON(failed == 0)))
+			failed = -ESRCH;
+		return failed;
+	}
+
+	return 0;
+}
+
+/**
+ * seccomp_sync_threads: sets all threads to use current's filter
+ *
+ * Expects sighand and cred_guard_mutex locks to be held, and for
+ * seccomp_can_sync_threads() to have returned success already
+ * without dropping the locks.
+ *
+ */
+static inline void seccomp_sync_threads(void)
+{
+	struct task_struct *thread, *caller;
+
+	BUG_ON(!mutex_is_locked(&current->signal->cred_guard_mutex));
+	BUG_ON(!spin_is_locked(&current->sighand->siglock));
+
+	/* Synchronize all threads. */
+	caller = current;
+	for_each_thread(caller, thread) {
+		/* Get a task reference for the new leaf node. */
+		get_seccomp_filter(caller);
+		/*
+		 * Drop the task reference to the shared ancestor since
+		 * current's path will hold a reference.  (This also
+		 * allows a put before the assignment.)
+		 */
+		put_seccomp_filter(thread);
+		smp_store_release(&thread->seccomp.filter,
+				  caller->seccomp.filter);
+		/*
+		 * Opt the other thread into seccomp if needed.
+		 * As threads are considered to be trust-realm
+		 * equivalent (see ptrace_may_access), it is safe to
+		 * allow one thread to transition the other.
+		 */
+		if (thread->seccomp.mode == SECCOMP_MODE_DISABLED) {
+			/*
+			 * Don't let an unprivileged task work around
+			 * the no_new_privs restriction by creating
+			 * a thread that sets it up, enters seccomp,
+			 * then dies.
+			 */
+			if (task_no_new_privs(caller))
+				task_set_no_new_privs(thread);
+
+			seccomp_assign_mode(thread, SECCOMP_MODE_FILTER);
+		}
+	}
+}
+
 /**
  * seccomp_prepare_filter: Prepares a seccomp filter for use.
  * @fprog: BPF program to install
@@ -362,6 +466,15 @@ static long seccomp_attach_filter(unsigned int flags,
 	if (total_insns > MAX_INSNS_PER_PATH)
 		return -ENOMEM;
 
+	/* If thread sync has been requested, check that it is possible. */
+	if (flags & SECCOMP_FILTER_FLAG_TSYNC) {
+		int ret;
+
+		ret = seccomp_can_sync_threads();
+		if (ret)
+			return ret;
+	}
+
 	/*
 	 * If there is an existing filter, make it the prev and don't drop its
 	 * task reference.
@@ -369,6 +482,10 @@ static long seccomp_attach_filter(unsigned int flags,
 	filter->prev = current->seccomp.filter;
 	current->seccomp.filter = filter;
 
+	/* Now that the new filter is in place, synchronize to all threads. */
+	if (flags & SECCOMP_FILTER_FLAG_TSYNC)
+		seccomp_sync_threads();
+
 	return 0;
 }
 
@@ -588,7 +705,7 @@ static long seccomp_set_mode_filter(unsigned int flags,
 	long ret = -EINVAL;
 
 	/* Validate flags. */
-	if (flags != 0)
+	if (flags & SECCOMP_FILTER_FLAG_MASK)
 		return -EINVAL;
 
 	/* Prepare the new filter before holding any locks. */
@@ -596,6 +713,14 @@ static long seccomp_set_mode_filter(unsigned int flags,
 	if (IS_ERR(prepared))
 		return PTR_ERR(prepared);
 
+	/*
+	 * Make sure we cannot change seccomp or nnp state via TSYNC
+	 * while another thread is in the middle of calling exec.
+	 */
+	if (flags & SECCOMP_FILTER_FLAG_TSYNC &&
+	    mutex_lock_killable(&current->signal->cred_guard_mutex))
+		goto out_free;
+
 	spin_lock_irq(&current->sighand->siglock);
 
 	if (!seccomp_check_mode(seccomp_mode))
@@ -610,6 +735,9 @@ static long seccomp_set_mode_filter(unsigned int flags,
 	seccomp_assign_mode(current, seccomp_mode);
 out:
 	spin_unlock_irq(&current->sighand->siglock);
+	if (flags & SECCOMP_FILTER_FLAG_TSYNC)
+		mutex_unlock(&current->signal->cred_guard_mutex);
+out_free:
 	seccomp_filter_free(prepared);
 	return ret;
 }
-- 
1.7.9.5
