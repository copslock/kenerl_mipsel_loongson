Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Apr 2008 20:25:53 +0100 (BST)
Received: from rtsoft3.corbina.net ([85.21.88.6]:59585 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S30617975AbYD3TZs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 30 Apr 2008 20:25:48 +0100
Received: from wasted.dev.rtsoft.ru (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP
	id 8AA7C8815; Thu,  1 May 2008 00:25:42 +0500 (SAMST)
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
To:	ralf@linux-mips.org
Subject: [PATCH 4/11] DBAu1xx0 code style cleanup
Date:	Wed, 30 Apr 2008 23:25:04 +0400
User-Agent: KMail/1.5
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200804302325.04753.sshtylyov@ru.mvista.com>
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19057
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Fix several errors and warnings given by checkpatch.pl:

- macros with complex values not enclosed in parentheses;

- leading spaces instead of tabs;

- printk() without KERN_* facility level;

- using simple_strtol() where strict_strtol() could be used;

- line over 80 characters.

In addition to these changes, also do the following:

- initialize variable instead of assigning value later where it makes sense;

- insert spaces between operator and its operands, also remove excess spaces
  there;

- remove unneeded numeric literal type casts;

- remove needless parentheses;

- remove space after the type cast's closing parenthesis;

- insert missing space before closing brace in the array initializers;

- replace spaces after the macro name with tabs in the #define directives;

- remove excess tabs after the macro name in the #define directives;

- fix typos/errors, capitalize acronyms, etc. in the comments;

- make the multi-line comment style consistent with the kernel style elsewhere
  by adding empty first/last line;

- update MontaVista copyright;

- remove Pete Popov's old email address...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

 arch/mips/au1000/db1x00/Makefile      |    8 +--
 arch/mips/au1000/db1x00/board_setup.c |   61 +++++++++++------------
 arch/mips/au1000/db1x00/init.c        |   11 +---
 arch/mips/au1000/db1x00/irqmap.c      |   22 ++++----
 include/asm-mips/mach-db1x00/db1x00.h |   87 +++++++++++++++++-----------------
 5 files changed, 94 insertions(+), 95 deletions(-)

Index: linux-2.6/arch/mips/au1000/db1x00/Makefile
===================================================================
--- linux-2.6.orig/arch/mips/au1000/db1x00/Makefile
+++ linux-2.6/arch/mips/au1000/db1x00/Makefile
@@ -1,8 +1,8 @@
 #
-#  Copyright 2000 MontaVista Software Inc.
-#  Author: MontaVista Software, Inc.
-#     	ppopov@mvista.com or source@mvista.com
+#  Copyright 2000, 2008 MontaVista Software Inc.
+#  Author: MontaVista Software, Inc. <source@mvista.com>
+#
+# Makefile for the Alchemy Semiconductor DBAu1xx0 boards.
 #
-# Makefile for the Alchemy Semiconductor Db1x00 board.
 
 lib-y := init.o board_setup.o irqmap.o
Index: linux-2.6/arch/mips/au1000/db1x00/board_setup.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/db1x00/board_setup.c
+++ linux-2.6/arch/mips/au1000/db1x00/board_setup.c
@@ -3,9 +3,8 @@
  * BRIEF MODULE DESCRIPTION
  *	Alchemy Db1x00 board setup.
  *
- * Copyright 2000 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *         	ppopov@mvista.com or source@mvista.com
+ * Copyright 2000, 2008 MontaVista Software Inc.
+ * Author: MontaVista Software, Inc. <source@mvista.com>
  *
  *  This program is free software; you can redistribute  it and/or modify it
  *  under  the terms of  the GNU General  Public License as published by the
@@ -37,49 +36,49 @@ static BCSR * const bcsr = (BCSR *)BCSR_
 
 void board_reset(void)
 {
-	/* Hit BCSR.SYSTEM_CONTROL[SW_RST] */
+	/* Hit BCSR.SW_RESET[RESET] */
 	bcsr->swreset = 0x0000;
 }
 
 void __init board_setup(void)
 {
-	u32 pin_func;
+	u32 pin_func = 0;
 
-	pin_func = 0;
-	/* not valid for 1550 */
-
-#if defined(CONFIG_IRDA) && (defined(CONFIG_SOC_AU1000) || defined(CONFIG_SOC_AU1100))
-	/* set IRFIRSEL instead of GPIO15 */
-	pin_func = au_readl(SYS_PINFUNC) | (u32)((1<<8));
+	/* Not valid for Au1550 */
+#if defined(CONFIG_IRDA) && \
+   (defined(CONFIG_SOC_AU1000) || defined(CONFIG_SOC_AU1100))
+	/* Set IRFIRSEL instead of GPIO15 */
+	pin_func = au_readl(SYS_PINFUNC) | SYS_PF_IRF;
 	au_writel(pin_func, SYS_PINFUNC);
-	/* power off until the driver is in use */
+	/* Power off until the driver is in use */
 	bcsr->resets &= ~BCSR_RESETS_IRDA_MODE_MASK;
-	bcsr->resets |= BCSR_RESETS_IRDA_MODE_OFF;
+	bcsr->resets |=  BCSR_RESETS_IRDA_MODE_OFF;
 	au_sync();
 #endif
 	bcsr->pcmcia = 0x0000; /* turn off PCMCIA power */
 
 #ifdef CONFIG_MIPS_MIRAGE
-	/* enable GPIO[31:0] inputs */
+	/* Enable GPIO[31:0] inputs */
 	au_writel(0, SYS_PININPUTEN);
 
-	/* GPIO[20] is output, tristate the other input primary GPIO's */
-	au_writel((u32)(~(1<<20)), SYS_TRIOUTCLR);
+	/* GPIO[20] is output, tristate the other input primary GPIOs */
+	au_writel(~(1 << 20), SYS_TRIOUTCLR);
 
-	/* set GPIO[210:208] instead of SSI_0 */
-	pin_func = au_readl(SYS_PINFUNC) | (u32)(1);
+	/* Set GPIO[210:208] instead of SSI_0 */
+	pin_func = au_readl(SYS_PINFUNC) | SYS_PF_S0;
 
-	/* set GPIO[215:211] for LED's */
-	pin_func |= (u32)((5<<2));
+	/* Set GPIO[215:211] for LEDs */
+	pin_func |= 5 << 2;
 
-	/* set GPIO[214:213] for more LED's */
-	pin_func |= (u32)((5<<12));
+	/* Set GPIO[214:213] for more LEDs */
+	pin_func |= 5 << 12;
 
-	/* set GPIO[207:200] instead of PCMCIA/LCD */
-	pin_func |= (u32)((3<<17));
+	/* Set GPIO[207:200] instead of PCMCIA/LCD */
+	pin_func |= SYS_PF_LCD | SYS_PF_PC;
 	au_writel(pin_func, SYS_PINFUNC);
 
-	/* Enable speaker amplifier.  This should
+	/*
+	 * Enable speaker amplifier.  This should
 	 * be part of the audio driver.
 	 */
 	au_writel(au_readl(GPIO2_DIR) | 0x200, GPIO2_DIR);
@@ -89,21 +88,21 @@ void __init board_setup(void)
 	au_sync();
 
 #ifdef CONFIG_MIPS_DB1000
-    printk("AMD Alchemy Au1000/Db1000 Board\n");
+	printk(KERN_INFO "AMD Alchemy Au1000/Db1000 Board\n");
 #endif
 #ifdef CONFIG_MIPS_DB1500
-    printk("AMD Alchemy Au1500/Db1500 Board\n");
+	printk(KERN_INFO "AMD Alchemy Au1500/Db1500 Board\n");
 #endif
 #ifdef CONFIG_MIPS_DB1100
-    printk("AMD Alchemy Au1100/Db1100 Board\n");
+	printk(KERN_INFO "AMD Alchemy Au1100/Db1100 Board\n");
 #endif
 #ifdef CONFIG_MIPS_BOSPORUS
-    printk("AMD Alchemy Bosporus Board\n");
+	printk(KERN_INFO "AMD Alchemy Bosporus Board\n");
 #endif
 #ifdef CONFIG_MIPS_MIRAGE
-    printk("AMD Alchemy Mirage Board\n");
+	printk(KERN_INFO "AMD Alchemy Mirage Board\n");
 #endif
 #ifdef CONFIG_MIPS_DB1550
-    printk("AMD Alchemy Au1550/Db1550 Board\n");
+	printk(KERN_INFO "AMD Alchemy Au1550/Db1550 Board\n");
 #endif
 }
Index: linux-2.6/arch/mips/au1000/db1x00/init.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/db1x00/init.c
+++ linux-2.6/arch/mips/au1000/db1x00/init.c
@@ -2,9 +2,8 @@
  * BRIEF MODULE DESCRIPTION
  *	PB1000 board setup
  *
- * Copyright 2001 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *         	ppopov@mvista.com or source@mvista.com
+ * Copyright 2001, 2008 MontaVista Software Inc.
+ * Author: MontaVista Software, Inc. <source@mvista.com>
  *
  *  This program is free software; you can redistribute  it and/or modify it
  *  under  the terms of  the GNU General  Public License as published by the
@@ -49,8 +48,8 @@ void __init prom_init(void)
 	unsigned long memsize;
 
 	prom_argc = fw_arg0;
-	prom_argv = (char **) fw_arg1;
-	prom_envp = (char **) fw_arg2;
+	prom_argv = (char **)fw_arg1;
+	prom_envp = (char **)fw_arg2;
 
 	prom_init_cmdline();
 
@@ -58,6 +57,6 @@ void __init prom_init(void)
 	if (!memsize_str)
 		memsize = 0x04000000;
 	else
-		memsize = simple_strtol(memsize_str, NULL, 0);
+		memsize = strict_strtol(memsize_str, 0, NULL);
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
 }
Index: linux-2.6/arch/mips/au1000/db1x00/irqmap.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/db1x00/irqmap.c
+++ linux-2.6/arch/mips/au1000/db1x00/irqmap.c
@@ -32,32 +32,32 @@
 
 #ifdef CONFIG_MIPS_DB1500
 char irq_tab_alchemy[][5] __initdata = {
- [12] =	{ -1, INTA, INTX, INTX, INTX},   /* IDSEL 12 - HPT371   */
- [13] =	{ -1, INTA, INTB, INTC, INTD},   /* IDSEL 13 - PCI slot */
+	[12] = { -1, INTA, INTX, INTX, INTX }, /* IDSEL 12 - HPT371   */
+	[13] = { -1, INTA, INTB, INTC, INTD }, /* IDSEL 13 - PCI slot */
 };
 #endif
 
 #ifdef CONFIG_MIPS_BOSPORUS
 char irq_tab_alchemy[][5] __initdata = {
- [11] =	{ -1, INTA, INTB, INTX, INTX},   /* IDSEL 11 - miniPCI  */
- [12] =	{ -1, INTA, INTX, INTX, INTX},   /* IDSEL 12 - SN1741   */
- [13] =	{ -1, INTA, INTB, INTC, INTD},   /* IDSEL 13 - PCI slot */
+	[11] = { -1, INTA, INTB, INTX, INTX }, /* IDSEL 11 - miniPCI  */
+	[12] = { -1, INTA, INTX, INTX, INTX }, /* IDSEL 12 - SN1741   */
+	[13] = { -1, INTA, INTB, INTC, INTD }, /* IDSEL 13 - PCI slot */
 };
 #endif
 
 #ifdef CONFIG_MIPS_MIRAGE
 char irq_tab_alchemy[][5] __initdata = {
- [11] =	{ -1, INTD, INTX, INTX, INTX},   /* IDSEL 11 - SMI VGX */
- [12] =	{ -1, INTX, INTX, INTC, INTX},   /* IDSEL 12 - PNX1300 */
- [13] =	{ -1, INTA, INTB, INTX, INTX},   /* IDSEL 13 - miniPCI */
+	[11] = { -1, INTD, INTX, INTX, INTX }, /* IDSEL 11 - SMI VGX */
+	[12] = { -1, INTX, INTX, INTC, INTX }, /* IDSEL 12 - PNX1300 */
+	[13] = { -1, INTA, INTB, INTX, INTX }, /* IDSEL 13 - miniPCI */
 };
 #endif
 
 #ifdef CONFIG_MIPS_DB1550
 char irq_tab_alchemy[][5] __initdata = {
- [11] =	{ -1, INTC, INTX, INTX, INTX},   /* IDSEL 11 - on-board HPT371    */
- [12] =	{ -1, INTB, INTC, INTD, INTA},   /* IDSEL 12 - PCI slot 2 (left)  */
- [13] =	{ -1, INTA, INTB, INTC, INTD},   /* IDSEL 13 - PCI slot 1 (right) */
+	[11] = { -1, INTC, INTX, INTX, INTX }, /* IDSEL 11 - on-board HPT371 */
+	[12] = { -1, INTB, INTC, INTD, INTA }, /* IDSEL 12 - PCI slot 2 (left) */
+	[13] = { -1, INTA, INTB, INTC, INTD }, /* IDSEL 13 - PCI slot 1 (right) */
 };
 #endif
 
Index: linux-2.6/include/asm-mips/mach-db1x00/db1x00.h
===================================================================
--- linux-2.6.orig/include/asm-mips/mach-db1x00/db1x00.h
+++ linux-2.6/include/asm-mips/mach-db1x00/db1x00.h
@@ -1,9 +1,8 @@
 /*
- * AMD Alchemy DB1x00 Reference Boards
+ * AMD Alchemy DBAu1x00 Reference Boards
  *
- * Copyright 2001 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *         	ppopov@mvista.com or source@mvista.com
+ * Copyright 2001, 2008 MontaVista Software Inc.
+ * Author: MontaVista Software, Inc. <source@mvista.com>
  * Copyright (C) 2005 Ralf Baechle (ralf@linux-mips.org)
  *
  * ########################################################################
@@ -32,26 +31,26 @@
 
 #ifdef CONFIG_MIPS_DB1550
 
-#define DBDMA_AC97_TX_CHAN DSCR_CMD0_PSC1_TX
-#define DBDMA_AC97_RX_CHAN DSCR_CMD0_PSC1_RX
-#define DBDMA_I2S_TX_CHAN  DSCR_CMD0_PSC3_TX
-#define DBDMA_I2S_RX_CHAN  DSCR_CMD0_PSC3_RX
-
-#define SPI_PSC_BASE       PSC0_BASE_ADDR
-#define AC97_PSC_BASE      PSC1_BASE_ADDR
-#define SMBUS_PSC_BASE     PSC2_BASE_ADDR
-#define I2S_PSC_BASE       PSC3_BASE_ADDR
+#define DBDMA_AC97_TX_CHAN	DSCR_CMD0_PSC1_TX
+#define DBDMA_AC97_RX_CHAN	DSCR_CMD0_PSC1_RX
+#define DBDMA_I2S_TX_CHAN	DSCR_CMD0_PSC3_TX
+#define DBDMA_I2S_RX_CHAN	DSCR_CMD0_PSC3_RX
+
+#define SPI_PSC_BASE		PSC0_BASE_ADDR
+#define AC97_PSC_BASE		PSC1_BASE_ADDR
+#define SMBUS_PSC_BASE		PSC2_BASE_ADDR
+#define I2S_PSC_BASE		PSC3_BASE_ADDR
 
-#define BCSR_KSEG1_ADDR 0xAF000000
-#define NAND_PHYS_ADDR  0x20000000
+#define BCSR_KSEG1_ADDR 	0xAF000000
+#define NAND_PHYS_ADDR		0x20000000
 
 #else
 #define BCSR_KSEG1_ADDR 0xAE000000
 #endif
 
 /*
- * Overlay data structure of the Db1x00 board registers.
- * Registers located at physical 0E0000xx, KSEG1 0xAE0000xx
+ * Overlay data structure of the DBAu1x00 board registers.
+ * Registers are located at physical 0E0000xx, KSEG1 0xAE0000xx.
  */
 typedef volatile struct
 {
@@ -138,18 +137,19 @@ typedef volatile struct
 
 #define BCSR_SWRESET_RESET		0x0080
 
-/* PCMCIA Db1x00 specific defines */
-#define PCMCIA_MAX_SOCK 1
-#define PCMCIA_NUM_SOCKS (PCMCIA_MAX_SOCK+1)
+/* PCMCIA DBAu1x00 specific defines */
+#define PCMCIA_MAX_SOCK  1
+#define PCMCIA_NUM_SOCKS (PCMCIA_MAX_SOCK + 1)
 
 /* VPP/VCC */
 #define SET_VCC_VPP(VCC, VPP, SLOT)\
-	((((VCC)<<2) | ((VPP)<<0)) << ((SLOT)*8))
+	((((VCC) << 2) | ((VPP) << 0)) << ((SLOT) * 8))
 
-/* SD controller macros */
 /*
- * Detect card.
+ * SD controller macros
  */
+
+/* Detect card. */
 #define mmc_card_inserted(_n_, _res_) \
 	do { \
 		BCSR * const bcsr = (BCSR *)0xAE000000; \
@@ -176,10 +176,10 @@ typedef volatile struct
 		unsigned long mmc_pwr, mmc_wp, board_specific; \
 		if ((_n_)) { \
 			mmc_pwr = BCSR_BOARD_SD1_PWR; \
-			mmc_wp = BCSR_BOARD_SD1_WP; \
+			mmc_wp	= BCSR_BOARD_SD1_WP; \
 		} else { \
 			mmc_pwr = BCSR_BOARD_SD0_PWR; \
-			mmc_wp = BCSR_BOARD_SD0_WP; \
+			mmc_wp	= BCSR_BOARD_SD0_WP; \
 		} \
 		board_specific = au_readl((unsigned long)(&bcsr->specific)); \
 		if (!(board_specific & mmc_wp)) {/* low means card present */ \
@@ -190,17 +190,19 @@ typedef volatile struct
 	} while (0)
 
 
-/* NAND defines */
-/* Timing values as described in databook, * ns value stripped of
+/*
+ * NAND defines
+ *
+ * Timing values as described in databook, * ns value stripped of the
  * lower 2 bits.
- * These defines are here rather than an SOC1550 generic file because
+ * These defines are here rather than an Au1550 generic file because
  * the parts chosen on another board may be different and may require
  * different timings.
  */
-#define NAND_T_H			(18 >> 2)
-#define NAND_T_PUL			(30 >> 2)
-#define NAND_T_SU			(30 >> 2)
-#define NAND_T_WH			(30 >> 2)
+#define NAND_T_H		(18 >> 2)
+#define NAND_T_PUL		(30 >> 2)
+#define NAND_T_SU		(30 >> 2)
+#define NAND_T_WH		(30 >> 2)
 
 /* Bitfield shift amounts */
 #define NAND_T_H_SHIFT		0
@@ -208,16 +210,15 @@ typedef volatile struct
 #define NAND_T_SU_SHIFT		8
 #define NAND_T_WH_SHIFT		12
 
-#define NAND_TIMING	((NAND_T_H   & 0xF)	<< NAND_T_H_SHIFT)   | \
-			((NAND_T_PUL & 0xF)	<< NAND_T_PUL_SHIFT) | \
-			((NAND_T_SU  & 0xF)	<< NAND_T_SU_SHIFT)  | \
-			((NAND_T_WH  & 0xF)	<< NAND_T_WH_SHIFT)
-#define NAND_CS 1
-
-/* should be done by yamon */
-#define NAND_STCFG  0x00400005 /* 8-bit NAND */
-#define NAND_STTIME 0x00007774 /* valid for 396MHz SD=2 only */
-#define NAND_STADDR 0x12000FFF /* physical address 0x20000000 */
+#define NAND_TIMING	(((NAND_T_H   & 0xF) << NAND_T_H_SHIFT)   | \
+			 ((NAND_T_PUL & 0xF) << NAND_T_PUL_SHIFT) | \
+			 ((NAND_T_SU  & 0xF) << NAND_T_SU_SHIFT)  | \
+			 ((NAND_T_WH  & 0xF) << NAND_T_WH_SHIFT))
+#define NAND_CS 	1
+
+/* Should be done by YAMON */
+#define NAND_STCFG	0x00400005 /* 8-bit NAND */
+#define NAND_STTIME	0x00007774 /* valid for 396 MHz SD=2 only */
+#define NAND_STADDR	0x12000FFF /* physical address 0x20000000 */
 
 #endif /* __ASM_DB1X00_H */
-
