Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Mar 2014 15:05:38 +0100 (CET)
Received: from mail-ee0-f47.google.com ([74.125.83.47]:43272 "EHLO
        mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816019AbaCZOFdVlhVb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Mar 2014 15:05:33 +0100
Received: by mail-ee0-f47.google.com with SMTP id b15so1685368eek.6
        for <linux-mips@linux-mips.org>; Wed, 26 Mar 2014 07:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Dm1Ch61Lq6qZV3XbArUujP3ptgmeDzhUl3jbKDUEaqk=;
        b=dT5sBY/kKK32vLuzf5xhBl47aslkTECn93Uu2lbxaRoCmmzIE10e6Iew1Uo1ZJ10os
         cc2cguxUvdt7YhpeNQsf7bDqtnmiXK3+6YDe6DA+Q3IhGIv73iktbafDI858SEDBAKrd
         N4gJAkKGXnM+wakVBASpBDfUZyBc1vv/lbZveEhNONsiKODPTtiLPBITL83fdU6PrgEd
         w7oTiSn4wxBdbcce/4UMmEnYM2N3D661j4RUtHdkW7iWVaAAtcUFE0KRs4EHHeU7CrOu
         4ehgCTCBtVieylb31zp1GNniHpOp5H/Ugy6xQu5mzwdJo9lhXTPivUyGxzzaUSJTgkSs
         HJ4w==
X-Received: by 10.15.24.201 with SMTP id j49mr1496308eeu.99.1395842727789;
        Wed, 26 Mar 2014 07:05:27 -0700 (PDT)
Received: from localhost.localdomain (p4FD8D458.dip0.t-ipconnect.de. [79.216.212.88])
        by mx.google.com with ESMTPSA id q49sm47396010eem.34.2014.03.26.07.05.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Mar 2014 07:05:27 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH v2 3/3] MIPS: Alchemy: pata_platform for DB1200
Date:   Wed, 26 Mar 2014 15:05:21 +0100
Message-Id: <1395842721-38450-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39585
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
modes only work on the db1200 with a certain cpu speed, UDMA is broken,
and finally the old IDE layer is on death row, so time to switch to
the newer ATA layer.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
v2: adjusted resource ranges and removed commented section, found by Sergei Shtylyov.

 arch/mips/alchemy/devboards/db1200.c | 21 ++++++++++++++-------
 arch/mips/configs/db1xxx_defconfig   |  3 ---
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/mips/alchemy/devboards/db1200.c b/arch/mips/alchemy/devboards/db1200.c
index 4bcf2f4..9e46667 100644
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
@@ -330,32 +331,38 @@ static struct platform_device db1200_eth_dev = {
 
 /**********************************************************************/
 
+static struct pata_platform_info db1200_ide_info = {
+	.ioport_shift	= DB1200_IDE_REG_SHIFT,
+};
+
+#define IDE_ALT_START	(14 << DB1200_IDE_REG_SHIFT)
 static struct resource db1200_ide_res[] = {
 	[0] = {
 		.start	= DB1200_IDE_PHYS_ADDR,
-		.end	= DB1200_IDE_PHYS_ADDR + DB1200_IDE_PHYS_LEN - 1,
+		.end	= DB1200_IDE_PHYS_ADDR + IDE_ALT_START - 1,
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
-		.start	= AU1200_DSCR_CMD0_DMA_REQ1,
-		.end	= AU1200_DSCR_CMD0_DMA_REQ1,
-		.flags	= IORESOURCE_DMA,
-	},
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
