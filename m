Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7C0Y7Rw027173
	for <linux-mips-outgoing@oss.sgi.com>; Sun, 11 Aug 2002 17:34:07 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7C0Y76g027172
	for linux-mips-outgoing; Sun, 11 Aug 2002 17:34:07 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from deliverator.sgi.com (deliverator.SGI.COM [204.94.214.10] (may be forged))
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7C0XURw027159;
	Sun, 11 Aug 2002 17:33:30 -0700
Received: from laposte.enst-bretagne.fr ([192.108.115.3]) 
	by deliverator.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA06617; Sun, 11 Aug 2002 17:35:49 -0700 (PDT)
	mail_from (vivien.chappelier@enst-bretagne.fr)
Received: from resel.enst-bretagne.fr (UNKNOWN@maisel-gw.enst-bretagne.fr [192.44.76.8])
	by laposte.enst-bretagne.fr (8.11.6/8.11.6) with ESMTP id g7C0HqY31596;
	Mon, 12 Aug 2002 02:17:52 +0200
Received: from melkor (mail@melkor.maisel.enst-bretagne.fr [172.16.20.65])
	by resel.enst-bretagne.fr (8.12.3/8.12.3/Debian -4) with ESMTP id g7C0Hqfo020680;
	Mon, 12 Aug 2002 02:17:53 +0200
Received: from glaurung (helo=localhost)
	by melkor with local-esmtp (Exim 3.35 #1 (Debian))
	id 17e2u8-0008Cj-00; Mon, 12 Aug 2002 02:17:52 +0200
Date: Mon, 12 Aug 2002 02:17:51 +0200 (CEST)
From: Vivien Chappelier <vivien.chappelier@enst-bretagne.fr>
X-Sender: glaurung@melkor
To: Ralf Baechle <ralf@oss.sgi.com>
cc: linux-mips@oss.sgi.com
Subject: [2.5 PATCH] pci.h cleanup and fixes
Message-ID: <Pine.LNX.4.21.0208120206560.28324-100000@melkor>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: by amavisd-milter (http://amavis.org/) at enst-bretagne.fr
X-Spam-Status: No, hits=-3.7 required=5.0 tests=MAY_BE_FORGED,UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

	This patch fixes the following things for pci.h:
	- flush cache only on non-coherent archs
	- fix usage of bus_to_baddr
	- fix DECLARE_PCI_UNMAP_ADDR, ... for non-coherent arch where
pci_unmap_* functions are not a empty.
	- change __pa, '+ PAGE_OFFSET' to virt_to_phys() and
phys_to_virt()
	- adds sg->offset to page_address(sg->page) when mapping a
scatter-gather buffer

	This is a patch against CVS HEAD (2.5.5)/mips64. It should apply
directly to 2.5.5/mips as well. As for 2.5.4 care should be taken with the
old 'sg->address' interface for scatter-gather buffers, but these fixes
should probably be applied as well.

Please comment and/or apply,
Vivien.

--- linux/include/asm-mips64/addrspace.h	Thu Aug  1 20:22:00 2002
+++ linux.patch/include/asm-mips64/addrspace.h	Thu Aug  1 20:21:54 2002
@@ -58,7 +58,7 @@
 
 #ifndef __ASSEMBLY__
 #define PHYSADDR(a) ({						\
-	const _ATYPE64_ _a = (a);				\
+	const _ATYPE64_ _a = _ACAST64_ (a);				\
 	_a == _ACAST32_ _a ? CPHYSADDR(_a) : XPHYSADDR(_a); })
 #endif
 
