Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 26 Jan 2003 02:10:10 +0000 (GMT)
Received: from smtp-102.nerim.net ([IPv6:::ffff:62.4.16.102]:33293 "EHLO
	kraid.nerim.net") by linux-mips.org with ESMTP id <S8225200AbTAZCKJ>;
	Sun, 26 Jan 2003 02:10:09 +0000
Received: from melkor (vivienc.net1.nerim.net [213.41.134.233])
	by kraid.nerim.net (Postfix) with ESMTP
	id 9A8C340E2A; Sun, 26 Jan 2003 03:10:06 +0100 (CET)
Received: from glaurung (helo=localhost)
	by melkor with local-esmtp (Exim 3.36 #1 (Debian))
	id 18ccFy-0004AH-00; Sun, 26 Jan 2003 03:10:46 +0100
Date: Sun, 26 Jan 2003 03:10:46 +0100 (CET)
From: Vivien Chappelier <vivienc@nerim.net>
X-Sender: glaurung@melkor
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: linux-mips@linux-mips.org
Subject: [PATCH 2.5] PCI DMA fixes for non-coherent arch
Message-ID: <Pine.LNX.4.21.0301260303400.15950-100000@melkor>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <vivienc@nerim.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1220
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vivienc@nerim.net
Precedence: bulk
X-list: linux-mips

Hi,

	Here's a patch to fix various bugs in the PCI DMA routines on
non-coherent archs:
	- when unmapped, a buffer should be flushed if PCI_DMA_FROMDEVICE
is set, which is not the opposite of PCI_DMA_TODEVICE (both can be set)
	- on non-coherent archs, DECLARE_PCI_UNMAP_ADDR and friends are
needed, since pci_unmap_{page,single} is not a nop
	- the scatter buffer offset was not added in pci_dma_sync_sg

Vivien.

--- include/asm-mips64/pci.h	2002-10-09 23:12:58.000000000 +0200
+++ include/asm-mips64/pci.h	2002-12-08 13:54:03.000000000 +0100
@@ -24,6 +24,8 @@
 #define PCIBIOS_MIN_IO		0x1000
 #define PCIBIOS_MIN_MEM		0x10000000
 
+struct pci_dev;
+
 static inline void pcibios_set_master(struct pci_dev *dev)
 {
 	/* No special bus mastering setup handling */
@@ -44,6 +46,7 @@
 #include <asm/scatterlist.h>
 #include <linux/string.h>
 #include <asm/io.h>
+#include <linux/pci.h>
 
 #if defined(CONFIG_DDB5074) || defined(CONFIG_DDB5476)
 #undef PCIBIOS_MIN_IO
@@ -52,8 +55,6 @@
 #define PCIBIOS_MIN_MEM		0x1000000
 #endif
 
-struct pci_dev;
-
 /*
  * The PCI address space does equal the physical memory address space.  The
  * networking and block device layers use this boolean for bounce buffer
@@ -141,17 +142,33 @@
 static inline void pci_unmap_single(struct pci_dev *hwdev, dma_addr_t dma_addr,
 				    size_t size, int direction)
 {
+	unsigned long addr;
+
 	if (direction == PCI_DMA_NONE)
 		BUG();
 
-	if (direction != PCI_DMA_TODEVICE) {
-		unsigned long addr;
+	if (direction == PCI_DMA_TODEVICE)
+		return; /* nothing to do */
 
-		addr = baddr_to_bus(hwdev->bus, dma_addr) + PAGE_OFFSET;
-		dma_cache_wback_inv(addr, size);
-	}
+	addr = baddr_to_bus(hwdev->bus, dma_addr) + PAGE_OFFSET;
+	dma_cache_wback_inv(addr, size);
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
@@ -159,6 +176,7 @@
 #define pci_unmap_addr_set(PTR, ADDR_NAME, VAL)	do { } while (0)
 #define pci_unmap_len(PTR, LEN_NAME)		(0)
 #define pci_unmap_len_set(PTR, LEN_NAME, VAL)	do { } while (0)
+#endif
 
 /*
  * pci_{map,unmap}_single_page maps a kernel page to a dma_addr_t. identical
@@ -182,15 +200,16 @@
 static inline void pci_unmap_page(struct pci_dev *hwdev, dma_addr_t dma_address,
 				  size_t size, int direction)
 {
+	unsigned long addr;
+
 	if (direction == PCI_DMA_NONE)
 		BUG();
 
-	if (direction != PCI_DMA_TODEVICE) {
-		unsigned long addr;
+	if (direction == PCI_DMA_TODEVICE)
+		return; /* nothing to do */
 
-		addr = baddr_to_bus(hwdev->bus, dma_address) + PAGE_OFFSET;
-		dma_cache_wback_inv(addr, size);
-	}
+	addr = baddr_to_bus(hwdev->bus, dma_address) + PAGE_OFFSET;
+	dma_cache_wback_inv(addr, size);
 }
 
 /*
@@ -301,9 +320,12 @@
 
 	/* Make sure that gcc doesn't leave the empty loop body.  */
 #ifdef CONFIG_NONCOHERENT_IO
