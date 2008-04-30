Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Apr 2008 20:32:13 +0100 (BST)
Received: from rtsoft3.corbina.net ([85.21.88.6]:706 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S30618263AbYD3TcG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 30 Apr 2008 20:32:06 +0100
Received: from wasted.dev.rtsoft.ru (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP
	id 7D0188816; Thu,  1 May 2008 00:31:41 +0500 (SAMST)
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
To:	ralf@linux-mips.org
Subject: [PATCH 11/11] XXS1500 code style cleanup
Date:	Wed, 30 Apr 2008 23:31:03 +0400
User-Agent: KMail/1.5
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200804302331.03586.sshtylyov@ru.mvista.com>
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19064
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Fix several errors and warnings given by checkpatch.pl:

- use of C99 // comments;

- using simple_strtol() where strict_strtol() could be used.

In addition to these changes, also do the following:

- remove needless parentheses;

- remove unneeded numeric literal type cast;

- insert spaces between operator and its operands;

- remove excess new lines;

- remove space after the type cast's closing parenthesis;

- insert missing space before closing brace in the structure initializer;

- fix typos, capitalize acronyms, etc. in the comments;

- update MontaVista copyright;

- remove Pete Popov's old email address...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

 arch/mips/au1000/xxs1500/Makefile      |    3 --
 arch/mips/au1000/xxs1500/board_setup.c |   39 ++++++++++++++++-----------------
 arch/mips/au1000/xxs1500/init.c        |   11 ++++-----
 arch/mips/au1000/xxs1500/irqmap.c      |    2 -
 4 files changed, 26 insertions(+), 29 deletions(-)

Index: linux-2.6/arch/mips/au1000/xxs1500/Makefile
===================================================================
--- linux-2.6.orig/arch/mips/au1000/xxs1500/Makefile
+++ linux-2.6/arch/mips/au1000/xxs1500/Makefile
@@ -1,7 +1,6 @@
 #
 #  Copyright 2003 MontaVista Software Inc.
-#  Author: MontaVista Software, Inc.
-#     	ppopov@mvista.com or source@mvista.com
+#  Author: MontaVista Software, Inc. <source@mvista.com>
 #
 # Makefile for MyCable XXS1500 board.
 #
Index: linux-2.6/arch/mips/au1000/xxs1500/board_setup.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/xxs1500/board_setup.c
+++ linux-2.6/arch/mips/au1000/xxs1500/board_setup.c
@@ -1,7 +1,6 @@
 /*
- * Copyright 2000-2003 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *         	ppopov@mvista.com or source@mvista.com
+ * Copyright 2000-2003, 2008 MontaVista Software Inc.
+ * Author: MontaVista Software, Inc. <source@mvista.com>
  *
  *  This program is free software; you can redistribute  it and/or modify it
  *  under  the terms of  the GNU General  Public License as published by the
@@ -39,40 +38,40 @@ void __init board_setup(void)
 {
 	u32 pin_func;
 
-	// set multiple use pins (UART3/GPIO) to UART (it's used as UART too)
-	pin_func = au_readl(SYS_PINFUNC) & (u32)(~SYS_PF_UR3);
+	/* Set multiple use pins (UART3/GPIO) to UART (it's used as UART too) */
+	pin_func  = au_readl(SYS_PINFUNC) & ~SYS_PF_UR3;
 	pin_func |= SYS_PF_UR3;
 	au_writel(pin_func, SYS_PINFUNC);
 
-	// enable UART
-	au_writel(0x01, UART3_ADDR+UART_MOD_CNTRL); // clock enable (CE)
+	/* Enable UART */
+	au_writel(0x01, UART3_ADDR + UART_MOD_CNTRL); /* clock enable (CE) */
 	mdelay(10);
-	au_writel(0x03, UART3_ADDR+UART_MOD_CNTRL); // CE and "enable"
+	au_writel(0x03, UART3_ADDR + UART_MOD_CNTRL); /* CE and "enable" */
 	mdelay(10);
 
-	// enable DTR = USB power up
-	au_writel(0x01, UART3_ADDR+UART_MCR); //? UART_MCR_DTR is 0x01???
+	/* Enable DTR = USB power up */
+	au_writel(0x01, UART3_ADDR + UART_MCR); /* UART_MCR_DTR is 0x01??? */
 
 #ifdef CONFIG_PCMCIA_XXS1500
-	/* setup pcmcia signals */
+	/* Setup PCMCIA signals */
 	au_writel(0, SYS_PININPUTEN);
 
-	/* gpio 0, 1, and 4 are inputs */
-	au_writel(1 | (1<<1) | (1<<4), SYS_TRIOUTCLR);
+	/* GPIO 0, 1, and 4 are inputs */
+	au_writel(1 | (1 << 1) | (1 << 4), SYS_TRIOUTCLR);
 
-	/* enable GPIO2 if not already enabled */
+	/* Enable GPIO2 if not already enabled */
 	au_writel(1, GPIO2_ENABLE);
-	/* gpio2 208/9/10/11 are inputs */
-	au_writel((1<<8) | (1<<9) | (1<<10) | (1<<11), GPIO2_DIR);
+	/* GPIO2 208/9/10/11 are inputs */
+	au_writel((1 << 8) | (1 << 9) | (1 << 10) | (1 << 11), GPIO2_DIR);
 
-	/* turn off power */
-	au_writel((au_readl(GPIO2_PINSTATE) & ~(1<<14))|(1<<30), GPIO2_OUTPUT);
+	/* Turn off power */
+	au_writel((au_readl(GPIO2_PINSTATE) & ~(1 << 14)) | (1 << 30),
+		  GPIO2_OUTPUT);
 #endif
 
-
 #ifdef CONFIG_PCI
 #if defined(__MIPSEB__)
-	au_writel(0xf | (2<<6) | (1<<4), Au1500_PCI_CFG);
+	au_writel(0xf | (2 << 6) | (1 << 4), Au1500_PCI_CFG);
 #else
 	au_writel(0xf, Au1500_PCI_CFG);
 #endif
Index: linux-2.6/arch/mips/au1000/xxs1500/init.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/xxs1500/init.c
+++ linux-2.6/arch/mips/au1000/xxs1500/init.c
@@ -2,9 +2,8 @@
  * BRIEF MODULE DESCRIPTION
  *	XXS1500 board setup
  *
- * Copyright 2003 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *         	ppopov@mvista.com or source@mvista.com
+ * Copyright 2003, 2008 MontaVista Software Inc.
+ * Author: MontaVista Software, Inc. <source@mvista.com>
  *
  *  This program is free software; you can redistribute  it and/or modify it
  *  under  the terms of  the GNU General  Public License as published by the
@@ -45,8 +44,8 @@ void __init prom_init(void)
 	unsigned long memsize;
 
 	prom_argc = fw_arg0;
-	prom_argv = (char **) fw_arg1;
-	prom_envp = (char **) fw_arg2;
+	prom_argv = (char **)fw_arg1;
+	prom_envp = (char **)fw_arg2;
 
 	prom_init_cmdline();
 
@@ -54,6 +53,6 @@ void __init prom_init(void)
 	if (!memsize_str)
 		memsize = 0x04000000;
 	else
-		memsize = simple_strtol(memsize_str, NULL, 0);
+		memsize = strict_strtol(memsize_str, 0, NULL);
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
 }
Index: linux-2.6/arch/mips/au1000/xxs1500/irqmap.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/xxs1500/irqmap.c
+++ linux-2.6/arch/mips/au1000/xxs1500/irqmap.c
@@ -31,7 +31,7 @@
 #include <asm/mach-au1x00/au1000.h>
 
 struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
-	{ AU1500_GPIO_204, INTC_INT_HIGH_LEVEL, 0},
+	{ AU1500_GPIO_204, INTC_INT_HIGH_LEVEL, 0 },
 	{ AU1500_GPIO_201, INTC_INT_LOW_LEVEL, 0 },
 	{ AU1500_GPIO_202, INTC_INT_LOW_LEVEL, 0 },
 	{ AU1500_GPIO_203, INTC_INT_LOW_LEVEL, 0 },
