Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Oct 2014 05:41:18 +0200 (CEST)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:56651 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010259AbaJJDkfJsdh1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Oct 2014 05:40:35 +0200
Received: by mail-pa0-f49.google.com with SMTP id hz1so900543pad.36
        for <multiple recipients>; Thu, 09 Oct 2014 20:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S1pTE4n06khPdCPLu5Ut5hova7Y/fPh6982tAjCUWgA=;
        b=yLcKwKSMmYTR+OHqTflU/2X5oXZ5vtzkh15WOjapPc0xWn6szKpZ5CTwIN7kWVtqUT
         DCtDC2wHMm/CqubisJrEguonXrECPuoHr7ymyLA+B0qp9oIKtFS6N8qP3eWchL/lF/cH
         mrCpzzAKBQq294QQhftEbtQzsx/fkC2cmq0pHnfE+4REkZ04OyJ3UXSwrAmZCDIUMPzm
         lz8KpldeQaQlRGNesMNwMqHgBSYzVZ0XQNgSe6zbx0mavy9r8loPIObJRUplrSS62Y5R
         CvsuiFaA5OB8G8X8R6FYtd0mmh2rtRtyriIX4FwCntlixk5nB+v7jm3yhC0fr1xyLphU
         zdSQ==
X-Received: by 10.66.173.141 with SMTP id bk13mr1202325pac.137.1412912428903;
        Thu, 09 Oct 2014 20:40:28 -0700 (PDT)
Received: from localhost.localdomain ([171.213.62.98])
        by mx.google.com with ESMTPSA id sa6sm1563051pbb.29.2014.10.09.20.40.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 09 Oct 2014 20:40:28 -0700 (PDT)
From:   Kelvin Cheung <keguang.zhang@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH 3/6] MIPS: Loongson1B: Some fixes/updates for LS1B
Date:   Fri, 10 Oct 2014 11:40:01 +0800
Message-Id: <1412912402-6002-4-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1412912402-6002-1-git-send-email-keguang.zhang@gmail.com>
References: <1412912402-6002-1-git-send-email-keguang.zhang@gmail.com>
Return-Path: <keguang.zhang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43185
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keguang.zhang@gmail.com
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

 - Fix hanging ethernet issue of LS1B v2.0 by adding pbl field in plat data.
   (It seems that the MAC controller of LS1B v2.0 can only accept pbl=1)
 - Add GMAC1 support and setup MUX in terms of PHY mode.
 - Add CPUFreq support.
 - Add MUX Register Definitions.
 - Add PWM Register Definitions.
 - Update clock register bitfields according to the latest spec.
 - Update clock related stuff.

Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
---
 arch/mips/Kconfig                                |   1 +
 arch/mips/include/asm/mach-loongson1/cpufreq.h   |  23 ++++
 arch/mips/include/asm/mach-loongson1/loongson1.h |   8 +-
 arch/mips/include/asm/mach-loongson1/platform.h  |  10 +-
 arch/mips/include/asm/mach-loongson1/regs-clk.h  |  23 +++-
 arch/mips/include/asm/mach-loongson1/regs-mux.h  |  67 +++++++++++
 arch/mips/include/asm/mach-loongson1/regs-pwm.h  |  29 +++++
 arch/mips/loongson1/common/platform.c            | 141 ++++++++++++++++++++---
 arch/mips/loongson1/ls1b/board.c                 |  12 +-
 9 files changed, 283 insertions(+), 31 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-loongson1/cpufreq.h
 create mode 100644 arch/mips/include/asm/mach-loongson1/regs-mux.h
 create mode 100644 arch/mips/include/asm/mach-loongson1/regs-pwm.h

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index ad6badb..63cc6de 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1574,6 +1574,7 @@ config CPU_LOONGSON1
 	select CPU_HAS_PREFETCH
 	select CPU_SUPPORTS_32BIT_KERNEL
 	select CPU_SUPPORTS_HIGHMEM
+	select CPU_SUPPORTS_CPUFREQ
 
 config CPU_BMIPS32_3300
 	select SMP_UP if SMP
