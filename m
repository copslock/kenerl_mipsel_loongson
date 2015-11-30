Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2015 17:31:18 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:40777 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008058AbbK3Q3M5uR1e (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Nov 2015 17:29:12 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 45BFBF16EA927;
        Mon, 30 Nov 2015 16:29:03 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Mon, 30 Nov 2015 16:29:06 +0000
Received: from localhost (10.100.200.236) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 30 Nov
 2015 16:29:04 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>, Tejun Heo <tj@kernel.org>,
        "Joe Perches" <joe@perches.com>, Jiri Slaby <jslaby@suse.com>,
        "Mauro Carvalho Chehab" <mchehab@osg.samsung.com>,
        <linux-kernel@vger.kernel.org>,
        "Andrew Bresticker" <abrestic@chromium.org>,
        Kumar Gala <galak@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 28/28] MIPS: Boston board support
Date:   Mon, 30 Nov 2015 16:21:53 +0000
Message-ID: <1448900513-20856-29-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com>
References: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.236]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50209
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

Add support for the MIPS Boston development board. Boston is an
FPGA-based development board akin to the much older Malta board. As such
it's very configurable, but in broad terms it's built around a Xilinx
FPGA running a MIPS core & other logic, and 3 Xilinx PCIe root ports -
one of which is connected to an Intel EG20T Platform Controller Hub to
provide a base set of peripherals.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 MAINTAINERS                                        |   3 +
 arch/mips/Kbuild.platforms                         |   1 +
 arch/mips/Kconfig                                  |  39 ++++
 arch/mips/boot/dts/Makefile                        |   1 +
 arch/mips/boot/dts/img/Makefile                    |   7 +
 arch/mips/boot/dts/img/boston.dts                  | 201 +++++++++++++++++++++
 arch/mips/boston/Makefile                          |  12 ++
 arch/mips/boston/Platform                          |   8 +
 arch/mips/boston/init.c                            |  75 ++++++++
 arch/mips/boston/int.c                             |  33 ++++
 arch/mips/boston/time.c                            |  89 +++++++++
 arch/mips/boston/vmlinux.its                       |  23 +++
 arch/mips/configs/boston_defconfig                 | 170 +++++++++++++++++
 .../asm/mach-boston/cpu-feature-overrides.h        |  26 +++
 arch/mips/include/asm/mach-boston/irq.h            |  18 ++
 arch/mips/include/asm/mach-boston/spaces.h         |  20 ++
 16 files changed, 726 insertions(+)
 create mode 100644 arch/mips/boot/dts/img/Makefile
 create mode 100644 arch/mips/boot/dts/img/boston.dts
 create mode 100644 arch/mips/boston/Makefile
 create mode 100644 arch/mips/boston/Platform
 create mode 100644 arch/mips/boston/init.c
 create mode 100644 arch/mips/boston/int.c
 create mode 100644 arch/mips/boston/time.c
 create mode 100644 arch/mips/boston/vmlinux.its
 create mode 100644 arch/mips/configs/boston_defconfig
 create mode 100644 arch/mips/include/asm/mach-boston/cpu-feature-overrides.h
 create mode 100644 arch/mips/include/asm/mach-boston/irq.h
 create mode 100644 arch/mips/include/asm/mach-boston/spaces.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a9cd996..a1e7f8f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5438,6 +5438,9 @@ F:	security/integrity/ima/
 IMGTEC BOSTON PLATFORM SUPPORT
 M:	Paul Burton <paul.burton@imgtec.com>
 S:	Maintained
+F:	arch/mips/boot/dts/img/boston.dts
+F:	arch/mips/boston/
+F:	arch/mips/include/asm/mach-boston/
 F:	Documentation/devicetree/bindings/mips/img/boston.txt
 
 IMGTEC IR DECODER DRIVER
diff --git a/arch/mips/Kbuild.platforms b/arch/mips/Kbuild.platforms
index a96c81d..b1ab69a 100644
--- a/arch/mips/Kbuild.platforms
+++ b/arch/mips/Kbuild.platforms
@@ -7,6 +7,7 @@ platforms += ath79
 platforms += bcm47xx
 platforms += bcm63xx
 platforms += bmips
