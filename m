Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 May 2016 06:29:47 +0200 (CEST)
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34279 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27030570AbcESE3pcJysm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 May 2016 06:29:45 +0200
Received: by mail-pf0-f194.google.com with SMTP id 145so6901925pfz.1;
        Wed, 18 May 2016 21:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=A1hHMKY4P2Z4tT2owRYP2zKCM5LjDIY1DQnXddoRIGc=;
        b=VfLx2kkBSd3fN64nuDtTWc6d35hOSlF9WgWuPQVh207LI2q53lUKo9ZTv9WdDk+vSh
         O+Vz+ybOn8uBFuXcSyuON/B2cgwprj8wbhCb70YJBGmN5srAEuB9Q4QfqQBOL8wl/hXD
         TcfbsCQmTv0K3OmiRHax+jFlPxHvpA7z5qPcM551OkaMWM9rsG1WhJ7sWtz6EXoXBx11
         GCj/iZvHGSEhyVBEA+jtec4hYgHF4cfJj22THeymHfxbqJ7WM/W0eH9yA5tZcQLri+8T
         pPub0NqfAzcukPAsr7dbpgzmDXyhIGElcfijjAINZXmufHlAXKQKs2v0uNCrUqQbQ9g0
         JL7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=A1hHMKY4P2Z4tT2owRYP2zKCM5LjDIY1DQnXddoRIGc=;
        b=dxQ2HZBhnkv76YV3Fykdq2lTv4PiL3mE7/ZeNSvF/kPRJiyKmclP/ZWtZec6QT50fA
         d8aQNj+0RZEbWp/djS4kJp+RbxpDpuSKNmH/lJURqBxV35Lxfl7Tckt7j1adJhoho7P7
         iI1JnM93l/f9Boiy4AxOcQuWQqQ2IgIK0nXuf45h/NSCmnH221bIV4ydgBkr4QsmChTX
         yQ0MixbE3O8arQA3aewfbQUcdznvkjKoNPIgOIzDt090JAFiXMQ8xlkJWRNivSmsGyHs
         Q5iTtybigSDRnSP3rOvoJMiI593e3NaPjhcbCI6x6qhkL7wHsOkJ39ii7hya8LKD6Ais
         y18w==
X-Gm-Message-State: AOPr4FVbaWW+Z0NmVaF8KDGP0J72U0eJiJEf0in5DSXwa8dBdOsdQDGMWkpqJbKzUSffIA==
X-Received: by 10.98.109.198 with SMTP id i189mr16219827pfc.106.1463632179263;
        Wed, 18 May 2016 21:29:39 -0700 (PDT)
Received: from ly-pc (li734-185.members.linode.com. [106.185.31.185])
        by smtp.gmail.com with ESMTPSA id y128sm15798309pfb.13.2016.05.18.21.29.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 18 May 2016 21:29:38 -0700 (PDT)
Date:   Thu, 19 May 2016 12:29:30 +0800
From:   Yang Ling <gnaygnil@gmail.com>
To:     keguang.zhang@gmail.com
Cc:     ralf@linux-mips.org, chenhc@lemote.com, gnaygnil@gmail.com,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH V1 3/4] MIPS: Loongson1C: Add board support
Message-ID: <20160519042923.GA5398@ly-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <gnaygnil@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53541
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

Adds basic platform devices for Loongson1C, including serial port
and ethernet.

Signed-off-by: Yang Ling <gnaygnil@gmail.com>
---
 arch/mips/Kconfig                                 | 13 +++++
 arch/mips/include/asm/mach-loongson32/irq.h       | 41 ++++++++++++++-
 arch/mips/include/asm/mach-loongson32/loongson1.h |  5 ++
 arch/mips/include/asm/mach-loongson32/regs-clk.h  | 34 +++++++++++++
 arch/mips/include/asm/mach-loongson32/regs-mux.h  | 61 +++++++++++++++++++++++
 arch/mips/loongson32/Kconfig                      | 15 ++++++
 arch/mips/loongson32/Makefile                     |  6 +++
 arch/mips/loongson32/Platform                     |  1 +
 arch/mips/loongson32/common/irq.c                 | 55 ++++++++++++++++++--
 arch/mips/loongson32/common/platform.c            | 19 +++++++
 arch/mips/loongson32/common/setup.c               |  4 ++
 arch/mips/loongson32/ls1c/Makefile                |  5 ++
 arch/mips/loongson32/ls1c/board.c                 | 28 +++++++++++
 13 files changed, 283 insertions(+), 4 deletions(-)
 create mode 100644 arch/mips/loongson32/ls1c/Makefile
 create mode 100644 arch/mips/loongson32/ls1c/board.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index e237868..4093cfa 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1384,6 +1384,16 @@ config CPU_LOONGSON1B
 	  The Loongson 1B is a 32-bit SoC, which implements the MIPS32
 	  release 2 instruction set.
 
