Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6OFYFRw022223
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 24 Jul 2002 08:34:15 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6OFYFRm022222
	for linux-mips-outgoing; Wed, 24 Jul 2002 08:34:15 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6OFWqRw022211
	for <linux-mips@oss.sgi.com>; Wed, 24 Jul 2002 08:32:53 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA01570;
	Wed, 24 Jul 2002 17:34:21 +0200 (MET DST)
Date: Wed, 24 Jul 2002 17:34:20 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@uni-koblenz.de>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: [patch] wbflush() fixes and updates
Message-ID: <Pine.GSO.3.96.1020724172222.27732I-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-5.0 required=5.0 tests=UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello,

 Here is a follow-on patch to the recent synchronization rewrite.  It
converts a few of wbflush() references to iob() (functionally equivalent,
but with a somewhat more consistent naming) and it removes a few
unnecessary private __wbflush() implementations (that now are covered by
the generic code).  Finally, it fixes the DECstation __wbflush() 
implementation to match hardware reality. 

 OK to apply?

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.19-rc1-20020719-wbflush-9
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020719.macro/arch/mips/au1000/pb1000/setup.c linux-mips-2.4.19-rc1-20020719/arch/mips/au1000/pb1000/setup.c
--- linux-mips-2.4.19-rc1-20020719.macro/arch/mips/au1000/pb1000/setup.c	2002-07-05 02:57:37.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020719/arch/mips/au1000/pb1000/setup.c	2002-07-23 21:25:22.000000000 +0000
@@ -67,7 +67,6 @@ extern struct ide_ops std_ide_ops;
 extern struct ide_ops *ide_ops;
 #endif
 
-void (*__wbflush) (void);
 extern struct rtc_ops no_rtc_ops;
 extern char * __init prom_getcmdline(void);
 extern void au1000_restart(char *);
@@ -78,11 +77,6 @@ extern struct resource iomem_resource;
 
 void __init bus_error_init(void) { /* nothing */ }
 
