Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Apr 2018 16:43:09 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.17.10]:39439 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994682AbeDSOj1qbQhB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Apr 2018 16:39:27 +0200
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0M2dqH-1eJgR81PpF-00sN80; Thu, 19 Apr 2018 16:37:59 +0200
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
Subject: [PATCH v3 14/17] y2038: ipc: Use __kernel_timespec
Date:   Thu, 19 Apr 2018 16:37:34 +0200
Message-Id: <20180419143737.606138-15-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180419143737.606138-1-arnd@arndb.de>
References: <20180419143737.606138-1-arnd@arndb.de>
X-Provags-ID: V03:K1:ZKYAuxGMajmvaIzfwCYhsflzK2XPcYERcA468TieefZU0vLGepf
 2Wkz/HafOKlcUAFLzYD6udPmDsM4igRQ/uZeeH4BUCYDLRKQrHXMrNXHy81qCzVtqu8vyib
 Ej60fgyqLctnHauTwS87L0KUPZ0gsh/r+GKkP4ajkDdAwnGI2bENXQy0ps800t8LhB1TklK
 +2gYPRu7eB9PsIa0tiEZQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:l+iPWJPC3Ww=:pRP4OdoG+L/xHdLq5sx8nH
 ZEjmszxrElDS4mrhmDfVuwsWQQIcmXTxMPYYJPBfywlkPTOYDOkBVvUid83ExOG1NpoInac9+
 NtnVPiNQdiU7fvJF4Bu/aRCqCJRcPjqPNpFpVQyYxb/UlYSPv7xKcz86uSBGbjUsErUzaAuox
 ETVykYxFODKrZ/JGrlu7009d58rwCKzqYh/popmsB3odf/J6+JFpGIanjwdMxvkbBX8Dd7rc8
 7TiXdK5LhYgp9iKvzwAylR5h8EE5AfQH3V5VBMXdVYN/uW8KpG6ccWvyO+gzs1nlTa40Dv8MO
 BHUUxDny8CwA+BNw8Ayi+T40Ggj19duYs/p9DE3rakubI5NgETmKB772YZAoogzo6HoIh5jkU
 rNBbirHafjlRZhzKyik607r2/XaFxVeHqn+D7Ph02hqPZX4EiNAYsDt7B80zrOOJ/q8C0MDbs
 vZycorTJplY1842oJYoEPJCDfPgPOsMcNiINo0lcmV/IYgnaKIkaDvT/MYcIFd4s3k9fhn0g9
 SJSXKjp1om6EvM11S9zOfU1BFbRjCNDaDCfEisWPkQr/cM9oFmnYho3Ug/KCfUstMgnVfAK0P
 1xzCQEFOWa5MvXDU2YofbMMUZtGN/MlrXWZaQOWNtzthMgx+rk9FNHPIvzEKNss8QxgufJwuJ
 cnfKGd632K9MeC8AFcDTKypzd2LavyAtd7ZQP3YyC8D1F7nyEaRrSOMz0enMG1TDWCWuOEgJ7
 Wx//PEk5yXaiY/kbl8qxtMqKCS+jk852IQHwWg==
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63621
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

This is a preparatation for changing over __kernel_timespec to 64-bit
times, which involves assigning new system call numbers for mq_timedsend(),
mq_timedreceive() and semtimedop() for compatibility with future y2038
proof user space.

The existing ABIs will remain available through compat code.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/syscalls.h | 6 +++---
 ipc/mqueue.c             | 6 +++---
 ipc/sem.c                | 4 ++--
 ipc/util.h               | 2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index c9a2a2601852..b92cb79d38c3 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -680,8 +680,8 @@ asmlinkage long sys_sysinfo(struct sysinfo __user *info);
 /* ipc/mqueue.c */
 asmlinkage long sys_mq_open(const char __user *name, int oflag, umode_t mode, struct mq_attr __user *attr);
 asmlinkage long sys_mq_unlink(const char __user *name);