+config CPU_LOONGSON1C
+	bool "Loongson 1C"
+	depends on SYS_HAS_CPU_LOONGSON1C
+	select CPU_LOONGSON1
+	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select LEDS_GPIO_REGISTER
+	help
+	  The Loongson 1C is a 32-bit SoC, which implements the MIPS32
+	  release 2 instruction set.
+
 config CPU_MIPS32_R1
 	bool "MIPS32 Release 1"
 	depends on SYS_HAS_CPU_MIPS32_R1
@@ -1827,6 +1837,9 @@ config SYS_HAS_CPU_LOONGSON2F
 config SYS_HAS_CPU_LOONGSON1B
 	bool
 
+config SYS_HAS_CPU_LOONGSON1C
+	bool
+
 config SYS_HAS_CPU_MIPS32_R1
 	bool
 
diff --git a/arch/mips/include/asm/mach-loongson32/irq.h b/arch/mips/include/asm/mach-loongson32/irq.h
index c1c7441..8c01b30 100644
--- a/arch/mips/include/asm/mach-loongson32/irq.h
+++ b/arch/mips/include/asm/mach-loongson32/irq.h
@@ -36,9 +36,14 @@
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
@@ -47,6 +52,9 @@
 #define LS1X_DMA0_IRQ			LS1X_IRQ(0, 13)
 #define LS1X_DMA1_IRQ			LS1X_IRQ(0, 14)
 #define LS1X_DMA2_IRQ			LS1X_IRQ(0, 15)
+#if defined(CONFIG_LOONGSON1_LS1C)
+#define LS1X_NAND_IRQ			LS1X_IRQ(0, 16)
+#endif
 #define LS1X_PWM0_IRQ			LS1X_IRQ(0, 17)
 #define LS1X_PWM1_IRQ			LS1X_IRQ(0, 18)
 #define LS1X_PWM2_IRQ			LS1X_IRQ(0, 19)
@@ -54,18 +62,49 @@
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
index 978f6df..3584c40 100644
--- a/arch/mips/include/asm/mach-loongson32/loongson1.h
+++ b/arch/mips/include/asm/mach-loongson32/loongson1.h
@@ -12,7 +12,11 @@
 #ifndef __ASM_MACH_LOONGSON32_LOONGSON1_H
 #define __ASM_MACH_LOONGSON32_LOONGSON1_H
 
+#if defined(CONFIG_LOONGSON1_LS1B)
 #define DEFAULT_MEMSIZE			256	/* If no memsize provided */
+#elif defined(CONFIG_LOONGSON1_LS1C)
+#define DEFAULT_MEMSIZE			32
+#endif
 
 /* Loongson 1 Register Bases */
 #define LS1X_MUX_BASE			0x1fd00420
@@ -20,6 +24,7 @@
 #define LS1X_GPIO0_BASE			0x1fd010c0
 #define LS1X_GPIO1_BASE			0x1fd010c4
 #define LS1X_DMAC_BASE			0x1fd01160
+#define LS1X_CBUS_BASE			0x1fd011c0
 #define LS1X_EHCI_BASE			0x1fe00000
 #define LS1X_OHCI_BASE			0x1fe08000
 #define LS1X_GMAC0_BASE			0x1fe10000
diff --git a/arch/mips/include/asm/mach-loongson32/regs-clk.h b/arch/mips/include/asm/mach-loongson32/regs-clk.h
index 4d56fc3..e5e8f11 100644
--- a/arch/mips/include/asm/mach-loongson32/regs-clk.h
+++ b/arch/mips/include/asm/mach-loongson32/regs-clk.h
@@ -18,6 +18,7 @@
 #define LS1X_CLK_PLL_FREQ		LS1X_CLK_REG(0x0)
 #define LS1X_CLK_PLL_DIV		LS1X_CLK_REG(0x4)
 
+#if defined(CONFIG_LOONGSON1_LS1B)
 /* Clock PLL Divisor Register Bits */
 #define DIV_DC_EN			BIT(31)
 #define DIV_DC_RST			BIT(30)
@@ -48,4 +49,37 @@
 #define BYPASS_DDR_WIDTH		1
 #define BYPASS_CPU_WIDTH		1
 
