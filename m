Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jun 2011 23:50:48 +0200 (CEST)
Received: from smtp4-g21.free.fr ([212.27.42.4]:52688 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491145Ab1FJVrn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 10 Jun 2011 23:47:43 +0200
Received: from bobafett.staff.proxad.net (unknown [213.228.1.121])
        by smtp4-g21.free.fr (Postfix) with ESMTP id 9AB274C80DE;
        Fri, 10 Jun 2011 23:47:38 +0200 (CEST)
Received: from sakura.staff.proxad.net (unknown [172.18.3.156])
        by bobafett.staff.proxad.net (Postfix) with ESMTP id BED7018065D;
        Fri, 10 Jun 2011 23:47:30 +0200 (CEST)
Received: by sakura.staff.proxad.net (Postfix, from userid 1000)
        id A8F8755B08E; Fri, 10 Jun 2011 23:47:30 +0200 (CEST)
From:   Maxime Bizon <mbizon@freebox.fr>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, florian@openwrt.org,
        Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH 05/11] MIPS: BCM63XX: cleanup cpu registers.
Date:   Fri, 10 Jun 2011 23:47:15 +0200
Message-Id: <1307742441-28284-6-git-send-email-mbizon@freebox.fr>
X-Mailer: git-send-email 1.7.1.1
In-Reply-To: <1307742441-28284-1-git-send-email-mbizon@freebox.fr>
References: <1307742441-28284-1-git-send-email-mbizon@freebox.fr>
X-archive-position: 30333
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9580

Use preprocessor when possible to avoid duplicated and error-prone
code.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
---
 arch/mips/bcm63xx/cpu.c                          |  145 +----------
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h |  311 +++++++---------------
 2 files changed, 109 insertions(+), 347 deletions(-)

diff --git a/arch/mips/bcm63xx/cpu.c b/arch/mips/bcm63xx/cpu.c
index 7c7e4d4..027ac30 100644
--- a/arch/mips/bcm63xx/cpu.c
+++ b/arch/mips/bcm63xx/cpu.c
@@ -33,162 +33,37 @@ static unsigned int bcm63xx_memory_size;
  * 6338 register sets and irqs
  */
 static const unsigned long bcm96338_regs_base[] = {
-	[RSET_DSL_LMEM]		= BCM_6338_DSL_LMEM_BASE,
-	[RSET_PERF]		= BCM_6338_PERF_BASE,
-	[RSET_TIMER]		= BCM_6338_TIMER_BASE,
-	[RSET_WDT]		= BCM_6338_WDT_BASE,
-	[RSET_UART0]		= BCM_6338_UART0_BASE,
-	[RSET_UART1]		= BCM_6338_UART1_BASE,
-	[RSET_GPIO]		= BCM_6338_GPIO_BASE,
-	[RSET_SPI]		= BCM_6338_SPI_BASE,
-	[RSET_OHCI0]		= BCM_6338_OHCI0_BASE,
-	[RSET_OHCI_PRIV]	= BCM_6338_OHCI_PRIV_BASE,
-	[RSET_USBH_PRIV]	= BCM_6338_USBH_PRIV_BASE,
-	[RSET_UDC0]		= BCM_6338_UDC0_BASE,
-	[RSET_MPI]		= BCM_6338_MPI_BASE,
-	[RSET_PCMCIA]		= BCM_6338_PCMCIA_BASE,
-	[RSET_SDRAM]		= BCM_6338_SDRAM_BASE,
-	[RSET_DSL]		= BCM_6338_DSL_BASE,
-	[RSET_ENET0]		= BCM_6338_ENET0_BASE,
-	[RSET_ENET1]		= BCM_6338_ENET1_BASE,
-	[RSET_ENETDMA]		= BCM_6338_ENETDMA_BASE,
-	[RSET_MEMC]		= BCM_6338_MEMC_BASE,
-	[RSET_DDR]		= BCM_6338_DDR_BASE,
+	__GEN_CPU_REGS_TABLE(6338)
 };
 
 static const int bcm96338_irqs[] = {
-	[IRQ_TIMER]		= BCM_6338_TIMER_IRQ,
-	[IRQ_UART0]		= BCM_6338_UART0_IRQ,
-	[IRQ_DSL]		= BCM_6338_DSL_IRQ,
-	[IRQ_ENET0]		= BCM_6338_ENET0_IRQ,
-	[IRQ_ENET_PHY]		= BCM_6338_ENET_PHY_IRQ,
-	[IRQ_ENET0_RXDMA]	= BCM_6338_ENET0_RXDMA_IRQ,
-	[IRQ_ENET0_TXDMA]	= BCM_6338_ENET0_TXDMA_IRQ,
+	__GEN_CPU_IRQ_TABLE(6338)
 };
 
