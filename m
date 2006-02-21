Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Feb 2006 06:58:29 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:25128 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S8127231AbWBUG6N (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 21 Feb 2006 06:58:13 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Tue, 21 Feb 2006 16:05:14 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 0348A20449;
	Tue, 21 Feb 2006 16:05:12 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id E2EF920239;
	Tue, 21 Feb 2006 16:05:11 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k1L75B4D010270;
	Tue, 21 Feb 2006 16:05:11 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Tue, 21 Feb 2006 16:05:11 +0900 (JST)
Message-Id: <20060221.160511.118969010.nemoto@toshiba-tops.co.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] add some __user tags
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060220174720.GA28701@linux-mips.org>
References: <20060221.013435.104641385.anemo@mba.ocn.ne.jp>
	<20060220172038.GB18561@linux-mips.org>
	<20060220174720.GA28701@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10588
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Mon, 20 Feb 2006 17:47:20 +0000, Ralf Baechle <ralf@linux-mips.org> said:
ralf> Or rather queued for 2.6.17,

Please dequeue it and enqueue this revised one.  This does not touch
sys32_getdents() and sys32_readdir() since I just sent an another
patch to remove them.


Add some __user tags to linux32.c, etc.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/kernel/linux32.c b/arch/mips/kernel/linux32.c
index 5f68b22..e12e8c3 100644
--- a/arch/mips/kernel/linux32.c
+++ b/arch/mips/kernel/linux32.c
@@ -69,7 +69,7 @@
  * Revalidate the inode. This is required for proper NFS attribute caching.
  */
 
-int cp_compat_stat(struct kstat *stat, struct compat_stat *statbuf)
+int cp_compat_stat(struct kstat *stat, struct compat_stat __user *statbuf)
 {
 	struct compat_stat tmp;
 
@@ -125,7 +125,7 @@ out:
 }
 
 
