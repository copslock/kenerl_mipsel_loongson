From: Manuel Lauss <mlau@msc-ge.com>
Date: Wed, 7 May 2008 15:18:14 +0200
Subject: [PATCH] au1xmmc: wire up SDIO interrupt
Message-ID: <20080507131814._FV4yvMw6y6X2K9aWWgOeIDavLfjZUOAoMeDsP1D-jM@z>

The silicon supports SDIO irqs.

Untested since I don't have any SDIO hardware.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 drivers/mmc/host/au1xmmc.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
index 8ee7640..513937a 100644
--- a/drivers/mmc/host/au1xmmc.c
+++ b/drivers/mmc/host/au1xmmc.c
@@ -848,6 +848,9 @@ static irqreturn_t au1xmmc_irq(int irq, void *dev_id)
 		else if ((host->flags & HOST_F_RECV) && (status & STATUS_DATA_IN))
 			au1xmmc_receive_pio(host);
 
+	} else if (status & 0x80000000) {
+		mmc_signal_sdio_irq(host->mmc);
+
 	} else if (status & 0x203FBC70) {
 			DBG("Unhandled status %8.8x\n", host->id, status);
 	}
@@ -901,10 +904,21 @@ static int au1xmmc_init_dma(struct au1xmmc_host *host)
 	return 0;
 }
 
+static void au1xmmc_enable_sdio_irq(struct mmc_host *mmc, int en)
+{
+	struct au1xmmc_host *host = mmc_priv(mmc);
+
+	if (en)
+		IRQ_ON(host, (1<<31));
+	else
+		IRQ_OFF(host, (1<<31));
+}
+
 static const struct mmc_host_ops au1xmmc_ops = {
 	.request	= au1xmmc_request,
 	.set_ios	= au1xmmc_set_ios,
 	.get_ro		= au1xmmc_card_readonly,
+	.enable_sdio_irq = au1xmmc_enable_sdio_irq,
 };
 
 static void au1xmmc_poll_event(unsigned long arg)
@@ -996,7 +1010,7 @@ static int __devinit au1xmmc_probe(struct platform_device *pdev)
 	mmc->max_blk_count = 512;
 
 	mmc->ocr_avail = AU1XMMC_OCR;
-	mmc->caps = MMC_CAP_4_BIT_DATA;
+	mmc->caps = MMC_CAP_4_BIT_DATA | MMC_CAP_SDIO_IRQ;
 
 	host->id = pdev->id;
 	host->status = HOST_S_IDLE;
-- 
1.5.5.1
