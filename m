Received:  by oss.sgi.com id <S42442AbQJBLs3>;
	Mon, 2 Oct 2000 04:48:29 -0700
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:45527 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S42232AbQJBLsH>;
	Mon, 2 Oct 2000 04:48:07 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA09173;
	Mon, 2 Oct 2000 13:46:09 +0200 (MET DST)
Date:   Mon, 2 Oct 2000 13:46:08 +0200 (MET DST)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Florian Lohoff <flo@rfc822.org>
cc:     Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: Decstation broken Was: CVS Update@oss.sgi.com: linux
In-Reply-To: <20000929222227.C396@paradigm.rfc822.org>
Message-ID: <Pine.GSO.3.96.1001002134003.6563G-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, 29 Sep 2000, Florian Lohoff wrote:

> >>boot
> 1532656+0+141200
> This DECstation is a DS5000/1xx
> Loading R[23]00 MMU routines.
> CPU revision is: 00000230
> Primary instruction cache 64kb, linesize 4 bytes
> Primary data cache 64kb, linesize 4 bytes
> Linux version 2.4.0-test8-pre1 (flo@slimer.rfc822.org) (gcc version egcs-2.90.29 980515 (egcs-1.0.3 release)) #1 Fri Sep 29 20:09:51 GMT 2000
> On node 0 totalpages: 4096
> zone(0): 4096 pages.
> zone(1): 0 pages.
> zone(2): 0 pages.
> Kernel command line: console=ttyS2 root=/dev/sda1
> Calibrating delay loop... 

 I've looked through the code thoroughly and I cannot find the point of
failure.  Please try the following patch and report the addresses that get
printed after "dec_irq_setup".

 What versions of tools do you use?  Could you please provide me a
preprocessed copy of int-handler.S and a copy of int-handler.o?

 Thanks,

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

diff -u --recursive --new-file linux-mips-2.4.0-test8-20000829.macro/arch/mips/dec/setup.c linux-mips-2.4.0-test8-20000829/arch/mips/dec/setup.c
--- linux-mips-2.4.0-test8-20000829.macro/arch/mips/dec/setup.c	Sat Sep 30 16:33:17 2000
+++ linux-mips-2.4.0-test8-20000829/arch/mips/dec/setup.c	Sat Sep 30 17:32:26 2000
@@ -27,6 +27,8 @@
 #include <asm/dec/ioasic_addrs.h>
 #include <asm/dec/ioasic_ints.h>
 
+#define IOASIC_DEBUG
+
 extern asmlinkage void decstation_handle_int(void);
 
 void dec_init_kn01(void);
@@ -98,6 +100,13 @@
 	break;
     }
     set_except_vector(0, decstation_handle_int);
+#ifdef IOASIC_DEBUG
+    printk("dec_irq_setup: MMIO addresses:\n");
+    printk("I/O ASIC base: %p\n", ioasic_base);
+    printk("I/O ASIC SIR : %p\n", isr);
+    printk("I/O ASIC SIMR: %p\n", imr);
+    printk("RTC base     : %p\n", dec_rtc_base);
+#endif
 }
 
 /*
diff -u --recursive --new-file linux-mips-2.4.0-test8-20000829.macro/arch/mips/dec/time.c linux-mips-2.4.0-test8-20000829/arch/mips/dec/time.c
--- linux-mips-2.4.0-test8-20000829.macro/arch/mips/dec/time.c	Sat Sep 30 16:34:12 2000
+++ linux-mips-2.4.0-test8-20000829/arch/mips/dec/time.c	Sat Sep 30 17:52:30 2000
@@ -31,6 +31,8 @@
 
 #include <asm/div64.h>
 
+#define R4K_DEBUG
+
 extern volatile unsigned long wall_jiffies;
 extern rwlock_t xtime_lock;
 
@@ -548,11 +550,16 @@
 
 	init_cycle_counter();
 
+#ifndef R4K_DEBUG
 	if (cyclecounter_available) {
+		printk("time_init: using CP0.COUNT for do_gettimeoffset()...\n");
 		write_32bit_cp0_register(CP0_COUNT, 0);
 		do_gettimeoffset = do_fast_gettimeoffset;
 		irq0.handler = r4k_timer_interrupt;
-	} else if (IOASIC) {
+	} else
+#endif
+	if (IOASIC) {
+		printk("time_init: using IOASIC.FCTR for do_gettimeoffset()...\n");
 		ioasic_write(FCTR, 0);
 		do_gettimeoffset = do_ioasic_gettimeoffset;
 		irq0.handler = ioasic_timer_interrupt;
diff -u --recursive --new-file linux-mips-2.4.0-test8-20000829.macro/include/asm-mips/div64.h linux-mips-2.4.0-test8-20000829/include/asm-mips/div64.h
--- linux-mips-2.4.0-test8-20000829.macro/include/asm-mips/div64.h	Sat Aug 26 04:26:45 2000
+++ linux-mips-2.4.0-test8-20000829/include/asm-mips/div64.h	Sat Sep 30 17:47:57 2000
@@ -12,11 +12,14 @@
 
 #include <asm/sgidefs.h>
 
+#define DIV64_DEBUG
+
 /*
  * No traps on overflows for any of these...
  */
 
-#if (_MIPS_ISA == _MIPS_ISA_MIPS1) || (_MIPS_ISA == _MIPS_ISA_MIPS2)
+#if defined(DIV64_DEBUG) || \
+	(_MIPS_ISA == _MIPS_ISA_MIPS1) || (_MIPS_ISA == _MIPS_ISA_MIPS2)
 
 #define do_div64_32(res, high, low, base) ({ \
 	unsigned long __quot, __mod; \
