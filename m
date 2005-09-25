Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Sep 2005 16:19:37 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:35807 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133472AbVIYPTU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 25 Sep 2005 16:19:20 +0100
Received: from localhost (p6250-ipad30funabasi.chiba.ocn.ne.jp [221.184.81.250])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 3AD2C4E9E; Mon, 26 Sep 2005 00:19:17 +0900 (JST)
Date:	Mon, 26 Sep 2005 00:17:53 +0900 (JST)
Message-Id: <20050926.001753.74752084.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: add __iomem to ioremap
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9036
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Some function like iounmap, read[bwlq], etc. have been using __iomem
attribute, but ioremap does not use it.  Here is a patch to add
__iomem to ioremap family.  This would kill some sparse warnings.


diff -ur /home/cvs/linux-mips/include/asm-mips/io.h linux/include/asm-mips/io.h
--- linux-mips/include/asm-mips/io.h	2005-09-25 00:12:39.000000000 +0900
+++ linux/include/asm-mips/io.h	2005-09-25 23:08:18.930898136 +0900
@@ -203,10 +203,10 @@
  */
 #define page_to_phys(page)	((dma_addr_t)page_to_pfn(page) << PAGE_SHIFT)
 
-extern void * __ioremap(phys_t offset, phys_t size, unsigned long flags);
+extern void __iomem * __ioremap(phys_t offset, phys_t size, unsigned long flags);
 extern void __iounmap(volatile void __iomem *addr);
 
-static inline void * __ioremap_mode(phys_t offset, unsigned long size,
+static inline void __iomem * __ioremap_mode(phys_t offset, unsigned long size,
 	unsigned long flags)
 {
 #define __IS_LOW512(addr) (!((phys_t)(addr) & (phys_t) ~0x1fffffffULL))
@@ -220,7 +220,7 @@
 		 */
 		if (flags == _CACHE_UNCACHED)
 			base = (u64) IO_BASE;
-		return (void *) (unsigned long) (base + offset);
+		return (void __iomem *) (unsigned long) (base + offset);
 	} else if (__builtin_constant_p(offset) &&
 		   __builtin_constant_p(size) && __builtin_constant_p(flags)) {
 		phys_t phys_addr, last_addr;
@@ -238,7 +238,7 @@
 		 */
 		if (__IS_LOW512(phys_addr) && __IS_LOW512(last_addr) &&
 		    flags == _CACHE_UNCACHED)
-			return (void *)CKSEG1ADDR(phys_addr);
+			return (void __iomem *)CKSEG1ADDR(phys_addr);
 
 	}
 
diff -ur linux-mips/arch/mips/mm/ioremap.c linux/arch/mips/mm/ioremap.c
--- linux-mips/arch/mips/mm/ioremap.c	2005-07-03 01:09:48.000000000 +0900
+++ linux/arch/mips/mm/ioremap.c	2005-09-25 23:09:24.944862488 +0900
@@ -117,7 +117,7 @@
 
 #define IS_LOW512(addr) (!((phys_t)(addr) & (phys_t) ~0x1fffffffULL))
 
-void * __ioremap(phys_t phys_addr, phys_t size, unsigned long flags)
+void __iomem * __ioremap(phys_t phys_addr, phys_t size, unsigned long flags)
 {
 	struct vm_struct * area;
 	unsigned long offset;
@@ -137,7 +137,7 @@
 	 */
 	if (IS_LOW512(phys_addr) && IS_LOW512(last_addr) &&
 	    flags == _CACHE_UNCACHED)
-		return (void *) CKSEG1ADDR(phys_addr);
+		return (void __iomem *) CKSEG1ADDR(phys_addr);
 
 	/*
 	 * Don't allow anybody to remap normal RAM that we're using..
@@ -173,7 +173,7 @@
 		return NULL;
 	}
 
-	return (void *) (offset + (char *)addr);
+	return (void __iomem *) (offset + (char *)addr);
 }
 
 #define IS_KSEG1(addr) (((unsigned long)(addr) & ~0x1fffffffUL) == CKSEG1)

---
Atsushi Nemoto
