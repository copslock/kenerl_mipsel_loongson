Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Oct 2002 16:33:58 +0200 (CEST)
Received: from ftp.mips.com ([206.31.31.227]:25800 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S1123897AbSJBOd5>;
	Wed, 2 Oct 2002 16:33:57 +0200
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g92EXCrZ006941;
	Wed, 2 Oct 2002 07:33:12 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id HAA24415;
	Wed, 2 Oct 2002 07:33:41 -0700 (PDT)
Received: from mips.com (IDENT:carstenl@coplin20 [192.168.205.90])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g92EXCb08754;
	Wed, 2 Oct 2002 16:33:13 +0200 (MEST)
Message-ID: <3D9B03A5.5307F659@mips.com>
Date: Wed, 02 Oct 2002 16:33:09 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.9-31-P3-UP-WS-jg i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	linux-mips@linux-mips.org
Subject: Re: 64-bit kernel patch.
References: <Pine.GSO.3.96.1021002153025.8947A-100000@delta.ds2.pg.gda.pl> <3D9AFD0E.84BA5100@mips.com> <20021002160948.F16482@linux-mips.org>
Content-Type: multipart/mixed;
 boundary="------------D7E47A80237233EEC4CA07EC"
Return-Path: <carstenl@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 341
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carstenl@mips.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------D7E47A80237233EEC4CA07EC
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

Here is another linux32.c patch.

/Carsten



Ralf Baechle wrote:

> On Wed, Oct 02, 2002 at 04:05:02PM +0200, Carsten Langgaard wrote:
>
> > Ok, here is the next patch.
> > It fixes the sys32_sendmsg and sys32_recvmsg.
>
> Ok, in.  Maciej, you can start the chainsawing ;-)
>
>   Ralf

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com



--------------D7E47A80237233EEC4CA07EC
Content-Type: text/plain; charset=iso-8859-15;
 name="syscall_wrapper.part3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="syscall_wrapper.part3.patch"

Index: arch/mips64/kernel/linux32.c
===================================================================
RCS file: /home/cvs/linux/arch/mips64/kernel/linux32.c,v
retrieving revision 1.42.2.14
diff -u -r1.42.2.14 linux32.c
--- arch/mips64/kernel/linux32.c	2 Oct 2002 14:09:24 -0000	1.42.2.14
+++ arch/mips64/kernel/linux32.c	2 Oct 2002 14:29:30 -0000
@@ -1598,6 +1598,15 @@
         unsigned short  sem_nsems;              /* no. of semaphores in array */
 };
 
+struct semid64_ds32 {
+	struct ipc64_perm32 sem_perm;
+	__kernel_time_t32 sem_otime;
+	__kernel_time_t32 sem_ctime;
+	unsigned int sem_nsems;
+	unsigned int __unused1;
+	unsigned int __unused2;
+};
+
 struct msqid_ds32
 {
         struct ipc_perm32 msg_perm;
@@ -1655,7 +1664,6 @@
 	u32 pad;
 	int err, err2;
 	struct semid64_ds s;
-	struct semid_ds32 *usp;
 	mm_segment_t old_fs;
 
 	if (!uptr)
@@ -1668,7 +1676,6 @@
 	else
 		fourth.__pad = (void *)A(pad);
 	switch (third & ~IPC_64) {
-
 	case IPC_INFO:
 	case IPC_RMID:
 	case IPC_SET:
@@ -1685,29 +1692,54 @@
 
 	case IPC_STAT:
 	case SEM_STAT:
-		usp = (struct semid_ds32 *)A(pad);
 		fourth.__pad = &s;
 		old_fs = get_fs ();
 		set_fs (KERNEL_DS);
 		err = sys_semctl (first, second, third, fourth);
 		set_fs (old_fs);
-		err2 = put_user(s.sem_perm.key, &usp->sem_perm.key);
-		err2 |= __put_user(s.sem_perm.uid, &usp->sem_perm.uid);
-		err2 |= __put_user(s.sem_perm.gid, &usp->sem_perm.gid);
-		err2 |= __put_user(s.sem_perm.cuid,
-				   &usp->sem_perm.cuid);
-		err2 |= __put_user (s.sem_perm.cgid,
-				    &usp->sem_perm.cgid);
-		err2 |= __put_user (s.sem_perm.mode,
-				    &usp->sem_perm.mode);
-		err2 |= __put_user (s.sem_perm.seq, &usp->sem_perm.seq);
-		err2 |= __put_user (s.sem_otime, &usp->sem_otime);
-		err2 |= __put_user (s.sem_ctime, &usp->sem_ctime);
-		err2 |= __put_user (s.sem_nsems, &usp->sem_nsems);
+
+		if (third & IPC_64) {
+			struct semid64_ds32 *usp64 = (struct semid64_ds32 *) A(pad);
+
+			if (!access_ok(VERIFY_WRITE, usp64, sizeof(*usp64))) {
+				err = -EFAULT;
+				break;
+			}
+			err2 = __put_user(s.sem_perm.key, &usp64->sem_perm.key);
+			err2 |= __put_user(s.sem_perm.uid, &usp64->sem_perm.uid);
+			err2 |= __put_user(s.sem_perm.gid, &usp64->sem_perm.gid);
+			err2 |= __put_user(s.sem_perm.cuid, &usp64->sem_perm.cuid);
+			err2 |= __put_user(s.sem_perm.cgid, &usp64->sem_perm.cgid);
+			err2 |= __put_user(s.sem_perm.mode, &usp64->sem_perm.mode);
+			err2 |= __put_user(s.sem_perm.seq, &usp64->sem_perm.seq);
+			err2 |= __put_user(s.sem_otime, &usp64->sem_otime);
+			err2 |= __put_user(s.sem_ctime, &usp64->sem_ctime);
+			err2 |= __put_user(s.sem_nsems, &usp64->sem_nsems);
+		} else {
+			struct semid_ds32 *usp32 = (struct semid_ds32 *) A(pad);
+
+			if (!access_ok(VERIFY_WRITE, usp32, sizeof(*usp32))) {
+				err = -EFAULT;
+				break;
+			}
+			err2 = __put_user(s.sem_perm.key, &usp32->sem_perm.key);
+			err2 |= __put_user(s.sem_perm.uid, &usp32->sem_perm.uid);
+			err2 |= __put_user(s.sem_perm.gid, &usp32->sem_perm.gid);
+			err2 |= __put_user(s.sem_perm.cuid, &usp32->sem_perm.cuid);
+			err2 |= __put_user(s.sem_perm.cgid, &usp32->sem_perm.cgid);
+			err2 |= __put_user(s.sem_perm.mode, &usp32->sem_perm.mode);
+			err2 |= __put_user(s.sem_perm.seq, &usp32->sem_perm.seq);
+			err2 |= __put_user(s.sem_otime, &usp32->sem_otime);
+			err2 |= __put_user(s.sem_ctime, &usp32->sem_ctime);
+			err2 |= __put_user(s.sem_nsems, &usp32->sem_nsems);
+		}
 		if (err2)
 			err = -EFAULT;
 		break;
 
+	default:
+		err = - EINVAL;
+		break;
 	}
 
 	return err;

--------------D7E47A80237233EEC4CA07EC--
