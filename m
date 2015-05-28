Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 May 2015 18:46:52 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27007457AbbE1QqtHJ2Pb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 May 2015 18:46:49 +0200
Date:   Thu, 28 May 2015 17:46:49 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH] MIPS: strnlen_user.S: Fix a CPU_DADDI_WORKAROUNDS
 regression
Message-ID: <alpine.LFD.2.11.1505271631400.21603@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47710
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

Correct a regression introduced with 8453eebd [MIPS: Fix strnlen_user() 
return value in case of overlong strings.] causing assembler warnings 
and broken code generated in __strnlen_kernel_nocheck_asm:

arch/mips/lib/strnlen_user.S: Assembler messages:
arch/mips/lib/strnlen_user.S:64: Warning: Macro instruction expanded into multiple instructions in a branch delay slot

with the CPU_DADDI_WORKAROUNDS option set, resulting in the function 
looping indefinitely upon mounting NFS root.

Use conditional assembly to avoid a microMIPS code size regression.  
Using $at unconditionally would cause such a regression as there are no 
16-bit instruction encodings available for ALU operations using this 
register.  Using $v1 unconditionally would produce short microMIPS 
encodings, but would prevent this register from being used across calls 
to this function.

The extra LI operation introduced is free, replacing a NOP originally 
scheduled into the delay slot of the branch that follows.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
Ralf,

 The jump to the delay slot combined with the unusual register usage 
convention taken here made it trickier than it would normally be to make a 
fix that does not regress -- in terms of code size -- unaffected microMIPS 
systems.  I tried several versions and eventually I came up with this one 
that I believe produces the best code in all cases, at the cost of these 
#ifdefs.  I hope they are acceptable.

 Please apply,

  Maciej

linux-mips-strnlen-user-nodaddi-fix.patch
Index: linux-20150524-4maxp64/arch/mips/lib/strnlen_user.S
===================================================================
--- linux-20150524-4maxp64.orig/arch/mips/lib/strnlen_user.S
+++ linux-20150524-4maxp64/arch/mips/lib/strnlen_user.S
@@ -34,7 +34,12 @@ LEAF(__strnlen_\func\()_asm)
 FEXPORT(__strnlen_\func\()_nocheck_asm)
 	move		v0, a0
 	PTR_ADDU	a1, a0			# stop pointer
-1:	beq		v0, a1, 1f		# limit reached?
+1:
+#ifdef CONFIG_CPU_DADDI_WORKAROUNDS
+	.set		noat
+	li		AT, 1
+#endif
+	beq		v0, a1, 1f		# limit reached?
 .ifeqs "\func", "kernel"
 	EX(lb, t0, (v0), .Lfault\@)
 .else
@@ -42,7 +47,13 @@ FEXPORT(__strnlen_\func\()_nocheck_asm)
 .endif
 	.set		noreorder
 	bnez		t0, 1b
-1:	 PTR_ADDIU	v0, 1
+1:
+#ifndef CONFIG_CPU_DADDI_WORKAROUNDS
+	 PTR_ADDIU	v0, 1
+#else
+	 PTR_ADDU	v0, AT
+	.set		at
+#endif
 	.set		reorder
 	PTR_SUBU	v0, a0
 	jr		ra
