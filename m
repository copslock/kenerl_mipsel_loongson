Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Nov 2010 12:33:02 +0100 (CET)
Received: from smtp-68.nebula.fi ([83.145.220.68]:42036 "EHLO
        smtp-68.nebula.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491894Ab0KWLcz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Nov 2010 12:32:55 +0100
Received: from localhost.localdomain (dyn-xdsl-83-150-115-228.nebulazone.fi [83.150.115.228])
        by smtp-68.nebula.fi (Postfix) with ESMTP id BE41A43F0497;
        Tue, 23 Nov 2010 13:32:43 +0200 (EET)
From:   Dmitri Vorobiev <dmitri.vorobiev@movial.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     Dmitri Vorobiev <dmitri.vorobiev@movial.com>
Subject: [PATCH] MIPS: Fix build failure for IP22
Date:   Tue, 23 Nov 2010 13:32:28 +0200
Message-Id: <1290511948-10347-1-git-send-email-dmitri.vorobiev@movial.com>
X-Mailer: git-send-email 1.7.0.4
Return-Path: <dmitri.vorobiev@movial.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28460
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.com
Precedence: bulk
X-list: linux-mips

Commit 48e1fd5a81416a037f5a48120bf281102f2584e2 changed the name
of the MIPS-specific dma_cache_sync() routine by prefixing it with
`mips_', and removed the export for its symbol. Two drivers, which
did use dma_cache_sync(), namely, sgiseeq and sgiwd93, were not
converted to use the new function, which led to build failure for
the IP22 platform.

This patch fixes the build failure by fixing the call sites of
mips_dma_cache_sync() and exporting the symbol for this routine as
a GPL symbol. While at it, some minor changes to improve Kconfig
help entries were done.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.com>
---
 arch/mips/include/asm/dma-mapping.h |    2 +-
 arch/mips/mm/dma-default.c          |    1 +
 drivers/net/Kconfig                 |    3 +++
 drivers/net/sgiseeq.c               |    8 ++++----
 drivers/scsi/Kconfig                |    3 +++
 drivers/scsi/sgiwd93.c              |    2 +-
 6 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/dma-mapping.h
index 655f849..ecf669d 100644
--- a/arch/mips/include/asm/dma-mapping.h
+++ b/arch/mips/include/asm/dma-mapping.h
@@ -52,7 +52,7 @@ dma_set_mask(struct device *dev, u64 mask)
 	return 0;
 }
 
-extern void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
+extern void mips_dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 	       enum dma_data_direction direction);
 
 static inline void *dma_alloc_coherent(struct device *dev, size_t size,
diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index 4fc1a0f..114e9bb 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -297,6 +297,7 @@ void mips_dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 	if (!plat_device_is_coherent(dev))
 		__dma_sync((unsigned long)vaddr, size, direction);
 }
+EXPORT_SYMBOL_GPL(mips_dma_cache_sync);
 
 static struct dma_map_ops mips_default_dma_map_ops = {
 	.alloc_coherent = mips_dma_alloc_coherent,
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index f6668cd..fe64edc 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -1925,6 +1925,9 @@ config SGISEEQ
 	  Say Y here if you have an Seeq based Ethernet network card. This is
 	  used in many Silicon Graphics machines.
 
+	  To compile this driver as a module, choose M here: the module
+	  will be called sgiseeq.
+
 config DECLANCE
 	tristate "DEC LANCE ethernet controller support"
 	depends on MACH_DECSTATION
diff --git a/drivers/net/sgiseeq.c b/drivers/net/sgiseeq.c
index 3a0cc63..6ecefd2 100644
--- a/drivers/net/sgiseeq.c
+++ b/drivers/net/sgiseeq.c
@@ -111,14 +111,14 @@ struct sgiseeq_private {
 
 static inline void dma_sync_desc_cpu(struct net_device *dev, void *addr)
 {
-	dma_cache_sync(dev->dev.parent, addr, sizeof(struct sgiseeq_rx_desc),
-		       DMA_FROM_DEVICE);
+	mips_dma_cache_sync(dev->dev.parent, addr,
+		sizeof(struct sgiseeq_rx_desc), DMA_FROM_DEVICE);
 }
 
 static inline void dma_sync_desc_dev(struct net_device *dev, void *addr)
 {
-	dma_cache_sync(dev->dev.parent, addr, sizeof(struct sgiseeq_rx_desc),
-		       DMA_TO_DEVICE);
+	mips_dma_cache_sync(dev->dev.parent, addr,
+		sizeof(struct sgiseeq_rx_desc), DMA_TO_DEVICE);
 }
 
 static inline void hpc3_eth_reset(struct hpc3_ethregs *hregs)
diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 8616496..2d868bf 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -390,6 +390,9 @@ config SGIWD93_SCSI
 	  If you have a Western Digital WD93 SCSI controller on
 	  an SGI MIPS system, say Y.  Otherwise, say N.
 
+	  To compile this driver as a module, choose M here: the
+	  module will be called sgiwd93.
+
 config BLK_DEV_3W_XXXX_RAID
 	tristate "3ware 5/6/7/8xxx ATA-RAID support"
 	depends on PCI && SCSI
diff --git a/drivers/scsi/sgiwd93.c b/drivers/scsi/sgiwd93.c
index fef0e3c..be9fc40 100644
--- a/drivers/scsi/sgiwd93.c
+++ b/drivers/scsi/sgiwd93.c
@@ -95,7 +95,7 @@ void fill_hpc_entries(struct ip22_hostdata *hd, struct scsi_cmnd *cmd, int din)
 	 */
 	hcp->desc.pbuf = 0;
 	hcp->desc.cntinfo = HPCDMA_EOX;
-	dma_cache_sync(hd->dev, hd->cpu,
+	mips_dma_cache_sync(hd->dev, hd->cpu,
 		       (unsigned long)(hcp + 1) - (unsigned long)hd->cpu,
 		       DMA_TO_DEVICE);
 }
-- 
1.7.0.4
