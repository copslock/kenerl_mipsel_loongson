Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5HIIWnC028003
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 17 Jun 2002 11:18:32 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5HIIWmj028002
	for linux-mips-outgoing; Mon, 17 Jun 2002 11:18:32 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from localhost.localdomain (ip68-6-25-170.hu.sd.cox.net [68.6.25.170])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5HIINnC027998;
	Mon, 17 Jun 2002 11:18:23 -0700
Received: (from justin@localhost)
	by localhost.localdomain (8.11.6/8.11.6) id g5HIKh802005;
	Mon, 17 Jun 2002 11:20:43 -0700
X-Authentication-Warning: localhost.localdomain: justin set sender to justin@cs.cmu.edu using -f
Subject: system.h asm fixes
From: Justin Carlson <justin@cs.cmu.edu>
To: linux-mips@oss.sgi.com
Cc: ralf@oss.sgi.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 17 Jun 2002 11:20:42 -0700
Message-Id: <1024338042.1463.21.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Looks to me like we're missing some proper asm clobber markers:

diff -u -r1.13 system.h
--- system.h	4 Feb 2002 17:35:51 -0000	1.13
+++ system.h	17 Jun 2002 18:18:56 -0000
@@ -41,7 +41,8 @@
 		"__sti"
 		: /* no outputs */
 		: /* no inputs */
-		: "memory");
+		: "$1","memory"
+		);
 }
 
 /*
@@ -73,7 +74,7 @@
 		"__cli"
 		: /* no outputs */
 		: /* no inputs */
-		: "memory");
+		: "$1","memory");
 }
 
 __asm__ (
@@ -110,7 +111,7 @@
 	"__save_and_cli\t%0"						\
 	: "=r" (x)							\
 	: /* no inputs */						\
-	: "memory")
+	: "$1","memory")
 
 __asm__(".macro\t__restore_flags flags\n\t"
 	".set\tpush\n\t"
@@ -136,7 +137,7 @@
 		"__restore_flags\t%0"					\
 		: "=r" (__tmp1)						\
 		: "0" (flags)						\
-		: "memory");						\
+		: "$1","memory");					\
 } while(0)
 
 #ifdef CONFIG_SMP
