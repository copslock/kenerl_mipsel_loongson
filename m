Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Aug 2003 12:31:46 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:46777 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225209AbTHNLbn>; Thu, 14 Aug 2003 12:31:43 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA15064;
	Thu, 14 Aug 2003 13:31:31 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Thu, 14 Aug 2003 13:31:31 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [patch] Generic time trailing clean-ups
In-Reply-To: <20030813094541.B9655@mvista.com>
Message-ID: <Pine.GSO.3.96.1030814121949.14241A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3048
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 13 Aug 2003, Jun Sun wrote:

> >  That's good enough as a temporary hack, but not as a final solution.  I
> > think we need to do the calibration similarly to how calibrate_tsc() or
> > calibrate_APIC_clock() do that for the i386.  Specifically, we need to do
> > that with polling for appropriate accuracy (interrupt delivery time might
> > not be deterministic) and preferably before interrupts are enabled
> > (time_init() looks like a perfect place to do that).  And of course we
> > need to poll against the interrupt source as it's the frequency ratio that
> > matters (otherwise I could e.g. just read the TURBOchannel clock frequency
> > as reported by the firmware for the HPT on R3k DECstations).  That means
> > it needs to be done in platform-specific way.
> 
> I don't like this idea.  This is way too much over-doing for little gain.

 Well, others are doing it this way.  And for a reason. 

> When counter frequency is calibrated, the system is just starting.  The interrupt
> delivery time is rather deterministic. 

 Do you know all the interrupt controllers out there?  Cool.  But I don't,
and I am a wimp.  And I know e.g. the i386 has the message-driven APIC
which uses a relatively slow serial bus to transmit interrupt events to
processors.  And the delivery latency varies, depending on the arbitration
time, traffic on the bus, noise causing interrupt retransmits, etc. 
Search the LKML archive for recurring discussions about interrupt
latencies. 

> Then you also need to put into perspective of its usage in gettimeoffset.
> We are talking about micro-second resolution.  calibration obtained this way
> is accurate enough.

 Nanosecond for the 2.6 upwards.  And you don't want to have time
"freezes" (i.e. consecutive gettimeofday() calls returning the same value)
due to an overflow at the end of a jiffy, do you?

 Anyway, your change affects the core.  Have you tried submitting it to
Linus?  Or discussing at the LKML?  Interesting ideas might arise.

> Over-abstraction is very bad for OS.  We need to recognize that danger.

 Code duplication is yet worse.  This is the price paid for being
multiplatform within a single processor's architecture.  Compare that to
the i386 vs the PC/AT platform, although even that is changing these days.
And the Alpha at the other end, which uses platform specific vectors for
backends, even though Alphas don't differ as much as MIPS systems.

> In addition, this change expands MIPS common and board interface and increases
> board-layer porting work.

 What work?  It took me two minutes to add support for the DECstation for
the new interface.  That wasn't a big deal for me, even though whatever
I'm doing here, I am using my precious free time.  Compare it to various
changes say in drivers APIs happening every now and then.  But such is
Linux -- if something sucks and a better replacement is needed, it's done.

> >  I have an idea how to make an abstraction layer for this purpose and I'll
> > make a patch for the DECstation soon.  The plan might be as follows: 
> > 
> > 1. I'll apply the patch as is (Ralf has already approved it off-list) as
> > the calibrate_*() backends won't disappear immediately anyway. 
> 
> If you take the above view, the obvious action is to apply the 
> calibration patch and get rid of all various calibrate_* routines.

 That is the plan -- see the following points.  But 2.4 is too deep in the
maintenance stage to require all platforms to be updated.  Some are still
using private copies of time handlers!  But we can actually backport code
removal from 2.7 to later 2.6 if platforms get updated as appropriate.

> Of course, future improvement is still possible even with doing this.  For example,
> one interesting item is to calibrate and sync counters on a SMP system.

 Feel free to do this.  It shouldn't be that tough -- the i386 already
does that.  I don't have a SMP system to give me much enough incentive.

> > 2. I'll provide the abstraction layer together with an example
> > implementation for the DECstation.
> > 
> > 3. For 2.6 I'll add a warning about uninitialized mips_counter_frequency
> > and deprecation of calibrate_*() backends, so that platform maintainers
> > know what's going on.
> > 
> > 4. After 2.7 starts code related to calibrate_*() will be removed and the
> > kernel will panic() if a HPT is found, but mips_counter_frequency is zero.
> > 
> > Any comments?
> 
> That is my two cents.  
> 
> BTW, I am drafting a proposal to use a native high resolution clock/timer
> interface for 2.7 kernel, with jiffie timer emulated on top of it.  If adopted, 
> that will change the whole picture obviously.  But that is too far to be
> a real factor here.  The only implication to MIPS is probably that we should 
> encourage people to use CPU counter as the system timer as much as possible.
> This will increase maximum code sharing and is future-proof.

 I disagree -- the CPU counter should be used for the timer interrupt as
