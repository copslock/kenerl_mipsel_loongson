Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Sep 2009 15:59:42 +0200 (CEST)
Received: from mba.ocn.ne.jp ([122.28.14.163]:55870 "HELO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with SMTP
	id S1492724AbZICN7L (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 3 Sep 2009 15:59:11 +0200
Received: from localhost.localdomain (p2046-ipad301funabasi.chiba.ocn.ne.jp [122.17.252.46])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 24EE46A7E; Thu,  3 Sep 2009 22:59:03 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, spi-devel-general@lists.sourceforge.net,
	david-b@pacbell.net
Subject: [PATCH 2/2] spi_txx9: Fix bit rate calculation
Date:	Thu,  3 Sep 2009 22:59:01 +0900
Message-Id: <1251986341-16938-2-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.5
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23978
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

TXx9 SPI bit rate is calculated by:
        fBR = (spi-baseclk) / (n + 1)
Fix calculation of min_speed_hz, max_speed_hz and n.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 drivers/spi/spi_txx9.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi_txx9.c b/drivers/spi/spi_txx9.c
index 96057de..19f7562 100644
--- a/drivers/spi/spi_txx9.c
+++ b/drivers/spi/spi_txx9.c
@@ -29,6 +29,8 @@
 
 
 #define SPI_FIFO_SIZE 4
+#define SPI_MAX_DIVIDER 0xff	/* Max. value for SPCR1.SER */
+#define SPI_MIN_DIVIDER 1	/* Min. value for SPCR1.SER */
 
 #define TXx9_SPMCR		0x00
 #define TXx9_SPCR0		0x04
@@ -193,11 +195,8 @@ static void txx9spi_work_one(struct txx9spi *c, struct spi_message *m)
 
 		if (prev_speed_hz != speed_hz
 				|| prev_bits_per_word != bits_per_word) {
-			u32 n = (c->baseclk + speed_hz - 1) / speed_hz;
-			if (n < 1)
-				n = 1;
-			else if (n > 0xff)
-				n = 0xff;
+			int n = DIV_ROUND_UP(c->baseclk, speed_hz) - 1;
+			n = clamp(n, SPI_MIN_DIVIDER, SPI_MAX_DIVIDER);
 			/* enter config mode */
 			txx9spi_wr(c, mcr | TXx9_SPMCR_CONFIG | TXx9_SPMCR_BCLR,
 					TXx9_SPMCR);
@@ -370,8 +369,8 @@ static int __init txx9spi_probe(struct platform_device *dev)
 		goto exit;
 	}
 	c->baseclk = clk_get_rate(c->clk);
-	c->min_speed_hz = (c->baseclk + 0xff - 1) / 0xff;
-	c->max_speed_hz = c->baseclk;
+	c->min_speed_hz = DIV_ROUND_UP(c->baseclk, SPI_MAX_DIVIDER + 1);
+	c->max_speed_hz = c->baseclk / (SPI_MIN_DIVIDER + 1);
 
 	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
 	if (!res)
-- 
1.5.6.5