--- linux/include/asm-mips64/pci.h	Mon Aug 12 00:25:23 2002
+++ linux.patch/include/asm-mips64/pci.h	Mon Aug 12 00:19:27 2002
@@ -120,14 +120,20 @@
 static inline dma_addr_t pci_map_single(struct pci_dev *hwdev, void *ptr,
 					size_t size, int direction)
 {
+#ifdef CONFIG_NONCOHERENT_IO
 	unsigned long addr = (unsigned long) ptr;
+#endif
 
 	if (direction == PCI_DMA_NONE)
 		BUG();
 
+#ifdef CONFIG_NONCOHERENT_IO
+	/* even if DMAing from device, make sure there is no dirty entry */
+	/* in the cache that could be evicted during the DMA transfer    */
+	/* thus overwritting the device data */
 	dma_cache_wback_inv(addr, size);
-
-	return bus_to_baddr(hwdev->bus->number, __pa(ptr));
+#endif
+	return bus_to_baddr(hwdev, virt_to_phys(ptr));
 }
 
 /*
@@ -141,17 +147,37 @@
 static inline void pci_unmap_single(struct pci_dev *hwdev, dma_addr_t dma_addr,
 				    size_t size, int direction)
 {
+#ifdef CONFIG_NONCOHERENT_IO
+	unsigned long addr;
+#endif
+
 	if (direction == PCI_DMA_NONE)
 		BUG();
 
-	if (direction != PCI_DMA_TODEVICE) {
-		unsigned long addr;
+	if (direction == PCI_DMA_TODEVICE)
+		return; /* nothing to do */
 
-		addr = baddr_to_bus(hwdev, dma_addr) + PAGE_OFFSET;
-		dma_cache_wback_inv(addr, size);
-	}
+#ifdef CONFIG_NONCOHERENT_IO
+	addr = (unsigned long) phys_to_virt(baddr_to_bus(hwdev, dma_addr));
+	dma_cache_wback_inv(addr, size);
+#endif
 }
 
+#ifdef CONFIG_NONCOHERENT_IO
+/* pci_unmap_{single,page} is not a nop, thus... */
+#define DECLARE_PCI_UNMAP_ADDR(ADDR_NAME)	\
+	dma_addr_t ADDR_NAME;
+#define DECLARE_PCI_UNMAP_LEN(LEN_NAME)		\
+	__u32 LEN_NAME;
+#define pci_unmap_addr(PTR, ADDR_NAME)			\
+	((PTR)->ADDR_NAME)
+#define pci_unmap_addr_set(PTR, ADDR_NAME, VAL)		\
+	(((PTR)->ADDR_NAME) = (VAL))
+#define pci_unmap_len(PTR, LEN_NAME)			\
+	((PTR)->LEN_NAME)
+#define pci_unmap_len_set(PTR, LEN_NAME, VAL)		\
+	(((PTR)->LEN_NAME) = (VAL))
+#else
 /* pci_unmap_{page,single} is a nop so... */
 #define DECLARE_PCI_UNMAP_ADDR(ADDR_NAME)
 #define DECLARE_PCI_UNMAP_LEN(LEN_NAME)
@@ -159,6 +185,7 @@
 #define pci_unmap_addr_set(PTR, ADDR_NAME, VAL)	do { } while (0)
 #define pci_unmap_len(PTR, LEN_NAME)		(0)
 #define pci_unmap_len_set(PTR, LEN_NAME, VAL)	do { } while (0)
+#endif
 
 /*
  * pci_{map,unmap}_single_page maps a kernel page to a dma_addr_t. identical
@@ -168,13 +195,17 @@
 				      unsigned long offset, size_t size,
                                       int direction)
 {
+#ifdef CONFIG_NONCOHERENT_IO
 	unsigned long addr;
+#endif
 
 	if (direction == PCI_DMA_NONE)
 		BUG();
 
+#ifdef CONFIG_NONCOHERENT_IO
 	addr = (unsigned long) page_address(page) + offset;
 	dma_cache_wback_inv(addr, size);
+#endif
 
 	return bus_to_baddr(hwdev, page_to_phys(page) + offset);
 }
@@ -182,15 +213,20 @@
 static inline void pci_unmap_page(struct pci_dev *hwdev, dma_addr_t dma_address,
 				  size_t size, int direction)
 {
+#ifdef CONFIG_NONCOHERENT_IO
+	unsigned long addr;
+#endif
+
 	if (direction == PCI_DMA_NONE)
 		BUG();
 
-	if (direction != PCI_DMA_TODEVICE) {
-		unsigned long addr;
+	if (direction == PCI_DMA_TODEVICE)
+		return; /* nothing to do */
 