+platforms += boston
 platforms += cavium-octeon
 platforms += cobalt
 platforms += dec
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 6d11a41..74b4d19 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -216,6 +216,45 @@ config BCM63XX
 	help
 	 Support for BCM63XX based boards
 
+config BOSTON
+	bool "MIPS Boston board"
+	select ARCH_REQUIRE_GPIOLIB
+	select BOOT_ELF32
+	select BOOT_RAW
+	select BUILTIN_DTB
+	select CEVT_R4K
+	select COMMON_CLK
+	select CSRC_R4K
+	select DMA_NONCOHERENT
+	select HW_HAS_PCI
+	select IRQ_MIPS_CPU
+	select MIPS_CPU_SCACHE
+	select MIPS_GENERIC_PCI
+	select MIPS_GIC
+	select MIPS_L1_CACHE_SHIFT_6
+	select SYS_HAS_CPU_MIPS32_R1
+	select SYS_HAS_CPU_MIPS32_R2
+	select SYS_HAS_CPU_MIPS32_R3_5
+	select SYS_HAS_CPU_MIPS32_R5
+	select SYS_HAS_CPU_MIPS32_R6
+	select SYS_HAS_CPU_MIPS64_R1
+	select SYS_HAS_CPU_MIPS64_R2
+	select SYS_HAS_CPU_MIPS64_R6
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_64BIT_KERNEL
+	select SYS_SUPPORTS_BIG_ENDIAN
+	select SYS_SUPPORTS_HIGHMEM
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SYS_SUPPORTS_MIPS_CPS
+	select SYS_SUPPORTS_MULTITHREADING
+	select SYS_SUPPORTS_ZBOOT
+	select USE_OF
+	help
+	  This enables support for the MIPS Boston development board from
+	  Imagination Technologies. Boston is an FPGA-based development
+	  board aimed at evaluating MIPS CPUs & developing software for
+	  them. If you wish to build for such a board, select this.
+
 config MIPS_COBALT
 	bool "Cobalt Server"
 	select CEVT_R4K
diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
index a0bf516..a41417b 100644
--- a/arch/mips/boot/dts/Makefile
+++ b/arch/mips/boot/dts/Makefile
@@ -1,5 +1,6 @@
 dts-dirs	+= brcm
 dts-dirs	+= cavium-octeon
+dts-dirs	+= img
 dts-dirs	+= ingenic
 dts-dirs	+= lantiq
 dts-dirs	+= mti
