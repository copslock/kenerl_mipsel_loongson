Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Apr 2014 22:42:51 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:32814 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816019AbaDFUmth20pN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 6 Apr 2014 22:42:49 +0200
Date:   Sun, 6 Apr 2014 21:42:49 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH] MIPS: __delay ABI-dependent subtraction simplification
Message-ID: <alpine.LFD.2.11.1404062132180.15266@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39669
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

This small update to the previous fix to __delay removes a conditional 
around the ABI-dependent subtraction operation within an inline asm in 
favor to the standard <asm/asm.h> LONG_SUBU macro.  No change in code 
produced.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
Here again checkpatch.pl complains, but I fail to see the point.
linux-mips-delay-str.patch
Index: linux-20140329-4maxp64/arch/mips/lib/delay.c
===================================================================
--- linux-20140329-4maxp64.orig/arch/mips/lib/delay.c
+++ linux-20140329-4maxp64/arch/mips/lib/delay.c
@@ -11,7 +11,9 @@
 #include <linux/module.h>
 #include <linux/param.h>
 #include <linux/smp.h>
+#include <linux/stringify.h>
 
+#include <asm/asm.h>
 #include <asm/compiler.h>
 #include <asm/war.h>
 
@@ -27,11 +29,7 @@ void __delay(unsigned long loops)
 	"	.set	noreorder				\n"
 	"	.align	3					\n"
 	"1:	bnez	%0, 1b					\n"
-#if BITS_PER_LONG == 32
-	"	subu	%0, %1					\n"
-#else
-	"	dsubu	%0, %1					\n"
-#endif
+	"	 " __stringify(LONG_SUBU) "	%0, %1		\n"
 	"	.set	reorder					\n"
 	: "=r" (loops)
 	: GCC_DADDI_IMM_ASM() (1), "0" (loops));
