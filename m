Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Nov 2004 17:18:31 +0000 (GMT)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:30221 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8224859AbUKJRSY>;
	Wed, 10 Nov 2004 17:18:24 +0000
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1CRwF3-0002lA-00; Wed, 10 Nov 2004 17:26:45 +0000
Received: from perivale.mips.com ([192.168.192.200])
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1CRw6c-0007E3-00; Wed, 10 Nov 2004 17:18:02 +0000
Received: from macro (helo=localhost)
	by perivale.mips.com with local-esmtp (Exim 3.36 #1 (Debian))
	id 1CRw6c-00036t-00; Wed, 10 Nov 2004 17:18:02 +0000
Date: Wed, 10 Nov 2004 17:18:02 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@mips.com>
To: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	libc-alpha@sources.redhat.com
cc: Nigel Stephens <nigel@mips.com>,
	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: [PATCH] MIPS/Linux: Kernel vs libc struct siginfo discrepancy
Message-ID: <Pine.LNX.4.61.0411101657420.11408@perivale.mips.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-4.803, required 4, AWL,
	BAYES_00)
Return-Path: <macro@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6296
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@mips.com
Precedence: bulk
X-list: linux-mips

Hello,

 Since the following change:

http://www.linux-mips.org/cvsweb/linux/include/asm-mips/siginfo.h.diff?r1=1.4&r2=1.5&only_with_tag=MAIN

dated back to Aug 1999 (!), the definitions of struct siginfo in Linux and 
GNU libc differ to each other.  While it's the kernel that is at fault by 
changing its ABI, at this stage it may be more acceptable to update glibc 
as it's not the only program interfacing to Linux (uClibc?).  It doesn't 
seem to be a heavily used feature as otherwise someone else would have 
noticed the problem during these five years.  As I don't really have a 
preference, hereby I provide two patches to choose from and ask for 
voting.  The ChangeLog entry is for glibc, of course.

2004-11-10  Maciej W. Rozycki  <macro@linux-mips.org>

	* sysdeps/unix/sysv/linux/mips/bits/siginfo.h [struct siginfo] 
	(_sigchld): Update to match the kernel.

  Maciej

glibc-2.3.3-20041018-mips-siginfo_sigchld-1.patch
diff -up --recursive --new-file glibc-2.3.3-20041018.macro/sysdeps/unix/sysv/linux/bits/siginfo.h glibc-2.3.3-20041018/sysdeps/unix/sysv/linux/bits/siginfo.h
--- glibc-2.3.3-20041018.macro/sysdeps/unix/sysv/linux/bits/siginfo.h	Tue Apr 22 02:26:04 2003
+++ glibc-2.3.3-20041018/sysdeps/unix/sysv/linux/bits/siginfo.h	Wed Nov 10 16:52:24 2004
@@ -1,5 +1,5 @@
 /* siginfo_t, sigevent and constants.  Linux version.
-   Copyright (C) 1997-2002, 2003 Free Software Foundation, Inc.
+   Copyright (C) 1997-2002, 2003, 2004 Free Software Foundation, Inc.
    This file is part of the GNU C Library.
 
    The GNU C Library is free software; you can redistribute it and/or
@@ -87,8 +87,8 @@ typedef struct siginfo
 	  {
 	    __pid_t si_pid;	/* Which child.  */
 	    __uid_t si_uid;	/* Real user ID of sending process.  */
-	    int si_status;	/* Exit value or signal.  */
 	    __clock_t si_utime;
+	    int si_status;	/* Exit value or signal.  */
 	    __clock_t si_stime;
 	  } _sigchld;
 

patch-malta-2.6.9-rc1-20041020-mips-siginfo_sigchld-0
diff -up --recursive --new-file linux-malta-2.6.9-rc1-20041020.macro/include/asm-mips/siginfo.h linux-malta-2.6.9-rc1-20041020/include/asm-mips/siginfo.h
--- linux-malta-2.6.9-rc1-20041020.macro/include/asm-mips/siginfo.h	2004-10-01 14:49:33.000000000 +0000
+++ linux-malta-2.6.9-rc1-20041020/include/asm-mips/siginfo.h	2004-11-10 16:53:42.000000000 +0000
@@ -47,8 +47,8 @@ typedef struct siginfo {
 		struct {
 			pid_t _pid;		/* which child */
 			uid_t _uid;		/* sender's uid */
-			clock_t _utime;
 			int _status;		/* exit code */
+			clock_t _utime;
 			clock_t _stime;
 		} _sigchld;
 
