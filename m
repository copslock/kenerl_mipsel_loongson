Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Aug 2003 18:19:39 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:21909 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224772AbTHDRTg>; Mon, 4 Aug 2003 18:19:36 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA20895;
	Mon, 4 Aug 2003 19:19:33 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Mon, 4 Aug 2003 19:19:32 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: linux-mips@linux-mips.org
Subject: [patch] Time handling: now the big changes
Message-ID: <Pine.GSO.3.96.1030804183710.17066I-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2980
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

Hello,

 Now it's the time for the big changes.  The following patch adds a
pluggable handlers capability to the generic MIPS time handler.  Now most,
if not all systems can use the code, e.g. ones that fit one of the
following models: 

1. No external high precision timer (HPT), no R4k timer, an external timer
IRQ. 

2. An external HPT, no R4k timer, an external timer IRQ.

3. No external HPT, an R4k timer, an external timer IRQ. 

4. No external HPT, an R4k timer, an R4k timer IRQ. 

If a system has both an external HPT and an R4k timer, it can select which
one to use (e.g. based on the designed clock stability).  If a system has
both an external timer IRQ and an R4k timer IRQ, it can also select which
one to use (e.g. based on the flexibility of available intervals).

 Three pluggable handlers are available:

- mips_timer_ack() -- used to send an acknowledge to the originator of the
timer IRQ.  It may be used to reprogram a one-shot kind of IRQ source,
such as the R4k timer IRQ.  If unset by a board-specific backend, it
defaults to an R4k-specific handler if an R4k timer is available and its
driving frequency is known, otherwise it's set to a null handler (which
still makes sense for self-recoverable sources).

- mips_hpt_read() -- used to read a HPT.  If unset by a board-specific
backend, it defaults to an R4k-specific handler if an R4k timer is
available otherwise it's set to a null handler that always returns zeor
(no offsets to jiffies).

- mips_hpt_init() -- used to initialize a HPT.  It has a bit non-obvious
semantics: its argument is to be subtracted from the current value of the
HPT.  It's an aid for handling jiffy overflows (which are rare and thus
should be handled especially carefully -- hardly anyone will notice a
problem here, so once one happens it may be a complete disaster) -- if a
direct initialization is needed, "mips_hpt_init(mips_hpt_read() - <v>)"
can be used.  If in doubt, use the source, Luke.  Its default
initialization depends on mips_hpt_read() (the function makes no sense
alone): if that function is unset, it defaults to an R4k-specific handler
if an R4k timer is available, otherwise it's set to a null handler. 

 In addition to the above changes, a few fixes are included:

- USECS_PER_JIFFY is now set to tick,

- USECS_PER_JIFFY_FRAC is now properly zero-extended,

- division in calibrate_div64_gettimeoffset() now propely makes use of
USECS_PER_JIFFY_FRAC (for better accuracy), plus missing clobbers are
added,

- jiffies overflow trigger resets the HPT,

- internal gettimeoffset() functions are now static as they do not need to
be referred to externally.

 OK to apply?

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.21-20030725-mips-time-6
diff -up --recursive --new-file linux-mips-2.4.21-20030725.macro/arch/mips/kernel/time.c linux-mips-2.4.21-20030725/arch/mips/kernel/time.c
--- linux-mips-2.4.21-20030725.macro/arch/mips/kernel/time.c	2003-07-31 21:27:18.000000000 +0000
+++ linux-mips-2.4.21-20030725/arch/mips/kernel/time.c	2003-08-03 17:43:49.000000000 +0000
@@ -31,9 +31,14 @@
 #include <asm/hardirq.h>
 #include <asm/div64.h>
 
-/* This is for machines which generate the exact clock. */
-#define USECS_PER_JIFFY (1000000/HZ)
-#define USECS_PER_JIFFY_FRAC ((u32)((1000000ULL << 32) / HZ))
+/*
+ * The integer part of the number of usecs per jiffy is taken from tick,
+ * but the fractional part is not recorded, so we calculate it using the
+ * initial value of HZ.  This aids systems where tick isn't really an
+ * integer (e.g. for HZ = 128).
+ */
+#define USECS_PER_JIFFY		tick
+#define USECS_PER_JIFFY_FRAC	((unsigned long)(u32)((1000000ULL << 32) / HZ))
 
 /*
  * forward reference
@@ -48,6 +53,7 @@ spinlock_t rtc_lock = SPIN_LOCK_UNLOCKED
  */
 int emulate_local_timer_interrupt;
 
+
 /*
  * By default we provide the null RTC ops
  */
@@ -66,6 +72,84 @@ int (*rtc_set_time)(unsigned long) = nul
 int (*rtc_set_mmss)(unsigned long);
 
 
