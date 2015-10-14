Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Oct 2015 14:54:13 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:59938 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009577AbbJNMwoI7k0C (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Oct 2015 14:52:44 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 54C4BD5E9D1C1;
        Wed, 14 Oct 2015 13:52:34 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 14 Oct 2015 13:52:37 +0100
Received: from zkakakhel-linux.le.imgtec.org (192.168.154.45) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 14 Oct 2015 13:52:36 +0100
From:   Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
To:     <ralf@linux-mips.org>, <robh+dt@kernel.org>,
        <linus.walleij@linaro.org>
CC:     <linux-mips@linux-mips.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Zubair.Kakakhel@imgtec.com>
Subject: [PATCH 4/5] MIPS: xilfpga: Add mipsfpga platform code
Date:   Wed, 14 Oct 2015 13:51:56 +0100
Message-ID: <1444827117-10939-5-git-send-email-Zubair.Kakakhel@imgtec.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1444827117-10939-1-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1444827117-10939-1-git-send-email-Zubair.Kakakhel@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.45]
Return-Path: <Zubair.Kakakhel@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49542
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

The xilfpga platform will be DT only.

Add required platform code. DT files have already been added separately

Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
---
 arch/mips/Kbuild.platforms                |  1 +
 arch/mips/Kconfig                         | 25 ++++++++++++++
 arch/mips/include/asm/mach-xilfpga/gpio.h | 19 +++++++++++
 arch/mips/include/asm/mach-xilfpga/irq.h  | 18 ++++++++++
 arch/mips/xilfpga/Kconfig                 |  9 +++++
 arch/mips/xilfpga/Makefile                |  7 ++++
 arch/mips/xilfpga/Platform                |  3 ++
 arch/mips/xilfpga/init.c                  | 57 +++++++++++++++++++++++++++++++
 arch/mips/xilfpga/intc.c                  | 26 ++++++++++++++
 arch/mips/xilfpga/time.c                  | 41 ++++++++++++++++++++++
 10 files changed, 206 insertions(+)
 create mode 100644 arch/mips/include/asm/mach-xilfpga/gpio.h
 create mode 100644 arch/mips/include/asm/mach-xilfpga/irq.h
 create mode 100644 arch/mips/xilfpga/Kconfig
 create mode 100644 arch/mips/xilfpga/Makefile
 create mode 100644 arch/mips/xilfpga/Platform
 create mode 100644 arch/mips/xilfpga/init.c
 create mode 100644 arch/mips/xilfpga/intc.c
 create mode 100644 arch/mips/xilfpga/time.c

diff --git a/arch/mips/Kbuild.platforms b/arch/mips/Kbuild.platforms
index a424e46..a96c81d 100644
--- a/arch/mips/Kbuild.platforms
+++ b/arch/mips/Kbuild.platforms
@@ -33,6 +33,7 @@ platforms += sibyte
 platforms += sni
 platforms += txx9
 platforms += vr41xx
+platforms += xilfpga
 
 # include the platform specific files
 include $(patsubst %, $(srctree)/arch/mips/%/Platform, $(platforms))
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index e3aa5b0..66c1a7e 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -401,6 +401,30 @@ config MACH_PISTACHIO
 	help
 	  This enables support for the IMG Pistachio SoC platform.
 
+config MACH_XILFPGA
+	bool "MIPSFPGA Xilinx based boards"
+	select ARCH_REQUIRE_GPIOLIB
+	select BOOT_ELF32
+	select BOOT_RAW
+	select BUILTIN_DTB
+	select CEVT_R4K
+	select COMMON_CLK
+	select CSRC_R4K
+	select IRQ_MIPS_CPU
+	select LIBFDT
+	select MIPS_CPU_SCACHE
+	select SERIAL_8250
+	select SERIAL_8250_CONSOLE
+	select SYS_HAS_EARLY_PRINTK
+	select SYS_HAS_CPU_MIPS32_R2
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SYS_SUPPORTS_ZBOOT_UART16550
+	select USE_OF
+	select USE_GENERIC_EARLY_PRINTK_8250
+	help
+	  This enables support for the Xilinx
+
 config MIPS_MALTA
 	bool "MIPS Malta board"
 	select ARCH_MAY_HAVE_PC_FDC
@@ -964,6 +988,7 @@ source "arch/mips/loongson32/Kconfig"
 source "arch/mips/loongson64/Kconfig"
 source "arch/mips/netlogic/Kconfig"
 source "arch/mips/paravirt/Kconfig"
+source "arch/mips/xilfpga/Kconfig"
 
 endmenu
 
