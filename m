Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Dec 2002 20:01:12 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:14976 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8225473AbSLSUBM>;
	Thu, 19 Dec 2002 20:01:12 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id 76437D657; Thu, 19 Dec 2002 21:07:17 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: [PATCH]: fix type of MAXMEM
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: 19 Dec 2002 21:07:17 +0100
Message-ID: <m28yylixhm.fsf@demo.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1008
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi
        I expect that the amount from where it is highmem to never be
        bigger that 4Giga Megabytes :) I.e. int should be enough.

Later, Juan.


Index: arch/mips/kernel/setup.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/setup.c,v
retrieving revision 1.96.2.34
diff -u -r1.96.2.34 setup.c
--- arch/mips/kernel/setup.c	11 Dec 2002 06:12:29 -0000	1.96.2.34
+++ arch/mips/kernel/setup.c	19 Dec 2002 19:48:41 -0000
@@ -306,7 +306,7 @@
 		max_low_pfn = MAXMEM_PFN;
 #ifndef CONFIG_HIGHMEM
 		/* Maximum memory usable is what is directly addressable */
-		printk(KERN_WARNING "Warning only %ldMB will be used.\n",
+		printk(KERN_WARNING "Warning only %dMB will be used.\n",
 		       MAXMEM>>20);
 		printk(KERN_WARNING "Use a HIGHMEM enabled kernel.\n");
 #endif


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