-asmlinkage int sys_truncate64(const char *path, unsigned int high,
+asmlinkage int sys_truncate64(const char __user *path, unsigned int high,
 			      unsigned int low)
 {
 	if ((int)high < 0)
@@ -215,8 +215,12 @@ sys32_readdir(unsigned int fd, void * di
 	return(n);
 }
 
+asmlinkage long
+compat_sys_wait4(compat_pid_t pid, compat_uint_t __user *stat_addr, int options,
+		 struct compat_rusage __user *ru);
+
 asmlinkage int
-sys32_waitpid(compat_pid_t pid, unsigned int *stat_addr, int options)
+sys32_waitpid(compat_pid_t pid, unsigned int __user *stat_addr, int options)
 {
 	return compat_sys_wait4(pid, stat_addr, options, NULL);
 }
@@ -229,6 +233,7 @@ sysn32_waitid(int which, compat_pid_t pi
 	struct rusage ru;
 	long ret;
 	mm_segment_t old_fs = get_fs();
+	int si_signo;
 
 	if (!access_ok(VERIFY_WRITE, uinfo, sizeof(*uinfo)))
 		return -EFAULT;
@@ -238,7 +243,9 @@ sysn32_waitid(int which, compat_pid_t pi
 			 uru ? (struct rusage __user *) &ru : NULL);
 	set_fs (old_fs);
 
-	if (ret < 0 || uinfo->si_signo == 0)
+	if (__get_user(si_signo, &uinfo->si_signo))
+		return -EFAULT;
+	if (ret < 0 || si_signo == 0)
 		return ret;
 
 	if (uru)
@@ -262,14 +269,14 @@ struct sysinfo32 {
 	char _f[8];
 };
 
-asmlinkage int sys32_sysinfo(struct sysinfo32 *info)
+asmlinkage int sys32_sysinfo(struct sysinfo32 __user *info)
 {
 	struct sysinfo s;
 	int ret, err;
 	mm_segment_t old_fs = get_fs ();
 
 	set_fs (KERNEL_DS);
-	ret = sys_sysinfo(&s);
+	ret = sys_sysinfo((struct sysinfo __user *)&s);
 	set_fs (old_fs);
 	err = put_user (s.uptime, &info->uptime);
 	err |= __put_user (s.loads[0], &info->loads[0]);
@@ -299,11 +306,11 @@ struct rlimit32 {
 };
 
 #ifdef __MIPSEB__
-asmlinkage long sys32_truncate64(const char * path, unsigned long __dummy,
+asmlinkage long sys32_truncate64(const char __user * path, unsigned long __dummy,
 	int length_hi, int length_lo)
 #endif
 #ifdef __MIPSEL__
-asmlinkage long sys32_truncate64(const char * path, unsigned long __dummy,
+asmlinkage long sys32_truncate64(const char __user * path, unsigned long __dummy,
 	int length_lo, int length_hi)
 #endif
 {
@@ -331,7 +338,7 @@ asmlinkage long sys32_ftruncate64(unsign
 }
 
 static inline long
-get_tv32(struct timeval *o, struct compat_timeval *i)
+get_tv32(struct timeval *o, struct compat_timeval __user *i)
 {
 	return (!access_ok(VERIFY_READ, i, sizeof(*i)) ||
 		(__get_user(o->tv_sec, &i->tv_sec) |
@@ -339,7 +346,7 @@ get_tv32(struct timeval *o, struct compa
 }
 
 static inline long
-put_tv32(struct compat_timeval *o, struct timeval *i)
+put_tv32(struct compat_timeval __user *o, struct timeval *i)
 {
 	return (!access_ok(VERIFY_WRITE, o, sizeof(*o)) ||
 		(__put_user(i->tv_sec, &o->tv_sec) |
@@ -349,7 +356,7 @@ put_tv32(struct compat_timeval *o, struc
 extern struct timezone sys_tz;
 
 asmlinkage int
-sys32_gettimeofday(struct compat_timeval *tv, struct timezone *tz)
+sys32_gettimeofday(struct compat_timeval __user *tv, struct timezone __user *tz)
 {
 	if (tv) {
 		struct timeval ktv;
@@ -364,7 +371,7 @@ sys32_gettimeofday(struct compat_timeval
 	return 0;
 }
 
-static inline long get_ts32(struct timespec *o, struct compat_timeval *i)
+static inline long get_ts32(struct timespec *o, struct compat_timeval __user *i)
 {
 	long usec;
 
@@ -379,7 +386,7 @@ static inline long get_ts32(struct times
 }
 
 asmlinkage int
-sys32_settimeofday(struct compat_timeval *tv, struct timezone *tz)
+sys32_settimeofday(struct compat_timeval __user *tv, struct timezone __user *tz)
 {
 	struct timespec kts;
 	struct timezone ktz;
@@ -397,7 +404,7 @@ sys32_settimeofday(struct compat_timeval
 }
 
 asmlinkage int sys32_llseek(unsigned int fd, unsigned int offset_high,
-			    unsigned int offset_low, loff_t * result,
+			    unsigned int offset_low, loff_t __user * result,
 			    unsigned int origin)
 {
 	return sys_llseek(fd, offset_high, offset_low, result, origin);
@@ -407,12 +414,12 @@ asmlinkage int sys32_llseek(unsigned int
    lseek back to original location.  They fail just like lseek does on
    non-seekable files.  */
 
-asmlinkage ssize_t sys32_pread(unsigned int fd, char * buf,
+asmlinkage ssize_t sys32_pread(unsigned int fd, char __user * buf,
 			       size_t count, u32 unused, u64 a4, u64 a5)
 {
 	ssize_t ret;
 	struct file * file;
-	ssize_t (*read)(struct file *, char *, size_t, loff_t *);
+	ssize_t (*read)(struct file *, char __user *, size_t, loff_t *);
 	loff_t pos;
 
 	ret = -EBADF;
@@ -442,12 +449,12 @@ bad_file:
 	return ret;
 }
 
-asmlinkage ssize_t sys32_pwrite(unsigned int fd, const char * buf,
+asmlinkage ssize_t sys32_pwrite(unsigned int fd, const char __user * buf,
 			        size_t count, u32 unused, u64 a4, u64 a5)
 {
 	ssize_t ret;
 	struct file * file;
-	ssize_t (*write)(struct file *, const char *, size_t, loff_t *);
+	ssize_t (*write)(struct file *, const char __user *, size_t, loff_t *);
 	loff_t pos;
 
 	ret = -EBADF;
@@ -480,14 +487,14 @@ bad_file:
 }
 
 asmlinkage int sys32_sched_rr_get_interval(compat_pid_t pid,
-	struct compat_timespec *interval)
+	struct compat_timespec __user *interval)
 {
 	struct timespec t;
 	int ret;
 	mm_segment_t old_fs = get_fs ();
 
 	set_fs (KERNEL_DS);
-	ret = sys_sched_rr_get_interval(pid, &t);
+	ret = sys_sched_rr_get_interval(pid, (struct timespec __user *)&t);
 	set_fs (old_fs);
 	if (put_user (t.tv_sec, &interval->tv_sec) ||
 	    __put_user (t.tv_nsec, &interval->tv_nsec))
@@ -605,7 +612,7 @@ struct ipc_kludge32 {
 };
 
 static int
-do_sys32_semctl(int first, int second, int third, void *uptr)
+do_sys32_semctl(int first, int second, int third, void __user *uptr)
 {
 	union semun fourth;
 	u32 pad;
@@ -616,12 +623,12 @@ do_sys32_semctl(int first, int second, i
 	if (!uptr)
 		return -EINVAL;
 	err = -EFAULT;
-	if (get_user (pad, (u32 *)uptr))
+	if (get_user (pad, (u32 __user *)uptr))
 		return err;
 	if ((third & ~IPC_64) == SETVAL)
 		fourth.val = (int)pad;
 	else
-		fourth.__pad = (void *)A(pad);
+		fourth.__pad = (void __user *)A(pad);
 	switch (third & ~IPC_64) {
 	case IPC_INFO:
 	case IPC_RMID:
@@ -639,14 +646,14 @@ do_sys32_semctl(int first, int second, i
 
 	case IPC_STAT:
 	case SEM_STAT:
-		fourth.__pad = &s;
+		fourth.__pad = (struct semid64_ds __user *)&s;
 		old_fs = get_fs();
 		set_fs(KERNEL_DS);
 		err = sys_semctl(first, second, third | IPC_64, fourth);
 		set_fs(old_fs);
 
 		if (third & IPC_64) {
-			struct semid64_ds32 *usp64 = (struct semid64_ds32 *) A(pad);
+			struct semid64_ds32 __user *usp64 = (struct semid64_ds32 __user *) A(pad);
 
 			if (!access_ok(VERIFY_WRITE, usp64, sizeof(*usp64))) {
 				err = -EFAULT;
@@ -663,7 +670,7 @@ do_sys32_semctl(int first, int second, i
 			err2 |= __put_user(s.sem_ctime, &usp64->sem_ctime);
 			err2 |= __put_user(s.sem_nsems, &usp64->sem_nsems);
 		} else {
-			struct semid_ds32 *usp32 = (struct semid_ds32 *) A(pad);
+			struct semid_ds32 __user *usp32 = (struct semid_ds32 __user *) A(pad);
 
 			if (!access_ok(VERIFY_WRITE, usp32, sizeof(*usp32))) {
 				err = -EFAULT;
@@ -693,9 +700,9 @@ do_sys32_semctl(int first, int second, i
 }
 
 static int
-do_sys32_msgsnd (int first, int second, int third, void *uptr)
+do_sys32_msgsnd (int first, int second, int third, void __user *uptr)
 {
-	struct msgbuf32 *up = (struct msgbuf32 *)uptr;
+	struct msgbuf32 __user *up = (struct msgbuf32 __user *)uptr;
 	struct msgbuf *p;
 	mm_segment_t old_fs;
 	int err;
@@ -714,7 +721,7 @@ do_sys32_msgsnd (int first, int second, 
 		goto out;
 	old_fs = get_fs ();
 	set_fs (KERNEL_DS);
-	err = sys_msgsnd (first, p, second, third);
+	err = sys_msgsnd (first, (struct msgbuf __user *)p, second, third);
 	set_fs (old_fs);
 out:
 	kfree (p);
@@ -724,15 +731,15 @@ out:
 
 static int
 do_sys32_msgrcv (int first, int second, int msgtyp, int third,
-		 int version, void *uptr)
+		 int version, void __user *uptr)
 {
-	struct msgbuf32 *up;
+	struct msgbuf32 __user *up;
 	struct msgbuf *p;
 	mm_segment_t old_fs;
 	int err;
 
 	if (!version) {
-		struct ipc_kludge32 *uipck = (struct ipc_kludge32 *)uptr;
+		struct ipc_kludge32 __user *uipck = (struct ipc_kludge32 __user *)uptr;
 		struct ipc_kludge32 ipck;
 
 		err = -EINVAL;
@@ -741,7 +748,7 @@ do_sys32_msgrcv (int first, int second, 
 		err = -EFAULT;
 		if (copy_from_user (&ipck, uipck, sizeof (struct ipc_kludge32)))
 			goto out;
-		uptr = (void *)AA(ipck.msgp);
+		uptr = (void __user *)AA(ipck.msgp);
 		msgtyp = ipck.msgtyp;
 	}
 
@@ -753,11 +760,11 @@ do_sys32_msgrcv (int first, int second, 
 		goto out;
 	old_fs = get_fs ();
 	set_fs (KERNEL_DS);
-	err = sys_msgrcv (first, p, second + 4, msgtyp, third);
+	err = sys_msgrcv (first, (struct msgbuf __user *)p, second + 4, msgtyp, third);
 	set_fs (old_fs);
 	if (err < 0)
 		goto free_then_out;
-	up = (struct msgbuf32 *)uptr;
+	up = (struct msgbuf32 __user *)uptr;
 	if (put_user (p->mtype, &up->mtype) ||
 	    __copy_to_user (&up->mtext, p->mtext, err))
 		err = -EFAULT;
@@ -768,19 +775,19 @@ out:
 }
 
 static int
-do_sys32_msgctl (int first, int second, void *uptr)
+do_sys32_msgctl (int first, int second, void __user *uptr)
 {
 	int err = -EINVAL, err2;
 	struct msqid64_ds m;
-	struct msqid_ds32 *up32 = (struct msqid_ds32 *)uptr;
-	struct msqid64_ds32 *up64 = (struct msqid64_ds32 *)uptr;
+	struct msqid_ds32 __user *up32 = (struct msqid_ds32 __user *)uptr;
+	struct msqid64_ds32 __user *up64 = (struct msqid64_ds32 __user *)uptr;
 	mm_segment_t old_fs;
 
 	switch (second & ~IPC_64) {
 	case IPC_INFO:
 	case IPC_RMID:
 	case MSG_INFO:
-		err = sys_msgctl (first, second, (struct msqid_ds *)uptr);
+		err = sys_msgctl (first, second, (struct msqid_ds __user *)uptr);
 		break;
 
 	case IPC_SET:
@@ -807,7 +814,7 @@ do_sys32_msgctl (int first, int second, 
 			break;
 		old_fs = get_fs();
 		set_fs(KERNEL_DS);
-		err = sys_msgctl(first, second | IPC_64, (struct msqid_ds *)&m);
+		err = sys_msgctl(first, second | IPC_64, (struct msqid_ds __user *)&m);
 		set_fs(old_fs);
 		break;
 
@@ -815,7 +822,7 @@ do_sys32_msgctl (int first, int second, 
 	case MSG_STAT:
 		old_fs = get_fs();
 		set_fs(KERNEL_DS);
-		err = sys_msgctl(first, second | IPC_64, (struct msqid_ds *)&m);
+		err = sys_msgctl(first, second | IPC_64, (struct msqid_ds __user *)&m);
 		set_fs(old_fs);
 		if (second & IPC_64) {
 			if (!access_ok(VERIFY_WRITE, up64, sizeof(*up64))) {
@@ -869,10 +876,10 @@ do_sys32_msgctl (int first, int second, 
 }
 
 static int
-do_sys32_shmat (int first, int second, int third, int version, void *uptr)
+do_sys32_shmat (int first, int second, int third, int version, void __user *uptr)
 {
 	unsigned long raddr;
-	u32 *uaddr = (u32 *)A((u32)third);
+	u32 __user *uaddr = (u32 __user *)A((u32)third);
 	int err = -EINVAL;
 
 	if (version == 1)
@@ -891,11 +898,11 @@ struct shm_info32 {
 };
 
 static int
-do_sys32_shmctl (int first, int second, void *uptr)
+do_sys32_shmctl (int first, int second, void __user *uptr)
 {
-	struct shmid64_ds32 *up64 = (struct shmid64_ds32 *)uptr;
-	struct shmid_ds32 *up32 = (struct shmid_ds32 *)uptr;
-	struct shm_info32 *uip = (struct shm_info32 *)uptr;
+	struct shmid64_ds32 __user *up64 = (struct shmid64_ds32 __user *)uptr;
+	struct shmid_ds32 __user *up32 = (struct shmid_ds32 __user *)uptr;
+	struct shm_info32 __user *uip = (struct shm_info32 __user *)uptr;
 	int err = -EFAULT, err2;
 	struct shmid64_ds s64;
 	mm_segment_t old_fs;
@@ -908,7 +915,7 @@ do_sys32_shmctl (int first, int second, 
 	case IPC_RMID:
 	case SHM_LOCK:
 	case SHM_UNLOCK:
-		err = sys_shmctl(first, second, (struct shmid_ds *)uptr);
+		err = sys_shmctl(first, second, (struct shmid_ds __user *)uptr);
 		break;
 	case IPC_SET:
 		if (second & IPC_64) {
@@ -924,7 +931,7 @@ do_sys32_shmctl (int first, int second, 
 			break;
 		old_fs = get_fs();
 		set_fs(KERNEL_DS);
-		err = sys_shmctl(first, second & ~IPC_64, &s);
+		err = sys_shmctl(first, second & ~IPC_64, (struct shmid_ds __user *)&s);
 		set_fs(old_fs);
 		break;
 
@@ -932,7 +939,7 @@ do_sys32_shmctl (int first, int second, 
 	case SHM_STAT:
 		old_fs = get_fs();
 		set_fs(KERNEL_DS);
-		err = sys_shmctl(first, second | IPC_64, (void *) &s64);
+		err = sys_shmctl(first, second | IPC_64, (void __user *) &s64);
 		set_fs(old_fs);
 		if (err < 0)
 			break;
@@ -982,7 +989,7 @@ do_sys32_shmctl (int first, int second, 
 	case SHM_INFO:
 		old_fs = get_fs();
 		set_fs(KERNEL_DS);
-		err = sys_shmctl(first, second, (void *)&si);
+		err = sys_shmctl(first, second, (void __user *)&si);
 		set_fs(old_fs);
 		if (err < 0)
 			break;
@@ -1004,11 +1011,11 @@ do_sys32_shmctl (int first, int second, 
 	return err;
 }
 
-static int sys32_semtimedop(int semid, struct sembuf *tsems, int nsems,
-                            const struct compat_timespec *timeout32)
+static int sys32_semtimedop(int semid, struct sembuf __user *tsems, int nsems,
+                            const struct compat_timespec __user *timeout32)
 {
 	struct compat_timespec t32;
-	struct timespec *t64 = compat_alloc_user_space(sizeof(*t64));
+	struct timespec __user *t64 = compat_alloc_user_space(sizeof(*t64));
 
 	if (copy_from_user(&t32, timeout32, sizeof(t32)))
 		return -EFAULT;
@@ -1031,11 +1038,11 @@ sys32_ipc (u32 call, int first, int seco
 	switch (call) {
 	case SEMOP:
 		/* struct sembuf is the same on 32 and 64bit :)) */
-		err = sys_semtimedop (first, (struct sembuf *)AA(ptr), second,
+		err = sys_semtimedop (first, (struct sembuf __user *)AA(ptr), second,
 		                      NULL);
 		break;
 	case SEMTIMEDOP:
-		err = sys32_semtimedop (first, (struct sembuf *)AA(ptr), second,
+		err = sys32_semtimedop (first, (struct sembuf __user *)AA(ptr), second,
 		                      (const struct compat_timespec __user *)AA(fifth));
 		break;
 	case SEMGET:
@@ -1043,36 +1050,36 @@ sys32_ipc (u32 call, int first, int seco
 		break;
 	case SEMCTL:
 		err = do_sys32_semctl (first, second, third,
-				       (void *)AA(ptr));
+				       (void __user *)AA(ptr));
 		break;
 
 	case MSGSND:
 		err = do_sys32_msgsnd (first, second, third,
-				       (void *)AA(ptr));
+				       (void __user *)AA(ptr));
 		break;
 	case MSGRCV:
 		err = do_sys32_msgrcv (first, second, fifth, third,
-				       version, (void *)AA(ptr));
+				       version, (void __user *)AA(ptr));
 		break;
 	case MSGGET:
 		err = sys_msgget ((key_t) first, second);
 		break;
 	case MSGCTL:
-		err = do_sys32_msgctl (first, second, (void *)AA(ptr));
+		err = do_sys32_msgctl (first, second, (void __user *)AA(ptr));
 		break;
 
 	case SHMAT:
 		err = do_sys32_shmat (first, second, third,
-				      version, (void *)AA(ptr));
+				      version, (void __user *)AA(ptr));
 		break;
 	case SHMDT:
-		err = sys_shmdt ((char *)A(ptr));
+		err = sys_shmdt ((char __user *)A(ptr));
 		break;
 	case SHMGET:
 		err = sys_shmget (first, (unsigned)second, third);
 		break;
 	case SHMCTL:
-		err = do_sys32_shmctl (first, second, (void *)AA(ptr));
+		err = do_sys32_shmctl (first, second, (void __user *)AA(ptr));
 		break;
 	default:
 		err = -EINVAL;
@@ -1083,7 +1090,7 @@ sys32_ipc (u32 call, int first, int seco
 }
 
 asmlinkage long sys32_shmat(int shmid, char __user *shmaddr,
-			  int shmflg, int32_t *addr)
+			  int shmflg, int32_t __user *addr)
 {
 	unsigned long raddr;
 	int err;
@@ -1108,12 +1115,13 @@ struct sysctl_args32
 
 #ifdef CONFIG_SYSCTL
 
-asmlinkage long sys32_sysctl(struct sysctl_args32 *args)
+asmlinkage long sys32_sysctl(struct sysctl_args32 __user *args)
 {
 	struct sysctl_args32 tmp;
 	int error;
-	size_t oldlen, *oldlenp = NULL;
-	unsigned long addr = (((long)&args->__unused[0]) + 7) & ~7;
+	size_t oldlen;
+	size_t __user *oldlenp = NULL;
+	unsigned long addr = (((unsigned long)&args->__unused[0]) + 7) & ~7;
 
 	if (copy_from_user(&tmp, args, sizeof(tmp)))
 		return -EFAULT;
@@ -1125,20 +1133,20 @@ asmlinkage long sys32_sysctl(struct sysc
 		   basically copy the whole sysctl.c here, and
 		   glibc's __sysctl uses rw memory for the structure
 		   anyway.  */
-		if (get_user(oldlen, (u32 *)A(tmp.oldlenp)) ||
-		    put_user(oldlen, (size_t *)addr))
+		if (get_user(oldlen, (u32 __user *)A(tmp.oldlenp)) ||
+		    put_user(oldlen, (size_t __user *)addr))
 			return -EFAULT;
-		oldlenp = (size_t *)addr;
+		oldlenp = (size_t __user *)addr;
 	}
 
 	lock_kernel();
-	error = do_sysctl((int *)A(tmp.name), tmp.nlen, (void *)A(tmp.oldval),
-			  oldlenp, (void *)A(tmp.newval), tmp.newlen);
+	error = do_sysctl((int __user *)A(tmp.name), tmp.nlen, (void __user *)A(tmp.oldval),
+			  oldlenp, (void __user *)A(tmp.newval), tmp.newlen);
 	unlock_kernel();
 	if (oldlenp) {
 		if (!error) {
-			if (get_user(oldlen, (size_t *)addr) ||
-			    put_user(oldlen, (u32 *)A(tmp.oldlenp)))
+			if (get_user(oldlen, (size_t __user *)addr) ||
+			    put_user(oldlen, (u32 __user *)A(tmp.oldlenp)))
 				error = -EFAULT;
 		}
 		copy_to_user(args->__unused, tmp.__unused, sizeof(tmp.__unused));
@@ -1148,7 +1156,7 @@ asmlinkage long sys32_sysctl(struct sysc
 
 #endif /* CONFIG_SYSCTL */
 
-asmlinkage long sys32_newuname(struct new_utsname * name)
+asmlinkage long sys32_newuname(struct new_utsname __user * name)
 {
 	int ret = 0;
 
@@ -1183,9 +1191,9 @@ struct ustat32 {
 	char		f_fpack[6];
 };
 
-extern asmlinkage long sys_ustat(dev_t dev, struct ustat * ubuf);
+extern asmlinkage long sys_ustat(dev_t dev, struct ustat __user * ubuf);
 
-asmlinkage int sys32_ustat(dev_t dev, struct ustat32 * ubuf32)
+asmlinkage int sys32_ustat(dev_t dev, struct ustat32 __user * ubuf32)
 {
 	int err;
         struct ustat tmp;
@@ -1193,7 +1201,7 @@ asmlinkage int sys32_ustat(dev_t dev, st
 	mm_segment_t old_fs = get_fs();
 
 	set_fs(KERNEL_DS);
-	err = sys_ustat(dev, &tmp);
+	err = sys_ustat(dev, (struct ustat __user *)&tmp);
 	set_fs (old_fs);
 
 	if (err)
@@ -1226,7 +1234,7 @@ struct timex32 {
 
 extern int do_adjtimex(struct timex *);
 
-asmlinkage int sys32_adjtimex(struct timex32 *utp)
+asmlinkage int sys32_adjtimex(struct timex32 __user *utp)
 {
 	struct timex txc;
 	int ret;
@@ -1282,7 +1290,7 @@ asmlinkage int sys32_adjtimex(struct tim
 	return ret;
 }
 
-asmlinkage int sys32_sendfile(int out_fd, int in_fd, compat_off_t *offset,
+asmlinkage int sys32_sendfile(int out_fd, int in_fd, compat_off_t __user *offset,
 	s32 count)
 {
 	mm_segment_t old_fs = get_fs();
@@ -1293,7 +1301,7 @@ asmlinkage int sys32_sendfile(int out_fd
 		return -EFAULT;
 
 	set_fs(KERNEL_DS);
-	ret = sys_sendfile(out_fd, in_fd, offset ? &of : NULL, count);
+	ret = sys_sendfile(out_fd, in_fd, offset ? (off_t __user *)&of : NULL, count);
 	set_fs(old_fs);
 
 	if (offset && put_user(of, offset))
@@ -1323,7 +1331,7 @@ static unsigned char socketcall_nargs[18
  *  it is set by the callees.
  */
 
-asmlinkage long sys32_socketcall(int call, unsigned int *args32)
+asmlinkage long sys32_socketcall(int call, unsigned int __user *args32)
 {
 	unsigned int a[6];
 	unsigned int a0,a1;
@@ -1345,7 +1353,7 @@ asmlinkage long sys32_socketcall(int cal
 					    struct sockaddr __user *addr, int __user *addr_len);
 	extern asmlinkage long sys_shutdown(int fd, int how);
 	extern asmlinkage long sys_setsockopt(int fd, int level, int optname, char __user *optval, int optlen);
-	extern asmlinkage long sys_getsockopt(int fd, int level, int optname, char __user *optval, int *optlen);
+	extern asmlinkage long sys_getsockopt(int fd, int level, int optname, char __user *optval, int __user *optlen);
 	extern asmlinkage long sys_sendmsg(int fd, struct msghdr __user *msg, unsigned flags);
 	extern asmlinkage long sys_recvmsg(int fd, struct msghdr __user *msg, unsigned int flags);
 
@@ -1465,7 +1473,7 @@ _sys32_clone(nabi_no_regargs struct pt_r
 	newsp = regs.regs[5];
 	if (!newsp)
 		newsp = regs.regs[29];
-	parent_tidptr = (int *) regs.regs[6];
+	parent_tidptr = (int __user *) regs.regs[6];
 
 	/* Use __dummy4 instead of getting it off the stack, so that
 	   syscall() works.  */
diff --git a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c
index 1da2eeb..55f2bc0 100644
--- a/arch/mips/kernel/syscall.c
+++ b/arch/mips/kernel/syscall.c
@@ -345,7 +345,7 @@ asmlinkage int sys_ipc (uint call, int f
 		union semun fourth;
 		if (!ptr)
 			return -EINVAL;
-		if (get_user(fourth.__pad, (void *__user *) ptr))
+		if (get_user(fourth.__pad, (void __user *__user *) ptr))
 			return -EFAULT;
 		return sys_semctl (first, second, third, fourth);
 	}
diff --git a/include/asm-mips/compat.h b/include/asm-mips/compat.h
index 35d2604..0012bd8 100644
--- a/include/asm-mips/compat.h
+++ b/include/asm-mips/compat.h
@@ -128,17 +128,17 @@ typedef u32		compat_sigset_word;
  */
 typedef u32		compat_uptr_t;
 
-static inline void *compat_ptr(compat_uptr_t uptr)
+static inline void __user *compat_ptr(compat_uptr_t uptr)
 {
-	return (void *)(long)uptr;
+	return (void __user *)(long)uptr;
 }
 
-static inline void *compat_alloc_user_space(long len)
+static inline void __user *compat_alloc_user_space(long len)
 {
 	struct pt_regs *regs = (struct pt_regs *)
 		((unsigned long) current_thread_info() + THREAD_SIZE - 32) - 1;
 
-	return (void *) (regs->regs[29] - len);
+	return (void __user *) (regs->regs[29] - len);
 }
 #if defined (__MIPSEL__)
 #define __COMPAT_ENDIAN_SWAP__ 	1
