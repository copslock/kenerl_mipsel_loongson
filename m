Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2012 19:43:39 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:38223 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903678Ab2ENRnb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 May 2012 19:43:31 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [RESEND PATCH V2 01/17] MIPS: lantiq: drop mips_machine support
Date:   Mon, 14 May 2012 19:42:27 +0200
Message-Id: <1337017363-14424-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.9.1
X-archive-position: 33291
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Before we are able to add OF support, we really want to drop all the bloat
needed to register all the platform devices.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/Kconfig                      |    1 -
 arch/mips/lantiq/Kconfig               |    2 -
 arch/mips/lantiq/Makefile              |    2 +-
 arch/mips/lantiq/devices.c             |  120 --------------------------------
 arch/mips/lantiq/devices.h             |   23 ------
 arch/mips/lantiq/machtypes.h           |   20 -----
 arch/mips/lantiq/prom.h                |    1 -
 arch/mips/lantiq/setup.c               |   23 ------
 arch/mips/lantiq/xway/Kconfig          |   23 ------
 arch/mips/lantiq/xway/Makefile         |    9 +--
 arch/mips/lantiq/xway/devices.c        |  119 -------------------------------
 arch/mips/lantiq/xway/devices.h        |   20 -----
 arch/mips/lantiq/xway/mach-easy50601.c |   57 ---------------
 arch/mips/lantiq/xway/mach-easy50712.c |   74 --------------------
 arch/mips/lantiq/xway/setup-ase.c      |   19 -----
 arch/mips/lantiq/xway/setup-xway.c     |   20 -----
 16 files changed, 4 insertions(+), 529 deletions(-)
 delete mode 100644 arch/mips/lantiq/devices.c
 delete mode 100644 arch/mips/lantiq/devices.h
 delete mode 100644 arch/mips/lantiq/machtypes.h
 delete mode 100644 arch/mips/lantiq/xway/Kconfig
 delete mode 100644 arch/mips/lantiq/xway/devices.c
 delete mode 100644 arch/mips/lantiq/xway/devices.h
 delete mode 100644 arch/mips/lantiq/xway/mach-easy50601.c
 delete mode 100644 arch/mips/lantiq/xway/mach-easy50712.c
 delete mode 100644 arch/mips/lantiq/xway/setup-ase.c
 delete mode 100644 arch/mips/lantiq/xway/setup-xway.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 6e04163..27b392e 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -229,7 +229,6 @@ config LANTIQ
 	select SWAP_IO_SPACE
 	select BOOT_RAW
 	select HAVE_CLK
-	select MIPS_MACHINE
 
 config LASAT
 	bool "LASAT Networks platforms"
diff --git a/arch/mips/lantiq/Kconfig b/arch/mips/lantiq/Kconfig
index 3fccf21..2780461 100644
--- a/arch/mips/lantiq/Kconfig
+++ b/arch/mips/lantiq/Kconfig
@@ -18,6 +18,4 @@ config SOC_XWAY
 	select HW_HAS_PCI
 endchoice
 
-source "arch/mips/lantiq/xway/Kconfig"
-
 endif
diff --git a/arch/mips/lantiq/Makefile b/arch/mips/lantiq/Makefile
index e5dae0e..a268391 100644
--- a/arch/mips/lantiq/Makefile
+++ b/arch/mips/lantiq/Makefile
@@ -4,7 +4,7 @@
 # under the terms of the GNU General Public License version 2 as published
 # by the Free Software Foundation.
 
-obj-y := irq.o setup.o clk.o prom.o devices.o
+obj-y := irq.o setup.o clk.o prom.o
 
 obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
 
