Received:  by oss.sgi.com id <S42188AbQHGP2l>;
	Mon, 7 Aug 2000 08:28:41 -0700
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:19128 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S42183AbQHGP2O>;
	Mon, 7 Aug 2000 08:28:14 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA04367;
	Mon, 7 Aug 2000 17:22:54 +0200 (MET DST)
Date:   Mon, 7 Aug 2000 17:22:54 +0200 (MET DST)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Ralf Baechle <ralf@uni-koblenz.de>,
        Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
cc:     Craig P Prescott <prescott@phys.ufl.edu>, linux-mips@fnet.fr,
        linux-mips@oss.sgi.com
Subject: High resolution timer support for I/O ASIC DECstations
Message-ID: <Pine.GSO.3.96.1000807165501.3044B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi,

 Following is a patch that implements a high resolution timer for I/O ASIC
DECstations, i.e. it provides a do_fast_gettimeoffset() function that is
suitable for R3K-based machines (that do not have a cycle counter within
the CPU).  Also a proper do_div() macro is included.  There are also a few
small cleanups and enhancements in the related code.

 This change makes my NTP daemon particularly happy -- a dispersion of
0.02 when synchronizing with a remote server is really nice.  An X server
would benefit, too, if we had one. 

 I'd like to encourage everyone interested to test these changes as much
as possible.  Also if anyone knows of a better division algorithm than the
one I used for do_div64_32(), I'd be glad to hear of it.  If nothing wrong
pops up, these changes should be included in the official tree, I believe. 

 Comments are welcomed, as usually.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

diff -u --recursive --new-file linux-mips-2.4.0-test5-20000731.macro/arch/mips/Makefile linux-mips-2.4.0-test5-20000731/arch/mips/Makefile
--- linux-mips-2.4.0-test5-20000731.macro/arch/mips/Makefile	Thu Jul 13 04:26:16 2000
+++ linux-mips-2.4.0-test5-20000731/arch/mips/Makefile	Sat Aug  5 17:45:33 2000
@@ -35,7 +35,7 @@
 # machines may also.  Since BFD is incredibly buggy with respect to
 # crossformat linking we rely on the elf2ecoff tool for format conversion.
 #
-CFLAGS		+= -G 0 -mno-abicalls -fno-pic
+GCCFLAGS	:= -G 0 -mno-abicalls -fno-pic
 LINKFLAGS	+= -static -G 0
 MODFLAGS	+= -mlong-calls
 
@@ -47,31 +47,40 @@
 # CPU-dependent compiler/assembler options for optimization.
 #
 ifdef CONFIG_CPU_R3000
-CFLAGS		:= $(CFLAGS) -mcpu=r3000 -mips1
+GCCFLAGS	+= -mcpu=r3000 -mips1
 endif
 ifdef CONFIG_CPU_R6000
-CFLAGS		:= $(CFLAGS) -mcpu=r6000 -mips2 -Wa,--trap
+GCCFLAGS	+= -mcpu=r6000 -mips2 -Wa,--trap
 endif
 ifdef CONFIG_CPU_R4300
-CFLAGS		:= $(CFLAGS) -mcpu=r4300 -mips2 -Wa,--trap
+GCCFLAGS	+= -mcpu=r4300 -mips2 -Wa,--trap
 endif
 ifdef CONFIG_CPU_R4X00
-CFLAGS		:= $(CFLAGS) -mcpu=r4600 -mips2 -Wa,--trap
+GCCFLAGS	+= -mcpu=r4600 -mips2 -Wa,--trap
 endif
 ifdef CONFIG_CPU_R5000
-CFLAGS		:= $(CFLAGS) -mcpu=r8000 -mips2 -Wa,--trap
+GCCFLAGS	+= -mcpu=r8000 -mips2 -Wa,--trap
 endif
 ifdef CONFIG_CPU_NEVADA
-CFLAGS		:= $(CFLAGS) -mcpu=r8000 -mips2 -Wa,--trap -mmad
+GCCFLAGS	+= -mcpu=r8000 -mips2 -Wa,--trap -mmad
 endif
 ifdef CONFIG_CPU_R8000
-CFLAGS		:= $(CFLAGS) -mcpu=r8000 -mips2 -Wa,--trap
+GCCFLAGS	+= -mcpu=r8000 -mips2 -Wa,--trap
 endif
 ifdef CONFIG_CPU_R10000
-CFLAGS		:= $(CFLAGS) -mcpu=r8000 -mips2 -Wa,--trap
+GCCFLAGS	+= -mcpu=r8000 -mips2 -Wa,--trap
 endif
 
 #
+# The pipe options is bad for my low-mem machine
+# Uncomment this if you want this.
+#
+GCCFLAGS	+= -pipe
+
+CFLAGS		+= $(GCCFLAGS)
+AFLAGS		+= $(GCCFLAGS)
+
+#
 # Board-dependent options and extra files
 #
 ifdef CONFIG_ALGOR_P4032
@@ -168,12 +177,6 @@
 ifdef LOADADDR
 LINKFLAGS     += -Ttext $(word 1,$(LOADADDR))
 endif
-
-#
-# The pipe options is bad for my low-mem machine
-# Uncomment this if you want this.
-#
-CFLAGS		+= -pipe
 
 HEAD := arch/mips/kernel/head.o arch/mips/kernel/init_task.o
 
