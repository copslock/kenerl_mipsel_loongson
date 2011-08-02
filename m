Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Aug 2011 19:55:33 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:33355 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491759Ab1HBRvc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Aug 2011 19:51:32 +0200
Received: by mail-fx0-f49.google.com with SMTP id 20so73189fxd.36
        for <multiple recipients>; Tue, 02 Aug 2011 10:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=r/zhnjcxNAs6+KgLiCh/bmJg1wce0bcXo1pjky76rOw=;
        b=F4cnLhVvNke4SlWmwwFtRgSIBscUPLTAeznY9TdkpmoJhPoPi7NBJkle3zQBsuoqUb
         gPjpQEC4sIS7KBcGD9ROtHa/OsGufj8cOPRKyufDTIiMkpA9w18sRRBWJMtHe0a4fFEa
         HTSymlhxCu6DGYIm3WNjT1zSO4Sl/26tIqNog=
Received: by 10.223.68.22 with SMTP id t22mr803313fai.145.1312307492585;
        Tue, 02 Aug 2011 10:51:32 -0700 (PDT)
Received: from localhost.localdomain (188-22-5-211.adsl.highway.telekom.at [188.22.5.211])
        by mx.google.com with ESMTPS id r12sm3608450fam.24.2011.08.02.10.51.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 02 Aug 2011 10:51:31 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 09/15] MIPS: au1xxx: au1xxx-ide: remove pb1200/db1200 header dependencies
Date:   Tue,  2 Aug 2011 19:51:04 +0200
Message-Id: <1312307470-6841-10-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1312307470-6841-1-git-send-email-manuel.lauss@googlemail.com>
References: <1312307470-6841-1-git-send-email-manuel.lauss@googlemail.com>
X-archive-position: 30805
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 1620

au1xxx-ide uses defines from the pb1200/db1200 headers, fix this.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 arch/mips/alchemy/devboards/db1200/platform.c  |    7 +++-
 arch/mips/alchemy/devboards/pb1200/platform.c  |    8 ++++-
 arch/mips/include/asm/mach-au1x00/au1xxx_ide.h |    1 +
 arch/mips/include/asm/mach-db1x00/db1200.h     |    2 -
 arch/mips/include/asm/mach-pb1x00/pb1200.h     |    2 -
 drivers/ide/au1xxx-ide.c                       |   44 ++++++++++++++----------
 6 files changed, 40 insertions(+), 24 deletions(-)

diff --git a/arch/mips/alchemy/devboards/db1200/platform.c b/arch/mips/alchemy/devboards/db1200/platform.c
index 95c7327..6fd070d 100644
--- a/arch/mips/alchemy/devboards/db1200/platform.c
+++ b/arch/mips/alchemy/devboards/db1200/platform.c
@@ -213,7 +213,12 @@ static struct resource db1200_ide_res[] = {
 		.start	= DB1200_IDE_INT,
 		.end	= DB1200_IDE_INT,
 		.flags	= IORESOURCE_IRQ,
-	}
+	},
+	[2] = {
+		.start	= DSCR_CMD0_DMA_REQ1,
+		.end	= DSCR_CMD0_DMA_REQ1,
+		.flags	= IORESOURCE_DMA,
+	},
 };
 
 static u64 ide_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/mips/alchemy/devboards/pb1200/platform.c b/arch/mips/alchemy/devboards/pb1200/platform.c
index c52809d..6ac0494 100644
--- a/arch/mips/alchemy/devboards/pb1200/platform.c
+++ b/arch/mips/alchemy/devboards/pb1200/platform.c
@@ -26,6 +26,7 @@
 
 #include <asm/mach-au1x00/au1xxx.h>
 #include <asm/mach-au1x00/au1100_mmc.h>
+#include <asm/mach-au1x00/au1xxx_dbdma.h>
 #include <asm/mach-db1x00/bcsr.h>
 
 #include "../platform.h"
