Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Apr 2015 05:42:48 +0200 (CEST)
Received: from smtpbg327.qq.com ([14.17.43.158]:50081 "EHLO smtpbg327.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010140AbbD2DmnuLhdD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 29 Apr 2015 05:42:43 +0200
X-QQ-mid: bizesmtp2t1430278784t427t184
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Wed, 29 Apr 2015 11:39:43 +0800 (CST)
X-QQ-SSF: 01100000002000F0F322B00A0000000
X-QQ-FEAT: tVKGGNF+Ub974J8150iYtkx0ZldtYx9towIhfmB/Isi0JDDTDBQS/JDF3cucc
        /hLF0DXpWiCR0mNhG9TO5IS7aHeZiD7tOd2o6Tzi6p/RZ9W/z25JPrwowTc3+Yw3JOKutGW
        GdptZIbMyjlvn8XWMUbb3mDZ/VAKX9bZfZdRi+j9T/f242C7m/Fb6zFcRjHc1ninu6riqEZ
        rYE68UBeBr06juOFUR+Rl1DvNz/hGuo4Z+cKaiSg/UyuaaZdAr0QSy+1E2j71Rg4=
X-QQ-GoodBg: 0
From:   Binbin Zhou <zhoubb@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Binbin Zhou <zhoubb@lemote.com>, Chunbo Cui <cuicb@lemote.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH 4/8] MIPS: Loongson: Add loongson-1A board support
Date:   Wed, 29 Apr 2015 11:57:23 +0800
Message-Id: <1430279847-25120-5-git-send-email-zhoubb@lemote.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1430279847-25120-1-git-send-email-zhoubb@lemote.com>
References: <1430279847-25120-1-git-send-email-zhoubb@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <zhoubb@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47157
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

Loongson 1A's platform devices register.

Specially, Loongson 1A use ACPI to control restart/poweroff/halt.

Signed-off-by: Chunbo Cui <cuicb@lemote.com>
Signed-off-by: Binbin Zhou <zhoubb@lemote.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/mach-loongson1/loongson1.h |   8 ++
 arch/mips/loongson1/Makefile                     |   1 +
 arch/mips/loongson1/common/reset.c               |   6 ++
 arch/mips/loongson1/common/setup.c               |  38 +++++++-
 arch/mips/loongson1/ls1a/Makefile                |   5 ++
 arch/mips/loongson1/ls1a/board.c                 | 105 +++++++++++++++++++++++
 6 files changed, 162 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/loongson1/ls1a/Makefile
 create mode 100644 arch/mips/loongson1/ls1a/board.c

diff --git a/arch/mips/include/asm/mach-loongson1/loongson1.h b/arch/mips/include/asm/mach-loongson1/loongson1.h
index 912d702..c7689ad 100644
--- a/arch/mips/include/asm/mach-loongson1/loongson1.h
+++ b/arch/mips/include/asm/mach-loongson1/loongson1.h
@@ -157,6 +157,14 @@
 #define LS1X_LPC_CFG2_REG		(LS1X_LPC_REG_BASE + 0x8)
 #define LS1X_LPC_CFG3_REG		(LS1X_LPC_REG_BASE + 0xc)
 
+/* reg access */
+#define ls1x_readb(addr)		(*(volatile u8 *)CKSEG1ADDR(addr))
+#define ls1x_readw(addr)		(*(volatile u16 *)CKSEG1ADDR(addr))
+#define ls1x_readl(addr)		(*(volatile u32 *)CKSEG1ADDR(addr))
+#define ls1x_writeb(val, addr)		(*(volatile u8 *)CKSEG1ADDR(addr) = (val))
+#define ls1x_writew(val, addr)		(*(volatile u16 *)CKSEG1ADDR(addr) = (val))
+#define ls1x_writel(val, addr)		(*(volatile u32 *)CKSEG1ADDR(addr) = (val))
+
 #include <regs-clk.h>
 #include <regs-mux.h>
 #include <regs-pwm.h>
