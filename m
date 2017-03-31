Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Mar 2017 11:01:57 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:16769 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993302AbdCaJBFzlkPq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 31 Mar 2017 11:01:05 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id B536386305CFB;
        Fri, 31 Mar 2017 10:00:55 +0100 (IST)
Received: from zkakakhel-linux.le.imgtec.org (192.168.154.45) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 31 Mar 2017 10:00:57 +0100
From:   Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
CC:     <Zubair.Kakakhel@imgtec.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] MIPS: Xilfpga: Switch to using generic defconfigs
Date:   Fri, 31 Mar 2017 10:00:42 +0100
Message-ID: <20170331090042.29168-3-Zubair.Kakakhel@imgtec.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20170331090042.29168-1-Zubair.Kakakhel@imgtec.com>
References: <20170331090042.29168-1-Zubair.Kakakhel@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.45]
Return-Path: <Zubair.Kakakhel@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57500
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Zubair.Kakakhel@imgtec.com
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

Use the generic platform code and remove arch/mips/xilfpga

Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
---
 arch/mips/Kbuild.platforms          |  1 -
 arch/mips/Kconfig                   | 24 ------------
 arch/mips/Makefile                  |  4 ++
 arch/mips/configs/xilfpga_defconfig | 75 -------------------------------------
 arch/mips/xilfpga/Kconfig           |  9 -----
 arch/mips/xilfpga/Makefile          |  7 ----
 arch/mips/xilfpga/Platform          |  3 --
 arch/mips/xilfpga/init.c            | 44 ----------------------
 arch/mips/xilfpga/intc.c            | 22 -----------
 arch/mips/xilfpga/time.c            | 41 --------------------
 10 files changed, 4 insertions(+), 226 deletions(-)
 delete mode 100644 arch/mips/configs/xilfpga_defconfig
 delete mode 100644 arch/mips/xilfpga/Kconfig
 delete mode 100644 arch/mips/xilfpga/Makefile
 delete mode 100644 arch/mips/xilfpga/Platform
 delete mode 100644 arch/mips/xilfpga/init.c
 delete mode 100644 arch/mips/xilfpga/intc.c
 delete mode 100644 arch/mips/xilfpga/time.c

diff --git a/arch/mips/Kbuild.platforms b/arch/mips/Kbuild.platforms
index f5f1bdb..ac7ad54 100644
--- a/arch/mips/Kbuild.platforms
+++ b/arch/mips/Kbuild.platforms
@@ -34,7 +34,6 @@ platforms += sibyte
 platforms += sni
 platforms += txx9
 platforms += vr41xx
-platforms += xilfpga
 
 # include the platform specific files
 include $(patsubst %, $(srctree)/arch/mips/%/Platform, $(platforms))
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index a008a9f..d8f152e 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -463,29 +463,6 @@ config MACH_PISTACHIO
 	help
 	  This enables support for the IMG Pistachio SoC platform.
 
-config MACH_XILFPGA
-	bool "MIPSfpga Xilinx based boards"
-	select BOOT_ELF32
-	select BOOT_RAW
-	select BUILTIN_DTB
-	select CEVT_R4K
-	select COMMON_CLK
-	select CSRC_R4K
-	select GPIOLIB
-	select IRQ_MIPS_CPU
-	select LIBFDT
-	select MIPS_CPU_SCACHE
-	select SYS_HAS_EARLY_PRINTK
-	select SYS_HAS_CPU_MIPS32_R2
-	select SYS_SUPPORTS_32BIT_KERNEL
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-	select SYS_SUPPORTS_ZBOOT_UART16550
-	select USE_OF
-	select USE_GENERIC_EARLY_PRINTK_8250
-	select XILINX_INTC
-	help
-	  This enables support for the IMG University Program MIPSfpga platform.
-
 config MIPS_MALTA
 	bool "MIPS Malta board"
 	select ARCH_MAY_HAVE_PC_FDC
@@ -1029,7 +1006,6 @@ source "arch/mips/loongson32/Kconfig"
 source "arch/mips/loongson64/Kconfig"
 source "arch/mips/netlogic/Kconfig"
 source "arch/mips/paravirt/Kconfig"
-source "arch/mips/xilfpga/Kconfig"
 
 endmenu
 
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 8ef9c02..ce65dea 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -501,6 +501,10 @@ $(generic_config_dir)/%.config: ;
 # now that the boards have been converted to use the generic kernel they are
 # wrappers around the generic rules above.
 #
