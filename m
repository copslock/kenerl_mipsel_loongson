Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 May 2016 11:15:04 +0200 (CEST)
Received: from smtpbg62.qq.com ([103.7.29.139]:54547 "EHLO smtpbg64.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27029236AbcELJPBMYF0T (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 May 2016 11:15:01 +0200
X-QQ-mid: esmtp11t1463044484t498t30049
Received: from localhost (unknown [180.109.228.28])
        by esmtp4.qq.com (ESMTP) with 
        id ; Thu, 12 May 2016 17:14:43 +0800 (CST)
X-QQ-SSF: 01000000000000F0F9200000002000P
X-QQ-FEAT: q9Y45HqrGrm4F2vOaCCSfadMYi00GTuuO5ojIJYqamIXBD9e6wvmPGUtw8fva
        nKapz2HbX9Hb9RAjCfHPAw1pSP2NnsONyTHCYJi0X80Euyjp9QYlP7vIWbpqzveKIoKjE8l
        ryZ2SAETkj6MH1JkSv5UDZQUISs3s3lx0G1R0pcFMtBCtLTy8Tl55KITKIyH87fKB5WO6EB
        e8OZ+J9F4rRrKhuVT7VJwOMr3uPvDzT/PcwToeTg1fuF5BJQA3qTu
X-QQ-GoodBg: 0
X-QQ-CSender: 842587420@qq.com
From:   Yang Ling <gnaygnil@gmail.com>
To:     ralf@linux-mips.org
Cc:     chenhc@lemote.com, gnaygnil@gmail.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] MIPS: Loongson 1C: Add board support
Date:   Thu, 12 May 2016 17:14:41 +0800
Message-Id: <1463044481-21960-1-git-send-email-gnaygnil@gmail.com>
X-Mailer: git-send-email 1.9.1
X-QQ-SENDSIZE: 520
Return-Path: <842587420@qq.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53394
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gnaygnil@gmail.com
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

Adds basic platform devices for Loongson 1C, including serial port,
and ethernet.

Signed-off-by: Yang Ling <gnaygnil@gmail.com>
---
 arch/mips/Kconfig                                 | 11 ++++
 arch/mips/include/asm/mach-loongson32/irq.h       | 43 ++++++++++++++-
 arch/mips/include/asm/mach-loongson32/loongson1.h | 22 ++++++++
 arch/mips/include/asm/mach-loongson32/regs-gpio.h | 26 +++++++++
 arch/mips/include/asm/mach-loongson32/regs-mux.h  | 65 +++++++++++++++++++++++
 arch/mips/loongson32/Kconfig                      | 15 ++++++
 arch/mips/loongson32/Makefile                     |  6 +++
 arch/mips/loongson32/Platform                     |  1 +
 arch/mips/loongson32/common/irq.c                 | 57 ++++++++++++++++++--
 arch/mips/loongson32/common/platform.c            | 24 ++++++++-
 arch/mips/loongson32/common/setup.c               |  6 +++
 arch/mips/loongson32/ls1c/Makefile                |  5 ++
 arch/mips/loongson32/ls1c/board.c                 | 30 +++++++++++
 13 files changed, 306 insertions(+), 5 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-loongson32/regs-gpio.h
 create mode 100644 arch/mips/loongson32/ls1c/Makefile
 create mode 100644 arch/mips/loongson32/ls1c/board.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 51a03c3..443c826 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1382,6 +1382,14 @@ config CPU_LOONGSON1B
 	  The Loongson 1B is a 32-bit SoC, which implements the MIPS32
 	  release 2 instruction set.
 
+config CPU_LOONGSON1C
+	bool "Loongson 1C"
+	depends on SYS_HAS_CPU_LOONGSON1C
+	select CPU_LOONGSON1
+	help
+	  The Loongson 1C is a 32-bit SoC, which implements the MIPS32
+	  release 2 instruction set.
+
 config CPU_MIPS32_R1
 	bool "MIPS32 Release 1"
 	depends on SYS_HAS_CPU_MIPS32_R1
@@ -1825,6 +1833,9 @@ config SYS_HAS_CPU_LOONGSON2F
 config SYS_HAS_CPU_LOONGSON1B
 	bool
 
