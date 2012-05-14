Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2012 19:44:58 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:38228 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903693Ab2ENRnc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 May 2012 19:43:32 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>,
        devicetree-discuss@lists.ozlabs.org
Subject: [RESEND PATCH V2 02/17] OF: MIPS: lantiq: implement OF support
Date:   Mon, 14 May 2012 19:42:28 +0200
Message-Id: <1337017363-14424-2-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.9.1
In-Reply-To: <1337017363-14424-1-git-send-email-blogic@openwrt.org>
References: <1337017363-14424-1-git-send-email-blogic@openwrt.org>
X-archive-position: 33294
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Activate USE_OF, add a sample DTS file and convert the core soc code to OF.

Signed-off-by: John Crispin <blogic@openwrt.org>
Cc: devicetree-discuss@lists.ozlabs.org
---
This patch is part of a series moving the mips/lantiq target to OF and clkdev
support. The patch, once Acked, should go upstream via Ralf's MIPS tree.

 arch/mips/Kconfig                  |    1 +
 arch/mips/lantiq/Kconfig           |    9 +++
 arch/mips/lantiq/Makefile          |    4 +-
 arch/mips/lantiq/dts/Makefile      |    4 +
 arch/mips/lantiq/dts/danube.dtsi   |  105 +++++++++++++++++++++++++++++++++
 arch/mips/lantiq/dts/easy50712.dts |  113 ++++++++++++++++++++++++++++++++++++
 arch/mips/lantiq/prom.c            |   57 ++++++++++++++----
 arch/mips/lantiq/prom.h            |    2 +
 arch/mips/lantiq/setup.c           |   43 --------------
 arch/mips/lantiq/xway/ebu.c        |    4 -
 arch/mips/lantiq/xway/reset.c      |   29 ++++-----
 11 files changed, 294 insertions(+), 77 deletions(-)
 create mode 100644 arch/mips/lantiq/dts/Makefile
 create mode 100644 arch/mips/lantiq/dts/danube.dtsi
 create mode 100644 arch/mips/lantiq/dts/easy50712.dts
 delete mode 100644 arch/mips/lantiq/setup.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 27b392e..08b0312 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -229,6 +229,7 @@ config LANTIQ
 	select SWAP_IO_SPACE
 	select BOOT_RAW
 	select HAVE_CLK
+	select USE_OF
 
 config LASAT
 	bool "LASAT Networks platforms"
diff --git a/arch/mips/lantiq/Kconfig b/arch/mips/lantiq/Kconfig
index 2780461..9485fe5 100644
--- a/arch/mips/lantiq/Kconfig
+++ b/arch/mips/lantiq/Kconfig
@@ -18,4 +18,13 @@ config SOC_XWAY
 	select HW_HAS_PCI
 endchoice
 
+
+choice
+	prompt "Devicetree"
+
+config DT_EASY50712
+	bool "Easy50712"
+	depends on SOC_XWAY
+endchoice
+
 endif
diff --git a/arch/mips/lantiq/Makefile b/arch/mips/lantiq/Makefile
index a268391..16f1c75 100644
--- a/arch/mips/lantiq/Makefile
+++ b/arch/mips/lantiq/Makefile
@@ -4,7 +4,9 @@
 # under the terms of the GNU General Public License version 2 as published
 # by the Free Software Foundation.
 
-obj-y := irq.o setup.o clk.o prom.o
+obj-y := irq.o clk.o prom.o
+
+obj-y += dts/
 
 obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
 
