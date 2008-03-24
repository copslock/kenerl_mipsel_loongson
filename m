Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Mar 2008 20:14:27 +0000 (GMT)
Received: from rtsoft3.corbina.net ([85.21.88.6]:36839 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S28582890AbYCXUOZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 24 Mar 2008 20:14:25 +0000
Received: from wasted.dev.rtsoft.ru (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP
	id 347188810; Tue, 25 Mar 2008 01:14:42 +0400 (SAMT)
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
To:	ralf@linux-mips.org
Subject: [PATCH] Alchemy: don't unmask timer IRQ early
Date:	Mon, 24 Mar 2008 23:15:50 +0300
User-Agent: KMail/1.5
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200803242315.50423.sshtylyov@ru.mvista.com>
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18478
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Defer the unmasking of the count/compare interrupt (IRQ5) till the clockevent
driver initialization:

- only enable the cascaded IRQs 0 thru 4 in arch_init_irq(); kill the ALLINTS
  macro -- this change is blessed by AMD as I saw it in their own patch; :-)

- do not force IRQ5 enabled in plat_time_init() if PM is enabled and there's
  no 32 KHz crystal.

Update the copyrights (taking into account my prior changes), also removing
Pete Popov's old email...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The current code only caused me issues with interrupts prematurely enabled,
so the patch may be considered a cleanup...

 arch/mips/au1000/common/irq.c         |    7 +++----
 arch/mips/au1000/common/time.c        |    8 ++------
 include/asm-mips/mach-au1x00/au1000.h |   12 ++----------
 3 files changed, 7 insertions(+), 20 deletions(-)

Index: linux-2.6/arch/mips/au1000/common/irq.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/common/irq.c
+++ linux-2.6/arch/mips/au1000/common/irq.c
@@ -1,7 +1,6 @@
 /*
- * Copyright 2001 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *		ppopov@mvista.com or source@mvista.com
+ * Copyright 2001, 2007-2008 MontaVista Software Inc.
+ * Author: MontaVista Software, Inc. <source@mvista.com>
  *
  * Copyright (C) 2007 Ralf Baechle (ralf@linux-mips.org)
  *
@@ -591,7 +590,7 @@ void __init arch_init_irq(void)
 		imp++;
 	}
 
-	set_c0_status(ALLINTS);
+	set_c0_status(IE_IRQ0 | IE_IRQ1 | IE_IRQ2 | IE_IRQ3 | IE_IRQ4);
 
 	/* Board specific IRQ initialization.
 	*/
Index: linux-2.6/arch/mips/au1000/common/time.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/common/time.c
+++ linux-2.6/arch/mips/au1000/common/time.c
@@ -1,6 +1,6 @@
 /*
  *
- * Copyright (C) 2001 MontaVista Software, ppopov@mvista.com
+ * Copyright (C) 2001, 2006, 2008 MontaVista Software, <source@mvista.com>
  * Copied and modified Carsten Langgaard's time.c
  *
  * Carsten Langgaard, carstenl@mips.com
@@ -261,12 +261,8 @@ void __init plat_time_init(void)
 	 * Check to ensure we really have a 32KHz oscillator before
 	 * we do this.
 	 */
-	if (no_au1xxx_32khz) {
+	if (no_au1xxx_32khz)
 		printk("WARNING: no 32KHz clock found.\n");
-
-		/* Ensure we get CPO_COUNTER interrupts.  */
-		set_c0_status(IE_IRQ5);
-	}
 	else {
 		while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_C0S);
 		au_writel(0, SYS_TOYWRITE);
Index: linux-2.6/include/asm-mips/mach-au1x00/au1000.h
===================================================================
--- linux-2.6.orig/include/asm-mips/mach-au1x00/au1000.h
+++ linux-2.6/include/asm-mips/mach-au1x00/au1000.h
@@ -3,9 +3,8 @@
  * BRIEF MODULE DESCRIPTION
  *	Include file for Alchemy Semiconductor's Au1k CPU.
  *
- * Copyright 2000,2001 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *         	ppopov@mvista.com or source@mvista.com
+ * Copyright 2000-2001, 2006-2008 MontaVista Software Inc.
+ * Author: MontaVista Software, Inc. <source@mvista.com>
  *
  *  This program is free software; you can redistribute  it and/or modify it
  *  under  the terms of  the GNU General  Public License as published by the
@@ -117,13 +116,6 @@ extern struct au1xxx_irqmap au1xxx_irq_m
 
 #endif /* !defined (_LANGUAGE_ASSEMBLY) */
 
-#ifdef CONFIG_PM
-/* no CP0 timer irq */
-#define ALLINTS (IE_IRQ0 | IE_IRQ1 | IE_IRQ2 | IE_IRQ3 | IE_IRQ4)
-#else
-#define ALLINTS (IE_IRQ0 | IE_IRQ1 | IE_IRQ2 | IE_IRQ3 | IE_IRQ4 | IE_IRQ5)
-#endif
-
 /*
  * SDRAM Register Offsets
  */
