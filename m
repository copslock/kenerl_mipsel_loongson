Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Sep 2002 17:31:10 +0200 (CEST)
Received: from buserror-extern.convergence.de ([212.84.236.66]:28422 "EHLO
	hell") by linux-mips.org with ESMTP id <S1122987AbSIQPbJ>;
	Tue, 17 Sep 2002 17:31:09 +0200
Received: from js by hell with local (Exim 3.35 #1 (Debian))
	id 17rKJb-0004Em-00
	for <linux-mips@linux-mips.org>; Tue, 17 Sep 2002 17:31:03 +0200
Date: Tue, 17 Sep 2002 17:31:02 +0200
From: Johannes Stezenbach <js@convergence.de>
To: linux-mips@linux-mips.org
Subject: consistent_alloc() for MIPS
Message-ID: <20020917153102.GA16159@convergence.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Return-Path: <js@convergence.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 200
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: js@convergence.de
Precedence: bulk
X-list: linux-mips


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

a co-worker ported consistent_alloc() from ARM to MIPS.
We use it to allocate DMA buffers in unified memory in
a non-PCI system-on-a-chip embedded thingy.

Maybe we could have just used pci_alloc_consistent(), but
consistent_alloc() has the advantage of freeing unused
pages allocated due to __get_free_pages() power-of-two-
number-of-pages semantics.

BTW, it seems that at least for CONFIG_SGI_IP27
pci_alloc_consistent() does not work for non-PCI DMA
buffers (hwdev == NULL). Anyway, the code for pci_alloc_consistent()
looks confusing because it seems to dereference a NULL pointer.

The attached patch works for us, but maybe someone
could comment if
a) it was a good idea to port it from ARM to MIPS
b) we made no gross mistakes (e.g. do we need to flush
   the dcache? Currently it works without. Should we
   ioremap()?)
c) if it is of use to other linux/MIPS users


One other thing:
The comments for dma_cache_wback_inv() in io.h seem
to lack a "memory" in "...makes caches and coherent...".
Also, dma_cache_wback() and dma_cache_wback_inv() seem to
be identical. Is this intentional?


Regards,
Johannes

--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-oss-consistent-alloc.patch"

diff -ruaN linux-oss.orig/arch/mips/mm/Makefile linux-oss/arch/mips/mm/Makefile
--- linux-oss.orig/arch/mips/mm/Makefile	2002-09-09 21:30:12.000000000 +0200
+++ linux-oss/arch/mips/mm/Makefile	2002-09-13 12:53:17.000000000 +0200
@@ -10,8 +10,8 @@
 
 O_TARGET := mm.o
 
-export-objs			+= ioremap.o loadmmu.o umap.o
-obj-y				+= extable.o init.o ioremap.o fault.o loadmmu.o
+export-objs			+= ioremap.o loadmmu.o umap.o consistent.o
+obj-y				+= extable.o init.o ioremap.o fault.o loadmmu.o consistent.o
 
 obj-$(CONFIG_CPU_R3000)		+= pg-r3k.o c-r3k.o c-tx39.o tlb-r3k.o \
 				   tlbex-r3k.o
diff -ruaN linux-oss.orig/arch/mips/mm/consistent.c linux-oss/arch/mips/mm/consistent.c
--- linux-oss.orig/arch/mips/mm/consistent.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-oss/arch/mips/mm/consistent.c	2002-05-24 18:55:30.000000000 +0200
@@ -0,0 +1,108 @@
+/*
+ * linux/arch/mips/mm/consistent.c
+ *
+ *  Copyright (C) 2002 Denis Oliver Kropp
+ *
+ *
+ * Based on linux/arch/arm/mm/consistent.c
+ *
+ *  Copyright (C) 2000 Russell King
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ *  Dynamic DMA mapping support.
+ */
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/mm.h>
+#include <linux/string.h>
+#include <linux/vmalloc.h>
+#include <linux/interrupt.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+
+#include <asm/io.h>
+#include <asm/pgtable.h>
+#include <asm/pgalloc.h>
+
+/*
+ * This allocates one page of cache-coherent memory space and returns
+ * both the virtual and a "dma" address to that space.  It is not clear
+ * whether this could be called from an interrupt context or not.  For
+ * now, we expressly forbid it, especially as some of the stuff we do
+ * here is not interrupt context safe.
+ *
+ * Note that this does *not* zero the allocated area!
+ */
+void *consistent_alloc(int gfp, size_t size, dma_addr_t *dma_handle)
+{
+	struct page *page, *free, *end;
+	unsigned long order;
+	void *virt;
+
+	if (in_interrupt())
+		BUG();
+
+	size = PAGE_ALIGN(size);
+	order = get_order(size);
+
+	page = alloc_pages(gfp, order);
+	if (!page)
+		return NULL;
+
+	virt = page_address(page);
+	*dma_handle = virt_to_bus(virt);
+
+        /*
+         * free wasted pages.  We skip the first page since we know
+       	 * that it will have count = 1 and won't require freeing.
+         * We also mark the pages in use as reserved so that
+         * remap_page_range works.
+         */
+	page = virt_to_page(virt);
+	free = page + (size >> PAGE_SHIFT);
+	end  = page + (1 << order);
+        
+	for (; page < end; page++) {
+		set_page_count(page, 1);
+		if (page >= free)
+			__free_page(page);
+		else
+                       	SetPageReserved(page);
+	}
+
+	return (void*) KSEG1ADDR(virt);
+}
+
+/*
+ * free a page as defined by the above mapping.  We expressly forbid
+ * calling this from interrupt context.
+ */
+void consistent_free(void *vaddr, size_t size, dma_addr_t handle)
+{
+	struct page *page, *end;
+	void *virt;
+
+	if (in_interrupt())
+		BUG();
+
+	virt = bus_to_virt(handle);
+
+	/*
+	 * More messing around with the MM internals.  This is
+	 * sick, but then so is remap_page_range().
+	 */
+	size = PAGE_ALIGN(size);
+	page = virt_to_page(virt);
+	end = page + (size >> PAGE_SHIFT);
+
+	for (; page < end; page++)
+		ClearPageReserved(page);
+}
+
+EXPORT_SYMBOL(consistent_alloc);
+EXPORT_SYMBOL(consistent_free);
+
diff -ruaN linux-oss.orig/include/asm-mips/io.h linux-oss/include/asm-mips/io.h
--- linux-oss.orig/include/asm-mips/io.h	2002-08-16 20:36:17.000000000 +0200
+++ linux-oss/include/asm-mips/io.h	2002-09-13 12:53:18.000000000 +0200
@@ -222,6 +222,15 @@
 extern void iounmap(void *addr);
 
 /*
+ * DMA-consistent mapping functions.  These allocate/free a region of
+ * uncached, unwrite-buffered mapped memory space for use with DMA
+ * devices.  This is the "generic" version.  The PCI specific version
+ * is in pci.h
+ */
+extern void *consistent_alloc(int gfp, size_t size, dma_addr_t *handle);
+extern void consistent_free(void *vaddr, size_t size, dma_addr_t handle);
+
+/*
  * XXX We need system specific versions of these to handle EISA address bits
  * 24-31 on SNI.
  * XXX more SNI hacks.

--XsQoSWH+UP9D9v3l--