-	for (i = 0; i < nelems; i++, sg++)
-		dma_cache_wback_inv((unsigned long)page_address(sg->page),
-		                    sg->length);
+	for (i = 0; i < nelems; i++, sg++) {
+		unsigned long addr;
+
+		addr = (unsigned long) page_address(sg->page);
+		dma_cache_wback_inv(addr + sg->offset, sg->length);
+	}
 #endif
 }
 #endif /* CONFIG_MAPPED_PCI_IO  */
--- include/asm-mips/pci.h	2002-10-09 23:12:58.000000000 +0200
+++ include/asm-mips/pci.h	2002-12-08 13:54:03.000000000 +0100
@@ -24,6 +24,8 @@
 #define PCIBIOS_MIN_IO		0x1000
 #define PCIBIOS_MIN_MEM		0x10000000
 
+struct pci_dev;
+
 static inline void pcibios_set_master(struct pci_dev *dev)
 {
 	/* No special bus mastering setup handling */
@@ -44,6 +46,7 @@
 #include <asm/scatterlist.h>
 #include <linux/string.h>
 #include <asm/io.h>
+#include <linux/pci.h>
 
 #if defined(CONFIG_DDB5074) || defined(CONFIG_DDB5476)
 #undef PCIBIOS_MIN_IO
@@ -52,8 +55,6 @@
 #define PCIBIOS_MIN_MEM		0x1000000
 #endif
 
-struct pci_dev;
-
 /*
  * The PCI address space does equal the physical memory address space.  The
  * networking and block device layers use this boolean for bounce buffer
@@ -141,17 +142,33 @@
 static inline void pci_unmap_single(struct pci_dev *hwdev, dma_addr_t dma_addr,
 				    size_t size, int direction)
 {
+	unsigned long addr;
+
 	if (direction == PCI_DMA_NONE)
 		BUG();
 
-	if (direction != PCI_DMA_TODEVICE) {
-		unsigned long addr;
+	if (direction == PCI_DMA_TODEVICE)
+		return; /* nothing to do */
 
-		addr = baddr_to_bus(hwdev->bus, dma_addr) + PAGE_OFFSET;
-		dma_cache_wback_inv(addr, size);
-	}
+	addr = baddr_to_bus(hwdev->bus, dma_addr) + PAGE_OFFSET;
+	dma_cache_wback_inv(addr, size);
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
@@ -159,6 +176,7 @@
 #define pci_unmap_addr_set(PTR, ADDR_NAME, VAL)	do { } while (0)
 #define pci_unmap_len(PTR, LEN_NAME)		(0)
 #define pci_unmap_len_set(PTR, LEN_NAME, VAL)	do { } while (0)
+#endif
 
 /*
  * pci_{map,unmap}_single_page maps a kernel page to a dma_addr_t. identical
@@ -182,15 +200,16 @@
 static inline void pci_unmap_page(struct pci_dev *hwdev, dma_addr_t dma_address,
 				  size_t size, int direction)
 {
+	unsigned long addr;
+
 	if (direction == PCI_DMA_NONE)
 		BUG();
 
-	if (direction != PCI_DMA_TODEVICE) {
-		unsigned long addr;
+	if (direction == PCI_DMA_TODEVICE)
+		return; /* nothing to do */
 
-		addr = baddr_to_bus(hwdev->bus, dma_address) + PAGE_OFFSET;
-		dma_cache_wback_inv(addr, size);
-	}
+	addr = baddr_to_bus(hwdev->bus, dma_address) + PAGE_OFFSET;
+	dma_cache_wback_inv(addr, size);
 }
 
 /*
@@ -301,9 +320,12 @@
 
 	/* Make sure that gcc doesn't leave the empty loop body.  */
 #ifdef CONFIG_NONCOHERENT_IO
-	for (i = 0; i < nelems; i++, sg++)
-		dma_cache_wback_inv((unsigned long)page_address(sg->page),
-		                    sg->length);
+	for (i = 0; i < nelems; i++, sg++) {
+		unsigned long addr;
+
+		addr = (unsigned long) page_address(sg->page);
+		dma_cache_wback_inv(addr + sg->offset, sg->length);
+	}
 #endif
 }
 #endif /* CONFIG_MAPPED_PCI_IO  */
