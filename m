Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Mar 2003 00:56:15 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:8581 "EHLO
	neno.mitica") by linux-mips.org with ESMTP id <S8225196AbTC1AyN>;
	Fri, 28 Mar 2003 00:54:13 +0000
Received: by neno.mitica (Postfix, from userid 501)
	id 6D57346BA6; Fri, 28 Mar 2003 01:52:45 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: [PATCH]: c-r4k.c 7/7 minor cleanups
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: Fri, 28 Mar 2003 01:52:45 +0100
Message-ID: <m2n0jg9usi.fsf@neno.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1848
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi
	- No need to test for a WAR when we _know_ that the WAR is there.
	- Use the pcache function already defined.

Later, Juan.


 build/arch/mips/mm/c-r4k.c |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff -puN build/arch/mips/mm/c-r4k.c~c-r4k_minor_cleanups build/arch/mips/mm/c-r4k.c
--- 24/build/arch/mips/mm/c-r4k.c~c-r4k_minor_cleanups	2003-03-28 01:23:29.000000000 +0100
+++ 24-quintela/build/arch/mips/mm/c-r4k.c	2003-03-28 01:25:10.000000000 +0100
@@ -59,17 +59,13 @@ dc_32:
 	return;
 
 dc_32_r4600:
-#ifdef R4600_V1_HIT_DCACHE_WAR
 	{
 	unsigned long flags;
 
 	local_irq_save(flags);
 	__asm__ __volatile__("nop;nop;nop;nop");
-#endif
 	blast_dcache32_page(addr);
-#ifdef R4600_V1_HIT_DCACHE_WAR
 	local_irq_restore(flags);
-#endif
 	return;
 	}
 
@@ -287,10 +283,8 @@ static inline void r4k_flush_pcache_all(
 static void r4k_flush_cache_range(struct mm_struct *mm,
 	unsigned long start, unsigned long end)
 {
-	if (cpu_context(smp_processor_id(), mm) != 0) {
-		r4k_blast_dcache();
-		r4k_blast_icache();
-	}
+	if (cpu_context(smp_processor_id(), mm) != 0)
+		r4k_flush_pcache_all();
 }
 
 /*

_

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
