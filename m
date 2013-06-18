Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jun 2013 20:01:30 +0200 (CEST)
Received: from mail1.windriver.com ([147.11.146.13]:55359 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6825821Ab3FRSB05d-X- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Jun 2013 20:01:26 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id r5II1KcN016182
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 18 Jun 2013 11:01:20 -0700 (PDT)
Received: from yow-lpgnfs-02.corp.ad.wrs.com (128.224.149.8) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.2.342.3; Tue, 18 Jun 2013 11:01:19 -0700
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH] mips: delete Wind River ppmc eval board support.
Date:   Tue, 18 Jun 2013 14:01:10 -0400
Message-ID: <1371578470-29924-1-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 1.8.1.2
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Paul.Gortmaker@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36987
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
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

This board has been EOL for many years now; lets not burden
people doing build coverage and other tree wide work with
working on essentially dead files.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/mips/Kbuild.platforms                       |   1 -
 arch/mips/Kconfig                                |  23 ----
 arch/mips/configs/wrppmc_defconfig               |  97 -----------------
 arch/mips/include/asm/mach-wrppmc/mach-gt64120.h |  83 ---------------
 arch/mips/pci/Makefile                           |   1 -
 arch/mips/pci/fixup-wrppmc.c                     |  37 -------
 arch/mips/wrppmc/Makefile                        |  12 ---
 arch/mips/wrppmc/Platform                        |   7 --
 arch/mips/wrppmc/irq.c                           |  56 ----------
 arch/mips/wrppmc/pci.c                           |  52 ---------
 arch/mips/wrppmc/reset.c                         |  41 --------
 arch/mips/wrppmc/serial.c                        |  80 --------------
 arch/mips/wrppmc/setup.c                         | 128 -----------------------
 arch/mips/wrppmc/time.c                          |  39 -------
 14 files changed, 657 deletions(-)
 delete mode 100644 arch/mips/configs/wrppmc_defconfig
 delete mode 100644 arch/mips/include/asm/mach-wrppmc/mach-gt64120.h
 delete mode 100644 arch/mips/pci/fixup-wrppmc.c
 delete mode 100644 arch/mips/wrppmc/Makefile
 delete mode 100644 arch/mips/wrppmc/Platform
 delete mode 100644 arch/mips/wrppmc/irq.c
 delete mode 100644 arch/mips/wrppmc/pci.c
 delete mode 100644 arch/mips/wrppmc/reset.c
 delete mode 100644 arch/mips/wrppmc/serial.c
 delete mode 100644 arch/mips/wrppmc/setup.c
 delete mode 100644 arch/mips/wrppmc/time.c

diff --git a/arch/mips/Kbuild.platforms b/arch/mips/Kbuild.platforms
index 4b597d9..d9d81c2 100644
--- a/arch/mips/Kbuild.platforms
+++ b/arch/mips/Kbuild.platforms
@@ -30,7 +30,6 @@ platforms += sibyte
 platforms += sni
 platforms += txx9
 platforms += vr41xx
-platforms += wrppmc
 
 # include the platform specific files
 include $(patsubst %, $(srctree)/arch/mips/%/Platform, $(platforms))
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 30d200d..1f8a495 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -711,29 +711,6 @@ config MIKROTIK_RB532
 	  Support the Mikrotik(tm) RouterBoard 532 series,
 	  based on the IDT RC32434 SoC.
 
-config WR_PPMC
-	bool "Wind River PPMC board"
-	select CEVT_R4K
-	select CSRC_R4K
-	select IRQ_CPU
-	select BOOT_ELF32
-	select DMA_NONCOHERENT
-	select HW_HAS_PCI
-	select PCI_GT64XXX_PCI0
-	select SWAP_IO_SPACE
-	select SYS_HAS_CPU_MIPS32_R1
-	select SYS_HAS_CPU_MIPS32_R2
-	select SYS_HAS_CPU_MIPS64_R1
-	select SYS_HAS_CPU_NEVADA
-	select SYS_HAS_CPU_RM7000
-	select SYS_SUPPORTS_32BIT_KERNEL
-	select SYS_SUPPORTS_64BIT_KERNEL
-	select SYS_SUPPORTS_BIG_ENDIAN
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-	help
-	  This enables support for the Wind River MIPS32 4KC PPMC evaluation
-	  board, which is based on GT64120 bridge chip.
-
 config CAVIUM_OCTEON_SOC
 	bool "Cavium Networks Octeon SoC based boards"
 	select CEVT_R4K