the last resort.  We might think of using it for scheduling purposes,
though (possibly with a different offset for each processor), and using an
external timer for timekeeping only.  This would give a cleaner handling
of timer events on SMP systems.  But I'm looking forward to seeing your
code when you have examples ready -- we can study the issues then (but
please keep in mind what the other ports or the core do in this matter).

 Here is my proposed patch.  It seems to work just fine both on an R3k
using a 25MHz external HPT and on an R4k using its internal HPT at 60MHz.
It lets all systems that have an external timer use the generic time code
by providing up to four backends (depending on the configuration),
typically quite trivial.  These systems that have no external timer at all
and need to rely on the R4k-style counter for timer interrupts, still need
to get its frequency from elsewhere (from the firmware, by hardcoding it,
etc.).  Once they do that, they can use the generic time code as well.

 OK to apply?  I'll update Documentation/mips/time.README when the dust
settles down.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.21-20030811-mips-hpt-calibrate-3
diff -up --recursive --new-file linux-mips-2.4.21-20030811.macro/arch/mips/au1000/common/time.c linux-mips-2.4.21-20030811/arch/mips/au1000/common/time.c
--- linux-mips-2.4.21-20030811.macro/arch/mips/au1000/common/time.c	2003-03-26 03:56:33.000000000 +0000
+++ linux-mips-2.4.21-20030811/arch/mips/au1000/common/time.c	2003-08-14 00:07:58.000000000 +0000
@@ -52,7 +52,7 @@ unsigned long missed_heart_beats = 0;
 static unsigned long r4k_offset; /* Amount to increment compare reg each time */
 static unsigned long r4k_cur;    /* What counter should be at next timer irq */
 extern rwlock_t xtime_lock;
-unsigned int mips_counter_frequency = 0;
+unsigned int mips_hpt_frequency = 0;
 
 /* Cycle counter value at the previous timer interrupt.. */
 static unsigned int timerhi = 0, timerlo = 0;
@@ -202,7 +202,7 @@ unsigned long cal_r4koff(void)
 
 	count = read_c0_count();
 	cpu_speed = count * 2;
-	mips_counter_frequency = count;
+	mips_hpt_frequency = count;
 	set_au1x00_uart_baud_base(((cpu_speed) / 4) / 16);
 	spin_unlock_irqrestore(&time_lock, flags);
 	return (cpu_speed / HZ);
diff -up --recursive --new-file linux-mips-2.4.21-20030811.macro/arch/mips/ddb5xxx/ddb5476/setup.c linux-mips-2.4.21-20030811/arch/mips/ddb5xxx/ddb5476/setup.c
--- linux-mips-2.4.21-20030811.macro/arch/mips/ddb5xxx/ddb5476/setup.c	2003-04-15 02:56:51.000000000 +0000
+++ linux-mips-2.4.21-20030811/arch/mips/ddb5xxx/ddb5476/setup.c	2003-08-14 00:08:20.000000000 +0000
@@ -84,7 +84,7 @@ extern void rtc_ds1386_init(unsigned lon
 static void __init ddb_time_init(void)
 {
 #if defined(USE_CPU_COUNTER_TIMER)
-	mips_counter_frequency = CPU_COUNTER_FREQUENCY;
+	mips_hpt_frequency = CPU_COUNTER_FREQUENCY;
 #endif
 
 	/* we have ds1396 RTC chip */
diff -up --recursive --new-file linux-mips-2.4.21-20030811.macro/arch/mips/ddb5xxx/ddb5477/setup.c linux-mips-2.4.21-20030811/arch/mips/ddb5xxx/ddb5477/setup.c
--- linux-mips-2.4.21-20030811.macro/arch/mips/ddb5xxx/ddb5477/setup.c	2003-04-18 02:56:37.000000000 +0000
+++ linux-mips-2.4.21-20030811/arch/mips/ddb5xxx/ddb5477/setup.c	2003-08-14 00:08:50.000000000 +0000
@@ -138,11 +138,11 @@ static void __init ddb_time_init(void)
 		bus_frequency = detect_bus_frequency(rtc_base);
 	}
 
-	/* mips_counter_frequency is 1/2 of the cpu core freq */
+	/* mips_hpt_frequency is 1/2 of the cpu core freq */
 	i =  (read_c0_config() >> 28 ) & 7;
 	if ((current_cpu_data.cputype == CPU_R5432) && (i == 3))
 		i = 4;
-	mips_counter_frequency = bus_frequency*(i+4)/4;
+	mips_hpt_frequency = bus_frequency*(i+4)/4;
 }
 
 extern int setup_irq(unsigned int irq, struct irqaction *irqaction);
diff -up --recursive --new-file linux-mips-2.4.21-20030811.macro/arch/mips/dec/time.c linux-mips-2.4.21-20030811/arch/mips/dec/time.c
--- linux-mips-2.4.21-20030811.macro/arch/mips/dec/time.c	2003-08-06 02:56:27.000000000 +0000
+++ linux-mips-2.4.21-20030811/arch/mips/dec/time.c	2003-08-13 23:52:44.000000000 +0000
@@ -144,6 +144,11 @@ static int dec_rtc_set_mmss(unsigned lon
 }
 
 
