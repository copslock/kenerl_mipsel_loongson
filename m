Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Apr 2004 22:26:46 +0100 (BST)
Received: from [IPv6:::ffff:217.157.140.228] ([IPv6:::ffff:217.157.140.228]:6996
	"EHLO brian.localnet") by linux-mips.org with ESMTP
	id <S8225742AbUDNV0o>; Wed, 14 Apr 2004 22:26:44 +0100
Received: from brm by brian.localnet with local (Exim 3.36 #1 (Debian))
	id 1BDru0-0000aY-00; Wed, 14 Apr 2004 23:26:36 +0200
To: ralf@linux-mips.org
Subject: [PATCH 2.5] LASAT ndelay changes
Cc: linux-mips@linux-mips.org
Message-Id: <E1BDru0-0000aY-00@brian.localnet>
From: Brian Murphy <brm@murphy.dk>
Date: Wed, 14 Apr 2004 23:26:36 +0200
Return-Path: <brm@murphy.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4783
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brm@murphy.dk
Precedence: bulk
X-list: linux-mips

Hi Ralf,
	this brings back lasat_ndelay which is necessary because the eeprom
containing information about memory sizes (among other things) needs ndelay
very early on, before it is calibrated. You removed this code in a cleanup
round a long time ago but it really is necessary for the system to work.
The rtc also uses a bit-banging interface and is read before ndelay is
calibrated (using the rtc).

Initcalls now have a return code.

There was an unused variable left after a cleanup.

Please apply when you have time. I will come and poke you some day
soon if you don't ;).

/Brian

Index: arch/mips/lasat/at93c.c
===================================================================
RCS file: /cvs/linux/arch/mips/lasat/at93c.c,v
retrieving revision 1.2
diff -u -r1.2 at93c.c
--- arch/mips/lasat/at93c.c	25 Feb 2003 22:39:02 -0000	1.2
+++ arch/mips/lasat/at93c.c	14 Apr 2004 18:49:04 -0000
@@ -41,9 +41,9 @@
 static void at93c_cycle_clk(u32 data)
 {
 	at93c_reg_write(data | at93c->clk);
-	ndelay(250);
+	lasat_ndelay(250);
 	at93c_reg_write(data & ~at93c->clk);
-	ndelay(250);
+	lasat_ndelay(250);
 }
 
 static void at93c_write_databit(u8 bit)
@@ -55,7 +55,7 @@
 		data &= ~(1 << at93c->wdata_shift);
 
 	at93c_reg_write(data);
-	ndelay(100);
+	lasat_ndelay(100);
 	at93c_cycle_clk(data);
 }
 
@@ -95,13 +95,13 @@
 static void at93c_init_op(void)
 {
 	at93c_reg_write((at93c_reg_read() | at93c->cs) & ~at93c->clk & ~(1 << at93c->rdata_shift));
-	ndelay(50);
+	lasat_ndelay(50);
 }
 
 static void at93c_end_op(void)
 {
 	at93c_reg_write(at93c_reg_read() & ~at93c->cs);
-	ndelay(250);
+	lasat_ndelay(250);
 }
 
 static void at93c_wait(void) 
Index: arch/mips/lasat/ds1603.c
===================================================================
RCS file: /cvs/linux/arch/mips/lasat/ds1603.c,v
retrieving revision 1.3
diff -u -r1.3 ds1603.c
--- arch/mips/lasat/ds1603.c	25 Feb 2003 22:39:02 -0000	1.3
+++ arch/mips/lasat/ds1603.c	14 Apr 2004 19:05:57 -0000
@@ -51,14 +51,14 @@
 {
 	data |= ds1603->clk;
 	rtc_reg_write(data);
-	ndelay(250);
+	lasat_ndelay(250);
 	if (ds1603->data_reversed)
 		data &= ~ds1603->data;
 	else
 		data |= ds1603->data;
 	data &= ~ds1603->clk;
 	rtc_reg_write(data);
-	ndelay(250 + ds1603->huge_delay);
+	lasat_ndelay(250 + ds1603->huge_delay);
 }
 
 static void rtc_write_databit(unsigned int bit)
@@ -72,7 +72,7 @@
 		data &= ~ds1603->data;
 
 	rtc_reg_write(data);
-	ndelay(50 + ds1603->huge_delay);
+	lasat_ndelay(50 + ds1603->huge_delay);
 	rtc_cycle_clock(data);
 }
 
