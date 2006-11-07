Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Nov 2006 09:23:14 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:14764 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20037661AbWKGJXJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 7 Nov 2006 09:23:09 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Tue, 7 Nov 2006 18:23:07 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 7C4F9203FD;
	Tue,  7 Nov 2006 18:23:03 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id A72AB2029C;
	Tue,  7 Nov 2006 18:02:45 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id kA792iW0052786;
	Tue, 7 Nov 2006 18:02:44 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Tue, 07 Nov 2006 18:02:44 +0900 (JST)
Message-Id: <20061107.180244.95062957.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, dpervushin@ru.mvista.com,
	creese@caviumnetworks.com
Subject: [PATCH] Use SYSVIPC_COMPAT to fix various problems on N32
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
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
X-archive-position: 13157
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

N32 SysV IPC system calls should use 32-bit compatible code.
arch/mips/kernel/linux32.c have similar compatible code for O32, but
ipc/compat.c seems more complete.  We can use it for both N32 and O32.

This patch should fix these problems (and other possible problems):

http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=1149188824.6986.6.camel%40diimka-laptop
http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=44C6B829.8050508%40caviumnetworks.com

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

 arch/mips/Kconfig              |    5 
 arch/mips/kernel/linux32.c     |  578 +----------------------------------------
 arch/mips/kernel/scall64-n32.S |   14 
 include/asm-mips/compat.h      |   68 ++++
 4 files changed, 103 insertions(+), 562 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 5f2f77f..7cc9adb 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1920,6 +1920,11 @@ config COMPAT
 	depends on MIPS32_COMPAT
 	default y
 
+config SYSVIPC_COMPAT
+	bool
+	depends on COMPAT && SYSVIPC
+	default y
+
 config MIPS32_O32
 	bool "Kernel support for o32 binaries"
 	depends on MIPS32_COMPAT
diff --git a/arch/mips/kernel/linux32.c b/arch/mips/kernel/linux32.c
index 7a3ebbe..6cd62ac 100644
--- a/arch/mips/kernel/linux32.c
+++ b/arch/mips/kernel/linux32.c
@@ -382,531 +382,6 @@ asmlinkage int sys32_sched_rr_get_interv
 	return ret;
 }
 
