Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Dec 2002 10:57:07 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:21228 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8225409AbSLSK5G>;
	Thu, 19 Dec 2002 10:57:06 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id F2213D657; Thu, 19 Dec 2002 12:03:09 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: [PATCH]: global variables are automatically initialized to 0
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: 19 Dec 2002 12:03:09 +0100
Message-ID: <m2k7i6l18y.fsf@demo.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 984
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi
        globals are already initialized to 0.

Later, Juan.

Index: drivers/sgi/char/sgicons.c
===================================================================
RCS file: /home/cvs/linux/drivers/sgi/char/sgicons.c,v
retrieving revision 1.13.2.1
diff -u -r1.13.2.1 sgicons.c
--- drivers/sgi/char/sgicons.c	6 Aug 2002 01:51:52 -0000	1.13.2.1
+++ drivers/sgi/char/sgicons.c	19 Dec 2002 10:38:05 -0000
@@ -14,8 +14,8 @@
 #include "gconsole.h"
 
 /* This is the system graphics console (the first adapter found) */
-struct console_ops *gconsole = 0;
-struct console_ops *real_gconsole = 0;
+struct console_ops *gconsole;
+struct console_ops *real_gconsole;
 
 void
 enable_gconsole (void)


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
