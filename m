Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Jan 2004 23:39:02 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:9460 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225269AbUAIXjB>;
	Fri, 9 Jan 2004 23:39:01 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id i09Ncv522283;
	Fri, 9 Jan 2004 15:38:57 -0800
Date: Fri, 9 Jan 2004 15:38:57 -0800
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: [PATCH] only setup kseg0 coherency after flush_cache_all ...
Message-ID: <20040109153857.I24193@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7iMSBzlTiPOCCT2k"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3893
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


The change is needed to make CONFIG_MIPS_UNCACHED work.
Otherwise you end up with accessing stale data right after
switching off cache.

If no objections, I will check it in later.

Jun


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=junk

diff -Nru arch/mips/mm/c-r4k.c.orig arch/mips/mm/c-r4k.c
--- arch/mips/mm/c-r4k.c.orig	Mon Jan  5 10:33:35 2004
+++ arch/mips/mm/c-r4k.c	Fri Jan  9 15:32:18 2004
@@ -1031,7 +1031,6 @@
 
 	probe_pcache();
 	setup_scache();
-	coherency_setup();
 
 	if (c->dcache.sets * c->dcache.ways > PAGE_SIZE)
 		c->dcache.flags |= MIPS_CACHE_ALIASES;
@@ -1073,6 +1072,7 @@
 #endif
 
 	__flush_cache_all();
+	coherency_setup();
 
 	build_clear_page();
 	build_copy_page();

--7iMSBzlTiPOCCT2k--
