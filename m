Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2002 01:40:13 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:55012 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8225327AbSLRBhl>;
	Wed, 18 Dec 2002 01:37:41 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id B8A94D657; Wed, 18 Dec 2002 02:43:37 +0100 (CET)
To: linux mips mailing list <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH]: correct format string in dump_tlb
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: 18 Dec 2002 02:43:37 +0100
Message-ID: <m2wum8p0dy.fsf@demo.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 941
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi
        if we cast to unsigned it, print it as a long is a no-no :(

Later, Juan.

Index: arch/mips/lib/dump_tlb.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/lib/dump_tlb.c,v
retrieving revision 1.8.2.5
diff -u -r1.8.2.5 dump_tlb.c
--- arch/mips/lib/dump_tlb.c	2 Dec 2002 00:24:48 -0000	1.8.2.5
+++ arch/mips/lib/dump_tlb.c	18 Dec 2002 00:49:18 -0000
@@ -179,7 +180,7 @@
 #ifdef CONFIG_64BIT_PHYS_ADDR
 	printk("page == %08Lx\n", (unsigned long long) pte_val(page));
 #else
-	printk("page == %08lx\n", (unsigned int) pte_val(page));
+	printk("page == %08x\n", (unsigned int) pte_val(page));
 #endif
 
 	val = pte_val(page);


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
