From: Manuel Lauss <mlau@msc-ge.com>
Date: Sat, 17 May 2008 17:48:02 +0200
Subject: [PATCH] Alchemy: register mmc platform device for db1200/pb1200 boards
Message-ID: <20080517154802.MY3CLNPS_k_6dH4KpKCa2s4hhBaw7W5eONxbTD2ZaTo@z>

Add au1xmmc platform data for PB1200/DB1200 boards, and wire up
the 2 SD controllers for them.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/au1000/common/platform.c |   88 ++++++++++++++++++++++++++----------
 arch/mips/au1000/pb1200/platform.c |   60 ++++++++++++++++++++++++
 2 files changed, 124 insertions(+), 24 deletions(-)

diff --git a/arch/mips/au1000/common/platform.c b/arch/mips/au1000/common/platform.c
index 8cae775..6225e95 100644
--- a/arch/mips/au1000/common/platform.c
+++ b/arch/mips/au1000/common/platform.c
@@ -16,6 +16,8 @@
 #include <linux/init.h>
 
 #include <asm/mach-au1x00/au1xxx.h>
+#include <asm/mach-au1x00/au1xxx_dbdma.h>
+#include <asm/mach-au1x00/au1100_mmc.h>
 
 #define PORT(_base, _irq)				\
 	{						\
@@ -162,24 +164,6 @@ static struct resource au1xxx_usb_gdt_resources[] = {
 	},
 };
 
