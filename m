Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4PM3YnC005339
	for <linux-mips-outgoing@oss.sgi.com>; Sat, 25 May 2002 15:03:34 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4PM3YMW005338
	for linux-mips-outgoing; Sat, 25 May 2002 15:03:34 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from ayrnetworks.com (64-166-72-142.ayrnetworks.com [64.166.72.142])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4PM3LnC005334;
	Sat, 25 May 2002 15:03:21 -0700
Received: (from wjhun@localhost)
	by  ayrnetworks.com (8.11.2/8.11.2) id g4PM32h08267;
	Sat, 25 May 2002 15:03:02 -0700
Date: Sat, 25 May 2002 15:03:02 -0700
From: William Jhun <wjhun@ayrnetworks.com>
To: linux-mips@oss.sgi.com
Cc: ralf@oss.sgi.com, davem@redhat.com
Subject: Re: [PATCH] include/asm-mips/pci.h: More optimal cache behavior, added "prep" routines
Message-ID: <20020525150302.A8264@ayrnetworks.com>
References: <20020525131806.A4073@ayrnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020525131806.A4073@ayrnetworks.com>; from wjhun@ayrnetworks.com on Sat, May 25, 2002 at 01:18:06PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, May 25, 2002 at 01:18:06PM -0700, William Jhun wrote:
> When preparing a buffer for a DMA transfer, we've found it's more
> optimal to only do a wback_inv if the direction is not known
> (PCIDMA_BIDIRECTIONAL), only a wback if transfer is to the device
> (PCIDMA_TO_DEVICE), and only an invalidate if from the device
> (PCIDMA_FROM_DEVICE). Such a modification has made a small (yet
> significant) improvement for one of our network drivers during a packet
> forwarding rate test.

*sigh*. On the platform we were testing on, we used our own cache code
(rm7k with tertiary cache support) which has been well-tested for over a
year now. In these routines, we implement dma_cache_wback and only do
invalidates (no flush) for dma_cache_wback_inv. Now that I'm looking
around in cache support for other MIPS CPUs, I see that all the _wback
calls are not implemented and that many (or all?) of the _inv calls also
flush the caches.

The patch below leaves the existing funtions alone and just adds the two
pci_dma_prep_{sg,single}() calls.

My question is: why are these dma_cache_wback calls not implemented? And
how come dma_cache_inv is treated the same as dma_cache_wback_inv? Are
we doing something wrong by implementing these calls in our cache code
as they are described?

Thanks,
Will

---
Index: include/asm-mips/pci.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/pci.h,v
retrieving revision 1.24.2.1
diff -u -r1.24.2.1 pci.h
--- include/asm-mips/pci.h	2002/02/26 06:00:25	1.24.2.1
+++ include/asm-mips/pci.h	2002/05/25 22:01:53
@@ -250,6 +250,49 @@
 #endif
 }
 
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
+	dma_cache_wback_inv((unsigned long)bus_to_virt(dma_handle), size);
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
+	for (i = 0; i < nelems; i++, sg++)
+		dma_cache_wback_inv((unsigned long)sg->address, sg->length);
+#endif
+}
+
 /* Return whether the given PCI device DMA address mask can
  * be supported properly.  For example, if your device can
  * only drive the low 24-bits during PCI bus mastering, then
