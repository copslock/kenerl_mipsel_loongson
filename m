Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Mar 2013 16:03:53 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:37233 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817032Ab3CUPDwA9xED (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 21 Mar 2013 16:03:52 +0100
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Z1D6HKYXsLae; Thu, 21 Mar 2013 16:03:19 +0100 (CET)
Received: from shaker64.lan (dslb-088-073-029-203.pools.arcor-ip.net [88.73.29.203])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 0D76A2815AD;
        Thu, 21 Mar 2013 16:03:19 +0100 (CET)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 1/7] MIPS: BCM63XX: remove duplicate spi register definitions
Date:   Thu, 21 Mar 2013 16:03:14 +0100
Message-Id: <1363878200-4523-1-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1363878001-4461-1-git-send-email-jogo@openwrt.org>
References: <1363878001-4461-1-git-send-email-jogo@openwrt.org>
X-archive-position: 35929
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
Return-Path: <linux-mips-bounce@linux-mips.org>

BCM6338 and BCM6348, and BCM6358 and everything after that share the
same register layout. To not have to redefine them for each new chip
and keep the code size small, only use the definitions for the first
chip with the certain layout.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/bcm63xx/dev-spi.c                        |   24 +++---------
 .../include/asm/mach-bcm63xx/bcm63xx_dev_spi.h     |   10 +----
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h  |   40 +-------------------
 3 files changed, 10 insertions(+), 64 deletions(-)

diff --git a/arch/mips/bcm63xx/dev-spi.c b/arch/mips/bcm63xx/dev-spi.c
index f1c9c3e..2a43825 100644
--- a/arch/mips/bcm63xx/dev-spi.c
+++ b/arch/mips/bcm63xx/dev-spi.c
@@ -22,10 +22,6 @@
 /*
  * register offsets
  */
-static const unsigned long bcm6338_regs_spi[] = {
-	__GEN_SPI_REGS_TABLE(6338)
-};
-
 static const unsigned long bcm6348_regs_spi[] = {
 	__GEN_SPI_REGS_TABLE(6348)
 };
@@ -34,23 +30,15 @@ static const unsigned long bcm6358_regs_spi[] = {
 	__GEN_SPI_REGS_TABLE(6358)
 };
 
-static const unsigned long bcm6368_regs_spi[] = {
-	__GEN_SPI_REGS_TABLE(6368)
-};
-
 const unsigned long *bcm63xx_regs_spi;
 EXPORT_SYMBOL(bcm63xx_regs_spi);
 
 static __init void bcm63xx_spi_regs_init(void)
 {
-	if (BCMCPU_IS_6338())
-		bcm63xx_regs_spi = bcm6338_regs_spi;
-	if (BCMCPU_IS_6348())
+	if (BCMCPU_IS_6338() || BCMCPU_IS_6348())
 		bcm63xx_regs_spi = bcm6348_regs_spi;
-	if (BCMCPU_IS_6358())
+	if (BCMCPU_IS_6358() || BCMCPU_IS_6368())
 		bcm63xx_regs_spi = bcm6358_regs_spi;
-	if (BCMCPU_IS_6368())
-		bcm63xx_regs_spi = bcm6368_regs_spi;
 }
 #else
 static __init void bcm63xx_spi_regs_init(void) { }
@@ -104,10 +92,10 @@ int __init bcm63xx_spi_register(void)
 	spi_resources[1].start = bcm63xx_get_irq_number(IRQ_SPI);
 
 	if (BCMCPU_IS_6338() || BCMCPU_IS_6348()) {
-		spi_resources[0].end += BCM_6338_RSET_SPI_SIZE - 1;
-		spi_pdata.fifo_size = SPI_6338_MSG_DATA_SIZE;
-		spi_pdata.msg_type_shift = SPI_6338_MSG_TYPE_SHIFT;
-		spi_pdata.msg_ctl_width = SPI_6338_MSG_CTL_WIDTH;
+		spi_resources[0].end += BCM_6348_RSET_SPI_SIZE - 1;
+		spi_pdata.fifo_size = SPI_6348_MSG_DATA_SIZE;
+		spi_pdata.msg_type_shift = SPI_6348_MSG_TYPE_SHIFT;
+		spi_pdata.msg_ctl_width = SPI_6348_MSG_CTL_WIDTH;
 	}
 
 	if (BCMCPU_IS_6358() || BCMCPU_IS_6368()) {
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h
index c9bae13..cc15f7c 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h
@@ -72,18 +72,12 @@ static inline unsigned long bcm63xx_spireg(enum bcm63xx_regs_spi reg)
 
 	return bcm63xx_regs_spi[reg];
 #else
-#ifdef CONFIG_BCM63XX_CPU_6338
-	__GEN_SPI_RSET(6338)
-#endif
-#ifdef CONFIG_BCM63XX_CPU_6348
+#if defined(CONFIG_BCM63XX_CPU_6338) || defined(CONFIG_BCM63XX_CPU_6348)
 	__GEN_SPI_RSET(6348)
 #endif
-#ifdef CONFIG_BCM63XX_CPU_6358
+#if defined(CONFIG_BCM63XX_CPU_6358) || defined(CONFIG_BCM63XX_CPU_6368)
 	__GEN_SPI_RSET(6358)
 #endif
-#ifdef CONFIG_BCM63XX_CPU_6368
-	__GEN_SPI_RSET(6368)
-#endif
 #endif
 	return 0;
 }
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
index 81b4702..acd1f93 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
@@ -1223,24 +1223,7 @@
  * _REG relative to RSET_SPI
  *************************************************************************/
 
