Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Oct 2002 13:29:14 +0200 (CEST)
Received: from ftp.mips.com ([206.31.31.227]:64910 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S1123398AbSJJL3N>;
	Thu, 10 Oct 2002 13:29:13 +0200
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g9ABQwNf009581;
	Thu, 10 Oct 2002 04:26:59 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id EAA17783;
	Thu, 10 Oct 2002 04:27:35 -0700 (PDT)
Received: from mips.com (IDENT:carstenl@coplin20 [192.168.205.90])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g9ABQub14332;
	Thu, 10 Oct 2002 13:26:57 +0200 (MEST)
Message-ID: <3DA563FF.4484A818@mips.com>
Date: Thu, 10 Oct 2002 13:26:55 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.9-31-P3-UP-WS-jg i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	linux-mips@linux-mips.org
Subject: 64-bit kernel patch
Content-Type: multipart/mixed;
 boundary="------------A9737B481F110F90A6C1E29B"
Return-Path: <carstenl@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 408
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carstenl@mips.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------A9737B481F110F90A6C1E29B
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

Here is yet another patch for the 64-bit syscall wrapper.

/Carsten


--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com



--------------A9737B481F110F90A6C1E29B
Content-Type: text/plain; charset=iso-8859-15;
 name="syscall_wrapper.part5.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="syscall_wrapper.part5.patch"

Index: arch/mips64/kernel/linux32.c
===================================================================
RCS file: /home/cvs/linux/arch/mips64/kernel/linux32.c,v
retrieving revision 1.42.2.16
diff -u -r1.42.2.16 linux32.c
--- arch/mips64/kernel/linux32.c	3 Oct 2002 09:38:26 -0000	1.42.2.16
+++ arch/mips64/kernel/linux32.c	10 Oct 2002 11:22:40 -0000
@@ -751,12 +751,17 @@
 	int ret;
 	struct statfs s;
 	mm_segment_t old_fs = get_fs();
-
-	set_fs (KERNEL_DS);
-	ret = sys_statfs((const char *)path, &s);
-	set_fs (old_fs);
-	if (put_statfs(buf, &s))
-		return -EFAULT;
+	char *pth;
+	
+	pth = getname (path);
+	ret = PTR_ERR(pth);
+	if (!IS_ERR(pth)) {
+		set_fs (KERNEL_DS);
+		ret = sys_statfs((const char *)path, &s);
+		set_fs (old_fs);
+		if (!ret && put_statfs(buf, &s))
+			return -EFAULT;
+	}
 	return ret;
 }
 
@@ -1652,6 +1657,19 @@
         unsigned short          shm_nattch;
 };
 
