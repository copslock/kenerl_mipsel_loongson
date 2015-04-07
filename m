Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Apr 2015 20:39:19 +0200 (CEST)
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35713 "EHLO
        mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010733AbbDGSjR0P2o3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Apr 2015 20:39:17 +0200
Received: by patj18 with SMTP id j18so87306411pat.2;
        Tue, 07 Apr 2015 11:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Uwvfhwucrts9JBrmTVNRNZMQzaQySv1ntkPWDgIWnV8=;
        b=r0EXtCIdq33E/Zu2YAoXIFvO+dfOoZTS7AttyTXsLG021bryTHwEZlen8sbSjmZuhN
         xVN2u0e1OpCq7H/jaoO//Tae/xS775cPE78J0M09OAfA5x/LCNKlHnfZojGhiTOB7FBN
         whPzY7o3/4H7uVRqn3NnL/r91+Z1UdT/GTJdFRP5FktLXd9eT0qhzK5F6wDHZlCW8H4N
         YIfqfAZfSzZH45FOK1MSStZpm7CO1JQFjik+FDaieaCclSonok9myAZeWX6I8sTws6tz
         8KcEzNVMlyuxFY8YrXAS5IqrG0vesvRrcdjVgGYLnJiuczfxHqjU/UNCvD6m/UX7/RAe
         N52g==
X-Received: by 10.66.178.139 with SMTP id cy11mr38743009pac.146.1428431952582;
        Tue, 07 Apr 2015 11:39:12 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id gn7sm8677717pbc.63.2015.04.07.11.39.11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Apr 2015 11:39:11 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, cernekee@gmail.com, jogo@openwrt.org,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH] MIPS: Rework BMIPS dma-coherence header
Date:   Tue,  7 Apr 2015 11:38:16 -0700
Message-Id: <1428431896-11468-1-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.0
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46812
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Commits 0c8741360c6 ("MIPS: BMIPS: Create bmips-dma-coherence.h") and
6fb7566baa01 ("MIPS: BCM63xx: Utilize bmips-dma-coherence.h") have put a
tad too much into bmips-dma-coherence.h. mach-bmips overrides some of
the platform DMA operations to deal with a configurable translation
window address, whereas BCM63xx can use the default implementation from
asm/mach-generic/dma-coherence.c.

The only thing that is truly shareable by nature is the post DMA flush
hook, which is now renamed to bmips_post_dma_flush() and utilized by
both machines.

This fixes build failures on BCM63xx since we did not provide valid
plat_dma_* helper functions.

Fixes: 0c8741360c6 ("MIPS: BMIPS: Create bmips-dma-coherence.h")
Fixes: 6fb7566baa01 ("MIPS: BCM63xx: Utilize bmips-dma-coherence.h")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Hi Ralf,

This applies on top of mips-for-linux-next, and fixes build failures
reported on linux-next.

Thanks!

 arch/mips/include/asm/bmips-dma-coherence.h        | 32 +--------------
 arch/mips/include/asm/mach-bcm63xx/dma-coherence.h | 45 ++++++++++++++++++++++
 arch/mips/include/asm/mach-bmips/dma-coherence.h   | 32 +++++++++++++++
 3 files changed, 78 insertions(+), 31 deletions(-)

diff --git a/arch/mips/include/asm/bmips-dma-coherence.h b/arch/mips/include/asm/bmips-dma-coherence.h
index bd4aac47b832..7ae0ea45fa70 100644
--- a/arch/mips/include/asm/bmips-dma-coherence.h
+++ b/arch/mips/include/asm/bmips-dma-coherence.h
@@ -19,37 +19,7 @@
 #include <asm/cpu-type.h>
 #include <asm/cpu.h>
 
