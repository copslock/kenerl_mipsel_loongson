Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Feb 2006 06:52:14 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:28689 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S8127231AbWBUGwE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 21 Feb 2006 06:52:04 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Tue, 21 Feb 2006 15:59:04 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 09B7820445;
	Tue, 21 Feb 2006 15:59:02 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id F32DE20444;
	Tue, 21 Feb 2006 15:59:01 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k1L6x14D010243;
	Tue, 21 Feb 2006 15:59:01 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Tue, 21 Feb 2006 15:59:00 +0900 (JST)
Message-Id: <20060221.155900.45517504.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] use generic compat routines for readdir, getdents
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
X-archive-position: 10587
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Not just cleanup but also fixes O32 readdir(2) emulation.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/kernel/linux32.c b/arch/mips/kernel/linux32.c
index 5f68b22..e00e5f6 100644
--- a/arch/mips/kernel/linux32.c
+++ b/arch/mips/kernel/linux32.c
@@ -161,60 +161,6 @@ out:
 	return error;
 }
 
-struct dirent32 {
-	unsigned int	d_ino;
-	unsigned int	d_off;
-	unsigned short	d_reclen;
-	char		d_name[NAME_MAX + 1];
-};
-
-static void
-xlate_dirent(void *dirent64, void *dirent32, long n)
-{
-	long off;
-	struct dirent *dirp;
-	struct dirent32 *dirp32;
-
-	off = 0;
-	while (off < n) {
-		dirp = (struct dirent *)(dirent64 + off);
-		dirp32 = (struct dirent32 *)(dirent32 + off);
-		off += dirp->d_reclen;
-		dirp32->d_ino = dirp->d_ino;
-		dirp32->d_off = (unsigned int)dirp->d_off;
-		dirp32->d_reclen = dirp->d_reclen;
-		strncpy(dirp32->d_name, dirp->d_name, dirp->d_reclen - ((3 * 4) + 2));
-	}
-	return;
-}
-
-asmlinkage long
-sys32_getdents(unsigned int fd, void * dirent32, unsigned int count)
-{
-	long n;
-	void *dirent64;
-
-	dirent64 = (void *)((unsigned long)(dirent32 + (sizeof(long) - 1)) & ~(sizeof(long) - 1));
-	if ((n = sys_getdents(fd, dirent64, count - (dirent64 - dirent32))) < 0)
-		return(n);
-	xlate_dirent(dirent64, dirent32, n);
-	return(n);
-}
-
-asmlinkage int old_readdir(unsigned int fd, void * dirent, unsigned int count);
-
-asmlinkage int
-sys32_readdir(unsigned int fd, void * dirent32, unsigned int count)
-{
-	int n;
-	struct dirent dirent64;
-
-	if ((n = old_readdir(fd, &dirent64, count)) < 0)
-		return(n);
-	xlate_dirent(&dirent64, dirent32, dirent64.d_reclen);
-	return(n);
-}
-
 asmlinkage int
 sys32_waitpid(compat_pid_t pid, unsigned int *stat_addr, int options)
 {
diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index d87b544..02c8267 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -195,7 +195,7 @@ EXPORT(sysn32_call_table)
 	PTR	sys_fdatasync
 	PTR	sys_truncate
 	PTR	sys_ftruncate			/* 6075 */
-	PTR	sys32_getdents
+	PTR	compat_sys_getdents
 	PTR	sys_getcwd
 	PTR	sys_chdir
 	PTR	sys_fchdir
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index 5b04140..797e0d8 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -293,7 +293,7 @@ sys_call_table:
 	PTR	sys_uselib
 	PTR	sys_swapon
 	PTR	sys_reboot
-	PTR	sys32_readdir
+	PTR	compat_sys_old_readdir
 	PTR	old_mmap			/* 4090 */
 	PTR	sys_munmap
 	PTR	sys_truncate
@@ -345,7 +345,7 @@ sys_call_table:
 	PTR	sys_setfsuid
 	PTR	sys_setfsgid
 	PTR	sys32_llseek			/* 4140 */
-	PTR	sys32_getdents
+	PTR	compat_sys_getdents
 	PTR	compat_sys_select
 	PTR	sys_flock
 	PTR	sys_msync
