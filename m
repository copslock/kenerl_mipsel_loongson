Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jul 2003 19:38:08 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:1028
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225235AbTGASiF>; Tue, 1 Jul 2003 19:38:05 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.35 #1)
	id 19XQ0w-00005Y-00; Tue, 01 Jul 2003 20:38:02 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 19XNsv-0001UG-00; Tue, 01 Jul 2003 18:21:37 +0200
Date: Tue, 1 Jul 2003 18:21:22 +0200
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Subject: [PATCH] Fix r4k cache handling
Message-ID: <20030701162122.GA5698@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2744
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Hello Ralf,

I need the appended patch for my 5000/50, which has a R4000SC.


Thiemo


diff -BurpNX /home/ths/dontdiff linux-orig/arch/mips/mm/c-r4k.c linux/arch/mips/mm/c-r4k.c
--- linux-orig/arch/mips/mm/c-r4k.c	Tue May 13 23:32:50 2003
+++ linux/arch/mips/mm/c-r4k.c	Tue Jul  1 18:01:44 2003
@@ -27,7 +27,6 @@
 /* Primary cache parameters. */
 static unsigned long icache_size, dcache_size, scache_size;
 unsigned long icache_way_size, dcache_way_size, scache_way_size;
-static unsigned long scache_size;
 
 #include <asm/cacheops.h>
 #include <asm/r4kcache.h>
@@ -1084,6 +1083,11 @@ static void __init setup_scache(void)
 	     current_cpu_data.isa_level == MIPS_CPU_ISA_M64) &&
 	    !(current_cpu_data.scache.flags & MIPS_CACHE_NOT_PRESENT))
 		panic("Dunno how to handle MIPS32 / MIPS64 second level cache");
+
+	/* compute a couple of other cache variables */
+	scache_way_size = scache_size / c->scache.ways;
+
+	c->scache.sets = scache_size / (c->scache.linesz * c->scache.ways);
 
 	printk("Unified secondary cache %ldkB %s, linesize %d bytes.\n",
 	       scache_size >> 10, way_string[c->scache.ways], c->scache.linesz);
diff -BurpNX /home/ths/dontdiff linux-orig/include/asm-mips/r4kcache.h linux/include/asm-mips/r4kcache.h
--- linux-orig/include/asm-mips/r4kcache.h	Wed Apr 23 17:17:05 2003
+++ linux/include/asm-mips/r4kcache.h	Tue Jul  1 17:45:00 2003
@@ -111,6 +111,8 @@ static inline void invalidate_tcache_pag
 	cache_op(Page_Invalidate_T, addr);
 }
 
+extern unsigned long icache_way_size, dcache_way_size, scache_way_size;
+
 #define cache16_unroll32(base,op)				\
 	__asm__ __volatile__("					\
 		.set noreorder;					\
