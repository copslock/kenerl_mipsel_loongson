Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Dec 2003 17:57:42 +0000 (GMT)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:62373 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8226032AbTLWR5l>;
	Tue, 23 Dec 2003 17:57:41 +0000
Received: from drow by nevyn.them.org with local (Exim 4.30 #1 (Debian))
	id 1AYqmi-0006mZ-Ln; Tue, 23 Dec 2003 12:57:32 -0500
Date: Tue, 23 Dec 2003 12:57:32 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Subject: 2.5 n32 syscall numbers are wrong
Message-ID: <20031223175732.GA26052@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.1i
Return-Path: <drow@crack.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3831
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

If you take a look at scall64-n32.S, you'll find that there's no hole after
sendfile64.  But in <asm/unistd.h> there is.  So glibc gets built with the
wrong number for clock_gettime and confusion ensues...

Index: unistd.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/unistd.h,v
retrieving revision 1.55
diff -u -p -r1.55 unistd.h
--- unistd.h	9 Oct 2003 15:43:22 -0000	1.55
+++ unistd.h	23 Dec 2003 17:56:25 -0000
@@ -769,17 +769,17 @@
 #define __NR_statfs64			(__NR_Linux + 217)
 #define __NR_fstatfs64			(__NR_Linux + 218)
 #define __NR_sendfile64			(__NR_Linux + 219)
-#define __NR_timer_create		(__NR_Linux + 221)
-#define __NR_timer_settime		(__NR_Linux + 222)
-#define __NR_timer_gettime		(__NR_Linux + 223)
-#define __NR_timer_getoverrun		(__NR_Linux + 224)
-#define __NR_timer_delete		(__NR_Linux + 225)
-#define __NR_clock_settime		(__NR_Linux + 226)
-#define __NR_clock_gettime		(__NR_Linux + 227)
-#define __NR_clock_getres		(__NR_Linux + 228)
-#define __NR_clock_nanosleep		(__NR_Linux + 229)
-#define __NR_tgkill			(__NR_Linux + 230)
-#define __NR_utimes			(__NR_Linux + 231)
+#define __NR_timer_create		(__NR_Linux + 220)
+#define __NR_timer_settime		(__NR_Linux + 221)
+#define __NR_timer_gettime		(__NR_Linux + 222)
+#define __NR_timer_getoverrun		(__NR_Linux + 223)
+#define __NR_timer_delete		(__NR_Linux + 224)
+#define __NR_clock_settime		(__NR_Linux + 225)
+#define __NR_clock_gettime		(__NR_Linux + 226)
+#define __NR_clock_getres		(__NR_Linux + 227)
+#define __NR_clock_nanosleep		(__NR_Linux + 228)
+#define __NR_tgkill			(__NR_Linux + 229)
+#define __NR_utimes			(__NR_Linux + 230)
 
 /*
  * Offset of the last N32 flavoured syscall

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
