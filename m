Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5IH4onC024075
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 18 Jun 2002 10:04:50 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5IH4oww024074
	for linux-mips-outgoing; Tue, 18 Jun 2002 10:04:50 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from ayrnetworks.com (64-166-72-141.ayrnetworks.com [64.166.72.141])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5IH4BnC024069
	for <linux-mips@oss.sgi.com>; Tue, 18 Jun 2002 10:04:11 -0700
Received: (from wjhun@localhost)
	by  ayrnetworks.com (8.11.2/8.11.2) id g5IH3l601409
	for "linux-mips@oss.sgi.com"; Tue, 18 Jun 2002 10:03:47 -0700
Date: Tue, 18 Jun 2002 10:03:47 -0700
From: William Jhun <wjhun@ayrnetworks.com>
To: "linux-mips@oss.sgi.com"@ayrnetworks.com
Subject: [PATCH] dma_cache_wback, pci DMA cache coherency changes
Message-ID: <20020618100347.A1361@ayrnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a re-hash of patches I sent out a while ago which do a more
optimal cache-flushing for pci_map_*() and pci_dma_sync_*(). It
basically does an invalidate for PCI_DMA_FROMDEVICE operations and a
writeback for PCI_DMA_TODEVICE pci_map_* (or writeback/invalidate if
PCI_DMA_BIDIRECTIONAL). This is similar to the ARM implementation.

Additionally, I filled in the _dma_cache_wback calls in the
arch/mips/c-*.c to call *_dma_cache_wback_inv* instead of calling
panic(). Some architectures could probably do a real writeback instead
of just wback_inv, but this will at least allow code that can use
writeback-only if available.

Note: I'm not familiar with a lot of these CPUs, but the change should
be innocuous. Could someone validate/improve these?

Thanks,
William

Index: include/asm/pci.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/pci.h,v
retrieving revision 1.24.2.1
diff -u -r1.24.2.1 pci.h
--- include/asm/pci.h	2002/02/26 06:00:25	1.24.2.1
+++ include/asm/pci.h	2002/06/18 16:51:30
@@ -79,7 +79,40 @@
 extern void pci_free_consistent(struct pci_dev *hwdev, size_t size,
 				void *vaddr, dma_addr_t dma_handle);
 
+#ifdef CONFIG_NONCOHERENT_IO
+/*
+ * Prepare buffer for DMA transfer
+ */
+static inline void prep_buffer(void *ptr, size_t size, int direction)
+{
+        switch(direction) {
+        case PCI_DMA_TODEVICE:
+                dma_cache_wback((unsigned long)ptr, size);
+                break;
+        case PCI_DMA_FROMDEVICE:
+                dma_cache_inv((unsigned long)ptr, size);
+                break;
+        case PCI_DMA_BIDIRECTIONAL:
+                dma_cache_wback_inv((unsigned long)ptr, size);
+                break;
+        }
+}
+
 /*
+ * Prepare buffer for CPU access after DMA transfer
+ */
+static inline void sync_buffer(void *ptr, size_t size, int direction)
+{
+        switch(direction) {
+        case PCI_DMA_FROMDEVICE:
+        case PCI_DMA_BIDIRECTIONAL:
+                dma_cache_inv((unsigned long)ptr, size);
+                break;
+        }
+}
+#endif
+
+/*
  * Map a single buffer of the indicated size for DMA in streaming mode.
  * The 32-bit bus address to use is returned.
  *
@@ -93,7 +126,7 @@
 		BUG();
 
 #ifdef CONFIG_NONCOHERENT_IO
-	dma_cache_wback_inv((unsigned long)ptr, size);
+	prep_buffer(ptr, size, direction);
 #endif
 
 	return virt_to_bus(ptr);
@@ -132,7 +165,7 @@
 	addr = (unsigned long) page_address(page);
 	addr += offset;
 #ifdef CONFIG_NONCOHERENT_IO
-	dma_cache_wback_inv(addr, size);
+	prep_buffer((void*)addr, size, direction);
 #endif
 
 	return virt_to_bus((void *)addr);
@@ -183,7 +216,7 @@
 #ifdef CONFIG_NONCOHERENT_IO
 	/* Make sure that gcc doesn't leave the empty loop body.  */
 	for (i = 0; i < nents; i++, sg++)
-		dma_cache_wback_inv((unsigned long)sg->address, sg->length);
+		prep_buffer(sg->address, sg->length, direction);
 #endif
 
 	return nents;
@@ -221,7 +254,7 @@
 		BUG();
 
 #ifdef CONFIG_NONCOHERENT_IO
-	dma_cache_wback_inv((unsigned long)bus_to_virt(dma_handle), size);
+	sync_buffer(bus_to_virt(dma_handle), size, direction);
 #endif
 }
 