diff --git a/arch/mips/lantiq/devices.c b/arch/mips/lantiq/devices.c
deleted file mode 100644
index de1cb2b..0000000
--- a/arch/mips/lantiq/devices.c
+++ /dev/null
@@ -1,120 +0,0 @@
-/*
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License version 2 as published
- *  by the Free Software Foundation.
- *
- *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
- */
-
-#include <linux/init.h>
-#include <linux/export.h>
-#include <linux/types.h>
-#include <linux/string.h>
-#include <linux/kernel.h>
-#include <linux/reboot.h>
-#include <linux/platform_device.h>
-#include <linux/leds.h>
-#include <linux/etherdevice.h>
-#include <linux/time.h>
-#include <linux/io.h>
-#include <linux/gpio.h>
-
-#include <asm/bootinfo.h>
-#include <asm/irq.h>
-
-#include <lantiq_soc.h>
-
-#include "devices.h"
-
-/* nor flash */
-static struct resource ltq_nor_resource = {
-	.name	= "nor",
-	.start	= LTQ_FLASH_START,
-	.end	= LTQ_FLASH_START + LTQ_FLASH_MAX - 1,
-	.flags  = IORESOURCE_MEM,
-};
-
-static struct platform_device ltq_nor = {
-	.name		= "ltq_nor",
-	.resource	= &ltq_nor_resource,
-	.num_resources	= 1,
-};
-
-void __init ltq_register_nor(struct physmap_flash_data *data)
-{
-	ltq_nor.dev.platform_data = data;
-	platform_device_register(&ltq_nor);
-}
-
-/* watchdog */
-static struct resource ltq_wdt_resource = {
-	.name	= "watchdog",
-	.start  = LTQ_WDT_BASE_ADDR,
-	.end    = LTQ_WDT_BASE_ADDR + LTQ_WDT_SIZE - 1,
-	.flags  = IORESOURCE_MEM,
-};
-
-void __init ltq_register_wdt(void)
-{
-	platform_device_register_simple("ltq_wdt", 0, &ltq_wdt_resource, 1);
-}
-
-/* asc ports */
-static struct resource ltq_asc0_resources[] = {
-	{
-		.name	= "asc0",
-		.start  = LTQ_ASC0_BASE_ADDR,
-		.end    = LTQ_ASC0_BASE_ADDR + LTQ_ASC_SIZE - 1,
-		.flags  = IORESOURCE_MEM,
-	},
-	IRQ_RES(tx, LTQ_ASC_TIR(0)),
-	IRQ_RES(rx, LTQ_ASC_RIR(0)),
-	IRQ_RES(err, LTQ_ASC_EIR(0)),
-};
-
-static struct resource ltq_asc1_resources[] = {
-	{
-		.name	= "asc1",
-		.start  = LTQ_ASC1_BASE_ADDR,
-		.end    = LTQ_ASC1_BASE_ADDR + LTQ_ASC_SIZE - 1,
-		.flags  = IORESOURCE_MEM,
-	},
-	IRQ_RES(tx, LTQ_ASC_TIR(1)),
-	IRQ_RES(rx, LTQ_ASC_RIR(1)),
-	IRQ_RES(err, LTQ_ASC_EIR(1)),
-};
-
-void __init ltq_register_asc(int port)
-{
-	switch (port) {
-	case 0:
-		platform_device_register_simple("ltq_asc", 0,
-			ltq_asc0_resources, ARRAY_SIZE(ltq_asc0_resources));
-		break;
-	case 1:
-		platform_device_register_simple("ltq_asc", 1,
-			ltq_asc1_resources, ARRAY_SIZE(ltq_asc1_resources));
-		break;
-	default:
-		break;
-	}
-}
-
-#ifdef CONFIG_PCI
-/* pci */
-static struct platform_device ltq_pci = {
-	.name		= "ltq_pci",
-	.num_resources	= 0,
-};
-
-void __init ltq_register_pci(struct ltq_pci_data *data)
-{
-	ltq_pci.dev.platform_data = data;
-	platform_device_register(&ltq_pci);
-}
-#else
-void __init ltq_register_pci(struct ltq_pci_data *data)
-{
-	pr_err("kernel is compiled without PCI support\n");
-}
-#endif
diff --git a/arch/mips/lantiq/devices.h b/arch/mips/lantiq/devices.h
deleted file mode 100644
index 2947bb1..0000000
--- a/arch/mips/lantiq/devices.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/*
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License version 2 as published
- *  by the Free Software Foundation.
- *
- *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
- */
-
-#ifndef _LTQ_DEVICES_H__
-#define _LTQ_DEVICES_H__
-
-#include <lantiq_platform.h>
-#include <linux/mtd/physmap.h>
-
-#define IRQ_RES(resname, irq) \
-	{.name = #resname, .start = (irq), .flags = IORESOURCE_IRQ}
-
-extern void ltq_register_nor(struct physmap_flash_data *data);
-extern void ltq_register_wdt(void);
-extern void ltq_register_asc(int port);
-extern void ltq_register_pci(struct ltq_pci_data *data);
-
-#endif
diff --git a/arch/mips/lantiq/machtypes.h b/arch/mips/lantiq/machtypes.h
deleted file mode 100644
index 7e01b8c..0000000
--- a/arch/mips/lantiq/machtypes.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License version 2 as published
- *  by the Free Software Foundation.
- *
- *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
- */
-
-#ifndef _LANTIQ_MACH_H__
-#define _LANTIQ_MACH_H__
-
-#include <asm/mips_machine.h>
-
-enum lantiq_mach_type {
-	LTQ_MACH_GENERIC = 0,
-	LTQ_MACH_EASY50712,	/* Danube evaluation board */
-	LTQ_MACH_EASY50601,	/* Amazon SE evaluation board */
-};
-
-#endif
diff --git a/arch/mips/lantiq/prom.h b/arch/mips/lantiq/prom.h
index 90070a5..f7c2a79 100644
--- a/arch/mips/lantiq/prom.h
+++ b/arch/mips/lantiq/prom.h
@@ -24,7 +24,6 @@ struct ltq_soc_info {
 };
 
 extern void ltq_soc_detect(struct ltq_soc_info *i);
-extern void ltq_soc_setup(void);
 extern void ltq_soc_init(void);
 
 #endif
diff --git a/arch/mips/lantiq/setup.c b/arch/mips/lantiq/setup.c
index 1ff6c9d..f1c605a 100644
--- a/arch/mips/lantiq/setup.c
+++ b/arch/mips/lantiq/setup.c
@@ -14,8 +14,6 @@
 
 #include <lantiq_soc.h>
 
-#include "machtypes.h"
-#include "devices.h"
 #include "prom.h"
 
 void __init plat_mem_setup(void)
@@ -43,24 +41,3 @@ void __init plat_mem_setup(void)
 	memsize *= 1024 * 1024;
 	add_memory_region(0x00000000, memsize, BOOT_MEM_RAM);
 }
