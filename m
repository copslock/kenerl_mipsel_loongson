Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Aug 2011 19:58:18 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:34084 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491765Ab1HBRvq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Aug 2011 19:51:46 +0200
Received: by mail-fx0-f49.google.com with SMTP id 20so73231fxd.36
        for <multiple recipients>; Tue, 02 Aug 2011 10:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=bfS0p59ClCRzDeZg6BYo1dirdboGic4U+1DXV0QlAek=;
        b=PwrEAkS8wsxUSPaD7DZ1SrhIJwy9HvHAU8oI6h4RnJpu6/P993qEqqXqW3uFZM8E90
         TJd6+b7qvI52t9U7b414Jv2+896WbA+weAo1aw2KAomORlRkQb6F18vgVs3VI4b0xLgQ
         r/RWdFuks5iZ6k5Rq7PyVSy8E7CTQEWxMsElY=
Received: by 10.223.68.194 with SMTP id w2mr2898434fai.139.1312307506211;
        Tue, 02 Aug 2011 10:51:46 -0700 (PDT)
Received: from localhost.localdomain (188-22-5-211.adsl.highway.telekom.at [188.22.5.211])
        by mx.google.com with ESMTPS id r12sm3608450fam.24.2011.08.02.10.51.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 02 Aug 2011 10:51:45 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 15/15] MIPS: Alchemy: remove all CONFIG_SOC_AU1??? defines
Date:   Tue,  2 Aug 2011 19:51:10 +0200
Message-Id: <1312307470-6841-16-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1312307470-6841-1-git-send-email-manuel.lauss@googlemail.com>
References: <1312307470-6841-1-git-send-email-manuel.lauss@googlemail.com>
X-archive-position: 30811
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 1628

Now that no driver any longer depends on the CONFIG_SOC_AU1???
symbols, it's time to get rid of them:
Move some of the platform devices to the boards which can use them,
Rename a few (unused) constants in the header,
Replace them with MIPS_ALCHEMY in the various Kconfig files.
Finally delete them altogether from the Alchemy Kconfig file.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 arch/mips/Kconfig                                |    2 +
 arch/mips/alchemy/Kconfig                        |   50 ++----
 arch/mips/alchemy/common/platform.c              |  175 +------------------
 arch/mips/alchemy/devboards/db1200/platform.c    |   78 ++++++++-
 arch/mips/alchemy/devboards/db1x00/board_setup.c |    4 +-
 arch/mips/alchemy/devboards/db1x00/platform.c    |   32 ++++
 arch/mips/alchemy/devboards/pb1100/platform.c    |   29 +++
 arch/mips/alchemy/devboards/pb1200/platform.c    |  137 ++++++++++++++-
 arch/mips/alchemy/devboards/pb1500/platform.c    |    1 +
 arch/mips/alchemy/devboards/pb1550/platform.c    |   33 ++++
 arch/mips/include/asm/mach-au1x00/au1000.h       |  203 ++++++++++------------
 drivers/i2c/busses/Kconfig                       |    2 +-
 drivers/ide/Kconfig                              |    6 +-
 drivers/mmc/host/Kconfig                         |    2 +-
 drivers/mtd/nand/Kconfig                         |    2 +-
 drivers/net/irda/Kconfig                         |    2 +-
 drivers/spi/Kconfig                              |    2 +-
 drivers/usb/Kconfig                              |    1 -
 drivers/usb/host/ehci-hcd.c                      |    2 +-
 drivers/video/Kconfig                            |    4 +-
 sound/mips/Kconfig                               |    2 +-
 sound/soc/au1x/Kconfig                           |    2 +-
 22 files changed, 423 insertions(+), 348 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 177cdaf..32e7e3c 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -46,6 +46,8 @@ config MIPS_ALCHEMY
 	select GENERIC_GPIO
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select SYS_SUPPORTS_ZBOOT
+	select USB_ARCH_HAS_OHCI
+	select USB_ARCH_HAS_EHCI
 
 config AR7
 	bool "Texas Instruments AR7"
diff --git a/arch/mips/alchemy/Kconfig b/arch/mips/alchemy/Kconfig
index 2ccfd4a..2a68be6 100644
--- a/arch/mips/alchemy/Kconfig
+++ b/arch/mips/alchemy/Kconfig
@@ -18,20 +18,20 @@ config MIPS_MTX1
 	bool "4G Systems MTX-1 board"
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
-	select SOC_AU1500
+	select ALCHEMY_GPIOINT_AU1000
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_HAS_EARLY_PRINTK
 
 config MIPS_BOSPORUS
 	bool "Alchemy Bosporus board"
-	select SOC_AU1500
+	select ALCHEMY_GPIOINT_AU1000
 	select DMA_NONCOHERENT
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_HAS_EARLY_PRINTK
 
 config MIPS_DB1000
 	bool "Alchemy DB1000 board"
-	select SOC_AU1000
+	select ALCHEMY_GPIOINT_AU1000
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
 	select SYS_SUPPORTS_LITTLE_ENDIAN
@@ -39,14 +39,14 @@ config MIPS_DB1000
 
 config MIPS_DB1100
 	bool "Alchemy DB1100 board"
-	select SOC_AU1100
+	select ALCHEMY_GPIOINT_AU1000
 	select DMA_NONCOHERENT
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_HAS_EARLY_PRINTK
 
 config MIPS_DB1200
 	bool "Alchemy DB1200 board"
-	select SOC_AU1200
+	select ALCHEMY_GPIOINT_AU1000
 	select DMA_COHERENT
 	select MIPS_DISABLE_OBSOLETE_IDE
 	select SYS_SUPPORTS_LITTLE_ENDIAN
@@ -54,7 +54,7 @@ config MIPS_DB1200
 
 config MIPS_DB1500
 	bool "Alchemy DB1500 board"
-	select SOC_AU1500
+	select ALCHEMY_GPIOINT_AU1000
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
 	select MIPS_DISABLE_OBSOLETE_IDE
@@ -64,7 +64,7 @@ config MIPS_DB1500
 
 config MIPS_DB1550
 	bool "Alchemy DB1550 board"
-	select SOC_AU1550
+	select ALCHEMY_GPIOINT_AU1000
 	select HW_HAS_PCI
 	select DMA_NONCOHERENT
 	select MIPS_DISABLE_OBSOLETE_IDE
@@ -74,13 +74,13 @@ config MIPS_DB1550
 config MIPS_MIRAGE
 	bool "Alchemy Mirage board"
 	select DMA_NONCOHERENT
