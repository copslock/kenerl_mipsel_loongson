Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Aug 2008 18:51:37 +0100 (BST)
Received: from fnoeppeil43.netpark.at ([217.175.205.171]:53187 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20022964AbYHERva (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 5 Aug 2008 18:51:30 +0100
Received: (qmail 29767 invoked by uid 1000); 5 Aug 2008 19:51:26 +0200
Date:	Tue, 5 Aug 2008 19:51:26 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: [PATCH] Alchemy: register mmc platform device for db1200/pb1200
	boards
Message-ID: <20080805175126.GA29618@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20115
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hi Ralf, 

Please apply this patch, it is the last missing piece of the au1xmmc
updates, which lets db1200/pb1200 use MMC/SD cards.

Tested on DB1200.

Thanks!
	Manuel Lauss

--- 

Add au1xmmc platform data for PB1200/DB1200 boards, and wire up
the 2 SD controllers for them.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/au1000/common/platform.c |   98 +++++++++++++++++++++++++++---------
 arch/mips/au1000/pb1200/platform.c |   81 +++++++++++++++++++++++++++++
 2 files changed, 155 insertions(+), 24 deletions(-)

diff --git a/arch/mips/au1000/common/platform.c b/arch/mips/au1000/common/platform.c
index dc8a67e..5c76c64 100644
--- a/arch/mips/au1000/common/platform.c
+++ b/arch/mips/au1000/common/platform.c
@@ -17,6 +17,8 @@
 #include <linux/init.h>
 
 #include <asm/mach-au1x00/au1xxx.h>
+#include <asm/mach-au1x00/au1xxx_dbdma.h>
+#include <asm/mach-au1x00/au1100_mmc.h>
 
 #define PORT(_base, _irq)				\
 	{						\
@@ -163,24 +165,6 @@ static struct resource au1xxx_usb_gdt_resources[] = {
 	},
 };
 
-static struct resource au1xxx_mmc_resources[] = {
-	[0] = {
-		.start          = SD0_PHYS_ADDR,
-		.end            = SD0_PHYS_ADDR + 0x7ffff,
-		.flags          = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start		= SD1_PHYS_ADDR,
-		.end 		= SD1_PHYS_ADDR + 0x7ffff,
-		.flags		= IORESOURCE_MEM,
-	},
-	[2] = {
-		.start          = AU1200_SD_INT,
-		.end            = AU1200_SD_INT,
-		.flags          = IORESOURCE_IRQ,
-	}
-};
-
 static u64 udc_dmamask = DMA_32BIT_MASK;
 
 static struct platform_device au1xxx_usb_gdt_device = {
@@ -249,16 +233,79 @@ static struct platform_device au1200_lcd_device = {
 
 static u64 au1xxx_mmc_dmamask =  DMA_32BIT_MASK;
 
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
+static struct platform_device au1200_mmc0_device = {
 	.name = "au1xxx-mmc",
 	.id = 0,
 	.dev = {
-		.dma_mask               = &au1xxx_mmc_dmamask,
-		.coherent_dma_mask      = DMA_32BIT_MASK,
+		.dma_mask		= &au1xxx_mmc_dmamask,
+		.coherent_dma_mask	= DMA_32BIT_MASK,
+		.platform_data		= &au1xmmc_platdata[0],
 	},
-	.num_resources  = ARRAY_SIZE(au1xxx_mmc_resources),
-	.resource       = au1xxx_mmc_resources,
+	.num_resources	= ARRAY_SIZE(au1200_mmc0_resources),
+	.resource	= au1200_mmc0_resources,
 };
+
+#ifndef CONFIG_MIPS_DB1200
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
+static struct platform_device au1200_mmc1_device = {
+	.name = "au1xxx-mmc",
+	.id = 1,
+	.dev = {
+		.dma_mask		= &au1xxx_mmc_dmamask,
+		.coherent_dma_mask	= DMA_32BIT_MASK,
+		.platform_data		= &au1xmmc_platdata[1],
+	},
+	.num_resources	= ARRAY_SIZE(au1200_mmc1_resources),
+	.resource	= au1200_mmc1_resources,
+};
+#endif /* #ifndef CONFIG_MIPS_DB1200 */
 #endif /* #ifdef CONFIG_SOC_AU1200 */
 
 static struct platform_device au1x00_pcmcia_device = {
@@ -296,7 +343,10 @@ static struct platform_device *au1xxx_platform_devices[] __initdata = {
 	&au1xxx_usb_gdt_device,
 	&au1xxx_usb_otg_device,
 	&au1200_lcd_device,
-	&au1xxx_mmc_device,
+	&au1200_mmc0_device,
+#ifndef CONFIG_MIPS_DB1200
+	&au1200_mmc1_device,
+#endif
 #endif
 #ifdef SMBUS_PSC_BASE
 	&pbdb_smbus_device,
diff --git a/arch/mips/au1000/pb1200/platform.c b/arch/mips/au1000/pb1200/platform.c
index f8fb0ae..9530329 100644
--- a/arch/mips/au1000/pb1200/platform.c
+++ b/arch/mips/au1000/pb1200/platform.c
@@ -20,9 +20,90 @@
 
 #include <linux/dma-mapping.h>
 #include <linux/init.h>
+#include <linux/leds.h>
 #include <linux/platform_device.h>
 
 #include <asm/mach-au1x00/au1xxx.h>
+#include <asm/mach-au1x00/au1100_mmc.h>
+
+static int mmc_activity;
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
+static void pb1200_mmcled_set(struct led_classdev *led,
+			enum led_brightness brightness)
+{
+	if (brightness != LED_OFF) {
+		if (++mmc_activity == 1)
+			bcsr->disk_leds &= ~(1 << 8);
+	} else {
+		if (--mmc_activity == 0)
+			bcsr->disk_leds |= (1 << 8);
+	}
+}
+
+static struct led_classdev pb1200mmc_led = {
+	.brightness_set	= pb1200_mmcled_set,
+};
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
+		.led		= &pb1200mmc_led,
+	},
+#ifndef CONFIG_MIPS_DB1200
+	[1] = {
+		.set_power	= pb1200mmc1_set_power,
+		.card_inserted	= pb1200mmc1_card_inserted,
+		.card_readonly	= pb1200mmc1_card_readonly,
+		.cd_setup	= NULL,		/* use poll-timer in driver */
+		.led		= &pb1200mmc_led,
+	},
+#endif
+};
 
 static struct resource ide_resources[] = {
 	[0] = {
-- 
1.5.6.4
