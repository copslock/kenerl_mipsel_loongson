Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Mar 2003 00:54:54 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:6533 "EHLO
	neno.mitica") by linux-mips.org with ESMTP id <S8225201AbTC1Axm>;
	Fri, 28 Mar 2003 00:53:42 +0000
Received: by neno.mitica (Postfix, from userid 501)
	id 13E4E46BA6; Fri, 28 Mar 2003 01:52:14 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: [PATCH]: c-r4k.c 3/7 flush_cache_sigtramp cleanup
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: Fri, 28 Mar 2003 01:52:14 +0100
Message-ID: <m2u1do9utd.fsf@neno.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1844
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi
	we _always_ know what version of sigtramp we need to call, 
	just made it explicit. As an added bonus, we only pay penalizations
	now on the buggy cpus (aka 4600).

Later, Juan.


 build/arch/mips/mm/c-r4k.c |   31 +++++++++++++++++++------------
 1 files changed, 19 insertions(+), 12 deletions(-)

diff -puN build/arch/mips/mm/c-r4k.c~c-r4k_sigtramp build/arch/mips/mm/c-r4k.c
--- 24/build/arch/mips/mm/c-r4k.c~c-r4k_sigtramp	2003-03-28 00:41:17.000000000 +0100
+++ 24-quintela/build/arch/mips/mm/c-r4k.c	2003-03-28 00:43:42.000000000 +0100
@@ -531,22 +531,25 @@ static void r4k_dma_cache_inv_sc(unsigne
  */
 static void r4k_flush_cache_sigtramp(unsigned long addr)
 {
+	protected_writeback_dcache_line(addr & ~(dc_lsize - 1));
+	protected_flush_icache_line(addr & ~(ic_lsize - 1));
+}
+
+static void r4600v17_flush_cache_sigtramp(unsigned long addr)
+{
 #ifdef R4600_V1_HIT_DCACHE_WAR
 	unsigned long flags;
 
 	local_irq_save(flags);
 	__asm__ __volatile__("nop;nop;nop;nop");
 #endif
-
-	protected_writeback_dcache_line(addr & ~(dc_lsize - 1));
-	protected_flush_icache_line(addr & ~(ic_lsize - 1));
-
+	r4k_flush_cache_sigtramp(addr);
 #ifdef R4600_V1_HIT_DCACHE_WAR
 	local_irq_restore(flags);
 #endif
 }
 
-static void r4600v20k_flush_cache_sigtramp(unsigned long addr)
+static void r4600v20_flush_cache_sigtramp(unsigned long addr)
 {
 #ifdef R4600_V2_HIT_CACHEOP_WAR
 	unsigned long flags;
@@ -556,10 +559,7 @@ static void r4600v20k_flush_cache_sigtra
 	/* Clear internal cache refill buffer */
 	*(volatile unsigned int *)KSEG1;
 #endif
-
-	protected_writeback_dcache_line(addr & ~(dc_lsize - 1));
-	protected_flush_icache_line(addr & ~(ic_lsize - 1));
-
+	r4k_flush_cache_sigtramp(addr);
 #ifdef R4600_V2_HIT_CACHEOP_WAR
 	local_irq_restore(flags);
 #endif
@@ -810,9 +810,16 @@ void __init ld_mmu_r4xx0(void)
 	}
 
 	_flush_dcache_page = r4k_flush_dcache_page;
-	_flush_cache_sigtramp = r4k_flush_cache_sigtramp;
-	if ((read_c0_prid() & 0xfff0) == 0x2020) {
-		_flush_cache_sigtramp = r4600v20k_flush_cache_sigtramp;
+
+	switch(read_c0_prid() & 0xfff0) {
+	case 0x2010:
+		_flush_cache_sigtramp = r4600v17_flush_cache_sigtramp;
+		break;
+	case 0x2020:
+		_flush_cache_sigtramp = r4600v20_flush_cache_sigtramp;
+		break;
+	default:
+		_flush_cache_sigtramp = r4k_flush_cache_sigtramp;
 	}
 	_flush_icache_range = r4k_flush_icache_range;	/* Ouch */
 

_


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
