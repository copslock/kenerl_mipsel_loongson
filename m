Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Aug 2003 13:05:25 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:60451
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225200AbTHZMEw>; Tue, 26 Aug 2003 13:04:52 +0100
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for [62.254.210.162]) with SMTP; 26 Aug 2003 12:04:51 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.9/8.12.9) with ESMTP id h7QC4Lgc015816
	for <linux-mips@linux-mips.org>; Tue, 26 Aug 2003 21:04:22 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Tue, 26 Aug 2003 21:06:12 +0900 (JST)
Message-Id: <20030826.210612.115929945.nemoto@toshiba-tops.co.jp>
To: linux-mips@linux-mips.org
Subject: SysV IPC in mips64
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3094
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Some SysV IPC using old-style (without IPC_64 flag) does not work on
mips64 kernel.

I think SysV IPC conversion routine should set/clear IPC_64 flag when
calling native system-call routine if the conversion routine pass
their own data structures.

* should set IPC_64 for semid64_ds, msqid64_ds, shmid64_ds.
* should clear IPC_64 for shmid_ds.

Here is a patch against 2.4 tree.  This can be applied for 2.6 also.

diff -u linux-mips-cvs/arch/mips64/kernel/linux32.c linux/arch/mips64/kernel/linux32.c
--- linux-mips-cvs/arch/mips64/kernel/linux32.c	Tue Aug 26 20:49:10 2003
+++ linux/arch/mips64/kernel/linux32.c	Tue Aug 26 20:49:43 2003
@@ -1802,7 +1802,7 @@
 		fourth.__pad = &s;
 		old_fs = get_fs ();
 		set_fs (KERNEL_DS);
-		err = sys_semctl (first, second, third, fourth);
+		err = sys_semctl (first, second, third | IPC_64, fourth);
 		set_fs (old_fs);
 
 		if (third & IPC_64) {
@@ -1967,7 +1967,7 @@
 			break;
 		old_fs = get_fs ();
 		set_fs (KERNEL_DS);
-		err = sys_msgctl (first, second, (struct msqid_ds *)&m);
+		err = sys_msgctl (first, second | IPC_64, (struct msqid_ds *)&m);
 		set_fs (old_fs);
 		break;
 
@@ -1975,7 +1975,7 @@
 	case MSG_STAT:
 		old_fs = get_fs ();
 		set_fs (KERNEL_DS);
-		err = sys_msgctl (first, second, (struct msqid_ds *)&m);
+		err = sys_msgctl (first, second | IPC_64, (struct msqid_ds *)&m);
 		set_fs (old_fs);
 		if (second & IPC_64) {
 			if (!access_ok(VERIFY_WRITE, up64, sizeof(*up64))) {
@@ -2084,7 +2084,7 @@
 			break;
 		old_fs = get_fs ();
 		set_fs (KERNEL_DS);
-		err = sys_shmctl (first, second, &s);
+		err = sys_shmctl (first, second & ~IPC_64, &s);
 		set_fs (old_fs);
 		break;
 
@@ -2092,7 +2092,7 @@
 	case SHM_STAT:
 		old_fs = get_fs ();
 		set_fs (KERNEL_DS);
-		err = sys_shmctl (first, second, (void *) &s64);
+		err = sys_shmctl (first, second | IPC_64, (void *) &s64);
 		set_fs (old_fs);
 		if (err < 0)
 			break;
---
Atsushi Nemoto
