Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Feb 2008 00:44:02 +0000 (GMT)
Received: from relay01.mx.bawue.net ([193.7.176.67]:45282 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S28593102AbYB2AoA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 29 Feb 2008 00:44:00 +0000
Received: from lagash (88-106-132-201.dynamic.dsl.as9105.com [88.106.132.201])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by relay01.mx.bawue.net (Postfix) with ESMTP id 5434448916;
	Fri, 29 Feb 2008 01:43:54 +0100 (CET)
Received: from ths by lagash with local (Exim 4.69)
	(envelope-from <ths@networkno.de>)
	id 1JUtLo-0002QV-0k; Fri, 29 Feb 2008 00:43:48 +0000
Date:	Fri, 29 Feb 2008 00:43:47 +0000
From:	Thiemo Seufer <ths@networkno.de>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Fix typo in comment
Message-ID: <20080229004347.GA18731@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18322
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Fix a typo, we support now other page sizes as well.


Signed-off-by: Thiemo Seufer <ths@networkno.de>

Index: linux.git/arch/mips/mm/tlb-r4k.c
===================================================================
--- linux.git.orig/arch/mips/mm/tlb-r4k.c	2008-02-27 02:41:03.000000000 +0000
+++ linux.git/arch/mips/mm/tlb-r4k.c	2008-02-27 02:41:56.000000000 +0000
@@ -473,7 +473,7 @@
 	 *   - On R4600 1.7 the tlbp never hits for pages smaller than
 	 *     the value in the c0_pagemask register.
 	 *   - The entire mm handling assumes the c0_pagemask register to
-	 *     be set for 4kb pages.
+	 *     be set to fixed-size pages.
 	 */
 	probe_tlb(config);
 	write_c0_pagemask(PM_DEFAULT_MASK);
