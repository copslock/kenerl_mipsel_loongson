Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Apr 2013 11:20:19 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:55621 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6826577Ab3DMJT7gtN8r (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 13 Apr 2013 11:19:59 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH V3 12/14] MIPS: ralink: adds support for RT3883 SoC family
Date:   Sat, 13 Apr 2013 10:48:23 +0200
Message-Id: <1365842905-10906-12-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1365842905-10906-1-git-send-email-blogic@openwrt.org>
References: <1365842905-10906-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36139
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

Add support code for rt3883 SOC.

The code detects the SoC and registers the clk / pinmux settings.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/include/asm/mach-ralink/rt3883.h |  247 ++++++++++++++++++++++++++++
 arch/mips/ralink/Kconfig                   |    5 +
 arch/mips/ralink/Makefile                  |    1 +
 arch/mips/ralink/Platform                  |    5 +
 arch/mips/ralink/rt3883.c                  |  244 +++++++++++++++++++++++++++
 5 files changed, 502 insertions(+)
 create mode 100644 arch/mips/include/asm/mach-ralink/rt3883.h
 create mode 100644 arch/mips/ralink/rt3883.c

diff --git a/arch/mips/include/asm/mach-ralink/rt3883.h b/arch/mips/include/asm/mach-ralink/rt3883.h
new file mode 100644
index 0000000..b91c6c1
--- /dev/null
+++ b/arch/mips/include/asm/mach-ralink/rt3883.h
@@ -0,0 +1,247 @@
+/*
+ * Ralink RT3662/RT3883 SoC register definitions
+ *
+ * Copyright (C) 2011-2012 Gabor Juhos <juhosg@openwrt.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#ifndef _RT3883_REGS_H_
+#define _RT3883_REGS_H_
+
+#include <linux/bitops.h>
+
+#define RT3883_SDRAM_BASE	0x00000000
+#define RT3883_SYSC_BASE	0x10000000
+#define RT3883_TIMER_BASE	0x10000100
+#define RT3883_INTC_BASE	0x10000200
+#define RT3883_MEMC_BASE	0x10000300
+#define RT3883_UART0_BASE	0x10000500
+#define RT3883_PIO_BASE		0x10000600
+#define RT3883_FSCC_BASE	0x10000700
+#define RT3883_NANDC_BASE	0x10000810
+#define RT3883_I2C_BASE		0x10000900
+#define RT3883_I2S_BASE		0x10000a00
+#define RT3883_SPI_BASE		0x10000b00
+#define RT3883_UART1_BASE	0x10000c00
+#define RT3883_PCM_BASE		0x10002000
+#define RT3883_GDMA_BASE	0x10002800
+#define RT3883_CODEC1_BASE	0x10003000
+#define RT3883_CODEC2_BASE	0x10003800
+#define RT3883_FE_BASE		0x10100000
+#define RT3883_ROM_BASE		0x10118000
+#define RT3883_USBDEV_BASE	0x10112000
+#define RT3883_PCI_BASE		0x10140000
+#define RT3883_WLAN_BASE	0x10180000
+#define RT3883_USBHOST_BASE	0x101c0000
+#define RT3883_BOOT_BASE	0x1c000000
+#define RT3883_SRAM_BASE	0x1e000000
+#define RT3883_PCIMEM_BASE	0x20000000
+
+#define RT3883_EHCI_BASE	(RT3883_USBHOST_BASE)
+#define RT3883_OHCI_BASE	(RT3883_USBHOST_BASE + 0x1000)
+
+#define RT3883_SYSC_SIZE	0x100
+#define RT3883_TIMER_SIZE	0x100
+#define RT3883_INTC_SIZE	0x100
+#define RT3883_MEMC_SIZE	0x100
+#define RT3883_UART0_SIZE	0x100
+#define RT3883_UART1_SIZE	0x100
+#define RT3883_PIO_SIZE		0x100
+#define RT3883_FSCC_SIZE	0x100
+#define RT3883_NANDC_SIZE	0x0f0
+#define RT3883_I2C_SIZE		0x100
+#define RT3883_I2S_SIZE		0x100
+#define RT3883_SPI_SIZE		0x100
+#define RT3883_PCM_SIZE		0x800
+#define RT3883_GDMA_SIZE	0x800
+#define RT3883_CODEC1_SIZE	0x800
+#define RT3883_CODEC2_SIZE	0x800
+#define RT3883_FE_SIZE		0x10000
+#define RT3883_ROM_SIZE		0x4000
+#define RT3883_USBDEV_SIZE	0x4000
+#define RT3883_PCI_SIZE		0x40000
+#define RT3883_WLAN_SIZE	0x40000
+#define RT3883_USBHOST_SIZE	0x40000
+#define RT3883_BOOT_SIZE	(32 * 1024 * 1024)
+#define RT3883_SRAM_SIZE	(32 * 1024 * 1024)
+
+/* SYSC registers */
+#define RT3883_SYSC_REG_CHIPID0_3	0x00	/* Chip ID 0 */
+#define RT3883_SYSC_REG_CHIPID4_7	0x04	/* Chip ID 1 */
+#define RT3883_SYSC_REG_REVID		0x0c	/* Chip Revision Identification */
+#define RT3883_SYSC_REG_SYSCFG0		0x10	/* System Configuration 0 */
+#define RT3883_SYSC_REG_SYSCFG1		0x14	/* System Configuration 1 */
+#define RT3883_SYSC_REG_CLKCFG0		0x2c	/* Clock Configuration 0 */
+#define RT3883_SYSC_REG_CLKCFG1		0x30	/* Clock Configuration 1 */
+#define RT3883_SYSC_REG_RSTCTRL		0x34	/* Reset Control*/
+#define RT3883_SYSC_REG_RSTSTAT		0x38	/* Reset Status*/
+#define RT3883_SYSC_REG_USB_PS		0x5c	/* USB Power saving control */
+#define RT3883_SYSC_REG_GPIO_MODE	0x60	/* GPIO Purpose Select */
+#define RT3883_SYSC_REG_PCIE_CLK_GEN0	0x7c
+#define RT3883_SYSC_REG_PCIE_CLK_GEN1	0x80
+#define RT3883_SYSC_REG_PCIE_CLK_GEN2	0x84
+#define RT3883_SYSC_REG_PMU		0x88
+#define RT3883_SYSC_REG_PMU1		0x8c
+
+#define RT3883_CHIP_NAME0		0x38335452
+#define RT3883_CHIP_NAME1		0x20203338
+
+#define RT3883_REVID_VER_ID_MASK	0x0f
+#define RT3883_REVID_VER_ID_SHIFT	8
+#define RT3883_REVID_ECO_ID_MASK	0x0f
+
+#define RT3883_SYSCFG0_DRAM_TYPE_DDR2	BIT(17)
+#define RT3883_SYSCFG0_CPUCLK_SHIFT	8
+#define RT3883_SYSCFG0_CPUCLK_MASK	0x3
+#define RT3883_SYSCFG0_CPUCLK_250	0x0
+#define RT3883_SYSCFG0_CPUCLK_384	0x1
+#define RT3883_SYSCFG0_CPUCLK_480	0x2
+#define RT3883_SYSCFG0_CPUCLK_500	0x3
+
+#define RT3883_SYSCFG1_USB0_HOST_MODE	BIT(10)
+#define RT3883_SYSCFG1_PCIE_RC_MODE	BIT(8)
+#define RT3883_SYSCFG1_PCI_HOST_MODE	BIT(7)
+#define RT3883_SYSCFG1_PCI_66M_MODE	BIT(6)
+#define RT3883_SYSCFG1_GPIO2_AS_WDT_OUT	BIT(2)
+
+#define RT3883_CLKCFG1_PCIE_CLK_EN	BIT(21)
+#define RT3883_CLKCFG1_UPHY1_CLK_EN	BIT(20)
+#define RT3883_CLKCFG1_PCI_CLK_EN	BIT(19)
+#define RT3883_CLKCFG1_UPHY0_CLK_EN	BIT(18)
+
+#define RT3883_GPIO_MODE_I2C		BIT(0)
+#define RT3883_GPIO_MODE_SPI		BIT(1)
+#define RT3883_GPIO_MODE_UART0_SHIFT	2
+#define RT3883_GPIO_MODE_UART0_MASK	0x7
+#define RT3883_GPIO_MODE_UART0(x)	((x) << RT3883_GPIO_MODE_UART0_SHIFT)
+#define RT3883_GPIO_MODE_UARTF		0x0
+#define RT3883_GPIO_MODE_PCM_UARTF	0x1
+#define RT3883_GPIO_MODE_PCM_I2S	0x2
+#define RT3883_GPIO_MODE_I2S_UARTF	0x3
+#define RT3883_GPIO_MODE_PCM_GPIO	0x4
+#define RT3883_GPIO_MODE_GPIO_UARTF	0x5
+#define RT3883_GPIO_MODE_GPIO_I2S	0x6
+#define RT3883_GPIO_MODE_GPIO		0x7
+#define RT3883_GPIO_MODE_UART1		BIT(5)
+#define RT3883_GPIO_MODE_JTAG		BIT(6)
+#define RT3883_GPIO_MODE_MDIO		BIT(7)
+#define RT3883_GPIO_MODE_GE1		BIT(9)
+#define RT3883_GPIO_MODE_GE2		BIT(10)
+#define RT3883_GPIO_MODE_PCI_SHIFT	11
+#define RT3883_GPIO_MODE_PCI_MASK	0x7
+#define RT3883_GPIO_MODE_PCI		(RT3883_GPIO_MODE_PCI_MASK << RT3883_GPIO_MODE_PCI_SHIFT)
+#define RT3883_GPIO_MODE_LNA_A_SHIFT	16
+#define RT3883_GPIO_MODE_LNA_A_MASK	0x3
+#define _RT3883_GPIO_MODE_LNA_A(_x)	((_x) << RT3883_GPIO_MODE_LNA_A_SHIFT)
+#define RT3883_GPIO_MODE_LNA_A_GPIO	0x3
+#define RT3883_GPIO_MODE_LNA_A		_RT3883_GPIO_MODE_LNA_A(RT3883_GPIO_MODE_LNA_A_MASK)
+#define RT3883_GPIO_MODE_LNA_G_SHIFT	18
+#define RT3883_GPIO_MODE_LNA_G_MASK	0x3
+#define _RT3883_GPIO_MODE_LNA_G(_x)	((_x) << RT3883_GPIO_MODE_LNA_G_SHIFT)
+#define RT3883_GPIO_MODE_LNA_G_GPIO	0x3
+#define RT3883_GPIO_MODE_LNA_G		_RT3883_GPIO_MODE_LNA_G(RT3883_GPIO_MODE_LNA_G_MASK)
+
+#define RT3883_GPIO_I2C_SD		1
+#define RT3883_GPIO_I2C_SCLK		2
+#define RT3883_GPIO_SPI_CS0		3
+#define RT3883_GPIO_SPI_CLK		4
+#define RT3883_GPIO_SPI_MOSI		5
+#define RT3883_GPIO_SPI_MISO		6
+#define RT3883_GPIO_7			7
+#define RT3883_GPIO_10			10
+#define RT3883_GPIO_14			14
+#define RT3883_GPIO_UART1_TXD		15
+#define RT3883_GPIO_UART1_RXD		16
+#define RT3883_GPIO_JTAG_TDO		17
+#define RT3883_GPIO_JTAG_TDI		18
+#define RT3883_GPIO_JTAG_TMS		19
+#define RT3883_GPIO_JTAG_TCLK		20
+#define RT3883_GPIO_JTAG_TRST_N		21
+#define RT3883_GPIO_MDIO_MDC		22
+#define RT3883_GPIO_MDIO_MDIO		23
+#define RT3883_GPIO_LNA_PE_A0		32
+#define RT3883_GPIO_LNA_PE_A1		33
+#define RT3883_GPIO_LNA_PE_A2		34
+#define RT3883_GPIO_LNA_PE_G0		35
+#define RT3883_GPIO_LNA_PE_G1		36
+#define RT3883_GPIO_LNA_PE_G2		37
+#define RT3883_GPIO_PCI_AD0		40
+#define RT3883_GPIO_PCI_AD31		71
+#define RT3883_GPIO_GE2_TXD0		72
+#define RT3883_GPIO_GE2_TXD1		73
+#define RT3883_GPIO_GE2_TXD2		74
+#define RT3883_GPIO_GE2_TXD3		75
+#define RT3883_GPIO_GE2_TXEN		76
+#define RT3883_GPIO_GE2_TXCLK		77
+#define RT3883_GPIO_GE2_RXD0		78
+#define RT3883_GPIO_GE2_RXD1		79
+#define RT3883_GPIO_GE2_RXD2		80
+#define RT3883_GPIO_GE2_RXD3		81
+#define RT3883_GPIO_GE2_RXDV		82
+#define RT3883_GPIO_GE2_RXCLK		83
+#define RT3883_GPIO_GE1_TXD0		84
+#define RT3883_GPIO_GE1_TXD1		85
+#define RT3883_GPIO_GE1_TXD2		86
+#define RT3883_GPIO_GE1_TXD3		87
+#define RT3883_GPIO_GE1_TXEN		88
+#define RT3883_GPIO_GE1_TXCLK		89
+#define RT3883_GPIO_GE1_RXD0		90
+#define RT3883_GPIO_GE1_RXD1		91
+#define RT3883_GPIO_GE1_RXD2		92
+#define RT3883_GPIO_GE1_RXD3		93
+#define RT3883_GPIO_GE1_RXDV		94
+#define RT3883_GPIO_GE1_RXCLK	95
+
+#define RT3883_RSTCTRL_PCIE_PCI_PDM	BIT(27)
+#define RT3883_RSTCTRL_FLASH		BIT(26)
+#define RT3883_RSTCTRL_UDEV		BIT(25)
+#define RT3883_RSTCTRL_PCI		BIT(24)
+#define RT3883_RSTCTRL_PCIE		BIT(23)
+#define RT3883_RSTCTRL_UHST		BIT(22)
+#define RT3883_RSTCTRL_FE		BIT(21)
+#define RT3883_RSTCTRL_WLAN		BIT(20)
+#define RT3883_RSTCTRL_UART1		BIT(29)
+#define RT3883_RSTCTRL_SPI		BIT(18)
+#define RT3883_RSTCTRL_I2S		BIT(17)
+#define RT3883_RSTCTRL_I2C		BIT(16)
+#define RT3883_RSTCTRL_NAND		BIT(15)
+#define RT3883_RSTCTRL_DMA		BIT(14)
+#define RT3883_RSTCTRL_PIO		BIT(13)
+#define RT3883_RSTCTRL_UART		BIT(12)
+#define RT3883_RSTCTRL_PCM		BIT(11)
+#define RT3883_RSTCTRL_MC		BIT(10)
+#define RT3883_RSTCTRL_INTC		BIT(9)
+#define RT3883_RSTCTRL_TIMER		BIT(8)
+#define RT3883_RSTCTRL_SYS		BIT(0)
+
+#define RT3883_INTC_INT_SYSCTL	BIT(0)
+#define RT3883_INTC_INT_TIMER0	BIT(1)
+#define RT3883_INTC_INT_TIMER1	BIT(2)
+#define RT3883_INTC_INT_IA	BIT(3)
+#define RT3883_INTC_INT_PCM	BIT(4)
+#define RT3883_INTC_INT_UART0	BIT(5)
+#define RT3883_INTC_INT_PIO	BIT(6)
+#define RT3883_INTC_INT_DMA	BIT(7)
+#define RT3883_INTC_INT_NAND	BIT(8)
+#define RT3883_INTC_INT_PERFC	BIT(9)
+#define RT3883_INTC_INT_I2S	BIT(10)
+#define RT3883_INTC_INT_UART1	BIT(12)
+#define RT3883_INTC_INT_UHST	BIT(18)
+#define RT3883_INTC_INT_UDEV	BIT(19)
+
+/* FLASH/SRAM/Codec Controller registers */
+#define RT3883_FSCC_REG_FLASH_CFG0	0x00
+#define RT3883_FSCC_REG_FLASH_CFG1	0x04
+#define RT3883_FSCC_REG_CODEC_CFG0	0x40
+#define RT3883_FSCC_REG_CODEC_CFG1	0x44
+
+#define RT3883_FLASH_CFG_WIDTH_SHIFT	26
+#define RT3883_FLASH_CFG_WIDTH_MASK	0x3
+#define RT3883_FLASH_CFG_WIDTH_8BIT	0x0
+#define RT3883_FLASH_CFG_WIDTH_16BIT	0x1
+#define RT3883_FLASH_CFG_WIDTH_32BIT	0x2
+
+#endif /* _RT3883_REGS_H_ */
diff --git a/arch/mips/ralink/Kconfig b/arch/mips/ralink/Kconfig
index 6723b94..ce57d3e 100644
--- a/arch/mips/ralink/Kconfig
+++ b/arch/mips/ralink/Kconfig
@@ -15,6 +15,11 @@ choice
 		select USB_ARCH_HAS_OHCI
 		select USB_ARCH_HAS_EHCI
 
