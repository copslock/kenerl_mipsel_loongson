Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2012 11:38:19 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:36944 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903699Ab2BQKdj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Feb 2012 11:33:39 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH 5/9] MIPS: lantiq: convert dma driver to clkdev api
Date:   Fri, 17 Feb 2012 11:33:16 +0100
Message-Id: <1329474800-20979-6-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1329474800-20979-1-git-send-email-blogic@openwrt.org>
References: <1329474800-20979-1-git-send-email-blogic@openwrt.org>
X-archive-position: 32449
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Update from old pmu_{dis,en}able() to ckldev api.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/lantiq/xway/dma.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/mips/lantiq/xway/dma.c b/arch/mips/lantiq/xway/dma.c
index 6cf883b..ed04da9 100644
--- a/arch/mips/lantiq/xway/dma.c
+++ b/arch/mips/lantiq/xway/dma.c
@@ -20,6 +20,7 @@
 #include <linux/io.h>
 #include <linux/dma-mapping.h>
 #include <linux/export.h>
+#include <linux/clk.h>
 
 #include <lantiq_soc.h>
 #include <xway_dma.h>
@@ -216,6 +217,7 @@ EXPORT_SYMBOL_GPL(ltq_dma_init_port);
 int __init
 ltq_dma_init(void)
 {
+	struct clk *clk;
 	int i;
 
 	/* remap dma register range */
@@ -224,7 +226,8 @@ ltq_dma_init(void)
 		panic("Failed to remap dma memory");
 
 	/* power up and reset the dma engine */
-	ltq_pmu_enable(PMU_DMA);
+	clk = clk_get_sys("fpi", "dma");
+	clk_enable(clk);
 	ltq_dma_w32_mask(0, DMA_RESET, LTQ_DMA_CTRL);
 
 	/* disable all interrupts */
-- 
1.7.7.1
