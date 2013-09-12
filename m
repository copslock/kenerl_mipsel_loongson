Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Sep 2013 13:01:56 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:35861 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822585Ab3ILLBxqiLM4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Sep 2013 13:01:53 +0200
Date:   Thu, 12 Sep 2013 12:01:53 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH] MIPS: DECstation HRT initialization rearrangement
Message-ID: <alpine.LFD.2.03.1309101036520.29830@linux-mips.org>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37800
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

Not all I/O ASIC versions have the free-running counter implemented, an 
early revision used in the 5000/1xx models aka 3MIN and 4MIN did not have 
it.  Therefore we cannot unconditionally use it as a clock source.  
Fortunately if not implemented its register slot has a fixed value so it 
is enough if we check for the value at the end of the calibration period 
being the same as at the beginning.

This also means we need to look for another high-precision clock source on 
the systems affected.  The 5000/1xx can have an R4000SC processor 
installed where the CP0 Count register can be used as a clock source.  
Unfortunately all the R4k DECstations suffer from the missed timer 
interrupt on CP0 Count reads erratum, so we cannot use the CP0 timer as a 
clock source and a clock event both at a time.  However we never need an 
R4k clock event device because all DECstations have a DS1287A RTC chip 
whose periodic interrupt can be used as a clock source.

This gives us the following four configuration possibilities for I/O ASIC 
DECstations:

1. No I/O ASIC counter and no CP0 timer, e.g. R3k 5000/1xx (3MIN).

2. No I/O ASIC counter but the CP0 timer, i.e. R4k 5000/150 (4MIN). 

3. The I/O ASIC counter but no CP0 timer, e.g. R3k 5000/240 (3MAX+).

4. The I/O ASIC counter and the CP0 timer, e.g. R4k 5000/260 (4MAX+).

For #1 and #2 this change stops the I/O ASIC free-running counter from 
being installed as a clock source of a 0Hz frequency.  For #2 it also 
arranges for the CP0 timer to be used as a clock source rather than a 
clock event device, because having an accurate wall clock is more 
important than a high-precision interval timer.  For #3 there is no 
change.  For #4 the change makes the I/O ASIC free-running counter 
installed as a clock source so that the CP0 timer can be used as a clock 
event device.

Unfortunately the use of the CP0 timer as a clock event device relies on a 
succesful completion of c0_compare_interrupt.  That never happens, because 
while waiting for a CP0 Compare interrupt to happen the function spins in 
a loop reading the CP0 Count register.  This makes the CP0 Count erratum 
trigger reliably causing the interrupt waited for to be lost in all cases.  
As a result #4 resorts to using the CP0 timer as a clock source as well, 
just as #2.  However we want to keep this separate arrangement in case 
(hope) c0_compare_interrupt is eventually rewritten such that it avoids 
the erratum.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
Ralf,

 As promised this is the last of the three changes in this area, please 
apply.

  Maciej

linux-csrc-dec-r4k.patch
Index: linux/arch/mips/dec/time.c
===================================================================
--- linux.orig/arch/mips/dec/time.c
+++ linux/arch/mips/dec/time.c
@@ -125,12 +125,16 @@ int rtc_mips_set_mmss(unsigned long nowt
 
 void __init plat_time_init(void)
 {
+	int ioasic_clock = 0;
 	u32 start, end;
 	int i = HZ / 8;
 
 	/* Set up the rate of periodic DS1287 interrupts. */
 	ds1287_set_base_clock(HZ);
 
+	/* On some I/O ASIC systems we have the I/O ASIC's counter.  */
+	if (IOASIC)
+		ioasic_clock = dec_ioasic_clocksource_init() == 0;
 	if (cpu_has_counter) {
 		ds1287_timer_state();
 		while (!ds1287_timer_state())
@@ -147,9 +151,21 @@ void __init plat_time_init(void)
 		mips_hpt_frequency = (end - start) * 8;
 		printk(KERN_INFO "MIPS counter frequency %dHz\n",
 			mips_hpt_frequency);
-	} else if (IOASIC)
-		/* For pre-R4k systems we use the I/O ASIC's counter.  */
-		dec_ioasic_clocksource_init();
+
+		/*
+		 * All R4k DECstations suffer from the CP0 Count erratum,
+		 * so we can't use the timer as a clock source, and a clock
+		 * event both at a time.  An accurate wall clock is more
+		 * important than a high-precision interval timer so only
+		 * use the timer as a clock source, and not a clock event
+		 * if there's no I/O ASIC counter available to serve as a
+		 * clock source.
+		 */
+		if (!ioasic_clock) {
+			init_r4k_clocksource();
+			mips_hpt_frequency = 0;
+		}
+	}
 
 	ds1287_clockevent_init(dec_interrupt[DEC_IRQ_RTC]);
 }
Index: linux/arch/mips/include/asm/dec/ioasic.h
===================================================================
--- linux.orig/arch/mips/include/asm/dec/ioasic.h
+++ linux/arch/mips/include/asm/dec/ioasic.h
@@ -33,6 +33,6 @@ static inline u32 ioasic_read(unsigned i
 
 extern void init_ioasic_irqs(int base);
 
-extern void dec_ioasic_clocksource_init(void);
+extern int dec_ioasic_clocksource_init(void);
 
 #endif /* __ASM_DEC_IOASIC_H */
Index: linux/arch/mips/kernel/csrc-ioasic.c
===================================================================
--- linux.orig/arch/mips/kernel/csrc-ioasic.c
+++ linux/arch/mips/kernel/csrc-ioasic.c
@@ -37,7 +37,7 @@ static struct clocksource clocksource_de
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-void __init dec_ioasic_clocksource_init(void)
+int __init dec_ioasic_clocksource_init(void)
 {
 	unsigned int freq;
 	u32 start, end;
@@ -56,8 +56,14 @@ void __init dec_ioasic_clocksource_init(
 	end = dec_ioasic_hpt_read(&clocksource_dec);
 
 	freq = (end - start) * 8;
+
+	/* An early revision of the I/O ASIC didn't have the counter.  */
+	if (!freq)
+		return -ENXIO;
+
 	printk(KERN_INFO "I/O ASIC clock frequency %dHz\n", freq);
 
 	clocksource_dec.rating = 200 + freq / 10000000;
 	clocksource_register_hz(&clocksource_dec, freq);
+	return 0;
 }
