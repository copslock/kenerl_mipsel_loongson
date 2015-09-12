Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Sep 2015 18:08:37 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:52889 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009663AbbILQIXZ98Gq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 12 Sep 2015 18:08:23 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 7112028C127;
        Sat, 12 Sep 2015 18:06:56 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (dslb-088-073-016-160.088.073.pools.vodafone-ip.de [88.73.16.160])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 5754728C123;
        Sat, 12 Sep 2015 18:06:26 +0200 (CEST)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-spi@vger.kernel.org, linux-mips@linux-mips.org
Cc:     Mark Brown <broonie@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, florian@openwrt.org
Subject: [PATCH V2 2/6] spi/bcm63xx: always use a fixed number of CS
Date:   Sat, 12 Sep 2015 18:06:59 +0200
Message-Id: <1442074023-29840-3-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1442074023-29840-1-git-send-email-jogo@openwrt.org>
References: <1442074023-29840-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49167
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

We always pass 8 for the number of chip selects, so we can as well
hardcode it to this number.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
v1 -> v2
 * remove the platform_data member as well.

 arch/mips/bcm63xx/dev-spi.c                          | 1 -
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h | 1 -
 drivers/spi/spi-bcm63xx.c                            | 4 +++-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/bcm63xx/dev-spi.c b/arch/mips/bcm63xx/dev-spi.c
index ad448e4..438df08 100644
--- a/arch/mips/bcm63xx/dev-spi.c
+++ b/arch/mips/bcm63xx/dev-spi.c
@@ -55,7 +55,6 @@ static struct resource spi_resources[] = {
 
 static struct bcm63xx_spi_pdata spi_pdata = {
 	.bus_num		= 0,
-	.num_chipselect		= 8,
 };
 
 static struct platform_device bcm63xx_spi_device = {
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h
index 2573765..40dab9d 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h
@@ -12,7 +12,6 @@ struct bcm63xx_spi_pdata {
 	unsigned int	msg_type_shift;
 	unsigned int	msg_ctl_width;
 	int		bus_num;
-	int		num_chipselect;
 };
 
 enum bcm63xx_regs_spi {
diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 2b908db..a997c64 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -31,6 +31,8 @@
 
 #define BCM63XX_SPI_MAX_PREPEND		15
 
+#define BCM63XX_SPI_MAX_CS		8
+
 struct bcm63xx_spi {
 	struct completion	done;
 
@@ -368,7 +370,7 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 	}
 
 	master->bus_num = pdata->bus_num;
-	master->num_chipselect = pdata->num_chipselect;
+	master->num_chipselect = BCM63XX_SPI_MAX_CS;
 	master->transfer_one_message = bcm63xx_spi_transfer_one;
 	master->mode_bits = MODEBITS;
 	master->bits_per_word_mask = SPI_BPW_MASK(8);
-- 
2.1.4
