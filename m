Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Feb 2007 01:35:38 +0000 (GMT)
Received: from [66.201.51.66] ([66.201.51.66]:14872 "EHLO ripper.onstor.net")
	by ftp.linux-mips.org with ESMTP id S20039649AbXBJBfd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 10 Feb 2007 01:35:33 +0000
Received: from andys by ripper.onstor.net with local (Exim 4.63)
	(envelope-from <andy.sharp@onstor.com>)
	id 1HFh9E-0003dP-29
	for linux-mips@linux-mips.org; Fri, 09 Feb 2007 17:35:28 -0800
Date:	Fri, 9 Feb 2007 17:35:28 -0800
From:	tigerand@gmail.com
To:	linux-mips@linux-mips.org
Subject: [PATCH] try#2 Fix non-SMP build Sibyte 1250 SOC, kernel linux-mips.git master
Message-ID: <20070210013521.GA13917@onstor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <andy.sharp@onstor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14019
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tigerand@gmail.com
Precedence: bulk
X-list: linux-mips

	Try #2, sorry, first patch was reversed.

    	Fix build of non-SMP for Sibyte 1250 SOC
    
    Signed-off-by: Andrew Sharp <tigerand@gmail.com>

diff --git a/arch/mips/mm/c-sb1.c b/arch/mips/mm/c-sb1.c
index 3a8afd4..9ea460b 100644
--- a/arch/mips/mm/c-sb1.c
+++ b/arch/mips/mm/c-sb1.c
@@ -259,6 +259,12 @@ static void sb1_flush_cache_data_page(unsigned long addr)
 		on_each_cpu(sb1_flush_cache_data_page_ipi, (void *) addr, 1, 1);
 }
 #else
+
+static void local_sb1_flush_cache_data_page(unsigned long addr)
+{
+	__sb1_writeback_inv_dcache_range(addr, addr + PAGE_SIZE);
+}
+
 void sb1_flush_cache_data_page(unsigned long)
 	__attribute__((alias("local_sb1_flush_cache_data_page")));
 #endif