diff --git a/arch/mips/configs/wrppmc_defconfig b/arch/mips/configs/wrppmc_defconfig
deleted file mode 100644
index 44a451b..0000000
--- a/arch/mips/configs/wrppmc_defconfig
+++ /dev/null
@@ -1,97 +0,0 @@
-CONFIG_WR_PPMC=y
-CONFIG_HZ_1000=y
-CONFIG_EXPERIMENTAL=y
-# CONFIG_SWAP is not set
-CONFIG_SYSVIPC=y
-CONFIG_BSD_PROCESS_ACCT=y
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
-CONFIG_EXPERT=y
-CONFIG_KALLSYMS_EXTRA_PASS=y
-# CONFIG_EPOLL is not set
-CONFIG_SLAB=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODVERSIONS=y
-CONFIG_MODULE_SRCVERSION_ALL=y
-CONFIG_PCI=y
-CONFIG_HOTPLUG_PCI=y
-CONFIG_BINFMT_MISC=y
-CONFIG_PM=y
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_XFRM_MIGRATE=y
-CONFIG_INET=y
-CONFIG_IP_MULTICAST=y
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
-CONFIG_IP_PNP_BOOTP=y
-CONFIG_IP_PNP_RARP=y
-CONFIG_IP_MROUTE=y
-CONFIG_ARPD=y
-CONFIG_INET_XFRM_MODE_TRANSPORT=m
-CONFIG_INET_XFRM_MODE_TUNNEL=m
-CONFIG_INET_XFRM_MODE_BEET=m
-CONFIG_TCP_MD5SIG=y
-# CONFIG_IPV6 is not set
-CONFIG_NETWORK_SECMARK=y
-CONFIG_FW_LOADER=m
-CONFIG_BLK_DEV_RAM=y
-CONFIG_SGI_IOC4=m
-CONFIG_NETDEVICES=y
-CONFIG_PHYLIB=y
-CONFIG_VITESSE_PHY=m
-CONFIG_SMSC_PHY=m
-CONFIG_NET_ETHERNET=y
-CONFIG_NET_PCI=y
-CONFIG_E100=y
-CONFIG_QLA3XXX=m
-CONFIG_CHELSIO_T3=m
-CONFIG_NETXEN_NIC=m
-# CONFIG_INPUT is not set
-# CONFIG_SERIO is not set
-# CONFIG_VT is not set
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_NR_UARTS=1
-CONFIG_SERIAL_8250_RUNTIME_UARTS=1
-# CONFIG_HW_RANDOM is not set
-CONFIG_PROC_KCORE=y
-CONFIG_TMPFS=y
-CONFIG_TMPFS_POSIX_ACL=y
-CONFIG_NFS_FS=y
-CONFIG_NFS_V3=y
-CONFIG_ROOT_NFS=y
-CONFIG_DLM=m
-CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="console=ttyS0,115200n8"
-CONFIG_CRYPTO_NULL=m
-CONFIG_CRYPTO_CBC=m
-CONFIG_CRYPTO_ECB=m
-CONFIG_CRYPTO_LRW=m
-CONFIG_CRYPTO_PCBC=m
-CONFIG_CRYPTO_XCBC=m
-CONFIG_CRYPTO_MD4=m
-CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_SHA256=m
-CONFIG_CRYPTO_SHA512=m
-CONFIG_CRYPTO_TGR192=m
-CONFIG_CRYPTO_WP512=m
-CONFIG_CRYPTO_ANUBIS=m
-CONFIG_CRYPTO_ARC4=m
-CONFIG_CRYPTO_BLOWFISH=m
-CONFIG_CRYPTO_CAMELLIA=m
-CONFIG_CRYPTO_CAST5=m
-CONFIG_CRYPTO_CAST6=m
-CONFIG_CRYPTO_DES=m
-CONFIG_CRYPTO_FCRYPT=m
-CONFIG_CRYPTO_KHAZAD=m
-CONFIG_CRYPTO_SERPENT=m
-CONFIG_CRYPTO_TEA=m
-CONFIG_CRYPTO_TWOFISH=m
-CONFIG_CRYPTO_DEFLATE=m
-CONFIG_CRC_CCITT=y
-CONFIG_CRC16=y
-CONFIG_LIBCRC32C=y
diff --git a/arch/mips/include/asm/mach-wrppmc/mach-gt64120.h b/arch/mips/include/asm/mach-wrppmc/mach-gt64120.h
deleted file mode 100644
index 00fa368..0000000
--- a/arch/mips/include/asm/mach-wrppmc/mach-gt64120.h
+++ /dev/null
@@ -1,83 +0,0 @@
-/*
- * This is a direct copy of the ev96100.h file, with a global
- * search and replace.	The numbers are the same.
- *
- * The reason I'm duplicating this is so that the 64120/96100
- * defines won't be confusing in the source code.
- */
-#ifndef __ASM_MIPS_GT64120_H
-#define __ASM_MIPS_GT64120_H
-
-/*
- * This is the CPU physical memory map of PPMC Board:
- *
- *    0x00000000-0x03FFFFFF	 - 64MB SDRAM (SCS[0]#)
- *    0x1C000000-0x1C000000	 - LED (CS0)
- *    0x1C800000-0x1C800007	 - UART 16550 port (CS1)
- *    0x1F000000-0x1F000000	 - MailBox (CS3)
- *    0x1FC00000-0x20000000	 - 4MB Flash (BOOT CS)
- */
-
-#define WRPPMC_SDRAM_SCS0_BASE	0x00000000
-#define WRPPMC_SDRAM_SCS0_SIZE	0x04000000
-
-#define WRPPMC_UART16550_BASE	0x1C800000
-#define WRPPMC_UART16550_CLOCK	3686400 /* 3.68MHZ */
-
-#define WRPPMC_LED_BASE		0x1C000000
-#define WRPPMC_MBOX_BASE	0x1F000000
-
-#define WRPPMC_BOOTROM_BASE	0x1FC00000
-#define WRPPMC_BOOTROM_SIZE	0x00400000 /* 4M Flash */
-
-#define WRPPMC_MIPS_TIMER_IRQ	7 /* MIPS compare/count timer interrupt */
-#define WRPPMC_UART16550_IRQ	6
-#define WRPPMC_PCI_INTA_IRQ	3
-
-/*
- * PCI Bus I/O and Memory resources allocation
- *
- * NOTE: We only have PCI_0 hose interface
- */
-#define GT_PCI_MEM_BASE 0x13000000UL
-#define GT_PCI_MEM_SIZE 0x02000000UL
-#define GT_PCI_IO_BASE	0x11000000UL
-#define GT_PCI_IO_SIZE	0x02000000UL
-
-/*
- * PCI interrupts will come in on either the INTA or INTD interrupt lines,
- * which are mapped to the #2 and #5 interrupt pins of the MIPS.  On our
- * boards, they all either come in on IntD or they all come in on IntA, they
- * aren't mixed. There can be numerous PCI interrupts, so we keep a list of the
- * "requested" interrupt numbers and go through the list whenever we get an
- * IntA/D.
- *
- * Interrupts < 8 are directly wired to the processor; PCI INTA is 8 and
- * INTD is 11.
- */
-#define GT_TIMER	4
-#define GT_INTA		2
-#define GT_INTD		5
-
-#ifndef __ASSEMBLY__
-
-/*
- * GT64120 internal register space base address
- */
-extern unsigned long gt64120_base;
-
-#define GT64120_BASE	(gt64120_base)
-
-/* define WRPPMC_EARLY_DEBUG to enable early output something to UART */
-#undef WRPPMC_EARLY_DEBUG
-
-#ifdef WRPPMC_EARLY_DEBUG
-extern void wrppmc_led_on(int mask);
-extern void wrppmc_led_off(int mask);
-extern void wrppmc_early_printk(const char *fmt, ...);
-#else
-#define wrppmc_early_printk(fmt, ...) do {} while (0)
-#endif /* WRPPMC_EARLY_DEBUG */
-
-#endif /* __ASSEMBLY__ */
-#endif /* __ASM_MIPS_GT64120_H */
diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index fa3bcd2..b56fbc0 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -52,7 +52,6 @@ obj-$(CONFIG_TOSHIBA_RBTX4927)	+= fixup-rbtx4927.o
 obj-$(CONFIG_TOSHIBA_RBTX4938)	+= fixup-rbtx4938.o
 obj-$(CONFIG_VICTOR_MPC30X)	+= fixup-mpc30x.o
 obj-$(CONFIG_ZAO_CAPCELLA)	+= fixup-capcella.o