diff -u --recursive --new-file linux-mips-2.4.0-test5-20000731.macro/arch/mips/dec/Makefile linux-mips-2.4.0-test5-20000731/arch/mips/dec/Makefile
--- linux-mips-2.4.0-test5-20000731.macro/arch/mips/dec/Makefile	Tue Mar 28 04:26:06 2000
+++ linux-mips-2.4.0-test5-20000731/arch/mips/dec/Makefile	Sat Aug  5 17:24:35 2000
@@ -7,9 +7,9 @@
 #
 
 .S.s:
-	$(CPP) $(CFLAGS) $< -o $*.s
+	$(CPP) $(AFLAGS) -traditional -o $*.o $<
 .S.o:
-	$(CC) $(CFLAGS) -c $< -o $*.o
+	$(CC) $(AFLAGS) -traditional -c -o $*.o $<
 
 all: dec.o
 O_TARGET := dec.o
diff -u --recursive --new-file linux-mips-2.4.0-test5-20000731.macro/arch/mips/dec/int-handler.S linux-mips-2.4.0-test5-20000731/arch/mips/dec/int-handler.S
--- linux-mips-2.4.0-test5-20000731.macro/arch/mips/dec/int-handler.S	Tue Mar 28 04:26:06 2000
+++ linux-mips-2.4.0-test5-20000731/arch/mips/dec/int-handler.S	Sat Aug  5 15:31:37 2000
@@ -2,6 +2,7 @@
  * arch/mips/dec/int-handler.S
  *
  * Copyright (C) 1995, 1996, 1997 Paul M. Antoine and Harald Koerfgen
+ * Copyright (C) 2000  Maciej W. Rozycki
  *
  * Written by Ralf Baechle and Andreas Busse, modified for DECStation
  * support by Paul Antoine and Harald Koerfgen.
@@ -16,6 +17,11 @@
 #include <asm/stackframe.h>
 #include <asm/addrspace.h>
 
+#include <asm/dec/kn01.h>
+#include <asm/dec/kn02.h>
+#include <asm/dec/kn02xa.h>
+#include <asm/dec/kn03.h>
+#include <asm/dec/ioasic_addrs.h>
 #include <asm/dec/interrupts.h>
 
 
@@ -164,10 +170,10 @@
 /*
  * Handle "IRQ Controller" Interrupts
  * Masked Interrupts are still visible and have to be masked "by hand".
- * %hi(KN02_CSR_ADDR) does not work so all addresses are hardcoded :-(.
  */
 		EXPORT(kn02_io_int)
-kn02_io_int:	lui	t0,0xbff0		# get interrupt status and mask
+kn02_io_int:					# 3max
+		lui	t0,KN02_CSR_ADDR>>16	# get interrupt status and mask
 		lw	t0,(t0)
 		la	t1,asic_mask_tbl
 		move	t3,t0
@@ -176,17 +182,20 @@
 		 and	t0,t3			# mask out allowed ones
 
 		EXPORT(kn03_io_int)
-kn03_io_int:	lui	t2,0xbf84		# upper part of IOASIC Address
-		lw	t0,0x0110(t2)		# get status: IOASIC isr
-		lw	t3,0x0120(t2)		# get mask:   IOASIC isrm
+kn03_io_int:					# 3max+
+		lui	t2,KN03_IOASIC_BASE>>16	# upper part of IOASIC Address
+		lw	t0,SIR(t2)		# get status: IOASIC isr
+		lw	t3,SIMR(t2)		# get mask:   IOASIC isrm
 		la	t1,asic_mask_tbl
 		b	find_int
 		 and	t0,t3			# mask out allowed ones
 
-		EXPORT(kn02ba_io_int)
-kn02ba_io_int:	lui	t2,0xbc04		
-		lw	t0,0x0110(t2)		# IOASIC isr, works for maxine also
-		lw	t3,0x0120(t2)		# IOASIC isrm
+		EXPORT(kn02xa_io_int)
+kn02xa_io_int:					# 3min/maxine
+		lui	t2,KN02XA_IOASIC_BASE>>16		
+						# upper part of IOASIC Address
+		lw	t0,SIR(t2)		# get status: IOASIC isr
+		lw	t3,SIMR(t2)		# get mask:   IOASIC isrm
 		la	t1,asic_mask_tbl
 		and	t0,t3
 
diff -u --recursive --new-file linux-mips-2.4.0-test5-20000731.macro/arch/mips/dec/irq.c linux-mips-2.4.0-test5-20000731/arch/mips/dec/irq.c
--- linux-mips-2.4.0-test5-20000731.macro/arch/mips/dec/irq.c	Tue Mar 28 04:26:06 2000
+++ linux-mips-2.4.0-test5-20000731/arch/mips/dec/irq.c	Sat Aug  5 18:40:27 2000
@@ -27,10 +27,6 @@
 
 #include <asm/dec/interrupts.h>
 
-extern volatile unsigned int *isr;	/* address of the interrupt status register     */
-extern volatile unsigned int *imr;	/* address of the interrupt mask register       */
-extern decint_t dec_interrupt[NR_INTS];
-
 irq_cpustat_t irq_stat [NR_CPUS];
 
 unsigned int local_bh_count[NR_CPUS];
diff -u --recursive --new-file linux-mips-2.4.0-test5-20000731.macro/arch/mips/dec/setup.c linux-mips-2.4.0-test5-20000731/arch/mips/dec/setup.c
--- linux-mips-2.4.0-test5-20000731.macro/arch/mips/dec/setup.c	Tue Mar 28 04:26:06 2000
+++ linux-mips-2.4.0-test5-20000731/arch/mips/dec/setup.c	Sat Aug  5 18:49:00 2000
@@ -6,6 +6,7 @@
  * for more details.
  *
  * Copyright (C) 1998 Harald Koerfgen