+static int dec_timer_state(void)
+{
+	return (CMOS_READ(RTC_REG_C) & RTC_PF) != 0;
+}
+
 static void dec_timer_ack(void)
 {
 	CMOS_READ(RTC_REG_C);			/* Ack the RTC interrupt.  */
@@ -169,19 +174,23 @@ void __init dec_time_init(void)
 	rtc_get_time = dec_rtc_get_time;
 	rtc_set_mmss = dec_rtc_set_mmss;
 
+	mips_timer_state = dec_timer_state;
 	mips_timer_ack = dec_timer_ack;
+
 	if (!cpu_has_counter && IOASIC) {
 		/* For pre-R4k systems we use the I/O ASIC's counter.  */
 		mips_hpt_read = dec_ioasic_hpt_read;
 		mips_hpt_init = dec_ioasic_hpt_init;
 	}
+
+	/* Set up the rate of periodic DS1287 interrupts.  */
+	CMOS_WRITE(RTC_REF_CLCK_32KHZ | (16 - LOG_2_HZ), RTC_REG_A);
 }
 
 void __init dec_timer_setup(struct irqaction *irq)
 {
+	setup_irq(dec_interrupt[DEC_IRQ_RTC], irq);
+
 	/* Enable periodic DS1287 interrupts.  */
-	CMOS_WRITE(RTC_REF_CLCK_32KHZ | (16 - LOG_2_HZ), RTC_REG_A);
 	CMOS_WRITE(CMOS_READ(RTC_REG_B) | RTC_PIE, RTC_REG_B);
-
-	setup_irq(dec_interrupt[DEC_IRQ_RTC], irq);
 }
diff -up --recursive --new-file linux-mips-2.4.21-20030811.macro/arch/mips/ite-boards/generic/time.c linux-mips-2.4.21-20030811/arch/mips/ite-boards/generic/time.c
--- linux-mips-2.4.21-20030811.macro/arch/mips/ite-boards/generic/time.c	2003-04-26 02:56:37.000000000 +0000
+++ linux-mips-2.4.21-20030811/arch/mips/ite-boards/generic/time.c	2003-08-14 00:09:30.000000000 +0000
@@ -114,7 +114,7 @@ hour_hw_to_bin(unsigned char c)
 
 static unsigned long r4k_offset; /* Amount to increment compare reg each time */
 static unsigned long r4k_cur;    /* What counter should be at next timer irq */
-extern unsigned int mips_counter_frequency;
+extern unsigned int mips_hpt_frequency;
 
 /*
  * Figure out the r4k offset, the amount to increment the compare
@@ -138,12 +138,12 @@ static unsigned long __init cal_r4koff(v
 	while (CMOS_READ(RTC_REG_A) & RTC_UIP);
 	while (!(CMOS_READ(RTC_REG_A) & RTC_UIP));
 
-	mips_counter_frequency = read_c0_count();
+	mips_hpt_frequency = read_c0_count();
 
 	/* restore interrupts */
 	local_irq_restore(flags);
 
-	return (mips_counter_frequency / HZ);
+	return (mips_hpt_frequency / HZ);
 }
 
 static unsigned long 
diff -up --recursive --new-file linux-mips-2.4.21-20030811.macro/arch/mips/kernel/time.c linux-mips-2.4.21-20030811/arch/mips/kernel/time.c
--- linux-mips-2.4.21-20030811.macro/arch/mips/kernel/time.c	2003-08-11 20:57:07.000000000 +0000
+++ linux-mips-2.4.21-20030811/arch/mips/kernel/time.c	2003-08-14 01:57:43.000000000 +0000
@@ -102,9 +102,9 @@ static void null_hpt_init(unsigned int c
 
 
 /*
- * Timer ack for a R4k-compatible timer of a known frequency.
+ * Timer ack for an R4k-compatible timer of a known frequency.
  */
-static void c0_fixed_timer_ack(void)
+static void c0_timer_ack(void)
 {
 	unsigned int count;
 
@@ -129,14 +129,14 @@ static unsigned int c0_hpt_read(void)
 	return read_c0_count();
 }
 
-/* For unknown frequency.  */
+/* For use solely as a high precision timer.  */
 static void c0_hpt_init(unsigned int count)
 {
 	write_c0_count(read_c0_count() - count);
 }
 
-/* For a known frequency.  Used as an interrupt source.  */
-static void c0_fixed_hpt_init(unsigned int count)
+/* For use both as a high precision timer and an interrupt source.  */
+static void c0_hpt_timer_init(unsigned int count)
 {
 	count = read_c0_count() - count;
 	expirelo = (count / cycles_per_jiffy + 1) * cycles_per_jiffy;
@@ -145,6 +145,7 @@ static void c0_fixed_hpt_init(unsigned i
 	write_c0_count(count);
 }
 
+int (*mips_timer_state)(void);
 void (*mips_timer_ack)(void);
 unsigned int (*mips_hpt_read)(void);
 void (*mips_hpt_init)(unsigned int);
@@ -548,7 +549,7 @@ asmlinkage void ll_local_timer_interrupt
  *
  * 1) board_time_init() -
  * 	a) (optional) set up RTC routines,
