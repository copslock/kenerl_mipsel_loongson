Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Apr 2008 20:26:45 +0100 (BST)
Received: from rtsoft3.corbina.net ([85.21.88.6]:60609 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S29574466AbYD3T0m (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 30 Apr 2008 20:26:42 +0100
Received: from wasted.dev.rtsoft.ru (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP
	id 0133F8815; Thu,  1 May 2008 00:26:33 +0500 (SAMST)
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
To:	ralf@linux-mips.org
Subject: [PATCH 5/11] Pb1000 code style cleanup
Date:	Wed, 30 Apr 2008 23:25:55 +0400
User-Agent: KMail/1.5
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200804302325.55147.sshtylyov@ru.mvista.com>
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19058
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Fix several errors and warnings given by checkpatch.pl:

- use of C99 // comments;

- brace not on the same line with condition in the 'switch' statement;

- printk() without KERN_* facility level;

- unnecessary braces for single-statement block;

- using simple_strtol() where strict_strtol() could be used.

In addition to these changes, also do the following:

- properly indent the 'switch' statement;

- remove needless parentheses;

- insert spaces between operator and its operands;

- replace numeric literals/expressions with the matching macros;

- remove useless #if dirctive from board_setup();

- remove unneeded numeric literal type casts;

- remove space after the type cast's closing parenthesis;

- replace spaces after the macro name with tabs in the #define directives, and
  sometimes insert spaces there;

- remove excess new lines;

- fix typos/errors, capitalize acronyms, etc. in the comments;

- make the multi-line comment style consistent with the kernel style elsewhere
  by adding empty first/last line;

- combine some comments;

- update MontaVista copyright;

- remove Pete Popov's old email address...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

 arch/mips/au1000/pb1000/Makefile      |    8 +-
 arch/mips/au1000/pb1000/board_setup.c |  110 +++++++++++++++++-----------------
 arch/mips/au1000/pb1000/init.c        |   20 ++----
 include/asm-mips/mach-pb1x00/pb1000.h |  104 +++++++++++++++-----------------
 4 files changed, 121 insertions(+), 121 deletions(-)

Index: linux-2.6/arch/mips/au1000/pb1000/Makefile
===================================================================
--- linux-2.6.orig/arch/mips/au1000/pb1000/Makefile
+++ linux-2.6/arch/mips/au1000/pb1000/Makefile
@@ -1,8 +1,8 @@
 #
-#  Copyright 2000 MontaVista Software Inc.
-#  Author: MontaVista Software, Inc.
-#     	ppopov@mvista.com or source@mvista.com
+#  Copyright 2000, 2008 MontaVista Software Inc.
+#  Author: MontaVista Software, Inc. <source@mvista.com>
+#
+# Makefile for the Alchemy Semiconductor Pb1000 board.
 #
-# Makefile for the Alchemy Semiconductor PB1000 board.
 
 lib-y := init.o board_setup.o irqmap.o
Index: linux-2.6/arch/mips/au1000/pb1000/board_setup.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/pb1000/board_setup.c
+++ linux-2.6/arch/mips/au1000/pb1000/board_setup.c
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
@@ -40,121 +39,126 @@ void __init board_setup(void)
 	u32 sys_freqctrl, sys_clksrc;
 	u32 prid = read_c0_prid();
 
-	// set AUX clock to 12MHz * 8 = 96 MHz
+	/* Set AUX clock to 12 MHz * 8 = 96 MHz */
 	au_writel(8, SYS_AUXPLL);
 	au_writel(0, SYS_PINSTATERD);
 	udelay(100);
 
 #if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
-	/* zero and disable FREQ2 */
+	/* Zero and disable FREQ2 */
 	sys_freqctrl = au_readl(SYS_FREQCTRL0);
 	sys_freqctrl &= ~0xFFF00000;
 	au_writel(sys_freqctrl, SYS_FREQCTRL0);
 
-	/* zero and disable USBH/USBD clocks */
+	/* Zero and disable USBH/USBD clocks */
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
 
-	switch (prid & 0x000000FF)
-	{
+	switch (prid & 0x000000FF) {
 	case 0x00: /* DA */
 	case 0x01: /* HA */
 	case 0x02: /* HB */
-	/* CPU core freq to 48MHz to slow it way down... */
-	au_writel(4, SYS_CPUPLL);
+		/* CPU core freq to 48 MHz to slow it way down... */
+		au_writel(4, SYS_CPUPLL);
 
-	/*
-	 * Setup 48MHz FREQ2 from CPUPLL for USB Host
-	 */
-	/* FRDIV2=3 -> div by 8 of 384MHz -> 48MHz */
-	sys_freqctrl |= ((3<<22) | (1<<21) | (0<<20));
-	au_writel(sys_freqctrl, SYS_FREQCTRL0);
+		/*
+		 * Setup 48 MHz FREQ2 from CPUPLL for USB Host
+		 * FRDIV2 = 3 -> div by 8 of 384 MHz -> 48 MHz
+		 */
+		sys_freqctrl |= (3 << SYS_FC_FRDIV2_BIT) | SYS_FC_FE2;
+		au_writel(sys_freqctrl, SYS_FREQCTRL0);
 
-	/* CPU core freq to 384MHz */
-	au_writel(0x20, SYS_CPUPLL);
+		/* CPU core freq to 384 MHz */
+		au_writel(0x20, SYS_CPUPLL);
 
-	printk("Au1000: 48MHz OHCI workaround enabled\n");
+		printk(KERN_INFO "Au1000: 48 MHz OHCI workaround enabled\n");
 		break;
 
-	default:  /* HC and newer */
-	// FREQ2 = aux/2 = 48 MHz
-	sys_freqctrl |= ((0<<22) | (1<<21) | (1<<20));
-	au_writel(sys_freqctrl, SYS_FREQCTRL0);
+	default: /* HC and newer */
+		/* FREQ2 = aux / 2 = 48 MHz */
+		sys_freqctrl |= (0 << SYS_FC_FRDIV2_BIT) |
+				SYS_FC_FE2 | SYS_FC_FS2;
+		au_writel(sys_freqctrl, SYS_FREQCTRL0);
 		break;
 	}
 
 	/*
-	 * Route 48MHz FREQ2 into USB Host and/or Device
+	 * Route 48 MHz FREQ2 into USB Host and/or Device
 	 */
-#if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
-	sys_clksrc |= ((4<<12) | (0<<11) | (0<<10));
-#endif
+	sys_clksrc |= SYS_CS_MUX_FQ2 << SYS_CS_MUH_BIT;
 	au_writel(sys_clksrc, SYS_CLKSRC);
 
-	// configure pins GPIO[14:9] as GPIO
-	pin_func = au_readl(SYS_PINFUNC) & (u32)(~0x8080);
+	/* Configure pins GPIO[14:9] as GPIO */
+	pin_func = au_readl(SYS_PINFUNC) & ~(SYS_PF_UR3 | SYS_PF_USB);
 
-	// 2nd USB port is USB host
-	pin_func |= 0x8000;
+	/* 2nd USB port is USB host */
+	pin_func |= SYS_PF_USB;
 
 	au_writel(pin_func, SYS_PINFUNC);
 	au_writel(0x2800, SYS_TRIOUTCLR);
 	au_writel(0x0030, SYS_OUTPUTCLR);
 #endif /* defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE) */
 
-	// make gpio 15 an input (for interrupt line)
-	pin_func = au_readl(SYS_PINFUNC) & (u32)(~0x100);
-	// we don't need I2S, so make it available for GPIO[31:29]
-	pin_func |= (1<<5);
+	/* Make GPIO 15 an input (for interrupt line) */
+	pin_func = au_readl(SYS_PINFUNC) & ~SYS_PF_IRF;
+	/* We don't need I2S, so make it available for GPIO[31:29] */
+	pin_func |= SYS_PF_I2S;
 	au_writel(pin_func, SYS_PINFUNC);
 
 	au_writel(0x8000, SYS_TRIOUTCLR);
 
-	static_cfg0 = au_readl(MEM_STCFG0) & (u32)(~0xc00);
+	static_cfg0 = au_readl(MEM_STCFG0) & ~0xc00;
 	au_writel(static_cfg0, MEM_STCFG0);
 
-	// configure RCE2* for LCD
+	/* configure RCE2* for LCD */
 	au_writel(0x00000004, MEM_STCFG2);
 
-	// MEM_STTIME2
+	/* MEM_STTIME2 */
 	au_writel(0x09000000, MEM_STTIME2);
 
-	// Set 32-bit base address decoding for RCE2*
+	/* Set 32-bit base address decoding for RCE2* */
 	au_writel(0x10003ff0, MEM_STADDR2);
 
-	// PCI CPLD setup
-	// expand CE0 to cover PCI
+	/*
+	 * PCI CPLD setup
+	 * Expand CE0 to cover PCI
+	 */
 	au_writel(0x11803e40, MEM_STADDR1);
 
-	// burst visibility on
+	/* Burst visibility on */
 	au_writel(au_readl(MEM_STCFG0) | 0x1000, MEM_STCFG0);
 
-	au_writel(0x83, MEM_STCFG1);         // ewait enabled, flash timing
-	au_writel(0x33030a10, MEM_STTIME1);   // slower timing for FPGA
+	au_writel(0x83, MEM_STCFG1);         /* ewait enabled, flash timing */
+	au_writel(0x33030a10, MEM_STTIME1);  /* slower timing for FPGA */
 
-	/* setup the static bus controller */
+	/* Setup the static bus controller */
 	au_writel(0x00000002, MEM_STCFG3);  /* type = PCMCIA */
 	au_writel(0x280E3D07, MEM_STTIME3); /* 250ns cycle time */
 	au_writel(0x10000000, MEM_STADDR3); /* any PCMCIA select */
 
-	/* Enable Au1000 BCLK switching - note: sed1356 must not use
-	 * its BCLK (Au1000 LCLK) for any timings */
-	switch (prid & 0x000000FF)
-	{
+	/*
+	 * Enable Au1000 BCLK switching - note: sed1356 must not use
+	 * its BCLK (Au1000 LCLK) for any timings
+	 */
+	switch (prid & 0x000000FF) {
 	case 0x00: /* DA */
 	case 0x01: /* HA */
 	case 0x02: /* HB */
 		break;
 	default:  /* HC and newer */
-		/* Enable sys bus clock divider when IDLE state or no bus
-		   activity. */
+		/*
+		 * Enable sys bus clock divider when IDLE state or no bus
+		 * activity.
+		 */
 		au_writel(au_readl(SYS_POWERCTRL) | (0x3 << 5), SYS_POWERCTRL);
 		break;
 	}
Index: linux-2.6/arch/mips/au1000/pb1000/init.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/pb1000/init.c
+++ linux-2.6/arch/mips/au1000/pb1000/init.c
@@ -1,10 +1,9 @@
 /*
  * BRIEF MODULE DESCRIPTION
- *	PB1000 board setup
+ *	Pb1000 board setup
  *
- * Copyright 2001 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *         	ppopov@mvista.com or source@mvista.com
+ * Copyright 2001, 2008 MontaVista Software Inc.
+ * Author: MontaVista Software, Inc. <source@mvista.com>
  *
  *  This program is free software; you can redistribute  it and/or modify it
  *  under  the terms of  the GNU General  Public License as published by the
@@ -44,16 +43,15 @@ void __init prom_init(void)
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
Index: linux-2.6/include/asm-mips/mach-pb1x00/pb1000.h
===================================================================
--- linux-2.6.orig/include/asm-mips/mach-pb1x00/pb1000.h
+++ linux-2.6/include/asm-mips/mach-pb1x00/pb1000.h
@@ -1,9 +1,8 @@
 /*
- * Alchemy Semi PB1000 Referrence Board
+ * Alchemy Semi Pb1000 Referrence Board
  *
- * Copyright 2001 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *         	ppopov@mvista.com or source@mvista.com
+ * Copyright 2001, 2008 MontaVista Software Inc.
+ * Author: MontaVista Software, Inc. <source@mvista.com>
  *
  * ########################################################################
  *
@@ -28,62 +27,61 @@
 #define __ASM_PB1000_H
 
 /* PCMCIA PB1000 specific defines */
-#define PCMCIA_MAX_SOCK 1
-#define PCMCIA_NUM_SOCKS (PCMCIA_MAX_SOCK+1)
+#define PCMCIA_MAX_SOCK  1
+#define PCMCIA_NUM_SOCKS (PCMCIA_MAX_SOCK + 1)
 
-#define PB1000_PCR     0xBE000000
-#  define PCR_SLOT_0_VPP0  (1<<0)
-#  define PCR_SLOT_0_VPP1  (1<<1)
-#  define PCR_SLOT_0_VCC0  (1<<2)
-#  define PCR_SLOT_0_VCC1  (1<<3)
-#  define PCR_SLOT_0_RST   (1<<4)
-
-#  define PCR_SLOT_1_VPP0  (1<<8)
-#  define PCR_SLOT_1_VPP1  (1<<9)
-#  define PCR_SLOT_1_VCC0  (1<<10)
-#  define PCR_SLOT_1_VCC1  (1<<11)
-#  define PCR_SLOT_1_RST   (1<<12)
-
-#define PB1000_MDR     0xBE000004
-#  define MDR_PI        (1<<5)  /* pcmcia int latch  */
-#  define MDR_EPI      (1<<14)  /* enable pcmcia int */
-#  define MDR_CPI      (1<<15)  /* clear pcmcia int  */
-
-#define PB1000_ACR1    0xBE000008
-#  define ACR1_SLOT_0_CD1    (1<<0)  /* card detect 1     */
-#  define ACR1_SLOT_0_CD2    (1<<1)  /* card detect 2     */
-#  define ACR1_SLOT_0_READY  (1<<2)  /* ready             */
-#  define ACR1_SLOT_0_STATUS (1<<3)  /* status change     */
-#  define ACR1_SLOT_0_VS1    (1<<4)  /* voltage sense 1   */
-#  define ACR1_SLOT_0_VS2    (1<<5)  /* voltage sense 2   */
-#  define ACR1_SLOT_0_INPACK (1<<6)  /* inpack pin status */
-#  define ACR1_SLOT_1_CD1    (1<<8)  /* card detect 1     */
-#  define ACR1_SLOT_1_CD2    (1<<9)  /* card detect 2     */
-#  define ACR1_SLOT_1_READY  (1<<10) /* ready             */
-#  define ACR1_SLOT_1_STATUS (1<<11) /* status change     */
-#  define ACR1_SLOT_1_VS1    (1<<12) /* voltage sense 1   */
-#  define ACR1_SLOT_1_VS2    (1<<13) /* voltage sense 2   */
-#  define ACR1_SLOT_1_INPACK (1<<14) /* inpack pin status */
-
-#define CPLD_AUX0      0xBE00000C
-#define CPLD_AUX1      0xBE000010
-#define CPLD_AUX2      0xBE000014
+#define PB1000_PCR		0xBE000000
+#  define PCR_SLOT_0_VPP0	(1 << 0)
+#  define PCR_SLOT_0_VPP1	(1 << 1)
+#  define PCR_SLOT_0_VCC0	(1 << 2)
+#  define PCR_SLOT_0_VCC1	(1 << 3)
+#  define PCR_SLOT_0_RST	(1 << 4)
+#  define PCR_SLOT_1_VPP0	(1 << 8)
+#  define PCR_SLOT_1_VPP1	(1 << 9)
+#  define PCR_SLOT_1_VCC0	(1 << 10)
+#  define PCR_SLOT_1_VCC1	(1 << 11)
+#  define PCR_SLOT_1_RST	(1 << 12)
+
+#define PB1000_MDR		0xBE000004
+#  define MDR_PI		(1 << 5)	/* PCMCIA int latch  */
+#  define MDR_EPI		(1 << 14)	/* enable PCMCIA int */
+#  define MDR_CPI		(1 << 15)	/* clear  PCMCIA int  */
+
+#define PB1000_ACR1		0xBE000008
+#  define ACR1_SLOT_0_CD1	(1 << 0)	/* card detect 1	*/
+#  define ACR1_SLOT_0_CD2	(1 << 1)	/* card detect 2	*/
+#  define ACR1_SLOT_0_READY	(1 << 2)	/* ready		*/
+#  define ACR1_SLOT_0_STATUS	(1 << 3)	/* status change	*/
+#  define ACR1_SLOT_0_VS1	(1 << 4)	/* voltage sense 1	*/
+#  define ACR1_SLOT_0_VS2	(1 << 5)	/* voltage sense 2	*/
+#  define ACR1_SLOT_0_INPACK	(1 << 6)	/* inpack pin status	*/
+#  define ACR1_SLOT_1_CD1	(1 << 8)	/* card detect 1	*/
+#  define ACR1_SLOT_1_CD2	(1 << 9)	/* card detect 2	*/
+#  define ACR1_SLOT_1_READY	(1 << 10)	/* ready		*/
+#  define ACR1_SLOT_1_STATUS	(1 << 11)	/* status change	*/
+#  define ACR1_SLOT_1_VS1	(1 << 12)	/* voltage sense 1	*/
+#  define ACR1_SLOT_1_VS2	(1 << 13)	/* voltage sense 2	*/
+#  define ACR1_SLOT_1_INPACK	(1 << 14)	/* inpack pin status	*/
+
+#define CPLD_AUX0		0xBE00000C
+#define CPLD_AUX1		0xBE000010
+#define CPLD_AUX2		0xBE000014
 
 /* Voltage levels */
 
 /* VPPEN1 - VPPEN0 */
-#define VPP_GND ((0<<1) | (0<<0))
-#define VPP_5V  ((1<<1) | (0<<0))
-#define VPP_3V  ((0<<1) | (1<<0))
-#define VPP_12V ((0<<1) | (1<<0))
-#define VPP_HIZ ((1<<1) | (1<<0))
+#define VPP_GND ((0 << 1) | (0 << 0))
+#define VPP_5V	((1 << 1) | (0 << 0))
+#define VPP_3V	((0 << 1) | (1 << 0))
+#define VPP_12V ((0 << 1) | (1 << 0))
+#define VPP_HIZ ((1 << 1) | (1 << 0))
 
 /* VCCEN1 - VCCEN0 */
-#define VCC_3V  ((0<<1) | (1<<0))
-#define VCC_5V  ((1<<1) | (0<<0))
-#define VCC_HIZ ((0<<1) | (0<<0))
+#define VCC_3V	((0 << 1) | (1 << 0))
+#define VCC_5V	((1 << 1) | (0 << 0))
+#define VCC_HIZ ((0 << 1) | (0 << 0))
 
 /* VPP/VCC */
-#define SET_VCC_VPP(VCC, VPP, SLOT)\
-	((((VCC)<<2) | ((VPP)<<0)) << ((SLOT)*8))
+#define SET_VCC_VPP(VCC, VPP, SLOT) \
+	((((VCC) << 2) | ((VPP) << 0)) << ((SLOT) * 8))
 #endif /* __ASM_PB1000_H */
