Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g71LHNRw015678
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 1 Aug 2002 14:17:23 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g71LHN5D015677
	for linux-mips-outgoing; Thu, 1 Aug 2002 14:17:23 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from laposte.enst-bretagne.fr (laposte.enst-bretagne.fr [192.108.115.3])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g71LGrRw015666;
	Thu, 1 Aug 2002 14:16:54 -0700
Received: from resel.enst-bretagne.fr (UNKNOWN@maisel-gw.enst-bretagne.fr [192.44.76.8])
	by laposte.enst-bretagne.fr (8.11.6/8.11.6) with ESMTP id g71LINf12689;
	Thu, 1 Aug 2002 23:18:23 +0200
Received: from melkor (mail@melkor.maisel.enst-bretagne.fr [172.16.20.65])
	by resel.enst-bretagne.fr (8.12.3/8.12.3/Debian -4) with ESMTP id g71LIOfo012224;
	Thu, 1 Aug 2002 23:18:24 +0200
Received: from glaurung (helo=localhost)
	by melkor with local-esmtp (Exim 3.35 #1 (Debian))
	id 17aNKx-0008V5-00; Thu, 01 Aug 2002 23:18:23 +0200
Date: Thu, 1 Aug 2002 23:18:23 +0200 (CEST)
From: Vivien Chappelier <vivien.chappelier@enst-bretagne.fr>
X-Sender: glaurung@melkor
To: Ralf Baechle <ralf@oss.sgi.com>
cc: linux-mips@oss.sgi.com
Subject: [2.5 patch] pci_dma fixes for mips64
Message-ID: <Pine.LNX.4.21.0208012312590.32661-100000@melkor>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: by amavisd-milter (http://amavis.org/) at enst-bretagne.fr
X-Spam-Status: No, hits=-5.0 required=5.0 tests=UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello,

	This patch should fix pci_dma_* functions for mips64, especially
on non-coherent computers (and fixes a warning).

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
 
--- linux/include/asm-mips64/scatterlist.h	Thu Aug  1 20:12:14 2002
+++ linux.patch/include/asm-mips64/scatterlist.h	Thu Aug  1 20:12:01 2002
@@ -4,7 +4,7 @@
 struct scatterlist {
 	struct page *	page;
 	unsigned int	offset;
-	dma_addr_t	dma_address;
+	dma_addr_t	address;
 	unsigned int	length;
 };
 
--- linux/include/asm-mips64/pci.h	Thu Aug  1 21:22:41 2002
+++ linux.patch/include/asm-mips64/pci.h	Thu Aug  1 21:37:46 2002
@@ -8,6 +8,7 @@
 
 #include <linux/config.h>
 #include <linux/types.h>
+#include <linux/mm.h>			/* for page_address()  */
 #include <asm/io.h>			/* for virt_to_bus()  */
 
 #ifdef __KERNEL__
@@ -126,9 +125,11 @@
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
@@ -145,7 +146,11 @@
 	if (direction == PCI_DMA_NONE)
 		BUG();
 
-	/* Nothing to do */
+#ifdef CONFIG_NONCOHERENT_IO
+	if (direction != PCI_DMA_TODEVICE) {
+		dma_cache_wback_inv((unsigned long)bus_to_virt(dma_addr), size);
+	}
+#endif
 }
 
 /* pci_unmap_{page,single} is a nop so... */
@@ -171,10 +176,12 @@
 
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
@@ -182,7 +189,12 @@
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
@@ -205,17 +217,20 @@
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
+		sg->address = bus_to_baddr(hwdev, virt_to_bus((void *)addr));
 	}
-
 	return nents;
 }
 
@@ -227,10 +242,22 @@
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
@@ -250,7 +277,7 @@
 	if (direction == PCI_DMA_NONE)
 		BUG();
 #ifdef CONFIG_NONCOHERENT_IO
-	dma_cache_wback_inv((unsigned long)__va(dma_handle - bus_to_baddr[hwdev->bus->number]), size);
+	dma_cache_wback_inv((unsigned long) bus_to_virt(baddr_to_bus(hwdev, dma_handle)), size);
 #endif
 }
 
@@ -267,6 +294,7 @@
 {
 #ifdef CONFIG_NONCOHERENT_IO
 	int i;
+	unsigned long addr;
 #endif
 
 	if (direction == PCI_DMA_NONE)
@@ -274,9 +302,10 @@
 
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