+config SYS_HAS_CPU_LOONGSON1C
+	bool
+
 config SYS_HAS_CPU_MIPS32_R1
 	bool
 
diff --git a/arch/mips/include/asm/mach-loongson32/irq.h b/arch/mips/include/asm/mach-loongson32/irq.h
index 0d35b99..39b9f86 100644
--- a/arch/mips/include/asm/mach-loongson32/irq.h
+++ b/arch/mips/include/asm/mach-loongson32/irq.h
@@ -1,5 +1,7 @@
 /*
  * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
+ * Copyright (c) 2015 Tang Haifeng <tanghaifeng-gz@loongson.cn>
+ * Copyright (c) 2016 Ling Yang <gnaygnil@gmail.com>
  *
  * IRQ mappings for Loongson 1
  *
@@ -37,9 +39,14 @@
 #define LS1X_IRQ(n, x)			(LS1X_IRQ_BASE + (n << 5) + (x))
 
 #define LS1X_UART0_IRQ			LS1X_IRQ(0, 2)
+#if defined(CONFIG_LOONGSON1_LS1B)
 #define LS1X_UART1_IRQ			LS1X_IRQ(0, 3)
 #define LS1X_UART2_IRQ			LS1X_IRQ(0, 4)
 #define LS1X_UART3_IRQ			LS1X_IRQ(0, 5)
+#elif defined(CONFIG_LOONGSON1_LS1C)
+#define LS1X_UART1_IRQ			LS1X_IRQ(0, 4)
+#define LS1X_UART2_IRQ			LS1X_IRQ(0, 5)
+#endif
 #define LS1X_CAN0_IRQ			LS1X_IRQ(0, 6)
 #define LS1X_CAN1_IRQ			LS1X_IRQ(0, 7)
 #define LS1X_SPI0_IRQ			LS1X_IRQ(0, 8)
@@ -48,6 +55,9 @@
 #define LS1X_DMA0_IRQ			LS1X_IRQ(0, 13)
 #define LS1X_DMA1_IRQ			LS1X_IRQ(0, 14)
 #define LS1X_DMA2_IRQ			LS1X_IRQ(0, 15)
+#if defined(CONFIG_LOONGSON1_LS1C)
+#define LS1X_NAND_IRQ			LS1X_IRQ(0, 16)
+#endif
 #define LS1X_PWM0_IRQ			LS1X_IRQ(0, 17)
 #define LS1X_PWM1_IRQ			LS1X_IRQ(0, 18)
 #define LS1X_PWM2_IRQ			LS1X_IRQ(0, 19)
@@ -55,18 +65,49 @@
 #define LS1X_RTC_INT0_IRQ		LS1X_IRQ(0, 21)
 #define LS1X_RTC_INT1_IRQ		LS1X_IRQ(0, 22)
 #define LS1X_RTC_INT2_IRQ		LS1X_IRQ(0, 23)
+#if defined(CONFIG_LOONGSON1_LS1B)
 #define LS1X_TOY_INT0_IRQ		LS1X_IRQ(0, 24)
 #define LS1X_TOY_INT1_IRQ		LS1X_IRQ(0, 25)
 #define LS1X_TOY_INT2_IRQ		LS1X_IRQ(0, 26)
 #define LS1X_RTC_TICK_IRQ		LS1X_IRQ(0, 27)
 #define LS1X_TOY_TICK_IRQ		LS1X_IRQ(0, 28)
+#define LS1X_UART4_IRQ			LS1X_IRQ(0, 29)
+#define LS1X_UART5_IRQ			LS1X_IRQ(0, 30)
+#elif defined(CONFIG_LOONGSON1_LS1C)
+#define LS1X_UART3_IRQ			LS1X_IRQ(0, 29)
+#define LS1X_ADC_IRQ			LS1X_IRQ(0, 30)
+#define LS1X_SDIO_IRQ			LS1X_IRQ(0, 31)
+#endif
 
 #define LS1X_EHCI_IRQ			LS1X_IRQ(1, 0)
 #define LS1X_OHCI_IRQ			LS1X_IRQ(1, 1)
+#if defined(CONFIG_LOONGSON1_LS1B)
 #define LS1X_GMAC0_IRQ			LS1X_IRQ(1, 2)
 #define LS1X_GMAC1_IRQ			LS1X_IRQ(1, 3)
+#elif defined(CONFIG_LOONGSON1_LS1C)
+#define LS1X_OTG_IRQ			LS1X_IRQ(1, 2)
+#define LS1X_GMAC0_IRQ			LS1X_IRQ(1, 3)
+#define LS1X_CAM_IRQ			LS1X_IRQ(1, 4)
+#define LS1X_UART4_IRQ			LS1X_IRQ(1, 5)
+#define LS1X_UART5_IRQ			LS1X_IRQ(1, 6)
+#define LS1X_UART6_IRQ			LS1X_IRQ(1, 7)
+#define LS1X_UART7_IRQ			LS1X_IRQ(1, 8)
+#define LS1X_UART8_IRQ			LS1X_IRQ(1, 9)
+#define LS1X_UART9_IRQ			LS1X_IRQ(1, 13)
+#define LS1X_UART10_IRQ			LS1X_IRQ(1, 14)
+#define LS1X_UART11_IRQ			LS1X_IRQ(1, 15)
+#define LS1X_I2C0_IRQ			LS1X_IRQ(1, 17)
+#define LS1X_I2C1_IRQ			LS1X_IRQ(1, 18)
+#define LS1X_I2C2_IRQ			LS1X_IRQ(1, 19)
+#endif
 
-#define LS1X_IRQS		(LS1X_IRQ(4, 31) + 1 - LS1X_IRQ_BASE)
+#if defined(CONFIG_LOONGSON1_LS1B)
+#define INTN	4
+#elif defined(CONFIG_LOONGSON1_LS1C)
+#define INTN	5
+#endif
+
+#define LS1X_IRQS		(LS1X_IRQ(INTN, 31) + 1 - LS1X_IRQ_BASE)
 
 #define NR_IRQS			(MIPS_CPU_IRQS + LS1X_IRQS)
 
diff --git a/arch/mips/include/asm/mach-loongson32/loongson1.h b/arch/mips/include/asm/mach-loongson32/loongson1.h
index 12aa129..4a2f4cd 100644
--- a/arch/mips/include/asm/mach-loongson32/loongson1.h
+++ b/arch/mips/include/asm/mach-loongson32/loongson1.h
@@ -1,5 +1,7 @@
 /*
  * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
+ * Copyright (c) 2015 Tang Haifeng <tanghaifeng-gz@loongson.cn>
+ * Copyright (c) 2016 Ling Yang <gnaygnil@gmail.com>
  *
  * Register mappings for Loongson 1
  *
@@ -13,15 +15,29 @@
 #ifndef __ASM_MACH_LOONGSON32_LOONGSON1_H
 #define __ASM_MACH_LOONGSON32_LOONGSON1_H
 
+#if defined(CONFIG_LOONGSON1_LS1B)
 #define DEFAULT_MEMSIZE			256	/* If no memsize provided */