diff --git a/arch/mips/boot/dts/img/Makefile b/arch/mips/boot/dts/img/Makefile
new file mode 100644
index 0000000..6cc1737
--- /dev/null
+++ b/arch/mips/boot/dts/img/Makefile
@@ -0,0 +1,7 @@
+dtb-$(CONFIG_BOSTON)		+= boston.dtb
+
+# Force kbuild to make empty built-in.o if necessary
+obj-				+= dummy.o
+
+always				:= $(dtb-y)
+clean-files			:= *.dtb *.dtb.S
diff --git a/arch/mips/boot/dts/img/boston.dts b/arch/mips/boot/dts/img/boston.dts
new file mode 100644
index 0000000..1104a68
--- /dev/null
+++ b/arch/mips/boot/dts/img/boston.dts
@@ -0,0 +1,201 @@
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/mips-gic.h>
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "img,boston";
+
+	chosen {
+		stdout-path = &uart0;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			device_type = "cpu";
+			compatible = "img,mips";
+			reg = <0>;
+			clocks = <&clk_sys>;
+		};
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00000000 0x10000000>;
+	};
+
+	clk_sys: clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <10000000>;
+	};
+
+	axi4 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <>;
+
+		gic: interrupt-controller {
+			compatible = "mti,gic";
+
+			interrupt-controller;
+			#interrupt-cells = <3>;
+
+			timer {
+				compatible = "mti,gic-timer";
+				interrupts = <GIC_LOCAL 1 IRQ_TYPE_NONE>;
+				clocks = <&clk_sys>;
+			};
+		};
+
+		uart0: uart@17ffe000 {
+			compatible = "ns16550a";
+			reg = <0x17ffe000 0x1000>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SHARED 3 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&clk_sys>;
+		};
+
+		lcd: lcd@17fff000 {
+			compatible = "img,boston-lcd";
+			reg = <0x17fff000 0x8>;
+		};
+
+		pci0: pci@10000000 {
+			compatible = "xlnx,axi-pcie-host-1.00.a";
+			device_type = "pci";
+			reg = <0x10000000 0x2000000>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SHARED 2 IRQ_TYPE_LEVEL_HIGH>;
+
+			ranges = <0x02000000 0 0x40000000 0x40000000 0 0x40000000>;
+
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &pci0_intc 0>,
+					<0 0 0 2 &pci0_intc 1>,
+					<0 0 0 3 &pci0_intc 2>,
+					<0 0 0 4 &pci0_intc 3>;
+
+			pci0_intc: interrupt-controller {
+				interrupt-controller;
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		pci1: pci@12000000 {
+			compatible = "xlnx,axi-pcie-host-1.00.a";
+			device_type = "pci";
+			reg = <0x12000000 0x2000000>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SHARED 1 IRQ_TYPE_LEVEL_HIGH>;
+
+			ranges = <0x02000000 0 0x20000000 0x20000000 0 0x20000000>;
+
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &pci1_intc 0>,
+					<0 0 0 2 &pci1_intc 1>,
+					<0 0 0 3 &pci1_intc 2>,
+					<0 0 0 4 &pci1_intc 3>;
+
+			pci1_intc: interrupt-controller {
+				interrupt-controller;
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		pci2: pci@14000000 {
+			compatible = "xlnx,axi-pcie-host-1.00.a";
+			device_type = "pci";
+			reg = <0x14000000 0x2000000>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SHARED 0 IRQ_TYPE_LEVEL_HIGH>;
+
+			ranges = <0x02000000 0 0x16000000 0x16000000 0 0x100000>;
+
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &pci2_intc 0>,
+					<0 0 0 2 &pci2_intc 1>,
+					<0 0 0 3 &pci2_intc 2>,
+					<0 0 0 4 &pci2_intc 3>;
+
+			pci2_intc: interrupt-controller {
+				interrupt-controller;
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+			};
+
+			pci2_root@0,0,0 {
+				compatible = "pci10ee,7021";
+				reg = <0x00000000 0 0 0 0>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+
+				eg20t_bridge@1,0,0 {
+					compatible = "pci8086,8800";
+					reg = <0x00010000 0 0 0 0>;
+
+					#address-cells = <3>;
+					#size-cells = <2>;
+					#interrupt-cells = <1>;
+
+					eg20t_mac@2,0,1 {
+						compatible = "pci8086,8802";
+						reg = <0x00020100 0 0 0 0>;
+						phy-reset-gpios = <&eg20t_gpio 6 GPIO_ACTIVE_LOW>;
+					};
+
+					eg20t_gpio: eg20t_gpio@2,0,2 {
+						compatible = "pci8086,8803";
+						reg = <0x00020200 0 0 0 0>;
+
+						gpio-controller;
+						#gpio-cells = <2>;
+					};
+
+					eg20t_i2c@2,12,2 {
+						compatible = "pci8086,8817";
+						reg = <0x00026200 0 0 0 0>;
+
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						rtc@0x68 {
+							compatible = "st,m41t81s";
+							reg = <0x68>;
+						};
+					};
+				};
+			};
+		};
+	};
+};
diff --git a/arch/mips/boston/Makefile b/arch/mips/boston/Makefile
new file mode 100644
index 0000000..0a13246
--- /dev/null
+++ b/arch/mips/boston/Makefile
@@ -0,0 +1,12 @@
+#
+# Copyright (C) 2015 Imagination Technologies
+# Author: Paul Burton <paul.burton@imgtec.com>
+#
+# This program is free software; you can redistribute it and/or modify it
+# under the terms of the GNU General Public License as published by the
+# Free Software Foundation; either version 2 of the License, or (at your
+# option) any later version.
+#
+obj-y	+= init.o
+obj-y	+= int.o
+obj-y	+= time.o
diff --git a/arch/mips/boston/Platform b/arch/mips/boston/Platform
new file mode 100644
index 0000000..d3dad1e
--- /dev/null
+++ b/arch/mips/boston/Platform
@@ -0,0 +1,8 @@
+#
+# MIPS Boston board
+#
+platform-$(CONFIG_BOSTON)	+= boston/
+cflags-$(CONFIG_BOSTON)		+= -I$(srctree)/arch/mips/include/asm/mach-boston
+load-$(CONFIG_BOSTON)		+= 0xffffffff80100000
+all-$(CONFIG_BOSTON)		:= $(COMPRESSION_FNAME).bin
+its-$(CONFIG_BOSTON)		+= boston/vmlinux.its
diff --git a/arch/mips/boston/init.c b/arch/mips/boston/init.c
new file mode 100644
index 0000000..4bab5ba
--- /dev/null
+++ b/arch/mips/boston/init.c
@@ -0,0 +1,75 @@
+/*
+ * Copyright (C) 2015 Imagination Technologies
+ * Author: Paul Burton <paul.burton@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/of_fdt.h>
+#include <linux/of_platform.h>
+#include <linux/string.h>
+
+#include <asm/fw/fw.h>
+#include <asm/mips-cm.h>
+#include <asm/mips-cpc.h>
+#include <asm/prom.h>
+#include <asm/smp-ops.h>
+
+void __init plat_mem_setup(void)
+{
+	if (fw_arg0 != -2)
+		panic("Device-tree not present");
+
+	__dt_setup_arch((void *)fw_arg1);
+	strlcpy(arcs_cmdline, boot_command_line, COMMAND_LINE_SIZE);
+}
+
+void __init device_tree_init(void)
+{
+	unflatten_and_copy_device_tree();
+}
+
+static int __init publish_devices(void)
+{
+	if (!of_have_populated_dt())
+		panic("Device-tree not present");
+
+	if (of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL))
+		panic("Failed to populate DT");
+
+	return 0;
+}
+arch_initcall(publish_devices);
+
+phys_addr_t mips_cpc_default_phys_base(void)
+{
+	return 0x16200000;
+}
+
+phys_addr_t mips_cdmm_phys_base(void)
+{
+	return 0x16140000;
+}
+
+const char *get_system_type(void)
+{
+	return "MIPS Boston";
+}
+
+void __init prom_init(void)
+{
+	fw_init_cmdline();
+	mips_cm_probe();
+	mips_cpc_probe();
+	register_cps_smp_ops();
+}
+
+void __init prom_free_prom_memory(void)
+{
+}
diff --git a/arch/mips/boston/int.c b/arch/mips/boston/int.c
new file mode 100644
index 0000000..4069424
--- /dev/null
+++ b/arch/mips/boston/int.c
@@ -0,0 +1,33 @@
+/*
+ * Copyright (C) 2015 Imagination Technologies
+ * Author: Paul Burton <paul.burton@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/irqchip.h>
+#include <linux/of_irq.h>
+
+#include <asm/irq_cpu.h>
+#include <asm/mips-cm.h>
+#include <asm/traps.h>
+
+static int be_handler(struct pt_regs *regs, int is_fixup)
+{
+	mips_cm_error_report();
+	return is_fixup ? MIPS_BE_FIXUP : MIPS_BE_FATAL;
+}
+
+void __init arch_init_irq(void)
+{
+	board_be_handler = be_handler;
+
+	if (!cpu_has_veic)
+		mips_cpu_irq_init();
+
+	irqchip_init();
+}
diff --git a/arch/mips/boston/time.c b/arch/mips/boston/time.c
new file mode 100644
index 0000000..a51710a
--- /dev/null
+++ b/arch/mips/boston/time.c
@@ -0,0 +1,89 @@
+/*
+ * Copyright (C) 2015 Imagination Technologies
+ * Author: Paul Burton <paul.burton@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/clocksource.h>
+#include <linux/init.h>
+#include <linux/irqchip/mips-gic.h>
+#include <linux/types.h>
+
+#include <asm/irq.h>
+#include <asm/time.h>
+
+void __init plat_time_init(void)
+{
+	struct device_node *np;
+	struct clk *clk;
+
+	of_clk_init(NULL);
+	clocksource_probe();
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
+
+int get_c0_fdc_int(void)
+{
+	int mips_cpu_fdc_irq;
+
+	if (cpu_has_veic)
+		panic("Unimplemented!");
+	else if (gic_present)
+		mips_cpu_fdc_irq = gic_get_c0_fdc_int();
+	else if (cp0_fdc_irq >= 0)
+		mips_cpu_fdc_irq = MIPS_CPU_IRQ_BASE + cp0_fdc_irq;
+	else
+		mips_cpu_fdc_irq = -1;
+
+	return mips_cpu_fdc_irq;
+}
+
+int get_c0_perfcount_int(void)
+{
+	int mips_cpu_perf_irq;
+
+	if (cpu_has_veic)
+		panic("Unimplemented!");
+	else if (gic_present)
+		mips_cpu_perf_irq = gic_get_c0_perfcount_int();
+	else if (cp0_perfcount_irq >= 0)
+		mips_cpu_perf_irq = MIPS_CPU_IRQ_BASE + cp0_perfcount_irq;
+	else
+		mips_cpu_perf_irq = -1;
+
+	return mips_cpu_perf_irq;
+}
+
+unsigned int get_c0_compare_int(void)
+{
+	int mips_cpu_timer_irq;
+
+	if (cpu_has_veic)
+		panic("Unimplemented!");
+	else if (gic_present)
+		mips_cpu_timer_irq = gic_get_c0_compare_int();
+	else
+		mips_cpu_timer_irq = MIPS_CPU_IRQ_BASE + cp0_compare_irq;
+
+	return mips_cpu_timer_irq;
+}
diff --git a/arch/mips/boston/vmlinux.its b/arch/mips/boston/vmlinux.its
new file mode 100644
index 0000000..643ac63
--- /dev/null
+++ b/arch/mips/boston/vmlinux.its
@@ -0,0 +1,23 @@
+/ {
+	images {
+		fdt@boston {
+			description = "img,boston Device Tree";
+			data = /incbin/("boot/dts/img/boston.dtb");
+			type = "flat_dt";
+			arch = "mips";
+			compression = "none";
+			hash@1 {
+				algo = "sha1";
+			};
+		};
+	};
+
+	configurations {
+		default = "conf@boston";
+		conf@boston {
+			description = "Boot Linux kernel";
+			kernel = "kernel@0";
+			fdt = "fdt@boston";
+		};
+	};
+};
diff --git a/arch/mips/configs/boston_defconfig b/arch/mips/configs/boston_defconfig
new file mode 100644
index 0000000..43c1fce
--- /dev/null
+++ b/arch/mips/configs/boston_defconfig
@@ -0,0 +1,170 @@
+CONFIG_BOSTON=y
+CONFIG_CPU_LITTLE_ENDIAN=y
+CONFIG_CPU_MIPS64_R6=y
+CONFIG_64BIT=y
+CONFIG_PAGE_SIZE_16KB=y
+CONFIG_CPU_HAS_MSA=y
+# CONFIG_COMPACTION is not set
+CONFIG_HZ_48=y
+# CONFIG_SWAP is not set
+CONFIG_SYSVIPC=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_AUDIT=y
+CONFIG_NO_HZ_IDLE=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=15
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_SYSCTL_SYSCALL=y
+CONFIG_EMBEDDED=y
+CONFIG_SLAB=y
+# CONFIG_BLK_DEV_BSG is not set
+CONFIG_PCI=y
+CONFIG_PCI_MSI=y
+CONFIG_PCIE_XILINX=y
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+CONFIG_MIPS32_O32=y
+CONFIG_MIPS32_N32=y
+# CONFIG_SUSPEND is not set
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_XFRM_USER=y
+CONFIG_NET_KEY=y
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+CONFIG_IP_ADVANCED_ROUTER=y
+CONFIG_IP_MULTIPLE_TABLES=y
+CONFIG_IP_ROUTE_MULTIPATH=y
+CONFIG_IP_ROUTE_VERBOSE=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+CONFIG_NET_IPIP=y
+CONFIG_SYN_COOKIES=y
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_LRO is not set
+# CONFIG_INET_DIAG is not set
+# CONFIG_WIRELESS is not set
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_CRYPTOLOOP=y
+CONFIG_PCH_PHUB=y
+CONFIG_BLK_DEV_SD=y
+CONFIG_CHR_DEV_SG=y
+# CONFIG_SCSI_LOWLEVEL is not set
+CONFIG_ATA=y
+CONFIG_SATA_AHCI=y
+# CONFIG_ATA_SFF is not set
+CONFIG_NETDEVICES=y
+# CONFIG_NET_VENDOR_3COM is not set
+# CONFIG_NET_VENDOR_ADAPTEC is not set
+# CONFIG_NET_VENDOR_AGERE is not set
+# CONFIG_NET_VENDOR_ALTEON is not set
+# CONFIG_NET_VENDOR_AMD is not set
+# CONFIG_NET_VENDOR_ARC is not set
+# CONFIG_NET_VENDOR_ATHEROS is not set
+# CONFIG_NET_CADENCE is not set
+# CONFIG_NET_VENDOR_BROADCOM is not set
+# CONFIG_NET_VENDOR_BROCADE is not set
+# CONFIG_NET_VENDOR_CHELSIO is not set
+# CONFIG_NET_VENDOR_CISCO is not set
+# CONFIG_NET_VENDOR_DEC is not set
+# CONFIG_NET_VENDOR_DLINK is not set
+# CONFIG_NET_VENDOR_EMULEX is not set
+# CONFIG_NET_VENDOR_EXAR is not set
+# CONFIG_NET_VENDOR_HP is not set
+# CONFIG_NET_VENDOR_INTEL is not set
+# CONFIG_NET_VENDOR_MARVELL is not set
+# CONFIG_NET_VENDOR_MELLANOX is not set
+# CONFIG_NET_VENDOR_MICREL is not set
+# CONFIG_NET_VENDOR_MYRI is not set
+# CONFIG_NET_VENDOR_NATSEMI is not set
+# CONFIG_NET_VENDOR_NVIDIA is not set
+CONFIG_PCH_GBE=y
+# CONFIG_NET_PACKET_ENGINE is not set
+# CONFIG_NET_VENDOR_QLOGIC is not set
+# CONFIG_NET_VENDOR_QUALCOMM is not set
+# CONFIG_NET_VENDOR_REALTEK is not set
+# CONFIG_NET_VENDOR_RDC is not set
+# CONFIG_NET_VENDOR_ROCKER is not set
+# CONFIG_NET_VENDOR_SAMSUNG is not set
+# CONFIG_NET_VENDOR_SEEQ is not set
+# CONFIG_NET_VENDOR_SILAN is not set
+# CONFIG_NET_VENDOR_SIS is not set
+# CONFIG_NET_VENDOR_SMSC is not set
+# CONFIG_NET_VENDOR_STMICRO is not set
+# CONFIG_NET_VENDOR_SUN is not set
+# CONFIG_NET_VENDOR_TEHUTI is not set
+# CONFIG_NET_VENDOR_TI is not set
+# CONFIG_NET_VENDOR_TOSHIBA is not set
+# CONFIG_NET_VENDOR_VIA is not set
+# CONFIG_NET_VENDOR_WIZNET is not set
+# CONFIG_WLAN is not set
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_SERIO is not set
+# CONFIG_VT is not set
+CONFIG_LEGACY_PTY_COUNT=4
+CONFIG_SERIAL_8250=y
+# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
+CONFIG_SERIAL_8250_CONSOLE=y
+# CONFIG_SERIAL_8250_PCI is not set
+CONFIG_SERIAL_OF_PLATFORM=y
+# CONFIG_HW_RANDOM is not set
+CONFIG_I2C=y
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_EG20T=y
+CONFIG_SPI=y
+CONFIG_SPI_TOPCLIFF_PCH=y
+CONFIG_GPIO_SYSFS=y
+CONFIG_GPIO_PCH=y
+# CONFIG_HWMON is not set
+CONFIG_REGULATOR=y
+# CONFIG_VGA_ARB is not set
+CONFIG_USB=y
+CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_STORAGE=y
+CONFIG_MMC=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_PCI=y
+# CONFIG_MMC_RICOH_MMC is not set
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_M41T80=y
+CONFIG_DMADEVICES=y
+CONFIG_PCH_DMA=y
+CONFIG_AUXDISPLAY=y
+CONFIG_ASCII_LCD=y
+# CONFIG_MIPS_PLATFORM_DEVICES is not set
+# CONFIG_IOMMU_SUPPORT is not set
+CONFIG_EXT4_FS=y
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_PROC_KCORE=y
+CONFIG_TMPFS=y
+CONFIG_CONFIGFS_FS=y
+# CONFIG_MISC_FILESYSTEMS is not set
+CONFIG_NFS_FS=y
+CONFIG_NFS_V4=y
+CONFIG_NFS_V4_1=y
+CONFIG_NFS_V4_2=y
+CONFIG_ROOT_NFS=y
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_ISO8859_1=y
+CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_REDUCED=y
+CONFIG_FRAME_WARN=1024
+CONFIG_READABLE_ASM=y
+CONFIG_DEBUG_FS=y
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_FTRACE is not set
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE="earlycon console=ttyS0,57600"
+# CONFIG_CRYPTO_HW is not set
+CONFIG_LIBCRC32C=y
diff --git a/arch/mips/include/asm/mach-boston/cpu-feature-overrides.h b/arch/mips/include/asm/mach-boston/cpu-feature-overrides.h
new file mode 100644
index 0000000..e1bd9b9
--- /dev/null
+++ b/arch/mips/include/asm/mach-boston/cpu-feature-overrides.h
@@ -0,0 +1,26 @@
+/*
+ * Copyright (C) 2015 Imagination Technologies
+ * Author: Paul Burton <paul.burton@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __ASM_MACH_BOSTON_CPU_FEATURE_OVERRIDES_H__
+#define __ASM_MACH_BOSTON_CPU_FEATURE_OVERRIDES_H__
+
+#define cpu_has_4kex			1
+#define cpu_has_4k_cache		1
+#define cpu_has_clo_clz			1
+#define cpu_has_counter			1
+#define cpu_has_divec			1
+#define cpu_has_llsc			1
+#define cpu_has_mcheck			1
+#define cpu_has_nofpuex			0
+#define cpu_has_tlb			1
+#define cpu_has_vce			0
+#define cpu_icache_snoops_remote_store	1
+
+#endif /* __ASM_MACH_BOSTON_CPU_FEATURE_OVERRIDES_H__ */
diff --git a/arch/mips/include/asm/mach-boston/irq.h b/arch/mips/include/asm/mach-boston/irq.h
new file mode 100644
index 0000000..95ac10c
--- /dev/null
+++ b/arch/mips/include/asm/mach-boston/irq.h
@@ -0,0 +1,18 @@
+/*
+ * Copyright (C) 2015 Imagination Technologies
+ * Author: Paul Burton <paul.burton@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __ASM_MACH_BOSTON_IRQ_H__
+#define __ASM_MACH_BOSTON_IRQ_H__
+
+#define NR_IRQS 256
+
+#include_next <irq.h>
+
+#endif /* __ASM_MACH_BOSTON_IRQ_H__ */
diff --git a/arch/mips/include/asm/mach-boston/spaces.h b/arch/mips/include/asm/mach-boston/spaces.h
new file mode 100644
index 0000000..e7f4c59
--- /dev/null
+++ b/arch/mips/include/asm/mach-boston/spaces.h
@@ -0,0 +1,20 @@
+/*
+ * Copyright (C) 2015 Imagination Technologies
+ * Author: Paul Burton <paul.burton@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __ASM_MACH_BOSTON_SPACES_H__
+#define __ASM_MACH_BOSTON_SPACES_H__
+
+#ifdef CONFIG_64BIT
+# define CAC_BASE _AC(0xa800000000000000, UL)
+#endif
+
+#include <asm/mach-generic/spaces.h>
+
+#endif /* __ASM_MACH_BOSTON_SPACES_H__ */
-- 
2.6.2
