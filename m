Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Sep 2015 18:09:11 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:52897 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011405AbbILQIikZGIq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 12 Sep 2015 18:08:38 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id B357B28C123;
        Sat, 12 Sep 2015 18:07:27 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (dslb-088-073-016-160.088.073.pools.vodafone-ip.de [88.73.16.160])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 3315928C12E;
        Sat, 12 Sep 2015 18:06:38 +0200 (CEST)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-spi@vger.kernel.org, linux-mips@linux-mips.org
Cc:     Mark Brown <broonie@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, florian@openwrt.org
Subject: [PATCH V2 4/6] spi/bcm63xx: replace custom io accessors with standard ones
Date:   Sat, 12 Sep 2015 18:07:01 +0200
Message-Id: <1442074023-29840-5-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1442074023-29840-1-git-send-email-jogo@openwrt.org>
References: <1442074023-29840-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49169
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

Replace all bcm_read* with (io)read. Due to this block following
system endianness, make sure we match that.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
v1 -> v2:
 * Use the right guard and io*be.

 drivers/spi/spi-bcm63xx.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index c1364a8..461891f 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -56,25 +56,33 @@ struct bcm63xx_spi {
 static inline u8 bcm_spi_readb(struct bcm63xx_spi *bs,
 				unsigned int offset)
 {
-	return bcm_readb(bs->regs + bcm63xx_spireg(offset));
+	return readb(bs->regs + bcm63xx_spireg(offset));
 }
 
 static inline u16 bcm_spi_readw(struct bcm63xx_spi *bs,
 				unsigned int offset)
 {
-	return bcm_readw(bs->regs + bcm63xx_spireg(offset));
+#ifdef CONFIG_CPU_BIG_ENDIAN
+	return ioread16be(bs->regs + bcm63xx_spireg(offset));
+#else
+	return readw(bs->regs + bcm63xx_spireg(offset));
+#endif
 }
 
 static inline void bcm_spi_writeb(struct bcm63xx_spi *bs,
 				  u8 value, unsigned int offset)
 {
-	bcm_writeb(value, bs->regs + bcm63xx_spireg(offset));
+	writeb(value, bs->regs + bcm63xx_spireg(offset));
 }
 
 static inline void bcm_spi_writew(struct bcm63xx_spi *bs,
 				  u16 value, unsigned int offset)
 {
-	bcm_writew(value, bs->regs + bcm63xx_spireg(offset));
+#ifdef CONFIG_CPU_BIG_ENDIAN
+	iowrite16be(value, bs->regs + bcm63xx_spireg(offset));
+#else
+	writew(value, bs->regs + bcm63xx_spireg(offset));
+#endif
 }
 
 static const unsigned bcm63xx_spi_freq_table[SPI_CLK_MASK][2] = {
-- 
2.1.4
