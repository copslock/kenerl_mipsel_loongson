Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 00:34:57 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27025303AbbDCW1GhFPni (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 00:27:06 +0200
Date:   Fri, 3 Apr 2015 23:27:06 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH 39/48] MIPS: Respect the FCSR exception mask for `si_code'
In-Reply-To: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1504032007430.21028@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46756
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

Respect the FCSR exception mask when interpreting the IEEE 754 exception 
condition to report with SIGFPE in `si_code', so as not to use one that 
has been masked where a different one set in parallel caused the FPE 
hardware exception to trigger.  As per the IEEE Std 754 the Inexact 
exception can happen together with Overflow or Underflow.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-mips-fpe-except-mask.diff
Index: linux/arch/mips/kernel/traps.c
===================================================================
--- linux.orig/arch/mips/kernel/traps.c	2015-04-02 20:27:57.489216000 +0100
+++ linux/arch/mips/kernel/traps.c	2015-04-02 20:27:58.065226000 +0100
@@ -12,6 +12,7 @@
  * Copyright (C) 2000, 2001, 2012 MIPS Technologies, Inc.  All rights reserved.
  * Copyright (C) 2014, Imagination Technologies Ltd.
  */
+#include <linux/bitops.h>
 #include <linux/bug.h>
 #include <linux/compiler.h>
 #include <linux/context_tracking.h>
@@ -817,7 +818,15 @@ asmlinkage void do_fpe(struct pt_regs *r
 		process_fpemu_return(sig, fault_addr);
 
 		goto out;
-	} else if (fcr31 & FPU_CSR_INV_X)
+	}
+
+	/*
+	 * Inexact can happen together with Overflow or Underflow.
+	 * Respect the mask to deliver the correct exception.
+	 */
+	fcr31 &= (fcr31 & FPU_CSR_ALL_E) <<
+		 (ffs(FPU_CSR_ALL_X) - ffs(FPU_CSR_ALL_E));
+	if (fcr31 & FPU_CSR_INV_X)
 		info.si_code = FPE_FLTINV;
 	else if (fcr31 & FPU_CSR_DIV_X)
 		info.si_code = FPE_FLTDIV;
