Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jun 2011 23:49:41 +0200 (CEST)
Received: from smtp4-g21.free.fr ([212.27.42.4]:52674 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491139Ab1FJVrn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 10 Jun 2011 23:47:43 +0200
Received: from bobafett.staff.proxad.net (unknown [213.228.1.121])
        by smtp4-g21.free.fr (Postfix) with ESMTP id 492294C8168;
        Fri, 10 Jun 2011 23:47:38 +0200 (CEST)
Received: from sakura.staff.proxad.net (unknown [172.18.3.156])
        by bobafett.staff.proxad.net (Postfix) with ESMTP id CD634180660;
        Fri, 10 Jun 2011 23:47:30 +0200 (CEST)
Received: by sakura.staff.proxad.net (Postfix, from userid 1000)
        id BCE6555AEB4; Fri, 10 Jun 2011 23:47:30 +0200 (CEST)
From:   Maxime Bizon <mbizon@freebox.fr>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, florian@openwrt.org,
        Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH 06/11] MIPS: BCM63XX: add more register sets & missing register definitions.
Date:   Fri, 10 Jun 2011 23:47:16 +0200
Message-Id: <1307742441-28284-7-git-send-email-mbizon@freebox.fr>
X-Mailer: git-send-email 1.7.1.1
In-Reply-To: <1307742441-28284-1-git-send-email-mbizon@freebox.fr>
References: <1307742441-28284-1-git-send-email-mbizon@freebox.fr>
X-archive-position: 30330
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9575

Needed for upcoming 6368 CPU support.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
---
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h  |  183 +++++++++++++++++++++
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h |   78 +++++++++
 2 files changed, 261 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
