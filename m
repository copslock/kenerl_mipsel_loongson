Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Sep 2002 15:04:01 +0200 (CEST)
Received: from mx2.mips.com ([206.31.31.227]:10406 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S1122960AbSIINEA>;
	Mon, 9 Sep 2002 15:04:00 +0200
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g89D3pUD004393;
	Mon, 9 Sep 2002 06:03:51 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id GAA04365;
	Mon, 9 Sep 2002 06:03:52 -0700 (PDT)
Received: from mips.com (IDENT:carstenl@coplin20 [192.168.205.90])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g89D3nb28551;
	Mon, 9 Sep 2002 15:03:49 +0200 (MEST)
Message-ID: <3D7C9C34.AC04A4B@mips.com>
Date: Mon, 09 Sep 2002 15:03:48 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.9-31-P3-UP-WS-jg i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: 64-bit kernel patch
References: <3D7C910A.6D217586@mips.com>
Content-Type: multipart/mixed;
 boundary="------------3A830A5615E2F5B16D6844EB"
Return-Path: <carstenl@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 148
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carstenl@mips.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------3A830A5615E2F5B16D6844EB
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

OK, I try again. This time with the patch attached.

/Carsten


Carsten Langgaard wrote:

> I have send this patch before, although it's a little bit different from
> the previous one.
> The patch fixes the ipc syscalls in the o32 wrapper/conversion routines,
> which is needed when running a 64-bit kernel on an o32 userland.
> Ralf, could you please apply.
>
> /Carsten
>
> --
> _    _ ____  ___   Carsten Langgaard  Mailto:carstenl@mips.com
> |\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
> | \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
>   TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
>                    Denmark            http://www.mips.com

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com



--------------3A830A5615E2F5B16D6844EB
Content-Type: text/plain; charset=iso-8859-15;
 name="ipc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipc.patch"

Index: arch/mips64/kernel/linux32.c
===================================================================
RCS file: /cvs/linux/arch/mips64/kernel/linux32.c,v
retrieving revision 1.42.2.9
diff -u -r1.42.2.9 linux32.c
--- arch/mips64/kernel/linux32.c	2002/07/23 12:26:09	1.42.2.9
+++ arch/mips64/kernel/linux32.c	2002/09/09 12:06:04
@@ -35,8 +35,16 @@
 #include <asm/mman.h>
 #include <asm/ipc.h>
 
-
+/* Use this to get at 32-bit user passed pointers. */
+/* A() macro should be used for places where you e.g.
+   have some internal variable u32 and just want to get
+   rid of a compiler warning. AA() has to be used in
+   places where you want to convert a function argument
+   to 32bit pointer or when you e.g. access pt_regs
+   structure and want to consider 32bit registers only.
+ */
 #define A(__x) ((unsigned long)(__x))
+#define AA(__x) ((unsigned long)((int)__x))
 
 #ifdef __MIPSEB__
 #define merge_64(r1,r2)	((((r1) & 0xffffffffUL) << 32) + ((r2) & 0xffffffffUL))
@@ -1494,6 +1502,19 @@
         unsigned short  seq;
 };
 
+struct ipc64_perm32 {
+	key_t key;
+	__kernel_uid_t32 uid;
+	__kernel_gid_t32 gid;
+	__kernel_uid_t32 cuid;
+	__kernel_gid_t32 cgid;
+	__kernel_mode_t32 mode; 
+	unsigned short seq;
+	unsigned short __pad1;
+	unsigned int __unused1;
+	unsigned int __unused2;
+};
+
 struct semid_ds32 {
         struct ipc_perm32 sem_perm;               /* permissions .. see ipc.h */
         __kernel_time_t32 sem_otime;              /* last semop time */
@@ -1522,6 +1543,23 @@
         __kernel_ipc_pid_t32 msg_lrpid;
 };
 
