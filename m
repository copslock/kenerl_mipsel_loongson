Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Dec 2002 19:07:09 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:33157 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8225541AbSLTTHI>;
	Fri, 20 Dec 2002 19:07:08 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id CE29BD657; Fri, 20 Dec 2002 20:13:18 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: [PATCH]: flags have to be unsigned long
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: 20 Dec 2002 20:13:18 +0100
Message-ID: <m2el8cfqr5.fsf@demo.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1030
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi
        more occurrences where flags are declared as int.
        In a couple of places I move the declaration to its
        corresponding ifdef.

Later, Juan.

Index: arch/mips/mm/c-r4k.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/c-r4k.c,v
retrieving revision 1.3.2.16
diff -u -r1.3.2.16 c-r4k.c
--- arch/mips/mm/c-r4k.c	20 Dec 2002 03:08:32 -0000	1.3.2.16
+++ arch/mips/mm/c-r4k.c	20 Dec 2002 18:39:46 -0000
@@ -948,12 +948,13 @@
 static void r4k_dma_cache_wback_inv_pc(unsigned long addr, unsigned long size)
 {
 	unsigned long end, a;
-	unsigned int flags;
 
 	if (size >= dcache_size) {
 		flush_cache_all();
 	} else {
 #ifdef R4600_V2_HIT_CACHEOP_WAR
+		unsigned long flags;
+
 		/* Workaround for R4600 bug.  See comment in <asm/war>. */
 		local_irq_save(flags);
 		*(volatile unsigned long *)KSEG1;
@@ -994,12 +995,13 @@
 static void r4k_dma_cache_inv_pc(unsigned long addr, unsigned long size)
 {
 	unsigned long end, a;
-	unsigned int flags;
 
 	if (size >= dcache_size) {
 		flush_cache_all();
 	} else {
 #ifdef R4600_V2_HIT_CACHEOP_WAR
+		unsigned long flags;
+
 		/* Workaround for R4600 bug.  See comment in <asm/war>. */
 		local_irq_save(flags);
 		*(volatile unsigned long *)KSEG1;
Index: arch/mips64/mm/c-mips64.c
===================================================================
RCS file: /home/cvs/linux/arch/mips64/mm/c-mips64.c,v
retrieving revision 1.1.2.6
diff -u -r1.1.2.6 c-mips64.c
--- arch/mips64/mm/c-mips64.c	18 Dec 2002 22:23:59 -0000	1.1.2.6
+++ arch/mips64/mm/c-mips64.c	20 Dec 2002 18:39:48 -0000
@@ -316,7 +316,7 @@
 mips64_dma_cache_wback_inv_pc(unsigned long addr, unsigned long size)
 {
 	unsigned long end, a;
-	unsigned int flags;
+	unsigned long flags;
 
 	if (size >= (unsigned long)dcache_size) {
 		blast_dcache();
@@ -357,7 +357,7 @@
 mips64_dma_cache_inv_pc(unsigned long addr, unsigned long size)
 {
 	unsigned long end, a;
-	unsigned int flags;
+	unsigned long flags;
 
 	if (size >= (unsigned long)dcache_size) {
 		blast_dcache();
Index: arch/mips64/mm/c-r4k.c
===================================================================
RCS file: /home/cvs/linux/arch/mips64/mm/c-r4k.c,v
retrieving revision 1.1.2.10
diff -u -r1.1.2.10 c-r4k.c
--- arch/mips64/mm/c-r4k.c	20 Dec 2002 03:08:32 -0000	1.1.2.10
+++ arch/mips64/mm/c-r4k.c	20 Dec 2002 18:39:48 -0000
@@ -1065,7 +1070,7 @@
 static void r4600v20k_flush_cache_sigtramp(unsigned long addr)
 {
 #ifdef R4600_V2_HIT_CACHEOP_WAR
-	unsigned int flags;
+	unsigned long flags;
 
 	local_irq_save(flags);
 
Index: arch/mips64/mm/pg-r4k.c
===================================================================
RCS file: /home/cvs/linux/arch/mips64/mm/pg-r4k.c,v
retrieving revision 1.1.2.2
diff -u -r1.1.2.2 pg-r4k.c
--- arch/mips64/mm/pg-r4k.c	30 Sep 2002 16:53:55 -0000	1.1.2.2
+++ arch/mips64/mm/pg-r4k.c	20 Dec 2002 18:39:48 -0000
@@ -157,7 +157,7 @@
  */
 void r4k_clear_page_r4600_v2(void * page)
 {
-	unsigned int flags;
+	unsigned long flags;
 
 	__save_and_cli(flags);
 	*(volatile unsigned int *)KSEG1;
@@ -432,7 +432,7 @@
 void r4k_copy_page_r4600_v2(void * to, void * from)
 {
 	unsigned long dummy1, dummy2, reg1, reg2;
-	unsigned int flags;
+	unsigned long flags;
 
 	__save_and_cli(flags);
 	__asm__ __volatile__(

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
