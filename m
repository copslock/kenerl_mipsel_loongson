Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Aug 2011 11:40:32 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:50901 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491155Ab1HLJj4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Aug 2011 11:39:56 +0200
Received: by mail-fx0-f49.google.com with SMTP id 20so2860465fxd.36
        for <multiple recipients>; Fri, 12 Aug 2011 02:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=+JFJw4zya601KYmdMeN8rAlOr4ia6iPHviaT90n6UFs=;
        b=kmT7zCamjUGTFcytPompZYc46LcZDTb0GT35ULw2U52X1r7SC+VSdoVuL76ryBSONK
         pbZ0TWtKy7bkuGXrcNnuWwxlO/DD6YlVN8V7J17fBatyr6VrFKymB0UY8yMD7wCI/1D3
         z6cpMA8vxMGKY10Xf6rWj9v+FmHYR7F+m7j+g=
Received: by 10.223.22.8 with SMTP id l8mr978227fab.105.1313141996398;
        Fri, 12 Aug 2011 02:39:56 -0700 (PDT)
Received: from localhost.localdomain (178-191-11-228.adsl.highway.telekom.at [178.191.11.228])
        by mx.google.com with ESMTPS id s14sm467338fah.29.2011.08.12.02.39.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 12 Aug 2011 02:39:55 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 3/8] MIPS: Alchemy: more base address cleanup
Date:   Fri, 12 Aug 2011 11:39:40 +0200
Message-Id: <1313141985-5830-4-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1313141985-5830-1-git-send-email-manuel.lauss@googlemail.com>
References: <1313141985-5830-1-git-send-email-manuel.lauss@googlemail.com>
X-archive-position: 30856
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9261

remove all redundant peripheral base address defines, fix
all affected boards and drivers.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 arch/mips/alchemy/common/platform.c            |   12 ++--
 arch/mips/alchemy/devboards/db1200/platform.c  |   52 ++++++-------
 arch/mips/alchemy/devboards/db1x00/platform.c  |   40 ++++-----
 arch/mips/alchemy/devboards/pb1100/platform.c  |   20 ++---
 arch/mips/alchemy/devboards/pb1200/platform.c  |   42 +++++-----
 arch/mips/alchemy/devboards/pb1500/platform.c  |   22 +++---
 arch/mips/alchemy/devboards/pb1550/platform.c  |   40 ++++-----
 arch/mips/alchemy/xxs1500/platform.c           |   12 ++--
 arch/mips/include/asm/mach-au1x00/au1000.h     |  103 ++++++------------------
 arch/mips/include/asm/mach-au1x00/au1xxx_psc.h |   26 ------
 arch/mips/include/asm/mach-db1x00/db1x00.h     |    8 +-
 arch/mips/include/asm/mach-pb1x00/pb1200.h     |    8 +-
 arch/mips/include/asm/mach-pb1x00/pb1550.h     |    8 +-
 13 files changed, 146 insertions(+), 247 deletions(-)

diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/common/platform.c
index 910a3bd..bf1ac41 100644
--- a/arch/mips/alchemy/common/platform.c
+++ b/arch/mips/alchemy/common/platform.c
@@ -194,8 +194,8 @@ static void __init alchemy_setup_usb(int ctype)
 #ifdef CONFIG_FB_AU1100
 static struct resource au1100_lcd_resources[] = {
 	[0] = {
-		.start          = LCD_PHYS_ADDR,
-		.end            = LCD_PHYS_ADDR + 0x800 - 1,
+		.start          = AU1100_LCD_PHYS_ADDR,
+		.end            = AU1100_LCD_PHYS_ADDR + 0x800 - 1,
 		.flags          = IORESOURCE_MEM,
 	},
 	[1] = {
@@ -223,8 +223,8 @@ static struct platform_device au1100_lcd_device = {
 
 static struct resource au1200_lcd_resources[] = {
 	[0] = {
-		.start          = LCD_PHYS_ADDR,
-		.end            = LCD_PHYS_ADDR + 0x800 - 1,
+		.start          = AU1200_LCD_PHYS_ADDR,
+		.end            = AU1200_LCD_PHYS_ADDR + 0x800 - 1,
 		.flags          = IORESOURCE_MEM,
 	},
 	[1] = {
@@ -328,8 +328,8 @@ static struct platform_device au1200_mmc1_device = {
 #ifdef SMBUS_PSC_BASE
 static struct resource pbdb_smbus_resources[] = {
 	{
-		.start	= CPHYSADDR(SMBUS_PSC_BASE),
-		.end	= CPHYSADDR(SMBUS_PSC_BASE + 0xfffff),
+		.start	= SMBUS_PSC_BASE,
+		.end	= SMBUS_PSC_BASE + 0xfff,
 		.flags	= IORESOURCE_MEM,
 	},
 };
diff --git a/arch/mips/alchemy/devboards/db1200/platform.c b/arch/mips/alchemy/devboards/db1200/platform.c
index fbb5593..95c7327 100644
--- a/arch/mips/alchemy/devboards/db1200/platform.c
+++ b/arch/mips/alchemy/devboards/db1200/platform.c
@@ -343,8 +343,8 @@ struct au1xmmc_platform_data au1xmmc_platdata[] = {
 
 static struct resource au1200_psc0_res[] = {
 	[0] = {
-		.start	= PSC0_PHYS_ADDR,
-		.end	= PSC0_PHYS_ADDR + 0x000fffff,
+		.start	= AU1550_PSC0_PHYS_ADDR,
+		.end	= AU1550_PSC0_PHYS_ADDR + 0xfff,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
@@ -401,8 +401,8 @@ static struct platform_device db1200_spi_dev = {
 
 static struct resource au1200_psc1_res[] = {
 	[0] = {
-		.start	= PSC1_PHYS_ADDR,
-		.end	= PSC1_PHYS_ADDR + 0x000fffff,
+		.start	= AU1550_PSC1_PHYS_ADDR,
+		.end	= AU1550_PSC1_PHYS_ADDR + 0xfff,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
@@ -510,32 +510,28 @@ static int __init db1200_dev_init(void)
 
 	/* Audio PSC clock is supplied externally. (FIXME: platdata!!) */
 	__raw_writel(PSC_SEL_CLK_SERCLK,
-		(void __iomem *)KSEG1ADDR(PSC1_PHYS_ADDR) + PSC_SEL_OFFSET);
+		(void __iomem *)KSEG1ADDR(AU1550_PSC1_PHYS_ADDR) + PSC_SEL_OFFSET);
 	wmb();
 
-	db1x_register_pcmcia_socket(PCMCIA_ATTR_PHYS_ADDR,
-				    PCMCIA_ATTR_PHYS_ADDR + 0x000400000 - 1,
-				    PCMCIA_MEM_PHYS_ADDR,
-				    PCMCIA_MEM_PHYS_ADDR  + 0x000400000 - 1,
-				    PCMCIA_IO_PHYS_ADDR,
-				    PCMCIA_IO_PHYS_ADDR   + 0x000010000 - 1,
-				    DB1200_PC0_INT,
-				    DB1200_PC0_INSERT_INT,
-				    /*DB1200_PC0_STSCHG_INT*/0,
-				    DB1200_PC0_EJECT_INT,
-				    0);
-
-	db1x_register_pcmcia_socket(PCMCIA_ATTR_PHYS_ADDR + 0x004000000,
-				    PCMCIA_ATTR_PHYS_ADDR + 0x004400000 - 1,
-				    PCMCIA_MEM_PHYS_ADDR  + 0x004000000,
-				    PCMCIA_MEM_PHYS_ADDR  + 0x004400000 - 1,
-				    PCMCIA_IO_PHYS_ADDR   + 0x004000000,
-				    PCMCIA_IO_PHYS_ADDR   + 0x004010000 - 1,
-				    DB1200_PC1_INT,
-				    DB1200_PC1_INSERT_INT,
-				    /*DB1200_PC1_STSCHG_INT*/0,
-				    DB1200_PC1_EJECT_INT,
-				    1);
+	db1x_register_pcmcia_socket(
+		AU1000_PCMCIA_ATTR_PHYS_ADDR,
+		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x000400000 - 1,
+		AU1000_PCMCIA_MEM_PHYS_ADDR,
+		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x000400000 - 1,
+		AU1000_PCMCIA_IO_PHYS_ADDR,
+		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x000010000 - 1,
+		DB1200_PC0_INT, DB1200_PC0_INSERT_INT,
+		/*DB1200_PC0_STSCHG_INT*/0, DB1200_PC0_EJECT_INT, 0);
+
+	db1x_register_pcmcia_socket(
+		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x004000000,
+		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x004400000 - 1,
+		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x004000000,
+		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x004400000 - 1,
+		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x004000000,
+		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x004010000 - 1,
+		DB1200_PC1_INT, DB1200_PC1_INSERT_INT,
+		/*DB1200_PC1_STSCHG_INT*/0, DB1200_PC1_EJECT_INT, 1);
 
 	swapped = bcsr_read(BCSR_STATUS) & BCSR_STATUS_DB1200_SWAPBOOT;
 	db1x_register_norflash(64 << 20, 2, swapped);
diff --git a/arch/mips/alchemy/devboards/db1x00/platform.c b/arch/mips/alchemy/devboards/db1x00/platform.c
index 978d5ab..ef8017f 100644
--- a/arch/mips/alchemy/devboards/db1x00/platform.c
+++ b/arch/mips/alchemy/devboards/db1x00/platform.c
@@ -88,29 +88,25 @@
 static int __init db1xxx_dev_init(void)
 {
 #ifdef DB1XXX_HAS_PCMCIA
-	db1x_register_pcmcia_socket(PCMCIA_ATTR_PHYS_ADDR,
-				    PCMCIA_ATTR_PHYS_ADDR + 0x000400000 - 1,
-				    PCMCIA_MEM_PHYS_ADDR,
-				    PCMCIA_MEM_PHYS_ADDR  + 0x000400000 - 1,
-				    PCMCIA_IO_PHYS_ADDR,
-				    PCMCIA_IO_PHYS_ADDR   + 0x000010000 - 1,
-				    DB1XXX_PCMCIA_CARD0,
-				    DB1XXX_PCMCIA_CD0,
-				    /*DB1XXX_PCMCIA_STSCHG0*/0,
-				    0,
-				    0);
+	db1x_register_pcmcia_socket(
+		AU1000_PCMCIA_ATTR_PHYS_ADDR,
+		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x000400000 - 1,
+		AU1000_PCMCIA_MEM_PHYS_ADDR,
+		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x000400000 - 1,
+		AU1000_PCMCIA_IO_PHYS_ADDR,
+		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x000010000 - 1,
+		DB1XXX_PCMCIA_CARD0, DB1XXX_PCMCIA_CD0,
+		/*DB1XXX_PCMCIA_STSCHG0*/0, 0, 0);
 
-	db1x_register_pcmcia_socket(PCMCIA_ATTR_PHYS_ADDR + 0x004000000,
-				    PCMCIA_ATTR_PHYS_ADDR + 0x004400000 - 1,
-				    PCMCIA_MEM_PHYS_ADDR  + 0x004000000,
-				    PCMCIA_MEM_PHYS_ADDR  + 0x004400000 - 1,
-				    PCMCIA_IO_PHYS_ADDR   + 0x004000000,
-				    PCMCIA_IO_PHYS_ADDR   + 0x004010000 - 1,
-				    DB1XXX_PCMCIA_CARD1,
-				    DB1XXX_PCMCIA_CD1,
-				    /*DB1XXX_PCMCIA_STSCHG1*/0,
-				    0,
-				    1);
+	db1x_register_pcmcia_socket(
+		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x004000000,
+		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x004400000 - 1,
+		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x004000000,
+		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x004400000 - 1,
+		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x004000000,
+		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x004010000 - 1,
+		DB1XXX_PCMCIA_CARD1, DB1XXX_PCMCIA_CD1,
+		/*DB1XXX_PCMCIA_STSCHG1*/0, 0, 1);
 #endif
 	db1x_register_norflash(BOARD_FLASH_SIZE, BOARD_FLASH_WIDTH, F_SWAPPED);
 	return 0;
diff --git a/arch/mips/alchemy/devboards/pb1100/platform.c b/arch/mips/alchemy/devboards/pb1100/platform.c
index 2c8dc29..8a4e733 100644
--- a/arch/mips/alchemy/devboards/pb1100/platform.c
+++ b/arch/mips/alchemy/devboards/pb1100/platform.c
@@ -30,17 +30,15 @@ static int __init pb1100_dev_init(void)
 	int swapped;
 
 	/* PCMCIA. single socket, identical to Pb1500 */
-	db1x_register_pcmcia_socket(PCMCIA_ATTR_PHYS_ADDR,
-				    PCMCIA_ATTR_PHYS_ADDR + 0x000400000 - 1,
-				    PCMCIA_MEM_PHYS_ADDR,
-				    PCMCIA_MEM_PHYS_ADDR  + 0x000400000 - 1,
-				    PCMCIA_IO_PHYS_ADDR,
-				    PCMCIA_IO_PHYS_ADDR   + 0x000010000 - 1,
-				    AU1100_GPIO11_INT,	 /* card */
-				    AU1100_GPIO9_INT,	 /* insert */
-				    /*AU1100_GPIO10_INT*/0, /* stschg */
-				    0,			 /* eject */
-				    0);			 /* id */
+	db1x_register_pcmcia_socket(
+		AU1000_PCMCIA_ATTR_PHYS_ADDR,
+		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x000400000 - 1,
+		AU1000_PCMCIA_MEM_PHYS_ADDR,
+		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x000400000 - 1,
+		AU1000_PCMCIA_IO_PHYS_ADDR,
+		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x000010000 - 1,
+		AU1100_GPIO11_INT, AU1100_GPIO9_INT,	 /* card / insert */
+		/*AU1100_GPIO10_INT*/0, 0, 0); /* stschg / eject / id */
 
 	swapped = bcsr_read(BCSR_STATUS) &  BCSR_STATUS_DB1000_SWAPBOOT;
 	db1x_register_norflash(64 * 1024 * 1024, 4, swapped);
diff --git a/arch/mips/alchemy/devboards/pb1200/platform.c b/arch/mips/alchemy/devboards/pb1200/platform.c
index 3ef2dce..c52809d 100644
--- a/arch/mips/alchemy/devboards/pb1200/platform.c
+++ b/arch/mips/alchemy/devboards/pb1200/platform.c
@@ -170,29 +170,25 @@ static int __init board_register_devices(void)
 {
 	int swapped;
 
-	db1x_register_pcmcia_socket(PCMCIA_ATTR_PHYS_ADDR,
-				    PCMCIA_ATTR_PHYS_ADDR + 0x000400000 - 1,
-				    PCMCIA_MEM_PHYS_ADDR,
-				    PCMCIA_MEM_PHYS_ADDR  + 0x000400000 - 1,
-				    PCMCIA_IO_PHYS_ADDR,
-				    PCMCIA_IO_PHYS_ADDR   + 0x000010000 - 1,
-				    PB1200_PC0_INT,
-				    PB1200_PC0_INSERT_INT,
-				    /*PB1200_PC0_STSCHG_INT*/0,
-				    PB1200_PC0_EJECT_INT,
-				    0);
-
-	db1x_register_pcmcia_socket(PCMCIA_ATTR_PHYS_ADDR + 0x008000000,
-				    PCMCIA_ATTR_PHYS_ADDR + 0x008400000 - 1,
-				    PCMCIA_MEM_PHYS_ADDR  + 0x008000000,
-				    PCMCIA_MEM_PHYS_ADDR  + 0x008400000 - 1,
-				    PCMCIA_IO_PHYS_ADDR   + 0x008000000,
-				    PCMCIA_IO_PHYS_ADDR   + 0x008010000 - 1,
-				    PB1200_PC1_INT,
-				    PB1200_PC1_INSERT_INT,
-				    /*PB1200_PC1_STSCHG_INT*/0,
-				    PB1200_PC1_EJECT_INT,
-				    1);
+	db1x_register_pcmcia_socket(
+		AU1000_PCMCIA_ATTR_PHYS_ADDR,
+		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x000400000 - 1,
+		AU1000_PCMCIA_MEM_PHYS_ADDR,
+		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x000400000 - 1,
+		AU1000_PCMCIA_IO_PHYS_ADDR,
+		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x000010000 - 1,
+		PB1200_PC0_INT, PB1200_PC0_INSERT_INT,
+		/*PB1200_PC0_STSCHG_INT*/0, PB1200_PC0_EJECT_INT, 0);
+
+	db1x_register_pcmcia_socket(
+		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x008000000,
+		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x008400000 - 1,
+		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x008000000,
+		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x008400000 - 1,
+		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x008000000,
+		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x008010000 - 1,
+		PB1200_PC1_INT, PB1200_PC1_INSERT_INT,
+		/*PB1200_PC1_STSCHG_INT*/0, PB1200_PC1_EJECT_INT, 1);
 
 	swapped = bcsr_read(BCSR_STATUS) &  BCSR_STATUS_DB1200_SWAPBOOT;
 	db1x_register_norflash(128 * 1024 * 1024, 2, swapped);
diff --git a/arch/mips/alchemy/devboards/pb1500/platform.c b/arch/mips/alchemy/devboards/pb1500/platform.c
index d443bc7..42b0e6b 100644
--- a/arch/mips/alchemy/devboards/pb1500/platform.c
+++ b/arch/mips/alchemy/devboards/pb1500/platform.c
@@ -28,18 +28,16 @@ static int __init pb1500_dev_init(void)
 {
 	int swapped;
 
-	/* PCMCIA. single socket, identical to Pb1500 */
-	db1x_register_pcmcia_socket(PCMCIA_ATTR_PHYS_ADDR,
-				    PCMCIA_ATTR_PHYS_ADDR + 0x000400000 - 1,
-				    PCMCIA_MEM_PHYS_ADDR,
-				    PCMCIA_MEM_PHYS_ADDR  + 0x000400000 - 1,
-				    PCMCIA_IO_PHYS_ADDR,
-				    PCMCIA_IO_PHYS_ADDR   + 0x000010000 - 1,
-				    AU1500_GPIO11_INT,	 /* card */
-				    AU1500_GPIO9_INT,	 /* insert */
-				    /*AU1500_GPIO10_INT*/0, /* stschg */
-				    0,			 /* eject */
-				    0);			 /* id */
+	/* PCMCIA. single socket, identical to Pb1100 */
+	db1x_register_pcmcia_socket(
+		AU1000_PCMCIA_ATTR_PHYS_ADDR,
+		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x000400000 - 1,
+		AU1000_PCMCIA_MEM_PHYS_ADDR,
+		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x000400000 - 1,
+		AU1000_PCMCIA_IO_PHYS_ADDR,
+		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x000010000 - 1,
+		AU1500_GPIO11_INT, AU1500_GPIO9_INT,	 /* card / insert */
+		/*AU1500_GPIO10_INT*/0, 0, 0); /* stschg / eject / id */
 
 	swapped = bcsr_read(BCSR_STATUS) &  BCSR_STATUS_DB1000_SWAPBOOT;
 	db1x_register_norflash(64 * 1024 * 1024, 4, swapped);
diff --git a/arch/mips/alchemy/devboards/pb1550/platform.c b/arch/mips/alchemy/devboards/pb1550/platform.c
index d7150d0..87c79b7 100644
--- a/arch/mips/alchemy/devboards/pb1550/platform.c
+++ b/arch/mips/alchemy/devboards/pb1550/platform.c
@@ -37,29 +37,23 @@ static int __init pb1550_dev_init(void)
 	* drivers are used to shared irqs and b) statuschange isn't really use-
 	* ful anyway.
 	*/
-	db1x_register_pcmcia_socket(PCMCIA_ATTR_PHYS_ADDR,
-				    PCMCIA_ATTR_PHYS_ADDR + 0x000400000 - 1,
-				    PCMCIA_MEM_PHYS_ADDR,
-				    PCMCIA_MEM_PHYS_ADDR  + 0x000400000 - 1,
-				    PCMCIA_IO_PHYS_ADDR,
-				    PCMCIA_IO_PHYS_ADDR   + 0x000010000 - 1,
-				    AU1550_GPIO201_205_INT,
-				    AU1550_GPIO0_INT,
-				    0,
-				    0,
-				    0);
-
-	db1x_register_pcmcia_socket(PCMCIA_ATTR_PHYS_ADDR + 0x008000000,
-				    PCMCIA_ATTR_PHYS_ADDR + 0x008400000 - 1,
-				    PCMCIA_MEM_PHYS_ADDR  + 0x008000000,
-				    PCMCIA_MEM_PHYS_ADDR  + 0x008400000 - 1,
-				    PCMCIA_IO_PHYS_ADDR   + 0x008000000,
-				    PCMCIA_IO_PHYS_ADDR   + 0x008010000 - 1,
-				    AU1550_GPIO201_205_INT,
-				    AU1550_GPIO1_INT,
-				    0,
-				    0,
-				    1);
+	db1x_register_pcmcia_socket(
+		AU1000_PCMCIA_ATTR_PHYS_ADDR,
+		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x000400000 - 1,
+		AU1000_PCMCIA_MEM_PHYS_ADDR,
+		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x000400000 - 1,
+		AU1000_PCMCIA_IO_PHYS_ADDR,
+		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x000010000 - 1,
+		AU1550_GPIO201_205_INT, AU1550_GPIO0_INT, 0, 0, 0);
+
+	db1x_register_pcmcia_socket(
+		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x008000000,
+		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x008400000 - 1,
+		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x008000000,
+		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x008400000 - 1,
+		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x008000000,
+		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x008010000 - 1,
+		AU1550_GPIO201_205_INT, AU1550_GPIO1_INT, 0, 0, 1);
 
 	swapped = bcsr_read(BCSR_STATUS) & BCSR_STATUS_PB1550_SWAPBOOT;
 	db1x_register_norflash(128 * 1024 * 1024, 4, swapped);
diff --git a/arch/mips/alchemy/xxs1500/platform.c b/arch/mips/alchemy/xxs1500/platform.c
index e87c45c..06a3a45 100644
--- a/arch/mips/alchemy/xxs1500/platform.c
+++ b/arch/mips/alchemy/xxs1500/platform.c
@@ -27,20 +27,20 @@ static struct resource xxs1500_pcmcia_res[] = {
 	{
 		.name	= "pcmcia-io",
 		.flags	= IORESOURCE_MEM,
-		.start	= PCMCIA_IO_PHYS_ADDR,
-		.end	= PCMCIA_IO_PHYS_ADDR + 0x000400000 - 1,
+		.start	= AU1000_PCMCIA_IO_PHYS_ADDR,
+		.end	= AU1000_PCMCIA_IO_PHYS_ADDR + 0x000400000 - 1,
 	},
 	{
 		.name	= "pcmcia-attr",
 		.flags	= IORESOURCE_MEM,
-		.start	= PCMCIA_ATTR_PHYS_ADDR,
-		.end	= PCMCIA_ATTR_PHYS_ADDR + 0x000400000 - 1,
+		.start	= AU1000_PCMCIA_ATTR_PHYS_ADDR,
+		.end	= AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x000400000 - 1,
 	},
 	{
 		.name	= "pcmcia-mem",
 		.flags	= IORESOURCE_MEM,
-		.start	= PCMCIA_MEM_PHYS_ADDR,
-		.end	= PCMCIA_MEM_PHYS_ADDR + 0x000400000 - 1,
+		.start	= AU1000_PCMCIA_MEM_PHYS_ADDR,
+		.end	= AU1000_PCMCIA_MEM_PHYS_ADDR + 0x000400000 - 1,
 	},
 };
 
diff --git a/arch/mips/include/asm/mach-au1x00/au1000.h b/arch/mips/include/asm/mach-au1x00/au1000.h
index 86d39c3..bcf3d1e 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000.h
@@ -698,114 +698,61 @@ enum soc_au1200_ints {
 #define AU1000_AC97_PHYS_ADDR		0x10000000 /* 012 */
 #define AU1000_USB_OHCI_PHYS_ADDR	0x10100000 /* 012 */
 #define AU1000_USB_UDC_PHYS_ADDR	0x10200000 /* 0123 */
+#define AU1000_IRDA_PHYS_ADDR		0x10300000 /* 02 */
+#define AU1200_AES_PHYS_ADDR		0x10300000 /* 4 */
 #define AU1000_IC0_PHYS_ADDR		0x10400000 /* 01234 */
 #define AU1000_MAC0_PHYS_ADDR		0x10500000 /* 023 */
 #define AU1000_MAC1_PHYS_ADDR		0x10510000 /* 023 */
 #define AU1000_MACEN_PHYS_ADDR		0x10520000 /* 023 */
 #define AU1100_SD0_PHYS_ADDR		0x10600000 /* 24 */
 #define AU1100_SD1_PHYS_ADDR		0x10680000 /* 24 */
+#define AU1550_PSC2_PHYS_ADDR		0x10A00000 /* 3 */
+#define AU1550_PSC3_PHYS_ADDR		0x10B00000 /* 3 */
 #define AU1000_I2S_PHYS_ADDR		0x11000000 /* 02 */
 #define AU1500_MAC0_PHYS_ADDR		0x11500000 /* 1 */
 #define AU1500_MAC1_PHYS_ADDR		0x11510000 /* 1 */
 #define AU1500_MACEN_PHYS_ADDR		0x11520000 /* 1 */
 #define AU1000_UART0_PHYS_ADDR		0x11100000 /* 01234 */
+#define AU1200_SWCNT_PHYS_ADDR		0x1110010C /* 4 */
 #define AU1000_UART1_PHYS_ADDR		0x11200000 /* 0234 */
 #define AU1000_UART2_PHYS_ADDR		0x11300000 /* 0 */
 #define AU1000_UART3_PHYS_ADDR		0x11400000 /* 0123 */
+#define AU1000_SSI0_PHYS_ADDR		0x11600000 /* 02 */
+#define AU1000_SSI1_PHYS_ADDR		0x11680000 /* 02 */
 #define AU1500_GPIO2_PHYS_ADDR		0x11700000 /* 1234 */
 #define AU1000_IC1_PHYS_ADDR		0x11800000 /* 01234 */
 #define AU1000_SYS_PHYS_ADDR		0x11900000 /* 01234 */
+#define AU1550_PSC0_PHYS_ADDR		0x11A00000 /* 34 */
+#define AU1550_PSC1_PHYS_ADDR		0x11B00000 /* 34 */
+#define AU1000_MEM_PHYS_ADDR		0x14000000 /* 01234 */
+#define AU1000_STATIC_MEM_PHYS_ADDR	0x14001000 /* 01234 */
 #define AU1000_DMA_PHYS_ADDR		0x14002000 /* 012 */
 #define AU1550_DBDMA_PHYS_ADDR		0x14002000 /* 34 */
 #define AU1550_DBDMA_CONF_PHYS_ADDR	0x14003000 /* 34 */
 #define AU1000_MACDMA0_PHYS_ADDR	0x14004000 /* 0123 */
 #define AU1000_MACDMA1_PHYS_ADDR	0x14004200 /* 0123 */
+#define AU1200_CIM_PHYS_ADDR		0x14004000 /* 4 */
+#define AU1500_PCI_PHYS_ADDR		0x14005000 /* 13 */
+#define AU1550_PE_PHYS_ADDR		0x14008000 /* 3 */
+#define AU1200_MAEBE_PHYS_ADDR		0x14010000 /* 4 */
+#define AU1200_MAEFE_PHYS_ADDR		0x14012000 /* 4 */
 #define AU1550_USB_OHCI_PHYS_ADDR	0x14020000 /* 3 */
 #define AU1200_USB_CTL_PHYS_ADDR	0x14020000 /* 4 */
 #define AU1200_USB_OTG_PHYS_ADDR	0x14020020 /* 4 */
 #define AU1200_USB_OHCI_PHYS_ADDR	0x14020100 /* 4 */
 #define AU1200_USB_EHCI_PHYS_ADDR	0x14020200 /* 4 */
 #define AU1200_USB_UDC_PHYS_ADDR	0x14022000 /* 4 */
+#define AU1100_LCD_PHYS_ADDR		0x15000000 /* 2 */
+#define AU1200_LCD_PHYS_ADDR		0x15000000 /* 4 */
+#define AU1500_PCI_MEM_PHYS_ADDR	0x400000000ULL /* 13 */
+#define AU1500_PCI_IO_PHYS_ADDR		0x500000000ULL /* 13 */
+#define AU1500_PCI_CONFIG0_PHYS_ADDR	0x600000000ULL /* 13 */
+#define AU1500_PCI_CONFIG1_PHYS_ADDR	0x680000000ULL /* 13 */
+#define AU1000_PCMCIA_IO_PHYS_ADDR	0xF00000000ULL /* 01234 */
+#define AU1000_PCMCIA_ATTR_PHYS_ADDR	0xF40000000ULL /* 01234 */
+#define AU1000_PCMCIA_MEM_PHYS_ADDR	0xF80000000ULL /* 01234 */
 
 
-#ifdef CONFIG_SOC_AU1000
-#define	MEM_PHYS_ADDR		0x14000000
-#define	STATIC_MEM_PHYS_ADDR	0x14001000
-#define	IRDA_PHYS_ADDR		0x10300000
-#define	SSI0_PHYS_ADDR		0x11600000
-#define	SSI1_PHYS_ADDR		0x11680000
-#define PCMCIA_IO_PHYS_ADDR	0xF00000000ULL
-#define PCMCIA_ATTR_PHYS_ADDR	0xF40000000ULL
-#define PCMCIA_MEM_PHYS_ADDR	0xF80000000ULL
-#endif
-
-/********************************************************************/
-
-#ifdef CONFIG_SOC_AU1500
-#define	MEM_PHYS_ADDR		0x14000000
-#define	STATIC_MEM_PHYS_ADDR	0x14001000
-#define PCI_PHYS_ADDR		0x14005000
-#define PCI_MEM_PHYS_ADDR	0x400000000ULL
-#define PCI_IO_PHYS_ADDR	0x500000000ULL
-#define PCI_CONFIG0_PHYS_ADDR	0x600000000ULL
-#define PCI_CONFIG1_PHYS_ADDR	0x680000000ULL
-#define PCMCIA_IO_PHYS_ADDR	0xF00000000ULL
-#define PCMCIA_ATTR_PHYS_ADDR	0xF40000000ULL
-#define PCMCIA_MEM_PHYS_ADDR	0xF80000000ULL
-#endif
-
-/********************************************************************/
-
-#ifdef CONFIG_SOC_AU1100
-#define	MEM_PHYS_ADDR		0x14000000
-#define	STATIC_MEM_PHYS_ADDR	0x14001000
-#define	IRDA_PHYS_ADDR		0x10300000
-#define	SSI0_PHYS_ADDR		0x11600000
-#define	SSI1_PHYS_ADDR		0x11680000
-#define LCD_PHYS_ADDR		0x15000000
-#define PCMCIA_IO_PHYS_ADDR	0xF00000000ULL
-#define PCMCIA_ATTR_PHYS_ADDR	0xF40000000ULL
-#define PCMCIA_MEM_PHYS_ADDR	0xF80000000ULL
-#endif
-
-/***********************************************************************/
-
-#ifdef CONFIG_SOC_AU1550
-#define	MEM_PHYS_ADDR		0x14000000
-#define	STATIC_MEM_PHYS_ADDR	0x14001000
-#define PCI_PHYS_ADDR		0x14005000
-#define PE_PHYS_ADDR		0x14008000
-#define PSC0_PHYS_ADDR		0x11A00000
-#define PSC1_PHYS_ADDR		0x11B00000
-#define PSC2_PHYS_ADDR		0x10A00000
-#define PSC3_PHYS_ADDR		0x10B00000
-#define PCI_MEM_PHYS_ADDR	0x400000000ULL
-#define PCI_IO_PHYS_ADDR	0x500000000ULL
-#define PCI_CONFIG0_PHYS_ADDR	0x600000000ULL
-#define PCI_CONFIG1_PHYS_ADDR	0x680000000ULL
-#define PCMCIA_IO_PHYS_ADDR	0xF00000000ULL
-#define PCMCIA_ATTR_PHYS_ADDR	0xF40000000ULL
-#define PCMCIA_MEM_PHYS_ADDR	0xF80000000ULL
-#endif
-
-/***********************************************************************/
-
-#ifdef CONFIG_SOC_AU1200
-#define	MEM_PHYS_ADDR		0x14000000
-#define	STATIC_MEM_PHYS_ADDR	0x14001000
-#define AES_PHYS_ADDR		0x10300000
-#define CIM_PHYS_ADDR		0x14004000
-#define PSC0_PHYS_ADDR	 	0x11A00000
-#define PSC1_PHYS_ADDR	 	0x11B00000
-#define LCD_PHYS_ADDR		0x15000000
-#define SWCNT_PHYS_ADDR		0x1110010C
-#define MAEFE_PHYS_ADDR		0x14012000
-#define MAEBE_PHYS_ADDR		0x14010000
-#define PCMCIA_IO_PHYS_ADDR	0xF00000000ULL
-#define PCMCIA_ATTR_PHYS_ADDR	0xF40000000ULL
-#define PCMCIA_MEM_PHYS_ADDR	0xF80000000ULL
-#endif
-
 /* Static Bus Controller */
 #define MEM_STCFG0		0xB4001000
 #define MEM_STTIME0		0xB4001004
diff --git a/arch/mips/include/asm/mach-au1x00/au1xxx_psc.h b/arch/mips/include/asm/mach-au1x00/au1xxx_psc.h
index 892b7f1..8e2fa67 100644
--- a/arch/mips/include/asm/mach-au1x00/au1xxx_psc.h
+++ b/arch/mips/include/asm/mach-au1x00/au1xxx_psc.h
@@ -33,19 +33,6 @@
 #ifndef _AU1000_PSC_H_
 #define _AU1000_PSC_H_
 
-/* The PSC base addresses.  */
-#ifdef CONFIG_SOC_AU1550
-#define PSC0_BASE_ADDR		0xb1a00000
-#define PSC1_BASE_ADDR		0xb1b00000
-#define PSC2_BASE_ADDR		0xb0a00000
-#define PSC3_BASE_ADDR		0xb0b00000
-#endif
-
-#ifdef CONFIG_SOC_AU1200
-#define PSC0_BASE_ADDR		0xb1a00000
-#define PSC1_BASE_ADDR		0xb1b00000
-#endif
-
 /*
  * The PSC select and control registers are common to all protocols.
  */
@@ -80,19 +67,6 @@
 #define PSC_AC97GPO_OFFSET	0x00000028
 #define PSC_AC97GPI_OFFSET	0x0000002c
 
-#define AC97_PSC_SEL		(AC97_PSC_BASE + PSC_SEL_OFFSET)
-#define AC97_PSC_CTRL		(AC97_PSC_BASE + PSC_CTRL_OFFSET)
-#define PSC_AC97CFG		(AC97_PSC_BASE + PSC_AC97CFG_OFFSET)
-#define PSC_AC97MSK		(AC97_PSC_BASE + PSC_AC97MSK_OFFSET)
-#define PSC_AC97PCR		(AC97_PSC_BASE + PSC_AC97PCR_OFFSET)
-#define PSC_AC97STAT		(AC97_PSC_BASE + PSC_AC97STAT_OFFSET)
-#define PSC_AC97EVNT		(AC97_PSC_BASE + PSC_AC97EVNT_OFFSET)
-#define PSC_AC97TXRX		(AC97_PSC_BASE + PSC_AC97TXRX_OFFSET)
-#define PSC_AC97CDC		(AC97_PSC_BASE + PSC_AC97CDC_OFFSET)
-#define PSC_AC97RST		(AC97_PSC_BASE + PSC_AC97RST_OFFSET)
-#define PSC_AC97GPO		(AC97_PSC_BASE + PSC_AC97GPO_OFFSET)
-#define PSC_AC97GPI		(AC97_PSC_BASE + PSC_AC97GPI_OFFSET)
-
 /* AC97 Config Register. */
 #define PSC_AC97CFG_RT_MASK	(3 << 30)
 #define PSC_AC97CFG_RT_FIFO1	(0 << 30)
diff --git a/arch/mips/include/asm/mach-db1x00/db1x00.h b/arch/mips/include/asm/mach-db1x00/db1x00.h
index a919dac..115cc7c 100644
--- a/arch/mips/include/asm/mach-db1x00/db1x00.h
+++ b/arch/mips/include/asm/mach-db1x00/db1x00.h
@@ -36,10 +36,10 @@
 #define DBDMA_I2S_TX_CHAN	DSCR_CMD0_PSC3_TX
 #define DBDMA_I2S_RX_CHAN	DSCR_CMD0_PSC3_RX
 
-#define SPI_PSC_BASE		PSC0_BASE_ADDR
-#define AC97_PSC_BASE		PSC1_BASE_ADDR
-#define SMBUS_PSC_BASE		PSC2_BASE_ADDR
-#define I2S_PSC_BASE		PSC3_BASE_ADDR
+#define SPI_PSC_BASE		AU1550_PSC0_PHYS_ADDR
+#define AC97_PSC_BASE		AU1550_PSC1_PHYS_ADDR
+#define SMBUS_PSC_BASE		AU1550_PSC2_PHYS_ADDR
+#define I2S_PSC_BASE		AU1550_PSC3_PHYS_ADDR
 
 #define NAND_PHYS_ADDR		0x20000000
 
diff --git a/arch/mips/include/asm/mach-pb1x00/pb1200.h b/arch/mips/include/asm/mach-pb1x00/pb1200.h
index fce4332..0ecff1c 100644
--- a/arch/mips/include/asm/mach-pb1x00/pb1200.h
+++ b/arch/mips/include/asm/mach-pb1x00/pb1200.h
@@ -37,14 +37,14 @@
  * SPI and SMB are muxed on the Pb1200 board.
  * Refer to board documentation.
  */
-#define SPI_PSC_BASE		PSC0_BASE_ADDR
-#define SMBUS_PSC_BASE		PSC0_BASE_ADDR
+#define SPI_PSC_BASE		AU1550_PSC0_PHYS_ADDR
+#define SMBUS_PSC_BASE		AU1550_PSC0_PHYS_ADDR
 /*
  * AC97 and I2S are muxed on the Pb1200 board.
  * Refer to board documentation.
  */
-#define AC97_PSC_BASE       PSC1_BASE_ADDR
-#define I2S_PSC_BASE	PSC1_BASE_ADDR
+#define AC97_PSC_BASE       AU1550_PSC1_PHYS_ADDR
+#define I2S_PSC_BASE	AU1550_PSC1_PHYS_ADDR
 
 
 #define BCSR_SYSTEM_VDDI	0x001F
diff --git a/arch/mips/include/asm/mach-pb1x00/pb1550.h b/arch/mips/include/asm/mach-pb1x00/pb1550.h
index f835c88..0b0f462 100644
--- a/arch/mips/include/asm/mach-pb1x00/pb1550.h
+++ b/arch/mips/include/asm/mach-pb1x00/pb1550.h
@@ -35,10 +35,10 @@
 #define DBDMA_I2S_TX_CHAN	DSCR_CMD0_PSC3_TX
 #define DBDMA_I2S_RX_CHAN	DSCR_CMD0_PSC3_RX
 
-#define SPI_PSC_BASE		PSC0_BASE_ADDR
-#define AC97_PSC_BASE		PSC1_BASE_ADDR
-#define SMBUS_PSC_BASE		PSC2_BASE_ADDR
-#define I2S_PSC_BASE		PSC3_BASE_ADDR
+#define SPI_PSC_BASE		AU1550_PSC0_PHYS_ADDR
+#define AC97_PSC_BASE		AU1550_PSC1_PHYS_ADDR
+#define SMBUS_PSC_BASE		AU1550_PSC2_PHYS_ADDR
+#define I2S_PSC_BASE		AU1550_PSC3_PHYS_ADDR
 
 /*
  * Timing values as described in databook, * ns value stripped of
-- 
1.7.6
