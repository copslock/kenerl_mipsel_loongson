Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Aug 2009 23:50:04 +0200 (CEST)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:57177 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492984AbZHGVru (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 7 Aug 2009 23:47:50 +0200
Received: by ewy12 with SMTP id 12so2283026ewy.0
        for <multiple recipients>; Fri, 07 Aug 2009 14:47:45 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:cc:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=2/s/llznYIKaL0zNc7KHJ4uvf4Aappy63bH4A4yO0gk=;
        b=IexhnaXXqqZwqkVNutrxvCMAUzE1x2A+EE2HbvNm4uHTuNHRkC2IWwq5QXG+Mq1Tm4
         2p8ccvrKcTG4XyXTC2UtYYgpMcCeGSrMZ5xRQFpHSTCvK7VrhoX6XfvBNdc8bXv8Syly
         NdJWwLgG+LnF4lr6cIWoEmB3E2eKeM4ZayFxc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:cc
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=bNjFbrYaAMC8c9CR1mT7nfH8OyoFF4htO5yFsj3AXF7SJq9HwJUQSmEaB1tGuZXrIk
         7b+5IPsbX2G3UkXr6ArDN9TLOpktVWqbS+4mmfqoD+ImfsgHBhn+XiYrYtydoBhfzN9s
         9Gd11z2mnzg012PEc3aiwDfN+ThvjSa4wTWhw=
Received: by 10.210.63.18 with SMTP id l18mr1965991eba.67.1249681630865;
        Fri, 07 Aug 2009 14:47:10 -0700 (PDT)
Received: from lenovo.mimichou.home (home.mimichou.net [82.67.132.19])
        by mx.google.com with ESMTPS id 28sm4262227eyg.52.2009.08.07.14.47.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 07 Aug 2009 14:47:10 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Fri, 7 Aug 2009 23:46:58 +0200
Subject: [PATCH 6/8] bcm63xx: add support for BCM6345 SoC
MIME-Version: 1.0
X-UID:	1183
X-Length: 12527
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Maxime Bizon <mbizon@freebox.fr>, linux-mips@linux-mips.org
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200908072346.58740.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23860
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch adds support for the BCM6345 SoC. This is
the very first generation of BCM63xx. A couple of modifications
needs to be made:
- bcm6345 does not support r4k_wait, disable it
- bcm6345 does not have SPI or MPI

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/bcm63xx/Kconfig b/arch/mips/bcm63xx/Kconfig
index 325f69a..4aa21e8 100644
--- a/arch/mips/bcm63xx/Kconfig
+++ b/arch/mips/bcm63xx/Kconfig
@@ -8,6 +8,11 @@ config BCM63XX_CPU_6338
 	select USB_OHCI_BIG_ENDIAN_DESC
 	select USB_OHCI_BIG_ENDIAN_MMIO
 
+config BCM63XX_CPU_6345
+	bool "support 6345 CPU"
+	select USB_OHCI_BIG_ENDIAN_DESC
+	select USB_OHCI_BIG_ENDIAN_MMIO
+
 config BCM63XX_CPU_6348
 	bool "support 6348 CPU"
 	select HW_HAS_PCI
diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
index d189965..4e2309a 100644
--- a/arch/mips/bcm63xx/clk.c
+++ b/arch/mips/bcm63xx/clk.c
@@ -51,6 +51,8 @@ static void enet_misc_set(struct clk *clk, int enable)
 
 	if (BCMCPU_IS_6338())
 		mask = CKCTL_6338_ENET_EN;
+	else if (BCMCPU_IS_6345())
+		mask = CKCTL_6345_ENET_EN;
 	else if (BCMCPU_IS_6348())
 		mask = CKCTL_6348_ENET_EN;
 	else
diff --git a/arch/mips/bcm63xx/cpu.c b/arch/mips/bcm63xx/cpu.c
index cb41855..79b76a4 100644
--- a/arch/mips/bcm63xx/cpu.c
+++ b/arch/mips/bcm63xx/cpu.c
@@ -63,6 +63,43 @@ static const int bcm96338_irqs[] = {
 };
 
 /*
+ * 6345 register sets and irqs
+ */
+static const unsigned long bcm96345_regs_base[] = {
+	[RSET_DSL_LMEM]		= BCM_6345_DSL_LMEM_BASE,
+	[RSET_PERF]		= BCM_6345_PERF_BASE,
+	[RSET_TIMER]		= BCM_6345_TIMER_BASE,
+	[RSET_WDT]		= BCM_6345_WDT_BASE,
+	[RSET_UART0]		= BCM_6345_UART0_BASE,
+	[RSET_GPIO]		= BCM_6345_GPIO_BASE,
+	[RSET_SPI]		= BCM_6345_SPI_BASE,
+	[RSET_UDC0]		= BCM_6345_UDC0_BASE,
+	[RSET_OHCI0]		= BCM_6345_OHCI0_BASE,
+	[RSET_OHCI_PRIV]	= BCM_6345_OHCI_PRIV_BASE,
+	[RSET_USBH_PRIV]	= BCM_6345_USBH_PRIV_BASE,
+	[RSET_MPI]		= BCM_6345_MPI_BASE,
+	[RSET_PCMCIA]		= BCM_6345_PCMCIA_BASE,
+	[RSET_DSL]		= BCM_6345_DSL_BASE,
+	[RSET_ENET0]		= BCM_6345_ENET0_BASE,
+	[RSET_ENET1]		= BCM_6345_ENET1_BASE,
+	[RSET_ENETDMA]		= BCM_6345_ENETDMA_BASE,
+	[RSET_EHCI0]		= BCM_6345_EHCI0_BASE,
+	[RSET_SDRAM]		= BCM_6345_SDRAM_BASE,
+	[RSET_MEMC]		= BCM_6345_MEMC_BASE,
+	[RSET_DDR]		= BCM_6345_DDR_BASE,
+};
+
+static const int bcm96345_irqs[] = {
+	[IRQ_TIMER]		= BCM_6345_TIMER_IRQ,
+	[IRQ_UART0]		= BCM_6345_UART0_IRQ,
+	[IRQ_DSL]		= BCM_6345_DSL_IRQ,
+	[IRQ_ENET0]		= BCM_6345_ENET0_IRQ,
+	[IRQ_ENET_PHY]		= BCM_6345_ENET_PHY_IRQ,
+	[IRQ_ENET0_RXDMA]	= BCM_6345_ENET0_RXDMA_IRQ,
+	[IRQ_ENET0_TXDMA]	= BCM_6345_ENET0_TXDMA_IRQ,
+};
+
+/*
  * 6348 register sets and irqs
  */
 static const unsigned long bcm96348_regs_base[] = {
@@ -177,6 +214,10 @@ static unsigned int detect_cpu_clock(void)
 	/* BCM6338 has a fixed 240 Mhz frequency */
 	if (BCMCPU_IS_6338())
 		return 240000000;
+	
+	/* BCM6345 has a fixed 140Mhz frequency */
+	if (BCMCPU_IS_6345())
+		return 140000000;
 
 	/*
 	 * frequency depends on PLL configuration:
@@ -210,6 +251,9 @@ static unsigned int detect_memory_size(void)
 {
 	unsigned int cols = 0, rows = 0, is_32bits = 0, banks = 0;
 	u32 val;
+	
+	if (BCMCPU_IS_6345())
+		return (8 * 1024 * 1024);
 
 	if (BCMCPU_IS_6338() || BCMCPU_IS_6348()) {
 		val = bcm_sdram_readl(SDRAM_CFG_REG);
@@ -252,6 +296,11 @@ void __init bcm63xx_cpu_init(void)
 		bcm63xx_regs_base = bcm96338_regs_base;
 		bcm63xx_irqs = bcm96338_irqs;
 		break;
+	case CPU_BCM6345:
+		expected_cpu_id = BCM6345_CPU_ID;
+		bcm63xx_regs_base = bcm96345_regs_base;
+		bcm63xx_irqs = bcm96345_irqs;
+		break;
 	case CPU_BCM6348:
 		expected_cpu_id = BCM6348_CPU_ID;
 		bcm63xx_regs_base = bcm96348_regs_base;
diff --git a/arch/mips/bcm63xx/prom.c b/arch/mips/bcm63xx/prom.c
index 6a41acb..d36ee03 100644
--- a/arch/mips/bcm63xx/prom.c
+++ b/arch/mips/bcm63xx/prom.c
@@ -27,6 +27,8 @@ void __init prom_init(void)
 	/* disable all hardware blocks clock for now */
 	if (BCMCPU_IS_6338())
 		mask = CKCTL_6338_ALL_SAFE_EN;
+	else if (BCMCPU_IS_6345())
+		mask = CKCTL_6345_ALL_SAFE_EN;
 	else if (BCMCPU_IS_6348())
 		mask = CKCTL_6348_ALL_SAFE_EN;
 	else
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
index 3c107d0..b12c4ac 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
@@ -10,6 +10,7 @@
  * arm mach-types)
  */
 #define BCM6338_CPU_ID		0x6338
+#define BCM6345_CPU_ID		0x6345
 #define BCM6348_CPU_ID		0x6348
 #define BCM6358_CPU_ID		0x6358
 
@@ -31,6 +32,19 @@ unsigned int bcm63xx_get_cpu_freq(void);
 # define BCMCPU_IS_6338()	(0)
 #endif
 
+#ifdef CONFIG_BCM63XX_CPU_6345
+# ifdef bcm63xx_get_cpu_id
+#  undef bcm63xx_get_cpu_id
+#  define bcm63xx_get_cpu_id()	__bcm63xx_get_cpu_id()
+#  define BCMCPU_RUNTIME_DETECT
+# else
+#  define bcm63xx_get_cpu_id()	BCM6345_CPU_ID
+# endif
+# define BCMCPU_IS_6345()	(bcm63xx_get_cpu_id() == BCM6345_CPU_ID)
+#else
+# define BCMCPU_IS_6345()	(0)
+#endif
+
 #ifdef CONFIG_BCM63XX_CPU_6348
 # ifdef bcm63xx_get_cpu_id
 #  undef bcm63xx_get_cpu_id
@@ -131,6 +145,36 @@ enum bcm63xx_regs_set {
 #define BCM_6338_DDR_BASE		(0xdeadbeef)
 
 /*
+ * 6345 register sets base address
+ */
+#define BCM_6345_DSL_LMEM_BASE		(0xfff00000)
+#define BCM_6345_PERF_BASE		(0xfffe0000)
+#define BCM_6345_BB_BASE		(0xfffe0100)
+#define BCM_6345_TIMER_BASE		(0xfffe0200)
+#define BCM_6345_WDT_BASE		(0xfffe021c)
+#define BCM_6345_UART0_BASE		(0xfffe0300)
+#define BCM_6345_GPIO_BASE		(0xfffe0400)
+#define BCM_6345_SPI_BASE		(0xdeadbeef)
+#define BCM_6345_UDC0_BASE		(0xdeadbeef)
+#define BCM_6345_USBDMA_BASE		(0xfffe2800)
+#define BCM_6345_ENET0_BASE		(0xfffe1800)
+#define BCM_6345_ENETDMA_BASE		(0xfffe2800)
+#define BCM_6345_PCMCIA_BASE		(0xfffe2028)
+#define BCM_6345_MPI_BASE		(0xdeadbeef)
+#define BCM_6345_OHCI0_BASE		(0xfffe2100)
+#define BCM_6345_OHCI_PRIV_BASE		(0xfffe2200)
+#define BCM_6345_USBH_PRIV_BASE		(0xdeadbeef)
+#define BCM_6345_SDRAM_REGS_BASE	(0xfffe2300)
+#define BCM_6345_DSL_BASE		(0xdeadbeef)
+#define BCM_6345_SAR_BASE		(0xdeadbeef)
+#define BCM_6345_UBUS_BASE		(0xdeadbeef)
+#define BCM_6345_ENET1_BASE		(0xdeadbeef)
+#define BCM_6345_EHCI0_BASE		(0xdeadbeef)
+#define BCM_6345_SDRAM_BASE		(0xfffe2300)
+#define BCM_6345_MEMC_BASE		(0xdeadbeef)
+#define BCM_6345_DDR_BASE		(0xdeadbeef)
+
+/*
  * 6348 register sets base address
  */
 #define BCM_6348_DSL_LMEM_BASE		(0xfff00000)
@@ -236,6 +280,52 @@ static inline unsigned long bcm63xx_regset_address(enum bcm63xx_regs_set set)
 		return BCM_6338_DDR_BASE;
 	}
 #endif
+#ifdef CONFIG_BCM63XX_CPU_6345
+	switch (set) {
+	case RSET_DSL_LMEM:
+		return BCM_6345_DSL_LMEM_BASE;
+	case RSET_PERF:
+		return BCM_6345_PERF_BASE;
+	case RSET_TIMER:
+		return BCM_6345_TIMER_BASE;
+	case RSET_WDT:
+		return BCM_6345_WDT_BASE;
+	case RSET_UART0:
+		return BCM_6345_UART0_BASE;
+	case RSET_GPIO:
+		return BCM_6345_GPIO_BASE;
+	case RSET_SPI:
+		return BCM_6345_SPI_BASE;
+	case RSET_UDC0:
+		return BCM_6345_UDC0_BASE;
+	case RSET_OHCI0:
+		return BCM_6345_OHCI0_BASE;
+	case RSET_OHCI_PRIV:
+		return BCM_6345_OHCI_PRIV_BASE;
+	case RSET_USBH_PRIV:
+		return BCM_6345_USBH_PRIV_BASE;
+	case RSET_MPI:
+		return BCM_6345_MPI_BASE;
+	case RSET_PCMCIA:
+		return BCM_6345_PCMCIA_BASE;
+	case RSET_DSL:
+		return BCM_6345_DSL_BASE;
+	case RSET_ENET0:
+		return BCM_6345_ENET0_BASE;
+	case RSET_ENET1:
+		return BCM_6345_ENET1_BASE;
+	case RSET_ENETDMA:
+		return BCM_6345_ENETDMA_BASE;
+	case RSET_EHCI0:
+		return BCM_6345_EHCI0_BASE;
+	case RSET_SDRAM:
+		return BCM_6345_SDRAM_BASE;
+	case RSET_MEMC:
+		return BCM_6345_MEMC_BASE;
+	case RSET_DDR:
+		return BCM_6345_DDR_BASE;
+	}
+#endif
 #ifdef CONFIG_BCM63XX_CPU_6348
 	switch (set) {
 	case RSET_DSL_LMEM:
@@ -376,6 +466,29 @@ enum bcm63xx_irq {
 #define BCM_6338_SDIO_IRQ		(IRQ_INTERNAL_BASE + 17)
 
 /*
+ * 6345 irqs
+ */
+#define BCM_6345_TIMER_IRQ		(IRQ_INTERNAL_BASE + 0)
+#define BCM_6345_UART0_IRQ		(IRQ_INTERNAL_BASE + 2)
+#define BCM_6345_DSL_IRQ		(IRQ_INTERNAL_BASE + 3)
+#define BCM_6345_ATM_IRQ		(IRQ_INTERNAL_BASE + 4)
+#define BCM_6345_USB_IRQ		(IRQ_INTERNAL_BASE + 5)
+#define BCM_6345_ENET0_IRQ		(IRQ_INTERNAL_BASE + 8)
+#define BCM_6345_ENET_PHY_IRQ		(IRQ_INTERNAL_BASE + 12)
+#define BCM_6345_ENET0_RXDMA_IRQ	(IRQ_INTERNAL_BASE + 13 + 1)
+#define BCM_6345_ENET0_TXDMA_IRQ	(IRQ_INTERNAL_BASE + 13 + 2)
+#define BCM_6345_EBI_RX_IRQ		(IRQ_INTERNAL_BASE + 13 + 5)
+#define BCM_6345_EBI_TX_IRQ		(IRQ_INTERNAL_BASE + 13 + 6)
+#define BCM_6345_RESERVED_RX_IRQ	(IRQ_INTERNAL_BASE + 13 + 9)
+#define BCM_6345_RESERVED_TX_IRQ	(IRQ_INTERNAL_BASE + 13 + 10)
+#define BCM_6345_USB_BULK_RX_DMA_IRQ	(IRQ_INTERNAL_BASE + 13 + 13)
+#define BCM_6345_USB_BULK_TX_DMA_IRQ	(IRQ_INTERNAL_BASE + 13 + 14)
+#define BCM_6345_USB_CNTL_RX_DMA_IRQ	(IRQ_INTERNAL_BASE + 13 + 15)
+#define BCM_6345_USB_CNTL_TX_DMA_IRQ	(IRQ_INTERNAL_BASE + 13 + 16)
+#define BCM_6345_USB_ISO_RX_DMA_IRQ	(IRQ_INTERNAL_BASE + 13 + 17)
+#define BCM_6345_USB_ISO_TX_DMA_IRQ	(IRQ_INTERNAL_BASE + 13 + 18)
+
+/*
  * 6348 irqs
  */
 #define BCM_6348_TIMER_IRQ		(IRQ_INTERNAL_BASE + 0)
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
index 3249e8c..48dcb43 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
@@ -29,6 +29,18 @@
 					CKCTL_6338_SAR_EN |		\
 					CKCTL_6338_SPI_EN)
 
+#define CKCTL_6345_CPU_EN		(1 << 0)
+#define CKCTL_6345_BUS_EN		(1 << 1)
+#define CKCTL_6345_EBI_EN		(1 << 2)
+#define CKCTL_6345_UART_EN		(1 << 3)
+#define CKCTL_6345_ADSLPHY_EN		(1 << 4)
+#define CKCTL_6345_ENET_EN		(1 << 7)
+#define CKCTL_6345_USBH_EN		(1 << 8)
+
+#define CKCTL_6345_ALL_SAFE_EN		(CKCTL_6345_ENET_EN |	\
+					CKCTL_6345_USBH_EN |	\
+					CKCTL_6345_ADSLPHY_EN)
+
 #define CKCTL_6348_ADSLPHY_EN		(1 << 0)
 #define CKCTL_6348_MPI_EN		(1 << 1)
 #define CKCTL_6348_SDRAM_EN		(1 << 2)
diff --git a/arch/mips/include/asm/mach-bcm63xx/cpu-feature-overrides.h b/arch/mips/include/asm/mach-bcm63xx/cpu-feature-overrides.h
index 80c3aa2..71742ba 100644
--- a/arch/mips/include/asm/mach-bcm63xx/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-bcm63xx/cpu-feature-overrides.h
@@ -24,7 +24,7 @@
 #define cpu_has_smartmips		0
 #define cpu_has_vtag_icache		0
 
-#if !defined(BCMCPU_RUNTIME_DETECT) && (defined(CONFIG_BCMCPU_IS_6348) || defined(CONFIG_CPU_IS_6338))
+#if !defined(BCMCPU_RUNTIME_DETECT) && (defined(CONFIG_BCMCPU_IS_6348) || defined(CONFIG_CPU_IS_6338) || defined(CONFIG_CPU_IS_BCM6345))
 #define cpu_has_dc_aliases		0
 #endif
 
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index ae53992..251a268 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -160,7 +160,6 @@ void __init check_wait(void)
 	case CPU_PR4450:
 	case CPU_BCM3302:
 	case CPU_BCM6338:
-	case CPU_BCM6345:
 	case CPU_BCM6348:
 	case CPU_BCM6358:
 	case CPU_CAVIUM_OCTEON:
