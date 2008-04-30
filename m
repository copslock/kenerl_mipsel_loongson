Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Apr 2008 20:27:24 +0100 (BST)
Received: from rtsoft3.corbina.net ([85.21.88.6]:61121 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S30618047AbYD3T1U (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 30 Apr 2008 20:27:20 +0100
Received: from wasted.dev.rtsoft.ru (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP
	id 170A48815; Thu,  1 May 2008 00:27:06 +0500 (SAMST)
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
To:	ralf@linux-mips.org
Subject: [PATCH 5/11] Pb1100 code style cleanup
Date:	Wed, 30 Apr 2008 23:26:28 +0400
User-Agent: KMail/1.5
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200804302326.28167.sshtylyov@ru.mvista.com>
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19059
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Fix several errors and warnings given by checkpatch.pl:

- space between asterisk and variable name;

- use of C99 // comments;

- using simple_strtol() where strict_strtol() could be used.

In addition to these changes, also do the following:

- properly indent the code;

- remove space after the type cast's closing parenthesis;

- replace numeric literals/expressions with the matching macros;

- replace spaces after the macro name with tabs in the #define directives, and
  sometimes insert spaces there;

- fix typos/errors, capitalize acronyms, etc. in the comments;

- make the multi-line comment style consistent with the kernel style elsewhere
  by adding empty first line;

- update MontaVista copyright;

- remove Pete Popov's old email address...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

 arch/mips/au1000/pb1100/Makefile      |    6 -
 arch/mips/au1000/pb1100/board_setup.c |   50 ++++++++--------
 arch/mips/au1000/pb1100/init.c        |   11 +--
 arch/mips/au1000/pb1100/irqmap.c      |   10 +--
 include/asm-mips/mach-pb1x00/pb1100.h |  104 +++++++++++++++++-----------------
 5 files changed, 91 insertions(+), 90 deletions(-)

Index: linux-2.6/arch/mips/au1000/pb1100/Makefile
===================================================================
--- linux-2.6.orig/arch/mips/au1000/pb1100/Makefile
+++ linux-2.6/arch/mips/au1000/pb1100/Makefile
@@ -1,8 +1,8 @@
 #
-#  Copyright 2000,2001 MontaVista Software Inc.
-#  Author: MontaVista Software, Inc.
-#     	ppopov@mvista.com or source@mvista.com
+#  Copyright 2000, 2001, 2008 MontaVista Software Inc.
+#  Author: MontaVista Software, Inc. <source@mvista.com>
 #
 # Makefile for the Alchemy Semiconductor Pb1100 board.
+#
 
 lib-y := init.o board_setup.o irqmap.o
Index: linux-2.6/arch/mips/au1000/pb1100/board_setup.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/pb1100/board_setup.c
+++ linux-2.6/arch/mips/au1000/pb1100/board_setup.c
@@ -1,7 +1,6 @@
 /*
- * Copyright 2002 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *         	ppopov@mvista.com or source@mvista.com
+ * Copyright 2002, 2008 MontaVista Software Inc.
+ * Author: MontaVista Software, Inc. <source@mvista.com>
  *
  *  This program is free software; you can redistribute  it and/or modify it
  *  under  the terms of  the GNU General  Public License as published by the
@@ -32,15 +31,15 @@
 
 void board_reset(void)
 {
-    /* Hit BCSR.SYSTEM_CONTROL[SW_RST] */
-    au_writel(0x00000000, 0xAE00001C);
+	/* Hit BCSR.RST_VDDI[SOFT_RESET] */
+	au_writel(0x00000000, PB1100_RST_VDDI);
 }
 
 void __init board_setup(void)
 {
-	volatile void __iomem * base = (volatile void __iomem *) 0xac000000UL;
+	volatile void __iomem *base = (volatile void __iomem *)0xac000000UL;
 
-	// set AUX clock to 12MHz * 8 = 96 MHz
+	/* Set AUX clock to 12 MHz * 8 = 96 MHz */
 	au_writel(8, SYS_AUXPLL);
 	au_writel(0, SYS_PININPUTEN);
 	udelay(100);
@@ -49,44 +48,47 @@ void __init board_setup(void)
 	{
 		u32 pin_func, sys_freqctrl, sys_clksrc;
 
-		// configure pins GPIO[14:9] as GPIO
-		pin_func = au_readl(SYS_PINFUNC) & (u32)(~0x80);
+		/* Configure pins GPIO[14:9] as GPIO */
+		pin_func = au_readl(SYS_PINFUNC) & ~SYS_PF_UR3;
 
-		/* zero and disable FREQ2 */
+		/* Zero and disable FREQ2 */
 		sys_freqctrl = au_readl(SYS_FREQCTRL0);
 		sys_freqctrl &= ~0xFFF00000;
 		au_writel(sys_freqctrl, SYS_FREQCTRL0);
 
-		/* zero and disable USBH/USBD/IrDA clock */
+		/* Zero and disable USBH/USBD/IrDA clock */
 		sys_clksrc = au_readl(SYS_CLKSRC);
-		sys_clksrc &= ~0x0000001F;
+		sys_clksrc &= ~(SYS_CS_CIR | SYS_CS_DIR | SYS_CS_MIR_MASK);
 		au_writel(sys_clksrc, SYS_CLKSRC);
 
 		sys_freqctrl = au_readl(SYS_FREQCTRL0);
 		sys_freqctrl &= ~0xFFF00000;
 
 		sys_clksrc = au_readl(SYS_CLKSRC);
-		sys_clksrc &= ~0x0000001F;
+		sys_clksrc &= ~(SYS_CS_CIR | SYS_CS_DIR | SYS_CS_MIR_MASK);
 
-		// FREQ2 = aux/2 = 48 MHz
-		sys_freqctrl |= ((0<<22) | (1<<21) | (1<<20));
+		/* FREQ2 = aux / 2 = 48 MHz */
+		sys_freqctrl |= (0 << SYS_FC_FRDIV2_BIT) |
+				SYS_FC_FE2 | SYS_FC_FS2;
 		au_writel(sys_freqctrl, SYS_FREQCTRL0);
 
 		/*
-		 * Route 48MHz FREQ2 into USBH/USBD/IrDA
+		 * Route 48 MHz FREQ2 into USBH/USBD/IrDA
 		 */
-		sys_clksrc |= ((4<<2) | (0<<1) | 0 );
+		sys_clksrc |= SYS_CS_MUX_FQ2 << SYS_CS_MIR_BIT;
 		au_writel(sys_clksrc, SYS_CLKSRC);
 
-		/* setup the static bus controller */
+		/* Setup the static bus controller */
 		au_writel(0x00000002, MEM_STCFG3);  /* type = PCMCIA */
 		au_writel(0x280E3D07, MEM_STTIME3); /* 250ns cycle time */
 		au_writel(0x10000000, MEM_STADDR3); /* any PCMCIA select */
 
-		// get USB Functionality pin state (device vs host drive pins)
-		pin_func = au_readl(SYS_PINFUNC) & (u32)(~0x8000);
-		// 2nd USB port is USB host
-		pin_func |= 0x8000;
+		/*
+		 * Get USB Functionality pin state (device vs host drive pins).
+		 */
+		pin_func = au_readl(SYS_PINFUNC) & ~SYS_PF_USB;
+		/* 2nd USB port is USB host. */
+		pin_func |= SYS_PF_USB;
 		au_writel(pin_func, SYS_PINFUNC);
 	}
 #endif /* defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE) */
@@ -94,12 +96,12 @@ void __init board_setup(void)
 	/* Enable sys bus clock divider when IDLE state or no bus activity. */
 	au_writel(au_readl(SYS_POWERCTRL) | (0x3 << 5), SYS_POWERCTRL);
 
-	// Enable the RTC if not already enabled
+	/* Enable the RTC if not already enabled. */
 	if (!(readb(base + 0x28) & 0x20)) {
 		writeb(readb(base + 0x28) | 0x20, base + 0x28);
 		au_sync();
 	}
-	// Put the clock in BCD mode
+	/* Put the clock in BCD mode. */
 	if (readb(base + 0x2C) & 0x4) { /* reg B */
 		writeb(readb(base + 0x2c) & ~0x4, base + 0x2c);
 		au_sync();
Index: linux-2.6/arch/mips/au1000/pb1100/init.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/pb1100/init.c
+++ linux-2.6/arch/mips/au1000/pb1100/init.c
@@ -3,9 +3,8 @@
  * BRIEF MODULE DESCRIPTION
  *	Pb1100 board setup
  *
- * Copyright 2002 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *         	ppopov@mvista.com or source@mvista.com
+ * Copyright 2002, 2008 MontaVista Software Inc.
+ * Author: MontaVista Software, Inc. <source@mvista.com>
  *
  *  This program is free software; you can redistribute  it and/or modify it
  *  under  the terms of  the GNU General  Public License as published by the
@@ -46,8 +45,8 @@ void __init prom_init(void)
 	unsigned long memsize;
 
 	prom_argc = fw_arg0;
-	prom_argv = (char **) fw_arg1;
-	prom_envp = (char **) fw_arg3;
+	prom_argv = (char **)fw_arg1;
+	prom_envp = (char **)fw_arg3;
 
 	prom_init_cmdline();
 
@@ -55,7 +54,7 @@ void __init prom_init(void)
 	if (!memsize_str)
 		memsize = 0x04000000;
 	else
-		memsize = simple_strtol(memsize_str, NULL, 0);
+		memsize = strict_strtol(memsize_str, 0, NULL);
 
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
 }
Index: linux-2.6/arch/mips/au1000/pb1100/irqmap.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/pb1100/irqmap.c
+++ linux-2.6/arch/mips/au1000/pb1100/irqmap.c
@@ -1,6 +1,6 @@
 /*
  * BRIEF MODULE DESCRIPTION
- *	Au1xxx irq map table
+ *	Au1xx0 IRQ map table
  *
  * Copyright 2003 Embedded Edge, LLC
  *		dan@embeddededge.com
@@ -31,10 +31,10 @@
 #include <asm/mach-au1x00/au1000.h>
 
 struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
-	{ AU1000_GPIO_9, INTC_INT_LOW_LEVEL, 0 }, // PCMCIA Card Fully_Interted#
-	{ AU1000_GPIO_10, INTC_INT_LOW_LEVEL, 0 }, // PCMCIA Card STSCHG#
-	{ AU1000_GPIO_11, INTC_INT_LOW_LEVEL, 0 }, // PCMCIA Card IRQ#
-	{ AU1000_GPIO_13, INTC_INT_LOW_LEVEL, 0 }, // DC_IRQ#
+	{ AU1000_GPIO_9,  INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card Fully_Inserted# */
+	{ AU1000_GPIO_10, INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card STSCHG# */
+	{ AU1000_GPIO_11, INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card IRQ# */
+	{ AU1000_GPIO_13, INTC_INT_LOW_LEVEL, 0 }, /* DC_IRQ# */
 };
 
 int __initdata au1xxx_nr_irqs = ARRAY_SIZE(au1xxx_irq_map);
Index: linux-2.6/include/asm-mips/mach-pb1x00/pb1100.h
===================================================================
--- linux-2.6.orig/include/asm-mips/mach-pb1x00/pb1100.h
+++ linux-2.6/include/asm-mips/mach-pb1x00/pb1100.h
@@ -1,9 +1,8 @@
 /*
- * Alchemy Semi PB1100 Referrence Board
+ * Alchemy Semi Pb1100 Referrence Board
  *
- * Copyright 2001 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *         	ppopov@mvista.com or source@mvista.com
+ * Copyright 2001, 2008 MontaVista Software Inc.
+ * Author: MontaVista Software, Inc. <source@mvista.com>
  *
  * ########################################################################
  *
@@ -27,59 +26,60 @@
 #ifndef __ASM_PB1100_H
 #define __ASM_PB1100_H
 
-#define PB1100_IDENT          0xAE000000
-#define BOARD_STATUS_REG      0xAE000004
-#  define PB1100_ROM_SEL         (1<<15)
-#  define PB1100_ROM_SIZ         (1<<14)
-#  define PB1100_SWAP_BOOT       (1<<13)
-#  define PB1100_FLASH_WP        (1<<12)
-#  define PB1100_ROM_H_STS       (1<<11)
-#  define PB1100_ROM_L_STS       (1<<10)
-#  define PB1100_FLASH_H_STS      (1<<9)
-#  define PB1100_FLASH_L_STS      (1<<8)
-#  define PB1100_SRAM_SIZ         (1<<7)
-#  define PB1100_TSC_BUSY         (1<<6)
-#  define PB1100_PCMCIA_VS_MASK   (3<<4)
-#  define PB1100_RS232_CD         (1<<3)
-#  define PB1100_RS232_CTS        (1<<2)
-#  define PB1100_RS232_DSR        (1<<1)
-#  define PB1100_RS232_RI         (1<<0)
-
-#define PB1100_IRDA_RS232     0xAE00000C
-#  define PB1100_IRDA_FULL       (0<<14) /* full power */
-#  define PB1100_IRDA_SHUTDOWN   (1<<14)
-#  define PB1100_IRDA_TT         (2<<14) /* 2/3 power */
-#  define PB1100_IRDA_OT         (3<<14) /* 1/3 power */
-#  define PB1100_IRDA_FIR        (1<<13)
-
-#define PCMCIA_BOARD_REG     0xAE000010
-#  define PB1100_SD_WP1_RO       (1<<15) /* read only */
-#  define PB1100_SD_WP0_RO       (1<<14) /* read only */
-#  define PB1100_SD_PWR1         (1<<11) /* applies power to SD1 */
-#  define PB1100_SD_PWR0         (1<<10) /* applies power to SD0 */
-#  define PB1100_SEL_SD_CONN1     (1<<9)
-#  define PB1100_SEL_SD_CONN0     (1<<8)
-#  define PC_DEASSERT_RST         (1<<7)
-#  define PC_DRV_EN               (1<<4)
-
-#define PB1100_G_CONTROL      0xAE000014 /* graphics control */
-
-#define PB1100_RST_VDDI       0xAE00001C
-#  define PB1100_SOFT_RESET      (1<<15) /* clear to reset the board */
-#  define PB1100_VDDI_MASK        (0x1F)
+#define PB1100_IDENT		0xAE000000
+#define BOARD_STATUS_REG	0xAE000004
+#  define PB1100_ROM_SEL	(1 << 15)
+#  define PB1100_ROM_SIZ	(1 << 14)
+#  define PB1100_SWAP_BOOT	(1 << 13)
+#  define PB1100_FLASH_WP	(1 << 12)
+#  define PB1100_ROM_H_STS	(1 << 11)
+#  define PB1100_ROM_L_STS	(1 << 10)
+#  define PB1100_FLASH_H_STS	(1 << 9)
+#  define PB1100_FLASH_L_STS	(1 << 8)
+#  define PB1100_SRAM_SIZ	(1 << 7)
+#  define PB1100_TSC_BUSY	(1 << 6)
+#  define PB1100_PCMCIA_VS_MASK (3 << 4)
+#  define PB1100_RS232_CD	(1 << 3)
+#  define PB1100_RS232_CTS	(1 << 2)
+#  define PB1100_RS232_DSR	(1 << 1)
+#  define PB1100_RS232_RI	(1 << 0)
+
+#define PB1100_IRDA_RS232	0xAE00000C
+#  define PB1100_IRDA_FULL	(0 << 14)	/* full power		*/
+#  define PB1100_IRDA_SHUTDOWN	(1 << 14)
+#  define PB1100_IRDA_TT	(2 << 14)	/* 2/3 power		*/
+#  define PB1100_IRDA_OT	(3 << 14)	/* 1/3 power		*/
+#  define PB1100_IRDA_FIR	(1 << 13)
+
+#define PCMCIA_BOARD_REG	0xAE000010
+#  define PB1100_SD_WP1_RO	(1 << 15)	/* read only		*/
+#  define PB1100_SD_WP0_RO	(1 << 14)	/* read only		*/
+#  define PB1100_SD_PWR1	(1 << 11)	/* applies power to SD1 */
+#  define PB1100_SD_PWR0	(1 << 10)	/* applies power to SD0 */
+#  define PB1100_SEL_SD_CONN1	(1 << 9)
+#  define PB1100_SEL_SD_CONN0	(1 << 8)
+#  define PC_DEASSERT_RST	(1 << 7)
+#  define PC_DRV_EN		(1 << 4)
+
+#define PB1100_G_CONTROL	0xAE000014	/* graphics control	*/
+
+#define PB1100_RST_VDDI 	0xAE00001C
+#  define PB1100_SOFT_RESET	(1 << 15)	/* clear to reset the board */
+#  define PB1100_VDDI_MASK	0x1F
 
-#define PB1100_LEDS           0xAE000018
+#define PB1100_LEDS		0xAE000018
 
-/* 11:8 is 4 discreet LEDs. Clearing a bit illuminates the LED.
- * 7:0 is the LED Display's decimal points.
+/*
+ * 11:8 is 4 discreet LEDs. Clearing a bit illuminates the LED.
+ * 7:0  is the LED Display's decimal points.
  */
-#define PB1100_HEX_LED        0xAE000018
+#define PB1100_HEX_LED		0xAE000018
 
-/* PCMCIA PB1100 specific defines */
-#define PCMCIA_MAX_SOCK 0
-#define PCMCIA_NUM_SOCKS (PCMCIA_MAX_SOCK+1)
+/* PCMCIA Pb1100 specific defines */
+#define PCMCIA_MAX_SOCK  0
+#define PCMCIA_NUM_SOCKS (PCMCIA_MAX_SOCK + 1)
 
 /* VPP/VCC */
-#define SET_VCC_VPP(VCC, VPP) (((VCC)<<2) | ((VPP)<<0))
+#define SET_VCC_VPP(VCC, VPP) (((VCC) << 2) | ((VPP) << 0))
 
 #endif /* __ASM_PB1100_H */