-struct device;
-
-extern dma_addr_t plat_map_dma_mem(struct device *dev, void *addr, size_t size);
-extern dma_addr_t plat_map_dma_mem_page(struct device *dev, struct page *page);
-extern unsigned long plat_dma_addr_to_phys(struct device *dev,
-	dma_addr_t dma_addr);
-
-static inline void plat_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr,
-	size_t size, enum dma_data_direction direction)
-{
-}
-
-static inline int plat_dma_supported(struct device *dev, u64 mask)
-{
-	/*
-	 * we fall back to GFP_DMA when the mask isn't all 1s,
-	 * so we can't guarantee allocations that must be
-	 * within a tighter range than GFP_DMA..
-	 */
-	if (mask < DMA_BIT_MASK(24))
-		return 0;
-
-	return 1;
-}
-
-static inline int plat_device_is_coherent(struct device *dev)
-{
-	return 0;
-}
-
-static inline void plat_post_dma_flush(struct device *dev)
+static inline void bmips_post_dma_flush(struct device *dev)
 {
 	void __iomem *cbr = BMIPS_GET_CBR();
 	u32 cfg;
diff --git a/arch/mips/include/asm/mach-bcm63xx/dma-coherence.h b/arch/mips/include/asm/mach-bcm63xx/dma-coherence.h
index 932b2b38bbdf..8596525fcfd1 100644
--- a/arch/mips/include/asm/mach-bcm63xx/dma-coherence.h
+++ b/arch/mips/include/asm/mach-bcm63xx/dma-coherence.h
@@ -1,6 +1,51 @@
 #ifndef __ASM_MACH_BCM63XX_DMA_COHERENCE_H
 #define __ASM_MACH_BCM63XX_DMA_COHERENCE_H
 
+struct device;
+
+static inline dma_addr_t plat_map_dma_mem(struct device *dev, void *addr,
+	size_t size)
+{
+	return virt_to_phys(addr);
+}
+
+static inline dma_addr_t plat_map_dma_mem_page(struct device *dev,
+	struct page *page)
+{
+	return page_to_phys(page);
+}
+
+static inline unsigned long plat_dma_addr_to_phys(struct device *dev,
+	dma_addr_t dma_addr)
+{
+	return dma_addr;
+}
+
+static inline void plat_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr,
+	size_t size, enum dma_data_direction direction)
+{
+}
+
+static inline int plat_dma_supported(struct device *dev, u64 mask)
+{
+	/*
+	 * we fall back to GFP_DMA when the mask isn't all 1s,
+	 * so we can't guarantee allocations that must be
+	 * within a tighter range than GFP_DMA..
+	 */
+	if (mask < DMA_BIT_MASK(24))
+		return 0;
+
+	return 1;
+}
+
+static inline int plat_device_is_coherent(struct device *dev)
+{
+	return coherentio;
+}
+
 #include <asm/bmips-dma-coherence.h>
 
+#define plat_post_dma_flush	bmips_post_dma_flush
+
 #endif /* __ASM_MACH_BCM63XX_DMA_COHERENCE_H */
diff --git a/arch/mips/include/asm/mach-bmips/dma-coherence.h b/arch/mips/include/asm/mach-bmips/dma-coherence.h
index 4d88233a82fd..18b24064f469 100644
--- a/arch/mips/include/asm/mach-bmips/dma-coherence.h
+++ b/arch/mips/include/asm/mach-bmips/dma-coherence.h
@@ -3,4 +3,36 @@
 
 #include <asm/bmips-dma-coherence.h>
 
+struct device;
+
+extern dma_addr_t plat_map_dma_mem(struct device *dev, void *addr, size_t size);
+extern dma_addr_t plat_map_dma_mem_page(struct device *dev, struct page *page);
+extern unsigned long plat_dma_addr_to_phys(struct device *dev,
+	dma_addr_t dma_addr);
+
+static inline void plat_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr,
+	size_t size, enum dma_data_direction direction)
+{
+}
+
+static inline int plat_dma_supported(struct device *dev, u64 mask)
+{
+	/*
+	 * we fall back to GFP_DMA when the mask isn't all 1s,
+	 * so we can't guarantee allocations that must be
+	 * within a tighter range than GFP_DMA..
+	 */
+	if (mask < DMA_BIT_MASK(24))
+		return 0;
+
+	return 1;
+}
+
+static inline int plat_device_is_coherent(struct device *dev)
+{
+	return 0;
+}
+
+#define plat_post_dma_flush	bmips_post_dma_flush
+
 #endif /* __ASM_MACH_BMIPS_DMA_COHERENCE_H */
-- 
2.1.0
