Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 May 2012 00:03:33 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:43454 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903565Ab2E3WDS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 May 2012 00:03:18 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SZqyz-00011s-FH; Wed, 30 May 2012 17:03:09 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>,
        Douglas Leung <douglas@mips.com>,
        Chris Dearman <chris@mips.com>
Subject: [PATCH v4,01/10] MIPS: Add core files for MIPS SEAD-3 development platform.
Date:   Wed, 30 May 2012 17:02:49 -0500
Message-Id: <1338415369-11286-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10
X-archive-position: 33491
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
 arch/mips/include/asm/mips-boards/sead3int.h       |   67 ++++
 arch/mips/mti-sead3/Makefile                       |   11 +
 arch/mips/mti-sead3/Platform                       |    7 +
 arch/mips/mti-sead3/sead3-console.c                |   46 +++
 arch/mips/mti-sead3/sead3-display.c                |   78 ++++
 arch/mips/mti-sead3/sead3-ehci.c                   |   47 +++
 arch/mips/mti-sead3/sead3-i2c-dev.c                |   34 ++
 arch/mips/mti-sead3/sead3-i2c-drv.c                |  405 ++++++++++++++++++++
 arch/mips/mti-sead3/sead3-i2c.c                    |   37 ++
 arch/mips/mti-sead3/sead3-init.c                   |  152 ++++++++
 arch/mips/mti-sead3/sead3-int.c                    |   86 +++++
 arch/mips/mti-sead3/sead3-lcd.c                    |   44 +++
 arch/mips/mti-sead3/sead3-leds.c                   |   83 ++++
 arch/mips/mti-sead3/sead3-memory.c                 |  133 +++++++
 arch/mips/mti-sead3/sead3-mtd.c                    |   55 +++
 arch/mips/mti-sead3/sead3-net.c                    |   51 +++
 arch/mips/mti-sead3/sead3-reset.c                  |   39 ++
 arch/mips/mti-sead3/sead3-serial.c                 |   45 +++
 arch/mips/mti-sead3/sead3-setup.c                  |   20 +
 arch/mips/mti-sead3/sead3-time.c                   |  117 ++++++
 24 files changed, 1715 insertions(+)
 create mode 100644 arch/mips/include/asm/mach-sead3/cpu-feature-overrides.h
 create mode 100644 arch/mips/include/asm/mach-sead3/irq.h
 create mode 100644 arch/mips/include/asm/mach-sead3/kernel-entry-init.h
 create mode 100644 arch/mips/include/asm/mach-sead3/war.h
 create mode 100644 arch/mips/include/asm/mips-boards/sead3int.h
 create mode 100644 arch/mips/mti-sead3/Makefile
 create mode 100644 arch/mips/mti-sead3/Platform
 create mode 100644 arch/mips/mti-sead3/sead3-console.c
 create mode 100644 arch/mips/mti-sead3/sead3-display.c
 create mode 100644 arch/mips/mti-sead3/sead3-ehci.c
 create mode 100644 arch/mips/mti-sead3/sead3-i2c-dev.c
 create mode 100644 arch/mips/mti-sead3/sead3-i2c-drv.c
 create mode 100644 arch/mips/mti-sead3/sead3-i2c.c
 create mode 100644 arch/mips/mti-sead3/sead3-init.c
 create mode 100644 arch/mips/mti-sead3/sead3-int.c
 create mode 100644 arch/mips/mti-sead3/sead3-lcd.c
 create mode 100644 arch/mips/mti-sead3/sead3-leds.c
 create mode 100644 arch/mips/mti-sead3/sead3-memory.c
 create mode 100644 arch/mips/mti-sead3/sead3-mtd.c
 create mode 100644 arch/mips/mti-sead3/sead3-net.c
 create mode 100644 arch/mips/mti-sead3/sead3-reset.c
 create mode 100644 arch/mips/mti-sead3/sead3-serial.c
 create mode 100644 arch/mips/mti-sead3/sead3-setup.c
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
index 0000000..ed0abb7
--- /dev/null
+++ b/arch/mips/mti-sead3/Makefile
@@ -0,0 +1,11 @@
+#
+# Copyright (C) 2012  MIPS Technologies, Inc.
+#
+obj-y				+= sead3-lcd.o sead3-display.o sead3-init.o \
+				   sead3-int.o sead3-mtd.o sead3-net.o \
+				   sead3-memory.o sead3-serial.o sead3-leds.o \
+				   sead3-reset.o sead3-setup.o sead3-time.o \
+				   sead3-i2c-dev.o sead3-i2c.o sead3-i2c-drv.o
+
+obj-$(CONFIG_EARLY_PRINTK)	+= sead3-console.o
+obj-$(CONFIG_USB_EHCI_HCD)	+= sead3-ehci.o
diff --git a/arch/mips/mti-sead3/Platform b/arch/mips/mti-sead3/Platform
new file mode 100644
index 0000000..3870924
--- /dev/null
+++ b/arch/mips/mti-sead3/Platform
@@ -0,0 +1,7 @@
+#
+# MIPS SEAD-3 board
+#
+platform-$(CONFIG_MIPS_SEAD3)	+= mti-sead3/
+cflags-$(CONFIG_MIPS_SEAD3)	+= -I$(srctree)/arch/mips/include/asm/mach-sead3
+load-$(CONFIG_MIPS_SEAD3)	+= 0xffffffff80100000
+all-$(CONFIG_MIPS_SEAD3)	:= $(COMPRESSION_FNAME).srec
diff --git a/arch/mips/mti-sead3/sead3-console.c b/arch/mips/mti-sead3/sead3-console.c
new file mode 100644
index 0000000..677ebb1
--- /dev/null
+++ b/arch/mips/mti-sead3/sead3-console.c
@@ -0,0 +1,46 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2010-2012  MIPS Technologies, Inc.
+ */
+#include <linux/init.h>
+#include <linux/console.h>
+#include <linux/serial_reg.h>
+#include <linux/io.h>
+
+#define SEAD_UART1_REGS_BASE    0xbf000800   /* ttyS1 = DB9 port */
+#define SEAD_UART0_REGS_BASE    0xbf000900   /* ttyS0 = USB port   */
+#define PORT(base_addr, offset) ((unsigned int __iomem *)(base_addr+(offset)*4))
+
+static char console_port = 1;
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
+void __init prom_init_early_console(char port)
+{
+	console_port = port;
+}
+
+int prom_putchar(char c)
+{
+	unsigned int base_addr;
+
+	base_addr = console_port ? SEAD_UART1_REGS_BASE : SEAD_UART0_REGS_BASE;
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
index 0000000..49e4c04
--- /dev/null
+++ b/arch/mips/mti-sead3/sead3-display.c
@@ -0,0 +1,78 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2010-2012  MIPS Technologies, Inc.
+ */
+#include <linux/timer.h>
+#include <linux/io.h>
+#include <asm/mips-boards/generic.h>
+#include <asm/fw/yamon/yamon.h>
+
+static unsigned int display_count;
+static unsigned int max_display_count;
+
+#define LCD_DISPLAY_POS_BASE		0x1f000400
+#define DISPLAY_LCDINSTRUCTION		(0*2)
+#define DISPLAY_LCDDATA			(1*2)
+#define DISPLAY_CPLDSTATUS		(2*2)
+#define DISPLAY_CPLDDATA		(3*2)
+#define LCD_SETDDRAM			0x80
+#define LCD_IR_BF			0x80
+
+const char display_string[] = "               LINUX ON SEAD3               ";
+
+static void scroll_display_message(unsigned long data);
+static DEFINE_TIMER(mips_scroll_timer, scroll_display_message, HZ, 0);
+
+static void lcd_wait(unsigned int __iomem *display)
+{
+	/* Wait for CPLD state machine to become idle. */
+	do { } while (__raw_readl(display + DISPLAY_CPLDSTATUS) & 1);
+
+	do {
+		__raw_readl(display + DISPLAY_LCDINSTRUCTION);
+
+		/* Wait for CPLD state machine to become idle. */
+		do { } while (__raw_readl(display + DISPLAY_CPLDSTATUS) & 1);
+	} while (__raw_readl(display + DISPLAY_CPLDDATA) & LCD_IR_BF);
+}
+
+static void mips_display_message(const char *str)
+{
+	static unsigned int __iomem *display;
+	char ch;
+	int i;
+
+	if (unlikely(display == NULL))
+		display = ioremap_nocache(LCD_DISPLAY_POS_BASE,
+			(8 * sizeof(int)));
+
+	for (i = 0; i < 16; i++) {
+		if (*str)
+			ch = *str++;
+		else
+			ch = ' ';
+		lcd_wait(display);
+		__raw_writel((LCD_SETDDRAM | i),
+			(display + DISPLAY_LCDINSTRUCTION));
+		lcd_wait(display);
+		__raw_writel(ch, display + DISPLAY_LCDDATA);
+	}
+}
+
+static void scroll_display_message(unsigned long data)
+{
+	mips_display_message(&display_string[display_count++]);
+	if (display_count == max_display_count)
+		display_count = 0;
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
index 0000000..e82044c
--- /dev/null
+++ b/arch/mips/mti-sead3/sead3-ehci.c
@@ -0,0 +1,47 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2009-2012  MIPS Technologies, Inc.
+ */
+#include <linux/module.h>
+#include <linux/irq.h>
+#include <linux/dma-mapping.h>
+#include <linux/platform_device.h>
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
index 0000000..e85197b
--- /dev/null
+++ b/arch/mips/mti-sead3/sead3-i2c-dev.c
@@ -0,0 +1,34 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2010-2012  MIPS Technologies, Inc.
+ */
+#include <linux/init.h>
+#include <linux/i2c.h>
+
+static struct i2c_board_info __initdata sead3_i2c_devices[] = {
+	{
+		I2C_BOARD_INFO("adt7476", 0x2c),
+		.irq = 0,
+	},
+	{
+		I2C_BOARD_INFO("m41t80", 0x68),
+		.irq = 0,
+	},
+};
+
+static int __init sead3_i2c_init(void)
+{
+	int err;
+
+	err = i2c_register_board_info(0, sead3_i2c_devices,
+					ARRAY_SIZE(sead3_i2c_devices));
+	if (err < 0)
+		printk(KERN_ERR
+			"sead3-i2c-dev: cannot register board I2C devices\n");
+	return err;
+}
+
+arch_initcall(sead3_i2c_init);
diff --git a/arch/mips/mti-sead3/sead3-i2c-drv.c b/arch/mips/mti-sead3/sead3-i2c-drv.c
new file mode 100644
index 0000000..2ac1e87
--- /dev/null
+++ b/arch/mips/mti-sead3/sead3-i2c-drv.c
@@ -0,0 +1,405 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2010-2012  MIPS Technologies, Inc.
+ */
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/platform_device.h>
+
+#define PIC32_I2CxCON		0x0000
+#define  PIC32_I2CCON_ON	(1<<15)
+#define  PIC32_I2CCON_ACKDT	(1<<5)
+#define  PIC32_I2CCON_ACKEN	(1<<4)
+#define  PIC32_I2CCON_RCEN	(1<<3)
+#define  PIC32_I2CCON_PEN	(1<<2)
+#define  PIC32_I2CCON_RSEN	(1<<1)
+#define  PIC32_I2CCON_SEN	(1<<0)
+#define PIC32_I2CxCONCLR	0x0004
+#define PIC32_I2CxCONSET	0x0008
+#define PIC32_I2CxSTAT		0x0010
+#define PIC32_I2CxSTATCLR	0x0014
+#define  PIC32_I2CSTAT_ACKSTAT	(1<<15)
+#define  PIC32_I2CSTAT_TRSTAT	(1<<14)
+#define  PIC32_I2CSTAT_BCL	(1<<10)
+#define  PIC32_I2CSTAT_IWCOL	(1<<7)
+#define  PIC32_I2CSTAT_I2COV	(1<<6)
+#define PIC32_I2CxBRG		0x0040
+#define PIC32_I2CxTRN		0x0050
+#define PIC32_I2CxRCV		0x0060
+
+static DEFINE_SPINLOCK(pic32_bus_lock);
+
+static void __iomem *bus_xfer   = (void __iomem *)0xbf000600;
+static void __iomem *bus_status = (void __iomem *)0xbf000060;
+
+#define DELAY()	udelay(100)
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
+		do {
+			(void) readl(bus_xfer);
+			DELAY();
+		} while (ioready());
+	}
+}
+
+static u32 pic32_bus_readl(u32 reg)
+{
+	unsigned long flags;
+	u32 status, val;
+
+	spin_lock_irqsave(&pic32_bus_lock, flags);
+
+	check_ioclear();
+	writel((0x01 << 24) | (reg & 0x00ffffff), bus_xfer);
+	DELAY();
+	wait_ioready();
+	status = readl(bus_xfer);
+	DELAY();
+	val = readl(bus_xfer);
+	wait_ioclear();
+
+	spin_unlock_irqrestore(&pic32_bus_lock, flags);
+
+	return val;
+}
+
+static void pic32_bus_writel(u32 val, u32 reg)
+{
+	unsigned long flags;
+	u32 status;
+
+	spin_lock_irqsave(&pic32_bus_lock, flags);
+
+	check_ioclear();
+	writel((0x10 << 24) | (reg & 0x00ffffff), bus_xfer);
+	DELAY();
+	writel(val, bus_xfer);
+	DELAY();
+	wait_ioready();
+	status = readl(bus_xfer);
+	wait_ioclear();
+
+	spin_unlock_irqrestore(&pic32_bus_lock, flags);
+}
+
+struct pic32_i2c_platform_data {
+	u32	base;
+	struct i2c_adapter adap;
+	u32	xfer_timeout;
+	u32	ack_timeout;
+	u32	ctl_timeout;
+};
+
+static inline void pic32_i2c_start(struct pic32_i2c_platform_data *adap)
+{
+	pic32_bus_writel(PIC32_I2CCON_SEN, adap->base + PIC32_I2CxCONSET);
+}
+
+static inline void pic32_i2c_stop(struct pic32_i2c_platform_data *adap)
+{
+	pic32_bus_writel(PIC32_I2CCON_PEN, adap->base + PIC32_I2CxCONSET);
+}
+
+static inline void pic32_i2c_ack(struct pic32_i2c_platform_data *adap)
+{
+	pic32_bus_writel(PIC32_I2CCON_ACKDT, adap->base + PIC32_I2CxCONCLR);
+	pic32_bus_writel(PIC32_I2CCON_ACKEN, adap->base + PIC32_I2CxCONSET);
+}
+
+static inline void pic32_i2c_nack(struct pic32_i2c_platform_data *adap)
+{
+	pic32_bus_writel(PIC32_I2CCON_ACKDT, adap->base + PIC32_I2CxCONSET);
+	pic32_bus_writel(PIC32_I2CCON_ACKEN, adap->base + PIC32_I2CxCONSET);
+}
+
+static inline int pic32_i2c_idle(struct pic32_i2c_platform_data *adap)
+{
+	int i;
+
+	for (i = 0; i < adap->ctl_timeout; i++) {
+		if (((pic32_bus_readl(adap->base + PIC32_I2CxCON) &
+		      (PIC32_I2CCON_ACKEN | PIC32_I2CCON_RCEN |
+		       PIC32_I2CCON_PEN | PIC32_I2CCON_RSEN |
+		       PIC32_I2CCON_SEN)) == 0) &&
+		    ((pic32_bus_readl(adap->base + PIC32_I2CxSTAT) &
+		      (PIC32_I2CSTAT_TRSTAT)) == 0))
+			return 0;
+		udelay(1);
+	}
+	return -ETIMEDOUT;
+}
+
+static inline u32 pic32_i2c_master_write(struct pic32_i2c_platform_data *adap,
+		u32 byte)
+{
+	pic32_bus_writel(byte, adap->base + PIC32_I2CxTRN);
+	return pic32_bus_readl(adap->base + PIC32_I2CxSTAT) &
+			PIC32_I2CSTAT_IWCOL;
+}
+
+static inline u32 pic32_i2c_master_read(struct pic32_i2c_platform_data *adap)
+{
+	pic32_bus_writel(PIC32_I2CCON_RCEN, adap->base + PIC32_I2CxCONSET);
+	while (pic32_bus_readl(adap->base + PIC32_I2CxCON) & PIC32_I2CCON_RCEN)
+		;
+	pic32_bus_writel(PIC32_I2CSTAT_I2COV, adap->base + PIC32_I2CxSTATCLR);
+	return pic32_bus_readl(adap->base + PIC32_I2CxRCV);
+}
+
+static int pic32_i2c_address(struct pic32_i2c_platform_data *adap,
+		unsigned int addr, int rd)
+{
+	pic32_i2c_idle(adap);
+	pic32_i2c_start(adap);
+	pic32_i2c_idle(adap);
+
+	addr <<= 1;
+	if (rd)
+		addr |= 1;
+
+	if (pic32_i2c_master_write(adap, addr))
+		return -EIO;
+	pic32_i2c_idle(adap);
+	if (pic32_bus_readl(adap->base + PIC32_I2CxSTAT) &
+			PIC32_I2CSTAT_ACKSTAT)
+		return -EIO;
+	return 0;
+}
+
+static int sead3_i2c_read(struct pic32_i2c_platform_data *adap,
+		unsigned char *buf, unsigned int len)
+{
+	u32 data;
+	int i;
+
+	i = 0;
+	while (i < len) {
+		data = pic32_i2c_master_read(adap);
+		buf[i++] = data;
+		if (i < len)
+			pic32_i2c_ack(adap);
+		else
+			pic32_i2c_nack(adap);
+	}
+
+	pic32_i2c_stop(adap);
+	pic32_i2c_idle(adap);
+	return 0;
+}
+
+static int sead3_i2c_write(struct pic32_i2c_platform_data *adap,
+		unsigned char *buf, unsigned int len)
+{
+	int i;
+	u32 data;
+
+	i = 0;
+	while (i < len) {
+		data = buf[i];
+		if (pic32_i2c_master_write(adap, data))
+			return -EIO;
+		pic32_i2c_idle(adap);
+		if (pic32_bus_readl(adap->base + PIC32_I2CxSTAT) &
+					PIC32_I2CSTAT_ACKSTAT)
+			return -EIO;
+		i++;
+	}
+
+	pic32_i2c_stop(adap);
+	pic32_i2c_idle(adap);
+	return 0;
+}
+
+static int sead3_pic32_platform_xfer(struct i2c_adapter *i2c_adap,
+		struct i2c_msg *msgs, int num)
+{
+	struct pic32_i2c_platform_data *adap = i2c_adap->algo_data;
+	struct i2c_msg *p;
+	int i, err = 0;
+
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
+	}
+
+	for (i = 0; !err && i < num; i++) {
+		p = &msgs[i];
+		err = pic32_i2c_address(adap, p->addr, p->flags & I2C_M_RD);
+		if (err || !p->len)
+			continue;
+		if (p->flags & I2C_M_RD)
+			err = sead3_i2c_read(adap, p->buf, p->len);
+		else
+			err = sead3_i2c_write(adap, p->buf, p->len);
+	}
+
+	/* Return the number of messages processed, or the error code. */
+	if (err == 0)
+		err = num;
+
+	return err;
+}
+
+static u32 sead3_pic32_platform_func(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
+}
+
+static const struct i2c_algorithm sead3_platform_algo = {
+	.master_xfer	= sead3_pic32_platform_xfer,
+	.functionality	= sead3_pic32_platform_func,
+};
+
+static void sead3_i2c_platform_setup(struct pic32_i2c_platform_data *priv)
+{
+	pic32_bus_writel(500, priv->base + PIC32_I2CxBRG);
+	pic32_bus_writel(PIC32_I2CCON_ON, priv->base + PIC32_I2CxCONCLR);
+	pic32_bus_writel(PIC32_I2CCON_ON, priv->base + PIC32_I2CxCONSET);
+	pic32_bus_writel(PIC32_I2CSTAT_BCL | PIC32_I2CSTAT_IWCOL,
+		priv->base + PIC32_I2CxSTATCLR);
+}
+
+static int __devinit sead3_i2c_platform_probe(struct platform_device *pdev)
+{
+	struct pic32_i2c_platform_data *priv;
+	struct resource *r;
+	int ret;
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	priv = kzalloc(sizeof(struct pic32_i2c_platform_data), GFP_KERNEL);
+	if (!priv) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	priv->base = r->start;
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
+	priv->adap.algo = &sead3_platform_algo;
+	priv->adap.algo_data = priv;
+	priv->adap.dev.parent = &pdev->dev;
+	strlcpy(priv->adap.name, "SEAD3 PIC32", sizeof(priv->adap.name));
+
+	sead3_i2c_platform_setup(priv);
+
+	ret = i2c_add_numbered_adapter(&priv->adap);
+	if (ret == 0) {
+		platform_set_drvdata(pdev, priv);
+		return 0;
+	}
+
+out_mem:
+	kfree(priv);
+out:
+	return ret;
+}
+
+static int __devexit sead3_i2c_platform_remove(struct platform_device *pdev)
+{
+	struct pic32_i2c_platform_data *priv = platform_get_drvdata(pdev);
+
+	platform_set_drvdata(pdev, NULL);
+	i2c_del_adapter(&priv->adap);
+	kfree(priv);
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int sead3_i2c_platform_suspend(struct platform_device *pdev,
+		pm_message_t state)
+{
+	dev_dbg(&pdev->dev, "i2c_platform_disable\n");
+	return 0;
+}
+
+static int sead3_i2c_platform_resume(struct platform_device *pdev)
+{
+	struct pic32_i2c_platform_data *priv = platform_get_drvdata(pdev);
+
+	dev_dbg(&pdev->dev, "sead3_i2c_platform_setup\n");
+	sead3_i2c_platform_setup(priv);
+
+	return 0;
+}
+#else
+#define sead3_i2c_platform_suspend	NULL
+#define sead3_i2c_platform_resume	NULL
+#endif
+
+static struct platform_driver sead3_i2c_platform_driver = {
+	.driver = {
+		.name	= "sead3-i2c",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= sead3_i2c_platform_probe,
+	.remove		= __devexit_p(sead3_i2c_platform_remove),
+	.suspend	= sead3_i2c_platform_suspend,
+	.resume		= sead3_i2c_platform_resume,
+};
+
+static int __init sead3_i2c_platform_init(void)
+{
+	return platform_driver_register(&sead3_i2c_platform_driver);
+}
+module_init(sead3_i2c_platform_init);
+
+static void __exit sead3_i2c_platform_exit(void)
+{
+	platform_driver_unregister(&sead3_i2c_platform_driver);
+}
+module_exit(sead3_i2c_platform_exit);
+
+MODULE_AUTHOR("Chris Dearman, MIPS Technologies INC.");
+MODULE_DESCRIPTION("SEAD3 PIC32 I2C driver");
+MODULE_LICENSE("GPL");
diff --git a/arch/mips/mti-sead3/sead3-i2c.c b/arch/mips/mti-sead3/sead3-i2c.c
new file mode 100644
index 0000000..bcc1f14
--- /dev/null
+++ b/arch/mips/mti-sead3/sead3-i2c.c
@@ -0,0 +1,37 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2010-2012  MIPS Technologies, Inc.
+ */
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <irq.h>
+
+struct resource sead3_i2c_resources[] = {
+	{
+		.start	= 0x805200,
+		.end	= 0x8053ff,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device sead3_i2c_device = {
+	.name		= "sead3-i2c",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(sead3_i2c_resources),
+	.resource	= sead3_i2c_resources,
+};
+
+static int __init sead3_i2c_init(void)
+{
+	return platform_device_register(&sead3_i2c_device);
+}
+
+module_init(sead3_i2c_init);
+
+MODULE_AUTHOR("Chris Dearman <chris@mips.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("I2C probe driver for SEAD3");
diff --git a/arch/mips/mti-sead3/sead3-init.c b/arch/mips/mti-sead3/sead3-init.c
new file mode 100644
index 0000000..52ea729
--- /dev/null
+++ b/arch/mips/mti-sead3/sead3-init.c
@@ -0,0 +1,152 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2010-2012  MIPS Technologies, Inc.
+ */
+#include <linux/init.h>
+#include <linux/io.h>
+
+#include <asm/bootinfo.h>
+#include <asm/cacheflush.h>
+#include <asm/traps.h>
+#include <asm/mips-boards/generic.h>
+#include <asm/fw/yamon/yamon.h>
+
+extern char except_vec_nmi;
+extern char except_vec_ejtag_debug;
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
+	}
+}
+#endif
+
+static void __init mips_nmi_setup(void)
+{
+	void *base;
+
+	base = cpu_has_veic ?
+		(void *)(CAC_BASE + 0xa80) :
+		(void *)(CAC_BASE + 0x380);
+#ifdef CONFIG_CPU_MICROMIPS
+	/*
+	 * Decrement the exception vector address by one for microMIPS.
+	 */
+	memcpy(base, (&except_vec_nmi - 1), 0x80);
+
+	/*
+	 * This is a hack. We do not know if the boot loader was built with
+	 * microMIPS instructions or not. If it was not, the NMI exception
+	 * code at 0x80000a80 will be taken in MIPS32 mode. The hand coded
+	 * assembly below forces us into microMIPS mode if we are a pure
+	 * microMIPS kernel. The assembly instructions are:
+	 *
+	 *  3C1A8000   lui       k0,0x8000
+	 *  375A0381   ori       k0,k0,0x381
+	 *  03400008   jr        k0
+	 *  00000000   nop
+	 *
+	 * The mode switch occurs by jumping to the unaligned exception
+	 * vector address at 0x80000381 which would have been 0x80000380
+	 * in MIPS32 mode. The jump to the unaligned address transitions
+	 * us into microMIPS mode.
+	 */
+	if (!cpu_has_veic) {
+		void *base2 = (void *)(CAC_BASE + 0xa80);
+		*((unsigned int *)base2) = 0x3c1a8000;
+		*((unsigned int *)base2 + 1) = 0x375a0381;
+		*((unsigned int *)base2 + 2) = 0x03400008;
+		*((unsigned int *)base2 + 3) = 0x00000000;
+		flush_icache_range((unsigned long)base2,
+			(unsigned long)base2 + 0x10);
+	}
+#else
+	memcpy(base, &except_vec_nmi, 0x80);
+#endif
+	flush_icache_range((unsigned long)base, (unsigned long)base + 0x80);
+}
+
+static void __init mips_ejtag_setup(void)
+{
+	void *base;
+
+	base = cpu_has_veic ?
+		(void *)(CAC_BASE + 0xa00) :
+		(void *)(CAC_BASE + 0x300);
+#ifdef CONFIG_CPU_MICROMIPS
+	/* Deja vu... */
+	memcpy(base, (&except_vec_ejtag_debug - 1), 0x80);
+	if (!cpu_has_veic) {
+		void *base2 = (void *)(CAC_BASE + 0xa00);
+		*((unsigned int *)base2) = 0x3c1a8000;
+		*((unsigned int *)base2 + 1) = 0x375a0301;
+		*((unsigned int *)base2 + 2) = 0x03400008;
+		*((unsigned int *)base2 + 3) = 0x00000000;
+		flush_icache_range((unsigned long)base2,
+			(unsigned long)base2 + 0x10);
+	}
+#else
+	memcpy(base, &except_vec_ejtag_debug, 0x80);
+#endif
+	flush_icache_range((unsigned long)base, (unsigned long)base + 0x80);
+}
+
+void __init prom_init(void)
+{
+	prom_argc = fw_arg0;
+	_prom_argv = (int *) fw_arg1;
+	_prom_envp = (int *) fw_arg2;
+
+	board_nmi_handler_setup = mips_nmi_setup;
+	board_ejtag_handler_setup = mips_ejtag_setup;
+
+	prom_init_cmdline();
+	prom_meminit();
+
+#ifdef CONFIG_EARLY_PRINTK
+	if ((strstr(prom_getcmdline(), "console=ttyS0")) != NULL)
+		prom_init_early_console(0);
+	else if ((strstr(prom_getcmdline(), "console=ttyS1")) != NULL)
+		prom_init_early_console(1);
+#endif
+#ifdef CONFIG_SERIAL_8250_CONSOLE
+	console_config();
+#endif
+}
diff --git a/arch/mips/mti-sead3/sead3-int.c b/arch/mips/mti-sead3/sead3-int.c
new file mode 100644
index 0000000..99a6098
--- /dev/null
+++ b/arch/mips/mti-sead3/sead3-int.c
@@ -0,0 +1,86 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2010-2012  MIPS Technologies, Inc.
+ */
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/io.h>
+
+#include <asm/setup.h>
+#include <asm/irq_cpu.h>
+#include <asm/gic.h>
+#include <asm/mips-boards/sead3int.h>
+
+#define SEAD_CONFIG_GIC_PRESENT_SHF	1
+#define SEAD_CONFIG_GIC_PRESENT_MSK	(1 << SEAD_CONFIG_GIC_PRESENT_SHF)
+#define SEAD_CONFIG_BASE		0x1b100110
+#define SEAD_CONFIG_SIZE		4
+
+int gic_present;
+static unsigned long sead3_config_reg;
+
+/*
+ * This table defines the setup for each external GIC interrupt. It is
+ * indexed by interrupt number.
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
+};
+
+asmlinkage void plat_irq_dispatch(void)
+{
+	unsigned int pending = read_c0_cause() & read_c0_status() & ST0_IM;
+	int irq;
+
+	irq = (fls(pending) - CAUSEB_IP - 1);
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
+	sead3_config_reg = (unsigned long)ioremap_nocache(SEAD_CONFIG_BASE,
+		SEAD_CONFIG_SIZE);
+	gic_present = (REG32(sead3_config_reg) & SEAD_CONFIG_GIC_PRESENT_MSK) >>
+		SEAD_CONFIG_GIC_PRESENT_SHF;
+	printk(KERN_INFO "GIC: %spresent\n", (gic_present) ? "" : "not ");
+	printk(KERN_INFO "EIC: %s\n",
+		(current_cpu_data.options & MIPS_CPU_VEIC) ?  "on" : "off");
+
+	if (gic_present)
+		gic_init(GIC_BASE_ADDR, GIC_ADDRSPACE_SZ, gic_intr_map,
+			ARRAY_SIZE(gic_intr_map), MIPS_GIC_IRQ_BASE);
+}
diff --git a/arch/mips/mti-sead3/sead3-lcd.c b/arch/mips/mti-sead3/sead3-lcd.c
new file mode 100644
index 0000000..da5f776
--- /dev/null
+++ b/arch/mips/mti-sead3/sead3-lcd.c
@@ -0,0 +1,44 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2010  Chris Dearman <chris@mips.com>
+ * Copyright (C) 2012  MIPS Technologies, Inc.
+ */
+#include <linux/init.h>
+#include <linux/platform_device.h>
+
+static struct resource __initdata sead3_lcd_resource = {
+		.start	= 0x1f000400,
+		.end	= 0x1f00041f,
+		.flags	= IORESOURCE_MEM,
+};
+
+static __init int sead3_lcd_add(void)
+{
+	struct platform_device *pdev;
+	int retval;
+
+	/* SEAD-3 and Cobalt platforms use same display type. */
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
+
+device_initcall(sead3_lcd_add);
diff --git a/arch/mips/mti-sead3/sead3-leds.c b/arch/mips/mti-sead3/sead3-leds.c
new file mode 100644
index 0000000..358819b
--- /dev/null
+++ b/arch/mips/mti-sead3/sead3-leds.c
@@ -0,0 +1,83 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2009-2012  MIPS Technologies, Inc.
+ */
+#include <linux/module.h>
+#include <linux/leds.h>
+#include <linux/platform_device.h>
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
+		.start	= 0x1f000210,
+		.end	= 0x1f000217,
+		.flags	= IORESOURCE_MEM
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
+		.start			= 0x1f000218,
+		.end			= 0x1f00021f,
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
+MODULE_DESCRIPTION("LED probe driver for SEAD-3");
diff --git a/arch/mips/mti-sead3/sead3-memory.c b/arch/mips/mti-sead3/sead3-memory.c
new file mode 100644
index 0000000..47fca7b
--- /dev/null
+++ b/arch/mips/mti-sead3/sead3-memory.c
@@ -0,0 +1,133 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2010-2012  MIPS Technologies, Inc.
+ */
+#include <linux/bootmem.h>
+
+#include <asm/bootinfo.h>
+#include <asm/sections.h>
+#include <asm/fw/yamon/yamon.h>
+
+static struct prom_pmemblock mdesc[PROM_MAX_PMEMBLOCKS];
+
+/* determined physical memory size, not overridden by command line args  */
+unsigned long physical_memsize = 0L;
+
+struct prom_pmemblock * __init prom_getmdesc(void)
+{
+	char *memsize_str, *ptr;
+	unsigned int memsize;
+	static char cmdline[COMMAND_LINE_SIZE] __initdata;
+	long val;
+	int tmp;
+
+	/* otherwise look in the environment */
+	memsize_str = prom_getenv("memsize");
+	if (!memsize_str) {
+		printk(KERN_WARNING
+		       "memsize not set in boot prom, set to default (32Mb)\n");
+		physical_memsize = 0x02000000;
+	} else {
+		tmp = kstrtol(memsize_str, 0, &val);
+		physical_memsize = (unsigned long)val;
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
+	mdesc[3].size = CPHYSADDR(PFN_ALIGN((unsigned long)&_end)) -
+		mdesc[3].base;
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
+		p++;
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
index 0000000..c7b1e70
--- /dev/null
+++ b/arch/mips/mti-sead3/sead3-mtd.c
@@ -0,0 +1,55 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2006  Ralf Baechle <ralf@linux-mips.org>
+ * Copyright (C) 2012  MIPS Technologies, Inc.
+ */
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/mtd/physmap.h>
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
index 0000000..b3ab9cc
--- /dev/null
+++ b/arch/mips/mti-sead3/sead3-net.c
@@ -0,0 +1,51 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2010-2012  MIPS Technologies, Inc.
+ */
+#include <linux/module.h>
+#include <linux/irq.h>
+#include <linux/platform_device.h>
+#include <linux/smsc911x.h>
+
+static struct smsc911x_platform_config sead3_smsc911x_data = {
+	.irq_polarity = SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
+	.irq_type = SMSC911X_IRQ_TYPE_PUSH_PULL,
+	.flags	= SMSC911X_USE_32BIT | SMSC911X_SAVE_MAC_ADDRESS,
+	.phy_interface = PHY_INTERFACE_MODE_MII,
+};
+
+struct resource sead3_net_resourcess[] = {
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
+static struct platform_device sead3_net_device = {
+	.name			= "smsc911x",
+	.id			= 0,
+	.dev			= {
+		.platform_data	= &sead3_smsc911x_data,
+	},
+	.num_resources		= ARRAY_SIZE(sead3_net_resourcess),
+	.resource		= sead3_net_resourcess
+};
+
+static int __init sead3_net_init(void)
+{
+	return platform_device_register(&sead3_net_device);
+}
+
+module_init(sead3_net_init);
+
+MODULE_AUTHOR("Chris Dearman <chris@mips.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Network probe driver for SEAD-3");
diff --git a/arch/mips/mti-sead3/sead3-reset.c b/arch/mips/mti-sead3/sead3-reset.c
new file mode 100644
index 0000000..5bcbc68
--- /dev/null
+++ b/arch/mips/mti-sead3/sead3-reset.c
@@ -0,0 +1,39 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2012  MIPS Technologies, Inc.
+ */
+#include <linux/io.h>
+#include <linux/pm.h>
+
+#include <asm/reboot.h>
+#include <asm/mips-boards/generic.h>
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
diff --git a/arch/mips/mti-sead3/sead3-serial.c b/arch/mips/mti-sead3/sead3-serial.c
new file mode 100644
index 0000000..f038ccd
--- /dev/null
+++ b/arch/mips/mti-sead3/sead3-serial.c
@@ -0,0 +1,45 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2010-2012  MIPS Technologies, Inc.
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
+	.id			= PLAT8250_DEV_PLATFORM,
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
+MODULE_DESCRIPTION("8250 UART probe driver for the SEAD-3 platform");
diff --git a/arch/mips/mti-sead3/sead3-setup.c b/arch/mips/mti-sead3/sead3-setup.c
new file mode 100644
index 0000000..e19e929
--- /dev/null
+++ b/arch/mips/mti-sead3/sead3-setup.c
@@ -0,0 +1,20 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2012  MIPS Technologies, Inc.
+ */
+#include <linux/init.h>
+
+int coherentio;		/* 0 => no DMA cache coherency (may be set by user) */
+int hw_coherentio;	/* 0 => no HW DMA cache coherency (reflects real HW) */
+
+const char *get_system_type(void)
+{
+	return "MIPS SEAD3";
+}
+
+void __init plat_mem_setup(void)
+{
+}
diff --git a/arch/mips/mti-sead3/sead3-time.c b/arch/mips/mti-sead3/sead3-time.c
new file mode 100644
index 0000000..f3f476d
--- /dev/null
+++ b/arch/mips/mti-sead3/sead3-time.c
@@ -0,0 +1,117 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2010-2012  MIPS Technologies, Inc.
+ */
+#include <linux/init.h>
+
+#include <asm/setup.h>
+#include <asm/time.h>
+#include <asm/irq.h>
+#include <asm/mips-boards/generic.h>
+#include <asm/fw/yamon/yamon.h>
+
+unsigned long cpu_khz;
+
+static int mips_cpu_timer_irq;
+static int mips_cpu_perf_irq;
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
+static void __iomem *status_reg = (void __iomem *)0xbf000410;
+
+/*
+ * Estimate CPU frequency.  Sets mips_hpt_frequency as a side-effect.
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
+	ts->tv_sec = 0;
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
+	printk(KERN_DEBUG "CPU frequency %d.%02d MHz\n", (est_freq / 1000000),
+	       (est_freq % 1000000) * 100 / 1000000);
+
+	cpu_khz = est_freq / 1000;
+
+	mips_scroll_message();
+
+	plat_perf_setup();
+}
-- 
1.7.10
