Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Oct 2006 19:28:05 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:35287 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038563AbWJVS2C (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 22 Oct 2006 19:28:02 +0100
Received: from localhost (p2094-ipad22funabasi.chiba.ocn.ne.jp [220.104.80.94])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id DCC64A333; Mon, 23 Oct 2006 03:27:54 +0900 (JST)
Date:	Mon, 23 Oct 2006 03:30:18 +0900 (JST)
Message-Id: <20061023.033018.59031419.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] rest of works for migration to GENERIC_TIME
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13050
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Since we already moved to GENERIC_TIME, we should implement
alternatives of old do_gettimeoffset routines to get sub-jiffies
resolution from gettimeofday().  This patch includes:

* MIPS clocksource support (based on works by Manish Lachwani).
* remove unused gettimeoffset routines and related codes.
* remove unised 64bit do_div64_32().
* simplify mips_hpt_init. (no argument needed, __init tag)
* simplify c0_hpt_timer_init. (no need to write to c0_count)
* remove some hpt_init routines.
* mips_hpt_mask variable to specify bitmask of hpt value.
* convert jmr3927_do_gettimeoffset to jmr3927_hpt_read.
* convert ip27_do_gettimeoffset to ip27_hpt_read.
* convert bcm1480_do_gettimeoffset to bcm1480_hpt_read.
* simplify sb1250 hpt functions. (no need to subtract and shift)

Other than board independent part are not tested.  Please test if you
have those platforms.  Thank you.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

 Documentation/mips/time.README          |   35 ---
 arch/mips/au1000/common/time.c          |   98 ----------
 arch/mips/dec/time.c                    |    9 
 arch/mips/jmr3927/rbhma3100/irq.c       |    5 
 arch/mips/jmr3927/rbhma3100/setup.c     |   46 +---
 arch/mips/kernel/time.c                 |  312 ++++----------------------------
 arch/mips/philips/pnx8550/common/time.c |    4 
 arch/mips/pmc-sierra/yosemite/smp.c     |    6 
 arch/mips/sgi-ip27/ip27-timer.c         |   16 -
 arch/mips/sibyte/bcm1480/time.c         |   40 ++--
 arch/mips/sibyte/sb1250/time.c          |   28 --
 include/asm-mips/div64.h                |   21 --
 include/asm-mips/sibyte/sb1250.h        |    2 
 include/asm-mips/time.h                 |   10 -
 14 files changed, 108 insertions(+), 524 deletions(-)

diff --git a/Documentation/mips/time.README b/Documentation/mips/time.README
index e1304b6..e9f428a 100644
--- a/Documentation/mips/time.README
+++ b/Documentation/mips/time.README
@@ -38,17 +38,12 @@ The new time code provide the following 
 
   a) Implements functions required by Linux common code:
 	time_init
-	do_gettimeofday
-	do_settimeofday
 
   b) provides an abstraction of RTC and null RTC implementation as default.
 	extern unsigned long (*rtc_get_time)(void);
 	extern int (*rtc_set_time)(unsigned long);
 
-  c) a set of gettimeoffset functions for different CPUs and different
-     needs.
-
-  d) high-level and low-level timer interrupt routines where the timer 
+  c) high-level and low-level timer interrupt routines where the timer 
      interrupt source  may or may not be the CPU timer.  The high-level 
      routine is dispatched through do_IRQ() while the low-level is 
      dispatched in assemably code (usually int-handler.S)
@@ -73,8 +68,7 @@ the following functions or values:
   c) (optional) board-specific RTC routines.
 
   d) (optional) mips_hpt_frequency - It must be definied if the board
-     is using CPU counter for timer interrupt or it is using fixed rate
-     gettimeoffset().
+     is using CPU counter for timer interrupt.
 
 
 PORTING GUIDE
@@ -89,16 +83,6 @@ Step 1: decide how you like to implement
      If the answer is no, you need a timer to provide the timer interrupt
      at 100 HZ speed.
 
-     You cannot use the fast gettimeoffset functions, i.e.,
-
-	unsigned long fixed_rate_gettimeoffset(void);
-	unsigned long calibrate_div32_gettimeoffset(void);
-	unsigned long calibrate_div64_gettimeoffset(void);
-
-    You can use null_gettimeoffset() will gives the same time resolution as
-    jiffy.  Or you can implement your own gettimeoffset (probably based on 
-    some ad hoc hardware on your machine.)
-
   c) The following sub steps assume your CPU has counter register.
      Do you plan to use the CPU counter register as the timer interrupt
      or use an exnternal timer?
@@ -123,8 +107,8 @@ Step 3: implement rtc routines, board_ti
   board_time_init() -
   	a) (optional) set up RTC routines,
         b) (optional) calibrate and set the mips_hpt_frequency
- 	    (only needed if you intended to use fixed_rate_gettimeoffset
- 	     or use cpu counter as timer interrupt source)
+ 	    (only needed if you intended to use cpu counter as timer interrupt
+ 	     source)
 
   plat_timer_setup() -
  	a) (optional) over-write any choices made above by time_init().
@@ -154,8 +138,8 @@ for some of the functions in time.c.  
 For example, you may define your own timer interrupt routine, which does
 some of its own processing and then calls timer_interrupt().
 
-You can also over-ride any of the built-in functions (gettimeoffset,
-RTC routines and/or timer interrupt routine).
+You can also over-ride any of the built-in functions (RTC routines
+and/or timer interrupt routine).
 
 
 PORTING NOTES FOR SMP
@@ -187,10 +171,3 @@ You need to decide on your timer interru
 
 	You can also do the low-level version of those interrupt routines,
 	following similar dispatching routes described above.
