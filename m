Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Mar 2016 01:49:05 +0100 (CET)
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33610 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27015061AbcCAAsVvvg18 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Mar 2016 01:48:21 +0100
Received: by mail-pf0-f193.google.com with SMTP id l6so391949pfl.0;
        Mon, 29 Feb 2016 16:48:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lqEcADiSbridk8pRuyY0N01YPtrkjH1pWBKc6125deQ=;
        b=Vol4R8Dgn3LPREhORONYwBdVO8SGSBYlTquRB/ZEX0H7hLmLicJPwEmR7JNbTb4pT0
         goXUUQ/6bEcYWLDg43wPmOJHYvAEwEm+iTQcPzpcsfnz+jqdD6lslGfE6E3sEDpUThd7
         RpmqUQ89n+wAPrWQKK2MX1uezcxB43KKpR+sejvtEiMk6VdR6CvDUsKDer9nuAmxOp16
         HqBwelynfxdn5v1+ruiWwR1b7RVSXpt103bcAiXeOaHlzGEI2pk/ynBWH3UiaSqNIeLI
         Zt03JZdaKZYBKmMJqL8LgINXDV8XyKtKWUQ6SdgGssqDHRnC/soOJwUQ9tej5Yysa3oc
         ddWA==
X-Gm-Message-State: AD7BkJIwqKpTTMCoCETLQFHgELzmd20k09D9ks5p5nIzZZ8JkSjKFDDrc4Mqstzg9LPpxg==
X-Received: by 10.98.0.194 with SMTP id 185mr26597165pfa.139.1456793295924;
        Mon, 29 Feb 2016 16:48:15 -0800 (PST)
Received: from software.domain.org ([222.92.8.142])
        by smtp.gmail.com with ESMTPSA id s197sm40683975pfs.62.2016.02.29.16.48.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Feb 2016 16:48:15 -0800 (PST)
From:   Binbin Zhou <zhoubb@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Binbin Zhou <zhoubb@lemote.com>, Chunbo Cui <cuicb@lemote.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH v3 3/8] MIPS: Loongson: Add platform devices for Loongson-1A/1B
Date:   Tue,  1 Mar 2016 08:48:11 +0800
Message-Id: <1456793296-17120-4-git-send-email-zhoubb@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1456793296-17120-1-git-send-email-zhoubb@lemote.com>
References: <1456793296-17120-1-git-send-email-zhoubb@lemote.com>
Return-Path: <zhoubb.aaron@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52366
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

Added basic platform devices for Loongson 1A, including serial port,
ethernet, AHCI, USB, RTC, SPI and so on.

Most of the devices are shared with Loongson 1B, like serial port,
ethernet, USB and so on.
Specially, something like AHCI is only used in Loonson 1A.

Signed-off-by: Chunbo Cui <cuicb@lemote.com>
Signed-off-by: Binbin Zhou <zhoubb@lemote.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/mach-loongson32/irq.h       |   1 +
 arch/mips/include/asm/mach-loongson32/loongson1.h | 167 +++++++++++--
 arch/mips/include/asm/mach-loongson32/platform.h  |  11 +
 arch/mips/loongson32/common/platform.c            | 290 +++++++++++++++++++++-
 4 files changed, 441 insertions(+), 28 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson32/irq.h b/arch/mips/include/asm/mach-loongson32/irq.h
index 0d35b99..326e541 100644
--- a/arch/mips/include/asm/mach-loongson32/irq.h
+++ b/arch/mips/include/asm/mach-loongson32/irq.h
@@ -65,6 +65,7 @@
 #define LS1X_OHCI_IRQ			LS1X_IRQ(1, 1)
 #define LS1X_GMAC0_IRQ			LS1X_IRQ(1, 2)
 #define LS1X_GMAC1_IRQ			LS1X_IRQ(1, 3)
+#define LS1X_AHCI_IRQ			LS1X_IRQ(1, 4)
 
 #define LS1X_IRQS		(LS1X_IRQ(4, 31) + 1 - LS1X_IRQ_BASE)
 
