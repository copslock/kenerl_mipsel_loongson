Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Dec 2002 10:30:45 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:27267 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8225527AbSLTKao>;
	Fri, 20 Dec 2002 10:30:44 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id E93F6D657; Fri, 20 Dec 2002 11:36:52 +0100 (CET)
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux mips mailing list <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH]: make highmem only things enclosed in the right #ifdef
References: <Pine.GSO.3.96.1021219125246.27339I-100000@delta.ds2.pg.gda.pl>
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <Pine.GSO.3.96.1021219125246.27339I-100000@delta.ds2.pg.gda.pl>
Date: 20 Dec 2002 11:36:52 +0100
Message-ID: <m2y96lf03f.fsf@demo.mitica>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2.92
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1023
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips

>>>>> "maciej" == Maciej W Rozycki <macro@ds2.pg.gda.pl> writes:

maciej> On 19 Dec 2002, Juan Quintela wrote:
>> What do you think of this new one?

maciej> Well, you could remove the line below:

>> sizeof(pgd_t ) * USER_PTRS_PER_PGD);
>> 
>> -	pgd_base = swapper_pg_dir;
>> 
>> #ifdef CONFIG_HIGHMEM

maciej> but that's nitpicking (and I may fix it up if Ralf applies the patch as
maciej> is) -- I've pointed you out the problem of spacing more to bring your
maciej> attention to such details than to object this particular change.  The
maciej> patch looks semantically OK. 

Hi

        Do you preffer this way?

Later, Juan.


Index: arch/mips/mm/init.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/init.c,v
retrieving revision 1.38.2.7
diff -u -r1.38.2.7 init.c
--- arch/mips/mm/init.c	5 Aug 2002 23:53:35 -0000	1.38.2.7
+++ arch/mips/mm/init.c	20 Dec 2002 09:55:03 -0000
@@ -161,6 +161,7 @@
 extern char _ftext, _etext, _fdata, _edata;
 extern char __init_begin, __init_end;
 
+#ifdef CONFIG_HIGHMEM
 static void __init fixrange_init (unsigned long start, unsigned long end,
 	pgd_t *pgd_base)
 {
@@ -189,33 +190,35 @@
 		j = 0;
 	}
 }
+#endif /* CONFIG_HIGHMEM */
 
 void __init pagetable_init(void)
 {
+#ifdef CONFIG_HIGHMEM
 	unsigned long vaddr;
-	pgd_t *pgd, *pgd_base;
+	pgd_t *pgd;
 	pmd_t *pmd;
 	pte_t *pte;
+#endif
 
 	/* Initialize the entire pgd.  */
 	pgd_init((unsigned long)swapper_pg_dir);
 	pgd_init((unsigned long)swapper_pg_dir +
 	         sizeof(pgd_t ) * USER_PTRS_PER_PGD);
 
-	pgd_base = swapper_pg_dir;
 
 #ifdef CONFIG_HIGHMEM
 	/*
 	 * Fixed mappings:
 	 */
 	vaddr = __fix_to_virt(__end_of_fixed_addresses - 1) & PMD_MASK;
-	fixrange_init(vaddr, 0, pgd_base);
+	fixrange_init(vaddr, 0, swapper_pg_dir);
 
 	/*
 	 * Permanent kmaps:
 	 */
 	vaddr = PKMAP_BASE;
-	fixrange_init(vaddr, vaddr + PAGE_SIZE*LAST_PKMAP, pgd_base);
+	fixrange_init(vaddr, vaddr + PAGE_SIZE*LAST_PKMAP, swapper_pg_dir);
 
 	pgd = swapper_pg_dir + __pgd_offset(vaddr);
 	pmd = pmd_offset(pgd, vaddr);




-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
