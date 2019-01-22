Return-Path: <SRS0=jHXZ=P6=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52A4C282C3
	for <linux-mips@archiver.kernel.org>; Tue, 22 Jan 2019 13:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A38D520879
	for <linux-mips@archiver.kernel.org>; Tue, 22 Jan 2019 13:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="aa38T2oz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbfAVNKo (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:10:44 -0500
Received: from forward106o.mail.yandex.net ([37.140.190.187]:41822 "EHLO
        forward106o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728488AbfAVNKn (ORCPT
        <rfc822;linux-mips@vger.kernel.org>);
        Tue, 22 Jan 2019 08:10:43 -0500
X-Greylist: delayed 318 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Jan 2019 08:10:41 EST
Received: from mxback4g.mail.yandex.net (mxback4g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:165])
        by forward106o.mail.yandex.net (Yandex) with ESMTP id 716E15061729;
        Tue, 22 Jan 2019 16:05:22 +0300 (MSK)
Received: from smtp3p.mail.yandex.net (smtp3p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:8])
        by mxback4g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id OlsEWXwmZ7-5L7SLMjt;
        Tue, 22 Jan 2019 16:05:22 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1548162322;
        bh=rxcZVRlMHjDctv2ssN2QMaqlJZjeB3SIV1dbFY/Ne/Q=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=aa38T2ozUlxq/GmTXbhcnlMDC2TQ2TmnBxJw4ftKOWealVyVOZYscHqe10raaq3Rm
         B/me4PfBn+TToSEDK2hLwkINSvFsKRISoBKBMz0QrWwbMzqvf/O25ZSOBo1WVskD6T
         1k3RdY3XkafhI7A6ynntjVcABNIrmgp6NOmvlDy4=
Authentication-Results: mxback4g.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp3p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id nEDDgaQwiv-5FeS4VFM;
        Tue, 22 Jan 2019 16:05:19 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     keguang.zhang@gmail.com, paul.burton@mips.com,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 1/6] MIPS: Loongson32: Remove unused platform devices
Date:   Tue, 22 Jan 2019 21:04:10 +0800
Message-Id: <20190122130415.3440-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

platform.c contains several unused platform device with no
drivers submited.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 .../include/asm/mach-loongson32/platform.h    |  4 --
 arch/mips/loongson32/common/platform.c        | 63 -------------------
 2 files changed, 67 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson32/platform.h b/arch/mips/include/asm/mach-loongson32/platform.h
index 8f8fa43ba095..15d1de2300fe 100644
--- a/arch/mips/include/asm/mach-loongson32/platform.h
+++ b/arch/mips/include/asm/mach-loongson32/platform.h
@@ -17,19 +17,15 @@
 
 extern struct platform_device ls1x_uart_pdev;
 extern struct platform_device ls1x_cpufreq_pdev;
-extern struct platform_device ls1x_dma_pdev;
 extern struct platform_device ls1x_eth0_pdev;
 extern struct platform_device ls1x_eth1_pdev;
 extern struct platform_device ls1x_ehci_pdev;
 extern struct platform_device ls1x_gpio0_pdev;
 extern struct platform_device ls1x_gpio1_pdev;
-extern struct platform_device ls1x_nand_pdev;
 extern struct platform_device ls1x_rtc_pdev;
 extern struct platform_device ls1x_wdt_pdev;
 
 void __init ls1x_clk_init(void);
-void __init ls1x_dma_set_platdata(struct plat_ls1x_dma *pdata);
-void __init ls1x_nand_set_platdata(struct plat_ls1x_nand *pdata);
 void __init ls1x_rtc_set_extclk(struct platform_device *pdev);
 void __init ls1x_serial_set_uartclk(struct platform_device *pdev);
 
diff --git a/arch/mips/loongson32/common/platform.c b/arch/mips/loongson32/common/platform.c
index ac584c5823d0..0bf355c8bcb2 100644
--- a/arch/mips/loongson32/common/platform.c
+++ b/arch/mips/loongson32/common/platform.c
@@ -81,42 +81,6 @@ struct platform_device ls1x_cpufreq_pdev = {
 	},
 };
 
-/* DMA */
-static struct resource ls1x_dma_resources[] = {
-	[0] = {
-		.start = LS1X_DMAC_BASE,
-		.end = LS1X_DMAC_BASE + SZ_4 - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = LS1X_DMA0_IRQ,
-		.end = LS1X_DMA0_IRQ,
-		.flags = IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start = LS1X_DMA1_IRQ,
-		.end = LS1X_DMA1_IRQ,
-		.flags = IORESOURCE_IRQ,
-	},
-	[3] = {
-		.start = LS1X_DMA2_IRQ,
-		.end = LS1X_DMA2_IRQ,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device ls1x_dma_pdev = {
-	.name		= "ls1x-dma",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(ls1x_dma_resources),
-	.resource	= ls1x_dma_resources,
-};
-
-void __init ls1x_dma_set_platdata(struct plat_ls1x_dma *pdata)
-{
-	ls1x_dma_pdev.dev.platform_data = pdata;
-}
-
 /* Synopsys Ethernet GMAC */
 static struct stmmac_mdio_bus_data ls1x_mdio_bus_data = {
 	.phy_mask	= 0,
@@ -291,33 +255,6 @@ struct platform_device ls1x_gpio1_pdev = {
 	.resource	= ls1x_gpio1_resources,
 };
 
-/* NAND Flash */
-static struct resource ls1x_nand_resources[] = {
-	[0] = {
-		.start	= LS1X_NAND_BASE,
-		.end	= LS1X_NAND_BASE + SZ_32 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		/* DMA channel 0 is dedicated to NAND */
-		.start	= LS1X_DMA_CHANNEL0,
-		.end	= LS1X_DMA_CHANNEL0,
-		.flags	= IORESOURCE_DMA,
-	},
-};
-
-struct platform_device ls1x_nand_pdev = {
-	.name		= "ls1x-nand",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(ls1x_nand_resources),
-	.resource	= ls1x_nand_resources,
-};
-
-void __init ls1x_nand_set_platdata(struct plat_ls1x_nand *pdata)
-{
-	ls1x_nand_pdev.dev.platform_data = pdata;
-}
-
 /* USB EHCI */
 static u64 ls1x_ehci_dmamask = DMA_BIT_MASK(32);
 
-- 
2.20.1

