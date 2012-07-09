Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jul 2012 04:48:55 +0200 (CEST)
Received: from [69.28.251.93] ([69.28.251.93]:45220 "EHLO b32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903472Ab2GICr7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 9 Jul 2012 04:47:59 +0200
Received: (qmail 24406 invoked from network); 9 Jul 2012 02:47:56 -0000
Received: from unknown (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by 127.0.0.1 with (DHE-RSA-AES128-SHA encrypted) SMTP; 9 Jul 2012 02:47:56 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Sun, 08 Jul 2012 19:47:56 -0700
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     <ffainelli@freebox.fr>, <mbizon@freebox.fr>,
        <jonas.gorski@gmail.com>, <linux-mips@linux-mips.org>
Subject: [PATCH V2 6/7] MIPS: BCM63XX: Add register and IRQ definitions for USB
 2.0 device
Date:   Sun, 08 Jul 2012 19:41:20 -0700
Message-Id: <4bd8d0a281e5678919fd10b90bb4472d@localhost>
In-Reply-To: <a4b88fe5a7ef864d5adce1145d8bbf6c@localhost>
References: <a4b88fe5a7ef864d5adce1145d8bbf6c@localhost>
User-Agent: vim 7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-archive-position: 33886
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h  |  75 ++++++++++-
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h | 147 ++++++++++++++++++++++
 2 files changed, 221 insertions(+), 1 deletion(-)

V2:

Rename USBDMA IRQs so they are closer to the ENET names.

diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
index c0e6333..1ac5704 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
@@ -120,6 +120,8 @@ enum bcm63xx_regs_set {
 	RSET_OHCI0,
 	RSET_OHCI_PRIV,
 	RSET_USBH_PRIV,
+	RSET_USBD,
+	RSET_USBDMA,
 	RSET_MPI,
 	RSET_PCMCIA,
 	RSET_PCIE,
@@ -162,6 +164,8 @@ enum bcm63xx_regs_set {
 #define RSET_UDC_SIZE			256
 #define RSET_OHCI_SIZE			256
 #define RSET_EHCI_SIZE			256
+#define RSET_USBD_SIZE			256
+#define RSET_USBDMA_SIZE		1280
 #define RSET_PCMCIA_SIZE		12
 #define RSET_M2M_SIZE			256
 #define RSET_ATM_SIZE			4096
@@ -183,10 +187,11 @@ enum bcm63xx_regs_set {
 #define BCM_6328_GPIO_BASE		(0xb0000080)
 #define BCM_6328_SPI_BASE		(0xdeadbeef)
 #define BCM_6328_UDC0_BASE		(0xdeadbeef)
-#define BCM_6328_USBDMA_BASE		(0xdeadbeef)
+#define BCM_6328_USBDMA_BASE		(0xb000c000)
 #define BCM_6328_OHCI0_BASE		(0xb0002600)
 #define BCM_6328_OHCI_PRIV_BASE		(0xdeadbeef)
 #define BCM_6328_USBH_PRIV_BASE		(0xb0002700)
+#define BCM_6328_USBD_BASE		(0xb0002400)
 #define BCM_6328_MPI_BASE		(0xdeadbeef)
 #define BCM_6328_PCMCIA_BASE		(0xdeadbeef)
 #define BCM_6328_PCIE_BASE		(0xb0e40000)
@@ -232,6 +237,7 @@ enum bcm63xx_regs_set {
 #define BCM_6338_OHCI0_BASE		(0xdeadbeef)
 #define BCM_6338_OHCI_PRIV_BASE		(0xfffe3000)
 #define BCM_6338_USBH_PRIV_BASE		(0xdeadbeef)
+#define BCM_6338_USBD_BASE		(0xdeadbeef)
 #define BCM_6338_MPI_BASE		(0xfffe3160)
 #define BCM_6338_PCMCIA_BASE		(0xdeadbeef)
 #define BCM_6338_PCIE_BASE		(0xdeadbeef)
@@ -286,6 +292,7 @@ enum bcm63xx_regs_set {
 #define BCM_6345_OHCI0_BASE		(0xfffe2100)
 #define BCM_6345_OHCI_PRIV_BASE		(0xfffe2200)
 #define BCM_6345_USBH_PRIV_BASE		(0xdeadbeef)
+#define BCM_6345_USBD_BASE		(0xdeadbeef)
 #define BCM_6345_SDRAM_REGS_BASE	(0xfffe2300)
 #define BCM_6345_DSL_BASE		(0xdeadbeef)
 #define BCM_6345_UBUS_BASE		(0xdeadbeef)
@@ -319,9 +326,11 @@ enum bcm63xx_regs_set {
 #define BCM_6348_GPIO_BASE		(0xfffe0400)
 #define BCM_6348_SPI_BASE		(0xfffe0c00)
 #define BCM_6348_UDC0_BASE		(0xfffe1000)
+#define BCM_6348_USBDMA_BASE		(0xdeadbeef)
 #define BCM_6348_OHCI0_BASE		(0xfffe1b00)
 #define BCM_6348_OHCI_PRIV_BASE		(0xfffe1c00)
 #define BCM_6348_USBH_PRIV_BASE		(0xdeadbeef)
+#define BCM_6348_USBD_BASE		(0xdeadbeef)
 #define BCM_6348_MPI_BASE		(0xfffe2000)
 #define BCM_6348_PCMCIA_BASE		(0xfffe2054)
 #define BCM_6348_PCIE_BASE		(0xdeadbeef)
@@ -362,9 +371,11 @@ enum bcm63xx_regs_set {
 #define BCM_6358_GPIO_BASE		(0xfffe0080)
 #define BCM_6358_SPI_BASE		(0xfffe0800)
 #define BCM_6358_UDC0_BASE		(0xfffe0800)
+#define BCM_6358_USBDMA_BASE		(0xdeadbeef)
 #define BCM_6358_OHCI0_BASE		(0xfffe1400)
 #define BCM_6358_OHCI_PRIV_BASE		(0xdeadbeef)
 #define BCM_6358_USBH_PRIV_BASE		(0xfffe1500)
+#define BCM_6358_USBD_BASE		(0xdeadbeef)
 #define BCM_6358_MPI_BASE		(0xfffe1000)
 #define BCM_6358_PCMCIA_BASE		(0xfffe1054)
 #define BCM_6358_PCIE_BASE		(0xdeadbeef)
@@ -406,9 +417,11 @@ enum bcm63xx_regs_set {
 #define BCM_6368_GPIO_BASE		(0xb0000080)
 #define BCM_6368_SPI_BASE		(0xb0000800)
 #define BCM_6368_UDC0_BASE		(0xdeadbeef)
+#define BCM_6368_USBDMA_BASE		(0xb0004800)
 #define BCM_6368_OHCI0_BASE		(0xb0001600)
 #define BCM_6368_OHCI_PRIV_BASE		(0xdeadbeef)
 #define BCM_6368_USBH_PRIV_BASE		(0xb0001700)
+#define BCM_6368_USBD_BASE		(0xb0001400)
 #define BCM_6368_MPI_BASE		(0xb0001000)
 #define BCM_6368_PCMCIA_BASE		(0xb0001054)
 #define BCM_6368_PCIE_BASE		(0xdeadbeef)
@@ -458,6 +471,8 @@ extern const unsigned long *bcm63xx_regs_base;
 	__GEN_RSET_BASE(__cpu, OHCI0)					\
 	__GEN_RSET_BASE(__cpu, OHCI_PRIV)				\
 	__GEN_RSET_BASE(__cpu, USBH_PRIV)				\
+	__GEN_RSET_BASE(__cpu, USBD)					\
+	__GEN_RSET_BASE(__cpu, USBDMA)					\
 	__GEN_RSET_BASE(__cpu, MPI)					\
 	__GEN_RSET_BASE(__cpu, PCMCIA)					\
 	__GEN_RSET_BASE(__cpu, PCIE)					\
@@ -499,6 +514,8 @@ extern const unsigned long *bcm63xx_regs_base;
 	[RSET_OHCI0]		= BCM_## __cpu ##_OHCI0_BASE,		\
 	[RSET_OHCI_PRIV]	= BCM_## __cpu ##_OHCI_PRIV_BASE,	\
 	[RSET_USBH_PRIV]	= BCM_## __cpu ##_USBH_PRIV_BASE,	\
+	[RSET_USBD]		= BCM_## __cpu ##_USBD_BASE,		\
+	[RSET_USBDMA]		= BCM_## __cpu ##_USBDMA_BASE,		\
 	[RSET_MPI]		= BCM_## __cpu ##_MPI_BASE,		\
 	[RSET_PCMCIA]		= BCM_## __cpu ##_PCMCIA_BASE,		\
 	[RSET_PCIE]		= BCM_## __cpu ##_PCIE_BASE,		\
@@ -569,6 +586,13 @@ enum bcm63xx_irq {
 	IRQ_ENET_PHY,
 	IRQ_OHCI0,
 	IRQ_EHCI0,
+	IRQ_USBD,
+	IRQ_USBD_RXDMA0,
+	IRQ_USBD_TXDMA0,
+	IRQ_USBD_RXDMA1,
+	IRQ_USBD_TXDMA1,
+	IRQ_USBD_RXDMA2,
+	IRQ_USBD_TXDMA2,
 	IRQ_ENET0_RXDMA,
 	IRQ_ENET0_TXDMA,
 	IRQ_ENET1_RXDMA,
@@ -604,6 +628,13 @@ enum bcm63xx_irq {
 #define BCM_6328_ENET_PHY_IRQ		(IRQ_INTERNAL_BASE + 12)
 #define BCM_6328_OHCI0_IRQ		(BCM_6328_HIGH_IRQ_BASE + 9)
 #define BCM_6328_EHCI0_IRQ		(BCM_6328_HIGH_IRQ_BASE + 10)
+#define BCM_6328_USBD_IRQ		(IRQ_INTERNAL_BASE + 4)
+#define BCM_6328_USBD_RXDMA0_IRQ	(IRQ_INTERNAL_BASE + 5)
+#define BCM_6328_USBD_TXDMA0_IRQ	(IRQ_INTERNAL_BASE + 6)
+#define BCM_6328_USBD_RXDMA1_IRQ	(IRQ_INTERNAL_BASE + 7)
+#define BCM_6328_USBD_TXDMA1_IRQ	(IRQ_INTERNAL_BASE + 8)
+#define BCM_6328_USBD_RXDMA2_IRQ	(IRQ_INTERNAL_BASE + 9)
+#define BCM_6328_USBD_TXDMA2_IRQ	(IRQ_INTERNAL_BASE + 10)
 #define BCM_6328_PCMCIA_IRQ		0
 #define BCM_6328_ENET0_RXDMA_IRQ	0
 #define BCM_6328_ENET0_TXDMA_IRQ	0
@@ -642,6 +673,13 @@ enum bcm63xx_irq {
 #define BCM_6338_ENET_PHY_IRQ		(IRQ_INTERNAL_BASE + 9)
 #define BCM_6338_OHCI0_IRQ		0
 #define BCM_6338_EHCI0_IRQ		0
+#define BCM_6338_USBD_IRQ		0
+#define BCM_6338_USBD_RXDMA0_IRQ	0
+#define BCM_6338_USBD_TXDMA0_IRQ	0
+#define BCM_6338_USBD_RXDMA1_IRQ	0
+#define BCM_6338_USBD_TXDMA1_IRQ	0
+#define BCM_6338_USBD_RXDMA2_IRQ	0
+#define BCM_6338_USBD_TXDMA2_IRQ	0
 #define BCM_6338_ENET0_RXDMA_IRQ	(IRQ_INTERNAL_BASE + 15)
 #define BCM_6338_ENET0_TXDMA_IRQ	(IRQ_INTERNAL_BASE + 16)
 #define BCM_6338_ENET1_RXDMA_IRQ	0
@@ -673,6 +711,13 @@ enum bcm63xx_irq {
 #define BCM_6345_ENET_PHY_IRQ		(IRQ_INTERNAL_BASE + 12)
 #define BCM_6345_OHCI0_IRQ		0
 #define BCM_6345_EHCI0_IRQ		0
+#define BCM_6345_USBD_IRQ		0
+#define BCM_6345_USBD_RXDMA0_IRQ	0
+#define BCM_6345_USBD_TXDMA0_IRQ	0
+#define BCM_6345_USBD_RXDMA1_IRQ	0
+#define BCM_6345_USBD_TXDMA1_IRQ	0
+#define BCM_6345_USBD_RXDMA2_IRQ	0
+#define BCM_6345_USBD_TXDMA2_IRQ	0
 #define BCM_6345_ENET0_RXDMA_IRQ	(IRQ_INTERNAL_BASE + 13 + 1)
 #define BCM_6345_ENET0_TXDMA_IRQ	(IRQ_INTERNAL_BASE + 13 + 2)
 #define BCM_6345_ENET1_RXDMA_IRQ	0
@@ -704,6 +749,13 @@ enum bcm63xx_irq {
 #define BCM_6348_ENET_PHY_IRQ		(IRQ_INTERNAL_BASE + 9)
 #define BCM_6348_OHCI0_IRQ		(IRQ_INTERNAL_BASE + 12)
 #define BCM_6348_EHCI0_IRQ		0
+#define BCM_6348_USBD_IRQ		0
+#define BCM_6348_USBD_RXDMA0_IRQ	0
+#define BCM_6348_USBD_TXDMA0_IRQ	0
+#define BCM_6348_USBD_RXDMA1_IRQ	0
+#define BCM_6348_USBD_TXDMA1_IRQ	0
+#define BCM_6348_USBD_RXDMA2_IRQ	0
+#define BCM_6348_USBD_TXDMA2_IRQ	0
 #define BCM_6348_ENET0_RXDMA_IRQ	(IRQ_INTERNAL_BASE + 20)
 #define BCM_6348_ENET0_TXDMA_IRQ	(IRQ_INTERNAL_BASE + 21)
 #define BCM_6348_ENET1_RXDMA_IRQ	(IRQ_INTERNAL_BASE + 22)
@@ -735,6 +787,13 @@ enum bcm63xx_irq {
 #define BCM_6358_ENET_PHY_IRQ		(IRQ_INTERNAL_BASE + 9)
 #define BCM_6358_OHCI0_IRQ		(IRQ_INTERNAL_BASE + 5)
 #define BCM_6358_EHCI0_IRQ		(IRQ_INTERNAL_BASE + 10)
+#define BCM_6358_USBD_IRQ		0
+#define BCM_6358_USBD_RXDMA0_IRQ	0
+#define BCM_6358_USBD_TXDMA0_IRQ	0
+#define BCM_6358_USBD_RXDMA1_IRQ	0
+#define BCM_6358_USBD_TXDMA1_IRQ	0
+#define BCM_6358_USBD_RXDMA2_IRQ	0
+#define BCM_6358_USBD_TXDMA2_IRQ	0
 #define BCM_6358_ENET0_RXDMA_IRQ	(IRQ_INTERNAL_BASE + 15)
 #define BCM_6358_ENET0_TXDMA_IRQ	(IRQ_INTERNAL_BASE + 16)
 #define BCM_6358_ENET1_RXDMA_IRQ	(IRQ_INTERNAL_BASE + 17)
@@ -775,6 +834,13 @@ enum bcm63xx_irq {
 #define BCM_6368_ENET_PHY_IRQ		(IRQ_INTERNAL_BASE + 15)
 #define BCM_6368_OHCI0_IRQ		(IRQ_INTERNAL_BASE + 5)
 #define BCM_6368_EHCI0_IRQ		(IRQ_INTERNAL_BASE + 7)
+#define BCM_6368_USBD_IRQ		(IRQ_INTERNAL_BASE + 8)
+#define BCM_6368_USBD_RXDMA0_IRQ	(IRQ_INTERNAL_BASE + 26)
+#define BCM_6368_USBD_TXDMA0_IRQ	(IRQ_INTERNAL_BASE + 27)
+#define BCM_6368_USBD_RXDMA1_IRQ	(IRQ_INTERNAL_BASE + 28)
+#define BCM_6368_USBD_TXDMA1_IRQ	(IRQ_INTERNAL_BASE + 29)
+#define BCM_6368_USBD_RXDMA2_IRQ	(IRQ_INTERNAL_BASE + 30)
+#define BCM_6368_USBD_TXDMA2_IRQ	(IRQ_INTERNAL_BASE + 31)
 #define BCM_6368_PCMCIA_IRQ		0
 #define BCM_6368_ENET0_RXDMA_IRQ	0
 #define BCM_6368_ENET0_TXDMA_IRQ	0
@@ -815,6 +881,13 @@ extern const int *bcm63xx_irqs;
 	[IRQ_ENET_PHY]		= BCM_## __cpu ##_ENET_PHY_IRQ,		\
 	[IRQ_OHCI0]		= BCM_## __cpu ##_OHCI0_IRQ,		\
 	[IRQ_EHCI0]		= BCM_## __cpu ##_EHCI0_IRQ,		\
+	[IRQ_USBD]		= BCM_## __cpu ##_USBD_IRQ,		\
+	[IRQ_USBD_RXDMA0]	= BCM_## __cpu ##_USBD_RXDMA0_IRQ,	\
+	[IRQ_USBD_TXDMA0]	= BCM_## __cpu ##_USBD_TXDMA0_IRQ,	\
+	[IRQ_USBD_RXDMA1]	= BCM_## __cpu ##_USBD_RXDMA1_IRQ,	\
+	[IRQ_USBD_TXDMA1]	= BCM_## __cpu ##_USBD_TXDMA1_IRQ,	\
+	[IRQ_USBD_RXDMA2]	= BCM_## __cpu ##_USBD_RXDMA2_IRQ,	\
+	[IRQ_USBD_TXDMA2]	= BCM_## __cpu ##_USBD_TXDMA2_IRQ,	\
 	[IRQ_ENET0_RXDMA]	= BCM_## __cpu ##_ENET0_RXDMA_IRQ,	\
 	[IRQ_ENET0_TXDMA]	= BCM_## __cpu ##_ENET0_TXDMA_IRQ,	\
 	[IRQ_ENET1_RXDMA]	= BCM_## __cpu ##_ENET1_RXDMA_IRQ,	\
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
index 29654ae..fa74a37 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
@@ -795,6 +795,12 @@
 #define USBH_PRIV_SWAP_OHCI_DATA_SHIFT	0
 #define USBH_PRIV_SWAP_OHCI_DATA_MASK	(1 << USBH_PRIV_SWAP_OHCI_DATA_SHIFT)
 
+#define USBH_PRIV_UTMI_CTL_6368_REG	0x10
+#define USBH_PRIV_UTMI_CTL_NODRIV_SHIFT	12
+#define USBH_PRIV_UTMI_CTL_NODRIV_MASK	(0xf << USBH_PRIV_UTMI_CTL_NODRIV_SHIFT)
+#define USBH_PRIV_UTMI_CTL_HOSTB_SHIFT	0
+#define USBH_PRIV_UTMI_CTL_HOSTB_MASK	(0xf << USBH_PRIV_UTMI_CTL_HOSTB_SHIFT)
+
 #define USBH_PRIV_TEST_6358_REG		0x24
 #define USBH_PRIV_TEST_6368_REG		0x14
 
@@ -803,6 +809,147 @@
 #define USBH_PRIV_SETUP_IOC_MASK	(1 << USBH_PRIV_SETUP_IOC_SHIFT)
 
 
+/*************************************************************************
+ * _REG relative to RSET_USBD
+ *************************************************************************/
+
+/* General control */
+#define USBD_CONTROL_REG		0x00
+#define USBD_CONTROL_TXZLENINS_SHIFT	14
+#define USBD_CONTROL_TXZLENINS_MASK	(1 << USBD_CONTROL_TXZLENINS_SHIFT)
+#define USBD_CONTROL_AUTO_CSRS_SHIFT	13
+#define USBD_CONTROL_AUTO_CSRS_MASK	(1 << USBD_CONTROL_AUTO_CSRS_SHIFT)
+#define USBD_CONTROL_RXZSCFG_SHIFT	12
+#define USBD_CONTROL_RXZSCFG_MASK	(1 << USBD_CONTROL_RXZSCFG_SHIFT)
+#define USBD_CONTROL_INIT_SEL_SHIFT	8
+#define USBD_CONTROL_INIT_SEL_MASK	(0xf << USBD_CONTROL_INIT_SEL_SHIFT)
+#define USBD_CONTROL_FIFO_RESET_SHIFT	6
+#define USBD_CONTROL_FIFO_RESET_MASK	(3 << USBD_CONTROL_FIFO_RESET_SHIFT)
+#define USBD_CONTROL_SETUPERRLOCK_SHIFT	5
+#define USBD_CONTROL_SETUPERRLOCK_MASK	(1 << USBD_CONTROL_SETUPERRLOCK_SHIFT)
+#define USBD_CONTROL_DONE_CSRS_SHIFT	0
+#define USBD_CONTROL_DONE_CSRS_MASK	(1 << USBD_CONTROL_DONE_CSRS_SHIFT)
+
+/* Strap options */
+#define USBD_STRAPS_REG			0x04
+#define USBD_STRAPS_APP_SELF_PWR_SHIFT	10
+#define USBD_STRAPS_APP_SELF_PWR_MASK	(1 << USBD_STRAPS_APP_SELF_PWR_SHIFT)
+#define USBD_STRAPS_APP_DISCON_SHIFT	9
+#define USBD_STRAPS_APP_DISCON_MASK	(1 << USBD_STRAPS_APP_DISCON_SHIFT)
+#define USBD_STRAPS_APP_CSRPRGSUP_SHIFT	8
+#define USBD_STRAPS_APP_CSRPRGSUP_MASK	(1 << USBD_STRAPS_APP_CSRPRGSUP_SHIFT)
+#define USBD_STRAPS_APP_RMTWKUP_SHIFT	6
+#define USBD_STRAPS_APP_RMTWKUP_MASK	(1 << USBD_STRAPS_APP_RMTWKUP_SHIFT)
+#define USBD_STRAPS_APP_RAM_IF_SHIFT	7
+#define USBD_STRAPS_APP_RAM_IF_MASK	(1 << USBD_STRAPS_APP_RAM_IF_SHIFT)
+#define USBD_STRAPS_APP_8BITPHY_SHIFT	2
+#define USBD_STRAPS_APP_8BITPHY_MASK	(1 << USBD_STRAPS_APP_8BITPHY_SHIFT)
+#define USBD_STRAPS_SPEED_SHIFT		0
+#define USBD_STRAPS_SPEED_MASK		(3 << USBD_STRAPS_SPEED_SHIFT)
+
+/* Stall control */
+#define USBD_STALL_REG			0x08
+#define USBD_STALL_UPDATE_SHIFT		7
+#define USBD_STALL_UPDATE_MASK		(1 << USBD_STALL_UPDATE_SHIFT)
+#define USBD_STALL_ENABLE_SHIFT		6
+#define USBD_STALL_ENABLE_MASK		(1 << USBD_STALL_ENABLE_SHIFT)
+#define USBD_STALL_EPNUM_SHIFT		0
+#define USBD_STALL_EPNUM_MASK		(0xf << USBD_STALL_EPNUM_SHIFT)
+
+/* General status */
+#define USBD_STATUS_REG			0x0c
+#define USBD_STATUS_SOF_SHIFT		16
+#define USBD_STATUS_SOF_MASK		(0x7ff << USBD_STATUS_SOF_SHIFT)
+#define USBD_STATUS_SPD_SHIFT		12
+#define USBD_STATUS_SPD_MASK		(3 << USBD_STATUS_SPD_SHIFT)
+#define USBD_STATUS_ALTINTF_SHIFT	8
+#define USBD_STATUS_ALTINTF_MASK	(0xf << USBD_STATUS_ALTINTF_SHIFT)
+#define USBD_STATUS_INTF_SHIFT		4
+#define USBD_STATUS_INTF_MASK		(0xf << USBD_STATUS_INTF_SHIFT)
+#define USBD_STATUS_CFG_SHIFT		0
+#define USBD_STATUS_CFG_MASK		(0xf << USBD_STATUS_CFG_SHIFT)
+
+/* Other events */
+#define USBD_EVENTS_REG			0x10
+#define USBD_EVENTS_USB_LINK_SHIFT	10
+#define USBD_EVENTS_USB_LINK_MASK	(1 << USBD_EVENTS_USB_LINK_SHIFT)
+
+/* IRQ status */
+#define USBD_EVENT_IRQ_STATUS_REG	0x14
+
+/* IRQ level (2 bits per IRQ event) */
+#define USBD_EVENT_IRQ_CFG_HI_REG	0x18
+
+#define USBD_EVENT_IRQ_CFG_LO_REG	0x1c
+
+#define USBD_EVENT_IRQ_CFG_SHIFT(x)	((x & 0xf) << 1)
+#define USBD_EVENT_IRQ_CFG_MASK(x)	(3 << USBD_EVENT_IRQ_CFG_SHIFT(x))
+#define USBD_EVENT_IRQ_CFG_RISING(x)	(0 << USBD_EVENT_IRQ_CFG_SHIFT(x))
+#define USBD_EVENT_IRQ_CFG_FALLING(x)	(1 << USBD_EVENT_IRQ_CFG_SHIFT(x))
+
+/* IRQ mask (1=unmasked) */
+#define USBD_EVENT_IRQ_MASK_REG		0x20
+
+/* IRQ bits */
+#define USBD_EVENT_IRQ_USB_LINK		10
+#define USBD_EVENT_IRQ_SETCFG		9
+#define USBD_EVENT_IRQ_SETINTF		8
+#define USBD_EVENT_IRQ_ERRATIC_ERR	7
+#define USBD_EVENT_IRQ_SET_CSRS		6
+#define USBD_EVENT_IRQ_SUSPEND		5
+#define USBD_EVENT_IRQ_EARLY_SUSPEND	4
+#define USBD_EVENT_IRQ_SOF		3
+#define USBD_EVENT_IRQ_ENUM_ON		2
+#define USBD_EVENT_IRQ_SETUP		1
+#define USBD_EVENT_IRQ_USB_RESET	0
+
+/* TX FIFO partitioning */
+#define USBD_TXFIFO_CONFIG_REG		0x40
+#define USBD_TXFIFO_CONFIG_END_SHIFT	16
+#define USBD_TXFIFO_CONFIG_END_MASK	(0xff << USBD_TXFIFO_CONFIG_END_SHIFT)
+#define USBD_TXFIFO_CONFIG_START_SHIFT	0
+#define USBD_TXFIFO_CONFIG_START_MASK	(0xff << USBD_TXFIFO_CONFIG_START_SHIFT)
+
+/* RX FIFO partitioning */
+#define USBD_RXFIFO_CONFIG_REG		0x44
+#define USBD_RXFIFO_CONFIG_END_SHIFT	16
+#define USBD_RXFIFO_CONFIG_END_MASK	(0xff << USBD_TXFIFO_CONFIG_END_SHIFT)
+#define USBD_RXFIFO_CONFIG_START_SHIFT	0
+#define USBD_RXFIFO_CONFIG_START_MASK	(0xff << USBD_TXFIFO_CONFIG_START_SHIFT)
+
+/* TX FIFO/endpoint configuration */
+#define USBD_TXFIFO_EPSIZE_REG		0x48
+
+/* RX FIFO/endpoint configuration */
+#define USBD_RXFIFO_EPSIZE_REG		0x4c
+
+/* Endpoint<->DMA mappings */
+#define USBD_EPNUM_TYPEMAP_REG		0x50
+#define USBD_EPNUM_TYPEMAP_TYPE_SHIFT	8
+#define USBD_EPNUM_TYPEMAP_TYPE_MASK	(0x3 << USBD_EPNUM_TYPEMAP_TYPE_SHIFT)
+#define USBD_EPNUM_TYPEMAP_DMA_CH_SHIFT	0
+#define USBD_EPNUM_TYPEMAP_DMA_CH_MASK	(0xf << USBD_EPNUM_TYPEMAP_DMACH_SHIFT)
+
+/* Misc per-endpoint settings */
+#define USBD_CSR_SETUPADDR_REG		0x80
+#define USBD_CSR_SETUPADDR_DEF		0xb550
+
+#define USBD_CSR_EP_REG(x)		(0x84 + (x) * 4)
+#define USBD_CSR_EP_MAXPKT_SHIFT	19
+#define USBD_CSR_EP_MAXPKT_MASK		(0x7ff << USBD_CSR_EP_MAXPKT_SHIFT)
+#define USBD_CSR_EP_ALTIFACE_SHIFT	15
+#define USBD_CSR_EP_ALTIFACE_MASK	(0xf << USBD_CSR_EP_ALTIFACE_SHIFT)
+#define USBD_CSR_EP_IFACE_SHIFT		11
+#define USBD_CSR_EP_IFACE_MASK		(0xf << USBD_CSR_EP_IFACE_SHIFT)
+#define USBD_CSR_EP_CFG_SHIFT		7
+#define USBD_CSR_EP_CFG_MASK		(0xf << USBD_CSR_EP_CFG_SHIFT)
+#define USBD_CSR_EP_TYPE_SHIFT		5
+#define USBD_CSR_EP_TYPE_MASK		(3 << USBD_CSR_EP_TYPE_SHIFT)
+#define USBD_CSR_EP_DIR_SHIFT		4
+#define USBD_CSR_EP_DIR_MASK		(1 << USBD_CSR_EP_DIR_SHIFT)
+#define USBD_CSR_EP_LOG_SHIFT		0
+#define USBD_CSR_EP_LOG_MASK		(0xf << USBD_CSR_EP_LOG_SHIFT)
+
 
 /*************************************************************************
  * _REG relative to RSET_MPI
-- 
1.7.11.1