- *      b) (optional) calibrate and set the mips_counter_frequency
+ *      b) (optional) calibrate and set the mips_hpt_frequency
  *	    (only needed if you intended to use fixed_rate_gettimeoffset
  *	     or use cpu counter as timer interrupt source)
  * 2) setup xtime based on rtc_get_time().
@@ -563,7 +564,7 @@ asmlinkage void ll_local_timer_interrupt
 void (*board_time_init)(void);
 void (*board_timer_setup)(struct irqaction *irq);
 
-unsigned int mips_counter_frequency;
+unsigned int mips_hpt_frequency;
 
 static struct irqaction timer_irqaction = {
 	.handler = timer_interrupt,
@@ -571,6 +572,49 @@ static struct irqaction timer_irqaction 
 	.name = "timer",
 };
 
+static unsigned int __init calibrate_hpt(void)
+{
+	u64 frequency;
+	u32 hpt_start, hpt_end, hpt_count, hz;
+
+	const int loops = HZ / 10;
+	int log_2_loops = 0;
+	int i;
+
+	/*
+	 * We want to calibrate for 0.1s, but to avoid a 64-bit
+	 * division we round the number of loops up to the nearest
+	 * power of 2.
+	 */
+	while (loops > 1 << log_2_loops)
+		log_2_loops++;
+	i = 1 << log_2_loops;
+
+	/*
+	 * Wait for a rising edge of the timer interrupt.
+	 */
+	while (mips_timer_state());
+	while (!mips_timer_state());
+
+	/*
+	 * Now see how many high precision timer ticks happen
+	 * during the calculated number of periods between timer
+	 * interrupts.
+	 */
+	hpt_start = mips_hpt_read();
+	do {
+		while (mips_timer_state());
+		while (!mips_timer_state());
+	} while (--i);
+	hpt_end = mips_hpt_read();
+
+	hpt_count = hpt_end - hpt_start;
+	hz = HZ;
+	frequency = (u64)hpt_count * (u64)hz;
+
+	return frequency >> log_2_loops;
+}
+
 void __init time_init(void)
 {
 	if (board_time_init)
@@ -587,7 +631,7 @@ void __init time_init(void)
 		/* No high precision timer -- sorry.  */
 		mips_hpt_read = null_hpt_read;
 		mips_hpt_init = null_hpt_init;
-	} else if (!mips_counter_frequency) {
+	} else if (!mips_hpt_frequency && !mips_timer_state) {
 		/* A high precision timer of unknown frequency.  */
 		if (!mips_hpt_read) {
 			/* No external high precision timer -- use R4k.  */
@@ -610,27 +654,36 @@ void __init time_init(void)
 			 */
 			do_gettimeoffset = calibrate_div64_gettimeoffset;
 	} else {
-		/* We know counter frequency! */
+		/* We know counter frequency.  Or we can get it.  */
 		if (!mips_hpt_read) {
 			/* No external high precision timer -- use R4k.  */
 			mips_hpt_read = c0_hpt_read;
-			mips_hpt_init = c0_fixed_hpt_init;
 
-			if (!mips_timer_ack)
-				/* R4k timer interrupt ack.  */
-				mips_timer_ack = c0_fixed_timer_ack;
+			if (mips_timer_state)
+				mips_hpt_init = c0_hpt_init;
+			else {
+				/* No external timer interrupt -- use R4k.  */
+				mips_hpt_init = c0_hpt_timer_init;
+				mips_timer_ack = c0_timer_ack;
+			}
 		}
+		if (!mips_hpt_frequency)
+			mips_hpt_frequency = calibrate_hpt();
 
 		do_gettimeoffset = fixed_rate_gettimeoffset;
 
 		/* Calculate cache parameters.  */
-		cycles_per_jiffy = mips_counter_frequency / HZ;
+		cycles_per_jiffy = (mips_hpt_frequency + HZ / 2) / HZ;
 
 		/* sll32_usecs_per_cycle = 10^6 * 2^32 / mips_counter_freq  */
-		/* Any better way to do this?  */
-		sll32_usecs_per_cycle = mips_counter_frequency / 100000;
-		sll32_usecs_per_cycle = 0xffffffff / sll32_usecs_per_cycle;
-		sll32_usecs_per_cycle *= 10;
+		do_div64_32(sll32_usecs_per_cycle,
+			    1000000, mips_hpt_frequency / 2,
+			    mips_hpt_frequency);
+
+		/* Report the high precision timer rate for a reference.  */
+		printk("Using %u.%03u MHz high precision timer.\n",
+		       ((mips_hpt_frequency + 500) / 1000) / 1000,
+		       ((mips_hpt_frequency + 500) / 1000) % 1000);
 	}
 
 	if (!mips_timer_ack)
diff -up --recursive --new-file linux-mips-2.4.21-20030811.macro/arch/mips/lasat/setup.c linux-mips-2.4.21-20030811/arch/mips/lasat/setup.c
--- linux-mips-2.4.21-20030811.macro/arch/mips/lasat/setup.c	2003-04-15 02:56:53.000000000 +0000
+++ linux-mips-2.4.21-20030811/arch/mips/lasat/setup.c	2003-08-14 00:09:41.000000000 +0000
@@ -138,7 +138,7 @@ static ide_ioreg_t lasat_ide_default_io_
 
 static void lasat_time_init(void)
 {
-	mips_counter_frequency = lasat_board_info.li_cpu_hz / 2;
+	mips_hpt_frequency = lasat_board_info.li_cpu_hz / 2;
 }
 
 static void lasat_timer_setup(struct irqaction *irq)
@@ -146,7 +146,7 @@ static void lasat_timer_setup(struct irq
 
 	write_c0_compare(
 		read_c0_count() + 
-		mips_counter_frequency / HZ);
+		mips_hpt_frequency / HZ);
 	change_c0_status(ST0_IM, IE_IRQ0 | IE_IRQ5);
 }
 
