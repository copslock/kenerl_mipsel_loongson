Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Sep 2015 18:09:27 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:52902 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008088AbbILQImajbEq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 12 Sep 2015 18:08:42 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 0313D28C11A;
        Sat, 12 Sep 2015 18:07:31 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (dslb-088-073-016-160.088.073.pools.vodafone-ip.de [88.73.16.160])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 2388D28C088;
        Sat, 12 Sep 2015 18:06:43 +0200 (CEST)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-spi@vger.kernel.org, linux-mips@linux-mips.org
Cc:     Mark Brown <broonie@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, florian@openwrt.org
Subject: [PATCH V2 5/6] spi/bcm63xx: move message control word description to register offsets
Date:   Sat, 12 Sep 2015 18:07:02 +0200
Message-Id: <1442074023-29840-6-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1442074023-29840-1-git-send-email-jogo@openwrt.org>
References: <1442074023-29840-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49170
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

Make the message control word parameters part of the register offsets
array so we have them all in one struct.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
v1 -> v2
 * drop the platform_data struct completely.

 arch/mips/bcm63xx/dev-spi.c                          | 17 ++---------------
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h | 14 +++++++-------
 drivers/spi/spi-bcm63xx.c                            |  7 +++----
 3 files changed, 12 insertions(+), 26 deletions(-)

diff --git a/arch/mips/bcm63xx/dev-spi.c b/arch/mips/bcm63xx/dev-spi.c
index b475bc1..b212256 100644
--- a/arch/mips/bcm63xx/dev-spi.c
+++ b/arch/mips/bcm63xx/dev-spi.c
@@ -53,16 +53,11 @@ static struct resource spi_resources[] = {
 	},
 };
 
-static struct bcm63xx_spi_pdata spi_pdata;
-
 static struct platform_device bcm63xx_spi_device = {
 	.name		= "bcm63xx-spi",
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(spi_resources),
 	.resource	= spi_resources,
-	.dev		= {
-		.platform_data = &spi_pdata,
-	},
 };
 
 int __init bcm63xx_spi_register(void)
@@ -74,20 +69,12 @@ int __init bcm63xx_spi_register(void)
 	spi_resources[0].end = spi_resources[0].start;
 	spi_resources[1].start = bcm63xx_get_irq_number(IRQ_SPI);
 
-	if (BCMCPU_IS_6338() || BCMCPU_IS_6348()) {
+	if (BCMCPU_IS_6338() || BCMCPU_IS_6348())
 		spi_resources[0].end += BCM_6348_RSET_SPI_SIZE - 1;
-		spi_pdata.fifo_size = SPI_6348_MSG_DATA_SIZE;
-		spi_pdata.msg_type_shift = SPI_6348_MSG_TYPE_SHIFT;
-		spi_pdata.msg_ctl_width = SPI_6348_MSG_CTL_WIDTH;
-	}
 
 	if (BCMCPU_IS_3368() || BCMCPU_IS_6358() || BCMCPU_IS_6362() ||
-		BCMCPU_IS_6368()) {
+		BCMCPU_IS_6368())
 		spi_resources[0].end += BCM_6358_RSET_SPI_SIZE - 1;
-		spi_pdata.fifo_size = SPI_6358_MSG_DATA_SIZE;
-		spi_pdata.msg_type_shift = SPI_6358_MSG_TYPE_SHIFT;
-		spi_pdata.msg_ctl_width = SPI_6358_MSG_CTL_WIDTH;
-	}
 
 	bcm63xx_spi_regs_init();
 
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h
index 07c6098..1d121fd 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h
@@ -7,12 +7,6 @@
 
 int __init bcm63xx_spi_register(void);
 
-struct bcm63xx_spi_pdata {
-	unsigned int	fifo_size;
-	unsigned int	msg_type_shift;
-	unsigned int	msg_ctl_width;
-};
-
 enum bcm63xx_regs_spi {
 	SPI_CMD,
 	SPI_INT_STATUS,
@@ -26,6 +20,9 @@ enum bcm63xx_regs_spi {
 	SPI_MSG_CTL,
 	SPI_MSG_DATA,
 	SPI_RX_DATA,
+	SPI_MSG_TYPE_SHIFT,
+	SPI_MSG_CTL_WIDTH,
+	SPI_MSG_DATA_SIZE,
 };
 
 #define __GEN_SPI_REGS_TABLE(__cpu)					\
@@ -40,7 +37,10 @@ enum bcm63xx_regs_spi {
 	[SPI_RX_TAIL]		= SPI_## __cpu ##_RX_TAIL,		\
 	[SPI_MSG_CTL]		= SPI_## __cpu ##_MSG_CTL,		\
 	[SPI_MSG_DATA]		= SPI_## __cpu ##_MSG_DATA,		\
-	[SPI_RX_DATA]		= SPI_## __cpu ##_RX_DATA,
+	[SPI_RX_DATA]		= SPI_## __cpu ##_RX_DATA,		\
+	[SPI_MSG_TYPE_SHIFT]	= SPI_## __cpu ##_MSG_TYPE_SHIFT,	\
+	[SPI_MSG_CTL_WIDTH]	= SPI_## __cpu ##_MSG_CTL_WIDTH,	\
+	[SPI_MSG_DATA_SIZE]	= SPI_## __cpu ##_MSG_DATA_SIZE,
 
 static inline unsigned long bcm63xx_spireg(enum bcm63xx_regs_spi reg)
 {
diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 461891f..b3da044 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -329,7 +329,6 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 {
 	struct resource *r;
 	struct device *dev = &pdev->dev;
-	struct bcm63xx_spi_pdata *pdata = dev_get_platdata(&pdev->dev);
 	int irq;
 	struct spi_master *master;
 	struct clk *clk;
@@ -369,7 +368,7 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 
 	bs->irq = irq;
 	bs->clk = clk;
-	bs->fifo_size = pdata->fifo_size;
+	bs->fifo_size = bcm63xx_spireg(SPI_MSG_DATA_SIZE);
 
 	ret = devm_request_irq(&pdev->dev, irq, bcm63xx_spi_interrupt, 0,
 							pdev->name, master);
@@ -384,8 +383,8 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 	master->mode_bits = MODEBITS;
 	master->bits_per_word_mask = SPI_BPW_MASK(8);
 	master->auto_runtime_pm = true;
-	bs->msg_type_shift = pdata->msg_type_shift;
-	bs->msg_ctl_width = pdata->msg_ctl_width;
+	bs->msg_type_shift = bcm63xx_spireg(SPI_MSG_TYPE_SHIFT);
+	bs->msg_ctl_width = bcm63xx_spireg(SPI_MSG_CTL_WIDTH);
 	bs->tx_io = (u8 *)(bs->regs + bcm63xx_spireg(SPI_MSG_DATA));
 	bs->rx_io = (const u8 *)(bs->regs + bcm63xx_spireg(SPI_RX_DATA));
 
-- 
2.1.4
