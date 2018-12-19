Return-Path: <SRS0=x683=O4=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B104DC43387
	for <linux-mips@archiver.kernel.org>; Wed, 19 Dec 2018 07:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A16C21841
	for <linux-mips@archiver.kernel.org>; Wed, 19 Dec 2018 07:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpHHZQt+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbeLSHIN (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 19 Dec 2018 02:08:13 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34275 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbeLSHIN (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Wed, 19 Dec 2018 02:08:13 -0500
Received: by mail-wr1-f67.google.com with SMTP id j2so18357174wrw.1
        for <linux-mips@vger.kernel.org>; Tue, 18 Dec 2018 23:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0rdFdeR5wsN1QZtfW2Lzo8NR0lTcORoDhBaQZrBtVuo=;
        b=DpHHZQt+8Iw9kujgNZCAva560JJ05CwuKmTpOKa6Y/zcbjErU1BV0yZ92GRVAJk0T0
         eoOJ8UGz0bqGYZIqQ1fkL0npQzzZWpcZAXue485haCmw/AhBicfbafcZRjmO1/f3ZF5d
         buO/iN4rqHG4LdzOtL+fBs1j6GGQgH6kfz4LnChT2oSfbUvjBLGs7kc6ANK9tDRkY6B2
         bl4R/xVHvDOrnQ6pZAMmxRbvJpIExyc4QN60NkYl2+njgEj67kievUapC30XhJsaaLF9
         Ic+ozYXxqYVAY4FaOQFW+vNMg0+gaSsQlxnPJuECysEC4uVkBCMheQ/joyTUvmVQo3Od
         qtmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0rdFdeR5wsN1QZtfW2Lzo8NR0lTcORoDhBaQZrBtVuo=;
        b=G8ClF3V55wlIsHIgSJZFvmk+1563D+iUJWCajGNiFCygukHSiBHL3nqEXtRS8YzLHD
         RUrYVjpNda/x9KsKrSVtmrWc4/2Y2H08ctNt1nfTH6ZDlM8regZHyqgpolas0NJF6o2n
         QKKeYpjLHqpI9S635SL/3puoZ7AmvLqFxmDlNL9AAiVVlJ6EtQpzVGnA6h9mVvVXAaX2
         YzgB2tIlDKmyjvE8wz+a2eHCsAThElY+8Ym386hrdrLi7687eZMyTQ1i1QyItvh892Al
         aIxXDZdpd2HIuurkKK5+joQCSvhrLFXP10lVCPT7gG7pMB2sP1B00ecU8P6GFeCBQ2OF
         4YDw==
X-Gm-Message-State: AA+aEWbqLUjgkKM/chONuSO+8x9P+tU+n9ifqBJmGp8kOME/MVKckm6r
        7JKpAvd48X4yJKrkcT1BEeQ9IgoI
X-Google-Smtp-Source: AFSGD/V1mknNDvCTRK2XNF3OGR98ndNmHsIiV+hbVJmJYi8ugUErZcrBme1Hzo6F5cS4W34WZUhNEQ==
X-Received: by 2002:adf:9061:: with SMTP id h88mr17069701wrh.65.1545203288980;
        Tue, 18 Dec 2018 23:08:08 -0800 (PST)
Received: from flagship2.speedport.ip (p200300C20BD333581B9ECEB655B1C7D2.dip0.t-ipconnect.de. [2003:c2:bd3:3358:1b9e:ceb6:55b1:c7d2])
        by smtp.gmail.com with ESMTPSA id s16sm3245724wrt.77.2018.12.18.23.08.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 23:08:08 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@vger.kernel.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 5/5] MIPS: Alchemy: update dma masks for devboard devices
Date:   Wed, 19 Dec 2018 08:08:03 +0100
Message-Id: <20181219070803.449981-6-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181219070803.449981-1-manuel.lauss@gmail.com>
References: <20181219070803.449981-1-manuel.lauss@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Fix the DMA masks for sound and mmc devices.

Verified on DB1300 and DB1500.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/alchemy/devboards/db1000.c | 18 +++++++++++-------
 arch/mips/alchemy/devboards/db1200.c | 24 +++++++++++-------------
 arch/mips/alchemy/devboards/db1300.c | 23 +++++++++++++++++++----
 arch/mips/alchemy/devboards/db1550.c | 13 +++++++++++--
 4 files changed, 52 insertions(+), 26 deletions(-)

diff --git a/arch/mips/alchemy/devboards/db1000.c b/arch/mips/alchemy/devboards/db1000.c
index aab842a8ddf3..7f99592cf56b 100644
--- a/arch/mips/alchemy/devboards/db1000.c
+++ b/arch/mips/alchemy/devboards/db1000.c
@@ -82,6 +82,8 @@ static int db1500_map_pci_irq(const struct pci_dev *d, u8 slot, u8 pin)
 	return -1;
 }
 