-
-static int __init
-lantiq_setup(void)
-{
-	ltq_soc_setup();
-	mips_machine_setup();
-	return 0;
-}
-
-arch_initcall(lantiq_setup);
-
-static void __init
-lantiq_generic_init(void)
-{
-	/* Nothing to do */
-}
-
-MIPS_MACHINE(LTQ_MACH_GENERIC,
-	     "Generic",
-	     "Generic Lantiq based board",
-	     lantiq_generic_init);
diff --git a/arch/mips/lantiq/xway/Kconfig b/arch/mips/lantiq/xway/Kconfig
deleted file mode 100644
index 2b857de..0000000
--- a/arch/mips/lantiq/xway/Kconfig
+++ /dev/null
@@ -1,23 +0,0 @@
-if SOC_XWAY
-
-menu "MIPS Machine"
-
-config LANTIQ_MACH_EASY50712
-	bool "Easy50712 - Danube"
-	default y
-
-endmenu
-
-endif
-
-if SOC_AMAZON_SE
-
-menu "MIPS Machine"
-
-config LANTIQ_MACH_EASY50601
-	bool "Easy50601 - Amazon SE"
-	default y
-
-endmenu
-
-endif
diff --git a/arch/mips/lantiq/xway/Makefile b/arch/mips/lantiq/xway/Makefile
index 42d5fda..7a6c30f 100644
--- a/arch/mips/lantiq/xway/Makefile
+++ b/arch/mips/lantiq/xway/Makefile
@@ -1,7 +1,4 @@
-obj-y := prom.o pmu.o ebu.o reset.o gpio.o gpio_stp.o gpio_ebu.o devices.o dma.o
+obj-y := prom.o pmu.o ebu.o reset.o gpio.o gpio_stp.o gpio_ebu.o dma.o
 