+ * Copyright (C) 2000 Maciej W. Rozycki
  */
 #include <linux/sched.h>
 #include <linux/interrupt.h>
@@ -22,6 +23,8 @@
 #include <asm/dec/kn02.h>
 #include <asm/dec/kn02xa.h>
 #include <asm/dec/kn03.h>
+#include <asm/dec/ioasic.h>
+#include <asm/dec/ioasic_addrs.h>
 #include <asm/dec/ioasic_ints.h>
 
 extern asmlinkage void decstation_handle_int(void);
@@ -33,14 +36,14 @@
 void dec_init_kn02ca(void);
 void dec_init_kn03(void);
 
-char *dec_rtc_base = (char *) KN01_RTC_BASE;	/* Assume DS2100/3100 initially */
+char *dec_rtc_base = (void *) KN01_RTC_BASE;	/* Assume DS2100/3100 initially */
+
+volatile unsigned int *ioasic_base;
 
 decint_t dec_interrupt[NR_INTS];
 
-/* 
+/*
  * Information regarding the IRQ Controller
- *
- * isr and imr are also hardcoded for different machines in int_handler.S
  */
 
 volatile unsigned int *isr = 0L;	/* address of the interrupt status register     */
@@ -206,8 +209,8 @@
      * Setup some memory addresses. FIXME: probably incomplete!
      */
     dec_rtc_base = (char *) KN02_RTC_BASE;
-    isr = (volatile unsigned int *) KN02_CSR_ADDR;
-    imr = (volatile unsigned int *) KN02_CSR_ADDR;
+    isr = (void *) KN02_CSR_ADDR;
+    imr = (void *) KN02_CSR_ADDR;
 
     /*
      * Setup IOASIC interrupt
@@ -275,16 +278,17 @@
     /*
      * Setup some memory addresses.
      */
+    ioasic_base = (void *) KN02XA_IOASIC_BASE;
     dec_rtc_base = (char *) KN02XA_RTC_BASE;
-    isr = (volatile unsigned int *) KN02XA_SIR_ADDR;
-    imr = (volatile unsigned int *) KN02XA_SIRM_ADDR;
+    isr = (void *) KN02XA_IOASIC_REG(SIR);
+    imr = (void *) KN02XA_IOASIC_REG(SIMR);
 
     /*
      * Setup IOASIC interrupt
      */
     cpu_mask_tbl[0] = IE_IRQ3;
     cpu_irq_nr[0] = -1;
-    cpu_ivec_tbl[0] = kn02ba_io_int;
+    cpu_ivec_tbl[0] = kn02xa_io_int;
     *imr = 0;
 
     /*
@@ -355,14 +359,15 @@
     /*
      * Setup some memory addresses. FIXME: probably incomplete!
      */
+    ioasic_base = (void *) KN02XA_IOASIC_BASE;
     dec_rtc_base = (char *) KN02XA_RTC_BASE;
-    isr = (volatile unsigned int *) KN02XA_SIR_ADDR;
-    imr = (volatile unsigned int *) KN02XA_SIRM_ADDR;
+    isr = (void *) KN02XA_IOASIC_REG(SIR);
+    imr = (void *) KN02XA_IOASIC_REG(SIMR);
 
     /*
      * Setup IOASIC interrupt
      */
-    cpu_ivec_tbl[1] = kn02ba_io_int;
+    cpu_ivec_tbl[1] = kn02xa_io_int;
     cpu_irq_nr[1] = -1;
     cpu_mask_tbl[1] = IE_IRQ3;
     *imr = 0;
@@ -430,9 +435,10 @@
     /*
      * Setup some memory addresses. FIXME: probably incomplete!
      */
+    ioasic_base = (void *) KN03_IOASIC_BASE;
     dec_rtc_base = (char *) KN03_RTC_BASE;
-    isr = (volatile unsigned int *) KN03_SIR_ADDR;
-    imr = (volatile unsigned int *) KN03_SIRM_ADDR;
+    isr = (void *) KN03_IOASIC_REG(SIR);
+    imr = (void *) KN03_IOASIC_REG(SIMR);
 
     /*
      * Setup IOASIC interrupt
diff -u --recursive --new-file linux-mips-2.4.0-test5-20000731.macro/arch/mips/dec/time.c linux-mips-2.4.0-test5-20000731/arch/mips/dec/time.c
--- linux-mips-2.4.0-test5-20000731.macro/arch/mips/dec/time.c	Wed Jul 12 04:25:56 2000
+++ linux-mips-2.4.0-test5-20000731/arch/mips/dec/time.c	Sat Aug  5 19:19:57 2000
@@ -1,8 +1,9 @@
 
 /*
- *  linux/arch/mips/kernel/time.c
+ *  linux/arch/mips/dec/time.c
  *
  *  Copyright (C) 1991, 1992, 1995  Linus Torvalds
+ *  Copyright (C) 2000  Maciej W. Rozycki
  *
  * This file contains the time handling details for PC-style clocks as
  * found in some MIPS systems.
@@ -21,10 +22,15 @@
 #include <asm/mipsregs.h>
 #include <asm/io.h>
 #include <asm/irq.h>
+#include <asm/dec/machtype.h>
+#include <asm/dec/ioasic.h>
+#include <asm/dec/ioasic_addrs.h>
 
 #include <linux/mc146818rtc.h>
 #include <linux/timex.h>
 
+#include <asm/div64.h>
+
 extern volatile unsigned long wall_jiffies;
 extern rwlock_t xtime_lock;
 
@@ -36,12 +42,22 @@
 
 /* This is for machines which generate the exact clock. */
 #define USECS_PER_JIFFY (1000000/HZ)
