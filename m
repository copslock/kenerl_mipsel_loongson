Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Dec 2002 10:58:06 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:22508 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8225413AbSLSK5b>;
	Thu, 19 Dec 2002 10:57:31 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id CE869D657; Thu, 19 Dec 2002 12:03:34 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: [PATCH]: %p and 0 pad is not C99
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: 19 Dec 2002 12:03:34 +0100
Message-ID: <m2bs3il189.fsf@demo.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 987
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi
        compiler complains when you use %08p about the %0, notice that
        this came (normally) from somebody changing %08x to this, with
        %x the 0 is valid.

Later, Juan.

Index: arch/mips/lib/dump_tlb.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/lib/dump_tlb.c,v
retrieving revision 1.8.2.6
diff -u -r1.8.2.6 dump_tlb.c
--- arch/mips/lib/dump_tlb.c	18 Dec 2002 22:47:37 -0000	1.8.2.6
+++ arch/mips/lib/dump_tlb.c	19 Dec 2002 10:38:02 -0000
@@ -153,8 +154,8 @@
 	addr = (unsigned int) address;
 
 	printk("Addr                 == %08x\n", addr);
-	printk("task                 == %08p\n", t);
-	printk("task->mm             == %08p\n", t->mm);
+	printk("task                 == %8p\n", t);
+	printk("task->mm             == %8p\n", t->mm);
 	//printk("tasks->mm.pgd        == %08x\n", (unsigned int) t->mm->pgd);
 
 	if (addr > KSEG0)


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
