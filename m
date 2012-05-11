Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 May 2012 05:20:34 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:33745 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903543Ab2EKDUU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 May 2012 05:20:20 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SSgOp-0001a7-06; Thu, 10 May 2012 22:20:11 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>,
        Douglas Leung <douglas@mips.com>,
        Chris Dearman <chris@mips.com>
Subject: [PATCH v3,01/10] MIPS: Add core files for MIPS SEAD-3 development platform.
Date:   Thu, 10 May 2012 22:20:01 -0500
Message-Id: <1336706401-27530-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10
X-archive-position: 33236
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

More information about the SEAD-3 platform can be found at
<http://www.mips.com/products/development-kits/mips-sead-3/>
on MTI's site. Currently, the M14K family of cores is what
the SEAD-3 is utilised with.

Signed-off-by: Douglas Leung <douglas@mips.com>
Signed-off-by: Chris Dearman <chris@mips.com>
Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 .../include/asm/mach-sead3/cpu-feature-overrides.h |   72 ++++
 arch/mips/include/asm/mach-sead3/irq.h             |    9 +
 .../include/asm/mach-sead3/kernel-entry-init.h     |   52 +++
 arch/mips/include/asm/mach-sead3/war.h             |   25 ++
 arch/mips/include/asm/mips-boards/sead3int.h       |   67 +++
 arch/mips/mti-sead3/Makefile                       |   24 ++
 arch/mips/mti-sead3/Platform                       |    7 +
 arch/mips/mti-sead3/leds-sead3.c                   |  133 ++++++
 arch/mips/mti-sead3/sead3-cmdline.c                |   59 +++
 arch/mips/mti-sead3/sead3-console.c                |   52 +++
 arch/mips/mti-sead3/sead3-display.c                |   90 ++++
 arch/mips/mti-sead3/sead3-ehci.c                   |   52 +++
 arch/mips/mti-sead3/sead3-i2c-dev.c                |   38 ++
 arch/mips/mti-sead3/sead3-i2c.c                    |   42 ++
 arch/mips/mti-sead3/sead3-init.c                   |  244 +++++++++++
 arch/mips/mti-sead3/sead3-int.c                    |  146 +++++++
 arch/mips/mti-sead3/sead3-lcd.c                    |   55 +++
 arch/mips/mti-sead3/sead3-leds.c                   |   91 ++++
 arch/mips/mti-sead3/sead3-memory.c                 |  178 ++++++++
 arch/mips/mti-sead3/sead3-mtd.c                    |   58 +++
 arch/mips/mti-sead3/sead3-net.c                    |   56 +++
 arch/mips/mti-sead3/sead3-pic32-bus.c              |  112 +++++
 arch/mips/mti-sead3/sead3-pic32-i2c-drv.c          |  441 ++++++++++++++++++++
 arch/mips/mti-sead3/sead3-platform.c               |   49 +++
 arch/mips/mti-sead3/sead3-reset.c                  |   64 +++
 arch/mips/mti-sead3/sead3-setup.c                  |   49 +++
 arch/mips/mti-sead3/sead3-smtc.c                   |  162 +++++++
 arch/mips/mti-sead3/sead3-time.c                   |  145 +++++++
 28 files changed, 2572 insertions(+)
 create mode 100644 arch/mips/include/asm/mach-sead3/cpu-feature-overrides.h
 create mode 100644 arch/mips/include/asm/mach-sead3/irq.h
 create mode 100644 arch/mips/include/asm/mach-sead3/kernel-entry-init.h
 create mode 100644 arch/mips/include/asm/mach-sead3/war.h
 create mode 100644 arch/mips/include/asm/mips-boards/sead3int.h
 create mode 100644 arch/mips/mti-sead3/Makefile
 create mode 100644 arch/mips/mti-sead3/Platform
 create mode 100644 arch/mips/mti-sead3/leds-sead3.c
 create mode 100644 arch/mips/mti-sead3/sead3-cmdline.c
 create mode 100644 arch/mips/mti-sead3/sead3-console.c
 create mode 100644 arch/mips/mti-sead3/sead3-display.c
 create mode 100644 arch/mips/mti-sead3/sead3-ehci.c
 create mode 100644 arch/mips/mti-sead3/sead3-i2c-dev.c
 create mode 100644 arch/mips/mti-sead3/sead3-i2c.c
 create mode 100644 arch/mips/mti-sead3/sead3-init.c
 create mode 100644 arch/mips/mti-sead3/sead3-int.c
 create mode 100644 arch/mips/mti-sead3/sead3-lcd.c
 create mode 100644 arch/mips/mti-sead3/sead3-leds.c
 create mode 100644 arch/mips/mti-sead3/sead3-memory.c
 create mode 100644 arch/mips/mti-sead3/sead3-mtd.c
 create mode 100644 arch/mips/mti-sead3/sead3-net.c
 create mode 100644 arch/mips/mti-sead3/sead3-pic32-bus.c
 create mode 100644 arch/mips/mti-sead3/sead3-pic32-i2c-drv.c
 create mode 100644 arch/mips/mti-sead3/sead3-platform.c
 create mode 100644 arch/mips/mti-sead3/sead3-reset.c
 create mode 100644 arch/mips/mti-sead3/sead3-setup.c
 create mode 100644 arch/mips/mti-sead3/sead3-smtc.c
 create mode 100644 arch/mips/mti-sead3/sead3-time.c