+#define USECS_PER_JIFFY_FRAC (0x100000000*1000000/HZ&0xffffffff)
 
 /* Cycle counter value at the previous timer interrupt.. */
 
 static unsigned int timerhi = 0, timerlo = 0;
 
 /*
+ * Cached "1/(clocks per usec)*2^32" value.
+ * It has to be recalculated once each jiffy.
+ */
+static unsigned long cached_quotient = 0;
+
+/* Last jiffy when do_fast_gettimeoffset() was called. */
+static unsigned long last_jiffies = 0;
+
+/*
  * On MIPS only R4000 and better have a cycle counter.
  *
  * FIXME: Does playing with the RP bit in c0_status interfere with this code?
@@ -50,45 +66,34 @@
 {
 	u32 count;
 	unsigned long res, tmp;
-
-	/* Last jiffy when do_fast_gettimeoffset() was called. */
-	static unsigned long last_jiffies = 0;
 	unsigned long quotient;
 
-	/*
-	 * Cached "1/(clocks per usec)*2^32" value.
-	 * It has to be recalculated once each jiffy.
-	 */
-	static unsigned long cached_quotient = 0;
-
 	tmp = jiffies;
 
 	quotient = cached_quotient;
 
-	if (tmp && last_jiffies != tmp) {
-		last_jiffies = tmp;
-		__asm__(".set\tnoreorder\n\t"
-			".set\tnoat\n\t"
-			".set\tmips3\n\t"
-			"lwu\t%0,%2\n\t"
-			"dsll32\t$1,%1,0\n\t"
-			"or\t$1,$1,%0\n\t"
-			"ddivu\t$0,$1,%3\n\t"
-			"mflo\t$1\n\t"
-			"dsll32\t%0,%4,0\n\t"
-			"nop\n\t"
-			"ddivu\t$0,%0,$1\n\t"
-			"mflo\t%0\n\t"
-			".set\tmips0\n\t"
-			".set\tat\n\t"
-			".set\treorder"
-			:"=&r"(quotient)
-			:"r"(timerhi),
-			"m"(timerlo),
-			"r"(tmp),
-			"r"(USECS_PER_JIFFY)
-			:"$1");
+	if (last_jiffies != tmp) {
+	    last_jiffies = tmp;
+	    if (last_jiffies != 0) {
+		unsigned long r0;
+		__asm__(".set	push\n\t"
+			".set	mips3\n\t"
+			"lwu	%0,%3\n\t"
+			"dsll32	%1,%2,0\n\t"
+			"or	%1,%1,%0\n\t"
+			"ddivu	$0,%1,%4\n\t"
+			"mflo	%1\n\t"
+			"dsll32	%0,%5,0\n\t"
+			"or	%0,%0,%6\n\t"
+			"ddivu	$0,%0,%1\n\t"
+			"mflo	%0\n\t"
+			".set	pop"
+			: "=&r" (quotient), "=&r" (r0)
+			: "r" (timerhi), "m" (timerlo),
+			  "r" (tmp), "r" (USECS_PER_JIFFY),
+			  "r" (USECS_PER_JIFFY_FRAC));
 		cached_quotient = quotient;
+	    }
 	}
 	/* Get last timer tick in absolute kernel time */
 	count = read_32bit_cp0_register(CP0_COUNT);
@@ -97,11 +102,9 @@
 	count -= timerlo;
 //printk("count: %08lx, %08lx:%08lx\n", count, timerhi, timerlo);
 
-	__asm__("multu\t%1,%2\n\t"
-		"mfhi\t%0"
-		:"=r"(res)
-		:"r"(count),
-		"r"(quotient));
+	__asm__("multu	%2,%3"
+		: "=l" (tmp), "=h" (res)
+		: "r" (count), "r" (quotient));
 
 	/*
 	 * Due to possible jiffies inconsistencies, we need to check 
@@ -113,6 +116,47 @@
 	return res;
 }
 
+static unsigned long do_ioasic_gettimeoffset(void)
+{
+	u32 count;
+	unsigned long res, tmp;
+	unsigned long quotient;
+
+	tmp = jiffies;
+
+	quotient = cached_quotient;
+
+	if (last_jiffies != tmp) {
+		last_jiffies = tmp;
+		if (last_jiffies != 0) {
+			unsigned long r0;
+			do_div64_32(r0, timerhi, timerlo, tmp);
+			do_div64_32(quotient, USECS_PER_JIFFY,
+				    USECS_PER_JIFFY_FRAC, r0);
+			cached_quotient = quotient;
+		}
+	}
+	/* Get last timer tick in absolute kernel time */
+	count = ioasic_read(FCTR);
+
+	/* .. relative to previous jiffy (32 bits is enough) */
+	count -= timerlo;
+//printk("count: %08x, %08x:%08x\n", count, timerhi, timerlo);
+
+	__asm__("multu	%2,%3"
+		: "=l" (tmp), "=h" (res)
+		: "r" (count), "r" (quotient));
+
+	/*
+	 * Due to possible jiffies inconsistencies, we need to check
+	 * the result so that we'll get a timer that is monotonic.
+	 */
+	if (res >= USECS_PER_JIFFY)
+        	res = USECS_PER_JIFFY - 1;
+
+	return res;
+}
+
 /* This function must be called with interrupts disabled 
  * It was inspired by Steve McCanne's microtime-i386 for BSD.  -- jrs
  * 
@@ -170,8 +214,8 @@
 	tv->tv_usec += do_gettimeoffset();
 
 	/*
-	 * xtime is atomically updated in timer_bh. lost_ticks is
-	 * nonzero if the timer bottom half hasnt executed yet.
+	 * xtime is atomically updated in timer_bh. jiffies - wall_jiffies
+	 * is nonzero if the timer bottom half hasnt executed yet.
 	 */
 	if (jiffies - wall_jiffies)
 		tv->tv_usec += USECS_PER_JIFFY;
