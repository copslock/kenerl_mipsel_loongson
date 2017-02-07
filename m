Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Feb 2017 08:30:31 +0100 (CET)
Received: from smtpbg320.qq.com ([14.17.32.29]:49441 "EHLO smtpbg320.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992121AbdBGH36xYaFm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 7 Feb 2017 08:29:58 +0100
X-QQ-mid: bizesmtp16t1486452567t6qc3wr8
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Tue, 07 Feb 2017 15:29:26 +0800 (CST)
X-QQ-SSF: 01100000002000F0FG61B00A0000000
X-QQ-FEAT: UQzUm2uM70eRbXHWZcnJZqJvbeJ4iUHLQ2oyKUBx7NpuPzY0QpF38gwWkHq/2
        Eq51KhNSzLF8cK4l0Q6lxzBU1ooSYXs313qI9nyy+gShRE2tjgHBB1zzWjh8LNaKiAP/VO9
        /EjovVdihirdyHWgzzjAvoVFNNRYHca1jJHvDqGMfNs6VyvvWCeEdx0UFoUrlEku9lWlrfR
        RyaPbr1AoerEf10n9eVj60NqtRBA5p1/1L/ymzvYKU6GgJ4q8WZHFNPWFg6w1lwr9M0Uw2N
        548sFxTdQZb4OFJQxSClVSISw8ZftUlFIZHw==
X-QQ-GoodBg: 0
From:   Binbin Zhou <zhoubb@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Yang Ling <gnaygnil@gmail.com>,
        Binbin Zhou <zhoubb@lemote.com>,
        HuaCai Chen <chenhc@lemote.com>
Subject: [PATCH v4 2/8] MIPS: Loongson: Expand Loongson-1's register definition
Date:   Tue,  7 Feb 2017 15:29:04 +0800
Message-Id: <1486452550-10721-3-git-send-email-zhoubb@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1486452550-10721-1-git-send-email-zhoubb@lemote.com>
References: <1486452550-10721-1-git-send-email-zhoubb@lemote.com>
X-QQ-SENDSIZE: 520
Return-Path: <zhoubb@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56688
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

Rewrite their names for more readable

Signed-off-by: Binbin Zhou <zhoubb@lemote.com>
Signed-off-by: HuaCai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/mach-loongson32/loongson1.h | 170 ++++++++++++++++++----
 arch/mips/loongson32/common/platform.c            |  16 +-
 2 files changed, 149 insertions(+), 37 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson32/loongson1.h b/arch/mips/include/asm/mach-loongson32/loongson1.h
index 84c28a8..8cfd4ba 100644
--- a/arch/mips/include/asm/mach-loongson32/loongson1.h
+++ b/arch/mips/include/asm/mach-loongson32/loongson1.h
@@ -19,35 +19,147 @@
 #endif
 
 /* Loongson 1 Register Bases */
-#define LS1X_MUX_BASE			0x1fd00420
-#define LS1X_INTC_BASE			0x1fd01040
-#define LS1X_GPIO0_BASE			0x1fd010c0
-#define LS1X_GPIO1_BASE			0x1fd010c4
-#define LS1X_DMAC_BASE			0x1fd01160
-#define LS1X_CBUS_BASE			0x1fd011c0
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
diff --git a/arch/mips/loongson32/common/platform.c b/arch/mips/loongson32/common/platform.c
index 100f23d..f71392f 100644
--- a/arch/mips/loongson32/common/platform.c
+++ b/arch/mips/loongson32/common/platform.c
@@ -84,8 +84,8 @@ struct platform_device ls1x_cpufreq_pdev = {
 /* DMA */
 static struct resource ls1x_dma_resources[] = {
 	[0] = {
-		.start = LS1X_DMAC_BASE,
-		.end = LS1X_DMAC_BASE + SZ_4 - 1,
+		.start = LS1X_DMA_ORDER_REG,
+		.end = LS1X_DMA_ORDER_REG + SZ_4 - 1,
 		.flags = IORESOURCE_MEM,
 	},
 	[1] = {
@@ -259,8 +259,8 @@ struct platform_device ls1x_eth1_pdev = {
 /* GPIO */
 static struct resource ls1x_gpio0_resources[] = {
 	[0] = {
-		.start	= LS1X_GPIO0_BASE,
-		.end	= LS1X_GPIO0_BASE + SZ_4 - 1,
+		.start	= LS1X_GPIO_CFG0_REG,
+		.end	= LS1X_GPIO_CFG0_REG + SZ_4 - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 };
@@ -274,8 +274,8 @@ struct platform_device ls1x_gpio0_pdev = {
 
 static struct resource ls1x_gpio1_resources[] = {
 	[0] = {
-		.start	= LS1X_GPIO1_BASE,
-		.end	= LS1X_GPIO1_BASE + SZ_4 - 1,
+		.start	= LS1X_GPIO_CFG1_REG,
+		.end	= LS1X_GPIO_CFG1_REG + SZ_4 - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 };
@@ -290,8 +290,8 @@ struct platform_device ls1x_gpio1_pdev = {
 /* NAND Flash */
 static struct resource ls1x_nand_resources[] = {
 	[0] = {
-		.start	= LS1X_NAND_BASE,
-		.end	= LS1X_NAND_BASE + SZ_32 - 1,
+		.start	= LS1X_NAND_REG_BASE,
+		.end	= LS1X_NAND_REG_BASE + SZ_32 - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-- 
2.9.3
