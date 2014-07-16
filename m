Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2014 23:53:22 +0200 (CEST)
Received: from smtp.outflux.net ([198.145.64.163]:33869 "EHLO smtp.outflux.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6861347AbaGPVvEGFGQO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 16 Jul 2014 23:51:04 +0200
Received: from www.outflux.net (serenity.outflux.net [10.2.0.2])
        by vinyl.outflux.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id s6GLotDw007788;
        Wed, 16 Jul 2014 14:50:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        James Morris <jmorris@namei.org>,
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
Subject: [PATCH v11 07/11] sched: move no_new_privs into new atomic flags
Date:   Wed, 16 Jul 2014 14:50:38 -0700
Message-Id: <1405547442-26641-8-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1405547442-26641-1-git-send-email-keescook@chromium.org>
References: <1405547442-26641-1-git-send-email-keescook@chromium.org>
X-MIMEDefang-Filter: outflux$Revision: 1.316 $
X-HELO: www.outflux.net
X-Scanned-By: MIMEDefang 2.73
Return-Path: <keescook@www.outflux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41247
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
no_new_privs flag to be atomic, the flag must be part of an atomic flag
set. This moves the nnp flag into a separate task field, and introduces
accessors.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Reviewed-by: Andy Lutomirski <luto@amacapital.net>
---
 fs/exec.c                  |    4 ++--
 include/linux/sched.h      |   18 +++++++++++++++---
 kernel/seccomp.c           |    2 +-
 kernel/sys.c               |    4 ++--
 security/apparmor/domain.c |    4 ++--
 5 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index a3d33fe592d6..0f5c272410f6 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1234,7 +1234,7 @@ static void check_unsafe_exec(struct linux_binprm *bprm)
 	 * This isn't strictly necessary, but it makes it harder for LSMs to
 	 * mess up.
 	 */
-	if (current->no_new_privs)
+	if (task_no_new_privs(current))
 		bprm->unsafe |= LSM_UNSAFE_NO_NEW_PRIVS;
 
 	t = p;
@@ -1272,7 +1272,7 @@ int prepare_binprm(struct linux_binprm *bprm)
 	bprm->cred->egid = current_egid();
 
 	if (!(bprm->file->f_path.mnt->mnt_flags & MNT_NOSUID) &&
-	    !current->no_new_privs &&
+	    !task_no_new_privs(current) &&
 	    kuid_has_mapping(bprm->cred->user_ns, inode->i_uid) &&
 	    kgid_has_mapping(bprm->cred->user_ns, inode->i_gid)) {
 		/* Set-uid? */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 306f4f0c987a..0fd19055bb64 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1307,13 +1307,12 @@ struct task_struct {
 				 * execve */
 	unsigned in_iowait:1;
 
-	/* task may not gain privileges */
-	unsigned no_new_privs:1;
-
 	/* Revert to default priority/policy when forking */
 	unsigned sched_reset_on_fork:1;
 	unsigned sched_contributes_to_load:1;
 
+	unsigned long atomic_flags; /* Flags needing atomic access. */
+
 	pid_t pid;
 	pid_t tgid;
 
@@ -1967,6 +1966,19 @@ static inline void memalloc_noio_restore(unsigned int flags)
 	current->flags = (current->flags & ~PF_MEMALLOC_NOIO) | flags;
 }
 
+/* Per-process atomic flags. */
+#define PFA_NO_NEW_PRIVS 0x00000001	/* May not gain new privileges. */
+
+static inline bool task_no_new_privs(struct task_struct *p)
+{
+	return test_bit(PFA_NO_NEW_PRIVS, &p->atomic_flags);
+}
+
+static inline void task_set_no_new_privs(struct task_struct *p)
+{
+	set_bit(PFA_NO_NEW_PRIVS, &p->atomic_flags);
+}
+
 /*
  * task->jobctl flags
  */
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index f0652578af75..d2596136b0d1 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -241,7 +241,7 @@ static long seccomp_attach_filter(struct sock_fprog *fprog)
 	 * This avoids scenarios where unprivileged tasks can affect the
 	 * behavior of privileged children.
 	 */
-	if (!current->no_new_privs &&
+	if (!task_no_new_privs(current) &&
 	    security_capable_noaudit(current_cred(), current_user_ns(),
 				     CAP_SYS_ADMIN) != 0)
 		return -EACCES;
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
