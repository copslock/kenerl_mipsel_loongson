Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Sep 2010 03:03:43 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:8608 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491117Ab0IXBDk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Sep 2010 03:03:40 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c9bf9090000>; Thu, 23 Sep 2010 18:04:09 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 23 Sep 2010 18:03:37 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 23 Sep 2010 18:03:36 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o8O13XT3004261;
        Thu, 23 Sep 2010 18:03:33 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o8O13UAJ004260;
        Thu, 23 Sep 2010 18:03:30 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Wu Zhangjin <wuzhangjin@gmail.com>,
        David VomLehn <dvomlehn@cisco.com>
Subject: [PATCH] MIPS: Remove plat_map_dma_mem_page().
Date:   Thu, 23 Sep 2010 18:03:21 -0700
Message-Id: <1285290201-4226-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.2
In-Reply-To: <1285281496-24696-6-git-send-email-ddaney@caviumnetworks.com>
References: <1285281496-24696-6-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 24 Sep 2010 01:03:36.0958 (UTC) FILETIME=[516511E0:01CB5B84]
X-archive-position: 27815
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 18947

It is now unused.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Cc: Wu Zhangjin <wuzhangjin@gmail.com>
Cc: David VomLehn <dvomlehn@cisco.com>
---

This is a small addition to the rest of the patch set.  It could be
rolled into [PATCH 5/9] MIPS: Convert DMA to use dma-mapping-common.h

 arch/mips/include/asm/mach-generic/dma-coherence.h |    6 ------
 arch/mips/include/asm/mach-ip27/dma-coherence.h    |    7 -------
 arch/mips/include/asm/mach-ip32/dma-coherence.h    |   12 ------------
 arch/mips/include/asm/mach-jazz/dma-coherence.h    |    5 -----
 .../mips/include/asm/mach-loongson/dma-coherence.h |    6 ------
 arch/mips/include/asm/mach-powertv/dma-coherence.h |    6 ------
 6 files changed, 0 insertions(+), 42 deletions(-)

diff --git a/arch/mips/include/asm/mach-generic/dma-coherence.h b/arch/mips/include/asm/mach-generic/dma-coherence.h
index 8da9807..8259966 100644
--- a/arch/mips/include/asm/mach-generic/dma-coherence.h
+++ b/arch/mips/include/asm/mach-generic/dma-coherence.h
@@ -17,12 +17,6 @@ static inline dma_addr_t plat_map_dma_mem(struct device *dev, void *addr,
 	return virt_to_phys(addr);
 }
 
-static inline dma_addr_t plat_map_dma_mem_page(struct device *dev,
-	struct page *page)
-{
-	return page_to_phys(page);
-}
-
 static inline unsigned long plat_dma_addr_to_phys(struct device *dev,
 	dma_addr_t dma_addr)
 {
diff --git a/arch/mips/include/asm/mach-ip27/dma-coherence.h b/arch/mips/include/asm/mach-ip27/dma-coherence.h
index d3d0401..e35bfbc 100644
--- a/arch/mips/include/asm/mach-ip27/dma-coherence.h
+++ b/arch/mips/include/asm/mach-ip27/dma-coherence.h
@@ -26,13 +26,6 @@ static inline dma_addr_t plat_map_dma_mem(struct device *dev, void *addr,
 	return pa;
 }
 
-static dma_addr_t plat_map_dma_mem_page(struct device *dev, struct page *page)
-{
-	dma_addr_t pa = dev_to_baddr(dev, page_to_phys(page));
-
-	return pa;
-}
-
 static unsigned long plat_dma_addr_to_phys(struct device *dev,
 	dma_addr_t dma_addr)
 {
diff --git a/arch/mips/include/asm/mach-ip32/dma-coherence.h b/arch/mips/include/asm/mach-ip32/dma-coherence.h
index 3785595..7dd1907 100644
--- a/arch/mips/include/asm/mach-ip32/dma-coherence.h
+++ b/arch/mips/include/asm/mach-ip32/dma-coherence.h
@@ -37,18 +37,6 @@ static inline dma_addr_t plat_map_dma_mem(struct device *dev, void *addr,
 	return pa;
 }
 
-static dma_addr_t plat_map_dma_mem_page(struct device *dev, struct page *page)
-{
-	dma_addr_t pa;
-
-	pa = page_to_phys(page) & RAM_OFFSET_MASK;
-
-	if (dev == NULL)
-		pa += CRIME_HI_MEM_BASE;
-
-	return pa;
-}
-
 /* This is almost certainly wrong but it's what dma-ip32.c used to use  */
 static unsigned long plat_dma_addr_to_phys(struct device *dev,
 	dma_addr_t dma_addr)
diff --git a/arch/mips/include/asm/mach-jazz/dma-coherence.h b/arch/mips/include/asm/mach-jazz/dma-coherence.h
index f93aee5..e0d340b 100644
--- a/arch/mips/include/asm/mach-jazz/dma-coherence.h
+++ b/arch/mips/include/asm/mach-jazz/dma-coherence.h
@@ -17,11 +17,6 @@ static dma_addr_t plat_map_dma_mem(struct device *dev, void *addr, size_t size)
 	return vdma_alloc(virt_to_phys(addr), size);
 }
 
-static dma_addr_t plat_map_dma_mem_page(struct device *dev, struct page *page)
-{
-	return vdma_alloc(page_to_phys(page), PAGE_SIZE);
-}
-
 static unsigned long plat_dma_addr_to_phys(struct device *dev,
 	dma_addr_t dma_addr)
 {
diff --git a/arch/mips/include/asm/mach-loongson/dma-coherence.h b/arch/mips/include/asm/mach-loongson/dma-coherence.h
index 981c75f..8daeaee 100644
--- a/arch/mips/include/asm/mach-loongson/dma-coherence.h
+++ b/arch/mips/include/asm/mach-loongson/dma-coherence.h
@@ -19,12 +19,6 @@ static inline dma_addr_t plat_map_dma_mem(struct device *dev, void *addr,
 	return virt_to_phys(addr) | 0x80000000;
 }
 
-static inline dma_addr_t plat_map_dma_mem_page(struct device *dev,
-					       struct page *page)
-{
-	return page_to_phys(page) | 0x80000000;
-}
-
 static inline unsigned long plat_dma_addr_to_phys(struct device *dev,
 	dma_addr_t dma_addr)
 {
diff --git a/arch/mips/include/asm/mach-powertv/dma-coherence.h b/arch/mips/include/asm/mach-powertv/dma-coherence.h
index f76029c..647de8c 100644
--- a/arch/mips/include/asm/mach-powertv/dma-coherence.h
+++ b/arch/mips/include/asm/mach-powertv/dma-coherence.h
@@ -70,12 +70,6 @@ static inline dma_addr_t plat_map_dma_mem(struct device *dev, void *addr,
 		return phys_to_dma(virt_to_phys(addr));
 }
 
-static inline dma_addr_t plat_map_dma_mem_page(struct device *dev,
-	struct page *page)
-{
-	return phys_to_dma(page_to_phys(page));
-}
-
 static inline unsigned long plat_dma_addr_to_phys(struct device *dev,
 	dma_addr_t dma_addr)
 {
-- 
1.7.2.2
