Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Mar 2003 02:54:15 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:10883 "EHLO
	neno.mitica") by linux-mips.org with ESMTP id <S8225196AbTC0Cxx>;
	Thu, 27 Mar 2003 02:53:53 +0000
Received: by neno.mitica (Postfix, from userid 501)
	id 7557146A59; Thu, 27 Mar 2003 03:52:26 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: [PATCH]: remove pgd_base
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: Thu, 27 Mar 2003 03:52:26 +0100
Message-ID: <m2ptoded1x.fsf@mandrakesoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1821
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi

pgd_base was only used in the CONFIG_HIGHMEM.  Used constant
propagation and we are done.

Later, Juan.


 build/arch/mips/mm/init.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff -puN build/arch/mips/mm/init.c~remove_unused_var_init.c build/arch/mips/mm/init.c
--- 24/build/arch/mips/mm/init.c~remove_unused_var_init.c	2003-03-19 23:37:26.000000000 +0100
+++ 24-quintela/build/arch/mips/mm/init.c	2003-03-19 23:39:06.000000000 +0100
@@ -193,7 +193,7 @@ static void __init fixrange_init (unsign
 void __init pagetable_init(void)
 {
 	unsigned long vaddr;
-	pgd_t *pgd, *pgd_base;
+	pgd_t *pgd;
 	pmd_t *pmd;
 	pte_t *pte;
 
@@ -202,20 +202,18 @@ void __init pagetable_init(void)
 	pgd_init((unsigned long)swapper_pg_dir +
 	         sizeof(pgd_t ) * USER_PTRS_PER_PGD);
 
-	pgd_base = swapper_pg_dir;
-
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

_


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
