Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 Feb 2004 15:05:24 +0000 (GMT)
Received: from mo02.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:17904 "EHLO
	mo02.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225384AbUBNPFX>;
	Sat, 14 Feb 2004 15:05:23 +0000
Received: from mdo00.iij4u.or.jp (mdo00.iij4u.or.jp [210.130.0.170])
	by mo02.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id AAA13842;
	Sun, 15 Feb 2004 00:05:19 +0900 (JST)
Received: 4UMDO00 id i1EF5Jx01468; Sun, 15 Feb 2004 00:05:19 +0900 (JST)
Received: 4UMRO00 id i1EF5HC01030; Sun, 15 Feb 2004 00:05:18 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Sun, 15 Feb 2004 00:05:15 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][2.4] Changed clock function for vr41xx
Message-Id: <20040215000515.66bc8839.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4366
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hello Ralf,

I made a patch for vr41xx.
This patch changes a clock function for a power management.

This is required because of a power management.
Please apply this patch to v2.4.

Yoichi

diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/common/cmu.c linux/arch/mips/vr41xx/common/cmu.c
--- linux-orig/arch/mips/vr41xx/common/cmu.c	Tue Jan 13 08:16:58 2004
+++ linux/arch/mips/vr41xx/common/cmu.c	Wed Feb 11 00:34:15 2004
@@ -40,6 +40,7 @@
  *  - Added support for NEC VR4133.
  */
 #include <linux/init.h>
+#include <linux/spinlock.h>
 #include <linux/types.h>
 
 #include <asm/cpu.h>
@@ -66,16 +67,19 @@
  #define MSKMAC0	0x0002
  #define MSKMAC1	0x0004
 
-static u32 vr41xx_cmu_base;
-static u16 cmuclkmsk, cmuclkmsk2;
+static uint32_t cmu_base;
+static uint16_t cmuclkmsk, cmuclkmsk2;
+static spinlock_t cmu_lock;
 
-#define read_cmuclkmsk()	readw(vr41xx_cmu_base)
+#define read_cmuclkmsk()	readw(cmu_base)
 #define read_cmuclkmsk2()	readw(CMUCLKMSK2)
-#define write_cmuclkmsk()	writew(cmuclkmsk, vr41xx_cmu_base)
+#define write_cmuclkmsk()	writew(cmuclkmsk, cmu_base)
 #define write_cmuclkmsk2()	writew(cmuclkmsk2, CMUCLKMSK2)
 