@@ -115,7 +116,12 @@ static struct resource ide_resources[] = {
 		.start	= IDE_INT,
 		.end	= IDE_INT,
 		.flags	= IORESOURCE_IRQ
-	}
+	},
+	[2] = {
+		.start	= DSCR_CMD0_DMA_REQ1,
+		.end	= DSCR_CMD0_DMA_REQ1,
+		.flags	= IORESOURCE_DMA,
+	},
 };
 
 static u64 ide_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/mips/include/asm/mach-au1x00/au1xxx_ide.h b/arch/mips/include/asm/mach-au1x00/au1xxx_ide.h
index 5656c72..e306384 100644
--- a/arch/mips/include/asm/mach-au1x00/au1xxx_ide.h
+++ b/arch/mips/include/asm/mach-au1x00/au1xxx_ide.h
@@ -58,6 +58,7 @@ typedef struct {
 #endif
 	int			irq;
 	u32			regbase;
+	int			ddma_id;
 } _auide_hwif;
 
 /******************************************************************************/
diff --git a/arch/mips/include/asm/mach-db1x00/db1200.h b/arch/mips/include/asm/mach-db1x00/db1200.h
index 3404248..7a39657 100644
--- a/arch/mips/include/asm/mach-db1x00/db1200.h
+++ b/arch/mips/include/asm/mach-db1x00/db1200.h
@@ -46,8 +46,6 @@
 
 #define IDE_PHYS_ADDR		0x18800000
 #define IDE_REG_SHIFT		5
-#define IDE_DDMA_REQ		DSCR_CMD0_DMA_REQ1
-#define IDE_RQSIZE		128
 
 #define DB1200_IDE_PHYS_ADDR	IDE_PHYS_ADDR
 #define DB1200_IDE_PHYS_LEN	(16 << IDE_REG_SHIFT)
diff --git a/arch/mips/include/asm/mach-pb1x00/pb1200.h b/arch/mips/include/asm/mach-pb1x00/pb1200.h
index 0ecff1c..56865e9 100644
--- a/arch/mips/include/asm/mach-pb1x00/pb1200.h
+++ b/arch/mips/include/asm/mach-pb1x00/pb1200.h
@@ -76,8 +76,6 @@
 #define IDE_REG_SHIFT		5
 #define IDE_PHYS_LEN		(16 << IDE_REG_SHIFT)
 #define IDE_INT 		PB1200_IDE_INT
-#define IDE_DDMA_REQ		DSCR_CMD0_DMA_REQ1
-#define IDE_RQSIZE		128
 
 #define NAND_PHYS_ADDR 	0x1C000000
 
diff --git a/drivers/ide/au1xxx-ide.c b/drivers/ide/au1xxx-ide.c
index b26c234..c778373 100644
--- a/drivers/ide/au1xxx-ide.c
+++ b/drivers/ide/au1xxx-ide.c
@@ -43,6 +43,10 @@
 #define DRV_NAME	"au1200-ide"
 #define DRV_AUTHOR	"Enrico Walther <enrico.walther@amd.com> / Pete Popov <ppopov@embeddedalley.com>"
 
+#ifndef IDE_REG_SHIFT
+#define IDE_REG_SHIFT 5
+#endif
+
 /* enable the burstmode in the dbdma */
 #define IDE_AU1XXX_BURSTMODE	1
 
@@ -317,10 +321,11 @@ static void auide_ddma_rx_callback(int irq, void *param)
 }
 #endif /* end CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA */
 
