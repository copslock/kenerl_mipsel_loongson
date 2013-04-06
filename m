Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Apr 2013 13:19:26 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:49491 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6819313Ab3DFLTZ18aLc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 6 Apr 2013 13:19:25 +0200
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wVmgJBA2hh9H; Sat,  6 Apr 2013 13:18:42 +0200 (CEST)
Received: from shaker64.lan (dslb-088-073-140-081.pools.arcor-ip.net [88.73.140.81])
        by arrakis.dune.hu (Postfix) with ESMTPSA id E1483283D91;
        Sat,  6 Apr 2013 13:18:41 +0200 (CEST)
From:   Jonas Gorski <jogo@openwrt.org>
To:     spi-devel-general@lists.sourceforge.net, linux-mips@linux-mips.org
Cc:     Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Grant Likely <grant.likely@secretlab.ca>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] spi/bcm63xx: remove unused speed_hz variable
Date:   Sat,  6 Apr 2013 13:18:57 +0200
Message-Id: <1365247137-19050-1-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36020
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

speed_hz is a write only member, so we can safely remove it and its
generation. Also fixes the missing clk_put after getting the periph
clock.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---

This patch applies cleanly to both spi-next and mips-next, and I don't
have any preference into which tree it should go. Maybe mips, as it
"wins" in terms of removed lines ;-).

 arch/mips/bcm63xx/dev-spi.c                          |   11 -----------
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h |    1 -
 drivers/spi/spi-bcm63xx.c                            |    2 --
 3 files changed, 14 deletions(-)

diff --git a/arch/mips/bcm63xx/dev-spi.c b/arch/mips/bcm63xx/dev-spi.c
index f1c9c3e..e97fd60 100644
--- a/arch/mips/bcm63xx/dev-spi.c
+++ b/arch/mips/bcm63xx/dev-spi.c
@@ -85,20 +85,9 @@ static struct platform_device bcm63xx_spi_device = {
 
 int __init bcm63xx_spi_register(void)
 {
-	struct clk *periph_clk;
-
 	if (BCMCPU_IS_6328() || BCMCPU_IS_6345())
 		return -ENODEV;
 
-	periph_clk = clk_get(NULL, "periph");
-	if (IS_ERR(periph_clk)) {
-		pr_err("unable to get periph clock\n");
-		return -ENODEV;
-	}
-
-	/* Set bus frequency */
-	spi_pdata.speed_hz = clk_get_rate(periph_clk);
-
 	spi_resources[0].start = bcm63xx_regset_address(RSET_SPI);
 	spi_resources[0].end = spi_resources[0].start;
 	spi_resources[1].start = bcm63xx_get_irq_number(IRQ_SPI);
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h
index c9bae13..b0184cf 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h
@@ -13,7 +13,6 @@ struct bcm63xx_spi_pdata {
 	unsigned int	msg_ctl_width;
 	int		bus_num;
 	int		num_chipselect;
-	u32		speed_hz;
 };
 
 enum bcm63xx_regs_spi {
diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 973099b..a4ec5f4 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -46,7 +46,6 @@ struct bcm63xx_spi {
 	int			irq;
 
 	/* Platform data */
-	u32			speed_hz;
 	unsigned		fifo_size;
 	unsigned int		msg_type_shift;
 	unsigned int		msg_ctl_width;
@@ -436,7 +435,6 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 	master->unprepare_transfer_hardware = bcm63xx_spi_unprepare_transfer;
 	master->transfer_one_message = bcm63xx_spi_transfer_one;
 	master->mode_bits = MODEBITS;
-	bs->speed_hz = pdata->speed_hz;
 	bs->msg_type_shift = pdata->msg_type_shift;
 	bs->msg_ctl_width = pdata->msg_ctl_width;
 	bs->tx_io = (u8 *)(bs->regs + bcm63xx_spireg(SPI_MSG_DATA));
-- 
1.7.10.4
