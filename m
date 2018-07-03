Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Jul 2018 14:33:53 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:33004 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994583AbeGCMceanWVz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Jul 2018 14:32:34 +0200
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 05/14] dmaengine: dma-jz4780: Add support for the JZ4740 SoC
Date:   Tue,  3 Jul 2018 14:32:05 +0200
Message-Id: <20180703123214.23090-6-paul@crapouillou.net>
In-Reply-To: <20180703123214.23090-1-paul@crapouillou.net>
References: <20180703123214.23090-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1530621153; bh=3A57Tphh16JtBqx4iFmY3oVLDPbKp4B9P61Ul8WrKnc=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=I3JhKZNaQAgxLH27OhxamVAAL2rP4dtgxd7TwmOZ+B2sRIquCn1L8jmfUaALeRKcN3gJjqHoT83EwFp08TEKJG4SMkY6UxYP6Dtuhzvwq+fwpm2OtbHW/jYAAWndSX2KlxX+toOgG1mtK1GRnOx2WgGUgyY41eEI1vsnswvz7JY=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64569
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@crapouillou.net
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

The JZ4740 SoC has a single DMA core starring six DMA channels.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 Documentation/devicetree/bindings/dma/jz4780-dma.txt | 1 +
 drivers/dma/Kconfig                                  | 2 +-
 drivers/dma/dma-jz4780.c                             | 4 ++++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/jz4780-dma.txt b/Documentation/devicetree/bindings/dma/jz4780-dma.txt
index 0fd0759053be..d7ca3f925fdf 100644
--- a/Documentation/devicetree/bindings/dma/jz4780-dma.txt
+++ b/Documentation/devicetree/bindings/dma/jz4780-dma.txt
@@ -5,6 +5,7 @@ Required properties:
 - compatible: Should be one of:
   * ingenic,jz4780-dma
   * ingenic,jz4770-dma
+  * ingenic,jz4740-dma
 - reg: Should contain the DMA channel registers location and length, followed
   by the DMA controller registers location and length.
 - interrupts: Should contain the interrupt specifier of the DMA controller.
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 48d25dccedb7..a935d15ec581 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -143,7 +143,7 @@ config DMA_JZ4740
 
 config DMA_JZ4780
 	tristate "JZ4780 DMA support"
-	depends on MACH_JZ4780 || MACH_JZ4770 || COMPILE_TEST
+	depends on MACH_INGENIC || COMPILE_TEST
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 7b8b2dcd119e..ccadbe61dde7 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -133,6 +133,7 @@ struct jz4780_dma_chan {
 };
 
 enum jz_version {
+	ID_JZ4740,
 	ID_JZ4770,
 	ID_JZ4780,
 };
@@ -247,6 +248,7 @@ static void jz4780_dma_desc_free(struct virt_dma_desc *vdesc)
 }
 
 static const unsigned int jz4780_dma_ord_max[] = {
+	[ID_JZ4740] = 5,
 	[ID_JZ4770] = 6,
 	[ID_JZ4780] = 7,
 };
@@ -801,11 +803,13 @@ static struct dma_chan *jz4780_of_dma_xlate(struct of_phandle_args *dma_spec,
 }
 
 static const unsigned int jz4780_dma_nb_channels[] = {
+	[ID_JZ4740] = 6,
 	[ID_JZ4770] = 6,
 	[ID_JZ4780] = 32,
 };
 
 static const struct of_device_id jz4780_dma_dt_match[] = {
+	{ .compatible = "ingenic,jz4740-dma", .data = (void *)ID_JZ4740 },
 	{ .compatible = "ingenic,jz4770-dma", .data = (void *)ID_JZ4770 },
 	{ .compatible = "ingenic,jz4780-dma", .data = (void *)ID_JZ4780 },
 	{},
-- 
2.18.0
