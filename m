Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Apr 2005 15:42:43 +0100 (BST)
Received: from mail.timesys.com ([IPv6:::ffff:65.117.135.102]:13253 "EHLO
	exchange.timesys.com") by linux-mips.org with ESMTP
	id <S8226066AbVDSOm1>; Tue, 19 Apr 2005 15:42:27 +0100
Received: from [192.168.2.27] ([192.168.2.27]) by exchange.timesys.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Tue, 19 Apr 2005 10:37:42 -0400
Message-ID: <426518D0.5080506@timesys.com>
Date:	Tue, 19 Apr 2005 10:42:24 -0400
From:	Greg Weeks <greg.weeks@timesys.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: sysv ipc msg functions
Content-Type: multipart/mixed;
 boundary="------------080106050706080303090605"
X-OriginalArrivalTime: 19 Apr 2005 14:37:42.0031 (UTC) FILETIME=[57C3B9F0:01C544ED]
Return-Path: <greg.weeks@timesys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7760
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg.weeks@timesys.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------080106050706080303090605
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I needed this glibc patch to get the sysv ipc msgctl functions to work 
correctly. This looks a bit hackish to me, so I wanted to run it past 
everybody here before filing it with glibc.

Greg Weeks

--------------080106050706080303090605
Content-Type: text/x-patch;
 name="glibc-2.3.3-timesys-mips-msq.h.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="glibc-2.3.3-timesys-mips-msq.h.patch"

--- glibc-2.3.3-200407050320/sysdeps/unix/sysv/linux/mips/bits/msq.h.orig	2005-04-19 09:04:15.000000000 -0400
+++ glibc-2.3.3-200407050320/sysdeps/unix/sysv/linux/mips/bits/msq.h	2005-04-19 09:22:21.000000000 -0400
@@ -38,9 +38,27 @@ typedef unsigned long int msglen_t;
 struct msqid_ds
 {
   struct ipc_perm msg_perm;	/* structure describing operation permission */
+#if __WORDSIZE == 32 && defined(__MIPSEB__)
+   unsigned long	__unused3;
+#endif
   __time_t msg_stime;		/* time of last msgsnd command */
+#if __WORDSIZE == 32 && defined(__MIPSEL__)
+   unsigned long	__unused3;
+#endif
+#if __WORDSIZE == 32 && defined(__MIPSEB__)
+  unsigned long	__unused4;
+#endif
   __time_t msg_rtime;		/* time of last msgrcv command */
+#if __WORDSIZE == 32 && defined(__MIPSEL__)
+  unsigned long	__unused4;
+#endif
+#if __WORDSIZE == 32 && defined(__MIPSEB__)
+  unsigned long	__unused5;
+#endif
   __time_t msg_ctime;		/* time of last change */
+#if __WORDSIZE == 32 && defined(__MIPSEL__)
+  unsigned long	__unused5;
+#endif
   unsigned long int __msg_cbytes; /* current number of bytes on queue */
   msgqnum_t msg_qnum;		/* number of messages currently on queue */
   msglen_t msg_qbytes;		/* max number of bytes allowed on queue */

--------------080106050706080303090605--