diff --git a/arch/mips/lantiq/dts/Makefile b/arch/mips/lantiq/dts/Makefile
new file mode 100644
index 0000000..674fca4
--- /dev/null
+++ b/arch/mips/lantiq/dts/Makefile
@@ -0,0 +1,4 @@
+obj-$(CONFIG_DT_EASY50712) := easy50712.dtb.o
+
+$(obj)/%.dtb: $(obj)/%.dts
+	$(call if_changed,dtc)
diff --git a/arch/mips/lantiq/dts/danube.dtsi b/arch/mips/lantiq/dts/danube.dtsi
new file mode 100644
index 0000000..3a4520f
--- /dev/null
+++ b/arch/mips/lantiq/dts/danube.dtsi
@@ -0,0 +1,105 @@
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "lantiq,xway", "lantiq,danube";
+
+	cpus {
+		cpu@0 {
+			compatible = "mips,mips24Kc";
+		};
+	};
+
+	biu@1F800000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "lantiq,biu", "simple-bus";
+		reg = <0x1F800000 0x800000>;
+		ranges = <0x0 0x1F800000 0x7FFFFF>;
+
+		icu0: icu@80200 {
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			compatible = "lantiq,icu";
+			reg = <0x80200 0x120>;
+		};
+
+		watchdog@803F0 {
+			compatible = "lantiq,wdt";
+			reg = <0x803F0 0x10>;
+		};
+	};
+
+	sram@1F000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "lantiq,sram";
+		reg = <0x1F000000 0x800000>;
+		ranges = <0x0 0x1F000000 0x7FFFFF>;
+
+		eiu0: eiu@101000 {
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			interrupt-parent;
+			compatible = "lantiq,eiu-xway";
+			reg = <0x101000 0x1000>;
+		};
+
+		pmu0: pmu@102000 {
+			compatible = "lantiq,pmu-xway";
+			reg = <0x102000 0x1000>;
+		};
+
+		cgu0: cgu@103000 {
+			compatible = "lantiq,cgu-xway";
+			reg = <0x103000 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		rcu0: rcu@203000 {
+			compatible = "lantiq,rcu-xway";
+			reg = <0x203000 0x1000>;
+		};
+	};
+
+	fpi@10000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "lantiq,fpi", "simple-bus";
+		ranges = <0x0 0x10000000 0xEEFFFFF>;
+		reg = <0x10000000 0xEF00000>;
+
+		gptu@E100A00 {
+			compatible = "lantiq,gptu-xway";
+			reg = <0xE100A00 0x100>;
+		};
+
+		serial@E100C00 {
+			compatible = "lantiq,asc";
+			reg = <0xE100C00 0x400>;
+			interrupt-parent = <&icu0>;
+			interrupts = <112 113 114>;
+		};
+
+		dma0: dma@E104100 {
+			compatible = "lantiq,dma-xway";
+			reg = <0xE104100 0x800>;
+		};
+
+		ebu0: ebu@E105300 {
+			compatible = "lantiq,ebu-xway";
+			reg = <0xE105300 0x100>;
+		};
+
+		pci0: pci@E105400 {
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			compatible = "lantiq,pci-xway";
+			bus-range = <0x0 0x0>;
+			ranges = <0x2000000 0 0x8000000 0x8000000 0 0x2000000	/* pci memory */
+				  0x1000000 0 0x00000000 0xAE00000 0 0x200000>;	/* io space */
+			reg = <0x7000000 0x8000		/* config space */
+				0xE105400 0x400>;	/* pci bridge */
+		};
+	};
+};
diff --git a/arch/mips/lantiq/dts/easy50712.dts b/arch/mips/lantiq/dts/easy50712.dts
new file mode 100644
index 0000000..68c1731
--- /dev/null
+++ b/arch/mips/lantiq/dts/easy50712.dts
@@ -0,0 +1,113 @@
+/dts-v1/;
+
+/include/ "danube.dtsi"
+
+/ {
+	chosen {
+		bootargs = "console=ttyLTQ0,115200 init=/etc/preinit";
+	};
+
+	memory@0 {
+		reg = <0x0 0x2000000>;
+	};
+
+	fpi@10000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		localbus@0 {
+			#address-cells = <2>;
+			#size-cells = <1>;
+			ranges = <0 0 0x0 0x3ffffff /* addrsel0 */
+				1 0 0x4000000 0x4000010>; /* addsel1 */
+			compatible = "lantiq,localbus", "simple-bus";
+
+			nor-boot@0 {
+				compatible = "lantiq,nor";
+				bank-width = <2>;
+				reg = <0 0x0 0x2000000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				partition@0 {
+					label = "uboot";
+					reg = <0x00000 0x10000>; /* 64 KB */
+				};
+
+				partition@10000 {
+					label = "uboot_env";
+					reg = <0x10000 0x10000>; /* 64 KB */
+				};
+
+				partition@20000 {
+					label = "linux";
+					reg = <0x20000 0x3d0000>;
+				};
+
+				partition@400000 {
+					label = "rootfs";
+					reg = <0x400000 0x400000>;
+				};
+			};
+		};
+
+		gpio: pinmux@E100B10 {
+			compatible = "lantiq,pinctrl-xway";
+			pinctrl-names = "default";
+			pinctrl-0 = <&state_default>;
+
+			#gpio-cells = <2>;
+			gpio-controller;
+			reg = <0xE100B10 0xA0>;
+
+			state_default: pinmux {
+				stp {
+					lantiq,groups = "stp";
+					lantiq,function = "stp";
+				};
+				exin {
+					lantiq,groups = "exin1";
+					lantiq,function = "exin";
+				};
+				pci {
+					lantiq,groups = "gnt1";
+					lantiq,function = "pci";
+				};
+				conf_out {
+					lantiq,pins = "io4", "io5", "io6"; /* stp */
+					lantiq,open-drain;
+					lantiq,pull = <0>;
+				};
+			};
+		};
+
+		etop@E180000 {
+			compatible = "lantiq,etop-xway";
+			reg = <0xE180000 0x40000>;
+			interrupt-parent = <&icu0>;
+			interrupts = <73 78>;
+			phy-mode = "rmii";
+			mac-address = [ 00 11 22 33 44 55 ];
+		};
+
+		stp0: stp@E100BB0 {
+			#gpio-cells = <2>;
+			compatible = "lantiq,gpio-stp-xway";
+			gpio-controller;
+			reg = <0xE100BB0 0x40>;
+
+			lantiq,shadow = <0xfff>;
+			lantiq,groups = <0x3>;
+		};
+
+		pci@E105400 {
+			lantiq,bus-clock = <33333333>;
+			interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+			interrupt-map = <
+                                0x7000 0 0 1 &icu0 29 1 // slot 14, irq 29
+			>;
+			gpios-reset = <&gpio 21 0>;
+			req-mask = <0x1>;		/* GNT1 */
+		};
+
+	};
+};
diff --git a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
index cd56892..413ed53 100644
--- a/arch/mips/lantiq/prom.c
+++ b/arch/mips/lantiq/prom.c
@@ -8,6 +8,7 @@
 
 #include <linux/export.h>
 #include <linux/clk.h>
