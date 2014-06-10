Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jun 2014 01:04:56 +0200 (CEST)
Received: from smtp.outflux.net ([198.145.64.163]:37849 "EHLO smtp.outflux.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6859992AbaFJXEN1RpxJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 11 Jun 2014 01:04:13 +0200
Received: from www.outflux.net (serenity.outflux.net [10.2.0.2])
        by vinyl.outflux.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id s5AN2Obn021942;
        Tue, 10 Jun 2014 16:02:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
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
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-security-module@vger.kernel.org,
        x86@kernel.org
Subject: [PATCH v6 4/9] seccomp: move no_new_privs into seccomp
Date:   Tue, 10 Jun 2014 16:01:49 -0700
Message-Id: <1402441314-7447-5-git-send-email-keescook@chromium.org>
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
X-archive-position: 40466
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

Since seccomp transitions between threads requires updates to the
no_new_privs flag to be atomic, changes must be atomic. This moves the nnp
flag into the seccomp field as a separate unsigned long for atomic access.

Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Andy Lutomirski <luto@amacapital.net>
---
 fs/exec.c                  |    4 ++--
 include/linux/sched.h      |   13 ++++++++++---
 include/linux/seccomp.h    |    8 +++++++-
 kernel/seccomp.c           |    2 +-
 kernel/sys.c               |    4 ++--
 security/apparmor/domain.c |    4 ++--
 6 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 238b7aa26f68..614fcb993739 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1233,7 +1233,7 @@ static void check_unsafe_exec(struct linux_binprm *bprm)
 	 * This isn't strictly necessary, but it makes it harder for LSMs to
 	 * mess up.
 	 */
-	if (current->no_new_privs)
+	if (task_no_new_privs(current))
 		bprm->unsafe |= LSM_UNSAFE_NO_NEW_PRIVS;
 
 	t = p;
@@ -1271,7 +1271,7 @@ int prepare_binprm(struct linux_binprm *bprm)
 	bprm->cred->egid = current_egid();
 
 	if (!(bprm->file->f_path.mnt->mnt_flags & MNT_NOSUID) &&
-	    !current->no_new_privs &&
+	    !task_no_new_privs(current) &&
 	    kuid_has_mapping(bprm->cred->user_ns, inode->i_uid) &&
 	    kgid_has_mapping(bprm->cred->user_ns, inode->i_gid)) {
 		/* Set-uid? */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index ea74596014a2..50b41affb7b1 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1307,9 +1307,6 @@ struct task_struct {
 				 * execve */
 	unsigned in_iowait:1;
 
-	/* task may not gain privileges */
-	unsigned no_new_privs:1;
-
 	/* Revert to default priority/policy when forking */
 	unsigned sched_reset_on_fork:1;
 	unsigned sched_contributes_to_load:1;
@@ -2525,6 +2522,16 @@ static inline void task_unlock(struct task_struct *p)
 	spin_unlock(&p->alloc_lock);
 }
 
+static inline bool task_no_new_privs(struct task_struct *p)
+{
+	return test_bit(SECCOMP_FLAG_NO_NEW_PRIVS, &p->seccomp.flags);
+}
+
+static inline void task_set_no_new_privs(struct task_struct *p)
+{
+	set_bit(SECCOMP_FLAG_NO_NEW_PRIVS, &p->seccomp.flags);
+}
+
 extern struct sighand_struct *__lock_task_sighand(struct task_struct *tsk,
 							unsigned long *flags);
 
diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index 9ff98b4bfe2e..6a5e2d0ec912 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -3,6 +3,8 @@
 
 #include <uapi/linux/seccomp.h>
 
+#define SECCOMP_FLAG_NO_NEW_PRIVS	0	/* task may not gain privs */
+
 #ifdef CONFIG_SECCOMP
 
 #include <linux/thread_info.h>
@@ -16,6 +18,7 @@ struct seccomp_filter;
  *         system calls available to a process.
  * @filter: must always point to a valid seccomp-filter or NULL as it is
  *          accessed without locking during system call entry.
+ * @flags: flags under task->sighand->siglock lock
  *
  *          @filter must only be accessed from the context of current as there
  *          is no read locking.
@@ -23,6 +26,7 @@ struct seccomp_filter;
 struct seccomp {
 	int mode;
 	struct seccomp_filter *filter;
+	unsigned long flags;
 };
 
 extern int __secure_computing(int);
@@ -51,7 +55,9 @@ static inline int seccomp_mode(struct seccomp *s)
 
 #include <linux/errno.h>
 
-struct seccomp { };
+struct seccomp {
+	unsigned long flags;
+};
 struct seccomp_filter { };
 
 static inline int secure_computing(int this_syscall) { return 0; }
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 33655302b658..7ec99b99e400 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -219,7 +219,7 @@ static struct seccomp_filter *seccomp_prepare_filter(struct sock_fprog *fprog)
 	 * This avoids scenarios where unprivileged tasks can affect the
 	 * behavior of privileged children.
 	 */
-	if (!current->no_new_privs &&
+	if (!task_no_new_privs(current) &&
 	    security_capable_noaudit(current_cred(), current_user_ns(),
 				     CAP_SYS_ADMIN) != 0)
 		return ERR_PTR(-EACCES);
diff --git a/kernel/sys.c b/kernel/sys.c
index 66a751ebf9d9..ce8129192a26 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1990,12 +1990,12 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		if (arg2 != 1 || arg3 || arg4 || arg5)
 			return -EINVAL;
 
-		current->no_new_privs = 1;
+		task_set_no_new_privs(current);
 		break;
 	case PR_GET_NO_NEW_PRIVS:
 		if (arg2 || arg3 || arg4 || arg5)
 			return -EINVAL;
-		return current->no_new_privs ? 1 : 0;
+		return task_no_new_privs(current) ? 1 : 0;
 	case PR_GET_THP_DISABLE:
 		if (arg2 || arg3 || arg4 || arg5)
 			return -EINVAL;
diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index 452567d3a08e..d97cba3e3849 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -621,7 +621,7 @@ int aa_change_hat(const char *hats[], int count, u64 token, bool permtest)
 	 * There is no exception for unconfined as change_hat is not
 	 * available.
 	 */
-	if (current->no_new_privs)
+	if (task_no_new_privs(current))
 		return -EPERM;
 
 	/* released below */
@@ -776,7 +776,7 @@ int aa_change_profile(const char *ns_name, const char *hname, bool onexec,
 	 * no_new_privs is set because this aways results in a reduction
 	 * of permissions.
 	 */
-	if (current->no_new_privs && !unconfined(profile)) {
+	if (task_no_new_privs(current) && !unconfined(profile)) {
 		put_cred(cred);
 		return -EPERM;
 	}
-- 
1.7.9.5
