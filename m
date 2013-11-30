Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Nov 2013 12:46:50 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:35116 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6867262Ab3K3LpqoSns2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 30 Nov 2013 12:45:46 +0100
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 908F1283F6D;
        Sat, 30 Nov 2013 12:43:44 +0100 (CET)
X-Virus-Scanned: at arrakis.dune.hu
Received: from shaker64.lan (dslb-088-073-137-004.pools.arcor-ip.net [88.73.137.4])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 07412280153;
        Sat, 30 Nov 2013 12:43:42 +0100 (CET)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org, linux-spi@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Mark Brown <broonie@kernel.org>,
        John Crispin <blogic@openwrt.org>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH 3/5] MIPS: BCM63XX: add HSSPI IRQ and register offsets
Date:   Sat, 30 Nov 2013 12:42:04 +0100
Message-Id: <1385811726-6746-4-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.8.4.rc3
In-Reply-To: <1385811726-6746-1-git-send-email-jogo@openwrt.org>
References: <1385811726-6746-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38617
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

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
index 19f9134..3112f08 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
@@ -145,6 +145,7 @@ enum bcm63xx_regs_set {
 	RSET_UART1,
 	RSET_GPIO,
 	RSET_SPI,
+	RSET_HSSPI,
 	RSET_UDC0,
 	RSET_OHCI0,
 	RSET_OHCI_PRIV,
@@ -193,6 +194,7 @@ enum bcm63xx_regs_set {
 #define RSET_ENETDMAS_SIZE(chans)	(16 * (chans))
 #define RSET_ENETSW_SIZE		65536
 #define RSET_UART_SIZE			24
+#define RSET_HSSPI_SIZE			1536
 #define RSET_UDC_SIZE			256
 #define RSET_OHCI_SIZE			256
 #define RSET_EHCI_SIZE			256
@@ -265,6 +267,7 @@ enum bcm63xx_regs_set {
 #define BCM_6328_UART1_BASE		(0xb0000120)
 #define BCM_6328_GPIO_BASE		(0xb0000080)
 #define BCM_6328_SPI_BASE		(0xdeadbeef)
+#define BCM_6328_HSSPI_BASE		(0xb0001000)
 #define BCM_6328_UDC0_BASE		(0xdeadbeef)
 #define BCM_6328_USBDMA_BASE		(0xb000c000)
 #define BCM_6328_OHCI0_BASE		(0xb0002600)
@@ -313,6 +316,7 @@ enum bcm63xx_regs_set {
 #define BCM_6338_UART1_BASE		(0xdeadbeef)
 #define BCM_6338_GPIO_BASE		(0xfffe0400)
 #define BCM_6338_SPI_BASE		(0xfffe0c00)
+#define BCM_6338_HSSPI_BASE		(0xdeadbeef)
 #define BCM_6338_UDC0_BASE		(0xdeadbeef)
 #define BCM_6338_USBDMA_BASE		(0xfffe2400)
 #define BCM_6338_OHCI0_BASE		(0xdeadbeef)
@@ -360,6 +364,7 @@ enum bcm63xx_regs_set {
 #define BCM_6345_UART1_BASE		(0xdeadbeef)
 #define BCM_6345_GPIO_BASE		(0xfffe0400)
 #define BCM_6345_SPI_BASE		(0xdeadbeef)
+#define BCM_6345_HSSPI_BASE		(0xdeadbeef)
 #define BCM_6345_UDC0_BASE		(0xdeadbeef)
 #define BCM_6345_USBDMA_BASE		(0xfffe2800)
 #define BCM_6345_ENET0_BASE		(0xfffe1800)
@@ -406,6 +411,7 @@ enum bcm63xx_regs_set {
 #define BCM_6348_UART1_BASE		(0xdeadbeef)
 #define BCM_6348_GPIO_BASE		(0xfffe0400)
 #define BCM_6348_SPI_BASE		(0xfffe0c00)
+#define BCM_6348_HSSPI_BASE		(0xdeadbeef)
 #define BCM_6348_UDC0_BASE		(0xfffe1000)
 #define BCM_6348_USBDMA_BASE		(0xdeadbeef)
 #define BCM_6348_OHCI0_BASE		(0xfffe1b00)
@@ -451,6 +457,7 @@ enum bcm63xx_regs_set {
 #define BCM_6358_UART1_BASE		(0xfffe0120)
 #define BCM_6358_GPIO_BASE		(0xfffe0080)
 #define BCM_6358_SPI_BASE		(0xfffe0800)
+#define BCM_6358_HSSPI_BASE		(0xdeadbeef)
 #define BCM_6358_UDC0_BASE		(0xfffe0800)
 #define BCM_6358_USBDMA_BASE		(0xdeadbeef)
 #define BCM_6358_OHCI0_BASE		(0xfffe1400)
@@ -553,6 +560,7 @@ enum bcm63xx_regs_set {
 #define BCM_6368_UART1_BASE		(0xb0000120)
 #define BCM_6368_GPIO_BASE		(0xb0000080)
 #define BCM_6368_SPI_BASE		(0xb0000800)
+#define BCM_6368_HSSPI_BASE		(0xdeadbeef)
 #define BCM_6368_UDC0_BASE		(0xdeadbeef)
 #define BCM_6368_USBDMA_BASE		(0xb0004800)
 #define BCM_6368_OHCI0_BASE		(0xb0001600)
@@ -604,6 +612,7 @@ extern const unsigned long *bcm63xx_regs_base;
 	__GEN_RSET_BASE(__cpu, UART1)					\
 	__GEN_RSET_BASE(__cpu, GPIO)					\
 	__GEN_RSET_BASE(__cpu, SPI)					\
+	__GEN_RSET_BASE(__cpu, HSSPI)					\
 	__GEN_RSET_BASE(__cpu, UDC0)					\
 	__GEN_RSET_BASE(__cpu, OHCI0)					\
 	__GEN_RSET_BASE(__cpu, OHCI_PRIV)				\
@@ -647,6 +656,7 @@ extern const unsigned long *bcm63xx_regs_base;
 	[RSET_UART1]		= BCM_## __cpu ##_UART1_BASE,		\
 	[RSET_GPIO]		= BCM_## __cpu ##_GPIO_BASE,		\
 	[RSET_SPI]		= BCM_## __cpu ##_SPI_BASE,		\
+	[RSET_HSSPI]		= BCM_## __cpu ##_HSSPI_BASE,		\
 	[RSET_UDC0]		= BCM_## __cpu ##_UDC0_BASE,		\
 	[RSET_OHCI0]		= BCM_## __cpu ##_OHCI0_BASE,		\
 	[RSET_OHCI_PRIV]	= BCM_## __cpu ##_OHCI_PRIV_BASE,	\
@@ -727,6 +737,7 @@ enum bcm63xx_irq {
 	IRQ_ENET0,
 	IRQ_ENET1,
 	IRQ_ENET_PHY,
+	IRQ_HSSPI,
 	IRQ_OHCI0,
 	IRQ_EHCI0,
 	IRQ_USBD,
@@ -815,6 +826,7 @@ enum bcm63xx_irq {
 #define BCM_6328_ENET0_IRQ		0
 #define BCM_6328_ENET1_IRQ		0
 #define BCM_6328_ENET_PHY_IRQ		(IRQ_INTERNAL_BASE + 12)
+#define BCM_6328_HSSPI_IRQ		(IRQ_INTERNAL_BASE + 29)
 #define BCM_6328_OHCI0_IRQ		(BCM_6328_HIGH_IRQ_BASE + 9)
 #define BCM_6328_EHCI0_IRQ		(BCM_6328_HIGH_IRQ_BASE + 10)
 #define BCM_6328_USBD_IRQ		(IRQ_INTERNAL_BASE + 4)
@@ -860,6 +872,7 @@ enum bcm63xx_irq {
 #define BCM_6338_ENET0_IRQ		(IRQ_INTERNAL_BASE + 8)
 #define BCM_6338_ENET1_IRQ		0
 #define BCM_6338_ENET_PHY_IRQ		(IRQ_INTERNAL_BASE + 9)
+#define BCM_6338_HSSPI_IRQ		0
 #define BCM_6338_OHCI0_IRQ		0
 #define BCM_6338_EHCI0_IRQ		0
 #define BCM_6338_USBD_IRQ		0
@@ -898,6 +911,7 @@ enum bcm63xx_irq {
 #define BCM_6345_ENET0_IRQ		(IRQ_INTERNAL_BASE + 8)
 #define BCM_6345_ENET1_IRQ		0
 #define BCM_6345_ENET_PHY_IRQ		(IRQ_INTERNAL_BASE + 12)
+#define BCM_6345_HSSPI_IRQ		0
 #define BCM_6345_OHCI0_IRQ		0
 #define BCM_6345_EHCI0_IRQ		0
 #define BCM_6345_USBD_IRQ		0
@@ -936,6 +950,7 @@ enum bcm63xx_irq {
 #define BCM_6348_ENET0_IRQ		(IRQ_INTERNAL_BASE + 8)
 #define BCM_6348_ENET1_IRQ		(IRQ_INTERNAL_BASE + 7)
 #define BCM_6348_ENET_PHY_IRQ		(IRQ_INTERNAL_BASE + 9)
+#define BCM_6348_HSSPI_IRQ		0
 #define BCM_6348_OHCI0_IRQ		(IRQ_INTERNAL_BASE + 12)
 #define BCM_6348_EHCI0_IRQ		0
 #define BCM_6348_USBD_IRQ		0
@@ -974,6 +989,7 @@ enum bcm63xx_irq {
 #define BCM_6358_ENET0_IRQ		(IRQ_INTERNAL_BASE + 8)
 #define BCM_6358_ENET1_IRQ		(IRQ_INTERNAL_BASE + 6)
 #define BCM_6358_ENET_PHY_IRQ		(IRQ_INTERNAL_BASE + 9)
+#define BCM_6358_HSSPI_IRQ		0
 #define BCM_6358_OHCI0_IRQ		(IRQ_INTERNAL_BASE + 5)
 #define BCM_6358_EHCI0_IRQ		(IRQ_INTERNAL_BASE + 10)
 #define BCM_6358_USBD_IRQ		0
@@ -1086,6 +1102,7 @@ enum bcm63xx_irq {
 #define BCM_6368_ENET0_IRQ		0
 #define BCM_6368_ENET1_IRQ		0
 #define BCM_6368_ENET_PHY_IRQ		(IRQ_INTERNAL_BASE + 15)
+#define BCM_6368_HSSPI_IRQ		0
 #define BCM_6368_OHCI0_IRQ		(IRQ_INTERNAL_BASE + 5)
 #define BCM_6368_EHCI0_IRQ		(IRQ_INTERNAL_BASE + 7)
 #define BCM_6368_USBD_IRQ		(IRQ_INTERNAL_BASE + 8)
@@ -1133,6 +1150,7 @@ extern const int *bcm63xx_irqs;
 	[IRQ_ENET0]		= BCM_## __cpu ##_ENET0_IRQ,		\
 	[IRQ_ENET1]		= BCM_## __cpu ##_ENET1_IRQ,		\
 	[IRQ_ENET_PHY]		= BCM_## __cpu ##_ENET_PHY_IRQ,		\
+	[IRQ_HSSPI]		= BCM_## __cpu ##_HSSPI_IRQ,		\
 	[IRQ_OHCI0]		= BCM_## __cpu ##_OHCI0_IRQ,		\
 	[IRQ_EHCI0]		= BCM_## __cpu ##_EHCI0_IRQ,		\
 	[IRQ_USBD]		= BCM_## __cpu ##_USBD_IRQ,		\
-- 
1.8.4.rc3
