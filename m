Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2002 01:39:34 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:54244 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8225325AbSLRBhc>;
	Wed, 18 Dec 2002 01:37:32 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id 8DF9DD657; Wed, 18 Dec 2002 02:43:28 +0100 (CET)
To: linux mips mailing list <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH]: make prototype of printk available
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: 18 Dec 2002 02:43:28 +0100
Message-ID: <m23cowqeyn.fsf@demo.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 939
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi
        this complained about printk being undefined.
        Once there, put a tag to the printk.

Later, Juan.

Index: arch/mips/math-emu/ieee754xcpt.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/math-emu/ieee754xcpt.c,v
retrieving revision 1.3.2.1
diff -u -r1.3.2.1 ieee754xcpt.c
--- arch/mips/math-emu/ieee754xcpt.c	5 Aug 2002 23:53:34 -0000	1.3.2.1
+++ arch/mips/math-emu/ieee754xcpt.c	18 Dec 2002 00:49:18 -0000
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
+	printk(KERN_INFO "floating point exception in \"%s\", type=%s\n",
 		xcp->op, rtnames[xcp->rt]);
 }
 


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
