Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g38HRK8d031456
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 8 Apr 2002 10:27:20 -0700
Received: (from mail@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g38HRKgD031455
	for linux-mips-outgoing; Mon, 8 Apr 2002 10:27:20 -0700
X-Authentication-Warning: oss.sgi.com: mail set sender to owner-linux-mips@oss.sgi.com using -f
Received: from sgi.com (sgi-too.SGI.COM [204.94.211.39])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g38HQP8d031450
	for <linux-mips@oss.sgi.com>; Mon, 8 Apr 2002 10:26:25 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA04903
	for <linux-mips@oss.sgi.com>; Mon, 8 Apr 2002 10:27:00 -0700 (PDT)
	mail_from (macro@ds2.pg.gda.pl)
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA08974;
	Mon, 8 Apr 2002 19:16:06 +0200 (MET DST)
Date: Mon, 8 Apr 2002 19:16:05 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@uni-koblenz.de>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: [patch] linux: A wbflush() rework
Message-ID: <Pine.GSO.3.96.1020408190651.26107K-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello,

 Here is a rework of the wbflush() that makes code use iob() and possibly
fast_iob() where appropriate.  Additionally the DECstation __wbflush() 
backends are updated to match reality, yielding better and reliability
performance for I/O ASIC systems.  The code is needed specifically for R4k
not to generate an excessive number of spurious interrupts on DECstation. 

 The code applies on top of the "mb-wb" and "irq" patches. 

 Please apply.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.18-20020323-wbflush-3
diff -up --recursive --new-file linux-mips-2.4.18-20020323.macro/arch/mips/dec/Makefile linux-mips-2.4.18-20020323/arch/mips/dec/Makefile
--- linux-mips-2.4.18-20020323.macro/arch/mips/dec/Makefile	Tue Jan 22 07:32:00 2002
+++ linux-mips-2.4.18-20020323/arch/mips/dec/Makefile	Mon Feb  4 01:06:32 2002
@@ -17,9 +17,10 @@ all: dec.o
 
 export-objs := setup.o wbflush.o
 obj-y	 := int-handler.o ioasic-irq.o kn02-irq.o reset.o rtc-dec.o setup.o \
-	time.o wbflush.o
+	time.o
 
 obj-$(CONFIG_PROM_CONSOLE)	+= promcon.o
+obj-$(CONFIG_CPU_HAS_WB)	+= wbflush.o
 
 int-handler.o:	int-handler.S
 
diff -up --recursive --new-file linux-mips-2.4.18-20020323.macro/arch/mips/dec/ioasic-irq.c linux-mips-2.4.18-20020323/arch/mips/dec/ioasic-irq.c
--- linux-mips-2.4.18-20020323.macro/arch/mips/dec/ioasic-irq.c	Tue Jan 22 06:44:47 2002
+++ linux-mips-2.4.18-20020323/arch/mips/dec/ioasic-irq.c	Mon Feb  4 01:00:53 2002
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
diff -up --recursive --new-file linux-mips-2.4.18-20020323.macro/arch/mips/dec/kn02-irq.c linux-mips-2.4.18-20020323/arch/mips/dec/kn02-irq.c
--- linux-mips-2.4.18-20020323.macro/arch/mips/dec/kn02-irq.c	Tue Jan 22 06:47:34 2002
+++ linux-mips-2.4.18-20020323/arch/mips/dec/kn02-irq.c	Mon Feb  4 01:01:59 2002
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
diff -up --recursive --new-file linux-mips-2.4.18-20020323.macro/arch/mips/dec/setup.c linux-mips-2.4.18-20020323/arch/mips/dec/setup.c
--- linux-mips-2.4.18-20020323.macro/arch/mips/dec/setup.c	Tue Jan 22 07:31:08 2002
+++ linux-mips-2.4.18-20020323/arch/mips/dec/setup.c	Mon Feb  4 01:10:36 2002
@@ -24,6 +24,7 @@
 #include <asm/irq_cpu.h>
 #include <asm/mipsregs.h>
 #include <asm/reboot.h>
+#include <asm/wbflush.h>
 
 #include <asm/dec/interrupts.h>
 #include <asm/dec/kn01.h>
@@ -87,8 +88,6 @@ static struct irqaction fpuirq = {NULL, 
 
 static struct irqaction haltirq = {dec_intr_halt, 0, 0, "halt", NULL, NULL};
 
-
-extern void wbflush_setup(void);
 
 extern struct rtc_ops dec_rtc_ops;
 
diff -up --recursive --new-file linux-mips-2.4.18-20020323.macro/arch/mips/dec/wbflush.c linux-mips-2.4.18-20020323/arch/mips/dec/wbflush.c
--- linux-mips-2.4.18-20020323.macro/arch/mips/dec/wbflush.c	Tue Nov  6 05:26:15 2001
+++ linux-mips-2.4.18-20020323/arch/mips/dec/wbflush.c	Mon Feb  4 01:03:17 2002
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
diff -up --recursive --new-file linux-mips-2.4.18-20020323.macro/arch/mips/mm/c-r3k.c linux-mips-2.4.18-20020323/arch/mips/mm/c-r3k.c
--- linux-mips-2.4.18-20020323.macro/arch/mips/mm/c-r3k.c	Tue Feb 19 05:28:14 2002
+++ linux-mips-2.4.18-20020323/arch/mips/mm/c-r3k.c	Sun Mar 24 21:16:14 2002
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
 
diff -up --recursive --new-file linux-mips-2.4.18-20020323.macro/arch/mips/mm/c-tx39.c linux-mips-2.4.18-20020323/arch/mips/mm/c-tx39.c
--- linux-mips-2.4.18-20020323.macro/arch/mips/mm/c-tx39.c	Sat Dec  1 05:26:01 2001
+++ linux-mips-2.4.18-20020323/arch/mips/mm/c-tx39.c	Mon Feb  4 01:12:41 2002
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
diff -up --recursive --new-file linux-mips-2.4.18-20020323.macro/arch/mips/mm/tlb-r3k.c linux-mips-2.4.18-20020323/arch/mips/mm/tlb-r3k.c
--- linux-mips-2.4.18-20020323.macro/arch/mips/mm/tlb-r3k.c	Fri Jan 18 05:28:05 2002
+++ linux-mips-2.4.18-20020323/arch/mips/mm/tlb-r3k.c	Mon Feb  4 00:59:46 2002
@@ -19,7 +19,6 @@
 #include <asm/system.h>
 #include <asm/isadep.h>
 #include <asm/io.h>
-#include <asm/wbflush.h>
 #include <asm/bootinfo.h>
 #include <asm/cpu.h>
 
diff -up --recursive --new-file linux-mips-2.4.18-20020323.macro/drivers/char/dz.c linux-mips-2.4.18-20020323/drivers/char/dz.c
--- linux-mips-2.4.18-20020323.macro/drivers/char/dz.c	Sun Jan 20 21:37:53 2002
+++ linux-mips-2.4.18-20020323/drivers/char/dz.c	Mon Feb  4 01:13:30 2002
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
@@ -1420,7 +1421,7 @@ int __init dz_init(void)
 #ifndef CONFIG_SERIAL_CONSOLE
 	dz_out(info, DZ_CSR, DZ_CLR);
 	while ((tmp = dz_in(info, DZ_CSR)) & DZ_CLR);
-	wbflush();
+	iob();
 
 	/* enable scanning */
 	dz_out(info, DZ_CSR, DZ_MSE);
diff -up --recursive --new-file linux-mips-2.4.18-20020323.macro/drivers/net/declance.c linux-mips-2.4.18-20020323/drivers/net/declance.c
--- linux-mips-2.4.18-20020323.macro/drivers/net/declance.c	Sun Mar 24 20:58:18 2002
+++ linux-mips-2.4.18-20020323/drivers/net/declance.c	Sun Mar 24 21:16:14 2002
@@ -60,7 +60,7 @@ static char *lancestr = "lance";
 #include <asm/dec/machtype.h>
 #include <asm/dec/tc.h>
 #include <asm/dec/kn01.h>
-#include <asm/wbflush.h>
+#include <asm/system.h>
 #include <asm/addrspace.h>
 
 #include <linux/config.h>
@@ -306,7 +306,7 @@ int dec_lance_debug = 2;
 static inline void writereg(volatile unsigned short *regptr, short value)
 {
 	*regptr = value;
-	wbflush();
+	iob();
 }
 
 /* Load the CSR registers */
@@ -386,7 +386,7 @@ void cp_to_buf(void *to, const void *fro
 		}
 	}
 
-	wbflush();
+	iob();
 }
 
 void cp_from_buf(void *to, unsigned char *from, int len)
