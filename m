Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Apr 2008 20:31:01 +0100 (BST)
Received: from rtsoft3.corbina.net ([85.21.88.6]:64961 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S30617781AbYD3Ta4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 30 Apr 2008 20:30:56 +0100
Received: from wasted.dev.rtsoft.ru (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP
	id 3E4B78816; Thu,  1 May 2008 00:30:50 +0500 (SAMST)
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
To:	ralf@linux-mips.org
Subject: [PATCH 10/11] MTX-1 code style cleanup
Date:	Wed, 30 Apr 2008 23:30:12 +0400
User-Agent: KMail/1.5
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200804302330.12345.sshtylyov@ru.mvista.com>
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19063
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Fix many errors and warnings given by checkpatch.pl:

- space after opening and before closing parentheses;

- use of C99 // comments;

- leading spaces instead of tabs;

- brace not on the same line with 'else' in the 'if' statement;
  statement;

- printk() without KERN_* facility level;

- using simple_strtol() where strict_strtol() could be used.

- including <asm/gpio.h> instead of <linux/gpio.h>.

In addition to these changes, also do the following:

- insert spaces between operator and its operands;

- replace tab between the function type and name with space in mtx1_pci_idsel()
  declaration;

- remove space after the type cast's closing parenthesis;

- insert missing space before closing brace in the array/structure initializers;

- update MontaVista copyright;

- remove Pete Popov's old email address...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

 arch/mips/au1000/mtx-1/Makefile      |    3 -
 arch/mips/au1000/mtx-1/board_setup.c |   65 ++++++++++++++++-------------------
 arch/mips/au1000/mtx-1/init.c        |   11 ++---
 arch/mips/au1000/mtx-1/irqmap.c      |   18 ++++-----
 arch/mips/au1000/mtx-1/platform.c    |    3 -
 5 files changed, 47 insertions(+), 53 deletions(-)

Index: linux-2.6/arch/mips/au1000/mtx-1/Makefile
===================================================================
--- linux-2.6.orig/arch/mips/au1000/mtx-1/Makefile
+++ linux-2.6/arch/mips/au1000/mtx-1/Makefile
@@ -1,7 +1,6 @@
 #
 #  Copyright 2003 MontaVista Software Inc.
-#  Author: MontaVista Software, Inc.
-#     	ppopov@mvista.com or source@mvista.com
+#  Author: MontaVista Software, Inc. <source@mvista.com>
 #       Bruno Randolf <bruno.randolf@4g-systems.biz>
 #
 # Makefile for 4G Systems MTX-1 board.
Index: linux-2.6/arch/mips/au1000/mtx-1/board_setup.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/mtx-1/board_setup.c
+++ linux-2.6/arch/mips/au1000/mtx-1/board_setup.c
@@ -3,9 +3,8 @@
  * BRIEF MODULE DESCRIPTION
  *	4G Systems MTX-1 board setup.
  *
- * Copyright 2003 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *         	ppopov@mvista.com or source@mvista.com
+ * Copyright 2003, 2008 MontaVista Software Inc.
+ * Author: MontaVista Software, Inc. <source@mvista.com>
  *         Bruno Randolf <bruno.randolf@4g-systems.biz>
  *
  *  This program is free software; you can redistribute  it and/or modify it
@@ -34,7 +33,7 @@
 #include <asm/mach-au1x00/au1000.h>
 
 extern int (*board_pci_idsel)(unsigned int devsel, int assert);
-int    mtx1_pci_idsel(unsigned int devsel, int assert);
+int mtx1_pci_idsel(unsigned int devsel, int assert);
 
 void board_reset(void)
 {
@@ -45,36 +44,36 @@ void board_reset(void)
 void __init board_setup(void)
 {
 #if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
-	// enable USB power switch
-	au_writel( au_readl(GPIO2_DIR) | 0x10, GPIO2_DIR );
-	au_writel( 0x100000, GPIO2_OUTPUT );
+	/* Enable USB power switch */
+	au_writel(au_readl(GPIO2_DIR) | 0x10, GPIO2_DIR);
+	au_writel(0x100000, GPIO2_OUTPUT);
 #endif /* defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE) */
 
 #ifdef CONFIG_PCI
 #if defined(__MIPSEB__)
-	au_writel(0xf | (2<<6) | (1<<4), Au1500_PCI_CFG);
+	au_writel(0xf | (2 << 6) | (1 << 4), Au1500_PCI_CFG);
 #else
 	au_writel(0xf, Au1500_PCI_CFG);
 #endif
 #endif
 
-	// initialize sys_pinfunc:
-	au_writel( SYS_PF_NI2, SYS_PINFUNC );
+	/* Initialize sys_pinfunc */
+	au_writel(SYS_PF_NI2, SYS_PINFUNC);
 
-	// initialize GPIO
-	au_writel( 0xFFFFFFFF, SYS_TRIOUTCLR );
-	au_writel( 0x00000001, SYS_OUTPUTCLR ); // set M66EN (PCI 66MHz) to OFF
-	au_writel( 0x00000008, SYS_OUTPUTSET ); // set PCI CLKRUN# to OFF
-	au_writel( 0x00000002, SYS_OUTPUTSET ); // set EXT_IO3 ON
-	au_writel( 0x00000020, SYS_OUTPUTCLR ); // set eth PHY TX_ER to OFF
-
-	// enable LED and set it to green
-	au_writel( au_readl(GPIO2_DIR) | 0x1800, GPIO2_DIR );
-	au_writel( 0x18000800, GPIO2_OUTPUT );
+	/* Initialize GPIO */
+	au_writel(0xFFFFFFFF, SYS_TRIOUTCLR);
+	au_writel(0x00000001, SYS_OUTPUTCLR); /* set M66EN (PCI 66MHz) to OFF */
+	au_writel(0x00000008, SYS_OUTPUTSET); /* set PCI CLKRUN# to OFF */
+	au_writel(0x00000002, SYS_OUTPUTSET); /* set EXT_IO3 ON */
+	au_writel(0x00000020, SYS_OUTPUTCLR); /* set eth PHY TX_ER to OFF */
+
+	/* Enable LED and set it to green */
+	au_writel(au_readl(GPIO2_DIR) | 0x1800, GPIO2_DIR);
+	au_writel(0x18000800, GPIO2_OUTPUT);
 
 	board_pci_idsel = mtx1_pci_idsel;
 
-	printk("4G Systems MTX-1 Board\n");
+	printk(KERN_INFO "4G Systems MTX-1 Board\n");
 }
 
 int
@@ -82,20 +81,18 @@ mtx1_pci_idsel(unsigned int devsel, int 
 {
 #define MTX_IDSEL_ONLY_0_AND_3 0
 #if MTX_IDSEL_ONLY_0_AND_3
-       if (devsel != 0 && devsel != 3) {
-               printk("*** not 0 or 3\n");
-               return 0;
-       }
+	if (devsel != 0 && devsel != 3) {
+		printk(KERN_ERR "*** not 0 or 3\n");
+		return 0;
+	}
 #endif
 
-       if (assert && devsel != 0) {
-               // suppress signal to cardbus
-               au_writel( 0x00000002, SYS_OUTPUTCLR ); // set EXT_IO3 OFF
-       }
-       else {
-               au_writel( 0x00000002, SYS_OUTPUTSET ); // set EXT_IO3 ON
-       }
-       au_sync_udelay(1);
-       return 1;
+	if (assert && devsel != 0)
+		/* Suppress signal to Cardbus */
+		au_writel(0x00000002, SYS_OUTPUTCLR); /* set EXT_IO3 OFF */
+	else
+		au_writel(0x00000002, SYS_OUTPUTSET); /* set EXT_IO3 ON */
+	au_sync_udelay(1);
+	return 1;
 }
 
Index: linux-2.6/arch/mips/au1000/mtx-1/init.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/mtx-1/init.c
+++ linux-2.6/arch/mips/au1000/mtx-1/init.c
@@ -3,9 +3,8 @@
  * BRIEF MODULE DESCRIPTION
  *	4G Systems MTX-1 board setup
  *
- * Copyright 2003 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *         	ppopov@mvista.com or source@mvista.com
+ * Copyright 2003, 2008 MontaVista Software Inc.
+ * Author: MontaVista Software, Inc. <source@mvista.com>
  *         Bruno Randolf <bruno.randolf@4g-systems.biz>
  *
  *  This program is free software; you can redistribute  it and/or modify it
@@ -47,8 +46,8 @@ void __init prom_init(void)
 	unsigned long memsize;
 
 	prom_argc = fw_arg0;
-	prom_argv = (char **) fw_arg1;
-	prom_envp = (char **) fw_arg2;
+	prom_argv = (char **)fw_arg1;
+	prom_envp = (char **)fw_arg2;
 
 	prom_init_cmdline();
 
@@ -56,6 +55,6 @@ void __init prom_init(void)
 	if (!memsize_str)
 		memsize = 0x04000000;
 	else
-		memsize = simple_strtol(memsize_str, NULL, 0);
+		memsize = strict_strtol(memsize_str, 0, NULL);
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
 }
Index: linux-2.6/arch/mips/au1000/mtx-1/irqmap.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/mtx-1/irqmap.c
+++ linux-2.6/arch/mips/au1000/mtx-1/irqmap.c
@@ -31,18 +31,18 @@
 #include <asm/mach-au1x00/au1000.h>
 
 char irq_tab_alchemy[][5] __initdata = {
- [0] = { -1, INTA, INTA, INTX, INTX},   /* IDSEL 00 - AdapterA-Slot0 (top)    */
- [1] = { -1, INTB, INTA, INTX, INTX},   /* IDSEL 01 - AdapterA-Slot1 (bottom) */
- [2] = { -1, INTC, INTD, INTX, INTX},   /* IDSEL 02 - AdapterB-Slot0 (top)    */
- [3] = { -1, INTD, INTC, INTX, INTX},   /* IDSEL 03 - AdapterB-Slot1 (bottom) */
- [4] = { -1, INTA, INTB, INTX, INTX},   /* IDSEL 04 - AdapterC-Slot0 (top)    */
- [5] = { -1, INTB, INTA, INTX, INTX},   /* IDSEL 05 - AdapterC-Slot1 (bottom) */
- [6] = { -1, INTC, INTD, INTX, INTX},   /* IDSEL 06 - AdapterD-Slot0 (top)    */
- [7] = { -1, INTD, INTC, INTX, INTX},   /* IDSEL 07 - AdapterD-Slot1 (bottom) */
+	[0] = { -1, INTA, INTA, INTX, INTX }, /* IDSEL 00 - AdapterA-Slot0 (top) */
+	[1] = { -1, INTB, INTA, INTX, INTX }, /* IDSEL 01 - AdapterA-Slot1 (bottom) */
+	[2] = { -1, INTC, INTD, INTX, INTX }, /* IDSEL 02 - AdapterB-Slot0 (top) */
+	[3] = { -1, INTD, INTC, INTX, INTX }, /* IDSEL 03 - AdapterB-Slot1 (bottom) */
+	[4] = { -1, INTA, INTB, INTX, INTX }, /* IDSEL 04 - AdapterC-Slot0 (top) */
+	[5] = { -1, INTB, INTA, INTX, INTX }, /* IDSEL 05 - AdapterC-Slot1 (bottom) */
+	[6] = { -1, INTC, INTD, INTX, INTX }, /* IDSEL 06 - AdapterD-Slot0 (top) */
+	[7] = { -1, INTD, INTC, INTX, INTX }, /* IDSEL 07 - AdapterD-Slot1 (bottom) */
 };
 
 struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
-       { AU1500_GPIO_204, INTC_INT_HIGH_LEVEL, 0},
+       { AU1500_GPIO_204, INTC_INT_HIGH_LEVEL, 0 },
        { AU1500_GPIO_201, INTC_INT_LOW_LEVEL, 0 },
        { AU1500_GPIO_202, INTC_INT_LOW_LEVEL, 0 },
        { AU1500_GPIO_203, INTC_INT_LOW_LEVEL, 0 },
Index: linux-2.6/arch/mips/au1000/mtx-1/platform.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/mtx-1/platform.c
+++ linux-2.6/arch/mips/au1000/mtx-1/platform.c
@@ -21,11 +21,10 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/leds.h>
+#include <linux/gpio.h>
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
 
-#include <asm/gpio.h>
-
 static struct gpio_keys_button mtx1_gpio_button[] = {
 	{
 		.gpio = 207,