@@ -309,11 +353,12 @@
 	read_lock(&xtime_lock);
 	if (time_state != TIME_BAD && xtime.tv_sec > last_rtc_update + 660 &&
 	    xtime.tv_usec > 500000 - (tick >> 1) &&
-	    xtime.tv_usec < 500000 + (tick >> 1))
+	    xtime.tv_usec < 500000 + (tick >> 1)) {
 		if (set_rtc_mmss(xtime.tv_sec) == 0)
 			last_rtc_update = xtime.tv_sec;
 		else
 			last_rtc_update = xtime.tv_sec - 600;	/* do it again in 60 s */
+	}
 	/* As we return to user mode fire off the other CPU schedulers.. this is
 	   basically because we don't yet share IRQ's around. This message is
 	   rigged to be safe on the 386 - basically it's a hack, so don't look
@@ -334,16 +379,42 @@
 	timerhi += (count < timerlo);	/* Wrap around */
 	timerlo = count;
 
+	if (jiffies == ~0) {
+		/*
+		 * If jiffies is to overflow in this timer_interrupt we must
+		 * update the timer[hi]/[lo] to make do_fast_gettimeoffset()
+		 * quotient calc still valid. -arca
+		 */
+		write_32bit_cp0_register(CP0_COUNT, 0);
+		timerhi = timerlo = 0;
+	}
+
 	timer_interrupt(irq, dev_id, regs);
+}
+
+static void ioasic_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	unsigned int count;
+
+	/*
+	 * The free-running counter is 32 bit which is good for about
+	 * 2 minutes, 50 seconds at possible count rates of upto 25MHz.
+	 */
+	count = ioasic_read(FCTR);
+	timerhi += (count < timerlo);	/* Wrap around */
+	timerlo = count;
 
-	if (!jiffies) {
+	if (jiffies == ~0) {
 		/*
-		 * If jiffies has overflowed in this timer_interrupt we must
+		 * If jiffies is to overflow in this timer_interrupt we must
 		 * update the timer[hi]/[lo] to make do_fast_gettimeoffset()
 		 * quotient calc still valid. -arca
 		 */
+		ioasic_write(FCTR, 0);
 		timerhi = timerlo = 0;
 	}
+
+	timer_interrupt(irq, dev_id, regs);
 }
 
 /* Converts Gregorian date to seconds since 1970-01-01 00:00:00.
@@ -473,6 +544,10 @@
 		write_32bit_cp0_register(CP0_COUNT, 0);
 		do_gettimeoffset = do_fast_gettimeoffset;
 		irq0.handler = r4k_timer_interrupt;
-	}
+	} else if (IOASIC) {
+		ioasic_write(FCTR, 0);
+		do_gettimeoffset = do_ioasic_gettimeoffset;
+		irq0.handler = ioasic_timer_interrupt;
+        }
 	board_time_init(&irq0);
 }
diff -u --recursive --new-file linux-mips-2.4.0-test5-20000731.macro/include/asm-mips/addrspace.h linux-mips-2.4.0-test5-20000731/include/asm-mips/addrspace.h
--- linux-mips-2.4.0-test5-20000731.macro/include/asm-mips/addrspace.h	Tue Mar 28 04:27:19 2000
+++ linux-mips-2.4.0-test5-20000731/include/asm-mips/addrspace.h	Sat Aug  5 18:04:53 2000
@@ -4,6 +4,7 @@
  * for more details.
  *
  * Copyright (C) 1996 by Ralf Baechle
+ * Copyright (C) 2000 by Maciej W. Rozycki
  *
  * Defitions for the address spaces of the MIPS CPUs.
  */
@@ -22,20 +23,35 @@
 /*
  * Returns the kernel segment base of a given address
  */
+#ifndef __ASSEMBLY__
 #define KSEGX(a)                (((unsigned long)(a)) & 0xe0000000)
+#else
+#define KSEGX(a)                ((a) & 0xe0000000)
+#endif
 
 /*
  * Returns the physical address of a KSEG0/KSEG1 address
  */
+#ifndef __ASSEMBLY__
 #define PHYSADDR(a)		(((unsigned long)(a)) & 0x1fffffff)
+#else
+#define PHYSADDR(a)		((a) & 0x1fffffff)
+#endif
 
 /*
  * Map an address to a certain kernel segment
  */
+#ifndef __ASSEMBLY__
 #define KSEG0ADDR(a)		((__typeof__(a))(((unsigned long)(a) & 0x1fffffff) | KSEG0))
 #define KSEG1ADDR(a)		((__typeof__(a))(((unsigned long)(a) & 0x1fffffff) | KSEG1))
 #define KSEG2ADDR(a)		((__typeof__(a))(((unsigned long)(a) & 0x1fffffff) | KSEG2))
 #define KSEG3ADDR(a)		((__typeof__(a))(((unsigned long)(a) & 0x1fffffff) | KSEG3))