-	select SOC_AU1500
+	select ALCHEMY_GPIOINT_AU1000
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_HAS_EARLY_PRINTK
 
 config MIPS_PB1000
 	bool "Alchemy PB1000 board"
-	select SOC_AU1000
+	select ALCHEMY_GPIOINT_AU1000
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
 	select SWAP_IO_SPACE
@@ -89,7 +89,7 @@ config MIPS_PB1000
 
 config MIPS_PB1100
 	bool "Alchemy PB1100 board"
-	select SOC_AU1100
+	select ALCHEMY_GPIOINT_AU1000
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
 	select SWAP_IO_SPACE
@@ -98,7 +98,7 @@ config MIPS_PB1100
 
 config MIPS_PB1200
 	bool "Alchemy PB1200 board"
-	select SOC_AU1200
+	select ALCHEMY_GPIOINT_AU1000
 	select DMA_NONCOHERENT
 	select MIPS_DISABLE_OBSOLETE_IDE
 	select SYS_SUPPORTS_LITTLE_ENDIAN
@@ -106,7 +106,7 @@ config MIPS_PB1200
 
 config MIPS_PB1500
 	bool "Alchemy PB1500 board"
-	select SOC_AU1500
+	select ALCHEMY_GPIOINT_AU1000
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
 	select SYS_SUPPORTS_LITTLE_ENDIAN
@@ -114,7 +114,7 @@ config MIPS_PB1500
 
 config MIPS_PB1550
 	bool "Alchemy PB1550 board"
-	select SOC_AU1550
+	select ALCHEMY_GPIOINT_AU1000
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
 	select MIPS_DISABLE_OBSOLETE_IDE
@@ -124,13 +124,13 @@ config MIPS_PB1550
 config MIPS_XXS1500
 	bool "MyCable XXS1500 board"
 	select DMA_NONCOHERENT
-	select SOC_AU1500
+	select ALCHEMY_GPIOINT_AU1000
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_HAS_EARLY_PRINTK
 
 config MIPS_GPR
 	bool "Trapeze ITS GPR board"
-	select SOC_AU1550
+	select ALCHEMY_GPIOINT_AU1000
 	select HW_HAS_PCI
 	select DMA_NONCOHERENT
 	select MIPS_DISABLE_OBSOLETE_IDE
@@ -138,23 +138,3 @@ config MIPS_GPR
 	select SYS_HAS_EARLY_PRINTK
 
 endchoice
-
-config SOC_AU1000
-	bool
-	select ALCHEMY_GPIOINT_AU1000
-
-config SOC_AU1100
-	bool
-	select ALCHEMY_GPIOINT_AU1000
-
-config SOC_AU1500
-	bool
-	select ALCHEMY_GPIOINT_AU1000
-
-config SOC_AU1550
-	bool
-	select ALCHEMY_GPIOINT_AU1000
-
-config SOC_AU1200
-	bool
-	select ALCHEMY_GPIOINT_AU1000
diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/common/platform.c
index 657ae27..c8e5d72 100644
--- a/arch/mips/alchemy/common/platform.c
+++ b/arch/mips/alchemy/common/platform.c
@@ -189,159 +189,6 @@ static void __init alchemy_setup_usb(int ctype)
 	}
 }
 
