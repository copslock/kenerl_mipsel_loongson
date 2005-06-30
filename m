Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jun 2005 17:43:49 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:48655 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226093AbVF3Qna>; Thu, 30 Jun 2005 17:43:30 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 38A45E1CC5; Thu, 30 Jun 2005 18:43:11 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 26975-05; Thu, 30 Jun 2005 18:43:11 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id F4053E1C84; Thu, 30 Jun 2005 18:43:10 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j5UGhCCH019320;
	Thu, 30 Jun 2005 18:43:15 +0200
Date:	Thu, 30 Jun 2005 17:43:21 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Andy Isaacson <adi@hexapodia.org>,
	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [patch 3/5] SiByte fixes for 2.6.12
In-Reply-To: <20050623194826.GA23653@hexapodia.org>
Message-ID: <Pine.LNX.4.61L.0506301712410.28331@blysk.ds.pg.gda.pl>
References: <20050622230137.GA17954@broadcom.com>
 <Pine.LNX.4.61L.0506231202130.17155@blysk.ds.pg.gda.pl>
 <20050623194826.GA23653@hexapodia.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/960/Wed Jun 29 06:31:06 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8265
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 23 Jun 2005, Andy Isaacson wrote:

> >  Is it really the case?  Perhaps it doesn't know the symbolic name of the 
> > register which has only been added recently.  Replacing it with $31 should 
> > fix the problem, but your patch is obviously correct regardless.
> 
> Yeah, you're right, my old gas just doesn't know $ra.  s/ra/31/g works
> as well.

 Here's my proposal to fix run_uncached() -- it works correctly for me for 
both 32-bit and 64-bit builds (current code crashes for me for 64 bits, 
because as a result of the bad calculation a jump outside any valid 
address space is attempted).  I've inspected generated machine code to 
make sure it's correct as well.

 Unfortunately with this code GCC spits out a few bogus warnings for 
32-bit builds (this is supposed to be a "non-bug" of the compiler -- see 
"http://gcc.gnu.org/bugzilla/show_bug.cgi?id=12963" for details).  I'm not 
sure struggling hard to get rid of these warnings, possibly complicating 
code, is worth the hassle; GCC should be fixed instead.

 Unless there are objections I'd like to apply this patch.

  Maciej

patch-mips-2.6.12-20050620-run_uncached-8
diff -up --recursive --new-file linux-mips-2.6.12-20050620.macro/arch/mips/lib/uncached.c linux-mips-2.6.12-20050620/arch/mips/lib/uncached.c
--- linux-mips-2.6.12-20050620.macro/arch/mips/lib/uncached.c	2005-04-25 16:36:23.000000000 +0000
+++ linux-mips-2.6.12-20050620/arch/mips/lib/uncached.c	2005-06-23 18:24:58.000000000 +0000
@@ -4,31 +4,71 @@
  * for more details.
  *
  * Copyright (C) 2005 Thiemo Seufer
+ * Copyright (C) 2005  MIPS Technologies, Inc.  All rights reserved.
+ *	Author: Maciej W. Rozycki <macro@mips.com>
  */
+
 #include <linux/init.h>
 
 #include <asm/addrspace.h>
+#include <asm/bug.h>
+
+#ifndef CKSEG2
+#define CKSEG2 CKSSEG
+#endif
+#ifndef TO_PHYS_MASK
+#define TO_PHYS_MASK -1
+#endif
 
 /*
- * FUNC is executed in the uncached segment CKSEG1. This works only if
- * both code and stack live in CKSEG0. The stack handling works because
- * we don't handle stack arguments or more complex return values, so we
- * can avoid to share the same stack area between cached and uncached
- * mode.
+ * FUNC is executed in one of the uncached segments, depending on its
+ * original address as follows:
+ *
+ * 1. If the original address is in CKSEG0 or CKSEG1, then the uncached
+ *    segment used is CKSEG1.
+ * 2. If the original address is in XKPHYS, then the uncached segment
+ *    used is XKPHYS(2).
+ * 3. Otherwise it's a bug.
+ *
+ * The same remapping is done with the stack pointer.  Stack handling
+ * works because we don't handle stack arguments or more complex return
+ * values, so we can avoid sharing the same stack area between a cached
+ * and the uncached mode.
  */
 unsigned long __init run_uncached(void *func)
 {
-	register unsigned long sp __asm__("$sp");
-	register unsigned long ret __asm__("$2");
-	unsigned long usp = sp - CAC_BASE + UNCAC_BASE;
-	unsigned long ufunc = func - CAC_BASE + UNCAC_BASE;
+	register long sp __asm__("$sp");
+	register long ret __asm__("$2");
+	long lfunc = (long)func, ufunc;
+	long usp;
+
+	if (sp >= (long)CKSEG0 && sp < (long)CKSEG2)
+		usp = CKSEG1ADDR(sp);
+	else if ((long long)sp >= (long long)PHYS_TO_XKPHYS(0LL, 0) &&
+		 (long long)sp < (long long)PHYS_TO_XKPHYS(8LL, 0))
+		usp = PHYS_TO_XKPHYS((long long)K_CALG_UNCACHED,
+				     XKPHYS_TO_PHYS((long long)sp));
+	else {
+		BUG();
+		usp = sp;
+	}
+	if (lfunc >= (long)CKSEG0 && lfunc < (long)CKSEG2)
+		ufunc = CKSEG1ADDR(lfunc);
+	else if ((long long)lfunc >= (long long)PHYS_TO_XKPHYS(0LL, 0) &&
+		 (long long)lfunc < (long long)PHYS_TO_XKPHYS(8LL, 0))
+		ufunc = PHYS_TO_XKPHYS((long long)K_CALG_UNCACHED,
+				       XKPHYS_TO_PHYS((long long)lfunc));
+	else {
+		BUG();
+		ufunc = lfunc;
+	}
 
 	__asm__ __volatile__ (
-		"	move $16, $sp\n"
-		"	move $sp, %1\n"
-		"	jalr $ra, %2\n"
-		"	move $sp, $16"
-		: "=&r" (ret)
+		"	move	$16, $sp\n"
+		"	move	$sp, %1\n"
+		"	jalr	%2\n"
+		"	move	$sp, $16"
+		: "=r" (ret)
 		: "r" (usp), "r" (ufunc)
 		: "$16", "$31");
 