diff -up --recursive --new-file linux-mips-2.4.21-20030811.macro/arch/mips/mips-boards/generic/time.c linux-mips-2.4.21-20030811/arch/mips/mips-boards/generic/time.c
--- linux-mips-2.4.21-20030811.macro/arch/mips/mips-boards/generic/time.c	2003-03-26 03:56:35.000000000 +0000
+++ linux-mips-2.4.21-20030811/arch/mips/mips-boards/generic/time.c	2003-08-14 00:09:58.000000000 +0000
@@ -102,12 +102,12 @@ static unsigned int __init cal_r4koff(vo
 	while (CMOS_READ(RTC_REG_A) & RTC_UIP);
 	while (!(CMOS_READ(RTC_REG_A) & RTC_UIP));
 
-	mips_counter_frequency = read_c0_count();
+	mips_hpt_frequency = read_c0_count();
 
 	/* restore interrupts */
 	local_irq_restore(flags);
 
-	return (mips_counter_frequency / HZ);
+	return (mips_hpt_frequency / HZ);
 }
 
 unsigned long __init mips_rtc_get_time(void)
diff -up --recursive --new-file linux-mips-2.4.21-20030811.macro/arch/mips/momentum/ocelot_c/setup.c linux-mips-2.4.21-20030811/arch/mips/momentum/ocelot_c/setup.c
--- linux-mips-2.4.21-20030811.macro/arch/mips/momentum/ocelot_c/setup.c	2003-04-15 02:56:54.000000000 +0000
+++ linux-mips-2.4.21-20030811/arch/mips/momentum/ocelot_c/setup.c	2003-08-14 00:10:08.000000000 +0000
@@ -183,9 +183,9 @@ void momenco_timer_setup(struct irqactio
 void momenco_time_init(void)
 {
 #ifdef CONFIG_CPU_SR71000
-	mips_counter_frequency = cpu_clock;
+	mips_hpt_frequency = cpu_clock;
 #elif defined(CONFIG_CPU_RM7000)
-	mips_counter_frequency = cpu_clock / 2;
+	mips_hpt_frequency = cpu_clock / 2;
 #else
 #error Unknown CPU for this board
 #endif
diff -up --recursive --new-file linux-mips-2.4.21-20030811.macro/arch/mips/sgi-ip22/ip22-time.c linux-mips-2.4.21-20030811/arch/mips/sgi-ip22/ip22-time.c
--- linux-mips-2.4.21-20030811.macro/arch/mips/sgi-ip22/ip22-time.c	2003-07-13 02:56:38.000000000 +0000
+++ linux-mips-2.4.21-20030811/arch/mips/sgi-ip22/ip22-time.c	2003-08-14 00:10:20.000000000 +0000
@@ -177,7 +177,7 @@ void indy_time_init(void)
 		(int) (r4k_tick / (500000 / HZ)),
 		(int) (r4k_tick % (500000 / HZ)));
 
-	mips_counter_frequency = r4k_tick * HZ;
+	mips_hpt_frequency = r4k_tick * HZ;
 }
 
 /* Generic SGI handler for (spurious) 8254 interrupts */
diff -up --recursive --new-file linux-mips-2.4.21-20030811.macro/arch/mips/tx4927/common/tx4927_setup.c linux-mips-2.4.21-20030811/arch/mips/tx4927/common/tx4927_setup.c
--- linux-mips-2.4.21-20030811.macro/arch/mips/tx4927/common/tx4927_setup.c	2003-04-11 17:26:20.000000000 +0000
+++ linux-mips-2.4.21-20030811/arch/mips/tx4927/common/tx4927_setup.c	2003-08-14 00:10:32.000000000 +0000
@@ -120,7 +120,7 @@ void __init tx4927_timer_setup(struct ir
 
 	/* to generate the first timer interrupt */
 	c1 = read_c0_count();
-	count = c1 + (mips_counter_frequency / HZ);
+	count = c1 + (mips_hpt_frequency / HZ);
 	write_c0_compare(count);
 	c2 = read_c0_count();
 
diff -up --recursive --new-file linux-mips-2.4.21-20030811.macro/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c linux-mips-2.4.21-20030811/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
--- linux-mips-2.4.21-20030811.macro/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c	2003-07-16 02:56:43.000000000 +0000
+++ linux-mips-2.4.21-20030811/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c	2003-08-14 00:10:52.000000000 +0000
@@ -1168,7 +1168,7 @@ toshiba_rbtx4927_time_init(void)
 				       ":rtc_ds1742_init()+\n");
 
 	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_TIME_INIT,
