Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Mar 2005 20:04:30 +0000 (GMT)
Received: from mail.alphastar.de ([IPv6:::ffff:194.59.236.179]:22021 "EHLO
	mail.alphastar.de") by linux-mips.org with ESMTP
	id <S8229674AbVCYUDd>; Fri, 25 Mar 2005 20:03:33 +0000
Received: from SNaIlmail.Peter (212.144.145.222)
          by mail.alphastar.de with MERCUR Mailserver (v4.02.28 MTIxLTIxODAtNjY2OA==)
          for <linux-mips@linux-mips.org>; Fri, 25 Mar 2005 21:01:20 +0100
Received: from Opal.Peter (pf@Opal.Peter [192.168.1.1])
	by SNaIlmail.Peter (8.12.6/8.12.6/Sendmail/Linux 2.0.32) with ESMTP id j2PK0LrO000544;
	Fri, 25 Mar 2005 21:00:22 +0100
Received: from localhost (pf@localhost)
	by Opal.Peter (8.9.3/8.9.3/Sendmail/Linux 2.2.5-15) with ESMTP id UAA00779;
	Fri, 25 Mar 2005 20:56:07 +0100
Date:	Fri, 25 Mar 2005 20:56:07 +0100 (CET)
From:	peter fuerst <pf@net.alphadv.de>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	linux-mips@linux-mips.org
Subject: [PATCH] r4k_dma_cache_inv (arch/mips/mm/c-r4k.c)
Message-ID: <Pine.LNX.4.21.0503252053060.775-100000@Opal.Peter>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Reply-To: pf@net.alphadv.de
Return-Path: <pf@net.alphadv.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7527
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pf@net.alphadv.de
Precedence: bulk
X-list: linux-mips



Hi,

here's a (long outstanding) patch, that let's `r4k_dma_cache_inv' do what
it should do, instead of being a mere copy of `r4k_dma_cache_wback_inv'.
(There really are machines, where we occasionaly can't avoid to invalidate
cache(s) :)
Please apply. Thank you.

with best regards

pf

--- snip ---------------------------------------------------------------

diff -Nau -b -B arch/mips/mm/c-r4k.c.1.107 arch/mips/mm/c-r4k.c
--- arch/mips/mm/c-r4k.c.1.107	Fri Mar 18 17:36:53 2005
+++ arch/mips/mm/c-r4k.c	Tue Mar 22 23:35:23 2005
@@ -668,32 +668,24 @@
 	if (cpu_has_subset_pcaches) {
 		unsigned long sc_lsize = current_cpu_data.scache.linesz;
 
-		if (size >= scache_size) {
-			r4k_blast_scache();
-			return;
-		}
-
 		a = addr & ~(sc_lsize - 1);
 		end = (addr + size - 1) & ~(sc_lsize - 1);
 		while (1) {
-			flush_scache_line(a);	/* Hit_Writeback_Inv_SD */
+			invalidate_scache_line(a);	/* Hit_Invalidate_SD/S */
 			if (a == end)
 				break;
 			a += sc_lsize;
 		}
 		return;
 	}
-
-	if (size >= dcache_size) {
-		r4k_blast_dcache();
-	} else {
+	{
 		unsigned long dc_lsize = current_cpu_data.dcache.linesz;
 
 		R4600_HIT_CACHEOP_WAR_IMPL;
 		a = addr & ~(dc_lsize - 1);
 		end = (addr + size - 1) & ~(dc_lsize - 1);
 		while (1) {
-			flush_dcache_line(a);	/* Hit_Writeback_Inv_D */
+			invalidate_dcache_line(a);	/* Hit_Invalidate_D */
 			if (a == end)
 				break;
 			a += dc_lsize;
