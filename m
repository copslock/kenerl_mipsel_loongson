Return-Path: <SRS0=fNfu=SN=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57201C10F13
	for <linux-mips@archiver.kernel.org>; Thu, 11 Apr 2019 12:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25BA62083E
	for <linux-mips@archiver.kernel.org>; Thu, 11 Apr 2019 12:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="JONSPgkN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfDKMTl (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:19:41 -0400
Received: from forward102o.mail.yandex.net ([37.140.190.182]:41927 "EHLO
        forward102o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726121AbfDKMTk (ORCPT
        <rfc822;linux-mips@vger.kernel.org>);
        Thu, 11 Apr 2019 08:19:40 -0400
Received: from mxback4j.mail.yandex.net (mxback4j.mail.yandex.net [IPv6:2a02:6b8:0:1619::10d])
        by forward102o.mail.yandex.net (Yandex) with ESMTP id 7467D6680DED;
        Thu, 11 Apr 2019 15:19:37 +0300 (MSK)
Received: from smtp2o.mail.yandex.net (smtp2o.mail.yandex.net [2a02:6b8:0:1a2d::26])
        by mxback4j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id jNWUUu7otR-JaB8LQGo;
        Thu, 11 Apr 2019 15:19:37 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1554985177;
        bh=6Jv6KIqpfZutwKG/fs90WqWAeomDW4QQyg5IfA95Vb8=;
        h=In-Reply-To:Subject:To:From:Message-Id:Cc:References:Date;
        b=JONSPgkN37jZ0wtMf5AV7UxtKg2NOHX516+vVV1QlF0mSPshj4U++NQTdBAyENQnK
         FL7mmbUy/Yib88fT5fmVZ1GeoJC9a0UsF4chiOEPj1H4hExbbXnAREzwGqsFyjEgeI
         GA7Tg2Xvp4BIqEyZYnFCdD2OhHJG+J+YaJkMgQgQ=
Authentication-Results: mxback4j.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp2o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id QbB7ClwXzg-JTCmWWn1;
        Thu, 11 Apr 2019 15:19:34 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     devicetree@vger.kernel.org, paul.burton@mips.com,
        robh+dt@kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 1/6] MIPS: Loongson32: Remove ehci platform device
Date:   Thu, 11 Apr 2019 20:19:10 +0800
Message-Id: <20190411121915.8040-2-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190411121915.8040-1-jiaxun.yang@flygoat.com>
References: <20190312091520.8863-2-jiaxun.yang@flygoat.com>
 <20190411121915.8040-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

It's going to be enabled by DeviceTree

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 .../include/asm/mach-loongson32/platform.h    |  1 -
 arch/mips/loongson32/common/platform.c        | 30 -------------------
 arch/mips/loongson32/ls1b/board.c             |  1 -
 3 files changed, 32 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson32/platform.h b/arch/mips/include/asm/mach-loongson32/platform.h
index 15d1de2300fe..f36c8d287b59 100644
--- a/arch/mips/include/asm/mach-loongson32/platform.h
+++ b/arch/mips/include/asm/mach-loongson32/platform.h
@@ -19,7 +19,6 @@ extern struct platform_device ls1x_uart_pdev;
 extern struct platform_device ls1x_cpufreq_pdev;
 extern struct platform_device ls1x_eth0_pdev;
 extern struct platform_device ls1x_eth1_pdev;
-extern struct platform_device ls1x_ehci_pdev;
 extern struct platform_device ls1x_gpio0_pdev;
 extern struct platform_device ls1x_gpio1_pdev;
 extern struct platform_device ls1x_rtc_pdev;
diff --git a/arch/mips/loongson32/common/platform.c b/arch/mips/loongson32/common/platform.c
index 0bf355c8bcb2..4b35f49e9fcb 100644
--- a/arch/mips/loongson32/common/platform.c
+++ b/arch/mips/loongson32/common/platform.c
@@ -10,12 +10,10 @@
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
-#include <linux/mtd/partitions.h>
 #include <linux/sizes.h>
 #include <linux/phy.h>
 #include <linux/serial_8250.h>
 #include <linux/stmmac.h>
-#include <linux/usb/ehci_pdriver.h>
 
 #include <platform.h>
 #include <loongson1.h>
@@ -255,34 +253,6 @@ struct platform_device ls1x_gpio1_pdev = {
 	.resource	= ls1x_gpio1_resources,
 };
 
-/* USB EHCI */
-static u64 ls1x_ehci_dmamask = DMA_BIT_MASK(32);
-
-static struct resource ls1x_ehci_resources[] = {
-	[0] = {
-		.start	= LS1X_EHCI_BASE,
-		.end	= LS1X_EHCI_BASE + SZ_32K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= LS1X_EHCI_IRQ,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct usb_ehci_pdata ls1x_ehci_pdata = {
-};
-
-struct platform_device ls1x_ehci_pdev = {
-	.name		= "ehci-platform",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(ls1x_ehci_resources),
-	.resource	= ls1x_ehci_resources,
-	.dev		= {
-		.dma_mask = &ls1x_ehci_dmamask,
-		.platform_data = &ls1x_ehci_pdata,
-	},
-};
 
 /* Real Time Clock */
 void __init ls1x_rtc_set_extclk(struct platform_device *pdev)
diff --git a/arch/mips/loongson32/ls1b/board.c b/arch/mips/loongson32/ls1b/board.c
index 447b15fc0a2b..74f7b530d9b1 100644
--- a/arch/mips/loongson32/ls1b/board.c
+++ b/arch/mips/loongson32/ls1b/board.c
@@ -42,7 +42,6 @@ static struct platform_device *ls1b_platform_devices[] __initdata = {
 	&ls1x_cpufreq_pdev,
 	&ls1x_eth0_pdev,
 	&ls1x_eth1_pdev,
-	&ls1x_ehci_pdev,
 	&ls1x_gpio0_pdev,
 	&ls1x_gpio1_pdev,
 	&ls1x_rtc_pdev,
-- 
2.21.0

