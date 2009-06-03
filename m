Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jun 2009 16:16:22 +0100 (WEST)
Received: from mow300.po.2iij.net ([210.128.50.200]:38992 "EHLO
	mow.po.2iij.net" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20022935AbZFCPQL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 3 Jun 2009 16:16:11 +0100
Received: by mow.po.2iij.net (mow300) id n53FG7fm013812; Thu, 4 Jun 2009 00:16:07 +0900
Received: from fulvia (20.8.30.125.dy.iij4u.or.jp [125.30.8.20])
	by mbox.po.2iij.net (po-mbox301) id n53FG5rm016663
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 4 Jun 2009 00:16:05 +0900
Date:	Thu, 4 Jun 2009 00:16:04 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] add DMA declare coherent memory support
Message-Id: <20090604001604.9ced2997.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23219
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips


Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/Kconfig linux/arch/mips/Kconfig
--- linux-orig/arch/mips/Kconfig	2009-04-21 10:55:44.353177629 +0900
+++ linux/arch/mips/Kconfig	2009-04-21 11:01:02.801170966 +0900
@@ -3,6 +3,7 @@ config MIPS
 	default y
 	select HAVE_IDE
 	select HAVE_OPROFILE
+	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_ARCH_KGDB
 	# Horrible source of confusion.  Die, die, die ...
 	select EMBEDDED
diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/include/asm/dma-mapping.h linux/arch/mips/include/asm/dma-mapping.h
--- linux-orig/arch/mips/include/asm/dma-mapping.h	2009-04-21 10:55:44.549177717 +0900
+++ linux/arch/mips/include/asm/dma-mapping.h	2009-04-21 11:19:40.077177611 +0900
@@ -3,6 +3,7 @@
 
 #include <asm/scatterlist.h>
 #include <asm/cache.h>
+#include <asm-generic/dma-coherent.h>
 
 void *dma_alloc_noncoherent(struct device *dev, size_t size,
 			   dma_addr_t *dma_handle, gfp_t flag);
@@ -73,7 +74,6 @@ extern int dma_is_consistent(struct devi
 extern void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 	       enum dma_data_direction direction);
 
-#if 0
 #define ARCH_HAS_DMA_DECLARE_COHERENT_MEMORY
 
 extern int dma_declare_coherent_memory(struct device *dev, dma_addr_t bus_addr,
@@ -81,6 +81,5 @@ extern int dma_declare_coherent_memory(s
 extern void dma_release_declared_memory(struct device *dev);
 extern void * dma_mark_declared_memory_occupied(struct device *dev,
 	dma_addr_t device_addr, size_t size);
-#endif
 
 #endif /* _ASM_DMA_MAPPING_H */
diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/mm/dma-default.c linux/arch/mips/mm/dma-default.c
--- linux-orig/arch/mips/mm/dma-default.c	2009-04-21 10:55:46.409177601 +0900
+++ linux/arch/mips/mm/dma-default.c	2009-04-21 11:21:17.061177557 +0900
@@ -89,6 +89,9 @@ void *dma_alloc_coherent(struct device *
 {
 	void *ret;
 
+	if (dma_alloc_from_coherent(dev, size, dma_handle, &ret))
+		return ret;
+
 	gfp = massage_gfp_flags(dev, gfp);
 
 	ret = (void *) __get_free_pages(gfp, get_order(size));
@@ -120,8 +123,12 @@ EXPORT_SYMBOL(dma_free_noncoherent);
 void dma_free_coherent(struct device *dev, size_t size, void *vaddr,
 	dma_addr_t dma_handle)
 {
+	int order = get_order(size);
 	unsigned long addr = (unsigned long) vaddr;
 
+	if (dma_release_from_coherent(dev, order, vaddr))
+		return;
+
 	plat_unmap_dma_mem(dev, dma_handle);
 
 	if (!plat_device_is_coherent(dev))