-/*
- * 6345 register sets and irqs
- */
 static const unsigned long bcm96345_regs_base[] = {
-	[RSET_DSL_LMEM]		= BCM_6345_DSL_LMEM_BASE,
-	[RSET_PERF]		= BCM_6345_PERF_BASE,
-	[RSET_TIMER]		= BCM_6345_TIMER_BASE,
-	[RSET_WDT]		= BCM_6345_WDT_BASE,
-	[RSET_UART0]		= BCM_6345_UART0_BASE,
-	[RSET_UART1]		= BCM_6345_UART1_BASE,
-	[RSET_GPIO]		= BCM_6345_GPIO_BASE,
-	[RSET_SPI]		= BCM_6345_SPI_BASE,
-	[RSET_UDC0]		= BCM_6345_UDC0_BASE,
-	[RSET_OHCI0]		= BCM_6345_OHCI0_BASE,
-	[RSET_OHCI_PRIV]	= BCM_6345_OHCI_PRIV_BASE,
-	[RSET_USBH_PRIV]	= BCM_6345_USBH_PRIV_BASE,
-	[RSET_MPI]		= BCM_6345_MPI_BASE,
-	[RSET_PCMCIA]		= BCM_6345_PCMCIA_BASE,
-	[RSET_DSL]		= BCM_6345_DSL_BASE,
-	[RSET_ENET0]		= BCM_6345_ENET0_BASE,
-	[RSET_ENET1]		= BCM_6345_ENET1_BASE,
-	[RSET_ENETDMA]		= BCM_6345_ENETDMA_BASE,
-	[RSET_EHCI0]		= BCM_6345_EHCI0_BASE,
-	[RSET_SDRAM]		= BCM_6345_SDRAM_BASE,
-	[RSET_MEMC]		= BCM_6345_MEMC_BASE,
-	[RSET_DDR]		= BCM_6345_DDR_BASE,
+	__GEN_CPU_REGS_TABLE(6345)
 };
 
 static const int bcm96345_irqs[] = {
-	[IRQ_TIMER]		= BCM_6345_TIMER_IRQ,
-	[IRQ_UART0]		= BCM_6345_UART0_IRQ,
-	[IRQ_DSL]		= BCM_6345_DSL_IRQ,
-	[IRQ_ENET0]		= BCM_6345_ENET0_IRQ,
-	[IRQ_ENET_PHY]		= BCM_6345_ENET_PHY_IRQ,
-	[IRQ_ENET0_RXDMA]	= BCM_6345_ENET0_RXDMA_IRQ,
-	[IRQ_ENET0_TXDMA]	= BCM_6345_ENET0_TXDMA_IRQ,
+	__GEN_CPU_IRQ_TABLE(6345)
 };
 
-/*
- * 6348 register sets and irqs
- */
 static const unsigned long bcm96348_regs_base[] = {
-	[RSET_DSL_LMEM]		= BCM_6348_DSL_LMEM_BASE,
-	[RSET_PERF]		= BCM_6348_PERF_BASE,
-	[RSET_TIMER]		= BCM_6348_TIMER_BASE,
-	[RSET_WDT]		= BCM_6348_WDT_BASE,
-	[RSET_UART0]		= BCM_6348_UART0_BASE,
-	[RSET_UART1]		= BCM_6348_UART1_BASE,
-	[RSET_GPIO]		= BCM_6348_GPIO_BASE,
-	[RSET_SPI]		= BCM_6348_SPI_BASE,
-	[RSET_OHCI0]		= BCM_6348_OHCI0_BASE,
-	[RSET_OHCI_PRIV]	= BCM_6348_OHCI_PRIV_BASE,
-	[RSET_USBH_PRIV]	= BCM_6348_USBH_PRIV_BASE,
-	[RSET_MPI]		= BCM_6348_MPI_BASE,
-	[RSET_PCMCIA]		= BCM_6348_PCMCIA_BASE,
-	[RSET_SDRAM]		= BCM_6348_SDRAM_BASE,
-	[RSET_DSL]		= BCM_6348_DSL_BASE,
-	[RSET_ENET0]		= BCM_6348_ENET0_BASE,
-	[RSET_ENET1]		= BCM_6348_ENET1_BASE,
-	[RSET_ENETDMA]		= BCM_6348_ENETDMA_BASE,
-	[RSET_MEMC]		= BCM_6348_MEMC_BASE,
-	[RSET_DDR]		= BCM_6348_DDR_BASE,
+	__GEN_CPU_REGS_TABLE(6348)
 };
 
 static const int bcm96348_irqs[] = {
-	[IRQ_TIMER]		= BCM_6348_TIMER_IRQ,
-	[IRQ_UART0]		= BCM_6348_UART0_IRQ,
-	[IRQ_DSL]		= BCM_6348_DSL_IRQ,
-	[IRQ_ENET0]		= BCM_6348_ENET0_IRQ,
-	[IRQ_ENET1]		= BCM_6348_ENET1_IRQ,
-	[IRQ_ENET_PHY]		= BCM_6348_ENET_PHY_IRQ,
-	[IRQ_OHCI0]		= BCM_6348_OHCI0_IRQ,
-	[IRQ_PCMCIA]		= BCM_6348_PCMCIA_IRQ,
-	[IRQ_ENET0_RXDMA]	= BCM_6348_ENET0_RXDMA_IRQ,
-	[IRQ_ENET0_TXDMA]	= BCM_6348_ENET0_TXDMA_IRQ,
-	[IRQ_ENET1_RXDMA]	= BCM_6348_ENET1_RXDMA_IRQ,
-	[IRQ_ENET1_TXDMA]	= BCM_6348_ENET1_TXDMA_IRQ,
-	[IRQ_PCI]		= BCM_6348_PCI_IRQ,
+	__GEN_CPU_IRQ_TABLE(6348)
+
 };
 
