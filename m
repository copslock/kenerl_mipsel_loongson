Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jul 2004 13:24:21 +0100 (BST)
Received: from p508B5A48.dip.t-dialin.net ([IPv6:::ffff:80.139.90.72]:12115
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225002AbUGPMYQ>; Fri, 16 Jul 2004 13:24:16 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i6GCO9xd021603;
	Fri, 16 Jul 2004 14:24:09 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i6GCO9TY021602;
	Fri, 16 Jul 2004 14:24:09 +0200
Date: Fri, 16 Jul 2004 14:24:09 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Dominic Sweetman <dom@mips.com>
Cc: "Kevin D. Kissell" <KevinK@mips.com>,
	S C <theansweriz42@hotmail.com>, linux-mips@linux-mips.org
Subject: Re: Strange, strange occurence
Message-ID: <20040716122409.GA19192@linux-mips.org>
References: <BAY2-F21njXXBARdkfw0003b0c8@hotmail.com> <20040710100412.GA23624@linux-mips.org> <00ba01c46823$3729b200$0deca8c0@Ulysses> <20040713003317.GA26715@linux-mips.org> <16629.24775.778491.754688@arsenal.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16629.24775.778491.754688@arsenal.mips.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5488
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jul 14, 2004 at 05:35:19PM +0100, Dominic Sweetman wrote:

> This is fiddly, but not terribly difficult and should have a
> negligible performance impact.
> 
> Does that make sense?  Am I now, having named the solution,
> responsible for figuring out a patch (yeuch, I never wanted to be a
> kernel programmer again...).

No and yes - but here is a simpler solution.  Below patch solves the
problem and adds just 32 bytes of code but removes the special case for
TX49/H2 entirely.

  Ralf

 arch/mips/mm/c-r4k.c        |   59 -------------------------------------------- include/asm-mips/r4kcache.h |   18 ++++++++-----
 include/asm-mips/war.h      |   14 ----------
 3 files changed, 13 insertions(+), 78 deletions(-)


Index: arch/mips/mm/c-r4k.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/c-r4k.c,v
retrieving revision 1.88
diff -u -r1.88 c-r4k.c
--- arch/mips/mm/c-r4k.c	16 Jul 2004 12:06:13 -0000	1.88
+++ arch/mips/mm/c-r4k.c	16 Jul 2004 12:17:05 -0000
@@ -96,16 +96,6 @@
 		r4k_blast_dcache = blast_dcache32;
 }
 
-/* force code alignment (used for TX49XX_ICACHE_INDEX_INV_WAR) */
-#define JUMP_TO_ALIGN(order) \
-	__asm__ __volatile__( \
-		"b\t1f\n\t" \
-		".align\t" #order "\n\t" \
-		"1:\n\t" \
-		)
-#define CACHE32_UNROLL32_ALIGN	JUMP_TO_ALIGN(10) /* 32 * 32 = 1024 */
-#define CACHE32_UNROLL32_ALIGN2	JUMP_TO_ALIGN(11)
-
 static inline void blast_r4600_v1_icache32(void)
 {
 	unsigned long flags;
@@ -115,27 +105,6 @@
 	local_irq_restore(flags);
 }
 
-static inline void tx49_blast_icache32(void)
-{
-	unsigned long start = INDEX_BASE;
-	unsigned long end = start + current_cpu_data.icache.waysize;
-	unsigned long ws_inc = 1UL << current_cpu_data.icache.waybit;
-	unsigned long ws_end = current_cpu_data.icache.ways <<
-	                       current_cpu_data.icache.waybit;
-	unsigned long ws, addr;
-
-	CACHE32_UNROLL32_ALIGN2;
-	/* I'm in even chunk.  blast odd chunks */
-	for (ws = 0; ws < ws_end; ws += ws_inc) 
-		for (addr = start + 0x400; addr < end; addr += 0x400 * 2) 
-			cache32_unroll32(addr|ws,Index_Invalidate_I);
-	CACHE32_UNROLL32_ALIGN;
-	/* I'm in odd chunk.  blast even chunks */
-	for (ws = 0; ws < ws_end; ws += ws_inc) 
-		for (addr = start; addr < end; addr += 0x400 * 2) 
-			cache32_unroll32(addr|ws,Index_Invalidate_I);
-}
-
 static inline void blast_icache32_r4600_v1_page_indexed(unsigned long page)
 {
 	unsigned long flags;
@@ -145,27 +114,6 @@
 	local_irq_restore(flags);
 }
 
-static inline void tx49_blast_icache32_page_indexed(unsigned long page)
-{
-	unsigned long start = page;
-	unsigned long end = start + PAGE_SIZE;
-	unsigned long ws_inc = 1UL << current_cpu_data.icache.waybit;
-	unsigned long ws_end = current_cpu_data.icache.ways <<
-	                       current_cpu_data.icache.waybit;
-	unsigned long ws, addr;
-
-	CACHE32_UNROLL32_ALIGN2;
-	/* I'm in even chunk.  blast odd chunks */
-	for (ws = 0; ws < ws_end; ws += ws_inc) 
-		for (addr = start + 0x400; addr < end; addr += 0x400 * 2) 
-			cache32_unroll32(addr|ws,Index_Invalidate_I);
-	CACHE32_UNROLL32_ALIGN;
-	/* I'm in odd chunk.  blast even chunks */
-	for (ws = 0; ws < ws_end; ws += ws_inc) 
-		for (addr = start; addr < end; addr += 0x400 * 2) 
-			cache32_unroll32(addr|ws,Index_Invalidate_I);
-}
-
 static void (* r4k_blast_icache_page)(unsigned long addr);
 
 static inline void r4k_blast_icache_page_setup(void)
