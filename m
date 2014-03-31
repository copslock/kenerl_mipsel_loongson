Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Apr 2014 01:57:44 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:41090 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822097AbaCaX52aNd80 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Apr 2014 01:57:28 +0200
Date:   Tue, 1 Apr 2014 00:57:28 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH 1/3] MIPS: __delay CPU_DADDI_WORKAROUNDS bug fix
Message-ID: <alpine.LFD.2.11.1404010020510.27402@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39598
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

With CPU_DADDI_WORKAROUNDS enabled __delay assembles with a macro in a 
branch delay slot:

{standard input}: Assembler messages:
{standard input}:18: Warning: Macro instruction expanded into multiple 
instructions in a branch delay slot

and broken code results:

0000000000000000 <__delay>:
   0:	1480ffff 	bnez	a0,0 <__delay>
   4:	24010001 	li	at,1
   8:	0081202f 	dsubu	a0,a0,at
   c:	03e00008 	jr	ra
  10:	00000000 	nop
  14:	00000000 	nop

Consequently the function loops indefinitely, showing up prominently as a 
hang in the delay loop calibration at bootstrap.

This change corrects the problem by forcing the immediate 1 into a 
register while keeping code produced identical where CPU_DADDI_WORKAROUNDS 
is disabled.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-mips-delay-nodaddi-fix.patch
Index: linux-20140329-4maxp64/arch/mips/lib/delay.c
===================================================================
--- linux-20140329-4maxp64.orig/arch/mips/lib/delay.c
+++ linux-20140329-4maxp64/arch/mips/lib/delay.c
@@ -6,7 +6,7 @@
  * Copyright (C) 1994 by Waldorf Electronics
  * Copyright (C) 1995 - 2000, 01, 03 by Ralf Baechle
  * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
- * Copyright (C) 2007  Maciej W. Rozycki
+ * Copyright (C) 2007, 2014 Maciej W. Rozycki
  */
 #include <linux/module.h>
 #include <linux/param.h>
@@ -15,6 +15,12 @@
 #include <asm/compiler.h>
 #include <asm/war.h>
 
+#ifndef CONFIG_CPU_DADDI_WORKAROUNDS
+#define GCC_DADDI_IMM_ASM() "I"
+#else
+#define GCC_DADDI_IMM_ASM() "r"
+#endif
+
 void __delay(unsigned long loops)
 {
 	__asm__ __volatile__ (
@@ -22,13 +28,13 @@ void __delay(unsigned long loops)
 	"	.align	3					\n"
 	"1:	bnez	%0, 1b					\n"
 #if BITS_PER_LONG == 32
-	"	subu	%0, 1					\n"
+	"	subu	%0, %1					\n"
 #else
-	"	dsubu	%0, 1					\n"
+	"	dsubu	%0, %1					\n"
 #endif
 	"	.set	reorder					\n"
 	: "=r" (loops)
-	: "0" (loops));
+	: GCC_DADDI_IMM_ASM() (1), "0" (loops));
 }
 EXPORT_SYMBOL(__delay);
 
