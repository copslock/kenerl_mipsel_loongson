Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Feb 2008 16:58:42 +0000 (GMT)
Received: from relay01.mx.bawue.net ([193.7.176.67]:36505 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S20025129AbYBNQ6d (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 14 Feb 2008 16:58:33 +0000
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by relay01.mx.bawue.net (Postfix) with ESMTP id 4C85E48916;
	Thu, 14 Feb 2008 17:58:27 +0100 (CET)
Received: from ths by lagash with local (Exim 4.69)
	(envelope-from <ths@networkno.de>)
	id 1JPhPl-0000hi-H2; Thu, 14 Feb 2008 16:58:25 +0000
Date:	Thu, 14 Feb 2008 16:58:25 +0000
From:	Thiemo Seufer <ths@networkno.de>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Fix build failure for 64-bit SB-1 kernels
Message-ID: <20080214165825.GE29497@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18226
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Fix type mismatch warnings for 64-bit kernel builds which trigger -Werror.
The problem affects only SB-1 kernels with CONFIG_SIBYTE_DMA_PAGEOPS enabled.


Signed-off-by: Thiemo Seufer <ths@networkno.de>
---

Index: linux.git/arch/mips/mm/pg-sb1.c
===================================================================
--- linux.git.orig/arch/mips/mm/pg-sb1.c	2008-02-12 00:14:34.000000000 +0000
+++ linux.git/arch/mips/mm/pg-sb1.c	2008-02-12 00:29:36.000000000 +0000
@@ -216,7 +216,7 @@
 	int i;
 
 	for (i = 0; i < DM_NUM_CHANNELS; i++) {
-		const u64 base_val = CPHYSADDR(&page_descr[i]) |
+		const u64 base_val = CPHYSADDR((unsigned long)&page_descr[i]) |
 				     V_DM_DSCR_BASE_RINGSZ(1);
 		void *base_reg = IOADDR(A_DM_REGISTER(i, R_DM_DSCR_BASE));
 
@@ -228,11 +228,11 @@
 
 void clear_page(void *page)
 {
-	u64 to_phys = CPHYSADDR(page);
+	u64 to_phys = CPHYSADDR((unsigned long)page);
 	unsigned int cpu = smp_processor_id();
 
 	/* if the page is not in KSEG0, use old way */
-	if ((long)KSEGX(page) != (long)CKSEG0)
+	if ((long)KSEGX((unsigned long)page) != (long)CKSEG0)
 		return clear_page_cpu(page);
 
 	page_descr[cpu].dscr_a = to_phys | M_DM_DSCRA_ZERO_MEM |
@@ -252,13 +252,13 @@
 
 void copy_page(void *to, void *from)
 {
-	u64 from_phys = CPHYSADDR(from);
-	u64 to_phys = CPHYSADDR(to);
+	u64 from_phys = CPHYSADDR((unsigned long)from);
+	u64 to_phys = CPHYSADDR((unsigned long)to);
 	unsigned int cpu = smp_processor_id();
 
 	/* if any page is not in KSEG0, use old way */
-	if ((long)KSEGX(to) != (long)CKSEG0
-	    || (long)KSEGX(from) != (long)CKSEG0)
+	if ((long)KSEGX((unsigned long)to) != (long)CKSEG0
+	    || (long)KSEGX((unsigned long)from) != (long)CKSEG0)
 		return copy_page_cpu(to, from);
 
 	page_descr[cpu].dscr_a = to_phys | M_DM_DSCRA_L2C_DEST |