-/*
- * 6358 register sets and irqs
- */
 static const unsigned long bcm96358_regs_base[] = {
-	[RSET_DSL_LMEM]		= BCM_6358_DSL_LMEM_BASE,
-	[RSET_PERF]		= BCM_6358_PERF_BASE,
-	[RSET_TIMER]		= BCM_6358_TIMER_BASE,
-	[RSET_WDT]		= BCM_6358_WDT_BASE,
-	[RSET_UART0]		= BCM_6358_UART0_BASE,
-	[RSET_UART1]		= BCM_6358_UART1_BASE,
-	[RSET_GPIO]		= BCM_6358_GPIO_BASE,
-	[RSET_SPI]		= BCM_6358_SPI_BASE,
-	[RSET_OHCI0]		= BCM_6358_OHCI0_BASE,
-	[RSET_EHCI0]		= BCM_6358_EHCI0_BASE,
-	[RSET_OHCI_PRIV]	= BCM_6358_OHCI_PRIV_BASE,
-	[RSET_USBH_PRIV]	= BCM_6358_USBH_PRIV_BASE,
-	[RSET_MPI]		= BCM_6358_MPI_BASE,
-	[RSET_PCMCIA]		= BCM_6358_PCMCIA_BASE,
-	[RSET_SDRAM]		= BCM_6358_SDRAM_BASE,
-	[RSET_DSL]		= BCM_6358_DSL_BASE,
-	[RSET_ENET0]		= BCM_6358_ENET0_BASE,
-	[RSET_ENET1]		= BCM_6358_ENET1_BASE,
-	[RSET_ENETDMA]		= BCM_6358_ENETDMA_BASE,
-	[RSET_MEMC]		= BCM_6358_MEMC_BASE,
-	[RSET_DDR]		= BCM_6358_DDR_BASE,
+	__GEN_CPU_REGS_TABLE(6358)
 };
 
 static const int bcm96358_irqs[] = {
-	[IRQ_TIMER]		= BCM_6358_TIMER_IRQ,
-	[IRQ_UART0]		= BCM_6358_UART0_IRQ,
-	[IRQ_UART1]		= BCM_6358_UART1_IRQ,
-	[IRQ_DSL]		= BCM_6358_DSL_IRQ,
-	[IRQ_ENET0]		= BCM_6358_ENET0_IRQ,
-	[IRQ_ENET1]		= BCM_6358_ENET1_IRQ,
-	[IRQ_ENET_PHY]		= BCM_6358_ENET_PHY_IRQ,
-	[IRQ_OHCI0]		= BCM_6358_OHCI0_IRQ,
-	[IRQ_EHCI0]		= BCM_6358_EHCI0_IRQ,
-	[IRQ_PCMCIA]		= BCM_6358_PCMCIA_IRQ,
-	[IRQ_ENET0_RXDMA]	= BCM_6358_ENET0_RXDMA_IRQ,
-	[IRQ_ENET0_TXDMA]	= BCM_6358_ENET0_TXDMA_IRQ,
-	[IRQ_ENET1_RXDMA]	= BCM_6358_ENET1_RXDMA_IRQ,
-	[IRQ_ENET1_TXDMA]	= BCM_6358_ENET1_TXDMA_IRQ,
-	[IRQ_PCI]		= BCM_6358_PCI_IRQ,
+	__GEN_CPU_IRQ_TABLE(6358)
+
 };
 
 u16 __bcm63xx_get_cpu_id(void)
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
index 96a2391..464f948 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
@@ -234,202 +234,77 @@ enum bcm63xx_regs_set {
 
 extern const unsigned long *bcm63xx_regs_base;
 
+#define __GEN_RSET_BASE(__cpu, __rset)					\
+	case RSET_## __rset :						\
+		return BCM_## __cpu ##_## __rset ##_BASE;
+
+#define __GEN_RSET(__cpu)						\
+	switch (set) {							\
+	__GEN_RSET_BASE(__cpu, DSL_LMEM)				\
+	__GEN_RSET_BASE(__cpu, PERF)					\
+	__GEN_RSET_BASE(__cpu, TIMER)					\
+	__GEN_RSET_BASE(__cpu, WDT)					\
+	__GEN_RSET_BASE(__cpu, UART0)					\
+	__GEN_RSET_BASE(__cpu, UART1)					\
+	__GEN_RSET_BASE(__cpu, GPIO)					\
+	__GEN_RSET_BASE(__cpu, SPI)					\
+	__GEN_RSET_BASE(__cpu, UDC0)					\
+	__GEN_RSET_BASE(__cpu, OHCI0)					\
+	__GEN_RSET_BASE(__cpu, OHCI_PRIV)				\
+	__GEN_RSET_BASE(__cpu, USBH_PRIV)				\
+	__GEN_RSET_BASE(__cpu, MPI)					\
+	__GEN_RSET_BASE(__cpu, PCMCIA)					\
+	__GEN_RSET_BASE(__cpu, DSL)					\
+	__GEN_RSET_BASE(__cpu, ENET0)					\
+	__GEN_RSET_BASE(__cpu, ENET1)					\
+	__GEN_RSET_BASE(__cpu, ENETDMA)					\
+	__GEN_RSET_BASE(__cpu, EHCI0)					\
+	__GEN_RSET_BASE(__cpu, SDRAM)					\
+	__GEN_RSET_BASE(__cpu, MEMC)					\
+	__GEN_RSET_BASE(__cpu, DDR)					\
+	}
+
+#define __GEN_CPU_REGS_TABLE(__cpu)					\
+	[RSET_DSL_LMEM]		= BCM_## __cpu ##_DSL_LMEM_BASE,	\
+	[RSET_PERF]		= BCM_## __cpu ##_PERF_BASE,		\
+	[RSET_TIMER]		= BCM_## __cpu ##_TIMER_BASE,		\
+	[RSET_WDT]		= BCM_## __cpu ##_WDT_BASE,		\
+	[RSET_UART0]		= BCM_## __cpu ##_UART0_BASE,		\
+	[RSET_UART1]		= BCM_## __cpu ##_UART1_BASE,		\
+	[RSET_GPIO]		= BCM_## __cpu ##_GPIO_BASE,		\
+	[RSET_SPI]		= BCM_## __cpu ##_SPI_BASE,		\
+	[RSET_UDC0]		= BCM_## __cpu ##_UDC0_BASE,		\
+	[RSET_OHCI0]		= BCM_## __cpu ##_OHCI0_BASE,		\
+	[RSET_OHCI_PRIV]	= BCM_## __cpu ##_OHCI_PRIV_BASE,	\
+	[RSET_USBH_PRIV]	= BCM_## __cpu ##_USBH_PRIV_BASE,	\
+	[RSET_MPI]		= BCM_## __cpu ##_MPI_BASE,		\
+	[RSET_PCMCIA]		= BCM_## __cpu ##_PCMCIA_BASE,		\
+	[RSET_DSL]		= BCM_## __cpu ##_DSL_BASE,		\
+	[RSET_ENET0]		= BCM_## __cpu ##_ENET0_BASE,		\
+	[RSET_ENET1]		= BCM_## __cpu ##_ENET1_BASE,		\
+	[RSET_ENETDMA]		= BCM_## __cpu ##_ENETDMA_BASE,		\
+	[RSET_EHCI0]		= BCM_## __cpu ##_EHCI0_BASE,		\
+	[RSET_SDRAM]		= BCM_## __cpu ##_SDRAM_BASE,		\
+	[RSET_MEMC]		= BCM_## __cpu ##_MEMC_BASE,		\
+	[RSET_DDR]		= BCM_## __cpu ##_DDR_BASE,		\
+
+
 static inline unsigned long bcm63xx_regset_address(enum bcm63xx_regs_set set)
 {
 #ifdef BCMCPU_RUNTIME_DETECT
 	return bcm63xx_regs_base[set];
 #else
 #ifdef CONFIG_BCM63XX_CPU_6338
-	switch (set) {
-	case RSET_DSL_LMEM:
-		return BCM_6338_DSL_LMEM_BASE;
-	case RSET_PERF:
-		return BCM_6338_PERF_BASE;
-	case RSET_TIMER:
-		return BCM_6338_TIMER_BASE;
-	case RSET_WDT:
-		return BCM_6338_WDT_BASE;
-	case RSET_UART0:
-		return BCM_6338_UART0_BASE;
-	case RSET_UART1:
-		return BCM_6338_UART1_BASE;
-	case RSET_GPIO:
-		return BCM_6338_GPIO_BASE;
-	case RSET_SPI:
-		return BCM_6338_SPI_BASE;
-	case RSET_UDC0:
-		return BCM_6338_UDC0_BASE;
-	case RSET_OHCI0:
-		return BCM_6338_OHCI0_BASE;
-	case RSET_OHCI_PRIV:
-		return BCM_6338_OHCI_PRIV_BASE;
-	case RSET_USBH_PRIV:
-		return BCM_6338_USBH_PRIV_BASE;
-	case RSET_MPI:
-		return BCM_6338_MPI_BASE;
-	case RSET_PCMCIA:
-		return BCM_6338_PCMCIA_BASE;
-	case RSET_DSL:
-		return BCM_6338_DSL_BASE;
-	case RSET_ENET0:
-		return BCM_6338_ENET0_BASE;
-	case RSET_ENET1:
-		return BCM_6338_ENET1_BASE;
-	case RSET_ENETDMA:
-		return BCM_6338_ENETDMA_BASE;
-	case RSET_EHCI0:
-		return BCM_6338_EHCI0_BASE;
-	case RSET_SDRAM:
-		return BCM_6338_SDRAM_BASE;
-	case RSET_MEMC:
-		return BCM_6338_MEMC_BASE;
-	case RSET_DDR:
-		return BCM_6338_DDR_BASE;
-	}
+	__GEN_RSET(6338)
 #endif
 #ifdef CONFIG_BCM63XX_CPU_6345
-	switch (set) {
-	case RSET_DSL_LMEM:
-		return BCM_6345_DSL_LMEM_BASE;
-	case RSET_PERF:
-		return BCM_6345_PERF_BASE;
-	case RSET_TIMER:
-		return BCM_6345_TIMER_BASE;
-	case RSET_WDT:
-		return BCM_6345_WDT_BASE;
-	case RSET_UART0:
-		return BCM_6345_UART0_BASE;
-	case RSET_UART1:
-		return BCM_6345_UART1_BASE;
-	case RSET_GPIO:
-		return BCM_6345_GPIO_BASE;
-	case RSET_SPI:
-		return BCM_6345_SPI_BASE;
-	case RSET_UDC0:
-		return BCM_6345_UDC0_BASE;
-	case RSET_OHCI0:
-		return BCM_6345_OHCI0_BASE;
-	case RSET_OHCI_PRIV:
-		return BCM_6345_OHCI_PRIV_BASE;
-	case RSET_USBH_PRIV:
-		return BCM_6345_USBH_PRIV_BASE;
-	case RSET_MPI:
-		return BCM_6345_MPI_BASE;
-	case RSET_PCMCIA:
-		return BCM_6345_PCMCIA_BASE;
-	case RSET_DSL:
-		return BCM_6345_DSL_BASE;
-	case RSET_ENET0:
-		return BCM_6345_ENET0_BASE;
-	case RSET_ENET1:
-		return BCM_6345_ENET1_BASE;
-	case RSET_ENETDMA:
-		return BCM_6345_ENETDMA_BASE;
-	case RSET_EHCI0:
-		return BCM_6345_EHCI0_BASE;
-	case RSET_SDRAM:
-		return BCM_6345_SDRAM_BASE;
-	case RSET_MEMC:
-		return BCM_6345_MEMC_BASE;
-	case RSET_DDR:
-		return BCM_6345_DDR_BASE;
-	}
+	__GEN_RSET(6345)
 #endif
 #ifdef CONFIG_BCM63XX_CPU_6348
-	switch (set) {
-	case RSET_DSL_LMEM:
-		return BCM_6348_DSL_LMEM_BASE;
-	case RSET_PERF:
-		return BCM_6348_PERF_BASE;
-	case RSET_TIMER:
-		return BCM_6348_TIMER_BASE;
-	case RSET_WDT:
-		return BCM_6348_WDT_BASE;
-	case RSET_UART0:
-		return BCM_6348_UART0_BASE;
-	case RSET_UART1:
-		return BCM_6348_UART1_BASE;
-	case RSET_GPIO:
-		return BCM_6348_GPIO_BASE;
-	case RSET_SPI:
-		return BCM_6348_SPI_BASE;
-	case RSET_UDC0:
-		return BCM_6348_UDC0_BASE;
-	case RSET_OHCI0:
-		return BCM_6348_OHCI0_BASE;
-	case RSET_OHCI_PRIV:
-		return BCM_6348_OHCI_PRIV_BASE;
-	case RSET_USBH_PRIV:
-		return BCM_6348_USBH_PRIV_BASE;
-	case RSET_MPI:
-		return BCM_6348_MPI_BASE;
-	case RSET_PCMCIA:
-		return BCM_6348_PCMCIA_BASE;
-	case RSET_DSL:
-		return BCM_6348_DSL_BASE;
-	case RSET_ENET0:
-		return BCM_6348_ENET0_BASE;
-	case RSET_ENET1:
-		return BCM_6348_ENET1_BASE;
-	case RSET_ENETDMA:
-		return BCM_6348_ENETDMA_BASE;
-	case RSET_EHCI0:
-		return BCM_6348_EHCI0_BASE;
-	case RSET_SDRAM:
-		return BCM_6348_SDRAM_BASE;
-	case RSET_MEMC:
-		return BCM_6348_MEMC_BASE;
-	case RSET_DDR:
-		return BCM_6348_DDR_BASE;
-	}
+	__GEN_RSET(6348)
 #endif
 #ifdef CONFIG_BCM63XX_CPU_6358
-	switch (set) {
-	case RSET_DSL_LMEM:
-		return BCM_6358_DSL_LMEM_BASE;
-	case RSET_PERF:
-		return BCM_6358_PERF_BASE;
-	case RSET_TIMER:
-		return BCM_6358_TIMER_BASE;
-	case RSET_WDT:
-		return BCM_6358_WDT_BASE;
-	case RSET_UART0:
-		return BCM_6358_UART0_BASE;
-	case RSET_UART1:
-		return BCM_6358_UART1_BASE;
-	case RSET_GPIO:
-		return BCM_6358_GPIO_BASE;
-	case RSET_SPI:
-		return BCM_6358_SPI_BASE;
-	case RSET_UDC0:
-		return BCM_6358_UDC0_BASE;
-	case RSET_OHCI0:
-		return BCM_6358_OHCI0_BASE;
-	case RSET_OHCI_PRIV:
-		return BCM_6358_OHCI_PRIV_BASE;
-	case RSET_USBH_PRIV:
-		return BCM_6358_USBH_PRIV_BASE;
-	case RSET_MPI:
-		return BCM_6358_MPI_BASE;
-	case RSET_PCMCIA:
-		return BCM_6358_PCMCIA_BASE;
-	case RSET_ENET0:
-		return BCM_6358_ENET0_BASE;
-	case RSET_ENET1:
-		return BCM_6358_ENET1_BASE;
-	case RSET_ENETDMA:
-		return BCM_6358_ENETDMA_BASE;
-	case RSET_DSL:
-		return BCM_6358_DSL_BASE;
-	case RSET_EHCI0:
-		return BCM_6358_EHCI0_BASE;
-	case RSET_SDRAM:
-		return BCM_6358_SDRAM_BASE;
-	case RSET_MEMC:
-		return BCM_6358_MEMC_BASE;
-	case RSET_DDR:
-		return BCM_6358_DDR_BASE;
-	}
+	__GEN_RSET(6358)
 #endif
 #endif
 	/* unreached */
@@ -449,7 +324,6 @@ enum bcm63xx_irq {
 	IRQ_ENET_PHY,
 	IRQ_OHCI0,
 	IRQ_EHCI0,
-	IRQ_PCMCIA0,
 	IRQ_ENET0_RXDMA,
 	IRQ_ENET0_TXDMA,
 	IRQ_ENET1_RXDMA,
@@ -462,62 +336,58 @@ enum bcm63xx_irq {
  * 6338 irqs
  */
 #define BCM_6338_TIMER_IRQ		(IRQ_INTERNAL_BASE + 0)
-#define BCM_6338_SPI_IRQ		(IRQ_INTERNAL_BASE + 1)
 #define BCM_6338_UART0_IRQ		(IRQ_INTERNAL_BASE + 2)
-#define BCM_6338_DG_IRQ			(IRQ_INTERNAL_BASE + 4)
+#define BCM_6338_UART1_IRQ		0
 #define BCM_6338_DSL_IRQ		(IRQ_INTERNAL_BASE + 5)
-#define BCM_6338_ATM_IRQ		(IRQ_INTERNAL_BASE + 6)
-#define BCM_6338_UDC0_IRQ		(IRQ_INTERNAL_BASE + 7)
 #define BCM_6338_ENET0_IRQ		(IRQ_INTERNAL_BASE + 8)
+#define BCM_6338_ENET1_IRQ		0
 #define BCM_6338_ENET_PHY_IRQ		(IRQ_INTERNAL_BASE + 9)
-#define BCM_6338_SDRAM_IRQ		(IRQ_INTERNAL_BASE + 10)
-#define BCM_6338_USB_CNTL_RX_DMA_IRQ	(IRQ_INTERNAL_BASE + 11)
-#define BCM_6338_USB_CNTL_TX_DMA_IRQ	(IRQ_INTERNAL_BASE + 12)
-#define BCM_6338_USB_BULK_RX_DMA_IRQ	(IRQ_INTERNAL_BASE + 13)
-#define BCM_6338_USB_BULK_TX_DMA_IRQ	(IRQ_INTERNAL_BASE + 14)
+#define BCM_6338_OHCI0_IRQ		0
+#define BCM_6338_EHCI0_IRQ		0
 #define BCM_6338_ENET0_RXDMA_IRQ	(IRQ_INTERNAL_BASE + 15)
 #define BCM_6338_ENET0_TXDMA_IRQ	(IRQ_INTERNAL_BASE + 16)
-#define BCM_6338_SDIO_IRQ		(IRQ_INTERNAL_BASE + 17)
+#define BCM_6338_ENET1_RXDMA_IRQ	0
+#define BCM_6338_ENET1_TXDMA_IRQ	0
+#define BCM_6338_PCI_IRQ		0
+#define BCM_6338_PCMCIA_IRQ		0
 
 /*
  * 6345 irqs
  */
 #define BCM_6345_TIMER_IRQ		(IRQ_INTERNAL_BASE + 0)
 #define BCM_6345_UART0_IRQ		(IRQ_INTERNAL_BASE + 2)
+#define BCM_6345_UART1_IRQ		0
 #define BCM_6345_DSL_IRQ		(IRQ_INTERNAL_BASE + 3)
-#define BCM_6345_ATM_IRQ		(IRQ_INTERNAL_BASE + 4)
-#define BCM_6345_USB_IRQ		(IRQ_INTERNAL_BASE + 5)
 #define BCM_6345_ENET0_IRQ		(IRQ_INTERNAL_BASE + 8)
+#define BCM_6345_ENET1_IRQ		0
 #define BCM_6345_ENET_PHY_IRQ		(IRQ_INTERNAL_BASE + 12)
+#define BCM_6345_OHCI0_IRQ		0
+#define BCM_6345_EHCI0_IRQ		0
 #define BCM_6345_ENET0_RXDMA_IRQ	(IRQ_INTERNAL_BASE + 13 + 1)
 #define BCM_6345_ENET0_TXDMA_IRQ	(IRQ_INTERNAL_BASE + 13 + 2)
-#define BCM_6345_EBI_RX_IRQ		(IRQ_INTERNAL_BASE + 13 + 5)
-#define BCM_6345_EBI_TX_IRQ		(IRQ_INTERNAL_BASE + 13 + 6)
-#define BCM_6345_RESERVED_RX_IRQ	(IRQ_INTERNAL_BASE + 13 + 9)
-#define BCM_6345_RESERVED_TX_IRQ	(IRQ_INTERNAL_BASE + 13 + 10)
-#define BCM_6345_USB_BULK_RX_DMA_IRQ	(IRQ_INTERNAL_BASE + 13 + 13)
-#define BCM_6345_USB_BULK_TX_DMA_IRQ	(IRQ_INTERNAL_BASE + 13 + 14)
-#define BCM_6345_USB_CNTL_RX_DMA_IRQ	(IRQ_INTERNAL_BASE + 13 + 15)
-#define BCM_6345_USB_CNTL_TX_DMA_IRQ	(IRQ_INTERNAL_BASE + 13 + 16)
-#define BCM_6345_USB_ISO_RX_DMA_IRQ	(IRQ_INTERNAL_BASE + 13 + 17)
-#define BCM_6345_USB_ISO_TX_DMA_IRQ	(IRQ_INTERNAL_BASE + 13 + 18)
+#define BCM_6345_ENET1_RXDMA_IRQ	0
+#define BCM_6345_ENET1_TXDMA_IRQ	0
+#define BCM_6345_PCI_IRQ		0
+#define BCM_6345_PCMCIA_IRQ		0
 
 /*
  * 6348 irqs
  */
 #define BCM_6348_TIMER_IRQ		(IRQ_INTERNAL_BASE + 0)
 #define BCM_6348_UART0_IRQ		(IRQ_INTERNAL_BASE + 2)
+#define BCM_6348_UART1_IRQ		0
 #define BCM_6348_DSL_IRQ		(IRQ_INTERNAL_BASE + 4)
-#define BCM_6348_ENET1_IRQ		(IRQ_INTERNAL_BASE + 7)
 #define BCM_6348_ENET0_IRQ		(IRQ_INTERNAL_BASE + 8)
+#define BCM_6348_ENET1_IRQ		(IRQ_INTERNAL_BASE + 7)
 #define BCM_6348_ENET_PHY_IRQ		(IRQ_INTERNAL_BASE + 9)
 #define BCM_6348_OHCI0_IRQ		(IRQ_INTERNAL_BASE + 12)
+#define BCM_6348_EHCI0_IRQ		0
 #define BCM_6348_ENET0_RXDMA_IRQ	(IRQ_INTERNAL_BASE + 20)
 #define BCM_6348_ENET0_TXDMA_IRQ	(IRQ_INTERNAL_BASE + 21)
 #define BCM_6348_ENET1_RXDMA_IRQ	(IRQ_INTERNAL_BASE + 22)
 #define BCM_6348_ENET1_TXDMA_IRQ	(IRQ_INTERNAL_BASE + 23)
-#define BCM_6348_PCMCIA_IRQ		(IRQ_INTERNAL_BASE + 24)
 #define BCM_6348_PCI_IRQ		(IRQ_INTERNAL_BASE + 24)
+#define BCM_6348_PCMCIA_IRQ		(IRQ_INTERNAL_BASE + 24)
 
 /*
  * 6358 irqs
@@ -525,21 +395,38 @@ enum bcm63xx_irq {
 #define BCM_6358_TIMER_IRQ		(IRQ_INTERNAL_BASE + 0)
 #define BCM_6358_UART0_IRQ		(IRQ_INTERNAL_BASE + 2)
 #define BCM_6358_UART1_IRQ		(IRQ_INTERNAL_BASE + 3)
-#define BCM_6358_OHCI0_IRQ		(IRQ_INTERNAL_BASE + 5)
-#define BCM_6358_ENET1_IRQ		(IRQ_INTERNAL_BASE + 6)
+#define BCM_6358_DSL_IRQ		(IRQ_INTERNAL_BASE + 29)
 #define BCM_6358_ENET0_IRQ		(IRQ_INTERNAL_BASE + 8)
+#define BCM_6358_ENET1_IRQ		(IRQ_INTERNAL_BASE + 6)
 #define BCM_6358_ENET_PHY_IRQ		(IRQ_INTERNAL_BASE + 9)
+#define BCM_6358_OHCI0_IRQ		(IRQ_INTERNAL_BASE + 5)
 #define BCM_6358_EHCI0_IRQ		(IRQ_INTERNAL_BASE + 10)
 #define BCM_6358_ENET0_RXDMA_IRQ	(IRQ_INTERNAL_BASE + 15)
 #define BCM_6358_ENET0_TXDMA_IRQ	(IRQ_INTERNAL_BASE + 16)
 #define BCM_6358_ENET1_RXDMA_IRQ	(IRQ_INTERNAL_BASE + 17)
 #define BCM_6358_ENET1_TXDMA_IRQ	(IRQ_INTERNAL_BASE + 18)
-#define BCM_6358_DSL_IRQ		(IRQ_INTERNAL_BASE + 29)
 #define BCM_6358_PCI_IRQ		(IRQ_INTERNAL_BASE + 31)
 #define BCM_6358_PCMCIA_IRQ		(IRQ_INTERNAL_BASE + 24)
 
 extern const int *bcm63xx_irqs;
 
+#define __GEN_CPU_IRQ_TABLE(__cpu)					\
+	[IRQ_TIMER]		= BCM_## __cpu ##_TIMER_IRQ,		\
+	[IRQ_UART0]		= BCM_## __cpu ##_UART0_IRQ,		\
+	[IRQ_UART1]		= BCM_## __cpu ##_UART1_IRQ,		\
+	[IRQ_DSL]		= BCM_## __cpu ##_DSL_IRQ,		\
+	[IRQ_ENET0]		= BCM_## __cpu ##_ENET0_IRQ,		\
+	[IRQ_ENET1]		= BCM_## __cpu ##_ENET1_IRQ,		\
+	[IRQ_ENET_PHY]		= BCM_## __cpu ##_ENET_PHY_IRQ,		\
+	[IRQ_OHCI0]		= BCM_## __cpu ##_OHCI0_IRQ,		\
+	[IRQ_EHCI0]		= BCM_## __cpu ##_EHCI0_IRQ,		\
+	[IRQ_ENET0_RXDMA]	= BCM_## __cpu ##_ENET0_RXDMA_IRQ,	\
+	[IRQ_ENET0_TXDMA]	= BCM_## __cpu ##_ENET0_TXDMA_IRQ,	\
+	[IRQ_ENET1_RXDMA]	= BCM_## __cpu ##_ENET1_RXDMA_IRQ,	\
+	[IRQ_ENET1_TXDMA]	= BCM_## __cpu ##_ENET1_TXDMA_IRQ,	\
+	[IRQ_PCI]		= BCM_## __cpu ##_PCI_IRQ,		\
+	[IRQ_PCMCIA]		= BCM_## __cpu ##_PCMCIA_IRQ,		\
+
 static inline int bcm63xx_get_irq_number(enum bcm63xx_irq irq)
 {
 	return bcm63xx_irqs[irq];
-- 
1.7.1.1
