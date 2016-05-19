Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 May 2016 03:42:55 +0200 (CEST)
Received: from smtpproxy19.qq.com ([184.105.206.84]:41691 "EHLO
        smtpproxy19.qq.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27028735AbcESBmx4iTk0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 May 2016 03:42:53 +0200
X-QQ-mid: bizesmtp3t1463622161t557t177
Received: from localhost.localdomain (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Thu, 19 May 2016 09:42:39 +0800 (CST)
X-QQ-SSF: 01100000002000F0FG70000A0000000
X-QQ-FEAT: QX/rXDl9P1tHnm5aWhsCbndWRF2kNHAzkfsxMIqA+9joR9NKiGIxFFGvGLm5X
        ABtBHjyKDylC26BY+nTbQK9qCtnfIVaEPeuWIW8VsVv0Oq+27FhJ32AL4h7wzpUg/HXr1u9
        JzY8NDmTt1HDWshStBCCVjuzw5xNxzFpxitB15ICViQFF89ya5qZTtL+339LRfFNKXl3xWD
        XmBs9o+njCQNK6JAzV/Cy4XQbZ9SP2lrc/8Wj23dA3iB6Al6s8tjj22DhxB2Q6ZLlqVwsUD
        mh1hIgRWrNsaPmH+E24KIWnkc=
X-QQ-GoodBg: 0
From:   Binbin Zhou <zhoubb@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Binbin Zhou <zhoubb@lemote.com>, Chunbo Cui <cuichboo@163.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH RESEND v4 3/9] MIPS: Loongson: Add platform devices for Loongson-1A/1B
Date:   Thu, 19 May 2016 09:38:28 +0800
Message-Id: <1463621912-9883-4-git-send-email-zhoubb@lemote.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1463621912-9883-1-git-send-email-zhoubb@lemote.com>
References: <1463621912-9883-1-git-send-email-zhoubb@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <zhoubb@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53529
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

Signed-off-by: Chunbo Cui <cuichboo@163.com>
Signed-off-by: Binbin Zhou <zhoubb@lemote.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/mach-loongson32/dma.h       |   1 +
 arch/mips/include/asm/mach-loongson32/irq.h       |   1 +
 arch/mips/include/asm/mach-loongson32/loongson1.h | 172 ++++++++++++---
 arch/mips/include/asm/mach-loongson32/nand.h      |   1 +
 arch/mips/include/asm/mach-loongson32/platform.h  |  10 +
 arch/mips/include/asm/mach-loongson32/regs-mux.h  |   2 +-
 arch/mips/loongson32/common/irq.c                 |   2 +-
 arch/mips/loongson32/common/platform.c            | 243 +++++++++++++++++++++-
 8 files changed, 390 insertions(+), 42 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson32/dma.h b/arch/mips/include/asm/mach-loongson32/dma.h
index ad1dec7..170c16a 100644
--- a/arch/mips/include/asm/mach-loongson32/dma.h
+++ b/arch/mips/include/asm/mach-loongson32/dma.h
@@ -20,6 +20,7 @@ struct plat_ls1x_dma {
 	int nr_channels;
 };
 
+extern struct plat_ls1x_dma ls1a_dma_pdata;
 extern struct plat_ls1x_dma ls1b_dma_pdata;
 
 #endif /* __ASM_MACH_LOONGSON32_DMA_H */
diff --git a/arch/mips/include/asm/mach-loongson32/irq.h b/arch/mips/include/asm/mach-loongson32/irq.h
index c1c7441..e17232c 100644
--- a/arch/mips/include/asm/mach-loongson32/irq.h
+++ b/arch/mips/include/asm/mach-loongson32/irq.h
@@ -64,6 +64,7 @@
 #define LS1X_OHCI_IRQ			LS1X_IRQ(1, 1)
 #define LS1X_GMAC0_IRQ			LS1X_IRQ(1, 2)
 #define LS1X_GMAC1_IRQ			LS1X_IRQ(1, 3)
+#define LS1X_AHCI_IRQ			LS1X_IRQ(1, 4)
 
 #define LS1X_IRQS		(LS1X_IRQ(4, 31) + 1 - LS1X_IRQ_BASE)
 
diff --git a/arch/mips/include/asm/mach-loongson32/loongson1.h b/arch/mips/include/asm/mach-loongson32/loongson1.h
index 978f6df..8ba34f9 100644
--- a/arch/mips/include/asm/mach-loongson32/loongson1.h
+++ b/arch/mips/include/asm/mach-loongson32/loongson1.h
@@ -14,35 +14,149 @@
 
 #define DEFAULT_MEMSIZE			256	/* If no memsize provided */
 
-/* Loongson 1 Register Bases */
-#define LS1X_MUX_BASE			0x1fd00420
-#define LS1X_INTC_BASE			0x1fd01040
-#define LS1X_GPIO0_BASE			0x1fd010c0
-#define LS1X_GPIO1_BASE			0x1fd010c4
-#define LS1X_DMAC_BASE			0x1fd01160
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
+#define LS1X_GPIO_MUX_BASE		(LS1X_CFG_REG_BASE + 0x0420)
+
+/*INT regs */
+#define LS1X_INT_REG_BASE		(LS1X_CFG_REG_BASE + 0x1040)
+
+/* GPIO regs */
+#define LS1X_GPIO_REG_BASE		(LS1X_CFG_REG_BASE + 0x10c0)
+#define LS1X_GPIO_CFG0_REG		(LS1X_CFG_REG_BASE + 0x10c0)
+#define LS1X_GPIO_CFG1_REG		(LS1X_CFG_REG_BASE + 0x10c4)
+#define LS1X_GPIO_CFG2_REG		(LS1X_CFG_REG_BASE + 0x10c8)
+#define LS1X_GPIO_OE0_REG		(LS1X_CFG_REG_BASE + 0x10d0)
+#define LS1X_GPIO_OE1_REG		(LS1X_CFG_REG_BASE + 0x10d4)
+#define LS1X_GPIO_OE2_REG		(LS1X_CFG_REG_BASE + 0x10d8)
+#define LS1X_GPIO_IN0_REG		(LS1X_CFG_REG_BASE + 0x10e0)
+#define LS1X_GPIO_IN1_REG		(LS1X_CFG_REG_BASE + 0x10e4)
+#define LS1X_GPIO_IN2_REG		(LS1X_CFG_REG_BASE + 0x10e8)
+#define LS1X_GPIO_OUT0_REG		(LS1X_CFG_REG_BASE + 0x10f0)
+#define LS1X_GPIO_OUT1_REG		(LS1X_CFG_REG_BASE + 0x10f4)
+#define LS1X_GPIO_OUT2_REG		(LS1X_CFG_REG_BASE + 0x10f8)
+
+#define LS1X_DMA_ORDER_REG		(LS1X_CFG_REG_BASE + 0x1160)
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
+/* I2C regs */
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
diff --git a/arch/mips/include/asm/mach-loongson32/nand.h b/arch/mips/include/asm/mach-loongson32/nand.h
index e274912..d141e0a 100644
--- a/arch/mips/include/asm/mach-loongson32/nand.h
+++ b/arch/mips/include/asm/mach-loongson32/nand.h
@@ -23,6 +23,7 @@ struct plat_ls1x_nand {
 	int wait_cycle;
 };
 
+extern struct plat_ls1x_nand ls1a_nand_pdata;
 extern struct plat_ls1x_nand ls1b_nand_pdata;
 
 bool ls1x_dma_filter_fn(struct dma_chan *chan, void *param);
diff --git a/arch/mips/include/asm/mach-loongson32/platform.h b/arch/mips/include/asm/mach-loongson32/platform.h
index 672531a..c48f17b 100644
--- a/arch/mips/include/asm/mach-loongson32/platform.h
+++ b/arch/mips/include/asm/mach-loongson32/platform.h
@@ -25,6 +25,16 @@ extern struct platform_device ls1x_gpio0_pdev;
 extern struct platform_device ls1x_gpio1_pdev;
 extern struct platform_device ls1x_nand_pdev;
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
 
 void __init ls1x_clk_init(void);
 void __init ls1x_dma_set_platdata(struct plat_ls1x_dma *pdata);
diff --git a/arch/mips/include/asm/mach-loongson32/regs-mux.h b/arch/mips/include/asm/mach-loongson32/regs-mux.h
index 7c394f9..d52ea03 100644
--- a/arch/mips/include/asm/mach-loongson32/regs-mux.h
+++ b/arch/mips/include/asm/mach-loongson32/regs-mux.h
@@ -13,7 +13,7 @@
 #define __ASM_MACH_LOONGSON32_REGS_MUX_H
 
 #define LS1X_MUX_REG(x) \
-		((void __iomem *)KSEG1ADDR(LS1X_MUX_BASE + (x)))
+		((void __iomem *)KSEG1ADDR(LS1X_GPIO_MUX_BASE + (x)))
 
 #define LS1X_MUX_CTRL0			LS1X_MUX_REG(0x0)
 #define LS1X_MUX_CTRL1			LS1X_MUX_REG(0x4)
diff --git a/arch/mips/loongson32/common/irq.c b/arch/mips/loongson32/common/irq.c
index 455a770..f2520f2 100644
--- a/arch/mips/loongson32/common/irq.c
+++ b/arch/mips/loongson32/common/irq.c
@@ -15,7 +15,7 @@
 #include <irq.h>
 
 #define LS1X_INTC_REG(n, x) \
-		((void __iomem *)KSEG1ADDR(LS1X_INTC_BASE + (n * 0x18) + (x)))
+		((void __iomem *)KSEG1ADDR(LS1X_INT_REG_BASE + (n * 0x18) + (x)))
 
 #define LS1X_INTC_INTISR(n)		LS1X_INTC_REG(n, 0x0)
 #define LS1X_INTC_INTIEN(n)		LS1X_INTC_REG(n, 0x4)
diff --git a/arch/mips/loongson32/common/platform.c b/arch/mips/loongson32/common/platform.c
index f2c714d..24f35b6 100644
--- a/arch/mips/loongson32/common/platform.c
+++ b/arch/mips/loongson32/common/platform.c
@@ -7,7 +7,10 @@
  * option) any later version.
  */
 
+#include <linux/init.h>
 #include <linux/clk.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/mtd/partitions.h>
@@ -15,7 +18,15 @@
 #include <linux/phy.h>
 #include <linux/serial_8250.h>
 #include <linux/stmmac.h>
+#include <linux/resource.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/flash.h>
+#include <linux/i2c.h>
+#include <linux/gpio_keys.h>
+#include <linux/input.h>
 #include <linux/usb/ehci_pdriver.h>
+#include <linux/usb/ohci_pdriver.h>
+#include <linux/platform_device.h>
 
 #include <loongson1.h>
 #include <cpufreq.h>
@@ -26,6 +37,7 @@
 #define LS1X_UART(_id)						\
 	{							\
 		.mapbase	= LS1X_UART ## _id ## _BASE,	\
+		.membase	= (u8 *)KSEG1ADDR(LS1X_UART ## _id ## _BASE), \
 		.irq		= LS1X_UART ## _id ## _IRQ,	\
 		.iotype		= UPIO_MEM,			\
 		.flags		= UPF_IOREMAP | UPF_FIXED_TYPE, \
@@ -83,8 +95,8 @@ struct platform_device ls1x_cpufreq_pdev = {
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
@@ -240,8 +252,8 @@ struct platform_device ls1x_eth1_pdev = {
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
@@ -255,8 +267,8 @@ struct platform_device ls1x_gpio0_pdev = {
 
 static struct resource ls1x_gpio1_resources[] = {
 	[0] = {
-		.start	= LS1X_GPIO1_BASE,
-		.end	= LS1X_GPIO1_BASE + SZ_4 - 1,
+		.start	= LS1X_GPIO_CFG1_REG,
+		.end	= LS1X_GPIO_CFG1_REG + SZ_4 - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 };
@@ -268,11 +280,12 @@ struct platform_device ls1x_gpio1_pdev = {
 	.resource	= ls1x_gpio1_resources,
 };
 
+
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
@@ -295,9 +308,9 @@ void __init ls1x_nand_set_platdata(struct plat_ls1x_nand *pdata)
 	ls1x_nand_pdev.dev.platform_data = pdata;
 }
 
-/* USB EHCI */
-static u64 ls1x_ehci_dmamask = DMA_BIT_MASK(32);
+static u64 platform_dma_mask = DMA_BIT_MASK(32);
 
+/* USB EHCI */
 static struct resource ls1x_ehci_resources[] = {
 	[0] = {
 		.start	= LS1X_EHCI_BASE,
@@ -319,13 +332,221 @@ struct platform_device ls1x_ehci_pdev = {
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
+/* Real Time Clock */
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
 /* Real Time Clock */
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
