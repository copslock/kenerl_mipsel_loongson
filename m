Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Aug 2006 15:00:07 +0100 (BST)
Received: from mo32.po.2iij.net ([210.128.50.17]:8994 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20038731AbWHVN6s (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 22 Aug 2006 14:58:48 +0100
Received: by mo.po.2iij.net (mo32) id k7MDwjt5037044; Tue, 22 Aug 2006 22:58:45 +0900 (JST)
Received: from localhost.localdomain (191.28.30.125.dy.iij4u.or.jp [125.30.28.191])
	by mbox.po.2iij.net (mbox33) id k7MDwhJN012197
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 22 Aug 2006 22:58:44 +0900 (JST)
Date:	Tue, 22 Aug 2006 22:40:48 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 4/12] added new common timer routines for GT64111/GT64120
Message-Id: <20060822224048.0664ad5f.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12400
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has added new common timer routines for GT64111/GT64120.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/Kconfig mips/arch/mips/Kconfig
--- mips-orig/arch/mips/Kconfig	2006-08-18 23:18:55.852396000 +0900
+++ mips/arch/mips/Kconfig	2006-08-18 23:19:19.769890750 +0900
@@ -1024,22 +1024,32 @@ config EMMA2RH
 #
 choice
 	prompt "Galileo Chip Clock"
-	#default SYSCLK_83 if MIPS_EV64120
-	depends on MIPS_EV64120 || MOMENCO_OCELOT || MOMENCO_OCELOT_G
+	depends on MIPS_COBALT || MIPS_EV64120 || MOMENCO_OCELOT || MOMENCO_OCELOT_G
+	default SYSCLK_50 if MIPS_COBALT
 	default SYSCLK_83 if MIPS_EV64120
 	default SYSCLK_100 if MOMENCO_OCELOT || MOMENCO_OCELOT_G
 
+config SYSCLK_50
+	bool "50MHz" if MIPS_COBALT
+
 config SYSCLK_75
-	bool "75" if MIPS_EV64120
+	bool "75MHz" if MIPS_EV64120
 
 config SYSCLK_83
-	bool "83.3" if MIPS_EV64120
+	bool "83.3MHz" if MIPS_EV64120
 
 config SYSCLK_100
-	bool "100" if MIPS_EV64120 || MOMENCO_OCELOT || MOMENCO_OCELOT_G
+	bool "100MHz" if MIPS_EV64120 || MOMENCO_OCELOT || MOMENCO_OCELOT_G
 
 endchoice
 
+config SYSCLK 
+	int
+	default 50000000 if SYSCLK_50
+	default 75000000 if SYSCLK_70
+	default 83333000 if SYSCLK_83
+	default 100000000 if SYSCLK_100
+
 config ARC32
 	bool
 
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/Makefile mips/arch/mips/Makefile
--- mips-orig/arch/mips/Makefile	2006-08-18 23:18:55.856396250 +0900
+++ mips/arch/mips/Makefile	2006-08-18 23:19:19.769890750 +0900
@@ -271,11 +271,13 @@ libs-$(CONFIG_MACH_DECSTATION)	+= arch/m
 load-$(CONFIG_MACH_DECSTATION)	+= 0xffffffff80040000
 CLEAN_FILES			+= drivers/tc/lk201-map.c
 
+
+core-$(CONFIG_MIPS_GT64120)	+= arch/mips/gt64120/common/
+
 #
 # Galileo EV64120 Board
 #
 core-$(CONFIG_MIPS_EV64120)	+= arch/mips/gt64120/ev64120/
-core-$(CONFIG_MIPS_EV64120)	+= arch/mips/gt64120/common/
 cflags-$(CONFIG_MIPS_EV64120)	+= -Iinclude/asm-mips/mach-ev64120
 load-$(CONFIG_MIPS_EV64120)	+= 0xffffffff80100000
 
@@ -345,8 +347,7 @@ load-$(CONFIG_MIPS_SIM)		+= 0x80100000
 # The Ocelot setup.o must be linked early - it does the ioremap() for the
 # mips_io_port_base.
 #
-core-$(CONFIG_MOMENCO_OCELOT)	+= arch/mips/gt64120/common/ \
-				   arch/mips/gt64120/momenco_ocelot/
+core-$(CONFIG_MOMENCO_OCELOT)	+= arch/mips/gt64120/momenco_ocelot/
 cflags-$(CONFIG_MOMENCO_OCELOT)	+= -Iinclude/asm-mips/mach-ocelot
 load-$(CONFIG_MOMENCO_OCELOT)	+= 0xffffffff80100000
 
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/gt64120/cobalt/irq.c mips/arch/mips/gt64120/cobalt/irq.c
--- mips-orig/arch/mips/gt64120/cobalt/irq.c	2006-08-18 23:18:55.856396250 +0900
+++ mips/arch/mips/gt64120/cobalt/irq.c	2006-08-18 23:19:19.769890750 +0900
@@ -18,7 +18,7 @@
 #include <asm/gt64120.h>
 #include <asm/ptrace.h>
 
-#include <asm/mach-cobalt/cobalt.h>
+#include <cobalt.h>
 
 /*
  * We have two types of interrupts that we handle, ones that come in through
@@ -49,9 +49,9 @@ static inline void galileo_irq(struct pt
 	mask = GT_READ(GT_INTRMASK_OFS);
 	pending = GT_READ(GT_INTRCAUSE_OFS) & mask;
 
-	if (pending & GALILEO_INTR_T0EXP) {
+	if (pending & GALILEO_INTR_T3EXP) {
 
-		GT_WRITE(GT_INTRCAUSE_OFS, ~GALILEO_INTR_T0EXP);
+		GT_WRITE(GT_INTRCAUSE_OFS, ~GALILEO_INTR_T3EXP);
 		do_IRQ(COBALT_GALILEO_IRQ, regs);
 
 	} else if (pending & GALILEO_INTR_RETRY_CTR) {
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/gt64120/cobalt/setup.c mips/arch/mips/gt64120/cobalt/setup.c
--- mips-orig/arch/mips/gt64120/cobalt/setup.c	2006-08-18 23:18:55.860396500 +0900
+++ mips/arch/mips/gt64120/cobalt/setup.c	2006-08-18 23:19:19.773891000 +0900
@@ -25,7 +25,7 @@
 #include <asm/gt64120.h>
 #include <asm/serial.h>
 
-#include <asm/mach-cobalt/cobalt.h>
+#include <cobalt.h>
 
 extern void cobalt_machine_restart(char *command);
 extern void cobalt_machine_halt(void);
@@ -51,17 +51,8 @@ const char *get_system_type(void)
 
 void __init plat_timer_setup(struct irqaction *irq)
 {
-	/* Load timer value for 1KHz (TCLK is 50MHz) */
-	GT_WRITE(GT_TC0_OFS, 50*1000*1000 / 1000);
-
-	/* Enable timer */
-	GT_WRITE(GT_TC_CONTROL_OFS, GALILEO_ENTC0 | GALILEO_SELTC0);
-
 	/* Register interrupt */
 	setup_irq(COBALT_GALILEO_IRQ, irq);
-
-	/* Enable interrupt */
-	GT_WRITE(GT_INTRMASK_OFS, GALILEO_INTR_T0EXP | GT_READ(GT_INTRMASK_OFS));
 }
 
 extern struct pci_ops gt64120_pci_ops;