@@ -125,13 +125,13 @@
 
 	rtc_reg_write(rtc_reg_read() & ~ds1603->clk);
 
-	ndelay(50);
+	lasat_ndelay(50);
 }
 
 static void rtc_end_op(void)
 {
 	rtc_nrst_low();
-	ndelay(1000);
+	lasat_ndelay(1000);
 }
 
 /* interface */
Index: arch/mips/lasat/interrupt.c
===================================================================
RCS file: /cvs/linux/arch/mips/lasat/interrupt.c,v
retrieving revision 1.10
diff -u -r1.10 interrupt.c
--- arch/mips/lasat/interrupt.c	13 Apr 2004 22:07:45 -0000	1.10
+++ arch/mips/lasat/interrupt.c	13 Apr 2004 22:35:54 -0000
@@ -112,7 +112,6 @@
 
 void lasat_hw0_irqdispatch(struct pt_regs *regs)
 {
-	struct irqaction *action;
 	unsigned long int_status;
 	int irq;
 
Index: arch/mips/lasat/prom.c
===================================================================
RCS file: /cvs/linux/arch/mips/lasat/prom.c,v
retrieving revision 1.9
diff -u -r1.9 prom.c
--- arch/mips/lasat/prom.c	28 Jan 2004 22:16:39 -0000	1.9
+++ arch/mips/lasat/prom.c	14 Apr 2004 19:00:10 -0000
@@ -46,6 +46,8 @@
 		null_prom_display;
 void (* prom_monitor)(void) = null_prom_monitor;
 
+unsigned int lasat_ndelay_divider;
+
 #define PROM_PRINTFBUF_SIZE 256
 static char prom_printfbuf[PROM_PRINTFBUF_SIZE];
 
@@ -98,10 +100,15 @@
 
 	setup_prom_vectors();
 
-	if (current_cpu_data.cputype == CPU_R5000)
+	if (current_cpu_data.cputype == CPU_R5000) {
+	        prom_printf("LASAT 200 board\n");
 		mips_machtype = MACH_LASAT_200;
-	else
+                lasat_ndelay_divider = LASAT_200_DIVIDER;
+        } else {
+	        prom_printf("LASAT 100 board\n");
 		mips_machtype = MACH_LASAT_100;
+                lasat_ndelay_divider = LASAT_100_DIVIDER;
+        }
 
 	at93c = &at93c_defs[mips_machtype];
 
Index: arch/mips/lasat/setup.c
===================================================================
RCS file: /cvs/linux/arch/mips/lasat/setup.c,v
retrieving revision 1.13
diff -u -r1.13 setup.c
--- arch/mips/lasat/setup.c	13 Apr 2004 22:07:45 -0000	1.13
+++ arch/mips/lasat/setup.c	13 Apr 2004 22:27:54 -0000
@@ -155,7 +155,7 @@
 }
 #endif
 
-static void __init lasat_setup(void)
+static int __init lasat_setup(void)
 {
 	int i;
 	lasat_misc  = &lasat_misc_info[mips_machtype];
@@ -185,6 +185,8 @@
 	change_c0_status(ST0_BEV,0);
 
 	prom_printf("Lasat specific initialization complete\n");
+
+        return 0;
 }
 
 early_initcall(lasat_setup);
Index: include/asm-mips/lasat/lasat.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/lasat/lasat.h,v
retrieving revision 1.4
diff -u -r1.4 lasat.h
--- include/asm-mips/lasat/lasat.h	6 Jun 2003 11:47:49 -0000	1.4
+++ include/asm-mips/lasat/lasat.h	14 Apr 2004 21:14:39 -0000
@@ -220,7 +220,22 @@
 #define N_MACHTYPES		2
 /* for calibration of delays */
 
+/* the lasat_ndelay function is necessary because it is used at an 
+ * early stage of the boot process where ndelay is not calibrated.
+ * It is used for the bit-banging rtc and eeprom drivers */
+
 #include <asm/delay.h>
+/* calculating with the slowest board with 100 MHz clock */
+#define LASAT_100_DIVIDER 20
+/* All 200's run at 250 MHz clock */
+#define LASAT_200_DIVIDER 8
+
+extern unsigned int lasat_ndelay_divider;
+
+static inline void lasat_ndelay(unsigned int ns)
+{
+            __delay(ns / lasat_ndelay_divider);
+}
 
 extern void (* prom_printf)(const char *fmt, ...);
 
