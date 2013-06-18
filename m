Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jun 2013 19:57:36 +0200 (CEST)
Received: from mms3.broadcom.com ([216.31.210.19]:2886 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825879Ab3FRR41ZXSH6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 18 Jun 2013 19:56:27 +0200
Received: from [10.9.208.53] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Tue, 18 Jun 2013 10:47:03 -0700
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS06.corp.ad.broadcom.com (10.9.208.53) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Tue, 18 Jun 2013 10:56:11 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP
 Server id 14.1.438.0; Tue, 18 Jun 2013 10:56:11 -0700
Received: from fainelli-desktop.broadcom.com (
 dhcp-lab-brsc-244.bri.broadcom.com [10.178.5.244]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 4656EF2D75; Tue, 18
 Jun 2013 10:56:09 -0700 (PDT)
From:   "Florian Fainelli" <florian@openwrt.org>
To:     ralf@linux-mips.org
cc:     linux-mips@linux-mips.org, cernekee@gmail.com, jogo@openwrt.org,
        "Florian Fainelli" <florian@openwrt.org>
Subject: [PATCH 3/7] MIPS: BCM63XX: add support for BCM3368 Cable Modem
Date:   Tue, 18 Jun 2013 18:55:40 +0100
Message-ID: <1371578144-12794-4-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1371578144-12794-1-git-send-email-florian@openwrt.org>
References: <1371578144-12794-1-git-send-email-florian@openwrt.org>
MIME-Version: 1.0
X-WSS-ID: 7DDE429D2L834866969-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <florian@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36983
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

The Broadcom BCM3368 Cable Modem SoC is extremely similar to the
existing BCM63xx DSL SoCs, in particular BCM6358, therefore little effort
in the existing code base is required to get it supported. This patch adds
support for the following on-chip peripherals:

- two UARTS
- GPIO
- Ethernet
- SPI
- PCI
- NOR Flash

The most noticeable difference with 3368 is that it has its peripheral
register at 0xfff8_0000 we check that separately in ioremap.h. Since
3368 is identical to 6358 for its clock and reset bits, we use them
verbatim.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/bcm63xx/Kconfig                         |   4 +
 arch/mips/bcm63xx/clk.c                           |  18 ++--
 arch/mips/bcm63xx/cpu.c                           |  28 +++++-
 arch/mips/bcm63xx/dev-flash.c                     |   1 +
 arch/mips/bcm63xx/dev-spi.c                       |   6 +-
 arch/mips/bcm63xx/dev-uart.c                      |   3 +-
 arch/mips/bcm63xx/irq.c                           |  19 ++++
 arch/mips/bcm63xx/prom.c                          |   4 +-
 arch/mips/bcm63xx/reset.c                         |  29 +++++-
 arch/mips/bcm63xx/setup.c                         |   3 +
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h  | 110 ++++++++++++++++++++++
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h |   1 +
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h |  45 ++++++++-
 arch/mips/include/asm/mach-bcm63xx/ioremap.h      |   4 +
 arch/mips/pci/pci-bcm63xx.c                       |   3 +-
 15 files changed, 259 insertions(+), 19 deletions(-)

diff --git a/arch/mips/bcm63xx/Kconfig b/arch/mips/bcm63xx/Kconfig
index 165727d..b78306c 100644
--- a/arch/mips/bcm63xx/Kconfig
+++ b/arch/mips/bcm63xx/Kconfig
@@ -1,6 +1,10 @@
 menu "CPU support"
 	depends on BCM63XX
 
+config BCM63XX_CPU_3368
+	bool "support 3368 CPU"
+	select HW_HAS_PCI
+
 config BCM63XX_CPU_6328
 	bool "support 6328 CPU"
 	select HW_HAS_PCI
diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
index c726a97..fda2690 100644
--- a/arch/mips/bcm63xx/clk.c
+++ b/arch/mips/bcm63xx/clk.c
@@ -84,7 +84,7 @@ static void enetx_set(struct clk *clk, int enable)
 	else
 		clk_disable_unlocked(&clk_enet_misc);
 
-	if (BCMCPU_IS_6358()) {
+	if (BCMCPU_IS_3368() || BCMCPU_IS_6358()) {
 		u32 mask;
 
 		if (clk->id == 0)
@@ -110,9 +110,8 @@ static struct clk clk_enet1 = {
  */
 static void ephy_set(struct clk *clk, int enable)
 {
-	if (!BCMCPU_IS_6358())
-		return;
-	bcm_hwclock_set(CKCTL_6358_EPHY_EN, enable);
+	if (BCMCPU_IS_3368() || BCMCPU_IS_6358())
+		bcm_hwclock_set(CKCTL_6358_EPHY_EN, enable);
 }
 
 
@@ -155,9 +154,10 @@ static struct clk clk_enetsw = {
  */
 static void pcm_set(struct clk *clk, int enable)
 {
-	if (!BCMCPU_IS_6358())
-		return;
-	bcm_hwclock_set(CKCTL_6358_PCM_EN, enable);
+	if (BCMCPU_IS_3368())
+		bcm_hwclock_set(CKCTL_3368_PCM_EN, enable);
+	if (BCMCPU_IS_6358())
+		bcm_hwclock_set(CKCTL_6358_PCM_EN, enable);
 }
 
 static struct clk clk_pcm = {
@@ -211,7 +211,7 @@ static void spi_set(struct clk *clk, int enable)
 		mask = CKCTL_6338_SPI_EN;
 	else if (BCMCPU_IS_6348())
 		mask = CKCTL_6348_SPI_EN;
-	else if (BCMCPU_IS_6358())
+	else if (BCMCPU_IS_3368() || BCMCPU_IS_6358())
 		mask = CKCTL_6358_SPI_EN;
 	else if (BCMCPU_IS_6362())
 		mask = CKCTL_6362_SPI_EN;
@@ -338,7 +338,7 @@ struct clk *clk_get(struct device *dev, const char *id)
 		return &clk_xtm;
 	if (!strcmp(id, "periph"))
 		return &clk_periph;
-	if (BCMCPU_IS_6358() && !strcmp(id, "pcm"))
+	if ((BCMCPU_IS_3368() || BCMCPU_IS_6358()) && !strcmp(id, "pcm"))
 		return &clk_pcm;
 	if ((BCMCPU_IS_6362() || BCMCPU_IS_6368()) && !strcmp(id, "ipsec"))
 		return &clk_ipsec;
diff --git a/arch/mips/bcm63xx/cpu.c b/arch/mips/bcm63xx/cpu.c
index 79fe32d..7e17374 100644
--- a/arch/mips/bcm63xx/cpu.c
+++ b/arch/mips/bcm63xx/cpu.c
@@ -29,6 +29,14 @@ static u8 bcm63xx_cpu_rev;
 static unsigned int bcm63xx_cpu_freq;
 static unsigned int bcm63xx_memory_size;
 
+static const unsigned long bcm3368_regs_base[] = {
+	__GEN_CPU_REGS_TABLE(3368)
+};
+
+static const int bcm3368_irqs[] = {
+	__GEN_CPU_IRQ_TABLE(3368)
+};
+
 static const unsigned long bcm6328_regs_base[] = {
 	__GEN_CPU_REGS_TABLE(6328)
 };
@@ -116,6 +124,9 @@ unsigned int bcm63xx_get_memory_size(void)
 static unsigned int detect_cpu_clock(void)
 {
 	switch (bcm63xx_get_cpu_id()) {
+	case BCM3368_CPU_ID:
+		return 300000000;
+
 	case BCM6328_CPU_ID:
 	{
 		unsigned int tmp, mips_pll_fcvo;
@@ -266,7 +277,7 @@ static unsigned int detect_memory_size(void)
 		banks = (val & SDRAM_CFG_BANK_MASK) ? 2 : 1;
 	}
 
-	if (BCMCPU_IS_6358() || BCMCPU_IS_6368()) {
+	if (BCMCPU_IS_3368() || BCMCPU_IS_6358() || BCMCPU_IS_6368()) {
 		val = bcm_memc_readl(MEMC_CFG_REG);
 		rows = (val & MEMC_CFG_ROW_MASK) >> MEMC_CFG_ROW_SHIFT;
 		cols = (val & MEMC_CFG_COL_MASK) >> MEMC_CFG_COL_SHIFT;
@@ -302,10 +313,17 @@ void __init bcm63xx_cpu_init(void)
 		chipid_reg = BCM_6345_PERF_BASE;
 		break;
 	case CPU_BMIPS4350:
-		if ((read_c0_prid() & 0xf0) == 0x10)
+		switch ((read_c0_prid() & 0xff)) {
+		case 0x04:
+			chipid_reg = BCM_3368_PERF_BASE;
+			break;
+		case 0x10:
 			chipid_reg = BCM_6345_PERF_BASE;
-		else
+			break;
+		default:
 			chipid_reg = BCM_6368_PERF_BASE;
+			break;
+		}
 		break;
 	}
 
@@ -322,6 +340,10 @@ void __init bcm63xx_cpu_init(void)
 	bcm63xx_cpu_rev = (tmp & REV_REVID_MASK) >> REV_REVID_SHIFT;
 
 	switch (bcm63xx_cpu_id) {
+	case BCM3368_CPU_ID:
+		bcm63xx_regs_base = bcm3368_regs_base;
+		bcm63xx_irqs = bcm3368_irqs;
+		break;
 	case BCM6328_CPU_ID:
 		bcm63xx_regs_base = bcm6328_regs_base;
 		bcm63xx_irqs = bcm6328_irqs;
diff --git a/arch/mips/bcm63xx/dev-flash.c b/arch/mips/bcm63xx/dev-flash.c
index 588d1ec..172dd83 100644
--- a/arch/mips/bcm63xx/dev-flash.c
+++ b/arch/mips/bcm63xx/dev-flash.c
@@ -71,6 +71,7 @@ static int __init bcm63xx_detect_flash_type(void)
 	case BCM6348_CPU_ID:
 		/* no way to auto detect so assume parallel */
 		return BCM63XX_FLASH_TYPE_PARALLEL;
+	case BCM3368_CPU_ID:
 	case BCM6358_CPU_ID:
 		val = bcm_gpio_readl(GPIO_STRAPBUS_REG);
 		if (val & STRAPBUS_6358_BOOT_SEL_PARALLEL)
diff --git a/arch/mips/bcm63xx/dev-spi.c b/arch/mips/bcm63xx/dev-spi.c
index 3065bb6..d12daed 100644
--- a/arch/mips/bcm63xx/dev-spi.c
+++ b/arch/mips/bcm63xx/dev-spi.c
@@ -37,7 +37,8 @@ static __init void bcm63xx_spi_regs_init(void)
 {
 	if (BCMCPU_IS_6338() || BCMCPU_IS_6348())
 		bcm63xx_regs_spi = bcm6348_regs_spi;
-	if (BCMCPU_IS_6358() || BCMCPU_IS_6362() || BCMCPU_IS_6368())
+	if (BCMCPU_IS_3368() || BCMCPU_IS_6358() ||
+		BCMCPU_IS_6362() || BCMCPU_IS_6368())
 		bcm63xx_regs_spi = bcm6358_regs_spi;
 }
 #else
@@ -87,7 +88,8 @@ int __init bcm63xx_spi_register(void)
 		spi_pdata.msg_ctl_width = SPI_6348_MSG_CTL_WIDTH;
 	}
 
-	if (BCMCPU_IS_6358() || BCMCPU_IS_6362() || BCMCPU_IS_6368()) {
+	if (BCMCPU_IS_3368() || BCMCPU_IS_6358() || BCMCPU_IS_6362() ||
+		BCMCPU_IS_6368()) {
 		spi_resources[0].end += BCM_6358_RSET_SPI_SIZE - 1;
 		spi_pdata.fifo_size = SPI_6358_MSG_DATA_SIZE;
 		spi_pdata.msg_type_shift = SPI_6358_MSG_TYPE_SHIFT;
diff --git a/arch/mips/bcm63xx/dev-uart.c b/arch/mips/bcm63xx/dev-uart.c
index d6e42c6..3bc7f3b 100644
--- a/arch/mips/bcm63xx/dev-uart.c
+++ b/arch/mips/bcm63xx/dev-uart.c
@@ -54,7 +54,8 @@ int __init bcm63xx_uart_register(unsigned int id)
 	if (id >= ARRAY_SIZE(bcm63xx_uart_devices))
 		return -ENODEV;
 
-	if (id == 1 && (!BCMCPU_IS_6358() && !BCMCPU_IS_6368()))
+	if (id == 1 && (!BCMCPU_IS_3368() && !BCMCPU_IS_6358() &&
+		!BCMCPU_IS_6368()))
 		return -ENODEV;
 
 	if (id == 0) {
diff --git a/arch/mips/bcm63xx/irq.c b/arch/mips/bcm63xx/irq.c
index d744606..1525f8a 100644
--- a/arch/mips/bcm63xx/irq.c
+++ b/arch/mips/bcm63xx/irq.c
@@ -27,6 +27,17 @@ static void __internal_irq_unmask_32(unsigned int irq) __maybe_unused;
 static void __internal_irq_unmask_64(unsigned int irq) __maybe_unused;
 
 #ifndef BCMCPU_RUNTIME_DETECT
+#ifdef CONFIG_BCM63XX_CPU_3368
+#define irq_stat_reg		PERF_IRQSTAT_3368_REG
+#define irq_mask_reg		PERF_IRQMASK_3368_REG
+#define irq_bits		32
+#define is_ext_irq_cascaded	0
+#define ext_irq_start		0
+#define ext_irq_end		0
+#define ext_irq_count		4
+#define ext_irq_cfg_reg1	PERF_EXTIRQ_CFG_REG_3368
+#define ext_irq_cfg_reg2	0
+#endif
 #ifdef CONFIG_BCM63XX_CPU_6328
 #define irq_stat_reg		PERF_IRQSTAT_6328_REG
 #define irq_mask_reg		PERF_IRQMASK_6328_REG
@@ -140,6 +151,13 @@ static void bcm63xx_init_irq(void)
 	irq_mask_addr = bcm63xx_regset_address(RSET_PERF);
 
 	switch (bcm63xx_get_cpu_id()) {
+	case BCM3368_CPU_ID:
+		irq_stat_addr += PERF_IRQSTAT_3368_REG;
+		irq_mask_addr += PERF_IRQMASK_3368_REG;
+		irq_bits = 32;
+		ext_irq_count = 4;
+		ext_irq_cfg_reg1 = PERF_EXTIRQ_CFG_REG_3368;
+		break;
 	case BCM6328_CPU_ID:
 		irq_stat_addr += PERF_IRQSTAT_6328_REG;
 		irq_mask_addr += PERF_IRQMASK_6328_REG;
@@ -479,6 +497,7 @@ static int bcm63xx_external_irq_set_type(struct irq_data *d,
 			reg &= ~EXTIRQ_CFG_BOTHEDGE_6348(irq);
 		break;
 
+	case BCM3368_CPU_ID:
 	case BCM6328_CPU_ID:
 	case BCM6338_CPU_ID:
 	case BCM6345_CPU_ID:
diff --git a/arch/mips/bcm63xx/prom.c b/arch/mips/bcm63xx/prom.c
index fd69808..f3ff28f 100644
--- a/arch/mips/bcm63xx/prom.c
+++ b/arch/mips/bcm63xx/prom.c
@@ -26,7 +26,9 @@ void __init prom_init(void)
 	bcm_wdt_writel(WDT_STOP_2, WDT_CTL_REG);
 
 	/* disable all hardware blocks clock for now */
-	if (BCMCPU_IS_6328())
+	if (BCMCPU_IS_3368())
+		mask = CKCTL_3368_ALL_SAFE_EN;
+	else if (BCMCPU_IS_6328())
 		mask = CKCTL_6328_ALL_SAFE_EN;
 	else if (BCMCPU_IS_6338())
 		mask = CKCTL_6338_ALL_SAFE_EN;
diff --git a/arch/mips/bcm63xx/reset.c b/arch/mips/bcm63xx/reset.c
index 317931c..acbeb1f 100644
--- a/arch/mips/bcm63xx/reset.c
+++ b/arch/mips/bcm63xx/reset.c
@@ -30,6 +30,19 @@
 	[BCM63XX_RESET_PCIE]		= BCM## __cpu ##_RESET_PCIE,	\
 	[BCM63XX_RESET_PCIE_EXT]	= BCM## __cpu ##_RESET_PCIE_EXT,
 
+#define BCM3368_RESET_SPI	SOFTRESET_3368_SPI_MASK
+#define BCM3368_RESET_ENET	SOFTRESET_3368_ENET_MASK
+#define BCM3368_RESET_USBH	0
+#define BCM3368_RESET_USBD	SOFTRESET_3368_USBS_MASK
+#define BCM3368_RESET_DSL	0
+#define BCM3368_RESET_SAR	0
+#define BCM3368_RESET_EPHY	SOFTRESET_3368_EPHY_MASK
+#define BCM3368_RESET_ENETSW	0
+#define BCM3368_RESET_PCM	SOFTRESET_3368_PCM_MASK
+#define BCM3368_RESET_MPI	SOFTRESET_3368_MPI_MASK
+#define BCM3368_RESET_PCIE	0
+#define BCM3368_RESET_PCIE_EXT	0
+
 #define BCM6328_RESET_SPI	SOFTRESET_6328_SPI_MASK
 #define BCM6328_RESET_ENET	0
 #define BCM6328_RESET_USBH	SOFTRESET_6328_USBH_MASK
@@ -117,6 +130,10 @@
 /*
  * core reset bits
  */
+static const u32 bcm3368_reset_bits[] = {
+	__GEN_RESET_BITS_TABLE(3368)
+};
+
 static const u32 bcm6328_reset_bits[] = {
 	__GEN_RESET_BITS_TABLE(6328)
 };
@@ -146,7 +163,10 @@ static int reset_reg;
 
 static int __init bcm63xx_reset_bits_init(void)
 {
-	if (BCMCPU_IS_6328()) {
+	if (BCMCPU_IS_3368()) {
+		reset_reg = PERF_SOFTRESET_6358_REG;
+		bcm63xx_reset_bits = bcm3368_reset_bits;
+	} else if (BCMCPU_IS_6328()) {
 		reset_reg = PERF_SOFTRESET_6328_REG;
 		bcm63xx_reset_bits = bcm6328_reset_bits;
 	} else if (BCMCPU_IS_6338()) {
@@ -170,6 +190,13 @@ static int __init bcm63xx_reset_bits_init(void)
 }
 #else
 
+#ifdef CONFIG_BCM63XX_CPU_3368
+static const u32 bcm63xx_reset_bits[] = {
+	__GEN_RESET_BITS_TABLE(3368)
+};
+#define reset_reg PERF_SOFTRESET_6358_REG
+#endif
+
 #ifdef CONFIG_BCM63XX_CPU_6328
 static const u32 bcm63xx_reset_bits[] = {
 	__GEN_RESET_BITS_TABLE(6328)
diff --git a/arch/mips/bcm63xx/setup.c b/arch/mips/bcm63xx/setup.c
index 24a2444..6660c7d 100644
--- a/arch/mips/bcm63xx/setup.c
+++ b/arch/mips/bcm63xx/setup.c
@@ -68,6 +68,9 @@ void bcm63xx_machine_reboot(void)
 
 	/* mask and clear all external irq */
 	switch (bcm63xx_get_cpu_id()) {
+	case BCM3368_CPU_ID:
+		perf_regs[0] = PERF_EXTIRQ_CFG_REG_3368;
+		break;
 	case BCM6328_CPU_ID:
 		perf_regs[0] = PERF_EXTIRQ_CFG_REG_6328;
 		break;
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
index 3362289..9d3c08e 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
@@ -9,6 +9,7 @@
  * compile time if only one CPU support is enabled (idea stolen from
  * arm mach-types)
  */
+#define BCM3368_CPU_ID		0x3368
 #define BCM6328_CPU_ID		0x6328
 #define BCM6338_CPU_ID		0x6338
 #define BCM6345_CPU_ID		0x6345
@@ -22,6 +23,19 @@ u16 __bcm63xx_get_cpu_id(void);
 u8 bcm63xx_get_cpu_rev(void);
 unsigned int bcm63xx_get_cpu_freq(void);
 
+#ifdef CONFIG_BCM63XX_CPU_3368
+# ifdef bcm63xx_get_cpu_id
+#  undef bcm63xx_get_cpu_id
+#  define bcm63xx_get_cpu_id()	__bcm63xx_get_cpu_id()
+#  define BCMCPU_RUNTIME_DETECT
+# else
+#  define bcm63xx_get_cpu_id()	BCM3368_CPU_ID
+# endif
+# define BCMCPU_IS_3368()	(bcm63xx_get_cpu_id() == BCM3368_CPU_ID)
+#else
+# define BCMCPU_IS_3368()	(0)
+#endif
+
 #ifdef CONFIG_BCM63XX_CPU_6328
 # ifdef bcm63xx_get_cpu_id
 #  undef bcm63xx_get_cpu_id
@@ -191,6 +205,53 @@ enum bcm63xx_regs_set {
 #define RSET_RNG_SIZE			20
 
 /*
+ * 3368 register sets base address
+ */
+#define BCM_3368_DSL_LMEM_BASE		(0xdeadbeef)
+#define BCM_3368_PERF_BASE		(0xfff8c000)
+#define BCM_3368_TIMER_BASE		(0xfff8c040)
+#define BCM_3368_WDT_BASE		(0xfff8c080)
+#define BCM_3368_UART0_BASE		(0xfff8c100)
+#define BCM_3368_UART1_BASE		(0xfff8c120)
+#define BCM_3368_GPIO_BASE		(0xfff8c080)
+#define BCM_3368_SPI_BASE		(0xfff8c800)
+#define BCM_3368_HSSPI_BASE		(0xdeadbeef)
+#define BCM_3368_UDC0_BASE		(0xdeadbeef)
+#define BCM_3368_USBDMA_BASE		(0xdeadbeef)
+#define BCM_3368_OHCI0_BASE		(0xdeadbeef)
+#define BCM_3368_OHCI_PRIV_BASE		(0xdeadbeef)
+#define BCM_3368_USBH_PRIV_BASE		(0xdeadbeef)
+#define BCM_3368_USBD_BASE		(0xdeadbeef)
+#define BCM_3368_MPI_BASE		(0xfff80000)
+#define BCM_3368_PCMCIA_BASE		(0xfff80054)
+#define BCM_3368_PCIE_BASE		(0xdeadbeef)
+#define BCM_3368_SDRAM_REGS_BASE	(0xdeadbeef)
+#define BCM_3368_DSL_BASE		(0xdeadbeef)
+#define BCM_3368_UBUS_BASE		(0xdeadbeef)
+#define BCM_3368_ENET0_BASE		(0xfff98000)
+#define BCM_3368_ENET1_BASE		(0xfff98800)
+#define BCM_3368_ENETDMA_BASE		(0xfff99800)
+#define BCM_3368_ENETDMAC_BASE		(0xfff99900)
+#define BCM_3368_ENETDMAS_BASE		(0xfff99a00)
+#define BCM_3368_ENETSW_BASE		(0xdeadbeef)
+#define BCM_3368_EHCI0_BASE		(0xdeadbeef)
+#define BCM_3368_SDRAM_BASE		(0xdeadbeef)
+#define BCM_3368_MEMC_BASE		(0xfff84000)
+#define BCM_3368_DDR_BASE		(0xdeadbeef)
+#define BCM_3368_M2M_BASE		(0xdeadbeef)
+#define BCM_3368_ATM_BASE		(0xdeadbeef)
+#define BCM_3368_XTM_BASE		(0xdeadbeef)
+#define BCM_3368_XTMDMA_BASE		(0xdeadbeef)
+#define BCM_3368_XTMDMAC_BASE		(0xdeadbeef)
+#define BCM_3368_XTMDMAS_BASE		(0xdeadbeef)
+#define BCM_3368_PCM_BASE		(0xfff9c200)
+#define BCM_3368_PCMDMA_BASE		(0xdeadbeef)
+#define BCM_3368_PCMDMAC_BASE		(0xdeadbeef)
+#define BCM_3368_PCMDMAS_BASE		(0xdeadbeef)
+#define BCM_3368_RNG_BASE		(0xdeadbeef)
+#define BCM_3368_MISC_BASE		(0xdeadbeef)
+
+/*
  * 6328 register sets base address
  */
 #define BCM_6328_DSL_LMEM_BASE		(0xdeadbeef)
@@ -620,6 +681,9 @@ static inline unsigned long bcm63xx_regset_address(enum bcm63xx_regs_set set)
 #ifdef BCMCPU_RUNTIME_DETECT
 	return bcm63xx_regs_base[set];
 #else
+#ifdef CONFIG_BCM63XX_CPU_3368
+	__GEN_RSET(3368)
+#endif
 #ifdef CONFIG_BCM63XX_CPU_6328
 	__GEN_RSET(6328)
 #endif
@@ -687,6 +751,52 @@ enum bcm63xx_irq {
 };
 
 /*
+ * 3368 irqs
+ */
+#define BCM_3368_TIMER_IRQ		(IRQ_INTERNAL_BASE + 0)
+#define BCM_3368_SPI_IRQ		(IRQ_INTERNAL_BASE + 1)
+#define BCM_3368_UART0_IRQ		(IRQ_INTERNAL_BASE + 2)
+#define BCM_3368_UART1_IRQ		(IRQ_INTERNAL_BASE + 3)
+#define BCM_3368_DSL_IRQ		0
+#define BCM_3368_UDC0_IRQ		0
+#define BCM_3368_OHCI0_IRQ		0
+#define BCM_3368_ENET0_IRQ		(IRQ_INTERNAL_BASE + 8)
+#define BCM_3368_ENET1_IRQ		(IRQ_INTERNAL_BASE + 6)
+#define BCM_3368_ENET_PHY_IRQ		(IRQ_INTERNAL_BASE + 9)
+#define BCM_3368_ENET0_RXDMA_IRQ	(IRQ_INTERNAL_BASE + 15)
+#define BCM_3368_ENET0_TXDMA_IRQ	(IRQ_INTERNAL_BASE + 16)
+#define BCM_3368_HSSPI_IRQ		0
+#define BCM_3368_EHCI0_IRQ		0
+#define BCM_3368_USBD_IRQ		0
+#define BCM_3368_USBD_RXDMA0_IRQ	0
+#define BCM_3368_USBD_TXDMA0_IRQ	0
+#define BCM_3368_USBD_RXDMA1_IRQ	0
+#define BCM_3368_USBD_TXDMA1_IRQ	0
+#define BCM_3368_USBD_RXDMA2_IRQ	0
+#define BCM_3368_USBD_TXDMA2_IRQ	0
+#define BCM_3368_ENET1_RXDMA_IRQ        (IRQ_INTERNAL_BASE + 17)
+#define BCM_3368_ENET1_TXDMA_IRQ        (IRQ_INTERNAL_BASE + 18)
+#define BCM_3368_PCI_IRQ		(IRQ_INTERNAL_BASE + 31)
+#define BCM_3368_PCMCIA_IRQ		0
+#define BCM_3368_ATM_IRQ		0
+#define BCM_3368_ENETSW_RXDMA0_IRQ	0
+#define BCM_3368_ENETSW_RXDMA1_IRQ	0
+#define BCM_3368_ENETSW_RXDMA2_IRQ	0
+#define BCM_3368_ENETSW_RXDMA3_IRQ	0
+#define BCM_3368_ENETSW_TXDMA0_IRQ	0
+#define BCM_3368_ENETSW_TXDMA1_IRQ	0
+#define BCM_3368_ENETSW_TXDMA2_IRQ	0
+#define BCM_3368_ENETSW_TXDMA3_IRQ	0
+#define BCM_3368_XTM_IRQ		0
+#define BCM_3368_XTM_DMA0_IRQ		0
+
+#define BCM_3368_EXT_IRQ0		(IRQ_INTERNAL_BASE + 25)
+#define BCM_3368_EXT_IRQ1		(IRQ_INTERNAL_BASE + 26)
+#define BCM_3368_EXT_IRQ2		(IRQ_INTERNAL_BASE + 27)
+#define BCM_3368_EXT_IRQ3		(IRQ_INTERNAL_BASE + 28)
+
+
+/*
  * 6328 irqs
  */
 #define BCM_6328_HIGH_IRQ_BASE		(IRQ_INTERNAL_BASE + 32)
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h
index 35baa1a..565ff36 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h
@@ -11,6 +11,7 @@ static inline unsigned long bcm63xx_gpio_count(void)
 	switch (bcm63xx_get_cpu_id()) {
 	case BCM6328_CPU_ID:
 		return 32;
+	case BCM3368_CPU_ID:
 	case BCM6358_CPU_ID:
 		return 40;
 	case BCM6338_CPU_ID:
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
index 3203fe4..6542137 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
@@ -15,6 +15,39 @@
 /* Clock Control register */
 #define PERF_CKCTL_REG			0x4
 
+#define CKCTL_3368_MAC_EN		(1 << 3)
+#define CKCTL_3368_TC_EN		(1 << 5)
+#define CKCTL_3368_US_TOP_EN		(1 << 6)
+#define CKCTL_3368_DS_TOP_EN		(1 << 7)
+#define CKCTL_3368_APM_EN		(1 << 8)
+#define CKCTL_3368_SPI_EN		(1 << 9)
+#define CKCTL_3368_USBS_EN		(1 << 10)
+#define CKCTL_3368_BMU_EN		(1 << 11)
+#define CKCTL_3368_PCM_EN		(1 << 12)
+#define CKCTL_3368_NTP_EN		(1 << 13)
+#define CKCTL_3368_ACP_B_EN		(1 << 14)
+#define CKCTL_3368_ACP_A_EN		(1 << 15)
+#define CKCTL_3368_EMUSB_EN		(1 << 17)
+#define CKCTL_3368_ENET0_EN		(1 << 18)
+#define CKCTL_3368_ENET1_EN		(1 << 19)
+#define CKCTL_3368_USBU_EN		(1 << 20)
+#define CKCTL_3368_EPHY_EN		(1 << 21)
+
+#define CKCTL_3368_ALL_SAFE_EN		(CKCTL_3368_MAC_EN | \
+					 CKCTL_3368_TC_EN | \
+					 CKCTL_3368_US_TOP_EN | \
+					 CKCTL_3368_DS_TOP_EN | \
+					 CKCTL_3368_APM_EN | \
+					 CKCTL_3368_SPI_EN | \
+					 CKCTL_3368_USBS_EN | \
+					 CKCTL_3368_BMU_EN | \
+					 CKCTL_3368_PCM_EN | \
+					 CKCTL_3368_NTP_EN | \
+					 CKCTL_3368_ACP_B_EN | \
+					 CKCTL_3368_ACP_A_EN | \
+					 CKCTL_3368_EMUSB_EN | \
+					 CKCTL_3368_USBU_EN)
+
 #define CKCTL_6328_PHYMIPS_EN		(1 << 0)
 #define CKCTL_6328_ADSL_QPROC_EN	(1 << 1)
 #define CKCTL_6328_ADSL_AFE_EN		(1 << 2)
@@ -181,6 +214,7 @@
 #define SYS_PLL_SOFT_RESET		0x1
 
 /* Interrupt Mask register */
+#define PERF_IRQMASK_3368_REG		0xc
 #define PERF_IRQMASK_6328_REG		0x20
 #define PERF_IRQMASK_6338_REG		0xc
 #define PERF_IRQMASK_6345_REG		0xc
@@ -190,6 +224,7 @@
 #define PERF_IRQMASK_6368_REG		0x20
 
 /* Interrupt Status register */
+#define PERF_IRQSTAT_3368_REG		0x10
 #define PERF_IRQSTAT_6328_REG		0x28
 #define PERF_IRQSTAT_6338_REG		0x10
 #define PERF_IRQSTAT_6345_REG		0x10
@@ -199,6 +234,7 @@
 #define PERF_IRQSTAT_6368_REG		0x28
 
 /* External Interrupt Configuration register */
+#define PERF_EXTIRQ_CFG_REG_3368	0x14
 #define PERF_EXTIRQ_CFG_REG_6328	0x18
 #define PERF_EXTIRQ_CFG_REG_6338	0x14
 #define PERF_EXTIRQ_CFG_REG_6345	0x14
@@ -236,6 +272,13 @@
 #define PERF_SOFTRESET_6362_REG		0x10
 #define PERF_SOFTRESET_6368_REG		0x10
 
+#define SOFTRESET_3368_SPI_MASK		(1 << 0)
+#define SOFTRESET_3368_ENET_MASK	(1 << 2)
+#define SOFTRESET_3368_MPI_MASK		(1 << 3)
+#define SOFTRESET_3368_EPHY_MASK	(1 << 6)
+#define SOFTRESET_3368_USBS_MASK	(1 << 11)
+#define SOFTRESET_3368_PCM_MASK		(1 << 13)
+
 #define SOFTRESET_6328_SPI_MASK		(1 << 0)
 #define SOFTRESET_6328_EPHY_MASK	(1 << 1)
 #define SOFTRESET_6328_SAR_MASK		(1 << 2)
@@ -1293,7 +1336,7 @@
 #define SPI_6348_RX_DATA		0x80
 #define SPI_6348_RX_DATA_SIZE		0x3f
 
-/* BCM 6358/6262/6368 SPI core */
+/* BCM 3368/6358/6262/6368 SPI core */
 #define SPI_6358_MSG_CTL		0x00	/* 16-bits register */
 #define SPI_6358_MSG_CTL_WIDTH		16
 #define SPI_6358_MSG_DATA		0x02
diff --git a/arch/mips/include/asm/mach-bcm63xx/ioremap.h b/arch/mips/include/asm/mach-bcm63xx/ioremap.h
index 94e3011..ff15e3b 100644
--- a/arch/mips/include/asm/mach-bcm63xx/ioremap.h
+++ b/arch/mips/include/asm/mach-bcm63xx/ioremap.h
@@ -11,6 +11,10 @@ static inline phys_t fixup_bigphys_addr(phys_t phys_addr, phys_t size)
 static inline int is_bcm63xx_internal_registers(phys_t offset)
 {
 	switch (bcm63xx_get_cpu_id()) {
+	case BCM3368_CPU_ID:
+		if (offset >= 0xfff80000)
+			return 1;
+		break;
 	case BCM6338_CPU_ID:
 	case BCM6345_CPU_ID:
 	case BCM6348_CPU_ID:
diff --git a/arch/mips/pci/pci-bcm63xx.c b/arch/mips/pci/pci-bcm63xx.c
index 2eb9542..151d9b5 100644
--- a/arch/mips/pci/pci-bcm63xx.c
+++ b/arch/mips/pci/pci-bcm63xx.c
@@ -266,7 +266,7 @@ static int __init bcm63xx_register_pci(void)
 	/* setup PCI to local bus access, used by PCI device to target
 	 * local RAM while bus mastering */
 	bcm63xx_int_cfg_writel(0, PCI_BASE_ADDRESS_3);
-	if (BCMCPU_IS_6358() || BCMCPU_IS_6368())
+	if (BCMCPU_IS_3368() || BCMCPU_IS_6358() || BCMCPU_IS_6368())
 		val = MPI_SP0_REMAP_ENABLE_MASK;
 	else
 		val = 0;
@@ -338,6 +338,7 @@ static int __init bcm63xx_pci_init(void)
 	case BCM6328_CPU_ID:
 	case BCM6362_CPU_ID:
 		return bcm63xx_register_pcie();
+	case BCM3368_CPU_ID:
 	case BCM6348_CPU_ID:
 	case BCM6358_CPU_ID:
 	case BCM6368_CPU_ID:
-- 
1.8.1.2