+#elif defined(CONFIG_LOONGSON1_LS1C)
+/* PLL/SDRAM Frequency configuration register Bits */
+#define PLL_VALID			BIT(31)
+#define FRAC_N				GENMASK(23, 16)
+#define RST_TIME			GENMASK(3, 2)
+#define SDRAM_DIV			GENMASK(1, 0)
+
+/* CPU/CAMERA/DC Frequency configuration register Bits */
+#define DIV_DC_EN			BIT(31)
+#define DIV_DC				GENMASK(30, 24)
+#define DIV_CAM_EN			BIT(23)
+#define DIV_CAM				GENMASK(22, 16)
+#define DIV_CPU_EN			BIT(15)
+#define DIV_CPU				GENMASK(14, 8)
+#define DIV_DC_SEL_EN			BIT(5)
+#define DIV_DC_SEL			BIT(4)
+#define DIV_CAM_SEL_EN			BIT(3)
+#define DIV_CAM_SEL			BIT(2)
+#define DIV_CPU_SEL_EN			BIT(1)
+#define DIV_CPU_SEL			BIT(0)
+
+#define DIV_DC_SHIFT			24
+#define DIV_CAM_SHIFT			16
+#define DIV_CPU_SHIFT			8
+#define DIV_DDR_SHIFT			0
+
+#define DIV_DC_WIDTH			7
+#define DIV_CAM_WIDTH			7
+#define DIV_CPU_WIDTH			7
+#define DIV_DDR_WIDTH			2
+
+#endif
+
 #endif /* __ASM_MACH_LOONGSON32_REGS_CLK_H */
diff --git a/arch/mips/include/asm/mach-loongson32/regs-mux.h b/arch/mips/include/asm/mach-loongson32/regs-mux.h
index 7c394f9..4a0bdeb 100644
--- a/arch/mips/include/asm/mach-loongson32/regs-mux.h
+++ b/arch/mips/include/asm/mach-loongson32/regs-mux.h
@@ -18,6 +18,7 @@
 #define LS1X_MUX_CTRL0			LS1X_MUX_REG(0x0)
 #define LS1X_MUX_CTRL1			LS1X_MUX_REG(0x4)
 
+#if defined(CONFIG_LOONGSON1_LS1B)
 /* MUX CTRL0 Register Bits */
 #define UART0_USE_PWM23			BIT(28)
 #define UART0_USE_PWM01			BIT(27)
@@ -64,4 +65,64 @@
 #define GMAC1_USE_PWM23			BIT(1)
 #define GMAC0_USE_PWM01			BIT(0)
 
+#elif defined(CONFIG_LOONGSON1_LS1C)
+
+/* SHUT_CTRL Register Bits */
+#define UART_SPLIT			GENMASK(31, 30)
+#define OUTPUT_CLK			GENMASK(29, 26)
+#define ADC_SHUT			BIT(25)
+#define SDIO_SHUT			BIT(24)
+#define DMA2_SHUT			BIT(23)
+#define DMA1_SHUT			BIT(22)
+#define DMA0_SHUT			BIT(21)
+#define SPI1_SHUT			BIT(20)
+#define SPI0_SHUT			BIT(19)
+#define I2C2_SHUT			BIT(18)
+#define I2C1_SHUT			BIT(17)
+#define I2C0_SHUT			BIT(16)
+#define AC97_SHUT			BIT(15)
+#define I2S_SHUT			BIT(14)
+#define UART3_SHUT			BIT(13)
+#define UART2_SHUT			BIT(12)
+#define UART1_SHUT			BIT(11)
+#define UART0_SHUT			BIT(10)
+#define CAN1_SHUT			BIT(9)
+#define CAN0_SHUT			BIT(8)
+#define ECC_SHUT			BIT(7)
+#define GMAC_SHUT			BIT(6)
+#define USBHOST_SHUT			BIT(5)
+#define USBOTG_SHUT			BIT(4)
+#define SDRAM_SHUT			BIT(3)
+#define SRAM_SHUT			BIT(2)
+#define CAM_SHUT			BIT(1)
+#define LCD_SHUT			BIT(0)
+
+#define UART_SPLIT_SHIFT                        30
+#define OUTPUT_CLK_SHIFT                        26
+
+/* MISC_CTRL Register Bits */
+#define USBHOST_RSTN			BIT(31)
+#define PHY_INTF_SELI			GENMASK(30, 28)
+#define AC97_EN				BIT(25)
+#define SDIO_DMA_EN			GENMASK(24, 23)
+#define ADC_DMA_EN			BIT(22)
+#define SDIO_USE_SPI1			BIT(17)
+#define SDIO_USE_SPI0			BIT(16)
+#define SRAM_CTRL			GENMASK(15, 0)
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
index 455a770..635a4ab 100644
--- a/arch/mips/loongson32/common/irq.c
+++ b/arch/mips/loongson32/common/irq.c
@@ -62,12 +62,58 @@ static void ls1x_irq_unmask(struct irq_data *d)
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
@@ -107,7 +153,7 @@ asmlinkage void plat_irq_dispatch(void)
 
 }
 
