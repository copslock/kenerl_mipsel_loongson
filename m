From: Manuel Lauss <mlau@msc-ge.com>
Date: Wed, 7 May 2008 15:04:51 +0200
Subject: [PATCH] au1xmmc: 4 bit transfer mode
Message-ID: <20080507130451.H0oxHobulie8n_kCCtkxOER6Yc7AsQvYqJIjMnSY1Xs@z>

Add 4 Bit transfer mode support.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 drivers/mmc/host/au1xmmc.c |   21 +++++++++++++++++----
 1 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
index 17870cd..8ee7640 100644
--- a/drivers/mmc/host/au1xmmc.c
+++ b/drivers/mmc/host/au1xmmc.c
@@ -159,13 +159,13 @@ static inline void IRQ_OFF(struct au1xmmc_host *host, u32 mask)
 static inline void SEND_STOP(struct au1xmmc_host *host)
 {
 
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
@@ -760,6 +760,7 @@ static void au1xmmc_reset_controller(struct au1xmmc_host *host)
 static void au1xmmc_set_ios(struct mmc_host* mmc, struct mmc_ios* ios)
 {
 	struct au1xmmc_host *host = mmc_priv(mmc);
+	u32 config;
 
 	if (ios->power_mode == MMC_POWER_OFF)
 		au1xmmc_set_power(host, 0);
@@ -771,6 +772,18 @@ static void au1xmmc_set_ios(struct mmc_host* mmc, struct mmc_ios* ios)
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
@@ -983,7 +996,7 @@ static int __devinit au1xmmc_probe(struct platform_device *pdev)
 	mmc->max_blk_count = 512;
 
 	mmc->ocr_avail = AU1XMMC_OCR;
-	mmc->caps = 0;
+	mmc->caps = MMC_CAP_4_BIT_DATA;
 
 	host->id = pdev->id;
 	host->status = HOST_S_IDLE;
-- 
1.5.5.1