diff --git a/arch/mips/include/asm/mach-loongson1/cpufreq.h b/arch/mips/include/asm/mach-loongson1/cpufreq.h
new file mode 100644
index 0000000..e7765ce
--- /dev/null
+++ b/arch/mips/include/asm/mach-loongson1/cpufreq.h
@@ -0,0 +1,23 @@
+/*
+ * Copyright (c) 2014 Zhang, Keguang <keguang.zhang@gmail.com>
+ *
+ * Loongson 1 CPUFreq platform support.
+ *
+ * This program is free software; you can redistribute	it and/or modify it
+ * under  the terms of	the GNU General	 Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+
+#ifndef __ASM_MACH_LOONGSON1_CPUFREQ_H
+#define __ASM_MACH_LOONGSON1_CPUFREQ_H
+
+struct plat_ls1x_cpufreq {
+	const char	*clk_name;	/* CPU clk */
+	const char	*osc_clk_name;	/* OSC clk */
+	unsigned int	max_freq;	/* in kHz */
+	unsigned int	min_freq;	/* in kHz */
+};
+
+#endif /* __ASM_MACH_LOONGSON1_CPUFREQ_H */
diff --git a/arch/mips/include/asm/mach-loongson1/loongson1.h b/arch/mips/include/asm/mach-loongson1/loongson1.h
index 5c437c2..20e0c2b 100644
--- a/arch/mips/include/asm/mach-loongson1/loongson1.h
+++ b/arch/mips/include/asm/mach-loongson1/loongson1.h
@@ -16,6 +16,7 @@
 #define DEFAULT_MEMSIZE			256	/* If no memsize provided */
 
 /* Loongson 1 Register Bases */
+#define LS1X_MUX_BASE			0x1fd00420
 #define LS1X_INTC_BASE			0x1fd01040
 #define LS1X_EHCI_BASE			0x1fe00000
 #define LS1X_OHCI_BASE			0x1fe08000
@@ -31,7 +32,10 @@
 #define LS1X_I2C0_BASE			0x1fe58000
 #define LS1X_I2C1_BASE			0x1fe68000
 #define LS1X_I2C2_BASE			0x1fe70000
-#define LS1X_PWM_BASE			0x1fe5c000
+#define LS1X_PWM0_BASE			0x1fe5c000
+#define LS1X_PWM1_BASE			0x1fe5c010
+#define LS1X_PWM2_BASE			0x1fe5c020
+#define LS1X_PWM3_BASE			0x1fe5c030
 #define LS1X_WDT_BASE			0x1fe5c060
 #define LS1X_RTC_BASE			0x1fe64000
 #define LS1X_AC97_BASE			0x1fe74000
@@ -39,6 +43,8 @@
 #define LS1X_CLK_BASE			0x1fe78030
 
 #include <regs-clk.h>
+#include <regs-mux.h>
+#include <regs-pwm.h>
 #include <regs-wdt.h>
 
 #endif /* __ASM_MACH_LOONGSON1_LOONGSON1_H */
diff --git a/arch/mips/include/asm/mach-loongson1/platform.h b/arch/mips/include/asm/mach-loongson1/platform.h
index 30c13e5..47de55e 100644
--- a/arch/mips/include/asm/mach-loongson1/platform.h
+++ b/arch/mips/include/asm/mach-loongson1/platform.h
@@ -13,10 +13,12 @@
 
 #include <linux/platform_device.h>
 
-extern struct platform_device ls1x_uart_device;
-extern struct platform_device ls1x_eth0_device;
-extern struct platform_device ls1x_ehci_device;
-extern struct platform_device ls1x_rtc_device;
+extern struct platform_device ls1x_uart_pdev;
+extern struct platform_device ls1x_cpufreq_pdev;
+extern struct platform_device ls1x_eth0_pdev;
+extern struct platform_device ls1x_eth1_pdev;
+extern struct platform_device ls1x_ehci_pdev;
+extern struct platform_device ls1x_rtc_pdev;
 
 extern void __init ls1x_clk_init(void);
 extern void __init ls1x_serial_setup(struct platform_device *pdev);
