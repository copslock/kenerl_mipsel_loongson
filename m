Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jun 2010 18:26:28 +0200 (CEST)
Received: from sh.osrg.net ([192.16.179.4]:33859 "EHLO sh.osrg.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491973Ab0FWQ0Z (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 23 Jun 2010 18:26:25 +0200
Received: from localhost (rose.osrg.net [10.76.0.1])
        by sh.osrg.net (8.14.3/8.14.3/OSRG-NET) with ESMTP id o5NGQ943009169;
        Thu, 24 Jun 2010 01:26:11 +0900
Date:   Thu, 24 Jun 2010 01:26:09 +0900
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, manuel.lauss@gmail.com
Subject: [PATCH] MIPS: Alchemy: fix deprecated compile warnings
From:   FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20100624012415L.fujita.tomonori@lab.ntt.co.jp>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (sh.osrg.net [192.16.179.4]); Thu, 24 Jun 2010 01:26:11 +0900 (JST)
X-Virus-Scanned: clamav-milter 0.96.1 at sh
X-Virus-Status: Clean
X-archive-position: 27246
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fujita.tomonori@lab.ntt.co.jp
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 16106

I got the following errors on linux-next. They might be already
addressed (I've not subscribed to linux-mips@linux-mips), but anyway
here's a fix.

=
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: [PATCH] MIPS: Alchemy: fix deprecated compile warnings

replace deprecated DMA_32BIT_MASK with DMA_BIT_MASK.

cc1: warnings being treated as errors
arch/mips/alchemy/devboards/db1200/platform.c:219: error: 'DMA_nnBIT_MASK' is deprecated
arch/mips/alchemy/devboards/db1200/platform.c:226: error: 'DMA_nnBIT_MASK' is deprecated
arch/mips/alchemy/devboards/db1200/platform.c:388: error: 'DMA_nnBIT_MASK' is deprecated
arch/mips/alchemy/devboards/db1200/platform.c:393: error: 'DMA_nnBIT_MASK' is deprecated

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
---
 arch/mips/alchemy/devboards/db1200/platform.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/alchemy/devboards/db1200/platform.c b/arch/mips/alchemy/devboards/db1200/platform.c
index 3cb95a9..3fa34c3 100644
--- a/arch/mips/alchemy/devboards/db1200/platform.c
+++ b/arch/mips/alchemy/devboards/db1200/platform.c
@@ -216,14 +216,14 @@ static struct resource db1200_ide_res[] = {
 	}
 };
 
-static u64 ide_dmamask = DMA_32BIT_MASK;
+static u64 ide_dmamask = DMA_BIT_MASK(32);
 
 static struct platform_device db1200_ide_dev = {
 	.name		= "au1200-ide",
 	.id		= 0,
 	.dev = {
 		.dma_mask 		= &ide_dmamask,
-		.coherent_dma_mask	= DMA_32BIT_MASK,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
 	},
 	.num_resources	= ARRAY_SIZE(db1200_ide_res),
 	.resource	= db1200_ide_res,
@@ -385,12 +385,12 @@ static struct au1550_spi_info db1200_spi_platdata = {
 	.activate_cs	= db1200_spi_cs_en,
 };
 
-static u64 spi_dmamask = DMA_32BIT_MASK;
+static u64 spi_dmamask = DMA_BIT_MASK(32);
 
 static struct platform_device db1200_spi_dev = {
 	.dev	= {
 		.dma_mask		= &spi_dmamask,
-		.coherent_dma_mask	= DMA_32BIT_MASK,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
 		.platform_data		= &db1200_spi_platdata,
 	},
 	.name		= "au1550-spi",
-- 
1.6.5
