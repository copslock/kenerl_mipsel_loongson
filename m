Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2002 01:37:35 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:50916 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8225319AbSLRBhC>;
	Wed, 18 Dec 2002 01:37:02 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id 1EC79D657; Wed, 18 Dec 2002 02:42:59 +0100 (CET)
To: linux mips mailing list <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH]: make highmem only things enclosed in the right #ifdef
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: 18 Dec 2002 02:42:59 +0100
Message-ID: <m2k7i8qezg.fsf@demo.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 933
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi
        a couple of variable declarations and a function declaration
        wasn't properly protected by #ifdefs.

Later, Juan.

Index: arch/mips/mm/init.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/init.c,v
retrieving revision 1.38.2.7
diff -u -r1.38.2.7 init.c
--- arch/mips/mm/init.c	5 Aug 2002 23:53:35 -0000	1.38.2.7
+++ arch/mips/mm/init.c	18 Dec 2002 00:49:19 -0000
@@ -161,6 +161,7 @@
 extern char _ftext, _etext, _fdata, _edata;
 extern char __init_begin, __init_end;
 
+#ifdef CONFIG_HIGHMEM
 static void __init fixrange_init (unsigned long start, unsigned long end,
 	pgd_t *pgd_base)
 {
@@ -189,22 +190,25 @@
 		j = 0;
 	}
 }
+#endif /* CONFIG_HIGHMEM */
 
 void __init pagetable_init(void)
 {
+#ifdef CONFIG_HIGHMEM
 	unsigned long vaddr;
-	pgd_t *pgd, *pgd_base;
 	pmd_t *pmd;
 	pte_t *pte;
-
+	pgd_t *pgd, pgd_base;
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
