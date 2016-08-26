Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2016 16:19:46 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:20490 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992472AbcHZOTPeZ7xn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Aug 2016 16:19:15 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id B2409BCF48186;
        Fri, 26 Aug 2016 15:18:54 +0100 (IST)
Received: from localhost (10.100.200.141) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 26 Aug
 2016 15:18:57 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        <devicetree@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jacek Anaszewski <j.anaszewski@samsung.com>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 02/19] MIPS: SEAD3: Probe interrupt controllers using DT
Date:   Fri, 26 Aug 2016 15:17:34 +0100
Message-ID: <20160826141751.13121-3-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160826141751.13121-1-paul.burton@imgtec.com>
References: <20160826141751.13121-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.141]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54765
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Probe the CPU interrupt controller & optional Global Interrupt
Controller (GIC) using devicetree rather than platform code. Because the
bootloader on SEAD3 does not provide a device tree to the kernel & the
device tree is always built in, we patch out the GIC node during boot if
we detect that a GIC is not present in the system.

The appropriate IRQ domain is discovered by platform code setting up
device IRQ numbers temporarily. It will be removed by further patches
which move the devices towards being probed via device tree.

No behavioural change is intended by this patch.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>

---

Changes in v2:
- #include <linux/errno.h>, thanks kbuild test robot!
- Add missing semicolon, thanks kbuild test robot!

 arch/mips/boot/dts/mti/sead3.dts                | 31 +++++++++
 arch/mips/include/asm/mach-sead3/sead3-dtshim.h | 29 ++++++++
 arch/mips/include/asm/mips-boards/sead3int.h    |  5 --
 arch/mips/mti-sead3/Makefile                    |  1 +
 arch/mips/mti-sead3/sead3-dtshim.c              | 92 +++++++++++++++++++++++++
 arch/mips/mti-sead3/sead3-int.c                 | 27 ++------
 arch/mips/mti-sead3/sead3-platform.c            | 43 +++++++++---
 arch/mips/mti-sead3/sead3-setup.c               | 13 ++--
 8 files changed, 197 insertions(+), 44 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-sead3/sead3-dtshim.h
 create mode 100644 arch/mips/mti-sead3/sead3-dtshim.c

diff --git a/arch/mips/boot/dts/mti/sead3.dts b/arch/mips/boot/dts/mti/sead3.dts
index e4b317d..051b3a9 100644
--- a/arch/mips/boot/dts/mti/sead3.dts
+++ b/arch/mips/boot/dts/mti/sead3.dts
@@ -4,10 +4,13 @@
 /memreserve/ 0x00001000 0x000ef000;	// ROM data
 /memreserve/ 0x000f0000 0x004cc000;	// reserved
 
+#include <dt-bindings/interrupt-controller/mips-gic.h>
+
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
 	compatible = "mti,sead-3";
+	interrupt-parent = <&gic>;
 
 	cpus {
 		cpu@0 {
@@ -19,4 +22,32 @@
 		device_type = "memory";
 		reg = <0x0 0x08000000>;
 	};
+
+	cpu_intc: interrupt-controller {
+		compatible = "mti,cpu-interrupt-controller";
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+	};
+
+	gic: interrupt-controller@1b1c0000 {
+		compatible = "mti,gic";
+		reg = <0x1b1c0000 0x20000>;
+
+		interrupt-controller;
+		#interrupt-cells = <3>;
+
+		/*
+		 * Declare the interrupt-parent even though the mti,gic
+		 * binding doesn't require it, such that the kernel can
+		 * figure out that cpu_intc is the root interrupt
+		 * controller & should be probed first.
+		 */
+		interrupt-parent = <&cpu_intc>;
+
+		timer {
+			compatible = "mti,gic-timer";
+			interrupts = <GIC_LOCAL 1 IRQ_TYPE_NONE>;
+		};
+	};
 };