-/*** AU1100 LCD controller ***/
-
-#ifdef CONFIG_FB_AU1100
-static struct resource au1100_lcd_resources[] = {
-	[0] = {
-		.start          = AU1100_LCD_PHYS_ADDR,
-		.end            = AU1100_LCD_PHYS_ADDR + 0x800 - 1,
-		.flags          = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start          = AU1100_LCD_INT,
-		.end            = AU1100_LCD_INT,
-		.flags          = IORESOURCE_IRQ,
-	}
-};
-
-static u64 au1100_lcd_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device au1100_lcd_device = {
-	.name           = "au1100-lcd",
-	.id             = 0,
-	.dev = {
-		.dma_mask               = &au1100_lcd_dmamask,
-		.coherent_dma_mask      = DMA_BIT_MASK(32),
-	},
-	.num_resources  = ARRAY_SIZE(au1100_lcd_resources),
-	.resource       = au1100_lcd_resources,
-};
-#endif
-
-#ifdef CONFIG_SOC_AU1200
-
-static struct resource au1200_lcd_resources[] = {
-	[0] = {
-		.start          = AU1200_LCD_PHYS_ADDR,
-		.end            = AU1200_LCD_PHYS_ADDR + 0x800 - 1,
-		.flags          = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start          = AU1200_LCD_INT,
-		.end            = AU1200_LCD_INT,
-		.flags          = IORESOURCE_IRQ,
-	}
-};
-
-static u64 au1200_lcd_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device au1200_lcd_device = {
-	.name           = "au1200-lcd",
-	.id             = 0,
-	.dev = {
-		.dma_mask               = &au1200_lcd_dmamask,
-		.coherent_dma_mask      = DMA_BIT_MASK(32),
-	},
-	.num_resources  = ARRAY_SIZE(au1200_lcd_resources),
-	.resource       = au1200_lcd_resources,
-};
-
-static u64 au1xxx_mmc_dmamask =  DMA_BIT_MASK(32);
-
-extern struct au1xmmc_platform_data au1xmmc_platdata[2];
-
-static struct resource au1200_mmc0_resources[] = {
-	[0] = {
-		.start          = AU1100_SD0_PHYS_ADDR,
-		.end            = AU1100_SD0_PHYS_ADDR + 0xfff,
-		.flags          = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start		= AU1200_SD_INT,
-		.end		= AU1200_SD_INT,
-		.flags		= IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start		= AU1200_DSCR_CMD0_SDMS_TX0,
-		.end		= AU1200_DSCR_CMD0_SDMS_TX0,
-		.flags		= IORESOURCE_DMA,
-	},
-	[3] = {
-		.start          = AU1200_DSCR_CMD0_SDMS_RX0,
-		.end		= AU1200_DSCR_CMD0_SDMS_RX0,
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
-		.start          = AU1100_SD1_PHYS_ADDR,
-		.end            = AU1100_SD1_PHYS_ADDR + 0xfff,
-		.flags          = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start		= AU1200_SD_INT,
-		.end		= AU1200_SD_INT,
-		.flags		= IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start		= AU1200_DSCR_CMD0_SDMS_TX1,
-		.end		= AU1200_DSCR_CMD0_SDMS_TX1,
-		.flags		= IORESOURCE_DMA,
-	},
-	[3] = {
-		.start          = AU1200_DSCR_CMD0_SDMS_RX1,
-		.end		= AU1200_DSCR_CMD0_SDMS_RX1,
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
-#endif /* #ifdef CONFIG_SOC_AU1200 */
-
-/* All Alchemy demoboards with I2C have this #define in their headers */
-#ifdef SMBUS_PSC_BASE
-static struct resource pbdb_smbus_resources[] = {
-	{
-		.start	= SMBUS_PSC_BASE,
-		.end	= SMBUS_PSC_BASE + 0xfff,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-static struct platform_device pbdb_smbus_device = {
-	.name		= "au1xpsc_smbus",
-	.id		= 0,	/* bus number */
-	.num_resources	= ARRAY_SIZE(pbdb_smbus_resources),
-	.resource	= pbdb_smbus_resources,
-};
-#endif
-
 /* Macro to help defining the Ethernet MAC resources */
 #define MAC_RES_COUNT	4	/* MAC regs, MAC en, MAC INT, MACDMA regs */
 #define MAC_RES(_base, _enable, _irq, _macdma)		\
@@ -503,33 +350,15 @@ static void __init alchemy_setup_macs(int ctype)
 	}
 }
 
-static struct platform_device *au1xxx_platform_devices[] __initdata = {
-#ifdef CONFIG_FB_AU1100
-	&au1100_lcd_device,
-#endif
-#ifdef CONFIG_SOC_AU1200
-	&au1200_lcd_device,
-	&au1200_mmc0_device,
-#ifndef CONFIG_MIPS_DB1200
-	&au1200_mmc1_device,
-#endif
-#endif
-#ifdef SMBUS_PSC_BASE
-	&pbdb_smbus_device,
-#endif
-};
-
 static int __init au1xxx_platform_init(void)
 {
-	int err, ctype = alchemy_get_cputype();
+	int ctype = alchemy_get_cputype();
 
 	alchemy_setup_uarts(ctype);
 	alchemy_setup_macs(ctype);
 	alchemy_setup_usb(ctype);
 
-	err = platform_add_devices(au1xxx_platform_devices,
-				   ARRAY_SIZE(au1xxx_platform_devices));
-	return err;
+	return 0;
 }
 
 arch_initcall(au1xxx_platform_init);
diff --git a/arch/mips/alchemy/devboards/db1200/platform.c b/arch/mips/alchemy/devboards/db1200/platform.c
index 1bc16f0..aae08c1 100644
--- a/arch/mips/alchemy/devboards/db1200/platform.c
+++ b/arch/mips/alchemy/devboards/db1200/platform.c
@@ -333,15 +333,77 @@ static struct led_classdev db1200_mmc_led = {
 	.brightness_set	= db1200_mmcled_set,
 };
 
-/* needed by arch/mips/alchemy/common/platform.c */
-struct au1xmmc_platform_data au1xmmc_platdata[] = {
+static struct au1xmmc_platform_data db1200mmc_platdata = {
+	.cd_setup	= db1200_mmc_cd_setup,
+	.set_power	= db1200_mmc_set_power,
+	.card_inserted	= db1200_mmc_card_inserted,
+	.card_readonly	= db1200_mmc_card_readonly,
+	.led		= &db1200_mmc_led,
+};
+
+static struct resource au1200_mmc0_resources[] = {
+	[0] = {
+		.start	= AU1100_SD0_PHYS_ADDR,
+		.end	= AU1100_SD0_PHYS_ADDR + 0xfff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AU1200_SD_INT,
+		.end	= AU1200_SD_INT,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= AU1200_DSCR_CMD0_SDMS_TX0,
+		.end	= AU1200_DSCR_CMD0_SDMS_TX0,
+		.flags	= IORESOURCE_DMA,
+	},
+	[3] = {
+		.start	= AU1200_DSCR_CMD0_SDMS_RX0,
+		.end	= AU1200_DSCR_CMD0_SDMS_RX0,
+		.flags	= IORESOURCE_DMA,
+	}
+};
+
+static u64 au1xxx_mmc_dmamask =  DMA_BIT_MASK(32);
+
+static struct platform_device db1200_mmc0_dev = {
+	.name		= "au1xxx-mmc",
+	.id		= 0,
+	.dev = {
+		.dma_mask		= &au1xxx_mmc_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+		.platform_data		= &db1200mmc_platdata,
+	},
+	.num_resources	= ARRAY_SIZE(au1200_mmc0_resources),
+	.resource	= au1200_mmc0_resources,
+};
+
+/**********************************************************************/
+
+static struct resource au1200_lcd_res[] = {
 	[0] = {
-		.cd_setup	= db1200_mmc_cd_setup,
-		.set_power	= db1200_mmc_set_power,
-		.card_inserted	= db1200_mmc_card_inserted,
-		.card_readonly	= db1200_mmc_card_readonly,
-		.led		= &db1200_mmc_led,
+		.start	= AU1200_LCD_PHYS_ADDR,
+		.end	= AU1200_LCD_PHYS_ADDR + 0x800 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AU1200_LCD_INT,
+		.end	= AU1200_LCD_INT,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+static u64 au1200_lcd_dmamask = DMA_BIT_MASK(32);
+
+static struct platform_device au1200_lcd_dev = {
+	.name		= "au1200-lcd",
+	.id		= 0,
+	.dev = {
+		.dma_mask		= &au1200_lcd_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
 	},
+	.num_resources	= ARRAY_SIZE(au1200_lcd_res),
+	.resource	= au1200_lcd_res,
 };
 
 /**********************************************************************/
@@ -442,6 +504,8 @@ static struct platform_device db1200_stac_dev = {
 static struct platform_device *db1200_devs[] __initdata = {
 	NULL,		/* PSC0, selected by S6.8 */
 	&db1200_ide_dev,
+	&db1200_mmc0_dev,
+	&au1200_lcd_dev,
 	&db1200_eth_dev,
 	&db1200_rtc_dev,
 	&db1200_nand_dev,
diff --git a/arch/mips/alchemy/devboards/db1x00/board_setup.c b/arch/mips/alchemy/devboards/db1x00/board_setup.c
index 2b2178f..7cd36e6 100644
--- a/arch/mips/alchemy/devboards/db1x00/board_setup.c
+++ b/arch/mips/alchemy/devboards/db1x00/board_setup.c
@@ -134,9 +134,7 @@ void __init board_setup(void)
 	/* initialize board register space */
 	bcsr_init(bcsr1, bcsr2);
 
-	/* Not valid for Au1550 */
-#if defined(CONFIG_IRDA) && \
-   (defined(CONFIG_SOC_AU1000) || defined(CONFIG_SOC_AU1100))
+#if defined(CONFIG_IRDA) && defined(CONFIG_AU1000_FIR)
 	{
 		u32 pin_func;
 
diff --git a/arch/mips/alchemy/devboards/db1x00/platform.c b/arch/mips/alchemy/devboards/db1x00/platform.c
index 990367f..8704865 100644
--- a/arch/mips/alchemy/devboards/db1x00/platform.c
+++ b/arch/mips/alchemy/devboards/db1x00/platform.c
@@ -19,6 +19,7 @@
  */
 
 #include <linux/init.h>
+#include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
 
 #include <asm/mach-au1x00/au1000.h>
@@ -208,6 +209,34 @@ static int __init db15x0_pci_init(void)
 arch_initcall(db15x0_pci_init);
 #endif
 
+#ifdef CONFIG_MIPS_DB1100
+static struct resource au1100_lcd_resources[] = {
+	[0] = {
+		.start	= AU1100_LCD_PHYS_ADDR,
+		.end	= AU1100_LCD_PHYS_ADDR + 0x800 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AU1100_LCD_INT,
+		.end	= AU1100_LCD_INT,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+static u64 au1100_lcd_dmamask = DMA_BIT_MASK(32);
+
+static struct platform_device au1100_lcd_device = {
+	.name		= "au1100-lcd",
+	.id		= 0,
+	.dev = {
+		.dma_mask		= &au1100_lcd_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+	.num_resources	= ARRAY_SIZE(au1100_lcd_resources),
+	.resource	= au1100_lcd_resources,
+};
+#endif
+
 static int __init db1xxx_dev_init(void)
 {
 #ifdef DB1XXX_HAS_PCMCIA
@@ -231,6 +260,9 @@ static int __init db1xxx_dev_init(void)
 		DB1XXX_PCMCIA_CARD1, DB1XXX_PCMCIA_CD1,
 		/*DB1XXX_PCMCIA_STSCHG1*/0, 0, 1);
 #endif
+#ifdef CONFIG_MIPS_DB1100
+	platform_device_register(&au1100_lcd_device);
+#endif
 	db1x_register_norflash(BOARD_FLASH_SIZE, BOARD_FLASH_WIDTH, F_SWAPPED);
 	return 0;
 }
diff --git a/arch/mips/alchemy/devboards/pb1100/platform.c b/arch/mips/alchemy/devboards/pb1100/platform.c
index 8a4e733..9c57c01 100644
--- a/arch/mips/alchemy/devboards/pb1100/platform.c
+++ b/arch/mips/alchemy/devboards/pb1100/platform.c
@@ -19,12 +19,40 @@
  */
 
 #include <linux/init.h>
+#include <linux/dma-mapping.h>
+#include <linux/platform_device.h>
 
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-db1x00/bcsr.h>
 
 #include "../platform.h"
 
+static struct resource au1100_lcd_resources[] = {
+	[0] = {
+		.start	= AU1100_LCD_PHYS_ADDR,
+		.end	= AU1100_LCD_PHYS_ADDR + 0x800 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AU1100_LCD_INT,
+		.end	= AU1100_LCD_INT,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+static u64 au1100_lcd_dmamask = DMA_BIT_MASK(32);
+
+static struct platform_device au1100_lcd_device = {
+	.name		= "au1100-lcd",
+	.id		= 0,
+	.dev = {
+		.dma_mask		= &au1100_lcd_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+	.num_resources	= ARRAY_SIZE(au1100_lcd_resources),
+	.resource	= au1100_lcd_resources,
+};
+
 static int __init pb1100_dev_init(void)
 {
 	int swapped;
@@ -42,6 +70,7 @@ static int __init pb1100_dev_init(void)
 
 	swapped = bcsr_read(BCSR_STATUS) &  BCSR_STATUS_DB1000_SWAPBOOT;
 	db1x_register_norflash(64 * 1024 * 1024, 4, swapped);
+	platform_device_register(&au1100_lcd_device);
 
 	return 0;
 }
diff --git a/arch/mips/alchemy/devboards/pb1200/platform.c b/arch/mips/alchemy/devboards/pb1200/platform.c
index d7915b0..54f7f7b 100644
--- a/arch/mips/alchemy/devboards/pb1200/platform.c
+++ b/arch/mips/alchemy/devboards/pb1200/platform.c
@@ -90,7 +90,7 @@ static int pb1200mmc1_card_inserted(void *mmc_host)
 	return (bcsr_read(BCSR_SIGSTAT) & BCSR_INT_SD1INSERT) ? 1 : 0;
 }
 
-const struct au1xmmc_platform_data au1xmmc_platdata[2] = {
+static struct au1xmmc_platform_data pb1200mmc_platdata[2] = {
 	[0] = {
 		.set_power	= pb1200mmc0_set_power,
 		.card_inserted	= pb1200mmc0_card_inserted,
@@ -107,6 +107,79 @@ const struct au1xmmc_platform_data au1xmmc_platdata[2] = {
 	},
 };
 
+static u64 au1xxx_mmc_dmamask =  DMA_BIT_MASK(32);
+
+static struct resource au1200_mmc0_res[] = {
+	[0] = {
+		.start	= AU1100_SD0_PHYS_ADDR,
+		.end	= AU1100_SD0_PHYS_ADDR + 0xfff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AU1200_SD_INT,
+		.end	= AU1200_SD_INT,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= AU1200_DSCR_CMD0_SDMS_TX0,
+		.end	= AU1200_DSCR_CMD0_SDMS_TX0,
+		.flags	= IORESOURCE_DMA,
+	},
+	[3] = {
+		.start	= AU1200_DSCR_CMD0_SDMS_RX0,
+		.end	= AU1200_DSCR_CMD0_SDMS_RX0,
+		.flags	= IORESOURCE_DMA,
+	}
+};
+
+static struct platform_device pb1200_mmc0_dev = {
+	.name		= "au1xxx-mmc",
+	.id		= 0,
+	.dev = {
+		.dma_mask		= &au1xxx_mmc_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+		.platform_data		= &pb1200mmc_platdata[0],
+	},
+	.num_resources	= ARRAY_SIZE(au1200_mmc0_res),
+	.resource	= au1200_mmc0_res,
+};
+
+static struct resource au1200_mmc1_res[] = {
+	[0] = {
+		.start	= AU1100_SD1_PHYS_ADDR,
+		.end	= AU1100_SD1_PHYS_ADDR + 0xfff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AU1200_SD_INT,
+		.end	= AU1200_SD_INT,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= AU1200_DSCR_CMD0_SDMS_TX1,
+		.end	= AU1200_DSCR_CMD0_SDMS_TX1,
+		.flags	= IORESOURCE_DMA,
+	},
+	[3] = {
+		.start	= AU1200_DSCR_CMD0_SDMS_RX1,
+		.end	= AU1200_DSCR_CMD0_SDMS_RX1,
+		.flags	= IORESOURCE_DMA,
+	}
+};
+
+static struct platform_device pb1200_mmc1_dev = {
+	.name		= "au1xxx-mmc",
+	.id		= 1,
+	.dev = {
+		.dma_mask		= &au1xxx_mmc_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+		.platform_data		= &pb1200mmc_platdata[1],
+	},
+	.num_resources	= ARRAY_SIZE(au1200_mmc1_res),
+	.resource	= au1200_mmc1_res,
+};
+
+
 static struct resource ide_resources[] = {
 	[0] = {
 		.start	= IDE_PHYS_ADDR,
@@ -168,9 +241,69 @@ static struct platform_device smc91c111_device = {
 	.resource	= smc91c111_resources
 };
 
+static struct resource au1200_psc0_res[] = {
+	[0] = {
+		.start	= AU1550_PSC0_PHYS_ADDR,
+		.end	= AU1550_PSC0_PHYS_ADDR + 0xfff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AU1200_PSC0_INT,
+		.end	= AU1200_PSC0_INT,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= AU1200_DSCR_CMD0_PSC0_TX,
+		.end	= AU1200_DSCR_CMD0_PSC0_TX,
+		.flags	= IORESOURCE_DMA,
+	},
+	[3] = {
+		.start	= AU1200_DSCR_CMD0_PSC0_RX,
+		.end	= AU1200_DSCR_CMD0_PSC0_RX,
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+static struct platform_device pb1200_i2c_dev = {
+	.name		= "au1xpsc_smbus",
+	.id		= 0,	/* bus number */
+	.num_resources	= ARRAY_SIZE(au1200_psc0_res),
+	.resource	= au1200_psc0_res,
+};
+
+static struct resource au1200_lcd_res[] = {
+	[0] = {
+		.start	= AU1200_LCD_PHYS_ADDR,
+		.end	= AU1200_LCD_PHYS_ADDR + 0x800 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AU1200_LCD_INT,
+		.end	= AU1200_LCD_INT,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+static u64 au1200_lcd_dmamask = DMA_BIT_MASK(32);
+
+static struct platform_device au1200_lcd_dev = {
+	.name		= "au1200-lcd",
+	.id		= 0,
+	.dev = {
+		.dma_mask		= &au1200_lcd_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+	.num_resources	= ARRAY_SIZE(au1200_lcd_res),
+	.resource	= au1200_lcd_res,
+};
+
 static struct platform_device *board_platform_devices[] __initdata = {
 	&ide_device,
-	&smc91c111_device
+	&smc91c111_device,
+	&pb1200_i2c_dev,
+	&pb1200_mmc0_dev,
+	&pb1200_mmc1_dev,
+	&au1200_lcd_dev,
 };
 
 static int __init board_register_devices(void)
diff --git a/arch/mips/alchemy/devboards/pb1500/platform.c b/arch/mips/alchemy/devboards/pb1500/platform.c
index 9f0b5a0..1e52a01 100644
--- a/arch/mips/alchemy/devboards/pb1500/platform.c
+++ b/arch/mips/alchemy/devboards/pb1500/platform.c
@@ -18,6 +18,7 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#include <linux/dma-mapping.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <asm/mach-au1x00/au1000.h>
diff --git a/arch/mips/alchemy/devboards/pb1550/platform.c b/arch/mips/alchemy/devboards/pb1550/platform.c
index 0c5711f..a4604b8 100644
--- a/arch/mips/alchemy/devboards/pb1550/platform.c
+++ b/arch/mips/alchemy/devboards/pb1550/platform.c
@@ -18,9 +18,11 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#include <linux/dma-mapping.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-au1x00/au1xxx_dbdma.h>
 #include <asm/mach-pb1x00/pb1550.h>
 #include <asm/mach-db1x00/bcsr.h>
 
@@ -69,6 +71,36 @@ static struct platform_device pb1550_pci_host = {
 	.resource	= alchemy_pci_host_res,
 };
 
+static struct resource au1550_psc2_res[] = {
+	[0] = {
+		.start	= AU1550_PSC2_PHYS_ADDR,
+		.end	= AU1550_PSC2_PHYS_ADDR + 0xfff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AU1550_PSC2_INT,
+		.end	= AU1550_PSC2_INT,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= AU1550_DSCR_CMD0_PSC2_TX,
+		.end	= AU1550_DSCR_CMD0_PSC2_TX,
+		.flags	= IORESOURCE_DMA,
+	},
+	[3] = {
+		.start	= AU1550_DSCR_CMD0_PSC2_RX,
+		.end	= AU1550_DSCR_CMD0_PSC2_RX,
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+static struct platform_device pb1550_i2c_dev = {
+	.name		= "au1xpsc_smbus",
+	.id		= 0,	/* bus number */
+	.num_resources	= ARRAY_SIZE(au1550_psc2_res),
+	.resource	= au1550_psc2_res,
+};
+
 static int __init pb1550_dev_init(void)
 {
 	int swapped;
@@ -101,6 +133,7 @@ static int __init pb1550_dev_init(void)
 	swapped = bcsr_read(BCSR_STATUS) & BCSR_STATUS_PB1550_SWAPBOOT;
 	db1x_register_norflash(128 * 1024 * 1024, 4, swapped);
 	platform_device_register(&pb1550_pci_host);
+	platform_device_register(&pb1550_i2c_dev);
 
 	return 0;
 }
diff --git a/arch/mips/include/asm/mach-au1x00/au1000.h b/arch/mips/include/asm/mach-au1x00/au1000.h
index 5da2fd7..4afc3a9 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000.h
@@ -592,113 +592,6 @@ enum soc_au1200_ints {
 #endif /* !defined (_LANGUAGE_ASSEMBLY) */
 
 /*
- * SDRAM register offsets
- */
-#if defined(CONFIG_SOC_AU1000) || defined(CONFIG_SOC_AU1500) || \
-    defined(CONFIG_SOC_AU1100)
-#define MEM_SDMODE0		0x0000
-#define MEM_SDMODE1		0x0004
-#define MEM_SDMODE2		0x0008
-#define MEM_SDADDR0		0x000C
-#define MEM_SDADDR1		0x0010
-#define MEM_SDADDR2		0x0014
-#define MEM_SDREFCFG		0x0018
-#define MEM_SDPRECMD		0x001C
-#define MEM_SDAUTOREF		0x0020
-#define MEM_SDWRMD0		0x0024
-#define MEM_SDWRMD1		0x0028
-#define MEM_SDWRMD2		0x002C
-#define MEM_SDSLEEP		0x0030
-#define MEM_SDSMCKE		0x0034
-
-/*
- * MEM_SDMODE register content definitions
- */
-#define MEM_SDMODE_F		(1 << 22)
-#define MEM_SDMODE_SR		(1 << 21)
-#define MEM_SDMODE_BS		(1 << 20)
-#define MEM_SDMODE_RS		(3 << 18)
-#define MEM_SDMODE_CS		(7 << 15)
-#define MEM_SDMODE_TRAS 	(15 << 11)
-#define MEM_SDMODE_TMRD 	(3 << 9)
-#define MEM_SDMODE_TWR		(3 << 7)
-#define MEM_SDMODE_TRP		(3 << 5)
-#define MEM_SDMODE_TRCD 	(3 << 3)
-#define MEM_SDMODE_TCL		(7 << 0)
-
-#define MEM_SDMODE_BS_2Bank	(0 << 20)
-#define MEM_SDMODE_BS_4Bank	(1 << 20)
-#define MEM_SDMODE_RS_11Row	(0 << 18)
-#define MEM_SDMODE_RS_12Row	(1 << 18)
-#define MEM_SDMODE_RS_13Row	(2 << 18)
-#define MEM_SDMODE_RS_N(N)	((N) << 18)
-#define MEM_SDMODE_CS_7Col	(0 << 15)
-#define MEM_SDMODE_CS_8Col	(1 << 15)
-#define MEM_SDMODE_CS_9Col	(2 << 15)
-#define MEM_SDMODE_CS_10Col	(3 << 15)
-#define MEM_SDMODE_CS_11Col	(4 << 15)
-#define MEM_SDMODE_CS_N(N)	((N) << 15)
-#define MEM_SDMODE_TRAS_N(N)	((N) << 11)
-#define MEM_SDMODE_TMRD_N(N)	((N) << 9)
-#define MEM_SDMODE_TWR_N(N)	((N) << 7)
-#define MEM_SDMODE_TRP_N(N)	((N) << 5)
-#define MEM_SDMODE_TRCD_N(N)	((N) << 3)
-#define MEM_SDMODE_TCL_N(N)	((N) << 0)
-
-/*
- * MEM_SDADDR register contents definitions
- */
-#define MEM_SDADDR_E		(1 << 20)
-#define MEM_SDADDR_CSBA 	(0x03FF << 10)
-#define MEM_SDADDR_CSMASK	(0x03FF << 0)
-#define MEM_SDADDR_CSBA_N(N)	((N) & (0x03FF << 22) >> 12)
-#define MEM_SDADDR_CSMASK_N(N)	((N)&(0x03FF << 22) >> 22)
-
-/*
- * MEM_SDREFCFG register content definitions
- */
-#define MEM_SDREFCFG_TRC	(15 << 28)
-#define MEM_SDREFCFG_TRPM	(3 << 26)
-#define MEM_SDREFCFG_E		(1 << 25)
-#define MEM_SDREFCFG_RE 	(0x1ffffff << 0)
-#define MEM_SDREFCFG_TRC_N(N)	((N) << MEM_SDREFCFG_TRC)
-#define MEM_SDREFCFG_TRPM_N(N)	((N) << MEM_SDREFCFG_TRPM)
-#define MEM_SDREFCFG_REF_N(N)	(N)
-#endif
-
-/***********************************************************************/
-
-/*
- * Au1550 SDRAM Register Offsets
- */
-
-/***********************************************************************/
-
-#if defined(CONFIG_SOC_AU1550) || defined(CONFIG_SOC_AU1200)
-#define MEM_SDMODE0		0x0800
-#define MEM_SDMODE1		0x0808
-#define MEM_SDMODE2		0x0810
-#define MEM_SDADDR0		0x0820
-#define MEM_SDADDR1		0x0828
-#define MEM_SDADDR2		0x0830
-#define MEM_SDCONFIGA		0x0840
-#define MEM_SDCONFIGB		0x0848
-#define MEM_SDSTAT		0x0850
-#define MEM_SDERRADDR		0x0858
-#define MEM_SDSTRIDE0		0x0860
-#define MEM_SDSTRIDE1		0x0868
-#define MEM_SDSTRIDE2		0x0870
-#define MEM_SDWRMD0		0x0880
-#define MEM_SDWRMD1		0x0888
-#define MEM_SDWRMD2		0x0890
-#define MEM_SDPRECMD		0x08C0
-#define MEM_SDAUTOREF		0x08C8
-#define MEM_SDSREF		0x08D0
-#define MEM_SDSLEEP		MEM_SDSREF
-
-#endif
-
-/*
  * Physical base addresses for integrated peripherals
  * 0..au1000 1..au1500 2..au1100 3..au1550 4..au1200
  */
@@ -761,6 +654,92 @@ enum soc_au1200_ints {
 #define AU1000_PCMCIA_MEM_PHYS_ADDR	0xF80000000ULL /* 01234 */
 
 
+/* Au1000 SDRAM memory controller register offsets */
+#define AU1000_MEM_SDMODE0		0x0000
+#define AU1000_MEM_SDMODE1		0x0004
+#define AU1000_MEM_SDMODE2		0x0008
+#define AU1000_MEM_SDADDR0		0x000C
+#define AU1000_MEM_SDADDR1		0x0010
+#define AU1000_MEM_SDADDR2		0x0014
+#define AU1000_MEM_SDREFCFG		0x0018
+#define AU1000_MEM_SDPRECMD		0x001C
+#define AU1000_MEM_SDAUTOREF		0x0020
+#define AU1000_MEM_SDWRMD0		0x0024
+#define AU1000_MEM_SDWRMD1		0x0028
+#define AU1000_MEM_SDWRMD2		0x002C
+#define AU1000_MEM_SDSLEEP		0x0030
+#define AU1000_MEM_SDSMCKE		0x0034
+
+/* MEM_SDMODE register content definitions */
+#define MEM_SDMODE_F		(1 << 22)
+#define MEM_SDMODE_SR		(1 << 21)
+#define MEM_SDMODE_BS		(1 << 20)
+#define MEM_SDMODE_RS		(3 << 18)
+#define MEM_SDMODE_CS		(7 << 15)
+#define MEM_SDMODE_TRAS		(15 << 11)
+#define MEM_SDMODE_TMRD		(3 << 9)
+#define MEM_SDMODE_TWR		(3 << 7)
+#define MEM_SDMODE_TRP		(3 << 5)
+#define MEM_SDMODE_TRCD		(3 << 3)
+#define MEM_SDMODE_TCL		(7 << 0)
+
+#define MEM_SDMODE_BS_2Bank	(0 << 20)
+#define MEM_SDMODE_BS_4Bank	(1 << 20)
+#define MEM_SDMODE_RS_11Row	(0 << 18)
+#define MEM_SDMODE_RS_12Row	(1 << 18)
+#define MEM_SDMODE_RS_13Row	(2 << 18)
+#define MEM_SDMODE_RS_N(N)	((N) << 18)
+#define MEM_SDMODE_CS_7Col	(0 << 15)
+#define MEM_SDMODE_CS_8Col	(1 << 15)
+#define MEM_SDMODE_CS_9Col	(2 << 15)
+#define MEM_SDMODE_CS_10Col	(3 << 15)
+#define MEM_SDMODE_CS_11Col	(4 << 15)
+#define MEM_SDMODE_CS_N(N)	((N) << 15)
+#define MEM_SDMODE_TRAS_N(N)	((N) << 11)
+#define MEM_SDMODE_TMRD_N(N)	((N) << 9)
+#define MEM_SDMODE_TWR_N(N)	((N) << 7)
+#define MEM_SDMODE_TRP_N(N)	((N) << 5)
+#define MEM_SDMODE_TRCD_N(N)	((N) << 3)
+#define MEM_SDMODE_TCL_N(N)	((N) << 0)
+
+/* MEM_SDADDR register contents definitions */
+#define MEM_SDADDR_E		(1 << 20)
+#define MEM_SDADDR_CSBA		(0x03FF << 10)
+#define MEM_SDADDR_CSMASK	(0x03FF << 0)
+#define MEM_SDADDR_CSBA_N(N)	((N) & (0x03FF << 22) >> 12)
+#define MEM_SDADDR_CSMASK_N(N)	((N)&(0x03FF << 22) >> 22)
+
+/* MEM_SDREFCFG register content definitions */
+#define MEM_SDREFCFG_TRC	(15 << 28)
+#define MEM_SDREFCFG_TRPM	(3 << 26)
+#define MEM_SDREFCFG_E		(1 << 25)
+#define MEM_SDREFCFG_RE		(0x1ffffff << 0)
+#define MEM_SDREFCFG_TRC_N(N)	((N) << MEM_SDREFCFG_TRC)
+#define MEM_SDREFCFG_TRPM_N(N)	((N) << MEM_SDREFCFG_TRPM)
+#define MEM_SDREFCFG_REF_N(N)	(N)
+
+/* Au1550 SDRAM Register Offsets */
+#define AU1550_MEM_SDMODE0		0x0800
+#define AU1550_MEM_SDMODE1		0x0808
+#define AU1550_MEM_SDMODE2		0x0810
+#define AU1550_MEM_SDADDR0		0x0820
+#define AU1550_MEM_SDADDR1		0x0828
+#define AU1550_MEM_SDADDR2		0x0830
+#define AU1550_MEM_SDCONFIGA		0x0840
+#define AU1550_MEM_SDCONFIGB		0x0848
+#define AU1550_MEM_SDSTAT		0x0850
+#define AU1550_MEM_SDERRADDR		0x0858
+#define AU1550_MEM_SDSTRIDE0		0x0860
+#define AU1550_MEM_SDSTRIDE1		0x0868
+#define AU1550_MEM_SDSTRIDE2		0x0870
+#define AU1550_MEM_SDWRMD0		0x0880
+#define AU1550_MEM_SDWRMD1		0x0888
+#define AU1550_MEM_SDWRMD2		0x0890
+#define AU1550_MEM_SDPRECMD		0x08C0
+#define AU1550_MEM_SDAUTOREF		0x08C8
+#define AU1550_MEM_SDSREF		0x08D0
+#define AU1550_MEM_SDSLEEP		MEM_SDSREF
+
 /* Static Bus Controller */
 #define MEM_STCFG0		0xB4001000
 #define MEM_STTIME0		0xB4001004
@@ -778,14 +757,12 @@ enum soc_au1200_ints {
 #define MEM_STTIME3		0xB4001034
 #define MEM_STADDR3		0xB4001038
 
-#if defined(CONFIG_SOC_AU1550) || defined(CONFIG_SOC_AU1200)
 #define MEM_STNDCTL		0xB4001100
 #define MEM_STSTAT		0xB4001104
 
 #define MEM_STNAND_CMD		0x0
 #define MEM_STNAND_ADDR 	0x4
 #define MEM_STNAND_DATA 	0x20
-#endif
 
 
 /* Programmable Counters 0 and 1 */
@@ -1172,7 +1149,6 @@ enum soc_au1200_ints {
 #  define SYS_PF_MUST_BE_SET	((1 << 5) | (1 << 2))
 
 /* Au1200 only */
-#ifdef CONFIG_SOC_AU1200
 #define SYS_PINFUNC_DMA 	(1 << 31)
 #define SYS_PINFUNC_S0A 	(1 << 30)
 #define SYS_PINFUNC_S1A 	(1 << 29)
@@ -1200,7 +1176,6 @@ enum soc_au1200_ints {
 #define SYS_PINFUNC_P0B 	(1 << 4)
 #define SYS_PINFUNC_U0T 	(1 << 3)
 #define SYS_PINFUNC_S1B 	(1 << 2)
-#endif
 
 /* Power Management */
 #define SYS_SCRATCH0		0xB1900018
@@ -1256,12 +1231,12 @@ enum soc_au1200_ints {
 #  define SYS_CS_MI2_MASK	(0x7 << SYS_CS_MI2_BIT)
 #  define SYS_CS_DI2		(1 << 16)
 #  define SYS_CS_CI2		(1 << 15)
-#ifdef CONFIG_SOC_AU1100
+
 #  define SYS_CS_ML_BIT 	7
 #  define SYS_CS_ML_MASK	(0x7 << SYS_CS_ML_BIT)
 #  define SYS_CS_DL		(1 << 6)
 #  define SYS_CS_CL		(1 << 5)
-#else
+
 #  define SYS_CS_MUH_BIT	12
 #  define SYS_CS_MUH_MASK	(0x7 << SYS_CS_MUH_BIT)
 #  define SYS_CS_DUH		(1 << 11)
@@ -1270,7 +1245,7 @@ enum soc_au1200_ints {
 #  define SYS_CS_MUD_MASK	(0x7 << SYS_CS_MUD_BIT)
 #  define SYS_CS_DUD		(1 << 6)
 #  define SYS_CS_CUD		(1 << 5)
-#endif
+
 #  define SYS_CS_MIR_BIT	2
 #  define SYS_CS_MIR_MASK	(0x7 << SYS_CS_MIR_BIT)
 #  define SYS_CS_DIR		(1 << 1)
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 646068e..1908195 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -301,7 +301,7 @@ config I2C_AT91
 
 config I2C_AU1550
 	tristate "Au1550/Au1200 SMBus interface"
-	depends on SOC_AU1550 || SOC_AU1200
+	depends on MIPS_ALCHEMY
 	help
 	  If you say yes to this option, support will be included for the
 	  Au1550 and Au1200 SMBus interface.
diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
index 9827c5e..ec42e6c 100644
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -677,19 +677,19 @@ config BLK_DEV_IDE_PMAC_ATA100FIRST
 
 config BLK_DEV_IDE_AU1XXX
        bool "IDE for AMD Alchemy Au1200"
-       depends on SOC_AU1200
+       depends on MIPS_ALCHEMY
        select IDE_XFER_MODE
 choice
        prompt "IDE Mode for AMD Alchemy Au1200"
        default CONFIG_BLK_DEV_IDE_AU1XXX_PIO_DBDMA
-       depends on SOC_AU1200 && BLK_DEV_IDE_AU1XXX
+       depends on BLK_DEV_IDE_AU1XXX
 
 config BLK_DEV_IDE_AU1XXX_PIO_DBDMA
        bool "PIO+DbDMA IDE for AMD Alchemy Au1200"
 
 config BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA
        bool "MDMA2+DbDMA IDE for AMD Alchemy Au1200"
-       depends on SOC_AU1200 && BLK_DEV_IDE_AU1XXX
+       depends on BLK_DEV_IDE_AU1XXX
 endchoice
 
 config BLK_DEV_IDE_TX4938
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 8c87096..6d74f49 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -263,7 +263,7 @@ config MMC_WBSD
 
 config MMC_AU1X
 	tristate "Alchemy AU1XX0 MMC Card Interface support"
-	depends on SOC_AU1200
+	depends on MIPS_ALCHEMY
 	help
 	  This selects the AMD Alchemy(R) Multimedia card interface.
 	  If you have a Alchemy platform with a MMC slot, say Y or M here.
diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 4c34252..dbfa0f7 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -138,7 +138,7 @@ config MTD_NAND_RICOH
 
 config MTD_NAND_AU1550
 	tristate "Au1550/1200 NAND support"
-	depends on SOC_AU1200 || SOC_AU1550
+	depends on MIPS_ALCHEMY
 	help
 	  This enables the driver for the NAND flash controller on the
 	  AMD/Alchemy 1550 SOC.
diff --git a/drivers/net/irda/Kconfig b/drivers/net/irda/Kconfig
index 25bb2a0..0cda6c4 100644
--- a/drivers/net/irda/Kconfig
+++ b/drivers/net/irda/Kconfig
@@ -314,7 +314,7 @@ config TOSHIBA_FIR
 
 config AU1000_FIR
 	tristate "Alchemy Au1000 SIR/FIR"
-	depends on SOC_AU1000 && IRDA
+	depends on IRDA && MIPS_ALCHEMY
 
 config SMC_IRCC_FIR
 	tristate "SMSC IrCC (EXPERIMENTAL)"
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 52e2900..a1fd73d 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -88,7 +88,7 @@ config SPI_BFIN_SPORT
 
 config SPI_AU1550
 	tristate "Au1550/Au12x0 SPI Controller"
-	depends on (SOC_AU1550 || SOC_AU1200) && EXPERIMENTAL
+	depends on MIPS_ALCHEMY && EXPERIMENTAL
 	select SPI_BITBANG
 	help
 	  If you say yes to this option, support will be included for the
diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 48f1781..85d5a01 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -56,7 +56,6 @@ config USB_ARCH_HAS_EHCI
 	boolean
 	default y if PPC_83xx
 	default y if PPC_MPC512x
-	default y if SOC_AU1200
 	default y if ARCH_IXP4XX
 	default y if ARCH_W90X900
 	default y if ARCH_AT91SAM9G45
diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index f72ae0b..47aa22d 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -1196,7 +1196,7 @@ MODULE_LICENSE ("GPL");
 #define PLATFORM_DRIVER		ehci_hcd_sh_driver
 #endif
 
-#ifdef CONFIG_SOC_AU1200
+#ifdef CONFIG_MIPS_ALCHEMY
 #include "ehci-au1xxx.c"
 #define	PLATFORM_DRIVER		ehci_hcd_au1xxx_driver
 #endif
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 549b960..55a7df4 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1744,7 +1744,7 @@ endchoice
 
 config FB_AU1100
 	bool "Au1100 LCD Driver"
-	depends on (FB = y) && MIPS && SOC_AU1100
+	depends on (FB = y) && MIPS_ALCHEMY
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -1755,7 +1755,7 @@ config FB_AU1100
 
 config FB_AU1200
 	bool "Au1200 LCD Driver"
-	depends on (FB = y) && MIPS && SOC_AU1200
+	depends on (FB = y) && MIPS_ALCHEMY
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
diff --git a/sound/mips/Kconfig b/sound/mips/Kconfig
index a9823fa..0a0d501 100644
--- a/sound/mips/Kconfig
+++ b/sound/mips/Kconfig
@@ -24,7 +24,7 @@ config SND_SGI_HAL2
 
 config SND_AU1X00
 	tristate "Au1x00 AC97 Port Driver"
-	depends on SOC_AU1000 || SOC_AU1100 || SOC_AU1500
+	depends on MIPS_ALCHEMY
 	select SND_PCM
 	select SND_AC97_CODEC
 	help
diff --git a/sound/soc/au1x/Kconfig b/sound/soc/au1x/Kconfig
index 4b67140..606039f 100644
--- a/sound/soc/au1x/Kconfig
+++ b/sound/soc/au1x/Kconfig
@@ -3,7 +3,7 @@
 ##
 config SND_SOC_AU1XPSC
 	tristate "SoC Audio for Au1200/Au1250/Au1550"
-	depends on SOC_AU1200 || SOC_AU1550
+	depends on MIPS_ALCHEMY
 	help
 	  This option enables support for the Programmable Serial
 	  Controllers in AC97 and I2S mode, and the Descriptor-Based DMA
-- 
1.7.6
