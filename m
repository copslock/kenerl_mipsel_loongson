Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6JGL2Rw002589
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 19 Jul 2002 09:21:02 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6JGL17f002588
	for linux-mips-outgoing; Fri, 19 Jul 2002 09:21:01 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from columba.www.eur.3com.com (ip-161-71-171-238.corp-eur.3com.com [161.71.171.238])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6JGKtRw002578
	for <linux-mips@oss.sgi.com>; Fri, 19 Jul 2002 09:20:56 -0700
Received: from toucana.eur.3com.com (toucana.EUR.3Com.COM [140.204.220.50])
	by columba.www.eur.3com.com  with ESMTP id g6JGN8Dw008191;
	Fri, 19 Jul 2002 17:23:09 +0100 (BST)
Received: from notesmta.eur.3com.com (eurmta1.EUR.3Com.COM [140.204.220.206])
	by toucana.eur.3com.com  with SMTP id g6JGM0R14222;
	Fri, 19 Jul 2002 17:22:00 +0100 (BST)
Received: by notesmta.eur.3com.com(Lotus SMTP MTA v4.6.3  (733.2 10-16-1998))  id 80256BFB.005A407A ; Fri, 19 Jul 2002 17:25:47 +0100
X-Lotus-FromDomain: 3COM
From: "Jon Burgess" <Jon_Burgess@eur.3com.com>
To: linux-mips@oss.sgi.com
cc: carstenl@mips.com
Message-ID: <80256BFB.005A3F76.00@notesmta.eur.3com.com>
Date: Fri, 19 Jul 2002 17:21:09 +0100
Subject: Mips32 icache vs dcache size typo
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, hits=-5.0 required=5.0 tests=UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk



The patch below fixes what looks like a typo on mips32_flush_icache_page() which
uses 'dcache_size' instead of 'icache_size'. The patch is part of the one sent
by Carsten and the same fix was included in a kernel supplied to us by Broadcom.
I haven't had a chance to try the rest of the patch suggested by Carsten yet,
but this looks like an important fix for processors where dcache_size !=
icache_size.

     Jon Burgess


--- arch/mips/mm/c-mips32.c~  Wed May 29 05:03:17 2002
+++ arch/mips/mm/c-mips32.c   Thu Jul 11 09:55:08 2002
@@ -303,7 +303,7 @@
     if (!(vma->vm_flags & VM_EXEC))
          return;

-    address = KSEG0 + ((unsigned long)page_address(page) & PAGE_MASK &
(dcache_size - 1));
+    address = KSEG0 + ((unsigned long)page_address(page) & PAGE_MASK &
(icache_size - 1));
     blast_icache_page_indexed(address);
 }