+/* usecs per counter cycle, shifted to left by 32 bits */
+static unsigned int sll32_usecs_per_cycle;
+
+/* how many counter cycles in a jiffy */
+static unsigned long cycles_per_jiffy;
+
+/* Cycle counter value at the previous timer interrupt.. */
+static unsigned int timerhi, timerlo;
+
+/* expirelo is the count value for next CPU timer interrupt */
+static unsigned int expirelo;
+
+
+/*
+ * Null timer ack for systems not needing one (e.g. i8254).
+ */
+static void null_timer_ack(void) { /* nothing */ }
+
+/*
+ * Null high precision timer functions for systems lacking one.
+ */
+static unsigned int null_hpt_read(void)
+{
+	return 0;
+}
+
+static void null_hpt_init(unsigned int count) { /* nothing */ }
+
+
+/*
+ * Timer ack for a R4k-compatible timer of a known frequency.
+ */
+static void c0_fixed_timer_ack(void)
+{
+	unsigned int count;
+
+	/* Ack this timer interrupt and set the next one.  */
+	expirelo += cycles_per_jiffy;
+	write_c0_compare(expirelo);
+
+	/* Check to see if we have missed any timer interrupts.  */
+	count = read_c0_count();
+	if ((count - expirelo) < 0x7fffffff) {
+		/* missed_timer_count++; */
+		expirelo = count + cycles_per_jiffy;
+		write_c0_compare(expirelo);
+	}
+}
+
+/*
+ * High precision timer functions for a R4k-compatible timer.
+ */
+static unsigned int c0_hpt_read(void)
+{
+	return read_c0_count();
+}
+
+/* For unknown frequency.  */
+static void c0_hpt_init(unsigned int count)
+{
+	write_c0_count(read_c0_count() - count);
+}
+
+/* For a known frequency.  Used as an interrupt source.  */
+static void c0_fixed_hpt_init(unsigned int count)
+{
+	expirelo = cycles_per_jiffy;
+	count = read_c0_count() - count;
+	write_c0_count(0);
+	write_c0_compare(cycles_per_jiffy);
+	write_c0_count(count);
+}
+
+void (*mips_timer_ack)(void);
+unsigned int (*mips_hpt_read)(void);
+void (*mips_hpt_init)(unsigned int);
+
+
 /*
  * timeofday services, for syscalls.
  */
@@ -128,42 +212,28 @@ void do_settimeofday(struct timeval *tv)
  * If the exact CPU counter frequency is known, use fixed_rate_gettimeoffset.
  * Otherwise use calibrate_gettimeoffset()
  *
- * If the CPU does not have counter register all, you can either supply
- * your own gettimeoffset() routine, or use null_gettimeoffset() routines,
- * which gives the same resolution as HZ.
+ * If the CPU does not have the counter register, you can either supply
+ * your own gettimeoffset() routine, or use null_gettimeoffset(), which
+ * gives the same resolution as HZ.
  */
 
-
-/* usecs per counter cycle, shifted to left by 32 bits */
-static unsigned int sll32_usecs_per_cycle;
-
-/* how many counter cycles in a jiffy */
-static unsigned long cycles_per_jiffy;
-
-/* Cycle counter value at the previous timer interrupt.. */
-static unsigned int timerhi, timerlo;
-
-/* expirelo is the count value for next CPU timer interrupt */
-static unsigned int expirelo;
-
-/* last time when xtime and rtc are sync'ed up */
-static long last_rtc_update;
-
-/* the function pointer to one of the gettimeoffset funcs*/
-unsigned long (*do_gettimeoffset)(void) = null_gettimeoffset;
-
 unsigned long null_gettimeoffset(void)
 {
 	return 0;
 }
 
-unsigned long fixed_rate_gettimeoffset(void)
+
+/* The function pointer to one of the gettimeoffset funcs.  */
+unsigned long (*do_gettimeoffset)(void) = null_gettimeoffset;
+
+
+static unsigned long fixed_rate_gettimeoffset(void)
 {
 	u32 count;
 	unsigned long res;
 
 	/* Get last timer tick in absolute kernel time */
-	count = read_c0_count();
+	count = mips_hpt_read();
 
 	/* .. relative to previous jiffy (32 bits is enough) */
 	count -= timerlo;
@@ -183,6 +253,7 @@ unsigned long fixed_rate_gettimeoffset(v
 	return res;
 }
 
+
 /*
  * Cached "1/(clocks per usec) * 2^32" value.
  * It has to be recalculated once each jiffy.
@@ -192,11 +263,10 @@ static unsigned long cached_quotient;
 /* Last jiffy when calibrate_divXX_gettimeoffset() was called. */
 static unsigned long last_jiffies;
 
-
 /*
- * This is copied from dec/time.c:do_ioasic_gettimeoffset() by Maciej.
+ * This is moved from dec/time.c:do_ioasic_gettimeoffset() by Maciej.
  */
-unsigned long calibrate_div32_gettimeoffset(void)
+static unsigned long calibrate_div32_gettimeoffset(void)
 {
 	u32 count;
 	unsigned long res, tmp;
@@ -218,7 +288,7 @@ unsigned long calibrate_div32_gettimeoff
 	}
 
 	/* Get last timer tick in absolute kernel time */
-	count = read_c0_count();
+	count = mips_hpt_read();
 
 	/* .. relative to previous jiffy (32 bits is enough) */
 	count -= timerlo;
@@ -238,7 +308,7 @@ unsigned long calibrate_div32_gettimeoff
 	return res;
 }
 