+	config SOC_RT3883
+		bool "RT3883"
+		select USB_ARCH_HAS_OHCI
+		select USB_ARCH_HAS_EHCI
+
 endchoice
 
 choice
diff --git a/arch/mips/ralink/Makefile b/arch/mips/ralink/Makefile
index 6d826f2..ba9669c 100644
--- a/arch/mips/ralink/Makefile
+++ b/arch/mips/ralink/Makefile
@@ -10,6 +10,7 @@ obj-y := prom.o of.o reset.o clk.o irq.o
 
 obj-$(CONFIG_SOC_RT288X) += rt288x.o
 obj-$(CONFIG_SOC_RT305X) += rt305x.o
+obj-$(CONFIG_SOC_RT3883) += rt3883.o
 
 obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
 
diff --git a/arch/mips/ralink/Platform b/arch/mips/ralink/Platform
index 3f49e51..f67c08d 100644
--- a/arch/mips/ralink/Platform
+++ b/arch/mips/ralink/Platform
@@ -13,3 +13,8 @@ load-$(CONFIG_SOC_RT288X)	+= 0xffffffff88000000
 # Ralink RT305x
 #
 load-$(CONFIG_SOC_RT305X)	+= 0xffffffff80000000
+
+#
+# Ralink RT3883
+#
+load-$(CONFIG_SOC_RT3883)	+= 0xffffffff80000000
diff --git a/arch/mips/ralink/rt3883.c b/arch/mips/ralink/rt3883.c
new file mode 100644
index 0000000..724a570
--- /dev/null
+++ b/arch/mips/ralink/rt3883.c
@@ -0,0 +1,244 @@
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ *
+ * Parts of this file are based on Ralink's 2.6.21 BSP
+ *
+ * Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
+ * Copyright (C) 2008-2011 Gabor Juhos <juhosg@openwrt.org>
+ * Copyright (C) 2013 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+
+#include <asm/mipsregs.h>
+#include <asm/mach-ralink/ralink_regs.h>
+#include <asm/mach-ralink/rt3883.h>
+
+#include "common.h"
+
+static struct ralink_pinmux_grp mode_mux[] = {
+	{
+		.name = "i2c",
+		.mask = RT3883_GPIO_MODE_I2C,
+		.gpio_first = RT3883_GPIO_I2C_SD,
+		.gpio_last = RT3883_GPIO_I2C_SCLK,
+	}, {
+		.name = "spi",
+		.mask = RT3883_GPIO_MODE_SPI,
+		.gpio_first = RT3883_GPIO_SPI_CS0,
+		.gpio_last = RT3883_GPIO_SPI_MISO,
+	}, {
+		.name = "uartlite",
+		.mask = RT3883_GPIO_MODE_UART1,
+		.gpio_first = RT3883_GPIO_UART1_TXD,
+		.gpio_last = RT3883_GPIO_UART1_RXD,
+	}, {
+		.name = "jtag",
+		.mask = RT3883_GPIO_MODE_JTAG,
+		.gpio_first = RT3883_GPIO_JTAG_TDO,
+		.gpio_last = RT3883_GPIO_JTAG_TCLK,
+	}, {
+		.name = "mdio",
+		.mask = RT3883_GPIO_MODE_MDIO,
+		.gpio_first = RT3883_GPIO_MDIO_MDC,
+		.gpio_last = RT3883_GPIO_MDIO_MDIO,
+	}, {
+		.name = "ge1",
+		.mask = RT3883_GPIO_MODE_GE1,
+		.gpio_first = RT3883_GPIO_GE1_TXD0,
+		.gpio_last = RT3883_GPIO_GE1_RXCLK,
+	}, {
+		.name = "ge2",
+		.mask = RT3883_GPIO_MODE_GE2,
+		.gpio_first = RT3883_GPIO_GE2_TXD0,
+		.gpio_last = RT3883_GPIO_GE2_RXCLK,
+	}, {
+		.name = "pci",
+		.mask = RT3883_GPIO_MODE_PCI,
+		.gpio_first = RT3883_GPIO_PCI_AD0,
+		.gpio_last = RT3883_GPIO_PCI_AD31,
+	}, {
+		.name = "lna a",
+		.mask = RT3883_GPIO_MODE_LNA_A,
+		.gpio_first = RT3883_GPIO_LNA_PE_A0,
+		.gpio_last = RT3883_GPIO_LNA_PE_A2,
+	}, {
+		.name = "lna g",
+		.mask = RT3883_GPIO_MODE_LNA_G,
+		.gpio_first = RT3883_GPIO_LNA_PE_G0,
+		.gpio_last = RT3883_GPIO_LNA_PE_G2,
+	}, {0}
+};
+
+static struct ralink_pinmux_grp uart_mux[] = {
+	{
+		.name = "uartf",
+		.mask = RT3883_GPIO_MODE_UARTF,
+		.gpio_first = RT3883_GPIO_7,
+		.gpio_last = RT3883_GPIO_14,
+	}, {
+		.name = "pcm uartf",
+		.mask = RT3883_GPIO_MODE_PCM_UARTF,
+		.gpio_first = RT3883_GPIO_7,
+		.gpio_last = RT3883_GPIO_14,
+	}, {
+		.name = "pcm i2s",
+		.mask = RT3883_GPIO_MODE_PCM_I2S,
+		.gpio_first = RT3883_GPIO_7,
+		.gpio_last = RT3883_GPIO_14,
+	}, {
+		.name = "i2s uartf",
+		.mask = RT3883_GPIO_MODE_I2S_UARTF,
+		.gpio_first = RT3883_GPIO_7,
+		.gpio_last = RT3883_GPIO_14,
+	}, {
+		.name = "pcm gpio",
+		.mask = RT3883_GPIO_MODE_PCM_GPIO,
+		.gpio_first = RT3883_GPIO_10,
+		.gpio_last = RT3883_GPIO_14,
+	}, {
+		.name = "gpio uartf",
+		.mask = RT3883_GPIO_MODE_GPIO_UARTF,
+		.gpio_first = RT3883_GPIO_7,
+		.gpio_last = RT3883_GPIO_14,
+	}, {
+		.name = "gpio i2s",
+		.mask = RT3883_GPIO_MODE_GPIO_I2S,
+		.gpio_first = RT3883_GPIO_7,
+		.gpio_last = RT3883_GPIO_14,
+	}, {
+		.name = "gpio",
+		.mask = RT3883_GPIO_MODE_GPIO,
+		.gpio_first = RT3883_GPIO_7,
+		.gpio_last = RT3883_GPIO_14,
+	}, {0}
+};
+
+static struct ralink_pinmux_grp pci_mux[] = {
+	{
+		.name = "pci-dev",
+		.mask = 0,
+		.gpio_first = RT3883_GPIO_PCI_AD0,
+		.gpio_last = RT3883_GPIO_PCI_AD31,
+	}, {
+		.name = "pci-host2",
+		.mask = 1,
+		.gpio_first = RT3883_GPIO_PCI_AD0,
+		.gpio_last = RT3883_GPIO_PCI_AD31,
+	}, {
+		.name = "pci-host1",
+		.mask = 2,
+		.gpio_first = RT3883_GPIO_PCI_AD0,
+		.gpio_last = RT3883_GPIO_PCI_AD31,
+	}, {
+		.name = "pci-fnc",
+		.mask = 3,
+		.gpio_first = RT3883_GPIO_PCI_AD0,
+		.gpio_last = RT3883_GPIO_PCI_AD31,
+	}, {
+		.name = "pci-gpio",
+		.mask = 7,
+		.gpio_first = RT3883_GPIO_PCI_AD0,
+		.gpio_last = RT3883_GPIO_PCI_AD31,
+	}, {0}
+};
+
+static void rt3883_wdt_reset(void)
+{
+	u32 t;
+
+	/* enable WDT reset output on GPIO 2 */
+	t = rt_sysc_r32(RT3883_SYSC_REG_SYSCFG1);
+	t |= RT3883_SYSCFG1_GPIO2_AS_WDT_OUT;
+	rt_sysc_w32(t, RT3883_SYSC_REG_SYSCFG1);
+}
+
+struct ralink_pinmux rt_gpio_pinmux = {
+	.mode = mode_mux,
+	.uart = uart_mux,
+	.uart_shift = RT3883_GPIO_MODE_UART0_SHIFT,
+	.uart_mask = RT3883_GPIO_MODE_GPIO,
+	.wdt_reset = rt3883_wdt_reset,
+	.pci = pci_mux,
+	.pci_shift = RT3883_GPIO_MODE_PCI_SHIFT,
+	.pci_mask = RT3883_GPIO_MODE_PCI_MASK,
+};
+
+void __init ralink_clk_init(void)
+{
+	unsigned long cpu_rate, sys_rate;
+	u32 syscfg0;
+	u32 clksel;
+	u32 ddr2;
+
+	syscfg0 = rt_sysc_r32(RT3883_SYSC_REG_SYSCFG0);
+	clksel = ((syscfg0 >> RT3883_SYSCFG0_CPUCLK_SHIFT) &
+		RT3883_SYSCFG0_CPUCLK_MASK);
+	ddr2 = syscfg0 & RT3883_SYSCFG0_DRAM_TYPE_DDR2;
+
+	switch (clksel) {
+	case RT3883_SYSCFG0_CPUCLK_250:
+		cpu_rate = 250000000;
+		sys_rate = (ddr2) ? 125000000 : 83000000;
+		break;
+	case RT3883_SYSCFG0_CPUCLK_384:
+		cpu_rate = 384000000;
+		sys_rate = (ddr2) ? 128000000 : 96000000;
+		break;
+	case RT3883_SYSCFG0_CPUCLK_480:
+		cpu_rate = 480000000;
+		sys_rate = (ddr2) ? 160000000 : 120000000;
+		break;
+	case RT3883_SYSCFG0_CPUCLK_500:
+		cpu_rate = 500000000;
+		sys_rate = (ddr2) ? 166000000 : 125000000;
+		break;
+	}
+
+	ralink_clk_add("cpu", cpu_rate);
+	ralink_clk_add("10000100.timer", sys_rate);
+	ralink_clk_add("10000120.watchdog", sys_rate);
+	ralink_clk_add("10000500.uart", 40000000);
+	ralink_clk_add("10000b00.spi", sys_rate);
+	ralink_clk_add("10000c00.uartlite", 40000000);
+	ralink_clk_add("10100000.ethernet", sys_rate);
+}
+
+void __init ralink_of_remap(void)
+{
+	rt_sysc_membase = plat_of_remap_node("ralink,rt3883-sysc");
+	rt_memc_membase = plat_of_remap_node("ralink,rt3883-memc");
+
+	if (!rt_sysc_membase || !rt_memc_membase)
+		panic("Failed to remap core resources");
+}
+
+void prom_soc_init(struct ralink_soc_info *soc_info)
+{
+	void __iomem *sysc = (void __iomem *) KSEG1ADDR(RT3883_SYSC_BASE);
+	const char *name;
+	u32 n0;
+	u32 n1;
+	u32 id;
+
+	n0 = __raw_readl(sysc + RT3883_SYSC_REG_CHIPID0_3);
+	n1 = __raw_readl(sysc + RT3883_SYSC_REG_CHIPID4_7);
+	id = __raw_readl(sysc + RT3883_SYSC_REG_REVID);
+
+	if (n0 == RT3883_CHIP_NAME0 && n1 == RT3883_CHIP_NAME1) {
+		soc_info->compatible = "ralink,rt3883-soc";
+		name = "RT3883";
+	} else {
+		panic("rt3883: unknown SoC, n0:%08x n1:%08x", n0, n1);
+	}
+
+	snprintf(soc_info->sys_type, RAMIPS_SYS_TYPE_LEN,
+		"Ralink %s ver:%u eco:%u",
+		name,
+		(id >> RT3883_REVID_VER_ID_SHIFT) & RT3883_REVID_VER_ID_MASK,
+		(id & RT3883_REVID_ECO_ID_MASK));
+}
-- 
1.7.10.4
