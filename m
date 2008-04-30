Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Apr 2008 20:29:53 +0100 (BST)
Received: from rtsoft3.corbina.net ([85.21.88.6]:63681 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S30617598AbYD3T3t (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 30 Apr 2008 20:29:49 +0100
Received: from wasted.dev.rtsoft.ru (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP
	id 1A3BE8816; Thu,  1 May 2008 00:29:42 +0500 (SAMST)
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
To:	ralf@linux-mips.org
Subject: [PATCH 7/11] Pb1200/DBAu1200 code style cleanup
Date:	Wed, 30 Apr 2008 23:29:04 +0400
User-Agent: KMail/1.5
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200804302329.04189.sshtylyov@ru.mvista.com>
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19062
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Fix several errors and warnings given by checkpatch.pl:

- use of C99 // comments;

- initialization of a 'static' variable to 0;

- space after opening and before closing parentheses;

- missing space between 'for' and opening parenthesis;

- macros with complex values not enclosed in parentheses;

- printk() without KERN_* facility level;

- unnecessary braces for single-statement block;

- using simple_strtol() where strict_strtol() could be used;

- line over 80 characters.

In addition to these changes, also do the following:

- mention DBAu1200 board in the Makefile;

- replace the group of #include/#ifdef directives by single #include <au1xxx.h>
  since this header contains the needed stuff;

- properly indent the blocks;

- insert spaces between operator and its operands, remove excess spaces there;

- remove needless parentheses and add some for clarity;

- replace numeric literals/expressions with the matching macros;

- remove space after the type cast's closing parenthesis;

- reduce pb1200_setup_cascade() to the single 'return' statement;

- reduce the number of printed empty lines in the so-called CPLD workaround;

- remove #undef AU1X00_EXTERNAL_INT since that macro is not defined anywhere;

- replace spaces after the macro name with tabs in the #define directives;

- remove excess tabs after the macro name in the #define directives;

- fix typo in the BCSR_RESETS_PWMR1mUX macro's name;

- group all Pb1200 PCMCIA definitions together;

- put the function's result type and name/parameters on the same line;

- insert missing and remove excess new lines;

- make the multi-line comment style consistent with the kernel style elsewhere
  by adding empty first line and/or adding space/asterisk on their left side;

- fix typos/errors, capitalize acronyms, etc. in the comments;

- combine some comments;

- update MontaVista copyright;

- remove Pete Popov's old email address...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

 arch/mips/au1000/pb1200/Makefile      |    2 
 arch/mips/au1000/pb1200/board_setup.c |  131 ++++++++++++++++------------------
 arch/mips/au1000/pb1200/init.c        |   18 ++--
 arch/mips/au1000/pb1200/irqmap.c      |   66 +++++++----------
 include/asm-mips/mach-db1x00/db1200.h |   75 +++++++++----------
 include/asm-mips/mach-pb1x00/pb1200.h |   93 +++++++++++-------------
 6 files changed, 183 insertions(+), 202 deletions(-)

Index: linux-2.6/arch/mips/au1000/pb1200/Makefile
===================================================================
--- linux-2.6.orig/arch/mips/au1000/pb1200/Makefile
+++ linux-2.6/arch/mips/au1000/pb1200/Makefile
@@ -1,5 +1,5 @@
 #
-# Makefile for the Alchemy Semiconductor PB1200 board.
+# Makefile for the Alchemy Semiconductor Pb1200/DBAu1200 boards.
 #
 
 lib-y := init.o board_setup.o irqmap.o
Index: linux-2.6/arch/mips/au1000/pb1200/board_setup.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/pb1200/board_setup.c
+++ linux-2.6/arch/mips/au1000/pb1200/board_setup.c
@@ -27,16 +27,8 @@
 #include <linux/init.h>
 #include <linux/sched.h>
 
-#include <au1000.h>
 #include <prom.h>
-
-#ifdef CONFIG_MIPS_PB1200
-#include <asm/mach-pb1x00/pb1200.h>
-#endif
-
-#ifdef CONFIG_MIPS_DB1200
-#include <asm/mach-db1x00/db1200.h>
-#endif
+#include <au1xxx.h>
 
 extern void _board_init_irq(void);
 extern void (*board_init_irq)(void);
@@ -53,56 +45,57 @@ void __init board_setup(void)
 
 #if 0
 	{
-	u32 pin_func;
+		u32 pin_func;
 
-	/* Enable PSC1 SYNC for AC97.  Normaly done in audio driver,
-	 * but it is board specific code, so put it here.
-	 */
-	pin_func = au_readl(SYS_PINFUNC);
-	au_sync();
-	pin_func |= SYS_PF_MUST_BE_SET | SYS_PF_PSC1_S1;
-	au_writel(pin_func, SYS_PINFUNC);
+		/*
+		 * Enable PSC1 SYNC for AC97.  Normaly done in audio driver,
+		 * but it is board specific code, so put it here.
+		 */
+		pin_func = au_readl(SYS_PINFUNC);
+		au_sync();
+		pin_func |= SYS_PF_MUST_BE_SET | SYS_PF_PSC1_S1;
+		au_writel(pin_func, SYS_PINFUNC);
 
-	au_writel(0, (u32)bcsr|0x10); /* turn off pcmcia power */
-	au_sync();
+		au_writel(0, (u32)bcsr | 0x10); /* turn off PCMCIA power */
+		au_sync();
 	}
 #endif
 
 #if defined(CONFIG_I2C_AU1550)
 	{
-	u32 freq0, clksrc;
-	u32 pin_func;
-
-	/* Select SMBUS in CPLD */
-	bcsr->resets &= ~(BCSR_RESETS_PCS0MUX);
-
-	pin_func = au_readl(SYS_PINFUNC);
-	au_sync();
-	pin_func &= ~(3<<17 | 1<<4);
-	/* Set GPIOs correctly */
-	pin_func |= 2<<17;
-	au_writel(pin_func, SYS_PINFUNC);
-	au_sync();
+		u32 freq0, clksrc;
+		u32 pin_func;
 
-	/* The i2c driver depends on 50Mhz clock */
-	freq0 = au_readl(SYS_FREQCTRL0);
-	au_sync();
-	freq0 &= ~(SYS_FC_FRDIV1_MASK | SYS_FC_FS1 | SYS_FC_FE1);
-	freq0 |= (3<<SYS_FC_FRDIV1_BIT);
-	/* 396Mhz / (3+1)*2 == 49.5Mhz */
-	au_writel(freq0, SYS_FREQCTRL0);
-	au_sync();
-	freq0 |= SYS_FC_FE1;
-	au_writel(freq0, SYS_FREQCTRL0);
-	au_sync();
+		/* Select SMBus in CPLD */
+		bcsr->resets &= ~BCSR_RESETS_PCS0MUX;
 
-	clksrc = au_readl(SYS_CLKSRC);
-	au_sync();
-	clksrc &= ~0x01f00000;
-	/* bit 22 is EXTCLK0 for PSC0 */
-	clksrc |= (0x3 << 22);
-	au_writel(clksrc, SYS_CLKSRC);
-	au_sync();
+		pin_func = au_readl(SYS_PINFUNC);
+		au_sync();
+		pin_func &= ~(SYS_PINFUNC_P0A | SYS_PINFUNC_P0B);
+		/* Set GPIOs correctly */
+		pin_func |= 2 << 17;
+		au_writel(pin_func, SYS_PINFUNC);
+		au_sync();
+
+		/* The I2C driver depends on 50 MHz clock */
+		freq0 = au_readl(SYS_FREQCTRL0);
+		au_sync();
+		freq0 &= ~(SYS_FC_FRDIV1_MASK | SYS_FC_FS1 | SYS_FC_FE1);
+		freq0 |= 3 << SYS_FC_FRDIV1_BIT;
+		/* 396 MHz / (3 + 1) * 2 == 49.5 MHz */
+		au_writel(freq0, SYS_FREQCTRL0);
+		au_sync();
+		freq0 |= SYS_FC_FE1;
+		au_writel(freq0, SYS_FREQCTRL0);
+		au_sync();
+
+		clksrc = au_readl(SYS_CLKSRC);
+		au_sync();
+		clksrc &= ~(SYS_CS_CE0 | SYS_CS_DE0 | SYS_CS_ME0_MASK);
+		/* Bit 22 is EXTCLK0 for PSC0 */
+		clksrc |= SYS_CS_MUX_FQ1 << SYS_CS_ME0_BIT;
+		au_writel(clksrc, SYS_CLKSRC);
+		au_sync();
 	}
 #endif
 
@@ -116,27 +109,27 @@ void __init board_setup(void)
 #endif
 #endif
 
-	/* The Pb1200 development board uses external MUX for PSC0 to
-	support SMB/SPI. bcsr->resets bit 12: 0=SMB 1=SPI
-	*/
+	/*
+	 * The Pb1200 development board uses external MUX for PSC0 to
+	 * support SMB/SPI. bcsr->resets bit 12: 0=SMB 1=SPI
+	 */
 #ifdef CONFIG_I2C_AU1550
-	bcsr->resets &= (~BCSR_RESETS_PCS0MUX);
+	bcsr->resets &= ~BCSR_RESETS_PCS0MUX;
 #endif
 	au_sync();
 
 #ifdef CONFIG_MIPS_PB1200
-	printk("AMD Alchemy Pb1200 Board\n");
+	printk(KERN_INFO "AMD Alchemy Pb1200 Board\n");
 #endif
 #ifdef CONFIG_MIPS_DB1200
-	printk("AMD Alchemy Db1200 Board\n");
+	printk(KERN_INFO "AMD Alchemy Db1200 Board\n");
 #endif
 
 	/* Setup Pb1200 External Interrupt Controller */
 	board_init_irq = _board_init_irq;
 }
 
-int
-board_au1200fb_panel(void)
+int board_au1200fb_panel(void)
 {
 	BCSR *bcsr = (BCSR *)BCSR_KSEG1_ADDR;
 	int p;
@@ -147,23 +140,23 @@ board_au1200fb_panel(void)
 	return p;
 }
 
-int
-board_au1200fb_panel_init(void)
+int board_au1200fb_panel_init(void)
 {
 	/* Apply power */
-    BCSR *bcsr = (BCSR *)BCSR_KSEG1_ADDR;
-	bcsr->board |= (BCSR_BOARD_LCDVEE | BCSR_BOARD_LCDVDD | BCSR_BOARD_LCDBL);
-	/*printk("board_au1200fb_panel_init()\n"); */
+	BCSR *bcsr = (BCSR *)BCSR_KSEG1_ADDR;
+
+	bcsr->board |= BCSR_BOARD_LCDVEE | BCSR_BOARD_LCDVDD | BCSR_BOARD_LCDBL;
+	/* printk(KERN_DEBUG "board_au1200fb_panel_init()\n"); */
 	return 0;
 }
 
-int
-board_au1200fb_panel_shutdown(void)
+int board_au1200fb_panel_shutdown(void)
 {
 	/* Remove power */
-    BCSR *bcsr = (BCSR *)BCSR_KSEG1_ADDR;
-	bcsr->board &= ~(BCSR_BOARD_LCDVEE | BCSR_BOARD_LCDVDD | BCSR_BOARD_LCDBL);
-	/*printk("board_au1200fb_panel_shutdown()\n"); */
+	BCSR *bcsr = (BCSR *)BCSR_KSEG1_ADDR;
+
+	bcsr->board &= ~(BCSR_BOARD_LCDVEE | BCSR_BOARD_LCDVDD |
+			 BCSR_BOARD_LCDBL);
+	/* printk(KERN_DEBUG "board_au1200fb_panel_shutdown()\n"); */
 	return 0;
 }
-
Index: linux-2.6/arch/mips/au1000/pb1200/init.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/pb1200/init.c
+++ linux-2.6/arch/mips/au1000/pb1200/init.c
@@ -3,9 +3,8 @@
  * BRIEF MODULE DESCRIPTION
  *	PB1200 board setup
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
Index: linux-2.6/arch/mips/au1000/pb1200/irqmap.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/pb1200/irqmap.c
+++ linux-2.6/arch/mips/au1000/pb1200/irqmap.c
@@ -39,25 +39,25 @@
 #endif
 
 struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
-	{ AU1000_GPIO_7, INTC_INT_LOW_LEVEL, 0 }, // This is exteranl interrupt cascade
+	/* This is external interrupt cascade */
+	{ AU1000_GPIO_7, INTC_INT_LOW_LEVEL, 0 },
 };
 
 int __initdata au1xxx_nr_irqs = ARRAY_SIZE(au1xxx_irq_map);
 
 /*
- *	Support for External interrupts on the PbAu1200 Development platform.
+ * Support for External interrupts on the Pb1200 Development platform.
  */
-static volatile int pb1200_cascade_en=0;
+static volatile int pb1200_cascade_en;
 
-irqreturn_t pb1200_cascade_handler( int irq, void *dev_id)
+irqreturn_t pb1200_cascade_handler(int irq, void *dev_id)
 {
 	unsigned short bisr = bcsr->int_status;
 	int extirq_nr = 0;
 
-	/* Clear all the edge interrupts. This has no effect on level */
+	/* Clear all the edge interrupts. This has no effect on level. */
 	bcsr->int_status = bisr;
-	for( ; bisr; bisr &= (bisr-1) )
-	{
+	for ( ; bisr; bisr &= bisr - 1) {
 		extirq_nr = PB1200_INT_BEGIN + __ffs(bisr);
 		/* Ack and dispatch IRQ */
 		do_IRQ(extirq_nr);
@@ -68,26 +68,20 @@ irqreturn_t pb1200_cascade_handler( int 
 
 inline void pb1200_enable_irq(unsigned int irq_nr)
 {
-	bcsr->intset_mask = 1<<(irq_nr - PB1200_INT_BEGIN);
-	bcsr->intset = 1<<(irq_nr - PB1200_INT_BEGIN);
+	bcsr->intset_mask = 1 << (irq_nr - PB1200_INT_BEGIN);
+	bcsr->intset = 1 << (irq_nr - PB1200_INT_BEGIN);
 }
 
 inline void pb1200_disable_irq(unsigned int irq_nr)
 {
-	bcsr->intclr_mask = 1<<(irq_nr - PB1200_INT_BEGIN);
-	bcsr->intclr = 1<<(irq_nr - PB1200_INT_BEGIN);
+	bcsr->intclr_mask = 1 << (irq_nr - PB1200_INT_BEGIN);
+	bcsr->intclr = 1 << (irq_nr - PB1200_INT_BEGIN);
 }
 
 static unsigned int pb1200_setup_cascade(void)
 {
-	int err;
-
-	err = request_irq(AU1000_GPIO_7, &pb1200_cascade_handler,
-			  0, "Pb1200 Cascade", &pb1200_cascade_handler);
-	if (err)
-		return err;
-
-	return 0;
+	return request_irq(AU1000_GPIO_7, &pb1200_cascade_handler,
+			   0, "Pb1200 Cascade", &pb1200_cascade_handler);
 }
 
 static unsigned int pb1200_startup_irq(unsigned int irq)
@@ -132,23 +126,23 @@ void _board_init_irq(void)
 	unsigned int irq;
 
 #ifdef CONFIG_MIPS_PB1200
-	/* We have a problem with CPLD rev3. Enable a workaround */
+	/* We have a problem with CPLD rev 3. */
 	if (((bcsr->whoami & BCSR_WHOAMI_CPLD) >> 4) <= 3) {
-		printk("\nWARNING!!!\n");
-		printk("\nWARNING!!!\n");
-		printk("\nWARNING!!!\n");
-		printk("\nWARNING!!!\n");
-		printk("\nWARNING!!!\n");
-		printk("\nWARNING!!!\n");
-		printk("Pb1200 must be at CPLD rev4. Please have Pb1200\n");
-		printk("updated to latest revision. This software will not\n");
-		printk("work on anything less than CPLD rev4\n");
-		printk("\nWARNING!!!\n");
-		printk("\nWARNING!!!\n");
-		printk("\nWARNING!!!\n");
-		printk("\nWARNING!!!\n");
-		printk("\nWARNING!!!\n");
-		printk("\nWARNING!!!\n");
+		printk(KERN_ERR "WARNING!!!\n");
+		printk(KERN_ERR "WARNING!!!\n");
+		printk(KERN_ERR "WARNING!!!\n");
+		printk(KERN_ERR "WARNING!!!\n");
+		printk(KERN_ERR "WARNING!!!\n");
+		printk(KERN_ERR "WARNING!!!\n");
+		printk(KERN_ERR "Pb1200 must be at CPLD rev 4. Please have Pb1200\n");
+		printk(KERN_ERR "updated to latest revision. This software will\n");
+		printk(KERN_ERR "not work on anything less than CPLD rev 4.\n");
+		printk(KERN_ERR "WARNING!!!\n");
+		printk(KERN_ERR "WARNING!!!\n");
+		printk(KERN_ERR "WARNING!!!\n");
+		printk(KERN_ERR "WARNING!!!\n");
+		printk(KERN_ERR "WARNING!!!\n");
+		printk(KERN_ERR "WARNING!!!\n");
 		panic("Game over.  Your score is 0.");
 	}
 #endif
@@ -161,6 +155,6 @@ void _board_init_irq(void)
 
 	/*
 	 * GPIO_7 can not be hooked here, so it is hooked upon first
-	 * request of any source attached to the cascade
+	 * request of any source attached to the cascade.
 	 */
 }
Index: linux-2.6/include/asm-mips/mach-db1x00/db1200.h
===================================================================
--- linux-2.6.orig/include/asm-mips/mach-db1x00/db1200.h
+++ linux-2.6/include/asm-mips/mach-db1x00/db1200.h
@@ -1,6 +1,6 @@
 /*
- * AMD Alchemy DB1200 Referrence Board
- * Board Registers defines.
+ * AMD Alchemy DBAu1200 Reference Board
+ * Board register defines.
  *
  * ########################################################################
  *
@@ -27,26 +27,25 @@
 #include <linux/types.h>
 #include <asm/mach-au1x00/au1xxx_psc.h>
 
-// This is defined in au1000.h with bogus value
-#undef AU1X00_EXTERNAL_INT
+#define DBDMA_AC97_TX_CHAN	DSCR_CMD0_PSC1_TX
+#define DBDMA_AC97_RX_CHAN	DSCR_CMD0_PSC1_RX
+#define DBDMA_I2S_TX_CHAN	DSCR_CMD0_PSC1_TX
+#define DBDMA_I2S_RX_CHAN	DSCR_CMD0_PSC1_RX
 
-#define DBDMA_AC97_TX_CHAN DSCR_CMD0_PSC1_TX
-#define DBDMA_AC97_RX_CHAN DSCR_CMD0_PSC1_RX
-#define DBDMA_I2S_TX_CHAN DSCR_CMD0_PSC1_TX
-#define DBDMA_I2S_RX_CHAN DSCR_CMD0_PSC1_RX
-
-/* SPI and SMB are muxed on the Pb1200 board.
-   Refer to board documentation.
- */
-#define SPI_PSC_BASE        PSC0_BASE_ADDR
-#define SMBUS_PSC_BASE      PSC0_BASE_ADDR
-/* AC97 and I2S are muxed on the Pb1200 board.
-   Refer to board documentation.
+/*
+ * SPI and SMB are muxed on the DBAu1200 board.
+ * Refer to board documentation.
+ */
+#define SPI_PSC_BASE		PSC0_BASE_ADDR
+#define SMBUS_PSC_BASE		PSC0_BASE_ADDR
+/*
+ * AC'97 and I2S are muxed on the DBAu1200 board.
+ * Refer to board documentation.
  */
-#define AC97_PSC_BASE       PSC1_BASE_ADDR
+#define AC97_PSC_BASE		PSC1_BASE_ADDR
 #define I2S_PSC_BASE		PSC1_BASE_ADDR
 
-#define BCSR_KSEG1_ADDR 0xB9800000
+#define BCSR_KSEG1_ADDR 	0xB9800000
 
 typedef volatile struct
 {
@@ -102,9 +101,9 @@ static BCSR * const bcsr = (BCSR *)BCSR_
 #define BCSR_STATUS_SWAPBOOT	0x0040
 #define BCSR_STATUS_FLASHBUSY	0x0100
 #define BCSR_STATUS_IDECBLID	0x0200
-#define BCSR_STATUS_SD0WP		0x0400
-#define BCSR_STATUS_U0RXD		0x1000
-#define BCSR_STATUS_U1RXD		0x2000
+#define BCSR_STATUS_SD0WP	0x0400
+#define BCSR_STATUS_U0RXD	0x1000
+#define BCSR_STATUS_U1RXD	0x2000
 
 #define BCSR_SWITCHES_OCTAL	0x00FF
 #define BCSR_SWITCHES_DIP_1	0x0080
@@ -122,8 +121,8 @@ static BCSR * const bcsr = (BCSR *)BCSR_
 #define BCSR_RESETS_DC		0x0004
 #define BCSR_RESETS_IDE		0x0008
 #define BCSR_RESETS_TV		0x0010
-/* not resets but in the same register */
-#define BCSR_RESETS_PWMR1mUX 0x0800
+/* Not resets but in the same register */
+#define BCSR_RESETS_PWMR1MUX	0x0800
 #define BCSR_RESETS_PCS0MUX	0x1000
 #define BCSR_RESETS_PCS1MUX	0x2000
 #define BCSR_RESETS_SPISEL	0x4000
@@ -160,7 +159,7 @@ static BCSR * const bcsr = (BCSR *)BCSR_
 #define BCSR_INT_PC0STSCHG	0x0008
 #define BCSR_INT_PC1		0x0010
 #define BCSR_INT_PC1STSCHG	0x0020
-#define BCSR_INT_DC			0x0040
+#define BCSR_INT_DC		0x0040
 #define BCSR_INT_FLASHBUSY	0x0080
 #define BCSR_INT_PC0INSERT	0x0100
 #define BCSR_INT_PC0EJECT	0x0200
@@ -179,10 +178,10 @@ static BCSR * const bcsr = (BCSR *)BCSR_
 #define IDE_DDMA_REQ		DSCR_CMD0_DMA_REQ1
 #define IDE_RQSIZE		128
 
-#define NAND_PHYS_ADDR   0x20000000
+#define NAND_PHYS_ADDR		0x20000000
 
 /*
- * External Interrupts for Pb1200 as of 8/6/2004.
+ * External Interrupts for DBAu1200 as of 8/6/2004.
  * Bit positions in the CPLD registers can be calculated by taking
  * the interrupt define and subtracting the DB1200_INT_BEGIN value.
  *
@@ -211,23 +210,21 @@ enum external_pb1200_ints {
 };
 
 
-/* For drivers/pcmcia/au1000_db1x00.c */
-
-/* PCMCIA Db1x00 specific defines */
-
-#define PCMCIA_MAX_SOCK 1
-#define PCMCIA_NUM_SOCKS (PCMCIA_MAX_SOCK+1)
+/*
+ * DBAu1200 specific PCMCIA defines for drivers/pcmcia/au1000_db1x00.c
+ */
+#define PCMCIA_MAX_SOCK  1
+#define PCMCIA_NUM_SOCKS (PCMCIA_MAX_SOCK + 1)
 
 /* VPP/VCC */
-#define SET_VCC_VPP(VCC, VPP, SLOT)\
-	((((VCC)<<2) | ((VPP)<<0)) << ((SLOT)*8))
+#define SET_VCC_VPP(VCC, VPP, SLOT) \
+	((((VCC) << 2) | ((VPP) << 0)) << ((SLOT) * 8))
 
-#define BOARD_PC0_INT DB1200_PC0_INT
-#define BOARD_PC1_INT DB1200_PC1_INT
-#define BOARD_CARD_INSERTED(SOCKET) bcsr->sig_status & (1<<(8+(2*SOCKET)))
+#define BOARD_PC0_INT	DB1200_PC0_INT
+#define BOARD_PC1_INT	DB1200_PC1_INT
+#define BOARD_CARD_INSERTED(SOCKET) bcsr->sig_status & (1 << (8 + (2 * SOCKET)))
 
-/* Nand chip select */
+/* NAND chip select */
 #define NAND_CS 1
 
 #endif /* __ASM_DB1200_H */
-
Index: linux-2.6/include/asm-mips/mach-pb1x00/pb1200.h
===================================================================
--- linux-2.6.orig/include/asm-mips/mach-pb1x00/pb1200.h
+++ linux-2.6/include/asm-mips/mach-pb1x00/pb1200.h
@@ -1,5 +1,5 @@
 /*
- * AMD Alchemy PB1200 Referrence Board
+ * AMD Alchemy Pb1200 Referrence Board
  * Board Registers defines.
  *
  * ########################################################################
@@ -27,21 +27,20 @@
 #include <linux/types.h>
 #include <asm/mach-au1x00/au1xxx_psc.h>
 
-// This is defined in au1000.h with bogus value
-#undef AU1X00_EXTERNAL_INT
+#define DBDMA_AC97_TX_CHAN	DSCR_CMD0_PSC1_TX
+#define DBDMA_AC97_RX_CHAN	DSCR_CMD0_PSC1_RX
+#define DBDMA_I2S_TX_CHAN	DSCR_CMD0_PSC1_TX
+#define DBDMA_I2S_RX_CHAN	DSCR_CMD0_PSC1_RX
 
-#define DBDMA_AC97_TX_CHAN DSCR_CMD0_PSC1_TX
-#define DBDMA_AC97_RX_CHAN DSCR_CMD0_PSC1_RX
-#define DBDMA_I2S_TX_CHAN DSCR_CMD0_PSC1_TX
-#define DBDMA_I2S_RX_CHAN DSCR_CMD0_PSC1_RX
-
-/* SPI and SMB are muxed on the Pb1200 board.
-   Refer to board documentation.
+/*
+ * SPI and SMB are muxed on the Pb1200 board.
+ * Refer to board documentation.
  */
-#define SPI_PSC_BASE        PSC0_BASE_ADDR
-#define SMBUS_PSC_BASE      PSC0_BASE_ADDR
-/* AC97 and I2S are muxed on the Pb1200 board.
-   Refer to board documentation.
+#define SPI_PSC_BASE		PSC0_BASE_ADDR
+#define SMBUS_PSC_BASE		PSC0_BASE_ADDR
+/*
+ * AC97 and I2S are muxed on the Pb1200 board.
+ * Refer to board documentation.
  */
 #define AC97_PSC_BASE       PSC1_BASE_ADDR
 #define I2S_PSC_BASE		PSC1_BASE_ADDR
@@ -102,10 +101,10 @@ static BCSR * const bcsr = (BCSR *)BCSR_
 #define BCSR_STATUS_SWAPBOOT	0x0040
 #define BCSR_STATUS_FLASHBUSY	0x0100
 #define BCSR_STATUS_IDECBLID	0x0200
-#define BCSR_STATUS_SD0WP		0x0400
-#define BCSR_STATUS_SD1WP		0x0800
-#define BCSR_STATUS_U0RXD		0x1000
-#define BCSR_STATUS_U1RXD		0x2000
+#define BCSR_STATUS_SD0WP	0x0400
+#define BCSR_STATUS_SD1WP	0x0800
+#define BCSR_STATUS_U0RXD	0x1000
+#define BCSR_STATUS_U1RXD	0x2000
 
 #define BCSR_SWITCHES_OCTAL	0x00FF
 #define BCSR_SWITCHES_DIP_1	0x0080
@@ -123,11 +122,11 @@ static BCSR * const bcsr = (BCSR *)BCSR_
 #define BCSR_RESETS_DC		0x0004
 #define BCSR_RESETS_IDE		0x0008
 /* not resets but in the same register */
-#define BCSR_RESETS_WSCFSM  0x0800
+#define BCSR_RESETS_WSCFSM	0x0800
 #define BCSR_RESETS_PCS0MUX	0x1000
 #define BCSR_RESETS_PCS1MUX	0x2000
 #define BCSR_RESETS_SPISEL	0x4000
-#define BCSR_RESETS_SD1MUX  0x8000
+#define BCSR_RESETS_SD1MUX	0x8000
 
 #define BCSR_PCMCIA_PC0VPP	0x0003
 #define BCSR_PCMCIA_PC0VCC	0x000C
@@ -163,7 +162,7 @@ static BCSR * const bcsr = (BCSR *)BCSR_
 #define BCSR_INT_PC0STSCHG	0x0008
 #define BCSR_INT_PC1		0x0010
 #define BCSR_INT_PC1STSCHG	0x0020
-#define BCSR_INT_DC			0x0040
+#define BCSR_INT_DC		0x0040
 #define BCSR_INT_FLASHBUSY	0x0080
 #define BCSR_INT_PC0INSERT	0x0100
 #define BCSR_INT_PC0EJECT	0x0200
@@ -174,14 +173,6 @@ static BCSR * const bcsr = (BCSR *)BCSR_
 #define BCSR_INT_SD1INSERT	0x4000
 #define BCSR_INT_SD1EJECT	0x8000
 
-/* PCMCIA Db1x00 specific defines */
-#define PCMCIA_MAX_SOCK 1
-#define PCMCIA_NUM_SOCKS (PCMCIA_MAX_SOCK+1)
-
-/* VPP/VCC */
-#define SET_VCC_VPP(VCC, VPP, SLOT)\
-	((((VCC)<<2) | ((VPP)<<0)) << ((SLOT)*8))
-
 #define SMC91C111_PHYS_ADDR	0x0D000300
 #define SMC91C111_INT		PB1200_ETH_INT
 
@@ -192,18 +183,19 @@ static BCSR * const bcsr = (BCSR *)BCSR_
 #define IDE_DDMA_REQ		DSCR_CMD0_DMA_REQ1
 #define IDE_RQSIZE		128
 
-#define NAND_PHYS_ADDR   0x1C000000
+#define NAND_PHYS_ADDR 	0x1C000000
 
-/* Timing values as described in databook, * ns value stripped of
+/*
+ * Timing values as described in databook, * ns value stripped of
  * lower 2 bits.
- * These defines are here rather than an SOC1200 generic file because
+ * These defines are here rather than an Au1200 generic file because
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
@@ -211,11 +203,10 @@ static BCSR * const bcsr = (BCSR *)BCSR_
 #define NAND_T_SU_SHIFT		8
 #define NAND_T_WH_SHIFT		12
 
-#define NAND_TIMING	((NAND_T_H   & 0xF)	<< NAND_T_H_SHIFT)   | \
-			((NAND_T_PUL & 0xF)	<< NAND_T_PUL_SHIFT) | \
-			((NAND_T_SU  & 0xF)	<< NAND_T_SU_SHIFT)  | \
-			((NAND_T_WH  & 0xF)	<< NAND_T_WH_SHIFT)
-
+#define NAND_TIMING	(((NAND_T_H   & 0xF) << NAND_T_H_SHIFT)   | \
+			 ((NAND_T_PUL & 0xF) << NAND_T_PUL_SHIFT) | \
+			 ((NAND_T_SU  & 0xF) << NAND_T_SU_SHIFT)  | \
+			 ((NAND_T_WH  & 0xF) << NAND_T_WH_SHIFT))
 
 /*
  * External Interrupts for Pb1200 as of 8/6/2004.
@@ -248,13 +239,21 @@ enum external_pb1200_ints {
 	PB1200_INT_END		= PB1200_INT_BEGIN + 15
 };
 
-/* For drivers/pcmcia/au1000_db1x00.c */
-#define BOARD_PC0_INT PB1200_PC0_INT
-#define BOARD_PC1_INT PB1200_PC1_INT
-#define BOARD_CARD_INSERTED(SOCKET) bcsr->sig_status & (1<<(8+(2*SOCKET)))
+/*
+ * Pb1200 specific PCMCIA defines for drivers/pcmcia/au1000_db1x00.c
+ */
+#define PCMCIA_MAX_SOCK  1
+#define PCMCIA_NUM_SOCKS (PCMCIA_MAX_SOCK + 1)
 
-/* Nand chip select */
+/* VPP/VCC */
+#define SET_VCC_VPP(VCC, VPP, SLOT) \
+	((((VCC) << 2) | ((VPP) << 0)) << ((SLOT) * 8))
+
+#define BOARD_PC0_INT	PB1200_PC0_INT
+#define BOARD_PC1_INT	PB1200_PC1_INT
+#define BOARD_CARD_INSERTED(SOCKET) bcsr->sig_status & (1 << (8 + (2 * SOCKET)))
+
+/* NAND chip select */
 #define NAND_CS 1
 
 #endif /* __ASM_PB1200_H */
-
