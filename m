Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Nov 2012 19:38:05 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:42433 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6826537Ab2KISh2jwuTU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Nov 2012 19:37:28 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH 3/6] MIPS: lantiq: verbose init of dma core
Date:   Fri,  9 Nov 2012 19:36:20 +0100
Message-Id: <1352486183-22576-3-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1352486183-22576-1-git-send-email-blogic@openwrt.org>
References: <1352486183-22576-1-git-send-email-blogic@openwrt.org>
X-archive-position: 34924
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Print the hardware revision and port/channel info when starting the dma core.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/lantiq/xway/dma.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/mips/lantiq/xway/dma.c b/arch/mips/lantiq/xway/dma.c
index 55d2c4f..b5d76d1 100644
--- a/arch/mips/lantiq/xway/dma.c
+++ b/arch/mips/lantiq/xway/dma.c
@@ -25,6 +25,7 @@
 #include <lantiq_soc.h>
 #include <xway_dma.h>
 
+#define LTQ_DMA_ID		0x08
 #define LTQ_DMA_CTRL		0x10
 #define LTQ_DMA_CPOLL		0x14
 #define LTQ_DMA_CS		0x18
@@ -214,6 +215,7 @@ ltq_dma_init(struct platform_device *pdev)
 {
 	struct clk *clk;
 	struct resource *res;
+	unsigned id;
 	int i;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -243,7 +245,12 @@ ltq_dma_init(struct platform_device *pdev)
 		ltq_dma_w32(DMA_POLL | DMA_CLK_DIV4, LTQ_DMA_CPOLL);
 		ltq_dma_w32_mask(DMA_CHAN_ON, 0, LTQ_DMA_CCTRL);
 	}
-	dev_info(&pdev->dev, "init done\n");
+
+	id = ltq_dma_r32(LTQ_DMA_ID);
+	dev_info(&pdev->dev,
+		"Init done - hw rev: %X, ports: %d, channels: %d\n",
+		id & 0x1f, (id >> 16) & 0xf, id >> 20);
+
 	return 0;
 }
 
-- 
1.7.10.4
