Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Dec 2002 10:24:40 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:24963 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8225527AbSLTKYk>;
	Fri, 20 Dec 2002 10:24:40 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id 9D447D657; Fri, 20 Dec 2002 11:30:48 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: [PATCH]: fault.c use unblank_screen
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: 20 Dec 2002 11:30:48 +0100
Message-ID: <m24r99gexz.fsf@demo.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1022
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi
        if CONFIG_VT is defined, this file uses unblank screen.

Later, Juan.

Index: arch/mips64/mm/fault.c
===================================================================
RCS file: /home/cvs/linux/arch/mips64/mm/fault.c,v
retrieving revision 1.26.2.13
diff -u -r1.26.2.13 fault.c
--- arch/mips64/mm/fault.c	11 Sep 2002 12:44:29 -0000	1.26.2.13
+++ arch/mips64/mm/fault.c	20 Dec 2002 09:55:05 -0000
@@ -20,6 +20,7 @@
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <linux/version.h>
+#include <linux/vt_kern.h>
 
 #include <asm/branch.h>
 #include <asm/hardirq.h>


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