+.PHONY: xilfpga_defconfig
+xilfpga_defconfig:
+	$(Q)$(MAKE) 32r2el_defconfig BOARDS=xilfpga
+
 .PHONY: sead3_defconfig
 sead3_defconfig:
 	$(Q)$(MAKE) 32r2el_defconfig BOARDS=sead-3
diff --git a/arch/mips/configs/xilfpga_defconfig b/arch/mips/configs/xilfpga_defconfig
deleted file mode 100644
index 829c637..0000000
--- a/arch/mips/configs/xilfpga_defconfig
+++ /dev/null
@@ -1,75 +0,0 @@
-CONFIG_MACH_XILFPGA=y
-# CONFIG_COMPACTION is not set
-# CONFIG_LOCALVERSION_AUTO is not set
-CONFIG_EMBEDDED=y
-# CONFIG_VM_EVENT_COUNTERS is not set
-# CONFIG_COMPAT_BRK is not set
-CONFIG_SLAB=y
-# CONFIG_BLOCK is not set
-# CONFIG_SUSPEND is not set
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_INET=y
-# CONFIG_IPV6 is not set
-# CONFIG_WIRELESS is not set
-# CONFIG_UEVENT_HELPER is not set
-CONFIG_DEVTMPFS=y
-CONFIG_DEVTMPFS_MOUNT=y
-# CONFIG_STANDALONE is not set
-# CONFIG_PREVENT_FIRMWARE_BUILD is not set
-# CONFIG_FW_LOADER is not set
-# CONFIG_ALLOW_DEV_COREDUMP is not set
-CONFIG_NETDEVICES=y
-# CONFIG_NET_CORE is not set
-# CONFIG_NET_VENDOR_ARC is not set
-# CONFIG_NET_CADENCE is not set
-# CONFIG_NET_VENDOR_BROADCOM is not set
-# CONFIG_NET_VENDOR_EZCHIP is not set
-# CONFIG_NET_VENDOR_INTEL is not set
-# CONFIG_NET_VENDOR_MARVELL is not set
-# CONFIG_NET_VENDOR_MICREL is not set
-# CONFIG_NET_VENDOR_NATSEMI is not set
-# CONFIG_NET_VENDOR_NETRONOME is not set
-# CONFIG_NET_VENDOR_QUALCOMM is not set
-# CONFIG_NET_VENDOR_RENESAS is not set
-# CONFIG_NET_VENDOR_ROCKER is not set
-# CONFIG_NET_VENDOR_SAMSUNG is not set
-# CONFIG_NET_VENDOR_SEEQ is not set
-# CONFIG_NET_VENDOR_SMSC is not set
-# CONFIG_NET_VENDOR_STMICRO is not set
-# CONFIG_NET_VENDOR_SYNOPSYS is not set
-# CONFIG_NET_VENDOR_VIA is not set
-# CONFIG_NET_VENDOR_WIZNET is not set
-CONFIG_XILINX_EMACLITE=y
-CONFIG_SMSC_PHY=y
-# CONFIG_WLAN is not set
-# CONFIG_INPUT_MOUSEDEV is not set
-# CONFIG_INPUT_KEYBOARD is not set
-# CONFIG_INPUT_MOUSE is not set
-# CONFIG_SERIO is not set
-CONFIG_VT_HW_CONSOLE_BINDING=y
-# CONFIG_UNIX98_PTYS is not set
-# CONFIG_LEGACY_PTYS is not set
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_OF_PLATFORM=y
-# CONFIG_HW_RANDOM is not set
-CONFIG_I2C=y
-CONFIG_I2C_CHARDEV=y
-# CONFIG_I2C_HELPER_AUTO is not set
-CONFIG_I2C_XILINX=y
-CONFIG_GPIO_SYSFS=y
-CONFIG_GPIO_XILINX=y
-CONFIG_SENSORS_ADT7410=y
-# CONFIG_USB_SUPPORT is not set
-# CONFIG_MIPS_PLATFORM_DEVICES is not set
-# CONFIG_IOMMU_SUPPORT is not set
-# CONFIG_PROC_PAGE_MONITOR is not set
-CONFIG_TMPFS=y
-# CONFIG_MISC_FILESYSTEMS is not set
-CONFIG_PANIC_ON_OOPS=y
-# CONFIG_SCHED_DEBUG is not set
-# CONFIG_FTRACE is not set
-CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="console=ttyS0,115200"
diff --git a/arch/mips/xilfpga/Kconfig b/arch/mips/xilfpga/Kconfig
deleted file mode 100644
index 42a030a..0000000
--- a/arch/mips/xilfpga/Kconfig
+++ /dev/null
@@ -1,9 +0,0 @@
-choice
-	prompt "Machine type"
-	depends on MACH_XILFPGA
-	default XILFPGA_NEXYS4DDR
-
-config XILFPGA_NEXYS4DDR
-	bool "Nexys4DDR by Digilent"
-
-endchoice
diff --git a/arch/mips/xilfpga/Makefile b/arch/mips/xilfpga/Makefile
deleted file mode 100644
index a4deec6..0000000
--- a/arch/mips/xilfpga/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-#
-# Makefile for the Xilfpga
-#
-
-obj-y +=	init.o
-obj-y +=	intc.o
-obj-y +=	time.o
diff --git a/arch/mips/xilfpga/Platform b/arch/mips/xilfpga/Platform
deleted file mode 100644
index ed375af..0000000
--- a/arch/mips/xilfpga/Platform
+++ /dev/null
@@ -1,3 +0,0 @@
-platform-$(CONFIG_MACH_XILFPGA) += xilfpga/
-cflags-$(CONFIG_MACH_XILFPGA) += -I$(srctree)/arch/mips/include/asm/mach-xilfpga
-load-$(CONFIG_MACH_XILFPGA) += 0xffffffff80100000
diff --git a/arch/mips/xilfpga/init.c b/arch/mips/xilfpga/init.c
deleted file mode 100644
index 602e384..0000000
--- a/arch/mips/xilfpga/init.c
+++ /dev/null
@@ -1,44 +0,0 @@
-/*
- * Xilfpga platform setup
- *
- * Copyright (C) 2015 Imagination Technologies
- * Author: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- */
-
-#include <linux/of_fdt.h>
-
-#include <asm/prom.h>
-
-#define XILFPGA_UART_BASE	0xb0401000
-
-const char *get_system_type(void)
-{
-	return "MIPSfpga";
-}
-
-void __init plat_mem_setup(void)
-{
-	__dt_setup_arch(__dtb_start);
-	strlcpy(arcs_cmdline, boot_command_line, COMMAND_LINE_SIZE);
-}
-
-void __init prom_init(void)
-{
-	setup_8250_early_printk_port(XILFPGA_UART_BASE, 2, 50000);
-}
-
-void __init prom_free_prom_memory(void)
-{
-}
-
-void __init device_tree_init(void)
-{
-	if (!initial_boot_params)
-		return;
-
-	unflatten_and_copy_device_tree();
-}
diff --git a/arch/mips/xilfpga/intc.c b/arch/mips/xilfpga/intc.c
deleted file mode 100644
index a127cca..0000000
--- a/arch/mips/xilfpga/intc.c
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- * Xilfpga interrupt controller setup
- *
- * Copyright (C) 2015 Imagination Technologies
- * Author: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- */
-
-#include <linux/of.h>
-#include <linux/of_irq.h>
-#include <linux/irqchip.h>
-
-#include <asm/irq_cpu.h>
-
-
-void __init arch_init_irq(void)
-{
-	irqchip_init();
-}
diff --git a/arch/mips/xilfpga/time.c b/arch/mips/xilfpga/time.c
deleted file mode 100644
index cbb3fca..0000000
--- a/arch/mips/xilfpga/time.c
+++ /dev/null
@@ -1,41 +0,0 @@
-/*
- * Xilfpga clocksource/timer setup
- *
- * Copyright (C) 2015 Imagination Technologies
- * Author: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- */
-
-#include <linux/clk.h>
-#include <linux/clk-provider.h>
-#include <linux/clocksource.h>
-#include <linux/of.h>
-
-#include <asm/time.h>
-
-void __init plat_time_init(void)
-{
-	struct device_node *np;
-	struct clk *clk;
-
-	of_clk_init(NULL);
-	clocksource_probe();
-
-	np = of_get_cpu_node(0, NULL);
-	if (!np) {
-		pr_err("Failed to get CPU node\n");
-		return;
-	}
-
-	clk = of_clk_get(np, 0);
-	if (IS_ERR(clk)) {
-		pr_err("Failed to get CPU clock: %ld\n", PTR_ERR(clk));
-		return;
-	}
-
-	mips_hpt_frequency = clk_get_rate(clk) / 2;
-	clk_put(clk);
-}
-- 
2.10.2