-struct msgbuf32 { s32 mtype; char mtext[1]; };
-
-struct ipc_perm32
-{
-	key_t    	  key;
-        __compat_uid_t  uid;
-        __compat_gid_t  gid;
-        __compat_uid_t  cuid;
-        __compat_gid_t  cgid;
-        compat_mode_t	mode;
-        unsigned short  seq;
-};
-
-struct ipc64_perm32 {
-	key_t key;
-	__compat_uid_t uid;
-	__compat_gid_t gid;
-	__compat_uid_t cuid;
-	__compat_gid_t cgid;
-	compat_mode_t	mode;
-	unsigned short	seq;
-	unsigned short __pad1;
-	unsigned int __unused1;
-	unsigned int __unused2;
-};
-
-struct semid_ds32 {
-        struct ipc_perm32 sem_perm;               /* permissions .. see ipc.h */
-        compat_time_t   sem_otime;              /* last semop time */
-        compat_time_t   sem_ctime;              /* last change time */
-        u32 sem_base;              /* ptr to first semaphore in array */
-        u32 sem_pending;          /* pending operations to be processed */
-        u32 sem_pending_last;    /* last pending operation */
-        u32 undo;                  /* undo requests on this array */
-        unsigned short  sem_nsems;              /* no. of semaphores in array */
-};
-
-struct semid64_ds32 {
-	struct ipc64_perm32	sem_perm;
-	compat_time_t	sem_otime;
-	compat_time_t	sem_ctime;
-	unsigned int		sem_nsems;
-	unsigned int		__unused1;
-	unsigned int		__unused2;
-};
-
-struct msqid_ds32
-{
-        struct ipc_perm32 msg_perm;
-        u32 msg_first;
-        u32 msg_last;
-        compat_time_t   msg_stime;
-        compat_time_t   msg_rtime;
-        compat_time_t   msg_ctime;
-        u32 wwait;
-        u32 rwait;
-        unsigned short msg_cbytes;
-        unsigned short msg_qnum;
-        unsigned short msg_qbytes;
-        compat_ipc_pid_t msg_lspid;
-        compat_ipc_pid_t msg_lrpid;
-};
-
-struct msqid64_ds32 {
-	struct ipc64_perm32 msg_perm;
-	compat_time_t msg_stime;
-	unsigned int __unused1;
-	compat_time_t msg_rtime;
-	unsigned int __unused2;
-	compat_time_t msg_ctime;
-	unsigned int __unused3;
-	unsigned int msg_cbytes;
-	unsigned int msg_qnum;
-	unsigned int msg_qbytes;
-	compat_pid_t msg_lspid;
-	compat_pid_t msg_lrpid;
-	unsigned int __unused4;
-	unsigned int __unused5;
-};
-
-struct shmid_ds32 {
-        struct ipc_perm32       shm_perm;
-        int                     shm_segsz;
-        compat_time_t		shm_atime;
-        compat_time_t		shm_dtime;
-        compat_time_t		shm_ctime;
-        compat_ipc_pid_t    shm_cpid;
-        compat_ipc_pid_t    shm_lpid;
-        unsigned short          shm_nattch;
-};
-
-struct shmid64_ds32 {
-	struct ipc64_perm32	shm_perm;
-	compat_size_t		shm_segsz;
-	compat_time_t		shm_atime;
-	compat_time_t		shm_dtime;
-	compat_time_t shm_ctime;
-	compat_pid_t shm_cpid;
-	compat_pid_t shm_lpid;
-	unsigned int shm_nattch;
-	unsigned int __unused1;
-	unsigned int __unused2;
-};
-
-struct ipc_kludge32 {
-	u32 msgp;
-	s32 msgtyp;
-};
-
-static int
-do_sys32_semctl(int first, int second, int third, void __user *uptr)
-{
-	union semun fourth;
-	u32 pad;
-	int err, err2;
-	struct semid64_ds s;
-	mm_segment_t old_fs;
-
-	if (!uptr)
-		return -EINVAL;
-	err = -EFAULT;
-	if (get_user (pad, (u32 __user *)uptr))
-		return err;
-	if ((third & ~IPC_64) == SETVAL)
-		fourth.val = (int)pad;
-	else
-		fourth.__pad = (void __user *)A(pad);
-	switch (third & ~IPC_64) {
-	case IPC_INFO:
-	case IPC_RMID:
-	case IPC_SET:
-	case SEM_INFO:
-	case GETVAL:
-	case GETPID:
-	case GETNCNT:
-	case GETZCNT:
-	case GETALL:
-	case SETVAL:
-	case SETALL:
-		err = sys_semctl (first, second, third, fourth);
-		break;
-
-	case IPC_STAT:
-	case SEM_STAT:
-		fourth.__pad = (struct semid64_ds __user *)&s;
-		old_fs = get_fs();
-		set_fs(KERNEL_DS);
-		err = sys_semctl(first, second, third | IPC_64, fourth);
-		set_fs(old_fs);
-
-		if (third & IPC_64) {
-			struct semid64_ds32 __user *usp64 = (struct semid64_ds32 __user *) A(pad);
-
-			if (!access_ok(VERIFY_WRITE, usp64, sizeof(*usp64))) {
-				err = -EFAULT;
-				break;
-			}
-			err2 = __put_user(s.sem_perm.key, &usp64->sem_perm.key);
-			err2 |= __put_user(s.sem_perm.uid, &usp64->sem_perm.uid);
-			err2 |= __put_user(s.sem_perm.gid, &usp64->sem_perm.gid);
-			err2 |= __put_user(s.sem_perm.cuid, &usp64->sem_perm.cuid);
-			err2 |= __put_user(s.sem_perm.cgid, &usp64->sem_perm.cgid);
-			err2 |= __put_user(s.sem_perm.mode, &usp64->sem_perm.mode);
-			err2 |= __put_user(s.sem_perm.seq, &usp64->sem_perm.seq);
-			err2 |= __put_user(s.sem_otime, &usp64->sem_otime);
-			err2 |= __put_user(s.sem_ctime, &usp64->sem_ctime);
-			err2 |= __put_user(s.sem_nsems, &usp64->sem_nsems);
-		} else {
-			struct semid_ds32 __user *usp32 = (struct semid_ds32 __user *) A(pad);
-
-			if (!access_ok(VERIFY_WRITE, usp32, sizeof(*usp32))) {
-				err = -EFAULT;
-				break;
-			}
-			err2 = __put_user(s.sem_perm.key, &usp32->sem_perm.key);
-			err2 |= __put_user(s.sem_perm.uid, &usp32->sem_perm.uid);
-			err2 |= __put_user(s.sem_perm.gid, &usp32->sem_perm.gid);
-			err2 |= __put_user(s.sem_perm.cuid, &usp32->sem_perm.cuid);
-			err2 |= __put_user(s.sem_perm.cgid, &usp32->sem_perm.cgid);
-			err2 |= __put_user(s.sem_perm.mode, &usp32->sem_perm.mode);
-			err2 |= __put_user(s.sem_perm.seq, &usp32->sem_perm.seq);
-			err2 |= __put_user(s.sem_otime, &usp32->sem_otime);
-			err2 |= __put_user(s.sem_ctime, &usp32->sem_ctime);
-			err2 |= __put_user(s.sem_nsems, &usp32->sem_nsems);
-		}
-		if (err2)
-			err = -EFAULT;
-		break;
-
-	default:
-		err = - EINVAL;
-		break;
-	}
-
-	return err;
-}
-
-static int
-do_sys32_msgsnd (int first, int second, int third, void __user *uptr)
-{
-	struct msgbuf32 __user *up = (struct msgbuf32 __user *)uptr;
-	struct msgbuf *p;
-	mm_segment_t old_fs;
-	int err;
-
-	if (second < 0)
-		return -EINVAL;
-	p = kmalloc (second + sizeof (struct msgbuf)
-				    + 4, GFP_USER);
-	if (!p)
-		return -ENOMEM;
-	err = get_user (p->mtype, &up->mtype);
-	if (err)
-		goto out;
-	err |= __copy_from_user (p->mtext, &up->mtext, second);
-	if (err)
-		goto out;
-	old_fs = get_fs ();
-	set_fs (KERNEL_DS);
-	err = sys_msgsnd (first, (struct msgbuf __user *)p, second, third);
-	set_fs (old_fs);
-out:
-	kfree (p);
-
-	return err;
-}
-
-static int
-do_sys32_msgrcv (int first, int second, int msgtyp, int third,
-		 int version, void __user *uptr)
-{
-	struct msgbuf32 __user *up;
-	struct msgbuf *p;
-	mm_segment_t old_fs;
-	int err;
-
-	if (!version) {
-		struct ipc_kludge32 __user *uipck = (struct ipc_kludge32 __user *)uptr;
-		struct ipc_kludge32 ipck;
-
-		err = -EINVAL;
-		if (!uptr)
-			goto out;
-		err = -EFAULT;
-		if (copy_from_user (&ipck, uipck, sizeof (struct ipc_kludge32)))
-			goto out;
-		uptr = (void __user *)AA(ipck.msgp);
-		msgtyp = ipck.msgtyp;
-	}
-
-	if (second < 0)
-		return -EINVAL;
-	err = -ENOMEM;
-	p = kmalloc (second + sizeof (struct msgbuf) + 4, GFP_USER);
-	if (!p)
-		goto out;
-	old_fs = get_fs ();
-	set_fs (KERNEL_DS);
-	err = sys_msgrcv (first, (struct msgbuf __user *)p, second + 4, msgtyp, third);
-	set_fs (old_fs);
-	if (err < 0)
-		goto free_then_out;
-	up = (struct msgbuf32 __user *)uptr;
-	if (put_user (p->mtype, &up->mtype) ||
-	    __copy_to_user (&up->mtext, p->mtext, err))
-		err = -EFAULT;
-free_then_out:
-	kfree (p);
-out:
-	return err;
-}
-
-static int
-do_sys32_msgctl (int first, int second, void __user *uptr)
-{
-	int err = -EINVAL, err2;
-	struct msqid64_ds m;
-	struct msqid_ds32 __user *up32 = (struct msqid_ds32 __user *)uptr;
-	struct msqid64_ds32 __user *up64 = (struct msqid64_ds32 __user *)uptr;
-	mm_segment_t old_fs;
-
-	switch (second & ~IPC_64) {
-	case IPC_INFO:
-	case IPC_RMID:
-	case MSG_INFO:
-		err = sys_msgctl (first, second, (struct msqid_ds __user *)uptr);
-		break;
-
-	case IPC_SET:
-		if (second & IPC_64) {
-			if (!access_ok(VERIFY_READ, up64, sizeof(*up64))) {
-				err = -EFAULT;
-				break;
-			}
-			err = __get_user(m.msg_perm.uid, &up64->msg_perm.uid);
-			err |= __get_user(m.msg_perm.gid, &up64->msg_perm.gid);
-			err |= __get_user(m.msg_perm.mode, &up64->msg_perm.mode);
-			err |= __get_user(m.msg_qbytes, &up64->msg_qbytes);
-		} else {
-			if (!access_ok(VERIFY_READ, up32, sizeof(*up32))) {
-				err = -EFAULT;
-				break;
-			}
-			err = __get_user(m.msg_perm.uid, &up32->msg_perm.uid);
-			err |= __get_user(m.msg_perm.gid, &up32->msg_perm.gid);
-			err |= __get_user(m.msg_perm.mode, &up32->msg_perm.mode);
-			err |= __get_user(m.msg_qbytes, &up32->msg_qbytes);
-		}
-		if (err)
-			break;
-		old_fs = get_fs();
-		set_fs(KERNEL_DS);
-		err = sys_msgctl(first, second | IPC_64, (struct msqid_ds __user *)&m);
-		set_fs(old_fs);
-		break;
-
-	case IPC_STAT:
-	case MSG_STAT:
-		old_fs = get_fs();
-		set_fs(KERNEL_DS);
-		err = sys_msgctl(first, second | IPC_64, (struct msqid_ds __user *)&m);
-		set_fs(old_fs);
-		if (second & IPC_64) {
-			if (!access_ok(VERIFY_WRITE, up64, sizeof(*up64))) {
-				err = -EFAULT;
-				break;
-			}
-			err2 = __put_user(m.msg_perm.key, &up64->msg_perm.key);
-			err2 |= __put_user(m.msg_perm.uid, &up64->msg_perm.uid);
-			err2 |= __put_user(m.msg_perm.gid, &up64->msg_perm.gid);
-			err2 |= __put_user(m.msg_perm.cuid, &up64->msg_perm.cuid);
-			err2 |= __put_user(m.msg_perm.cgid, &up64->msg_perm.cgid);
-			err2 |= __put_user(m.msg_perm.mode, &up64->msg_perm.mode);
-			err2 |= __put_user(m.msg_perm.seq, &up64->msg_perm.seq);
-			err2 |= __put_user(m.msg_stime, &up64->msg_stime);
-			err2 |= __put_user(m.msg_rtime, &up64->msg_rtime);
-			err2 |= __put_user(m.msg_ctime, &up64->msg_ctime);
-			err2 |= __put_user(m.msg_cbytes, &up64->msg_cbytes);
-			err2 |= __put_user(m.msg_qnum, &up64->msg_qnum);
-			err2 |= __put_user(m.msg_qbytes, &up64->msg_qbytes);
-			err2 |= __put_user(m.msg_lspid, &up64->msg_lspid);
-			err2 |= __put_user(m.msg_lrpid, &up64->msg_lrpid);
-			if (err2)
-				err = -EFAULT;
-		} else {
-			if (!access_ok(VERIFY_WRITE, up32, sizeof(*up32))) {
-				err = -EFAULT;
-				break;
-			}
-			err2 = __put_user(m.msg_perm.key, &up32->msg_perm.key);
-			err2 |= __put_user(m.msg_perm.uid, &up32->msg_perm.uid);
-			err2 |= __put_user(m.msg_perm.gid, &up32->msg_perm.gid);
-			err2 |= __put_user(m.msg_perm.cuid, &up32->msg_perm.cuid);
-			err2 |= __put_user(m.msg_perm.cgid, &up32->msg_perm.cgid);
-			err2 |= __put_user(m.msg_perm.mode, &up32->msg_perm.mode);
-			err2 |= __put_user(m.msg_perm.seq, &up32->msg_perm.seq);
-			err2 |= __put_user(m.msg_stime, &up32->msg_stime);
-			err2 |= __put_user(m.msg_rtime, &up32->msg_rtime);
-			err2 |= __put_user(m.msg_ctime, &up32->msg_ctime);
-			err2 |= __put_user(m.msg_cbytes, &up32->msg_cbytes);
-			err2 |= __put_user(m.msg_qnum, &up32->msg_qnum);
-			err2 |= __put_user(m.msg_qbytes, &up32->msg_qbytes);
-			err2 |= __put_user(m.msg_lspid, &up32->msg_lspid);
-			err2 |= __put_user(m.msg_lrpid, &up32->msg_lrpid);
-			if (err2)
-				err = -EFAULT;
-		}
-		break;
-	}
-
-	return err;
-}
-
-static int
-do_sys32_shmat (int first, int second, int third, int version, void __user *uptr)
-{
-	unsigned long raddr;
-	u32 __user *uaddr = (u32 __user *)A((u32)third);
-	int err = -EINVAL;
-
-	if (version == 1)
-		return err;
-	err = do_shmat (first, uptr, second, &raddr);
-	if (err)
-		return err;
-	err = put_user (raddr, uaddr);
-	return err;
-}
-
-struct shm_info32 {
-	int used_ids;
-	u32 shm_tot, shm_rss, shm_swp;
-	u32 swap_attempts, swap_successes;
-};
-
-static int
-do_sys32_shmctl (int first, int second, void __user *uptr)
-{
-	struct shmid64_ds32 __user *up64 = (struct shmid64_ds32 __user *)uptr;
-	struct shmid_ds32 __user *up32 = (struct shmid_ds32 __user *)uptr;
-	struct shm_info32 __user *uip = (struct shm_info32 __user *)uptr;
-	int err = -EFAULT, err2;
-	struct shmid64_ds s64;
-	mm_segment_t old_fs;
-	struct shm_info si;
-	struct shmid_ds s;
-
-	switch (second & ~IPC_64) {
-	case IPC_INFO:
-		second = IPC_INFO; /* So that we don't have to translate it */
-	case IPC_RMID:
-	case SHM_LOCK:
-	case SHM_UNLOCK:
-		err = sys_shmctl(first, second, (struct shmid_ds __user *)uptr);
-		break;
-	case IPC_SET:
-		if (second & IPC_64) {
-			err = get_user(s.shm_perm.uid, &up64->shm_perm.uid);
-			err |= get_user(s.shm_perm.gid, &up64->shm_perm.gid);
-			err |= get_user(s.shm_perm.mode, &up64->shm_perm.mode);
-		} else {
-			err = get_user(s.shm_perm.uid, &up32->shm_perm.uid);
-			err |= get_user(s.shm_perm.gid, &up32->shm_perm.gid);
-			err |= get_user(s.shm_perm.mode, &up32->shm_perm.mode);
-		}
-		if (err)
-			break;
-		old_fs = get_fs();
-		set_fs(KERNEL_DS);
-		err = sys_shmctl(first, second & ~IPC_64, (struct shmid_ds __user *)&s);
-		set_fs(old_fs);
-		break;
-
-	case IPC_STAT:
-	case SHM_STAT:
-		old_fs = get_fs();
-		set_fs(KERNEL_DS);
-		err = sys_shmctl(first, second | IPC_64, (void __user *) &s64);
-		set_fs(old_fs);
-		if (err < 0)
-			break;
-		if (second & IPC_64) {
-			if (!access_ok(VERIFY_WRITE, up64, sizeof(*up64))) {
-				err = -EFAULT;
-				break;
-			}
-			err2 = __put_user(s64.shm_perm.key, &up64->shm_perm.key);
-			err2 |= __put_user(s64.shm_perm.uid, &up64->shm_perm.uid);
-			err2 |= __put_user(s64.shm_perm.gid, &up64->shm_perm.gid);
-			err2 |= __put_user(s64.shm_perm.cuid, &up64->shm_perm.cuid);
-			err2 |= __put_user(s64.shm_perm.cgid, &up64->shm_perm.cgid);
-			err2 |= __put_user(s64.shm_perm.mode, &up64->shm_perm.mode);
-			err2 |= __put_user(s64.shm_perm.seq, &up64->shm_perm.seq);
-			err2 |= __put_user(s64.shm_atime, &up64->shm_atime);
-			err2 |= __put_user(s64.shm_dtime, &up64->shm_dtime);
-			err2 |= __put_user(s64.shm_ctime, &up64->shm_ctime);
-			err2 |= __put_user(s64.shm_segsz, &up64->shm_segsz);
-			err2 |= __put_user(s64.shm_nattch, &up64->shm_nattch);
-			err2 |= __put_user(s64.shm_cpid, &up64->shm_cpid);
-			err2 |= __put_user(s64.shm_lpid, &up64->shm_lpid);
-		} else {
-			if (!access_ok(VERIFY_WRITE, up32, sizeof(*up32))) {
-				err = -EFAULT;
-				break;
-			}
-			err2 = __put_user(s64.shm_perm.key, &up32->shm_perm.key);
-			err2 |= __put_user(s64.shm_perm.uid, &up32->shm_perm.uid);
-			err2 |= __put_user(s64.shm_perm.gid, &up32->shm_perm.gid);
-			err2 |= __put_user(s64.shm_perm.cuid, &up32->shm_perm.cuid);
-			err2 |= __put_user(s64.shm_perm.cgid, &up32->shm_perm.cgid);
-			err2 |= __put_user(s64.shm_perm.mode, &up32->shm_perm.mode);
-			err2 |= __put_user(s64.shm_perm.seq, &up32->shm_perm.seq);
-			err2 |= __put_user(s64.shm_atime, &up32->shm_atime);
-			err2 |= __put_user(s64.shm_dtime, &up32->shm_dtime);
-			err2 |= __put_user(s64.shm_ctime, &up32->shm_ctime);
-			err2 |= __put_user(s64.shm_segsz, &up32->shm_segsz);
-			err2 |= __put_user(s64.shm_nattch, &up32->shm_nattch);
-			err2 |= __put_user(s64.shm_cpid, &up32->shm_cpid);
-			err2 |= __put_user(s64.shm_lpid, &up32->shm_lpid);
-		}
-		if (err2)
-			err = -EFAULT;
-		break;
-
-	case SHM_INFO:
-		old_fs = get_fs();
-		set_fs(KERNEL_DS);
-		err = sys_shmctl(first, second, (void __user *)&si);
-		set_fs(old_fs);
-		if (err < 0)
-			break;
-		err2 = put_user(si.used_ids, &uip->used_ids);
-		err2 |= __put_user(si.shm_tot, &uip->shm_tot);
-		err2 |= __put_user(si.shm_rss, &uip->shm_rss);
-		err2 |= __put_user(si.shm_swp, &uip->shm_swp);
-		err2 |= __put_user(si.swap_attempts, &uip->swap_attempts);
-		err2 |= __put_user (si.swap_successes, &uip->swap_successes);
-		if (err2)
-			err = -EFAULT;
-		break;
-
-	default:
-		err = -EINVAL;
-		break;
-	}
-
-	return err;
-}
-
-static int sys32_semtimedop(int semid, struct sembuf __user *tsems, int nsems,
-                            const struct compat_timespec __user *timeout32)
-{
-	struct compat_timespec t32;
-	struct timespec __user *t64 = compat_alloc_user_space(sizeof(*t64));
-
-	if (copy_from_user(&t32, timeout32, sizeof(t32)))
-		return -EFAULT;
-
-	if (put_user(t32.tv_sec, &t64->tv_sec) ||
-	    put_user(t32.tv_nsec, &t64->tv_nsec))
-		return -EFAULT;
-
-	return sys_semtimedop(semid, tsems, nsems, t64);
-}
-
 asmlinkage long
 sys32_ipc (u32 call, int first, int second, int third, u32 ptr, u32 fifth)
 {
@@ -918,48 +393,43 @@ sys32_ipc (u32 call, int first, int seco
 	switch (call) {
 	case SEMOP:
 		/* struct sembuf is the same on 32 and 64bit :)) */
-		err = sys_semtimedop (first, (struct sembuf __user *)AA(ptr), second,
-		                      NULL);
+		err = sys_semtimedop(first, compat_ptr(ptr), second, NULL);
 		break;
 	case SEMTIMEDOP:
-		err = sys32_semtimedop (first, (struct sembuf __user *)AA(ptr), second,
-		                      (const struct compat_timespec __user *)AA(fifth));
+		err = compat_sys_semtimedop(first, compat_ptr(ptr), second,
+					    compat_ptr(fifth));
 		break;
 	case SEMGET:
-		err = sys_semget (first, second, third);
+		err = sys_semget(first, second, third);
 		break;
 	case SEMCTL:
-		err = do_sys32_semctl (first, second, third,
-				       (void __user *)AA(ptr));
+		err = compat_sys_semctl(first, second, third, compat_ptr(ptr));
 		break;
-
 	case MSGSND:
-		err = do_sys32_msgsnd (first, second, third,
-				       (void __user *)AA(ptr));
+		err = compat_sys_msgsnd(first, second, third, compat_ptr(ptr));
 		break;
 	case MSGRCV:
-		err = do_sys32_msgrcv (first, second, fifth, third,
-				       version, (void __user *)AA(ptr));
+		err = compat_sys_msgrcv(first, second, fifth, third,
+					version, compat_ptr(ptr));
 		break;
 	case MSGGET:
-		err = sys_msgget ((key_t) first, second);
+		err = sys_msgget((key_t) first, second);
 		break;
 	case MSGCTL:
-		err = do_sys32_msgctl (first, second, (void __user *)AA(ptr));
+		err = compat_sys_msgctl(first, second, compat_ptr(ptr));
 		break;
-
 	case SHMAT:
-		err = do_sys32_shmat (first, second, third,
-				      version, (void __user *)AA(ptr));
+		err = compat_sys_shmat(first, second, third, version,
+				       compat_ptr(ptr));
 		break;
 	case SHMDT:
-		err = sys_shmdt ((char __user *)A(ptr));
+		err = sys_shmdt(compat_ptr(ptr));
 		break;
 	case SHMGET:
-		err = sys_shmget (first, (unsigned)second, third);
+		err = sys_shmget(first, (unsigned)second, third);
 		break;
 	case SHMCTL:
-		err = do_sys32_shmctl (first, second, (void __user *)AA(ptr));
+		err = compat_sys_shmctl(first, second, compat_ptr(ptr));
 		break;
 	default:
 		err = -EINVAL;
@@ -969,18 +439,16 @@ sys32_ipc (u32 call, int first, int seco
 	return err;
 }
 
-asmlinkage long sys32_shmat(int shmid, char __user *shmaddr,
-			  int shmflg, int32_t __user *addr)
+#ifdef CONFIG_MIPS32_N32
+asmlinkage long sys32_semctl(int semid, int semnum, int cmd, union semun arg)
 {
-	unsigned long raddr;
-	int err;
-
-	err = do_shmat(shmid, shmaddr, shmflg, &raddr);
-	if (err)
-		return err;
-
-	return put_user(raddr, addr);
+	/* compat_sys_semctl expects a pointer to union semun */
+	u32 __user *uptr = compat_alloc_user_space(sizeof(u32));
+	if (put_user(ptr_to_compat(arg.__pad), uptr))
+		return -EFAULT;
+	return compat_sys_semctl(semid, semnum, cmd, uptr);
 }
+#endif
 
 struct sysctl_args32
 {
diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index 0da5ca2..01c3d7c 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -149,8 +149,8 @@ EXPORT(sysn32_call_table)
 	PTR	sys_mincore
 	PTR	sys_madvise
 	PTR	sys_shmget
-	PTR	sys32_shmat
-	PTR	sys_shmctl			/* 6030 */
+	PTR	sys_shmat
+	PTR	compat_sys_shmctl			/* 6030 */
 	PTR	sys_dup
 	PTR	sys_dup2
 	PTR	sys_pause
@@ -184,12 +184,12 @@ EXPORT(sysn32_call_table)
 	PTR	sys32_newuname
 	PTR	sys_semget
 	PTR	sys_semop
-	PTR	sys_semctl
+	PTR	sys32_semctl
 	PTR	sys_shmdt			/* 6065 */
 	PTR	sys_msgget
-	PTR	sys_msgsnd
-	PTR	sys_msgrcv
-	PTR	sys_msgctl
+	PTR	compat_sys_msgsnd
+	PTR	compat_sys_msgrcv
+	PTR	compat_sys_msgctl
 	PTR	compat_sys_fcntl		/* 6070 */
 	PTR	sys_flock
 	PTR	sys_fsync
@@ -335,7 +335,7 @@ EXPORT(sysn32_call_table)
 	PTR	compat_sys_fcntl64
 	PTR	sys_set_tid_address
 	PTR	sys_restart_syscall
-	PTR	sys_semtimedop			/* 6215 */
+	PTR	compat_sys_semtimedop			/* 6215 */
 	PTR	sys_fadvise64_64
 	PTR	compat_sys_statfs64
 	PTR	compat_sys_fstatfs64
diff --git a/include/asm-mips/compat.h b/include/asm-mips/compat.h
index 900f472..55a0152 100644
--- a/include/asm-mips/compat.h
+++ b/include/asm-mips/compat.h
@@ -32,6 +32,7 @@ typedef struct {
 	s32	val[2];
 } compat_fsid_t;
 typedef s32		compat_timer_t;
+typedef s32		compat_key_t;
 
 typedef s32		compat_int_t;
 typedef s32		compat_long_t;
@@ -146,4 +147,71 @@ static inline void __user *compat_alloc_
 	return (void __user *) (regs->regs[29] - len);
 }
 
+struct compat_ipc64_perm {
+	compat_key_t key;
+	__compat_uid32_t uid;
+	__compat_gid32_t gid;
+	__compat_uid32_t cuid;
+	__compat_gid32_t cgid;
+	compat_mode_t mode;
+	unsigned short seq;
+	unsigned short __pad2;
+	compat_ulong_t __unused1;
+	compat_ulong_t __unused2;
+};
+
+struct compat_semid64_ds {
+	struct compat_ipc64_perm sem_perm;
+	compat_time_t	sem_otime;
+	compat_time_t	sem_ctime;
+	compat_ulong_t	sem_nsems;
+	compat_ulong_t	__unused1;
+	compat_ulong_t	__unused2;
+};
+
+struct compat_msqid64_ds {
+	struct compat_ipc64_perm msg_perm;
+#ifndef CONFIG_CPU_LITTLE_ENDIAN
+	compat_ulong_t	__unused1;
+#endif
+	compat_time_t	msg_stime;
+#ifdef CONFIG_CPU_LITTLE_ENDIAN
+	compat_ulong_t	__unused1;
+#endif
+#ifndef CONFIG_CPU_LITTLE_ENDIAN
+	compat_ulong_t	__unused2;
+#endif
+	compat_time_t	msg_rtime;
+#ifdef CONFIG_CPU_LITTLE_ENDIAN
+	compat_ulong_t	__unused2;
+#endif
+#ifndef CONFIG_CPU_LITTLE_ENDIAN
+	compat_ulong_t	__unused3;
+#endif
+	compat_time_t	msg_ctime;
+#ifdef CONFIG_CPU_LITTLE_ENDIAN
+	compat_ulong_t	__unused3;
+#endif
+	compat_ulong_t	msg_cbytes;
+	compat_ulong_t	msg_qnum;
+	compat_ulong_t	msg_qbytes;
+	compat_pid_t	msg_lspid;
+	compat_pid_t	msg_lrpid;
+	compat_ulong_t	__unused4;
+	compat_ulong_t	__unused5;
+};
+
+struct compat_shmid64_ds {
+	struct compat_ipc64_perm shm_perm;
+	compat_size_t	shm_segsz;
+	compat_time_t	shm_atime;
+	compat_time_t	shm_dtime;
+	compat_time_t	shm_ctime;
+	compat_pid_t	shm_cpid;
+	compat_pid_t	shm_lpid;
+	compat_ulong_t	shm_nattch;
+	compat_ulong_t	__unused1;
+	compat_ulong_t	__unused2;
+};
+
 #endif /* _ASM_COMPAT_H */
