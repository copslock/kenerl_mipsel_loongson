Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5P9uDnC019740
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 25 Jun 2002 02:56:13 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5P9uDaV019739
	for linux-mips-outgoing; Tue, 25 Jun 2002 02:56:13 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5P9twnC019736;
	Tue, 25 Jun 2002 02:55:59 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id CAA16402;
	Tue, 25 Jun 2002 02:59:13 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id CAA11541;
	Tue, 25 Jun 2002 02:59:14 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g5P9xEb23912;
	Tue, 25 Jun 2002 11:59:14 +0200 (MEST)
Message-ID: <3D183EF2.FB26BA59@mips.com>
Date: Tue, 25 Jun 2002 11:59:14 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>,
   "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: LTP testing
Content-Type: multipart/mixed;
 boundary="------------A57255ACE7E444374521FB17"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------A57255ACE7E444374521FB17
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

The LTP test fails with:
msgctl01    1  FAIL  :  qs_buf.msg_qbytes did not change
msgctl02    1  FAIL  :  qs_buf.msg_qbytes value is not expected
msgsnd01    1  FAIL  :  queue bytes != MSGSIZE
msgsnd01    2  FAIL  :  queue message != 1

All the above failures is fixed by the attached patch.
The msgbuf.h file is now a copy from i386, instead of alpha.
I guess the fix goes for 64-bit kernel as well.

/Carsten



--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com



--------------A57255ACE7E444374521FB17
Content-Type: text/plain; charset=iso-8859-15;
 name="msgbuf.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="msgbuf.patch"

Index: include/asm-mips/msgbuf.h
===================================================================
RCS file: /home/repository/sw/linux-2.4.18/include/asm-mips/msgbuf.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 msgbuf.h
--- include/asm-mips/msgbuf.h	4 Mar 2002 11:13:24 -0000	1.1.1.1
+++ include/asm-mips/msgbuf.h	25 Jun 2002 09:30:03 -0000
@@ -2,26 +2,30 @@
 #define _ASM_MSGBUF_H
 
 /* 
- * The msqid64_ds structure for alpha architecture.
+ * The msqid64_ds structure for i386 architecture.
  * Note extra padding because this structure is passed back and forth
  * between kernel and user space.
  *
  * Pad space is left for:
- * - 2 miscellaneous 64-bit values
+ * - 64-bit time_t to solve y2038 problem
+ * - 2 miscellaneous 32-bit values
  */
 
 struct msqid64_ds {
 	struct ipc64_perm msg_perm;
 	__kernel_time_t msg_stime;	/* last msgsnd time */
+	unsigned long	__unused1;
 	__kernel_time_t msg_rtime;	/* last msgrcv time */
+	unsigned long	__unused2;
 	__kernel_time_t msg_ctime;	/* last change time */
+	unsigned long	__unused3;
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

--------------A57255ACE7E444374521FB17--
