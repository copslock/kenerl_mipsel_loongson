Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6JEUIRw032522
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 19 Jul 2002 07:30:18 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6JEUIbN032521
	for linux-mips-outgoing; Fri, 19 Jul 2002 07:30:18 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from hell (buserror-extern.convergence.de [212.84.236.66])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6JEU0Rw032505
	for <linux-mips@oss.sgi.com>; Fri, 19 Jul 2002 07:30:01 -0700
Received: from js by hell with local (Exim 3.35 #1 (Debian))
	id 17VYmA-0001YM-00
	for <linux-mips@oss.sgi.com>; Fri, 19 Jul 2002 16:30:34 +0200
Date: Fri, 19 Jul 2002 16:30:34 +0200
From: Johannes Stezenbach <js@convergence.de>
To: linux-mips@oss.sgi.com
Subject: LTP testing: msgctl/IPC_STAT
Message-ID: <20020719143034.GA5956@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	linux-mips@oss.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Spam-Status: No, hits=-5.0 required=5.0 tests=UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I was investigating LTP test suite failures of the msgctl01,
msgctl02, msgsnd01 and msgsnd02 tests. It seems that they
are caused by a mismatch between /usr/include/bits/msq.h
and linux/include/asm-mips/msgbuf.h.

I suggest the following patch which makes mips' msgbuf.h
a copy of the one in include/asm-i386.

Johannes


Index: linux/include/asm-mips/msgbuf.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/msgbuf.h,v
retrieving revision 1.1
diff -u -r1.1 msgbuf.h
--- linux/include/asm-mips/msgbuf.h	2000/02/16 01:07:48	1.1
+++ linux/include/asm-mips/msgbuf.h	2002/07/19 14:20:29
@@ -2,26 +2,30 @@
 #define _ASM_MSGBUF_H
 
 /* 
- * The msqid64_ds structure for alpha architecture.
+ * The msqid64_ds structure for mips architecture.
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
