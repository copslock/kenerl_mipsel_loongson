Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2018 23:04:34 +0200 (CEST)
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47256 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994629AbeC1VCbGhhrC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Mar 2018 23:02:31 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id F2EF8260844
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Mathieu Malaterre <malat@debian.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>, kernel@collabora.com,
        Alex Smith <alex.smith@imgtec.com>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>
Subject: [PATCH v4 09/15] mmc: jz4740: Add support for the JZ4780
Date:   Wed, 28 Mar 2018 18:00:51 -0300
Message-Id: <20180328210057.31148-10-ezequiel@collabora.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180328210057.31148-1-ezequiel@collabora.com>
References: <20180328210057.31148-1-ezequiel@collabora.com>
Return-Path: <ezequiel@collabora.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63312
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ezequiel@collabora.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

From: Alex Smith <alex.smith@imgtec.com>

Add support for the JZ4780 MMC controller to the jz47xx_mmc driver. There
are a few minor differences from the 4740 to the 4780 that need to be
handled, but otherwise the controllers behave the same. The IREG and IMASK
registers are expanded to 32 bits. Additionally, some error conditions are
now reported in both STATUS and IREG. Writing IREG before reading STATUS
causes the bits in STATUS to be cleared, so STATUS must be read first to
ensure we see and report error conditions correctly.

Signed-off-by: Alex Smith <alex.smith@imgtec.com>
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: Ezequiel Garcia <ezequiel@collabora.co.uk>
---
 drivers/mmc/host/Kconfig      |  9 +++--
 drivers/mmc/host/jz4740_mmc.c | 86 +++++++++++++++++++++++++++++++++----------
 2 files changed, 72 insertions(+), 23 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 620c2d90a646..35a5a5ad65b9 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -766,11 +766,12 @@ config MMC_SH_MMCIF
 
 
 config MMC_JZ4740
-	tristate "JZ4740 SD/Multimedia Card Interface support"
-	depends on MACH_JZ4740
+	tristate "Ingenic JZ47xx SD/Multimedia Card Interface support"
+	depends on MACH_JZ4740 || MACH_JZ4780
 	help
-	  This selects support for the SD/MMC controller on Ingenic JZ4740
-	  SoCs.
+	  This selects support for the SD/MMC controller on Ingenic
+	  JZ4740, JZ4750, JZ4770 and JZ4780 SoCs.
+
 	  If you have a board based on such a SoC and with a SD/MMC slot,
 	  say Y or M here.
 
diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index aa635b458d2c..5d3efd59bda1 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -1,5 +1,7 @@
 /*
  *  Copyright (C) 2009-2010, Lars-Peter Clausen <lars@metafoo.de>
+ *  Copyright (C) 2013, Imagination Technologies
+ *
  *  JZ4740 SD/MMC controller driver
  *
  *  This program is free software; you can redistribute  it and/or modify it
@@ -52,6 +54,7 @@
 #define JZ_REG_MMC_RESP_FIFO	0x34
 #define JZ_REG_MMC_RXFIFO	0x38
 #define JZ_REG_MMC_TXFIFO	0x3C
+#define JZ_REG_MMC_DMAC		0x44
 
 #define JZ_MMC_STRPCL_EXIT_MULTIPLE BIT(7)
 #define JZ_MMC_STRPCL_EXIT_TRANSFER BIT(6)
@@ -105,11 +108,15 @@
 #define JZ_MMC_IRQ_PRG_DONE BIT(1)
 #define JZ_MMC_IRQ_DATA_TRAN_DONE BIT(0)
 
+#define JZ_MMC_DMAC_DMA_SEL BIT(1)
+#define JZ_MMC_DMAC_DMA_EN BIT(0)
 
 #define JZ_MMC_CLK_RATE 24000000
 
 enum jz4740_mmc_version {
 	JZ_MMC_JZ4740,
+	JZ_MMC_JZ4750,
+	JZ_MMC_JZ4780,
 };
 
 enum jz4740_mmc_state {
@@ -144,7 +151,7 @@ struct jz4740_mmc_host {
 
 	uint32_t cmdat;
 
-	uint16_t irq_mask;
+	uint32_t irq_mask;
 
 	spinlock_t lock;
 
@@ -166,6 +173,32 @@ struct jz4740_mmc_host {
 #define JZ4740_MMC_FIFO_HALF_SIZE 8
 };
 
+static void jz4740_mmc_write_irq_mask(struct jz4740_mmc_host *host,
+				      uint32_t val)
+{
+	if (host->version >= JZ_MMC_JZ4750)
+		return writel(val, host->base + JZ_REG_MMC_IMASK);
+	else
+		return writew(val, host->base + JZ_REG_MMC_IMASK);
+}
+
+static void jz4740_mmc_write_irq_reg(struct jz4740_mmc_host *host,
+				     uint32_t val)
+{
+	if (host->version >= JZ_MMC_JZ4780)
+		return writel(val, host->base + JZ_REG_MMC_IREG);
+	else
+		return writew(val, host->base + JZ_REG_MMC_IREG);
+}
+
+static uint32_t jz4740_mmc_read_irq_reg(struct jz4740_mmc_host *host)
+{
+	if (host->version >= JZ_MMC_JZ4780)
+		return readl(host->base + JZ_REG_MMC_IREG);
+	else
+		return readw(host->base + JZ_REG_MMC_IREG);
+}
+
 /*----------------------------------------------------------------------------*/
 /* DMA infrastructure */
 