-obj-$(CONFIG_WR_PPMC)		+= fixup-wrppmc.o
 obj-$(CONFIG_MIKROTIK_RB532)	+= pci-rc32434.o ops-rc32434.o fixup-rc32434.o
 obj-$(CONFIG_CAVIUM_OCTEON_SOC) += pci-octeon.o pcie-octeon.o
 obj-$(CONFIG_CPU_XLR)		+= pci-xlr.o
diff --git a/arch/mips/pci/fixup-wrppmc.c b/arch/mips/pci/fixup-wrppmc.c
deleted file mode 100644
index 29737ed..0000000
--- a/arch/mips/pci/fixup-wrppmc.c
+++ /dev/null
@@ -1,37 +0,0 @@
-/*
- * fixup-wrppmc.c: PPMC board specific PCI fixup
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2006, Wind River Inc. Rongkai.zhan (rongkai.zhan@windriver.com)
- */
-#include <linux/init.h>
-#include <linux/pci.h>
-#include <asm/gt64120.h>
-
-/* PCI interrupt pins */
-#define PCI_INTA		1
-#define PCI_INTB		2
-#define PCI_INTC		3
-#define PCI_INTD		4
-
-#define PCI_SLOT_MAXNR	32 /* Each PCI bus has 32 physical slots */
-
-static char pci_irq_tab[PCI_SLOT_MAXNR][5] __initdata = {
-	/* 0	INTA   INTB   INTC   INTD */
-	[0] = {0, 0, 0, 0, 0},		/* Slot 0: GT64120 PCI bridge */
-	[6] = {0, WRPPMC_PCI_INTA_IRQ, 0, 0, 0},
-};
-
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
-{
-	return pci_irq_tab[slot][pin];
-}
-
-/* Do platform specific device initialization at pci_enable_device() time */
-int pcibios_plat_dev_init(struct pci_dev *dev)
-{
-	return 0;
-}
diff --git a/arch/mips/wrppmc/Makefile b/arch/mips/wrppmc/Makefile
deleted file mode 100644
index 307cc69..0000000
--- a/arch/mips/wrppmc/Makefile
+++ /dev/null
@@ -1,12 +0,0 @@
-#
-# This file is subject to the terms and conditions of the GNU General Public
-# License.  See the file "COPYING" in the main directory of this archive
-# for more details.
-#
-# Copyright 2006 Wind River System, Inc.
-# Author: Rongkai.Zhan <rongkai.zhan@windriver.com>
-#
-# Makefile for the Wind River MIPS 4Kc PPMC Eval Board
-#
-
-obj-y += irq.o pci.o reset.o serial.o setup.o time.o
diff --git a/arch/mips/wrppmc/Platform b/arch/mips/wrppmc/Platform
deleted file mode 100644
index dc78b25..0000000
--- a/arch/mips/wrppmc/Platform
+++ /dev/null
@@ -1,7 +0,0 @@
-#
-# Wind River PPMC Board (4KC + GT64120)
-#
-platform-$(CONFIG_WR_PPMC)	+= wrppmc/
-cflags-$(CONFIG_WR_PPMC)	+=					\
-		-I$(srctree)/arch/mips/include/asm/mach-wrppmc
-load-$(CONFIG_WR_PPMC)		+= 0xffffffff80100000
diff --git a/arch/mips/wrppmc/irq.c b/arch/mips/wrppmc/irq.c
deleted file mode 100644
index f237bf4..0000000
--- a/arch/mips/wrppmc/irq.c
+++ /dev/null
@@ -1,56 +0,0 @@
-/*
- * irq.c: GT64120 Interrupt Controller
- *
- * Copyright (C) 2006, Wind River System Inc.
- * Author: Rongkai.Zhan, <rongkai.zhan@windriver.com>
- *
- * This program is free software; you can redistribute	it and/or modify it
- * under  the terms of	the GNU General	 Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-#include <linux/hardirq.h>
-#include <linux/init.h>
-#include <linux/irq.h>
-
-#include <asm/gt64120.h>
-#include <asm/irq_cpu.h>
-#include <asm/mipsregs.h>
-
-asmlinkage void plat_irq_dispatch(void)
-{
-	unsigned int pending = read_c0_status() & read_c0_cause() & ST0_IM;
-
-	if (pending & STATUSF_IP7)
-		do_IRQ(WRPPMC_MIPS_TIMER_IRQ);	/* CPU Compare/Count internal timer */
-	else if (pending & STATUSF_IP6)
-		do_IRQ(WRPPMC_UART16550_IRQ);	/* UART 16550 port */
-	else if (pending & STATUSF_IP3)
-		do_IRQ(WRPPMC_PCI_INTA_IRQ);	/* PCI INT_A */
-	else
-		spurious_interrupt();
-}
-
-/**
- * Initialize GT64120 Interrupt Controller
- */
-void gt64120_init_pic(void)
-{
-	/* clear CPU Interrupt Cause Registers */
-	GT_WRITE(GT_INTRCAUSE_OFS, (0x1F << 21));
-	GT_WRITE(GT_HINTRCAUSE_OFS, 0x00);
-
-	/* Disable all interrupts from GT64120 bridge chip */
-	GT_WRITE(GT_INTRMASK_OFS, 0x00);
-	GT_WRITE(GT_HINTRMASK_OFS, 0x00);
-	GT_WRITE(GT_PCI0_ICMASK_OFS, 0x00);
-	GT_WRITE(GT_PCI0_HICMASK_OFS, 0x00);
-}
-
-void __init arch_init_irq(void)
-{
-	/* IRQ 0 - 7 are for MIPS common irq_cpu controller */
-	mips_cpu_irq_init();
-
-	gt64120_init_pic();
-}
diff --git a/arch/mips/wrppmc/pci.c b/arch/mips/wrppmc/pci.c
deleted file mode 100644
index 8b8a0e1..0000000
--- a/arch/mips/wrppmc/pci.c
+++ /dev/null
@@ -1,52 +0,0 @@
-/*
- * pci.c: GT64120 PCI support.
- *
- * Copyright (C) 2006, Wind River System Inc. Rongkai.Zhan <rongkai.zhan@windriver.com>
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-#include <linux/init.h>
-#include <linux/ioport.h>
-#include <linux/types.h>
-#include <linux/pci.h>
-
-#include <asm/gt64120.h>
-
-extern struct pci_ops gt64xxx_pci0_ops;
-
-static struct resource pci0_io_resource = {
-	.name  = "pci_0 io",
-	.start = GT_PCI_IO_BASE,
-	.end   = GT_PCI_IO_BASE + GT_PCI_IO_SIZE - 1,
-	.flags = IORESOURCE_IO,
-};
-
-static struct resource pci0_mem_resource = {
-	.name  = "pci_0 memory",
-	.start = GT_PCI_MEM_BASE,
-	.end   = GT_PCI_MEM_BASE + GT_PCI_MEM_SIZE - 1,
-	.flags = IORESOURCE_MEM,
-};
-
-static struct pci_controller hose_0 = {
-	.pci_ops	= &gt64xxx_pci0_ops,
-	.io_resource	= &pci0_io_resource,
-	.mem_resource	= &pci0_mem_resource,
-};
-
-static int __init gt64120_pci_init(void)
-{
-	(void) GT_READ(GT_PCI0_CMD_OFS);	/* Huh??? -- Ralf  */
-	(void) GT_READ(GT_PCI0_BARE_OFS);
-
-	/* reset the whole PCI I/O space range */
-	ioport_resource.start = GT_PCI_IO_BASE;
-	ioport_resource.end = GT_PCI_IO_BASE + GT_PCI_IO_SIZE - 1;
-
-	register_pci_controller(&hose_0);
-	return 0;
-}
-
-arch_initcall(gt64120_pci_init);
diff --git a/arch/mips/wrppmc/reset.c b/arch/mips/wrppmc/reset.c
deleted file mode 100644
index 80beb18..0000000
--- a/arch/mips/wrppmc/reset.c
+++ /dev/null
@@ -1,41 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 1997 Ralf Baechle
- */
-#include <linux/irqflags.h>
-#include <linux/kernel.h>
-
-#include <asm/cacheflush.h>
-#include <asm/idle.h>
-#include <asm/mipsregs.h>
-#include <asm/processor.h>
-
-void wrppmc_machine_restart(char *command)
-{
-	/*
-	 * Ouch, we're still alive ... This time we take the silver bullet ...
-	 * ... and find that we leave the hardware in a state in which the
-	 * kernel in the flush locks up somewhen during of after the PCI
-	 * detection stuff.
-	 */
-	local_irq_disable();
-	set_c0_status(ST0_BEV | ST0_ERL);
-	change_c0_config(CONF_CM_CMASK, CONF_CM_UNCACHED);
-	flush_cache_all();
-	write_c0_wired(0);
-	__asm__ __volatile__("jr\t%0"::"r"(0xbfc00000));
-}
-
-void wrppmc_machine_halt(void)
-{
-	local_irq_disable();
-
-	printk(KERN_NOTICE "You can safely turn off the power\n");
-	while (1) {
-		if (cpu_wait)
-			cpu_wait();
-	}
-}
diff --git a/arch/mips/wrppmc/serial.c b/arch/mips/wrppmc/serial.c
deleted file mode 100644
index 83f0f7d..0000000
--- a/arch/mips/wrppmc/serial.c
+++ /dev/null
@@ -1,80 +0,0 @@
-/*
- *  Registration of WRPPMC UART platform device.
- *
- *  Copyright (C) 2007	Yoichi Yuasa <yuasa@linux-mips.org>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
- */
-#include <linux/errno.h>
-#include <linux/init.h>
-#include <linux/ioport.h>
-#include <linux/platform_device.h>
-#include <linux/serial_8250.h>
-
-#include <asm/gt64120.h>
-
-static struct resource wrppmc_uart_resource[] __initdata = {
-	{
-		.start	= WRPPMC_UART16550_BASE,
-		.end	= WRPPMC_UART16550_BASE + 7,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= WRPPMC_UART16550_IRQ,
-		.end	= WRPPMC_UART16550_IRQ,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct plat_serial8250_port wrppmc_serial8250_port[] = {
-	{
-		.irq		= WRPPMC_UART16550_IRQ,
-		.uartclk	= WRPPMC_UART16550_CLOCK,
-		.iotype		= UPIO_MEM,
-		.flags		= UPF_IOREMAP | UPF_SKIP_TEST,
-		.mapbase	= WRPPMC_UART16550_BASE,
-	},
-	{},
-};
-
-static __init int wrppmc_uart_add(void)
-{
-	struct platform_device *pdev;
-	int retval;
-
-	pdev = platform_device_alloc("serial8250", -1);
-	if (!pdev)
-		return -ENOMEM;
-
-	pdev->id = PLAT8250_DEV_PLATFORM;
-	pdev->dev.platform_data = wrppmc_serial8250_port;
-
-	retval = platform_device_add_resources(pdev, wrppmc_uart_resource,
-					ARRAY_SIZE(wrppmc_uart_resource));
-	if (retval)
-		goto err_free_device;
-
-	retval = platform_device_add(pdev);
-	if (retval)
-		goto err_free_device;
-
-	return 0;
-
-err_free_device:
-	platform_device_put(pdev);
-
-	return retval;
-}
-device_initcall(wrppmc_uart_add);
diff --git a/arch/mips/wrppmc/setup.c b/arch/mips/wrppmc/setup.c
deleted file mode 100644
index ca65c84..0000000
--- a/arch/mips/wrppmc/setup.c
+++ /dev/null
@@ -1,128 +0,0 @@
-/*
- * setup.c: Setup pointers to hardware dependent routines.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 1996, 1997, 2004 by Ralf Baechle (ralf@linux-mips.org)
- * Copyright (C) 2006, Wind River System Inc. Rongkai.zhan <rongkai.zhan@windriver.com>
- */
-#include <linux/init.h>
-#include <linux/string.h>
-#include <linux/kernel.h>
-#include <linux/pm.h>
-
-#include <asm/io.h>
-#include <asm/bootinfo.h>
-#include <asm/reboot.h>
-#include <asm/time.h>
-#include <asm/gt64120.h>
-
-unsigned long gt64120_base = KSEG1ADDR(0x14000000);
-
-#ifdef WRPPMC_EARLY_DEBUG
-
-static volatile unsigned char * wrppmc_led = \
-	(volatile unsigned char *)KSEG1ADDR(WRPPMC_LED_BASE);
-
-/*
- * PPMC LED control register:
- * -) bit[0] controls DS1 LED (1 - OFF, 0 - ON)
- * -) bit[1] controls DS2 LED (1 - OFF, 0 - ON)
- * -) bit[2] controls DS4 LED (1 - OFF, 0 - ON)
- */
-void wrppmc_led_on(int mask)
-{
-	unsigned char value = *wrppmc_led;
-
-	value &= (0xF8 | mask);
-	*wrppmc_led = value;
-}
-
-/* If mask = 0, turn off all LEDs */
-void wrppmc_led_off(int mask)
-{
-	unsigned char value = *wrppmc_led;
-
-	value |= (0x7 & mask);
-	*wrppmc_led = value;
-}
-
-/*
- * We assume that bootloader has initialized UART16550 correctly
- */
-void __init wrppmc_early_putc(char ch)
-{
-	static volatile unsigned char *wrppmc_uart = \
-		(volatile unsigned char *)KSEG1ADDR(WRPPMC_UART16550_BASE);
-	unsigned char value;
-
-	/* Wait until Transmit-Holding-Register is empty */
-	while (1) {
-		value = *(wrppmc_uart + 5);
-		if (value & 0x20)
-			break;
-	}
-
-	*wrppmc_uart = ch;
-}
-
-void __init wrppmc_early_printk(const char *fmt, ...)
-{
-	static char pbuf[256] = {'\0', };
-	char *ch = pbuf;
-	va_list args;
-	unsigned int i;
-
-	memset(pbuf, 0, 256);
-	va_start(args, fmt);
-	i = vsprintf(pbuf, fmt, args);
-	va_end(args);
-
-	/* Print the string */
-	while (*ch != '\0') {
-		wrppmc_early_putc(*ch);
-		/* if print '\n', also print '\r' */
-		if (*ch++ == '\n')
-			wrppmc_early_putc('\r');
-	}
-}
-#endif /* WRPPMC_EARLY_DEBUG */
-
-void __init prom_free_prom_memory(void)
-{
-}
-
-void __init plat_mem_setup(void)
-{
-	extern void wrppmc_machine_restart(char *command);
-	extern void wrppmc_machine_halt(void);
-
-	_machine_restart = wrppmc_machine_restart;
-	_machine_halt	 = wrppmc_machine_halt;
-	pm_power_off	 = wrppmc_machine_halt;
-
-	/* This makes the operations of 'in/out[bwl]' to the
-	 * physical address ( < KSEG0) can work via KSEG1
-	 */
-	set_io_port_base(KSEG1);
-}
-
-const char *get_system_type(void)
-{
-	return "Wind River PPMC (GT64120)";
-}
-
-/*
- * Initializes basic routines and structures pointers, memory size (as
- * given by the bios and saves the command line.
- */
-void __init prom_init(void)
-{
-	add_memory_region(WRPPMC_SDRAM_SCS0_BASE, WRPPMC_SDRAM_SCS0_SIZE, BOOT_MEM_RAM);
-	add_memory_region(WRPPMC_BOOTROM_BASE, WRPPMC_BOOTROM_SIZE, BOOT_MEM_ROM_DATA);
-
-	wrppmc_early_printk("prom_init: GT64120 SDRAM Bank 0: 0x%x - 0x%08lx\n",
-			WRPPMC_SDRAM_SCS0_BASE, (WRPPMC_SDRAM_SCS0_BASE + WRPPMC_SDRAM_SCS0_SIZE));
-}
diff --git a/arch/mips/wrppmc/time.c b/arch/mips/wrppmc/time.c
deleted file mode 100644
index 668dbd5..0000000
--- a/arch/mips/wrppmc/time.c
+++ /dev/null
@@ -1,39 +0,0 @@
-/*
- * time.c: MIPS CPU Count/Compare timer hookup
- *
- * Author: Mark.Zhan, <rongkai.zhan@windriver.com>
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 1996, 1997, 2004 by Ralf Baechle (ralf@linux-mips.org)
- * Copyright (C) 2006, Wind River System Inc.
- */
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-
-#include <asm/gt64120.h>
-#include <asm/time.h>
-
-#define WRPPMC_CPU_CLK_FREQ 40000000 /* 40MHZ */
-
-/*
- * Estimate CPU frequency.  Sets mips_hpt_frequency as a side-effect
- *
- * NOTE: We disable all GT64120 timers, and use MIPS processor internal
- * timer as the source of kernel clock tick.
- */
-void __init plat_time_init(void)
-{
-	/* Disable GT64120 timers */
-	GT_WRITE(GT_TC_CONTROL_OFS, 0x00);
-	GT_WRITE(GT_TC0_OFS, 0x00);
-	GT_WRITE(GT_TC1_OFS, 0x00);
-	GT_WRITE(GT_TC2_OFS, 0x00);
-	GT_WRITE(GT_TC3_OFS, 0x00);
-
-	/* Use MIPS compare/count internal timer */
-	mips_hpt_frequency = WRPPMC_CPU_CLK_FREQ;
-}
-- 
1.8.1.2
