Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Nov 2011 17:11:21 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:40727 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903799Ab1KUQIB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 21 Nov 2011 17:08:01 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 999953B2E48;
        Mon, 21 Nov 2011 17:08:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YJjWlIWC4op0; Mon, 21 Nov 2011 17:08:01 +0100 (CET)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id 021573AF532;
        Mon, 21 Nov 2011 17:08:01 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 7/8 v2] MIPS: BCM63XX: add stub to register the SPI platform driver
Date:   Mon, 21 Nov 2011 17:07:22 +0100
Message-Id: <1321891643-4119-8-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1321891643-4119-1-git-send-email-florian@openwrt.org>
References: <1321891643-4119-1-git-send-email-florian@openwrt.org>
X-archive-position: 31889
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17467

This patch adds the necessary stub to register the SPI platform driver.
Since the registers are shuffled between the 4 BCM63xx CPUs supported by
this SPI driver we also need to generate the internal register layout and
export this layout for the driver to use it properly.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
Changes since v1:

- fixed typo in bcm63xx_spi_regs_init()
- folded patch 8 and 7 together

 arch/mips/bcm63xx/Makefile                         |    3 +-
 arch/mips/bcm63xx/dev-spi.c                        |  117 ++++++++++++++++++++
 .../include/asm/mach-bcm63xx/bcm63xx_dev_spi.h     |   89 +++++++++++++++
 3 files changed, 208 insertions(+), 1 deletions(-)
 create mode 100644 arch/mips/bcm63xx/dev-spi.c
 create mode 100644 arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h

diff --git a/arch/mips/bcm63xx/Makefile b/arch/mips/bcm63xx/Makefile
index 6dfdc69..4049cd5 100644
--- a/arch/mips/bcm63xx/Makefile
+++ b/arch/mips/bcm63xx/Makefile
@@ -1,5 +1,6 @@
 obj-y		+= clk.o cpu.o cs.o gpio.o irq.o prom.o setup.o timer.o \
-		   dev-dsp.o dev-enet.o dev-pcmcia.o dev-uart.o dev-wdt.o
+		   dev-dsp.o dev-enet.o dev-pcmcia.o dev-spi.o dev-uart.o \
+		   dev-wdt.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
 obj-y		+= boards/