-				       ":Calibrate mips_counter_frequency-\n");
+				       ":Calibrate mips_hpt_frequency-\n");
 	rtc_ds1742_wait();
 
 	/* get the count */
@@ -1181,29 +1181,29 @@ toshiba_rbtx4927_time_init(void)
 	c2 = read_c0_count();
 
 	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_TIME_INIT,
-				       ":Calibrate mips_counter_frequency+\n");
+				       ":Calibrate mips_hpt_frequency+\n");
 	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_TIME_INIT,
 				       ":c1=%12u\n", c1);
 	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_TIME_INIT,
 				       ":c2=%12u\n", c2);
 
 	/* this diff is as close as we are going to get to counter ticks per sec */
-	mips_counter_frequency = abs(c2 - c1);
+	mips_hpt_frequency = abs(c2 - c1);
 	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_TIME_INIT,
-				       ":f1=%12u\n", mips_counter_frequency);
+				       ":f1=%12u\n", mips_hpt_frequency);
 
 	/* round to 1/10th of a MHz */
-	mips_counter_frequency /= (100 * 1000);
-	mips_counter_frequency *= (100 * 1000);
+	mips_hpt_frequency /= (100 * 1000);
+	mips_hpt_frequency *= (100 * 1000);
 	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_TIME_INIT,
-				       ":f2=%12u\n", mips_counter_frequency);
+				       ":f2=%12u\n", mips_hpt_frequency);
 
 	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_INFO,
-				       ":mips_counter_frequency=%uHz (%uMHz)\n",
-				       mips_counter_frequency,
-				       mips_counter_frequency / 1000000);
+				       ":mips_hpt_frequency=%uHz (%uMHz)\n",
+				       mips_hpt_frequency,
+				       mips_hpt_frequency / 1000000);
 #else
-	mips_counter_frequency = 100000000;
+	mips_hpt_frequency = 100000000;
 #endif
 
 	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_TIME_INIT, "+\n");
diff -up --recursive --new-file linux-mips-2.4.21-20030811.macro/arch/mips/vr41xx/common/bcu.c linux-mips-2.4.21-20030811/arch/mips/vr41xx/common/bcu.c
--- linux-mips-2.4.21-20030811.macro/arch/mips/vr41xx/common/bcu.c	2003-04-07 02:56:30.000000000 +0000
+++ linux-mips-2.4.21-20030811/arch/mips/vr41xx/common/bcu.c	2003-08-14 00:11:13.000000000 +0000
@@ -36,7 +36,7 @@
  *  - Added support for NEC VR4111 and VR4121.
  *
  *  Paul Mundt <lethal@chaoticdreams.org>
- *  - Calculate mips_counter_frequency properly on VR4131.
+ *  - Calculate mips_hpt_frequency properly on VR4131.
  *
  *  MontaVista Software Inc. <yyuasa@mvista.com> or <source@mvista.com>
  *  - New creation, NEC VR4122 and VR4131 are supported.
@@ -177,7 +177,7 @@ static inline unsigned long calculate_tc
 	return tclock;
 }
 