-void au1000_wbflush(void)
-{
-	__asm__ volatile ("sync");
-}
-
 void __init au1000_setup(void)
 {
 	char *argptr;
@@ -103,7 +97,6 @@ void __init au1000_setup(void)
 #endif	  
 
 	rtc_ops = &no_rtc_ops;
-        __wbflush = au1000_wbflush;
 	_machine_restart = au1000_restart;
 	_machine_halt = au1000_halt;
 	_machine_power_off = au1000_power_off;
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020719.macro/arch/mips/au1000/pb1100/setup.c linux-mips-2.4.19-rc1-20020719/arch/mips/au1000/pb1100/setup.c
--- linux-mips-2.4.19-rc1-20020719.macro/arch/mips/au1000/pb1100/setup.c	2002-07-14 21:20:57.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020719/arch/mips/au1000/pb1100/setup.c	2002-07-23 21:25:56.000000000 +0000
@@ -71,7 +71,6 @@ extern struct ide_ops *ide_ops;
 extern struct rtc_ops pb1500_rtc_ops;
 #endif
 
-void (*__wbflush) (void);
 extern char * __init prom_getcmdline(void);
 extern void au1000_restart(char *);
 extern void au1000_halt(void);
@@ -80,11 +79,6 @@ extern struct resource ioport_resource;
 extern struct resource iomem_resource;
 
 
-void au1100_wbflush(void)
-{
-	__asm__ volatile ("sync");
-}
-
 void __init bus_error_init(void) { /* nothing */ }
 
 void __init au1100_setup(void)
@@ -112,7 +106,6 @@ void __init au1100_setup(void)
 	argptr = prom_getcmdline();
 #endif
 
-        __wbflush = au1100_wbflush;
 	_machine_restart = au1000_restart;
 	_machine_halt = au1000_halt;
 	_machine_power_off = au1000_power_off;
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020719.macro/arch/mips/au1000/pb1500/setup.c linux-mips-2.4.19-rc1-20020719/arch/mips/au1000/pb1500/setup.c
--- linux-mips-2.4.19-rc1-20020719.macro/arch/mips/au1000/pb1500/setup.c	2002-07-15 02:57:11.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020719/arch/mips/au1000/pb1500/setup.c	2002-07-23 21:26:24.000000000 +0000
@@ -71,7 +71,6 @@ extern struct ide_ops *ide_ops;
 extern struct rtc_ops pb1500_rtc_ops;
 #endif
 
-void (*__wbflush) (void);
 extern char * __init prom_getcmdline(void);
 extern void au1000_restart(char *);
 extern void au1000_halt(void);
@@ -82,11 +81,6 @@ extern struct resource iomem_resource;
 
 void __init bus_error_init(void) { /* nothing */ }
 
-void au1500_wbflush(void)
-{
-	__asm__ volatile ("sync");
-}
-
 void __init au1500_setup(void)
 {
 	char *argptr;
@@ -112,7 +106,6 @@ void __init au1500_setup(void)
 	argptr = prom_getcmdline();
 #endif
 
-        __wbflush = au1500_wbflush;
 	_machine_restart = au1000_restart;
 	_machine_halt = au1000_halt;
 	_machine_power_off = au1000_power_off;
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020719.macro/arch/mips/baget/Makefile linux-mips-2.4.19-rc1-20020719/arch/mips/baget/Makefile
--- linux-mips-2.4.19-rc1-20020719.macro/arch/mips/baget/Makefile	2001-01-11 05:25:50.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020719/arch/mips/baget/Makefile	2002-07-23 21:27:40.000000000 +0000
@@ -14,7 +14,7 @@ O_TARGET := baget.a
 
 export-objs		:= vacserial.o vacrtc.o
 obj-y			:= baget.o print.o setup.o time.o irq.o bagetIRQ.o \
-			   reset.o wbflush.o
+			   reset.o
 obj-$(CONFIG_SERIAL)	+= vacserial.o
 obj-$(CONFIG_VAC_RTC)	+= vacrtc.o
 
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020719.macro/arch/mips/baget/wbflush.c linux-mips-2.4.19-rc1-20020719/arch/mips/baget/wbflush.c
--- linux-mips-2.4.19-rc1-20020719.macro/arch/mips/baget/wbflush.c	2000-03-28 04:26:02.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020719/arch/mips/baget/wbflush.c	1970-01-01 00:00:00.000000000 +0000
@@ -1,24 +0,0 @@
-/*
- * Setup the right wbflush routine for Baget/MIPS.
- *
- * Copyright (C) 1999 Gleb Raiko & Vladimir Roganov
- */
-
-#include <linux/init.h>
-#include <asm/bootinfo.h>
-
-void (*__wbflush) (void);
-
-static void wbflush_baget(void);
-
-void __init wbflush_setup(void)
-{
-	__wbflush = wbflush_baget;
-}
-
-/*
- * Baget/MIPS doesnt need to write back the WB.
- */
-static void wbflush_baget(void)
-{
-}
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020719.macro/arch/mips/dec/Makefile linux-mips-2.4.19-rc1-20020719/arch/mips/dec/Makefile
--- linux-mips-2.4.19-rc1-20020719.macro/arch/mips/dec/Makefile	2002-06-26 03:04:35.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020719/arch/mips/dec/Makefile	2002-07-21 18:11:04.000000000 +0000
@@ -14,9 +14,10 @@ all: dec.o
 
 export-objs := setup.o wbflush.o
 obj-y	 := int-handler.o ioasic-irq.o kn02-irq.o reset.o rtc-dec.o setup.o \
-	time.o wbflush.o
+	time.o
 
 obj-$(CONFIG_PROM_CONSOLE)	+= promcon.o
+obj-$(CONFIG_CPU_HAS_WB)	+= wbflush.o
 
 int-handler.o:	int-handler.S
 
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020719.macro/arch/mips/dec/ioasic-irq.c linux-mips-2.4.19-rc1-20020719/arch/mips/dec/ioasic-irq.c
--- linux-mips-2.4.19-rc1-20020719.macro/arch/mips/dec/ioasic-irq.c	2002-04-09 02:27:12.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020719/arch/mips/dec/ioasic-irq.c	2002-04-16 20:53:43.000000000 +0000
@@ -84,6 +84,7 @@ static inline void ack_ioasic_irq(unsign
 	spin_lock(&ioasic_lock);
 	mask_ioasic_irq(irq);
 	spin_unlock(&ioasic_lock);
+	fast_iob();
 }
 
 static inline void end_ioasic_irq(unsigned int irq)
@@ -119,6 +120,7 @@ static struct hw_interrupt_type ioasic_i
 static inline void end_ioasic_dma_irq(unsigned int irq)
 {
 	clear_ioasic_irq(irq);
+	fast_iob();
 	end_ioasic_irq(irq);
 }
 
@@ -142,6 +144,7 @@ void __init init_ioasic_irqs(int base)
 
 	/* Mask interrupts. */
 	ioasic_write(SIMR, 0);
+	fast_iob();
 
 	for (i = base; i < base + IO_INR_DMA; i++) {
 		irq_desc[i].status = IRQ_DISABLED;
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020719.macro/arch/mips/dec/kn02-irq.c linux-mips-2.4.19-rc1-20020719/arch/mips/dec/kn02-irq.c
--- linux-mips-2.4.19-rc1-20020719.macro/arch/mips/dec/kn02-irq.c	2002-04-09 02:27:12.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020719/arch/mips/dec/kn02-irq.c	2002-04-16 20:53:43.000000000 +0000
@@ -83,6 +83,7 @@ static void ack_kn02_irq(unsigned int ir
 	spin_lock(&kn02_lock);
 	mask_kn02_irq(irq);
 	spin_unlock(&kn02_lock);
+	iob();
 }
 
 static void end_kn02_irq(unsigned int irq)
@@ -113,6 +114,7 @@ void __init init_kn02_irqs(int base)
 	/* Mask interrupts and preset write-only bits. */
 	cached_kn02_csr = (*csr & ~0xff0000) | 0xff;
 	*csr = cached_kn02_csr;
+	iob();
 
 	for (i = base; i < base + KN02_IRQ_LINES; i++) {
 		irq_desc[i].status = IRQ_DISABLED;
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020719.macro/arch/mips/dec/setup.c linux-mips-2.4.19-rc1-20020719/arch/mips/dec/setup.c
--- linux-mips-2.4.19-rc1-20020719.macro/arch/mips/dec/setup.c	2002-07-19 03:01:49.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020719/arch/mips/dec/setup.c	2002-07-21 18:11:04.000000000 +0000
@@ -25,6 +25,7 @@
 #include <asm/mipsregs.h>
 #include <asm/reboot.h>
 #include <asm/traps.h>
+#include <asm/wbflush.h>
 
 #include <asm/dec/interrupts.h>
 #include <asm/dec/kn01.h>
@@ -89,8 +90,6 @@ static struct irqaction fpuirq = {NULL, 
 static struct irqaction haltirq = {dec_intr_halt, 0, 0, "halt", NULL, NULL};
 
 
-extern void wbflush_setup(void);
-
 extern struct rtc_ops dec_rtc_ops;
 
 void (*board_time_init) (struct irqaction * irq);
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020719.macro/arch/mips/dec/wbflush.c linux-mips-2.4.19-rc1-20020719/arch/mips/dec/wbflush.c
--- linux-mips-2.4.19-rc1-20020719.macro/arch/mips/dec/wbflush.c	2001-11-06 05:26:15.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020719/arch/mips/dec/wbflush.c	2002-02-04 01:03:17.000000000 +0000
@@ -11,15 +11,18 @@
  * for more details.
  *
  * Copyright (C) 1998 Harald Koerfgen
+ * Copyright (C) 2002 Maciej W. Rozycki
  */
 
-#include <asm/bootinfo.h>
 #include <linux/init.h>
 
+#include <asm/bootinfo.h>
+#include <asm/system.h>
+#include <asm/wbflush.h>
+
 static void wbflush_kn01(void);
 static void wbflush_kn210(void);
-static void wbflush_kn02ba(void);
-static void wbflush_kn03(void);
+static void wbflush_mips(void);
 
 void (*__wbflush) (void);
 
@@ -27,28 +30,23 @@ void __init wbflush_setup(void)
 {
 	switch (mips_machtype) {
 	case MACH_DS23100:
-	    __wbflush = wbflush_kn01;
-	    break;
-	case MACH_DS5100:	/*  DS5100 MIPSMATE */
-	    __wbflush = wbflush_kn210;
-	    break;
 	case MACH_DS5000_200:	/* DS5000 3max */
-	    __wbflush = wbflush_kn01;
-	    break;
+		__wbflush = wbflush_kn01;
+		break;
+	case MACH_DS5100:	/* DS5100 MIPSMATE */
+		__wbflush = wbflush_kn210;
+		break;
 	case MACH_DS5000_1XX:	/* DS5000/100 3min */
-	    __wbflush = wbflush_kn02ba;
-	    break;
-	case MACH_DS5000_2X0:	/* DS5000/240 3max+ */
-	    __wbflush = wbflush_kn03;
-	    break;
 	case MACH_DS5000_XX:	/* Personal DS5000/2x */
-	    __wbflush = wbflush_kn02ba;
-	    break;
+	case MACH_DS5000_2X0:	/* DS5000/240 3max+ */
+	default:
+		__wbflush = wbflush_mips;
+		break;
 	}
 }
 
 /*
- * For the DS3100 and DS5000/200 the writeback buffer functions
+ * For the DS3100 and DS5000/200 the R2020/R3220 writeback buffer functions
  * as part of Coprocessor 0.
  */
 static void wbflush_kn01(void)
@@ -78,29 +76,16 @@ static void wbflush_kn210(void)
 	"mtc0\t$2,$12\n\t"
 	"nop\n\t"
 	".set\tpop"
-  : : :"$2", "$3");
-}
-
-/*
- * Looks like some magic with the System Interrupt Mask Register
- * in the famous IOASIC for kmins and maxines.
- */
-static void wbflush_kn02ba(void)
-{
-    asm(".set\tpush\n\t"
-	".set\tnoreorder\n\t"
-	"lui\t$2,0xbc04\n\t"
-	"lw\t$3,0x120($2)\n\t"
-	"lw\t$3,0x120($2)\n\t"
-	".set\tpop"
-  : : :"$2", "$3");
+	: : : "$2", "$3");
 }
 
 /*
- * The DS500/2x0 doesnt need to write back the WB.
+ * I/O ASIC systems use a standard writeback buffer that gets flushed
+ * upon an uncached read.
  */
-static void wbflush_kn03(void)
+static void wbflush_mips(void)
 {
+	__fast_iob();
 }
 
 #include <linux/module.h>
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020719.macro/arch/mips/galileo-boards/ev96100/setup.c linux-mips-2.4.19-rc1-20020719/arch/mips/galileo-boards/ev96100/setup.c
--- linux-mips-2.4.19-rc1-20020719.macro/arch/mips/galileo-boards/ev96100/setup.c	2001-11-26 05:25:59.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020719/arch/mips/galileo-boards/ev96100/setup.c	2002-07-23 21:30:52.000000000 +0000
@@ -52,8 +52,6 @@
 #include <asm/galileo-boards/ev96100int.h>
 
 
-void (*__wbflush) (void);
-
 #if defined(CONFIG_SERIAL_CONSOLE) || defined(CONFIG_PROM_CONSOLE)
 extern void console_setup(char *, int *);
 char serial_console[20];
@@ -65,11 +63,6 @@ extern void mips_reboot_setup(void);
 extern struct rtc_ops no_rtc_ops;
 extern struct resource ioport_resource;
 
-static void rm7000_wbflush(void)
-{
-	 __asm__ __volatile__ ("sync");
-}
-
 unsigned char mac_0_1[12];
 
 
@@ -83,7 +76,6 @@ void __init ev96100_setup(void)
 	char *argptr;
 
 	clear_cp0_status(ST0_FR);
-        __wbflush = rm7000_wbflush;
 
         if (config & 0x8) {
             printk("Secondary cache is enabled\n");
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020719.macro/arch/mips/mm/c-r3k.c linux-mips-2.4.19-rc1-20020719/arch/mips/mm/c-r3k.c
--- linux-mips-2.4.19-rc1-20020719.macro/arch/mips/mm/c-r3k.c	2002-02-19 05:28:14.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020719/arch/mips/mm/c-r3k.c	2002-03-24 21:16:14.000000000 +0000
@@ -19,7 +19,6 @@
 #include <asm/system.h>
 #include <asm/isadep.h>
 #include <asm/io.h>
-#include <asm/wbflush.h>
 #include <asm/bootinfo.h>
 #include <asm/cpu.h>
 
@@ -314,7 +313,7 @@ static void r3k_flush_cache_sigtramp(uns
 
 static void r3k_dma_cache_wback_inv(unsigned long start, unsigned long size)
 {
-	wbflush();
+	iob();
 	r3k_flush_dcache_range(start, start + size);
 }
 
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020719.macro/arch/mips/mm/c-tx39.c linux-mips-2.4.19-rc1-20020719/arch/mips/mm/c-tx39.c
--- linux-mips-2.4.19-rc1-20020719.macro/arch/mips/mm/c-tx39.c	2001-12-01 05:26:01.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020719/arch/mips/mm/c-tx39.c	2002-02-04 01:12:41.000000000 +0000
@@ -20,7 +20,6 @@
 #include <asm/system.h>
 #include <asm/isadep.h>
 #include <asm/io.h>
-#include <asm/wbflush.h>
 #include <asm/bootinfo.h>
 #include <asm/cpu.h>
 
@@ -63,8 +62,8 @@ static void tx39h_flush_icache_all(void)
 static void tx39h_dma_cache_wback_inv(unsigned long addr, unsigned long size)
 {
 	unsigned long end, a;
-	wbflush();
 
+	iob();
 	a = addr & ~(dcache_lsize - 1);
 	end = (addr + size) & ~(dcache_lsize - 1);
 	while (1) {
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020719.macro/arch/mips/mm/tlb-r3k.c linux-mips-2.4.19-rc1-20020719/arch/mips/mm/tlb-r3k.c
--- linux-mips-2.4.19-rc1-20020719.macro/arch/mips/mm/tlb-r3k.c	2002-05-30 02:57:46.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020719/arch/mips/mm/tlb-r3k.c	2002-06-15 15:38:41.000000000 +0000
@@ -20,7 +20,6 @@
 #include <asm/system.h>
 #include <asm/isadep.h>
 #include <asm/io.h>
-#include <asm/wbflush.h>
 #include <asm/bootinfo.h>
 #include <asm/cpu.h>
 
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020719.macro/drivers/char/dz.c linux-mips-2.4.19-rc1-20020719/drivers/char/dz.c
--- linux-mips-2.4.19-rc1-20020719.macro/drivers/char/dz.c	2002-06-27 02:58:15.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020719/drivers/char/dz.c	2002-07-21 18:11:04.000000000 +0000
@@ -35,7 +35,6 @@
 #include <linux/param.h>
 #include <linux/tqueue.h>
 #include <linux/interrupt.h>
-#include <asm-mips/wbflush.h>
 #include <asm/dec/interrupts.h>
 
 #include <linux/console.h>
@@ -53,6 +52,8 @@
 #include <linux/fs.h>
 #include <asm/bootinfo.h>
 
+#include <asm/system.h>
+
 #define CONSOLE_LINE (3)	/* for definition of struct console */
 
 extern int (*prom_printf) (char *,...);
@@ -1415,7 +1416,7 @@ int __init dz_init(void)
 #ifndef CONFIG_SERIAL_CONSOLE
 	dz_out(info, DZ_CSR, DZ_CLR);
 	while ((tmp = dz_in(info, DZ_CSR)) & DZ_CLR);
-	wbflush();
+	iob();
 
 	/* enable scanning */
 	dz_out(info, DZ_CSR, DZ_MSE);
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020719.macro/drivers/net/declance.c linux-mips-2.4.19-rc1-20020719/drivers/net/declance.c
--- linux-mips-2.4.19-rc1-20020719.macro/drivers/net/declance.c	2002-07-08 16:46:24.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020719/drivers/net/declance.c	2002-07-21 18:11:05.000000000 +0000
@@ -62,7 +62,7 @@
 #include <asm/dec/kn01.h>
 #include <asm/dec/machtype.h>
 #include <asm/dec/tc.h>
-#include <asm/wbflush.h>
+#include <asm/system.h>
 
 static char version[] __devinitdata =
 "declance.c: v0.009 by Linux MIPS DECstation task force\n";
@@ -289,7 +289,7 @@ static struct net_device *root_lance_dev
 static inline void writereg(volatile unsigned short *regptr, short value)
 {
 	*regptr = value;
-	wbflush();
+	iob();
 }
 
 /* Load the CSR registers */
@@ -369,7 +369,7 @@ void cp_to_buf(const int type, void *to,
 		}
 	}
 
-	wbflush();
+	iob();
 }
 
 void cp_from_buf(const int type, void *to, const void *from, int len)
@@ -497,7 +497,7 @@ static void lance_init_ring(struct net_d
 		if (i < 3 && ZERO)
 			printk("%d: 0x%8.8x(0x%8.8x)\n", i, leptr, (int) lp->rx_buf_ptr_cpu[i]);
 	}
-	wbflush();
+	iob();
 }
 
 static int init_restart_lance(struct lance_private *lp)
@@ -794,7 +794,7 @@ static int lance_open(struct net_device 
 			return -EAGAIN;
 		}
 		/* Enable I/O ASIC LANCE DMA.  */
-		wbflush();
+		fast_wmb();
 		ioasic_write(SSR, ioasic_read(SSR) | LANCE_DMA_EN);
 	}
 
@@ -823,7 +823,7 @@ static int lance_close(struct net_device
 	if (lp->dma_irq >= 0) {
 		/* Disable I/O ASIC LANCE DMA.  */
 		ioasic_write(SSR, ioasic_read(SSR) & ~LANCE_DMA_EN);
-		wbflush();
+		fast_iob();
 		free_irq(lp->dma_irq, dev);
 	}
 	free_irq(dev->irq, dev);
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020719.macro/drivers/scsi/NCR53C9x.h linux-mips-2.4.19-rc1-20020719/drivers/scsi/NCR53C9x.h
--- linux-mips-2.4.19-rc1-20020719.macro/drivers/scsi/NCR53C9x.h	2001-10-19 04:29:11.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020719/drivers/scsi/NCR53C9x.h	2002-02-04 01:14:34.000000000 +0000
@@ -144,12 +144,7 @@
 
 #ifndef MULTIPLE_PAD_SIZES
 
-#ifdef CONFIG_CPU_HAS_WB
-#include <asm/wbflush.h>
-#define esp_write(__reg, __val) do{(__reg) = (__val); wbflush();} while(0)
-#else
-#define esp_write(__reg, __val) ((__reg) = (__val))
-#endif
+#define esp_write(__reg, __val) do{(__reg) = (__val); iob();} while(0)
 #define esp_read(__reg) (__reg)
 
 struct ESP_regs {
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020719.macro/drivers/scsi/dec_esp.c linux-mips-2.4.19-rc1-20020719/drivers/scsi/dec_esp.c
--- linux-mips-2.4.19-rc1-20020719.macro/drivers/scsi/dec_esp.c	2002-04-10 02:58:49.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020719/drivers/scsi/dec_esp.c	2002-07-21 18:12:55.000000000 +0000
@@ -46,6 +46,8 @@
 #include <asm/dec/ioasic_ints.h>
 #include <asm/dec/machtype.h>
 
+#include <asm/system.h>
+
 /*
  * Once upon a time the pmaz code used to be working but
  * it hasn't been maintained for quite some time.
@@ -308,17 +310,9 @@ static void scsi_dma_err_int(int irq, vo
 
 static void scsi_dma_int(int irq, void *dev_id, struct pt_regs *regs)
 {
-	volatile unsigned int *dummy = (volatile unsigned int *)KSEG1;
-
 	/* next page */
 	*scsi_next_ptr = ((*scsi_dma_ptr + PAGE_SIZE) & PAGE_MASK) << 3;
-
-	/*
-	 * This routine will only work on IOASIC machines
-	 * so we can avoid an indirect function call here
-	 * and flush the writeback buffer the fast way
-	 */
-	*dummy;
+	fast_iob();
 }
 
 static int dma_bytes_sent(struct NCR_ESP *esp, int fifo_count)
@@ -370,8 +364,6 @@ static void dma_dump_state(struct NCR_ES
 
 static void dma_init_read(struct NCR_ESP *esp, __u32 vaddress, int length)
 {
-	volatile unsigned int *dummy = (volatile unsigned int *)KSEG1;
-
 	if (vaddress & 3)
 		panic("dec_efs.c: unable to handle partial word transfers, yet...");
 
@@ -384,17 +376,11 @@ static void dma_init_read(struct NCR_ESP
 	/* prepare for next page */
 	*scsi_next_ptr = ((vaddress + PAGE_SIZE) & PAGE_MASK) << 3;
 	*ioasic_ssr |= (SCSI_DMA_DIR | SCSI_DMA_EN);
-
-	/*
-	 * see above
-	 */
-	*dummy;
+	fast_iob();
 }
 
 static void dma_init_write(struct NCR_ESP *esp, __u32 vaddress, int length)
 {
-	volatile unsigned int *dummy = (volatile unsigned int *)KSEG1;
-
 	if (vaddress & 3)
 		panic("dec_efs.c: unable to handle partial word transfers, yet...");
 
@@ -407,11 +393,7 @@ static void dma_init_write(struct NCR_ES
 	/* prepare for next page */
 	*scsi_next_ptr = ((vaddress + PAGE_SIZE) & PAGE_MASK) << 3;
 	*ioasic_ssr |= SCSI_DMA_EN;
-
-	/*
-	 * see above
-	 */
-	*dummy;
+	fast_iob();
 }
 
 static void dma_ints_off(struct NCR_ESP *esp)
@@ -492,6 +474,8 @@ static void pmaz_dma_init_read(struct NC
 
 	*dmareg = TC_ESP_DMA_ADDR(esp->slot + DEC_SCSI_SRAM + ESP_TGT_DMA_SIZE);
 
+	iob();
+
 	esp_virt_buffer = vaddress;
 	scsi_current_length = length;
 }
@@ -506,6 +490,7 @@ static void pmaz_dma_init_write(struct N
 	*dmareg = TC_ESP_DMAR_WRITE | 
 		TC_ESP_DMA_ADDR(esp->slot + DEC_SCSI_SRAM + ESP_TGT_DMA_SIZE);
 
+	iob();
 }
 
 static void pmaz_dma_ints_off(struct NCR_ESP *esp)
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020719.macro/drivers/tc/zs.c linux-mips-2.4.19-rc1-20020719/drivers/tc/zs.c
--- linux-mips-2.4.19-rc1-20020719.macro/drivers/tc/zs.c	2002-06-27 02:59:46.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020719/drivers/tc/zs.c	2002-07-21 18:11:05.000000000 +0000
@@ -67,7 +67,6 @@
 #include <asm/segment.h>
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
-#include <asm/wbflush.h>
 #include <asm/bootinfo.h>
 #ifdef CONFIG_DECSTATION
 #include <asm/dec/interrupts.h>
@@ -276,7 +275,7 @@ static inline unsigned char read_zsreg(s
 
 	if (reg != 0) {
 		*channel->control = reg & 0xf;
-		wbflush(); RECOVERY_DELAY;
+		fast_iob(); RECOVERY_DELAY;
 	}
 	retval = *channel->control;
 	RECOVERY_DELAY;
@@ -288,10 +287,10 @@ static inline void write_zsreg(struct de
 {
 	if (reg != 0) {
 		*channel->control = reg & 0xf;
-		wbflush(); RECOVERY_DELAY;
+		fast_iob(); RECOVERY_DELAY;
 	}
 	*channel->control = value;
-	wbflush(); RECOVERY_DELAY;
+	fast_iob(); RECOVERY_DELAY;
 	return;
 }
 
@@ -308,7 +307,7 @@ static inline void write_zsdata(struct d
 				unsigned char value)
 {
 	*channel->data = value;
-	wbflush(); RECOVERY_DELAY;
+	fast_iob(); RECOVERY_DELAY;
 	return;
 }
 
