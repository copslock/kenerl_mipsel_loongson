Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Nov 2011 20:07:26 +0100 (CET)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:43882 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903694Ab1KATE3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Nov 2011 20:04:29 +0100
Received: by bkat2 with SMTP id t2so2658581bka.36
        for <multiple recipients>; Tue, 01 Nov 2011 12:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=aUZy6w3YW0kg8K3qNjmCikn7Cmh8xeFHLnuG53FEa8E=;
        b=pIVUBYZb2GIqoKJVnrV8VNhp0T5HeK2/wmATKCoLK55KN+nAIWJVzIS3k6uz/vyz+l
         BcMAZ8C4EvEMTAYqYtBDWRIhPj8jOnc/kwImyXdE3TG4m9DoCNOqXNRQTxmENLcR5h9P
         /CnSu7LRckpFR+VsjzKOR7SKBgYvjs52U2Qr0=
Received: by 10.223.91.68 with SMTP id l4mr2531933fam.16.1320174264143;
        Tue, 01 Nov 2011 12:04:24 -0700 (PDT)
Received: from localhost.localdomain (188-22-150-81.adsl.highway.telekom.at. [188.22.150.81])
        by mx.google.com with ESMTPS id a8sm327916faa.11.2011.11.01.12.04.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 Nov 2011 12:04:23 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 07/18] MIPS: Alchemy: merge GPR/MTX-1/XXS1500 board code into single files
Date:   Tue,  1 Nov 2011 20:03:33 +0100
Message-Id: <1320174224-27305-8-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1320174224-27305-1-git-send-email-manuel.lauss@googlemail.com>
References: <1320174224-27305-1-git-send-email-manuel.lauss@googlemail.com>
X-archive-position: 31347
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 657

Most of these files are have more comments than real code;  merge
them all into single board-<name>.c files.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 arch/mips/alchemy/Makefile              |    3 +
 arch/mips/alchemy/Platform              |    8 +-
 arch/mips/alchemy/board-gpr.c           |  303 ++++++++++++++++++++++++++++++
 arch/mips/alchemy/board-mtx1.c          |  313 +++++++++++++++++++++++++++++++
 arch/mips/alchemy/board-xxs1500.c       |  154 +++++++++++++++
 arch/mips/alchemy/gpr/Makefile          |    8 -
 arch/mips/alchemy/gpr/board_setup.c     |   75 --------
 arch/mips/alchemy/gpr/init.c            |   63 ------
 arch/mips/alchemy/gpr/platform.c        |  230 -----------------------
 arch/mips/alchemy/mtx-1/Makefile        |    9 -
 arch/mips/alchemy/mtx-1/board_setup.c   |   94 ---------
 arch/mips/alchemy/mtx-1/init.c          |   66 -------
 arch/mips/alchemy/mtx-1/platform.c      |  230 -----------------------
 arch/mips/alchemy/xxs1500/Makefile      |    8 -
 arch/mips/alchemy/xxs1500/board_setup.c |   93 ---------
 arch/mips/alchemy/xxs1500/init.c        |   63 ------
 arch/mips/alchemy/xxs1500/platform.c    |   63 ------
 17 files changed, 777 insertions(+), 1006 deletions(-)
 create mode 100644 arch/mips/alchemy/Makefile
 create mode 100644 arch/mips/alchemy/board-gpr.c
 create mode 100644 arch/mips/alchemy/board-mtx1.c
 create mode 100644 arch/mips/alchemy/board-xxs1500.c
 delete mode 100644 arch/mips/alchemy/gpr/Makefile
 delete mode 100644 arch/mips/alchemy/gpr/board_setup.c
 delete mode 100644 arch/mips/alchemy/gpr/init.c
 delete mode 100644 arch/mips/alchemy/gpr/platform.c
 delete mode 100644 arch/mips/alchemy/mtx-1/Makefile
 delete mode 100644 arch/mips/alchemy/mtx-1/board_setup.c
 delete mode 100644 arch/mips/alchemy/mtx-1/init.c
 delete mode 100644 arch/mips/alchemy/mtx-1/platform.c
 delete mode 100644 arch/mips/alchemy/xxs1500/Makefile
 delete mode 100644 arch/mips/alchemy/xxs1500/board_setup.c
 delete mode 100644 arch/mips/alchemy/xxs1500/init.c
 delete mode 100644 arch/mips/alchemy/xxs1500/platform.c

diff --git a/arch/mips/alchemy/Makefile b/arch/mips/alchemy/Makefile
new file mode 100644
index 0000000..aac3b17
--- /dev/null
+++ b/arch/mips/alchemy/Makefile
@@ -0,0 +1,3 @@
+obj-$(CONFIG_MIPS_GPR) += board-gpr.o
+obj-$(CONFIG_MIPS_MTX1) += board-mtx1.o
+obj-$(CONFIG_MIPS_XXS1500) += board-xxs1500.o
diff --git a/arch/mips/alchemy/Platform b/arch/mips/alchemy/Platform
index 4d13e21..c032f5b 100644
--- a/arch/mips/alchemy/Platform
+++ b/arch/mips/alchemy/Platform
@@ -75,21 +75,21 @@ cflags-$(CONFIG_MIPS_DB1300)	+= -I$(srctree)/arch/mips/include/asm/mach-db1x00
 load-$(CONFIG_MIPS_DB1300)	+= 0xffffffff80100000
 
 #
-# 4G-Systems eval board
+# 4G-Systems MTX-1 "MeshCube" wireless router
 #
-platform-$(CONFIG_MIPS_MTX1)	+= alchemy/mtx-1/
+platform-$(CONFIG_MIPS_MTX1)	+= alchemy/
 load-$(CONFIG_MIPS_MTX1)	+= 0xffffffff80100000
 
 #
 # MyCable eval board
 #
-platform-$(CONFIG_MIPS_XXS1500)	+= alchemy/xxs1500/
+platform-$(CONFIG_MIPS_XXS1500)	+= alchemy/
 load-$(CONFIG_MIPS_XXS1500)	+= 0xffffffff80100000
 
 #
 # Trapeze ITS GRP board
 #
-platform-$(CONFIG_MIPS_GPR)	+= alchemy/gpr/
+platform-$(CONFIG_MIPS_GPR)	+= alchemy/
 load-$(CONFIG_MIPS_GPR)		+= 0xffffffff80100000
 
 # boards can specify their own <gpio.h> in one of their include dirs.
