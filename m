Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Feb 2006 14:34:38 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:52425 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S3467527AbWBHOeX (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 8 Feb 2006 14:34:23 +0000
Received: from localhost (p8063-ipad01funabasi.chiba.ocn.ne.jp [61.207.82.63])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id B956F9B93; Wed,  8 Feb 2006 23:40:06 +0900 (JST)
Date:	Wed, 08 Feb 2006 23:39:49 +0900 (JST)
Message-Id: <20060208.233949.25478044.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] add some __user tags to syscall.c
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10368
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c
index 3323584..1da2eeb 100644
--- a/arch/mips/kernel/syscall.c
+++ b/arch/mips/kernel/syscall.c
@@ -212,12 +212,12 @@ asmlinkage int sys_execve(nabi_no_regarg
 	int error;
 	char * filename;
 
-	filename = getname((char *) (long)regs.regs[4]);
+	filename = getname((char __user *) (long)regs.regs[4]);
 	error = PTR_ERR(filename);
 	if (IS_ERR(filename))
 		goto out;
-	error = do_execve(filename, (char **) (long)regs.regs[5],
-	                  (char **) (long)regs.regs[6], &regs);
+	error = do_execve(filename, (char __user *__user *) (long)regs.regs[5],
+	                  (char __user *__user *) (long)regs.regs[6], &regs);
 	putname(filename);
 
 out:
@@ -227,7 +227,7 @@ out:
 /*
  * Compacrapability ...
  */
-asmlinkage int sys_uname(struct old_utsname * name)
+asmlinkage int sys_uname(struct old_utsname __user * name)
 {
 	if (name && !copy_to_user(name, &system_utsname, sizeof (*name)))
 		return 0;
@@ -237,7 +237,7 @@ asmlinkage int sys_uname(struct old_utsn
 /*
  * Compacrapability ...
  */
-asmlinkage int sys_olduname(struct oldold_utsname * name)
+asmlinkage int sys_olduname(struct oldold_utsname __user * name)
 {
 	int error;
 
@@ -274,7 +274,7 @@ void sys_set_thread_area(unsigned long a
 asmlinkage int _sys_sysmips(int cmd, long arg1, int arg2, int arg3)
 {
 	int	tmp, len;
-	char	*name;
+	char	__user *name;
 
 	switch(cmd) {
 	case SETNAME: {
@@ -283,7 +283,7 @@ asmlinkage int _sys_sysmips(int cmd, lon
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
 
-		name = (char *) arg1;
+		name = (char __user *) arg1;
 
 		len = strncpy_from_user(nodename, name, __NEW_UTS_LEN);
 		if (len < 0)
@@ -324,7 +324,7 @@ asmlinkage int _sys_sysmips(int cmd, lon
  * This is really horribly ugly.
  */
 asmlinkage int sys_ipc (uint call, int first, int second,
-			unsigned long third, void *ptr, long fifth)
+			unsigned long third, void __user *ptr, long fifth)
 {
 	int version, ret;
 
@@ -333,24 +333,25 @@ asmlinkage int sys_ipc (uint call, int f
 
 	switch (call) {
 	case SEMOP:
-		return sys_semtimedop (first, (struct sembuf *)ptr, second,
-		                       NULL);
+		return sys_semtimedop (first, (struct sembuf __user *)ptr,
+		                       second, NULL);
 	case SEMTIMEDOP:
-		return sys_semtimedop (first, (struct sembuf *)ptr, second,
-		                       (const struct timespec __user *)fifth);
+		return sys_semtimedop (first, (struct sembuf __user *)ptr,
+				       second,
+				       (const struct timespec __user *)fifth);
 	case SEMGET:
 		return sys_semget (first, second, third);
 	case SEMCTL: {
 		union semun fourth;
 		if (!ptr)
 			return -EINVAL;
-		if (get_user(fourth.__pad, (void **) ptr))
+		if (get_user(fourth.__pad, (void *__user *) ptr))
 			return -EFAULT;
 		return sys_semctl (first, second, third, fourth);
 	}
 
 	case MSGSND:
-		return sys_msgsnd (first, (struct msgbuf *) ptr,
+		return sys_msgsnd (first, (struct msgbuf __user *) ptr,
 				   second, third);
 	case MSGRCV:
 		switch (version) {
@@ -360,7 +361,7 @@ asmlinkage int sys_ipc (uint call, int f
 				return -EINVAL;
 
 			if (copy_from_user(&tmp,
-					   (struct ipc_kludge *) ptr,
+					   (struct ipc_kludge __user *) ptr,
 					   sizeof (tmp)))
 				return -EFAULT;
 			return sys_msgrcv (first, tmp.msgp, second,
@@ -368,35 +369,38 @@ asmlinkage int sys_ipc (uint call, int f
 		}
 		default:
 			return sys_msgrcv (first,
-					   (struct msgbuf *) ptr,
+					   (struct msgbuf __user *) ptr,
 					   second, fifth, third);
 		}
 	case MSGGET:
 		return sys_msgget ((key_t) first, second);
 	case MSGCTL:
-		return sys_msgctl (first, second, (struct msqid_ds *) ptr);
+		return sys_msgctl (first, second,
+				   (struct msqid_ds __user *) ptr);
 
 	case SHMAT:
 		switch (version) {
 		default: {
 			ulong raddr;
-			ret = do_shmat (first, (char *) ptr, second, &raddr);
+			ret = do_shmat (first, (char __user *) ptr, second,
+					&raddr);
 			if (ret)
 				return ret;
-			return put_user (raddr, (ulong *) third);
+			return put_user (raddr, (ulong __user *) third);
 		}
 		case 1:	/* iBCS2 emulator entry point */
 			if (!segment_eq(get_fs(), get_ds()))
 				return -EINVAL;
-			return do_shmat (first, (char *) ptr, second, (ulong *) third);
+			return do_shmat (first, (char __user *) ptr, second,
+					 (ulong *) third);
 		}
 	case SHMDT:
-		return sys_shmdt ((char *)ptr);
+		return sys_shmdt ((char __user *)ptr);
 	case SHMGET:
 		return sys_shmget (first, second, third);
 	case SHMCTL:
 		return sys_shmctl (first, second,
-				   (struct shmid_ds *) ptr);
+				   (struct shmid_ds __user *) ptr);
 	default:
 		return -ENOSYS;
 	}
