Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Sep 2005 16:41:23 +0100 (BST)
Received: from mx01.qsc.de ([IPv6:::ffff:213.148.129.14]:43484 "EHLO
	mx01.qsc.de") by linux-mips.org with ESMTP id <S8225206AbVISPlD>;
	Mon, 19 Sep 2005 16:41:03 +0100
Received: from port-195-158-179-11.dynamic.qsc.de ([195.158.179.11] helo=hattusa.textio)
	by mx01.qsc.de with esmtp (Exim 3.35 #1)
	id 1EHNlJ-0007Wf-00
	for linux-mips@linux-mips.org; Mon, 19 Sep 2005 17:40:57 +0200
Received: from ths by hattusa.textio with local (Exim 4.52)
	id 1EHNlI-000360-RE
	for linux-mips@linux-mips.org; Mon, 19 Sep 2005 17:40:56 +0200
Date:	Mon, 19 Sep 2005 17:40:56 +0200
To:	linux-mips@linux-mips.org
Subject: Performance bug in c-r4k.c cache handling code
Message-ID: <20050919154056.GG3386@hattusa.textio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8976
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Hello All,

I found an performance bug in c-r4k.c:r4k_dma_cache_inv, where a
Hit_Writeback_Inv instead of Hit_Invalidate is done. Ralf mentioned
this is probably due to broken Hit_Invalidate cache ops on some
CPUs, does anybody have more information about this? The appended
patch works apparently fine on R4400, R4600v2.0, R5000.


Thiemo


Index: arch/mips/mm/c-r4k.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/c-r4k.c,v
retrieving revision 1.119
diff -u -p -r1.119 c-r4k.c
--- arch/mips/mm/c-r4k.c	9 Sep 2005 20:26:54 -0000	1.119
+++ arch/mips/mm/c-r4k.c	19 Sep 2005 15:33:35 -0000
@@ -685,7 +685,7 @@ static void r4k_dma_cache_inv(unsigned l
 		a = addr & ~(sc_lsize - 1);
 		end = (addr + size - 1) & ~(sc_lsize - 1);
 		while (1) {
-			flush_scache_line(a);	/* Hit_Writeback_Inv_SD */
+			invalidate_scache_line(a);	/* Hit_Invalidate_SD */
 			if (a == end)
 				break;
 			a += sc_lsize;
@@ -702,7 +702,7 @@ static void r4k_dma_cache_inv(unsigned l
 		a = addr & ~(dc_lsize - 1);
 		end = (addr + size - 1) & ~(dc_lsize - 1);
 		while (1) {
-			flush_dcache_line(a);	/* Hit_Writeback_Inv_D */
+			invalidate_dcache_line(a);	/* Hit_Invalidate_D */
 			if (a == end)
 				break;
 			a += dc_lsize;