-struct irqaction cascade_irqaction = {
+static struct irqaction cascade_irqaction = {
 	.handler = no_action,
 	.name = "cascade",
 	.flags = IRQF_NO_THREAD,
@@ -120,7 +166,7 @@ static void __init ls1x_irq_init(int base)
 	/* Disable interrupts and clear pending,
 	 * setup all IRQs as high level triggered
 	 */
-	for (n = 0; n < 4; n++) {
+	for (n = 0; n < INTN; n++) {
 		__raw_writel(0x0, LS1X_INTC_INTIEN(n));
 		__raw_writel(0xffffffff, LS1X_INTC_INTCLR(n));
 		__raw_writel(0xffffffff, LS1X_INTC_INTPOL(n));
@@ -129,7 +175,7 @@ static void __init ls1x_irq_init(int base)
 	}
 
 
-	for (n = base; n < LS1X_IRQS; n++) {
+	for (n = base; n < NR_IRQS; n++) {
 		irq_set_chip_and_handler(n, &ls1x_irq_chip,
 					 handle_level_irq);
 	}
@@ -138,6 +184,9 @@ static void __init ls1x_irq_init(int base)
 	setup_irq(INT1_IRQ, &cascade_irqaction);
 	setup_irq(INT2_IRQ, &cascade_irqaction);
 	setup_irq(INT3_IRQ, &cascade_irqaction);
+#if defined(CONFIG_LOONGSON1_LS1C)
+	setup_irq(INT4_IRQ, &cascade_irqaction);
+#endif
 }
 
 void __init arch_init_irq(void)
diff --git a/arch/mips/loongson32/common/platform.c b/arch/mips/loongson32/common/platform.c
index f2c714d..4d12e36 100644
--- a/arch/mips/loongson32/common/platform.c
+++ b/arch/mips/loongson32/common/platform.c
@@ -17,6 +17,7 @@
 #include <linux/stmmac.h>
 #include <linux/usb/ehci_pdriver.h>
 
+#include <platform.h>
 #include <loongson1.h>
 #include <cpufreq.h>
 #include <dma.h>
@@ -132,6 +133,7 @@ int ls1x_eth_mux_init(struct platform_device *pdev, void *priv)
 
 	val = __raw_readl(LS1X_MUX_CTRL1);
 
+#if defined(CONFIG_LOONGSON1_LS1B)
 	plat_dat = dev_get_platdata(&pdev->dev);
 	if (plat_dat->bus_id) {
 		__raw_writel(__raw_readl(LS1X_MUX_CTRL0) | GMAC1_USE_UART1 |
@@ -165,6 +167,17 @@ int ls1x_eth_mux_init(struct platform_device *pdev, void *priv)
 		val &= ~GMAC0_SHUT;
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
 
 	return 0;
 }
@@ -172,7 +185,11 @@ int ls1x_eth_mux_init(struct platform_device *pdev, void *priv)
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
@@ -203,6 +220,7 @@ struct platform_device ls1x_eth0_pdev = {
 	},
 };
 
+#ifdef CONFIG_LOONGSON1_LS1B
 static struct plat_stmmacenet_data ls1x_eth1_pdata = {
 	.bus_id		= 1,
 	.phy_addr	= -1,
@@ -236,6 +254,7 @@ struct platform_device ls1x_eth1_pdev = {
 		.platform_data = &ls1x_eth1_pdata,
 	},
 };
+#endif	/* CONFIG_LOONGSON1_LS1B */
 
 /* GPIO */
 static struct resource ls1x_gpio0_resources[] = {
diff --git a/arch/mips/loongson32/common/setup.c b/arch/mips/loongson32/common/setup.c
index 62f41af..1640744 100644
--- a/arch/mips/loongson32/common/setup.c
+++ b/arch/mips/loongson32/common/setup.c
@@ -22,7 +22,11 @@ const char *get_system_type(void)
 
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
index 0000000..3d69bd6
--- /dev/null
+++ b/arch/mips/loongson32/ls1c/board.c
@@ -0,0 +1,28 @@
+/*
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
+	ls1x_serial_set_uartclk(&ls1x_uart_pdev);
+
+	err = platform_add_devices(ls1c_platform_devices,
+				   ARRAY_SIZE(ls1c_platform_devices));
+	return err;
+}
+
+arch_initcall(ls1c_platform_init);
-- 
1.9.1


Rebase changes base on the following patch.
https://patchwork.linux-mips.org/patch/13039/