@@ -129,6 +120,9 @@ void __init plat_mem_setup(void)
 	_machine_halt = cobalt_machine_halt;
 	pm_power_off = cobalt_machine_power_off;
 
+	gt641xx_disable_alltimers();
+	board_time_init = gt641xx_timer3_init;
+
         set_io_port_base(CKSEG1ADDR(GT_DEF_PCI0_IO_BASE));
 
 	/* I/O port resource must include UART and LCD/buttons */
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/gt64120/common/Makefile mips/arch/mips/gt64120/common/Makefile
--- mips-orig/arch/mips/gt64120/common/Makefile	2006-08-18 23:16:20.214669250 +0900
+++ mips/arch/mips/gt64120/common/Makefile	2006-08-18 23:19:19.773891000 +0900
@@ -2,4 +2,4 @@
 # Makefile for common code of gt64120-based boards.
 #
 
-obj-y	 		+= time.o
+obj-y	+= time.o
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/gt64120/common/time.c mips/arch/mips/gt64120/common/time.c
--- mips-orig/arch/mips/gt64120/common/time.c	2006-08-18 23:16:20.214669250 +0900
+++ mips/arch/mips/gt64120/common/time.c	2006-08-18 23:19:19.773891000 +0900
@@ -1,99 +1,50 @@
 /*
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
+ *  Common timer routines for Galileo GT64111/GT64120
  *
- * Galileo Technology chip interrupt handler
+ *  Copyright (C) 2006  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
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
+ *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
  */