+struct msqid64_ds32 {
+	struct ipc64_perm32 msg_perm;
+	__kernel_time_t32 msg_stime;
+	unsigned int __unused1;
+	__kernel_time_t32 msg_rtime;
+	unsigned int __unused2;
+	__kernel_time_t32 msg_ctime;
+	unsigned int __unused3;
+	unsigned int msg_cbytes;
+	unsigned int msg_qnum;
+	unsigned int msg_qbytes;
+	__kernel_pid_t32 msg_lspid;
+	__kernel_pid_t32 msg_lrpid;
+	unsigned int __unused4;
+	unsigned int __unused5;
+};
+
 struct shmid_ds32 {
         struct ipc_perm32       shm_perm;
         int                     shm_segsz;
@@ -1533,7 +1571,10 @@
         unsigned short          shm_nattch;
 };
 
-#define IPCOP_MASK(__x)	(1UL << (__x))
+struct ipc_kludge32 {
+	u32 msgp;
+	s32 msgtyp;
+};
 
 static int
 do_sys32_semctl(int first, int second, int third, void *uptr)
@@ -1600,21 +1641,23 @@
 	return err;
 }
 
-static int
 do_sys32_msgsnd (int first, int second, int third, void *uptr)
 {
-	struct msgbuf *p = kmalloc (second + sizeof (struct msgbuf)
-				    + 4, GFP_USER);
 	struct msgbuf32 *up = (struct msgbuf32 *)uptr;
+	struct msgbuf *p;
 	mm_segment_t old_fs;
 	int err;
 
+	if (second < 0)
+		return -EINVAL;
+	p = kmalloc (second + sizeof (struct msgbuf)
+				    + 4, GFP_USER);
 	if (!p)
 		return -ENOMEM;
 	err = get_user (p->mtype, &up->mtype);
 	if (err)
 		goto out;
-	err = __copy_from_user (p->mtext, &up->mtext, second);
+	err |= __copy_from_user (p->mtext, &up->mtext, second);
 	if (err)
 		goto out;
 	old_fs = get_fs ();
@@ -1623,6 +1666,7 @@
 	set_fs (old_fs);
 out:
 	kfree (p);
+
 	return err;
 }
 
@@ -1636,18 +1680,21 @@
 	int err;
 
 	if (!version) {
-		struct ipc_kludge *uipck = (struct ipc_kludge *)uptr;
-		struct ipc_kludge ipck;
+		struct ipc_kludge32 *uipck = (struct ipc_kludge32 *)uptr;
+		struct ipc_kludge32 ipck;
 
 		err = -EINVAL;
 		if (!uptr)
 			goto out;
 		err = -EFAULT;
-		if (copy_from_user (&ipck, uipck, sizeof (struct ipc_kludge)))
+		if (copy_from_user (&ipck, uipck, sizeof (struct ipc_kludge32)))
 			goto out;
-		uptr = (void *)A(ipck.msgp);
+		uptr = (void *)AA(ipck.msgp);
 		msgtyp = ipck.msgtyp;
 	}
+
+	if (second < 0)
+		return -EINVAL;
 	err = -ENOMEM;
 	p = kmalloc (second + sizeof (struct msgbuf) + 4, GFP_USER);
 	if (!p)
