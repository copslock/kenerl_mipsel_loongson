Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Aug 2003 15:59:00 +0100 (BST)
Received: from p508B6685.dip.t-dialin.net ([IPv6:::ffff:80.139.102.133]:3260
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225354AbTHaO65>; Sun, 31 Aug 2003 15:58:57 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h7VEwu1p009996;
	Sun, 31 Aug 2003 16:58:56 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h7VEwt1N009995;
	Sun, 31 Aug 2003 16:58:55 +0200
Date: Sun, 31 Aug 2003 16:58:54 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Ulrich Drepper <drepper@redhat.com>,
	Glibc hackers <libc-hacker@sources.redhat.com>,
	linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: [PATCH] Fix sigevent_t stuff
Message-ID: <20030831145854.GB23189@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3114
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Uli,

below patch fixes a mismatch between glibc and the kernel header's
definition on MIPS.  Please apply.

Thanks,

  Ralf

2003-08-31  Ralf Baechle  <ralf@linux-mips.org>

	* sysdeps/unix/sysv/linux/mips/bits/siginfo.h: Delete comment
	obsoleted by this patch.
	(__SIGEV_PAD_SIZE: Change the definition such that it'll keep the size
	of sigevent_t at SIGEV_MAX_SIZE bytes for 64-bit also.
	(SIGEV_MAX_SIZE): Remove unused definition making this match the
	kernel definition.

Index: sysdeps/unix/sysv/linux/mips/bits/siginfo.h
===================================================================
RCS file: /cvs/glibc/libc/sysdeps/unix/sysv/linux/mips/bits/siginfo.h,v
retrieving revision 1.10
diff -u -r1.10 siginfo.h
--- sysdeps/unix/sysv/linux/mips/bits/siginfo.h	22 May 2003 02:26:29 -0000	1.10
+++ sysdeps/unix/sysv/linux/mips/bits/siginfo.h	31 Aug 2003 14:31:00 -0000
@@ -255,12 +255,13 @@
 
 /* Structure to transport application-defined values with signals.  */
 # define __SIGEV_MAX_SIZE	64
-# define __SIGEV_PAD_SIZE	((__SIGEV_MAX_SIZE / sizeof (int)) - 3)
+# define __SIGEV_HEAD_SIZE	(sizeof(long) + 2*sizeof(int))
+# define __SIGEV_PAD_SIZE	\
+	((__SIGEV_MAX_SIZE-__SIGEV_HEAD_SIZE) / sizeof(int))
 
 /* Forward declaration of the `pthread_attr_t' type.  */
 struct __pthread_attr_s;
 
-/* XXX This one might need to change!!!  */
 typedef struct sigevent
   {
     sigval_t sigev_value;
@@ -290,8 +291,6 @@
 # define SIGEV_SIGNAL	SIGEV_SIGNAL
   SIGEV_NONE,			/* Other notification: meaningless.  */
 # define SIGEV_NONE	SIGEV_NONE
-  SIGEV_CALLBACK,		/* Deliver via thread creation.  */
-# define SIGEV_CALLBACK	SIGEV_CALLBACK
   SIGEV_THREAD			/* Deliver via thread creation.  */
 # define SIGEV_THREAD	SIGEV_THREAD
 };
