Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4PKIqnC004833
	for <linux-mips-outgoing@oss.sgi.com>; Sat, 25 May 2002 13:18:52 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4PKIqLD004832
	for linux-mips-outgoing; Sat, 25 May 2002 13:18:52 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from ayrnetworks.com (64-166-72-142.ayrnetworks.com [64.166.72.142])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4PKIPnC004824;
	Sat, 25 May 2002 13:18:25 -0700
Received: (from wjhun@localhost)
	by  ayrnetworks.com (8.11.2/8.11.2) id g4PKI6Y04077;
	Sat, 25 May 2002 13:18:06 -0700
Date: Sat, 25 May 2002 13:18:06 -0700
From: William Jhun <wjhun@ayrnetworks.com>
To: linux-mips@oss.sgi.com
Cc: ralf@oss.sgi.com, davem@redhat.com
Subject: [PATCH] include/asm-mips/pci.h: More optimal cache behavior, added "prep" routines
Message-ID: <20020525131806.A4073@ayrnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This patch (against latest linux_2_4 oss tree) makes several
optimizations for pci_map_*() and pci_dma_sync_*() routines, as well as
adds an extention to the interface that allows a driver to prepare a
buffer for a DMA transfer after having intercepted it with
pci_dma_sync_*().

These calls, pci_dma_prep_{sg,single}, are useful in cases where one
wants to reuse a buffer for DMAing to a device without having to
unmap/map it again. They essentially should do what pci_map_*() should
do except for setting up the mapping itself. (On other architectures,
this might involve something like copying to a bounce buffer or the
like...)

When preparing a buffer for a DMA transfer, we've found it's more
optimal to only do a wback_inv if the direction is not known
(PCIDMA_BIDIRECTIONAL), only a wback if transfer is to the device
(PCIDMA_TO_DEVICE), and only an invalidate if from the device
(PCIDMA_FROM_DEVICE). Such a modification has made a small (yet
significant) improvement for one of our network drivers during a packet
forwarding rate test.

The other modification is to only invalidate on a pci_dma_sync_*() if
the direction is from the device or bidirectional. Since this call is
only supposed to insure that the CPU views exactly what has been DMAed
in, there is no reason to write-back (or do anything if the direction is
PCIDMA_TO_DEVICE).

If I'm not mistaken, it seems that this call should actually do nothing
to invalidate caches, but instead a pci_dma_prep_{sync,single} call with
PCIDMA_FROM_DEVICE should do the invalidate. This would eliminate the
extra invalidate that happens when a driver calls pci_dma_sync_*() after
just having DMAed into a just mapped buffer. It would also clear up the
abstraction of who "owns" the device; there would be an explicit call
for each transition i.e. (FROM_DEVICE operation)

	pci_map_single()      - device now owns the buffer [invalidate]
	[DMA]
	pci_dma_sync_single() - driver now owns it         [no invalidate]
	[driver touches buffer]
	pci_dma_prep_single() - device owns it once again  [invalidate]
	[DMA] ...

rather than an implicit change from driver->device, i.e.

	pci_map_single()      - device now owns the buffer [invalidate]
	[DMA]
	pci_dma_sync_single() - driver now owns it [unneeded invalidate]
	[driver touches buffer]
	[driver now gives bus address back to the device,
	 and the device implicitly owns it once again]
	[DMA] ...

However, such a change would require change lots of existing drivers and
breaking others. So I'll veer away from that. :o)

Thanks,
William

---
Index: include/asm-mips/pci.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/pci.h,v
retrieving revision 1.24.2.1
diff -u -r1.24.2.1 pci.h
--- include/asm-mips/pci.h	2002/02/26 06:00:25	1.24.2.1
+++ include/asm-mips/pci.h	2002/05/25 20:10:20
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
 
@@ -245,8 +278,52 @@
 
 	/* Make sure that gcc doesn't leave the empty loop body.  */
 #ifdef CONFIG_NONCOHERENT_IO
+	for (i = 0; i < nelems; i++, sg++)
+		sync_buffer(sg->address, sg->length, direction);
+#endif
+
+}
+
+/*
+ * Prepare buffer for a DMA transfer after driver temporarily
+ * re-claimed it with pci_dma_sync_*().
+ *
+ * In essence, this "returns" the buffer to the PCI device.
+ */
+static inline void pci_dma_prep_single(struct pci_dev *hwdev,
+				       dma_addr_t dma_handle,
+				       size_t size, int direction)
+{
+	if (direction == PCI_DMA_NONE)
+		BUG();
+
+#ifdef CONFIG_NONCOHERENT_IO
+	prep_buffer(bus_to_virt(dma_handle), size, direction);
+#endif
+}
+
+/*
+ * Prepare buffer for a DMA transfer after driver temporarily
+ * re-claimed it with pci_dma_sync_*().
+ *
+ * The same as pci_dma_prep_single but for a scatter-gather list,
+ * same rules and usage.
+ */
+static inline void pci_dma_prep_sg(struct pci_dev *hwdev,
+				   struct scatterlist *sg,
+				   int nelems, int direction)
+{
+#ifdef CONFIG_NONCOHERENT_IO
+	int i;
+#endif
+
+	if (direction == PCI_DMA_NONE)
+		BUG();
+
+	/* Make sure that gcc doesn't leave the empty loop body.  */
+#ifdef CONFIG_NONCOHERENT_IO
 	for (i = 0; i < nelems; i++, sg++)
-		dma_cache_wback_inv((unsigned long)sg->address, sg->length);
+		prep_buffer(sg->address, sg->length, direction);
 #endif
 }
 