+#else
+#define KSEG0ADDR(a)		(((a) & 0x1fffffff) | KSEG0)
+#define KSEG1ADDR(a)		(((a) & 0x1fffffff) | KSEG1)
+#define KSEG2ADDR(a)		(((a) & 0x1fffffff) | KSEG2)
+#define KSEG3ADDR(a)		(((a) & 0x1fffffff) | KSEG3)
+#endif
 
 /*
  * Memory segments (64bit kernel mode addresses)
diff -u --recursive --new-file linux-mips-2.4.0-test5-20000731.macro/include/asm-mips/dec/interrupts.h linux-mips-2.4.0-test5-20000731/include/asm-mips/dec/interrupts.h
--- linux-mips-2.4.0-test5-20000731.macro/include/asm-mips/dec/interrupts.h	Tue Mar 28 04:27:23 2000
+++ linux-mips-2.4.0-test5-20000731/include/asm-mips/dec/interrupts.h	Sat Aug  5 19:25:54 2000
@@ -36,7 +36,7 @@
 
 #define NR_INTS	11
 
-#ifndef _LANGUAGE_ASSEMBLY
+#ifndef __ASSEMBLY__
 /*
  * Data structure to hide the differences between the DECstation Interrupts
  *
@@ -50,6 +50,12 @@
 	unsigned int	iemask;		/* enabling interrupts in IRQ Controller	*/
 } decint_t;
 
+extern volatile unsigned int *isr;
+				/* address of the interrupt status register  */
+extern volatile unsigned int *imr;
+				/* address of the interrupt mask register    */
+extern decint_t dec_interrupt[NR_INTS];
+
 /*
  * Interrupt table structure to hide differences between different
  * systems such.
@@ -68,7 +74,7 @@
 extern void	dec_intr_rtc(void);
 
 extern void	kn02_io_int(void);
-extern void	kn02ba_io_int(void);
+extern void	kn02xa_io_int(void);
 extern void	kn03_io_int(void);
 
 extern void	intr_halt(void);
diff -u --recursive --new-file linux-mips-2.4.0-test5-20000731.macro/include/asm-mips/dec/ioasic.h linux-mips-2.4.0-test5-20000731/include/asm-mips/dec/ioasic.h
--- linux-mips-2.4.0-test5-20000731.macro/include/asm-mips/dec/ioasic.h	Thu Jan  1 00:00:00 1970
+++ linux-mips-2.4.0-test5-20000731/include/asm-mips/dec/ioasic.h	Sat Aug  5 17:07:15 2000
@@ -0,0 +1,24 @@
+/*
+ *  linux/asm-mips/dec/ioasic.h
+ *
+ *  Copyright (C) 2000  Maciej W. Rozycki
+ *
+ *  DEC I/O ASIC access operations.
+ */
+
+#ifndef __ASM_DEC_IOASIC_H
+#define __ASM_DEC_IOASIC_H
+
+extern volatile unsigned int *ioasic_base;
+
+extern inline void ioasic_write(unsigned int reg, unsigned int v)
+{
+	ioasic_base[reg / 4] = v;
+}
+
+extern inline unsigned int ioasic_read(unsigned int reg)
+{
+	return ioasic_base[reg / 4];
+}
+
+#endif /* __ASM_DEC_IOASIC_H */
diff -u --recursive --new-file linux-mips-2.4.0-test5-20000731.macro/include/asm-mips/dec/ioasic_addrs.h linux-mips-2.4.0-test5-20000731/include/asm-mips/dec/ioasic_addrs.h
--- linux-mips-2.4.0-test5-20000731.macro/include/asm-mips/dec/ioasic_addrs.h	Tue Mar 28 04:27:23 2000
+++ linux-mips-2.4.0-test5-20000731/include/asm-mips/dec/ioasic_addrs.h	Sat Aug  5 14:48:14 2000
@@ -17,25 +17,25 @@
 
 #define CHUNK_SIZE 0x00040000
 