+struct shmid64_ds32 {
+	struct ipc64_perm32 shm_perm;
+	__kernel_size_t32 shm_segsz;
+	__kernel_time_t32 shm_atime;
+	__kernel_time_t32 shm_dtime;
+	__kernel_time_t32 shm_ctime;
+	__kernel_pid_t32 shm_cpid;
+	__kernel_pid_t32 shm_lpid;
+	unsigned int shm_nattch;
+	unsigned int __unused1;
+	unsigned int __unused2;
+};
+
 struct ipc_kludge32 {
 	u32 msgp;
 	s32 msgtyp;
@@ -1945,7 +1963,8 @@
 	int err = -EFAULT, err2;
 	struct shmid_ds s;
 	struct shmid64_ds s64;
-	struct shmid_ds32 *up = (struct shmid_ds32 *)uptr;
+	struct shmid_ds32 *up32 = (struct shmid_ds32 *)uptr;
+	struct shmid64_ds32 *up64 = (struct shmid64_ds32 *)uptr;
 	mm_segment_t old_fs;
 	struct shm_info32 {
 		int used_ids;
@@ -1954,18 +1973,24 @@
 	} *uip = (struct shm_info32 *)uptr;
 	struct shm_info si;
 
-	switch (second) {
-
+	switch (second & ~IPC_64) {
 	case IPC_INFO:
+		second = IPC_INFO; /* So that we don't have to translate it */
 	case IPC_RMID:
 	case SHM_LOCK:
 	case SHM_UNLOCK:
 		err = sys_shmctl (first, second, (struct shmid_ds *)uptr);
 		break;
 	case IPC_SET:
-		err = get_user (s.shm_perm.uid, &up->shm_perm.uid);
-		err |= __get_user (s.shm_perm.gid, &up->shm_perm.gid);
-		err |= __get_user (s.shm_perm.mode, &up->shm_perm.mode);
+		if (second & IPC_64) {
+			err = get_user(s.shm_perm.uid, &up64->shm_perm.uid);
+			err |= get_user(s.shm_perm.gid, &up64->shm_perm.gid);
+			err |= get_user(s.shm_perm.mode, &up64->shm_perm.mode);
+		} else {
+			err = get_user(s.shm_perm.uid, &up32->shm_perm.uid);
+			err |= get_user(s.shm_perm.gid, &up32->shm_perm.gid);
+			err |= get_user(s.shm_perm.mode, &up32->shm_perm.mode);
+		}
 		if (err)
 			break;
 		old_fs = get_fs ();
@@ -1982,23 +2007,45 @@
 		set_fs (old_fs);
 		if (err < 0)
 			break;
-		err2 = put_user (s64.shm_perm.key, &up->shm_perm.key);
-		err2 |= __put_user (s64.shm_perm.uid, &up->shm_perm.uid);
-		err2 |= __put_user (s64.shm_perm.gid, &up->shm_perm.gid);
-		err2 |= __put_user (s64.shm_perm.cuid,
-				    &up->shm_perm.cuid);
-		err2 |= __put_user (s64.shm_perm.cgid,
-				    &up->shm_perm.cgid);
-		err2 |= __put_user (s64.shm_perm.mode,
-				    &up->shm_perm.mode);
-		err2 |= __put_user (s64.shm_perm.seq, &up->shm_perm.seq);
-		err2 |= __put_user (s64.shm_atime, &up->shm_atime);
-		err2 |= __put_user (s64.shm_dtime, &up->shm_dtime);
-		err2 |= __put_user (s64.shm_ctime, &up->shm_ctime);
-		err2 |= __put_user (s64.shm_segsz, &up->shm_segsz);
-		err2 |= __put_user (s64.shm_nattch, &up->shm_nattch);
-		err2 |= __put_user (s64.shm_cpid, &up->shm_cpid);
-		err2 |= __put_user (s64.shm_lpid, &up->shm_lpid);
+		if (second & IPC_64) {
+			if (!access_ok(VERIFY_WRITE, up64, sizeof(*up64))) {
+				err = -EFAULT;
+				break;
+			}
+			err2 = __put_user(s64.shm_perm.key, &up64->shm_perm.key);
+			err2 |= __put_user(s64.shm_perm.uid, &up64->shm_perm.uid);
+			err2 |= __put_user(s64.shm_perm.gid, &up64->shm_perm.gid);
+			err2 |= __put_user(s64.shm_perm.cuid, &up64->shm_perm.cuid);
+			err2 |= __put_user(s64.shm_perm.cgid, &up64->shm_perm.cgid);
+			err2 |= __put_user(s64.shm_perm.mode, &up64->shm_perm.mode);
+			err2 |= __put_user(s64.shm_perm.seq, &up64->shm_perm.seq);
+			err2 |= __put_user(s64.shm_atime, &up64->shm_atime);
+			err2 |= __put_user(s64.shm_dtime, &up64->shm_dtime);
+			err2 |= __put_user(s64.shm_ctime, &up64->shm_ctime);
+			err2 |= __put_user(s64.shm_segsz, &up64->shm_segsz);
+			err2 |= __put_user(s64.shm_nattch, &up64->shm_nattch);
+			err2 |= __put_user(s64.shm_cpid, &up64->shm_cpid);
+			err2 |= __put_user(s64.shm_lpid, &up64->shm_lpid);
+		} else {
+			if (!access_ok(VERIFY_WRITE, up32, sizeof(*up32))) {
+				err = -EFAULT;
+				break;
+			}
+			err2 = __put_user(s64.shm_perm.key, &up32->shm_perm.key);
+			err2 |= __put_user(s64.shm_perm.uid, &up32->shm_perm.uid);
+			err2 |= __put_user(s64.shm_perm.gid, &up32->shm_perm.gid);
+			err2 |= __put_user(s64.shm_perm.cuid, &up32->shm_perm.cuid);
+			err2 |= __put_user(s64.shm_perm.cgid, &up32->shm_perm.cgid);
+			err2 |= __put_user(s64.shm_perm.mode, &up32->shm_perm.mode);
+			err2 |= __put_user(s64.shm_perm.seq, &up32->shm_perm.seq);
+			err2 |= __put_user(s64.shm_atime, &up32->shm_atime);
+			err2 |= __put_user(s64.shm_dtime, &up32->shm_dtime);
+			err2 |= __put_user(s64.shm_ctime, &up32->shm_ctime);
+			err2 |= __put_user(s64.shm_segsz, &up32->shm_segsz);
+			err2 |= __put_user(s64.shm_nattch, &up32->shm_nattch);
+			err2 |= __put_user(s64.shm_cpid, &up32->shm_cpid);
+			err2 |= __put_user(s64.shm_lpid, &up32->shm_lpid);
+		}
 		if (err2)
 			err = -EFAULT;
 		break;
@@ -2022,7 +2069,11 @@
 			err = -EFAULT;
 		break;
 
+	default:
+		err = - EINVAL;
+		break;
 	}
+
 	return err;
 }
 

--------------A9737B481F110F90A6C1E29B--
