Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Dec 2002 21:03:53 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:33152 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8225484AbSLSVDw>;
	Thu, 19 Dec 2002 21:03:52 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id EC591D657; Thu, 19 Dec 2002 22:09:57 +0100 (CET)
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: Re: [PATCH]:
References: <Pine.GSO.3.96.1021219215031.27339S-100000@delta.ds2.pg.gda.pl>
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <Pine.GSO.3.96.1021219215031.27339S-100000@delta.ds2.pg.gda.pl>
Date: 19 Dec 2002 22:09:57 +0100
Message-ID: <m23cotiul6.fsf@demo.mitica>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2.92
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1011
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips

>>>>> "maciej" == Maciej W Rozycki <macro@ds2.pg.gda.pl> writes:

maciej> On 19 Dec 2002, Juan Quintela wrote:
>> - pte_val() returs a long, print it directly.
maciej> [...]
>> -	printk("Memory Mapping: VA = %08x, PA = %08x ", addr, (unsigned int) pte_val(page));
>> +	printk("Memory Mapping: VA = %08x, PA = %08x ", addr, pte_val(page));

maciej> Well, I guess you need "%08lx" then.  For both formats, actually.

Arghhhhhhhh, wrong patch, 
Ralf, don't apply, appy this other:

Sorry for the inconvenience, just diff the wrong tree :(

Later, Juan.

Index: arch/mips64/mm/tlb-r4k.c
===================================================================
RCS file: /home/cvs/linux/arch/mips64/mm/tlb-r4k.c,v
retrieving revision 1.1.2.5
diff -u -r1.1.2.5 tlb-r4k.c
--- arch/mips64/mm/tlb-r4k.c	2 Dec 2002 00:24:53 -0000	1.1.2.5
+++ arch/mips64/mm/tlb-r4k.c	19 Dec 2002 21:03:09 -0000
@@ -244,7 +244,7 @@
 	pmd = pmd_offset(pgd, addr);
 	pte = pte_offset(pmd, addr);
 	page = *pte;
-	printk("Memory Mapping: VA = %08x, PA = %08x ", addr, (unsigned int) pte_val(page));
+	printk("Memory Mapping: VA = %08lx, PA = %08lx ", addr, pte_val(page));
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