@@ -190,10 +138,7 @@
 	if (ic_lsize == 16)
 		r4k_blast_icache_page_indexed = blast_icache16_page_indexed;
 	else if (ic_lsize == 32) {
-		if (TX49XX_ICACHE_INDEX_INV_WAR)
-			r4k_blast_icache_page_indexed =
-				tx49_blast_icache32_page_indexed;
-		else if (R4600_V1_INDEX_ICACHEOP_WAR && cpu_is_r4600_v1_x())
+		if (R4600_V1_INDEX_ICACHEOP_WAR && cpu_is_r4600_v1_x())
 			r4k_blast_icache_page_indexed =
 				blast_icache32_r4600_v1_page_indexed;
 		else
@@ -214,8 +159,6 @@
 	else if (ic_lsize == 32) {
 		if (R4600_V1_INDEX_ICACHEOP_WAR && cpu_is_r4600_v1_x())
 			r4k_blast_icache = blast_r4600_v1_icache32;
-		else if (TX49XX_ICACHE_INDEX_INV_WAR)
-			r4k_blast_icache = tx49_blast_icache32;
 		else
 			r4k_blast_icache = blast_icache32;
 	} else if (ic_lsize == 64)
Index: include/asm-mips/r4kcache.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/r4kcache.h,v
retrieving revision 1.22
diff -u -r1.22 r4kcache.h
--- include/asm-mips/r4kcache.h	5 Jan 2004 01:56:01 -0000	1.22
+++ include/asm-mips/r4kcache.h	16 Jul 2004 12:17:05 -0000
@@ -192,7 +192,7 @@
 
 static inline void blast_icache16(void)
 {
-	unsigned long start = INDEX_BASE;
+	unsigned long start = (unsigned long) &&body + 0x100;
 	unsigned long end = start + current_cpu_data.icache.waysize;
 	unsigned long ws_inc = 1UL << current_cpu_data.icache.waybit;
 	unsigned long ws_end = current_cpu_data.icache.ways <<
@@ -200,8 +200,10 @@
 	unsigned long ws, addr;
 
 	for (ws = 0; ws < ws_end; ws += ws_inc) 
-		for (addr = start; addr < end; addr += 0x200) 
+		for (addr = start; addr < end; addr += 0x200) {
+body:
 			cache16_unroll32(addr|ws,Index_Invalidate_I);
+		}
 }
 
 static inline void blast_icache16_page(unsigned long page)
@@ -335,7 +337,7 @@
 
 static inline void blast_icache32(void)
 {
-	unsigned long start = INDEX_BASE;
+	unsigned long start = (unsigned long) &&body + 0x200;
 	unsigned long end = start + current_cpu_data.icache.waysize;
 	unsigned long ws_inc = 1UL << current_cpu_data.icache.waybit;
 	unsigned long ws_end = current_cpu_data.icache.ways <<
@@ -343,8 +345,10 @@
 	unsigned long ws, addr;
 
 	for (ws = 0; ws < ws_end; ws += ws_inc) 
-		for (addr = start; addr < end; addr += 0x400) 
+		for (addr = start; addr < end; addr += 0x400)  {
+body:
 			cache32_unroll32(addr|ws,Index_Invalidate_I);
+		}
 }
 
 static inline void blast_icache32_page(unsigned long page)
@@ -439,7 +443,7 @@
 
 static inline void blast_icache64(void)
 {
-	unsigned long start = INDEX_BASE;
+	unsigned long start = (unsigned long) &&body + 0x400;
 	unsigned long end = start + current_cpu_data.icache.waysize;
 	unsigned long ws_inc = 1UL << current_cpu_data.icache.waybit;
 	unsigned long ws_end = current_cpu_data.icache.ways <<
@@ -447,8 +451,10 @@
 	unsigned long ws, addr;
 
 	for (ws = 0; ws < ws_end; ws += ws_inc) 
-		for (addr = start; addr < end; addr += 0x800) 
+		for (addr = start; addr < end; addr += 0x800) {
+body:
 			cache64_unroll32(addr|ws,Index_Invalidate_I);
+		}
 }
 
 static inline void blast_icache64_page(unsigned long page)
Index: include/asm-mips/war.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/war.h,v
retrieving revision 1.18
diff -u -r1.18 war.h
--- include/asm-mips/war.h	5 Mar 2004 02:47:19 -0000	1.18
+++ include/asm-mips/war.h	16 Jul 2004 12:17:05 -0000
@@ -158,17 +158,6 @@
 #endif
 
 /*
- * From TX49/H2 manual: "If the instruction (i.e. CACHE) is issued for
- * the line which this instruction itself exists, the following
- * operation is not guaranteed."
- *
- * Workaround: do two phase flushing for Index_Invalidate_I
- */
-#ifdef CONFIG_CPU_TX49XX
-#define TX49XX_ICACHE_INDEX_INV_WAR 1
-#endif
-
-/*
  * On the RM9000 there is a problem which makes the CreateDirtyExclusive
  * cache operation unusable on SMP systems.
  */
@@ -203,9 +192,6 @@
 #ifndef MIPS_CACHE_SYNC_WAR
 #define MIPS_CACHE_SYNC_WAR		0
 #endif
-#ifndef TX49XX_ICACHE_INDEX_INV_WAR
-#define TX49XX_ICACHE_INDEX_INV_WAR	0
-#endif
 #ifndef RM9000_CDEX_SMP_WAR
 #define RM9000_CDEX_SMP_WAR		0
 #endif