diff --git a/arch/mips/include/asm/mach-loongson1/regs-clk.h b/arch/mips/include/asm/mach-loongson1/regs-clk.h
index fb6a3ff..ee2445b 100644
--- a/arch/mips/include/asm/mach-loongson1/regs-clk.h
+++ b/arch/mips/include/asm/mach-loongson1/regs-clk.h
@@ -20,15 +20,32 @@
 
 /* Clock PLL Divisor Register Bits */
 #define DIV_DC_EN			(0x1 << 31)
+#define DIV_DC_RST			(0x1 << 30)
 #define DIV_CPU_EN			(0x1 << 25)
+#define DIV_CPU_RST			(0x1 << 24)
 #define DIV_DDR_EN			(0x1 << 19)
+#define DIV_DDR_RST			(0x1 << 18)
+#define RST_DC_EN			(0x1 << 5)
+#define RST_DC				(0x1 << 4)
+#define RST_DDR_EN			(0x1 << 3)
+#define RST_DDR				(0x1 << 2)
+#define RST_CPU_EN			(0x1 << 1)
+#define RST_CPU				0x1
 
 #define DIV_DC_SHIFT			26
 #define DIV_CPU_SHIFT			20
 #define DIV_DDR_SHIFT			14
 
-#define DIV_DC_WIDTH			5
-#define DIV_CPU_WIDTH			5
-#define DIV_DDR_WIDTH			5
+#define DIV_DC_WIDTH			4
+#define DIV_CPU_WIDTH			4
+#define DIV_DDR_WIDTH			4
+
+#define BYPASS_DC_SHIFT			12
+#define BYPASS_DDR_SHIFT		10
+#define BYPASS_CPU_SHIFT		8
+
+#define BYPASS_DC_WIDTH			1
+#define BYPASS_DDR_WIDTH		1
+#define BYPASS_CPU_WIDTH		1
 
 #endif /* __ASM_MACH_LOONGSON1_REGS_CLK_H */