diff --git a/arch/mips/include/asm/mach-loongson32/loongson1.h b/arch/mips/include/asm/mach-loongson32/loongson1.h
index 12aa129..5c1ba48 100644
--- a/arch/mips/include/asm/mach-loongson32/loongson1.h
+++ b/arch/mips/include/asm/mach-loongson32/loongson1.h
@@ -15,32 +15,147 @@
 
 #define DEFAULT_MEMSIZE			256	/* If no memsize provided */
 
-/* Loongson 1 Register Bases */
-#define LS1X_MUX_BASE			0x1fd00420
-#define LS1X_INTC_BASE			0x1fd01040
-#define LS1X_EHCI_BASE			0x1fe00000
-#define LS1X_OHCI_BASE			0x1fe08000
-#define LS1X_GMAC0_BASE			0x1fe10000
-#define LS1X_GMAC1_BASE			0x1fe20000
-
-#define LS1X_UART0_BASE			0x1fe40000
-#define LS1X_UART1_BASE			0x1fe44000
-#define LS1X_UART2_BASE			0x1fe48000
-#define LS1X_UART3_BASE			0x1fe4c000
-#define LS1X_CAN0_BASE			0x1fe50000
-#define LS1X_CAN1_BASE			0x1fe54000
-#define LS1X_I2C0_BASE			0x1fe58000
-#define LS1X_I2C1_BASE			0x1fe68000
-#define LS1X_I2C2_BASE			0x1fe70000
-#define LS1X_PWM0_BASE			0x1fe5c000
-#define LS1X_PWM1_BASE			0x1fe5c010
-#define LS1X_PWM2_BASE			0x1fe5c020
-#define LS1X_PWM3_BASE			0x1fe5c030
-#define LS1X_WDT_BASE			0x1fe5c060
-#define LS1X_RTC_BASE			0x1fe64000
-#define LS1X_AC97_BASE			0x1fe74000
-#define LS1X_NAND_BASE			0x1fe78000
-#define LS1X_CLK_BASE			0x1fe78030
+#define LS1X_DC_REG_BASE		0x1c200000
+#define LS1X_MUX_REG_BASE		0x1f000000
+
+#define LS1X_CFG_REG_BASE		(LS1X_MUX_REG_BASE + 0x00d00000)
+
+#define LS1X_INTC_BASE			(LS1X_CFG_REG_BASE + 0x1040)
+
+/* GPIO regs */
+#define LS1X_GPIO_REG_BASE		(LS1X_CFG_REG_BASE + 0x1000)
+#define LS1X_GPIO_CFG0_REG		(LS1X_GPIO_REG_BASE + 0xc0)
+#define LS1X_GPIO_CFG1_REG		(LS1X_GPIO_REG_BASE + 0xc4)
+#define LS1X_GPIO_CFG2_REG		(LS1X_GPIO_REG_BASE + 0xc8)
+#define LS1X_GPIO_OE0_REG		(LS1X_GPIO_REG_BASE + 0xd0)
+#define LS1X_GPIO_OE1_REG		(LS1X_GPIO_REG_BASE + 0xd4)
+#define LS1X_GPIO_OE2_REG		(LS1X_GPIO_REG_BASE + 0xd8)
+#define LS1X_GPIO_IN0_REG		(LS1X_GPIO_REG_BASE + 0xe0)
+#define LS1X_GPIO_IN1_REG		(LS1X_GPIO_REG_BASE + 0xe4)
+#define LS1X_GPIO_IN2_REG		(LS1X_GPIO_REG_BASE + 0xe8)
+#define LS1X_GPIO_OUT0_REG		(LS1X_GPIO_REG_BASE + 0xf0)
+#define LS1X_GPIO_OUT1_REG		(LS1X_GPIO_REG_BASE + 0xf4)
+#define LS1X_GPIO_OUT2_REG		(LS1X_GPIO_REG_BASE + 0xf8)
+
+#define LS1X_DMA_ORDER_REG		(LS1X_CFG_REG_BASE + 0x1160)
+
+#define LS1X_MUX_BASE			(LS1X_CFG_REG_BASE + 0x0420)
+
+/* USB regs */
+#define LS1X_EHCI_BASE			(LS1X_MUX_REG_BASE + 0x00e00000)
+#define LS1X_OHCI_BASE			(LS1X_MUX_REG_BASE + 0x00e08000)
+
+/* GMAC regs */
+#define LS1X_GMAC0_BASE			(LS1X_MUX_REG_BASE + 0x00e10000)
+#define LS1X_GMAC0_DMA_REG		(LS1X_GMAC0_BASE + 0x1000)
+#define LS1X_GMAC1_BASE			(LS1X_MUX_REG_BASE + 0x00e20000)
+#define LS1X_GMAC1_DMA_REG		(LS1X_GMAC1_BASE + 0x1000)
+
+/* SATA regs */
+#define LS1X_AHCI_BASE			(LS1X_MUX_REG_BASE + 0x00e30000)
+
+/* APB regs */
+#define LS1X_APB_REG_BASE		(LS1X_MUX_REG_BASE + 0x00e40000)
+
+/* UART regs */
+#define LS1X_UART0_BASE			(LS1X_APB_REG_BASE + 0x0000)
+#define LS1X_UART1_BASE			(LS1X_APB_REG_BASE + 0x4000)
+#define LS1X_UART2_BASE			(LS1X_APB_REG_BASE + 0x8000)
+#define LS1X_UART3_BASE			(LS1X_APB_REG_BASE + 0xc000)
+
+/* CAN regs */
+#define LS1X_CAN0_BASE			(LS1X_APB_REG_BASE + 0x10000)
+#define LS1X_CAN1_BASE			(LS1X_APB_REG_BASE + 0x14000)
+
+#define LS1X_I2C0_BASE			(LS1X_APB_REG_BASE + 0x18000)
+#define LS1X_I2C0_PRER_LO_REG		(LS1X_I2C0_BASE + 0x0)
+#define LS1X_I2C0_PRER_HI_REG		(LS1X_I2C0_BASE + 0x1)
+#define LS1X_I2C0_CTR_REG		(LS1X_I2C0_BASE + 0x2)
+#define LS1X_I2C0_TXR_REG		(LS1X_I2C0_BASE + 0x3)
+#define LS1X_I2C0_RXR_REG		(LS1X_I2C0_BASE + 0x3)
+#define LS1X_I2C0_CR_REG		(LS1X_I2C0_BASE + 0x4)
+#define LS1X_I2C0_SR_REG		(LS1X_I2C0_BASE + 0x4)
+
+#define LS1X_I2C1_BASE			(LS1X_APB_REG_BASE + 0x28000)
+#define LS1X_I2C1_PRER_LO_REG		(LS1X_I2C1_BASE + 0x0)
+#define LS1X_I2C1_PRER_HI_REG		(LS1X_I2C1_BASE + 0x1)
+#define LS1X_I2C1_CTR_REG		(LS1X_I2C1_BASE + 0x2)
+#define LS1X_I2C1_TXR_REG		(LS1X_I2C1_BASE + 0x3)
+#define LS1X_I2C1_RXR_REG		(LS1X_I2C1_BASE + 0x3)
+#define LS1X_I2C1_CR_REG		(LS1X_I2C1_BASE + 0x4)
+#define LS1X_I2C1_SR_REG		(LS1X_I2C1_BASE + 0x4)
+
+#define LS1X_I2C2_BASE			(LS1X_APB_REG_BASE + 0x30000)
+#define LS1X_I2C2_PRER_LO_REG		(LS1X_I2C2_BASE + 0x0)
+#define LS1X_I2C2_PRER_HI_REG		(LS1X_I2C2_BASE + 0x1)
+#define LS1X_I2C2_CTR_REG		(LS1X_I2C2_BASE + 0x2)
+#define LS1X_I2C2_TXR_REG		(LS1X_I2C2_BASE + 0x3)
+#define LS1X_I2C2_RXR_REG		(LS1X_I2C2_BASE + 0x3)
+#define LS1X_I2C2_CR_REG		(LS1X_I2C2_BASE + 0x4)
+#define LS1X_I2C2_SR_REG		(LS1X_I2C2_BASE + 0x4)
+
+#define LS1X_PWM_REG_BASE		(LS1X_APB_REG_BASE + 0x1c000)
+#define LS1X_PWM0_BASE			(LS1X_PWM_REG_BASE + 0x00)
+#define LS1X_PWM1_BASE			(LS1X_PWM_REG_BASE + 0x10)
+#define LS1X_PWM2_BASE			(LS1X_PWM_REG_BASE + 0x20)
+#define LS1X_PWM3_BASE			(LS1X_PWM_REG_BASE + 0x30)
+
+/* RTC regs */
+#define LS1X_RTC_BASE			(LS1X_APB_REG_BASE + 0x24000)
+
+/* AC97 regs */
+#define LS1X_AC97_BASE			(LS1X_APB_REG_BASE + 0x34000)
+
+/* Watchdog regs */
+#ifdef CONFIG_CPU_LOONGSON1A
+#define LS1X_WDT_BASE			(LS1X_MUX_REG_BASE + 0x00e7c060)
+#else
+#define LS1X_WDT_BASE			(LS1X_MUX_REG_BASE + 0x00e5c060)
+#endif
+
+/* CLK regs */
+#define LS1X_CLK_BASE			(LS1X_MUX_REG_BASE + 0x00e78030)
+
+/* NAND regs */
+#define LS1X_NAND_REG_BASE		(LS1X_APB_REG_BASE + 0x38000)
+#define LS1X_NAND_CMD_REG		(LS1X_NAND_REG_BASE + 0x0000)
+#define LS1X_NAND_ADDR_C_REG		(LS1X_NAND_REG_BASE + 0x0004)
+#define LS1X_NAND_ADDR_R_REG		(LS1X_NAND_REG_BASE + 0x0008)
+#define LS1X_NAND_TIMING_REG		(LS1X_NAND_REG_BASE + 0x000c)
+#define LS1X_NAND_IDL_REG		(LS1X_NAND_REG_BASE + 0x0010)
+#define LS1X_NAND_STA_IDH_REG		(LS1X_NAND_REG_BASE + 0x0014)
+#define LS1X_NAND_PARAM_REG		(LS1X_NAND_REG_BASE + 0x0018)
+#define LS1X_NAND_OP_NUM_REG		(LS1X_NAND_REG_BASE + 0x001c)
+#define LS1X_NAND_CSRDY_MAP_REG		(LS1X_NAND_REG_BASE + 0x0020)
+#define LS1X_NAND_DMA_ACC_REG		(LS1X_NAND_REG_BASE + 0x0040)
+
+/* ACPI regs for ls1a */
+#define LS1X_ACPI_REG_BASE		(LS1X_APB_REG_BASE + 0x3c000)
+#define LS1X_PM1_STS_REG		(LS1X_ACPI_REG_BASE + 0x0000)
+#define LS1X_PM1_EN_REG			(LS1X_ACPI_REG_BASE + 0x0004)
+#define LS1X_PM1_CNT_REG		(LS1X_ACPI_REG_BASE + 0x0008)
+#define LS1X_PM1_TMR_REG		(LS1X_ACPI_REG_BASE + 0x000c)
+#define LS1X_P_CNT_REG			(LS1X_ACPI_REG_BASE + 0x0010)
+#define LS1X_P_LVL2_REG			(LS1X_ACPI_REG_BASE + 0x0014)
+#define LS1X_P_LVL3_REG			(LS1X_ACPI_REG_BASE + 0x0018)
+#define LS1X_GPE0_STS_REG		(LS1X_ACPI_REG_BASE + 0x0020)
+#define LS1X_GPE0_EN_REG		(LS1X_ACPI_REG_BASE + 0x0024)
+#define LS1X_PM_CONF1_REG		(LS1X_ACPI_REG_BASE + 0x0030)
+#define LS1X_PM_CONF2_REG		(LS1X_ACPI_REG_BASE + 0x0034)
+#define LS1X_PM_CONF3_REG		(LS1X_ACPI_REG_BASE + 0x0038)
+#define LS1X_RST_CNT_REG		(LS1X_ACPI_REG_BASE + 0x0044)
+#define LS1X_CPU_INIT_REG		(LS1X_ACPI_REG_BASE + 0x0050)
+
+#define LS1X_SPI0_REG_BASE		(LS1X_MUX_REG_BASE + 0x00e80000)
+#define LS1X_SPI1_REG_BASE		(LS1X_MUX_REG_BASE + 0x00ec0000)
+
+/* LPC regs */
+#define LS1X_LPC_IO_BASE		(LS1X_MUX_REG_BASE + 0x00f00000)
+#define LS1X_LPC_REG_BASE		(LS1X_MUX_REG_BASE + 0x00f10200)
+#define LS1X_LPC_CFG0_REG		(LS1X_LPC_REG_BASE + 0x0)
+#define LS1X_LPC_CFG1_REG		(LS1X_LPC_REG_BASE + 0x4)
+#define LS1X_LPC_CFG2_REG		(LS1X_LPC_REG_BASE + 0x8)
+#define LS1X_LPC_CFG3_REG		(LS1X_LPC_REG_BASE + 0xc)
 
 #include <regs-clk.h>
 #include <regs-mux.h>