diff --git a/arch/mips/include/asm/mach-sead3/cpu-feature-overrides.h b/arch/mips/include/asm/mach-sead3/cpu-feature-overrides.h
new file mode 100644
index 0000000..7f3e3f9
--- /dev/null
+++ b/arch/mips/include/asm/mach-sead3/cpu-feature-overrides.h
@@ -0,0 +1,72 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2003, 2004 Chris Dearman
+ * Copyright (C) 2005 Ralf Baechle (ralf@linux-mips.org)
+ */
+#ifndef __ASM_MACH_MIPS_CPU_FEATURE_OVERRIDES_H
+#define __ASM_MACH_MIPS_CPU_FEATURE_OVERRIDES_H
+
+
+/*
+ * CPU feature overrides for MIPS boards
+ */
+#ifdef CONFIG_CPU_MIPS32
+#define cpu_has_tlb		1
+#define cpu_has_4kex		1
+#define cpu_has_4k_cache	1
+/* #define cpu_has_fpu		? */
+/* #define cpu_has_32fpr	? */
+#define cpu_has_counter		1
+/* #define cpu_has_watch	? */
+#define cpu_has_divec		1
+#define cpu_has_vce		0
+/* #define cpu_has_cache_cdex_p	? */
+/* #define cpu_has_cache_cdex_s	? */
+/* #define cpu_has_prefetch	? */
+#define cpu_has_mcheck		1
+/* #define cpu_has_ejtag	? */
+#ifdef CONFIG_CPU_HAS_LLSC
+#define cpu_has_llsc		1
+#else
+#define cpu_has_llsc		0
+#endif
+/* #define cpu_has_vtag_icache	? */
+/* #define cpu_has_dc_aliases	? */
+/* #define cpu_has_ic_fills_f_dc ? */
+#define cpu_has_nofpuex		0
+/* #define cpu_has_64bits	? */
+/* #define cpu_has_64bit_zero_reg ? */
+/* #define cpu_has_inclusive_pcaches ? */
+#define cpu_icache_snoops_remote_store 1
+#endif
+
+#ifdef CONFIG_CPU_MIPS64
+#define cpu_has_tlb		1
+#define cpu_has_4kex		1
+#define cpu_has_4k_cache	1
+/* #define cpu_has_fpu		? */
+/* #define cpu_has_32fpr	? */
+#define cpu_has_counter		1
+/* #define cpu_has_watch	? */
+#define cpu_has_divec		1
+#define cpu_has_vce		0
+/* #define cpu_has_cache_cdex_p	? */
+/* #define cpu_has_cache_cdex_s	? */
+/* #define cpu_has_prefetch	? */
+#define cpu_has_mcheck		1
+/* #define cpu_has_ejtag	? */
+#define cpu_has_llsc		1
+/* #define cpu_has_vtag_icache	? */
+/* #define cpu_has_dc_aliases	? */
+/* #define cpu_has_ic_fills_f_dc ? */
+#define cpu_has_nofpuex		0
+/* #define cpu_has_64bits	? */
+/* #define cpu_has_64bit_zero_reg ? */
+/* #define cpu_has_inclusive_pcaches ? */
+#define cpu_icache_snoops_remote_store 1
+#endif
+
+#endif /* __ASM_MACH_MIPS_CPU_FEATURE_OVERRIDES_H */
diff --git a/arch/mips/include/asm/mach-sead3/irq.h b/arch/mips/include/asm/mach-sead3/irq.h
new file mode 100644
index 0000000..652ea4c
--- /dev/null
+++ b/arch/mips/include/asm/mach-sead3/irq.h
@@ -0,0 +1,9 @@
+#ifndef __ASM_MACH_MIPS_IRQ_H
+#define __ASM_MACH_MIPS_IRQ_H
+
+#define NR_IRQS	256
+
+
+#include_next <irq.h>
+
+#endif /* __ASM_MACH_MIPS_IRQ_H */
diff --git a/arch/mips/include/asm/mach-sead3/kernel-entry-init.h b/arch/mips/include/asm/mach-sead3/kernel-entry-init.h
new file mode 100644
index 0000000..3dfbd8e
--- /dev/null
+++ b/arch/mips/include/asm/mach-sead3/kernel-entry-init.h
@@ -0,0 +1,52 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Chris Dearman (chris@mips.com)
+ * Copyright (C) 2007 Mips Technologies, Inc.
+ */
+#ifndef __ASM_MACH_MIPS_KERNEL_ENTRY_INIT_H
+#define __ASM_MACH_MIPS_KERNEL_ENTRY_INIT_H
+
+	.macro	kernel_entry_setup
+#ifdef CONFIG_MIPS_MT_SMTC
+	mfc0	t0, CP0_CONFIG
+	bgez	t0, 9f
+	mfc0	t0, CP0_CONFIG, 1
+	bgez	t0, 9f
+	mfc0	t0, CP0_CONFIG, 2
+	bgez	t0, 9f
+	mfc0	t0, CP0_CONFIG, 3
+	and	t0, 1<<2
+	bnez	t0, 0f
+9 :
+	/* Assume we came from YAMON... */
+	PTR_LA	v0, 0x9fc00534	/* YAMON print */
+	lw	v0, (v0)
+	move	a0, zero
+	PTR_LA	a1, nonmt_processor
+	jal	v0
+
+	PTR_LA	v0, 0x9fc00520	/* YAMON exit */
+	lw	v0, (v0)
+	li	a0, 1
+	jal	v0
+
+1 :	b	1b
+
+	__INITDATA
+nonmt_processor :
+	.asciz	"SMTC kernel requires the MT ASE to run\n"
+	__FINIT
+0 :
+#endif
+	.endm
+
+/*
+ * Do SMP slave processor setup necessary before we can safely execute C code.
+ */
+	.macro	smp_slave_setup
+	.endm
+
+#endif /* __ASM_MACH_MIPS_KERNEL_ENTRY_INIT_H */
diff --git a/arch/mips/include/asm/mach-sead3/war.h b/arch/mips/include/asm/mach-sead3/war.h
new file mode 100644
index 0000000..7c6931d
--- /dev/null
+++ b/arch/mips/include/asm/mach-sead3/war.h
@@ -0,0 +1,25 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
+ */
+#ifndef __ASM_MIPS_MACH_MIPS_WAR_H
+#define __ASM_MIPS_MACH_MIPS_WAR_H
+
+#define R4600_V1_INDEX_ICACHEOP_WAR	0
+#define R4600_V1_HIT_CACHEOP_WAR	0
+#define R4600_V2_HIT_CACHEOP_WAR	0
+#define R5432_CP0_INTERRUPT_WAR		0
+#define BCM1250_M3_WAR			0
+#define SIBYTE_1956_WAR			0
+#define MIPS4K_ICACHE_REFILL_WAR	1
+#define MIPS_CACHE_SYNC_WAR		1
+#define TX49XX_ICACHE_INDEX_INV_WAR	0
+#define RM9000_CDEX_SMP_WAR		0
+#define ICACHE_REFILLS_WORKAROUND_WAR	1
+#define R10000_LLSC_WAR			0
+#define MIPS34K_MISSED_ITLB_WAR		0
+
+#endif /* __ASM_MIPS_MACH_MIPS_WAR_H */
diff --git a/arch/mips/include/asm/mips-boards/sead3int.h b/arch/mips/include/asm/mips-boards/sead3int.h
new file mode 100644
index 0000000..2563b82
--- /dev/null
+++ b/arch/mips/include/asm/mips-boards/sead3int.h
@@ -0,0 +1,67 @@
+/*
+ * Douglas Leung, douglas@mips.com
+ * Copyright (C) 2000 MIPS Technologies, Inc.  All rights reserved.
+ *
+ * ########################################################################
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * ########################################################################
+ *
+ * Defines for the SEAD3 interrupt controller.
+ *
+ */
+#ifndef _MIPS_SEAD3INT_H
+#define _MIPS_SEAD3INT_H
+
+/*
+ * SEAD3 GIC's address space definitions
+ */
+#define GIC_BASE_ADDR                   0x1b1c0000
+#define GIC_ADDRSPACE_SZ                (128 * 1024)
+
+/* GIC's Nomenclature for Core Interrupt Pins on the SEAD3 */
+#define GIC_CPU_INT0		0 /* Core Interrupt 2 	*/
+#define GIC_CPU_INT1		1 /* .			*/
+#define GIC_CPU_INT2		2 /* .			*/
+#define GIC_CPU_INT3		3 /* .			*/
+#define GIC_CPU_INT4		4 /* .			*/
+#define GIC_CPU_INT5		5 /* Core Interrupt 7   */
+
+/* SEAD3 GIC local interrupts */
+#define GIC_INT_TMR             (GIC_CPU_INT5)
+#define GIC_INT_PERFCTR         (GIC_CPU_INT5)
+
+/* SEAD3 GIC constants */
+/* Add 2 to convert non-eic hw int # to eic vector # */
+#define GIC_CPU_TO_VEC_OFFSET   (2)
+
+/* GIC constants */
+/* If we map an intr to pin X, GIC will actually generate vector X+1 */
+#define GIC_PIN_TO_VEC_OFFSET   (1)
+
+#define GIC_EXT_INTR(x)		x
+
+/* Dummy data */
+#define X			0xdead
+
+/* External Interrupts used for IPI */
+/* Currently linux don't know about GIC => GIC base must be same as what Linux is using */
+#define MIPS_GIC_IRQ_BASE       (MIPS_CPU_IRQ_BASE + 0)
+
+#ifndef __ASSEMBLY__
+extern void sead3int_init(void);
+#endif
+
+#endif /* !(_MIPS_SEAD3INT_H) */
diff --git a/arch/mips/mti-sead3/Makefile b/arch/mips/mti-sead3/Makefile
new file mode 100644
index 0000000..8797977
--- /dev/null
+++ b/arch/mips/mti-sead3/Makefile
@@ -0,0 +1,24 @@
+#
+# Carsten Langgaard, carstenl@mips.com
+# Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
+#
+# Copyright (C) 2008 Wind River Systems, Inc.
+#   written by Ralf Baechle <ralf@linux-mips.org>
+#
+obj-y				:= sead3-lcd.o sead3-cmdline.o \
+				   sead3-display.o sead3-init.o sead3-int.o \
+				   sead3-mtd.o sead3-net.o \
+				   sead3-memory.o sead3-platform.o \
+				   sead3-reset.o sead3-setup.o sead3-time.o
+
+obj-y				+= sead3-i2c-dev.o sead3-i2c.o \
+				   sead3-pic32-i2c-drv.o sead3-pic32-bus.o \
+				   leds-sead3.o sead3-leds.o
+
+obj-$(CONFIG_EARLY_PRINTK)	+= sead3-console.o
+obj-$(CONFIG_USB_EHCI_HCD)	+= sead3-ehci.o
+
+# FIXME
+obj-$(CONFIG_MIPS_MT_SMTC)	+= sead3-smtc.o
+
+EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/mti-sead3/Platform b/arch/mips/mti-sead3/Platform
new file mode 100644
index 0000000..596e484
--- /dev/null
+++ b/arch/mips/mti-sead3/Platform
@@ -0,0 +1,7 @@
+#
+# MIPS Sead3 board
+#
+platform-$(CONFIG_MIPS_SEAD3)	+= mti-sead3/
+cflags-$(CONFIG_MIPS_SEAD3)	+= -I$(srctree)/arch/mips/include/asm/mach-sead3
+load-$(CONFIG_MIPS_SEAD3)	+= 0xffffffff80100000
+all-$(CONFIG_MIPS_SEAD3)	:= $(COMPRESSION_FNAME).srec
diff --git a/arch/mips/mti-sead3/leds-sead3.c b/arch/mips/mti-sead3/leds-sead3.c
new file mode 100644
index 0000000..89954ce
--- /dev/null
+++ b/arch/mips/mti-sead3/leds-sead3.c
@@ -0,0 +1,133 @@
+/*
+ * LEDs driver for SEAD3
+ *
+ * Copyright (C) 2006 Kristian Kielhofner <kris@krisk.org>
+ *
+ * Based on leds-wrap.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/leds.h>
+#include <linux/err.h>
+#include <asm/io.h>
+
+#define DRVNAME "sead3-led"
+
+static struct platform_device *pdev;
+
+static void sead3_pled_set(struct led_classdev *led_cdev,
+		enum led_brightness value)
+{
+	pr_debug("sead3_pled_set\n");
+	writel(value, (void __iomem *)0xBF000210);	/* FIXME */
+}
+
+static void sead3_fled_set(struct led_classdev *led_cdev,
+		enum led_brightness value)
+{
+	pr_debug("sead3_fled_set\n");
+	writel(value, (void __iomem *)0xBF000218);	/* FIXME */
+}
+
+static struct led_classdev sead3_pled = {
+	.name		= "sead3::pled",
+	.brightness_set	= sead3_pled_set,
+};
+
+static struct led_classdev sead3_fled = {
+	.name		= "sead3::fled",
+	.brightness_set	= sead3_fled_set,
+};
+
+#ifdef CONFIG_PM
+static int sead3_led_suspend(struct platform_device *dev,
+		pm_message_t state)
+{
+	led_classdev_suspend(&sead3_pled);
+	led_classdev_suspend(&sead3_fled);
+	return 0;
+}
+
+static int sead3_led_resume(struct platform_device *dev)
+{
+	led_classdev_resume(&sead3_pled);
+	led_classdev_resume(&sead3_fled);
+	return 0;
+}
+#else
+#define sead3_led_suspend NULL
+#define sead3_led_resume NULL
+#endif
+
+static int sead3_led_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	ret = led_classdev_register(&pdev->dev, &sead3_pled);
+	if (ret < 0)
+		return ret;
+
+	ret = led_classdev_register(&pdev->dev, &sead3_fled);
+	if (ret < 0)
+		led_classdev_unregister(&sead3_pled);
+
+	return ret;
+}
+
+static int sead3_led_remove(struct platform_device *pdev)
+{
+	led_classdev_unregister(&sead3_pled);
+	led_classdev_unregister(&sead3_fled);
+	return 0;
+}
+
+static struct platform_driver sead3_led_driver = {
+	.probe		= sead3_led_probe,
+	.remove		= sead3_led_remove,
+	.suspend	= sead3_led_suspend,
+	.resume		= sead3_led_resume,
+	.driver		= {
+		.name		= DRVNAME,
+		.owner		= THIS_MODULE,
+	},
+};
+
+static int __init sead3_led_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&sead3_led_driver);
+	if (ret < 0)
+		goto out;
+
+	pdev = platform_device_register_simple(DRVNAME, -1, NULL, 0);
+	if (IS_ERR(pdev)) {
+		ret = PTR_ERR(pdev);
+		platform_driver_unregister(&sead3_led_driver);
+		goto out;
+	}
+
+out:
+	return ret;
+}
+
+static void __exit sead3_led_exit(void)
+{
+	platform_device_unregister(pdev);
+	platform_driver_unregister(&sead3_led_driver);
+}
+
+module_init(sead3_led_init);
+module_exit(sead3_led_exit);
+
+MODULE_AUTHOR("Kristian Kielhofner <kris@krisk.org>");
+MODULE_DESCRIPTION("SEAD3 LED driver");
+MODULE_LICENSE("GPL");
+
diff --git a/arch/mips/mti-sead3/sead3-cmdline.c b/arch/mips/mti-sead3/sead3-cmdline.c
new file mode 100644
index 0000000..8d6ad39
--- /dev/null
+++ b/arch/mips/mti-sead3/sead3-cmdline.c
@@ -0,0 +1,59 @@
+/*
+ * Carsten Langgaard, carstenl@mips.com
+ * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
+ *
+ * This program is free software; you can distribute it and/or modify it
+ * under the terms of the GNU General Public License (Version 2) as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * Kernel command line creation using the prom monitor (YAMON) argc/argv.
+ */
+#include <linux/init.h>
+#include <linux/string.h>
+
+#include <asm/bootinfo.h>
+
+extern int prom_argc;
+extern int *_prom_argv;
+
+/*
+ * YAMON (32-bit PROM) pass arguments and environment as 32-bit pointer.
+ * This macro take care of sign extension.
+ */
+#define prom_argv(index) ((char *)(long)_prom_argv[(index)])
+
+char * __init prom_getcmdline(void)
+{
+	return &(arcs_cmdline[0]);
+}
+
+
+void  __init prom_init_cmdline(void)
+{
+	char *cp;
+	int actr;
+
+	actr = 1; /* Always ignore argv[0] */
+
+	cp = &(arcs_cmdline[0]);
+	while (actr < prom_argc) {
+		strcpy(cp, prom_argv(actr));
+		cp += strlen(prom_argv(actr));
+		*cp++ = ' ';
+		actr++;
+	}
+	if (cp != &(arcs_cmdline[0])) {
+		/* get rid of trailing space */
+		--cp;
+		*cp = '\0';
+	}
+}
diff --git a/arch/mips/mti-sead3/sead3-console.c b/arch/mips/mti-sead3/sead3-console.c
new file mode 100644
index 0000000..a799a5d
--- /dev/null
+++ b/arch/mips/mti-sead3/sead3-console.c
@@ -0,0 +1,52 @@
+/*
+ * Carsten Langgaard, carstenl@mips.com
+ * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ */
+#include <linux/console.h>
+#include <linux/init.h>
+#include <linux/serial_reg.h>
+#include <asm/io.h>
+
+
+#define SEAD_UART1_REGS_BASE    0xbf000800   /* ttyS1 = RS232 port */
+#define SEAD_UART0_REGS_BASE    0xbf000900   /* ttyS0 = USB port   */
+
+#define PORT(base_addr, offset) ((unsigned int __iomem *)(base_addr+(offset)*4))
+
+static inline unsigned int serial_in(int offset, unsigned int base_addr)
+{
+	return __raw_readl(PORT(base_addr, offset)) & 0xff;
+}
+
+static inline void serial_out(int offset, int value, unsigned int base_addr)
+{
+	__raw_writel(value, PORT(base_addr, offset));
+}
+
+int prom_putchar(char c, char port)
+{
+	unsigned int base_addr;
+
+	base_addr = port ? SEAD_UART1_REGS_BASE : SEAD_UART0_REGS_BASE;
+
+	while ((serial_in(UART_LSR, base_addr) & UART_LSR_THRE) == 0)
+		;
+
+	serial_out(UART_TX, c, base_addr);
+
+	return 1;
+}
diff --git a/arch/mips/mti-sead3/sead3-display.c b/arch/mips/mti-sead3/sead3-display.c
new file mode 100644
index 0000000..f6e2231
--- /dev/null
+++ b/arch/mips/mti-sead3/sead3-display.c
@@ -0,0 +1,90 @@
+/*
+ * Carsten Langgaard, carstenl@mips.com
+ * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ */
+
+#include <linux/compiler.h>
+#include <linux/timer.h>
+#include <asm/io.h>
+#include <asm/mips-boards/generic.h>
+#include <asm/mips-boards/prom.h>
+
+extern const char display_string[];
+static unsigned int display_count;
+static unsigned int max_display_count;
+
+#define DISPLAY_LCDINSTRUCTION         (0*2)
+#define DISPLAY_LCDDATA                (1*2)
+#define DISPLAY_CPLDSTATUS             (2*2)
+#define DISPLAY_CPLDDATA               (3*2)
+#define LCD_SETDDRAM                   0x80
+#define LCD_IR_BF                      0x80
+
+static void lcd_wait(unsigned int __iomem *display)
+{
+	/* wait for CPLD state machine to become idle */
+	do {
+	} while (__raw_readl(display + DISPLAY_CPLDSTATUS) & 1);
+
+	do {
+		__raw_readl(display + DISPLAY_LCDINSTRUCTION);
+
+		/* wait for CPLD state machine to become idle */
+		do {
+		} while (__raw_readl(display + DISPLAY_CPLDSTATUS) & 1);
+	} while (__raw_readl(display + DISPLAY_CPLDDATA) & LCD_IR_BF);
+}
+
+void mips_display_message(const char *str)
+{
+	static unsigned int __iomem *display;  /* static => auto initialized to NULL */
+	int i;
+	char ch;
+
+	if (unlikely(display == NULL))
+		display = ioremap_nocache(LCD_DISPLAY_POS_BASE, 4*2*sizeof(int));
+
+	for (i = 0; i < 16; i++) {
+		if (*str)
+			ch = *str++;
+		else
+			ch = ' ';
+		lcd_wait(display);
+		__raw_writel(LCD_SETDDRAM | i, display + DISPLAY_LCDINSTRUCTION);
+		lcd_wait(display);
+		__raw_writel(ch, display + DISPLAY_LCDDATA);
+	}
+}
+
+static void scroll_display_message(unsigned long data);
+static DEFINE_TIMER(mips_scroll_timer, scroll_display_message, HZ, 0);
+
+static void scroll_display_message(unsigned long data)
+{
+	mips_display_message(&display_string[display_count++]);
+	if (display_count == max_display_count)
+		display_count = 0;
+
+	mod_timer(&mips_scroll_timer, jiffies + HZ);
+}
+
+void mips_scroll_message(void)
+{
+	del_timer_sync(&mips_scroll_timer);
+	max_display_count = strlen(display_string) + 1 - 16;
+	mod_timer(&mips_scroll_timer, jiffies + 1);
+}
diff --git a/arch/mips/mti-sead3/sead3-ehci.c b/arch/mips/mti-sead3/sead3-ehci.c
new file mode 100644
index 0000000..cf4d93c
--- /dev/null
+++ b/arch/mips/mti-sead3/sead3-ehci.c
@@ -0,0 +1,52 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2009 MIPS Technologies, vInc.
+ *   written by Chris Dearman (chris@mips.com)
+ *
+ * Probe driver for the SEAD3 EHCI device
+ *
+ */
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+#include <irq.h>
+
+struct resource ehci_resources[] = {
+	{
+		.start			= 0x1b200000,
+		.end			= 0x1b200fff,
+		.flags			= IORESOURCE_MEM
+	},
+	{
+		.start			= MIPS_CPU_IRQ_BASE + 2,
+		.flags			= IORESOURCE_IRQ
+	}
+};
+
+u64 sead3_usbdev_dma_mask = DMA_BIT_MASK(32);
+
+static struct platform_device ehci_device = {
+	.name		= "sead3-ehci",
+	.id		= 0,
+	.dev		= {
+		.dma_mask		= &sead3_usbdev_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32)
+	},
+	.num_resources	= ARRAY_SIZE(ehci_resources),
+	.resource	= ehci_resources
+};
+
+static int __init ehci_init(void)
+{
+	return platform_device_register(&ehci_device);
+}
+
+module_init(ehci_init);
+
+MODULE_AUTHOR("Chris Dearman <chris@mips.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("EHCI probe driver for SEAD3");
diff --git a/arch/mips/mti-sead3/sead3-i2c-dev.c b/arch/mips/mti-sead3/sead3-i2c-dev.c
new file mode 100644
index 0000000..7e7a911
--- /dev/null
+++ b/arch/mips/mti-sead3/sead3-i2c-dev.c
@@ -0,0 +1,38 @@
+#define DEBUG
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ */
+
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+
+static struct i2c_board_info sead3_i2c_info2[] __initdata = {
+	{
+		I2C_BOARD_INFO("adt7476",	0x2c),
+		.irq = 0,
+	},
+	{
+		I2C_BOARD_INFO("m41t80",	0x68),
+		.irq = 0,
+	},
+};
+
+static int __init sead3_i2c_init(void)
+{
+	int err;
+
+	pr_debug("sead3_i2c_init\n");
+
+	err = i2c_register_board_info(2, sead3_i2c_info2,
+					ARRAY_SIZE(sead3_i2c_info2));
+	if (err < 0)
+		printk(KERN_ERR
+			"sead3-i2c-dev: cannot register board I2C devices\n");
+	return err;
+}
+
+arch_initcall(sead3_i2c_init);
diff --git a/arch/mips/mti-sead3/sead3-i2c.c b/arch/mips/mti-sead3/sead3-i2c.c
new file mode 100644
index 0000000..bf5f8d3
--- /dev/null
+++ b/arch/mips/mti-sead3/sead3-i2c.c
@@ -0,0 +1,42 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2007 MIPS Technologies, Inc.
+ *   written by Ralf Baechle (ralf@linux-mips.org)
+ *
+ * Probe driver for the SEAD3 network device
+ *
+ */
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <irq.h>
+
+
+struct resource i2c_resources[] = {
+	{
+		.start			= 0x805200,
+		.end			= 0x8053FF,
+		.flags			= IORESOURCE_MEM
+	},
+};
+
+static struct platform_device i2c_device = {
+	.name			= "i2c_pic32",
+	.id			= 2,
+	.num_resources		= ARRAY_SIZE(i2c_resources),
+	.resource		= i2c_resources
+};
+
+static int __init i2c_init(void)
+{
+	return platform_device_register(&i2c_device);
+}
+
+module_init(i2c_init);
+
+MODULE_AUTHOR("Chris Dearman <chris@mips.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("I2C probe driver for SEAD3");
diff --git a/arch/mips/mti-sead3/sead3-init.c b/arch/mips/mti-sead3/sead3-init.c
new file mode 100644
index 0000000..25bdb0a
--- /dev/null
+++ b/arch/mips/mti-sead3/sead3-init.c
@@ -0,0 +1,244 @@
+/*
+ * Copyright (C) 1999, 2000, 2004, 2005  MIPS Technologies, Inc.
+ *	All rights reserved.
+ *	Authors: Carsten Langgaard <carstenl@mips.com>
+ *		 Maciej W. Rozycki <macro@mips.com>
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * PROM library initialisation code.
+ */
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/kernel.h>
+
+#include <asm/bootinfo.h>
+#include <asm/io.h>
+#include <asm/cacheflush.h>
+#include <asm/traps.h>
+
+#include <asm/mips-boards/prom.h>
+#include <asm/mips-boards/generic.h>
+
+int prom_argc;
+int *_prom_argv, *_prom_envp;
+
+/*
+ * YAMON (32-bit PROM) pass arguments and environment as 32-bit pointer.
+ * This macro take care of sign extension, if running in 64-bit mode.
+ */
+#define prom_envp(index) ((char *)(long)_prom_envp[(index)])
+
+int init_debug;  /* global var => auto initialized to 0 */
+
+int mips_revision_corid;
+int mips_revision_sconid;
+
+char *prom_getenv(char *envname)
+{
+	/*
+	 * Return a pointer to the given environment variable.
+	 * In 64-bit mode: we're using 64-bit pointers, but all pointers
+	 * in the PROM structures are only 32-bit, so we need some
+	 * workarounds, if we are running in 64-bit mode.
+	 */
+	int i, index = 0;
+
+	i = strlen(envname);
+
+	while (prom_envp(index)) {
+		if (strncmp(envname, prom_envp(index), i) == 0)
+			return prom_envp(index+1);
+		index += 2;
+	}
+
+	return NULL;
+}
+
+static inline unsigned char str2hexnum(unsigned char c)
+{
+	if (c >= '0' && c <= '9')
+		return c - '0';
+	if (c >= 'a' && c <= 'f')
+		return c - 'a' + 10;
+	return 0; /* foo */
+}
+
+static inline void str2eaddr(unsigned char *ea, unsigned char *str)
+{
+	int i;
+
+	for (i = 0; i < 6; i++) {
+		unsigned char num;
+
+		if ((*str == '.') || (*str == ':'))
+			str++;
+		num = str2hexnum(*str++) << 4;
+		num |= (str2hexnum(*str++));
+		ea[i] = num;
+	}
+}
+
+int get_ethernet_addr(char *ethernet_addr)
+{
+	char *ethaddr_str;
+
+	ethaddr_str = prom_getenv("ethaddr");
+	if (!ethaddr_str) {
+		printk(KERN_WARNING "ethaddr not set in boot prom\n");
+		return -1;
+	}
+	str2eaddr(ethernet_addr, ethaddr_str);
+
+	if (init_debug > 1) {
+		int i;
+		printk(KERN_DEBUG "get_ethernet_addr: ");
+		for (i = 0; i < 5; i++)
+			printk("%02x:", (unsigned char)*(ethernet_addr+i));
+		printk("%02x\n", *(ethernet_addr+i));
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_SERIAL_8250_CONSOLE
+static void __init console_config(void)
+{
+	char console_string[40];
+	int baud = 0;
+	char parity = '\0', bits = '\0', flow = '\0';
+	char *s;
+
+	if ((strstr(prom_getcmdline(), "console=")) == NULL) {
+		s = prom_getenv("modetty0");
+		if (s) {
+			while (*s >= '0' && *s <= '9')
+				baud = baud*10 + *s++ - '0';
+			if (*s == ',')
+				s++;
+			if (*s)
+				parity = *s++;
+			if (*s == ',')
+				s++;
+			if (*s)
+				bits = *s++;
+			if (*s == ',')
+				s++;
+			if (*s == 'h')
+				flow = 'r';
+		}
+		if (baud == 0)
+			baud = 38400;
+		if (parity != 'n' && parity != 'o' && parity != 'e')
+			parity = 'n';
+		if (bits != '7' && bits != '8')
+			bits = '8';
+		if (flow == '\0')
+			flow = 'r';
+		sprintf(console_string, " console=ttyS0,%d%c%c%c", baud,
+			parity, bits, flow);
+		strcat(prom_getcmdline(), console_string);
+		pr_info("Config serial console:%s\n", console_string);
+	}
+}
+#endif
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
+	flush_icache_range((unsigned long)base, (unsigned long)base + 0x80);
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
+	flush_icache_range((unsigned long)base, (unsigned long)base + 0x80);
+}
+
+extern struct plat_smp_ops msmtc_smp_ops;
+
+void __init prom_init(void)
+{
+	prom_argc = fw_arg0;
+	_prom_argv = (int *) fw_arg1;
+	_prom_envp = (int *) fw_arg2;
+
+	mips_display_message("LINUX");
+
+	mips_revision_corid = MIPS_REVISION_CORID;
+	mips_revision_sconid = MIPS_REVISION_SCONID;
+	if (mips_revision_sconid == MIPS_REVISION_SCON_OTHER) {
+		switch (mips_revision_corid) {
+		case MIPS_REVISION_CORID_QED_RM5261:
+		case MIPS_REVISION_CORID_CORE_LV:
+		case MIPS_REVISION_CORID_CORE_FPGA:
+		case MIPS_REVISION_CORID_CORE_FPGAR2:
+			mips_revision_sconid = MIPS_REVISION_SCON_GT64120;
+			break;
+		case MIPS_REVISION_CORID_CORE_EMUL_BON:
+		case MIPS_REVISION_CORID_BONITO64:
+		case MIPS_REVISION_CORID_CORE_20K:
+			mips_revision_sconid = MIPS_REVISION_SCON_BONITO;
+			break;
+		case MIPS_REVISION_CORID_CORE_MSC:
+		case MIPS_REVISION_CORID_CORE_FPGA2:
+		case MIPS_REVISION_CORID_CORE_24K:
+			/*
+			 * SOCit/ROCit support is essentially identical
+			 * but make an attempt to distinguish them
+			 */
+			mips_revision_sconid = MIPS_REVISION_SCON_SOCIT;
+			break;
+		case MIPS_REVISION_CORID_CORE_FPGA3:
+		case MIPS_REVISION_CORID_CORE_FPGA4:
+		case MIPS_REVISION_CORID_CORE_FPGA5:
+		case MIPS_REVISION_CORID_CORE_EMUL_MSC:
+		default:
+			/* See above */
+			mips_revision_sconid = MIPS_REVISION_SCON_ROCIT;
+			break;
+		}
+	}
+
+	board_nmi_handler_setup = mips_nmi_setup;
+	board_ejtag_handler_setup = mips_ejtag_setup;
+
+	pr_info("\nLINUX started...\n");
+	prom_init_cmdline();
+	prom_meminit();
+#ifdef CONFIG_SERIAL_8250_CONSOLE
+	console_config();
+#endif
+#ifdef CONFIG_MIPS_CMP
+	register_smp_ops(&cmp_smp_ops);
+#endif
+#ifdef CONFIG_MIPS_MT_SMP
+	register_smp_ops(&vsmp_smp_ops);
+#endif
+#ifdef CONFIG_MIPS_MT_SMTC
+	register_smp_ops(&msmtc_smp_ops);
+#endif
+}
diff --git a/arch/mips/mti-sead3/sead3-int.c b/arch/mips/mti-sead3/sead3-int.c
new file mode 100644
index 0000000..4cd569e
--- /dev/null
+++ b/arch/mips/mti-sead3/sead3-int.c
@@ -0,0 +1,146 @@
+/*
+ * Carsten Langgaard, carstenl@mips.com
+ * Copyright (C) 2000, 2001, 2004 MIPS Technologies, Inc.
+ * Copyright (C) 2001 Ralf Baechle
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * Routines for generic manipulation of the interrupts found on the MIPS
+ * Malta board.
+ * The interrupt controller is located in the South Bridge a PIIX4 device
+ * with two internal 82C95 interrupt controllers.
+ */
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel_stat.h>
+#include <linux/kernel.h>
+#include <linux/random.h>
+
+#include <asm/setup.h>
+#include <asm/traps.h>
+#include <asm/irq_cpu.h>
+#include <asm/irq_regs.h>
+#include <asm/mips-boards/generic.h>
+#include <asm/mips-boards/sead3int.h>
+#include <asm/gic.h>
+
+#define SEAD_CONFIG_GIC_PRESENT_SHF   (1)
+#define SEAD_CONFIG_GIC_PRESENT_MSK   (1 << SEAD_CONFIG_GIC_PRESENT_SHF)
+#define SEAD_CONFIG_BASE              (0x1B100110)
+#define SEAD_CONFIG_SIZE              (4)
+
+int gic_present;    /* global var => auto initialized to 0 */
+static unsigned long sead3_config_reg;
+
+/*
+ * This table defines the setup for each external GIC interrupt
+ * It is indexed by interrupt number
+ */
+#define GIC_CPU_NMI GIC_MAP_TO_NMI_MSK
+static struct gic_intr_map gic_intr_map[GIC_NUM_INTRS] = {
+	{ 0, GIC_CPU_INT4, GIC_POL_POS, GIC_TRIG_LEVEL, GIC_FLAG_TRANSPARENT },
+	{ 0, GIC_CPU_INT3, GIC_POL_POS, GIC_TRIG_LEVEL, GIC_FLAG_TRANSPARENT },
+	{ 0, GIC_CPU_INT2, GIC_POL_POS, GIC_TRIG_LEVEL, GIC_FLAG_TRANSPARENT },
+	{ 0, GIC_CPU_INT2, GIC_POL_POS, GIC_TRIG_LEVEL, GIC_FLAG_TRANSPARENT },
+	{ 0, GIC_CPU_INT1, GIC_POL_POS, GIC_TRIG_LEVEL, GIC_FLAG_TRANSPARENT },
+	{ 0, GIC_CPU_INT0, GIC_POL_POS, GIC_TRIG_LEVEL, GIC_FLAG_TRANSPARENT },
+	{ 0, GIC_CPU_INT0, GIC_POL_POS, GIC_TRIG_LEVEL, GIC_FLAG_TRANSPARENT },
+	{ 0, GIC_CPU_INT0, GIC_POL_POS, GIC_TRIG_LEVEL, GIC_FLAG_TRANSPARENT },
+	{ 0, GIC_CPU_INT0, GIC_POL_POS, GIC_TRIG_LEVEL, GIC_FLAG_TRANSPARENT },
+	{ X, X,            X,           X,              0 },
+	{ X, X,            X,           X,              0 },
+	{ X, X,            X,           X,              0 },
+	{ X, X,            X,           X,              0 },
+	{ X, X,            X,           X,              0 },
+	{ X, X,            X,           X,              0 },
+	{ X, X,            X,           X,              0 },
+	/* The remainder of this table is initialised by fill_ipi_map */
+};
+
+/*
+ * Version of ffs that only looks at bits 8..15
+ */
+static inline unsigned int irq_ffs(unsigned int pending)
+{
+#if defined(CONFIG_CPU_MIPS32) || defined(CONFIG_CPU_MIPS64)
+	return fls(pending) - CAUSEB_IP - 1;
+#else
+	unsigned int a0 = 7;
+	unsigned int t0;
+
+	t0 = pending & 0xf000;
+	t0 = t0 < 1;
+	t0 = t0 << 2;
+	a0 = a0 - t0;
+	pending = pending << t0;
+
+	t0 = pending & 0xc000;
+	t0 = t0 < 1;
+	t0 = t0 << 1;
+	a0 = a0 - t0;
+	pending = pending << t0;
+
+	t0 = pending & 0x8000;
+	t0 = t0 < 1;
+	/* t0 = t0 << 2; */
+	a0 = a0 - t0;
+	/* pending = pending << t0; */
+
+	return a0;
+#endif
+}
+
+asmlinkage void plat_irq_dispatch(void)
+{
+	unsigned int pending = read_c0_cause() & read_c0_status() & ST0_IM;
+	int irq;
+
+	irq = irq_ffs(pending);
+
+	if (irq >= 0)
+		do_IRQ(MIPS_CPU_IRQ_BASE + irq);
+	else
+		spurious_interrupt();
+}
+
+void __init arch_init_irq(void)
+{
+	int i;
+
+	if (!cpu_has_veic) {
+		mips_cpu_irq_init();
+
+		if (cpu_has_vint) {
+			/* install generic handler */
+			for (i = 0; i < 8; i++)
+				set_vi_handler(i, plat_irq_dispatch);
+		}
+	}
+
+	sead3_config_reg = (unsigned long)ioremap_nocache(SEAD_CONFIG_BASE, SEAD_CONFIG_SIZE);
+	gic_present = (REG32(sead3_config_reg) & SEAD_CONFIG_GIC_PRESENT_MSK) >>
+			SEAD_CONFIG_GIC_PRESENT_SHF;
+	printk("GIC: %spresent\n", (gic_present) ? "" : "not ");
+	printk("EIC: %s\n", (current_cpu_data.options & MIPS_CPU_VEIC) ? "on" : "off");
+
+	if (gic_present) {
+		gic_init(GIC_BASE_ADDR, GIC_ADDRSPACE_SZ, gic_intr_map,
+				ARRAY_SIZE(gic_intr_map), MIPS_GIC_IRQ_BASE);
+	}
+}
+
diff --git a/arch/mips/mti-sead3/sead3-lcd.c b/arch/mips/mti-sead3/sead3-lcd.c
new file mode 100644
index 0000000..654b447
--- /dev/null
+++ b/arch/mips/mti-sead3/sead3-lcd.c
@@ -0,0 +1,55 @@
+/*
+ *  Registration of Sead3 LCD platform device.
+ *
+ *  Copyright (C) 2008  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/platform_device.h>
+
+static struct resource sead3_lcd_resource __initdata = {
+	.start	= 0x1f000400,
+	.end	= 0x1f00041f,
+	.flags	= IORESOURCE_MEM,
+};
+
+static __init int sead3_lcd_add(void)
+{
+	struct platform_device *pdev;
+	int retval;
+
+	pdev = platform_device_alloc("cobalt-lcd", -1);
+	if (!pdev)
+		return -ENOMEM;
+
+	retval = platform_device_add_resources(pdev, &sead3_lcd_resource, 1);
+	if (retval)
+		goto err_free_device;
+
+	retval = platform_device_add(pdev);
+	if (retval)
+		goto err_free_device;
+
+	return 0;
+
+err_free_device:
+	platform_device_put(pdev);
+
+	return retval;
+}
+device_initcall(sead3_lcd_add);
diff --git a/arch/mips/mti-sead3/sead3-leds.c b/arch/mips/mti-sead3/sead3-leds.c
new file mode 100644
index 0000000..ff003d2
--- /dev/null
+++ b/arch/mips/mti-sead3/sead3-leds.c
@@ -0,0 +1,91 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2009 MIPS Technologies, Inc.
+ *   written by Chris Dearman (chris@mips.com)
+ *
+ * Probe driver for the SEAD3 LED devices
+ *
+ */
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/leds.h>
+#include <irq.h>
+
+
+#define LEDFLAGS(bits, shift)		\
+	((bits << 8) | (shift << 8))
+
+#define LEDBITS(id, shift, bits)	\
+	.name = id #shift,		\
+	.flags = LEDFLAGS(bits, shift)
+
+struct led_info led_data_info[] = {
+	{ LEDBITS("bit", 0, 1) },
+	{ LEDBITS("bit", 1, 1) },
+	{ LEDBITS("bit", 2, 1) },
+	{ LEDBITS("bit", 3, 1) },
+	{ LEDBITS("bit", 4, 1) },
+	{ LEDBITS("bit", 5, 1) },
+	{ LEDBITS("bit", 6, 1) },
+	{ LEDBITS("bit", 7, 1) },
+	{ LEDBITS("all", 0, 8) },
+};
+
+static struct led_platform_data led_data = {
+	.num_leds	= ARRAY_SIZE(led_data_info),
+	.leds		= led_data_info
+};
+
+static struct resource pled_resources[] = {
+	{
+		.start			= 0x1F000210,
+		.end			= 0x1F000217,
+		.flags			= IORESOURCE_MEM
+	}
+};
+
+static struct platform_device pled_device = {
+	.name			= "sead3::pled",
+	.id			= 0,
+	.dev			= {
+		.platform_data	= &led_data,
+	},
+	.num_resources		= ARRAY_SIZE(pled_resources),
+	.resource		= pled_resources
+};
+
+
+static struct resource fled_resources[] = {
+	{
+		.start			= 0x1F000218,
+		.end			= 0x1F00021f,
+		.flags			= IORESOURCE_MEM
+	}
+};
+
+static struct platform_device fled_device = {
+	.name			= "sead3::fled",
+	.id			= 0,
+	.dev			= {
+		.platform_data	= &led_data,
+	},
+	.num_resources		= ARRAY_SIZE(fled_resources),
+	.resource		= fled_resources
+};
+
+
+static int __init led_init(void)
+{
+	platform_device_register(&pled_device);
+	return platform_device_register(&fled_device);
+}
+
+module_init(led_init);
+
+MODULE_AUTHOR("Chris Dearman <chris@mips.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("LED probe driver for SEAD3");
diff --git a/arch/mips/mti-sead3/sead3-memory.c b/arch/mips/mti-sead3/sead3-memory.c
new file mode 100644
index 0000000..b27419c
--- /dev/null
+++ b/arch/mips/mti-sead3/sead3-memory.c
@@ -0,0 +1,178 @@
+/*
+ * Carsten Langgaard, carstenl@mips.com
+ * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * PROM library functions for acquiring/using memory descriptors given to
+ * us from the YAMON.
+ */
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/bootmem.h>
+#include <linux/pfn.h>
+#include <linux/string.h>
+
+#include <asm/bootinfo.h>
+#include <asm/page.h>
+#include <asm/sections.h>
+
+#include <asm/mips-boards/prom.h>
+
+/*#define DEBUG*/
+
+enum yamon_memtypes {
+	yamon_dontuse,
+	yamon_prom,
+	yamon_free,
+};
+static struct prom_pmemblock mdesc[PROM_MAX_PMEMBLOCKS];
+
+#ifdef DEBUG
+static char *mtypes[3] = {
+	"Dont use memory",
+	"YAMON PROM memory",
+	"Free memmory",
+};
+#endif
+
+/* determined physical memory size, not overridden by command line args  */
+unsigned long physical_memsize = 0L;
+
+static struct prom_pmemblock * __init prom_getmdesc(void)
+{
+	char *memsize_str;
+	unsigned int memsize;
+	char *ptr;
+	static char cmdline[COMMAND_LINE_SIZE] __initdata;
+
+	/* otherwise look in the environment */
+	memsize_str = prom_getenv("memsize");
+	if (!memsize_str) {
+		printk(KERN_WARNING
+		       "memsize not set in boot prom, set to default (32Mb)\n");
+		physical_memsize = 0x02000000;
+	} else {
+#ifdef DEBUG
+		pr_debug("prom_memsize = %s\n", memsize_str);
+#endif
+		physical_memsize = simple_strtol(memsize_str, NULL, 0);
+	}
+
+#ifdef CONFIG_CPU_BIG_ENDIAN
+	/* SOC-it swaps, or perhaps doesn't swap, when DMA'ing the last
+	   word of physical memory */
+	physical_memsize -= PAGE_SIZE;
+#endif
+
+	/* Check the command line for a memsize directive that overrides
+	   the physical/default amount */
+	strcpy(cmdline, arcs_cmdline);
+	ptr = strstr(cmdline, "memsize=");
+	if (ptr && (ptr != cmdline) && (*(ptr - 1) != ' '))
+		ptr = strstr(ptr, " memsize=");
+
+	if (ptr)
+		memsize = memparse(ptr + 8, &ptr);
+	else
+		memsize = physical_memsize;
+
+	memset(mdesc, 0, sizeof(mdesc));
+
+	mdesc[0].type = yamon_dontuse;
+	mdesc[0].base = 0x00000000;
+	mdesc[0].size = 0x00001000;
+
+	mdesc[1].type = yamon_prom;
+	mdesc[1].base = 0x00001000;
+	mdesc[1].size = 0x000ef000;
+
+	/*
+	 * The area 0x000f0000-0x000fffff is allocated for BIOS memory by the
+	 * south bridge and PCI access always forwarded to the ISA Bus and
+	 * BIOSCS# is always generated.
+	 * This mean that this area can't be used as DMA memory for PCI
+	 * devices.
+	 */
+	mdesc[2].type = yamon_dontuse;
+	mdesc[2].base = 0x000f0000;
+	mdesc[2].size = 0x00010000;
+
+	mdesc[3].type = yamon_dontuse;
+	mdesc[3].base = 0x00100000;
+	mdesc[3].size = CPHYSADDR(PFN_ALIGN((unsigned long)&_end)) - mdesc[3].base;
+
+	mdesc[4].type = yamon_free;
+	mdesc[4].base = CPHYSADDR(PFN_ALIGN(&_end));
+	mdesc[4].size = memsize - mdesc[4].base;
+
+	return &mdesc[0];
+}
+
+static int __init prom_memtype_classify(unsigned int type)
+{
+	switch (type) {
+	case yamon_free:
+		return BOOT_MEM_RAM;
+	case yamon_prom:
+		return BOOT_MEM_ROM_DATA;
+	default:
+		return BOOT_MEM_RESERVED;
+	}
+}
+
+void __init prom_meminit(void)
+{
+	struct prom_pmemblock *p;
+
+#ifdef DEBUG
+	pr_debug("YAMON MEMORY DESCRIPTOR dump:\n");
+	p = prom_getmdesc();
+	while (p->size) {
+		int i = 0;
+		pr_debug("[%d,%p]: base<%08lx> size<%08lx> type<%s>\n",
+			 i, p, p->base, p->size, mtypes[p->type]);
+		p++;
+		i++;
+	}
+#endif
+	p = prom_getmdesc();
+
+	while (p->size) {
+		long type;
+		unsigned long base, size;
+
+		type = prom_memtype_classify(p->type);
+		base = p->base;
+		size = p->size;
+
+		add_memory_region(base, size, type);
+                p++;
+	}
+}
+
+void __init prom_free_prom_memory(void)
+{
+	unsigned long addr;
+	int i;
+
+	for (i = 0; i < boot_mem_map.nr_map; i++) {
+		if (boot_mem_map.map[i].type != BOOT_MEM_ROM_DATA)
+			continue;
+
+		addr = boot_mem_map.map[i].addr;
+		free_init_pages("prom memory",
+				addr, addr + boot_mem_map.map[i].size);
+	}
+}
diff --git a/arch/mips/mti-sead3/sead3-mtd.c b/arch/mips/mti-sead3/sead3-mtd.c
new file mode 100644
index 0000000..30450b4
--- /dev/null
+++ b/arch/mips/mti-sead3/sead3-mtd.c
@@ -0,0 +1,58 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2006 MIPS Technologies, Inc.
+ *     written by Ralf Baechle <ralf@linux-mips.org>
+ */
+
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/physmap.h>
+#include <mtd/mtd-abi.h>
+
+static struct mtd_partition sead3_mtd_partitions[] = {
+	{
+		.name =		"User FS",
+		.offset =	0x00000000,
+		.size =		0x01fc0000,
+	}, {
+		.name =		"Board Config",
+		.offset =	0x01fc0000,
+		.size =		0x00040000,
+		.mask_flags =	MTD_WRITEABLE
+	},
+};
+
+static struct physmap_flash_data sead3_flash_data = {
+	.width		= 4,
+	.nr_parts	= ARRAY_SIZE(sead3_mtd_partitions),
+	.parts		= sead3_mtd_partitions
+};
+
+static struct resource sead3_flash_resource = {
+	.start		= 0x1c000000,
+	.end		= 0x1dffffff,
+	.flags		= IORESOURCE_MEM
+};
+
+static struct platform_device sead3_flash = {
+	.name		= "physmap-flash",
+	.id		= 0,
+	.dev		= {
+		.platform_data	= &sead3_flash_data,
+	},
+	.num_resources	= 1,
+	.resource	= &sead3_flash_resource,
+};
+
+static int __init sead3_mtd_init(void)
+{
+	platform_device_register(&sead3_flash);
+
+	return 0;
+}
+
+module_init(sead3_mtd_init)
diff --git a/arch/mips/mti-sead3/sead3-net.c b/arch/mips/mti-sead3/sead3-net.c
new file mode 100644
index 0000000..1a5018d
--- /dev/null
+++ b/arch/mips/mti-sead3/sead3-net.c
@@ -0,0 +1,56 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2007-2011 MIPS Technologies, Inc.
+ *   written by Ralf Baechle (ralf@linux-mips.org)
+ *
+ * Probe driver for the SEAD3 network device
+ *
+ */
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/smsc911x.h>
+#include <irq.h>
+
+static struct smsc911x_platform_config net_data = {
+	.irq_polarity = SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
+	.irq_type = SMSC911X_IRQ_TYPE_PUSH_PULL,
+	.flags	= SMSC911X_USE_32BIT | SMSC911X_SAVE_MAC_ADDRESS,
+	.phy_interface = PHY_INTERFACE_MODE_MII,
+};
+
+struct resource net_resources[] = {
+	{
+		.start                  = 0x1f010000,
+		.end                    = 0x1f01ffff,
+		.flags			= IORESOURCE_MEM
+	},
+	{
+		.start			= MIPS_CPU_IRQ_BASE + 6,
+		.flags			= IORESOURCE_IRQ
+	}
+};
+
+static struct platform_device net_device = {
+	.name			= "smsc911x",
+	.id			= 0,
+	.dev			= {
+		.platform_data	= &net_data,
+	},
+	.num_resources		= ARRAY_SIZE(net_resources),
+	.resource		= net_resources
+};
+
+static int __init net_init(void)
+{
+	return platform_device_register(&net_device);
+}
+
+module_init(net_init);
+
+MODULE_AUTHOR("Chris Dearman <chris@mips.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Network probe driver for SEAD3");
diff --git a/arch/mips/mti-sead3/sead3-pic32-bus.c b/arch/mips/mti-sead3/sead3-pic32-bus.c
new file mode 100644
index 0000000..b0bb326
--- /dev/null
+++ b/arch/mips/mti-sead3/sead3-pic32-bus.c
@@ -0,0 +1,112 @@
+/*
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ */
+
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/spinlock.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/errno.h>
+
+#define PIC32_NULL	0x00
+#define PIC32_RD	0x01
+#define PIC32_SYSRD	0x02
+#define PIC32_WR	0x10
+#define PIC32_SYSWR	0x20
+#define PIC32_IRQ_CLR   0x40
+#define PIC32_STATUS	0x80
+
+#define DELAY()	udelay(100)	/* FIXME: needed? */
+
+/* spinlock to ensure atomic access to PIC32 */
+static DEFINE_SPINLOCK(pic32_bus_lock);
+
+/* FIXME: io_remap these */
+static void __iomem *bus_xfer   = (void __iomem *)0xbf000600;
+static void __iomem *bus_status = (void __iomem *)0xbf000060;
+
+static inline unsigned int ioready(void)
+{
+	return readl(bus_status) & 1;
+}
+
+static inline void wait_ioready(void)
+{
+	do { } while (!ioready());
+}
+
+static inline void wait_ioclear(void)
+{
+	do { } while (ioready());
+}
+
+static inline void check_ioclear(void)
+{
+	if (ioready()) {
+		pr_debug("ioclear: initially busy\n");
+		do {
+			(void) readl(bus_xfer);
+			DELAY();
+		} while (ioready());
+		pr_debug("ioclear: cleared busy\n");
+	}
+}
+
+u32 pic32_bus_readl(u32 reg)
+{
+	unsigned long flags;
+	u32 status, val;
+
+	spin_lock_irqsave(&pic32_bus_lock, flags);
+
+	check_ioclear();
+
+	writel((PIC32_RD << 24) | (reg & 0x00ffffff), bus_xfer);
+	DELAY();
+	wait_ioready();
+	status = readl(bus_xfer);
+	DELAY();
+	val = readl(bus_xfer);
+	wait_ioclear();
+
+	pr_debug("pic32_bus_readl: *%x -> %x (status=%x)\n", reg, val, status);
+
+	spin_unlock_irqrestore(&pic32_bus_lock, flags);
+
+	return val;
+}
+
+void pic32_bus_writel(u32 val, u32 reg)
+{
+	unsigned long flags;
+	u32 status;
+
+	spin_lock_irqsave(&pic32_bus_lock, flags);
+
+	check_ioclear();
+
+	writel((PIC32_WR << 24) | (reg & 0x00ffffff), bus_xfer);
+	DELAY();
+	writel(val, bus_xfer);
+	DELAY();
+	wait_ioready();
+	status = readl(bus_xfer);
+	wait_ioclear();
+
+	pr_debug("pic32_bus_writel: *%x <- %x (status=%x)\n", reg, val, status);
+
+	spin_unlock_irqrestore(&pic32_bus_lock, flags);
+}
diff --git a/arch/mips/mti-sead3/sead3-pic32-i2c-drv.c b/arch/mips/mti-sead3/sead3-pic32-i2c-drv.c
new file mode 100644
index 0000000..053b23e
--- /dev/null
+++ b/arch/mips/mti-sead3/sead3-pic32-i2c-drv.c
@@ -0,0 +1,441 @@
+/*
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ */
+
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/platform_device.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/i2c.h>
+#include <linux/slab.h>
+
+#define PIC32_I2CxCON		0x0000
+#define PIC32_I2CxCONCLR	0x0004
+#define PIC32_I2CxCONSET	0x0008
+#define PIC32_I2CxCONINV	0x000C
+#define  I2CCON_ON		(1<<15)
+#define  I2CCON_FRZ		(1<<14)
+#define  I2CCON_SIDL		(1<<13)
+#define  I2CCON_SCLREL		(1<<12)
+#define  I2CCON_STRICT		(1<<11)
+#define  I2CCON_A10M		(1<<10)
+#define  I2CCON_DISSLW		(1<<9)
+#define  I2CCON_SMEN		(1<<8)
+#define  I2CCON_GCEN		(1<<7)
+#define  I2CCON_STREN		(1<<6)
+#define  I2CCON_ACKDT		(1<<5)
+#define  I2CCON_ACKEN		(1<<4)
+#define  I2CCON_RCEN		(1<<3)
+#define  I2CCON_PEN		(1<<2)
+#define  I2CCON_RSEN		(1<<1)
+#define  I2CCON_SEN		(1<<0)
+
+#define PIC32_I2CxSTAT		0x0010
+#define PIC32_I2CxSTATCLR	0x0014
+#define PIC32_I2CxSTATSET	0x0018
+#define PIC32_I2CxSTATINV	0x001C
+#define  I2CSTAT_ACKSTAT	(1<<15)
+#define  I2CSTAT_TRSTAT		(1<<14)
+#define  I2CSTAT_BCL		(1<<10)
+#define  I2CSTAT_GCSTAT		(1<<9)
+#define  I2CSTAT_ADD10		(1<<8)
+#define  I2CSTAT_IWCOL		(1<<7)
+#define  I2CSTAT_I2COV		(1<<6)
+#define  I2CSTAT_DA		(1<<5)
+#define  I2CSTAT_P		(1<<4)
+#define  I2CSTAT_S		(1<<3)
+#define  I2CSTAT_RW		(1<<2)
+#define  I2CSTAT_RBF		(1<<1)
+#define  I2CSTAT_TBF		(1<<0)
+
+#define PIC32_I2CxADD		0x0020
+#define PIC32_I2CxADDCLR	0x0024
+#define PIC32_I2CxADDSET	0x0028
+#define PIC32_I2CxADDINV	0x002C
+#define PIC32_I2CxMSK		0x0030
+#define PIC32_I2CxMSKCLR	0x0034
+#define PIC32_I2CxMSKSET	0x0038
+#define PIC32_I2CxMSKINV	0x003C
+#define PIC32_I2CxBRG		0x0040
+#define PIC32_I2CxBRGCLR	0x0044
+#define PIC32_I2CxBRGSET	0x0048
+#define PIC32_I2CxBRGINV	0x004C
+#define PIC32_I2CxTRN		0x0050
+#define PIC32_I2CxTRNCLR	0x0054
+#define PIC32_I2CxTRNSET	0x0058
+#define PIC32_I2CxTRNINV	0x005C
+#define PIC32_I2CxRCV		0x0060
+
+struct i2c_platform_data {
+	u32	base;
+	struct i2c_adapter adap;
+	u32	xfer_timeout;
+	u32	ack_timeout;
+	u32	ctl_timeout;
+};
+
+extern u32 pic32_bus_readl(u32 reg);
+extern void pic32_bus_writel(u32 val, u32 reg);
+
+static inline void
+StartI2C(struct i2c_platform_data *adap)
+{
+	pr_debug("StartI2C\n");
+	pic32_bus_writel(I2CCON_SEN, adap->base + PIC32_I2CxCONSET);
+}
+
+static inline void
+StopI2C(struct i2c_platform_data *adap)
+{
+	pr_debug("StopI2C\n");
+	pic32_bus_writel(I2CCON_PEN, adap->base + PIC32_I2CxCONSET);
+}
+
+static inline void
+AckI2C(struct i2c_platform_data *adap)
+{
+	pr_debug("AckI2C\n");
+	pic32_bus_writel(I2CCON_ACKDT, adap->base + PIC32_I2CxCONCLR);
+	pic32_bus_writel(I2CCON_ACKEN, adap->base + PIC32_I2CxCONSET);
+}
+
+static inline void
+NotAckI2C(struct i2c_platform_data *adap)
+{
+	pr_debug("NakI2C\n");
+	pic32_bus_writel(I2CCON_ACKDT, adap->base + PIC32_I2CxCONSET);
+	pic32_bus_writel(I2CCON_ACKEN, adap->base + PIC32_I2CxCONSET);
+}
+
+static inline int
+IdleI2C(struct i2c_platform_data *adap)
+{
+	int i;
+
+	pr_debug("IdleI2C\n");
+	for (i = 0; i < adap->ctl_timeout; i++) {
+		if (((pic32_bus_readl(adap->base + PIC32_I2CxCON) &
+		      (I2CCON_ACKEN|I2CCON_RCEN|I2CCON_PEN|I2CCON_RSEN|I2CCON_SEN)) == 0) &&
+		    ((pic32_bus_readl(adap->base + PIC32_I2CxSTAT) &
+		      (I2CSTAT_TRSTAT)) == 0))
+			return 0;
+		udelay(1);
+	}
+	return -ETIMEDOUT;
+}
+
+static inline u32
+MasterWriteI2C(struct i2c_platform_data *adap, u32 byte)
+{
+	pr_debug("MasterWriteI2C\n");
+
+	pic32_bus_writel(byte, adap->base + PIC32_I2CxTRN);
+
+	return pic32_bus_readl(adap->base + PIC32_I2CxSTAT) & I2CSTAT_IWCOL;
+}
+
+static inline u32
+MasterReadI2C(struct i2c_platform_data *adap)
+{
+	pr_debug("MasterReadI2C\n");
+
+	pic32_bus_writel(I2CCON_RCEN, adap->base + PIC32_I2CxCONSET);
+
+	while (pic32_bus_readl(adap->base + PIC32_I2CxCON) & I2CCON_RCEN)
+		;
+
+	pic32_bus_writel(I2CSTAT_I2COV, adap->base + PIC32_I2CxSTATCLR);
+
+	return pic32_bus_readl(adap->base + PIC32_I2CxRCV);
+}
+
+static int
+do_address(struct i2c_platform_data *adap, unsigned int addr, int rd)
+{
+	pr_debug("doaddress\n");
+
+	IdleI2C(adap);
+	StartI2C(adap);
+	IdleI2C(adap);
+
+	addr <<= 1;
+	if (rd)
+		addr |= 1;
+
+	if (MasterWriteI2C(adap, addr))
+		return -EIO;
+	IdleI2C(adap);
+	if (pic32_bus_readl(adap->base + PIC32_I2CxSTAT) & I2CSTAT_ACKSTAT)
+		return -EIO;
+	return 0;
+}
+
+static int
+i2c_read(struct i2c_platform_data *adap, unsigned char *buf,
+		    unsigned int len)
+{
+	int	i;
+	u32	data;
+
+	pr_debug("i2c_read\n");
+
+	i = 0;
+	while (i < len) {
+		data = MasterReadI2C(adap);
+		buf[i++] = data;
+		if (i < len)
+			AckI2C(adap);
+		else
+			NotAckI2C(adap);
+	}
+
+	StopI2C(adap);
+	IdleI2C(adap);
+	return 0;
+}
+
+static int
+i2c_write(struct i2c_platform_data *adap, unsigned char *buf,
+		     unsigned int len)
+{
+	int	i;
+	u32	data;
+
+	pr_debug("i2c_write\n");
+
+	i = 0;
+	while (i < len) {
+		data = buf[i];
+		if (MasterWriteI2C(adap, data))
+			return -EIO;
+		IdleI2C(adap);
+		if (pic32_bus_readl(adap->base + PIC32_I2CxSTAT) & I2CSTAT_ACKSTAT)
+			return -EIO;
+		i++;
+	}
+
+	StopI2C(adap);
+	IdleI2C(adap);
+	return 0;
+}
+
+static int
+platform_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs, int num)
+{
+	struct i2c_platform_data *adap = i2c_adap->algo_data;
+	struct i2c_msg *p;
+	int i, err = 0;
+
+	pr_debug("platform_xfer\n");
+	for (i = 0; i < num; i++) {
+#define __BUFSIZE 80
+		int ii;
+		static char buf[__BUFSIZE];
+		char *b = buf;
+
+		p = &msgs[i];
+		b += sprintf(buf, " [%d bytes]", p->len);
+		if ((p->flags & I2C_M_RD) == 0) {
+			for (ii = 0; ii < p->len; ii++) {
+				if (b < &buf[__BUFSIZE-4]) {
+					b += sprintf(b, " %02x", p->buf[ii]);
+				} else {
+					strcat(b, "...");
+					break;
+				}
+			}
+		}
+		pr_debug("xfer%d: DevAddr: %04x Op:%s Data:%s\n", i, p->addr,
+			 (p->flags & I2C_M_RD) ? "Rd" : "Wr", buf);
+	}
+
+
+	for (i = 0; !err && i < num; i++) {
+		p = &msgs[i];
+		err = do_address(adap, p->addr, p->flags & I2C_M_RD);
+		if (err || !p->len)
+			continue;
+		if (p->flags & I2C_M_RD)
+			err = i2c_read(adap, p->buf, p->len);
+		else
+			err = i2c_write(adap, p->buf, p->len);
+	}
+
+	/* Return the number of messages processed, or the error code. */
+	if (err == 0)
+		err = num;
+
+	return err;
+}
+
+static u32
+platform_func(struct i2c_adapter *adap)
+{
+	pr_debug("platform_algo\n");
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
+}
+
+static const struct i2c_algorithm platform_algo = {
+	.master_xfer	= platform_xfer,
+	.functionality	= platform_func,
+};
+
+static void i2c_platform_setup(struct i2c_platform_data *priv)
+{
+	pr_debug("i2c_platform_setup\n");
+
+	pic32_bus_writel(500, priv->base + PIC32_I2CxBRG);
+	pic32_bus_writel(I2CCON_ON, priv->base + PIC32_I2CxCONCLR);
+	pic32_bus_writel(I2CCON_ON, priv->base + PIC32_I2CxCONSET);
+	pic32_bus_writel(I2CSTAT_BCL|I2CSTAT_IWCOL, priv->base + PIC32_I2CxSTATCLR);
+}
+
+static void i2c_platform_disable(struct i2c_platform_data *priv)
+{
+	pr_debug("i2c_platform_disable\n");
+}
+
+static int __devinit
+i2c_platform_probe(struct platform_device *pdev)
+{
+	struct i2c_platform_data *priv;
+	struct resource *r;
+	int ret;
+
+	pr_debug("i2c_platform_probe\n");
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	priv = kzalloc(sizeof(struct i2c_platform_data), GFP_KERNEL);
+	if (!priv) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/* FIXME: need to allocate resource in PIC32 space */
+#if 0
+	priv->base = bus_request_region(r->start, resource_size(r),
+					  pdev->name);
+#else
+	priv->base = r->start;
+#endif
+	if (!priv->base) {
+		ret = -EBUSY;
+		goto out_mem;
+	}
+
+	priv->xfer_timeout = 200;
+	priv->ack_timeout = 200;
+	priv->ctl_timeout = 200;
+
+	priv->adap.nr = pdev->id;
+	priv->adap.algo = &platform_algo;
+	priv->adap.algo_data = priv;
+	priv->adap.dev.parent = &pdev->dev;
+	strlcpy(priv->adap.name, "PIC32 I2C", sizeof(priv->adap.name));
+
+	i2c_platform_setup(priv);
+
+	ret = i2c_add_numbered_adapter(&priv->adap);
+	if (ret == 0) {
+		platform_set_drvdata(pdev, priv);
+		return 0;
+	}
+
+	i2c_platform_disable(priv);
+
+out_mem:
+	kfree(priv);
+out:
+	return ret;
+}
+
+static int __devexit
+i2c_platform_remove(struct platform_device *pdev)
+{
+	struct i2c_platform_data *priv = platform_get_drvdata(pdev);
+
+	pr_debug("i2c_platform_remove\n");
+	platform_set_drvdata(pdev, NULL);
+	i2c_del_adapter(&priv->adap);
+	i2c_platform_disable(priv);
+	kfree(priv);
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int
+i2c_platform_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct i2c_platform_data *priv = platform_get_drvdata(pdev);
+
+	dev_dbg(&pdev->dev, "i2c_platform_disable\n");
+	i2c_platform_disable(priv);
+
+	return 0;
+}
+
+static int
+i2c_platform_resume(struct platform_device *pdev)
+{
+	struct i2c_platform_data *priv = platform_get_drvdata(pdev);
+
+	dev_dbg(&pdev->dev, "i2c_platform_setup\n");
+	i2c_platform_setup(priv);
+
+	return 0;
+}
+#else
+#define i2c_platform_suspend	NULL
+#define i2c_platform_resume	NULL
+#endif
+
+static struct platform_driver i2c_platform_driver = {
+	.driver = {
+		.name	= "i2c_pic32",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= i2c_platform_probe,
+	.remove		= __devexit_p(i2c_platform_remove),
+	.suspend	= i2c_platform_suspend,
+	.resume		= i2c_platform_resume,
+};
+
+static int __init
+i2c_platform_init(void)
+{
+	pr_debug("i2c_platform_init\n");
+	return platform_driver_register(&i2c_platform_driver);
+}
+
+static void __exit
+i2c_platform_exit(void)
+{
+	pr_debug("i2c_platform_exit\n");
+	platform_driver_unregister(&i2c_platform_driver);
+}
+
+MODULE_AUTHOR("Chris Dearman, MIPS Technologies INC.");
+MODULE_DESCRIPTION("PIC32 I2C driver");
+MODULE_LICENSE("GPL");
+
+module_init(i2c_platform_init);
+module_exit(i2c_platform_exit);
diff --git a/arch/mips/mti-sead3/sead3-platform.c b/arch/mips/mti-sead3/sead3-platform.c
new file mode 100644
index 0000000..ddd28f6
--- /dev/null
+++ b/arch/mips/mti-sead3/sead3-platform.c
@@ -0,0 +1,49 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2007 MIPS Technologies, Inc.
+ *   written by Ralf Baechle (ralf@linux-mips.org)
+ *
+ * Probe driver for the SEAD3 UART ports
+ *
+ */
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/serial_8250.h>
+
+#define UART(base, int)							\
+{									\
+	.mapbase	= base,						\
+	.irq		= int,						\
+	.uartclk	= 14745600,					\
+	.iotype		= UPIO_MEM32,					\
+	.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_IOREMAP, \
+	.regshift	= 2,						\
+}
+
+static struct plat_serial8250_port uart8250_data[] = {
+	UART(0x1f000900, MIPS_CPU_IRQ_BASE + 4),   /* ttyS0 = USB   */
+	UART(0x1f000800, MIPS_CPU_IRQ_BASE + 4),   /* ttyS1 = RS232 */
+	{ },
+};
+
+static struct platform_device uart8250_device = {
+	.name			= "serial8250",
+	.id			= PLAT8250_DEV_PLATFORM2,
+	.dev			= {
+		.platform_data	= uart8250_data,
+	},
+};
+
+static int __init uart8250_init(void)
+{
+	return platform_device_register(&uart8250_device);
+}
+
+module_init(uart8250_init);
+
+MODULE_AUTHOR("Chris Dearman <chris@mips.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("8250 UART probe driver for SEAD3");
diff --git a/arch/mips/mti-sead3/sead3-reset.c b/arch/mips/mti-sead3/sead3-reset.c
new file mode 100644
index 0000000..4aec9f9
--- /dev/null
+++ b/arch/mips/mti-sead3/sead3-reset.c
@@ -0,0 +1,64 @@
+#define DEBUG
+/*
+ * Carsten Langgaard, carstenl@mips.com
+ * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
+ *
+ * ########################################################################
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * ########################################################################
+ *
+ * Reset the MIPS boards.
+ *
+ */
+#include <linux/init.h>
+#include <linux/pm.h>
+
+#include <asm/io.h>
+#include <asm/reboot.h>
+
+#define  SOFTRES_REG           	0x1F000050
+#define  GORESET		0x4D
+
+static void mips_machine_restart(char *command);
+static void mips_machine_halt(void);
+
+static void mips_machine_restart(char *command)
+{
+	unsigned int __iomem *softres_reg =
+		ioremap(SOFTRES_REG, sizeof(unsigned int));
+
+	__raw_writel(GORESET, softres_reg);
+}
+
+static void mips_machine_halt(void)
+{
+	unsigned int __iomem *softres_reg =
+		ioremap(SOFTRES_REG, sizeof(unsigned int));
+
+	__raw_writel(GORESET, softres_reg);
+}
+
+
+static int __init mips_reboot_setup(void)
+{
+	_machine_restart = mips_machine_restart;
+	_machine_halt = mips_machine_halt;
+	pm_power_off = mips_machine_halt;
+
+	return 0;
+}
+
+arch_initcall(mips_reboot_setup);
diff --git a/arch/mips/mti-sead3/sead3-setup.c b/arch/mips/mti-sead3/sead3-setup.c
new file mode 100644
index 0000000..1ddd4c3
--- /dev/null
+++ b/arch/mips/mti-sead3/sead3-setup.c
@@ -0,0 +1,49 @@
+/*
+ * Carsten Langgaard, carstenl@mips.com
+ * Copyright (C) 2000 MIPS Technologies, Inc.  All rights reserved.
+ * Copyright (C) 2008 Dmitri Vorobiev
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ */
+#include <linux/cpu.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/ioport.h>
+#include <linux/irq.h>
+#include <linux/pci.h>
+#include <linux/screen_info.h>
+#include <linux/time.h>
+
+#include <asm/bootinfo.h>
+#include <asm/mips-boards/generic.h>
+#include <asm/mips-boards/prom.h>
+#include <asm/traps.h>
+
+int coherentio; 	/* init to 0 => no DMA cache coherency (may be set by user) */
+int hw_coherentio;	/* init to 0 => no HW DMA cache coherency (reflects real HW) */
+
+const char *get_system_type(void)
+{
+	return "MIPS SEAD3";
+}
+
+#if defined(CONFIG_MIPS_MT_SMTC)
+const char display_string[] = "               SMTC LINUX ON SEAD3               ";
+#else
+const char display_string[] = "               LINUX ON SEAD3               ";
+#endif /* CONFIG_MIPS_MT_SMTC */
+
+void __init plat_mem_setup(void)
+{
+}
diff --git a/arch/mips/mti-sead3/sead3-smtc.c b/arch/mips/mti-sead3/sead3-smtc.c
new file mode 100644
index 0000000..192cfd2
--- /dev/null
+++ b/arch/mips/mti-sead3/sead3-smtc.c
@@ -0,0 +1,162 @@
+/*
+ * Malta Platform-specific hooks for SMP operation
+ */
+#include <linux/irq.h>
+#include <linux/init.h>
+
+#include <asm/mipsregs.h>
+#include <asm/mipsmtregs.h>
+#include <asm/smtc.h>
+#include <asm/smtc_ipi.h>
+
+/* VPE/SMP Prototype implements platform interfaces directly */
+
+/*
+ * Cause the specified action to be performed on a targeted "CPU"
+ */
+
+static void msmtc_send_ipi_single(int cpu, unsigned int action)
+{
+	/* "CPU" may be TC of same VPE, VPE of same CPU, or different CPU */
+	smtc_send_ipi(cpu, LINUX_SMP_IPI, action);
+}
+
+static void msmtc_send_ipi_mask(const struct cpumask *mask, unsigned int action)
+{
+	unsigned int i;
+
+	for_each_cpu(i, mask)
+		msmtc_send_ipi_single(i, action);
+}
+
+/*
+ * Post-config but pre-boot cleanup entry point
+ */
+static void __cpuinit msmtc_init_secondary(void)
+{
+	void smtc_init_secondary(void);
+	int myvpe;
+
+	/* Don't enable Malta I/O interrupts (IP2) for secondary VPEs */
+	myvpe = read_c0_tcbind() & TCBIND_CURVPE;
+	if (myvpe != 0) {
+		/* Ideally, this should be done only once per VPE, but... */
+		clear_c0_status(ST0_IM);
+		set_c0_status((0x100 << cp0_compare_irq)
+				| (0x100 << MIPS_CPU_IPI_IRQ));
+		if (cp0_perfcount_irq >= 0)
+			set_c0_status(0x100 << cp0_perfcount_irq);
+	}
+
+	smtc_init_secondary();
+}
+
+/*
+ * Platform "CPU" startup hook
+ */
+static void __cpuinit msmtc_boot_secondary(int cpu, struct task_struct *idle)
+{
+	smtc_boot_secondary(cpu, idle);
+}
+
+/*
+ * SMP initialization finalization entry point
+ */
+static void __cpuinit msmtc_smp_finish(void)
+{
+	smtc_smp_finish();
+}
+
+/*
+ * Hook for after all CPUs are online
+ */
+
+static void msmtc_cpus_done(void)
+{
+}
+
+/*
+ * Platform SMP pre-initialization
+ *
+ * As noted above, we can assume a single CPU for now
+ * but it may be multithreaded.
+ */
+
+static void __init msmtc_smp_setup(void)
+{
+	/*
+	 * we won't get the definitive value until
+	 * we've run smtc_prepare_cpus later, but
+	 * we would appear to need an upper bound now.
+	 */
+	smp_num_siblings = smtc_build_cpu_map(0);
+}
+
+static void __init msmtc_prepare_cpus(unsigned int max_cpus)
+{
+	smtc_prepare_cpus(max_cpus);
+}
+
+struct plat_smp_ops msmtc_smp_ops = {
+	.send_ipi_single	= msmtc_send_ipi_single,
+	.send_ipi_mask		= msmtc_send_ipi_mask,
+	.init_secondary		= msmtc_init_secondary,
+	.smp_finish		= msmtc_smp_finish,
+	.cpus_done		= msmtc_cpus_done,
+	.boot_secondary		= msmtc_boot_secondary,
+	.smp_setup		= msmtc_smp_setup,
+	.prepare_cpus		= msmtc_prepare_cpus,
+};
+
+#ifdef CONFIG_MIPS_MT_SMTC_IRQAFF
+/*
+ * IRQ affinity hook
+ */
+
+
+int plat_set_irq_affinity(unsigned int irq, const struct cpumask *affinity)
+{
+	cpumask_t tmask;
+	int cpu = 0;
+	void smtc_set_irq_affinity(unsigned int irq, cpumask_t aff);
+
+	/*
+	 * On the legacy Malta development board, all I/O interrupts
+	 * are routed through the 8259 and combined in a single signal
+	 * to the CPU daughterboard, and on the CoreFPGA2/3 34K models,
+	 * that signal is brought to IP2 of both VPEs. To avoid racing
+	 * concurrent interrupt service events, IP2 is enabled only on
+	 * one VPE, by convention VPE0.  So long as no bits are ever
+	 * cleared in the affinity mask, there will never be any
+	 * interrupt forwarding.  But as soon as a program or operator
+	 * sets affinity for one of the related IRQs, we need to make
+	 * sure that we don't ever try to forward across the VPE boundry,
+	 * at least not until we engineer a system where the interrupt
+	 * _ack() or _end() function can somehow know that it corresponds
+	 * to an interrupt taken on another VPE, and perform the appropriate
+	 * restoration of Status.IM state using MFTR/MTTR instead of the
+	 * normal local behavior. We also ensure that no attempt will
+	 * be made to forward to an offline "CPU".
+	 */
+
+	cpumask_copy(&tmask, affinity);
+	for_each_cpu(cpu, affinity) {
+		if ((cpu_data[cpu].vpe_id != 0) || !cpu_online(cpu))
+			cpu_clear(cpu, tmask);
+	}
+	cpumask_copy(irq_desc[irq].affinity, &tmask);
+
+	if (cpus_empty(tmask))
+		/*
+		 * We could restore a default mask here, but the
+		 * runtime code can anyway deal with the null set
+		 */
+		printk(KERN_WARNING
+			"IRQ affinity leaves no legal CPU for IRQ %d\n", irq);
+
+	/* Do any generic SMTC IRQ affinity setup */
+	smtc_set_irq_affinity(irq, tmask);
+
+	return 0;
+}
+#endif /* CONFIG_MIPS_MT_SMTC_IRQAFF */
diff --git a/arch/mips/mti-sead3/sead3-time.c b/arch/mips/mti-sead3/sead3-time.c
new file mode 100644
index 0000000..a31dd35
--- /dev/null
+++ b/arch/mips/mti-sead3/sead3-time.c
@@ -0,0 +1,145 @@
+/*
+ * Carsten Langgaard, carstenl@mips.com
+ * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * Setting up the clock on the MIPS boards.
+ */
+
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/kernel_stat.h>
+#include <linux/sched.h>
+#include <linux/spinlock.h>
+#include <linux/interrupt.h>
+#include <linux/time.h>
+#include <linux/timex.h>
+
+#include <asm/setup.h>
+#include <asm/mipsregs.h>
+#include <asm/mipsmtregs.h>
+#include <asm/hardirq.h>
+#include <asm/irq.h>
+#include <asm/div64.h>
+#include <asm/cpu.h>
+#include <asm/time.h>
+#include <asm/msc01_ic.h>
+
+#include <asm/mips-boards/generic.h>
+#include <asm/mips-boards/prom.h>
+
+unsigned long cpu_khz;
+
+static int mips_cpu_timer_irq;
+static int mips_cpu_perf_irq;
+extern int cp0_perfcount_irq;
+
+static void mips_timer_dispatch(void)
+{
+	do_IRQ(mips_cpu_timer_irq);
+}
+
+static void mips_perf_dispatch(void)
+{
+	do_IRQ(mips_cpu_perf_irq);
+}
+
+static void __iomem *status_reg   = (void __iomem *)0xbf000410;
+
+/*
+ * Estimate CPU frequency.  Sets mips_hpt_frequency as a side-effect
+ */
+static unsigned int __init estimate_cpu_frequency(void)
+{
+	unsigned int prid = read_c0_prid() & 0xffff00;
+	unsigned int tick = 0;
+	unsigned int freq;
+	unsigned int orig;
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+	orig = readl(status_reg) & 0x2;               /* get original sample */
+	/* wait for transition */
+	while ((readl(status_reg) & 0x2) == orig)
+		;
+	orig = orig ^ 0x2;                            /* flip the bit */
+
+	write_c0_count(0);
+
+	/* wait 1 second (the sampling clock transitions every 10ms) */
+	while (tick < 100) {
+		/* wait for transition */
+		while ((readl(status_reg) & 0x2) == orig)
+			;
+		orig = orig ^ 0x2;                            /* flip the bit */
+		tick++;
+	}
+
+	freq = read_c0_count();
+
+	local_irq_restore(flags);
+
+	mips_hpt_frequency = freq;
+
+	/* Adjust for processor */
+	if ((prid != (PRID_COMP_MIPS | PRID_IMP_20KC)) &&
+		(prid != (PRID_COMP_MIPS | PRID_IMP_25KF)))
+		freq *= 2;
+
+	freq += 5000;        /* rounding */
+	freq -= freq%10000;
+
+	return freq ;
+}
+
+void read_persistent_clock(struct timespec *ts)
+{
+	ts->tv_sec = 0;		/* FIXME - i2c is not up yet => can't access RTC */
+	ts->tv_nsec = 0;
+}
+
+static void __init plat_perf_setup(void)
+{
+	if (cp0_perfcount_irq >= 0) {
+		if (cpu_has_vint)
+			set_vi_handler(cp0_perfcount_irq, mips_perf_dispatch);
+		mips_cpu_perf_irq = MIPS_CPU_IRQ_BASE + cp0_perfcount_irq;
+	}
+}
+
+unsigned int __cpuinit get_c0_compare_int(void)
+{
+	if (cpu_has_vint)
+		set_vi_handler(cp0_compare_irq, mips_timer_dispatch);
+	mips_cpu_timer_irq = MIPS_CPU_IRQ_BASE + cp0_compare_irq;
+	return mips_cpu_timer_irq;
+}
+
+void __init plat_time_init(void)
+{
+	unsigned int est_freq;
+
+	est_freq = estimate_cpu_frequency();
+
+	printk("CPU frequency %d.%02d MHz\n", est_freq/1000000,
+	       (est_freq%1000000)*100/1000000);
+
+	cpu_khz = est_freq / 1000;
+
+	mips_scroll_message();
+
+	plat_perf_setup();
+}
-- 
1.7.10