-/* BCM 6338 SPI core */
-#define SPI_6338_CMD			0x00	/* 16-bits register */
-#define SPI_6338_INT_STATUS		0x02
-#define SPI_6338_INT_MASK_ST		0x03
-#define SPI_6338_INT_MASK		0x04
-#define SPI_6338_ST			0x05
-#define SPI_6338_CLK_CFG		0x06
-#define SPI_6338_FILL_BYTE		0x07
-#define SPI_6338_MSG_TAIL		0x09
-#define SPI_6338_RX_TAIL		0x0b
-#define SPI_6338_MSG_CTL		0x40	/* 8-bits register */
-#define SPI_6338_MSG_CTL_WIDTH		8
-#define SPI_6338_MSG_DATA		0x41
-#define SPI_6338_MSG_DATA_SIZE		0x3f
-#define SPI_6338_RX_DATA		0x80
-#define SPI_6338_RX_DATA_SIZE		0x3f
-
-/* BCM 6348 SPI core */
+/* BCM 6338/6348 SPI core */
 #define SPI_6348_CMD			0x00	/* 16-bits register */
 #define SPI_6348_INT_STATUS		0x02
 #define SPI_6348_INT_MASK_ST		0x03
@@ -1257,7 +1240,7 @@
 #define SPI_6348_RX_DATA		0x80
 #define SPI_6348_RX_DATA_SIZE		0x3f
 
-/* BCM 6358 SPI core */
+/* BCM 6358/6368 SPI core */
 #define SPI_6358_MSG_CTL		0x00	/* 16-bits register */
 #define SPI_6358_MSG_CTL_WIDTH		16
 #define SPI_6358_MSG_DATA		0x02
@@ -1274,23 +1257,6 @@
 #define SPI_6358_MSG_TAIL		0x709
 #define SPI_6358_RX_TAIL		0x70B
 
-/* BCM 6358 SPI core */
-#define SPI_6368_MSG_CTL		0x00	/* 16-bits register */
-#define SPI_6368_MSG_CTL_WIDTH		16
-#define SPI_6368_MSG_DATA		0x02
-#define SPI_6368_MSG_DATA_SIZE		0x21e
-#define SPI_6368_RX_DATA		0x400
-#define SPI_6368_RX_DATA_SIZE		0x220
-#define SPI_6368_CMD			0x700	/* 16-bits register */
-#define SPI_6368_INT_STATUS		0x702
-#define SPI_6368_INT_MASK_ST		0x703
-#define SPI_6368_INT_MASK		0x704
-#define SPI_6368_ST			0x705
-#define SPI_6368_CLK_CFG		0x706
-#define SPI_6368_FILL_BYTE		0x707
-#define SPI_6368_MSG_TAIL		0x709
-#define SPI_6368_RX_TAIL		0x70B
-
 /* Shared SPI definitions */
 
 /* Message configuration */
@@ -1298,10 +1264,8 @@
 #define SPI_HD_W			0x01
 #define SPI_HD_R			0x02
 #define SPI_BYTE_CNT_SHIFT		0
-#define SPI_6338_MSG_TYPE_SHIFT		6
 #define SPI_6348_MSG_TYPE_SHIFT		6
 #define SPI_6358_MSG_TYPE_SHIFT		14
-#define SPI_6368_MSG_TYPE_SHIFT		14
 
 /* Command */
 #define SPI_CMD_NOOP			0x00
-- 
1.7.10.4