-asmlinkage long sys_mq_timedsend(mqd_t mqdes, const char __user *msg_ptr, size_t msg_len, unsigned int msg_prio, const struct timespec __user *abs_timeout);
-asmlinkage long sys_mq_timedreceive(mqd_t mqdes, char __user *msg_ptr, size_t msg_len, unsigned int __user *msg_prio, const struct timespec __user *abs_timeout);
+asmlinkage long sys_mq_timedsend(mqd_t mqdes, const char __user *msg_ptr, size_t msg_len, unsigned int msg_prio, const struct __kernel_timespec __user *abs_timeout);
+asmlinkage long sys_mq_timedreceive(mqd_t mqdes, char __user *msg_ptr, size_t msg_len, unsigned int __user *msg_prio, const struct __kernel_timespec __user *abs_timeout);
 asmlinkage long sys_mq_notify(mqd_t mqdes, const struct sigevent __user *notification);
 asmlinkage long sys_mq_getsetattr(mqd_t mqdes, const struct mq_attr __user *mqstat, struct mq_attr __user *omqstat);
 
@@ -698,7 +698,7 @@ asmlinkage long sys_semget(key_t key, int nsems, int semflg);
 asmlinkage long sys_semctl(int semid, int semnum, int cmd, unsigned long arg);
 asmlinkage long sys_semtimedop(int semid, struct sembuf __user *sops,
 				unsigned nsops,
-				const struct timespec __user *timeout);
+				const struct __kernel_timespec __user *timeout);
 asmlinkage long sys_semop(int semid, struct sembuf __user *sops,
 				unsigned nsops);
 
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index a808f29d4c5a..9610afcfa2e5 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -691,7 +691,7 @@ static void __do_notify(struct mqueue_inode_info *info)
 	wake_up(&info->wait_q);
 }
 
-static int prepare_timeout(const struct timespec __user *u_abs_timeout,
+static int prepare_timeout(const struct __kernel_timespec __user *u_abs_timeout,
 			   struct timespec64 *ts)
 {
 	if (get_timespec64(ts, u_abs_timeout))
@@ -1128,7 +1128,7 @@ static int do_mq_timedreceive(mqd_t mqdes, char __user *u_msg_ptr,
 
 SYSCALL_DEFINE5(mq_timedsend, mqd_t, mqdes, const char __user *, u_msg_ptr,
 		size_t, msg_len, unsigned int, msg_prio,
-		const struct timespec __user *, u_abs_timeout)
+		const struct __kernel_timespec __user *, u_abs_timeout)
 {
 	struct timespec64 ts, *p = NULL;
 	if (u_abs_timeout) {
@@ -1142,7 +1142,7 @@ SYSCALL_DEFINE5(mq_timedsend, mqd_t, mqdes, const char __user *, u_msg_ptr,
 
 SYSCALL_DEFINE5(mq_timedreceive, mqd_t, mqdes, char __user *, u_msg_ptr,
 		size_t, msg_len, unsigned int __user *, u_msg_prio,
-		const struct timespec __user *, u_abs_timeout)
+		const struct __kernel_timespec __user *, u_abs_timeout)
 {
 	struct timespec64 ts, *p = NULL;
 	if (u_abs_timeout) {
diff --git a/ipc/sem.c b/ipc/sem.c
index 8935cd8cf166..b951e25ba2db 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -2176,7 +2176,7 @@ static long do_semtimedop(int semid, struct sembuf __user *tsops,
 }
 
 long ksys_semtimedop(int semid, struct sembuf __user *tsops,
-		     unsigned int nsops, const struct timespec __user *timeout)
+		     unsigned int nsops, const struct __kernel_timespec __user *timeout)
 {
 	if (timeout) {
 		struct timespec64 ts;
@@ -2188,7 +2188,7 @@ long ksys_semtimedop(int semid, struct sembuf __user *tsops,
 }
 
 SYSCALL_DEFINE4(semtimedop, int, semid, struct sembuf __user *, tsops,
-		unsigned int, nsops, const struct timespec __user *, timeout)
+		unsigned int, nsops, const struct __kernel_timespec __user *, timeout)
 {
 	return ksys_semtimedop(semid, tsops, nsops, timeout);
 }
diff --git a/ipc/util.h b/ipc/util.h
index acc5159e96d0..975c6de2df9d 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -251,7 +251,7 @@ static inline int compat_ipc_parse_version(int *cmd)
 /* for __ARCH_WANT_SYS_IPC */
 long ksys_semtimedop(int semid, struct sembuf __user *tsops,
 		     unsigned int nsops,
-		     const struct timespec __user *timeout);
+		     const struct __kernel_timespec __user *timeout);
 long ksys_semget(key_t key, int nsems, int semflg);
 long ksys_semctl(int semid, int semnum, int cmd, unsigned long arg);
 long ksys_msgget(key_t key, int msgflg);
-- 
2.9.0
