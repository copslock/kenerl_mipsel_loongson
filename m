Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Mar 2018 23:01:42 +0100 (CET)
Received: from mail-qk0-x243.google.com ([IPv6:2607:f8b0:400d:c09::243]:41894
        "EHLO mail-qk0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990434AbeCLV7ksT-ef (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Mar 2018 22:59:40 +0100
Received: by mail-qk0-x243.google.com with SMTP id s78so3695772qkl.8
        for <linux-mips@linux-mips.org>; Mon, 12 Mar 2018 14:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W43CgS9uC4z2J80mJZf8uddvCw7loIlRWJlpzdQEKqo=;
        b=i6z2gC4zl7La/ec0onfhSYOr2qNK8mX2oR9Qd0oYw8I8wCM/znwz3uBGfec12cNx0/
         l9JgmXgWljx9r5w2tYgx8vMR9e9/rKjkMxKi+bK0ESzXww+kzHERzWVzfL/g0ygJRs5R
         et7Y2fj2uBBvfEnrsk6xqgpmDzWer8IF5HopjahU4Itypm6VKDy2w2ZZg82a2BGMTR0P
         KvfY4MdkBV6ZGRXG/QxQ1qRJ4ackX95wVh5tA0vePbaBiLhwsFlI4V7VAECEx1eNScQL
         1E6bgEtf+iIIV+PZShyf/Pnx1ETg3npVkgivLzNrlBaKKXBPIVKdcojKE8/8r73hYOD+
         Htww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W43CgS9uC4z2J80mJZf8uddvCw7loIlRWJlpzdQEKqo=;
        b=LFBRgIjrMoFTyPt0IwXmPRso9ANnFSIgG3fAmzDGOL1rXAM2ojPyAwGNu1jEVyoqj3
         JcqhDw5AmQ4C3G0HX2+DFNgXFrOGLrx2GBVaf1eqeYEpNpKlfiVUSVJrOIRS7DH5UnXV
         JCqzNVREQnBLu+Fcu0lXSM7JwvlT1ajXtdIKcGZ8Ud27TvVnkq9M1Mgp5ZE0/wxDuB6v
         mVfcWxMvN4BGpAYkWrmgVTB68UctZqzpQ0w3gkHYfrfZl+6IlLqtfa1bTcyyjNFTUodq
         seUzG+2nC3MmmTqpwFePvaUGi6pvam6j4or9qmhPVbc99lRFJJTSJDSlX7VXzQmCb57z
         rolA==
X-Gm-Message-State: AElRT7HG+isot+AmhRCKeMI0gd3mjIG7P8QsrRT/40fL24KcMxLmsPpU
        QiPk8C1xkAqUzVlUVwEajl0+Q9j2
X-Google-Smtp-Source: AG47ELtpSDmG6bX6ltjeW100eYMj8kVhBKkB2RZFqsD+49IztC6Y2ftHHN6+AyM0lUveLrFckS+GyQ==
X-Received: by 10.55.173.7 with SMTP id f7mr13681976qkm.195.1520891974585;
        Mon, 12 Mar 2018 14:59:34 -0700 (PDT)
Received: from localhost.localdomain ([190.210.56.45])
        by smtp.gmail.com with ESMTPSA id c5sm2756961qkf.93.2018.03.12.14.59.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Mar 2018 14:59:33 -0700 (PDT)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>,
        Alex Smith <alex.smith@imgtec.com>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>
Subject: [PATCH v2 09/14] mmc: jz4740: Add support for the JZ4780
Date:   Mon, 12 Mar 2018 18:55:49 -0300
Message-Id: <20180312215554.20770-10-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180312215554.20770-1-ezequiel@vanguardiasur.com.ar>
References: <20180312215554.20770-1-ezequiel@vanguardiasur.com.ar>
Return-Path: <ezequiel@vanguardiasur.com.ar>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62940
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ezequiel@vanguardiasur.com.ar
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
[Ezequiel: rebase and introduce register accessors]
Tested-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: Ezequiel Garcia <ezequiel@collabora.co.uk>
---
 drivers/mmc/host/Kconfig      |   9 ++--
 drivers/mmc/host/jz4740_mmc.c | 111 ++++++++++++++++++++++++++++++++++--------
 2 files changed, 97 insertions(+), 23 deletions(-)

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
index aa635b458d2c..c3ec8e662706 100644
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
 
@@ -164,8 +171,46 @@ struct jz4740_mmc_host {
  * trigger is when data words in MSC_TXFIFO is < 8.
  */
 #define JZ4740_MMC_FIFO_HALF_SIZE 8
+
+	void (*write_irq_mask)(struct jz4740_mmc_host *host, uint32_t val);
+	void (*write_irq_reg)(struct jz4740_mmc_host *host, uint32_t val);
+	uint32_t (*read_irq_reg)(struct jz4740_mmc_host *host);
 };
 
+static void jz4750_mmc_write_irq_mask(struct jz4740_mmc_host *host,
+				      uint32_t val)
+{
+	return writel(val, host->base + JZ_REG_MMC_IMASK);
+}
+
+static void jz4740_mmc_write_irq_mask(struct jz4740_mmc_host *host,
+				      uint32_t val)
+{
+	return writew(val, host->base + JZ_REG_MMC_IMASK);
+}
+
+static void jz4740_mmc_write_irq_reg(struct jz4740_mmc_host *host,
+				     uint32_t val)
+{
+	return writew(val, host->base + JZ_REG_MMC_IREG);
+}
+
+static uint32_t jz4740_mmc_read_irq_reg(struct jz4740_mmc_host *host)
+{
+	return readw(host->base + JZ_REG_MMC_IREG);
+}
+
+static void jz4780_mmc_write_irq_reg(struct jz4740_mmc_host *host, uint32_t val)
+{
+	return writel(val, host->base + JZ_REG_MMC_IREG);
+}
+
+/* In the 4780 onwards, IREG is expanded to 32 bits. */
+static uint32_t jz4780_mmc_read_irq_reg(struct jz4740_mmc_host *host)
+{
+	return readl(host->base + JZ_REG_MMC_IREG);
+}
+
 /*----------------------------------------------------------------------------*/
 /* DMA infrastructure */
 
@@ -370,7 +415,7 @@ static void jz4740_mmc_set_irq_enabled(struct jz4740_mmc_host *host,
 	else
 		host->irq_mask |= irq;
 
-	writew(host->irq_mask, host->base + JZ_REG_MMC_IMASK);
+	host->write_irq_mask(host, host->irq_mask);
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
@@ -422,10 +467,10 @@ static unsigned int jz4740_mmc_poll_irq(struct jz4740_mmc_host *host,
 	unsigned int irq)
 {
 	unsigned int timeout = 0x800;
-	uint16_t status;
+	uint32_t status;
 
 	do {
-		status = readw(host->base + JZ_REG_MMC_IREG);
+		status = host->read_irq_reg(host);
 	} while (!(status & irq) && --timeout);
 
 	if (timeout == 0) {
@@ -525,7 +570,7 @@ static bool jz4740_mmc_read_data(struct jz4740_mmc_host *host,
 	void __iomem *fifo_addr = host->base + JZ_REG_MMC_RXFIFO;
 	uint32_t *buf;
 	uint32_t d;
-	uint16_t status;
+	uint32_t status;
 	size_t i, j;
 	unsigned int timeout;
 
@@ -661,8 +706,25 @@ static void jz4740_mmc_send_command(struct jz4740_mmc_host *host,
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
@@ -743,7 +805,7 @@ static irqreturn_t jz_mmc_irq_worker(int irq, void *devid)
 			host->state = JZ4740_MMC_STATE_SEND_STOP;
 			break;
 		}
-		writew(JZ_MMC_IRQ_DATA_TRAN_DONE, host->base + JZ_REG_MMC_IREG);
+		host->write_irq_reg(host, JZ_MMC_IRQ_DATA_TRAN_DONE);
 
 	case JZ4740_MMC_STATE_SEND_STOP:
 		if (!req->stop)
@@ -773,9 +835,10 @@ static irqreturn_t jz_mmc_irq(int irq, void *devid)
 {
 	struct jz4740_mmc_host *host = devid;
 	struct mmc_command *cmd = host->cmd;
-	uint16_t irq_reg, status, tmp;
+	uint32_t irq_reg, status, tmp;
 
-	irq_reg = readw(host->base + JZ_REG_MMC_IREG);
+	status = readl(host->base + JZ_REG_MMC_STATUS);
+	irq_reg = host->read_irq_reg(host);
 
 	tmp = irq_reg;
 	irq_reg &= ~host->irq_mask;
@@ -784,10 +847,10 @@ static irqreturn_t jz_mmc_irq(int irq, void *devid)
 		JZ_MMC_IRQ_PRG_DONE | JZ_MMC_IRQ_DATA_TRAN_DONE);
 
 	if (tmp != irq_reg)
-		writew(tmp & ~irq_reg, host->base + JZ_REG_MMC_IREG);
+		host->write_irq_reg(host, tmp & ~irq_reg);
 
 	if (irq_reg & JZ_MMC_IRQ_SDIO) {
-		writew(JZ_MMC_IRQ_SDIO, host->base + JZ_REG_MMC_IREG);
+		host->write_irq_reg(host, JZ_MMC_IRQ_SDIO);
 		mmc_signal_sdio_irq(host->mmc);
 		irq_reg &= ~JZ_MMC_IRQ_SDIO;
 	}
@@ -796,8 +859,6 @@ static irqreturn_t jz_mmc_irq(int irq, void *devid)
 		if (test_and_clear_bit(0, &host->waiting)) {
 			del_timer(&host->timeout_timer);
 
-			status = readl(host->base + JZ_REG_MMC_STATUS);
-
 			if (status & JZ_MMC_STATUS_TIMEOUT_RES) {
 					cmd->error = -ETIMEDOUT;
 			} else if (status & JZ_MMC_STATUS_CRC_RES_ERR) {
@@ -810,7 +871,7 @@ static irqreturn_t jz_mmc_irq(int irq, void *devid)
 			}
 
 			jz4740_mmc_set_irq_enabled(host, irq_reg, false);
-			writew(irq_reg, host->base + JZ_REG_MMC_IREG);
+			host->write_irq_reg(host, irq_reg);
 
 			return IRQ_WAKE_THREAD;
 		}
@@ -844,9 +905,7 @@ static void jz4740_mmc_request(struct mmc_host *mmc, struct mmc_request *req)
 
 	host->req = req;
 
-	writew(0xffff, host->base + JZ_REG_MMC_IREG);
-
-	writew(JZ_MMC_IRQ_END_CMD_RES, host->base + JZ_REG_MMC_IREG);
+	host->write_irq_reg(host, ~0);
 	jz4740_mmc_set_irq_enabled(host, JZ_MMC_IRQ_END_CMD_RES, true);
 
 	host->state = JZ4740_MMC_STATE_READ_RESPONSE;
@@ -973,6 +1032,7 @@ static void jz4740_mmc_free_gpios(struct platform_device *pdev)
 
 static const struct of_device_id jz4740_mmc_of_match[] = {
 	{ .compatible = "ingenic,jz4740-mmc", .data = (void *) JZ_MMC_JZ4740 },
+	{ .compatible = "ingenic,jz4780-mmc", .data = (void *) JZ_MMC_JZ4780 },
 	{},
 };
 MODULE_DEVICE_TABLE(of, jz4740_mmc_of_match);
@@ -1017,6 +1077,19 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
 			goto err_free_host;
 	}
 
+	if (host->version >= JZ_MMC_JZ4780) {
+		host->write_irq_reg = jz4780_mmc_write_irq_reg;
+		host->read_irq_reg = jz4780_mmc_read_irq_reg;
+	} else {
+		host->write_irq_reg = jz4740_mmc_write_irq_reg;
+		host->read_irq_reg = jz4740_mmc_read_irq_reg;
+	}
+
+	if (host->version >= JZ_MMC_JZ4750)
+		host->write_irq_mask = jz4750_mmc_write_irq_mask;
+	else
+		host->write_irq_mask = jz4740_mmc_write_irq_mask;
+
 	host->irq = platform_get_irq(pdev, 0);
 	if (host->irq < 0) {
 		ret = host->irq;
@@ -1055,7 +1128,7 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
 	host->mmc = mmc;
 	host->pdev = pdev;
 	spin_lock_init(&host->lock);
-	host->irq_mask = 0xffff;
+	host->irq_mask = ~0;
 
 	jz4740_mmc_reset(host);
 
-- 
2.16.2
