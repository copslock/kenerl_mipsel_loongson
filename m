Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Dec 2002 10:58:26 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:23276 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8225414AbSLSK5g>;
	Thu, 19 Dec 2002 10:57:36 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id 93A73D657; Thu, 19 Dec 2002 12:03:40 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>,
	linux mips mailing list <linux-mips@linux-mips.org>
Subject: [PATCH]: read_c0_* return always a long
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: 19 Dec 2002 12:03:40 +0100
Message-ID: <m28yyml183.fsf@demo.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 988
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi
        this function returns a long, nuke a call to read_c0_errorepc
        and use right types for variables and printks.

Later, Juan.

Index: arch/mips/kernel/traps.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/traps.c,v
retrieving revision 1.99.2.38
diff -u -r1.99.2.38 traps.c
--- arch/mips/kernel/traps.c	17 Dec 2002 23:41:01 -0000	1.99.2.38
+++ arch/mips/kernel/traps.c	19 Dec 2002 10:17:47 -0000
@@ -781,14 +781,14 @@
 
 asmlinkage void cache_parity_error(void)
 {
-	unsigned int reg_val;
+	unsigned long reg_val;
 
 	/* For the moment, report the problem and hang. */
 	reg_val = read_c0_errorepc();
 	printk("Cache error exception:\n");
-	printk("cp0_errorepc == %08x\n", read_c0_errorepc());
+	printk("cp0_errorepc == %08lx\n", reg_val);
 	reg_val = read_c0_cacheerr();
-	printk("c0_cacheerr == %08x\n", reg_val);
+	printk("c0_cacheerr == %08lx\n", reg_val);
 
 	printk("Decoded c0_cacheerr: %s cache fault in %s reference.\n",
 	       reg_val & (1<<30) ? "secondary" : "primary",


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
