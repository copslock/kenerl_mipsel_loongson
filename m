Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Nov 2009 08:42:10 +0100 (CET)
Received: from mail-yw0-f173.google.com ([209.85.211.173]:35826 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492416AbZKDHmD (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 4 Nov 2009 08:42:03 +0100
Received: by ywh3 with SMTP id 3so7044819ywh.22
        for <multiple recipients>; Tue, 03 Nov 2009 23:41:54 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=lwybjC5A4qE6NHZqdbT1DhaUCbi46JepJa5odaRRFJc=;
        b=SDYv4HNzGeleVsqjws3FkXYLJjxzKf81Bn1F4eNBtGsGmlLS22fobUvrINU1M8YIcS
         5SdOQ6U0qE+Iy8bWaIxVfhBCvber42WRWAb3aBL/WW+x10rGQcG1BWrWg4S36j3vbBc8
         Yfg5R68aCqb4B9IqUQBYDiBTHI515YG+XsHx8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=EHmPGwe0WTMD95AxWLD4odWqd2ZeGmnrHIN0fgLWmX5cMf+zJcEoaiqWq53DzkqYfz
         fQ5V5sdikb1AJM6/JPXkTNYWtgcYlTXa/MRnaaIWkBYufWSdTIMHY4zyeeuUcxI/DOmM
         CpAWjCPPMfHB0fsv3mr+Vc4jaDaTmyrVFJll0=
Received: by 10.150.35.3 with SMTP id i3mr2110298ybi.128.1257320514733;
        Tue, 03 Nov 2009 23:41:54 -0800 (PST)
Received: from ypsilon.skybright.jp (sannin29006.nirai.ne.jp [203.160.29.6])
        by mx.google.com with ESMTPS id 13sm415417gxk.9.2009.11.03.23.41.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Nov 2009 23:41:53 -0800 (PST)
Date:	Wed, 4 Nov 2009 16:41:04 +0900
From:	Yoichi Yuasa <yuasa@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yuasa@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH][MIPS] add DMA declare coherent memory support
Message-Id: <20091104164104.9fc315af.yuasa@linux-mips.org>
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.16.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa.linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24657
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips


ohci-sm501 driver require dma_declare_coherent_memory().
It is used to driver's local memory allocation with dma_alloc_coherent().

This patch works without problem on TANBAC TB0287(VR4131 + SM501).

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/Kconfig                   |    1 +
 arch/mips/include/asm/dma-mapping.h |    3 +--
 arch/mips/mm/dma-default.c          |    7 +++++++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 03bd56a..687a438 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -3,6 +3,7 @@ config MIPS
 	default y
 	select HAVE_IDE
 	select HAVE_OPROFILE
+	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_ARCH_KGDB
 	# Horrible source of confusion.  Die, die, die ...
 	select EMBEDDED
diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/dma-mapping.h
index d16afdd..808e303 100644
--- a/arch/mips/include/asm/dma-mapping.h
+++ b/arch/mips/include/asm/dma-mapping.h
@@ -3,6 +3,7 @@
 
 #include <asm/scatterlist.h>
 #include <asm/cache.h>
+#include <asm-generic/dma-coherent.h>
 
 void *dma_alloc_noncoherent(struct device *dev, size_t size,
 			   dma_addr_t *dma_handle, gfp_t flag);
@@ -73,7 +74,6 @@ extern int dma_is_consistent(struct device *dev, dma_addr_t dma_addr);
 extern void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 	       enum dma_data_direction direction);
 
-#if 0
 #define ARCH_HAS_DMA_DECLARE_COHERENT_MEMORY
 
 extern int dma_declare_coherent_memory(struct device *dev, dma_addr_t bus_addr,
@@ -81,6 +81,5 @@ extern int dma_declare_coherent_memory(struct device *dev, dma_addr_t bus_addr,
 extern void dma_release_declared_memory(struct device *dev);
 extern void * dma_mark_declared_memory_occupied(struct device *dev,
 	dma_addr_t device_addr, size_t size);
-#endif
 
 #endif /* _ASM_DMA_MAPPING_H */
diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index 7e48e76..32b43bd 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -90,6 +90,9 @@ void *dma_alloc_coherent(struct device *dev, size_t size,
 {
 	void *ret;
 
+	if (dma_alloc_from_coherent(dev, size, dma_handle, &ret))
+		return ret;
+
 	gfp = massage_gfp_flags(dev, gfp);
 
 	ret = (void *) __get_free_pages(gfp, get_order(size));
@@ -121,8 +124,12 @@ EXPORT_SYMBOL(dma_free_noncoherent);
 void dma_free_coherent(struct device *dev, size_t size, void *vaddr,
 	dma_addr_t dma_handle)
 {
+	int order = get_order(size);
 	unsigned long addr = (unsigned long) vaddr;
 
+	if (dma_release_from_coherent(dev, order, vaddr))
+		return;
+
 	plat_unmap_dma_mem(dev, dma_handle, size, DMA_BIDIRECTIONAL);
 
 	if (!plat_device_is_coherent(dev))
-- 
1.6.5.2
