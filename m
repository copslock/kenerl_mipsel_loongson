From: Manuel Lauss <mano@scarran.local>
Date: Tue, 6 May 2008 20:03:24 +0200
Subject: [PATCH] au1xmmc updates
Message-ID: <20080506180324.a0A0k3lUyYmyFNZIa2sKwmReh92hVmKAjIS9DM77dew@z>

- export get_au1x00_speed() for modules
- move DB/PB1200 specific functions out of the driver to the board code,
  wrap them in a structure and pass them to the driver via platform_data.
- code style changes
- hook up the SDIO irq
---
 arch/mips/au1000/common/clocks.c          |    2 +-
 arch/mips/au1000/common/platform.c        |   32 --
 arch/mips/au1000/pb1200/platform.c        |  127 +++++++-
 drivers/mmc/host/au1xmmc.c                |  573 +++++++++++++++++------------
 drivers/mmc/host/au1xmmc.h                |   96 -----
 include/asm-mips/mach-au1x00/au1100_mmc.h |   43 ++-
 6 files changed, 501 insertions(+), 372 deletions(-)
 delete mode 100644 drivers/mmc/host/au1xmmc.h

diff --git a/arch/mips/au1000/common/clocks.c b/arch/mips/au1000/common/clocks.c
index 3ce6cac..6dbc87a 100644
--- a/arch/mips/au1000/common/clocks.c
+++ b/arch/mips/au1000/common/clocks.c
@@ -46,7 +46,7 @@ unsigned int get_au1x00_speed(void)
 {
 	return au1x00_clock;
 }