diff --git a/arch/mips/include/asm/mach-loongson1/regs-mux.h b/arch/mips/include/asm/mach-loongson1/regs-mux.h
new file mode 100644
index 0000000..fb1e36e
--- /dev/null
+++ b/arch/mips/include/asm/mach-loongson1/regs-mux.h
@@ -0,0 +1,67 @@
+/*
+ * Copyright (c) 2014 Zhang, Keguang <keguang.zhang@gmail.com>
+ *
+ * Loongson 1 MUX Register Definitions.
+ *
+ * This program is free software; you can redistribute	it and/or modify it
+ * under  the terms of	the GNU General	 Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __ASM_MACH_LOONGSON1_REGS_MUX_H
+#define __ASM_MACH_LOONGSON1_REGS_MUX_H
+
+#define LS1X_MUX_REG(x) \
+		((void __iomem *)KSEG1ADDR(LS1X_MUX_BASE + (x)))
+
+#define LS1X_MUX_CTRL0			LS1X_MUX_REG(0x0)
+#define LS1X_MUX_CTRL1			LS1X_MUX_REG(0x4)
+
+/* MUX CTRL0 Register Bits */
+#define UART0_USE_PWM23			(0x1 << 28)
+#define UART0_USE_PWM01			(0x1 << 27)
+#define UART1_USE_LCD0_5_6_11		(0x1 << 26)
+#define I2C2_USE_CAN1			(0x1 << 25)
+#define I2C1_USE_CAN0			(0x1 << 24)
+#define NAND3_USE_UART5			(0x1 << 23)
+#define NAND3_USE_UART4			(0x1 << 22)
+#define NAND3_USE_UART1_DAT		(0x1 << 21)
+#define NAND3_USE_UART1_CTS		(0x1 << 20)
+#define NAND3_USE_PWM23			(0x1 << 19)
+#define NAND3_USE_PWM01			(0x1 << 18)
+#define NAND2_USE_UART5			(0x1 << 17)
+#define NAND2_USE_UART4			(0x1 << 16)
+#define NAND2_USE_UART1_DAT		(0x1 << 15)
+#define NAND2_USE_UART1_CTS		(0x1 << 14)
+#define NAND2_USE_PWM23			(0x1 << 13)
+#define NAND2_USE_PWM01			(0x1 << 12)
+#define NAND1_USE_UART5			(0x1 << 11)
+#define NAND1_USE_UART4			(0x1 << 10)
+#define NAND1_USE_UART1_DAT		(0x1 << 9)
+#define NAND1_USE_UART1_CTS		(0x1 << 8)
+#define NAND1_USE_PWM23			(0x1 << 7)
+#define NAND1_USE_PWM01			(0x1 << 6)
+#define GMAC1_USE_UART1			(0x1 << 4)
+#define GMAC1_USE_UART0			(0x1 << 3)
+#define LCD_USE_UART0_DAT		(0x1 << 2)
+#define LCD_USE_UART15			(0x1 << 1)
+#define LCD_USE_UART0			0x1
+
+/* MUX CTRL1 Register Bits */
+#define USB_RESET			(0x1 << 31)
+#define SPI1_CS_USE_PWM01		(0x1 << 24)
+#define SPI1_USE_CAN			(0x1 << 23)
+#define DISABLE_DDR_CONFSPACE		(0x1 << 20)
+#define DDR32TO16EN			(0x1 << 16)
+#define GMAC1_SHUT			(0x1 << 13)
+#define GMAC0_SHUT			(0x1 << 12)
+#define USB_SHUT			(0x1 << 11)
+#define UART1_3_USE_CAN1		(0x1 << 5)
+#define UART1_2_USE_CAN0		(0x1 << 4)
+#define GMAC1_USE_TXCLK			(0x1 << 3)
+#define GMAC0_USE_TXCLK			(0x1 << 2)
+#define GMAC1_USE_PWM23			(0x1 << 1)
+#define GMAC0_USE_PWM01			0x1
+
+#endif /* __ASM_MACH_LOONGSON1_REGS_MUX_H */
diff --git a/arch/mips/include/asm/mach-loongson1/regs-pwm.h b/arch/mips/include/asm/mach-loongson1/regs-pwm.h
new file mode 100644
index 0000000..99f2bcc
--- /dev/null
+++ b/arch/mips/include/asm/mach-loongson1/regs-pwm.h
@@ -0,0 +1,29 @@
+/*
+ * Copyright (c) 2014 Zhang, Keguang <keguang.zhang@gmail.com>
+ *
+ * Loongson 1 PWM Register Definitions.
+ *
+ * This program is free software; you can redistribute	it and/or modify it
+ * under  the terms of	the GNU General	 Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __ASM_MACH_LOONGSON1_REGS_PWM_H
+#define __ASM_MACH_LOONGSON1_REGS_PWM_H
+
+/* Loongson 1 PWM Timer Register Definitions */
+#define PWM_CNT			0x0
+#define PWM_HRC			0x4
+#define PWM_LRC			0x8
+#define PWM_CTRL		0xc
+
+/* PWM Control Register Bits */
+#define CNT_RST			(0x1 << 7)
+#define INT_SR			(0x1 << 6)
+#define INT_EN			(0x1 << 5)
+#define PWM_SINGLE		(0x1 << 4)
+#define PWM_OE			(0x1 << 3)
+#define CNT_EN			0x1
+
+#endif /* __ASM_MACH_LOONGSON1_REGS_PWM_H */
diff --git a/arch/mips/loongson1/common/platform.c b/arch/mips/loongson1/common/platform.c
index fdf8cb5..ddf1d4c 100644
--- a/arch/mips/loongson1/common/platform.c
+++ b/arch/mips/loongson1/common/platform.c
@@ -16,8 +16,10 @@
 #include <linux/usb/ehci_pdriver.h>
 #include <asm-generic/sizes.h>
 
+#include <cpufreq.h>
 #include <loongson1.h>
 
+/* 8250/16550 compatible UART */
 #define LS1X_UART(_id)						\
 	{							\
 		.mapbase	= LS1X_UART ## _id ## _BASE,	\
@@ -27,7 +29,7 @@
 		.type		= PORT_16550A,			\
 	}
 