-
-Note about do_gettimeoffset():
-
-  It is very likely the CPU counter registers are not sync'ed up in a SMP box.
-  Therefore you cannot really use the many of the existing routines that
-  are based on CPU counter.  You should wirte your own gettimeoffset rouinte
-  if you want intra-jiffy resolution.
diff --git a/arch/mips/au1000/common/time.c b/arch/mips/au1000/common/time.c
index 94f0919..5c5ffde 100644
--- a/arch/mips/au1000/common/time.c
+++ b/arch/mips/au1000/common/time.c
@@ -53,9 +53,6 @@ static unsigned long r4k_cur;    /* What
 int	no_au1xxx_32khz;
 extern int allow_au1k_wait; /* default off for CP0 Counter */
 
-/* Cycle counter value at the previous timer interrupt.. */
-static unsigned int timerhi = 0, timerlo = 0;
-
 #ifdef CONFIG_PM
 #if HZ < 100 || HZ > 1000
 #error "unsupported HZ value! Must be in [100,1000]"
@@ -91,10 +88,6 @@ void mips_timer_interrupt(void)
 		goto null;
 
 	do {
-		count = read_c0_count();
-		timerhi += (count < timerlo);   /* Wrap around */
-		timerlo = count;
-
 		kstat_this_cpu.irqs[irq]++;
 		do_timer(1);
 #ifndef CONFIG_SMP
@@ -301,88 +294,6 @@ #endif
 	return (cpu_speed / HZ);
 }
 
-/* This is for machines which generate the exact clock. */
-#define USECS_PER_JIFFY (1000000/HZ)
-#define USECS_PER_JIFFY_FRAC (0x100000000LL*1000000/HZ&0xffffffff)
-
-static unsigned long
-div64_32(unsigned long v1, unsigned long v2, unsigned long v3)
-{
-	unsigned long r0;
-	do_div64_32(r0, v1, v2, v3);
-	return r0;
-}
-
-static unsigned long do_fast_cp0_gettimeoffset(void)
-{
-	u32 count;
-	unsigned long res, tmp;
-	unsigned long r0;
-
-	/* Last jiffy when do_fast_gettimeoffset() was called. */
-	static unsigned long last_jiffies=0;
-	unsigned long quotient;
-
-	/*
-	 * Cached "1/(clocks per usec)*2^32" value.
-	 * It has to be recalculated once each jiffy.
-	 */
-	static unsigned long cached_quotient=0;
-
-	tmp = jiffies;
-
-	quotient = cached_quotient;
-
-	if (tmp && last_jiffies != tmp) {
-		last_jiffies = tmp;
-		if (last_jiffies != 0) {
-			r0 = div64_32(timerhi, timerlo, tmp);
-			quotient = div64_32(USECS_PER_JIFFY, USECS_PER_JIFFY_FRAC, r0);
-			cached_quotient = quotient;
-		}
-	}
-
-	/* Get last timer tick in absolute kernel time */
-	count = read_c0_count();
-
-	/* .. relative to previous jiffy (32 bits is enough) */
-	count -= timerlo;
-
-	__asm__("multu\t%1,%2\n\t"
-		"mfhi\t%0"
-		: "=r" (res)
-		: "r" (count), "r" (quotient)
-		: "hi", "lo", GCC_REG_ACCUM);
-
-	/*
-	 * Due to possible jiffies inconsistencies, we need to check
-	 * the result so that we'll get a timer that is monotonic.
-	 */
-	if (res >= USECS_PER_JIFFY)
-		res = USECS_PER_JIFFY-1;
-
-	return res;
-}
-
-#ifdef CONFIG_PM
-static unsigned long do_fast_pm_gettimeoffset(void)
-{
-	unsigned long pc0;
-	unsigned long offset;
-
-	pc0 = au_readl(SYS_TOYREAD);
-	au_sync();
-	offset = pc0 - last_pc0;
-	if (offset > 2*MATCH20_INC) {
-		printk("huge offset %x, last_pc0 %x last_match20 %x pc0 %x\n",
-				(unsigned)offset, (unsigned)last_pc0,
-				(unsigned)last_match20, (unsigned)pc0);
-	}
-	offset = (unsigned long)((offset * 305) / 10);
-	return offset;
-}
-#endif
-
 void __init plat_timer_setup(struct irqaction *irq)
 {
 	unsigned int est_freq;
@@ -420,7 +331,6 @@ #ifdef CONFIG_PM
 		unsigned int c0_status;
 
 		printk("WARNING: no 32KHz clock found.\n");
-		do_gettimeoffset = do_fast_cp0_gettimeoffset;
 
 		/* Ensure we get CPO_COUNTER interrupts.
 		*/
@@ -445,19 +355,11 @@ #ifdef CONFIG_PM
 		while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_M20);
 		startup_match20_interrupt(counter0_irq);
 
-		do_gettimeoffset = do_fast_pm_gettimeoffset;
-
 		/* We can use the real 'wait' instruction.
 		*/
 		allow_au1k_wait = 1;
 	}
 
-#else
-	/* We have to do this here instead of in timer_init because
-	 * the generic code in arch/mips/kernel/time.c will write
-	 * over our function pointer.
-	 */
-	do_gettimeoffset = do_fast_cp0_gettimeoffset;
 #endif
 }
 
diff --git a/arch/mips/dec/time.c b/arch/mips/dec/time.c
index 4cf0c06..69e424e 100644
--- a/arch/mips/dec/time.c
+++ b/arch/mips/dec/time.c
@@ -160,11 +160,6 @@ static unsigned int dec_ioasic_hpt_read(
 	return ioasic_read(IO_REG_FCTR);
 }
 