-static void auide_init_dbdma_dev(dbdev_tab_t *dev, u32 dev_id, u32 tsize, u32 devwidth, u32 flags)
+static void auide_init_dbdma_dev(dbdev_tab_t *dev, u32 dev_id, u32 tsize,
+				 u32 devwidth, u32 flags, u32 regbase)
 {
 	dev->dev_id          = dev_id;
-	dev->dev_physaddr    = (u32)IDE_PHYS_ADDR;
+	dev->dev_physaddr    = CPHYSADDR(regbase);
 	dev->dev_intlevel    = 0;
 	dev->dev_intpolarity = 0;
 	dev->dev_tsize       = tsize;
@@ -344,7 +349,7 @@ static int auide_ddma_init(ide_hwif_t *hwif, const struct ide_port_info *d)
 	dbdev_tab_t source_dev_tab, target_dev_tab;
 	u32 dev_id, tsize, devwidth, flags;
 
-	dev_id	 = IDE_DDMA_REQ;
+	dev_id	 = hwif->ddma_id;
 
 	tsize    =  8; /*  1 */
 	devwidth = 32; /* 16 */
@@ -356,20 +361,17 @@ static int auide_ddma_init(ide_hwif_t *hwif, const struct ide_port_info *d)
 #endif
 
 	/* setup dev_tab for tx channel */
-	auide_init_dbdma_dev( &source_dev_tab,
-			      dev_id,
-			      tsize, devwidth, DEV_FLAGS_OUT | flags);
+	auide_init_dbdma_dev(&source_dev_tab, dev_id, tsize, devwidth,
+			     DEV_FLAGS_OUT | flags, auide->regbase);
  	auide->tx_dev_id = au1xxx_ddma_add_device( &source_dev_tab );
 
-	auide_init_dbdma_dev( &source_dev_tab,
-			      dev_id,
-			      tsize, devwidth, DEV_FLAGS_IN | flags);
+	auide_init_dbdma_dev(&source_dev_tab, dev_id, tsize, devwidth,
+			     DEV_FLAGS_IN | flags, auide->regbase);
  	auide->rx_dev_id = au1xxx_ddma_add_device( &source_dev_tab );
 	
 	/* We also need to add a target device for the DMA */
-	auide_init_dbdma_dev( &target_dev_tab,
-			      (u32)DSCR_CMD0_ALWAYS,
-			      tsize, devwidth, DEV_FLAGS_ANYUSE);
+	auide_init_dbdma_dev(&target_dev_tab, (u32)DSCR_CMD0_ALWAYS, tsize,
+			     devwidth, DEV_FLAGS_ANYUSE, auide->regbase);
 	auide->target_dev_id = au1xxx_ddma_add_device(&target_dev_tab);	
  
 	/* Get a channel for TX */
@@ -411,14 +413,12 @@ static int auide_ddma_init(ide_hwif_t *hwif, const struct ide_port_info *d)
 #endif
 
 	/* setup dev_tab for tx channel */
-	auide_init_dbdma_dev( &source_dev_tab,
-			      (u32)DSCR_CMD0_ALWAYS,
-			      8, 32, DEV_FLAGS_OUT | flags);
+	auide_init_dbdma_dev(&source_dev_tab, (u32)DSCR_CMD0_ALWAYS, 8, 32,
+			     DEV_FLAGS_OUT | flags, auide->regbase);
  	auide->tx_dev_id = au1xxx_ddma_add_device( &source_dev_tab );
 
-	auide_init_dbdma_dev( &source_dev_tab,
-			      (u32)DSCR_CMD0_ALWAYS,
-			      8, 32, DEV_FLAGS_IN | flags);
+	auide_init_dbdma_dev(&source_dev_tab, (u32)DSCR_CMD0_ALWAYS, 8, 32,
+			     DEV_FLAGS_IN | flags, auide->regbase);
  	auide->rx_dev_id = au1xxx_ddma_add_device( &source_dev_tab );
 	
 	/* Get a channel for TX */
@@ -540,6 +540,14 @@ static int au_ide_probe(struct platform_device *dev)
 		goto out;
 	}
 
+	res = platform_get_resource(dev, IORESOURCE_DMA, 0);
+	if (!res) {
+		pr_debug("%s: no DDMA ID resource\n", DRV_NAME);
+		ret = -ENODEV;
+		goto out;
+	}
+	ahwif->ddma_id = res->start;
+
 	memset(&hw, 0, sizeof(hw));
 	auide_setup_ports(&hw, ahwif);
 	hw.irq = ahwif->irq;
-- 
1.7.6