-#include <linux/interrupt.h>
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/kernel_stat.h>
-#include <asm/ptrace.h>
 #include <asm/gt64120.h>
+#include <asm/time.h>
 
-/*
- * These are interrupt handlers for the GT on-chip interrupts.  They all come
- * in to the MIPS on a single interrupt line, and have to be handled and ack'ed
- * differently than other MIPS interrupts.
- */
+static void gt641xx_hpt_init(unsigned int count)
+{
+}
 
-static void gt64120_irq(int irq, void *dev_id, struct pt_regs *regs)
+static unsigned int gt641xx_hpt_read(void)
 {
-	unsigned int irq_src, int_high_src, irq_src_mask, int_high_src_mask;
-	int handled = 0;
+	return 0;
+}
 
-	irq_src = GT_READ(GT_INTRCAUSE_OFS);
-	irq_src_mask = GT_READ(GT_INTRMASK_OFS);
-	int_high_src = GT_READ(GT_HINTRCAUSE_OFS);
-	int_high_src_mask = GT_READ(GT_HINTRMASK_OFS);
-	irq_src = irq_src & irq_src_mask;
-	int_high_src = int_high_src & int_high_src_mask;
-
-	if (irq_src & 0x00000800) {	/* Check for timer interrupt */
-		handled = 1;
-		irq_src &= ~0x00000800;
-		do_timer(regs);
-#ifndef CONFIG_SMP
-		update_process_times(user_mode(regs));
-#endif
-	}
+void __init gt641xx_timer3_init(void)
+{
+	GT_WRITE(GT_TC3_OFS, GT641XX_SYSCLK / HZ);
 
-	GT_WRITE(GT_INTRCAUSE_OFS, 0);
-	GT_WRITE(GT_HINTRCAUSE_OFS, 0);
-}
+	GT_WRITE(GT_TC_CONTROL_OFS, GT_TC_CONTROL_SELTC3_BIT | GT_TC_CONTROL_ENTC3_BIT);
 
-/*
- * Initializes timer using galileo's built in timer.
- */
-#ifdef CONFIG_SYSCLK_100
-#define Sys_clock (100 * 1000000)	// 100 MHz
-#endif
-#ifdef CONFIG_SYSCLK_83
-#define Sys_clock (83.333 * 1000000)	// 83.333 MHz
-#endif
-#ifdef CONFIG_SYSCLK_75
-#define Sys_clock (75 * 1000000)	// 75 MHz
-#endif
+	mips_hpt_init = gt641xx_hpt_init;
+	mips_hpt_read = gt641xx_hpt_read;
+	mips_hpt_frequency = GT641XX_SYSCLK;
+}
 
