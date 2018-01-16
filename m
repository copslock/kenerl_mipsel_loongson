Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jan 2018 11:15:04 +0100 (CET)
Received: from mail.free-electrons.com ([62.4.15.54]:60499 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994627AbeAPKNFbzdTs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Jan 2018 11:13:05 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 3DFF3208C1; Tue, 16 Jan 2018 11:12:59 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 0A9B9208C2;
        Tue, 16 Jan 2018 11:12:49 +0100 (CET)
From:   Alexandre Belloni <alexandre.belloni@free-electrons.com>
To:     James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH v3 4/8] MIPS: mscc: Add initial support for Microsemi MIPS SoCs
Date:   Tue, 16 Jan 2018 11:12:36 +0100
Message-Id: <20180116101240.5393-5-alexandre.belloni@free-electrons.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180116101240.5393-1-alexandre.belloni@free-electrons.com>
References: <20180116101240.5393-1-alexandre.belloni@free-electrons.com>
Return-Path: <alexandre.belloni@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62166
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@free-electrons.com
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

Introduce support for the MIPS based Microsemi Ocelot SoCs.
As the plan is to have all SoCs supported only using device tree, the
mach directory is simply called mscc.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/mips/Kbuild.platforms |   1 +
 arch/mips/Kconfig          |  24 ++++++++++
 arch/mips/mscc/Makefile    |  11 +++++
 arch/mips/mscc/Platform    |  12 +++++
 arch/mips/mscc/setup.c     | 106 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 154 insertions(+)
 create mode 100644 arch/mips/mscc/Makefile
 create mode 100644 arch/mips/mscc/Platform
 create mode 100644 arch/mips/mscc/setup.c

diff --git a/arch/mips/Kbuild.platforms b/arch/mips/Kbuild.platforms
index ac7ad54f984f..b3b2f8dc91db 100644
--- a/arch/mips/Kbuild.platforms
+++ b/arch/mips/Kbuild.platforms
@@ -18,6 +18,7 @@ platforms += lantiq
 platforms += lasat
 platforms += loongson32
 platforms += loongson64
+platforms += mscc
 platforms += mti-malta
 platforms += netlogic
 platforms += paravirt
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 350a990fc719..a9db028a0338 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -527,6 +527,30 @@ config MIPS_MALTA
 	  This enables support for the MIPS Technologies Malta evaluation
 	  board.
 
+config MSCC_OCELOT
+	bool "Microsemi Ocelot architecture"
+	select BOOT_RAW
+	select CEVT_R4K
+	select CSRC_R4K
+	select IRQ_MIPS_CPU
+	select DMA_NONCOHERENT
+	select SYS_HAS_CPU_MIPS32_R2
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_BIG_ENDIAN
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SYS_HAS_EARLY_PRINTK
+	select USE_GENERIC_EARLY_PRINTK_8250
+	select MSCC_OCELOT_IRQ
+	select PINCTRL
+	select GPIOLIB
+	select COMMON_CLK
+	select USE_OF
+	select BUILTIN_DTB
+	select LIBFDT
+	help
+	  This enables support for the Microsemi Ocelot architecture.
+	  It builds a generic DT-based kernel image.
+
 config MACH_PIC32
 	bool "Microchip PIC32 Family"
 	help
diff --git a/arch/mips/mscc/Makefile b/arch/mips/mscc/Makefile
new file mode 100644
index 000000000000..c96b13546730
--- /dev/null
+++ b/arch/mips/mscc/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: (GPL-2.0 OR MIT)
+#
+# Microsemi MIPS SoC support
+#
+# License: Dual MIT/GPL
+# Copyright (c) 2017 Microsemi Corporation
+
+#
+# Makefile for the Microsemi MIPS SoCs
+#
+obj-y := setup.o
diff --git a/arch/mips/mscc/Platform b/arch/mips/mscc/Platform
new file mode 100644
index 000000000000..9ae874c8f136
--- /dev/null
+++ b/arch/mips/mscc/Platform
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: (GPL-2.0 OR MIT)
+#
+# Microsemi MIPS SoC support
+#
+# License: Dual MIT/GPL
+# Copyright (c) 2017 Microsemi Corporation
+
+#
+# Microsemi Ocelot board(s)
+#
+platform-$(CONFIG_MSCC_OCELOT) += mscc/
+load-$(CONFIG_MSCC_OCELOT)	 += 0x80100000
diff --git a/arch/mips/mscc/setup.c b/arch/mips/mscc/setup.c
new file mode 100644
index 000000000000..77803edd7bfd
--- /dev/null
+++ b/arch/mips/mscc/setup.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Microsemi MIPS SoC support
+ *
+ * License: Dual MIT/GPL
+ * Copyright (c) 2017 Microsemi Corporation
+ */
+#include <linux/delay.h>
+#include <linux/export.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/libfdt.h>
+#include <linux/of_fdt.h>
+#include <linux/of_platform.h>
+#include <linux/reboot.h>
+
+#include <asm/time.h>
+#include <asm/idle.h>
+#include <asm/prom.h>
+#include <asm/reboot.h>
+
+static void __init ocelot_earlyprintk_init(void)
+{
+	void __iomem *uart_base;
+
+	uart_base = ioremap_nocache(0x70100000, 0x0f);
+	setup_8250_early_printk_port((unsigned long)uart_base, 2, 50000);
+}
+
+void __init prom_init(void)
+{
+	/* Sanity check for defunct bootloader */
+	if (fw_arg0 < 10 && (fw_arg1 & 0xFFF00000) == 0x80000000) {
+		unsigned int prom_argc = fw_arg0;
+		const char **prom_argv = (const char **)fw_arg1;
+
+		if (prom_argc > 1 && strlen(prom_argv[1]) > 0)
+			/* ignore all built-in args if any f/w args given */
+			strcpy(arcs_cmdline, prom_argv[1]);
+	}
+}
+
+void __init prom_free_prom_memory(void)
+{
+}
+
+unsigned int get_c0_compare_int(void)
+{
+	return CP0_LEGACY_COMPARE_IRQ;
+}
+
+void __init plat_time_init(void)
+{
+	struct device_node *np;
+	u32 freq;
+
+	np = of_find_node_by_name(NULL, "cpus");
+	if (!np)
+		panic("missing 'cpus' DT node");
+	if (of_property_read_u32(np, "mips-hpt-frequency", &freq) < 0)
+		panic("missing 'mips-hpt-frequency' property");
+	of_node_put(np);
+
+	mips_hpt_frequency = freq;
+}
+
+void __init arch_init_irq(void)
+{
+	irqchip_init();
+}
+
+const char *get_system_type(void)
+{
+	return "Microsemi Ocelot";
+}
+
+static void __init ocelot_late_init(void)
+{
+	ocelot_earlyprintk_init();
+}
+
+extern void (*late_time_init)(void);
+
+void __init plat_mem_setup(void)
+{
+	/* This has to be done so late because ioremap needs to work */
+	late_time_init = ocelot_late_init;
+
+	__dt_setup_arch(__dtb_start);
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
+static int __init populate_machine(void)
+{
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	return 0;
+}
+arch_initcall(populate_machine);
-- 
2.15.1
