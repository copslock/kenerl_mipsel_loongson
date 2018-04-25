Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Apr 2018 17:09:01 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.126.134]:45569 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994666AbeDYPHYOQxfC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Apr 2018 17:07:24 +0200
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MeGdC-1f23Ng43A6-00Pqu1; Wed, 25 Apr 2018 17:06:31 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        libc-alpha@sourceware.org, tglx@linutronix.de,
        deepa.kernel@gmail.com, viro@zeniv.linux.org.uk,
        ebiederm@xmission.com, albert.aribaud@3adev.fr,
        linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, x86@kernel.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-mips@linux-mips.org, jhogan@kernel.org, ralf@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        zackw@panix.com, noloader@gmail.com, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 14/16] y2038: ipc: Use __kernel_timespec
Date:   Wed, 25 Apr 2018 17:06:04 +0200
Message-Id: <20180425150606.954771-14-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180425132242.1500539-1-arnd@arndb.de>
References: <20180425132242.1500539-1-arnd@arndb.de>
X-Provags-ID: V03:K1:GC8B4lvTkw5Lm1bzN/Q0A6HXJ7loY8D2WCpwJQcWGCLtmTYV60x
 6nydte5iGaMkPNezDbJHWv2T6A5ubHs7YDmFg3Y2rfsTkcd05ISLJSwWNww0aqKLEIMuBwL
 or/J5Y0U0t8pM6SeboCMYjU7H/bpZ1ZaW+jVR/WfxHY71ZZ9GAJ9SfKNTQe4gvR6NkpfqTr
 C1PYQCGo71GjBGpLYbk3g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BJXUDQ6Vvto=:iFZRn5T++Cyo0hzYvieKxi
 Ok5PngjIt0vhLUEbGiUjM/SlfiQ5tCzDqq375Cr2Rph9Zv9x0mr1syd10p7LKMtRWHWbGKwf6
 Z4+7h7MCrn0+YL0b7oxUtgxxv54/8r0fjP5Hzz1zAFl4mrbgIrdiL/VZp5w2xDFY7c7ReWwsj
 /fRzQYXKkfRqlHYI3pUhDWW4AXEti+yFtXik5o28vdGYBwFrBQ+DLp6BaJZv8DovmZcYIPdcT
 rFjEOiY1bfWKgfI+JAHkyodQWDzRJShBR6cJRDEzv5U9Kb1JqQMocf/a/ORBCN0FpIDO6wBls
 zKwWGUazjo1e5JlASCCKCAaB6CfAiDICLHR3YFTfRHhdFAW+cPwCHuR/rXuQP5dxqf1sMHrzQ
 gH43ULgvkBOedwCl6Dl/NFLAuEJ6o3B3DnC3x25FlQks1H3a92c1Cuv0Y8TFU50u9GiQkTtRi
 Dznbz8ZwrcUyncvhH5yp+QBLEX5iRqda/coMPqXqKjNeQTkq8MUZkgzOP6YTo4SjP238pd9tF
 1/e5QuKpH8SjunVfmQ82mYZZ83hBkabum39IAi3bmL3L+RtniK71/sVhDdZw8P24OzbVXmKBL
 PYKhk1N0qJUaXGbsSy3F2QuTY7fybJLnlXolQibwapDSpXLk2q4guJy67YYrw43FhcYMKq2Yd
 jld6R9gbggwVYyWntTBG6EB+kGuf64QdQAinoNjAhS5D9DlnDoDWxCmZDJ2juli2d6SlM5GDM
 zr0tmga1eO6+Zdmn0Vyv6ZlG8kh2VpTPSlv3uA==
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63769
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
