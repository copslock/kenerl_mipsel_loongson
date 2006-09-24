Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Sep 2006 06:39:43 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.176]:60239 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20037500AbWIXFjm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 24 Sep 2006 06:39:42 +0100
Received: by py-out-1112.google.com with SMTP id i49so1667494pyi
        for <linux-mips@linux-mips.org>; Sat, 23 Sep 2006 22:39:39 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=otn41kqWx2sFOp84OJN0GmTh0Tv8WEKdkioCQrub1dtX77NsJo+QE0p0ayZCZ8eEF6k8ZriB0uBClLYmWx2HDEMF/HpydhYUVmRYF4lg+uShZzC0xIj91Qh7mjyXQtcWK3MKZFHltCcxNykD03NdWokXcYc6OJezgNYAvNgYmD8=
Received: by 10.35.8.1 with SMTP id l1mr4750348pyi;
        Sat, 23 Sep 2006 22:39:38 -0700 (PDT)
Received: by 10.35.95.17 with HTTP; Sat, 23 Sep 2006 22:39:38 -0700 (PDT)
Message-ID: <34a75100609232239y29cdabd4xeefb898e502c5dfa@mail.gmail.com>
Date:	Sun, 24 Sep 2006 14:39:38 +0900
From:	girish <girishvg@gmail.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH] cleanup hardcoding __pa/__va macros etc.
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <girishvg@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12635
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: girishvg@gmail.com
Precedence: bulk
X-list: linux-mips

hello.

here is a patch to cleanup some hard coded lines.
plese let me know if these are valid changes.

thanks.


diff -uprN -X linux-vanilla/Documentation/dontdiff
linux-vanilla/arch/mips/mm/dma-noncoherent.c
linux/arch/mips/mm/dma-noncoherent.c
--- linux-vanilla/arch/mips/mm/dma-noncoherent.c	2006-09-24
12:22:46.000000000 +0900
+++ linux/arch/mips/mm/dma-noncoherent.c	2006-09-24 12:20:35.000000000 +0900
@@ -334,7 +334,7 @@ EXPORT_SYMBOL(pci_dac_page_to_dma);
 struct page *pci_dac_dma_to_page(struct pci_dev *pdev,
 	dma64_addr_t dma_addr)
 {
-	return mem_map + (dma_addr >> PAGE_SHIFT);
+	return pfn_to_page (dma_addr >> PAGE_SHIFT);
 }

 EXPORT_SYMBOL(pci_dac_dma_to_page);
diff -uprN -X linux-vanilla/Documentation/dontdiff
linux-vanilla/arch/mips/mm/init.c linux/arch/mips/mm/init.c
--- linux-vanilla/arch/mips/mm/init.c	2006-09-24 12:22:46.000000000 +0900
+++ linux/arch/mips/mm/init.c	2006-09-24 14:23:56.000000000 +0900
@@ -155,24 +155,22 @@ void __init paging_init(void)
 	low = max_low_pfn;
 	high = highend_pfn;

-#ifdef CONFIG_ISA
-	if (low < max_dma)
+	if (low < max_dma) {
 		zones_size[ZONE_DMA] = low;
-	else {
+	} else {
 		zones_size[ZONE_DMA] = max_dma;
 		zones_size[ZONE_NORMAL] = low - max_dma;
 	}
-#else
-	zones_size[ZONE_DMA] = low;
-#endif
+
 #ifdef CONFIG_HIGHMEM
 	if (cpu_has_dc_aliases) {
 		printk(KERN_WARNING "This processor doesn't support highmem.");
 		if (high - low)
 			printk(" %ldk highmem ignored", high - low);
 		printk("\n");
-	} else
-		zones_size[ZONE_HIGHMEM] = high - low;
+	} else {
+		zones_size[ZONE_HIGHMEM] = high - highstart_pfn;
+	}
 #endif

 	free_area_init(zones_size);