diff --git a/arch/mips/bcm63xx/dev-spi.c b/arch/mips/bcm63xx/dev-spi.c
new file mode 100644
index 0000000..2fd52f3
--- /dev/null
+++ b/arch/mips/bcm63xx/dev-spi.c
@@ -0,0 +1,117 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2009-2011 Florian Fainelli <florian@openwrt.org>
+ * Copyright (C) 2010 Tanguy Bouzeloc <tanguy.bouzeloc@efixo.com>
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/export.h>
+#include <linux/platform_device.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+
+#include <bcm63xx_cpu.h>
+#include <bcm63xx_dev_spi.h>
+#include <bcm63xx_regs.h>
+
+#ifdef BCMCPU_RUNTIME_DETECT
+/*
+ * register offsets
+ */
+static const unsigned long bcm6338_regs_spi[] = {
+	__GEN_SPI_REGS_TABLE(6338)
+};
+
+static const unsigned long bcm6348_regs_spi[] = {
+	__GEN_SPI_REGS_TABLE(6348)
+};
+
+static const unsigned long bcm6358_regs_spi[] = {
+	__GEN_SPI_REGS_TABLE(6358)
+};
+
+static const unsigned long bcm6368_regs_spi[] = {
+	__GEN_SPI_REGS_TABLE(6368)
+};
+
+const unsigned long *bcm63xx_regs_spi;
+EXPORT_SYMBOL(bcm63xx_regs_spi);
+
+static __init void bcm63xx_spi_regs_init(void)
+{
+	if (BCMCPU_IS_6338())
+		bcm63xx_regs_spi = bcm6338_regs_spi;
+	if (BCMCPU_IS_6348())
+		bcm63xx_regs_spi = bcm6348_regs_spi;
+	if (BCMCPU_IS_6358())
+		bcm63xx_regs_spi = bcm6358_regs_spi;
+	if (BCMCPU_IS_6368())
+		bcm63xx_regs_spi = bcm6368_regs_spi;
+}
+#else
+static __init void bcm63xx_spi_regs_init(void) { }
+#endif
+
+static struct resource spi_resources[] = {
+	{
+		.start		= -1, /* filled at runtime */
+		.end		= -1, /* filled at runtime */
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= -1, /* filled at runtime */
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static struct bcm63xx_spi_pdata spi_pdata = {
+	.bus_num		= 0,
+	.num_chipselect		= 8,
+};
+
+static struct platform_device bcm63xx_spi_device = {
+	.name		= "bcm63xx-spi",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(spi_resources),
+	.resource	= spi_resources,
+	.dev		= {
+		.platform_data = &spi_pdata,
+	},
+};
+
+int __init bcm63xx_spi_register(void)
+{
+	struct clk *periph_clk;
+
+	if (BCMCPU_IS_6345())
+		return -ENODEV;
+
+	periph_clk = clk_get(NULL, "periph");
+	if (IS_ERR(periph_clk)) {
+		pr_err("unable to get periph clock\n");
+		return -ENODEV;
+	}
+
+	/* Set bus frequency */
+	spi_pdata.speed_hz = clk_get_rate(periph_clk);
+
+	spi_resources[0].start = bcm63xx_regset_address(RSET_SPI);
+	spi_resources[0].end = spi_resources[0].start;
+	spi_resources[0].end += RSET_SPI_SIZE - 1;
+	spi_resources[1].start = bcm63xx_get_irq_number(IRQ_SPI);
+
+	/* Fill in platform data */
+	if (BCMCPU_IS_6338() || BCMCPU_IS_6348())
+		spi_pdata.fifo_size = SPI_6338_MSG_DATA_SIZE;
+
+	if (BCMCPU_IS_6358() || BCMCPU_IS_6368())
+		spi_pdata.fifo_size = SPI_6358_MSG_DATA_SIZE;
+
+	bcm63xx_spi_regs_init();
+
+	return platform_device_register(&bcm63xx_spi_device);
+}
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h
new file mode 100644
index 0000000..7d98dbe
--- /dev/null
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h
@@ -0,0 +1,89 @@
+#ifndef BCM63XX_DEV_SPI_H
+#define BCM63XX_DEV_SPI_H
+
+#include <linux/types.h>
+#include <bcm63xx_io.h>
+#include <bcm63xx_regs.h>
+
+int __init bcm63xx_spi_register(void);
+
+struct bcm63xx_spi_pdata {
+	unsigned int	fifo_size;
+	int		bus_num;
+	int		num_chipselect;
+	u32		speed_hz;
+};
+
+enum bcm63xx_regs_spi {
+	SPI_CMD,
+	SPI_INT_STATUS,
+	SPI_INT_MASK_ST,
+	SPI_INT_MASK,
+	SPI_ST,
+	SPI_CLK_CFG,
+	SPI_FILL_BYTE,
+	SPI_MSG_TAIL,
+	SPI_RX_TAIL,
+	SPI_MSG_CTL,
+	SPI_MSG_DATA,
+	SPI_RX_DATA,
+};
+
+#define __GEN_SPI_RSET_BASE(__cpu, __rset)				\
+	case SPI_## __rset:						\
+		return SPI_## __cpu ##_## __rset;
+
+#define __GEN_SPI_RSET(__cpu)						\
+	switch (reg) {							\
+	__GEN_SPI_RSET_BASE(__cpu, CMD)					\
+	__GEN_SPI_RSET_BASE(__cpu, INT_STATUS)				\
+	__GEN_SPI_RSET_BASE(__cpu, INT_MASK_ST)				\
+	__GEN_SPI_RSET_BASE(__cpu, INT_MASK)				\
+	__GEN_SPI_RSET_BASE(__cpu, ST)					\
+	__GEN_SPI_RSET_BASE(__cpu, CLK_CFG)				\
+	__GEN_SPI_RSET_BASE(__cpu, FILL_BYTE)				\
+	__GEN_SPI_RSET_BASE(__cpu, MSG_TAIL)				\
+	__GEN_SPI_RSET_BASE(__cpu, RX_TAIL)				\
+	__GEN_SPI_RSET_BASE(__cpu, MSG_CTL)				\
+	__GEN_SPI_RSET_BASE(__cpu, MSG_DATA)				\
+	__GEN_SPI_RSET_BASE(__cpu, RX_DATA)				\
+	}
+
+#define __GEN_SPI_REGS_TABLE(__cpu)					\
+	[SPI_CMD]		= SPI_## __cpu ##_CMD,			\
+	[SPI_INT_STATUS]	= SPI_## __cpu ##_INT_STATUS,		\
+	[SPI_INT_MASK_ST]	= SPI_## __cpu ##_INT_MASK_ST,		\
+	[SPI_INT_MASK]		= SPI_## __cpu ##_INT_MASK,		\
+	[SPI_ST]		= SPI_## __cpu ##_ST,			\
+	[SPI_CLK_CFG]		= SPI_## __cpu ##_CLK_CFG,		\
+	[SPI_FILL_BYTE]		= SPI_## __cpu ##_FILL_BYTE,		\
+	[SPI_MSG_TAIL]		= SPI_## __cpu ##_MSG_TAIL,		\
+	[SPI_RX_TAIL]		= SPI_## __cpu ##_RX_TAIL,		\
+	[SPI_MSG_CTL]		= SPI_## __cpu ##_MSG_CTL,		\
+	[SPI_MSG_DATA]		= SPI_## __cpu ##_MSG_DATA,		\
+	[SPI_RX_DATA]		= SPI_## __cpu ##_RX_DATA,
+
+static inline unsigned long bcm63xx_spireg(enum bcm63xx_regs_spi reg)
+{
+#ifdef BCMCPU_RUNTIME_DETECT
+	extern const unsigned long *bcm63xx_regs_spi;
+
+	return bcm63xx_regs_spi[reg];
+#else
+#ifdef CONFIG_BCM63XX_CPU_6338
+	__GEN_SPI_RSET(6338)
+#endif
+#ifdef CONFIG_BCM63XX_CPU_6348
+	__GEN_SPI_RSET(6348)
+#endif
+#ifdef CONFIG_BCM63XX_CPU_6358
+	__GEN_SPI_RSET(6358)
+#endif
+#ifdef CONFIG_BCM63XX_CPU_6368
+	__GEN_SPI_RSET(6368)
+#endif
+#endif
+	return 0;
+}
+
+#endif /* BCM63XX_DEV_SPI_H */
-- 
1.7.5.4
