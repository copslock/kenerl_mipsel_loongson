From: Manuel Lauss <mlau@msc-ge.com>
Date: Wed, 7 May 2008 15:18:14 +0200
Subject: [PATCH] au1xmmc: wire up SDIO interrupt
Message-ID: <20080507131814.pl-PDDTEO7_w-x3Dc_99K5Y1vUyw_ivTd6wiC5GHDW0@z>


Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 drivers/mmc/host/au1xmmc.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
index d9e334f..8b60509 100644
--- a/drivers/mmc/host/au1xmmc.c
+++ b/drivers/mmc/host/au1xmmc.c
@@ -817,6 +817,9 @@ static irqreturn_t au1xmmc_irq(int irq, void *dev_id)
 	if (!(status & (1 << 15)))
 		return IRQ_NONE;	/* not ours */
 
+	if (status & 0x80000000)	/* SDIO */
+		mmc_signal_sdio_irq(host->mmc);
+
 	if (host->mrq && (status & STATUS_TIMEOUT)) {
 		if (status & SD_STATUS_RAT)
 			host->mrq->cmd->error = -ETIMEDOUT;
@@ -903,10 +906,21 @@ static int au1xmmc_init_dma(struct au1xmmc_host *host)
 	return 0;
 }
 
+static void au1xmmc_enable_sdio_irq(struct mmc_host *mmc, int en)
+{
+	struct au1xmmc_host *host = mmc_priv(mmc);
+
+	if (en)
+		IRQ_ON(host, (1 << 31));
+	else
+		IRQ_OFF(host, (1 << 31));
+}
+
 static const struct mmc_host_ops au1xmmc_ops = {
 	.request	= au1xmmc_request,
 	.set_ios	= au1xmmc_set_ios,
 	.get_ro		= au1xmmc_card_readonly,
+	.enable_sdio_irq = au1xmmc_enable_sdio_irq,
 };
 
 static void au1xmmc_poll_event(unsigned long arg)
@@ -998,7 +1012,7 @@ static int __devinit au1xmmc_probe(struct platform_device *pdev)
 	mmc->max_blk_count = 512;
 
 	mmc->ocr_avail = AU1XMMC_OCR;
-	mmc->caps = MMC_CAP_4_BIT_DATA;
+	mmc->caps = MMC_CAP_4_BIT_DATA | MMC_CAP_SDIO_IRQ;
 
 	host->id = pdev->id;
 	host->status = HOST_S_IDLE;
-- 
1.5.5.1