-/*
- * This will ignore the standard MIPS timer interrupt handler that is passed in
- * as *irq (=irq0 in ../kernel/time.c).  We will do our own timer interrupt
- * handling.
- */
-void gt64120_time_init(void)
+void __init gt641xx_disable_alltimers(void)
 {
-	static struct irqaction timer;
-
-	/* Disable timer first */
 	GT_WRITE(GT_TC_CONTROL_OFS, 0);
-	/* Load timer value for 100 Hz */
-	GT_WRITE(GT_TC3_OFS, Sys_clock / 100);
-
-	/*
-	 * Create the IRQ structure entry for the timer.  Since we're too early
-	 * in the boot process to use the "request_irq()" call, we'll hard-code
-	 * the values to the correct interrupt line.
-	 */
-	timer.handler = gt64120_irq;
-	timer.flags = IRQF_SHARED | IRQF_DISABLED;
-	timer.name = "timer";
-	timer.dev_id = NULL;
-	timer.next = NULL;
-	timer.mask = CPU_MASK_NONE;
-	irq_desc[GT_TIMER].action = &timer;
-
-	enable_irq(GT_TIMER);
-
-	/* Enable timer ints */
-	GT_WRITE(GT_TC_CONTROL_OFS, 0xc0);
-	/* clear Cause register first */
-	GT_WRITE(GT_INTRCAUSE_OFS, 0x0);
-	/* Unmask timer int */
-	GT_WRITE(GT_INTRMASK_OFS, 0x800);
-	/* Clear High int register */
-	GT_WRITE(GT_HINTRCAUSE_OFS, 0x0);
-	/* Mask All interrupts at High cause interrupt */
-	GT_WRITE(GT_HINTRMASK_OFS, 0x0);
+	GT_WRITE(GT_TC0_OFS, 0);
+	GT_WRITE(GT_TC1_OFS, 0);
+	GT_WRITE(GT_TC2_OFS, 0);
+	GT_WRITE(GT_TC3_OFS, 0);
 }
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/gt64120/ev64120/setup.c mips/arch/mips/gt64120/ev64120/setup.c
--- mips-orig/arch/mips/gt64120/ev64120/setup.c	2006-08-18 23:16:20.218669500 +0900
+++ mips/arch/mips/gt64120/ev64120/setup.c	2006-08-18 23:19:19.773891000 +0900
@@ -69,15 +69,14 @@ unsigned long __init prom_free_prom_memo
  * Initializes basic routines and structures pointers, memory size (as
  * given by the bios and saves the command line.
  */
-extern void gt64120_time_init(void);
-
 void __init plat_mem_setup(void)
 {
 	_machine_restart = galileo_machine_restart;
 	_machine_halt = galileo_machine_halt;
 	pm_power_off = galileo_machine_power_off;
 
-	board_time_init = gt64120_time_init;
+	gt641xx_disable_alltimers();
+	board_time_init = gt641xx_timer3_init;
 	set_io_port_base(KSEG1);
 }
 
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/gt64120/momenco_ocelot/setup.c mips/arch/mips/gt64120/momenco_ocelot/setup.c
--- mips-orig/arch/mips/gt64120/momenco_ocelot/setup.c	2006-08-18 23:16:20.222669750 +0900
+++ mips/arch/mips/gt64120/momenco_ocelot/setup.c	2006-08-18 23:19:19.773891000 +0900
@@ -71,7 +71,6 @@ extern void momenco_ocelot_restart(char 
 extern void momenco_ocelot_halt(void);
 extern void momenco_ocelot_power_off(void);
 
-extern void gt64120_time_init(void);
 extern void momenco_ocelot_irq_setup(void);
 
 static char reset_reason;
@@ -157,7 +156,8 @@ void __init plat_mem_setup(void)
 	void (*l3func)(unsigned long)=KSEG1ADDR(&setup_l3cache);
 	unsigned int tmpword;
 
-	board_time_init = gt64120_time_init;
+	gt641xx_disable_alltimers();
+	board_time_init = gt641xx_timer3_init;
 
 	_machine_restart = momenco_ocelot_restart;
 	_machine_halt = momenco_ocelot_halt;
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/gt64120/wrppmc/time.c mips/arch/mips/gt64120/wrppmc/time.c
--- mips-orig/arch/mips/gt64120/wrppmc/time.c	2006-08-18 23:16:20.222669750 +0900
+++ mips/arch/mips/gt64120/wrppmc/time.c	2006-08-18 23:19:19.777891250 +0900
@@ -41,11 +41,7 @@ void __init plat_timer_setup(struct irqa
 void __init wrppmc_time_init(void)
 {
 	/* Disable GT64120 timers */
-	GT_WRITE(GT_TC_CONTROL_OFS, 0x00);
-	GT_WRITE(GT_TC0_OFS, 0x00);
-	GT_WRITE(GT_TC1_OFS, 0x00);
-	GT_WRITE(GT_TC2_OFS, 0x00);
-	GT_WRITE(GT_TC3_OFS, 0x00);
+	gt641xx_disable_alltimers();
 
 	/* Use MIPS compare/count internal timer */
 	mips_hpt_frequency = WRPPMC_CPU_CLK_FREQ;
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c mips/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
--- mips-orig/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c	2006-08-18 23:16:20.438683250 +0900
+++ mips/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c	2006-08-18 23:19:19.777891250 +0900
@@ -134,7 +134,6 @@ extern void toshiba_rbtx4927_power_off(v
 
 int tx4927_using_backplane = 0;
 
-extern void gt64120_time_init(void);
 extern void toshiba_rbtx4927_irq_setup(void);
 
 #ifdef CONFIG_PCI
diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/gt64120.h mips/include/asm-mips/gt64120.h
--- mips-orig/include/asm-mips/gt64120.h	2006-08-18 23:16:27.699137000 +0900
+++ mips/include/asm-mips/gt64120.h	2006-08-18 23:19:19.777891250 +0900
@@ -24,6 +24,12 @@
 #include <asm/addrspace.h>
 #include <asm/byteorder.h>
 
+#ifdef CONFIG_SYSCLK
+#define GT641XX_SYSCLK		CONFIG_SYSCLK
+#else
+#define GT641XX_SYSCLK		0
+#endif
+
 #define MSK(n)			((1 << (n)) - 1)
 
 /*
@@ -452,6 +458,15 @@
 #define GT_SDRAM_OPMODE_OP_CBR		4
 
 
+#define GT_TC_CONTROL_ENTC3_SHF		6
+#define GT_TC_CONTROL_ENTC3_MSK		(MSK(1) << GT_TC_CONTROL_ENTC3_SHF)
+#define GT_TC_CONTROL_ENTC3_BIT		GT_TC_CONTROL_ENTC3_MSK
+
+#define GT_TC_CONTROL_SELTC3_SHF	7
+#define GT_TC_CONTROL_SELTC3_MSK	(MSK(1) << GT_TC_CONTROL_SELTC3_SHF)
+#define GT_TC_CONTROL_SELTC3_BIT	GT_TC_CONTROL_SELTC3_MSK
+
+
 #define GT_PCI0_BARE_SWSCS3BOOTDIS_SHF	0
 #define GT_PCI0_BARE_SWSCS3BOOTDIS_MSK	(MSK(1) << GT_PCI0_BARE_SWSCS3BOOTDIS_SHF)
 #define GT_PCI0_BARE_SWSCS3BOOTDIS_BIT	GT_PCI0_BARE_SWSCS3BOOTDIS_MSK
@@ -558,4 +573,7 @@
 #define GT_READ(ofs)		le32_to_cpu(__GT_READ(ofs))
 #define GT_WRITE(ofs, data)	__GT_WRITE(ofs, cpu_to_le32(data))
 
+extern void gt641xx_timer3_init(void);
+extern void gt641xx_disable_alltimers(void);
+
 #endif /* _ASM_GT64120_H */
diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/mach-cobalt/cobalt.h mips/include/asm-mips/mach-cobalt/cobalt.h
--- mips-orig/include/asm-mips/mach-cobalt/cobalt.h	2006-08-18 23:18:55.828394500 +0900
+++ mips/include/asm-mips/mach-cobalt/cobalt.h	2006-08-18 23:19:19.781891500 +0900
@@ -67,12 +67,9 @@
 #define COBALT_BRD_ID_QUBE2    0x5
 #define COBALT_BRD_ID_RAQ2     0x6
 
-#define GALILEO_INTR_T0EXP	(1 << 8)
+#define GALILEO_INTR_T3EXP	(1 << 11)
 #define GALILEO_INTR_RETRY_CTR	(1 << 20)
 
-#define GALILEO_ENTC0		0x01
-#define GALILEO_SELTC0		0x02
-
 #define PCI_CFG_SET(devfn,where)					\
 	GT_WRITE(GT_PCI0_CFGADDR_OFS, (0x80000000 | (PCI_SLOT (devfn) << 11) |		\
 		(PCI_FUNC (devfn) << 8) | (where)))
