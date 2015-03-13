Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Mar 2015 23:55:28 +0100 (CET)
Received: from mail-qc0-f201.google.com ([209.85.216.201]:34305 "EHLO
        mail-qc0-f201.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013736AbbCMWyUElhwF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Mar 2015 23:54:20 +0100
Received: by qcvp6 with SMTP id p6so4333111qcv.1
        for <linux-mips@linux-mips.org>; Fri, 13 Mar 2015 15:54:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DIkWkqbeDt8UCrQ93SfG4adHGSbPEdtCgAS8peat/TQ=;
        b=RxGMJAVanwlakaG7Y4IaHm2NqwMDUrxrZWLhVrZihuhxmbfAV++yzAE6FB2MsHWbHq
         58u4S3C+MDoWC7xcNbJKNFdu+BgYz1nDqe1L3AW+SYjAKWHBeXqiKl+BNNHdQuLv1OIB
         eGi01wgs2P0fexVTKvxEagUh5snxYTDEuHzUKbN4B/ETqJ6VQ+lq4gSY3NuDhGFH6Nar
         rgKqyJ4heEyZKQrH5HMqhzE9lTL7ubwWp3oeQ8c/J9P0NQNv2YBECC32i4g9JSbxVIYx
         BY8t2vnINNiB6QSPl/ql0Zf4aluoXQGGJVmQOdfIJzdwzrWyEqazr9DEuXynIjnRvdj/
         55rA==
X-Gm-Message-State: ALoCoQk7wzl+Jh4Sozz6M09izIkmSGlbjuYbOuy3wLdH0FyzwJ9w4sBMJ7sQvE56XNxOgogtKuIK
X-Received: by 10.236.70.234 with SMTP id p70mr49947628yhd.56.1426287254722;
        Fri, 13 Mar 2015 15:54:14 -0700 (PDT)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id l42si192477yhq.1.2015.03.13.15.54.14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Mar 2015 15:54:14 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id 2dE2lyIw.2; Fri, 13 Mar 2015 15:54:14 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id D734E22038B; Fri, 13 Mar 2015 15:54:13 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Andrew Bresticker <abrestic@chromium.org>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>
Subject: [PATCH V2 4/5] MIPS: Add support for the IMG Pistachio SoC
Date:   Fri, 13 Mar 2015 15:54:08 -0700
Message-Id: <1426287249-27185-5-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.2.0.rc0.207.ga3a616c
In-Reply-To: <1426287249-27185-1-git-send-email-abrestic@chromium.org>
References: <1426287249-27185-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46383
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

Add initial support for boards based on the Imagination Pistachio SoC.
Pistachio is based on a dual-core MIPS interAptiv CPU and will boot
using device-tree.

Signed-off-by: James Hartley <james.hartley@imgtec.com>
Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
Changes from v1:
 - switched to MIPS UHI hand-off protocol
---
 arch/mips/Kbuild.platforms                  |   1 +
 arch/mips/Kconfig                           |  27 ++++++
 arch/mips/include/asm/mach-pistachio/gpio.h |  21 +++++
 arch/mips/include/asm/mach-pistachio/irq.h  |  18 ++++
 arch/mips/pistachio/Makefile                |   1 +
 arch/mips/pistachio/Platform                |   8 ++
 arch/mips/pistachio/init.c                  | 131 ++++++++++++++++++++++++++++
 arch/mips/pistachio/irq.c                   |  28 ++++++
 arch/mips/pistachio/time.c                  |  52 +++++++++++
 9 files changed, 287 insertions(+)
 create mode 100644 arch/mips/include/asm/mach-pistachio/gpio.h
 create mode 100644 arch/mips/include/asm/mach-pistachio/irq.h
 create mode 100644 arch/mips/pistachio/Makefile
 create mode 100644 arch/mips/pistachio/Platform
 create mode 100644 arch/mips/pistachio/init.c
 create mode 100644 arch/mips/pistachio/irq.c
 create mode 100644 arch/mips/pistachio/time.c

diff --git a/arch/mips/Kbuild.platforms b/arch/mips/Kbuild.platforms
index e5fc463..2298baa 100644
--- a/arch/mips/Kbuild.platforms
+++ b/arch/mips/Kbuild.platforms
@@ -23,6 +23,7 @@ platforms += netlogic
 platforms += paravirt
 platforms += pmcs-msp71xx
 platforms += pnx833x
+platforms += pistachio
 platforms += ralink
 platforms += rb532
 platforms += sgi-ip22
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index c7a1690..343b238 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -352,6 +352,33 @@ config MACH_LOONGSON1
 	  the ICT (Institute of Computing Technology) and the Chinese Academy
 	  of Sciences.
 
+config MACH_PISTACHIO
+	bool "IMG Pistachio SoC based boards"
+	select ARCH_REQUIRE_GPIOLIB
+	select BOOT_ELF32
+	select BOOT_RAW
+	select CEVT_R4K
+	select CLKSRC_MIPS_GIC
+	select COMMON_CLK
+	select CSRC_R4K
+	select DMA_MAYBE_COHERENT
+	select IRQ_CPU
+	select LIBFDT
+	select MFD_SYSCON
+	select MIPS_CPU_SCACHE
+	select MIPS_GIC
+	select PINCTRL
+	select REGULATOR
+	select SYS_HAS_CPU_MIPS32_R2
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SYS_SUPPORTS_MIPS_CPS
+	select SYS_SUPPORTS_MULTITHREADING
+	select SYS_SUPPORTS_ZBOOT
+	select USE_OF
+	help
+	  This enables support for the IMG Pistachio SoC platform.
+
 config MIPS_MALTA
 	bool "MIPS Malta board"
 	select ARCH_MAY_HAVE_PC_FDC
diff --git a/arch/mips/include/asm/mach-pistachio/gpio.h b/arch/mips/include/asm/mach-pistachio/gpio.h
new file mode 100644
index 0000000..6c1649c
--- /dev/null
+++ b/arch/mips/include/asm/mach-pistachio/gpio.h
@@ -0,0 +1,21 @@
+/*
+ * Pistachio IRQ setup
+ *
+ * Copyright (C) 2014 Google, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ */
+
+#ifndef __ASM_MACH_PISTACHIO_GPIO_H
+#define __ASM_MACH_PISTACHIO_GPIO_H
+
+#include <asm-generic/gpio.h>
+
+#define gpio_get_value	__gpio_get_value
+#define gpio_set_value	__gpio_set_value
+#define gpio_cansleep	__gpio_cansleep
+#define gpio_to_irq	__gpio_to_irq
+
+#endif /* __ASM_MACH_PISTACHIO_GPIO_H */
diff --git a/arch/mips/include/asm/mach-pistachio/irq.h b/arch/mips/include/asm/mach-pistachio/irq.h
new file mode 100644
index 0000000..b94a09a
--- /dev/null
+++ b/arch/mips/include/asm/mach-pistachio/irq.h
@@ -0,0 +1,18 @@
+/*
+ * Pistachio IRQ setup
+ *
+ * Copyright (C) 2014 Google, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ */
+
+#ifndef __ASM_MACH_PISTACHIO_IRQ_H
+#define __ASM_MACH_PISTACHIO_IRQ_H
+
+#define NR_IRQS 256
+
+#include_next <irq.h>
+
+#endif /* __ASM_MACH_PISTACHIO_IRQ_H */
diff --git a/arch/mips/pistachio/Makefile b/arch/mips/pistachio/Makefile
new file mode 100644
index 0000000..32189c6
--- /dev/null
+++ b/arch/mips/pistachio/Makefile
@@ -0,0 +1 @@
+obj-y	+= init.o irq.o time.o
diff --git a/arch/mips/pistachio/Platform b/arch/mips/pistachio/Platform
new file mode 100644
index 0000000..d80cd61
--- /dev/null
+++ b/arch/mips/pistachio/Platform
@@ -0,0 +1,8 @@
+#
+# IMG Pistachio SoC
+#
+platform-$(CONFIG_MACH_PISTACHIO)	+= pistachio/
+cflags-$(CONFIG_MACH_PISTACHIO)		+=				\
+		-I$(srctree)/arch/mips/include/asm/mach-pistachio
+load-$(CONFIG_MACH_PISTACHIO)		+= 0xffffffff80400000
+zload-$(CONFIG_MACH_PISTACHIO)		+= 0xffffffff81000000
diff --git a/arch/mips/pistachio/init.c b/arch/mips/pistachio/init.c
new file mode 100644
index 0000000..6b297d5
--- /dev/null
+++ b/arch/mips/pistachio/init.c
@@ -0,0 +1,131 @@
+/*
+ * Pistachio platform setup
+ *
+ * Copyright (C) 2014 Google, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/of_address.h>
+#include <linux/of_fdt.h>
+#include <linux/of_platform.h>
+
+#include <asm/cacheflush.h>
+#include <asm/dma-coherence.h>
+#include <asm/fw/fw.h>
+#include <asm/mips-boards/generic.h>
+#include <asm/mips-cm.h>
+#include <asm/mips-cpc.h>
+#include <asm/prom.h>
+#include <asm/smp-ops.h>
+#include <asm/traps.h>
+
+const char *get_system_type(void)
+{
+	return "IMG Pistachio SoC";
+}
+
+static void __init plat_setup_iocoherency(void)
+{
+	/*
+	 * Kernel has been configured with software coherency
+	 * but we might choose to turn it off and use hardware
+	 * coherency instead.
+	 */
+	if (mips_cm_numiocu() != 0) {
+		/* Nothing special needs to be done to enable coherency */
+		pr_info("CMP IOCU detected\n");
+		hw_coherentio = 1;
+		if (coherentio == 0)
+			pr_info("Hardware DMA cache coherency disabled\n");
+		else
+			pr_info("Hardware DMA cache coherency enabled\n");
+	} else {
+		if (coherentio == 1)
+			pr_info("Hardware DMA cache coherency unsupported, but enabled from command line!\n");
+		else
+			pr_info("Software DMA cache coherency enabled\n");
+	}
+}
+
+void __init plat_mem_setup(void)
+{
+	if (fw_arg0 != -2)
+		panic("Device-tree not present");
+
+	__dt_setup_arch((void *)fw_arg1);
+	strlcpy(arcs_cmdline, boot_command_line, COMMAND_LINE_SIZE);
+
+	plat_setup_iocoherency();
+}
+
+#define DEFAULT_CPC_BASE_ADDR 0x1bde0000
+
+phys_addr_t mips_cpc_default_phys_base(void)
+{
+	return DEFAULT_CPC_BASE_ADDR;
+}
+
+static void __init mips_nmi_setup(void)
+{
+	void *base;
+	extern char except_vec_nmi;
+
+	base = cpu_has_veic ?
+		(void *)(CAC_BASE + 0xa80) :
+		(void *)(CAC_BASE + 0x380);
+	memcpy(base, &except_vec_nmi, 0x80);
+	flush_icache_range((unsigned long)base,
+			   (unsigned long)base + 0x80);
+}
+
+static void __init mips_ejtag_setup(void)
+{
+	void *base;
+	extern char except_vec_ejtag_debug;
+
+	base = cpu_has_veic ?
+		(void *)(CAC_BASE + 0xa00) :
+		(void *)(CAC_BASE + 0x300);
+	memcpy(base, &except_vec_ejtag_debug, 0x80);
+	flush_icache_range((unsigned long)base,
+			   (unsigned long)base + 0x80);
+}
+
+void __init prom_init(void)
+{
+	board_nmi_handler_setup = mips_nmi_setup;
+	board_ejtag_handler_setup = mips_ejtag_setup;
+
+	mips_cm_probe();
+	mips_cpc_probe();
+	register_cps_smp_ops();
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
+		panic("Failed to populate DT\n");
+
+	return 0;
+}
+arch_initcall(plat_of_setup);
diff --git a/arch/mips/pistachio/irq.c b/arch/mips/pistachio/irq.c
new file mode 100644
index 0000000..0a6b24c
--- /dev/null
+++ b/arch/mips/pistachio/irq.c
@@ -0,0 +1,28 @@
+/*
+ * Pistachio IRQ setup
+ *
+ * Copyright (C) 2014 Google, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/mips-gic.h>
+#include <linux/kernel.h>
+
+#include <asm/cpu-features.h>
+#include <asm/irq_cpu.h>
+
+void __init arch_init_irq(void)
+{
+	pr_info("EIC is %s\n", cpu_has_veic ? "on" : "off");
+	pr_info("VINT is %s\n", cpu_has_vint ? "on" : "off");
+
+	if (!cpu_has_veic)
+		mips_cpu_irq_init();
+
+	irqchip_init();
+}
diff --git a/arch/mips/pistachio/time.c b/arch/mips/pistachio/time.c
new file mode 100644
index 0000000..67889fc
--- /dev/null
+++ b/arch/mips/pistachio/time.c
@@ -0,0 +1,52 @@
+/*
+ * Pistachio clocksource/timer setup
+ *
+ * Copyright (C) 2014 Google, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/clocksource.h>
+#include <linux/init.h>
+#include <linux/irqchip/mips-gic.h>
+#include <linux/of.h>
+
+#include <asm/time.h>
+
+unsigned int get_c0_compare_int(void)
+{
+	return gic_get_c0_compare_int();
+}
+
+int get_c0_perfcount_int(void)
+{
+	return gic_get_c0_perfcount_int();
+}
+
+void __init plat_time_init(void)
+{
+	struct device_node *np;
+	struct clk *clk;
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
2.2.0.rc0.207.ga3a616c
