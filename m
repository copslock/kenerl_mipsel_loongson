Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Dec 2002 10:57:27 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:21740 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8225411AbSLSK5U>;
	Thu, 19 Dec 2002 10:57:20 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id E5F1DD657; Thu, 19 Dec 2002 12:03:23 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: [PATCH]: do right includes in math-emu
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: 19 Dec 2002 12:03:23 +0100
Message-ID: <m2hedal18k.fsf@demo.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 985
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi
        another trivial patch, include kernel.h for printk, and put a
        printk label.

Later, Juan.

Index: arch/mips/math-emu/ieee754xcpt.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/math-emu/ieee754xcpt.c,v
retrieving revision 1.3.2.1
diff -u -r1.3.2.1 ieee754xcpt.c
--- arch/mips/math-emu/ieee754xcpt.c	5 Aug 2002 23:53:34 -0000	1.3.2.1
+++ arch/mips/math-emu/ieee754xcpt.c	19 Dec 2002 10:38:02 -0000
@@ -29,6 +29,7 @@
  *  Copyright (C) 2000 MIPS Technologies, Inc.  All rights reserved.
  *************************************************************************/
 
+#include <linux/kernel.h>
 #include "ieee754.h"
 
 /*
@@ -42,7 +43,7 @@
 
 void ieee754_xcpt(struct ieee754xctx *xcp)
 {
-	printk("floating point exception in \"%s\", type=%s\n",
+	printk(KERN_DEBUG "floating point exception in \"%s\", type=%s\n",
 		xcp->op, rtnames[xcp->rt]);
 }
 


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