diff --git a/arch/mips/include/asm/mach-sead3/sead3-dtshim.h b/arch/mips/include/asm/mach-sead3/sead3-dtshim.h
new file mode 100644
index 0000000..f5d7d9c
--- /dev/null
+++ b/arch/mips/include/asm/mach-sead3/sead3-dtshim.h
@@ -0,0 +1,29 @@
+/*
+ * Copyright (C) 2016 Imagination Technologies
+ * Author: Paul Burton <paul.burton@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __MIPS_SEAD3_DTSHIM_H__
+#define __MIPS_SEAD3_DTSHIM_H__
+
+#include <linux/init.h>
+
+#ifdef CONFIG_MIPS_SEAD3
+
+extern void __init *sead3_dt_shim(void *fdt);
+
+#else /* !CONFIG_MIPS_SEAD3 */
+
+static inline void *sead3_dt_shim(void *fdt)
+{
+	return fdt;
+}
+
+#endif /* !CONFIG_MIPS_SEAD3 */
+
+#endif /* __MIPS_SEAD3_DTSHIM_H__ */
diff --git a/arch/mips/include/asm/mips-boards/sead3int.h b/arch/mips/include/asm/mips-boards/sead3int.h
index 8932c7d..bd85da3 100644
--- a/arch/mips/include/asm/mips-boards/sead3int.h
+++ b/arch/mips/include/asm/mips-boards/sead3int.h
@@ -12,12 +12,7 @@
 
 #include <linux/irqchip/mips-gic.h>
 
-/* SEAD-3 GIC address space definitions. */
-#define GIC_BASE_ADDR		0x1b1c0000
-#define GIC_ADDRSPACE_SZ	(128 * 1024)
-
 /* CPU interrupt offsets */
-#define CPU_INT_GIC		2
 #define CPU_INT_EHCI		2
 #define CPU_INT_UART0		4
 #define CPU_INT_UART1		4
diff --git a/arch/mips/mti-sead3/Makefile b/arch/mips/mti-sead3/Makefile
index 8b03cfb..aad67aa 100644
--- a/arch/mips/mti-sead3/Makefile
+++ b/arch/mips/mti-sead3/Makefile
@@ -10,6 +10,7 @@
 #
 obj-y := sead3-lcd.o
 obj-y += sead3-display.o
+obj-y += sead3-dtshim.o
 obj-y += sead3-init.o
 obj-y += sead3-int.o
 obj-y += sead3-platform.o
