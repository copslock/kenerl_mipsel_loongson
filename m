Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8PInjw32128
	for linux-mips-outgoing; Tue, 25 Sep 2001 11:49:45 -0700
Received: from firewall.i-data.com (firewall.i-data.com [195.24.22.194])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8PInWD32122
	for <linux-mips@oss.sgi.com>; Tue, 25 Sep 2001 11:49:33 -0700
From: tommy.christensen@eicon.com
Received: (qmail 5744 invoked from network); 25 Sep 2001 18:49:31 -0000
Received: from idahub2000.i-data.com (HELO idanshub.i-data.com) (172.16.1.8)
  by firewall.i-data.com with SMTP; 25 Sep 2001 18:49:31 -0000
Received: from eicon.com ([172.17.159.1])          by idanshub.i-data.com (Lotus
 Domino Release 5.0.8)          with ESMTP id 2001092520515173:21091
 ;          Tue, 25 Sep 2001 20:51:51 +0200
Message-ID: <3BB0D217.80E313F5@eicon.com>
Date: Tue, 25 Sep 2001 20:51:03 +0200
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14 i686)
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: linux-mips@oss.sgi.com
Subject: Register allocation in copy_to_user
X-MIMETrack: Itemize by SMTP Server on idaHUB2000/INT(Release 5.0.8 |June 18, 2001) at
 25-09-2001 20:51:51,
	MIME-CD by Notes Server on idaHUB2000/INT(Release 5.0.8 |June 18, 2001) at
 25-09-2001 20:51:52,
	MIME-CD complete at 25-09-2001 20:51:52,
	Serialize by Router on idaHUB2000/INT(Release 5.0.8 |June 18, 2001) at 25-09-2001
 20:51:53
Content-type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


For some time, I have seen occasional corruption of tty-output (pty's and
serial). This turned out to be caused by a register collision in read_chan
()
in n_tty.c. In the expansion of copy_to_user, the compiler chose register
"a0" to hold the value of local variable __cu_from. Since this register is
modified in the asm statement, before __cu_from is used, the corruption
occured.

I am not sure, whether this is a compiler-bug (egcs-2.91.66) or the code
should prevent this from happening. Have the semantics about side-effects
of asm statements changed?

Anyway, the attached patch solves this by explicitly building the arguments
to __copy_user in the argument registers ;-) instead of moving them around.
So it actually saves some instructions as well. And the compiler can
generate
better code since it now has more registers for temporary variables ...

Is this OK? It works just fine for me with a 2.4.9 kernel (VR5000).

-Tommy
--- include/asm-mips/uaccess.h.orig      Mon Aug  6 10:35:52 2001
+++ include/asm-mips/uaccess.h     Tue Sep 25 18:51:00 2001
@@ -270,97 +270,81 @@
 extern size_t __copy_user(void *__to, const void *__from, size_t __n);

 #define __copy_to_user(to,from,n) ({ \
-    void *__cu_to; \
-    const void *__cu_from; \
-    long __cu_len; \
+    register void *__cu_to __asm__ ("$4"); \
+    register const void *__cu_from __asm__ ("$5"); \
+    register long __cu_len __asm__ ("$6"); \
     \
     __cu_to = (to); \
     __cu_from = (from); \
     __cu_len = (n); \
     __asm__ __volatile__( \
-         "move\t$4, %1\n\t" \
-         "move\t$5, %2\n\t" \
-         "move\t$6, %3\n\t" \
          __MODULE_JAL(__copy_user) \
-         "move\t%0, $6" \
-         : "=r" (__cu_len) \
-         : "r" (__cu_to), "r" (__cu_from), "r" (__cu_len) \
-         : "$4", "$5", "$6", "$8", "$9", "$10", "$11", "$12", "$15", \
+         : "+r" (__cu_to), "+r" (__cu_from), "+r" (__cu_len) \
+         : \
+         : "$8", "$9", "$10", "$11", "$12", "$15", \
            "$24", "$31","memory"); \
     __cu_len; \
 })

 #define __copy_from_user(to,from,n) ({ \
