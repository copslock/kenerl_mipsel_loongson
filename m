Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jan 2003 12:37:05 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:20939 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226128AbTAJMhE>; Fri, 10 Jan 2003 12:37:04 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA24336;
	Fri, 10 Jan 2003 13:37:14 +0100 (MET)
Date: Fri, 10 Jan 2003 13:37:12 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: linux-mips@linux-mips.org
Subject: [patch] R4k cache code synchronization
Message-ID: <Pine.GSO.3.96.1030110131859.23678B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1119
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

Ralf,

 Here are some bits to synchronize c-r4k.c across ports.  There are no
functional changes, at least no intended ones.  OK to apply?

 I can't see any need for flush_cache_l1() and flush_cache_l2().  I'd like
to remove them.  A single flush_cache_all() seems sufficient for our
needs.  Any objections? 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.20-pre6-20030107-mips-c-r4k-sync-0
diff -up --recursive --new-file linux-mips-2.4.20-pre6-20030107.macro/arch/mips/mm/c-r4k.c linux-mips-2.4.20-pre6-20030107/arch/mips/mm/c-r4k.c
--- linux-mips-2.4.20-pre6-20030107.macro/arch/mips/mm/c-r4k.c	2002-12-20 03:56:50.000000000 +0000
+++ linux-mips-2.4.20-pre6-20030107/arch/mips/mm/c-r4k.c	2003-01-09 22:23:33.000000000 +0000
@@ -948,12 +948,13 @@ static void r4k_flush_icache_page_p(stru
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
@@ -962,7 +963,7 @@ static void r4k_dma_cache_wback_inv_pc(u
 		a = addr & ~(dc_lsize - 1);
 		end = (addr + size - 1) & ~(dc_lsize - 1);
 		while (1) {
-			flush_dcache_line(a); /* Hit_Writeback_Inv_D */
+			flush_dcache_line(a);	/* Hit_Writeback_Inv_D */
 			if (a == end) break;
 			a += dc_lsize;
 		}
@@ -970,6 +971,7 @@ static void r4k_dma_cache_wback_inv_pc(u
 		local_irq_restore(flags);
 #endif
 	}
+
 	bc_wback_inv(addr, size);
 }
 
@@ -994,12 +996,13 @@ static void r4k_dma_cache_wback_inv_sc(u
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
@@ -1008,7 +1011,7 @@ static void r4k_dma_cache_inv_pc(unsigne
 		a = addr & ~(dc_lsize - 1);
 		end = (addr + size - 1) & ~(dc_lsize - 1);
 		while (1) {
-			flush_dcache_line(a); /* Hit_Writeback_Inv_D */
+			flush_dcache_line(a);	/* Hit_Writeback_Inv_D */
 			if (a == end) break;
 			a += dc_lsize;
 		}
@@ -1016,6 +1019,7 @@ static void r4k_dma_cache_inv_pc(unsigne
 		local_irq_restore(flags);
 #endif
 	}
+
 	bc_inv(addr, size);
 }
 
@@ -1031,7 +1035,7 @@ static void r4k_dma_cache_inv_sc(unsigne
 	a = addr & ~(sc_lsize - 1);
 	end = (addr + size - 1) & ~(sc_lsize - 1);
 	while (1) {
-		flush_scache_line(a); /* Hit_Writeback_Inv_SD */
+		flush_scache_line(a);	/* Hit_Writeback_Inv_SD */
 		if (a == end) break;
 		a += sc_lsize;
 	}
@@ -1232,10 +1236,10 @@ static void __init setup_noscache_funcs(
 		_flush_cache_page = r4k_flush_cache_page_d32i32;
 		break;
 	}
-	___flush_cache_all = _flush_cache_all;
-
 	_flush_icache_page = r4k_flush_icache_page_p;
 
+	___flush_cache_all = _flush_cache_all;
+
 	_dma_cache_wback_inv = r4k_dma_cache_wback_inv_pc;
 	_dma_cache_wback = r4k_dma_cache_wback_inv_pc;
 	_dma_cache_inv = r4k_dma_cache_inv_pc;
@@ -1317,8 +1321,10 @@ static void __init setup_scache_funcs(vo
 		_copy_page = r4k_copy_page_s128;
 		break;
 	}
-	___flush_cache_all = _flush_cache_all;
 	_flush_icache_page = r4k_flush_icache_page_s;
+
+	___flush_cache_all = _flush_cache_all;
+
 	_dma_cache_wback_inv = r4k_dma_cache_wback_inv_sc;
 	_dma_cache_wback = r4k_dma_cache_wback_inv_sc;
 	_dma_cache_inv = r4k_dma_cache_inv_sc;
@@ -1373,10 +1379,10 @@ void __init ld_mmu_r4xx0(void)
 	}
 
 	_flush_cache_sigtramp = r4k_flush_cache_sigtramp;
-	_flush_icache_range = r4k_flush_icache_range;	/* Ouch */
 	if ((read_c0_prid() & 0xfff0) == 0x2020) {
 		_flush_cache_sigtramp = r4600v20k_flush_cache_sigtramp;
 	}
+	_flush_icache_range = r4k_flush_icache_range;	/* Ouch */
 
 	__flush_cache_all();
 }
diff -up --recursive --new-file linux-mips-2.4.20-pre6-20030107.macro/arch/mips64/mm/c-r4k.c linux-mips-2.4.20-pre6-20030107/arch/mips64/mm/c-r4k.c
--- linux-mips-2.4.20-pre6-20030107.macro/arch/mips64/mm/c-r4k.c	2002-12-20 03:56:52.000000000 +0000
+++ linux-mips-2.4.20-pre6-20030107/arch/mips64/mm/c-r4k.c	2003-01-09 23:21:39.000000000 +0000
@@ -950,7 +950,7 @@ static void r4k_dma_cache_wback_inv_pc(u
 	unsigned long end, a;
 
 	if (size >= dcache_size) {
-		flush_cache_l1();
+		flush_cache_all();
 	} else {
 #ifdef R4600_V2_HIT_CACHEOP_WAR
 		unsigned long flags;
@@ -963,7 +963,7 @@ static void r4k_dma_cache_wback_inv_pc(u
 		a = addr & ~(dc_lsize - 1);
 		end = (addr + size - 1) & ~(dc_lsize - 1);
 		while (1) {
-			flush_dcache_line(a); /* Hit_Writeback_Inv_D */
+			flush_dcache_line(a);	/* Hit_Writeback_Inv_D */
 			if (a == end) break;
 			a += dc_lsize;
 		}
@@ -971,6 +971,7 @@ static void r4k_dma_cache_wback_inv_pc(u
 		local_irq_restore(flags);
 #endif
 	}
+
 	bc_wback_inv(addr, size);
 }
 
@@ -979,7 +980,7 @@ static void r4k_dma_cache_wback_inv_sc(u
 	unsigned long end, a;
 
 	if (size >= scache_size) {
-		flush_cache_l1();
+		flush_cache_all();
 		return;
 	}
 
@@ -997,7 +998,7 @@ static void r4k_dma_cache_inv_pc(unsigne
 	unsigned long end, a;
 
 	if (size >= dcache_size) {
-		flush_cache_l1();
+		flush_cache_all();
 	} else {
 #ifdef R4600_V2_HIT_CACHEOP_WAR
 		unsigned long flags;
@@ -1010,7 +1011,7 @@ static void r4k_dma_cache_inv_pc(unsigne
 		a = addr & ~(dc_lsize - 1);
 		end = (addr + size - 1) & ~(dc_lsize - 1);
 		while (1) {
-			flush_dcache_line(a); /* Hit_Writeback_Inv_D */
+			flush_dcache_line(a);	/* Hit_Writeback_Inv_D */
 			if (a == end) break;
 			a += dc_lsize;
 		}
@@ -1027,14 +1028,14 @@ static void r4k_dma_cache_inv_sc(unsigne
 	unsigned long end, a;
 
 	if (size >= scache_size) {
-		flush_cache_l1();
+		flush_cache_all();
 		return;
 	}
 
 	a = addr & ~(sc_lsize - 1);
 	end = (addr + size - 1) & ~(sc_lsize - 1);
 	while (1) {
-		flush_scache_line(a); /* Hit_Writeback_Inv_SD */
+		flush_scache_line(a);	/* Hit_Writeback_Inv_SD */
 		if (a == end) break;
 		a += sc_lsize;
 	}
@@ -1241,9 +1242,10 @@ static void __init setup_noscache_funcs(
 		_flush_cache_page = r4k_flush_cache_page_d32i32;
 		break;
 	}
-
 	_flush_icache_page = r4k_flush_icache_page_p;
 
+	___flush_cache_all = _flush_cache_all;
+
 	_dma_cache_wback_inv = r4k_dma_cache_wback_inv_pc;
 	_dma_cache_wback = r4k_dma_cache_wback_inv_pc;
 	_dma_cache_inv = r4k_dma_cache_inv_pc;
@@ -1333,6 +1335,9 @@ static void __init setup_scache_funcs(vo
 		break;
 	}
 	_flush_icache_page = r4k_flush_icache_page_s;
+
+	___flush_cache_all = _flush_cache_all;
+
 	_dma_cache_wback_inv = r4k_dma_cache_wback_inv_sc;
 	_dma_cache_wback = r4k_dma_cache_wback_inv_sc;
 	_dma_cache_inv = r4k_dma_cache_inv_sc;
@@ -1394,5 +1399,5 @@ void __init ld_mmu_r4xx0(void)
 
 	_flush_cache_l2 = r4k_flush_cache_l2;
 
-	flush_cache_l1();
+	__flush_cache_all();
 }
