Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6QNihRw022912
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 26 Jul 2002 16:44:43 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6QNih26022911
	for linux-mips-outgoing; Fri, 26 Jul 2002 16:44:43 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from laposte.enst-bretagne.fr (laposte.enst-bretagne.fr [192.108.115.3])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6QNiYRw022902;
	Fri, 26 Jul 2002 16:44:35 -0700
Received: from resel.enst-bretagne.fr (UNKNOWN@maisel-gw.enst-bretagne.fr [192.44.76.8])
	by laposte.enst-bretagne.fr (8.11.6/8.11.6) with ESMTP id g6QNjbL16285;
	Sat, 27 Jul 2002 01:45:37 +0200
Received: from melkor (mail@melkor.maisel.enst-bretagne.fr [172.16.20.65])
	by resel.enst-bretagne.fr (8.12.3/8.12.3/Debian -4) with ESMTP id g6QNjcTF008666;
	Sat, 27 Jul 2002 01:45:38 +0200
Received: from glaurung (helo=localhost)
	by melkor with local-esmtp (Exim 3.35 #1 (Debian))
	id 17YEm9-0000CH-00; Sat, 27 Jul 2002 01:45:37 +0200
Date: Sat, 27 Jul 2002 01:45:37 +0200 (CEST)
From: Vivien Chappelier <vivien.chappelier@enst-bretagne.fr>
X-Sender: glaurung@melkor
To: Ralf Baechle <ralf@oss.sgi.com>
cc: linux-mips@oss.sgi.com
Subject: [2.5 PATCH] pmd_populate and pmd_page fixes
Message-ID: <Pine.LNX.4.21.0207270142350.20095-100000@melkor>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: by amavisd-milter (http://amavis.org/) at enst-bretagne.fr
X-Spam-Status: No, hits=-5.0 required=5.0 tests=UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

	This patch fixes the pmd_populate and pmd_page functions
introduced in 2.5.5 (the old ones having been renamed as pmd_page_kernel
and pmd_populate_kernel). It applies to 'mips64' but 'mips' should be
corrected as well. Also, I've not checked what should be done in the
HIGHMEM or NUMA case.

Vivien.

--- linux/include/asm-mips64/pgtable.h	Mon Jul 22 20:21:37 2002
+++ linux.new/include/asm-mips64/pgtable.h	Sat Jul 27 00:51:43 2002
@@ -270,7 +270,7 @@
  */
 #define page_pte(page)		page_pte_prot(page, __pgprot(0))
 #define pmd_page_kernel(pmd)	pmd_val(pmd)
-#define pmd_page(pmd)		(mem_map + (pmd_val(pmd) - PAGE_OFFSET))
+#define pmd_page(pmd)		(mem_map + ((pmd_val(pmd) - PAGE_OFFSET) >> PAGE_SHIFT))
 
 static inline unsigned long pgd_page(pgd_t pgd)
 {
--- linux/include/asm-mips64/pgalloc.h	Mon Jul 22 20:21:37 2002
+++ linux.new/include/asm-mips64/pgalloc.h	Sat Jul 27 00:53:26 2002
@@ -51,7 +51,7 @@
 }
 
 #define pmd_populate_kernel(mm, pmd, pte)	set_pmd(pmd, __pmd(pte))
-#define pmd_populate(mm, pmd, pte)		set_pmd(pmd, __pmd(pte))
+#define pmd_populate(mm, pmd, page)		set_pmd(pmd, __pmd(((page - mem_map) << PAGE_SHIFT) + PAGE_OFFSET))
 #define pgd_populate(mm, pgd, pmd)		set_pgd(pgd, __pgd(pmd))
 
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