-obj-$(CONFIG_SOC_XWAY) += clk-xway.o setup-xway.o
-obj-$(CONFIG_SOC_AMAZON_SE) += clk-ase.o setup-ase.o
-
-obj-$(CONFIG_LANTIQ_MACH_EASY50712) += mach-easy50712.o
-obj-$(CONFIG_LANTIQ_MACH_EASY50601) += mach-easy50601.o
+obj-$(CONFIG_SOC_XWAY) += clk-xway.o
+obj-$(CONFIG_SOC_AMAZON_SE) += clk-ase.o
diff --git a/arch/mips/lantiq/xway/devices.c b/arch/mips/lantiq/xway/devices.c
deleted file mode 100644
index d614aa7..0000000
--- a/arch/mips/lantiq/xway/devices.c
+++ /dev/null
@@ -1,119 +0,0 @@
-/*
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License version 2 as published
- *  by the Free Software Foundation.
- *
- *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
- */
-
-#include <linux/init.h>
-#include <linux/export.h>
-#include <linux/types.h>
-#include <linux/string.h>
-#include <linux/mtd/physmap.h>
-#include <linux/kernel.h>
-#include <linux/reboot.h>
-#include <linux/platform_device.h>
-#include <linux/leds.h>
-#include <linux/etherdevice.h>
-#include <linux/time.h>
-#include <linux/io.h>
-#include <linux/gpio.h>
-
-#include <asm/bootinfo.h>
-#include <asm/irq.h>
-
-#include <lantiq_soc.h>
-#include <lantiq_irq.h>
-#include <lantiq_platform.h>
-
-#include "devices.h"
-
-/* gpio */
-static struct resource ltq_gpio_resource[] = {
-	{
-		.name	= "gpio0",
-		.start  = LTQ_GPIO0_BASE_ADDR,
-		.end    = LTQ_GPIO0_BASE_ADDR + LTQ_GPIO_SIZE - 1,
-		.flags  = IORESOURCE_MEM,
-	}, {
-		.name	= "gpio1",
-		.start  = LTQ_GPIO1_BASE_ADDR,
-		.end    = LTQ_GPIO1_BASE_ADDR + LTQ_GPIO_SIZE - 1,
-		.flags  = IORESOURCE_MEM,
-	}, {
-		.name	= "gpio2",
-		.start  = LTQ_GPIO2_BASE_ADDR,
-		.end    = LTQ_GPIO2_BASE_ADDR + LTQ_GPIO_SIZE - 1,
-		.flags  = IORESOURCE_MEM,
-	}
-};
-
-void __init ltq_register_gpio(void)
-{
-	platform_device_register_simple("ltq_gpio", 0,
-		&ltq_gpio_resource[0], 1);
-	platform_device_register_simple("ltq_gpio", 1,
-		&ltq_gpio_resource[1], 1);
-
-	/* AR9 and VR9 have an extra gpio block */
-	if (ltq_is_ar9() || ltq_is_vr9()) {
-		platform_device_register_simple("ltq_gpio", 2,
-			&ltq_gpio_resource[2], 1);
-	}
-}
-
-/* serial to parallel conversion */
-static struct resource ltq_stp_resource = {
-	.name   = "stp",
-	.start  = LTQ_STP_BASE_ADDR,
-	.end    = LTQ_STP_BASE_ADDR + LTQ_STP_SIZE - 1,
-	.flags  = IORESOURCE_MEM,
-};
-
-void __init ltq_register_gpio_stp(void)
-{
-	platform_device_register_simple("ltq_stp", 0, &ltq_stp_resource, 1);
-}
-
-/* asc ports - amazon se has its own serial mapping */
-static struct resource ltq_ase_asc_resources[] = {
-	{
-		.name	= "asc0",
-		.start  = LTQ_ASC1_BASE_ADDR,
-		.end    = LTQ_ASC1_BASE_ADDR + LTQ_ASC_SIZE - 1,
-		.flags  = IORESOURCE_MEM,
-	},
-	IRQ_RES(tx, LTQ_ASC_ASE_TIR),
-	IRQ_RES(rx, LTQ_ASC_ASE_RIR),
-	IRQ_RES(err, LTQ_ASC_ASE_EIR),
-};
-
-void __init ltq_register_ase_asc(void)
-{
-	platform_device_register_simple("ltq_asc", 0,
-		ltq_ase_asc_resources, ARRAY_SIZE(ltq_ase_asc_resources));
-}
-
-/* ethernet */
-static struct resource ltq_etop_resources = {
-	.name	= "etop",
-	.start	= LTQ_ETOP_BASE_ADDR,
-	.end	= LTQ_ETOP_BASE_ADDR + LTQ_ETOP_SIZE - 1,
-	.flags	= IORESOURCE_MEM,
-};
-
-static struct platform_device ltq_etop = {
-	.name		= "ltq_etop",
-	.resource	= &ltq_etop_resources,
-	.num_resources	= 1,
-};
-
-void __init
-ltq_register_etop(struct ltq_eth_data *eth)
-{
-	if (eth) {
-		ltq_etop.dev.platform_data = eth;
-		platform_device_register(&ltq_etop);
-	}
-}
diff --git a/arch/mips/lantiq/xway/devices.h b/arch/mips/lantiq/xway/devices.h
deleted file mode 100644
index e904934..0000000
--- a/arch/mips/lantiq/xway/devices.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License version 2 as published
- *  by the Free Software Foundation.
- *
- *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
- */
-
-#ifndef _LTQ_DEVICES_XWAY_H__
-#define _LTQ_DEVICES_XWAY_H__
-
-#include "../devices.h"
-#include <linux/phy.h>
-
-extern void ltq_register_gpio(void);
-extern void ltq_register_gpio_stp(void);
-extern void ltq_register_ase_asc(void);
-extern void ltq_register_etop(struct ltq_eth_data *eth);
-
-#endif
diff --git a/arch/mips/lantiq/xway/mach-easy50601.c b/arch/mips/lantiq/xway/mach-easy50601.c
deleted file mode 100644
index d5aaf63..0000000
--- a/arch/mips/lantiq/xway/mach-easy50601.c
+++ /dev/null
@@ -1,57 +0,0 @@
-/*
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License version 2 as published
- *  by the Free Software Foundation.
- *
- *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
- */
-
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/partitions.h>
-#include <linux/mtd/physmap.h>
-#include <linux/input.h>
-
-#include <lantiq.h>
-
-#include "../machtypes.h"
-#include "devices.h"
-
-static struct mtd_partition easy50601_partitions[] = {
-	{
-		.name	= "uboot",
-		.offset	= 0x0,
-		.size	= 0x10000,
-	},
-	{
-		.name	= "uboot_env",
-		.offset	= 0x10000,
-		.size	= 0x10000,
-	},
-	{
-		.name	= "linux",
-		.offset	= 0x20000,
-		.size	= 0xE0000,
-	},
-	{
-		.name	= "rootfs",
-		.offset	= 0x100000,
-		.size	= 0x300000,
-	},
-};
-
-static struct physmap_flash_data easy50601_flash_data = {
-	.nr_parts	= ARRAY_SIZE(easy50601_partitions),
-	.parts		= easy50601_partitions,
-};
-
-static void __init easy50601_init(void)
-{
-	ltq_register_nor(&easy50601_flash_data);
-}
-
-MIPS_MACHINE(LTQ_MACH_EASY50601,
-			"EASY50601",
-			"EASY50601 Eval Board",
-			easy50601_init);
diff --git a/arch/mips/lantiq/xway/mach-easy50712.c b/arch/mips/lantiq/xway/mach-easy50712.c
deleted file mode 100644
index ea5027b..0000000
--- a/arch/mips/lantiq/xway/mach-easy50712.c
+++ /dev/null
@@ -1,74 +0,0 @@
-/*
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License version 2 as published
- *  by the Free Software Foundation.
- *
- *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
- */
-
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/partitions.h>
-#include <linux/mtd/physmap.h>
-#include <linux/input.h>
-#include <linux/phy.h>
-
-#include <lantiq_soc.h>
-#include <irq.h>
-
-#include "../machtypes.h"
-#include "devices.h"
-
-static struct mtd_partition easy50712_partitions[] = {
-	{
-		.name	= "uboot",
-		.offset	= 0x0,
-		.size	= 0x10000,
-	},
-	{
-		.name	= "uboot_env",
-		.offset	= 0x10000,
-		.size	= 0x10000,
-	},
-	{
-		.name	= "linux",
-		.offset	= 0x20000,
-		.size	= 0xe0000,
-	},
-	{
-		.name	= "rootfs",
-		.offset	= 0x100000,
-		.size	= 0x300000,
-	},
-};
-
-static struct physmap_flash_data easy50712_flash_data = {
-	.nr_parts	= ARRAY_SIZE(easy50712_partitions),
-	.parts		= easy50712_partitions,
-};
-
-static struct ltq_pci_data ltq_pci_data = {
-	.clock	= PCI_CLOCK_INT,
-	.gpio	= PCI_GNT1 | PCI_REQ1,
-	.irq	= {
-		[14] = INT_NUM_IM0_IRL0 + 22,
-	},
-};
-
-static struct ltq_eth_data ltq_eth_data = {
-	.mii_mode = PHY_INTERFACE_MODE_MII,
-};
-
-static void __init easy50712_init(void)
-{
-	ltq_register_gpio_stp();
-	ltq_register_nor(&easy50712_flash_data);
-	ltq_register_pci(&ltq_pci_data);
-	ltq_register_etop(&ltq_eth_data);
-}
-
-MIPS_MACHINE(LTQ_MACH_EASY50712,
-	     "EASY50712",
-	     "EASY50712 Eval Board",
-	      easy50712_init);
diff --git a/arch/mips/lantiq/xway/setup-ase.c b/arch/mips/lantiq/xway/setup-ase.c
deleted file mode 100644
index f6f3267..0000000
--- a/arch/mips/lantiq/xway/setup-ase.c
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License version 2 as published
- *  by the Free Software Foundation.
- *
- *  Copyright (C) 2011 John Crispin <blogic@openwrt.org>
- */
-
-#include <lantiq_soc.h>
-
-#include "../prom.h"
-#include "devices.h"
-
-void __init ltq_soc_setup(void)
-{
-	ltq_register_ase_asc();
-	ltq_register_gpio();
-	ltq_register_wdt();
-}
diff --git a/arch/mips/lantiq/xway/setup-xway.c b/arch/mips/lantiq/xway/setup-xway.c
deleted file mode 100644
index c292f64..0000000
--- a/arch/mips/lantiq/xway/setup-xway.c
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License version 2 as published
- *  by the Free Software Foundation.
- *
- *  Copyright (C) 2011 John Crispin <blogic@openwrt.org>
- */
-
-#include <lantiq_soc.h>
-
-#include "../prom.h"
-#include "devices.h"
-
-void __init ltq_soc_setup(void)
-{
-	ltq_register_asc(0);
-	ltq_register_asc(1);
-	ltq_register_gpio();
-	ltq_register_wdt();
-}
-- 
1.7.9.1
