Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6EL3LRw014833
	for <linux-mips-outgoing@oss.sgi.com>; Sun, 14 Jul 2002 14:03:22 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6EL3LPg014832
	for linux-mips-outgoing; Sun, 14 Jul 2002 14:03:21 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from sgi.com (sgi-too.SGI.COM [204.94.211.39])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6EL31Rw014820;
	Sun, 14 Jul 2002 14:03:01 -0700
Received: from laposte.enst-bretagne.fr ([192.108.115.3]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA05787; Sun, 14 Jul 2002 14:08:10 -0700 (PDT)
	mail_from (vivien.chappelier@enst-bretagne.fr)
Received: from resel.enst-bretagne.fr (UNKNOWN@maisel-gw.enst-bretagne.fr [192.44.76.8])
	by laposte.enst-bretagne.fr (8.11.6/8.11.6) with ESMTP id g6EKndC11913;
	Sun, 14 Jul 2002 22:49:39 +0200
Received: from melkor (mail@melkor.maisel.enst-bretagne.fr [172.16.20.65])
	by resel.enst-bretagne.fr (8.12.3/8.12.3/Debian -4) with ESMTP id g6EKneTF020519;
	Sun, 14 Jul 2002 22:49:40 +0200
Received: from glaurung (helo=localhost)
	by melkor with local-esmtp (Exim 3.35 #1 (Debian))
	id 17TqJI-0002F8-00; Sun, 14 Jul 2002 22:49:40 +0200
Date: Sun, 14 Jul 2002 22:49:39 +0200 (CEST)
From: Vivien Chappelier <vivien.chappelier@enst-bretagne.fr>
X-Sender: glaurung@melkor
To: Ralf Baechle <ralf@oss.sgi.com>
cc: linux-mips@oss.sgi.com
Subject: [2.5 PATCH] O2 coherency
Message-ID: <Pine.LNX.4.21.0207142241210.8121-100000@melkor>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: by amavisd-milter (http://amavis.org/) at enst-bretagne.fr
X-Spam-Status: No, hits=-5.0 required=5.0 tests=UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

	This is a patch to ensure DMA coherency on the SGI O2, by adding
the appropriate cache flushes before and after DMA, and setting the
default page attribute to cacheable non-coherent.
It also fixes the flushed address for the ip27 (offset was missing).

Vivien.

================================================================================
diff -Naur linux/arch/mips64/sgi-ip27/ip27-pci-dma.c linux.patch/arch/mips64/sgi-ip27/ip27-pci-dma.c
--- linux/arch/mips64/sgi-ip27/ip27-pci-dma.c	Thu Jan  3 21:24:54 2002
+++ linux.patch/arch/mips64/sgi-ip27/ip27-pci-dma.c	Sun Jul 14 22:29:34 2002
@@ -98,7 +98,8 @@
 
 	/* Make sure that gcc doesn't leave the empty loop body.  */
 	for (i = 0; i < nents; i++, sg++) {
-		sg->address = (char *)(bus_to_baddr[hwdev->bus->number] | __pa(sg->address));
+		address = page_address(sg->page) + sg->offset;
+		sg->dvma_address = (char *)(bus_to_baddr[hwdev->bus->number] | __pa(address));
 	}
 
 	return nents;
diff -Naur linux/arch/mips64/sgi-ip32/ip32-pci-dma.c linux.patch/arch/mips64/sgi-ip32/ip32-pci-dma.c
--- linux/arch/mips64/sgi-ip32/ip32-pci-dma.c	Thu Jan  3 21:24:55 2002
+++ linux.patch/arch/mips64/sgi-ip32/ip32-pci-dma.c	Sun Jul 14 22:29:34 2002
@@ -44,7 +44,7 @@
 		dma_cache_wback_inv((unsigned long) ret, size);
 		*dma_handle = ( __pa (ret));
 		DPRINTK("pci_alloc_consistent: addr=%016lx; dma_handle=%08x\n",(u64)KSEG1ADDR(ret),*dma_handle);
-		return KSEG1ADDR(ret);
+		return((void *)KSEG1ADDR(ret));
 	}
 	DPRINTK("pci_alloc_consistent2: addr=%016lx; dma_handle=%08x\n",(u64)KSEG1ADDR(ret),*dma_handle);
 	return NULL;
@@ -85,7 +85,10 @@
 	if (direction == PCI_DMA_NONE)
 		BUG();
 	DPRINTK("pci_unmap_single\n");
-	/* Nothing to do */
+	if (direction != PCI_DMA_TODEVICE) {
+	        mips_wbflush();
+	        dma_cache_wback_inv((unsigned long)__va(dma_addr), size);
+	}
 }
 
 /*
@@ -108,6 +111,7 @@
 			     int nents, int direction)
 {
 	int i;
+	unsigned long address;
 
 	if (direction == PCI_DMA_NONE)
 		BUG();
@@ -117,9 +121,10 @@
 	DPRINTK("pci_map_sg\n");
 	/* Make sure that gcc doesn't leave the empty loop body.  */
 	for (i = 0; i < nents; i++, sg++) {
+		address = page_address(sg->page) + sg->offset;
 		mips_wbflush();
-		dma_cache_wback_inv((unsigned long)sg->address, sg->length);
-		sg->address = (char *)(__pa(sg->address));
+		dma_cache_wback_inv(address, sg->length);
+		sg->dvma_address = __pa(address);
 	}
 
 	return nents;
@@ -133,10 +138,19 @@
 void pci_unmap_sg(struct pci_dev *hwdev, struct scatterlist *sg,
 				int nents, int direction)
 {
+	int i;
+	unsigned long address;
+
 	if (direction == PCI_DMA_NONE)
 		BUG();
 	DPRINTK("pci_unmap_sg\n");
-	/* Nothing to do */
+	for (i = 0; i < nents; i++, sg++) {
+	  if (direction != PCI_DMA_TODEVICE) {
+		address = page_address(sg->page) + sg->offset;
+	        mips_wbflush();
+	        dma_cache_wback_inv(address, sg->length);
+	  }
+	}
 }
 
 /*
@@ -174,13 +188,16 @@
 				   int nelems, int direction)
 {
 	int i;
+	unsigned long address;
+
 	if (direction == PCI_DMA_NONE)
 		BUG();
 	DPRINTK("pci_dma_sync_sg\n");
 	/*  Make sure that gcc doesn't leave the empty loop body.  */
 	for (i = 0; i < nelems; i++, sg++){
+		address = page_address(sg->page) + sg->offset;
 		mips_wbflush();
-		dma_cache_wback_inv((unsigned long)__va(sg->address), sg->length);
+		dma_cache_wback_inv(address, sg->length);
 	}
 /*	if(direction==PCI_DMA_TODEVICE)
 		mace_inv_read_buffers();*/
diff -Naur linux/include/asm-mips64/pci.h linux.patch/include/asm-mips64/pci.h
--- linux/include/asm-mips64/pci.h	Tue Jul  9 22:03:12 2002
+++ linux.patch/include/asm-mips64/pci.h	Sun Jul 14 22:29:34 2002
@@ -343,7 +343,7 @@
  * returns, or alternatively stop on the first sg_dma_len(sg) which
  * is 0.
  */
-#define sg_dma_address(sg)	((unsigned long)((sg)->address))
+#define sg_dma_address(sg)	((sg)->dvma_address)
 #define sg_dma_len(sg)		((sg)->length)
 
 #endif /* __KERNEL__ */
diff -Naur linux/include/asm-mips64/pgtable.h linux.patch/include/asm-mips64/pgtable.h
--- linux/include/asm-mips64/pgtable.h	Mon Jul  8 22:28:12 2002
+++ linux.patch/include/asm-mips64/pgtable.h	Sun Jul 14 22:29:34 2002
@@ -188,11 +188,11 @@
 #ifdef CONFIG_MIPS_UNCACHED
 #define PAGE_CACHABLE_DEFAULT _CACHE_UNCACHED
 #else /* ! UNCACHED */
-#ifdef CONFIG_SGI_IP22
+#if defined(CONFIG_SGI_IP22) || defined(CONFIG_SGI_IP32)
 #define PAGE_CACHABLE_DEFAULT _CACHE_CACHABLE_NONCOHERENT
-#else /* ! IP22 */
+#else /* ! (IP22 || IP32)*/
 #define PAGE_CACHABLE_DEFAULT _CACHE_CACHABLE_COW
-#endif /* IP22 */
+#endif /* (IP22 || IP32) */
 #endif /* UNCACHED */
 
 #define PAGE_NONE	__pgprot(_PAGE_PRESENT | PAGE_CACHABLE_DEFAULT)
