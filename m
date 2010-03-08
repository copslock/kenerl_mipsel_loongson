Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Mar 2010 20:22:58 +0100 (CET)
Received: from mail-fx0-f217.google.com ([209.85.220.217]:63613 "EHLO
        mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492481Ab0CHTWC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Mar 2010 20:22:02 +0100
Received: by fxm9 with SMTP id 9so1891984fxm.24
        for <linux-mips@linux-mips.org>; Mon, 08 Mar 2010 11:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=fCQjeZS/3WdHUkjxDMDleRega9y9gUm1oM2nZS1cASI=;
        b=YlgRNoLra2dENwr0J2/MdolrLMwH1iYYR+QRPXOdjvyf92Sog/zufR+Oq9VSSItjLU
         aXIhCtoFH76gAv989lrLiHFwuvCsW7ufvsgFvApq8oN/09JGyFoWUU0vRL+C3jHKbUSc
         duAYJopPG9qUXf7TZiJYC71dBmKPr3RdDgAfw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=cQDSGrVTeUjZujxx6KBWfnX0Cw99ak75RZS0HhDICoPtC1ulw3EoHiiX1ZU4ucHD1X
         U98q1ij6HAotzFZE60vBtqA0IfYZsbgJ7HJSMtkLE3pSMNHZZ0d3wOrQl50Z8iaMOzwR
         d7T3QdoeXH8sB48JpTuoOjPbmRhkHAo1WxYY0=
Received: by 10.223.5.70 with SMTP id 6mr2622482fau.18.1268076116956;
        Mon, 08 Mar 2010 11:21:56 -0800 (PST)
Received: from localhost.localdomain (p5496CE16.dip.t-dialin.net [84.150.206.22])
        by mx.google.com with ESMTPS id b17sm9039919fka.43.2010.03.08.11.21.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Mar 2010 11:21:56 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH] MIPS: Alchemy: move MMC driver registration to board code.
Date:   Mon,  8 Mar 2010 20:23:01 +0100
Message-Id: <1268076181-29642-3-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.7.0.2
In-Reply-To: <1268076181-29642-1-git-send-email-manuel.lauss@gmail.com>
References: <1268076181-29642-1-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26147
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Where it really belongs to.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/alchemy/common/platform.c           |   81 -------------------------
 arch/mips/alchemy/devboards/db1200/platform.c |   48 +++++++++++++--
 arch/mips/alchemy/devboards/pb1200/platform.c |   79 +++++++++++++++++++++++-
 3 files changed, 119 insertions(+), 89 deletions(-)

diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/common/platform.c
index 2580e77..e1ed1ad 100644
--- a/arch/mips/alchemy/common/platform.c
+++ b/arch/mips/alchemy/common/platform.c
@@ -18,7 +18,6 @@
 
 #include <asm/mach-au1x00/au1xxx.h>
 #include <asm/mach-au1x00/au1xxx_dbdma.h>
-#include <asm/mach-au1x00/au1100_mmc.h>
 #include <asm/mach-au1x00/au1xxx_eth.h>
 
 #define PORT(_base, _irq)					\
@@ -231,82 +230,6 @@ static struct platform_device au1200_lcd_device = {
 	.num_resources  = ARRAY_SIZE(au1200_lcd_resources),
 	.resource       = au1200_lcd_resources,
 };
