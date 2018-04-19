Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Apr 2018 16:41:32 +0200 (CEST)
Received: from mout.kundenserver.de ([217.72.192.74]:59573 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994641AbeDSOjDCcAvB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Apr 2018 16:39:03 +0200
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0Lvjxc-1eLaGC0etA-017R1Z; Thu, 19 Apr 2018 16:38:00 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, libc-alpha@sourceware.org,
        tglx@linutronix.de, deepa.kernel@gmail.com,
        viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        albert.aribaud@3adev.fr, linux-s390@vger.kernel.org,
        schwidefsky@de.ibm.com, x86@kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, linux-mips@linux-mips.org, jhogan@kernel.org,
        ralf@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org
Subject: [PATCH v3 15/17] y2038: ipc: Enable COMPAT_32BIT_TIME
Date:   Thu, 19 Apr 2018 16:37:35 +0200
Message-Id: <20180419143737.606138-16-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180419143737.606138-1-arnd@arndb.de>
References: <20180419143737.606138-1-arnd@arndb.de>
X-Provags-ID: V03:K1:hTc/tiy+Hysq7Qezx00qPc3pSW3JxV9JMzmbP4EF+StwAcj79kc
 0TMq2vq1ymiJZHIxBh2mRObbcYc3Jl/AssGWTR0N0UAOSENbGWY4OOUG+WB7T8eJlbNuXDf
 EPrNYNJVCS55yz6uGdXKcbK+k0HzUyOwnxwmHsY8Ax5PT+eeh8wRjVS1rH45CgQHRkfp28a
 S/3OM/8MDTzrB+HtmZyrg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:28YI5D+IHS0=:xWOSR6zBUn8BQ/UqyYRXhL
 2jZ4Ua5Tfz9y0nGYuNgtJ9AoCf9UVNlxLpbksG0+sz62morHm8WPh3bFcloBjOtBrSOUr/vPG
 DhWUmefNuknVVKQuU4o/SKwwfiH7kMuQX+ZjQP2U7OmH+OnsrEUi4pAU/GpmJDw1+qXMb8M5F
 W/gGGNG0MmcZT6KcXRkibJFlATILysA2vPaIC9NFHW18BEoIvPdnRMW/IdbxxuzO1KJl0Kpvw
 LA+SsUdEVQqcAZYYv2QeM7MpebnMa9uzx8iGyyOqpQODHQ5zsJbm+057hZLmy4BcDVwvJgegB
 p7ttbRHoJxZmSuD+hSWZQAXSoLqRHJ1fAzLcrROj0F7D7XmgC7Nk9duydcz2tasnKj5ewVXn1
 VITs/xOJttlXqNsGlFsw2dzpOG7SlDOuQ9Ufo0iS0sCj+xqFCEVdlSjB/KmPTS7aEeZU2jnib
 tyDfbE5G2DAt7k6CngpfxCGzCvSIi/QnhVRFJfLoTm4e+a78viD7ju8kMhUGx8IMijdKR89Tk
 sG4xFXBUB2v2iQ/4IzISz2jPK67F5LyVl2AY7dyE1dunUwbATjPl6OAdKVp7Sb03hin35+S52
 pqzB073jE4UpbbeZWd/xK6Xlv0xmOWQooe1DptZpGLTJpg1JvjE1+cvVF3AnA+S6AglSphNXY
 ehylfKumwMRdgYeuwfQGzJ7KEy+QNKGtTQh37Q8B+2nMycuNvNE/VU4vX1BmlewA11eET4EmW
 3JshkqEEpZa2OxYUdnRuu9OsKgy5C8SQB1uUfw==
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63615
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

Three ipc syscalls (mq_timedsend, mq_timedreceive and and semtimedop)
take a timespec argument. After we move 32-bit architectures over to
useing 64-bit time_t based syscalls, we need seperate entry points for
the old 32-bit based interfaces.

This changes the #ifdef guards for the existing 32-bit compat syscalls
to check for CONFIG_COMPAT_32BIT_TIME instead, which will then be
enabled on all existing 32-bit architectures.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 ipc/mqueue.c | 80 +++++++++++++++++++++++++++++++-----------------------------
 ipc/sem.c    |  3 ++-
 ipc/util.h   |  2 +-
 3 files changed, 44 insertions(+), 41 deletions(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 9610afcfa2e5..c0d58f390c3b 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -1420,6 +1420,47 @@ COMPAT_SYSCALL_DEFINE4(mq_open, const char __user *, u_name,
 	return do_mq_open(u_name, oflag, mode, p);
 }
 
+COMPAT_SYSCALL_DEFINE2(mq_notify, mqd_t, mqdes,
+		       const struct compat_sigevent __user *, u_notification)
+{
+	struct sigevent n, *p = NULL;
+	if (u_notification) {
+		if (get_compat_sigevent(&n, u_notification))
+			return -EFAULT;
+		if (n.sigev_notify == SIGEV_THREAD)
+			n.sigev_value.sival_ptr = compat_ptr(n.sigev_value.sival_int);
+		p = &n;
+	}
+	return do_mq_notify(mqdes, p);
+}
+
+COMPAT_SYSCALL_DEFINE3(mq_getsetattr, mqd_t, mqdes,
+		       const struct compat_mq_attr __user *, u_mqstat,
+		       struct compat_mq_attr __user *, u_omqstat)
+{
+	int ret;
+	struct mq_attr mqstat, omqstat;
+	struct mq_attr *new = NULL, *old = NULL;
+
+	if (u_mqstat) {
+		new = &mqstat;
+		if (get_compat_mq_attr(new, u_mqstat))
+			return -EFAULT;
+	}
+	if (u_omqstat)
+		old = &omqstat;
+
+	ret = do_mq_getsetattr(mqdes, new, old);
+	if (ret || !old)
+		return ret;
+
+	if (put_compat_mq_attr(old, u_omqstat))
+		return -EFAULT;
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_COMPAT_32BIT_TIME
 static int compat_prepare_timeout(const struct compat_timespec __user *p,
 				   struct timespec64 *ts)
 {
@@ -1459,45 +1500,6 @@ COMPAT_SYSCALL_DEFINE5(mq_timedreceive, mqd_t, mqdes,
 	}
 	return do_mq_timedreceive(mqdes, u_msg_ptr, msg_len, u_msg_prio, p);
 }
-
-COMPAT_SYSCALL_DEFINE2(mq_notify, mqd_t, mqdes,
-		       const struct compat_sigevent __user *, u_notification)
-{
-	struct sigevent n, *p = NULL;
-	if (u_notification) {
-		if (get_compat_sigevent(&n, u_notification))
-			return -EFAULT;
-		if (n.sigev_notify == SIGEV_THREAD)
-			n.sigev_value.sival_ptr = compat_ptr(n.sigev_value.sival_int);
-		p = &n;
-	}
-	return do_mq_notify(mqdes, p);
-}
-
-COMPAT_SYSCALL_DEFINE3(mq_getsetattr, mqd_t, mqdes,
-		       const struct compat_mq_attr __user *, u_mqstat,
-		       struct compat_mq_attr __user *, u_omqstat)
-{
-	int ret;
-	struct mq_attr mqstat, omqstat;
-	struct mq_attr *new = NULL, *old = NULL;
-
-	if (u_mqstat) {
-		new = &mqstat;
-		if (get_compat_mq_attr(new, u_mqstat))
-			return -EFAULT;
-	}
-	if (u_omqstat)
-		old = &omqstat;
-
-	ret = do_mq_getsetattr(mqdes, new, old);
-	if (ret || !old)
-		return ret;
-
-	if (put_compat_mq_attr(old, u_omqstat))
-		return -EFAULT;
-	return 0;
-}
 #endif
 
 static const struct inode_operations mqueue_dir_inode_operations = {
diff --git a/ipc/sem.c b/ipc/sem.c
index b951e25ba2db..cfd94d48a9aa 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -70,6 +70,7 @@
  *   The worst-case behavior is nevertheless O(N^2) for N wakeups.
  */
 
+#include <linux/compat.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/init.h>
@@ -2193,7 +2194,7 @@ SYSCALL_DEFINE4(semtimedop, int, semid, struct sembuf __user *, tsops,
 	return ksys_semtimedop(semid, tsops, nsops, timeout);
 }
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_COMPAT_32BIT_TIME
 long compat_ksys_semtimedop(int semid, struct sembuf __user *tsems,
 			    unsigned int nsops,
 			    const struct compat_timespec __user *timeout)
diff --git a/ipc/util.h b/ipc/util.h
index 975c6de2df9d..0aba3230d007 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -265,10 +265,10 @@ long ksys_shmdt(char __user *shmaddr);
 long ksys_shmctl(int shmid, int cmd, struct shmid_ds __user *buf);
 
 /* for CONFIG_ARCH_WANT_OLD_COMPAT_IPC */
-#ifdef CONFIG_COMPAT
 long compat_ksys_semtimedop(int semid, struct sembuf __user *tsems,
 			    unsigned int nsops,
 			    const struct compat_timespec __user *timeout);
+#ifdef CONFIG_COMPAT
 long compat_ksys_semctl(int semid, int semnum, int cmd, int arg);
 long compat_ksys_msgctl(int msqid, int cmd, void __user *uptr);
 long compat_ksys_msgrcv(int msqid, compat_uptr_t msgp, compat_ssize_t msgsz,
-- 
2.9.0