+#elif defined(CONFIG_LOONGSON1_LS1C)
+#define DEFAULT_MEMSIZE			32	/* If no memsize provided */
+#endif
 
 /* Loongson 1 Register Bases */
 #define LS1X_MUX_BASE			0x1fd00420
 #define LS1X_INTC_BASE			0x1fd01040
+#define LS1X_GPIO_BASE			0x1fd010c0
+#define LS1X_CBUS_BASE			0x1fd011c0
+#if defined(CONFIG_LOONGSON1_LS1B)
 #define LS1X_EHCI_BASE			0x1fe00000
 #define LS1X_OHCI_BASE			0x1fe08000
+#elif defined(CONFIG_LOONGSON1_LS1C)
+#define LS1X_OTG_BASE			0x1fe00000
+#define LS1X_EHCI_BASE			0x1fe20000
+#define LS1X_OHCI_BASE			0x1fe28000
+#endif
 #define LS1X_GMAC0_BASE			0x1fe10000
+#if defined(CONFIG_LOONGSON1_LS1B)
 #define LS1X_GMAC1_BASE			0x1fe20000
+#endif
 
 #define LS1X_UART0_BASE			0x1fe40000
 #define LS1X_UART1_BASE			0x1fe44000
@@ -38,7 +54,12 @@
 #define LS1X_PWM3_BASE			0x1fe5c030
 #define LS1X_WDT_BASE			0x1fe5c060
 #define LS1X_RTC_BASE			0x1fe64000