@@ -246,8 +279,9 @@
 	/* Make sure that gcc doesn't leave the empty loop body.  */
 #ifdef CONFIG_NONCOHERENT_IO
 	for (i = 0; i < nelems; i++, sg++)
-		dma_cache_wback_inv((unsigned long)sg->address, sg->length);
+		sync_buffer(sg->address, sg->length, direction);
 #endif
+
 }
 
 /* Return whether the given PCI device DMA address mask can

Index: arch/mips/mm/c-mips32.c
===================================================================
RCS file: /cvs/linux/arch/mips/mm/c-mips32.c,v
retrieving revision 1.3.2.4
diff -u -r1.3.2.4 c-mips32.c
--- arch/mips/mm/c-mips32.c	2002/05/29 03:03:17	1.3.2.4
+++ arch/mips/mm/c-mips32.c	2002/06/18 16:52:21
@@ -393,12 +393,6 @@
 	}
 }
 
-static void
-mips32_dma_cache_wback(unsigned long addr, unsigned long size)
-{
-	panic("mips32_dma_cache called - should not happen.");
-}
-
 /*
  * While we're protected against bad userland addresses we don't care
  * very much about what happens in that case.  Usually a segmentation
@@ -603,7 +597,7 @@
 	_flush_icache_page = mips32_flush_icache_page;
 
 	_dma_cache_wback_inv = mips32_dma_cache_wback_inv_pc;
-	_dma_cache_wback = mips32_dma_cache_wback;
+	_dma_cache_wback = mips32_dma_cache_wback_inv_pc;
 	_dma_cache_inv = mips32_dma_cache_inv_pc;
 }
 
@@ -621,7 +615,7 @@
 	_flush_icache_page = mips32_flush_icache_page_s;
 
 	_dma_cache_wback_inv = mips32_dma_cache_wback_inv_sc;
-	_dma_cache_wback = mips32_dma_cache_wback;
+	_dma_cache_wback = mips32_dma_cache_wback_inv_sc;
 	_dma_cache_inv = mips32_dma_cache_inv_sc;
 }
 
Index: arch/mips/mm/c-r3k.c
===================================================================
RCS file: /cvs/linux/arch/mips/mm/c-r3k.c,v
retrieving revision 1.4.2.1
diff -u -r1.4.2.1 c-r3k.c
--- arch/mips/mm/c-r3k.c	2002/02/18 15:22:30	1.4.2.1
+++ arch/mips/mm/c-r3k.c	2002/06/18 16:52:21
@@ -337,7 +337,9 @@
 	_flush_icache_page = r3k_flush_icache_page;
 	_flush_icache_range = r3k_flush_icache_range;
 
+	_dma_cache_inv = r3k_dma_cache_wback_inv;
 	_dma_cache_wback_inv = r3k_dma_cache_wback_inv;
+	_dma_cache_wback = r3k_dma_cache_wback_inv;
 
 	printk("Primary instruction cache %dkb, linesize %d bytes\n",
 		(int) (icache_size >> 10), (int) icache_lsize);
Index: arch/mips/mm/c-r4k.c
===================================================================
RCS file: /cvs/linux/arch/mips/mm/c-r4k.c,v
retrieving revision 1.3.2.3
diff -u -r1.3.2.3 c-r4k.c
--- arch/mips/mm/c-r4k.c	2002/05/29 03:03:17	1.3.2.3
+++ arch/mips/mm/c-r4k.c	2002/06/18 16:52:21
@@ -1150,12 +1150,6 @@
 	}
 }
 
-static void
-r4k_dma_cache_wback(unsigned long addr, unsigned long size)
-{
-	panic("r4k_dma_cache called - should not happen.");
-}
-
 /*
  * While we're protected against bad userland addresses we don't care
  * very much about what happens in that case.  Usually a segmentation
@@ -1358,7 +1352,7 @@
 	_flush_icache_page = r4k_flush_icache_page_p;
 
 	_dma_cache_wback_inv = r4k_dma_cache_wback_inv_pc;
-	_dma_cache_wback = r4k_dma_cache_wback;
+	_dma_cache_wback = r4k_dma_cache_wback_inv_pc;
 	_dma_cache_inv = r4k_dma_cache_inv_pc;
 }
 
@@ -1441,7 +1435,7 @@
 	___flush_cache_all = _flush_cache_all;
 	_flush_icache_page = r4k_flush_icache_page_s;
 	_dma_cache_wback_inv = r4k_dma_cache_wback_inv_sc;
-	_dma_cache_wback = r4k_dma_cache_wback;
+	_dma_cache_wback = r4k_dma_cache_wback_inv_sc;
 	_dma_cache_inv = r4k_dma_cache_inv_sc;
 }
 
Index: arch/mips/mm/c-r5432.c
===================================================================
RCS file: /cvs/linux/arch/mips/mm/c-r5432.c,v
retrieving revision 1.4
diff -u -r1.4 c-r5432.c
--- arch/mips/mm/c-r5432.c	2001/11/30 13:28:06	1.4
+++ arch/mips/mm/c-r5432.c	2002/06/18 16:52:21
@@ -414,12 +414,6 @@
 	bc_inv(addr, size);
 }
 
-static void
-r5432_dma_cache_wback(unsigned long addr, unsigned long size)
-{
-	panic("r5432_dma_cache called - should not happen.");
-}
-
 /*
  * While we're protected against bad userland addresses we don't care
  * very much about what happens in that case.  Usually a segmentation
@@ -470,7 +464,7 @@
 	_flush_cache_page = r5432_flush_cache_page_d32i32;
 	_flush_icache_page = r5432_flush_icache_page_i32;
 	_dma_cache_wback_inv = r5432_dma_cache_wback_inv_pc;
-	_dma_cache_wback = r5432_dma_cache_wback;
+	_dma_cache_wback = r5432_dma_cache_wback_inv_pc;
 	_dma_cache_inv = r5432_dma_cache_inv_pc;
 
 	_flush_cache_sigtramp = r5432_flush_cache_sigtramp;
Index: arch/mips/mm/c-rm7k.c
===================================================================
RCS file: /cvs/linux/arch/mips/mm/c-rm7k.c,v
retrieving revision 1.4.2.2
diff -u -r1.4.2.2 c-rm7k.c
--- arch/mips/mm/c-rm7k.c	2002/05/29 03:03:17	1.4.2.2
+++ arch/mips/mm/c-rm7k.c	2002/06/18 16:52:21
@@ -177,12 +177,6 @@
 	}
 }
 
-static void
-rm7k_dma_cache_wback(unsigned long addr, unsigned long size)
-{
-	panic("rm7k_dma_cache_wback called - should not happen.");
-}
-
 /*
  * While we're protected against bad userland addresses we don't care
  * very much about what happens in that case.  Usually a segmentation
@@ -342,7 +336,7 @@
 	_flush_icache_page = rm7k_flush_icache_page;
 
 	_dma_cache_wback_inv = rm7k_dma_cache_wback_inv;
-	_dma_cache_wback = rm7k_dma_cache_wback;
+	_dma_cache_wback = rm7k_dma_cache_wback_inv;
 	_dma_cache_inv = rm7k_dma_cache_inv;
 
 	__flush_cache_all_d32i32();
Index: arch/mips/mm/c-tx39.c
===================================================================
RCS file: /cvs/linux/arch/mips/mm/c-tx39.c,v
retrieving revision 1.4
diff -u -r1.4 c-tx39.c
--- arch/mips/mm/c-tx39.c	2001/11/30 13:28:06	1.4
+++ arch/mips/mm/c-tx39.c	2002/06/18 16:52:21
@@ -225,11 +225,6 @@
 	}
 }
 
-static void tx39_dma_cache_wback(unsigned long addr, unsigned long size)
-{
-	panic("tx39_dma_cache called - should not happen.");
-}
-
 static void tx39_flush_cache_sigtramp(unsigned long addr)
 {
 	unsigned long config;
@@ -317,7 +312,7 @@
 		_flush_icache_range = tx39_flush_icache_range;
 
 		_dma_cache_wback_inv = tx39_dma_cache_wback_inv;
-		_dma_cache_wback = tx39_dma_cache_wback;
+		_dma_cache_wback = tx39_dma_cache_wback_inv;
 		_dma_cache_inv = tx39_dma_cache_inv;
 
 		break;
Index: arch/mips/mm/c-tx49.c
===================================================================
RCS file: /cvs/linux/arch/mips/mm/c-tx49.c,v
retrieving revision 1.3.2.1
diff -u -r1.3.2.1 c-tx49.c
--- arch/mips/mm/c-tx49.c	2002/05/29 03:03:17	1.3.2.1
+++ arch/mips/mm/c-tx49.c	2002/06/18 16:52:21
@@ -343,12 +343,6 @@
 	}
 }
 
-static void
-r4k_dma_cache_wback(unsigned long addr, unsigned long size)
-{
-	panic("r4k_dma_cache called - should not happen.");
-}
-
 /*
  * While we're protected against bad userland addresses we don't care
  * very much about what happens in that case.  Usually a segmentation
@@ -429,7 +423,7 @@
 	_flush_icache_page = r4k_flush_icache_page;
 
 	_dma_cache_wback_inv = r4k_dma_cache_wback_inv;
-	_dma_cache_wback = r4k_dma_cache_wback;
+	_dma_cache_wback = r4k_dma_cache_wback_inv;
 	_dma_cache_inv = r4k_dma_cache_inv;
 
 	_flush_cache_sigtramp = r4k_flush_cache_sigtramp;
