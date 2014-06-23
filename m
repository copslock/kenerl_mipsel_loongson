Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jun 2014 23:58:30 +0200 (CEST)
Received: from smtp.outflux.net ([198.145.64.163]:33850 "EHLO smtp.outflux.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6859996AbaFWV610AgvU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 23 Jun 2014 23:58:27 +0200
Received: from www.outflux.net (serenity.outflux.net [10.2.0.2])
        by vinyl.outflux.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id s5NLwH19002905;
        Mon, 23 Jun 2014 14:58:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Alexei Starovoitov <ast@plumgrid.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <dborkman@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Will Drewry <wad@chromium.org>,
        Julien Tinnes <jln@chromium.org>,
        David Drysdale <drysdale@google.com>,
        linux-api@vger.kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v7 2/9] seccomp: split filter prep from check and apply
Date:   Mon, 23 Jun 2014 14:58:06 -0700
Message-Id: <1403560693-21809-3-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1403560693-21809-1-git-send-email-keescook@chromium.org>
References: <1403560693-21809-1-git-send-email-keescook@chromium.org>
X-MIMEDefang-Filter: outflux$Revision: 1.316 $
X-HELO: www.outflux.net
X-Scanned-By: MIMEDefang 2.73
Return-Path: <keescook@www.outflux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40682
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

In preparation for adding seccomp locking, move filter creation away
from where it is checked and applied. This will allow for locking where
no memory allocation is happening. The validation, filter attachment,
and seccomp mode setting can all happen under the future locks.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/seccomp.c |   97 +++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 67 insertions(+), 30 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index afb916c7e890..edc8c79ed16d 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -18,6 +18,7 @@
 #include <linux/compat.h>
 #include <linux/sched.h>
 #include <linux/seccomp.h>
+#include <linux/slab.h>
 
 /* #define SECCOMP_DEBUG 1 */
 
@@ -26,7 +27,6 @@
 #include <linux/filter.h>
 #include <linux/ptrace.h>
 #include <linux/security.h>
-#include <linux/slab.h>
 #include <linux/tracehook.h>
 #include <linux/uaccess.h>
 
@@ -196,27 +196,21 @@ static u32 seccomp_run_filters(int syscall)
 }
 
 /**
- * seccomp_attach_filter: Attaches a seccomp filter to current.
+ * seccomp_prepare_filter: Prepares a seccomp filter for use.
  * @fprog: BPF program to install
  *
- * Returns 0 on success or an errno on failure.
+ * Returns filter on success or an ERR_PTR on failure.
  */
-static long seccomp_attach_filter(struct sock_fprog *fprog)
+static struct seccomp_filter *seccomp_prepare_filter(struct sock_fprog *fprog)
 {
 	struct seccomp_filter *filter;
 	unsigned long fp_size = fprog->len * sizeof(struct sock_filter);
-	unsigned long total_insns = fprog->len;
 	struct sock_filter *fp;
 	int new_len;
 	long ret;
 
 	if (fprog->len == 0 || fprog->len > BPF_MAXINSNS)
-		return -EINVAL;
-
-	for (filter = current->seccomp.filter; filter; filter = filter->prev)
-		total_insns += filter->prog->len + 4;  /* include a 4 instr penalty */
-	if (total_insns > MAX_INSNS_PER_PATH)
-		return -ENOMEM;
+		return ERR_PTR(-EINVAL);
 
 	/*
 	 * Installing a seccomp filter requires that the task has
@@ -227,11 +221,11 @@ static long seccomp_attach_filter(struct sock_fprog *fprog)
 	if (!current->no_new_privs &&
 	    security_capable_noaudit(current_cred(), current_user_ns(),
 				     CAP_SYS_ADMIN) != 0)
-		return -EACCES;
+		return ERR_PTR(-EACCES);
 
 	fp = kzalloc(fp_size, GFP_KERNEL|__GFP_NOWARN);
 	if (!fp)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	/* Copy the instructions from fprog. */
 	ret = -EFAULT;
@@ -275,13 +269,7 @@ static long seccomp_attach_filter(struct sock_fprog *fprog)
 
 	sk_filter_select_runtime(filter->prog);
 
-	/*
-	 * If there is an existing filter, make it the prev and don't drop its
-	 * task reference.
-	 */
-	filter->prev = current->seccomp.filter;
-	current->seccomp.filter = filter;
-	return 0;
+	return filter;
 
 free_filter_prog:
 	kfree(filter->prog);
@@ -289,19 +277,20 @@ free_filter:
 	kfree(filter);
 free_prog:
 	kfree(fp);
-	return ret;
+	return ERR_PTR(ret);
 }
 
 /**
- * seccomp_attach_user_filter - attaches a user-supplied sock_fprog
+ * seccomp_prepare_user_filter - prepares a user-supplied sock_fprog
  * @user_filter: pointer to the user data containing a sock_fprog.
  *
- * Returns 0 on success and non-zero otherwise.
+ * Returns filter on success and ERR_PTR otherwise.
  */