@@ -514,7 +514,7 @@ static void lance_init_ring(struct net_d
 		if (i < 3 && ZERO)
 			printk("%d: 0x%8.8x(0x%8.8x)\n", i, leptr, (int) lp->rx_buf_ptr_cpu[i]);
 	}
-	wbflush();
+	iob();
 }
 
 static int init_restart_lance(struct lance_private *lp)
@@ -1084,7 +1084,7 @@ static int __init dec_lance_init(struct 
 		lp->dma_ptr_reg = (unsigned long *) (system_base + IOCTL + LANCE_DMA_P);
 		*(lp->dma_ptr_reg) = PHYSADDR(dev->mem_start) << 3;
 		*(unsigned long *) (system_base + IOCTL + SSR) |= (1 << 16);
-		wbflush();
+		fast_iob();
 
 		break;
 	case PMAD_LANCE:
diff -up --recursive --new-file linux-mips-2.4.18-20020323.macro/drivers/scsi/NCR53C9x.h linux-mips-2.4.18-20020323/drivers/scsi/NCR53C9x.h
--- linux-mips-2.4.18-20020323.macro/drivers/scsi/NCR53C9x.h	Fri Oct 19 04:29:11 2001
+++ linux-mips-2.4.18-20020323/drivers/scsi/NCR53C9x.h	Mon Feb  4 01:14:34 2002
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
diff -up --recursive --new-file linux-mips-2.4.18-20020323.macro/drivers/scsi/dec_esp.c linux-mips-2.4.18-20020323/drivers/scsi/dec_esp.c
--- linux-mips-2.4.18-20020323.macro/drivers/scsi/dec_esp.c	Tue Jan 22 03:06:51 2002
+++ linux-mips-2.4.18-20020323/drivers/scsi/dec_esp.c	Mon Feb  4 01:15:48 2002
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
diff -up --recursive --new-file linux-mips-2.4.18-20020323.macro/drivers/tc/zs.c linux-mips-2.4.18-20020323/drivers/tc/zs.c
--- linux-mips-2.4.18-20020323.macro/drivers/tc/zs.c	Sun Mar 24 21:02:44 2002
+++ linux-mips-2.4.18-20020323/drivers/tc/zs.c	Sun Mar 24 21:16:14 2002
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
 