@@ -233,7 +231,7 @@ void __init mem_init(void)

 #ifdef CONFIG_HIGHMEM
 	for (tmp = highstart_pfn; tmp < highend_pfn; tmp++) {
-		struct page *page = mem_map + tmp;
+		struct page *page = pfn_to_page(tmp);

 		if (!page_is_ram(tmp)) {
 			SetPageReserved(page);
diff -uprN -X linux-vanilla/Documentation/dontdiff
linux-vanilla/include/asm-mips/dma.h linux/include/asm-mips/dma.h
--- linux-vanilla/include/asm-mips/dma.h	2006-09-24 12:23:34.000000000 +0900
+++ linux/include/asm-mips/dma.h	2006-09-24 14:14:28.000000000 +0900
@@ -87,8 +87,13 @@
 /* Horrible hack to have a correct DMA window on IP22 */
 #include <asm/sgi/mc.h>
 #define MAX_DMA_ADDRESS		(PAGE_OFFSET + SGIMC_SEG0_BADDR + 0x01000000)
-#else
+#elif defined(CONFIG_ISA)
 #define MAX_DMA_ADDRESS		(PAGE_OFFSET + 0x01000000)
+#else
+#ifndef PLAT_MAX_DMA_SIZE
+#define PLAT_MAX_DMA_SIZE       0x10000000    /* 256MB: true for most
of the MIPS32 systems */
+#endif
+#define MAX_DMA_ADDRESS		(PAGE_OFFSET + PLAT_MAX_DMA_SIZE)
 #endif

 /* 8237 DMA controllers */
diff -uprN -X linux-vanilla/Documentation/dontdiff
linux-vanilla/include/asm-mips/io.h linux/include/asm-mips/io.h
--- linux-vanilla/include/asm-mips/io.h	2006-09-24 12:23:34.000000000 +0900
+++ linux/include/asm-mips/io.h	2006-09-24 12:40:12.000000000 +0900
@@ -116,7 +116,7 @@ static inline void set_io_port_base(unsi
  */
 static inline unsigned long virt_to_phys(volatile void * address)
 {
-	return (unsigned long)address - PAGE_OFFSET;
+  return (unsigned long) __pa(address);
 }

 /*
@@ -133,7 +133,7 @@ static inline unsigned long virt_to_phys
  */
 static inline void * phys_to_virt(unsigned long address)
 {
-	return (void *)(address + PAGE_OFFSET);
+  return (void *) __va(address);
 }

 /*
@@ -141,12 +141,12 @@ static inline void * phys_to_virt(unsign
  */
 static inline unsigned long isa_virt_to_bus(volatile void * address)
 {
-	return (unsigned long)address - PAGE_OFFSET;
+  return (unsigned long) __pa(address);
 }

 static inline void * isa_bus_to_virt(unsigned long address)
 {
-	return (void *)(address + PAGE_OFFSET);
+  return (void *) __va(address);
 }

 #define isa_page_to_bus page_to_phys
diff -uprN -X linux-vanilla/Documentation/dontdiff
linux-vanilla/include/asm-mips/page.h linux/include/asm-mips/page.h
--- linux-vanilla/include/asm-mips/page.h	2006-09-24 12:23:34.000000000 +0900
+++ linux/include/asm-mips/page.h	2006-09-24 14:00:53.000000000 +0900
@@ -134,8 +134,13 @@ typedef struct { unsigned long pgprot; }
 /* to align the pointer to the (next) page boundary */
 #define PAGE_ALIGN(addr)	(((addr) + PAGE_SIZE - 1) & PAGE_MASK)

-#define __pa(x)			((unsigned long) (x) - PAGE_OFFSET)
-#define __va(x)			((void *)((unsigned long) (x) + PAGE_OFFSET))
+#define UNMAPLIMIT              (UNCAC_BASE - CAC_BASE) /*HIGHMEM_START*/
+#define ISMAPPED(x)             (KSEGX((x)) > UNMAPLIMIT)
+#define ___pa(x)		((unsigned long) (x) - PAGE_OFFSET)
+#define __pa(x)		        (ISMAPPED(x) ? (x) : ___pa(x))
+
+#define ___va(x)		((void *)((unsigned long) (x) + PAGE_OFFSET))
+#define __va(x)			(ISMAPPED(x) ? (x) : ___va(x))

 #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