-static long seccomp_attach_user_filter(char __user *user_filter)
+static
+struct seccomp_filter *seccomp_prepare_user_filter(char __user *user_filter)
 {
 	struct sock_fprog fprog;
-	long ret = -EFAULT;
+	struct seccomp_filter *filter = ERR_PTR(-EFAULT);
 
 #ifdef CONFIG_COMPAT
 	if (is_compat_task()) {
@@ -314,9 +303,37 @@ static long seccomp_attach_user_filter(char __user *user_filter)
 #endif
 	if (copy_from_user(&fprog, user_filter, sizeof(fprog)))
 		goto out;
-	ret = seccomp_attach_filter(&fprog);
+	filter = seccomp_prepare_filter(&fprog);
 out:
-	return ret;
+	return filter;
+}
+
+/**
+ * seccomp_attach_filter: validate and attach filter
+ * @filter: seccomp filter to add to the current process
+ *
+ * Returns 0 on success, -ve on error.
+ */
+static long seccomp_attach_filter(struct seccomp_filter *filter)
+{
+	unsigned long total_insns;
+	struct seccomp_filter *walker;
+
+	/* Validate resulting filter length. */
+	total_insns = filter->prog->len;
+	for (walker = current->seccomp.filter; walker; walker = walker->prev)
+		total_insns += walker->prog->len + 4;  /* 4 instr penalty */
+	if (total_insns > MAX_INSNS_PER_PATH)
+		return -ENOMEM;
+
+	/*
+	 * If there is an existing filter, make it the prev and don't drop its
+	 * task reference.
+	 */
+	filter->prev = current->seccomp.filter;
+	current->seccomp.filter = filter;
+
+	return 0;
 }
 
 /* get_seccomp_filter - increments the reference count of the filter on @tsk */
@@ -329,6 +346,14 @@ void get_seccomp_filter(struct task_struct *tsk)
 	atomic_inc(&orig->usage);
 }
 
+static inline void seccomp_filter_free(struct seccomp_filter *filter)
+{
+	if (filter) {
+		sk_filter_free(filter->prog);
+		kfree(filter);
+	}
+}
+
 /* put_seccomp_filter - decrements the ref count of tsk->seccomp.filter */
 void put_seccomp_filter(struct task_struct *tsk)
 {
@@ -337,8 +362,7 @@ void put_seccomp_filter(struct task_struct *tsk)
 	while (orig && atomic_dec_and_test(&orig->usage)) {
 		struct seccomp_filter *freeme = orig;
 		orig = orig->prev;
-		sk_filter_free(freeme->prog);
-		kfree(freeme);
+		seccomp_filter_free(freeme);
 	}
 }
 
@@ -488,8 +512,18 @@ long prctl_get_seccomp(void)
  */
 static long seccomp_set_mode(unsigned long seccomp_mode, char __user *filter)
 {
+	struct seccomp_filter *prepared = NULL;
 	long ret = -EINVAL;
 
+#ifdef CONFIG_SECCOMP_FILTER
+	/* Prepare the new filter outside of the seccomp lock. */
+	if (seccomp_mode == SECCOMP_MODE_FILTER) {
+		prepared = seccomp_prepare_user_filter(filter);
+		if (IS_ERR(prepared))
+			return PTR_ERR(prepared);
+	}
+#endif
+
 	if (current->seccomp.mode &&
 	    current->seccomp.mode != seccomp_mode)
 		goto out;
@@ -503,9 +537,11 @@ static long seccomp_set_mode(unsigned long seccomp_mode, char __user *filter)
 		break;
 #ifdef CONFIG_SECCOMP_FILTER
 	case SECCOMP_MODE_FILTER:
-		ret = seccomp_attach_user_filter(filter);
+		ret = seccomp_attach_filter(prepared);
 		if (ret)
 			goto out;
+		/* Do not free the successfully attached filter. */
+		prepared = NULL;
 		break;
 #endif
 	default:
@@ -515,6 +551,7 @@ static long seccomp_set_mode(unsigned long seccomp_mode, char __user *filter)
 	current->seccomp.mode = seccomp_mode;
 	set_thread_flag(TIF_SECCOMP);
 out:
+	seccomp_filter_free(prepared);
 	return ret;
 }
 
-- 
1.7.9.5
