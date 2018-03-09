Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Mar 2018 16:15:34 +0100 (CET)
Received: from mail-qk0-x241.google.com ([IPv6:2607:f8b0:400d:c09::241]:45597
        "EHLO mail-qk0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994816AbeCIPNdcXjFw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Mar 2018 16:13:33 +0100
Received: by mail-qk0-x241.google.com with SMTP id r140so3948832qke.12
        for <linux-mips@linux-mips.org>; Fri, 09 Mar 2018 07:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=prPbV5jwzkXz4p8Uo05cHKrC+M6pLMxShLng6z57HAM=;
        b=YhzaKNLW0s/R+STy4veoBR3PRk00qSYtrg1cOyeGXDaBOmZWBKjagnP34dTbzaB870
         09mePSFgk9uIhRaLAQp+MKxbAYd3QEa0I/qD7oQfqYaMuMg0Padms2p4sPvzu0Ep6qM8
         vTbTiNkFjuRz7Y8An/xprqHu9MXMC1xCsfayQhCVLIvNEVVBiWUdoKcE2+SheAW8llwc
         67iYHw+ph6B9jeEOCBna0XswdOyoPYOrK/XV14ouEaCZDR/QAzh2uUJpU8V+7t9bD7sn
         4JnQBBVnsavWv1EMnR+68cwWnkLCX2l8FwCkFMwBc9JYztGjC+r/eICy75+jY2psXaVv
         VZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=prPbV5jwzkXz4p8Uo05cHKrC+M6pLMxShLng6z57HAM=;
        b=lMKZ4vaQI0cEqAPOEJBmngAKwCVCsDMdDR4mQa1FDEcpWYVSOON53v0PtC5vWPs4H6
         p0W90OESa+Me/DDvfMHn0XXv2dGIipSF4Q1/pBGC7+oD+D8jb7Cm5zzIuAkRDh4Cpoi1
         4dEdryT1WP9O95KQe6EwP5ru/cEUFBqpDGWNnKafBLCtS1PD96wFhZ1OO/LnEc3HfaJG
         4fdkaaWbv+9eh0bTtIRURCN/jcGm1rNYBFJfgMHfpD5pSabxEKM07EpoGOWlb5vNV4Py
         G48xipN1OYHl4VO2HNlFNXdSjHScWuLMhDv++d5t4cpsoo/FM39woxLRMhqO78BoLbSG
         Tgxg==
X-Gm-Message-State: AElRT7GZKdjxwK/p0euUmCOlQ5ObsVDEgffxcC2RFj9bZyWYxDg6QlLf
        cRqGRSPPw9etrmjOBuTyhwwdGg==
X-Google-Smtp-Source: AG47ELt2L/+JtmsTeTDcwsxhwTwZsuJS3x5uCGFSY33Y4hyFEL0jVgcZrAEX31YvP9ZkzxnxAMRiUA==
X-Received: by 10.55.73.140 with SMTP id w134mr45666532qka.215.1520608407416;
        Fri, 09 Mar 2018 07:13:27 -0800 (PST)
Received: from localhost.localdomain ([190.210.56.45])
        by smtp.gmail.com with ESMTPSA id d186sm682187qkf.37.2018.03.09.07.13.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Mar 2018 07:13:26 -0800 (PST)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>,
        Alex Smith <alex.smith@imgtec.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: [PATCH 08/14] mmc: jz4740: Add support for the JZ4780
Date:   Fri,  9 Mar 2018 12:12:13 -0300
Message-Id: <20180309151219.18723-9-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180309151219.18723-1-ezequiel@vanguardiasur.com.ar>
References: <20180309151219.18723-1-ezequiel@vanguardiasur.com.ar>
Return-Path: <ezequiel@vanguardiasur.com.ar>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62885
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
Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
 drivers/mmc/host/Kconfig      |   2 +-
 drivers/mmc/host/jz4740_mmc.c | 111 ++++++++++++++++++++++++++++++++++--------
 2 files changed, 93 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 620c2d90a646..7dd5169a2dfb 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -767,7 +767,7 @@ config MMC_SH_MMCIF
 
 config MMC_JZ4740
 	tristate "JZ4740 SD/Multimedia Card Interface support"
-	depends on MACH_JZ4740
+	depends on MACH_JZ4740 || MACH_JZ4780
 	help
 	  This selects support for the SD/MMC controller on Ingenic JZ4740
 	  SoCs.
diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 7d4dcce76cd8..bb1b9114ef53 100644
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
 
@@ -371,7 +416,7 @@ static void jz4740_mmc_set_irq_enabled(struct jz4740_mmc_host *host,
 		host->irq_mask |= irq;
 	spin_unlock_irqrestore(&host->lock, flags);
 
-	writew(host->irq_mask, host->base + JZ_REG_MMC_IMASK);
+	host->write_irq_mask(host, host->irq_mask);
 }
 
 static void jz4740_mmc_clock_enable(struct jz4740_mmc_host *host,
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
