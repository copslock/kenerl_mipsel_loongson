Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2003 14:32:37 +0000 (GMT)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:52698 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225394AbTJ1OcF>; Tue, 28 Oct 2003 14:32:05 +0000
Received: from localhost (p7054-ipad28funabasi.chiba.ocn.ne.jp [220.107.206.54])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP id 55E355524
	for <linux-mips@linux-mips.org>; Tue, 28 Oct 2003 23:32:02 +0900 (JST)
Date: Tue, 28 Oct 2003 23:49:49 +0900 (JST)
Message-Id: <20031028.234949.74756121.anemo@mba.ocn.ne.jp>
To: linux-mips@linux-mips.org
Subject: Re: SysV IPC in mips64
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20030826.210612.115929945.nemoto@toshiba-tops.co.jp>
References: <20030826.210612.115929945.nemoto@toshiba-tops.co.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3536
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Are there any comments about this problem?  glibc does not use this
old-style interfaces but uClibc does.

>>>>> On Tue, 26 Aug 2003 21:06:12 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> said:

anemo> Some SysV IPC using old-style (without IPC_64 flag) does not
anemo> work on mips64 kernel.

anemo> I think SysV IPC conversion routine should set/clear IPC_64
anemo> flag when calling native system-call routine if the conversion
anemo> routine pass their own data structures.

anemo> * should set IPC_64 for semid64_ds, msqid64_ds, shmid64_ds.
anemo> * should clear IPC_64 for shmid_ds.

Here is a patch against current 2.4 CVS.  Can be applied for 2.6 with
some offsets.

diff -u linux-mips-cvs/arch/mips64/kernel/linux32.c linux.new/arch/mips64/kernel/linux32.c
--- linux-mips-cvs/arch/mips64/kernel/linux32.c	Fri Oct 24 00:01:35 2003
+++ linux.new/arch/mips64/kernel/linux32.c	Tue Oct 28 22:56:54 2003
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
@@ -2082,7 +2082,7 @@
 			break;
 		old_fs = get_fs ();
 		set_fs (KERNEL_DS);
-		err = sys_shmctl (first, second, &s);
+		err = sys_shmctl (first, second & ~IPC_64, &s);
 		set_fs (old_fs);
 		break;
 
@@ -2090,7 +2090,7 @@
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