index 464f948..ce6b3ca 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
@@ -88,6 +88,7 @@ enum bcm63xx_regs_set {
 	RSET_UART1,
 	RSET_GPIO,
 	RSET_SPI,
+	RSET_SPI2,
 	RSET_UDC0,
 	RSET_OHCI0,
 	RSET_OHCI_PRIV,
@@ -98,10 +99,23 @@ enum bcm63xx_regs_set {
 	RSET_ENET0,
 	RSET_ENET1,
 	RSET_ENETDMA,
+	RSET_ENETDMAC,
+	RSET_ENETDMAS,
+	RSET_ENETSW,
 	RSET_EHCI0,
 	RSET_SDRAM,
 	RSET_MEMC,
 	RSET_DDR,
+	RSET_M2M,
+	RSET_ATM,
+	RSET_XTM,
+	RSET_XTMDMA,
+	RSET_XTMDMAC,
+	RSET_XTMDMAS,
+	RSET_PCM,
+	RSET_PCMDMA,
+	RSET_PCMDMAC,
+	RSET_PCMDMAS,
 };
 
 #define RSET_DSL_LMEM_SIZE		(64 * 1024 * 4)
@@ -109,11 +123,18 @@ enum bcm63xx_regs_set {
 #define RSET_WDT_SIZE			12
 #define RSET_ENET_SIZE			2048
 #define RSET_ENETDMA_SIZE		2048
+#define RSET_ENETSW_SIZE		65536
 #define RSET_UART_SIZE			24
 #define RSET_UDC_SIZE			256
 #define RSET_OHCI_SIZE			256
 #define RSET_EHCI_SIZE			256
 #define RSET_PCMCIA_SIZE		12
+#define RSET_M2M_SIZE			256
+#define RSET_ATM_SIZE			4096
+#define RSET_XTM_SIZE			10240
+#define RSET_XTMDMA_SIZE		256
+#define RSET_XTMDMAC_SIZE(chans)	(16 * (chans))
+#define RSET_XTMDMAS_SIZE(chans)	(16 * (chans))
 
 /*
  * 6338 register sets base address
@@ -127,6 +148,7 @@ enum bcm63xx_regs_set {
 #define BCM_6338_UART1_BASE		(0xdeadbeef)
 #define BCM_6338_GPIO_BASE		(0xfffe0400)
 #define BCM_6338_SPI_BASE		(0xfffe0c00)
+#define BCM_6338_SPI2_BASE		(0xdeadbeef)
 #define BCM_6338_UDC0_BASE		(0xdeadbeef)
 #define BCM_6338_USBDMA_BASE		(0xfffe2400)
 #define BCM_6338_OHCI0_BASE		(0xdeadbeef)
@@ -141,10 +163,23 @@ enum bcm63xx_regs_set {
 #define BCM_6338_ENET0_BASE		(0xfffe2800)
 #define BCM_6338_ENET1_BASE		(0xdeadbeef)
 #define BCM_6338_ENETDMA_BASE		(0xfffe2400)
+#define BCM_6338_ENETDMAC_BASE		(0xfffe2500)
+#define BCM_6338_ENETDMAS_BASE		(0xfffe2600)
+#define BCM_6338_ENETSW_BASE		(0xdeadbeef)
 #define BCM_6338_EHCI0_BASE		(0xdeadbeef)
 #define BCM_6338_SDRAM_BASE		(0xfffe3100)
 #define BCM_6338_MEMC_BASE		(0xdeadbeef)
 #define BCM_6338_DDR_BASE		(0xdeadbeef)
+#define BCM_6338_M2M_BASE		(0xdeadbeef)
+#define BCM_6338_ATM_BASE		(0xdeadbeef)
+#define BCM_6338_XTM_BASE		(0xdeadbeef)
+#define BCM_6338_XTMDMA_BASE		(0xdeadbeef)
+#define BCM_6338_XTMDMAC_BASE		(0xdeadbeef)
+#define BCM_6338_XTMDMAS_BASE		(0xdeadbeef)
+#define BCM_6338_PCM_BASE		(0xdeadbeef)
+#define BCM_6338_PCMDMA_BASE		(0xdeadbeef)
+#define BCM_6338_PCMDMAC_BASE		(0xdeadbeef)
+#define BCM_6338_PCMDMAS_BASE		(0xdeadbeef)
 
 /*
  * 6345 register sets base address
@@ -158,10 +193,14 @@ enum bcm63xx_regs_set {
 #define BCM_6345_UART1_BASE		(0xdeadbeef)
 #define BCM_6345_GPIO_BASE		(0xfffe0400)
 #define BCM_6345_SPI_BASE		(0xdeadbeef)
+#define BCM_6345_SPI2_BASE		(0xdeadbeef)
 #define BCM_6345_UDC0_BASE		(0xdeadbeef)
 #define BCM_6345_USBDMA_BASE		(0xfffe2800)
 #define BCM_6345_ENET0_BASE		(0xfffe1800)
 #define BCM_6345_ENETDMA_BASE		(0xfffe2800)
+#define BCM_6345_ENETDMAC_BASE		(0xfffe2900)
+#define BCM_6345_ENETDMAS_BASE		(0xfffe2a00)
+#define BCM_6345_ENETSW_BASE		(0xdeadbeef)
 #define BCM_6345_PCMCIA_BASE		(0xfffe2028)
 #define BCM_6345_MPI_BASE		(0xdeadbeef)
 #define BCM_6345_OHCI0_BASE		(0xfffe2100)
@@ -176,6 +215,16 @@ enum bcm63xx_regs_set {
 #define BCM_6345_SDRAM_BASE		(0xfffe2300)
 #define BCM_6345_MEMC_BASE		(0xdeadbeef)
 #define BCM_6345_DDR_BASE		(0xdeadbeef)
+#define BCM_6345_M2M_BASE		(0xdeadbeef)
+#define BCM_6345_ATM_BASE		(0xdeadbeef)
+#define BCM_6345_XTM_BASE		(0xdeadbeef)
+#define BCM_6345_XTMDMA_BASE		(0xdeadbeef)
+#define BCM_6345_XTMDMAC_BASE		(0xdeadbeef)
+#define BCM_6345_XTMDMAS_BASE		(0xdeadbeef)
+#define BCM_6345_PCM_BASE		(0xdeadbeef)
+#define BCM_6345_PCMDMA_BASE		(0xdeadbeef)
+#define BCM_6345_PCMDMAC_BASE		(0xdeadbeef)
+#define BCM_6345_PCMDMAS_BASE		(0xdeadbeef)
 
 /*
  * 6348 register sets base address
@@ -188,6 +237,7 @@ enum bcm63xx_regs_set {
 #define BCM_6348_UART1_BASE		(0xdeadbeef)
 #define BCM_6348_GPIO_BASE		(0xfffe0400)
 #define BCM_6348_SPI_BASE		(0xfffe0c00)
+#define BCM_6348_SPI2_BASE		(0xdeadbeef)
 #define BCM_6348_UDC0_BASE		(0xfffe1000)
 #define BCM_6348_OHCI0_BASE		(0xfffe1b00)
 #define BCM_6348_OHCI_PRIV_BASE		(0xfffe1c00)
@@ -195,14 +245,27 @@ enum bcm63xx_regs_set {
 #define BCM_6348_MPI_BASE		(0xfffe2000)
 #define BCM_6348_PCMCIA_BASE		(0xfffe2054)
 #define BCM_6348_SDRAM_REGS_BASE	(0xfffe2300)
+#define BCM_6348_M2M_BASE		(0xfffe2800)
 #define BCM_6348_DSL_BASE		(0xfffe3000)
 #define BCM_6348_ENET0_BASE		(0xfffe6000)
 #define BCM_6348_ENET1_BASE		(0xfffe6800)
 #define BCM_6348_ENETDMA_BASE		(0xfffe7000)
+#define BCM_6348_ENETDMAC_BASE		(0xfffe7100)
+#define BCM_6348_ENETDMAS_BASE		(0xfffe7200)
+#define BCM_6348_ENETSW_BASE		(0xdeadbeef)
 #define BCM_6348_EHCI0_BASE		(0xdeadbeef)
 #define BCM_6348_SDRAM_BASE		(0xfffe2300)
 #define BCM_6348_MEMC_BASE		(0xdeadbeef)
 #define BCM_6348_DDR_BASE		(0xdeadbeef)
+#define BCM_6348_ATM_BASE		(0xfffe4000)
+#define BCM_6348_XTM_BASE		(0xdeadbeef)
+#define BCM_6348_XTMDMA_BASE		(0xdeadbeef)
+#define BCM_6348_XTMDMAC_BASE		(0xdeadbeef)
+#define BCM_6348_XTMDMAS_BASE		(0xdeadbeef)
+#define BCM_6348_PCM_BASE		(0xdeadbeef)
+#define BCM_6348_PCMDMA_BASE		(0xdeadbeef)
+#define BCM_6348_PCMDMAC_BASE		(0xdeadbeef)
+#define BCM_6348_PCMDMAS_BASE		(0xdeadbeef)
 
 /*
  * 6358 register sets base address
@@ -215,6 +278,7 @@ enum bcm63xx_regs_set {
 #define BCM_6358_UART1_BASE		(0xfffe0120)
 #define BCM_6358_GPIO_BASE		(0xfffe0080)
 #define BCM_6358_SPI_BASE		(0xdeadbeef)
+#define BCM_6358_SPI2_BASE		(0xfffe0800)
 #define BCM_6358_UDC0_BASE		(0xfffe0800)
 #define BCM_6358_OHCI0_BASE		(0xfffe1400)
 #define BCM_6358_OHCI_PRIV_BASE		(0xdeadbeef)
@@ -222,14 +286,28 @@ enum bcm63xx_regs_set {
 #define BCM_6358_MPI_BASE		(0xfffe1000)
 #define BCM_6358_PCMCIA_BASE		(0xfffe1054)
 #define BCM_6358_SDRAM_REGS_BASE	(0xfffe2300)
+#define BCM_6358_M2M_BASE		(0xdeadbeef)
 #define BCM_6358_DSL_BASE		(0xfffe3000)
 #define BCM_6358_ENET0_BASE		(0xfffe4000)
 #define BCM_6358_ENET1_BASE		(0xfffe4800)
 #define BCM_6358_ENETDMA_BASE		(0xfffe5000)
+#define BCM_6358_ENETDMAC_BASE		(0xfffe5100)
+#define BCM_6358_ENETDMAS_BASE		(0xfffe5200)
+#define BCM_6358_ENETSW_BASE		(0xdeadbeef)
 #define BCM_6358_EHCI0_BASE		(0xfffe1300)
 #define BCM_6358_SDRAM_BASE		(0xdeadbeef)
 #define BCM_6358_MEMC_BASE		(0xfffe1200)
 #define BCM_6358_DDR_BASE		(0xfffe12a0)
+#define BCM_6358_ATM_BASE		(0xfffe2000)
+#define BCM_6358_XTM_BASE		(0xdeadbeef)
+#define BCM_6358_XTMDMA_BASE		(0xdeadbeef)
+#define BCM_6358_XTMDMAC_BASE		(0xdeadbeef)
+#define BCM_6358_XTMDMAS_BASE		(0xdeadbeef)
+#define BCM_6358_PCM_BASE		(0xfffe1600)
+#define BCM_6358_PCMDMA_BASE		(0xfffe1800)
+#define BCM_6358_PCMDMAC_BASE		(0xfffe1900)
+#define BCM_6358_PCMDMAS_BASE		(0xfffe1a00)
+
 
 
 extern const unsigned long *bcm63xx_regs_base;
@@ -248,6 +326,7 @@ extern const unsigned long *bcm63xx_regs_base;
 	__GEN_RSET_BASE(__cpu, UART1)					\
 	__GEN_RSET_BASE(__cpu, GPIO)					\
 	__GEN_RSET_BASE(__cpu, SPI)					\
+	__GEN_RSET_BASE(__cpu, SPI2)					\
 	__GEN_RSET_BASE(__cpu, UDC0)					\
 	__GEN_RSET_BASE(__cpu, OHCI0)					\
 	__GEN_RSET_BASE(__cpu, OHCI_PRIV)				\
@@ -258,10 +337,23 @@ extern const unsigned long *bcm63xx_regs_base;
 	__GEN_RSET_BASE(__cpu, ENET0)					\
 	__GEN_RSET_BASE(__cpu, ENET1)					\
 	__GEN_RSET_BASE(__cpu, ENETDMA)					\
+	__GEN_RSET_BASE(__cpu, ENETDMAC)				\
+	__GEN_RSET_BASE(__cpu, ENETDMAS)				\
+	__GEN_RSET_BASE(__cpu, ENETSW)					\
 	__GEN_RSET_BASE(__cpu, EHCI0)					\
 	__GEN_RSET_BASE(__cpu, SDRAM)					\
 	__GEN_RSET_BASE(__cpu, MEMC)					\
 	__GEN_RSET_BASE(__cpu, DDR)					\
+	__GEN_RSET_BASE(__cpu, M2M)					\
+	__GEN_RSET_BASE(__cpu, ATM)					\
+	__GEN_RSET_BASE(__cpu, XTM)					\
+	__GEN_RSET_BASE(__cpu, XTMDMA)					\
+	__GEN_RSET_BASE(__cpu, XTMDMAC)					\
+	__GEN_RSET_BASE(__cpu, XTMDMAS)					\
+	__GEN_RSET_BASE(__cpu, PCM)					\
+	__GEN_RSET_BASE(__cpu, PCMDMA)					\
+	__GEN_RSET_BASE(__cpu, PCMDMAC)					\
+	__GEN_RSET_BASE(__cpu, PCMDMAS)					\
 	}
 
 #define __GEN_CPU_REGS_TABLE(__cpu)					\
@@ -273,6 +365,7 @@ extern const unsigned long *bcm63xx_regs_base;
 	[RSET_UART1]		= BCM_## __cpu ##_UART1_BASE,		\
 	[RSET_GPIO]		= BCM_## __cpu ##_GPIO_BASE,		\
 	[RSET_SPI]		= BCM_## __cpu ##_SPI_BASE,		\
+	[RSET_SPI2]		= BCM_## __cpu ##_SPI2_BASE,		\
 	[RSET_UDC0]		= BCM_## __cpu ##_UDC0_BASE,		\
 	[RSET_OHCI0]		= BCM_## __cpu ##_OHCI0_BASE,		\
 	[RSET_OHCI_PRIV]	= BCM_## __cpu ##_OHCI_PRIV_BASE,	\
@@ -283,10 +376,23 @@ extern const unsigned long *bcm63xx_regs_base;
 	[RSET_ENET0]		= BCM_## __cpu ##_ENET0_BASE,		\
 	[RSET_ENET1]		= BCM_## __cpu ##_ENET1_BASE,		\
 	[RSET_ENETDMA]		= BCM_## __cpu ##_ENETDMA_BASE,		\
+	[RSET_ENETDMAC]		= BCM_## __cpu ##_ENETDMAC_BASE,	\
+	[RSET_ENETDMAS]		= BCM_## __cpu ##_ENETDMAS_BASE,	\
+	[RSET_ENETSW]		= BCM_## __cpu ##_ENETSW_BASE,		\
 	[RSET_EHCI0]		= BCM_## __cpu ##_EHCI0_BASE,		\
 	[RSET_SDRAM]		= BCM_## __cpu ##_SDRAM_BASE,		\
 	[RSET_MEMC]		= BCM_## __cpu ##_MEMC_BASE,		\
 	[RSET_DDR]		= BCM_## __cpu ##_DDR_BASE,		\
+	[RSET_M2M]		= BCM_## __cpu ##_M2M_BASE,		\
+	[RSET_ATM]		= BCM_## __cpu ##_ATM_BASE,		\
+	[RSET_XTM]		= BCM_## __cpu ##_XTM_BASE,		\
+	[RSET_XTMDMA]		= BCM_## __cpu ##_XTMDMA_BASE,		\
+	[RSET_XTMDMAC]		= BCM_## __cpu ##_XTMDMAC_BASE,		\
+	[RSET_XTMDMAS]		= BCM_## __cpu ##_XTMDMAS_BASE,		\
+	[RSET_PCM]		= BCM_## __cpu ##_PCM_BASE,		\
+	[RSET_PCMDMA]		= BCM_## __cpu ##_PCMDMA_BASE,		\
+	[RSET_PCMDMAC]		= BCM_## __cpu ##_PCMDMAC_BASE,		\
+	[RSET_PCMDMAS]		= BCM_## __cpu ##_PCMDMAS_BASE,		\
 
 
 static inline unsigned long bcm63xx_regset_address(enum bcm63xx_regs_set set)
@@ -330,6 +436,17 @@ enum bcm63xx_irq {
 	IRQ_ENET1_TXDMA,
 	IRQ_PCI,
 	IRQ_PCMCIA,
+	IRQ_ATM,
+	IRQ_ENETSW_RXDMA0,
+	IRQ_ENETSW_RXDMA1,
+	IRQ_ENETSW_RXDMA2,
+	IRQ_ENETSW_RXDMA3,
+	IRQ_ENETSW_TXDMA0,
+	IRQ_ENETSW_TXDMA1,
+	IRQ_ENETSW_TXDMA2,
+	IRQ_ENETSW_TXDMA3,
+	IRQ_XTM,
+	IRQ_XTM_DMA0,
 };
 
 /*
@@ -350,6 +467,17 @@ enum bcm63xx_irq {
 #define BCM_6338_ENET1_TXDMA_IRQ	0
 #define BCM_6338_PCI_IRQ		0
 #define BCM_6338_PCMCIA_IRQ		0
+#define BCM_6338_ATM_IRQ		0
+#define BCM_6338_ENETSW_RXDMA0_IRQ	0
+#define BCM_6338_ENETSW_RXDMA1_IRQ	0
+#define BCM_6338_ENETSW_RXDMA2_IRQ	0
+#define BCM_6338_ENETSW_RXDMA3_IRQ	0
+#define BCM_6338_ENETSW_TXDMA0_IRQ	0
+#define BCM_6338_ENETSW_TXDMA1_IRQ	0
+#define BCM_6338_ENETSW_TXDMA2_IRQ	0
+#define BCM_6338_ENETSW_TXDMA3_IRQ	0
+#define BCM_6338_XTM_IRQ		0
+#define BCM_6338_XTM_DMA0_IRQ		0
 
 /*
  * 6345 irqs
@@ -369,6 +497,17 @@ enum bcm63xx_irq {
 #define BCM_6345_ENET1_TXDMA_IRQ	0
 #define BCM_6345_PCI_IRQ		0
 #define BCM_6345_PCMCIA_IRQ		0
+#define BCM_6345_ATM_IRQ		0
+#define BCM_6345_ENETSW_RXDMA0_IRQ	0
+#define BCM_6345_ENETSW_RXDMA1_IRQ	0
+#define BCM_6345_ENETSW_RXDMA2_IRQ	0
+#define BCM_6345_ENETSW_RXDMA3_IRQ	0
+#define BCM_6345_ENETSW_TXDMA0_IRQ	0
+#define BCM_6345_ENETSW_TXDMA1_IRQ	0
+#define BCM_6345_ENETSW_TXDMA2_IRQ	0
+#define BCM_6345_ENETSW_TXDMA3_IRQ	0
+#define BCM_6345_XTM_IRQ		0
+#define BCM_6345_XTM_DMA0_IRQ		0
 
 /*
  * 6348 irqs
@@ -388,6 +527,17 @@ enum bcm63xx_irq {
 #define BCM_6348_ENET1_TXDMA_IRQ	(IRQ_INTERNAL_BASE + 23)
 #define BCM_6348_PCI_IRQ		(IRQ_INTERNAL_BASE + 24)
 #define BCM_6348_PCMCIA_IRQ		(IRQ_INTERNAL_BASE + 24)
+#define BCM_6348_ATM_IRQ		(IRQ_INTERNAL_BASE + 5)
+#define BCM_6348_ENETSW_RXDMA0_IRQ	0
+#define BCM_6348_ENETSW_RXDMA1_IRQ	0
+#define BCM_6348_ENETSW_RXDMA2_IRQ	0
+#define BCM_6348_ENETSW_RXDMA3_IRQ	0
+#define BCM_6348_ENETSW_TXDMA0_IRQ	0
+#define BCM_6348_ENETSW_TXDMA1_IRQ	0
+#define BCM_6348_ENETSW_TXDMA2_IRQ	0
+#define BCM_6348_ENETSW_TXDMA3_IRQ	0
+#define BCM_6348_XTM_IRQ		0
+#define BCM_6348_XTM_DMA0_IRQ		0
 
 /*
  * 6358 irqs
@@ -407,6 +557,24 @@ enum bcm63xx_irq {
 #define BCM_6358_ENET1_TXDMA_IRQ	(IRQ_INTERNAL_BASE + 18)
 #define BCM_6358_PCI_IRQ		(IRQ_INTERNAL_BASE + 31)
 #define BCM_6358_PCMCIA_IRQ		(IRQ_INTERNAL_BASE + 24)
+#define BCM_6358_ATM_IRQ		(IRQ_INTERNAL_BASE + 19)
+#define BCM_6358_ENETSW_RXDMA0_IRQ	0
+#define BCM_6358_ENETSW_RXDMA1_IRQ	0
+#define BCM_6358_ENETSW_RXDMA2_IRQ	0
+#define BCM_6358_ENETSW_RXDMA3_IRQ	0
+#define BCM_6358_ENETSW_TXDMA0_IRQ	0
+#define BCM_6358_ENETSW_TXDMA1_IRQ	0
+#define BCM_6358_ENETSW_TXDMA2_IRQ	0
+#define BCM_6358_ENETSW_TXDMA3_IRQ	0
+#define BCM_6358_XTM_IRQ		0
+#define BCM_6358_XTM_DMA0_IRQ		0
+
+#define BCM_6358_PCM_DMA0_IRQ		(IRQ_INTERNAL_BASE + 23)
+#define BCM_6358_PCM_DMA1_IRQ		(IRQ_INTERNAL_BASE + 24)
+#define BCM_6358_EXT_IRQ0		(IRQ_INTERNAL_BASE + 25)
+#define BCM_6358_EXT_IRQ1		(IRQ_INTERNAL_BASE + 26)
+#define BCM_6358_EXT_IRQ2		(IRQ_INTERNAL_BASE + 27)
+#define BCM_6358_EXT_IRQ3		(IRQ_INTERNAL_BASE + 28)
 
 extern const int *bcm63xx_irqs;
 
@@ -426,6 +594,17 @@ extern const int *bcm63xx_irqs;
 	[IRQ_ENET1_TXDMA]	= BCM_## __cpu ##_ENET1_TXDMA_IRQ,	\
 	[IRQ_PCI]		= BCM_## __cpu ##_PCI_IRQ,		\
 	[IRQ_PCMCIA]		= BCM_## __cpu ##_PCMCIA_IRQ,		\
+	[IRQ_ATM]		= BCM_## __cpu ##_ATM_IRQ,		\
+	[IRQ_ENETSW_RXDMA0]	= BCM_## __cpu ##_ENETSW_RXDMA0_IRQ,	\
+	[IRQ_ENETSW_RXDMA1]	= BCM_## __cpu ##_ENETSW_RXDMA1_IRQ,	\
+	[IRQ_ENETSW_RXDMA2]	= BCM_## __cpu ##_ENETSW_RXDMA2_IRQ,	\
+	[IRQ_ENETSW_RXDMA3]	= BCM_## __cpu ##_ENETSW_RXDMA3_IRQ,	\
+	[IRQ_ENETSW_TXDMA0]	= BCM_## __cpu ##_ENETSW_TXDMA0_IRQ,	\
+	[IRQ_ENETSW_TXDMA1]	= BCM_## __cpu ##_ENETSW_TXDMA1_IRQ,	\
+	[IRQ_ENETSW_TXDMA2]	= BCM_## __cpu ##_ENETSW_TXDMA2_IRQ,	\
+	[IRQ_ENETSW_TXDMA3]	= BCM_## __cpu ##_ENETSW_TXDMA3_IRQ,	\
+	[IRQ_XTM]		= BCM_## __cpu ##_XTM_IRQ,		\
+	[IRQ_XTM_DMA0]		= BCM_## __cpu ##_XTM_DMA0_IRQ,		\
 
 static inline int bcm63xx_get_irq_number(enum bcm63xx_irq irq)
 {
@@ -437,4 +616,8 @@ static inline int bcm63xx_get_irq_number(enum bcm63xx_irq irq)
  */
 unsigned int bcm63xx_get_memory_size(void);
 
+void bcm63xx_machine_halt(void);
+
+void bcm63xx_machine_reboot(void);
+
 #endif /* !BCM63XX_CPU_H_ */
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
index 0ed5230..3ea2681 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
@@ -548,6 +548,56 @@
 
 
 /*************************************************************************
+ * _REG relative to RSET_ENETDMAC
+ *************************************************************************/
+
+/* Channel Configuration register */
+#define ENETDMAC_CHANCFG_REG(x)		((x) * 0x10)
+#define ENETDMAC_CHANCFG_EN_SHIFT	0
+#define ENETDMAC_CHANCFG_EN_MASK	(1 << ENETDMA_CHANCFG_EN_SHIFT)
+#define ENETDMAC_CHANCFG_PKTHALT_SHIFT	1
+#define ENETDMAC_CHANCFG_PKTHALT_MASK	(1 << ENETDMA_CHANCFG_PKTHALT_SHIFT)
+
+/* Interrupt Control/Status register */
+#define ENETDMAC_IR_REG(x)		(0x4 + (x) * 0x10)
+#define ENETDMAC_IR_BUFDONE_MASK	(1 << 0)
+#define ENETDMAC_IR_PKTDONE_MASK	(1 << 1)
+#define ENETDMAC_IR_NOTOWNER_MASK	(1 << 2)
+
+/* Interrupt Mask register */
+#define ENETDMAC_IRMASK_REG(x)		(0x8 + (x) * 0x10)
+
+/* Maximum Burst Length */
+#define ENETDMAC_MAXBURST_REG(x)	(0xc + (x) * 0x10)
+
+
+/*************************************************************************
+ * _REG relative to RSET_ENETDMAS
+ *************************************************************************/
+
+/* Ring Start Address register */
+#define ENETDMAS_RSTART_REG(x)		((x) * 0x10)
+
+/* State Ram Word 2 */
+#define ENETDMAS_SRAM2_REG(x)		(0x4 + (x) * 0x10)
+
+/* State Ram Word 3 */
+#define ENETDMAS_SRAM3_REG(x)		(0x8 + (x) * 0x10)
+
+/* State Ram Word 4 */
+#define ENETDMAS_SRAM4_REG(x)		(0xc + (x) * 0x10)
+
+
+/*************************************************************************
+ * _REG relative to RSET_ENETSW
+ *************************************************************************/
+
+/* MIB register */
+#define ENETSW_MIB_REG(x)		(0x2800 + (x) * 4)
+#define ENETSW_MIB_REG_COUNT		47
+
+
+/*************************************************************************
  * _REG relative to RSET_OHCI_PRIV
  *************************************************************************/
 
@@ -768,4 +818,32 @@
 #define DMIPSPLLCFG_N2_SHIFT		29
 #define DMIPSPLLCFG_N2_MASK		(0x7 << DMIPSPLLCFG_N2_SHIFT)
 
+/*************************************************************************
+ * _REG relative to RSET_M2M
+ *************************************************************************/
+
+#define M2M_RX				0
+#define M2M_TX				1
+
+#define M2M_SRC_REG(x)			((x) * 0x40 + 0x00)
+#define M2M_DST_REG(x)			((x) * 0x40 + 0x04)
+#define M2M_SIZE_REG(x)			((x) * 0x40 + 0x08)
+
+#define M2M_CTRL_REG(x)			((x) * 0x40 + 0x0c)
+#define M2M_CTRL_ENABLE_MASK		(1 << 0)
+#define M2M_CTRL_IRQEN_MASK		(1 << 1)
+#define M2M_CTRL_ERROR_CLR_MASK		(1 << 6)
+#define M2M_CTRL_DONE_CLR_MASK		(1 << 7)
+#define M2M_CTRL_NOINC_MASK		(1 << 8)
+#define M2M_CTRL_PCMCIASWAP_MASK	(1 << 9)
+#define M2M_CTRL_SWAPBYTE_MASK		(1 << 10)
+#define M2M_CTRL_ENDIAN_MASK		(1 << 11)
+
+#define M2M_STAT_REG(x)			((x) * 0x40 + 0x10)
+#define M2M_STAT_DONE			(1 << 0)
+#define M2M_STAT_ERROR			(1 << 1)
+
+#define M2M_SRCID_REG(x)		((x) * 0x40 + 0x14)
+#define M2M_DSTID_REG(x)		((x) * 0x40 + 0x18)
+
 #endif /* BCM63XX_REGS_H_ */
-- 
1.7.1.1