diff --git a/arch/mips/loongson1/Makefile b/arch/mips/loongson1/Makefile
index 9719c75..b9f9bb3 100644
--- a/arch/mips/loongson1/Makefile
+++ b/arch/mips/loongson1/Makefile
@@ -8,4 +8,5 @@ obj-$(CONFIG_MACH_LOONGSON1) += common/
 # Loongson LS1B board
 #
 
+obj-$(CONFIG_LOONGSON1_LS1A)  += ls1a/
 obj-$(CONFIG_LOONGSON1_LS1B)  += ls1b/
diff --git a/arch/mips/loongson1/common/reset.c b/arch/mips/loongson1/common/reset.c
index c41e4ca..71630fd 100644
--- a/arch/mips/loongson1/common/reset.c
+++ b/arch/mips/loongson1/common/reset.c
@@ -18,10 +18,14 @@ static void __iomem *wdt_base;
 
 static void ls1x_halt(void)
 {
+#ifdef CONFIG_CPU_LOONGSON1A
+	ls1x_writel(ls1x_readl(LS1X_PM1_CNT_REG) | 0x3d00, LS1X_PM1_CNT_REG);
+#else
 	while (1) {
 		if (cpu_wait)
 			cpu_wait();
 	}
+#endif
 }
 
 static void ls1x_restart(char *command)
@@ -30,7 +34,9 @@ static void ls1x_restart(char *command)
 	__raw_writel(0x1, wdt_base + WDT_TIMER);
 	__raw_writel(0x1, wdt_base + WDT_SET);
 
+#ifndef CONFIG_CPU_LOONGSON1A
 	ls1x_halt();
+#endif
 }
 
 static void ls1x_power_off(void)
diff --git a/arch/mips/loongson1/common/setup.c b/arch/mips/loongson1/common/setup.c
index c3d2036..87d21c9 100644
--- a/arch/mips/loongson1/common/setup.c
+++ b/arch/mips/loongson1/common/setup.c
@@ -8,12 +8,48 @@
  */
 
 #include <asm/bootinfo.h>
-
+#include <linux/ioport.h>
+#include <linux/screen_info.h>
 #include <prom.h>
 
+void (*__wbflush)(void);
+static void wbflush_ls1x(void)
+{
+	asm(".set\tpush\n\t"
+	    ".set\tnoreorder\n\t"
+	    ".set mips3\n\t"
+	    "sync\n\t"
+	    "nop\n\t"
+	    ".set\tpop\n\t"
+	    ".set mips0\n\t");
+}
+
 void __init plat_mem_setup(void)
 {
 	add_memory_region(0x0, (memsize << 20), BOOT_MEM_RAM);
+
+#ifdef CONFIG_CPU_LOONGSON1A
+	ioport_resource.start	= 0;
+	ioport_resource.end	= 0xffffffff;
+	iomem_resource.start	= 0;
+	iomem_resource.end	= 0xffffffff;
+
+	__wbflush = wbflush_ls1x;
+
+	set_io_port_base(0xbc000000);
+
+#if defined(CONFIG_VGA_CONSOLE)
+	screen_info = (struct screen_info) {
+		.orig_x			= 0,
+		.orig_y			= 25,
+		.orig_video_cols	= 80,
+		.orig_video_lines	= 25,
+		.orig_video_isVGA	= VIDEO_TYPE_VGAC,
+		.orig_video_points	= 16,
+	};
+#endif
+	add_memory_region(0x20000000, 0x30000000, BOOT_MEM_RESERVED);
+#endif
 }
 
 const char *get_system_type(void)
