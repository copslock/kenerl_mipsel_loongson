Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6JExxRw000301
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 19 Jul 2002 07:59:59 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6JExx54000300
	for linux-mips-outgoing; Fri, 19 Jul 2002 07:59:59 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from rwcrmhc51.attbi.com (rwcrmhc51.attbi.com [204.127.198.38])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6JExgRw032758
	for <linux-mips@oss.sgi.com>; Fri, 19 Jul 2002 07:59:42 -0700
Received: from ocean.lucon.org ([12.234.143.38]) by rwcrmhc51.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20020719150016.JDXX24728.rwcrmhc51.attbi.com@ocean.lucon.org>;
          Fri, 19 Jul 2002 15:00:16 +0000
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 1BB90125D8; Fri, 19 Jul 2002 08:00:15 -0700 (PDT)
Date: Fri, 19 Jul 2002 08:00:14 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: Johannes Stezenbach <js@convergence.de>
Cc: linux-mips@oss.sgi.com, GNU C Library <libc-alpha@sources.redhat.com>
Subject: Re: LTP testing: msgctl/IPC_STAT
Message-ID: <20020719080014.A20377@lucon.org>
References: <20020719143034.GA5956@convergence.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020719143034.GA5956@convergence.de>; from js@convergence.de on Fri, Jul 19, 2002 at 04:30:34PM +0200
X-Spam-Status: No, hits=-9.4 required=5.0 tests=IN_REP_TO,UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 19, 2002 at 04:30:34PM +0200, Johannes Stezenbach wrote:
> I was investigating LTP test suite failures of the msgctl01,
> msgctl02, msgsnd01 and msgsnd02 tests. It seems that they
> are caused by a mismatch between /usr/include/bits/msq.h
> and linux/include/asm-mips/msgbuf.h.
> 
> I suggest the following patch which makes mips' msgbuf.h
> a copy of the one in include/asm-i386.
> 

I prefer we fix glibc. Here is a patch.


H.J.

--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="glibc-mips-msg.patch"

2002-07-19  H.J. Lu  <hjl@gnu.org>

	* sysdeps/unix/sysv/linux/mips/bits/msq.h: New.

--- sysdeps/unix/sysv/linux/mips/bits/msq.h.mips	Fri Jul 19 07:57:55 2002
+++ sysdeps/unix/sysv/linux/mips/bits/msq.h	Fri Jul 19 07:57:15 2002
@@ -0,0 +1,74 @@
+/* Copyright (C) 2002 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, write to the Free
+   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+   02111-1307 USA.  */
+
+#ifndef _SYS_MSG_H
+# error "Never use <bits/msq.h> directly; include <sys/msg.h> instead."
+#endif
+
+#include <bits/types.h>
+
+/* Define options for message queue functions.  */
+#define MSG_NOERROR	010000	/* no error if message is too big */
+#ifdef __USE_GNU
+# define MSG_EXCEPT	020000	/* recv any msg except of specified type */
+#endif
+
+/* Types used in the structure definition.  */
+typedef unsigned long int msgqnum_t;
+typedef unsigned long int msglen_t;
+
+
+/* Structure of record for one message inside the kernel.
+   The type `struct msg' is opaque.  */
+struct msqid_ds
+{
+  struct ipc_perm msg_perm;	/* structure describing operation permission */
+  __time_t msg_stime;		/* time of last msgsnd command */
+  __time_t msg_rtime;		/* time of last msgrcv command */
+  __time_t msg_ctime;		/* time of last change */
+  unsigned long int __msg_cbytes; /* current number of bytes on queue */
+  msgqnum_t msg_qnum;		/* number of messages currently on queue */
+  msglen_t msg_qbytes;		/* max number of bytes allowed on queue */
+  __pid_t msg_lspid;		/* pid of last msgsnd() */
+  __pid_t msg_lrpid;		/* pid of last msgrcv() */
+  unsigned long int __unused1;
+  unsigned long int __unused2;
+};
+
+#ifdef __USE_MISC
+
+# define msg_cbytes	__msg_cbytes
+
+/* ipcs ctl commands */
+# define MSG_STAT 11
+# define MSG_INFO 12
+
+/* buffer for msgctl calls IPC_INFO, MSG_INFO */
+struct msginfo
+  {
+    int msgpool;
+    int msgmap;
+    int msgmax;
+    int msgmnb;
+    int msgmni;
+    int msgssz;
+    int msgtql;
+    unsigned short int msgseg;
+  };
+
+#endif /* __USE_MISC */

--/04w6evG8XlLl3ft--