-static void dec_ioasic_hpt_init(unsigned int count)
-{
-	ioasic_write(IO_REG_FCTR, ioasic_read(IO_REG_FCTR) - count);
-}
-
 
 void __init dec_time_init(void)
 {
@@ -174,11 +169,9 @@ void __init dec_time_init(void)
 	mips_timer_state = dec_timer_state;
 	mips_timer_ack = dec_timer_ack;
 
-	if (!cpu_has_counter && IOASIC) {
+	if (!cpu_has_counter && IOASIC)
 		/* For pre-R4k systems we use the I/O ASIC's counter.  */
 		mips_hpt_read = dec_ioasic_hpt_read;
-		mips_hpt_init = dec_ioasic_hpt_init;
-	}
 
 	/* Set up the rate of periodic DS1287 interrupts.  */
 	CMOS_WRITE(RTC_REF_CLCK_32KHZ | (16 - __ffs(HZ)), RTC_REG_A);
diff --git a/arch/mips/jmr3927/rbhma3100/irq.c b/arch/mips/jmr3927/rbhma3100/irq.c
index 39a0243..4e23328 100644
--- a/arch/mips/jmr3927/rbhma3100/irq.c
+++ b/arch/mips/jmr3927/rbhma3100/irq.c
@@ -288,6 +288,7 @@ #endif
 
 static void jmr3927_spurious(void)
 {
+	struct pt_regs *regs = get_irq_regs();
 #ifdef CONFIG_TX_BRANCH_LIKELY_BUG_WORKAROUND
 	tx_branch_likely_bug_fixup();
 #endif
@@ -302,13 +303,13 @@ asmlinkage void plat_irq_dispatch(void)
 #ifdef CONFIG_TX_BRANCH_LIKELY_BUG_WORKAROUND
 	tx_branch_likely_bug_fixup();
 #endif
-	if ((regs->cp0_cause & CAUSEF_IP7) == 0) {
+	if ((read_c0_cause() & CAUSEF_IP7) == 0) {
 #if 0
 		jmr3927_spurious();
 #endif
 		return;
 	}
-	irq = (regs->cp0_cause >> CAUSEB_IP2) & 0x0f;
+	irq = (read_c0_cause() >> CAUSEB_IP2) & 0x0f;
 
 	do_IRQ(irq + JMR3927_IRQ_IRC);
 }
diff --git a/arch/mips/jmr3927/rbhma3100/setup.c b/arch/mips/jmr3927/rbhma3100/setup.c
index 0254340..744f746 100644
--- a/arch/mips/jmr3927/rbhma3100/setup.c
+++ b/arch/mips/jmr3927/rbhma3100/setup.c
@@ -170,12 +170,26 @@ static void jmr3927_machine_power_off(vo
 	while (1);
 }
 
+static unsigned int jmr3927_hpt_read(void)
+{
+	unsigned int count;
+	unsigned long j;
+	/* read consistent jiffies and counter */
+	do {
+		count = jmr3927_tmrptr->trr;
+		j = jiffies;
+	} while (count > jmr3927_tmrptr->trr);
+	return j * (JMR3927_TIMER_CLK / HZ) + count;
+}
+
 #define USE_RTC_DS1742
 #ifdef USE_RTC_DS1742
 extern void rtc_ds1742_init(unsigned long base);
 #endif
 static void __init jmr3927_time_init(void)
 {
+	mips_hpt_read = jmr3927_hpt_read;
+	mips_hpt_frequency = JMR3927_TIMER_CLK;
 #ifdef USE_RTC_DS1742
 	if (jmr3927_have_nvram()) {
 	        rtc_ds1742_init(JMR3927_IOC_NVRAMB_ADDR);
@@ -183,12 +197,8 @@ #ifdef USE_RTC_DS1742
 #endif
 }
 
-unsigned long jmr3927_do_gettimeoffset(void);
-
 void __init plat_timer_setup(struct irqaction *irq)
 {
-	do_gettimeoffset = jmr3927_do_gettimeoffset;
-
 	jmr3927_tmrptr->cpra = JMR3927_TIMER_CLK / HZ;
 	jmr3927_tmrptr->itmr = TXx927_TMTITMR_TIIE | TXx927_TMTITMR_TZCE;
 	jmr3927_tmrptr->ccdr = JMR3927_TIMER_CCD;
@@ -200,34 +210,6 @@ void __init plat_timer_setup(struct irqa
 
 #define USECS_PER_JIFFY (1000000/HZ)
 
-unsigned long jmr3927_do_gettimeoffset(void)
-{
-       unsigned long count;
-       unsigned long res = 0;
-
-       /* MUST read TRR before TISR. */
-       count = jmr3927_tmrptr->trr;
-
-       if (jmr3927_tmrptr->tisr & TXx927_TMTISR_TIIS) {
-               /* timer interrupt is pending.  use Max value. */
-               res = USECS_PER_JIFFY - 1;
-       } else {
-               /* convert to usec */
-               /* res = count / (JMR3927_TIMER_CLK / 1000000); */
-               res = (count << 7) / ((JMR3927_TIMER_CLK << 7) / 1000000);
-
-               /*
-                * Due to possible jiffies inconsistencies, we need to check
-                * the result so that we'll get a timer that is monotonic.
-                */
-               if (res >= USECS_PER_JIFFY)
-                       res = USECS_PER_JIFFY-1;
-       }
-
-       return res;
-}
-
-
 //#undef DO_WRITE_THROUGH
 #define DO_WRITE_THROUGH
 #define DO_ENABLE_CACHE
diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
index debe86c..2c6d52b 100644
--- a/arch/mips/kernel/time.c
+++ b/arch/mips/kernel/time.c
@@ -11,6 +11,7 @@
  * Free Software Foundation;  either version 2 of the  License, or (at your
  * option) any later version.
  */
+#include <linux/clocksource.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -67,15 +68,9 @@ int (*rtc_mips_set_time)(unsigned long) 
 int (*rtc_mips_set_mmss)(unsigned long);
 
 
-/* usecs per counter cycle, shifted to left by 32 bits */
-static unsigned int sll32_usecs_per_cycle;
-
 /* how many counter cycles in a jiffy */
 static unsigned long cycles_per_jiffy __read_mostly;
 
-/* Cycle counter value at the previous timer interrupt.. */
-static unsigned int timerhi, timerlo;
-
 /* expirelo is the count value for next CPU timer interrupt */
 static unsigned int expirelo;
 
@@ -93,7 +88,7 @@ static unsigned int null_hpt_read(void)
 	return 0;
 }
 
-static void null_hpt_init(unsigned int count)
+static void __init null_hpt_init(void)
 {
 	/* nothing */
 }
@@ -128,186 +123,18 @@ static unsigned int c0_hpt_read(void)
 	return read_c0_count();
 }
 
-/* For use solely as a high precision timer.  */
-static void c0_hpt_init(unsigned int count)
-{
-	write_c0_count(read_c0_count() - count);
-}
-
 /* For use both as a high precision timer and an interrupt source.  */
-static void c0_hpt_timer_init(unsigned int count)
+static void __init c0_hpt_timer_init(void)
 {
-	count = read_c0_count() - count;
-	expirelo = (count / cycles_per_jiffy + 1) * cycles_per_jiffy;
-	write_c0_count(expirelo - cycles_per_jiffy);
+	expirelo = read_c0_count() + cycles_per_jiffy;
 	write_c0_compare(expirelo);
-	write_c0_count(count);
 }
 
 int (*mips_timer_state)(void);
 void (*mips_timer_ack)(void);
 unsigned int (*mips_hpt_read)(void);
-void (*mips_hpt_init)(unsigned int);
-
-/*
- * Gettimeoffset routines.  These routines returns the time duration
- * since last timer interrupt in usecs.
- *
- * If the exact CPU counter frequency is known, use fixed_rate_gettimeoffset.
- * Otherwise use calibrate_gettimeoffset()
- *
- * If the CPU does not have the counter register, you can either supply
- * your own gettimeoffset() routine, or use null_gettimeoffset(), which
- * gives the same resolution as HZ.
- */
-
-static unsigned long null_gettimeoffset(void)
-{
-	return 0;
-}
-
-
-/* The function pointer to one of the gettimeoffset funcs.  */
-unsigned long (*do_gettimeoffset)(void) = null_gettimeoffset;
-
-
-static unsigned long fixed_rate_gettimeoffset(void)
-{
-	u32 count;
-	unsigned long res;
-
-	/* Get last timer tick in absolute kernel time */
-	count = mips_hpt_read();
-
-	/* .. relative to previous jiffy (32 bits is enough) */
-	count -= timerlo;
-
-	__asm__("multu	%1,%2"
-		: "=h" (res)
-		: "r" (count), "r" (sll32_usecs_per_cycle)
-		: "lo", GCC_REG_ACCUM);
-
-	/*
-	 * Due to possible jiffies inconsistencies, we need to check
-	 * the result so that we'll get a timer that is monotonic.
-	 */
-	if (res >= USECS_PER_JIFFY)
-		res = USECS_PER_JIFFY - 1;
-
-	return res;
-}
-
-
-/*
- * Cached "1/(clocks per usec) * 2^32" value.
- * It has to be recalculated once each jiffy.
- */
-static unsigned long cached_quotient;
-
-/* Last jiffy when calibrate_divXX_gettimeoffset() was called. */
-static unsigned long last_jiffies;
-
-/*
- * This is moved from dec/time.c:do_ioasic_gettimeoffset() by Maciej.
- */
-static unsigned long calibrate_div32_gettimeoffset(void)
-{
-	u32 count;
-	unsigned long res, tmp;
-	unsigned long quotient;
-
-	tmp = jiffies;
-
-	quotient = cached_quotient;
-
-	if (last_jiffies != tmp) {
-		last_jiffies = tmp;
-		if (last_jiffies != 0) {
-			unsigned long r0;
-			do_div64_32(r0, timerhi, timerlo, tmp);
-			do_div64_32(quotient, USECS_PER_JIFFY,
-				    USECS_PER_JIFFY_FRAC, r0);
-			cached_quotient = quotient;
-		}
-	}
-
-	/* Get last timer tick in absolute kernel time */
-	count = mips_hpt_read();
-
-	/* .. relative to previous jiffy (32 bits is enough) */
-	count -= timerlo;
-
-	__asm__("multu  %1,%2"
-		: "=h" (res)
-		: "r" (count), "r" (quotient)
-		: "lo", GCC_REG_ACCUM);
-
-	/*
-	 * Due to possible jiffies inconsistencies, we need to check
-	 * the result so that we'll get a timer that is monotonic.
-	 */
-	if (res >= USECS_PER_JIFFY)
-		res = USECS_PER_JIFFY - 1;
-
-	return res;
-}
-
-static unsigned long calibrate_div64_gettimeoffset(void)
-{
-	u32 count;
-	unsigned long res, tmp;
-	unsigned long quotient;
-
-	tmp = jiffies;
-
-	quotient = cached_quotient;
-
-	if (last_jiffies != tmp) {
-		last_jiffies = tmp;
-		if (last_jiffies) {
-			unsigned long r0;
-			__asm__(".set	push\n\t"
-				".set	mips3\n\t"
-				"lwu	%0,%3\n\t"
-				"dsll32	%1,%2,0\n\t"
-				"or	%1,%1,%0\n\t"
-				"ddivu	$0,%1,%4\n\t"
-				"mflo	%1\n\t"
-				"dsll32	%0,%5,0\n\t"
-				"or	%0,%0,%6\n\t"
-				"ddivu	$0,%0,%1\n\t"
-				"mflo	%0\n\t"
-				".set	pop"
-				: "=&r" (quotient), "=&r" (r0)
-				: "r" (timerhi), "m" (timerlo),
-				  "r" (tmp), "r" (USECS_PER_JIFFY),
-				  "r" (USECS_PER_JIFFY_FRAC)
-				: "hi", "lo", GCC_REG_ACCUM);
-			cached_quotient = quotient;
-		}
-	}
-
-	/* Get last timer tick in absolute kernel time */
-	count = mips_hpt_read();
-
-	/* .. relative to previous jiffy (32 bits is enough) */
-	count -= timerlo;
-
-	__asm__("multu	%1,%2"
-		: "=h" (res)
-		: "r" (count), "r" (quotient)
-		: "lo", GCC_REG_ACCUM);
-
-	/*
-	 * Due to possible jiffies inconsistencies, we need to check
-	 * the result so that we'll get a timer that is monotonic.
-	 */
-	if (res >= USECS_PER_JIFFY)
-		res = USECS_PER_JIFFY - 1;
-
-	return res;
-}
-
+void (*mips_hpt_init)(void) __initdata = null_hpt_init;
+unsigned int mips_hpt_mask = 0xffffffff;
 
 /* last time when xtime and rtc are sync'ed up */
 static long last_rtc_update;
@@ -334,18 +161,10 @@ void local_timer_interrupt(int irq, void
  */
 irqreturn_t timer_interrupt(int irq, void *dev_id)
 {
-	unsigned long j;
-	unsigned int count;
-
 	write_seqlock(&xtime_lock);
 
-	count = mips_hpt_read();
 	mips_timer_ack();
 
-	/* Update timerhi/timerlo for intra-jiffy calibration. */
-	timerhi += count < timerlo;			/* Wrap around */
-	timerlo = count;
-
 	/*
 	 * call the generic timer interrupt handling
 	 */
@@ -368,47 +187,6 @@ irqreturn_t timer_interrupt(int irq, voi
 		}
 	}
 
-	/*
-	 * If jiffies has overflown in this timer_interrupt, we must
-	 * update the timer[hi]/[lo] to make fast gettimeoffset funcs
-	 * quotient calc still valid. -arca
-	 *
-	 * The first timer interrupt comes late as interrupts are
-	 * enabled long after timers are initialized.  Therefore the
-	 * high precision timer is fast, leading to wrong gettimeoffset()
-	 * calculations.  We deal with it by setting it based on the
-	 * number of its ticks between the second and the third interrupt.
-	 * That is still somewhat imprecise, but it's a good estimate.
-	 * --macro
-	 */
-	j = jiffies;
-	if (j < 4) {
-		static unsigned int prev_count;
-		static int hpt_initialized;
-
-		switch (j) {
-		case 0:
-			timerhi = timerlo = 0;
-			mips_hpt_init(count);
-			break;
-		case 2:
-			prev_count = count;
-			break;
-		case 3:
-			if (!hpt_initialized) {
-				unsigned int c3 = 3 * (count - prev_count);
-
-				timerhi = 0;
-				timerlo = c3;
-				mips_hpt_init(count - c3);
-				hpt_initialized = 1;
-			}
-			break;
-		default:
-			break;
-		}
-	}
-
 	write_sequnlock(&xtime_lock);
 
 	/*
@@ -476,12 +254,11 @@ asmlinkage void ll_local_timer_interrupt
  * 1) board_time_init() -
  * 	a) (optional) set up RTC routines,
  *      b) (optional) calibrate and set the mips_hpt_frequency
- *	    (only needed if you intended to use fixed_rate_gettimeoffset
- *	     or use cpu counter as timer interrupt source)
+ *	    (only needed if you intended to use cpu counter as timer interrupt
+ *	     source)
  * 2) setup xtime based on rtc_mips_get_time().
- * 3) choose a appropriate gettimeoffset routine.
- * 4) calculate a couple of cached variables for later usage
- * 5) plat_timer_setup() -
+ * 3) calculate a couple of cached variables for later usage
+ * 4) plat_timer_setup() -
  *	a) (optional) over-write any choices made above by time_init().
  *	b) machine specific code should setup the timer irqaction.
  *	c) enable the timer interrupt
@@ -533,13 +310,41 @@ static unsigned int __init calibrate_hpt
 	} while (--i);
 	hpt_end = mips_hpt_read();
 
-	hpt_count = hpt_end - hpt_start;
+	hpt_count = (hpt_end - hpt_start) & mips_hpt_mask;
 	hz = HZ;
 	frequency = (u64)hpt_count * (u64)hz;
 
 	return frequency >> log_2_loops;
 }
 
+static cycle_t read_mips_hpt(void)
+{
+	return (cycle_t)mips_hpt_read();
+}
+
+static struct clocksource clocksource_mips = {
+	.name		= "MIPS",
+	.rating		= 250,
+	.read		= read_mips_hpt,
+	.shift		= 24,
+	.is_continuous	= 1,
+};
+
+static void __init init_mips_clocksource(void)
+{
+	u64 temp;
+
+	if (!mips_hpt_frequency || mips_hpt_read == null_hpt_read)
+		return;
+
+	temp = (u64) NSEC_PER_SEC << clocksource_mips.shift;
+	do_div(temp, mips_hpt_frequency);
+	clocksource_mips.mult = (unsigned)temp;
+	clocksource_mips.mask = mips_hpt_mask;
+
+	clocksource_register(&clocksource_mips);
+}
+
 void __init time_init(void)
 {
 	if (board_time_init)
@@ -555,41 +360,21 @@ void __init time_init(void)
 	                        -xtime.tv_sec, -xtime.tv_nsec);
 
 	/* Choose appropriate high precision timer routines.  */
-	if (!cpu_has_counter && !mips_hpt_read) {
+	if (!cpu_has_counter && !mips_hpt_read)
 		/* No high precision timer -- sorry.  */
 		mips_hpt_read = null_hpt_read;
-		mips_hpt_init = null_hpt_init;
-	} else if (!mips_hpt_frequency && !mips_timer_state) {
+	else if (!mips_hpt_frequency && !mips_timer_state) {
 		/* A high precision timer of unknown frequency.  */
-		if (!mips_hpt_read) {
+		if (!mips_hpt_read)
 			/* No external high precision timer -- use R4k.  */
 			mips_hpt_read = c0_hpt_read;
-			mips_hpt_init = c0_hpt_init;
-		}
-
-		if (cpu_has_mips32r1 || cpu_has_mips32r2 ||
-		    (current_cpu_data.isa_level == MIPS_CPU_ISA_I) ||
-		    (current_cpu_data.isa_level == MIPS_CPU_ISA_II))
-			/*
-			 * We need to calibrate the counter but we don't have
-			 * 64-bit division.
-			 */
-			do_gettimeoffset = calibrate_div32_gettimeoffset;
-		else
-			/*
-			 * We need to calibrate the counter but we *do* have
-			 * 64-bit division.
-			 */
-			do_gettimeoffset = calibrate_div64_gettimeoffset;
 	} else {
 		/* We know counter frequency.  Or we can get it.  */
 		if (!mips_hpt_read) {
 			/* No external high precision timer -- use R4k.  */
 			mips_hpt_read = c0_hpt_read;
 
-			if (mips_timer_state)
-				mips_hpt_init = c0_hpt_init;
-			else {
+			if (!mips_timer_state) {
 				/* No external timer interrupt -- use R4k.  */
 				mips_hpt_init = c0_hpt_timer_init;
 				mips_timer_ack = c0_timer_ack;
@@ -598,16 +383,9 @@ void __init time_init(void)
 		if (!mips_hpt_frequency)
 			mips_hpt_frequency = calibrate_hpt();
 
-		do_gettimeoffset = fixed_rate_gettimeoffset;
-
 		/* Calculate cache parameters.  */
 		cycles_per_jiffy = (mips_hpt_frequency + HZ / 2) / HZ;
 
-		/* sll32_usecs_per_cycle = 10^6 * 2^32 / mips_counter_freq  */
-		do_div64_32(sll32_usecs_per_cycle,
-			    1000000, mips_hpt_frequency / 2,
-			    mips_hpt_frequency);
-
 		/* Report the high precision timer rate for a reference.  */
 		printk("Using %u.%03u MHz high precision timer.\n",
 		       ((mips_hpt_frequency + 500) / 1000) / 1000,
@@ -619,7 +397,7 @@ void __init time_init(void)
 		mips_timer_ack = null_timer_ack;
 
 	/* This sets up the high precision timer for the first interrupt.  */
-	mips_hpt_init(mips_hpt_read());
+	mips_hpt_init();
 
 	/*
 	 * Call board specific timer interrupt setup.
@@ -633,6 +411,8 @@ void __init time_init(void)
 	 * is not invoked accidentally.
 	 */
 	plat_timer_setup(&timer_irqaction);
+
+	init_mips_clocksource();
 }
 
 #define FEBRUARY		2
diff --git a/arch/mips/philips/pnx8550/common/time.c b/arch/mips/philips/pnx8550/common/time.c
index 0af655b..593f470 100644
--- a/arch/mips/philips/pnx8550/common/time.c
+++ b/arch/mips/philips/pnx8550/common/time.c
@@ -41,8 +41,8 @@ extern unsigned int mips_hpt_frequency;
  * 1) board_time_init() -
  * 	a) (optional) set up RTC routines,
  *      b) (optional) calibrate and set the mips_hpt_frequency
- *	    (only needed if you intended to use fixed_rate_gettimeoffset
- *	     or use cpu counter as timer interrupt source)
+ *	    (only needed if you intended to use cpu counter as timer interrupt 
+ *	     source)
  */
 
 void pnx8550_time_init(void)
diff --git a/arch/mips/pmc-sierra/yosemite/smp.c b/arch/mips/pmc-sierra/yosemite/smp.c
index 65fa3a2..3cc0436 100644
--- a/arch/mips/pmc-sierra/yosemite/smp.c
+++ b/arch/mips/pmc-sierra/yosemite/smp.c
@@ -3,9 +3,7 @@ #include <linux/sched.h>
 
 #include <asm/pmon.h>
 #include <asm/titan_dep.h>
-
-extern unsigned int (*mips_hpt_read)(void);
-extern void (*mips_hpt_init)(unsigned int);
+#include <asm/time.h>
 
 #define LAUNCHSTACK_SIZE 256
 
@@ -101,7 +99,7 @@ void prom_cpus_done(void)
  */
 void prom_init_secondary(void)
 {
-	mips_hpt_init(mips_hpt_read());
+	mips_hpt_init();
 
 	set_c0_status(ST0_CO | ST0_IE | ST0_IM);
 }
diff --git a/arch/mips/sgi-ip27/ip27-timer.c b/arch/mips/sgi-ip27/ip27-timer.c
index 4e870fc..c965705 100644
--- a/arch/mips/sgi-ip27/ip27-timer.c
+++ b/arch/mips/sgi-ip27/ip27-timer.c
@@ -134,13 +134,6 @@ again:
 	irq_exit();
 }
 
-unsigned long ip27_do_gettimeoffset(void)
-{
-	unsigned long ct_cur1;
-	ct_cur1 = REMOTE_HUB_L(cputonasid(0), PI_RT_COUNT) + CYCLES_PER_JIFFY;
-	return (ct_cur1 - ct_cur[0]) * NSEC_PER_CYCLE / 1000;
-}
-
 /* Includes for ioc3_init().  */
 #include <asm/sn/types.h>
 #include <asm/sn/sn0/addrs.h>
@@ -248,12 +241,17 @@ void __init plat_timer_setup(struct irqa
 	setup_irq(irqno, &rt_irqaction);
 }
 
+static unsigned int ip27_hpt_read(void)
+{
+	return REMOTE_HUB_L(cputonasid(0), PI_RT_COUNT);
+}
+
 void __init ip27_time_init(void)
 {
+	mips_hpt_read = ip27_hpt_read;
+	mips_hpt_frequency = CYCLES_PER_SEC;
 	xtime.tv_sec = get_m48t35_time();
 	xtime.tv_nsec = 0;
-
-	do_gettimeoffset = ip27_do_gettimeoffset;
 }
 
 void __init cpu_time_init(void)
diff --git a/arch/mips/sibyte/bcm1480/time.c b/arch/mips/sibyte/bcm1480/time.c
index bf12af4..7eaed0f 100644
--- a/arch/mips/sibyte/bcm1480/time.c
+++ b/arch/mips/sibyte/bcm1480/time.c
@@ -47,6 +47,12 @@ #define IMR_IP2_VAL	K_BCM1480_INT_MAP_I0
 #define IMR_IP3_VAL	K_BCM1480_INT_MAP_I1
 #define IMR_IP4_VAL	K_BCM1480_INT_MAP_I2
 
+#ifdef CONFIG_SIMULATION
+#define BCM1480_HPT_VALUE	50000
+#else
+#define BCM1480_HPT_VALUE	1000000
+#endif
+
 extern int bcm1480_steal_irq(int irq);
 
 void bcm1480_time_init(void)
@@ -59,11 +65,6 @@ void bcm1480_time_init(void)
 		BUG();
 	}
 
-	if (!cpu) {
-		/* Use our own gettimeoffset() routine */
-		do_gettimeoffset = bcm1480_gettimeoffset;
-	}
-
 	bcm1480_mask_irq(cpu, irq);
 
 	/* Map the timer interrupt to ip[4] of this cpu */
@@ -74,11 +75,7 @@ void bcm1480_time_init(void)
 	/* Disable the timer and set up the count */
 	__raw_writeq(0, IOADDR(A_SCD_TIMER_REGISTER(cpu, R_SCD_TIMER_CFG)));
 	__raw_writeq(
-#ifndef CONFIG_SIMULATION
-		1000000/HZ
-#else
-		50000/HZ
-#endif
+		BCM1480_HPT_VALUE/HZ
 		, IOADDR(A_SCD_TIMER_REGISTER(cpu, R_SCD_TIMER_INIT)));
 
 	/* Set the timer running */
@@ -122,16 +119,19 @@ void bcm1480_timer_interrupt(void)
 	}
 }
 
-/*
- * We use our own do_gettimeoffset() instead of the generic one,
- * because the generic one does not work for SMP case.
- * In addition, since we use general timer 0 for system time,
- * we can get accurate intra-jiffy offset without calibration.
- */
-unsigned long bcm1480_gettimeoffset(void)
+static unsigned int bcm1480_hpt_read(void)
 {
-	unsigned long count =
-		__raw_readq(IOADDR(A_SCD_TIMER_REGISTER(0, R_SCD_TIMER_CNT)));
+	unsigned long count, j;
+	/* read consistent jiffies and counter */
+	do {
+		count = __raw_readq(IOADDR(A_SCD_TIMER_REGISTER(0, R_SCD_TIMER_CNT)));
+		j = jiffies;
+	} while (count < __raw_readq(IOADDR(A_SCD_TIMER_REGISTER(0, R_SCD_TIMER_CNT))));
+	return (j + 1) * (BCM1480_HPT_VALUE / HZ) - count;
+}
 
-	return 1000000/HZ - count;
+void __init bcm1480_hpt_setup(void)
+{
+	mips_hpt_read = bcm1480_hpt_read;
+	mips_hpt_frequency = BCM1480_HPT_VALUE;
 }
diff --git a/arch/mips/sibyte/sb1250/time.c b/arch/mips/sibyte/sb1250/time.c
index 0ccf179..8a1fc04 100644
--- a/arch/mips/sibyte/sb1250/time.c
+++ b/arch/mips/sibyte/sb1250/time.c
@@ -47,15 +47,11 @@ #define IMR_IP4_VAL	K_INT_MAP_I2
 
 #define SB1250_HPT_NUM		3
 #define SB1250_HPT_VALUE	M_SCD_TIMER_CNT /* max value */
-#define SB1250_HPT_SHIFT	((sizeof(unsigned int)*8)-V_SCD_TIMER_WIDTH)
 
 
 extern int sb1250_steal_irq(int irq);
 
 static unsigned int sb1250_hpt_read(void);
-static void sb1250_hpt_init(unsigned int);
-
-static unsigned int hpt_offset;
 
 void __init sb1250_hpt_setup(void)
 {
@@ -69,13 +65,9 @@ void __init sb1250_hpt_setup(void)
 		__raw_writeq(M_SCD_TIMER_ENABLE | M_SCD_TIMER_MODE_CONTINUOUS,
 			     IOADDR(A_SCD_TIMER_REGISTER(SB1250_HPT_NUM, R_SCD_TIMER_CFG)));
 
-		/*
-		 * we need to fill 32 bits, so just use the upper 23 bits and pretend
-		 * the timer is going 512Mhz instead of 1Mhz
-		 */
-		mips_hpt_frequency = V_SCD_TIMER_FREQ << SB1250_HPT_SHIFT;
-		mips_hpt_init = sb1250_hpt_init;
+		mips_hpt_frequency = V_SCD_TIMER_FREQ;
 		mips_hpt_read = sb1250_hpt_read;
+		mips_hpt_mask = V_SCD_TIMER_WIDTH;
 	}
 }
 
@@ -149,11 +141,7 @@ void sb1250_timer_interrupt(void)
 
 /*
  * The HPT is free running from SB1250_HPT_VALUE down to 0 then starts over
- * again. There's no easy way to set to a specific value so store init value
- * in hpt_offset and subtract each time.
- *
- * Note: Timer isn't full 32bits so shift it into the upper part making
- *       it appear to run at a higher frequency.
+ * again.
  */
 static unsigned int sb1250_hpt_read(void)
 {
@@ -161,13 +149,5 @@ static unsigned int sb1250_hpt_read(void
 
 	count = G_SCD_TIMER_CNT(__raw_readq(IOADDR(A_SCD_TIMER_REGISTER(SB1250_HPT_NUM, R_SCD_TIMER_CNT))));
 
-	count = (SB1250_HPT_VALUE - count) << SB1250_HPT_SHIFT;
-
-	return count - hpt_offset;
-}
-
-static void sb1250_hpt_init(unsigned int count)
-{
-	hpt_offset = count;
-	return;
+	return SB1250_HPT_VALUE - count;
 }
diff --git a/include/asm-mips/div64.h b/include/asm-mips/div64.h
index 5f7dcf5..d107832 100644
--- a/include/asm-mips/div64.h
+++ b/include/asm-mips/div64.h
@@ -83,27 +83,6 @@ #endif /* (_MIPS_SZLONG == 32) */
 #if (_MIPS_SZLONG == 64)
 
 /*
- * Don't use this one in new code
- */
-#define do_div64_32(res, high, low, base) ({ \
-	unsigned int __quot, __mod; \
-	unsigned long __div; \
-	unsigned int __low, __high, __base; \
-	\
-	__high = (high); \
-	__low = (low); \
-	__div = __high; \
-	__div = __div << 32 | __low; \
-	__base = (base); \
-	\
-	__mod = __div % __base; \
-	__div = __div / __base; \
-	\
-	__quot = __div; \
-	(res) = __quot; \
-	__mod; })
-
-/*
  * Hey, we're already 64-bit, no
  * need to play games..
  */
