Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Apr 2004 14:46:48 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:36748 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225532AbUDBNqi>; Fri, 2 Apr 2004 14:46:38 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 3D1E74787C; Fri,  2 Apr 2004 15:46:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 2ECCC47781; Fri,  2 Apr 2004 15:46:25 +0200 (CEST)
Date: Fri, 2 Apr 2004 15:46:25 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: [patch] Fragile constructs in c-sb1.c
Message-ID: <Pine.LNX.4.55.0404021534430.4735@jurand.ds.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4721
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

Hello,

 There's a bunch of ugly and fragile constructs defining assembler symbols
in c-sb1.c that depending on the configuration lead at least to an
unresolved reference to local_sb1___flush_cache_all upon a final link.  
Here's a fix that changes them to an equivalent implementation using a
documented gcc syntax.

 OK to apply?

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.24-pre2-20040116-c-sb1-0
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/arch/mips64/mm/c-sb1.c linux-mips-2.4.24-pre2-20040116/arch/mips64/mm/c-sb1.c
--- linux-mips-2.4.24-pre2-20040116.macro/arch/mips64/mm/c-sb1.c	2004-01-15 03:57:03.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/arch/mips64/mm/c-sb1.c	2004-04-01 21:10:41.000000000 +0000
@@ -2,6 +2,7 @@
  * Copyright (C) 1996 David S. Miller (dm@engr.sgi.com)
  * Copyright (C) 1997, 2001 Ralf Baechle (ralf@gnu.org)
  * Copyright (C) 2000, 2001, 2002, 2003 Broadcom Corporation
+ * Copyright (C) 2004  Maciej W. Rozycki
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
@@ -231,8 +232,8 @@ static void sb1_flush_cache_page(struct 
 	local_sb1_flush_cache_page(vma, addr);
 }
 #else
-void sb1_flush_cache_page(struct vm_area_struct *vma, unsigned long addr);
-asm("sb1_flush_cache_page = local_sb1_flush_cache_page");
+void sb1_flush_cache_page(struct vm_area_struct *vma, unsigned long addr)
+	__attribute__((alias("local_sb1_flush_cache_page")));
 #endif
 
 /*
@@ -280,8 +281,8 @@ static void local_sb1___flush_cache_all(
 }
 
 #ifdef CONFIG_SMP
-extern void sb1___flush_cache_all_ipi(void *ignored);
-asm("sb1___flush_cache_all_ipi = local_sb1___flush_cache_all");
+void sb1___flush_cache_all_ipi(void *ignored)
+	__attribute__((alias("local_sb1___flush_cache_all")));
 
 static void sb1___flush_cache_all(void)
 {
@@ -289,8 +290,8 @@ static void sb1___flush_cache_all(void)
 	local_sb1___flush_cache_all();
 }
 #else
-extern void sb1___flush_cache_all(void);
-asm("sb1___flush_cache_all = local_sb1___flush_cache_all");
+void sb1___flush_cache_all(void)
+	__attribute__((alias("local_sb1___flush_cache_all")));
 #endif
 
 /*
@@ -340,8 +341,8 @@ void sb1_flush_icache_range(unsigned lon
 	local_sb1_flush_icache_range(start, end);
 }
 #else
-void sb1_flush_icache_range(unsigned long start, unsigned long end);
-asm("sb1_flush_icache_range = local_sb1_flush_icache_range");
+void sb1_flush_icache_range(unsigned long start, unsigned long end)
+	__attribute__((alias("local_sb1_flush_icache_range")));
 #endif
 
 /*
@@ -398,8 +399,8 @@ static void sb1_flush_icache_page(struct
 	local_sb1_flush_icache_page(vma, page);
 }
 #else
-void sb1_flush_icache_page(struct vm_area_struct *vma, struct page *page);
-asm("sb1_flush_icache_page = local_sb1_flush_icache_page");
+void sb1_flush_icache_page(struct vm_area_struct *vma, struct page *page)
+	__attribute__((alias("local_sb1_flush_icache_page")));
 #endif
 
 /*
@@ -447,8 +448,8 @@ static void sb1_flush_cache_sigtramp(uns
 	smp_call_function(sb1_flush_cache_sigtramp_ipi, (void *) addr, 1, 1);
 }
 #else
-void sb1_flush_cache_sigtramp(unsigned long addr);
-asm("sb1_flush_cache_sigtramp = local_sb1_flush_cache_sigtramp");
+void sb1_flush_cache_sigtramp(unsigned long addr)
+	__attribute__((alias("local_sb1_flush_cache_sigtramp")));
 #endif
 
 
