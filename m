Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Sep 2013 00:47:54 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:36433 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827458Ab3IDWrpyj6M9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Sep 2013 00:47:45 +0200
Date:   Wed, 4 Sep 2013 23:47:45 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH] MIPS: DECstation HRT calibration bug fixes
Message-ID: <alpine.LFD.2.03.1309041410160.11570@linux-mips.org>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37759
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

This change corrects DECstation HRT calibration, by removing the following 
bugs:

1. Calibration period selection -- HZ / 10 has been chosen, however on 
   DECstation computers, HZ never divides by 10, as the choice for HZ is 
   among 128, 256 and 1024.  The choice therefore results in a systematic
   calibration error, e.g. 6.25% for the usual choice of 128 for HZ:

   128 / 10 * 10 = 120

   (128 - 120) / 128 -> 6.25%

   The change therefore makes calibration use HZ / 8 that is always 
   accurate for the HZ values available, getting rid of the systematic
   error.

2. Calibration starting point synchronisation -- the duration of a number 
   of intervals between DS1287A periodic interrupt assertions is measured,
   however code does not ensure at the beginning that the interrupt has 
   not been previously asserted.  This results in a variable error of e.g. 
   up to another 6.25% for the period of HZ / 8 (8.(3)% with the original 
   HZ / 10 period) and the usual choice of 128 for HZ:

   1 / 16 -> 6.25%

   1 / 12 -> 8.(3)%

   The change therefore adds an initial call to ds1287_timer_state that 
   clears any previous periodic interrupt pending.

The same issue applies to both I/O ASIC counter and R4k CP0 timer 
calibration on DECstation systems as similar code is used in both cases 
and both pieces of code are covered by this fix.

On an R3400 test system used this fix results in a change of the I/O ASIC 
clock frequency reported from values like:

I/O ASIC clock frequency 23185830Hz

to:

I/O ASIC clock frequency 24999288Hz

removing the miscalculation by 6.25% from the systematic error and (for 
the individual sample provided) a further 1.00% from the variable error, 
accordingly.  The nominal I/O ASIC clock frequency is 25MHz on this 
system.

Here's another result, with the fix applied, from a system that has both 
HRTs available (using an R4400 at 60MHz nominal):

MIPS counter frequency 59999328Hz
I/O ASIC clock frequency 24999432Hz

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
Ralf,

 Please apply.

  Maciej

linux-csrc-dec-fix.patch
Index: linux/arch/mips/dec/time.c
===================================================================
--- linux.orig/arch/mips/dec/time.c
+++ linux/arch/mips/dec/time.c
@@ -126,12 +126,13 @@ int rtc_mips_set_mmss(unsigned long nowt
 void __init plat_time_init(void)
 {
 	u32 start, end;
-	int i = HZ / 10;
+	int i = HZ / 8;
 
 	/* Set up the rate of periodic DS1287 interrupts. */
 	ds1287_set_base_clock(HZ);
 
 	if (cpu_has_counter) {
+		ds1287_timer_state();
 		while (!ds1287_timer_state())
 			;
 
@@ -143,7 +144,7 @@ void __init plat_time_init(void)
 
 		end = read_c0_count();
 
-		mips_hpt_frequency = (end - start) * 10;
+		mips_hpt_frequency = (end - start) * 8;
 		printk(KERN_INFO "MIPS counter frequency %dHz\n",
 			mips_hpt_frequency);
 	} else if (IOASIC)
Index: linux/arch/mips/kernel/csrc-ioasic.c
===================================================================
--- linux.orig/arch/mips/kernel/csrc-ioasic.c
+++ linux/arch/mips/kernel/csrc-ioasic.c
@@ -41,9 +41,9 @@ void __init dec_ioasic_clocksource_init(
 {
 	unsigned int freq;
 	u32 start, end;
-	int i = HZ / 10;
-
+	int i = HZ / 8;
 
+	ds1287_timer_state();
 	while (!ds1287_timer_state())
 		;
 
@@ -55,7 +55,7 @@ void __init dec_ioasic_clocksource_init(
 
 	end = dec_ioasic_hpt_read(&clocksource_dec);
 
-	freq = (end - start) * 10;
+	freq = (end - start) * 8;
 	printk(KERN_INFO "I/O ASIC clock frequency %dHz\n", freq);
 
 	clocksource_dec.rating = 200 + freq / 10000000;
