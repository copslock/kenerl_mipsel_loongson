Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6ELDaRw015287
	for <linux-mips-outgoing@oss.sgi.com>; Sun, 14 Jul 2002 14:13:36 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6ELDajk015286
	for linux-mips-outgoing; Sun, 14 Jul 2002 14:13:36 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from laposte.enst-bretagne.fr (laposte.enst-bretagne.fr [192.108.115.3])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6ELCvRw015257;
	Sun, 14 Jul 2002 14:12:58 -0700
Received: from resel.enst-bretagne.fr (UNKNOWN@maisel-gw.enst-bretagne.fr [192.44.76.8])
	by laposte.enst-bretagne.fr (8.11.6/8.11.6) with ESMTP id g6ELHdC12699;
	Sun, 14 Jul 2002 23:17:39 +0200
Received: from melkor (mail@melkor.maisel.enst-bretagne.fr [172.16.20.65])
	by resel.enst-bretagne.fr (8.12.3/8.12.3/Debian -4) with ESMTP id g6ELHdTF021495;
	Sun, 14 Jul 2002 23:17:39 +0200
Received: from glaurung (helo=localhost)
	by melkor with local-esmtp (Exim 3.35 #1 (Debian))
	id 17TqkN-0002hN-00; Sun, 14 Jul 2002 23:17:39 +0200
Date: Sun, 14 Jul 2002 23:17:39 +0200 (CEST)
From: Vivien Chappelier <vivien.chappelier@enst-bretagne.fr>
X-Sender: glaurung@melkor
To: Ralf Baechle <ralf@oss.sgi.com>
cc: linux-mips@oss.sgi.com
Subject: [2.5 PATCH] R10K DMA cache flushing routines for non-coherent systems
Message-ID: <Pine.LNX.4.21.0207142313170.8659-100000@melkor>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: by amavisd-milter (http://amavis.org/) at enst-bretagne.fr
X-Spam-Status: No, hits=-5.0 required=5.0 tests=UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

	This patch adds support for DMA cache flushing for the R10000
processor on non-coherent systems (Indy and O2).

Vivien.

================================================================================

--- linux/arch/mips64/mm/andes.c	Mon Jul  8 22:26:10 2002
+++ linux.patch/arch/mips64/mm/andes.c	Sun Jul  7 14:48:26 2002
@@ -11,13 +11,17 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
+#include <asm/io.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
-#include <asm/r10kcache.h>
 #include <asm/system.h>
 #include <asm/mmu_context.h>
 
-static int scache_lsz64;
+/* Secondary cache parameters. */
+static unsigned int scache_size, sc_lsize;	/* Again, in bytes */
+
+#include <asm/r10kcache.h>
+
 
 /*
  * This version has been tuned on an Origin.  For other machines the arguments
@@ -98,7 +102,7 @@
  */
 static void andes_flush_cache_l2(void)
 {
-	switch (sc_lsize()) {
+	switch (sc_lsize) {
 		case 64:
 			blast_scache64();
 			break;
@@ -111,13 +115,96 @@
 	}
 }
 
+static void
+andes_flush_cache_all(void)
+{
+	andes_flush_cache_l1();
+	andes_flush_cache_l2();
+}
+
 void
 andes_flush_icache_page(unsigned long page)
 {
-	if (scache_lsz64)
-		blast_scache64_page(page);
-	else
-		blast_scache128_page(page);
+	switch (sc_lsize) {
+		case 64:
+			blast_scache64_page(page);
+			break;
+		case 128:
+			blast_scache128_page(page);
+			break;
+		default:
+			printk(KERN_EMERG "Unknown L2 line size\n");
+			while(1);
+	}
+}
+
+/*
+ * Writeback and invalidate the cache before DMA.
+ */
+
+static void andes_dma_cache_wback_inv(unsigned long addr, unsigned long size)
+{
+	unsigned long end, a;
+
+
+	if (size >= (unsigned long)dcache_size) {
+		flush_cache_l1();
+	} else {
+		a = addr & ~((unsigned long)dc_lsize - 1);
+		end = (addr + size) & ~((unsigned long)dc_lsize - 1);
+		while (1) {
+			flush_dcache_line(a); /* Hit_Writeback_Inv_D */
+			if (a == end) break;
+			a += dc_lsize;
+		}
+	}
+
+	if (size >= (unsigned long)scache_size) {
+		flush_cache_l2();
+	} else {
+		a = addr & ~((unsigned long) sc_lsize - 1);
+		end = (addr + size) & ~((unsigned long) sc_lsize - 1);
+		while (1) {
+			flush_scache_line(a);	/* Hit_Writeback_Inv_S */
+			if (a == end) break;
+			a += sc_lsize;
+		}
+	}
+}
+
+static void andes_dma_cache_inv(unsigned long addr, unsigned long size)
+{
+	unsigned long end, a;
+
+
+	if (size >= (unsigned long)dcache_size) {
+		flush_cache_l1();
+	} else {
+		a = addr & ~((unsigned long)dc_lsize - 1);
+		end = (addr + size) & ~((unsigned long)dc_lsize - 1);
+		while (1) {
+			flush_dcache_line(a); /* Hit_Writeback_Inv_D */
+			if (a == end) break;
+			a += dc_lsize;
+		}
+	}
+
+	if (size >= (unsigned long)scache_size) {
+		flush_cache_l2();
+	} else {
+		a = addr & ~((unsigned long) sc_lsize - 1);
+		end = (addr + size) & ~((unsigned long) sc_lsize - 1);
+		while (1) {
+			flush_scache_line(a);	/* Hit_Writeback_Inv_S */
+			if (a == end) break;
+			a += sc_lsize;
+		}
+	}
+}
+
+static void andes_dma_cache_wback(unsigned long addr, unsigned long size)
+{
+	panic("andes_dma_cache called - should not happen.");
 }
 
 static void
@@ -176,11 +263,9 @@
 	}
 }
 
-void local_flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
+void local_flush_tlb_range(struct mm_struct *mm, unsigned long start,
                            unsigned long end)
 {
-	struct mm_struct *mm = vma->vm_mm;
-
 	if (CPU_CONTEXT(smp_processor_id(), mm) != 0) {
 		unsigned long flags;
 		int size;
@@ -305,31 +390,28 @@
 
 void __init ld_mmu_andes(void)
 {
+	/* get secondary cache parameters */
+	scache_size = scache_size();
+	sc_lsize = sc_lsize();
+
 	printk("Primary instruction cache %dkb, linesize %d bytes\n",
 	       icache_size >> 10, ic_lsize);
 	printk("Primary data cache %dkb, linesize %d bytes\n",
 	       dcache_size >> 10, dc_lsize);
 	printk("Secondary cache sized at %ldK, linesize %ld\n",
-	       scache_size() >> 10, sc_lsize());
+	       scache_size >> 10, sc_lsize);
 
 	_clear_page = andes_clear_page;
 	_copy_page = andes_copy_page;
 
+	_flush_cache_all = andes_flush_cache_all;
 	_flush_cache_l1 = andes_flush_cache_l1;
 	_flush_cache_l2 = andes_flush_cache_l2;
 	_flush_cache_sigtramp = andes_flush_cache_sigtramp;
 
-	switch (sc_lsize()) {
-		case 64:
-			scache_lsz64 = 1;
-			break;
-		case 128:
-			scache_lsz64 = 0;
-			break;
-		default:
-			printk(KERN_EMERG "Unknown L2 line size\n");
-			while(1);
-	}
+	_dma_cache_wback_inv = andes_dma_cache_wback_inv;
+	_dma_cache_wback = andes_dma_cache_wback;
+	_dma_cache_inv = andes_dma_cache_inv;
     
 	update_mmu_cache = andes_update_mmu_cache;
