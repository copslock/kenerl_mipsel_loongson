Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Aug 2009 23:48:27 +0200 (CEST)
Received: from ey-out-1920.google.com ([74.125.78.148]:16508 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492923AbZHGVrJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 7 Aug 2009 23:47:09 +0200
Received: by ey-out-1920.google.com with SMTP id 13so537922eye.54
        for <multiple recipients>; Fri, 07 Aug 2009 14:47:09 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:cc:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=L84FbzSxBsHVlseTm02JzCBKJY4jxDFg39Fi9RotkQk=;
        b=Y1S88PGrUT85Nz2YZi4sxp2R1+tlITAuDIwBL203X0kQiJF2n/2gjBdg+jwyOuV2Fb
         myoBkzGu4p9jIM14hDJjAk6yLmpndWfUemtRqG4LbRiB9XHioiyzp310wiFMGUZJAKkR
         L+Okeaa1QWFjxBHJY/GGNIwAhFYoJPXLscYlc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:cc
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=QPnjUtVLWffxGRnQq/jcq2aXFj24zCXpaf2jjRXd+Pa+STJgLk/nNvakg5Vm19TKPA
         c5aKafeg3Y4HJjjJQ2E8yoAlbuqaWPbqj01qWaLoow1rwrC9xtEI1X1l4H3F5hZRClmo
         kAF3lJZBsC50mHOxL4C0WrvP0A6DwBxLwaIoI=
Received: by 10.210.20.6 with SMTP id 6mr1980320ebt.59.1249681607262;
        Fri, 07 Aug 2009 14:46:47 -0700 (PDT)
Received: from lenovo.mimichou.home (home.mimichou.net [82.67.132.19])
        by mx.google.com with ESMTPS id 28sm4262227eyg.52.2009.08.07.14.46.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 07 Aug 2009 14:46:47 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Fri, 7 Aug 2009 23:46:44 +0200
Subject: [PATCH 4/8] bcm63xx: add support for the BCM6338 SoC
MIME-Version: 1.0
X-UID:	1181
X-Length: 14248
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Maxime Bizon <mbizon@freebox.fr>, linux-mips@linux-mips.org
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200908072346.45245.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23856
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch adds support for the BCM6338 SoC, it is very similar
to BCM6348 except that:
- the CPU frequency is not locked on PLL and is fixed
- there is only one Ethernet MAC therefore the DMA zone is twice smaller

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/bcm63xx/Kconfig b/arch/mips/bcm63xx/Kconfig
index 8c192e7..325f69a 100644
--- a/arch/mips/bcm63xx/Kconfig
+++ b/arch/mips/bcm63xx/Kconfig
@@ -1,6 +1,13 @@
 menu "CPU support"
 	depends on BCM63XX
 
+config BCM63XX_CPU_6338
+	bool "support 6338 CPU"
+	select HW_HAS_PCI
+	select USB_ARCH_HAS_OHCI
+	select USB_OHCI_BIG_ENDIAN_DESC
+	select USB_OHCI_BIG_ENDIAN_MMIO
+
 config BCM63XX_CPU_6348
 	bool "support 6348 CPU"
 	select HW_HAS_PCI
diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
index ae1f41f..d189965 100644
--- a/arch/mips/bcm63xx/clk.c
+++ b/arch/mips/bcm63xx/clk.c
@@ -49,7 +49,9 @@ static void enet_misc_set(struct clk *clk, int enable)
 {
 	u32 mask;
 
-	if (BCMCPU_IS_6348())
+	if (BCMCPU_IS_6338())
+		mask = CKCTL_6338_ENET_EN;
+	else if (BCMCPU_IS_6348())
 		mask = CKCTL_6348_ENET_EN;
 	else
 		/* BCMCPU_IS_6358 */
@@ -143,7 +145,9 @@ static void spi_set(struct clk *clk, int enable)
 {
 	u32 mask;
 
-	if (BCMCPU_IS_6348())
+	if (BCMCPU_IS_6338())
+		mask = CKCTL_6338_SPI_EN;
+	else if (BCMCPU_IS_6348())
 		mask = CKCTL_6348_SPI_EN;
 	else
 		/* BCMCPU_IS_6358 */
diff --git a/arch/mips/bcm63xx/cpu.c b/arch/mips/bcm63xx/cpu.c
index 9d6cfce..cb41855 100644
--- a/arch/mips/bcm63xx/cpu.c
+++ b/arch/mips/bcm63xx/cpu.c
@@ -4,6 +4,7 @@
  * for more details.
  *
  * Copyright (C) 2008 Maxime Bizon <mbizon@freebox.fr>
+ * Copyright (C) 2009 Florian Fainelli <florian@openwrt.org>
  */
 
 #include <linux/kernel.h>
@@ -26,6 +27,42 @@ static unsigned int bcm63xx_cpu_freq;
 static unsigned int bcm63xx_memory_size;
 
 /*
+ * 6338 register sets and irqs
+ */
+static const unsigned long bcm96338_regs_base[] = {
+	[RSET_DSL_LMEM]		= BCM_6338_DSL_LMEM_BASE,
+	[RSET_PERF]		= BCM_6338_PERF_BASE,
+	[RSET_TIMER]		= BCM_6338_TIMER_BASE,
+	[RSET_WDT]		= BCM_6338_WDT_BASE,
+	[RSET_UART0]		= BCM_6338_UART0_BASE,
+	[RSET_GPIO]		= BCM_6338_GPIO_BASE,
+	[RSET_SPI]		= BCM_6338_SPI_BASE,
+	[RSET_OHCI0]		= BCM_6338_OHCI0_BASE,
+	[RSET_OHCI_PRIV]	= BCM_6338_OHCI_PRIV_BASE,
+	[RSET_USBH_PRIV]	= BCM_6338_USBH_PRIV_BASE,
+	[RSET_UDC0]		= BCM_6338_UDC0_BASE,
+	[RSET_MPI]		= BCM_6338_MPI_BASE,
+	[RSET_PCMCIA]		= BCM_6338_PCMCIA_BASE,
+	[RSET_SDRAM]		= BCM_6338_SDRAM_BASE,
+	[RSET_DSL]		= BCM_6338_DSL_BASE,
+	[RSET_ENET0]		= BCM_6338_ENET0_BASE,
+	[RSET_ENET1]		= BCM_6338_ENET1_BASE,
+	[RSET_ENETDMA]		= BCM_6338_ENETDMA_BASE,
+	[RSET_MEMC]		= BCM_6338_MEMC_BASE,
+	[RSET_DDR]		= BCM_6338_DDR_BASE,
+};
+
+static const int bcm96338_irqs[] = {
+	[IRQ_TIMER]		= BCM_6338_TIMER_IRQ,
+	[IRQ_UART0]		= BCM_6338_UART0_IRQ,
+	[IRQ_DSL]		= BCM_6338_DSL_IRQ,
+	[IRQ_ENET0]		= BCM_6338_ENET0_IRQ,
+	[IRQ_ENET_PHY]		= BCM_6338_ENET_PHY_IRQ,
+	[IRQ_ENET0_RXDMA]	= BCM_6338_ENET0_RXDMA_IRQ,
+	[IRQ_ENET0_TXDMA]	= BCM_6338_ENET0_TXDMA_IRQ,
+};
+
+/*
  * 6348 register sets and irqs
  */
 static const unsigned long bcm96348_regs_base[] = {
@@ -137,6 +174,10 @@ static unsigned int detect_cpu_clock(void)
 {
 	unsigned int tmp, n1 = 0, n2 = 0, m1 = 0;
 
+	/* BCM6338 has a fixed 240 Mhz frequency */
+	if (BCMCPU_IS_6338())
+		return 240000000;
+
 	/*
 	 * frequency depends on PLL configuration:
 	 */
@@ -170,7 +211,7 @@ static unsigned int detect_memory_size(void)
 	unsigned int cols = 0, rows = 0, is_32bits = 0, banks = 0;
 	u32 val;
 
-	if (BCMCPU_IS_6348()) {
+	if (BCMCPU_IS_6338() || BCMCPU_IS_6348()) {
 		val = bcm_sdram_readl(SDRAM_CFG_REG);
 		rows = (val & SDRAM_CFG_ROW_MASK) >> SDRAM_CFG_ROW_SHIFT;
 		cols = (val & SDRAM_CFG_COL_MASK) >> SDRAM_CFG_COL_SHIFT;
@@ -204,6 +245,13 @@ void __init bcm63xx_cpu_init(void)
 	expected_cpu_id = 0;
 
 	switch (c->cputype) {
+	/* BCM6338 as the same PrId as BCM3302 see
+	 * arch/mips/kernel/cpu-probe.c */
+	case CPU_BCM3302:
+		expected_cpu_id = BCM6338_CPU_ID;
+		bcm63xx_regs_base = bcm96338_regs_base;
+		bcm63xx_irqs = bcm96338_irqs;
+		break;
 	case CPU_BCM6348:
 		expected_cpu_id = BCM6348_CPU_ID;
 		bcm63xx_regs_base = bcm96348_regs_base;
diff --git a/arch/mips/bcm63xx/dev-enet.c b/arch/mips/bcm63xx/dev-enet.c
index 188fa66..9f544ba 100644
--- a/arch/mips/bcm63xx/dev-enet.c
+++ b/arch/mips/bcm63xx/dev-enet.c
@@ -107,7 +107,10 @@ int __init bcm63xx_enet_register(int unit,
 	if (!shared_device_registered) {
 		shared_res[0].start = bcm63xx_regset_address(RSET_ENETDMA);
 		shared_res[0].end = shared_res[0].start;
-		shared_res[0].end += RSET_ENETDMA_SIZE - 1;
+		if (BCMCPU_IS_6338())
+			shared_res[0].end += (RSET_ENETDMA_SIZE / 2)  - 1;
+		else
+			shared_res[0].end += (RSET_ENETDMA_SIZE)  - 1;
 
 		ret = platform_device_register(&bcm63xx_enet_shared_device);
 		if (ret)
diff --git a/arch/mips/bcm63xx/prom.c b/arch/mips/bcm63xx/prom.c
index d97ceed..6a41acb 100644
--- a/arch/mips/bcm63xx/prom.c
+++ b/arch/mips/bcm63xx/prom.c
@@ -25,7 +25,9 @@ void __init prom_init(void)
 	bcm_wdt_writel(WDT_STOP_2, WDT_CTL_REG);
 
 	/* disable all hardware blocks clock for now */
-	if (BCMCPU_IS_6348())
+	if (BCMCPU_IS_6338())
+		mask = CKCTL_6338_ALL_SAFE_EN;
+	else if (BCMCPU_IS_6348())
 		mask = CKCTL_6348_ALL_SAFE_EN;
 	else
 		/* BCMCPU_IS_6358() */
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
index 29b61fd..3c107d0 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
@@ -9,6 +9,7 @@
  * compile time if only one CPU support is enabled (idea stolen from
  * arm mach-types)
  */
+#define BCM6338_CPU_ID		0x6338
 #define BCM6348_CPU_ID		0x6348
 #define BCM6358_CPU_ID		0x6358
 
@@ -17,6 +18,19 @@ u16 __bcm63xx_get_cpu_id(void);
 u16 bcm63xx_get_cpu_rev(void);
 unsigned int bcm63xx_get_cpu_freq(void);
 
+#ifdef CONFIG_BCM63XX_CPU_6338
+# ifdef bcm63xx_get_cpu_id
+#  undef bcm63xx_get_cpu_id
+#  define bcm63xx_get_cpu_id()	__bcm63xx_get_cpu_id()
+#  define BCMCPU_RUNTIME_DETECT
+# else
+#  define bcm63xx_get_cpu_id()	BCM6338_CPU_ID
+# endif
+# define BCMCPU_IS_6338()	(bcm63xx_get_cpu_id() == BCM6338_CPU_ID)
+#else
+# define BCMCPU_IS_6338()	(0)
+#endif
+
 #ifdef CONFIG_BCM63XX_CPU_6348
 # ifdef bcm63xx_get_cpu_id
 #  undef bcm63xx_get_cpu_id
@@ -87,6 +101,36 @@ enum bcm63xx_regs_set {
 #define RSET_PCMCIA_SIZE		12
 
 /*
+ * 6338 register sets base address
+ */
+#define BCM_6338_DSL_LMEM_BASE		(0xfff00000)
+#define BCM_6338_PERF_BASE		(0xfffe0000)
+#define BCM_6338_BB_BASE		(0xfffe0100)
+#define BCM_6338_TIMER_BASE		(0xfffe0200)
+#define BCM_6338_WDT_BASE		(0xfffe021c)
+#define BCM_6338_UART0_BASE		(0xfffe0300)
+#define BCM_6338_GPIO_BASE		(0xfffe0400)
+#define BCM_6338_SPI_BASE		(0xfffe0c00)
+#define BCM_6338_UDC0_BASE		(0xdeadbeef)
+#define BCM_6338_USBDMA_BASE		(0xfffe2400)
+#define BCM_6338_OHCI0_BASE		(0xdeadbeef)
+#define BCM_6338_OHCI_PRIV_BASE		(0xfffe3000)
+#define BCM_6338_USBH_PRIV_BASE		(0xdeadbeef)
+#define BCM_6338_MPI_BASE		(0xfffe3160)
+#define BCM_6338_PCMCIA_BASE		(0xdeadbeef)
+#define BCM_6338_SDRAM_REGS_BASE	(0xfffe3100)
+#define BCM_6338_DSL_BASE		(0xfffe1000)
+#define BCM_6338_SAR_BASE		(0xfffe2000)
+#define BCM_6338_UBUS_BASE		(0xdeadbeef)
+#define BCM_6338_ENET0_BASE		(0xfffe2800)
+#define BCM_6338_ENET1_BASE		(0xdeadbeef)
+#define BCM_6338_ENETDMA_BASE		(0xfffe2400)
+#define BCM_6338_EHCI0_BASE		(0xdeadbeef)
+#define BCM_6338_SDRAM_BASE		(0xfffe3100)
+#define BCM_6338_MEMC_BASE		(0xdeadbeef)
+#define BCM_6338_DDR_BASE		(0xdeadbeef)
+
+/*
  * 6348 register sets base address
  */
 #define BCM_6348_DSL_LMEM_BASE		(0xfff00000)
@@ -146,6 +190,52 @@ static inline unsigned long bcm63xx_regset_address(enum bcm63xx_regs_set set)
 #ifdef BCMCPU_RUNTIME_DETECT
 	return bcm63xx_regs_base[set];
 #else
+#ifdef CONFIG_BCM63XX_CPU_6338
+	switch (set) {
+	case RSET_DSL_LMEM:
+		return BCM_6338_DSL_LMEM_BASE;
+	case RSET_PERF:
+		return BCM_6338_PERF_BASE;
+	case RSET_TIMER:
+		return BCM_6338_TIMER_BASE;
+	case RSET_WDT:
+		return BCM_6338_WDT_BASE;
+	case RSET_UART0:
+		return BCM_6338_UART0_BASE;
+	case RSET_GPIO:
+		return BCM_6338_GPIO_BASE;
+	case RSET_SPI:
+		return BCM_6338_SPI_BASE;
+	case RSET_UDC0:
+		return BCM_6338_UDC0_BASE;
+	case RSET_OHCI0:
+		return BCM_6338_OHCI0_BASE;
+	case RSET_OHCI_PRIV:
+		return BCM_6338_OHCI_PRIV_BASE;
+	case RSET_USBH_PRIV:
+		return BCM_6338_USBH_PRIV_BASE;
+	case RSET_MPI:
+		return BCM_6338_MPI_BASE;
+	case RSET_PCMCIA:
+		return BCM_6338_PCMCIA_BASE;
+	case RSET_DSL:
+		return BCM_6338_DSL_BASE;
+	case RSET_ENET0:
+		return BCM_6338_ENET0_BASE;
+	case RSET_ENET1:
+		return BCM_6338_ENET1_BASE;
+	case RSET_ENETDMA:
+		return BCM_6338_ENETDMA_BASE;
+	case RSET_EHCI0:
+		return BCM_6338_EHCI0_BASE;
+	case RSET_SDRAM:
+		return BCM_6338_SDRAM_BASE;
+	case RSET_MEMC:
+		return BCM_6338_MEMC_BASE;
+	case RSET_DDR:
+		return BCM_6338_DDR_BASE;
+	}
+#endif
 #ifdef CONFIG_BCM63XX_CPU_6348
 	switch (set) {
 	case RSET_DSL_LMEM:
@@ -265,6 +355,27 @@ enum bcm63xx_irq {
 };
 
 /*
+ * 6338 irqs
+ */
+#define BCM_6338_TIMER_IRQ		(IRQ_INTERNAL_BASE + 0)
+#define BCM_6338_SPI_IRQ		(IRQ_INTERNAL_BASE + 1)
+#define BCM_6338_UART0_IRQ		(IRQ_INTERNAL_BASE + 2)
+#define BCM_6338_DG_IRQ			(IRQ_INTERNAL_BASE + 4)
+#define BCM_6338_DSL_IRQ		(IRQ_INTERNAL_BASE + 5)
+#define BCM_6338_ATM_IRQ		(IRQ_INTERNAL_BASE + 6)
+#define BCM_6338_UDC0_IRQ		(IRQ_INTERNAL_BASE + 7)
+#define BCM_6338_ENET0_IRQ		(IRQ_INTERNAL_BASE + 8)
+#define BCM_6338_ENET_PHY_IRQ		(IRQ_INTERNAL_BASE + 9)
+#define BCM_6338_SDRAM_IRQ		(IRQ_INTERNAL_BASE + 10)
+#define BCM_6338_USB_CNTL_RX_DMA_IRQ	(IRQ_INTERNAL_BASE + 11)
+#define BCM_6338_USB_CNTL_TX_DMA_IRQ	(IRQ_INTERNAL_BASE + 12)
+#define BCM_6338_USB_BULK_RX_DMA_IRQ	(IRQ_INTERNAL_BASE + 13)
+#define BCM_6338_USB_BULK_TX_DMA_IRQ	(IRQ_INTERNAL_BASE + 14)
+#define BCM_6338_ENET0_RXDMA_IRQ	(IRQ_INTERNAL_BASE + 15)
+#define BCM_6338_ENET0_TXDMA_IRQ	(IRQ_INTERNAL_BASE + 16)
+#define BCM_6338_SDIO_IRQ		(IRQ_INTERNAL_BASE + 17)
+
+/*
  * 6348 irqs
  */
 #define BCM_6348_TIMER_IRQ		(IRQ_INTERNAL_BASE + 0)
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
index 7b1dbb3..3249e8c 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
@@ -15,6 +15,20 @@
 /* Clock Control register */
 #define PERF_CKCTL_REG			0x4
 
+#define CKCTL_6338_ADSLPHY_EN		(1 << 0)
+#define CKCTL_6338_MPI_EN		(1 << 1)
+#define CKCTL_6338_DRAM_EN		(1 << 2)
+#define CKCTL_6338_ENET_EN		(1 << 4)
+#define CKCTL_6338_USBS_EN		(1 << 4)
+#define CKCTL_6338_SAR_EN		(1 << 5)
+#define CKCTL_6338_SPI_EN		(1 << 9)
+
+#define CKCTL_6338_ALL_SAFE_EN		(CKCTL_6338_ADSLPHY_EN |	\
+					CKCTL_6338_MPI_EN |		\
+					CKCTL_6338_ENET_EN |		\
+					CKCTL_6338_SAR_EN |		\
+					CKCTL_6338_SPI_EN)
+
 #define CKCTL_6348_ADSLPHY_EN		(1 << 0)
 #define CKCTL_6348_MPI_EN		(1 << 1)
 #define CKCTL_6348_SDRAM_EN		(1 << 2)
@@ -83,6 +97,25 @@
 /* Soft Reset register */
 #define PERF_SOFTRESET_REG		0x28
 
+#define SOFTRESET_6338_SPI_MASK		(1 << 0)
+#define SOFTRESET_6338_ENET_MASK	(1 << 2)
+#define SOFTRESET_6338_USBH_MASK	(1 << 3)
+#define SOFTRESET_6338_USBS_MASK	(1 << 4)
+#define SOFTRESET_6338_ADSL_MASK	(1 << 5)
+#define SOFTRESET_6338_DMAMEM_MASK	(1 << 6) 
+#define SOFTRESET_6338_SAR_MASK		(1 << 7)
+#define SOFTRESET_6338_ACLC_MASK	(1 << 8)
+#define SOFTRESET_6338_ADSLMIPSPLL_MASK	(1 << 10)
+#define SOFTRESET_6338_ALL	 (SOFTRESET_6338_SPI_MASK |		\
+				  SOFTRESET_6338_ENET_MASK |		\
+				  SOFTRESET_6338_USBH_MASK |		\
+				  SOFTRESET_6338_USBS_MASK |		\
+				  SOFTRESET_6338_ADSL_MASK |		\
+				  SOFTRESET_6338_DMAMEM_MASK |		\
+				  SOFTRESET_6338_SAR_MASK |		\
+				  SOFTRESET_6338_ACLC_MASK |		\
+				  SOFTRESET_6338_ADSLMIPSPLL_MASK)
+
 #define SOFTRESET_6348_SPI_MASK		(1 << 0)
 #define SOFTRESET_6348_ENET_MASK	(1 << 2)
 #define SOFTRESET_6348_USBH_MASK	(1 << 3)
diff --git a/arch/mips/include/asm/mach-bcm63xx/cpu-feature-overrides.h b/arch/mips/include/asm/mach-bcm63xx/cpu-feature-overrides.h
index 1a5c4b1..80c3aa2 100644
--- a/arch/mips/include/asm/mach-bcm63xx/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-bcm63xx/cpu-feature-overrides.h
@@ -24,7 +24,7 @@
 #define cpu_has_smartmips		0
 #define cpu_has_vtag_icache		0
 
-#if !defined(BCMCPU_RUNTIME_DETECT) && defined(CONFIG_BCMCPU_IS_6348)
+#if !defined(BCMCPU_RUNTIME_DETECT) && (defined(CONFIG_BCMCPU_IS_6348) || defined(CONFIG_CPU_IS_6338))
 #define cpu_has_dc_aliases		0
 #endif
 
