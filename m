Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jun 2017 11:00:06 +0200 (CEST)
Received: from smtpbg339.qq.com ([14.17.44.34]:56628 "EHLO smtpbg339.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991955AbdFTI5meqFf2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 20 Jun 2017 10:57:42 +0200
X-QQ-mid: bizesmtp2t1497949009tg0ju4few
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Tue, 20 Jun 2017 16:56:48 +0800 (CST)
X-QQ-SSF: 01100000008000F0FIF1000A0000000
X-QQ-FEAT: azVybbNp5hA3Vmuwj9PxKhfhzSmXzpzJiQqc9r7+LMtIDzyLBkqybhhjZZlH+
        OD/b5kpn2Is44UHc1tYxFILywb0vaXvKsy5ZVEJ63AuhOhf3g+8k4xlv3oO57ANAmQjVHgk
        1/1o4d4d2E68e9TJIYQs0py9Z2krJNm/XF/uIBWHEgQF6pyTmvu1VjbG6RsFtzY0sNHstik
        mBY9ixbyufY2E1woScexyJ8xXYaVSIn8btI6q2VH+XGMAh+fGDXlOLZ1olW+yGqoT3OcxqV
        Xcj8FkJq0+3n4+K/uO87n9RHYD/KX+bO/luhcuUrY1rJM80mi163bMov8=
X-QQ-GoodBg: 0
From:   Binbin Zhou <zhoubb@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Yang Ling <gnaygnil@gmail.com>,
        =?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6?= <Yeking@Red54.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        Binbin Zhou <zhoubb@lemote.com>,
        HuaCai Chen <chenhc@lemote.com>
Subject: [PATCH v8 5/9] MIPS: Loongson: Add platform devices for Loongson-1A
Date:   Tue, 20 Jun 2017 16:57:03 +0800
Message-Id: <1497949027-10988-6-git-send-email-zhoubb@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1497949027-10988-1-git-send-email-zhoubb@lemote.com>
References: <1497949027-10988-1-git-send-email-zhoubb@lemote.com>
X-QQ-SENDSIZE: 520
Return-Path: <zhoubb@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58677
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhoubb@lemote.com
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

Added basic platform devices for Loongson-1A, including serial port,
ethernet, AHCI, USB and so on.

As we known, Most of them are shared with Loongson-1B/1C,
like serial port, ethernet and so on.

But something like AHCI is only supported by Loonson-1A.

Signed-off-by: Binbin Zhou <zhoubb@lemote.com>
Signed-off-by: HuaCai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/mach-loongson32/irq.h       | 16 ++++--
 arch/mips/include/asm/mach-loongson32/loongson1.h |  2 +-
 arch/mips/include/asm/mach-loongson32/platform.h  |  2 +
 arch/mips/include/asm/mach-loongson32/regs-mux.h  | 36 +++++++++++-
 arch/mips/loongson32/common/irq.c                 |  2 +-
 arch/mips/loongson32/common/platform.c            | 67 +++++++++++++++++++++--
 6 files changed, 111 insertions(+), 14 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson32/irq.h b/arch/mips/include/asm/mach-loongson32/irq.h
index 8c01b30..e790957 100644
--- a/arch/mips/include/asm/mach-loongson32/irq.h
+++ b/arch/mips/include/asm/mach-loongson32/irq.h
@@ -36,7 +36,7 @@
 #define LS1X_IRQ(n, x)			(LS1X_IRQ_BASE + (n << 5) + (x))
 
 #define LS1X_UART0_IRQ			LS1X_IRQ(0, 2)
-#if defined(CONFIG_LOONGSON1_LS1B)
+#if defined(CONFIG_LOONGSON1_LS1A) || defined(CONFIG_LOONGSON1_LS1B)
 #define LS1X_UART1_IRQ			LS1X_IRQ(0, 3)
 #define LS1X_UART2_IRQ			LS1X_IRQ(0, 4)
 #define LS1X_UART3_IRQ			LS1X_IRQ(0, 5)
@@ -52,7 +52,9 @@
 #define LS1X_DMA0_IRQ			LS1X_IRQ(0, 13)
 #define LS1X_DMA1_IRQ			LS1X_IRQ(0, 14)
 #define LS1X_DMA2_IRQ			LS1X_IRQ(0, 15)
-#if defined(CONFIG_LOONGSON1_LS1C)
+#if defined(CONFIG_LOONGSON1_LS1A)
+#define LS1X_LPC_IRQ			LS1X_IRQ(0, 16)
+#elif defined(CONFIG_LOONGSON1_LS1C)
 #define LS1X_NAND_IRQ			LS1X_IRQ(0, 16)
 #endif
 #define LS1X_PWM0_IRQ			LS1X_IRQ(0, 17)
@@ -62,7 +64,7 @@
 #define LS1X_RTC_INT0_IRQ		LS1X_IRQ(0, 21)
 #define LS1X_RTC_INT1_IRQ		LS1X_IRQ(0, 22)
 #define LS1X_RTC_INT2_IRQ		LS1X_IRQ(0, 23)
-#if defined(CONFIG_LOONGSON1_LS1B)
+#if defined(CONFIG_LOONGSON1_LS1A) || defined(CONFIG_LOONGSON1_LS1B)
 #define LS1X_TOY_INT0_IRQ		LS1X_IRQ(0, 24)
 #define LS1X_TOY_INT1_IRQ		LS1X_IRQ(0, 25)
 #define LS1X_TOY_INT2_IRQ		LS1X_IRQ(0, 26)
@@ -78,7 +80,11 @@
 
 #define LS1X_EHCI_IRQ			LS1X_IRQ(1, 0)
 #define LS1X_OHCI_IRQ			LS1X_IRQ(1, 1)
-#if defined(CONFIG_LOONGSON1_LS1B)
+#if defined(CONFIG_LOONGSON1_LS1A)
+#define LS1X_GMAC0_IRQ			LS1X_IRQ(1, 2)
+#define LS1X_GMAC1_IRQ			LS1X_IRQ(1, 3)
+#define LS1X_SATA_IRQ			LS1X_IRQ(1, 4)
+#elif defined(CONFIG_LOONGSON1_LS1B)
 #define LS1X_GMAC0_IRQ			LS1X_IRQ(1, 2)
 #define LS1X_GMAC1_IRQ			LS1X_IRQ(1, 3)
 #elif defined(CONFIG_LOONGSON1_LS1C)
@@ -100,7 +106,7 @@
 
 #if defined(CONFIG_LOONGSON1_LS1B)
 #define INTN	4
-#elif defined(CONFIG_LOONGSON1_LS1C)
+#elif defined(CONFIG_LOONGSON1_LS1A) || defined(CONFIG_LOONGSON1_LS1C)
 #define INTN	5
 #endif
 
diff --git a/arch/mips/include/asm/mach-loongson32/loongson1.h b/arch/mips/include/asm/mach-loongson32/loongson1.h
index 8cfd4ba..029b3b7 100644
--- a/arch/mips/include/asm/mach-loongson32/loongson1.h
+++ b/arch/mips/include/asm/mach-loongson32/loongson1.h
@@ -12,7 +12,7 @@
 #ifndef __ASM_MACH_LOONGSON32_LOONGSON1_H
 #define __ASM_MACH_LOONGSON32_LOONGSON1_H
 
-#if defined(CONFIG_LOONGSON1_LS1B)
+#if defined(CONFIG_LOONGSON1_LS1A) || defined(CONFIG_LOONGSON1_LS1B)
 #define DEFAULT_MEMSIZE			64	/* If no memsize provided */
 #elif defined(CONFIG_LOONGSON1_LS1C)
 #define DEFAULT_MEMSIZE			32
diff --git a/arch/mips/include/asm/mach-loongson32/platform.h b/arch/mips/include/asm/mach-loongson32/platform.h
index 8f8fa43..f28f814 100644
--- a/arch/mips/include/asm/mach-loongson32/platform.h
+++ b/arch/mips/include/asm/mach-loongson32/platform.h
@@ -26,6 +26,8 @@ extern struct platform_device ls1x_gpio1_pdev;
 extern struct platform_device ls1x_nand_pdev;
 extern struct platform_device ls1x_rtc_pdev;
 extern struct platform_device ls1x_wdt_pdev;
+extern struct platform_device ls1x_ahci_pdev;
+extern struct platform_device ls1x_ohci_pdev;
 
 void __init ls1x_clk_init(void);
 void __init ls1x_dma_set_platdata(struct plat_ls1x_dma *pdata);
diff --git a/arch/mips/include/asm/mach-loongson32/regs-mux.h b/arch/mips/include/asm/mach-loongson32/regs-mux.h
index 4a0bdeb..2c22603 100644
--- a/arch/mips/include/asm/mach-loongson32/regs-mux.h
+++ b/arch/mips/include/asm/mach-loongson32/regs-mux.h
@@ -18,7 +18,41 @@
 #define LS1X_MUX_CTRL0			LS1X_MUX_REG(0x0)
 #define LS1X_MUX_CTRL1			LS1X_MUX_REG(0x4)
 
-#if defined(CONFIG_LOONGSON1_LS1B)
+#if defined(CONFIG_LOONGSON1_LS1A)
+/* GPIO CTRL0 Register Bits */
+#define NAND3_USE_CAN1			BIT(31)
+#define NAND2_USE_MS			BIT(30)
+#define NAND1_USE_PWM01			BIT(29)
+#define NAND3_D45_USE_PWM23		BIT(28)
+#define NAND3_D45_USE_LPC		BIT(27)
+#define NAND3_D03_USE_SPI1		BIT(26)
+#define NAND3_D03_USE_LPC		BIT(25)
+#define GMAC1_SHUT			BIT(24)
+#define GMAC0_SHUT			BIT(23)
+#define SATA_SHUT			BIT(22)
+#define USB_SHUT			BIT(21)
+#define GPU_SHUT			BIT(20)
+#define DDR2_SHUT			BIT(19)
+#define VGA_USE_PCI			BIT(18)
+#define I2C3_USE_CAN0			BIT(17)
+#define I2C2_USE_CAN1			BIT(16)
+#define SPI0_USE_CAN0_TX		BIT(15)
+#define SPI0_USE_CAN0_RX		BIT(14)
+#define SPI1_USE_CAN1_TX		BIT(13)
+#define SPI1_USE_CAN1_RX		BIT(12)
+#define GMAC1_USE_TXCLK			BIT(11)
+#define GMAC0_USE_TXCLK			BIT(10)
+#define GMAC1_USE_PWM23			BIT(9)
+#define GMAC0_USE_PWM01			BIT(8)
+#define GMAC1_USE_UART1			BIT(7)
+#define GMAC1_USE_UART0			BIT(6)
+#define GMAC1_USE_SPI1			BIT(5)
+#define GMAC1_USE_NAND			BIT(4)
+#define PCI_REQ2_USE_GMAC1		BIT(2)
+#define DISABLE_DDR2_CONFSPACE		BIT(1)
+#define DDE32TO16EN			BIT(0)
+
+#elif defined(CONFIG_LOONGSON1_LS1B)
 /* MUX CTRL0 Register Bits */
 #define UART0_USE_PWM23			BIT(28)
 #define UART0_USE_PWM01			BIT(27)
diff --git a/arch/mips/loongson32/common/irq.c b/arch/mips/loongson32/common/irq.c
index 635a4ab..b414eca 100644
--- a/arch/mips/loongson32/common/irq.c
+++ b/arch/mips/loongson32/common/irq.c
@@ -184,7 +184,7 @@ static void __init ls1x_irq_init(int base)
 	setup_irq(INT1_IRQ, &cascade_irqaction);
 	setup_irq(INT2_IRQ, &cascade_irqaction);
 	setup_irq(INT3_IRQ, &cascade_irqaction);
-#if defined(CONFIG_LOONGSON1_LS1C)
+#if defined(CONFIG_LOONGSON1_LS1A) || defined(CONFIG_LOONGSON1_LS1C)
 	setup_irq(INT4_IRQ, &cascade_irqaction);
 #endif
 }