-#define SYSTEM_ROM 	00*CHUNK_SIZE 		/* ??? */
-#define IOCTL 		01*CHUNK_SIZE 
-#define ESAR 		02*CHUNK_SIZE 
-#define LANCE 		03*CHUNK_SIZE 
-#define SCC0 		04*CHUNK_SIZE 
-#define VDAC_HI		05*CHUNK_SIZE		/* maxine only */
-#define SCC1 		06*CHUNK_SIZE 
-#define VDAC_LO		07*CHUNK_SIZE		/* maxine only */
-#define TOY 		08*CHUNK_SIZE 
-#define ISDN 		09*CHUNK_SIZE		/* maxine only */
-#define ERRADDR		09*CHUNK_SIZE 		/* 3maxplus only */
-#define CHKSYN 		10*CHUNK_SIZE 		/* 3maxplus only */
-#define ACCESS_BUS	10*CHUNK_SIZE 		/* maxine only */
-#define MCR 		11*CHUNK_SIZE 		/* 3maxplus only */
-#define FLOPPY 		11*CHUNK_SIZE 		/* maxine only */
-#define SCSI 		12*CHUNK_SIZE
-#define FLOPPY_DMA 	13*CHUNK_SIZE 		/* maxine only */
-#define SCSI_DMA 	14*CHUNK_SIZE 
-#define RESERVED_4 	15*CHUNK_SIZE 
+#define SYSTEM_ROM 	(00*CHUNK_SIZE)		/* ??? */
+#define IOCTL 		(01*CHUNK_SIZE)
+#define ESAR 		(02*CHUNK_SIZE)
+#define LANCE 		(03*CHUNK_SIZE)
+#define SCC0 		(04*CHUNK_SIZE)
+#define VDAC_HI		(05*CHUNK_SIZE)		/* maxine only */
+#define SCC1 		(06*CHUNK_SIZE)
+#define VDAC_LO		(07*CHUNK_SIZE)		/* maxine only */
+#define TOY 		(08*CHUNK_SIZE)
+#define ISDN 		(09*CHUNK_SIZE)		/* maxine only */
+#define ERRADDR		(09*CHUNK_SIZE)		/* 3maxplus only */
+#define CHKSYN 		(10*CHUNK_SIZE)		/* 3maxplus only */
+#define ACCESS_BUS	(10*CHUNK_SIZE)		/* maxine only */
+#define MCR 		(11*CHUNK_SIZE)		/* 3maxplus only */
+#define FLOPPY 		(11*CHUNK_SIZE)		/* maxine only */
+#define SCSI 		(12*CHUNK_SIZE)
+#define FLOPPY_DMA 	(13*CHUNK_SIZE)		/* maxine only */
+#define SCSI_DMA 	(14*CHUNK_SIZE)
+#define RESERVED_4 	(15*CHUNK_SIZE)
 
 /*
  * Offsets for IOCTL registers (relative to (system_base + IOCTL))
@@ -56,6 +56,7 @@
 #define SSR		0x100			/* System Support Register */
 #define SIR		0x110			/* System Interrupt Register */
 #define SIMR		0x120			/* System Interrupt Mask Register */
+#define FCTR		0x1e0			/* Free-Running Counter */
 
 /*
  * Handle partial word SCSI DMA transfers
diff -u --recursive --new-file linux-mips-2.4.0-test5-20000731.macro/include/asm-mips/dec/kn02xa.h linux-mips-2.4.0-test5-20000731/include/asm-mips/dec/kn02xa.h
--- linux-mips-2.4.0-test5-20000731.macro/include/asm-mips/dec/kn02xa.h	Tue Mar 28 04:27:23 2000
+++ linux-mips-2.4.0-test5-20000731/include/asm-mips/dec/kn02xa.h	Sat Aug  5 15:35:24 2000
@@ -9,6 +9,7 @@
  *
  * Copyright (C) 1995,1996 by Paul M. Antoine, some code and definitions
  * are by curteousy of Chris Fraser.
+ * Copyright (C) 2000  Maciej W. Rozycki
  *
  * These are addresses which have to be known early in the boot process.
  * For other addresses refer to tc.h ioasic_addrs.h and friends.
@@ -19,16 +20,12 @@
 #include <asm/addrspace.h>
 
 /*
- * Motherboard regs (kseg1 addresses)
- */
-#define KN02XA_SSR_ADDR		KSEG1ADDR(0x1c040100)	/* system control & status reg */
-#define KN02XA_SIR_ADDR		KSEG1ADDR(0x1c040110)	/* system interrupt reg */
-#define KN02XA_SIRM_ADDR	KSEG1ADDR(0x1c040120)	/* system interrupt mask reg */
-
-/*
  * Some port addresses...
  * FIXME: these addresses are incomplete and need tidying up!
  */
-#define KN02XA_RTC_BASE	(KSEG1ADDR(0x1c000000 + 0x200000)) /* ASIC + SL8 */
+#define KN02XA_IOASIC_BASE	KSEG1ADDR(0x1c040000)	/* I/O ASIC */
+#define KN02XA_RTC_BASE		KSEG1ADDR(0x1e000000)	/* RTC */
+
+#define KN02XA_IOASIC_REG(r)	(KN02XA_IOASIC_BASE+(r))
 
 #endif /* __ASM_MIPS_DEC_KN02XA_H */
diff -u --recursive --new-file linux-mips-2.4.0-test5-20000731.macro/include/asm-mips/dec/kn03.h linux-mips-2.4.0-test5-20000731/include/asm-mips/dec/kn03.h
--- linux-mips-2.4.0-test5-20000731.macro/include/asm-mips/dec/kn03.h	Tue Mar 28 04:27:23 2000
+++ linux-mips-2.4.0-test5-20000731/include/asm-mips/dec/kn03.h	Sat Aug  5 15:35:31 2000
@@ -8,6 +8,7 @@
  *
  * Copyright (C) 1995,1996 by Paul M. Antoine, some code and definitions
  * are by curteousy of Chris Fraser.
+ * Copyright (C) 2000  Maciej W. Rozycki
  *
  * These are addresses which have to be known early in the boot process.
  * For other addresses refer to tc.h ioasic_addrs.h and friends.
@@ -18,16 +19,12 @@
 #include <asm/addrspace.h>
 
 /*
- * Motherboard regs (kseg1 addresses)
- */
-#define KN03_SSR_ADDR	KSEG1ADDR(0x1f840100)	/* system control & status reg */
-#define KN03_SIR_ADDR	KSEG1ADDR(0x1f840110)	/* system interrupt reg */
-#define KN03_SIRM_ADDR	KSEG1ADDR(0x1f840120)	/* system interrupt mask reg */
-
-/*
  * Some port addresses...
  * FIXME: these addresses are incomplete and need tidying up!
  */