-void vr41xx_clock_supply(unsigned int clock)
+void vr41xx_supply_clock(unsigned int clock)
 {
+	spin_lock_irq(&cmu_lock);
+
 	switch (clock) {
 	case PIU_CLOCK:
 		cmuclkmsk |= MSKPIU;
@@ -129,10 +133,14 @@
 		write_cmuclkmsk2();
 	else
 		write_cmuclkmsk();
+
+	spin_unlock_irq(&cmu_lock);
 }
 
-void vr41xx_clock_mask(unsigned int clock)
+void vr41xx_mask_clock(unsigned int clock)
 {
+	spin_lock_irq(&cmu_lock);
+
 	switch (clock) {
 	case PIU_CLOCK:
 		cmuclkmsk &= ~MSKPIU;
@@ -198,6 +206,8 @@
 		write_cmuclkmsk2();
 	else
 		write_cmuclkmsk();
+
+	spin_unlock_irq(&cmu_lock);
 }
 
 void __init vr41xx_cmu_init(void)
@@ -205,14 +215,14 @@
 	switch (current_cpu_data.cputype) {
         case CPU_VR4111:
         case CPU_VR4121:
-                vr41xx_cmu_base = CMUCLKMSK_TYPE1;
+                cmu_base = CMUCLKMSK_TYPE1;
                 break;
         case CPU_VR4122:
         case CPU_VR4131:
-                vr41xx_cmu_base = CMUCLKMSK_TYPE2;
+                cmu_base = CMUCLKMSK_TYPE2;
                 break;
         case CPU_VR4133:
-                vr41xx_cmu_base = CMUCLKMSK_TYPE2;
+                cmu_base = CMUCLKMSK_TYPE2;
 		cmuclkmsk2 = read_cmuclkmsk2();
                 break;
 	default:
@@ -221,4 +231,6 @@
         }
 
 	cmuclkmsk = read_cmuclkmsk();
+
+	spin_lock_init(&cmu_lock);
 }
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/common/ksyms.c linux/arch/mips/vr41xx/common/ksyms.c
--- linux-orig/arch/mips/vr41xx/common/ksyms.c	Thu Dec 18 00:58:12 2003
+++ linux/arch/mips/vr41xx/common/ksyms.c	Wed Feb 11 00:34:15 2004
@@ -25,6 +25,9 @@
 EXPORT_SYMBOL(vr41xx_get_vtclock_frequency);
 EXPORT_SYMBOL(vr41xx_get_tclock_frequency);
 
+EXPORT_SYMBOL(vr41xx_supply_clock);
+EXPORT_SYMBOL(vr41xx_mask_clock);
+
 EXPORT_SYMBOL(vr41xx_set_intassign);
 
 EXPORT_SYMBOL(vr41xx_set_rtclong1_cycle);
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/common/pciu.c linux/arch/mips/vr41xx/common/pciu.c
--- linux-orig/arch/mips/vr41xx/common/pciu.c	Tue Feb 10 22:33:40 2004
+++ linux/arch/mips/vr41xx/common/pciu.c	Wed Feb 11 00:34:15 2004
@@ -178,7 +178,7 @@
 	writew(0, MPCIINTREG);
 
 	/* Supply VTClock to PCIU */
-	vr41xx_clock_supply(PCIU_CLOCK);
+	vr41xx_supply_clock(PCIU_CLOCK);
 
 	/* Dummy read/write, waiting for supply of VTClock. */
 	readw(MPCIINTREG);
@@ -196,7 +196,7 @@
 		printk(KERN_INFO "Warning: PCI Clock is over 33MHz.\n");
 
 	/* Supply PCI clock by PCI bus */
-	vr41xx_clock_supply(PCI_CLOCK);
+	vr41xx_supply_clock(PCI_CLOCK);
 
 	/*
 	 * Set PCI memory & I/O space address conversion registers
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/common/serial.c linux/arch/mips/vr41xx/common/serial.c
--- linux-orig/arch/mips/vr41xx/common/serial.c	Tue Jan 13 08:16:58 2004
+++ linux/arch/mips/vr41xx/common/serial.c	Wed Feb 11 00:34:15 2004
@@ -145,7 +145,7 @@
 	if (early_serial_setup(&s) != 0)
 		printk(KERN_ERR "SIU setup failed!\n");
 
-	vr41xx_clock_supply(SIU_CLOCK);
+	vr41xx_supply_clock(SIU_CLOCK);
 
 	vr41xx_serial_ports++;
 }
@@ -171,7 +171,7 @@
 	if (early_serial_setup(&s) != 0)
 		printk(KERN_ERR "DSIU setup failed!\n");
 
-	vr41xx_clock_supply(DSIU_CLOCK);
+	vr41xx_supply_clock(DSIU_CLOCK);
 
 	writew(INTDSIU, MDSIUINTREG);
 
diff -urN -X dontdiff linux-orig/drivers/char/vr41xx_keyb.c linux/drivers/char/vr41xx_keyb.c
--- linux-orig/drivers/char/vr41xx_keyb.c	Tue Feb 10 06:21:26 2004
+++ linux/drivers/char/vr41xx_keyb.c	Wed Feb 11 00:34:15 2004
@@ -325,7 +325,7 @@
 
 	if (current_cpu_data.cputype == CPU_VR4111 ||
 	    current_cpu_data.cputype == CPU_VR4121)
-		vr41xx_clock_supply(KIU_CLOCK);
+		vr41xx_supply_clock(KIU_CLOCK);
 
 	kiu_writew(KIURST_KIURST, KIURST);
 
diff -urN -X dontdiff linux-orig/include/asm-mips/vr41xx/vr41xx.h linux/include/asm-mips/vr41xx/vr41xx.h
--- linux-orig/include/asm-mips/vr41xx/vr41xx.h	Tue Feb 10 22:33:56 2004
+++ linux/include/asm-mips/vr41xx/vr41xx.h	Wed Feb 11 00:36:44 2004
@@ -53,8 +53,6 @@
  * Clock Mask Unit
  */
 extern void vr41xx_cmu_init(void);
-extern void vr41xx_clock_supply(unsigned int clock);
-extern void vr41xx_clock_mask(unsigned int clock);
 
 enum {
 	PIU_CLOCK,
@@ -71,6 +69,9 @@
 	ETHER0_CLOCK,
 	ETHER1_CLOCK
 };
+
+extern void vr41xx_supply_clock(unsigned int clock);
+extern void vr41xx_mask_clock(unsigned int clock);
 
 /*
  * Interrupt Control Unit
