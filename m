Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Mar 2016 01:49:20 +0100 (CET)
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33974 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27024609AbcCAAsYv7Mp8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Mar 2016 01:48:24 +0100
Received: by mail-pa0-f68.google.com with SMTP id yy13so9429541pab.1;
        Mon, 29 Feb 2016 16:48:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kHFFn137cAw/twfjkaouH/enivA4v3511cwySlctIes=;
        b=lEaznwgMo2+3ElF4C79BN2B2P2c171js+S+vkpUFx4tCl5zLDB9c6LLqQ5kUDAMHi0
         4sGEMoOQuEWE83lt5BQ+OZV9jW/gZ5OKHMS/xV7SCMy+boBvrhcag6rFlBTdWZZtPh3V
         4hO8VXN6hf5ZWpSa1ySxUwgynsUjDoekkBC4l2mi6eoS97QqHAh4F8yTAcPyI00mGT10
         u9zLLsWbdfMWc/0Dhtta7hFmk5PK7QbuuNkVKDtXm2dzYkvq9/u13mL4/8n1hL9beCbM
         zL2EUQ89qauH/gOEzUoIqrDQ3WCIn5vIf/7/HAH2YWZOp0MAe1xvUHhyUqLdelWQN7/H
         ZpCQ==
X-Gm-Message-State: AD7BkJK8DcxBlTUwzdXT7YxqnqGCYLqhB3/Zzczt5sUQa705nVLzFf5v2TO2ZWFuFdVNNw==
X-Received: by 10.66.248.168 with SMTP id yn8mr26079465pac.24.1456793299185;
        Mon, 29 Feb 2016 16:48:19 -0800 (PST)
Received: from software.domain.org ([222.92.8.142])
        by smtp.gmail.com with ESMTPSA id s197sm40683975pfs.62.2016.02.29.16.48.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Feb 2016 16:48:18 -0800 (PST)
From:   Binbin Zhou <zhoubb@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Binbin Zhou <zhoubb@lemote.com>, Chunbo Cui <cuicb@lemote.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH v3 4/8] MIPS: Loongson: Add loongson-1A board support
Date:   Tue,  1 Mar 2016 08:48:12 +0800
Message-Id: <1456793296-17120-5-git-send-email-zhoubb@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1456793296-17120-1-git-send-email-zhoubb@lemote.com>
References: <1456793296-17120-1-git-send-email-zhoubb@lemote.com>
Return-Path: <zhoubb.aaron@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52367
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
 arch/mips/include/asm/mach-loongson32/loongson1.h |   8 ++
 arch/mips/loongson32/Makefile                     |   6 ++
 arch/mips/loongson32/common/reset.c               |   6 ++
 arch/mips/loongson32/common/setup.c               |  38 +++++++-
 arch/mips/loongson32/ls1a/Makefile                |   5 ++
 arch/mips/loongson32/ls1a/board.c                 | 105 ++++++++++++++++++++++
 6 files changed, 167 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/loongson32/ls1a/Makefile
 create mode 100644 arch/mips/loongson32/ls1a/board.c

diff --git a/arch/mips/include/asm/mach-loongson32/loongson1.h b/arch/mips/include/asm/mach-loongson32/loongson1.h
index 5c1ba48..3061e64 100644
--- a/arch/mips/include/asm/mach-loongson32/loongson1.h
+++ b/arch/mips/include/asm/mach-loongson32/loongson1.h
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
diff --git a/arch/mips/loongson32/Makefile b/arch/mips/loongson32/Makefile
index 5f4bd6e..c2a6559 100644
--- a/arch/mips/loongson32/Makefile
+++ b/arch/mips/loongson32/Makefile
@@ -5,6 +5,12 @@
 obj-$(CONFIG_MACH_LOONGSON32) += common/
 
 #
+# Loongson LS1A board
+#
+
+obj-$(CONFIG_LOONGSON1_LS1A)  += ls1a/
+
+#
 # Loongson LS1B board
 #
 
diff --git a/arch/mips/loongson32/common/reset.c b/arch/mips/loongson32/common/reset.c
index c41e4ca..71630fd 100644
--- a/arch/mips/loongson32/common/reset.c
+++ b/arch/mips/loongson32/common/reset.c
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
diff --git a/arch/mips/loongson32/common/setup.c b/arch/mips/loongson32/common/setup.c
index c3d2036..87d21c9 100644
--- a/arch/mips/loongson32/common/setup.c
+++ b/arch/mips/loongson32/common/setup.c
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
diff --git a/arch/mips/loongson32/ls1a/Makefile b/arch/mips/loongson32/ls1a/Makefile
new file mode 100644
index 0000000..7f2baf3
--- /dev/null
+++ b/arch/mips/loongson32/ls1a/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for Loongson 1A based machines.
+#
+
+obj-y += board.o
diff --git a/arch/mips/loongson32/ls1a/board.c b/arch/mips/loongson32/ls1a/board.c
new file mode 100644
index 0000000..98fb86c
--- /dev/null
+++ b/arch/mips/loongson32/ls1a/board.c
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
1.9.1
