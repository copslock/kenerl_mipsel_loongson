Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Mar 2003 00:55:15 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:7045 "EHLO
	neno.mitica") by linux-mips.org with ESMTP id <S8225204AbTC1Axs>;
	Fri, 28 Mar 2003 00:53:48 +0000
Received: by neno.mitica (Postfix, from userid 501)
	id ECDC646BA6; Fri, 28 Mar 2003 01:52:19 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: [PATCH]: c-r4k.c 4/7 flush_cache_mm cleanup
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: Fri, 28 Mar 2003 01:52:19 +0100
Message-ID: <m2smt89ut8.fsf@neno.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1845
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi
	flush_cache_mm can use __flush_cache_all.

Later, Juan.


 build/arch/mips/mm/c-r4k.c |   18 +++++-------------
 1 files changed, 5 insertions(+), 13 deletions(-)

diff -puN build/arch/mips/mm/c-r4k.c~c-r4k_flush_cache_mm build/arch/mips/mm/c-r4k.c
--- 24/build/arch/mips/mm/c-r4k.c~c-r4k_flush_cache_mm	2003-03-28 00:54:48.000000000 +0100
+++ 24-quintela/build/arch/mips/mm/c-r4k.c	2003-03-28 00:57:35.000000000 +0100
@@ -255,18 +255,10 @@ static void r4k_flush_cache_range(struct
  * the cache created only by a certain context, but on the MIPS
  * (and actually certain Sparc's) we cannot.
  */
-static void r4k_flush_scache_mm(struct mm_struct *mm)
+static void r4k_flush_cache_mm(struct mm_struct *mm)
 {
-	if (cpu_context(smp_processor_id(), mm) != 0) {
-		r4k_flush_scache_all();
-	}
-}
-
-static void r4k_flush_pcache_mm(struct mm_struct *mm)
-{
-	if (cpu_context(smp_processor_id(), mm) != 0) {
-		r4k_flush_pcache_all();
-	}
+	if (cpu_context(smp_processor_id(), mm) != 0)
+		__flush_cache_all();
 }
 
 static void r4k_flush_cache_page(struct vm_area_struct *vma,
@@ -709,7 +701,7 @@ static void __init setup_noscache_funcs(
 	}
 	_flush_cache_all = r4k_flush_pcache_all;
 	___flush_cache_all = r4k_flush_pcache_all;
-	_flush_cache_mm = r4k_flush_pcache_mm;
+	_flush_cache_mm = r4k_flush_cache_mm;
 	_flush_cache_page = r4k_flush_cache_page;
 	_flush_icache_page = r4k_flush_icache_page;
 	_flush_cache_range = r4k_flush_cache_range;
@@ -745,7 +737,7 @@ static void __init setup_scache_funcs(vo
 
 	_flush_cache_all = r4k_flush_pcache_all;
 	___flush_cache_all = r4k_flush_scache_all;
-	_flush_cache_mm = r4k_flush_scache_mm;
+	_flush_cache_mm = r4k_flush_cache_mm;
 	_flush_cache_range = r4k_flush_cache_range;
 	_flush_cache_page = r4k_flush_cache_page;
 	_flush_icache_page = r4k_flush_icache_page;

_

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