-		addr = baddr_to_bus(hwdev, dma_address) + PAGE_OFFSET;
-		dma_cache_wback_inv(addr, size);
-	}
+#ifdef CONFIG_NONCOHERENT_IO
+	addr = (unsigned long) phys_to_virt(baddr_to_bus(hwdev, dma_address));
+	dma_cache_wback_inv(addr, size);
+#endif
 }
 
 /*
@@ -212,21 +248,23 @@
 static inline int pci_map_sg(struct pci_dev *hwdev, struct scatterlist *sg,
 			     int nents, int direction)
 {
+#ifdef CONFIG_NONCOHERENT_IO
 	int i;
+#endif
 
 	if (direction == PCI_DMA_NONE)
 		BUG();
 
+#ifdef CONFIG_NONCOHERENT_IO
 	for (i = 0; i < nents; i++, sg++) {
 		unsigned long addr;
 
-		addr = (unsigned long) page_address(sg->page);
-		if (addr)
-			dma_cache_wback_inv(addr, sg->length);
+		addr = (unsigned long) page_address(sg->page) + sg->offset;
+		dma_cache_wback_inv(addr, sg->length);
 		sg->dma_address = (dma_addr_t) bus_to_baddr(hwdev,
 			page_to_phys(sg->page) + sg->offset);
 	}
-
+#endif
 	return nents;
 }
 
@@ -238,24 +276,27 @@
 static inline void pci_unmap_sg(struct pci_dev *hwdev, struct scatterlist *sg,
 				int nents, int direction)
 {
+#ifdef CONFIG_NONCOHERENT_IO
 	int i;
+#endif
 
 	if (direction == PCI_DMA_NONE)
 		BUG();
 
 	if (direction == PCI_DMA_TODEVICE)
-		return;
+		return; /* nothing to do */
 
+#ifdef CONFIG_NONCOHERENT_IO
 	for (i = 0; i < nents; i++, sg++) {
 		unsigned long addr;
 
 		if (!sg->page)
 			BUG();
 
-		addr = (unsigned long) page_address(sg->page);
-		if (addr)
-			dma_cache_wback_inv(addr + sg->offset, sg->length);
+		addr = (unsigned long) page_address(sg->page) + sg->offset;
+		dma_cache_wback_inv(addr, sg->length);
 	}
+#endif
 }
 
 /*
@@ -272,13 +313,17 @@
 				       dma_addr_t dma_handle,
 				       size_t size, int direction)
 {
+#ifdef CONFIG_NONCOHERENT_IO
 	unsigned long addr;
+#endif
 
 	if (direction == PCI_DMA_NONE)
 		BUG();
 
-	addr = baddr_to_bus(hwdev, dma_handle) + PAGE_OFFSET;
+#ifdef CONFIG_NONCOHERENT_IO
+	addr = (unsigned long) phys_to_virt(baddr_to_bus(hwdev, dma_handle));
 	dma_cache_wback_inv(addr, size);
+#endif
 }
 
 /*
@@ -301,9 +346,12 @@
 
 	/* Make sure that gcc doesn't leave the empty loop body.  */
 #ifdef CONFIG_NONCOHERENT_IO
-	for (i = 0; i < nelems; i++, sg++)
-		dma_cache_wback_inv((unsigned long)page_address(sg->page),
-		                    sg->length);
+	for (i = 0; i < nelems; i++, sg++) {
+		unsigned long addr;
+
+		addr = (unsigned long) page_address(sg->page) + sg->offset;
+		dma_cache_wback_inv(addr, sg->length);
+	}
 #endif
 }
 #endif /* CONFIG_MAPPED_PCI_IO  */
@@ -337,7 +385,7 @@
 {
 	dma64_addr_t addr = page_to_phys(page) + offset;
 
-	return (dma64_addr_t) bus_to_baddr(hwdev->bus->number, addr);
+	return (dma64_addr_t) bus_to_baddr(hwdev, addr);
 }
 
 static inline struct page *pci_dac_dma_to_page(struct pci_dev *pdev,
@@ -362,8 +410,10 @@
 	if (direction == PCI_DMA_NONE)
 		BUG();
 
-	addr = baddr_to_bus(hwdev->bus->number, dma_addr) + PAGE_OFFSET;
+	addr = (unsigned long) phys_to_virt(baddr_to_bus(hwdev, dma_addr));
+#ifdef CONFIG_NONCOHERENT_IO
 	dma_cache_wback_inv(addr, len);
+#endif
 }
 
 /*
