Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Mar 2003 00:55:35 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:7557 "EHLO
	neno.mitica") by linux-mips.org with ESMTP id <S8225208AbTC1AyB>;
	Fri, 28 Mar 2003 00:54:01 +0000
Received: by neno.mitica (Postfix, from userid 501)
	id A4D3746BA6; Fri, 28 Mar 2003 01:52:32 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: [PATCH]: c-r4k.c 5/7 unduplicate declarations
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: Fri, 28 Mar 2003 01:52:32 +0100
Message-ID: <m2ptoc9usv.fsf@neno.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1846
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips



Hi
	Lots of _flush_* functions are asigned the same value in the 
	case of only pcache or scache.

Later, Juan.


 build/arch/mips/mm/c-r4k.c |   20 ++++++++------------
 1 files changed, 8 insertions(+), 12 deletions(-)

diff -puN build/arch/mips/mm/c-r4k.c~c-r4k_unduplicate_repated_code build/arch/mips/mm/c-r4k.c
--- 24/build/arch/mips/mm/c-r4k.c~c-r4k_unduplicate_repated_code	2003-03-28 00:58:39.000000000 +0100
+++ 24-quintela/build/arch/mips/mm/c-r4k.c	2003-03-28 01:01:43.000000000 +0100
@@ -699,12 +699,7 @@ static void __init setup_noscache_funcs(
 		}
 		break;
 	}
-	_flush_cache_all = r4k_flush_pcache_all;
 	___flush_cache_all = r4k_flush_pcache_all;
-	_flush_cache_mm = r4k_flush_cache_mm;
-	_flush_cache_page = r4k_flush_cache_page;
-	_flush_icache_page = r4k_flush_icache_page;
-	_flush_cache_range = r4k_flush_cache_range;
 
 	_dma_cache_wback_inv = r4k_dma_cache_wback_inv_pc;
 	_dma_cache_wback = r4k_dma_cache_wback_inv_pc;
@@ -735,12 +730,7 @@ static void __init setup_scache_funcs(vo
 		break;
 	}
 
-	_flush_cache_all = r4k_flush_pcache_all;
 	___flush_cache_all = r4k_flush_scache_all;
-	_flush_cache_mm = r4k_flush_cache_mm;
-	_flush_cache_range = r4k_flush_cache_range;
-	_flush_cache_page = r4k_flush_cache_page;
-	_flush_icache_page = r4k_flush_icache_page;
 
 	_dma_cache_wback_inv = r4k_dma_cache_wback_inv_sc;
 	_dma_cache_wback = r4k_dma_cache_wback_inv_sc;
@@ -793,6 +783,14 @@ void __init ld_mmu_r4xx0(void)
 	probe_dcache(config);
 	setup_scache(config);
 
+	_flush_cache_all = r4k_flush_pcache_all;
+	_flush_cache_range = r4k_flush_cache_range;
+	_flush_icache_range = r4k_flush_icache_range;	/* Ouch */
+	_flush_cache_mm = r4k_flush_cache_mm;
+	_flush_cache_page = r4k_flush_cache_page;
+	_flush_dcache_page = r4k_flush_dcache_page;
+	_flush_icache_page = r4k_flush_icache_page;
+
 	switch(mips_cpu.cputype) {
 	case CPU_R4600:			/* QED style two way caches? */
 	case CPU_R4700:
@@ -801,7 +799,6 @@ void __init ld_mmu_r4xx0(void)
 		_flush_cache_page = r4k_flush_cache_page_r4600;
 	}
 
-	_flush_dcache_page = r4k_flush_dcache_page;
 
 	switch(read_c0_prid() & 0xfff0) {
 	case 0x2010:
@@ -813,7 +810,6 @@ void __init ld_mmu_r4xx0(void)
 	default:
 		_flush_cache_sigtramp = r4k_flush_cache_sigtramp;
 	}
-	_flush_icache_range = r4k_flush_icache_range;	/* Ouch */
 
 	__flush_cache_all();
 }

_

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
