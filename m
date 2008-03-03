Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Mar 2008 12:52:37 +0000 (GMT)
Received: from relay01.mx.bawue.net ([193.7.176.67]:45245 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S28601036AbYCCMwe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 3 Mar 2008 12:52:34 +0000
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by relay01.mx.bawue.net (Postfix) with ESMTP id EC22348918;
	Mon,  3 Mar 2008 13:52:28 +0100 (CET)
Received: from ths by lagash with local (Exim 4.69)
	(envelope-from <ths@networkno.de>)
	id 1JWA9c-0006dX-4M; Mon, 03 Mar 2008 12:52:28 +0000
Date:	Mon, 3 Mar 2008 12:52:28 +0000
From:	Thiemo Seufer <ths@networkno.de>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: [PATCH] Fix PIO IDE on Broadcom SWARM
Message-ID: <20080303125228.GD25396@networkno.de>
References: <20080229013017.GB18731@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080229013017.GB18731@networkno.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18328
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

This patch marks pages tainted by PIO IDE as dirty, instead of trying
to flush them right away. This

a) fixes PIO IDE for systems without dcache aliases (which lacked
   the necessary cache flush so far)
b) improves performance a bit, since some pages may never need a
   cache flush
c) obsoletes local_flush_data_cache_page


Signed-off-by: Thiemo Seufer <ths@networkno.de>
---

Changed to avoid some compiler warnings.


Index: linux.git/include/asm-mips/mach-generic/ide.h
===================================================================
--- linux.git.orig/include/asm-mips/mach-generic/ide.h	2008-03-02 20:15:24.000000000 +0000
+++ linux.git/include/asm-mips/mach-generic/ide.h	2008-03-02 21:52:46.000000000 +0000
@@ -107,107 +107,66 @@
 #endif
 
 /* MIPS port and memory-mapped I/O string operations.  */
-static inline void __ide_flush_prologue(void)
+static inline void __ide_set_pages_dirty(const void *addr, unsigned long size)
 {
-#ifdef CONFIG_SMP
-	if (cpu_has_dc_aliases)
-		preempt_disable();
-#endif
-}
+	unsigned long end = (unsigned long)addr + size;
 
-static inline void __ide_flush_epilogue(void)
-{
-#ifdef CONFIG_SMP
-	if (cpu_has_dc_aliases)
-		preempt_enable();
-#endif
-}
-
-static inline void __ide_flush_dcache_range(unsigned long addr, unsigned long size)
-{
-	if (cpu_has_dc_aliases) {
-		unsigned long end = addr + size;
-
-		while (addr < end) {
-			local_flush_data_cache_page((void *)addr);
-			addr += PAGE_SIZE;
-		}
+	while ((unsigned long)addr < end) {
+		SetPageDcacheDirty(virt_to_page(addr));
+		addr += PAGE_SIZE;
 	}
 }
 
-/*
- * insw() and gang might be called with interrupts disabled, so we can't
- * send IPIs for flushing due to the potencial of deadlocks, see the comment
- * above smp_call_function() in arch/mips/kernel/smp.c.  We work around the
- * problem by disabling preemption so we know we actually perform the flush
- * on the processor that actually has the lines to be flushed which hopefully
- * is even better for performance anyway.
- */
 static inline void __ide_insw(unsigned long port, void *addr,
 	unsigned int count)
 {
-	__ide_flush_prologue();
 	insw(port, addr, count);
-	__ide_flush_dcache_range((unsigned long)addr, count * 2);
-	__ide_flush_epilogue();
+	__ide_set_pages_dirty(addr, count * 2);
 }
 
-static inline void __ide_insl(unsigned long port, void *addr, unsigned int count)
+static inline void __ide_insl(unsigned long port, void *addr,
+	unsigned int count)
 {
-	__ide_flush_prologue();
 	insl(port, addr, count);
-	__ide_flush_dcache_range((unsigned long)addr, count * 4);
-	__ide_flush_epilogue();
+	__ide_set_pages_dirty(addr, count * 4);
 }
 
 static inline void __ide_outsw(unsigned long port, const void *addr,
 	unsigned long count)
 {
-	__ide_flush_prologue();
 	outsw(port, addr, count);
-	__ide_flush_dcache_range((unsigned long)addr, count * 2);
-	__ide_flush_epilogue();
+	__ide_set_pages_dirty(addr, count * 2);
 }
 
 static inline void __ide_outsl(unsigned long port, const void *addr,
 	unsigned long count)
 {
-	__ide_flush_prologue();
 	outsl(port, addr, count);
-	__ide_flush_dcache_range((unsigned long)addr, count * 4);
-	__ide_flush_epilogue();
+	__ide_set_pages_dirty(addr, count * 4);
 }
 
 static inline void __ide_mm_insw(void __iomem *port, void *addr, u32 count)
 {
-	__ide_flush_prologue();
 	readsw(port, addr, count);
-	__ide_flush_dcache_range((unsigned long)addr, count * 2);
-	__ide_flush_epilogue();
+	__ide_set_pages_dirty(addr, count * 2);
 }
 
 static inline void __ide_mm_insl(void __iomem *port, void *addr, u32 count)
 {
-	__ide_flush_prologue();
 	readsl(port, addr, count);
-	__ide_flush_dcache_range((unsigned long)addr, count * 4);
-	__ide_flush_epilogue();
+	__ide_set_pages_dirty(addr, count * 4);
 }
 
 static inline void __ide_mm_outsw(void __iomem *port, void *addr, u32 count)
 {
-	__ide_flush_prologue();
 	writesw(port, addr, count);
-	__ide_flush_dcache_range((unsigned long)addr, count * 2);
-	__ide_flush_epilogue();
+	__ide_set_pages_dirty(addr, count * 2);
 }
 
 static inline void __ide_mm_outsl(void __iomem * port, void *addr, u32 count)
 {
-	__ide_flush_prologue();
 	writesl(port, addr, count);
-	__ide_flush_dcache_range((unsigned long)addr, count * 4);
-	__ide_flush_epilogue();
+	__ide_set_pages_dirty(addr, count * 4);
 }
 
 /* ide_insw calls insw, not __ide_insw.  Why? */
Index: linux.git/arch/mips/mm/c-r3k.c
===================================================================
--- linux.git.orig/arch/mips/mm/c-r3k.c	2008-03-02 20:15:24.000000000 +0000
+++ linux.git/arch/mips/mm/c-r3k.c	2008-03-02 21:42:33.000000000 +0000
@@ -266,10 +266,6 @@
 		r3k_flush_icache_range(kaddr, kaddr + PAGE_SIZE);
 }
 
