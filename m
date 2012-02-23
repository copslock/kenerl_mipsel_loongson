Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Feb 2012 17:07:25 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:47364 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903753Ab2BWQDe (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 23 Feb 2012 17:03:34 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH V2 06/14] MIPS: lantiq: convert dma driver to clkdev api
Date:   Thu, 23 Feb 2012 17:03:05 +0100
Message-Id: <1330012993-13510-6-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1330012993-13510-1-git-send-email-blogic@openwrt.org>
References: <1330012993-13510-1-git-send-email-blogic@openwrt.org>
X-archive-position: 32512
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
 arch/mips/lantiq/xway/dma.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/mips/lantiq/xway/dma.c b/arch/mips/lantiq/xway/dma.c
index 6cf883b..ce86529 100644
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
@@ -224,7 +226,9 @@ ltq_dma_init(void)
 		panic("Failed to remap dma memory");
 
 	/* power up and reset the dma engine */
-	ltq_pmu_enable(PMU_DMA);
+	clk = clk_get_sys("ltq_dma", NULL);
+	WARN_ON(!clk);
+	clk_enable(clk);
 	ltq_dma_w32_mask(0, DMA_RESET, LTQ_DMA_CTRL);
 
 	/* disable all interrupts */
-- 
1.7.7.1
