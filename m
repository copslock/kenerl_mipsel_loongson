Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jan 2003 19:26:12 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:56001 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8225692AbTABT0L>;
	Thu, 2 Jan 2003 19:26:11 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id C6E35D657; Thu,  2 Jan 2003 20:33:30 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: [PATCH]: fix possible buffer overflow problem in promlib
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: 02 Jan 2003 20:33:30 +0100
Message-ID: <m2hecrbb3p.fsf@demo.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1078
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi
        as the issue about prom.h is still not clear, please aply the
        trivial part.

        32 and 64 bits patch.

Later, Juan.

Index: arch/mips64/lib/promlib.c
===================================================================
RCS file: /home/cvs/linux/arch/mips64/lib/promlib.c,v
retrieving revision 1.1.2.1
diff -u -r1.1.2.1 promlib.c
--- arch/mips64/lib/promlib.c	28 Sep 2002 22:28:38 -0000	1.1.2.1
+++ arch/mips64/lib/promlib.c	20 Dec 2002 19:10:45 -0000
@@ -1,13 +1,19 @@
+
+
+#include <linux/kernel.h>
+
 #include <stdarg.h>
 
+#define BUFSIZE 1024
+
 void prom_printf(char *fmt, ...)
 {
 	va_list args;
-	char ppbuf[1024];
+	char ppbuf[BUFSIZE];
 	char *bptr;
 
 	va_start(args, fmt);
-	vsprintf(ppbuf, fmt, args);
+	vsnprintf(ppbuf, BUFSIZE, fmt, args);
 
 	bptr = ppbuf;
 
Index: arch/mips/lib/promlib.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/lib/promlib.c,v
retrieving revision 1.1.2.1
diff -u -r1.1.2.1 promlib.c
--- arch/mips/lib/promlib.c	28 Sep 2002 22:28:38 -0000	1.1.2.1
+++ arch/mips/lib/promlib.c	20 Dec 2002 19:10:43 -0000
@@ -1,13 +1,19 @@
+
+
+#include <linux/kernel.h>
+
 #include <stdarg.h>
 
+#define BUFSIZE 1024
+
 void prom_printf(char *fmt, ...)
 {
 	va_list args;
-	char ppbuf[1024];
+	char ppbuf[BUFSIZE];
 	char *bptr;
 
 	va_start(args, fmt);
-	vsprintf(ppbuf, fmt, args);
+	vsnprintf(ppbuf, BUFSIZE, fmt, args);
 
 	bptr = ppbuf;
 


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