diff --git a/arch/mips/loongson32/common/platform.c b/arch/mips/loongson32/common/platform.c
index f71392f..6b83fcf 100644
--- a/arch/mips/loongson32/common/platform.c
+++ b/arch/mips/loongson32/common/platform.c
@@ -16,6 +16,7 @@
 #include <linux/serial_8250.h>
 #include <linux/stmmac.h>
 #include <linux/usb/ehci_pdriver.h>
+#include <linux/usb/ohci_pdriver.h>
 
 #include <platform.h>
 #include <loongson1.h>
@@ -133,7 +134,7 @@ int ls1x_eth_mux_init(struct platform_device *pdev, void *priv)
 
 	val = __raw_readl(LS1X_MUX_CTRL1);
 
-#if defined(CONFIG_LOONGSON1_LS1B)
+#if defined(CONFIG_LOONGSON1_LS1A) || defined(CONFIG_LOONGSON1_LS1B)
 	plat_dat = dev_get_platdata(&pdev->dev);
 	if (plat_dat->bus_id) {
 		__raw_writel(__raw_readl(LS1X_MUX_CTRL0) | GMAC1_USE_UART1 |
@@ -185,7 +186,7 @@ int ls1x_eth_mux_init(struct platform_device *pdev, void *priv)
 static struct plat_stmmacenet_data ls1x_eth0_pdata = {
 	.bus_id		= 0,
 	.phy_addr	= -1,
-#if defined(CONFIG_LOONGSON1_LS1B)
+#if defined(CONFIG_LOONGSON1_LS1A) || defined(CONFIG_LOONGSON1_LS1B)
 	.interface	= PHY_INTERFACE_MODE_MII,
 #elif defined(CONFIG_LOONGSON1_LS1C)
 	.interface	= PHY_INTERFACE_MODE_RMII,
@@ -220,7 +221,7 @@ struct platform_device ls1x_eth0_pdev = {
 	},
 };
 
-#ifdef CONFIG_LOONGSON1_LS1B
+#if defined(CONFIG_LOONGSON1_LS1A) || defined(CONFIG_LOONGSON1_LS1B)
 static struct plat_stmmacenet_data ls1x_eth1_pdata = {
 	.bus_id		= 1,
 	.phy_addr	= -1,
@@ -254,7 +255,7 @@ struct platform_device ls1x_eth1_pdev = {
 		.platform_data = &ls1x_eth1_pdata,
 	},
 };
-#endif	/* CONFIG_LOONGSON1_LS1B */
+#endif	/* CONFIG_LOONGSON1_LS1A || CONFIG_LOONGSON1_LS1B */
 
 /* GPIO */
 static struct resource ls1x_gpio0_resources[] = {
@@ -315,7 +316,7 @@ void __init ls1x_nand_set_platdata(struct plat_ls1x_nand *pdata)
 }
 
 /* USB EHCI */
-static u64 ls1x_ehci_dmamask = DMA_BIT_MASK(32);
+static u64 ls1x_platform_dmamask = DMA_BIT_MASK(32);
 
 static struct resource ls1x_ehci_resources[] = {
 	[0] = {
@@ -338,11 +339,65 @@ struct platform_device ls1x_ehci_pdev = {
 	.num_resources	= ARRAY_SIZE(ls1x_ehci_resources),
 	.resource	= ls1x_ehci_resources,
 	.dev		= {
-		.dma_mask = &ls1x_ehci_dmamask,
+		.dma_mask = &ls1x_platform_dmamask,
 		.platform_data = &ls1x_ehci_pdata,
 	},
 };
 
+/* USB OHCI */
+static struct resource ls1x_ohci_resources[] = {
+	[0] = {
+		.start	= LS1X_OHCI_BASE,
+		.end	= LS1X_OHCI_BASE + SZ_32K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= LS1X_OHCI_IRQ,
+		.end	= LS1X_OHCI_IRQ,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct usb_ohci_pdata ls1x_ohci_data = {
+};
+
+struct platform_device ls1x_ohci_pdev = {
+	.name		= "ohci-platform",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(ls1x_ohci_resources),
+	.resource	= ls1x_ohci_resources,
+	.dev = {
+		.dma_mask	= &ls1x_platform_dmamask,
+		.platform_data	= &ls1x_ohci_data,
+	},
+};
+
+#ifdef CONFIG_LOONGSON1_LS1A
+/* AHCI */
+static struct resource ls1x_ahci_resources[] = {
+	[0] = {
+		.start	= LS1X_AHCI_BASE,
+		.end	= LS1X_AHCI_BASE + SZ_64K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= LS1X_SATA_IRQ,
+		.end	= LS1X_SATA_IRQ,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device ls1x_ahci_pdev = {
+	.name		= "ahci",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(ls1x_ahci_resources),
+	.resource	= ls1x_ahci_resources,
+	.dev		= {
+		.dma_mask = &ls1x_platform_dmamask,
+	},
+};
+#endif
+
 /* Real Time Clock */
 void __init ls1x_rtc_set_extclk(struct platform_device *pdev)
 {
-- 
2.9.4