+#if defined(CONFIG_LOONGSON1_LS1B)
 #define LS1X_AC97_BASE			0x1fe74000
+#elif defined(CONFIG_LOONGSON1_LS1C)
+#define LS1X_AC97_BASE			0x1fe60000
+#define LS1X_I2S_BASE			0x1fe60000
+#endif
 #define LS1X_NAND_BASE			0x1fe78000
 #define LS1X_CLK_BASE			0x1fe78030
 
@@ -46,5 +67,6 @@
 #include <regs-mux.h>
 #include <regs-pwm.h>
 #include <regs-wdt.h>
+#include <regs-gpio.h>
 
 #endif /* __ASM_MACH_LOONGSON32_LOONGSON1_H */
diff --git a/arch/mips/include/asm/mach-loongson32/regs-gpio.h b/arch/mips/include/asm/mach-loongson32/regs-gpio.h
new file mode 100644
index 0000000..87b66bb
--- /dev/null
+++ b/arch/mips/include/asm/mach-loongson32/regs-gpio.h
@@ -0,0 +1,26 @@
+/*
+ * Copyright (c) 2015 Tang Haifeng <tanghaifeng-gz@loongson.cn>
+ * Copyright (c) 2016 Ling Yang <gnaygnil@gmail.com>
+ *
+ * Loongson 1 GPIO Register Definitions.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __ASM_MACH_LOONGSON32_REGS_GPIO_H
+#define __ASM_MACH_LOONGSON32_REGS_GPIO_H
+
+#include <loongson1.h>
+
+#define LS1X_GPIO_REG(n, x) \
+		((void __iomem *)KSEG1ADDR(LS1X_GPIO_BASE + (n * 0x04) + (x)))
+
+#define LS1X_GPIO_CFG(n)	LS1X_GPIO_REG(n, 0x00)
+#define LS1X_GPIO_OE(n)		LS1X_GPIO_REG(n, 0x10)
+#define LS1X_GPIO_IN(n)		LS1X_GPIO_REG(n, 0x20)
+#define LS1X_GPIO_OUT(n)	LS1X_GPIO_REG(n, 0x30)
+
+#endif /* __ASM_MACH_LOONGSON32_REGS_GPIO_H */
diff --git a/arch/mips/include/asm/mach-loongson32/regs-mux.h b/arch/mips/include/asm/mach-loongson32/regs-mux.h
index 8302d92..4432685 100644
--- a/arch/mips/include/asm/mach-loongson32/regs-mux.h
+++ b/arch/mips/include/asm/mach-loongson32/regs-mux.h
@@ -1,5 +1,7 @@
 /*
  * Copyright (c) 2014 Zhang, Keguang <keguang.zhang@gmail.com>
+ * Copyright (c) 2015 Tang Haifeng <tanghaifeng-gz@loongson.cn>
+ * Copyright (c) 2016 Ling Yang <gnaygnil@gmail.com>
  *
  * Loongson 1 MUX Register Definitions.
  *
@@ -12,12 +14,15 @@
 #ifndef __ASM_MACH_LOONGSON32_REGS_MUX_H
 #define __ASM_MACH_LOONGSON32_REGS_MUX_H
 
+#include <loongson1.h>
+
 #define LS1X_MUX_REG(x) \
 		((void __iomem *)KSEG1ADDR(LS1X_MUX_BASE + (x)))
 
 #define LS1X_MUX_CTRL0			LS1X_MUX_REG(0x0)
 #define LS1X_MUX_CTRL1			LS1X_MUX_REG(0x4)
 
+#if	defined(CONFIG_LOONGSON1_LS1B)
 /* MUX CTRL0 Register Bits */
 #define UART0_USE_PWM23			(0x1 << 28)
 #define UART0_USE_PWM01			(0x1 << 27)
@@ -64,4 +69,64 @@
 #define GMAC1_USE_PWM23			(0x1 << 1)
 #define GMAC0_USE_PWM01			0x1
 
