Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Oct 2010 22:29:55 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:8591 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492024Ab0JAU1w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Oct 2010 22:27:52 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4ca644670000>; Fri, 01 Oct 2010 13:28:23 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 1 Oct 2010 13:27:52 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 1 Oct 2010 13:27:52 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o91KRiJl028720;
        Fri, 1 Oct 2010 13:27:44 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o91KRiAc028719;
        Fri, 1 Oct 2010 13:27:44 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 5/8] MIPS: ip32, ip27, jazz: Make static functions in dma-coherence.h inline.
Date:   Fri,  1 Oct 2010 13:27:31 -0700
Message-Id: <1285964854-28659-6-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.2
In-Reply-To: <1285964854-28659-1-git-send-email-ddaney@caviumnetworks.com>
References: <1285964854-28659-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 01 Oct 2010 20:27:52.0501 (UTC) FILETIME=[1F6F4650:01CB61A7]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27919
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Any function defined in a header file should be inline.  This helps us
avoid 'unused' compiler warnings when we include the files in more
places in subsequent patches.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/mach-ip27/dma-coherence.h |    4 ++--
 arch/mips/include/asm/mach-ip32/dma-coherence.h |    4 ++--
 arch/mips/include/asm/mach-jazz/dma-coherence.h |    8 ++++----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/mips/include/asm/mach-ip27/dma-coherence.h b/arch/mips/include/asm/mach-ip27/dma-coherence.h
index d3d0401..7aa5ef9 100644
--- a/arch/mips/include/asm/mach-ip27/dma-coherence.h
+++ b/arch/mips/include/asm/mach-ip27/dma-coherence.h
@@ -26,14 +26,14 @@ static inline dma_addr_t plat_map_dma_mem(struct device *dev, void *addr,
 	return pa;
 }
 
-static dma_addr_t plat_map_dma_mem_page(struct device *dev, struct page *page)
+static inline dma_addr_t plat_map_dma_mem_page(struct device *dev, struct page *page)
 {
 	dma_addr_t pa = dev_to_baddr(dev, page_to_phys(page));
 
 	return pa;
 }
 
-static unsigned long plat_dma_addr_to_phys(struct device *dev,
+static inline unsigned long plat_dma_addr_to_phys(struct device *dev,
 	dma_addr_t dma_addr)
 {
 	return dma_addr & ~(0xffUL << 56);
diff --git a/arch/mips/include/asm/mach-ip32/dma-coherence.h b/arch/mips/include/asm/mach-ip32/dma-coherence.h
index 3785595..55123fc 100644
--- a/arch/mips/include/asm/mach-ip32/dma-coherence.h
+++ b/arch/mips/include/asm/mach-ip32/dma-coherence.h
@@ -37,7 +37,7 @@ static inline dma_addr_t plat_map_dma_mem(struct device *dev, void *addr,
 	return pa;
 }
 
-static dma_addr_t plat_map_dma_mem_page(struct device *dev, struct page *page)
+static inline dma_addr_t plat_map_dma_mem_page(struct device *dev, struct page *page)
 {
 	dma_addr_t pa;
 
@@ -50,7 +50,7 @@ static dma_addr_t plat_map_dma_mem_page(struct device *dev, struct page *page)
 }
 
 /* This is almost certainly wrong but it's what dma-ip32.c used to use  */
-static unsigned long plat_dma_addr_to_phys(struct device *dev,
+static inline unsigned long plat_dma_addr_to_phys(struct device *dev,
 	dma_addr_t dma_addr)
 {
 	unsigned long addr = dma_addr & RAM_OFFSET_MASK;
diff --git a/arch/mips/include/asm/mach-jazz/dma-coherence.h b/arch/mips/include/asm/mach-jazz/dma-coherence.h
index f93aee5..2a10920 100644
--- a/arch/mips/include/asm/mach-jazz/dma-coherence.h
+++ b/arch/mips/include/asm/mach-jazz/dma-coherence.h
@@ -12,23 +12,23 @@
 
 struct device;
 
-static dma_addr_t plat_map_dma_mem(struct device *dev, void *addr, size_t size)
+static inline dma_addr_t plat_map_dma_mem(struct device *dev, void *addr, size_t size)
 {
 	return vdma_alloc(virt_to_phys(addr), size);
 }
 
-static dma_addr_t plat_map_dma_mem_page(struct device *dev, struct page *page)
+static inline dma_addr_t plat_map_dma_mem_page(struct device *dev, struct page *page)
 {
 	return vdma_alloc(page_to_phys(page), PAGE_SIZE);
 }
 
-static unsigned long plat_dma_addr_to_phys(struct device *dev,
+static inline unsigned long plat_dma_addr_to_phys(struct device *dev,
 	dma_addr_t dma_addr)
 {
 	return vdma_log2phys(dma_addr);
 }
 
-static void plat_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr,
+static inline void plat_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr,
 	size_t size, enum dma_data_direction direction)
 {
 	vdma_free(dma_addr);
-- 
1.7.2.2