diff --git a/arch/mips/include/asm/mach-xilfpga/gpio.h b/arch/mips/include/asm/mach-xilfpga/gpio.h
new file mode 100644
index 0000000..26778fc
--- /dev/null
+++ b/arch/mips/include/asm/mach-xilfpga/gpio.h
@@ -0,0 +1,19 @@
+/*
+ * Copyright (C) 2015 Imagination Technologies
+ * Author: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __ASM_MACH_XILFPGA_GPIO_H
+#define __ASM_MACH_XILFPGA_GPIO_H
+
+#include <asm-generic/gpio.h>
+
+#define gpio_get_value __gpio_get_value
+#define gpio_set_value __gpio_set_value
+
+#endif /* __ASM_MACH_XILFPGA_GPIO_H */
diff --git a/arch/mips/include/asm/mach-xilfpga/irq.h b/arch/mips/include/asm/mach-xilfpga/irq.h
new file mode 100644
index 0000000..0132a5b9
--- /dev/null
+++ b/arch/mips/include/asm/mach-xilfpga/irq.h
@@ -0,0 +1,18 @@
+/*
+ * Copyright (C) 2015 Imagination Technologies
+ * Author: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __MIPS_ASM_MACH_XILFPGA_IRQ_H__
+#define __MIPS_ASM_MACH_XILFPGA_IRQ_H__
+
+#define NR_IRQS 32
+
+#include_next <irq.h>
+
+#endif /* __MIPS_ASM_MACH_XILFPGA_IRQ_H__ */
diff --git a/arch/mips/xilfpga/Kconfig b/arch/mips/xilfpga/Kconfig
new file mode 100644
index 0000000..42a030a
--- /dev/null
+++ b/arch/mips/xilfpga/Kconfig
@@ -0,0 +1,9 @@
+choice
+	prompt "Machine type"
+	depends on MACH_XILFPGA
+	default XILFPGA_NEXYS4DDR
+
+config XILFPGA_NEXYS4DDR
+	bool "Nexys4DDR by Digilent"
+
+endchoice
diff --git a/arch/mips/xilfpga/Makefile b/arch/mips/xilfpga/Makefile
new file mode 100644
index 0000000..2385aa7
--- /dev/null
+++ b/arch/mips/xilfpga/Makefile
@@ -0,0 +1,7 @@
+#
+# Makefile for the Xilfpga
+#
+
+obj-y +=	init.o \
+		intc.o \
+		time.o
diff --git a/arch/mips/xilfpga/Platform b/arch/mips/xilfpga/Platform
new file mode 100644
index 0000000..ed375af
--- /dev/null
+++ b/arch/mips/xilfpga/Platform
@@ -0,0 +1,3 @@
+platform-$(CONFIG_MACH_XILFPGA) += xilfpga/
+cflags-$(CONFIG_MACH_XILFPGA) += -I$(srctree)/arch/mips/include/asm/mach-xilfpga
+load-$(CONFIG_MACH_XILFPGA) += 0xffffffff80100000
diff --git a/arch/mips/xilfpga/init.c b/arch/mips/xilfpga/init.c
new file mode 100644
index 0000000..5348af8
--- /dev/null
+++ b/arch/mips/xilfpga/init.c
@@ -0,0 +1,57 @@
+/*
+ * Xilfpga platform setup
+ *
+ * Copyright (C) 2015 Imagination Technologies
+ * Author: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ */
+
+#include <linux/of_fdt.h>
+#include <linux/of_platform.h>
+
+#include <asm/prom.h>
+
+#define XILFPGA_UART_BASE	0xb0401000
+
+const char *get_system_type(void)
+{
+	return "MIPSFpga";
+}
+
+void __init plat_mem_setup(void)
+{
+	__dt_setup_arch(__dtb_start);
+	strlcpy(arcs_cmdline, boot_command_line, COMMAND_LINE_SIZE);
+}
+
+void __init prom_init(void)
+{
+	setup_8250_early_printk_port(XILFPGA_UART_BASE, 2, 50000);
+}
+
+void __init prom_free_prom_memory(void)
+{
+}
+
+void __init device_tree_init(void)
+{
+	if (!initial_boot_params)
+		return;
+
+	unflatten_and_copy_device_tree();
+}
+
+static int __init plat_of_setup(void)
+{
+	if (!of_have_populated_dt())
+		panic("Device tree not present");
+
+	if (of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL))
+		panic("Failed to populate DT");
+
+	return 0;
+}
+arch_initcall(plat_of_setup);
diff --git a/arch/mips/xilfpga/intc.c b/arch/mips/xilfpga/intc.c
new file mode 100644
index 0000000..919eb97
--- /dev/null
+++ b/arch/mips/xilfpga/intc.c
@@ -0,0 +1,26 @@
+/*
+ * Xilfpga interrupt controller setup
+ *
+ * Copyright (C) 2015 Imagination Technologies
+ * Author: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ */
+
+#include <linux/of.h>
+#include <linux/of_irq.h>
+
+#include <asm/irq_cpu.h>
+
+static struct of_device_id of_irq_ids[] __initdata = {
+	{ .compatible = "mti,cpu-interrupt-controller", .data = mips_cpu_irq_of_init },
+	{},
+};
+
+void __init arch_init_irq(void)
+{
+	of_irq_init(of_irq_ids);
+}
+
diff --git a/arch/mips/xilfpga/time.c b/arch/mips/xilfpga/time.c
new file mode 100644
index 0000000..3f2e39e
--- /dev/null
+++ b/arch/mips/xilfpga/time.c
@@ -0,0 +1,41 @@
+/*
+ * Xilfpga clocksource/timer setup
+ *
+ * Copyright (C) 2015 Imagination Technologies
+ * Author: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/clocksource.h>
+#include <linux/of.h>
+
+#include <asm/time.h>
+
+void __init plat_time_init(void)
+{
+	struct device_node *np;
+	struct clk *clk = 0;
+
+	of_clk_init(NULL);
+	clocksource_of_init();
+
+	np = of_get_cpu_node(0, NULL);
+	if (!np) {
+		pr_err("Failed to get CPU node\n");
+		return;
+	}
+
+	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk)) {
+		pr_err("Failed to get CPU clock: %ld\n", PTR_ERR(clk));
+		return;
+	}
+
+	mips_hpt_frequency = clk_get_rate(clk) / 2;
+	clk_put(clk);
+}
-- 
1.9.1