@@ -1672,13 +1719,12 @@
 do_sys32_msgctl (int first, int second, void *uptr)
 {
 	int err = -EINVAL, err2;
-	struct msqid_ds m;
-	struct msqid64_ds m64;
-	struct msqid_ds32 *up = (struct msqid_ds32 *)uptr;
+	struct msqid64_ds m;
+	struct msqid_ds32 *up32 = (struct msqid_ds32 *)uptr;
+	struct msqid64_ds32 *up64 = (struct msqid64_ds32 *)uptr;
 	mm_segment_t old_fs;
 
-	switch (second) {
-
+	switch (second & ~IPC_64) {
 	case IPC_INFO:
 	case IPC_RMID:
 	case MSG_INFO:
@@ -1686,15 +1732,30 @@
 		break;
 
 	case IPC_SET:
-		err = get_user (m.msg_perm.uid, &up->msg_perm.uid);
-		err |= __get_user (m.msg_perm.gid, &up->msg_perm.gid);
-		err |= __get_user (m.msg_perm.mode, &up->msg_perm.mode);
-		err |= __get_user (m.msg_qbytes, &up->msg_qbytes);
+		if (second & IPC_64) {
+			if (!access_ok(VERIFY_READ, up64, sizeof(*up64))) {
+				err = -EFAULT;
+				break;
+			}
+			err = __get_user(m.msg_perm.uid, &up64->msg_perm.uid);
+			err |= __get_user(m.msg_perm.gid, &up64->msg_perm.gid);
+			err |= __get_user(m.msg_perm.mode, &up64->msg_perm.mode);
+			err |= __get_user(m.msg_qbytes, &up64->msg_qbytes);
+		} else {
+			if (!access_ok(VERIFY_READ, up32, sizeof(*up32))) {
+				err = -EFAULT;
+				break;
+			}
+			err = __get_user(m.msg_perm.uid, &up32->msg_perm.uid);
+			err |= __get_user(m.msg_perm.gid, &up32->msg_perm.gid);
+			err |= __get_user(m.msg_perm.mode, &up32->msg_perm.mode);
+			err |= __get_user(m.msg_qbytes, &up32->msg_qbytes);
+		}
 		if (err)
 			break;
 		old_fs = get_fs ();
 		set_fs (KERNEL_DS);
-		err = sys_msgctl (first, second, &m);
+		err = sys_msgctl (first, second, (struct msqid_ds *)&m);
 		set_fs (old_fs);
 		break;
 
@@ -1702,27 +1763,54 @@
 	case MSG_STAT:
 		old_fs = get_fs ();
 		set_fs (KERNEL_DS);
-		err = sys_msgctl (first, second, (void *) &m64);
+		err = sys_msgctl (first, second, (struct msqid_ds *)&m);
 		set_fs (old_fs);
-		err2 = put_user (m64.msg_perm.key, &up->msg_perm.key);
-		err2 |= __put_user(m64.msg_perm.uid, &up->msg_perm.uid);
-		err2 |= __put_user(m64.msg_perm.gid, &up->msg_perm.gid);
-		err2 |= __put_user(m64.msg_perm.cuid, &up->msg_perm.cuid);
-		err2 |= __put_user(m64.msg_perm.cgid, &up->msg_perm.cgid);
-		err2 |= __put_user(m64.msg_perm.mode, &up->msg_perm.mode);
-		err2 |= __put_user(m64.msg_perm.seq, &up->msg_perm.seq);
-		err2 |= __put_user(m64.msg_stime, &up->msg_stime);
-		err2 |= __put_user(m64.msg_rtime, &up->msg_rtime);
-		err2 |= __put_user(m64.msg_ctime, &up->msg_ctime);
-		err2 |= __put_user(m64.msg_cbytes, &up->msg_cbytes);
-		err2 |= __put_user(m64.msg_qnum, &up->msg_qnum);
-		err2 |= __put_user(m64.msg_qbytes, &up->msg_qbytes);
-		err2 |= __put_user(m64.msg_lspid, &up->msg_lspid);
-		err2 |= __put_user(m64.msg_lrpid, &up->msg_lrpid);
-		if (err2)
-			err = -EFAULT;
+		if (second & IPC_64) {
+			if (!access_ok(VERIFY_WRITE, up64, sizeof(*up64))) {
+				err = -EFAULT;
+				break;
+			}
+			err2 = __put_user(m.msg_perm.key, &up64->msg_perm.key);
+			err2 |= __put_user(m.msg_perm.uid, &up64->msg_perm.uid);
+			err2 |= __put_user(m.msg_perm.gid, &up64->msg_perm.gid);
+			err2 |= __put_user(m.msg_perm.cuid, &up64->msg_perm.cuid);
+			err2 |= __put_user(m.msg_perm.cgid, &up64->msg_perm.cgid);
+			err2 |= __put_user(m.msg_perm.mode, &up64->msg_perm.mode);
+			err2 |= __put_user(m.msg_perm.seq, &up64->msg_perm.seq);
+			err2 |= __put_user(m.msg_stime, &up64->msg_stime);
+			err2 |= __put_user(m.msg_rtime, &up64->msg_rtime);
+			err2 |= __put_user(m.msg_ctime, &up64->msg_ctime);
+			err2 |= __put_user(m.msg_cbytes, &up64->msg_cbytes);
+			err2 |= __put_user(m.msg_qnum, &up64->msg_qnum);
+			err2 |= __put_user(m.msg_qbytes, &up64->msg_qbytes);
+			err2 |= __put_user(m.msg_lspid, &up64->msg_lspid);
+			err2 |= __put_user(m.msg_lrpid, &up64->msg_lrpid);
+			if (err2)
+				err = -EFAULT;
+		} else {
+			if (!access_ok(VERIFY_WRITE, up32, sizeof(*up32))) {
+				err = -EFAULT;
+				break;
+			}
+			err2 = __put_user(m.msg_perm.key, &up32->msg_perm.key);
+			err2 |= __put_user(m.msg_perm.uid, &up32->msg_perm.uid);
+			err2 |= __put_user(m.msg_perm.gid, &up32->msg_perm.gid);
+			err2 |= __put_user(m.msg_perm.cuid, &up32->msg_perm.cuid);
+			err2 |= __put_user(m.msg_perm.cgid, &up32->msg_perm.cgid);
+			err2 |= __put_user(m.msg_perm.mode, &up32->msg_perm.mode);
+			err2 |= __put_user(m.msg_perm.seq, &up32->msg_perm.seq);
+			err2 |= __put_user(m.msg_stime, &up32->msg_stime);
+			err2 |= __put_user(m.msg_rtime, &up32->msg_rtime);
+			err2 |= __put_user(m.msg_ctime, &up32->msg_ctime);
+			err2 |= __put_user(m.msg_cbytes, &up32->msg_cbytes);
+			err2 |= __put_user(m.msg_qnum, &up32->msg_qnum);
+			err2 |= __put_user(m.msg_qbytes, &up32->msg_qbytes);
+			err2 |= __put_user(m.msg_lspid, &up32->msg_lspid);
+			err2 |= __put_user(m.msg_lrpid, &up32->msg_lrpid);
+			if (err2)
+				err = -EFAULT;
+		}
 		break;
-
 	}
 
 	return err;
@@ -1845,7 +1933,7 @@
 
 	case SEMOP:
 		/* struct sembuf is the same on 32 and 64bit :)) */
-		err = sys_semop (first, (struct sembuf *)A(ptr),
+		err = sys_semop (first, (struct sembuf *)AA(ptr),
 				 second);
 		break;
 	case SEMGET:
@@ -1853,27 +1941,27 @@
 		break;
 	case SEMCTL:
 		err = do_sys32_semctl (first, second, third,
-				       (void *)A(ptr));
+				       (void *)AA(ptr));
 		break;
 
 	case MSGSND:
 		err = do_sys32_msgsnd (first, second, third,
-				       (void *)A(ptr));
+				       (void *)AA(ptr));
 		break;
 	case MSGRCV:
 		err = do_sys32_msgrcv (first, second, fifth, third,
-				       version, (void *)A(ptr));
+				       version, (void *)AA(ptr));
 		break;
 	case MSGGET:
 		err = sys_msgget ((key_t) first, second);
 		break;
 	case MSGCTL:
-		err = do_sys32_msgctl (first, second, (void *)A(ptr));
+		err = do_sys32_msgctl (first, second, (void *)AA(ptr));
 		break;
 
 	case SHMAT:
 		err = do_sys32_shmat (first, second, third,
-				      version, (void *)A(ptr));
+				      version, (void *)AA(ptr));
 		break;
 	case SHMDT:
 		err = sys_shmdt ((char *)A(ptr));
@@ -1882,7 +1970,7 @@
 		err = sys_shmget (first, second, third);
 		break;
 	case SHMCTL:
-		err = do_sys32_shmctl (first, second, (void *)A(ptr));
+		err = do_sys32_shmctl (first, second, (void *)AA(ptr));
 		break;
 	default:
 		err = -EINVAL;

--------------3A830A5615E2F5B16D6844EB--