-
-static u64 au1xxx_mmc_dmamask =  DMA_BIT_MASK(32);
-
-extern struct au1xmmc_platform_data au1xmmc_platdata[2];
-
-static struct resource au1200_mmc0_resources[] = {
-	[0] = {
-		.start          = SD0_PHYS_ADDR,
-		.end            = SD0_PHYS_ADDR + 0x7ffff,
-		.flags          = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start		= AU1200_SD_INT,
-		.end		= AU1200_SD_INT,
-		.flags		= IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start		= DSCR_CMD0_SDMS_TX0,
-		.end		= DSCR_CMD0_SDMS_TX0,
-		.flags		= IORESOURCE_DMA,
-	},
-	[3] = {
-		.start          = DSCR_CMD0_SDMS_RX0,
-		.end		= DSCR_CMD0_SDMS_RX0,
-		.flags          = IORESOURCE_DMA,
-	}
-};
-
-static struct platform_device au1200_mmc0_device = {
-	.name = "au1xxx-mmc",
-	.id = 0,
-	.dev = {
-		.dma_mask		= &au1xxx_mmc_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-		.platform_data		= &au1xmmc_platdata[0],
-	},
-	.num_resources	= ARRAY_SIZE(au1200_mmc0_resources),
-	.resource	= au1200_mmc0_resources,
-};
-
-#ifndef CONFIG_MIPS_DB1200
-static struct resource au1200_mmc1_resources[] = {
-	[0] = {
-		.start          = SD1_PHYS_ADDR,
-		.end            = SD1_PHYS_ADDR + 0x7ffff,
-		.flags          = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start		= AU1200_SD_INT,
-		.end		= AU1200_SD_INT,
-		.flags		= IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start		= DSCR_CMD0_SDMS_TX1,
-		.end		= DSCR_CMD0_SDMS_TX1,
-		.flags		= IORESOURCE_DMA,
-	},
-	[3] = {
-		.start          = DSCR_CMD0_SDMS_RX1,
-		.end		= DSCR_CMD0_SDMS_RX1,
-		.flags          = IORESOURCE_DMA,
-	}
-};
-
-static struct platform_device au1200_mmc1_device = {
-	.name = "au1xxx-mmc",
-	.id = 1,
-	.dev = {
-		.dma_mask		= &au1xxx_mmc_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-		.platform_data		= &au1xmmc_platdata[1],
-	},
-	.num_resources	= ARRAY_SIZE(au1200_mmc1_resources),
-	.resource	= au1200_mmc1_resources,
-};
-#endif /* #ifndef CONFIG_MIPS_DB1200 */
 #endif /* #ifdef CONFIG_SOC_AU1200 */
 
 /* All Alchemy demoboards with I2C have this #define in their headers */
