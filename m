Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Apr 2008 20:29:03 +0100 (BST)
Received: from rtsoft3.corbina.net ([85.21.88.6]:62913 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S30618163AbYD3T3A (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 30 Apr 2008 20:29:00 +0100
Received: from wasted.dev.rtsoft.ru (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP
	id 62D9E8816; Thu,  1 May 2008 00:28:55 +0500 (SAMST)
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
To:	ralf@linux-mips.org
Subject: [PATCH 8/11] Pb1550 code style cleanup
Date:	Wed, 30 Apr 2008 23:28:17 +0400
User-Agent: KMail/1.5
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200804302328.17457.sshtylyov@ru.mvista.com>
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19061
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Fix a few errors and warnings given by checkpatch.pl:

- macros with complex values not enclosed in parentheses;

- printk() without KERN_* facility level;

- unnecessary braces for single-statement block;

- using simple_strtol() where strict_strtol() could be used.

In addition to these changes, also do the following:

- replace numeric literals with the matching macros;

- properly indent the code and the array initializers;

- insert spaces between operator and its operands, also remove excess spaces
  there;

- remove space after the type cast's closing parenthesis;

- insert missing space before closing brace in the array initializers;

- replace spaces after the macro name with tabs in the #define directives, also
  sometimes insert space there for better looks;

- remove excess tabs after the macro name in the #define directives;

- fix typos/errors, capitalize acronyms, etc. in the comments;

- make the multi-line comment style consistent with the kernel style elsewhere
  by adding empty first line;

- update MontaVista copyright;

- remove Pete Popov's old email address...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

 arch/mips/au1000/pb1550/Makefile      |    7 +---
 arch/mips/au1000/pb1550/board_setup.c |   16 +++++-----
 arch/mips/au1000/pb1550/init.c        |   20 +++++-------
 arch/mips/au1000/pb1550/irqmap.c      |    6 +--
 include/asm-mips/mach-pb1x00/pb1550.h |   53 +++++++++++++++++-----------------
 5 files changed, 50 insertions(+), 52 deletions(-)

Index: linux-2.6/arch/mips/au1000/pb1550/Makefile
===================================================================
--- linux-2.6.orig/arch/mips/au1000/pb1550/Makefile
+++ linux-2.6/arch/mips/au1000/pb1550/Makefile
@@ -1,9 +1,8 @@
 #
-#  Copyright 2000 MontaVista Software Inc.
-#  Author: MontaVista Software, Inc.
-#     	ppopov@mvista.com or source@mvista.com
+#  Copyright 2000, 2008 MontaVista Software Inc.
+#  Author: MontaVista Software, Inc. <source@mvista.com>
 #
-# Makefile for the Alchemy Semiconductor PB1000 board.
+# Makefile for the Alchemy Semiconductor Pb1550 board.
 #
 
 lib-y := init.o board_setup.o irqmap.o
Index: linux-2.6/arch/mips/au1000/pb1550/board_setup.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/pb1550/board_setup.c
+++ linux-2.6/arch/mips/au1000/pb1550/board_setup.c
@@ -3,9 +3,8 @@
  * BRIEF MODULE DESCRIPTION
  *	Alchemy Pb1550 board setup.
  *
- * Copyright 2000 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *         	ppopov@mvista.com or source@mvista.com
+ * Copyright 2000, 2008 MontaVista Software Inc.
+ * Author: MontaVista Software, Inc. <source@mvista.com>
  *
  *  This program is free software; you can redistribute  it and/or modify it
  *  under  the terms of  the GNU General  Public License as published by the
@@ -35,15 +34,16 @@
 
 void board_reset(void)
 {
-    /* Hit BCSR.SYSTEM_CONTROL[SW_RST] */
-	au_writew(au_readw(0xAF00001C) & ~(1<<15), 0xAF00001C);
+	/* Hit BCSR.SYSTEM[RESET] */
+	au_writew(au_readw(0xAF00001C) & ~BCSR_SYSTEM_RESET, 0xAF00001C);
 }
 
 void __init board_setup(void)
 {
 	u32 pin_func;
 
-	/* Enable PSC1 SYNC for AC97.  Normaly done in audio driver,
+	/*
+	 * Enable PSC1 SYNC for AC'97.  Normaly done in audio driver,
 	 * but it is board specific code, so put it here.
 	 */
 	pin_func = au_readl(SYS_PINFUNC);
@@ -51,8 +51,8 @@ void __init board_setup(void)
 	pin_func |= SYS_PF_MUST_BE_SET | SYS_PF_PSC1_S1;
 	au_writel(pin_func, SYS_PINFUNC);
 
-	au_writel(0, (u32)bcsr|0x10); /* turn off pcmcia power */
+	au_writel(0, (u32)bcsr | 0x10); /* turn off PCMCIA power */
 	au_sync();
 
-	printk("AMD Alchemy Pb1550 Board\n");
+	printk(KERN_INFO "AMD Alchemy Pb1550 Board\n");
 }
Index: linux-2.6/arch/mips/au1000/pb1550/init.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/pb1550/init.c
+++ linux-2.6/arch/mips/au1000/pb1550/init.c
@@ -1,11 +1,10 @@
 /*
  *
  * BRIEF MODULE DESCRIPTION
- *	PB1550 board setup
+ *	Pb1550 board setup
  *
- * Copyright 2001 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *         	ppopov@mvista.com or source@mvista.com
+ * Copyright 2001, 2008 MontaVista Software Inc.
+ * Author: MontaVista Software, Inc. <source@mvista.com>
  *
  *  This program is free software; you can redistribute  it and/or modify it
  *  under  the terms of  the GNU General  Public License as published by the
@@ -45,16 +44,15 @@ void __init prom_init(void)
 	unsigned char *memsize_str;
 	unsigned long memsize;
 
-	prom_argc = (int) fw_arg0;
-	prom_argv = (char **) fw_arg1;
-	prom_envp = (char **) fw_arg2;
+	prom_argc = (int)fw_arg0;
+	prom_argv = (char **)fw_arg1;
+	prom_envp = (char **)fw_arg2;
 
 	prom_init_cmdline();
 	memsize_str = prom_getenv("memsize");
-	if (!memsize_str) {
+	if (!memsize_str)
 		memsize = 0x08000000;
-	} else {
-		memsize = simple_strtol(memsize_str, NULL, 0);
-	}
+	else
+		memsize = strict_strtol(memsize_str, 0, NULL);
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
 }
Index: linux-2.6/arch/mips/au1000/pb1550/irqmap.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/pb1550/irqmap.c
+++ linux-2.6/arch/mips/au1000/pb1550/irqmap.c
@@ -1,6 +1,6 @@
 /*
  * BRIEF MODULE DESCRIPTION
- *	Au1xxx irq map table
+ *	Au1xx0 IRQ map table
  *
  * Copyright 2003 Embedded Edge, LLC
  *		dan@embeddededge.com
@@ -31,8 +31,8 @@
 #include <asm/mach-au1x00/au1000.h>
 
 char irq_tab_alchemy[][5] __initdata = {
- [12] =	{ -1, INTB, INTC, INTD, INTA},   /* IDSEL 12 - PCI slot 2 (left)  */
- [13] =	{ -1, INTA, INTB, INTC, INTD},   /* IDSEL 13 - PCI slot 1 (right) */
+	[12] = { -1, INTB, INTC, INTD, INTA }, /* IDSEL 12 - PCI slot 2 (left)  */
+	[13] = { -1, INTA, INTB, INTC, INTD }, /* IDSEL 13 - PCI slot 1 (right) */
 };
 
 struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
Index: linux-2.6/include/asm-mips/mach-pb1x00/pb1550.h
===================================================================
--- linux-2.6.orig/include/asm-mips/mach-pb1x00/pb1550.h
+++ linux-2.6/include/asm-mips/mach-pb1x00/pb1550.h
@@ -30,15 +30,15 @@
 #include <linux/types.h>
 #include <asm/mach-au1x00/au1xxx_psc.h>
 
-#define DBDMA_AC97_TX_CHAN DSCR_CMD0_PSC1_TX
-#define DBDMA_AC97_RX_CHAN DSCR_CMD0_PSC1_RX
-#define DBDMA_I2S_TX_CHAN DSCR_CMD0_PSC3_TX
-#define DBDMA_I2S_RX_CHAN DSCR_CMD0_PSC3_RX
-
-#define SPI_PSC_BASE        PSC0_BASE_ADDR
-#define AC97_PSC_BASE       PSC1_BASE_ADDR
-#define SMBUS_PSC_BASE      PSC2_BASE_ADDR
-#define I2S_PSC_BASE        PSC3_BASE_ADDR
+#define DBDMA_AC97_TX_CHAN	DSCR_CMD0_PSC1_TX
+#define DBDMA_AC97_RX_CHAN	DSCR_CMD0_PSC1_RX
+#define DBDMA_I2S_TX_CHAN	DSCR_CMD0_PSC3_TX
+#define DBDMA_I2S_RX_CHAN	DSCR_CMD0_PSC3_RX
+
+#define SPI_PSC_BASE		PSC0_BASE_ADDR
+#define AC97_PSC_BASE		PSC1_BASE_ADDR
+#define SMBUS_PSC_BASE		PSC2_BASE_ADDR
+#define I2S_PSC_BASE		PSC3_BASE_ADDR
 
 #define BCSR_PHYS_ADDR 0xAF000000
 
@@ -129,12 +129,12 @@ static BCSR * const bcsr = (BCSR *)BCSR_
 #define BCSR_SYSTEM_POWEROFF	0x4000
 #define BCSR_SYSTEM_RESET	0x8000
 
-#define PCMCIA_MAX_SOCK 1
-#define PCMCIA_NUM_SOCKS (PCMCIA_MAX_SOCK+1)
+#define PCMCIA_MAX_SOCK  1
+#define PCMCIA_NUM_SOCKS (PCMCIA_MAX_SOCK + 1)
 
 /* VPP/VCC */
-#define SET_VCC_VPP(VCC, VPP, SLOT)\
-	((((VCC)<<2) | ((VPP)<<0)) << ((SLOT)*8))
+#define SET_VCC_VPP(VCC, VPP, SLOT) \
+	((((VCC) << 2) | ((VPP) << 0)) << ((SLOT) * 8))
 
 #if defined(CONFIG_MTD_PB1550_BOOT) && defined(CONFIG_MTD_PB1550_USER)
 #define PB1550_BOTH_BANKS
@@ -144,16 +144,17 @@ static BCSR * const bcsr = (BCSR *)BCSR_
 #define PB1550_USER_ONLY
 #endif
 
-/* Timing values as described in databook, * ns value stripped of
+/*
+ * Timing values as described in databook, * ns value stripped of
  * lower 2 bits.
  * These defines are here rather than an SOC1550 generic file because
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
@@ -161,16 +162,16 @@ static BCSR * const bcsr = (BCSR *)BCSR_
 #define NAND_T_SU_SHIFT		8
 #define NAND_T_WH_SHIFT		12
 
-#define NAND_TIMING	((NAND_T_H   & 0xF)	<< NAND_T_H_SHIFT)   | \
-			((NAND_T_PUL & 0xF)	<< NAND_T_PUL_SHIFT) | \
-			((NAND_T_SU  & 0xF)	<< NAND_T_SU_SHIFT)  | \
-			((NAND_T_WH  & 0xF)	<< NAND_T_WH_SHIFT)
+#define NAND_TIMING	(((NAND_T_H   & 0xF) << NAND_T_H_SHIFT)   | \
+			 ((NAND_T_PUL & 0xF) << NAND_T_PUL_SHIFT) | \
+			 ((NAND_T_SU  & 0xF) << NAND_T_SU_SHIFT)  | \
+			 ((NAND_T_WH  & 0xF) << NAND_T_WH_SHIFT))
 
 #define NAND_CS 1
 
-/* should be done by yamon */
-#define NAND_STCFG  0x00400005 /* 8-bit NAND */
-#define NAND_STTIME 0x00007774 /* valid for 396MHz SD=2 only */
-#define NAND_STADDR 0x12000FFF /* physical address 0x20000000 */
+/* Should be done by YAMON */
+#define NAND_STCFG	0x00400005 /* 8-bit NAND */
+#define NAND_STTIME	0x00007774 /* valid for 396 MHz SD=2 only */
+#define NAND_STADDR	0x12000FFF /* physical address 0x20000000 */
 
 #endif /* __ASM_PB1550_H */