+#elif	defined(CONFIG_LOONGSON1_LS1C)
+
+/* MUX_CTRL0 Register Bits */
+#define UART_SPLIT			(0x3 << 30)
+#define OUTPUT_CLK			(0xf << 26)
+#define ADC_SHUT			(0x1 << 25)
+#define SDIO_SHUT			(0x1 << 24)
+#define DMA2_SHUT			(0x1 << 23)
+#define DMA1_SHUT			(0x1 << 22)
+#define DMA0_SHUT			(0x1 << 21)
+#define SPI1_SHUT			(0x1 << 20)
+#define SPI0_SHUT			(0x1 << 19)
+#define I2C2_SHUT			(0x1 << 18)
+#define I2C1_SHUT			(0x1 << 17)
+#define I2C0_SHUT			(0x1 << 16)
+#define AC97_SHUT			(0x1 << 15)
+#define I2S_SHUT			(0x1 << 14)
+#define UART3_SHUT			(0x1 << 13)
+#define UART2_SHUT			(0x1 << 12)
+#define UART1_SHUT			(0x1 << 11)
+#define UART0_SHUT			(0x1 << 10)
+#define CAN1_SHUT			(0x1 << 9)
+#define CAN0_SHUT			(0x1 << 8)
+#define ECC_SHUT			(0x1 << 7)
+#define GMAC_SHUT			(0x1 << 6)
+#define USBHOST_SHUT			(0x1 << 5)
+#define USBOTG_SHUT			(0x1 << 4)
+#define SDRAM_SHUT			(0x1 << 3)
+#define SRAM_SHUT			(0x1 << 2)
+#define CAM_SHUT			(0x1 << 1)
+#define LCD_SHUT			(0x1 << 0)
+
+#define UART_SPLIT_SHIFT                        30
+#define OUTPUT_CLK_SHIFT                        26
+
+/* MUX_CTRL1 Register Bits */
+#define USBHOST_RSTN			(0x1 << 31)
+#define PHY_INTF_SELI			(0x7 << 28)
+#define AC97_EN				(0x1 << 25)
+#define SDIO_DMA_EN			(0x3 << 23)
+#define ADC_DMA_EN			(0x1 << 22)
+#define SDIO_USE_SPI1			(0x1 << 17)
+#define SDIO_USE_SPI0			(0x1 << 16)
+#define SRAM_CTRL			(0xffff << 0)
+
+#define PHY_INTF_SELI_SHIFT                     28
+#define SDIO_DMA_EN_SHIFT                       23
+#define SRAM_CTRL_SHIFT				0
+
+#define LS1X_CBUS_REG(n, x) \
+		((void __iomem *)KSEG1ADDR(LS1X_CBUS_BASE + (n * 0x04) + (x)))
+
+#define LS1X_CBUS_FIRST(n)		LS1X_CBUS_REG(n, 0x00)
+#define LS1X_CBUS_SECOND(n)		LS1X_CBUS_REG(n, 0x10)
+#define LS1X_CBUS_THIRD(n)		LS1X_CBUS_REG(n, 0x20)
+#define LS1X_CBUS_FOURTHT(n)		LS1X_CBUS_REG(n, 0x30)
+#define LS1X_CBUS_FIFTHT(n)		LS1X_CBUS_REG(n, 0x40)
+
+#endif
+
 #endif /* __ASM_MACH_LOONGSON32_REGS_MUX_H */
diff --git a/arch/mips/loongson32/Kconfig b/arch/mips/loongson32/Kconfig
index 7704f20..3c0c2f2 100644
--- a/arch/mips/loongson32/Kconfig
+++ b/arch/mips/loongson32/Kconfig
@@ -19,6 +19,21 @@ config LOONGSON1_LS1B
 	select USE_GENERIC_EARLY_PRINTK_8250
 	select COMMON_CLK
 
+config LOONGSON1_LS1C
+	bool "Loongson LS1C board"
+	select CEVT_R4K if !MIPS_EXTERNAL_TIMER
+	select CSRC_R4K if !MIPS_EXTERNAL_TIMER
+	select SYS_HAS_CPU_LOONGSON1C
+	select DMA_NONCOHERENT
+	select BOOT_ELF32
+	select IRQ_MIPS_CPU
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SYS_SUPPORTS_HIGHMEM
+	select SYS_SUPPORTS_MIPS16
+	select SYS_HAS_EARLY_PRINTK
+	select USE_GENERIC_EARLY_PRINTK_8250
+	select COMMON_CLK
 endchoice
 
 menuconfig CEVT_CSRC_LS1X