diff --git a/arch/mips/mti-sead3/sead3-dtshim.c b/arch/mips/mti-sead3/sead3-dtshim.c
new file mode 100644
index 0000000..3283a7e
--- /dev/null
+++ b/arch/mips/mti-sead3/sead3-dtshim.c
@@ -0,0 +1,92 @@
+/*
+ * Copyright (C) 2016 Imagination Technologies
+ * Author: Paul Burton <paul.burton@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+#define pr_fmt(fmt) "sead3-dtshim: " fmt
+
+#include <linux/errno.h>
+#include <linux/libfdt.h>
+#include <linux/printk.h>
+
+#include <asm/io.h>
+
+#define SEAD_CONFIG			CKSEG1ADDR(0x1b100110)
+#define SEAD_CONFIG_GIC_PRESENT		BIT(1)
+
+static unsigned char fdt_buf[16 << 10] __initdata;
+
+static int remove_gic(void *fdt)
+{
+	int gic_off, cpu_off, err;
+	uint32_t cfg, cpu_phandle;
+
+	/* leave the GIC node intact if a GIC is present */
+	cfg = __raw_readl((uint32_t *)SEAD_CONFIG);
+	if (cfg & SEAD_CONFIG_GIC_PRESENT)
+		return 0;
+
+	gic_off = fdt_node_offset_by_compatible(fdt, -1, "mti,gic");
+	if (gic_off < 0) {
+		pr_err("unable to find DT GIC node: %d\n", gic_off);
+		return gic_off;
+	}
+
+	err = fdt_nop_node(fdt, gic_off);
+	if (err) {
+		pr_err("unable to nop GIC node\n");
+		return err;
+	}
+
+	cpu_off = fdt_node_offset_by_compatible(fdt, -1,
+			"mti,cpu-interrupt-controller");
+	if (cpu_off < 0) {
+		pr_err("unable to find CPU intc node: %d\n", cpu_off);
+		return cpu_off;
+	}
+
+	cpu_phandle = fdt_get_phandle(fdt, cpu_off);
+	if (!cpu_phandle) {
+		pr_err("unable to get CPU intc phandle\n");
+		return -EINVAL;
+	}
+
+	err = fdt_setprop_u32(fdt, 0, "interrupt-parent", cpu_phandle);
+	if (err) {
+		pr_err("unable to set root interrupt-parent: %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+void __init *sead3_dt_shim(void *fdt)
+{
+	int err;
+
+	if (fdt_check_header(fdt))
+		panic("Corrupt DT");
+
+	/* if this isn't SEAD3, leave the DT alone */
+	if (fdt_node_check_compatible(fdt, 0, "mti,sead-3"))
+		return fdt;
+
+	err = fdt_open_into(fdt, fdt_buf, sizeof(fdt_buf));
+	if (err)
+		panic("Unable to open FDT: %d", err);
+
+	err = remove_gic(fdt_buf);
+	if (err)
+		panic("Unable to patch FDT: %d", err);
+
+	err = fdt_pack(fdt_buf);
+	if (err)
+		panic("Unable to pack FDT: %d\n", err);
+
+	return fdt_buf;
+}
diff --git a/arch/mips/mti-sead3/sead3-int.c b/arch/mips/mti-sead3/sead3-int.c
index e31e17f..2e6b732 100644
--- a/arch/mips/mti-sead3/sead3-int.c
+++ b/arch/mips/mti-sead3/sead3-int.c
@@ -6,37 +6,18 @@
  * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
  */
 #include <linux/init.h>
-#include <linux/irq.h>
+#include <linux/irqchip.h>
 #include <linux/irqchip/mips-gic.h>
-#include <linux/io.h>
 
-#include <asm/irq_cpu.h>
-#include <asm/setup.h>
-
-#include <asm/mips-boards/sead3int.h>
-
-#define SEAD_CONFIG_GIC_PRESENT_SHF	1
-#define SEAD_CONFIG_GIC_PRESENT_MSK	(1 << SEAD_CONFIG_GIC_PRESENT_SHF)
-#define SEAD_CONFIG_BASE		0x1b100110
-#define SEAD_CONFIG_SIZE		4
-
-static void __iomem *sead3_config_reg;
+#include <asm/cpu-info.h>
+#include <asm/irq.h>
 
 void __init arch_init_irq(void)
 {
-	if (!cpu_has_veic)
-		mips_cpu_irq_init();
+	irqchip_init();
 
-	sead3_config_reg = ioremap_nocache(SEAD_CONFIG_BASE, SEAD_CONFIG_SIZE);
-	gic_present = (__raw_readl(sead3_config_reg) &
-		       SEAD_CONFIG_GIC_PRESENT_MSK) >>
-		SEAD_CONFIG_GIC_PRESENT_SHF;
 	pr_info("GIC: %spresent\n", (gic_present) ? "" : "not ");
 	pr_info("EIC: %s\n",
 		(current_cpu_data.options & MIPS_CPU_VEIC) ?  "on" : "off");
-
-	if (gic_present)
-		gic_init(GIC_BASE_ADDR, GIC_ADDRSPACE_SZ, CPU_INT_GIC,
-			 MIPS_GIC_IRQ_BASE);
 }
 
diff --git a/arch/mips/mti-sead3/sead3-platform.c b/arch/mips/mti-sead3/sead3-platform.c
index 73b73ef..d6be029 100644
--- a/arch/mips/mti-sead3/sead3-platform.c
+++ b/arch/mips/mti-sead3/sead3-platform.c
@@ -9,8 +9,10 @@
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/irqchip/mips-gic.h>
+#include <linux/irqdomain.h>
 #include <linux/leds.h>
 #include <linux/mtd/physmap.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/serial_8250.h>
 #include <linux/smsc911x.h>
@@ -204,16 +206,41 @@ static struct platform_device *sead3_platform_devices[] __initdata = {
 
 static int __init sead3_platforms_device_init(void)
 {
+	const char *intc_compat;
+	struct device_node *node;
+	struct irq_domain *irqd;
+
+	if (gic_present)
+		intc_compat = "mti,gic";
+	else
+		intc_compat = "mti,cpu-interrupt-controller";
+
+	node = of_find_compatible_node(NULL, NULL, intc_compat);
+	if (!node) {
+		pr_err("unable to find interrupt controller DT node\n");
+		return -ENODEV;
+	}
+
+	irqd = irq_find_host(node);
+	if (!irqd) {
+		pr_err("unable to find interrupt controller IRQ domain\n");
+		return -ENODEV;
+	}
+
 	if (gic_present) {
-		uart8250_data[0].irq = MIPS_GIC_IRQ_BASE + GIC_INT_UART0;
-		uart8250_data[1].irq = MIPS_GIC_IRQ_BASE + GIC_INT_UART1;
-		ehci_resources[1].start = MIPS_GIC_IRQ_BASE + GIC_INT_EHCI;
-		sead3_net_resources[1].start = MIPS_GIC_IRQ_BASE + GIC_INT_NET;
+		uart8250_data[0].irq = irq_create_mapping(irqd, GIC_INT_UART0);
+		uart8250_data[1].irq = irq_create_mapping(irqd, GIC_INT_UART1);
+		ehci_resources[1].start =
+			irq_create_mapping(irqd, GIC_INT_EHCI);
+		sead3_net_resources[1].start =
+			irq_create_mapping(irqd, GIC_INT_NET);
 	} else {
-		uart8250_data[0].irq = MIPS_CPU_IRQ_BASE + CPU_INT_UART0;
-		uart8250_data[1].irq = MIPS_CPU_IRQ_BASE + CPU_INT_UART1;
-		ehci_resources[1].start = MIPS_CPU_IRQ_BASE + CPU_INT_EHCI;
-		sead3_net_resources[1].start = MIPS_CPU_IRQ_BASE + CPU_INT_NET;
+		uart8250_data[0].irq = irq_create_mapping(irqd, CPU_INT_UART0);
+		uart8250_data[1].irq = irq_create_mapping(irqd, CPU_INT_UART1);
+		ehci_resources[1].start =
+			irq_create_mapping(irqd, CPU_INT_EHCI);
+		sead3_net_resources[1].start =
+			irq_create_mapping(irqd, CPU_INT_NET);
 	}
 
 	return platform_add_devices(sead3_platform_devices,
diff --git a/arch/mips/mti-sead3/sead3-setup.c b/arch/mips/mti-sead3/sead3-setup.c
index edfcaf0..c4fc0c6 100644
--- a/arch/mips/mti-sead3/sead3-setup.c
+++ b/arch/mips/mti-sead3/sead3-setup.c
@@ -13,6 +13,7 @@
 #include <asm/prom.h>
 #include <asm/fw/fw.h>
 
+#include <asm/mach-sead3/sead3-dtshim.h>
 #include <asm/mips-boards/generic.h>
 
 const char *get_system_type(void)
@@ -89,20 +90,16 @@ void __init *plat_get_fdt(void)
 
 void __init plat_mem_setup(void)
 {
+	void *fdt = plat_get_fdt();
+
 	/* allow command line/bootloader env to override memory size in DT */
 	parse_memsize_param();
 
-	/*
-	 * Load the builtin devicetree. This causes the chosen node to be
-	 * parsed resulting in our memory appearing
-	 */
-	__dt_setup_arch(__dtb_start);
+	fdt = sead3_dt_shim(fdt);
+	__dt_setup_arch(fdt);
 }
 
 void __init device_tree_init(void)
 {
-	if (!initial_boot_params)
-		return;
-
 	unflatten_and_copy_device_tree();
 }
-- 
2.9.3
