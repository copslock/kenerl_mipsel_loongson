Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Dec 2002 10:57:47 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:21996 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8225412AbSLSK50>;
	Thu, 19 Dec 2002 10:57:26 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id 0B214D657; Thu, 19 Dec 2002 12:03:30 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: [PATCH]: you can't use p and p++ without a secuence point
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: 19 Dec 2002 12:03:29 +0100
Message-ID: <m2el8el18e.fsf@demo.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 986
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi
        using p & p++ without a sequence point in the middle is
        undefined behaviour.  Once there fix the casts also.
        and change == to = as normally == means identity, not
        asignation :(

Later, Juan.

Index: arch/mips/lib/dump_tlb.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/lib/dump_tlb.c,v
retrieving revision 1.8.2.6
diff -u -r1.8.2.6 dump_tlb.c
--- arch/mips/lib/dump_tlb.c	18 Dec 2002 22:47:37 -0000	1.8.2.6
+++ arch/mips/lib/dump_tlb.c	19 Dec 2002 10:38:02 -0000
@@ -225,9 +226,7 @@
 
 	for(i=0;i<8;i++)
 	{
-		printk("*%08lx == %08lx, ",
-		       (unsigned long)p, (unsigned long)*p++);
-		printk("*%08lx == %08lx\n",
-		       (unsigned long)p, (unsigned long)*p++);
+		printk("*%8p = %08lx, ", p, *p); p++;
+		printk("*%8p = %08lx\n", p, *p); p++;
 	}
 }


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
