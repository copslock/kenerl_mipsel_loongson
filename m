Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2007 16:38:26 +0000 (GMT)
Received: from p549F72FE.dip.t-dialin.net ([84.159.114.254]:33981 "EHLO
	p549F72FE.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S20039673AbXAJQiW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 Jan 2007 16:38:22 +0000
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:13013 "EHLO
	topsns2.toshiba-tops.co.jp") by lappi.linux-mips.net with ESMTP
	id S1100422AbXAJJxh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 Jan 2007 10:53:37 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for p549F72FE.dip.t-dialin.net [84.159.114.254]) with ESMTP; Wed, 10 Jan 2007 18:53:37 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 4024541E1C;
	Wed, 10 Jan 2007 18:53:33 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 351AA203B8;
	Wed, 10 Jan 2007 18:53:33 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l0A9rXW0035795;
	Wed, 10 Jan 2007 18:53:33 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 10 Jan 2007 18:53:33 +0900 (JST)
Message-Id: <20070110.185333.51860171.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, kaz@zeugmasystems.com, drow@false.org
Subject: [PATCH] Fix N32 SysV IPC routines
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
X-archive-position: 13573
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Add wrappers for N32 msg{snd,rcv} while compat_sys_msg{snd,rcv} could
not be used as system call entries as is.  This fix is based on patch
originally made by Kaz Kylheku.

Also change a type of last argument of sysn32_semctl to match its true
size.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 linux32.c     |   16 ++++++++--
 scall64-n32.S |    4 +-
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/linux32.c b/arch/mips/kernel/linux32.c
index b061c9a..de3fae2 100644
--- a/arch/mips/kernel/linux32.c
+++ b/arch/mips/kernel/linux32.c
@@ -440,14 +440,26 @@ sys32_ipc (u32 call, int first, int seco
 }
 
 #ifdef CONFIG_MIPS32_N32
-asmlinkage long sysn32_semctl(int semid, int semnum, int cmd, union semun arg)
+asmlinkage long sysn32_semctl(int semid, int semnum, int cmd, u32 arg)
 {
 	/* compat_sys_semctl expects a pointer to union semun */
 	u32 __user *uptr = compat_alloc_user_space(sizeof(u32));
-	if (put_user(ptr_to_compat(arg.__pad), uptr))
+	if (put_user(arg, uptr))
 		return -EFAULT;
 	return compat_sys_semctl(semid, semnum, cmd, uptr);
 }
+
+asmlinkage long sysn32_msgsnd(int msqid, u32 msgp, unsigned msgsz, int msgflg)
+{
+	return compat_sys_msgsnd(msqid, msgsz, msgflg, compat_ptr(msgp));
+}
+
+asmlinkage long sysn32_msgrcv(int msqid, u32 msgp, size_t msgsz, int msgtyp,
+			      int msgflg)
+{
+	return compat_sys_msgrcv(msqid, msgsz, msgtyp, msgflg, IPC_64,
+				 compat_ptr(msgp));
+}
 #endif
 
 struct sysctl_args32
diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index 34567d8..a7bff2a 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -187,8 +187,8 @@ EXPORT(sysn32_call_table)
 	PTR	sysn32_semctl
 	PTR	sys_shmdt			/* 6065 */
 	PTR	sys_msgget
-	PTR	compat_sys_msgsnd
-	PTR	compat_sys_msgrcv
+	PTR	sysn32_msgsnd
+	PTR	sysn32_msgrcv
 	PTR	compat_sys_msgctl
 	PTR	compat_sys_fcntl		/* 6070 */
 	PTR	sys_flock