@@ -370,7 +403,7 @@ static void jz4740_mmc_set_irq_enabled(struct jz4740_mmc_host *host,
 	else
 		host->irq_mask |= irq;
 
-	writew(host->irq_mask, host->base + JZ_REG_MMC_IMASK);
+	jz4740_mmc_write_irq_mask(host, host->irq_mask);
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
@@ -422,10 +455,10 @@ static unsigned int jz4740_mmc_poll_irq(struct jz4740_mmc_host *host,
 	unsigned int irq)
 {
 	unsigned int timeout = 0x800;
-	uint16_t status;
+	uint32_t status;
 
 	do {
-		status = readw(host->base + JZ_REG_MMC_IREG);
+		status = jz4740_mmc_read_irq_reg(host);
 	} while (!(status & irq) && --timeout);
 
 	if (timeout == 0) {
@@ -525,7 +558,7 @@ static bool jz4740_mmc_read_data(struct jz4740_mmc_host *host,
 	void __iomem *fifo_addr = host->base + JZ_REG_MMC_RXFIFO;
 	uint32_t *buf;
 	uint32_t d;
-	uint16_t status;
+	uint32_t status;
 	size_t i, j;
 	unsigned int timeout;
 
@@ -661,8 +694,25 @@ static void jz4740_mmc_send_command(struct jz4740_mmc_host *host,
 		cmdat |= JZ_MMC_CMDAT_DATA_EN;
 		if (cmd->data->flags & MMC_DATA_WRITE)
 			cmdat |= JZ_MMC_CMDAT_WRITE;
-		if (host->use_dma)
-			cmdat |= JZ_MMC_CMDAT_DMA_EN;
+		if (host->use_dma) {
+			/*
+			 * The 4780's MMC controller has integrated DMA ability
+			 * in addition to being able to use the external DMA
+			 * controller. It moves DMA control bits to a separate
+			 * register. The DMA_SEL bit chooses the external
+			 * controller over the integrated one. Earlier SoCs
+			 * can only use the external controller, and have a
+			 * single DMA enable bit in CMDAT.
+			 */
+			if (host->version >= JZ_MMC_JZ4780) {
+				writel(JZ_MMC_DMAC_DMA_EN | JZ_MMC_DMAC_DMA_SEL,
+				       host->base + JZ_REG_MMC_DMAC);
+			} else {
+				cmdat |= JZ_MMC_CMDAT_DMA_EN;
+			}
+		} else if (host->version >= JZ_MMC_JZ4780) {
+			writel(0, host->base + JZ_REG_MMC_DMAC);
+		}
 
 		writew(cmd->data->blksz, host->base + JZ_REG_MMC_BLKLEN);
 		writew(cmd->data->blocks, host->base + JZ_REG_MMC_NOB);
@@ -743,7 +793,7 @@ static irqreturn_t jz_mmc_irq_worker(int irq, void *devid)
 			host->state = JZ4740_MMC_STATE_SEND_STOP;
 			break;
 		}
-		writew(JZ_MMC_IRQ_DATA_TRAN_DONE, host->base + JZ_REG_MMC_IREG);
+		jz4740_mmc_write_irq_reg(host, JZ_MMC_IRQ_DATA_TRAN_DONE);
 
 	case JZ4740_MMC_STATE_SEND_STOP:
 		if (!req->stop)
@@ -773,9 +823,10 @@ static irqreturn_t jz_mmc_irq(int irq, void *devid)
 {
 	struct jz4740_mmc_host *host = devid;
 	struct mmc_command *cmd = host->cmd;
-	uint16_t irq_reg, status, tmp;
+	uint32_t irq_reg, status, tmp;
 
-	irq_reg = readw(host->base + JZ_REG_MMC_IREG);
+	status = readl(host->base + JZ_REG_MMC_STATUS);
+	irq_reg = jz4740_mmc_read_irq_reg(host);
 
 	tmp = irq_reg;
 	irq_reg &= ~host->irq_mask;
@@ -784,10 +835,10 @@ static irqreturn_t jz_mmc_irq(int irq, void *devid)
 		JZ_MMC_IRQ_PRG_DONE | JZ_MMC_IRQ_DATA_TRAN_DONE);
 
 	if (tmp != irq_reg)
-		writew(tmp & ~irq_reg, host->base + JZ_REG_MMC_IREG);
+		jz4740_mmc_write_irq_reg(host, tmp & ~irq_reg);
 
 	if (irq_reg & JZ_MMC_IRQ_SDIO) {
-		writew(JZ_MMC_IRQ_SDIO, host->base + JZ_REG_MMC_IREG);
+		jz4740_mmc_write_irq_reg(host, JZ_MMC_IRQ_SDIO);
 		mmc_signal_sdio_irq(host->mmc);
 		irq_reg &= ~JZ_MMC_IRQ_SDIO;
 	}
@@ -796,8 +847,6 @@ static irqreturn_t jz_mmc_irq(int irq, void *devid)
 		if (test_and_clear_bit(0, &host->waiting)) {
 			del_timer(&host->timeout_timer);
 
-			status = readl(host->base + JZ_REG_MMC_STATUS);
-
 			if (status & JZ_MMC_STATUS_TIMEOUT_RES) {
 					cmd->error = -ETIMEDOUT;
 			} else if (status & JZ_MMC_STATUS_CRC_RES_ERR) {
@@ -810,7 +859,7 @@ static irqreturn_t jz_mmc_irq(int irq, void *devid)
 			}
 
 			jz4740_mmc_set_irq_enabled(host, irq_reg, false);
-			writew(irq_reg, host->base + JZ_REG_MMC_IREG);
+			jz4740_mmc_write_irq_reg(host, irq_reg);
 
 			return IRQ_WAKE_THREAD;
 		}
@@ -844,9 +893,7 @@ static void jz4740_mmc_request(struct mmc_host *mmc, struct mmc_request *req)
 
 	host->req = req;
 
-	writew(0xffff, host->base + JZ_REG_MMC_IREG);
-
-	writew(JZ_MMC_IRQ_END_CMD_RES, host->base + JZ_REG_MMC_IREG);
+	jz4740_mmc_write_irq_reg(host, ~0);
 	jz4740_mmc_set_irq_enabled(host, JZ_MMC_IRQ_END_CMD_RES, true);
 
 	host->state = JZ4740_MMC_STATE_READ_RESPONSE;
@@ -973,6 +1020,7 @@ static void jz4740_mmc_free_gpios(struct platform_device *pdev)
 
 static const struct of_device_id jz4740_mmc_of_match[] = {
 	{ .compatible = "ingenic,jz4740-mmc", .data = (void *) JZ_MMC_JZ4740 },
+	{ .compatible = "ingenic,jz4780-mmc", .data = (void *) JZ_MMC_JZ4780 },
 	{},
 };
 MODULE_DEVICE_TABLE(of, jz4740_mmc_of_match);
@@ -1055,7 +1103,7 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
 	host->mmc = mmc;
 	host->pdev = pdev;
 	spin_lock_init(&host->lock);
-	host->irq_mask = 0xffff;
+	host->irq_mask = ~0;
 
 	jz4740_mmc_reset(host);
 
-- 
2.16.2