+static u64 au1xxx_all_dmamask = DMA_BIT_MASK(32);
+
 static struct resource alchemy_pci_host_res[] = {
 	[0] = {
 		.start	= AU1500_PCI_PHYS_ADDR,
@@ -120,13 +122,11 @@ static struct resource au1100_lcd_resources[] = {
 	}
 };
 
-static u64 au1100_lcd_dmamask = DMA_BIT_MASK(32);
-
 static struct platform_device au1100_lcd_device = {
 	.name		= "au1100-lcd",
 	.id		= 0,
 	.dev = {
-		.dma_mask		= &au1100_lcd_dmamask,
+		.dma_mask		= &au1xxx_all_dmamask,
 		.coherent_dma_mask	= DMA_BIT_MASK(32),
 	},
 	.num_resources	= ARRAY_SIZE(au1100_lcd_resources),
@@ -170,6 +170,10 @@ static struct platform_device db1x00_codec_dev = {
 
 static struct platform_device db1x00_audio_dev = {
 	.name		= "db1000-audio",
+	.dev = {
+		.dma_mask		= &au1xxx_all_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
 };
 
 /******************************************************************************/
@@ -338,13 +342,11 @@ static struct resource au1100_mmc0_resources[] = {
 	}
 };
 
-static u64 au1xxx_mmc_dmamask =	 DMA_BIT_MASK(32);
-
 static struct platform_device db1100_mmc0_dev = {
 	.name		= "au1xxx-mmc",
 	.id		= 0,
 	.dev = {
-		.dma_mask		= &au1xxx_mmc_dmamask,
+		.dma_mask		= &au1xxx_all_dmamask,
 		.coherent_dma_mask	= DMA_BIT_MASK(32),
 		.platform_data		= &db1100_mmc_platdata[0],
 	},
@@ -379,7 +381,7 @@ static struct platform_device db1100_mmc1_dev = {
 	.name		= "au1xxx-mmc",
 	.id		= 1,
 	.dev = {
-		.dma_mask		= &au1xxx_mmc_dmamask,
+		.dma_mask		= &au1xxx_all_dmamask,
 		.coherent_dma_mask	= DMA_BIT_MASK(32),
 		.platform_data		= &db1100_mmc_platdata[1],
 	},
@@ -416,6 +418,8 @@ static struct platform_device db1100_spi_dev = {
 	.id		= 0,
 	.dev		= {
 		.platform_data	= &db1100_spictl_pd,
+		.dma_mask		= &au1xxx_all_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
 	},
 };
 
diff --git a/arch/mips/alchemy/devboards/db1200.c b/arch/mips/alchemy/devboards/db1200.c
index 4bf02f96ab7f..fb11c578e178 100644
--- a/arch/mips/alchemy/devboards/db1200.c
+++ b/arch/mips/alchemy/devboards/db1200.c
@@ -153,6 +153,8 @@ int __init db1200_board_setup(void)
 
 /******************************************************************************/
 
+static u64 au1200_all_dmamask = DMA_BIT_MASK(32);
+
 static struct mtd_partition db1200_spiflash_parts[] = {
 	{
 		.name	= "spi_flash",
@@ -324,13 +326,11 @@ static struct resource db1200_ide_res[] = {
 	},
 };
 
-static u64 au1200_ide_dmamask = DMA_BIT_MASK(32);
-
 static struct platform_device db1200_ide_dev = {
 	.name		= "pata_platform",
 	.id		= 0,
 	.dev = {
-		.dma_mask		= &au1200_ide_dmamask,
+		.dma_mask		= &au1200_all_dmamask,
 		.coherent_dma_mask	= DMA_BIT_MASK(32),
 		.platform_data		= &db1200_ide_info,
 	},
@@ -566,13 +566,11 @@ static struct resource au1200_mmc0_resources[] = {
 	}
 };
 
-static u64 au1xxx_mmc_dmamask =	 DMA_BIT_MASK(32);
-
 static struct platform_device db1200_mmc0_dev = {
 	.name		= "au1xxx-mmc",
 	.id		= 0,
 	.dev = {
-		.dma_mask		= &au1xxx_mmc_dmamask,
+		.dma_mask		= &au1200_all_dmamask,
 		.coherent_dma_mask	= DMA_BIT_MASK(32),
 		.platform_data		= &db1200_mmc_platdata[0],
 	},
@@ -607,7 +605,7 @@ static struct platform_device pb1200_mmc1_dev = {
 	.name		= "au1xxx-mmc",
 	.id		= 1,
 	.dev = {
-		.dma_mask		= &au1xxx_mmc_dmamask,
+		.dma_mask		= &au1200_all_dmamask,
 		.coherent_dma_mask	= DMA_BIT_MASK(32),
 		.platform_data		= &db1200_mmc_platdata[1],
 	},
@@ -657,13 +655,11 @@ static struct resource au1200_lcd_res[] = {
 	}
 };
 
-static u64 au1200_lcd_dmamask = DMA_BIT_MASK(32);
-
 static struct platform_device au1200_lcd_dev = {
 	.name		= "au1200-lcd",
 	.id		= 0,
 	.dev = {
-		.dma_mask		= &au1200_lcd_dmamask,
+		.dma_mask		= &au1200_all_dmamask,
 		.coherent_dma_mask	= DMA_BIT_MASK(32),
 		.platform_data		= &db1200fb_pd,
 	},
@@ -717,11 +713,9 @@ static struct au1550_spi_info db1200_spi_platdata = {
 	.activate_cs	= db1200_spi_cs_en,
 };
 
-static u64 spi_dmamask = DMA_BIT_MASK(32);
-
 static struct platform_device db1200_spi_dev = {
 	.dev	= {
-		.dma_mask		= &spi_dmamask,
+		.dma_mask		= &au1200_all_dmamask,
 		.coherent_dma_mask	= DMA_BIT_MASK(32),
 		.platform_data		= &db1200_spi_platdata,
 	},
@@ -766,6 +760,10 @@ static struct platform_device db1200_audio_dev = {
 static struct platform_device db1200_sound_dev = {
 	/* name assigned later based on switch setting */
 	.id		= 1,	/* PSC ID */
+	.dev = {
+		.dma_mask		= &au1200_all_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
 };
 
 static struct platform_device db1200_stac_dev = {
diff --git a/arch/mips/alchemy/devboards/db1300.c b/arch/mips/alchemy/devboards/db1300.c
index ad7dd8e89598..8ac1f56ee57d 100644
--- a/arch/mips/alchemy/devboards/db1300.c
+++ b/arch/mips/alchemy/devboards/db1300.c
@@ -148,6 +148,8 @@ static void __init db1300_gpio_config(void)
 
 /**********************************************************************/
 
+static u64 au1300_all_dmamask = DMA_BIT_MASK(32);
+
 static void au1300_nand_cmd_ctrl(struct nand_chip *this, int cmd,
 				 unsigned int ctrl)
 {
@@ -438,6 +440,8 @@ static struct resource db1300_ide_res[] = {
 
 static struct platform_device db1300_ide_dev = {
 	.dev	= {
+		.dma_mask		= &au1300_all_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
 		.platform_data	= &db1300_ide_info,
 	},
 	.name		= "pata_platform",
@@ -560,7 +564,9 @@ static struct resource au1300_sd1_res[] = {
 
 static struct platform_device db1300_sd1_dev = {
 	.dev = {
-		.platform_data	= &db1300_sd1_platdata,
+		.dma_mask		= &au1300_all_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+		.platform_data		= &db1300_sd1_platdata,
 	},
 	.name		= "au1xxx-mmc",
 	.id		= 1,
@@ -625,7 +631,9 @@ static struct resource au1300_sd0_res[] = {
 
 static struct platform_device db1300_sd0_dev = {
 	.dev = {
-		.platform_data	= &db1300_sd0_platdata,
+		.dma_mask		= &au1300_all_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+		.platform_data		= &db1300_sd0_platdata,
 	},
 	.name		= "au1xxx-mmc",
 	.id		= 0,
@@ -652,10 +660,18 @@ static struct platform_device db1300_i2sdma_dev = {
 
 static struct platform_device db1300_sndac97_dev = {
 	.name		= "db1300-ac97",
+	.dev = {
+		.dma_mask		= &au1300_all_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
 };
 
 static struct platform_device db1300_sndi2s_dev = {
 	.name		= "db1300-i2s",
+	.dev = {
+		.dma_mask		= &au1300_all_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
 };
 
 /**********************************************************************/
@@ -700,13 +716,12 @@ static struct resource au1300_lcd_res[] = {
 	}
 };
 
-static u64 au1300_lcd_dmamask = DMA_BIT_MASK(32);
 
 static struct platform_device db1300_lcd_dev = {
 	.name		= "au1200-lcd",
 	.id		= 0,
 	.dev = {
-		.dma_mask		= &au1300_lcd_dmamask,
+		.dma_mask		= &au1300_all_dmamask,
 		.coherent_dma_mask	= DMA_BIT_MASK(32),
 		.platform_data		= &db1300fb_pd,
 	},
diff --git a/arch/mips/alchemy/devboards/db1550.c b/arch/mips/alchemy/devboards/db1550.c
index 7700ad0b93b4..3e0c75c0ece0 100644
--- a/arch/mips/alchemy/devboards/db1550.c
+++ b/arch/mips/alchemy/devboards/db1550.c
@@ -82,6 +82,8 @@ int __init db1550_board_setup(void)
 
 /*****************************************************************************/
 
+static u64 au1550_all_dmamask = DMA_BIT_MASK(32);
+
 static struct mtd_partition db1550_spiflash_parts[] = {
 	{
 		.name	= "spi_flash",
@@ -269,11 +271,10 @@ static struct au1550_spi_info db1550_spi_platdata = {
 	.activate_cs	= db1550_spi_cs_en,
 };
 
-static u64 spi_dmamask = DMA_BIT_MASK(32);
 
 static struct platform_device db1550_spi_dev = {
 	.dev	= {
-		.dma_mask		= &spi_dmamask,
+		.dma_mask		= &au1550_all_dmamask,
 		.coherent_dma_mask	= DMA_BIT_MASK(32),
 		.platform_data		= &db1550_spi_platdata,
 	},
@@ -397,10 +398,18 @@ static struct platform_device db1550_i2sdma_dev = {
 
 static struct platform_device db1550_sndac97_dev = {
 	.name		= "db1550-ac97",
+	.dev = {
+		.dma_mask		= &au1550_all_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
 };
 
 static struct platform_device db1550_sndi2s_dev = {
 	.name		= "db1550-i2s",
+	.dev = {
+		.dma_mask		= &au1550_all_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
 };
 
 /**********************************************************************/
-- 
2.20.0