diff --git a/arch/mips/loongson32/Makefile b/arch/mips/loongson32/Makefile
index 5f4bd6e..1ab2c5b 100644
--- a/arch/mips/loongson32/Makefile
+++ b/arch/mips/loongson32/Makefile
@@ -9,3 +9,9 @@ obj-$(CONFIG_MACH_LOONGSON32) += common/
 #
 
 obj-$(CONFIG_LOONGSON1_LS1B)  += ls1b/
+
+#
+# Loongson LS1C board
+#
+
+obj-$(CONFIG_LOONGSON1_LS1C)  += ls1c/
diff --git a/arch/mips/loongson32/Platform b/arch/mips/loongson32/Platform
index ebb6dc2..ffe01c6 100644
--- a/arch/mips/loongson32/Platform
+++ b/arch/mips/loongson32/Platform
@@ -5,3 +5,4 @@ cflags-$(CONFIG_CPU_LOONGSON1)	+= \
 platform-$(CONFIG_MACH_LOONGSON32)	+= loongson32/
 cflags-$(CONFIG_MACH_LOONGSON32)	+= -I$(srctree)/arch/mips/include/asm/mach-loongson32
 load-$(CONFIG_LOONGSON1_LS1B)		+= 0xffffffff80100000
+load-$(CONFIG_LOONGSON1_LS1C)		+= 0xffffffff80100000
diff --git a/arch/mips/loongson32/common/irq.c b/arch/mips/loongson32/common/irq.c
index 455a770..6685d7e 100644
--- a/arch/mips/loongson32/common/irq.c
+++ b/arch/mips/loongson32/common/irq.c
@@ -1,5 +1,7 @@
 /*
  * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
+ * Copyright (c) 2015 Tang Haifeng <tanghaifeng-gz@loongson.cn>
+ * Copyright (c) 2016 Ling Yang <gnaygnil@gmail.com>
  *
  * This program is free software; you can redistribute	it and/or modify it
  * under  the terms of	the GNU General	 Public License as published by the
@@ -62,12 +64,58 @@ static void ls1x_irq_unmask(struct irq_data *d)
 			| (1 << bit), LS1X_INTC_INTIEN(n));
 }
 
+static int ls1x_irq_settype(struct irq_data *d, unsigned int type)
+{
+	unsigned int bit = (d->irq - LS1X_IRQ_BASE) & 0x1f;
+	unsigned int n = (d->irq - LS1X_IRQ_BASE) >> 5;
+
+	switch (type) {
+	case IRQ_TYPE_LEVEL_HIGH:
+		__raw_writel(__raw_readl(LS1X_INTC_INTPOL(n))
+			| (1 << bit), LS1X_INTC_INTPOL(n));
+		__raw_writel(__raw_readl(LS1X_INTC_INTEDGE(n))
+			& ~(1 << bit), LS1X_INTC_INTEDGE(n));
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		__raw_writel(__raw_readl(LS1X_INTC_INTPOL(n))
+			& ~(1 << bit), LS1X_INTC_INTPOL(n));
+		__raw_writel(__raw_readl(LS1X_INTC_INTEDGE(n))
+			& ~(1 << bit), LS1X_INTC_INTEDGE(n));
+		break;
+	case IRQ_TYPE_EDGE_RISING:
+		__raw_writel(__raw_readl(LS1X_INTC_INTPOL(n))
+			| (1 << bit), LS1X_INTC_INTPOL(n));
+		__raw_writel(__raw_readl(LS1X_INTC_INTEDGE(n))
+			| (1 << bit), LS1X_INTC_INTEDGE(n));
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		__raw_writel(__raw_readl(LS1X_INTC_INTPOL(n))
+			& ~(1 << bit), LS1X_INTC_INTPOL(n));
+		__raw_writel(__raw_readl(LS1X_INTC_INTEDGE(n))
+			| (1 << bit), LS1X_INTC_INTEDGE(n));
+		break;
+	case IRQ_TYPE_EDGE_BOTH:
+		__raw_writel(__raw_readl(LS1X_INTC_INTPOL(n))
+			& ~(1 << bit), LS1X_INTC_INTPOL(n));
+		__raw_writel(__raw_readl(LS1X_INTC_INTEDGE(n))
+			| (1 << bit), LS1X_INTC_INTEDGE(n));
+		break;
+	case IRQ_TYPE_NONE:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static struct irq_chip ls1x_irq_chip = {
 	.name		= "LS1X-INTC",
 	.irq_ack	= ls1x_irq_ack,
 	.irq_mask	= ls1x_irq_mask,
 	.irq_mask_ack	= ls1x_irq_mask_ack,
 	.irq_unmask	= ls1x_irq_unmask,
+	.irq_set_type   = ls1x_irq_settype,
 };
 
 static void ls1x_irq_dispatch(int n)
@@ -107,7 +155,7 @@ asmlinkage void plat_irq_dispatch(void)
 
 }
 
-struct irqaction cascade_irqaction = {
+static struct irqaction cascade_irqaction = {
 	.handler = no_action,
 	.name = "cascade",
 	.flags = IRQF_NO_THREAD,
@@ -120,7 +168,7 @@ static void __init ls1x_irq_init(int base)
 	/* Disable interrupts and clear pending,
 	 * setup all IRQs as high level triggered
 	 */