-    void *__cu_to; \
-    const void *__cu_from; \
-    long __cu_len; \
+    register void *__cu_to __asm__ ("$4"); \
+    register const void *__cu_from __asm__ ("$5"); \
+    register long __cu_len __asm__ ("$6"); \
     \
     __cu_to = (to); \
     __cu_from = (from); \
     __cu_len = (n); \
     __asm__ __volatile__( \
-         "move\t$4, %1\n\t" \
-         "move\t$5, %2\n\t" \
-         "move\t$6, %3\n\t" \
          ".set\tnoreorder\n\t" \
          __MODULE_JAL(__copy_user) \
          ".set\tnoat\n\t" \
-         "addu\t$1, %2, %3\n\t" \
+         "addu\t$1, %1, %2\n\t" \
          ".set\tat\n\t" \
          ".set\treorder\n\t" \
-         "move\t%0, $6" \
-         : "=r" (__cu_len) \
-         : "r" (__cu_to), "r" (__cu_from), "r" (__cu_len) \
-         : "$4", "$5", "$6", "$8", "$9", "$10", "$11", "$12", "$15", \
+         : "+r" (__cu_to), "+r" (__cu_from), "+r" (__cu_len) \
+         : \
+         : "$8", "$9", "$10", "$11", "$12", "$15", \
            "$24", "$31","memory"); \
     __cu_len; \
 })

 #define copy_to_user(to,from,n) ({ \
-    void *__cu_to; \
-    const void *__cu_from; \
-    long __cu_len; \
+    register void *__cu_to __asm__ ("$4"); \
+    register const void *__cu_from __asm__ ("$5"); \
+    register long __cu_len __asm__ ("$6"); \
     \
     __cu_to = (to); \
     __cu_from = (from); \
     __cu_len = (n); \
     if (access_ok(VERIFY_WRITE, __cu_to, __cu_len)) \
          __asm__ __volatile__( \
-              "move\t$4, %1\n\t" \
-              "move\t$5, %2\n\t" \
-              "move\t$6, %3\n\t" \
               __MODULE_JAL(__copy_user) \
-              "move\t%0, $6" \
-              : "=r" (__cu_len) \
-              : "r" (__cu_to), "r" (__cu_from), "r" (__cu_len) \
-              : "$4", "$5", "$6", "$8", "$9", "$10", "$11", "$12", \
+              : "+r" (__cu_to), "+r" (__cu_from), "+r" (__cu_len) \
+              : \
+              : "$8", "$9", "$10", "$11", "$12", \
                 "$15", "$24", "$31","memory"); \
     __cu_len; \
 })

 #define copy_from_user(to,from,n) ({ \
-    void *__cu_to; \
-    const void *__cu_from; \
-    long __cu_len; \
+    register void *__cu_to __asm__ ("$4"); \
+    register const void *__cu_from __asm__ ("$5"); \
+    register long __cu_len __asm__ ("$6"); \
     \
     __cu_to = (to); \
     __cu_from = (from); \
     __cu_len = (n); \
     if (access_ok(VERIFY_READ, __cu_from, __cu_len)) \
          __asm__ __volatile__( \
-              "move\t$4, %1\n\t" \
-              "move\t$5, %2\n\t" \
-              "move\t$6, %3\n\t" \
               ".set\tnoreorder\n\t" \
               __MODULE_JAL(__copy_user) \
               ".set\tnoat\n\t" \
-              "addu\t$1, %2, %3\n\t" \
+              "addu\t$1, %1, %2\n\t" \
               ".set\tat\n\t" \
               ".set\treorder\n\t" \
-              "move\t%0, $6" \
-              : "=r" (__cu_len) \
-              : "r" (__cu_to), "r" (__cu_from), "r" (__cu_len) \
-              : "$4", "$5", "$6", "$8", "$9", "$10", "$11", "$12", \
+              : "+r" (__cu_to), "+r" (__cu_from), "+r" (__cu_len) \
+              : \
+              : "$8", "$9", "$10", "$11", "$12", \
                 "$15", "$24", "$31","memory"); \
     __cu_len; \
 })