-static struct resource au1xxx_mmc_resources[] = {
-	[0] = {
-		.start          = SD0_PHYS_ADDR,
-		.end            = SD0_PHYS_ADDR + 0x40,
-		.flags          = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start		= SD1_PHYS_ADDR,
-		.end 		= SD1_PHYS_ADDR + 0x40,
-		.flags		= IORESOURCE_MEM,
-	},
-	[2] = {
-		.start          = AU1200_SD_INT,
-		.end            = AU1200_SD_INT,
-		.flags          = IORESOURCE_IRQ,
-	}
-};
-
 static u64 udc_dmamask = ~(u32)0;
 
 static struct platform_device au1xxx_usb_gdt_device = {
@@ -248,15 +232,70 @@ static struct platform_device au1200_lcd_device = {
 
 static u64 au1xxx_mmc_dmamask =  ~(u32)0;
 
-static struct platform_device au1xxx_mmc_device = {
+extern struct au1xmmc_platform_data au1xmmc_platdata[2];
+
+static struct resource au1200_mmc0_resources[] = {
+	[0] = {
+		.start          = SD0_PHYS_ADDR,
+		.end            = SD0_PHYS_ADDR + 0x7ffff,
+		.flags          = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start		= AU1200_SD_INT,
+		.flags		= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start		= DSCR_CMD0_SDMS_TX0,
+		.flags		= IORESOURCE_DMA,
+	},
+	[3] = {
+		.start          = DSCR_CMD0_SDMS_RX0,
+		.flags          = IORESOURCE_DMA,
+	}
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
+		.flags		= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start		= DSCR_CMD0_SDMS_TX1,
+		.flags		= IORESOURCE_DMA,
+	},
+	[3] = {
+		.start          = DSCR_CMD0_SDMS_RX1,
+		.flags          = IORESOURCE_DMA,
+	}
+};
+
+static struct platform_device au1200_mmc0_device = {
 	.name = "au1xxx-mmc",
 	.id = 0,
 	.dev = {
-		.dma_mask               = &au1xxx_mmc_dmamask,
-		.coherent_dma_mask      = 0xffffffff,
+		.dma_mask		= &au1xxx_mmc_dmamask,
+		.coherent_dma_mask	= 0xffffffff,
+		.platform_data		= &au1xmmc_platdata[0],
+	},
+	.num_resources	= ARRAY_SIZE(au1200_mmc0_resources),
+	.resource	= au1200_mmc0_resources,
+};
+
+static struct platform_device au1200_mmc1_device = {
+	.name = "au1xxx-mmc",
+	.id = 1,
+	.dev = {
+		.dma_mask		= &au1xxx_mmc_dmamask,
+		.coherent_dma_mask	= 0xffffffff,
+		.platform_data		= &au1xmmc_platdata[1],
 	},
-	.num_resources  = ARRAY_SIZE(au1xxx_mmc_resources),
-	.resource       = au1xxx_mmc_resources,
+	.num_resources	= ARRAY_SIZE(au1200_mmc1_resources),
+	.resource	= au1200_mmc1_resources,
 };
 #endif /* #ifdef CONFIG_SOC_AU1200 */
 
@@ -295,7 +334,8 @@ static struct platform_device *au1xxx_platform_devices[] __initdata = {
 	&au1xxx_usb_gdt_device,
 	&au1xxx_usb_otg_device,
 	&au1200_lcd_device,
-	&au1xxx_mmc_device,
+	&au1200_mmc0_device,
+	&au1200_mmc1_device,
 #endif
 #ifdef SMBUS_PSC_BASE
 	&pbdb_smbus_device,
diff --git a/arch/mips/au1000/pb1200/platform.c b/arch/mips/au1000/pb1200/platform.c
index 5930110..f329a38 100644
--- a/arch/mips/au1000/pb1200/platform.c
+++ b/arch/mips/au1000/pb1200/platform.c
@@ -22,6 +22,66 @@
 #include <linux/platform_device.h>
 
 #include <asm/mach-au1x00/au1xxx.h>
+#include <asm/mach-au1x00/au1100_mmc.h>
+
+static void pb1200mmc0_set_power(void *mmc_host, int state)
+{
+	if (state)
+		bcsr->board |= BCSR_BOARD_SD0PWR;
+	else
+		bcsr->board &= ~BCSR_BOARD_SD0PWR;
+
+	au_sync_delay(1);
+}
+
+static int pb1200mmc0_card_readonly(void *mmc_host)
+{
+	return (bcsr->status & BCSR_STATUS_SD0WP) ? 1 : 0;
+}
+
+static int pb1200mmc0_card_inserted(void *mmc_host)
+{
+	return (bcsr->sig_status & BCSR_INT_SD0INSERT) ? 1 : 0;
+}
+
+#ifndef CONFIG_MIPS_DB1200
+static void pb1200mmc1_set_power(void *mmc_host, int state)
+{
+	if (state)
+		bcsr->board |= BCSR_BOARD_SD1PWR;
+	else
+		bcsr->board &= ~BCSR_BOARD_SD1PWR;
+
+	au_sync_delay(1);
+}
+
+static int pb1200mmc1_card_readonly(void *mmc_host)
+{
+	return (bcsr->status & BCSR_STATUS_SD1WP) ? 1 : 0;
+}
+
+static int pb1200mmc1_card_inserted(void *mmc_host)
+{
+	return (bcsr->sig_status & BCSR_INT_SD1INSERT) ? 1 : 0;
+}
+#endif
+
+const struct au1xmmc_platform_data au1xmmc_platdata[2] = {
+	[0] = {
+		.set_power	= pb1200mmc0_set_power,
+		.card_inserted	= pb1200mmc0_card_inserted,
+		.card_readonly	= pb1200mmc0_card_readonly,
+		.cd_setup	= NULL,		/* use poll-timer in driver */
+	},
+#ifndef CONFIG_MIPS_DB1200
+	[1] = {
+		.set_power	= pb1200mmc1_set_power,
+		.card_inserted	= pb1200mmc1_card_inserted,
+		.card_readonly	= pb1200mmc1_card_readonly,
+		.cd_setup	= NULL,		/* use poll-timer in driver */
+	},
+#endif
+};
 
 static struct resource ide_resources[] = {
 	[0] = {
-- 
1.5.5.1
