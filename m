Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7208URw019265
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 1 Aug 2002 17:08:30 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7208Umu019264
	for linux-mips-outgoing; Thu, 1 Aug 2002 17:08:30 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from laposte.enst-bretagne.fr (laposte.enst-bretagne.fr [192.108.115.3])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7207jRw019253;
	Thu, 1 Aug 2002 17:07:46 -0700
Received: from resel.enst-bretagne.fr (UNKNOWN@maisel-gw.enst-bretagne.fr [192.44.76.8])
	by laposte.enst-bretagne.fr (8.11.6/8.11.6) with ESMTP id g7209Ef19456;
	Fri, 2 Aug 2002 02:09:14 +0200
Received: from melkor (mail@melkor.maisel.enst-bretagne.fr [172.16.20.65])
	by resel.enst-bretagne.fr (8.12.3/8.12.3/Debian -4) with ESMTP id g7209Ffo018150;
	Fri, 2 Aug 2002 02:09:15 +0200
Received: from glaurung (helo=localhost)
	by melkor with local-esmtp (Exim 3.35 #1 (Debian))
	id 17aQ0I-0003yM-00; Fri, 02 Aug 2002 02:09:14 +0200
Date: Fri, 2 Aug 2002 02:09:13 +0200 (CEST)
From: Vivien Chappelier <vivien.chappelier@enst-bretagne.fr>
X-Sender: glaurung@melkor
To: Ralf Baechle <ralf@oss.sgi.com>
cc: linux-mips@oss.sgi.com
Subject: [2.5 PATCH] pci_dma fixes, 2nd try..
Message-ID: <Pine.LNX.4.21.0208020159390.13343-100000@melkor>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: by amavisd-milter (http://amavis.org/) at enst-bretagne.fr
X-Spam-Status: No, hits=-5.0 required=5.0 tests=UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

	Here is a patch to fix pci_dma_* functions for both mips64 and
mips. It adds cache flushes when unmapping if the transfer was from device
for non-coherent systems, and abstracts the use of bus_to_baddr. The
resulting patched pci.h in include/asm-mips64 should work for
include/asm-mips as well (I've merged code, but couldn't test).

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
 
--- linux/include/asm-mips/io.h	Wed Jul 24 01:03:20 2002
+++ linux.patch/include/asm-mips/io.h	Fri Aug  2 01:05:57 2002
@@ -19,6 +19,15 @@
 #include <asm/byteorder.h>
 #include <asm/mipsregs.h>
 
+#ifdef CONFIG_SGI_IP27
+ extern unsigned long bus_to_baddr[256];
+#define bus_to_baddr(hwdev, addr) (bus_to_baddr[(hwdev)->bus->number] | (addr))
+#define baddr_to_bus(hwdev, addr) ((addr) - bus_to_baddr[(hwdev)->bus->number])
+#else
+#define bus_to_baddr(hwdev, addr) (addr)
+#define baddr_to_bus(hwdev, addr) (addr)
+#endif
+
 /*
  * Slowdown I/O port space accesses for antique hardware.
  */
--- linux/include/asm-mips64/io.h	Thu Aug  1 22:15:19 2002
+++ linux.patch/include/asm-mips64/io.h	Thu Aug  1 22:14:57 2002
@@ -35,7 +35,14 @@
 #include <asm/ip32/io.h>
 #endif
 
+#ifdef CONFIG_SGI_IP27
 extern unsigned long bus_to_baddr[256];
+#define bus_to_baddr(hwdev, addr) (bus_to_baddr[(hwdev)->bus->number] | (addr))
+#define baddr_to_bus(hwdev, addr) ((addr) - bus_to_baddr[(hwdev)->bus->number])
+#else
+#define bus_to_baddr(hwdev, addr) (addr)
+#define baddr_to_bus(hwdev, addr) (addr)
+#endif
 
 /*
  * Slowdown I/O port space accesses for antique hardware.
--- linux/include/asm-mips64/pci.h	Fri Aug  2 01:17:31 2002
+++ linux.patch/include/asm-mips64/pci.h	Fri Aug  2 01:20:04 2002
@@ -8,6 +8,7 @@
 
 #include <linux/config.h>
 #include <linux/types.h>
+#include <linux/mm.h>			/* for page_address()  */
 #include <asm/io.h>			/* for virt_to_bus()  */
 
 #ifdef __KERNEL__
@@ -47,6 +48,13 @@
 #include <linux/string.h>
 #include <asm/io.h>
 
+#if defined(CONFIG_DDB5074) || defined(CONFIG_DDB5476)
+#undef PCIBIOS_MIN_IO
+#undef PCIBIOS_MIN_MEM
+#define PCIBIOS_MIN_IO		0x0100000
+#define PCIBIOS_MIN_MEM		0x1000000
+#endif
+
 struct pci_dev;
 
 /*
@@ -79,6 +87,19 @@
 extern void pci_free_consistent(struct pci_dev *hwdev, size_t size,
 				void *vaddr, dma_addr_t dma_handle);
 
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
 
 #ifdef CONFIG_MAPPED_PCI_IO
 
@@ -95,20 +116,6 @@
 extern void pci_dma_sync_sg(struct pci_dev *hwdev, struct scatterlist *sg,
                             int nelems, int direction);
 
-/* pci_unmap_{single,page} is not a nop, thus... */
-#define DECLARE_PCI_UNMAP_ADDR(ADDR_NAME)	\
-	dma_addr_t ADDR_NAME;
-#define DECLARE_PCI_UNMAP_LEN(LEN_NAME)		\
-	__u32 LEN_NAME;
-#define pci_unmap_addr(PTR, ADDR_NAME)			\
-	((PTR)->ADDR_NAME)
-#define pci_unmap_addr_set(PTR, ADDR_NAME, VAL)		\
-	(((PTR)->ADDR_NAME) = (VAL))
-#define pci_unmap_len(PTR, LEN_NAME)			\
-	((PTR)->LEN_NAME)
-#define pci_unmap_len_set(PTR, LEN_NAME, VAL)		\
-	(((PTR)->LEN_NAME) = (VAL))
-
 #else /* CONFIG_MAPPED_PCI_IO  */
 
 /*
@@ -125,9 +132,11 @@
 		BUG();
 
 #ifdef CONFIG_NONCOHERENT_IO
-	dma_cache_wback_inv((unsigned long)ptr, size);
+	if (direction != PCI_DMA_FROMDEVICE) {
+		dma_cache_wback_inv((unsigned long)ptr, size);
+	}
 #endif
-	return virt_to_bus(ptr);
+	return bus_to_baddr(hwdev, virt_to_bus(ptr));
 }
 
 /*
@@ -144,17 +153,13 @@
 	if (direction == PCI_DMA_NONE)
 		BUG();
 
-	/* Nothing to do */
+#ifdef CONFIG_NONCOHERENT_IO
+	if (direction != PCI_DMA_TODEVICE) {
+		dma_cache_wback_inv((unsigned long)bus_to_virt(baddr_to_bus(hwdev, dma_addr)), size);
+	}
+#endif
 }
 
-/* pci_unmap_{page,single} is a nop so... */
-#define DECLARE_PCI_UNMAP_ADDR(ADDR_NAME)
-#define DECLARE_PCI_UNMAP_LEN(LEN_NAME)
-#define pci_unmap_addr(PTR, ADDR_NAME)		(0)
-#define pci_unmap_addr_set(PTR, ADDR_NAME, VAL)	do { } while (0)
-#define pci_unmap_len(PTR, LEN_NAME)		(0)
-#define pci_unmap_len_set(PTR, LEN_NAME, VAL)	do { } while (0)
-
 /*
  * pci_{map,unmap}_single_page maps a kernel page to a dma_addr_t. identical
  * to pci_map_single, but takes a struct page instead of a virtual address
@@ -170,10 +175,12 @@
 
 	addr = (unsigned long) page_address(page) + offset;
 #ifdef CONFIG_NONCOHERENT_IO
-	dma_cache_wback_inv(addr, size);
+	if (direction != PCI_DMA_FROMDEVICE) {
+		dma_cache_wback_inv(addr, size);
+	}
 #endif
 
-	return virt_to_bus((void *)addr);
+	return bus_to_baddr(hwdev, virt_to_bus((void *)addr));
 }
 
 static inline void pci_unmap_page(struct pci_dev *hwdev, dma_addr_t dma_address,
@@ -181,7 +188,12 @@
 {
 	if (direction == PCI_DMA_NONE)
 		BUG();
-	/* Nothing to do */
+
+#ifdef CONFIG_NONCOHERENT_IO
+	if (direction != PCI_DMA_TODEVICE) {
+		dma_cache_wback_inv((unsigned long) bus_to_virt(baddr_to_bus(hwdev, dma_address)), size);
+	}
+#endif
 }
 
 /*
@@ -204,17 +216,20 @@
 			     int nents, int direction)
 {
 	int i;
+	unsigned long addr;
 
 	if (direction == PCI_DMA_NONE)
 		BUG();
 
 	for (i = 0; i < nents; i++, sg++) {
-		dma_cache_wback_inv((unsigned long)page_address(sg->page),
-		                    sg->length);
-		sg->address = bus_to_baddr[hwdev->bus->number] +
-		               page_to_bus(sg->page) + sg->offset;
+		addr = (unsigned long) page_address(sg->page) + sg->offset;
+#ifdef CONFIG_NONCOHERENT_IO
+		if (direction != PCI_DMA_FROMDEVICE) {
+		  dma_cache_wback_inv(addr, sg->length);
+		}
+#endif
+		sg->dma_address = bus_to_baddr(hwdev, virt_to_bus((void *)addr));
 	}
-
 	return nents;
 }
 
@@ -226,10 +241,22 @@
 static inline void pci_unmap_sg(struct pci_dev *hwdev, struct scatterlist *sg,
 				int nents, int direction)
 {
+#ifdef CONFIG_NONCOHERENT_IO
+	int i;
+	unsigned long addr;
+#endif
+
 	if (direction == PCI_DMA_NONE)
 		BUG();
 
-	/* Nothing to do */
+#ifdef CONFIG_NONCOHERENT_IO
+	if (direction != PCI_DMA_TODEVICE) {
+	  for (i = 0; i < nents; i++, sg++) {
+		addr = (unsigned long) page_address(sg->page) + sg->offset;
+	        dma_cache_wback_inv(addr, sg->length);
+	  }
+	}
+#endif
 }
 
 /*
@@ -249,7 +276,7 @@
 	if (direction == PCI_DMA_NONE)
 		BUG();
 #ifdef CONFIG_NONCOHERENT_IO
-	dma_cache_wback_inv((unsigned long)__va(dma_handle - bus_to_baddr[hwdev->bus->number]), size);
+	dma_cache_wback_inv((unsigned long) bus_to_virt(baddr_to_bus(hwdev, dma_handle)), size);
 #endif
 }
 
@@ -266,6 +293,7 @@
 {
 #ifdef CONFIG_NONCOHERENT_IO
 	int i;
+	unsigned long addr;
 #endif
 
 	if (direction == PCI_DMA_NONE)
@@ -273,13 +301,19 @@
 
 	/*  Make sure that gcc doesn't leave the empty loop body.  */
 #ifdef CONFIG_NONCOHERENT_IO
