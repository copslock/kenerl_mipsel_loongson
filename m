Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Apr 2008 20:19:32 +0100 (BST)
Received: from rtsoft3.corbina.net ([85.21.88.6]:53953 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S30617817AbYD3TT1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 30 Apr 2008 20:19:27 +0100
Received: from wasted.dev.rtsoft.ru (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP
	id 367B88816; Thu,  1 May 2008 00:19:19 +0500 (SAMST)
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
To:	ralf@linux-mips.org
Subject: [PATCH 2/11] Alchemy common code style cleanup
Date:	Wed, 30 Apr 2008 23:18:41 +0400
User-Agent: KMail/1.5
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200804302318.41380.sshtylyov@ru.mvista.com>
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19054
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Fix many errors and warnings given by checkpatch.pl:

- use of C99 // comments;

- missing space between the type and asterisk in a variable declaration;

- space between the asterisk and function/variable name;

- leading spaces instead of tabs;

- space after opening and before closing parentheses;

- initialization of a 'static' variable to 0;

- missing spaces around assignement/comparison operator;

- brace not on the same line with condition (or 'else') in the 'if'/'switch'
  statement;

- missing space between 'if'/'for'/'while' and opening parenthesis;

- use of assignement in 'if' statement's condition;

- printk() without KERN_* facility level;

- EXPORT_SYMBOL() not following its function immediately;

- unnecessary braces for single-statement block;

- adding new 'typedef' (where including <linux/types.h> will do);

- use of 'extern' in the .c file (where it can be avoided by including header);

- line over 80 characters.

In addition to these changes, also do the following:

- insert missing space after opening brace and/or before closing brace in the
  structure initializers;

- insert spaces between operator and its operands;

- put the function's result type and name/parameters on the same line;

- properly indent multi-line expressions;

- remove commented out code;

- remove useless initializers and code;

- remove needless parentheses;

- fix broken/excess indentation;

- add missing spaces between operator and its operands;

- insert missing and remove excess new lines;

- group 'else' and 'if' together where possible;

- make au1xxx_platform_init() 'static';

- regroup variable declarations in pm_do_freq() for prettier look;

- replace numeric literals with the matching macros;

- fix printk() format specifiers mismatching the argument types;

- make the multi-line comment style consistent with the kernel style elsewhere
  by adding empty first line and/or adding space on their left side;

- make two-line comments that only have one line of text one-line;

- fix typos/errors, capitalize acronyms, etc. in the comments;

- fix/remove obsolete references in the comments;

- reformat some comments;

- add comment about the CPU:counter clock ratio to calc_clock();

- update MontaVista copyright;

- remove Pete Popov's and Steve Longerbeam's old email addresses...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

 arch/mips/au1000/common/Makefile        |    7 
 arch/mips/au1000/common/au1xxx_irqmap.c |  145 +++++------
 arch/mips/au1000/common/clocks.c        |   24 -
 arch/mips/au1000/common/cputable.c      |    5 
 arch/mips/au1000/common/dbdma.c         |  387 +++++++++++++++-----------------
 arch/mips/au1000/common/dbg_io.c        |   32 --
 arch/mips/au1000/common/dma.c           |   56 ++--
 arch/mips/au1000/common/gpio.c          |    6 
 arch/mips/au1000/common/irq.c           |    6 
 arch/mips/au1000/common/pci.c           |   11 
 arch/mips/au1000/common/platform.c      |    7 
 arch/mips/au1000/common/power.c         |  166 ++++++-------
 arch/mips/au1000/common/prom.c          |   21 -
 arch/mips/au1000/common/puts.c          |   35 +-
 arch/mips/au1000/common/reset.c         |   33 +-
 arch/mips/au1000/common/setup.c         |   60 ++--
 arch/mips/au1000/common/time.c          |   78 ++----
 17 files changed, 503 insertions(+), 576 deletions(-)

Index: linux-2.6/arch/mips/au1000/common/Makefile
===================================================================
--- linux-2.6.orig/arch/mips/au1000/common/Makefile
+++ linux-2.6/arch/mips/au1000/common/Makefile
@@ -1,9 +1,8 @@
 #
-#  Copyright 2000 MontaVista Software Inc.
-#  Author: MontaVista Software, Inc.
-#     	ppopov@mvista.com or source@mvista.com
+#  Copyright 2000, 2008 MontaVista Software Inc.
+#  Author: MontaVista Software, Inc. <source@mvista.com>
 #
-# Makefile for the Alchemy Au1000 CPU, generic files.
+# Makefile for the Alchemy Au1xx0 CPUs, generic files.
 #
 
 obj-y += prom.o irq.o puts.o time.o reset.o \
Index: linux-2.6/arch/mips/au1000/common/au1xxx_irqmap.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/common/au1xxx_irqmap.c
+++ linux-2.6/arch/mips/au1000/common/au1xxx_irqmap.c
@@ -40,20 +40,20 @@
 struct au1xxx_irqmap __initdata au1xxx_ic0_map[] = {
 
 #if defined(CONFIG_SOC_AU1000)
-	{ AU1000_UART0_INT, INTC_INT_HIGH_LEVEL, 0},
-	{ AU1000_UART1_INT, INTC_INT_HIGH_LEVEL, 0},
-	{ AU1000_UART2_INT, INTC_INT_HIGH_LEVEL, 0},
-	{ AU1000_UART3_INT, INTC_INT_HIGH_LEVEL, 0},
-	{ AU1000_SSI0_INT, INTC_INT_HIGH_LEVEL, 0},
-	{ AU1000_SSI1_INT, INTC_INT_HIGH_LEVEL, 0},
-	{ AU1000_DMA_INT_BASE, INTC_INT_HIGH_LEVEL, 0},
-	{ AU1000_DMA_INT_BASE+1, INTC_INT_HIGH_LEVEL, 0},
-	{ AU1000_DMA_INT_BASE+2, INTC_INT_HIGH_LEVEL, 0},
-	{ AU1000_DMA_INT_BASE+3, INTC_INT_HIGH_LEVEL, 0},
-	{ AU1000_DMA_INT_BASE+4, INTC_INT_HIGH_LEVEL, 0},
-	{ AU1000_DMA_INT_BASE+5, INTC_INT_HIGH_LEVEL, 0},
-	{ AU1000_DMA_INT_BASE+6, INTC_INT_HIGH_LEVEL, 0},
-	{ AU1000_DMA_INT_BASE+7, INTC_INT_HIGH_LEVEL, 0},
+	{ AU1000_UART0_INT, INTC_INT_HIGH_LEVEL, 0 },
+	{ AU1000_UART1_INT, INTC_INT_HIGH_LEVEL, 0 },
+	{ AU1000_UART2_INT, INTC_INT_HIGH_LEVEL, 0 },
+	{ AU1000_UART3_INT, INTC_INT_HIGH_LEVEL, 0 },
+	{ AU1000_SSI0_INT, INTC_INT_HIGH_LEVEL, 0 },
+	{ AU1000_SSI1_INT, INTC_INT_HIGH_LEVEL, 0 },
+	{ AU1000_DMA_INT_BASE, INTC_INT_HIGH_LEVEL, 0 },
+	{ AU1000_DMA_INT_BASE+1, INTC_INT_HIGH_LEVEL, 0 },
+	{ AU1000_DMA_INT_BASE+2, INTC_INT_HIGH_LEVEL, 0 },
+	{ AU1000_DMA_INT_BASE+3, INTC_INT_HIGH_LEVEL, 0 },
+	{ AU1000_DMA_INT_BASE+4, INTC_INT_HIGH_LEVEL, 0 },
+	{ AU1000_DMA_INT_BASE+5, INTC_INT_HIGH_LEVEL, 0 },
+	{ AU1000_DMA_INT_BASE+6, INTC_INT_HIGH_LEVEL, 0 },
+	{ AU1000_DMA_INT_BASE+7, INTC_INT_HIGH_LEVEL, 0 },
 	{ AU1000_TOY_INT, INTC_INT_RISE_EDGE, 0 },
 	{ AU1000_TOY_MATCH0_INT, INTC_INT_RISE_EDGE, 0 },
 	{ AU1000_TOY_MATCH1_INT, INTC_INT_RISE_EDGE, 0 },
@@ -62,32 +62,32 @@ struct au1xxx_irqmap __initdata au1xxx_i
 	{ AU1000_RTC_MATCH0_INT, INTC_INT_RISE_EDGE, 0 },
 	{ AU1000_RTC_MATCH1_INT, INTC_INT_RISE_EDGE, 0 },
 	{ AU1000_RTC_MATCH2_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1000_IRDA_TX_INT, INTC_INT_HIGH_LEVEL, 0},
-	{ AU1000_IRDA_RX_INT, INTC_INT_HIGH_LEVEL, 0},
+	{ AU1000_IRDA_TX_INT, INTC_INT_HIGH_LEVEL, 0 },
+	{ AU1000_IRDA_RX_INT, INTC_INT_HIGH_LEVEL, 0 },
 	{ AU1000_USB_DEV_REQ_INT, INTC_INT_HIGH_LEVEL, 0 },
 	{ AU1000_USB_DEV_SUS_INT, INTC_INT_RISE_EDGE, 0 },
 	{ AU1000_USB_HOST_INT, INTC_INT_LOW_LEVEL, 0 },
 	{ AU1000_ACSYNC_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1000_MAC0_DMA_INT, INTC_INT_HIGH_LEVEL, 0},
-	{ AU1000_MAC1_DMA_INT, INTC_INT_HIGH_LEVEL, 0},
+	{ AU1000_MAC0_DMA_INT, INTC_INT_HIGH_LEVEL, 0 },
+	{ AU1000_MAC1_DMA_INT, INTC_INT_HIGH_LEVEL, 0 },
 	{ AU1000_AC97C_INT, INTC_INT_RISE_EDGE, 0 },
 
 #elif defined(CONFIG_SOC_AU1500)
 
-	{ AU1500_UART0_INT, INTC_INT_HIGH_LEVEL, 0},
+	{ AU1500_UART0_INT, INTC_INT_HIGH_LEVEL, 0 },
 	{ AU1000_PCI_INTA, INTC_INT_LOW_LEVEL, 0 },
 	{ AU1000_PCI_INTB, INTC_INT_LOW_LEVEL, 0 },
-	{ AU1500_UART3_INT, INTC_INT_HIGH_LEVEL, 0},
+	{ AU1500_UART3_INT, INTC_INT_HIGH_LEVEL, 0 },
 	{ AU1000_PCI_INTC, INTC_INT_LOW_LEVEL, 0 },
 	{ AU1000_PCI_INTD, INTC_INT_LOW_LEVEL, 0 },
-	{ AU1000_DMA_INT_BASE, INTC_INT_HIGH_LEVEL, 0},
-	{ AU1000_DMA_INT_BASE+1, INTC_INT_HIGH_LEVEL, 0},
-	{ AU1000_DMA_INT_BASE+2, INTC_INT_HIGH_LEVEL, 0},
-	{ AU1000_DMA_INT_BASE+3, INTC_INT_HIGH_LEVEL, 0},
-	{ AU1000_DMA_INT_BASE+4, INTC_INT_HIGH_LEVEL, 0},
-	{ AU1000_DMA_INT_BASE+5, INTC_INT_HIGH_LEVEL, 0},
-	{ AU1000_DMA_INT_BASE+6, INTC_INT_HIGH_LEVEL, 0},
-	{ AU1000_DMA_INT_BASE+7, INTC_INT_HIGH_LEVEL, 0},
+	{ AU1000_DMA_INT_BASE, INTC_INT_HIGH_LEVEL, 0 },
+	{ AU1000_DMA_INT_BASE+1, INTC_INT_HIGH_LEVEL, 0 },
+	{ AU1000_DMA_INT_BASE+2, INTC_INT_HIGH_LEVEL, 0 },
+	{ AU1000_DMA_INT_BASE+3, INTC_INT_HIGH_LEVEL, 0 },
+	{ AU1000_DMA_INT_BASE+4, INTC_INT_HIGH_LEVEL, 0 },
+	{ AU1000_DMA_INT_BASE+5, INTC_INT_HIGH_LEVEL, 0 },
+	{ AU1000_DMA_INT_BASE+6, INTC_INT_HIGH_LEVEL, 0 },
+	{ AU1000_DMA_INT_BASE+7, INTC_INT_HIGH_LEVEL, 0 },
 	{ AU1000_TOY_INT, INTC_INT_RISE_EDGE, 0 },
 	{ AU1000_TOY_MATCH0_INT, INTC_INT_RISE_EDGE, 0 },
 	{ AU1000_TOY_MATCH1_INT, INTC_INT_RISE_EDGE, 0 },
@@ -100,26 +100,26 @@ struct au1xxx_irqmap __initdata au1xxx_i
 	{ AU1000_USB_DEV_SUS_INT, INTC_INT_RISE_EDGE, 0 },
 	{ AU1000_USB_HOST_INT, INTC_INT_LOW_LEVEL, 0 },
 	{ AU1000_ACSYNC_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1500_MAC0_DMA_INT, INTC_INT_HIGH_LEVEL, 0},
-	{ AU1500_MAC1_DMA_INT, INTC_INT_HIGH_LEVEL, 0},
+	{ AU1500_MAC0_DMA_INT, INTC_INT_HIGH_LEVEL, 0 },
+	{ AU1500_MAC1_DMA_INT, INTC_INT_HIGH_LEVEL, 0 },
 	{ AU1000_AC97C_INT, INTC_INT_RISE_EDGE, 0 },
 
 #elif defined(CONFIG_SOC_AU1100)
 
-	{ AU1100_UART0_INT, INTC_INT_HIGH_LEVEL, 0},
-	{ AU1100_UART1_INT, INTC_INT_HIGH_LEVEL, 0},
-	{ AU1100_SD_INT, INTC_INT_HIGH_LEVEL, 0},
-	{ AU1100_UART3_INT, INTC_INT_HIGH_LEVEL, 0},
-	{ AU1000_SSI0_INT, INTC_INT_HIGH_LEVEL, 0},
-	{ AU1000_SSI1_INT, INTC_INT_HIGH_LEVEL, 0},
-	{ AU1000_DMA_INT_BASE, INTC_INT_HIGH_LEVEL, 0},
-	{ AU1000_DMA_INT_BASE+1, INTC_INT_HIGH_LEVEL, 0},
-	{ AU1000_DMA_INT_BASE+2, INTC_INT_HIGH_LEVEL, 0},
-	{ AU1000_DMA_INT_BASE+3, INTC_INT_HIGH_LEVEL, 0},
-	{ AU1000_DMA_INT_BASE+4, INTC_INT_HIGH_LEVEL, 0},
-	{ AU1000_DMA_INT_BASE+5, INTC_INT_HIGH_LEVEL, 0},
-	{ AU1000_DMA_INT_BASE+6, INTC_INT_HIGH_LEVEL, 0},
-	{ AU1000_DMA_INT_BASE+7, INTC_INT_HIGH_LEVEL, 0},
+	{ AU1100_UART0_INT, INTC_INT_HIGH_LEVEL, 0 },
+	{ AU1100_UART1_INT, INTC_INT_HIGH_LEVEL, 0 },
+	{ AU1100_SD_INT, INTC_INT_HIGH_LEVEL, 0 },
+	{ AU1100_UART3_INT, INTC_INT_HIGH_LEVEL, 0 },
+	{ AU1000_SSI0_INT, INTC_INT_HIGH_LEVEL, 0 },
+	{ AU1000_SSI1_INT, INTC_INT_HIGH_LEVEL, 0 },
+	{ AU1000_DMA_INT_BASE, INTC_INT_HIGH_LEVEL, 0 },
+	{ AU1000_DMA_INT_BASE+1, INTC_INT_HIGH_LEVEL, 0 },
+	{ AU1000_DMA_INT_BASE+2, INTC_INT_HIGH_LEVEL, 0 },
+	{ AU1000_DMA_INT_BASE+3, INTC_INT_HIGH_LEVEL, 0 },
+	{ AU1000_DMA_INT_BASE+4, INTC_INT_HIGH_LEVEL, 0 },
+	{ AU1000_DMA_INT_BASE+5, INTC_INT_HIGH_LEVEL, 0 },
+	{ AU1000_DMA_INT_BASE+6, INTC_INT_HIGH_LEVEL, 0 },
+	{ AU1000_DMA_INT_BASE+7, INTC_INT_HIGH_LEVEL, 0 },
 	{ AU1000_TOY_INT, INTC_INT_RISE_EDGE, 0 },
 	{ AU1000_TOY_MATCH0_INT, INTC_INT_RISE_EDGE, 0 },
 	{ AU1000_TOY_MATCH1_INT, INTC_INT_RISE_EDGE, 0 },
@@ -128,33 +128,33 @@ struct au1xxx_irqmap __initdata au1xxx_i
 	{ AU1000_RTC_MATCH0_INT, INTC_INT_RISE_EDGE, 0 },
 	{ AU1000_RTC_MATCH1_INT, INTC_INT_RISE_EDGE, 0 },
 	{ AU1000_RTC_MATCH2_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1000_IRDA_TX_INT, INTC_INT_HIGH_LEVEL, 0},
-	{ AU1000_IRDA_RX_INT, INTC_INT_HIGH_LEVEL, 0},
+	{ AU1000_IRDA_TX_INT, INTC_INT_HIGH_LEVEL, 0 },
+	{ AU1000_IRDA_RX_INT, INTC_INT_HIGH_LEVEL, 0 },
 	{ AU1000_USB_DEV_REQ_INT, INTC_INT_HIGH_LEVEL, 0 },
 	{ AU1000_USB_DEV_SUS_INT, INTC_INT_RISE_EDGE, 0 },
 	{ AU1000_USB_HOST_INT, INTC_INT_LOW_LEVEL, 0 },
 	{ AU1000_ACSYNC_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1100_MAC0_DMA_INT, INTC_INT_HIGH_LEVEL, 0},
-	/*{ AU1000_GPIO215_208_INT, INTC_INT_HIGH_LEVEL, 0},*/
-	{ AU1100_LCD_INT, INTC_INT_HIGH_LEVEL, 0},
+	{ AU1100_MAC0_DMA_INT, INTC_INT_HIGH_LEVEL, 0 },
+	/* { AU1000_GPIO215_208_INT, INTC_INT_HIGH_LEVEL, 0 }, */
+	{ AU1100_LCD_INT, INTC_INT_HIGH_LEVEL, 0 },
 	{ AU1000_AC97C_INT, INTC_INT_RISE_EDGE, 0 },
 
 #elif defined(CONFIG_SOC_AU1550)
 
-	{ AU1550_UART0_INT, INTC_INT_HIGH_LEVEL, 0},
+	{ AU1550_UART0_INT, INTC_INT_HIGH_LEVEL, 0 },
 	{ AU1550_PCI_INTA, INTC_INT_LOW_LEVEL, 0 },
 	{ AU1550_PCI_INTB, INTC_INT_LOW_LEVEL, 0 },
-	{ AU1550_DDMA_INT, INTC_INT_HIGH_LEVEL, 0},
-	{ AU1550_CRYPTO_INT, INTC_INT_HIGH_LEVEL, 0},
+	{ AU1550_DDMA_INT, INTC_INT_HIGH_LEVEL, 0 },
+	{ AU1550_CRYPTO_INT, INTC_INT_HIGH_LEVEL, 0 },
 	{ AU1550_PCI_INTC, INTC_INT_LOW_LEVEL, 0 },
 	{ AU1550_PCI_INTD, INTC_INT_LOW_LEVEL, 0 },
 	{ AU1550_PCI_RST_INT, INTC_INT_LOW_LEVEL, 0 },
-	{ AU1550_UART1_INT, INTC_INT_HIGH_LEVEL, 0},
-	{ AU1550_UART3_INT, INTC_INT_HIGH_LEVEL, 0},
-	{ AU1550_PSC0_INT, INTC_INT_HIGH_LEVEL, 0},
-	{ AU1550_PSC1_INT, INTC_INT_HIGH_LEVEL, 0},
-	{ AU1550_PSC2_INT, INTC_INT_HIGH_LEVEL, 0},
-	{ AU1550_PSC3_INT, INTC_INT_HIGH_LEVEL, 0},
+	{ AU1550_UART1_INT, INTC_INT_HIGH_LEVEL, 0 },
+	{ AU1550_UART3_INT, INTC_INT_HIGH_LEVEL, 0 },
+	{ AU1550_PSC0_INT, INTC_INT_HIGH_LEVEL, 0 },
+	{ AU1550_PSC1_INT, INTC_INT_HIGH_LEVEL, 0 },
+	{ AU1550_PSC2_INT, INTC_INT_HIGH_LEVEL, 0 },
+	{ AU1550_PSC3_INT, INTC_INT_HIGH_LEVEL, 0 },
 	{ AU1000_TOY_INT, INTC_INT_RISE_EDGE, 0 },
 	{ AU1000_TOY_MATCH0_INT, INTC_INT_RISE_EDGE, 0 },
 	{ AU1000_TOY_MATCH1_INT, INTC_INT_RISE_EDGE, 0 },
@@ -163,26 +163,26 @@ struct au1xxx_irqmap __initdata au1xxx_i
 	{ AU1000_RTC_MATCH0_INT, INTC_INT_RISE_EDGE, 0 },
 	{ AU1000_RTC_MATCH1_INT, INTC_INT_RISE_EDGE, 0 },
 	{ AU1000_RTC_MATCH2_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1550_NAND_INT, INTC_INT_RISE_EDGE, 0},
+	{ AU1550_NAND_INT, INTC_INT_RISE_EDGE, 0 },
 	{ AU1550_USB_DEV_REQ_INT, INTC_INT_HIGH_LEVEL, 0 },
 	{ AU1550_USB_DEV_SUS_INT, INTC_INT_RISE_EDGE, 0 },
 	{ AU1550_USB_HOST_INT, INTC_INT_LOW_LEVEL, 0 },
-	{ AU1550_MAC0_DMA_INT, INTC_INT_HIGH_LEVEL, 0},
-	{ AU1550_MAC1_DMA_INT, INTC_INT_HIGH_LEVEL, 0},
+	{ AU1550_MAC0_DMA_INT, INTC_INT_HIGH_LEVEL, 0 },
+	{ AU1550_MAC1_DMA_INT, INTC_INT_HIGH_LEVEL, 0 },
 
 #elif defined(CONFIG_SOC_AU1200)
 
-	{ AU1200_UART0_INT, INTC_INT_HIGH_LEVEL, 0},
+	{ AU1200_UART0_INT, INTC_INT_HIGH_LEVEL, 0 },
 	{ AU1200_SWT_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1200_SD_INT, INTC_INT_HIGH_LEVEL, 0},
-	{ AU1200_DDMA_INT, INTC_INT_HIGH_LEVEL, 0},
+	{ AU1200_SD_INT, INTC_INT_HIGH_LEVEL, 0 },
+	{ AU1200_DDMA_INT, INTC_INT_HIGH_LEVEL, 0 },
 	{ AU1200_MAE_BE_INT, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1200_UART1_INT, INTC_INT_HIGH_LEVEL, 0},
+	{ AU1200_UART1_INT, INTC_INT_HIGH_LEVEL, 0 },
 	{ AU1200_MAE_FE_INT, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1200_PSC0_INT, INTC_INT_HIGH_LEVEL, 0},
-	{ AU1200_PSC1_INT, INTC_INT_HIGH_LEVEL, 0},
-	{ AU1200_AES_INT, INTC_INT_HIGH_LEVEL, 0},
-	{ AU1200_CAMERA_INT, INTC_INT_HIGH_LEVEL, 0},
+	{ AU1200_PSC0_INT, INTC_INT_HIGH_LEVEL, 0 },
+	{ AU1200_PSC1_INT, INTC_INT_HIGH_LEVEL, 0 },
+	{ AU1200_AES_INT, INTC_INT_HIGH_LEVEL, 0 },
+	{ AU1200_CAMERA_INT, INTC_INT_HIGH_LEVEL, 0 },
 	{ AU1000_TOY_INT, INTC_INT_RISE_EDGE, 0 },
 	{ AU1000_TOY_MATCH0_INT, INTC_INT_RISE_EDGE, 0 },
 	{ AU1000_TOY_MATCH1_INT, INTC_INT_RISE_EDGE, 0 },
@@ -191,10 +191,10 @@ struct au1xxx_irqmap __initdata au1xxx_i
 	{ AU1000_RTC_MATCH0_INT, INTC_INT_RISE_EDGE, 0 },
 	{ AU1000_RTC_MATCH1_INT, INTC_INT_RISE_EDGE, 0 },
 	{ AU1000_RTC_MATCH2_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1200_NAND_INT, INTC_INT_RISE_EDGE, 0},
+	{ AU1200_NAND_INT, INTC_INT_RISE_EDGE, 0 },
 	{ AU1200_USB_INT, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1200_LCD_INT, INTC_INT_HIGH_LEVEL, 0},
-	{ AU1200_MAE_BOTH_INT, INTC_INT_HIGH_LEVEL, 0},
+	{ AU1200_LCD_INT, INTC_INT_HIGH_LEVEL, 0 },
+	{ AU1200_MAE_BOTH_INT, INTC_INT_HIGH_LEVEL, 0 },
 
 #else
 #error "Error: Unknown Alchemy SOC"
@@ -203,4 +203,3 @@ struct au1xxx_irqmap __initdata au1xxx_i
 };
 
 int __initdata au1xxx_ic0_nr_irqs = ARRAY_SIZE(au1xxx_ic0_map);
-
Index: linux-2.6/arch/mips/au1000/common/clocks.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/common/clocks.c
+++ linux-2.6/arch/mips/au1000/common/clocks.c
@@ -1,10 +1,9 @@
 /*
  * BRIEF MODULE DESCRIPTION
- *	Simple Au1000 clocks routines.
+ *	Simple Au1xx0 clocks routines.
  *
- * Copyright 2001 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *		ppopov@mvista.com or source@mvista.com
+ * Copyright 2001, 2008 MontaVista Software Inc.
+ * Author: MontaVista Software, Inc. <source@mvista.com>
  *
  *  This program is free software; you can redistribute	 it and/or modify it
  *  under  the terms of	 the GNU General  Public License as published by the
@@ -30,8 +29,8 @@
 #include <linux/module.h>
 #include <asm/mach-au1x00/au1000.h>
 
-static unsigned int au1x00_clock; // Hz
-static unsigned int lcd_clock;    // KHz
+static unsigned int au1x00_clock; /*  Hz */
+static unsigned int lcd_clock;    /* KHz */
 static unsigned long uart_baud_base;
 
 /*
@@ -47,8 +46,6 @@ unsigned int get_au1x00_speed(void)
 	return au1x00_clock;
 }
 
-
-
 /*
  * The UART baud base is not known at compile time ... if
  * we want to be able to use the same code on different
@@ -73,24 +70,23 @@ void set_au1x00_uart_baud_base(unsigned 
 void set_au1x00_lcd_clock(void)
 {
 	unsigned int static_cfg0;
-	unsigned int sys_busclk =
-		(get_au1x00_speed()/1000) /
-		((int)(au_readl(SYS_POWERCTRL)&0x03) + 2);
+	unsigned int sys_busclk = (get_au1x00_speed() / 1000) /
+				  ((int)(au_readl(SYS_POWERCTRL) & 0x03) + 2);
 
 	static_cfg0 = au_readl(MEM_STCFG0);
 
-	if (static_cfg0 & (1<<11))
+	if (static_cfg0 & (1 << 11))
 		lcd_clock = sys_busclk / 5; /* note: BCLK switching fails with D5 */
 	else
 		lcd_clock = sys_busclk / 4;
 
 	if (lcd_clock > 50000) /* Epson MAX */
-		printk("warning: LCD clock too high (%d KHz)\n", lcd_clock);
+		printk(KERN_WARNING "warning: LCD clock too high (%u KHz)\n",
+				    lcd_clock);
 }
 
 unsigned int get_au1x00_lcd_clock(void)
 {
 	return lcd_clock;
 }
-
 EXPORT_SYMBOL(get_au1x00_lcd_clock);
Index: linux-2.6/arch/mips/au1000/common/cputable.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/common/cputable.c
+++ linux-2.6/arch/mips/au1000/common/cputable.c
@@ -14,7 +14,7 @@
 
 #include <asm/mach-au1x00/au1000.h>
 
-struct cpu_spec* cur_cpu_spec[NR_CPUS];
+struct cpu_spec *cur_cpu_spec[NR_CPUS];
 
 /* With some thought, we can probably use the mask to reduce the
  * size of the table.
@@ -39,8 +39,7 @@ struct cpu_spec cpu_specs[] = {
 	{ 0x00000000, 0x00000000, "Unknown Au1xxx", 1, 0, 0 }
 };
 
-void
-set_cpuspec(void)
+void set_cpuspec(void)
 {
 	struct	cpu_spec *sp;
 	u32	prid;
Index: linux-2.6/arch/mips/au1000/common/dbdma.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/common/dbdma.c
+++ linux-2.6/arch/mips/au1000/common/dbdma.c
@@ -53,12 +53,11 @@
  */
 static DEFINE_SPINLOCK(au1xxx_dbdma_spin_lock);
 
-/* I couldn't find a macro that did this......
-*/
+/* I couldn't find a macro that did this... */
 #define ALIGN_ADDR(x, a)	((((u32)(x)) + (a-1)) & ~(a-1))
 
 static dbdma_global_t *dbdma_gptr = (dbdma_global_t *)DDMA_GLOBAL_BASE;
-static int dbdma_initialized=0;
+static int dbdma_initialized;
 static void au1xxx_dbdma_init(void);
 
 static dbdev_tab_t dbdev_tab[] = {
@@ -149,7 +148,7 @@ static dbdev_tab_t dbdev_tab[] = {
 
 	{ DSCR_CMD0_NAND_FLASH, DEV_FLAGS_IN, 0, 0, 0x00000000, 0, 0 },
 
-#endif // CONFIG_SOC_AU1200
+#endif /* CONFIG_SOC_AU1200 */
 
 	{ DSCR_CMD0_THROTTLE, DEV_FLAGS_ANYUSE, 0, 0, 0x00000000, 0, 0 },
 	{ DSCR_CMD0_ALWAYS, DEV_FLAGS_ANYUSE, 0, 0, 0x00000000, 0, 0 },
@@ -177,8 +176,7 @@ static dbdev_tab_t dbdev_tab[] = {
 
 static chan_tab_t *chan_tab_ptr[NUM_DBDMA_CHANS];
 
-static dbdev_tab_t *
-find_dbdev_id(u32 id)
+static dbdev_tab_t *find_dbdev_id(u32 id)
 {
 	int i;
 	dbdev_tab_t *p;
@@ -190,29 +188,27 @@ find_dbdev_id(u32 id)
 	return NULL;
 }
 
-void * au1xxx_ddma_get_nextptr_virt(au1x_ddma_desc_t *dp)
+void *au1xxx_ddma_get_nextptr_virt(au1x_ddma_desc_t *dp)
 {
-        return phys_to_virt(DSCR_GET_NXTPTR(dp->dscr_nxtptr));
+	return phys_to_virt(DSCR_GET_NXTPTR(dp->dscr_nxtptr));
 }
 EXPORT_SYMBOL(au1xxx_ddma_get_nextptr_virt);
 
-u32
-au1xxx_ddma_add_device(dbdev_tab_t *dev)
+u32 au1xxx_ddma_add_device(dbdev_tab_t *dev)
 {
 	u32 ret = 0;
-	dbdev_tab_t *p=NULL;
-	static u16 new_id=0x1000;
+	dbdev_tab_t *p;
+	static u16 new_id = 0x1000;
 
 	p = find_dbdev_id(~0);
-	if ( NULL != p )
-	{
+	if (NULL != p) {
 		memcpy(p, dev, sizeof(dbdev_tab_t));
 		p->dev_id = DSCR_DEV2CUSTOM_ID(new_id, dev->dev_id);
 		ret = p->dev_id;
 		new_id++;
 #if 0
-		printk("add_device: id:%x flags:%x padd:%x\n",
-				p->dev_id, p->dev_flags, p->dev_physaddr );
+		printk(KERN_DEBUG "add_device: id:%x flags:%x padd:%x\n",
+				  p->dev_id, p->dev_flags, p->dev_physaddr);
 #endif
 	}
 
@@ -220,10 +216,8 @@ au1xxx_ddma_add_device(dbdev_tab_t *dev)
 }
 EXPORT_SYMBOL(au1xxx_ddma_add_device);
 
-/* Allocate a channel and return a non-zero descriptor if successful.
-*/
-u32
-au1xxx_dbdma_chan_alloc(u32 srcid, u32 destid,
+/* Allocate a channel and return a non-zero descriptor if successful. */
+u32 au1xxx_dbdma_chan_alloc(u32 srcid, u32 destid,
        void (*callback)(int, void *), void *callparam)
 {
 	unsigned long   flags;
@@ -234,7 +228,8 @@ au1xxx_dbdma_chan_alloc(u32 srcid, u32 d
 	chan_tab_t	*ctp;
 	au1x_dma_chan_t *cp;
 
-	/* We do the intialization on the first channel allocation.
+	/*
+	 * We do the intialization on the first channel allocation.
 	 * We have to wait because of the interrupt handler initialization
 	 * which can't be done successfully during board set up.
 	 */
@@ -242,16 +237,17 @@ au1xxx_dbdma_chan_alloc(u32 srcid, u32 d
 		au1xxx_dbdma_init();
 	dbdma_initialized = 1;
 
-	if ((stp = find_dbdev_id(srcid)) == NULL)
+	stp = find_dbdev_id(srcid);
+	if (stp == NULL)
 		return 0;
-	if ((dtp = find_dbdev_id(destid)) == NULL)
+	dtp = find_dbdev_id(destid);
+	if (dtp == NULL)
 		return 0;
 
 	used = 0;
 	rv = 0;
 
-	/* Check to see if we can get both channels.
-	*/
+	/* Check to see if we can get both channels. */
 	spin_lock_irqsave(&au1xxx_dbdma_spin_lock, flags);
 	if (!(stp->dev_flags & DEV_FLAGS_INUSE) ||
 	     (stp->dev_flags & DEV_FLAGS_ANYUSE)) {
@@ -261,35 +257,30 @@ au1xxx_dbdma_chan_alloc(u32 srcid, u32 d
 		     (dtp->dev_flags & DEV_FLAGS_ANYUSE)) {
 			/* Got destination */
 			dtp->dev_flags |= DEV_FLAGS_INUSE;
-		}
-		else {
-			/* Can't get dest.  Release src.
-			*/
+		} else {
+			/* Can't get dest.  Release src. */
 			stp->dev_flags &= ~DEV_FLAGS_INUSE;
 			used++;
 		}
-	}
-	else {
+	} else
 		used++;
-	}
 	spin_unlock_irqrestore(&au1xxx_dbdma_spin_lock, flags);
 
 	if (!used) {
-		/* Let's see if we can allocate a channel for it.
-		*/
+		/* Let's see if we can allocate a channel for it. */
 		ctp = NULL;
 		chan = 0;
 		spin_lock_irqsave(&au1xxx_dbdma_spin_lock, flags);
-		for (i=0; i<NUM_DBDMA_CHANS; i++) {
+		for (i = 0; i < NUM_DBDMA_CHANS; i++)
 			if (chan_tab_ptr[i] == NULL) {
-				/* If kmalloc fails, it is caught below same
+				/*
+				 * If kmalloc fails, it is caught below same
 				 * as a channel not available.
 				 */
 				ctp = kmalloc(sizeof(chan_tab_t), GFP_ATOMIC);
 				chan_tab_ptr[i] = ctp;
 				break;
 			}
-		}
 		spin_unlock_irqrestore(&au1xxx_dbdma_spin_lock, flags);
 
 		if (ctp != NULL) {
@@ -304,8 +295,7 @@ au1xxx_dbdma_chan_alloc(u32 srcid, u32 d
 			ctp->chan_callback = callback;
 			ctp->chan_callparam = callparam;
 
-			/* Initialize channel configuration.
-			*/
+			/* Initialize channel configuration. */
 			i = 0;
 			if (stp->dev_intlevel)
 				i |= DDMA_CFG_SED;
@@ -326,8 +316,7 @@ au1xxx_dbdma_chan_alloc(u32 srcid, u32 d
 			 * operations.
 			 */
 			rv = (u32)(&chan_tab_ptr[chan]);
-		}
-		else {
+		} else {
 			/* Release devices */
 			stp->dev_flags &= ~DEV_FLAGS_INUSE;
 			dtp->dev_flags &= ~DEV_FLAGS_INUSE;
@@ -337,11 +326,11 @@ au1xxx_dbdma_chan_alloc(u32 srcid, u32 d
 }
 EXPORT_SYMBOL(au1xxx_dbdma_chan_alloc);
 
-/* Set the device width if source or destination is a FIFO.
+/*
+ * Set the device width if source or destination is a FIFO.
  * Should be 8, 16, or 32 bits.
  */
-u32
-au1xxx_dbdma_set_devwidth(u32 chanid, int bits)
+u32 au1xxx_dbdma_set_devwidth(u32 chanid, int bits)
 {
 	u32		rv;
 	chan_tab_t	*ctp;
@@ -365,10 +354,8 @@ au1xxx_dbdma_set_devwidth(u32 chanid, in
 }
 EXPORT_SYMBOL(au1xxx_dbdma_set_devwidth);
 
-/* Allocate a descriptor ring, initializing as much as possible.
-*/
-u32
-au1xxx_dbdma_ring_alloc(u32 chanid, int entries)
+/* Allocate a descriptor ring, initializing as much as possible. */
+u32 au1xxx_dbdma_ring_alloc(u32 chanid, int entries)
 {
 	int			i;
 	u32			desc_base, srcid, destid;
@@ -378,43 +365,45 @@ au1xxx_dbdma_ring_alloc(u32 chanid, int 
 	dbdev_tab_t		*stp, *dtp;
 	au1x_ddma_desc_t	*dp;
 
-	/* I guess we could check this to be within the
+	/*
+	 * I guess we could check this to be within the
 	 * range of the table......
 	 */
 	ctp = *((chan_tab_t **)chanid);
 	stp = ctp->chan_src;
 	dtp = ctp->chan_dest;
 
-	/* The descriptors must be 32-byte aligned.  There is a
+	/*
+	 * The descriptors must be 32-byte aligned.  There is a
 	 * possibility the allocation will give us such an address,
 	 * and if we try that first we are likely to not waste larger
 	 * slabs of memory.
 	 */
 	desc_base = (u32)kmalloc(entries * sizeof(au1x_ddma_desc_t),
-			GFP_KERNEL|GFP_DMA);
+				 GFP_KERNEL|GFP_DMA);
 	if (desc_base == 0)
 		return 0;
 
 	if (desc_base & 0x1f) {
-		/* Lost....do it again, allocate extra, and round
+		/*
+		 * Lost....do it again, allocate extra, and round
 		 * the address base.
 		 */
 		kfree((const void *)desc_base);
 		i = entries * sizeof(au1x_ddma_desc_t);
 		i += (sizeof(au1x_ddma_desc_t) - 1);
-		if ((desc_base = (u32)kmalloc(i, GFP_KERNEL|GFP_DMA)) == 0)
+		desc_base = (u32)kmalloc(i, GFP_KERNEL|GFP_DMA);
+		if (desc_base == 0)
 			return 0;
 
 		desc_base = ALIGN_ADDR(desc_base, sizeof(au1x_ddma_desc_t));
 	}
 	dp = (au1x_ddma_desc_t *)desc_base;
 
-	/* Keep track of the base descriptor.
-	*/
+	/* Keep track of the base descriptor. */
 	ctp->chan_desc_base = dp;
 
-	/* Initialize the rings with as much information as we know.
-	 */
+	/* Initialize the rings with as much information as we know. */
 	srcid = stp->dev_id;
 	destid = dtp->dev_id;
 
@@ -426,11 +415,12 @@ au1xxx_dbdma_ring_alloc(u32 chanid, int 
 	cmd0 |= DSCR_CMD0_IE | DSCR_CMD0_CV;
 	cmd0 |= DSCR_CMD0_ST(DSCR_CMD0_ST_NOCHANGE);
 
-        /* is it mem to mem transfer? */
-        if(((DSCR_CUSTOM2DEV_ID(srcid) == DSCR_CMD0_THROTTLE) || (DSCR_CUSTOM2DEV_ID(srcid) == DSCR_CMD0_ALWAYS)) &&
-           ((DSCR_CUSTOM2DEV_ID(destid) == DSCR_CMD0_THROTTLE) || (DSCR_CUSTOM2DEV_ID(destid) == DSCR_CMD0_ALWAYS))) {
-               cmd0 |= DSCR_CMD0_MEM;
-        }
+	/* Is it mem to mem transfer? */
+	if (((DSCR_CUSTOM2DEV_ID(srcid) == DSCR_CMD0_THROTTLE) ||
+	     (DSCR_CUSTOM2DEV_ID(srcid) == DSCR_CMD0_ALWAYS)) &&
+	    ((DSCR_CUSTOM2DEV_ID(destid) == DSCR_CMD0_THROTTLE) ||
+	     (DSCR_CUSTOM2DEV_ID(destid) == DSCR_CMD0_ALWAYS)))
+		cmd0 |= DSCR_CMD0_MEM;
 
 	switch (stp->dev_devwidth) {
 	case 8:
@@ -458,15 +448,17 @@ au1xxx_dbdma_ring_alloc(u32 chanid, int 
 		break;
 	}
 
-	/* If the device is marked as an in/out FIFO, ensure it is
+	/*
+	 * If the device is marked as an in/out FIFO, ensure it is
 	 * set non-coherent.
 	 */
 	if (stp->dev_flags & DEV_FLAGS_IN)
-		cmd0 |= DSCR_CMD0_SN;		/* Source in fifo */
+		cmd0 |= DSCR_CMD0_SN;		/* Source in FIFO */
 	if (dtp->dev_flags & DEV_FLAGS_OUT)
-		cmd0 |= DSCR_CMD0_DN;		/* Destination out fifo */
+		cmd0 |= DSCR_CMD0_DN;		/* Destination out FIFO */
 
-	/* Set up source1.  For now, assume no stride and increment.
+	/*
+	 * Set up source1.  For now, assume no stride and increment.
 	 * A channel attribute update can change this later.
 	 */
 	switch (stp->dev_tsize) {
@@ -485,19 +477,19 @@ au1xxx_dbdma_ring_alloc(u32 chanid, int 
 		break;
 	}
 
-	/* If source input is fifo, set static address.
-	*/
+	/* If source input is FIFO, set static address.	*/
 	if (stp->dev_flags & DEV_FLAGS_IN) {
-		if ( stp->dev_flags & DEV_FLAGS_BURSTABLE )
+		if (stp->dev_flags & DEV_FLAGS_BURSTABLE)
 			src1 |= DSCR_SRC1_SAM(DSCR_xAM_BURST);
 		else
-		src1 |= DSCR_SRC1_SAM(DSCR_xAM_STATIC);
-
+			src1 |= DSCR_SRC1_SAM(DSCR_xAM_STATIC);
 	}
+
 	if (stp->dev_physaddr)
 		src0 = stp->dev_physaddr;
 
-	/* Set up dest1.  For now, assume no stride and increment.
+	/*
+	 * Set up dest1.  For now, assume no stride and increment.
 	 * A channel attribute update can change this later.
 	 */
 	switch (dtp->dev_tsize) {
@@ -516,22 +508,24 @@ au1xxx_dbdma_ring_alloc(u32 chanid, int 
 		break;
 	}
 
-	/* If destination output is fifo, set static address.
-	*/
+	/* If destination output is FIFO, set static address. */
 	if (dtp->dev_flags & DEV_FLAGS_OUT) {
-		if ( dtp->dev_flags & DEV_FLAGS_BURSTABLE )
-	                dest1 |= DSCR_DEST1_DAM(DSCR_xAM_BURST);
-				else
-		dest1 |= DSCR_DEST1_DAM(DSCR_xAM_STATIC);
+		if (dtp->dev_flags & DEV_FLAGS_BURSTABLE)
+			dest1 |= DSCR_DEST1_DAM(DSCR_xAM_BURST);
+		else
+			dest1 |= DSCR_DEST1_DAM(DSCR_xAM_STATIC);
 	}
+
 	if (dtp->dev_physaddr)
 		dest0 = dtp->dev_physaddr;
 
 #if 0
-		printk("did:%x sid:%x cmd0:%x cmd1:%x source0:%x source1:%x dest0:%x dest1:%x\n",
-			dtp->dev_id, stp->dev_id, cmd0, cmd1, src0, src1, dest0, dest1 );
+		printk(KERN_DEBUG "did:%x sid:%x cmd0:%x cmd1:%x source0:%x "
+				  "source1:%x dest0:%x dest1:%x\n",
+				  dtp->dev_id, stp->dev_id, cmd0, cmd1, src0,
+				  src1, dest0, dest1);
 #endif
-	for (i=0; i<entries; i++) {
+	for (i = 0; i < entries; i++) {
 		dp->dscr_cmd0 = cmd0;
 		dp->dscr_cmd1 = cmd1;
 		dp->dscr_source0 = src0;
@@ -545,49 +539,49 @@ au1xxx_dbdma_ring_alloc(u32 chanid, int 
 		dp++;
 	}
 
-	/* Make last descrptor point to the first.
-	*/
+	/* Make last descrptor point to the first. */
 	dp--;
 	dp->dscr_nxtptr = DSCR_NXTPTR(virt_to_phys(ctp->chan_desc_base));
 	ctp->get_ptr = ctp->put_ptr = ctp->cur_ptr = ctp->chan_desc_base;
 
-	return (u32)(ctp->chan_desc_base);
+	return (u32)ctp->chan_desc_base;
 }
 EXPORT_SYMBOL(au1xxx_dbdma_ring_alloc);
 
-/* Put a source buffer into the DMA ring.
+/*
+ * Put a source buffer into the DMA ring.
  * This updates the source pointer and byte count.  Normally used
  * for memory to fifo transfers.
  */
-u32
-_au1xxx_dbdma_put_source(u32 chanid, void *buf, int nbytes, u32 flags)
+u32 _au1xxx_dbdma_put_source(u32 chanid, void *buf, int nbytes, u32 flags)
 {
 	chan_tab_t		*ctp;
 	au1x_ddma_desc_t	*dp;
 
-	/* I guess we could check this to be within the
+	/*
+	 * I guess we could check this to be within the
 	 * range of the table......
 	 */
-	ctp = *((chan_tab_t **)chanid);
+	ctp = *(chan_tab_t **)chanid;
 
-	/* We should have multiple callers for a particular channel,
+	/*
+	 * We should have multiple callers for a particular channel,
 	 * an interrupt doesn't affect this pointer nor the descriptor,
 	 * so no locking should be needed.
 	 */
 	dp = ctp->put_ptr;
 
-	/* If the descriptor is valid, we are way ahead of the DMA
+	/*
+	 * If the descriptor is valid, we are way ahead of the DMA
 	 * engine, so just return an error condition.
 	 */
-	if (dp->dscr_cmd0 & DSCR_CMD0_V) {
+	if (dp->dscr_cmd0 & DSCR_CMD0_V)
 		return 0;
-	}
 
-	/* Load up buffer address and byte count.
-	*/
+	/* Load up buffer address and byte count. */
 	dp->dscr_source0 = virt_to_phys(buf);
 	dp->dscr_cmd1 = nbytes;
-	/* Check flags  */
+	/* Check flags */
 	if (flags & DDMA_FLAGS_IE)
 		dp->dscr_cmd0 |= DSCR_CMD0_IE;
 	if (flags & DDMA_FLAGS_NOIE)
@@ -595,23 +589,21 @@ _au1xxx_dbdma_put_source(u32 chanid, voi
 
 	/*
 	 * There is an errata on the Au1200/Au1550 parts that could result
-	 * in "stale" data being DMA'd. It has to do with the snoop logic on
-	 * the dache eviction buffer.  NONCOHERENT_IO is on by default for
-	 * these parts. If it is fixedin the future, these dma_cache_inv will
+	 * in "stale" data being DMA'ed. It has to do with the snoop logic on
+	 * the cache eviction buffer.  DMA_NONCOHERENT is on by default for
+	 * these parts. If it is fixed in the future, these dma_cache_inv will
 	 * just be nothing more than empty macros. See io.h.
-	 * */
+	 */
 	dma_cache_wback_inv((unsigned long)buf, nbytes);
-        dp->dscr_cmd0 |= DSCR_CMD0_V;        /* Let it rip */
+	dp->dscr_cmd0 |= DSCR_CMD0_V;	/* Let it rip */
 	au_sync();
 	dma_cache_wback_inv((unsigned long)dp, sizeof(dp));
-        ctp->chan_ptr->ddma_dbell = 0;
+	ctp->chan_ptr->ddma_dbell = 0;
 
-	/* Get next descriptor pointer.
-	*/
+	/* Get next descriptor pointer.	*/
 	ctp->put_ptr = phys_to_virt(DSCR_GET_NXTPTR(dp->dscr_nxtptr));
 
-	/* return something not zero.
-	*/
+	/* Return something non-zero. */
 	return nbytes;
 }
 EXPORT_SYMBOL(_au1xxx_dbdma_put_source);
@@ -654,81 +646,77 @@ _au1xxx_dbdma_put_dest(u32 chanid, void 
 	dp->dscr_dest0 = virt_to_phys(buf);
 	dp->dscr_cmd1 = nbytes;
 #if 0
-	printk("cmd0:%x cmd1:%x source0:%x source1:%x dest0:%x dest1:%x\n",
-			dp->dscr_cmd0, dp->dscr_cmd1, dp->dscr_source0,
-			dp->dscr_source1, dp->dscr_dest0, dp->dscr_dest1 );
+	printk(KERN_DEBUG "cmd0:%x cmd1:%x source0:%x source1:%x dest0:%x dest1:%x\n",
+			  dp->dscr_cmd0, dp->dscr_cmd1, dp->dscr_source0,
+			  dp->dscr_source1, dp->dscr_dest0, dp->dscr_dest1);
 #endif
 	/*
 	 * There is an errata on the Au1200/Au1550 parts that could result in
-	 * "stale" data being DMA'd. It has to do with the snoop logic on the
-	 * dache eviction buffer. NONCOHERENT_IO is on by default for these
-	 * parts. If it is fixedin the future, these dma_cache_inv will just
+	 * "stale" data being DMA'ed. It has to do with the snoop logic on the
+	 * cache eviction buffer.  DMA_NONCOHERENT is on by default for these
+	 * parts. If it is fixed in the future, these dma_cache_inv will just
 	 * be nothing more than empty macros. See io.h.
-	 * */
+	 */
 	dma_cache_inv((unsigned long)buf, nbytes);
 	dp->dscr_cmd0 |= DSCR_CMD0_V;	/* Let it rip */
 	au_sync();
 	dma_cache_wback_inv((unsigned long)dp, sizeof(dp));
-        ctp->chan_ptr->ddma_dbell = 0;
+	ctp->chan_ptr->ddma_dbell = 0;
 
-	/* Get next descriptor pointer.
-	*/
+	/* Get next descriptor pointer.	*/
 	ctp->put_ptr = phys_to_virt(DSCR_GET_NXTPTR(dp->dscr_nxtptr));
 
-	/* return something not zero.
-	*/
+	/* Return something non-zero. */
 	return nbytes;
 }
 EXPORT_SYMBOL(_au1xxx_dbdma_put_dest);
 
-/* Get a destination buffer into the DMA ring.
+/*
+ * Get a destination buffer into the DMA ring.
  * Normally used to get a full buffer from the ring during fifo
  * to memory transfers.  This does not set the valid bit, you will
  * have to put another destination buffer to keep the DMA going.
  */
-u32
-au1xxx_dbdma_get_dest(u32 chanid, void **buf, int *nbytes)
+u32 au1xxx_dbdma_get_dest(u32 chanid, void **buf, int *nbytes)
 {
 	chan_tab_t		*ctp;
 	au1x_ddma_desc_t	*dp;
 	u32			rv;
 
-	/* I guess we could check this to be within the
+	/*
+	 * I guess we could check this to be within the
 	 * range of the table......
 	 */
 	ctp = *((chan_tab_t **)chanid);
 
-	/* We should have multiple callers for a particular channel,
+	/*
+	 * We should have multiple callers for a particular channel,
 	 * an interrupt doesn't affect this pointer nor the descriptor,
 	 * so no locking should be needed.
 	 */
 	dp = ctp->get_ptr;
 
-	/* If the descriptor is valid, we are way ahead of the DMA
+	/*
+	 * If the descriptor is valid, we are way ahead of the DMA
 	 * engine, so just return an error condition.
 	 */
 	if (dp->dscr_cmd0 & DSCR_CMD0_V)
 		return 0;
 
-	/* Return buffer address and byte count.
-	*/
+	/* Return buffer address and byte count. */
 	*buf = (void *)(phys_to_virt(dp->dscr_dest0));
 	*nbytes = dp->dscr_cmd1;
 	rv = dp->dscr_stat;
 
-	/* Get next descriptor pointer.
-	*/
+	/* Get next descriptor pointer.	*/
 	ctp->get_ptr = phys_to_virt(DSCR_GET_NXTPTR(dp->dscr_nxtptr));
 
-	/* return something not zero.
-	*/
+	/* Return something non-zero. */
 	return rv;
 }
-
 EXPORT_SYMBOL_GPL(au1xxx_dbdma_get_dest);
 
-void
-au1xxx_dbdma_stop(u32 chanid)
+void au1xxx_dbdma_stop(u32 chanid)
 {
 	chan_tab_t	*ctp;
 	au1x_dma_chan_t *cp;
@@ -743,7 +731,7 @@ au1xxx_dbdma_stop(u32 chanid)
 		udelay(1);
 		halt_timeout++;
 		if (halt_timeout > 100) {
-			printk("warning: DMA channel won't halt\n");
+			printk(KERN_WARNING "warning: DMA channel won't halt\n");
 			break;
 		}
 	}
@@ -753,12 +741,12 @@ au1xxx_dbdma_stop(u32 chanid)
 }
 EXPORT_SYMBOL(au1xxx_dbdma_stop);
 
-/* Start using the current descriptor pointer.  If the dbdma encounters
- * a not valid descriptor, it will stop.  In this case, we can just
+/*
+ * Start using the current descriptor pointer.  If the DBDMA encounters
+ * a non-valid descriptor, it will stop.  In this case, we can just
  * continue by adding a buffer to the list and starting again.
  */
-void
-au1xxx_dbdma_start(u32 chanid)
+void au1xxx_dbdma_start(u32 chanid)
 {
 	chan_tab_t	*ctp;
 	au1x_dma_chan_t *cp;
@@ -773,8 +761,7 @@ au1xxx_dbdma_start(u32 chanid)
 }
 EXPORT_SYMBOL(au1xxx_dbdma_start);
 
-void
-au1xxx_dbdma_reset(u32 chanid)
+void au1xxx_dbdma_reset(u32 chanid)
 {
 	chan_tab_t		*ctp;
 	au1x_ddma_desc_t	*dp;
@@ -784,14 +771,14 @@ au1xxx_dbdma_reset(u32 chanid)
 	ctp = *((chan_tab_t **)chanid);
 	ctp->get_ptr = ctp->put_ptr = ctp->cur_ptr = ctp->chan_desc_base;
 
-	/* Run through the descriptors and reset the valid indicator.
-	*/
+	/* Run through the descriptors and reset the valid indicator. */
 	dp = ctp->chan_desc_base;
 
 	do {
 		dp->dscr_cmd0 &= ~DSCR_CMD0_V;
-		/* reset our SW status -- this is used to determine
-		 * if a descriptor is in use by upper level SW. Since
+		/*
+		 * Reset our software status -- this is used to determine
+		 * if a descriptor is in use by upper level software. Since
 		 * posting can reset 'V' bit.
 		 */
 		dp->sw_status = 0;
@@ -800,8 +787,7 @@ au1xxx_dbdma_reset(u32 chanid)
 }
 EXPORT_SYMBOL(au1xxx_dbdma_reset);
 
-u32
-au1xxx_get_dma_residue(u32 chanid)
+u32 au1xxx_get_dma_residue(u32 chanid)
 {
 	chan_tab_t	*ctp;
 	au1x_dma_chan_t *cp;
@@ -810,18 +796,15 @@ au1xxx_get_dma_residue(u32 chanid)
 	ctp = *((chan_tab_t **)chanid);
 	cp = ctp->chan_ptr;
 
-	/* This is only valid if the channel is stopped.
-	*/
+	/* This is only valid if the channel is stopped. */
 	rv = cp->ddma_bytecnt;
 	au_sync();
 
 	return rv;
 }
-
 EXPORT_SYMBOL_GPL(au1xxx_get_dma_residue);
 
-void
-au1xxx_dbdma_chan_free(u32 chanid)
+void au1xxx_dbdma_chan_free(u32 chanid)
 {
 	chan_tab_t	*ctp;
 	dbdev_tab_t	*stp, *dtp;
@@ -842,8 +825,7 @@ au1xxx_dbdma_chan_free(u32 chanid)
 }
 EXPORT_SYMBOL(au1xxx_dbdma_chan_free);
 
-static irqreturn_t
-dbdma_interrupt(int irq, void *dev_id)
+static irqreturn_t dbdma_interrupt(int irq, void *dev_id)
 {
 	u32 intstat;
 	u32 chan_index;
@@ -859,13 +841,12 @@ dbdma_interrupt(int irq, void *dev_id)
 	cp = ctp->chan_ptr;
 	dp = ctp->cur_ptr;
 
-	/* Reset interrupt.
-	*/
+	/* Reset interrupt. */
 	cp->ddma_irq = 0;
 	au_sync();
 
 	if (ctp->chan_callback)
-		(ctp->chan_callback)(irq, ctp->chan_callparam);
+		ctp->chan_callback(irq, ctp->chan_callparam);
 
 	ctp->cur_ptr = phys_to_virt(DSCR_GET_NXTPTR(dp->dscr_nxtptr));
 	return IRQ_RETVAL(1);
@@ -890,47 +871,47 @@ static void au1xxx_dbdma_init(void)
 
 	if (request_irq(irq_nr, dbdma_interrupt, IRQF_DISABLED,
 			"Au1xxx dbdma", (void *)dbdma_gptr))
-		printk("Can't get 1550 dbdma irq");
+		printk(KERN_ERR "Can't get 1550 dbdma irq");
 }
 
-void
-au1xxx_dbdma_dump(u32 chanid)
+void au1xxx_dbdma_dump(u32 chanid)
 {
-	chan_tab_t		*ctp;
-	au1x_ddma_desc_t	*dp;
-	dbdev_tab_t		*stp, *dtp;
-	au1x_dma_chan_t *cp;
-		u32			i = 0;
+	chan_tab_t	 *ctp;
+	au1x_ddma_desc_t *dp;
+	dbdev_tab_t	 *stp, *dtp;
+	au1x_dma_chan_t  *cp;
+	u32 i		 = 0;
 
 	ctp = *((chan_tab_t **)chanid);
 	stp = ctp->chan_src;
 	dtp = ctp->chan_dest;
 	cp = ctp->chan_ptr;
 
-	printk("Chan %x, stp %x (dev %d)  dtp %x (dev %d) \n",
-		(u32)ctp, (u32)stp, stp - dbdev_tab, (u32)dtp, dtp - dbdev_tab);
-	printk("desc base %x, get %x, put %x, cur %x\n",
-		(u32)(ctp->chan_desc_base), (u32)(ctp->get_ptr),
-		(u32)(ctp->put_ptr), (u32)(ctp->cur_ptr));
-
-	printk("dbdma chan %x\n", (u32)cp);
-	printk("cfg %08x, desptr %08x, statptr %08x\n",
-		cp->ddma_cfg, cp->ddma_desptr, cp->ddma_statptr);
-	printk("dbell %08x, irq %08x, stat %08x, bytecnt %08x\n",
-		cp->ddma_dbell, cp->ddma_irq, cp->ddma_stat, cp->ddma_bytecnt);
-
+	printk(KERN_DEBUG "Chan %x, stp %x (dev %d)  dtp %x (dev %d) \n",
+			  (u32)ctp, (u32)stp, stp - dbdev_tab, (u32)dtp,
+			  dtp - dbdev_tab);
+	printk(KERN_DEBUG "desc base %x, get %x, put %x, cur %x\n",
+			  (u32)(ctp->chan_desc_base), (u32)(ctp->get_ptr),
+			  (u32)(ctp->put_ptr), (u32)(ctp->cur_ptr));
+
+	printk(KERN_DEBUG "dbdma chan %x\n", (u32)cp);
+	printk(KERN_DEBUG "cfg %08x, desptr %08x, statptr %08x\n",
+			  cp->ddma_cfg, cp->ddma_desptr, cp->ddma_statptr);
+	printk(KERN_DEBUG "dbell %08x, irq %08x, stat %08x, bytecnt %08x\n",
+			  cp->ddma_dbell, cp->ddma_irq, cp->ddma_stat,
+			  cp->ddma_bytecnt);
 
-	/* Run through the descriptors
-	*/
+	/* Run through the descriptors */
 	dp = ctp->chan_desc_base;
 
 	do {
-                printk("Dp[%d]= %08x, cmd0 %08x, cmd1 %08x\n",
-                        i++, (u32)dp, dp->dscr_cmd0, dp->dscr_cmd1);
-                printk("src0 %08x, src1 %08x, dest0 %08x, dest1 %08x\n",
-                        dp->dscr_source0, dp->dscr_source1, dp->dscr_dest0, dp->dscr_dest1);
-                printk("stat %08x, nxtptr %08x\n",
-                        dp->dscr_stat, dp->dscr_nxtptr);
+		printk(KERN_DEBUG "Dp[%d]= %08x, cmd0 %08x, cmd1 %08x\n",
+				  i++, (u32)dp, dp->dscr_cmd0, dp->dscr_cmd1);
+		printk(KERN_DEBUG "src0 %08x, src1 %08x, dest0 %08x, dest1 %08x\n",
+				  dp->dscr_source0, dp->dscr_source1,
+				  dp->dscr_dest0, dp->dscr_dest1);
+		printk(KERN_DEBUG "stat %08x, nxtptr %08x\n",
+				  dp->dscr_stat, dp->dscr_nxtptr);
 		dp = phys_to_virt(DSCR_GET_NXTPTR(dp->dscr_nxtptr));
 	} while (dp != ctp->chan_desc_base);
 }
@@ -938,32 +919,33 @@ au1xxx_dbdma_dump(u32 chanid)
 /* Put a descriptor into the DMA ring.
  * This updates the source/destination pointers and byte count.
  */
-u32
-au1xxx_dbdma_put_dscr(u32 chanid, au1x_ddma_desc_t *dscr )
+u32 au1xxx_dbdma_put_dscr(u32 chanid, au1x_ddma_desc_t *dscr)
 {
 	chan_tab_t *ctp;
 	au1x_ddma_desc_t *dp;
-	u32 nbytes=0;
+	u32 nbytes = 0;
 
-	/* I guess we could check this to be within the
-	* range of the table......
-	*/
+	/*
+	 * I guess we could check this to be within the
+	 * range of the table......
+	 */
 	ctp = *((chan_tab_t **)chanid);
 
-	/* We should have multiple callers for a particular channel,
-	* an interrupt doesn't affect this pointer nor the descriptor,
-	* so no locking should be needed.
-	*/
+	/*
+	 * We should have multiple callers for a particular channel,
+	 * an interrupt doesn't affect this pointer nor the descriptor,
+	 * so no locking should be needed.
+	 */
 	dp = ctp->put_ptr;
 
-	/* If the descriptor is valid, we are way ahead of the DMA
-	* engine, so just return an error condition.
-	*/
+	/*
+	 * If the descriptor is valid, we are way ahead of the DMA
+	 * engine, so just return an error condition.
+	 */
 	if (dp->dscr_cmd0 & DSCR_CMD0_V)
 		return 0;
 
-	/* Load up buffer addresses and byte count.
-	*/
+	/* Load up buffer addresses and byte count. */
 	dp->dscr_dest0 = dscr->dscr_dest0;
 	dp->dscr_source0 = dscr->dscr_source0;
 	dp->dscr_dest1 = dscr->dscr_dest1;
@@ -975,14 +957,11 @@ au1xxx_dbdma_put_dscr(u32 chanid, au1x_d
 	dp->dscr_cmd0 |= dscr->dscr_cmd0 | DSCR_CMD0_V;
 	ctp->chan_ptr->ddma_dbell = 0;
 
-	/* Get next descriptor pointer.
-	*/
+	/* Get next descriptor pointer.	*/
 	ctp->put_ptr = phys_to_virt(DSCR_GET_NXTPTR(dp->dscr_nxtptr));
 
-	/* return something not zero.
-	*/
+	/* Return something non-zero. */
 	return nbytes;
 }
 
 #endif /* defined(CONFIG_SOC_AU1550) || defined(CONFIG_SOC_AU1200) */
-
Index: linux-2.6/arch/mips/au1000/common/dbg_io.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/common/dbg_io.c
+++ linux-2.6/arch/mips/au1000/common/dbg_io.c
@@ -1,3 +1,4 @@
+#include <linux/types.h>
 
 #include <asm/mach-au1x00/au1000.h>
 
@@ -8,12 +9,6 @@
  * uart to be used for debugging.
  */
 #define DEBUG_BASE  UART_DEBUG_BASE
-/**/
-
-/* we need uint32 uint8 */
-/* #include "types.h" */
-typedef         unsigned char uint8;
-typedef         unsigned int  uint32;
 
 #define         UART16550_BAUD_2400             2400
 #define         UART16550_BAUD_4800             4800
@@ -51,17 +46,15 @@ typedef         unsigned int  uint32;
 #define UART_MOD_CNTRL	0x100	/* Module Control */
 
 /* memory-mapped read/write of the port */
-#define UART16550_READ(y)    (au_readl(DEBUG_BASE + y) & 0xff)
-#define UART16550_WRITE(y, z) (au_writel(z&0xff, DEBUG_BASE + y))
+#define UART16550_READ(y)     (au_readl(DEBUG_BASE + y) & 0xff)
+#define UART16550_WRITE(y, z) (au_writel(z & 0xff, DEBUG_BASE + y))
 
 extern unsigned long calc_clock(void);
 
-void debugInit(uint32 baud, uint8 data, uint8 parity, uint8 stop)
+void debugInit(u32 baud, u8 data, u8 parity, u8 stop)
 {
-
-	if (UART16550_READ(UART_MOD_CNTRL) != 0x3) {
+	if (UART16550_READ(UART_MOD_CNTRL) != 0x3)
 		UART16550_WRITE(UART_MOD_CNTRL, 3);
-	}
 	calc_clock();
 
 	/* disable interrupts */
@@ -69,7 +62,7 @@ void debugInit(uint32 baud, uint8 data, 
 
 	/* set up baud rate */
 	{
-		uint32 divisor;
+		u32 divisor;
 
 		/* set divisor */
 		divisor = get_au1x00_uart_baud_base() / baud;
@@ -80,9 +73,9 @@ void debugInit(uint32 baud, uint8 data, 
 	UART16550_WRITE(UART_LCR, (data | parity | stop));
 }
 
-static int remoteDebugInitialized = 0;
+static int remoteDebugInitialized;
 
-uint8 getDebugChar(void)
+u8 getDebugChar(void)
 {
 	if (!remoteDebugInitialized) {
 		remoteDebugInitialized = 1;
@@ -92,15 +85,13 @@ uint8 getDebugChar(void)
 			  UART16550_STOP_1BIT);
 	}
 
-	while((UART16550_READ(UART_LSR) & 0x1) == 0);
+	while ((UART16550_READ(UART_LSR) & 0x1) == 0);
 	return UART16550_READ(UART_RX);
 }
 
 
-int putDebugChar(uint8 byte)
+int putDebugChar(u8 byte)
 {
-//	int i;
-
 	if (!remoteDebugInitialized) {
 		remoteDebugInitialized = 1;
 		debugInit(UART16550_BAUD_115200,
@@ -109,9 +100,8 @@ int putDebugChar(uint8 byte)
 			  UART16550_STOP_1BIT);
 	}
 
-	while ((UART16550_READ(UART_LSR)&0x40) == 0);
+	while ((UART16550_READ(UART_LSR) & 0x40) == 0);
 	UART16550_WRITE(UART_TX, byte);
-	//for (i=0;i<0xfff;i++);
 
 	return 1;
 }
Index: linux-2.6/arch/mips/au1000/common/dma.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/common/dma.c
+++ linux-2.6/arch/mips/au1000/common/dma.c
@@ -1,12 +1,11 @@
 /*
  *
  * BRIEF MODULE DESCRIPTION
- *      A DMA channel allocator for Au1000. API is modeled loosely off of
+ *      A DMA channel allocator for Au1x00. API is modeled loosely off of
  *      linux/kernel/dma.c.
  *
- * Copyright 2000 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *         	stevel@mvista.com or source@mvista.com
+ * Copyright 2000, 2008 MontaVista Software Inc.
+ * Author: MontaVista Software, Inc. <source@mvista.com>
  * Copyright (C) 2005 Ralf Baechle (ralf@linux-mips.org)
  *
  *  This program is free software; you can redistribute  it and/or modify it
@@ -39,7 +38,8 @@
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-au1x00/au1000_dma.h>
 
-#if defined(CONFIG_SOC_AU1000) || defined(CONFIG_SOC_AU1500) || defined(CONFIG_SOC_AU1100)
+#if defined(CONFIG_SOC_AU1000) || defined(CONFIG_SOC_AU1500) || \
+    defined(CONFIG_SOC_AU1100)
 /*
  * A note on resource allocation:
  *
@@ -56,7 +56,6 @@
  * returned from request_dma.
  */
 
-
 DEFINE_SPINLOCK(au1000_dma_spin_lock);
 
 struct dma_chan au1000_dma_table[NUM_AU1000_DMA_CHANNELS] = {
@@ -71,7 +70,7 @@ struct dma_chan au1000_dma_table[NUM_AU1
 };
 EXPORT_SYMBOL(au1000_dma_table);
 
-// Device FIFO addresses and default DMA modes
+/* Device FIFO addresses and default DMA modes */
 static const struct dma_dev {
 	unsigned int fifo_addr;
 	unsigned int dma_mode;
@@ -80,8 +79,8 @@ static const struct dma_dev {
 	{UART0_ADDR + UART_RX, 0},
 	{0, 0},
 	{0, 0},
-	{AC97C_DATA, DMA_DW16 },          // coherent
-	{AC97C_DATA, DMA_DR | DMA_DW16 }, // coherent
+	{AC97C_DATA, DMA_DW16 },          /* coherent */
+	{AC97C_DATA, DMA_DR | DMA_DW16 }, /* coherent */
 	{UART3_ADDR + UART_TX, DMA_DW8 | DMA_NC},
 	{UART3_ADDR + UART_RX, DMA_DR | DMA_DW8 | DMA_NC},
 	{USBD_EP0RD, DMA_DR | DMA_DW8 | DMA_NC},
@@ -101,10 +100,10 @@ int au1000_dma_read_proc(char *buf, char
 	struct dma_chan *chan;
 
 	for (i = 0; i < NUM_AU1000_DMA_CHANNELS; i++) {
-		if ((chan = get_dma_chan(i)) != NULL) {
+		chan = get_dma_chan(i);
+		if (chan != NULL)
 			len += sprintf(buf + len, "%2d: %s\n",
 				       i, chan->dev_str);
-		}
 	}
 
 	if (fpos >= len) {
@@ -113,18 +112,19 @@ int au1000_dma_read_proc(char *buf, char
 		return 0;
 	}
 	*start = buf + fpos;
-	if ((len -= fpos) > length)
+	len -= fpos;
+	if (len > length)
 		return length;
 	*eof = 1;
 	return len;
 }
 
-// Device FIFO addresses and default DMA modes - 2nd bank
+/* Device FIFO addresses and default DMA modes - 2nd bank */
 static const struct dma_dev dma_dev_table_bank2[DMA_NUM_DEV_BANK2] = {
-	{SD0_XMIT_FIFO, DMA_DS | DMA_DW8},		// coherent
-	{SD0_RECV_FIFO, DMA_DS | DMA_DR | DMA_DW8},	// coherent
-	{SD1_XMIT_FIFO, DMA_DS | DMA_DW8},		// coherent
-	{SD1_RECV_FIFO, DMA_DS | DMA_DR | DMA_DW8}	// coherent
+	{ SD0_XMIT_FIFO, DMA_DS | DMA_DW8 },		/* coherent */
+	{ SD0_RECV_FIFO, DMA_DS | DMA_DR | DMA_DW8 },	/* coherent */
+	{ SD1_XMIT_FIFO, DMA_DS | DMA_DW8 },		/* coherent */
+	{ SD1_RECV_FIFO, DMA_DS | DMA_DR | DMA_DW8 }	/* coherent */
 };
 
 void dump_au1000_dma_channel(unsigned int dmanr)
@@ -150,7 +150,6 @@ void dump_au1000_dma_channel(unsigned in
 	       au_readl(chan->io + DMA_BUFFER1_COUNT));
 }
 
-
 /*
  * Finds a free channel, and binds the requested device to it.
  * Returns the allocated channel number, or negative on error.
@@ -169,14 +168,14 @@ int request_au1000_dma(int dev_id, const
 	if (dev_id < 0 || dev_id >= (DMA_NUM_DEV + DMA_NUM_DEV_BANK2))
 		return -EINVAL;
 #else
- 	if (dev_id < 0 || dev_id >= DMA_NUM_DEV)
+	if (dev_id < 0 || dev_id >= DMA_NUM_DEV)
 		return -EINVAL;
 #endif
 
-	for (i = 0; i < NUM_AU1000_DMA_CHANNELS; i++) {
+	for (i = 0; i < NUM_AU1000_DMA_CHANNELS; i++)
 		if (au1000_dma_table[i].dev_id < 0)
 			break;
-	}
+
 	if (i == NUM_AU1000_DMA_CHANNELS)
 		return -ENODEV;
 
@@ -185,15 +184,15 @@ int request_au1000_dma(int dev_id, const
 	if (dev_id >= DMA_NUM_DEV) {
 		dev_id -= DMA_NUM_DEV;
 		dev = &dma_dev_table_bank2[dev_id];
-	} else {
+	} else
 		dev = &dma_dev_table[dev_id];
-	}
 
 	if (irqhandler) {
 		chan->irq = AU1000_DMA_INT_BASE + i;
 		chan->irq_dev = irq_dev_id;
-		if ((ret = request_irq(chan->irq, irqhandler, irqflags,
-				       dev_str, chan->irq_dev))) {
+		ret = request_irq(chan->irq, irqhandler, irqflags, dev_str,
+				  chan->irq_dev);
+		if (ret) {
 			chan->irq = 0;
 			chan->irq_dev = NULL;
 			return ret;
@@ -203,7 +202,7 @@ int request_au1000_dma(int dev_id, const
 		chan->irq_dev = NULL;
 	}
 
-	// fill it in
+	/* fill it in */
 	chan->io = DMA_CHANNEL_BASE + i * DMA_CHANNEL_LEN;
 	chan->dev_id = dev_id;
 	chan->dev_str = dev_str;
@@ -220,8 +219,9 @@ EXPORT_SYMBOL(request_au1000_dma);
 void free_au1000_dma(unsigned int dmanr)
 {
 	struct dma_chan *chan = get_dma_chan(dmanr);
+
 	if (!chan) {
-		printk("Trying to free DMA%d\n", dmanr);
+		printk(KERN_ERR "Error trying to free DMA%d\n", dmanr);
 		return;
 	}
 
@@ -235,4 +235,4 @@ void free_au1000_dma(unsigned int dmanr)
 }
 EXPORT_SYMBOL(free_au1000_dma);
 
-#endif // AU1000 AU1500 AU1100
+#endif /* AU1000 AU1500 AU1100 */
Index: linux-2.6/arch/mips/au1000/common/gpio.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/common/gpio.c
+++ linux-2.6/arch/mips/au1000/common/gpio.c
@@ -69,7 +69,7 @@ static int au1xxx_gpio2_direction_output
 
 static int au1xxx_gpio1_read(unsigned gpio)
 {
-	return ((gpio1->pinstaterd >> gpio) & 0x01);
+	return (gpio1->pinstaterd >> gpio) & 0x01;
 }
 
 static void au1xxx_gpio1_write(unsigned gpio, int value)
@@ -104,7 +104,6 @@ int au1xxx_gpio_get_value(unsigned gpio)
 	else
 		return au1xxx_gpio1_read(gpio);
 }
-
 EXPORT_SYMBOL(au1xxx_gpio_get_value);
 
 void au1xxx_gpio_set_value(unsigned gpio, int value)
@@ -118,7 +117,6 @@ void au1xxx_gpio_set_value(unsigned gpio
 	else
 		au1xxx_gpio1_write(gpio, value);
 }
-
 EXPORT_SYMBOL(au1xxx_gpio_set_value);
 
 int au1xxx_gpio_direction_input(unsigned gpio)
@@ -132,7 +130,6 @@ int au1xxx_gpio_direction_input(unsigned
 
 	return au1xxx_gpio1_direction_input(gpio);
 }
-
 EXPORT_SYMBOL(au1xxx_gpio_direction_input);
 
 int au1xxx_gpio_direction_output(unsigned gpio, int value)
@@ -146,5 +143,4 @@ int au1xxx_gpio_direction_output(unsigne
 
 	return au1xxx_gpio1_direction_output(gpio, value);
 }
-
 EXPORT_SYMBOL(au1xxx_gpio_direction_output);
Index: linux-2.6/arch/mips/au1000/common/irq.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/common/irq.c
+++ linux-2.6/arch/mips/au1000/common/irq.c
@@ -210,10 +210,8 @@ static inline void mask_and_ack_either_e
 	au_sync();
 }
 
-
 static inline void mask_and_ack_level_irq(unsigned int irq_nr)
 {
-
 	local_disable_irq(irq_nr);
 	au_sync();
 #if defined(CONFIG_MIPS_PB1000)
@@ -263,14 +261,14 @@ void restore_local_and_enable(int contro
 	unsigned long flags, new_mask;
 
 	spin_lock_irqsave(&irq_lock, flags);
-	for (i = 0; i < 32; i++) {
+	for (i = 0; i < 32; i++)
 		if (mask & (1 << i)) {
 			if (controller)
 				local_enable_irq(i + 32);
 			else
 				local_enable_irq(i);
 		}
-	}
+
 	if (controller)
 		new_mask = au_readl(IC1_MASKSET);
 	else
Index: linux-2.6/arch/mips/au1000/common/pci.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/common/pci.c
+++ linux-2.6/arch/mips/au1000/common/pci.c
@@ -2,9 +2,8 @@
  * BRIEF MODULE DESCRIPTION
  *	Alchemy/AMD Au1x00 PCI support.
  *
- * Copyright 2001-2003, 2007 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *         	ppopov@mvista.com or source@mvista.com
+ * Copyright 2001-2003, 2007-2008 MontaVista Software Inc.
+ * Author: MontaVista Software, Inc. <source@mvista.com>
  *
  * Copyright (C) 2004 by Ralf Baechle (ralf@linux-mips.org)
  *
@@ -86,9 +85,9 @@ static int __init au1x_pci_setup(void)
 		u32 prid = read_c0_prid();
 
 		if ((prid & 0xFF000000) == 0x01000000 && prid < 0x01030202) {
-		       au_writel((1 << 16) | au_readl(Au1500_PCI_CFG),
-			         Au1500_PCI_CFG);
-		       printk("Non-coherent PCI accesses enabled\n");
+			au_writel((1 << 16) | au_readl(Au1500_PCI_CFG),
+				  Au1500_PCI_CFG);
+			printk(KERN_INFO "Non-coherent PCI accesses enabled\n");
 		}
 	}
 #endif
Index: linux-2.6/arch/mips/au1000/common/platform.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/common/platform.c
+++ linux-2.6/arch/mips/au1000/common/platform.c
@@ -302,16 +302,17 @@ static struct platform_device *au1xxx_pl
 #endif
 };
 
-int __init au1xxx_platform_init(void)
+static int __init au1xxx_platform_init(void)
 {
 	unsigned int uartclk = get_au1x00_uart_baud_base() * 16;
 	int i;
 
 	/* Fill up uartclk. */
-	for (i = 0; au1x00_uart_data[i].flags ; i++)
+	for (i = 0; au1x00_uart_data[i].flags; i++)
 		au1x00_uart_data[i].uartclk = uartclk;
 
-	return platform_add_devices(au1xxx_platform_devices, ARRAY_SIZE(au1xxx_platform_devices));
+	return platform_add_devices(au1xxx_platform_devices,
+				    ARRAY_SIZE(au1xxx_platform_devices));
 }
 
 arch_initcall(au1xxx_platform_init);
Index: linux-2.6/arch/mips/au1000/common/power.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/common/power.c
+++ linux-2.6/arch/mips/au1000/common/power.c
@@ -1,10 +1,9 @@
 /*
  * BRIEF MODULE DESCRIPTION
- *	Au1000 Power Management routines.
+ *	Au1xx0 Power Management routines.
  *
- * Copyright 2001 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *		ppopov@mvista.com or source@mvista.com
+ * Copyright 2001, 2008 MontaVista Software Inc.
+ * Author: MontaVista Software, Inc. <source@mvista.com>
  *
  *  Some of the routines are right out of init/main.c, whose
  *  copyrights apply here.
@@ -43,10 +42,10 @@
 #ifdef CONFIG_PM
 
 #define DEBUG 1
-#ifdef DEBUG
-#  define DPRINTK(fmt, args...)	printk("%s: " fmt, __func__, ## args)
+#ifdef	DEBUG
+#define DPRINTK(fmt, args...)	printk(KERN_DEBUG "%s: " fmt, __func__, ## args)
 #else
-#  define DPRINTK(fmt, args...)
+#define DPRINTK(fmt, args...)
 #endif
 
 static void au1000_calibrate_delay(void);
@@ -57,7 +56,8 @@ extern void local_enable_irq(unsigned in
 
 static DEFINE_SPINLOCK(pm_lock);
 
-/* We need to save/restore a bunch of core registers that are
+/*
+ * We need to save/restore a bunch of core registers that are
  * either volatile or reset to some state across a processor sleep.
  * If reading a register doesn't provide a proper result for a
  * later restore, we have to provide a function for loading that
@@ -78,24 +78,25 @@ static unsigned int	sleep_usbhost_enable
 static unsigned int	sleep_usbdev_enable;
 static unsigned int	sleep_static_memctlr[4][3];
 
-/* Define this to cause the value you write to /proc/sys/pm/sleep to
+/*
+ * Define this to cause the value you write to /proc/sys/pm/sleep to
  * set the TOY timer for the amount of time you want to sleep.
  * This is done mainly for testing, but may be useful in other cases.
  * The value is number of 32KHz ticks to sleep.
  */
 #define SLEEP_TEST_TIMEOUT 1
-#ifdef SLEEP_TEST_TIMEOUT
-static	int	sleep_ticks;
+#ifdef	SLEEP_TEST_TIMEOUT
+static int sleep_ticks;
 void wakeup_counter0_set(int ticks);
 #endif
 
-static void
-save_core_regs(void)
+static void save_core_regs(void)
 {
 	extern void save_au1xxx_intctl(void);
 	extern void pm_eth0_shutdown(void);
 
-	/* Do the serial ports.....these really should be a pm_*
+	/*
+	 * Do the serial ports.....these really should be a pm_*
 	 * registered function by the driver......but of course the
 	 * standard serial driver doesn't understand our Au1xxx
 	 * unique registers.
@@ -106,27 +107,24 @@ save_core_regs(void)
 	sleep_uart0_clkdiv = au_readl(UART0_ADDR + UART_CLK);
 	sleep_uart0_enable = au_readl(UART0_ADDR + UART_MOD_CNTRL);
 
-	/* Shutdown USB host/device.
-	*/
+	/* Shutdown USB host/device. */
 	sleep_usbhost_enable = au_readl(USB_HOST_CONFIG);
 
-	/* There appears to be some undocumented reset register....
-	*/
+	/* There appears to be some undocumented reset register.... */
 	au_writel(0, 0xb0100004); au_sync();
 	au_writel(0, USB_HOST_CONFIG); au_sync();
 
 	sleep_usbdev_enable = au_readl(USBD_ENABLE);
 	au_writel(0, USBD_ENABLE); au_sync();
 
-	/* Save interrupt controller state.
-	*/
+	/* Save interrupt controller state. */
 	save_au1xxx_intctl();
 
-	/* Clocks and PLLs.
-	*/
+	/* Clocks and PLLs. */
 	sleep_aux_pll_cntrl = au_readl(SYS_AUXPLL);
 
-	/* We don't really need to do this one, but unless we
+	/*
+	 * We don't really need to do this one, but unless we
 	 * write it again it won't have a valid value if we
 	 * happen to read it.
 	 */
@@ -134,8 +132,7 @@ save_core_regs(void)
 
 	sleep_pin_function = au_readl(SYS_PINFUNC);
 
-	/* Save the static memory controller configuration.
-	*/
+	/* Save the static memory controller configuration. */
 	sleep_static_memctlr[0][0] = au_readl(MEM_STCFG0);
 	sleep_static_memctlr[0][1] = au_readl(MEM_STTIME0);
 	sleep_static_memctlr[0][2] = au_readl(MEM_STADDR0);
@@ -150,8 +147,7 @@ save_core_regs(void)
 	sleep_static_memctlr[3][2] = au_readl(MEM_STADDR3);
 }
 
-static void
-restore_core_regs(void)
+static void restore_core_regs(void)
 {
 	extern void restore_au1xxx_intctl(void);
 	extern void wakeup_counter0_adjust(void);
@@ -160,8 +156,7 @@ restore_core_regs(void)
 	au_writel(sleep_cpu_pll_cntrl, SYS_CPUPLL); au_sync();
 	au_writel(sleep_pin_function, SYS_PINFUNC); au_sync();
 
-	/* Restore the static memory controller configuration.
-	*/
+	/* Restore the static memory controller configuration. */
 	au_writel(sleep_static_memctlr[0][0], MEM_STCFG0);
 	au_writel(sleep_static_memctlr[0][1], MEM_STTIME0);
 	au_writel(sleep_static_memctlr[0][2], MEM_STADDR0);
@@ -175,7 +170,8 @@ restore_core_regs(void)
 	au_writel(sleep_static_memctlr[3][1], MEM_STTIME3);
 	au_writel(sleep_static_memctlr[3][2], MEM_STADDR3);
 
-	/* Enable the UART if it was enabled before sleep.
+	/*
+	 * Enable the UART if it was enabled before sleep.
 	 * I guess I should define module control bits........
 	 */
 	if (sleep_uart0_enable & 0x02) {
@@ -202,7 +198,7 @@ void wakeup_from_suspend(void)
 int au_sleep(void)
 {
 	unsigned long wakeup, flags;
-	extern	void	save_and_sleep(void);
+	extern void save_and_sleep(void);
 
 	spin_lock_irqsave(&pm_lock, flags);
 
@@ -210,23 +206,22 @@ int au_sleep(void)
 
 	flush_cache_all();
 
-	/** The code below is all system dependent and we should probably
+	/**
+	 ** The code below is all system dependent and we should probably
 	 ** have a function call out of here to set this up.  You need
 	 ** to configure the GPIO or timer interrupts that will bring
 	 ** you out of sleep.
 	 ** For testing, the TOY counter wakeup is useful.
 	 **/
-
 #if 0
 	au_writel(au_readl(SYS_PINSTATERD) & ~(1 << 11), SYS_PINSTATERD);
 
-	/* gpio 6 can cause a wake up event */
+	/* GPIO 6 can cause a wake up event */
 	wakeup = au_readl(SYS_WAKEMSK);
 	wakeup &= ~(1 << 8);	/* turn off match20 wakeup */
-	wakeup |= 1 << 6;	/* turn on gpio 6 wakeup   */
+	wakeup |= 1 << 6;	/* turn on  GPIO  6 wakeup */
 #else
-	/* For testing, allow match20 to wake us up.
-	*/
+	/* For testing, allow match20 to wake us up. */
 #ifdef SLEEP_TEST_TIMEOUT
 	wakeup_counter0_set(sleep_ticks);
 #endif
@@ -240,7 +235,8 @@ int au_sleep(void)
 
 	save_and_sleep();
 
-	/* after a wakeup, the cpu vectors back to 0x1fc00000 so
+	/*
+	 * After a wakeup, the cpu vectors back to 0x1fc00000, so
 	 * it's up to the boot code to get us back here.
 	 */
 	restore_core_regs();
@@ -248,8 +244,8 @@ int au_sleep(void)
 	return 0;
 }
 
-static int pm_do_sleep(ctl_table * ctl, int write, struct file *file,
-		       void __user *buffer, size_t * len, loff_t *ppos)
+static int pm_do_sleep(ctl_table *ctl, int write, struct file *file,
+		       void __user *buffer, size_t *len, loff_t *ppos)
 {
 	int retval = 0;
 #ifdef SLEEP_TEST_TIMEOUT
@@ -257,16 +253,14 @@ static int pm_do_sleep(ctl_table * ctl, 
 	char buf[TMPBUFLEN2], *p;
 #endif
 
-	if (!write) {
+	if (!write)
 		*len = 0;
-	} else {
+	else {
 #ifdef SLEEP_TEST_TIMEOUT
-		if (*len > TMPBUFLEN2 - 1) {
+		if (*len > TMPBUFLEN2 - 1)
 			return -EFAULT;
-		}
-		if (copy_from_user(buf, buffer, *len)) {
+		if (copy_from_user(buf, buffer, *len))
 			return -EFAULT;
-		}
 		buf[*len] = 0;
 		p = buf;
 		sleep_ticks = simple_strtoul(p, &p, 0);
@@ -282,14 +276,14 @@ static int pm_do_sleep(ctl_table * ctl, 
 	return retval;
 }
 
-static int pm_do_suspend(ctl_table * ctl, int write, struct file *file,
-			 void __user *buffer, size_t * len, loff_t *ppos)
+static int pm_do_suspend(ctl_table *ctl, int write, struct file *file,
+			 void __user *buffer, size_t *len, loff_t *ppos)
 {
 	int retval = 0;
 
-	if (!write) {
+	if (!write)
 		*len = 0;
-	} else {
+	else {
 		retval = pm_send_all(PM_SUSPEND, (void *) 2);
 		if (retval)
 			return retval;
@@ -300,9 +294,8 @@ static int pm_do_suspend(ctl_table * ctl
 	return retval;
 }
 
-
-static int pm_do_freq(ctl_table * ctl, int write, struct file *file,
-		      void __user *buffer, size_t * len, loff_t *ppos)
+static int pm_do_freq(ctl_table *ctl, int write, struct file *file,
+		      void __user *buffer, size_t *len, loff_t *ppos)
 {
 	int retval = 0, i;
 	unsigned long val, pll;
@@ -310,14 +303,14 @@ static int pm_do_freq(ctl_table * ctl, i
 #define MAX_CPU_FREQ 396
 	char buf[TMPBUFLEN], *p;
 	unsigned long flags, intc0_mask, intc1_mask;
-	unsigned long old_baud_base, old_cpu_freq, baud_rate, old_clk,
-	    old_refresh;
+	unsigned long old_baud_base, old_cpu_freq, old_clk, old_refresh;
 	unsigned long new_baud_base, new_cpu_freq, new_clk, new_refresh;
+	unsigned long baud_rate;
 
 	spin_lock_irqsave(&pm_lock, flags);
-	if (!write) {
+	if (!write)
 		*len = 0;
-	} else {
+	else {
 		/* Parse the new frequency */
 		if (*len > TMPBUFLEN - 1) {
 			spin_unlock_irqrestore(&pm_lock, flags);
@@ -337,7 +330,7 @@ static int pm_do_freq(ctl_table * ctl, i
 
 		pll = val / 12;
 		if ((pll > 33) || (pll < 7)) {	/* 396 MHz max, 84 MHz min */
-			/* revisit this for higher speed cpus */
+			/* Revisit this for higher speed CPUs */
 			spin_unlock_irqrestore(&pm_lock, flags);
 			return -EFAULT;
 		}
@@ -346,30 +339,28 @@ static int pm_do_freq(ctl_table * ctl, i
 		old_cpu_freq = get_au1x00_speed();
 
 		new_cpu_freq = pll * 12 * 1000000;
-	        new_baud_base =  (new_cpu_freq / (2 * ((int)(au_readl(SYS_POWERCTRL)&0x03) + 2) * 16));
+	        new_baud_base = (new_cpu_freq / (2 * ((int)(au_readl(SYS_POWERCTRL)
+							    & 0x03) + 2) * 16));
 		set_au1x00_speed(new_cpu_freq);
 		set_au1x00_uart_baud_base(new_baud_base);
 
 		old_refresh = au_readl(MEM_SDREFCFG) & 0x1ffffff;
-		new_refresh =
-		    ((old_refresh * new_cpu_freq) /
-		     old_cpu_freq) | (au_readl(MEM_SDREFCFG) & ~0x1ffffff);
+		new_refresh = ((old_refresh * new_cpu_freq) / old_cpu_freq) |
+			      (au_readl(MEM_SDREFCFG) & ~0x1ffffff);
 
 		au_writel(pll, SYS_CPUPLL);
 		au_sync_delay(1);
 		au_writel(new_refresh, MEM_SDREFCFG);
 		au_sync_delay(1);
 
-		for (i = 0; i < 4; i++) {
-			if (au_readl
-			    (UART_BASE + UART_MOD_CNTRL +
-			     i * 0x00100000) == 3) {
-				old_clk =
-				    au_readl(UART_BASE + UART_CLK +
-					  i * 0x00100000);
-				// baud_rate = baud_base/clk
+		for (i = 0; i < 4; i++)
+			if (au_readl(UART_BASE + UART_MOD_CNTRL +
+				     i * 0x00100000) == 3) {
+				old_clk = au_readl(UART_BASE + UART_CLK +
+						   i * 0x00100000);
 				baud_rate = old_baud_base / old_clk;
-				/* we won't get an exact baud rate and the error
+				/*
+				 * We won't get an exact baud rate and the error
 				 * could be significant enough that our new
 				 * calculation will result in a clock that will
 				 * give us a baud rate that's too far off from
@@ -384,18 +375,14 @@ static int pm_do_freq(ctl_table * ctl, i
 				else if (baud_rate > 17000)
 					baud_rate = 19200;
 				else
-					(baud_rate = 9600);
-				// new_clk = new_baud_base/baud_rate
+					baud_rate = 9600;
 				new_clk = new_baud_base / baud_rate;
-				au_writel(new_clk,
-				       UART_BASE + UART_CLK +
-				       i * 0x00100000);
+				au_writel(new_clk, UART_BASE + UART_CLK +
+					  i * 0x00100000);
 				au_sync_delay(10);
 			}
-		}
 	}
 
-
 	/*
 	 * We don't want _any_ interrupts other than match20. Otherwise our
 	 * au1000_calibrate_delay() calculation will be off, potentially a lot.
@@ -461,14 +448,15 @@ static int __init pm_init(void)
 
 __initcall(pm_init);
 
-
 /*
  * This is right out of init/main.c
  */
 
-/* This is the number of bits of precision for the loops_per_jiffy.  Each
-   bit takes on average 1.5/HZ seconds.  This (like the original) is a little
-   better than 1% */
+/*
+ * This is the number of bits of precision for the loops_per_jiffy.
+ * Each bit takes on average 1.5/HZ seconds.  This (like the original)
+ * is a little better than 1%.
+ */
 #define LPS_PREC 8
 
 static void au1000_calibrate_delay(void)
@@ -476,14 +464,14 @@ static void au1000_calibrate_delay(void)
 	unsigned long ticks, loopbit;
 	int lps_precision = LPS_PREC;
 
-	loops_per_jiffy = (1 << 12);
+	loops_per_jiffy = 1 << 12;
 
 	while (loops_per_jiffy <<= 1) {
-		/* wait for "start of" clock tick */
+		/* Wait for "start of" clock tick */
 		ticks = jiffies;
 		while (ticks == jiffies)
 			/* nothing */ ;
-		/* Go .. */
+		/* Go ... */
 		ticks = jiffies;
 		__delay(loops_per_jiffy);
 		ticks = jiffies - ticks;
@@ -491,8 +479,10 @@ static void au1000_calibrate_delay(void)
 			break;
 	}
 
-/* Do a binary approximation to get loops_per_jiffy set to equal one clock
-   (up to lps_precision bits) */
+	/*
+	 * Do a binary approximation to get loops_per_jiffy set to be equal
+	 * one clock (up to lps_precision bits)
+	 */
 	loops_per_jiffy >>= 1;
 	loopbit = loops_per_jiffy;
 	while (lps_precision-- && (loopbit >>= 1)) {
@@ -505,4 +495,4 @@ static void au1000_calibrate_delay(void)
 			loops_per_jiffy &= ~loopbit;
 	}
 }
-#endif				/* CONFIG_PM */
+#endif	/* CONFIG_PM */
Index: linux-2.6/arch/mips/au1000/common/prom.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/common/prom.c
+++ linux-2.6/arch/mips/au1000/common/prom.c
@@ -3,9 +3,8 @@
  * BRIEF MODULE DESCRIPTION
  *    PROM library initialisation code, supports YAMON and U-Boot.
  *
- * Copyright 2000, 2001, 2006 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *         	ppopov@mvista.com or source@mvista.com
+ * Copyright 2000-2001, 2006, 2008 MontaVista Software Inc.
+ * Author: MontaVista Software, Inc. <source@mvista.com>
  *
  * This file was derived from Carsten Langgaard's
  * arch/mips/mips-boards/xx files.
@@ -57,7 +56,7 @@ void prom_init_cmdline(void)
 	actr = 1; /* Always ignore argv[0] */
 
 	cp = &(arcs_cmdline[0]);
-	while(actr < prom_argc) {
+	while (actr < prom_argc) {
 		strcpy(cp, prom_argv[actr]);
 		cp += strlen(prom_argv[actr]);
 		*cp++ = ' ';
@@ -84,10 +83,8 @@ char *prom_getenv(char *envname)
 		if (yamon) {
 			if (strcmp(envname, *env++) == 0)
 				return *env;
-		} else {
-			if (strncmp(envname, *env, i) == 0 && (*env)[i] == '=')
-				return *env + i + 1;
-		}
+		} else if (strncmp(envname, *env, i) == 0 && (*env)[i] == '=')
+			return *env + i + 1;
 		env++;
 	}
 
@@ -110,13 +107,13 @@ static inline void str2eaddr(unsigned ch
 {
 	int i;
 
-	for(i = 0; i < 6; i++) {
+	for (i = 0; i < 6; i++) {
 		unsigned char num;
 
-		if((*str == '.') || (*str == ':'))
+		if ((*str == '.') || (*str == ':'))
 			str++;
-		num = str2hexnum(*str++) << 4;
-		num |= (str2hexnum(*str++));
+		num  = str2hexnum(*str++) << 4;
+		num |= str2hexnum(*str++);
 		ea[i] = num;
 	}
 }
Index: linux-2.6/arch/mips/au1000/common/puts.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/common/puts.c
+++ linux-2.6/arch/mips/au1000/common/puts.c
@@ -1,11 +1,10 @@
 /*
  *
  * BRIEF MODULE DESCRIPTION
- *	Low level uart routines to directly access a 16550 uart.
+ *	Low level UART routines to directly access Alchemy UART.
  *
- * Copyright 2001 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *         	ppopov@mvista.com or source@mvista.com
+ * Copyright 2001, 2008 MontaVista Software Inc.
+ * Author: MontaVista Software, Inc. <source@mvista.com>
  *
  *  This program is free software; you can redistribute  it and/or modify it
  *  under  the terms of  the GNU General  Public License as published by the
@@ -40,12 +39,12 @@
 
 static volatile unsigned long * const com1 = (unsigned long *)SERIAL_BASE;
 
-
 #ifdef SLOW_DOWN
 static inline void slow_down(void)
 {
-    int k;
-    for (k=0; k<10000; k++);
+	int k;
+
+	for (k = 0; k < 10000; k++);
 }
 #else
 #define slow_down()
@@ -54,16 +53,16 @@ static inline void slow_down(void)
 void
 prom_putchar(const unsigned char c)
 {
-    unsigned char ch;
-    int i = 0;
+	unsigned char ch;
+	int i = 0;
+
+	do {
+		ch = com1[SER_CMD];
+		slow_down();
+		i++;
+		if (i > TIMEOUT)
+			break;
+	} while (0 == (ch & TX_BUSY));
 
-    do {
-        ch = com1[SER_CMD];
-        slow_down();
-        i++;
-        if (i>TIMEOUT) {
-            break;
-        }
-    } while (0 == (ch & TX_BUSY));
-    com1[SER_DATA] = c;
+	com1[SER_DATA] = c;
 }
Index: linux-2.6/arch/mips/au1000/common/reset.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/common/reset.c
+++ linux-2.6/arch/mips/au1000/common/reset.c
@@ -1,11 +1,10 @@
 /*
  *
  * BRIEF MODULE DESCRIPTION
- *	Au1000 reset routines.
+ *	Au1xx0 reset routines.
  *
- * Copyright 2001 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *         	ppopov@mvista.com or source@mvista.com
+ * Copyright 2001, 2006, 2008 MontaVista Software Inc.
+ * Author: MontaVista Software, Inc. <source@mvista.com>
  *
  *  This program is free software; you can redistribute  it and/or modify it
  *  under  the terms of  the GNU General  Public License as published by the
@@ -28,10 +27,11 @@
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+#include <asm/cacheflush.h>
+
 #include <asm/mach-au1x00/au1000.h>
 
 extern int au_sleep(void);
-extern void (*flush_cache_all)(void);
 
 void au1000_restart(char *command)
 {
@@ -40,8 +40,8 @@ void au1000_restart(char *command)
 	u32 prid = read_c0_prid();
 
 	printk(KERN_NOTICE "\n** Resetting Integrated Peripherals\n");
-	switch (prid & 0xFF000000)
-	{
+
+	switch (prid & 0xFF000000) {
 	case 0x00000000: /* Au1000 */
 		au_writel(0x02, 0xb0000010); /* ac97_enable */
 		au_writel(0x08, 0xb017fffc); /* usbh_enable - early errata */
@@ -138,9 +138,6 @@ void au1000_restart(char *command)
 		au_writel(0x00, 0xb1900064); /* sys_auxpll */
 		au_writel(0x00, 0xb1900100); /* sys_pininputen */
 		break;
-
-	default:
-		break;
 	}
 
 	set_c0_status(ST0_BEV | ST0_ERL);
@@ -158,25 +155,25 @@ void au1000_restart(char *command)
 void au1000_halt(void)
 {
 #if defined(CONFIG_MIPS_PB1550) || defined(CONFIG_MIPS_DB1550)
-	/* power off system */
-	printk("\n** Powering off...\n");
-	au_writew(au_readw(0xAF00001C) | (3<<14), 0xAF00001C);
+	/* Power off system */
+	printk(KERN_NOTICE "\n** Powering off...\n");
+	au_writew(au_readw(0xAF00001C) | (3 << 14), 0xAF00001C);
 	au_sync();
-	while(1); /* should not get here */
+	while (1); /* should not get here */
 #else
 	printk(KERN_NOTICE "\n** You can safely turn off the power\n");
 #ifdef CONFIG_MIPS_MIRAGE
 	au_writel((1 << 26) | (1 << 10), GPIO2_OUTPUT);
 #endif
 #ifdef CONFIG_MIPS_DB1200
-	au_writew(au_readw(0xB980001C) | (1<<14), 0xB980001C);
+	au_writew(au_readw(0xB980001C) | (1 << 14), 0xB980001C);
 #endif
 #ifdef CONFIG_PM
 	au_sleep();
 
-	/* should not get here */
-	printk(KERN_ERR "Unable to put cpu in sleep mode\n");
-	while(1);
+	/* Should not get here */
+	printk(KERN_ERR "Unable to put CPU in sleep mode\n");
+	while (1);
 #else
 	while (1)
 		__asm__(".set\tmips3\n\t"
Index: linux-2.6/arch/mips/au1000/common/setup.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/common/setup.c
+++ linux-2.6/arch/mips/au1000/common/setup.c
@@ -1,7 +1,6 @@
 /*
- * Copyright 2000 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *         	ppopov@mvista.com or source@mvista.com
+ * Copyright 2000, 2007-2008 MontaVista Software Inc.
+ * Author: MontaVista Software, Inc. <source@mvista.com
  *
  * Updates to 2.6, Pete Popov, Embedded Alley Solutions, Inc.
  *
@@ -48,7 +47,7 @@ void __init plat_mem_setup(void)
 {
 	struct	cpu_spec *sp;
 	char *argptr;
-	unsigned long prid, cpufreq, bclk = 1;
+	unsigned long prid, cpufreq, bclk;
 
 	set_cpuspec();
 	sp = cur_cpu_spec[0];
@@ -66,42 +65,39 @@ void __init plat_mem_setup(void)
 		cpufreq = (au_readl(SYS_CPUPLL) & 0x3F) * 12;
 	printk(KERN_INFO "(PRID %08lx) @ %ld MHz\n", prid, cpufreq);
 
-	bclk = sp->cpu_bclk;
-	if (bclk)
-	{
+	if (sp->cpu_bclk) {
 		/* Enable BCLK switching */
-		bclk = au_readl(0xB190003C);
-		au_writel(bclk | 0x60, 0xB190003C);
-		printk("BCLK switching enabled!\n");
+		bclk = au_readl(SYS_POWERCTRL);
+		au_writel(bclk | 0x60, SYS_POWERCTRL);
+		printk(KERN_INFO "BCLK switching enabled!\n");
 	}
 
-	if (sp->cpu_od) {
-		/* Various early Au1000 Errata corrected by this */
-		set_c0_config(1<<19); /* Set Config[OD] */
-	}
-	else {
+	if (sp->cpu_od)
+		/* Various early Au1xx0 errata corrected by this */
+		set_c0_config(1 << 19); /* Set Config[OD] */
+	else
 		/* Clear to obtain best system bus performance */
-		clear_c0_config(1<<19); /* Clear Config[OD] */
-	}
+		clear_c0_config(1 << 19); /* Clear Config[OD] */
 
 	argptr = prom_getcmdline();
 
 #ifdef CONFIG_SERIAL_8250_CONSOLE
-	if ((argptr = strstr(argptr, "console=")) == NULL) {
+	argptr = strstr(argptr, "console=");
+	if (argptr == NULL) {
 		argptr = prom_getcmdline();
 		strcat(argptr, " console=ttyS0,115200");
 	}
 #endif
 
 #ifdef CONFIG_FB_AU1100
-    if ((argptr = strstr(argptr, "video=")) == NULL) {
-        argptr = prom_getcmdline();
-        /* default panel */
-        /*strcat(argptr, " video=au1100fb:panel:Sharp_320x240_16");*/
-    }
+	argptr = strstr(argptr, "video=");
+	if (argptr == NULL) {
+		argptr = prom_getcmdline();
+		/* default panel */
+		/*strcat(argptr, " video=au1100fb:panel:Sharp_320x240_16");*/
+	}
 #endif
 
-
 #if defined(CONFIG_SOUND_AU1X00) && !defined(CONFIG_SOC_AU1000)
 	/* au1000 does not support vra, au1500 and au1100 do */
 	strcat(argptr, " au1000_audio=vra");
@@ -129,7 +125,7 @@ void __init plat_mem_setup(void)
 /* This routine should be valid for all Au1x based boards */
 phys_t __fixup_bigphys_addr(phys_t phys_addr, phys_t size)
 {
-	/* Don't fixup 36 bit addresses */
+	/* Don't fixup 36-bit addresses */
 	if ((phys_addr >> 32) != 0)
 		return phys_addr;
 
@@ -145,17 +141,17 @@ phys_t __fixup_bigphys_addr(phys_t phys_
 	}
 #endif
 
-	/* All Au1x SOCs have a pcmcia controller */
-	/* We setup our 32 bit pseudo addresses to be equal to the
-	 * 36 bit addr >> 4, to make it easier to check the address
+	/*
+	 * All Au1xx0 SOCs have a PCMCIA controller.
+	 * We setup our 32-bit pseudo addresses to be equal to the
+	 * 36-bit addr >> 4, to make it easier to check the address
 	 * and fix it.
-	 * The Au1x socket 0 phys attribute address is 0xF 4000 0000.
+	 * The PCMCIA socket 0 physical attribute address is 0xF 4000 0000.
 	 * The pseudo address we use is 0xF400 0000. Any address over
-	 * 0xF400 0000 is a pcmcia pseudo address.
+	 * 0xF400 0000 is a PCMCIA pseudo address.
 	 */
-	if ((phys_addr >= 0xF4000000) && (phys_addr < 0xFFFFFFFF)) {
+	if ((phys_addr >= 0xF4000000) && (phys_addr < 0xFFFFFFFF))
 		return (phys_t)(phys_addr << 4);
-	}
 
 	/* default nop */
 	return phys_addr;
Index: linux-2.6/arch/mips/au1000/common/time.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/common/time.c
+++ linux-2.6/arch/mips/au1000/common/time.c
@@ -25,11 +25,9 @@
  *
  * Setting up the clock on the MIPS boards.
  *
- * Update.  Always configure the kernel with CONFIG_NEW_TIME_C.  This
- * will use the user interface gettimeofday() functions from the
- * arch/mips/kernel/time.c, and we provide the clock interrupt processing
- * and the timer offset compute functions.  If CONFIG_PM is selected,
- * we also ensure the 32KHz timer is available.   -- Dan
+ * We provide the clock interrupt processing and the timer offset compute
+ * functions.  If CONFIG_PM is selected, we also ensure the 32KHz timer is
+ * available.  -- Dan
  */
 
 #include <linux/types.h>
@@ -47,8 +45,7 @@ extern int allow_au1k_wait; /* default o
 #if HZ < 100 || HZ > 1000
 #error "unsupported HZ value! Must be in [100,1000]"
 #endif
-#define MATCH20_INC (328*100/HZ) /* magic number 328 is for HZ=100... */
-extern void startup_match20_interrupt(irq_handler_t handler);
+#define MATCH20_INC (328 * 100 / HZ) /* magic number 328 is for HZ=100... */
 static unsigned long last_pc0, last_match20;
 #endif
 
@@ -61,7 +58,7 @@ static irqreturn_t counter0_irq(int irq,
 {
 	unsigned long pc0;
 	int time_elapsed;
-	static int jiffie_drift = 0;
+	static int jiffie_drift;
 
 	if (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_M20) {
 		/* should never happen! */
@@ -70,13 +67,11 @@ static irqreturn_t counter0_irq(int irq,
 	}
 
 	pc0 = au_readl(SYS_TOYREAD);
-	if (pc0 < last_match20) {
+	if (pc0 < last_match20)
 		/* counter overflowed */
 		time_elapsed = (0xffffffff - last_match20) + pc0;
-	}
-	else {
+	else
 		time_elapsed = pc0 - last_match20;
-	}
 
 	while (time_elapsed > 0) {
 		do_timer(1);
@@ -92,8 +87,9 @@ static irqreturn_t counter0_irq(int irq,
 	au_writel(last_match20 + MATCH20_INC, SYS_TOYMATCH2);
 	au_sync();
 
-	/* our counter ticks at 10.009765625 ms/tick, we we're running
-	 * almost 10uS too slow per tick.
+	/*
+	 * Our counter ticks at 10.009765625 ms/tick, we we're running
+	 * almost 10 uS too slow per tick.
 	 */
 
 	if (jiffie_drift >= 999) {
@@ -117,20 +113,17 @@ struct irqaction counter0_action = {
 /* When we wakeup from sleep, we have to "catch up" on all of the
  * timer ticks we have missed.
  */
-void
-wakeup_counter0_adjust(void)
+void wakeup_counter0_adjust(void)
 {
 	unsigned long pc0;
 	int time_elapsed;
 
 	pc0 = au_readl(SYS_TOYREAD);
-	if (pc0 < last_match20) {
+	if (pc0 < last_match20)
 		/* counter overflowed */
 		time_elapsed = (0xffffffff - last_match20) + pc0;
-	}
-	else {
+	else
 		time_elapsed = pc0 - last_match20;
-	}
 
 	while (time_elapsed > 0) {
 		time_elapsed -= MATCH20_INC;
@@ -143,10 +136,8 @@ wakeup_counter0_adjust(void)
 
 }
 
-/* This is just for debugging to set the timer for a sleep delay.
-*/
-void
-wakeup_counter0_set(int ticks)
+/* This is just for debugging to set the timer for a sleep delay. */
+void wakeup_counter0_set(int ticks)
 {
 	unsigned long pc0;
 
@@ -157,21 +148,22 @@ wakeup_counter0_set(int ticks)
 }
 #endif
 
-/* I haven't found anyone that doesn't use a 12 MHz source clock,
+/*
+ * I haven't found anyone that doesn't use a 12 MHz source clock,
  * but just in case.....
  */
 #define AU1000_SRC_CLK	12000000
 
 /*
  * We read the real processor speed from the PLL.  This is important
- * because it is more accurate than computing it from the 32KHz
+ * because it is more accurate than computing it from the 32 KHz
  * counter, if it exists.  If we don't have an accurate processor
  * speed, all of the peripherals that derive their clocks based on
  * this advertised speed will introduce error and sometimes not work
  * properly.  This function is futher convoluted to still allow configurations
  * to do that in case they have really, really old silicon with a
- * write-only PLL register, that we need the 32KHz when power management
- * "wait" is enabled, and we need to detect if the 32KHz isn't present
+ * write-only PLL register, that we need the 32 KHz when power management
+ * "wait" is enabled, and we need to detect if the 32 KHz isn't present
  * but requested......got it? :-)		-- Dan
  */
 unsigned long calc_clock(void)
@@ -182,8 +174,7 @@ unsigned long calc_clock(void)
 
 	spin_lock_irqsave(&time_lock, flags);
 
-	/* Power management cares if we don't have a 32KHz counter.
-	*/
+	/* Power management cares if we don't have a 32 KHz counter. */
 	no_au1xxx_32khz = 0;
 	counter = au_readl(SYS_COUNTER_CNTRL);
 	if (counter & SYS_CNTRL_E0) {
@@ -193,7 +184,7 @@ unsigned long calc_clock(void)
 
 		while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_T1S);
 		/* RTC now ticks at 32.768/16 kHz */
-		au_writel(trim_divide-1, SYS_RTCTRIM);
+		au_writel(trim_divide - 1, SYS_RTCTRIM);
 		while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_T1S);
 
 		while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_C1S);
@@ -215,9 +206,11 @@ unsigned long calc_clock(void)
 #endif
 	else
 		cpu_speed = (au_readl(SYS_CPUPLL) & 0x0000003f) * AU1000_SRC_CLK;
+	/* On Alchemy CPU:counter ratio is 1:1 */
 	mips_hpt_frequency = cpu_speed;
-	// Equation: Baudrate = CPU / (SD * 2 * CLKDIV * 16)
-	set_au1x00_uart_baud_base(cpu_speed / (2 * ((int)(au_readl(SYS_POWERCTRL)&0x03) + 2) * 16));
+	/* Equation: Baudrate = CPU / (SD * 2 * CLKDIV * 16) */
+	set_au1x00_uart_baud_base(cpu_speed / (2 * ((int)(au_readl(SYS_POWERCTRL)
+							  & 0x03) + 2) * 16));
 	spin_unlock_irqrestore(&time_lock, flags);
 	return cpu_speed;
 }
@@ -228,10 +221,10 @@ void __init plat_time_init(void)
 
 	est_freq += 5000;    /* round */
 	est_freq -= est_freq%10000;
-	printk("CPU frequency %d.%02d MHz\n", est_freq/1000000,
-	       (est_freq%1000000)*100/1000000);
- 	set_au1x00_speed(est_freq);
- 	set_au1x00_lcd_clock(); // program the LCD clock
+	printk(KERN_INFO "CPU frequency %u.%02u MHz\n",
+	       est_freq / 1000000, ((est_freq % 1000000) * 100) / 1000000);
+	set_au1x00_speed(est_freq);
+	set_au1x00_lcd_clock(); /* program the LCD clock */
 
 #ifdef CONFIG_PM
 	/*
@@ -243,30 +236,29 @@ void __init plat_time_init(void)
 	 * counter 0 interrupt as a special irq and it doesn't show
 	 * up under /proc/interrupts.
 	 *
-	 * Check to ensure we really have a 32KHz oscillator before
+	 * Check to ensure we really have a 32 KHz oscillator before
 	 * we do this.
 	 */
 	if (no_au1xxx_32khz)
-		printk("WARNING: no 32KHz clock found.\n");
+		printk(KERN_WARNING "WARNING: no 32KHz clock found.\n");
 	else {
 		while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_C0S);
 		au_writel(0, SYS_TOYWRITE);
 		while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_C0S);
 
-		au_writel(au_readl(SYS_WAKEMSK) | (1<<8), SYS_WAKEMSK);
+		au_writel(au_readl(SYS_WAKEMSK) | (1 << 8), SYS_WAKEMSK);
 		au_writel(~0, SYS_WAKESRC);
 		au_sync();
 		while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_M20);
 
-		/* setup match20 to interrupt once every HZ */
+		/* Setup match20 to interrupt once every HZ */
 		last_pc0 = last_match20 = au_readl(SYS_TOYREAD);
 		au_writel(last_match20 + MATCH20_INC, SYS_TOYMATCH2);
 		au_sync();
 		while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_M20);
 		setup_irq(AU1000_TOY_MATCH2_INT, &counter0_action);
 
-		/* We can use the real 'wait' instruction.
-		*/
+		/* We can use the real 'wait' instruction. */
 		allow_au1k_wait = 1;
 	}
 
