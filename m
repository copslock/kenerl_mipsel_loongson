Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Dec 2002 19:54:42 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:10368 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8225473AbSLSTym>;
	Thu, 19 Dec 2002 19:54:42 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id C0ED5D657; Thu, 19 Dec 2002 21:00:46 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: [PATCH]:
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: 19 Dec 2002 21:00:46 +0100
Message-ID: <m2smwtixsh.fsf@demo.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1004
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi
        - pte_val() returs a long, print it directly.
        - flags needs to be unsigedn long, not unsigned int.

Later, Juan.


Later, Juan.

Index: arch/mips64/mm/tlb-r4k.c
===================================================================
RCS file: /home/cvs/linux/arch/mips64/mm/tlb-r4k.c,v
retrieving revision 1.1.2.5
diff -u -r1.1.2.5 tlb-r4k.c
--- arch/mips64/mm/tlb-r4k.c	2 Dec 2002 00:24:53 -0000	1.1.2.5
+++ arch/mips64/mm/tlb-r4k.c	19 Dec 2002 19:48:44 -0000
@@ -244,7 +244,7 @@
 	pmd = pmd_offset(pgd, addr);
 	pte = pte_offset(pmd, addr);
 	page = *pte;
-	printk("Memory Mapping: VA = %08x, PA = %08x ", addr, (unsigned int) pte_val(page));
+	printk("Memory Mapping: VA = %08x, PA = %08x ", addr, pte_val(page));
 	val = pte_val(page);
 	if (val & _PAGE_PRESENT) printk("present ");
 	if (val & _PAGE_READ) printk("read ");
@@ -259,7 +259,7 @@
 
 void show_tlb(void)
 {
-        unsigned int flags;
+        unsigned long flags;
         unsigned int old_ctx;
 	unsigned int entry;
 	unsigned int entrylo0, entrylo1, entryhi;


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