-static struct plat_serial8250_port ls1x_serial8250_port[] = {
+static struct plat_serial8250_port ls1x_serial8250_pdata[] = {
 	LS1X_UART(0),
 	LS1X_UART(1),
 	LS1X_UART(2),
@@ -35,11 +37,11 @@ static struct plat_serial8250_port ls1x_serial8250_port[] = {
 	{},
 };
 
-struct platform_device ls1x_uart_device = {
+struct platform_device ls1x_uart_pdev = {
 	.name		= "serial8250",
 	.id		= PLAT8250_DEV_PLATFORM,
 	.dev		= {
-		.platform_data = ls1x_serial8250_port,
+		.platform_data = ls1x_serial8250_pdata,
 	},
 };
 
@@ -48,16 +50,97 @@ void __init ls1x_serial_setup(struct platform_device *pdev)
 	struct clk *clk;
 	struct plat_serial8250_port *p;
 
-	clk = clk_get(NULL, pdev->name);
-	if (IS_ERR(clk))
-		panic("unable to get %s clock, err=%ld",
-			pdev->name, PTR_ERR(clk));
+	clk = clk_get(&pdev->dev, pdev->name);
+	if (IS_ERR(clk)) {
+		pr_err("unable to get %s clock, err=%ld",
+		       pdev->name, PTR_ERR(clk));
+		return;
+	}
+	clk_prepare_enable(clk);
 
 	for (p = pdev->dev.platform_data; p->flags != 0; ++p)
 		p->uartclk = clk_get_rate(clk);
 }
 
+/* CPUFreq */
+static struct plat_ls1x_cpufreq ls1x_cpufreq_pdata = {
+	.clk_name	= "cpu_clk",
+	.osc_clk_name	= "osc_33m_clk",
+	.max_freq	= 266 * 1000,
+	.min_freq	= 33 * 1000,
+};
+
+struct platform_device ls1x_cpufreq_pdev = {
+	.name		= "ls1x-cpufreq",
+	.dev		= {
+		.platform_data = &ls1x_cpufreq_pdata,
+	},
+};
+
 /* Synopsys Ethernet GMAC */
+static struct stmmac_mdio_bus_data ls1x_mdio_bus_data = {
+	.phy_mask	= 0,
+};
+
+static struct stmmac_dma_cfg ls1x_eth_dma_cfg = {
+	.pbl		= 1,
+};
+
+int ls1x_eth_mux_init(struct platform_device *pdev, void *priv)
+{
+	struct plat_stmmacenet_data *plat_dat = NULL;
+	u32 val;
+
+	val = __raw_readl(LS1X_MUX_CTRL1);
+
+	plat_dat = dev_get_platdata(&pdev->dev);
+	if (plat_dat->bus_id) {
+		__raw_writel(__raw_readl(LS1X_MUX_CTRL0) | GMAC1_USE_UART1 |
+			     GMAC1_USE_UART0, LS1X_MUX_CTRL0);
+		switch (plat_dat->interface) {
+		case PHY_INTERFACE_MODE_RGMII:
+			val &= ~(GMAC1_USE_TXCLK | GMAC1_USE_PWM23);
+			break;
+		case PHY_INTERFACE_MODE_MII:
+			val |= (GMAC1_USE_TXCLK | GMAC1_USE_PWM23);
+			break;
+		default:
+			pr_err("unsupported mii mode %d\n",
+			       plat_dat->interface);
+			return -ENOTSUPP;
+		}
+		val &= ~GMAC1_SHUT;
+	} else {
+		switch (plat_dat->interface) {
+		case PHY_INTERFACE_MODE_RGMII:
+			val &= ~(GMAC0_USE_TXCLK | GMAC0_USE_PWM01);
+			break;
+		case PHY_INTERFACE_MODE_MII:
+			val |= (GMAC0_USE_TXCLK | GMAC0_USE_PWM01);
+			break;
+		default:
+			pr_err("unsupported mii mode %d\n",
+			       plat_dat->interface);
+			return -ENOTSUPP;
+		}
+		val &= ~GMAC0_SHUT;
+	}
+	__raw_writel(val, LS1X_MUX_CTRL1);
+
+	return 0;
+}
+
+static struct plat_stmmacenet_data ls1x_eth0_pdata = {
+	.bus_id		= 0,
+	.phy_addr	= -1,
+	.interface	= PHY_INTERFACE_MODE_MII,
+	.mdio_bus_data	= &ls1x_mdio_bus_data,
+	.dma_cfg	= &ls1x_eth_dma_cfg,
+	.has_gmac	= 1,
+	.tx_coe		= 1,
+	.init		= ls1x_eth_mux_init,
+};
+
 static struct resource ls1x_eth0_resources[] = {
 	[0] = {
 		.start	= LS1X_GMAC0_BASE,
@@ -71,25 +154,47 @@ static struct resource ls1x_eth0_resources[] = {
 	},
 };
 
-static struct stmmac_mdio_bus_data ls1x_mdio_bus_data = {
-	.phy_mask	= 0,
+struct platform_device ls1x_eth0_pdev = {
+	.name		= "stmmaceth",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(ls1x_eth0_resources),
+	.resource	= ls1x_eth0_resources,
+	.dev		= {
+		.platform_data = &ls1x_eth0_pdata,
+	},
 };
 
-static struct plat_stmmacenet_data ls1x_eth_data = {
-	.bus_id		= 0,
+static struct plat_stmmacenet_data ls1x_eth1_pdata = {
+	.bus_id		= 1,
 	.phy_addr	= -1,
+	.interface	= PHY_INTERFACE_MODE_MII,
 	.mdio_bus_data	= &ls1x_mdio_bus_data,
+	.dma_cfg	= &ls1x_eth_dma_cfg,
 	.has_gmac	= 1,
 	.tx_coe		= 1,
+	.init		= ls1x_eth_mux_init,
 };
 
-struct platform_device ls1x_eth0_device = {
+static struct resource ls1x_eth1_resources[] = {
+	[0] = {
+		.start	= LS1X_GMAC1_BASE,
+		.end	= LS1X_GMAC1_BASE + SZ_64K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.name	= "macirq",
+		.start	= LS1X_GMAC1_IRQ,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device ls1x_eth1_pdev = {
 	.name		= "stmmaceth",
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(ls1x_eth0_resources),
-	.resource	= ls1x_eth0_resources,
+	.id		= 1,
+	.num_resources	= ARRAY_SIZE(ls1x_eth1_resources),
+	.resource	= ls1x_eth1_resources,
 	.dev		= {
-		.platform_data = &ls1x_eth_data,
+		.platform_data = &ls1x_eth1_pdata,
 	},
 };
 
@@ -111,7 +216,7 @@ static struct resource ls1x_ehci_resources[] = {
 static struct usb_ehci_pdata ls1x_ehci_pdata = {
 };
 
-struct platform_device ls1x_ehci_device = {
+struct platform_device ls1x_ehci_pdev = {
 	.name		= "ehci-platform",
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(ls1x_ehci_resources),
@@ -123,7 +228,7 @@ struct platform_device ls1x_ehci_device = {
 };
 
 /* Real Time Clock */
-struct platform_device ls1x_rtc_device = {
+struct platform_device ls1x_rtc_pdev = {
 	.name		= "ls1x-rtc",
 	.id		= -1,
 };
diff --git a/arch/mips/loongson1/ls1b/board.c b/arch/mips/loongson1/ls1b/board.c
index b26b10d..58daeea 100644
--- a/arch/mips/loongson1/ls1b/board.c
+++ b/arch/mips/loongson1/ls1b/board.c
@@ -10,17 +10,19 @@
 #include <platform.h>
 
 static struct platform_device *ls1b_platform_devices[] __initdata = {
-	&ls1x_uart_device,
-	&ls1x_eth0_device,
-	&ls1x_ehci_device,
-	&ls1x_rtc_device,
+	&ls1x_uart_pdev,
+	&ls1x_cpufreq_pdev,
+	&ls1x_eth0_pdev,
+	&ls1x_eth1_pdev,
+	&ls1x_ehci_pdev,
+	&ls1x_rtc_pdev,
 };
 
 static int __init ls1b_platform_init(void)
 {
 	int err;
 
-	ls1x_serial_setup(&ls1x_uart_device);
+	ls1x_serial_setup(&ls1x_uart_pdev);
 
 	err = platform_add_devices(ls1b_platform_devices,
 				   ARRAY_SIZE(ls1b_platform_devices));
-- 
1.9.1