-	for (i = 0; i < nelems; i++, sg++)
-		dma_cache_wback_inv((unsigned long)page_address(sg->page),
-		                    sg->length);
+	for (i = 0; i < nelems; i++, sg++) {
+		addr = (unsigned long) page_address(sg->page) + sg->offset;
+		dma_cache_wback_inv(addr, sg->length);
+	}
 #endif
 }
 #endif /* CONFIG_MAPPED_PCI_IO  */
 
+/* Return whether the given PCI device DMA address mask can
+ * be supported properly.  For example, if your device can
+ * only drive the low 24-bits during PCI bus mastering, then
+ * you would pass 0x00ffffff as the mask to this function.
+ */
 static inline int pci_dma_supported(struct pci_dev *hwdev, u64 mask)
 {
 	/*
@@ -329,6 +363,30 @@
 }
 #endif
 
+#if defined(CONFIG_MAPPED_PCI_IO) || defined(CONFIG_NONCOHERENT_IO)
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
+/* pci_unmap_{page,single} is a nop so... */
+#define DECLARE_PCI_UNMAP_ADDR(ADDR_NAME)
+#define DECLARE_PCI_UNMAP_LEN(LEN_NAME)
+#define pci_unmap_addr(PTR, ADDR_NAME)		(0)
+#define pci_unmap_addr_set(PTR, ADDR_NAME, VAL)	do { } while (0)
+#define pci_unmap_len(PTR, LEN_NAME)		(0)
+#define pci_unmap_len_set(PTR, LEN_NAME, VAL)	do { } while (0)
+#endif
+
 /*
  * Return the index of the PCI controller for device.
  */
@@ -341,7 +399,7 @@
  * returns, or alternatively stop on the first sg_dma_len(sg) which
  * is 0.
  */
-#define sg_dma_address(sg)	((sg)->address)
+#define sg_dma_address(sg)	((sg)->dma_address)
 #define sg_dma_len(sg)		((sg)->length)
 
 #endif /* __KERNEL__ */