@@ -421,10 +344,6 @@ static struct platform_device *au1xxx_platform_devices[] __initdata = {
 	&au1xxx_usb_gdt_device,
 	&au1xxx_usb_otg_device,
 	&au1200_lcd_device,
-	&au1200_mmc0_device,
-#ifndef CONFIG_MIPS_DB1200
-	&au1200_mmc1_device,
-#endif
 #endif
 #ifdef SMBUS_PSC_BASE
 	&pbdb_smbus_device,
diff --git a/arch/mips/alchemy/devboards/db1200/platform.c b/arch/mips/alchemy/devboards/db1200/platform.c
index 3cb95a9..9afb287 100644
--- a/arch/mips/alchemy/devboards/db1200/platform.c
+++ b/arch/mips/alchemy/devboards/db1200/platform.c
@@ -329,14 +329,49 @@ static struct led_classdev db1200_mmc_led = {
 };
 
 /* needed by arch/mips/alchemy/common/platform.c */
-struct au1xmmc_platform_data au1xmmc_platdata[] = {
+static struct au1xmmc_platform_data db1200_mmc_platdata = {
+	.cd_setup	= db1200_mmc_cd_setup,
+	.set_power	= db1200_mmc_set_power,
+	.card_inserted	= db1200_mmc_card_inserted,
+	.card_readonly	= db1200_mmc_card_readonly,
+	.led		= &db1200_mmc_led,
+};
+
+static u64 au1xxx_mmc_dmamask =  DMA_BIT_MASK(32);
+
+static struct resource au1200_mmc0_resources[] = {
 	[0] = {
-		.cd_setup	= db1200_mmc_cd_setup,
-		.set_power	= db1200_mmc_set_power,
-		.card_inserted	= db1200_mmc_card_inserted,
-		.card_readonly	= db1200_mmc_card_readonly,
-		.led		= &db1200_mmc_led,
+		.start          = SD0_PHYS_ADDR,
+		.end            = SD0_PHYS_ADDR + 0x7ffff,
+		.flags          = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start		= AU1200_SD_INT,
+		.end		= AU1200_SD_INT,
+		.flags		= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start		= DSCR_CMD0_SDMS_TX0,
+		.end		= DSCR_CMD0_SDMS_TX0,
+		.flags		= IORESOURCE_DMA,
+	},
+	[3] = {
+		.start          = DSCR_CMD0_SDMS_RX0,
+		.end		= DSCR_CMD0_SDMS_RX0,
+		.flags          = IORESOURCE_DMA,
+	}
+};
+
+static struct platform_device db1200_mmc0_dev = {
+	.name = "au1xxx-mmc",
+	.id = 0,
+	.dev = {
+		.dma_mask		= &au1xxx_mmc_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+		.platform_data		= &db1200_mmc_platdata,
 	},
+	.num_resources	= ARRAY_SIZE(au1200_mmc0_resources),
+	.resource	= au1200_mmc0_resources,
 };
 
 /**********************************************************************/
@@ -436,6 +471,7 @@ static struct platform_device *db1200_devs[] __initdata = {
 	&db1200_rtc_dev,
 	&db1200_nand_dev,
 	&db1200_audio_dev,
+	&db1200_mmc0_dev,
 };
 
 static int __init db1200_dev_init(void)
diff --git a/arch/mips/alchemy/devboards/pb1200/platform.c b/arch/mips/alchemy/devboards/pb1200/platform.c
index 3ef2dce..89e6f1d 100644
--- a/arch/mips/alchemy/devboards/pb1200/platform.c
+++ b/arch/mips/alchemy/devboards/pb1200/platform.c
@@ -25,6 +25,7 @@
 #include <linux/smc91x.h>
 
 #include <asm/mach-au1x00/au1xxx.h>
+#include <asm/mach-au1x00/au1xxx_dbdma.h>
 #include <asm/mach-au1x00/au1100_mmc.h>
 #include <asm/mach-db1x00/bcsr.h>
 
@@ -88,7 +89,7 @@ static int pb1200mmc1_card_inserted(void *mmc_host)
 	return (bcsr_read(BCSR_SIGSTAT) & BCSR_INT_SD1INSERT) ? 1 : 0;
 }
 
-const struct au1xmmc_platform_data au1xmmc_platdata[2] = {
+static struct au1xmmc_platform_data pb1200_mmc_platdata[2] = {
 	[0] = {
 		.set_power	= pb1200mmc0_set_power,
 		.card_inserted	= pb1200mmc0_card_inserted,
@@ -105,6 +106,78 @@ const struct au1xmmc_platform_data au1xmmc_platdata[2] = {
 	},
 };
 
+static u64 au1xxx_mmc_dmamask =  DMA_BIT_MASK(32);
+
+static struct resource au1200_mmc0_resources[] = {
+	[0] = {
+		.start          = SD0_PHYS_ADDR,
+		.end            = SD0_PHYS_ADDR + 0x7ffff,
+		.flags          = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start		= AU1200_SD_INT,
+		.end		= AU1200_SD_INT,
+		.flags		= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start		= DSCR_CMD0_SDMS_TX0,
+		.end		= DSCR_CMD0_SDMS_TX0,
+		.flags		= IORESOURCE_DMA,
+	},
+	[3] = {
+		.start          = DSCR_CMD0_SDMS_RX0,
+		.end		= DSCR_CMD0_SDMS_RX0,
+		.flags          = IORESOURCE_DMA,
+	}
+};
+
+static struct platform_device pb1200_mmc0_device = {
+	.name = "au1xxx-mmc",
+	.id = 0,
+	.dev = {
+		.dma_mask		= &au1xxx_mmc_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+		.platform_data		= &pb1200_mmc_platdata[0],
+	},
+	.num_resources	= ARRAY_SIZE(au1200_mmc0_resources),
+	.resource	= au1200_mmc0_resources,
+};
+
+static struct resource au1200_mmc1_resources[] = {
+	[0] = {
+		.start          = SD1_PHYS_ADDR,
+		.end            = SD1_PHYS_ADDR + 0x7ffff,
+		.flags          = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start		= AU1200_SD_INT,
+		.end		= AU1200_SD_INT,
+		.flags		= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start		= DSCR_CMD0_SDMS_TX1,
+		.end		= DSCR_CMD0_SDMS_TX1,
+		.flags		= IORESOURCE_DMA,
+	},
+	[3] = {
+		.start          = DSCR_CMD0_SDMS_RX1,
+		.end		= DSCR_CMD0_SDMS_RX1,
+		.flags          = IORESOURCE_DMA,
+	}
+};
+
+static struct platform_device pb1200_mmc1_device = {
+	.name = "au1xxx-mmc",
+	.id = 1,
+	.dev = {
+		.dma_mask		= &au1xxx_mmc_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+		.platform_data		= &pb1200_mmc_platdata[1],
+	},
+	.num_resources	= ARRAY_SIZE(au1200_mmc1_resources),
+	.resource	= au1200_mmc1_resources,
+};
+
 static struct resource ide_resources[] = {
 	[0] = {
 		.start	= IDE_PHYS_ADDR,
@@ -163,7 +236,9 @@ static struct platform_device smc91c111_device = {
 
 static struct platform_device *board_platform_devices[] __initdata = {
 	&ide_device,
-	&smc91c111_device
+	&smc91c111_device,
+	&pb1200_mmc0_device,
+	&pb1200_mmc1_device
 };
 
 static int __init board_register_devices(void)
-- 
1.7.0.2