diff --git a/arch/mips/include/asm/mach-loongson32/platform.h b/arch/mips/include/asm/mach-loongson32/platform.h
index c32f03f..f25398c 100644
--- a/arch/mips/include/asm/mach-loongson32/platform.h
+++ b/arch/mips/include/asm/mach-loongson32/platform.h
@@ -19,6 +19,17 @@ extern struct platform_device ls1x_eth0_pdev;
 extern struct platform_device ls1x_eth1_pdev;
 extern struct platform_device ls1x_ehci_pdev;
 extern struct platform_device ls1x_rtc_pdev;
+extern struct platform_device ls1x_fb_pdev;
+extern struct platform_device ls1x_i2c0_pdev;
+extern struct platform_device ls1x_i2c1_pdev;
+extern struct platform_device ls1x_i2c2_pdev;
+extern struct platform_device ls1x_ahci_pdev;
+extern struct platform_device ls1x_ohci_pdev;
+extern struct platform_device ls1x_wat_pdev;
+extern struct platform_device ls1x_audio_pdev;
+extern struct platform_device ls1x_spi0_pdev;
+extern struct platform_device ls1x_spi1_pdev;
+extern struct platform_device ls1x_nand_pdev;
 
 extern void __init ls1x_clk_init(void);
 extern void __init ls1x_serial_setup(struct platform_device *pdev);
