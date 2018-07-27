Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jul 2018 21:55:37 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:54830 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993016AbeG0TzBjzuPu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 27 Jul 2018 21:55:01 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 441712093A; Fri, 27 Jul 2018 21:54:55 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4D7E9209D6;
        Fri, 27 Jul 2018 21:53:59 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Mark Brown <broonie@kernel.org>, James Hogan <jhogan@kernel.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v3 1/5] spi: dw: export dw_spi_set_cs
Date:   Fri, 27 Jul 2018 21:53:54 +0200
Message-Id: <20180727195358.23336-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727195358.23336-1-alexandre.belloni@bootlin.com>
References: <20180727195358.23336-1-alexandre.belloni@bootlin.com>
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65211
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@bootlin.com
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

Export dw_spi_set_cs so it can be used from the various IP integration
modules.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/spi/spi-dw.c | 3 ++-
 drivers/spi/spi-dw.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index f76e31faf694..ac2eb89ef7a5 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -133,7 +133,7 @@ static inline void dw_spi_debugfs_remove(struct dw_spi *dws)
 }
 #endif /* CONFIG_DEBUG_FS */
 
-static void dw_spi_set_cs(struct spi_device *spi, bool enable)
+void dw_spi_set_cs(struct spi_device *spi, bool enable)
 {
 	struct dw_spi *dws = spi_controller_get_devdata(spi->controller);
 	struct chip_data *chip = spi_get_ctldata(spi);
@@ -145,6 +145,7 @@ static void dw_spi_set_cs(struct spi_device *spi, bool enable)
 	if (!enable)
 		dw_writel(dws, DW_SPI_SER, BIT(spi->chip_select));
 }
+EXPORT_SYMBOL_GPL(dw_spi_set_cs);
 
 /* Return the max entries we can fill into tx fifo */
 static inline u32 tx_max(struct dw_spi *dws)
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 446013022849..0168b08364d5 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -245,6 +245,7 @@ struct dw_spi_chip {
 	void (*cs_control)(u32 command);
 };
 
+extern void dw_spi_set_cs(struct spi_device *spi, bool enable);
 extern int dw_spi_add_host(struct device *dev, struct dw_spi *dws);
 extern void dw_spi_remove_host(struct dw_spi *dws);
 extern int dw_spi_suspend_host(struct dw_spi *dws);
-- 
2.18.0