-static void local_r3k_flush_data_cache_page(void *addr)
-{
-}
-
 static void r3k_flush_data_cache_page(unsigned long addr)
 {
 }
@@ -322,7 +318,6 @@
 	flush_icache_range = r3k_flush_icache_range;
 
 	flush_cache_sigtramp = r3k_flush_cache_sigtramp;
-	local_flush_data_cache_page = local_r3k_flush_data_cache_page;
 	flush_data_cache_page = r3k_flush_data_cache_page;
 
 	_dma_cache_wback_inv = r3k_dma_cache_wback_inv;
Index: linux.git/arch/mips/mm/c-r4k.c
===================================================================
--- linux.git.orig/arch/mips/mm/c-r4k.c	2008-03-02 21:33:29.000000000 +0000
+++ linux.git/arch/mips/mm/c-r4k.c	2008-03-02 21:42:33.000000000 +0000
@@ -1296,7 +1296,6 @@
 
 	flush_cache_sigtramp	= r4k_flush_cache_sigtramp;
 	flush_icache_all	= r4k_flush_icache_all;
-	local_flush_data_cache_page	= local_r4k_flush_data_cache_page;
 	flush_data_cache_page	= r4k_flush_data_cache_page;
 	flush_icache_range	= r4k_flush_icache_range;
 
Index: linux.git/arch/mips/mm/c-tx39.c
===================================================================
--- linux.git.orig/arch/mips/mm/c-tx39.c	2008-03-02 20:15:24.000000000 +0000
+++ linux.git/arch/mips/mm/c-tx39.c	2008-03-02 21:42:33.000000000 +0000
@@ -210,11 +210,6 @@
 		tx39_blast_icache_page_indexed(page);
 }
 
-static void local_tx39_flush_data_cache_page(void * addr)
-{
-	tx39_blast_dcache_page((unsigned long)addr);
-}
-
 static void tx39_flush_data_cache_page(unsigned long addr)
 {
 	tx39_blast_dcache_page(addr);
@@ -352,7 +347,6 @@
 		flush_icache_range	= (void *) tx39h_flush_icache_all;
 
 		flush_cache_sigtramp	= (void *) tx39h_flush_icache_all;
-		local_flush_data_cache_page	= (void *) tx39h_flush_icache_all;
 		flush_data_cache_page	= (void *) tx39h_flush_icache_all;
 
 		_dma_cache_wback_inv	= tx39h_dma_cache_wback_inv;
@@ -377,7 +371,6 @@
 		flush_icache_range = tx39_flush_icache_range;
 
 		flush_cache_sigtramp = tx39_flush_cache_sigtramp;
-		local_flush_data_cache_page = local_tx39_flush_data_cache_page;
 		flush_data_cache_page = tx39_flush_data_cache_page;
 
 		_dma_cache_wback_inv = tx39_dma_cache_wback_inv;
Index: linux.git/arch/mips/mm/cache.c
===================================================================
--- linux.git.orig/arch/mips/mm/cache.c	2008-03-02 20:15:24.000000000 +0000
+++ linux.git/arch/mips/mm/cache.c	2008-03-02 21:42:33.000000000 +0000
@@ -32,11 +32,9 @@
 
 /* MIPS specific cache operations */
 void (*flush_cache_sigtramp)(unsigned long addr);
-void (*local_flush_data_cache_page)(void * addr);
 void (*flush_data_cache_page)(unsigned long addr);
 void (*flush_icache_all)(void);
 
-EXPORT_SYMBOL_GPL(local_flush_data_cache_page);
 EXPORT_SYMBOL(flush_data_cache_page);
 
 #ifdef CONFIG_DMA_NONCOHERENT
Index: linux.git/include/asm-mips/cacheflush.h
===================================================================
--- linux.git.orig/include/asm-mips/cacheflush.h	2008-03-02 20:15:24.000000000 +0000
+++ linux.git/include/asm-mips/cacheflush.h	2008-03-02 21:42:33.000000000 +0000
@@ -76,7 +76,6 @@
 
 extern void (*flush_cache_sigtramp)(unsigned long addr);
 extern void (*flush_icache_all)(void);
-extern void (*local_flush_data_cache_page)(void * addr);
 extern void (*flush_data_cache_page)(unsigned long addr);
 
 /*
