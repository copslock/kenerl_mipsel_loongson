Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Nov 2007 22:42:51 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:50662 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28573743AbXKZWkS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 26 Nov 2007 22:40:18 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1Iwmch-0006QN-06; Mon, 26 Nov 2007 23:40:15 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 48CF6C2B26; Mon, 26 Nov 2007 23:40:01 +0100 (CET)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] Use real cache invalidate
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Message-Id: <20071126224001.48CF6C2B26@solo.franken.de>
Date:	Mon, 26 Nov 2007 23:40:01 +0100 (CET)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17600
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

R10k non coherent machines need a real dma cache invalidate to get
rid of speculative stores in cache.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 9355f1c..82d0d3e 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -598,7 +598,7 @@ static void r4k_dma_cache_inv(unsigned long addr, unsigned long size)
 		if (size >= scache_size)
 			r4k_blast_scache();
 		else
-			blast_scache_range(addr, addr + size);
+			blast_inv_scache_range(addr, addr + size);
 		return;
 	}
 
@@ -606,7 +606,7 @@ static void r4k_dma_cache_inv(unsigned long addr, unsigned long size)
 		r4k_blast_dcache();
 	} else {
 		R4600_HIT_CACHEOP_WAR_IMPL;
-		blast_dcache_range(addr, addr + size);
+		blast_inv_dcache_range(addr, addr + size);
 	}
 
 	bc_inv(addr, size);
diff --git a/include/asm-mips/r4kcache.h b/include/asm-mips/r4kcache.h
index 2b8466f..4c140db 100644
--- a/include/asm-mips/r4kcache.h
+++ b/include/asm-mips/r4kcache.h
@@ -403,6 +403,13 @@ __BUILD_BLAST_CACHE(i, icache, Index_Invalidate_I, Hit_Invalidate_I, 64)
 __BUILD_BLAST_CACHE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 64)
 __BUILD_BLAST_CACHE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 128)
 
+__BUILD_BLAST_CACHE(inv_d, dcache, Index_Writeback_Inv_D, Hit_Invalidate_D, 16)
+__BUILD_BLAST_CACHE(inv_d, dcache, Index_Writeback_Inv_D, Hit_Invalidate_D, 32)
+__BUILD_BLAST_CACHE(inv_s, scache, Index_Writeback_Inv_SD, Hit_Invalidate_SD, 16)
+__BUILD_BLAST_CACHE(inv_s, scache, Index_Writeback_Inv_SD, Hit_Invalidate_SD, 32)
+__BUILD_BLAST_CACHE(inv_s, scache, Index_Writeback_Inv_SD, Hit_Invalidate_SD, 64)
+__BUILD_BLAST_CACHE(inv_s, scache, Index_Writeback_Inv_SD, Hit_Invalidate_SD, 128)
+
 /* build blast_xxx_range, protected_blast_xxx_range */
 #define __BUILD_BLAST_CACHE_RANGE(pfx, desc, hitop, prot) \
 static inline void prot##blast_##pfx##cache##_range(unsigned long start, \