-static inline unsigned long calculate_mips_counter_frequency(unsigned long tclock)
+static inline unsigned long calculate_mips_hpt_frequency(unsigned long tclock)
 {
 	/*
 	 * VR4131 Revision 2.0 and 2.1 use a value of (tclock / 2).
@@ -202,5 +202,5 @@ void __init vr41xx_bcu_init(void)
 	vtclock = calculate_vtclock(clkspeed, pclock);
 	tclock = calculate_tclock(clkspeed, pclock, vtclock);
 
-	mips_counter_frequency = calculate_mips_counter_frequency(tclock);
+	mips_hpt_frequency = calculate_mips_hpt_frequency(tclock);
 }
diff -up --recursive --new-file linux-mips-2.4.21-20030811.macro/arch/mips/vr41xx/common/time.c linux-mips-2.4.21-20030811/arch/mips/vr41xx/common/time.c
--- linux-mips-2.4.21-20030811.macro/arch/mips/vr41xx/common/time.c	2003-04-07 02:56:30.000000000 +0000
+++ linux-mips-2.4.21-20030811/arch/mips/vr41xx/common/time.c	2003-08-14 00:11:23.000000000 +0000
@@ -89,5 +89,5 @@ void vr41xx_timer_setup(struct irqaction
 	setup_irq(MIPS_COUNTER_IRQ, irq);
 
 	count = read_c0_count();
-	write_c0_compare(count + (mips_counter_frequency / HZ));
+	write_c0_compare(count + (mips_hpt_frequency / HZ));
 }
diff -up --recursive --new-file linux-mips-2.4.21-20030811.macro/arch/mips64/kernel/time.c linux-mips-2.4.21-20030811/arch/mips64/kernel/time.c
--- linux-mips-2.4.21-20030811.macro/arch/mips64/kernel/time.c	2003-08-11 20:57:17.000000000 +0000
+++ linux-mips-2.4.21-20030811/arch/mips64/kernel/time.c	2003-08-14 01:57:43.000000000 +0000
@@ -102,9 +102,9 @@ static void null_hpt_init(unsigned int c
 
 
 /*
- * Timer ack for a R4k-compatible timer of a known frequency.
+ * Timer ack for an R4k-compatible timer of a known frequency.
  */
-static void c0_fixed_timer_ack(void)
+static void c0_timer_ack(void)
 {
 	unsigned int count;
 
@@ -129,14 +129,14 @@ static unsigned int c0_hpt_read(void)
 	return read_c0_count();
 }
 
-/* For unknown frequency.  */
+/* For use solely as a high precision timer.  */
 static void c0_hpt_init(unsigned int count)
 {
 	write_c0_count(read_c0_count() - count);
 }
 
-/* For a known frequency.  Used as an interrupt source.  */
-static void c0_fixed_hpt_init(unsigned int count)
+/* For use both as a high precision timer and an interrupt source.  */
+static void c0_hpt_timer_init(unsigned int count)
 {
 	count = read_c0_count() - count;
 	expirelo = (count / cycles_per_jiffy + 1) * cycles_per_jiffy;
@@ -145,6 +145,7 @@ static void c0_fixed_hpt_init(unsigned i
 	write_c0_count(count);
 }
 
+int (*mips_timer_state)(void);
 void (*mips_timer_ack)(void);
 unsigned int (*mips_hpt_read)(void);
 void (*mips_hpt_init)(unsigned int);
@@ -548,7 +549,7 @@ asmlinkage void ll_local_timer_interrupt
  *
  * 1) board_time_init() -
  * 	a) (optional) set up RTC routines,
- *      b) (optional) calibrate and set the mips_counter_frequency
+ *      b) (optional) calibrate and set the mips_hpt_frequency
  *	    (only needed if you intended to use fixed_rate_gettimeoffset
  *	     or use cpu counter as timer interrupt source)
  * 2) setup xtime based on rtc_get_time().
@@ -563,7 +564,7 @@ asmlinkage void ll_local_timer_interrupt
 void (*board_time_init)(void);
 void (*board_timer_setup)(struct irqaction *irq);
 
-unsigned int mips_counter_frequency;
+unsigned int mips_hpt_frequency;
 
 static struct irqaction timer_irqaction = {
 	.handler = timer_interrupt,
@@ -571,6 +572,49 @@ static struct irqaction timer_irqaction 
 	.name = "timer",
 };
 