diff --git a/arch/mips/loongson32/common/platform.c b/arch/mips/loongson32/common/platform.c
index ddf1d4c..97d8c01 100644
--- a/arch/mips/loongson32/common/platform.c
+++ b/arch/mips/loongson32/common/platform.c
@@ -8,12 +8,27 @@
  */
 
 #include <linux/clk.h>
+#include <linux/device.h>
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/phy.h>
 #include <linux/serial_8250.h>
 #include <linux/stmmac.h>
 #include <linux/usb/ehci_pdriver.h>
+#include <linux/usb/ohci_pdriver.h>
+#include <linux/platform_device.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/resource.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/flash.h>
+#include <linux/i2c.h>
+#include <linux/delay.h>
+#include <linux/gpio_keys.h>
+#include <linux/input.h>
+#include <linux/sizes.h>
 #include <asm-generic/sizes.h>
 
 #include <cpufreq.h>
@@ -23,6 +38,7 @@
 #define LS1X_UART(_id)						\
 	{							\
 		.mapbase	= LS1X_UART ## _id ## _BASE,	\
+		.membase	= (u8 *)KSEG1ADDR(LS1X_UART ## _id ## _BASE), \
 		.irq		= LS1X_UART ## _id ## _IRQ,	\
 		.iotype		= UPIO_MEM,			\
 		.flags		= UPF_IOREMAP | UPF_FIXED_TYPE, \
@@ -138,7 +154,9 @@ static struct plat_stmmacenet_data ls1x_eth0_pdata = {
 	.dma_cfg	= &ls1x_eth_dma_cfg,
 	.has_gmac	= 1,
 	.tx_coe		= 1,
+#ifndef CONFIG_CPU_LOONGSON1A
 	.init		= ls1x_eth_mux_init,
+#endif
 };
 
 static struct resource ls1x_eth0_resources[] = {
@@ -172,7 +190,9 @@ static struct plat_stmmacenet_data ls1x_eth1_pdata = {
 	.dma_cfg	= &ls1x_eth_dma_cfg,
 	.has_gmac	= 1,
 	.tx_coe		= 1,
+#ifndef CONFIG_CPU_LOONGSON1A
 	.init		= ls1x_eth_mux_init,
+#endif
 };
 
 static struct resource ls1x_eth1_resources[] = {
@@ -199,7 +219,7 @@ struct platform_device ls1x_eth1_pdev = {
 };
 
 /* USB EHCI */
-static u64 ls1x_ehci_dmamask = DMA_BIT_MASK(32);
+static u64 platform_dma_mask = DMA_BIT_MASK(32);
 
 static struct resource ls1x_ehci_resources[] = {
 	[0] = {
@@ -222,13 +242,279 @@ struct platform_device ls1x_ehci_pdev = {
 	.num_resources	= ARRAY_SIZE(ls1x_ehci_resources),
 	.resource	= ls1x_ehci_resources,
 	.dev		= {
-		.dma_mask = &ls1x_ehci_dmamask,
+		.dma_mask = &platform_dma_mask,
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
+		.dma_mask	= &platform_dma_mask,
+		.platform_data	= &ls1x_ohci_data,
+	},
+};
+
+/* AHCI */
+static struct resource ls1x_ahci_resources[] = {
+	[0] = {
+		.start	= LS1X_AHCI_BASE,
+		.end	= LS1X_AHCI_BASE + SZ_64K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= LS1X_AHCI_IRQ,
+		.end	= LS1X_AHCI_IRQ,
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
+		.dma_mask = &platform_dma_mask,
+	},
+};
+
 /* Real Time Clock */
+static struct resource ls1x_rtc_resource[] = {
+	[0] = {
+		.start	= LS1X_RTC_BASE,
+		.end	= LS1X_RTC_BASE + SZ_16K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= LS1X_TOY_INT2_IRQ,
+		.end	= LS1X_TOY_INT2_IRQ,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
 struct platform_device ls1x_rtc_pdev = {
 	.name		= "ls1x-rtc",
 	.id		= -1,
+	.num_resources	= ARRAY_SIZE(ls1x_rtc_resource),
+	.resource	= ls1x_rtc_resource,
+};
+
+/* FrameBuffer */
+static struct resource ls1x_fb_resources[] = {
+	[0] = {
+		.start	= LS1X_DC_REG_BASE,
+		.end	= LS1X_DC_REG_BASE + SZ_1M - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+struct platform_device ls1x_fb_pdev = {
+	.name           = "ls1x-fb",
+	.id             = -1,
+	.num_resources	= ARRAY_SIZE(ls1x_fb_resources),
+	.resource	= ls1x_fb_resources,
+};
+
+/* I2C */
+static struct resource ls1x_i2c0_resource[] = {
+	[0] = {
+		.start	= LS1X_I2C0_BASE,
+		.end	= LS1X_I2C0_BASE + SZ_16K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+struct platform_device ls1x_i2c0_pdev = {
+	.name		= "ls1x-i2c",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(ls1x_i2c0_resource),
+	.resource	= ls1x_i2c0_resource,
+};
+
+static struct resource ls1x_i2c1_resource[] = {
+	[0] = {
+		.start	= LS1X_I2C1_BASE,
+		.end	= LS1X_I2C1_BASE + SZ_16K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+struct platform_device ls1x_i2c1_pdev = {
+	.name		= "ls1x-i2c",
+	.id		= 1,
+	.num_resources	= ARRAY_SIZE(ls1x_i2c1_resource),
+	.resource	= ls1x_i2c1_resource,
+};
+
+static struct resource ls1x_i2c2_resource[] = {
+	[0] = {
+		.start	= LS1X_I2C2_BASE,
+		.end	= LS1X_I2C2_BASE + SZ_16K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+struct platform_device ls1x_i2c2_pdev = {
+	.name		= "ls1x-i2c",
+	.id		= 2,
+	.num_resources	= ARRAY_SIZE(ls1x_i2c2_resource),
+	.resource	= ls1x_i2c2_resource,
+};
+
+/* Watchdog */
+static struct resource ls1x_wat_resource[] = {
+	[0] = {
+		.start	= LS1X_WDT_BASE,
+		.end	= LS1X_WDT_BASE + SZ_8,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+struct platform_device ls1x_wat_pdev = {
+	.name		= "ls1x-wdt",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(ls1x_wat_resource),
+	.resource	= ls1x_wat_resource,
+};
+
+/* NAND */
+struct ls1x_nand_platform_data {
+	int		enable_arbiter;
+	struct		mtd_partition *parts;
+	unsigned int	nr_parts;
+};
+
+static struct mtd_partition ls1x_nand_partitions[] = {
+	[0] = {
+		.name   = "kernel",
+		.offset = 0,
+		.size   = 0x01400000,
+	},
+	[1] = {
+		.name   = "os",
+		.offset = 0x01400000,
+		.size   = 0x0,
+	},
+};
+
+static struct ls1x_nand_platform_data ls1x_nand_parts = {
+	.enable_arbiter	= 1,
+	.parts		= ls1x_nand_partitions,
+	.nr_parts	= ARRAY_SIZE(ls1x_nand_partitions),
+};
+
+static struct resource ls1x_nand_resources[] = {
+	[0] = {
+		.start	= 0,
+		.end	= 0,
+		.flags	= IORESOURCE_DMA,
+	},
+	[1] = {
+		.start	= LS1X_NAND_REG_BASE,
+		.end	= LS1X_NAND_REG_BASE + SZ_16K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[2] = {
+		.start	= LS1X_DMA_ORDER_REG,
+		.end	= LS1X_DMA_ORDER_REG,
+		.flags	= IORESOURCE_MEM,
+	},
+	[3] = {
+		.start	= LS1X_DMA0_IRQ,
+		.end	= LS1X_DMA0_IRQ,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device ls1x_nand_pdev = {
+	.name		= "ls1x-nand",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(ls1x_nand_resources),
+	.resource	= ls1x_nand_resources,
+	.dev		= {
+		.platform_data = &ls1x_nand_parts,
+	},
+};
+
+/* AC97 Audio */
+static struct resource ls1x_audio_resources[] = {
+	[0] = {
+		.start = LS1X_AC97_BASE,
+		.end   = LS1X_AC97_BASE + SZ_16K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = LS1X_AC97_IRQ,
+		.end   = LS1X_AC97_IRQ,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device ls1x_audio_pdev = {
+	.name		= "ls1x-audio",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(ls1x_audio_resources),
+	.resource	= ls1x_audio_resources,
+};
+
+/* SPI */
+static struct resource ls1x_spi0_resources[] = {
+	[1] = {
+		.start	= LS1X_SPI0_REG_BASE,
+		.end	= LS1X_SPI0_REG_BASE,
+		.flags	= IORESOURCE_MEM,
+	},
+	[2] = {
+		.start	= LS1X_SPI0_IRQ,
+		.end	= LS1X_SPI0_IRQ,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device ls1x_spi0_pdev = {
+	.name		= "ls1x-spi",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(ls1x_spi0_resources),
+	.resource	= ls1x_spi0_resources,
+};
+
+static struct resource ls1x_spi1_resources[] = {
+	[1] = {
+		.start	= LS1X_SPI1_REG_BASE,
+		.end	= LS1X_SPI1_REG_BASE,
+		.flags	= IORESOURCE_MEM,
+	},
+	[2] = {
+		.start	= LS1X_SPI1_IRQ,
+		.end	= LS1X_SPI1_IRQ,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device ls1x_spi1_pdev = {
+	.name		= "ls1x-spi",
+	.id		= 1,
+	.num_resources	= ARRAY_SIZE(ls1x_spi1_resources),
+	.resource	= ls1x_spi1_resources,
 };
-- 
1.9.1
