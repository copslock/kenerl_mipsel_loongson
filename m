From: Manuel Lauss <mlau@msc-ge.com>
Date: Sat, 17 May 2008 17:58:52 +0200
Subject: [PATCH] au1xmmc: SDIO IRQ support
Message-ID: <20080517155852.QZlSlKepC3Bf70a86xEAVe8ulWpx_f-XK4Pntl5wjvg@z>

Wire up the SD controllers' SDIO IRQ capability.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 drivers/mmc/host/au1xmmc.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
index 234f324..b3270b1 100644
--- a/drivers/mmc/host/au1xmmc.c
+++ b/drivers/mmc/host/au1xmmc.c
@@ -743,6 +743,9 @@ static irqreturn_t au1xmmc_irq(int irq, void *dev_id)
 	if (!(status & SD_STATUS_I))
 		return IRQ_NONE;	/* not ours */
 
+	if (status & SD_STATUS_SI)	/* SDIO */
+		mmc_signal_sdio_irq(host->mmc);
+
 	if (host->mrq && (status & STATUS_TIMEOUT)) {
 		if (status & SD_STATUS_RAT)
 			host->mrq->cmd->error = -ETIMEDOUT;
@@ -855,10 +858,21 @@ static void au1xmmc_dbdma_shutdown(struct au1xmmc_host *host)
 }
 #endif
 
+static void au1xmmc_enable_sdio_irq(struct mmc_host *mmc, int en)
+{
+	struct au1xmmc_host *host = mmc_priv(mmc);
+
+	if (en)
+		IRQ_ON(host, SD_CONFIG_SI);
+	else
+		IRQ_OFF(host, SD_CONFIG_SI);
+}
+
 static const struct mmc_host_ops au1xmmc_ops = {
 	.request	= au1xmmc_request,
 	.set_ios	= au1xmmc_set_ios,
 	.get_ro		= au1xmmc_card_readonly,
+	.enable_sdio_irq = au1xmmc_enable_sdio_irq,
 };
 
 static void au1xmmc_poll_event(unsigned long arg)
@@ -957,7 +971,7 @@ static int __devinit au1xmmc_probe(struct platform_device *pdev)
 	mmc->max_blk_count = 512;
 
 	mmc->ocr_avail = AU1XMMC_OCR;
-	mmc->caps = MMC_CAP_4_BIT_DATA;
+	mmc->caps = MMC_CAP_4_BIT_DATA | MMC_CAP_SDIO_IRQ;
 
 	host->status = HOST_S_IDLE;
 
-- 
1.5.5.1