diff --git a/arch/mips/alchemy/board-gpr.c b/arch/mips/alchemy/board-gpr.c
new file mode 100644
index 0000000..ba32590
--- /dev/null
+++ b/arch/mips/alchemy/board-gpr.c
@@ -0,0 +1,303 @@
+/*
+ * GPR board platform device registration (Au1550)
+ *
+ * Copyright (C) 2010 Wolfgang Grandegger <wg@denx.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/physmap.h>
+#include <linux/leds.h>
+#include <linux/gpio.h>
+#include <linux/i2c.h>
+#include <linux/i2c-gpio.h>
+#include <asm/bootinfo.h>
+#include <asm/reboot.h>
+#include <asm/mach-au1x00/au1000.h>
+#include <prom.h>
+
+const char *get_system_type(void)
+{
+	return "GPR";
+}
+
+void __init prom_init(void)
+{
+	unsigned char *memsize_str;
+	unsigned long memsize;
+
+	prom_argc = fw_arg0;
+	prom_argv = (char **)fw_arg1;
+	prom_envp = (char **)fw_arg2;
+
+	prom_init_cmdline();
+
+	memsize_str = prom_getenv("memsize");
+	if (!memsize_str)
+		memsize = 0x04000000;
+	else
+		strict_strtoul(memsize_str, 0, &memsize);
+	add_memory_region(0, memsize, BOOT_MEM_RAM);
+}
+
+void prom_putchar(unsigned char c)
+{
+	alchemy_uart_putchar(AU1000_UART0_PHYS_ADDR, c);
+}
+
+static void gpr_reset(char *c)
+{
+	/* switch System-LED to orange (red# and green# on) */
+	alchemy_gpio_direction_output(4, 0);
+	alchemy_gpio_direction_output(5, 0);
+
+	/* trigger watchdog to reset board in 200ms */
+	printk(KERN_EMERG "Triggering watchdog soft reset...\n");
+	raw_local_irq_disable();
+	alchemy_gpio_direction_output(1, 0);
+	udelay(1);
+	alchemy_gpio_set_value(1, 1);
+	while (1)
+		cpu_wait();
+}
+
+static void gpr_power_off(void)
+{
+	while (1)
+		cpu_wait();
+}
+
+void __init board_setup(void)
+{
+	printk(KERN_INFO "Trapeze ITS GPR board\n");
+
+	pm_power_off = gpr_power_off;
+	_machine_halt = gpr_power_off;
+	_machine_restart = gpr_reset;
+
+	/* Enable UART1/3 */
+	alchemy_uart_enable(AU1000_UART3_PHYS_ADDR);
+	alchemy_uart_enable(AU1000_UART1_PHYS_ADDR);
+
+	/* Take away Reset of UMTS-card */
+	alchemy_gpio_direction_output(215, 1);
+}
+
+/*
+ * Watchdog
+ */
+static struct resource gpr_wdt_resource[] = {
+	[0] = {
+		.start	= 1,
+		.end	= 1,
+		.name	= "gpr-adm6320-wdt",
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+static struct platform_device gpr_wdt_device = {
+	.name = "adm6320-wdt",
+	.id = 0,
+	.num_resources = ARRAY_SIZE(gpr_wdt_resource),
+	.resource = gpr_wdt_resource,
+};
+
+/*
+ * FLASH
+ *
+ * 0x00000000-0x00200000 : "kernel"
+ * 0x00200000-0x00a00000 : "rootfs"
+ * 0x01d00000-0x01f00000 : "config"
+ * 0x01c00000-0x01d00000 : "yamon"
+ * 0x01d00000-0x01d40000 : "yamon env vars"
+ * 0x00000000-0x00a00000 : "kernel+rootfs"
+ */
+static struct mtd_partition gpr_mtd_partitions[] = {
+	{
+		.name	= "kernel",
+		.size	= 0x00200000,
+		.offset	= 0,
+	},
+	{
+		.name	= "rootfs",
+		.size	= 0x00800000,
+		.offset	= MTDPART_OFS_APPEND,
+		.mask_flags = MTD_WRITEABLE,
+	},
+	{
+		.name	= "config",
+		.size	= 0x00200000,
+		.offset	= 0x01d00000,
+	},
+	{
+		.name	= "yamon",
+		.size	= 0x00100000,
+		.offset	= 0x01c00000,
+	},
+	{
+		.name	= "yamon env vars",
+		.size	= 0x00040000,
+		.offset	= MTDPART_OFS_APPEND,
+	},
+	{
+		.name	= "kernel+rootfs",
+		.size	= 0x00a00000,
+		.offset	= 0,
+	},
+};
+
+static struct physmap_flash_data gpr_flash_data = {
+	.width		= 4,
+	.nr_parts	= ARRAY_SIZE(gpr_mtd_partitions),
+	.parts		= gpr_mtd_partitions,
+};
+
+static struct resource gpr_mtd_resource = {
+	.start	= 0x1e000000,
+	.end	= 0x1fffffff,
+	.flags	= IORESOURCE_MEM,
+};
+
+static struct platform_device gpr_mtd_device = {
+	.name		= "physmap-flash",
+	.dev		= {
+		.platform_data	= &gpr_flash_data,
+	},
+	.num_resources	= 1,
+	.resource	= &gpr_mtd_resource,
+};
+
+/*
+ * LEDs
+ */
+static struct gpio_led gpr_gpio_leds[] = {
+	{	/* green */
+		.name			= "gpr:green",
+		.gpio			= 4,
+		.active_low		= 1,
+	},
+	{	/* red */
+		.name			= "gpr:red",
+		.gpio			= 5,
+		.active_low		= 1,
+	}
+};
+
+static struct gpio_led_platform_data gpr_led_data = {
+	.num_leds = ARRAY_SIZE(gpr_gpio_leds),
+	.leds = gpr_gpio_leds,
+};
+
+static struct platform_device gpr_led_devices = {
+	.name = "leds-gpio",
+	.id = -1,
+	.dev = {
+		.platform_data = &gpr_led_data,
+	}
+};
+
+/*
+ * I2C
+ */
+static struct i2c_gpio_platform_data gpr_i2c_data = {
+	.sda_pin		= 209,
+	.sda_is_open_drain	= 1,
+	.scl_pin		= 210,
+	.scl_is_open_drain	= 1,
+	.udelay			= 2,		/* ~100 kHz */
+	.timeout		= HZ,
+};
+
+static struct platform_device gpr_i2c_device = {
+	.name			= "i2c-gpio",
+	.id			= -1,
+	.dev.platform_data	= &gpr_i2c_data,
+};
+
+static struct i2c_board_info gpr_i2c_info[] __initdata = {
+	{
+		I2C_BOARD_INFO("lm83", 0x18),
+		.type = "lm83"
+	}
+};
+
+
+
+static struct resource alchemy_pci_host_res[] = {
+	[0] = {
+		.start	= AU1500_PCI_PHYS_ADDR,
+		.end	= AU1500_PCI_PHYS_ADDR + 0xfff,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static int gpr_map_pci_irq(const struct pci_dev *d, u8 slot, u8 pin)
+{
+	if ((slot == 0) && (pin == 1))
+		return AU1550_PCI_INTA;
+	else if ((slot == 0) && (pin == 2))
+		return AU1550_PCI_INTB;
+
+	return 0xff;
+}
+
+static struct alchemy_pci_platdata gpr_pci_pd = {
+	.board_map_irq	= gpr_map_pci_irq,
+	.pci_cfg_set	= PCI_CONFIG_AEN | PCI_CONFIG_R2H | PCI_CONFIG_R1H |
+			  PCI_CONFIG_CH |
+#if defined(__MIPSEB__)
+			  PCI_CONFIG_SIC_HWA_DAT | PCI_CONFIG_SM,
+#else
+			  0,
+#endif
+};
+
+static struct platform_device gpr_pci_host_dev = {
+	.dev.platform_data = &gpr_pci_pd,
+	.name		= "alchemy-pci",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(alchemy_pci_host_res),
+	.resource	= alchemy_pci_host_res,
+};
+
+static struct platform_device *gpr_devices[] __initdata = {
+	&gpr_wdt_device,
+	&gpr_mtd_device,
+	&gpr_i2c_device,
+	&gpr_led_devices,
+};
+
+static int __init gpr_pci_init(void)
+{
+	return platform_device_register(&gpr_pci_host_dev);
+}
+/* must be arch_initcall; MIPS PCI scans busses in a subsys_initcall */
+arch_initcall(gpr_pci_init);
+
+
+static int __init gpr_dev_init(void)
+{
+	i2c_register_board_info(0, gpr_i2c_info, ARRAY_SIZE(gpr_i2c_info));
+
+	return platform_add_devices(gpr_devices, ARRAY_SIZE(gpr_devices));
+}
+device_initcall(gpr_dev_init);
diff --git a/arch/mips/alchemy/board-mtx1.c b/arch/mips/alchemy/board-mtx1.c
new file mode 100644
index 0000000..295f1a9
--- /dev/null
+++ b/arch/mips/alchemy/board-mtx1.c
@@ -0,0 +1,313 @@
+/*
+ * MTX-1 platform devices registration (Au1500)
+ *
+ * Copyright (C) 2007-2009, Florian Fainelli <florian@openwrt.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/leds.h>
+#include <linux/gpio.h>
+#include <linux/gpio_keys.h>
+#include <linux/input.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/physmap.h>
+#include <mtd/mtd-abi.h>
+#include <asm/bootinfo.h>
+#include <asm/reboot.h>
+#include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-au1x00/au1xxx_eth.h>
+#include <prom.h>
+
+const char *get_system_type(void)
+{
+	return "MTX-1";
+}
+
+void __init prom_init(void)
+{
+	unsigned char *memsize_str;
+	unsigned long memsize;
+
+	prom_argc = fw_arg0;
+	prom_argv = (char **)fw_arg1;
+	prom_envp = (char **)fw_arg2;
+
+	prom_init_cmdline();
+
+	memsize_str = prom_getenv("memsize");
+	if (!memsize_str)
+		memsize = 0x04000000;
+	else
+		strict_strtoul(memsize_str, 0, &memsize);
+	add_memory_region(0, memsize, BOOT_MEM_RAM);
+}
+
+void prom_putchar(unsigned char c)
+{
+	alchemy_uart_putchar(AU1000_UART0_PHYS_ADDR, c);
+}
+
+static void mtx1_reset(char *c)
+{
+	/* Jump to the reset vector */
+	__asm__ __volatile__("jr\t%0" : : "r"(0xbfc00000));
+}
+
+static void mtx1_power_off(void)
+{
+	while (1)
+		asm volatile (
+		"	.set	mips32					\n"
+		"	wait						\n"
+		"	.set	mips0					\n");
+}
+
+void __init board_setup(void)
+{
+#if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
+	/* Enable USB power switch */
+	alchemy_gpio_direction_output(204, 0);
+#endif /* defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE) */
+
+	/* Initialize sys_pinfunc */
+	au_writel(SYS_PF_NI2, SYS_PINFUNC);
+
+	/* Initialize GPIO */
+	au_writel(~0, KSEG1ADDR(AU1000_SYS_PHYS_ADDR) + SYS_TRIOUTCLR);
+	alchemy_gpio_direction_output(0, 0);	/* Disable M66EN (PCI 66MHz) */
+	alchemy_gpio_direction_output(3, 1);	/* Disable PCI CLKRUN# */
+	alchemy_gpio_direction_output(1, 1);	/* Enable EXT_IO3 */
+	alchemy_gpio_direction_output(5, 0);	/* Disable eth PHY TX_ER */
+
+	/* Enable LED and set it to green */
+	alchemy_gpio_direction_output(211, 1);	/* green on */
+	alchemy_gpio_direction_output(212, 0);	/* red off */
+
+	pm_power_off = mtx1_power_off;
+	_machine_halt = mtx1_power_off;
+	_machine_restart = mtx1_reset;
+
+	printk(KERN_INFO "4G Systems MTX-1 Board\n");
+}
+
+/******************************************************************************/
+
+static struct gpio_keys_button mtx1_gpio_button[] = {
+	{
+		.gpio = 207,
+		.code = BTN_0,
+		.desc = "System button",
+	}
+};
+
+static struct gpio_keys_platform_data mtx1_buttons_data = {
+	.buttons = mtx1_gpio_button,
+	.nbuttons = ARRAY_SIZE(mtx1_gpio_button),
+};
+
+static struct platform_device mtx1_button = {
+	.name = "gpio-keys",
+	.id = -1,
+	.dev = {
+		.platform_data = &mtx1_buttons_data,
+	}
+};
+
+static struct resource mtx1_wdt_res[] = {
+	[0] = {
+		.start	= 215,
+		.end	= 215,
+		.name	= "mtx1-wdt-gpio",
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+static struct platform_device mtx1_wdt = {
+	.name = "mtx1-wdt",
+	.id = 0,
+	.num_resources = ARRAY_SIZE(mtx1_wdt_res),
+	.resource = mtx1_wdt_res,
+};
+
+static struct gpio_led default_leds[] = {
+	{
+		.name	= "mtx1:green",
+		.gpio = 211,
+	}, {
+		.name = "mtx1:red",
+		.gpio = 212,
+	},
+};
+
+static struct gpio_led_platform_data mtx1_led_data = {
+	.num_leds = ARRAY_SIZE(default_leds),
+	.leds = default_leds,
+};
+
+static struct platform_device mtx1_gpio_leds = {
+	.name = "leds-gpio",
+	.id = -1,
+	.dev = {
+		.platform_data = &mtx1_led_data,
+	}
+};
+
+static struct mtd_partition mtx1_mtd_partitions[] = {
+	{
+		.name	= "filesystem",
+		.size	= 0x01C00000,
+		.offset	= 0,
+	},
+	{
+		.name	= "yamon",
+		.size	= 0x00100000,
+		.offset	= MTDPART_OFS_APPEND,
+		.mask_flags = MTD_WRITEABLE,
+	},
+	{
+		.name	= "kernel",
+		.size	= 0x002c0000,
+		.offset	= MTDPART_OFS_APPEND,
+	},
+	{
+		.name	= "yamon env",
+		.size	= 0x00040000,
+		.offset	= MTDPART_OFS_APPEND,
+	},
+};
+
+static struct physmap_flash_data mtx1_flash_data = {
+	.width		= 4,
+	.nr_parts	= 4,
+	.parts		= mtx1_mtd_partitions,
+};
+
+static struct resource mtx1_mtd_resource = {
+	.start	= 0x1e000000,
+	.end	= 0x1fffffff,
+	.flags	= IORESOURCE_MEM,
+};
+
+static struct platform_device mtx1_mtd = {
+	.name		= "physmap-flash",
+	.dev		= {
+		.platform_data	= &mtx1_flash_data,
+	},
+	.num_resources	= 1,
+	.resource	= &mtx1_mtd_resource,
+};
+
+static struct resource alchemy_pci_host_res[] = {
+	[0] = {
+		.start	= AU1500_PCI_PHYS_ADDR,
+		.end	= AU1500_PCI_PHYS_ADDR + 0xfff,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static int mtx1_pci_idsel(unsigned int devsel, int assert)
+{
+	/* This function is only necessary to support a proprietary Cardbus
+	 * adapter on the mtx-1 "singleboard" variant. It triggers a custom
+	 * logic chip connected to EXT_IO3 (GPIO1) to suppress IDSEL signals.
+	 */
+	if (assert && devsel != 0)
+		/* Suppress signal to Cardbus */
+		alchemy_gpio_set_value(1, 0);	/* set EXT_IO3 OFF */
+	else
+		alchemy_gpio_set_value(1, 1);	/* set EXT_IO3 ON */
+
+	udelay(1);
+	return 1;
+}
+
+static const char mtx1_irqtab[][5] = {
+	[0] = { -1, AU1500_PCI_INTA, AU1500_PCI_INTA, 0xff, 0xff }, /* IDSEL 00 - AdapterA-Slot0 (top) */
+	[1] = { -1, AU1500_PCI_INTB, AU1500_PCI_INTA, 0xff, 0xff }, /* IDSEL 01 - AdapterA-Slot1 (bottom) */
+	[2] = { -1, AU1500_PCI_INTC, AU1500_PCI_INTD, 0xff, 0xff }, /* IDSEL 02 - AdapterB-Slot0 (top) */
+	[3] = { -1, AU1500_PCI_INTD, AU1500_PCI_INTC, 0xff, 0xff }, /* IDSEL 03 - AdapterB-Slot1 (bottom) */
+	[4] = { -1, AU1500_PCI_INTA, AU1500_PCI_INTB, 0xff, 0xff }, /* IDSEL 04 - AdapterC-Slot0 (top) */
+	[5] = { -1, AU1500_PCI_INTB, AU1500_PCI_INTA, 0xff, 0xff }, /* IDSEL 05 - AdapterC-Slot1 (bottom) */
+	[6] = { -1, AU1500_PCI_INTC, AU1500_PCI_INTD, 0xff, 0xff }, /* IDSEL 06 - AdapterD-Slot0 (top) */
+	[7] = { -1, AU1500_PCI_INTD, AU1500_PCI_INTC, 0xff, 0xff }, /* IDSEL 07 - AdapterD-Slot1 (bottom) */
+};
+
+static int mtx1_map_pci_irq(const struct pci_dev *d, u8 slot, u8 pin)
+{
+	return mtx1_irqtab[slot][pin];
+}
+
+static struct alchemy_pci_platdata mtx1_pci_pd = {
+	.board_map_irq	 = mtx1_map_pci_irq,
+	.board_pci_idsel = mtx1_pci_idsel,
+	.pci_cfg_set	 = PCI_CONFIG_AEN | PCI_CONFIG_R2H | PCI_CONFIG_R1H |
+			   PCI_CONFIG_CH |
+#if defined(__MIPSEB__)
+			   PCI_CONFIG_SIC_HWA_DAT | PCI_CONFIG_SM,
+#else
+			   0,
+#endif
+};
+
+static struct platform_device mtx1_pci_host = {
+	.dev.platform_data = &mtx1_pci_pd,
+	.name		= "alchemy-pci",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(alchemy_pci_host_res),
+	.resource	= alchemy_pci_host_res,
+};
+
+static struct __initdata platform_device * mtx1_devs[] = {
+	&mtx1_pci_host,
+	&mtx1_gpio_leds,
+	&mtx1_wdt,
+	&mtx1_button,
+	&mtx1_mtd,
+};
+
+static struct au1000_eth_platform_data mtx1_au1000_eth0_pdata = {
+	.phy_search_highest_addr	= 1,
+	.phy1_search_mac0		= 1,
+};
+
+static int __init mtx1_register_devices(void)
+{
+	int rc;
+
+	irq_set_irq_type(AU1500_GPIO204_INT, IRQ_TYPE_LEVEL_HIGH);
+	irq_set_irq_type(AU1500_GPIO201_INT, IRQ_TYPE_LEVEL_LOW);
+	irq_set_irq_type(AU1500_GPIO202_INT, IRQ_TYPE_LEVEL_LOW);
+	irq_set_irq_type(AU1500_GPIO203_INT, IRQ_TYPE_LEVEL_LOW);
+	irq_set_irq_type(AU1500_GPIO205_INT, IRQ_TYPE_LEVEL_LOW);
+
+	au1xxx_override_eth_cfg(0, &mtx1_au1000_eth0_pdata);
+
+	rc = gpio_request(mtx1_gpio_button[0].gpio,
+					mtx1_gpio_button[0].desc);
+	if (rc < 0) {
+		printk(KERN_INFO "mtx1: failed to request %d\n",
+					mtx1_gpio_button[0].gpio);
+		goto out;
+	}
+	gpio_direction_input(mtx1_gpio_button[0].gpio);
+out:
+	return platform_add_devices(mtx1_devs, ARRAY_SIZE(mtx1_devs));
+}
+arch_initcall(mtx1_register_devices);
diff --git a/arch/mips/alchemy/board-xxs1500.c b/arch/mips/alchemy/board-xxs1500.c
new file mode 100644
index 0000000..bd55136
--- /dev/null
+++ b/arch/mips/alchemy/board-xxs1500.c
@@ -0,0 +1,154 @@
+/*
+ * BRIEF MODULE DESCRIPTION
+ *	MyCable XXS1500 board support
+ *
+ * Copyright 2003, 2008 MontaVista Software Inc.
+ * Author: MontaVista Software, Inc. <source@mvista.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/gpio.h>
+#include <linux/delay.h>
+#include <linux/pm.h>
+#include <asm/bootinfo.h>
+#include <asm/reboot.h>
+#include <asm/mach-au1x00/au1000.h>
+#include <prom.h>
+
+const char *get_system_type(void)
+{
+	return "XXS1500";
+}
+
+void __init prom_init(void)
+{
+	unsigned char *memsize_str;
+	unsigned long memsize;
+
+	prom_argc = fw_arg0;
+	prom_argv = (char **)fw_arg1;
+	prom_envp = (char **)fw_arg2;
+
+	prom_init_cmdline();
+
+	memsize_str = prom_getenv("memsize");
+	if (!memsize_str || strict_strtoul(memsize_str, 0, &memsize))
+		memsize = 0x04000000;
+
+	add_memory_region(0, memsize, BOOT_MEM_RAM);
+}
+
+void prom_putchar(unsigned char c)
+{
+	alchemy_uart_putchar(AU1000_UART0_PHYS_ADDR, c);
+}
+
+static void xxs1500_reset(char *c)
+{
+	/* Jump to the reset vector */
+	__asm__ __volatile__("jr\t%0" : : "r"(0xbfc00000));
+}
+
+static void xxs1500_power_off(void)
+{
+	while (1)
+		asm volatile (
+		"	.set	mips32					\n"
+		"	wait						\n"
+		"	.set	mips0					\n");
+}
+
+void __init board_setup(void)
+{
+	u32 pin_func;
+
+	pm_power_off = xxs1500_power_off;
+	_machine_halt = xxs1500_power_off;
+	_machine_restart = xxs1500_reset;
+
+	alchemy_gpio1_input_enable();
+	alchemy_gpio2_enable();
+
+	/* Set multiple use pins (UART3/GPIO) to UART (it's used as UART too) */
+	pin_func  = au_readl(SYS_PINFUNC) & ~SYS_PF_UR3;
+	pin_func |= SYS_PF_UR3;
+	au_writel(pin_func, SYS_PINFUNC);
+
+	/* Enable UART */
+	alchemy_uart_enable(AU1000_UART3_PHYS_ADDR);
+	/* Enable DTR (MCR bit 0) = USB power up */
+	__raw_writel(1, (void __iomem *)KSEG1ADDR(AU1000_UART3_PHYS_ADDR + 0x18));
+	wmb();
+}
+
+/******************************************************************************/
+
+static struct resource xxs1500_pcmcia_res[] = {
+	{
+		.name	= "pcmcia-io",
+		.flags	= IORESOURCE_MEM,
+		.start	= AU1000_PCMCIA_IO_PHYS_ADDR,
+		.end	= AU1000_PCMCIA_IO_PHYS_ADDR + 0x000400000 - 1,
+	},
+	{
+		.name	= "pcmcia-attr",
+		.flags	= IORESOURCE_MEM,
+		.start	= AU1000_PCMCIA_ATTR_PHYS_ADDR,
+		.end	= AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x000400000 - 1,
+	},
+	{
+		.name	= "pcmcia-mem",
+		.flags	= IORESOURCE_MEM,
+		.start	= AU1000_PCMCIA_MEM_PHYS_ADDR,
+		.end	= AU1000_PCMCIA_MEM_PHYS_ADDR + 0x000400000 - 1,
+	},
+};
+
+static struct platform_device xxs1500_pcmcia_dev = {
+	.name		= "xxs1500_pcmcia",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(xxs1500_pcmcia_res),
+	.resource	= xxs1500_pcmcia_res,
+};
+
+static struct platform_device *xxs1500_devs[] __initdata = {
+	&xxs1500_pcmcia_dev,
+};
+
+static int __init xxs1500_dev_init(void)
+{
+	irq_set_irq_type(AU1500_GPIO204_INT, IRQ_TYPE_LEVEL_HIGH);
+	irq_set_irq_type(AU1500_GPIO201_INT, IRQ_TYPE_LEVEL_LOW);
+	irq_set_irq_type(AU1500_GPIO202_INT, IRQ_TYPE_LEVEL_LOW);
+	irq_set_irq_type(AU1500_GPIO203_INT, IRQ_TYPE_LEVEL_LOW);
+	irq_set_irq_type(AU1500_GPIO205_INT, IRQ_TYPE_LEVEL_LOW);
+	irq_set_irq_type(AU1500_GPIO207_INT, IRQ_TYPE_LEVEL_LOW);
+
+	irq_set_irq_type(AU1500_GPIO0_INT, IRQ_TYPE_LEVEL_LOW);
+	irq_set_irq_type(AU1500_GPIO1_INT, IRQ_TYPE_LEVEL_LOW);
+	irq_set_irq_type(AU1500_GPIO2_INT, IRQ_TYPE_LEVEL_LOW);
+	irq_set_irq_type(AU1500_GPIO3_INT, IRQ_TYPE_LEVEL_LOW);
+	irq_set_irq_type(AU1500_GPIO4_INT, IRQ_TYPE_LEVEL_LOW); /* CF irq */
+	irq_set_irq_type(AU1500_GPIO5_INT, IRQ_TYPE_LEVEL_LOW);
+
+	return platform_add_devices(xxs1500_devs,
+				    ARRAY_SIZE(xxs1500_devs));
+}
+device_initcall(xxs1500_dev_init);
diff --git a/arch/mips/alchemy/gpr/Makefile b/arch/mips/alchemy/gpr/Makefile
deleted file mode 100644
index cb73fe2..0000000
--- a/arch/mips/alchemy/gpr/Makefile
+++ /dev/null
@@ -1,8 +0,0 @@
-#
-#  Copyright 2003 MontaVista Software Inc.
-#  Author: MontaVista Software, Inc. <source@mvista.com>
-#
-# Makefile for Trapeze ITS GPR board.
-#
-
-obj-y += board_setup.o init.o platform.o
diff --git a/arch/mips/alchemy/gpr/board_setup.c b/arch/mips/alchemy/gpr/board_setup.c
deleted file mode 100644
index dea45c7..0000000
--- a/arch/mips/alchemy/gpr/board_setup.c
+++ /dev/null
@@ -1,75 +0,0 @@
-/*
- * Copyright 2010 Wolfgang Grandegger <wg@denx.de>
- *
- * Copyright 2000-2003, 2008 MontaVista Software Inc.
- * Author: MontaVista Software, Inc. <source@mvista.com>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/gpio.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/delay.h>
-#include <linux/pm.h>
-
-#include <asm/reboot.h>
-#include <asm/mach-au1x00/au1000.h>
-
-#include <prom.h>
-
-static void gpr_reset(char *c)
-{
-	/* switch System-LED to orange (red# and green# on) */
-	alchemy_gpio_direction_output(4, 0);
-	alchemy_gpio_direction_output(5, 0);
-
-	/* trigger watchdog to reset board in 200ms */
-	printk(KERN_EMERG "Triggering watchdog soft reset...\n");
-	raw_local_irq_disable();
-	alchemy_gpio_direction_output(1, 0);
-	udelay(1);
-	alchemy_gpio_set_value(1, 1);
-	while (1)
-		cpu_wait();
-}
-
-static void gpr_power_off(void)
-{
-	while (1)
-		cpu_wait();
-}
-
-void __init board_setup(void)
-{
-	printk(KERN_INFO "Trapeze ITS GPR board\n");
-
-	pm_power_off = gpr_power_off;
-	_machine_halt = gpr_power_off;
-	_machine_restart = gpr_reset;
-
-	/* Enable UART1/3 */
-	alchemy_uart_enable(AU1000_UART3_PHYS_ADDR);
-	alchemy_uart_enable(AU1000_UART1_PHYS_ADDR);
-
-	/* Take away Reset of UMTS-card */
-	alchemy_gpio_direction_output(215, 1);
-}
diff --git a/arch/mips/alchemy/gpr/init.c b/arch/mips/alchemy/gpr/init.c
deleted file mode 100644
index 229aafa..0000000
--- a/arch/mips/alchemy/gpr/init.c
+++ /dev/null
@@ -1,63 +0,0 @@
-/*
- * Copyright 2010 Wolfgang Grandegger <wg@denx.de>
- *
- * Copyright 2003, 2008 MontaVista Software Inc.
- * Author: MontaVista Software, Inc. <source@mvista.com>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/init.h>
-#include <linux/kernel.h>
-
-#include <asm/bootinfo.h>
-#include <asm/mach-au1x00/au1000.h>
-
-#include <prom.h>
-
-const char *get_system_type(void)
-{
-	return "GPR";
-}
-
-void __init prom_init(void)
-{
-	unsigned char *memsize_str;
-	unsigned long memsize;
-
-	prom_argc = fw_arg0;
-	prom_argv = (char **)fw_arg1;
-	prom_envp = (char **)fw_arg2;
-
-	prom_init_cmdline();
-
-	memsize_str = prom_getenv("memsize");
-	if (!memsize_str)
-		memsize = 0x04000000;
-	else
-		strict_strtoul(memsize_str, 0, &memsize);
-	add_memory_region(0, memsize, BOOT_MEM_RAM);
-}
-
-void prom_putchar(unsigned char c)
-{
-	alchemy_uart_putchar(AU1000_UART0_PHYS_ADDR, c);
-}
diff --git a/arch/mips/alchemy/gpr/platform.c b/arch/mips/alchemy/gpr/platform.c
deleted file mode 100644
index 982ce85..0000000
--- a/arch/mips/alchemy/gpr/platform.c
+++ /dev/null
@@ -1,230 +0,0 @@
-/*
- * GPR board platform device registration
- *
- * Copyright (C) 2010 Wolfgang Grandegger <wg@denx.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/mtd/partitions.h>
-#include <linux/mtd/physmap.h>
-#include <linux/leds.h>
-#include <linux/gpio.h>
-#include <linux/i2c.h>
-#include <linux/i2c-gpio.h>
-
-#include <asm/mach-au1x00/au1000.h>
-
-/*
- * Watchdog
- */
-static struct resource gpr_wdt_resource[] = {
-	[0] = {
-		.start	= 1,
-		.end	= 1,
-		.name	= "gpr-adm6320-wdt",
-		.flags	= IORESOURCE_IRQ,
-	}
-};
-
-static struct platform_device gpr_wdt_device = {
-	.name = "adm6320-wdt",
-	.id = 0,
-	.num_resources = ARRAY_SIZE(gpr_wdt_resource),
-	.resource = gpr_wdt_resource,
-};
-
-/*
- * FLASH
- *
- * 0x00000000-0x00200000 : "kernel"
- * 0x00200000-0x00a00000 : "rootfs"
- * 0x01d00000-0x01f00000 : "config"
- * 0x01c00000-0x01d00000 : "yamon"
- * 0x01d00000-0x01d40000 : "yamon env vars"
- * 0x00000000-0x00a00000 : "kernel+rootfs"
- */
-static struct mtd_partition gpr_mtd_partitions[] = {
-	{
-		.name	= "kernel",
-		.size	= 0x00200000,
-		.offset	= 0,
-	},
-	{
-		.name	= "rootfs",
-		.size	= 0x00800000,
-		.offset	= MTDPART_OFS_APPEND,
-		.mask_flags = MTD_WRITEABLE,
-	},
-	{
-		.name	= "config",
-		.size	= 0x00200000,
-		.offset	= 0x01d00000,
-	},
-	{
-		.name	= "yamon",
-		.size	= 0x00100000,
-		.offset	= 0x01c00000,
-	},
-	{
-		.name	= "yamon env vars",
-		.size	= 0x00040000,
-		.offset	= MTDPART_OFS_APPEND,
-	},
-	{
-		.name	= "kernel+rootfs",
-		.size	= 0x00a00000,
-		.offset	= 0,
-	},
-};
-
-static struct physmap_flash_data gpr_flash_data = {
-	.width		= 4,
-	.nr_parts	= ARRAY_SIZE(gpr_mtd_partitions),
-	.parts		= gpr_mtd_partitions,
-};
-
-static struct resource gpr_mtd_resource = {
-	.start	= 0x1e000000,
-	.end	= 0x1fffffff,
-	.flags	= IORESOURCE_MEM,
-};
-
-static struct platform_device gpr_mtd_device = {
-	.name		= "physmap-flash",
-	.dev		= {
-		.platform_data	= &gpr_flash_data,
-	},
-	.num_resources	= 1,
-	.resource	= &gpr_mtd_resource,
-};
-
-/*
- * LEDs
- */
-static struct gpio_led gpr_gpio_leds[] = {
-	{	/* green */
-		.name			= "gpr:green",
-		.gpio			= 4,
-		.active_low		= 1,
-	},
-	{	/* red */
-		.name			= "gpr:red",
-		.gpio			= 5,
-		.active_low		= 1,
-	}
-};
-
-static struct gpio_led_platform_data gpr_led_data = {
-	.num_leds = ARRAY_SIZE(gpr_gpio_leds),
-	.leds = gpr_gpio_leds,
-};
-
-static struct platform_device gpr_led_devices = {
-	.name = "leds-gpio",
-	.id = -1,
-	.dev = {
-		.platform_data = &gpr_led_data,
-	}
-};
-
-/*
- * I2C
- */
-static struct i2c_gpio_platform_data gpr_i2c_data = {
-	.sda_pin		= 209,
-	.sda_is_open_drain	= 1,
-	.scl_pin		= 210,
-	.scl_is_open_drain	= 1,
-	.udelay			= 2,		/* ~100 kHz */
-	.timeout		= HZ,
- };
-
-static struct platform_device gpr_i2c_device = {
-	.name			= "i2c-gpio",
-	.id			= -1,
-	.dev.platform_data	= &gpr_i2c_data,
-};
-
-static struct i2c_board_info gpr_i2c_info[] __initdata = {
-	{
-		I2C_BOARD_INFO("lm83", 0x18),
-		.type = "lm83"
-	}
-};
-
-
-
-static struct resource alchemy_pci_host_res[] = {
-	[0] = {
-		.start	= AU1500_PCI_PHYS_ADDR,
-		.end	= AU1500_PCI_PHYS_ADDR + 0xfff,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-static int gpr_map_pci_irq(const struct pci_dev *d, u8 slot, u8 pin)
-{
-	if ((slot == 0) && (pin == 1))
-		return AU1550_PCI_INTA;
-	else if ((slot == 0) && (pin == 2))
-		return AU1550_PCI_INTB;
-
-	return -1;
-}
-
-static struct alchemy_pci_platdata gpr_pci_pd = {
-	.board_map_irq	= gpr_map_pci_irq,
-	.pci_cfg_set	= PCI_CONFIG_AEN | PCI_CONFIG_R2H | PCI_CONFIG_R1H |
-			  PCI_CONFIG_CH |
-#if defined(__MIPSEB__)
-			  PCI_CONFIG_SIC_HWA_DAT | PCI_CONFIG_SM,
-#else
-			  0,
-#endif
-};
-
-static struct platform_device gpr_pci_host_dev = {
-	.dev.platform_data = &gpr_pci_pd,
-	.name		= "alchemy-pci",
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(alchemy_pci_host_res),
-	.resource	= alchemy_pci_host_res,
-};
-
-static struct platform_device *gpr_devices[] __initdata = {
-	&gpr_wdt_device,
-	&gpr_mtd_device,
-	&gpr_i2c_device,
-	&gpr_led_devices,
-};
-
-static int __init gpr_pci_init(void)
-{
-	return platform_device_register(&gpr_pci_host_dev);
-}
-/* must be arch_initcall; MIPS PCI scans busses in a subsys_initcall */
-arch_initcall(gpr_pci_init);
-
-
-static int __init gpr_dev_init(void)
-{
-	i2c_register_board_info(0, gpr_i2c_info, ARRAY_SIZE(gpr_i2c_info));
-
-	return platform_add_devices(gpr_devices, ARRAY_SIZE(gpr_devices));
-}
-device_initcall(gpr_dev_init);
diff --git a/arch/mips/alchemy/mtx-1/Makefile b/arch/mips/alchemy/mtx-1/Makefile
deleted file mode 100644
index 81b540c..0000000
--- a/arch/mips/alchemy/mtx-1/Makefile
+++ /dev/null
@@ -1,9 +0,0 @@
-#
-#  Copyright 2003 MontaVista Software Inc.
-#  Author: MontaVista Software, Inc. <source@mvista.com>
-#       Bruno Randolf <bruno.randolf@4g-systems.biz>
-#
-# Makefile for 4G Systems MTX-1 board.
-#
-
-obj-y += init.o board_setup.o platform.o
diff --git a/arch/mips/alchemy/mtx-1/board_setup.c b/arch/mips/alchemy/mtx-1/board_setup.c
deleted file mode 100644
index 851a5ab..0000000
--- a/arch/mips/alchemy/mtx-1/board_setup.c
+++ /dev/null
@@ -1,94 +0,0 @@
-/*
- *
- * BRIEF MODULE DESCRIPTION
- *	4G Systems MTX-1 board setup.
- *
- * Copyright 2003, 2008 MontaVista Software Inc.
- * Author: MontaVista Software, Inc. <source@mvista.com>
- *         Bruno Randolf <bruno.randolf@4g-systems.biz>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/gpio.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/pm.h>
-
-#include <asm/reboot.h>
-#include <asm/mach-au1x00/au1000.h>
-
-#include <prom.h>
-
-static void mtx1_reset(char *c)
-{
-	/* Jump to the reset vector */
-	__asm__ __volatile__("jr\t%0"::"r"(0xbfc00000));
-}
-
-static void mtx1_power_off(void)
-{
-	while (1)
-		asm volatile (
-		"	.set	mips32					\n"
-		"	wait						\n"
-		"	.set	mips0					\n");
-}
-
-void __init board_setup(void)
-{
-#if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
-	/* Enable USB power switch */
-	alchemy_gpio_direction_output(204, 0);
-#endif /* defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE) */
-
-	/* Initialize sys_pinfunc */
-	au_writel(SYS_PF_NI2, SYS_PINFUNC);
-
-	/* Initialize GPIO */
-	au_writel(~0, KSEG1ADDR(AU1000_SYS_PHYS_ADDR) + SYS_TRIOUTCLR);
-	alchemy_gpio_direction_output(0, 0);	/* Disable M66EN (PCI 66MHz) */
-	alchemy_gpio_direction_output(3, 1);	/* Disable PCI CLKRUN# */
-	alchemy_gpio_direction_output(1, 1);	/* Enable EXT_IO3 */
-	alchemy_gpio_direction_output(5, 0);	/* Disable eth PHY TX_ER */
-
-	/* Enable LED and set it to green */
-	alchemy_gpio_direction_output(211, 1);	/* green on */
-	alchemy_gpio_direction_output(212, 0);	/* red off */
-
-	pm_power_off = mtx1_power_off;
-	_machine_halt = mtx1_power_off;
-	_machine_restart = mtx1_reset;
-
-	printk(KERN_INFO "4G Systems MTX-1 Board\n");
-}
-
-static int __init mtx1_init_irq(void)
-{
-	irq_set_irq_type(AU1500_GPIO204_INT, IRQF_TRIGGER_HIGH);
-	irq_set_irq_type(AU1500_GPIO201_INT, IRQF_TRIGGER_LOW);
-	irq_set_irq_type(AU1500_GPIO202_INT, IRQF_TRIGGER_LOW);
-	irq_set_irq_type(AU1500_GPIO203_INT, IRQF_TRIGGER_LOW);
-	irq_set_irq_type(AU1500_GPIO205_INT, IRQF_TRIGGER_LOW);
-
-	return 0;
-}
-arch_initcall(mtx1_init_irq);
diff --git a/arch/mips/alchemy/mtx-1/init.c b/arch/mips/alchemy/mtx-1/init.c
deleted file mode 100644
index 2e81cc7..0000000
--- a/arch/mips/alchemy/mtx-1/init.c
+++ /dev/null
@@ -1,66 +0,0 @@
-/*
- *
- * BRIEF MODULE DESCRIPTION
- *	4G Systems MTX-1 board setup
- *
- * Copyright 2003, 2008 MontaVista Software Inc.
- * Author: MontaVista Software, Inc. <source@mvista.com>
- *         Bruno Randolf <bruno.randolf@4g-systems.biz>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-
-#include <asm/bootinfo.h>
-#include <asm/mach-au1x00/au1000.h>
-
-#include <prom.h>
-
-const char *get_system_type(void)
-{
-	return "MTX-1";
-}
-
-void __init prom_init(void)
-{
-	unsigned char *memsize_str;
-	unsigned long memsize;
-
-	prom_argc = fw_arg0;
-	prom_argv = (char **)fw_arg1;
-	prom_envp = (char **)fw_arg2;
-
-	prom_init_cmdline();
-
-	memsize_str = prom_getenv("memsize");
-	if (!memsize_str)
-		memsize = 0x04000000;
-	else
-		strict_strtoul(memsize_str, 0, &memsize);
-	add_memory_region(0, memsize, BOOT_MEM_RAM);
-}
-
-void prom_putchar(unsigned char c)
-{
-	alchemy_uart_putchar(AU1000_UART0_PHYS_ADDR, c);
-}
diff --git a/arch/mips/alchemy/mtx-1/platform.c b/arch/mips/alchemy/mtx-1/platform.c
deleted file mode 100644
index cc47b68..0000000
--- a/arch/mips/alchemy/mtx-1/platform.c
+++ /dev/null
@@ -1,230 +0,0 @@
-/*
- * MTX-1 platform devices registration
- *
- * Copyright (C) 2007-2009, Florian Fainelli <florian@openwrt.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/leds.h>
-#include <linux/gpio.h>
-#include <linux/gpio_keys.h>
-#include <linux/input.h>
-#include <linux/mtd/partitions.h>
-#include <linux/mtd/physmap.h>
-#include <mtd/mtd-abi.h>
-
-#include <asm/mach-au1x00/au1xxx_eth.h>
-
-static struct gpio_keys_button mtx1_gpio_button[] = {
-	{
-		.gpio = 207,
-		.code = BTN_0,
-		.desc = "System button",
-	}
-};
-
-static struct gpio_keys_platform_data mtx1_buttons_data = {
-	.buttons = mtx1_gpio_button,
-	.nbuttons = ARRAY_SIZE(mtx1_gpio_button),
-};
-
-static struct platform_device mtx1_button = {
-	.name = "gpio-keys",
-	.id = -1,
-	.dev = {
-		.platform_data = &mtx1_buttons_data,
-	}
-};
-
-static struct resource mtx1_wdt_res[] = {
-	[0] = {
-		.start	= 215,
-		.end	= 215,
-		.name	= "mtx1-wdt-gpio",
-		.flags	= IORESOURCE_IRQ,
-	}
-};
-
-static struct platform_device mtx1_wdt = {
-	.name = "mtx1-wdt",
-	.id = 0,
-	.num_resources = ARRAY_SIZE(mtx1_wdt_res),
-	.resource = mtx1_wdt_res,
-};
-
-static struct gpio_led default_leds[] = {
-	{
-		.name	= "mtx1:green",
-		.gpio = 211,
-	}, {
-		.name = "mtx1:red",
-		.gpio = 212,
-	},
-};
-
-static struct gpio_led_platform_data mtx1_led_data = {
-	.num_leds = ARRAY_SIZE(default_leds),
-	.leds = default_leds,
-};
-
-static struct platform_device mtx1_gpio_leds = {
-	.name = "leds-gpio",
-	.id = -1,
-	.dev = {
-		.platform_data = &mtx1_led_data,
-	}
-};
-
-static struct mtd_partition mtx1_mtd_partitions[] = {
-	{
-		.name	= "filesystem",
-		.size	= 0x01C00000,
-		.offset	= 0,
-	},
-	{
-		.name	= "yamon",
-		.size	= 0x00100000,
-		.offset	= MTDPART_OFS_APPEND,
-		.mask_flags = MTD_WRITEABLE,
-	},
-	{
-		.name	= "kernel",
-		.size	= 0x002c0000,
-		.offset	= MTDPART_OFS_APPEND,
-	},
-	{
-		.name	= "yamon env",
-		.size	= 0x00040000,
-		.offset	= MTDPART_OFS_APPEND,
-	},
-};
-
-static struct physmap_flash_data mtx1_flash_data = {
-	.width		= 4,
-	.nr_parts	= 4,
-	.parts		= mtx1_mtd_partitions,
-};
-
-static struct resource mtx1_mtd_resource = {
-	.start	= 0x1e000000,
-	.end	= 0x1fffffff,
-	.flags	= IORESOURCE_MEM,
-};
-
-static struct platform_device mtx1_mtd = {
-	.name		= "physmap-flash",
-	.dev		= {
-		.platform_data	= &mtx1_flash_data,
-	},
-	.num_resources	= 1,
-	.resource	= &mtx1_mtd_resource,
-};
-
-static struct resource alchemy_pci_host_res[] = {
-	[0] = {
-		.start	= AU1500_PCI_PHYS_ADDR,
-		.end	= AU1500_PCI_PHYS_ADDR + 0xfff,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-static int mtx1_pci_idsel(unsigned int devsel, int assert)
-{
-	/* This function is only necessary to support a proprietary Cardbus
-	 * adapter on the mtx-1 "singleboard" variant. It triggers a custom
-	 * logic chip connected to EXT_IO3 (GPIO1) to suppress IDSEL signals.
-	 */
-	if (assert && devsel != 0)
-		/* Suppress signal to Cardbus */
-		alchemy_gpio_set_value(1, 0);	/* set EXT_IO3 OFF */
-	else
-		alchemy_gpio_set_value(1, 1);	/* set EXT_IO3 ON */
-
-	udelay(1);
-	return 1;
-}
-
-static const char mtx1_irqtab[][5] = {
-	[0] = { -1, AU1500_PCI_INTA, AU1500_PCI_INTA, 0xff, 0xff }, /* IDSEL 00 - AdapterA-Slot0 (top) */
-	[1] = { -1, AU1500_PCI_INTB, AU1500_PCI_INTA, 0xff, 0xff }, /* IDSEL 01 - AdapterA-Slot1 (bottom) */
-	[2] = { -1, AU1500_PCI_INTC, AU1500_PCI_INTD, 0xff, 0xff }, /* IDSEL 02 - AdapterB-Slot0 (top) */
-	[3] = { -1, AU1500_PCI_INTD, AU1500_PCI_INTC, 0xff, 0xff }, /* IDSEL 03 - AdapterB-Slot1 (bottom) */
-	[4] = { -1, AU1500_PCI_INTA, AU1500_PCI_INTB, 0xff, 0xff }, /* IDSEL 04 - AdapterC-Slot0 (top) */
-	[5] = { -1, AU1500_PCI_INTB, AU1500_PCI_INTA, 0xff, 0xff }, /* IDSEL 05 - AdapterC-Slot1 (bottom) */
-	[6] = { -1, AU1500_PCI_INTC, AU1500_PCI_INTD, 0xff, 0xff }, /* IDSEL 06 - AdapterD-Slot0 (top) */
-	[7] = { -1, AU1500_PCI_INTD, AU1500_PCI_INTC, 0xff, 0xff }, /* IDSEL 07 - AdapterD-Slot1 (bottom) */
-};
-
-static int mtx1_map_pci_irq(const struct pci_dev *d, u8 slot, u8 pin)
-{
-	return mtx1_irqtab[slot][pin];
-}
-
-static struct alchemy_pci_platdata mtx1_pci_pd = {
-	.board_map_irq	 = mtx1_map_pci_irq,
-	.board_pci_idsel = mtx1_pci_idsel,
-	.pci_cfg_set	 = PCI_CONFIG_AEN | PCI_CONFIG_R2H | PCI_CONFIG_R1H |
-			   PCI_CONFIG_CH |
-#if defined(__MIPSEB__)
-			   PCI_CONFIG_SIC_HWA_DAT | PCI_CONFIG_SM,
-#else
-			   0,
-#endif
-};
-
-static struct platform_device mtx1_pci_host = {
-	.dev.platform_data = &mtx1_pci_pd,
-	.name		= "alchemy-pci",
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(alchemy_pci_host_res),
-	.resource	= alchemy_pci_host_res,
-};
-
-
-static struct __initdata platform_device * mtx1_devs[] = {
-	&mtx1_pci_host,
-	&mtx1_gpio_leds,
-	&mtx1_wdt,
-	&mtx1_button,
-	&mtx1_mtd,
-};
-
-static struct au1000_eth_platform_data mtx1_au1000_eth0_pdata = {
-	.phy_search_highest_addr	= 1,
-	.phy1_search_mac0 		= 1,
-};
-
-static int __init mtx1_register_devices(void)
-{
-	int rc;
-
-	au1xxx_override_eth_cfg(0, &mtx1_au1000_eth0_pdata);
-
-	rc = gpio_request(mtx1_gpio_button[0].gpio,
-					mtx1_gpio_button[0].desc);
-	if (rc < 0) {
-		printk(KERN_INFO "mtx1: failed to request %d\n",
-					mtx1_gpio_button[0].gpio);
-		goto out;
-	}
-	gpio_direction_input(mtx1_gpio_button[0].gpio);
-out:
-	return platform_add_devices(mtx1_devs, ARRAY_SIZE(mtx1_devs));
-}
-
-arch_initcall(mtx1_register_devices);
diff --git a/arch/mips/alchemy/xxs1500/Makefile b/arch/mips/alchemy/xxs1500/Makefile
deleted file mode 100644
index 91defcf..0000000
--- a/arch/mips/alchemy/xxs1500/Makefile
+++ /dev/null
@@ -1,8 +0,0 @@
-#
-#  Copyright 2003 MontaVista Software Inc.
-#  Author: MontaVista Software, Inc. <source@mvista.com>
-#
-# Makefile for MyCable XXS1500 board.
-#
-
-obj-y += init.o board_setup.o platform.o
diff --git a/arch/mips/alchemy/xxs1500/board_setup.c b/arch/mips/alchemy/xxs1500/board_setup.c
deleted file mode 100644
index 3fa83f7..0000000
--- a/arch/mips/alchemy/xxs1500/board_setup.c
+++ /dev/null
@@ -1,93 +0,0 @@
-/*
- * Copyright 2000-2003, 2008 MontaVista Software Inc.
- * Author: MontaVista Software, Inc. <source@mvista.com>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/gpio.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/delay.h>
-#include <linux/pm.h>
-
-#include <asm/reboot.h>
-#include <asm/mach-au1x00/au1000.h>
-
-#include <prom.h>
-
-static void xxs1500_reset(char *c)
-{
-	/* Jump to the reset vector */
-	__asm__ __volatile__("jr\t%0"::"r"(0xbfc00000));
-}
-
-static void xxs1500_power_off(void)
-{
-	while (1)
-		asm volatile (
-		"	.set	mips32					\n"
-		"	wait						\n"
-		"	.set	mips0					\n");
-}
-
-void __init board_setup(void)
-{
-	u32 pin_func;
-
-	pm_power_off = xxs1500_power_off;
-	_machine_halt = xxs1500_power_off;
-	_machine_restart = xxs1500_reset;
-
-	alchemy_gpio1_input_enable();
-	alchemy_gpio2_enable();
-
-	/* Set multiple use pins (UART3/GPIO) to UART (it's used as UART too) */
-	pin_func  = au_readl(SYS_PINFUNC) & ~SYS_PF_UR3;
-	pin_func |= SYS_PF_UR3;
-	au_writel(pin_func, SYS_PINFUNC);
-
-	/* Enable UART */
-	alchemy_uart_enable(AU1000_UART3_PHYS_ADDR);
-	/* Enable DTR (MCR bit 0) = USB power up */
-	__raw_writel(1, (void __iomem *)KSEG1ADDR(AU1000_UART3_PHYS_ADDR + 0x18));
-	wmb();
-}
-
-static int __init xxs1500_init_irq(void)
-{
-	irq_set_irq_type(AU1500_GPIO204_INT, IRQF_TRIGGER_HIGH);
-	irq_set_irq_type(AU1500_GPIO201_INT, IRQF_TRIGGER_LOW);
-	irq_set_irq_type(AU1500_GPIO202_INT, IRQF_TRIGGER_LOW);
-	irq_set_irq_type(AU1500_GPIO203_INT, IRQF_TRIGGER_LOW);
-	irq_set_irq_type(AU1500_GPIO205_INT, IRQF_TRIGGER_LOW);
-	irq_set_irq_type(AU1500_GPIO207_INT, IRQF_TRIGGER_LOW);
-
-	irq_set_irq_type(AU1500_GPIO0_INT, IRQF_TRIGGER_LOW);
-	irq_set_irq_type(AU1500_GPIO1_INT, IRQF_TRIGGER_LOW);
-	irq_set_irq_type(AU1500_GPIO2_INT, IRQF_TRIGGER_LOW);
-	irq_set_irq_type(AU1500_GPIO3_INT, IRQF_TRIGGER_LOW);
-	irq_set_irq_type(AU1500_GPIO4_INT, IRQF_TRIGGER_LOW); /* CF irq */
-	irq_set_irq_type(AU1500_GPIO5_INT, IRQF_TRIGGER_LOW);
-
-	return 0;
-}
-arch_initcall(xxs1500_init_irq);
diff --git a/arch/mips/alchemy/xxs1500/init.c b/arch/mips/alchemy/xxs1500/init.c
deleted file mode 100644
index 0ee02cf..0000000
--- a/arch/mips/alchemy/xxs1500/init.c
+++ /dev/null
@@ -1,63 +0,0 @@
-/*
- * BRIEF MODULE DESCRIPTION
- *	XXS1500 board setup
- *
- * Copyright 2003, 2008 MontaVista Software Inc.
- * Author: MontaVista Software, Inc. <source@mvista.com>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/init.h>
-#include <linux/kernel.h>
-
-#include <asm/bootinfo.h>
-#include <asm/mach-au1x00/au1000.h>
-
-#include <prom.h>
-
-const char *get_system_type(void)
-{
-	return "XXS1500";
-}
-
-void __init prom_init(void)
-{
-	unsigned char *memsize_str;
-	unsigned long memsize;
-
-	prom_argc = fw_arg0;
-	prom_argv = (char **)fw_arg1;
-	prom_envp = (char **)fw_arg2;
-
-	prom_init_cmdline();
-
-	memsize_str = prom_getenv("memsize");
-	if (!memsize_str || strict_strtoul(memsize_str, 0, &memsize))
-		memsize = 0x04000000;
-
-	add_memory_region(0, memsize, BOOT_MEM_RAM);
-}
-
-void prom_putchar(unsigned char c)
-{
-	alchemy_uart_putchar(AU1000_UART0_PHYS_ADDR, c);
-}
diff --git a/arch/mips/alchemy/xxs1500/platform.c b/arch/mips/alchemy/xxs1500/platform.c
deleted file mode 100644
index 06a3a45..0000000
--- a/arch/mips/alchemy/xxs1500/platform.c
+++ /dev/null
@@ -1,63 +0,0 @@
-/*
- * XXS1500 board platform device registration
- *
- * Copyright (C) 2009 Manuel Lauss
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-#include <linux/init.h>
-#include <linux/platform_device.h>
-
-#include <asm/mach-au1x00/au1000.h>
-
-static struct resource xxs1500_pcmcia_res[] = {
-	{
-		.name	= "pcmcia-io",
-		.flags	= IORESOURCE_MEM,
-		.start	= AU1000_PCMCIA_IO_PHYS_ADDR,
-		.end	= AU1000_PCMCIA_IO_PHYS_ADDR + 0x000400000 - 1,
-	},
-	{
-		.name	= "pcmcia-attr",
-		.flags	= IORESOURCE_MEM,
-		.start	= AU1000_PCMCIA_ATTR_PHYS_ADDR,
-		.end	= AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x000400000 - 1,
-	},
-	{
-		.name	= "pcmcia-mem",
-		.flags	= IORESOURCE_MEM,
-		.start	= AU1000_PCMCIA_MEM_PHYS_ADDR,
-		.end	= AU1000_PCMCIA_MEM_PHYS_ADDR + 0x000400000 - 1,
-	},
-};
-
-static struct platform_device xxs1500_pcmcia_dev = {
-	.name		= "xxs1500_pcmcia",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(xxs1500_pcmcia_res),
-	.resource	= xxs1500_pcmcia_res,
-};
-
-static struct platform_device *xxs1500_devs[] __initdata = {
-	&xxs1500_pcmcia_dev,
-};
-
-static int __init xxs1500_dev_init(void)
-{
-	return platform_add_devices(xxs1500_devs,
-				    ARRAY_SIZE(xxs1500_devs));
-}
-device_initcall(xxs1500_dev_init);
-- 
1.7.7.1