diff --git a/arch/mips/loongson1/ls1a/Makefile b/arch/mips/loongson1/ls1a/Makefile
new file mode 100644
index 0000000..7f2baf3
--- /dev/null
+++ b/arch/mips/loongson1/ls1a/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for Loongson 1A based machines.
+#
+
+obj-y += board.o
diff --git a/arch/mips/loongson1/ls1a/board.c b/arch/mips/loongson1/ls1a/board.c
new file mode 100644
index 0000000..98fb86c
--- /dev/null
+++ b/arch/mips/loongson1/ls1a/board.c
@@ -0,0 +1,105 @@
+/*
+ * Platform device support for GS232 SoCs.
+ *
+ * Copyright 2009, Su Wen <suwen@ict.ac.cn>
+ *
+ * base on Au1xxx Socs drivers by Matt Porter <mporter@kernel.crashing.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/flash.h>
+
+#include <irq.h>
+#include <platform.h>
+#include <loongson1.h>
+
+static struct platform_device *ls1a_platform_devices[] __initdata = {
+	&ls1x_nand_pdev,
+	&ls1x_uart_pdev,
+	&ls1x_ahci_pdev,
+	&ls1x_ohci_pdev,
+	&ls1x_ehci_pdev,
+	&ls1x_eth0_pdev,
+	&ls1x_eth1_pdev,
+	&ls1x_wat_pdev,
+	&ls1x_rtc_pdev,
+	&ls1x_audio_pdev,
+	&ls1x_fb_pdev,
+	&ls1x_i2c0_pdev,
+	&ls1x_i2c1_pdev,
+	&ls1x_i2c2_pdev,
+	&ls1x_spi0_pdev,
+	&ls1x_spi1_pdev,
+};
+
+struct i2c_board_info ls1a_pcf8563 __initdata = {
+	I2C_BOARD_INFO("pcf8563", 0x51),
+};
+
+struct flash_platform_data ls1a_spiflash_data = {
+	.name		= "m25p80",
+	.parts		= NULL,
+	.nr_parts	= 0,
+	.type		= "m25p80",
+};
+
+struct spi_board_info ls1a_spi_info[] __initdata = {
+	{
+		.modalias	= "m25p80",
+		.max_speed_hz	= 1000000,
+		.bus_num	= 0,
+		.chip_select	= 1,
+		.platform_data	= &ls1a_spiflash_data,
+	},
+};
+
+void ls1a_route_setting(void)
+{
+	/*set gpio 48-61 as normal pin*/
+	ls1x_writel(ls1x_readl(LS1X_GPIO_CFG1_REG) & 0xc000ffff,
+					LS1X_GPIO_CFG1_REG);
+
+	/*set gpio mux : gmac1 to use uart0, uart1 pins*/
+	ls1x_writel((ls1x_readl(LS1X_MUX_BASE) & 0x00fff5ff) | 0x0a0000c0,
+					LS1X_GPIO_CFG1_REG);
+
+	/*multiplex int0 as gpio0 */
+	ls1x_writel(ls1x_readl(LS1X_GPIO_CFG0_REG) | 0x00000001,
+					LS1X_GPIO_CFG0_REG);
+	ls1x_writel(ls1x_readl(LS1X_GPIO_OE0_REG) | 0x00000001,
+					LS1X_GPIO_OE0_REG);
+	ls1x_writel(ls1x_readl(LS1X_GPIO_IN0_REG) & 0xfffffffe,
+					LS1X_GPIO_IN0_REG);
+
+	/*i2c gpio configuartion gpio64 scl and gpio65 sda*/
+	ls1x_writel(ls1x_readl(LS1X_GPIO_CFG2_REG) & 0xfffffffd,
+					LS1X_GPIO_CFG2_REG);
+
+	mdelay(1);
+
+	/*ls1a usb reset stop*/
+	ls1x_writel(0x40000000, LS1X_LPC_CFG1_REG);
+
+	/* Reset GMAC0/1 to avoid DMA error */
+	ls1x_writel(ls1x_readl(LS1X_GMAC0_DMA_REG) | 1, LS1X_GMAC0_DMA_REG);
+	ls1x_writel(ls1x_readl(LS1X_GMAC1_DMA_REG) | 1, LS1X_GMAC1_DMA_REG);
+}
+
+int __init ls1a_platform_init(void)
+{
+	ls1a_route_setting();
+
+	i2c_register_board_info(1, &ls1a_pcf8563, 1);
+	spi_register_board_info(ls1a_spi_info, ARRAY_SIZE(ls1a_spi_info));
+
+	return platform_add_devices(ls1a_platform_devices,
+					ARRAY_SIZE(ls1a_platform_devices));
+}
+
+arch_initcall(ls1a_platform_init);
-- 
1.9.0