diff --git a/include/asm-mips/sibyte/sb1250.h b/include/asm-mips/sibyte/sb1250.h
index b09e16c..2ba6988 100644
--- a/include/asm-mips/sibyte/sb1250.h
+++ b/include/asm-mips/sibyte/sb1250.h
@@ -51,8 +51,8 @@ extern void sb1250_mask_irq(int cpu, int
 extern void sb1250_unmask_irq(int cpu, int irq);
 extern void sb1250_smp_finish(void);
 
+extern void bcm1480_hpt_setup(void);
 extern void bcm1480_time_init(void);
-extern unsigned long bcm1480_gettimeoffset(void);
 extern void bcm1480_mask_irq(int cpu, int irq);
 extern void bcm1480_unmask_irq(int cpu, int irq);
 extern void bcm1480_smp_finish(void);
diff --git a/include/asm-mips/time.h b/include/asm-mips/time.h
index 28512ba..625acd3 100644
--- a/include/asm-mips/time.h
+++ b/include/asm-mips/time.h
@@ -48,7 +48,8 @@ extern void (*mips_timer_ack)(void);
  * If mips_hpt_read is NULL, an R4k-compatible timer setup is attempted.
  */
 extern unsigned int (*mips_hpt_read)(void);
-extern void (*mips_hpt_init)(unsigned int);
+extern void (*mips_hpt_init)(void);
+extern unsigned int mips_hpt_mask;
 
 /*
  * to_tm() converts system time back to (year, mon, day, hour, min, sec).
@@ -58,13 +59,6 @@ extern void (*mips_hpt_init)(unsigned in
 extern void to_tm(unsigned long tim, struct rtc_time *tm);
 
 /*
- * do_gettimeoffset(). By default, this func pointer points to
- * do_null_gettimeoffset(), which leads to the same resolution as HZ.
- * Higher resolution versions are available, which give ~1us resolution.
- */
-extern unsigned long (*do_gettimeoffset)(void);
-
-/*
  * high-level timer interrupt routines.
  */
 extern irqreturn_t timer_interrupt(int irq, void *dev_id);