-
+EXPORT_SYMBOL(get_au1x00_speed);
 
 
 /*
diff --git a/arch/mips/au1000/common/platform.c b/arch/mips/au1000/common/platform.c
index 31d2a22..08a5900 100644
--- a/arch/mips/au1000/common/platform.c
+++ b/arch/mips/au1000/common/platform.c
@@ -162,24 +162,6 @@ static struct resource au1xxx_usb_gdt_resources[] = {
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
@@ -245,19 +227,6 @@ static struct platform_device au1200_lcd_device = {
 	.num_resources  = ARRAY_SIZE(au1200_lcd_resources),
 	.resource       = au1200_lcd_resources,
 };
-
-static u64 au1xxx_mmc_dmamask =  ~(u32)0;
-
-static struct platform_device au1xxx_mmc_device = {
-	.name = "au1xxx-mmc",
-	.id = 0,
-	.dev = {
-		.dma_mask               = &au1xxx_mmc_dmamask,
-		.coherent_dma_mask      = 0xffffffff,
-	},
-	.num_resources  = ARRAY_SIZE(au1xxx_mmc_resources),
-	.resource       = au1xxx_mmc_resources,
-};
 #endif /* #ifdef CONFIG_SOC_AU1200 */
 
 static struct platform_device au1x00_pcmcia_device = {
@@ -295,7 +264,6 @@ static struct platform_device *au1xxx_platform_devices[] __initdata = {
 	&au1xxx_usb_gdt_device,
 	&au1xxx_usb_otg_device,
 	&au1200_lcd_device,
-	&au1xxx_mmc_device,
 #endif
 #ifdef SMBUS_PSC_BASE
 	&pbdb_smbus_device,
diff --git a/arch/mips/au1000/pb1200/platform.c b/arch/mips/au1000/pb1200/platform.c
index 5930110..bee2bf7 100644
--- a/arch/mips/au1000/pb1200/platform.c
+++ b/arch/mips/au1000/pb1200/platform.c
@@ -20,8 +20,17 @@
 
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/mmc/host.h>
 
 #include <asm/mach-au1x00/au1xxx.h>
+#include <asm/mach-au1x00/au1xxx_dbdma.h>
+#include <asm/mach-au1x00/au1100_mmc.h>
+
+#if defined(CONFIG_MIPS_PB1200)
+#include <asm/mach-pb1x00/pb1200.h>
+#elif defined(CONFIG_MIPS_DB1200)
+#include <asm/mach-db1x00/db1200.h>
+#endif
 
 static struct resource ide_resources[] = {
 	[0] = {
@@ -70,9 +79,125 @@ static struct platform_device smc91c111_device = {
 	.resource	= smc91c111_resources
 };
 
+
+static const struct {
+	u16 bcsrpwr;
+	u16 bcsrstatus;
+	u16 wpstatus;
+} au1xmmc_card_table[] = {
+	{ BCSR_BOARD_SD0PWR, BCSR_INT_SD0INSERT, BCSR_STATUS_SD0WP },
+#ifndef CONFIG_MIPS_DB1200
+	{ BCSR_BOARD_SD1PWR, BCSR_INT_SD1INSERT, BCSR_STATUS_SD1WP }
+#endif
+};
+
+static void pb1200mmc_set_power(void *mmc_host, int state)
+{
+	struct au1xmmc_host *host = mmc_priv((struct mmc_host *)mmc_host);
+	u32 val = au1xmmc_card_table[host->id].bcsrpwr;
+
+	bcsr->board &= ~val;
+	if (state)
+		bcsr->board |= val;
+
+	au_sync_delay(1);
+}
+
+static int pb1200mmc_card_readonly(void *mmc_host)
+{
+	struct au1xmmc_host *host = mmc_priv((struct mmc_host *)mmc_host);
+	return (bcsr->status & au1xmmc_card_table[host->id].wpstatus) ? 1 : 0;
+}
+
+static int pb1200mmc_card_inserted(void *mmc_host)
+{
+	struct au1xmmc_host *host = mmc_priv((struct mmc_host *)mmc_host);
+	return (bcsr->sig_status & au1xmmc_card_table[host->id].bcsrstatus)
+		? 1 : 0;
+}
+
+static struct au1xmmc_platdata db1xmmcpd = {
+	.set_power	= pb1200mmc_set_power,
+	.card_inserted	= pb1200mmc_card_inserted,
+	.card_readonly	= pb1200mmc_card_readonly,
+	.cd_setup	= NULL,		/* use poll-timer in driver */
+};
+
+static u64 au1xxx_mmc_dmamask =  ~(u32)0;
+
+struct resource au1200sd0_res[] = {
+	[0] = {
+		.start	= CPHYSADDR(SD0_BASE),
+		.end	= CPHYSADDR(SD0_BASE) + 0x40,
+		.flags	= IORESOURCE_MEM,
+	},
+	[2] = {
+		.start	= AU1200_SD_INT,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[3] = {
+		.start	= DSCR_CMD0_SDMS_TX0,
+		.flags	= IORESOURCE_DMA,
+	},
+	[4] = {
+		.start	= DSCR_CMD0_SDMS_RX0,
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+static struct platform_device au1xxx_sd0_device = {
+	.name = "au1xxx-mmc",
+	.id = 0,	/* index into au1xmmc_card_table[] */
+	.dev = {
+		.dma_mask               = &au1xxx_mmc_dmamask,
+		.coherent_dma_mask      = 0xffffffff,
+		.platform_data		= &db1xmmcpd,
+	},
+	.num_resources  = ARRAY_SIZE(au1200sd0_res),
+	.resource       = au1200sd0_res,
+};
+
+#ifndef CONFIG_MIPS_DB1200
+struct resource au1200sd1_res[] = {
+	[0] = {
+		.start	= CPHYSADDR(SD1_BASE),
+		.end	= CPHYSADDR(SD1_BASE) + 0xff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[2] = {
+		.start	= AU1200_SD_INT,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[3] = {
+		.start	= DSCR_CMD0_SDMS_TX1,
+		.flags	= IORESOURCE_DMA,
+	},
+	[4] = {
+		.start	= DSCR_CMD0_SDMS_RX1,
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+static struct platform_device au1xxx_sd1_device = {
+	.name = "au1xxx-mmc",
+	.id = 1,	/* index into au1xmmc_card_table[] */
+	.dev = {
+		.dma_mask               = &au1xxx_mmc_dmamask,
+		.coherent_dma_mask      = 0xffffffff,
+		.platform_data		= &db1xmmcpd,
+	},
+	.num_resources  = ARRAY_SIZE(au1200sd1_res),
+	.resource       = au1200sd1_res,
+};
+#endif
+
 static struct platform_device *board_platform_devices[] __initdata = {
 	&ide_device,
-	&smc91c111_device
+	&smc91c111_device,
+	&au1xxx_sd0_device,
+#ifndef CONFIG_MIPS_DB1200
+	&au1xxx_sd1_device,
+#endif
 };
 
 static int __init board_register_devices(void)
diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
index cc5f7bc..da62bd2 100644
--- a/drivers/mmc/host/au1xmmc.c
+++ b/drivers/mmc/host/au1xmmc.c
@@ -49,7 +49,6 @@
 #include <asm/mach-au1x00/au1100_mmc.h>
 
 #include <au1xxx.h>
-#include "au1xmmc.h"
 
 #define DRIVER_NAME "au1xxx-mmc"
 
@@ -61,31 +60,71 @@
 #define DBG(fmt, idx, args...)
 #endif
 
-const struct {
-	u32 iobase;
-	u32 tx_devid, rx_devid;
-	u16 bcsrpwr;
-	u16 bcsrstatus;
-	u16 wpstatus;
-} au1xmmc_card_table[] = {
-	{ SD0_BASE, DSCR_CMD0_SDMS_TX0, DSCR_CMD0_SDMS_RX0,
-	  BCSR_BOARD_SD0PWR, BCSR_INT_SD0INSERT, BCSR_STATUS_SD0WP },
-#ifndef CONFIG_MIPS_DB1200
-	{ SD1_BASE, DSCR_CMD0_SDMS_TX1, DSCR_CMD0_SDMS_RX1,
-	  BCSR_BOARD_DS1PWR, BCSR_INT_SD1INSERT, BCSR_STATUS_SD1WP }
+#define AU1XMMC_DESCRIPTOR_COUNT 1
+#define AU1XMMC_DESCRIPTOR_SIZE  2048
+
+#define AU1XMMC_OCR ( MMC_VDD_27_28 | MMC_VDD_28_29 | MMC_VDD_29_30  | \
+		      MMC_VDD_30_31 | MMC_VDD_31_32 | MMC_VDD_32_33  | \
+		      MMC_VDD_33_34 | MMC_VDD_34_35 | MMC_VDD_35_36)
+
+/* Easy access macros */
+
+#define HOST_STATUS(h)	((h)->iobase + SD_STATUS)
+#define HOST_CONFIG(h)	((h)->iobase + SD_CONFIG)
+#define HOST_ENABLE(h)	((h)->iobase + SD_ENABLE)
+#define HOST_TXPORT(h)	((h)->iobase + SD_TXPORT)
+#define HOST_RXPORT(h)	((h)->iobase + SD_RXPORT)
+#define HOST_CMDARG(h)	((h)->iobase + SD_CMDARG)
+#define HOST_BLKSIZE(h)	((h)->iobase + SD_BLKSIZE)
+#define HOST_CMD(h)	((h)->iobase + SD_CMD)
+#define HOST_CONFIG2(h)	((h)->iobase + SD_CONFIG2)
+#define HOST_TIMEOUT(h)	((h)->iobase + SD_TIMEOUT)
+#define HOST_DEBUG(h)	((h)->iobase + SD_DEBUG)
+
+#define DMA_CHANNEL(h) \
+	( ((h)->flags & HOST_F_XMIT) ? (h)->dma.tx_chan : (h)->dma.rx_chan)
+
+/* This gives us a hard value for the stop command that we can write directly
+ * to the command register
+ */
+
+#define STOP_CMD (SD_CMD_RT_1B|SD_CMD_CT_7|(0xC << SD_CMD_CI_SHIFT)|SD_CMD_GO)
+
+/* This is the set of interrupts that we configure by default */
+
+#if 0
+#define AU1XMMC_INTERRUPTS (SD_CONFIG_SC | SD_CONFIG_DT | SD_CONFIG_DD | \
+		SD_CONFIG_RAT | SD_CONFIG_CR | SD_CONFIG_I)
 #endif
-};
 
-#define AU1XMMC_CONTROLLER_COUNT (ARRAY_SIZE(au1xmmc_card_table))
+#define AU1XMMC_INTERRUPTS (SD_CONFIG_SC | SD_CONFIG_DT | \
+		SD_CONFIG_RAT | SD_CONFIG_CR | SD_CONFIG_I)
+/* The poll event (looking for insert/remove events runs twice a second */
+#define AU1XMMC_DETECT_TIMEOUT (HZ/2)
+
+/* Status flags used by the host structure */
+#define HOST_F_XMIT   0x0001
+#define HOST_F_RECV   0x0002
+#define HOST_F_DMA    0x0010
+#define HOST_F_ACTIVE 0x0100
+#define HOST_F_STOP   0x1000
+
+#define HOST_S_IDLE   0x0001
+#define HOST_S_CMD    0x0002
+#define HOST_S_DATA   0x0003
+#define HOST_S_STOP   0x0004
 
-/* This array stores pointers for the hosts (used by the IRQ handler) */
-struct au1xmmc_host *au1xmmc_hosts[AU1XMMC_CONTROLLER_COUNT];
 static int dma = 1;
 
-#ifdef MODULE
 module_param(dma, bool, 0);
 MODULE_PARM_DESC(dma, "Use DMA engine for data transfers (0 = disabled)");
-#endif
+
+/* 8bit memory device */
+static dbdev_tab_t au1xmmc_mem_dbdev = {
+	DSCR_CMD0_ALWAYS, DEV_FLAGS_ANYUSE, 0, 8, 0x00000000, 0, 0
+};
+static int memid = 0;
+
 
 static inline void IRQ_ON(struct au1xmmc_host *host, u32 mask)
 {
@@ -119,14 +158,13 @@ static inline void IRQ_OFF(struct au1xmmc_host *host, u32 mask)
 
 static inline void SEND_STOP(struct au1xmmc_host *host)
 {
-
-	/* We know the value of CONFIG2, so avoid a read we don't need */
-	u32 mask = SD_CONFIG2_EN;
+	u32 config2;
 
 	WARN_ON(host->status != HOST_S_DATA);
 	host->status = HOST_S_STOP;
 
-	au_writel(mask | SD_CONFIG2_DF, HOST_CONFIG2(host));
+	config2 = au_readl(HOST_CONFIG2(host));
+	au_writel(config2 | SD_CONFIG2_DF, HOST_CONFIG2(host));
 	au_sync();
 
 	/* Send the stop commmand */
@@ -135,31 +173,37 @@ static inline void SEND_STOP(struct au1xmmc_host *host)
 
 static void au1xmmc_set_power(struct au1xmmc_host *host, int state)
 {
-
-	u32 val = au1xmmc_card_table[host->id].bcsrpwr;
-
-	bcsr->board &= ~val;
-	if (state) bcsr->board |= val;
-
-	au_sync_delay(1);
+	if (host->platdata && host->platdata->set_power)
+		host->platdata->set_power(host->mmc, state);
 }
 
-static inline int au1xmmc_card_inserted(struct au1xmmc_host *host)
+static int au1xmmc_card_inserted(struct au1xmmc_host *host)
 {
-	return (bcsr->sig_status & au1xmmc_card_table[host->id].bcsrstatus)
-		? 1 : 0;
+	int ret;
+
+	if (host->platdata && host->platdata->card_inserted)
+		ret = host->platdata->card_readonly(host->mmc);
+	else
+		ret = 1;	/* assume there is a card */
+
+	return ret;
 }
 
 static int au1xmmc_card_readonly(struct mmc_host *mmc)
 {
 	struct au1xmmc_host *host = mmc_priv(mmc);
-	return (bcsr->status & au1xmmc_card_table[host->id].wpstatus)
-		? 1 : 0;
+	int ret;
+
+	if (host->platdata && host->platdata->card_readonly)
+		ret = host->platdata->card_readonly(mmc);
+	else
+		ret = 1;	/* assume card is read-only */
+
+	return ret;
 }
 
 static void au1xmmc_finish_request(struct au1xmmc_host *host)
 {
-
 	struct mmc_request *mrq = host->mrq;
 
 	host->mrq = NULL;
@@ -174,14 +218,12 @@ static void au1xmmc_finish_request(struct au1xmmc_host *host)
 
 	host->status = HOST_S_IDLE;
 
-	bcsr->disk_leds |= (1 << 8);
-
 	mmc_request_done(host->mmc, mrq);
 }
 
 static void au1xmmc_tasklet_finish(unsigned long param)
 {
-	struct au1xmmc_host *host = (struct au1xmmc_host *) param;
+	struct au1xmmc_host *host = (struct au1xmmc_host *)param;
 	au1xmmc_finish_request(host);
 }
 
@@ -235,18 +277,16 @@ static int au1xmmc_send_command(struct au1xmmc_host *host, int wait,
 	au_sync();
 
 	/* Wait for the command to go on the line */
-
-	while(1) {
+	while (1) {
 		if (!(au_readl(HOST_CMD(host)) & SD_CMD_GO))
 			break;
 	}
 
 	/* Wait for the command to come back */
-
 	if (wait) {
 		u32 status = au_readl(HOST_STATUS(host));
 
-		while(!(status & SD_STATUS_CR))
+		while (!(status & SD_STATUS_CR))
 			status = au_readl(HOST_STATUS(host));
 
 		/* Clear the CR status */
@@ -260,7 +300,6 @@ static int au1xmmc_send_command(struct au1xmmc_host *host, int wait,
 
 static void au1xmmc_data_complete(struct au1xmmc_host *host, u32 status)
 {
-
 	struct mmc_request *mrq = host->mrq;
 	struct mmc_data *data;
 	u32 crc;
@@ -276,15 +315,13 @@ static void au1xmmc_data_complete(struct au1xmmc_host *host, u32 status)
 		status = au_readl(HOST_STATUS(host));
 
 	/* The transaction is really over when the SD_STATUS_DB bit is clear */
-
-	while((host->flags & HOST_F_XMIT) && (status & SD_STATUS_DB))
+	while ((host->flags & HOST_F_XMIT) && (status & SD_STATUS_DB))
 		status = au_readl(HOST_STATUS(host));
 
 	data->error = 0;
 	dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len, host->dma.dir);
 
         /* Process any errors */
-
 	crc = (status & (SD_STATUS_WC | SD_STATUS_RC));
 	if (host->flags & HOST_F_XMIT)
 		crc |= ((status & 0x07) == 0x02) ? 0 : 1;
@@ -304,8 +341,7 @@ static void au1xmmc_data_complete(struct au1xmmc_host *host, u32 status)
 			chan_tab_t *c = *((chan_tab_t **) chan);
 			au1x_dma_chan_t *cp = c->chan_ptr;
 			data->bytes_xfered = cp->ddma_bytecnt;
-		}
-		else
+		} else
 			data->bytes_xfered =
 				(data->blocks * data->blksz) -
 				host->pio.len;
@@ -326,10 +362,9 @@ static void au1xmmc_tasklet_data(unsigned long param)
 
 static void au1xmmc_send_pio(struct au1xmmc_host *host)
 {
-
 	struct mmc_data *data = 0;
 	int sg_len, max, count = 0;
-	unsigned char *sg_ptr;
+	unsigned char *sg_ptr, val;
 	u32 status = 0;
 	struct scatterlist *sg;
 
@@ -350,11 +385,8 @@ static void au1xmmc_send_pio(struct au1xmmc_host *host)
 	max = (sg_len > host->pio.len) ? host->pio.len : sg_len;
 	if (max > AU1XMMC_MAX_TRANSFER) max = AU1XMMC_MAX_TRANSFER;
 
-	for(count = 0; count < max; count++ ) {
-		unsigned char val;
-
+	for (count = 0; count < max; count++ ) {
 		status = au_readl(HOST_STATUS(host));
-
 		if (!(status & SD_STATUS_TH))
 			break;
 
@@ -384,7 +416,6 @@ static void au1xmmc_send_pio(struct au1xmmc_host *host)
 
 static void au1xmmc_receive_pio(struct au1xmmc_host *host)
 {
-
 	struct mmc_data *data = 0;
 	int sg_len = 0, max = 0, count = 0;
 	unsigned char *sg_ptr = 0;
@@ -412,7 +443,7 @@ static void au1xmmc_receive_pio(struct au1xmmc_host *host)
 	if (max > AU1XMMC_MAX_TRANSFER)
 		max = AU1XMMC_MAX_TRANSFER;
 
-	for(count = 0; count < max; count++ ) {
+	for (count = 0; count < max; count++ ) {
 		u32 val;
 		status = au_readl(HOST_STATUS(host));
 
@@ -468,7 +499,6 @@ static void au1xmmc_receive_pio(struct au1xmmc_host *host)
 
 static void au1xmmc_cmd_complete(struct au1xmmc_host *host, u32 status)
 {
-
 	struct mmc_request *mrq = host->mrq;
 	struct mmc_command *cmd;
 	int trans;
@@ -493,7 +523,6 @@ static void au1xmmc_cmd_complete(struct au1xmmc_host *host, u32 status)
 			 * we only got 120 bytes, but the engine expects
 			 * 128 bits, so we have to shift things up
 			 */
-
 			for(i = 0; i < 4; i++) {
 				cmd->resp[i] = (r[i] & 0x00FFFFFF) << 8;
 				if (i != 3)
@@ -512,14 +541,12 @@ static void au1xmmc_cmd_complete(struct au1xmmc_host *host, u32 status)
 	}
 
         /* Figure out errors */
-
 	if (status & (SD_STATUS_SC | SD_STATUS_WC | SD_STATUS_RC))
 		cmd->error = -EILSEQ;
 
 	trans = host->flags & (HOST_F_XMIT | HOST_F_RECV);
 
 	if (!trans || cmd->error) {
-
 		IRQ_OFF(host, SD_CONFIG_TH | SD_CONFIG_RA|SD_CONFIG_RF);
 		tasklet_schedule(&host->finish_task);
 		return;
@@ -531,21 +558,18 @@ static void au1xmmc_cmd_complete(struct au1xmmc_host *host, u32 status)
 		u32 channel = DMA_CHANNEL(host);
 
 		/* Start the DMA as soon as the buffer gets something in it */
-
 		if (host->flags & HOST_F_RECV) {
 			u32 mask = SD_STATUS_DB | SD_STATUS_NE;
 
-			while((status & mask) != mask)
+			while ((status & mask) != mask)
 				status = au_readl(HOST_STATUS(host));
 		}
-
 		au1xxx_dbdma_start(channel);
 	}
 }
 
 static void au1xmmc_set_clock(struct au1xmmc_host *host, int rate)
 {
-
 	unsigned int pbus = get_au1x00_speed();
 	unsigned int divisor;
 	u32 config;
@@ -571,7 +595,6 @@ static void au1xmmc_set_clock(struct au1xmmc_host *host, int rate)
 static int
 au1xmmc_prepare_data(struct au1xmmc_host *host, struct mmc_data *data)
 {
-
 	int datalen = data->blocks * data->blksz;
 
 	if (dma != 0)
@@ -646,10 +669,6 @@ au1xmmc_prepare_data(struct au1xmmc_host *host, struct mmc_data *data)
 	return -ETIMEDOUT;
 }
 
-/* static void au1xmmc_request
-   This actually starts a command or data transaction
-*/
-
 static void au1xmmc_request(struct mmc_host* mmc, struct mmc_request* mrq)
 {
 
@@ -663,8 +682,6 @@ static void au1xmmc_request(struct mmc_host* mmc, struct mmc_request* mrq)
 	host->mrq = mrq;
 	host->status = HOST_S_CMD;
 
-	bcsr->disk_leds &= ~(1 << 8);
-
 	if (mrq->data) {
 		FLUSH_FIFO(host);
 		flags = mrq->data->flags;
@@ -682,7 +699,6 @@ static void au1xmmc_request(struct mmc_host* mmc, struct mmc_request* mrq)
 
 static void au1xmmc_reset_controller(struct au1xmmc_host *host)
 {
-
 	/* Apply the clock */
 	au_writel(SD_ENABLE_CE, HOST_ENABLE(host));
         au_sync_delay(1);
@@ -711,10 +727,10 @@ static void au1xmmc_reset_controller(struct au1xmmc_host *host)
 	au_sync();
 }
 
-
-static void au1xmmc_set_ios(struct mmc_host* mmc, struct mmc_ios* ios)
+static void au1xmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct au1xmmc_host *host = mmc_priv(mmc);
+	u32 config;
 
 	if (ios->power_mode == MMC_POWER_OFF)
 		au1xmmc_set_power(host, 0);
@@ -726,14 +742,25 @@ static void au1xmmc_set_ios(struct mmc_host* mmc, struct mmc_ios* ios)
 		au1xmmc_set_clock(host, ios->clock);
 		host->clock = ios->clock;
 	}
+
+	config = au_readl(HOST_CONFIG2(host));
+	switch (ios->bus_width) {
+	case MMC_BUS_WIDTH_4:
+		config |= (1 << 8);
+		break;
+	case MMC_BUS_WIDTH_1:
+		config &= ~(1 << 8);
+		break;
+	}
+	au_writel(config, HOST_CONFIG2(host));
+	au_sync();
 }
 
 static void au1xmmc_dma_callback(int irq, void *dev_id)
 {
-	struct au1xmmc_host *host = (struct au1xmmc_host *) dev_id;
+	struct au1xmmc_host *host = (struct au1xmmc_host *)dev_id;
 
 	/* Avoid spurious interrupts */
-
 	if (!host->mrq)
 		return;
 
@@ -749,118 +776,90 @@ static void au1xmmc_dma_callback(int irq, void *dev_id)
 
 static irqreturn_t au1xmmc_irq(int irq, void *dev_id)
 {
-
+	struct au1xmmc_host *host = dev_id;
 	u32 status;
-	int i, ret = 0;
 
-	disable_irq(AU1100_SD_IRQ);
+	status = au_readl(HOST_STATUS(host));
 
-	for(i = 0; i < AU1XMMC_CONTROLLER_COUNT; i++) {
-		struct au1xmmc_host * host = au1xmmc_hosts[i];
-		u32 handled = 1;
+	if (!(status & (1<<15)))
+		return IRQ_NONE;	/* not ours */
 
-		status = au_readl(HOST_STATUS(host));
-
-		if (host->mrq && (status & STATUS_TIMEOUT)) {
-			if (status & SD_STATUS_RAT)
-				host->mrq->cmd->error = -ETIMEDOUT;
-
-			else if (status & SD_STATUS_DT)
-				host->mrq->data->error = -ETIMEDOUT;
+	if (host->mrq && (status & STATUS_TIMEOUT)) {
+		if (status & SD_STATUS_RAT)
+			host->mrq->cmd->error = -ETIMEDOUT;
+		else if (status & SD_STATUS_DT)
+			host->mrq->data->error = -ETIMEDOUT;
 
-			/* In PIO mode, interrupts might still be enabled */
-			IRQ_OFF(host, SD_CONFIG_NE | SD_CONFIG_TH);
+		/* In PIO mode, interrupts might still be enabled */
+		IRQ_OFF(host, SD_CONFIG_NE | SD_CONFIG_TH);
 
-			//IRQ_OFF(host, SD_CONFIG_TH|SD_CONFIG_RA|SD_CONFIG_RF);
-			tasklet_schedule(&host->finish_task);
-		}
+		//IRQ_OFF(host, SD_CONFIG_TH|SD_CONFIG_RA|SD_CONFIG_RF);
+		tasklet_schedule(&host->finish_task);
+	}
 #if 0
-		else if (status & SD_STATUS_DD) {
-
-			/* Sometimes we get a DD before a NE in PIO mode */
-
-			if (!(host->flags & HOST_F_DMA) &&
-					(status & SD_STATUS_NE))
-				au1xmmc_receive_pio(host);
-			else {
-				au1xmmc_data_complete(host, status);
-				//tasklet_schedule(&host->data_task);
-			}
+	else if (status & SD_STATUS_DD) {
+		/* Sometimes we get a DD before a NE in PIO mode */
+		if (!(host->flags & HOST_F_DMA) && (status & SD_STATUS_NE))
+			au1xmmc_receive_pio(host);
+		else {
+			au1xmmc_data_complete(host, status);
+			//tasklet_schedule(&host->data_task);
 		}
+	}
 #endif
-		else if (status & (SD_STATUS_CR)) {
-			if (host->status == HOST_S_CMD)
-				au1xmmc_cmd_complete(host,status);
-		}
-		else if (!(host->flags & HOST_F_DMA)) {
-			if ((host->flags & HOST_F_XMIT) &&
-			    (status & STATUS_DATA_OUT))
-				au1xmmc_send_pio(host);
-			else if ((host->flags & HOST_F_RECV) &&
-			    (status & STATUS_DATA_IN))
-				au1xmmc_receive_pio(host);
-		}
-		else if (status & 0x203FBC70) {
-			DBG("Unhandled status %8.8x\n", host->id, status);
-			handled = 0;
-		}
-
-		au_writel(status, HOST_STATUS(host));
-		au_sync();
+	else if (status & (SD_STATUS_CR)) {
+		if (host->status == HOST_S_CMD)
+			au1xmmc_cmd_complete(host,status);
 
-		ret |= handled;
-	}
+	} else if (!(host->flags & HOST_F_DMA)) {
+		if ((host->flags & HOST_F_XMIT) && (status & STATUS_DATA_OUT))
+			au1xmmc_send_pio(host);
+		else if ((host->flags & HOST_F_RECV) && (status & STATUS_DATA_IN))
+			au1xmmc_receive_pio(host);
 
-	enable_irq(AU1100_SD_IRQ);
-	return ret;
-}
+	} else if (status & 0x80000000) {
+		mmc_signal_sdio_irq(host->mmc);
 
-static void au1xmmc_poll_event(unsigned long arg)
-{
-	struct au1xmmc_host *host = (struct au1xmmc_host *) arg;
-
-	int card = au1xmmc_card_inserted(host);
-        int controller = (host->flags & HOST_F_ACTIVE) ? 1 : 0;
-
-	if (card != controller) {
-		host->flags &= ~HOST_F_ACTIVE;
-		if (card) host->flags |= HOST_F_ACTIVE;
-		mmc_detect_change(host->mmc, 0);
+	} else if (status & 0x203FBC70) {
+			DBG("Unhandled status %8.8x\n", host->id, status);
 	}
 
-	if (host->mrq != NULL) {
-		u32 status = au_readl(HOST_STATUS(host));
-		DBG("PENDING - %8.8x\n", host->id, status);
-	}
+	au_writel(status, HOST_STATUS(host));
+	au_sync();
 
-	mod_timer(&host->timer, jiffies + AU1XMMC_DETECT_TIMEOUT);
+	return IRQ_HANDLED;
 }
 
-static dbdev_tab_t au1xmmc_mem_dbdev =
+static int au1xmmc_init_dma(struct au1xmmc_host *host)
 {
-	DSCR_CMD0_ALWAYS, DEV_FLAGS_ANYUSE, 0, 8, 0x00000000, 0, 0
-};
-
-static void au1xmmc_init_dma(struct au1xmmc_host *host)
-{
-
+	struct resource *res;
 	u32 rxchan, txchan;
+	int txid, rxid;
 
-	int txid = au1xmmc_card_table[host->id].tx_devid;
-	int rxid = au1xmmc_card_table[host->id].rx_devid;
+	res = platform_get_resource(host->pdev, IORESOURCE_DMA, 0);
+	if (!res)
+		return -ENODEV;
+	txid = res->start;
 
-	/* DSCR_CMD0_ALWAYS has a stride of 32 bits, we need a stride
-	   of 8 bits.  And since devices are shared, we need to create
-	   our own to avoid freaking out other devices
-	*/
-
-	int memid = au1xxx_ddma_add_device(&au1xmmc_mem_dbdev);
+	res = platform_get_resource(host->pdev, IORESOURCE_DMA, 1);
+	if (!res)
+		return -ENODEV;
+	rxid = res->start;
 
 	txchan = au1xxx_dbdma_chan_alloc(memid, txid,
-					 au1xmmc_dma_callback, (void *) host);
+				au1xmmc_dma_callback, (void *)host);
+	if (!txchan) {
+		dev_err(&host->pdev->dev, "cannot allocate TX DMA\n");
+		return -ENODEV;
+	}
 
 	rxchan = au1xxx_dbdma_chan_alloc(rxid, memid,
-					 au1xmmc_dma_callback, (void *) host);
+				au1xmmc_dma_callback, (void *)host);
+	if (!rxchan) {
+		dev_err(&host->pdev->dev, "cannot allocate RX DMA\n");
+		au1xxx_dbdma_chan_free(txchan);
+		return -ENODEV;
+	}
 
 	au1xxx_dbdma_set_devwidth(txchan, 8);
 	au1xxx_dbdma_set_devwidth(rxchan, 8);
@@ -868,126 +867,219 @@ static void au1xmmc_init_dma(struct au1xmmc_host *host)
 	au1xxx_dbdma_ring_alloc(txchan, AU1XMMC_DESCRIPTOR_COUNT);
 	au1xxx_dbdma_ring_alloc(rxchan, AU1XMMC_DESCRIPTOR_COUNT);
 
-	host->tx_chan = txchan;
-	host->rx_chan = rxchan;
+	host->dma.tx_chan = txchan;
+	host->dma.rx_chan = rxchan;
+
+	return 0;
+}
+
+static void au1xmmc_enable_sdio_irq(struct mmc_host *mmc, int en)
+{
+	struct au1xmmc_host *host = mmc_priv(mmc);
+
+	if (en)
+		IRQ_ON(host, (1<<31));
+	else
+		IRQ_OFF(host, (1<<31));
 }
 
 static const struct mmc_host_ops au1xmmc_ops = {
 	.request	= au1xmmc_request,
 	.set_ios	= au1xmmc_set_ios,
 	.get_ro		= au1xmmc_card_readonly,
+	.enable_sdio_irq= au1xmmc_enable_sdio_irq,
 };
 
-static int __devinit au1xmmc_probe(struct platform_device *pdev)
+static void au1xmmc_poll_event(unsigned long arg)
 {
+	struct au1xmmc_host *host = (struct au1xmmc_host *)arg;
+	u32 status;
 
-	int i, ret = 0;
+	int card = au1xmmc_card_inserted(host);
+        int controller = (host->flags & HOST_F_ACTIVE) ? 1 : 0;
 
-	/* THe interrupt is shared among all controllers */
-	ret = request_irq(AU1100_SD_IRQ, au1xmmc_irq, IRQF_DISABLED, "MMC", 0);
+	if (card != controller) {
+		host->flags &= ~HOST_F_ACTIVE;
+		if (card)
+			host->flags |= HOST_F_ACTIVE;
+		mmc_detect_change(host->mmc, 0);
+	}
 
-	if (ret) {
-		printk(DRIVER_NAME "ERROR: Couldn't get int %d: %d\n",
-				AU1100_SD_IRQ, ret);
-		return -ENXIO;
+	if (host->mrq != NULL) {
+		status = au_readl(HOST_STATUS(host));
+		DBG("PENDING - %8.8x\n", host->id, status);
 	}
 
-	disable_irq(AU1100_SD_IRQ);
+	mod_timer(&host->timer, jiffies + AU1XMMC_DETECT_TIMEOUT);
+}
 
-	for(i = 0; i < AU1XMMC_CONTROLLER_COUNT; i++) {
-		struct mmc_host *mmc = mmc_alloc_host(sizeof(struct au1xmmc_host), &pdev->dev);
-		struct au1xmmc_host *host = 0;
+static void au1xmmc_init_cd_poll_timer(struct au1xmmc_host *host)
+{
+	init_timer(&host->timer);
+	host->timer.function = au1xmmc_poll_event;
+	host->timer.data = (unsigned long)host;
+	host->timer.expires = jiffies + AU1XMMC_DETECT_TIMEOUT;
+	add_timer(&host->timer);
+}
 
-		if (!mmc) {
-			printk(DRIVER_NAME "ERROR: no mem for host %d\n", i);
-			au1xmmc_hosts[i] = 0;
-			continue;
-		}
+static int __devinit au1xmmc_probe(struct platform_device *pdev)
+{
+	struct mmc_host *mmc;
+	struct au1xmmc_host *host;
+	struct resource *r;
+	int ret;
+
+	mmc = mmc_alloc_host(sizeof(struct au1xmmc_host), &pdev->dev);
+	if (!mmc) {
+		dev_err(&pdev->dev, "no memory for mmc host\n");
+		ret = -ENOMEM;
+		goto out0;
+	}
 
-		mmc->ops = &au1xmmc_ops;
+	host = mmc_priv(mmc);
+	host->mmc = mmc;
+	host->platdata = pdev->dev.platform_data;
+	host->pdev = pdev;
 
-		mmc->f_min =   450000;
-		mmc->f_max = 24000000;
+	ret = -ENODEV;
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r) {
+		dev_err(&pdev->dev, "no mmio defined\n");
+		goto out1;
+	}
+	host->iobase = (unsigned long)ioremap(r->start, 0xff);
+	if (!host->iobase) {
+		dev_err(&pdev->dev, "cannot remap mmio\n");
+		goto out1;
+	}
 
-		mmc->max_seg_size = AU1XMMC_DESCRIPTOR_SIZE;
-		mmc->max_phys_segs = AU1XMMC_DESCRIPTOR_COUNT;
+	r = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!r) {
+		dev_err(&pdev->dev, "no IRQ defined\n");
+		goto out2;
+	}
 
-		mmc->max_blk_size = 2048;
-		mmc->max_blk_count = 512;
+	host->irq = r->start;
+	/* IRQ is shared among both SD controllers */
+	ret = request_irq(host->irq, au1xmmc_irq, IRQF_SHARED,
+			  DRIVER_NAME, host);
+	if (ret) {
+		dev_err(&pdev->dev, "cannot grab IRQ\n");
+		goto out2;
+	}
 
-		mmc->ocr_avail = AU1XMMC_OCR;
+	mmc->ops = &au1xmmc_ops;
 
-		host = mmc_priv(mmc);
-		host->mmc = mmc;
+	mmc->f_min =   450000;
+	mmc->f_max = 24000000;
 
-		host->id = i;
-		host->iobase = au1xmmc_card_table[host->id].iobase;
-		host->clock = 0;
-		host->power_mode = MMC_POWER_OFF;
+	mmc->max_seg_size = AU1XMMC_DESCRIPTOR_SIZE;
+	mmc->max_phys_segs = AU1XMMC_DESCRIPTOR_COUNT;
 
-		host->flags = au1xmmc_card_inserted(host) ? HOST_F_ACTIVE : 0;
-		host->status = HOST_S_IDLE;
+	mmc->max_blk_size = 2048;
+	mmc->max_blk_count = 512;
 
-		init_timer(&host->timer);
+	mmc->ocr_avail = AU1XMMC_OCR;
+	mmc->caps = MMC_CAP_SDIO_IRQ /* | MMC_CAP_4_BIT_DATA borked */;
 
-		host->timer.function = au1xmmc_poll_event;
-		host->timer.data = (unsigned long) host;
-		host->timer.expires = jiffies + AU1XMMC_DETECT_TIMEOUT;
+	host->clock = 0;
+	host->id = pdev->id;
+	host->status = HOST_S_IDLE;
 
-		tasklet_init(&host->data_task, au1xmmc_tasklet_data,
-				(unsigned long) host);
+	/* board-specific carddetect setup, if any */
+	if (host->platdata && host->platdata->cd_setup) {
+		ret = host->platdata->cd_setup(mmc, 1);
+		if (ret) {
+			dev_err(&pdev->dev, "board CD setup failed\n");
+			goto out3;
+		}
+	} else {
+		/* poll the board-specific card-is-in-socket method */
+		au1xmmc_init_cd_poll_timer(host);
+		host->flags = au1xmmc_card_inserted(host) ? HOST_F_ACTIVE : 0;
+	}
 
-		tasklet_init(&host->finish_task, au1xmmc_tasklet_finish,
-				(unsigned long) host);
+	tasklet_init(&host->data_task, au1xmmc_tasklet_data,
+			(unsigned long)host);
 
-		spin_lock_init(&host->lock);
+	tasklet_init(&host->finish_task, au1xmmc_tasklet_finish,
+			(unsigned long)host);
 
-		if (dma != 0)
-			au1xmmc_init_dma(host);
+	if (dma) {
+		ret = au1xmmc_init_dma(host);
+		if (ret)
+			goto out4;
+	}
 
-		au1xmmc_reset_controller(host);
+	au1xmmc_reset_controller(host);
 
-		mmc_add_host(mmc);
-		au1xmmc_hosts[i] = host;
+	ret = mmc_add_host(mmc);
+	if (ret) {
+		dev_err(&pdev->dev, "cannot add mmc host\n");
+		goto out5;
+	}
 
-		add_timer(&host->timer);
+	platform_set_drvdata(pdev, mmc);
 
-		printk(KERN_INFO DRIVER_NAME ": MMC Controller %d set up at %8.8X (mode=%s)\n",
-		       host->id, host->iobase, dma ? "dma" : "pio");
-	}
+	printk(KERN_INFO DRIVER_NAME ": MMC Controller %d set up at %8.8X (mode=%s)\n",
+		       pdev->id, host->iobase, dma ? "dma" : "pio");
 
-	enable_irq(AU1100_SD_IRQ);
+	return 0;	/* all ok */
 
-	return 0;
+out5:
+	if (dma) {
+		au1xxx_dbdma_chan_free(host->dma.tx_chan);
+		au1xxx_dbdma_chan_free(host->dma.rx_chan);
+	}
+out4:
+	tasklet_kill(&host->data_task);
+	tasklet_kill(&host->finish_task);
+
+	if (host->platdata && host->platdata->cd_setup)
+		host->platdata->cd_setup(mmc, 0);
+	else
+		del_timer_sync(&host->timer);
+out3:
+	free_irq(host->irq, host);
+out2:
+	iounmap((void *)host->iobase);
+out1:
+	mmc_free_host(mmc);
+out0:
+	return ret;
 }
 
 static int __devexit au1xmmc_remove(struct platform_device *pdev)
 {
+	struct mmc_host *mmc = platform_get_drvdata(pdev);
+	struct au1xmmc_host *host;
 
-	int i;
-
-	disable_irq(AU1100_SD_IRQ);
+	if (mmc) {
+		host  = mmc_priv(mmc);
 
-	for(i = 0; i < AU1XMMC_CONTROLLER_COUNT; i++) {
-		struct au1xmmc_host *host = au1xmmc_hosts[i];
-		if (!host) continue;
+		au_writel(0, HOST_ENABLE(host));
+		au_writel(0, HOST_CONFIG(host));
+		au_sync();
 
 		tasklet_kill(&host->data_task);
 		tasklet_kill(&host->finish_task);
 
-		del_timer_sync(&host->timer);
+		if (host->platdata && host->platdata->cd_setup)
+			host->platdata->cd_setup(mmc, 0);
+		else
+			del_timer_sync(&host->timer);
+
 		au1xmmc_set_power(host, 0);
 
-		mmc_remove_host(host->mmc);
+		free_irq(host->irq, host);
 
-		au1xxx_dbdma_chan_free(host->tx_chan);
-		au1xxx_dbdma_chan_free(host->rx_chan);
+		mmc_remove_host(host->mmc);
 
-		au_writel(0x0, HOST_ENABLE(host));
-		au_sync();
+		if (dma) {
+			au1xxx_dbdma_chan_free(host->dma.tx_chan);
+			au1xxx_dbdma_chan_free(host->dma.rx_chan);
+		}
 	}
-
-	free_irq(AU1100_SD_IRQ, 0);
 	return 0;
 }
 
@@ -1004,6 +1096,18 @@ static struct platform_driver au1xmmc_driver = {
 
 static int __init au1xmmc_init(void)
 {
+	if (dma) {
+		/* DSCR_CMD0_ALWAYS has a stride of 32 bits, we need a stride
+		   of 8 bits.  And since devices are shared, we need to create
+		   our own to avoid freaking out other devices
+		 */
+		if (!memid)
+			memid = au1xxx_ddma_add_device(&au1xmmc_mem_dbdev);
+		if (!memid) {
+			printk(KERN_ERR "au1xmmc: cannot add memory dma dev\n");
+			return -ENODEV;
+		}
+	}
 	return platform_driver_register(&au1xmmc_driver);
 }
 
@@ -1015,10 +1119,7 @@ static void __exit au1xmmc_exit(void)
 module_init(au1xmmc_init);
 module_exit(au1xmmc_exit);
 
-#ifdef MODULE
 MODULE_AUTHOR("Advanced Micro Devices, Inc");
 MODULE_DESCRIPTION("MMC/SD driver for the Alchemy Au1XXX");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:au1xxx-mmc");
-#endif
-
diff --git a/drivers/mmc/host/au1xmmc.h b/drivers/mmc/host/au1xmmc.h
deleted file mode 100644
index 341cbdf..0000000
--- a/drivers/mmc/host/au1xmmc.h
+++ /dev/null
@@ -1,96 +0,0 @@
-#ifndef _AU1XMMC_H_
-#define _AU1XMMC_H_
-
-/* Hardware definitions */
-
-#define AU1XMMC_DESCRIPTOR_COUNT 1
-#define AU1XMMC_DESCRIPTOR_SIZE  2048
-
-#define AU1XMMC_OCR ( MMC_VDD_27_28 | MMC_VDD_28_29 | MMC_VDD_29_30  | \
-		      MMC_VDD_30_31 | MMC_VDD_31_32 | MMC_VDD_32_33  | \
-		      MMC_VDD_33_34 | MMC_VDD_34_35 | MMC_VDD_35_36)
-
-/* Easy access macros */
-
-#define HOST_STATUS(h)	((h)->iobase + SD_STATUS)
-#define HOST_CONFIG(h)	((h)->iobase + SD_CONFIG)
-#define HOST_ENABLE(h)	((h)->iobase + SD_ENABLE)
-#define HOST_TXPORT(h)	((h)->iobase + SD_TXPORT)
-#define HOST_RXPORT(h)	((h)->iobase + SD_RXPORT)
-#define HOST_CMDARG(h)	((h)->iobase + SD_CMDARG)
-#define HOST_BLKSIZE(h)	((h)->iobase + SD_BLKSIZE)
-#define HOST_CMD(h)	((h)->iobase + SD_CMD)
-#define HOST_CONFIG2(h)	((h)->iobase + SD_CONFIG2)
-#define HOST_TIMEOUT(h)	((h)->iobase + SD_TIMEOUT)
-#define HOST_DEBUG(h)	((h)->iobase + SD_DEBUG)
-
-#define DMA_CHANNEL(h) \
-	( ((h)->flags & HOST_F_XMIT) ? (h)->tx_chan : (h)->rx_chan)
-
-/* This gives us a hard value for the stop command that we can write directly
- * to the command register
- */
-
-#define STOP_CMD (SD_CMD_RT_1B|SD_CMD_CT_7|(0xC << SD_CMD_CI_SHIFT)|SD_CMD_GO)
-
-/* This is the set of interrupts that we configure by default */
-
-#if 0
-#define AU1XMMC_INTERRUPTS (SD_CONFIG_SC | SD_CONFIG_DT | SD_CONFIG_DD | \
-		SD_CONFIG_RAT | SD_CONFIG_CR | SD_CONFIG_I)
-#endif
-
-#define AU1XMMC_INTERRUPTS (SD_CONFIG_SC | SD_CONFIG_DT | \
-		SD_CONFIG_RAT | SD_CONFIG_CR | SD_CONFIG_I)
-/* The poll event (looking for insert/remove events runs twice a second */
-#define AU1XMMC_DETECT_TIMEOUT (HZ/2)
-
-struct au1xmmc_host {
-  struct mmc_host *mmc;
-  struct mmc_request *mrq;
-
-  u32 id;
-
-  u32 flags;
-  u32 iobase;
-  u32 clock;
-  u32 bus_width;
-  u32 power_mode;
-
-  int status;
-
-   struct {
-	   int len;
-	   int dir;
-  } dma;
-
-   struct {
-	   int index;
-	   int offset;
-	   int len;
-  } pio;
-
-  u32 tx_chan;
-  u32 rx_chan;
-
-  struct timer_list timer;
-  struct tasklet_struct finish_task;
-  struct tasklet_struct data_task;
-
-  spinlock_t lock;
-};
-
-/* Status flags used by the host structure */
-
-#define HOST_F_XMIT   0x0001
-#define HOST_F_RECV   0x0002
-#define HOST_F_DMA    0x0010
-#define HOST_F_ACTIVE 0x0100
-#define HOST_F_STOP   0x1000
-
-#define HOST_S_IDLE   0x0001
-#define HOST_S_CMD    0x0002
-#define HOST_S_DATA   0x0003
-#define HOST_S_STOP   0x0004
-
-#endif
diff --git a/include/asm-mips/mach-au1x00/au1100_mmc.h b/include/asm-mips/mach-au1x00/au1100_mmc.h
index 9e0028f..6474fac 100644
--- a/include/asm-mips/mach-au1x00/au1100_mmc.h
+++ b/include/asm-mips/mach-au1x00/au1100_mmc.h
@@ -38,15 +38,46 @@
 #ifndef __ASM_AU1100_MMC_H
 #define __ASM_AU1100_MMC_H
 
-
-#define NUM_AU1100_MMC_CONTROLLERS	2
-
-#if defined(CONFIG_SOC_AU1100)
-#define AU1100_SD_IRQ	AU1100_SD_INT
-#elif defined(CONFIG_SOC_AU1200)
-#define AU1100_SD_IRQ	AU1200_SD_INT
-#endif
-
+struct au1xmmc_platdata {
+	int(*cd_setup)(void *mmc_host, int on);
+	int(*card_inserted)(void *mmc_host);
+	int(*card_readonly)(void *mmc_host);
+	void(*set_power)(void *mmc_host, int state);
+};
+
+struct au1xmmc_host {
+	struct mmc_host *mmc;
+	struct mmc_request *mrq;
+
+	u32 id;
+
+	u32 flags;
+	u32 iobase;
+	u32 clock;
+
+	int status;
+
+	struct {
+		int len;
+		int dir;
+		u32 tx_chan;
+		u32 rx_chan;
+	} dma;
+
+	struct {
+		int index;
+		int offset;
+		int len;
+	} pio;
+
+	struct timer_list timer;
+	struct tasklet_struct finish_task;
+	struct tasklet_struct data_task;
+
+	struct platform_device *pdev;
+	struct au1xmmc_platdata *platdata;
+	int irq;
+};
 
 #define SD0_BASE	0xB0600000
 #define SD1_BASE	0xB0680000
-- 
1.5.5.1
