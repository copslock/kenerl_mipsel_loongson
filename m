Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5JIMqnC016604
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 19 Jun 2002 11:22:52 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5JIMqD5016603
	for linux-mips-outgoing; Wed, 19 Jun 2002 11:22:52 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from ayrnetworks.com (64-166-72-141.ayrnetworks.com [64.166.72.141])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5JIMWnC016579;
	Wed, 19 Jun 2002 11:22:32 -0700
Received: (from wjhun@localhost)
	by  ayrnetworks.com (8.11.2/8.11.2) id g5JIM7v08690;
	Wed, 19 Jun 2002 11:22:07 -0700
Date: Wed, 19 Jun 2002 11:22:07 -0700
From: William Jhun <wjhun@ayrnetworks.com>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: linux-mips@oss.sgi.com
Subject: [PATCH] include/asm-mips/pci.h
Message-ID: <20020619112207.B6057@ayrnetworks.com>
References: <20020618100347.A1361@ayrnetworks.com> <20020619113933.C22048@dea.linux-mips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020619113933.C22048@dea.linux-mips.net>; from ralf@oss.sgi.com on Wed, Jun 19, 2002 at 11:39:33AM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jun 19, 2002 at 11:39:33AM +0200, Ralf Baechle wrote:
> On Tue, Jun 18, 2002 at 10:03:47AM -0700, William Jhun wrote:
> 
> > To: "linux-mips@oss.sgi.com"@ayrnetworks.com
>       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> Your mail software is smoking funny stuff ;-)

Well! I'll just have to give it a strict spanking and send it off to
rehab. No wonder the office window is always wide open when I arrive in
the morning!

> Can you try to get rid of all these #ifdef CONFIG_NONCOHERENT_IO things?
> We already had too many of them and you're adding even more ...
> Basically if dma_cache_wback_inv, dma_cache_wback and dma_cache_inv are
> just empty macros as they are if CONFIG_NONCOHERENT_IO is undefined
> gcc should be able to optimize most of the #ifdef'd code away.

Ok, so I got rid of most except the ones in the *_sg() functions; gcc
won't optimize the loop out, even with -O2. It just creates a tight loop
that increments sg..

Note that without the #ifdefs, you may get warnings like:

../../../ayr/linux/include/asm/pci.h: In function `prep_buffer':
../../../ayr/linux/include/asm/pci.h:89: warning: statement with no effect
../../../ayr/linux/include/asm/pci.h:89: warning: statement with no effect
../../../ayr/linux/include/asm/pci.h:92: warning: statement with no effect
../../../ayr/linux/include/asm/pci.h:92: warning: statement with no effect
../../../ayr/linux/include/asm/pci.h:95: warning: statement with no effect
../../../ayr/linux/include/asm/pci.h:95: warning: statement with no effect
../../../ayr/linux/include/asm/pci.h: In function `sync_buffer':
../../../ayr/linux/include/asm/pci.h:108: warning: statement with no effect
../../../ayr/linux/include/asm/pci.h:108: warning: statement with no effect

So are we still sure we want to leave them out?

Will

---
Index: include/asm-mips/pci.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/pci.h,v
retrieving revision 1.24.2.1
diff -u -r1.24.2.1 pci.h
--- include/asm-mips/pci.h	2002/02/26 06:00:25	1.24.2.1
+++ include/asm-mips/pci.h	2002/06/19 18:20:51
@@ -80,6 +80,37 @@
 				void *vaddr, dma_addr_t dma_handle);
 
 /*
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
+/*
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
+
+/*
  * Map a single buffer of the indicated size for DMA in streaming mode.
  * The 32-bit bus address to use is returned.
  *
@@ -92,9 +123,7 @@
 	if (direction == PCI_DMA_NONE)
 		BUG();
 
-#ifdef CONFIG_NONCOHERENT_IO
-	dma_cache_wback_inv((unsigned long)ptr, size);
-#endif
+	prep_buffer(ptr, size, direction);
 
 	return virt_to_bus(ptr);
 }
@@ -131,9 +160,7 @@
 
 	addr = (unsigned long) page_address(page);
 	addr += offset;
-#ifdef CONFIG_NONCOHERENT_IO
-	dma_cache_wback_inv(addr, size);
-#endif
+	prep_buffer((void*)addr, size, direction);
 
 	return virt_to_bus((void *)addr);
 }
@@ -183,7 +210,7 @@
 #ifdef CONFIG_NONCOHERENT_IO
 	/* Make sure that gcc doesn't leave the empty loop body.  */
 	for (i = 0; i < nents; i++, sg++)
-		dma_cache_wback_inv((unsigned long)sg->address, sg->length);
+		prep_buffer(sg->address, sg->length, direction);
 #endif
 
 	return nents;
@@ -220,9 +247,7 @@
 	if (direction == PCI_DMA_NONE)
 		BUG();
 
-#ifdef CONFIG_NONCOHERENT_IO
-	dma_cache_wback_inv((unsigned long)bus_to_virt(dma_handle), size);
-#endif
+	sync_buffer(bus_to_virt(dma_handle), size, direction);
 }
 
 /*
@@ -246,7 +271,7 @@
 	/* Make sure that gcc doesn't leave the empty loop body.  */
 #ifdef CONFIG_NONCOHERENT_IO
 	for (i = 0; i < nelems; i++, sg++)
-		dma_cache_wback_inv((unsigned long)sg->address, sg->length);
+		sync_buffer(sg->address, sg->length, direction);
 #endif
 }
 
