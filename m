From: Manuel Lauss <mlau@msc-ge.com>
Date: Sat, 17 May 2008 17:53:57 +0200
Subject: [PATCH] au1xmmc: enable 4 bit transfer mode
Message-ID: <20080517155357.-Gt09Qoi6Oc4EcqC8fPY5AYkKzupuSjRxHDuP4vuvlk@z>

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 drivers/mmc/host/au1xmmc.c |   22 +++++++++++++++++-----
 1 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
index d8776d6..2bd4cf4 100644
--- a/drivers/mmc/host/au1xmmc.c
+++ b/drivers/mmc/host/au1xmmc.c
@@ -95,14 +95,13 @@ static inline void IRQ_OFF(struct au1xmmc_host *host, u32 mask)
 
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
@@ -697,6 +696,7 @@ static void au1xmmc_reset_controller(struct au1xmmc_host *host)
 static void au1xmmc_set_ios(struct mmc_host* mmc, struct mmc_ios* ios)
 {
 	struct au1xmmc_host *host = mmc_priv(mmc);
+	u32 config2;
 
 	if (ios->power_mode == MMC_POWER_OFF)
 		au1xmmc_set_power(host, 0);
@@ -708,6 +708,18 @@ static void au1xmmc_set_ios(struct mmc_host* mmc, struct mmc_ios* ios)
 		au1xmmc_set_clock(host, ios->clock);
 		host->clock = ios->clock;
 	}
+
+	config2 = au_readl(HOST_CONFIG2(host));
+	switch (ios->bus_width) {
+	case MMC_BUS_WIDTH_4:
+		config2 |= SD_CONFIG2_WB;
+		break;
+	case MMC_BUS_WIDTH_1:
+		config2 &= ~SD_CONFIG2_WB;
+		break;
+	}
+	au_writel(config2, HOST_CONFIG2(host));
+	au_sync();
 }
 
 #define STATUS_TIMEOUT (SD_STATUS_RAT | SD_STATUS_DT)
@@ -952,7 +964,7 @@ static int __devinit au1xmmc_probe(struct platform_device *pdev)
 	mmc->max_blk_count = 512;
 
 	mmc->ocr_avail = AU1XMMC_OCR;
-	mmc->caps = 0;
+	mmc->caps = MMC_CAP_4_BIT_DATA;
 
 	host->status = HOST_S_IDLE;
 
-- 
1.5.5.3
