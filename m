Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Mar 2003 02:54:35 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:11395 "EHLO
	neno.mitica") by linux-mips.org with ESMTP id <S8225201AbTC0CyF>;
	Thu, 27 Mar 2003 02:54:05 +0000
Received: by neno.mitica (Postfix, from userid 501)
	id EFEA546A59; Thu, 27 Mar 2003 03:52:38 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: [PATCH]: ifdef highmem code
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: Thu, 27 Mar 2003 03:52:38 +0100
Message-ID: <m2n0jhed1l.fsf@mandrakesoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1822
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi
        this patch applies on top of the:
             
                [PATCH]: remove pgd_base

Later, Juan.

ifdef var names & fixrange_init function that are only needed in the
CONFIG_HIGHMEM case.


 build/arch/mips/mm/init.c |    4 ++++
 1 files changed, 4 insertions(+)

diff -puN build/arch/mips/mm/init.c~ifdef_higmem_only_code build/arch/mips/mm/init.c
--- 24/build/arch/mips/mm/init.c~ifdef_higmem_only_code	2003-03-20 00:30:37.000000000 +0100
+++ 24-quintela/build/arch/mips/mm/init.c	2003-03-20 00:33:30.000000000 +0100
@@ -161,6 +161,7 @@ void show_mem(void)
 extern char _ftext, _etext, _fdata, _edata;
 extern char __init_begin, __init_end;
 
+#ifdef CONFIG_HIGHMEM
 static void __init fixrange_init (unsigned long start, unsigned long end,
 	pgd_t *pgd_base)
 {
@@ -189,13 +190,16 @@ static void __init fixrange_init (unsign
 		j = 0;
 	}
 }
+#endif
 
 void __init pagetable_init(void)
 {
+#ifdef CONFIG_HIGHMEM
 	unsigned long vaddr;
 	pgd_t *pgd;
 	pmd_t *pmd;
 	pte_t *pte;
+#endif
 
 	/* Initialize the entire pgd.  */
 	pgd_init((unsigned long)swapper_pg_dir);

_


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
