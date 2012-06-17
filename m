Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Jun 2012 23:58:25 +0200 (CEST)
Received: from zmc.proxad.net ([212.27.53.206]:59265 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903507Ab2FQV6R (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 17 Jun 2012 23:58:17 +0200
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 3798C8EAA43;
        Sun, 17 Jun 2012 23:58:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ihmtmtiHizvI; Sun, 17 Jun 2012 23:58:16 +0200 (CEST)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id 509B98E6AD7;
        Sun, 17 Jun 2012 23:58:16 +0200 (CEST)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, grant.likely@secretlab.ca,
        spi-devel-general@lists.sourceforge.net, jonas.gorski@gmail.com,
        Florian Fainelli <florian@openwrt.org>
Subject: [PATCH] MIPS: BCM63XX: fix SPI message control register handling for BCM6338/6348
Date:   Sun, 17 Jun 2012 23:55:53 +0200
Message-Id: <1339970153-30802-1-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.9.5
X-archive-position: 33682
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

BCM6338 and BCM6348 have a message control register width of 8 bits, instead
of 16-bits like what the SPI driver assumes right now. Also the SPI message
type shift value of 14 is actually 6 for these SoCs.
This resulted in transmit FIFO corruption because we were writing 16-bits
to an 8-bits wide register, thus spanning on the first byte of the transmit
FIFO, which had already been filed in bcm63xx_spi_fill_txrx_fifo().

Fix this by passing the message control register width and message type
shift through platform data back to the SPI driver so that it can use
it properly.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
Ralf, Grant,

I would rather this go through the MIPS tree, since bcm63xx_dev_spi.h
has not reached Grant's tree yet. Thanks!

 arch/mips/bcm63xx/dev-spi.c                        |    4 ++++
 .../include/asm/mach-bcm63xx/bcm63xx_dev_spi.h     |    2 ++
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h  |   13 +++++++---
 drivers/spi/spi-bcm63xx.c                          |   25 ++++++++++++++++----
 4 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/arch/mips/bcm63xx/dev-spi.c b/arch/mips/bcm63xx/dev-spi.c
index 67fa45b..409f16e 100644
--- a/arch/mips/bcm63xx/dev-spi.c
+++ b/arch/mips/bcm63xx/dev-spi.c
@@ -106,11 +106,15 @@ int __init bcm63xx_spi_register(void)
 	if (BCMCPU_IS_6338() || BCMCPU_IS_6348()) {
 		spi_resources[0].end += BCM_6338_RSET_SPI_SIZE - 1;
 		spi_pdata.fifo_size = SPI_6338_MSG_DATA_SIZE;
+		spi_pdata.msg_type_shift = SPI_6338_MSG_TYPE_SHIFT;
+		spi_pdata.msg_ctl_width = SPI_6338_MSG_CTL_WIDTH;
 	}
 
 	if (BCMCPU_IS_6358() || BCMCPU_IS_6368()) {
 		spi_resources[0].end += BCM_6358_RSET_SPI_SIZE - 1;
 		spi_pdata.fifo_size = SPI_6358_MSG_DATA_SIZE;
+		spi_pdata.msg_type_shift = SPI_6358_MSG_TYPE_SHIFT;
+		spi_pdata.msg_ctl_width = SPI_6358_MSG_CTL_WIDTH;
 	}
 
 	bcm63xx_spi_regs_init();
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h
index 7d98dbe..c9bae13 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h
@@ -9,6 +9,8 @@ int __init bcm63xx_spi_register(void);
 
 struct bcm63xx_spi_pdata {
 	unsigned int	fifo_size;
+	unsigned int	msg_type_shift;
+	unsigned int	msg_ctl_width;
 	int		bus_num;
 	int		num_chipselect;
 	u32		speed_hz;
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
index c21aa34..2bc77b4 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
@@ -987,7 +987,8 @@
 #define SPI_6338_FILL_BYTE		0x07
 #define SPI_6338_MSG_TAIL		0x09
 #define SPI_6338_RX_TAIL		0x0b
-#define SPI_6338_MSG_CTL		0x40
+#define SPI_6338_MSG_CTL		0x40	/* 8-bits register */
+#define SPI_6338_MSG_CTL_WIDTH		8
 #define SPI_6338_MSG_DATA		0x41
 #define SPI_6338_MSG_DATA_SIZE		0x3f
 #define SPI_6338_RX_DATA		0x80
@@ -1003,7 +1004,8 @@
 #define SPI_6348_FILL_BYTE		0x07
 #define SPI_6348_MSG_TAIL		0x09
 #define SPI_6348_RX_TAIL		0x0b
-#define SPI_6348_MSG_CTL		0x40
+#define SPI_6348_MSG_CTL		0x40	/* 8-bits register */
+#define SPI_6348_MSG_CTL_WIDTH		8
 #define SPI_6348_MSG_DATA		0x41
 #define SPI_6348_MSG_DATA_SIZE		0x3f
 #define SPI_6348_RX_DATA		0x80
@@ -1011,6 +1013,7 @@
 
 /* BCM 6358 SPI core */
 #define SPI_6358_MSG_CTL		0x00	/* 16-bits register */
+#define SPI_6358_MSG_CTL_WIDTH		16
 #define SPI_6358_MSG_DATA		0x02
 #define SPI_6358_MSG_DATA_SIZE		0x21e
 #define SPI_6358_RX_DATA		0x400
@@ -1027,6 +1030,7 @@
 
 /* BCM 6358 SPI core */
 #define SPI_6368_MSG_CTL		0x00	/* 16-bits register */
+#define SPI_6368_MSG_CTL_WIDTH		16
 #define SPI_6368_MSG_DATA		0x02
 #define SPI_6368_MSG_DATA_SIZE		0x21e
 #define SPI_6368_RX_DATA		0x400
@@ -1048,7 +1052,10 @@
 #define SPI_HD_W			0x01
 #define SPI_HD_R			0x02
 #define SPI_BYTE_CNT_SHIFT		0
-#define SPI_MSG_TYPE_SHIFT		14
+#define SPI_6338_MSG_TYPE_SHIFT		6
+#define SPI_6348_MSG_TYPE_SHIFT		6
+#define SPI_6358_MSG_TYPE_SHIFT		14
+#define SPI_6368_MSG_TYPE_SHIFT		14
 
 /* Command */
 #define SPI_CMD_NOOP			0x00
diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 7491971..fa7360d 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -47,6 +47,8 @@ struct bcm63xx_spi {
 	/* Platform data */
 	u32			speed_hz;
 	unsigned		fifo_size;
+	unsigned int		msg_type_shift;
+	unsigned int		msg_ctl_width;
 
 	/* Data buffers */
 	const unsigned char	*tx_ptr;
@@ -221,13 +223,24 @@ static unsigned int bcm63xx_txrx_bufs(struct spi_device *spi,
 	msg_ctl = (t->len << SPI_BYTE_CNT_SHIFT);
 
 	if (t->rx_buf && t->tx_buf)
-		msg_ctl |= (SPI_FD_RW << SPI_MSG_TYPE_SHIFT);
+		msg_ctl |= (SPI_FD_RW << bs->msg_type_shift);
 	else if (t->rx_buf)
-		msg_ctl |= (SPI_HD_R << SPI_MSG_TYPE_SHIFT);
+		msg_ctl |= (SPI_HD_R << bs->msg_type_shift);
 	else if (t->tx_buf)
-		msg_ctl |= (SPI_HD_W << SPI_MSG_TYPE_SHIFT);
-
-	bcm_spi_writew(bs, msg_ctl, SPI_MSG_CTL);
+		msg_ctl |= (SPI_HD_W << bs->msg_type_shift);
+
+	switch (bs->msg_ctl_width) {
+	case 8:
+		bcm_spi_writeb(bs, msg_ctl, SPI_MSG_CTL);
+		break;
+	case 16:
+		bcm_spi_writew(bs, msg_ctl, SPI_MSG_CTL);
+		break;
+	default:
+		dev_err(&spi->dev, "unknown MSG_CTL width: %d\n",
+			bs->msg_ctl_width);
+		return 0;
+	}
 
 	/* Issue the transfer */
 	cmd = SPI_CMD_START_IMMEDIATE;
@@ -406,6 +419,8 @@ static int __devinit bcm63xx_spi_probe(struct platform_device *pdev)
 	master->transfer_one_message = bcm63xx_spi_transfer_one;
 	master->mode_bits = MODEBITS;
 	bs->speed_hz = pdata->speed_hz;
+	bs->msg_type_shift = pdata->msg_type_shift;
+	bs->msg_ctl_width = pdata->msg_ctl_width;
 	bs->tx_io = (u8 *)(bs->regs + bcm63xx_spireg(SPI_MSG_DATA));
 	bs->rx_io = (const u8 *)(bs->regs + bcm63xx_spireg(SPI_RX_DATA));
 
-- 
1.7.9.5
