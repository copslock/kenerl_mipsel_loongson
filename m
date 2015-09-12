Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Sep 2015 18:08:53 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:52892 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008238AbbILQIfXGxWq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 12 Sep 2015 18:08:35 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 6FDF628C11A;
        Sat, 12 Sep 2015 18:07:20 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (dslb-088-073-016-160.088.073.pools.vodafone-ip.de [88.73.16.160])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 501E828C12D;
        Sat, 12 Sep 2015 18:06:30 +0200 (CEST)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-spi@vger.kernel.org, linux-mips@linux-mips.org
Cc:     Mark Brown <broonie@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, florian@openwrt.org
Subject: [PATCH V2 3/6] spi/bcm63xx: hardcode busnum to 0
Date:   Sat, 12 Sep 2015 18:07:00 +0200
Message-Id: <1442074023-29840-4-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1442074023-29840-1-git-send-email-jogo@openwrt.org>
References: <1442074023-29840-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49168
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

We always pass 0 as the spi bus number, so we might as well hard code
it.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
v1 -> v2
 * remove the platform data member as well.

 arch/mips/bcm63xx/dev-spi.c                          | 4 +---
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h | 1 -
 drivers/spi/spi-bcm63xx.c                            | 3 ++-
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/mips/bcm63xx/dev-spi.c b/arch/mips/bcm63xx/dev-spi.c
index 438df08..b475bc1 100644
--- a/arch/mips/bcm63xx/dev-spi.c
+++ b/arch/mips/bcm63xx/dev-spi.c
@@ -53,9 +53,7 @@ static struct resource spi_resources[] = {
 	},
 };
 
-static struct bcm63xx_spi_pdata spi_pdata = {
-	.bus_num		= 0,
-};
+static struct bcm63xx_spi_pdata spi_pdata;
 
 static struct platform_device bcm63xx_spi_device = {
 	.name		= "bcm63xx-spi",
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h
index 40dab9d..07c6098 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h
@@ -11,7 +11,6 @@ struct bcm63xx_spi_pdata {
 	unsigned int	fifo_size;
 	unsigned int	msg_type_shift;
 	unsigned int	msg_ctl_width;
-	int		bus_num;
 };
 
 enum bcm63xx_regs_spi {
diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index a997c64..c1364a8 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -32,6 +32,7 @@
 #define BCM63XX_SPI_MAX_PREPEND		15
 
 #define BCM63XX_SPI_MAX_CS		8
+#define BCM63XX_SPI_BUS_NUM		0
 
 struct bcm63xx_spi {
 	struct completion	done;
@@ -369,7 +370,7 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 		goto out_err;
 	}
 
-	master->bus_num = pdata->bus_num;
+	master->bus_num = BCM63XX_SPI_BUS_NUM;
 	master->num_chipselect = BCM63XX_SPI_MAX_CS;
 	master->transfer_one_message = bcm63xx_spi_transfer_one;
 	master->mode_bits = MODEBITS;
-- 
2.1.4
