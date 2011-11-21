Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Nov 2011 10:18:12 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:51162 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903707Ab1KUJOz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 21 Nov 2011 10:14:55 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 610763B1CE2;
        Mon, 21 Nov 2011 10:14:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id k5qK1Zlz4Hij; Mon, 21 Nov 2011 10:14:54 +0100 (CET)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id F3D653B1AF0;
        Mon, 21 Nov 2011 10:14:53 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 6/9] MIPS: BCM63XX: define internal registers offsets of the SPI controller
Date:   Mon, 21 Nov 2011 10:14:18 +0100
Message-Id: <1321866861-14340-7-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1321866861-14340-1-git-send-email-florian@openwrt.org>
References: <1321866861-14340-1-git-send-email-florian@openwrt.org>
X-archive-position: 31848
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17044

BCM6338, BCM6348, BCM6358 and BCM6368 basically use the same SPI controller
though the internal registers are shuffled, which still allows a common
driver to drive that IP block.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h |  120 +++++++++++++++++++++
 1 files changed, 120 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
index 94d4faa..5dc026a 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
@@ -973,4 +973,124 @@
 #define M2M_SRCID_REG(x)		((x) * 0x40 + 0x14)
 #define M2M_DSTID_REG(x)		((x) * 0x40 + 0x18)
 
+/*************************************************************************
+ * _REG relative to RSET_SPI
+ *************************************************************************/
+
+/* BCM 6338 SPI core */
+#define SPI_6338_CMD			0x00	/* 16-bits register */
+#define SPI_6338_INT_STATUS		0x02
+#define SPI_6338_INT_MASK_ST		0x03
+#define SPI_6338_INT_MASK		0x04
+#define SPI_6338_ST			0x05
+#define SPI_6338_CLK_CFG		0x06
+#define SPI_6338_FILL_BYTE		0x07
+#define SPI_6338_MSG_TAIL		0x09
+#define SPI_6338_RX_TAIL		0x0b
+#define SPI_6338_MSG_CTL		0x40
+#define SPI_6338_MSG_DATA		0x41
+#define SPI_6338_MSG_DATA_SIZE		0x3f
+#define SPI_6338_RX_DATA		0x80
+#define SPI_6338_RX_DATA_SIZE		0x3f
+
+/* BCM 6348 SPI core */
+#define SPI_6348_CMD			0x00	/* 16-bits register */
+#define SPI_6348_INT_STATUS		0x02
+#define SPI_6348_INT_MASK_ST		0x03
+#define SPI_6348_INT_MASK		0x04
+#define SPI_6348_ST			0x05
+#define SPI_6348_CLK_CFG		0x06
+#define SPI_6348_FILL_BYTE		0x07
+#define SPI_6348_MSG_TAIL		0x09
+#define SPI_6348_RX_TAIL		0x0b
+#define SPI_6348_MSG_CTL		0x40
+#define SPI_6348_MSG_DATA		0x41
+#define SPI_6348_MSG_DATA_SIZE		0x3f
+#define SPI_6348_RX_DATA		0x80
+#define SPI_6348_RX_DATA_SIZE		0x3f
+
+/* BCM 6358 SPI core */
+#define SPI_6358_MSG_CTL		0x00	/* 16-bits register */
+#define SPI_6358_MSG_DATA		0x02
+#define SPI_6358_MSG_DATA_SIZE		0x21e
+#define SPI_6358_RX_DATA		0x400
+#define SPI_6358_RX_DATA_SIZE		0x220
+#define SPI_6358_CMD			0x700	/* 16-bits register */
+#define SPI_6358_INT_STATUS		0x702
+#define SPI_6358_INT_MASK_ST		0x703
+#define SPI_6358_INT_MASK		0x704
+#define SPI_6358_ST			0x705
+#define SPI_6358_CLK_CFG		0x706
+#define SPI_6358_FILL_BYTE		0x707
+#define SPI_6358_MSG_TAIL		0x709
+#define SPI_6358_RX_TAIL		0x70B
+
+/* BCM 6358 SPI core */
+#define SPI_6368_MSG_CTL		0x00	/* 16-bits register */
+#define SPI_6368_MSG_DATA		0x02
+#define SPI_6368_MSG_DATA_SIZE		0x21e
+#define SPI_6368_RX_DATA		0x400
+#define SPI_6368_RX_DATA_SIZE		0x220
+#define SPI_6368_CMD			0x700	/* 16-bits register */
+#define SPI_6368_INT_STATUS		0x702
+#define SPI_6368_INT_MASK_ST		0x703
+#define SPI_6368_INT_MASK		0x704
+#define SPI_6368_ST			0x705
+#define SPI_6368_CLK_CFG		0x706
+#define SPI_6368_FILL_BYTE		0x707
+#define SPI_6368_MSG_TAIL		0x709
+#define SPI_6368_RX_TAIL		0x70B
+
+/* Shared SPI definitions */
+
+/* Message configuration */
+#define SPI_FD_RW			0x00
+#define SPI_HD_W			0x01
+#define SPI_HD_R			0x02
+#define SPI_BYTE_CNT_SHIFT		0
+#define SPI_MSG_TYPE_SHIFT		14
+
+/* Command */
+#define SPI_CMD_NOOP			0x00
+#define SPI_CMD_SOFT_RESET		0x01
+#define SPI_CMD_HARD_RESET		0x02
+#define SPI_CMD_START_IMMEDIATE		0x03
+#define SPI_CMD_COMMAND_SHIFT		0
+#define SPI_CMD_COMMAND_MASK		0x000f
+#define SPI_CMD_DEVICE_ID_SHIFT		4
+#define SPI_CMD_PREPEND_BYTE_CNT_SHIFT	8
+#define SPI_CMD_ONE_BYTE_SHIFT		11
+#define SPI_CMD_ONE_WIRE_SHIFT		12
+#define SPI_DEV_ID_0			0
+#define SPI_DEV_ID_1			1
+#define SPI_DEV_ID_2			2
+#define SPI_DEV_ID_3			3
+
+/* Interrupt mask */
+#define SPI_INTR_CMD_DONE		0x01
+#define SPI_INTR_RX_OVERFLOW		0x02
+#define SPI_INTR_TX_UNDERFLOW		0x04
+#define SPI_INTR_TX_OVERFLOW		0x08
+#define SPI_INTR_RX_UNDERFLOW		0x10
+#define SPI_INTR_CLEAR_ALL		0x1f
+
+/* Status */
+#define SPI_RX_EMPTY			0x02
+#define SPI_CMD_BUSY			0x04
+#define SPI_SERIAL_BUSY			0x08
+
+/* Clock configuration */
+#define SPI_CLK_20MHZ			0x00
+#define SPI_CLK_0_391MHZ		0x01
+#define SPI_CLK_0_781MHZ		0x02 /* default */
+#define SPI_CLK_1_563MHZ		0x03
+#define SPI_CLK_3_125MHZ		0x04
+#define SPI_CLK_6_250MHZ		0x05
+#define SPI_CLK_12_50MHZ		0x06
+#define SPI_CLK_25MHZ			0x07
+#define SPI_CLK_MASK			0x07
+#define SPI_SSOFFTIME_MASK		0x38
+#define SPI_SSOFFTIME_SHIFT		3
+#define SPI_BYTE_SWAP			0x80
+
 #endif /* BCM63XX_REGS_H_ */
-- 
1.7.5.4
