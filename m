Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Oct 2004 13:48:23 +0100 (BST)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:65035 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225235AbUJOMsR>;
	Fri, 15 Oct 2004 13:48:17 +0100
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1CIReD-0000O6-00; Fri, 15 Oct 2004 13:57:29 +0100
Received: from perivale.mips.com ([192.168.192.200])
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1CIRV2-0000In-00; Fri, 15 Oct 2004 13:48:00 +0100
Received: from macro (helo=localhost)
	by perivale.mips.com with local-esmtp (Exim 3.36 #1 (Debian))
	id 1CIRV1-0002P6-00; Fri, 15 Oct 2004 13:47:59 +0100
Date: Fri, 15 Oct 2004 13:47:59 +0100 (BST)
From: "Maciej W. Rozycki" <macro@mips.com>
To: linux-mips@linux-mips.org
cc: libc-alpha@sources.redhat.com, Dominic Sweetman <dom@mips.com>,
	Nigel Stephens <nigel@mips.com>,
	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: [patch] glibc 2.3: Memory clobber missing from syscalls
Message-ID: <Pine.LNX.4.61.0410151318550.8084@perivale.mips.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-4.889, required 4, AWL,
	BAYES_00)
Return-Path: <macro@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6059
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@mips.com
Precedence: bulk
X-list: linux-mips

Hi,

 It seems nobody at the libc-alpha list is intersted in this fix, so I'm 
sending it here, so that people do not struggle against weird failures, 
while a fix is already done.  The fix is needed for the current version of 
glibc.

  Maciej

---------- Forwarded message ----------
Message-ID: <Pine.LNX.4.61.0410061929220.17693@perivale.mips.com>
Date: Wed, 6 Oct 2004 19:41:23 +0100 (BST)
From: Maciej W. Rozycki <macro@mips.com>
To: libc-alpha@sources.redhat.com
Cc: Dominic Sweetman <dom@mips.com>, Nigel Stephens <nigel@mips.com>,
    Maciej W. Rozycki <macro@linux-mips.org>
Subject: [patch] MIPS/Linux: Memory clobber missing from syscalls

Hello,

 There is a problem with all inline syscalls invoked by the library.  As 
"memory" is not included in the list of clobbers, more aggressive versions 
of GCC, such as 3.4, may incorrectly optimize code away based on the 
assumption inline syscalls do not modify memory.  This indeed happens -- 
due to this problem the login/tst-utmp and login/tst-utmpx testcases fail.

 Here is an obvious fix that works for me.  Tested with the mips-linux and 
mipsel-linux configurations.

2004-10-06  Maciej W. Rozycki  <macro@mips.com>

	* sysdeps/unix/sysv/linux/mips/mips32/sysdep.h
	(__SYSCALL_CLOBBERS): Add "memory".
	* sysdeps/unix/sysv/linux/mips/mips64/n32/sysdep.h 
	(__SYSCALL_CLOBBERS): Likewise.
	* sysdeps/unix/sysv/linux/mips/mips64/n64/sysdep.h 
	(__SYSCALL_CLOBBERS): Likewise.

 Please apply.

  Maciej

glibc-2.3.3-mips-syscall_clobbers-0.patch
diff -up --recursive --new-file glibc-2.3.3.macro/sysdeps/unix/sysv/linux/mips/mips32/sysdep.h glibc-2.3.3/sysdeps/unix/sysv/linux/mips/mips32/sysdep.h
--- glibc-2.3.3.macro/sysdeps/unix/sysv/linux/mips/mips32/sysdep.h	Sat Mar 29 08:15:29 2003
+++ glibc-2.3.3/sysdeps/unix/sysv/linux/mips/mips32/sysdep.h	Tue Oct  5 17:16:47 2004
@@ -275,7 +275,8 @@
 	_sys_result;							\
 })
 
-#define __SYSCALL_CLOBBERS "$1", "$3", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24", "$25"
+#define __SYSCALL_CLOBBERS "$1", "$3", "$8", "$9", "$10", "$11", "$12", \
+	"$13", "$14", "$15", "$24", "$25", "memory"
 
 #endif /* __ASSEMBLER__ */
 
diff -up --recursive --new-file glibc-2.3.3.macro/sysdeps/unix/sysv/linux/mips/mips64/n32/sysdep.h glibc-2.3.3/sysdeps/unix/sysv/linux/mips/mips64/n32/sysdep.h
--- glibc-2.3.3.macro/sysdeps/unix/sysv/linux/mips/mips64/n32/sysdep.h	Wed Oct  1 06:59:39 2003
+++ glibc-2.3.3/sysdeps/unix/sysv/linux/mips/mips64/n32/sysdep.h	Tue Oct  5 17:18:03 2004
@@ -235,7 +235,8 @@
 	_sys_result;							\
 })
 
-#define __SYSCALL_CLOBBERS "$1", "$3", "$10", "$11", "$12", "$13", "$14", "$15", "$24", "$25"
+#define __SYSCALL_CLOBBERS "$1", "$3", "$10", "$11", "$12", "$13",	\
+	"$14", "$15", "$24", "$25", "memory"
 #endif /* __ASSEMBLER__ */
 
 #endif /* linux/mips/sysdep.h */
diff -up --recursive --new-file glibc-2.3.3.macro/sysdeps/unix/sysv/linux/mips/mips64/n64/sysdep.h glibc-2.3.3/sysdeps/unix/sysv/linux/mips/mips64/n64/sysdep.h
--- glibc-2.3.3.macro/sysdeps/unix/sysv/linux/mips/mips64/n64/sysdep.h	Wed Oct  1 06:59:40 2003
+++ glibc-2.3.3/sysdeps/unix/sysv/linux/mips/mips64/n64/sysdep.h	Tue Oct  5 17:18:28 2004
@@ -235,7 +235,8 @@
 	_sys_result;							\
 })
 
-#define __SYSCALL_CLOBBERS "$1", "$3", "$10", "$11", "$12", "$13", "$14", "$15", "$24", "$25"
+#define __SYSCALL_CLOBBERS "$1", "$3", "$10", "$11", "$12", "$13",	\
+	"$14", "$15", "$24", "$25", "memory"
 #endif /* __ASSEMBLER__ */
 
 #endif /* linux/mips/sysdep.h */
