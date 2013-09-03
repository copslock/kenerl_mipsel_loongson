Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Sep 2013 02:30:01 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:56495 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827349Ab3ICA360Zllo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Sep 2013 02:29:58 +0200
Date:   Tue, 3 Sep 2013 01:29:58 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH] MIPS: R4k clock source initialization bug fix
Message-ID: <alpine.LFD.2.03.1309022215530.3579@linux-mips.org>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37740
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

This is a fix for a bug introduced with commit 
447cdf2628b59aa513a42785450b348dced26d8a, submitted as archived here: 
http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=20080312235002.c717dde3.yoichi_yuasa%40tripeaks.co.jp 
regrettably with no further explanation.

The issue is with the CP0 Count register read erratum present on R4000 and 
some R4400 processors.  If this erratum is present, then a read from this 
register that happens around the time it reaches the value stored in the 
CP0 Compare register causes a CP0 timer interrupt that is supposed to 
happen when the values in the two registers match to be missed.  The 
implication for the chips affected is the CP0 timer can be used either as 
a source of a timer interrupt (a clock event) or as a source of a 
high-resolution counter (a clock source), but not both at a time.

The erratum does not affect timer interrupt operation itself, because in 
this case the CP0 Count register is only read while the timer interrupt 
has already been raised, while high-resolution counter references happen 
at random times.

Additionally some systems apparently have issues with the timer interrupt 
line being routed externally and not following the usual CP0 Count/Compare 
semantics.  In this case we don't want to use the R4k clock event.

We've meant to address the erratum and the timer interrupt routing issue 
in time_init, however the commit referred to above broke our solution.  
What we currently have is we enable the R4k clock source if the R4k clock 
event initialization has succeeded (the timer is present and has no timer 
interrupt routing issue) or there is no CP0 Count register read erratum.  
Which gives the following boolean matrix:

clock event | count erratum => clock source
------------+---------------+--------------
     0      |       0       |      1 (OK)
     0      |       1       |      0 (bug!) -> no interference, could use
     1      |       0       |      1 (OK)
     1      |       1       |      1 (bug!) -> can't use, interference

What we want instead is to enable the R4k clock source if there is no CP0 
Count register read erratum (obviously) or the R4k clock event 
initialization has *failed* -- because in the latter case we won't be 
using the timer interrupt anyway, so we don't care about any interference 
CP0 Count reads might cause with the interrupt.  This corresponds to the 
following boolean matrix:

clock event | count erratum => clock source
------------+---------------+--------------
     0      |       0       |      1
     0      |       1       |      1
     1      |       0       |      1
     1      |       1       |      0

This is implemented here, effectively reverting the problematic commit, 
and a short explanation is given next to code modified so that the 
rationale is known to future readers and confusion is prevented from 
happening here again.

It is worth noting that mips_clockevent_init returns 0 upon success while 
cpu_has_mfc0_count_bug returns 0 upon failure.  This is because the former 
function returns an error code while the latter returns a boolean value.  
To signify the difference I have therefore chosen to compare the result of 
the former call explicitly against 0.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
Ralf,

 Please apply.  Additionally I think mips_clockevent_init shouldn't be 
calling gic_clockevent_init as GIC has no relevance to the CP0 Count 
register or any errata it may have.  I think gic_clockevent_init should 
probably be called just from time_init directly.  But that's a separate 
patch material.

  Maciej

linux-mips-time.patch
Index: linux/arch/mips/kernel/time.c
===================================================================
--- linux.orig/arch/mips/kernel/time.c
+++ linux/arch/mips/kernel/time.c
@@ -121,6 +121,14 @@ void __init time_init(void)
 {
 	plat_time_init();
 
-	if (!mips_clockevent_init() || !cpu_has_mfc0_count_bug())
+	/*
+	 * The use of the R4k timer as a clock event takes precedence;
+	 * if reading the Count register might interfere with the timer
+	 * interrupt, then we don't use the timer as a clock source.
+	 * We may still use the timer as a clock source though if the
+	 * timer interrupt isn't reliable; the interference doesn't
+	 * matter then, because we don't use the interrupt.
+	 */
+	if (mips_clockevent_init() != 0 || !cpu_has_mfc0_count_bug())
 		init_mips_clocksource();
 }