-	for (n = 0; n < 4; n++) {
+	for (n = 0; n < INTN; n++) {
 		__raw_writel(0x0, LS1X_INTC_INTIEN(n));
 		__raw_writel(0xffffffff, LS1X_INTC_INTCLR(n));
 		__raw_writel(0xffffffff, LS1X_INTC_INTPOL(n));
@@ -129,7 +177,7 @@ static void __init ls1x_irq_init(int base)
 	}
 
 
-	for (n = base; n < LS1X_IRQS; n++) {
+	for (n = base; n < NR_IRQS; n++) {
 		irq_set_chip_and_handler(n, &ls1x_irq_chip,
 					 handle_level_irq);
 	}
@@ -138,6 +186,9 @@ static void __init ls1x_irq_init(int base)
 	setup_irq(INT1_IRQ, &cascade_irqaction);
 	setup_irq(INT2_IRQ, &cascade_irqaction);
 	setup_irq(INT3_IRQ, &cascade_irqaction);
+#if defined(CONFIG_LOONGSON1_LS1C)
+	setup_irq(INT4_IRQ, &cascade_irqaction);
+#endif
 }
 
 void __init arch_init_irq(void)
diff --git a/arch/mips/loongson32/common/platform.c b/arch/mips/loongson32/common/platform.c
index ddf1d4c..f3a6881 100644
--- a/arch/mips/loongson32/common/platform.c
+++ b/arch/mips/loongson32/common/platform.c
@@ -1,5 +1,7 @@
 /*
  * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
+ * Copyright (c) 2015 Tang Haifeng <tanghaifeng-gz@loongson.cn>
+ * Copyright (c) 2016 Ling Yang <gnaygnil@gmail.com>
  *
  * This program is free software; you can redistribute	it and/or modify it
  * under  the terms of	the GNU General	 Public License as published by the
@@ -18,6 +20,7 @@
 
 #include <cpufreq.h>
 #include <loongson1.h>
+#include <platform.h>
 
 /* 8250/16550 compatible UART */
 #define LS1X_UART(_id)						\
@@ -86,13 +89,14 @@ static struct stmmac_dma_cfg ls1x_eth_dma_cfg = {
 	.pbl		= 1,
 };
 
-int ls1x_eth_mux_init(struct platform_device *pdev, void *priv)
+static int ls1x_eth_mux_init(struct platform_device *pdev, void *priv)
 {
 	struct plat_stmmacenet_data *plat_dat = NULL;
 	u32 val;
 
 	val = __raw_readl(LS1X_MUX_CTRL1);
 
+#if defined(CONFIG_LOONGSON1_LS1B)
 	plat_dat = dev_get_platdata(&pdev->dev);
 	if (plat_dat->bus_id) {
 		__raw_writel(__raw_readl(LS1X_MUX_CTRL0) | GMAC1_USE_UART1 |
@@ -127,13 +131,29 @@ int ls1x_eth_mux_init(struct platform_device *pdev, void *priv)
 	}
 	__raw_writel(val, LS1X_MUX_CTRL1);
 
+#elif defined(CONFIG_LOONGSON1_LS1C)
+	plat_dat = dev_get_platdata(&pdev->dev);
+
+	val &= ~PHY_INTF_SELI;
+	if (plat_dat->interface == PHY_INTERFACE_MODE_RMII)
+		val |= 0x4 << PHY_INTF_SELI_SHIFT;
+	__raw_writel(val, LS1X_MUX_CTRL1);
+
+	val = __raw_readl(LS1X_MUX_CTRL0);
+	__raw_writel(val & (~GMAC_SHUT), LS1X_MUX_CTRL0);
+#endif
+
 	return 0;
 }
 
 static struct plat_stmmacenet_data ls1x_eth0_pdata = {
 	.bus_id		= 0,
 	.phy_addr	= -1,
+#if defined(CONFIG_LOONGSON1_LS1B)
 	.interface	= PHY_INTERFACE_MODE_MII,
+#elif defined(CONFIG_LOONGSON1_LS1C)
+	.interface	= PHY_INTERFACE_MODE_RMII,
+#endif
 	.mdio_bus_data	= &ls1x_mdio_bus_data,
 	.dma_cfg	= &ls1x_eth_dma_cfg,
 	.has_gmac	= 1,
@@ -164,6 +184,7 @@ struct platform_device ls1x_eth0_pdev = {
 	},
 };
 
+#if defined(CONFIG_LOONGSON1_LS1B)
 static struct plat_stmmacenet_data ls1x_eth1_pdata = {
 	.bus_id		= 1,
 	.phy_addr	= -1,
@@ -197,6 +218,7 @@ struct platform_device ls1x_eth1_pdev = {
 		.platform_data = &ls1x_eth1_pdata,
 	},
 };
+#endif
 
 /* USB EHCI */
 static u64 ls1x_ehci_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/mips/loongson32/common/setup.c b/arch/mips/loongson32/common/setup.c
index 62f41af..65634d0 100644
--- a/arch/mips/loongson32/common/setup.c
+++ b/arch/mips/loongson32/common/setup.c
@@ -1,5 +1,7 @@
 /*
  * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
+ * Copyright (c) 2015 Tang Haifeng <tanghaifeng-gz@loongson.cn>
+ * Copyright (c) 2016 Ling Yang <gnaygnil@gmail.com>
  *
  * This program is free software; you can redistribute	it and/or modify it
  * under  the terms of	the GNU General	 Public License as published by the
@@ -22,7 +24,11 @@ const char *get_system_type(void)
 
 	switch (processor_id & PRID_REV_MASK) {
 	case PRID_REV_LOONGSON1B:
+#if defined(CONFIG_LOONGSON1_LS1B)
 		return "LOONGSON LS1B";
+#elif defined(CONFIG_LOONGSON1_LS1C)
+		return "LOONGSON LS1C";
+#endif
 	default:
 		return "LOONGSON (unknown)";
 	}
diff --git a/arch/mips/loongson32/ls1c/Makefile b/arch/mips/loongson32/ls1c/Makefile
new file mode 100644
index 0000000..891eac4
--- /dev/null
+++ b/arch/mips/loongson32/ls1c/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for loongson1B based machines.
+#
+
+obj-y += board.o
diff --git a/arch/mips/loongson32/ls1c/board.c b/arch/mips/loongson32/ls1c/board.c
new file mode 100644
index 0000000..998f607
--- /dev/null
+++ b/arch/mips/loongson32/ls1c/board.c
@@ -0,0 +1,30 @@
+/*
+ * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
+ * Copyright (c) 2015 Tang Haifeng <tanghaifeng-gz@loongson.cn>
+ * Copyright (c) 2016 Ling Yang <gnaygnil@gmail.com>
+ *
+ * This program is free software; you can redistribute	it and/or modify it
+ * under  the terms of	the GNU General	 Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <platform.h>
+
+static struct platform_device *ls1c_platform_devices[] __initdata = {
+	&ls1x_uart_pdev,
+	&ls1x_eth0_pdev,
+};
+
+static int __init ls1c_platform_init(void)
+{
+	int err;
+
+	ls1x_serial_setup(&ls1x_uart_pdev);
+
+	err = platform_add_devices(ls1c_platform_devices,
+				   ARRAY_SIZE(ls1c_platform_devices));
+	return err;
+}
+
+arch_initcall(ls1c_platform_init);
-- 
1.9.1
