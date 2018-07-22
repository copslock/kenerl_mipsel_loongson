Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Jul 2018 23:23:24 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:34400 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994061AbeGVVUaXQo2S (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 22 Jul 2018 23:20:30 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 02F20AFE1;
        Sun, 22 Jul 2018 21:20:24 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        Ionela Voinescu <ionela.voinescu@imgtec.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH 14/15] spi: img-spfi: Finish every transfer cleanly
Date:   Sun, 22 Jul 2018 23:20:09 +0200
Message-Id: <20180722212010.3979-15-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180722212010.3979-1-afaerber@suse.de>
References: <20180722212010.3979-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <afaerber@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65046
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: afaerber@suse.de
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

From: Ionela Voinescu <ionela.voinescu@imgtec.com>

Before this change, the interrupt status bit that signaled
the end of a transfer was cleared in the wait_all_done
function. That functionality triggered issues for DMA
duplex transactions where the wait function was called
twice, in both the TX and RX callbacks.

In order to fix the issue, clear all interrupt data bits
at the end of a PIO transfer or at the end of both TX and RX
duplex transfers, if the transfer is not a pending transfer
(command waiting for data). After that, the status register
is checked for new incoming data or new data requests to be
signaled. If SPFI finished cleanly, no new interrupt data
bits should be set.

Signed-off-by: Ionela Voinescu <ionela.voinescu@imgtec.com>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 drivers/spi/spi-img-spfi.c | 49 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index 8ad6c75d0af5..a1244234daa5 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -83,6 +83,14 @@
 #define SPFI_INTERRUPT_SDE			BIT(1)
 #define SPFI_INTERRUPT_SDTRIG			BIT(0)
 
+#define SPFI_INTERRUPT_DATA_BITS		(SPFI_INTERRUPT_SDHF |\
+						SPFI_INTERRUPT_SDFUL |\
+						SPFI_INTERRUPT_GDEX32BIT |\
+						SPFI_INTERRUPT_GDHF |\
+						SPFI_INTERRUPT_GDFUL |\
+						SPFI_INTERRUPT_ALLDONETRIG |\
+						SPFI_INTERRUPT_GDEX8BIT)
+
 /*
  * There are four parallel FIFOs of 16 bytes each.  The word buffer
  * (*_32BIT_VALID_DATA) accesses all four FIFOs at once, resulting in an
@@ -144,6 +152,23 @@ static inline void spfi_reset(struct img_spfi *spfi)
 	spfi_writel(spfi, 0, SPFI_CONTROL);
 }
 
+static inline void spfi_finish(struct img_spfi *spfi)
+{
+	if (!(spfi->complete))
+		return;
+
+	/* Clear data bits as all transfers(TX and RX) have finished */
+	spfi_writel(spfi, SPFI_INTERRUPT_DATA_BITS, SPFI_INTERRUPT_CLEAR);
+	if (spfi_readl(spfi, SPFI_INTERRUPT_STATUS) & SPFI_INTERRUPT_DATA_BITS) {
+		dev_err(spfi->dev, "SPFI did not finish transfer cleanly.\n");
+		spfi_reset(spfi);
+	}
+	/* Disable SPFI for it not to interfere with pending transactions */
+	spfi_writel(spfi,
+		    spfi_readl(spfi, SPFI_CONTROL) & ~SPFI_CONTROL_SPFI_EN,
+		    SPFI_CONTROL);
+}
+
 static int spfi_wait_all_done(struct img_spfi *spfi)
 {
 	unsigned long timeout = jiffies + msecs_to_jiffies(50);
@@ -152,19 +177,9 @@ static int spfi_wait_all_done(struct img_spfi *spfi)
 		return 0;
 
 	while (time_before(jiffies, timeout)) {
-		u32 status = spfi_readl(spfi, SPFI_INTERRUPT_STATUS);
-
-		if (status & SPFI_INTERRUPT_ALLDONETRIG) {
-			spfi_writel(spfi, SPFI_INTERRUPT_ALLDONETRIG,
-				    SPFI_INTERRUPT_CLEAR);
-			/*
-			 * Disable SPFI for it not to interfere with
-			 * pending transactions
-			 */
-			spfi_writel(spfi, spfi_readl(spfi, SPFI_CONTROL)
-			& ~SPFI_CONTROL_SPFI_EN, SPFI_CONTROL);
+		if (spfi_readl(spfi, SPFI_INTERRUPT_STATUS) &
+		    SPFI_INTERRUPT_ALLDONETRIG)
 			return 0;
-		}
 		cpu_relax();
 	}
 
@@ -296,6 +311,8 @@ static int img_spfi_start_pio(struct spi_master *master,
 	}
 
 	ret = spfi_wait_all_done(spfi);
+	spfi_finish(spfi);
+
 	if (ret < 0)
 		return ret;
 
@@ -311,8 +328,10 @@ static void img_spfi_dma_rx_cb(void *data)
 
 	spin_lock_irqsave(&spfi->lock, flags);
 	spfi->rx_dma_busy = false;
-	if (!spfi->tx_dma_busy)
+	if (!spfi->tx_dma_busy) {
+		spfi_finish(spfi);
 		spi_finalize_current_transfer(spfi->master);
+	}
 	spin_unlock_irqrestore(&spfi->lock, flags);
 }
 
@@ -325,8 +344,10 @@ static void img_spfi_dma_tx_cb(void *data)
 
 	spin_lock_irqsave(&spfi->lock, flags);
 	spfi->tx_dma_busy = false;
-	if (!spfi->rx_dma_busy)
+	if (!spfi->rx_dma_busy) {
+		spfi_finish(spfi);
 		spi_finalize_current_transfer(spfi->master);
+	}
 	spin_unlock_irqrestore(&spfi->lock, flags);
 }
 
-- 
2.16.4
