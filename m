Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Dec 2002 19:55:46 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:12160 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8225473AbSLSTzq>;
	Thu, 19 Dec 2002 19:55:46 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id C8832D657; Thu, 19 Dec 2002 21:01:51 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: [PATCH]: flasg needs to be unsigned long
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: 19 Dec 2002 21:01:51 +0100
Message-ID: <m2n0n1ixqo.fsf@demo.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1005
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi
        subject told all.
        Once there, put they inside the right #ifdef

Later, Juan.

Index: arch/mips64/mm/c-r4k.c
===================================================================
RCS file: /home/cvs/linux/arch/mips64/mm/c-r4k.c,v
retrieving revision 1.1.2.9
diff -u -r1.1.2.9 c-r4k.c
--- arch/mips64/mm/c-r4k.c	18 Dec 2002 22:43:22 -0000	1.1.2.9
+++ arch/mips64/mm/c-r4k.c	19 Dec 2002 19:48:44 -0000
@@ -948,12 +948,13 @@
 static void r4k_dma_cache_wback_inv_pc(unsigned long addr, unsigned long size)
 {
 	unsigned long end, a;
-	unsigned int flags;
 
 	if (size >= dcache_size) {
 		flush_cache_l1();
 	} else {
 #ifdef R4600_V2_HIT_CACHEOP_WAR
+		unsigned long flags;
+
 		/* Workaround for R4600 bug.  See comment in <asm/war>. */
 		__save_and_cli(flags);
 		*(volatile unsigned long *)KSEG1;
@@ -994,12 +995,13 @@
 static void r4k_dma_cache_inv_pc(unsigned long addr, unsigned long size)
 {
 	unsigned long end, a;
-	unsigned int flags;
 
 	if (size >= dcache_size) {
 		flush_cache_l1();
 	} else {
 #ifdef R4600_V2_HIT_CACHEOP_WAR
+		unsigned long flags;
+
 		/* Workaround for R4600 bug.  See comment in <asm/war>. */
 		__save_and_cli(flags);
 		*(volatile unsigned long *)KSEG1;


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
