Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Sep 2012 16:49:16 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:37709 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903398Ab2IXOtF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Sep 2012 16:49:05 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1TG9xy-0007fV-Nn; Mon, 24 Sep 2012 09:48:58 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH] MIPS: MIPSsim: Remove the MIPSsim platform.
Date:   Mon, 24 Sep 2012 09:48:53 -0500
Message-Id: <1348498133-30328-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.5
X-archive-position: 34545
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

The MIPSsim platform is no longer supported or used.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/Kconfig                          |   19 -----
 arch/mips/configs/mipssim_defconfig        |   64 ---------------
 arch/mips/include/asm/mips-boards/simint.h |   31 --------
 arch/mips/mipssim/Makefile                 |   23 ------
 arch/mips/mipssim/Platform                 |    6 --
 arch/mips/mipssim/sim_console.c            |   40 ----------
 arch/mips/mipssim/sim_int.c                |   87 ---------------------
 arch/mips/mipssim/sim_mem.c                |  115 ---------------------------
 arch/mips/mipssim/sim_platform.c           |   35 ---------
 arch/mips/mipssim/sim_setup.c              |   99 -----------------------
 arch/mips/mipssim/sim_smtc.c               |  116 ---------------------------
 arch/mips/mipssim/sim_time.c               |  117 ----------------------------
 12 files changed, 752 deletions(-)
 delete mode 100644 arch/mips/configs/mipssim_defconfig
 delete mode 100644 arch/mips/include/asm/mips-boards/simint.h
 delete mode 100644 arch/mips/mipssim/Makefile
 delete mode 100644 arch/mips/mipssim/Platform
 delete mode 100644 arch/mips/mipssim/sim_console.c
 delete mode 100644 arch/mips/mipssim/sim_int.c
 delete mode 100644 arch/mips/mipssim/sim_mem.c
 delete mode 100644 arch/mips/mipssim/sim_platform.c
 delete mode 100644 arch/mips/mipssim/sim_setup.c
 delete mode 100644 arch/mips/mipssim/sim_smtc.c
 delete mode 100644 arch/mips/mipssim/sim_time.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 6e52408..f989b0c 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -350,25 +350,6 @@ config MIPS_SEAD3
 	  This enables support for the MIPS Technologies SEAD3 evaluation
 	  board.
 
-config MIPS_SIM
-	bool 'MIPS simulator (MIPSsim)'
-	select CEVT_R4K
-	select CSRC_R4K
-	select DMA_NONCOHERENT
-	select SYS_HAS_EARLY_PRINTK
-	select IRQ_CPU
-	select BOOT_RAW
-	select SYS_HAS_CPU_MIPS32_R1
-	select SYS_HAS_CPU_MIPS32_R2
-	select SYS_HAS_EARLY_PRINTK
-	select SYS_SUPPORTS_32BIT_KERNEL
-	select SYS_SUPPORTS_BIG_ENDIAN
-	select SYS_SUPPORTS_MULTITHREADING
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-	help
-	  This option enables support for MIPS Technologies MIPSsim software
-	  emulator.
-
 config NEC_MARKEINS
 	bool "NEC EMMA2RH Mark-eins board"
 	select SOC_EMMA2RH