+#include <linux/of_platform.h>
 #include <asm/bootinfo.h>
 #include <asm/time.h>
 
@@ -16,13 +17,15 @@
 #include "prom.h"
 #include "clk.h"
 
-static struct ltq_soc_info soc_info;
+/* access to the ebu needs to be locked between different drivers */
+DEFINE_SPINLOCK(ebu_lock);
+EXPORT_SYMBOL_GPL(ebu_lock);
 
-unsigned int ltq_get_cpu_ver(void)
-{
-	return soc_info.rev;
-}
-EXPORT_SYMBOL(ltq_get_cpu_ver);
+/*
+ * this struct is filled by the soc specific detection code and holds
+ * information about the specific soc type, revision and name
+ */
+static struct ltq_soc_info soc_info;
 
 unsigned int ltq_get_soc_type(void)
 {
@@ -57,16 +60,28 @@ static void __init prom_init_cmdline(void)
 	}
 }
 
-void __init prom_init(void)
+void __init plat_mem_setup(void)
 {
-	struct clk *clk;
+	ioport_resource.start = IOPORT_RESOURCE_START;
+	ioport_resource.end = IOPORT_RESOURCE_END;
+	iomem_resource.start = IOMEM_RESOURCE_START;
+	iomem_resource.end = IOMEM_RESOURCE_END;
+
+	set_io_port_base((unsigned long) KSEG1);
+
+	/*
+	 * Load the builtin devicetree. This causes the chosen node to be
+	 * parsed resulting in our memory appearing
+	 */
+	__dt_setup_arch(&__dtb_start);
+}
 
+void __init prom_init(void)
+{
+	/* call the soc specific detetcion code and get it to fill soc_info */
 	ltq_soc_detect(&soc_info);
-	clk_init();
-	clk = clk_get(0, "cpu");
-	snprintf(soc_info.sys_type, LTQ_SYS_TYPE_LEN - 1, "%s rev1.%d",
-		soc_info.name, soc_info.rev);
-	clk_put(clk);
+	snprintf(soc_info.sys_type, LTQ_SYS_TYPE_LEN - 1, "%s rev %s",
+		soc_info.name, soc_info.rev_type);
 	soc_info.sys_type[LTQ_SYS_TYPE_LEN - 1] = '\0';
 	pr_info("SoC: %s\n", soc_info.sys_type);
 	prom_init_cmdline();
@@ -76,3 +91,19 @@ void __init prom_init(void)
 		panic("failed to register_vsmp_smp_ops()");
 #endif
 }
