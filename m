Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Dec 2002 10:01:20 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:4332 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8225399AbSLSKBT>;
	Thu, 19 Dec 2002 10:01:19 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id 8AD01D657; Thu, 19 Dec 2002 11:07:20 +0100 (CET)
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux mips mailing list <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH]: make highmem only things enclosed in the right #ifdef
References: <Pine.GSO.3.96.1021218173132.5977B-100000@delta.ds2.pg.gda.pl>
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <Pine.GSO.3.96.1021218173132.5977B-100000@delta.ds2.pg.gda.pl>
Date: 19 Dec 2002 11:07:19 +0100
Message-ID: <m2znr2mieg.fsf@demo.mitica>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2.92
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 979
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips

>>>>> "maciej" == Maciej W Rozycki <macro@ds2.pg.gda.pl> writes:

maciej> On 18 Dec 2002, Juan Quintela wrote:
>> +#ifdef CONFIG_HIGHMEM
>> unsigned long vaddr;
>> -	pgd_t *pgd, *pgd_base;
>> pmd_t *pmd;
>> pte_t *pte;
>> -
>> +	pgd_t *pgd, pgd_base;
>> +#endif
>> /* Initialize the entire pgd.  */
>> pgd_init((unsigned long)swapper_pg_dir);

maciej> Please don't change the spacing this way -- it worsens readability. 
maciej> Check other pathes for cases like this, too. 

Hi

        Argh, the patch indeed missed an *.

What do you think of this new one?

Later ,Juan.

Index: arch/mips/mm/init.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/init.c,v
retrieving revision 1.38.2.7
diff -u -r1.38.2.7 init.c
--- arch/mips/mm/init.c	5 Aug 2002 23:53:35 -0000	1.38.2.7
+++ arch/mips/mm/init.c	19 Dec 2002 09:21:09 -0000
@@ -161,6 +161,7 @@
 extern char _ftext, _etext, _fdata, _edata;
 extern char __init_begin, __init_end;
 
+#ifdef CONFIG_HIGHMEM
 static void __init fixrange_init (unsigned long start, unsigned long end,
 	pgd_t *pgd_base)
 {
@@ -189,22 +190,26 @@
 		j = 0;
 	}
 }
+#endif /* CONFIG_HIGHMEM */
 
 void __init pagetable_init(void)
 {
+#ifdef CONFIG_HIGHMEM
 	unsigned long vaddr;
 	pgd_t *pgd, *pgd_base;
 	pmd_t *pmd;
 	pte_t *pte;
+#endif
 
 	/* Initialize the entire pgd.  */
 	pgd_init((unsigned long)swapper_pg_dir);
 	pgd_init((unsigned long)swapper_pg_dir +
 	         sizeof(pgd_t ) * USER_PTRS_PER_PGD);
 
-	pgd_base = swapper_pg_dir;
 
 #ifdef CONFIG_HIGHMEM
+	pgd_base = swapper_pg_dir;
+
 	/*
 	 * Fixed mappings:
 	 */



-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