diff --git a/arch/mips/configs/mipssim_defconfig b/arch/mips/configs/mipssim_defconfig
deleted file mode 100644
index b5ad738..0000000
--- a/arch/mips/configs/mipssim_defconfig
+++ /dev/null
@@ -1,64 +0,0 @@
-CONFIG_MIPS_SIM=y
-CONFIG_CPU_LITTLE_ENDIAN=y
-CONFIG_HZ_100=y
-# CONFIG_SECCOMP is not set
-CONFIG_EXPERIMENTAL=y
-# CONFIG_SWAP is not set
-CONFIG_SYSVIPC=y
-CONFIG_LOG_BUF_SHIFT=14
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
-CONFIG_EXPERT=y
-CONFIG_SLAB=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODVERSIONS=y
-CONFIG_MODULE_SRCVERSION_ALL=y
-# CONFIG_BLK_DEV_BSG is not set
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_INET=y
-CONFIG_IP_MULTICAST=y
-CONFIG_IP_ADVANCED_ROUTER=y
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
-CONFIG_IP_PNP_BOOTP=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
-# CONFIG_IPV6 is not set
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
-# CONFIG_STANDALONE is not set
-# CONFIG_PREVENT_FIRMWARE_BUILD is not set
-# CONFIG_FW_LOADER is not set
-CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_NBD=y
-# CONFIG_MISC_DEVICES is not set
-CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
-CONFIG_MIPS_SIM_NET=y
-# CONFIG_NETDEV_1000 is not set
-# CONFIG_NETDEV_10000 is not set
-# CONFIG_INPUT is not set
-# CONFIG_SERIO is not set
-# CONFIG_VT is not set
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_NR_UARTS=1
-CONFIG_SERIAL_8250_RUNTIME_UARTS=1
-# CONFIG_HW_RANDOM is not set
-# CONFIG_HWMON is not set
-# CONFIG_USB_SUPPORT is not set
-# CONFIG_DNOTIFY is not set
-CONFIG_TMPFS=y
-CONFIG_ROMFS_FS=y
-CONFIG_NFS_FS=y
-CONFIG_NFS_V3=y
-CONFIG_ROOT_NFS=y
-CONFIG_DEBUG_KERNEL=y
-# CONFIG_SCHED_DEBUG is not set
-CONFIG_DEBUG_INFO=y
-CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="nfsroot=192.168.192.169:/u1/mipsel,timeo=20 ip=dhcp"
-# CONFIG_CRC32 is not set
diff --git a/arch/mips/include/asm/mips-boards/simint.h b/arch/mips/include/asm/mips-boards/simint.h
deleted file mode 100644
index 8ef6db7..0000000
--- a/arch/mips/include/asm/mips-boards/simint.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/*
- * Copyright (C) 2005 MIPS Technologies, Inc.  All rights reserved.
- *
- *  This program is free software; you can distribute it and/or modify it
- *  under the terms of the GNU General Public License (Version 2) as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope it will be useful, but WITHOUT
- *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
- *  for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
- */
-#ifndef _MIPS_SIMINT_H
-#define _MIPS_SIMINT_H
-
-#include <irq.h>
-
-#define SIM_INT_BASE		0
-#define MIPSCPU_INT_MB0		2
-#define MIPS_CPU_TIMER_IRQ	7
-
-
-#define MSC01E_INT_BASE		64
-
-#define MSC01E_INT_CPUCTR	11
-
-#endif
diff --git a/arch/mips/mipssim/Makefile b/arch/mips/mipssim/Makefile
deleted file mode 100644
index 01410a3..0000000
--- a/arch/mips/mipssim/Makefile
+++ /dev/null
@@ -1,23 +0,0 @@
-#
-# Copyright (C) 2005 MIPS Technologies, Inc.  All rights reserved.
-# Copyright (C) 2007 MIPS Technologies, Inc.
-#   written by Ralf Baechle (ralf@linux-mips.org)
-#
-# This program is free software; you can distribute it and/or modify it
-# under the terms of the GNU General Public License (Version 2) as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope it will be useful, but WITHOUT
-# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
-# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
-#
-
-obj-y := sim_platform.o sim_setup.o sim_mem.o sim_time.o sim_int.o
-
-obj-$(CONFIG_EARLY_PRINTK) += sim_console.o
-obj-$(CONFIG_MIPS_MT_SMTC) += sim_smtc.o
diff --git a/arch/mips/mipssim/Platform b/arch/mips/mipssim/Platform
deleted file mode 100644
index 3df60b8a..0000000
--- a/arch/mips/mipssim/Platform
+++ /dev/null
@@ -1,6 +0,0 @@
-#
-# MIPS SIM
-#
-platform-$(CONFIG_MIPS_SIM)	+= mipssim/
-cflags-$(CONFIG_MIPS_SIM)	+= -I$(srctree)/arch/mips/include/asm/mach-mipssim
-load-$(CONFIG_MIPS_SIM)		+= 0x80100000
diff --git a/arch/mips/mipssim/sim_console.c b/arch/mips/mipssim/sim_console.c
deleted file mode 100644
index a2f4167..0000000
--- a/arch/mips/mipssim/sim_console.c
+++ /dev/null
@@ -1,40 +0,0 @@
-/*
- *  This program is free software; you can distribute it and/or modify it
- *  under the terms of the GNU General Public License (Version 2) as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope it will be useful, but WITHOUT
- *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
- *  for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
- *
- * Carsten Langgaard, carstenl@mips.com
- * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
- * Copyright (C) 2007 MIPS Technologies, Inc.
- *   written by Ralf Baechle
- */
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/serial_reg.h>
-
-static inline unsigned int serial_in(int offset)
-{
-	return inb(0x3f8 + offset);
-}
-
-static inline void serial_out(int offset, int value)
-{
-	outb(value, 0x3f8 + offset);
-}
-
-void __init prom_putchar(char c)
-{
-	while ((serial_in(UART_LSR) & UART_LSR_THRE) == 0)
-		;
-
-	serial_out(UART_TX, c);
-}
diff --git a/arch/mips/mipssim/sim_int.c b/arch/mips/mipssim/sim_int.c
deleted file mode 100644
index 5c779be..0000000
--- a/arch/mips/mipssim/sim_int.c
+++ /dev/null
@@ -1,87 +0,0 @@
-/*
- * Copyright (C) 1999, 2005 MIPS Technologies, Inc.  All rights reserved.
- *
- *  This program is free software; you can distribute it and/or modify it
- *  under the terms of the GNU General Public License (Version 2) as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope it will be useful, but WITHOUT
- *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
- *  for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
- *
- */
-#include <linux/init.h>
-#include <linux/sched.h>
-#include <linux/interrupt.h>
-#include <linux/kernel_stat.h>
-#include <asm/mips-boards/simint.h>
-#include <asm/irq_cpu.h>
-
-static inline int clz(unsigned long x)
-{
-	__asm__(
-	"	.set	push					\n"
-	"	.set	mips32					\n"
-	"	clz	%0, %1					\n"
-	"	.set	pop					\n"
-	: "=r" (x)
-	: "r" (x));
-
-	return x;
-}
-
-/*
- * Version of ffs that only looks at bits 12..15.
- */
-static inline unsigned int irq_ffs(unsigned int pending)
-{
-#if defined(CONFIG_CPU_MIPS32) || defined(CONFIG_CPU_MIPS64)
-	return -clz(pending) + 31 - CAUSEB_IP;
-#else
-	unsigned int a0 = 7;
-	unsigned int t0;
-
-	t0 = s0 & 0xf000;
-	t0 = t0 < 1;
-	t0 = t0 << 2;
-	a0 = a0 - t0;
-	s0 = s0 << t0;
-
-	t0 = s0 & 0xc000;
-	t0 = t0 < 1;
-	t0 = t0 << 1;
-	a0 = a0 - t0;
-	s0 = s0 << t0;
-
-	t0 = s0 & 0x8000;
-	t0 = t0 < 1;
-	/* t0 = t0 << 2; */
-	a0 = a0 - t0;
-	/* s0 = s0 << t0; */
-
-	return a0;
-#endif
-}
-
-asmlinkage void plat_irq_dispatch(void)
-{
-	unsigned int pending = read_c0_cause() & read_c0_status() & ST0_IM;
-	int irq;
-
-	irq = irq_ffs(pending);
-
-	if (irq > 0)
-		do_IRQ(MIPS_CPU_IRQ_BASE + irq);
-	else
-		spurious_interrupt();
-}
-
-void __init arch_init_irq(void)
-{
-	mips_cpu_irq_init();
-}
diff --git a/arch/mips/mipssim/sim_mem.c b/arch/mips/mipssim/sim_mem.c
deleted file mode 100644
index 953d836..0000000
--- a/arch/mips/mipssim/sim_mem.c
+++ /dev/null
@@ -1,115 +0,0 @@
-/*
- * Copyright (C) 2005 MIPS Technologies, Inc.  All rights reserved.
- *
- *  This program is free software; you can distribute it and/or modify it
- *  under the terms of the GNU General Public License (Version 2) as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope it will be useful, but WITHOUT
- *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
- *  for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
- *
- */
-#include <linux/init.h>
-#include <linux/mm.h>
-#include <linux/bootmem.h>
-#include <linux/pfn.h>
-
-#include <asm/bootinfo.h>
-#include <asm/page.h>
-#include <asm/sections.h>
-
-#include <asm/mips-boards/prom.h>
-
-/*#define DEBUG*/
-
-enum simmem_memtypes {
-	simmem_reserved = 0,
-	simmem_free,
-};
-struct prom_pmemblock mdesc[PROM_MAX_PMEMBLOCKS];
-
-#ifdef DEBUG
-static char *mtypes[3] = {
-	"SIM reserved memory",
-	"SIM free memory",
-};
-#endif
-
-struct prom_pmemblock * __init prom_getmdesc(void)
-{
-	unsigned int memsize;
-
-	memsize = 0x02000000;
-	pr_info("Setting default memory size 0x%08x\n", memsize);
-
-	memset(mdesc, 0, sizeof(mdesc));
-
-	mdesc[0].type = simmem_reserved;
-	mdesc[0].base = 0x00000000;
-	mdesc[0].size = 0x00001000;
-
-	mdesc[1].type = simmem_free;
-	mdesc[1].base = 0x00001000;
-	mdesc[1].size = 0x000ff000;
-
-	mdesc[2].type = simmem_reserved;
-	mdesc[2].base = 0x00100000;
-	mdesc[2].size = CPHYSADDR(PFN_ALIGN(&_end)) - mdesc[2].base;
-
-	mdesc[3].type = simmem_free;
-	mdesc[3].base = CPHYSADDR(PFN_ALIGN(&_end));
-	mdesc[3].size = memsize - mdesc[3].base;
-
-	return &mdesc[0];
-}
-
-static int __init prom_memtype_classify(unsigned int type)
-{
-	switch (type) {
-	case simmem_free:
-		return BOOT_MEM_RAM;
-	case simmem_reserved:
-	default:
-		return BOOT_MEM_RESERVED;
-	}
-}
-
-void __init prom_meminit(void)
-{
-	struct prom_pmemblock *p;
-
-	p = prom_getmdesc();
-
-	while (p->size) {
-		long type;
-		unsigned long base, size;
-
-		type = prom_memtype_classify(p->type);
-		base = p->base;
-		size = p->size;
-
-		add_memory_region(base, size, type);
-		p++;
-	}
-}
-
-void __init prom_free_prom_memory(void)
-{
-	int i;
-	unsigned long addr;
-
-	for (i = 0; i < boot_mem_map.nr_map; i++) {
-		if (boot_mem_map.map[i].type != BOOT_MEM_ROM_DATA)
-			continue;
-
-		addr = boot_mem_map.map[i].addr;
-		free_init_pages("prom memory",
-				addr, addr + boot_mem_map.map[i].size);
-	}
-}
diff --git a/arch/mips/mipssim/sim_platform.c b/arch/mips/mipssim/sim_platform.c
deleted file mode 100644
index 53210a8..0000000
--- a/arch/mips/mipssim/sim_platform.c
+++ /dev/null
@@ -1,35 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2007 by Ralf Baechle (ralf@linux-mips.org)
- */
-#include <linux/init.h>
-#include <linux/if_ether.h>
-#include <linux/kernel.h>
-#include <linux/platform_device.h>
-
-static char mipsnet_string[] = "mipsnet";
-
-static struct platform_device eth1_device = {
-	.name		= mipsnet_string,
-	.id		= 0,
-};
-
-/*
- * Create a platform device for the GPI port that receives the
- * image data from the embedded camera.
- */
-static int __init mipsnet_devinit(void)
-{
-	int err;
-
-	err = platform_device_register(&eth1_device);
-	if (err)
-		printk(KERN_ERR "%s: registration failed\n", mipsnet_string);
-
-	return err;
-}
-
-device_initcall(mipsnet_devinit);
diff --git a/arch/mips/mipssim/sim_setup.c b/arch/mips/mipssim/sim_setup.c
deleted file mode 100644
index 256e0cd..0000000
--- a/arch/mips/mipssim/sim_setup.c
+++ /dev/null
@@ -1,99 +0,0 @@
-/*
- * Copyright (C) 2005 MIPS Technologies, Inc.  All rights reserved.
- *
- *  This program is free software; you can distribute it and/or modify it
- *  under the terms of the GNU General Public License (Version 2) as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope it will be useful, but WITHOUT
- *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
- *  for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
- *
- */
-
-#include <linux/init.h>
-#include <linux/string.h>
-#include <linux/kernel.h>
-#include <linux/io.h>
-#include <linux/irq.h>
-#include <linux/ioport.h>
-#include <linux/tty.h>
-#include <linux/serial.h>
-#include <linux/serial_core.h>
-#include <linux/serial_8250.h>
-
-#include <asm/cpu.h>
-#include <asm/bootinfo.h>
-#include <asm/mips-boards/generic.h>
-#include <asm/mips-boards/prom.h>
-#include <asm/time.h>
-#include <asm/mips-boards/sim.h>
-#include <asm/mips-boards/simint.h>
-#include <asm/smp-ops.h>
-
-
-static void __init serial_init(void);
-unsigned int _isbonito;
-
-const char *get_system_type(void)
-{
-	return "MIPSsim";
-}
-
-void __init plat_mem_setup(void)
-{
-	set_io_port_base(0xbfd00000);
-
-	serial_init();
-}
-
-extern struct plat_smp_ops ssmtc_smp_ops;
-
-void __init prom_init(void)
-{
-	set_io_port_base(0xbfd00000);
-
-	prom_meminit();
-
-	if (cpu_has_mipsmt) {
-		if (!register_vsmp_smp_ops())
-			return;
-
-#ifdef CONFIG_MIPS_MT_SMTC
-		register_smp_ops(&ssmtc_smp_ops);
-			return;
-#endif
-	}
-
-	register_up_smp_ops();
-}
-
-static void __init serial_init(void)
-{
-#ifdef CONFIG_SERIAL_8250
-	struct uart_port s;
-
-	memset(&s, 0, sizeof(s));
-
-	s.iobase = 0x3f8;
-
-	/* hardware int 4 - the serial int, is CPU int 6
-	 but poll for now */
-	s.irq =  0;
-	s.uartclk = 1843200;
-	s.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
-	s.iotype = UPIO_PORT;
-	s.regshift = 0;
-	s.timeout = 4;
-
-	if (early_serial_setup(&s) != 0) {
-		printk(KERN_ERR "Serial setup failed!\n");
-	}
-
-#endif
-}
diff --git a/arch/mips/mipssim/sim_smtc.c b/arch/mips/mipssim/sim_smtc.c
deleted file mode 100644
index 3c104ab..0000000
--- a/arch/mips/mipssim/sim_smtc.c
+++ /dev/null
@@ -1,116 +0,0 @@
-/*
- * Copyright (C) 2005 MIPS Technologies, Inc.  All rights reserved.
- *
- *  This program is free software; you can distribute it and/or modify it
- *  under the terms of the GNU General Public License (Version 2) as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope it will be useful, but WITHOUT
- *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
- *  for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
- *
- */
-/*
- * Simulator Platform-specific hooks for SMTC operation
- */
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/cpumask.h>
-#include <linux/interrupt.h>
-#include <linux/smp.h>
-
-#include <linux/atomic.h>
-#include <asm/cpu.h>
-#include <asm/processor.h>
-#include <asm/smtc.h>
-#include <asm/mmu_context.h>
-#include <asm/smtc_ipi.h>
-
-/* VPE/SMP Prototype implements platform interfaces directly */
-
-/*
- * Cause the specified action to be performed on a targeted "CPU"
- */
-
-static void ssmtc_send_ipi_single(int cpu, unsigned int action)
-{
-	smtc_send_ipi(cpu, LINUX_SMP_IPI, action);
-	/* "CPU" may be TC of same VPE, VPE of same CPU, or different CPU */
-}
-
-static inline void ssmtc_send_ipi_mask(const struct cpumask *mask,
-				       unsigned int action)
-{
-	unsigned int i;
-
-	for_each_cpu(i, mask)
-		ssmtc_send_ipi_single(i, action);
-}
-
-/*
- * Post-config but pre-boot cleanup entry point
- */
-static void __cpuinit ssmtc_init_secondary(void)
-{
-	smtc_init_secondary();
-}
-
-/*
- * SMP initialization finalization entry point
- */
-static void __cpuinit ssmtc_smp_finish(void)
-{
-	smtc_smp_finish();
-}
-
-/*
- * Hook for after all CPUs are online
- */
-static void ssmtc_cpus_done(void)
-{
-}
-
-/*
- * Platform "CPU" startup hook
- */
-static void __cpuinit ssmtc_boot_secondary(int cpu, struct task_struct *idle)
-{
-	smtc_boot_secondary(cpu, idle);
-}
-
-static void __init ssmtc_smp_setup(void)
-{
-	if (read_c0_config3() & (1 << 2))
-		mipsmt_build_cpu_map(0);
-}
-
-/*
- * Platform SMP pre-initialization
- */
-static void ssmtc_prepare_cpus(unsigned int max_cpus)
-{
-	/*
-	 * As noted above, we can assume a single CPU for now
-	 * but it may be multithreaded.
-	 */
-
-	if (read_c0_config3() & (1 << 2)) {
-		mipsmt_prepare_cpus();
-	}
-}
-
-struct plat_smp_ops ssmtc_smp_ops = {
-	.send_ipi_single	= ssmtc_send_ipi_single,
-	.send_ipi_mask		= ssmtc_send_ipi_mask,
-	.init_secondary		= ssmtc_init_secondary,
-	.smp_finish		= ssmtc_smp_finish,
-	.cpus_done		= ssmtc_cpus_done,
-	.boot_secondary		= ssmtc_boot_secondary,
-	.smp_setup		= ssmtc_smp_setup,
-	.prepare_cpus		= ssmtc_prepare_cpus,
-};
diff --git a/arch/mips/mipssim/sim_time.c b/arch/mips/mipssim/sim_time.c
deleted file mode 100644
index 77bad3c..0000000
--- a/arch/mips/mipssim/sim_time.c
+++ /dev/null
@@ -1,117 +0,0 @@
-#include <linux/types.h>
-#include <linux/init.h>
-#include <linux/kernel_stat.h>
-#include <linux/sched.h>
-#include <linux/spinlock.h>
-#include <linux/interrupt.h>
-#include <linux/mc146818rtc.h>
-#include <linux/smp.h>
-#include <linux/timex.h>
-
-#include <asm/hardirq.h>
-#include <asm/div64.h>
-#include <asm/cpu.h>
-#include <asm/setup.h>
-#include <asm/time.h>
-#include <asm/irq.h>
-#include <asm/mc146818-time.h>
-#include <asm/msc01_ic.h>
-
-#include <asm/mips-boards/generic.h>
-#include <asm/mips-boards/prom.h>
-#include <asm/mips-boards/simint.h>
-
-
-unsigned long cpu_khz;
-
-/*
- * Estimate CPU frequency.  Sets mips_hpt_frequency as a side-effect
- */
-static unsigned int __init estimate_cpu_frequency(void)
-{
-	unsigned int prid = read_c0_prid() & 0xffff00;
-	unsigned int count;
-
-#if 1
-	/*
-	 * hardwire the board frequency to 12MHz.
-	 */
-
-	if ((prid == (PRID_COMP_MIPS | PRID_IMP_20KC)) ||
-	    (prid == (PRID_COMP_MIPS | PRID_IMP_25KF)))
-		count = 12000000;
-	else
-		count =  6000000;
-#else
-	unsigned int flags;
-
-	local_irq_save(flags);
-
-	/* Start counter exactly on falling edge of update flag */
-	while (CMOS_READ(RTC_REG_A) & RTC_UIP);
-	while (!(CMOS_READ(RTC_REG_A) & RTC_UIP));
-
-	/* Start r4k counter. */
-	write_c0_count(0);
-
-	/* Read counter exactly on falling edge of update flag */
-	while (CMOS_READ(RTC_REG_A) & RTC_UIP);
-	while (!(CMOS_READ(RTC_REG_A) & RTC_UIP));
-
-	count = read_c0_count();
-
-	/* restore interrupts */
-	local_irq_restore(flags);
-#endif
-
-	mips_hpt_frequency = count;
-
-	if ((prid != (PRID_COMP_MIPS | PRID_IMP_20KC)) &&
-	    (prid != (PRID_COMP_MIPS | PRID_IMP_25KF)))
-		count *= 2;
-
-	count += 5000;    /* round */
-	count -= count%10000;
-
-	return count;
-}
-
-static int mips_cpu_timer_irq;
-
-static void mips_timer_dispatch(void)
-{
-	do_IRQ(mips_cpu_timer_irq);
-}
-
-
-unsigned __cpuinit get_c0_compare_int(void)
-{
-#ifdef MSC01E_INT_BASE
-	if (cpu_has_veic) {
-		set_vi_handler(MSC01E_INT_CPUCTR, mips_timer_dispatch);
-		mips_cpu_timer_irq = MSC01E_INT_BASE + MSC01E_INT_CPUCTR;
-
-		return mips_cpu_timer_irq;
-	}
-#endif
-	if (cpu_has_vint)
-		set_vi_handler(cp0_compare_irq, mips_timer_dispatch);
-	mips_cpu_timer_irq = MIPS_CPU_IRQ_BASE + cp0_compare_irq;
-
-	return mips_cpu_timer_irq;
-}
-
-void __init plat_time_init(void)
-{
-	unsigned int est_freq;
-
-	/* Set Data mode - binary. */
-	CMOS_WRITE(CMOS_READ(RTC_CONTROL) | RTC_DM_BINARY, RTC_CONTROL);
-
-	est_freq = estimate_cpu_frequency();
-
-	printk(KERN_INFO "CPU frequency %d.%02d MHz\n", est_freq / 1000000,
-	       (est_freq % 1000000) * 100 / 1000000);
-
-	cpu_khz = est_freq / 1000;
-}
-- 
1.7.9.5