+
+int __init plat_of_setup(void)
+{
+	static struct of_device_id of_ids[3];
+
+	if (!of_have_populated_dt())
+		panic("device tree not present");
+
+	strncpy(of_ids[0].compatible, soc_info.compatible,
+		sizeof(of_ids[0].compatible));
+	strncpy(of_ids[1].compatible, "simple-bus",
+		sizeof(of_ids[1].compatible));
+	return of_platform_bus_probe(NULL, of_ids, NULL);
+}
+
+arch_initcall(plat_of_setup);
diff --git a/arch/mips/lantiq/prom.h b/arch/mips/lantiq/prom.h
index f7c2a79..a3fa1a2 100644
--- a/arch/mips/lantiq/prom.h
+++ b/arch/mips/lantiq/prom.h
@@ -26,4 +26,6 @@ struct ltq_soc_info {
 extern void ltq_soc_detect(struct ltq_soc_info *i);
 extern void ltq_soc_init(void);
 
+extern struct boot_param_header __dtb_start;
+
 #endif
diff --git a/arch/mips/lantiq/setup.c b/arch/mips/lantiq/setup.c
deleted file mode 100644
index f1c605a..0000000
--- a/arch/mips/lantiq/setup.c
+++ /dev/null
@@ -1,43 +0,0 @@
-/*
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License version 2 as published
- *  by the Free Software Foundation.
- *
- * Copyright (C) 2010 John Crispin <blogic@openwrt.org>
- */
-
-#include <linux/kernel.h>
-#include <linux/export.h>
-#include <linux/io.h>
-#include <linux/ioport.h>
-#include <asm/bootinfo.h>
-
-#include <lantiq_soc.h>
-
-#include "prom.h"
-
-void __init plat_mem_setup(void)
-{
-	/* assume 16M as default incase uboot fails to pass proper ramsize */
-	unsigned long memsize = 16;
-	char **envp = (char **) KSEG1ADDR(fw_arg2);
-
-	ioport_resource.start = IOPORT_RESOURCE_START;
-	ioport_resource.end = IOPORT_RESOURCE_END;
-	iomem_resource.start = IOMEM_RESOURCE_START;
-	iomem_resource.end = IOMEM_RESOURCE_END;
-
-	set_io_port_base((unsigned long) KSEG1);
-
-	while (*envp) {
-		char *e = (char *)KSEG1ADDR(*envp);
-		if (!strncmp(e, "memsize=", 8)) {
-			e += 8;
-			if (strict_strtoul(e, 0, &memsize))
-				pr_warn("bad memsize specified\n");
-		}
-		envp++;
-	}
-	memsize *= 1024 * 1024;
-	add_memory_region(0x00000000, memsize, BOOT_MEM_RAM);
-}
diff --git a/arch/mips/lantiq/xway/ebu.c b/arch/mips/lantiq/xway/ebu.c
index 862e3e8..419b47b 100644
--- a/arch/mips/lantiq/xway/ebu.c
+++ b/arch/mips/lantiq/xway/ebu.c
@@ -14,10 +14,6 @@
 
 #include <lantiq_soc.h>
 
-/* all access to the ebu must be locked */
-DEFINE_SPINLOCK(ebu_lock);
-EXPORT_SYMBOL_GPL(ebu_lock);
-
 static struct resource ltq_ebu_resource = {
 	.name	= "ebu",
 	.start	= LTQ_EBU_BASE_ADDR,
diff --git a/arch/mips/lantiq/xway/reset.c b/arch/mips/lantiq/xway/reset.c
index 3327211..22c55f7 100644
--- a/arch/mips/lantiq/xway/reset.c
+++ b/arch/mips/lantiq/xway/reset.c
@@ -37,13 +37,6 @@
 #define RCU_BOOT_SEL_SHIFT	26
 #define RCU_BOOT_SEL_MASK	0x7
 
-static struct resource ltq_rcu_resource = {
-	.name   = "rcu",
-	.start  = LTQ_RCU_BASE_ADDR,
-	.end    = LTQ_RCU_BASE_ADDR + LTQ_RCU_SIZE - 1,
-	.flags  = IORESOURCE_MEM,
-};
-
 /* remapped base addr of the reset control unit */
 static void __iomem *ltq_rcu_membase;
 
@@ -91,17 +84,21 @@ static void ltq_machine_power_off(void)
 
 static int __init mips_reboot_setup(void)
 {
-	/* insert and request the memory region */
-	if (insert_resource(&iomem_resource, &ltq_rcu_resource) < 0)
-		panic("Failed to insert rcu memory");
+	struct resource res;
+	struct device_node *np =
+		of_find_compatible_node(NULL, NULL, "lantiq,rcu-xway");
+
+	/* check if all the reset register range is available */
+	if (!np)
+		panic("Failed to load reset resources from devicetree");
+
+	if (of_address_to_resource(np, 0, &res))
+		panic("Failed to get rcu memory range");
 
-	if (request_mem_region(ltq_rcu_resource.start,
-			resource_size(&ltq_rcu_resource), "rcu") < 0)
-		panic("Failed to request rcu memory");
+	if (request_mem_region(res.start, resource_size(&res), res.name) < 0)
+		pr_err("Failed to request rcu memory");
 
-	/* remap rcu register range */
-	ltq_rcu_membase = ioremap_nocache(ltq_rcu_resource.start,
-				resource_size(&ltq_rcu_resource));
+	ltq_rcu_membase = ioremap_nocache(res.start, resource_size(&res));
 	if (!ltq_rcu_membase)
 		panic("Failed to remap core memory");
 
-- 
1.7.9.1
