Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Mar 2014 10:42:47 +0100 (CET)
Received: from mail-ee0-f49.google.com ([74.125.83.49]:48211 "EHLO
        mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822085AbaCZJmCH1jUV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Mar 2014 10:42:02 +0100
Received: by mail-ee0-f49.google.com with SMTP id c41so1416978eek.8
        for <linux-mips@linux-mips.org>; Wed, 26 Mar 2014 02:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nA1AsICNiVGa6icAvIAplDsbhSBPLtgQF/UHyrq7FE4=;
        b=Ku4uOPn9yfuNJQgIwJw7+GwfGaRZ8DZ7UVv584KgVulFn/n+U45XZis8yk+ZeY0rd4
         /hCA6+RnvcRRbxw2sQpmwcmkUevcZ/ysorLuK8Rtyuheg8UJV+UiBShLZvuVFQRueK8S
         HzmfdtwPDtq/0YiQuASm3DAxegx0AkHed2TQpA3+vTe55AwWvcWvXvbxv9jlEGG39jW8
         8rnfaa4/j+PyPpTBLN439N0XH2/rAkBppCrSeaZO/kqiGJQ5pe57qUCl9o9vyWuCB8Ub
         YMUKd7stFsp1cEfPNyhAdRMi0UDHTsWXXecMYGjkNKuQQ1DWwuC+TpiqE4kK2nzkNFd9
         h75w==
X-Received: by 10.14.5.135 with SMTP id 7mr2060208eel.86.1395826915986;
        Wed, 26 Mar 2014 02:41:55 -0700 (PDT)
Received: from localhost.localdomain (p4FD8D458.dip0.t-ipconnect.de. [79.216.212.88])
        by mx.google.com with ESMTPSA id w12sm46087849eez.36.2014.03.26.02.41.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Mar 2014 02:41:55 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 3/3] MIPS: Alchemy: pata_platform for DB1200
Date:   Wed, 26 Mar 2014 10:41:49 +0100
Message-Id: <1395826909-14772-3-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1395826909-14772-1-git-send-email-manuel.lauss@gmail.com>
References: <1395826909-14772-1-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39583
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

The au1xxx-ide driver isn't any faster than pata_platform since it
spends a lot of time busy waiting for DMA to finish; faster PIO/DMA
modes only work on the db1200 with a certain cpu speed, UDMA is broken
and finally the old IDE layer is on death row, so time to switch to
the winning side.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/alchemy/devboards/db1200.c | 18 +++++++++++++++---
 arch/mips/configs/db1xxx_defconfig   |  3 ---
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/mips/alchemy/devboards/db1200.c b/arch/mips/alchemy/devboards/db1200.c
index 4bcf2f4..40fa3a6 100644
--- a/arch/mips/alchemy/devboards/db1200.c
+++ b/arch/mips/alchemy/devboards/db1200.c
@@ -35,6 +35,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/flash.h>
 #include <linux/smc91x.h>
+#include <linux/ata_platform.h>
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-au1x00/au1100_mmc.h>
 #include <asm/mach-au1x00/au1xxx_dbdma.h>
@@ -330,6 +331,11 @@ static struct platform_device db1200_eth_dev = {
 
 /**********************************************************************/
 
+static struct pata_platform_info db1200_ide_info = {
+	.ioport_shift	= DB1200_IDE_REG_SHIFT,
+};
+
+#define IDE_ALT_START	(14 << DB1200_IDE_REG_SHIFT)
 static struct resource db1200_ide_res[] = {
 	[0] = {
 		.start	= DB1200_IDE_PHYS_ADDR,
@@ -337,25 +343,31 @@ static struct resource db1200_ide_res[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
+		.start	= DB1200_IDE_PHYS_ADDR + IDE_ALT_START,
+		.end	= DB1200_IDE_PHYS_ADDR + DB1200_IDE_PHYS_LEN - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[2] = {
 		.start	= DB1200_IDE_INT,
 		.end	= DB1200_IDE_INT,
 		.flags	= IORESOURCE_IRQ,
 	},
-	[2] = {
+/*	[3] = {
 		.start	= AU1200_DSCR_CMD0_DMA_REQ1,
 		.end	= AU1200_DSCR_CMD0_DMA_REQ1,
 		.flags	= IORESOURCE_DMA,
-	},
+	},*/
 };
 
 static u64 au1200_ide_dmamask = DMA_BIT_MASK(32);
 
 static struct platform_device db1200_ide_dev = {
-	.name		= "au1200-ide",
+	.name		= "pata_platform",
 	.id		= 0,
 	.dev = {
 		.dma_mask		= &au1200_ide_dmamask,
 		.coherent_dma_mask	= DMA_BIT_MASK(32),
+		.platform_data		= &db1200_ide_info,
 	},
 	.num_resources	= ARRAY_SIZE(db1200_ide_res),
 	.resource	= db1200_ide_res,
diff --git a/arch/mips/configs/db1xxx_defconfig b/arch/mips/configs/db1xxx_defconfig
index 3bccd5b..c99b6ee 100644
--- a/arch/mips/configs/db1xxx_defconfig
+++ b/arch/mips/configs/db1xxx_defconfig
@@ -115,9 +115,6 @@ CONFIG_MTD_NAND_AU1550=y
 CONFIG_MTD_NAND_PLATFORM=y
 CONFIG_EEPROM_AT24=y
 CONFIG_EEPROM_AT25=y
-CONFIG_IDE=y
-CONFIG_IDE_TASK_IOCTL=y
-CONFIG_BLK_DEV_IDE_AU1XXX=y
 CONFIG_SCSI_TGT=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_SG=y
-- 
1.9.1
