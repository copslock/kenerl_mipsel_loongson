Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jun 2004 13:53:02 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:63903 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225525AbUFNMw6>; Mon, 14 Jun 2004 13:52:58 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id A4E1047833; Mon, 14 Jun 2004 14:52:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 8064D474C5; Mon, 14 Jun 2004 14:52:50 +0200 (CEST)
Date: Mon, 14 Jun 2004 14:52:50 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: David Daney <ddaney@avtrex.com>, cgd@broadcom.com,
	Ralf Baechle <ralf@linux-mips.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>,
	binutils@sources.redhat.com
Subject: Re: [Patch] (revised patch) / 0 should send SIGFPE not SIGTRAP 
In-Reply-To: <Pine.GSO.4.58.0406131032350.85@waterleaf.sonytel.be>
Message-ID: <Pine.LNX.4.55.0406141446510.29984@jurand.ds.pg.gda.pl>
References: <40C9F5A4.2050606@avtrex.com> <40C9F5FE.8030607@avtrex.com>
 <40C9F7F0.50501@avtrex.com> <Pine.LNX.4.55.0406112039040.13062@jurand.ds.pg.gda.pl>
 <mailpost.1086981251.16853@news-sj1-1> <yov57juduc7q.fsf@ldt-sj3-010.sj.broadcom.com>
 <Pine.LNX.4.55.0406112133380.13062@jurand.ds.pg.gda.pl> <40CA1B35.6010603@avtrex.com>
 <40CA1FE3.9030507@avtrex.com> <Pine.GSO.4.58.0406131032350.85@waterleaf.sonytel.be>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5304
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Sun, 13 Jun 2004, Geert Uytterhoeven wrote:

> Please send one more, where you use `diff -up' :-)

 No need to -- I've reimplemented it a bit differently meanwhile.  Any 
objections to the following changes?

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.26-20040531-mips-bp-tr-0
diff -up --recursive --new-file linux-mips-2.4.26-20040531.macro/arch/mips/kernel/traps.c linux-mips-2.4.26-20040531/arch/mips/kernel/traps.c
--- linux-mips-2.4.26-20040531.macro/arch/mips/kernel/traps.c	2004-03-13 03:56:44.000000000 +0000
+++ linux-mips-2.4.26-20040531/arch/mips/kernel/traps.c	2004-06-13 20:24:32.000000000 +0000
@@ -9,7 +9,7 @@
  * Copyright (C) 1999 Silicon Graphics, Inc.
  * Kevin D. Kissell, kevink@mips.com and Carsten Langgaard, carstenl@mips.com
  * Copyright (C) 2000, 01 MIPS Technologies, Inc.
- * Copyright (C) 2002, 2003  Maciej W. Rozycki
+ * Copyright (C) 2002, 2003, 2004  Maciej W. Rozycki
  */
 #include <linux/config.h>
 #include <linux/init.h>
@@ -22,6 +22,7 @@
 
 #include <asm/bootinfo.h>
 #include <asm/branch.h>
+#include <asm/break.h>
 #include <asm/cpu.h>
 #include <asm/fpu.h>
 #include <asm/cachectl.h>
@@ -596,9 +597,12 @@ asmlinkage void do_bp(struct pt_regs *re
 	/*
 	 * There is the ancient bug in the MIPS assemblers that the break
 	 * code starts left to bit 16 instead to bit 6 in the opcode.
-	 * Gas is bug-compatible ...
+	 * Gas is bug-compatible, but not always, grrr...
+	 * We handle both cases with a simple heuristics.  --macro
 	 */
-	bcode = ((opcode >> 16) & ((1 << 20) - 1));
+	bcode = ((opcode >> 6) & ((1 << 20) - 1));
+	if (bcode < (1 << 10))
+		bcode <<= 10;
 
 	/*
 	 * (A short test says that IRIX 5.3 sends SIGTRAP for all break
@@ -607,9 +611,9 @@ asmlinkage void do_bp(struct pt_regs *re
 	 * But should we continue the brokenness???  --macro
 	 */
 	switch (bcode) {
-	case 6:
-	case 7:
-		if (bcode == 7)
+	case BRK_OVERFLOW << 10:
+	case BRK_DIVZERO << 10:
+		if (bcode == (BRK_DIVZERO << 10))
 			info.si_code = FPE_INTDIV;
 		else
 			info.si_code = FPE_INTOVF;
@@ -633,7 +637,7 @@ asmlinkage void do_tr(struct pt_regs *re
 
 	/* Immediate versions don't provide a code.  */
 	if (!(opcode & OPCODE))
-		tcode = ((opcode >> 6) & ((1 << 20) - 1));
+		tcode = ((opcode >> 6) & ((1 << 10) - 1));
 
 	/*
 	 * (A short test says that IRIX 5.3 sends SIGTRAP for all trap
@@ -642,9 +646,9 @@ asmlinkage void do_tr(struct pt_regs *re
 	 * But should we continue the brokenness???  --macro
 	 */
 	switch (tcode) {
-	case 6:
-	case 7:
-		if (tcode == 7)
+	case BRK_OVERFLOW:
+	case BRK_DIVZERO:
+		if (tcode == BRK_DIVZERO)
 			info.si_code = FPE_INTDIV;
 		else
 			info.si_code = FPE_INTOVF;
diff -up --recursive --new-file linux-mips-2.4.26-20040531.macro/arch/mips64/kernel/traps.c linux-mips-2.4.26-20040531/arch/mips64/kernel/traps.c
--- linux-mips-2.4.26-20040531.macro/arch/mips64/kernel/traps.c	2004-03-13 03:56:45.000000000 +0000
+++ linux-mips-2.4.26-20040531/arch/mips64/kernel/traps.c	2004-06-13 20:26:01.000000000 +0000
@@ -9,7 +9,7 @@
  * Copyright (C) 1999 Silicon Graphics, Inc.
  * Kevin D. Kissell, kevink@mips.com and Carsten Langgaard, carstenl@mips.com
  * Copyright (C) 2000, 01 MIPS Technologies, Inc.
- * Copyright (C) 2002, 2003  Maciej W. Rozycki
+ * Copyright (C) 2002, 2003, 2004  Maciej W. Rozycki
  */
 #include <linux/config.h>
 #include <linux/init.h>
@@ -22,6 +22,7 @@
 
 #include <asm/bootinfo.h>
 #include <asm/branch.h>
+#include <asm/break.h>
 #include <asm/cpu.h>
 #include <asm/fpu.h>
 #include <asm/module.h>
@@ -606,9 +607,12 @@ asmlinkage void do_bp(struct pt_regs *re
 	/*
 	 * There is the ancient bug in the MIPS assemblers that the break
 	 * code starts left to bit 16 instead to bit 6 in the opcode.
-	 * Gas is bug-compatible ...
+	 * Gas is bug-compatible, but not always, grrr...
+	 * We handle both cases with a simple heuristics.  --macro
 	 */
-	bcode = ((opcode >> 16) & ((1 << 20) - 1));
+	bcode = ((opcode >> 6) & ((1 << 20) - 1));
+	if (bcode < (1 << 10))
+		bcode <<= 10;
 
 	/*
 	 * (A short test says that IRIX 5.3 sends SIGTRAP for all break
@@ -617,9 +621,9 @@ asmlinkage void do_bp(struct pt_regs *re
 	 * But should we continue the brokenness???  --macro
 	 */
 	switch (bcode) {
-	case 6:
-	case 7:
-		if (bcode == 7)
+	case BRK_OVERFLOW << 10:
+	case BRK_DIVZERO << 10:
+		if (bcode == (BRK_DIVZERO << 10))
 			info.si_code = FPE_INTDIV;
 		else
 			info.si_code = FPE_INTOVF;
@@ -643,7 +647,7 @@ asmlinkage void do_tr(struct pt_regs *re
 
 	/* Immediate versions don't provide a code.  */
 	if (!(opcode & OPCODE))
-		tcode = ((opcode >> 6) & ((1 << 20) - 1));
+		tcode = ((opcode >> 6) & ((1 << 10) - 1));
 
 	/*
 	 * (A short test says that IRIX 5.3 sends SIGTRAP for all trap
@@ -652,9 +656,9 @@ asmlinkage void do_tr(struct pt_regs *re
 	 * But should we continue the brokenness???  --macro
 	 */
 	switch (tcode) {
-	case 6:
-	case 7:
-		if (tcode == 7)
+	case BRK_OVERFLOW:
+	case BRK_DIVZERO:
+		if (tcode == BRK_DIVZERO)
 			info.si_code = FPE_INTDIV;
 		else
 			info.si_code = FPE_INTOVF;