-#define KN03_RTC_BASE	(KSEG1ADDR(0x1f800000 + 0x200000)) /* ASIC + SL8 */
+#define KN03_IOASIC_BASE	KSEG1ADDR(0x1f840000)	/* I/O ASIC */
+#define KN03_RTC_BASE		KSEG1ADDR(0x1fa00000)	/* RTC */
+
+#define KN03_IOASIC_REG(r)	(KN03_IOASIC_BASE+(r))
 
 #endif /* __ASM_MIPS_DEC_KN03_H */
diff -u --recursive --new-file linux-mips-2.4.0-test5-20000731.macro/include/asm-mips/div64.h linux-mips-2.4.0-test5-20000731/include/asm-mips/div64.h
--- linux-mips-2.4.0-test5-20000731.macro/include/asm-mips/div64.h	Tue Mar 28 04:27:19 2000
+++ linux-mips-2.4.0-test5-20000731/include/asm-mips/div64.h	Sun Aug  6 05:22:36 2000
@@ -1,4 +1,7 @@
-/* $Id: div64.h,v 1.1 2000/01/28 23:18:43 ralf Exp $
+/*
+ * include/asm-mips/div64.h
+ * 
+ * Copyright (C) 2000  Maciej W. Rozycki
  *
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
@@ -7,14 +10,104 @@
 #ifndef _ASM_DIV64_H
 #define _ASM_DIV64_H
 
+#include <asm/sgidefs.h>
+
 /*
- * Hey, we're already 64-bit, no
- * need to play games..
+ * No traps on overflows for any of these...
  */
-#define do_div(n,base) ({ \
-	int __res; \
-	__res = ((unsigned long) n) % (unsigned) base; \
-	n = ((unsigned long) n) / (unsigned) base; \
-	__res; })
+
+#if (_MIPS_ISA == _MIPS_ISA_MIPS1) || (_MIPS_ISA == _MIPS_ISA_MIPS2)
+
+#define do_div64_32(res, high, low, base) ({ \
+	unsigned long __quot, __mod; \
+	unsigned long __cf, __tmp, __i; \
+	\
+	__asm__(".set	push\n\t" \
+		".set	noat\n\t" \
+		".set	noreorder\n\t" \
+		"b	1f\n\t" \
+		" li	%4,0x21\n" \
+		"0:\n\t" \
+		"sll	$1,%0,0x1\n\t" \
+		"srl	%3,%0,0x1f\n\t" \
+		"or	%0,$1,$2\n\t" \
+		"sll	%1,%1,0x1\n\t" \
+		"sll	%2,%2,0x1\n" \
+		"1:\n\t" \
+		"bnez	%3,2f\n\t" \
+		"sltu	$2,%0,%z5\n\t" \
+		"bnez	$2,3f\n\t" \
+		"2:\n\t" \
+		" addiu	%4,%4,-1\n\t" \
+		"subu	%0,%0,%z5\n\t" \
+		"addiu	%2,%2,1\n" \
+		"3:\n\t" \
+		"bnez	%4,0b\n\t" \
+		" srl	$2,%1,0x1f\n\t" \
+		".set	pop" \
+		: "=&r" (__mod), "=&r" (__tmp), "=&r" (__quot), "=&r" (__cf), \
+		  "=&r" (__i) \
+		: "Jr" (base), "0" (high), "1" (low), "2" (0), "3" (0) \
+		/* Aarrgh!  Ran out of gcc's limit on constraints... */ \
+		: "$1", "$2"); \
+	\
+	(res) = __quot; \
+	__mod; })
+
+#define do_div(n, base) ({ \
+	unsigned long long __quot; \
+	unsigned long __upper, __low, __high, __mod; \
+	\
+	__quot = (n); \
+	__high = __quot >> 32; \
+	__low = __quot; \
+	__upper = __high; \
+	\
+	if (__high) \
+		__asm__("divu	$0,%z2,%z3" \
+			: "=h" (__upper), "=l" (__high) \
+			: "Jr" (__high), "Jr" (base)); \
+	\
+	__mod = do_div64_32(__low, __upper, __low, base); \
+	\
+	__quot = __high; \
+	__quot = __quot << 32 | __low; \
+	(n) = __quot; \
+	__mod; })
+
+#else
+
+#define do_div64_32(res, high, low, base) ({ \
+	unsigned long __quot, __mod, __r0; \
+	\
+	__asm__("dsll32	%2,%z3,0\n\t" \
+		"or	%2,%2,%z4\n\t" \
+		"ddivu	$0,%2,%z5" \
+		: "=h" (__mod), "=l" (__quot), "=&r" (__r0) \
+		: "Jr" (high), "Jr" (low), "Jr" (base)); \
+	\
+	(res) = __quot; \
+	__mod; })
+
+#define do_div(n, base) ({ \
+	unsigned long long __quot; \
+	unsigned long __mod, __r0; \
+	\
+	__quot = (n); \
+	\
+	__asm__("dsll32	%2,%M3,0\n\t" \
+		"or	%2,%2,%L3\n\t" \
+		"ddivu	$0,%2,%z4\n\t" \
+		"mflo	%L1\n\t" \
+		"dsra32	%M1,%L1,0\n\t" \
+		"dsll32	%L1,%L1,0\n\t" \
+		"dsra32	%L1,%L1,0" \
+		: "=h" (__mod), "=r" (__quot), "=&r" (__r0) \
+		: "r" (n), "Jr" (base)); \
+	\
+	(n) = __quot; \
+	__mod; })
+
+#endif
 
 #endif /* _ASM_DIV64_H */