+static unsigned int __init calibrate_hpt(void)
+{
+	u64 frequency;
+	u32 hpt_start, hpt_end, hpt_count, hz;
+
+	const int loops = HZ / 10;
+	int log_2_loops = 0;
+	int i;
+
+	/*
+	 * We want to calibrate for 0.1s, but to avoid a 64-bit
+	 * division we round the number of loops up to the nearest
+	 * power of 2.
+	 */
+	while (loops > 1 << log_2_loops)
+		log_2_loops++;
+	i = 1 << log_2_loops;
+
+	/*
+	 * Wait for a rising edge of the timer interrupt.
+	 */
+	while (mips_timer_state());
+	while (!mips_timer_state());
+
+	/*
+	 * Now see how many high precision timer ticks happen
+	 * during the calculated number of periods between timer
+	 * interrupts.
+	 */
+	hpt_start = mips_hpt_read();
+	do {
+		while (mips_timer_state());
+		while (!mips_timer_state());
+	} while (--i);
+	hpt_end = mips_hpt_read();
+
+	hpt_count = hpt_end - hpt_start;
+	hz = HZ;
+	frequency = (u64)hpt_count * (u64)hz;
+
+	return frequency >> log_2_loops;
+}
+
 void __init time_init(void)
 {
 	if (board_time_init)
@@ -587,7 +631,7 @@ void __init time_init(void)
 		/* No high precision timer -- sorry.  */
 		mips_hpt_read = null_hpt_read;
 		mips_hpt_init = null_hpt_init;
-	} else if (!mips_counter_frequency) {
+	} else if (!mips_hpt_frequency && !mips_timer_state) {
 		/* A high precision timer of unknown frequency.  */
 		if (!mips_hpt_read) {
 			/* No external high precision timer -- use R4k.  */
@@ -610,27 +654,36 @@ void __init time_init(void)
 			 */
 			do_gettimeoffset = calibrate_div64_gettimeoffset;
 	} else {
-		/* We know counter frequency! */
+		/* We know counter frequency.  Or we can get it.  */
 		if (!mips_hpt_read) {
 			/* No external high precision timer -- use R4k.  */
 			mips_hpt_read = c0_hpt_read;
-			mips_hpt_init = c0_fixed_hpt_init;
 
-			if (!mips_timer_ack)
-				/* R4k timer interrupt ack.  */
-				mips_timer_ack = c0_fixed_timer_ack;
+			if (mips_timer_state)
+				mips_hpt_init = c0_hpt_init;
+			else {
+				/* No external timer interrupt -- use R4k.  */
+				mips_hpt_init = c0_hpt_timer_init;
+				mips_timer_ack = c0_timer_ack;
+			}
 		}
+		if (!mips_hpt_frequency)
+			mips_hpt_frequency = calibrate_hpt();
 
 		do_gettimeoffset = fixed_rate_gettimeoffset;
 
 		/* Calculate cache parameters.  */
-		cycles_per_jiffy = mips_counter_frequency / HZ;
+		cycles_per_jiffy = (mips_hpt_frequency + HZ / 2) / HZ;
 
 		/* sll32_usecs_per_cycle = 10^6 * 2^32 / mips_counter_freq  */
-		/* Any better way to do this?  */
-		sll32_usecs_per_cycle = mips_counter_frequency / 100000;
-		sll32_usecs_per_cycle = 0xffffffff / sll32_usecs_per_cycle;
-		sll32_usecs_per_cycle *= 10;
+		do_div64_32(sll32_usecs_per_cycle,
+			    1000000, mips_hpt_frequency / 2,
+			    mips_hpt_frequency);
+
+		/* Report the high precision timer rate for a reference.  */
+		printk("Using %u.%03u MHz high precision timer.\n",
+		       ((mips_hpt_frequency + 500) / 1000) / 1000,
+		       ((mips_hpt_frequency + 500) / 1000) % 1000);
 	}
 
 	if (!mips_timer_ack)
diff -up --recursive --new-file linux-mips-2.4.21-20030811.macro/include/asm-mips/time.h linux-mips-2.4.21-20030811/include/asm-mips/time.h
--- linux-mips-2.4.21-20030811.macro/include/asm-mips/time.h	2003-08-06 02:57:03.000000000 +0000
+++ linux-mips-2.4.21-20030811/include/asm-mips/time.h	2003-08-14 00:32:44.000000000 +0000
@@ -36,9 +36,11 @@ extern int (*rtc_set_time)(unsigned long
 extern int (*rtc_set_mmss)(unsigned long);
 
 /*
- * Timer interrupt ack function.
- * May be NULL if the interrupt is self-recoverable.
+ * Timer interrupt functions.
+ * mips_timer_state is needed for high precision timer calibration.
+ * mips_timer_ack may be NULL if the interrupt is self-recoverable.
  */
+extern int (*mips_timer_state)(void);
 extern void (*mips_timer_ack)(void);
 
 /*
@@ -88,9 +90,10 @@ extern void (*board_time_init)(void);
 extern void (*board_timer_setup)(struct irqaction *irq);
 
 /*
- * mips_counter_frequency - must be set if you intend to use
- * counter as timer interrupt source or use fixed_rate_gettimeoffset.
+ * mips_hpt_frequency - must be set if you intend to use an R4k-compatible
+ * counter as a timer interrupt source; otherwise it can be set up
+ * automagically with an aid of mips_timer_state.
  */
-extern unsigned int mips_counter_frequency;
+extern unsigned int mips_hpt_frequency;
 
 #endif /* _ASM_TIME_H */
diff -up --recursive --new-file linux-mips-2.4.21-20030811.macro/include/asm-mips64/time.h linux-mips-2.4.21-20030811/include/asm-mips64/time.h
--- linux-mips-2.4.21-20030811.macro/include/asm-mips64/time.h	2003-08-11 22:16:06.000000000 +0000
+++ linux-mips-2.4.21-20030811/include/asm-mips64/time.h	2003-08-14 00:32:44.000000000 +0000
@@ -36,9 +36,11 @@ extern int (*rtc_set_time)(unsigned long
 extern int (*rtc_set_mmss)(unsigned long);
 
 /*
- * Timer interrupt ack function.
- * May be NULL if the interrupt is self-recoverable.
+ * Timer interrupt functions.
+ * mips_timer_state is needed for high precision timer calibration.
+ * mips_timer_ack may be NULL if the interrupt is self-recoverable.
  */
+extern int (*mips_timer_state)(void);
 extern void (*mips_timer_ack)(void);
 
 /*
@@ -88,9 +90,10 @@ extern void (*board_time_init)(void);
 extern void (*board_timer_setup)(struct irqaction *irq);
 
 /*
- * mips_counter_frequency - must be set if you intend to use
- * counter as timer interrupt source or use fixed_rate_gettimeoffset.
+ * mips_hpt_frequency - must be set if you intend to use an R4k-compatible
+ * counter as a timer interrupt source; otherwise it can be set up
+ * automagically with an aid of mips_timer_state.
  */
-extern unsigned int mips_counter_frequency;
+extern unsigned int mips_hpt_frequency;
 
 #endif /* _ASM_TIME_H */
