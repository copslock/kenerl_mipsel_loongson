Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f766som27993
	for linux-mips-outgoing; Sun, 5 Aug 2001 23:54:50 -0700
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f766sZV27989;
	Sun, 5 Aug 2001 23:54:35 -0700
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for [216.32.174.27]) with SMTP; 6 Aug 2001 06:54:35 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (8.9.3/3.7W-MailExchenger) with ESMTP id PAA76785;
	Mon, 6 Aug 2001 15:54:33 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id PAA46103; Mon, 6 Aug 2001 15:54:33 +0900 (JST)
To: ralf@oss.sgi.com
Cc: linux-mips@oss.sgi.com
Subject: Re: shm ipc broken
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <20010430004457.A1227@bacchus.dhis.org>
References: <20010429210601.A16687@bilbo.physik.uni-konstanz.de>
	<20010430004457.A1227@bacchus.dhis.org>
X-Mailer: Mew version 1.94.2 on Emacs 20.7 / Mule 4.1 (AOI)
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
 boundary="--Next_Part(Mon_Aug__6_15:58:43_2001_179)--"
Content-Transfer-Encoding: 7bit
Message-Id: <20010806155901I.nemoto@toshiba-tops.co.jp>
Date: Mon, 06 Aug 2001 15:59:01 +0900
X-Dispatcher: imput version 20000228(IM140)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

----Next_Part(Mon_Aug__6_15:58:43_2001_179)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

>>>>> On Mon, 30 Apr 2001 00:44:57 -0300, Ralf Baechle <ralf@oss.sgi.com> said:
>> The attached patch fixes a problem with shm ipc. The structs
>> ipc_perm in /u/i/bits/ipc.h and ipc64_perm in include/asm/ipcbuf.h
>> had different sizes and so caused the copy_shminfo_to_user in
>> ipc/shm.c to corrupt user space(the kernel structure was 8 bytes
>> larger).
>> ...

ralf> Thanks for the report.  Now, the kernel interface is what it is
ralf> supposed to be so you patch was unacceptable.  Instead I've sent
ralf> below patch to to the libc maintainers for inclusion.  Also for
ralf> semaphores we also had a structure missmatch.

There is still a structure mismatch between msqid_ds (in libc's
bits/msq.h) and msqid64_ds (in kernel's asm-mips/msgbuf.h).

Here is a patch to fix kernel's header, but I can not tell which one
should be fixed.

---
Atsushi Nemoto

----Next_Part(Mon_Aug__6_15:58:43_2001_179)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="msgbuf.h.patch"

--- linux/include/asm-mips/msgbuf.h:1.1.1.1	Fri Jul  6 11:22:16 2001
+++ linux/include/asm-mips/msgbuf.h	Thu Jul 26 12:13:43 2001
@@ -2,7 +2,7 @@
 #define _ASM_MSGBUF_H
 
 /* 
- * The msqid64_ds structure for alpha architecture.
+ * The msqid64_ds structure for MIPS architecture.
  * Note extra padding because this structure is passed back and forth
  * between kernel and user space.
  *
@@ -13,15 +13,18 @@
 struct msqid64_ds {
 	struct ipc64_perm msg_perm;
 	__kernel_time_t msg_stime;	/* last msgsnd time */
+	unsigned long int __unused1;
 	__kernel_time_t msg_rtime;	/* last msgrcv time */
+	unsigned long int __unused2;
 	__kernel_time_t msg_ctime;	/* last change time */
+	unsigned long int __unused3;
 	unsigned long  msg_cbytes;	/* current number of bytes on queue */
 	unsigned long  msg_qnum;	/* number of messages in queue */
 	unsigned long  msg_qbytes;	/* max number of bytes on queue */
 	__kernel_pid_t msg_lspid;	/* pid of last msgsnd */
 	__kernel_pid_t msg_lrpid;	/* last receive pid */
-	unsigned long  __unused1;
-	unsigned long  __unused2;
+	unsigned long  __unused4;
+	unsigned long  __unused5;
 };
 
 #endif /* _ASM_MSGBUF_H */

----Next_Part(Mon_Aug__6_15:58:43_2001_179)----
