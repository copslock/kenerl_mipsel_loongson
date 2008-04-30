Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Apr 2008 20:28:09 +0100 (BST)
Received: from rtsoft3.corbina.net ([85.21.88.6]:62145 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S30618117AbYD3T2G (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 30 Apr 2008 20:28:06 +0100
Received: from wasted.dev.rtsoft.ru (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP
	id 0DE618816; Thu,  1 May 2008 00:27:58 +0500 (SAMST)
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
To:	ralf@linux-mips.org
Subject: [PATCH 7/11] Pb1500 code style cleanup
Date:	Wed, 30 Apr 2008 23:27:20 +0400
User-Agent: KMail/1.5
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200804302327.20153.sshtylyov@ru.mvista.com>
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19060
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Fix several errors and warnings given by checkpatch.pl:

- use of C99 // comments;

- printk() without KERN_* facility level;

- unnecessary braces for single-statement block;

- using simple_strtol() where strict_strtol() could be used.

In addition to these changes, also do the following:

- replace numeric literals/expressions with the matching macros;

- insert spaces between operator and its operands;

- properly indent the code and the array initializers;

- remove useless #if dirctive from board_setup();

- remove needless parentheses;

- remove unneeded type casts;

- remove excess new lines;

- make hexadecimal literals all lower case;

- remove space after the type cast's closing parenthesis;

- insert missing space before closing brace in the array initializers;

- replace spaces after the macro name with tabs in the #define directives, also
  sometimes insert space there for better looks;

- fix typos/errors, capitalize acronyms, etc. in the comments;

- update MontaVista copyright;

- remove Pete Popov's old email address...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

 arch/mips/au1000/pb1500/Makefile      |    6 ++--
 arch/mips/au1000/pb1500/board_setup.c |   46 +++++++++++++++-------------------
 arch/mips/au1000/pb1500/init.c        |   20 ++++++--------
 arch/mips/au1000/pb1500/irqmap.c      |    6 ++--
 include/asm-mips/mach-pb1x00/pb1500.h |   42 ++++++++++++++-----------------
 5 files changed, 56 insertions(+), 64 deletions(-)

Index: linux-2.6/arch/mips/au1000/pb1500/Makefile
===================================================================
--- linux-2.6.orig/arch/mips/au1000/pb1500/Makefile
+++ linux-2.6/arch/mips/au1000/pb1500/Makefile
@@ -1,8 +1,8 @@
 #
-#  Copyright 2000,2001 MontaVista Software Inc.
-#  Author: MontaVista Software, Inc.
-#     	ppopov@mvista.com or source@mvista.com
+#  Copyright 2000, 2001, 2008 MontaVista Software Inc.
+#  Author: MontaVista Software, Inc. <source@mvista.com>
 #
 # Makefile for the Alchemy Semiconductor Pb1500 board.
+#
 
 lib-y := init.o board_setup.o irqmap.o
Index: linux-2.6/arch/mips/au1000/pb1500/board_setup.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/pb1500/board_setup.c
+++ linux-2.6/arch/mips/au1000/pb1500/board_setup.c
@@ -1,7 +1,6 @@
 /*
- * Copyright 2000 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *         	ppopov@mvista.com or source@mvista.com
+ * Copyright 2000, 2008 MontaVista Software Inc.
+ * Author: MontaVista Software, Inc. <source@mvista.com>
  *
  *  This program is free software; you can redistribute  it and/or modify it
  *  under  the terms of  the GNU General  Public License as published by the
@@ -32,8 +31,8 @@
 
 void board_reset(void)
 {
-    /* Hit BCSR.SYSTEM_CONTROL[SW_RST] */
-    au_writel(0x00000000, 0xAE00001C);
+	/* Hit BCSR.RST_VDDI[SOFT_RESET] */
+	au_writel(0x00000000, PB1500_RST_VDDI);
 }
 
 void __init board_setup(void)
@@ -42,7 +41,7 @@ void __init board_setup(void)
 	u32 sys_freqctrl, sys_clksrc;
 
 	sys_clksrc = sys_freqctrl = pin_func = 0;
-	// set AUX clock to 12MHz * 8 = 96 MHz
+	/* Set AUX clock to 12 MHz * 8 = 96 MHz */
 	au_writel(8, SYS_AUXPLL);
 	au_writel(0, SYS_PINSTATERD);
 	udelay(100);
@@ -51,51 +50,48 @@ void __init board_setup(void)
 
 	/* GPIO201 is input for PCMCIA card detect */
 	/* GPIO203 is input for PCMCIA interrupt request */
-	au_writel(au_readl(GPIO2_DIR) & (u32)(~((1<<1)|(1<<3))), GPIO2_DIR);
+	au_writel(au_readl(GPIO2_DIR) & ~((1 << 1) | (1 << 3)), GPIO2_DIR);
 
-	/* zero and disable FREQ2 */
+	/* Zero and disable FREQ2 */
 	sys_freqctrl = au_readl(SYS_FREQCTRL0);
 	sys_freqctrl &= ~0xFFF00000;
 	au_writel(sys_freqctrl, SYS_FREQCTRL0);
 
 	/* zero and disable USBH/USBD clocks */
 	sys_clksrc = au_readl(SYS_CLKSRC);
-	sys_clksrc &= ~0x00007FE0;
+	sys_clksrc &= ~(SYS_CS_CUD | SYS_CS_DUD | SYS_CS_MUD_MASK |
+			SYS_CS_CUH | SYS_CS_DUH | SYS_CS_MUH_MASK);
 	au_writel(sys_clksrc, SYS_CLKSRC);
 
 	sys_freqctrl = au_readl(SYS_FREQCTRL0);
 	sys_freqctrl &= ~0xFFF00000;
 
 	sys_clksrc = au_readl(SYS_CLKSRC);
-	sys_clksrc &= ~0x00007FE0;
+	sys_clksrc &= ~(SYS_CS_CUD | SYS_CS_DUD | SYS_CS_MUD_MASK |
+			SYS_CS_CUH | SYS_CS_DUH | SYS_CS_MUH_MASK);
 
-	// FREQ2 = aux/2 = 48 MHz
-	sys_freqctrl |= ((0<<22) | (1<<21) | (1<<20));
+	/* FREQ2 = aux/2 = 48 MHz */
+	sys_freqctrl |= (0 << SYS_FC_FRDIV2_BIT) | SYS_FC_FE2 | SYS_FC_FS2;
 	au_writel(sys_freqctrl, SYS_FREQCTRL0);
 
 	/*
 	 * Route 48MHz FREQ2 into USB Host and/or Device
 	 */
-#if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
-	sys_clksrc |= ((4<<12) | (0<<11) | (0<<10));
-#endif
+	sys_clksrc |= SYS_CS_MUX_FQ2 << SYS_CS_MUH_BIT;
 	au_writel(sys_clksrc, SYS_CLKSRC);
 
-
-	pin_func = au_readl(SYS_PINFUNC) & (u32)(~0x8000);
-	// 2nd USB port is USB host
-	pin_func |= 0x8000;
+	pin_func = au_readl(SYS_PINFUNC) & ~SYS_PF_USB;
+	/* 2nd USB port is USB host */
+	pin_func |= SYS_PF_USB;
 	au_writel(pin_func, SYS_PINFUNC);
 #endif /* defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE) */
 
-
-
 #ifdef CONFIG_PCI
-	// Setup PCI bus controller
+	/* Setup PCI bus controller */
 	au_writel(0, Au1500_PCI_CMEM);
 	au_writel(0x00003fff, Au1500_CFG_BASE);
 #if defined(__MIPSEB__)
-	au_writel(0xf | (2<<6) | (1<<4), Au1500_PCI_CFG);
+	au_writel(0xf | (2 << 6) | (1 << 4), Au1500_PCI_CFG);
 #else
 	au_writel(0xf, Au1500_PCI_CFG);
 #endif
@@ -112,11 +108,11 @@ void __init board_setup(void)
 
 	/* Enable the RTC if not already enabled */
 	if (!(au_readl(0xac000028) & 0x20)) {
-		printk("enabling clock ...\n");
+		printk(KERN_INFO "enabling clock ...\n");
 		au_writel((au_readl(0xac000028) | 0x20), 0xac000028);
 	}
 	/* Put the clock in BCD mode */
-	if (au_readl(0xac00002C) & 0x4) { /* reg B */
+	if (au_readl(0xac00002c) & 0x4) { /* reg B */
 		au_writel(au_readl(0xac00002c) & ~0x4, 0xac00002c);
 		au_sync();
 	}
Index: linux-2.6/arch/mips/au1000/pb1500/init.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/pb1500/init.c
+++ linux-2.6/arch/mips/au1000/pb1500/init.c
@@ -1,11 +1,10 @@
 /*
  *
  * BRIEF MODULE DESCRIPTION
- *	PB1500 board setup
+ *	Pb1500 board setup
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
 		memsize = 0x04000000;
-	} else {
-		memsize = simple_strtol(memsize_str, NULL, 0);
-	}
+	else
+		memsize = strict_strtol(memsize_str, 0, NULL);
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
 }
Index: linux-2.6/arch/mips/au1000/pb1500/irqmap.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/pb1500/irqmap.c
+++ linux-2.6/arch/mips/au1000/pb1500/irqmap.c
@@ -31,12 +31,12 @@
 #include <asm/mach-au1x00/au1000.h>
 
 char irq_tab_alchemy[][5] __initdata = {
- [12] = { -1, INTA, INTX, INTX, INTX},   /* IDSEL 12 - HPT370   */
- [13] = { -1, INTA, INTB, INTC, INTD},   /* IDSEL 13 - PCI slot */
+	[12] = { -1, INTA, INTX, INTX, INTX },   /* IDSEL 12 - HPT370	*/
+	[13] = { -1, INTA, INTB, INTC, INTD },   /* IDSEL 13 - PCI slot */
 };
 
 struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
-	{ AU1500_GPIO_204, INTC_INT_HIGH_LEVEL, 0},
+	{ AU1500_GPIO_204, INTC_INT_HIGH_LEVEL, 0 },
 	{ AU1500_GPIO_201, INTC_INT_LOW_LEVEL, 0 },
 	{ AU1500_GPIO_202, INTC_INT_LOW_LEVEL, 0 },
 	{ AU1500_GPIO_203, INTC_INT_LOW_LEVEL, 0 },
Index: linux-2.6/include/asm-mips/mach-pb1x00/pb1500.h
===================================================================
--- linux-2.6.orig/include/asm-mips/mach-pb1x00/pb1500.h
+++ linux-2.6/include/asm-mips/mach-pb1x00/pb1500.h
@@ -1,9 +1,8 @@
 /*
- * Alchemy Semi PB1500 Referrence Board
+ * Alchemy Semi Pb1500 Referrence Board
  *
- * Copyright 2001 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *         	ppopov@mvista.com or source@mvista.com
+ * Copyright 2001, 2008 MontaVista Software Inc.
+ * Author: MontaVista Software, Inc. <source@mvista.com>
  *
  * ########################################################################
  *
@@ -27,25 +26,24 @@
 #ifndef __ASM_PB1500_H
 #define __ASM_PB1500_H
 
-
-#define IDENT_BOARD_REG           0xAE000000
-#define BOARD_STATUS_REG          0xAE000004
-#define PCI_BOARD_REG             0xAE000010
-#define PCMCIA_BOARD_REG          0xAE000010
-  #define PC_DEASSERT_RST               0x80
-  #define PC_DRV_EN                     0x10
-#define PB1500_G_CONTROL          0xAE000014
-#define PB1500_RST_VDDI           0xAE00001C
-#define PB1500_LEDS               0xAE000018
-
-#define PB1500_HEX_LED            0xAF000004
-#define PB1500_HEX_LED_BLANK      0xAF000008
-
-/* PCMCIA PB1500 specific defines */
-#define PCMCIA_MAX_SOCK 0
-#define PCMCIA_NUM_SOCKS (PCMCIA_MAX_SOCK+1)
+#define IDENT_BOARD_REG 	0xAE000000
+#define BOARD_STATUS_REG	0xAE000004
+#define PCI_BOARD_REG		0xAE000010
+#define PCMCIA_BOARD_REG	0xAE000010
+#  define PC_DEASSERT_RST	      0x80
+#  define PC_DRV_EN		      0x10
+#define PB1500_G_CONTROL	0xAE000014
+#define PB1500_RST_VDDI 	0xAE00001C
+#define PB1500_LEDS		0xAE000018
+
+#define PB1500_HEX_LED		0xAF000004
+#define PB1500_HEX_LED_BLANK	0xAF000008
+
+/* PCMCIA Pb1500 specific defines */
+#define PCMCIA_MAX_SOCK  0
+#define PCMCIA_NUM_SOCKS (PCMCIA_MAX_SOCK + 1)
 
 /* VPP/VCC */
-#define SET_VCC_VPP(VCC, VPP) (((VCC)<<2) | ((VPP)<<0))
+#define SET_VCC_VPP(VCC, VPP) (((VCC) << 2) | ((VPP) << 0))
 
 #endif /* __ASM_PB1500_H */
