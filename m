Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Dec 2002 19:18:12 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:38021 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8225541AbSLTTSL>;
	Fri, 20 Dec 2002 19:18:11 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id 4DB1FD657; Fri, 20 Dec 2002 20:24:22 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: [RFC]: Problem with caches in 64bits
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: 20 Dec 2002 20:24:22 +0100
Message-ID: <m2znr0ebo9.fsf@demo.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1032
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi
        I found at least two things that look like bugs in the
handling of the caches for r4k:

- call flush_cache_l1() when the size is bigger that the secondary
  cache, should be flush_cache_all().

- call flush_dcache_line/flush_scache_line() when the user asked for
  invalidation (i.e. not need for writeback).

Comments?

Later, Juan.


Index: arch/mips64/mm/c-r4k.c
===================================================================
RCS file: /home/cvs/linux/arch/mips64/mm/c-r4k.c,v
retrieving revision 1.1.2.10
diff -u -r1.1.2.10 c-r4k.c
--- arch/mips64/mm/c-r4k.c	20 Dec 2002 03:08:32 -0000	1.1.2.10
+++ arch/mips64/mm/c-r4k.c	20 Dec 2002 19:10:45 -0000
@@ -979,7 +979,7 @@
 	unsigned long end, a;
 
 	if (size >= scache_size) {
-		flush_cache_l1();
+		flush_cache_all();
 		return;
 	}
 
@@ -1010,7 +1010,7 @@
 		a = addr & ~(dc_lsize - 1);
 		end = (addr + size - 1) & ~(dc_lsize - 1);
 		while (1) {
-			flush_dcache_line(a); /* Hit_Writeback_Inv_D */
+			invalidate_dcache_line(a); /* Hit_Invalidate_D */
 			if (a == end) break;
 			a += dc_lsize;
 		}
@@ -1027,14 +1027,14 @@
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
+		invalidate_scache_line(a); /* Hit_Invalidate_SD */
 		if (a == end) break;
 		a += sc_lsize;
 	}
 


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