-unsigned long calibrate_div64_gettimeoffset(void)
+static unsigned long calibrate_div64_gettimeoffset(void)
 {
 	u32 count;
 	unsigned long res, tmp;
@@ -248,30 +318,33 @@ unsigned long calibrate_div64_gettimeoff
 
 	quotient = cached_quotient;
 
-	if (tmp && last_jiffies != tmp) {
+	if (last_jiffies != tmp) {
 		last_jiffies = tmp;
-		__asm__(".set	push\n\t"
-			".set	noreorder\n\t"
-			".set	noat\n\t"
-			".set	mips3\n\t"
-			"lwu	%0,%2\n\t"
-			"dsll32	$1,%1,0\n\t"
-			"or	$1,$1,%0\n\t"
-			"ddivu	$0,$1,%3\n\t"
-			"mflo	$1\n\t"
-			"dsll32	%0,%4,0\n\t"
-			"nop\n\t"
-			"ddivu	$0,%0,$1\n\t"
-			"mflo	%0\n\t"
-			".set	pop"
-			: "=&r" (quotient)
-			: "r" (timerhi), "m" (timerlo),
-			  "r" (tmp), "r" (USECS_PER_JIFFY));
-		cached_quotient = quotient;
+		if (last_jiffies) {
+			unsigned long r0;
+			__asm__(".set	push\n\t"
+				".set	mips3\n\t"
+				"lwu	%0,%3\n\t"
+				"dsll32	%1,%2,0\n\t"
+				"or	%1,%1,%0\n\t"
+				"ddivu	$0,%1,%4\n\t"
+				"mflo	%1\n\t"
+				"dsll32	%0,%5,0\n\t"
+				"or	%0,%0,%6\n\t"
+				"ddivu	$0,%0,%1\n\t"
+				"mflo	%0\n\t"
+				".set	pop"
+				: "=&r" (quotient), "=&r" (r0)
+				: "r" (timerhi), "m" (timerlo),
+				  "r" (tmp), "r" (USECS_PER_JIFFY),
+				  "r" (USECS_PER_JIFFY_FRAC)
+				: "hi", "lo", "accum");
+			cached_quotient = quotient;
+		}
 	}
 
 	/* Get last timer tick in absolute kernel time */
-	count = read_c0_count();
+	count = mips_hpt_read();
 
 	/* .. relative to previous jiffy (32 bits is enough) */
 	count -= timerlo;
@@ -292,6 +365,9 @@ unsigned long calibrate_div64_gettimeoff
 }
 
 
+/* last time when xtime and rtc are sync'ed up */
+static long last_rtc_update;
+
 /*
  * local_timer_interrupt() does profiling and process accounting
  * on a per-CPU basis.
@@ -329,30 +405,19 @@ void local_timer_interrupt(int irq, void
 }
 
 /*
- * high-level timer interrupt service routines.  This function
+ * High-level timer interrupt service routines.  This function
  * is set as irqaction->handler and is invoked through do_IRQ.
  */
 void timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
-	if (cpu_has_counter) {
-		unsigned int count;
+	unsigned int count;
 
-		/* ack timer interrupt, and try to set next interrupt */
-		expirelo += cycles_per_jiffy;
-		write_c0_compare(expirelo);
-		count = read_c0_count();
+	count = mips_hpt_read();
+	mips_timer_ack();
 
-		/* check to see if we have missed any timer interrupts */
-		if ((count - expirelo) < 0x7fffffff) {
-			/* missed_timer_count++; */
-			expirelo = count + cycles_per_jiffy;
-			write_c0_compare(expirelo);
-		}
-
-		/* Update timerhi/timerlo for intra-jiffy calibration. */
-		timerhi += count < timerlo;	/* Wrap around */
-		timerlo = count;
-	}
+	/* Update timerhi/timerlo for intra-jiffy calibration. */
+	timerhi += count < timerlo;			/* Wrap around */
+	timerlo = count;
 
 	/*
 	 * call the generic timer interrupt handling
@@ -379,12 +444,13 @@ void timer_interrupt(int irq, void *dev_
 	read_unlock(&xtime_lock);
 
 	/*
-	 * If jiffies has overflowed in this timer_interrupt we must
+	 * If jiffies has overflown in this timer_interrupt, we must
 	 * update the timer[hi]/[lo] to make fast gettimeoffset funcs
 	 * quotient calc still valid. -arca
 	 */
 	if (!jiffies) {
 		timerhi = timerlo = 0;
+		mips_hpt_init(count);
 	}
 
 #if !defined(CONFIG_SMP)
@@ -484,50 +550,70 @@ void __init time_init(void)
 	xtime.tv_sec = rtc_get_time();
 	xtime.tv_usec = 0;
 
-	/* choose appropriate gettimeoffset routine */
-	if (!cpu_has_counter) {
-		/* no cpu counter - sorry */
-		do_gettimeoffset = null_gettimeoffset;
-	} else if (mips_counter_frequency != 0) {
-		/* we have cpu counter and know counter frequency! */
-		do_gettimeoffset = fixed_rate_gettimeoffset;
-	} else if ((current_cpu_data.isa_level == MIPS_CPU_ISA_M32) ||
-		   (current_cpu_data.isa_level == MIPS_CPU_ISA_I) ||
-		   (current_cpu_data.isa_level == MIPS_CPU_ISA_II) ) {
-		/* we need to calibrate the counter but we don't have
-		 * 64-bit division. */
-		do_gettimeoffset = calibrate_div32_gettimeoffset;
+	/* Choose appropriate high precision timer routines.  */
+	if (!cpu_has_counter && !mips_hpt_read) {
+		/* No high precision timer -- sorry.  */
+		mips_hpt_read = null_hpt_read;
+		mips_hpt_init = null_hpt_init;
+	} else if (!mips_counter_frequency) {
+		/* A high precision timer of unknown frequency.  */
+		if (!mips_hpt_read) {
+			/* No external high precision timer -- use R4k.  */
+			mips_hpt_read = c0_hpt_read;
+			mips_hpt_init = c0_hpt_init;
+		}
+
+		if ((current_cpu_data.isa_level == MIPS_CPU_ISA_M32) ||
+			 (current_cpu_data.isa_level == MIPS_CPU_ISA_I) ||
+			 (current_cpu_data.isa_level == MIPS_CPU_ISA_II))
+			/*
+			 * We need to calibrate the counter but we don't have
+			 * 64-bit division.
+			 */
+			do_gettimeoffset = calibrate_div32_gettimeoffset;
+		else
+			/*
+			 * We need to calibrate the counter but we *do* have
+			 * 64-bit division.
+			 */
+			do_gettimeoffset = calibrate_div64_gettimeoffset;
 	} else {
-		/* we need to calibrate the counter but we *do* have
-		 * 64-bit division. */
-		do_gettimeoffset = calibrate_div64_gettimeoffset;
-	}
+		/* We know counter frequency! */
+		if (!mips_hpt_read) {
+			/* No external high precision timer -- use R4k.  */
+			mips_hpt_read = c0_hpt_read;
+			mips_hpt_init = c0_fixed_hpt_init;
+
+			if (!mips_timer_ack)
+				/* R4k timer interrupt ack.  */
+				mips_timer_ack = c0_fixed_timer_ack;
+		}
 
-	/* caclulate cache parameters */
-	if (mips_counter_frequency) {
+		do_gettimeoffset = fixed_rate_gettimeoffset;
+
+		/* Calculate cache parameters.  */
 		cycles_per_jiffy = mips_counter_frequency / HZ;
 
-		/* sll32_usecs_per_cycle = 10^6 * 2^32 / mips_counter_freq */
-		/* any better way to do this? */
+		/* sll32_usecs_per_cycle = 10^6 * 2^32 / mips_counter_freq  */
+		/* Any better way to do this?  */
 		sll32_usecs_per_cycle = mips_counter_frequency / 100000;
 		sll32_usecs_per_cycle = 0xffffffff / sll32_usecs_per_cycle;
 		sll32_usecs_per_cycle *= 10;
-
-		/*
-		 * For those using cpu counter as timer,  this sets up the
-		 * first interrupt
-		 */
-		write_c0_compare(cycles_per_jiffy);
-		write_c0_count(0);
-		expirelo = cycles_per_jiffy;
 	}
 
+	if (!mips_timer_ack)
+		/* No timer interrupt ack (e.g. i8254).  */
+		mips_timer_ack = null_timer_ack;
+
+	/* This sets up the high precision timer for the first interrupt.  */
+	mips_hpt_init(mips_hpt_read());
+
 	/*
 	 * Call board specific timer interrupt setup.
 	 *
 	 * this pointer must be setup in machine setup routine.
 	 *
-	 * Even if the machine choose to use low-level timer interrupt,
+	 * Even if a machine chooses to use a low-level timer interrupt,
 	 * it still needs to setup the timer_irqaction.
 	 * In that case, it might be better to set timer_irqaction.handler
 	 * to be NULL function so that we are sure the high-level code
diff -up --recursive --new-file linux-mips-2.4.21-20030725.macro/arch/mips64/kernel/time.c linux-mips-2.4.21-20030725/arch/mips64/kernel/time.c
--- linux-mips-2.4.21-20030725.macro/arch/mips64/kernel/time.c	2003-07-31 21:27:18.000000000 +0000
+++ linux-mips-2.4.21-20030725/arch/mips64/kernel/time.c	2003-08-03 17:43:49.000000000 +0000
@@ -31,9 +31,14 @@
 #include <asm/hardirq.h>
 #include <asm/div64.h>
 
-/* This is for machines which generate the exact clock. */
-#define USECS_PER_JIFFY (1000000/HZ)
-#define USECS_PER_JIFFY_FRAC ((u32)((1000000ULL << 32) / HZ))
+/*
+ * The integer part of the number of usecs per jiffy is taken from tick,
+ * but the fractional part is not recorded, so we calculate it using the
+ * initial value of HZ.  This aids systems where tick isn't really an
+ * integer (e.g. for HZ = 128).
+ */
+#define USECS_PER_JIFFY		tick
+#define USECS_PER_JIFFY_FRAC	((unsigned long)(u32)((1000000ULL << 32) / HZ))
 
 /*
  * forward reference
@@ -48,6 +53,7 @@ spinlock_t rtc_lock = SPIN_LOCK_UNLOCKED
  */
 int emulate_local_timer_interrupt;
 
+
 /*
  * By default we provide the null RTC ops
  */
@@ -66,6 +72,84 @@ int (*rtc_set_time)(unsigned long) = nul
 int (*rtc_set_mmss)(unsigned long);
 
 
+/* usecs per counter cycle, shifted to left by 32 bits */
+static unsigned int sll32_usecs_per_cycle;
+
+/* how many counter cycles in a jiffy */
+static unsigned long cycles_per_jiffy;
+
+/* Cycle counter value at the previous timer interrupt.. */
+static unsigned int timerhi, timerlo;
+
+/* expirelo is the count value for next CPU timer interrupt */
+static unsigned int expirelo;
+
+
+/*
+ * Null timer ack for systems not needing one (e.g. i8254).
+ */
+static void null_timer_ack(void) { /* nothing */ }
+
+/*
+ * Null high precision timer functions for systems lacking one.
+ */
+static unsigned int null_hpt_read(void)
+{
+	return 0;
+}
+
+static void null_hpt_init(unsigned int count) { /* nothing */ }
+
+
+/*
+ * Timer ack for a R4k-compatible timer of a known frequency.
+ */
+static void c0_fixed_timer_ack(void)
+{
+	unsigned int count;
+
+	/* Ack this timer interrupt and set the next one.  */
+	expirelo += cycles_per_jiffy;
+	write_c0_compare(expirelo);
+
+	/* Check to see if we have missed any timer interrupts.  */
+	count = read_c0_count();
+	if ((count - expirelo) < 0x7fffffff) {
+		/* missed_timer_count++; */
+		expirelo = count + cycles_per_jiffy;
+		write_c0_compare(expirelo);
+	}
+}
+
+/*
+ * High precision timer functions for a R4k-compatible timer.
+ */
+static unsigned int c0_hpt_read(void)
+{
+	return read_c0_count();
+}
+
+/* For unknown frequency.  */
+static void c0_hpt_init(unsigned int count)
+{
+	write_c0_count(read_c0_count() - count);
+}
+
+/* For a known frequency.  Used as an interrupt source.  */
+static void c0_fixed_hpt_init(unsigned int count)
+{
+	expirelo = cycles_per_jiffy;
+	count = read_c0_count() - count;
+	write_c0_count(0);
+	write_c0_compare(cycles_per_jiffy);
+	write_c0_count(count);
+}
+
+void (*mips_timer_ack)(void);
+unsigned int (*mips_hpt_read)(void);
+void (*mips_hpt_init)(unsigned int);
+
+
 /*
  * timeofday services, for syscalls.
  */
@@ -128,42 +212,28 @@ void do_settimeofday(struct timeval *tv)
  * If the exact CPU counter frequency is known, use fixed_rate_gettimeoffset.
  * Otherwise use calibrate_gettimeoffset()
  *
- * If the CPU does not have counter register all, you can either supply
- * your own gettimeoffset() routine, or use null_gettimeoffset() routines,
- * which gives the same resolution as HZ.
+ * If the CPU does not have the counter register, you can either supply
+ * your own gettimeoffset() routine, or use null_gettimeoffset(), which
+ * gives the same resolution as HZ.
  */
 
-
-/* usecs per counter cycle, shifted to left by 32 bits */
-static unsigned int sll32_usecs_per_cycle;
-
-/* how many counter cycles in a jiffy */
-static unsigned long cycles_per_jiffy;
-
-/* Cycle counter value at the previous timer interrupt.. */
-static unsigned int timerhi, timerlo;
-
-/* expirelo is the count value for next CPU timer interrupt */
-static unsigned int expirelo;
-
-/* last time when xtime and rtc are sync'ed up */
-static long last_rtc_update;
-
-/* the function pointer to one of the gettimeoffset funcs*/
-unsigned long (*do_gettimeoffset)(void) = null_gettimeoffset;
-
 unsigned long null_gettimeoffset(void)
 {
 	return 0;
 }
 
-unsigned long fixed_rate_gettimeoffset(void)
+
+/* The function pointer to one of the gettimeoffset funcs.  */
+unsigned long (*do_gettimeoffset)(void) = null_gettimeoffset;
+
+
+static unsigned long fixed_rate_gettimeoffset(void)
 {
 	u32 count;
 	unsigned long res;
 
 	/* Get last timer tick in absolute kernel time */
-	count = read_c0_count();
+	count = mips_hpt_read();
 
 	/* .. relative to previous jiffy (32 bits is enough) */
 	count -= timerlo;
@@ -183,6 +253,7 @@ unsigned long fixed_rate_gettimeoffset(v
 	return res;
 }
 
+
 /*
  * Cached "1/(clocks per usec) * 2^32" value.
  * It has to be recalculated once each jiffy.
@@ -192,11 +263,10 @@ static unsigned long cached_quotient;
 /* Last jiffy when calibrate_divXX_gettimeoffset() was called. */
 static unsigned long last_jiffies;
 
-
 /*
- * This is copied from dec/time.c:do_ioasic_gettimeoffset() by Maciej.
+ * This is moved from dec/time.c:do_ioasic_gettimeoffset() by Maciej.
  */
-unsigned long calibrate_div32_gettimeoffset(void)
+static unsigned long calibrate_div32_gettimeoffset(void)
 {
 	u32 count;
 	unsigned long res, tmp;
@@ -218,7 +288,7 @@ unsigned long calibrate_div32_gettimeoff
 	}
 
 	/* Get last timer tick in absolute kernel time */
-	count = read_c0_count();
+	count = mips_hpt_read();
 
 	/* .. relative to previous jiffy (32 bits is enough) */
 	count -= timerlo;
@@ -238,7 +308,7 @@ unsigned long calibrate_div32_gettimeoff
 	return res;
 }
 
-unsigned long calibrate_div64_gettimeoffset(void)
+static unsigned long calibrate_div64_gettimeoffset(void)
 {
 	u32 count;
 	unsigned long res, tmp;
@@ -248,30 +318,33 @@ unsigned long calibrate_div64_gettimeoff
 
 	quotient = cached_quotient;
 
-	if (tmp && last_jiffies != tmp) {
+	if (last_jiffies != tmp) {
 		last_jiffies = tmp;
-		__asm__(".set	push\n\t"
-			".set	noreorder\n\t"
-			".set	noat\n\t"
-			".set	mips3\n\t"
-			"lwu	%0,%2\n\t"
-			"dsll32	$1,%1,0\n\t"
-			"or	$1,$1,%0\n\t"
-			"ddivu	$0,$1,%3\n\t"
-			"mflo	$1\n\t"
-			"dsll32	%0,%4,0\n\t"
-			"nop\n\t"
-			"ddivu	$0,%0,$1\n\t"
-			"mflo	%0\n\t"
-			".set	pop"
-			: "=&r" (quotient)
-			: "r" (timerhi), "m" (timerlo),
-			  "r" (tmp), "r" (USECS_PER_JIFFY));
-		cached_quotient = quotient;
+		if (last_jiffies) {
+			unsigned long r0;
+			__asm__(".set	push\n\t"
+				".set	mips3\n\t"
+				"lwu	%0,%3\n\t"
+				"dsll32	%1,%2,0\n\t"
+				"or	%1,%1,%0\n\t"
+				"ddivu	$0,%1,%4\n\t"
+				"mflo	%1\n\t"
+				"dsll32	%0,%5,0\n\t"
+				"or	%0,%0,%6\n\t"
+				"ddivu	$0,%0,%1\n\t"
+				"mflo	%0\n\t"
+				".set	pop"
+				: "=&r" (quotient), "=&r" (r0)
+				: "r" (timerhi), "m" (timerlo),
+				  "r" (tmp), "r" (USECS_PER_JIFFY),
+				  "r" (USECS_PER_JIFFY_FRAC)
+				: "hi", "lo", "accum");
+			cached_quotient = quotient;
+		}
 	}
 
 	/* Get last timer tick in absolute kernel time */
-	count = read_c0_count();
+	count = mips_hpt_read();
 
 	/* .. relative to previous jiffy (32 bits is enough) */
 	count -= timerlo;
@@ -292,6 +365,9 @@ unsigned long calibrate_div64_gettimeoff
 }
 
 
+/* last time when xtime and rtc are sync'ed up */
+static long last_rtc_update;
+
 /*
  * local_timer_interrupt() does profiling and process accounting
  * on a per-CPU basis.
@@ -329,30 +405,19 @@ void local_timer_interrupt(int irq, void
 }
 
 /*
- * high-level timer interrupt service routines.  This function
+ * High-level timer interrupt service routines.  This function
  * is set as irqaction->handler and is invoked through do_IRQ.
  */
 void timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
-	if (cpu_has_counter) {
-		unsigned int count;
+	unsigned int count;
 
-		/* ack timer interrupt, and try to set next interrupt */
-		expirelo += cycles_per_jiffy;
-		write_c0_compare(expirelo);
-		count = read_c0_count();
+	count = mips_hpt_read();
+	mips_timer_ack();
 
-		/* check to see if we have missed any timer interrupts */
-		if ((count - expirelo) < 0x7fffffff) {
-			/* missed_timer_count++; */
-			expirelo = count + cycles_per_jiffy;
-			write_c0_compare(expirelo);
-		}
-
-		/* Update timerhi/timerlo for intra-jiffy calibration. */
-		timerhi += count < timerlo;	/* Wrap around */
-		timerlo = count;
-	}
+	/* Update timerhi/timerlo for intra-jiffy calibration. */
+	timerhi += count < timerlo;			/* Wrap around */
+	timerlo = count;
 
 	/*
 	 * call the generic timer interrupt handling
@@ -379,12 +444,13 @@ void timer_interrupt(int irq, void *dev_
 	read_unlock(&xtime_lock);
 
 	/*
-	 * If jiffies has overflowed in this timer_interrupt we must
+	 * If jiffies has overflown in this timer_interrupt, we must
 	 * update the timer[hi]/[lo] to make fast gettimeoffset funcs
 	 * quotient calc still valid. -arca
 	 */
 	if (!jiffies) {
 		timerhi = timerlo = 0;
+		mips_hpt_init(count);
 	}
 
 #if !defined(CONFIG_SMP)
@@ -484,50 +550,70 @@ void __init time_init(void)
 	xtime.tv_sec = rtc_get_time();
 	xtime.tv_usec = 0;
 
-	/* choose appropriate gettimeoffset routine */
-	if (!cpu_has_counter) {
-		/* no cpu counter - sorry */
-		do_gettimeoffset = null_gettimeoffset;
-	} else if (mips_counter_frequency != 0) {
-		/* we have cpu counter and know counter frequency! */
-		do_gettimeoffset = fixed_rate_gettimeoffset;
-	} else if ((current_cpu_data.isa_level == MIPS_CPU_ISA_M32) ||
-		   (current_cpu_data.isa_level == MIPS_CPU_ISA_I) ||
-		   (current_cpu_data.isa_level == MIPS_CPU_ISA_II) ) {
-		/* we need to calibrate the counter but we don't have
-		 * 64-bit division. */
-		do_gettimeoffset = calibrate_div32_gettimeoffset;
+	/* Choose appropriate high precision timer routines.  */
+	if (!cpu_has_counter && !mips_hpt_read) {
+		/* No high precision timer -- sorry.  */
+		mips_hpt_read = null_hpt_read;
+		mips_hpt_init = null_hpt_init;
+	} else if (!mips_counter_frequency) {
+		/* A high precision timer of unknown frequency.  */
+		if (!mips_hpt_read) {
+			/* No external high precision timer -- use R4k.  */
+			mips_hpt_read = c0_hpt_read;
+			mips_hpt_init = c0_hpt_init;
+		}
+
+		if ((current_cpu_data.isa_level == MIPS_CPU_ISA_M32) ||
+			 (current_cpu_data.isa_level == MIPS_CPU_ISA_I) ||
+			 (current_cpu_data.isa_level == MIPS_CPU_ISA_II))
+			/*
+			 * We need to calibrate the counter but we don't have
+			 * 64-bit division.
+			 */
+			do_gettimeoffset = calibrate_div32_gettimeoffset;
+		else
+			/*
+			 * We need to calibrate the counter but we *do* have
+			 * 64-bit division.
+			 */
+			do_gettimeoffset = calibrate_div64_gettimeoffset;
 	} else {
-		/* we need to calibrate the counter but we *do* have
-		 * 64-bit division. */
-		do_gettimeoffset = calibrate_div64_gettimeoffset;
-	}
+		/* We know counter frequency! */
+		if (!mips_hpt_read) {
+			/* No external high precision timer -- use R4k.  */
+			mips_hpt_read = c0_hpt_read;
+			mips_hpt_init = c0_fixed_hpt_init;
+
+			if (!mips_timer_ack)
+				/* R4k timer interrupt ack.  */
+				mips_timer_ack = c0_fixed_timer_ack;
+		}
 
-	/* caclulate cache parameters */
-	if (mips_counter_frequency) {
+		do_gettimeoffset = fixed_rate_gettimeoffset;
+
+		/* Calculate cache parameters.  */
 		cycles_per_jiffy = mips_counter_frequency / HZ;
 
-		/* sll32_usecs_per_cycle = 10^6 * 2^32 / mips_counter_freq */
-		/* any better way to do this? */
+		/* sll32_usecs_per_cycle = 10^6 * 2^32 / mips_counter_freq  */
+		/* Any better way to do this?  */
 		sll32_usecs_per_cycle = mips_counter_frequency / 100000;
 		sll32_usecs_per_cycle = 0xffffffff / sll32_usecs_per_cycle;
 		sll32_usecs_per_cycle *= 10;
-
-		/*
-		 * For those using cpu counter as timer,  this sets up the
-		 * first interrupt
-		 */
-		write_c0_compare(cycles_per_jiffy);
-		write_c0_count(0);
-		expirelo = cycles_per_jiffy;
 	}
 
+	if (!mips_timer_ack)
+		/* No timer interrupt ack (e.g. i8254).  */
+		mips_timer_ack = null_timer_ack;
+
+	/* This sets up the high precision timer for the first interrupt.  */
+	mips_hpt_init(mips_hpt_read());
+
 	/*
 	 * Call board specific timer interrupt setup.
 	 *
 	 * this pointer must be setup in machine setup routine.
 	 *
-	 * Even if the machine choose to use low-level timer interrupt,
+	 * Even if a machine chooses to use a low-level timer interrupt,
 	 * it still needs to setup the timer_irqaction.
 	 * In that case, it might be better to set timer_irqaction.handler
 	 * to be NULL function so that we are sure the high-level code
diff -up --recursive --new-file linux-mips-2.4.21-20030725.macro/include/asm-mips/time.h linux-mips-2.4.21-20030725/include/asm-mips/time.h
--- linux-mips-2.4.21-20030725.macro/include/asm-mips/time.h	2003-07-25 23:07:42.000000000 +0000
+++ linux-mips-2.4.21-20030725/include/asm-mips/time.h	2003-08-03 17:47:55.000000000 +0000
@@ -36,6 +36,19 @@ extern int (*rtc_set_time)(unsigned long
 extern int (*rtc_set_mmss)(unsigned long);
 
 /*
+ * Timer interrupt ack function.
+ * May be NULL if the interrupt is self-recoverable.
+ */
+extern void (*mips_timer_ack)(void);
+
+/*
+ * High precision timer functions.
+ * If mips_hpt_read is NULL, an R4k-compatible timer setup is attempted.
+ */
+extern unsigned int (*mips_hpt_read)(void);
+extern void (*mips_hpt_init)(unsigned int);
+
+/*
  * to_tm() converts system time back to (year, mon, day, hour, min, sec).
  * It is intended to help implement rtc_set_time() functions.
  * Copied from PPC implementation.
@@ -49,11 +62,6 @@ extern void to_tm(unsigned long tim, str
  */
 extern unsigned long (*do_gettimeoffset)(void);
 
-extern unsigned long null_gettimeoffset(void);
-extern unsigned long fixed_rate_gettimeoffset(void);
-extern unsigned long calibrate_div32_gettimeoffset(void);
-extern unsigned long calibrate_div64_gettimeoffset(void);
-
 /*
  * high-level timer interrupt routines.
  */
diff -up --recursive --new-file linux-mips-2.4.21-20030725.macro/include/asm-mips64/time.h linux-mips-2.4.21-20030725/include/asm-mips64/time.h
--- linux-mips-2.4.21-20030725.macro/include/asm-mips64/time.h	2003-07-25 02:57:09.000000000 +0000
+++ linux-mips-2.4.21-20030725/include/asm-mips64/time.h	2003-08-03 17:47:55.000000000 +0000
@@ -36,6 +36,19 @@ extern int (*rtc_set_time)(unsigned long
 extern int (*rtc_set_mmss)(unsigned long);
 
 /*
+ * Timer interrupt ack function.
+ * May be NULL if the interrupt is self-recoverable.
+ */
+extern void (*mips_timer_ack)(void);
+
+/*
+ * High precision timer functions.
+ * If mips_hpt_read is NULL, an R4k-compatible timer setup is attempted.
+ */
+extern unsigned int (*mips_hpt_read)(void);
+extern void (*mips_hpt_init)(unsigned int);
+
+/*
  * to_tm() converts system time back to (year, mon, day, hour, min, sec).
  * It is intended to help implement rtc_set_time() functions.
  * Copied from PPC implementation.
@@ -49,11 +62,6 @@ extern void to_tm(unsigned long tim, str
  */
 extern unsigned long (*do_gettimeoffset)(void);
 
-extern unsigned long null_gettimeoffset(void);
-extern unsigned long fixed_rate_gettimeoffset(void);
-extern unsigned long calibrate_div32_gettimeoffset(void);
-extern unsigned long calibrate_div64_gettimeoffset(void);
-
 /*
  * high-level timer interrupt routines.
  */
